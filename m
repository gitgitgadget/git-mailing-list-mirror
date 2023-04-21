Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5B4C77B71
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 14:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjDUOwl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 10:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjDUOwd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 10:52:33 -0400
Received: from thyone.hiz-saarland.de (thyone.hiz-saarland.de [134.96.7.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B20B10D8
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 07:52:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by thyone.hiz-saarland.de (Postfix) with ESMTP id CE52140E1A90
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 16:52:28 +0200 (CEST)
Received: from thyone.hiz-saarland.de ([127.0.0.1])
        by localhost (thyone.hiz-saarland.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ys3jbS90rSgg for <git@vger.kernel.org>;
        Fri, 21 Apr 2023 16:52:27 +0200 (CEST)
Received: from triton.rz.uni-saarland.de (old-smtp.uni-saarland.de.local [134.96.7.25])
        by thyone.hiz-saarland.de (Postfix) with ESMTPS
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 16:52:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by triton.rz.uni-saarland.de (Postfix) with ESMTP id 9192C600018D
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 16:52:27 +0200 (CEST)
Received: from triton.rz.uni-saarland.de ([127.0.0.1])
        by localhost (triton.rz.uni-saarland.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id STzzzSNKw_FT for <git@vger.kernel.org>;
        Fri, 21 Apr 2023 16:52:26 +0200 (CEST)
Received: from mail.uni-sb.de (mail.uni-sb.de [134.96.252.33])
        by triton.rz.uni-saarland.de (Postfix) with ESMTPS
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 16:52:26 +0200 (CEST)
Received: from mail.cs.uni-saarland.de (mail.cs.uni-saarland.de [134.96.254.200])
        by mail.uni-sb.de (8.16.1/2018090600) with ESMTP id 33LEoZVo027441;
        Fri, 21 Apr 2023 16:50:35 +0200 (CEST)
Received: from edguy.cs.uni-saarland.de (edguy.cs.uni-saarland.de [134.96.224.31])
        by mail.cs.uni-saarland.de (8.16.1/2023032400) with ESMTP id 33LEq3w5000565;
        Fri, 21 Apr 2023 16:52:03 +0200 (CEST)
Received: from sopra.se.cs.uni-saarland.de ([134.96.246.2]:10099 helo=[10.1.2.252])
        by edguy.cs.uni-saarland.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <bockthom@cs.uni-saarland.de>)
        id 1pps6J-0005Ur-1M;
        Fri, 21 Apr 2023 16:51:04 +0200
Message-ID: <1153e31d-2f89-c9dc-8551-adf4d3822487@cs.uni-saarland.de>
Date:   Fri, 21 Apr 2023 16:51:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
 <xmqqa5z6q1jl.fsf@gitster.g> <20230418041253.GD60552@coredump.intra.peff.net>
 <7bbcfbc0-f9da-09ef-9441-5e4b13780841@github.com>
From:   Thomas Bock <bockthom@cs.uni-saarland.de>
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order':
 Commits from 2011 are treated to be before 1980
In-Reply-To: <7bbcfbc0-f9da-09ef-9441-5e4b13780841@github.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------U0m0CqR0zMoHhr8AhwBfYslv"
X-DCC--Metrics: mail.cs.uni-saarland.de; whitelist
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------U0m0CqR0zMoHhr8AhwBfYslv
Content-Type: multipart/mixed; boundary="------------atbgnc2myGQYQNxCGZYoKyaG";
 protected-headers="v1"
From: Thomas Bock <bockthom@cs.uni-saarland.de>
To: Derrick Stolee <derrickstolee@github.com>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-ID: <1153e31d-2f89-c9dc-8551-adf4d3822487@cs.uni-saarland.de>
Subject: Re: Weird behavior of 'git log --before' or 'git log --date-order':
 Commits from 2011 are treated to be before 1980
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
 <xmqqa5z6q1jl.fsf@gitster.g> <20230418041253.GD60552@coredump.intra.peff.net>
 <7bbcfbc0-f9da-09ef-9441-5e4b13780841@github.com>
In-Reply-To: <7bbcfbc0-f9da-09ef-9441-5e4b13780841@github.com>

--------------atbgnc2myGQYQNxCGZYoKyaG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

VGhhbmtzIEAgYWxsIGZvciBjbGFyaWZ5aW5nIHRoaXMgbXlzdGVyeSwgdGhpcyBhbHJlYWR5
IGhlbHBlZCBhIGxvdCB0byANCmZpZ3VyZSBvdXQgd2hhdCdzIGdvaW5nIG9uIHRoZXJlLg0K
DQpFdmVuIHRob3VnaCB0aGUgYWZmZWN0ZWQgY29tbWl0IG9iamVjdHMgYXJlIG1hbGZvcm1l
ZCwgaXQgd291bGQgYmUgdmVyeSANCmhlbHBmdWwgaWYgdGhpcyBwcm9ibGVtIGNvdWxkIGJl
IHNvbHZlZCBzb21laG93LCBmcm9tIGEgdXNlciANCnBlcnNwZWN0aXZlLiBTdWNoIG1hbGZv
cm1lZCBvYmplY3RzIGNhbiBwb3RlbnRpYWxseSBvY2N1ciBhbHNvIGluIG90aGVyIA0KY29t
cGFyYWJseSBvbGQgcHJvamVjdHMsIHdoZXJlIHNlYXJjaGluZyBmb3IgY29tbWl0cyB0aGF0
IGhhdmUgYmVlbiBtYWRlIA0KaW4gYSBzcGVjaWZpYyB0aW1lIHdpbmRvdyBpbiB0aGUgcGFz
dCBjb3VsZCBiZSB1c2VmdWwgb3IgZXZlbiBuZWNlc3NhcnkgDQppbiBzb21lIGNhc2VzLg0K
DQpPbiB0aGUgb3RoZXIgaGFuZCwgaWYgaXQgd291bGQgYmUgYSBodWdlIGVmZm9ydCB0byBz
b2x2ZSB0aGUgcHJvYmxlbSANCih3aGljaCBJIGNhbm5vdCBhc3Nlc3MpLCBJIGNvdWxkIGZ1
bGx5IHVuZGVyc3RhbmQgdGhhdCBpdCBtaWdodCBub3QgYmUgDQp3b3J0aCB0byBjb21wbGV0
ZWx5IGZpeCB0aGlzIHNwZWNpZmljIHByb2JsZW0gdGhhdCBvY2N1cnMgb25seSBpbiBmZXcg
DQpjYXNlcyBpbiB0aGUgcGFzdCAoaWYgeW91IGFyZSBzdXJlIHRoYXQgc3VjaCBtYWxmb3Jt
ZWQgb2JqZWN0cyBjYW5ub3QgDQpvY2N1ciBhbnkgbW9yZSB0b2RheSkuIElmIHlvdSBkZWNp
ZGUgdG8gbm90IHNwZW5kIHRoZSBlZmZvcnQgb24gZml4aW5nIA0KdGhpcyBwcm9ibGVtLCBo
b3dldmVyLCBJIHdvdWxkIGFwcHJlY2lhdGUgaWYgeW91IGNvdWxkLCBhdCBsZWFzdCwgDQpw
YXJ0aWFsbHkgZml4IHRoaXMgcHJvYmxlbSBieSBub3QgdHJlYXRpbmcgdGhlIGJyb2tlbiBj
b21taXQgb2JqZWN0cyB0byANCmJlIGJlZm9yZSBhbnkgb3RoZXIgY29tbWl0IG9iamVjdCAo
dGltZXN0YW1wIDApLCBidXQgaW50cm9kdWNlIHNvbWUga2luZCANCm9mIGVycm9yIGhhbmRs
aW5nIGZvciBzdWNoIGNvbW1pdHMgdGhhdCBvbWl0cyBsaXN0aW5nIHRoZW0gaW4gdGhlIHdy
b25nIA0KdGltZSBwZXJpb2QuDQoNClRoYW5rcyBhZ2FpbiBmb3IgYWxsIHRoZSBleHBsYW5h
dGlvbnMgYW5kIHRob3VnaHRzIQ0KDQpCZXN0LA0KVGhvbWFzDQoNCkFtIDE4LjA0LjIzIHVt
IDE2OjAyIHNjaHJpZWIgRGVycmljayBTdG9sZWU6DQo+IE9uIDQvMTgvMjAyMyAxMjoxMiBB
TSwgSmVmZiBLaW5nIHdyb3RlOg0KPg0KPj4gT25lIHRoaW5nIHRoZSBjb21taXQgZ3JhcGgg
cGVyaGFwcyBfY291bGRfIGRvIGlzIG9taXQgdGhlIGNvbW1pdCwgb3INCj4+IG1hcmsgaXQg
YXMgInRoaXMgb25lIGlzIGJyb2tlbiBpbiBzb21lIHdheSIuIEFuZCB0aGVuIGZhbGwgYmFj
ayB0bw0KPj4gcGFyc2luZyB0aG9zZSBmZXcgaW5zdGVhZCAod2hpY2ggaXMgc2xvd2VyLCBi
dXQgaWYgaXQncyBhIHNtYWxsIG1pbm9yaXR5DQo+PiBvZiBjb21taXRzLCB0aGF0J3MgT0sp
LiBCdXQgSSBkb24ndCB0aGluayB0aGVyZSdzIGFueSBjb2RlIGZvciB0aGF0Lg0KPiBUaGUg
ImJyb2tlbiIgY29tbWl0IHdvdWxkIG5lZWQgdG8gYmUgaW5jbHVkZWQgaW4gdGhlIGNvbW1p
dC1ncmFwaCBmaWxlDQo+IHNvIGl0cyBjaGlsZHJlbiBjYW4gcG9pbnQgdG8gaXQgdXNpbmcg
YSBncmFwaCBwb3NpdGlvbiwgYnV0IHRoZW4gaXQNCj4gd291bGQgcmV2ZXJ0IHRvIHBhcnNp
bmcgZnJvbSB0aGUgY29tbWl0IG9iamVjdCAoZHVlIHRvIHNvbWUgbmV3IGNvbmNlcHQNCj4g
c3RvcmluZyAidGhpcyBpcyBhIGJhZCBjb21taXQiKS4NCj4NCj4gSWYgd2UgZGVjaWRlZCB0
byB0cmVhdCBhIHRpbWVzdGFtcCBvZiAwIGFzICJwcm9iYWJseSBicm9rZW4sIGFydGlmaWNp
YWwNCj4gYXQgYmVzdCIgdGhlbiB3ZSB3b3VsZG4ndCBuZWVkIHRoZSBuZXcgaW5kaWNhdG9y
IGluIHRoZSBjb21taXQtZ3JhcGgNCj4gZmlsZSwgYnV0IHRoaXMgc2VlbXMgbGlrZSBxdWl0
ZSBhIGJpZyBoYW1tZXIgZm9yIGEgc21hbGwgY2FzZS4NCj4NCj4gVGhhbmtzLA0KPiAtU3Rv
bGVlDQo=

--------------atbgnc2myGQYQNxCGZYoKyaG--

--------------U0m0CqR0zMoHhr8AhwBfYslv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEHfCZEk2z1jjKTp51zUYJ42aHnxYFAmRCotcFAwAAAAAACgkQzUYJ42aHnxaB
oggAglsl/SmfO9rmTGMsP7MWN6lyeVqi/qFT8rvQaLD2zcA9/IBFyTgm6kzBrGxi5FETiLy0HNsf
3Aa+oORRu3gDnIhRyDqFlMm2Nh8oKVE2t2aufo5ajRxMcOrYUBwYAchoCqHxYXhNZD03a+JRFwUZ
kh4xR0TKS4s2JsibRMfryXNhVAMVifz5F51uYHSLmjsPx9aP2C4Whzy3em5Gji9yOJkMELuypDKp
z0zaBb1753iX96q9JWAV5i+WBIfM4IRUfiWiq4xUlG+M7+3gfftORJOKdySBhPhC+QYe7OvJ0Syz
dfCnpcMJ+KtiKAMToDaGxPuoY0hs4DSq4lyBTEiZwQ==
=CJvd
-----END PGP SIGNATURE-----

--------------U0m0CqR0zMoHhr8AhwBfYslv--
