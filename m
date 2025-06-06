Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33EB21767B
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240538; cv=fail; b=jsZiDTGgs6HlznbUGYY6VeChUYpCcih5uPyQlUldtCmOLGWEgzsA12uT8fSwC8yBRCN4O3CfUL7kPDp2pLfGwCA9PKpbBLQNoO8rs5FhYvQmU6C8SvfQc5Dm2bq3XhLdHhdLR/hGTBjDRSG2wZonOgU4ezKfbTd3lCdQ8k3DENU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240538; c=relaxed/simple;
	bh=C2Ea0fZ/1fbZp7wXFXYheErtV4NTDUaAB+ZPCRCqPGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXca8LsHO3KI1gtyHzSV1hERMQZ0FQm5nEfcgW5F1gx8j2ImYukFkm6M7oEFykQDrqhxmxWNZIrbbsOwMZdOXQXy8eaHr5BM00yI3tXcxHz1+IMsmcac1gjW429Ps3o3xVlEHhnUZZfg1moTX2EItGIbN7y1ScmZSmnGPWTj1NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=CAP5wVcO; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="CAP5wVcO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1UZOdfMCrhSzjdElwYgumXyFNkhWG5iGwTs+ToG9kbtYfQR1meoTCaRFPqL2WOTwoljSiGHymogMCtULba0L6gBavxHCKmRmlaUtg/TiZdZcMW7H+7I4lkqVG2e6KkQbdDRmEIXXlSLeSH6h67YnTeDJJs90sw6JZheb35V2s9ojP3WNpaQK4JCD/XsONBy0RT58eGHrlHt3e19LSLRoVL7QXbfpXBWdPmy4Rc0w9eAqQ+KAmJfMqhsFzh2PcxFtJ9WtdjDvPlzR8/2IpP3L+aqgLbqTPZEHxWuJks5vA3Z+gsZXrOn8o1+dTsIOLeZ/kl0u9Vd3lrNH451hY4HyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn9dcpWLeDQognIjZ8sklbeWx+YlUw4c3jgja55dACI=;
 b=RUzN3D+SsmyYM/UWLwr9xgsHbgTng4vvhZ1sWq/Qaz5Hl/t2Sn2MXASMLhiXNjkODY8Z9HDRsYE7wE2gKNtnz4dDOAWI7Dum9vAUrV9RmR5aJ1JigQ1kddSNRpE6wSFL3TsIMR+b1Ah+n27ODvSDD1BV1CsMfXeRqPgfYWGJPnBIKlcn1W0HsnJz4ZgF8NWD1JNpy9ZYCA2EOYYVRl+EpUJ0e3AudvkIUoDHEScsTWOu8yh9wHl9aJewAZU5FXVQJUYdKl9uwkjmdno/cIQl5faYiR8uQrWVWPx+tYVLgF3cb/QmnrzSnV3/n1rX1JXNDpUi+8U6yTUA+3nWOXJqAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn9dcpWLeDQognIjZ8sklbeWx+YlUw4c3jgja55dACI=;
 b=CAP5wVcOixn44HLFx2cBnPopEYSSEnWPKOte4RsAqX65rquqCV6U2Zz4oBjOOhXjnJYpMyKdrbApZlVG4S34LV3yzE9FruLJjffUucTXDyPU1WSF1ITzgHu1BSg6xH77YlhUn3f5K3VmJqBT6rnfW5LFRlHZyRkpciPCeZNyL2vIGBiHQgCT2mmI0nvRMViz32oU2gS6atmpaasn3/OhhK+NP9YQD5U5tUGVWlz78dbMeoSOM9C2YAM/I47w1gcpoOvZp19mFQXJGIU7ats/lcMlqNNRFgoAtGUJOEHuafchD1qBgZT1c7bhwRkT8aYONg9o90l5TbHCncN9ws5/ow==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8841.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:08:49 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 20:08:49 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v14 01/10] imap-send: fix bug causing cfg->folder being set to NULL
Date: Fri,  6 Jun 2025 20:06:23 +0000
Message-ID:
 <PN3PR01MB9597CC4CF79C3316ABC6F51EB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g0975df9fc0
In-Reply-To: <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250606200632.43298-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 274407d8-52e2-4903-93c1-08dda535f2ec
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrOwsKBlx1JOgp74JtkuEUkO4xHxbMngDsRQHoagt317ngSLDlqknva+VS4GQi4FanBtBKFu8kbEyEVwR0gc8ZFtfO3p2V1H+B+uTDjcCBcQAwxEQT7yATnrkHhLdpr0ejSkdgdCfVSg7x18cgf+QQxHvBMFtxP6btZxoC0wOV0iG69GScXOTCpbWq3naI0C/FRAdwbbkhjV1whk/MR3dR6LBdtdlMa22m/utIFTokdejbgKvpPqI+xsg+Oqa3dVh73f3MrkNBsRNbo46ck9n2VUqpigfRZGQddJifZoD5S4XZeFflnWWnD0wCmKuZuqtjKMW7f0wkV8mbOlt2NSp8h6k3ZZqJDEnyPsMjcmOyBYUTTdoU9p+D8HZRHX5wTPCyyMjrlVK1nU7m10qSRPlCjDIgLKKYwkKvEV7qAfsbOZ6Ua3ZrijVBWVfN4l0UUWX6hurczZ5yQjbcpbA468AKjYvg8h5vEH5flRdJ3atEbAjtRKnVLysHIZ8GITmod70/nuVkvAcUOa+feUe1trl5HA2tlkhVLKmWj1qcdzlirFrCeCekC1F0JjAw59PXg+2heO5tIPSP8pUWx4MbaqbreanFxyGuCwdVfbt6FJTlg6/3zwWvTU02q8mkwg3+zxc7VZ7uoEM/ugZWM0CC77Fd+ywFOWw01YrKhDhjoA4ASKnoMn0GWZYWUZyRBOs0yD5av3hIzN5dh6D08b3qj8+Jc/noBVY3IKly9tdIWbur99o2RX7JfKMNBHtuazjAJXahM=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|41001999006|5072599009|15080799009|19110799006|8060799009|7092599006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?geOwcTPz+5DxEtQSZqS3/QfVeU1nH91MlliBxMaivp0JbLY+jV6OBikYqP82?=
 =?us-ascii?Q?ZrdgZ4L6k7xUVpJutOBWKKqbZeEx84sSbrvuQHRNllXw2kHXkMSYFpIUyv4+?=
 =?us-ascii?Q?DQ+BoKlb/e9mRriBR+kDEFvzrRwFAdq4dgIVasRYx9/hYFJbAfrSvuYl4Vkd?=
 =?us-ascii?Q?XGiTKv9ze/ABSyzwBLfyDairL+B0nq1ruJr/vTqpOuNkkC+auBbnMq0+mw+R?=
 =?us-ascii?Q?66RzB7GegWqz5q+HdToe2iXVg2lJ8IzM5pd4UE+nrJY8cR/FQeCwzCifYWJS?=
 =?us-ascii?Q?s177qCCeKOxszIp+pS1OeB77QGsRc4BioOszoZu5QaKqO+lHED8GpzkLl87z?=
 =?us-ascii?Q?kk4RUm+yxqIUMl9zmn08++vI3zD+DVQ2975ZdM+kTwfRQkB9LH6N/D3HzR71?=
 =?us-ascii?Q?8uA86rwv08U3PGfw/OBTTn8fjZ97cCr+xgAQ2CWQwACjTMmuCpy/ccbY4F6m?=
 =?us-ascii?Q?ZLJWRQlCRBVPBdYm3ZksfNiDAe6okpa5Dc9Iu0rbn+6VPMzJ29I/DrJnmzsx?=
 =?us-ascii?Q?+JGeRb8xiEaBZTNHwtmofjI3QiQH9KMf/FHLpz6YXo0z6LVE/D9xZJSrsp7w?=
 =?us-ascii?Q?Lc999IMOUzo9Tf1i2tT11XayPbTyGX8eKoJjgh9azMyqYTVIWYwwTOKYhdzI?=
 =?us-ascii?Q?4fCeyx3fG+8vQoJetyFFss33+0vMXVdViypk8wF4MyXfKzEYbfav6DZIXXKH?=
 =?us-ascii?Q?aCM6Xv6dtLV4eipucP2lxITViMErQK8bDhn+SfENOZugqKKto2S1yHeRz2Q/?=
 =?us-ascii?Q?nBne3/wE9MwEe+Ag2yjv8WNoQPicFL3vj1KMahOQvqaHgxEM2Lcvu5z9BShG?=
 =?us-ascii?Q?9+3uC4Mvvmyse7O29E9nhkPcomMRjCqndv2qsOIbMkht26dG60pu48DybQ/V?=
 =?us-ascii?Q?D1FDrnOsVBdVRXtTAsHXydyuBi43SMqizXCGzVN41zvtAcKCEu/eJKbUZ5L5?=
 =?us-ascii?Q?ecpDtx+jH/LOz5Qj82l5n9GSQykk2zr4nZDlIQewvEVIipwbmkr09Ty7c+GB?=
 =?us-ascii?Q?0Kz/70cWKPe0kj3JBxD7YXYbfIyzBtHHOYwLyn9gQgU4Kn/wycvySbhwoRqK?=
 =?us-ascii?Q?uV4uGrDSowulD+iEdNyHGhYdWDiHqD2lgbMSJzKlVbmGKfuCD0WhpLxuRetP?=
 =?us-ascii?Q?xNHQh1jnDectOL6id6Hf2oGzbNrUtyA5eFvKa6Pgsx+qdRV/ELZQITY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tdTig623ie7ln+5hepGfeRnqY3jhXtStQlOr284h5UaGRwpU5bMyBOq1+qjS?=
 =?us-ascii?Q?/7Tp6KoyIcyOKTZOVdQ+Pr5YWN3kTwx0jUnS51keJcwKLZi5mnH5DTeviVIJ?=
 =?us-ascii?Q?VYqMxYFhGtXYr6BShEMADUphcxzgg+Kv0a0s2sAEB7iZ18wlUEydn9qy9HOo?=
 =?us-ascii?Q?wZS6R8dnELfr/Q4NgV/rsgyPfYj/Zkdeyv9XAkeNCaAOoGzYKldqbGj6GkP4?=
 =?us-ascii?Q?qLPFbGJc6WTcVYoxLsSEHae0ozcrn76if1Mkrh6sXDqV7CJS1W+N2yoQGdUN?=
 =?us-ascii?Q?A+7EtBS1dzAxnULyosstcvPXAa5iAJiAwum4haOXubF3DCzozPCjIbD9Ey+M?=
 =?us-ascii?Q?dYrFYQD3WygopwoQqwnXswKd1tr/YUwTXCHsQDEPBKNnITwNY+zSpJ1XyWLW?=
 =?us-ascii?Q?Rx8lT4SlmDTP0ajcMXDMA0iAF5DQVs1Hk+nen0juKdlB6K4YerP4KFYwDS+T?=
 =?us-ascii?Q?y1UnVn9lPNeEALZ2sXqrMXXfgBPCityGY9x8dpWaXC4V2ogb0AusXYNk36AT?=
 =?us-ascii?Q?kVjRmAulVgcTuTlXqS99p7guxC9UAF29zTvYkjCDxpANtrxa7ZdTbub13FCa?=
 =?us-ascii?Q?iyRUrMC59JTERUsY7h4zq1FG5ysV4DGgRkWTWzCSgf+GtzCO2w8rUH6dZbXz?=
 =?us-ascii?Q?us9+rv6UdBkKRH49gXvp9ddeQSTTD7BoGS87z9C7PEFr7XJJmlG+DcnNOOVn?=
 =?us-ascii?Q?L4nJx21gVWDsmZwLYzuwl9AAPPEXesaBYgtPPvYZFd5zDAmUkYTL71GR53gB?=
 =?us-ascii?Q?fVXCOY/KbnQQYaQ190GJuyfuN7cJTGAVo0Z6piez41UKupdY94+LGuNj9Ev7?=
 =?us-ascii?Q?E4cEwFRjlIK9i0UQ5tu/R79JlSFxG3CIQfPNBzv0RaJyMksi2W6UIAGuz/ii?=
 =?us-ascii?Q?DYKTIQEVxseNz6Kz7Jh7cJXBYBWCZYY1yNh4xf7WOi4m/f6leqGAqP7SDJZL?=
 =?us-ascii?Q?5q69SDVsb3mmz3TjJxHjzh2ySKJKLz8GrxrEQGvygjqpmrRc9GDkvLIAIPS2?=
 =?us-ascii?Q?A5mYY0CfRI6TsdBBOuKzMUoNiR8bzuVdiqF+Ldkhr8SC2xggKPKFZo56vkvr?=
 =?us-ascii?Q?0mPAPu1ssxeuavsi/T8pnuzaUX0NbNTbr0/pRe8oouBdwaSIpmUy9FtbTc4L?=
 =?us-ascii?Q?kZ2xPkTPclENk/vEH5Xe/BmH7xKPr8+/3NUb3+TbCYxUzB7dutIQs5Vx44EK?=
 =?us-ascii?Q?Ud4PT+yjRrTW0FtJSyWr71PbjeercOmH15+OKAAvJlLViLXBDbRVvQH+u9Y?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 274407d8-52e2-4903-93c1-08dda535f2ec
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:08:48.6167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8841

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

