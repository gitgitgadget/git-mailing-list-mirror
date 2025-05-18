Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010002.outbound.protection.outlook.com [52.103.68.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C6D2FB
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747553779; cv=fail; b=Pzuty7gvkS7nbhB3DXyN8ZYETv8/bCLiqRFzSi2OxyXbJDhACceIedPq62FkFciXw25k/Q/Y1r03Fxhx7S6041ohpMZ28PebJ/QQA5XZjtm3vD7BjQMiRq7zEn2iodCEEY4ZqqMRld6zowt3D9ZKBe5XLnSl4TU3kvwvsKSQ3MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747553779; c=relaxed/simple;
	bh=rWswD+3ZRdW+e7PNRVVIBlTBDJME0v7smI9hPohxWgA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YtX7Il6XwQcJac0LueulNhNNaKCRkjHgEzwWYX4+4MMylpmu5B7Wi11no2M8j4yoYaRNS8nFCEyDbP7COliqUPAjmkS2t9ayFK1EgGDV7w602ngIzO5X/dGR1/gra/itPu6RqRe2kmMNVUPSrtVFLRxztW4QJS2aaHBCoXngvQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=oLMUAseU; arc=fail smtp.client-ip=52.103.68.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="oLMUAseU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOQO8Iltuc2jNzawWxfBaAidm2dLyl7MpRiRb9+hz+zjoTBBxTPgILRhtAEOEsqAC1AgI/5UDVSGeFWOI6Lbjrnujr8cGiCxj1ojRFCF0XAUcs0B7NDVqIHLgwYQVXRdsURJDsYNnuvDz3SVVNrIBAw4bPu0QnPLj2etbd8nOx2KUFK+fIaBXGP/OZTUE/7gxiTXYOagF2UILd3w2lQzvJgAD0ij4gXSOGzC/4OeeSoAa4bx06ftfMaqrcuF3pffhnNUJNlD5Bh+JY5xPZAndJucbJxP19pO3BjN1EiTZ1ss5o6h7Slg0U+qndvcEel/+aZgBkG6/hLN7rFu8vZZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOxNwjZaRouvcuYdRu5E/2m31KNTWiOxU0ebmurq6SE=;
 b=NgOVZNs2u2NHlqCVKsywRpd8MFEC0+QHuHIlm2rOTMgjEUiJ6pYaL9AwH9luP9Z97zmyN4/+8fYRYvx9rgt8ZBBl09x5f/21HEIwxe7aQ6awRNBfDWbfWRJJyUsaNc5p07XP5+wkjdAjXBV48DfBS3mRMaGBseiyMDfjLppAz3K4+Ns9Rwaw+tVlno877HxgU7jXkQD/fdEJKELxE8mr8QZqhsNOtUEJu6T4kwN/UOGsLbOyo5t6e2ji9d4+m/9jjS1S9H0T7MzQPecdNSlSAlDGyow3FcIasb+oDvXd0WxAOwST6kEy7ulCRbmC0wkkGmabLt9+H0+a2749au3THA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOxNwjZaRouvcuYdRu5E/2m31KNTWiOxU0ebmurq6SE=;
 b=oLMUAseUTValXv7ZpcP2pNXrFjI2nsZEm0NS163aQT06ySOX0UsKGA+gd/HHHrfbk6bT/RjHW79wXFCb90xgOjftMGy/isbTQehPWK63otUsjGb8XtWkFV8DUCGWETB+Am1exdbImewUhPCJjJbqg62PC4aRFZiY5KlgdqFR54+gXBLeyqLnKYgSn9SX4J6ZQiw2MRV2+3Wq1txqq7+u1Ae2BGUpQqFmhoywh4PoRrDCwb9h/PLhBAtrg/Y2/UfxWxkZly7BwL6AFDc98bM/c5XVGh2g0fCCJVV7BcZYhVLzwOX2w81Ro6D/Bt2JJcsLswixgmIZj8Epkl62upWJeg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6904.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sun, 18 May
 2025 07:36:06 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8746.030; Sun, 18 May 2025
 07:36:06 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 2/3] docs: improve formatting in git-send-email
 documentation
Thread-Topic: [PATCH v3 2/3] docs: improve formatting in git-send-email
 documentation
Thread-Index: AQHbx8eEFiLB619x80+UxP09HmFV1w==
Date: Sun, 18 May 2025 07:36:06 +0000
Message-ID: <76AB293E-3A10-4827-92F2-852836E1F313@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D6BAA98013269897A963B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <6D57A8EA-FDE8-42C9-9541-7B97C2DDBCA1@live.com>
In-Reply-To: <6D57A8EA-FDE8-42C9-9541-7B97C2DDBCA1@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB6904:EE_
x-ms-office365-filtering-correlation-id: 41803715-c8c5-489b-71be-08dd95dea6a9
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799009|8062599006|12121999007|19110799006|15080799009|7092599006|41001999006|461199028|3412199025|440099028|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?L3hQJaAAfoWuvZ/NPxrPlgIzz8CxH+9HB33dsr8nETy2wlWAGdHOOSTU5bVo?=
 =?us-ascii?Q?LReX6QLyIuOO129OKLGn7uS62AtLD6iTdl2k/jnnOR0BH+HXbvOw8wNOcESC?=
 =?us-ascii?Q?+UGhfXSflP+uUP50co8zylAjXh+uBO7mdVBpOx3ge9Ia6vHfAUQh7kc30QTm?=
 =?us-ascii?Q?RgNPcV8rMOlSRQHKR+2oHLUaxDGEXxlPWWQJEP4B0cWUpVHtFIq7wBt60eaV?=
 =?us-ascii?Q?BTmS7X8uDIfaCz55n7IUWB+QfhPtF5H8L+vsuZDyEzusvexCGNHPZ4eWfaK1?=
 =?us-ascii?Q?xIdLHKRNd9XwLtq8WkHM+AFoBrcAjjpS0LHqMocKaD7Z+mP3kC2CH3PVc3Rx?=
 =?us-ascii?Q?UGOpaXYpWy4k6O+PKmXzjCRVTkb5SyKzGJvGiqujfOKQlJuRlelQJpS63POn?=
 =?us-ascii?Q?aC1KbVJUqwkRqg8ZprPmzSVXUhpYRyAHhQLEmQDJx5/f63Df1IYqJUHBj5yj?=
 =?us-ascii?Q?3JiMCHgqNYLHEcLh3WoKrE2ooD4oRRCUxRNAhlbbvc3t6imcHt5qLn5TXE6V?=
 =?us-ascii?Q?m0I1tFinTrnV3VBpIZN4nnnbOqQEFvsuJiSw2aCGO/Zy1qRrnWEv8e7TkX/R?=
 =?us-ascii?Q?/NE9yt8eVCgEqw0T/pZD6Yz3k9XGXlOYUmn0sK7nvQR7LEXxpGSqicdOmPD+?=
 =?us-ascii?Q?C9zzKWFwYSBQBPhyQudMZ/gbh8qBdcW2W+RUVSXkGN2mKNkgWH5/evfbAlHJ?=
 =?us-ascii?Q?9PX1vP3xEfSP7QAFfU99Y7NZDARiGDG3eYB+KMriCv+YCyjRP2Qmqc02RCuZ?=
 =?us-ascii?Q?A/U8TAZ9dGhRbkPbe9yrSSfAVafygWMhUSj9jjE8p2cGTGM42EK0gac+BBfu?=
 =?us-ascii?Q?HHiz/7QSaHFSJxD28DgZHsKhuEUvseNNAlbbzmmsG1/VweKHc5bQKBSDgBTb?=
 =?us-ascii?Q?4WPge5pdA5I+kiZmS7Gw7o+II7h7nU4BE8KnO5SqecJpa8bVfBnRihfcGu1M?=
 =?us-ascii?Q?ECK2wdYfuA9vmyJLm09ssFhAxBexv30llNVCORuPMhAJOt0PSVFoh0A2n4D1?=
 =?us-ascii?Q?oNFVuScq/2RP87cGGcyRsiJoQ/ziEg6E6jpxesVtrAbeWnEqLThkgqi2fnm7?=
 =?us-ascii?Q?EPlRh89huPFy3jnWjmzX9bMEJS5hE7mtS3HCbnTl+yZDDEbEDbvU+B9jHO7N?=
 =?us-ascii?Q?kul4IF9eC+06OJWlVsSr9ta/AVaxrakXNpuLYJUteVLt7Jqw1Y8lXUxpBb85?=
 =?us-ascii?Q?peXTTZRN+9X2SLJqxOBeDZg/RZwz9MLN0+2w3Kmxe1Hv4xgfpI+Bap/RKo4?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1o0BxyuSW12jfsTbM+WZTvn96Sgli7cXRGwhP3V5UoiSTJ8hvP42hgQzSu7e?=
 =?us-ascii?Q?Aj3FpjjmCDn734RnSws7WinHqAJh8v1PQrIfO1BHuqVUSGcdDElFPyDYV7Dc?=
 =?us-ascii?Q?bNCjF30gTKN6Crk8R5issoLViAP5CrO6Aljb3vkrlpKsXLoIBCXpqv8uRVwg?=
 =?us-ascii?Q?2UVe9DaFyRlJiykJJlbWyxmqONmHpkn7pl230gjluY3G+MHb1ViElitX3DyV?=
 =?us-ascii?Q?uWdv4F4fUfUjG5DQy/yliKv2QornPcyea9HfzUEa7WBI7SYt8o45B2FzUVFo?=
 =?us-ascii?Q?i0+J6tSj24QzbIXAyXtTs177Z3J7oFliYNafLmUAHEch2ABeiAUE2GvadYNp?=
 =?us-ascii?Q?36/LrRdoVRGsOef9AGnaKWFF5P7RMZmZVeoiywSJUMCvdc+EtDz2Hlvk2SNx?=
 =?us-ascii?Q?Ywxoki4WoDVT1cgLv13FOiZziNJIVi24AR/xWQVhQOEqW9hCjU5ZAnReowky?=
 =?us-ascii?Q?4m/xnuLa/ZUgt6D4mI+pzURXKBaG0vU4BsRoRCTUISrgUDBOPjJQpgJ3r2ni?=
 =?us-ascii?Q?AO9YT3sgGYwukemNGTtd20/P7U/3ONdvNWKqQ20YUmDwyI8p4s9KOBKbKmtb?=
 =?us-ascii?Q?EltvBui89T+w4e45mEWDQwESLhCohaSZgSJXKoKOsvyV7prv3j1YdluBQS7+?=
 =?us-ascii?Q?THttJGHYtX/bSSdLscefqapmChFk0J1RF7joeNlNq2+udjmuU0lFNwODDPf8?=
 =?us-ascii?Q?LDa4SMSBB4iY6b5hNcFfEac9+AlIuzoMqRwAkTJpPP30rs3RZEsx/O7GOkvZ?=
 =?us-ascii?Q?yP60FkLRPFhL+Eul6MhVxOy28Ib6aTTEvEKosxUF40nsPuX/gFWV9ajGje8a?=
 =?us-ascii?Q?ofAedUyj+v5xEs+jQHUp65wOvlvByBvG4fCJwToeHFcKmYZFxbwwSy6TJ6+k?=
 =?us-ascii?Q?VTxciwl6VH3n3Pz7zJzECXeTlrWvpo/WwWiL/s5HHq4Dgu6LgOWrOSHEFNWL?=
 =?us-ascii?Q?oEf9YVRNXWZT5l5T/6bYn9chLBAq+e6He3IakDsRVqYBFWd6c8jGub3hGj4k?=
 =?us-ascii?Q?AIIsfoXK7MoWTlpWRWp4aY1UI2G6Gn7EtwE19Vgre9KHlelnSuxjw9B8a/sj?=
 =?us-ascii?Q?igHxKhWMWS0XlYgTL9m+nUUEC373TvqrydXHFaNm9AL12pVcQNUoEw0DYf9A?=
 =?us-ascii?Q?dnd9G8oKtzW5+ah9kBz3EGmutasRvpogT32bcbNGFnnxOxEmBUrTz3/CxYtn?=
 =?us-ascii?Q?g6aG+306XmsILufw4TTLPzmHk2SiPa/UFcEj1h6bGpXSppYXEHoh1sfeSZv4?=
 =?us-ascii?Q?ogU+B70ETppJMWiZXCwYPXcgnII+T7AYay8kXAtifTOLStkGuwUeZJQOSCFZ?=
 =?us-ascii?Q?0pWvLBEX5DH5kGxQMygwmrW2?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4D479E7103F3F94DB0C1542E9EE4E963@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 41803715-c8c5-489b-71be-08dd95dea6a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2025 07:36:06.7316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6904

The current documentation for git-send-email had an inconsistent use of
"", ``, and '' for quoting. This commit improves the formatting by
using the same style throughout the documentation.

Also, at some places, minor grammatical errors were fixed, and some
non existent links were removed.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/sendemail.adoc |   8 +-
 Documentation/git-send-email.adoc   | 177 ++++++++++++++--------------
 2 files changed, 94 insertions(+), 91 deletions(-)

diff --git a/Documentation/config/sendemail.adoc b/Documentation/config/sen=
demail.adoc
index 5ffcfc9f2a..0b1b2766f5 100644
--- a/Documentation/config/sendemail.adoc
+++ b/Documentation/config/sendemail.adoc
@@ -19,9 +19,9 @@ sendemail.<identity>.*::
 	`sendemail.identity`.
=20
 sendemail.multiEdit::
-	If true (default), a single editor instance will be spawned to edit
+	If `true` (default), a single editor instance will be spawned to edit
 	files you have to edit (patches when `--annotate` is used, and the
-	summary when `--compose` is used). If false, files will be edited one
+	summary when `--compose` is used). If `false`, files will be edited one
 	after the other, spawning a new editor each time.
=20
 sendemail.confirm::
@@ -101,7 +101,7 @@ sendemail.signedOffCc (deprecated)::
=20
 sendemail.smtpBatchSize::
 	Number of messages to be sent per connection, after that a relogin
-	will happen.  If the value is 0 or undefined, send all messages in
+	will happen.  If the value is `0` or undefined, send all messages in
 	one connection.
 	See also the `--batch-size` option of linkgit:git-send-email[1].
=20
@@ -111,5 +111,5 @@ sendemail.smtpReloginDelay::
=20
 sendemail.forbidSendmailVariables::
 	To avoid common misconfiguration mistakes, linkgit:git-send-email[1]
-	will abort with a warning if any configuration options for "sendmail"
+	will abort with a warning if any configuration options for `sendmail`
 	exist. Set this variable to bypass the check.
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 81f8cbc6f3..cd52150afd 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -21,7 +21,7 @@ Takes the patches given on the command line and emails th=
em out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
 last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email, as well as options understood by
+be passed to `git send-email`, as well as options understood by
 linkgit:git-format-patch[1].
=20
 The header of the email is configurable via command-line options.  If not
@@ -35,11 +35,11 @@ There are two formats accepted for patch files:
 This is what linkgit:git-format-patch[1] generates.  Most headers and MIME
 formatting are ignored.
=20
-2. The original format used by Greg Kroah-Hartman's 'send_lots_of_email.pl=
'
+2. The original format used by Greg Kroah-Hartman's `send_lots_of_email.pl=
`
    script
 +
-This format expects the first line of the file to contain the "Cc:" value
-and the "Subject:" of the message as the second line.
+This format expects the first line of the file to contain the 'Cc:' value
+and the 'Subject:' of the message as the second line.
=20
=20
 OPTIONS
@@ -54,13 +54,13 @@ Composing
 	`sendemail.multiEdit`.
=20
 --bcc=3D<address>,...::
-	Specify a "Bcc:" value for each email. Default is the value of
+	Specify a 'Bcc:' value for each email. Default is the value of
 	`sendemail.bcc`.
 +
 This option may be specified multiple times.
=20
 --cc=3D<address>,...::
-	Specify a starting "Cc:" value for each email.
+	Specify a starting 'Cc:' value for each email.
 	Default is the value of `sendemail.cc`.
 +
 This option may be specified multiple times.
@@ -69,14 +69,14 @@ This option may be specified multiple times.
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
 	to edit an introductory message for the patch series.
 +
-When `--compose` is used, git send-email will use the From, To, Cc, Bcc,
-Subject, Reply-To, and In-Reply-To headers specified in the message. If
-the body of the message (what you type after the headers and a blank
-line) only contains blank (or Git: prefixed) lines, the summary won't be
+When `--compose` is used, `git send-email` will use the 'From', 'To', 'Cc'=
,
+'Bcc', 'Subject', 'Reply-To', and 'In-Reply-To' headers specified in the
+message. If the body of the message (what you type after the headers and a
+blank line) only contains blank (or Git: prefixed) lines, the summary won'=
t be
 sent, but the headers mentioned above will be used unless they are
 removed.
 +
-Missing From or In-Reply-To headers will be prompted for.
+Missing 'From' or 'In-Reply-To' headers will be prompted for.
 +
 See the CONFIGURATION section for `sendemail.multiEdit`.
=20
@@ -85,13 +85,13 @@ See the CONFIGURATION section for `sendemail.multiEdit`=
.
 	the value of the `sendemail.from` configuration option is used.  If
 	neither the command-line option nor `sendemail.from` are set, then the
 	user will be prompted for the value.  The default for the prompt will be
-	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
-	set, as returned by "git var -l".
+	the value of `GIT_AUTHOR_IDENT`, or `GIT_COMMITTER_IDENT` if that is not
+	set, as returned by `git var -l`.
=20
 --reply-to=3D<address>::
 	Specify the address where replies from recipients should go to.
 	Use this if replies to messages should go to another address than what
-	is specified with the --from parameter.
+	is specified with the `--from` parameter.
=20
 --in-reply-to=3D<identifier>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
@@ -112,14 +112,14 @@ illustration below where `[PATCH v2 0/3]` is in reply=
 to `[PATCH 0/2]`:
       [PATCH v2 2/3] New tests
       [PATCH v2 3/3] Implementation
 +
-Only necessary if --compose is also set.  If --compose
+Only necessary if `--compose` is also set.  If `--compose`
 is not set, this will be prompted for.
=20
 --[no-]outlook-id-fix::
 	Microsoft Outlook SMTP servers discard the Message-ID sent via email and
 	assign a new random Message-ID, thus breaking threads.
 +
-With `--outlook-id-fix`, 'git send-email' uses a mechanism specific to
+With `--outlook-id-fix`, `git send-email` uses a mechanism specific to
 Outlook servers to learn the Message-ID the server assigned to fix the
 threading. Use it only when you know that the server reports the
 rewritten Message-ID the same way as Outlook servers do.
@@ -130,14 +130,14 @@ to 'smtp.office365.com' or 'smtp-mail.outlook.com'. U=
se
=20
 --subject=3D<string>::
 	Specify the initial subject of the email thread.
-	Only necessary if --compose is also set.  If --compose
+	Only necessary if `--compose` is also set.  If `--compose`
 	is not set, this will be prompted for.
=20
 --to=3D<address>,...::
 	Specify the primary recipient of the emails generated. Generally, this
 	will be the upstream maintainer of the project involved. Default is the
 	value of the `sendemail.to` configuration value; if that is unspecified,
-	and --to-cmd is not specified, this will be prompted for.
+	and `--to-cmd` is not specified, this will be prompted for.
 +
 This option may be specified multiple times.
=20
@@ -145,30 +145,30 @@ This option may be specified multiple times.
 	When encountering a non-ASCII message or subject that does not
 	declare its encoding, add headers/quoting to indicate it is
 	encoded in <encoding>.  Default is the value of the
-	'sendemail.assume8bitEncoding'; if that is unspecified, this
+	`sendemail.assume8bitEncoding`; if that is unspecified, this
 	will be prompted for if any non-ASCII files are encountered.
 +
 Note that no attempts whatsoever are made to validate the encoding.
=20
 --compose-encoding=3D<encoding>::
 	Specify encoding of compose message. Default is the value of the
-	'sendemail.composeEncoding'; if that is unspecified, UTF-8 is assumed.
+	`sendemail.composeEncoding`; if that is unspecified, UTF-8 is assumed.
=20
 --transfer-encoding=3D(7bit|8bit|quoted-printable|base64|auto)::
 	Specify the transfer encoding to be used to send the message over SMTP.
-	7bit will fail upon encountering a non-ASCII message.  quoted-printable
+	'7bit' will fail upon encountering a non-ASCII message. 'quoted-printable=
'
 	can be useful when the repository contains files that contain carriage
-	returns, but makes the raw patch email file (as saved from a MUA) much
-	harder to inspect manually.  base64 is even more fool proof, but also
-	even more opaque.  auto will use 8bit when possible, and quoted-printable
-	otherwise.
+	returns, but makes the raw patch email file (as saved from an MUA) much
+	harder to inspect manually. 'base64' is even more fool proof, but also
+	even more opaque. 'auto' will use '8bit' when possible, and
+	'quoted-printable' otherwise.
 +
 Default is the value of the `sendemail.transferEncoding` configuration
-value; if that is unspecified, default to `auto`.
+value; if that is unspecified, default to 'auto'.
=20
 --xmailer::
 --no-xmailer::
-	Add (or prevent adding) the "X-Mailer:" header.  By default,
+	Add (or prevent adding) the 'X-Mailer:' header.  By default,
 	the header is added, but it can be turned off by setting the
 	`sendemail.xmailer` configuration variable to `false`.
=20
@@ -179,8 +179,8 @@ Sending
 	Specify the envelope sender used to send the emails.
 	This is useful if your default address is not the address that is
 	subscribed to a list. In order to use the 'From' address, set the
-	value to "auto". If you use the sendmail binary, you must have
-	suitable privileges for the -f parameter.  Default is the value of the
+	value to `auto`. If you use the `sendmail` binary, you must have
+	suitable privileges for the `-f` parameter.  Default is the value of the
 	`sendemail.envelopeSender` configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
=20
@@ -189,8 +189,8 @@ Sending
 	be sendmail-like; specifically, it must support the `-i` option.
 	The command will be executed in the shell if necessary.  Default
 	is the value of `sendemail.sendmailCmd`.  If unspecified, and if
-	--smtp-server is also unspecified, git-send-email will search
-	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
+	`--smtp-server` is also unspecified, `git send-email` will search
+	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH`.
=20
 --smtp-encryption=3D<encryption>::
 	Specify in what way encrypting begins for the SMTP connection.
@@ -209,7 +209,7 @@ Sending
 --smtp-domain=3D<FQDN>::
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
 	HELO/EHLO command to the SMTP server.  Some servers require the
-	FQDN to match your IP address.  If not set, git send-email attempts
+	FQDN to match your IP address.  If not set, `git send-email` attempts
 	to determine your FQDN automatically.  Default is the value of
 	`sendemail.smtpDomain`.
=20
@@ -223,10 +223,10 @@ $ git send-email --smtp-auth=3D"PLAIN LOGIN GSSAPI" .=
..
 +
 If at least one of the specified mechanisms matches the ones advertised by=
 the
 SMTP server and if it is supported by the utilized SASL library, the mecha=
nism
-is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-au=
th`
+is used for authentication. If neither `sendemail.smtpAuth` nor `--smtp-au=
th`
 is specified, all mechanisms supported by the SASL library can be used. Th=
e
-special value 'none' maybe specified to completely disable authentication
-independently of `--smtp-user`
+special value `none` maybe specified to completely disable authentication
+independently of `--smtp-user`.
=20
 --smtp-pass[=3D<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
@@ -238,16 +238,16 @@ Furthermore, passwords need not be specified in confi=
guration files
 or on the command line. If a username has been specified (with
 `--smtp-user` or a `sendemail.smtpUser`), but no password has been
 specified (with `--smtp-pass` or `sendemail.smtpPass`), then
-a password is obtained using 'git-credential'.
+a password is obtained using linkgit:git-credential[1].
=20
 --no-smtp-auth::
-	Disable SMTP authentication. Short hand for `--smtp-auth=3Dnone`
+	Disable SMTP authentication. Short hand for `--smtp-auth=3Dnone`.
=20
 --smtp-server=3D<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  If unspecified, and if
 	`--sendmail-cmd` is also unspecified, the default is to search
-	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH if such a
+	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH` if such a
 	program is available, falling back to `localhost` otherwise.
 +
 For backward compatibility, this option can also specify a full pathname
@@ -260,7 +260,7 @@ instead.
 	Specifies a port different from the default port (SMTP
 	servers typically listen to smtp port 25, but may also listen to
 	submission port 587, or the common SSL smtp port 465);
-	symbolic port names (e.g. "submission" instead of 587)
+	symbolic port names (e.g. `submission` instead of 587)
 	are also accepted. The port can also be set with the
 	`sendemail.smtpServerPort` configuration variable.
=20
@@ -269,7 +269,7 @@ instead.
 	Default value can be specified by the `sendemail.smtpServerOption`
 	configuration option.
 +
-The --smtp-server-option option must be repeated for each option you want
+The `--smtp-server-option` option must be repeated for each option you wan=
t
 to pass to the server. Likewise, different lines in the configuration file=
s
 must be used for each option.
=20
@@ -279,9 +279,8 @@ must be used for each option.
 --smtp-ssl-cert-path::
 	Path to a store of trusted CA certificates for SMTP SSL/TLS
 	certificate validation (either a directory that has been processed
-	by 'c_rehash', or a single file containing one or more PEM format
-	certificates concatenated together: see verify(1) -CAfile and
-	-CApath for more information on these). Set it to an empty string
+	by `c_rehash`, or a single file containing one or more PEM format
+	certificates concatenated together). Set it to an empty string
 	to disable certificate verification. Defaults to the value of the
 	`sendemail.smtpSSLCertPath` configuration variable, if set, or the
 	backing SSL library's compiled-in default otherwise (which should
@@ -298,18 +297,18 @@ must be used for each option.
 	connection and authentication problems.
=20
 --batch-size=3D<num>::
-	Some email servers (e.g. smtp.163.com) limit the number emails to be
+	Some email servers (e.g. 'smtp.163.com') limit the number of emails to be
 	sent per session (connection) and this will lead to a failure when
 	sending many messages.  With this option, send-email will disconnect afte=
r
-	sending $<num> messages and wait for a few seconds (see --relogin-delay)
-	and reconnect, to work around such a limit.  You may want to
-	use some form of credential helper to avoid having to retype
-	your password every time this happens.  Defaults to the
+	sending `$<num>` messages and wait for a few seconds
+	(see `--relogin-delay`) and reconnect, to work around such a limit.
+	You may want to use some form of credential helper to avoid having to
+	retype your password every time this happens.  Defaults to the
 	`sendemail.smtpBatchSize` configuration variable.
=20
 --relogin-delay=3D<int>::
-	Waiting $<int> seconds before reconnecting to SMTP server. Used together
-	with --batch-size option.  Defaults to the `sendemail.smtpReloginDelay`
+	Waiting `$<int>` seconds before reconnecting to SMTP server. Used togethe=
r
+	with `--batch-size` option.  Defaults to the `sendemail.smtpReloginDelay`
 	configuration variable.
=20
 Automating
@@ -318,7 +317,7 @@ Automating
 --no-to::
 --no-cc::
 --no-bcc::
-	Clears any list of "To:", "Cc:", "Bcc:" addresses previously
+	Clears any list of 'To:', 'Cc:', 'Bcc:' addresses previously
 	set via config.
=20
 --no-identity::
@@ -327,13 +326,13 @@ Automating
=20
 --to-cmd=3D<command>::
 	Specify a command to execute once per patch file which
-	should generate patch file specific "To:" entries.
+	should generate patch file specific 'To:' entries.
 	Output of this command must be single email address per line.
-	Default is the value of 'sendemail.toCmd' configuration value.
+	Default is the value of `sendemail.toCmd` configuration value.
=20
 --cc-cmd=3D<command>::
 	Specify a command to execute once per patch file which
-	should generate patch file specific "Cc:" entries.
+	should generate patch file specific 'Cc:' entries.
 	Output of this command must be single email address per line.
 	Default is the value of `sendemail.ccCmd` configuration value.
=20
@@ -341,7 +340,7 @@ Automating
 	Specify a command that is executed once per outgoing message
 	and output RFC 2822 style header lines to be inserted into
 	them. When the `sendemail.headerCmd` configuration variable is
-	set, its value is always used. When --header-cmd is provided
+	set, its value is always used. When `--header-cmd` is provided
 	at the command line, its value takes precedence over the
 	`sendemail.headerCmd` configuration variable.
=20
@@ -350,7 +349,7 @@ Automating
=20
 --[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
-	email sent.  If disabled with "--no-chain-reply-to", all emails after
+	email sent.  If disabled with `--no-chain-reply-to`, all emails after
 	the first will be sent as replies to the first email sent.  When using
 	this, it is recommended that the first file given be an overview of the
 	entire patch series. Disabled by default, but the `sendemail.chainReplyTo=
`
@@ -363,21 +362,22 @@ Automating
 	the value of `sendemail.identity`.
=20
 --[no-]signed-off-by-cc::
-	If this is set, add emails found in the `Signed-off-by` trailer or Cc: li=
nes to the
-	cc list. Default is the value of `sendemail.signedOffByCc` configuration
-	value; if that is unspecified, default to --signed-off-by-cc.
+	If this is set, add emails found in the `Signed-off-by` trailer or 'Cc:'
+	lines to the cc list. Default is the value of `sendemail.signedOffByCc`
+	configuration value; if that is unspecified, default to
+	`--signed-off-by-cc`.
=20
 --[no-]cc-cover::
-	If this is set, emails found in Cc: headers in the first patch of
+	If this is set, emails found in 'Cc:' headers in the first patch of
 	the series (typically the cover letter) are added to the cc list
-	for each email set. Default is the value of 'sendemail.ccCover'
-	configuration value; if that is unspecified, default to --no-cc-cover.
+	for each email set. Default is the value of `sendemail.ccCover`
+	configuration value; if that is unspecified, default to `--no-cc-cover`.
=20
 --[no-]to-cover::
-	If this is set, emails found in To: headers in the first patch of
+	If this is set, emails found in 'To:' headers in the first patch of
 	the series (typically the cover letter) are added to the to list
-	for each email set. Default is the value of 'sendemail.toCover'
-	configuration value; if that is unspecified, default to --no-to-cover.
+	for each email set. Default is the value of `sendemail.toCover`
+	configuration value; if that is unspecified, default to `--no-to-cover`.
=20
 --suppress-cc=3D<category>::
 	Specify an additional category of recipients to suppress the
@@ -401,36 +401,36 @@ Automating
 --
 +
 Default is the value of `sendemail.suppressCc` configuration value; if
-that is unspecified, default to 'self' if --suppress-from is
-specified, as well as 'body' if --no-signed-off-cc is specified.
+that is unspecified, default to 'self' if `--suppress-from` is
+specified, as well as 'body' if `--no-signed-off-cc` is specified.
=20
 --[no-]suppress-from::
-	If this is set, do not add the From: address to the cc: list.
+	If this is set, do not add the 'From:' address to the 'Cc:' list.
 	Default is the value of `sendemail.suppressFrom` configuration
-	value; if that is unspecified, default to --no-suppress-from.
+	value; if that is unspecified, default to `--no-suppress-from`.
=20
 --[no-]thread::
-	If this is set, the In-Reply-To and References headers will be
+	If this is set, the 'In-Reply-To' and 'References' headers will be
 	added to each email sent.  Whether each mail refers to the
-	previous email (`deep` threading per 'git format-patch'
+	previous email (`deep` threading per `git format-patch`
 	wording) or to the first email (`shallow` threading) is
-	governed by "--[no-]chain-reply-to".
+	governed by `--[no-]chain-reply-to`.
 +
-If disabled with "--no-thread", those headers will not be added
-(unless specified with --in-reply-to).  Default is the value of the
+If disabled with `--no-thread`, those headers will not be added
+(unless specified with `--in-reply-to`).  Default is the value of the
 `sendemail.thread` configuration value; if that is unspecified,
-default to --thread.
+default to `--thread`.
 +
 It is up to the user to ensure that no In-Reply-To header already
-exists when 'git send-email' is asked to add it (especially note that
-'git format-patch' can be configured to do the threading itself).
+exists when `git send-email` is asked to add it (especially note that
+`git format-patch` can be configured to do the threading itself).
 Failure to do so may not produce the expected result in the
 recipient's MUA.
=20
 --[no-]mailmap::
 	Use the mailmap file (see linkgit:gitmailmap[5]) to map all
 	addresses to their canonical real name and email address. Additional
-	mailmap data specific to git-send-email may be provided using the
+	mailmap data specific to `git send-email` may be provided using the
 	`sendemail.mailmap.file` or `sendemail.mailmap.blob` configuration
 	values. Defaults to `sendemail.mailmap`.
=20
@@ -441,12 +441,12 @@ Administering
 	Confirm just before sending:
 +
 --
-- 'always' will always confirm before sending
-- 'never' will never confirm before sending
+- 'always' will always confirm before sending.
+- 'never' will never confirm before sending.
 - 'cc' will confirm before sending when send-email has automatically
-  added addresses from the patch to the Cc list
+  added addresses from the patch to the Cc list.
 - 'compose' will confirm before sending the first message when using --com=
pose.
-- 'auto' is equivalent to 'cc' + 'compose'
+- 'auto' is equivalent to 'cc' + 'compose'.
 --
 +
 Default is the value of `sendemail.confirm` configuration value; if that
@@ -460,10 +460,10 @@ have been specified, in which case default to 'compos=
e'.
 	When an argument may be understood either as a reference or as a file nam=
e,
 	choose to understand it as a format-patch argument (`--format-patch`)
 	or as a file name (`--no-format-patch`). By default, when such a conflict
-	occurs, git send-email will fail.
+	occurs, `git send-email` will fail.
=20
 --quiet::
-	Make git-send-email less verbose.  One line per email should be
+	Make `git send-email` less verbose.  One line per email should be
 	all that is output.
=20
 --[no-]validate::
@@ -525,7 +525,7 @@ edit `~/.gitconfig` to specify your account settings:
 ----
=20
 If you have multi-factor authentication set up on your Gmail account, you =
can
-generate an app-specific password for use with 'git send-email'. Visit
+generate an app-specific password for use with `git send-email`. Visit
 https://security.google.com/settings/security/apppasswords to create it.
=20
 You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` and
@@ -599,9 +599,12 @@ helpers.
=20
 Note: the following core Perl modules that may be installed with your
 distribution of Perl are required:
-MIME::Base64, MIME::QuotedPrint, Net::Domain and Net::SMTP.
+
+'MIME::Base64', 'MIME::QuotedPrint', 'Net::Domain' and 'Net::SMTP'.
+
 These additional Perl modules are also required:
-Authen::SASL and Mail::Address.
+
+'Authen::SASL' and 'Mail::Address'.
=20
=20
 SEE ALSO
--=20
2.49.0

