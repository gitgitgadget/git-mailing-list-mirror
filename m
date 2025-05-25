Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A811A26B
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748199312; cv=fail; b=o53nMDSvPOZa1AxQyxnVkRBTLVUQzaXY/Y5S2gpqWst6XRX5R4hpFwizNzdajCQpZVprY4wGNC3tWJ53cVV7LbVljDbBJOUFNBnOGm3ppt7XCoG45VAWWkrRyuFhegadHOEUaT3f+qgUj6mfJv8iAxX8yPtx6c887E6NvHfIakU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748199312; c=relaxed/simple;
	bh=Xmkmrhbs0ojZn13dIU5uLzuD7WEW7JtN11QJ9kwgN18=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PIpPsPzKnOQz6zjkL5w7WFOGDLY5REReFBMXhaiALVzc2PdsoXU6LuAEPEuoZhWN9mMXGmf7SNoMj0j+a0vjDjMNUcBrhr2VlA7Zh7P3GpDL7zyFukaOW2bdqgp0Y6riRnPkpSM/C7c2oxemgOpYWwWRzgKJi5FxT7LUv5YY0D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=AEf8x4mJ; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="AEf8x4mJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaLsag0/bRHL7wYL7jg91uYrW1w5gWNVd2MGG9bke6Ajzn57yI209C2h61Cikj+2U7lg50Ezqo3Zm9ZvPHiBdFooOQv8TGRdEKBtAxr2PtbF7dHPRcbqP32w4QLsDvWghvhKRnl17dkMWLT2HNlGRfaCmVRsK3C/uPM7uCEWbu+RfpQlGhFOr4CIp3wZf1GND+BI3Y8MO03e8krJpQXk9qUD2BkxpC+BxTXfuMo8aLGjZDFvZpK3n0LaZrIlTBiZ9Cc3H6g/rT93BVgQYaIICX8I0BcVVa8lHW7jiei1r77DSU/iy29yOKlY3uID9aXVjV6Pk+HqBw2hqH1vRcdutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLPqyZPqWmoI6y2CwCJ3Ud2zUNSjFjocVXMhArQ0eW4=;
 b=vjEAC5X7szliXZtCDPOt7KgHeqdtOganv7Gi42bFneLzjyd+X3vz2pPe7z3k06A8abXWKJOKityawNjghPXWFh1TTWfyQnY6gaL5gTgC4fYKQeauBAKSZ9/EleshixxWlPNrfGqerpnw3oX643nu+0l47gVms4UutFGRZlOReb3V2HxEdBVeXyUkszeUpIYxAlqRbWzxfyr1vpuyIfJVzNECvg/gtIkEY7+MiXzwkHUwOpFVPJP2CrHDksMKewFIRIBWlwy8WpyN4AQvPzwGqlrknDxTU7qcVavS0cJCVzKqqvys8mkb3vYZPpDlhuZv9/+82WQrwC3GZXDQpHf9Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLPqyZPqWmoI6y2CwCJ3Ud2zUNSjFjocVXMhArQ0eW4=;
 b=AEf8x4mJgJE6U9mh8d6qXpxyg2Xqzp/HtZJ8GIAgN0gr9fdqh3xyv7xqczeP9lhjDbz6Ai+0Tk+vuv5ASlUvbDNVQTx+owvGj8wv5cYWrnk9KS1JivCOe15KMOLvXUHtIXjzzmuqSUBHtmF4LgP5yuwXc1p+phaaQA7PwIHjd5yC2ztUCUNlUwVmDASA1zBt6z3FBcsDBaNGxwP47Sxs73JVj1r/8OzygItAEmxAaEbAcN+xIKFN3C+xxKJZAMPVVfWVeQfWOw6sZoGuS2cVkyDpOnYk4OO7ZqMPmoMHYhPJodrBdXFTV25EUZrlG0snfpav5ZjMnL/o4a+GFMZScQ==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB10362.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 18:55:02 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.025; Sun, 25 May 2025
 18:55:02 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>
Subject: [PATCH v5 5/6] imap-send: enable specifying the folder using the
 command line
Thread-Topic: [PATCH v5 5/6] imap-send: enable specifying the folder using the
 command line
Thread-Index: AQHbzaaF/IZ/bEl2a0SklmdQN5tl0w==
Date: Sun, 25 May 2025 18:55:02 +0000
Message-ID: <20250525185447.29982-6-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250525185447.29982-1-gargaditya08@live.com>
In-Reply-To: <20250525185447.29982-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|PN3PR01MB10362:EE_
x-ms-office365-filtering-correlation-id: dc51ffb9-eee7-48f8-29ac-08dd9bbda7f7
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|461199028|7092599006|38102599003|15080799009|19110799006|12091999003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Eg8K8pL+vb4wOhFBBWTiGitAK7pL/IiNJUkxgidhF0T8FMH9/O/dvX5Htv?=
 =?iso-8859-1?Q?JnLaU1AQrWZLU//Po0k5cZFLxRQswNOZpzjPoSpt6rKb1/X2jHgU3bpobJ?=
 =?iso-8859-1?Q?Sb0ngBHIPTxY0XkWNZDqwhbpjhJ9bShZ81ORtzxtk83k8ism3qECHQPg+K?=
 =?iso-8859-1?Q?CcYzpZAy5mx77oLmtAnCIfyI+kJFmn9ggu1V7R9IreAcX3JSOInvF7l9gQ?=
 =?iso-8859-1?Q?H8ngwEFNjsKW2pD6Re293JSKkOKalf3PAeklC1TtKZjwQeAjw3di9UShUe?=
 =?iso-8859-1?Q?h6pse/jBav0LkhhTD1Rr7DYE5d77nRC737+J5pL/Jg0d1TIFRnQjLSYMj9?=
 =?iso-8859-1?Q?RayFoVtssWAowedEVJ1EaWUicW4GxDD7vEgPCQpI3pQvVVhH4FVQXUMp6/?=
 =?iso-8859-1?Q?hK74Y9mh28g2bV61xCE+vlPs3A40DTkT10Tx1amyDMERE0mj9fmodr/Nkb?=
 =?iso-8859-1?Q?awX2cj01c1QhzV5rL5twLXybfC5LXYc+ralqnYJqYL8LJHGvqET2Q4PAUk?=
 =?iso-8859-1?Q?On6CfGtP7Aie1g/Tljc7SNIaQB3kLIs0oyXxd/7gcCcZUQ/5so2AzDrncd?=
 =?iso-8859-1?Q?4aK7gy6mj71zLHFuniFGHHsVUO3VFQBf3a30P+4E1qNz0EQvBMnBztaPXZ?=
 =?iso-8859-1?Q?KUmzKZGR4lVhOGqdXCuNXPdz3m//7Hlv2nroyZB4EDiChMy2HjbB2igFse?=
 =?iso-8859-1?Q?GnU5qlhbx2NjxYcW7t+Hihcm7f714CT2WOLiiwSPuZ8idmhqNGYmOguFcm?=
 =?iso-8859-1?Q?6uDBgNemv6zXGK/ZbmdCbAfkkpI29JuU73YSYm2FJLuvGdR9SgA/t72RSo?=
 =?iso-8859-1?Q?jOijw+9K3Ndexu/Np5UiiqMUzGfn86ECgFmPmt5m436cxn0opluyl6mfrz?=
 =?iso-8859-1?Q?GKDqiMYSbRUBmDeDVcbZfgyYf0ca4gpPnRTCqpyG2GIiDr10AoTo8mwv+G?=
 =?iso-8859-1?Q?zRP0umA2lRLkNFOsz5IqDuuZDM4sIctRr2S1ftTMYp1TI6LQLIwOEvcfWO?=
 =?iso-8859-1?Q?pvudvCUgNT0mP2BwT41m7QETLAxkLESR6ZUVPIB22h+Cu8GOuyHSBxgp/R?=
 =?iso-8859-1?Q?ibEoK2MCKxMZPTjtXKGzmcLYyl14f0UzWz+x4m+HsgXbRJz099L1bXOQMb?=
 =?iso-8859-1?Q?f12U+Oi26fnFXeth7X/XcesRufXcaHrIxGgVs4RlihjaTrbUSr8IjRqYiR?=
 =?iso-8859-1?Q?0jmffb62aMbvdi2qtYVq8vlr2ThwO9YPRD0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Hk/LWsSgihqUMIpTnaVlzRgMjoS6/yQkR/FX3sFGX+dLvUnsYBnuoO6gAn?=
 =?iso-8859-1?Q?B3/zRx5IPG/e34figyRRB7xNjeD2C7UIJNo/YRoliIWcABprL519pBduen?=
 =?iso-8859-1?Q?Q0BaxIJsFawFQC2FEWDL0SOpvep/sdupKPJK23btQRq05aFqjtkL+H3tgs?=
 =?iso-8859-1?Q?kgT3sWc3AAXiTYxHr6p+if0UsASgwqPRGNoPqTaa8HYjLe83tV2IeJbv5t?=
 =?iso-8859-1?Q?fPkcOG6n1umhNkjYBgkdHNlbTlokjGq4jo5XCKpCm/FANmpoGxI4C7cFJH?=
 =?iso-8859-1?Q?8iE1vg1w8hxqXuV+RBwC8DMILpStIDdS8tqgVy68COuy4t2fJ4ZKiJiAeu?=
 =?iso-8859-1?Q?pR/E8bhqkbBOo67bd86VUbOfXSXRGNDQSWjYNFJyYUGezsXtt9WT8kiVBn?=
 =?iso-8859-1?Q?q9EM8JwSllY4ZZGl1gP56Sw2uguw7QANsdmMPBe8vjWoZY0a9xKADVfJn1?=
 =?iso-8859-1?Q?gcAV+PkTs2wpVMZa04n+156KZskPiGwRH+Wuy3l4/IQxbfHOdD5H/5wVlX?=
 =?iso-8859-1?Q?mthHOWzyPcG4hZXdCmSi+hYESkaCUf89i7nD0Txeg/IiVG+k7thFy5PRLk?=
 =?iso-8859-1?Q?atOgRVMZE7/9GNRTgylFMFNu07UfQupLfsvI6Mfnm6brleb0Wta4qDxALq?=
 =?iso-8859-1?Q?C+VPfPLV3DAl+TE3HQlHPh2GASaHxsO4NmQzj7dSJdugaR62WArkNNX0D+?=
 =?iso-8859-1?Q?3KUknCC0dtvD6fRmD7d1MQYeJmuO4ID5p0K20jWpmxkaDfF4DmIQLkfgXg?=
 =?iso-8859-1?Q?kX3OFqpMQ3jld1RN+HFhzgRJ4GH+sL4Tm5ms8KFgnu9QzR7eq1lHX6ogfg?=
 =?iso-8859-1?Q?FLRBBrgitlZQ0wXtDby6YpxPgwLG4DL8h4fvDItYUpd79ib/f7xAO3XzfF?=
 =?iso-8859-1?Q?Jw5FVfO6HBRjTwjUmMNjqqvxqsmh2b8UCSJdS3KpC2Bnpo1kLaE/OlbzHZ?=
 =?iso-8859-1?Q?ZsoTqrO2qY4XoyMzzAziEYgTdyLEfq/AqK7RL/qXKtujq4YUI+mYYr2EUQ?=
 =?iso-8859-1?Q?rLpQ/1YM9qZOb6pG7l4W11Mx8MXajZC6zZ4iXlmYkb0T1MqklyL4MJWxZM?=
 =?iso-8859-1?Q?94b+OT96aJvaA8Noa0UqrgWYQnPV/6HFQPQxmO70lXxPObmVNAePrMJb16?=
 =?iso-8859-1?Q?hXlSMukS8EbjPKWw+KTXT9T6ysTM6um2cGlRIHwFUVYcJrZpcax2EpPf/X?=
 =?iso-8859-1?Q?nW2j1G9JcCW5qLyRLNn+sOk4nFsyhYTXPDMoOhNvNJGK7NXPD57VjlvXBD?=
 =?iso-8859-1?Q?zugTcBcaEMKCj4I9atcNW7T9+Al5CmMlV5D7oRSr0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: dc51ffb9-eee7-48f8-29ac-08dd9bbda7f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 18:55:02.5387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10362

Some users may very often want to imap-send messages to a folder
other than the default set in the config. Add a command line
argument for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   | 5 +++--
 Documentation/git-imap-send.adoc | 5 +++++
 imap-send.c                      | 7 +++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.ado=
c
index 24e88228d0..829d9e0bac 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -1,7 +1,8 @@
 imap.folder::
 	The folder to drop the mails into, which is typically the Drafts
-	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
-	"[Gmail]/Drafts". Required.
+	folder. For example: 'INBOX.Drafts', 'INBOX/Drafts' or
+	'[Gmail]/Drafts'. Required if `--folder` argument is not used. If
+	set and `--folder` is also used, `--folder` will be preferred.
=20
 imap.tunnel::
 	Command used to set up a tunnel to the IMAP server through which
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send=
.adoc
index c3a46070ac..de3613928f 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -37,6 +37,11 @@ OPTIONS
 --quiet::
 	Be quiet.
=20
+-f <folder>::
+--folder <folder>::
+	Specify the folder in which the emails have to saved.
+	For example: `--folder [Gmail]/Drafts` or `-f INBOX/Drafts`.
+
 --curl::
 	Use libcurl to communicate with the IMAP server, unless tunneling
 	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
diff --git a/imap-send.c b/imap-send.c
index 87abfd15f3..e062758198 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -46,12 +46,14 @@
=20
 static int verbosity;
 static int use_curl =3D USE_CURL_DEFAULT;
+static char *opt_folder =3D NULL;
=20
 static const char * const imap_send_usage[] =3D { "git imap-send [-v] [-q]=
 [--[no-]curl] < <mbox>", NULL };
=20
 static struct option imap_send_options[] =3D {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP =
server"),
+	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder=
"),
 	OPT_END()
 };
=20
@@ -1762,6 +1764,11 @@ int cmd_main(int argc, const char **argv)
=20
 	argc =3D parse_options(argc, (const char **)argv, "", imap_send_options, =
imap_send_usage, 0);
=20
+	if (opt_folder) {
+		free(server.folder);
+		server.folder =3D xstrdup(opt_folder);
+	}
+
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
=20
--=20
2.43.0


