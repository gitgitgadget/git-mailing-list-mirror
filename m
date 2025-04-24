Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274781F3D44
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 07:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481475; cv=fail; b=R7huvo2Gs/iRfZ8oTZLJGv31R9M4JKfgw2RkXHR2A34S2U4W8fONVb2NQQNQMKl/c3MsZ+PeyWa0ybnrJ9DiuUY/hmXtfx9dpdMdRAUAC2jLzE3pP+sF0XQ62BN4wEwgNekBC76PQJwNbm0Y+oh8tSoKabJemF1cX1p3uSYDJAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481475; c=relaxed/simple;
	bh=XJ5lP2GRZLzxL7RGGGWrtaLkZqAsg7YGE2HPLHfUm9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JF76XDf0gQAV9h/xDmodXljRbfTZ/l3bM+L5VAz/7OKGRlN+1PHNxYn37lBNF272dWx7shUYyh4g6bhwii9hHKm2y4wg1eEB9KM8kBBLyL9/GlMGKgGqlDjy+OchKuDO4YvSECjJRL4RA2K2DcFUhNfzhyZJ2Af0JubEGYd2Ruc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=rmV2pXrD; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="rmV2pXrD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTmhbkzNQugG7fCyAlmxiOHJfFzT7ejlJqT3z4pVc1jcNjp06syX602rzpjxMcBP3nqCKjoc8YtkTNTIL4/sTruh01Agm22bocJlmeY4DkqxVZJVrd7hy3x26NWuijNBn/+4nLBGKZizZzmkH+HnhzcttOiH6Te16jkT+71XPMa1FqQgVsaC5kdz0BdTlGftsv8LXxX0DCsY/aKbHjEUR7SBNVxO8c1oAWKo0AL2tqx9D0bmSLyPI3TjCQm/OfozplAUSCnJK3pYywUu9HIxDoLr/6HNKP3C2dFdZIjnByX790/tC6+eUP9T0adM+mcafSMKay5z0Dv4uqJj4k6EIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brg1sH7Vftbiw0tV6TxspAScJtpTZjS4iFsLII+BbYo=;
 b=HtJHrgBZ4WZzTkVQuqzavUYyQdV4S/0bXis+X2mN1UHDBldgTgDf5z7ctwBj9HwvxdqHD2tCympBODD6YQA2gR22siDeSrPQu0dsIPKC0wthM1mZELOdpCZdw41beg2miralZ/pPQkum5kUg6mzbg3hMVPWTEOLOq+7V2gQRGj7DKywopbFS0VMd6RqmVRmJCf8x5E3yCZXZ21Ixcj3X/gqT4qLgyoxo7NXHbt0XXPXuciEhZ7qFRWfXMo9Nu6dJ+IddWRNgBvNfmdrgv4uXshkFV5hDEJ1xsYzwtDr9hwxZ/8mHCUH744sU8DAC97REiDTz3nFY8l5uMp2nnldV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brg1sH7Vftbiw0tV6TxspAScJtpTZjS4iFsLII+BbYo=;
 b=rmV2pXrDgMcUHLL6j/vRn+s2APMO22uArmNDuSBDDuxHAHaFwb7mjgZpTnZreXuZ+KFLpkt/nsUHEAzqt7CwrXlQJMkGW5K72A4IoSp0zUaNZpcPInGvLq0Moyzj8VHdPeQossadz7WkN6wVGZI+O8q+4lyCoRl83nDVyjqPP5NBTGcHFsqGsny9pFORGBSfdbnk/YaHeVVvcqIFSNqOzdgrBCUy9kU9IfktSjB+CYoAg1Do7pgxZFNf9AALsm6If+YIb97E+I7RLgutISEHA7mWjXcphQnPEWNEcH11Rstk152mVtiKzASBK2B+glqZ/xpcbgEewvLpgAJgQW0fSg==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB7808.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Thu, 24 Apr
 2025 07:57:44 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%3]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:57:44 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erik Huelsmann <ehuels@gmail.com>
Subject: [PATCH v5 3/3] send-email: add option to generate passswords like OAuth2 tokens
Date: Thu, 24 Apr 2025 07:53:55 +0000
Message-ID:
 <PN0PR01MB958856EC9FB1E4F73A738746B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0073.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25c::8) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <20250424075735.32601-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN3PR01MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ce1dcd-2179-4cbe-42af-08dd8305b14c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|7092599003|5072599009|19110799003|8060799006|19061999003|3412199025|440099028|19111999003|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xAJnWOY32F9U2vSSRjGc1zLKJWb0vQaY5APClz7lK2YLHZ1rjbh4HTgAqgDn?=
 =?us-ascii?Q?T8i3jiUWcLnV9SRZEaQ+MNVafy8xmrklF66vGmlqy8J7EyrSb1q0H9TC3LoA?=
 =?us-ascii?Q?+6epewlmO7wT+xPuCSinj9O0E3xxYI526P8dX2286X5ai/6TZMekG0twaIIM?=
 =?us-ascii?Q?Ad96Uhu6ejxYR2NEDgulPamlUIrLmisuICs15J8tj6vijHz0mvjOPyeoAlj4?=
 =?us-ascii?Q?biuPXttwGCH96s4MN+9kP6rqYzUjKkMkPTWLQ8z/4DEUJLoJujtCsooS3pof?=
 =?us-ascii?Q?vJkC5TKEAIri8235XDyqM+i4KNeDWqBERY0aGrrKCvn/lw/vY01pNzXKrJCB?=
 =?us-ascii?Q?uIkKTvWv2Dvu8EXtWxGJtRWRBXkbOp7CcggYPYSOGB1Q0kmM/8MPzIddvHmK?=
 =?us-ascii?Q?CFeX/FDhp2lm1j+co99llIiztEK9FtPAJNjF0XcVB2Zc7xTA3tyCo7+HID+t?=
 =?us-ascii?Q?HNqlM92hiLTMnhlpn+OOSqJ69ft0VBHrzmQW4k1wXGPI7lBPVv1cHR0UTyUp?=
 =?us-ascii?Q?4bgci24L53H61oTabtUeqFV8q9bp8wAqhYH0qAMjlsp9A5OLrcXlv/dCrTJF?=
 =?us-ascii?Q?16qsAcrSt5xbZwrDU2/ziwJz6Xhrg0smPy+akTQ+EreGQ04CXrLUpPFSPFoJ?=
 =?us-ascii?Q?fwbIxRQdfR0jClf0tLlWMi7YSMU61HMI7FluzLXwCqLTxMoPkOY+w4Twzh0u?=
 =?us-ascii?Q?X0NFDHPBTu8uyEDXWRMYNyTWCD4RD7dxH0kN1SRXCv8u6clCi97rARR7/5BQ?=
 =?us-ascii?Q?KKoCaCslFKeZVrIwxIEflu20Mqmf2XyhtIdgAXxJ2/qwp++CR7geNVwPiO4o?=
 =?us-ascii?Q?YpC49VUPUNdT9YKmsKtUYBn8Qo/UhBAaSHPXS5U/g9m72ED2lAzxJaIXwFYD?=
 =?us-ascii?Q?BALYS/yd/YRX2Y+xpG0xhSBF5RrFMYETiivUlpAjvUfqcgZmfj/NjlLYVTRY?=
 =?us-ascii?Q?DErJuqcdKJw9vk5BG7jhPuVXyk6yu9+VUJtojZBP57oz4DrzoYF2JPF+cD36?=
 =?us-ascii?Q?e3XLKT9UTKyLYnk/FRJdiXqL7AqzCGPU8vHZHnBZuxvlObdFCnxNWnAOeeaF?=
 =?us-ascii?Q?kjeTloSY1UiuzYigSRitlHQPSTd3Sypbs2cNQj/quIVMzKyDDV3PrIujojKb?=
 =?us-ascii?Q?JVFf2dSsPRYIHDzPePm+4RQXlH5ZOcszky7FwqhxmHETTu80/1LJi9yr+Znl?=
 =?us-ascii?Q?tzQ0X2nFMyUTJF8sWm20VK6hJv0B1wL59mBtQw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KusX/jB2kflI7wt4ZMzDm4Ujhq+KrhBq+FHzB/WNE+glcqnkdCjW2w0xmvfc?=
 =?us-ascii?Q?DMW+DbtmHOICmUM9WKiBQU4VMJZG5RK/EUWLqJmpuDPOh2WeGk4ZjNjQf9JB?=
 =?us-ascii?Q?vIRTW7eGepheAL1Xc+1qxFwjWtwIAXpw0NB0NZI3kmAHkCOcmZQPjsQHXFG0?=
 =?us-ascii?Q?Ft6vb0DCTQqkLPISpsSGw3hqlnHsVecOj0080c39VX60XZtZ8j1PB7iTB/P2?=
 =?us-ascii?Q?jNLRYy6FH/7nrytkFbVSXwNIYIQG3N3Im2XksdEWUDzxGc18WdMFCltxTGI2?=
 =?us-ascii?Q?1tSGTuiuxfE9EA5kkeDWjVvb8K0uIP5LcKvzYY6/adZz+lPkqTE0OEqY+yfV?=
 =?us-ascii?Q?FBSq/poeZ5GlarSR9qQ0xlOTwQ9xyaDoQetgjFWE60d53tLBTpSm1cnV9u6Y?=
 =?us-ascii?Q?42VqGxm3D6oo1Mt3v0BXuPj/Q/jWppuLHvCJcTEmxBm1xHEU4hXVnLMq/3fV?=
 =?us-ascii?Q?/4yB1nYm/qi79hKR4LBukhk2OiUAYZOzS22NkJca37DKvvcbAyWCQlzB2hLT?=
 =?us-ascii?Q?4OXIfa8uxHjW0YVxMK9H/IWILCkhm2Fx8W/zUyOSdC/z1pFSdQDo5KV2VWck?=
 =?us-ascii?Q?WmlVops6+00snGOYlUtYEkIziwtio0eZrbswjrL0koSzpqb4UKjkuAPEa7r5?=
 =?us-ascii?Q?VCtmhgnb9g1gsFrKrzDeD2a/whQ5QpwbcpyJTS+tULSGSrQ1mlkjchBZ3ViJ?=
 =?us-ascii?Q?BcGT4Tr8Er5LsoHyKlTyoE+aJEjmW5fkH6QdDwZ/sS9ve+7FAxe1CMoszWXH?=
 =?us-ascii?Q?64VYohR1rOVGDaG5dEEcJNyNFTa7RNFHZssij/0GpEp0I55GhZG5ps/fkHhk?=
 =?us-ascii?Q?ermhGq4yAfcryBHCYWpJdTwxW3RNnhkrjDWP4Lw3pjOFB4pbZrZKvTyKsZYj?=
 =?us-ascii?Q?A82oxGm6oZEY5w8vAuEgHlQKOn9VkVUgUpLW+CPZD51B5//+4UkLlAhP3NON?=
 =?us-ascii?Q?Jp8Owxj1hI2b4nqlpitdY1EvNmXkNRsuZOUNv3QfwAHkZrjVQ3BY35Rg5LrV?=
 =?us-ascii?Q?emJOoOztClo0m4tUEX/6faudXyvsBTOo67HJYAYVtj4gTx8rR8BDW7hiAjyu?=
 =?us-ascii?Q?XonQzOeLxu2wh554/2LqZQSd4hXEfVcpLxuzdEXnRdlRYOHPbi8lngD8K5HX?=
 =?us-ascii?Q?L3Bc/8w8fkFp59M07mC9YX2/7+NIX7tvO0c7itujeQpTXjiTZ0dqC0TOqpYl?=
 =?us-ascii?Q?uNaDEOLWAjk0h8xx6yoz7aRqh9nQervPChySZvI2AMNfj+XXyuG5wB5x7do?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ce1dcd-2179-4cbe-42af-08dd8305b14c
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:57:43.0930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7808

Some email providers like outlook allow only OAuth2 tokens to be used
for authentication. This commit adds an option to generate OAuth2 tokens
using scripts like M365-IMAP[1]. This option is similar to passwordeval
in msmtp.

Example usage:

[sendemail]
    smtpEncryption = tls
    smtpServer = smtp.office365.com
    smtpUser = someone@outlook.com
    smtpServerPort = 587
    smtpauth = XOAUTH2
    smtpPassEval = cd /workspaces/codespaces-blank/M365-IMAP && python3 ./refresh_token.py

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc |  8 ++++++++
 git-send-email.perl               | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 1bf75c060d..f478559582 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -230,6 +230,14 @@ or on the command line. If a username has been specified (with
 specified (with `--smtp-pass` or `sendemail.smtpPass`), then
 a password is obtained using 'git-credential'.
 
+--smtp-passeval[=<command>]::
+	Generate password like OAuth2 token for SMTP AUTH. If specified,
+	it will use the output of the command specified as a password for
+	authentication.
++
+Note that it will override any existing password specified using
+`--smtp-pass` or a `sendemail.smtpPass`.
+
 --no-smtp-auth::
 	Disable SMTP authentication. Short hand for `--smtp-auth=none`
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 8c8544f120..d34797f852 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -59,6 +59,8 @@ sub usage {
     --smtp-server-port      <int>  * Outgoing SMTP server port.
     --smtp-user             <str>  * Username for SMTP-AUTH.
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
+    --smtp-passeval         <str>  * Path to script or a command to generate
+                                     password like OAuth2 token for SMTP-AUTH.
     --smtp-encryption       <str>  * tls or ssl; anything else disables.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
     --smtp-ssl-cert-path    <str>  * Path to ca-certificates (either directory or file).
@@ -280,6 +282,7 @@ sub do_edit {
 my ($auto_8bit_encoding);
 my ($compose_encoding);
 my ($sendmail_cmd);
+my ($smtp_authpasseval);
 my ($mailmap_file, $mailmap_blob);
 # Variables with corresponding config settings & hardcoded defaults
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
@@ -316,6 +319,7 @@ sub do_edit {
     "smtppass" => \$smtp_authpass,
     "smtpdomain" => \$smtp_domain,
     "smtpauth" => \$smtp_auth,
+    "smtppasseval" => \$smtp_authpasseval,
     "smtpbatchsize" => \$batch_size,
     "smtprelogindelay" => \$relogin_delay,
     "to" => \@config_to,
@@ -516,6 +520,7 @@ sub config_regexp {
 		    "smtp-server-port=s" => \$smtp_server_port,
 		    "smtp-user=s" => \$smtp_authuser,
 		    "smtp-pass:s" => \$smtp_authpass,
+		    "smtp-passeval=s" => \$smtp_authpasseval,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
@@ -1470,6 +1475,16 @@ sub smtp_auth_maybe {
 		return 1;
 	}
 
+	# If smtpPassEval is set, run the user specified command to get the password
+	if (defined $smtp_authpasseval) {
+		printf __("Executing token generating script: %s\n"), $smtp_authpasseval;
+		chomp(my $generated_password = `$smtp_authpasseval 2>&1`);
+		if ($? != 0) {
+			die sprintf(__("Failed to execute token generating script: %s\n"), $smtp_authpasseval);
+		}
+		$smtp_authpass = $generated_password;
+	}
+
 	# Workaround AUTH PLAIN/LOGIN interaction defect
 	# with Authen::SASL::Cyrus
 	eval {
-- 
2.49.0

