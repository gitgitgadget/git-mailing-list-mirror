Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010011.outbound.protection.outlook.com [52.103.68.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E2A22AE7C
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944808; cv=fail; b=cAcZjUQE3627SXZA8QiFe6GbZD6j0a5p/fGqh+AvKNYqmJ3YCC2acVRwEFFoBMZSJLXdAQ3EjCApLEAXBjupmV8UOTo71TDTANsz/98c62oDT2OW6R3zj96dMKbu34EZpFO3huJ1kZibMyDB2gq3kTaP2yn9POY50Q+CniD1NLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944808; c=relaxed/simple;
	bh=HfnH0HZqjIGTPW+1jm0oEN3cGnV/A3jkLpoFV+Cp3Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dkuhWhYrhWCB6Eftfg56AoQYsJVkpgkmJCER/4ZKueV/2zSWVNkRK2aJafGdorjBAvMq3k4tAWY76YOn+uYkWWy1bpwGlNU4PaVRhMcC98LrOBGlB1EgVSGMygA2oLurXN9PAwCUXCRu/a4BVqs9n7cHHWy9gZxHr0REQDlU/p0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Fm9M79dZ; arc=fail smtp.client-ip=52.103.68.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Fm9M79dZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAxOipH8kAlX/6/w3KW1jxfHx8KXKCsC+wmjXOJREAFa/WaN8IxECLepmB5fQbsYD4f2GHs/i2brQIVXWt4kbYFEjgdWSnJ6aeh6E+Dfl59knemQFYHWKhjhx/TjM1nDMGq4GHExIm2ftiC2P1nR4QX8ZAgodikn8dUFPSV8kQWSyxpMfIx/aSr4lCFjLLsrpnls84hYsJWxxZbXuRWO0ufdFPqvNkq/RhkSK/OWGlSJeYZ4GUPFJlU34okPkrjZAVue5VLFRAxwugmf6MAKma+lpHRtlK73/ts8Gx8a4OZfFCArdA6lcKVh/4I4RzZx2T6Yl1p6D6vRG9ho8P+6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+M5rhbS0ZV7Lcvy3HPlWlulFJDfh78Efm2uunyXGos=;
 b=FsL19QmBnPwx6pXx933PpP1tB5Hb802KhqcC55KT/I3FUYcZjUU0KdXbLpKKnbLjS6S3pS64VQLdQ0A7WPZlAWQSSOJRh50V4XM7UgAE7+Aemn5V8Gc6CrF8M6Jz9Dn0s2BqqVcOfT1abPPbefxgttKp0RlxjuolTo02qd2JyPaVuXxwMqI0VxMU6y0osRTzy5rLqvJyBskHZAear5v/TIfMEnzZbA88df5zcyGCuMKOOtTXWbHco0W997AiwT+TmiBSCMv2sTs4TORNFt2pctiIE2uHmVBCHi1hVUdqpO3nkt9o1dWi3dnxkedLFC6ggIoJS2O9KxOaFFHwo57ZZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+M5rhbS0ZV7Lcvy3HPlWlulFJDfh78Efm2uunyXGos=;
 b=Fm9M79dZw95l/r8Ws9/odmQB3S+EUzsBgJhrgdh4QjqsJnJ6HzqmoNXMGPp7og48C+/lQ7JdDBzKxW3kpsbPArd52QpJAufqfGyr4gcyRedVTgZHkTpsjR9JQhlilZHN/oUrg2n0mTosAzc9JGu2u0iOGSoOEclWyqVp8jjkw/O0SH5q0LwJ7SjbAF6l+yEsmBj9JRmwA0HD6dw7/yyCnacb7mOX/4O6T69GU3HicnSz7kacDSyy5p81qpYHqR836mINE1ctIIw3VAw9FLfLvmBL2vXoY9HwFTXB7A/vfl+fxGWMoPaIcXK62Ho7I6klWknBxZvs+/HLMQ71FCT+9w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB6714.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:71::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Tue, 29 Apr
 2025 16:40:00 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 16:40:00 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erik Huelsmann <ehuels@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v4] send-email: add --[no-]outlook-id-fix option
Date: Tue, 29 Apr 2025 16:37:09 +0000
Message-ID:
 <PN3PR01MB9597AD101D75F316C722E84CB8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0118.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b3::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250429163708.24317-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd484f0-d52b-432f-ad6e-08dd873c7c0c
X-MS-Exchange-SLBlob-MailProps:
	CLk2x5OX5VZwo4mpOER2r1tzY7KfIDgGNr0csEj9Gx7WgFrUPz6aZCCo4BM7dr9kfHNFZ+RPLjZARiecZjbXQ/cLRG0flEL3O0WVNR6W69rJkXIYmDWh9i5odg4+W7uqZG90VBJqdB1VV2zEIr6zwpMPQ80Igeo/UAqY8I4KQdL+aq6y6C/kiSkXwcpYYr7kn8A36TzFpF4P34FFRFRA2e+yB3cAtnrhS/VlcDt5eWGYa43TEQXGlKDAmOycaaRuY9eV4mvIOdXXFmP3FhRK7l56DHfRODZULVby3OvSvj6c6kIZqMHClMWvKqd07bpptcEq6d8XXyAA4foJw+l7tTYQFfHeqpiyeLPAfDTl+52bK1caCPM4TkZ+IYp+oVZBUeYlymYu2l7yStsahD/C1YxNkBeA+9rSlwcSMaV5JHTyAmGViOw1zjPd5kcr3lwjU1BbHJ/eLcZVKoTwwPQKvFAsC6RYyK/MJC4sgVB1F5UjM4oII0YqkuH72NiQ0HWBMQ5YRmrpheEBIcwX1SL2KUTreetdE65unGSS5b7QP9xEuURUUsFwcap6ElAWYgksiQcNYO0qRzlw/nxWjUTWfuaXM3wrjNPREt+IUnbvI/wPAKDAx5F9jAe76V4gOIMnL92cV8ft3cLfIR4yG2VPKtJmu3IAOTFxx912ICmQRCNXkFmS5hvO/DzZJHlX2DzPXMKAlDHXdntNPVxU4bX31A==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|15080799006|19110799003|7092599003|461199028|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sev4tbetL03CjycSM44+kEME4Qvln8JziaEHL5ZgxAwmfvFNi+XLjF+JtiqR?=
 =?us-ascii?Q?OLcix4aDylt4e5YEY7xI/VI4WoRdsW3m69EEosasUbfMDJYi2WCyC4k9wPFT?=
 =?us-ascii?Q?Qjw734dV/CwcsR2ha2YIZBx2nNQi22x/gQfcF7uEh8tq6FQmuq0VDnGxOzy9?=
 =?us-ascii?Q?OYAtMdix90p2gtt2QslHfm1K79C4hTzfeczr89PXXRBTsgA60X4wvwg9jJnP?=
 =?us-ascii?Q?QYwbGE3oo43Fk60kX9lvYVQcPzhzL3K+lbIhMSn3BcG+6REtOxTECSLmkaVs?=
 =?us-ascii?Q?C61km8qwBXXvPUMnkxJQFs10PLL29vfB6zRpxW7aa9s989Fgfa9t4pkDgl5l?=
 =?us-ascii?Q?NzEZ8CKxz1q1iQ4bUszk7Jt0co3pK7jJCGqF3Caa0RlxLVmwcTiTPG5AieHV?=
 =?us-ascii?Q?piDzZ13RVeA+FyiJIGV+/mNfngmZffrP45qvziqmvykH8YRuI1YgooVZv7xT?=
 =?us-ascii?Q?JG50ieso2SF25o00bvmM/d6T8xLiVfz0KvVFjW2Ri0h5hr/AUiDlu7p+AKHv?=
 =?us-ascii?Q?79eGg8ifxCwbU/DbWOf9y1m9h6UClZVJaVNNFKSZPSW3L8Yw12M7UU2WdD1+?=
 =?us-ascii?Q?JArCdioVSvN1FwIjGcCH3d+pW3jwio/+dwDFvmUQyHxOGWTFpXPN845xrITW?=
 =?us-ascii?Q?mzCugVce7CLwqNYXbsWD+Y8MfK2ALQqmOeiEa27jJeaQHZSutCjqextA0ASx?=
 =?us-ascii?Q?t7pa0VfM6FwlMRbYReXFrcqMfzXOPxTpWwKaUYm6qugx/dEGjGUEerMfX2Ih?=
 =?us-ascii?Q?u8S1+L5iQ18j+YWGyEX2vixUYIelIggzgFyrynvDRlYoiVVz/vhAmhbY1I83?=
 =?us-ascii?Q?U6fpIH9Q5S3KsQ0GsArNZjtuYOCPALTEF19obyzKMsBWtd7WnxeiP4MsNIm6?=
 =?us-ascii?Q?ETxqqM1woi8DG8KW13BQhAt5yKnqzrFdYoUKeO9y8m7+BNq7QCIIWV6JBRan?=
 =?us-ascii?Q?0xnAwfhN8XrmOvlaLnAo8Jue58FoCJ4xW8HLGmuzcEfjHx2YMCkqmkTJ2YV2?=
 =?us-ascii?Q?icfgG0LbcKXEeLh3TrL/V/9GJB9a/VDLHQm2qfr5e/VjTcREcy+A+rUigMep?=
 =?us-ascii?Q?DXjXIqwt7xiS/69yZxkGY7kjgcEbgkVYLy8tG9Er/SzBdRHY+Zm1lmDpsysy?=
 =?us-ascii?Q?5OuBWUbC/QbkDwAETipvTXaVMOGRL8dudg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eCFn+2GuiCQSOYAlvy1AwQIuM5YXl0qltL80BY+G1p8b3yjo91vDgrCMrPMu?=
 =?us-ascii?Q?Iu233hsWpUQQA/RfCn3lQMTs3pL3QlnH+xydDahQVrGyD9BkdtkUqCk9cpey?=
 =?us-ascii?Q?EJ9OuRlSq3FhYx+z6CeWxe3qyFwTXDP1s6PjyvVSq1NlbjFfsi6LoFZeNxgr?=
 =?us-ascii?Q?NmPE0ZyulS3TyuyRzRG//f/EKZH9LxP7Ed72b2PwpSza53D+4enP545c65Tf?=
 =?us-ascii?Q?VDX665cYgh6XCZ6pUvlBubJz6NTanzC3ngm2i8IK47PyHUcIWFBgPYQopU8k?=
 =?us-ascii?Q?6OC35owZs395DY6ZqNrC3uX2wf4lJP55P/ZTlkB22Eum8IqB/nNADwebru6B?=
 =?us-ascii?Q?qRY5aXLgBzaGNlNxFUSvPSwNyVGAKcJjtvAKxwmWRdlE7ULqUV+o4JAGTWMb?=
 =?us-ascii?Q?oqzc0WqXi9gUgd2tRhPZyOAOZ4Vo722HBmQunDF9lXUN7JSTzR6cElyMeA+0?=
 =?us-ascii?Q?ADcgr0Z+Bg8ghEoGHsufQ0opA8qgwdO1VMCOuJZLQhbAynCxdGMdfl0VXVwa?=
 =?us-ascii?Q?KSLrlP3Sjn3CdDNo9oZ+CRzEunCzVN5sbOhlgzI7v5PnMFj2E97m15AK4JVE?=
 =?us-ascii?Q?V2YwNCQ2dnq6bAttxX6YuNYTG4oTsVE8bs607lWbxdg4DipY2CupogPlZPBe?=
 =?us-ascii?Q?TUcpRbIHeM4JIbZEqH4qg48A1L+sdg11GfZ+H0Vse6W/U2ALzoJEnUWV0+q4?=
 =?us-ascii?Q?PC1rz4LoQQOs/fFFzKEmOAq6eQu13YMq+QwN/1rnAkhQxr6IlW8ZIBh3OJmz?=
 =?us-ascii?Q?z3O5gp03zAGtv9j9cSeBbWO9TvkLggUcrVARLby5WFmW3ofYUUsnvjUXEd6u?=
 =?us-ascii?Q?NTKlOZ+XPaBCh3kOmthVBk946bPNkkXzvP6OunAjcAG/kWo0myDa05tEeGg6?=
 =?us-ascii?Q?gaITT5A4/rxijX5rFAeNE5BCDO94VvRhF7u/ZdRTckPZhVczldBSBbNot5M7?=
 =?us-ascii?Q?oYWDpOoIev6wTovjLLJAfOQJorTbKIIJDypDEFgDHiLWBwXdHIxKGA49v+Cs?=
 =?us-ascii?Q?vPnO5wCrAG1f8deAbfQyN5oJ3sEs4FbM0WYA7KNa3W/QfDpkkS+krf/tKVIk?=
 =?us-ascii?Q?onaeS7P0aHPjZ9XhXL5lqU6nYXxfHh0rGP1JMQzjvqzqBW6lQSU/F1EexxKB?=
 =?us-ascii?Q?DIg6qUKgIM/anuUhfhfpq/Xz1v2YppfjWYetIvHUyYTYzGJ8QOZANCSJwwQ1?=
 =?us-ascii?Q?MSFbWaOLZzo+VTFo6NK3eb4RHqZOfZo9Yh+veQ+CnamwXkGc7Odq10BMGGE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd484f0-d52b-432f-ad6e-08dd873c7c0c
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 16:40:00.7747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6714

Add an option to allow users to specifically enable or disable
retrieving the Message-ID from the Outlook SMTP server. This can be used
for other hosts mimicking the behaviour of Outlook, or for users who set
a custom domain to be a CNAME for the Outlook SMTP server.

While at it, lets also add missing * in description of --no-smtp-auth.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
v2: Replace tab with spaces in "outlookidtweak" => \$outlook_id_tweak,
v3: Rename to --[no-]outlook-id-fix and make it bool. Also add missing
    * in description of --no-smtp-auth.
v4: Improve documentation and the log message. Also, have the final
    "return $outlook_id_fix;" on its own line.

 Documentation/git-send-email.adoc | 13 +++++++++++++
 git-send-email.perl               | 14 ++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 7f223db42d..7ccca16296 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -115,6 +115,19 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
 Only necessary if --compose is also set.  If --compose
 is not set, this will be prompted for.
 
+--[no-]outlook-id-fix::
+	Microsoft Outlook SMTP servers discard the Message-ID sent via email and
+	assign a new random Message-ID, thus breaking threads.
+
+	With `--outlook-id-fix`, 'git send-email' uses a mechanism specific to
+	Outlook servers to learn the Message-ID the server assigned to fix the
+	threading. Use it only when you know that the server reports the
+	rewritten Message-ID the same way as Outlook servers do.
+
+	Without this option specified, the fix is done by default when talking
+	to 'smtp.office365.com' or 'smtp-mail.outlook.com'. Use
+	`--no-outlook-id-fix` to disable even when talking to these two servers.
+
 --subject=<string>::
 	Specify the initial subject of the email thread.
 	Only necessary if --compose is also set.  If --compose
diff --git a/git-send-email.perl b/git-send-email.perl
index 618474916e..4215f8f7e9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -41,6 +41,8 @@ sub usage {
     --subject               <str>  * Email "Subject:"
     --reply-to              <str>  * Email "Reply-To:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
+    --[no-]outlook-id-fix          * The SMTP host is an Outlook server that munges the
+                                     Message-ID. Retrieve it from the server.
     --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
@@ -68,7 +70,7 @@ sub usage {
     --smtp-auth             <str>  * Space-separated list of allowed AUTH mechanisms, or
                                      "none" to disable authentication.
                                      This setting forces to use one of the listed mechanisms.
-    --no-smtp-auth                   Disable SMTP authentication. Shorthand for
+    --no-smtp-auth                 * Disable SMTP authentication. Shorthand for
                                      `--smtp-auth=none`
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
@@ -290,6 +292,7 @@ sub do_edit {
 my $mailmap = 0;
 my $target_xfer_encoding = 'auto';
 my $forbid_sendmail_variables = 1;
+my $outlook_id_fix = 'auto';
 
 my %config_bool_settings = (
     "thread" => \$thread,
@@ -305,6 +308,7 @@ sub do_edit {
     "xmailer" => \$use_xmailer,
     "forbidsendmailvariables" => \$forbid_sendmail_variables,
     "mailmap" => \$mailmap,
+    "outlookidfix" => \$outlook_id_fix,
 );
 
 my %config_settings = (
@@ -551,6 +555,7 @@ sub config_regexp {
 		    "relogin-delay=i" => \$relogin_delay,
 		    "git-completion-helper" => \$git_completion_helper,
 		    "v=s" => \$reroll_count,
+		    "outlook-id-fix!" => \$outlook_id_fix,
 );
 $rc = GetOptions(%options);
 
@@ -1576,7 +1581,12 @@ sub gen_header {
 
 sub is_outlook {
 	my ($host) = @_;
-	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
+	if ($outlook_id_fix eq 'auto') {
+		$outlook_id_fix =
+			($host eq 'smtp.office365.com' ||
+			 $host eq 'smtp-mail.outlook.com') ? 1 : 0;
+	}
+	return $outlook_id_fix;
 }
 
 # Prepares the email, then asks the user what to do.
-- 
2.49.0

