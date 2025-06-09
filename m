Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1B21421F
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483771; cv=fail; b=P7UysPdNDmz5Uiss/5BrcN/6ukzmBlOVyBqGcjt0IdCgzBz3Kfyfw0t4mrcGawATJWE/gH4OdgYFcE3a631mxgKh1vytQGWtrGYxUSeFUguLmZm/Obik9EgJHzcpGflOButcBXhvQ8ROA7ET6A9fw6q/LOio+/CW/8qxYOb9xik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483771; c=relaxed/simple;
	bh=hDPsp8vqwm5wCFbhxGdE2SpfkQ2UHpFYNOIGww4YNlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fJRzSD/o/zj4V7xbxofi7PIT/0ZgZENFAzqOJ3096Uuurb4WTIIicazhSxsehQrrUpl7pwf4HpO7ht2mD4G3YIXtB9E1tvZZWcjLRAkQ1Ru1cPtf2MVtyIwbiOGMKrf5YdNg/GcgHsF2AZTUz+nZ1zyuEGVDjwjCP/eK2OYLUNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=sBtNwROU; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="sBtNwROU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP3O0IIxju/Xc65eDj0lOJpOYwjg2k4DFN+Crs61rVaxHVu6gfRLFTPs2frh2Xx3V1PA1ggjT/O1PfkLCHfjqPr7N+kDe12wmQNKS9vgKiXy0W2OqW5TZIDN4vEh8Of1sZwizi7O5jt5JnOsm4tG7WIx981QGLwvPoBpArWnFGKYBkG50CtA7DPFSlmcRBtf+OX65PeTWusX4JLbMkvdPGBV+hDbv1HqjKnfHvyedmHOHZb0nKc1flsB2sZEGiMtNyGOWPsBKxU1KaupAhsZSCgSOT8jeqXv8+/qQX7kB10mHSt9LMYoA41yaHG+d9fOwBxz9wygHY3TUzlJJQOZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr1++ic8fNe2S8o2Gh9xNFmpe6cN7EprTQvp7kQqpu4=;
 b=OJOtFB7WKGDUMEKUn990VOOByrLowY8IYGAhd124yyEheEL3yADrp2/TEh7YYfGjy1VdZBT8oYfyoqR98nKxFUXg++n9U/dQX6eTReDIQvDr1J9le7VjGY+36N62GqkYknVbFErVua9yrKvEy17YG4tFa+OGkmWhx9TCoI9iVCkszXs6tjTwh3zFQI5lDoe0XlsRzg3EOfz8gohvdN0HmVviw3fxylI+r0xpeTe2MFjboosgzU2x+cxlxKqKDHP85T1XcMq0GEV2vpa335i7wTOoMysUcfa8+vnvGHLptRxvBuM0zAgGjW3CbC7UgblQzj0985EQo9xl2gvLU9WBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr1++ic8fNe2S8o2Gh9xNFmpe6cN7EprTQvp7kQqpu4=;
 b=sBtNwROUkOBJirsWIFtspfpQz0j2TtoFk9fo6UXQeii4MlU0XRfFrFMKl0DtMHYzDBEfm/hW3uf5zMx362q8+JpElkD4MsRbZeY7zJvmkVeopeVhJATSxzNmXba5tiqBW2Ai9Q7E+UrY1j44JmrULGL4XBRTPySCh42NMxq8j/ZY32I34TeKdneN1gRSp1l5pEF7GHX50Ad8Ntyys+pLN5pCXXHiY2Q96jbppabf6mLt+7q65lY0jlTBAcHlQO6C81jSeDrchApICGRv+w+vJiGPX3Qjx0C+7/iBbG4QHE+sqxoC89ORAf4vDINeOzQETHobi8VbsaotR+5Z4cm8jg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB5751.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 15:42:40 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:42:39 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v17 05/10] imap-send: add PLAIN authentication method to OpenSSL
Date: Mon,  9 Jun 2025 15:41:24 +0000
Message-ID:
 <PN3PR01MB95978AD187B9B205BCEADF44B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.824.geaff4db692
In-Reply-To: <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609154129.13552-6-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 596333f6-e25d-45ee-64a1-08dda76c3ffb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7092599006|8060799009|461199028|19110799006|15080799009|8022599003|41001999006|10035399007|4302099013|3412199025|440099028|19111999003|12091999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fKna0JGF4/S57jJPnv8See5GOTCEOie+I6452gktIOU0axlMlBHenkRhebY2?=
 =?us-ascii?Q?yxVrXnfchX52wYyzKicIDSROCWKo9+mg7hFqNivtSIO5y/KaxJSvy0/++D4w?=
 =?us-ascii?Q?BooRKNfldYsfM8ZTClSgpH9IIrXGbYNOHbmGkxz/RigGt1x72TUxGkD2qV+N?=
 =?us-ascii?Q?jH3TciJdSkhyAw8sgI6UZ4fsXIFTB7bF8zlnngaeppKFibu2S4ruJuHm/zLA?=
 =?us-ascii?Q?UsEajFS8F1HgYDuyWyyvqM0eJbeB6o/ItGJEcSop3eu8Ntmjv9K/aaFOKweD?=
 =?us-ascii?Q?X9lZBQsaQ/cu8Ia+miI8QTjHwbMAVj8aC2zA50if1Fzatvwe+B1Mqk82eTHQ?=
 =?us-ascii?Q?mf+/x3hehisJJol+dglXREwimqnNMjYWAxztqF43h0Ny6C7UiTbpyVvyzS6E?=
 =?us-ascii?Q?YcgG0eAB0u0JiW5DZq6pjxexmsOQYHFSFwBDoENyIl8ybw9tGxbmxI6o95pv?=
 =?us-ascii?Q?tKTTiMZbHtQ3kpWGKBuFrCr85TX/t0GtKlknFUy7Euz7lSQ9CVG9TVbo2A/t?=
 =?us-ascii?Q?KKTopHKU3Hq3u5QSm7hp4aSuI9EQGJEJ1kU55DOoDXy5e8ESVS/6dJRcbtQx?=
 =?us-ascii?Q?ff1gfJJapGzkMs1ndtFbET9KZu1M61Ow/Z8YXT7vyhrXRvB5GsdXUc/gJ3dg?=
 =?us-ascii?Q?XxZJ2pMyQLESvaW9W/uRNZ3ofB9x2p3H/jQSJrYvHOcbzAA9iU1uFQcykECq?=
 =?us-ascii?Q?x9QtFE02jYcKcx0Zcbke6aDNIyGNzHNbwI5ChadTKz+447gSAAN9FZDmlZcj?=
 =?us-ascii?Q?K6gq1RwbCzf87D9HJmIfvuc7k86oMqwrqEVZ3zAipWpWN/iMvlo+rHIWJbnr?=
 =?us-ascii?Q?98JswVXRS3brTWLb9oluTk4GtVQPQAsouoYagdbRYeaNkaEBdk+lQ+AKhPoh?=
 =?us-ascii?Q?soDyoiww8ARrRriLHUZZ/dg88itRBimzu1Vhv7MI90T4rHDW4LFB1+xhNDq3?=
 =?us-ascii?Q?2gv8IRL4cd15XhDNQROvtmNrh/NixY2IVc2bTdeTY4Nwwbdc5fKWkMEItjOp?=
 =?us-ascii?Q?jIyQOKXiDijhNa+co8nIQ/XdyC4s2pabYwN0xYN14zKqCULfCaCqWPzpBVLZ?=
 =?us-ascii?Q?AQzr3nGzVL3j/GvuygAl3b5NxyTI82ACzx0I2izDjYWb7GWWYc9UPkK8u640?=
 =?us-ascii?Q?+FWsYk3bp6I+sg2zDTiRjS4rK6gWV1YY1FLcZ5duDQVCEEbJfJ8CWqHJAy7C?=
 =?us-ascii?Q?BP+PJiWSlW9OM4jvmF7BXDzC99DFxFiEzL00w4hjHtHPuP0PGCJXEt+5jhz2?=
 =?us-ascii?Q?2JFVDw7QR8X+DN9BE18wUANDpnx/5L/LAGmuzMBfxk+dUUDZMWcwAcToFNdu?=
 =?us-ascii?Q?kuW7xqn/m3eM+ChggPiUD4GWz8hhe/ua1ZBei+cosI8VpQi2CRkklZiis6ZQ?=
 =?us-ascii?Q?hr7dQqDyt/RaHJ+5aipkjYtucLmdjCT8u4WRPhWjN9kCZjE8EA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yS8xim7+ZDH/TpxSbSV2SsnFdInEDRDNM2P5uiKIv8Ovn1sHRE5HilWfi37H?=
 =?us-ascii?Q?txqmUeYZHpOcZeJddahakjzaeOsejNjuDBmBY4qizOnDOevUMsjc8Ej9a9wJ?=
 =?us-ascii?Q?t7RqvrXgUaLG5JaV5cMD+scbyF4ouyZGF23breKN0eSA0na4PNI5LKnzqXvT?=
 =?us-ascii?Q?7oRzyrX6COMfejMGF0cVMmRDe/y7c/yslIca2WTaH7B84Vsby0wJRaJTaAxv?=
 =?us-ascii?Q?DcUALv6uDw9vPIw/5ZtZyh7Bhi64zjhkkQiw9MUKcx75FGGHu0ldLt7VRgKg?=
 =?us-ascii?Q?9Mv9aS6AX2gAKp7pYEgZSjb8pza1V2vdtbVOAQYK5d5SJ9pTUlgBZv23jW0L?=
 =?us-ascii?Q?wtSf83dtya6gdD3fKuSg6l60ChOUNQ1Nw7BmjJCQxc5tkmz3B/warCJOwegn?=
 =?us-ascii?Q?wOwl7Y1frr1uIaMuPGk/LI9jQGmaVY1V4uu0ErRpoR8En/IrhGQZXAnqHpxO?=
 =?us-ascii?Q?PCYABB3UBjgG2ndSm4ed9/gq7iygNTlrIw/1GwaNeGMDNf8L0uZmEj5YLkyt?=
 =?us-ascii?Q?LUQw+O+SV+0xTBqb5OiP/1Ty4piwnqVhGjMVl18ok+JYsHHuwiiqpMEtl16T?=
 =?us-ascii?Q?lCgzKuPtcYTWUisL2VTHIjnGdf8swAhtkv8p2p40E3WBNrMM8XntLcUfdSuB?=
 =?us-ascii?Q?DoUBiY9GEkOIFo4rjOUXB584viY/ETYRZ/ZbNwWJg/84Lg77dQbk8UO0TnDh?=
 =?us-ascii?Q?KSkkRJLsEYp3ebMgNsZ6YJPnJp44ua1g7JTH6JiUAsQS0h8L+7vPjcak/+XM?=
 =?us-ascii?Q?1m8goNxGrRx8hJnJjLjwiXj9t/cEWbwg9a2l12AeXz9m92CxniH3ZMYHcD+s?=
 =?us-ascii?Q?eycYVX15pVQ5lUIEvTvid0t0OVy3qCsSLZhEljRn1qYaPsGzlpO3nikjsWZJ?=
 =?us-ascii?Q?H8e2aMK7HLXaRwUk3d+5W3Cq9Q/HG0BwNPdqnr1KHmPUJHicH6Efjk8EevGO?=
 =?us-ascii?Q?rH22ja8GKm8oaFRPdza6oZpLb+DqNbuxtRVBUbK6nbR1xsram3O/PnAfL6ev?=
 =?us-ascii?Q?KPm1ZwT1KtFKDVRhvq1kOZQ7poxTKD6GzLpQw9gCJskiNYqqnxj1uLhCIgMT?=
 =?us-ascii?Q?+Vrw9foFx5+iyCGQpKT4hK7mUk5tjpU3yRCyBkTfUN6xZM5IcKSLRZ8RMs3h?=
 =?us-ascii?Q?bjGGIGM8lRh8anIf4SBhv/hJ9Q+FdKRYCoPDcHkkfn1Lqmt7gvIzwmHjTucz?=
 =?us-ascii?Q?7eYjS4WZpZP++W/ZoOcfcsR9BFBnxhCUxTLdzqnUueiSpWiTnQli77QrFKg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 596333f6-e25d-45ee-64a1-08dda76c3ffb
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:42:33.0377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5751

The current implementation for PLAIN in imap-send works just fine
if using curl, but if attempted to use for OpenSSL, it is treated
as an invalid mechanism. The default implementation for OpenSSL is
IMAP LOGIN command rather than AUTH PLAIN. Since AUTH PLAIN is
still used today by many email providers in form of app passwords,
lets add an implementation that can use AUTH PLAIN if specified.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc |  4 +--
 imap-send.c                    | 63 +++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 3 deletions(-)

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
index 24eab86a1a..64f66ec67d 100644
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
@@ -851,6 +853,41 @@ static char hexchar(unsigned int b)
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
@@ -951,6 +988,26 @@ static char *xoauth2_base64(const char *user, const char *access_token)
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
@@ -1011,6 +1068,7 @@ static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
 
 #else
 
+#define auth_plain NULL
 #define auth_cram_md5 NULL
 #define auth_oauthbearer NULL
 #define auth_xoauth2 NULL
@@ -1223,7 +1281,10 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
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
2.49.0.824.geaff4db692

