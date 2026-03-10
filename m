Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010001.outbound.protection.outlook.com [52.103.73.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DE3389479
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142895; cv=fail; b=tEG9AB7gRk0KyEhL0ssszfH/5oC15XX/NBZluIQajQn/GJEiim66N5GYDFKsRJgCeAcbkQxT2N3QOR0SpPE7Gjgr1CRvjOijrAv3aUiPwY4CjG2WGwKPsNAcApr4CYKPXFVhX9ZwL4ufhNR8tKK1AbA3lGvd3HyIpRE43TMKSvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142895; c=relaxed/simple;
	bh=hpj+k+fTTrj23x3chR+oabMlIwlc3okVwjJpEmGgrzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J4PA7SIA6w9KhBk+/b34DKLGLBvzA0O3kWX/xbI/hfaXl1Jz2CgGEh5UkZzZeVELfNkfxBeaGPuwDSbVu4pqOiuJrjoTis9x0TOsBXGFUMVNsBTJ/2TcVZtHoSJUQhPt6siyFuUFGTlUoqhPdOXd1mOUUedF/7FW1dYj8AaH1zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=clYFjRRK; arc=fail smtp.client-ip=52.103.73.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="clYFjRRK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyAao16EPZlS4ZFISvfrFUCsRIaSx8Z9yCBIpimvzisYTh1P3DC6hAV2TuQ51i/Tv4OxSWSZTr36qFoxh/uEnXrfjW+FcVNZre3JGw5VdYsZ12BWyGhV1NteR1C6lT+UUBow2xuj9RMGI3KfYtn4V3zhEEFagsJMD/tDLrWjgf3iWx7qZSBQTdTvAV7wT6+ZGjBa1bY+TAbIWPk9QRWEZNejJ6ht5E3ociYOiEkGpMeziX7wUGfx9oMVbL3WXjVzWH3Wjxfbiz9Qe/skxIGwP6bz3UX4rOXD8K5YLBIig/m1cv4mS3THY4VvGF38Qrz6VRpCFQygrvX1LtadpKtufg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl40C+7Osrzs7FG2hDTNtYLMfCyQju1sjIvr8hyrYXM=;
 b=LAVOj4ulHQGEq/IzEVrO99OasXo420B+HxN++lQoziQZOeeHapnhqe7ajbrW/KhdBVwAvwVskdk0L+YBOasfF8jbCbxuQEk6rNavrIYnMIVrZcFj5MEUk7XHG54h9P1w422PNd13zXDNEDhb1JpxxQ9kbNsKmlg0coEPv33PUZwPQJNq1X+5iNWPv77MEHjJNhWJGfSyr7Y40Vy+r0Cs7Z4P7qG3vck0Pkz3sY4Hb929GAk9Sg4LAgbkbp2QyGRvnQc7TpG3qBkZHE36nC2nSosISOi9EkIEehDJuux0RaVBhDDwiq53er69SQ0Btzsi0nodg76C+LvCkflWEaRL0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl40C+7Osrzs7FG2hDTNtYLMfCyQju1sjIvr8hyrYXM=;
 b=clYFjRRKUKQLr7xbOd2jD+zMO3p1h++W8TblD9b7QhZoTZR89LxAOMhs/NXsTq6SylMtBWHLlabOXtkl+TrZ1V68e+XKPt+ICZ4LIpfbXvo+BWd8p10KwGw9ZvTzU99DFJOzX+XYXfXgfJ3IkQFwqGJqQqix3l+CXIrbygz3ltLtEjGHMVObmIi7RwUk/upmMC3JmkL+dJ5fZbDeyyaU/9jOexKMzfkBz37J7wACATW4BLUw5g6Aj59i/BakA3ELQLkTW1hN+5+F8f0h5mm1xL/vSnSAF2qE3q7AA5uTww/bsV7UHuD0PdOv4KNEeZNS9Y0o+owS3JtVRKHQI6PEUQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB1392.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:41:25 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 11:41:25 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v3 7/8] parseopt: enable subcommand autocorrection for git-remote and git-notes
Date: Tue, 10 Mar 2026 20:41:06 +0900
Message-ID:
 <SY0P300MB0801CB7831295EE02F733063CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260310114107.1086103-8-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 50993438-9f0e-4bde-6e43-08de7e99f58d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|51005399006|19110799012|8060799015|41001999006|10092599007|25031999004|23021999003|15080799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DO9RAjQHMuHiK2qcRg1bvHx3j2MhWQoAUXaYm1K21wkt5z7NOHAOKqahXHce?=
 =?us-ascii?Q?VhTIHu09yp3VQDtw/e5ZfzQTVGVLa0pT5qi5Ky3uWxqacmTkRi0KNmqZThYa?=
 =?us-ascii?Q?/8O16S90GFlBVaUWz1tYlh0nWNczZbvo04lM4pZUKMmE+ilhljJ1IGdTiXho?=
 =?us-ascii?Q?fqYKWEx2bXWpvItKCGgLGT0QTU1g5WvGL6/2cpw8/FblJkjnM6fkmsAs2+mN?=
 =?us-ascii?Q?IzxLdKiP1m/V/zHGn7+b0UpRR858bTm2otN4m3O/bDUrWkEXkiASbKz/gPCH?=
 =?us-ascii?Q?jsnr4b+CRyvn0XYI5CmyGKbhnOL/Wgi1AUEC60Tb2mstC1WZljQbSYkfXzsV?=
 =?us-ascii?Q?xQpYGarznOBPkQc+TE7lVUY6vwIUMlGy7ztHTGRG0gEY4IoWvmba3IN/TAF9?=
 =?us-ascii?Q?laNZKLSu3EqHsMaKl8AE2/sBSiD/rZFOTZqn/l4jJ/weZHGLGO/+ASIFwSW4?=
 =?us-ascii?Q?9T3+W/PWygcN15vwIdoBhM15DcYQzGhONeQR9lzbzIQQv5qJO/Bw8297Arv/?=
 =?us-ascii?Q?skAR4vCNDZ7GbIk4XQX4380i7ze1mf4U4uPLQ/COmhbSAFJn/bz4HTJKe9IT?=
 =?us-ascii?Q?DyjdaWCOgzLxEA+azaRFHhB5Aizhup4p5IcSDH6LOPILaTTh7cThejk4NWy8?=
 =?us-ascii?Q?P+cSg5L59+A5IAlETcC+rLN3Ky5T27mZUSt0dyF9d8rlPrZ7KFpqTgYvrtlw?=
 =?us-ascii?Q?DI+5G779WmpJ295ftqTuwWGbQHaVF/H1lY5iFAJlNX9BwXeovjPHW7kwO96c?=
 =?us-ascii?Q?zWIuVnx+mWN1IUv7C/YQ9q5nE7nq6RY/OyCzUom3fh4maA+DMJssIHq2oyJ4?=
 =?us-ascii?Q?Y7c3gpqPlNF8TE7ZAyF0P/14CCxNTVL7wMZccZT01lRFIDwo81DqByHn02FL?=
 =?us-ascii?Q?bbQTGg8WX8eItKkOoxLJxhuGAi75YWq8TaSuyJeeS5BKMK6dZw2SDWr4Z8/9?=
 =?us-ascii?Q?33Xx8eFz3ZJ10ZfkBiIzUvSKbwsq44/0vDzxTThyMxXkM5rqae0ajOPPBhnr?=
 =?us-ascii?Q?NAavXwR50+AWT8/vFzAkr+VyUTngiiDVVFak29q+Njn/HIc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z5LPN1mkgMfha6Ef3VpyRJYB8JjhwNu3A4suWy0Y0RSl9hxpaElUD1mRw4Pr?=
 =?us-ascii?Q?Q2q2i9t2wYNVjKI60q2BIPRaJDOBt0PVoV75Qn9NMQnKcOVKBJ0vCSo25yul?=
 =?us-ascii?Q?axV3yfL1azolJ9+RebgBa31rd0hnY3/6XiyyWElWka48jKeFhM8yIRF+YEFW?=
 =?us-ascii?Q?S9ym1iSnjrpNNOczc+XXc27sbYghjnmpyaH9NpQefVlO3djkV+rLfqOEQ5Uc?=
 =?us-ascii?Q?3hwgPgXKs1GCgenckqp0UBB+LSWSczvzO+hANhYf3PrOtK4V+rrdGjRfBxBa?=
 =?us-ascii?Q?gJKdp93DMNzAt1bmNoG4divSACn54UgMJDnlAeih3hsa3Gerb0CU1dhZl5Sq?=
 =?us-ascii?Q?Zk4g55dVSL6qNUHw1Mwutyl0KUShZMx9VzUyfaq1SVU80/o0lqA5iROYC/K+?=
 =?us-ascii?Q?xih5llrboRZJhWCaMXtZP+oHMkGi7NQZCuXTF62aKLyBopHNa2bcn9uD/UBw?=
 =?us-ascii?Q?zQ+FHVrTWuqfRQtJgwBgQc8HvmRNn4g5kb1RqxSa4mvBwhEf3MNjXXZp0sha?=
 =?us-ascii?Q?Wdc0PNr/fr9rJ9xTIr+4sBznAj+Yp1AyURMI/5zYnm0qGbr/9oAwgRy96tOA?=
 =?us-ascii?Q?79PdZiaSXJcN2F7FGRG0OlYYVqyzPgcmtQFEiMxcLRls4it9IVezh84kInPu?=
 =?us-ascii?Q?j0f7mPaC+PbaWeS5jMB94W1piIc8GcujG4SCVIyGNvD5LXy86Ku7RdNYVPcN?=
 =?us-ascii?Q?ZingsXu1jecUd5KReq0XX/Gf6GbGlpI1dXxgTzXaEeAix78YuSmBiu9D27kN?=
 =?us-ascii?Q?YYu8RHLw8dlwVBnch0EGZ5e36Cb4BP0fwtTANM+yefqO/vFefGWQBePeByBF?=
 =?us-ascii?Q?vK0UYdlujS3AHnGpLveprAFDNKp3J1ifMOhVkxDdpGVEvqsYVeV2s/jPTVoG?=
 =?us-ascii?Q?KRpiLiH1sjgOgewZD8N4gZ1KOFUCCeG+BwgrK8vyPzWt2VC0LuQbW+vnPFp1?=
 =?us-ascii?Q?xDNjKKA2eRupHLdqbkVi6n1OQDiPInfce0N46AUcoUNZLTyvk6idLdZsVVAJ?=
 =?us-ascii?Q?bTaWw4ZUp+N8OIo2wsonxnk00EK9G3mOvzDl+pzbhIbP4iA2Brkjz5FijRq7?=
 =?us-ascii?Q?4qU/tqE553OUKADGWAbxdSpZyaUjLq0U39A0kHxfthIRiDfUhSZ8sJrTrZeZ?=
 =?us-ascii?Q?Gtd22muoUKE3cUXsrndx4O3oeROf131V2dJikI/n3V5/ZbFUiIjLKpsSGbul?=
 =?us-ascii?Q?ERk9bKfJRFHkx0TCzglFtp8VDBK4ClGaQWI/Aey7SlfOXhMev5Q7gUPOkUE5?=
 =?us-ascii?Q?Lg3dYff1sBxd0NG1SKoXdB+Uka25ccE4sAIErjVdDk8yChdhzDAmYfjAx46S?=
 =?us-ascii?Q?7TxP7Nu6XDBRNqOt2KwHq6VcCgx+ihE9ozZfh0YpmFuKln728vjO2JmFrZyU?=
 =?us-ascii?Q?17LI0ZFcGBDZzbwsCtfDIn8T/EJP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50993438-9f0e-4bde-6e43-08de7e99f58d
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:41:24.9758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1392

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
Changes in v3:
  - Improve commit message

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
index 227bc7499115..6ac4bd30e23b 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -693,14 +693,16 @@ static enum parse_opt_result handle_subcommand(struct parse_opt_ctx_t *ctx,
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

