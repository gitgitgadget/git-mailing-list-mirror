Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C9DC433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 02:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC67B600EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 02:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbhJ0Cvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 22:51:38 -0400
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.123]:49404 "EHLO
        xiaomi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238561AbhJ0Cvh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 22:51:37 -0400
Received: from BJ-MBX04.mioffice.cn (10.237.8.124) by HK-MBX02.mioffice.cn
 (10.56.8.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 27 Oct 2021
 10:48:53 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX04.mioffice.cn
 (10.237.8.124) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 27 Oct 2021
 10:48:52 +0800
Received: from BJ-MBX01.mioffice.cn ([::1]) by BJ-MBX01.mioffice.cn
 ([fe80::840f:e91a:2517:14d5%9]) with mapi id 15.02.0986.009; Wed, 27 Oct 2021
 10:48:52 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [External Mail]Re: why git is so slow for a tiny git push?
Thread-Topic: [External Mail]Re: why git is so slow for a tiny git push?
Thread-Index: Ade84mmmstEBXQTRSsexpdzlhc8vnAAVTYYAAAAT7KAAUV7NAAAwVDmA//+FzYD//3VBcIABZJ+A//1OjJCAGLZOAP//J7bQ
Date:   Wed, 27 Oct 2021 02:48:52 +0000
Message-ID: <5c7ac5d1ee2442bdb268daa5708806d3@xiaomi.com>
References: <c5a8595658d6416684c2bbd317494c49@xiaomi.com>
 <5a6f3e8f29f74c93bf3af5da636df973@xiaomi.com>
 <576b2f3e162e4f86992d8f4e680d0881@xiaomi.com>
 <YWRr9g32cMlIc37V@coredump.intra.peff.net>
 <ef2aa0d3ea8a4d98b910abdfd55191d0@xiaomi.com>
 <YWVJyRJhRTdg39tX@coredump.intra.peff.net>
 <d8abab7fb5184a94a9e9e5b7c1f28695@xiaomi.com>
 <YWYAjRfLsDtc1Dkm@coredump.intra.peff.net>
 <5063751fd4b94ccca3987080c96370d8@xiaomi.com>
 <YXh5FoeyfePqr1k3@coredump.intra.peff.net>
In-Reply-To: <YXh5FoeyfePqr1k3@coredump.intra.peff.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhdCdzIGNvb2wuIFRoYW5rcyBmb3IgeW91IGhlbHAuIEkgd2lsbCB0cnkgdG8gY29tcGlsZSBp
dCBteXNlbGYNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEplZmYgS2luZyA8
cGVmZkBwZWZmLm5ldD4NClNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyNywgMjAyMSA1OjU1IEFN
DQpUbzog56iL5rSLIDxjaGVuZ3lhbmdAeGlhb21pLmNvbT4NCkNjOiBnaXRAdmdlci5rZXJuZWwu
b3JnDQpTdWJqZWN0OiBSZTogW0V4dGVybmFsIE1haWxdUmU6IHdoeSBnaXQgaXMgc28gc2xvdyBm
b3IgYSB0aW55IGdpdCBwdXNoPw0KDQoqVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBvdXRz
aWRlIG9mIFhJQU9NSS4gUGxlYXNlIHRyZWF0IHRoaXMgZW1haWwgd2l0aCBjYXV0aW9uKg0KDQoN
Ck9uIFRodSwgT2N0IDE0LCAyMDIxIGF0IDA2OjQ3OjMxQU0gKzAwMDAsIOeoi+a0iyB3cm90ZToN
Cg0KPiBTZWVtcyB0aGF0IGdpdCByZWNlaXZlLXBhY2sgb25seSB0YWtlcyAxIHNlY29uZHMuDQo+
IEFmdGVyIHRoYXQsIGdpdCByZXYtbGlzdCB0YWtlcyB0aGUgbW9zdCB0aW1lLCBJIGRvbid0IGtu
b3cgd2hhdCBpcyBpdA0KPiBkb2luZw0KDQpJdCdzIGNoZWNraW5nIGNvbm5lY3Rpdml0eSBvZiB3
aGF0IHdhcyBzZW50IChpLmUuLCB0aGF0IHRoZSBvdGhlciBzaWRlIHNlbnQgdXMgYWxsIHRoZSBv
YmplY3RzKS4gSWYgeW91IGhhdmUgYSB0b24gb2YgcmVmcyBvbiB0aGUgc2VydmVyIHNpZGUsIHRo
ZXJlIGFyZSBzb21lIGtub3duIGlzc3VlcyBoZXJlLCBhcyBqdXN0IGxvYWRpbmcgdGhlICJ3ZSBh
bHJlYWR5IGhhdmUgdGhpcyIgc2lkZSBvZiB0aGUgdHJhdmVyc2FsIGNhbiBiZSB2ZXJ5IGV4cGVu
c2l2ZS4NCg0KVGhlcmUncyBiZWVuIHNvbWUgcmVjZW50IHdvcmsgdG8gbWFrZSB0aGlzIGZhc3Rl
ciwgbGlrZSBmNTU5ZDZkNDVlDQoocmV2aXNpb246IGF2b2lkIGhpdHRpbmcgcGFja2ZpbGVzIHdo
ZW4gY29tbWl0cyBhcmUgaW4gY29tbWl0LWdyYXBoLA0KMjAyMS0wOC0wOSkgYW5kIGY0NTAyMmRj
MmYgKGNvbm5lY3RlZDogZG8gbm90IHNvcnQgaW5wdXQgcmV2aXNpb25zLCAyMDIxLTA4LTA5KSwg
d2hpY2ggd2lsbCBiZSBpbiB0aGUgdXBjb21pbmcgcmVsZWFzZS4gSSdtIHN1cmUgdGhlcmUgYXJl
IG1vcmUgaW1wcm92ZW1lbnRzIHRoYXQgY291bGQgYmUgbWFkZSBvbiB0b3AsIGJ1dCB0aG9zZSBz
aG93IHRoZSBnZW5lcmFsIGRpcmVjdGlvbi4NCg0KLVBlZmYNCiMvKioqKioq5pys6YKu5Lu25Y+K
5YW26ZmE5Lu25ZCr5pyJ5bCP57Gz5YWs5Y+455qE5L+d5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R
6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye655qE5Liq5Lq65oiW576k57uE44CC56aB5q2i5Lu7
5L2V5YW25LuW5Lq65Lul5Lu75L2V5b2i5byP5L2/55So77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo
6YOo5oiW6YOo5YiG5Zyw5rOE6Zyy44CB5aSN5Yi244CB5oiW5pWj5Y+R77yJ5pys6YKu5Lu25Lit
55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS25LqG5pys6YKu5Lu277yM6K+35oKo56uL5Y2z55S1
6K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu277yBIFRoaXMgZS1t
YWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24g
ZnJvbSBYSUFPTUksIHdoaWNoIGlzIGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50
aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBpbmZvcm1h
dGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBsaW1p
dGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiwgb3IgZGlz
c2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQo
cykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBs
ZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBhbmQg
ZGVsZXRlIGl0ISoqKioqKi8jDQo=
