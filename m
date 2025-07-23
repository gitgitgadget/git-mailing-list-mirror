Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010002.outbound.protection.outlook.com [52.103.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0806E28466F
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 10:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753266878; cv=fail; b=LVLgbRd5RkHL42DSDMGjf1Q9XoPuUBHqLnjj158GnhSxu7FEb+Wwr+lqmsOEtkPlGyYbBeWCcF18rNc93M/JlrH99NO26xgdmzf4s9Pi150hyaTMYgZJklwIPGhY53fkYpvPt3Lko3yKkSACzxprsPufMZMYnPGTsWdLRIaH/QQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753266878; c=relaxed/simple;
	bh=AwKBdSFNEkelYc2J6EoQJTFOitJCvcp3b5p/sXwpdZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TOSPTn61T+easAxMKFGwhl+uO4e5PL+hinaP75FaUMhpX6Jme4i8Xur1DztJccXww1SyQgZbv8QGtdt6IeVgBqzCk492FIIgM2m9X57/5JFEUqyRcva0I9VnkwfdhVoBgriT1xT0czqK6bpvntLjgrrj5C1HUgot9kb1vELJ6cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QpSP2JwL; arc=fail smtp.client-ip=52.103.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QpSP2JwL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bp5/Z+KffGu1Q2PJr0j3I4ev/8igra34uOOwb8LIXmv2TyglBr6I5YO4SfH8wDlcUzmsceimA3v6zz0UsrzzODOZyWxVKx3ovu7nWKYGJX1FiVcBBjQvLrl04wC4GaVR00XJm9HNbrdLd2IQYGKm4St6a3K4omVhraU0moS9mB549nnXHIpXVwJ9UQpSR8tJjDOpcBnUJ5nwAOLziEkciikXSkiaThouZdOND2fwbbXmVuwnEIuwWgFPkfKyT6ySyCGheJwidoGPTHbOmafE3zZEyPAMyf6jQc2ml89XCevCGdJtKxP9CgZLGWPPuJAAXGE6rYxAhYraYwXqiiMTgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz2XAcHKlctt1RCufGYnV+wfaneBnE9tzyTrtZhcv9M=;
 b=q7u/eYC+bBpGalJeclA+MBZkeVD+ZnnnYZGSvBqjc7Adm4zsrRrUSKrnABaQMoz8N7rNCZkxGbxMhbCCMSSM+YCkPGWt4BIfMT4YqIfOSsLW3FOVhBfKwBRsyC2vbNaQzsZ8YIX7xvIca13+B5eTebgSRzYra2qSo4G5kMaFTSAbW46V/073L1qJ54Lj/8a31HYaOfx1k6v3JFzzqGIOIrcnuCatZfyeVEkV76zxLSmtLgny+LS8iMOlCe+W8n8Fw1guMA92W0zdXhX0geR9iqafOYvPdVxnN0WtAU26hnaxhBeZeiOcb2fuVQypi3A12UlC4SFWiBf/WXcy+UmXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz2XAcHKlctt1RCufGYnV+wfaneBnE9tzyTrtZhcv9M=;
 b=QpSP2JwLecThudZocKjOKXhiu74X8UBup3m/ppdPX51KoBSXsTs7RFYe2oSfyg/CiVnUVW1EL+JruW48kGcN2hVEHSPdr1LmuKYL1TZBEhxqIF5WlHSPh/V/pCDvWVJVpd6TpDzwZLSpa4BEppRxod7AaZJalcwQUq0KnNCed9zeL09oa4y6LjADFNxkN5RG96iVFnKkhUaCbfitQ0iftXE+p+ewYdEDduzvRQDbNf7WGTOn+DQvOk2VVOT/DuWsdBQvywSieM5iKuVO3GdTMfyallUQF2In3RuIJARfk70AAFjG8xcTyiAtIq5/OWhQ2FcTRxSG1DtVPSuRh2MbsA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7838.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 10:34:26 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 10:34:26 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 1/2] send-email: add ability to send a copy of sent emails to an IMAP folder
Date: Wed, 23 Jul 2025 16:03:50 +0530
Message-ID:
 <PN3PR01MB9597A17413F208C032E086E8B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250723103351.17560-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e50aaa-763d-462f-14b0-08ddc9d47f77
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|5072599009|461199028|8060799015|15080799012|19110799012|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0xofPvfLOBfoSBALMMb8cysNH1e4gcB5l6Sav97uu7XatxTFxIcaUb5qR+mi?=
 =?us-ascii?Q?70A0h6VxUXo+NJ27KbI3sa0I1crPlD4YlIelWbtWk3cFUnWvngODQx+XeROO?=
 =?us-ascii?Q?4rwvKeXW/ingUlzoSwTOtavFj1IiyggygltdYl7YjP+5QgHk60mjVM4fEgPG?=
 =?us-ascii?Q?/p5/I7gm5cDPO9TeO68FvVmJ1kuYvdySePxAUfd+Ccz7ILmlali18XxDed+C?=
 =?us-ascii?Q?NC139nPRe12FCTz08p4qwf6WIFwBH4NPlLaTT06G3IQXNQRFie5WxTR2+H0L?=
 =?us-ascii?Q?WNJyMISs9Khf2mFiu0+kqeEQMOsYDOQ0RtwkKHyo7m5hBfnc4qNP+Rh3sHEu?=
 =?us-ascii?Q?i0ix4xnnbAXbvDkXe0zLpjjgD4lwuyQjkyoHs2GyizskD13/GEUy13KJvrSo?=
 =?us-ascii?Q?5cSy/v1+WXohXao2/uoEAT7TJA/wSVlqnwBjKLJ+M2aSISfmwOfKhhKIoNpc?=
 =?us-ascii?Q?RDmok7xglZuSLlqKbmw2d7JDUyLyo2C5ZVoqNfotJnikwtLnXPt6/7ciY/C6?=
 =?us-ascii?Q?qnzEXCa8GJC9Wh8UPvSz69ZumSVYR+sTGmzy7oaaq46FeGzRv9FB83hIgDtH?=
 =?us-ascii?Q?bJpqeyrT8M+6CBQxbVYR/wWdBUSPyWudJFX1YZcMwB7kDO87vtLFFVKvCY8d?=
 =?us-ascii?Q?0aUSsvEJINusQ3XjkQexQHyDWpKdHb8pCxGcL5DUo3sMj5dPNAuZDtt04yNY?=
 =?us-ascii?Q?V7jRUen3d4P7x8FxKUWgOD+ysMfdBPHaLWSQmNzOGZo+tMjhrONa2zyR0BRD?=
 =?us-ascii?Q?KWuOG2UZzRHc9q05cHh0EQaUymxM48UhFi21MG6QQcjB18ksGcxyuSYhSFPg?=
 =?us-ascii?Q?K2RPM9vY/rbhvg8sABqNssip9sVQZdldLk8cGmIlBN/PxI3DyNogk+CWOcsg?=
 =?us-ascii?Q?RzC9ns3SC2Me20Ylk26GZwXCGa+fdulPemCVf89qP+wCgsdabzCX3QOqTqX0?=
 =?us-ascii?Q?AaRmAvgZ93MoIAOlaBqBlpwrP6QaGYLLWAvMQEYAT2272Rn2K8CdeyodO6Hq?=
 =?us-ascii?Q?2z9aQ5vmhkGvxKF03PEdIe4i7xhTwi0CDLG8xRUJT3lT0WKjbxypU4c5SkMJ?=
 =?us-ascii?Q?WeJ4zrbRdbx6S2Bz92OkXtoaUdH5Om8MpMF+nofx2E/XDKeDDCRwLjm1mHzk?=
 =?us-ascii?Q?D7p+Z7UorVSesL/YOrpdZV5tBioBKnUsYQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x4K89lc/swDs2k+kCdJPaBS3/+Cqv+5PR9KyPwShWaLAQwfdrxaok1WDFYMW?=
 =?us-ascii?Q?wG3jW/zkMid6MUIic4Wn5avtPF4nqKqrNc4mRzr5/qeI/6O8gG0aEqJgTdcI?=
 =?us-ascii?Q?8KGD+QosKnTrt6hKNh94I++KeTm0OclO40QMGdDchuRZ6Qz5bJYyDLQiALII?=
 =?us-ascii?Q?N5bgeR/r+LkWjjOpgDj1tK9bYteiRVfBsmy7+h58hj+aCZwdQTZqD5B5vmDa?=
 =?us-ascii?Q?8FZyxF6m09O0igpSF6brv5ovyNzZY1qCzJk51vRQzs7iY+DOjKnmovH+rDQZ?=
 =?us-ascii?Q?0PPBijkL2cprvfqPN9i9vDG1FH1LJEJGDDDfiDBOsVt0jEv8Pvis/mNhkYil?=
 =?us-ascii?Q?Ri2mEO5ERhG0sZMYWC3YzS5HmzuyIRFVUUYVHsLBmBNEXLCVwTem60iueXWn?=
 =?us-ascii?Q?g8OHGbeBm/q6vjdtEtqLrOFOiAw93/mGxnxbuUb3HV2m3oe1rDclGmnbF6Mj?=
 =?us-ascii?Q?r+L9RkbUpxz1nC6s7L7YXr6/IBoyaIB9BwpViV0UKs/HtGQ0h6NxeeJcENgr?=
 =?us-ascii?Q?KRwzOrbzCLZTxY46w3m9/Nj2osZzv4TMboPyMX5FI9lB5OFogT1NuxR7HOGz?=
 =?us-ascii?Q?eQXEBCf24/trNCX8xMG7bUAIKz7VofImDEdQX89FOPC41vvh/SFr475NyH9/?=
 =?us-ascii?Q?ZGe997mFPu41cP7hGjpeW3MOiW5RwOE2t8M+feuakQF/JqXdiKbtVj35FGiR?=
 =?us-ascii?Q?kl5NRnQU4uRqNdXGCyqPrNDZIVI/Lv6gSxqYkDV59wD/DJZdAPKkmpVxqG03?=
 =?us-ascii?Q?KoI1zSJiHPRhcioXvhU82JX752Iio3cvt3mgdiye0GrkDGT6wnoMaLvkipWS?=
 =?us-ascii?Q?49Nn7oaHyY9YsR9cTevnvRGqhs02423ygRJNOMXqt+nzYcrFw4Vt30s+UMmp?=
 =?us-ascii?Q?kIF5o13SloQ3YZfXznEExEqxWTrpVOIMjsUdasRr5tqJnpxEYVev9SaI5uLq?=
 =?us-ascii?Q?48ndkBXihXi3mQsM0FLHctShVbYN7C8T8fJ+glHDDPNpBTSk1P6TirWDiE4T?=
 =?us-ascii?Q?NpuRV1qYV8sYQg4reqyCbm9zbBCmym8uyNYjh1DoPFxHdZZL7DS7U1NlJZ+/?=
 =?us-ascii?Q?eMk/jWOnn9gEANVKh9aOxm89CDwP6ZtttQZPJbFk0WbTcbt3Lfqdc1iLd8hw?=
 =?us-ascii?Q?9+3G5883b6kgyrNButKCPg+C7FDFFbcJ/QCZDK5YA6V2DrqLrFpeCgUaeKRP?=
 =?us-ascii?Q?dl+0plkraIS1W2Z/p13ioVU97t3267cxv58toui/TSu8i0/FpGeJmKt/nGJ/?=
 =?us-ascii?Q?ywlgk53kaszSy2Xw4KzDybFozQqX3vsAJAFkwFOkKLks5zj70nTwAbEssvWl?=
 =?us-ascii?Q?0pExT5jY9iVRsdqMeHY4bunw?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e50aaa-763d-462f-14b0-08ddc9d47f77
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 10:34:26.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7838

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
2.50.1.320.g2ad311502d

