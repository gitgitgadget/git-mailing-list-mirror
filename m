Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1EEB1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 17:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754423AbdEIRkE (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 13:40:04 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36821 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753366AbdEIRkD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 13:40:03 -0400
Received: by mail-wr0-f194.google.com with SMTP id v42so1921410wrc.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n9Hiq0fCMtTPlni7HFWKR2FNrdourjcHOVmhzcqxO+M=;
        b=trhyFtzwt8MPBp6COx+o1Oh+5TaT6C4kf/WJoO8kDp/a0eOHd73AUGCKZONJ4dO3rT
         Z3hijpQC4xd1QdnsX2hSJfOzdsrSbBsejlmdBLjxJOU8e8yQ+2b9QoGmiD9vLBh6apl4
         4Lz3V89MOxNj5WdEdwA3uc/oUpIdBNvDaGDWZAC3KWPHZioFOH+7pM4WwYdwbZomMqqO
         ictD5ZFyZgq4RKFF1ubL6Yq/ChknRV/sNza9GCKQIl0zr8J/HRsAQ4aD2NjUd4ZdhnIr
         Uc6g29ZBJrZJ10bZNRY/cv+IQzvTI16UrCxP2VjO21nh1ASgHkW6jc116AtN8lPADbnV
         cEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=n9Hiq0fCMtTPlni7HFWKR2FNrdourjcHOVmhzcqxO+M=;
        b=U38JPC1zruqPnbNJXkBihRw7Soyq69uELQvXCBCJrOSkvNtNJHKu8/rt61AF9Hpy93
         HLHRJyI/wDcHYph0UbzhU1zV0kBc9pEpe5MtVqMFDlDRgsdAKll/LYk3jhUZ8yxg31ql
         zXTaGVL8mmwSVY2TGCLGKZj3xLywDyL1ltQhcL599wHE4V3BJ7FIzglrhntU9N8U1nuL
         LuRPMSKziQpPNR7T6l8xQAIGJ8dhtrj26m+9ymUocCVbVFor24uUD3Y9kTem8bBd+MJp
         ZoshKOFQHDEO71MK+ted8WpO5RXWhAz3sterGJUPcqcJ24zaaCauYo8dCmq3eOanRUuE
         1U+w==
X-Gm-Message-State: AODbwcCx9iU7Gck9fM47uOXUluWVM1E7kbELZnFNu/nbQGYXSfxbTn/X
        WfLpm5AK7liDazhkgNU=
X-Received: by 10.28.184.207 with SMTP id i198mr842419wmf.104.1494351602467;
        Tue, 09 May 2017 10:40:02 -0700 (PDT)
Received: from [10.207.198.252] (host86-187-76-40.range86-187.btcentralplus.com. [86.187.76.40])
        by smtp.gmail.com with ESMTPSA id n49sm624749wrn.30.2017.05.09.10.40.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 10:40:01 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2] travis-ci: retry if Git for Windows CI returns HTTP error 502 or 503
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqpofi35ik.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 9 May 2017 18:40:01 +0100
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: quoted-printable
Message-Id: <1ADD08FD-1DC0-4AC5-9E69-AC1A5DCBED83@gmail.com>
References: <20170503215015.17949-1-larsxschneider@gmail.com> <xmqqpofi35ik.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 May 2017, at 07:31, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Lars Schneider <larsxschneider@gmail.com> writes:
>=20
>> The Git for Windows CI web app sometimes returns HTTP errors of
>> "502 bad gateway" or "503 service unavailable" [1]. We also need to
>> check the HTTP content because the GfW web app seems to pass through
>> (error) results from other Azure calls with HTTP code 200.
>> Wait a little and retry the request if this happens.
>>=20
>> [1] =
https://docs.microsoft.com/en-in/azure/app-service-web/app-service-web-tro=
ubleshoot-http-502-http-503
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>=20
>> Hi Junio,
>>=20
>> I can't really test this as my TravisCI account does not have the
>> extended timeout and I am unable to reproduce the error.
>>=20
>> It would be great if we could test this is a little bit in pu.
>=20
> This has been in 'pu' for a while. =20
>=20
> As the patch simply discards 502 (and others), it is unclear if the
> failing test on 'next' is now gone, or the attempt to run 'pu'
> happened to be lucky not to get one, from the output we can see in
> https://travis-ci.org/git/git/jobs/229867212
>=20
> Are you comfortable enough to move this forward?

Yes, please move it forward. I haven't seen a "502 - Web server=20
received an invalid response" on pu for a while. That means the
patch should work as expected.


Unrelated to this patch I have, however, seen two kinds of timeouts:

(1) Timeout in the "notStarted" state. This job eventually finished
with a failure but it did start only *after* 3h:
https://travis-ci.org/git/git/jobs/230225611

(2) Timeout in the "in progress" state. This job eventually finished
successfully but it took longer than 3h:
https://travis-ci.org/git/git/jobs/229867248

Right now the timeout generates potential false negative results.=20
I would like to change that and respond with a successful build=20
*before* we approach the 3h timeout. This means we could generate
false positives. Although this is not ideal, I think that is the better=20=

compromise as a failing Windows build would usually fail quickly=20
(e.g. in the compile step).

What do you guys think? Would you be OK with that reasoning?
If the Git for Windows builds get more stable over time then
we could reevaluate this compromise.


- Lars=
