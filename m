Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F21EFF80
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312228; cv=fail; b=bLEzhUCUTOWVSaEUHJS2wNOznqP+XIZXdyLOS0Tj7PtWlTkLx8kdY2mSBntoG2tdWccfTJYwHorWisjcU3zI17adeY4JQUEz3cF2h/0Q4YJlePeti0vqGZKIC9BCWLjdsMSLe3Op38NSyXG0JGYFDa1TwkdAVGP5Dv43lnEaeto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312228; c=relaxed/simple;
	bh=Uhofx1yVK+E42A9CXBhyp55BFvMP9fYRaMplPqYd2NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MTT91FIxYqxCTQxlAyFmaioKTWM4Uo6UJPUSLaRjn88/mg7igqhg07FejQGYHnlZsrJzHDfZ+k8t7lRuFdP0Pk79WXFOK3f/2LiPYu16Oeo3FOOUU8RrNta2zAhr35OBYhKE51+3eQpb3N7NaKk29T/flpmudffOCpQjP+NLDUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=P/Cip22r; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="P/Cip22r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAoR8tknyZMd12/x3UuvFUZehg57KV8ZuOuFCjNbALYRfHxNlG+oSoXgoTIqPQ25SKJo9OhGKIB9R4I7B3Ib1hJCPoW+BJzjoecSM7ADUkJHJ6Kfzead3nIi5jwjhITH2rRylisJZPDBV8Y+f4BO/vDfQNok8rYD8yr3LRQL7UMvVOWaLxBTpLMSwDMKZXi319OezV4NX3TehCDaMgW0qf4mWgU1iga6NDPnw20hyf8WTMcc10OHcuXOSKSIPx2/zWFQydrjOqNIglmHdZlsZVfjlz07BkoYvcO0NEUUKOHzPmXzk4rqDEbBhk2eogvRUc9UwRoD2eAfUlHcP4wEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNonkeecgGJCbjNLETv7W3bv8zrpISlB9cueXuTzaLI=;
 b=O+efoWV4JUYorWEO7jbd8HKIZVODhMveJIlQlarNyYeKv0zPY6iQshpIwnU06vIE1Jn76zYg1c2QlPLrTpub/edM1te1cJvTM1qUirYfbdUXt+JderRQjKIFnAotCgfFjkAuAcfu1NE6jbtwb/+YsQb0HYQGxH15uRUrCj8Zu+LVOoIhOQOKJ2Ug3ZH8VkesT9Ck006+D1vSLjWB5hhXPlpUfOe+saUUEeMIis6Riao7WXi9GQzcLwzYSvUwsURQEtve06XaS02we6c5GGIEJCYl8lVelQiD01KfKxYr8wdO0IIzJzkUl49Im9gqhI/IZR+A6hbuIzdLsRwVSpxbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNonkeecgGJCbjNLETv7W3bv8zrpISlB9cueXuTzaLI=;
 b=P/Cip22rlbzvgO8KoCqyOTR/tMG8nq687u7/kWGucAUHrNvj1tTCmOMUUv2kXw97bqUb5v3r9fcaMURTnXH8L9TwWM/tLrMVtugJSVltlWGoWJbUCxrFOqdAaRYUUd8tgng8w6KvylWXaZTz2sVNSMPwR2/k6E1FN1rhlJtgBn/N+QTjEO2KzOkLMDWuuiGmUIaNyIxucjNojYSYIpE5p6Jj+DJ34Aw30kgg6Gxf8yeemgWQjbynGGx4s6mMZFymK/yStcbrEdRMlJLOS/V6rYtzUk9EXk7ku6JjwhMew8o5xoaBggN/uWPVqpZa7eQQ7uer26jgUbxwYzQhEn6nKA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8754.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 08:57:00 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 08:57:00 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v2 1/2] send-email: implement SMTP bearer authentication
Date: Tue, 22 Apr 2025 08:54:24 +0000
Message-ID:
 <PN3PR01MB959785FBC3CB925FCDF081B4B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB959739CFCF4D1EFC14259F8BB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB959739CFCF4D1EFC14259F8BB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b7::10) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250422085616.9679-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3334f6-6140-4a67-522f-08dd817ba430
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|5072599009|15080799006|7092599003|10035399004|440099028|3412199025|4302099013|19111999003|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ErB9IjVhjXyDeblD7HSpmqrCuDEnRmsi5/QJpK9TKij6hfrugwoHYaxyfOaq?=
 =?us-ascii?Q?TN9pRcFMEWH0Txxduff8PBKApOHbybOB1DlzyBSuHjGwcfKyHa/FluL56JWw?=
 =?us-ascii?Q?pK/Dp31kTqrVUnUZ5UZuOPHuftyg5cig7rKpd6eeIQFZ9n8eGfSgGUUKxAu1?=
 =?us-ascii?Q?aqq6wgvVl/s2q4p/Dx9KssPU6C5zDgoq+hSUTKNDvR4Y98knUcIF7AjTiFaz?=
 =?us-ascii?Q?fgkDMh6H4SQQjxHxOc2ahuyU0YSc4IU8KE8d5leey+7UK8KD/ca1mOYkMfj8?=
 =?us-ascii?Q?AVVOd+iVb2CZMsUppyGlhGBcd5Ug9IG2uzzzFRMeqoSHesDgCYG1EwEs+JwY?=
 =?us-ascii?Q?3rNQ9cnZ8+fmmYfevejquGXk5zOmNaay1stq4zkNfD9sxOaLjhNTQGv64bGj?=
 =?us-ascii?Q?nvhW7uXr6LFrtrTbmOT5X0qmZZ7ZKik4LJjuHneCcORugDSYGl0PXuXYENpA?=
 =?us-ascii?Q?EhgY8GWjMBBG4bQqy33Qe0BhAK3bZ+6rFphQrRQtbC/jYOvpvZoxE5W5EBGI?=
 =?us-ascii?Q?67A6F/DKL1xBPj9M1yFVoXiJVh1I8EEWNupGm7s0MQ6u3hak08ZtX38EWQx/?=
 =?us-ascii?Q?Yz/ZS0hlnJ4+Gb8EEUsS5tI9pY/aL9dccKPg8DJjcwZKNJcNTn6QKnjb5HeW?=
 =?us-ascii?Q?79dECx0ZWnMmeffVaQ9lqglH4CJDOj9vqW9pPvjuLAUoG4++JJwqRi2aezPh?=
 =?us-ascii?Q?rrVT7miUdBg5IH2WTRJNVUnbz6wR+KAdUpuPuk6I/k+sWBaps5Ro+yMA89u5?=
 =?us-ascii?Q?8Tiy0gPJjxyruxktVJ3SkaTftO9T6GGSuHShpEp44jeI1Av8Eob7rojXyhL3?=
 =?us-ascii?Q?wKtvTC4Qw8zKnlLsQTWKEOKvLTasIBAdz4Uzo49vf4m4m0c15YesYXESJRrw?=
 =?us-ascii?Q?Jabcd5Ygi/81MXB3SuH8S8AGEiPAKlawN4tRXEAxmgdyW0mpRPgzwYfd9/S3?=
 =?us-ascii?Q?0hHCF5+HqzoS7oCaoOjvpLBuWogyKJVG5asGqFdNEbhRM7JULZvW3BrezSx9?=
 =?us-ascii?Q?EhIKYXWEC6LvGYBibsUST9DfUx5t9eO/tBzPfPf78yOe8i9Pl8T/BTIIKtAV?=
 =?us-ascii?Q?sAMCkS676WqVvkAzh9NZ+NPXUztPB8FNaqykYYufgH2lvZBWfeHkchlzOXg4?=
 =?us-ascii?Q?r0uSAA1zQuaw/qRIWnyg2o7LcdZ/ArYcGea+SIE6cAI/kxyqPJd2+YvfMPPL?=
 =?us-ascii?Q?wmyl5T8BZIR/ha0NXumPXIPrV9ZFGP4hIMlcGl/av/eeMbFLgBQPcCqvHvE2?=
 =?us-ascii?Q?fG8uE3GGjZZqVZRNIYDiOQyXIqxx0WzGMTOx6iwxwJrIXGkioOARSq/LTh4b?=
 =?us-ascii?Q?E4o=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xbzUPhl2KmjXr/BFpyWm2Fzac4sRYZmB4TFch1xKRDy02keS3x9Ybdv6ucbE?=
 =?us-ascii?Q?ZKEsJSSPXPumcqrnoe8Q4zMCLMqyqR8ruhZ/6OPZ9Eawo+dqc43VDtOjUBzd?=
 =?us-ascii?Q?Ugfb7YBYTVea/VbzD+fV01uhf0/GPMZMJJhiPhsj9Z+kjTHJyHu12P189Oyp?=
 =?us-ascii?Q?Jy8hiFz5IXJ/cWqzQMsL+DEiVgcCpAtd22vEJjHt05HCg2U8wzn57qyoNO5K?=
 =?us-ascii?Q?xxkCvmX9/ZXPDbWV7BlD9Gtq20bgIGTTAOP7NhNuYGpcN0kc4zmulHPhInHZ?=
 =?us-ascii?Q?jGRgS4M0+oLq7S0DoWeUZAmFtXYnPf3M8eKxdOE/XqS73dFvsEEKVDymM+Gh?=
 =?us-ascii?Q?PrxB1dQ4qC3gRoGrtDOx7xn3aOJmhCYEkT7i6Cqn1hlkSZ0ltsnDr6rrSQjL?=
 =?us-ascii?Q?WGuOo4yq3mPE0YUgtZE4ikinZmYFyb/J12FRpoHXt0Xq8+RjMWZaj1TE9c5V?=
 =?us-ascii?Q?OUVFTShAGSw4Lezoj0s19sLWYYcVxc/SVOWDsZVA2jq2vgkLZlTkSub/wnkl?=
 =?us-ascii?Q?5qVySZheoqoU4vfET2ggiZmA25xjFY7fLcDixiNwpWirC24E+s4h+FHyAqVv?=
 =?us-ascii?Q?YfUuNMsOw+gm5aGcdp/AhubBMcfB4nDfCxFZQtznSyhoH81amzCW2UYGNQ1K?=
 =?us-ascii?Q?eZlwn20qWkIM2rn9alvTXqiGeTyXIeL7eKGzl20TYz53XRd7dTyreanrXRAT?=
 =?us-ascii?Q?oRHfUpHuhXDTAEjH/Iz01VszqoVqdSXwHU25+I3NbIV93voI0Qe7L4elpLSw?=
 =?us-ascii?Q?hWgRIxWvZauQjrlbLTe2nrm+i7zGOXsKyqFbz1NovcM6C3bcvr53UGDLiJzP?=
 =?us-ascii?Q?1exq1Wlko8pxXMcJPG486E03v9AOF9jAQWJTak/inTolh6bWL66oDN7HdFeS?=
 =?us-ascii?Q?FhiGKM44wnKdF0UKNmbYbR475seYHs+tcYeeDIijbRmOKySo3EcKxx5m0e4y?=
 =?us-ascii?Q?k9Tz6w0Bx6f9plasQO2yFHndtFhhaGHJOQkMdAw2DZqV/L1goBwjf8yYXoBt?=
 =?us-ascii?Q?VXuLGLh8+lPyA7TzpAF0OUKwfqxdsqsV7Lfyf3OgOeLAcjgsYtjn5jiEz1yv?=
 =?us-ascii?Q?6KejEGpwiYZ406fJGqvZJ/jT41TUrJU8VWqyWkxzfFAHOzLJwfbDJQc3HAhI?=
 =?us-ascii?Q?bXh/hMFsEI4HL09/cW58Wt+aEf4gBBqvh2ppb5JPKWXJibMPWV652bb4vmdw?=
 =?us-ascii?Q?97E5ccBX2qHg+Or2gJ5rQXAR9beiQ/VOwFS6XafxzIgDKRUSaiW1rN6psAQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3334f6-6140-4a67-522f-08dd817ba430
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 08:56:59.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8754

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

