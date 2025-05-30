Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972623536B
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626374; cv=fail; b=aKRypHr4xlaeHx46HjbD6NPfcutpFd0hRB6A18EyzYNGSQc1TDk42Pvxq/DjoTZi7EOZupFJgfFw1SJ1iqUCpYGNKD2HWVCqsX+Mxvvukfm8QakMtCcaj+uev+Y8GaDu8CSRoYZSSQtfPoe3oJlfz1O4g6CgalFDo/+ivA30HSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626374; c=relaxed/simple;
	bh=401NLskrnc4qaVtUICJtsLpB9K3uT2g+Y7jbWGqKEo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WP8FLMCtkZf+roGyhiJ5cvlEcGAmsYZ6X6J+b/K+QOSbbHdNaAOjVu0+Rrl703993GCNumWCUrLiGyCcWTgU9mXHwgfe0xdEIhPcrdhD4qmIx3iXFF7sj+w4E37jq2UYpy7aBrCjLZ7Ua0IRnrz+5HnBwenXqU3te1BxZS24YzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Pl01Ox9z; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Pl01Ox9z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0+sz6qS6fjrA1BtvuLviMbEW6SSnpfP4Idycty8dnmHuqQ2J1YI+NbwHwRWd1HAeNyvG5csL+61JkJnmWBXx2qeQ9yEIqCsckywJKynt5IIkw1wixBoy6EMktVUDZUrn4E4IoluoJ7ThC3VtivNsWZr9JD8vjAw/imdhCTHi1GRL1y7pC6UPv1xmLVKiVAlsBBUO03YiZbjyvDnVVKPOkJvd+/J3ipsjvPzjCPIDj+RDONvvT6XfPyK1HCpxmATk8M3CZ7sl9CD2EQbpwVQ7ODQoYdJ+L4wsn/M9SQr8am3oj7RqEk5rioVBSkxg2xQ56Ya3nTJzKtezRX59bwKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f42/5KNgx6PzQdGDLVZ++2CYAjIAXWrmaOSPAY91JDM=;
 b=RyOutgtsZgHRYazAGdOWcqWePCtOXBL62Ov/kfW/yqqXrQ0ZUZSAck025SThbU7pdoVXkGwiCtW7493SNchWS2RUqhD1tHjSj1RGBu0Yvx/1ojEUbBHr0UWCOJ7UbUpgrWbh8lvKKf6STIfZG4F2k44jLUjE3TJA0BMGdFAqLvO2rr2x8NwWbRssIA4arIGyd/o93Q2/R+QNoc9OMizOsmG6+D+Ay3kQBu0ceXAt9mISFdl2T0ZqXCGi06F13lt2dRppMoC62t4dPnQr6D+LgrrxugTF5y3LwFOFVwRzEqgykAbZPxFAvXFv6QLWNo9mXfWhXcRiCB8oWxd/XAFi9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f42/5KNgx6PzQdGDLVZ++2CYAjIAXWrmaOSPAY91JDM=;
 b=Pl01Ox9zYtwGnBwMRzRtsSrb6JEWdfOghzpmbptCHyj0YgoTLISe/YWMWlmYH8PpROedrU/zcOLCczlh8CSVZA9lxvRkWqnrL5Qj8hXUT1OTiNBhsqzEGeWfUCsoXCXEIvN2zWT+KDKVr3LWCRk6prQresL5RkWHG68PaFf8AVXSySssPAAAHdiEuJUTs7Fe+VxXw1+Skx3oW72v3444NyA9p0HJTiGhIad/4bEUT5B4R1wbYV7+zjcYv8+YvtlWcR5YLqiHhfZuQGpMEqfOMtEV+6LaaPqn1xpUpnaseSJWyXI5uq9UP8CitkPujdUo2B5QUj83k7iuf5NZ0OfK5w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5501.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 30 May
 2025 17:32:45 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 17:32:45 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v9 3/9] imap-send: add PLAIN authentication method to OpenSSL
Date: Fri, 30 May 2025 23:02:16 +0530
Message-ID:
 <PN3PR01MB9597C330AACC5BB89FC0B143B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g6f2668de07
In-Reply-To: <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250530173222.20211-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f16572-52ef-4003-10cd-08dd9f9ffcdf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|7092599006|19110799006|15080799009|8060799009|41001999006|1602099012|440099028|4302099013|3412199025|19111999003|12091999003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ds0g8d61rvkFkm/MwPFuLCdtrodMfjzrug84l/1scFlz3G+ORIh4m2ZSv5Uf?=
 =?us-ascii?Q?L9GkLBKRStJDsv+lZ/Lt5PRq9/q3Voqm9QcDfATrMZgc/mjAsvsA/ZPVOUvW?=
 =?us-ascii?Q?Imr85g4qFJNGzCP78Xb+yng2VIJdjWM2HoFbS0rDwHRRcj1WCyOpw1pwVdt+?=
 =?us-ascii?Q?6EzNAY0nkTMc29dNAicdxc0A96vnWo8Bm1uLiIgZREz1HjqdQaU3mm8UMwjy?=
 =?us-ascii?Q?cFUnZpgWK7il4S1BOvDZWjuoMQ4vfTFeDBwdc0YJuQgSFCCmyna/0AfbfWHl?=
 =?us-ascii?Q?dhzALq7uOIGt5p56y5B6uzI0vegjHdlRuZJ0F1b45jFgiTezoAAlKlCQLpaV?=
 =?us-ascii?Q?l5b1jwkw66dR6ZnLaa4oa48cLEAhT1Ozh6YUCDpPNRlasG4s4hWOumoUpzdr?=
 =?us-ascii?Q?P0PuJhiAt+0JEEft7zKP/bZ1/VHVZ2nWcivFLWaaq6w3zTL8RnUoIVpICYcF?=
 =?us-ascii?Q?QcOaKE+PBq3Es+cNWo2YDqFGWrVvT4uVZnubWNK0vDFC/zuFZNF9gZldIu9P?=
 =?us-ascii?Q?JpeacWvX3WoW9xldRK9RgquBRh6IVPVAeM/qtHr9IOpd0I7H+2ov/ufV0ozb?=
 =?us-ascii?Q?DgxfidLcUrYjL5e1mVS+l1cSJc4zGAqUVocUrZY5LCA9Cf3GSAKeHOrmU0uH?=
 =?us-ascii?Q?g/I6t6ssvpx5WiOPMvobFhO+2hmyG5Z19K6yOmegnqfzSn/eeu9gJLpD9WkX?=
 =?us-ascii?Q?Q0MjIFtLqGpJ/7yiRNbAGA0d0pMZ385iBNmd8/If8u8IihOH3X76+8Pptt8T?=
 =?us-ascii?Q?LycgOVcFLYqGIXS+88RCgcyjBqwwM8c6BGNnXtKkxiY8QwJG3uoWLlkgyZhi?=
 =?us-ascii?Q?Cm5AhH2dbK9PjdkhT4jElJ+byHvaHxqfsr/J/m0icd+lOcN3+rEoHvQJm1RO?=
 =?us-ascii?Q?xL/+1qtHLc5TaCeHz6t669WcM17e6WzwIzQNKllbF6CJVz5DUy1QNqm4Z/G/?=
 =?us-ascii?Q?kr6QAbRVpzV3iWPnChNiXgp1Ehqw8AWBGSd/K3JWz5Ait309UgeN4CnUTCdt?=
 =?us-ascii?Q?ohBpSNB8aBiIiYNsF7ktG9ceL1TARo8l8w6kNnW9QnItQFvSYF870oEXdNu8?=
 =?us-ascii?Q?faxVDJQ8PRHAQuqgtVuMHJ3mNnu+7xkY28Vr6iuvxPehUOuRjz1ug9LCHKxj?=
 =?us-ascii?Q?cfze1Plmuz9HO640qvc/Bt2uGhn/0tB5LiLqncgZHLLgTUj2GKZOEN09vYxV?=
 =?us-ascii?Q?MP68vU3C5T1n+HquaI42eBtX9JfJuT4pO/LfnnVtDJ6Mxp1sDf1+ehnonzWD?=
 =?us-ascii?Q?5ZEZxyKtIoqFdZ2ucb+95yUU2tNO6HBwcfl4RnOyHJvhJyrSOeZ+7gkLSMM+?=
 =?us-ascii?Q?2hEofCD/he9VZlIrDtOuKyW9hUj9c8d62ZR/zHqsBuhH6jSCoUy6BMSi02kh?=
 =?us-ascii?Q?/lOPCFtcZTrdrmQxVo4hzPPi9g/B?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1YXURV3Sh3+JWWZmCocbDZ36zVbYHF92RTLZtrHI0HtOALR+g+24rvxxFix4?=
 =?us-ascii?Q?BXd6fBdqmoakWfTOMFpNH0AyEmUwfVNzuoBxbI2QH7nZ3jfABzkI9GdO8lks?=
 =?us-ascii?Q?5U3+gRPmlDM7VjaKK4kfJGNZ4VjOi8Yacm0eev6oEHXrazSVycKfXPaHc+pK?=
 =?us-ascii?Q?zE1KnGienjTkyQYdrj0+YpUlo0jIIK9DhxumnGpZ0GXGFW0ANSfLCOedm507?=
 =?us-ascii?Q?esN0CVBwv/jdW7aagPqoryRnZa7zjjqrO39MudMbYAtl0Ep38Kf1tfp6KPiP?=
 =?us-ascii?Q?BqL09ypeD7vYsB+hs/z3gwhmuQB5stIQjgb/cZS2Es6LDORNvCkl2x9yJ37q?=
 =?us-ascii?Q?XSITTVy7rL+lA0FOtySPIC5U32u9Y90ATj0JQg45RRr175zz7TJsCpSX9fBx?=
 =?us-ascii?Q?mx+e3B0rkKgYwARsviLbFVhcVRx3HKpwhc304pZ5AWtO4wtw22M4nw9V4W0S?=
 =?us-ascii?Q?Po8Ih75XYyOSRF3iZSRoniR+Bs6SIcRKrbdQ5gNRu5xN2IOcaYNJ55wtrTdW?=
 =?us-ascii?Q?rA4smXTLxh0bXYaDW5WgeAkRBxbmw3yya0pabTy2FsTa8ULfIyCObUKK+BI+?=
 =?us-ascii?Q?mIefyXgCe+Rby5zo5CeH6nK2zPQ1VlUqASp2U7eqTJbpImOivetavzBPG8R+?=
 =?us-ascii?Q?lw1WyZADvR1AyTO3gssqQ4fPOnPk5Z4hUv+GbbkpH4d9QUtYEplhXEzP8l0p?=
 =?us-ascii?Q?qQW4SyZ4NgwmdmsRjOD1Ys6gfrNlzoIGNZzImFtpZt0owoDajEHMQODMJKc2?=
 =?us-ascii?Q?77DehI97XJbPtY+Td+U9r98ttndSpL1qyJd50o/kxBi1qaoK9NzpTQlC0eYQ?=
 =?us-ascii?Q?NNinUEy0KoW778kgPIYFbjBorVqYANXZWkflk7qM2twiWyDeUy7M9z2UkZYg?=
 =?us-ascii?Q?kPdUiSNLZDNMPBqgZUybtQh6daWX60drKyyUdzSI1GVZH/OW38Rhp/kkIoc2?=
 =?us-ascii?Q?jaHIMu0Q26nahTxjg+CPnsR89ufDG0JDr3moLUXzR6UfFTtDbEzWIGr9md9l?=
 =?us-ascii?Q?014l5dSr103KekRtqwnXE0RWOLeCTia4kDdtm+Jbb1ynKoMiwOx6H9FE99tz?=
 =?us-ascii?Q?VMyEeUyeZ9GjcdyxZQ/58DQVISrq5CNvWdZvULdEp6ml+eRrpSeFQhBv6e9D?=
 =?us-ascii?Q?9H19ngF4dQyZA8SlAy5l6WbqchStEQEq7s1ori2MIV6SndJ84yUEDTnM6dMp?=
 =?us-ascii?Q?LJBlsObVKoRRecUfjQVpK1lxqP/WvolcwH++j2WXallMFQCpMYhrQuBQPobE?=
 =?us-ascii?Q?qnO4TQQrz+QCEbZmIMwtMVz1tVi62JF689jvYcTq2oovECPl7fATCjB6OZ5l?=
 =?us-ascii?Q?49ufEoOodkqZwivpLFQjTDfm?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f16572-52ef-4003-10cd-08dd9f9ffcdf
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:32:45.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5501

The current implementation for PLAIN in imap-send works just fine
if using curl, but if attempted to use for OpenSSL, it is treated
as an invalid mechanism. The default implementation for OpenSSL is
IMAP LOGIN command rather than AUTH PLAIN. Since AUTH PLAIN is
still used today by many email providers in form of app passwords,
lets add an implementation that can use AUTH PLAIN if specified.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc |  4 +-
 imap-send.c                    | 80 +++++++++++++++++++++++++++++++++-
 2 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index fef6487293..24e88228d0 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,6 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
-	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
+	option, the only supported methods are 'PLAIN', 'CRAM-MD5', 'OAUTHBEARER'
+	and 'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
 	plaintext LOGIN command.
diff --git a/imap-send.c b/imap-send.c
index 0c7844aff2..c07ff98c3a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,6 +139,7 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
+	AUTH_PLAIN,
 	AUTH_CRAM_MD5,
 	AUTH_OAUTHBEARER,
 	AUTH_XOAUTH2
@@ -150,6 +151,7 @@ static const char *cap_list[] = {
 	"LITERAL+",
 	"NAMESPACE",
 	"STARTTLS",
+	"AUTH=PLAIN",
 	"AUTH=CRAM-MD5",
 	"AUTH=OAUTHBEARER",
 	"AUTH=XOAUTH2",
@@ -851,6 +853,40 @@ static char hexchar(unsigned int b)
 }
 
 #define ENCODED_SIZE(n) (4 * DIV_ROUND_UP((n), 3))
+static char *plain_base64(const char *user, const char *pass)
+{
+	int user_len = strlen(user);
+	int pass_len = strlen(pass);
+	int raw_len = 1 + user_len + 1 + pass_len;
+	int b64_len;
+	char *raw, *b64;
+
+	/* Compose the PLAIN string
+	 *
+	 * The username and password are combined to one string and base64 encoded.
+	 * "\0user\0pass"
+	 *
+	 * The method has been described in RFC4616.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc4616
+	 */
+	raw = xmallocz(raw_len);
+	raw[0] = '\0';
+	memcpy(raw + 1, user, user_len);
+	raw[1 + user_len] = '\0';
+	memcpy(raw + 2 + user_len, pass, pass_len);
+
+	b64 = xmallocz(ENCODED_SIZE(raw_len));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, raw_len);
+	free(raw);
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
@@ -951,6 +987,13 @@ static char *xoauth2_base64(const char *user, const char *access_token)
 
 #else
 
+static char *plain_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use PLAIN authenticate method "
+	    "with OpenSSL library, but its support has not been compiled in.");
+}
+
 static char *cram(const char *challenge_64 UNUSED,
 		  const char *user UNUSED,
 		  const char *pass UNUSED)
@@ -975,6 +1018,26 @@ static char *xoauth2_base64(const char *user UNUSED,
 
 #endif
 
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
@@ -1207,7 +1270,22 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		if (srvc->auth_method) {
 			struct imap_cmd_cb cb;
 
-			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
+			if (!strcmp(srvc->auth_method, "PLAIN")) {
+				if (!CAP(AUTH_PLAIN)) {
+					fprintf(stderr, "You specified "
+						"PLAIN as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* PLAIN */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_plain;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE PLAIN") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE PLAIN failed\n");
+					goto bail;
+				}
+			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
 				if (!CAP(AUTH_CRAM_MD5)) {
 					fprintf(stderr, "You specified "
 						"CRAM-MD5 as authentication method, "
-- 
2.49.0.639.ge2dd5d9d81

