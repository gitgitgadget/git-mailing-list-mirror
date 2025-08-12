Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC2B204C36
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981113; cv=fail; b=rt2JtwwAZ157CekGMsPwTQ3d86csw6Kk5CdbN/mDmy0pyz+uYo+QTbH9R1kikrE0LMbjARS1d7hJt/XIC+MNKgGWVMp2ymafUSTP7sOoRQ7Kfyt+wtJOEP2YWeiy2/ApqhpUB+MLS9BwJZQoriP30S02dJSs+4JQZv8CTsFoQb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981113; c=relaxed/simple;
	bh=0sDtR7xdcNGqO+9z0lpXvBC+eewztmQoAOtbsxXYFDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EiBDlShFwBcF4eDVd0m3hj4iLIF2kO0iwv5dZZqKFaQBztiqC77l79zhn5/rPn3m6Qphbe+0vPLS+QI2B//RsJOcdAutYK7Eqf3PAbot7qZ3VIJTTsTynplcyi2W/nEUsvvmvQLLweufcIrssaGDrCIR2av144k7QnA4RX9zNUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=lZUHtllo; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="lZUHtllo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9RY3VyOA5QoRYLRCDmVjyD72oibS2dbCMrX/9XRlMWmWPDq16Dz4HNqiJBp4uXnOl1uG0l+FtvsxSWMaeXjQ/xdPS1Vlu59PKxB2p7SHZ/7rE/RucFqGRGC8ay4sDg7DRgc2DM/gjYr8375NC9EqrEinrGjkBT1PQfaVlC9/LBDIv+0CzvJNSJP5IgVsel5oISUnm+M026pi0MbDOx3Mb7qUhpgThBkBdQyCOGQ4L1VKiShzBeGlsolPn6yiZICTQKuAnWtkk3Lyv2IAWfmLn/8CkyNef5tKJGGzx16g+igfMhfZsJG5aRzSBikICL/wMiNLg72ctkYL6tTMHup5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeLpShdk7YazV2Nwzoj8zYNbDJx20YkHTrIQBai7khI=;
 b=f/APyHv7i2ljHR2aPruENAGHPFqNBnxVmvtEE6rhktCHDjHIn6xzlSos/rRUzI56K68RoYZSiCrwwzCNpRdF3jCVAPi+BsktTbHfDv20Ba8mlzE5LLbzHTdEW8uZC6OXIRfDdwpVHCkXIdsiPgcVoonlZ4BQC8QvBVytwejWqPcK889Tcp39mewjQmEcnW9L/sFx290sm6qSGU0veTdBRluC5g7MYsMIP/OPEvJ7E5g+EM+ljibG1/X8GwdZ8sGTqO/NvklDwmPs6WRyHDuuJWPueG6Sg/D5sk+5FUNgvhmgUtGzklLYDL6px+IY1Glle1NjrOg73T6jliu4RyY0vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeLpShdk7YazV2Nwzoj8zYNbDJx20YkHTrIQBai7khI=;
 b=lZUHtllok5hwWskZmetJZevB8+C7ytDgzHC6u4unWmqy/yjfH8T986w+pMm8jtnAFJNeMwAuZ0IQ5scEz5WgpgS7fRv+WAn/ABvy0L1GU4r8UkWTIWdksKyqLBp/fMo8TO6mzH0OIMcyCsHN7aa+JLjApTfyHydi06m4kJL5lPXXPgVbblrP6gwsqnmST1wFvt8pehcd/EpowPB3+dIkt6KvcZsDalTAc72kvYmQRWmfzKnB+gP2XHbV2OO1rVruFEHgKgGpPdklXcfrfp9dd3Ri8vmvbsjZenW8/1ZlEYshuISfQRU46SeHPGCjil/LMJpJlFvhsqvQWT3Ppy8VWg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB10175.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 06:45:04 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 06:45:04 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v5 1/2] send-email: add ability to send a copy of sent emails to an IMAP folder
Date: Tue, 12 Aug 2025 06:44:35 +0000
Message-ID:
 <PN3PR01MB95976402ED4371D443518650B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <PN3PR01MB9597E8E33868386C997D2563B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
 <PN3PR01MB9597E8E33868386C997D2563B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0190.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::19) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250812064436.9643-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB10175:EE_
X-MS-Office365-Filtering-Correlation-Id: 98bd02ba-2ef8-4942-facb-08ddd96bc477
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|461199028|5072599009|41001999006|15080799012|3412199025|40105399003|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Q/6ZCfzskDFRDfV8cyxz2uSIidCgMfsAW9EFnlFttFo3fnCmJa1oZ67AlAT?=
 =?us-ascii?Q?/FLM4u7mHVBpgCj0Okeb9brU5jxaBiRBENL67OTny5OlgvFZTnH0IPhVqcho?=
 =?us-ascii?Q?wVkJOVLjSKKi/B8iaPaEayhXnlWMvSIoJgpBo5N/7hyRiWLno4SqrzqFMVEH?=
 =?us-ascii?Q?N6tI0X9lItqmyK/JIy2REJsP57+EzDKN0Kw+E3jFFEBlUDf6lnpDp8g/iCJy?=
 =?us-ascii?Q?XKs/6PLRrA156RgJwl00ekHLUNt4SnJMaioOc9oNeQc/OU0PpP5Pz4iE2nlh?=
 =?us-ascii?Q?zqyiADFdObsAotedaOoyYxJlUjbXxSkVlLVwsLuMnk7Gfy7x2NyXlFNnp4Dt?=
 =?us-ascii?Q?utXf76YLod0zHtz3R8af+ofZNkqMgAwu1by8ptdsqvrnAYTpDFeyHlzjjXIv?=
 =?us-ascii?Q?HxxaHIguTW3AUGtgXPfEn2QVk2r2rfxIqYIh6IHVF6sYV4Qm1WiQIiV1pcLH?=
 =?us-ascii?Q?Yg5ZtVrIHSwEBXwTBC7REVEoOHfzkxlpMUgExZG+zsa0j13w+DmTCPuH8AOT?=
 =?us-ascii?Q?Iu+urNlSaOXJDxJn3OPlP9pgWYYuRbIfzoNxRcsrWxum4/VLJmbRk1Ig2PxU?=
 =?us-ascii?Q?GjgPxVQFeRkVKCctEzfVCA3yuHZLjIUJOPasnbpjO4+0ZfUXtrC1LuGwNssb?=
 =?us-ascii?Q?PBW0I56W9+L8ErTqAg1WbxpBHBqIb8bk3AlneV4bQtfK+kQ3Y0/xMzbJuoxm?=
 =?us-ascii?Q?JgLFTgPGGK0SvukGgcBex0C1EjKrNP+TtFAJxnGHhvIpJe7TPVkL+PHWqX4E?=
 =?us-ascii?Q?Rjt6jr1R/0v0dQNJrmmX0drc8s0c8RUa6wJJFN9oP/UZc/A4ockYRG7dA578?=
 =?us-ascii?Q?3BZC6GIbQmM/9cmNhLasS7w+Bx7Thf7gI5e9U0RVOF6FOZ8q8zUV3QS5F0WW?=
 =?us-ascii?Q?FsQR7j20UVChMdLlyCEA57WpXaH1Rw68fmqnihc19czUQwZI5usBfi0xcNno?=
 =?us-ascii?Q?VtNNwlBreD5e7btK0rdH0U5S86WHtIwE8jx7T3VxZAVz7xIZdYv3lEpAh0oo?=
 =?us-ascii?Q?JRK1hzNwEb41QrodsBz7MKYah1YjbYJn5BqmzBdg0TWwFvDn1/aEfaQwx/AY?=
 =?us-ascii?Q?RQbTtWnlSw9og404iZWBasYLX3EmwapkYSS+puTbHyCfdzRlbnTaZYOTXBr0?=
 =?us-ascii?Q?QWPSqmeJbrxud/P+CkQkZsRYic1spj/ALg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3xMqm5wB3XE2Kmsgup50qMZ0xmJzSs8pQGkqd1YY7vEO0sQ5Mjfrpu/hBxFZ?=
 =?us-ascii?Q?KNtQgDNcl2HqID7PYftWVNMrtaLuhdAVmKj/MaRdMIrCsfbFG4S9M85lL3f3?=
 =?us-ascii?Q?NPyOyfvU8TwEv7qXt7yf6Wx83rXw1K9TExaWR72wKXVKc4FbQeovdoJM+A6j?=
 =?us-ascii?Q?i5wWSnZayGosRYahYgn3jktrcOlOuFi3EznZzu/f0f9KNqchuKHd9s2SMsLR?=
 =?us-ascii?Q?oXg7+dp4cj7APgExEah2Zp5o+f5dgS8PKuYGLR62vKM3SFZ/tooNDUy3/ECR?=
 =?us-ascii?Q?GLGS1KiQ1zKLpkl5McUu9zDLmONcKmJPDVLU2FunSXe1i4yHwpIJBbISVK4b?=
 =?us-ascii?Q?c/FiPXpXwV1ExlfCX1RLwqUPiZlYZiVUHCnoqdpsupMvyUbwiMKZCy4G3iiS?=
 =?us-ascii?Q?oEKIQb9qKeQ5waoj0++K/iLPdPCo43LUtnf/a5/W4JvatQcEbnNnUc5rY1fI?=
 =?us-ascii?Q?tWSA6xJuNyx2/RegjB+QLfW9KvnGW2iZk7vY4cxPkHH2YujdzyKU4BSQ0+vw?=
 =?us-ascii?Q?Q6IKb/Bifii9a9f7qNmXXdIVZr+KNWR0SWpLrE6qggDz1Kz2vGAVDOdOmMMd?=
 =?us-ascii?Q?s55f/zi4CZ3L3HYtxTeQluUC9vyAi2Qz0aeeKoUoxUKs3bNDwumUqtYC0sS8?=
 =?us-ascii?Q?d4vak2QUU/hcmfneJm+4tqK83E+XanKFiu0B1IzKFqqVxyRvWWKZeOdA1zVG?=
 =?us-ascii?Q?4zJz4LlUYQirt/XUQhfOpRqGJORcyHrFMMrqLtaS9gx73fHM9cRc80xoteK5?=
 =?us-ascii?Q?PmVQAw9AE7EyIX6qV9KQeB0dolnZpUlNqy6LyUvwDGqrgEGXSf0IoaGtpiy0?=
 =?us-ascii?Q?6YXQGe4fKb12kAqmKD1cFrE0NslS90gWgHSm40drPdt8FVgVWpc5icSeJ0bx?=
 =?us-ascii?Q?xPgMkj7BisSFAcxGDSuQw8iHtaKjQT9fqWvCYkLUDU35Lt6xG62YojOn5k/h?=
 =?us-ascii?Q?njLBwmJO3dQm/yQcaj/kxXUgLX3XLd3a7XtJFLTKYh7qgRfwbSbQANIXAw6g?=
 =?us-ascii?Q?aRm4HnsfdDQuqp8JoBF0Xxc359p3jjkyVHVysR0eQeFqU/07TqBADsjRsoKu?=
 =?us-ascii?Q?2P2Vr/xM8J6/9hke0KUFEBMzi3OXhnfwS3OLTC1u+mbfEVpUM47KOg/4HoiG?=
 =?us-ascii?Q?h9ezYWSIOgMCIYA5qD3ZICM1nnJFD7ZwNqSeUV2VGc1WSJ0VTC+HtNl5sFNw?=
 =?us-ascii?Q?YEDXM2gSWlt7k9seGnc+9oW3fqaIvnW0pQBXF5Aauc+JSPCGnj86vn1Fir4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 98bd02ba-2ef8-4942-facb-08ddd96bc477
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 06:45:03.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10175

Some email providers like Apple iCloud Mail do not support sending a copy
of sent emails to the "Sent" folder if SMTP server is used. As a
workaround, various email clients like Thunderbird which rely on SMTP,
use IMAP to send a copy of sent emails to the "Sent" folder. Something
similar can be done if sending emails via `git send-email`, by using
the `git imap-send` command to send a copy of the sent email to an IMAP
folder specified by the user.

Add this functionality to `git send-email` by introducing a new
configuration variable `sendemail.imapfolder` and command line option
`--imap-folder` which specifies the IMAP folder to send a copy of the
sent emails to. If specified, a copy of the sent emails will be sent
by piping the emails to `git imap-send` command, after all emails are
sent via SMTP and the SMTP server has been closed.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/sendemail.adoc |  1 +
 Documentation/git-send-email.adoc   | 12 +++++++++++
 git-send-email.perl                 | 31 ++++++++++++++++++++++++++++-
 imap-send.c                         | 26 ++++++++++++++++--------
 4 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/sendemail.adoc b/Documentation/config/sendemail.adoc
index 4722334657..dd2dbc87a0 100644
--- a/Documentation/config/sendemail.adoc
+++ b/Documentation/config/sendemail.adoc
@@ -88,6 +88,7 @@ sendemail.smtpServer::
 sendemail.smtpServerPort::
 sendemail.smtpServerOption::
 sendemail.smtpUser::
+sendemail.imapSentFolder::
 sendemail.thread::
 sendemail.transferEncoding::
 sendemail.validate::
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 5335502d68..d1c41a0dbd 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -299,6 +299,18 @@ must be used for each option.
 	commands and replies will be printed. Useful to debug TLS
 	connection and authentication problems.
 
+--imap-sent-folder=<folder>::
+	Some email providers (e.g. iCloud) do not send a copy of the emails sent
+	using SMTP to the `Sent` folder or similar in your mailbox. Use this option
+	to use `git imap-send` to send a copy of the emails to the folder specified
+	using this option. You can run `git imap-send --list` to get a list of
+	valid folder names, including the correct name of the `Sent` folder in
+	your mailbox. You can also use this option to send emails to a dedicated
+	IMAP folder of your choice.
++
+This feature requires setting up `git imap-send`. See linkgit:git-imap-send[1]
+for instructions.
+
 --batch-size=<num>::
 	Some email servers (e.g. 'smtp.163.com') limit the number of emails to be
 	sent per session (connection) and this will lead to a failure when
diff --git a/git-send-email.perl b/git-send-email.perl
index 437f8ac46a..b3cc237baa 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -73,6 +73,8 @@ sub usage {
     --no-smtp-auth                 * Disable SMTP authentication. Shorthand for
                                      `--smtp-auth=none`
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
+    --imap-sent-folder      <str>  * IMAP folder where a copy of the emails should be sent.
+                                     Make sure `git imap-send` is set up to use this feature.
 
     --batch-size            <int>  * send max <int> message per connection.
     --relogin-delay         <int>  * delay <int> seconds between two successive login.
@@ -200,7 +202,7 @@ sub format_2822_time {
 
 # Variables we fill in automatically, or via prompting:
 my (@to,@cc,@xh,$envelope_sender,
-	$initial_in_reply_to,$reply_to,$initial_subject,@files,
+	$initial_in_reply_to,$reply_to,$initial_subject,@files,@imap_copy,
 	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
 # Things we either get from config, *or* are overridden on the
 # command-line.
@@ -277,6 +279,7 @@ sub do_edit {
 my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
 my ($batch_size, $relogin_delay);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
+my ($imap_sent_folder);
 my ($confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
@@ -322,6 +325,7 @@ sub do_edit {
     "smtpauth" => \$smtp_auth,
     "smtpbatchsize" => \$batch_size,
     "smtprelogindelay" => \$relogin_delay,
+    "imapsentfolder" => \$imap_sent_folder,
     "to" => \@config_to,
     "tocmd" => \$to_cmd,
     "cc" => \@config_cc,
@@ -527,6 +531,7 @@ sub config_regexp {
 		    "smtp-domain:s" => \$smtp_domain,
 		    "smtp-auth=s" => \$smtp_auth,
 		    "no-smtp-auth" => sub {$smtp_auth = 'none'},
+		    "imap-sent-folder=s" => \$imap_sent_folder,
 		    "annotate!" => \$annotate,
 		    "compose" => \$compose,
 		    "quiet" => \$quiet,
@@ -1829,6 +1834,17 @@ sub send_message {
 		print "\n";
 	}
 
+	if ($imap_sent_folder && !$dry_run) {
+		my $imap_header = $header;
+		if (@initial_bcc) {
+			# Bcc is not a part of $header, so we add it here.
+			# This is only for the IMAP copy, not for the actual email
+			# sent to the recipients.
+			$imap_header .= "Bcc: " . join(", ", @initial_bcc) . "\n";
+		}
+		push @imap_copy, "From git-send-email\n$imap_header\n$message";
+	}
+
 	return 1;
 }
 
@@ -2223,6 +2239,19 @@ sub cleanup_compose_files {
 
 $smtp->quit if $smtp;
 
+if ($imap_sent_folder && @imap_copy && !$dry_run) {
+	my $imap_input = join("\n", @imap_copy);
+	eval {
+		print "\nStarting git imap-send...\n";
+		my ($fh, $ctx) = Git::command_input_pipe(['imap-send', '-f', $imap_sent_folder]);
+		print $fh $imap_input;
+		Git::command_close_pipe($fh, $ctx);
+		1;
+	} or do {
+		warn "Warning: failed to send messages to IMAP folder $imap_sent_folder: $@";
+	};
+}
+
 sub apply_transfer_encoding {
 	my $message = shift;
 	my $from = shift;
diff --git a/imap-send.c b/imap-send.c
index f5a656ac71..44de0c5a77 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1441,14 +1441,24 @@ static int count_messages(struct strbuf *all_msgs)
 
 	while (1) {
 		if (starts_with(p, "From ")) {
-			p = strstr(p+5, "\nFrom: ");
-			if (!p) break;
-			p = strstr(p+7, "\nDate: ");
-			if (!p) break;
-			p = strstr(p+7, "\nSubject: ");
-			if (!p) break;
-			p += 10;
-			count++;
+			if (starts_with(p, "From git-send-email")) {
+				p = strstr(p+5, "\nFrom: ");
+				if (!p) break;
+				p += 7;
+				p = strstr(p, "\nTo: ");
+				if (!p) break;
+				p += 5;
+				count++;
+			} else {
+				p = strstr(p+5, "\nFrom: ");
+				if (!p) break;
+				p = strstr(p+7, "\nDate: ");
+				if (!p) break;
+				p = strstr(p+7, "\nSubject: ");
+				if (!p) break;
+				p += 10;
+				count++;
+			}
 		}
 		p = strstr(p+5, "\nFrom ");
 		if (!p)
-- 
2.50.1

