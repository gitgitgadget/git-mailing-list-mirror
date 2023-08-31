Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46649C83F10
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 09:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjHaJuH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 05:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjHaJuG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 05:50:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD782CED
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693475357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
        to:to:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
        bh=xMuY9A1EviYKGl9crxacTDk3Or0hpqguf2sJSUUi4l0=;
        b=GHuDXg2rKg6aROLu/7Nn7TPs/umFUpIz/K/1WBIEemBDKrdy8DGvENEdUyTSXbRPK+2PoG
        zdf9OslwizBJ63uu/mqlTUQ9Pz+VtMemidKZoegVh1ZKPpUKllOF1BLiT5n1ZDbDGVza7Z
        Ct4Xse4PC5FvEw1aW8FS+A5IHe+NgVg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-aH2Q_9ffPACK_8UhgVL6cA-1; Thu, 31 Aug 2023 05:49:14 -0400
X-MC-Unique: aH2Q_9ffPACK_8UhgVL6cA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E12E3C10162
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 09:49:14 +0000 (UTC)
Received: from [10.45.224.90] (unknown [10.45.224.90])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBAF6492C13
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 09:49:12 +0000 (UTC)
Message-ID: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
Date:   Thu, 31 Aug 2023 11:49:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     git@vger.kernel.org
From:   =?UTF-8?Q?V=C3=ADt_Ondruch?= <vondruch@redhat.com>
Subject: Is there a way to get the "format-patch" formatted file name?
Autocrypt: addr=vondruch@redhat.com; keydata=
 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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hlnfFFd61m2A84DLJQ0wz1uG"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hlnfFFd61m2A84DLJQ0wz1uG
Content-Type: multipart/mixed; boundary="------------6yGyo5Bz00cs7YB7lkx93y6c";
 protected-headers="v1"
From: =?UTF-8?Q?V=C3=ADt_Ondruch?= <vondruch@redhat.com>
To: git@vger.kernel.org
Message-ID: <aa35fbdb-cca4-ae04-4124-9498d682ec06@redhat.com>
Subject: Is there a way to get the "format-patch" formatted file name?

--------------6yGyo5Bz00cs7YB7lkx93y6c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNCk15IHR5cGljYWwgdXNlIGNhc2UgaXMgdG8gZG93bmxvYWQgcGF0Y2hlcyBmcm9t
IEdILCBlLmcuOg0KDQp+fn4NCg0KJCBjdXJsIC1PTCBodHRwczovL2dpdGh1Yi5jb20vcmFp
bHMvc3Byb2NrZXRzL3B1bGwvNzkxLnBhdGNoDQogwqAgJSBUb3RhbMKgwqDCoCAlIFJlY2Vp
dmVkICUgWGZlcmTCoCBBdmVyYWdlIFNwZWVkwqDCoCBUaW1lwqDCoMKgIFRpbWUgVGltZcKg
IEN1cnJlbnQNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIERsb2FkwqAgVXBsb2FkwqDCoCBUb3RhbMKgwqAgU3Bl
bnQgTGVmdMKgIFNwZWVkDQogwqAgMMKgwqDCoMKgIDDCoMKgwqAgMMKgwqDCoMKgIDDCoMKg
wqAgMMKgwqDCoMKgIDDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgIDAgLS06LS06LS0gLS06LS06
LS0gDQotLTotLTotLcKgwqDCoMKgIDANCjEwMCAxMjcxN8KgwqDCoCAwIDEyNzE3wqDCoMKg
IDDCoMKgwqDCoCAwwqAgMjE3NjXCoMKgwqDCoMKgIDAgLS06LS06LS0gLS06LS06LS0gLS06
LS06LS0gDQo1ODYwMw0KDQp+fn4NCg0KDQpUaGUgcHJvYmxlbSB3aXRoIHRoaXMgaXMgdGhh
dCBJIGVuZCB1cCB3aXRoIHRoZSAiNzkxLnBhdGNoIiBmaWxlLCB3aGlsZSANCkknZCBsaWtl
IGhhdmUgYSBmaWxlIHdpdGggc2ltaWxhciBuYW1lIGFzIGlmIEkgaGF2ZSB1c2VkIHRoZSBn
aXQgY29tbWFuZDoNCg0KDQp+fn4NCg0KJCBnaXQgZm9ybWF0LXBhdGNoIC0xIDY1NTRiNmQN
CjAwMDEtRml4LU1pbml0ZXN0LWNvbnN0YW50LW5hbWUtaW4tdGVzdHMucGF0Y2gNCg0Kfn5+
DQoNCg0KU28gSSB3b25kZXIsIGlzIHRoZXJlIGEgd2F5IHRvIGdldCBzdWNoIGZpbGUgbmFt
ZT8NCg0KDQpUaGUgYmFzaWMgdXNlIGNhc2Ugd2hpY2ggd291bGQgYmUgZW5vdWdoIGZvciBt
ZSB3b3VsZCBiZSB0byBvYnRhaW4gdGhlIA0Kc3RyaW5nOg0KDQp+fn4NCg0KJCBoZWFkIC00
IDc5MS5wYXRjaCB8IHRhaWwgLTENClN1YmplY3Q6IFtQQVRDSF0gRml4IE1pbml0ZXN0IGNv
bnN0YW50IG5hbWUgaW4gdGVzdHMNCn5+fg0KDQphbmQgdGhlbiB1c2Ugc29tZXRoaW5nIGxp
a2U6DQoNCn5+fg0KDQokIGVjaG8gIkZpeCBNaW5pdGVzdCBjb25zdGFudCBuYW1lIGluIHRl
c3RzIiB8IGdpdCANCnNhbml0aXplLXN0cmluZy1pbnRvLWZpbGVuYW1lDQoNCkZpeC1NaW5p
dGVzdC1jb25zdGFudC1uYW1lLWluLXRlc3RzDQoNCn5+fg0KDQoNCk9mIGNvdXJzZSBJIGNh
biBpbWFnaW5lIHNvbWV0aGluZyBtb3JlIGZhbmN5IHN1Y2ggYXM6DQoNCg0Kfn5+DQoNCiQg
Z2l0IGV4dHJhY3QtZmlsZW5hbWVzLWZyb20tcGF0Y2ggNzkxLnBhdGNoDQoNCjAwMDEtRml4
LU1pbml0ZXN0LWNvbnN0YW50LW5hbWUtaW4tdGVzdHMucGF0Y2gNCg0Kfn5+DQoNCg0KSU9X
LCBJJ2QgbGlrZSBpZiB0aGUgYGZtdF9vdXRwdXRfc3ViamVjdGAgbWV0aG9kIChpZiB0aGF0
IGlzIHRoZSByaWdodCBvbmUpOg0KDQpodHRwczovL2dpdGh1Yi5jb20vZ2l0L2dpdC9ibG9i
LzZlODYxMWU5MGE2MjllMzhkYTFlN2MwZTFmOTg2YmM2ZWMyM2EzMzAvbG9nLXRyZWUuYyNM
Mzg4DQoNCndhcyBtb3JlIHVzZXIgZXhwb3NlZC4NCg0KDQpPZiBjb3Vyc2UgSSBjb3VsZCBw
dXQgc29tZSBzY3JpcHQgbGlrZSB0aGlzIHRvZ2V0aGVyIG15c2VsZiwgYnV0IEkgdGhpbmsg
DQp0aGF0IEdpdCBhbHJlYWR5IGhhcyBhbGwgdGhlIHBsdW1pbmcuDQoNCg0KVGhhbmsgeW91
IGluIGFkdmFuY2UNCg0KDQpWw610DQoNCg0KDQpQLlMuOiBQbGVhc2Uga2VlcCBtZSBpbiB0
aGUgQ0MsIGJlY2F1c2UgSSBhbSBub3Qgc3Vic2NyaWJlZCB0byB0aGlzIE1MDQoNCg==

--------------6yGyo5Bz00cs7YB7lkx93y6c--

--------------hlnfFFd61m2A84DLJQ0wz1uG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEjuEMC4xF8PxsGhoUDOCe55kXuHwFAmTwYhYFAwAAAAAACgkQDOCe55kXuHwp
LQ//SO8SYTr0bF66tFqq9A00o8F7Y0prtA0DCgaeuNgZLaFcOF1d2nr3opKkBEeJIg6m7vET1Pvb
jWJZv3atxey1EvzYoN0RXCnR7yBcxmHHmf9CH13FBrD6YJYYD4At31671BIYorbINThTKe5gWsx/
pqcLDFf3rPF5eyspi7bGw5HueyScu3f99mpi/fqJtGfxCLBsOMWIJ5fpM1xKLx6CrHVqL9c0zZRT
O0WcBzAXQ58Ou3y2kiNVK35RRargGY3DIlQdwWLWUcmUUWvhhs1ghPIh/JSqXDmM8cD1k5N27hbg
1J4lbZZD87T2hYah+6l/zTsMu975zESrQuepybXBREapzbUY5r/gfWjQQeP6QNc2V7dmNzxwOYjv
DcA3/OBDLnn73jtlcTwfFzkSIQH0gYfWNhuRKL60EX5Wq6n0gO3DK2dR8/IjR+4VUqJJcM/x0zSF
4OYTaBWeFYzBEcTBzfPbp29MsJUFBgsIi1RHVDfPPEX1DMLLiGUQA5nq3+jxjBc3vYuIH2OHlTD0
xQ92BOKk/9YX5ozW++ruDafDVk4UfBbcfH4ZGbZvqytqMLBHVRBJpD1UfKG9wDFvYeWZSXXGBp5o
zP6871SwDVEQxcG/ifm1eLJ1nNFzj7P3kTKcdxVA+w7JGXhXo1eSUaLl5018G3u/AM1QVc4m4sl3
+6I=
=5yFj
-----END PGP SIGNATURE-----

--------------hlnfFFd61m2A84DLJQ0wz1uG--

