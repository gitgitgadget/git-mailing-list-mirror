Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DCEC433F5
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 18:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF07561038
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 18:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344437AbhJQSfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 14:35:00 -0400
Received: from avasout02.plus.net ([212.159.14.17]:35244 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhJQSe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 14:34:59 -0400
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id cAxjm0FTerasdcAxkmc6M3; Sun, 17 Oct 2021 19:32:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1634495568; bh=tvq+4dFeQKwOAAjSoJtYvrFN+vCPpB3vIRXqi+bjq5w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Vu0QIBFpoSZbkk5eoKJ25E7VgqrO+6roaJrrVRtcKWJv1+M0LZvU+QrB6DO85pGuW
         8dgQata1nXIbBJeRQ0pTHXwAGuIpRfiajthLS5kVV0pxgW4fkWbcHRZi3hFmNfIpxU
         2BTu48/weiXG9OpfcsMIvnAnzIPddvz2g7vxDVVz+r6oT4P92JzAQVIrfQnmaTDYNU
         IXk2Qi7JB/SVvYS7f1KvMbUBADKF8pB9AG58KKlA+R8t55jnWBFtiBqf7WpZiGubHm
         s0Bkp5r+8poy5Q8q4d/WWf0Jr2zWQVVlHpXx9MmWKiwkhYmE3nZW9yvzEgLWIMDZWB
         rblEnWpF7nRug==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=bKWN3M2Z c=1 sm=1 tr=0
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=VwQbUJbxAAAA:8 a=IV6zVFhp2VCHSBWG5AkA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
Subject: Re: Build failure of 'seen'
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <48748e0e-7c18-b7ff-e1c3-ac0733cc7d34@ramsayjones.plus.com>
 <xmqqo87o1mgm.fsf@gitster.g> <87mtn8c633.fsf@evledraar.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <ab2082f4-dd6b-ece9-cc59-cb8ecdfc0f9e@ramsayjones.plus.com>
Date:   Sun, 17 Oct 2021 19:32:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87mtn8c633.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: base64
X-CMAE-Envelope: MS4wfIerDYJFHeDyBuNgIteceLGD/dlUy3TId3dbGsNfYdZFUbhBrCagat+Ls7LX03/XghvaMTdkrleuht0rOp2eht3hXZRmdnf5ruj8anlkRAaj4Eq4/q7R
 vE2NlAr7xjpl42PZhOToml4zJEy58ycxNr9oCvsiz81a0xYZ9eERdhBC4sgMFRGQL4IoNpohIpsmZA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCk9uIDE3LzEwLzIwMjEgMTE6MDYsIMOGdmFyIEFybmZqw7Zyw7AgQmphcm1hc29uIHdy
b3RlOg0KPiANCj4gT24gU2F0LCBPY3QgMTYgMjAyMSwgSnVuaW8gQyBIYW1hbm8gd3JvdGU6
DQo+IA0KPj4gUmFtc2F5IEpvbmVzIDxyYW1zYXlAcmFtc2F5am9uZXMucGx1cy5jb20+IHdy
aXRlczoNCj4+DQo+Pj4gSGkgSnVuaW8sDQo+Pj4NCj4+PiBUb25pZ2h0J3MgYnVpbGQgb2Yg
J3NlZW4nIGZhaWxlZCBmb3IgbWUgKG9uIExpbnV4IGFuZCBDeWd3aW4pOg0KPj4NCj4+IFll
cywgSSBzYXcgdGhlIHNhbWUgd2l0aCB0aGUgcmVwb3J0IGF0DQo+Pg0KPj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvZ2l0L3htcXFoN2RqYmE2ZS5mc2ZAZ2l0c3Rlci5nLw0KPj4NCj4+
IHRoZSBiYWxsIGlzIGluIMOGdmFyJ3MgY291cnQuDQoNCk9vcHMhIFNvcnJ5IGZvciB0aGUg
ZHVwbGljYXRlIHJlcG9ydC4NCkknbSBvYnZpb3VzbHkgbm90IHJlYWRpbmcgdGhlIGxpc3Qg
Y2xvc2VseSBlbm91Z2guIDooDQoNCj4gQXMgYW4gYXNpZGUgaXMgdGhhdCAidW5pbml0aWFs
aXplZCIgZm91bmQgYnkgYW55IHRvb2wvY29tcGlsZXI/IEkgZGlkbid0DQo+IHRyaWdnZXIg
aXQgd2l0aCBhbnl0aGluZyBJIHRyaWVkLg0KDQpJIG9ubHkgZ2V0IHRoZSB3YXJuaW5nIHdp
dGggZ2NjICh2OS4zLjAgb24gTGludXgsIGFuZCB2MTEuMi4wIG9uIEN5Z3dpbikuDQoNCltj
bGFuZyB2ZXJzaW9uIDEwLjAuMC00dWJ1bnR1MSBvbiBMaW51eCBhbmQgY2xhbmcgdmVyc2lv
biA4LjAuMSBvbiBDeWd3aW4NCmRvIG5vdCBpc3N1ZSBhbnkgd2FybmluZ3NdDQoNCkFsc28s
IHRoaXMgcGFydGljdWxhciB3YXJuaW5nIGRlcGVuZHMgb24gdGhlIGxldmVsIG9mIG9wdGlt
aXphdGlvbg0KdXNlZCB3aXRoIHRoZSBjb21tYW5kLiBJIGJ1aWxkIHdpdGggdGhlIGRlZmF1
bHQgJ0NGTEFHUyA9IC1nIC1PMiAtV2FsbCcNCmFuZCB3aXRoICdERVZFTE9QRVI9MScuDQoN
Ck9uIExpbnV4Og0KDQogICQgbWFrZSBWPTEgcmVmcy9maWxlcy1iYWNrZW5kLm8NCiAgR0lU
X1ZFUlNJT04gPSAyLjMzLjEuMTAzMy5nOTU3YWMwNTI3MA0KICBjYyAtbyByZWZzL2ZpbGVz
LWJhY2tlbmQubyAtYyAtTUYgcmVmcy8uZGVwZW5kL2ZpbGVzLWJhY2tlbmQuby5kIC1NUSBy
ZWZzL2ZpbGVzLWJhY2tlbmQubyAtTU1EIC1NUCAgLVdlcnJvciAtV2FsbCAtcGVkYW50aWMg
LVdwZWRhbnRpYyAtV2RlY2xhcmF0aW9uLWFmdGVyLXN0YXRlbWVudCAtV2Zvcm1hdC1zZWN1
cml0eSAtV29sZC1zdHlsZS1kZWZpbml0aW9uIC1Xb3ZlcmZsb3cgLVdwb2ludGVyLWFyaXRo
IC1Xc3RyaWN0LXByb3RvdHlwZXMgLVd1bnVzZWQgLVd2bGEgLWZuby1jb21tb24gLVdleHRy
YSAtV21pc3NpbmctcHJvdG90eXBlcyAtV25vLWVtcHR5LWJvZHkgLVduby1taXNzaW5nLWZp
ZWxkLWluaXRpYWxpemVycyAtV25vLXNpZ24tY29tcGFyZSAtV25vLXVudXNlZC1wYXJhbWV0
ZXIgIC1nIC1PMiAtV2FsbCAtSS4gLURIQVZFX1NZU0lORk8gLURHSVRfSE9TVF9DUFU9Ilwi
eDg2XzY0XCIiIC1ESEFWRV9BTExPQ0FfSCAgLURVU0VfQ1VSTF9GT1JfSU1BUF9TRU5EIC1E
U1VQUE9SVFNfU0lNUExFX0lQQyAtRFNIQTFfREMgLURTSEExRENfTk9fU1RBTkRBUkRfSU5D
TFVERVMgLURTSEExRENfSU5JVF9TQUZFX0hBU0hfREVGQVVMVD0wIC1EU0hBMURDX0NVU1RP
TV9JTkNMVURFX1NIQTFfQz0iXCJjYWNoZS5oXCIiIC1EU0hBMURDX0NVU1RPTV9JTkNMVURF
X1VCQ19DSEVDS19DPSJcImdpdC1jb21wYXQtdXRpbC5oXCIiIC1EU0hBMjU2X0JMSyAgLURI
QVZFX1BBVEhTX0ggLURIQVZFX0RFVl9UVFkgLURIQVZFX0NMT0NLX0dFVFRJTUUgLURIQVZF
X0NMT0NLX01PTk9UT05JQyAtREhBVkVfU1lOQ19GSUxFX1JBTkdFIC1ESEFWRV9HRVRERUxJ
TSAnLURQUk9DRlNfRVhFQ1VUQUJMRV9QQVRIPSIvcHJvYy9zZWxmL2V4ZSInICAtREZSRUFE
X1JFQURTX0RJUkVDVE9SSUVTIC1ETk9fU1RSTENQWSAtRFNIRUxMX1BBVEg9JyIvYmluL3No
IicgLURQQUdFUl9FTlY9JyJMRVNTPUZSWCBMVj0tYyInICByZWZzL2ZpbGVzLWJhY2tlbmQu
Yw0KICByZWZzL2ZpbGVzLWJhY2tlbmQuYzogSW4gZnVuY3Rpb24g4oCYZmlsZXNfcmVmbG9n
X2V4cGlyZeKAmToNCiAgcmVmcy9maWxlcy1iYWNrZW5kLmM6MzIxMjoxMTogZXJyb3I6IOKA
mHR5cGXigJkgbWF5IGJlIHVzZWQgdW5pbml0aWFsaXplZCBpbiB0aGlzIGZ1bmN0aW9uIFst
V2Vycm9yPW1heWJlLXVuaW5pdGlhbGl6ZWRdDQogICAzMjEyIHwgICAgISh0eXBlICYgUkVG
X0lTU1lNUkVGKSAmJg0KICAgICAgICB8ICAgICB+fn5+fn5efn5+fn5+fn5+fn5+fn4NCiAg
Y2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCiAgbWFrZTogKioq
IFtNYWtlZmlsZToyNTU1OiByZWZzL2ZpbGVzLWJhY2tlbmQub10gRXJyb3IgMQ0KICAkIA0K
DQpBVEIsDQpSYW1zYXkgSm9uZXMNCg==
