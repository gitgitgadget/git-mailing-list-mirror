Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65179C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 08:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiDMInd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 04:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiDMImq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 04:42:46 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A77C3F30F
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 01:39:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k22so1553131wrd.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 01:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=p1sec-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :autocrypt:organization:subject;
        bh=CfGOFzPzZjAwXVmJzIU3i+3CjlJ58FpV4vkkapZ6FUo=;
        b=OeeOX2XWbWdKQjCrxHpAiJ55diOQSeArbEWyCS6o68CiV5wmlg61fRhX3v1BKdFVf8
         kBpjxMLqkIfeA5vJl0EEy6TKN30FC543BL+J0LP5MM0AYZx2DWLAzHqEL3R0b/awJ4tq
         NPqk0T4qiXf3L713xq5pQlbCwv5BTV/JsN+cdwQyoEt0ZwpOTmi7ljvIp+SJjEX1P7En
         48QkT70U75y0cuTygeZTMIYoYqP0KUwGI41FBdVGGpToO20pQP3BICLwbHWFNDXSmR0y
         snEEaDnjUc+IEcQzpN8dkTKkNHmRBJ72hENTnBSWNq1vvv14TUrwP/bgXnlH59p0gYsN
         e37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:autocrypt:organization:subject;
        bh=CfGOFzPzZjAwXVmJzIU3i+3CjlJ58FpV4vkkapZ6FUo=;
        b=qjhdQCuMfcMuxnCAh9GZyZlaNUZphB8lyGU4HKN6KBkoocsIhU+bN3/1+DvKGiWdPl
         t0HHjvCNZUE/jrNK+zhW/p+R4y0VHtRxTBYU+Tq2I9INHs8gvlnx4f9oj9YMB7lGDh9A
         6er/vURmXiLxZFqgU9bqYRJIBl42hyG4nFMBxFaAI5ndoLzyuaKMw25EFGBHRePHXNoE
         JPYMc15J2DzVINhl5DHmbUoeszgedk5DVRlOkv46XWCt53+9HVCRwPk7Nz3pci1VeK8S
         lYoWshXYz2iVdp/fFcSedLtv/RXaoJNgsPiC4FkLbvqgxYoBvSpTvQUq7OnwubVLldjx
         OLGQ==
X-Gm-Message-State: AOAM530WYFF7J3N9Z4ksZwAQbeixsAOfkLwgie7P4EK7WUCKQrw4DpjI
        XlflXDTWRoMOs2TTrAFqRTx8CuOi6oaUcA==
X-Google-Smtp-Source: ABdhPJwL3gXXQnnJTmm1Mg/E+M6+GLWkwdXoSQ7dniYUWTxAYvmH5zOl1QdS7Q6AbtFJEYBg4yncwQ==
X-Received: by 2002:a05:6000:15c8:b0:207:b935:e918 with SMTP id y8-20020a05600015c800b00207b935e918mr760552wry.551.1649839176302;
        Wed, 13 Apr 2022 01:39:36 -0700 (PDT)
Received: from [172.27.32.86] (lputeaux-656-1-154-186.w217-128.abo.wanadoo.fr. [217.128.61.186])
        by smtp.gmail.com with ESMTPSA id az30-20020a05600c601e00b0038ebd950caesm1724389wmb.30.2022.04.13.01.39.35
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 01:39:35 -0700 (PDT)
Message-ID: <b6113b91-6613-42b5-ca85-1004099b65c4@p1sec.com>
Date:   Wed, 13 Apr 2022 08:39:35 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     git@vger.kernel.org
From:   Gregory David <gregory.david@p1sec.com>
Autocrypt: addr=gregory.david@p1sec.com; keydata=
 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
 v1dxvY4f2F5nhrZWkn5Rw95Qk2jIp0JB7GLzRSg=
Organization: P1 security
Subject: bugreport - SEGFAULT on 'git show-branch --current --reflog=3'
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jCMcynsjNCJl0Rl22ow0qR4z"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jCMcynsjNCJl0Rl22ow0qR4z
Content-Type: multipart/mixed; boundary="------------03ZUnvcaYJS9UjJBRLn0MT0g";
 protected-headers="v1"
From: Gregory David <gregory.david@p1sec.com>
To: git@vger.kernel.org
Message-ID: <b6113b91-6613-42b5-ca85-1004099b65c4@p1sec.com>
Subject: bugreport - SEGFAULT on 'git show-branch --current --reflog=3'

--------------03ZUnvcaYJS9UjJBRLn0MT0g
Content-Type: multipart/mixed; boundary="------------OQyJgskMkeiRD0p01ok7z6qS"

--------------OQyJgskMkeiRD0p01ok7z6qS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, this bugreport is about a SEGFAULT on git binary when running in
this repository (for example, as it also segfault on other private
repositories): https://framagit.org/groolot-association/osc_looper.git


What did you do before the bug happened? (Steps to reproduce your
issue) I just wanted to list branches, and so playing with 'git
show-branch --current --reflog=3D3' in the repository
https://framagit.org/groolot-association/osc_looper.git

What did you expect to happen? (Expected behavior)
Not to segfault

What happened instead? (Actual behavior)
This command fails with a SEGFAULT on version 2.35.1, 2.20.1 and 2.17.1
It also SEGFAULT on branch 'next' of github git repository.

What's different between what you expected and what actually happened?
Segfault

Anything else you want to add:
Segfaut happened when '--current' AND '--reflog=3D3' are provided togethe=
r

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.35.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.16.0-4-amd64 #1 SMP PREEMPT Debian 5.16.12-1 (2022-03-08)
x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.33
$SHELL (typically, interactive shell): /usr/bin/zsh


Best regards

--=20
Gregory David
Security Engineer
https://www.p1sec.com
--------------OQyJgskMkeiRD0p01ok7z6qS
Content-Type: application/pgp-keys; name="OpenPGP_0xA6DF37692E5DE2F7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA6DF37692E5DE2F7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
v1dxvY4f2F5nhrZWkn5Rw95Qk2jIp0JB7GLzRSg=3D
=3Du6yb
-----END PGP PUBLIC KEY BLOCK-----

--------------OQyJgskMkeiRD0p01ok7z6qS--

--------------03ZUnvcaYJS9UjJBRLn0MT0g--

--------------jCMcynsjNCJl0Rl22ow0qR4z
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEgTMgz/uZophfcP0Opt83aS5d4vcFAmJWjEcFAwAAAAAACgkQpt83aS5d4vdW
tAv8Dlko1fTK33WafQWagzgzUAOeQZ8ppY1LS+1lJU5i8X6gcRZh7FmfzYHMlv22MZ4j4IivnhGZ
wlgJjb13Id+pmmWf4HW5G9v7Nz3EtJz4xb9laiU20lDaZft0bl1fr8G9tJaOiyUGkaWhR4d05xhd
HMjLAjv68Ar9nW7Ax8wqFGSvfSFaGvEbumy6frWQECVmH9YtC0/oRd0juCMt8zfZA3irIPg0gq/d
gnndShXYbJI7pptx87oah8cYc+Q7PTvevBN4qWbtKXmRCtLHhqwuOkUaq/shCKz5AuIU33zWOlCl
A1fclY9Jf7d7kr1/QEAkqa+TRBSdlpTU5OxqnglU2HG6DLuWKF3DtDcFY/0RjGBlwOT9PpqOKaEq
W3VA55aFIrTeKJIX6blfkErzl+IJg2QlgTrCSwoVabqr4nieh9NwPYbv4KivA3IH/eOjb+waut0G
yHx/Z5/aNX2PCJHSHD+RjTn3Xs1sebksJdxAN7/QkjQNB24DClf7egCdExNj
=9v9D
-----END PGP SIGNATURE-----

--------------jCMcynsjNCJl0Rl22ow0qR4z--
