Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D061C54AA
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483764; cv=fail; b=s871iUvfA9vwJeOn1DfoblARdmNnPMWb21WKLcyLPQ63uzAsH4+5RRXnzP7tgQ5jCcHFzE/Y+ccyYs99PlyB89JW0WX4pzHGGkWkeitSJspj0seLK5DUq6K8DG9MpjyUzo+yjHpXaqYJUZJbUll+gf2Zy6b88/Wo+W/3XGuFqVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483764; c=relaxed/simple;
	bh=nkbFmdjGSOqo5THX2bo5DT4eqnKrDpq87UYNW0ccRuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JgOVGf0dFMmgda5ZXD/KQYFyA2JR2Bvxy9OhVwh7hGBko1J7qWWB+ukhzWBmdCLeXFIovo5HJt6rcN/YysxwCTMEIFNc1+n6vDgQh9kAuQJ2scrxgQKUfToDtCbI8UM0Kt+zoEwaJuQV6ttPFXE0Li7yINT+GCKspF6nbKqY6Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZPTGZibN; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZPTGZibN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SoF0PoO/P9Re6QRBR/j17yRk049hZIF8hB2lL+NjkAMwcoRIN4iVPsPxrnjHSwuihOBqOvA5JwsXtRa11e3MCdiPXvUWZnmAZ2jcfWl1/rJ48xkRpSrBStVHJwdLyN4DkeDETpOaHQeC8udgWKWHP0feHzVJvt9vWeQq+Eifr6Q1cDknxfX6Ru8FVz1ybO2sYGKI+E5MKStDtMrBxX4xc9RhQ4zEJUqglECRazJy5M9jmnB/a67H/+cPkR5qJrWxjUpS1JMrkL2+PbKNZhsYCnxkK43796v5eXPaKHtiwWW5wQjL+e9a4s8oD9vp8EGjhEAHjrIIBLuqyvzssRjuJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bda+ZVtNtYY4O6GdV5oXwnLdMlV/0fUbzM2FJ3A2XNg=;
 b=Z5D5pKK8sLQQIWrfVGU40ppAhHm6t9UynONcTyZx9tgTmiV91trrVPyRUfGnxs5LBelcapEpYsG759/JdM6x5SZnoeyKD0RBg4hFdWB/4YoxICFtC6myzJk4vdQLI/2oPs1QHaImahKlvn+I3RBRQeiZAUGMJtWXqfP0Bbw2fRbTPJKfIFlOIG06yCTdgjtvpAZ0CzD0PQGgeohS3NixSC4VJxmAk1tuYpBng+hL9HqY8895VSg/YwWGCWb+LazPFmzCveovC/S0aHgpHXfd/ycg6Jen5Bz2L89LVBqZXsizH8d8jtleOvTbDo5uXV2atdqz52/u+2njEtiIcbO1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bda+ZVtNtYY4O6GdV5oXwnLdMlV/0fUbzM2FJ3A2XNg=;
 b=ZPTGZibNP+EVVl4XUdgJ1kXbGTahLOI3Vq3cTecJPcRPS+p7ndaoPhOyk0VkeFoHR5bn7KhpxjZLo52sYhHlmdfPmBRYYZ3uskNjpFDU/F8cV5lDVnxosJ/uV8vY03H/eI/1A85t2fKzQ0U5W/hrAIfT59h3/9NCb3oAvOSHol8eMk0g+DggoJjjE0TXFzQQ2vI6UIVGlKUyNwPsm7rRQK87p2oeU4CONvh7IiKsBOoyATX5v2mT3+1tUvwgeka0Wfa7nT7yllYVV1XNCJt91bHsal3UH7M4wuvqKF2hWwqZtb5byyXqDdDZ0JliGMGilyk0wl2O5v7oefCzl0g6oA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB5751.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 15:42:37 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:42:37 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v17 01/10] imap-send: fix bug causing cfg->folder being set to NULL
Date: Mon,  9 Jun 2025 15:41:20 +0000
Message-ID:
 <PN3PR01MB9597BFD435427C72DB2CCFEBB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250609154129.13552-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 31009966-e6f6-480c-0aa2-08dda76c3f28
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7092599006|8060799009|461199028|19110799006|15080799009|8022599003|41001999006|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yRyUiAJorhJqewJ0lvn197tJKYsk1nQjd3tDBvz5dcxZGWYqGF3rUyJsUm+5?=
 =?us-ascii?Q?nUVtLqw0Y3cfiCrtO/MV6A4Q6qIEnLM4L/bKKPLd3R1Y0qPJ8EBBTCn54Gni?=
 =?us-ascii?Q?2RJxb9CKFoEutu8HNNXXal+3nCjLuxa87CHpLed5y1wklGxBZlEjbCidcyQu?=
 =?us-ascii?Q?y6dmlzZdLMPeOnp/XGYrplJBQ5g3ofnNWI+uLaCy3vgBFdnI7yyJzL6OQQDV?=
 =?us-ascii?Q?Kiqv6M5MVFJPS5cVAg0I4A7J3baLguR180mH2To4L3Rnb8jLR6oLWq2zdnuU?=
 =?us-ascii?Q?ime1mNIGIDGY6UGLmEYAR3dNQiyzmKmAdlmHW/pNkBppoGSjQiU5m8DcqQJ8?=
 =?us-ascii?Q?IoVVFWQB/8ZPnRdxuDQPHW23x2a9qEW7CUVJsKZVXhKbBWO5nCC4P+IPKzCf?=
 =?us-ascii?Q?mTSFcUhtX2LXL1TILSfgDSkvRX/DxfOoI9wdJR6pJBuBHUsq8+annKJbgFr1?=
 =?us-ascii?Q?m0ePIOe8zP0ZjZzu1obGTslefH1aZ+QoRVNsJkX8CTWL/1Q9xIFL0VF3Ao2n?=
 =?us-ascii?Q?a5RkA03KRVDz5giOHNAxg2XSMgUBaCl4twrw1J1MLF3U34et8tmLbl5szcKU?=
 =?us-ascii?Q?0HNMoSGQdRWk1ciANeoy325E0B6dUPjoB9H5vHJja7RLzutBWop684ZAVDlO?=
 =?us-ascii?Q?qZIL3bMbhLP3PJr07QE/ShhW3sv/HZwD6k6dWHo73o20YakKC9cOfiEN9b+j?=
 =?us-ascii?Q?0GpxHroHVrwt/XLfFMQ0ipjOoisOdp6IRwA9pqKnUAHPktjj8Jy8+TE+YV6e?=
 =?us-ascii?Q?Wtw7rvlQq4bsxdu8u59VKnCLVoPGoWSK3Srcp3Ur0/N+b4aSsiMpLczyx8TJ?=
 =?us-ascii?Q?vQvBOKAOZCsd33AjDXrxtP24qXjXL+8ZbcMfdVHnLcFN0EW1CVEIYmWITsMw?=
 =?us-ascii?Q?Fd5ofuF/oFY2ZXHh5HP0KiBDtE1eXzRwO8JKoh0dMF+WKyPjPzh7i2LFW5pi?=
 =?us-ascii?Q?QOBpd7hjzlUSrJrzh1adLLsTQaUcaJNypyAyBiXP0OaN5p5/4JlVSmxV3vfm?=
 =?us-ascii?Q?RrXYIrqdmMkVGrYFytzoFG8vbO2hcDdKtiHp9lhq7smI+vzJqcXA47Shqrq7?=
 =?us-ascii?Q?eG9NKvzUov5AfIwRIQbRwJwqnRaWHus94qFu1Xbp79L6QDRVe5qa7p8TfPTK?=
 =?us-ascii?Q?iUrZaPLjsAHN/gCV1iO/KtPKgCFlYtIkLBFTYoNQhnPDjQEcMh646rw55Mr/?=
 =?us-ascii?Q?bfcGeGEK05JdN0YvXpzbxtL8PfloDkVwk4iQPQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jTFT54lcpcXBt/rN8VWI5EwZWSD3EMsVoKnj009iJ9eS6Q3XzTL3LobVCmKn?=
 =?us-ascii?Q?Ze+aFMgr2HjV/QkFuiGsmzZNfD5OueApLzZhUge6rcQJCrdPRORNtw8M2CrO?=
 =?us-ascii?Q?DhnktdGxkg7sJGo2A0ltniH1pwGhv/hWz5q28kANKS1Yz70UUg2nKTGzWimd?=
 =?us-ascii?Q?A6Ap2oakZ6xxnGlmWHaIb+6UiJsSCX3ki9riIB1/V54Sh06+aYjQRjUmKSFS?=
 =?us-ascii?Q?tmCy5aVzGZ5ehzNd54cULq6nUAGIMNf+Lpn+CJrSRjaMgE3nqDN/vaZKtJup?=
 =?us-ascii?Q?ZYt/tebIDV1Ck72Wd3utcmmt6+HCebGKlJhZl0qbeOZCobtTimTc7Kd9P3BM?=
 =?us-ascii?Q?ENW70LvvOxRZcATD914SfVj0pyrHHFAE05u+tmS4t+AniCE865gasvhk2nYz?=
 =?us-ascii?Q?HHxBeXFB8p6nprw83pgLtIRGIFeMsEhGPWZ0aRGWWQ78T7oOAHUS4LhQg+7j?=
 =?us-ascii?Q?Z9ObWr3Gao20OPNH2Nl8JCMz/InhQ07sAvn3DcA3F5Eq0ywagQKPrtdQ4CjQ?=
 =?us-ascii?Q?iLJj5IZFxMPolRLlcKpGimyPZKYam0vhl9nY0avEg/lSpJGBgZv5bVtHPRWO?=
 =?us-ascii?Q?m41JTq7TebpCjthCgV8vIQhHecaaemOirrXhlGQtFluusXSbiBEKoVSAlblA?=
 =?us-ascii?Q?pNCYUc6H9fL5SiXtKbqA1ZLeFkzM0OmsY3O2hRMfvN9XdBKDc4J4jnONfGrZ?=
 =?us-ascii?Q?5BLrWzPzBl8iOmTMGLb4nPxF+99l0JYaARVry9PgrOMY7HjJwEd26NOe7osS?=
 =?us-ascii?Q?NYQUKpqniRNXQJHtqANOCGL/o4O1G3OKOH7jwjxjlNr75UCr/Eb4SrF7b0lK?=
 =?us-ascii?Q?JZVQgU9098R3DWZCXayalW4aaBCos9g1puNA9Jj81XFoDIE/QKFInKIW08Hh?=
 =?us-ascii?Q?NtaoE5tm8O5wnnicuyS8kMrQCgqkaxZEy2hnHT0gLlGiEiAUv9owhHlDBaLr?=
 =?us-ascii?Q?M3ty+/SLN9bqt7OlyWGbfimY+pGNGwaObyNAPnx1lDStZThPOoi6rkUiqCK2?=
 =?us-ascii?Q?8wB9PIcgBzIIEoNhvxIheK0BpPLUOA9PFz5bza9Fo8bxorU4k322fN7YUiMT?=
 =?us-ascii?Q?HKpB2jdMmrVLbB03jXamBDY60E2MH7zM4wGmkTJO+b1NXxEa3YzTFEHsEG2o?=
 =?us-ascii?Q?72vHDNDPSh+zgft8sCBTtTp6koJybN7mIMRyKF15H9E7D6iuHqKx9X0X28h9?=
 =?us-ascii?Q?lTxBZIcgAXUGpJaKkQfmePUWZcQ6LmZNY0dQcYfwXnFJl2u0VWuLCN3PNYM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 31009966-e6f6-480c-0aa2-08dda76c3f28
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:42:31.6783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5751

6d1f198f34 (imap-send: fix leaking memory in `imap_server_conf`, 2024-06-07)
resulted a change in static int git_imap_config which resulted in cfg->folder
being incorrectly set to NULL in case imap.user, imap.pass, imap.tunnel and
imap.authmethod were defined. Because of this, since Git 2.46.0,
git-imap-send is not usable at all. The bug seems to have been unnoticed for
a long time, likely due to better options like git-send-email.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 2e812f5a6e..3eed2360fd 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1316,16 +1316,16 @@ static int git_imap_config(const char *var, const char *val,
 		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->folder, var, val);
 	} else if (!strcmp("imap.user", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->user);
 		return git_config_string(&cfg->user, var, val);
 	} else if (!strcmp("imap.pass", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->pass);
 		return git_config_string(&cfg->pass, var, val);
 	} else if (!strcmp("imap.tunnel", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->tunnel);
 		return git_config_string(&cfg->tunnel, var, val);
 	} else if (!strcmp("imap.authmethod", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->auth_method);
 		return git_config_string(&cfg->auth_method, var, val);
 	} else if (!strcmp("imap.port", var)) {
 		cfg->port = git_config_int(var, val, ctx->kvi);
-- 
2.49.0.824.geaff4db692

