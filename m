Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A28E1FC44
	for <e@80x24.org>; Mon,  8 May 2017 15:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdEHP6U (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 11:58:20 -0400
Received: from mxo1.nje.dmz.twosigma.com ([208.77.214.160]:33619 "EHLO
        mxo1.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdEHP6T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 11:58:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTP id A4EC1100048;
        Mon,  8 May 2017 15:58:12 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QtmsfWYW6Wm6; Mon,  8 May 2017 15:58:12 +0000 (GMT)
Received: from exmbdft5.ad.twosigma.com (exmbdft5.ad.twosigma.com [172.22.1.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.nje.dmz.twosigma.com (Postfix) with ESMTPS id 927E88002E;
        Mon,  8 May 2017 15:58:12 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft5.ad.twosigma.com (172.22.1.56) with Microsoft SMTP Server (TLS) id
 15.0.1263.5; Mon, 8 May 2017 15:58:12 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%19]) with mapi id
 15.00.1263.000; Mon, 8 May 2017 15:58:12 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Christian Couder' <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
CC:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, "Ben Peart" <benpeart@microsoft.com>
Subject: RE: [PATCH 0/1] Preserve the untracked cache across checkout, reset
 --hard, etc
Thread-Topic: [PATCH 0/1] Preserve the untracked cache across checkout, reset
 --hard, etc
Thread-Index: AQHSx+Oao8T8fZ2aokWWu52bk1RBw6Hqk5Yw
Date:   Mon, 8 May 2017 15:58:12 +0000
Message-ID: <2c0be7c0a8ce4f5ea49dfaf3f8511bc0@exmbdft7.ad.twosigma.com>
References: <cover.1494236457.git.johannes.schindelin@gmx.de>
 <CAP8UFD3qoeQE5ZbFHGLE-_B4rOr3X2m-WPB7rb8QAbZA6zMRxg@mail.gmail.com>
In-Reply-To: <CAP8UFD3qoeQE5ZbFHGLE-_B4rOr3X2m-WPB7rb8QAbZA6zMRxg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.11]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Q2FuIHlvdSBhY3R1YWxseSBrZWVwIHRoZSBlbWFpbCBhZGRyZXNzIGFzIG15IFR3b3BlbnNvdXJj
ZSBvbmU/ICBJIHdhbnQgdG8gbWFrZSBzdXJlIHRoYXQgVHdpdHRlciwgbXkgZW1wbG95ZXIgYXQg
dGhlIHRpbWUsIGdldHMgY3JlZGl0IGZvciB0aGlzIHdvcmsgKGp1c3QgYXMgSSB3YW50IHRvIG1h
a2Ugc3VyZSB0aGF0IG15IGN1cnJlbnQgZW1wbG95ZXIsIFR3byBTaWdtYSwgZ2V0cyBjcmVkaXQg
Zm9yIG15IGN1cnJlbnQgd29yaykuDQoNClBsZWFzZSBmZWVsIGZyZWUgdG8gYWRkIFNpZ25lZC1v
ZmYtYnk6IERhdmlkIFR1cm5lciA8ZHR1cm5lckB0d29zaWdtYS5jb20+IGluIGNhc2UgdGhhdCBt
YWtlcyB0cmFja2luZyBlYXNpZXIuDQoNClRoYW5rcy4NCg0KV1JUIHRoZSBhY3R1YWwgcGF0Y2gs
IEkgd2FudCB0byBub3RlIHRoYXQgcGFzdCBtZSBkaWQgbm90IGRvIGEgZ3JlYXQgam9iIGhlcmUu
ICBUaGUgdGVzdHMgZG8gbm90IGNvcnJlY3RseSBjaGVjayB0aGF0IHRoZSBwb3N0LWNoZWNrb3V0
IHVudHJhY2tlZCBjYWNoZSBpcyBzdGlsbCB2YWxpZCBhZnRlciBhIGNoZWNrb3V0LiAgRm9yIGV4
YW1wbGUsIGxldCdzIHNheSB0aGF0IHByZXZpb3VzbHksIHRoZSBkaXJlY3RvcnkgZm9vIHdhcyBl
bnRpcmVseSB1bnRyYWNrZWQgKGJ1dCBpdCBjb250YWluZWQgYSBmaWxlIGJhciksIGJ1dCBhZnRl
ciB0aGUgY2hlY2tvdXQsIHRoZXJlIGlzIGEgZmlsZSBmb28vYmF6LiAgRG9lcyB0aGUgdW50cmFj
a2VkIGNhY2hlIG5lZWQgdG8gZ2V0IHVwZGF0ZWQ/ICANCg0KVW5mb3J0dW5hdGVseSwgdGhlIHVu
dHJhY2tlZCBjYWNoZSBpcyB2ZXJ5IHVubGlrZWx5IHRvIG1ha2UgaXQgdG8gdGhlIHRvcCBvZiBt
eSBwcmlvcml0eSBsaXN0IGFueSB0aW1lIHNvb24sIHNvIEkgd29uJ3QgYmUgYWJsZSB0byBjb3Jy
ZWN0IHRoaXMgdGVzdCAoYW5kLCBpZiBuZWNlc3NhcnksIGNvcnJlY3QgdGhlIGNvZGUpLiAgICBC
dXQgSSB3b3VsZCBzdHJvbmdseSBzdWdnZXN0IHRoYXQgdGhlIHRlc3QgYmUgaW1wcm92ZWQgYmVm
b3JlIHRoaXMgY29kZSBpcyBtZXJnZWQuDQoNClRoYW5rcyBmb3IgQ0NpbmcgbWUuDQoNCj4gLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0aWFuIENvdWRlciBbbWFpbHRv
OmNocmlzdGlhbi5jb3VkZXJAZ21haWwuY29tXQ0KPiBTZW50OiBNb25kYXksIE1heSA4LCAyMDE3
IDY6MTIgQU0NCj4gVG86IEpvaGFubmVzIFNjaGluZGVsaW4gPGpvaGFubmVzLnNjaGluZGVsaW5A
Z214LmRlPg0KPiBDYzogZ2l0IDxnaXRAdmdlci5rZXJuZWwub3JnPjsgSnVuaW8gQyBIYW1hbm8g
PGdpdHN0ZXJAcG9ib3guY29tPjsgTmd1eeG7hW4NCj4gVGjDoWkgTmfhu41jIER1eSA8cGNsb3Vk
c0BnbWFpbC5jb20+OyBCZW4gUGVhcnQgPGJlbnBlYXJ0QG1pY3Jvc29mdC5jb20+Ow0KPiBEYXZp
ZCBUdXJuZXIgPERhdmlkLlR1cm5lckB0d29zaWdtYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMC8xXSBQcmVzZXJ2ZSB0aGUgdW50cmFja2VkIGNhY2hlIGFjcm9zcyBjaGVja291dCwgcmVz
ZXQgLS0NCj4gaGFyZCwgZXRjDQo+IA0KPiAoQWRkaW5nIERhdmUgaW4gQ2MgYXMgaXQgbG9va3Mg
bGlrZSBoZSBpcyBpbnZvbHZlZC4pDQo+IA0KPiBPbiBNb24sIE1heSA4LCAyMDE3IGF0IDExOjQx
IEFNLCBKb2hhbm5lcyBTY2hpbmRlbGluDQo+IDxqb2hhbm5lcy5zY2hpbmRlbGluQGdteC5kZT4g
d3JvdGU6DQo+ID4gSSByZWNlbnRseSBzZW50IG91dCBhIHJlcXVlc3QgZm9yIGFzc2lzdGFuY2Us
IGFmdGVyIG5vdGljaW5nIHRoYXQgdGhlDQo+ID4gdW50cmFja2VkIGNhY2hlIGlzIHNpbXBseSB0
aHJvd24gYXdheSBhZnRlciBvcGVyYXRpb25zIHN1Y2ggYXMgYGdpdA0KPiA+IGNoZWNrb3V0YCBv
ciBgZ2l0IHJlc2V0IC0taGFyZGA6DQo+ID4NCj4gPiBodHRwOi8vcHVibGljLWluYm94Lm9yZy9n
aXQvYWxwaW5lLkRFQi4yLjIwLjE3MDUwMzEyMDI0NzAuMzQ4MEB2aXJ0dWFsDQo+ID4gYm94Lw0K
PiA+DQo+ID4gRHV5IHJlc3BvbmRlZCB3aXRoIHNvbWUgaGlnaC1sZXZlbCByZWFzb25pbmcgdGhh
dCBpdCBzaG91bGQgYmUNCj4gPiBwb3NzaWJsZSB0byBzaW1wbHkgcmV1c2UgdGhlIHVudHJhY2tl
ZCBjYWNoZSBkYXRhIHN0cnVjdHVyZSBpbiB0aGUgbmV3DQo+ID4gaW5kZXgsIGFzIGhlIGhhZCBh
IGd1dCBmZWVsaW5nIHRoYXQgIndlIGRvIGludmFsaWRhdGlvbiByaWdodCIuDQo+ID4NCj4gPiBJ
IGRpZCBub3QgaGF2ZSB0aW1lIHRvIGJhY2sgdGhhdCB1cCBieSBhIHRob3JvdWdoIGFuYWx5c2lz
IG9mIHRoZQ0KPiA+IGNvZGUsIGJ1dCBpdCB0dXJucyBvdXQgdGhhdCBpdCBpcyB1bm5lY2Vzc2Fy
eTogQmVuIFBlYXJ0IHBvaW50ZWQgbWUgdG8NCj4gPiBhIHBhdGNoIG9mIERhdmUgVHVybmVyJ3Mg
dGhhdCB3YXMgc3VibWl0dGVkIGFzIHBhcnQgb2YgdGhlIHdhdGNobWFuDQo+ID4gc2VyaWVzLCBh
ZGRyZXNzaW5nIHRoZSB2ZXJ5IGlzc3VlIGFib3V0IHdoaWNoIEkgd2FzIGNvbmNlcm5lZC4NCj4g
Pg0KPiA+IEFuZCBJIHRydXN0IERhdmUgdG8gaGF2ZSB2YWxpZGF0ZWQgdGhlIGlkZWEgdGhhdCB0
aGUgdW50cmFja2VkIGNhY2hlDQo+ID4gaW52YWxpZGF0aW9uICJpcyBkb25lIHJpZ2h0IiBldmVu
IHdoZW4gd2Ugc2ltcGx5IG1vdmUgdGhlIHBvaW50ZXIgdG8gYQ0KPiA+IGRpZmZlcmVudCBpbmRl
eF9zdGF0ZSBzdHJ1Y3QgdGhhbiBvcmlnaW5hbGx5Lg0KPiA+DQo+ID4gU2VlaW5nIGFzIHRoZSB1
bnRyYWNrZWQgY2FjaGUgYmVpbmcgZHJvcHBlZCB1bmNlcmVtb25pb3VzbHkgd2hlbiBpdA0KPiA+
IHNob3VsZCBub3QgYmUgZHJvcHBlZCwgaW4gYSBzdXJwcmlzaW5nIG51bWJlciBvZiBvcGVyYXRp
b25zLCBJIHRoaW5rDQo+ID4gaXQgaXMgYSBzZW5zaWJsZSBjaGFuZ2UsIGFuZCBpbXBvcnRhbnQs
IHRvbywgYW5kIGluZGVwZW5kZW50IGVub3VnaA0KPiA+IGZyb20gdGhlIHdhdGNobWFuIHBhdGNo
ZXMgdG8gbWVyaXQgYmVpbmcgc2VwYXJhdGVkIG91dCBhbmQgYXBwbGllZA0KPiA+IHByZXR0eSBz
b29uLg0KPiA+DQo+ID4gU28gd2hhdCBJIGRpZCB3YXMgc2ltcGx5IHRvIGRyb3AgdGhlIHR3byBs
aW5lcyBmcm9tIHRoaXMgcGF0Y2ggdGhhdA0KPiA+IHJlZmVycmVkIHRvIGluZGV4X3N0YXRlIGZp
ZWxkcyBhZGRlZCBieSBEYXZlJ3Mgd2F0Y2htYW4gcGF0Y2ggc2VyaWVzLg0KPiA+DQo+ID4gUGxl
YXNlIGRvIG5vdCBtaXN0YWtlIHRoaXMgZm9yIGEgc2lnbiB0aGF0IEkgYW0gZGlzaW50ZXJlc3Rl
ZCBpbg0KPiA+IHdhdGNobWFuIHN1cHBvcnQsIGZhciBmcm9tIGl0Li4uIHN0YXkgdHVuZWQgOy0p
DQo+ID4NCj4gPiBPaCwgYW5kIEkgYWRqdXN0ZWQgRGF2ZSdzIGVtYWlsIGFkZHJlc3MuIERhdmUs
IGlzIHRoYXQgb2theT8NCj4gPg0KPiA+IEFzIHdlIGFyZSBpbiBhIGZlYXR1cmUgZnJlZXplIHBo
YXNlLCBJIHdhcyBkZWJhdGluZyB3aGV0aGVyIHRvIHNlbmQNCj4gPiBvdXQgdGhpcyBwYXRjaCBu
b3cgb3IgbGF0ZXIuDQo+ID4NCj4gPiBIYXZpbmcgdGhvdWdodCBhYm91dCBpdCBmb3IgcXVpdGUg
YSBiaXQsIEkgYW0gbm93IGNvbnZpbmNlZCB0aGF0IHRoaXMNCj4gPiBwYXRjaCBmaXhlcyBhIGJ1
ZyBpbiB0aGUgdW50cmFja2VkIGNhY2hlIGZlYXR1cmUgdGhhdCBpcyBzbyBjcml0aWNhbA0KPiA+
IGFzIHRvIHJlbmRlciBpdCB1c2VsZXNzOiBpZiB5b3UNCj4gPg0KPiA+IC0gaGF2ZSB0byBzd2l0
Y2ggYmV0d2VlbiBicmFuY2hlcyBmcmVxdWVudGx5LCBvcg0KPiA+IC0gcmViYXNlIGZyZXF1ZW50
bHkgKHdoaWNoIGNhbGxzIGBnaXQgcmVzZXQgLS1oYXJkYCksIG9yDQo+ID4gLSBzdGFzaCBmcmVx
dWVudGx5ICh3aGljaCBjYWxscyBgZ2l0IHJlc2V0IC0taGFyZGApLA0KPiA+DQo+ID4gaXQgaXMg
YXMgaWYgeW91IGhhZCBub3QgZW5hYmxlZCB0aGUgdW50cmFja2VkIGNhY2hlIGF0IGFsbC4gRXZl
bg0KPiA+IHdvcnNlLCBHaXQgd2lsbCBkbyBhIHRvbiBvZiB3b3JrIHRvIHJlY3JlYXRlIHRoZSB1
bnRyYWNrZWQgY2FjaGUgYW5kDQo+ID4gdG8gc3RvcmUgaXQgYXMgYW4gaW5kZXggZXh0ZW5zaW9u
LCAqanVzdCogdG8gdGhyb3cgdGhlIHVudHJhY2tlZCBhd2F5IGluIHRoZQ0KPiBlbmQuDQo+ID4N
Cj4gPg0KPiA+IERhdmlkIFR1cm5lciAoMSk6DQo+ID4gICB1bnBhY2stdHJlZXM6IHByZXNlcnZl
IGluZGV4IGV4dGVuc2lvbnMNCj4gPg0KPiA+ICBjYWNoZS5oICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMSArDQo+ID4gIHJlYWQtY2FjaGUuYyAgICAgICAgICAgICAgICAgICAgICB8ICA2
ICsrKysrKw0KPiA+ICB0L3Q3MDYzLXN0YXR1cy11bnRyYWNrZWQtY2FjaGUuc2ggfCAyMiArKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIHVucGFjay10cmVlcy5jICAgICAgICAgICAgICAgICAg
ICB8ICAxICsNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspDQo+ID4NCj4g
Pg0KPiA+IGJhc2UtY29tbWl0OiA0ZmE2NmM4NWYxMWJjNWE1NDE0NjJjYTVhZTMyNDZhYTBjZTAy
ZTc0DQo+ID4gUHVibGlzaGVkLUFzOg0KPiA+IGh0dHBzOi8vZ2l0aHViLmNvbS9kc2Noby9naXQv
cmVsZWFzZXMvdGFnL3ByZXNlcnZlLXVudHJhY2tlZC1jYWNoZS12MQ0KPiA+IEZldGNoLUl0LVZp
YTogZ2l0IGZldGNoIGh0dHBzOi8vZ2l0aHViLmNvbS9kc2Noby9naXQNCj4gPiBwcmVzZXJ2ZS11
bnRyYWNrZWQtY2FjaGUtdjENCj4gPg0KPiA+IC0tDQo+ID4gMi4xMi4yLndpbmRvd3MuMi44MDAu
Z2VkZThmMTQ1ZTA2DQo+ID4NCg==
