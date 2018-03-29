Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 393011F404
	for <e@80x24.org>; Thu, 29 Mar 2018 22:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbeC2WUn (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 18:20:43 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:55755 "EHLO
        rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2WUm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 18:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1960; q=dns/txt; s=iport;
  t=1522362042; x=1523571642;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yz/AgIHsdFThj/I7hGlH42qX4y1QU/MmTJGAZc2Ayes=;
  b=g+JSxFiW6jA2Q7lCUFcBVpksOhoTJXW0UATe+tNcOuqAI0RT/wOv132u
   Vg1xjMJUoYbumqKp7NqUx5uQWbGz5tVLolEjXjr+vwn+czQWR+1WnlSHd
   jWMy5yFG0VOqmFdDJsL/08o8f0WwB0Bhazp8QStRt9PPTcjGOtkdoHBEd
   w=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0D1AABPZb1a/51dJa1dGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYMXK4FQKAqDUogAjQKBUyGBD5JRgXoLhQQCGoQAITQYAQI?=
 =?us-ascii?q?BAQEBAQECayiFJgEEASMRRRACAQgODAImAgICHRMVEAIEDgWFBQitcIIchFW?=
 =?us-ascii?q?Da4IugQiEPIIaghOBLgyCVodvMIIkApBChnEIAhiOEgqBJYYvhFSPUwIREwG?=
 =?us-ascii?q?BJAEcOIFScBVkAYIYgzEBAguNDm+OMIEXAQE?=
X-IronPort-AV: E=Sophos;i="5.48,378,1517875200"; 
   d="scan'208";a="377261635"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2018 22:20:41 +0000
Received: from XCH-RTP-017.cisco.com (xch-rtp-017.cisco.com [64.101.220.157])
        by rcdn-core-6.cisco.com (8.14.5/8.14.5) with ESMTP id w2TMKfXG027846
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 29 Mar 2018 22:20:41 GMT
Received: from xch-rtp-020.cisco.com (64.101.220.160) by XCH-RTP-017.cisco.com
 (64.101.220.157) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Thu, 29 Mar
 2018 18:20:40 -0400
Received: from xch-rtp-020.cisco.com ([64.101.220.160]) by
 XCH-RTP-020.cisco.com ([64.101.220.160]) with mapi id 15.00.1320.000; Thu, 29
 Mar 2018 18:20:40 -0400
From:   "Erik Brady -X (brady - ROBERT HALF INTERNATIONAL INC at Cisco)" 
        <brady@cisco.com>
To:     Jeff King <peff@peff.net>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] credential: ignore SIGPIPE when writing to credential
 helpers
Thread-Topic: [PATCH] credential: ignore SIGPIPE when writing to credential
 helpers
Thread-Index: AQHTx4f8wM/XnPV0a0K1A8i1pl9TWqPoBEsA//+SsQA=
Date:   Thu, 29 Mar 2018 22:20:40 +0000
Message-ID: <E29A3311-D880-4872-835B-EF082EB2F70C@cisco.com>
References: <20180329175501.GE31833@sigill.intra.peff.net>
 <20180329180056.9941-1-brady@cisco.com>
 <20180329215153.GJ2939@sigill.intra.peff.net>
In-Reply-To: <20180329215153.GJ2939@sigill.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.24.61.214]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD7D0C7FF8C70A4D9AACACB0B0F1FC8B@emea.cisco.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzIEplZmYuDQoNCkkgYXBwcmVjaWF0ZSB5b3VyIHRpbWUuICBRdWljayBRLi4uIGlzIHRo
ZXJlIGEgd2F5IHRvIHRyYWNrIHRoZSBwYXRjaCB0aHJvdWdoIHRvIHJlbGVhc2U/ICBJZiBub3Qg
SSBjYW4ganVzdCBzY2FuIHJlbGVhc2Ugbm90ZXMvZXRjIHNvIG5vIHdvcnJpZXMuDQoNCkNoZWVy
cywNCkVyaWsNCg0K77u/T24gMy8yOS8xOCwgMjo1MSBQTSwgIkplZmYgS2luZyIgPHBlZmZAcGVm
Zi5uZXQ+IHdyb3RlOg0KDQogICAgT24gVGh1LCBNYXIgMjksIDIwMTggYXQgMTE6MDA6NTZBTSAt
MDcwMCwgRXJpayBFIEJyYWR5IHdyb3RlOg0KICAgIA0KICAgID4gVGhlIGNyZWRlbnRpYWwgc3Vi
c3lzdGVtIGNhbiB0cmlnZ2VyIFNJR1BJUEUgd2hlbiB3cml0aW5nIHRvIGFuDQogICAgPiBleHRl
cm5hbCBoZWxwZXIgaWYgdGhhdCBoZWxwZXIgY2xvc2VzIGl0cyBzdGRpbiBiZWZvcmUgcmVhZGlu
ZyB0aGUNCiAgICA+IHdob2xlIGlucHV0LiBOb3JtYWxseSB0aGlzIGlzIHJhcmUsIHNpbmNlIGhl
bHBlcnMgd291bGQgbmVlZCB0byByZWFkDQogICAgPiB0aGF0IGlucHV0IHRvIG1ha2UgYSBkZWNp
c2lvbiBhYm91dCBob3cgdG8gcmVzcG9uZCwgYnV0Og0KICAgID4gDQogICAgPiAxLiBJdCdzIHJl
YXNvbmFibGUgdG8gY29uZmlndXJlIGEgaGVscGVyIHdoaWNoIG9ubHkgaGFuZGxlcyAiZ2V0Ig0K
ICAgID4gICAgd2hpbGUgaWdub3JpbmcgInN0b3JlIi4gIFN1Y2ggYSBoYW5kbGVyIG1pZ2h0IG5v
dCByZWFkIHN0ZGluDQogICAgPiAgICBmb3IgInN0b3JlIiwgdGhlcmVieSByYXBpZGx5IGNsb3Np
bmcgc3RkaW4gdXBvbiBoZWxwZXIgZXhpdC4NCiAgICA+IA0KICAgID4gMi4gQSBicm9rZW4gb3Ig
bWlzYmVoYXZpbmcgaGVscGVyIG1pZ2h0IGV4aXQgaW1tZWRpYXRlbHkuIFRoYXQncyBhbg0KICAg
ID4gICAgZXJyb3IsIGJ1dCBpdCdzIG5vdCByZWFzb25hYmxlIGZvciBpdCB0byB0YWtlIGRvd24g
dGhlIHBhcmVudCBHaXQNCiAgICA+ICAgIHByb2Nlc3Mgd2l0aCBTSUdQSVBFLg0KICAgID4gDQog
ICAgPiBFdmVuIHdpdGggc3VjaCBhIGhlbHBlciwgc2VlaW5nIHRoaXMgcHJvYmxlbSBzaG91bGQg
YmUgcmFyZS4gR2V0dGluZw0KICAgID4gU0lHUElQRSByZXF1aXJlcyB0aGUgaGVscGVyIHJhY2ls
eSBleGl0aW5nIGJlZm9yZSB3ZSd2ZSB3cml0dGVuIHRoZQ0KICAgID4gZmFpcmx5IHNtYWxsIGNy
ZWRlbnRpYWwgb3V0cHV0Lg0KICAgID4gDQogICAgPiBTaWduZWQtb2ZmLWJ5OiBFcmlrIEUgQnJh
ZHkgPGJyYWR5QGNpc2NvLmNvbT4NCiAgICA+IC0tLQ0KICAgID4gIGNyZWRlbnRpYWwuYyB8IDMg
KysrDQogICAgPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KICAgIA0KICAgIFRo
aXMgdmVyc2lvbiBsb29rcyBnb29kIHRvIG1lLiBUaGFua3MhDQogICAgDQogICAgLVBlZmYNCiAg
ICANCg0K
