Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D192ECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 11:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbiIELR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 07:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiIELR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 07:17:27 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F6A657205
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 04:17:24 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,291,1654531200"; 
   d="scan'208";a="29255913"
Received: from hk-mbx12.mioffice.cn (HELO xiaomi.com) ([10.56.21.122])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 05 Sep 2022 19:17:23 +0800
Received: from yz-mbx07.mioffice.cn (10.237.88.127) by HK-MBX12.mioffice.cn
 (10.56.21.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 5 Sep 2022
 19:17:22 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by yz-mbx07.mioffice.cn
 (10.237.88.127) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 5 Sep 2022
 19:17:22 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218]) by
 BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218%9]) with mapi id
 15.02.0986.029; Mon, 5 Sep 2022 19:17:22 +0800
From:   =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?utf-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
Subject: RE: [External Mail]Re: Partial-clone cause big performance impact on
 server
Thread-Topic: [External Mail]Re: Partial-clone cause big performance impact on
 server
Thread-Index: AditV5yCC1rR4WwDR+uOdfckQ0GBIQCDyEaAA5jIzsAABGhigADPW5cQ
Date:   Mon, 5 Sep 2022 11:17:21 +0000
Message-ID: <d5305274b7c24adbaf6ad9ab92ac3b6a@xiaomi.com>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <YviaoXRctE9fg/mB@coredump.intra.peff.net>
 <b0101e7e0e61496a92c2299454c2696a@xiaomi.com>
 <YxDbfXyWzgokb1Bq@coredump.intra.peff.net>
In-Reply-To: <YxDbfXyWzgokb1Bq@coredump.intra.peff.net>
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

U29ycnksIEkgdG9sZCB5b3UgdGhlIHdyb25nIGJyYW5jaC4gSXQgc2hvdWxkIGJlICJhbmRyb2lk
LXQtcHJldmlldy0xIg0KZ2l0IGNsb25lIC0tZmlsdGVyPWJsb2I6bm9uZSAtLW5vLWxvY2FsIC1i
IGFuZHJvaWQtdC1wcmV2aWV3LTEgZ3JhZGUtcGx1Z2luDQoNCkNhbiB5b3UgdHJ5IHRoaXMgb25l
Pw0KDQo+ID4gQXQgZmlyc3QgSSBhbHNvIHRoaW5rIGl0J3Mgc29tZSBpbXBsZW1lbnRhdGlvbiBi
dWdzIGJ5IGpnaXQuIEhvd2V2ZXIgSQ0KPiA+IGNhbiBhbHNvIHJlcHJvZHVjZSBpdCBvbiBjZ2l0
LiBIZXJlIGlzIHRoZSBzdGVwcywgSSdtIG5vdCBzdXJlIGlmIHlvdQ0KPiA+IGNhbiByZXByb2R1
Y2UgdG9vLg0KPiA+DQo+ID4gMS4gQ2xvbmUgYSByZXBvc2l0b3J5IGZyb20gQU9TUCB0byBsb2Nh
bCBtYWNoaW5lOiAgYGdpdCBjbG9uZQ0KPiA+DQo+ID4gImh0dHBzOi8vYW5kcm9pZC5nb29nbGVz
b3VyY2UuY29tL3BsYXRmb3JtL3ByZWJ1aWx0cy9ncmFkbGUtcGx1Z2luImANCj4gPiAyLiB0cnkg
dG8gY2xvbmUgZnJvbSBsb2NhbGhvc3QgdXNpbmcgY2dpdCBzZXJ2ZXIuDQo+ID4gICAgYEdJVF9U
UkFDRV9QQUNLRVQ9MSBnaXQgY2xvbmUgLS1maWx0ZXI9YmxvYjpub25lIC1iIG1hc3Rlcg0KPiA+
ICAgIHVzZXJAbG9jYWxob3N0Oi9ob21lL3VzZXIvcmVwb3NpdG9yaWVzL2dyYWRsZS1wbHVnaW4g
YCAzLiBEdXJpbmcNCj4gPiBjaGVja291dCBwaGFzZSwgaXQgYWxzbyB0YWtlcyAxNSBzZWNvbmRz
IGJlZm9yZSBhY3R1YWwgZG93bmxvYWRpbmcuDQo+DQo+IEkgZG9uJ3Qgc2VlIHRoYXQgYXQgYWxs
LiBBIGZldyB0aGluZ3Mgb24geW91ciByZXByb2R1Y3Rpb246DQo+DQo+ICAgLSB5b3UgaGF2ZSB0
byB0ZWxsIHRoZSBsb2NhbCBzZXJ2ZXIgcmVwbyB0aGF0IGZpbHRlcnMgYXJlIE9LOg0KPg0KPiAg
ICAgICBnaXQgLUMgZ3JhZGxlLXBsdWdpbiBjb25maWcgdXBsb2FkcGFjay5hbGxvd2ZpbHRlciB0
cnVlDQo+DQo+ICAgLSB5b3VyIGV4YW1wbGUgZ29lcyBvdmVyIGxvY2FsaG9zdCBzc2guIElzIHlv
dXIgc2VydmVyIGNvbmZpZ3VyZWQgdG8NCj4gICAgIGFsbG93IHBhc3NpbmcgdGhlIEdJVF9QUk9U
T0NPTCBlbnZpcm9ubWVudCB2YXJpYWJsZT8gSWYgbm90LCB5b3UncmUNCj4gICAgIHVzaW5nIHRo
ZSB2MCBwcm90b2NvbC4gSW4gd2hpY2ggY2FzZSB5b3UnbGwgaGF2ZSB0byBzZXQgYSBjb25maWcN
Cj4gICAgIG9wdGlvbiB0byBhbGxvdyBjbGllbnRzIHRvIGZldGNoIG9iamVjdHMgdGhhdCB0aGUg
c2VydmVyIGRpZG4ndA0KPiAgICAgYWR2ZXJ0aXNlLg0KPg0KPiAgICAgSWYgeW91IGRvIGl0IHdp
dGggYWxsb3dSZWFjaGFibGVTSEExSW5XYW50LCBsaWtlIHRoaXM6DQo+DQo+ICAgICAgIGdpdCAt
QyBncmFkbGUtcGx1Z2luIGNvbmZpZyB1cGxvYWRwYWNrLmFsbG93UmVhY2hhYmxlU0hBMUluV2Fu
dCB0cnVlDQo+DQo+ICAgICB0aGVuIHRoZXJlIHdpbGwgYmUgYSBzaG9ydCBkZWxheSB3aGlsZSBp
dCBjaGVja3MgdGhlaXINCj4gICAgIHJlYWNoYWJpbGl0eS4gVGhhdCBjaGVjayBoYXBwZW5zIHZp
YSBhbiBleHRlcm5hbCByZXYtbGlzdC4gSSB0aGluaw0KPiAgICAgaXQncyBub3QgY2xldmVyIGVu
b3VnaCB0byB1c2UgYml0bWFwcywgdGhvdWdoIGl0IGNvdWxkLiBIb3dldmVyLCBpbg0KPiAgICAg
dGhpcyBleGFtcGxlLCB0aGUgZGVsYXkgb25seSBzZWVtcyB0byBiZSBhcm91bmQgODAwbXMgZm9y
IG1lIChhbmQgb2YNCj4gICAgIGNvdXJzZSB3ZSBkaWRuJ3QgZ2VuZXJhdGUgYml0bWFwcyBhbnl3
YXksIHNvIHRoYXQgd291bGRuJ3QgbWF0dGVyKS4NCj4NCj4gICAgIElmIHlvdSBpbnN0ZWFkIGRv
Og0KPg0KPiAgICAgICBnaXQgLUMgZ3JhZGxlLXBsdWdpbiBjb25maWcgdXBsb2FkcGFjay5hbGxv
d0FueVNIQTFJbldhbnQgdHJ1ZQ0KPg0KPiAgICAgdGhlbiB0aGF0IHJlYWNoYWJpbGl0eSBjaGVj
ayBnb2VzIGF3YXkuDQo+DQo+ICAgICBCdXQgb24gbW9kZXJuIHNlcnZlcnMsIG1vc3Qgb2YgdGhp
cyBzaG91bGQgYmUgbW9vdCBhbnl3YXkuIEENCj4gICAgIHdlbGwtY29uZmlndXJlZCBzZXJ2ZXIg
c2hvdWxkIHN1cHBvcnQgcHJvdG9jb2wgdjIsIHdoaWNoIGRlZmF1bHRzIHRvDQo+ICAgICBhbGxv
d0FueVNIQTFJbldhbnQuDQo+DQo+ICAgICBJZiB5b3UgdXNlIC0tbm8tbG9jYWwgdG8gZGlzYWJs
ZSBsb2NhbC1jbG9uZSBvcHRpbWl6YXRpb25zLCB0aGVuIHlvdQ0KPiAgICAgY2FuIHVzZSAtLWZp
bHRlciB3aXRob3V0IGhhdmluZyB0byBnbyB0aHJvdWdoIHNzaC4gVGhhdCBzaG91bGQgdXNlDQo+
ICAgICBwcm90b2NvbCB2ZXJzaW9uIDIsIGFzIGEgInJlYWwiIHNlcnZlciB3b3VsZC4NCj4NCj4g
U28gYWxsIHRvbGQsIEkgdGhpbmsgYSBtb3JlIHJlYWxpc3RpYyByZXByb2R1Y3Rpb24gaXM6DQo+
DQo+ICAgJCBnaXQgY2xvbmUgaHR0cHM6Ly9hbmRyb2lkLmdvb2dsZXNvdXJjZS5jb20vcGxhdGZv
cm0vcHJlYnVpbHRzL2dyYWRsZS0NCj4gcGx1Z2luDQo+ICAgJCBnaXQgLUMgZ3JhZGxlLXBsdWdp
biBjb25maWcgdXBsb2FkcGFjay5hbGxvd2ZpbHRlciB0cnVlDQo+ICAgJCBnaXQgY2xvbmUgLS1m
aWx0ZXI9YmxvYjpub25lIC0tbm8tbG9jYWwgLWIgbWFzdGVyIGdyYWRlLXBsdWdpbiBmb28NCj4N
Cj4gd2hpY2ggdGFrZXMgfjNzIGZvciBtZS4NCj4NCj4gSSBkbyB0aGluayB1cGxvYWQtcGFjayBz
cGVuZHMgbW9yZSB0aW1lIHRoYW4gaXQgbmVlZHMgaW4gdGhpcyBjYXNlLCBhcyBpdCdzDQo+IGtl
ZW4gdG8gY2FsbCBwYXJzZV9vYmplY3QoKSBvbiBvaWRzIHRoYXQgdGhlIGNsaWVudCBhc2tzIGZv
ci4gV2hpY2ggbWVhbnMgd2UnbGwNCj4gb3BlbiB1cCB0aG9zZSBibG9icyBhbmQgY2hlY2sgdGhl
aXIgc2hhMXMgYmVmb3JlIHNlbmRpbmcgdGhlbSBvdXQsIHdoaWNoDQo+IGlzbid0IHN0cmljdGx5
IG5lY2Vzc2FyeS4NCj4NCj4gQWxsIG9mIHRoaXMgc2VlbXMgb3J0aG9nb25hbCB0byB0aGUgb3Jp
Z2luYWwgY2xhaW0gdGhhdCAiQ291bnRpbmcgb2JqZWN0cyIgd2FzDQo+IHRha2luZyBhIHdoaWxl
LCB0aG91Z2guIFRoZSBkZWxheXMgaGVyZSBhcmUgYWxsIGluc2lkZSB1cGxvYWQtcGFjaywgYmVm
b3JlIGl0DQo+IHNwYXducyBwYWNrLW9iamVjdHMuIEFuZCBpdCdzIHBhY2stb2JqZWN0cyB0aGF0
IHNheXMgIkNvdW50aW5nIG9iamVjdHMiLg0KPg0KPiAtUGVmZg0KIy8qKioqKirmnKzpgq7ku7bl
j4rlhbbpmYTku7blkKvmnInlsI/nsbPlhazlj7jnmoTkv53lr4bkv6Hmga/vvIzku4XpmZDkuo7l
j5HpgIHnu5nkuIrpnaLlnLDlnYDkuK3liJflh7rnmoTkuKrkurrmiJbnvqTnu4TjgILnpoHmraLk
u7vkvZXlhbbku5bkurrku6Xku7vkvZXlvaLlvI/kvb/nlKjvvIjljIXmi6zkvYbkuI3pmZDkuo7l
hajpg6jmiJbpg6jliIblnLDms4TpnLLjgIHlpI3liLbjgIHmiJbmlaPlj5HvvInmnKzpgq7ku7bk
uK3nmoTkv6Hmga/jgILlpoLmnpzmgqjplJnmlLbkuobmnKzpgq7ku7bvvIzor7fmgqjnq4vljbPn
lLXor53miJbpgq7ku7bpgJrnn6Xlj5Hku7bkurrlubbliKDpmaTmnKzpgq7ku7bvvIEgVGhpcyBl
LW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlv
biBmcm9tIFhJQU9NSSwgd2hpY2ggaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBl
bnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQgYWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9y
bWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxp
bWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlzY2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBk
aXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVyIHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVu
dChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwg
cGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBob25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFu
ZCBkZWxldGUgaXQhKioqKioqLyMNCg==
