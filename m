Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E728F952
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 15:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335604; cv=fail; b=AeRKqAhdT+RTFGlr5FQwrKkzoOYAhdXs6I1p4d7M7ZYF3F945XpFFzoNJwKG/MXsVXo6ldsctIBkaJZhBFEHZUr+uRygago2AfaY1Btn2LTlMoM6YUCMsQXPx3NRkPBj8AUCd0e7A4bgjgvlslbezFQ361vNcjGxMIbCy1XkRaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335604; c=relaxed/simple;
	bh=9jL+TNCdHAryg3dxvV3nKOqGmrgrEU4LyvyBArx5FIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OU4MCvqFm5qe/Wq3pcObaH+gtsROFm95zVmJ6cjdLA0TXXnJP7Lk9hCS5PT3HQrQCa9pYXUMPvqUj/KHd8eBcCelYrW5jhCvKQoQAhgHBX1NUM0zYdWzKuuZGNJqDgZBK8qgyn+qlr99diMEFR+evI/wMxZRjwHEnCQ2GqJW/tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=V6DFm6xd; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="V6DFm6xd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFS7gO15nuq8Zt5YNtt16qFqFvDBmsq6/Z+P5cRPIKls/DvhfzQQ4/iqUnOAoKyne4ciENv0lv7CyYtEfu8zBJKJQHq0Gb6b+T0jdTb42wkO8SG9/eFJTPB9FVCU+rqqKd21YKVJFWpoKnbBAvhBTyNVeAXdLzRceYR9ZQFv1lVVH3zyl2V7U2QNtcGVZiLx45DDlE+hAFuMN1ktG3VxJBqHfK6LpG53OUI6aHibUuo1dVv2phgiVCvanSSOI5tl+ofWTaRMCJdgn8t71e5NOgZXRE5+2qn4KaozHs2taBSz7lEsP3BqiDgqwNczN2BcnPeMLv73yiw43DrbYThQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVss+tqQBCCK3t3qlIH4ye7880o1xE3rTD65HJ+yjjc=;
 b=sPFeFOt4xo/33sPk50azFvrhBBZAvkSOp9Pm4sobru9JPB+PnZBUJqhUDXi3bIQXPK6XGmXXIufIVsskqT+V7jZ7R/Z69iZN0VBjhV+zdDO9FlPi5Od4gSFi0KKR4BvSunxtgR7y+8IkRz+bJg54EoaaBO6d5rfuP6M5jwzB8rwxdQnMWNUZRkQAgdR6IVsuiXa23XcKiUoHOHb/UVkZ+m6Ttq26AOoEAYgyaM9sSlYzC+JBo3wTph2871JzbvmKwr5qRrJWrLcFoRBXHdU2XJIgM7KbgO9csmsxlT375FManjolJitLbSlvc3Z4pya2py1w7dQB2pWIKMqFfia07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVss+tqQBCCK3t3qlIH4ye7880o1xE3rTD65HJ+yjjc=;
 b=V6DFm6xdnjdr5En2CQqTZLcj/r3iqNn9u2SAOyRK/QGt4PN9d94UiWqapW3d871V+xhCfv12u8RGQD7bK+WAoIcmRkbvWiMnnUVXQ16mR2E9w2DNPKMcRr9rXJJdOKKC4lW+DUDCNrQZZlmSiQlph3XCqn/Fo8LjbGJ/eH7Qr4rDVIzET8kAMu6RoUzQ+iaPqE/ogjaxD2PPAryo12i5uoXqiPok/7LYvlDruey2Q8Uy2yZjQKnt5yMPpvXfWEyP8jI/88nPQHsMlUbcaRwiZNexv63J2qXLalejDoLH76qK+ZX4Y3c82di1sws6QVG0EP9G2Gz1AbiAwdahGzVm5Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6777.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Tue, 22 Apr
 2025 15:26:34 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 15:26:34 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v3 3/3] send-email: add option to generate passswords like OAuth2 tokens
Date: Tue, 22 Apr 2025 15:23:21 +0000
Message-ID:
 <PN3PR01MB9597813722A475923ED1C036B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB95975C7925B6395DEC46F9EAB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB95975C7925B6395DEC46F9EAB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0106.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250422152624.19037-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 149836c9-8412-43e7-7606-08dd81b20ff8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|15080799006|7092599003|461199028|19110799003|19061999003|3412199025|440099028|41001999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Ojckhf/Ziq3iyq9qutA+hgl17XSy5e6si6NG6Gr0I2mF1n1IldrKF40pMHm?=
 =?us-ascii?Q?uoWZYc4lSxpe8JJ1oJLUrerB+JXbjtd+PLOQGqri0DPDhoXguCfuntrB5cXm?=
 =?us-ascii?Q?7IXU4Zlf9bx+L+DzTipAKkqUycd52ogOYQ7oESSlEksi+haMru9mC/KvsVvF?=
 =?us-ascii?Q?v411KdOTqVhBlO8PM/Y9D/x3hD2JpLIoKHm2CbjgzJOXhbwCRNEBNAZbGLbc?=
 =?us-ascii?Q?/QR/iERzA3b4qYJnNegbQcZIA1gckXpR0NHYjZdh9qtC76OZoBTm9imt/AUp?=
 =?us-ascii?Q?NvM5VAVKVm38Qv8xPBVlMpBNjzcAAyYIKBKXeuynUUNpXsSmgTgWtCeRjxln?=
 =?us-ascii?Q?gVkCDDhgoJ3gEFDNjJsYyvaNhL1Gr3Ozvu9plSQFYWOtUTy0LtTRg3Rh+mbe?=
 =?us-ascii?Q?9esxCZKobimF23/CILOkzwkcLrShceQQIx3E3JHbj3OVh/0yaKNtaGI+A1sH?=
 =?us-ascii?Q?AaphMc9zHEzQ8JXXouYRwMTPk/0LHaZxeQlPQ++sQRMzzuHoFPDWLNvBkcZj?=
 =?us-ascii?Q?0GE9vq0hUE2cW5rBYdvUWq9h4O0KHj2voMZ52kJauFTiATG2R1aeoSy1jJIY?=
 =?us-ascii?Q?YN2KXNK4gBrpGTEdAjJ61yD7qmpo/aD9393gzKIEoqt6P4Iuyk5P8DGss5y8?=
 =?us-ascii?Q?/6kgMHTgA3Zmr+23LosxIejELxbCAn7jPZ9mbFiWxtMYPJB3hFz7S4Bnkvvv?=
 =?us-ascii?Q?iMpD7LgfpWaDB5ci2UfdD4s3nj6x3zYRsv0FeWr3LexHb5DTa1xb1hSAP/Ys?=
 =?us-ascii?Q?eSXiT3bA3hHiSTlVAO141DUan1cTS3c/rd2+kYiNEbJSegrJxINp1HivO54s?=
 =?us-ascii?Q?e1mRVRStWlwmup+Jmzzqwwz6RgMUy5hwe+7usVKyAUMsuoxM0l4s//oj694r?=
 =?us-ascii?Q?072WdDOsqCYfrp1M7xFR6yTH4U6qFbnes9LYaYLRRQ8IavdF19tqsud07vYW?=
 =?us-ascii?Q?AgOLVyv1Ut0UbDawcZtIUO4Cj7ppPPcZRy34vCC9W0DNNX+F5xctMkTju27k?=
 =?us-ascii?Q?yF4ztcPeuyqbq5asBxwNQNTqrSUm7h73g19Ft77zzdXucp7TLst5w1LqyNFD?=
 =?us-ascii?Q?IY9LlRbirSPJ6W7CtuEM+8t8xsiP4qe5ULa+f5eZvBS088quFWLpCCZvnLdh?=
 =?us-ascii?Q?xIjqFSJ7rNshUv4W5yxX3GVlyfQjrQRhIvEjqVknkskIgQqnT5oHs7NjW2Ao?=
 =?us-ascii?Q?FYwPgh6m3OdB3hDnTXY6CDiZydrM0qbGTtdRRg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?miT0qLGI6Q29yQuxFB93mi3cQp0DEH6sUT65SmTmxirto3XyR7IxwjC/W5h8?=
 =?us-ascii?Q?B9KP5bwtbcQqi8FrsoN2EQ0fgYPOUvruirokZinq1kr03xGVp14Oe89Jop7o?=
 =?us-ascii?Q?qRFeihxtjzLu+kxJCtdOLq06/B3Zk0OhFvr5tmtomZocVkXqdSUXhcTW2nkY?=
 =?us-ascii?Q?wdBEq+gxpz3rVE4aVLIp73hEQPfASGfbq5kcUdVG53iR7f3NVmRozkj47Fyg?=
 =?us-ascii?Q?UMu7Y3E0D9MYFSMWygcNgYHz7f44G0m/CIEENQ0ZCFwrULaw36OaGL/c+yzZ?=
 =?us-ascii?Q?V8VY6rvnJSQ31P9TgP1GqzKVvCkwurUQcb4PAVyNsH2sg3VkVMUfIlcphHNy?=
 =?us-ascii?Q?M2/c3QluwHdPVxY0ByQSrOr52AtLyuWbVe74x/U3ioFQXDVx8X603GD8Kgyf?=
 =?us-ascii?Q?0oXJzEtp81AlyzQNJCBnthNPovxHLUZp6DrRbc+KneqAdgiHzKikKZMI38PK?=
 =?us-ascii?Q?0lRLz/2WHq46sFS7vDqioFNcHwr2+aPzuii8Dr+jnzDV9xrNhwtUm0iEzRcU?=
 =?us-ascii?Q?30wIshCR8+40pwW8ghou+bil++oqg/ty1BfK2hH96U0E4QVo2mHIxdILnl6L?=
 =?us-ascii?Q?UsqSVomBHejOUgUaC+1ZUGuEkUg4vD9z+zVUcfixqIK+hAkg65065fFpXQut?=
 =?us-ascii?Q?5r9y4xwp8EnCh/ucj+PO17qUKqXvanByNR6QCpUt3agCZofqprSxv/i9uEaq?=
 =?us-ascii?Q?KlLIftfHcSybElE2Lwki69PTVz4NypBPkEOyrArdgTe+KUq1T5fGoXaVil7U?=
 =?us-ascii?Q?XsbZn3iJRpTBKGhIwdxFbT9SgLn+ulzfx4yriJFGKVnVO1GhLLSNNxIqLKmt?=
 =?us-ascii?Q?Bim1+AiA5ouLETzPV8o3OTWFBsOgu637aj6sqFmQpA8bZjNSY/vjoYv5TQlW?=
 =?us-ascii?Q?TwMvsGyf+X47O9YIbWJ2J8/Ll1G8RokZrIxx4IRWEemU78zXNo9oyDOtRFS3?=
 =?us-ascii?Q?J9E0/83cr8BIeiRWawZ+ZLhQzq8Tp6YChsdNhbzbrGI/VRmz7qY5sAXj796x?=
 =?us-ascii?Q?aTxfiwtJHnJF0TQz54VwyCqYkApK76pz+wB/ypn7mlHmkmL2gGyTj+JMdgUh?=
 =?us-ascii?Q?+2YuQ8pmfZukAV/Kz/qWJ2ltlV6rZeaDHLDJKhDJLR9cAJ6nOsT+K5AICxc8?=
 =?us-ascii?Q?WWk5qQdnawonrGz6ZH/pRxnd1r/p4KyEEoC0botatV8ZHegNWu7WtW7MowaJ?=
 =?us-ascii?Q?929LUVYNPf/+qPgY3RJelGpTu4nAUsgiKdo3SAxEx4UZRUpMTKFd8q1R3dk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 149836c9-8412-43e7-7606-08dd81b20ff8
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 15:26:33.2403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6777

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
index 1bf75c060d..b41c807960 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -230,6 +230,14 @@ or on the command line. If a username has been specified (with
 specified (with `--smtp-pass` or `sendemail.smtpPass`), then
 a password is obtained using 'git-credential'.
 
+--smtp-passeval[=<command>]::
+	Generate password or OAuth2 token for SMTP AUTH. The argument is
+	optional. If specified, it will use the output of any password
+	or OAuth2 token generated using the command specified.
++
+Note that it will override any existing password specified using
+`--smtp-user` or a `sendemail.smtpUser`.
+
 --no-smtp-auth::
 	Disable SMTP authentication. Short hand for `--smtp-auth=none`
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 216b23caa5..49de6a048e 100755
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
@@ -1463,6 +1468,16 @@ sub smtp_auth_maybe {
 		return 1;
 	}
 
+	# If smtpPassEval is set, run the user specified command to get the password
+	if (defined $smtp_authpasseval) {
+		printf __("Executing smtpPassEval: %s\n"), $smtp_authpasseval;
+		chomp(my $generated_password = `$smtp_authpasseval 2>&1`);
+		if ($? != 0) {
+			die sprintf(__("Failed to execute smtpPassEval: %s\n"), $smtp_authpasseval);
+		}
+		$smtp_authpass = $generated_password;
+	}
+
 	# Workaround AUTH PLAIN/LOGIN interaction defect
 	# with Authen::SASL::Cyrus
 	eval {
-- 
2.49.0

