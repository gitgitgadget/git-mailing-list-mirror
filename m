Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876F41FF40
	for <e@80x24.org>; Mon,  5 Dec 2016 10:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbcLEJKr (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 04:10:47 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:33758 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbcLEJKR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 04:10:17 -0500
Received: by mail-wm0-f50.google.com with SMTP id c184so18597486wmd.0
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 01:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=51UOmWP+InlUQFcoL1KzQaJzit3+1kItrSF471oYMDo=;
        b=iXNsJx5nHqJtzGfZaaCBnb1bCd2VCPcwCgO5YAn/qFDI41Jj9+U1NR2gzN2GbrXxR1
         jvKGgo5JOwT+qFyD3oammFx1mGjptUKve4XrwB9KR0Ag6LRy0hTdpdxXVnwkxl/Im/vo
         0nFXvgm5ON4NF00EDx9ZzVvSM4rvp2XXJCvZuJ6rBiEjfgpOmz97+0qiT/CAvP2OsJUh
         bXVEmcUuh+xs4l4xog6+Cx658Cn/T45kfRWV+Ku1Q2QPr6S0YORaYtMblkC4zpixPeki
         kMHIbsSn+CJJ3YgtPIFvNIoFQ6kDxx/PZWd6ML0RDkCCQ+d2B6SZ+ioFRgZRxESpX8B7
         9U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=51UOmWP+InlUQFcoL1KzQaJzit3+1kItrSF471oYMDo=;
        b=BHEsYul4B7c8qHoBzQyqr7a3j232ffripV28ipsz4kBDQ+8FbmfW2Thc3Gwj6jKHpg
         dDE7yQgXQGbhbAY9Fvvh5UGMu4ZqrlFU9WAvIIeIOrq4y8K3lQxh9LQnjt2+WeN+1m4e
         52T/JSPWfWc2Qg+VKf5RLK0Nuec3utBPF/YGj/H9iTsKR2zYcw7SvxGhe8n73EyrnRQ5
         gcnltIqFNrg+BmyTVQVwUdSNZHjm7hVuOV0TRI62Z0x6u+pjEAdZ1UzkXZco6u8l4tT1
         uC9RE0Rzf2wyI9HgaoijZT+j5Xr0OF/6+q7eSJ+eoxluasLfpKE4Ox/J/dlJwjILomNT
         0G1w==
X-Gm-Message-State: AKaTC02gYsh22Tn4T/Fw5wSTtqa0bmZBGEg30NTmq2e9P+hh/AJ2rA010zmnDBW/cMPNcw==
X-Received: by 10.28.131.72 with SMTP id f69mr7772762wmd.135.1480928982972;
        Mon, 05 Dec 2016 01:09:42 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB56B5.dip0.t-ipconnect.de. [93.219.86.181])
        by smtp.gmail.com with ESMTPSA id i15sm19304435wjs.16.2016.12.05.01.09.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Dec 2016 01:09:42 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] git-p4: add config to retry p4 commands; retry 3 times by default
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161204140311.26269-1-larsxschneider@gmail.com>
Date:   Mon, 5 Dec 2016 10:09:48 +0100
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EFB6754A-8205-4B5C-BD2E-13D2AA211369@gmail.com>
References: <20161204140311.26269-1-larsxschneider@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Dec 2016, at 15:03, larsxschneider@gmail.com wrote:
>=20
> From: Lars Schneider <lars.schneider@autodesk.com>

Hi Junio,

if you decide to queue this patch and/or the "git-p4: fix empty file=20
processing for large file system backend GitLFS", please use my=20
signed-off address. I accidentally messed up the author field in
both.

Thanks,
Lars


>=20
> P4 commands can fail due to random network issues. P4 users can =
counter
> these issues by using a retry flag supported by all p4 commands [1].
>=20
> Add an integer Git config value `git-p4.retries` to define the number =
of
> retries for all p4 invocations. If the config is not defined then set
> the default retry count to 3.
>=20
> [1] =
https://www.perforce.com/perforce/doc.current/manuals/cmdref/global.option=
s.html
>=20
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>

