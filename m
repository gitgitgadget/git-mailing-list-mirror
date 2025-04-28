Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A4115B0EF
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745862833; cv=fail; b=BcZ6BZvhxWmTvOlybPIpnSvkjOlbkwKgSDZAT3qCAbYMY78uq3f4nu1PGND556R/OXOJDecz/evL/RZ7a/DioKl2QlDbn+p8FUQ0PKdvnyh4kZbYqlUWFVHPRRWTarsCUnSMDg5CqFcJzgwq2tOma2enrGYaP148l8F9y0LGL0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745862833; c=relaxed/simple;
	bh=Z1Ad08rJ86HNmmg7Bsw1fV1ksYOkGQ7U6PdrLS+0zu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uMrUMao2+jxJbjv4UQ7RmdTaMEJVbUuQgCyomvaRQeDUyGsy7GqeQzpug/djOsMh4ckVvqKmZ5Kbc+HPhYK4XulbHJdHHzSoXddg4MtanYsSb9tUEgsl7J82HVZIuNnTTnddNBKpYVnkjVaFZJY5dE0amk0vAWwGA5jlEAvBfTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=FqzquuHK; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="FqzquuHK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqTAS7Oybr/u38F6p0Ng9vfGX6hF0d39EcnZOtJ5LB0zNl9Xa7sPu4Xfkdc/UD1R9dLBHfElIkzYqx9Kyy+ceWzxCe5FvycDfKuEA11bP2K2T0/6cjw2xrSSJGzVmXQVcw5a+j8XisVLwQIbWmXkFFx6I8OMHq580cwYgUV3oFzL9wYKffYSx434E8j1+dVuh8x7Z8R7YdiutprEyoRL8r9qWb9YPiCoFqjBu794GsRvb7Dq3vn7CMXQjdYtroXc6+w6EOVZyVaxrELQ7b62hm/ymL+I2ar5Ke3aKK/B01eMNBv9UmmtFe+CluqISES2lIZ2mXa9S308OAwODBSc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eGIw5q2dmaHwGLxyV7D2cq5rwxH7y9UTHkC4iS2odv8=;
 b=d0X624BzM0qmxj6HfYUw4Qz4mrxSuXQ8ka8ccCWXZep0yGXB9TdA9yfQaao08vLjfm/G8LSTdSWxDZqeVmz3sfIFVq+OZ0oHzGJMg57LJ6qwXjt7nc2SuS3awaa+HNWBjWVFq17z1NiVMCJvqM1GI+FEDLuD4ov+/kQk7eCQ5dRsGNOqViecXOgXbRSjeJd8d+E/MChXF7+7s8ns0/J3EXkLmDuRCmYUFEQ5vyLw3ZTEJQ61zTkeG56kEM1ZINLRlK8di1RITI6ainbycV+6aUY18POCN5AGlrtGt1z14F2fWGKOLWbwUGdLYxnPHRWBoQkHID6bX2abJHxmhdHR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGIw5q2dmaHwGLxyV7D2cq5rwxH7y9UTHkC4iS2odv8=;
 b=FqzquuHKmRelU/KpYO5/MDM7y6xih7ccU5WAjJ8CQAUQuBokpJih5wDehayRz5WIanXvKaJB6UYqm/AvJZKbgO//5XqkVGnZUPLynogxE5bIZOIbHzQQ4krRqriQJYmtc5LWxFWQk6bp7n6rqbmLv6r91tqww7X55v2J4NCSBqtwH46i3a2i7HAmFJavA76G8TB1nODxIkRl9HN/PkWEcvCcSHvLx3kVg/nxWcumqi/y/jI8MLGp8+KJaUClPQGSSVtNAeKHXSZWbCh0rj9X85k8+cEk1wVk7MWAS4jSvY+1ZxjHKy6LkUCcG+8T/YyBLEwXMDxBZPNh3VKvGqjfgA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB10029.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:16f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 17:53:47 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 17:53:47 +0000
From: Aditya Garg <gargaditya08@live.com>
To: gitster@pobox.com
Cc: ehuels@gmail.com,
	gargaditya08@live.com,
	git@vger.kernel.org,
	gregkh@linuxfoundation.org,
	julian@swagemakers.org,
	mirth.hickford@gmail.com,
	sandals@crustytoothpaste.net,
	wiagn233@outlook.com
Subject: [PATCH] send-email: add --smtp-outlook-id-tweak option
Date: Mon, 28 Apr 2025 17:52:59 +0000
Message-ID:
 <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <xmqqfrhsdy9z.fsf@gitster.g>
References: <xmqqfrhsdy9z.fsf@gitster.g>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250428175258.22127-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB10029:EE_
X-MS-Office365-Filtering-Correlation-Id: 01791a39-26d5-49f7-1727-08dd867d9fe9
X-MS-Exchange-SLBlob-MailProps:
	igNrEvV8uhHi5klYzQchmbXEARBtURutKUuyHRWxfXu0EL3aYF+0oaPuFoMYlB/QOwNrD1jEo4riISDKBnOEjBb2tf7FJok5lo/CNbdJ6GeR3CqWIMB/64cC15QkpOSwp+nXXeBBocymOs5UJk6fmNcUafkEESkrMpvZBHGL/hn3MuJQGhQdP5aVR9d+mqugZIGIzK5Y2Tt6orsQrPdNwMUXBy+ocHOM8Sc67QJ2RVvoH7AxSrPOciP7j6l6WiuQw8JyW5TQEeWotjsR0YTE9LvoqFySMCnPKhMDWMjc+Gbnogbb50eOQqLP8gSgT51WX7OfeIiXt7eUoM5hveSiOKTRFqz7It7ErVzkVdoIfTIDEAdPSCftq8qzCLpeRWVNMk+0evn3CxG2WU0W0d6orv2VMCtSPXw77Ey80oWwJmF80isHyQWb+/O0dAkOq/YCcoAK9hPLeoiRzd1U5ZVbZ7u/Wjfu6F8NUNdlTInTj5dIqA6wAR3jn0Sx2RHves+VxntOShzid8es26p5eLawYn34rJeDA3o8y/x1TtU/QfcivewDnfY8m/3s9nF3r47QwHkLMDam7pRv1N/fkQTXvzenZt+Gr7DsichMdcNFe70olcIPN0NOL78TJcIE9ic5J/knrltjZyN4QUbEtPF4DMq2aOkNbKJgZ1ot3B+6i7Sz4CFjqQ1IetAgzsbzuqrPi7/fz5Gd8GM=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|7092599003|461199028|5072599009|19110799003|8060799006|41001999003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WPG8P8bJNVAolvm/hHSYifw6pjCYupvUYOZeZevtiSFpB8J/xvhiWJP4Unbu?=
 =?us-ascii?Q?19yzOEZ6mDZt5eLN+Nz17IoW5yH6WxyoDXKA0FrEs/pBbs5kWtPDXbi0IkBt?=
 =?us-ascii?Q?B6+7D5THVUbl7v53nIgz+0sHrMVbz5Ggyl2rq4Dlr/eG2XQF0yBVH+Kuu02I?=
 =?us-ascii?Q?FHFEP6wMTCVLbpno5cJ4mSP+4wuvRFhX/uSoVwli0D553nRJDsNUSW8rYhu/?=
 =?us-ascii?Q?U6FRUmMPdhTDrRCMmFWMY8JqbSFw6Enic0dQzjGDl0CmEtYGp+Q24bM0pykE?=
 =?us-ascii?Q?VU2+PdM66soau0tvPy3vbfZxnALiRm1RSuHzEtsTApw5Q9PGKN3JH4SHPQAu?=
 =?us-ascii?Q?4ouWfF6r2OCNWmpxV0s3hIoRb65kR9VcQ7yQaiMERE2v4CsI6uxhjNeUitWU?=
 =?us-ascii?Q?BsIV3vPHHPQNdC/uBIqdIIRG9djAa2vTWPip73+Qwm7gjaueMQKXBYKC/kzy?=
 =?us-ascii?Q?XttpKx9OXor3TxY/9C4AQEALHtrkS75TGeI8PfzCx+C7zstgkqbE7x3itdaD?=
 =?us-ascii?Q?mW4sXquDUx0Pd+qsMlIS9NmGTsD4WFssWbaajeNFfPqKb4lZbccq+LMtJP/v?=
 =?us-ascii?Q?A1KtIdhtBHoZwoZwKFHI7eW35qF7vK97Oh7/+UXQAzZ5hsB1fXi2YlyCUf0c?=
 =?us-ascii?Q?VCZZ+KZ+u7k+0074kdeKMK8qb9iNiMVMsonbv4RzFpjFZ2E4pZXLnXPp1pp2?=
 =?us-ascii?Q?giqxPnAfE+Ufo0Yh2ulMrrknYJjwp/dcXlLGhWX1PcuX8OhA6vUh6gpd80Bg?=
 =?us-ascii?Q?QSk7vClg0TuLij7LMWRlm4rdtfhVVW/Fi+LS6LF3eZhmzeUD69he+WxigorK?=
 =?us-ascii?Q?tdk9hoS1RhL+mQxzuR5hppeiQLwxotyrsNywJK2bUKd5WTCuDHdn7ToX8yc1?=
 =?us-ascii?Q?UfdHREBhlhGh+TFZCjkqkwZLYvylRo/CYe+SL1ZnPbx3LO1lRferhvRnPy8E?=
 =?us-ascii?Q?xucMOiRDTxQGAtKfKXHwxVqCpPOuUgsyYOqXpksDRyM2DkjlLZOkcNsV2fGa?=
 =?us-ascii?Q?T0roS/rOQT1yQkXUfEVNb8UfDfsN2727Thvj+AYfHj7tP4e49S4pzrCDrpGV?=
 =?us-ascii?Q?4aTa7bQH+ZNi9XkbQEahOargUFZVD8qcaw1ZHFaQNLGnXCnScyFnKqd3+MiL?=
 =?us-ascii?Q?R0GXpeLj0dFzOep8h4oUl9NJstOdiyH4joZwhQ5nXu2dzYR880RQ8PI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/gW3Lmn//HcbyMsif05ODSB0v9G8QREH8c5PIOZLCuWCiDwBdJOuZzaEbElB?=
 =?us-ascii?Q?iqJAMH1X7iyPoP+SMQ48bMhg+2HDQGWxqyVl3v8fsobLXYcrEh224/cQF0JZ?=
 =?us-ascii?Q?HgJ4YqDg/yXuNs9LGAi4udces6G6MXsVDOq0m2Z9DgSs85S6A2h4VGClswoQ?=
 =?us-ascii?Q?IAxTTWVVsMRHS7FInA3KVCefZvacGAhX0SZUIeUFf18ZKmPytMOTuer7nvVZ?=
 =?us-ascii?Q?AHekcNAcSa7VnblSwdwUER/RU3K67jMvDmRIpRgLVVC7OSRvS6lQa2qTAFcF?=
 =?us-ascii?Q?3jgGOnLtZWmdG6xIpcY6YYS95WUJBMJ6mf1kXpWRjtSxgCIjBxRHRzkcXUpt?=
 =?us-ascii?Q?FwlKDioJleG3p76ga3IjM2R7MN0s3J0ENp0jjMulwsZE68bUsGN7RGOetywi?=
 =?us-ascii?Q?M1HHErNPsAhOuREeVbTRmVHylJahxlgnHr84mWDXYu6ZYeN6fs/dHd479YGX?=
 =?us-ascii?Q?wHR3Gb7emZ8TityhzLQJ2Sm1LsavATR94uDCKCRq2AolvByekn3zOsi71Ie5?=
 =?us-ascii?Q?l9eFGAjnDBnDnL5OjQnzPTfXg8xxRzm1w/u78bGzTbc7p/s8eeN9anu6JzGX?=
 =?us-ascii?Q?VCPp3TzCcOvhRspCN77Q00LAP+tZbmvhT68mlC/J3/RPemnQfqWgDQWTbCkB?=
 =?us-ascii?Q?Mwc7gaHirosHoF+glH8TQY+tKAc39raUCm3qdqvVcrBZhUHdP+f28fWBuAJD?=
 =?us-ascii?Q?eggH2gF4FcR507RzvrOUL9DKwokRIv8FpNZcyX0qAhAfKgRPWmWYIU+IeKKL?=
 =?us-ascii?Q?eiu2dFP5oq5iUI0QWqcifWlHY6+boBabiNewTl9d5kZ/J0sRbnsR8CKZyBh6?=
 =?us-ascii?Q?dRnvauWOJR4yjh5G6KIvqvtj4UEGwbqsmweFjydkHSq5HL+lBR/oJUldTnEG?=
 =?us-ascii?Q?7n2rp+ae6BZ+7mD2HuyR+huWJrpd7136cC5XdFFNzdZA9aLqMXRGsX8NYNUu?=
 =?us-ascii?Q?vSycV/nVUVsXUk5opl0yqZvfLStQC6mwSemNSw6YLkdodB031UvuNjADAfM4?=
 =?us-ascii?Q?45EvN49hhkk3TKqxbWmWdFT93vdcuWR2DIZp93n48diDsU1D7im06/gcK6K7?=
 =?us-ascii?Q?4QVTOU6A2PJ0VKhNoaxUgjnOheYNhzpR58rJ9VZiej3MLxtS2IDjxGCWrziM?=
 =?us-ascii?Q?rpbghCZ6D3ydkjkVRqC87kkTl9rx0D9wrbnZvaw2+2Vi5eOiwEdGynMtQaIK?=
 =?us-ascii?Q?xvDqDaL51eW+YHPDAaEkumqKcL5w/5F2GSzSpWtFyJNk6MxfDUZZ1zlKMJc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 01791a39-26d5-49f7-1727-08dd867d9fe9
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 17:53:47.0533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10029

Add an option to allow users to specifically enable or disable
retrieving the Message-ID from the Outlook SMTP server. This can be used
for other hosts mimicking the behaviour of Outlook, or for users who set
a custom domain to be a CNAME for the Outlook SMTP server.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 14 ++++++++++++++
 git-send-email.perl               | 14 +++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 7f223db42d..20f804e4c7 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -153,6 +153,20 @@ Note that no attempts whatsoever are made to validate the encoding.
 Default is the value of the `sendemail.transferEncoding` configuration
 value; if that is unspecified, default to `auto`.
 
+--smtp-outlook-id-tweak=(always|never|auto)::
+	Outlook servers discard the Message-ID sent via email and assign a
+	new random Message-ID, thus breaking threads.
++
+--
+- 'auto' will attempt to retrieve the ID from the server only if the SMTP
+  server is 'smtp.office365.com' or 'smtp-mail.outlook.com'.
+- 'always' will attempt to retrieve the ID from the server irrespective of
+  the SMTP server being used. Use only if Microsoft is your email provider.
+- 'never' will disable this tweak irrespective of theSMTP server being used.
+--
++
+If not specified, the default behaviour will be that of 'auto'.
+
 --xmailer::
 --no-xmailer::
 	Add (or prevent adding) the "X-Mailer:" header.  By default,
diff --git a/git-send-email.perl b/git-send-email.perl
index 618474916e..81ff965844 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -60,6 +60,8 @@ sub usage {
     --smtp-user             <str>  * Username for SMTP-AUTH.
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
     --smtp-encryption       <str>  * tls or ssl; anything else disables.
+    --smtp-outlook-id-tweak <str>  * This server munges Message-ID. Retrieve it from
+                                     the server.
     --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
     --smtp-ssl-cert-path    <str>  * Path to ca-certificates (either directory or file).
                                      Pass an empty string to disable certificate
@@ -290,6 +292,7 @@ sub do_edit {
 my $mailmap = 0;
 my $target_xfer_encoding = 'auto';
 my $forbid_sendmail_variables = 1;
+my $outlook_id_tweak = 'auto';
 
 my %config_bool_settings = (
     "thread" => \$thread,
@@ -333,6 +336,7 @@ sub do_edit {
     "composeencoding" => \$compose_encoding,
     "transferencoding" => \$target_xfer_encoding,
     "sendmailcmd" => \$sendmail_cmd,
+	"outlookidtweak" => \$outlook_id_tweak,
 );
 
 my %config_path_settings = (
@@ -518,6 +522,7 @@ sub config_regexp {
 		    "smtp-pass:s" => \$smtp_authpass,
 		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
 		    "smtp-encryption=s" => \$smtp_encryption,
+		    "smtp-outlook-id-tweak=s" => \$outlook_id_tweak,
 		    "smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
@@ -1576,7 +1581,14 @@ sub gen_header {
 
 sub is_outlook {
 	my ($host) = @_;
-	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
+	if ($outlook_id_tweak eq 'always') {
+		return 1;
+	} elsif ($outlook_id_tweak eq 'never') {
+		return 0;
+	} else {
+		return ($host eq 'smtp.office365.com' ||
+			$host eq 'smtp-mail.outlook.com');
+	}
 }
 
 # Prepares the email, then asks the user what to do.
-- 
2.49.0

