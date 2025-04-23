Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011037.outbound.protection.outlook.com [52.103.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CC21C9FF
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745411368; cv=fail; b=EKvxPmcFE0OpKZVlSbiy2LnfLIR0a1ZdNhlYaB7/3zlYl3ybOZMgKvXc8BsrHuWcw2WTECHr7a3oSEersXM+j3KLowsTk0Z4xunRNLTcyhcHicM8BSbzu1FxOr8gFz7QpaGRHBtM+br4Pk1D6VkEgfQfjeZjlCRnZZGr+Jfr2+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745411368; c=relaxed/simple;
	bh=I4D0VYkG4zpGqsfH1BRlBTEvM3Gtzgh1vd+KnmgUfEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k+mRWgxWQRn5L25MFOu2Okb5dhvHeCJJawnFGf6T0lgm982dXq10e5YWzonUf3ejHaLCrPSHRSvkVx+2n5C9GqR1ar02LtrqGLw6gJHih/zvEe4WxEg9JXTAlQbu+T0qFTEYbfHxFmaZo///ySVny9dD47rUslRySW5HesaEfzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=HVgtSbH6; arc=fail smtp.client-ip=52.103.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="HVgtSbH6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bd1HcBd99wPvJvPzqL2lVI0pVoYmcAO1xx70ubp3UuwxjdGH6pzkwzVySbc9OCTOW2p/jkbN14RIfK00yAIwuVxrjA3C37L9+hvKVtYCq0g0yM8kfMW9Kk9pEttjvmTJBTL+OMze7mceKRGqGnKAmUoBH+biYD7zMEYPWwdYetqCy97cp7cTiRpl2zyr5/qzOXZExS6qf/3VcAed7/3cdXxDNydc+HCv1i+l8kAvHDq5gvcCRyWXSwEPygAhEMlWB8wx8s29R7AApv3IFQoOPtzv/vv7NNExybyHW4lTWlBHymdSkCwFs8P/Mz4RMe/bY2HIbVtvHu+0welFIMzRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNrqP7chg4UhWuvktkTGw4VTE8X+FukuuWAmYjtAZMc=;
 b=t3eG6eq9jHABjrn/V2Tnwc8gUjtcVJGKVQxCQb0rR/97ASAhmpFSgQsVkRRQkXcdtaLkG0Iq5MA1AiuiSSiJM0EC6MDNc0CUS2SOtsooEfrPQRPITCNgStyoV2ZIk5HQurNO1zBe7GozTF3OXHUDO3SvlnsEF0bB0I4H9ARVHBFJKGlwqeyU0Onc4DXuaYal4Ai97x2sUbriRngkx3v9oMfHSTAdyplT/f3TWLal/stFNV6hxXlX8yJpCATD8XMNhio4ky9Xd25bEGaWUfqAocfI4xJXAh2hOGnqi6Cp6aQpUU3q7BC57OUrNg6SU+sF9fC6m7OwSIUSvalKJo+4dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNrqP7chg4UhWuvktkTGw4VTE8X+FukuuWAmYjtAZMc=;
 b=HVgtSbH6lTqI2jMkrgfTNeTwQUXtQ8VwQJZzx79YvLiBx4k9xNkYreoiIzuemJKGsZg1Ee6Pvy3s5URN8CN6hghCR/GelGfENxcTETA/uP8JK9TROpsQBf5S4NZPCSH+fK9z9YiqNgIZaLwegDhe7LCl83dg+l8C4Y0WgjA67YDfKjxDSybZMlFcXqY8AARF3F25iSujxdu4kvlQYA07a8O7QZY1phuqkp6gCpv8UE/K2ERxmkbQ7jKrUvNxcx9RyPNuzEcrIzK4j73VejZU31GIcscU7Ykkf6tZLdxkirvUzFNNT54iyp9hGvF5vmkUOJN+X+oZu8mM/6vn8wI3OA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 12:29:14 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 12:29:14 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v4 3/3] send-email: add option to generate passswords like OAuth2 tokens
Date: Wed, 23 Apr 2025 12:19:47 +0000
Message-ID:
 <PN3PR01MB9597B50EF69AD097C594F844B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::18) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250423122903.43547-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8317e9-fc88-490f-6f09-08dd826273cc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|5072599009|15080799006|7092599003|3412199025|440099028|19061999003|41001999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WK8LQbihZEQXYCUW1qY8YCnusFXk2C2kvCzQq1LeXz/QQQlDJu4uH8F+vIUB?=
 =?us-ascii?Q?Q3uhRk9KxtjefEdtJDp0leCBflLp7slbvI2ScOs/RzYzZJXVv1ZMPFTz/qGM?=
 =?us-ascii?Q?e3re/RsXRUxXG7Oof9cHe8owKI9moyP78qPADWYJj/ojoWpuZHSrXizfPYqn?=
 =?us-ascii?Q?PmG79hu+KWM4hG/l0FZCNtdTfGR3mdQcOptpuK2VQI3uDm0gtm2wL3ZWYXlu?=
 =?us-ascii?Q?fOaKvTXFwodxU8ABhf0+mlGsjOr0NCGimhNrVm1YuhEBwzex/gxz8iBPEJAB?=
 =?us-ascii?Q?1JR4KbwaId+zZHFBP2nk31Vc0Wn0Yz/sSpNxaFNwK5rjr/cMidSEtGxRg78O?=
 =?us-ascii?Q?e2/guEjxkyBIW/F88RRG5r/QSchOb88/8l8ELY8bbgknwlgZ4hM6ebD+qQAZ?=
 =?us-ascii?Q?izjz9FKadbh1xHUvi1xG/lpwgIYOLXh6oZ3VrqSwYuehyC3NZibwi5hUopcy?=
 =?us-ascii?Q?X5YPM7ZBJHdA2/X2JYc5H0NfrJWEPm+0GkaiWLtMGHF33MA3z7gWasf3Bpbo?=
 =?us-ascii?Q?LfBjxJ9kHstwNfNFLx6LLJ9JS81YJ6oLpmzVZW4PGw7h7LMyNCX2icl6Noas?=
 =?us-ascii?Q?5TCn4HfslqISQohs67surqIZWHQoL1f82aRyPYLWgKMPNoprAz70fMVcqCDH?=
 =?us-ascii?Q?0x9s5HtnEgxyxAEbZ3QKlabrhB1lEDtwegYKSVo3GqPfPDj/RLTruErogyKI?=
 =?us-ascii?Q?l0pGoSpCJM3DSxmdoXxsd26cQRTenAp+80RziKJxt6lthgZ3MQ0BLbi2nRAr?=
 =?us-ascii?Q?erBW0Jec4PO12LEOpqmyoyn7mhq1SnQaX36sD/qg7PyMjGcgpZaZ+9b+ZUog?=
 =?us-ascii?Q?Q+WU6AeJUUC6DvHWEixlKVy/ROfhOk6BB53vxn1pU1/FoY7R6dOL1k21kChG?=
 =?us-ascii?Q?VhiVo4cFXq9CYMK+9/MltB2Nq29sGyDFY0EJSOQxIQ3C/OVjWpk7VwLNSTmi?=
 =?us-ascii?Q?ky23aNHd3nCs1549ZpBqqizddvIF17Oi6b7c3/KpBlGh2FHf1eSUNM02akS5?=
 =?us-ascii?Q?2S4J9iwh1s7vmsV1IDK7+xA+THQd9zjbEgC9efRlth9CT2MSnk9aXA+gF9xE?=
 =?us-ascii?Q?fa8DefzRRNUpOinE3GxCmwMrbWeLU2fKBTf1yhsr19nnjlbr2fxhHa9UI2/H?=
 =?us-ascii?Q?9IpUaOJZGhQ+1cZqgZiNQ2SgGJZ+bMpp9dptbP3kO65e2PNA6w12AO7hgn2p?=
 =?us-ascii?Q?cQPZLvCXyTneWcMcQSRMRJnS/iTxxa9+Ve4HYA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XO2HJr/oVZcWSiesCcg/ghqbyFU+KQWmSoeC9SnSSLZwElwT52n9r01als/4?=
 =?us-ascii?Q?84yYsQZDB5mWDZEbapp/4cM3i87dg39iLk6Us/38BDWXdRJ7pBomOcmiinet?=
 =?us-ascii?Q?kP6cvBcP8rAPxSYgUG7R3ucz2bOdiaNSttce/BneP0Z+lZnLvzFk00FNOkik?=
 =?us-ascii?Q?3QqnACzpz3gayEggDGGodKmaQ9XfdqOmXC60eRhlHRHwRb4F6homxK0oZThI?=
 =?us-ascii?Q?zdsW/N1qdvCdc7g4Mr5iS1lM+5km+/6u2lazsNQnxpNLDleSTcuA5kTGs4qG?=
 =?us-ascii?Q?mhBNlgR2R7nOfFeY5kJb14tg7DuQaE6tEk0r9VgCCuP86oYMbUD9wGFIcSdX?=
 =?us-ascii?Q?diZF+NsYCXSz1LKNSnkatXeJ/FHG0owSCjXnyIxpZK348wZvRWHbaZ6WZe+t?=
 =?us-ascii?Q?3RhCf97YVuoKlCQMY0lyyO1WrixU8hSKgjWBgUxc6mePQuV7CNQBgoMBx+OX?=
 =?us-ascii?Q?DpjPn2KjmXg82yr89nIiDDuaDBH/Qus2hXZyrhUHDwJ3Uj29rbYo0znGDHah?=
 =?us-ascii?Q?gqVY6ehFLyQE/XhNd5kwXWe7faQwjFA1TIwMT86PRLuYe7dZU6s5w2NFsXR/?=
 =?us-ascii?Q?AXAisfVFRAFrw5kqIRJLsSzNcubOEX+1RA0cbIi1ZsmBWYU4+pNJ7nZiSUpI?=
 =?us-ascii?Q?dDYkOmHP7bhYsoZ/ZTGFq6SSjUDPQ9fIsWZY3CiMchSiZgWWGMTkKs0CUHWV?=
 =?us-ascii?Q?oStE3V2uYHdIkmft7Xv5DZI151tE1j7AiJBPwOUvWhUljO3hiIcJXh0l+AZz?=
 =?us-ascii?Q?2TbH4tWyBzZSBi3uPO5vrJ1cfOkdPx3Ifmy3IjDztzx1KrYxsAEx+5lSXxc1?=
 =?us-ascii?Q?+kItCOD1L7oTAu8gto1OvPPhDLUC3fG3KablYeTe6/1CTY8tYzrRDSndQuPi?=
 =?us-ascii?Q?g+kJ7sY89DN9OIkXguE8LiaLuiY3VZRgs8UPw7cRrFdUVHHivJOfN/dJbE1V?=
 =?us-ascii?Q?xX6dPo5hirD+Lv3nceR3gWKZQmHNw5JpGMetG10n+H80vT/jfL1CGOvxx1//?=
 =?us-ascii?Q?IcIbEwccdkjh7n8q/XU8KXLBb2X/EXRESoQW9gikzeM+C+4W9ooKVMsomYAW?=
 =?us-ascii?Q?v65CKgvsloPpbNf90kjexku720TxQay2AM7WUBtp6NONEh6KixA1EddBu9y1?=
 =?us-ascii?Q?SxICQVeiZ8tVEJFwiaR9utoJO5hnxkczdO9unwkhbz3tRi75osYpuaWyvAbN?=
 =?us-ascii?Q?Q8X+C6w0wuKsoxOpJF7MMTD91+tA0FgerMO6K/bYMoVSCQ1YWY4kyCFm12o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8317e9-fc88-490f-6f09-08dd826273cc
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 12:29:11.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7143

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
index a18e978e22..cafb9aa43b 100755
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

