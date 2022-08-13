Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C373C25B08
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 07:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbiHMH4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMH4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 03:56:19 -0400
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D90413CDB
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 00:56:15 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,233,1654531200"; 
   d="scan'208";a="38810924"
Received: from hk-mbx01.mioffice.cn (HELO xiaomi.com) ([10.56.8.121])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 13 Aug 2022 15:55:32 +0800
Received: from yz-mbx09.mioffice.cn (10.237.88.129) by HK-MBX01.mioffice.cn
 (10.56.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 13 Aug
 2022 15:55:28 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by yz-mbx09.mioffice.cn
 (10.237.88.129) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sat, 13 Aug
 2022 15:55:28 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6]) by
 BJ-MBX01.mioffice.cn ([fe80::5cd6:7afe:4dcf:69a6%9]) with mapi id
 15.02.0986.026; Sat, 13 Aug 2022 15:55:28 +0800
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
Thread-Index: AditV5yCC1rR4WwDR+uOdfckQ0GBIQADD4yAAGB4/fA=
Date:   Sat, 13 Aug 2022 07:55:28 +0000
Message-ID: <08dae83ba1b541adac0fd96e2f99b194@xiaomi.com>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <20220811172219.2308120-1-jonathantanmy@google.com>
In-Reply-To: <20220811172219.2308120-1-jonathantanmy@google.com>
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

PiA+ICAgICAzLiB3aXRoIEdJVF9UUkFDRV9QQUNLRVQ9MS4gV2UgZm91bmQgb24gYmlnIHJlcG9z
aXRvcmllcyAoMjAwSytyZWZzLCA2bSsgb2JqZWN0cykuIEdpdCB3aWxsIHNlbmRzIDQwayB3YW50
Lg0KPiA+ICAgICA0LiBBbmQgd2UgdGhlbiB0cmFjayBvdXIgc2VydmVyKHdoaWNoIGlzIGdlcnJp
dCB3aXRoIGpnaXQpLiBXZSBmb3VuZCB0aGUgc2VydmVyIGlzIGNvdXRpbmcgb2JqZWN0cy4gVGhl
biB3ZSBjaGVjayB0aG9zZSA0MGsgb2JqZWN0cywgbW9zdCBvZiB0aGVtIGFyZSBibG9icyByYXRo
ZXIgdGhhbiBjb21taXQuICh3aGljaCBtZWFucyB0aGV5J3JlIG5vdCBpbiBiaXRtYXApDQo+ID4g
ICAgIDUuIFdlIGJlbGlldmUgdGhhdCdzIHRoZSByb290IGNhdXNlIG9mIG91ciBwcm9ibGVtLiBH
aXQgc2VuZHMgdG9vIG1hbnkgIndhbnQgU0hBMSIgd2hpY2ggYXJlIG5vdCBpbiBiaXRtYXAsIGNh
dXNlIHRoZSBzZXJ2ZXIgdG8gY291bnQgb2JqZWN0cyBmcmVxdWVudGx5LCB3aGljaCB0aGVuIHNs
b3cgZG93biB0aGUgc2VydmVyLg0KPiA+DQo+ID4gV2hhdCB3ZSB3YW50IGlzLCBkb3dubG9hZCB0
aGUgdGhpbmdzIHdlIG5lZWQgdG8gY2hlY2tvdXQgdG8gc3BlY2lmaWMgY29tbWl0LiBCdXQgaWYg
b25lIGNvbW1pdCBjb250YWluIHNvIG1hbnkgb2JqZWN0cyAobGlrZSB1cyAsIDQwayspLiBJdCB0
YWtlcyBtb3JlIHRpbWUgdG8gY291bnRpbmcgdGhhbiBkb3dubG9hZGluZy4NCj4gPiBJcyBpdCBw
b3NzaWJsZSB0byBsZXQgZ2l0IG9ubHkgc2VuZCAiY29tbWl0IHdhbnQiIHJhdGhlciB0aGFuIGFs
bCB0aGUgb2JqZWN0cyBTSEExIG9uZSBieSBvbmU/DQo+DQo+IE9uIGEgdGVjaG5pY2FsIGxldmVs
LCBpdCBtYXkgYmUgcG9zc2libGUgLSBhdCB0aGUgcG9pbnQgaW4gdGhlIEdpdCBjb2RlIHdoZXJl
IHRoZQ0KPiBiYXRjaCBwcmVmZXRjaCBvY2N1cnMsIEknbSBub3Qgc3VyZSBpZiB3ZSBoYXZlIHRo
ZSBjb21taXQsIGJ1dCB3ZSBjb3VsZA0KPiBwbHVtYiB0aGUgY29tbWl0IGluZm9ybWF0aW9uIHRo
ZXJlLiAoV2UgaGF2ZSB0aGUgdHJlZSwgYnV0IHRoaXMgZG9lc24ndCBoZWxwDQo+IHVzIGhlcmUg
YmVjYXVzZSBhcyBmYXIgYXMgSSBrbm93LCB0aGUgdHJlZSB3b24ndCBiZSBpbiB0aGUgYml0bWFw
IHNvIHRoZSBzZXJ2ZXINCj4gd291bGQgbmVlZCB0byBjb3VudCBvYmplY3RzIGFueXdheSwgcmVz
dWx0aW5nIGluIHRoZSBzYW1lIHByb2JsZW0uKQ0KPg0KPiBIb3dldmVyLCBzZW5kaW5nIG9ubHkg
Y29tbWl0cyBhcyB3YW50cyB3b3VsZCBtZWFuIHRoYXQgd2Ugd291bGQgYmUNCj4gZmV0Y2hpbmcg
bW9yZSBibG9icyB0aGFuIG5lZWRlZC4gRm9yIGV4YW1wbGUsIGlmIHdlIHdlcmUgdG8gY2xvbmUg
KHdpdGgNCj4gY2hlY2tvdXQpIGFuZCB0aGVuIGNoZWNrb3V0IEhFQUReLCBzZW5kaW5nIGEgImNv
bW1pdCB3YW50IiBmb3IgdGhlIGxhdHRlcg0KPiBjaGVja291dCB3b3VsZCByZXN1bHQgaW4gYWxs
IGJsb2JzIHJlZmVyZW5jZWQgYnkgdGhlIGNvbW1pdCdzIHRyZWUgYmVpbmcNCj4gZmV0Y2hlZCBh
bmQgbm90IG9ubHkgdGhlIGJsb2JzIHRoYXQgYXJlIGRpZmZlcmVudC4NCg0KSXQgc2VlbXMgeW91
ciBzb2x1dGlvbiByZXF1aXJlIGNoYW5nZXMgZnJvbSBib3RoIHNlcnZlciBzaWRlIGFuZCBjbGll
bnQgc2lkZQ0KV2h5IG5vdCB3ZSBqdXN0IGFkZCBhbm90aGVyIGZpbHRlciwgYWxsb3cgcGFydGlh
bC1jbG9uZSBhbHdheXMgc2VuZHMgY29tbWl0IGxldmVsIHdhbnQ/DQpJZiB3ZSBjaGVja291dCBI
RUFEfjEsIHRoZW4gY2xpZW50IGNhbiBzZW5kICJ3YW50IEhFQUR+MSBIRUFEfjIiLg0KDQo+IE9u
ZSBpZGVhIHRoYXQgd2UgKGF0ICREQVlKT0IpIGhhZCBpcyB0byBzdXBwbHkgYSBjb21taXQgaGlu
dCBzbyB0aGF0IHRoZQ0KPiBzZXJ2ZXIgY2FuIGZpcnN0IHVzZSBiaXRtYXBzIHRvIG5hcnJvdyBk
b3duIHRoZSBvYmplY3RzIHRoYXQgbmVlZCB0byBiZQ0KPiBjaGVja2VkLiBJIGhhZCBhIHByZWxp
bWluYXJ5IHBhdGNoIGZvciB0aGF0IFsxXSBidXQgYXMgb2Ygbm93LCBubyBvbmUgaGFzDQo+IGNv
bnRpbnVlZCBwdXJzdWluZyB0aGF0IGlkZWEuDQo+DQo+IFsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9naXQvMjAyMDEyMTUyMDAyMDcuMTA4MzY1NS0xLWpvbmF0aGFudGFubXlAZ29vZ2xlLmNv
bS8NCiMvKioqKioq5pys6YKu5Lu25Y+K5YW26ZmE5Lu25ZCr5pyJ5bCP57Gz5YWs5Y+455qE5L+d
5a+G5L+h5oGv77yM5LuF6ZmQ5LqO5Y+R6YCB57uZ5LiK6Z2i5Zyw5Z2A5Lit5YiX5Ye655qE5Liq
5Lq65oiW576k57uE44CC56aB5q2i5Lu75L2V5YW25LuW5Lq65Lul5Lu75L2V5b2i5byP5L2/55So
77yI5YyF5ous5L2G5LiN6ZmQ5LqO5YWo6YOo5oiW6YOo5YiG5Zyw5rOE6Zyy44CB5aSN5Yi244CB
5oiW5pWj5Y+R77yJ5pys6YKu5Lu25Lit55qE5L+h5oGv44CC5aaC5p6c5oKo6ZSZ5pS25LqG5pys
6YKu5Lu277yM6K+35oKo56uL5Y2z55S16K+d5oiW6YKu5Lu26YCa55+l5Y+R5Lu25Lq65bm25Yig
6Zmk5pys6YKu5Lu277yBIFRoaXMgZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBj
b25maWRlbnRpYWwgaW5mb3JtYXRpb24gZnJvbSBYSUFPTUksIHdoaWNoIGlzIGludGVuZGVkIG9u
bHkgZm9yIHRoZSBwZXJzb24gb3IgZW50aXR5IHdob3NlIGFkZHJlc3MgaXMgbGlzdGVkIGFib3Zl
LiBBbnkgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVyZWluIGluIGFueSB3YXkg
KGluY2x1ZGluZywgYnV0IG5vdCBsaW1pdGVkIHRvLCB0b3RhbCBvciBwYXJ0aWFsIGRpc2Nsb3N1
cmUsIHJlcHJvZHVjdGlvbiwgb3IgZGlzc2VtaW5hdGlvbikgYnkgcGVyc29ucyBvdGhlciB0aGFu
IHRoZSBpbnRlbmRlZCByZWNpcGllbnQocykgaXMgcHJvaGliaXRlZC4gSWYgeW91IHJlY2VpdmUg
dGhpcyBlLW1haWwgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkgdGhlIHNlbmRlciBieSBwaG9uZSBv
ciBlbWFpbCBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGl0ISoqKioqKi8jDQo=
