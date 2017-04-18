Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC95C1FA14
	for <e@80x24.org>; Tue, 18 Apr 2017 17:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757314AbdDRRQz (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 13:16:55 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:47698 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756780AbdDRRQy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 13:16:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id D995E100056;
        Tue, 18 Apr 2017 17:16:52 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sPjSILjZhKHV; Tue, 18 Apr 2017 17:16:52 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id C9D2C8002E;
        Tue, 18 Apr 2017 17:16:52 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Tue, 18 Apr 2017 17:16:52 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Tue, 18 Apr 2017 17:16:52 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Jeff King' <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "mfick@codeaurora.org" <mfick@codeaurora.org>,
        "jacob.keller@gmail.com" <jacob.keller@gmail.com>
Subject: RE: [PATCH] repack: respect gc.pid lock
Thread-Topic: [PATCH] repack: respect gc.pid lock
Thread-Index: AQHStVYFs4jQpN8FG0CoCGa3r9IKNaHJsErwgADQfoCAAOKaQA==
Date:   Tue, 18 Apr 2017 17:16:52 +0000
Message-ID: <2400e9cbfaff4838a8f3b23c4c2c5a22@exmbdft7.ad.twosigma.com>
References: <20170413202712.22192-1-dturner@twosigma.com>
 <20170414193341.itr3ybiiu2brt63b@sigill.intra.peff.net>
 <c6dd37238f154ccea56dda9b43f3277a@exmbdft7.ad.twosigma.com>
 <20170418034157.oi6hkg5obnca5zsa@sigill.intra.peff.net>
In-Reply-To: <20170418034157.oi6hkg5obnca5zsa@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.13]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWZmIEtpbmcgW21haWx0bzpw
ZWZmQHBlZmYubmV0XQ0KPiBTZW50OiBNb25kYXksIEFwcmlsIDE3LCAyMDE3IDExOjQyIFBNDQo+
IFRvOiBEYXZpZCBUdXJuZXIgPERhdmlkLlR1cm5lckB0d29zaWdtYS5jb20+DQo+IENjOiBnaXRA
dmdlci5rZXJuZWwub3JnOyBjaHJpc3RpYW4uY291ZGVyQGdtYWlsLmNvbTsgbWZpY2tAY29kZWF1
cm9yYS5vcmc7DQo+IGphY29iLmtlbGxlckBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gcmVwYWNrOiByZXNwZWN0IGdjLnBpZCBsb2NrDQo+IA0KPiBPbiBNb24sIEFwciAxNywgMjAx
NyBhdCAxMToyOToxOFBNICswMDAwLCBEYXZpZCBUdXJuZXIgd3JvdGU6DQo+IA0KPiA+IFdlIHNh
dyB0aGlzIGZhaWx1cmUgaW4gdGhlIGxvZ3MgbXVsdGlwbGUgIHRpbWVzICh3aXRoIHRocmVlIGRp
ZmZlcmVudA0KPiA+IHNoYXMsIHdoaWxlIGEgZ2Mgd2FzIHJ1bm5pbmcpOg0KPiA+IEFwcmlsIDEy
LCAyMDE3IDA2OjQ1IC0+IEVSUk9SIC0+ICdnaXQgLWMgcmVwYWNrLndyaXRlQml0bWFwcz10cnVl
IHJlcGFjayAtQSAtZA0KPiAtLXBhY2sta2VwdC1vYmplY3RzJyBpbiBbcmVwb10gZmFpbGVkOg0K
PiA+IGZhdGFsOiBwYWNrZmlsZSAuL29iamVjdHMvcGFjay9wYWNrLVtzaGFdLnBhY2sgY2Fubm90
IGJlIGFjY2Vzc2VkDQo+ID4gUG9zc2libHkgc29tZSBvdGhlciByZXBhY2sgd2FzIGFsc28gcnVu
bmluZyBhdCB0aGUgdGltZSBhcyB3ZWxsLg0KPiA+DQo+ID4gTXkgY29sbGVhZ3VlIGFsc28gc2F3
IGl0IHdoaWxlIG1hbnVhbGx5IGRvaW5nIGdjIChhZ2FpbiB3aGlsZSByZXBhY2tzDQo+ID4gd2Vy
ZSBsaWtlbHkgdG8gYmUgcnVubmluZyk6DQo+IA0KPiBUaGlzIGlzIHNvcnQgb2YgYSBzaWRlIHF1
ZXN0aW9uLCBidXQuLi53aHkgYXJlIHlvdSBydW5uaW5nIG90aGVyIHJlcGFja3MgYWxvbmdzaWRl
DQo+IGdpdC1nYz8gSXQgc2VlbXMgbGlrZSB5b3Ugb3VnaHQgdG8gYmUgZG9pbmcgb25lIG9yIHRo
ZSBvdGhlci4NCg0KQnV0IGFjdHVhbGx5LCBpdCB3b3VsZCBiZSBraW5kIG9mIG5pY2UgaWYgZ2l0
IHdvdWxkIGhlbHAgcHJvdGVjdCB1cyBmcm9tIGRvaW5nIHRoaXM/DQo=
