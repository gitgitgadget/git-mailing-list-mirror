Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE7FC2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 01:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150B52083B
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 01:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ty7GfE0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgI2BSC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 21:18:02 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:32901 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgI2BSC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 21:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601342282; x=1632878282;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=aVaf2fAlaIFWrGyDiJFZzAaDJMGfUTFY09vGXpyJ8Eo=;
  b=Ty7GfE0xvtWryO83udIJQnV2UwPNZon7KMIRoqiZsmm94Ghm/wNnCFQR
   JqflqOj3Hquu4DyyZTxzqrP3MKZ3zB9LDmi1ISw9zulNQi/3uCYj7Gtaq
   kdvXvTuLZfLD5rMbrNOFjOKT575xve9QwUtaExJCwdwp5wyDButMlodUB
   w=;
X-IronPort-AV: E=Sophos;i="5.77,316,1596499200"; 
   d="scan'208";a="56841978"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 29 Sep 2020 01:18:01 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 54698240FEC
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 01:18:00 +0000 (UTC)
Received: from EX13D20UWA003.ant.amazon.com (10.43.160.97) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 29 Sep 2020 01:18:00 +0000
Received: from EX13D20UWA003.ant.amazon.com (10.43.160.97) by
 EX13D20UWA003.ant.amazon.com (10.43.160.97) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 29 Sep 2020 01:17:59 +0000
Received: from EX13D20UWA003.ant.amazon.com ([10.43.160.97]) by
 EX13D20UWA003.ant.amazon.com ([10.43.160.97]) with mapi id 15.00.1497.006;
 Tue, 29 Sep 2020 01:17:59 +0000
From:   "Wu, Zhichen" <zhwu@amazon.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Question About Git V2 Protocol & SHA256
Thread-Topic: Question About Git V2 Protocol & SHA256
Thread-Index: AQHWlf5ecO6oUvIkOE6Oo7T8lc6CpA==
Date:   Tue, 29 Sep 2020 01:17:59 +0000
Message-ID: <9FC3DDB4-DE6F-45B3-95F9-1048991713A4@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.35]
Content-Type: text/plain; charset="utf-8"
Content-ID: <95A2B6A7BD9F0A46ABB4B2344C395A94@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGkgR2l0IENvbW11bml0eSwNCsKgDQpIb3BlIHRoaXMgZW1haWwgZmluZHMgeW91IHdlbGwuDQrC
oA0KSeKAmW0gWmhpY2hlbiBmcm9tIEFXUyBDb2RlQ29tbWl0LiBJ4oCZbSByZWFjaGluZyBvdXQg
cmVnYXJkaW5nIDIgZ2l0IGZlYXR1cmVzIHRoYXQgd2UgYXJlIHBsYW5uaW5nIGZvciBDb2RlQ29t
bWl0IGFuZCB5b3VyIGlucHV0IHdvdWxkIGJlIGNyaXRpY2FsIGZvciBvdXIgbmV4dCBzdGVwLg0K
DQoxLiBTaW5jZSB2MiBwcm90b2NvbCBoYXMgYmVlbiBsYXVuY2hlZCBmb3IgMiB5ZWFycywgaXMg
dGhlcmUgYW55IHBsYW4gaW4gdGhlIG5lYXIgZnV0dXJlIGFib3V0IHYxIGRlcHJlY2F0aW9uPw0K
Mi4gSSBzZWUgdjIgaGFzIGEgY2FwYWJpbGl0eSBjYWxsZWQg4oCcb2JqZWN0LWZvcm1hdOKAnSB0
aGF0IHByb3ZpZGVzIFNIQTEgb3B0aW9uLiBJ4oCZbSB3b25kZXJpbmcgaWYgdGhhdCBjYXBhYmls
aXR5IHdpbGwgYmUgdGhlIG9ubHkgd2F5IGZvciBjbGllbnQgYW5kIHNlcnZlciB0byBzdGFydCB1
c2luZyBTSEEyNTY/IE9yIHB1dCBpdCBhcyBhbm90aGVyIHdvcmQsIHdpbGwgdjIgcHJvdG9jb2wg
YmUgdGhlIHByZXJlcXVpc2l0ZSBvZiBTSEEyNTY/DQrCoA0KTG9va2luZyBmb3J3YXJkIHRvIGhl
YXJpbmcgYmFjayBmcm9tIHlvdS4NCsKgDQpUaGFua3MgaW4gYWR2YW5jZSENClpoaWNoZW4gV3UN
Cg0KDQo=
