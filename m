Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40122258E
	for <git@vger.kernel.org>; Fri, 23 May 2025 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747973058; cv=fail; b=t9pJiKNMt+ZnJgTUxzUgrr8GKk8vSA7/ni+QBBlig5KcU966mcu7lKceXMQk9Uww3zeLJce6i3il4f7BXVJ+APGkjZX/NumLOiy3zcRs2krFgKQ0dOs/lshQdd+TbiubaUzhiF+E3Yiy10LMDNRaSrVqs9UGlGA3LGsDyvmnDNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747973058; c=relaxed/simple;
	bh=6UzPqVZzPGFmWKE96ihPgVlO6fj6Qe53TcwWXVkxShU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u6U1y6iKAEeyo2yslIMvmuhA+Z4WnKVmlXeoHVise5YbFPHD2Lz7jVdiT3voQPVHYFvoC+loVjh2khrQGOITCpOW/zih82bna/ckUQQ+2QBpaw4wLKmmrtekesXIBi20ITYdGDEUGNS6a53qglQYdWTogfBI1nTBkU63SLFUQWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=U1s4nXd/; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="U1s4nXd/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV1zHJC/o5cbACtSDi034wzEYrwcpTSfqJxKIdquvQYAjmFBCVbkowVAp4Dz7ho6XCQVNeVmMFGW1Cxr7QvWCY59Kg6iwBtzxENlTC9PlgAoOBQrPUcRgi4XLUWqn38VQ62/ANhvWFrO7cIsDFXKG7EQg9OhXGx6ZFzQwvMt9f4Jixj0uyAaB9KjB0f6uWq9E/W+XlBdJ8m4Fu/sIkKHx1Hn6FoNnGjmQRvfNN99yDYLU1uDWsZnHVgqQQhyuJN6yXYWxp+85RHabKcefdKScfai0kLa12+ZY/2hKttbppFSsfqEA5KN1fXijbidFu5Xfcw1/JxikxAfF4O2SNJhHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=po/mF64P7QEydfDR4LcIKR9jVVfkzdoFqKbvZsmwL+w=;
 b=H6s5uguqQHY2KvtuSFxkuuPWd/FCDjHwlX7Q7JQBxxZssqszP2uoAGfCGQzENSDTXag6/L49eEn0SckPjLYvfWdPUJJNJhtBs+G+kcEGg8nD5f1zHdOCHqf4wLJ0BIr6IJov4+glZjZVFWXeZJvwFXTOmhdMaZJhQ8EpPd6/CydIZUznP26zrDmodBHpU7wYwXpHwk51gyAAKWGe3YLc5b932LVT00PbaLS6e/hRCh4m65rx7Nsd6xXXLBwgCgC8nJxB327vpA6OJMclAvZ3A2GJ7VN8/Lk/eSuzSiChR4sKYLdZyKWiy94jbWqFi1kXAXDIAfPVA+F6dV16cqyarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=po/mF64P7QEydfDR4LcIKR9jVVfkzdoFqKbvZsmwL+w=;
 b=U1s4nXd/Q/9ORWLhwZyCW6KYXCVgkWefUqP3tu+2ImEOCdzBOAPSOvGGLhhgxjwq9Vfljn9AIGluKIVPKOwXDKtJibg6MAvWm4T+s2NkXh8NNkilnEs5xEYRvSzo2i9iBXm9hbsJJCWdHOd8sDo5Rpau4isBOQ5NiAm/DWuzHe+1y8Ie0FNozL4s3hNQSrQJqvt9F0CdAvAIPbMHQ2WpIxmAti53RTcxvH/dtM0lRZLaA/vV+MmlXc+nfGKSb/56Lh7hfLrpOmc2TghpZ4D044JtnvZQnGY073yCo9EgwYc5Yp9xGn69VEmY8b2i9ESzi0xlyAeMjojua0MaaoZIXw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB10178.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 04:04:07 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 04:04:07 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 3/3] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Fri, 23 May 2025 03:58:34 +0000
Message-ID:
 <PN3PR01MB9597F251FC1AE6A78CC92C93B898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250523040347.25483-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: 7008afce-5c68-42d7-261a-08dd99aedcba
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|41001999006|8060799009|19110799006|15080799009|7092599006|8022599003|461199028|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NaQNZhb0RkNmVzuTGnKuc6IQH6eX24YVhTDtFwbQIbXlnGOT1DlGKg34FiG4?=
 =?us-ascii?Q?kgZ/mvrRCWBGWNtk2Ai5bx/1wF1xUc6j0Nx/H6itvUzSZD/HH3L0msV7SFo0?=
 =?us-ascii?Q?+9pXXoQWANgXX9teFH/b9XpizpMyn5xWTH2grRyA/ruooQl7BH/WQX4oAl+4?=
 =?us-ascii?Q?dBtLhw6jEJltuwqTwPJ2wjmd1ylBCpMBLe3igEJUCgB3GCsco0o5P9VfL59X?=
 =?us-ascii?Q?E0BVeHtswktSXb+vicFbHRHg8m/LY4uWJuwHJFM3MW7WESpVBG18gYfQkPxi?=
 =?us-ascii?Q?hcDSDXE/uIrLwjYKLFjJ3+vu+err4YPxZ4ELOGuq0yLyZ6KGfgerdR/fN0nQ?=
 =?us-ascii?Q?7stpKJvDGbpg6vm7zo7p8iETCricwjHMsi1hGTnOxl8JwlxyAwWnNyo9Uvvm?=
 =?us-ascii?Q?ZAkAtOuPYErVwa8QWpwjqLKQqXLWFd8RhreXFOKrHLdQ7AEyhtaLPJhj/JP+?=
 =?us-ascii?Q?tvla+oeI9fVWAX/cvbJPVpSCxo3Vjbvnv8l/8j4woHx8HQKAa6VcM97ft3fT?=
 =?us-ascii?Q?RzUhaTzZ24mOia1L4yZPygWUTx3VNkPl2rVeW4aWDiSWN6gxdowHF8OvkoM/?=
 =?us-ascii?Q?Odcz9PYfJWMaaD4IGYVpN2PF0rQqhMXnRz8FSaSOqIwCAj+ClrxVHs7i3+m3?=
 =?us-ascii?Q?Eh+ikrwPvxjadgU8LTZ3lSmT+BWsEuzqFXgeUeuX31iGN79DrKKR/KHxkoSn?=
 =?us-ascii?Q?qKb/XSEjop/zlQ91Uu2MS0DV0b1oOfoy9hMwu939l/Fb2TZYXw5ZGLsaYa5+?=
 =?us-ascii?Q?bK1TZUkXVVmtrseXI8py7nxROWzQ0D3wbC9atPqbHXWhxEueF9iTohs+ZrUx?=
 =?us-ascii?Q?K1n98uLtvsX7hCCYI0EuSXXMuavkaTmcMYF9tV7StbRQyFUGcUyOXuIMPDOj?=
 =?us-ascii?Q?AyFC32cUoP6ToivRMDo8NT9MSSBI7TPwlhvxlYr7ONXM1ofp5T8K73Q5WVCP?=
 =?us-ascii?Q?LGXlF/aKQHDJ5L/C/Ah7aItKtRXbKOCtrjDKAZOz2cHgZM8gAKvc5XTwQw/J?=
 =?us-ascii?Q?ZzWiwgYlYXWl8Nc5GT3A4o1zQ+D8zT3iMyKnmBJ9eRDNqQwMvGYaM7EAmSdZ?=
 =?us-ascii?Q?Yfmc6pEeqXprNlWOwFfoQT0j6HxPX6ELLB+HhePcUmlX0KEf6p2S9J3o57Kc?=
 =?us-ascii?Q?2YGhRgX2+907fUByAsO6SXv/jV8SO/ipetqoeUUGeohQ88zJT4E+v6mCEQbK?=
 =?us-ascii?Q?l781ylEmDosMnhVb2eAd6hJlvQ70qrRNvAPTAA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3uyOhwO6610+7m6PrJQgAzdsMzmhB2PMHvEhxd50WY7tvsj8dBW5Ak6np+L+?=
 =?us-ascii?Q?5hv6HbMa2GWZCYWkojybls9OvtXzmX9uRWeIDY/5Zp77GiDQs/LkAstzDeU2?=
 =?us-ascii?Q?iYi0Dk4g1iF1k6Bx1Zzznpu+3dSGJfctFkjsDC3MRpEPyLzwnp3NMWJcwTjI?=
 =?us-ascii?Q?2gtA+BVbucogQpHhFOALpsnC0HRnL+D01GSm4L2XNzcogWF6Zzc1cXq0Oenf?=
 =?us-ascii?Q?trGEyTCVwy4PRyo1p/TElOHZJOLDnlZZOMs/1D85MgsFGzH0Q++a9+SO2Q4D?=
 =?us-ascii?Q?zIdL2W7HaUuR0MMj4GDfO5EWroDbHPdQwquVJ37hgoIOQF9syVEHN0a3ZF5O?=
 =?us-ascii?Q?6XY3S8dvWjbTB418K5GWlmolyJxcUlWrFu+vsnLtHpe8/Id0PkSNeTnAK0ba?=
 =?us-ascii?Q?XRjflJbqqz1lUQhAyNOp92i6ZY9tC6492Ottem4sYkncYMGIJl4iomEPv0JL?=
 =?us-ascii?Q?TwVmd1v8I3tR3McOF3idVvsqBjlSnw9xo5v8FOIoOM4xYUDdvh4dl3BIw7m4?=
 =?us-ascii?Q?QTWcq1Xce4HvUUQXxREEVpbk7COKwzLMYS02yh4w7at0PhcfG+CPqbkDhjBw?=
 =?us-ascii?Q?Dd9GwtaAbhc7BHTeEWDIsQrrcm8cMZnIYJ4eVO5q7CWAI6n+vG9krVHcT7K9?=
 =?us-ascii?Q?/8htTGEvVfTXQmyN6Memn3twT7J4MeUSP+VgP+x6Ctb63Znan5Cjn8PM4LyU?=
 =?us-ascii?Q?yQYSqaoL/Acf91JJlILI5DYbT8Bd7DcyyoHdvGoNKPHOIPxXvUI2gPNuQwqe?=
 =?us-ascii?Q?C6YypGb5PU7B9k4oUBfJMc4MRKnR9XmcCoS/yvlnSW9gltPmZrhUCKYzDJcV?=
 =?us-ascii?Q?6AaK6/EqptMu0ErVBXt/THhxYyb2SY6ETNPFSLbkvqLiB6DEHGGfRxfTO9Uu?=
 =?us-ascii?Q?EMBZwbmivZv8FfEGnlTRCS8tOkpNQl7LbI3It2Pepcad05GzZ8Z3JBOrPCdW?=
 =?us-ascii?Q?upFNQx/eL49c3JI3JIPj/GU642IV0fX1wdidN+QdEueJ3plx4FeqJMEFAX7h?=
 =?us-ascii?Q?9a4A3TV8CRfo+DYO5QA3VZIhTzHjXhhrzGLRAuuhq2I2ITPpXp94LEZfqxmz?=
 =?us-ascii?Q?etBI1nthS8lM4OKDgt6KlyYrf00Ii2g1KskLeeNEyAE2VJuISD2mcfZoITbQ?=
 =?us-ascii?Q?iw4lYaItK/GMBHyObS+XLu+VUIBZ9Vdm9mYKS62pN2hRf9OLuD+f/JdI3CzC?=
 =?us-ascii?Q?ekODsdi62zRuyUywPQXYflyfbUUPgVIR4UR7ID7ioA1+2SROe491DFwZJ/E?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7008afce-5c68-42d7-261a-08dd99aedcba
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 04:04:06.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10178

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 04b507fc14..e19dc69b7c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -983,8 +983,10 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
 
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
-	if (ret != strlen(response))
+	if (ret != strlen(response)) {
+		free(response);
 		return error("IMAP error: sending response failed");
+	}
 
 	free(response);
 
-- 
2.49.0

