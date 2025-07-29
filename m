Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8195F298990
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753809062; cv=fail; b=aNXYvVKSLIXf2mMK59hVur4Qth847b0YUypsN9tvtwK6/N3GPCQJGlZp6/JkSpAp9NmXkBph4TVqNy0dZbqDiESbqDh4p7oEy91aKPC646TqY3yUdD0JBdgpgpO16kahPKWci+E3vSfT2I3n7WaUTKmcU0YAq7hZgrT8eWMYqKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753809062; c=relaxed/simple;
	bh=Un18b39nDBDbL6PakM4kPPU6dx9kfXFxrTwQnZjAxNg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RDoVWlJkXaxET3RAIXhpBvOmFA66pECi4+v7r3LXEvTwHWfm/YL1jxCmK+2c9mX+IRPV5KYL+zKA9bY1nXeCpr3Y9dBA1ZgYPEGu4eJRXeZRdUEIe0IUI7quCROvn8td3CzAF2b9xUGPlzmrxKRS8mwluigbRa7r1ZD2RFfLuzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=mCoL5gix; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="mCoL5gix"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UBkwy9FC7BhZvxkStPnUyRM1NcYGqoWJZC014S0aU0jArGI8LA7NdfcDgQAQ5Sm+yqhS2seVAI5alUhcY9LTqf8M48sUU9hWgtlj+0d8hIYXdktbt01lmD0SlJ5iSUo1q2edIca9Sz87O0JZ/aHqEHHfeSjTULsjcFj2R+Uq8k7bnz3EDEAvJmh5qrTte8lYpZz/f1LDu3ajKiZ2bJ+/J4tEeYnazF3hdHEbE0OOPc+hiOfoxXGuK9CFIv9fcycVcvtv235rDsHAaOxbV/S97yLjZXykNKtj8XWcU2BJfX9lB5/cqO2guDq3pScERJAe9DpJIgniwazmguIGGrDg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aImc5tB6+spZ3//4p8nPoA6m//01wZYC1QlKuosfH/I=;
 b=tvVAN6hCtvzrBUGTm+zgvdgkoy9LEIXtZaiXAPYCFuzcJwsvHVuuLwa2QcmutjT7P6fUzSy/5u++pQNwgBoiI1IOFoNXLC6nML7pkqu3NDPhuzks0FJuP92m6+InsFzpznQmppXoq8NssjkpzricP8ds4fhzgRJUhh8q4vFLRP5CMNRrf74tQXnOKgLi3el/EosCux+5E3FRCj2tqFYEZ34OJPUYlfh76Ig44J6TLrz4C4lBBK4iVa+0vrw+AwdowP/mwNAItcPUClzwGi+DH6GTeNSDs8i6FqEI39JCMApDjv6N/rkRlK15nattjhigaJ1JQ77QNTJZ5nRES+lfpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aImc5tB6+spZ3//4p8nPoA6m//01wZYC1QlKuosfH/I=;
 b=mCoL5gixLLGaQKVwzK9q0bHCnRDk98UeoylvZkUEa4QmLN73hplVEBjQRzSjK1sS5tBJjcbOHONcUmHoZDLtZYd344xQ9iiWeVk0lUvHU4Jb6jcYdMnk5P0pddoMuUxKubTvYdNxC3720AFLFanhtKgYd/7V3kKworY+anxGB+ttD4qRnEzmkjE6jJwjt44nqgZk+fVfbRJGny40VDRp72VA/9L3ovJEnfAW0XuoQC9hgrNtP0SOU73NM1kE3yW9tx46CdeK+/conPlLDWI11Yv9965td1epjlRLXJVRAX+JOvlYopVaVUp85WADuLg3zpvH/p/I41XCZ7zSoeQoYA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9559.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 17:10:54 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 17:10:54 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] send-email: add --get-smtp-server option to fetch SMTP settings
Date: Tue, 29 Jul 2025 22:40:32 +0530
Message-ID:
 <PN3PR01MB9597763982F1AB6B5E5806CBB825A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.50.1.320.g2ad311502d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0231.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250729171032.47773-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d68f103-acbc-4be7-ddd8-08ddcec2e049
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|19110799012|15080799012|5072599009|41001999006|5062599005|461199028|1602099012|3412199025|40105399003|440099028|4302099013|10035399007|12091999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8HrKrbizSQvYbNG+YfAkW3ZurQ0X+oUC67jdGMfIaid/UnZwqoyM7baOVcBl?=
 =?us-ascii?Q?qTKEATYRSQQUaD18N1zXRo7sxWjBdF6gJ20w4aCbbBgHrQH8RymamjXTAC6f?=
 =?us-ascii?Q?sI0h3W0YAuuDCfFQsxpZbvKCA0czOMT/7FCnQ8g6/WCtUJpxhyKR+npP3T70?=
 =?us-ascii?Q?9HFqR9KK0JddXBIpaY2vIDL5NCPGz5WnDY9SyymZ9pqob7isKdK9isPsSIrr?=
 =?us-ascii?Q?BeQBLBmT8ko7L4VOlnqkgTLPYqz0gSR1UdxhJbblotPdEr07a6NkCssVh+Im?=
 =?us-ascii?Q?xKoaUA1fU50BbasmUYyJaveIVDPu0W9JtzTFDOLO9cmWENRkg/rF6dS8fFIj?=
 =?us-ascii?Q?kYt6V0rn5/gnis2froqWQh+4ztJudePuMurrbkZ7PM5EqUNknYzaUDrTFKmj?=
 =?us-ascii?Q?S1+LiLJUmplvXLxZSuXZCz8VZjRLZe/JCK1HZOloTY0yruQfkyZggarwIHrL?=
 =?us-ascii?Q?yqKvH+Ym23kOHhHpXDRLC24U+hezU8G35ZZOTYSlM8rZBh7HACVS9wpbITSC?=
 =?us-ascii?Q?wnv6I/CAPyRBRcc0+DpzHb0pmTkx5dqym+fm1/aTy31jdt+jP597HRz4l+H7?=
 =?us-ascii?Q?ekzvm6wgk+ZJrk+1Zo2ukUxvcGBUBHYvudB+XAImrbAkYyJcNb/bYDeOkpRm?=
 =?us-ascii?Q?e0OWjp3YyUhvEH9/k7035CROfxuQiinZpO/AezBV7sgRhXYtNUNrxQcICQi+?=
 =?us-ascii?Q?NzvmuIYw3ct5bjaYAxGuzRIu7RyCWXBfCmYXkmLkRABGli4/JSbtStNfLEGx?=
 =?us-ascii?Q?4EqyisXBFx7lEtXgSHawEC/uDk4Kr64edzKt+Dh7hMm75nk1F9eXw3QLq8ON?=
 =?us-ascii?Q?AdGH2QKn5d8UCCIP1NRPL9eBvVV9rbRh0HxrdlESLC/6pxo+gTni3izvzsSJ?=
 =?us-ascii?Q?OonuA2uaKdos1ljkhN/RgxQLIlD6/ZnzucgCy5LEy3TljjNlb9TjwQ2Zzfte?=
 =?us-ascii?Q?WryMKiJvZAs1+4OIauyG1tEiyIbHo2gMQmHRkPoBzRe2jnP4iPplfjnajh5y?=
 =?us-ascii?Q?jVt/XQvGbUOMeddH27kTWMGbyr7KXJCpJCLlM+IFvrsUxGEmGt/7gzyeTpzR?=
 =?us-ascii?Q?t73T70qfRs1y8U8MJVWIc9RAwTvwkPFOCq569FjjGB8971OluUVATc6/RJdb?=
 =?us-ascii?Q?+5FiNiBvKYXiwdd7u8RD/fwa/8GBfYf1AEwFc4lMIqsewLbnqqpYu0p2mzDI?=
 =?us-ascii?Q?jrgbXZ/OCxa8l1SwOS67C0jyaTsjfVmqo/LuTFW9egVS8j2Zb9qGpL0HZJLL?=
 =?us-ascii?Q?L4+yY29dKY9fdx0wxZKY7kRXVCyXRcebdcyspTprOHoCiXKPsRVKk9GiTWY7?=
 =?us-ascii?Q?VzKAEexJRnaW2IxUVRZ16Bve?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6jSpS052L1Ahc4RF4pa0/B36di2Z8rWJmCFh9uy61He/Wk7I7s+gNA25kxX?=
 =?us-ascii?Q?ris3WWQA0G5YoQpYiOwd27QdX39SBae8L/0Z5HhHv9qhE5MGHzJw13LibI70?=
 =?us-ascii?Q?1sBIKvoNoHbd5HfTLe+KUbz7WJec1YMSzCgmj5Bn+/zRqOyGQ2hhIXDfDKec?=
 =?us-ascii?Q?6uM4UYnWufL+YJc0U/POwo0Hp2bykMsYU4C1lHyQaM4CbbFFwB6ZqZ0N6Emx?=
 =?us-ascii?Q?qw0LrjkEm73iEUk52/t/9PeRRG6ohe8eGCxgKCR2p1w9AngKYGBaFkkZPLht?=
 =?us-ascii?Q?yCFHI05LroMk7x1OsUN9QmMnAJz0XJgV4rA2n7VfAdwOegz0nKkmsz1TyIeJ?=
 =?us-ascii?Q?Np5d0yscqT67Gknvr9jS617mCHLD58TG2pnHDbOLE2aD3eidXljymAYEi1MK?=
 =?us-ascii?Q?IUJxKEL78SZJCMH1ZoL7iJwyt9iUHHHbFWTKg6fnMhPNyEd5suVwii8IIJfw?=
 =?us-ascii?Q?4JjQBrBloOK+XioBq1uBbKUWb3XWIeP5tjmc0rV8CuHacoksq7yuAyaO4D0Z?=
 =?us-ascii?Q?ScduGp/mWFw7KyfGj5INQNJPwpSVplakFRa/XMlcK10Z1dT1FRk1hSv6ck3Z?=
 =?us-ascii?Q?F2lyamxk7N3r1CG2Q5IiKxLcOC+/pavxihKxW5XqhDmOouwlY6NMKCDRuvUc?=
 =?us-ascii?Q?buwp3eha/OZlxnQFFR9Ju9XYp5AyHPoKHAkdlGvQVp+eAeAKEFw9XenWtYml?=
 =?us-ascii?Q?y0wa06kebe08HU3ddZTkYBriMYkPCTDIaQgU4HtUUQ0E/Sgukl55d9IXc/Mj?=
 =?us-ascii?Q?5QrPA0CKnPZbQ+LVGFC/QCq/JT46WkwPtLleG4CqX0S0YVbdg6CCyZwxuBhW?=
 =?us-ascii?Q?Xa4lgxj9qcmULalMd3ydvtA3FW8DdUkskeHcilrZ/Un5o3ypNqw/AHg8uqMH?=
 =?us-ascii?Q?bse4m1d/7KZz5FPXkvo58m2GeVcf75+FgtUvKeArgHzHfQ7JgaF5D4PHsKMX?=
 =?us-ascii?Q?gkegyTnSPDhpjmZSWMpRIl31mjMyI+15PysiAjCRe8C7eIGeXZ+HLzZQABfy?=
 =?us-ascii?Q?ojxLjqTzuVmxwv9Mt4nE8Jbo94A0KSlI9310zx5U0M69im00KAAHGrZt7Jyj?=
 =?us-ascii?Q?vC/5TV7r+KjFbFU7KyKAZRpZnjethK5WbuTJxfczOdebMQP2ljyZrVWz+VlZ?=
 =?us-ascii?Q?jGM/6RiwJ9nas+c2B+p9kBRZyrim4LCzRtKR1v3S89ZxbK+UZtd7rcidmsSt?=
 =?us-ascii?Q?LRto6aNDjYX5qcMy2W2tSsyzJ89uda5y0uKMBsuiKr/AraTx8NAsjlU7nGUD?=
 =?us-ascii?Q?5yuOh2QLUcDAnJscV4GgRrfrw618jqJS/ZvMK/6F8Gp9ajUomgNhsL9PhwEk?=
 =?us-ascii?Q?x2cAOAWQ5UKYOa4+A78g6AGb?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d68f103-acbc-4be7-ddd8-08ddcec2e049
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 17:10:54.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9559

Autoconfiguring SMTP server settings is a common feature present in many
email clients. In order to get the correct SMTP server settings easily,
this commit adds a `--get-smtp-server` option to `git send-email`. This
option attempts to fetch the SMTP server settings for a given email address
via the following steps:

1. It first tries to fetch the settings from Mozilla's ISPDB at
   `https://autoconfig.thunderbird.net/v1.1/[domain]`.

2. If that fails, it attempts to fetch the autoconfig file from the email
   provider's autoconfig URL, which is typically in the format
   `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=[email]`.

3. If that also fails, it falls back to checking the MX records of the
   domain used in the email address to find the SMTP server. It can be
   useful in case of emails with custom domains. It attempts to guess
   the correct domain for the email from the MX records, and repeats the
   first 2 steps with the guessed domain.

This feature is heavily inpired by the autoconfig feature in Mozilla
Thunderbird. A detailed documentation about how thunderbird fetches the
autoconfig settings can be found at:

https://www.bucksch.org/1/projects/thunderbird/autoconfiguration/
---
 Documentation/git-send-email.adoc |  55 ++++++++++-
 git-send-email.perl               | 153 +++++++++++++++++++++++++++++-
 2 files changed, 205 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 5335502d68..d4fb761b4f 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -13,6 +13,7 @@ SYNOPSIS
 'git send-email' [<options>] <format-patch-options>
 'git send-email' --dump-aliases
 'git send-email' --translate-aliases
+'git send-email' --get-smtp-server
 
 
 DESCRIPTION
@@ -505,6 +506,15 @@ Information
 	address to standard output, one per line. See `sendemail.aliasFile`
 	for more information about aliases.
 
+--get-smtp-server::
+	Attempt to get the correct SMTP server settings by entering an email
+	address. Once an email address is entered, it will first try to get
+	the correct settings from
+	https://autoconfig.thunderbird.net/v1.1/[Mozilla's ISPDB], followed
+	by attempting to check for an autoconfig file hosted by the email
+	provider, finally falling back to the MX records of the domain used
+	by the email address.
+
 CONFIGURATION
 -------------
 
@@ -512,6 +522,44 @@ include::includes/cmd-config-section-all.adoc[]
 
 include::config/sendemail.adoc[]
 
+GETTING THE CORRECT SMTP SERVER SETTINGS
+----------------------------------------
+
+You can attempt to get the correct SMTP server settings by using
+the `--get-smtp-server` command line option with `git send-email`.
+It will ask you for your email address, then attempt to get the
+correct SMTP server settings for that email address. An email
+address may have more than one configuration. In that case, any of
+them can be used.
+
+For example, an output with email `someone@pobox.com` yields:
+
+----
+Configuration 1:
+  Server: smtp.pobox.com
+  Port: 465
+  Encryption: ssl
+  Username: ssw@pobox.com
+
+Configuration 2:
+  Server: smtp.pobox.com
+  Port: 587
+  Encryption: tls
+  Username: ssw@pobox.com
+----
+
+Here the value of:
++
+- `Server` corresponds to `sendmail.smtpServer`.
+- `Port` corresponds to `sendmail.smtpServerPort`.
+- `Encryption` corresponds to `sendmail.smtpEncryption`.
+- `Username` corresponds to `sendmail.smtpUser`.
++
+
+This method should work well for almost all large email providers in the
+world. If it provides invalid settings or cannot retrieve them, contact
+your email provider.
+
 EXAMPLES OF SMTP SERVERS
 ------------------------
 Use Gmail as the SMTP Server
@@ -624,8 +672,11 @@ https://metacpan.org/pod/Net::SMTP[Net::SMTP].
 
 These additional Perl modules are also required:
 
-https://metacpan.org/pod/Authen::SASL[Authen::SASL] and
-https://metacpan.org/pod/Mail::Address[Mail::Address].
+https://metacpan.org/pod/Authen::SASL[Authen::SASL],
+https://metacpan.org/pod/Mail::Address[Mail::Address],
+https://metacpan.org/pod/Net::DNS[Net::DNS],
+https://metacpan.org/pod/URI::Escape[URI::Escape] and
+https://metacpan.org/dist/XML-LibXML[XML::LibXML].
 
 Exploiting the `sendmailCmd` option of `git send-email`
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/git-send-email.perl b/git-send-email.perl
index 437f8ac46a..60bc1f2adb 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -32,6 +32,7 @@ sub usage {
 git send-email [<options>] <format-patch options>
 git send-email --dump-aliases
 git send-email --translate-aliases
+git send-email --get-smtp-server
 
   Composing:
     --from                  <str>  * Email From:
@@ -108,6 +109,7 @@ sub usage {
                                      input according to the configured email
                                      alias file(s), outputting the result to
                                      standard output.
+    --get-smtp-server              * Print the SMTP server settings for a given email.
 
 EOT
 	exit(1);
@@ -222,6 +224,7 @@ sub format_2822_time {
 my $force = 0;
 my $dump_aliases = 0;
 my $translate_aliases = 0;
+my $get_smtp_server = 0;
 
 # Variables to prevent short format-patch options from being captured
 # as abbreviated send-email options
@@ -501,6 +504,15 @@ sub config_regexp {
     if !$help and ($dump_aliases or $translate_aliases) and @ARGV;
 die __("--dump-aliases and --translate-aliases are mutually exclusive\n")
     if !$help and $dump_aliases and $translate_aliases;
+
+my %get_smtp_server_options = (
+	"get-smtp-server" => \$get_smtp_server,
+);
+$rc = GetOptions(%get_smtp_server_options);
+usage() unless $rc;
+die __("--get-smtp-server incompatible with other options\n")
+	if !$help and $get_smtp_server and @ARGV;
+
 my %options = (
 		    "sender|from=s" => \$sender,
 		    "in-reply-to=s" => \$initial_in_reply_to,
@@ -565,7 +577,7 @@ sub config_regexp {
 my @initial_bcc = @getopt_bcc ? @getopt_bcc : ($no_bcc ? () : @config_bcc);
 
 usage() if $help;
-my %all_options = (%options, %dump_aliases_options, %identity_options);
+my %all_options = (%options, %dump_aliases_options, %identity_options, %get_smtp_server_options);
 completion_helper(\%all_options) if $git_completion_helper;
 unless ($rc) {
     usage();
@@ -757,6 +769,145 @@ sub parse_sendmail_aliases {
 	exit(0);
 }
 
+sub fetch_config_mozilla_ispdb {
+	my ($domain) = @_;
+	my $ispdb_url = "https://autoconfig.thunderbird.net/v1.1/$domain";
+	my $xml = fetch_config($ispdb_url);
+	return $xml if $xml;
+}
+
+sub fetch_config_domain_autoconfig {
+	my ($domain, $email_enc) = @_;
+	my $autoconfig_url = "https://autoconfig.$domain/mail/config-v1.1.xml?emailaddress=$email_enc";
+	my $xml = fetch_config($autoconfig_url);
+	return $xml if $xml;
+}
+
+sub fetch_config {
+	require HTTP::Tiny;
+	my ($url) = @_;
+	my $http = HTTP::Tiny->new(timeout => 10);
+	my $res = $http->get($url);
+
+	return unless $res->{success};
+	return $res->{content};
+}
+
+sub extract_base_domain {
+	require IO::Socket::SSL::PublicSuffix;
+	my ($host) = @_;
+	my $ps = IO::Socket::SSL::PublicSuffix->default;
+
+	my $public_suffix = $ps->public_suffix($host);
+	return $host unless defined $public_suffix;
+
+	my @host_parts = split(/\./, lc($host));
+	my @suffix_parts = split(/\./, $public_suffix);
+
+	# Find where the suffix starts in the host
+	for (my $i = 0; $i <= $#host_parts - $#suffix_parts; $i++) {
+		if (join('.', @host_parts[$i .. $#host_parts]) eq $public_suffix) {
+			# Precursor + suffix = base domain
+			return join('.', $host_parts[$i - 1], @host_parts[$i .. $#host_parts]) if $i > 0;
+			return $public_suffix;
+		}
+	}
+
+	return $host;
+}
+
+sub get_mx_base_domain {
+	require Net::DNS;
+	my ($domain) = @_;
+	my $resolver = Net::DNS::Resolver->new;
+	my $query = $resolver->query($domain, "MX");
+
+	if ($query) {
+		my @mx_hosts = sort { $a->preference <=> $b->preference } grep { $_->type eq "MX" } $query->answer;
+		if (@mx_hosts) {
+			my $mx_host = $mx_hosts[0]->exchange;
+			$mx_host =~ s/\.$//;  # Remove trailing dot
+			return extract_base_domain($mx_host);
+		}
+	}
+	return;
+}
+
+sub parse_config {
+	require XML::LibXML;
+	my ($xml, $email) = @_;
+	my $parser = XML::LibXML->new;
+	my $doc = eval { $parser->load_xml(string => $xml) };
+	die "Failed to parse XML\n" unless $doc;
+	my $config_num = 0;
+	my $smtp_encryption_config;
+	my $smtp_user_config;
+
+	foreach my $outgoing ($doc->findnodes('//outgoingServer')) {
+		$config_num++;
+		if ($outgoing->findvalue('./socketType') eq 'SSL') {
+			$smtp_encryption_config = 'ssl';
+		} elsif ($outgoing->findvalue('./socketType') eq 'STARTTLS') {
+			$smtp_encryption_config = 'tls';
+		} else {
+			$smtp_encryption_config = 'plain';
+		}
+
+		if ($outgoing->findvalue('./username') eq '%EMAILADDRESS%') {
+			$smtp_user_config = $email;
+		} elsif ($outgoing->findvalue('./username') eq '%EMAILLOCALPART%') {
+			$smtp_user_config = (split /@/, $email)[0];
+		} elsif ($outgoing->findvalue('./username') eq '%EMAILDOMAIN%') {
+			$smtp_user_config = (split /@/, $email)[1];
+		} else {
+			$smtp_user_config = $outgoing->findvalue('./username');
+		}
+
+		print "\nConfiguration $config_num:\n";
+		print "  Server: ", $outgoing->findvalue('./hostname'), "\n";
+		print "  Port: ", $outgoing->findvalue('./port'), "\n";
+		print "  Encryption: ", $smtp_encryption_config, "\n";
+		print "  Username: ", $smtp_user_config, "\n";
+	}
+}
+
+if ($get_smtp_server) {
+	require URI::Escape;
+	print "Enter your email address: ";
+	chomp(my $email = <STDIN>);
+	$email =~ /@(.+)$/ or die "Invalid email format.\n";
+	my $domain = $1;
+	my $email_enc = URI::Escape::uri_escape($email);
+
+	# 1. Try Mozilla ISPDB
+	my $xml = fetch_config_mozilla_ispdb($domain);
+
+	# 2. Try domain autoconfig if ISPDB fails
+	if (!$xml) {
+		$xml = fetch_config_domain_autoconfig($domain, $email_enc);
+	}
+
+	# 3. Try MX record lookup
+	if (!$xml) {
+		my $base_domain = get_mx_base_domain($domain);
+		if ($base_domain && $base_domain ne $domain) {
+			$xml = fetch_config_mozilla_ispdb($base_domain);
+
+			if (!$xml) {
+				$xml = fetch_config_domain_autoconfig($base_domain, $email_enc);
+			}
+		}
+	}
+
+	if ($xml) {
+		print "\nFound SMTP server settings for $email:\n";
+		parse_config($xml, $email);
+	} else {
+		print "\nUnable to find SMTP server settings for $email\n";
+	}
+	exit(0);
+}
+
 # is_format_patch_arg($f) returns 0 if $f names a patch, or 1 if
 # $f is a revision list specification to be passed to format-patch.
 sub is_format_patch_arg {
-- 
2.50.1.320.g2ad311502d

