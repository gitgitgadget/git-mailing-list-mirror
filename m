Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010004.outbound.protection.outlook.com [52.103.68.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC715221D80
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753092346; cv=fail; b=bLA3XvkZf4QRUkRAkmavqcqk0hoYzkhpyNU/m3REtrN1vD+s4uXoQa3AP8721tyWlU5GMJQJ2EmoCDqFxSJSM859YSSSeVqHPb0PBV2Pf6GQIyy9dFZ97Cx/cLhQsX9TACYcD7nstet41QdVXBhnJDeAc5Hi8cE3u0k0aVmmcr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753092346; c=relaxed/simple;
	bh=x23OWW5zIKSZbDsLqJBbAh/pGoxCxksD4duR1QcE8Vk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=INCBb1JyWctUpdiuqcJ3lSMon/LmR8PIdg+ygFNomEH4DqtBJKu3I/HpFvrjegb/z/0icKUCDtZBj/U8abe3na0DSFg155dAuyG2f1+ZcNa8kox6oRJC0r9EWEa2C9x4Q9zzN3erzGOxCrd/IvXnh/TyqyUnH6EYzBBKPjNStbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=WV4H28Kt; arc=fail smtp.client-ip=52.103.68.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="WV4H28Kt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0A5JImNyhAanTi9VuoLdXBy+c0WkPtLPIJ+zah/MH8f8W1F18zCMnMgIL7oSFj1uXwr5UI6cliUf3wZQSh6pWLrYsmMX0THjQKdPZkQ+9fvy1sUeSKLSrGQUD6c/+b6a2oHobpOvqnkY+czyxPNihJzyBp/h5zIGvzTpNSlLNlci57RMiJHxaQAinwRN8pl/7FQ3vj3yazCyNkGmzzAk6XnQsIYnu2Ns6MGOLmOCViDMjp6L/W/qqm9zt+ysnz8eHhsC+klWgfgRN6kTTaxJogLctAT6edpiY2pn0WoQEFFGDRdc5++TtaFw8BqmoERbawgu0lxAfPoKZ1rE5YsrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/AR1wYPtN5siw6VMtnIg0oqQZv+fTNoEZsWHFLjg4zo=;
 b=WF0z/WXmOE+JrOrQQZR6Z0sm0mhY2Iq4+fcT6nLejKv5nDF3JGvBcP3mGQLZ38lHj3I/8MvZfvD0o9q2OBIFwT97p/fMwHlb2UhexXYX90EGTXCq7YuJNF0HK0p1NuLuOLsVu+pXbFvbm8lepvrQ5OUy8ULy99uKACEa/cV4JaZSrAW9kCxI9NKlW6Hf2bA71K3GXDomw9++nPZQWRvvD7i4AuK9JZxXnx1jGRSjDl+ZRwFGoPdgDIUdijRD3PwPjnfAFVu6XevbZ5tQPaXWkzc1zMZes2wKvXx66SKY0SBbSUoQE0Sxv54aI7DfM0w9meGrTTj6HAIzyYs+sThMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/AR1wYPtN5siw6VMtnIg0oqQZv+fTNoEZsWHFLjg4zo=;
 b=WV4H28KtAoHHm1enUtJBEtyhWOiirFOBqwyeq+Up4kPeG0me4ufUfU7IIN1J+bV6y5R8MfdHS/blJmMTTMK/vwOfZCeyl79xChFTwnOh6eecWmJ5iGfLFegBWZ6S8Uvr5V4HiHCBGshfHjFkQ3ruAzbwGkMPA2OeBjyRvVIw4LKndWK10HS7qKDCdBKEngX1opUeyhUulY8WHqrUmrFo5hrxlZ70dZQz+6uT5AdFPKtBzzuDf8MpAUC6wxZ4YkAVxSl37NgR0qgbkqD/FJn7L0z3NBHOclEa+Ezgi0A1dU63HM3GGvpFL3pLEw5vqRAPyMLwWWc42wicoTAT4a8IQw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB10089.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 10:05:39 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 10:05:39 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>
CC: Eric Sunshine <sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2] send-email: add ability to send a copy of sent emails to
 an IMAP folder
Thread-Topic: [PATCH v2] send-email: add ability to send a copy of sent emails
 to an IMAP folder
Thread-Index: AQHb+icCP6QpV1qJFUuwKA//pz1KNQ==
Date: Mon, 21 Jul 2025 10:05:39 +0000
Message-ID:
 <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
References:
 <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
In-Reply-To:
 <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB10089:EE_
x-ms-office365-filtering-correlation-id: c74e2588-a90c-489f-8ea0-08ddc83e2513
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|38102599003|461199028|41001999006|3412199025|40105399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?11FuBCqAKbVPEbhRyvazlroxBhijtCi/6KMvbe4Wy0W7sEflk1jZJ6hvEn?=
 =?iso-8859-1?Q?+6ZROi1fDoKkXHLQ7/LhQdmdwK8fBlmUj16Yt2PwA3XzS/zSk5FnuLAYLu?=
 =?iso-8859-1?Q?ix70FW307zWcYqQJQbk3iFfL5FPgvIsSsFPJee12RZGbuYhJ3tRUVDcuWr?=
 =?iso-8859-1?Q?Xnpn1FYDqt1kQ0FDzcucFeltjYIuryWN+QSJn1vwf24HAgWnChuk25oS7D?=
 =?iso-8859-1?Q?HY3qK58sPYyPvMsUN75zCk2DJCj3BRvS8MZyh0k5RCsdALW/AGfsTyb813?=
 =?iso-8859-1?Q?opFzeULzn8VvzY3POaS3JPMz8YCU60VK4S44yfIpEYegPVVhcUfCTdCIUD?=
 =?iso-8859-1?Q?gBFeK5sjXON1HNxXn4JtjN0uAw7gdA1sOAjHixM+LcgBQj9aNaqw0F28iI?=
 =?iso-8859-1?Q?UkG1MKRDw/MU1ji39PHC1W1GA+KNuWP8XX6u/v68YyVexaFA43XZaV5aza?=
 =?iso-8859-1?Q?1TFvTWjswDnN9ZLKOflQ02HS1Bz8gygm2SSmX8mWWhA2a7BNmo2YNRdSFv?=
 =?iso-8859-1?Q?ICLXhyc2oM1wjmyrkBJXuN7r69Jnc7RexF+B34EKoMaV10ZFz8dWHYVA/W?=
 =?iso-8859-1?Q?TxWtjFZp45ayozZuWoQOsw96hx6XxajxWk281eWLjZCk7G1WdUr+6+1f5/?=
 =?iso-8859-1?Q?KQ2geHgzeb7vjH7oZA7uDdBEiGH2Vf6W7Ryui95uSXCoGTwNYIFbMnpTBM?=
 =?iso-8859-1?Q?sxnMAv1RnP3jZdKyH/XW3DwikYdMV7vfU0MXBJIeOFcxMfl3Di74bfkNqX?=
 =?iso-8859-1?Q?R4DtGpViTdiO5EiRRyVMa31jhLbF8R6LRh4qTNlzKGmt8qf0xNtHXY4o4M?=
 =?iso-8859-1?Q?iJ6r+emdFGey83ctU0jVZtSTBD1Ba7pgQOUREX2y3lyWsWVseUEhSTvXQu?=
 =?iso-8859-1?Q?i+3bytMMcnXYkXLoRIWx99Kyk93vbT6vJC6XhftZYkYM44ZpD8T+vCdzhx?=
 =?iso-8859-1?Q?ubszFLd6y7ntcAn3xdfF3X1EkOEwAYAGaQIWWNN3kocq58pnoUC4uTUY7P?=
 =?iso-8859-1?Q?jZ84iZSajnPqirdGPWLnCIOJSq5m0IN/WWS/BdkRVy4ZfykY4RdADluVMG?=
 =?iso-8859-1?Q?kjURkcncslg3Fu7O6TgeVC8T/aFSnSQfekpYFC+58bbDbZDGy1McGoM3o0?=
 =?iso-8859-1?Q?PdWrV2Lg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2WC2xhyppY9gy8n7S6TxVTfiIFlAHsCi1UtKSX2av5IqnDJdQmIagH/gmB?=
 =?iso-8859-1?Q?NJFIUsAlV59YU4UdeN0+wh0Fb2UbwxwG0G/O7qkbutkeKTjPNCR9Z+eFka?=
 =?iso-8859-1?Q?OdPODrslzRx2OOvJ7fbbkFVdwQfLRE+oTSX2XYsWRtpREK1Zh0eCPAibUo?=
 =?iso-8859-1?Q?ru8rC9NdPqZjGQVTxIZlLirQiNpM8RNUuyO68fVRa8esUOPHHcSoPF6Ybh?=
 =?iso-8859-1?Q?Njw0yDP78k3mxsEm4DIcL/wQfR9nEPcZAVYo5He/6izIaB0u3Y8SlJFyA6?=
 =?iso-8859-1?Q?zF/GMeONgE5jFiyyB9o3Nu7+sxIb7ZdsP+w0QA1z0YN+6gsBgP8tTTKeK0?=
 =?iso-8859-1?Q?EU7TlsHQbWU/hM/EiAIuKQpebUXylmwfUTu7cu2kLjRz9hYs4+QCsWmxTQ?=
 =?iso-8859-1?Q?OoEd/27RkRYB8w9xYTlsavB6uNB2ntoitGT0l/BJna3IzUPR1tPjC6tm43?=
 =?iso-8859-1?Q?YXVQaw6XHGdwtWpj/xujY3KIADTwss2LLYzdalptzfSSQqvi8rVatF8cO6?=
 =?iso-8859-1?Q?vva3XHM/9RKEGJemVVJsInHUfqa3Q9NXI8TX2LksFsy/eSMNNVDucAcvGJ?=
 =?iso-8859-1?Q?5ePJO+DFhUNnwQ+/rmxET69m+1HJQPwURpKBLDDeaxTNgnOzaE1j1fI0ZM?=
 =?iso-8859-1?Q?u+s/yZ4RFoNR4r9CgGLJjhqEv1prS0x5P3SLBzgdUZfI8A11O0BPKucCaI?=
 =?iso-8859-1?Q?a7b0IgDWpAs65B3YpJflxQ/1SZxCmr/ZK197R0/wLebzi4d0RzjwbdsnoH?=
 =?iso-8859-1?Q?GWiEzASfF4Wne8xjOu+ELSQQnseV1N97sq0Iq9vw/kty6fK1qxzmEl+uWN?=
 =?iso-8859-1?Q?cECBxNLrcSP3nJP6WYBSolGkmvoDY7MfpBPjpTTpLlEPUh7NfdhfWtJhbL?=
 =?iso-8859-1?Q?sFQ+Y749MO2p1wfAShvUtOYpPxssXwYfod56WZ5UH/xx7UwmTq+r/TJRL3?=
 =?iso-8859-1?Q?q4VT3xYoxTQ5JZyftELSMv2aQo4YD7AUkQ6mXXLqP3zNXT4+93IghI1DC3?=
 =?iso-8859-1?Q?mJValQXC7v/pTHfTbFK6KNseGhC+xHjG6rfABbvI34zA/bMHF9FJ6B2Y7c?=
 =?iso-8859-1?Q?gLXXUDdbeaKQo6cA1HExr+4tMNmnJPCg8o85VoGhBUYBx8d+z01cXfmw6D?=
 =?iso-8859-1?Q?iRlkqXnoMcaOQrx7i3R+PbsvzewV7CsmTss4fiR2UwTpmlrV3Iuv5lZs3B?=
 =?iso-8859-1?Q?+7zY8ADLQPVx844GRuIsdVpVxLibVRWmbcbbVQq4ygMEE6wgKkEPPGDkbn?=
 =?iso-8859-1?Q?lDLYZ8CNeN1q0xRe1WZGYTYw4X3fCpNLzQyRgQ5OY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c74e2588-a90c-489f-8ea0-08ddc83e2513
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2025 10:05:39.1738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10089

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

 Documentation/config/sendemail.adoc |  1 +
 Documentation/git-send-email.adoc   | 12 +++++++++++
 git-send-email.perl                 | 31 ++++++++++++++++++++++++++++-
 imap-send.c                         | 26 ++++++++++++++++--------
 4 files changed, 61 insertions(+), 9 deletions(-)

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
index 437f8ac46a..214a0023bf 100755
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
@@ -2223,6 +2239,19 @@ sub cleanup_compose_files {
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

Range-diff against v1:
1:  c87d31a672 ! 1:  87a8901825 send-email: add ability to send a copy of s=
ent emails to an IMAP folder
    @@ Commit message
         send-email: add ability to send a copy of sent emails to an IMAP f=
older
    =20
         Some email providers like Apple iCloud Mail do not support sending=
 a copy
    -    of sent emails to the "Sent" folder if emails are sent via SMTP. A=
s a
    +    of sent emails to the "Sent" folder if SMTP server is used. As a
         workaround, various email clients like Thunderbird which rely on S=
MTP,
         use IMAP to send a copy of sent emails to the "Sent" folder. Somet=
hing
    -    similar can be done with if sending emails via `git send-email`, b=
y using
    +    similar can be done if sending emails via `git send-email`, by usi=
ng
         the `git imap-send` command to send a copy of the sent email to an=
 IMAP
         folder specified by the user.
    =20
    @@ imap-send.c: static int count_messages(struct strbuf *all_msgs)
     -			p =3D strstr(p+7, "\nDate: ");
     -			if (!p) break;
     -			p =3D strstr(p+7, "\nSubject: ");
    +-			if (!p) break;
    +-			p +=3D 10;
    +-			count++;
     +			if (starts_with(p, "From git-send-email")) {
     +				p =3D strstr(p+5, "\nFrom: ");
     +				if (!p) break;
    @@ imap-send.c: static int count_messages(struct strbuf *all_msgs)
     +				p =3D strstr(p+7, "\nDate: ");
     +				if (!p) break;
     +				p =3D strstr(p+7, "\nSubject: ");
    - 			if (!p) break;
    - 			p +=3D 10;
    - 			count++;
    ++				if (!p) break;
    ++				p +=3D 10;
    ++				count++;
     +			}
      		}
      		p =3D strstr(p+5, "\nFrom ");
--=20
2.50.1.windows.1

