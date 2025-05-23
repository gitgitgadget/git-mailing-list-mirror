Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0898635E
	for <git@vger.kernel.org>; Fri, 23 May 2025 04:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747973054; cv=fail; b=MXmGGCtPgFh8DAT26te7Hv4oKG+KbGOra5eJYlSUyuE1bI+dKric9u//bxHT6d+MCXb7/DJJk4Ii//v60N4Lf6b3kO8NHTJk4VS6++Tf4ouIU0QytsgN3C6uqxBy6b/RkolL4qNNVm78nWEOGFqHIhgFNGhsaOxZ9YdlYQWueJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747973054; c=relaxed/simple;
	bh=Xy8clKYYETYN7OMi7SX6rIMAqx6BQQxMphJ95F7t6Ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KW5cCRwHDNJA3KI6mRMOboDD5RPREQ8+s9g/7Z3cLx4LcB1KWmJMhZsJn4ENb0hBRuxtaADuDrV6sBT1qmKPy3KoR+AqnjF77D+8Ln+4V6z0U5VMhg6BtXfpw1NFdWySyo19ZfqIGS49O28LPTKRdUWVjY1LFVKv3ijU0nUr+v0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=IZ/f5BYX; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="IZ/f5BYX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XU4qlIPOlU58k4NWK1NIhSViQscCm1GkYNRMBcUCAQDy4SiR4PI9KqZT57qMBgbQAukJSm4lauJ5LwovyfD52h3PztqoI7ScXcCCkqGtU7i6BVNheeqj9PlycY4rqpY5wdpLwFXpyd5J7h1Y+DOS+5SKepM7Ib3bUGoMWVgXKStiAj1DFguQAGcF54EEvvlqjbqEPfj3UhlvsCcHXRywUijCJcLD04f3NF2sDY3ww+xPcjUB4l8Nrf+RzJqez+DzLWvsFqbmxuNl/q2VSw+jrdAWaDC8uMuX5RAWmai4ZeMO1vO0h33YkOxrhC+Jmr2pUpetz761t8PKo6S/8gr47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYgTcM4jlrZi+bzcWC1vLIquOLb1+rqdMJbkAzwFr0E=;
 b=Ofq/TNKEW87GNClXmMFX5svqZfCqgBwH3ZTHTROgbfKdd+wIDaFuTEP+zT0rKnozTylAm/XpmNf1QRwEqOl2RIhKQNptm0qXV6tnBfjZxBOOdt9oniMhykck6Sy4GusBlFcORfZNzrWQDAYzI2OoxO8zWnHluhR2fUeViX0Bcoz3F5tZI2fsLI6j/Wdp2tbCYngJwI4LZYdW8moVJs6w0R+FWgQWEDNxIRgKvAq52O68/y2snN9pvRGn6pNIyvdosTmaORTRHlT9hYAyU4+EOpwfBWcOuqqrKXM5gwWEclHwHOXT+8t8SP4rg5IDzqSfQem+pKH4xbV6JOQXw4dSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYgTcM4jlrZi+bzcWC1vLIquOLb1+rqdMJbkAzwFr0E=;
 b=IZ/f5BYXzMDw0lWwjizqJxY259DsbQgX3743j/CRXzZzQL+LEAzpsCV1o2LVZWRQjEeaAadziW0c+16jWJHydD+ggtYbb9DD+oB+fKswmy+Saj9hb5TnrVw/7OVnclZZTwU0DmuDJkfVmMFVnBww4ourX4TI5ozsH1NKN583uboFP3CRDiGdQZN+aYMzxk5sl8WWiMttM/360EkcYpPzYbTsO/1qQgCWm/6/jSyChh9wJgVtN607K8oc1J/fXgzzcY5X3wvWonZf6p70bBXNSZOwC5X5hru7sHUwOiuIDekmPlpBguWrPdkiKBpkoGkojhYpXGoNTOjlFdLZkEkE4Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB10178.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 04:04:06 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 04:04:06 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 1/3] imap-send: fix bug causing cfg->folder being set to NULL
Date: Fri, 23 May 2025 03:58:32 +0000
Message-ID:
 <PN3PR01MB9597E47BB9662200E32475CDB898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597F89DF32B700ABB8AEE11B898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597F89DF32B700ABB8AEE11B898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5P287CA0033.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:263::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250523040347.25483-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6e2f7b-7bb7-4706-09e1-08dd99aedc3d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|41001999006|8060799009|19110799006|15080799009|7092599006|8022599003|461199028|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hyb8m6NcqrD5vmdPbZDNyo3Ys9SO5oaDjTM2bdieRX+VEpKPjKi0pKNZGSkJ?=
 =?us-ascii?Q?HF5TiSzRYEQlx9cCue/088XFtt5dskVNAXO7Q8RIZ41NCSGNToEwQk0DKvQb?=
 =?us-ascii?Q?vgZUpVRUm0+lgRndx0ndDtlFgVFKSAkpZBO3aiQyjGEHtj/Na1lh29kxPKtr?=
 =?us-ascii?Q?82Cxj+VNhnKFJKxSpiaTRr8cpHoukEnFfOXITShLuFUBr94gf2agd8tbEvFM?=
 =?us-ascii?Q?QumcR1S3esdue/7b0LLcpllYqcAfHFj/6Bx3cMV3A9QdpBNp8xPv8+nVp4Rf?=
 =?us-ascii?Q?VFyb4eVDotyeABMEhFLdUeXaD+NqNXkyQLsOwyXi9VhK0joYva7x3g2J4OY2?=
 =?us-ascii?Q?3k3ilopXMCGXhHxjJEhceP283kHPVgc8hBsrEHbqBRBj28jnNpQNcg7Ybb8F?=
 =?us-ascii?Q?jt3quIqPSPQIBsa/3l4knb5feszqv0nQrYVFAodlx9X83fKlet4tMimTJ44M?=
 =?us-ascii?Q?puaYnsy04NCEp3iUI9QeoqoKYW9gklbUviLHbB181wUucFZlTJekCQ6tTP7B?=
 =?us-ascii?Q?fhIfj76KH8DC0bFpvJhPfr8p6jR3gmoJosEwGNpylzgdHoHeTn4bhxH3mdkD?=
 =?us-ascii?Q?Dtjz4bkZiVd+MA9nDnwAUQ7RmK5g3g1Z9ChluNjEXknxOJgNoBjwJu6ZrC7Q?=
 =?us-ascii?Q?g64VgPluMiJJhjUYA0XOyJDNYmBnfOFndJtrGBkzwZLrekI0ddyH8JLZJy2/?=
 =?us-ascii?Q?2brSa9Zq/s6qowKPriwaCqAXkc/aZvKwQ/+NklRwO7Dkv7sVJFXbLvw8eVyF?=
 =?us-ascii?Q?5wgidb3Vot19XYzhMuMUAeiEZfgQ9Znlq9Ahe/kp5qGa4ROFAVJWZB2hcmRi?=
 =?us-ascii?Q?msnnkXtIoQKFhh39tF51tXLp+sTPOfbUlrspbS9wsGVA1OzeNflkKERdPApE?=
 =?us-ascii?Q?hPZOWeDt6S2hkphiATw8iCECiM5PtavRs0Tdb+2a0b4+wKLv+Az2KKRkWs8S?=
 =?us-ascii?Q?XqroVRSDrLgk9n2P1y2c1AoSSBRkVzs+eHCyL86fy08ptHTOTQu8Ztn4jwng?=
 =?us-ascii?Q?JikvAh/n3NsNDTenTNzrhD6nTVlZX2ddv7lazTXt46dPOYEIjQa91iirNngZ?=
 =?us-ascii?Q?/BB9wE8y/TRrHbVfK34Vu50Un8pDOpUlrMBT043FN7jKDCFNJBGmgmjNzBLl?=
 =?us-ascii?Q?z3C9Etx1oy2smVITxSnlGXRlWs1qQSrt83oL5isNx9PDxADXr9k4Nitg9n+p?=
 =?us-ascii?Q?bnflpo7oFU9Ehoeq?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dunwk4UJFsuXhP9AS2U3ZOnqHKInEexJoc2flO84v2ri5b1bc0ij/GO/O4Wm?=
 =?us-ascii?Q?DSwklPttZnlzwFap5B7AUMfLGlXiqfVc0KTv/yqS3fSAnF0Scu+5VjUiFnBT?=
 =?us-ascii?Q?o8WlALIfY5JhhQA3OXWEszvK7luZ5vcrryEjWwdQoUdaibcjP8AlGGYqMGlh?=
 =?us-ascii?Q?ea+ZW6TcZWfwctheFd2LymYZYdjXdfsIZ8R2vPR00hOVKe1cU5ZYxXa2DyVj?=
 =?us-ascii?Q?YrLz5fytNfrpidEVWcW6GpXJbenmlopVQBTC4iZcLOiP629zCuKZDFTv7xQi?=
 =?us-ascii?Q?BYnGmAtnXN1EcsSbdndDowF01SH0eDNRAr1HaD0wGaraMwcrWTyezGAU5e6B?=
 =?us-ascii?Q?5hQ5eAIORl+9aiq8xGyOyAAFvhTBMuX3B9LXXNJ9nBM+w982G1rJuP3elzcX?=
 =?us-ascii?Q?qyJrf7HwsMNVnQu6W/wBhnEZghGuZ8nyji/OK+Vjh8xOXArbMLEAWe0Mp97L?=
 =?us-ascii?Q?wXxjeXhjpcla4a7vJA6rUgbzw3Yc2+o+d3//24qClNTR23un0mctFbqGvTmS?=
 =?us-ascii?Q?po4xV1Ap+JkJDfqc1lBRHtm3ktUFi4v82DSipxxzND6ep17mVhYC0Zv1crbL?=
 =?us-ascii?Q?21J4QaEaozlGDJgS/gEUzvTEQ0ZhF26CsHHzkuLos5TNNYhFKcp2PWTmZaLt?=
 =?us-ascii?Q?Q7wTtz0yatRnM6b/yyTY3CEkBqVioe+Nhr3/pBcboXgBDQpsl+yc0bjjRDoN?=
 =?us-ascii?Q?V6k+l7djPO3bfZ9MOoF1p2BCoQIlmy+slrSHk+rMroVIZfEcvaNeIJKqXOBB?=
 =?us-ascii?Q?84mL9jkh33umfTMgf85OuxeF+iteb/sqcs1XFI6bF44Tqd9bMwbaZrSnzZGu?=
 =?us-ascii?Q?ThU8ka17DW/kZ7XbE5SJMkDFJgt6E+pj1guufk6vu73MA8CwdOrQqD/+UvnM?=
 =?us-ascii?Q?CfunLgGgASmFV033MoYM602fft9pJMFUjQjU64P99FptB+B18OXuOZYwLdnI?=
 =?us-ascii?Q?5hsYNvIwRUSuT630OZ+xsUwd78tEQhAT0gBtUfpRv5AVTia6qOoTF+lIC0QD?=
 =?us-ascii?Q?K2hrxUzy+WKeseIy7Pv4d8zVXUDF328otbsC3N31dBzqC+c+HkYYBqEpjPVk?=
 =?us-ascii?Q?ZUokP8F2tqrNwtVOd0e/Wu/OZHhVSvFVK3sBOkjwDo25UfY77l1ABv0i2Qr5?=
 =?us-ascii?Q?hiKnhKaf4Xa1nanc/5yGudlhdmAKM5T3nT7G/cb4N1QhiiTZ448EoQbkqUWw?=
 =?us-ascii?Q?XDBcMVDfExpUa4qC3WlxqJ95dCR6t07Phs73dbhPfCgJ+75bQgnJe9Uf+zM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6e2f7b-7bb7-4706-09e1-08dd99aedc3d
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 04:04:05.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10178

6d1f198f34 (imap-send: fix leaking memory in `imap_server_conf`, 2024-06-07)
resulted a change in static int git_imap_config which resulted in cfg->folder
was being incorrectly set to NULL in case imap.user, imap.pass, imap.tunnel
and imap.authmethod were defined. Because of this, git imap-send was basically
not usable at all. The bug seems to be there for quite a while, and has not
yet been detected, likely due to better options like git send-email being
available.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 27dc033c7f..37f94a37e8 100644
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
2.49.0

