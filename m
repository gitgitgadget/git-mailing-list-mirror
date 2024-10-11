Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011037.outbound.protection.outlook.com [52.103.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E153D7F9
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728668906; cv=fail; b=uxxntsBWmcNM9nhVV3mtxZezYXM6ugBxRKibWuf1J1y6oXHKv0aUsFE9jjA5SpSBgh1tjmL3SJxLq4lkXHfASeVN6SXlsUinLzSWU7cM0b6qdZG/weSqp0qDNXJCdFKmZQGbImykUesxCTDKh3yRNOHj3gqL+ugWzB/UJWwwxsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728668906; c=relaxed/simple;
	bh=dSo1SUo8t5/Q1t/zF50+Al3orkESxqHNzYq6eLlCADo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NwwT0+ie2AZQdRR72LhdtzRRHLRpiXYvkR21Evf4BeqOivB7B5R4+uWDhU2I/7QRW2hvteus63pSVwokT2vl618K6eZKhXHM2rnE86QZy+aNBfl2N7AAhyFmFP06XBdA6+2XpWc1WbDutWoj9yinKccSfpgn1oU70d0OPIOMYoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aYVyJQdK; arc=fail smtp.client-ip=52.103.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aYVyJQdK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kr7Nya1uUeuPASmHJmWPOkh0Tz4XQUUqpms+UhM0bCgA5ekYt8hpmceTvfPOe4H1TFrcD/E7AykgUqnm6VW8uC0W5MXxbaXd5+dIcvJTFj8+FIoEVAc/z6dyK+VgrQOT7XT64G2B1wxgbCUUbOe3tSi1bopbFyOiltr3iw8YQ+QyRSJUQrfCBsa8rGdVFt1Q4bHg3l64RrVi4QTe2sWLzoYeNtkTMc1Q26ChNNegHVPazI05e9xjUsP/suWzdm9A+mXxAr29OQdrW+Nc0qWU6JZmZKaJ3jDUOf9gV/hRl9KatjytZ8+dHj167uq4aOkMCknCiWVIHa8uUUI9PX+YoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU7tMwgbx+Upjq+OIAcysYrCiHbQCXtial4uUjNiG1o=;
 b=wYRlo/q98WP3aDVaugYdhf/YibG4f9BZknDwv0sQFZAVdfnLK8iuzEQJR6t74b+/fTRBILXpKb46Ma7uws+myZ9YcUTZOYT6yjGdECkE2giULeI/2i9iQXg1cLu6G+6enT+YLl/wybOh3c0xUvfYA6b2JQUOl0VLCARmker/RmG+2142LUYqmqQwZrCAZodP0H3lEL8br06GUyTAiwGQhLsjc/M0KEW9xgDF6TzG+Em7PnpWB8UG/CITxbXiYx1S+i2pc80J5nArMHSwweAVnUeT+LOQgW9JzG67S8PJ/mlsa70lE34qH7/9+1KEokh0FrwHnOs7UiCXEySNU2cqWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU7tMwgbx+Upjq+OIAcysYrCiHbQCXtial4uUjNiG1o=;
 b=aYVyJQdKgvG0Vi+1TH/mrs/JO7If9u+OOXka4IlbKdff9QOO0Z+pDxiZfYMj3LdU4CedEW3eh+9GE/3aC2nmDX14ex7R/s6H/ruFiq/KUhp2jPHSLjfR7VlhddTVMRYkk6xTCQ9qSVxKbctvEITUWkR8w7xhlcx4FKnC79tWCirzAqg9rnXsibAB3R0w0YWFET/sV3Olc4ygHKPj/xubaoDLHrT4yfjN6WCRhUDfJEm3xPTiY7roIcaiVePZ9jPXbc4qW1oE8GNAp6uVRfhG7F/yUqLp7zX2serLz7CKDiRzq19WprwCRYAcyXAQEUOnENg5rschHrXKjrkE2OvAHg==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by OSZPR01MB7149.jpnprd01.prod.outlook.com (2603:1096:604:137::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Fri, 11 Oct
 2024 17:48:21 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%6]) with mapi id 15.20.8048.013; Fri, 11 Oct 2024
 17:48:21 +0000
Message-ID:
 <TYCPR01MB843751F88AF98DFDB606B0BE98792@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Date: Sat, 12 Oct 2024 01:48:18 +0800
User-Agent: Mozilla Thunderbird
Cc: wiagn233@outlook.com
Subject: Re: [PATCH] send-email: implement SMTP bearer authentication
To: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org
References: <20240225103413.9845-1-julian@swagemakers.org>
Content-Language: en-US
From: Shengyu Qu <wiagn233@outlook.com>
Autocrypt: addr=wiagn233@outlook.com; keydata=
 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
In-Reply-To: <20240225103413.9845-1-julian@swagemakers.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0123.apcprd02.prod.outlook.com
 (2603:1096:4:188::22) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID:
 <29b3d890-9bcf-4fdd-b3fc-f524cc5453f2@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|OSZPR01MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7f4048-7658-4432-6393-08dcea1ce5cd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799003|461199028|8060799006|5072599009|15080799006|7092599003|3412199025|4302099013|440099028|10035399004|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	4PqNksPwyb1dj6yko497kNyon5h8xl5GE4L4MThD0wYLK4oIGH7SEXjv4pW1u0LZdbUR92ftmCe5B0REGCNJNavAI3J4G+4HEKrDw3HsBAAvbCaXTW4TlohXE2Vk/d8GLhqP3xUf8bTgsMCCHTBW3C57/rFzZ6ZpQvjGrkUu5RNuP5FBNSaK3bINUhZNO2UiC4E7yy/+pSvDyx74hi8oB8e5Fe3dWJbQhTY/Bd+NFloPcShfKYdgtTe+JJ8FRHfBXBNU2pBq+pLDyN67zrrcVL58S3md4tKjH9odEBAtMZ17wn4RlVqGJnsyv1OxmZ6uokOCj85YI6/anARx7/IEx+eEpftrBoXeGHZj9Kdio5lPRqSz4p8/nvFKmZPOV1OJGOWZk5e7AaBxziKdZ8Iwi+7mwydIbwc9y12RDGAX9u2e0f5gIvGLPhSlGD2XWoo4ltlYKYPJm17cLrdQvKk/J1QH2pgifWA6y6NVRn4Wlm9BT7jzsMAZpjdeihpaBi2sKn+0JTpqjXova/wksaW9EK5USI05e8ZW4b+c9+Zwi34xetFKoX4uvMU/cjKZWtVV8GxU/3b7KL56k/J7N0fNZ+Hz6ejOHAEYZVdMV8dvmlhhnCwfby3MSkc5IMlkHzxXUZI5X9ZA9BUVPWphImWeJg1H6SKORob9W4oGrtPRqaes3gJanyVGpsXId58b08m6Cge2eHhzECWc3aU16HS/IVwx7Up68S4WEmSLwzbiEhw++38g/1hZBiqa8fjhlQkH5LAlHCdSqNtPV5j2N8SE0i9wNE/IClGueThqCZm6wYhNA3KBcaIdYXV1GNXotSWaYqSoPTVoLaCEUy69mCsgot8/1nXdGm5yjFRHBVzXDiQL58JXjLn3CVVjyne+seSSweomsAQMaMrq7RCGbhq9pJ88E2XBprEtOOAfdzio0tCm1nzr/TUaK4qZChh7A/Q5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHJiejA5VHZmZVErdTRSa2lqQVdDSG13eDh3WTRIZ1QvM2dodjVJYUZKL3hz?=
 =?utf-8?B?Qmk2TWlVQUttQktiYXhVS0JTcFd6YmhnU3hZdEJrQmlxTEdocUE2VHVub2hn?=
 =?utf-8?B?NGtmSnNKK1Y4Zm9TRVpBZE9uM2VUQzBSaG01SlYwMVJvSVBaMkt1d1NMWDEx?=
 =?utf-8?B?Z1U4SU5FbjJhOWkxSzQ2ZDRyQzJZM3ZIb3JJaDd6UTY1V243MmhKTWg1OW9q?=
 =?utf-8?B?ZGtyTzF2VHBMMzJqSEhZQ3IxSURSUGVSN1ZBSXMzTGFXU2R2RGNTSTNmcnR0?=
 =?utf-8?B?Q2tEOGVpblhWcHlGRkVNWFgxUExsandEVkRtS3FsMDdnckZpNUVobmdmbTUr?=
 =?utf-8?B?LzUrdytMM2lKaGJQUzU3UTMxcGVZVWwxSTlLSW1Xclc5T1NVQS9Lem9IWHdB?=
 =?utf-8?B?SDgwN2FUbnkwYXpnQXVHQmlLbmZCWnJiNk9ubDNxamt4WFFhaTMzL1RDYjBM?=
 =?utf-8?B?OGsvMlpaQ3VIMTQ3Z2JvL3pHcGVWV0pjNktnQTkrdUJIVkhPYmhSeW11TExK?=
 =?utf-8?B?NDBJam5jRjFaVWVsT3JFT1hEbW45bFErM2k1RmRhSjZ2elRnaXRyNGw3R20v?=
 =?utf-8?B?N0ZwNVZIN0szR0hXNFRHaER1NE9MN0d2RldaRFA0WWtDMFAySGJkcGpQdHN3?=
 =?utf-8?B?SlFncUhvcm9jNXRYelVNTWE5S3VQdkMvY3dHdDhLQURRK29obXlZWU9Ya3ow?=
 =?utf-8?B?VUpTYTBKS09jQUh5cys4Z3MySDNKZEVLM05XZlQ2NmNVVzhva1BGRW5yZE1L?=
 =?utf-8?B?VjR1U0xITzZzMXhmcXJQR2tnaU5Fbjd6SUtzWFpXTFh6SDdSK2x2TnRIRC9m?=
 =?utf-8?B?Qlp4ZE5vWjlOMVhDZmVzdFdBOGIwVjFmNnVQb0hsTTVzVnljeVhjRUhURnBk?=
 =?utf-8?B?SlhiUW0wcUM4VEZ4YWd3SXlROFI4Mm15TW1keHZNZXNuM29IQzgyQUdseGZS?=
 =?utf-8?B?R0JiZUhPOS9sV2d2QTJqY0liN2FTMGFJR2t3a29VdjIwZFdxWWRVRHI5UjVy?=
 =?utf-8?B?MXRhYVRjR3pmcEQ4cmZnUjdOU1NxU1JpajRjT210dGFPeDhWZERXVEYycThj?=
 =?utf-8?B?eDdUbGcrek9OeldDK3MwREMvNmlFTDJFM2crUnhEMi96ellrN0NjNlNtUFBV?=
 =?utf-8?B?U3lPdzhKVjFzaGxrSHVlZldUaGl1RmZGVE85RXRMcnUzUkQ2YU5EZU5Jd1c4?=
 =?utf-8?B?azVVTTl5T3dURTg0MjRkZkhnWWpZdnNWOFUxSmF1dllUbEpNNkhUcjlDeVl5?=
 =?utf-8?B?WlR1c2pBSjZFNk91OXpadUo5UzZzS0V2YWtHWDBvdDZTdHA1cHVFWTZnV0x2?=
 =?utf-8?B?T3JtMitHQkRUemI5TFBGUmYxRGtHTW5UZXB4VkYvYVQ4VGZ0N2ZiejFTTGhU?=
 =?utf-8?B?ZW95K01NMHAyZnZwZEhuSGQ2Z1FEcmw0QzluNjJXUHF0VGwrK1grczkrY2Rz?=
 =?utf-8?B?RjlyTmhqUS9ONnRHUTk4S1BhN2RmRnVHQlJkSXZzdy9oOW4rZjY5NTNUdENB?=
 =?utf-8?B?M2ZxZ3lKQUdXeldFR0JUV2F0S3I4UnpJRkFrbi9kMkdiV25NcTdOU2p4TFdR?=
 =?utf-8?B?bWVxODhlRjFRR1BlYS96ODJwcjJ2dTZScEw4Tm42TmZwL3ExeTJtSjV0REFx?=
 =?utf-8?Q?bDc0kNUDW7klcRKla1dknJDng/WYnIg0bP2zNtoWcNxI=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7f4048-7658-4432-6393-08dcea1ce5cd
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 17:48:21.7144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7149

Hello,

Sorry to bother but what had happened to this patch? It is more useful now
since outlook also switched to oauth2 only mode.

Best regards,
Shengyu


在 2024/2/25 18:34, Julian Swagemakers 写道:
> Manually send SMTP AUTH command for auth type OAUTHBEARER and XOAUTH2.
> This is necessary since they are currently not supported by the Perls
> Authen::SASL module.
>
> The bearer token needs to be passed in as the password. This can be done
> with git-credential-oauth[0] after minor modifications[1]. Which will
> allow using git send-email with Gmail and oauth2 authentication:
>
> ```
> [credential]
> 	helper = cache --timeout 7200	# two hours
> 	helper = oauth
> [sendemail]
>      smtpEncryption = tls
>      smtpServer = smtp.gmail.com
>      smtpUser = example@gmail.com
>      smtpServerPort = 587
>      smtpauth = OAUTHBEARER
> ```
>
> As well as Office 365 accounts:
>
> ```
> [credential]
> 	helper = cache --timeout 7200	# two hours
> 	helper = oauth
> [sendemail]
>      smtpEncryption = tls
>      smtpServer = smtp.office365.com
>      smtpUser = example@example.com
>      smtpServerPort = 587
>      smtpauth = XOAUTH2
> ```
>
> [0] https://github.com/hickford/git-credential-oauth
> [1] https://github.com/hickford/git-credential-oauth/issues/48
>
> Signed-off-by: Julian Swagemakers <julian@swagemakers.org>
> ---
>   git-send-email.perl | 65 +++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 63 insertions(+), 2 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 821b2b3a13..72d378f6fd 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1359,6 +1359,63 @@ sub smtp_host_string {
>   	}
>   }
>   
> +sub generate_oauthbearer_string {
> +	# This will generate the oauthbearer string used for authentication.
> +	#
> +	# "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
> +	#
> +	# The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
> +	# * gs2-cb-flag `n` -> client does not support CB
> +	# * gs2-authzid `a=" {User} "`
> +	#
> +	# The second part are key value pairs containing host, port and auth as
> +	# described in RFC7628.
> +	#
> +	# https://datatracker.ietf.org/doc/html/rfc5801
> +	# https://datatracker.ietf.org/doc/html/rfc7628
> +	my $username = shift;
> +	my $token = shift;
> +	return "n,a=$username,\001port=$smtp_server_port\001auth=Bearer $token\001\001";
> +}
> +
> +sub generate_xoauth2_string {
> +	# "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
> +	# https://developers.google.com/gmail/imap/xoauth2-protocol#initial_client_response
> +	my $username = shift;
> +	my $token = shift;
> +	return "user=$username\001auth=Bearer $token\001\001";
> +}
> +
> +sub smtp_bearer_auth {
> +	my $username = shift;
> +	my $token = shift;
> +	my $auth_string;
> +	if ($smtp_encryption ne "tls") {
> +		# As described in RFC7628 TLS is required and will be will
> +		# be enforced at this point.
> +		#
> +		# https://datatracker.ietf.org/doc/html/rfc7628#section-3
> +		die __("For $smtp_auth TLS is required.")
> +	}
> +	if ($smtp_auth eq "OAUTHBEARER") {
> +		$auth_string = generate_oauthbearer_string($username, $token);
> +	} elsif ($smtp_auth eq "XOAUTH2") {
> +		$auth_string = generate_xoauth2_string($username, $token);
> +	}
> +	my $encoded_auth_string = MIME::Base64::encode($auth_string, "");
> +	$smtp->command("AUTH $smtp_auth $encoded_auth_string\r\n");
> +	use Net::Cmd qw(CMD_OK);
> +	if ($smtp->response() == CMD_OK){
> +		return 1;
> +	} else {
> +		# Send dummy request on authentication failure according to rfc7628.
> +		# https://datatracker.ietf.org/doc/html/rfc7628#section-3.2.3
> +		$smtp->command(MIME::Base64::encode("\001"));
> +		$smtp->response();
> +		return 0;
> +	}
> +}
> +
>   # Returns 1 if authentication succeeded or was not necessary
>   # (smtp_user was not specified), and 0 otherwise.
>   
> @@ -1392,8 +1449,12 @@ sub smtp_auth_maybe {
>   		'password' => $smtp_authpass
>   	}, sub {
>   		my $cred = shift;
> -
> -		if ($smtp_auth) {
> +		if ($smtp_auth eq "OAUTHBEARER" or $smtp_auth eq "XOAUTH2") {
> +			# Since Authen:SASL does not support XOAUTH2 nor OAUTHBEARER we will
> +			# manuall authenticate for tese types. The password field should
> +			# contain the auth token at this point.
> +			return smtp_bearer_auth($cred->{'username'}, $cred->{'password'});
> +		} elsif ($smtp_auth) {
>   			my $sasl = Authen::SASL->new(
>   				mechanism => $smtp_auth,
>   				callback => {

