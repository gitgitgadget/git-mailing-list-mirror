Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A87C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 10:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiJTK6P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 06:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJTK6L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 06:58:11 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CABA52C2
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 03:58:10 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id e18so14658431wmq.3
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 03:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1gI7yV9fJo1WbysBgHk8hOIfthn1QP2rBK+n/mMLuNQ=;
        b=YHgzku6bx/t5m6k+Vx0biIL4iBu55tvl/SWE0z+su77j6EzaYGSFHRMoiwGSAUp//n
         wHNujoOuVV2TLZlCe9OC2GPx+KqSRpc8mCDBuS6LJHaM7R+frmeLAUqc8oIduzRsLN0W
         nYUXeRsEN8rO1sRyJWNOxvo4I0GOYLRjd+me8/eICqD25g64XjEqDEzF2mVH2WqLDk2D
         AadJON8YvM/9BMjaMPq/GH3eGP9vt5ZjXWNLKyhT3Vzt/1+281lk4e+WjzHnJmeq3LPN
         ZzLjTsYaOhqpxYYlVnhLGof9tfH3ABpb1beS+DYaJxHLnHbjEyYe4ln2fyhXPk6QfbnT
         aDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=subject:from:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1gI7yV9fJo1WbysBgHk8hOIfthn1QP2rBK+n/mMLuNQ=;
        b=0QZJO0SAdw04/cWOVcFlP4K3BGDldVC4M11lQ0Hmzc7PVs3W4nuWmURpuI8ZnYO0PC
         aZhZd2tsisqhXPxLv4bi3Tfc13kZG/o1SJrxKlPzZmOEnY/46MVrWmc7Nn1+jzuPI5M3
         PK+xNKYlgn22566OlVRhZYuwEbuxtIKGKuTAVL8cbbNFOA8xXtoFR53MYnZuamSP7P+i
         /gmOY2LJCutQqGUB0fNNjwvW4TCb1fU640VOe0tEWKjRrTxWcmPRSvI+aMJgN8xt1VAz
         TmFU3fJJsozNxNkcC94QOnKu7KWm9SBHAuoYpufAwFMJVLlb1RU3ujTKwbIDFS/cUBGS
         3eAQ==
X-Gm-Message-State: ACrzQf3J2UMewAASMx8sZDacsz5DUZqTIpkJzCDArLDeh8ctOhkBO110
        qV3YLO4xfFGaB3KeVsCVc0UhfZqo+0A=
X-Google-Smtp-Source: AMsMyM7Cfq8s1vz4CIRppq/ghqtq4BesbVAb1/j8Tw4LWh/jEsDp0Q0SI4+1GGapBM1yr4Us0F7RrQ==
X-Received: by 2002:a05:600c:3509:b0:3c6:fd36:ef19 with SMTP id h9-20020a05600c350900b003c6fd36ef19mr9063740wmq.191.1666263489068;
        Thu, 20 Oct 2022 03:58:09 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id j8-20020adfd208000000b00235da296623sm1409767wrh.31.2022.10.20.03.58.08
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 03:58:08 -0700 (PDT)
Message-ID: <a49c95b2-4468-e510-957a-427f9ce8763d@gmail.com>
Date:   Thu, 20 Oct 2022 12:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Git <git@vger.kernel.org>
From:   Alejandro Colomar <alx.manpages@gmail.com>
Subject: [BUG] 'make install' may overwrite existing directories
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------pDf0k5Z5Gil0lFEH0A4bnH7i"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------pDf0k5Z5Gil0lFEH0A4bnH7i
Content-Type: multipart/mixed; boundary="------------WDNS56nxRGzjPqwCsMioMB0m";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Git <git@vger.kernel.org>
Message-ID: <a49c95b2-4468-e510-957a-427f9ce8763d@gmail.com>
Subject: [BUG] 'make install' may overwrite existing directories

--------------WDNS56nxRGzjPqwCsMioMB0m
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNClRoZSBwcm9qZWN0IE1ha2VmaWxlIGRlZmluZXMgdGhlIGluc3RhbGwgdGFyZ2V0
IGFzOg0KDQokIHNlZCAtbiAnMzIzNiwzMjQ1cCcgTWFrZWZpbGUNCg0KaW5zdGFsbDogYWxs
DQoJJChJTlNUQUxMKSAtZCAtbSA3NTUgJyQoREVTVERJUl9TUSkkKGJpbmRpcl9TUSknDQoJ
JChJTlNUQUxMKSAtZCAtbSA3NTUgJyQoREVTVERJUl9TUSkkKGdpdGV4ZWNfaW5zdGRpcl9T
USknDQoJJChJTlNUQUxMKSAkKElOU1RBTExfU1RSSVApICQoUFJPR1JBTVMpIA0KJyQoREVT
VERJUl9TUSkkKGdpdGV4ZWNfaW5zdGRpcl9TUSknDQoJJChJTlNUQUxMKSAkKFNDUklQVFMp
ICckKERFU1RESVJfU1EpJChnaXRleGVjX2luc3RkaXJfU1EpJw0KCSQoSU5TVEFMTCkgLW0g
NjQ0ICQoU0NSSVBUX0xJQikgJyQoREVTVERJUl9TUSkkKGdpdGV4ZWNfaW5zdGRpcl9TUSkn
DQoJJChJTlNUQUxMKSAkKElOU1RBTExfU1RSSVApICQoaW5zdGFsbF9iaW5kaXJfeHByb2dy
YW1zKSANCickKERFU1RESVJfU1EpJChiaW5kaXJfU1EpJw0KCSQoSU5TVEFMTCkgJChCSU5E
SVJfUFJPR1JBTVNfTk9fWCkgJyQoREVTVERJUl9TUSkkKGJpbmRpcl9TUSknDQoNCg0KTm90
aWNlIHRoYXQgdGhlIGRpcmVjdG9yaWVzIGFyZSBiZWluZyBpbnN0YWxsZWQgZXZlbiBpZiB0
aGV5IGFscmVhZHkgDQpleGlzdC4gIFRoaXMgbWF5IGJlIHByb2JsZW1hdGljIGluIGNhc2Ug
dGhlIGV4aXN0aW5nIGRpcmVjdG9yaWVzIGhhdmUgYSANCmRpZmZlcmVudCBtb2RlLCBvciBo
YXZlIFNFTGludXggc2VjdXJpdHkgY29udGV4dHMsIG9yIGFueSBvdGhlciANCmNoYXJhY3Rl
cmlzdGljIHRoYXQgaW5zdGFsbCgxKSB3b3VsZCBvdmVyd3JpdGUuDQoNCkEgc2ltaWxhciBi
dWcgcmVwb3J0IGluIGFuIE5HSU5YIHByb2plY3QgY2FuIGJlIGZvdW5kIGhlcmU6DQoNCjxo
dHRwczovL2dpdGh1Yi5jb20vbmdpbngvdW5pdC9pc3N1ZXMvNzY5Pg0KDQpUaGUgdHdvIHNv
bHV0aW9ucyBhdmFpbGFibGUgYXJlOg0KDQotIE1ha2UgdGhlIGluc3RhbGwgdGFyZ2V0IGJl
IGEgZHVtbXkgdGFyZ2V0IHRoYXQgZGVwZW5kcyBvbiB0aGUgZmlsZXMgDQpiZWluZyBpbnN0
YWxsZWQsIGFuZCB3cml0ZSBwcm9wZXIgbWFrZSgxKSBydWxlcyBmb3IgdGhvc2UgdGFyZ2V0
cy4gIFRoaXMgDQp3b3VsZCBiZSBwcmVmZXJyZWQuICBZb3UgY2FuIGNoZWNrIHRoZSBMaW51
eCBtYW4tcGFnZXMgTWFrZWZpbGUgZm9yIGFuIA0KaW1wbGVtZW50YXRpb24gb2YgdGhlICdp
bnN0YWxsJyB0YXJnZXQgdGhhdCBkb2VzIHRoaXMuDQoNCi0gdGVzdCgxKSBpZiB0aGUgZGly
ZWN0b3J5IGV4aXN0cyBiZWZvcmUgYWN0dWFsbHkgY3JlYXRpbmcgaXQuICBUaGlzIGlzIA0K
YSBzaW1wbGUgd29ya2Fyb3VuZC4NCg0KDQpDaGVlcnMsDQoNCkFsZXgNCg0KDQotLSANCjxo
dHRwOi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzLz4NCg==

--------------WDNS56nxRGzjPqwCsMioMB0m--

--------------pDf0k5Z5Gil0lFEH0A4bnH7i
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmNRKbgACgkQnowa+77/
2zJKLQ//c88sOF9G3sMHtMc3uZn6hO9VcAtpURDnRPidbgoR0oX57A4N6l2yf1eU
7azaPy+ChY0yzRKmxdLyC1YVFuLc29/aUa7PX3bEZZjKtO440a5OjcAKwdLnGNmH
KoIXUP1L5X2um2g4GoovgFll1yL1Fob9LLCTsKe5vmtaTlNkJmAVfQBGYFA6f9h2
wupnQS7qqVfxOQl2HJ0WmikQDsOgErocgI4ctuVoKsUWxLU+I/zORdlmQYmJ0Jva
0/ABuWZghoe4lVnEZ2pW6TlBg6h2gPPvOB5cj+7GhP9gvYwy2Uo7Ui+bYA9zSlSn
Rq2MebQClIWUYytVF+fooZqdAvjHmaTozmnz99oQO3d3zWYvANX6s2/4FfR0BLi1
S3vsqJC9BPXXKgvT71NraWuGIdNTvJ01if/78JpyZPKO4Z+m/pwEt1TWDoa/02w5
uhlnCA5XSyhrQknk/usRdC4NWAybw4LWsL3xPjkgMGEmZd8mYGjlZZMJjRYgsN2K
M3rD6gVnRGPibDEZ6mCIfA8gfG8h2W1fAZ4deidN1ovJnzbfQI0ktEftxj0csgNC
mVCKk0/iyxTRLJ2G34DfULzOr9Qezp50W/G/TBPt7SC3o4DmAaXBacjSNXgIvewe
B//I/qZx9+bMN88XU6uoAFzUHsWO4H1kZ7fmCg/XEbmInvz6KeU=
=RVRT
-----END PGP SIGNATURE-----

--------------pDf0k5Z5Gil0lFEH0A4bnH7i--
