Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C80A313552
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675405; cv=fail; b=T2mLgSc/saWTugsJdzSkwESTALll+I+mfhZILD09JQdT6/ppPpl9D8irl1D8Ihby17ajA7j6p/JnIbNkss6E0zkdDsf72pks117fJOF9UnP3+qM200wi5wA4GIGpdT+aRw6tApb+1ZQ1o0weldFeV+HlC5nfbq/SPxaWSIMZIQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675405; c=relaxed/simple;
	bh=lBfnCpl5t/m70XkVxSOmXw3hsG1isGfOFTCdy1LNZOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qa0bgEHpqwJeg14jPpt16lOUIi0zMnzyHPwf+9aqr6kr8uMZveSFwh9CesfZhCLTF+wf2SMCxAyawrvJG6BY0gpsparvQsKB1SiThyOqgxyzZrPG4msFYPRRwn1TqcrpobX4iWaZmdR5Lvk4+5NVKEcRLAcn7m2jQJ8usbgmD7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=N+bwvHe9; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="N+bwvHe9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PzGxOKNzTCgnKw1q08+ntUSXyj89o7qEFhqZxhsgoC9jv3wA4LMKKveaB7XPZPHPZAdPhw/8osuhOlJjK4axk4jCiTmxkEKDRTrwAJAN5Cs5Zorb6ynNnL8dWjK3mHZMg8j1BiWNi+MKsnG9NdsxO6YI7+cN3tiMUEbSeM1dPO2sbp5Xw69FDE5tIDmO6sqZYibAM0LcqsV9GLdhA5RUFTgegQDBzgNaJdDSOkwSSx6d8hrZl1bGqXHVQyRaXcDOF3h1zoFODHdS7wLDND3VgtLQMvUdVv8c+y/JyBd0WeSwWrOriQzj1mZ4p24Z4NK2ys7SzEAe/mYCgON+13lsjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZomT6BUNwzJcqm9yF8OGpTYgMnETFdr3qVaZ2iUIg0=;
 b=YLlfkoO/cBFw4sFeJB++L+kC3gGDkGdUseDEKJCqog0h4kkovxLQFMc2+zf9rsDkRHJMadeo3Uiv0kTbAXnREEN27OLaV4GKENN4mSmQNnfDACX+7Iv8eyW+l1JrP52UYT9gtV3n2yMA7KdcRgM2ACghUGRI/OHYtsuwVpHBu9HESeOjccIxRqciuNbxrne8YCl8n7dwvDzt6lsJfb6f2g2XKhzLHUuDgvS8FyvsojEaHkN5801o/1j2bwqBEDDnNcoqQO8D2UJGVEVP5WjaElB13PeuVeFX4/LHCLveqyNk6do6T+9PZ+Zc1QQVbldMdTFaRmcfVKjtaMv/peve9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZomT6BUNwzJcqm9yF8OGpTYgMnETFdr3qVaZ2iUIg0=;
 b=N+bwvHe9ySrlqKiNCBRv4py/TZdw7hzWohV0B3kcoPeW2ju3aekRYlPlgA5QqJq25w1mfJ7hTcyRwZp+8dsYa96zvLLPLUdlT/gPLAXjZrBh1hSsxiRatE7AT8LjPhP707itNyFx5YJJGV324iCTZOl6RtEbcm9SeZ/E2cC2zjPbOvXF0y8SHR+yzgdPFUGoZly7F/9XzkjkvhcSzMkVWNxM4YEb8DWYGgiChfQwTj42VVrwYv9TZuZai+peMoig0TBEFUYo8NlM6jOr4yX1Q5bESkLs5B+54oqiLIiOcIdnHCe3yg+DwumRb+VgR+wvn9De0trxNJIe9TEIV8t0+g==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0774.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:36:37 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:36:37 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Aaron Plattner <aplattner@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v4 03/10] help: move tty check for autocorrection to autocorrect.c
Date: Tue, 17 Mar 2026 00:36:16 +0900
Message-ID:
 <SY0P300MB0801450C65264D1ED270C50DCE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260316153623.569881-4-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0774:EE_
X-MS-Office365-Filtering-Correlation-Id: f7f7e03f-197e-4314-a586-08de8371cfcf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25031999004|19110799012|8060799015|41001999006|12121999013|23021999003|15080799012|5072599009|461199028|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OIS+YsQbM4gvgXes88+6NVTuvJnvcBc75J4g9MdkotCOiiYf1czov0hIi3gS?=
 =?us-ascii?Q?awx7tAsxbYz6OGjYPwhQU31s9Z0oxawlV+PzCeXDeOpR8tLjdVdQgQbu480y?=
 =?us-ascii?Q?g+zZUh38RdG1H/8U2oMNb2dLbqJ+txUrFF/k3Oiqt/urSKzU1PvBuhOvHsrA?=
 =?us-ascii?Q?4UWQ8yZUVyPTBfyI/JKzwVpNsXWQVMNlUAkfXrtSvbriJZawvvxqjO3MQiZm?=
 =?us-ascii?Q?e3NSQipqCwckCGiyJyBjt/kIV+TfvAOz8WqjxmHJSyxDEP0PhKL9V+CAupnT?=
 =?us-ascii?Q?rggW1oxHm5OY6Ar8pEvrjyue2gpfoh3zD7Gr24mdAdE7nHIA312LlnBXVBQo?=
 =?us-ascii?Q?AzUypPs5kmoQW/+UcvwE4I7ge4MP8nqRjcAUI+6mqTMstSqTU2sKru4ckiiZ?=
 =?us-ascii?Q?X+fIP5aJ+WZwKFyP2E73E6c/q/qDs5DfYmZvcQMGDrE9qQxq0Uh6aF8NdY0q?=
 =?us-ascii?Q?WxY3HUGpqE014/8Eh0etMyXw+wRG5Z7oFZ/sSPTiqyUJU8QIlJ/PH3ScCCW6?=
 =?us-ascii?Q?/WFwTZzWCiDNnul9TzkTa0zD2f4GCF+f8WXVKLH/Tz4hqNyTLMaPTiGy3Nss?=
 =?us-ascii?Q?Ps6M0umuk7g13sIhm0Gj6Nk58AjoNYtYqzchfCcrE7eEi8UXkl+W2xhn0H5w?=
 =?us-ascii?Q?J5ZAf6y5vHPQKgGg+FqZs3+osObP/l8wkV2O1uB78tNn/uUyFFI8uwRKGfDa?=
 =?us-ascii?Q?Cpfuit0WYtP61Y+U38bZfEUXDsg0NC0AxovaL3gCKA6bukIiVQkJVftdjLDW?=
 =?us-ascii?Q?stLwXU6FlZuO33sLdKjBupfNigO0eyrr0BqYme490In8x/w8hjCQr168ybId?=
 =?us-ascii?Q?gF5V7IgeNZ2Xah0hmjZUzOb2bJ6SIcLJ9hlKHY4ljSvRHeUt3Iv9UFLo2qVa?=
 =?us-ascii?Q?LGzaVPZXYrjj4LfAKHafwhaxIhIzWISKabmBgWlviitobdf95tGYT9TdTUXF?=
 =?us-ascii?Q?iotRyqLjtBAoUuJD5Wqn+pxChWWujQm6dU7dJemiHugGkrZXQda2Ldebua9v?=
 =?us-ascii?Q?NsGbD7cB6BM4q0qQUFk5l/vtsnb2OqWXM1QPI6lo75AAY78=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m8Fl3kTIQYxY5RwnyDx6Hbyv9mUXLQDOGJzpExR/9JUtkt7DFKGWR3MFoZCT?=
 =?us-ascii?Q?bG5k7HeHjDlfcoHyCHEtZGeuk0xbF9CCQollxH90fvXhgB6ctMP6QJXX8Gqu?=
 =?us-ascii?Q?FAnr8FY8b/qH32jcNEDvgXdG7pHoVe3k8L3TxP61hniUSTm50uUG6yjfNpLg?=
 =?us-ascii?Q?7NPtUHWMLuUYUe+4hwWrpDxj1/m0iA3p4lr3DKc9odDEfWDffS1pbSRPTE0K?=
 =?us-ascii?Q?u8AwMxT3C2TUGTItmxrGLPfNr48uIqJYggUSkDWrs88q8ByDIz33AtKmdG8W?=
 =?us-ascii?Q?8xEYG8Zk8u7XqUYeM9hZCPwvI3mMpjcclyWC7okxjUB/c+9USh2VglPwbLnz?=
 =?us-ascii?Q?cCPXz65S54vEWoP0hpLfzWjTIoIejBzjmJzZwnu/GbhluOOSq9YR1bDXthpO?=
 =?us-ascii?Q?n6ttIW6Iq3GMF/Wf55lBy+Bmvj2DVrHzQs2qhOjZkliuUkDVNHVf3tC32DWN?=
 =?us-ascii?Q?saQYg9RHBxlDmyUZAz25dTtgm00j9yfdIoidG/D+BQVDp5drVb8SOPfCXiD7?=
 =?us-ascii?Q?wLUAIsX/DdOyIMtZyf78Eu8w2ZsWfbkt3Lt7vEu/NivZPhdZj15VXkJ9zpsj?=
 =?us-ascii?Q?oN+jSokzfdvP9/qxt+n/fmAQRfqSbdHfHeJBO9FIzYaBEiy8WAUQn9QaOZ+m?=
 =?us-ascii?Q?750Ag/nLOdgw7rIxHXmh21eq9fn2M/fWda+HONWRUY+fubfSoC9V93PApSZp?=
 =?us-ascii?Q?iuJe3E0SWl8ScdiMyr3vC9aJdmDhJBaDSO9EbXpzP6EPuSZ0r+eaneQDVjQl?=
 =?us-ascii?Q?szgCQAEGErD7n5KiEBjVClQ0+k47kGHDLmca6sEsZgxvgEHw/ATK6teJOsJd?=
 =?us-ascii?Q?hhKUnFXkZdlIaPr4SQYZ1uYj7ppuSBDKXQ4wSTvdCjUTZhSONXmUyqz6Jmoi?=
 =?us-ascii?Q?fzycXIYwioZi7qPRnUq/d7cyKPt6TvtZhpUEVdNShplbbWnIYFN5mvZCuOpn?=
 =?us-ascii?Q?WWsB+tw2msRVcaJqeybvCdyTDkfSGR1SAx3Nio9oKP6AQ45s5VL4IWq9MEHY?=
 =?us-ascii?Q?ArtHmeyCUMInuAMtrxQ3Bh6jcSxxzK7+cMgV9Aafm19lScvp4U9HGlK9CK2C?=
 =?us-ascii?Q?UCjEitmvHQ+IR1tNBge8LLhC3EB2C5j4AK0muHqwoPXKPK5qfpk9wArf52Zu?=
 =?us-ascii?Q?mcxHkVIoJQiVX1gQkKTM0bwm9AwP29OHKOWczAmQ6zsruWR0FdDedMwIXgqI?=
 =?us-ascii?Q?obZqcOTu0iUgelRCZexYTotOal/QMxun99acAwbew8AeJnXtmnZ34W7ORADy?=
 =?us-ascii?Q?d3SaJoUriTHMqMa4jN5fXwVPN/XsjyE+DeXduti3/ZfRR4J8jLGt7NPlkj0X?=
 =?us-ascii?Q?fjN00Be23Ebl8LhpNK0Aj5KTqmz+XwF7YE0SCT2Gqcld/y93GniUUyG7IcZ/?=
 =?us-ascii?Q?Ef0lve0EhBCISX3r4tNaAKHcCjHz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f7e03f-197e-4314-a586-08de8371cfcf
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:36:37.6840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0774

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
index 4acb6ca585ff..983057970e7c 100644
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

