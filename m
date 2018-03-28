Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EBE01F404
	for <e@80x24.org>; Wed, 28 Mar 2018 20:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753102AbeC1Ukg (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 16:40:36 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:1206 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752924AbeC1Uke (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 16:40:34 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Mar 2018 16:40:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3482; q=dns/txt; s=iport;
  t=1522269634; x=1523479234;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Xh5L6o/zjQ/OsWsLdokFcuzZO1VKEOizAwbrKI5SmKM=;
  b=StUUqQPWv5k2VuIgVZKdZ96IfUEIsmoHvW7JJJucIWUTrzdDt6sT9lk9
   BfaF3h5XUcQqSoYdao4OkPgCdx/TmNCBmoWlCj+ElwIIGfPPTo72br7g2
   TtlGav5jCrOOHsQ9Di9DDFcYsLMgSgho7ig5VgWocBIFMlmLD6tkvgzLt
   g=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AYAQCI+rta/4ENJK1dGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYMWK2E+MSgKg1KIAI0BgVMhgQ+SSoF6CxuEaQIag3MhNBgBAgE?=
 =?us-ascii?q?BAQEBAQJrKIUmAQQBIxE3DhACAQgODAIUEgICAh0TFRACBA4FhQYIq12CHIRVg?=
 =?us-ascii?q?2+CKYEIhDyCGoITgS4MgigugxECgiqCMjCCJAKHBJAvCAIYhTeIV4Evhi+EU49?=
 =?us-ascii?q?QAhETAYEkARw4gVJwFWQBghgJghcXegEIjRNvjU+BCoEXAQE?=
X-IronPort-AV: E=Sophos;i="5.48,373,1517875200"; 
   d="scan'208";a="155816586"
Received: from alln-core-9.cisco.com ([173.36.13.129])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Mar 2018 20:31:02 +0000
Received: from XCH-RTP-016.cisco.com (xch-rtp-016.cisco.com [64.101.220.156])
        by alln-core-9.cisco.com (8.14.5/8.14.5) with ESMTP id w2SKV21E014492
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 28 Mar 2018 20:31:02 GMT
Received: from xch-rtp-020.cisco.com (64.101.220.160) by XCH-RTP-016.cisco.com
 (64.101.220.156) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 28 Mar
 2018 16:31:01 -0400
Received: from xch-rtp-020.cisco.com ([64.101.220.160]) by
 XCH-RTP-020.cisco.com ([64.101.220.160]) with mapi id 15.00.1320.000; Wed, 28
 Mar 2018 16:31:01 -0400
From:   "Erik Brady -X (brady - ROBERT HALF INTERNATIONAL INC at Cisco)" 
        <brady@cisco.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Apparent bug in credential tool running...
Thread-Topic: Apparent bug in credential tool running...
Thread-Index: AQHTxsI9w7UvG8AaqkW66sXaczqa96PmP74A//+n0AA=
Date:   Wed, 28 Mar 2018 20:31:01 +0000
Message-ID: <6C6181C9-AA36-4940-94BC-5DB0160C412D@cisco.com>
References: <7898B9A4-D52E-41AD-9162-5B6B401A1AEA@cisco.com>
 <20180328184637.GB16931@sigill.intra.peff.net>
In-Reply-To: <20180328184637.GB16931@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.24.45.247]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CAB53ECD8438C41B22E78C0F50E9A7E@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

U3VyZSwgSSBjYW4gc3VibWl0IGEgcGF0Y2ggaWYgdGhlIGNoYW5nZSBsb29rcyBnb29kIHRvIHlv
dSAod2l0aCBteSBsYWNrIG9mIGV4cGVyaWVuY2UgaW4gdGhlIGdpdCBzb3VyY2UgYW5kIHZlcnkg
cnVzdHkgQyBJIHdvdWxkLCBvZiBjb3Vyc2UsIGRlZmVyIHRvIGFuIGV4cGVydCBpbiB0aGUgYXJl
YSBvbiBleGFjdGx5IHdoZXJlIHRvIHBsYWNlIHRoZSBTSUdQSVBFIGlnbm9yZSBwdXNoIGFuZCBw
b3AgYW5kIHN1Y2guLi4gYnV0IHdoYXQncyBiZWxvdyBzZWVtcyB0byBhdm9pZCB0aGUgcmFjZSBm
b3IgdXMuLi4uIHNvIEkgY2FuIHN1Ym1pdCB0aGF0IGFzLWlzKS4NCg0KVGhhbmtzIGZvciB0aGUg
cXVpY2sgcmVzcG9uc2UhDQpFcmlrDQoNCu+7v09uIDMvMjgvMTgsIDExOjQ2IEFNLCAiSmVmZiBL
aW5nIiA8cGVmZkBwZWZmLm5ldD4gd3JvdGU6DQoNCiAgICBPbiBXZWQsIE1hciAyOCwgMjAxOCBh
dCAwNjoyNjowOFBNICswMDAwLCBFcmlrIEJyYWR5IC1YIChicmFkeSAtIFJPQkVSVCBIQUxGIElO
VEVSTkFUSU9OQUwgSU5DIGF0IENpc2NvKSB3cm90ZToNCiAgICANCiAgICA+IFRoZSBsb2NhdGlv
biBvZiB0aGUgcHJvYmxlbSBpcyBpbiBjcmVkZW50aWFsLmMsIHJ1bl9jcmVkZW50aWFsX2hlbHBl
cigpLi4uIHRoaXMgY29kZToNCiAgICA+IA0KICAgID4gICAgLi4uDQogICAgPiAgICAgZnAgPSB4
ZmRvcGVuKGhlbHBlci5pbiwgInciKTsNCiAgICA+ICAgICBjcmVkZW50aWFsX3dyaXRlKGMsIGZw
KTsNCiAgICA+ICAgICBmY2xvc2UoZnApOw0KICAgID4gICAgLi4NCiAgICA+IA0KICAgID4gV2hp
Y2ggSSB0aGluayBuZWVkcyB0byBiZWNvbWUgc29tZXRoaW5nIGxpa2UgdGhpczoNCiAgICA+IA0K
ICAgID4gICAgIGZwID0geGZkb3BlbihoZWxwZXIuaW4sICJ3Iik7DQogICAgPiAgICAgc2lnY2hh
aW5fcHVzaChTSUdQSVBFLCBTSUdfSUdOKTsNCiAgICA+ICAgICBjcmVkZW50aWFsX3dyaXRlKGMs
IGZwKTsNCiAgICA+ICAgICBmY2xvc2UoZnApOw0KICAgID4gICAgIHNpZ2NoYWluX3BvcChTSUdQ
SVBFKTsNCiAgICA+IA0KICAgID4gVGhlIGJhc2ljcyBhcmUgdGhhdCB3ZSB3cm90ZSBhIGNyZWRl
bnRpYWwgaGVscGVyIGluIEdvIGFuZCwgZm9yIHRoZQ0KICAgID4gc3RvcmUgYWN0aW9uLCBpdCBz
aW1wbHkgZXhpdHMgMC4gIEl0IGlzIGZhc3QuICBUaGlzIGlzIHNpbWlsYXIgdG8gdGhlDQogICAg
PiBleGFtcGxlIGhlcmU6DQogICAgDQogICAgWWVhaCwgdGhhdCBtYWtlcyBzZW5zZS4gR2VuZXJh
bGx5IGEgcGlwZSBidWZmZXIgd291bGQgYmUgcGxlbnR5IHRvIGhvbGQNCiAgICBhIGNyZWRlbnRp
YWwsIGJ1dCB3ZSdyZSByYWNpbmcgYWdhaW5zdCB3aGV0aGVyIHRoZSBvdGhlciBwcm9jZXNzIGV4
aXRzDQogICAgYmVmb3JlIHdlIGV2ZW4gd3JpdGUgYW55dGhpbmcsIHNvIGl0J3MgYm91bmQgdG8g
ZmFpbCBldmVudHVhbGx5IGluIGENCiAgICByYWN5IHdheS4NCiAgICANCiAgICBJIGRvbid0IHRo
aW5rIHdlJ3ZlIGV2ZXIgbWFkZSBhIHByb21pc2VbMV0gYWJvdXQgd2hldGhlciBjcmVkZW50aWFs
DQogICAgaGVscGVycyBoYXZlIHRvIHJlYWQgdGhlaXIgaW5wdXQsIGJ1dCBpdCBtYWtlcyBzZW5z
ZSB0byBtZSBmb3IgR2l0IHRvIGJlDQogICAgZnJpZW5kbHkgYW5kIGhhbmRsZSB0aGlzIGNhc2Uu
IFdlJ3ZlIGRvbmUgc2ltaWxhciB0aGluZ3MgZm9yIGhvb2tzLg0KICAgIA0KICAgIEN1cmlvdXNs
eSwgSSBoYXZlIGEgdmVyeSBzaW1pbGFyIGhlbHBlciBteXNlbGYsIHdoaWNoIEkgZGlkIGFzIGFu
IGlubGluZQ0KICAgIHNoZWxsIHNuaXBwZXQgaW4gbXkgfi8uZ2l0Y29uZmlnOg0KICAgIA0KICAg
ICAgW2NyZWRlbnRpYWwgImh0dHBzOi8vZ2l0aHViLmNvbSJdDQogICAgICB1c2VybmFtZSA9IHBl
ZmYNCiAgICAgIGhlbHBlciA9ICIhZigpIHsgdGVzdCAkMSA9IGdldCAmJiBlY2hvIHBhc3N3b3Jk
PWBwYXNzIHBlZmYvZ2l0aHViL29hdXRoYDsgfTsgZiINCiAgICANCiAgICBJIGd1ZXNzIEkndmUg
bmV2ZXIgbG9zdCB0aGUgcmFjZSBiZWNhdXNlIG9mIHRoZSBzaGVlciBudW1iZXIgb2YNCiAgICBz
dWItcHJvY2Vzc2VzIHRoYXQgZ2V0IHNwYXduZWQgKHNoZWxsIHRvICJwYXNzIiB3aGljaCBpcyBp
dHNlbGYgYSBzaGVsbA0KICAgIHNjcmlwdCwgd2hpY2ggc3Bhd25zIGdwZyAtLSB5aWtlcyEpLg0K
ICAgIA0KICAgIERvIHlvdSB3YW50IHRvIHNlbmQgeW91ciBjaGFuZ2UgYXMgYSBwYXRjaD8gVGhl
cmUncyBzb21lIGd1aWRhbmNlIGluDQogICAgRG9jdW1lbnRhdGlvbi9TdWJtaXR0aW5nUGF0Y2hl
cy4NCiAgICANCiAgICAtUGVmZg0KICAgIA0KICAgIFsxXSBJIGtub3cgeW91IHB1bGxlZCBhIHNp
bWlsYXIgZXhhbXBsZSBmcm9tIHRoZSBQcm8gR2l0IGJvb2sgY29udGVudCwNCiAgICAgICAgd2hp
Y2ggd2UgbWlycm9yIG9uIGdpdC1zY20uY29tLiAgVGhlIHF1YWxpdHkgdGhlcmUgaXMgdXN1YWxs
eSBxdWl0ZQ0KICAgICAgICBnb29kLCBidXQgSSBkb24ndCBjb25zaWRlciBpdCBhcyBhdXRob3Jp
dGF0aXZlIGFzIHRoZSBtYW5wYWdlcy4gOikNCiAgICANCg0K
