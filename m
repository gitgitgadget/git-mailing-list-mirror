Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010007.outbound.protection.outlook.com [52.103.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A90870808
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753003534; cv=fail; b=grwZLyX81tlsU/7gV7FGOyjr4VzaIE9buBoJ1jNxhcyqY+lfeo0Owrl1mmj+e9ZJ6JgyczpugK0mc33xBn9BmUChz93mHR1Q9B4acQfsn9oSrHfs0kvdNhnei6JK1p5gkGD2U4SL0JLI0GfTbjawYRdXGvCCU3HcbVtTPqKkPsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753003534; c=relaxed/simple;
	bh=YFKQU/wK6YxEgIo9zAkMhUDvutvt+sHfDdtd8TvVcNY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HOcJUZU9Mi7n9CGCnJX9hD8VM4pGvaLu2mXOvc+Zizyyv+fkb4WPWny/r2fHAhoFU3rEcg56tqrroFLwS+cB8MjpHvAkLAhuyPgccgDjLDD8+4xnWSBuhgrSHdXnvoDdoz6VmMI7mkLgLJHbYIo8mZrPQnX3KTOTV6zy5Rcc4kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=m98jW+xB; arc=fail smtp.client-ip=52.103.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="m98jW+xB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tged3zDbuPcvPfQ1WrA00BOybXmFos9HPx155eV+/JnrsMr3QdbBl3G/FSiQVa17IhAJpNbc+EiM3skdU6sRBwFayJqACwx0//NCSan/BL2zpYrH0M15TDuGNVJBEULdQrX8DYeb6ekY/GExBGVlyTd0wBH57Rd7yDSUe+92NAesBenft5ofEc1Ixi3oeBbUJ+kVQB97OqyvaKZZSnl1nBpOvYpTpniB0drOLa1kY63EATO5GpkaLojdVR/MKgX+m5VdUERGHjvXm1aSAfFOduQlkDvk904M/CgyDW0AScjCb0uiLMRIEPLWgaHYQsKYMyUXjGFam+EoxrjRJCBiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BsjYqv7DngcaCrpyX1Vy4Nz9w06VNDX9UUaseYy4lQ=;
 b=iOjQo3PLhu9+7FY+SA0qZO6XrPXb0htUYSxz+7H/QZp7pX1gxT99Y0S/4MlT+aQPQwoAO119pWUZ6oOfQPgxUG410f/3/4HYGF6xWLlYKa6iO95bXkwqkfXav7gjaTmCRPnQpXihidugpsmUt8m1PIhczavjPCDriGzYiMlgeQsDNfLF2kMCnGV7Vej5llAdGdf9FNkFtirpU6regBUQna4Kf178vCBXfEGfsj7TuZSHsrvkL1LrsRz2wXzxxDfQBpTdG6llPxv5051ihbJBlQ1Fq6VnIZaY7GivwsRjPN0AAsThwkDdWfXIrty0D8zDPS2NKHGCGCatVi7GjhBCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BsjYqv7DngcaCrpyX1Vy4Nz9w06VNDX9UUaseYy4lQ=;
 b=m98jW+xB2pemiS3ESfM065BxwePrSFprKdUwCovSBwsgOPNNI5k1axC7rVn+y7lbDOOwfCHpS1frVF/cCyNhBk/tYHvngPib5X2P+60JUnnSOIV0Uo3dWqo58v87rHgCxC+bvfEPgGsHWwNYIiiVXvs7m97q9IAXbYYdxpMpirRcHJbJiu+N97q8COzI68YMWfjlnB+rVjgfLDflWzthsPJvuYhpT5HAthUlQ4zmFpi1OV9QU4HjEPDOJyR44LXbMoHhda8GkWQJhHg7GFIikztELiMxFP7wrnquX2JIen8xz3VJhXUWKeTxq5OgSxwyjuoZzNVJ/y2wmk9oU7BJbQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9995.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Sun, 20 Jul
 2025 09:25:27 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 09:25:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] send-email: add ability to send a copy of sent emails to an
 IMAP folder
Thread-Topic: [PATCH] send-email: add ability to send a copy of sent emails to
 an IMAP folder
Thread-Index: AQHb+Vg6gZ+2ij9YGUq8U+Snxy26rA==
Date: Sun, 20 Jul 2025 09:25:27 +0000
Message-ID:
 <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB9995:EE_
x-ms-office365-filtering-correlation-id: f82845f6-ca45-4f61-362d-08ddc76f5d5a
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|15080799012|38102599003|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SUaV4R92zU6pYpzMdsWAmKb9/qvb7xSCxwWkz78qDzwnm47DcpPwGu3y9n?=
 =?iso-8859-1?Q?oZPxCGGhGDbpsnoqQRo3ntWz5cbSWjBvKgRHAO7068n5ZaIGqk7uPFnwFi?=
 =?iso-8859-1?Q?vsI+hdQAryLY7JsNncVPGUNZbypLebwqchWWtWS4Q87+TZ/auU/MDV0MEq?=
 =?iso-8859-1?Q?0TCJQYtC1kkUoby8S6ygzUi59Qyd70K7lwYd6nPWDKyKxdMc0S9zFvC4SW?=
 =?iso-8859-1?Q?UW/O12WIT+TcAn2m18YBLZVRa8Lg05XcYN+bUxDM5OHiTUVlsoUHF765Zt?=
 =?iso-8859-1?Q?2YeDgER3rZqbWF8AhgrEtfvLESK/hmx6Hrc/8gBDdopVlIH9rufOZsbEGy?=
 =?iso-8859-1?Q?tVp3us0LG5bzsJlkykW2gasZz6on5FUMfymOxX3maYdojngcrK8Zl+M9cF?=
 =?iso-8859-1?Q?I9Omik+fpkNL9GpdWgO08oiwHp1l2RUwf+Z6DN6YU4KsSJvIU9tR5bZpWV?=
 =?iso-8859-1?Q?DUM73XAHrGwpmhpCm8Vxgc72Y9w9lh58O8DM6tIbtxnRaaZZP/dwixuEpz?=
 =?iso-8859-1?Q?HSiij6TyxxSSziqXlL0fCvkg1Z2ZMs2TrA9pL3AQQNHK6Za0ZrW77Fl9eX?=
 =?iso-8859-1?Q?GWCOp0Zk4IMDCOUp7XaMlcPSSckcMXO7CtbxJ55sMjspuy+mXnvjw0rgWM?=
 =?iso-8859-1?Q?XBqqAtBOX4V1rmXpOo8w1dHbebcMWth//kotRY6EyxlHX2C6JdnaT8PZ7W?=
 =?iso-8859-1?Q?ipOPvhWMKGGM56hbU7DmS+7sNBInwznyBhQ3Y/dk/RwPfmp7owsh+oHNhe?=
 =?iso-8859-1?Q?EIqt12EE+DXdu9dwl6j7ZkU+PIrq52oIVRZW0NO38YHz9Dq4xcbDdwBo8f?=
 =?iso-8859-1?Q?+RAe4SgVGTMSdtIvG1mpS3QRT0dw8CHav+oJjKzQ5bcSZa7fLT50eR5/ZX?=
 =?iso-8859-1?Q?WfCj7pFN7cCRRmge7wTQHfP3y6NvCD8jGfVAz6o4evQ6ZYzM7eo9KZ/DyJ?=
 =?iso-8859-1?Q?9CDg6t1sp9vdtInzEEB1GGNNk+L6pjoNG8nWOYH46KnZpllN6aRz3LDfyd?=
 =?iso-8859-1?Q?CVxnW2BdPqq+GmDOdB2Ujwg7h7QS6fYEO1faUT8pNLsSRxeRoH3SBGxmMc?=
 =?iso-8859-1?Q?X/FXyjLAbY5/XcW6j/8qWgHjPXfmwOgVskvZvdQL2RGSi+saq7vDFus2hC?=
 =?iso-8859-1?Q?rIaF4pJg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iDOYDPlQbh1JZZn9yq4/WUPCi+F1+CGkoI1nfEzR3c4N1qqa+EnYCZ5PMJ?=
 =?iso-8859-1?Q?PAFVbdk+NaVjoP1QaVsnQ8UB+1FROsbhqZpOVYCw2WUh5PhEVCCosaQVM0?=
 =?iso-8859-1?Q?JFmtim4LwK+OXrU/YTdvEXrc/BUkesOnZttCW3WN9ezuG5WuVqIXxx9GX0?=
 =?iso-8859-1?Q?VuJFObZMF9uNRbnu4vRMcKLtxNKql4iAQgnF6I7kCYl528LPMg7yFE8epi?=
 =?iso-8859-1?Q?BAz99X6NGYPeuBX6ApYpyuzak9tJrlA8/z32uzVNtj7hKYTRvzM9tmkh2V?=
 =?iso-8859-1?Q?lVdIrYaVrQdyWCfw4r+Zw95MiQBeFksHVcUPX16R9yEPFjl3O6hbvyVkXk?=
 =?iso-8859-1?Q?SuV0Aq10EMSOaFm+MjBKgdJkBjdnevkYeQVs0/x1FC9TJI9LG6iP7R9V0B?=
 =?iso-8859-1?Q?4JJe2EgDsEymFDK2yzRn7nBdk3pDUxHDoTfbKsdpRFvUUncnFWKyc9ege1?=
 =?iso-8859-1?Q?rVEzirkjc4mQFq+y3iDpndkSBHjy3I81PNtyAGkKDrXwjpWXDrCQODWVdt?=
 =?iso-8859-1?Q?DhjcFpHUUm6o6dCCTYKZ1QXgJFov2lzsZG+EAxO7fLtWOEJuaHLrMXWbtM?=
 =?iso-8859-1?Q?GDOVDHbNk1g+1inQFYz5tDXPLNtQgCQz4hgPjxnwrXjvqX74p0OLIC2QOb?=
 =?iso-8859-1?Q?K9CKZtEgZmbcFFDGn8ictw1EsKRBqab3bTH7RaO4QFSquHG1yFzqm9XhhC?=
 =?iso-8859-1?Q?FL0erhCUDM70XsxATokDywRg+qkTftBfmAQdgdcYyqI058dAivgRBtco1r?=
 =?iso-8859-1?Q?Ad72jzHTLTUbvJH/3Gx841H6N7M6qv3G9kwLTJArL1VWUbe220EdiHozFo?=
 =?iso-8859-1?Q?mZYP95S2EYEwdmmJXK6AMeOp4inbnd6wJWGFlWZuAQtPBk+NtCbDHBN+y+?=
 =?iso-8859-1?Q?jxWhiYgGgRc7MfSu6o6VaurIm8Hb8vRfw5mhizYLp2YJupr0cWfQoVQsKv?=
 =?iso-8859-1?Q?mzmT2689te0h7q7yVn32pXmIG1DjdxT9XwcWSFRM0gKnV1dtx/CuAVnmc2?=
 =?iso-8859-1?Q?xcl0IQnnUA/+KzYYftlZPtdokhN/C1BhFvjt7hIcAQoA2kbQ3FYm+6Ph9P?=
 =?iso-8859-1?Q?z6jgb8ZDRhu3n3yoBPUE1nK5NCez4zZnvgg7yw+vKroDtFxzOoL85q5nCz?=
 =?iso-8859-1?Q?sfNaJr/mNVPgsNg4ULw1nyLV0tm4RxdIdl2EfnzEmdzgFpHvRTtBCtTJfM?=
 =?iso-8859-1?Q?Z7FMzwUnOwZHIeU+uNL3bwwgEuvHYpnfQcyzKwhtcyX4+rz8fMAyRDhhJ1?=
 =?iso-8859-1?Q?HRfEw792Kd0IUUF+hXLac5HVH+xoXtLUKzqGHFm0o=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8769-5-msonline-outlook-acae4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f82845f6-ca45-4f61-362d-08ddc76f5d5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2025 09:25:27.7864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9995

Some email providers like Apple iCloud Mail do not support sending a copy
of sent emails to the "Sent" folder if emails are sent via SMTP. As a
workaround, various email clients like Thunderbird which rely on SMTP,
use IMAP to send a copy of sent emails to the "Sent" folder. Something
similar can be done with if sending emails via `git send-email`, by using
the `git imap-send` command to send a copy of the sent email to an IMAP
folder specified by the user.

Add this functionality to `git send-email` by introducing a new
configuration variable `sendemail.imapfolder` and command line option
`--imap-folder` which specifies the IMAP folder to send a copy of the
sent emails to. If specified, a copy of the sent emails will be sent
by piping the emails to `git imap-send` command, after the all emails are
sent via SMTP and the SMTP server has been closed.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/sendemail.adoc |  1 +
 Documentation/git-send-email.adoc   | 12 +++++++++++
 git-send-email.perl                 | 31 ++++++++++++++++++++++++++++-
 imap-send.c                         | 20 ++++++++++++++-----
 4 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/sendemail.adoc b/Documentation/config/sen=
demail.adoc
index 4722334657..55b5943956 100644
--- a/Documentation/config/sendemail.adoc
+++ b/Documentation/config/sendemail.adoc
@@ -88,6 +88,7 @@ sendemail.smtpServer::
 sendemail.smtpServerPort::
 sendemail.smtpServerOption::
 sendemail.smtpUser::
+sendemail.imapfolder::
 sendemail.thread::
 sendemail.transferEncoding::
 sendemail.validate::
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 5335502d68..74ec2944da 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -299,6 +299,18 @@ must be used for each option.
 	commands and replies will be printed. Useful to debug TLS
 	connection and authentication problems.
=20
+--imap-folder=3D<folder>::
+	Some email providers (e.g. iCloud) do not send a copy of the emails sent
+	using SMTP to the `Sent` folder or similar in your mailbox. Use this opti=
on
+	to use `git imap-send` to send a copy of the emails to the folder specifi=
ed
+	using this option. You can run `git imap-send --list` to get a list of
+	valid folder names, including the correct name of the `Sent` folder in
+	your mailbox. You can also use this option to send emails to a dedicated
+	IMAP folder of your choice.
++
+This feature requires setting up `git imap-send`. See linkgit:git-imap-sen=
d[1]
+to get instructions for the same.
+
 --batch-size=3D<num>::
 	Some email servers (e.g. 'smtp.163.com') limit the number of emails to be
 	sent per session (connection) and this will lead to a failure when
diff --git a/git-send-email.perl b/git-send-email.perl
index cb6dca2500..571e4b78c9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -73,6 +73,8 @@ sub usage {
     --no-smtp-auth                 * Disable SMTP authentication. Shorthan=
d for
                                      `--smtp-auth=3Dnone`
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
+    --imap-folder           <str>  * IMAP folder where a copy of the email=
s should be sent.
+                                     Make sure `git imap-send` is setup to=
 use this feature.
=20
     --batch-size            <int>  * send max <int> message per connection=
.
     --relogin-delay         <int>  * delay <int> seconds between two succe=
ssive login.
@@ -200,7 +202,7 @@ sub format_2822_time {
=20
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
+my ($imap_folder);
 my ($confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
@@ -322,6 +325,7 @@ sub do_edit {
     "smtpauth" =3D> \$smtp_auth,
     "smtpbatchsize" =3D> \$batch_size,
     "smtprelogindelay" =3D> \$relogin_delay,
+    "imapfolder" =3D> \$imap_folder,
     "to" =3D> \@config_to,
     "tocmd" =3D> \$to_cmd,
     "cc" =3D> \@config_cc,
@@ -527,6 +531,7 @@ sub config_regexp {
 		    "smtp-domain:s" =3D> \$smtp_domain,
 		    "smtp-auth=3Ds" =3D> \$smtp_auth,
 		    "no-smtp-auth" =3D> sub {$smtp_auth =3D 'none'},
+		    "imap-folder=3Ds" =3D> \$imap_folder,
 		    "annotate!" =3D> \$annotate,
 		    "compose" =3D> \$compose,
 		    "quiet" =3D> \$quiet,
@@ -1829,6 +1834,17 @@ sub send_message {
 		print "\n";
 	}
=20
+	if ($imap_folder) {
+		my $imap_header =3D $header;
+		if (@initial_bcc) {
+			# Bcc is not a part of $header, so we add it here.
+			# This is only for the IMAP copy, not for the actual email
+			# sent to the recipients.
+			$imap_header .=3D "Bcc: " . join(", ", @initial_bcc) . "\n";
+		}
+		push @imap_copy, "From git-send-email\n$imap_header\n$message";
+	}
+
 	return 1;
 }
=20
@@ -2212,6 +2228,19 @@ sub cleanup_compose_files {
=20
 $smtp->quit if $smtp;
=20
+if ($imap_folder && @imap_copy) {
+	my $imap_input =3D join("\n", @imap_copy);
+	eval {
+		print "\nStarting git imap-send...\n";
+		my ($fh, $ctx) =3D Git::command_input_pipe(['imap-send', '-f', $imap_fol=
der]);
+		print $fh $imap_input;
+		Git::command_close_pipe($fh, $ctx);
+		1;
+	} or do {
+		warn "Warning: failed to send messages to IMAP folder $imap_folder via i=
map-send pipe: $@";
+	};
+}
+
 sub apply_transfer_encoding {
 	my $message =3D shift;
 	my $from =3D shift;
diff --git a/imap-send.c b/imap-send.c
index f5a656ac71..e82dbb2170 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1441,14 +1441,24 @@ static int count_messages(struct strbuf *all_msgs)
=20
 	while (1) {
 		if (starts_with(p, "From ")) {
-			p =3D strstr(p+5, "\nFrom: ");
-			if (!p) break;
-			p =3D strstr(p+7, "\nDate: ");
-			if (!p) break;
-			p =3D strstr(p+7, "\nSubject: ");
+			if (starts_with(p, "From git-send-email")) {
+				p =3D strstr(p+5, "\nFrom: ");
+				if (!p) break;
+				p +=3D 7;
+				p =3D strstr(p, "\nTo: ");
+				if (!p) break;
+				p +=3D 5;
+				count++;
+			} else {
+				p =3D strstr(p+5, "\nFrom: ");
+				if (!p) break;
+				p =3D strstr(p+7, "\nDate: ");
+				if (!p) break;
+				p =3D strstr(p+7, "\nSubject: ");
 			if (!p) break;
 			p +=3D 10;
 			count++;
+			}
 		}
 		p =3D strstr(p+5, "\nFrom ");
 		if (!p)
--=20
2.43.0

