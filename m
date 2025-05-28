Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730C3246333
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417936; cv=fail; b=lg3iG6395qbUCtuq1KsGdXiXZqyr9wuYTOzhg6rknIB3DA1/puHlgmkDiQjHpcwkihy0iw39XyIEri7AGIjAgM4Nr+KE0O/23+xbJ8ToZyMGH/GFCjf1pBQ+AJM0WxTYrfRe7Y36NVna6ENCEbwnv9IGawcP+Uu7Z+5oFZN26fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417936; c=relaxed/simple;
	bh=8mkAGtbowNm/nji5mXyfbgEMCQxf13JQ9ewl9wYI0mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NAw3x106lmJd66TDCReXWizf5FPJz0s3iLnu4SmeXef2lnxxZZMpYI+pnVX7s3IQM91oN2SKQ62H+fCNJBJ9HWyKk2mJ08Bv8hpPs+Lk6TccNzmUeXJMGUL6XmUtBI85RpohgdjHghfYETx3tdUBLVGQlVx83ZL8DjXSN89J5Q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=VXzWzov5; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="VXzWzov5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzbKZKkvPpuWHcipHH+x26CuE7pj1JRQP85KAuvn/Np5EtuejPH+uDMbS/YBP6goClGdpAuac/qFM5fqBiKbEAtpjz4wkkRGIPSkDqotdW7OQ3S6c5tJynY7LJ2AVZS5bExl3z/Jjs9sL25AlyjpM9dI+O3McqZv29Qh8Wg7QkrD+KcAa7De0MA1GrUM8EIvVtV0L3dr6wK+CkZenX/8Jbuy/2zy9AC49pzuhxt6UTWjWpB9R5rpguQiWBuKyke4E0AQO40Khi6zvYOcJqiKP0JBn1phlrNc8a7F4tVOq/lR2kIdzb82Xxs3wxhsIBm0kAUkeXpI7oF8BcfW8LDg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtc0V4V9ZTX2JgocGPJnn3NvSt+9DC8F4Q7MFG2g8gg=;
 b=ZSNIpeD33WDzELIpjReeFTpvrsOZNY+mkUmdQWWuF9yHdXvUC+nbqrdUjydKfUS42wwCAJUCYZbCvGpN0d5JIIDiqurQC/v0JZFYF1T0JxpYem58pqvfGZGdSm2G/i6oNYRW1CMkxKULiEeOF/r5ajU7U++mqnDLhCv6Zh9YRgWU8Fcf9/D3ndCP8i6aE6byzmebt+/I+5QOPeAxeZYHwiatB8JYW4mODbld4/vm5F3YZo0LA6Vwr6XSKXPsYUBZnAB63Rb4fxAlmPuQnkCZw8cSeuUQruLZr3dvPPhQezB5bmgomV3XD9Qpuoz8lulwImw3TvY30Oqocbt/BpH49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtc0V4V9ZTX2JgocGPJnn3NvSt+9DC8F4Q7MFG2g8gg=;
 b=VXzWzov5AZca5TFd+mLJvn22Nzupe4xrGUOs/jIdvEv7qfupQHNPIV5jnmLTLk9FjwmJBsdakNImPWuApcvjrfu8PtqTJqGUZqLwfeJEtECa42lQuV2KTeOsoTvm3TXTEf4+RhhnItAR0Tikn6UzRxZyPE/t8hLLjCtZyF3E58CBo9jj3Wjpuvl1GJSY4SfOHZLds4TdXdheS3sq4oQti8bVgWIIh48EDagGjCazZu5nDzwsYNZGF5B+DiqeYr+fIGxZZJx1yaDb+701DaSaR3k42gM9B+ZPV+0mw+VU9ld1HGM128PQ/xAF01mSYKOzKXYCyK6SFm7FXffYUJCVQg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB6577.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:72::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:38:47 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:38:47 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v6 5/6] imap-send: enable specifying the folder using the command line
Date: Wed, 28 May 2025 13:08:13 +0530
Message-ID:
 <PN3PR01MB959754E8F2C07E29C83B99F5B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g4769924781
In-Reply-To: <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528073814.29138-6-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a123da6-8cd1-435a-aa5b-08dd9dbaae8b
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnVpqwGBbaZZUM3/MIi/y2C4XMX/9hfZSEZc8nKF8l81vFosW6zVLAqGFjkYyaCwUCfjPA8bdMmhyK3pTxsmjvJmMbpn7hYJkhT+qiKW9rHmS9lXYIEky72oSkQkQQGudlR+7NYF+2lfklb5VKoXBl6C1CJDd/sySjcT9KWWy3PUp7ZKprfKJJTc8n3ApRybGYV18MSwAerRIWHzCjjzP68uafIa+l9/9HwOmAfrjjOnGxJPvayyeheF5Fz9Qp4m1Nuc90NALw8llFTuAk9Ld2UcVa9A9xrngJ1JkcTrDonaKJmlfzy4+MK74RqVMvkxZecEFnR6hT8AuZAQF6zqW2HaIp+gcIWEBdqv9X3c4bK+gBdkdzmZ7cziSjcqqtqb9F6R6ldL4eh67Cr6RE2ZtvOEuPZpUXL8XarAWPl+txzy7RXgRoNqvBlgbiaPBsKQNkFTwQlpHIBxmiwMMbg1XEb/Q1IGA5y9jOC2b40tJ4omjfzLOPU34SzrODccnCV/ICjuxqEakvF9JTmDrDTlXIRlVXu2aF/VVzIMapxS6mK6Eu60QAHIZ+gm5jvjvCN5GjhL3yL3Rs2o9bdXVAakcQpJ2S0dlIPCD8sl031O8VbU7qMNYESAGOQ4zreYzysGlrbAHVIl+O2ZSJDCJg51PgOSRKFTqAFQIBCa6Jbtnoiwks7j49qokUBdeWNmxeb3eAVN304KQxIqR5dITbAzRLSE14aGzTP/lmojNWc1tucEI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|7092599006|8060799009|19110799006|15080799009|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8LUPnRjhwJariHxJaDXtzxk4Phj/WSokalOqyShGwNPp0aO/6CZSIO0tvzNU?=
 =?us-ascii?Q?yjOAuFQSIGl/DhhEmx5ckuxNH99ZvywAiVb3R4q/bgCIlr9u49/d5KWMCdEp?=
 =?us-ascii?Q?37FVVBEsaj4CAO85yr5asVMU7fzz7mVEa5K6jwCY46NugHTWjOzfxcbknKth?=
 =?us-ascii?Q?iOmY876h85EAmh+VJc74kpHicM2nKA2AV1uGNyI6YKxrc1mZjqlu7Ai9FUzn?=
 =?us-ascii?Q?+9nDrsONe5EXT0U2F0jWCdVU5exGIuZkIq5z1mnRYN4et60GSExKTe6Y8tM+?=
 =?us-ascii?Q?e7+WrggAfoihEIJeSpC6a806IeGIobbPqk+9d2Hx2i89s82W/xAr2dm2SqlW?=
 =?us-ascii?Q?a6iiDKO3Le/QJUTwC6X0p6hRw7Lj3ED2NuLA9lysJeAjrK0tCcQvzZGPHztw?=
 =?us-ascii?Q?fwyNWA/9nx5OuyPsdu5auV7BNeq/QSo3dqLRLi2UMXnAT6dRDhPIdqazxZZI?=
 =?us-ascii?Q?ue0kJCDfuXNhdGDaFVgWEXkz01+XX0B20nlmK8D4gBPplLNCIizX5WqFmx31?=
 =?us-ascii?Q?vDt7HNiyNohSK8m27Rq7JCsh/nkL5kLT2Lp68833telW8ibMV+AczJO7UMGw?=
 =?us-ascii?Q?kB3SySHjtiLhl2ZNg+z6FurFF5cx8CZxQf7NkVUah8xzAc16mtcuZBwlkG02?=
 =?us-ascii?Q?4FvjVhemD+GoNDQPlfUSnfDetLLVrvwUmppY1BrPEtRk+cefHOigX8N442IU?=
 =?us-ascii?Q?2Wqd1kAYECfznF+Vmkd9pkDdmNiAu9ieFps2bpeHUy2O5B6z6rVJSqAlAAGl?=
 =?us-ascii?Q?p8rwKfVR9xmsMqtkRNAdeLPrS9g+kesg2+h934tzjDR9xkW45/7WfYU00HWo?=
 =?us-ascii?Q?CGLTWhwt864JPDHDHAdi8gn9c/QujUSdnLcnB+DnYEItux/KJkwl6YFDW++f?=
 =?us-ascii?Q?etcv6uDncNFy5DSkT3A0fyYASCq3XJdq1VV9YrjGQmJZSOewq3KVL4WmGu+I?=
 =?us-ascii?Q?4nNKV6yZonK93PBBsJpRo12tOOCGjvJbrLRJje7UaGrTflwRYqTPcQ/P3V3G?=
 =?us-ascii?Q?O4Cy9PFmALQIPiNXrKy9lFu35AVjFCzrvmoke4MAttTjY3QDOZ2Lmi8XiQgI?=
 =?us-ascii?Q?QvbYvaXAh12bZimSpJvbh+eAo+8rZgm3tkXHhCuwhuAR4+XN+f9TCIkbbbNU?=
 =?us-ascii?Q?wj5wNexhWq6gYZ/VEBuk8Wmmafcs6mTEzQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g7Qgp9diIE0fqNF9B3bl6lrEGR2IwwGNvDamjypWtAZs7YhnrZDQa/gesCmm?=
 =?us-ascii?Q?rxpUPGcMvnrQ4UHiiohScTLmmxrnsVysFVyOWcMuJLmOBvvhBsG61QGZkODm?=
 =?us-ascii?Q?OUrPKOreIr95WQJ2TsCz8PZvTW3/GjcxJ7Gods5suk62+KLpGvBZb294MIHf?=
 =?us-ascii?Q?JOl1SygVf8NeEeJLH9oflLeEYY7uqy8rXaVZXiTAAdMf2ceyKEwucDGooVWP?=
 =?us-ascii?Q?adY/pjdIUfPI+/6zFlJtLNLggrke22/jmVuITPDE218VLLl+PtD9cbMXDs0q?=
 =?us-ascii?Q?tMmbtl9u7OxTIeUCxwnhV2QXYghtPSdb5qERiXGg6vLu1RIfk14g/KB4w7XD?=
 =?us-ascii?Q?9tFByC9I+PiWyGj1WKjG0awt4N7Gys1bs8b1w+E///R+HxpPIb80lBPuJohn?=
 =?us-ascii?Q?O8JrmB9iMGXO31L3xLHhH9AZsL9k+9braPgJ/KasJchN8E6yL1a4k9HUiR1P?=
 =?us-ascii?Q?q3d3dxz76sZWrde8v2kEHpJLCVGwZlV1r4NjlDgAIKg07HdTowQjHPcknimt?=
 =?us-ascii?Q?LuRYwEz5FSH3NKf4w96DjkyQ0o7Q68udh+xuJi13nG/sp9gIq8VADPnaeo53?=
 =?us-ascii?Q?Cp0Pqso4xJrFNFpKySTs5vQpRMuVaiaBgCAsN05yOGq+BW3/qUcEsGtS2m6/?=
 =?us-ascii?Q?uiOgOlVie8WRVMOiZ1FHghiNf7vyzaauZ6PUOVJy7s3wRJrdiNBLlD2N4yA9?=
 =?us-ascii?Q?psiE48svnXjKvJ57WKMX7pAt4GEjyLq+iX/1A6eYrrWfdlx1bJNUHZ0u6P2e?=
 =?us-ascii?Q?oQXAVv0xEC631KNd5r4wMX2kqSx/sroFWMVDPqvfmXzQbNJmBvMM2OixG67K?=
 =?us-ascii?Q?krBFiP02Vf1cMV+jMy12HUSHTgDnzwkvvLQHMoOmXM6KuOk/2DM4+KeNgDQn?=
 =?us-ascii?Q?8x4yJOY1e0EiKI975MJdkxY1da3eXHnZV2TvhuQD4bBn1COSiLynM+BY7rxZ?=
 =?us-ascii?Q?+yju6zn5Z+TPJ/+eQe3Ly/XJ1SfW1j4tDaqZFYosJMCi90NpaTjs4CbzQbtO?=
 =?us-ascii?Q?0IyEgQK5isftchgSZjg51WJA2mNQbUY5BWhB7Bsfu2Y0YVhQNUvampZIfRmZ?=
 =?us-ascii?Q?SZ1Dn+i4iqM4Rh60hY4j/gp91udRIdWc5vD7T5D8/D0LY55iYaujfrA9jzfT?=
 =?us-ascii?Q?/6uVYpGhFTE2ZsYG/0+aHyd8ijz0WyPYm3sAG8Bml5kZSaM9L5Nrjy3zYmxk?=
 =?us-ascii?Q?MVo+aPEHshY9+xZLkjzdgKYOro3vPPztnmC9RxGWJpVT5kD7stJ9Cmb1JMrn?=
 =?us-ascii?Q?GszrEy7F5E9wfFQ0SxMFt4WOKbNSuzGTiDkVwN3KrEkb0f19guRtHvyIIIQk?=
 =?us-ascii?Q?vh8=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a123da6-8cd1-435a-aa5b-08dd9dbaae8b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:38:47.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB6577

Some users may very often want to imap-send messages to a folder
other than the default set in the config. Add a command line
argument for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |  5 +++--
 Documentation/git-imap-send.adoc | 15 +++++++++++----
 imap-send.c                      |  9 ++++++++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
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
 
 imap.tunnel::
 	Command used to set up a tunnel to the IMAP server through which
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index c3a46070ac..a35f278baf 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -9,21 +9,23 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send' [-v] [-q] [--[no-]curl]
+'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
 
 
 DESCRIPTION
 -----------
-This command uploads a mailbox generated with 'git format-patch'
+This command uploads a mailbox generated with `git format-patch`
 into an IMAP drafts folder.  This allows patches to be sent as
 other email is when using mail clients that cannot read mailbox
 files directly. The command also works with any general mailbox
-in which emails have the fields "From", "Date", and "Subject" in
+in which emails have the fields 'From', 'Date', and 'Subject' in
 that order.
 
 Typical usage is something like:
 
-git format-patch --signoff --stdout --attach origin | git imap-send
+------
+$ git format-patch --signoff --stdout --attach origin | git imap-send
+------
 
 
 OPTIONS
@@ -37,6 +39,11 @@ OPTIONS
 --quiet::
 	Be quiet.
 
+-f <folder>::
+--folder=<folder>::
+	Specify the folder in which the emails have to saved.
+	For example: `--folder=[Gmail]/Drafts` or `-f INBOX/Drafts`.
+
 --curl::
 	Use libcurl to communicate with the IMAP server, unless tunneling
 	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
diff --git a/imap-send.c b/imap-send.c
index 87abfd15f3..51372e1811 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -46,12 +46,14 @@
 
 static int verbosity;
 static int use_curl = USE_CURL_DEFAULT;
+static char *opt_folder = NULL;
 
-static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
+static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
 
 static struct option imap_send_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
+	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder"),
 	OPT_END()
 };
 
@@ -1762,6 +1764,11 @@ int cmd_main(int argc, const char **argv)
 
 	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
 
+	if (opt_folder) {
+		free(server.folder);
+		server.folder = xstrdup(opt_folder);
+	}
+
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
 
-- 
2.43.0

