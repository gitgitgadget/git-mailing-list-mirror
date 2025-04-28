Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011026.outbound.protection.outlook.com [52.103.67.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC524AEE2
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745863120; cv=fail; b=hhXwzRBHE8G7f4VH2Gmq8KWVd/vV6a881mqz058+oXi3XbAEwNXvMlFevHsQVsCI2BKXQvijdjcIGyzUg6ScE1sKW007rDt0v7pP84TAg4kVfKNvBbtiw+jOfDJ1cEM03wqG61AEJbi75jGKDvGbXyZXy4l2tBLLEdp7mf9pn7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745863120; c=relaxed/simple;
	bh=LPV62IOTj/MVdsema2bSZyVbI5WUbNUKpmxJCEQoy0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kp3EZFoB6dg+ufkHeRQIfquMmxM3K2h4WxXV6BUb17z34AXRfVA/HfaHVwwP0SJ3k+EjPWFz3sAZ8BstSIC4hurlHnScNGmehihOWpjyaJTiCUNUZ4sZkD0SmeU0cc5WfdLJhymJNXksE+UTneky5jKoOW7SZLjdeAshiOidybA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bzIR6/qN; arc=fail smtp.client-ip=52.103.67.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bzIR6/qN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muswbOipbHWxAQgq5tdSGZ7MWju3N1zymSVPE1mtQ/8NcgFBkaUgvPIasFdNwWLbAX+cKWlNxUZTELhgFGCsD0i1I/7l6bFasI2kwaCCJ41vOtm7p5VaUYqC7NQK9Y+oPM5VHTnMDLKsFJvmOaaDeD0358jHO0o07Ejpaq4aRqIN2JUnb8pLTl+zvU7cKbXk/KgMj6IBxL5zf24ERJmH+oXLr02JYkMcnKGnXJrk6Ow1wtOAwr+iFVxRpumUeyzATLmttS6mvqnTMyWgkUqA9nQUVwYjtI4R8j3op+pMZsjFwiqai4B5aUo2txFNjC+Ii4xCCQ/JxCqU3zOq2Wxv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3wUAfuf977MfgNfFnrguIFIhdLQyFIqHa91lvZk0+o=;
 b=UL7eR5rEkAqUDnG/0OyTH/XTSW/9qgXtPO/DW+P9NZwutVk8LDb0je0AR9pjf8hSF3NLOVHe+5nT3kcTYuC73k6j4JHDd6VzTI1Xu188vPz51X0v2Sp0a/BrBS1Er710Y50oM6eKXJq8vkij+ySVR9uU7liWAYV9Tcq3Ht6i2KOGrg4gTSm+dM+pP3niVDzku5rEDpIBEuYSHci8TA6mZfhyQJf64oOB2WNWE4BgoIns+gCtw28MKVK4UDbEaOcyl1oOIW3E2esGVIZVCAV6Q8v4LvBDkjkoqSo+Txf8Irc11wve70tQ/KuV19F/P9NqQYIKI3F6BRGR+4okZtno3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3wUAfuf977MfgNfFnrguIFIhdLQyFIqHa91lvZk0+o=;
 b=bzIR6/qNTe/CIF74gXZQQLUpvGrSL+z+zI+REKw4jOHrwRy2af47afM1x6JnvvWpxF93WnRBG6QjOUoXcToGNDmOkFhHLbdLKDIy0sq74+MhaSZWGq4n79KUKl6yOjsMEzTIXwgam2bfct0nZ4TC+zo3PLLIF9XA8S5IwuD5CFEyvdpSCvQd0ZJ+Ohj7NL1jj4sh0Ohw/IrdTY6jG3rtOcsgGVKnIIeRX1ccPpD2x7V+IpowfMpSYET9a7VRANYkQp8dKARHHm+Xg7+jfX3AqRKbdE1r8QVDRHeo7gQ8PPUK2LT3Ou/YdVufa3Gs3mjGj158yMiWmb/YRQHlP6UO3A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB10029.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:16f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 17:58:33 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 17:58:33 +0000
From: Aditya Garg <gargaditya08@live.com>
To: gargaditya08@live.com
Cc: ehuels@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	gregkh@linuxfoundation.org,
	julian@swagemakers.org,
	mirth.hickford@gmail.com,
	sandals@crustytoothpaste.net,
	wiagn233@outlook.com
Subject: [PATCH v2] send-email: add --smtp-outlook-id-tweak option
Date: Mon, 28 Apr 2025 17:57:15 +0000
Message-ID:
 <PN3PR01MB9597D897A65B4B59BA6FA93CB8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250428175714.24524-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB10029:EE_
X-MS-Office365-Filtering-Correlation-Id: 7752d575-125e-4d5f-e4f7-08dd867e4ac4
X-MS-Exchange-SLBlob-MailProps:
	igNrEvV8uhHi5klYzQchmbXEARBtURutmqLR8GDg7veRJDuRGYug6ckBu86hhuYXdSWMhiZZLJ928u5CDf3vb+Cy7hYi03r6bAygmkV/YcJ+Qu6TdFsUmO6nO2nFzxHn78ncmxPZ+NEgWf+5tYsfk2kvXh7dz7utdfIRqKCOzZ6DfPxkeTVGDeHQUrMkF7K/P/ZJE+yvQfydtJigZPXf/VjRMlUgrmTSGH+GVhZMDqjK/xIHH39pmFMNgAI5AXFFJ3V1/RXAP1kzANctSIuBoapPRQzYSgor4hEFsFWBxrfMOP43QAA9E7Te72gf5CcykpRk92yXrI3HJNvDy+jVvT9hdMyzjDVs/tsFnVo98QYfvpsaYfoKgqxzvn2xfGC7G2cZkPFNdwLxbdWi1ixH3RuatKZORxTnGXV9+0D7oApFghSgVzKWCpbCMz4qFp89SMNmFsCZsqg/dX4Fmjri3H3ARPXN0kkNJcNV6Q4bwo0+qllkiO9z/4MunQajZ5VL6yAgc0dM60m4IR5aEK5Ohn3tb5/1GwuKzQMtjA05qdajcQFE6rKBsNO13+go+Rx9dCa4SCt1FRtHKeKINhac22uMNsk8Tet520EgwnpgAUWpKkQehUs+t6NYBaLtpqliZRgsQijIOUuD5x6VApnFSybGPZWi8gJ0pXBtpGXjIlBc/Fyke/2wbsHllp0XVMVysx0gyRb5Uiw=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|7092599003|461199028|5072599009|19110799003|8060799006|41001999003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+L2TpuvVj8Hm8DPIsnuOrIQZc/abqau0K411bBwXuFGCs4exT+kRU4yPd9zd?=
 =?us-ascii?Q?zULnpHO1m5XXVFftqGY/74huFQGbyhY3NHW/2v2lWjsbQsj0j/Fys1tEviBH?=
 =?us-ascii?Q?6pnsJEyTgPeoW/OUbe54SntRsKIa16I7x0SbEYNhvHxwipnaCjufRAFsjmXn?=
 =?us-ascii?Q?hjZ9wy4vKSUTxs6+MujNJiAOSn85j5Mn/txRLTb9k3eSkJxMtyreez+hWCOw?=
 =?us-ascii?Q?tMUsvkEXo+86WwhkoJ0V59IY4G35sbkJEDFaNzWqaF/IU+DXOhA7fcHBFXnX?=
 =?us-ascii?Q?RZQ+uwTf+IQ8GRpnQgyK1GU/+2KHKR43+lAyq2WS1lp20sir0gbBrNXclZW8?=
 =?us-ascii?Q?1JYnoUVBw4s0gkIFHzwk6B67DenVK199MyQXOC4jQq2/tnqSTGf7k7wW3BAK?=
 =?us-ascii?Q?weIAqdzQUjLiGGM1xyeH5AI2L3fvGvH/HSWgcQue+Qlh93vptFQg8o/1dqgr?=
 =?us-ascii?Q?3TUkR/Fq8j6LkOAgt/6bWrv9BUwKSZMcckAmgU04HhCdTWfATpvvhWbQHwQI?=
 =?us-ascii?Q?ElR9gC7OP5JhQQKVGHSpnsPdvX2fOzxp3myLvGO/ykJbMysJ3xMFGrVeCr6Y?=
 =?us-ascii?Q?Zf7PMUstdgMsb3bnyX3JQ9/oEh27wD+mqfMx50plM7RzSFAHVP01c3DxLumP?=
 =?us-ascii?Q?IfAItBuSLRIZcaJmUw6cAxHtxhx4tr6s5GoKYepRonBBUnGiLMT07dF5LKZ7?=
 =?us-ascii?Q?pS5ibNNs/ofhk6fjhInosfd152q6ui9Z1akEDIItaRRvjWnh9H50NTb4xWD4?=
 =?us-ascii?Q?QCQtsPLeWAB/VQiBrfXtwpges06digc/knAZn3PYmLcf+G42y+S81/1J8jAs?=
 =?us-ascii?Q?TWzZh8PuUfRGhuMbqfkha0NH2LcCh8+QCr4N+uNhO4MFA8IUz/lOcWspcQCR?=
 =?us-ascii?Q?MrpVsb/84ZUYfmRZ69m30qCOX0F4JVRu8RdkZOwoEKuyC3xE1vymNw1IfO7X?=
 =?us-ascii?Q?nz9pyPFE44BvSYoDfQOw8AH7w5sQyRBExSWrDlZVxut8bFWJ6YlOQmnKirMQ?=
 =?us-ascii?Q?2JNbjZGX82fiOYz9LeQNqJOby8IIYhQNWr5FJwyzHR4CfcxwyPeTA9BnST2d?=
 =?us-ascii?Q?RXIpjdNS8cFnzKF+zhwMztoxBVvGxbIFz20huivEbiwU5jy+561xGNQN8otf?=
 =?us-ascii?Q?CcKiUBGp4wuoxJ7V4QajU+6yiNPG1FYEFsif9pmdXOUuR9Uj7+J0rwI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rOeBIdsk2xKOZX5APi4gRtL3M296wctLwLbfj8zyHELlMhKv0IdvmOVP5d4X?=
 =?us-ascii?Q?jBnau8jXcES+lyyTCXLbpKw3SLjuLMOE8QJOvMN0CbDNRsS0mL8/Ou9iHtID?=
 =?us-ascii?Q?AJI18gufqRUEvnfUI6bnTBohD8FyRPhNc7NtSqhqM9sEbipds+quWaiR7IVu?=
 =?us-ascii?Q?5QTe/f8HaHJ6ThkWKLpCHiXCKmCj7pdoVRwQ8wZhJofhFu3QsTyPcw0G8OjG?=
 =?us-ascii?Q?BcYhC0J2RrF/ndJKQIfeWjVjYdql/r22/rU+LYZX2GG2ykUFvneRrm7GC+xI?=
 =?us-ascii?Q?e4Pge/gaj7/V66EXh6Xgg5s1zbUpMMhSt8vcsJsehCfx+c5ZUjvcA0ZiMXc7?=
 =?us-ascii?Q?hzUxZ32tpS3cwJHQHqBb7RfuUF83CzSJqkAg+tLsIJIxwW2Ohoy9mD2JLOJf?=
 =?us-ascii?Q?yryjhIYD2N2w1OgIzllij5U+sGUZQBlFla/pTEJVGDZhznVE9HNT8+GZ/J3Q?=
 =?us-ascii?Q?8ObHbdSANrqRoJipUP3mWHGIEOR/aiptiixhc0raueXZzKanqte8xTofmv7v?=
 =?us-ascii?Q?UM0AN78ewkuNUzn0cPRcJb2YzZEZCnJPkVCjCJCuve1fiGp1Ws0xFEEWNH4Q?=
 =?us-ascii?Q?RgsagRv7jVRgfDr6MfKRQQnP25l2cqWX8lxVSBp61lQPhFs9+W7k1u6SuEQj?=
 =?us-ascii?Q?TcTmRlIvxm6TWTmYxu/gPwmjmAazJNo2e2731pk2m9UeCzrbOAsET2m+BCwX?=
 =?us-ascii?Q?7O+9Dt13Ox7y4gjT2oQuIFwuuMO9Ngv163wai11kYRUOKKytUVvmU/Y+Z9AC?=
 =?us-ascii?Q?lUSfl3STwbByqzMxxngsdy81KnT+yuPVFfqkeOGdejLpZjaEFTvjAflF6giC?=
 =?us-ascii?Q?yjBuyvYPKE8bIoxlghxxYr15pOPu/SURJQ/YZlJ6mkiQ1yo/d8JQ6TBCbGV6?=
 =?us-ascii?Q?3wDXcVXRJb/vwPWi0DC2icXEAl389ksilclL6WOo+u9nLGjPkDJIAKySchNu?=
 =?us-ascii?Q?YiBZLIcsKtXjEVyrB1ij6ZksX2BfFXmcJjRmI2C5WqXIV27f0ClCccys0btV?=
 =?us-ascii?Q?BjeOiIzkKbrEdZ+uUBtttHJiB/2dwndD9tRXXiHE07ZAEa2rgAggbK/2YdKT?=
 =?us-ascii?Q?A0W5szrHK7wd5ES0JoCmZwFZKFQjl7xIJnOA9u/SVVuaig8ofmGxgOedfLhL?=
 =?us-ascii?Q?ik6/lKSUdGCEd5Nf8ND9V+cR+liNHygDnR4I7WmmJPXbwu28v5/+oPpyXQDi?=
 =?us-ascii?Q?0wvoHUUFXA7eplW+g51KreoZM2rl1FneH8KpJzVgJpt7pYZtop23GXyZqDA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7752d575-125e-4d5f-e4f7-08dd867e4ac4
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 17:58:33.7287
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
v2: Replace tab with spaces in "outlookidtweak" => \$outlook_id_tweak,

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
index 618474916e..20cc460ed6 100755
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
+    "outlookidtweak" => \$outlook_id_tweak,
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

