Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011025.outbound.protection.outlook.com [52.103.68.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD6221576
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401666; cv=fail; b=N0beeuUyFWuAElTFMIj5u1xXT37/B9NwG53GGfPT5BHtt54f5M+q2xgX4J1csxd4rbn1n3sNoOJjqtNZBNL++roPr0jA8Ivjf8D5ZDT/rKRIlh3NNIqON9SltH6xrrXqRKY4vI2WEGNpdQRJ/WvsyrqvOtr6hGrzXtObdqLA6kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401666; c=relaxed/simple;
	bh=4ADwOZ+PYH68YCBaHaOjX1gI3fJ/w7PRiy8Lz9lXLt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hk/hy2+gk03VHuyR2HzkYDJJV6fZ3KJCvSNtrg3Q+rvFSrpFzBGntffLtRxQ/66tOkCHyreU8pm/XZSgy3O9HVYHL4isNsMz17MeVQcW6vGgTs2aVfZLH/sc7T6oUlE9fnH8J+UGmmsoSFBmArWvhs4psS6k22T2ModBqoI5O78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UcLPWbnG; arc=fail smtp.client-ip=52.103.68.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UcLPWbnG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bt9VaPNO6Qn7XXz4gIhR/ON7Y4lr2aQJiHsBTWR+qWVtj9yO+4grnveHZyxZVY4OGEmpadpRA35zuHs0xw/xWCnbTvLQsC10kVUg6egJHFqXUUyPxxujV9VnJbCYTXId17yVzerzlaBDiHboohBuZREnbwNC5SUlD6QjAbgusqydcoPTyEHkC6awZfv2HXuufpyICv6Ux8INc3MVbRSVfaw88QjxendiOVUoQDgVFPOt/Ngp059JantSpUyaLTX7zlYAouyo2vybH/DE/MKnHAzKeHXlwEGcPCpOzV0tonI3IhmeTDL8LMY5MdgrmZcVPxxnQLTGxjaZRwhZk0FL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXgSAKo4bMF18keb+NeeagKW3kkB1dNLvTA21u+VjkA=;
 b=a/WVxRVNwGYiNRBLEvn9dBWF86yPxi0zmoiM6TVy/cWSSoKX1mlZtUEs6aH+8BX5AJJitauNxnfvkKz3Q4QAH6E+phrkE/BdHanHXT2lGJuZgjePq0Wysg84KFSGxF9e/j5GFdoEb7sPW8ZMDs5nwX9H3S+VRcU21MeVcGMsOyDWiaiQDE7FHkVDaYLFKxLMjIMzDThdsUURLWJOqsALApPZ22dwkXasy3TM0BbzO36ti6y/uYdSaK2ydHN1F2G6j4JFGJY9EITqyS488KjUhbSKlZkP6PW8A7ruSdNFMB3wmBf7hyPejfeyPl0JzypIFhJl8/yOpFQgUY2/v6ksgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXgSAKo4bMF18keb+NeeagKW3kkB1dNLvTA21u+VjkA=;
 b=UcLPWbnGg0xJmCNtzLZ7MRaovPR1Vbb3JOmmEv0u9B9lxDMrpD59EnC6aRmFq4r4JpNYuPq9+Tr/uANCABru3dZE6gpXn+zarXv8r4L/MLAMmw0fmFRaYcuePps23HMsOCWObXNHXMiwRZNrauEhv5aES4pDMo3HQ+eIQC8dXtYj7JXg4BoU2uLUXuy5aEYf+9Oxr/I8d1JWE7NTUwZxwDU6jK9mB2BQI63UPVTf4sbIo+oYqY1HjwVSkyUyBl9khO9a0AvXbgm77lb9KKZb/y+ZxLgs4lAGGOfL/ocJ5aiCz2cGBqwS5j6eq928obSeC2zTaNl9ehn1/x+5rRJYRA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6749.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 06:40:52 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 06:40:52 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v19 05/10] imap-send: add PLAIN authentication method to OpenSSL
Date: Fri, 20 Jun 2025 12:10:28 +0530
Message-ID:
 <PN3PR01MB9597CB16EB1C59A217615376B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250620064033.15814-6-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ff2233-4ed8-4a4f-7e06-08ddafc56644
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|7092599006|5072599009|15080799009|8060799009|461199028|41001999006|1602099012|3412199025|440099028|4302099013|40105399003|10035399007|19111999003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u5wvblxWH+pgGG5+U5MLaGJ9GTGjum+I5nrYU91OzFIdqyzmO5E0TfCkRISa?=
 =?us-ascii?Q?TlM5fH3Uyblv3HjIckTeu5H4P7gfJ62n4qzHnqpZkUQrZjR1Fzr5djdSaZBv?=
 =?us-ascii?Q?ALQxiD78IDSTFL9hsuJAF9Rpdu9HHLGXwtRyFBYqW4sHgBOQK3HHKQYh5/u0?=
 =?us-ascii?Q?feXMRWUlxq3e8Qxa6SntLO2hJu0HgG4ASeXEC4fKQ86847AJ21zG7Zi1p0hF?=
 =?us-ascii?Q?peitFV73JL7KgCLOwBdXh6D8xdN5sXoMkQjjhahmizxetp3tsyvgoRn7cKNO?=
 =?us-ascii?Q?SnGdUsJzqBcCNfKtjoBeIg9msZLzWzRzPm2qDVxHpkEepK8zuyXD9JtcqvYh?=
 =?us-ascii?Q?L+31Oht6nzuaXCcYChousKXSqRIxklnlbaKcCdQslJeBDxWww7JLhaXDgpDa?=
 =?us-ascii?Q?QsrYUrBUIDUYytocTy8A1y6P0RJvC9MVSzzEvspgGjavapEO5DXNOcq+gJhZ?=
 =?us-ascii?Q?WTpsi9+Gw22N1nIYOrCkis98twqjXzy7PbJ3g7FyL70UUvDC42AH1gfegsl6?=
 =?us-ascii?Q?vtkEZACUlCbFWSpJ/mr9ZGdafRzkrMGZ2Cxn2UzklU3lEd6MdyOsNvQPJgr3?=
 =?us-ascii?Q?CNy1zaHsqRD0x2Yj7aPnXKPQ8gchkDhgXTfu/zZjCLzqazWyBTVIYoxCku6H?=
 =?us-ascii?Q?mfwChTfhBz0m2tzbgBZinQY6zSerIPKYbtIxve2UX1GzaVKPuTUe30Usrfe/?=
 =?us-ascii?Q?KTW1idm2rRrD6rXJJVbZJChAk2jHfxN21PkTexvgSyumywwT5qw8/oJ+Ndym?=
 =?us-ascii?Q?MTxPtl6WqWhIHlayRKOFPGR4L/vRdSnMnJ5VwxLziDCLoqVGX28m2VL8fz6I?=
 =?us-ascii?Q?gqQWuTKxYvb08vcslMWK2gelqMYxTUK+p29Wijf7/ZRM5pT87IQ6+9ELZp3O?=
 =?us-ascii?Q?JZOmZKUU1twztzhJH7hKytPgqteKiWo3Tw6Yw4WPI9LzLziKk+9Itx2tn0Nz?=
 =?us-ascii?Q?oK5ZLEoPUMoukSW7ZNI/EsBJqqElsjYXVVEsorlPFt3MsAha0yv9+pNB3pSp?=
 =?us-ascii?Q?TIvEt91Exc5fhQXFjqN+JbAmPjI/TOXtlmBcqAGnnMcQxsFs96kcbxZd6N0W?=
 =?us-ascii?Q?3kKeOw15LK/8ED9FEFutR7QNrpcS9s0iD+V9ubFSLGQ3ghQi6RCSMHFvAOf/?=
 =?us-ascii?Q?fUn8hlSGVBKSq3NCDfbqOYupbIV0PdcqmYGCTSu9V07dFOgYzPXpQ/wqwiE/?=
 =?us-ascii?Q?QxCrckKT3h0U+HmktncSxHTr7DOWJo8BZZNSCdKnt3s/pC7T7CwuFfenqv5o?=
 =?us-ascii?Q?oI7ub0E9nIFjVeXJ9iUKdKUq7uG7gD2E5+QUx3PbmWpS+YA/eQKMQuE9N2VL?=
 =?us-ascii?Q?q/m94LHV+B1HCdeatxt5K6Aqj3PktQEqefTVoE3GZeENjJzInFfYXdPjrtbi?=
 =?us-ascii?Q?Ms17yLVej/2GpIQ+lzcI9+6IdDSR+oJ45+8MNUw/MgBCwUE4SA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FwPbxkc4iRK7NcB9Cnu69s5vZAcMjPFv50RiM1X1dTExidzG2IyD98F6JHKZ?=
 =?us-ascii?Q?idB0GeBLuiKpbkjBWA6nhTdE2KBtLj4isKCbpz2Yz94MDOqp9ij+ZsAnHBb2?=
 =?us-ascii?Q?5Gd0jkvq1zbnazkqgEtRDg8wqetcVQtpVm96BwKXb0DmmlB61+y8LQe5dgbm?=
 =?us-ascii?Q?SsHIc3NOTtmb5rMCfvzIfygTJIUBMqyGIz+RGzUtoxDLb4Ape6MGVDSrv3tJ?=
 =?us-ascii?Q?94aB0pWewbaF9kICL+8w7ddNUjkQ3A4s8Fv07zoEHiipsAuEze7Of6sgb2xv?=
 =?us-ascii?Q?7zQPtYzd0LSbEM+MVerJa3cIESY4XvWTHMfDYNtTjeqUFv+9ysrGHMQ8ZjAd?=
 =?us-ascii?Q?jVLzIlsIzaXWlX7zicoCNqwqYGDIdVvnoDAQeOAbSYZtuq76QdLykmxrI72Q?=
 =?us-ascii?Q?FFUl7A1/86bhWpfIV29lGQXIKiZu6hkGKnKvmqSkLzWL+PktyWyMtzhbu1Q/?=
 =?us-ascii?Q?4pvdvKBeqzsqnGgRIT5wByh4O1MOr0E5aVk22/Jg03yAqdPJLLLHSNfaHXVQ?=
 =?us-ascii?Q?/cGvJsFgD3vNip/n/iCdqOk2B/9IIy/HZ2bvrbAOLQ6SXsKHyxZGtGu+R988?=
 =?us-ascii?Q?FJ29pwJammO65/oQ1gVYR6eZmITFLMeHN+fZv2WochOeflRvok73W1LxnCLL?=
 =?us-ascii?Q?W8MDs/0O0km6qE/IgH4+TjW0UWfG1SFT3o5NOHHsWvI5jShfREl+gMCDB+5f?=
 =?us-ascii?Q?FWconL26WPwerDZgb1K//Xw45rm+VrGGRRnJRb+GXoJ0ZadI+1xI+Tt5g5aD?=
 =?us-ascii?Q?B9oECaG4fPUQ9+CZgHvZJCMK3/o3xWg5tpHNJYmi2SC1x8GrMeCA+YEGvTAk?=
 =?us-ascii?Q?NbPBvD8PEKe/LCPiSiSPObm5toBjTNiTeuwP8yLs2yPswZSPMhZBKCknyORk?=
 =?us-ascii?Q?BsaZlYSPAfNAW+kKUCGb22Tf9Auqa02kw+61d75yGtpxoRn96FFAcr6Mx6wa?=
 =?us-ascii?Q?QQwUZyB0zyqJ1xCYBMC9KFL1ccdc5+w/mcssnfTpqoYDeTaQuSGaHpgsKeUM?=
 =?us-ascii?Q?ORZOqnmG5wzPn2nsO8Df9zELEYTFO7ZzlQvhIO6h1DcSi5MqyPJxtw6773gi?=
 =?us-ascii?Q?hehYGc1Mh2xTP42o8yYA+votttpRjBj2e1fnZpdksGEC/hhOg6c+neAMouqp?=
 =?us-ascii?Q?blp99AnMcEg92hU3z80t6R+Od9z8lir9gCtFX2vgL1SW+hDt1OP3m6OK5A6m?=
 =?us-ascii?Q?9EXe1pcc80DUCz62oXjTUvsAL+ovs/Kf2BBlTp3kSsvETs1vZX7zDCwPF56v?=
 =?us-ascii?Q?GojpluFDo2D3l67ZJfVouhEfNECyOUGgs+Ka/jOVZgxAvFaRZa5r+4qQLEVn?=
 =?us-ascii?Q?hPo=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ff2233-4ed8-4a4f-7e06-08ddafc56644
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:40:51.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6749

The current implementation for PLAIN in imap-send works just fine
if using curl, but if attempted to use for OpenSSL, it is treated
as an invalid mechanism. The default implementation for OpenSSL is
IMAP LOGIN command rather than AUTH PLAIN. Since AUTH PLAIN is
still used today by many email providers in form of app passwords,
lets add an implementation that can use AUTH PLAIN if specified.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc |  4 +--
 imap-send.c                    | 60 +++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 29b998d5ff..7c8b2dcce4 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,6 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
-	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
+	option, the only supported methods are `PLAIN`, `CRAM-MD5`, `OAUTHBEARER`
+	and `XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
 	plaintext `LOGIN` command.
diff --git a/imap-send.c b/imap-send.c
index 5a83ea80e1..f3ba5eeb5b 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,6 +139,7 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
+	AUTH_PLAIN,
 	AUTH_CRAM_MD5,
 	AUTH_OAUTHBEARER,
 	AUTH_XOAUTH2,
@@ -150,6 +151,7 @@ static const char *cap_list[] = {
 	"LITERAL+",
 	"NAMESPACE",
 	"STARTTLS",
+	"AUTH=PLAIN",
 	"AUTH=CRAM-MD5",
 	"AUTH=OAUTHBEARER",
 	"AUTH=XOAUTH2",
@@ -851,6 +853,38 @@ static char hexchar(unsigned int b)
 }
 
 #define ENCODED_SIZE(n) (4 * DIV_ROUND_UP((n), 3))
+static char *plain_base64(const char *user, const char *pass)
+{
+	struct strbuf raw = STRBUF_INIT;
+	int b64_len;
+	char *b64;
+
+	/*
+	 * Compose the PLAIN string
+	 *
+	 * The username and password are combined to one string and base64 encoded.
+	 * "\0user\0pass"
+	 *
+	 * The method has been described in RFC4616.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc4616
+	 */
+	strbuf_addch(&raw, '\0');
+	strbuf_addstr(&raw, user);
+	strbuf_addch(&raw, '\0');
+	strbuf_addstr(&raw, pass);
+
+	b64 = xmallocz(ENCODED_SIZE(raw.len));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw.buf, raw.len);
+	strbuf_release(&raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
 static char *cram(const char *challenge_64, const char *user, const char *pass)
 {
 	int i, resp_len, encoded_len, decoded_len;
@@ -947,6 +981,26 @@ static char *xoauth2_base64(const char *user, const char *access_token)
 	return b64;
 }
 
+static int auth_plain(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = plain_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("PLAIN: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending PLAIN response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 {
 	int ret;
@@ -1007,6 +1061,7 @@ static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
 
 #else
 
+#define auth_plain NULL
 #define auth_cram_md5 NULL
 #define auth_oauthbearer NULL
 #define auth_xoauth2 NULL
@@ -1219,7 +1274,10 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		server_fill_credential(srvc, &cred);
 
 		if (srvc->auth_method) {
-			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
+			if (!strcmp(srvc->auth_method, "PLAIN")) {
+				if (try_auth_method(srvc, ctx, imap, "PLAIN", AUTH_PLAIN, auth_plain))
+					goto bail;
+			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
 				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
 					goto bail;
 			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
-- 
2.49.0.824.gcc76007b2f

