Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D028E5E9
	for <git@vger.kernel.org>; Wed, 28 May 2025 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452720; cv=fail; b=VGG8tRP+XtnQM3KgN49qJHddFUmP7lHtt/GeT8JmF9lm1orXijd2qXIira+iFfihNeJKWsIUbe0TrWsBq56LRObgd2xH1UjyxAWDnuO9hQQfsOHL8SGn72t1URNm680b3hsGuavxpXZR0K5htBwW7JHtdlejXGiB8aYCc/+0m5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452720; c=relaxed/simple;
	bh=XNTWJW1O9sM3C6q6lsHre9JEdqhQyDyrMnwoYT3CNhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BVgNupqQq12T0XUUH7kTL4YGDEwXZv4sGfqmdmgnXqJSUcKvg/Xq+WvhCuO+f3+W9igYDrPYMrkOx3qBomFlnbSge2D/wVmJQHd8TVtPz9Aq53fHEoml7/seP5RBLh3tf7OuEXA3/0O89V6PzK8zcw26yljfEi3Uz3Nevr3Xo5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=RqtZjJGs; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="RqtZjJGs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2/oxeQSmZsvje1toniJ9v3yds/0ToP73io/VYMYnE1GQ53wTBNCbgQIfPwupSqiq4lR/oQknPFvl3coUGlPDxOf03CJgCtMhfTxVF5u1+SpG7vTTdQ5s1saHZkJ+lyPVFJX2KR0yVIWjx9XKSqFOgw3yUnqw2URko9WANoJCs4wUatEoOEFKK+DwC6IyAn93AiEgTjCkUB1RqDaLSvQJXu1wkSagxV91KxioFKoGmPHWKApOUrz1PHJJ2KuZTaWSy/kcv7gmTKRbemqK+BH/5N0p1oaO9ICcmQfO9TmxgkMWFBrsvTjmkObqYeQU0z0BgXsft342+V3Nr9z85OpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eia2D/dcAZDwUyGAuaozekln3PO/083oEO9q5Huxc2M=;
 b=tiCir3mLMeZVmbpMQs7PnkBLznMRSXJo5SiPQi0/bLTxUGsnqwdCEhZT5Wk1ya0k1raIJMSRjijIHhVMhayRzCF3O9AkHcpsIT90DXScvyTd0EynFcJQA8nXp6lVYzDGrMNHMaQ+pCT8/AevKRXLJErxkifKtYMHFNvyx8MPJKOzSgO+CjiEXKBrB7E+/1gsOzYidAlLmv31Dh51bKw4Wr0bCPQ+3S1yCR5SPYQL7vM/mnhU5DGcBD2CAqoK/qaSGoADhqCp+doGVo2HyAn+1ThZymVaYXsQrcJwbhZRoUxypCIbVtJp5o/dhKvmeJhRXMT5eZqLDB6w2QaYtGDciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eia2D/dcAZDwUyGAuaozekln3PO/083oEO9q5Huxc2M=;
 b=RqtZjJGsibX/3VwLX7t/cXn0twdxehPm9GvEQvD2dHFzeTBuliKsAgKMkpLlUSoCwfAw77XKs9NjMxo4wAgDnpanZibf5D7SkneTJ0wkY0HSpE0B/HfEUGzH/+I6bjdNoAM+Ka2/Qjl+aOnK0Amj4HH8o7zYu7OGChH4QXsB1qI3fFoLCksMu2/tOEnYcjGEVYntx2Toc3Ybhfttqo6EoqiVBES7yPN+lJcW/8U4bPECYfI2U//jMAQj6hfaOOdtDHD8K9U/g2kdIXxYRf+bW9VPRfoE+L3eq373HroKr4NmCjCi0qmttsyQtCaSzuRMz1mEH5VodNqPRKh1vCfzLQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9864.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:18:29 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:18:29 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 7/9] imap-send: fix numerous spelling and grammar mistakes in logs
Date: Wed, 28 May 2025 22:47:53 +0530
Message-ID:
 <PN3PR01MB9597F25DF4C2F5FEF2CAC0F1B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g5db5b64a3b.dirty
In-Reply-To: <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528171755.90367-8-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4a5b01-fa41-43d6-00c2-08dd9e0ba9de
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnVpqwGBbaZZW1pMskFQwysmVSJQn/Ak8kJyIROIJ+ZQYdMH4+A7ei5BVRgRHJXcVDeOXCeVU9AiLSwG/f89px67sS1cFwoY60oNF/hCXN8113/EOPfC8rjgZRome9KQ6YFqFyWjAVvLSO4GGYmPRMzrds5NKQ0Xx7S+NuR/SpyBZzsNZ8IeSBnB6+qpTqmJ5oZckyRbo1q3sZ1lldnXfDNNZXQwBagS/rio6M4+b9VPRKEKh6xcOepVAYikiDRF41whtAX1bx8p0mYZHL+51Roq2WCFrOfsm7+5IM0kIuaoTthvaBUui72EzRb6o1F/HhY3q00jcuiuCwa+kxIjVMSI9Y5PVs3C1n4Yfynsk59BWLzEQe41u0FqjT+LBZBem8EXhqO/GZTJraUFKBl1nTXAehhiBLhBEuisa4Ne0UOGojsVd0dGM59O90/n/DMkJLyeumSb4bxqewhvpgpOpsYQNc13Ea75wd2DF33DmNgwXU+XPhAayo2P01+etxDvyVikwSP08NM6VpmP1dzw7GdPIf3UDrMyWgHjTskS16sT4l01LVRY3zMFnLuo1b6Cw1/Qj4Wr9pGjXInMKhCAtpeTVFBrN+e5QUJ73yLDOIt+fn9u6AzRO8JECcsF1HsVwemRe4/evgMWih7uWbyhwEc2j8XJ5tFye4ip834xxMxIlgVpntZ9LH3HblXwV8sYJGQhp63tj36Lsd3i9crYWI0iGxeSGoJkiLtG4qOWq2Rw0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|15080799009|12121999007|41001999006|5072599009|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t72UplMJ1AN6upPRjGTPLRh8fqUaK/B1JY8BBZB3KFEB2feONIAsmP+fQbaS?=
 =?us-ascii?Q?3KIk/MoSxU5kbDUVHfQpRgAI4aLUBF9adrzxJs9uvQdejsydP7xW44xn3OPG?=
 =?us-ascii?Q?LnnR0ke5hAYmr1k8phiK1bK0bgsrus20HGB/qm6mrV+LlpgrKYS5r6URKWzf?=
 =?us-ascii?Q?xImkda+fojgOqYQo9OB8N4AFxmMvKiqcGEz75syYYJD/zOUex5786y9qL+5l?=
 =?us-ascii?Q?hDDmzOfDeUZ3AFze/9xWLP8oa9d5I7XaGSvMKZNjJuW6TRsDiplA0sN91jf4?=
 =?us-ascii?Q?dr9IX4sTGKNGFI9bj2NABxWXScKcvtiRVEVVluAWKeemlYNCHmvF/yVP9Bd/?=
 =?us-ascii?Q?Thsz+JPFs2U2HchVYA+1zLGjhKj2v6gw3D+AozcftPExRczb7EW2B/LgHt42?=
 =?us-ascii?Q?jYbw+XscOQ0X2tgLErn7Gocnt/fGqKk/fN8yyg8cz8FN+QCUNrQhySlK3JkL?=
 =?us-ascii?Q?/EvQjzYAEEKA9G7QtQbGW2I3Tt3B+zv8MaLlkemqyN8AKrjasGRe2H8hOXlM?=
 =?us-ascii?Q?3wqkZ20nYW5Fdrj+HOGxXAu9VUPZGqWUH33n1eHFc3CP610wtDUjvtsIkSIT?=
 =?us-ascii?Q?S00NHQhVH8YNOGCXx7cvxmeVxVT0Dlg43sPvQjirtc5uvv7BkDpJwrfOT/gt?=
 =?us-ascii?Q?/LFnpMmJb0gsL/WU1NG69HQ80ph5u5EEiaCZW2K+ZsyRpMDJpd4s1EDn1Pk1?=
 =?us-ascii?Q?PKhGmndA/jk0wdjZcU5UcLQ3d6nAA1z2X0vG7b6YhNyX5pklTCOokF+uLGop?=
 =?us-ascii?Q?KlzS7gXdZJ6Oj2OxZkEHLmMuIOhsF2+1SMDC0gNgJgkQcNlYAbGg4HcsOSPW?=
 =?us-ascii?Q?vUUDFQRhMudiXL6/Bo5cyDjWvkE1UxIKycw2oAgR+R8XrbaRE2Q1ImqAoojy?=
 =?us-ascii?Q?XrW83vKuZpS1/D5pAARzu8oT6jqblnMdRlImohl2OcfSrrPI5XB/5414dK1m?=
 =?us-ascii?Q?HhQOQgLO7HeajV49jhPuwbS68Xw3Rp9EkBpNBxYdS44MP9KB1aT6JGX7u9DX?=
 =?us-ascii?Q?jIQjYUL6OS8Se/TfYhJf9733J+i+DGITsFyz1rP/eYUSp30o48GnwQKupqXN?=
 =?us-ascii?Q?yXKL+6Td9l1l7QvdLVL4UFi3uA3zb3ZYsv1q2+wl+DbylUpV2BwfVljRBQfi?=
 =?us-ascii?Q?FUV4SmJk6cLZCJylyATya8X0n3XEBtfKdRN04BYCWlkp3qXb16WDXsFAK0LM?=
 =?us-ascii?Q?7nDoMZ7MVrllfFUxJ1EPAi5lmCvmMzngXwTSWw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K02FxBwWL9Y5bz2HXgZIomGLUCf3+tRbn0dlM/POhDpZE/Q1MmZlypi6C39S?=
 =?us-ascii?Q?xic+gDv/Qx3wRKpSoC/c/ZehvO7OAvLd4OnfbEtrHlVHBN9aPkKb+FqDdH9E?=
 =?us-ascii?Q?yySbzfc+m3Ri+aT9lqiOjeBdvF1wgs3Q7IYv0cP21UZPMEK020rvjwV7tAvx?=
 =?us-ascii?Q?jamleloRY+WztsbMt5iSSMTHx+qguJJ2tV098crVNUHljZ9WbnteskUGpe2h?=
 =?us-ascii?Q?vp+vpNQzIjjpWFG3ZiHuvvY2Q82Fj495eWuKybNCCjkBOo/BFZEYF2gqCpeS?=
 =?us-ascii?Q?gKtp7xebnUFfTC5WmNEgud283/0YLO8mq/qX/vl7lwMkWXHw80+v9XDKj6al?=
 =?us-ascii?Q?jvnbpSfPoXCpG8Yod+chqkuYs8AYRER7XAbyyZAtwNNiS29Hl+z5jkF+WW4a?=
 =?us-ascii?Q?zGCcznokJJEixm1oDecR1r88SlhOajR4XcfqLr62UW45+mgpIg6gADVUAHjU?=
 =?us-ascii?Q?W6+E1sceZ4DGTDdkMNcC39Scl1+ZeMXOBD/qGrycqhgek3eClR0kMzV4bpS3?=
 =?us-ascii?Q?Fi6fryadwZxF6P1DKQGrH/dEhKZiZ/rrEGFMqQKD31QUOwyF9D4q1fmdWnbF?=
 =?us-ascii?Q?mMMLU9raqlgBUa/YjTkkRAAa4+yGkEApCQti2SDAjJp9kU3ACLhr2FLFjNo1?=
 =?us-ascii?Q?Wf7HPFUX9KfBbblaEH18hRBXhBiZPvRhwV4MKmdQSHeR+tV/1ZhNueDnlgtJ?=
 =?us-ascii?Q?f9VQQdur/GITpBMLfJsvKV3JciU0ipfYbjOURv+HoIVcV7mD9esCm67SY5pc?=
 =?us-ascii?Q?f7vQBqA+mscYp78enZJzxz95F4RKGcAV2lGs3lpK2gE8zIquhZMlIhiTxPnI?=
 =?us-ascii?Q?ats2J2OSOj8FDD1RT2DPJ8C/DXgtsXiam0cioXsLQ2X/QYKx+MLb/puncBXX?=
 =?us-ascii?Q?4PJPxspQ1pr3SPN+UZiEw/zHhHl4RVAeBbrr4++bXXDhSOLKxAYVv0Tp6shS?=
 =?us-ascii?Q?UGCRijljstR452QI8/XS3l3MMgpZ3zQRRNUSK5iqhoFsf7q4nYsBWNkSlO/X?=
 =?us-ascii?Q?vlUOE0QU42gmMdYIn+8wDJC09gByT8KfGEJz8RO91RER9xE4m+1LmCTC7ybp?=
 =?us-ascii?Q?Ski5W7rldFEOmWuyoF95APU2brTgEsL6tEPN4dXxBDPsVmOYJVi73LY0qq65?=
 =?us-ascii?Q?ztiMnxI4TuO7BkdE0lpyoF0xSdk5yS8H6u1cVI6eySzRF7v9MduC2DWVeyRv?=
 =?us-ascii?Q?gwMxDDfL9TqKlhdVrfAVNju9p+4xt4QfhPIhU9cDIpPk1i5qsTcaAWqQH54h?=
 =?us-ascii?Q?nrDte+7RBgp92Iz1ofPChDzZxn7eqKsqyYgdwL/HhlbVssNlhM+/SZOR6C3k?=
 =?us-ascii?Q?gjLFxE6CEMtmGeVni/TOZw56?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4a5b01-fa41-43d6-00c2-08dd9e0ba9de
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:18:29.1814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9864

A lot of spelling and grammar mistakes were found in the logs shown to
the user while using imap-send. Most of them are lack of a full stop at
the end of a sentence and first word of a sentence not being capitalized.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index b08ec0e1d5..204d2a14b2 100644
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
@@ -905,7 +905,7 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	decoded_len = EVP_DecodeBlock((unsigned char *)challenge,
 				      (unsigned char *)challenge_64, encoded_len);
 	if (decoded_len < 0)
-		die("invalid challenge %s", challenge_64);
+		die("Invalid challenge %s", challenge_64);
 	if (!HMAC(EVP_md5(), pass, strlen(pass), (unsigned char *)challenge, decoded_len, hash, NULL))
 		die("HMAC error");
 
@@ -1050,7 +1050,7 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret != strlen(response)) {
 		free(response);
-		return error("IMAP error: sending response failed");
+		return error("IMAP error: sending CRAM-MD5 response failed");
 	}
 
 	free(response);
@@ -1144,12 +1144,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
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
@@ -1168,7 +1168,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		for (ai0 = ai; ai; ai = ai->ai_next) {
 			char addr[NI_MAXHOST];
@@ -1206,7 +1206,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			perror("gethostbyname");
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		addr.sin_addr.s_addr = *((int *) he->h_addr_list[0]);
 
@@ -1220,7 +1220,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		}
 #endif
 		if (s < 0) {
-			fputs("Error: unable to connect to server.\n", stderr);
+			fputs("Error: unable to connect to server\n", stderr);
 			goto bail;
 		}
 
@@ -1232,7 +1232,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			close(s);
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 	}
 
 	/* read the greeting string */
@@ -1340,13 +1340,13 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
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
@@ -1593,12 +1593,12 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 
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
 
@@ -1650,7 +1650,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
 	if (!uri_encoded_folder)
-		die("failed to encode server folder");
+		die("Failed to encode server folder.");
 	strbuf_addstr(&path, uri_encoded_folder);
 	curl_free(uri_encoded_folder);
 
@@ -1706,7 +1706,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
@@ -1790,13 +1790,13 @@ int cmd_main(int argc, const char **argv)
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
@@ -1805,20 +1805,20 @@ int cmd_main(int argc, const char **argv)
 
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
-- 
2.49.0.638.g5db5b64a3b.dirty

