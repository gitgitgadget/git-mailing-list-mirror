Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700AD1F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 17:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfKSRKG (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 12:10:06 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:51691 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfKSRKG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 12:10:06 -0500
Received: by mail-wm1-f44.google.com with SMTP id q70so4033653wme.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 09:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:autocrypt:subject:message-id:date:user-agent:mime-version;
        bh=gnK9dWvo6E6oJLjabGEcoj2kDa81+bDU9qrIoJ//eQQ=;
        b=BEfdFyiCHXXluAT1pcEoz4oyK6MTni4V6FFDi+6nL2wGi1mELtSsAkEt1GuRAafbNg
         a843wWYQyCpx3igTX85FETIDbyWhWuWXp55kTozn5OSy2KepldnhheBKdQvtqdWhqxyw
         F4rbXAKkGKdjJ+/LpQdIy8Fv1j4ZpgaCDAi9f0Pszw0JkhTPB2euWJpNgFDxuzxfDMmh
         xtqC00QKUTduvjY1G+CnNtTtxdrSrce8cA6vehMPIsoM+TbBPSE34kO1Hc33BXWMGrHM
         rLIlJ6Vx9x/6FYUELKldqAbIN1SK3As6TsJVcOeUwQ3juXZ3an4hPm2q04nTc70FwTrZ
         QBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:autocrypt:subject:message-id:date
         :user-agent:mime-version;
        bh=gnK9dWvo6E6oJLjabGEcoj2kDa81+bDU9qrIoJ//eQQ=;
        b=uAZtUEADgWfY2N6ZHxKrQhmj5QVNxkzz3MqLbK6bsnhMT6IlZTrudlmZ7EEcSItlIw
         sMNGMpGXk3Qn0ef/UTUpGPsxgS0dStr+D3roNbmchEsSTU812QFf80RsBiaC+f1n4so/
         kf4897y93dvv5rlQxjTuOZk4/FjKfUocugNnXg5DAjMy6w7chLNxkRqtd4JHUwt0hCPe
         MamDS6H7K6lRFCjazyGgyS/ShljXike5LrU4EGTjbvzUQZFHMgQ6TmHvj+5no1MJ7SzQ
         CKk9i+7kt3ZDkkLUKd27cUjOSLFxcJ1G9A5RetkZjkIFtIG1v7hk/f+jw5NGWqTTNgHP
         LoEQ==
X-Gm-Message-State: APjAAAVfkBjT/cyU+OYuC1mXI98XFCNEYH16m+RAinA2/cArg0ugDFDO
        unj7zjyKwTHyQsv6nkoEZ14OfxAP
X-Google-Smtp-Source: APXvYqzrL9egp8KgjB8jQm+wFuUNILYSc5nCFuiikuO0BaCgvbaQ0jWhQHHnh0SIPeLXQzp6i43CvQ==
X-Received: by 2002:a7b:cc86:: with SMTP id p6mr7288806wma.116.1574183403461;
        Tue, 19 Nov 2019 09:10:03 -0800 (PST)
Received: from [129.187.109.42] (tueilnt-mo-tk1.lnt.ei.tum.de. [129.187.109.42])
        by smtp.gmail.com with ESMTPSA id 5sm3557409wmk.48.2019.11.19.09.10.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 09:10:02 -0800 (PST)
To:     git@vger.kernel.org
From:   Tasnad Kernetzky <tasnadk@gmail.com>
Autocrypt: addr=tasnadk@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFblpqIBCAC4TkkXJbIXuaGVk8HmobciF+UUKyOigeJyVq9W+TXTFdT5dDb9B7G9o3M3
 azuRLhZsWF0sB+XtIW+SuG6jRbiymFet+NYZ8M8zDU38CKg8tLRWbOhqIxEhDebVvJTL4yZ5
 FqkeNP9gx01h0yTycATO19lC/NixQkS2MgaDVUEE5VS9XYBu68sHgJrQsSm758By4WckcimY
 seyuw+a/+zElFdfFxhkmzE7YzP0io/qk6cLPiEdQqwbgyBu3zuU6O5ZLqbl4h5mhciyexwQc
 O2jNk2ISCTXtNu65AFsAru96hxG0wVmCJ5U4BNUUTQwA7H/v3okI9Xg2a/oHD/2d647fABEB
 AAG0JFRhc25hZCBLZXJuZXR6a3kgPHRhc25hZGtAZ21haWwuY29tPokBNwQTAQgAIQIbAwUL
 CQgHAgYVCAkKCwIEFgIDAQIeAQIXgAUCVuWqKAAKCRANFbbGxqZtJkdhB/4l39UFmfZ1M9bW
 hNcm4/mIT+4psqTezkzvxUUmdTsnSBiF4fDzDsfB/4OhEEMJQ01Rufcg4LIsemd+i80viTtp
 NoLFI9kBc5GSlaCSdx/m99w/0gYhsWXx8jYBGyrLrxD66ZrZ7OBSjLTP5zVjASsEqG0pqGZr
 VO1jdJGxLJDSUdh9pwrWKGJ1R9yn5XVSSA9K7Gjp6v0J6g2lnO8j4BBFLIjjQWekhMlrgdp1
 mbZqoDYpTS/mLDKkcj+8xjKLm9jBrDwa/zZ/6rUDztyXnPY7WsXc1RsSQXpmGk6Wk+QP0jMH
 dAFHLfvoX/ulLHOVZps8Jbd01v/PdEgemWj4pjLVuQENBFblpqIBCADO5fKPowDcuYcAcF6f
 bmeUWE3MmywB7BasGk9JDCll9U9FcVskRwHwEauFUpHP07fyj7A55SF1wWbDIzvM5WHRUoci
 +HuWvXbldAdI0/NYv6dKZVaPnnRJUfkzZ4+P/t/BL45RrFY+b5Vf8S/H42FHahDbm20hbJYa
 3qCyxkRr1Uxw4EzOKUqGb/z2E8NPapdwj68vemJSVaEE71OBBu56soQz8sQ1ru/XkKcp9SOg
 oOlAtQlE+G+aNplirIG3QPGd8LJQlwreKx00dAF903f7dJ2/Xr5VeR/we7aVdryG58DX/A4+
 nYS+RDPerWIPZGu1Hm/h6Y0lsXT1F20yy6yZABEBAAGJAR8EGAEIAAkCGwwFAlblrYIACgkQ
 DRW2xsambSalVwf/XweibiJpqvuKyGJO9w8T5PW8WjDYe6dE2QJiMmVrurJJ2ndHDGF3g7c0
 /89Ba/tyfWMvHzTEuPvFvs7Jg/862ATsyRemCb9VXRgsQHlEANTUhre3Cb3WAnRIT1cKZiHm
 Zk3dPxl25WQfA8tlvodo1s3mehnUQavtwp7ijWnV5pml7ADJcNZ5YFK+3bIJBckulDk0lv1P
 /s8Ak6jlaAZewUaFupp9tpLNTbhVOAXc+YM9pMXh5v6jlm1Xrlrauew2dpLNow8qj5Q/vtvp
 Ktdi0mD5VctHHrliQ2Hc3KSogP6uagbTSvsVa/4UWTcuS98oP00pOJzKxsOhPkQZJIpd5g==
Subject: [BUG] "git checkout BRANCH -- FILE" deletes staged commits
Message-ID: <5cb30154-5753-f229-9fa2-6c82d2896abc@gmail.com>
Date:   Tue, 19 Nov 2019 18:10:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kgOBKtASnq9D8OyIF1FXEZwNH4k3iYCKb"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kgOBKtASnq9D8OyIF1FXEZwNH4k3iYCKb
Content-Type: multipart/mixed; boundary="NYbtXnLu3Pswd0K1ECSSIhSPTSFIzJXQF";
 protected-headers="v1"
From: Tasnad Kernetzky <tasnadk@gmail.com>
To: git@vger.kernel.org
Message-ID: <5cb30154-5753-f229-9fa2-6c82d2896abc@gmail.com>
Subject: [BUG] "git checkout BRANCH -- FILE" deletes staged commits

--NYbtXnLu3Pswd0K1ECSSIhSPTSFIzJXQF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US-large

Hi,

I suppose I found a bug in git version 2.24.0. Please consider the small
shell script to reproduce.

Best,

Tasnad


#!/bin/bash
# init repo, create master branch
git init
echo 'master' > tst
git add tst
git ci -m 'master'

# create branch "B" where tst contains the line from master plus a line "=
B"
git checkout -b B
echo 'B' >> tst
git commit -am 'B'

# back in master: stage a change
git checkout master
echo 'master_dirty' >> tst
git add tst
echo '*** tst should contain [master, master_dirty]: ***'
cat tst
echo '-------------'

# checkout copies over contents from B -> I guess the bug is here,
changes are not detected
git checkout B -- tst
git status
echo '-> this seems to be wrong, change is not detected'

# if we now go to B and back to master, we loose staged changes
echo '*** tst should contain [master, B]: ***'
cat tst
echo '-------------'
git checkout B
echo '*** tst should contain [master, B]: ***'
cat tst
echo '-------------'
git checkout master
echo '*** tst should contain [master, B]: ***'
cat tst
echo '-------------'
echo '-> wrong / staged changes lost!?'



--NYbtXnLu3Pswd0K1ECSSIhSPTSFIzJXQF--

--kgOBKtASnq9D8OyIF1FXEZwNH4k3iYCKb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEu6VccBfZfXwfvGDzDRW2xsambSYFAl3UIekACgkQDRW2xsam
bSY3fwf+IadO729hCqtr9wlT6cY4co6XyPf+Tha4jOqRqRYeatUS+fgpPW6p9AlI
ZRh5zAS+IXQ+XXk6f+dgeWOlqCNo1pr377YnA4jtPYrVQYBuMso5ks/lDDLUmDUB
toNAleS0ILYYlSlR8udAHgc1POBI37/xBfSIzuwLEK/EEY0SRuD4RYrrDRSEUx88
AOTvUlZ1xspAu/2hIGbeirCCGD+WgJfMWr2ccpMa+7EKQAMlAQ3wiihuR6F/jQJ3
uPDAELeJVdvDiloeuJCV/mhAucR5pxJa5wODK4pJtupEp5H7zMLlHDRDhHj9MQeJ
d0qCsq29QZUULcnrCYgQph/mrKehiQ==
=0Tl6
-----END PGP SIGNATURE-----

--kgOBKtASnq9D8OyIF1FXEZwNH4k3iYCKb--
