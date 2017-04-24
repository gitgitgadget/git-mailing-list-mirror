Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB80207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 14:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1170095AbdDXOSh (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 10:18:37 -0400
Received: from esa1.dell-outbound.iphmx.com ([68.232.153.90]:35972 "EHLO
        esa1.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1169844AbdDXOSf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 24 Apr 2017 10:18:35 -0400
X-Greylist: delayed 681 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Apr 2017 10:18:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=dell.com; i=@dell.com; q=dns/txt; s=smtpout;
  t=1493043050; x=1524579050;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Ef2xW9R0rzSZhlmVUXUh7CTucb7S/7nM+7/30D/B5M=;
  b=nkiU9xPCOUiWrlIV/ptSXB0IICZkT2d0dAOLAwO9GLPg37VslnufZAR7
   Qokig6+lwSzQcdWlfnWz7hgSK9iMMUr9/oly7Pzy0wHNW2MzQypOk8p95
   36kOVA4iCTkiG7Adaz36bjPDa5jm4HqPWznmPvOGK/40Ph8PzwNqBLr2s
   M=;
Received: from esa5.dell-outbound2.iphmx.com ([68.232.153.203])
  by esa1.dell-outbound.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2017 09:01:12 -0500
From:   "taylor, david" <David.Taylor@dell.com>
Received: from mailuogwhop.emc.com ([168.159.213.141])
  by esa5.dell-outbound2.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2017 20:02:57 +0600
Received: from maildlpprd03.lss.emc.com (maildlpprd03.lss.emc.com [10.253.24.35])
        by mailuogwprd04.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id v3OE7Ba7028331
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 24 Apr 2017 10:07:12 -0400
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd04.lss.emc.com v3OE7Ba7028331
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=emc.com; s=jan2013;
        t=1493042832; bh=geSRPvJBIJG95tjY2B+Vc451OXs=;
        h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding:MIME-Version;
        b=tHsHAMudP2p6QNlU8Vj8EF1qcciHySf+hrGLXdoyrXJlM0pNShxrg4ONthrA+UmRi
         BcBW8w+PSxQKwEZdN9/Int4P2270jl3nXjxNR97OTUDdVmQXYoNuaC3al3NLEJg407
         1OiNOB7FIkeR3iLTxbKLZdAu1gvYNEPRy5g0Re/o=
X-DKIM: OpenDKIM Filter v2.4.3 mailuogwprd04.lss.emc.com v3OE7Ba7028331
Received: from mailusrhubprd54.lss.emc.com (mailusrhubprd54.lss.emc.com [10.106.48.19]) by maildlpprd03.lss.emc.com (RSA Interceptor); Mon, 24 Apr 2017 10:06:53 -0400
Received: from MXHUB202.corp.emc.com (MXHUB202.corp.emc.com [10.253.68.28])
        by mailusrhubprd54.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with ESMTP id v3OE704J001865
        (version=TLSv1.2 cipher=AES128-SHA256 bits=128 verify=FAIL);
        Mon, 24 Apr 2017 10:07:00 -0400
Received: from MX203CL03.corp.emc.com ([fe80::4dee:b763:b476:8fbc]) by
 MXHUB202.corp.emc.com ([10.253.68.28]) with mapi id 14.03.0266.001; Mon, 24
 Apr 2017 10:06:59 -0400
To:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
CC:     Git Mailing List <git@vger.kernel.org>
Subject: RE: [PATCH] worktree add: add --lock option
Thread-Topic: [PATCH] worktree add: add --lock option
Thread-Index: AQHStKhKcWigKBrcdUyLP3pp/L0hrqHFGAaAgA+CwPA=
Date:   Mon, 24 Apr 2017 14:06:59 +0000
Message-ID: <63F1AEE13FAE864586D589C671A6E18B0D23F9@MX203CL03.corp.emc.com>
References: <63F1AEE13FAE864586D589C671A6E18B0CFBF7@MX203CL03.corp.emc.com>
 <20170412135805.29837-1-pclouds@gmail.com>
 <xmqqy3v3orc3.fsf@gitster.mtv.corp.google.com>
 <CACsJy8D_S+KNTxLp7QT5KzvCmdjuQZ++saYAaikkO7beRDwzJQ@mail.gmail.com>
In-Reply-To: <CACsJy8D_S+KNTxLp7QT5KzvCmdjuQZ++saYAaikkO7beRDwzJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.238.48.71]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Sentrion-Hostname: mailusrhubprd54.lss.emc.com
X-RSA-Classifications: public
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQo+IEZyb206IER1eSBOZ3V5ZW4gW21haWx0bzpwY2xvdWRzQGdtYWlsLmNvbV0NCj4gU2VudDog
RnJpZGF5LCBBcHJpbCAxNCwgMjAxNyA5OjAxIEFNDQo+IFRvOiBKdW5pbyBDIEhhbWFubw0KPiBD
YzogR2l0IE1haWxpbmcgTGlzdDsgdGF5bG9yLCBkYXZpZA0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSB3b3JrdHJlZSBhZGQ6IGFkZCAtLWxvY2sgb3B0aW9uDQo+IA0KPiBPbiBGcmksIEFwciAxNCwg
MjAxNyBhdCA1OjUwIEFNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2JveC5jb20+DQo+IHdy
b3RlOg0KPiA+IE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXkgIDxwY2xvdWRzQGdtYWlsLmNvbT4g
d3JpdGVzOg0KPiA+DQo+ID4+IEFzIGV4cGxhaW5lZCBpbiB0aGUgZG9jdW1lbnQuIFRoaXMgb3B0
aW9uIGhhcyBhbiBhZHZhbnRhZ2Ugb3ZlciB0aGUNCj4gPj4gY29tbWFuZCBzZXF1ZW5jZSAiZ2l0
IHdvcmt0cmVlIGFkZCAmJiBnaXQgd29ya3RyZWUgbG9jayI6IHRoZXJlIHdpbGwgYmUNCj4gPj4g
bm8gZ2FwIHRoYXQgc29tZWJvZHkgY2FuIGFjY2lkZW50YWxseSAicHJ1bmUiIHRoZSBuZXcgd29y
a3RyZWUgKG9yDQo+IHNvb24sDQo+ID4+IGV4cGxpY2l0bHkgIndvcmt0cmVlIHJlbW92ZSIgaXQp
Lg0KPiA+Pg0KPiA+PiAid29ya3RyZWUgYWRkIiBkb2VzIGtlZXAgYSBsb2NrIG9uIHdoaWxlIGl0
J3MgcHJlcGFyaW5nIHRoZSB3b3JrdHJlZS4NCj4gPj4gSWYgLS1sb2NrIGlzIHNwZWNpZmllZCwg
dGhpcyBsb2NrIHJlbWFpbnMgYWZ0ZXIgdGhlIHdvcmt0cmVlIGlzIGNyZWF0ZWQuDQo+ID4+DQo+
ID4+IFN1Z2dlc3RlZC1ieTogRGF2aWQgVGF5bG9yIDxEYXZpZC5UYXlsb3JAZGVsbC5jb20+DQo+
ID4+IFNpZ25lZC1vZmYtYnk6IE5ndXnhu4VuIFRow6FpIE5n4buNYyBEdXkgPHBjbG91ZHNAZ21h
aWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gIEEgcGF0Y2ggdGhhdCBhZGRzIC0tbG9jayBtYXkgbG9v
ayBsaWtlIHRoaXMuDQo+ID4NCj4gPiBUaGlzIGxvb2tzIG1vcmUgbGlrZSAiSSBkbyBiZWxpZXZl
IHRoZSBpZGVhIGJ5IERhdmlkIGlzIGEgdXNlZnVsDQo+ID4gYWRkaXRpb24gYW5kIGhlcmUgaXMg
aG93IEkgZGlkIGl0IHRvIHRoZSBiZXN0IG9mIG15IGFiaWxpdHktLS1sZXQncw0KPiA+IG1ha2Ug
c3VyZSB3ZSBwb2xpc2ggaXQgZm9yIGV2ZW50dWFsIGluY2x1c2lvbiIgdGhhbiBhIG1lcmUgIml0
IG1heQ0KPiA+IGxvb2sgbGlrZSBzby0tLWRvIHdoYXRldmVyIHlvdSB3YW50IHdpdGggaXQiIHBh
dGNoLg0KPiANCj4gSXQgaXMgYSBnb29kIGFkZGl0aW9uLCB3aGljaCBpcyB3aHkgSSBhZGRlZCB0
ZXN0cyBhbmQgZG9jdW1lbnRzLCBzbyBpdA0KPiBtYXkgaGF2ZSBhIGNoYW5jZSBmb3IgaW5jbHVz
aW9uLiBJIHdvdWxkIG5vdCBzdHJvbmdseSBkZWZlbmQgaXQgdGhvdWdoDQo+IGlmIHRoZXJlJ3Mg
b2JqZWN0aW9uLg0KPiANCj4gPiBUbyBtZSAiZ2l0IHdvcmt0cmVlIGFkZCAtLWxvY2siIHNvbWVo
b3cgc291bmRzIGxlc3MgY29ycmVjdCB0aGFuDQo+ID4gImdpdCB3b3JrdHJlZSBhZGQgLS1sb2Nr
ZWQiLCBidXQgSSdkIGFwcHJlY2lhdGUgaWYgbmF0aXZlcyBjYW4NCj4gPiBjb3JyZWN0IG1lLg0K
PiANCj4gVGhhdCB3YXMgbXkgZmlyc3QgY2hvaWNlIHRvby4gVGhlbiBJIHNhdyAtLWRldGFjaCAo
aW5zdGVhZCBvZg0KPiAtLWRldGFjaGVkKS4gSSBkaWRuJ3QgY2FyZSBtdWNoIGFuZCB3ZW50IHdp
dGggYSB2ZXJiIGxpa2UgdGhlIHJlc3QuDQoNCldoaWxlIEkgcGVyc29uYWxseSB3b3VsZCBwcmVm
ZXIgLS1sb2NrZWQsIEkgYWxzbyBwcmVmZXIga2VlcGluZyBpdCAncGFyYWxsZWwNCmNvbnN0cnVj
dGlvbicgd2l0aCAtLWRldGFjaC4gIFRoYXQgaXMgZWl0aGVyIFstLWRldGFjaF1bLS1sb2NrXSBv
cg0KWy0tZGV0YWNoZWRdWy0tbG9ja2VkXS4gIEJ1dCwgdWx0aW1hdGVseSwgbXkgaW50ZW5kZWQg
IHVzZSBpcyB3aXRoaW4gYSBzY3JpcHQsDQpzbyBldmVuIGlmIGl0IHdhcyAtLXRvdGFsbHktbm9u
LW1uZW1vbmljLW9wdGlvbiBJIHdvdWxkIGNvcGUuDQoNCkEgc3Ryb25nZXIgZGVzaXJlLCByZWdh
cmRsZXNzIG9mIHdoZXRoZXIgaXQncyBEdXkncyBpbXBsZW1lbnRhdGlvbiwgbWluZSwgb3INCnNv
bWVvbmUgZWxzZXMsIGlzIHRvIGhhdmUgc29tZXRoaW5nIGFjY2VwdGFibGUgdG8gdGhlIGNvbW11
bml0eSBzbyB0aGF0DQp3ZSBhcmUgbm90IG1haW50YWluaW5nIGEgZm9yayB3aXRoIHRoZSBhdHRl
bmRhbnQgbmVlZCB0byBtZXJnZSBjaGFuZ2VzDQppbiBlYWNoIHRpbWUgd2UgdXBncmFkZS4NCg0K
PiAtLQ0KPiBEdXkNCg==
