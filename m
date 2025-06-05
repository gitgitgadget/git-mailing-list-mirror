Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010003.outbound.protection.outlook.com [52.103.67.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A12147ED
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112962; cv=fail; b=XNSvDJmu4M4RPJ1lfKNYKbUdGPHcR6RD9+oWO91b+OR48dn6HSzzfInE1u4PqFnojk/F5IMLTT98noy1kQ8y9V+NCNjJPUS677DAqiDsQyCEI2CM6ZV2unH6L1JGm94ZLnuhtz6DCmKz/7tHrihG4oN4GTsfKq0UKL3HJ1KgVaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112962; c=relaxed/simple;
	bh=L7xarbfWP3/HTy8+cAKGJPs83ZzGEvZmKTGzJzeflis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTLkXVt+Hza3W/jLGYH1e+GtzEJgVZQ9mbq49a3Pvg1J53ywwX1U+PWW1tCZibk/VLagY7pIVnKsJNDiFaDkKLQSlJDCHqJJ0/52lq8ayM77zcuHSt1DOtOCxnMsYXe+nEOeDp1ZtFfOylJbwE2iGxftweEN+HlxjOO9CGGcpoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Nc3sdUvO; arc=fail smtp.client-ip=52.103.67.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Nc3sdUvO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOVVNk8RSX2HHIZdnd72q/Up0fljiiMVtTWoGjxEQdy7YAzjPc84hwZLeiJVnzRibh6yBgpJXQgKu9XuG948sRNfvNWc4EpqFQPkU4Tc5uLUw/cvkvJUIFs6HOkFtycRZUTbYnDScp/9JBET+Qh+1Q5mB/TNaH5DvfD+VMLhiKvdTm13aVru1QAAyIFHAM8DkfLvVe7l1vePXo+v91LToGNaGqSOMbx/pXBuCS4bNqympUEKLU6grivU9RPGOqJda0hGKjXTHvQnEAstBXSFOIt+nHhmDY0Zg181KI3ZQBa/HTaSBk5TOVhY/Pbgwv5YqT/xEACwQWbjnr2kVto/5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHW2bCzCZ+hiN87lKJu6FO7QsBAj8HS8eVLnCN3f3oM=;
 b=oiA3IzOXP3ZuXsqsrU9Pwb4/T9toJkoC50cm/PFOBz57o6ox9lIViQzKdJUuflCsuM4yCkqOfSqHkPCODk0wCKTVdTt0xdXaNybD4Jr/plU2vHERjGvTNgSRnjrl42B15itjzQ2fAEsUJbnx4VjawuIaiEmklm9sJzAi1aRmckJfft9UmtoFHfNh5ji652DJHY6KmKKtBRPmlY+JgNGZyv7BODbS11eFrw50QIfVS1TgW5oZm7afD32E6h5DBTrvMHC/0nlRYPwe9vr8XWGxxAeuVEbwJlz9I6/tiOlXqSYyXLSJ8bZ/l76tpnSmYHLAPDF9fn1TsEk0JPH8RUgaNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHW2bCzCZ+hiN87lKJu6FO7QsBAj8HS8eVLnCN3f3oM=;
 b=Nc3sdUvOX4MJ3SUPwrgps2b7tZH13Zuyr6w+QPwDx1vYlkA/bY+JcYOS2Q9SDZ1jTBWHA7493v8RsmbSmcFofbromTE+T4Z2FfD03OSx7gFTgTC+QW2WKCdxSuFfEaTVVpnIdNUErESCbFA1EyxCWrl+ONUznCcFfK8OOjqmAQk9Ipq5GdlVwT9zdJbA7SApKCDF8YTCuImVruf3f4wEB25lAXjx//AGFS4lfm/rk6JRduKpeNZfMvSSijsqgcuUNzmWTgZuw6/2MYwaI7WYJdKEnUiniNaEM03Ay3WQiS4SXspAIcayMouAwxYWIqmbsS8ebtDSrpAXSPK9XFb8wg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPFFC37E0415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 08:42:27 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 08:42:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v13 05/10] imap-send: gracefully fail if CRAM-MD5
 authentication is requested without OpenSSL
Thread-Topic: [PATCH v13 05/10] imap-send: gracefully fail if CRAM-MD5
 authentication is requested without OpenSSL
Thread-Index: AQHb1fXEdMqUvXO9+UyQiY1w/2X8sg==
Date: Thu, 5 Jun 2025 08:42:27 +0000
Message-ID:
 <c111ee6bc16f1acfa2f4fb6ea51b58f822d33182.1749112640.git.gargaditya08@live.com>
References: <cover.1749112640.git.gargaditya08@live.com>
In-Reply-To: <cover.1749112640.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PPFFC37E0415:EE_
x-ms-office365-filtering-correlation-id: 55dc58dc-6682-41a4-a332-08dda40ce6f0
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|8022599003|461199028|7092599006|8060799009|8062599006|15080799009|19110799006|41001999006|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?3StEYPYRAIRLNrh7eKLUbEOI5HWkF8MydtqgdU4hxiGklq47cpJQADviAq?=
 =?iso-8859-1?Q?88b48EAoYduAxLfkPBrdGGcc9hHGkB5HJFX9CduYTtw7STuKvbAiRO09Gi?=
 =?iso-8859-1?Q?ObjgsyTRKRKYB4O/zlxnrNFzzL0TXCyB5Lmak0QxSFAYcnUihaT2H7b3XN?=
 =?iso-8859-1?Q?XNzi8+yPnUkvX8DY+aV6qi7f6zTRTGUji6n6oaVNDNk5QGDoamiCufY7ZS?=
 =?iso-8859-1?Q?pBIW6K3SzZLyCbq9JFRypFrpW7gI1D5l7YxYZPpoCJpKwlGwwVbwVvzZEI?=
 =?iso-8859-1?Q?RRP8VjOttSFSYqlPrT4rT7TONOZ/LTlITFxFhjqW6f3AUTNzNeING7hb0D?=
 =?iso-8859-1?Q?Q+b5687J/RtALU1ext7YFeziOHrYrJTnMj0BVQEI3JXSmwrRQKwKof16L2?=
 =?iso-8859-1?Q?K/CEx0pH7AtB/Ie/5zGIvJdQ0b5N+14FnDr6hJT5sVfQOmT9jSk0oqgGoR?=
 =?iso-8859-1?Q?ZYxubweC5s/Uv8h9j38JkveEAmat3juSj6IUdzSR58bTmZ+EwNMmTgcXhD?=
 =?iso-8859-1?Q?fF5Lue5iVIKNJS0dwdQdwNHmojoCuzzyfP5FPJE1GbHca8ag4ZZOjVeJ+o?=
 =?iso-8859-1?Q?NZ49QbX0ZIyg0PGJ76R6WpaNwEwEfboMEtHk5XB+ZQjA+B/HUr0oMkRq3c?=
 =?iso-8859-1?Q?zTuYIpELXt4VZjkdkHitrx2tot1akwfz8CnH9kzw++IOOE4nN3PxZQniq9?=
 =?iso-8859-1?Q?2OylJFTHsPim7DkJYzn+uNdeUChRM8a+Buc/1xH4M8OhzuILgH3OUgOW7p?=
 =?iso-8859-1?Q?oypEAzKcajt43ZCLpuh1gKUfb5/GOmj6Yx1B0KLyzbVuDVXL8e+sL9s1u1?=
 =?iso-8859-1?Q?S2TDBg8a80v9jJK90d7uddwMNuOqaBdV//jL/TOFOw7z5g2GzkgKGHTRsD?=
 =?iso-8859-1?Q?Phud2drqaG/nCrcgzqAd1kH2EoxBZakiU3a0oaXYr8MvxPrfur+94ZMYC8?=
 =?iso-8859-1?Q?nCDuYRfYusp05UuXClhytwVVfI9F2WnhgSfkHqqFJ7fFGmw3hSVNUNfSpp?=
 =?iso-8859-1?Q?KqC6DxfqkZJIY7u0B26cdCpfFdYfpFfQ+i7QZcmN/HmZslyAwNkIHMs8NC?=
 =?iso-8859-1?Q?NOVNxIpp0VizzIPzXh3pPeFkbc9JXYoQw8jlMF7afIl9pZEVYnMOsFNu0A?=
 =?iso-8859-1?Q?QDO9pevj1ahyjCUCwg+bQOlDwm+JxTih1rqyOoIQQl9w14ggA8C+0FG3AG?=
 =?iso-8859-1?Q?lk/6y1z9CSlPEOcnD00Lpl0Z7d5Cv3y61G+YQDUrlkSydL8yv+Vn7daaLC?=
 =?iso-8859-1?Q?mFHZ8BEk1ZMx2qEzOQ2r60uv/zxifAzzoVzf4eCKE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7IajXRQ4DwM11OC+S9UWrsjOkLiNmvemWaeZ+ICkeD7KfE9hrAiyDTBhsx?=
 =?iso-8859-1?Q?erTDdcQU+5UFLBFRF6dnd5ZarAGCu2x9t4W915Wfz0ok+GUjb6xWPlV0pP?=
 =?iso-8859-1?Q?fVnl4xtdCEJ5hKah5kYOG12mciqCMIjcKnWL+J0A1Pj9GvK1kUBN5/LHYH?=
 =?iso-8859-1?Q?grewOq4YiTUIG/NBYAfP7K7WdzFHXA02+UcoIJjB3pHKnZUYMdWsH+C0yi?=
 =?iso-8859-1?Q?4NoM8crsLDHm30Z5AwF4wdTZ/lWwaxMEwQvsuOCpiZOhWdiAZkv73PWkXi?=
 =?iso-8859-1?Q?EW4pFlXT8WRSKfCBntd7oVcKBKGa2OpJoJtG0C7pgI4mVAyMMNQJIHi708?=
 =?iso-8859-1?Q?v4ApqKoBgHyTyLyst3PNaH7GhUVBxwD84QDYKyZX+jNAXqJFvKYysL+jiP?=
 =?iso-8859-1?Q?IA2F9NtWGNQQedKvwDXSk+6kbrNEK1jJXfxCd5VYZt64ibSpBLyMeu8HL7?=
 =?iso-8859-1?Q?KPcXut1NMm+RUq8Jy++uXaGHUSlKLjMlYfweDnG7bBnUoZlJePfkQUaWqF?=
 =?iso-8859-1?Q?D+DpKcIBT9BOB2zdixddNNnqjXUSwqKHsFtGPRPoR10/YExsMhVKT/lla9?=
 =?iso-8859-1?Q?A7Tf76ZpHizqZl6nD6OJ9OJExF6VQKIlYBH/OwZYj/rnNxSg6sAigA/CBL?=
 =?iso-8859-1?Q?KWbF7MM/om4QztmhCWrVI5xnQ0kc8cIFsBvPEPMlfEE2ZfK9RML7HUBeO1?=
 =?iso-8859-1?Q?5401neWJpx7T4OsPY3cEN4lq3Ej4aA3V6Jw7wu5K6W791J2bC9vVmkJdgk?=
 =?iso-8859-1?Q?b0/zT/Ro+H31QmsYXuRB7b9pdiC1f3/cKZEV7QtD0NioV0z7bw7wjhbM9y?=
 =?iso-8859-1?Q?q7F3dfPepW5eVKm38huah/rb5qZZtl8fOAqUL0ftPxUeqmTHFJR/UIjodE?=
 =?iso-8859-1?Q?98wj+2X0woqOLj62N1uZPX+JAq74399X2Z/vvsM9QC3/0Mu5uEhV4nheFP?=
 =?iso-8859-1?Q?iDxPulYfTQ39LDrtMD+6Lk2PFEsh5RY+1Mpzt1b1fF4th1O1R/r7aZSGWn?=
 =?iso-8859-1?Q?ae1pckCU8BARCxX1PWfIOmlRLbl9RqP6YCZ/BNCQm9+R9WQnlSOAmUmM0D?=
 =?iso-8859-1?Q?aLiF07cOHfQLymGFA1tapo0KNiu56YxYz4ZJdDkjWR+28mUT1X6fufNFlp?=
 =?iso-8859-1?Q?tZFBYL/fgfX4swAWEg/YpXUcF9qx9PXL3jAI+uqCu7t5rNvYAtWi7GlFqH?=
 =?iso-8859-1?Q?GK7mHY0o3JaY7H87PWpkDtf9DOe2ai4/lXqSRPB5uxmwR153I8BzKjI3P2?=
 =?iso-8859-1?Q?1Tl0TcMKjyjJN4jBNQi1cI+/ye+k3sXsngdeH+YvQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dc58dc-6682-41a4-a332-08dda40ce6f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:42:27.7457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFFC37E0415

Unlike PLAIN, XOAUTH2 and OAUTHBEARER, CRAM-MD5 authentication is not
supported by libcurl and requires OpenSSL. If the user tries to use
CRAM-MD5 authentication without OpenSSL, the previous behaviour was to
attempt to authenticate and fail with a die(error). Handle this in a
better way by first checking if OpenSSL is available and then attempting
to authenticate. If OpenSSL is not available, print an error message and
exit gracefully.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 072c8f4e39..6c7175ced0 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1008,6 +1008,24 @@ static int auth_plain(struct imap_store *ctx, const =
char *prompt UNUSED)
 	return 0;
 }
=20
+static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
+{
+	int ret;
+	char *response;
+
+	response =3D cram(prompt, ctx->cfg->user, ctx->cfg->pass);
+
+	ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(response));
+	if (ret !=3D strlen(response)) {
+		free(response);
+		return error("IMAP error: sending response failed");
+	}
+
+	free(response);
+
+	return 0;
+}
+
 static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNU=
SED)
 {
 	int ret;
@@ -1050,38 +1068,13 @@ static int auth_xoauth2(struct imap_store *ctx, con=
st char *prompt UNUSED)
=20
 #else
=20
-static char *cram(const char *challenge_64 UNUSED,
-		  const char *user UNUSED,
-		  const char *pass UNUSED)
-{
-	die("If you want to use CRAM-MD5 authenticate method, "
-	    "you have to build git-imap-send with OpenSSL library.");
-}
-
 #define auth_plain NULL
+#define auth_cram_md5 NULL
 #define auth_oauthbearer NULL
 #define auth_xoauth2 NULL
=20
 #endif
=20
-static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
-{
-	int ret;
-	char *response;
-
-	response =3D cram(prompt, ctx->cfg->user, ctx->cfg->pass);
-
-	ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(response));
-	if (ret !=3D strlen(response)) {
-		free(response);
-		return error("IMAP error: sending response failed");
-	}
-
-	free(response);
-
-	return 0;
-}
-
 static void server_fill_credential(struct imap_server_conf *srvc, struct c=
redential *cred)
 {
 	if (srvc->user && srvc->pass)
@@ -1287,6 +1280,13 @@ static struct imap_store *imap_open_store(struct ima=
p_server_conf *srvc, const c
 						"but %s doesn't support it.\n", srvc->host);
 					goto bail;
 				}
+
+				#ifdef NO_OPENSSL
+				fprintf(stderr, "If you want to use CRAM-MD5 authentication mechanism,=
 "
+					"you have to build git-imap-send with OpenSSL library.");
+				goto bail;
+				#endif
+
 				/* CRAM-MD5 */
=20
 				memset(&cb, 0, sizeof(cb));
--=20
2.49.0.639.gf77f2423e1

