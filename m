Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689B7FA373E
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 19:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJYT1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 15:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiJYT1I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 15:27:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15466AF197
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 12:27:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk15so22798410wrb.13
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 12:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U63F9uzo+Q1tMCziUjdQGqxwn8J8pTv0ghumApRbQhI=;
        b=fGz9NcPue1FnRZcA9ucM+aT88FK/CluEu7DQ9hYwF+Ijq+lMKunpDPzPZvLaF5WY7s
         PKBbp9ZZEHs3UF2uu71nUyxhSs3lMo6X1Gpv7GTmgRqKI3k/h9ivv/yXd7nIHnyEpgUV
         wXfbxiTqzVEABiNaiCbGy1bTM6v/TECGPUYpfXCCwiBDi+Z4wdPGGzHttHBi1JA22E64
         df7mFufnyUqhBclCIxNUEB9jDSxF/rqoxMJQnFXoh12AbWERiwHSGR7yrdkW6BpuWwqI
         lWi6IWe2Auw62GGoKTJWhjBiMgt6E2ikNOFbvGVX9TM5Iff7f5s7pjnalHg1mvCIWYFP
         rCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U63F9uzo+Q1tMCziUjdQGqxwn8J8pTv0ghumApRbQhI=;
        b=V7bMpxzi2FpohtDFgTgsXMMc3nOVjoOLpxfn/t3X6WZaRYN105zxETmVjbzXmj8Tm7
         8Um2BWW1Fs1hxK3UAIiC8bo6KtUBDyNTaSKfO+ijffEQzJtJGir7lhHCcv2UEINWZ1ow
         mr74xvDSSeeZEzoGx3M6h28787FLsvA/xSWiizSE6pSxuAB5FD6FnPs+1AxB+jaL4b+E
         wZR1h+hECnIbsZmBjZOB7LT2vYcLTC6BcKJwuoWmELWSgzxTklie8GRjBFNByLSC0Rqw
         KAj42Ju6f6zIv4Wi05pYvR5qFchEFXMUYuxmH7yttDqi07dyXSjFN3PUO4hx/7ElUW+K
         99aA==
X-Gm-Message-State: ACrzQf3MQpcuwBF4/5hwHKoC+zcOEAELgYU3xvBJYrxe9mUUY/tEAKUr
        T9GN+ySHjlpMw15zzVTdW/U=
X-Google-Smtp-Source: AMsMyM4+3K3vLKuVBMa0EfKO82JVX/xsZqlijpROpaXWUEyynZP8GSdbWB6g0YyixMvT1YQFEYwZjA==
X-Received: by 2002:adf:ee46:0:b0:236:57e4:60d9 with SMTP id w6-20020adfee46000000b0023657e460d9mr15065580wro.208.1666726025536;
        Tue, 25 Oct 2022 12:27:05 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id v21-20020a7bcb55000000b003b3365b38f9sm3345299wmj.10.2022.10.25.12.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 12:27:04 -0700 (PDT)
Message-ID: <242e6a00-a2ad-4b7b-3643-41cf49d4432a@gmail.com>
Date:   Tue, 25 Oct 2022 21:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] Set git diff driver for C source code files.
Content-Language: en-US
To:     Andrew Clayton <a.clayton@nginx.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Alejandro Colomar <alx@nginx.com>
References: <20221025191552.60658-1-a.clayton@nginx.com>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20221025191552.60658-1-a.clayton@nginx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ilzJiiuF02ih2s0oEJe5A4Zh"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ilzJiiuF02ih2s0oEJe5A4Zh
Content-Type: multipart/mixed; boundary="------------fc8ljIkgkRij3wJnsp5IDGI8";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Andrew Clayton <a.clayton@nginx.com>,
 Git Mailing List <git@vger.kernel.org>
Cc: Alejandro Colomar <alx@nginx.com>
Message-ID: <242e6a00-a2ad-4b7b-3643-41cf49d4432a@gmail.com>
Subject: Re: [PATCH] Set git diff driver for C source code files.
References: <20221025191552.60658-1-a.clayton@nginx.com>
In-Reply-To: <20221025191552.60658-1-a.clayton@nginx.com>

--------------fc8ljIkgkRij3wJnsp5IDGI8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQW5kcmV3LA0KDQpPbiAxMC8yNS8yMiAyMToxNSwgQW5kcmV3IENsYXl0b24gd3JvdGU6
DQo+IEdpdCBjYW4gYmUgdG9sZCB0byBhcHBseSBsYW5ndWFnZS1zcGVjaWZpYyBydWxlcyB3
aGVuIGdlbmVyYXRpbmcgZGlmZnMuDQo+IEVuYWJsZSB0aGlzIGZvciBDIHNvdXJjZSBjb2Rl
IGZpbGVzICgqLmMgYW5kICouaCkgc28gdGhhdCBmdW5jdGlvbiBuYW1lcw0KPiBhcmUgcHJp
bnRlZCByaWdodC4gU3BlY2lmaWNhbGx5LCBkb2luZyBzbyBwcmV2ZW50cyAiZ2l0IGRpZmYi
IGZyb20NCj4gbWlzdGFrZW5seSBjb25zaWRlcmluZyB1bmluZGVudGVkIGdvdG8gbGFiZWxz
IGFzIGZ1bmN0aW9uIG5hbWVzLg0KPiANCj4gVGhpcyBoYXMgdGhlIHNhbWUgZWZmZWN0IGFz
IGFkZGluZw0KPiANCj4gICAgICBbZGlmZiAiZGVmYXVsdCJdDQo+ICAgICAgICAgIHhmdW5j
bmFtZSA9ICJeW1s6YWxwaGE6XSRfXS4qW146XSQiDQoNCldoZXJlIGRvZXMgdGhhdCByZWdl
eCBjb21lIGZyb20/DQoNCj4gDQo+IHRvIHlvdXIgZ2l0IGNvbmZpZyBmaWxlLg0KPiANCj4g
ZS5nIGdldA0KPiANCj4gICAgICBAQCAtMTAsNyArMTAsNyBAQCBpbnQgbWFpbih2b2lkKQ0K
PiANCj4gaW5zdGVhZCBvZg0KPiANCj4gICAgICBAQCAtMTAsNyArMTAsNyBAQCBhZ2FpbjoN
Cj4gDQo+IFRoaXMgbWFrZXMgdXNlIG9mIHRoZSBnaXRhdHRyaWJ1dGVzKDUpIGluZnJhc3Ry
dWN0dXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmV3IENsYXl0b24gPGEuY2xheXRv
bkBuZ2lueC5jb20+DQoNCldvdyEgIGdpdCgxKSBpcyBzaG93aW5nIEMgZnVuY3Rpb25zIGlu
Y29ycmVjdGx5PyEgIFRoZSBsYXN0IGxhbmd1YWdlIEkgZXhwZWN0ZWQgDQp0aGlzIHRvIGhh
cHBlbiB3aXRoLiAgSSBoYWQgdG8gdXNlIHRoaXMgZm9yIG1hbig3KSBwYWdlcywgYnV0IGZv
ciBDIGZpbGVzPyENCg0KSSBtZWFuLCB3ZSBoYXZlIG9uZSBvZiB0aGUgc2ltcGxlc3QgYW5k
IG1vc3QgY29uc2lzdGVudCBjb2Rpbmcgc3R5bGVzIEkndmUgc2VlbiANCnJlZ2FyZGluZyBw
bGFjZW1lbnQgb2YgZnVuY3Rpb24gZGVmaW5pdGlvbnMgKG5vIGZhbHNlIG5lZ2F0aXZlcyBv
ciBwb3NpdGl2ZXMgaW4gDQpncmVwYygxKSkuDQoNClNob3VsZCB3ZSByZXBvcnQgYSBidWcg
dG8gPG1haWx0bzpHaXQgPGdpdEB2Z2VyLmtlcm5lbC5vcmc+PiB0b28gOikNCg0KPiAtLS0N
Cj4gICAuZ2l0YXR0cmlidXRlcyB8IDIgKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IC5naXRhdHRyaWJ1dGVzDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvLmdpdGF0dHJpYnV0ZXMgYi8uZ2l0YXR0cmlidXRlcw0KPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMC4uNDVlYzUxNTYNCj4gLS0tIC9k
ZXYvbnVsbA0KPiArKysgYi8uZ2l0YXR0cmlidXRlcw0KPiBAQCAtMCwwICsxLDIgQEANCj4g
KyouYwlkaWZmPWNwcA0KPiArKi5oCWRpZmY9Y3BwDQoNCldoeSBjcHA/DQoNClRoYW5rcywN
Cg0KQWxleA0KDQotLSANCjxodHRwOi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzLz4NCg==


--------------fc8ljIkgkRij3wJnsp5IDGI8--

--------------ilzJiiuF02ih2s0oEJe5A4Zh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmNYOIAACgkQnowa+77/
2zKW/w//QAGTE0yl1l1BJAU5ZWsz36aF6zl99iPj+0JVNCfqYR0WFba3Q68dPW/M
aGY2EUucerzzqWEExSFAWRiA/GTpS+cpOAvODfTG2e82/oGsrkf6XuhQkIB0z7w/
1W7PECi06ShTKrTTOSt0PEmNHCX29j6Ik4cdngsxQ+C14vdUF9BxfQ42t5kwUDJM
yAhxxqu6WOl6PQsfmNg73TlzXm0j3lhjwPMP5NiPFgzVv26pCgg2kGU2l+Owtjzy
70MLqjL4UxHWcNwK95/gi/j9m1OwgmNyrJDIu0fCp/YFtHGhG90W4/rvkFBEr36/
cuasshvgTd9DPE4+r4rczsR8nQU58ReWssvuYNhgW2OMIGriaC0zpRYLCIaQNJ4V
naxIrMgfoFbsHnx4+06kwhOsHOl4JKSz99+jXDBFuXrdJa8bSgy9go6ePVm7N6MI
1fDlDx0KF5OyU7+1ilc6U9jVYMRLUblpA/oPxYheyeUXnuY2AhT0JLpHlgOeVTWZ
1YWw2262VIZ8PSEB30IulVrK4aHqYriG6smNDJqie20aCIRVJBZvjOyDZVtzaX4k
q48HRIi/iSe8gupEuZ6FQ9LWi3QWEpMwpk/KC8qs3W9tqkgLGSt3gnGaKnMEpKDX
6X9kvhRQUyscbcvUaoOg7QOeQznK9aX8EhmiP/5TYNd15AmFpOU=
=F3yO
-----END PGP SIGNATURE-----

--------------ilzJiiuF02ih2s0oEJe5A4Zh--
