Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E849FC19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 11:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbiHMLlx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 07:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMLlw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 07:41:52 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8496019C2C
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 04:41:48 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,233,1654531200"; 
   d="scan'208";a="38841505"
Received: from hk-mbx03.mioffice.cn (HELO xiaomi.com) ([10.56.8.123])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 13 Aug 2022 19:41:47 +0800
Received: from BJ-MBX13.mioffice.cn (10.237.8.133) by HK-MBX03.mioffice.cn
 (10.56.8.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 13 Aug
 2022 19:41:46 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX13.mioffice.cn
 (10.237.8.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Sat, 13 Aug
 2022 19:41:46 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6]) by
 BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6%9]) with mapi id
 15.02.0986.026; Sat, 13 Aug 2022 19:41:46 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     Jonathan Tan <jonathantanmy@google.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?utf-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: =?utf-8?B?5Zue5aSNOiBbRXh0ZXJuYWwgTWFpbF1SZTogUGFydGlhbC1jbG9uZSBjYXVz?=
 =?utf-8?Q?e_big_performance_impact_on_server?=
Thread-Topic: [External Mail]Re: Partial-clone cause big performance impact on
 server
Thread-Index: AditV5yCC1rR4WwDR+uOdfckQ0GBIQADD4yAAGB4/fAACMRq0A==
Date:   Sat, 13 Aug 2022 11:41:46 +0000
Message-ID: <5ad4e3134df444908a548a52f43b90e1@xiaomi.com>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <20220811172219.2308120-1-jonathantanmy@google.com>
 <08dae83ba1b541adac0fd96e2f99b194@xiaomi.com>
In-Reply-To: <08dae83ba1b541adac0fd96e2f99b194@xiaomi.com>
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

QW5vdGhlciB0aGluZyBJIG5lZWQgdG8gcG9pbnQgb3V0IGlzLCBjdXJyZW50IHBhcnRpYWwtY2xv
bmUgYWxzbyBoYXZlIGJpZyBwZXJmb3JtYW5jZSBpbXBhY3Qgb24gZGlza3MuIEVzcGVjaWFsbHkg
b24gU01SIGRpc2tzLg0KU29tZSBvZiBTTVIgZGlzayBoYXMgcmVhbGx5IGJhZCByYW5kb20gd3Jp
dGUgcGVyZm9ybWFuY2UgKGxpa2UgMTAwa2IvcykuDQpXZSBmb3VuZCB0eXBpY2FsbHkgaXQgdGFr
ZXMgdXMgNTAgbWludXRlcyB0byBkb3dubG9hZCB3aG9sZSBBbmRyb2lkIHByb2plY3QgYnkgcGFy
dGlhbC1jbG9uZSAoMiBob3VycyBhbmQgYSBoYWxmIHdpdGhvdXQgcGFydGlhbC1jbG9uZSkNCkhv
d2V2ZXIgaXQgdGFrZXMgdXMgNSBob3VycyB0byBkb3dubG9hZCB3aXRoIHBhcnRpYWwtY2xvbmUg
b24gdGhvc2UgU01SIGRpc2tzLg0KDQpUaGF0J3MgYWxzbyBiZWNhdXNlIHRoZSBiaWcgbnVtYmVy
IHdhbnRzIG1ha2UgdGhlIGRvd25sb2FkIHByb2Nlc3MgdG8gYmUgbWFkZSBvZiByYW5kb20gd3Jp
dGVzIHJhdGhlciB0aGFuIHNlcXVlbmNlIHdyaXRlcy4NCg0KPiA+ID4gICAgIDMuIHdpdGggR0lU
X1RSQUNFX1BBQ0tFVD0xLiBXZSBmb3VuZCBvbiBiaWcgcmVwb3NpdG9yaWVzICgyMDBLK3JlZnMs
IDZtKyBvYmplY3RzKS4gR2l0IHdpbGwgc2VuZHMgNDBrIHdhbnQuDQo+ID4gPiAgICAgNC4gQW5k
IHdlIHRoZW4gdHJhY2sgb3VyIHNlcnZlcih3aGljaCBpcyBnZXJyaXQgd2l0aCBqZ2l0KS4gV2Ug
Zm91bmQgdGhlDQo+IHNlcnZlciBpcyBjb3V0aW5nIG9iamVjdHMuIFRoZW4gd2UgY2hlY2sgdGhv
c2UgNDBrIG9iamVjdHMsIG1vc3Qgb2YgdGhlbSBhcmUNCj4gYmxvYnMgcmF0aGVyIHRoYW4gY29t
bWl0LiAod2hpY2ggbWVhbnMgdGhleSdyZSBub3QgaW4gYml0bWFwKQ0KPiA+ID4gICAgIDUuIFdl
IGJlbGlldmUgdGhhdCdzIHRoZSByb290IGNhdXNlIG9mIG91ciBwcm9ibGVtLiBHaXQgc2VuZHMg
dG9vIG1hbnkgIndhbnQgU0hBMSIgd2hpY2ggYXJlIG5vdCBpbiBiaXRtYXAsIGNhdXNlIHRoZSBz
ZXJ2ZXIgdG8gY291bnQgb2JqZWN0cyBmcmVxdWVudGx5LCB3aGljaCB0aGVuIHNsb3cgZG93biB0
aGUgc2VydmVyLg0KPiA+ID4NCj4gPiA+IFdoYXQgd2Ugd2FudCBpcywgZG93bmxvYWQgdGhlIHRo
aW5ncyB3ZSBuZWVkIHRvIGNoZWNrb3V0IHRvIHNwZWNpZmljIGNvbW1pdC4gQnV0IGlmIG9uZSBj
b21taXQgY29udGFpbiBzbyBtYW55IG9iamVjdHMgKGxpa2UgdXMgLCA0MGsrKS4gSXQgdGFrZXMg
bW9yZSB0aW1lIHRvIGNvdW50aW5nIHRoYW4gZG93bmxvYWRpbmcuDQo+ID4gPiBJcyBpdCBwb3Nz
aWJsZSB0byBsZXQgZ2l0IG9ubHkgc2VuZCAiY29tbWl0IHdhbnQiIHJhdGhlciB0aGFuIGFsbCB0
aGUgb2JqZWN0cyBTSEExIG9uZSBieSBvbmU/DQo+ID4NCj4gPiBPbiBhIHRlY2huaWNhbCBsZXZl
bCwgaXQgbWF5IGJlIHBvc3NpYmxlIC0gYXQgdGhlIHBvaW50IGluIHRoZSBHaXQNCj4gPiBjb2Rl
IHdoZXJlIHRoZSBiYXRjaCBwcmVmZXRjaCBvY2N1cnMsIEknbSBub3Qgc3VyZSBpZiB3ZSBoYXZl
IHRoZQ0KPiA+IGNvbW1pdCwgYnV0IHdlIGNvdWxkIHBsdW1iIHRoZSBjb21taXQgaW5mb3JtYXRp
b24gdGhlcmUuIChXZSBoYXZlIHRoZQ0KPiA+IHRyZWUsIGJ1dCB0aGlzIGRvZXNuJ3QgaGVscCB1
cyBoZXJlIGJlY2F1c2UgYXMgZmFyIGFzIEkga25vdywgdGhlIHRyZWUNCj4gPiB3b24ndCBiZSBp
biB0aGUgYml0bWFwIHNvIHRoZSBzZXJ2ZXIgd291bGQgbmVlZCB0byBjb3VudCBvYmplY3RzDQo+
ID4gYW55d2F5LCByZXN1bHRpbmcgaW4gdGhlIHNhbWUgcHJvYmxlbS4pDQo+ID4NCj4gPiBIb3dl
dmVyLCBzZW5kaW5nIG9ubHkgY29tbWl0cyBhcyB3YW50cyB3b3VsZCBtZWFuIHRoYXQgd2Ugd291
bGQgYmUNCj4gPiBmZXRjaGluZyBtb3JlIGJsb2JzIHRoYW4gbmVlZGVkLiBGb3IgZXhhbXBsZSwg
aWYgd2Ugd2VyZSB0byBjbG9uZQ0KPiA+ICh3aXRoDQo+ID4gY2hlY2tvdXQpIGFuZCB0aGVuIGNo
ZWNrb3V0IEhFQUReLCBzZW5kaW5nIGEgImNvbW1pdCB3YW50IiBmb3IgdGhlDQo+ID4gbGF0dGVy
IGNoZWNrb3V0IHdvdWxkIHJlc3VsdCBpbiBhbGwgYmxvYnMgcmVmZXJlbmNlZCBieSB0aGUgY29t
bWl0J3MNCj4gPiB0cmVlIGJlaW5nIGZldGNoZWQgYW5kIG5vdCBvbmx5IHRoZSBibG9icyB0aGF0
IGFyZSBkaWZmZXJlbnQuDQo+DQo+IEl0IHNlZW1zIHlvdXIgc29sdXRpb24gcmVxdWlyZSBjaGFu
Z2VzIGZyb20gYm90aCBzZXJ2ZXIgc2lkZSBhbmQgY2xpZW50IHNpZGUNCj4gV2h5IG5vdCB3ZSBq
dXN0IGFkZCBhbm90aGVyIGZpbHRlciwgYWxsb3cgcGFydGlhbC1jbG9uZSBhbHdheXMgc2VuZHMg
Y29tbWl0DQo+IGxldmVsIHdhbnQ/DQo+IElmIHdlIGNoZWNrb3V0IEhFQUR+MSwgdGhlbiBjbGll
bnQgY2FuIHNlbmQgIndhbnQgSEVBRH4xIEhFQUR+MiIuDQo+DQo+ID4gT25lIGlkZWEgdGhhdCB3
ZSAoYXQgJERBWUpPQikgaGFkIGlzIHRvIHN1cHBseSBhIGNvbW1pdCBoaW50IHNvIHRoYXQNCj4g
PiB0aGUgc2VydmVyIGNhbiBmaXJzdCB1c2UgYml0bWFwcyB0byBuYXJyb3cgZG93biB0aGUgb2Jq
ZWN0cyB0aGF0IG5lZWQNCj4gPiB0byBiZSBjaGVja2VkLiBJIGhhZCBhIHByZWxpbWluYXJ5IHBh
dGNoIGZvciB0aGF0IFsxXSBidXQgYXMgb2Ygbm93LA0KPiA+IG5vIG9uZSBoYXMgY29udGludWVk
IHB1cnN1aW5nIHRoYXQgaWRlYS4NCj4gPg0KPiA+IFsxXQ0KPiA+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2dpdC8yMDIwMTIxNTIwMDIwNy4xMDgzNjU1LTEtDQo+IGpvbmF0aGFudGFubXlAZ29v
DQo+ID4gZ2xlLmNvbS8NCiMvKioqKioq5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ5bCP57Gz
5YWs5Y+455qE5L+d5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit
5YiX5Ye655qE5Liq5Lq65oiW576k57uE44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul5Lu75L2V
5b2i5byP5L2/55So77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW6YOo5YiG5Zyw5rOE6Zyy
44CB5aSN5Yi244CB5oiW5pWj5Y+R77yJ5pys6YKu5Lu25Lit55qE5L+h5oGv44CC5aaC5p6c5oKo
6ZSZ5pS25LqG5pys6YKu5Lu277yM6K+35oKo56uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R
5Lu25Lq65bm25Yig6Zmk5pys6YKu5Lu277yBIFRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVu
dHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBYSUFPTUksIHdoaWNoIGlz
IGludGVuZGVkIG9ubHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMg
bGlzdGVkIGFib3ZlLiBBbnkgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWlu
IGluIGFueSB3YXkgKGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0
aWFsIGRpc2Nsb3N1cmUsIHJlcHJvZHVjdGlvbiwgb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29u
cyBvdGhlciB0aGFuIHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYg
eW91IHJlY2VpdmUgdGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRl
ciBieSBwaG9uZSBvciBlbWFpbCBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0ISoqKioqKi8jDQo=
