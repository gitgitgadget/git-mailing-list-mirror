Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D780C433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 08:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376633AbiEFIhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 04:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbiEFIhm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 04:37:42 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 May 2022 01:33:59 PDT
Received: from mail101.atlas-elektronik.com (mail101.atlas-elektronik.com [194.156.172.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9575E56FA4
        for <git@vger.kernel.org>; Fri,  6 May 2022 01:33:58 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2HTFAAM3HRi/zfHxApaHgEBCxIMQAmBSIF6gSSBVoRPk?=
 =?us-ascii?q?QsDgiOIcJFQgXsLAQEBAQEBAQEBBwEBEhMdBAEBhQICFoUjJjsDDQECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEBBQEBAQEBAQYDAQICgRiFL0aGSwEBAgIBIxFVAgEVC?=
 =?us-ascii?q?wICJgICAh8RFRACBAESCBaCB4M8Aw2sLnqBMRpnhG2COA2CTIEQLYFlhC+BJ?=
 =?us-ascii?q?4chglCDPlFugiCFeoJlBJQ3gW0vgQsBT4EqkgODaaoGawedUoVpLhWWWBsDk?=
 =?us-ascii?q?V2WYSCQWZV7AgQCBAUCFoILAYFrcIM4URmcf3U7AgYBCgEBAwmNXgEB?=
IronPort-Data: A9a23:lQnw/6kF/3GSHCBm0QnNab7o5gwpJERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIZUTuAO/rZZzOkeYx3YYXl9U9TsMSDydE3TlZppC82Fy4T+ZvOCP2ndUqhZCn6wu8v7K5EA
 2TyTvGacajYm1eF/k/F3p7J8yUkjclkYZKlULWfakidfSc9FGF5z0gLd9cR2uaEu/Dga++2k
 Y608pS31GONgWYuaDpJs//b9HuDgdyr0N8mlg1mDRx0lAKG/5UlJMp3yXaZdiaQriF8R4ZWd
 s6bpF2L1jqxEyQFU7tJpo3GnngiGdY+C+QuZk1+AMBOijAazsA7Pz1S2PA0MS+7gB3R9zx9J
 UkkWTVdhm7FM4WV8NnxXSW0HAlgELd3yOD/IEKVkvSBzXfkVXDBksxXWRRe0Y0woo6bAEli2
 NwycRYoVkjZweuqxLugD+Roi8c/Ns7tPYBZsXZlpd3bJa9+B8mSHeOTtI4egWpYasNmRJ4yY
 +ICdTdhZRKGZRRCJVo/AY46lfzti33ycCFCr1SUpuw85G27IAlZieOya4uLI7RmQ+0ElBa3n
 lL97VjnPSgQM9mb1T3brCmV07qncSTTHdh6+KeD3vFrnHWNyWEJTh4bT122pb++kEHWZj5EA
 xVMvHN/8+5rpR3tE4SVswCEnUNodyU0A7J4e9DWIinXokYIy2513lQ5cwM=
IronPort-HdrOrdr: A9a23:XW7Mwq1gUAV1UCdytFidiQqjBG0kLtp133Aq2lEZdPUMSL3/qy
 ncpoVj6faSskdtZJhAo6H7BEDuewK/yXcY2+Ys1PKZLW7bUQiTXf1fBOnZsljd8kTFn4Y3v8
 oNT0E9MqyVMbEQt6fHCXyDYrUdKa68kJxA692x815dCS5HL5hn6gdyGkK6PyRNNXZ77NECZe
 KhD4J81kGdRUg=
Received: from unknown (HELO DEHB1NMP02.atlas-elektronik.com) ([10.196.199.55])
  by MGW101FE.atlas.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2022 10:32:53 +0200
Received: from mgw201partner.atlas.de ([10.206.101.60])
        by DEHB1NMP02.atlas-elektronik.com  with ESMTP id 2468Wqev015646-2468Wqex015646
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=CAFAIL)
        for <git@vger.kernel.org>; Fri, 6 May 2022 10:32:53 +0200
Received: from dehb1pex06.atlas.de ([10.248.64.143])
  by mgw201data.atlas.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2022 10:32:52 +0200
Received: from DEHB1PEX04.atlas.de (10.248.64.139) by DEHB1PEX06.atlas.de
 (10.248.64.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 6 May 2022
 10:32:49 +0200
Received: from DEHB1PEX04.atlas.de ([fe80::e9bf:575b:6bb5:cc2f]) by
 DEHB1PEX04.atlas.de ([fe80::e9bf:575b:6bb5:cc2f%5]) with mapi id
 15.02.0986.015; Fri, 6 May 2022 10:32:49 +0200
From:   <stefan.naewe@atlas-elektronik.com>
To:     <christian.gruen@gmail.com>, <git@vger.kernel.org>
Subject: AW: Resizing panels in the gitk window
Thread-Topic: Resizing panels in the gitk window
Thread-Index: AQHYYR1VsIVrksEn/Um9ELVbxNREIa0RhRew
Date:   Fri, 6 May 2022 08:32:49 +0000
Message-ID: <ff856dc509c7424cb7137d9cac318714@atlas-elektronik.com>
References: <CAP94bnOyrx6hCmWSjmejVfopUydk10ga42wJzm1M4nk_OXn9Mg@mail.gmail.com>
 <CAP94bnNbXaZA9pdDspb2ajWk==rSAP0xEAQ4LNfwkzsN7B7Exg@mail.gmail.com>
In-Reply-To: <CAP94bnNbXaZA9pdDspb2ajWk==rSAP0xEAQ4LNfwkzsN7B7Exg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FE-Policy-ID: 1:1:17:SYSTEM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1VcnNwcsO8bmdsaWNoZSBOYWNocmljaHQtLS0tLQ0KPiBWb246IENocmlzdGlh
biBHcsO8biA8Y2hyaXN0aWFuLmdydWVuQGdtYWlsLmNvbT4NCj4gR2VzZW5kZXQ6IEZyZWl0YWcs
IDYuIE1haSAyMDIyIDA5OjQ2DQo+IEFuOiBnaXRAdmdlci5rZXJuZWwub3JnDQo+IEJldHJlZmY6
IFJlOiBSZXNpemluZyBwYW5lbHMgaW4gdGhlIGdpdGsgd2luZG93DQo+IA0KPiBNYXliZSB0aGVy
ZeKAmXMgYSBiZXR0ZXIgcGxhY2UgdG8gYWRkcmVzcyBnaXRrPyBBbnlvbmU/DQo+IFRoYW5rcyAg
aW4gYWR2YW5jZSwgQ2hyaXN0aWFuDQoNCkkgdGhpbmsgaXQgd291bGQgYmUgYSBnb29kIGlkZWEg
dG8gYXQgbGVhc3Qgc2F5IG9uIHdoaWNoIE9TIHlvdSdyZSB1c2luZyBnaXRrDQphbmQgd2hpY2gg
dmVyc2lvbiBvZiBnaXQgaXMgaW5zdGFsbGVkLg0KIA0KUmVnYXJkcywNCiAgU3RlZmFuDQogDQo+
IA0KPiBPbiBUaHUsIE1heSA1LCAyMDIyIGF0IDk6MDEgQU0gQ2hyaXN0aWFuIEdyw7xuIDxjaHJp
c3RpYW4uZ3J1ZW5AZ21haWwuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IFJlc2l6aW5nIHBhbmVs
cyBpbiB0aGUgZ2l0ayB3aW5kb3cgbGVhZHMgdG8gYSBlcnJvciBtZXNzYWdlIHRoYXTigJlzIHBy
ZXNlbnRlZA0KPiBtdWx0aXBsZSB0aW1lcyBpbiBhIGRpYWxvZzoNCj4gPg0KPiA+IGV4cGVjdGVk
IGludGVnZXIgYnV0IGdvdCAiIg0KPiA+IGV4cGVjdGVkIGludGVnZXIgYnV0IGdvdCAiIg0KPiA+
ICAgICB3aGlsZSBleGVjdXRpbmcNCj4gPiAiJHdpbiBzYXNoIHBsYWNlIDAgJHNhc2gwIFtsaW5k
ZXggJHMwIDFdIg0KPiA+ICAgICAocHJvY2VkdXJlICJyZXNpemVjbGlzdHBhbmVzIiBsaW5lIDM4
KQ0KPiA+ICAgICBpbnZva2VkIGZyb20gd2l0aGluDQo+ID4gInJlc2l6ZWNsaXN0cGFuZXMgLnRm
Lmhpc3RmcmFtZS5wd2NsaXN0IDE4MzQiDQo+ID4gICAgIChjb21tYW5kIGJvdW5kIHRvIGV2ZW50
KQ0KPiA+DQo+ID4gSXMgdGhpcyBhIGtub3duIGJ1Zz8NCj4gPg0KPiA+IEnigJlsbCBiZSBoYXBw
eSB0byBnaXZlIG1vcmUgZGV0YWlscy4NCj4gPiBCZXN0LCBDaHJpc3RpYW4NCj4gPg0K
