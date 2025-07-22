Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011025.outbound.protection.outlook.com [52.103.68.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D781E520D
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182864; cv=fail; b=qeIkR4YbyTNNRq7n2WJfgdWHGlai0fwVDJvfZb2NQrQXpNEBov2kN7XK4Zmuaz8ee/sQE/scCYJ7oWJ2lqrQBg3TFC81QEooUMiU68NgB5Gw9uu0JHLqj+Qh05F/jB1w5mAIdtrSqpYe054+M4nnjNqqx/r1QsK0SNWqVsADciw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182864; c=relaxed/simple;
	bh=je12htUOIR/REppoqL1AqjfThV37TfxaUaBfVLy/9oc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OuJWFsvvOAYBvFQDAi7hcZYFtUeIK/w5CrKkzXEgMbTlrjLp3inNGq89ixOgy33KypsMfgBEAmN8qplEBPaz4lI7PbRDazswyehdcZ4+lInN86JCaXJ77Nbsj7+54000gOjIJqGX8HviJdIoVShOn7tutjh20l5dy/0mrYVH5qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=m2S8AbBo; arc=fail smtp.client-ip=52.103.68.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="m2S8AbBo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0wIHDIqAZY4aC38hugvbVwjkytJ8S2jugZXjKIgeqf6F3EgR+FJDxcfCPGjbn+fM4ZZ9q5mlG8QyaYRbrTR/kYBfq8B7P092QUfDY8+oyC4DXt7RgOpwojx9whXhwL3YQ9R9J8GMDxPV/9xeOGWZyim6Yk4Xsod2Yx5p0VEECDOfzOY6ZKQBnF/b2PX4nMabkX91ykqlqK4BXNBOSRRlFmQiAxftZmpgCiXB2PCCpZxfdkM46/fimyneXsdSzqRXHrLrvYVwQIQAuUJjnyZ6PuAzyR6WjJqgREz8kBsx381i0bJqDw0wQ2jxGi0AYtgE07899CCK40p6BOnwZ1dnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGqY7NNSEr93YkX4EyP5JUaIKGK/VbtxGyfs5KDjk98=;
 b=lVFU3P+F/n6vK1tnhARUXwPLujXagSDSTjrXel9geZmc79/g5DMYGy70SekUimWYB+atXPu/bEb86SwSnbGU3WkdJi9uxPhxKLlIcsEr1zfbBdiywuBCb/3D7juO4/SLDnA39yX36YujcVvXD524S3TijslXsAznGOhzKlWNl3VrzpUjOq9rBRrr3QnhxHJTc9UwkUefSTnS1T6gebnb/ZzvLkapZJMrol5Jkx9S+RkdzCAe7zy1p/F1CPSRDd63UE3Cr5ovI81WkFHIvkmCB8F4gKx+WZr14OQVHMGW3zCbgalfq04bVau9KK4rV4kdIjsrhzYU8463hGc1elo8wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGqY7NNSEr93YkX4EyP5JUaIKGK/VbtxGyfs5KDjk98=;
 b=m2S8AbBo2EadvXYqfPx0LsowJfi57U99Wz7ZiQyStPp4zDfuD1OufvNY2GUzK7uOSA99NCqtqXY9KpqKN2MXlbMdd8juJSbuk+tD2Le3HPfivW+zoS/xl1lXxix9yvqj6/krrFdDRp6riei+X3OQIplH2ut1rKbONnkuFNGQJqKfKgNs2OpPGL4POSrZz33YLS7TwJWqA/BJaxqk0Zz1cuXjRazE9VNyt/iTHID/Rkmx/iKZBRhlr4ey7n8bLmxj6gc/rL7Nfi+udoy/tLBo2I7zZLifzv7zOytfhuE/g+nsBzBqmyRtVwEQezKiHp+f39Bbv3pF07HkpGNKsRbANA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB8663.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 11:14:16 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 11:14:16 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3] send-email: add ability to send a copy of sent emails to
 an IMAP folder
Thread-Topic: [PATCH v3] send-email: add ability to send a copy of sent emails
 to an IMAP folder
Thread-Index: AQHb+vnDEsKjxOdd+EeTMcePooQufQ==
Date: Tue, 22 Jul 2025 11:14:16 +0000
Message-ID:
 <da7cee769f25871ed3f934e3ec7f2cccf0a0420c.1753182534.git.gargaditya08@live.com>
References:
 <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
In-Reply-To:
 <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB8663:EE_
x-ms-office365-filtering-correlation-id: 35b753a4-87d1-4ed1-14fb-08ddc910e5a2
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|38102599003|41001999006|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?FQ+cde7dIXXuKaNlCwn3cS/0JmM5Gw+iYK+Xd77bG4Lq7kR0jAHKPJYH2s?=
 =?iso-8859-1?Q?1HRDxvd7zcorKfCCbnpa4GNrtcFgJg/MFMCzwixlT3H+z+jeMhK65gvixW?=
 =?iso-8859-1?Q?vdyOE/vCSnvdMpezAw0CQpVPARU5tehvvVCaCGm+y5Vy0/YNDJld5Qgo3B?=
 =?iso-8859-1?Q?dLnDsgu7qdGcva7C2Hh/oDmcq2TXNHSkOpgIzQuaoIptypgwfAilYD0NO4?=
 =?iso-8859-1?Q?ToEHZN0kroNdZT/oK3CAFsUC7Gny+IkwHqrpMNiPh21YS+c4eeOiG26/to?=
 =?iso-8859-1?Q?AutdH8e0JKLYnaOXtLveJtc3zMqjNJ2hTrMbsxemFMl8c8+vbovVowz55U?=
 =?iso-8859-1?Q?DE9mjVexbWQgUlRWFH7HZ/u6Mxzbh15Q3RWMLVsLXaCXxSr+B6g8MamxEG?=
 =?iso-8859-1?Q?eqoPAKGYOI3g1tXxL9VPVcwTD25HTlyrvakRWlV9akYadMt7V7u8vg6x2c?=
 =?iso-8859-1?Q?QB40h/sjg/EBsyXj9byYLPU9B+0wjuEjK1ue3IZ0dkBaRuDXpybfS0eex4?=
 =?iso-8859-1?Q?SfAWB1qHzf2OrjHcVuDGNdVCU6BDP9YZOPPqPV2i5pbyTy0QiMaCPGKmp4?=
 =?iso-8859-1?Q?8J/xMYk+vy8xOYrqlNxCP7UZ+qP0vZf6rzYXfEuYmb+xPHCy/l8UZMDyrO?=
 =?iso-8859-1?Q?VXUIx93Fyzm+j7w+t4OzmmKs5VCYCpuEAc4rvjVYsixilOnbVlbmtcqe3p?=
 =?iso-8859-1?Q?Lybw11aRNcHuhz68BzkRyUc+meNTdoeOOYVfNDuyCAbB0h2VJVWAQoURdO?=
 =?iso-8859-1?Q?VTONRU/PqA8kF/jn72qtCiLDLWPjbgBMZWcYMbe3TgMpVJJQXaTe90i67v?=
 =?iso-8859-1?Q?Z5cAjvIonCDY62b7LiUGl/1/EW4XNijoClRuVdVGxy0Oyrqh8P7kBCdQSr?=
 =?iso-8859-1?Q?aIxkiT/XcJ0M8Dx6HzCkdp9TeRCSHftIQtztUW1Wjh8GSVxZq3eVhK9XBX?=
 =?iso-8859-1?Q?quy/kMIuEuF5ZcfZ8YtZVZBQJqq6FjTHJwzjsaluB9ChKZJwKy/9SwOIAg?=
 =?iso-8859-1?Q?v7nQlIUf+n1IJiZASH2khcGW00DK/ACQM6aZSujt+QaWi5gxetM4VszEQs?=
 =?iso-8859-1?Q?Cmsb9wlj23e70MjESmseoAIzgdxLLzLNBab4D6LDK+zSSkhNmxBuc7QEkc?=
 =?iso-8859-1?Q?XFXX2cqg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fbbyjVC4e+K/+rfI+S0vF44ahtrpp+SrCrQ48vQAzUBdyRytmePynCW8hw?=
 =?iso-8859-1?Q?+QHm7t7VTnHfJkhNmQ3iFTHyIEaiUxhOMCEpQdYV5e+bpZL5oW05K43thU?=
 =?iso-8859-1?Q?jCGI5N/z7BoYYZVoWbN0Tn9S1mln7JkaToRoArvKp3MjPWF69EtjZu7pSH?=
 =?iso-8859-1?Q?Tt7Q5iMDGrbXViNgG7degefFGdrvihMpIMMk41dlxitAwo4ODqjdT3bqPd?=
 =?iso-8859-1?Q?jbGqPpEsaua0Oft4z1Vywv2nwEXGWSewpiyuDiIXN/9IUTG4p8SksaoRwi?=
 =?iso-8859-1?Q?bsKQ9q/W0jyXGm3i91mUH6930SktT6MEoOcJ1gZvJNjBOUZ7/6vFNdje/x?=
 =?iso-8859-1?Q?HQaITNUhUZLyJ4ck/tYOP6z+mkM+zWsx3PfOafGAjXzXeDBl+NZ5IahDv7?=
 =?iso-8859-1?Q?6Ky4hvXD0TFfXIj4D4zCGAVmvHVK7cVQefSwGRfzUnULBrcOzjrVxhZR/K?=
 =?iso-8859-1?Q?9DWVuvwv2IiEcjka7XaxjQCadycWUveZbu/wLWym0vF0n+JDAebn4ttWeL?=
 =?iso-8859-1?Q?/+QE/zX51t1rerhIQq/c8tQcSOuTM9DJJiokuMzJZqWx+Ze5xHVbyEI7IN?=
 =?iso-8859-1?Q?XVHynBSe9c9q3fQzdm+iXHG3esIIPVmVAuzi2wvF14/3WohbYu74U8kVHp?=
 =?iso-8859-1?Q?8pQBTludV0FMEeF8PXxW9+DfERmzJwR3ouU1b0Tw3bcD2WwhkOCpvyHBxs?=
 =?iso-8859-1?Q?CiWcrw1IdM68Gh0cd3FuR6WoS4mup6UbJmlvbwhA6CtzFnWY8ONqpvTJtq?=
 =?iso-8859-1?Q?kSplSLZrzCO7xhozkm/ZYvv5bQLD+CguMyd4gRuTh//XswF1p7wASTBX6M?=
 =?iso-8859-1?Q?5nFLAxqCABYYV0UpMWFZ/XafcBrZJvdojste7vDMCTk2GBHcUdf0xBS2HY?=
 =?iso-8859-1?Q?sneRAI571o+0N/MiK6aea4wpAzxFWG3etEA0cGt05OnBKxtflM7sN9a0O3?=
 =?iso-8859-1?Q?0PEoIeGbK0ZVD6drqo4H4vH3M9GUFvCF7s1UIbBScC4aIjQE6ODrygzzIu?=
 =?iso-8859-1?Q?ICPOa4FP4vwqdr26yqH1RcsvbfO+iYYHHbPA/wGz8nhYF10pT4y0fMv3Pa?=
 =?iso-8859-1?Q?FvV/eCnTYlHnSvQ+KWCBzfkdoBQLT9NdR/vpnXmxAeM20tZYQZp95vQ8R8?=
 =?iso-8859-1?Q?lXEDFDCnpuubpb/BKd/7/V9V4PdW/nv6664oNMQSLH1qdvZXugcpPzhuRF?=
 =?iso-8859-1?Q?TWINvrC0BA9QQi0UQ77vnEUgtuMzcto89dXK82aR6LjFZcX6Oyw12S0B6X?=
 =?iso-8859-1?Q?JgXc2y+r3iXTwlF2XTD35yLQA4D8kt57tuWR/8DQU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b753a4-87d1-4ed1-14fb-08ddc910e5a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 11:14:16.5555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB8663

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
by piping the emails to `git imap-send` command, after the all emails are
sent via SMTP and the SMTP server has been closed.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---

v2 - Fix indentation in patch for imap-send.c
   - Minor edits to commit message

v3 - Rename imap folder to imap sent folder
   - Make an error message shorter by removing unecessary details

 Documentation/config/sendemail.adoc |  1 +
 Documentation/git-send-email.adoc   | 12 +++++++++++
 git-send-email.perl                 | 31 ++++++++++++++++++++++++++++-
 imap-send.c                         | 26 ++++++++++++++++--------
 4 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/Documentation/config/sendemail.adoc b/Documentation/config/sen=
demail.adoc
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
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 5335502d68..82a65fd47f 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -299,6 +299,18 @@ must be used for each option.
 	commands and replies will be printed. Useful to debug TLS
 	connection and authentication problems.
=20
+--imap-sent-folder=3D<folder>::
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
index 437f8ac46a..5aafe8cdf3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -73,6 +73,8 @@ sub usage {
     --no-smtp-auth                 * Disable SMTP authentication. Shorthan=
d for
                                      `--smtp-auth=3Dnone`
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
+    --imap-sent-folder      <str>  * IMAP folder where a copy of the email=
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
+my ($imap_sent_folder);
 my ($confirm);
 my (@suppress_cc);
 my ($auto_8bit_encoding);
@@ -322,6 +325,7 @@ sub do_edit {
     "smtpauth" =3D> \$smtp_auth,
     "smtpbatchsize" =3D> \$batch_size,
     "smtprelogindelay" =3D> \$relogin_delay,
+    "imapsentfolder" =3D> \$imap_sent_folder,
     "to" =3D> \@config_to,
     "tocmd" =3D> \$to_cmd,
     "cc" =3D> \@config_cc,
@@ -527,6 +531,7 @@ sub config_regexp {
 		    "smtp-domain:s" =3D> \$smtp_domain,
 		    "smtp-auth=3Ds" =3D> \$smtp_auth,
 		    "no-smtp-auth" =3D> sub {$smtp_auth =3D 'none'},
+		    "imap-sent-folder=3Ds" =3D> \$imap_sent_folder,
 		    "annotate!" =3D> \$annotate,
 		    "compose" =3D> \$compose,
 		    "quiet" =3D> \$quiet,
@@ -1829,6 +1834,17 @@ sub send_message {
 		print "\n";
 	}
=20
+	if ($imap_sent_folder) {
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
@@ -2223,6 +2239,19 @@ sub cleanup_compose_files {
=20
 $smtp->quit if $smtp;
=20
+if ($imap_sent_folder && @imap_copy) {
+	my $imap_input =3D join("\n", @imap_copy);
+	eval {
+		print "\nStarting git imap-send...\n";
+		my ($fh, $ctx) =3D Git::command_input_pipe(['imap-send', '-f', $imap_sen=
t_folder]);
+		print $fh $imap_input;
+		Git::command_close_pipe($fh, $ctx);
+		1;
+	} or do {
+		warn "Warning: failed to send messages to IMAP folder $imap_sent_folder:=
 $@";
+	};
+}
+
 sub apply_transfer_encoding {
 	my $message =3D shift;
 	my $from =3D shift;
diff --git a/imap-send.c b/imap-send.c
index f5a656ac71..44de0c5a77 100644
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
-			if (!p) break;
-			p +=3D 10;
-			count++;
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
+				if (!p) break;
+				p +=3D 10;
+				count++;
+			}
 		}
 		p =3D strstr(p+5, "\nFrom ");
 		if (!p)

Range-diff against v2:
1:  01084f57f9 ! 1:  da7cee769f send-email: add ability to send a copy of s=
ent emails to an IMAP folder
    @@ Documentation/config/sendemail.adoc: sendemail.smtpServer::
      sendemail.smtpServerPort::
      sendemail.smtpServerOption::
      sendemail.smtpUser::
    -+sendemail.imapfolder::
    ++sendemail.imapSentFolder::
      sendemail.thread::
      sendemail.transferEncoding::
      sendemail.validate::
    @@ Documentation/git-send-email.adoc: must be used for each option.
      	commands and replies will be printed. Useful to debug TLS
      	connection and authentication problems.
     =20
    -+--imap-folder=3D<folder>::
    ++--imap-sent-folder=3D<folder>::
     +	Some email providers (e.g. iCloud) do not send a copy of the emails =
sent
     +	using SMTP to the `Sent` folder or similar in your mailbox. Use this=
 option
     +	to use `git imap-send` to send a copy of the emails to the folder sp=
ecified
    @@ git-send-email.perl: sub usage {
          --no-smtp-auth                 * Disable SMTP authentication. Sho=
rthand for
                                           `--smtp-auth=3Dnone`
          --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
    -+    --imap-folder           <str>  * IMAP folder where a copy of the =
emails should be sent.
    ++    --imap-sent-folder      <str>  * IMAP folder where a copy of the =
emails should be sent.
     +                                     Make sure `git imap-send` is set=
up to use this feature.
     =20
          --batch-size            <int>  * send max <int> message per conne=
ction.
    @@ git-send-email.perl: sub do_edit {
      my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
      my ($batch_size, $relogin_delay);
      my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth=
);
    -+my ($imap_folder);
    ++my ($imap_sent_folder);
      my ($confirm);
      my (@suppress_cc);
      my ($auto_8bit_encoding);
    @@ git-send-email.perl: sub do_edit {
          "smtpauth" =3D> \$smtp_auth,
          "smtpbatchsize" =3D> \$batch_size,
          "smtprelogindelay" =3D> \$relogin_delay,
    -+    "imapfolder" =3D> \$imap_folder,
    ++    "imapsentfolder" =3D> \$imap_sent_folder,
          "to" =3D> \@config_to,
          "tocmd" =3D> \$to_cmd,
          "cc" =3D> \@config_cc,
    @@ git-send-email.perl: sub config_regexp {
      		    "smtp-domain:s" =3D> \$smtp_domain,
      		    "smtp-auth=3Ds" =3D> \$smtp_auth,
      		    "no-smtp-auth" =3D> sub {$smtp_auth =3D 'none'},
    -+		    "imap-folder=3Ds" =3D> \$imap_folder,
    ++		    "imap-sent-folder=3Ds" =3D> \$imap_sent_folder,
      		    "annotate!" =3D> \$annotate,
      		    "compose" =3D> \$compose,
      		    "quiet" =3D> \$quiet,
    @@ git-send-email.perl: sub send_message {
      		print "\n";
      	}
     =20
    -+	if ($imap_folder) {
    ++	if ($imap_sent_folder) {
     +		my $imap_header =3D $header;
     +		if (@initial_bcc) {
     +			# Bcc is not a part of $header, so we add it here.
    @@ git-send-email.perl: sub cleanup_compose_files {
     =20
      $smtp->quit if $smtp;
     =20
    -+if ($imap_folder && @imap_copy) {
    ++if ($imap_sent_folder && @imap_copy) {
     +	my $imap_input =3D join("\n", @imap_copy);
     +	eval {
     +		print "\nStarting git imap-send...\n";
    -+		my ($fh, $ctx) =3D Git::command_input_pipe(['imap-send', '-f', $ima=
p_folder]);
    ++		my ($fh, $ctx) =3D Git::command_input_pipe(['imap-send', '-f', $ima=
p_sent_folder]);
     +		print $fh $imap_input;
     +		Git::command_close_pipe($fh, $ctx);
     +		1;
     +	} or do {
    -+		warn "Warning: failed to send messages to IMAP folder $imap_folder =
via imap-send pipe: $@";
    ++		warn "Warning: failed to send messages to IMAP folder $imap_sent_fo=
lder: $@";
     +	};
     +}
     +
--=20
2.50.1.319.gda7cee769f

