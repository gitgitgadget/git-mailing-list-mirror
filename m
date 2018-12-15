Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F1871F405
	for <e@80x24.org>; Sat, 15 Dec 2018 07:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeLOHOd (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Dec 2018 02:14:33 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:43482 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbeLOHOd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Dec 2018 02:14:33 -0500
Received: by mail-wr1-f52.google.com with SMTP id r10so7406523wrs.10
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 23:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version;
        bh=em5Dli0RDwFRmbDwmpI15dexqpJkCenyBs0nYwaRv9w=;
        b=Qh4jPAvEVrFbaOjxEPijaWjH1JdjKbtH5f1AEyEXywXAh4vWl0HTrDKDApEalBFpSY
         VMTlcDcDEjhaQSgSnnYT6iEhLEr/uyR9eXhKDzElRXLgNpyKaxav1EC6jlMSE0KM5ADZ
         AvGALtTnHSqGls+QPwvp6B1qEuxxBRQkw7ScHF/Vjs9lt9VmVXEvD25OlInkRjoEzsTB
         zU7Pa7rXADzNKSxmX53xTQg+0rZLHrwPXh5pVkUZv6lsAj7BBZey4jAsBWLjMWg0aMUi
         9SUpayzybcUsraiQEGPtdKxwx1hOPCZG3pBR5ZSPWi71S1obWcMqKS7lWk2e+N2v72s0
         NoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version;
        bh=em5Dli0RDwFRmbDwmpI15dexqpJkCenyBs0nYwaRv9w=;
        b=fuZ351dX6OqndpM5DAQJAVBHsQO5MMKcOhoSO9RPJuFER1z2rh/GH3fiNFMPuDBvah
         nllZoW7tF+aCfw2KxMKr/JKxBM8BuPYkOwmuPPlZmbFI5KYaIKg4Gw5H1ecbepAWdw4F
         +A0+jY0IFHKK/i7SyNbLlbgn69DlBXiFxEFBqScVuyMdWINB0EUf87n+dNxgeAgDhxjD
         gjDLgIziK1jtklI54Kc2/9xhXWKm6uVSGmX3+FzEibm7+ayScIQdxbQW8i764sEMOVuZ
         mkTAvUUQFc+h30fGlMbDd52sn31QbTiYDjAO/2fUS+KTrDzyrVBD9VlWGH7hfDQIuhsp
         q2/w==
X-Gm-Message-State: AA+aEWYqOmhL/YHXhIg9ZNqytp8Z544AFtBVZC78CWTif42JurX7za/x
        10w0NM0qG1F3Uz4L2xqfGwP4FDwR
X-Google-Smtp-Source: AFSGD/VEDBum5jT+hGV5u0ZVY7c0W2uGH4OcIOa20YJv8ZwGA9x5U+p8+KkXlPquhjzQ3chHN5Gvew==
X-Received: by 2002:a5d:4512:: with SMTP id s18mr5064872wrq.182.1544858069401;
        Fri, 14 Dec 2018 23:14:29 -0800 (PST)
Received: from [192.168.1.4] (net-188-218-25-196.cust.vodafonedsl.it. [188.218.25.196])
        by smtp.gmail.com with ESMTPSA id r12sm8386734wrq.3.2018.12.14.23.14.27
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 23:14:28 -0800 (PST)
To:     git@vger.kernel.org
From:   Gennady Uraltsev <gennady.uraltsev@gmail.com>
Subject: Bug in git-remote
Openpgp: preference=signencrypt
Autocrypt: addr=gennady.uraltsev@gmail.com; keydata=
 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
Message-ID: <650b15f4-5e13-7a83-9f2e-072efc4815e4@gmail.com>
Date:   Sat, 15 Dec 2018 02:14:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GK40awNiaQQutWQkhFUmBbSJ4dKpGcFpH"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GK40awNiaQQutWQkhFUmBbSJ4dKpGcFpH
Content-Type: multipart/mixed; boundary="rNgcOpV2rb4jrdaHnoJphvlTU5MnCgYDa";
 protected-headers="v1"
From: Gennady Uraltsev <gennady.uraltsev@gmail.com>
To: git@vger.kernel.org
Message-ID: <650b15f4-5e13-7a83-9f2e-072efc4815e4@gmail.com>
Subject: Bug in git-remote

--rNgcOpV2rb4jrdaHnoJphvlTU5MnCgYDa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable

I am on git version 2.20.0

$ git remote

does not show remotes configured in named files in $GIT_DIR/remotes/

I do not think that this is the intended behavior.

In particular:

$ git init --bare test.git
Initialized empty Git repository in /home/guraltsev/admin/test/git/test.g=
it/

$ cd test.git

$ mkdir -p remotes
mkdir: created directory 'remotes'

$ echo -e "URL: /testremote.git \n Push: *:* \n Pull:
refs/heads/*:refs/remotes/testremote/* " > remotes/testremote

$ git remote

$ git remote show testremote
fatal: '/testremote.git' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.



The second to last command should show testremote as a remote.


Best,

Gennady


--rNgcOpV2rb4jrdaHnoJphvlTU5MnCgYDa--

--GK40awNiaQQutWQkhFUmBbSJ4dKpGcFpH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQQMgTpmrxMi2uL37hfeU97djTEFAlwUqfUACgkQ7hfeU97d
jTG3AQ/+KiizH30e6yFt9Xpf3NsE0AkqVcx6mxSmo64DFifdEYQOLWasYzUmuUOI
qI53xYvlOsMw7TNNPJtiqZCgYIO27mGqq3sFsjUvgGBCqWHgeUKaYhzxu2/sdlo8
/rbrLB82y3e6pUurOBNO64CCKHE3lMzUJWuJ3V9gjq6CXRqWe9WVmTL2/i9OQAex
3fikereJy+dBoo6vdOXBmbwOSIXugZVvXlKLjiPg4l0vu0DxQT3HGTQsRNviCBs1
BwuVympk7vQKm7uf2bZabgv18sW9SESDtQ9U9z6fm9FEH9FRciyNcv5fYSMfUssA
y3pVXl4QX1/cDj+PnDqo3wRdD5BUZUKZmCIh+LIFkC/reqnC1VR7Wh1S/GPaXWO3
KoNZiyK/BxOtB2FMTi2LJEZVabmBjqSGplM9R/fxmIuAMm+2TwF9zi31tT7V2L1l
UhFt+JViC2tW+n51MIlkLwCIx6vt+WQTvEiNJ1wkQujOn4wbfZb8duPxFXKHl0LT
fQVRp+0EXQqFW6DP7saratN2WKemo3NyT+hR9iX8OBM5om3fez5merpb/zbCYNE6
vYRQ46DCdp9ovHCnSqbs2pefjSa0otI/VmVvE2NkvS/K8UVqv6tTnB5+6/CN3XaX
z5O4/HLYfNvDa3+kLAg29chutiRCvHGBcSBmZBKEUkbmoR/ulgI=
=1K0F
-----END PGP SIGNATURE-----

--GK40awNiaQQutWQkhFUmBbSJ4dKpGcFpH--
