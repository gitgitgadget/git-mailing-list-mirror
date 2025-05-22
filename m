Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92920199252
	for <git@vger.kernel.org>; Thu, 22 May 2025 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934959; cv=fail; b=TPaOdp3Cob/DsBzDI/Pu3CEVcHHiPwBgradnrmV2dVVVhA8SrVLTtuPj9Kpj9rPcXqb3mdq2EzFqBWJnd40kutXhng9DmFFsNTOR//tmjGIuEH5jg1uxagj1hSCfMe7fAfUh/S2j7raQdGP3J9O1rZg+zvhkNIbvMslUhN80jE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934959; c=relaxed/simple;
	bh=2HkQUBONCUGuNAp0retkmw9tqKbSniUaD7aJGRCetSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=duxTPzfVB7BVP15Lbss954vj67TwuNONsRGC0NcYZ+XG+CSLeq7/XIh3sFNApom6cKQXb2hf+52ugkyaPG5adS9hUZ7jx0Tpa+ute3ww3AJN/bKCXVSbpfireSpbN9V5tXOYnM9vIPArToyDxrpJNUaQnmQzE0V4UjHxRM/i3n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=aOaxRaBK; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="aOaxRaBK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqi+/FtF5qCBFDL3Bc3xFwZl4QyHlL+3JoIV/VuiPqRTRqoKHv5rovpB0r7aBEEqZW73Ng6d04N0Hl5c8spAPwdbJBEYH2cGn5jqkeUa1BkKs1D9nnsknKnEogRS4inzdyV/5+bm4SkQ2iJtB95vfYVtcLsP6Zb5J/LoE/nzJTXH+alMgBOxtHvapbfZCh7sKFzLgAV7tOnDDjd9AQpZXfM7E+NwJ/GhbqHPczENYKUXKHcvt0DRRF2wTNyl+YfZpUaQugLG9Uqxc2/V7l3kfr+4AP9JKhFGP8WIJg+9HpwmSaSEBdoGMViM9QZwKtvr5raw782zJb2bgwTldAA6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGU4bgDq7sDjkiEoFkDqEkHWgUTqqJ0xUnSt5CQdPPY=;
 b=Rl64ox575Nunr4b1mQpKHwey/9amq8dNuVK8CM694VBMTEST46j6eNXx2gTCgPRydlxeX+jfrqXGFR6soocz9J2PNad01gINkzNrs89b1AMU7RZDBhrSNpZqu154nKsv7zjX/cfIUpK2OOGvwe4osAoQ8dvDzwLStA0lSuXO+wACIx96xCtQS3Lfx6h/q7ISg3hYLd6IQ2YguULXJSZhTjJ3weumKcOvGhZDkYgQGi0eMVO/djWywcHTvOH4c3zLa27z7y1ULW82oTJmqtz+PB3T1VlpXNrdVpVIgZcPLt4uds/EjdyqWSQ4PqG7KOp1tOCR4O9DcPgWOE1l+QZ1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGU4bgDq7sDjkiEoFkDqEkHWgUTqqJ0xUnSt5CQdPPY=;
 b=aOaxRaBKwujBknpsBuSZB/CTtZQdmA6j+PMPNa/jgLke3AhhSqt2mmojOGbBLQkWtQ7NzQ/NpWDKQOCA8X3EEZ/7moeJi2JkYZbyqbIsOgIEw1BzP80rc3zKQB7R/eqo7KbK8BjsaicaDPoD5HWAlkjInWWyW2oU6sPEaLtoXWluUpFI+MHaVp1tm2dBZdtq33SY9hlyTpJpwBPRCjKctDQfVeuOZqJdV35kB+zYZ4cCl3ewilBlruUTDjgfZJcJaCeIRPmae/POkdE2Sd5ilN+meazZbQQfeQtnCs/6qoFppA2yh2/HvEKe60Qk61AXyQM97cQ5pdMrLFmIlIMBlg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB6547.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:74::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 17:29:11 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 17:29:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Julian Swagemakers <julian@swagemakers.org>,
	Shengyu Qu <wiagn233@outlook.com>,
	Zi Yao <ziyao@disroot.org>
Subject: [PATCH 2/2] imap-send: add support for OAuth2.0 authentication
Date: Thu, 22 May 2025 17:27:16 +0000
Message-ID:
 <PN3PR01MB959744EC6D19FEB8D197C434B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0079.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25c::15) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250522172854.43999-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: e502b980-a157-475b-6231-08dd9956291a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|7092599006|41001999006|8060799009|12121999007|15080799009|5072599009|461199028|440099028|4302099013|3412199025|19111999003|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lGHJ7HZVqw3rZUWHRe4vFdPKMtmBMHUKxfoeeshRlqNpiFcRk/A7HmhiUtk0?=
 =?us-ascii?Q?3i3zFL2BRHvNrUUoXEj0dc9ZSN7t6DhuS/w3Ksmw/HOLgaFvdjZ0QaZ5ERKt?=
 =?us-ascii?Q?oyowbwr1br5zZbUN8y3UtUu5SA24ERYiyvdzlXycrqS8SYXFH7GUotnaEo9g?=
 =?us-ascii?Q?KaFCLotRtrnULvhNoIrnLNOdLC25ISLxSzSo/QI6/D7UuBfY/7G8NvPST7SB?=
 =?us-ascii?Q?ZsCaeEaIY1uN1aBv9rGpMmtKrvnAmtHDnm5CT7zE/Gg0ZRV/jYT5IHngoluE?=
 =?us-ascii?Q?ZaM+6dvjSKBDlreweTqrvIr7hujMKCbigHUbUweKKX5XRqe+UtEsLABjTsyT?=
 =?us-ascii?Q?6taPCCqpJPqg2uE1zXwN5G/eabpJMNr+X8cjx0u6vctc3q5y9knS+omjyZZo?=
 =?us-ascii?Q?guKpoJC46j+mt0VTCPMRRfh1U4rVYtgfjHZfQLkXeMCQwQi2jzCuTUOCrN07?=
 =?us-ascii?Q?O+HbQVHi5HCU6mqvKTrknO6BvQPKOBCoeVoJhoTLiOq5vcJj/44dVdI0fNL2?=
 =?us-ascii?Q?d0tcnYQNsgzOdOaFj6XbmMcTjCOGo9WepAxATQIVq5WXbXSj8QYw80K5Czla?=
 =?us-ascii?Q?CmPN4JLlHzUN74iolnNNFtKzywMsb07+ycETf43UB7qnXKmWZT/s4SAoA5IA?=
 =?us-ascii?Q?xiKcQsSDDdpG9f2cAz3qe/DzajlPLptVWo1ziQMRXA8ttcqVe91S4glk32EL?=
 =?us-ascii?Q?juKKUGXkSoss2fV6q8Ivv5yYvP2tiB9c0+0CGcvuqc/PzngR/wxCbtHjSs9t?=
 =?us-ascii?Q?WPqOX8Oas58YnW7egj3wNGM5X9m/F0ciF0AZ/vXI8N/eiELLeyWTcaOR5POu?=
 =?us-ascii?Q?/pjjZWdzz080YxXxD2lJdr86OU/XaWG+R2So7KyPv2zvW2aNpMrklcNQiJ08?=
 =?us-ascii?Q?osq8etz1kD99T23T0LOuoHdhlM+DWsduAMO0tRqkKJGqUdLyGNlJiFVP6s+h?=
 =?us-ascii?Q?rcWgy+3oP2i4kPsGKLCkJ8kJy0hNUY+128zNvRT79DdH0kzmi758ID8AV/Dp?=
 =?us-ascii?Q?+2YAHtjqrruzWMUZTfpP5qwhIUcpdlltMnpkqmyijn4AN0YbmOw6n0Sy6tbP?=
 =?us-ascii?Q?Wh9udhQu9jKdk+pnUrgyCNP/Aa7OJE8aT9M5W1piMXr5k6Ltrj7AFjAM1K3u?=
 =?us-ascii?Q?lFqveGq+kcyU0DMMPsiLKsYg3Qt8PcxGYHXOUQPZwJdnRN7k+PqYv5SilqvG?=
 =?us-ascii?Q?0JfaH7AQZxJ4tnC8BFhFE+WaKH9oqjl9TQ4T6r4OZERWalJqUNjlqntVZg+k?=
 =?us-ascii?Q?trwchjhHIZvQyQDDfZZI/CTSfIhLjSz7fyiLJhmvdSh/zu4locvnXxpO/MXz?=
 =?us-ascii?Q?2iwjpWSKzot8d2X3KxzLhaPAuij7NRJUxP8dgQQisxfHvwyLoG26fzJHCxfe?=
 =?us-ascii?Q?q03aUp4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9u+P72afWp/rWpeNDns4eCzprLjrQdyoT8uKN5HlTMmr1bjJy2clyXnmfcoj?=
 =?us-ascii?Q?FBg4qY+eWyGpywDKkWjMfy8788ZRdI2GDd5c+pHRoAnttq3ILERvnSuuJbtJ?=
 =?us-ascii?Q?NbBPCXUAj9MRs02PUAwj0asGl1GTbY5jTR1+v8rjNV8lXbYXmMU1KGpnNfb8?=
 =?us-ascii?Q?NL+iGM50zUm1ZjLqzuWFifu9WEjCFcsQlNlgbI6qtvHr7EeVNb5+B2+iy/es?=
 =?us-ascii?Q?0YOxwsFhD3sA2dN9hisB+URQnZg7/eQvvBnLGYImHr9DEx7ES7UlOPZh/O4P?=
 =?us-ascii?Q?oHlqFakiCvPz7NLtD13U8sfJe/2ORdgxFdNgHKmrImgxU694H2dD8t0/ml2I?=
 =?us-ascii?Q?8CJenuQvF4DCjSiTNbaCiN+uC/EkK45KJWtrZultWoyji05olJz5Dp82r9ao?=
 =?us-ascii?Q?LaGJYvxYcJtiWPnXBP7f1u6va5tuDqedlbMeBiYq97+tnbe+ao3r075JBljS?=
 =?us-ascii?Q?7tEVEJal0Braj2jgvMjItwMsVzwfLrCF6zR1Dr6cci0kJ7XBv82AgPJGfDRk?=
 =?us-ascii?Q?f8/S+UInEARA1z0h0X+K4dd3M76OJQIjSqv8TVXHSHxZNRGnXndaujhetgci?=
 =?us-ascii?Q?cLritqVh30OlxCSCL5eAdY0r0wWWQD4Cm7eVGk0z/nADCiV2dI+fJnaDjkID?=
 =?us-ascii?Q?RNxnEqeNZM461iTI3HuhPurBWriW7kNoJBQvrAFUJp6WXWW8cPsYxL8o0Q0k?=
 =?us-ascii?Q?MtJ4MWn2ilWoQmw5YijKz0Ol2vQAH8MDETUeAZuCWQxoicKteg6NrPhwvMuz?=
 =?us-ascii?Q?7qcKaQiX2BUnWcKdWvryDljSYAlIgZWuD3jRvClGTqPCNwjX0ATDQlBMgXSm?=
 =?us-ascii?Q?ok5IUWp5GeAYS4PbTqYOmodczkPJY3we3Nemo9k9t7A8Z8F1amd5MCRMeTCi?=
 =?us-ascii?Q?3pMmZKlcS6UQJZA1jJvZeUPEwj0dPf9qMuZF9hndSL0K9PnLMfTTViZDpdfn?=
 =?us-ascii?Q?kbSIrPWtccbYxpDDAg7t80d5v69l2n+2OXp9MRalm5YQJGfEMTS3iK5fdxMm?=
 =?us-ascii?Q?6ubc/Dgah0pfFOD2zxtKQaQmbity5KlJviOrq7fGKcHYISTxeqbGSUoazk0C?=
 =?us-ascii?Q?wf81X+G5RqZYg1HT0VpGQWK7+nrCV+h/NbuDFCb8zThAK8RoxKwobaqYaN/2?=
 =?us-ascii?Q?+uaSBrLDtu1fF+u2UjZutCPyLd2x90k653SmHbK86U3hYX7HA8hhIipcCqvT?=
 =?us-ascii?Q?TEjZ4iLZgO8fEAHZ2fFqPuQTX8Ak+w6ir6qi7BaDSOYcXBuSyLhdxIGgVb4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e502b980-a157-475b-6231-08dd9956291a
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 17:29:09.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6547

OAuth2.0 is a new way of authentication supported by various email providers
these days. OAUTHBEARER and XOAUTH2 are the two most common mechanisms used
for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2], whereas
XOAUTH2 is Google's proprietary mechanism (See [3]).

[1]: https://datatracker.ietf.org/doc/html/rfc5801
[2]: https://datatracker.ietf.org/doc/html/rfc7628
[3]: https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |   5 +-
 Documentation/git-imap-send.adoc |  48 +++++++++-
 imap-send.c                      | 150 ++++++++++++++++++++++++++++++-
 3 files changed, 196 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 3d28f72643..dcb0db5563 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,5 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported method is 'CRAM-MD5'. If this is not set
-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
+	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
+	'XOAUTH2'. If this is not set then 'git imap-send' uses the basic IMAP
+	plaintext LOGIN command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 26ccf4e433..582a46672b 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -102,12 +102,16 @@ Using Gmail's IMAP interface:
 
 ---------
 [imap]
-	folder = "[Gmail]/Drafts"
-	host = imaps://imap.gmail.com
-	user = user@gmail.com
-	port = 993
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.gmail.com
+    user = user@gmail.com
+    port = 993
 ---------
 
+If you have multi-factor authentication set up on your Gmail account, you can generate
+an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create it.
+
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
@@ -116,14 +120,50 @@ that the "Folder doesn't exist".
 If your Gmail account is set to another language than English, the name of the "Drafts"
 folder will be localized.
 
+If you want to use OAuth2.0 based authentication, you can specify `OAUTHBEARER`
+or `XOAUTH2` mechanism in your config. In such a case you will have to use an
+OAuth2.0 access token in place of your password.
+
+---------
+[imap]
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.gmail.com
+    user = user@gmail.com
+    port = 993
+    authmethod = OAUTHBEARER
+---------
+
+Using Outlook's IMAP interface:
+
+Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Also, it
+supports only `XOAUTH2` as the mechanism.
+
+---------
+[imap]
+    folder = "Drafts"
+    host = imaps://outlook.office365.com
+    user = user@outlook.com
+    port = 993
+    authmethod = XOAUTH2
+---------
+
 Once the commits are ready to be sent, run the following command:
 
   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
 
+[NOTE]
+Due to some bugs in libcurl, OAuth2.0 authentication may fail if curl is used
+for IMAP. In case you face the same issue, use `git imap-send` with `--no-curl`
+option.
+
 Just make sure to disable line wrapping in the email client (Gmail's web
 interface will wrap lines no matter what, so you need to use a real
 IMAP client).
 
+In case you are using OAuth2.0 authentication, it is easier to use credential
+helpers to generate tokens. Credential helpers suggested in
+linkgit:git-send-email[1] can be used for `git imap-send` as well.
+
 CAUTION
 -------
 It is still your responsibility to make sure that the email message
diff --git a/imap-send.c b/imap-send.c
index 37f94a37e8..4390001cf8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,7 +139,9 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
-	AUTH_CRAM_MD5
+	AUTH_CRAM_MD5,
+	AUTH_OAUTHBEARER,
+	AUTH_XOAUTH2
 };
 
 static const char *cap_list[] = {
@@ -149,6 +151,8 @@ static const char *cap_list[] = {
 	"NAMESPACE",
 	"STARTTLS",
 	"AUTH=CRAM-MD5",
+	"AUTH=OAUTHBEARER",
+	"AUTH=XOAUTH2",
 };
 
 #define RESP_OK    0
@@ -885,6 +889,66 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	return (char *)response_64;
 }
 
+static char *oauthbearer_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/* Compose the OAUTHBEARER string
+	 *
+	 * "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
+	 *
+	 * The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
+	 * * gs2-cb-flag `n` -> client does not support CB
+	 * * gs2-authzid `a=" {User} "`
+	 *
+	 * The second part are key value pairs containing host, port and auth as
+	 * described in RFC7628.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc5801
+	 * https://datatracker.ietf.org/doc/html/rfc7628
+	 */
+	raw_len = strlen(user) + strlen(access_token) + 20;
+	raw = xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
+
+	/* Base64 encode */
+	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
+static char *xoauth2_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/* Compose the XOAUTH2 string
+	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
+	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
+	 */
+	raw_len = strlen(user) + strlen(access_token) + 20;
+	raw = xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "user=%s\001auth=Bearer %s\001\001", user, access_token);
+
+	/* Base64 encode */
+	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
 #else
 
 static char *cram(const char *challenge_64 UNUSED,
@@ -895,6 +959,20 @@ static char *cram(const char *challenge_64 UNUSED,
 	    "you have to build git-imap-send with OpenSSL library.");
 }
 
+static char *oauthbearer_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("If you want to use OAUTHBEARER authenticate method, "
+	    "you have to build git-imap-send with OpenSSL library.");
+}
+
+static char *xoauth2_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("If you want to use XOAUTH2 authenticate method, "
+	    "you have to build git-imap-send with OpenSSL library.");
+}
+
 #endif
 
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
@@ -913,6 +991,46 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	return 0;
 }
 
+static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("OAUTHBEARER: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending OAUTHBEARER response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
+static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("XOAUTH2: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending XOAUTH2 response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
 static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
 {
 	if (srvc->user && srvc->pass)
@@ -1104,6 +1222,36 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
 					goto bail;
 				}
+			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
+				if (!CAP(AUTH_OAUTHBEARER)) {
+					fprintf(stderr, "You specified "
+						"OAUTHBEARER as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* OAUTHBEARER */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_oauthbearer;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE OAUTHBEARER") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE OAUTHBEARER failed\n");
+					goto bail;
+				}
+			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
+				if (!CAP(AUTH_XOAUTH2)) {
+					fprintf(stderr, "You specified "
+						"XOAUTH2 as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* XOAUTH2 */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_xoauth2;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE XOAUTH2") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE XOAUTH2 failed\n");
+					goto bail;
+				}
 			} else {
 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
 				goto bail;
-- 
2.49.0

