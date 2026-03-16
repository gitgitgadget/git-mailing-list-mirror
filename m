Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2683A257B
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675414; cv=fail; b=QQ56RlBtCSdmtU6vXrouGi+fl6N10hohRaLyeVJo/G5/iUUAtKn8LtGtAkW1+hLeSHiM+tXStkDhaVgqtFC/Mmw6uoYrGCrGe9Jlex4eJY8uz/Z6y4Bj6Niaixq1IapRQ2m+tJWv4hQ3gwsDA1eBBDVoRlEBP3YRzivso2p8QCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675414; c=relaxed/simple;
	bh=mmWN6Pk4NTv5XBjvDoWYAWgBCTIrhzMS1zfsGME/4fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iqAVhNKJ5rXnwNJ7Pl56F03REm9gsu6jnhaLVtncZ24wZbpeRcvoxQ7tsR0bXLQNrtR9iGswWFgiUKjqoIqf6z666XeyNiz9HPN5EvSXEtN57EEze4Z84luxkE6r06n5wYASqBL2yrtiMYwtEAuxzbzLm+iInj6pE9zzxy17P7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l656itnA; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l656itnA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jv347p9EvoX0x0zLxrBiexE2rlW1usRYZQP+JUHAy1jxqh6IrI8IwV+rpcxmLgk/rKkB7azul9VvLT0iy7S2kfozrDy0cty9Z8XwsZ/9GnXjJ0fMdMDljLbW097qXL9foWl6lD44j5SDhcVHuPTOY3RSr6GWi193fHldFla/m4fTJ2+gRWgPXyHPLGMZNvssATEtLrabuhpct/wACFGS72X7d7c80D2IGQPQDGgEul3WTaZEym4a9oKPlInj3bt+aBRuAmDZIk19zelICtjSucoZyO9lZQ3RHtt5i9F6lH11Lwkwe5CBZgeOm6EQ1wTjqRD4pRLzCq7yis9/ylt/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZ3yM4KF5oWlpwuuSprbPdO+h1WjWy8/tUgN/Y+VerY=;
 b=C8iBfOtmK9shzOgzElUWAb7coZPd3CnEbOU81skUDHR0vpYStDpAf9xdxFeiEf0XMFepNiWNs/3fAlcBxIlvZa783ZjnF+3tqO3SfDqVV4DZ0sRyuJRI5xqIrlM7MNXYFO6//U4aRJnR3lvrXkgRLCgCWv0HwY4zjAKBWPGM3ID+Pe+DfAlvqOQ7yMPrzF+J38UoJ59ijSehSuZTRZ7SsMfYOy2faqX5YDTg/cclM06u4WAG9Na3i0Hgf90pR0sVXqdhcJ1hXswetSMqzWnUghUHJH/1ovVqAcQrjzyO7oPA4F241tBNR/d++LvVqsKUNOeNmCISKYR6rIvJJ9S6TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ3yM4KF5oWlpwuuSprbPdO+h1WjWy8/tUgN/Y+VerY=;
 b=l656itnAjW0K2p//VIDCefbGOfINF1lck3af+lr6wtLqQE0dyGgtJipuRppVGIcgvzzfakE/HD/xV4BdvfnEu7jXKaBbydNMK0u7NF19/9aQEudmFpkfEVNfRaJmc+ZLfWAlp8RAVGhdwzbuKIVmNpw9q337YRyO9hKQuqxxtvUFo+RRz2Msf5L+nrDwkeYp21bSrEhW49MX5+92/pWYxhof1mtXSJGaGRy2CxugCt0E8UPlgSE+h+mAzDkcDZCaOik/qH3UyP20UfxU2WtTNPjRbTQtvYpD8W8/i0JbONcaTc5S0zGP6dFhBl6OP1LK1bmsPCdoWlsC1Z1nnhmT6g==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0774.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:36:43 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:36:43 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Aaron Plattner <aplattner@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v4 08/10] parseopt: enable subcommand autocorrection for git-remote and git-notes
Date: Tue, 17 Mar 2026 00:36:21 +0900
Message-ID:
 <SY0P300MB08013C6876A8683EC0EE69A0CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260316153623.569881-9-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 1ec80b32-2044-48d9-bafc-08de8371d371
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25031999004|19110799012|8060799015|41001999006|10092599007|23021999003|15080799012|5072599009|461199028|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KWtYelATq1+VCLLTUic+53DKPwrbFauojNfB0OIUevid44E5xG55Sh/sB9Qk?=
 =?us-ascii?Q?pSqb+0FZkJTJeZlsuo3qwhwqc/1QcEKQhb8RCGqH2IJ06yUSDeAdHZj41+B6?=
 =?us-ascii?Q?oeyAXx3DIoIhA+wVYOOBq0CrSHXBdurRBkgWA1awF2x+Cg91Hpf+6o0W1Jdp?=
 =?us-ascii?Q?dXfNKgCyzxfhz7CAveOrtu5T/BwtfUEtteoZNIGKQejz1fG/f26uNwVsc/nd?=
 =?us-ascii?Q?CFTe67hqa7nmdgU4GMMawWhmtla/Mk+iJ9OPEm7+/EtCpUc620/KkpAJKXJz?=
 =?us-ascii?Q?bv7gppcPqR4GIP8YlWk6DEeZyq5XQtDGx5buhyXCFJliJofxlzXnsaQxN4B0?=
 =?us-ascii?Q?yhRyf4Jg7cKUPhjmaSwFFvi5I5t1Z7JWMIDUgaB1VhfFsx8hla58KtQIukZE?=
 =?us-ascii?Q?ixvjBBVW11/hzGMGEOfmcR5ct5DoaR0wpnFgv2c2+omOZZPuS7jIaEaScmwD?=
 =?us-ascii?Q?9j+cAy5wfSxxEaHLsSsHrmQiaHFASN5TOHz5x3g4yc5co1ZEnu+ESMeB7k4Z?=
 =?us-ascii?Q?gHZ4kMXZGOVhznnUMmeRoo4qoIAZvVjOO1kJx71SUwVDdv55xGkZ/lMOIGZW?=
 =?us-ascii?Q?q2j5nacaUMOC9TrfvXZdow6v/sPB/yC5XJkoTQbuA00rGODjfZeeER6bVr5b?=
 =?us-ascii?Q?88u6q0IZ0gNz/f3XLfhS552utsn5DpRL+c7VH90QMzdggeKFG+1z1RVG+gpD?=
 =?us-ascii?Q?2mmRI9YuP/qfV5bgQEe8MIFT9to0qlwEd6F2mVVorenmWgBTAosOFWdmQ98A?=
 =?us-ascii?Q?bXl+vZR1qJ/ypkxet/Q2g9L/gHuk1B9QTTFjL6z7ej9w+Blp0jSL8EC6YiR6?=
 =?us-ascii?Q?RPYez8Qxf0NRTeBIan/Gw9XAK67Jal4umEefRV5zN7Fm6j8flC2bFaSW0ZRi?=
 =?us-ascii?Q?1YZxNP9G+dlhjziEJ1xM/7TLAunDkNyN919jJY7wFCcWqNBJ9s4cSZ1IN/6X?=
 =?us-ascii?Q?fYRq80VnwbUraX7Qk6rTIEyUMzo984+gXl6BYHNUw+J8PL7qbztiboCifit3?=
 =?us-ascii?Q?6zPHCrT4fScxLdqmQXCIoh/tR9DWVSU8YUTQXepox7a3Y28=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?32FgmTARMx6TZHT80H52ysttvyLtjo6nLgzFCjLsjFH4EJth/Py6hQLkvRlR?=
 =?us-ascii?Q?5loCODT7vhXb3cA0nxKZUEqciY/epFlSICATA/yRG/BXa8iEf1PEq1/qPW5J?=
 =?us-ascii?Q?NxITfKMzRKVqcxjjOLRmuaYx4Kc8Bfd3XszoF2GlEf+i8/sQpuoY2xM9Pl9y?=
 =?us-ascii?Q?3/jVv0mYFKGwC59S8Au+5tHd5o+OqXvgTkuPqZ+7SwRGzmhVhwuifzJcQu+H?=
 =?us-ascii?Q?ruTO39FXD/vLTPuqeC8YKTwjnQEGE4UD8uNpoq9NuV7CiUYtG7kGnhgZVVHN?=
 =?us-ascii?Q?W8eA0b11aWKGgMggWRKNLHHH1Bjh++O5GHXboaRFHMzf4orF/gQvZ87Wsg3G?=
 =?us-ascii?Q?FsNrf7ewcrOcxK0vU74RQakvnGxqFBWuBOkyj30B7iXSx3IsW3LUgIAU9DiY?=
 =?us-ascii?Q?ziY5PiNqNQsMhv97CVp+tSpP11yjDaO1G1NSQR3wX7jgz5+uehFrFR7+AG/p?=
 =?us-ascii?Q?a1aq439WvSv5c0w+ZVy8Ae6C8/bJOPMcpQzLH7JYJ1zzVZaACftI41/n298E?=
 =?us-ascii?Q?aRiFcCGGLh9MPP5zwuIKs5n2ebdJBKLTFTP3CRC93rzMBg4pAyeCUX3PQml8?=
 =?us-ascii?Q?2ibjy+qP02h5hIMtDSyyrHKIr+P+1HBA/YjYJtmSElo8qGUYgVeJ/AGmUC1w?=
 =?us-ascii?Q?qjoLjXVB9f4VDD3x1XhokqM0VjqyJPBzlPLLa3ReVBwJxBIsftTk91GvlWBh?=
 =?us-ascii?Q?KzReyEJCR+f2zSlV6HHujQyYPVv2GdNRKVmURKD71d52KYKtZufZxEo/eTUA?=
 =?us-ascii?Q?Ze0J4eOypAHdL+8+0EFzMbaJxkEp+XZp5ALNC9pfuuJtgHGaLwcgfeWfboXw?=
 =?us-ascii?Q?cY7WYpReeTgotpqKVdFkmGkkuZE62repx5iHAf8sPUbfpYhWB3EbzX3UnjNA?=
 =?us-ascii?Q?bt+Cp1ZQNmNq0mQ6SjYyBVVKiMmPm3SndqW1JgAKX26AD72Jy5B2WTHLB55e?=
 =?us-ascii?Q?7sf5ACDqwCbPcE6DnGd41vxXN9K+etNYtAM8CPAXE0OZRRqvPyHEyGRw43B/?=
 =?us-ascii?Q?7LyzUpTbrHBJNNwPslXcSfeZhQbCFEh9f07UV616W/NoT6A1AMdkf4AUHdQa?=
 =?us-ascii?Q?z5fOJK5V5Asa7JkMkZ3ujiWVuEpMv94eQpSa4pEMBj6c1/sgNt5llP7C0Ggu?=
 =?us-ascii?Q?UyPSOYzodRnLc8jKCTAcCGIEGS+mXk6/h3pudR8CMLHO2W3Eo5nHkWuHMulS?=
 =?us-ascii?Q?RZyJ0gTiP66DzAk9ZvjhVmeu3BAQJMBDZJ+z/dVVdHfiksd/Sa6dTxjtpc+I?=
 =?us-ascii?Q?bDZr7AOKEhtP1t9oJKG74RyP4Yr3AePAxFgra2tv4UUSRV9fC2mQfD/ZxYr7?=
 =?us-ascii?Q?OxIHoEIVI1xOYRpFWmv8s3I+f4FZnxbfLQzYn0Ds5YT1cyJGlyZW8LfFTjM+?=
 =?us-ascii?Q?rg2MYUAocPSrqi+gyqFsvRsUX7nf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec80b32-2044-48d9-bafc-08de8371d371
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:36:43.7929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0774

Add PARSE_OPT_SUBCOMMAND_AUTOCORR to enable autocorrection for
subcommands parsed with PARSE_OPT_SUBCOMMAND_OPTIONAL.

Use it for git-remote and git-notes, so mistyped subcommands can be
automatically corrected, and builtin entry points no longer need to
handle the unknown subcommand error path themselves.

This is safe for these two builtins, because they either resolve to a
single subcommand or take no subcommand at all. This means that if the
subcommand parser encounters an unknown argument, it must be a mistyped
subcommand.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 builtin/notes.c  | 10 +++-------
 builtin/remote.c | 12 ++++--------
 parse-options.c  | 16 +++++++++-------
 parse-options.h  |  1 +
 4 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 9af602bdd7b4..087eb898a441 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -1149,14 +1149,10 @@ int cmd_notes(int argc,
 
 	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, git_notes_usage,
-			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
-	if (!fn) {
-		if (argc) {
-			error(_("unknown subcommand: `%s'"), argv[0]);
-			usage_with_options(git_notes_usage, options);
-		}
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
+			     PARSE_OPT_SUBCOMMAND_AUTOCORR);
+	if (!fn)
 		fn = list;
-	}
 
 	if (override_notes_ref) {
 		struct strbuf sb = STRBUF_INIT;
diff --git a/builtin/remote.c b/builtin/remote.c
index ace390c671d6..d1d6244a662a 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1949,15 +1949,11 @@ int cmd_remote(int argc,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, builtin_remote_usage,
-			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
+			     PARSE_OPT_SUBCOMMAND_AUTOCORR);
 
-	if (fn) {
+	if (fn)
 		return !!fn(argc, argv, prefix, repo);
-	} else {
-		if (argc) {
-			error(_("unknown subcommand: `%s'"), argv[0]);
-			usage_with_options(builtin_remote_usage, options);
-		}
+	else
 		return !!show_all();
-	}
 }
diff --git a/parse-options.c b/parse-options.c
index 1f1b72762790..0b84061a3811 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -698,14 +698,16 @@ static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
 	if (!err)
 		return PARSE_OPT_SUBCOMMAND;
 
-	/*
-	 * arg is neither a short or long option nor a subcommand.  Since this
-	 * command has a default operation mode, we have to treat this arg and
-	 * all remaining args as args meant to that default operation mode.
-	 * So we are done parsing.
-	 */
-	if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)
+	if (ctx->flags & PARSE_OPT_SUBCOMMAND_OPTIONAL &&
+	    !(ctx->flags & PARSE_OPT_SUBCOMMAND_AUTOCORR)) {
+		/*
+		 * arg is neither a short or long option nor a subcommand.
+		 * Since this command has a default operation mode, we have to
+		 * treat this arg and all remaining args as args meant to that
+		 * default operation mode.  So we are done parsing.
+		 */
 		return PARSE_OPT_DONE;
+	}
 
 	find_subcommands(&cmds, options);
 	assumed = autocorrect_subcommand(arg, &cmds);
diff --git a/parse-options.h b/parse-options.h
index 706de9729f6b..f29ac337893c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -40,6 +40,7 @@ enum parse_opt_flags {
 	PARSE_OPT_ONE_SHOT = 1 << 5,
 	PARSE_OPT_SHELL_EVAL = 1 << 6,
 	PARSE_OPT_SUBCOMMAND_OPTIONAL = 1 << 7,
+	PARSE_OPT_SUBCOMMAND_AUTOCORR = 1 << 8,
 };
 
 enum parse_opt_option_flags {
-- 
2.53.0

