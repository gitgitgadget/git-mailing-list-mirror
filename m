Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5BAC4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 12:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJTMT2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 08:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJTMT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 08:19:27 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A04F42
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 05:19:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e18so14786017wmq.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 05:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mNvtQfZo9qau/JdavtY/9dSeYuGbIfcrBw7ghz2rogI=;
        b=k3xegvGyPEG2ph2lFHpTZB+wsvPpwuU7O1pzYQxoLI8g058sWDEzJI3UNQBwQ0Yt9s
         1lbQb2eBfD8JeMvBqhf6HZr4JdXzfPemDbSYZ0fVEaa3faNTRKW9qpn+drfHW9QHEGlT
         my5CblRCbvaGKzAS3bNYUlK7hSj+DDZcbZwyh6NkUx+j+5b+rXygBoRJrJDp7ujTS7Ac
         y0gR/2/zd8ueCgVrXjzpDjJ8QXHh/NiOH8nixNV7PL3x8bmMeOsHBb5aDtNust33XSQG
         YUz2g8vbuV5VxNrKjtWCohOYLbcrrobporu+NI0WSvYRO5c16PU1+BBdDHZM1RbLp4/l
         08Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNvtQfZo9qau/JdavtY/9dSeYuGbIfcrBw7ghz2rogI=;
        b=dNlTAg0d4qGwI6030ttfflbSZ6t3aPYfMD7SOU7ITm3zgJdxJBnKHhCGx3lVasx1LH
         zqdoAEv70tbz2rbzdPmaUF3GYvyGxRfOTr92k3oobmyHTwmqR/tFYu+Na0pVFYZ8qY/o
         EjFhJ6hhSWHdduinxlEATDoup5LPd/+UzHo9iYyY4EgXf9KfwYtpetICypOWzXwRY4BO
         nLJ4bafDVRbj9cnst5GKUzaQLsFULVUd1qhvev0xxyQIKMEgB48zHWyl9krbR1mRyHYi
         tKc8bXUs995hJojVYYrovbwcQ60XfDhNCT2coJFdDyQVOAoyGFIsyktGpSfJ+aH/SjD8
         WG3w==
X-Gm-Message-State: ACrzQf2FMRNsk24xIRDlApZLxXeW6bONC2LdMGs0bXeX8xmprXTaeecf
        YsSUNIlRq8p6wA0W7bu3odRAHwrOEuM=
X-Google-Smtp-Source: AMsMyM6blq/qNqWogGAAv7hmTmcKhmZC3JsGS58CMOHoi9u8AU2iuq5eIIJggNXUU6EKXFycFPh2HA==
X-Received: by 2002:a05:600c:46c7:b0:3c6:f3e6:1f13 with SMTP id q7-20020a05600c46c700b003c6f3e61f13mr16097997wmo.62.1666268358877;
        Thu, 20 Oct 2022 05:19:18 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id h205-20020a1c21d6000000b003b47e75b401sm2653394wmh.37.2022.10.20.05.19.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:19:18 -0700 (PDT)
Message-ID: <ce09bfae-091f-7c62-5e40-2784906d5370@gmail.com>
Date:   Thu, 20 Oct 2022 14:19:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Git <git@vger.kernel.org>
From:   Alejandro Colomar <alx.manpages@gmail.com>
Subject: diff: Add support for man(7) pages
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------IO0pmnxZ9BtvKSaqPoFUgFSD"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------IO0pmnxZ9BtvKSaqPoFUgFSD
Content-Type: multipart/mixed; boundary="------------oa9wkd6DkdRWPdk2HGEi0zeB";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Git <git@vger.kernel.org>
Message-ID: <ce09bfae-091f-7c62-5e40-2784906d5370@gmail.com>
Subject: diff: Add support for man(7) pages

--------------oa9wkd6DkdRWPdk2HGEi0zeB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkhDQoNCkkgYWRkZWQgdGhlIGZvbGxvd2luZyB0byBteSBnaXRjb25maWcgYW5kIGF0dHJp
YnV0ZXMgZmlsZXMgdG8gaW1wcm92ZSANCmRpZmZzIGluIG1hbnVhbCBwYWdlcy4gIFdvdWxk
IHlvdSBtaW5kIGFkZGluZyBzdXBwb3J0IGZvciB0aGVtIGluIGdpdCgxKT8NCg0KVGhhbmtz
LA0KDQpBbGV4DQoNClAuUy46IFRoZSBleHRlbnNpb24gSSB1c2VkIGluIHRoZSBhdHRyaWJ1
dGVzIGZpbGUgaXMgaW1wZXJmZWN0LCBzaW5jZSBhIA0KZ2xvYiB3b3VsZG4ndCBhbGxvdyBt
ZSBhcyBtdWNoIHByZWNpc3Npb24gYXMgYSByZWdleC4gIFdpdGggYSByZWdleCwgaXQgDQp3
b3VsZCBiZSB3cml0dGVuIGFzICdcLlsxLTldW1s6bG93ZXI6XV0qJCcuDQoNCg0KLS0tDQoN
CiAgICAgZ2l0OiBkaWZmICJtYW4iOiBDb3JyZWN0bHkgaW50ZXJwcmV0IG1hbig3KSBwYWdl
cy4NCg0KICAgICBTaWduZWQtb2ZmLWJ5OiBBbGVqYW5kcm8gQ29sb21hciA8YWx4QGtlcm5l
bC5vcmc+DQoNCmRpZmYgLS1naXQgYS9ob21lL3VzZXIvLmNvbmZpZy9naXQvYXR0cmlidXRl
cyANCmIvaG9tZS91c2VyLy5jb25maWcvZ2l0L2F0dHJpYnV0ZXMNCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQppbmRleCAwMDAwMDAwLi42NTI1NThmDQotLS0gL2Rldi9udWxsDQorKysgYi9o
b21lL3VzZXIvLmNvbmZpZy9naXQvYXR0cmlidXRlcw0KQEAgLTAsMCArMSBAQA0KKyouWzEt
OV0qIGRpZmY9bWFuDQpkaWZmIC0tZ2l0IGEvaG9tZS91c2VyLy5naXRjb25maWcgYi9ob21l
L3VzZXIvLmdpdGNvbmZpZw0KaW5kZXggNzJkZGM1MC4uYWRiNmNiYiAxMDA2NDQNCi0tLSBh
L2hvbWUvdXNlci8uZ2l0Y29uZmlnDQorKysgYi9ob21lL3VzZXIvLmdpdGNvbmZpZw0KQEAg
LTI3LDMgKzI3LDUgQEANCiAgICAgICAgIHNpZ25pbmdLZXkgPSBBOTM0ODU5NENFMzEyODNB
ODI2RkJERDhENTc2MzNENDQxRTI1QkI1DQogIFtkaWZmXQ0KICAgICAgICAgYWxnb3JpdGht
ID0gaGlzdG9ncmFtDQorW2RpZmYgIm1hbiJdDQorICAgICAgIHhmdW5jbmFtZSA9ICJeXFwu
U1tTSF0gLiokIg0KDQoNCg0KLS0gDQo8aHR0cDovL3d3dy5hbGVqYW5kcm8tY29sb21hci5l
cy8+DQo=

--------------oa9wkd6DkdRWPdk2HGEi0zeB--

--------------IO0pmnxZ9BtvKSaqPoFUgFSD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmNRPLsACgkQnowa+77/
2zLvFA/+NCKapAhl7fQ1QXFYdJOUR/deZPmUCYmQvFs+H675ugYGcnKNdXbuUFSP
Or020iUNZ74TGzcJmjnJVpePf2CJ8DHMuvzXyXewF4O+Nztu3l0QwT3dlZsoS/Yh
SWNnZTccFqSVh1eLhBzRn9t9Ibq6xohWqZ+40jj9JL6ajIoib/iP6pGu/0sDdIxh
/ihmZrWYhh0l75Ofa1WvH+gdpKEZ4bpcNz7PHyNM8dZHQfZ2dBcYB3d/uihhgYR/
hNY3R6o3DqMwcUlFVAZt5fsUIlsbEDWJNzlylA7nFZ+1hYZOxFrRIUxF5Lqe3Cay
UXlNFw+b628Y5lS5vCzG3ZA7uIPknA6tKt5+ifoy4/OhTf5D7XBCOeMlg1OKkCM6
1P3Y0JNaUEcA5QLpSdDqwB4M+yRjLCsStNi9Y4G77nMG4FOXyIA5W02f1dFzCZkb
jRa3SGj2Oar5YhP9cwUCiU4r+xNQxLcE5PXw9r7vXT10h0jsNaqyLuEud2yHaDeU
MZgwjULL1mwCbLeUnTPRAftQG59onVSoKM8rcL+XbPE/eAa02HkNsLhVY9PKqvUc
TILb5jkW6UCUZ1jQJ/pWOdSYTMFpV9695oPLwZ/QnKtIQvWkaMeMAwIVSoHvwOQ+
1Yb2nOiRjxYtyRXXvJ8xmHQF7fnzEIhuiwJrTGHj0v6eSywKNN4=
=Xt0L
-----END PGP SIGNATURE-----

--------------IO0pmnxZ9BtvKSaqPoFUgFSD--
