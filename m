Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28B4420A2A
	for <e@80x24.org>; Tue, 19 Sep 2017 21:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751370AbdISV1E (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 17:27:04 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:42312 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751309AbdISV1D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 17:27:03 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 2CA7410002E;
        Tue, 19 Sep 2017 21:27:02 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rYfEsRMuzcM8; Tue, 19 Sep 2017 21:27:02 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 16D478002E;
        Tue, 19 Sep 2017 21:27:02 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Tue, 19 Sep 2017 21:27:01 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Tue, 19 Sep 2017 21:27:01 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Ben Peart' <peartben@gmail.com>,
        'Ben Peart' <benpeart@microsoft.com>
CC:     "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v7 06/12] ls-files: Add support in ls-files to display the
 fsmonitor valid bit
Thread-Topic: [PATCH v7 06/12] ls-files: Add support in ls-files to display
 the fsmonitor valid bit
Thread-Index: AQHTMX2B4PBp+DHoukCxcEeYWCLnXqK8m3aggAARvQCAAAMRYA==
Date:   Tue, 19 Sep 2017 21:27:01 +0000
Message-ID: <34effd8a881e497d8f5bdd56acc2285d@exmbdft7.ad.twosigma.com>
References: <20170915192043.4516-1-benpeart@microsoft.com>
 <20170919192744.19224-1-benpeart@microsoft.com>
 <20170919192744.19224-7-benpeart@microsoft.com>
 <37b2e5b4ca1d490b9f50d430b3b420f0@exmbdft7.ad.twosigma.com>
 <f1213833-be5e-4850-0ffa-d063e2d1deb8@gmail.com>
In-Reply-To: <f1213833-be5e-4850-0ffa-d063e2d1deb8@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJlbiBQZWFydCBbbWFpbHRv
OnBlYXJ0YmVuQGdtYWlsLmNvbV0NCj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE5LCAyMDE3
IDQ6NDUgUE0NCj4gVG86IERhdmlkIFR1cm5lciA8RGF2aWQuVHVybmVyQHR3b3NpZ21hLmNvbT47
ICdCZW4gUGVhcnQnDQo+IDxiZW5wZWFydEBtaWNyb3NvZnQuY29tPg0KPiBDYzogYXZhcmFiQGdt
YWlsLmNvbTsgY2hyaXN0aWFuLmNvdWRlckBnbWFpbC5jb207IGdpdEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGdpdHN0ZXJAcG9ib3guY29tOyBqb2hhbm5lcy5zY2hpbmRlbGluQGdteC5kZTsgcGNsb3Vk
c0BnbWFpbC5jb207DQo+IHBlZmZAcGVmZi5uZXQNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyAw
Ni8xMl0gbHMtZmlsZXM6IEFkZCBzdXBwb3J0IGluIGxzLWZpbGVzIHRvIGRpc3BsYXkgdGhlDQo+
IGZzbW9uaXRvciB2YWxpZCBiaXQNCj4gDQo+IA0KPiANCj4gT24gOS8xOS8yMDE3IDM6NDYgUE0s
IERhdmlkIFR1cm5lciB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
Pj4gRnJvbTogQmVuIFBlYXJ0IFttYWlsdG86YmVucGVhcnRAbWljcm9zb2Z0LmNvbV0NCj4gPj4g
U2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDE5LCAyMDE3IDM6MjggUE0NCj4gPj4gVG86IGJlbnBl
YXJ0QG1pY3Jvc29mdC5jb20NCj4gPj4gQ2M6IERhdmlkIFR1cm5lciA8RGF2aWQuVHVybmVyQHR3
b3NpZ21hLmNvbT47IGF2YXJhYkBnbWFpbC5jb207DQo+ID4+IGNocmlzdGlhbi5jb3VkZXJAZ21h
aWwuY29tOyBnaXRAdmdlci5rZXJuZWwub3JnOyBnaXRzdGVyQHBvYm94LmNvbTsNCj4gPj4gam9o
YW5uZXMuc2NoaW5kZWxpbkBnbXguZGU7IHBjbG91ZHNAZ21haWwuY29tOyBwZWZmQHBlZmYubmV0
DQo+ID4+IFN1YmplY3Q6IFtQQVRDSCB2NyAwNi8xMl0gbHMtZmlsZXM6IEFkZCBzdXBwb3J0IGlu
IGxzLWZpbGVzIHRvDQo+ID4+IGRpc3BsYXkgdGhlIGZzbW9uaXRvciB2YWxpZCBiaXQNCj4gPj4N
Cj4gPj4gQWRkIGEgbmV3IGNvbW1hbmQgbGluZSBvcHRpb24gKC1mKSB0byBscy1maWxlcyB0byBo
YXZlIGl0IHVzZQ0KPiA+PiBsb3dlcmNhc2UgbGV0dGVycyBmb3IgJ2ZzbW9uaXRvciB2YWxpZCcg
ZmlsZXMNCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQmVuIFBlYXJ0IDxiZW5wZWFydEBtaWNy
b3NvZnQuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBidWlsdGluL2xzLWZpbGVzLmMgfCA4ICsrKysr
Ky0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IFRoaXMgaXMgc3RpbGwgbWlzc2luZyB0aGUgY29ycmVzcG9uZGluZyBkb2N1
bWVudGF0aW9uIHBhdGNoLg0KPiANCj4gU29ycnkgZm9yIHRoZSBjb25mdXNpb24uDQoNClRoYW5r
cyBmb3IgZm9sbG93aW5nIHVwLg0KDQo+ID4gMTAvMTIgKG5vIHJlcGx5LCBoYXZlbid0IGNoZWNr
ZWQgd2hldGhlciBzYW1lIGlzc3VlIGJ1dCBJIGFzc3VtZSBzYW1lDQo+ID4gaXNzdWUgc2luY2Ug
dGhlIG5ldyBjYXNlIEkgbWVudGlvbmVkIGlzbid0IGFkZGVkKQ0KPiANCj4gSXQgd2Fzbid0IGEg
YnVnIHNvIEkgZGlkbid0ICJmaXgiIGl0LiAgSSBqdXN0IHNlbnQgYW4gZXhwbGFuYXRpb24gYW5k
IHBhdGNoDQo+IGRlbW9uc3RyYXRpbmcgd2h5LiBZb3UgY2FuIGZpbmQgaXQgaGVyZToNCg0KSSB3
YXMgY29uY2VybmVkIGFib3V0IHRoZSBjYXNlIG9mIGFuIHVudHJhY2tlZCBmaWxlIGluc2lkZSBh
IGRpcmVjdG9yeSANCnRoYXQgY29udGFpbnMgbm8gdHJhY2tlZCBmaWxlcy4gIFlvdXIgcGF0Y2gg
aW4gdGhpcyBtYWlsIHRyZWF0cyBkaXIzIGp1c3QgDQpsaWtlIGRpcjEgYW5kIGRpcjIuICBJIHRo
aW5rIHlvdSBvdWdodCB0byB0ZXN0IHRoZSBjYXNlIG9mIGEgZGlyIHdpdGggbm8gDQp0cmFja2Vk
IGZpbGVzLg0KDQpBZnRlciBtb3JlIGNhcmVmdWwgY2hlY2tpbmcsIGl0IGxvb2tzIGxpa2UgdGhp
cyBjYXNlIGRvZXMgd29yaywgYnV0IGl0J3MgDQpzdGlsbCB3b3J0aCB0ZXN0aW5nLg0KDQo=
