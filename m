Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3391891AA
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748761937; cv=fail; b=P1n6NXHy+MmLcQaSAT0A4f0igIt06rfVwKEJhGAJWvqLc+nkIikK3FRt2o8PdZbAdKmVwU/xA4/YF5vtEr2dA9tFHx708hl4ev4qpSIJu8pgxy1hNCZ3Xzpz7x6QTCC3ip3zVhVgnDFEjkayUQvQkfjYWsZFZ9VcBGTTjruLBOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748761937; c=relaxed/simple;
	bh=7sJVDMm01xb5Sk6Kud6BtrHiAUM7ibZBKw33hjxFw4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iuO7GcH9Ib77yzxMIt90qatymvrkay7g74/5NjH7PwsYD6wF6GfMRwjaWmFTSrFyaldbcT9tB3WZneh8bOqN5/YGYUIQLi6SV5IrAUfGB6o1JzJAnyGsCJPGh+uorUzGeeDKhkNRA+lXIhZ6CXJt//hYxvkuc3FmaNp1TwVV4es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=DOwflvHS; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="DOwflvHS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fz8b0GtYiXZbaZmrbWygeBvm1op/xedO0+BofvlhrI4NHpeJgFaTxbAveckpbUg8q7EViUk1KBWAyJ/dd+pce54XUAvZtLMhAc6UzvMDycfSTmyOURYTx71SPOUXEgaHdKiXieie/Ck9HWMvula7+WaEtitXrJkGuic00O/Ljkqnej8z8mHmo78RCd3vDDNSfWp7LNYpjKvfv07pEW7HGJTmRwHEe2BLwizZCmVgYpOA4zZgSQ/vz045HuEAVbgoFs/+RWze/ESOdFRXo02ABdpC6pyz0ocxPZWe4bq16k/sxlakg5MZVHblNheAtlHhjO7W21g3YsaOhAcQYdVfSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXXL2vrL3ljW3njCO6ulbkvX4ART+KqhbHfZu5OaIAw=;
 b=EqUk7cdyejb0vSoMCtBc7qGggxyw+fn8R0BVl4GtujJb0uwmKtVQmEAXjPweO+8X3VQssKWRrvaDOS6nwdHfL0xVIvcpfkXlydC0w5iBsp9eOjZGUEADuHa8SpwtIbU079+yPjSLwwcWlHU3O5x19fgTvfKlma13+/H5gjFCT68vcyoeBAz79t7uFFdpd8PPvKK9WXb6dTN8e3shDU+q4r6Ch2Nnlj4Pznujy0mxtshjDs6KFUd1inJMykpYXo92569UoAsoe0yuzZl9KMv/gPKdp8mlJ2CpJsaZz/sqI24IhpU7jxCto8DVEqJs365aApdk0wY5pwcQP6V83U3AIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXXL2vrL3ljW3njCO6ulbkvX4ART+KqhbHfZu5OaIAw=;
 b=DOwflvHSiM5jVQ7a42ETqypY797ConDxov+tqZEKsPuWRR01+nLkR6lwiGiMtLQ20CP1x9dLe8xrMuuU7QeK0L7LtzilP/w+QVMq7dyp+yCect7mOcUKXi2PxKcNs0+NIlp8Y1ereKd14BhS7CznrD12SEOeDertJfPAq4P3+8eFpkarOXcHtS2LmdNhXU3aSuiN6dO7pzKeT475iXoKuEFzFVpk9qkZ5KoiWR9otUsbfOAr5FSaSV+dwj4cJvysHbmdUSdW3dLi5Dez6bM1c+NT4CRBjtcLPcaDmfJPWkJ/MlWciJVoLX4wHri2LjLJwFVc/cUE8WHgmAj70Cd2yQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sun, 1 Jun
 2025 07:12:09 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 07:12:09 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v10 2/9] imap-send: add support for OAuth2.0 authentication
Date: Sun,  1 Jun 2025 12:40:28 +0530
Message-ID:
 <PN3PR01MB95974D14FA95D297D82E8B46B863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g67a2d115ec
In-Reply-To: <PN3PR01MB9597C4D1176FC7E9A459C42DB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597C4D1176FC7E9A459C42DB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250601071035.2412968-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: ece76465-2870-486a-818a-08dda0db9fbd
X-MS-Exchange-SLBlob-MailProps:
	+b2+gf+2pHTK0hJWfIOsgR8XTzjzRgQkiZspJtoIFtQq2ldG0jUrhSh+08lKJlncTtO4P05nnt5CmvWt6ALU2MWNuhEofAeqj8KFft/OMx88RYTx2OGDg+stckgZPak3VFJmuPzV3eBoOJtsWeFe7JP1dzLvYWn7jvg2vJXiqI4DBbTcAnY/yv/286WN6UQweWhiAVzaG4Dgcs9y38ft305s4y8AthBAiE19QJncIG8+WC742oQsp6wJAbBzLKwlPsqYUvjIiAzorMtxvF8MBlzzqy8sK928TEWOLNthSECAfQD/sFXZ1Ihgla8TVDTbPkKGVBNMzIjqdDKmOfS1/9iCzX8IBmzfbnd7wvX12ZHkpxtSrsR/VNqsn33/OxZ6YqbRiwzq256n8bsb/M+BYxHVxXqhxJ1fsUhPkTb/yk4wnA/oFUn84AZQPtUweVGaDr/yEmOZCtJn9q1C4jH1yNX4ySS/ZsMiqXPFFfxYkgAz7chKZB8mGBHhTahZST6D4OtDjE3/BzkjfCUxeJMtPGVPkUfSxUnhE9cPi4fjK99hPwJQcweBvi/SyzRQsHljXYn6jUX+jMl5/b2XSsswsuSJuJjReax22MpEuYmehm9p08a0Rr+6RLjhsbTjztV3Z5P0Qwh7+En1pl8oEggQRiv+AeOFXhrmc9TyIb/QXoGLbxlrqh0wR0jiOPQ2Sp/au8jFLpehLSEYnVmKiqOqLScIMVlxjvHDKnzZAxFY52TKVj3vC3/n8DQGq21eI0pekVR/Moc1hSZ5RUqgqNxYaqvgguTg1NwiNlZTYA+ZbBp7k5ZhxYgQhAEvRE5kjfUZ55ZFmt7uSOQDsrzzhXSJ4tEDZyult78uRRxKfttsLCSK5bnxYRHSOg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|12121999007|7092599006|8060799009|15080799009|41001999006|19110799006|5072599009|4302099013|3412199025|440099028|12091999003|19111999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WrE8JYuk67BfwanDMaQ9iFnyVCk89vAMpNks/pzTKK/oXzRmt5tI5aZSTQwW?=
 =?us-ascii?Q?5HMaz+vJrcMimFyGKtX3NfNft3/UV0UTx53jXYevFyDw6vFERfqWtqMFH9bS?=
 =?us-ascii?Q?+LC0VNU7swVPBqb23lG047TVa1thbPc0YS9uO1odvsTzixkKzr6sTJbRTkSe?=
 =?us-ascii?Q?npeUBOMk5lr4OaU8Br4qCq+NOqcu2O4hImfg60DYn8pOu0TkP2RRmisZXMHS?=
 =?us-ascii?Q?xX1VhBV4si7ugcANQZjWTVOIc74zID4baQ6+tXIA6VJCAJi3PH+5PbI2UlAY?=
 =?us-ascii?Q?RiLAET3ofqy2AwMApVjEpllvbrjxb68JGOwiNTwp6bkIIs8NmdgMldSv2Oa/?=
 =?us-ascii?Q?X6tan20wZIx5BEiHlWGVguQmWbF4xRwy8dKtEivA0oqXhwHBp3fuKoAUR/tV?=
 =?us-ascii?Q?JBrrwp/269LBV3g0K/Rvig7fylIIT50JT0lvL5h8hFpctnmMTV4mm28iHWag?=
 =?us-ascii?Q?w4xFp1UwDy06kwQHKihfDiyObtG/j/eGxK3UD7F6h0byQXh8ki9TWrp4AyO0?=
 =?us-ascii?Q?wgKiGxl0ACjWRqaYANhjnEuiO1rA+/TrEfLtYPdd5vHO8LPajABwV1Ghc1L2?=
 =?us-ascii?Q?dsv8w5OGoMHPlUVYsvCyuMli6bvxVzU15ZWPMC6luQ/QEuwZbprXzVZCOo88?=
 =?us-ascii?Q?06Y4BZOzT5he+Y6AmsePmpV53iNmbSSauV1P/4cV/H1Xc2aEdopj2gV0/WEv?=
 =?us-ascii?Q?qMbc0Q65qCWYpcL1XEYOD4Rsv3afpdTUe2AD4z7Y5h/w/VzZtSu21W9EJB0I?=
 =?us-ascii?Q?gCGI7ejAt0mk9hYN8U8p51Y5LD04IManKbFO0m3mTdf7+h9WFYkhYPG1Q9Tl?=
 =?us-ascii?Q?cl6w+d2J9pygArL8CNxic7YX1/2Xrc8m8eFgGFGO7uEyeqLAgYXz5kaaAsDA?=
 =?us-ascii?Q?fD2y8aEYsnAQF08KBoMpSzaNivA0fS1Ll/FvGtRckh+8w9dlOP6927AbFyqp?=
 =?us-ascii?Q?c9yLL4XOS70ShXtsTkg64bjAermqnRdn4JyYSvy5VRYbWM8a1PkPIu/TU2BS?=
 =?us-ascii?Q?oTtFA0J5UXHdAcbu7APxEYK1Beiw0GSbGDgJluhSbXAhh0AkkHq9I2HA10HN?=
 =?us-ascii?Q?pNPIG0STsBWhsz967nBfkmpGSbrH4EFbZyibxkl3kc9gKkDAi/m365o72R0z?=
 =?us-ascii?Q?s8w9uXcM/LKOhktweHqCV3ui6yBG3ElPZ6fp0F3i74k89PEZiPFtPDufZFlM?=
 =?us-ascii?Q?HvIh8yzJnu/d3hu9L8nHNw5tuhtYUZ7HiVPHh2ThbDCjwcGi0ndpcooAHUV/?=
 =?us-ascii?Q?VLmqDrppy+J+O7aHysZ//qYx+67Qeg5Nih3FDkWLF3YYWTs9CJCquGpifTpc?=
 =?us-ascii?Q?kUZwpmaxRPtNAnD1Q7Mb12AR6p8Bszppho1KwYkqGnj4oFs/+BrZPG7Y2qP+?=
 =?us-ascii?Q?UAlenQ0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P3MrC57AT1+f4xIFOn/JALhtYBZ0wUZc4N0AES31aEsDYgtrOpBH6IbxDsx5?=
 =?us-ascii?Q?kNPOzyMuYsGymo/MUXGPluVBw7r0JN1XAnvnMongmcu/Ut0XxWDwEbqPmPMn?=
 =?us-ascii?Q?tzgUqmWtSj4Ts8yVu73odF7XoaGgVJ2TcJgbr8qz5rtejNdbmR5BLvqjqaNm?=
 =?us-ascii?Q?pxB6yFnQNlqOCi3pEWmWFLsPgg98GpimIibAxj9acb2o7OS22M1LvHsQkzNA?=
 =?us-ascii?Q?vrU8zR52Vgqv37AzrufyFxcg/IuevkBwtBfEWSTLX2yC+Gl6pTMra6KgQD4P?=
 =?us-ascii?Q?zCHvTLwWKkgCAblnjyxiLjifDivskiTnGQERIGVnKzyfSfNRdPx1stVBk9WC?=
 =?us-ascii?Q?TEradaG9InTDziOZudYn5vBk72MQczXIVYc4OsC7KISYNAreZHgkZC8skC5D?=
 =?us-ascii?Q?Wu6KX7u9FRZdV/kzL+3Ccthn4IvZZnm7Qo9584jrUApMLYfSLk5TTjUjVVoX?=
 =?us-ascii?Q?KA7BOKSs/q/J221cbSeMHFSVxfLUc+l1sLh87B5pNNBcf1qeDCpFhrkANxoi?=
 =?us-ascii?Q?hXs+B1AhuV1fMXwU5Ls7FVsqQeGKjj9v7vKfJxW5m4YH1dVHGtLVWVaC7UXZ?=
 =?us-ascii?Q?9AQ4KvpE6iC/NCuNJG+pK1jTkJyZdDqDN9w7jUe1zM73Sb2Pr/ohC6OEEky1?=
 =?us-ascii?Q?AJo5VA6ku3l4TKNGcvp7Ydb1vyVOC+Z1iXU1Pi0vXVysZ3mPYg/7ytwqF3jP?=
 =?us-ascii?Q?j2OBLxmt1hBiNbDtN6D3ZStLbZcaJA/u03cwDEVQid7g0nJF2wBD+BqRmQw5?=
 =?us-ascii?Q?rzTmgpSdamnb8rDEPP/vBIfGGuF3BiZc4RRaO19XW0Z4I7rSK5pRn0dMMsRm?=
 =?us-ascii?Q?UdYEzfquLju40OEMADjHFf7n171R96hapArYCwrul+W3cW7kKR0jFTO9qckd?=
 =?us-ascii?Q?MpViKFqRVUYxtWFlCEr0eVtQ6Zx/uUygmkRj/Km1dKra9W6aWARmQtozuRlf?=
 =?us-ascii?Q?LyeGytnsgFdk02KKNKjitpFk+NKLF5DFUy3jGhHdTvIVPPu522RC/ibp/z5t?=
 =?us-ascii?Q?CqISEcy6rNO38RjO7YbY/DdL36vamuKxvdT/9/UkJQHJmjlL0L+t/JZMd1hT?=
 =?us-ascii?Q?V0ooNLMCKR4T5ndGXGrFKrcZC+1CVIDIM97tIUv1Om32WWzsqR0FE4hh1+vZ?=
 =?us-ascii?Q?biHHB83Rx9Jqt8Wizv0AsboC7tegk0kV/XQkd5Fj7uWaa3Yen6jRZ23REWvb?=
 =?us-ascii?Q?+JbArXiDCtR5EYRVw2PS1R0qz6dN7Zo+SrEMVpQkxAKwvpJRXzvhToomGlU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ece76465-2870-486a-818a-08dda0db9fbd
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 07:12:09.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9108

OAuth2.0 is a new way of authentication supported by various email providers
these days. OAUTHBEARER and XOAUTH2 are the two most common mechanisms used
for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2], whereas
XOAUTH2 is Google's proprietary mechanism (See [3]).

[1]: https://datatracker.ietf.org/doc/html/rfc5801
[2]: https://datatracker.ietf.org/doc/html/rfc7628
[3]: https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |   5 +-
 Documentation/git-imap-send.adoc |  47 +++++++-
 imap-send.c                      | 179 +++++++++++++++++++++++++++++--
 3 files changed, 218 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 3d28f72643..fef6487293 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,5 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported method is 'CRAM-MD5'. If this is not set
-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
+	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
+	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
+	plaintext LOGIN command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 26ccf4e433..08ecb1e829 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -102,12 +102,18 @@ Using Gmail's IMAP interface:
 
 ---------
 [imap]
-	folder = "[Gmail]/Drafts"
-	host = imaps://imap.gmail.com
-	user = user@gmail.com
-	port = 993
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.gmail.com
+    user = user@gmail.com
+    port = 993
 ---------
 
+Gmail does not allow using your regular password for `git imap-send`.
+If you have multi-factor authentication set up on your Gmail account, you can generate
+an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create it.
+Alternatively, use OAuth2.0 authentication as described below.
+
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
@@ -116,6 +122,35 @@ that the "Folder doesn't exist".
 If your Gmail account is set to another language than English, the name of the "Drafts"
 folder will be localized.
 
+If you want to use OAuth2.0 based authentication, you can specify `OAUTHBEARER`
+or `XOAUTH2` mechanism in your config. It is more secure than using app-specific
+passwords, and also does not enforce the need of having multi-factor authentication.
+You will have to use an OAuth2.0 access token in place of your password when using this
+authentication.
+
+---------
+[imap]
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.gmail.com
+    user = user@gmail.com
+    port = 993
+    authmethod = OAUTHBEARER
+---------
+
+Using Outlook's IMAP interface:
+
+Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Also, it
+supports only `XOAUTH2` as the mechanism.
+
+---------
+[imap]
+    folder = "Drafts"
+    host = imaps://outlook.office365.com
+    user = user@outlook.com
+    port = 993
+    authmethod = XOAUTH2
+---------
+
 Once the commits are ready to be sent, run the following command:
 
   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
@@ -124,6 +159,10 @@ Just make sure to disable line wrapping in the email client (Gmail's web
 interface will wrap lines no matter what, so you need to use a real
 IMAP client).
 
+In case you are using OAuth2.0 authentication, it is easier to use credential
+helpers to generate tokens. Credential helpers suggested in
+linkgit:git-send-email[1] can be used for `git imap-send` as well.
+
 CAUTION
 -------
 It is still your responsibility to make sure that the email message
diff --git a/imap-send.c b/imap-send.c
index 37f94a37e8..4f3a1fb5b1 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,7 +139,9 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
-	AUTH_CRAM_MD5
+	AUTH_CRAM_MD5,
+	AUTH_OAUTHBEARER,
+	AUTH_XOAUTH2
 };
 
 static const char *cap_list[] = {
@@ -149,6 +151,8 @@ static const char *cap_list[] = {
 	"NAMESPACE",
 	"STARTTLS",
 	"AUTH=CRAM-MD5",
+	"AUTH=OAUTHBEARER",
+	"AUTH=XOAUTH2",
 };
 
 #define RESP_OK    0
@@ -885,6 +889,68 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	return (char *)response_64;
 }
 
+static char *oauthbearer_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the OAUTHBEARER string
+	 *
+	 * "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
+	 *
+	 * The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
+	 * * gs2-cb-flag `n` -> client does not support CB
+	 * * gs2-authzid `a=" {User} "`
+	 *
+	 * The second part are key value pairs containing host, port and auth as
+	 * described in RFC7628.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc5801
+	 * https://datatracker.ietf.org/doc/html/rfc7628
+	 */
+	raw_len = strlen(user) + strlen(access_token) + 20;
+	raw = xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
+
+	/* Base64 encode */
+	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
+static char *xoauth2_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the XOAUTH2 string
+	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
+	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
+	 */
+	raw_len = strlen(user) + strlen(access_token) + 20;
+	raw = xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "user=%s\001auth=Bearer %s\001\001", user, access_token);
+
+	/* Base64 encode */
+	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
 #else
 
 static char *cram(const char *challenge_64 UNUSED,
@@ -895,6 +961,20 @@ static char *cram(const char *challenge_64 UNUSED,
 	    "you have to build git-imap-send with OpenSSL library.");
 }
 
+static char *oauthbearer_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use OAUTHBEARER authenticate method "
+	    "with OpenSSL library, but its support has not been compiled in.");
+}
+
+static char *xoauth2_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use XOAUTH2 authenticate method "
+	    "with OpenSSL library, but its support has not been compiled in.");
+}
+
 #endif
 
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
@@ -913,6 +993,46 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	return 0;
 }
 
+static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("OAUTHBEARER: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending OAUTHBEARER response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
+static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("XOAUTH2: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending XOAUTH2 response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
 static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
 {
 	if (srvc->user && srvc->pass)
@@ -1104,6 +1224,36 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
 					goto bail;
 				}
+			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
+				if (!CAP(AUTH_OAUTHBEARER)) {
+					fprintf(stderr, "You specified "
+						"OAUTHBEARER as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* OAUTHBEARER */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_oauthbearer;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE OAUTHBEARER") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE OAUTHBEARER failed\n");
+					goto bail;
+				}
+			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
+				if (!CAP(AUTH_XOAUTH2)) {
+					fprintf(stderr, "You specified "
+						"XOAUTH2 as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* XOAUTH2 */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_xoauth2;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE XOAUTH2") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE XOAUTH2 failed\n");
+					goto bail;
+				}
 			} else {
 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
 				goto bail;
@@ -1405,7 +1555,11 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	server_fill_credential(srvc, cred);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
+
+	if (!srvc->auth_method ||
+	    strcmp(srvc->auth_method, "XOAUTH2") ||
+	    strcmp(srvc->auth_method, "OAUTHBEARER"))
+		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
 
 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
 	strbuf_addstr(&path, srvc->host);
@@ -1423,11 +1577,22 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
 
 	if (srvc->auth_method) {
-		struct strbuf auth = STRBUF_INIT;
-		strbuf_addstr(&auth, "AUTH=");
-		strbuf_addstr(&auth, srvc->auth_method);
-		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
-		strbuf_release(&auth);
+		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
+		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
+
+			/*
+			 * While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
+			 * upon debugging, it has been found that it is capable of detecting
+			 * the best option out of OAUTHBEARER and XOAUTH2.
+			 */
+			curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, srvc->pass);
+		} else {
+			struct strbuf auth = STRBUF_INIT;
+			strbuf_addstr(&auth, "AUTH=");
+			strbuf_addstr(&auth, srvc->auth_method);
+			curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
+			strbuf_release(&auth);
+		}
 	}
 
 	if (!srvc->use_ssl)
-- 
2.49.0.638.g67a2d115ec

