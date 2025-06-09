Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E34C8E
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453708; cv=fail; b=Ydn5EaSpHvLseuyhIuMVLzn9D4WHaGIGvlfB3XoVnoxT4qMDD6mI7NCPUv/o26l81vQyG4+KZT2ciXvefUc43aUM8IdZmsvix1WlZECf4dqQWyVSshhIXptPyGfxOkRtq7tcHXGqxVgEOw8xtXaPfZlwmKGgH/lV5nRMb1aYCPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453708; c=relaxed/simple;
	bh=VW8LG49Rnz7fURCo4TFE49+z1czdVJbUeDrEKv9nuEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q3bzcb8iIpV6jEyctUSKQ3KFO7TQjMWKNhzjUakYH14QsaK+UYvlSOf4r/UP565gIFvBm/YmKdSeK9+SC8sRDF18Bw0iArZSDjAmdnMqTJ3GKHM1YOd8iNxGIpr7YZSHTpQeowYaAYaTabpAS7HI3fxuR5oMw48KGpKsRPSGX6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ADrVchr/; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ADrVchr/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m4Ta/ib5PQlpTg6tfniJNFGKHjlQyZ33U/7ntK75VMdZmF4Nf8d2wGNxSKMuog+QLcaoZw8GPYjGYJ5l5kIgBEi7gZmy71i7fiDJJnVST4vbn5dgoG+In58ROveJE+YMyJ0zrMIhhoy37GsZHX31f5jVVnRvhHB5bgP6yoQ38eCNviHXdljoky/vFjiIMpwbSmfjEplAum39OHI1HoD8DWJaqs+OtSKt9bOwlYZR+7l56etE+A33WzCe6iWMDZSWsVUKfmJwAb3fT6AnGpH4KMgxo+T3OiTmyDPQC8soeSGX5mv0KjAkM36P9wpcljcASG5s7e+XdHCO9Cl+LMa0Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5XYQmyquvi2CsmySEIZSdNsev4iCmZYl2pFzeeBogo=;
 b=KNhsN7vJI/tAYPmgHUxapyc2qBsuhZZj6A1dHU3nU/lOsCVoG2s9Ty4txPQPrAqdJw5nmgEMo3K6GqfSe9AD7phXrzBCSvqncDzHMZcWZ2Gw3mLYCdLYb1scL2pr3fVJul4o/daUxtad/bQXg49LciekXw7r3wff6aDB7LFpLPz+pk23RG0LQqeCeHUekAQbXsbftFbV5fQVc4KapQBLLALipHU5yM3s7/iQt/8I4JFoQGQWYnhacov9jlT7LafCsEUNT893A3bE7pSR0Yg11ok/2CMsgLI1FDDzN9kHiTFOClAU+Q4Hzl1TsGmS4taiB67hsj1xyL5In+JDPNm4bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5XYQmyquvi2CsmySEIZSdNsev4iCmZYl2pFzeeBogo=;
 b=ADrVchr/MjlBvA0hCNlx6PKIQX9q3+/ZAlTOsbyYlAj4aXx2NHD1gKKQ/Up0aa9JZGvpxPTa0jbM7HQpkdF+Hdtc+08RuWUrOvcGSb+035UYyoLzK2a+aKMkTCVo6Q9RWodeHE+UNKvO7BPlErE79sM7XjInvFLTN8Llq+4ZZUZ0Ki863CZlf0FlOPGwpudu5DBKcMzlc7kXA7mBtM85NvHZnXWy6PAy5zFuY5CxjOj4yPVw+Jfg24M4/MCgJWxAZQ+CaqIHPYifz0nZ8p5uLH8jjnl0pZq291YT4PGKJgJc1fk+N07TiAYlDyLSh8dSJeKzxRk98ElREvy+R5LTnQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7959.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:21:39 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 07:21:39 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v16 00/10] imap-send: make it usable again and add OAuth2.0 support
Date: Mon,  9 Jun 2025 07:20:31 +0000
Message-ID:
 <PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g6561d45bee
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001B5.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609072041.12114-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 11eb82db-5771-4492-edbd-08dda726469c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799006|12121999007|15080799009|41001999006|7092599006|8060799009|56899033|1602099012|440099028|3412199025|4302099013|10035399007|12091999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LX+fxaizz9ar0h8HcIXZpdgYQsttKSkOxFlKimLemBZUr2Z1hQFvpudlQ8mZ?=
 =?us-ascii?Q?ocre/sw0HQKQIZ0q90OF6tovdJ0e/5K2EQRDxL578tNnvsewGFAiLGcWfTJt?=
 =?us-ascii?Q?gDlMYdGr6NMrXH6oHmflMcrcPCvELIN+Vbb0KvvlKx0O/LvTVMnhvBml2Ipq?=
 =?us-ascii?Q?oziMxVqq34tWQhHooYQpEizAWKUJS044stP3AnayV46+l3QhZXi9Bl2B4orm?=
 =?us-ascii?Q?HWNuDhXojFfRIRBXJuns4q0+RlEz+IXk7FhOS4DsQB4Hnimfe+7ASawCRlyO?=
 =?us-ascii?Q?1/yxymqrhGIo+NXrzscwmSfCmyE1oFUvVilEVpcfN+RV2TExbOzXM+CFMIgS?=
 =?us-ascii?Q?SVWLf/0cM3rwb74UNpNHvRCCXeNXD7UJarz/T88gDzyGlEp19rpUqkZfSayG?=
 =?us-ascii?Q?67k52WFZ1NO4BowXIXpDUo5fJhpmBbm1xEPym6RwZnew/iI8+lElhYpU4LqN?=
 =?us-ascii?Q?b62aJ/EfaIHEGTdvZmnPB+2uvXqpI/soK8Lm2seLFC0j1E9oGdjusN0evuq4?=
 =?us-ascii?Q?z7zLgDfccZDdm8CEMjcZDf7R5J7aBfT5oze4mM8bKskPUDrzAYUtCWiIpEkp?=
 =?us-ascii?Q?XL0tiaM25nOxEkQSRuDrWGh56n82cUk5hb0kxlRABATvMFs7C7qyKvaYvTln?=
 =?us-ascii?Q?o8bIRFzHZ/a63IUdk99FOWCzYtAGDax5RQROKAChurtJ4QnwNBlNAvqK3qdt?=
 =?us-ascii?Q?0/evDA2twz4ky6f4CqEsRL+EMa4QyUX+gKnIp0p41aWyijC+u/NOtQxnp1+h?=
 =?us-ascii?Q?1qZ0NVOvgrP6akKzMkNuUXi7qgvU76vAHjyxb5MDdkuf6QtXa2V4197e8yQP?=
 =?us-ascii?Q?tF/bpndoNPVJK8mVeyfwUDefYUq8YBmng64fnRjoA6HV4eR2JkS1w5Y/jipi?=
 =?us-ascii?Q?5dtSxgZBrjecV2wRq6mvalDyZiRAldZld3HupXqDO7A4eEAqWCsSzfuurSv9?=
 =?us-ascii?Q?lMpcXe9aCLdIIlOukcJb3nLpziFeW9U1wJGGU7k0/+T9m6j1tUYMmEwObkY1?=
 =?us-ascii?Q?KiA1qXJTw9ooyO1q02XL1oayxWRDB57l3sZ3yr6zQ5FrGl+3NZJ4nJ3oK6qb?=
 =?us-ascii?Q?LzFWjHKBW0ReRG4lQUs7PbWnRET8CZscghXzpP/B+hOabve8WHe010hY8tev?=
 =?us-ascii?Q?wuLSEOXa73LSWEpAEMWEZk5rr+aZFOo/0FdKfptsN9S/Th2XoRDnlBQwhkd/?=
 =?us-ascii?Q?9iZDC7wdHdpXuF6azmgnKmefPOZXEY5LBEFnhLDyxGgtBJBAh97QS4IOFINq?=
 =?us-ascii?Q?EPlGg11SsvCInDfO3jJ91T29dSAS18tukcPu786D56F4f8z5PoJPu/WIfpuX?=
 =?us-ascii?Q?wkWtCUDFjMP3Q6ZApUM9AbI6P/HOKSXPCAwZjAKttkG9QkNwQYsTtoceaBqj?=
 =?us-ascii?Q?LOZE3hg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Obea2mQQR86dhbx09g7PwK+bO6gOk+Bt5AR+jowYTSZSgg/IaxFsEUCd1m0A?=
 =?us-ascii?Q?gr7PuElvW+HYDSFDuS4Nntcg3BgCyqhXAFFA/Lsf0teXBcCj0A99XELr+I4I?=
 =?us-ascii?Q?dsuPF+Vf8UVBg9jUXQhp289PVfcbNFkJD3+KP9Z9qCqjby14hvuVvUdyteCm?=
 =?us-ascii?Q?5fwIGSbw4YuuW/kp3y2FlxlZdFh1LvXBn7VKGmOTBjhImOu2zmOvmy8WHoog?=
 =?us-ascii?Q?E3J0qteyHS96HQqOm9sosS89yZfHzk39x9g7+UxyIpErYAoUX7ZUsUFXzDEZ?=
 =?us-ascii?Q?+8rMyR9jzqYOpW40wZIbbaUZ8s/sVciM5+UhGLHfdP6KA39YcE9LOgCTlvzq?=
 =?us-ascii?Q?krhoEimP/khbQJWFWtPmXgnwSdDwwrf3ULMi5++xcD0fGJ6koJb8aJSbGCFH?=
 =?us-ascii?Q?5/OxyjtSx2dcadqgONOiQPS5uQlwqoF8Oc+Eb/t2USwq1N/JLwUp87yP3gXK?=
 =?us-ascii?Q?HuzV5tNBg8hLQVEexVTk+hdvNqC1Mcml5S5Tl2T5+Ci+x1zYSmlfDbR6A5O0?=
 =?us-ascii?Q?aQyAHPQ9DacWpYhbFx8OIPnslnw3xt0MpPt/WxWwipEkK61hcHTEQ5qq4dwI?=
 =?us-ascii?Q?PA5Wig8RLQEr+iPFsL7xgK63ZbhmL9tQCSWsJ0bVnd3A0Hr93FZKFEnaVCUc?=
 =?us-ascii?Q?G7+yIh29XsLI3SNniMNqPCV5CJCf059uQHnjBJ7Zy6ZJRaQYXnr5xzquCQZm?=
 =?us-ascii?Q?pbSOSg29VMlKdCrcPrydAN06CFqQZ81qNdJG30INhdd1U29V2I0vbzTTCj/m?=
 =?us-ascii?Q?PVrkD2e7QrJXpfNRWf1+OVdTEpOC5XHkgdhiZ35qEf+5NEPWRYFv8LVR+RMB?=
 =?us-ascii?Q?oDck2wr/l5jlimN8eilqGs3L2Dzhtnl8R0XUCmOsXmFdWykoHRuecglaAPL0?=
 =?us-ascii?Q?XvJdNKkx/Ht/QJta7jE2x9zgyI/KweCmdRccF1dis204Ow0zc0ymavRWWzbH?=
 =?us-ascii?Q?S3NrVauCODyEsPUOTK0zx0OukUHOMKvBWUmJb0EiY7Me/1jj6tHlPCyftiit?=
 =?us-ascii?Q?rC8AGUoWmjV9GmkoZuF9FvM2KH8rOw0F2WJYlZwpWlys4vMUEvbGjFGwzqf8?=
 =?us-ascii?Q?UJpdDcY3Gg3dMOlPbmNOeneJJjUcLaktIs0Xsj+nGfKzCxKqXOORtHJ1Czvu?=
 =?us-ascii?Q?FHq50Sfme2LSDqd63xbiYpCfsuiPhW98ifFdqy2Bi7PtYuSLXR4KQua3cs2J?=
 =?us-ascii?Q?RopO8Ug3I1FxLbFFdSviAGSqw63F72hHo5borlwJReb0PFYnFLE5p7OOS64?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 11eb82db-5771-4492-edbd-08dda726469c
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:21:39.5816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7959

This patch series does the following things:
Firstly it basically makes the imap-send command usable again since it
was broken because of not being able to correctly parse the config file.

Further it adds support for OAuth2.0 and PLAIN authentication to git
imap-send.

Lastly, it does some minor improvements including adding the ability to
specify the folder using the command line and ability to list the
available folders by adding a `--list` option.

v2:  - Added support for OAuth2.0 with curl.
     - Fixed the memory leak in case auth_cram_md5 fails.
v3:  - Improve wording in first patch
     - Change misleading message if OAuth2.0 is used without OpenSSL
v4:  - Add PLAIN authentication mechanism for OpenSSL
     - Improved wording in the first patch a bit more
v5:  - Add ability to specify destination folder using the command line
     - Add ability to set a default between curl and openssl using the config
v6:  - Fix minor mistakes in --folder documentation
v7:  - Fix spelling and grammar mistakes in logs shown to the user when running imap-send
     - Display port alongwith host when git credential is invoked and asks for a password
     - Display the destination mailbox when sending a message
v8:  - Drop the patch that enabled user to choose between libcurl and openssl using the config
     - Add ability to list the available folders by adding a `--list` option
v9:  - Encourage users to use OAuth2.0 for Gmail (similar change done for send-email docs).
v10: - Fix comment styles
     - Fix failing tests
v11: - Use lower case letters for the first word of a sendtence in an error message
       and avoid using full stops at the end of a sentence.
v12: - Gracefully exit PLAIN, CRAM-MD5, OAUTHBEARER and XOAUTH2 authentication methods
       if OpenSSL support is not compiled in, but is requested by the user.
     - Use backticks for string literals.
     - Wrap documentation text to 75 columns.
     - End the last member of enum CAPABILITY with a trailing comma.
v13: - Fix logic error which was using || instead of && when checking if
       the authentication method is neither XOAUTH2 nor OAUTHBEARER.
v14: - Specify why we are not using CURLOPT_PASSWORD for OAuth2.0
       methods using a comment.
     - Add a function try_auth_method() to reduce code duplication
       when trying to authenticate using a specific method.
v15: - Simply rearrange the patches to make the cram md5 patches come
       before adding OAuth2.0 and PLAIN authentication methods. No 
       change has been done to the code itself.
v16: - Rearrage some more patches so that the two new features, i.e.,
       --folder and --list come just after the new authentication
       methods. Then the two patches with minor improvements of displaying
       the destination mailbox and displaying port alongwith host have
       been added. The patch fixing other minor mistakes in the logs has
       been moved to the end. Just like v15, no change has been done
       to the code itself.

Aditya Garg (10):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: fix memory leak in case auth_cram_md5 fails
  imap-send: gracefully fail if CRAM-MD5 authentication is requested
    without OpenSSL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: enable specifying the folder using the command line
  imap-send: add ability to list the available folders
  imap-send: display port alongwith host when git credential is invoked
  imap-send: display the destination mailbox when sending a message
  imap-send: fix minor mistakes in the logs

 Documentation/config/imap.adoc   |  11 +-
 Documentation/git-imap-send.adoc |  68 ++++-
 imap-send.c                      | 412 ++++++++++++++++++++++++++-----
 3 files changed, 414 insertions(+), 77 deletions(-)

Range-diff against v15:
 -:  ---------- >  1:  3e3ddf7077 imap-send: fix bug causing cfg->folder being set to NULL
 -:  ---------- >  2:  417b3b8e38 imap-send: fix memory leak in case auth_cram_md5 fails
 -:  ---------- >  3:  c4216528e7 imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
 3:  668e62c0e0 !  4:  b38fca0e6a imap-send: display the destination mailbox when sending a message
    @@ Metadata
     Author: Aditya Garg <gargaditya08@live.com>
     
      ## Commit message ##
    -    imap-send: display the destination mailbox when sending a message
    +    imap-send: add support for OAuth2.0 authentication
     
    -    Whenever we sent a message using the `imap-send` command, it would
    -    display a log showing the number of messages which are to be sent.
    -    For example:
    +    OAuth2.0 is a new way of authentication supported by various email providers
    +    these days. OAUTHBEARER and XOAUTH2 are the two most common mechanisms used
    +    for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2], whereas
    +    XOAUTH2 is Google's proprietary mechanism (See [3]).
     
    -        Sending 1 message
    -         100% (1/1) done
    +    [1]: https://datatracker.ietf.org/doc/html/rfc5801
    +    [2]: https://datatracker.ietf.org/doc/html/rfc7628
    +    [3]: https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
     
    -    This had been made more informative by adding the name of the destination
    -    folder as well:
    +    Signed-off-by: Aditya Garg <gargaditya08@live.com>
     
    -        Sending 1 message to Drafts folder...
    -         100% (1/1) done
    + ## Documentation/config/imap.adoc ##
    +@@ Documentation/config/imap.adoc: imap.authMethod::
    + 	Specify the authentication method for authenticating with the IMAP server.
    + 	If Git was built with the NO_CURL option, or if your curl version is older
    + 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
    +-	option, the only supported method is 'CRAM-MD5'. If this is not set
    +-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
    ++	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
    ++	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
    ++	plaintext `LOGIN` command.
     
    -    Signed-off-by: Aditya Garg <gargaditya08@live.com>
    + ## Documentation/git-imap-send.adoc ##
    +@@ Documentation/git-imap-send.adoc: Using Gmail's IMAP interface:
    + 
    + ---------
    + [imap]
    +-	folder = "[Gmail]/Drafts"
    +-	host = imaps://imap.gmail.com
    +-	user = user@gmail.com
    +-	port = 993
    ++    folder = "[Gmail]/Drafts"
    ++    host = imaps://imap.gmail.com
    ++    user = user@gmail.com
    ++    port = 993
    + ---------
    + 
    ++Gmail does not allow using your regular password for `git imap-send`.
    ++If you have multi-factor authentication set up on your Gmail account, you
    ++can generate an app-specific password for use with `git imap-send`.
    ++Visit https://security.google.com/settings/security/apppasswords to create
    ++it. Alternatively, use OAuth2.0 authentication as described below.
    ++
    + [NOTE]
    + You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
    + that the "Folder doesn't exist".
    +@@ Documentation/git-imap-send.adoc: that the "Folder doesn't exist".
    + If your Gmail account is set to another language than English, the name of the "Drafts"
    + folder will be localized.
    + 
    ++If you want to use OAuth2.0 based authentication, you can specify
    ++`OAUTHBEARER` or `XOAUTH2` mechanism in your config. It is more secure
    ++than using app-specific passwords, and also does not enforce the need of
    ++having multi-factor authentication. You will have to use an OAuth2.0
    ++access token in place of your password when using this authentication.
    ++
    ++---------
    ++[imap]
    ++    folder = "[Gmail]/Drafts"
    ++    host = imaps://imap.gmail.com
    ++    user = user@gmail.com
    ++    port = 993
    ++    authmethod = OAUTHBEARER
    ++---------
    ++
    ++Using Outlook's IMAP interface:
    ++
    ++Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Also, it
    ++supports only `XOAUTH2` as the mechanism.
    ++
    ++---------
    ++[imap]
    ++    folder = "Drafts"
    ++    host = imaps://outlook.office365.com
    ++    user = user@outlook.com
    ++    port = 993
    ++    authmethod = XOAUTH2
    ++---------
    ++
    + Once the commits are ready to be sent, run the following command:
    + 
    +   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
    +@@ Documentation/git-imap-send.adoc: Just make sure to disable line wrapping in the email client (Gmail's web
    + interface will wrap lines no matter what, so you need to use a real
    + IMAP client).
    + 
    ++In case you are using OAuth2.0 authentication, it is easier to use credential
    ++helpers to generate tokens. Credential helpers suggested in
    ++linkgit:git-send-email[1] can be used for `git imap-send` as well.
    ++
    + CAUTION
    + -------
    + It is still your responsibility to make sure that the email message
     
      ## imap-send.c ##
    -@@ imap-send.c: static int append_msgs_to_imap(struct imap_server_conf *server,
    +@@ imap-send.c: enum CAPABILITY {
    + 	LITERALPLUS,
    + 	NAMESPACE,
    + 	STARTTLS,
    +-	AUTH_CRAM_MD5
    ++	AUTH_CRAM_MD5,
    ++	AUTH_OAUTHBEARER,
    ++	AUTH_XOAUTH2,
    + };
    + 
    + static const char *cap_list[] = {
    +@@ imap-send.c: static const char *cap_list[] = {
    + 	"NAMESPACE",
    + 	"STARTTLS",
    + 	"AUTH=CRAM-MD5",
    ++	"AUTH=OAUTHBEARER",
    ++	"AUTH=XOAUTH2",
    + };
    + 
    + #define RESP_OK    0
    +@@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const char *pass)
    + 	return (char *)response_64;
    + }
    + 
    ++static char *oauthbearer_base64(const char *user, const char *access_token)
    ++{
    ++	int raw_len, b64_len;
    ++	char *raw, *b64;
    ++
    ++	/*
    ++	 * Compose the OAUTHBEARER string
    ++	 *
    ++	 * "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
    ++	 *
    ++	 * The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
    ++	 * * gs2-cb-flag `n` -> client does not support CB
    ++	 * * gs2-authzid `a=" {User} "`
    ++	 *
    ++	 * The second part are key value pairs containing host, port and auth as
    ++	 * described in RFC7628.
    ++	 *
    ++	 * https://datatracker.ietf.org/doc/html/rfc5801
    ++	 * https://datatracker.ietf.org/doc/html/rfc7628
    ++	 */
    ++	raw_len = strlen(user) + strlen(access_token) + 20;
    ++	raw = xmallocz(raw_len + 1);
    ++	snprintf(raw, raw_len + 1, "n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
    ++
    ++	/* Base64 encode */
    ++	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
    ++	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
    ++	free(raw);
    ++
    ++	if (b64_len < 0) {
    ++		free(b64);
    ++		return NULL;
    ++	}
    ++	return b64;
    ++}
    ++
    ++static char *xoauth2_base64(const char *user, const char *access_token)
    ++{
    ++	int raw_len, b64_len;
    ++	char *raw, *b64;
    ++
    ++	/*
    ++	 * Compose the XOAUTH2 string
    ++	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
    ++	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
    ++	 */
    ++	raw_len = strlen(user) + strlen(access_token) + 20;
    ++	raw = xmallocz(raw_len + 1);
    ++	snprintf(raw, raw_len + 1, "user=%s\001auth=Bearer %s\001\001", user, access_token);
    ++
    ++	/* Base64 encode */
    ++	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
    ++	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
    ++	free(raw);
    ++
    ++	if (b64_len < 0) {
    ++		free(b64);
    ++		return NULL;
    ++	}
    ++	return b64;
    ++}
    ++
    + static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    + {
    + 	int ret;
    +@@ imap-send.c: static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    + 	return 0;
    + }
    + 
    ++static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
    ++{
    ++	int ret;
    ++	char *b64;
    ++
    ++	b64 = oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
    ++	if (!b64)
    ++		return error("OAUTHBEARER: base64 encoding failed");
    ++
    ++	/* Send the base64-encoded response */
    ++	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
    ++	if (ret != (int)strlen(b64)) {
    ++		free(b64);
    ++		return error("IMAP error: sending OAUTHBEARER response failed");
    ++	}
    ++
    ++	free(b64);
    ++	return 0;
    ++}
    ++
    ++static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
    ++{
    ++	int ret;
    ++	char *b64;
    ++
    ++	b64 = xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
    ++	if (!b64)
    ++		return error("XOAUTH2: base64 encoding failed");
    ++
    ++	/* Send the base64-encoded response */
    ++	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
    ++	if (ret != (int)strlen(b64)) {
    ++		free(b64);
    ++		return error("IMAP error: sending XOAUTH2 response failed");
    ++	}
    ++
    ++	free(b64);
    ++	return 0;
    ++}
    ++
    + #else
    + 
    + #define auth_cram_md5 NULL
    ++#define auth_oauthbearer NULL
    ++#define auth_xoauth2 NULL
    + 
    + #endif
    + 
    +@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    + 			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
    + 				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
    + 					goto bail;
    ++			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
    ++				if (try_auth_method(srvc, ctx, imap, "OAUTHBEARER", AUTH_OAUTHBEARER, auth_oauthbearer))
    ++					goto bail;
    ++			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
    ++				if (try_auth_method(srvc, ctx, imap, "XOAUTH2", AUTH_XOAUTH2, auth_xoauth2))
    ++					goto bail;
    + 			} else {
    + 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
    + 				goto bail;
    +@@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
    + 
    + 	server_fill_credential(srvc, cred);
    + 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
    +-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
    ++
    ++	/*
    ++	 * Use CURLOPT_PASSWORD irrespective of whether there is
    ++	 * an auth method specified or not, unless it's OAuth2.0,
    ++	 * where we use CURLOPT_XOAUTH2_BEARER.
    ++	 */
    ++	if (!srvc->auth_method ||
    ++	    (strcmp(srvc->auth_method, "XOAUTH2") &&
    ++	    strcmp(srvc->auth_method, "OAUTHBEARER")))
    ++		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
    + 
    + 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
    + 	strbuf_addstr(&path, srvc->host);
    +@@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
    + 	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
    + 
    + 	if (srvc->auth_method) {
    +-		struct strbuf auth = STRBUF_INIT;
    +-		strbuf_addstr(&auth, "AUTH=");
    +-		strbuf_addstr(&auth, srvc->auth_method);
    +-		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
    +-		strbuf_release(&auth);
    ++		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
    ++		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
    ++
    ++			/*
    ++			 * While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
    ++			 * upon debugging, it has been found that it is capable of detecting
    ++			 * the best option out of OAUTHBEARER and XOAUTH2.
    ++			 */
    ++			curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, srvc->pass);
    ++		} else {
    ++			struct strbuf auth = STRBUF_INIT;
    ++			strbuf_addstr(&auth, "AUTH=");
    ++			strbuf_addstr(&auth, srvc->auth_method);
    ++			curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
    ++			strbuf_release(&auth);
    ++		}
      	}
    - 	ctx->name = server->folder;
    - 
    --	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
    -+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
    -+		total, (total != 1) ? "s" : "", server->folder);
    - 	while (1) {
    - 		unsigned percent = n * 100 / total;
    - 
    -@@ imap-send.c: static int curl_append_msgs_to_imap(struct imap_server_conf *server,
    - 	curl = setup_curl(server, &cred);
    - 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
    - 
    --	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
    -+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
    -+		total, (total != 1) ? "s" : "", server->folder);
    - 	while (1) {
    - 		unsigned percent = n * 100 / total;
    - 		int prev_len;
    + 
    + 	if (!srvc->use_ssl)
 -:  ---------- >  5:  86d3d2c54d imap-send: add PLAIN authentication method to OpenSSL
 -:  ---------- >  6:  7674e749c8 imap-send: enable specifying the folder using the command line
 4:  4d9a3b5661 !  7:  90ce3a63f3 imap-send: add ability to list the available folders
    @@ imap-send.c: static int curl_append_msgs_to_imap(struct imap_server_conf *server
     +
      	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
      
    - 	fprintf(stderr, "Sending %d message%s to %s folder...\n",
    + 	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
     @@ imap-send.c: static int curl_append_msgs_to_imap(struct imap_server_conf *server,
      
      	return res != CURLE_OK;
    @@ imap-send.c: int cmd_main(int argc, const char **argv)
      		server.port = server.use_ssl ? 993 : 143;
      
     -	if (!server.folder) {
    --		fprintf(stderr, "no IMAP store specified\n");
    +-		fprintf(stderr, "no imap store specified\n");
     -		ret = 1;
     -		goto out;
     -	}
      	if (!server.host) {
      		if (!server.tunnel) {
    - 			fprintf(stderr, "no IMAP host specified\n");
    + 			fprintf(stderr, "no imap host specified\n");
     @@ imap-send.c: int cmd_main(int argc, const char **argv)
      		server.host = xstrdup("tunnel");
      	}
    @@ imap-send.c: int cmd_main(int argc, const char **argv)
     +	}
     +
     +	if (!server.folder) {
    -+		fprintf(stderr, "no IMAP store specified\n");
    ++		fprintf(stderr, "no imap store specified\n");
     +		ret = 1;
     +		goto out;
     +	}
 2:  b2e7ef35ed =  8:  1bdd054908 imap-send: display port alongwith host when git credential is invoked
 -:  ---------- >  9:  e381120ab5 imap-send: display the destination mailbox when sending a message
 1:  a67322ce06 ! 10:  6561d45bee imap-send: fix minor mistakes in the logs
    @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *
      					srvc->user, srvc->host);
      				goto bail;
      			}
    -@@ imap-send.c: static int append_msgs_to_imap(struct imap_server_conf *server,
    - 	}
    - 	ctx->name = server->folder;
    - 
    --	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
    -+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
    - 	while (1) {
    - 		unsigned percent = n * 100 / total;
    - 
    -@@ imap-send.c: static int curl_append_msgs_to_imap(struct imap_server_conf *server,
    - 	curl = setup_curl(server, &cred);
    - 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
    - 
    --	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
    -+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
    - 	while (1) {
    - 		unsigned percent = n * 100 / total;
    - 		int prev_len;
     @@ imap-send.c: int cmd_main(int argc, const char **argv)
    - 		server.port = server.use_ssl ? 993 : 143;
      
    - 	if (!server.folder) {
    --		fprintf(stderr, "no imap store specified\n");
    -+		fprintf(stderr, "no IMAP store specified\n");
    - 		ret = 1;
    - 		goto out;
    - 	}
      	if (!server.host) {
      		if (!server.tunnel) {
     -			fprintf(stderr, "no imap host specified\n");
    @@ imap-send.c: int cmd_main(int argc, const char **argv)
      			goto out;
      		}
     @@ imap-send.c: int cmd_main(int argc, const char **argv)
    + 	}
    + 
    + 	if (!server.folder) {
    +-		fprintf(stderr, "no imap store specified\n");
    ++		fprintf(stderr, "no IMAP store specified\n");
    + 		ret = 1;
    + 		goto out;
    + 	}
    +@@ imap-send.c: int cmd_main(int argc, const char **argv)
      
      	total = count_messages(&all_msgs);
      	if (!total) {
-- 
2.49.0

