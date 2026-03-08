Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010012.outbound.protection.outlook.com [52.103.73.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C422E7BD3
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772972281; cv=fail; b=ImjoLe0c0QeaFH7ZYuysFo1UFP0AytZp9ETRC2jf8Xzt+gWipHA+sJkeMc5BdFP2/chWjKvtL2kx99tslag48+4EyjY0b6lSbUu1dgT0wfVOYfxpwo0mu8aGKO9UW4o4X6wUagdCDPLoimRFmpgcaKrvxDrfS8oMVNetesqG8gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772972281; c=relaxed/simple;
	bh=Q21q7eXi1Zd/Ui3a9xJi/tfkz8tH96VLJ9zUDHYzeeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q+pwGoa35GOlUxrpsSxQHpmnf5wLBKPFvFQ9AqaXusyWOoH45/6ZHfWpbnvKU3D0UPsuOv/rwryZc8XMRh33YbW12r45vxN65NXgwJ3v3hMJnBp5Mp+DwTm6A4uD5D5d8vs7361ZUSnwcWCJ+lT6oIDeAfvjU8IPTHODPTWbAfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Xv9DITO6; arc=fail smtp.client-ip=52.103.73.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Xv9DITO6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOHKOH04KTGk7iMKkeRpyTfEFLmW4Z4fE7HsJlFDSF2Uzk7PKvD4ID61T/m/abXNZ1keERrEwj/RYQIzD10pGFGoBjkzYAuLZ2rfXMIbKgqq07laf3OgiXjrNtVy8nV6WwWPEGFirgr3R7ofRaHXWvvSUgEHt66tCPP22WmemTotlRHIte+XKkyAlSSHeIX9LrGWkYgVa0e55bUipgABM7ZGTWOeeTmL0X9PNfxw+Z6aoVvJ5/ZAOxH8++5mQnlNGo6gRXvC00ZmFjpiXCM2P0YbSXHZCt1BcCDu0CWTELQ8N6BqR/3odvD8qJhX1Xw0VG6OSmy8qF/AB45hkcmm3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfW0LkeKnayHadoAWJOuHEJV8o/zraURU/B07/drje8=;
 b=x758RDu371zJJ1f9zzajH2mmIDi7chKwjOZoUoWINDg3ZTgrfKCntbQluwa5bGBgBKjyqDDRTQc790ikFy5+DNP/8i03pzQbVujQvTSTZwWMc97M2g1C0ILc0OsFKuSlYtIzpFfePgLtj9kSbWeo0XdjUopnyx3HvfkmH8ev+0thRtzfsS4I+tcpwMo0W3GuBmVrohAXXk3fMM4HFwB85GxkufujCH2L91jkxcehsqKvkf0GnN5pmBzWlIDHSERZ+MeXIaW7KDl0gcB7vCEHfQGKZNjeM+PxmATyaxQ8oXanfKk3aQa8sZ319LDGFEjG5R0XsIq6Di/maOKYTTE3pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfW0LkeKnayHadoAWJOuHEJV8o/zraURU/B07/drje8=;
 b=Xv9DITO6LWFHjZb9Vt3b13JNOWq0qL+x49Qbccyn/YEVhmjIDUVUOeIeZlYZR3u3vwta49cK3LJ+XTNpvej5gzai2fFbHw35GVreTkHCNFqxAvWlAtNmieKQ9ma8/jrsUkpqbdpfgV+BLo0oZtrLq1ty8SZG1o19SpSEulNHVxFsJNf1q/MZIFKsKqWAZku1Ihs7XvbAQl2I/nkcB8zK5F63NpQXcT/B/vJ2DcOVVatabhEXWi91KASU58AlE0vtOAWv62LgzBoWfFy8VBCp4VYR5ePKdGi415pKCBFimm16GMIubtklsZmvSKk2oF35gQ+XduHM7Y04PBubv2FpZQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0080.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 12:17:55 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 12:17:55 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH 4/5] parseopt: enable subcommand autocorrect for remote and notes
Date: Sun,  8 Mar 2026 21:17:24 +0900
Message-ID:
 <SY0P300MB08014A3AFE45F66951ADC8E7CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:a03:60::27) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260308121725.2333643-5-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3b28f7-7f7c-4deb-6279-08de7d0cba69
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|51005399006|10092599007|15080799012|23021999003|19110799012|8060799015|461199028|41001999006|5072599009|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jyGUWxZYALqohY8FLCewTGtVwEiumLNWd20kOjnPl82a+c//YiOqrIPmdFLy?=
 =?us-ascii?Q?LwpiLEo1c5AGqvRVjdfehiQAUkFRxYyS8b9V7xIJDcel0oP0rs6zsx6PC8O/?=
 =?us-ascii?Q?wIYXEfunlObpwW6SadKifKmPCV7qQnEtckKEiPO86hfvUX0zd2lSSPy+/BaO?=
 =?us-ascii?Q?VSNI/zkYeXcBce2IQNwc85AygU9LUcVQGHlK2DM5PQ1vrhACcdWZ+H0oTGJn?=
 =?us-ascii?Q?lSfhx0naBur+DnDUyWLigi1GiZjhPb8f7buNd1GeztioihoUU+zpuzSgD4Ht?=
 =?us-ascii?Q?SCbxegspzpTtdgTLNOWQTb0U524Omcs0Jif3LKr5JwxAESn7ZvCFcuWTBs1u?=
 =?us-ascii?Q?GAJ1nNKY3/vRWLGBPqbx1S73Hu9GLnEDd+0qdte4PgY5yyG1OVpjd/gMLNKq?=
 =?us-ascii?Q?WLnH7S/yGcueXivgxMx9jZvl0ghLSjI02fDKdx4MEP0tG0stRyBywg2fNJV2?=
 =?us-ascii?Q?TpKH6TVyXAPYe2kp33Ncd0ED0837R7zHEYd1dUIyjTxuyCtQnGa8AT/R7O1T?=
 =?us-ascii?Q?pXg/826xCPjaiTedddxyGdvss70GDuhO2zp03JSe486T+yUXR4B5xkNMkh8m?=
 =?us-ascii?Q?0GIeeYGisF1dzhvROvjBlELa5+D4RXxAAbl0q4tnHyOe7EnCUF9517NB9v2p?=
 =?us-ascii?Q?0ZIgn0bjSpTcC8I24TqADCkQ+ewbrVQCQkT5erZ1YIHimFDqkJU5K6ZAXzhR?=
 =?us-ascii?Q?WfJi6utlU4XXmOklkJcNV4X3oxJM2U8bzBnlLruT2NpJbTf440vqLDDtZnsU?=
 =?us-ascii?Q?TrBqaB39z3tJmdne4IQPZxCWRduzLdsBya4ClcSZq652BXP/iwAG75Gb1Fp6?=
 =?us-ascii?Q?Mnh2wVj/rM5Tlzyi6KX9/+KJv7f58I0BavPdZJ/JaUgqmw1c9eL4CUPBgsuB?=
 =?us-ascii?Q?5sNLHCB8ffWbYiuapoN/A4vqL43EgEy/+sKgsXOgRpi/QBBcZznu8mDGBHDR?=
 =?us-ascii?Q?5hJLacj+Zatm737E+3dwcttJ4p4hUVfgWOhAVwZX5Yxe+VHGlThQFhtYoUO/?=
 =?us-ascii?Q?mLkpzGpWqbdOe/uqQ0oY3FwLn3NhxFSrCMfBQFcekQTCaj0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?utiaSUAm5WUD3oT7ATyEtPfSbAwPEwv+jq7AoE4qi0q6usMZVFMmB6RPMhWA?=
 =?us-ascii?Q?OF99IQL/U/lVcw/Ql6mtrOAmu9kHVblfl2mAeDXumvgQFtmmQqzURt06zl05?=
 =?us-ascii?Q?Uf8YXUwXVaMuuGwekzWA5WVOyCkkeoWKdzj+sPb0ONoJBhgW7ePL3tAnsnro?=
 =?us-ascii?Q?Bz4Wi/Raq7TF+SxlPeA7dm/SoHojdqUcDnNa8xqrVxOSCtjtsMIE7ZLjBCur?=
 =?us-ascii?Q?YH5NPucwgTevqMi0SxR4daxRMaDBopVfkq8OQYI2M030GvLhLhQ0ehmn8ovk?=
 =?us-ascii?Q?BV4WYgp4XVELWJOc9L1JY1pAY0lDpDvSMSo0LKM064PfJwSEkjnBTuukARIp?=
 =?us-ascii?Q?TQpYh1YJ/oj83he9kmikCIV8+kljGDxkFJ4v+AktMzAI0sjEoHLsD5gh97xZ?=
 =?us-ascii?Q?Ob8TMxS+RhDFbVap45jJ+uAGrqMB33X7tLEth+SDoQHTTq0LsZfrfefSkvdG?=
 =?us-ascii?Q?2gWhAm08NSTnJsozbTkcszHzC1f5PXZ5VId2Ld+6JSWqfo/cmLd/OrnLkkp1?=
 =?us-ascii?Q?tf6bWFY1ZrMaAa+CPv+hU5fj6doO/jfFasfDJWztD4WVqePKDHxkiOJteMua?=
 =?us-ascii?Q?e0Ch/W08X12r27R4hKw15B9+8dbVx2zDuGkMuY6niYfdYGegeCovPnYQEJpQ?=
 =?us-ascii?Q?vIs5USvQY5yos9UGGg1vnOAi+BgbH9BG+Tu7pNXRYp2LD1MblQGijP5/2fYI?=
 =?us-ascii?Q?/D/HWoR1Ctvn2RU6vvhOtSpoOjZeu3D2bwZLmc6kjrVCNV2/lSMjtNf9D2ez?=
 =?us-ascii?Q?X8FGP2JSixFUzwC/URom2Itgg6DscnHE7yI4X0Z5mOx31VUip5boyWdEoMcU?=
 =?us-ascii?Q?hcG90/rWMkxcqnUK5OVKvR7phoP+P1R/tcGjlLpF5e50fEtF6aGA3DzdxsTw?=
 =?us-ascii?Q?I93qa/mMuuqgpNmKdYFm79nIQ6VqgMT7Hkg5aEDZVRKSQDQjlceldK5KGm4r?=
 =?us-ascii?Q?NPMS90iLctbVlcc3iH0EbELIT6QeKBhkGaPX/5ByPF/kv6XgK4Uge+BoUzWj?=
 =?us-ascii?Q?otQC0XX/jrSi/KGF642LvEw1vXR2JZ5XYzJOMWsVS/BA2iokxBASq3JVQqxz?=
 =?us-ascii?Q?PkohfZg5EOMM+OKd0rAKISPn5fvl9PBFUaWqCQDqx1kFtXbr9rDjMB8z9fWa?=
 =?us-ascii?Q?7XnowT8T9u3n00OAfPlUpNlaL52+h6arTtOsiegzpP+vZ9w6LDCinyHgk14Y?=
 =?us-ascii?Q?PqrXfr8Vkxs708OeHWvvOT9VXaBfa/R66E2AooxpHqwi8ez9AFcXHh8PhupD?=
 =?us-ascii?Q?Cd7jBsGGGZ4usVeDzD+nKnVSzOllUz/ZGI+aQaVHotQMNBFWHqABu75HC/ZV?=
 =?us-ascii?Q?jgT5s7dPBkUhs0qK1CFxWlByhH5ImJKrYem+WJ4GFUqO8IQh4F/wW2R1+BB5?=
 =?us-ascii?Q?NTRsBSpAsz+wx4UF0NmYOtoeHXGt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3b28f7-7f7c-4deb-6279-08de7d0cba69
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 12:17:55.7156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0080

Add PARSE_OPT_SUBCOMMAND_AUTOCORR to enable autocorrection for
subcommands parsed with PARSE_OPT_SUBCOMMAND_OPTIONAL.

Use it for git-remote and git-notes, so mistyped subcommands can be
automatically corrected, and builtin entry points no longer need
to handle missing subcommand error path themselves.

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
index cbbb04b9997a..b7c818e818fe 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -691,14 +691,16 @@ static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
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
 
 	struct string_list cmds = STRING_LIST_INIT_NODUP;
 
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

