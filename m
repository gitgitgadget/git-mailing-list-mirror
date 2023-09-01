Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCB3CA0FEA
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 16:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346803AbjIAQjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346822AbjIAQjH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 12:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D61310EB
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 09:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693586301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=B1GQiTWmQpsDwrpipvNv6weAHE2BpKPXrugTngn6ASo=;
        b=czX9LRtlhOxxbPEpIgTfaJOYM3zWyIu8zPIJL3Kql5C5fUTboDNt0ro1ZZGlxy4tkHFfFl
        XhdcXBLLcW3B+VLEvYykmwx8JPA2CBWxU4QDprsn02QXDefFAhRp9Y9YazV+xXyJ0XBik+
        ztraqhAZhoKWCd/UGvBHAfLz+J/E9yM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-278-IBs9agu4NQqvwCBTyfso0Q-1; Fri, 01 Sep 2023 12:38:03 -0400
X-MC-Unique: IBs9agu4NQqvwCBTyfso0Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F2B1182C5E7;
        Fri,  1 Sep 2023 16:37:50 +0000 (UTC)
Received: from [10.45.224.90] (unknown [10.45.224.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B241ED4781A;
        Fri,  1 Sep 2023 16:37:48 +0000 (UTC)
Message-ID: <36fcd3ae-19c8-23c6-fcb0-a20230ee4622@redhat.com>
Date:   Fri, 1 Sep 2023 18:37:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is there a way to get the "format-patch" formatted file name?
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
References: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
 <xmqqo7inw2na.fsf@gitster.g>
 <24e10903-29a0-497a-c8d8-b26c02de7336@redhat.com> <ZPHEOYyyX+l3AGP1@ugly>
 <xmqqwmx9ritx.fsf@gitster.g>
From:   =?UTF-8?Q?V=C3=ADt_Ondruch?= <vondruch@redhat.com>
Autocrypt: addr=vondruch@redhat.com; keydata=
 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
In-Reply-To: <xmqqwmx9ritx.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xadrimkBZsxBc8Xulm6Zyi6s"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------xadrimkBZsxBc8Xulm6Zyi6s
Content-Type: multipart/mixed; boundary="------------d2EWjkF0bwVG0I0a4xpCY090";
 protected-headers="v1"
From: =?UTF-8?Q?V=C3=ADt_Ondruch?= <vondruch@redhat.com>
To: Junio C Hamano <gitster@pobox.com>,
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc: git@vger.kernel.org
Message-ID: <36fcd3ae-19c8-23c6-fcb0-a20230ee4622@redhat.com>
Subject: Re: Is there a way to get the "format-patch" formatted file name?
References: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
 <xmqqo7inw2na.fsf@gitster.g>
 <24e10903-29a0-497a-c8d8-b26c02de7336@redhat.com> <ZPHEOYyyX+l3AGP1@ugly>
 <xmqqwmx9ritx.fsf@gitster.g>
In-Reply-To: <xmqqwmx9ritx.fsf@gitster.g>

--------------d2EWjkF0bwVG0I0a4xpCY090
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

DQpEbmUgMDEuIDA5LiAyMyB2IDE3OjUzIEp1bmlvIEMgSGFtYW5vIG5hcHNhbChhKToNCj4g
T3N3YWxkIEJ1ZGRlbmhhZ2VuIDxvc3dhbGQuYnVkZGVuaGFnZW5AZ214LmRlPiB3cml0ZXM6
DQo+DQo+PiBidXQgaSB3b3VsZG4ndCBiZSBvcHBvc2VkIHRvIGZvciBleGFtcGxlIGdpdC1t
YWlsaW5mbyBsZWFybmluZyB0bw0KPj4gdW5kZXJzdGFuZCB0aGUgLS1wcmV0dHkgYXJndW1l
bnQsIGlmIHRoZSBpbXBsZW1lbnRhdGlvbiBkb2Vzbid0IHR1cm4NCj4+IG91dCB0byBiZSBj
b21wbGV0ZWx5IG91dCBvZiBwcm9wb3J0aW9uLg0KPiBFeGNlbGxlbnQgc3VnZ2VzdGlvbi4g
IEkgYWdyZWUgdGhhdCAnbWFpbGluZm8nIHdvdWxkIGJlIHRoZSBjbG9zZXN0DQo+IHBsYWNl
IHdlIGhhdmUgZm9yIHN1Y2ggYSBuZXcgZmVhdHVyZS4gIEl0J3MgImluZm8iIG91dHB1dCAo
aS5lLiB3aGF0DQo+IGNvbWVzIG91dCB0byB0aGUgc3RhbmRhcmQgb3V0cHV0IG9mIHRoZSBj
b21tYW5kKSBpcyBkZXNpZ25lZCB0byBiZQ0KPiBleHRlbnNpYmxlLCBhbmQgSSB2YWd1ZWx5
IHJlY2FsbCB0aGF0IHdlIGluZGVlZCBoYXZlIGFkZGVkIG5ldw0KPiBmaWVsZChzKSBkdXJp
bmcgaXRzIGxpZmV0aW1lIHdpdGggZXhpc3RpbmcgdXNlcnMgYWxyZWFkeS4NCj4NCj4gV2Ug
Y2FuIGp1c3QgaW52ZW50IGEgbmV3IGxhYmVsIChlLmcuICJGaWxlc3lzdGVtLXNhZmUtc3Vi
amVjdDoiKSwNCj4gcGFzcyB0aGUgc3ViamVjdCBzdHJpbmcgdG8gcHJldHR5LmM6Zm9ybWF0
X3Nhbml0aXplZF9zdWJqZWN0KCkgYW5kDQo+IGVtaXQgdGhlIHJlc3VsdCBuZXh0IHRvIHRo
ZSBleGlzdGluZyAiU3ViamVjdDoiIHdpdGggdGhhdCBsYWJlbCwgYW5kDQo+IHdlIGNhbiBl
dmVuIGRvIHNvIHVuY29uZGl0aW9uYWxseSB3aXRob3V0IGJyZWFraW5nIGFueWJvZHkuDQoN
Cg0KJ21haWxpbmZvJyBpcyBuZXcgdG8gbWUuIEkgYW0gbm90IHJlYWxseSBzdXJlIHdoYXQg
aXMgdGhlIHByb3BlciB1c2Ugb2YgDQp0aGlzIHRvb2wsIGJ1dCBpdCBzb3VuZCBhcyBhIG5l
YXQgaWRlYS4gSSBjb3VsZCBjZXJ0YWlubHkgZXh0cmFjdCB0aGUgDQpzdHJpbmcgZnJvbSB0
aGUgJ21haWxpbmZvJyBvdXRwdXQgYW5kIGl0IHdvcmtzIGp1c3QgYWJvdmUgdGhlIC5wYXRj
aCANCmZpbGUsIHdoaWNoIGlzIGdyZWF0Lg0KDQoNCj4NCj4NCj4gSGF2aW5nIGl0IGluICdt
YWlsaW5mbycgbWF5IHN0aWxsIG5vdCBiZSBhIGdvb2Qgc29sdXRpb24gdG8gdGhlDQo+IGlz
c3VlLCBnaXZlbiB0aGF0IFZpdCBzYXlzDQo+DQo+Pj4gQnV0IEkgdHlwaWNhbGx5IGRvbid0
IGhhdmUgYSBHaXQuDQo+IHRob3VnaC4NCg0KDQpXZWxsLCB0aGlzIHNob3VsZCBoYXZlIGJl
ZW4gIkkgdHlwaWNhbGx5IGRvbid0IGhhdmUgYSBHaXQgKnJlcG9zaXRvcnkqIiwgDQpiZWNh
dXNlIEkgY2VydGFpbmx5IGhhdmUgYSBHaXQuIE90aGVyd2lzZSBJIHdvdWxkIG5vdCBhc2sg
Zm9yIHRoaXMgDQpmdW5jdGlvbmFsaXR5Lg0KDQpKdXN0IHRvIGV4cGxhaW4sIEkgd291bGQg
bmVlZCB0byBleHBhbmQgdGhlIHNvdXJjZXMsIHdoaWNoIEkgdHlwaWNhbGx5IA0KZG9uJ3Qg
ZG8uIEknZCBuZWVkIGluaXRpYWxpemUgdGhlIHJlcG9zaXRvcnkgYW5kIGNvbW1pdCBldmVy
eXRoaW5nLCANCmFwcGx5IHRoZSBwYXRjaCwgZXRjLiBJbiB0aGF0IGNhc2UsIEknZCByYXRl
ciBrZWVwIG1hbnVhbGx5IGNoYW5naW5nIHRoZSANCnBhdGNoIG5hbWVzIDopDQoNCg0KVsOt
dA0K

--------------d2EWjkF0bwVG0I0a4xpCY090--

--------------xadrimkBZsxBc8Xulm6Zyi6s
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEjuEMC4xF8PxsGhoUDOCe55kXuHwFAmTyE1oFAwAAAAAACgkQDOCe55kXuHxE
iw//YTzKn1RfQZLqZs25/2YMrbXUHn+sk5/IXHHFNlQ8wO3jro8RVyIugC4WrrfuqsOOTlYRgWPs
urAb4CcjdGZRd4t/al1vwI8lu18YBEw3wxLqHiN7KuojIZyBcPXYkB6EVVQlgRa3fRABjTLKzBvZ
4Ab/mcbyOUABjB/85+BG2B1S07Eq0INlcB9lXBa+Yb14mkv0od/Gx7I/xpr62odeK/eYt8CIddid
IypCy3bo5b5hHS91Et1aR+9noMGWfMPgptfLOHiNOaiHo02dP+gQGV97eXkvhDLt/CvDBLvuUaTH
5TBdYiXvPJx2tPV65ygnlshPXKxdsZy3LAVAA7vF8HX2SOP2iCEjFEol3rAD4qufY/G2dIL8x1jk
fiCJVoz0M1fVVKW2Vymzzf6dRPM5hdj25wQl9UUHHjRl+XUKzycIb6mDVr/VZbxdLX2QFvF0UUWg
iYG7KaBnsV6tiBHoyLVsuzIUaZy2rQjriWU6F5nODW9S7h09J4C79r+aBQHi99c46WrQjNaGFuYu
7JmnDK3Kr+YBbi3QYwx0q85952mG3aCSgM8DNVotBp4dactSFpnk4OKSUzapWc4U0mfL6yydmXAk
lxNdiKEk68iqtWvisBhuiiyaqdC+74xQ9t4I4csLmAwoSkJVFHA8zbBYdMyVbZ/rQ6Eqetf0yZBO
Th8=
=Ow0x
-----END PGP SIGNATURE-----

--------------xadrimkBZsxBc8Xulm6Zyi6s--

