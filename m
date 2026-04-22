Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012070.outbound.protection.outlook.com [52.103.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CA346FA4
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860404; cv=fail; b=ToGdvR3Tt0ZWbeaDqmETp7+OSQvtJ/6v9yBLLX+qefXolbN+ixFFPJ+QMNvqxSdYcPK49JD2f0dglYZnLN9DIFn5IBwZEC7wqhb3t6C1gVk2V4FbPJg3PgA+vddzLBp6yVbuJtavym+26oxpjDxpZ/2TgsPIZnerQUQ8d7FGLsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860404; c=relaxed/simple;
	bh=CX0xzEK6twfU/dIbmLd1x2aLWAkUakKQ9wgdVuCyukk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HmX1XRf4MMMPZiuQhEBTQopSo6PxMgUxB8artxdFhf84Mvbu1FLcOKKXY6FkPZn59xFFugdRZUqXVOhBfh+pZM4GViZ0//xZ+p40YGUyRA5lxoGS0/bAlMp+z8QevbsyNuPELVoqTHfdxUJ6AZMmcOAp5HazsWjelKVQNjJvhsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dcfgsgDp; arc=fail smtp.client-ip=52.103.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dcfgsgDp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mvj8VgWJhCuDMEAyJwTt1ulZQl889OQOehZYgwN9VM5Rby1b4YtLky2Rk30u+U8rsu6hbGHQsVC2Gg62FNPSxr3TF+DVnQUFArZWWn/n8Qd78WjfH6M6vOoq2DKADQKW04evvtARxOkFCe5aWEq0kfVUqvfg/ksSMCMoFUXUw2HBUNZK+BR/yMPRWy+nGgUWzhHsZQw1eZHyBCTeW+i/DTCffORKSfFdxd1crza/q1e7JwWQ1KaTug/oKLWomMYHcXnF1gaGJA0mZKR+CtQgIlW0IfjnnTmussXyBDzfYiG6mCy17Whd6Ud/2gC7zwHOkQK+cn0+CFVUTL2IqIJQZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ux31TU964tHtz8CYMpZNJmY57LBx21qo4CLImd2YgEQ=;
 b=eFEjqFXbTVghLy7h71gFHbGY6PprYYpLP9jF0GF3JiriW1exFYHHhDEon6k52vETi783QKNyu7X06j2tXOQGeP37pbDLuGTqh/rALpSyk5xiJIZvWnW2GXbjn0QGFDew1wb3NPi2tUnL8Oyo8NmnFVLumtmffODSE1dKZBsLaJdaT+MFuPTpB12xLeVcQlzzx2koeNO+N8bJD37hSmyMJHyPhQ4rtqYXssnRBhy7DxhdoXZZSAJIICnrdU3P8BzjHymd1RF5cfXYezRdFC2stqGfVpTc5ovND6TeOPDwv8o6IGE8Ss7nlaYMXeo7dC3pDtnpWo/tsyyWSvo9S5g/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ux31TU964tHtz8CYMpZNJmY57LBx21qo4CLImd2YgEQ=;
 b=dcfgsgDpqQ3jNtcioaYTauzqD6IKuvXPi6ZQezEzcNUcTMJWgmKL1REMFbTuVH3jM5x1e3c29mq9BxyQI0LcLPNkvUHWCx3JHy//zpPgF2TTDH79LCQRp/+LOCYGfGCZ8RCTmomDku+6W0/Iqh8ZMfIhtuYUF4pHniXdF9wu7OSqlsVH3NG1/vNzuhqD1Zhu9dgZVIJUpi8X/gImVRlMG2sE4Onv7Z5PLEKU6UEKoeDy7k/rVNurAnjeR7SaiA/QCa7o+XnliwFDku3O0wZm1rKOVJTEStu73dQZ+ZYABGaUHyCay6w3yHkhMVaSR8MiuY5LJizYHiTzhYlI3BptMQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0530.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 12:19:57 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 12:19:57 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: aplattner@nvidia.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v5 08/10] parseopt: enable subcommand autocorrection for git-remote and git-notes
Date: Wed, 22 Apr 2026 21:18:08 +0900
Message-ID:
 <SY0P300MB08013857F222BCCC22870ADCCE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260422121810.307862-9-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 150ce808-51df-40ad-8a39-08dea0697749
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|5072599009|15080799012|23021999003|10092599007|461199028|8060799015|19110799012|51005399006|55001999006|41001999006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KIRyFmtkiZjNukqNQIwKSmWp2r9/BPA+jGcPvWzLJ/Q0IYi3GYSkA5X8lEmX?=
 =?us-ascii?Q?r7sVt9bBxl0bEhbzmOh6EUxnEbGIqczAMuh6izpSlg9MiWxoEADuhRBsuPj7?=
 =?us-ascii?Q?va9g5vp7LzORVxXLilYO3+/qN7OzV2MANrCrZfP/+ybapgWRk2J3zVmCqdTz?=
 =?us-ascii?Q?BZ0UITOeDClwuzRHRREKJhHyVCl5H/Qs2lx578ABXDcP9cCNI5GklwX135ry?=
 =?us-ascii?Q?0FpJHn2YKShLIgGRrM7t+8T/FQg25mOWt0Seuy9kEzhTBJUPRISIvc4hnt1P?=
 =?us-ascii?Q?5ty2WmjTd74/c+fyYe06Ko+jJ2Fyy/0y+PSlM6cfhlcPcSHmEbEEZajgSA+c?=
 =?us-ascii?Q?zAUBvDOAkcFMRAAB/BOHkXvywZep2TZ/OkbW7UJo52EXuOFSK5u5X5EN/WGP?=
 =?us-ascii?Q?A6jkM/9m/0IadeoakAU73+ZgZ1mndSovdrnKaCE3XEG0nZC/+lorcpMySJ80?=
 =?us-ascii?Q?GAG6j72pXjXc8PFGE0kndmw662C+02V7WzhPR22x7V7QivQkTySkfcDk+7lN?=
 =?us-ascii?Q?qP2GBSefXKFEMiY29qYc6TiYbQVJZO1cY9/tshnKnQaoXvKbA77npX86G5rj?=
 =?us-ascii?Q?WCaUIXC6LIaBH9ACRdB3y13cVqjAgUVy5sMkSF4pEsGEk+4pxbcDhCJI+Anx?=
 =?us-ascii?Q?FxKeSSNNPGEo+61sQVPBFtcaEp0SwjQjAeGoBej7mnSCS2MsbKi9i7DGGD81?=
 =?us-ascii?Q?dvAlEmz7Wuc7LGezOiLxB+uBaK+O8zw0O4c1UIxAyEBJ8FsNofoHmALgldsv?=
 =?us-ascii?Q?NDSFnDhE6uP/v73OdI5JHL0MzT4DGSTajHk22o8hlBGqETJoQbSpySSdui8q?=
 =?us-ascii?Q?l89JKNFSMZc/1gwW6k+98Qp1EKf9r0zFPkHZVd2ACyl+lK9IejP+ufGNuheA?=
 =?us-ascii?Q?X0J8l5CsNkwY1I4tHhGtcfKZT59l1/tbqNTGHSAIuBYRDO1yU0PL6FseEItn?=
 =?us-ascii?Q?M04dt3eOdA+TkG4SFNy1++lWfmoqSdq8gsqv3qPTUvQNKF1s4iYY2nTJpwvb?=
 =?us-ascii?Q?tu6+SQ5WhuL8zgOy6yLw3JlmAiQ4dTw9TvqQbHdN/3JxluBFjMaOb/GZn4Py?=
 =?us-ascii?Q?r2oRDrR3?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yBmWHYLkLtWT/4zR217CS6keXvaodaQfnSqmGei8dC0isC/knDaNPgswtXz7?=
 =?us-ascii?Q?ipYdVPG11hGsQJi0/rijB+QTxTchdfMyB+tLHNzBmuopoEZquSXFgZkrYtJB?=
 =?us-ascii?Q?FOiKyRKa2IvLcFyuUBOG1ncE3c2k4WFLkGkUUbkURblt5+iOnZ2Z652Kl7aM?=
 =?us-ascii?Q?63/JcAIA7xH1wDsH3ok3MQZ7aSRJ7titKT8h5YjBvJhuMyD8L7+G0EEVzfdB?=
 =?us-ascii?Q?LmCXhipbYczd58aHiXKKxOKKI1eFJ0x0LGspxfyQcpxVfUIF7PaWWsQu5NyU?=
 =?us-ascii?Q?v+7bOWyoISjYPaxyL27IOCgj8hL3+h5+Um7AkChV8RFqBZ6ZhGBc/C8ronz+?=
 =?us-ascii?Q?5grnYefZ58sKjb6SLb8PWd3BkBjoo+wm2/U3n2MxRqHLdZ2BzCZlbzNyBN0G?=
 =?us-ascii?Q?bEw5qAz8SoSpy6SRqv+5u4WuoxFnnPDY5mWF+AtaZ7OtM7SE384NMfolJnv+?=
 =?us-ascii?Q?EbRyHkB400J9ndM2LgidQwr3cJ2zlqSwwpnXe7LrRmcJbWf3vOVzesfOxgV7?=
 =?us-ascii?Q?UxOei+5jXvmbg+wqbkHTqBrclEeb7nI/g57D7dmIYgSmtjfUCmtwta6x/uvp?=
 =?us-ascii?Q?UNhzcbQbU+nmXIx6JOZTcLmbLf2r8RNzfr1Ocm+jfv5OSqeDNyCceAynQaqv?=
 =?us-ascii?Q?XR2R/vqSb7BgCFhZGI8kGodb/uOW1rofs81rCw9NhwMpL7D+aDAimzFJQrfy?=
 =?us-ascii?Q?+W51KmqkTSSUHTclHKRvPRZ22Q3nVOGLjWskTV5MJC8Wrm374CjC9SZ9mDa3?=
 =?us-ascii?Q?TxVEk4/MTS7RyXHOTikacxTdyZJGvDJwa2s+aOSTSTos9rOXw67/5SGhI9+J?=
 =?us-ascii?Q?X4BC0f5TcjfRtN5jBfQLiVvAHDTwduLuQAZ9/i0z7ZyW+aUWRxg5y+Kgz+JP?=
 =?us-ascii?Q?aMQH3afozGlyxEsGDnPYAc5oSfdXX+fpZtxTyYeJ3tYk0tATyxCxm4Lkuijn?=
 =?us-ascii?Q?quthnmrIWXLI+eVxyVMSumLEqT/7iVM2IzfQaShZJvYZ7WBpyRF1I4jCENSA?=
 =?us-ascii?Q?U++xqI6Q9dwg0s5Ql4SID3lzvmJtFj/IiD6Ph8uwkEEkQvEp+g9eT9oKK+cG?=
 =?us-ascii?Q?XiedsNIbaMZdFsHqx0/iU3x1NA1JNq8w5zbj44UiF5WdMa95GMgskAtCs+rH?=
 =?us-ascii?Q?IKUz2YqMrtpHtlV5kGyhxxCrtTa5OL1eXKNrblwIeuJmbhbdh73ndegTHpia?=
 =?us-ascii?Q?rYJdmntxw8P4Ks7j0H0fLSn7LAtAuFYaSup24qzGjFz+wHx096zxNKruAnBN?=
 =?us-ascii?Q?P8G3fiYKRe2EN9X/mXzH3BpaBU/VSSxxwtIbCX5FEkaVpZNBqcGtDU9gxiTD?=
 =?us-ascii?Q?bz7clAu5btCiMW4ZiMewe517AvmG1lDHS700WGavPPNJj1Ysjs7zBkKZUlCq?=
 =?us-ascii?Q?bhKUI6wldbdhfHZRRHGSN7kDU681?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 150ce808-51df-40ad-8a39-08dea0697749
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:19:57.1431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0530

Add PARSE_OPT_SUBCOMMAND_AUTOCORRECT to enable autocorrection for
subcommands parsed with PARSE_OPT_SUBCOMMAND_OPTIONAL.

Apply this to git-remote and git-notes, so mistyped subcommands can be
automatically corrected, and builtin entry points no longer need to
handle the unknown subcommand error path themselves.

This is safe. Both builtins either resolve to a single subcommand or
take no subcommand at all, meaning any unknown argument encountered by
the parser must be a mistyped subcommand.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 builtin/notes.c  | 10 +++-------
 builtin/remote.c | 12 ++++--------
 parse-options.c  | 16 +++++++++-------
 parse-options.h  |  1 +
 4 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 9af602bdd7b4..f9bf350df4e8 100644
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
+			     PARSE_OPT_SUBCOMMAND_AUTOCORRECT);
+	if (!fn)
 		fn = list;
-	}
 
 	if (override_notes_ref) {
 		struct strbuf sb = STRBUF_INIT;
diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3ba96..6a78ab8f4cd2 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1953,15 +1953,11 @@ int cmd_remote(int argc,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, builtin_remote_usage,
-			     PARSE_OPT_SUBCOMMAND_OPTIONAL);
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL |
+			     PARSE_OPT_SUBCOMMAND_AUTOCORRECT);
 
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
index a488f9a41df8..820683e982c1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -720,14 +720,16 @@ static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
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
+	    !(ctx->flags & PARSE_OPT_SUBCOMMAND_AUTOCORRECT)) {
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
index 706de9729f6b..e5fd4da4055b 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -40,6 +40,7 @@ enum parse_opt_flags {
 	PARSE_OPT_ONE_SHOT = 1 << 5,
 	PARSE_OPT_SHELL_EVAL = 1 << 6,
 	PARSE_OPT_SUBCOMMAND_OPTIONAL = 1 << 7,
+	PARSE_OPT_SUBCOMMAND_AUTOCORRECT = 1 << 8,
 };
 
 enum parse_opt_option_flags {
-- 
2.53.0

