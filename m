Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010002.outbound.protection.outlook.com [52.103.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461C287271
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266881; cv=fail; b=CfxJo93fLv2z0ZOAk8yrW4XNPxzbM9cTZc7x13ubby0hOcgQwFqnuVFQt13IvJm/XoV2li1qoJtqoRHF/5t+HL7A+vHJ1Z7PKDYz7E/kpitsU8GjwW6msXXL8dckQnDxBNdEaFLDmgjXHrGAGIvFiGgBTlvF0wqJZp+PEMkky0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266881; c=relaxed/simple;
	bh=eizufZ0k7AhSVpAml1EuuKu4MF+ECYfYGFN3RC+XSSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oYm++UdhRtSqBKOhi5SD5YM70BU9W6TRuQTXtQe90CtOx+cY9rAinB6ya3loXhHFuf5aiF7fBzLyx3wrj5xd5Wfua7uoPg/ujovZH8MnBvSpqtGz/o8xW/R/VSyNcZgq6H6h+J89TgEecYKRR7BX5I8JM2LSSVQHZ1SKI2pchrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=O1K4dm6P; arc=fail smtp.client-ip=52.103.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="O1K4dm6P"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymqh9I0ooA9B0p7iIYEmCp0r7x9yxlSfsdwE8BFR0ReUl1PJtOETxfBYX/ZaOk7e/Q0zaD//yBaMgHbhxaFCU8Y1LSxbAXsCddYlu902E8ebyceFqNqLLTHUmp7IY82n702WEuKpazZtU0RXs/E0GdDvRORLSBd6P3jf2MOc35Qz2RqeZ1sIDDUEeLW1umRR1JwzgmmO3NEsM2VBjaguz9AD9qqB29rwX61DfU+7+5KakSmBaOz09R/9+7bfN5vgoHMMzxI0GOfB6fqjX/eLjOQRtb4loSjYAnJlV3baUKCeHlolXXlvSEyhpw7zqjLeNxfCAh7nvppX2ZvVMiSTZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kZ6fSAuD2ajVdPntXxTiz1or2zD8Dhg0EH79OCXFBE=;
 b=LSyMWgFEaBVTsIlpX5f1EddXfmSBIvGKehcq7EhSBCEnCvry92j2g14aU/wPlp44+RtASVoZcVJPdUvNmTj/8EkrheXOue+o4IqSmoPjjq6DdBpuyLa+qTfa3/SrLaayViQBlFpLeAoL9yQWgMeNSNkGZvN0U3fzuCQKff9ypZ2y9sZQDCH8j39Hv2NPULB1RlC6Gk0Xmbs9L/Wtfmp7vJbrelqaHYAzfLr4tA0pQdhZ4mcd6chatX4yQ9vXbFESnCUcX6ejWnQQ8fFOx0OOtdmbGSD2YxWP8xz5qtN3IXoHRQCiDt9roA1BnooUpjzvTbj3wHzjG0++uPoU6Hykiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kZ6fSAuD2ajVdPntXxTiz1or2zD8Dhg0EH79OCXFBE=;
 b=O1K4dm6PrcCZZtvGIzoMa6t6HO435yjF/NktNn6+0/uzTWYp+84da4g9duaw2uEDAGBW4R0uXgceptor1tQJTKGZSWGLVllr7/CQQyDQfrXu/rRmE3YrC/SwghNI+wQccKV0CY+nBiK/XUAeZTtOJXfpokOWsTS4guhZq0VfFp7u15aCS5dFqbpLt/zTZ40nlROigRAxEyAFGRbiqEBuz6ggNba8PJ9un16sFkghSiMAADbmTsnKQxsFpUd971YOMaJDbRsxqKXLhF0qv76ouMp2b1SMKTGs92OiJ/jGPmMihYEitA2Q08mjBC1gOjPjPaqULKIayKBm/cDUkHfLAA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7838.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 10:34:28 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 10:34:28 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 2/2] send-email: enable copying emails to IMAP folder without actually sending them
Date: Wed, 23 Jul 2025 16:03:51 +0530
Message-ID:
 <PN3PR01MB95972CAE853F4079F0F62F0AB85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1.320.g2ad311502d
In-Reply-To: <PN3PR01MB9597EC4C5DF97943587AEEB4B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
 <PN3PR01MB9597EC4C5DF97943587AEEB4B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::15) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250723103351.17560-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbddaba-d31d-4f84-8ecc-08ddc9d48028
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|8060799015|15080799012|19110799012|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5FsLSEUflZqxWBY5i/Wv05+7TLEjWCg7I4mfytLzQaR168zbXYLGy/sKP7o6?=
 =?us-ascii?Q?ROi3ys9gorPCHUpZVkEHK8qRDyvyIDVd/9pXk8SBC8YZJZFaEAyF2D8V3uLK?=
 =?us-ascii?Q?b/leDaGKm8DAFEcv7ojBfWYSA/nj4F5QGUwzDRt5l9JZ3wUla/wYigNYauuh?=
 =?us-ascii?Q?0ebFnsXeC7jgsOjOOIFFhoILQotPz6JZOb3fD1bI85OGxOMTpPMIE6lA7pBy?=
 =?us-ascii?Q?2m+vLgWX6GMoccPRTjLBcLEml+rP4eq4fVCwslCpSCXAy4cVxb7+L+rmesZ/?=
 =?us-ascii?Q?aIHy3ymDdFIbVQX2LrvUHxGGwz2pKGonUBGUeXOL+d1yvR0NUpiTGGOZC0fa?=
 =?us-ascii?Q?0L8rWErLoJCFzB8jjMEVAZYL7nd070OqmqDB2DHVbgXy6z58GHwdMuQYsI11?=
 =?us-ascii?Q?PY4kjNc+U7LoVwrMitZTc5hyj06h0p1KnIemIKAlRtduycuHmg+ruDB7GxxF?=
 =?us-ascii?Q?He++wSqBs7KsbxajX+dbuOrlJxNvQyd7mfVbvOlR4b5JSK6fgCEZpbX5ugef?=
 =?us-ascii?Q?3tuUPDxp4sc0cLDURsb/tnLvRsCk/alNriPbhuklJSgUVr90EKEEN1hxCC5N?=
 =?us-ascii?Q?ILeWKNbxrhkUuDJZ0J9SUjU4Dtr1dZzMRYQrLvgBG4ijhw1VIefi3fzvtVUz?=
 =?us-ascii?Q?UoNOQEHOcK/lWpyTFc4wgYTpS95OxYK1b7f/I/EnwkZ67bLsIiWUzs0ZK5E8?=
 =?us-ascii?Q?wU+yKVRbBdCmrRJHr1jIchgkzT3idQmmNz/8Z52PvHMRhArUmv0BpAvtQ3Nm?=
 =?us-ascii?Q?Rpom8NhRBZlV3znWmEG8TsVaX0N0kTXhNimHsHUde82+GqHUxSSgfTXYaFwL?=
 =?us-ascii?Q?05pl2LBSZtQwS/Ivl6c/LsLsp6viSNiPfLWWmqSUsKnWPQjgprUS1zaAogM5?=
 =?us-ascii?Q?dC9JYFPEvPaeeJkTQs/ujBCD2/ZEq8K1FBkYRcGYFC5iGX3nk62so/brvruU?=
 =?us-ascii?Q?J8hyob6kYoD4evNQ6W9iOSpHoucsvWi3YtgrrSgMs9ou3H/cn5/BdAUw2mmg?=
 =?us-ascii?Q?NpdAs3ClZhtAy+dxX8Ev4MPwabbCgM1W/1CQnpgsQ7pT51rwhCHst0nIQMh4?=
 =?us-ascii?Q?c2+Sh8QCMVmFCRJcha9sr0nDYpMl9x/2WRc71UydX+Z7zKfMW1TnSck074x1?=
 =?us-ascii?Q?Z/GN2eqrd25s?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ddxCWV1b8N25tnACJM8gFYRspvNPJiGqaZ5L8w5RBnoAJNJNvod02ZhLljmr?=
 =?us-ascii?Q?ul4coCHHUsr2NwkkWG/fCN8dRWuE+ceUcGJ6lcYz0Erx5aYeoZHQz3mYe0ce?=
 =?us-ascii?Q?uO4JA1CYSespLcQ8mwgOHyljck0j97JvLMZKOEJK1CRS1RxStfWrogPKYCP2?=
 =?us-ascii?Q?5TuhK2kDCp3iZzLDCKtXOJ3oEZNHaYZJG5xUk467w50XmIEgSahumJmN5AR4?=
 =?us-ascii?Q?ld+x6sUr8GXNcoZy45xFhp/rDW5xbgepdvR5Xe7c3y5gy6jN685JvMD3RIA6?=
 =?us-ascii?Q?q+XacfTRO9/zQINa+8xpdaZfyxZ2e2uQJ7ieNTgXy+LQa+SC8tJFZ72+0YGs?=
 =?us-ascii?Q?bTLTS07p0TQKmAv6xSpBaeXmI99BZPoeByQ6N/CyU81DG40bi3Y00MfzJqXj?=
 =?us-ascii?Q?wiEJ49XlFqBQ0l3J6ViX4gY9A3aoRPEmHYmoBC4MQcUQPcmdUi1odL8hJFqy?=
 =?us-ascii?Q?xn+IN2uaeBOAKvWL0LRMDACBLN8g03OPJEpYUugdtwZ+Tn2dwhelieCSRjR+?=
 =?us-ascii?Q?1sNrhnhxM1caorOOJ4y4eOF3Bp/KQwS1ZLHpBxnIZ1dT72aN4m2N1cdLZ9pP?=
 =?us-ascii?Q?KGGAEq+/CrGmOaoHvEGl+6zruhc1gzP4/puMFkW9BmcTGFbJsDv5h4Ib2poy?=
 =?us-ascii?Q?SbfCbrIZzfJjKBXxwtPhaXTJPQu+Sn7cHHaHy37oJN/G8yB1f6PgltZ++G70?=
 =?us-ascii?Q?XMuu3GU7ltrH4qpWgtWczRGovzZ7ApRkJdJcanxAar65CD9l3hWgCeQhu+r8?=
 =?us-ascii?Q?8I45FTvTOBcQaLn5HQfrq7SmaBpM4dsVuKrTrD320D1pP/rKY282n0FHRpDV?=
 =?us-ascii?Q?+KHCs3EqpUM7zxd/B9/M5P7ThViHXUbiJT3K3wHPvLqaLv+Be0GxbAmCssyK?=
 =?us-ascii?Q?RaFc2M7WfA4FdUhCpkZO6uW4nHoQDOhsjPyNRfnzFTk3bC+d2w/vVqCG9tZU?=
 =?us-ascii?Q?n3oKluzBzqEhjeVLRxg20Witqu63aqeGvOLzK8sXC6nWHJ1Qopc1uxx8krkK?=
 =?us-ascii?Q?vtLQI4tzYi4XJ6gRhzILUBscVshzKDCrQb7FGlw3VXplqoUglEq8SRW+VZon?=
 =?us-ascii?Q?Aisuv0gYH3B+7/H9DlcvNe7OiruoSEvuvgDWlOAKBKB9K9Fpfbror0Y4J34O?=
 =?us-ascii?Q?dGqfv2hQKsZqTDxPa5zoeh/ucNlRDFqvqviEt3QJj+jX9jbJ6yQ/J/bXW6H9?=
 =?us-ascii?Q?uzSbrpCUQy4wWXaP7kcxFotqsssLlgjCBJ5hiyebnbjZPt+qpTFlztBZEtIn?=
 =?us-ascii?Q?KF3esOmdckiunjlc15MlJ8RSUlifh5fOnFrmjua8EPFRxGV0icIr78bIuroK?=
 =?us-ascii?Q?VbtEQ6oQlT7J9tb7NItf6UNw?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbddaba-d31d-4f84-8ecc-08ddc9d48028
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 10:34:28.0246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7838

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
 Documentation/git-send-email.adoc   | 13 +++++++++++++
 git-send-email.perl                 |  9 ++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

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
index d1c41a0dbd..88e183b489 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -311,6 +311,19 @@ must be used for each option.
 This feature requires setting up `git imap-send`. See linkgit:git-imap-send[1]
 for instructions.
 
+--[no-]use-imap-only::
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
2.50.1.320.g2ad311502d

