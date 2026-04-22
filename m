Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012070.outbound.protection.outlook.com [52.103.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1EE3D330A
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860395; cv=fail; b=VnQ1pFZFQe2WQt6PyiHFgEJvaxEc5r40/XuSKkVZkx7E6dEoVUveXsdJU4M/qbczSkKn3j2dkslBsMrcl89k2t0C5DIQ02/L8Fj3gKu1/bFqo2bnZXvHPFj5PEIgybXu3en1YZe8JK8P2dYIR7TcGGCNHnQQUwPGhaZYEUK97Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860395; c=relaxed/simple;
	bh=yX0iamSVjQYKzzNEpghViuT/KmJec0rCvKKV/mdrc24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tfayq+4HqSUrLk7EcmS1sYUW5M3WG77Mijpv9jquyv53gkgSjwYIPK+DUEx718cFkBqKduPgYCxJ7aop0EHbCjd3My8Sgf8cvU7PIWvvIGb8ZrCltxDU5/VOPt13XhFPmXWPjFu9PDaLNjrGzA/LDAF6rApZjYDUcvoVUust9qQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l3z+Tjfe; arc=fail smtp.client-ip=52.103.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l3z+Tjfe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLJ2Xc6tThfN8KYQQkOUSxf2z48Ei1NxaB4dGA8O1wB7GUHa89ImpD8qS0yImgC0gTiB8u6gB4LJ/GLAYseJ6VtPW1xMr/keg738QATiRcJPsu14NF7jCTFcNaUdozPSWJUji3UlfJQsjCT6YrBDhJL1AZukp1Rbs0Yl6cHb8qUww+faMkxX7XFHinvzYDCOjJ2nm3yQFkbW5OwVYBvk3bjzDJCXiAgFJP1LUgF/JD7e6XrsUTFCrOIfENol4fLRnDp0YqqjL5m7IDsxPK87AahYm6Brn6I7mkCOtqp+fS6H/wmfFn7oNy7xxnjxk3gRFAAGhWw855FY/zPQEHLKHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ic9puG1SO8T5NHgmaDTT8NBC440xZa9hcIufoklz9t0=;
 b=NqVS3VsY1xHmPHkeJZl/lO48wr5H5DcIOttfIm4gu0uN/9fz8nf768uWK84IDO+SV8Gz9uMHEgB0ZTpLdPTLM7gb44QPK9pLchyPIl+0/8MXVtnlxZFqUsQDe8EO3Bva4Ji+pngeRhlKN7dWMOggid9OTvyLpnh/XOH6DqfbQSzFfqpQE79DMuf15/mitTmEfErbQA1ZHevNyQvwPhdblKvzE2zuMSiZ4hHJEpFALXE1Xcfj4hcX8IAHnfBXvbJw76vrf2rWre253ie+JBk2JnorkMtTOEn9igHn/Hw0xA+IZjOmjT8hbyOWWBhKi0+qDOo7/L4O3zzuwyDkBg12Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ic9puG1SO8T5NHgmaDTT8NBC440xZa9hcIufoklz9t0=;
 b=l3z+Tjfeq29XTdUab5HfjvsI5vCYcdc4zCE0UHJ0jPQ0bvWiSBBWJv20MtiTZbdUs5AQ9Gv8bfUcC0pStr+FEeQOGIbiIffLQK/HoL7lIqL98DeCoMRazwmeKnd9x7u8d92TO3gnnMj/0CzxLAGogOYF38/DB51uXK/YH5TszvLZjzwXP/1ae+u6mRnmQT625/xDOhxTqqO1KoRjjEAgQMm5Il2qcAWard3luCQKrDt/lx/h1+RdvM9Ce7blQu1IMo6w8EO/+7DdhlAss+HOvcVLxsW30eXilZVyMRmD7W5ww/pTfDaP3CsBXdRn0Zz47MQLVpPM19CTlXScsCUKqg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0530.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 12:19:50 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 12:19:50 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: aplattner@nvidia.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v5 03/10] help: move tty check for autocorrection to autocorrect.c
Date: Wed, 22 Apr 2026 21:18:03 +0900
Message-ID:
 <SY0P300MB0801D0D27D3304F6D0CE2425CE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260422121810.307862-4-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY0P300MB0530:EE_
X-MS-Office365-Filtering-Correlation-Id: 70a4b5c7-a111-46d8-0a03-08dea0697352
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|5072599009|15080799012|23021999003|12121999013|461199028|8060799015|19110799012|51005399006|55001999006|41001999006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ER08jOSs2M5qvEqHbJXZNutZ5iu0I6XfQeZq4GgwKtkgCwo2RuP6vaMytKHk?=
 =?us-ascii?Q?BIgWaQINk9yX1NY/EQlI3whA8TDr8nyUFOtcLugQH4VqpP20FIxfJvwfCy8A?=
 =?us-ascii?Q?ey7+mAhPQFWwQhpMhW91ktIsNVs96vd5MRSou4gqf7Usl1QFa1GJ89heGSWa?=
 =?us-ascii?Q?ihJzEOvlCajcjMZ9+Ga/SI1y2u5eB3uON6vyYqTZO9r+n0tPSyz/h3vQQo8W?=
 =?us-ascii?Q?9K3orDeuuf6qTsEHfvo2Uji2hjb9XulC7oyvdY98dgcsgrgMtPYC7MYn27qU?=
 =?us-ascii?Q?I2TCbxuRZ/GQ9QNjvrxmhFPQmPSnDN6VuxRxgxpQoQ+hey2K4369Lj3WMG0X?=
 =?us-ascii?Q?7TBzHkx0Nq7vp71dIWh6WDcDytYHh128txkgA0l8FAAfXGbw+IK7NwcT2eEd?=
 =?us-ascii?Q?HKhUxifv45sRHRkbojH3qDr5/hQnFfPsmGQrF2oM54MYmirqfhCPWS23Hgrh?=
 =?us-ascii?Q?kvvDgsT6NsHh5mXKwbhoYy1ZGUZa9LJO5N1I9ibUOapQCNliLR14g6oTsyRz?=
 =?us-ascii?Q?3NWuZWD0A8Ii5/osxH8kpU88tu/JDrfI06pe07TFqInRhF/DWh4BA/OvBLj6?=
 =?us-ascii?Q?KqKZEDSziDrMKdeVZVkLSR0cS1yJEWeZ5cfxrqe2uWAiPikX3ifkDZ6hHVkt?=
 =?us-ascii?Q?peGaEuj8iwhE93XI6GiOJo0lYkd2kV5zQ5PvWBU9r0DgabAHnnDeTyOXvI1l?=
 =?us-ascii?Q?IzKWH4byPA59op4sm9qAp65MlcXfceXcb5P8Iq//qFODwB9IRURFpW+aV7Eg?=
 =?us-ascii?Q?8QScA4zKHvMLy6X8hW2umhn5nlNyo+FlI1FPRlPqtkf3TSsetrFYxob1G8EY?=
 =?us-ascii?Q?BbbaHlcUQUKoZls1mqGDWBlhrxc9bgiTLPbUoYMq52PasGyqnksf35r4B80w?=
 =?us-ascii?Q?nVV/ahtb3xoEgkUnHfbYuf9jZRXPh80NYOC3SaELFQWuFjPPVPoSHM5nqdVm?=
 =?us-ascii?Q?Pl0SaUKTF6sheslaAlrfGuwMyqZxkCDZNtAgKvl78KJTwh40y+BpnV6wuVsN?=
 =?us-ascii?Q?YrNQduP/Ob3FOPejTfXnpDe/NiMw0Oji8cko9mQjAPzfq+FVtDjn0DvAhpFJ?=
 =?us-ascii?Q?A6ZBX9zy?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6TWsg1tjqmHnPIZ22r0Pguapx2ZR2i1BqfHomw9BO1OYjGJrmD+RT+iG50ij?=
 =?us-ascii?Q?kb5QG6V6BknUpAJz5K9p9cmQGZyXutwXckTJ7R6Hc7Nn1iIlrjI+yntnDEYx?=
 =?us-ascii?Q?uDLYzzwQKh9DGQy6XINGjL9+LUHtxndggFzFRnb6Nep+BgE8bXsr2zde5tfS?=
 =?us-ascii?Q?q119i5jtXwPkTGRrAkw4y05aDowXpUC29/pMp+s6SbLVQ5h2hEu+ep5MsyHP?=
 =?us-ascii?Q?owD77nl9R8ADkQ6GLS2AquIdzEVl7YLuYM9XAlbeqiOG/5ZaZbRKgzw2ewFW?=
 =?us-ascii?Q?hNA5TnjHIdTmyW/k32fPmGjxp8Vs7YAarFJVCagD4vxw5jnXZ7RqMNlqdGs4?=
 =?us-ascii?Q?sp1fi9m4fCwhsSeowoU+Kv8pDLUH/KDpj8g/1+NgxvbrtX8GuKtWhwrwdUK+?=
 =?us-ascii?Q?orrRpEjc/p0cQbmj8BZa/GVnK7J6x/1FpGzZ06LkxwauaxG32sCNLeHC1A4A?=
 =?us-ascii?Q?LIpfppQgn46j19wg4nCCYp64GuG7YazGgFkKr3kkiSdsvJU3SEWuJvgNTDtC?=
 =?us-ascii?Q?IoQo0SMiIJfCRhqGUpIa8LTbf18PLpmuxS50wKcEXLpmMP765yjTdrh3ZIIW?=
 =?us-ascii?Q?4Gdyi5CtP1zJofsXlfX6K1nG2+v20p3h5EZ7VYcvB2A2BRsFjJb4XB81lfPY?=
 =?us-ascii?Q?j7v4RIzsxUBoZxNzyKxRvTW6x3PkUY6QkUw6a3H1r0e09yVCRcIevfE1iFwc?=
 =?us-ascii?Q?j16FA+BIoqjqNh70Whvm07OeMiDaBRa8bBYDDAGVeawM+fCgIjd2ZeJGdbzr?=
 =?us-ascii?Q?GaAFJQ9CAXD0r09cBNcNMEAWYwK+YlZTph1zGPBEeZlzhDo7SIyYow4yH1vc?=
 =?us-ascii?Q?QshwSX0SWMkbqavJM1Vgn4qeiwcOaZFt3aroG7y3Au7663vQPSmOhbMNedCp?=
 =?us-ascii?Q?IQHV/oRbUztE/g3rHYHNdtOoivS+6ZXNYchvyvfWqo04vorOZAzhPSag1ZrI?=
 =?us-ascii?Q?K8Id4WTil+0MI/zqucuoqJZg5dEEp7D328fezhvLEqtQ2uycW88Mr+aBrvM+?=
 =?us-ascii?Q?oPTIubDAlrQ94x5hihTCI239Nu3thXiuinPm3FnBY6Xcg9MWoAr5eqID2idf?=
 =?us-ascii?Q?P9P3t0/NuYT7e/6uv/ocFYUne+TeHWnjEvH3qkw9btPEyyfjKr1SGoT224ID?=
 =?us-ascii?Q?7wm38Wi820hTNEAxIBsk/PyoHHp+EP7dftFHLsyJI9cvJ62kKgBLWPWaTKcE?=
 =?us-ascii?Q?tkXaBAyTrezbk3Y/MXlF0aBqxvy3oCln1D9DjA599byDYiZQhKEeHlDt2nzn?=
 =?us-ascii?Q?ymJtCx5Jr6Soxwy5L1tHcLkFNE5zj+5GouUrClpDsjbxGVtJYK8fUI6V/DIt?=
 =?us-ascii?Q?xR1Lxz8JtS868YaJob5IJwveJOWJF2p/AiTt1CQ6gY0LlRseuupByo/ZA74R?=
 =?us-ascii?Q?pBr50JL8Ie43GAphfcbO9eHqwDRw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70a4b5c7-a111-46d8-0a03-08dea0697352
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:19:50.2932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0530

TTY checking is the autocorrect config parser's responsibility. It must
ensure the parsed value is correct and reliable. Thus, move the check to
autocorrect_resolve_config().

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.c | 24 ++++++++++++++++--------
 help.c        |  6 ------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/autocorrect.c b/autocorrect.c
index 97145d3a53ce..887d2396da44 100644
--- a/autocorrect.c
+++ b/autocorrect.c
@@ -33,18 +33,26 @@ void autocorrect_resolve_config(const char *var, const char *value,
 				const struct config_context *ctx, void *data)
 {
 	int *out = data;
+	int parsed;
 
-	if (!strcmp(var, "help.autocorrect")) {
-		int v = parse_autocorrect(value);
+	if (strcmp(var, "help.autocorrect"))
+		return;
 
-		if (!v) {
-			v = git_config_int(var, value, ctx->kvi);
-			if (v < 0 || v == 1)
-				v = AUTOCORRECT_IMMEDIATELY;
-		}
+	parsed = parse_autocorrect(value);
 
-		*out = v;
+	/*
+	 * Disable autocorrection prompt in a non-interactive session
+	 */
+	if (parsed == AUTOCORRECT_PROMPT && (!isatty(0) || !isatty(2)))
+		parsed = AUTOCORRECT_NEVER;
+
+	if (!parsed) {
+		parsed = git_config_int(var, value, ctx->kvi);
+		if (parsed < 0 || parsed == 1)
+			parsed = AUTOCORRECT_IMMEDIATELY;
 	}
+
+	*out = parsed;
 }
 
 void autocorrect_confirm(int autocorrect, const char *assumed)
diff --git a/help.c b/help.c
index ab619ed43c7a..d2b29715817e 100644
--- a/help.c
+++ b/help.c
@@ -607,12 +607,6 @@ char *help_unknown_cmd(const char *cmd)
 
 	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
 
-	/*
-	 * Disable autocorrection prompt in a non-interactive session
-	 */
-	if ((cfg.autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
-		cfg.autocorrect = AUTOCORRECT_NEVER;
-
 	if (cfg.autocorrect == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);
-- 
2.53.0

