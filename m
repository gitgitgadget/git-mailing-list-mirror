Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387FB211710
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 10:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380244; cv=fail; b=lI7oezDR4gFNYZt39KkMQ7eT/aynVnnUJh9k923Q37pLv0HbEBy0A9x8Kh1LgPTKwUUYzF76R4h0xNcQqUvPL/QPW9sX7TxZfwBIRZ4+d5vFJi1NkkoeuWzvu6QTTJzp0HM7AVLGfaEk+feOqZ3MEBe2D/ZIjig5OYPS15ZMKtY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380244; c=relaxed/simple;
	bh=MDyonNs3S9hMnIOUtjYFpzasfd3yBhpFyKq8ijA/yWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G9BubRVfpqSquZ36UtgXjSB4fLCkXQw3YfhtojGGgJTrSv3QvFxtjZcxzjo0B8O+oYWj+t1nw6G85YwuDKSxSns/Ar9ARpLxbutQp1XT6rtA9IU6xjGWCkc1ZBtfj+8k4TXMqfudYPmnA13hRQIkqxxtjSrvct7NRaOTomI6SW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=SOf4aLr2; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="SOf4aLr2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0Rrevps7uqKpdnvjLgyzVX3wJnTnl5bl/hoQvfBbmmm/5oZnQGbl7JDk5AOKaC8lr9afIT/+Ly4t8/t0isiC2auv4uVrJTbeyZzMKZmTQqqiNGiPXa6upCwg24azZSOtkKAeCOqYeN7usrR2K+rCQGlYOWChOoGqgo9ucIqP3eQP+u70Y4j0S41UkrDoqmTLKs0BRpVcA13h8/qr41Wy2XUWTone2fzfqFDXhYjU0QYnOUWwZOZPqcJljU7rRxTz4LiZMdKui+/QLn4WSk6PRRFdUf0nFgux+dHhol86ZKkbsLVSc4vFLbsOzLBWcM6jxXSO7gL3xvYwGx4wnVtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJiAQOZ9kHCIzZ6xwRzao2EYd2XYbjJI5KhEb9yerpA=;
 b=X0cxOaHRBVTc4nExcF13lgOeCVxGDgKYvxsb8Xpz4BRJ9oo24Yr6ApfyBwAQFZ+vThASufXso1/zNswzYbVwA2MS7EMVfJczEyjJanrENfQuK/ILdmI46PrqhdmbYeJ3fTpK12XxShVZ2TTYyX0fI52yLyw+02GrQVhkMk2f5emwYf9lY2s1j18mqM9cWuffL8UlgW9I6bGyV/Mvx/etH/WTESFnOlRCNEW1CPHJPUU98q/NMYbtTNkyhcE4AIGOsAF+mv4Edqvxazj6XMjyGo1qIge9EJ4MH48HA9uZdJZLGt55/MktiBlkFTxYqEWso5SWrmE5m9lLyUPou0aRNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJiAQOZ9kHCIzZ6xwRzao2EYd2XYbjJI5KhEb9yerpA=;
 b=SOf4aLr2LW3DYHEb7GQ83AIEBmyMdlJxZtAkQRag+cMGW0ASwuS8t2LCi+HKrU3lKj4egjYygG0LcuWIyO/gYavysQF2YIRW/DhUMfMXrXZs3ZMLjPyDXYAXr8qUJHETdmEWD9rru3MerBIhR2a5Eu82O9nS56xW/8UaMicuHWYenIdz11BElosa/oM0ymIAe7JWh8o6NkVvm41xhthV9D0M3jqkvROLMLvOw21/yPVfvYTUCAG/wfrMFgcfnDYqk6jh/l0Vsc7XxOsbuESZm2N2/adXIG1CgwQq7jRp7It+ko8ezxgAWTbvdxlHM2oLvVKJnQEbA/m4i1vMLXXQ+Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB8974.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Sun, 8 Jun
 2025 10:57:11 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 10:57:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v15 04/10] imap-send: add support for OAuth2.0 authentication
Date: Sun,  8 Jun 2025 10:55:13 +0000
Message-ID:
 <PN3PR01MB959787CC7175E2296A3AF710B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g4d9a3b5661
In-Reply-To: <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::21) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250608105520.18264-5-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: e8e259eb-005d-4e3f-5ea0-08dda67b36fb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|41001999006|7092599006|8060799009|12121999007|5072599009|461199028|15080799009|1602099012|440099028|4302099013|3412199025|10035399007|12091999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LYF6pXectKRPpzJgBSHA77ZJBxpfK1Ay1QOqLFMBpe9vj6AOXsJ1+FOMQ1N4?=
 =?us-ascii?Q?ql1OfFvjhoZKzg7S4tMyis9nLoQ+P3p8D4GbN14+EVizVUiE4q4A0tBSLqmf?=
 =?us-ascii?Q?u9bWGTrxIERprspkUCK/QahS9tXJi8Ppiu4KBFxn7WMfg2I6iWiTmOKiBLGL?=
 =?us-ascii?Q?VzbBpqdknZ5tqK/xyWG2ZIyk6aSqWrQ33todcXUDOSyIhy+xstGS3uNql2Cy?=
 =?us-ascii?Q?R90/xOC3xyMQKIhuqicOJteMZGyuc/oRYIsrafYzunWxj4aAXGGeYRFd+jrz?=
 =?us-ascii?Q?+J8kG+pF3Ih93xVIkM2bg13FLwTLVGh0Y9nstrVo6BpuFsSheoHTsEeYQpMq?=
 =?us-ascii?Q?S5VMdBysWG4sHcvwfd392d8nU6J1lEnVXDJt5F6B30NYt7y9u1DV10M74ftV?=
 =?us-ascii?Q?3lsqYknlgh4NegFCDUNWyok83lFG5qv7lrHZveohkqAaiqerEMDVXDbs/2Pv?=
 =?us-ascii?Q?7VaJXnV3ffU2bP/ghYh3SXL5TOb+yigE0qeeVeu1hM9DHOyCxYgnYW2IDTJY?=
 =?us-ascii?Q?bsCKCGzo1tcZgksR2qJfbeIK2v3ZefHxbCuE+ulsGvnGPRAb20iPEegJpr4L?=
 =?us-ascii?Q?KzBin/EMmdbhXlsI5hYRuCPLgHpYSlkpyJ4Tdr0Ntzd5guclrmGj2LvY31qI?=
 =?us-ascii?Q?JpB7QVLiG0jJdfoxej5SA4pgO38uM1D+oRLl0zLs3LVfsTwmz+flQrs9qJph?=
 =?us-ascii?Q?FzuCXoxXHQZbfwyFQGMaG08YG9a8Qo2rb2j3HPnPM1pqEUKNDW2rJBk6Xrsi?=
 =?us-ascii?Q?5IGtdj5CCfVd9QAbxPpi3MfRrmHoHzEUV+SmI8UApqhXu/nFDJqu2JYQQF8g?=
 =?us-ascii?Q?y7qCRqXI+iNpSjMxM5UwXZLYadV2VU8I9S2bOgDHtk69ZFtvZ5E2sVZczErm?=
 =?us-ascii?Q?LmnjR+mKf0wdAfzlvCS4w4tnTu4vnd7I+TH8CLDxuVGxVDfeJX81NMMl2lBD?=
 =?us-ascii?Q?OqQC2jyfbPQD4gPGCrVjuP/3dzlAAA4mkzSiuCnJhZFRxDyJX16+IeObTzFm?=
 =?us-ascii?Q?ynmpR3yDkW23EjiU03bJt9YvLeJLfRA3FI3Y14tb2bVHvJHLMsK+9pzSYhqh?=
 =?us-ascii?Q?Fb0HV0WYbQcX4CkB0hqApytYHok05gNpT5mOYaUut5jHHTtcDogvHicPlkze?=
 =?us-ascii?Q?eZhIizvmUHktxKvhe8BqaRhVYlNe3yEtNW8++sHaMaDKf4wupzutqVwSnynw?=
 =?us-ascii?Q?dUsX1bGtRoL8uRNCuyHh1OO+DWmPkahmu/zEUr337uWizQa9We3IG/zAeWwI?=
 =?us-ascii?Q?dsQM43R/EpoKJDOt/uee4f8kX9X0uVWRLFYnG6iI3kRH/WfTOF4fglPt4/VZ?=
 =?us-ascii?Q?aDd0sUuP2e4ahNFseSDq1gCBUXeVnTvGCDNgHS6CDH/9n3PudMv0dcAOrsaH?=
 =?us-ascii?Q?4xncwYs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+CUfwJ8fmWOCzrac7GxAkU3whkZUMSLXdemRPetcGQ7nSUmb98k0mRvpuKU7?=
 =?us-ascii?Q?uB2TF71Xj/11cQnsM46kSJJrDjqWTYVNvXZPST64YgtMNm8TUCDqdol6llwN?=
 =?us-ascii?Q?sjw4RzMsqoLKValf7flK/Asn8QgYIVjes7ApSEenKrtHNPyrQy71hii0LsjL?=
 =?us-ascii?Q?2D72wfjjPqElwW18pzdGPPlUEyOMc0Uy+7kMxi2qVenMgmixxqRVP/DB3L8Z?=
 =?us-ascii?Q?WRi1ZbtHpDv5jSoz/ecwF6BCsGBurdSafM3024v7rrd8i+qWu51D9FIJ+LhO?=
 =?us-ascii?Q?0gdvh51BvIvFNaahjDMsZ7m5qV+v3zxen1WOPvX8MVCOVec3poWhuFX1D5O8?=
 =?us-ascii?Q?Kd6sPi+czeyWrwn9TLHJQQIcbKKglGRpaToRJdze0AZH5cbRDgeYjbD1O6JD?=
 =?us-ascii?Q?Nb2pK/2iLzUXlTJyC7i4+paMJGXYtLO1ZF5QXMq9o+woqnXUGS5SMDTZSz5S?=
 =?us-ascii?Q?jvdygdgCBSrT7uzOAs1X0UqzTi9qkZh3QTLbz61KsTtHLHOziNkrhGVFPGkK?=
 =?us-ascii?Q?9z/SGYl/Kcgl2fc+VcfHHGOT2KEDmQYJtFWNW+C/+xIqcAldmuf4NWWVmFDS?=
 =?us-ascii?Q?TKddMkDPL5E7aiH9ri3mJAYqeamkENSb4IxEZ8QPbnolbvfwDJ516O/zUTfo?=
 =?us-ascii?Q?7PbSKIrY6ydI2nbZ2Km3xpDszo5shqMHTpPbA+b00gzA19GA9IhD0sBUlexz?=
 =?us-ascii?Q?cC5kRVPqMcEZBuZ0Twbhj5NwwM3T5AShnwKpvxpBbNyzUqTeW+Qtz6BtW4NW?=
 =?us-ascii?Q?17z3Ezaz9r3ntuxp3scCbOPh0mSEhQeHGu6HXXJ1XgAsZDTqU0//CaI0/HMr?=
 =?us-ascii?Q?JHH4sGRdEi49Uj2regQJFJI9hSXsJ2vKhVCSsNhnXCkXYFGPdnfeg0N/QhaT?=
 =?us-ascii?Q?mmnJMMuE44x6VKVlLrYh0hqZJIjiLid4CQXPhTvYEx4DNRzHncFduYHlK6pm?=
 =?us-ascii?Q?hVZpLY81/lN3DLc9OA8APk2k1Jxrrepd85IPdA7uBDYmoZlIqjD7apyoVIdd?=
 =?us-ascii?Q?wCC4R/N7w+vJ1yF6HmaPMYa7abV6RydX74ksLYmFQS/ix+5XGcPpvkT85nIa?=
 =?us-ascii?Q?1fn0G2zE1fYw46WP9OApcNZuAWoCSXY2TiRqXyP4caKukmQ+N9K5SUwiK3D2?=
 =?us-ascii?Q?LW0m1wfk4n80ex2l4vth5n7BL6iu1Yez4Z8+QdYB9McTD8qwcmXS0W11g43A?=
 =?us-ascii?Q?Nq0+bFzb1qvbuCbo/2fXKgxEK/7QZ9d3GF1cocQ3B60OyTHDUrad1ONhJKY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e259eb-005d-4e3f-5ea0-08dda67b36fb
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 10:57:09.2459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB8974

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
 Documentation/git-imap-send.adoc |  47 +++++++++-
 imap-send.c                      | 148 +++++++++++++++++++++++++++++--
 3 files changed, 187 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 3d28f72643..29b998d5ff 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,5 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported method is 'CRAM-MD5'. If this is not set
-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
+	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
+	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
+	plaintext `LOGIN` command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 26ccf4e433..8adf0e5aac 100644
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
+If you have multi-factor authentication set up on your Gmail account, you
+can generate an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create
+it. Alternatively, use OAuth2.0 authentication as described below.
+
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
@@ -116,6 +122,35 @@ that the "Folder doesn't exist".
 If your Gmail account is set to another language than English, the name of the "Drafts"
 folder will be localized.
 
+If you want to use OAuth2.0 based authentication, you can specify
+`OAUTHBEARER` or `XOAUTH2` mechanism in your config. It is more secure
+than using app-specific passwords, and also does not enforce the need of
+having multi-factor authentication. You will have to use an OAuth2.0
+access token in place of your password when using this authentication.
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
index f55399cd9e..5373f18b94 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,7 +139,9 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
-	AUTH_CRAM_MD5
+	AUTH_CRAM_MD5,
+	AUTH_OAUTHBEARER,
+	AUTH_XOAUTH2,
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
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 {
 	int ret;
@@ -903,9 +969,51 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
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
 #else
 
 #define auth_cram_md5 NULL
+#define auth_oauthbearer NULL
+#define auth_xoauth2 NULL
 
 #endif
 
@@ -1118,6 +1226,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
 				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
 					goto bail;
+			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
+				if (try_auth_method(srvc, ctx, imap, "OAUTHBEARER", AUTH_OAUTHBEARER, auth_oauthbearer))
+					goto bail;
+			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
+				if (try_auth_method(srvc, ctx, imap, "XOAUTH2", AUTH_XOAUTH2, auth_xoauth2))
+					goto bail;
 			} else {
 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
 				goto bail;
@@ -1419,7 +1533,16 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	server_fill_credential(srvc, cred);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
+
+	/*
+	 * Use CURLOPT_PASSWORD irrespective of whether there is
+	 * an auth method specified or not, unless it's OAuth2.0,
+	 * where we use CURLOPT_XOAUTH2_BEARER.
+	 */
+	if (!srvc->auth_method ||
+	    (strcmp(srvc->auth_method, "XOAUTH2") &&
+	    strcmp(srvc->auth_method, "OAUTHBEARER")))
+		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
 
 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
 	strbuf_addstr(&path, srvc->host);
@@ -1437,11 +1560,22 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
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
2.49.0

