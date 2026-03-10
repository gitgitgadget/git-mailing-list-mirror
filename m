Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010001.outbound.protection.outlook.com [52.103.73.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CF3381AF8
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142890; cv=fail; b=jMGtgYe1+7T3bed8qZNJWtzAKfp90ZGHhXJiaJkpdE2isTCAFAldCY+uvLzun/9ExYzzKF517g941D2cSAQtXdfyrnwgJwr1lqWkQoxcbDVHs3i8WU3aK64uTP+dOXkoY8mpwBRa+C8LeHbMlr9z0xhp2DEmVPpIZJnq9CPd1bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142890; c=relaxed/simple;
	bh=C+EDkFwIabeuV3ZyOiUYPNnhfw64KBPV5JKPxmhOulw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lmrT8Us/nqnN2bXLRzW6BXViGJOlk0hAxUmJqtmxqQeI6xx0TSi4Y17X0R36VYVIVJfRsFEojjX0u5jS/iXqXYp97TpeXj5QUNQQKxJvsh4iqfenB/pbF/vvBSENBM5AciwTwY4CM7zvmVaWmirtM0xvZWJ20VkkEu7Sl2mhZnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IXxicYHc; arc=fail smtp.client-ip=52.103.73.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IXxicYHc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZJz1L7Q2VK1pjN7SCImvEuNP+ESrwvXRfTg8cMrsb8DEuf3l0ZWxNp+Eucg7Rpvl4wxZCyPF+Ni7JPD9VqP0wTxtHBWIn25rYyhDJnBZHFQ5VLbpKNuQAKhLzZ29N4YyS4gJRf6MMZ50GCiV+gDqHgLE1x5w1Gd008dKr6fhP1wwt9qo6Ms8qwnDGNNKUzmoKDLj1xe2Shwk9bQN+FtA78rBWx2yh0bRXwiD+HhG623wCX1dpZLmbQV1NwdOW6OztgfzUPF/I3Sodozf/aZuAXdL/35N9Dz1+LPBf2WzEg5Wn36hXJsCFLQnoPs0koHxd/yzGLw7+21GXiVe4Ccbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABW43ippraSr2hoSH4iTHAwqIX6Kw9BnC0sIUEIZBkk=;
 b=Xdn+3inkzUF3mi6ZATkaIifFQjnUAnP2iizZKQrHHkiM5lDhM0Tt0TYWCPZrEDrErpFHxZGfkJI5yTxtAy1mpGDYfLfoh1ywn9E2zRvfst/tzhM/6kt3UxdvSh6/aVOVyojtssJMaK7bIH5lQ6eh9Yubhzl3qcxh77HJxxzhLrfUtY8N1/ZkYAqX7H+JkKpz4T6cHTFxqtA71lZKwB0e1kKwTAQunG04sECaEP8KULj1QuzQUpQA8fDNzsOp7Zdfa1NKvGtOaYfE4xiNS+qEX+9uVNtE18hGu0ZZsk79aPcj0Y/LyuzGdNL/LZ3BigSVdawM6aV/SIPcDbN25FfCwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABW43ippraSr2hoSH4iTHAwqIX6Kw9BnC0sIUEIZBkk=;
 b=IXxicYHcBn76YSmTB7MWjGrIew6PAx9BoU4a704rkOEf/oAWroKOq3MHoT9UeKavD3IImXowribTezFsyXvkR+WPgTwmM4rY00Nq7o7QTiV1ay9ctFo0cpKey33HTEXpshjuKdHNY/iirqBNZOdLIeCymrVXpnKq2jFlnmuyq2BXe7+Ia4tWCY+N6dfBtUW8YrIXq18s9O/3nCP7X0wGwLFSl3clNbnczy6HkYg0NXeQiDK9RKc/81Gr47MsuhblSvIke3sCMzlD7NgsoFw40JE58UTvFlpdbb/xv02xnawLpFZ4M/Munk+pc29to5FSX9WBSri3nKqUvZYsWvmbMA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB1392.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:41:22 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 11:41:22 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v3 4/8] autocorrect: rename AUTOCORRECT_SHOW to AUTOCORRECT_HINTONLY
Date: Tue, 10 Mar 2026 20:41:03 +0900
Message-ID:
 <SY0P300MB080176719022D3D7C2C5D70FCE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260310114107.1086103-5-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY7P300MB1392:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f518c1f-23c5-4ed5-211a-08de7e99f3d9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|51005399006|19110799012|8060799015|41001999006|25031999004|23021999003|15080799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EcwyBc2c0jTA9GZTEc7kAawZHnRJyGDpVcLvLjghItNbf8zohYkPpgVzsQXs?=
 =?us-ascii?Q?0R89lZTtTz1UqzGE1Iu6OOaOuruWZg7BPgLR+ZOHZeH/mOeNnQI4gihVS2zw?=
 =?us-ascii?Q?nPqN9XzngO+P4QTsDcc0SPW/FLk9LvS2cnBmvV6jHLcIVZGLQJoLKBlWL9wa?=
 =?us-ascii?Q?X+85Irtw4NZhKoPr9YRReeA8TEkrAadIwsEHw16INFX8/cbze8VeusMDEuCs?=
 =?us-ascii?Q?ySAK1e5UEnYX9XHTjK5V6dKVcJqWGD3n/3kQROQID/0yPsr9Pfag+iQPkjj6?=
 =?us-ascii?Q?9T3oX9EimbG0guhVNYtqAv5uMalcwXPfnjNNjnvd8v1YW5VICOs1YmXHIn/8?=
 =?us-ascii?Q?sZ/bCv6ZISm4NN4Kck2wN2niwnWu1ZAltjlOl5B+fVzjE2CYWVThRD9rS5+Z?=
 =?us-ascii?Q?kVIq5Hoic5CWyVH0/Gz7uJIVEETkz/DAlS2IcuMrrvTz8v7saMNaBdjPobgs?=
 =?us-ascii?Q?UFRLFojbQTFt+iNE9WsXdOmaCXUMXW5mSgmxALO9KlK/vv79fbpah9gquWoJ?=
 =?us-ascii?Q?tCdMi0bM21/RQ5UQKxj1avYDuRcZowR0gUjfoBU19YoNNWmbYK//OxLK/Gn3?=
 =?us-ascii?Q?RD2my49B8QyfirDp5CBD97ZPohyCNrgY808r9YJzyzMKhQjGD9NLmWs1KSmV?=
 =?us-ascii?Q?lo9qz29Kt0+JeKPkfydeH1Clyv2Y77R82pwTLU940v7Z5Jqh1FUkYcyfSxDt?=
 =?us-ascii?Q?seL+zAlCmrhaDxBphTw2IjnWLQZZkrwhuT2jNjSTQg4YKsQhhtpRZnGcNnfK?=
 =?us-ascii?Q?O62nVtdSCPLeaga5IrjShNzLb9bNvB21yEtC6H3SlsnXDbjAnO7y5ePSBNhc?=
 =?us-ascii?Q?JPdxLR/RnjCEd6+lyykIcr0g7nOC2V1RTxQpPegwcQFgUA9QcrQe66/TBxWS?=
 =?us-ascii?Q?FUOWpgYfIX67aSU3skG1CB20fSJHg006Orf8VgDKjhhSAZclreC/DwQX8GR7?=
 =?us-ascii?Q?mp2phWq+HHQSyAUP7cGaauwcazTi//fOaPVnNB5fB+j2MYuhjxw+lTcrzQ63?=
 =?us-ascii?Q?sC/d?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iItJo//V+OmC8sPyD4ztBC1FoAwjXYLbC1F4TV3kunxlhdPhHybvjfSPERD3?=
 =?us-ascii?Q?Y03tLCCobfZZu7yTQK7bIawytCKd9RjFOh+l2WEIFJe9P1cRHOV810ybIgkp?=
 =?us-ascii?Q?+B9+1M3rOZsKc4nCqMC2Ro9sW2tTprWZNUKpHExj/0Mo3bxu3UBUFCjyWVLL?=
 =?us-ascii?Q?BmzMSBvNJzbJvo7PFUx5xvFSdRrDMAs63tnUj/SAVix9nzD4lNRIxMR6znt3?=
 =?us-ascii?Q?O0iVzbcxcU+zBuNfxUKh57m6Gj0iZsr7mHmLlv8L4jkOGUIm1gp6HZCLuWGd?=
 =?us-ascii?Q?yB2l8xMWXET9IOa1xy4apP3RpqidkiYY/rB2eAFyRfI9IMwkm9otT2DN2rMJ?=
 =?us-ascii?Q?qbfHi6w62Ws+mqbQyF9dcV92g5tqtTkE6CxWaHR72R2UDoYV4PU1WAa2Helb?=
 =?us-ascii?Q?TnSA3Rpepql7mxHLqW0PAHHxs7DzLKQNLYNkHeTyVYIMmqtIULJG7ND/p8xW?=
 =?us-ascii?Q?tUnlN2CIDdpMWxO+ig0fRuTKGcWqV8WMyhE/5BVtAqptI/N5agKz5CCUzQAW?=
 =?us-ascii?Q?CurJ61pGH1AxPJYwXr+onYn6Nrvk+iSRPX82AZyu4IwZw6ZuxU/uZy+niGMn?=
 =?us-ascii?Q?x4/R0o6skeAnqOxMtYuU/tE3ascIfoR4c5d8xB/Z+RYMa7igfJwZKRoSjMZT?=
 =?us-ascii?Q?E5oc1XwiaHr9PelUkqghWa7vktq59DirV8knvtUcnmxnQNdFqjt8Q6p9m9Dh?=
 =?us-ascii?Q?dXZmkBhK+IBpg+BLVltXaA9sw/bVzQFgbKh1YHiYTocoydRL6d4Rbi7ZKJsN?=
 =?us-ascii?Q?pKfRJWuDStnwM2hwUDbSB+WyER2F7M/qihgB4ef5wEBIzNui/pq8SgbPhrcR?=
 =?us-ascii?Q?zyMWQMkJCzFxLSIYEJS7BIZabO6LkYdNyHI4KGBvV5Aqz0HmhFeP7bt+uzz7?=
 =?us-ascii?Q?nkXdIlsqYaBpdOWtgUZS+Zk/GYh/6mFH2DOls/QiSK21udTdzGKclVuAAeEH?=
 =?us-ascii?Q?m33/1QCUmku6ii8sMQVmUbbscCCCOB0yD08wzqRUrIACcKdzsLFwzAaY1uN5?=
 =?us-ascii?Q?gIG2WLzPH+JaqpAvKecGN9TMJrsj0Nv4I6xiyjETfSWNV1rq6VHQSzPwop6p?=
 =?us-ascii?Q?0kWHFS4M4e+xPMLFbRVaFzQcUzGOhdEeIrozogPuIdhMSJ9onQTZPPyFdFOp?=
 =?us-ascii?Q?oLF6tWxHsd24s9kayk7hgxk9S0bLRKVkQXVR+AZyJyp2utsaT2tWF7PVv84H?=
 =?us-ascii?Q?fa6msaAuL+s8brnfaFBQ+y75slM8+mrFgI40asD9618YNnZwgzf4q0M5YgvF?=
 =?us-ascii?Q?fG2v2w6DyAs4NmhaRINj029uRT85kohigDkfyH/3jOsEtjkvEQBY3zYcAvou?=
 =?us-ascii?Q?BzHyiVybrK9t/e2okLFIraoGStfbgw+PyMBYcTZOOHkp3gSJ7DFTuUK4o/zF?=
 =?us-ascii?Q?HGmgc7vacdaaI77x6IhGIE/Sx/yU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f518c1f-23c5-4ed5-211a-08de7e99f3d9
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:41:22.2033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1392

AUTOCORRECT_SHOW is ambiguous. Its purpose is to show commands similar
to the unknown one and take no other action. Rename it to fit the
semantics.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.c | 6 +++---
 autocorrect.h | 2 +-
 help.c        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/autocorrect.c b/autocorrect.c
index 50d7f116d85d..9c4b691fb003 100644
--- a/autocorrect.c
+++ b/autocorrect.c
@@ -12,7 +12,7 @@ static enum autocorr_mode parse_autocorrect(const char *value)
 		case 1:
 			return AUTOCORRECT_IMMEDIATELY;
 		case 0:
-			return AUTOCORRECT_SHOW;
+			return AUTOCORRECT_HINTONLY;
 		default: /* other random text */
 			break;
 	}
@@ -24,7 +24,7 @@ static enum autocorr_mode parse_autocorrect(const char *value)
 	else if (!strcmp(value, "immediate"))
 		return AUTOCORRECT_IMMEDIATELY;
 	else if (!strcmp(value, "show"))
-		return AUTOCORRECT_SHOW;
+		return AUTOCORRECT_HINTONLY;
 	else
 		return AUTOCORRECT_DELAY;
 }
@@ -49,7 +49,7 @@ void autocorr_resolve_config(const char *var, const char *value,
 		conf->delay = git_config_int(var, value, ctx->kvi);
 
 		if (!conf->delay)
-			conf->mode = AUTOCORRECT_SHOW;
+			conf->mode = AUTOCORRECT_HINTONLY;
 		else if (conf->delay <= 1)
 			conf->mode = AUTOCORRECT_IMMEDIATELY;
 	}
diff --git a/autocorrect.h b/autocorrect.h
index ce4a68379f2f..be4e3e8b2043 100644
--- a/autocorrect.h
+++ b/autocorrect.h
@@ -4,7 +4,7 @@
 struct config_context;
 
 enum autocorr_mode {
-	AUTOCORRECT_SHOW,
+	AUTOCORRECT_HINTONLY,
 	AUTOCORRECT_NEVER,
 	AUTOCORRECT_PROMPT,
 	AUTOCORRECT_IMMEDIATELY,
diff --git a/help.c b/help.c
index 566d33299b9a..6158545e48a1 100644
--- a/help.c
+++ b/help.c
@@ -674,7 +674,7 @@ char *help_unknown_cmd(const char *cmd)
 			; /* still counting */
 	}
 
-	if (cfg.autocorr.mode != AUTOCORRECT_SHOW && n == 1 &&
+	if (cfg.autocorr.mode != AUTOCORRECT_HINTONLY && n == 1 &&
 	    SIMILAR_ENOUGH(best_similarity)) {
 		char *assumed = xstrdup(main_cmds.names[0]->name);
 
-- 
2.53.0

