Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC819F12D
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748761944; cv=fail; b=mWYUI5uOrDqdIRo6FG0sAG9vhHDXMn91fm7G2jxJuRFEKpXk79wd3GZwPrCAvwcEPmPfsSn9gCqxFho2SnBcrpR0WK1YsCZmD5OBfm9Y7EDTTYyNMzoIIq4/m9psouVwhkhKF8LG8Z/rfaE4z9z17VbF3PJ9SoRMbg0iXpQO6bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748761944; c=relaxed/simple;
	bh=yz3bFxO+z5MNpDkm6ap3irx4SHKyaeX82L7Tb4NXx+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lFqciKnVyCHrPidrpLPM0qR8MArRSqnaYe2fcDVmHPt1wqztDhXSRmOkUbcI7PLJ+AL6A8Dg25HTJDEp/284T0fEu25t+5zDc/KbDeGWrxwWOpBaJbrvc3HNJgSVVT6pPNL5ch2NuCecJIVNnVG3VWO5JWu3sA6fXmbo/ABFYUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=o2xg0Ztu; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="o2xg0Ztu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgPfsgmnDlUt4HhIm+MSwqn+2Tb7CDVtMhNuHn9BkQjstcGtqeTXCNV9UjOyInV0+90XzdstO6vbdatZTOUKrD7QEVPFr8MDV7z14i1KBT+3HNKH6jK5A0+6cxPWPchFgxnmwan2vJcTW1KmA21JAWox8UDYH+uzFaPtdPdoTHqDCrKpAd5hq+audQNdUzazgQZ/Tv3PaI7nvdsirxdNrjUVrWS++G6D4VfpyxlWJsXP39ke7QFCWeN4e2vUNXWuEomIczdE3zsoopW09BQs8rkHVBBl2Up1jGrPEDk+vIv/W6TlXZV3wMPtnl3QwC2OGB16wjln8CdJha31+mO7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP7VM/w5W2Pek0JVXY0uguCyfGy6zeeDcps3ipz0Kxk=;
 b=jV4pxluxQDzmJsfqB6k6JjEVykdAUSBhGV9wr6Rzg/uDvAEDNtYVVIRa0+TWuN2zBJWiGN6A5kdYJLC4qHNx3UUPfl37iTIIbnFRt4GlqVr8eyePLzbmyXb+MjyS1IqWiLKnpxtklBrYbXNnvA5xVUlniGEZdYlPg6OuidlJPb8J9pnZNMEQx2jH8iYGd6tNIaH33K+c57ApKlH37wCZUZmTmfnyZMRHoVy1EutEIaYCR7JUfz6wYS3v2sArVfczz/5IYbyMqzmoiHrpwfwO0h0iJRYmAcy9CZCUGUGdsJSLxCpkRj5pjWP2kDGkQ+8sV+FSkB1iBZFuXM0N+8Derg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP7VM/w5W2Pek0JVXY0uguCyfGy6zeeDcps3ipz0Kxk=;
 b=o2xg0Ztu3Z8W4L4LfGpDD9lOwqCCBc1pJHhIll4JvpQU6CsL695CaxogR8vvFWCJS1Tldjt+TWj90EOK6B5WoL3RosjWy4UBK5hPluGbZQM30AXsSzlAylEDEKIEYh6NwI8LdNaLM+Nv+OZ0ia/Og2becZSLIR4zT5Ojrmzztb0fbBHIliP9LokZO4i+515Xy5091mVM6ffsvppexpzZh21NKiyhz/cXXoOVRkFQ3TkzygcmrTmI0B/aGXkcyWwS5ngMCbThlmEOSVjdJ6ZXNMoMAk4TRQrEMGEszLlvhZgxXQNEWeYTkis3e1dLzdApwifF9ur2UFXhOjsRE3Mw+Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sun, 1 Jun
 2025 07:12:13 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 07:12:13 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v10 6/9] imap-send: fix numerous spelling and grammar mistakes in logs
Date: Sun,  1 Jun 2025 12:40:32 +0530
Message-ID:
 <PN3PR01MB9597A33B17E07B461A5C276EB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250601071035.2412968-7-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b5f93aa-6bac-4850-863d-08dda0dba1da
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnVpqwGBbaZZWCHldlR2beXBuF0pShvHi7sITb1IKEi/psrpsK7SoV0s2jLkvpJ0tAxTScwWwJZ/gsGLVvV22h7dJdSzzOAsfpw8W1ySAj5VECwcmsuMhIHn37pDgausBv9YPMyZibWGS8qZlsNWBxtRpyY9ot8AYkRQfcVYpyllixxgeTrcTiRugDt7nF7GAXexc7P7h6H8EI54RPkqGmuBa0GMddAFO2tyma/PyooDGpEsN17/tz+yj9jDO54VFh+Fsipk7uwARAFiYOIbGN2dDdt0oSJ4uCExb/Yi1ZtY3MOlgX8tv8fYIRsbZYl2Ot6Xjtk7c/XKtIcM0T3fVeB3vZqxG/E2wos8c8LOdk3Sc8gC3b+3coyiQo5Dgr3EsLF+7A1s/NvX8riVCilVaM7YK8KcnHSPhmfZFMzEjvHDgUpBidgGFP0S+Y+94Q1suDJ0j8QbO+s+IH/bemL3Qsi9SGJzMuFuhwZUdFuW31aPL6SY5+Cu1AzIvEQTGTLWa4V53TWco92HLonBqBfr36LckO3Qo3B/JZl6A18c0iOFgolIqYrT81M0cRzv5A+wzTwzNy8JWvHCoTG3tw49apI4MO6E7mC9cZBhRvI2xIcna9rSX+9kxk0OachQFY1ordu9l3Ituc59TJltFp/55aJ95lm3H89uB901s1qADvG/tkKUvwoJij9BoxrQZOnUK3xjmgBMpcLhpPzhNieyXUVTGV4pWQRmqx95uEbJOf7o4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|12121999007|7092599006|8060799009|15080799009|41001999006|19110799006|5072599009|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hGQ+6wJevpEGkXQSbvQKU5JTZt/g3CEQvOLUH6nZgpgeRMZC1SZXHHWTLbds?=
 =?us-ascii?Q?eB+VZxMvquNUbN+hhMeOSUVdB+nq/MREbeP3SMejMzGL/tIRfsGjEu+GiHRn?=
 =?us-ascii?Q?2i03bDTxYXHIYheFTR4H8fG3vwOVpoe9xvn42gkOca1pDCAvonHMzNdKLlPK?=
 =?us-ascii?Q?g+pd2iOqtfHnVNEu5Cjy2RjbpTsxqoJ4JFgibw/bSy6N+WHtGPZr8Pqy+8le?=
 =?us-ascii?Q?s/uF2KEERgyqOgg0NVwBU2pbGNNLxgjO4YtKmx0ExO24RJwLuyYGqSsju7WH?=
 =?us-ascii?Q?Tjye4Qd8uNSkEWg9/XSHXP8ujuieoJfE+qV4971yVTiLi9obfP/cSnPKEi01?=
 =?us-ascii?Q?zItfQeRpDUqSJVrlHu45JoFSfbiZVAOTkVUtmm/9r7U1HTsC29qythhjkwHh?=
 =?us-ascii?Q?71U6VbaYWyRlF4tmvTs6QkShhaGmgkZDO2RRloE0fxXy12hbzxAj0yhMX8C3?=
 =?us-ascii?Q?IHcb4Wgtu+CfQ3wfc5O6cAE4WNfKfjo9QveWv9GK0bOu9r+v70RF++z+nJlX?=
 =?us-ascii?Q?Yq1DsLDFEichMzOXsFj6UnhaJr3h3KVvtUioGPLx5ZZuEchKoqKmoT2TXZgZ?=
 =?us-ascii?Q?hMCryB88QOVeJ37b1pQaInFIxpOIshA/Rf+AdA5PbYI1DXSoIbPQTpmDdv2y?=
 =?us-ascii?Q?nFQvVCEoB/2Vc8RMoNz1jUc831s33dgdrYu8XJKlOmRQdqLmcsCCX7S6vBhN?=
 =?us-ascii?Q?O9giwNTrU4Bx0nwYDhWvtCigy5Lf2R1dW7zzKnS5qz8Pgi8hF82LEWgIz6gl?=
 =?us-ascii?Q?rB+j1zTza9TKj64ESpJj1itmzmWcqctHIw3MGCRlhJnXxBpGL7fh2fzy3NHd?=
 =?us-ascii?Q?sW6VDmgi+BptTkSDQkrppCzXq23fDj0n9tSnvdpw6ISzRqsKe7+4BYKhKpmk?=
 =?us-ascii?Q?K9m9kG1Uedwe+Ei08pzqJWoHK3ch/GgnZzYliQOFl2+le0pk49lrr6AkH7Mq?=
 =?us-ascii?Q?Yw1mrdREGV4GmE3GmuNqmyLoTWOifY0HJMVKJb08V+A1Lfj04vG62yUKbPPU?=
 =?us-ascii?Q?1iS/rplN20JyYnV3Zn/S286OtlZyM86AabMMkd7ea/4o4X0CWwVqLIocJmt7?=
 =?us-ascii?Q?JM3+JSZBH3V5681kJzShLLb2Ayavhna1s60XDVAljGCtGPGVDiuPd6pP4sBH?=
 =?us-ascii?Q?2ZhHeq2hccy9YWJ8EcZRQhEpx01EOoFJ7uSdXrwZ0hPZ9ySrHvua2ZAIH7r1?=
 =?us-ascii?Q?cHngbR8s6OlGw/G3N/Gd1y7AbMizpK9JjcJg1Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UUguqzLV9eHmhHfX2SgajqFBSyWoX4QUHsAXlsRX2p/E34izzRvpVy3ciXTq?=
 =?us-ascii?Q?Cex/X5nwtFQPZX+a9c9x8/2lBeWORb5DSgJ83MvfLXAugXUR8Zy9u5Gqvtxf?=
 =?us-ascii?Q?2NPpjXCk6iAx8J63eQie0kI/sB9VvHAG/xYuEO31Keni1xN35I+87NkYM8WR?=
 =?us-ascii?Q?NdG/gfB5aVIWdwPDujmb2sqzhLGIoSVhLrVR3twSuJpa29tp+iFQn6Ej4cYj?=
 =?us-ascii?Q?FPOWZ4HEYLeYcIFUn0WFdadslMaxpu0R8AaA0wOEhZy9V+t/SqvCOGE47NtZ?=
 =?us-ascii?Q?EQh+bgbl8Cug5AtZJ7zLAkfSAd2Nd/luV/8muNSXdkFThUJ71f0PQ8JAEzSu?=
 =?us-ascii?Q?FNQ5LBn/H28VcpnAQwpWHamiCOyVm8F88oNEdLbpMgEgrD4BHkkPfapQHtTx?=
 =?us-ascii?Q?+rao5qnRrnQuly9juALoqp3Opbt6GPWnm6g04xtOvqRMZc3FHB/ix2j+151H?=
 =?us-ascii?Q?T6NqKq3v8e0VGVnFINh33Xax8F9sOUQ3/m99+dAUJsn+IQoMo/gUCruErQC7?=
 =?us-ascii?Q?7tXw2wgDbjlEaIqZNIy0OPBKGM5E2LDTfeySumtedTro8TG7XN5n7P8uUwgJ?=
 =?us-ascii?Q?O9DxQrDqBVHQ+hhwSMcfKNcmQve3jd1Ad7oUpk+bi3UpXjSSUI0o+dI/Q6Av?=
 =?us-ascii?Q?sT0PPvSP/peowc9806faUXVXczJROVfeaD5m/Lr/PT/tuR36vO9Tg79NAXjL?=
 =?us-ascii?Q?ZNHTTKaKgEDL8Cc2kqiiwXTRlwyWA0gHKXjYkVotOJ+h9BT9lJx+0cAh+/rX?=
 =?us-ascii?Q?+VhVOQ2SwM7rXsmiK6IgHvpnvUbS5bERW+ey5cPMcTZCewFCyNDrYBmJdqUu?=
 =?us-ascii?Q?y3xdITzBrf3KuHkT3fJR5cMQ/t8uzDYn2oRMPC8T9naA+bQSVxbIu5uWtPMj?=
 =?us-ascii?Q?GltNM7NI9eS7ckdZY2IYgmXHtylcx/1b3nuXnB+2uM70W8/6pS2KNgm3P/sQ?=
 =?us-ascii?Q?sH1QReVkJ6SP297W4K0TJur+p9oq6Y8S7uACMDma4hkSSVMaoA7mRjFjB2MO?=
 =?us-ascii?Q?+5Gz8v8meylMxps2UjerN8fo+K7sQ2dK6YWL5+WxSzs3rIPUsnazc4Eq5pQ7?=
 =?us-ascii?Q?7gLSGTJuvLayycPJTiG9QpsWEv33E+w965yQb6gLSINKsukn60Qxq7rPNoUF?=
 =?us-ascii?Q?K03Ek8PkCSGex7mSjRMv6k9E2b4lf8jawHqfbiicsCgTw3jUEyhYjE8s7QM6?=
 =?us-ascii?Q?EiBj5keygeYWdRCmMw806sUmh9l7nlYrsIdnnZ9yEpIj25HbEcIWM8eIt8U?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5f93aa-6bac-4850-863d-08dda0dba1da
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 07:12:13.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9108

A lot of spelling and grammar mistakes were found in the logs shown to
the user while using imap-send. Most of them are lack of a full stop at
the end of a sentence and first word of a sentence not being capitalized.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c             | 44 ++++++++++++++++++++---------------------
 t/t1517-outside-repo.sh |  2 +-
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index cfa335b647..d791cbff43 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -205,7 +205,7 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 			      const struct imap_server_conf *cfg UNUSED,
 			      int use_tls_only UNUSED)
 {
-	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
+	fprintf(stderr, "SSL requested, but SSL support is not compiled in.\n");
 	return -1;
 }
 
@@ -249,9 +249,9 @@ static int verify_hostname(X509 *cert, const char *hostname)
 
 	/* try the common name */
 	if (!(subj = X509_get_subject_name(cert)))
-		return error("cannot get certificate subject");
+		return error("Cannot get certificate subject");
 	if ((len = X509_NAME_get_text_by_NID(subj, NID_commonName, cname, sizeof(cname))) < 0)
-		return error("cannot get certificate common name");
+		return error("Cannot get certificate common name");
 	if (strlen(cname) == (size_t)len && host_matches(hostname, cname))
 		return 0;
 	return error("certificate owner '%s' does not match hostname '%s'",
@@ -906,7 +906,7 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	decoded_len = EVP_DecodeBlock((unsigned char *)challenge,
 				      (unsigned char *)challenge_64, encoded_len);
 	if (decoded_len < 0)
-		die("invalid challenge %s", challenge_64);
+		die("Invalid challenge %s", challenge_64);
 	if (!HMAC(EVP_md5(), pass, strlen(pass), (unsigned char *)challenge, decoded_len, hash, NULL))
 		die("HMAC error");
 
@@ -1053,7 +1053,7 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret != strlen(response)) {
 		free(response);
-		return error("IMAP error: sending response failed");
+		return error("IMAP error: sending CRAM-MD5 response failed");
 	}
 
 	free(response);
@@ -1147,12 +1147,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		tunnel.in = -1;
 		tunnel.out = -1;
 		if (start_command(&tunnel))
-			die("cannot start proxy %s", srvc->tunnel);
+			die("Cannot start proxy %s", srvc->tunnel);
 
 		imap->buf.sock.fd[0] = tunnel.out;
 		imap->buf.sock.fd[1] = tunnel.in;
 
-		imap_info("ok\n");
+		imap_info("OK\n");
 	} else {
 #ifndef NO_IPV6
 		struct addrinfo hints, *ai0, *ai;
@@ -1171,7 +1171,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		for (ai0 = ai; ai; ai = ai->ai_next) {
 			char addr[NI_MAXHOST];
@@ -1209,7 +1209,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			perror("gethostbyname");
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		addr.sin_addr.s_addr = *((int *) he->h_addr_list[0]);
 
@@ -1223,7 +1223,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		}
 #endif
 		if (s < 0) {
-			fputs("Error: unable to connect to server.\n", stderr);
+			fputs("Error: unable to connect to server\n", stderr);
 			goto bail;
 		}
 
@@ -1235,7 +1235,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			close(s);
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 	}
 
 	/* read the greeting string */
@@ -1343,13 +1343,13 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			}
 		} else {
 			if (CAP(NOLOGIN)) {
-				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
+				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN.\n",
 					srvc->user, srvc->host);
 				goto bail;
 			}
 			if (!imap->buf.sock.ssl)
 				imap_warn("*** IMAP Warning *** Password is being "
-					  "sent in the clear\n");
+					  "sent in the clear.\n");
 			if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass) != RESP_OK) {
 				fprintf(stderr, "IMAP error: LOGIN failed\n");
 				goto bail;
@@ -1594,12 +1594,12 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 
 	ctx = imap_open_store(server, server->folder);
 	if (!ctx) {
-		fprintf(stderr, "failed to open store\n");
+		fprintf(stderr, "Failed to open store.\n");
 		return 1;
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1651,7 +1651,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
 	if (!uri_encoded_folder)
-		die("failed to encode server folder");
+		die("Failed to encode server folder.");
 	strbuf_addstr(&path, uri_encoded_folder);
 	curl_free(uri_encoded_folder);
 
@@ -1708,7 +1708,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
@@ -1792,13 +1792,13 @@ int cmd_main(int argc, const char **argv)
 		server.port = server.use_ssl ? 993 : 143;
 
 	if (!server.folder) {
-		fprintf(stderr, "no imap store specified\n");
+		fprintf(stderr, "No IMAP store specified.\n");
 		ret = 1;
 		goto out;
 	}
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf(stderr, "no imap host specified\n");
+			fprintf(stderr, "No IMAP host specified.\n");
 			ret = 1;
 			goto out;
 		}
@@ -1807,20 +1807,20 @@ int cmd_main(int argc, const char **argv)
 
 	/* read the messages */
 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
-		error_errno(_("could not read from stdin"));
+		error_errno(_("Could not read from stdin."));
 		ret = 1;
 		goto out;
 	}
 
 	if (all_msgs.len == 0) {
-		fprintf(stderr, "nothing to send\n");
+		fprintf(stderr, "Nothing to send.\n");
 		ret = 1;
 		goto out;
 	}
 
 	total = count_messages(&all_msgs);
 	if (!total) {
-		fprintf(stderr, "no messages to send\n");
+		fprintf(stderr, "No messages found to send.\n");
 		ret = 1;
 		goto out;
 	}
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 6824581317..bc6e79613f 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -59,7 +59,7 @@ test_expect_success 'imap-send outside repository' '
 	test_config_global imap.host imaps://localhost &&
 	test_config_global imap.folder Drafts &&
 
-	echo nothing to send >expect &&
+	echo Nothing to send. >expect &&
 	test_must_fail git imap-send -v </dev/null 2>actual &&
 	test_cmp expect actual &&
 
-- 
2.49.0.638.g67a2d115ec

