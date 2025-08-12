Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA5A264A65
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 06:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981115; cv=fail; b=WFRdsy6oAPCSLn2e2UtVJ5wIWdIY3wYiEDIr4sLNvKBT+4EpBgwS0L/6n2JWnKEUPu+0g0kcNeS843JanO1cuVkKsVeXwxfk6LTapSUZtO5bZvYEUu33tO+Z9OeQZ0snvbBDgJ9uTmJHsfHl6ge0YTOcCEvueF8Ul50/yGvZjTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981115; c=relaxed/simple;
	bh=jfmOX/nvDytMnBIhXWO4q6ZJDXBi1TeL0dbZE9Dt5Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mBBwCVyVX6iFtqar7UVzgnviqDPgBHoqOY3bT8psVzE8p5mId/J0iGnUTYJXOqO49RGqef8Xd/nS6cdoeuxFhXygEs5mMVukQUYfgQjDM3Lr9LZ/ar/Gl+2271YTOd7/uRBlbrdXqxW7dCeNwCN4titb0np5CZ0mg8fy4w7/LTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=nLie6KUj; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="nLie6KUj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlHAYCO+FK7WmFifdAvF/nWVwK4ow6aScZ4KlMFUwJ1pcdtBA0PHy7IUFKO1rNEXQ8N587A2NGcUuZqNZ68Jg051WoQDKS3uxfObcV54HTBGHTagjciFEtRKJXH3HmgbTp1XcKUAngueyFsLrOfTw9JZ+56wdwyDT1MhrRI3fQsZdxcC0Rv2CvxgBCcVULYwdeXTE39LoXKAowQMJDt6I4hHWdOk4h0T+5G26a2uySNvd5kiUNz6I3xgGaXDHf3DdXdtuLeQBS4KlmMmakD66fpWuMAVkkrN+mYiEL3E9ircap8U2PuL+Dz8rtjtAL9YANKv2rJbEVtORt6Qt2XI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNWQbY9wfJgvvvYUd7vzu96niVtAGeRRofu9SnkS55E=;
 b=i/AW9Hg5ba57srupW6ZQll+VLgMYbkk4M2qCsp4mKEqnDrNb4g6jXg6Lb2qcyHTpOe2BBUmude/Rj6Hp+xYN/XetxiM4VXMzb9oF74rY5maY2WFQFCZyJL30Fa1VLJritqA25T8qXsparEy+sqivvM0yrQwX98JVjE2NraJO/BvN27bjZ75LWjkQudDvc9WQBdQc1ZOpZbKFfSjMOL2VDCIkTM9b98t2OJRUFtEHlGaecnIdj3Kqpk2A5gb6sk8ES+jay6NMguvCzSo9cZAFbfMx0kaDZ/XY0NotZ6uVuY6fWCNHz2NzGk+GAR2wRBKivwD8bYePV1IDFfjTS9PUuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNWQbY9wfJgvvvYUd7vzu96niVtAGeRRofu9SnkS55E=;
 b=nLie6KUji83bfuU/aVqaWAqFdYz4y+u7Vp62Z883ava7LW4V9k7ajheSrLRobIngGfUAfWLfd4FofKURb33H+7hDLmDqRJLWhixLJOt8mi/BTaOcWTy67V+L3eTT6o1jUUgfM/6cjyfnh5bByLx5sIfTmshQrZHut5Y2GUsf0KJJjPJUkfLI4ZCKWofcLAg14+RU8g4+CTZKBIAon1fLN/06Z+GaUkRJcj3jVjYOBfZR2na9IuBZ1PYIlXd7ZhZbvFMlolp4EnDe+KG8ylxpjaIJMCh1i0SyptsywT7l1fzlawZdhonJQksPER6MpoQZ401qC9VXUAes6WGQaV/XJQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB10175.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 06:45:05 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 06:45:05 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v5 2/2] send-email: enable copying emails to an IMAP folder without actually sending them
Date: Tue, 12 Aug 2025 06:44:36 +0000
Message-ID:
 <PN3PR01MB95976EFF4DA2B0BB479E2113B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <PN3PR01MB9597E8E33868386C997D2563B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
 <PN3PR01MB9597E8E33868386C997D2563B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0190.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::19) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250812064436.9643-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB10175:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c0bbf9b-a8ea-4e02-cc88-08ddd96bc4ac
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|461199028|5072599009|15080799012|3412199025|40105399003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1lmw84ThpP3WvVJccDjK74iI9MRRVhncH9Diz+/f9DN92yq9et/aLXDIBz5r?=
 =?us-ascii?Q?yW+4tYUWheZWgJrjLRWJ+BS6knSoipI0W36EzbffCZI/dWd0jQ8/Mu1SnETz?=
 =?us-ascii?Q?RaZHv0teODnsMT9prsj8EhghfZKm5wcRFV86yaozfxaVamkMlknqpU9yLH6/?=
 =?us-ascii?Q?ItMG254d85qVpQ4vlyV2lfDMHnrc2O2jOQE49fRE0BZwIFAkFbTlnrrrt13p?=
 =?us-ascii?Q?uQ48y8tovFytWINIGs67GkWb9zc4poDGNqzJ68ZQpWERQ5bN/CUHkdcs1H4d?=
 =?us-ascii?Q?hBr8hgBBSjHiI2Neh2rThQQONWw+Qh1kFZAl6rhnbr3xED5HA/MZIZWcV8vo?=
 =?us-ascii?Q?eEo6CWq9fN689T0jUA6X6DPBfev2VileDA2qfkvquvvXjEpu0nxLvMJiRE6w?=
 =?us-ascii?Q?2DSa27LH1qBcN2QRA5BYZlniOy4t5JxkQz9dNZVpBuzkApLAi0689B+/+Xg4?=
 =?us-ascii?Q?U8KhDRa27SxZ9MbEEmZEbAn1oGBnZkKz6+WUVXWAZ6fTOSlvlgq85CGuqc6i?=
 =?us-ascii?Q?fWhcWyZc7JD+ALrtTO5CZTo9Yxz2bps37mwFadhLIomLjJoG9lr4kNEOZ89n?=
 =?us-ascii?Q?fqie8kG/3t+WKK9Ar4wB/jZnHLmyCnVCU8nAQlSXKDHeA7kgVz1mThofS6vQ?=
 =?us-ascii?Q?6z7sSH4JCfUzLJawne3DBr6u61WgiSsNZfUZm9zcWWdUvP//Gm+fs6ahc8GO?=
 =?us-ascii?Q?xmKVEvx/jgkI1VfjdAIFpzAekcFAnVt4vhzNpmahL86Lr9He/jeqd/Ddj8Ei?=
 =?us-ascii?Q?LLD8iX9COSPRbX8zoIm0iA1rXtFyPO/0ly6SRT48E6PKcnZx2nMCNNZHsQhx?=
 =?us-ascii?Q?R+/WSpne9z3obm+c82KNDELtp3vcl/91cllwPM90HUFrVN8x2HeOUbGG2SPA?=
 =?us-ascii?Q?1xNJfVHNBroQF1qzdKhhbAlDY/30j6tAZf6fmaM6rOKH9H+8CFI+CfWtEdA0?=
 =?us-ascii?Q?W42+pJshEnKRAxRLyN48S39Tx+XP/mgYnxIMV/vCVch6Pn0zwU4ZnOFmEaSy?=
 =?us-ascii?Q?m+Oh+yolk8ZnI8HS/KbcgH6/F7Zv8BV2Vsngs9JiAgd79sxwLxgPGzzbuTUb?=
 =?us-ascii?Q?bfyC7rxPW1M7gdZW9rDO1b5C2gowfYNNIO/pF4HOkJTSjOnctVgE+5Vq1EL7?=
 =?us-ascii?Q?MK0kEeo9A8Cp?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dt1wW0VSssjNA7qH/kbooJ9niiMdRbMuoCojxbwgpnijH7lAaeePwkvJ8h0M?=
 =?us-ascii?Q?t6w8UcqYEdFxyNmu5DvFrt7xa3aNmuDU6LEaDcuMI30Z23YDq8DzibJXLPbH?=
 =?us-ascii?Q?WrD+02abM6C5j5m5HQRoFC5mcFY+GYYHd9wzlehKsH4mNSwN3FgILGNr46Tl?=
 =?us-ascii?Q?0Ecw3E2EI1ZN6gagu7q2ioHjSrQYDQd1OK0P+k6Nz/ZlHyhTFvehe3LM034K?=
 =?us-ascii?Q?mVbCKmM+wdtACrwd8ojvgSHa18lVOjhf2HdruzOpvAElcGUpJcJpJbA7Fa9n?=
 =?us-ascii?Q?9I4Pn2j9uRf5connzMstkVFn3DOEPqmPWr9qwpqajJSJqqv8iYIIN84LI7BF?=
 =?us-ascii?Q?5PyBeI1e5GOxo2AIUJqD9DH/fiIFqSiLpWHlkDahlxxOgYAjVMyhqHOfC8G1?=
 =?us-ascii?Q?jG7Q/ZOzhFPZ06N47lgne89SBdGXlq9y5o+rlEJmwzMCbxu0RSPkqiNrgUMo?=
 =?us-ascii?Q?Memhll1SLMRB/3r+AA98TUW2P9TA2wTNqIWE2/ZCr8y6NspK/p+KEF5jSFk5?=
 =?us-ascii?Q?hGAZvjuqDqAGGENDCDfEqQyNUpQYv86VhhmXl1sXnereQyMfA8GA1QgQuIMK?=
 =?us-ascii?Q?lIwGAIJcJ/ftEyxO0OZBzF4LtsFzBHzTLsdhDHDe0Us4+mvguPIyVk6+ATOq?=
 =?us-ascii?Q?eb+UKAJhn3XuIO12AkXFPf8vBMrIuPc8hr4veGLCVy5kb4r8KGRfnVFe9/6m?=
 =?us-ascii?Q?MFv/2n+HSI1pZGHzFX7MAw3b1iTD8pQIe58xkWo8KWfaKEb0N8JslTihDU/P?=
 =?us-ascii?Q?FN98zbgWPzg30SNaFWdRrZTXDFqkuMvG4Pj2zPi8LWCOK8NXUwIxlzprgpmK?=
 =?us-ascii?Q?eaVJl6PFTNBTUfasJ9i7tMm/dutxD+4IL+ZuyQHYY1UJOI/xBInP20j56fRe?=
 =?us-ascii?Q?OuivHt1lf+n3SqZGaH1ooPBel8qsX+QiJn7aD5EPbPWOVgs7L7i1/m15iUFp?=
 =?us-ascii?Q?Jrsqy3gTlkt8aBbRmf4PqqeRFO9e3sshO9Zesge9Bzvofs5zZBR+8OFjl0vk?=
 =?us-ascii?Q?X2sZHsN60z/kumGnkIvzBVdkgc6xdRz0UhrUjbE8sPbd11yCc5K+dBk05NP2?=
 =?us-ascii?Q?Du33lzq3dyEmUS2m65oxfzDizLzXmMLpjgjIQQBWSfkjsO32PO38db/1GK5l?=
 =?us-ascii?Q?l+XQrFIDoZN1lkHH0ii3zrZifqUrJwobzWRrq85s80Q61JNmDuaQS4r9831j?=
 =?us-ascii?Q?gv3DSCm/UN7EOz0HSh4Kroel/K9BEcvXLe0O1W9Dkvyg5Ki9KqETN7x4B6k?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0bbf9b-a8ea-4e02-cc88-08ddd96bc4ac
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 06:45:04.3484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10175

`git imap-send` was built on the idea of copying emails to an IMAP folder
like drafts, and sending them later using an email client. Currently
the only way to do it is by piping output of `git format-patch` to IMAP
send.

Add another way to do it by using `git send-email` with the
`--use-imap-only` or `sendmail.useImapOnly` option. This allows users to
use the advanced features of `git send-email` like tweaking Cc: list
programmatically, compose the cover letter, etc. and then send the well
formatted emails to an IMAP folder using `git imap-send`.

While at it, use `` instead of '' for --smtp-encryption ssl in help
section of `git send-email`.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/sendemail.adoc |  1 +
 Documentation/git-send-email.adoc   | 14 ++++++++++++++
 git-send-email.perl                 |  9 ++++++++-
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/sendemail.adoc b/Documentation/config/sendemail.adoc
index dd2dbc87a0..90164c734d 100644
--- a/Documentation/config/sendemail.adoc
+++ b/Documentation/config/sendemail.adoc
@@ -89,6 +89,7 @@ sendemail.smtpServerPort::
 sendemail.smtpServerOption::
 sendemail.smtpUser::
 sendemail.imapSentFolder::
+sendemail.useImapOnly::
 sendemail.thread::
 sendemail.transferEncoding::
 sendemail.validate::
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index d1c41a0dbd..a385f865fb 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -311,6 +311,20 @@ must be used for each option.
 This feature requires setting up `git imap-send`. See linkgit:git-imap-send[1]
 for instructions.
 
+--use-imap-only::
+--no-use-imap-only::
+	If this is set, all emails will only be copied to the IMAP folder specified
+	with `--imap-sent-folder` or `sendemail.imapSentFolder` and will not be sent
+	to the recipients. Useful if you just want to create a draft of the emails
+	and use another email client to send them.
+	If disabled with `--no-use-imap-only`, the emails will be sent like usual.
+	Disabled by default, but the `sendemail.useImapOnly` configuration
+	variable can be used to enable it.
+
++
+This feature requires setting up `git imap-send`. See linkgit:git-imap-send[1]
+for instructions.
+
 --batch-size=<num>::
 	Some email servers (e.g. 'smtp.163.com') limit the number of emails to be
 	sent per session (connection) and this will lead to a failure when
diff --git a/git-send-email.perl b/git-send-email.perl
index b3cc237baa..96504e7be1 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -62,7 +62,7 @@ sub usage {
     --smtp-user             <str>  * Username for SMTP-AUTH.
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
     --smtp-encryption       <str>  * tls or ssl; anything else disables.
-    --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
+    --smtp-ssl                     * Deprecated. Use `--smtp-encryption ssl`.
     --smtp-ssl-cert-path    <str>  * Path to ca-certificates (either directory or file).
                                      Pass an empty string to disable certificate
                                      verification.
@@ -75,6 +75,8 @@ sub usage {
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
     --imap-sent-folder      <str>  * IMAP folder where a copy of the emails should be sent.
                                      Make sure `git imap-send` is set up to use this feature.
+    --[no-]use-imap-only           * Only copy emails to the IMAP folder specified by
+                                     `--imap-sent-folder` instead of actually sending them.
 
     --batch-size            <int>  * send max <int> message per connection.
     --relogin-delay         <int>  * delay <int> seconds between two successive login.
@@ -296,6 +298,7 @@ sub do_edit {
 my $target_xfer_encoding = 'auto';
 my $forbid_sendmail_variables = 1;
 my $outlook_id_fix = 'auto';
+my $use_imap_only = 0;
 
 my %config_bool_settings = (
     "thread" => \$thread,
@@ -312,6 +315,7 @@ sub do_edit {
     "forbidsendmailvariables" => \$forbid_sendmail_variables,
     "mailmap" => \$mailmap,
     "outlookidfix" => \$outlook_id_fix,
+    "useimaponly" => \$use_imap_only,
 );
 
 my %config_settings = (
@@ -532,6 +536,7 @@ sub config_regexp {
 		    "smtp-auth=s" => \$smtp_auth,
 		    "no-smtp-auth" => sub {$smtp_auth = 'none'},
 		    "imap-sent-folder=s" => \$imap_sent_folder,
+		    "use-imap-only!" => \$use_imap_only,
 		    "annotate!" => \$annotate,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
@@ -1683,6 +1688,8 @@ sub send_message {
 
 	if ($dry_run) {
 		# We don't want to send the email.
+	} elsif ($use_imap_only) {
+		die __("The destination IMAP folder is not properly defined.") if !defined $imap_sent_folder;
 	} elsif (defined $sendmail_cmd || file_name_is_absolute($smtp_server)) {
 		my $pid = open my $sm, '|-';
 		defined $pid or die $!;
-- 
2.50.1

