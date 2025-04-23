Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011037.outbound.protection.outlook.com [52.103.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA620B1F4
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745411364; cv=fail; b=pHyvSkzQHSPfTC5qLx0hRoyv5wBmkcakfeZj20AN/shl0OBdqSUnLbl4cSI2a1vD+dAb5fAoasstor3O6fgtVCNviH1Q10VPkqz5FyFEnj6CgJ5U71f9CzHPjUpN6SkDFI/m7a7gpFlFepwVQV0GZWc3plyb1cBmVPdIvYjsdU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745411364; c=relaxed/simple;
	bh=Uhofx1yVK+E42A9CXBhyp55BFvMP9fYRaMplPqYd2NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VzOG7M77KTeOwL3L9Gi4zhtGiEweJ773m7aj3VzI2pq37XevJAr9NRoe8KmZaTT/TiVNWXTh2z/jdzbHXh1TcPnuAXZBT1/y7AzaaykDQFWNT+CGhMzZfb+4S5Yhd3YGiVuxUMfzMpIFkt8b5fQwpXs0SrM+NdBazrUY9X//9IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Ni/d7vQt; arc=fail smtp.client-ip=52.103.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Ni/d7vQt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqjptFWwHp4grW+G6hkfYC8grtcQmtLduq6bYGAZ5pT1SD6sFQrM/6phTaZMj6RvuwCjhHc9g7mmnTFUJ7EFvqHnD4cXDDNkoFcLVqxh+H/odTL4Iw6QOALFBnIeSahzJ/DI2SNF2JzgaSy2pb/O7g95kHgLU0o2GSom6HzRK6NPHvp+8pbllf6pweszAVILEkrSPzpCQyvXzMJEBiFuJlrQKifPdMpTSTKs7LYmNhZutHKm44COmjIW9z2t+PnJQaaiT1tHLC/NgeZai636Oqy5KESkjB9gvGitAsVtFEsHcQQ90a+L+gQuXety8Bkm0cdza/Mbal3DHx6DloOn6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNonkeecgGJCbjNLETv7W3bv8zrpISlB9cueXuTzaLI=;
 b=ZgQZz7+bCZyvLkrmzXlehzgTdr0nen/nmaNIn4rYO3qmeVR3gRp4uAdBXFR9M+SxXEEVR909CWBh/fgSVWv5nUPdZ1i5FJQ+PzCWnRKBcnmkJwuNvhEXbqC+xDLiRt1M3OBO/AwPPc0EyLAMA64JaRZg0Ry9nVH2zB7l2RpDVSzVJEYFUyljQdmiB2MvjvvD3DgSq2zok+UylgBBPfTVRQU4+PktJDVBIpBws+Zg/3oenWVO4rcsde75pA/AFO55hOl8n786NsKCDPKusKp4374ix1fSmrhDLOzYvztl35/Zf0h4f07w4CR+KRNLsKpAEwmDvcmIy7uoJQulgcjH7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNonkeecgGJCbjNLETv7W3bv8zrpISlB9cueXuTzaLI=;
 b=Ni/d7vQteEQSjtx3Ght/ZNhzpaECC/bxZYQkcxzkXvg863kKhooHv82t4+Veh2TWoZs+RoH3mOL/aNl7FbaTBRfHTJl4/9ZGlI4UZmBKnsciI/QFQYRr5yIsPeuMJjx79jNo8WzEHVfaMF2lHPdTycG7V7b9veNwmeX9gd+k1M2oLgpkNVFNtRj4Pm6Q3aqTZW0nW7zix/I78LWqEam/R/tZUn7qE4Ai+13HRpCyg/LTQub714S4JepvqOSX/AmrCt4EvBwrHvEXnQsDrC0T0ttc4X/f5NLxEUhG4fPUqWI1cg8HHzYAT4IorMTtB+DM9K9hLOqz5wx3umaalinkew==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 12:29:13 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 12:29:12 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v4 1/3] send-email: implement SMTP bearer authentication
Date: Wed, 23 Apr 2025 12:19:45 +0000
Message-ID:
 <PN3PR01MB9597776CB37BE7B05A7ADD80B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::18) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250423122903.43547-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: a283ec8e-7f68-461b-19ce-08dd82627380
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|5072599009|15080799006|7092599003|10035399004|3412199025|440099028|4302099013|41001999003|19111999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O9AjqFDfHDhbEQqLfJiYKLV4RvduW6Q1pVST+x+oakV6vNlR8uQqdWHO4B37?=
 =?us-ascii?Q?FPXyRDEY8r5nnZCFbpfMgTt1ym4YI51F0V1GCppkFEJbOf58P8+d639/o+H6?=
 =?us-ascii?Q?vrfP2en37zbjEdqUhFv6pqQix9Qd+8/7mqy+oQN42j/rl/EzqVWg1GgZral6?=
 =?us-ascii?Q?Yjrp83qLi/RKYSBJcIyU4J025jN3Vy6Fx9Ue/D6A7AgBWq0+zamfV2PzN+y+?=
 =?us-ascii?Q?Wty+u+kiCJqmsPwDVEiKGcFUJypcEs+r6qjQhZjq+E938XMVpPDl6E4s7SYm?=
 =?us-ascii?Q?AipDOpASFu5Gxf0+UT3sdRbcJS4lfS47VgqY+AKr2hRF29s+5DkHro0vg7Yd?=
 =?us-ascii?Q?oysEZXW04DHBxoEEIR0iArQ1/elxHpe0RujGimo/IZ+uQPzCawRCm9BF7NzX?=
 =?us-ascii?Q?mDSFgvwwwIQP/je+z0SN47yhICbVMpja7nlxX3b1QB33wfNyYK6c+GVgImxY?=
 =?us-ascii?Q?cuH+/cz2223rl4OPiayykmVSpt94sX4yT6B90BmPqlrShEMjSI6edVcqmTyo?=
 =?us-ascii?Q?YYx5Adk2n7OxAS85JEcK/lsjcpIq9fOEPgFy3M5R7Y71dY6T+SdNU8DG0K1b?=
 =?us-ascii?Q?AG8kWF+K9YiXabVddz2MHqmlEudIP+kfZUMDQOC/FMOsfUTSSs0XAo9a0/vu?=
 =?us-ascii?Q?ARtNzahU+z6Ttv810KfE+hfX798SoyLoeJvBxfu3zn7XJGZ55DE85y8Px9iY?=
 =?us-ascii?Q?CpVgUptmGigB7JQczTLm4UTCnpz7Mr3PKXsNAt4QiGp6dXmzfJQ4ulMnrp+W?=
 =?us-ascii?Q?PAj9/AajVHzQdYxQ46GuzfgXzWz48/SlTPei3PLIFmoDWAZNdlcQkVkmwIAf?=
 =?us-ascii?Q?eyeJA6VWFKUXH//w82BW8yxss6Fr3vcuGF0Vb05XU6UYVeQmvvkZMW0gsXmU?=
 =?us-ascii?Q?FJajiDiq03Nzxf9Fv/VXmwXOg5vmoq2jR2v5mQpML9DmBtqgXVAZMYXARTMP?=
 =?us-ascii?Q?S+/Pse68oyR9RQ/EevMPQ5nJxFmIhz16cFgLZpZIifly6o0z76HSZ68Fxo0z?=
 =?us-ascii?Q?HWYylMV4bHgCkGTGgwPoqIQXVIMeAxmUMn1692EymHuUv2nNHq5o6QFhJH7Y?=
 =?us-ascii?Q?TXL0Hb6KiMH7qNk7Ma66/ffSVno7Dtk9f1ccmMso2i3KDVzglvNbUjhmRmvq?=
 =?us-ascii?Q?spceo2UsIOqwYD5jzpuzN75lMCHrtwH9TRBfIR8gX/2gIsQzGL/0kUsb14js?=
 =?us-ascii?Q?d1qY14JdyHQO3kioJPnwjNAZTvdJzePWZWbLOtYCpypUHWgTFRQQLfYDpY3X?=
 =?us-ascii?Q?yekXBV4Aul6A0DaL90Eap/qeFqlgrDIt/6IDrRfK0sqaHvW6egZZLdC+5Rn0?=
 =?us-ascii?Q?CRs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sN8H9cnxABOXRN7kwVzYaXpVaeNh0mFnp8mhmwkTv8aWr4cCz6f+Z4SN1Jm/?=
 =?us-ascii?Q?ujuP5+a/tKZOjovt1R/0OIsQKljEStwzgjAF2BJ5BFlmRn89xBcEgtOWAM6G?=
 =?us-ascii?Q?0oG6OpTSR9L3XHvjEEjpdTmVgfBWYrgpZkf/R0u8NqpBxVb7EPau4j+Weyob?=
 =?us-ascii?Q?pqqBAdXfYqVzYtfAO65+TMMwXuIWWLlI79NXt0mrnC+uRooQaMXbbIyJnHnz?=
 =?us-ascii?Q?3K1Xt1CQJBQO9COpYgWTiNjguIte3+xHb26avVtSHAbtfVKRXePQeg448xX/?=
 =?us-ascii?Q?2W2Y9b7tl1JRj/4xcD5wlLc+6RAuz+Z6ybHfFmbTQSahzxxSmP6cac2tisyU?=
 =?us-ascii?Q?/vURRQ8Bs51c07nqwMVjYWNGHsSSnY5VqDW/IKOpfwDaHO4WfN0/pv1TGBmm?=
 =?us-ascii?Q?kBrz6McpBCNNYtuRFwO5A4cUBZzTf8nX5iiBY4kiGvqbKdiNNoZ0dlI5Gi1t?=
 =?us-ascii?Q?xauDxsBgclsq0XpyxnXQqc4V6PV82dD/dPytGfY9OAlju1iR7ze2lgehxSLV?=
 =?us-ascii?Q?wCJS7uutBbSvFFUnYiFs5y6gf7xGDMkF7HgRPTa661+yO7/Ape9FDKFcupVV?=
 =?us-ascii?Q?BfnaeJYXXJuisEVgZSD3y7XlE+Dae2RgFncyJpAVRoDWEN1/M/nzTHv7faHM?=
 =?us-ascii?Q?/s48hLbdEMXht67QbFJWT92xgolXXIMnDhTHFPJivjfopLvwvY31z+8Gt3vD?=
 =?us-ascii?Q?NcAZKgp83A+QEIB4qH4fyROnfCgBKd9hMtQFxlsvDbqxaG4KxpYWEHdZwCLu?=
 =?us-ascii?Q?+7bLxVpt38QzrwW5O196GyEMoFNmf3Me0QwP413GGfJXnMIUwLYGMiyl7RH7?=
 =?us-ascii?Q?Pjm1xSee0T608GDoz5/B/ugC60XbblD9dJjH7OkmyLZWGtaH0xo3EkdTkKpC?=
 =?us-ascii?Q?e516Dl5l4fEU/LBBdQPlnSs9a97KFrgrxlXUNxJbo6Gu/w4ABPm0a+lp6Ecs?=
 =?us-ascii?Q?BIOXny6sTvaA2CK/u3ehbOWwdcrHD19dHhl5EISxK+Tt/fC35pqzN4X9nfqW?=
 =?us-ascii?Q?MTTJIFediK2r1nhafyjaqbmaXuYpLSRpyhW4kSbZFSn5jimbDLlc+jp2Q5xL?=
 =?us-ascii?Q?zX6YYiTggSMrsk8k+FhcUWQ8VKJj0BrVRFbG60cS3shPA71nWs3SiJQiHG9s?=
 =?us-ascii?Q?Gb4WF9vRbN4n7hbCI5LAAyEvV7wWVj8CBvIADcmMgT/sBDIoUqhFEoiPV3IQ?=
 =?us-ascii?Q?lvZ0+OCmw+EIVi2ayA6ab0O2pkwCdixUT57O3BfL+9bogfNNfbYGmrkWDEY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a283ec8e-7f68-461b-19ce-08dd82627380
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 12:29:11.4798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7143

From: Julian Swagemakers <julian@swagemakers.org>

Manually send SMTP AUTH command for auth type OAUTHBEARER and XOAUTH2.
This is necessary since they are currently not supported by the Perls
Authen::SASL module.

The bearer token needs to be passed in as the password. This can be done
with git-credential-oauth[0] after minor modifications[1]. Which will
allow using git send-email with Gmail and oauth2 authentication:

    [credential]
        helper = cache --timeout 7200    # two hours
        helper = oauth
    [sendemail]
        smtpEncryption = tls
        smtpServer = smtp.gmail.com
        smtpUser = example@gmail.com
        smtpServerPort = 587
        smtpauth = OAUTHBEARER

As well as Office 365 accounts:

    [credential]
        helper = cache --timeout 7200   # two hours
        helper = oauth
    [sendemail]
        smtpEncryption = tls
        smtpServer = smtp.office365.com
        smtpUser = example@example.com
        smtpServerPort = 587
        smtpauth = XOAUTH2

[0] https://github.com/hickford/git-credential-oauth
[1] https://github.com/hickford/git-credential-oauth/issues/48

Tested-by: M Hickford <mirth.hickford@gmail.com>
Signed-off-by: Julian Swagemakers <julian@swagemakers.org>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc |  5 ++-
 git-send-email.perl               | 64 ++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 7f223db42d..1bf75c060d 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -213,7 +213,10 @@ SMTP server and if it is supported by the utilized SASL library, the mechanism
 is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-auth`
 is specified, all mechanisms supported by the SASL library can be used. The
 special value 'none' maybe specified to completely disable authentication
-independently of `--smtp-user`
+independently of `--smtp-user`. Specifying `OAUTHBEARER` or `XOAUTH2` will
+bypass SASL negotiation and force bearer authentication. In this case the
+bearer token must be provided with `--smtp-pass` or using a credential helper
+and `--smtp-encryption=tls` must be set.
 
 --smtp-pass[=<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
diff --git a/git-send-email.perl b/git-send-email.perl
index 1f613fa979..a6cafda29c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1398,6 +1398,63 @@ sub smtp_host_string {
 	}
 }
 
+sub generate_oauthbearer_string {
+	# This will generate the oauthbearer string used for authentication.
+	#
+	# "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
+	#
+	# The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
+	# * gs2-cb-flag `n` -> client does not support CB
+	# * gs2-authzid `a=" {User} "`
+	#
+	# The second part are key value pairs containing host, port and auth as
+	# described in RFC7628.
+	#
+	# https://datatracker.ietf.org/doc/html/rfc5801
+	# https://datatracker.ietf.org/doc/html/rfc7628
+	my $username = shift;
+	my $token = shift;
+	return "n,a=$username,\001port=$smtp_server_port\001auth=Bearer $token\001\001";
+}
+
+sub generate_xoauth2_string {
+	# "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
+	# https://developers.google.com/gmail/imap/xoauth2-protocol#initial_client_response
+	my $username = shift;
+	my $token = shift;
+	return "user=$username\001auth=Bearer $token\001\001";
+}
+
+sub smtp_bearer_auth {
+	my $username = shift;
+	my $token = shift;
+	my $auth_string;
+	if ($smtp_encryption ne "tls") {
+		# As described in RFC7628 TLS is required and will be enforced
+		# at this point.
+		#
+		# https://datatracker.ietf.org/doc/html/rfc7628#section-3
+		die sprintf(__("For %s TLS is required."), $smtp_auth);
+	}
+	if ($smtp_auth eq "OAUTHBEARER") {
+		$auth_string = generate_oauthbearer_string($username, $token);
+	} elsif ($smtp_auth eq "XOAUTH2") {
+		$auth_string = generate_xoauth2_string($username, $token);
+	}
+	my $encoded_auth_string = MIME::Base64::encode($auth_string, "");
+	$smtp->command("AUTH $smtp_auth $encoded_auth_string\r\n");
+	use Net::Cmd qw(CMD_OK);
+	if ($smtp->response() == CMD_OK){
+		return 1;
+	} else {
+		# Send dummy request on authentication failure according to rfc7628.
+		# https://datatracker.ietf.org/doc/html/rfc7628#section-3.2.3
+		$smtp->command(MIME::Base64::encode("\001"));
+		$smtp->response();
+		return 0;
+	}
+}
+
 # Returns 1 if authentication succeeded or was not necessary
 # (smtp_user was not specified), and 0 otherwise.
 
@@ -1436,7 +1493,12 @@ sub smtp_auth_maybe {
 
 		# catch all SMTP auth error in a unified eval block
 		eval {
-			if ($smtp_auth) {
+			if (defined $smtp_auth && ($smtp_auth eq "OAUTHBEARER" || $smtp_auth eq "XOAUTH2")) {
+				# Since Authen:SASL does not support XOAUTH2 nor OAUTHBEARER we will
+				# manually authenticate for these types. The password field should
+				# contain the auth token at this point.
+				$result = smtp_bearer_auth($cred->{'username'}, $cred->{'password'});
+			} elsif ($smtp_auth) {
 				my $sasl = Authen::SASL->new(
 					mechanism => $smtp_auth,
 					callback => {
-- 
2.49.0

