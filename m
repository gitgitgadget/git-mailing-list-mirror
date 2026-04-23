Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012011.outbound.protection.outlook.com [52.103.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8DE3B3C0D
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908360; cv=fail; b=gopEMIiYjFDHqbgI4Dsufe5Wog8qVyHG+idZZelr4tEu5I124dqNbOnjPgjbPO6C87oKgkbsUdrxOiF59+SpIKtun2Fe9rDF2ZpmHzfNc19qQyfkuXp2O+aDiQ+3FzA3F8mc4VGvX6ilm2H3Vm2Wk2E7bVWsin0uUWldjEnOFsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908360; c=relaxed/simple;
	bh=FuIn1NUQ7dOKmX8iUWRaTbECrWh7/98ZptX8GYGjwsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iBCNWymG+8CixeT9ro1vIsAxyfgmY9gZcAW2RK2+auNXfBSctrVUUMPe7sjRmHbiPe8Th26pMSHZ6MPZ3no2UlRuT0s9Ovr48TECcadJEicqgyyHaERpoGxJQK5lKbNuxdW8GRGBb7+xVtoWz2xmcwVOMwXp4ocdVq9J9Ca/lGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SNI0X9f1; arc=fail smtp.client-ip=52.103.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SNI0X9f1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGahrP/edOtVq/I5wwCE2CzQoWcx9TrfCgbQymCDtJYQkp0z/YS1/zpj4n6L2iqGfAyBkUZhuTlhQkEkqdw+IgI1BnDX6AWLSn6H8+oW6w43OtNTN7Mz0cIr2ZHaCh7n/aEafqtUI67yChEeQuwP5Fbm4/jY0wycmR6ZiEPLsrjbMHGaPbzdgpweSj8W4Pupyhu5sZ/YlKtCCN+xTkAWbqt5448pRJPyIOSADt0Bp1omsNHIyL+7Kfa8H/v8EbxZWwxAQRxDHkVXyR7cJNTED03m27H8GILF7AA2J8f7MyhmhIdwE/KpsfttNwE/gYtyE5+o5B+uR3tHmaIuk5MN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7Ak79Jlqia1r6fAj2L5O1L6sfwvNm/6rDBuuZgw2Rg=;
 b=NFk2WVG7uEY2dAvHpRbg682RSR+MXg7BhIH9VdveStz95iJKL2DCOSCMo8dPh/cNFe4RJecaZsQgGMx8atpZs6aliv36pGIsPicT4y4VGVKjU7/XIMt+6QThATBXdWB+eCOl1dJ8QgvDy0q5OUJf1cubIV/h4qGmeOEEihMmwo+O5Nx924NeTTb/wUWMrhFCpLIX+KZsWZ8mkY4fMMQe4Easa8CBxidShavhOg//sDfrTZqZQM845km9VYniaCP0Iq0n2NcDdgS9kAeqMJw9qRH3l4nradBkam8Os3iqnXCLcLn6oBNn2WjfvXHOuYvflfedNfY1B8eG1YzZEhmv6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7Ak79Jlqia1r6fAj2L5O1L6sfwvNm/6rDBuuZgw2Rg=;
 b=SNI0X9f14NNDR3ECdDZCs6RW858LQmBo2AlfMJkl4P8xyjaSC6DVnk03XUgvW4U/qf19gZhH5uR+dXNxuP8hZ1bl8ncapUR0v1ZkSmJqx+dBgyYR8WeymkaoBL987eQZib865AskoblsPzwrqYK2HD8GO2sIf5hGp5b5KgxiNabZfdVh80KqhADazleXIHIINwVErXf4zWEt4hywvVaY3DhDNKvarmVUkVn01HuPAKIY7Q/HNXr0WnUTwnDBvQpv5DIkLNC2aiJWF8Ve1uVewKNlL5lFMp8Fw1gQZ9TCP7oTgfkNZAab7jCJiC26VO6g4pbJKh84WOlpWtNrhaCGgg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0270.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 01:38:32 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 01:38:31 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v6 08/10] parseopt: enable subcommand autocorrection for git-remote and git-notes
Date: Thu, 23 Apr 2026 10:37:58 +0900
Message-ID:
 <SY0P300MB08014BED919401CACCE547FDCE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260423013800.82156-9-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0270:EE_
X-MS-Office365-Filtering-Correlation-Id: c75a00ae-c3ad-4fae-732a-08dea0d905f4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|41001999006|19110799012|15080799012|8060799015|461199028|5072599009|25031999004|23021999003|10092599007|51005399006|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GUdakyFAu6cqGNIqSwZpyPZs6A1X5/U1eKW9zcHGt5cp18Wx7SlUmsT0byAi?=
 =?us-ascii?Q?FzEhciRutUjvvssl+9yAGn8cNoOIXr1RIYCiqqMtuOjJ5GJi5P/UKlEOn6XY?=
 =?us-ascii?Q?dKNarZHZ7GQE4zzwDYf5l/PvI77racVBlZ8qdx4hHW/TevgHJUyHMuXzgvaA?=
 =?us-ascii?Q?/lio8xmQeWV5jLLUSLkm98AEe15348Vk2cqmeLvbZhEz1dqfrwNdAHnuWhz8?=
 =?us-ascii?Q?xZoizCnXt2IPHBUJDGoWHF14lFwZNz7orhQNu6CYS5P+LALZMRDWpwU9noxj?=
 =?us-ascii?Q?131avmnl4crACiBEySwMcLB5W0J6o8YoGyniw+GvNbKIt+W+M9qzOcmTD+/S?=
 =?us-ascii?Q?QCJbU3gOl8GRfSifdPznkEw2nWcwi6ZgqegeLxBA2VnoQDOUQrSOdCHGKOMH?=
 =?us-ascii?Q?4sTp6TnScp2jshZL+wEHyfK9Vk9E6MHeJLqlTRRT7fUPS9Pc/sJt4WZl3noZ?=
 =?us-ascii?Q?ZkT4LhHhP8KP4AKX51y+5Y+5rgaIkjijvWfxIMC8PSnFryYoni0eXBz19YN9?=
 =?us-ascii?Q?KLX74BvpShAbYX1OCq86kSE6OwS6OsdM2HbaH2kN+a1/18TEMJAMwYRghg1B?=
 =?us-ascii?Q?J8kkN95oYooGCXYNopDbrH4KumnKdRNRgxev6Hz0wOD5wkogwQ7riOF0lpkb?=
 =?us-ascii?Q?81+k/ugytzv7WnF8NLUX2IUSiHK45vJONuEnGDeRvTkqeZnRHwP1ODNh3pht?=
 =?us-ascii?Q?kYcg8lQuWdkYj6qtTX0u3a8KZ5n3O5plxEe4urcLyLf+V1FOQExD32IE9t6w?=
 =?us-ascii?Q?Uhv6HXXH+buGATZaOXnf0etxzO8SiAl6HxpEPFou6kkYUznS5qQNZZXZDIk0?=
 =?us-ascii?Q?ESPuNwRVYfhWOAdqktx8NQG4F7uCl4Zs1R7YPkdVMl6lsdbK2NX3gos6uK3+?=
 =?us-ascii?Q?zZBpQVJ16yRfGVssEcHKnZWefWSUY/pOByaAYcOhI0WUqIXQLadfsSJ9xlTr?=
 =?us-ascii?Q?lAEpSBtmLTrp2YBaQwg2raHzD7RqJsysANi2N2v81j1yw2Vl02VeINRB4xye?=
 =?us-ascii?Q?m2zzVbgKnGsfGH7F88X6T2Bf+G1CmNBJ15vkMchjmLaLrb4pWRyzie6B8bST?=
 =?us-ascii?Q?FhMC7ir43Dwi67suZtzQziNp+pDqRvc3nFE1VqMJY8dwx6GP0YY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A8H1HPksCasrPlL3BynWY8YbZK7jBNjOhGs5EH2Zv/wK0WvG3ueUWKSjO1nk?=
 =?us-ascii?Q?Hf8kKeYXlt0uW/4J5PwR0KeYWZKrSPulndAFE/2XGY830DOnyYSmfd6Cj2hd?=
 =?us-ascii?Q?Y8775h51+g/zZl+9SFfUsgvvft9h8lCD4Ob+uLs2kNP0qv4joCLZFernTqhp?=
 =?us-ascii?Q?k+Oh3imBhNRm0l+yLdXAC5VaZbsscrOkfVKWmZt82vl/meNef+zcaqh4UtML?=
 =?us-ascii?Q?J+48ZVRd25DHeflTOQz8GbMInbtMFtZfs9D6P+vedVBktTmaqzGbfNMdGkGC?=
 =?us-ascii?Q?3yO1YgWc87VQ4vUpRRKgOn5BmUmjTPLDAG5DIQFEFAkXyZTkYz/C9o1ToB/T?=
 =?us-ascii?Q?v1s87oXaAAzmhYUm+tVLm4cemfbwollDWcn60o1k+6+YZ8B0Jz75AbSoJP3f?=
 =?us-ascii?Q?Juq77G/wE0pv4H/1pRi1JKI6kCKRORMWXpW2e6qQhKU2DTQZzujjvUmtM/8j?=
 =?us-ascii?Q?ac1dC9EpxtVTTru9KTzrmKJhayTa+GhhkfMqLtGNCKGRS7gskA0ug4CTWwsl?=
 =?us-ascii?Q?2gEppMThDXCS63mkRfcKPlATYJk3Sajs1UZwey1PP6/e09AfflM6YPlDiBaY?=
 =?us-ascii?Q?tAWMN9gku53J2rDc0M8pv9uquzTjDVwNIqPGYcMb16nWOApVZsIWkVzyZ3ja?=
 =?us-ascii?Q?2ywdAnkrrmfrclMiH2iWcZ0jz/rK4KwhJwUR6Jw/57MZGfdI+fEmq6Sfq15w?=
 =?us-ascii?Q?2XpBilEDfaJzZpnmnefrMrX4JDCmUwpcoZYHPIbfVIO8HEdJTdo0qHXLdhoO?=
 =?us-ascii?Q?+fFyeB9oY5PBXuiMKBfNHx9bbCY50Ty8grKHjTnrJ94vjteJHnhJz/xxAsGw?=
 =?us-ascii?Q?srcd3j+QvVOClAPXyZOEEGnEcwJ0WrsMRLH41Dxe/tdBqQSO+Xsff1Bg8Im0?=
 =?us-ascii?Q?aXvz+/In+G0M+CwzPx5TQUTD2SJYe74n53GlSjm5OAExDg6SUNY1T+AdkyqV?=
 =?us-ascii?Q?+ewuJDaCvL2rf5XkjrwsdwgaJFWFPnmuwpIDewa2O50HALvX+zutuETZ/epC?=
 =?us-ascii?Q?aeQKILoT6MAsLd0wsNfyRFjh8sciANK6cJklo5PrAmUz+9EJcSN2nXdfZ2Xe?=
 =?us-ascii?Q?EZCpA7k+UVXelT3ESDbRTE/RQvbS2uC9YUN6TG5SJJGoae7XcL1EfGH7vWgK?=
 =?us-ascii?Q?cYom7wAVXqfdWUHVGgTPvnFcOyQVu7A6X52yvRbv0hKovycQZd1jKoQeP9fM?=
 =?us-ascii?Q?Ybs+W1CME/uwxzcBWLWnIoEKIRBjPyP287Plax1Iqs4cMj/l/k66AsFIS3Tq?=
 =?us-ascii?Q?nux7c8r+XXn7f8M8sDsg2Kc5PZNYcaYt/qbu/ZcUdIuRWkP18QG93aUa/vN6?=
 =?us-ascii?Q?4Okr1iCJEGd2IcixpP+vWniJ3Kcy6/6A2lG4wbLc9EqXO27W3egC7Q1u3O6D?=
 =?us-ascii?Q?oOCO2WWzpUvx+F3qKFnzfnFWFqxP?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75a00ae-c3ad-4fae-732a-08dea0d905f4
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:38:31.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0270

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
index 4370d9c623e4..d60e7bd3c977 100644
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
2.54.0

