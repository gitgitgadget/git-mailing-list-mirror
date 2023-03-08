Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BEFC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 20:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCHUQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 15:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCHUQf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 15:16:35 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6E0D13EC
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 12:16:03 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c18so10544739wmr.3
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678306561;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7WQJHEhR9CFwRuMTB9Q+bWwernSaOZKh/ZEXRez9W2U=;
        b=IWfV8yuoOUAsjPqeUAfpxVuGgu2yLpEaNstkmd2Qah6tXXyt+U4ciUepZYC/YTNqlH
         EAs9n4jNTtGPWIrWNTVN/meg+SNZyng3qCG0ol1WOh8fUEBV2SlQuL6lo1z4YIK/W3uv
         +DDSa/Oh1IWR2KGmhS5sv+8pl2bhLxWMKrR0PyF9cUodMUsbJEEN7wxhdcmjhCd9QhtF
         fJZyOzJ58d0bgZOnAyQQlmi0sMXo8S3DHHdQjKlRDW3StZxbvk+KywA94tFDixFLN4OQ
         eaYeG9yGdJCR0uMa5AsBfKmxpHemg6rarhXkF2Kbt9o4pTJ1c+mklXbQVm4FNvm4970y
         eR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678306561;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WQJHEhR9CFwRuMTB9Q+bWwernSaOZKh/ZEXRez9W2U=;
        b=4M9bzzPTHKzx96KavtKcDLjdpvP3I5o0NQCv4RM0gKN/yjhkcApszMXJMzlSKz9c4Y
         QTNHW4TiUjYy3uSvPmI6HuXC1hxwsmCcnJQG4NnoiC6nBCM6tATEKCZzXX+m/mPNhMMn
         7IeCT4h+JWDzYyVenZqdYiP+lXUViGbWsDVgSJUo1nAzl1KA41bz8uI1ZJeqmbjounxI
         BCjN+b5ERFoi//G6b4ny6AzBc+PVGZDsnpGyarbE0KPJH2bJQ8c2+zemad9FunXNJfby
         YmPBiWAiWA0bywiI+7XdPNAmRqlf7qhh7nvKfTTqoa5VEbr4iECFqDc+M+oRMt2u8swY
         kDgg==
X-Gm-Message-State: AO0yUKWxGnWlj7EQB5/2Y0wc6LlkAFVws8ROJHecFXgz0CzPVyKthc1G
        fb+DyaSMr2JkgDCxI/qbHmDWfe7f/uY=
X-Google-Smtp-Source: AK7set80bBPRWF04/jetOb2YqZV1qTqn85QaXtfzSN2/kbiae1WDdgtulYRLx7Slmq/aeIWomor+hA==
X-Received: by 2002:a05:600c:4746:b0:3eb:36fa:b791 with SMTP id w6-20020a05600c474600b003eb36fab791mr17109939wmo.31.1678306561652;
        Wed, 08 Mar 2023 12:16:01 -0800 (PST)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600c474900b003df7b40f99fsm469773wmo.11.2023.03.08.12.16.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 12:16:01 -0800 (PST)
Message-ID: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
Date:   Wed, 8 Mar 2023 21:15:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Alejandro Colomar <alx.manpages@gmail.com>
Subject: Better suggestions when git-am(1) fails
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------FbRZpQdaznVG5DvJBDZuJggG"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------FbRZpQdaznVG5DvJBDZuJggG
Content-Type: multipart/mixed; boundary="------------wm8S6cFfUkYNhBdE6z16zOxi";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Message-ID: <897c200c-afb3-ceb4-bf44-9af651f5feb4@gmail.com>
Subject: Better suggestions when git-am(1) fails

--------------wm8S6cFfUkYNhBdE6z16zOxi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I had the following error already a few times, when some contributors,
for some reason unknown to me, remove the leading path components from
the patch.  Now I know that the fix is to use -p0, but the first times
it wasn't obvious.  And still I forget about -p0 sometimes and it's
hard to find in the manual pages.  I think it would be good to suggest
using it when such an error appears.


$ git am -s patches/\[PATCH\ 1_2\]\ CONTRIBUTING\:\ Fix\ typo\,\ there\ i=
s\ one\ active\ maintainer\ -\ Rodrigo\ Campos\ \<rodrigo@sdfg.com.ar\>\ =
-\ 2023-03-08\ 1622.eml
Applying: CONTRIBUTING: Fix typo, there is one active maintainer
error: git diff header lacks filename information when removing 1 leading=
 pathname component (line 9)
Patch failed at 0001 CONTRIBUTING: Fix typo, there is one active maintain=
er
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
alx@asus5775:~/src/linux/man-pages/man-pages/main$ man git-am
alx@asus5775:~/src/linux/man-pages/man-pages/main$ git am --show-current-=
patch=3Ddiff
---
 CONTRIBUTING | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git CONTRIBUTING CONTRIBUTING
index 3b4408108..3bb671eca 100644
--- CONTRIBUTING
+++ CONTRIBUTING
@@ -8,7 +8,7 @@ Description
    Mailing list
        The main discussions regarding development of the project, patche=
s,
        bugs, news, doubts, etc. happen on the mailing list.  To send an =
email
-       to the project, send it to both maintainers and CC the mailing li=
st:
+       to the project, send it to Alejandro and CC the mailing list:
=20
            To: Alejandro Colomar <alx@kernel.org>
            Cc: <linux-man@vger.kernel.org>
--=20
2.39.2


git(1) could recommend using `-p` to sort this out.  It could go
further and check which level would be needed for the patch to apply,
but at the very least it could tell the user which option it wants
to look for in the documentation.

Does this make sense to you?  I usually find git-am error messages
quite uninformative.


Cheers,

Alex


--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------wm8S6cFfUkYNhBdE6z16zOxi--

--------------FbRZpQdaznVG5DvJBDZuJggG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQI7PkACgkQnowa+77/
2zKNJQ/+MvtIOwa2n95ZLnMx5/0A/PfvkZpA+MU9N3GPPoz0s8smU6Y8iufXE3Q3
9W51aGigzzDN1bKmdjF2C4nHsHrW2GGPQ8+n2bUWXWJvWiN+2FEjnjnNFe8AUI4p
pXQrn45lXr7vNEFy/BOHFXiDIv0ZNxc4UZ4AhF+28tCyf1agKbmJ7Sf6aH4rX0xE
4ZZVrqvi0DU1cN8a/rgSjbS+PwG1/ufkep1iTA4v0mKNIIEMmO4DuqjFqdC+xXdb
COZ+BtYI0kTvohtnHmIN3aY6SRGAzb87RR2RP3Dz7W6IsTrDzAt5GKvjhPdc/1vZ
ogmiC6JJ/1NKRNZLrQ981VcP+Ht2dYp6YJQle0Tfo+eFt01Jc3mhG05RQ2DphPJ2
RurHmNDFK0/mePOCEDF3Zy42qQH8U2CxBqvRmzNl+kG+h5ZIMxfqABalVDA7KD+M
OkAQq4peAP9nbrLQcsmVThplWcRi0lv2HzumHYICh9n/3h8ORW36nw9AeD9qwen+
52X4yiuphl8UaDfzV5usKUB6pwV/Bo19rmSd95mTsagsQbXQZ7IcJWs+FEhEADKZ
o5K3Gm92Ye5nYQ9kkcqDW4ll2Qj2G4VbNNlQNLtjU6oZZ10lqZPvPiw924vkcAJu
jOAYxrFoNsyPVQEPySkWV6zpbwtVOUpakq9Y7aBCP9OF2LCvVGU=
=q32P
-----END PGP SIGNATURE-----

--------------FbRZpQdaznVG5DvJBDZuJggG--
