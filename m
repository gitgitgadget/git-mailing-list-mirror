Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74AA91F859
	for <e@80x24.org>; Wed,  7 Sep 2016 13:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754667AbcIGNUd (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 09:20:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34040 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbcIGNUc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 09:20:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id w12so2980843wmf.1
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vx1oMNUAaofIYtS5AuBmSdCvLZ7Z8kIxhciBci3k8pA=;
        b=fg201qQVK+/Z3XK3Q03VMdgSfniJlG/7d6x8VXTkz/KN2UW8tpahaUIHpCnOalTt9B
         q1zSmElRtsnYttMWq1fCfQ/X2MBqqdrTU2w8OGQdJOFUBAZ9VRTq9q+6YRHhlC/N+mRk
         9CRa2dNDS5vp6nn7EFkQcaTnR97EqQrIPG9LAzPnNf2yZD+H4EfltIA8O8NuFWnqH0lW
         6lGC1EsSVtU6pewl7MxoGBm+/XxH4rJPkcjylsXSlBrC5AHme2jeV+Cvd51cA3kIOiJb
         z4vDpmrjWUI5c8Yn9q/dWfMfKoNSPmH3fN9aLpg0A1b6af8+xXDQOPhFtxPIPTzUIwrz
         oKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vx1oMNUAaofIYtS5AuBmSdCvLZ7Z8kIxhciBci3k8pA=;
        b=aQLu5BzKNnKhewl+4looUzIxDm8+LmPLAeHFaZuGtlbSMbMUeFcAUSQXBrrxyWokrE
         gKUXP58Fr4RboJzfIkSGxa7TgLqvspqq9L8JZSA42GsD8+BqbqCZYpkv3Apj0/uWan5X
         v8ZxtpbfNTid7QJQtpvxeNCSQ1p9MKaAcojjPE68Z7NwKXI6Moi79qgDpDR0OZt26k60
         uGqd6ITOtNb8leADdue1R6YcUK9Gpng0YcYzER3TnJunpTzzDvRZ9B0VFbkQg02Ebf6v
         u67Obcm16i9AG6rGoLNPNCOpmwg8Xgqn9BWndorcN/vImLIza+KFiXgjiLP9yc7K2bWD
         iW4Q==
X-Gm-Message-State: AE9vXwPwVLWsvpHkjMZd1LOb4dB/RPqIaEV2x0ThfsAe1PScChqMgNGb7NmarAVNwDNvDg==
X-Received: by 10.194.189.229 with SMTP id gl5mr40377394wjc.168.1473254430607;
        Wed, 07 Sep 2016 06:20:30 -0700 (PDT)
Received: from [10.32.250.72] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 188sm4304850wmo.4.2016.09.07.06.20.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 06:20:29 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 1/2] sha1_file: open window into packfiles with CLOEXEC
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <alpine.DEB.2.20.1609061333030.129229@virtualbox>
Date:   Wed, 7 Sep 2016 15:20:28 +0200
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org, gitster@pobox.com,
        tboegi@web.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8E7B7CE-1177-4CBD-999E-21C593A8ACD2@gmail.com>
References: <20160905211111.72956-1-larsxschneider@gmail.com> <20160905211111.72956-2-larsxschneider@gmail.com> <20160905222715.GA30031@starla> <alpine.DEB.2.20.1609061333030.129229@virtualbox>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 06 Sep 2016, at 13:38, Johannes Schindelin =
<johannes.schindelin@gmx.de> wrote:
>=20
> Hi Eric & Lars,
>=20
> On Mon, 5 Sep 2016, Eric Wong wrote:
>=20
>> larsxschneider@gmail.com wrote:
>>> All processes that the Git main process spawns inherit the open file
>>> descriptors of the main process. These leaked file descriptors can
>>> cause problems.
>>=20
>>=20
>>> -int git_open_noatime(const char *name)
>>> +int git_open_noatime_cloexec(const char *name)
>>> {
>>> -	static int sha1_file_open_flag =3D O_NOATIME;
>>> +	static int sha1_file_open_flag =3D O_NOATIME | O_CLOEXEC;
>>>=20
>>> 	for (;;) {
>>> 		int fd;
>=20
>> I question the need for the "_cloexec" suffixing in the
>> function name since the old function is going away entirely.
>=20
> Me, too. While it is correct, it makes things harder to read, so it =
may
> even cause more harm than it does good.

What name would you suggest? Leaving the name as-is seems misleading to =
me.
Maybe just "git_open()" ?


>> I prefer all FD-creating functions set cloexec by default
>> for FD > 2 to avoid inadvertantly leaking FDs.  So we
>> ought to use pipe2, accept4, socket(..., SOCK_CLOEXEC), etc...
>> and fallback to the racy+slower F_SETFD when not available.
>=20
> In the original Pull Request where the change was contributed to Git =
for
> Windows, this was tested (actually, the code did not see whether fd > =
2,
> but simply assumed that all newly opened file descriptors would be > 2
> anyway), and it failed:
>=20
> https://github.com/git-for-windows/git/pull/755#issuecomment-220247972
>=20
> So it appears that we would have to exclude at least the code path to =
`git
> upload-pack` from that magic.


I just realized that Dscho improved his original patch in GfW with a
fallback if CLOEXEC is not present.

I applied the same mechanism here. Would that be OK?

Thanks,
Lars

-       static int sha1_file_open_flag =3D O_NOATIME;
+       static int sha1_file_open_flag =3D O_NOATIME | O_CLOEXEC;

        for (;;) {
                int fd;
@@ -1471,12 +1471,17 @@ int git_open_noatime(const char *name)
                if (fd >=3D 0)
                        return fd;

-               /* Might the failure be due to O_NOATIME? */
-               if (errno !=3D ENOENT && sha1_file_open_flag) {
-                       sha1_file_open_flag =3D 0;
+               /* Try again w/o O_CLOEXEC: the kernel might not support =
it */
+               if (O_CLOEXEC && errno =3D=3D EINVAL && =
(sha1_file_open_flag & O_CLOEXEC)) {
+                       sha1_file_open_flag &=3D ~O_CLOEXEC;
                        continue;
                }

+               /* Might the failure be due to O_NOATIME? */
+               if (errno !=3D ENOENT && (sha1_file_open_flag & =
O_NOATIME)) {
+                       sha1_file_open_flag &=3D ~O_NOATIME;
+                       continue;
+               }

