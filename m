Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC2EECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 06:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiIAGyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 02:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiIAGyJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 02:54:09 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 23:54:06 PDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C22D1208FD
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 23:54:06 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,280,1654531200"; 
   d="scan'208";a="28858337"
Received: from hk-mbx01.mioffice.cn (HELO xiaomi.com) ([10.56.8.121])
  by outboundhk.mxmail.xiaomi.com with ESMTP; 01 Sep 2022 14:53:03 +0800
Received: from yz-mbx03.mioffice.cn (10.237.88.123) by HK-MBX01.mioffice.cn
 (10.56.8.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 1 Sep 2022
 14:53:02 +0800
Received: from BJ-MBX01.mioffice.cn (10.237.8.121) by yz-mbx03.mioffice.cn
 (10.237.88.123) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 1 Sep 2022
 14:53:02 +0800
Received: from BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218]) by
 BJ-MBX01.mioffice.cn ([fe80::1839:49c8:1d62:7218%9]) with mapi id
 15.02.0986.029; Thu, 1 Sep 2022 14:53:02 +0800
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
Thread-Index: AditV5yCC1rR4WwDR+uOdfckQ0GBIQCDyEaAA5jIzsA=
Date:   Thu, 1 Sep 2022 06:53:01 +0000
Message-ID: <b0101e7e0e61496a92c2299454c2696a@xiaomi.com>
References: <bfa3de4485614badb4a27d8cfba99968@xiaomi.com>
 <YviaoXRctE9fg/mB@coredump.intra.peff.net>
In-Reply-To: <YviaoXRctE9fg/mB@coredump.intra.peff.net>
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

Pg0KPiA+ICAgICA0LiBBbmQgd2UgdGhlbiB0cmFjayBvdXIgc2VydmVyKHdoaWNoIGlzIGdlcnJp
dCB3aXRoIGpnaXQpLiBXZQ0KPiA+ICAgICAgICBmb3VuZCB0aGUgc2VydmVyIGlzIGNvdXRpbmcg
b2JqZWN0cy4gVGhlbiB3ZSBjaGVjayB0aG9zZSA0MGsNCj4gPiAgICAgICAgb2JqZWN0cywgbW9z
dCBvZiB0aGVtIGFyZSBibG9icyByYXRoZXIgdGhhbiBjb21taXQuICh3aGljaA0KPiA+ICAgICAg
ICBtZWFucyB0aGV5J3JlIG5vdCBpbiBiaXRtYXApDQo+ID4gICAgIDUuIFdlIGJlbGlldmUgdGhh
dCdzIHRoZSByb290IGNhdXNlIG9mIG91ciBwcm9ibGVtLiBHaXQgc2VuZHMgdG9vDQo+ID4gICAg
ICAgIG1hbnkgIndhbnQgU0hBMSIgd2hpY2ggYXJlIG5vdCBpbiBiaXRtYXAsIGNhdXNlIHRoZSBz
ZXJ2ZXIgdG8NCj4gPiAgICAgICAgY291bnQgb2JqZWN0cyAgZnJlcXVlbnRseSwgd2hpY2ggdGhl
biBzbG93IGRvd24gdGhlIHNlcnZlci4NCj4NCj4gSSdkIGJlIHN1cnByaXNlZCBpZiBiaXRtYXBz
IG1ha2UgYSBiaWcgZGlmZmVyZW5jZSBlaXRoZXIgd2F5IGhlcmUsIHNpbmNlIGJsb2JzDQo+IGFy
ZSB2ZXJ5IHF1aWNrIGluIHRoZSAiY291bnRpbmciIHBoYXNlIG9mIHBhY2stb2JqZWN0cy4gVGhl
eSBjYW4ndCBsaW5rIHRvDQo+IGFueXRoaW5nIGVsc2UsIHNvIHdlIHNob3VsZCBub3QgYmUgb3Bl
bmluZyB0aGUgb2JqZWN0IGNvbnRlbnRzIGF0IGFsbCEgV2UNCj4ganVzdCBuZWVkIHRvIGZpbmQg
dGhlbSBvbiBkaXNrLCBhbmQgdGhlbiBpbiBtYW55IGNhc2VzIHdlIGNhbiBzZW5kIHRoZW0NCj4g
b3ZlciB0aGUgd2lyZSB3aXRob3V0IGV2ZW4gZGVjb21wcmVzc2luZyAodGhlIGV4Y2VwdGlvbiBp
cyBpZiB0aGV5IGFyZQ0KPiBzdG9yZWQgYXMgZGVsdGFzIGFnYWluc3QgYW4gb2JqZWN0IHRoZSBj
bGllbnQgZG9lc24ndCBoYXZlKS4NCj4NCj4gSSBkaWRuJ3QgZ2VuZXJhdGUgYSB0ZXN0IGNhc2Us
IGJ1dCBJJ20gcHJldHR5IHN1cmUgdGhhdCBpcyBob3cgZ2l0LmdpdCdzIHBhY2stDQo+IG9iamVj
dHMgc2hvdWxkIGJlaGF2ZS4gQnV0IHlvdSBtZW50aW9uZWQgdGhhdCB0aGUgc2VydmVyIGlzIGpn
aXQ7IGl0J3MgcG9zc2libGUNCj4gdGhhdCBpdCBpc24ndCBhcyBvcHRpbWl6ZWQgaW4gdGhhdCBh
cmVhLg0KDQpBdCBmaXJzdCBJIGFsc28gdGhpbmsgaXQncyBzb21lIGltcGxlbWVudGF0aW9uIGJ1
Z3MgYnkgamdpdC4gSG93ZXZlciBJIGNhbiBhbHNvIHJlcHJvZHVjZSBpdCBvbiBjZ2l0LiBIZXJl
IGlzIHRoZSBzdGVwcywgSSdtIG5vdCBzdXJlIGlmIHlvdSBjYW4gcmVwcm9kdWNlIHRvby4NCg0K
MS4gQ2xvbmUgYSByZXBvc2l0b3J5IGZyb20gQU9TUCB0byBsb2NhbCBtYWNoaW5lOiAgYGdpdCBj
bG9uZSAiaHR0cHM6Ly9hbmRyb2lkLmdvb2dsZXNvdXJjZS5jb20vcGxhdGZvcm0vcHJlYnVpbHRz
L2dyYWRsZS1wbHVnaW4iYA0KMi4gdHJ5IHRvIGNsb25lIGZyb20gbG9jYWxob3N0IHVzaW5nIGNn
aXQgc2VydmVyLiAgIGBHSVRfVFJBQ0VfUEFDS0VUPTEgZ2l0IGNsb25lIC0tZmlsdGVyPWJsb2I6
bm9uZSAtYiBtYXN0ZXIgdXNlckBsb2NhbGhvc3Q6L2hvbWUvdXNlci9yZXBvc2l0b3JpZXMvZ3Jh
ZGxlLXBsdWdpbiBgDQozLiBEdXJpbmcgY2hlY2tvdXQgcGhhc2UsIGl0IGFsc28gdGFrZXMgMTUg
c2Vjb25kcyBiZWZvcmUgYWN0dWFsIGRvd25sb2FkaW5nLg0KDQpJdCdzIHJlYWxseSBlYXN5IHRv
IHJlcHJvZHVjZSwgYXMgbG9uZyBhcyB0aGUgcmVwb3NpdG9yeSBoYXMgc28gbWFueSBibG9icyB0
byBjaGVja291dA0KDQo+DQo+IC1QZWZmDQojLyoqKioqKuacrOmCruS7tuWPiuWFtumZhOS7tuWQ
q+acieWwj+exs+WFrOWPuOeahOS/neWvhuS/oeaBr++8jOS7hemZkOS6juWPkemAgee7meS4iumd
ouWcsOWdgOS4reWIl+WHuueahOS4quS6uuaIlue+pOe7hOOAguemgeatouS7u+S9leWFtuS7luS6
uuS7peS7u+S9leW9ouW8j+S9v+eUqO+8iOWMheaLrOS9huS4jemZkOS6juWFqOmDqOaIlumDqOWI
huWcsOazhOmcsuOAgeWkjeWItuOAgeaIluaVo+WPke+8ieacrOmCruS7tuS4reeahOS/oeaBr+OA
guWmguaenOaCqOmUmeaUtuS6huacrOmCruS7tu+8jOivt+aCqOeri+WNs+eUteivneaIlumCruS7
tumAmuefpeWPkeS7tuS6uuW5tuWIoOmZpOacrOmCruS7tu+8gSBUaGlzIGUtbWFpbCBhbmQgaXRz
IGF0dGFjaG1lbnRzIGNvbnRhaW4gY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGZyb20gWElBT01J
LCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVudGl0eSB3aG9zZSBh
ZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3JtYXRpb24gY29udGFp
bmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGltaXRlZCB0bywgdG90
YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRpc3NlbWluYXRpb24p
IGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGlzIHByb2hp
Yml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBwbGVhc2Ugbm90aWZ5
IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5kIGRlbGV0ZSBpdCEq
KioqKiovIw0K
