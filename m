Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C2AC433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 14:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244584AbiFCOk4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 10:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiFCOkz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 10:40:55 -0400
Received: from mail101.atlas-elektronik.com (mail101.atlas-elektronik.com [194.156.172.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0678D48E59
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 07:40:53 -0700 (PDT)
X-IPAS-Result: =?us-ascii?q?A2FrBAAfHZpi/zfHxApaHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?YFGAoMggViET5EQgiOcPwsBAQEBAQEBAQEHAQFCBAEBhQICFoUyJjkFDQECB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBAQEDAQEBBQEBAQEBAQYDAQICgRiFL0aGTAYjEVUCARUNA?=
 =?us-ascii?q?iYCAgIwFRACBAESCLJzgTEaZ4RthRGBESwBgWWFWYckglCBFYNohCyDboJlB?=
 =?us-ascii?q?JZ7HTsDTjQSgSFxAQgGBgcKBTIGAgwYFAQCAxASUx0CEgwKHA5UGQwPAxIDE?=
 =?us-ascii?q?QEHAgsSCBUsCAMCAwgDAgMuAgMXCQcKAx0IChwSEBQCBBMeCwgDGR8tCQIED?=
 =?us-ascii?q?gNDCAsKAxEEAxMYCxYIEAQGAwkvDSgLAwUPDwEGAwYCBQUBAyADFAMFJwcDI?=
 =?us-ascii?q?QcLJg0NBCMdAwMFJgMCAhsHAgIDAgYXBgICcQooDQgECAQcHSUQBQIHMQUEL?=
 =?us-ascii?q?wIeBAUGEQkCFgIGBAUCBAQWAgISCAIIJxsHFjYZAQVdBgsJIRwpEQUGFgMjc?=
 =?us-ascii?q?QVIDyk0ATgkCAEfARuZPFGBKASXYqsKB6NNLhWDdYw+hisbA5FelmggpmoCB?=
 =?us-ascii?q?AIEBQIWgXmBfnBQgmhRGZx/dTsCBgEKAQEDCZAUAQE?=
IronPort-Data: A9a23:j3Dg8arjY+exCihEn5RsgJavDqVeBmKwZxIvgKrLsJaIsI4StFCzt
 garIBmCOfaDZzT9cookaYi0pxgB6p+GyINrHVZtrSk0Qi9B9JacVYWSI27OZC7DdceroGCLT
 yk9hngsCOhuExcwcz/0auCJQV9Ui/3QHtIQL8adYnsvG2eIcA941VQ73bRRbrdA2bBVOSvU0
 T/Ji5CZaQbNNwJcaDpOsfrd8Eg35pwehRtB1rAATaET1LPhvyRNZH4vDfnZw6zQG9Q88kaSH
 o4v/Znhlo/r105F5uCNy94XRnY3rov6ZmBivJb2t5+K2XCurgRqukoy2WF1hU1/011llPgpo
 DlBWADZpa7E8cQglcxEOyS0HR2SMoVa5Yf6I1ORvPe+7G+WTSavmfk2MWsfaNhwFuZfWQmi9
 NQ0BRAnNzamv7rshrunTuB3w8knIcr3JoQZu3ImxjbcZRokacmbBfybu5kBjWZ2250m8fX2P
 qL1bRJ0cBnOahsJPF4aF58Wlfusj2K6fjlVq06Poqw24C7YywkZPL3FaYaEJ4TWGK25mG7Ao
 E7I8TmiGCgWatqwk2Cs73mMj+3QyHaTtIU6UefQGuRRqFKS2kQNBxAME1i2u/+0jgi5Qd03F
 qAP0nN26/FjqgryH4i7AkDQTGO4gyPwkuF4S4USgDxhAIKNi+pFLgDolgJ8VeE=
IronPort-HdrOrdr: A9a23:lM9rTaD1udshqKblHelz55DYdb4zR+YMi2TDj3oBLyC9Afbo7v
 xG+85rqCMc6QxhIk3I9urwWpVoLUmyyXcx2/h3AV7AZnibhILLFvAG0WKK+VSJcEeSmtK1l5
 0QF5SWY+eQMbEOt7eY3ODOKbYdKbe8npyAtKPw4zNVSwRrYbElzyoRMHflLqQ8fng/OXNwLu
 vm2vZ6
Received: from unknown (HELO DEHB1NMP02.atlas-elektronik.com) ([10.196.199.55])
  by MGW101FE.atlas.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 16:40:23 +0200
Received: from mgw202partner.atlas.de ([10.206.101.61])
        by DEHB1NMP02.atlas-elektronik.com  with ESMTP id 253EeNwo006590-253EeNwq006590
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=CAFAIL)
        for <git@vger.kernel.org>; Fri, 3 Jun 2022 16:40:23 +0200
Received: from dehb1pex03.atlas.de ([10.248.64.138])
  by mgw202data.atlas.de with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jun 2022 16:40:22 +0200
Received: from DEHB1PEX04.atlas.de (10.248.64.139) by DEHB1PEX03.atlas.de
 (10.248.64.138) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Fri, 3 Jun 2022
 16:40:22 +0200
Received: from DEHB1PEX04.atlas.de ([fe80::e9bf:575b:6bb5:cc2f]) by
 DEHB1PEX04.atlas.de ([fe80::e9bf:575b:6bb5:cc2f%5]) with mapi id
 15.02.0986.015; Fri, 3 Jun 2022 16:40:22 +0200
From:   <stefan.naewe@atlas-elektronik.com>
To:     <git-ian@mnementh.co.uk>, <git@vger.kernel.org>
Subject: AW: git log on bare repository fails if the default branch is not
 called master
Thread-Topic: git log on bare repository fails if the default branch is not
 called master
Thread-Index: AQHYd1VVYXxgmACa8kCLA95QcgD4tK09wNjg
Date:   Fri, 3 Jun 2022 14:40:22 +0000
Message-ID: <48bcd99afbca4c73b938c3ed4e104c64@atlas-elektronik.com>
References: <a1830e79-9503-3fd9-8c50-a2856206e219@mnementh.co.uk>
In-Reply-To: <a1830e79-9503-3fd9-8c50-a2856206e219@mnementh.co.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FE-Policy-ID: 1:1:17:SYSTEM
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

DQoNCj4gLS0tLS1VcnNwcsO8bmdsaWNoZSBOYWNocmljaHQtLS0tLQ0KPiBWb246IElhbiBNb2x0
b24gPGdpdC1pYW5AbW5lbWVudGguY28udWs+DQo+IEdlc2VuZGV0OiBGcmVpdGFnLCAzLiBKdW5p
IDIwMjIgMTY6MjINCj4gQW46IGdpdEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IElhbiBNb2x0b24g
PGdpdC1pYW5AbW5lbWVudGguY28udWs+DQo+IEJldHJlZmY6IEJVRzogZ2l0IGxvZyBvbiBiYXJl
IHJlcG9zaXRvcnkgZmFpbHMgaWYgdGhlIGRlZmF1bHQgYnJhbmNoIGlzIG5vdCBjYWxsZWQNCj4g
bWFzdGVyDQo+IA0KPiBIaSwNCj4gDQo+IFBsZWFzZSBDQyBtZSBpbiByZXBsaWVzLCBJJ20gbm90
IG9uIHRoZSBsaXN0Lg0KPiANCj4gSSd2ZSBub3RpY2VkIHRoYXQgZ2l0IGxvZyBhc3N1bWVzIHRo
ZSBkZWZhdWx0IGJyYW5jaCBpcyBtYXN0ZXIsIGV2ZW4gaWYgaXQgZG9lc24ndA0KPiBleGlzdC4u
Lg0KPiANCj4gTXkgbGF0ZXN0IHJlcG8gaGFzIGl0IHNldCB0byAibWFpbmxpbmUiIGFuZCBhbGwg
d2FzIHdlbGwgdW50aWwgSSBwdXNoZWQgaXQgdG8gYSBiYXJlDQo+IHJlcG8gb24gbXkgc2VydmVy
Lg0KPiANCj4gRXhwZWN0YXRpb246DQo+IA0KPiBJZiBJIHJ1bg0KPiANCj4gZ2l0IGxvZw0KPiAN
Cj4gaW4gdGhlIGJhcmUgcmVwbywgaXQgc2hvdWxkIGxvZyB0aGUgZGVmYXVsdCAob3Igb25seSEp
IGJyYW5jaC4NCj4gDQo+IFJlYWxpdHk6DQo+IA0KPiBnaXQgbG9nDQo+ICMgZmF0YWw6IHlvdXIg
Y3VycmVudCBicmFuY2ggJ21hc3RlcicgZG9lcyBub3QgaGF2ZSBhbnkgY29tbWl0cyB5ZXQNCg0K
SSBiZXQgdGhlIEhFQUQgZmlsZSBpbiB5b3VyIGJhcmUgcmVwb3NpdG9yeSBwb2ludHMgdG8gcmVm
cy9oZWFkcy9tYXN0ZXIuLi4NCg0KDQpTdGVmYW4NCg==
