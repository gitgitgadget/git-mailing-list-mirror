Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E915BC433EF
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 10:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381601AbiFQKYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 06:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiFQKYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 06:24:36 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA0C583A9
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 03:24:33 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id c130-20020a1c3588000000b0039c6fd897b4so4119015wma.4
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 03:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject;
        bh=mMhiWbpnP+wb/IEoxkU2er4HUAkqlY29Zk8MHaeGm00=;
        b=cyoOywmTL8oPnrKAPIu3M1rCC1F9IWeSmLyKCAMI0wdm+HHhQdWQrvwlJCx9iJuPxo
         Qdfw95tSIHjs6YfnRUgJIedT5GafTlsyvaAiKczcFtR1xeAlJQFPnV3F9C+SsMaQaX8N
         sfYGQbJmn8xnJ2fd0jrYPsZ8+WYVbWDzpZiel0qpukFpQycP6tmKdfj1FbJRTO9nPwek
         VQBCUMEviuzCM6wQNKYQp6Oh38LPOwjXdy1Q8EPKrDrLoRsQxWdZG6rp1AWs4T1Ym2Wl
         utCgzJdrDXbFZp5yBh8TnyZGJ0eNpWrUpOs3RzW9qAYJ0ZbNysHhQdZDDeBXf3MDWTnG
         vbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject;
        bh=mMhiWbpnP+wb/IEoxkU2er4HUAkqlY29Zk8MHaeGm00=;
        b=NYiXS2xzY96kqM7c64Jm9O5FoQ0P6pJE+aQqBV5Q4O0xNYWVtAxQMl3vShgxH8d3H2
         svevR4ZIgrbstk9A95T4q3xj+AvKktt+H2nQEpSblujpLcKUS0ME7WLnFEe+NyJ8cYRB
         eXNNxj+6kAlPxNMVRfaEmmz9x75dPbkV9BJPTMRbAHxDYwlIgVV9kaqeJUxtzbkCLkTC
         /uOk+ekIteqgbsSNr05+9+68ZW3jb1o90Ri2gDER0mcLCnzsa1ZKqFdvXwD3H5KP92T5
         /Oa6miAMpJZ7B1LZNyDbBEILYTKsGNh/gpnUrpPGAMf6I4Ia75MXw/j0G+sUkmTUrLqs
         3XrQ==
X-Gm-Message-State: AJIora9oUtowUNcwEBoAfDVPmJywNn000pMwc7rHCpz4Hz0vdZ0UCVAA
        pSwqnDce83un13QdNE7gJcWDMsePYpE=
X-Google-Smtp-Source: AGRyM1s1wfeAxRPpYMHHr29C1alnPHyKU0DNdEb8e8WjJ0DSn25FlUCxaaLds0rxKVKmTOS9J2OyjA==
X-Received: by 2002:a1c:7713:0:b0:39e:e5c4:fe9a with SMTP id t19-20020a1c7713000000b0039ee5c4fe9amr3336828wmi.65.1655461472341;
        Fri, 17 Jun 2022 03:24:32 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id j11-20020a05600c190b00b0039c5328ad92sm10516276wmq.41.2022.06.17.03.24.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 03:24:31 -0700 (PDT)
Message-ID: <81caab7d-777e-13fe-89ea-820b7b2f0314@gmail.com>
Date:   Fri, 17 Jun 2022 12:24:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>
From:   Alejandro Colomar <alx.manpages@gmail.com>
Subject: send PGP signed commits/patches with git-send-email(1)
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------eT0cL4lAJ4PjZKeMUFuwBbDM"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------eT0cL4lAJ4PjZKeMUFuwBbDM
Content-Type: multipart/mixed; boundary="------------02ADq2fRPej3HxbRcn1TKfrB";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>
Message-ID: <81caab7d-777e-13fe-89ea-820b7b2f0314@gmail.com>
Subject: send PGP signed commits/patches with git-send-email(1)

--------------02ADq2fRPej3HxbRcn1TKfrB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCkluIEtlcm5lbCBSZWNpcGVzIHRoaXMgbW9udGggWzFdLCBHcmVnIG1lbnRpb25l
ZCB0aGF0IGdpdC1zZW5kLWVtYWlsKDEpIA0KY291bGQgYmUgdXNlZCB0b2dldGhlciB3aXRo
IGdwZygxKSB0byB2ZXJpZnkgYXV0aGVudGljaXR5IG9mIHRoZSBzZW5kZXIuDQoNCkkgY291
bGRuJ3QgZmluZCBhbnkgZG9jdW1lbnRhdGlvbiBhYm91dCBpdCwgYW5kIGlmIEkgY3JlYXRl
IGEgcGF0Y2ggZnJvbSANCmEgY29tbWl0IHRoYXQgd2FzIHNpZ25lZCAoLVMpLCB0aGUgUEdQ
IHNpZ25hdHVyZSBpcyBub3QgcGFydCBvZiB0aGUgcGF0Y2guDQoNClNvLCBpcyB0aGVyZSBh
IHdheSB0byBQR1AtYXV0aGVudGljYXRlIHBhdGNoZXM/DQpJZiBub3QsIGNvdWxkIHRoaXMg
YmUgYWRkZWQgdG8gZ2l0KDEpPw0KDQokIGdpdCAtLXZlcnNpb24NCmdpdCB2ZXJzaW9uIDIu
MzYuMQ0KDQpUaGFua3MsDQoNCkFsZXgNCg0KDQpbMV06IDxodHRwczovL3d3dy55b3V0dWJl
LmNvbS93YXRjaD92PW5oSnFhWlQ5NHowPg0KDQogICAgICAtIFN0YXJ0IG9mIHRocmVhZCBR
JkEgaW4gMTo1NjozMC4NCiAgICAgIC0gR3JlZydzIGFuc3dlciBzdGFydHMgaW4gMTo1Njo1
Nw0KICAgICAgLSBTcGVjaWZpYyBnaXQtc2VuZC1lbWFpbCgxKSBwYXJ0IGluIDE6NTc6NTAN
Cg0KLS0gDQpBbGVqYW5kcm8gQ29sb21hcg0KPGh0dHA6Ly93d3cuYWxlamFuZHJvLWNvbG9t
YXIuZXMvPg0K

--------------02ADq2fRPej3HxbRcn1TKfrB--

--------------eT0cL4lAJ4PjZKeMUFuwBbDM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmKsVlUACgkQnowa+77/
2zLpeg/9HNZKpH2zWdkpFnH1EKanjDWkDKJx69bDIDfuc8b+Rrshd21cg7cx4m17
/62aZPkgeMrrT4j6A+OzQWrdv1amM2NTKvsBrv9jY7RDiM5RJuBngr4D0ZgGluq8
6tlLIEY2RGwMjL4MRh9dl5VbbpCmzFR25WIJwXscRCjoQns/aofz5+w2dHF8BP4m
5u24mTJZ0OOghsCtwBiknQIux+M0hOY7zOZGAIxg7lZdIbqFVHTTWxiG35MqqBYL
TDmbIQuspFK3v+GpgaknytKhHv5/1dfuUVB8D8TMNieafNI3ONVmnuYnljHbXAv6
nQ0CgT4HSftTW8uPOPpi0aYIl2S3kL2bzeXCFlcsfko04BOWEyIqj0T+aRjGBcnN
7shIxdRB9h0W9l11leI6C6ghdVbKJZ40tT24dl1ghBciDiR0EPBtLO3LpMgTPTO2
IEVhfIgYrGkhBhK0RIg+BNzurTx+uVodBVJGVrPGKn5q+BQMwuH54tMo4aKuOzca
jiyyMBtuSI6LeBPnDT29aSR+C24PU2Sk3KeBdjOMZ43n3DTha5ANOw8Xtr+deYse
bBjMYOVo7UzmNQBY9dO6sV9FM3fma4VV5koSuKGqfMmwfAJOJqopxtJA/Dz6ta92
7kr3kxkfafqDUUqTgv5Mi0n16crJJmZ24lVXOCJTYtFntiJUnDA=
=srrv
-----END PGP SIGNATURE-----

--------------eT0cL4lAJ4PjZKeMUFuwBbDM--
