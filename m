Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5718B47C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862033; cv=fail; b=koG+AUE11aKK7KHqnIO41MKfp/+vCzz0pLRt2e1A2RrhKpE5xiq8xE8NlFcNXrSsvssGZ8PWCMWMLV7u3RGRJnXsE76YSrKsNRx09NrIuVgMAaFrH/u2BGyy4lh7d/mqQHcotNNbNuGpakuO8gvnPh57dKe+lRJIeGC+JgPVG2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862033; c=relaxed/simple;
	bh=PeI8sqy/4TGBGWFg8MrWP7RdbQgWRCtwcMicKPnSGWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=musVz2a+PyrfvVj4jL6nTQsUb0rVQk8eihn3SfNxkYgf5U5aedXqLHv5nVz366TjoDRSF0FVKmoqBGOw9OoO8mqFzy7he//ouUUyKJlt4GboZFOBtLgOTeOOpjKJKG4dsWEgrehDYrv3PZm3ugSY13nLfOPKmfjgNof853PW3CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=fBMO1jm7; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="fBMO1jm7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q9U91itmir8IOUCV5Bc87zTcnuCNYI7mw4bYuloFckk3b90yJ/DvWJmNAI4vfqGxI7OyZdW9kEiVTfuQ6NZsv4nP5ICn/zCoHh1r8XR2TUnu+2Iw7BaP9YNoJnNmfmYKgD+a9+qa6/yvYGwEktkbKYnZPB3NYo084NTmsbBsRN+NSG5psT0zjlrHVfDp5iejEHpI37SnWv0dB38IjnsNxU3bawd+skixMizd2WEmlBNXktrABHT7bRM62JEnsJ8VaLPUImSbIYa2mUTn4J20wjNWS7JYBjBDmxFvzumKcx6aj62eo+cdnAurggTbxb/9IEz2L8WsqH43OhBd7rRlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VF72bEpqaCV4PpW5jJZ6rCyDyWs2QlRQNRSi8UzShU=;
 b=xU394esW+97BGIh+FI/+i2/dE+vNeecOg+KSTKFySTR56nnY8oHd9rDLeAqNjdHr+I0VhWOuwyhQmfZTnl9FCgmQFrLNkiWM7NsSIGdZkQx3UA7DBpWFMc5tAkk1OhrSPPyYaU/oJy8UwND2x5GVUqR/ydxz8Fpe7ca2macA9RyDSt6o37u9w664UEyGYkE8R9dIoD5J8zUokMd/E7QarsQznnZs+W6ab9/Fa75rOxXRXrLlTACZVDnOe5uQORP1QoRT7Z/Dg48032vqU6VyTNWTN6KtTGZpH8/OtzGPT4ZXVqRgW4z/DMA70OefoEtE7a3jcRvW+Dwfzw9vmDRcaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VF72bEpqaCV4PpW5jJZ6rCyDyWs2QlRQNRSi8UzShU=;
 b=fBMO1jm7RnO2/r0vHy8kwM/Xin2kibnAFqmZ4fCWXGVBnXQ9Mr1fmW/sHCa3KiQIVqhsf1fG7sBtvtGxVL8+peaRXtA4602q668angEomsusw3a4K3iNvI/ZCgjQYwmCnIPutox/c9VgoS2xowINZlF5HV7N4ogpeRYh3Q4rnahruAsWczMypX5e/Xol7ZM0TeFpPVhA6UoNA4DenEPto+WIdO3x+3vVQyEDor6E/ulm34HUgs3TC80Hlp+ZCYfnajeYfK0v8sqc6cNwaacw/QK3ygveKlwC9cN0N7yCmAqh1aadmNdqwoFXTAIHyawtNLiJwPTcoOYzsCsL85lnoA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB8176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:00:25 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 11:00:24 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v12 01/10] imap-send: fix bug causing cfg->folder being set to NULL
Date: Mon,  2 Jun 2025 16:29:32 +0530
Message-ID:
 <PN3PR01MB9597A278677355CC3D65443AB862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g36d50d01f0.dirty
In-Reply-To: <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250602105940.75439-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 38dbc941-ff31-4c50-27bf-08dda1c4ad04
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrN1Uple1Eat7kdR7nOrSpOl56s90kmQUjDu4ZuppS+PIFMBp3K/I1M89DDlf8hCngZ3S1g4g4T1c8EaLnep4Gxn1Is13VBN3sAqqlyjJ+ImGCHpLTcA2MKkJPEUO5QsYZsM/UlDYLbEI7zBtjYkhgWV2Fdos6ZROnxRleytVRK24J6AU4ywJxWqdeOzcJRULwYLFXS7gZBSamrdGe/PmHXHp+yYheMX3/qNu+2AGaHS09Fug/Rj3I93mTB9+XB7obysHr2wzYJMgDGsvlxDCOF4XPvJlpllstRdU8PQDZkXPWxP1byuVl9avusUV63Zgx0M2tMJG80qNBN4XJTBLJMy19eJioJlOoNxeICGJpvkq/S1xsegaqrjdEwvmGqE2cxk3PY6NLCVi9FUppCdDKH4LxAPC0vb9T/C3I1YZurICv7yvn7Ojqavc0CjHP8d9YpETMZ/lUhYQ6v3pz6injxInARXtnEAkc8b8svuimX2LG9IFWxQ5S2FaEQO3Do6iDJLcPzc8qkwClAC2JHtFJRj6kqhXb4pUEBLHSTe6rVzCGnepkpQsr4dM/fsh/MQYFKn8kYmr4FYWdxbTkf9UQm9Tzv57awSzvD8Bi2+sAEb03WGuFdg5/Ezs6jqNPGrWrl51BCgwAwHSUeti5WV0wLqJvgcYmdLYsnoxms6ILnz7/SA7WzYFQDfghAv0B2rD+bnJZ/qWzyoZ1Arj+M4TNSgibONG2KEwzHihaye7wrq1lG2rnc+8wbnY7ir3UOqrmA=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|7092599006|8060799009|15080799009|19110799006|5072599009|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UYa4X14G2LNBkzoo545F42X/+7WuighdceAu5FwwNBZm7jybiZMnN0lgcaWt?=
 =?us-ascii?Q?vklpYgQhQlo/eDMawKLWy+w3SjUTscaioTRP9d4aYMtOP9ikqy7RvppSkeTV?=
 =?us-ascii?Q?uItPtUxYdJKJ5KvKBz5KYUCeV7vdpz+pMOFqYjALgIMRtZ4fsp0boeTzZOuM?=
 =?us-ascii?Q?W4tFdaQok6FT1ddjEi72d/4sLs0HZiyMr/iAq8mUQsTBqdFb5X9YYGWx5AO3?=
 =?us-ascii?Q?xJGJeE0ag+uyb+D464pdMWOndkIirpBBsZsE1Na0ypqnUQQ1AnGgtNcEVfzC?=
 =?us-ascii?Q?LjKmgkjJwqg/+bhZrS6/Q1KoMx1k7ArMBV4Vqw1PdgPnDFp1AltspSJeWRrr?=
 =?us-ascii?Q?Q3zxz+PWL0ruoDbA59blR7+Q4Y6e1xAOD4bc8vsn5KXKfngP6ffXxvjS+uzp?=
 =?us-ascii?Q?aa0kstXXf6X8U5tvQiQUbbWxQKt4EAn5sO//djP1aik3tBML03fKaFcGnixX?=
 =?us-ascii?Q?zFhlHdFNJ2a5J8UFrtvELqqRKB3ktTMiHu3n+KB9NjnMm7IPENTuLGRET3c1?=
 =?us-ascii?Q?ZgSSTGorykBptFbzPK9PsBTASzUkRXlkj2biAUvUnnQukFOKRfFW8YKDyocU?=
 =?us-ascii?Q?D35uPSwQPdVA7t5nNf9G+VadpHyYJasxScQrm2HSS6jvhp6DrgrWZt+Cg4Nl?=
 =?us-ascii?Q?bW430YLbuBXOuZyaJkXiMLsAdJ8LhiheXXDrSzGwJCUBBsO9tpISwQRVLeiu?=
 =?us-ascii?Q?I6qg77W/Seuqh8pcjAALi+2ufpmq0zDLGdmy2y4bhwL/ytKDDF4KlsKncgCO?=
 =?us-ascii?Q?IP6shB7UCZZP0ueNhmQBM2JisKTHE42NiQH5NzI5yQ6R+f+kt9OknxfOQSZ5?=
 =?us-ascii?Q?tLg7Bc1N9TXeluiVeCCaw6q12xVBeXEiI9grTYWA3Y+cq278YifmPlpHEJ3f?=
 =?us-ascii?Q?MafbSgPghobBQTySBNU3ZNGMGjncBGdma2LYahIW+x0a47Dx3VT4h/66aaJb?=
 =?us-ascii?Q?AgmF1m9BT7OvuVcGaGwiTzyuE0Fm+aXnz8LH9l3hEKFhrzB6CdzaDdcdfX7l?=
 =?us-ascii?Q?c+Xt6cKrvPEAXJyImHjjctq44pldFyIgztDkyW/yWuJ4/H+q3jvDaVxbiont?=
 =?us-ascii?Q?C6NlV20uIiWrOo6eh+9MqMRive3lTa03P5G/fzZBmWmqaKz6HiD2YdIX8mEz?=
 =?us-ascii?Q?22xN/syhunufktG3CiMR8aMAOKiLNZOUtvOXQFLb4/e8wDn4sjZWIxI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A3tvj7z7+ERHjQnsXwlj5fNEnLT/MwjWmWYm7QTpsd5XfQUqcXCx4W9VWUaS?=
 =?us-ascii?Q?dadXw53Ia9MN/420qFBPi3lFP1WPzZy6xccCWhaDzbThZNlCJRk8hCkEpLvQ?=
 =?us-ascii?Q?LxPMxtnlH9LKYpIsYiS1RdSa4dRrVsDLcUoJ5XRM/rpOmxEy6ob+slxE3/aF?=
 =?us-ascii?Q?jQJ5MjymerGocjBkIv4RFtQYp9X04C7tB0mxV1/GhUPvT44R7nPpp2HmeE2S?=
 =?us-ascii?Q?G7ShDy8UCh+noNrMCTJW8K4F4+VzpQxd/ZqGwJPh+2Aqx8T1sUsvcYspk6Qn?=
 =?us-ascii?Q?wnS/62cvakOf3EldKK6RkXwxeEmYJzPfnkX36/9YlICMoCqeZ0HoLMVh0/bu?=
 =?us-ascii?Q?yA9jvf8+qhKmGWvHyvGv14kLG+a4dllW0dlksLiyqlT7bu0/iP9u6SHi0Ovo?=
 =?us-ascii?Q?9HDWrm1tpbARt2hbF3aG8N9Nx3NElPPAXiMG7y7Jvq/lXJZ/qPemxvkILPPI?=
 =?us-ascii?Q?4n3xWYQdNpNyoNjZDVq6WadLMInxuKIHfOQJGf/T+3K4Me2KwmoIMaZnl9cX?=
 =?us-ascii?Q?QT6+1FcJtXklkfef9DwKCNWCFDwXC8mduGMjD1tIKtg8M3Dp/lxM7KzFYIwR?=
 =?us-ascii?Q?YPocDrxgdV6f/7QfG4W7xT1qEnBJTOgCr9/iWSF7u97DTxpormFpw9au2cMD?=
 =?us-ascii?Q?yqXA9TvmiL+cfGZYnBZGO7Q46U+CvSV/JLS5yota5J2QieCKisDRDDL/dpD9?=
 =?us-ascii?Q?0m18egH4nLXmEewqDiCdapzTuprdy1exS0OsoWuMRJqcm6xGqWD8iR4Iv1ci?=
 =?us-ascii?Q?9VslSPU0W8vj4rLyAwoRL2s6RVx+R+mN+LgqHKMm9AD/1TFLLK5ZvYw9SO76?=
 =?us-ascii?Q?Kif7vDGJen4aY7h5HUJHvcjBuycgNefWJMNeHdX24OivWZwekLupuVIG4quP?=
 =?us-ascii?Q?DFfgDs8NJOTI5CTqn0CjXLbNNtIyB/LQRbKnyxMLGRr9zx9XIicExBealp75?=
 =?us-ascii?Q?ObWr38Trs+WmX8Ihz7hOcZwera90WpGcoAcDAMF32yO6mRjJNSsyF0jivTaW?=
 =?us-ascii?Q?pX8OE6i8j0+33p0vu9ELWT1v3a/oAxUvjAbDX1q4Xqtspyw3W3uwWxF1xqbb?=
 =?us-ascii?Q?Dvv4Ag836ZA0qObMXFCgYLnI+yfYIov9K05qZoB5qpL+W72W/uDb0O1DoAED?=
 =?us-ascii?Q?4KtkDpRRVEmK9hNxZzzKYe4XWfEZzfmt2OEQKJ6a+mv3HQ4bBDfSfGqZOfpL?=
 =?us-ascii?Q?MThRtL9pZ9tdv2rTcLsOl/rbEkGc5TCVso3SWarSwfjs2nHbdRM7npi7c1lM?=
 =?us-ascii?Q?1h6O3DAsXlzFSQ1D9LUfhE3guYCtr7wMd7G7RKmAiy8Rf9WxPUCZh1hYgCcz?=
 =?us-ascii?Q?oOQ82n+qkScHH7Aq4Xhn+07J?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 38dbc941-ff31-4c50-27bf-08dda1c4ad04
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:00:24.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8176

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
2.49.0.639.g36d50d01f0

