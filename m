Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D5DC54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 14:26:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiI0O0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 10:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiI0OZz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 10:25:55 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BDBD1BE84
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 07:25:49 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,349,1654531200"; 
   d="scan'208";a="31970080"
Received: from hk-mbx01.mioffice.cn (HELO xiaomi.com) ([10.56.8.121])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 27 Sep 2022 22:25:48 +0800
Received: from BJ-MBX17.mioffice.cn (10.237.8.137) by HK-MBX01.mioffice.cn
 (10.56.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 22:25:47 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by BJ-MBX17.mioffice.cn
 (10.237.8.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 27 Sep
 2022 22:25:47 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218]) by
 BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218%9]) with mapi id
 15.02.0986.029; Tue, 27 Sep 2022 22:25:47 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     Carlo Arenas <carenas@gmail.com>, Han Xin <hanxin.hx@bytedance.com>
CC:     "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "derrickstolee@github.com" <derrickstolee@github.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        =?utf-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>
Subject: RE: possible bug with commit-graph causing git to fork bomb (was Re:
 [External Mail]Re: Git fork process infinitely and never stop)
Thread-Topic: possible bug with commit-graph causing git to fork bomb (was Re:
 [External Mail]Re: Git fork process infinitely and never stop)
Thread-Index: AQHYkyqfW8rRbTmyTUC0VnyKJLR31610r+CAgABhBoCAfr6ugA==
Date:   Tue, 27 Sep 2022 14:25:46 +0000
Message-ID: <09cbcb88fb6643ad9d43ffc8f41eb360@xiaomi.com>
References: <20220709002658.vt34nnzhxefg72d3@Carlos-MacBook-Pro-2.local>
 <20220709005227.82423-1-hanxin.hx@bytedance.com>
 <CAPUEspiP=U+pBYm3tx1wPc46He=5WKkdFYCr-58a-UfhAD+PUg@mail.gmail.com>
In-Reply-To: <CAPUEspiP=U+pBYm3tx1wPc46He=5WKkdFYCr-58a-UfhAD+PUg@mail.gmail.com>
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

SSBmb3VuZCBhbm90aGVyIGZvcmsgYm9tYiB3aXRoIHBhcnRpYWwtY2xvbmUgYnV0IG5vdCByZWxh
dGVkIHRvIGNvbW1pdEdyYXBoDQoNCkhlcmUgaXMgdGhlIHZpZGVvOiBodHRwczovL3lvdXR1LmJl
LzNYdW40UFFOUUM0DQoNCkFuZCBoZXJlIGlzIHRoZSB0cmVlIGNvbW1hbmQsIEdJVF9UUkVBQ0Uy
IGFuZCBHSVRfVFJBQ0VfUEFDS0VUIGxvZw0KaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUv
ZC8xbUo0LVVjQTh5dGRqcllMN0s2WHhDdHh5cy1EUlJUcWQvdmlldz91c3A9c2hhcmluZw0KaHR0
cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUvZC8xck9sc2thcDVsMloxTjZMbmFCZ0xoVy1HX1VG
OHp4M1ovdmlldz91c3A9c2hhcmluZw0KaHR0cHM6Ly9kcml2ZS5nb29nbGUuY29tL2ZpbGUvZC8x
empJN0NtNGFYdjNmaFBOM0ZfY3dZMTVVYS1wNG5jRmwvdmlldz91c3A9c2hhcmluZw0KDQpJIHN0
aWxsIGhhdmUgdGhlIHNjZW5lIHdoaWNoIGNhbiByZXByb2R1Y2UgdGhpcyBidWcuIElmIHRoZXJl
IGlzIHNvbWV0aGluZyBlbHNlIEkgY2FuIHByb3ZpZGUsIGZlZWwgZnJlZSB0byBhc2sNCg0KPg0K
PiBPbiBGcmksIEp1bCA4LCAyMDIyIGF0IDU6NTIgUE0gSGFuIFhpbiA8aGFueGluLmh4QGJ5dGVk
YW5jZS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiA+IFRvIGJlIGEgc3VwcGxlbWVudC4NCj4gPiA+
ID4gSWYgSSBkZWxldGUgLmdpdC9vYmplY3RzL2luZm8vY29tbWl0LWdyYXBoLCAgZXZlcnl0aGlu
ZyB3b3JrcyB3ZWxsDQo+ID4gPiA+IEFzIHdlbGwgYXMgZmV0Y2ggd2l0aCBgLWMgY29yZS5jb21t
aXRHcmFwaD1mYWxzZWANCj4gPiA+DQo+ID4gPiBUaGlzIHdvdWxkIHNlZW0gdG8gaW5kaWNhdGUg
dGhhdCBzb21ldGhpbmcgaW4gdGhlIHJlcG9zaXRvcnkgbWlnaHQNCj4gPiA+IGJlIHRyaWdnZXJl
ZCBieSB0aGUgY29tbWl0LWdyYXBoIGNvZGUuDQo+ID4gPg0KPiA+ID4gPiBpZiBJIGV4ZWN1dGUg
YGdpdCBmZXRjaCAtLWZpbHRlcj1ibG9iOm5vbmUgLS1xdWlldCAtLXByb2dyZXNzIG1pdWkgLS1w
cnVuZSAtDQo+IC10YWdzICtyZWZzL2hlYWRzLyo6cmVmcy9yZW1vdGVzL21pdWkvKiArcmVmcy9o
ZWFkcy9taXVpMTMtcy10aG9yLQ0KPiB2ZW5kb3Itc3RhYmxlOnJlZnMvcmVtb3Rlcy9taXVpL21p
dWkxMy1zLXRob3ItdmVuZG9yLXN0YWJsZWAgIG9uIHZlcnNpb24NCj4gMi4yNS4xLiBJdCBqdXN0
IHRocm93IGVycm9yIHJhdGhlciB0aGFuIGluZmluaXRlIGxvb3AsIGxpa2UgdGhpcyB5b3V0dWJl
IHZpZGVvDQo+ICJodHRwczovL3d3dy55b3V0dWJlLmNvbS93YXRjaD92PXF2WVR2VlJFMEZVJmZl
YXR1cmU9eW91dHUuYmUiDQo+ID4gPg0KPiA+ID4gbWF5YmUgYSByZWdyZXNzaW9uPw0KPiA+ID4N
Cj4gPiA+IENhcmxvDQo+ID4NCj4gPiBJIGxvb2tzIGxpa2UgdGhlIHNhbWUgaXNzdWUgSSByZXBv
cnRlZCBpbiBbMV0sIGFuZCB3ZSBjYW4gc2VlIHRoZQ0KPiA+IGZpeHVwIGluIFsyXS4NCj4gPg0K
PiA+IDEuDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvZ2l0LzIwMjIwNjEyMTYxNzA3LjIx
ODA3LTEtY2hpeXV0aWFueWlAZ21haWwuYw0KPiA+IG9tLyAyLg0KPiA+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2dpdC9jb3Zlci4xNjU2NTkzMjc5LmdpdC5oYW54aW4uaHhAYnl0ZWRhbmNlLmMN
Cj4gPiBvbS8NCj4NCj4gSW5kZWVkOyBhbmQgaXQgaXMgYWxyZWFkeSBpbnRlZ3JhdGVkIHRocm91
Z2ggaHgvbG9va3VwLWNvbW1pdC1pbi1ncmFwaC1maXgNCj4gYW5kIG1lcmdlZCBhbGwgdGhlIHdh
eSB0byAibmV4dCIsIHdoaWNoIHdvdWxkIGxpa2VseSBiZWNvbWUgMi4zOCBzb21ldGltZQ0KPiBz
b29uLg0KPg0KPiDnqIvmtIssDQo+DQo+IGlmIHlvdSBjb3VsZCBidWlsZCBhIG5ldyBnaXQgdmVy
c2lvbiBiYXNlZCBvbiBuZXh0IGFuZCBjb25maXJtIGl0IHNvbHZlcyB5b3VyDQo+IHByb2JsZW0s
IGl0IHdvdWxkIGhlbHAgdXMgYWxsLg0KPg0KPiBBbHRlcm5hdGl2ZSBjYW4gZ2V0IHRoYXQgc2lu
Z2xlICJvbmUgbGluZSIgcGF0Y2hbMV0gYW5kIGludGVncmF0ZSBpdCBvbiB0b3Agb2YNCj4gdGhl
IGdpdCB2ZXJzaW9uIHlvdSBhcmUgdXNpbmcuDQo+DQo+IENhcmxvDQo+DQo+IFsxXQ0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9naXQvOTZkNGJiNzE1MDVkODdlZDUwMWMwNThiYmQ4OWJmYzEz
ZDA4YjI0YS4xDQo+IDY1NjU5MzI3OS5naXQuaGFueGluLmh4QGJ5dGVkYW5jZS5jb20vDQojLyoq
KioqKuacrOmCruS7tuWPiuWFtumZhOS7tuWQq+acieWwj+exs+WFrOWPuOeahOS/neWvhuS/oeaB
r++8jOS7hemZkOS6juWPkemAgee7meS4iumdouWcsOWdgOS4reWIl+WHuueahOS4quS6uuaIlue+
pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaL
rOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWIhuWcsOazhOmcsuOAgeWkjeWItuOAgeaIluaVo+WP
ke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OAguWmguaenOaCqOmUmeaUtuS6huacrOmCruS7tu+8
jOivt+aCqOeri+WNs+eUteivneaIlumCruS7tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmC
ruS7tu+8gSBUaGlzIGUtbWFpbCBhbmQgaXRzIGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50
aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01JLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0
aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVz
ZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRp
bmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXBy
b2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50
ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1t
YWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwg
aW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEqKioqKiovIw0K
