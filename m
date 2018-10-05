Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851311F97E
	for <e@80x24.org>; Fri,  5 Oct 2018 16:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbeJEXxJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 19:53:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:27498 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbeJEXxJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 19:53:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 09:53:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,345,1534834800"; 
   d="scan'208";a="79038688"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga008.jf.intel.com with ESMTP; 05 Oct 2018 09:53:36 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.116]) by
 ORSMSX107.amr.corp.intel.com ([169.254.1.14]) with mapi id 14.03.0319.002;
 Fri, 5 Oct 2018 09:53:35 -0700
From:   "Keller, Jacob E" <jacob.e.keller@intel.com>
To:     Jeff King <peff@peff.net>,
        =?utf-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
CC:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: RE: [PATCH v3] coccicheck: process every source file at once
Thread-Topic: [PATCH v3] coccicheck: process every source file at once
Thread-Index: AQHUWovas3IlG4cLg0Kfw7gNupZ+aqUM2lkAgAOJHoCAAK4SAIAAPriA//+SNmA=
Date:   Fri, 5 Oct 2018 16:53:35 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5884CCBED2@ORSMSX115.amr.corp.intel.com>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
 <20181005162517.GB11254@sigill.intra.peff.net>
In-Reply-To: <20181005162517.GB11254@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjg4ODBmNzAtN2ZiMi00YzE2LTlhM2QtYjBjMWJkYWE5MjU5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZHNKT1BQRmlSTklQSTh6QWFJR3VOMzJLYmI4ekpicDZUc3doeGR2cE1NajBDaGxJQWpsS1p3RnA5M0VFUUsyNiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZWZmIEtpbmcgW21haWx0bzpw
ZWZmQHBlZmYubmV0XQ0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMDUsIDIwMTggOToyNSBBTQ0K
PiBUbzogU1pFREVSIEfDoWJvciA8c3plZGVyLmRldkBnbWFpbC5jb20+DQo+IENjOiBKYWNvYiBL
ZWxsZXIgPGphY29iLmtlbGxlckBnbWFpbC5jb20+OyBLZWxsZXIsIEphY29iIEUNCj4gPGphY29i
LmUua2VsbGVyQGludGVsLmNvbT47IEdpdCBtYWlsaW5nIGxpc3QgPGdpdEB2Z2VyLmtlcm5lbC5v
cmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIGNvY2NpY2hlY2s6IHByb2Nlc3MgZXZlcnkg
c291cmNlIGZpbGUgYXQgb25jZQ0KPiANCj4gT24gRnJpLCBPY3QgMDUsIDIwMTggYXQgMDI6NDA6
NDhQTSArMDIwMCwgU1pFREVSIEfDoWJvciB3cm90ZToNCj4gDQo+ID4gT24gVGh1LCBPY3QgMDQs
IDIwMTggYXQgMDc6MTc6NDdQTSAtMDcwMCwgSmFjb2IgS2VsbGVyIHdyb3RlOg0KPiA+ID4gSnVu
aW8sIGRvIHlvdSB3YW50IG1lIHRvIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2Ugb24gbXkgc2lk
ZSB3aXRoIHRoZQ0KPiA+ID4gbWVtb3J5IGNvbmNlcm5zPyBPciBjb3VsZCB5b3UgdXBkYXRlIGl0
IHRvIG1lbnRpb24gbWVtb3J5IGFzIGEgbm90ZWQNCj4gPiA+IHRyYWRlIG9mZi4NCj4gPg0KPiA+
IFdlIGhhdmUgYmVlbiBydW5uaW5nICdtYWtlIC1qMiBjb2NjaWNoZWNrJyBpbiB0aGUgc3RhdGlj
IGFuYWx5c2lzDQo+ID4gYnVpbGQgam9iIG9uIFRyYXZpcyBDSSwgd2hpY2ggd29ya2VkIGp1c3Qg
ZmluZSBzbyBmYXIuICBUaGUgVHJhdmlzIENJDQo+ID4gYnVpbGQgZW52aXJvbm1lbnRzIGhhdmUg
M0dCIG9mIG1lbW9yeSBhdmFpbGFibGUgWzFdLCBidXQsIGFzIHNob3duIGluDQo+ID4gWzJdLCB3
aXRoIHRoaXMgcGF0Y2ggdGhlIG1lbW9yeSBjb25zdW1wdGlvbiBqdW1wcyB1cCB0byBhYm91dA0K
PiA+IDEuMy0xLjhHQiBmb3IgZWFjaCBvZiB0aG9zZSBqb2JzLiAgU28gd2l0aCB0d28gcGFyYWxs
ZWwgam9icyB3ZSB3aWxsDQo+ID4gdmVyeSBsaWtlbHkgYnVtcCBpbnRvIHRoaXMgbGltaXQuDQo+
ID4NCj4gPiBTbyB0aGlzIHBhdGNoIHNob3VsZCBkZWZpbml0ZWx5IGNoYW5nZSB0aGF0IGJ1aWxk
IHNjcmlwdCB0byBydW4gb25seSBhDQo+ID4gc2luZ2xlIGpvYi4NCj4gDQo+IEl0IHNob3VsZCBz
dGlsbCBiZSBhIG5ldCB3aW4sIHNpbmNlIHRoZSB0b3RhbCBDUFUgc2VlbXMgdG8gZHJvcCBieSBh
DQo+IGZhY3RvciBvZiAzLTQuDQo+IA0KPiBBcmUgd2UgT0sgd2l0aCBzYXlpbmcgMS4zLTEuOEdC
IGlzIG5lY2Vzc2FyeSB0byBydW4gY29jY2ljaGVjaz8gVGhhdA0KPiBkb2Vzbid0IGZlZWwgbGlr
ZSBhbiBleG9yYml0YW50IHJlcXVlc3QgZm9yIGEgZGV2ZWxvcGVyLW9ubHkgdG9vbCB0aGVzZQ0K
PiBkYXlzLCBidXQgSSBoYXZlIG5vdGljZWQgc29tZSBwZW9wbGUgb24gdGhlIGxpc3QgdGVuZCB0
byBoYXZlIGxvdXNpZXINCj4gbWFjaGluZXMgdGhhbiBJIGRvLiA7KQ0KPiANCj4gLVBlZmYNCg0K
SXQncyBwcm9iYWJseSBub3Qgd29ydGggdHJ5aW5nIHRvIG1ha2UgdGhpcyBtb3JlIGNvbXBsaWNh
dGVkIGFuZCBzY2FsZSB1cCBob3cgbWFueSBmaWxlcyB3ZSBkbyBhdCBvbmNlIGJhc2VkIG9uIHRo
ZSBhbW91bnQgb2YgYXZhaWxhYmxlIG1lbW9yeSBvbiB0aGUgc3lzdGVtLi4uDQoNClRoYW5rcywN
Ckpha2UNCg==
