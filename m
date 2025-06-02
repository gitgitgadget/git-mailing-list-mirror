Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1622AEF5
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862031; cv=fail; b=j+qlR2CR/Bqp0tyl2GRowob7Zgw10hlymZIe/9XPKhn74DT40HfSDj/t59YkqGMeVxXfIM02pMgMvyhHLIh2hK0HkMlrvSEqxHerSKYln9bMjF/Q0m9E/rxK4cbeyrD8iSw+QVN9lxw9zPuUo0BKaajTEKh193JBXa8nTmhK38g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862031; c=relaxed/simple;
	bh=WUl1cgErKKfLm6KzCP6C2Z5te9IBcWXkvXdUvlJtNu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E15t1t8LerSXVD9T/PtCvRoH6gRlEIXqG8/fbAQX6K2m7nRbrzy78H01y1mul4Pu37jUiJT/IeQBCzIBKOhvl+CSpoG+R8nvBrCIRwfBP+hVOF1KySqSiWGncDkhQll2xCC3mmhEwx0ZSqLHkX/n8JZ3vJ8PjOlowLef4Dfh9Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=rpY0Qiko; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="rpY0Qiko"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2zNJb4YnwSFdHHTUdpvTcFBNitEwfCISSfClMvGII+UxiDOdq870OjSqrsXEEafTbiRO22AHfAtJZfqJeeht8l9Pzl0mJEM9gtC3f0JMbM49zXNJxVhtbtloNfDhw6TKqssT3eCU2ZFhuxvnvFbzvSw5nm+MbnXL9Ur+KId5G6UnSpJ+7SAZEjmdgrzidE+GO6IT/0UsOa/VT4FOOAGDhJLcmSxsPzRrZPhzNigG9ClACqcB8UWxncIbYn9LpMUaVtb2CbKqm+xEDMGlTuQoRmF4qD7F9jk0fT4r9qnlaUgZuxHQA+E2qtlr7Sz9GCriT9pF/0iOC8nIf1V9kEOWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TisVvR0gv7OyEUiuySLV1JXTsMscpu50sLhAmZjpuI0=;
 b=W/R7TmHo5z0pIBzwczUxVTRW//LbXrP9Nx7B2e4I/m0h8csXbhKchlSMXXaPnp4U8qn9xCnwAHbq9N+mKRyaQL9XCuIM3+vmiugqjr8CHlgvfopi2LuyfwoUbP7tzvT4F0tPgL3gQrG/TklUMJ7FDacLszJwh6oqo0Q6snJEYbwXxh72VUvyA537PL8kKNNpenl8FJnboOKPIZtychcE3uzK8WVJJ2hp8BbWClafTgqmwFImoFcu7GBBXLnyWwJf994YHmqeKDktTKV0gLiWkYLXEZAz49BpxWt493BRr5nMQYn0k7FR82TnTI7oBFTimlHajSv8fYRpsbp6zxKZsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TisVvR0gv7OyEUiuySLV1JXTsMscpu50sLhAmZjpuI0=;
 b=rpY0QikomMS0xsltZ7K+O1KxoWX2DFhgnFtP6PLy2UEr5foKh+mqO29JLo8z9qk5EGkwiJNjYAsXfz+GcOFTeQ2PYAFcDUvYXE7C5yN1OZreHog6S+SbkpiRCJWkvTzLqgI7Jmgzi/OYZqbsvvKTogbAVZy9JVbOLQkd8vmwzxxzhaxne7H+dtWc+2mfjzqYzEmH/UPHbzlyQdtknLd4JZuHgV1XPg0/et2eXsF+WkiiKC9pMsWGAM5Y7JCiYB3eURDng7KvOKSaPWXAPSCYS/1lOOjdi9nmGKchgJfyJ3Syzv2tO0yE4PuTk3acZEqavSzVBCvRfOvNF7ZRiUH4Xg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB8176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:00:24 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 11:00:24 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v12 00/10] imap-send: make it usable again and add OAuth2.0 support
Date: Mon,  2 Jun 2025 16:29:31 +0530
Message-ID:
 <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g36d50d01f0.dirty
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250602105940.75439-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc80fe1-5cd7-46a3-7a87-08dda1c4ac62
X-MS-Exchange-SLBlob-MailProps:
	Mga27o8vReHCdvL2qF+xyFjTTItLCG6Zst1kqdVHtYr27aAaarz7oepS5d8ky7Zs0CiJni/t6qvx0NtKNUNiODqmYTrZVc54S/cBwd3FXZs+pTReab1nWjyVkKvcN84WBx0b0y2Ygq/KogMHee6D8wZe196P3/n0hUzt4dyBLRbmuAymx5SJkd4WTZOOyqymuaSQmuNsUN9xB+8IN7MaA98/xK/mt9YvKd7v4wyRjym9j7j6xIjNfArXyuLbsJykY7I8Kh0PIquYFOorz5e5PCa9I1amwSPF337AFlOVkdlg3eEho7PTQoUPrZQ4k4ng10E/2Q9vsBfXPEjNEYRfkmtO/pjAH5oFGdy4ydntCXbB5upWx8VhtKzaO/p1Mw6WW0pm06bIaUCfprp37Sj+AcEY2WaFPQbo5lhrvNg0+KIGLTxXS0huRpE0uglSGCoiZsOYnCsdVxg5hDAUnSK2VvyLUXWEQpkxaUVrQZO0mXKd7K5f5wHJNjXoFORyRBBQEr41WMbyavtEkQ480CcgPmZTEJeqWgNRdw6OF7+65tSOjz9uwuU7edvViGl+E0Mk53hSHY2czig/IzaWviprLXqfG7r4WrURqbc2LH+cViig5vgmgE4M3m5o2NIhsb5NG4+fqDiPKyp5/ouZLgsiA1cTyGfuss8gNUYmGlJrvtEjkw9Vomy05IKZqtjww+tG/RW3gCaYwsOR98UchmoxMFK6fHWNoU2QxsALR9j1ilmauUFgHNTx8OZRx4lMAzHqaAan7A65TXbwU5iYvPC4raME6bEeIC5er/5jkss8Z8p/JIp4BCzOnw==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|7092599006|8060799009|15080799009|19110799006|12121999007|5072599009|461199028|3412199025|440099028|19111999003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?38LVsbJ7GVgfHsZMOCT4D3a810FG7HFqwGyp7sjNM60NuYkGH4drwN5OJeNb?=
 =?us-ascii?Q?bWNcrm4EI5Qq0KY560NV0DatsV3ovRl1A74iubOQRSKKvuRug4rcbg9a8yoM?=
 =?us-ascii?Q?Z9Es3pQHCF+DeJXmrwcCrpSLLtgAISBnTJVGeOylK8XMFVsKHdLxN8nEhro5?=
 =?us-ascii?Q?FfYkhtwS5vRo/Iom//tRvWls4pcq6EOPsHyPdT7y6sZDaJhZr2v3N+MAhtLw?=
 =?us-ascii?Q?CgOddsc3jtqILz2Z9ALFVFmkHEvKIvWsFEQs6odmld9Cd9+a/FJlLdSzVc+e?=
 =?us-ascii?Q?1gz8tuZTFF7Zsk52mYCoKP553FKDO4VJQ0EQPu2C4ui9L5GiQOMSMybA8qVn?=
 =?us-ascii?Q?dvKCrTPYZAINHaOodm9EljjfHNSxq7ih8Va39h1R3F/3wgw62QIUDjoQeC83?=
 =?us-ascii?Q?PBea/u5gBtvKNO8KDs76kBsdlH5WbWbrLC2RIaNSl/fHyrFHUojog8LfMG3E?=
 =?us-ascii?Q?nHIL1Ibj/xT7oHC3fn0QCI6H4pxmJiJxPabYaNGg0r+WFija4ci+kYMDG7W+?=
 =?us-ascii?Q?DzgVRHVib3+9dnUeSAI9Xe3qYpch0G/nhGrwowGI8iQlTSrwDv8KC5+yHZro?=
 =?us-ascii?Q?/7aVWa5S0uB2IoxDHBvAJzx+yIazwEJS1LHQNp29GWfVxULimueL73CdkBNf?=
 =?us-ascii?Q?62cTTGC29z0JPQ1YHc2aRL10YcjOjqHALeeh6ZzoadJJncFsKccoA7iY9AUL?=
 =?us-ascii?Q?yl/R/sg4D5WSAU9LqIw2RriyZz0c2lzySKCDEgdFoIr1uOcfp4WUDPzJNd7k?=
 =?us-ascii?Q?yM8SP5uiFFWK9xch+Vh47HUUTJ+64+3XWnTPShUHai7flXY3eHsO3AbKSQcK?=
 =?us-ascii?Q?iOiUzYnnj2Yb4cKmgVBOjuT9+DYMugvGZjLVtFaYpRB1aOFX22if0ju6aR6v?=
 =?us-ascii?Q?hmaQRAiCMso9HzEDh8oaWVwzsOYER0+vGTTf5ffLiLL3VfO/K2Yv08gZ9J6O?=
 =?us-ascii?Q?14EEAW9mMhUnU3wA4v9qgStiCj6BE2clxExd2shr26OkU+r3NKJ0MzAElT4I?=
 =?us-ascii?Q?v+yKbqgHT9L08FATCt7+fgBLIr5JPmP/7wwPHFrH2AYKpXNcti/xSYx6iNM/?=
 =?us-ascii?Q?Eb0j5qRZdA7wQgBed1Ao+n7CnzjP5Vo53JlXqQzn99V9gtsybRXbekU9D6iM?=
 =?us-ascii?Q?IZPEBcfMTl/zfkWbHOtsRlctXEwTA0K460BQLBLTmF5ePh3iSkv/VkbY/sVI?=
 =?us-ascii?Q?29nE43klguhAGLuY11ES1U8E8Q6rwkDux8qjko9E6mo4FSTsvgIPRIo01DG6?=
 =?us-ascii?Q?YDGi1C4bUhfe4qJtVEG5?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nElAWcE8hESDna91Rh2tGKtL3pD5QV1XDoucv542xPe7OAWf1DC/yr1SN80m?=
 =?us-ascii?Q?ipWNPz4A92Yb1DfP9PCZzw2OM2B6/V376JYyj0TtOymVK3a5OFD4Ur2Sdj8Z?=
 =?us-ascii?Q?mPV9bfGXQAMG6HWuJKiEYW/5F1EhkyaiqDHPjEs24eO3slYApYUr4AfcJUp3?=
 =?us-ascii?Q?+/HtsUlgbdXVofnYhk3gh8/oYg4wupiyuJMonOxO61WG3ryGmXwRJRUKvv9s?=
 =?us-ascii?Q?T0qsQVM1IeP4Ke2GSiS+Jssj3TkKo6jRe38gNESECjEo6fOs9EIu/BOuGk+H?=
 =?us-ascii?Q?3Y13ptVqb7omK6CpK5H+fXViJatqOzJN+M1FMzS88wR17s0tWU42GTlt68U6?=
 =?us-ascii?Q?Byh+sbzSCnmRoUFFQgabT+BpP61GkVfdaC8z4kObgupU8Tu1OrPpW3i4GXY+?=
 =?us-ascii?Q?kPwjNSxzse7fbxRT0MKXD7i4a/zrW+sY4P8C+nxtYbEsvGDFIkIDfYCZmKlR?=
 =?us-ascii?Q?6Ikz+QQcUhEDQvR46zjZVUrlVTmGyrxzCWwdio6l0QBohN5/2sUtjSuH4eGd?=
 =?us-ascii?Q?PrKzfIGRoQWde/bD+qPPwJ3rrL6wdmrVX0Rpb2vzrLji+QBYX6z5sLV48drT?=
 =?us-ascii?Q?c7bXuCSzeg/HvWx4QBoxggWKM8gqPUZgBznQKTD40guzpt8Ggbfl4Pl2h0qG?=
 =?us-ascii?Q?z0TFdrwLuWNrTz8hRh12LYnw90cQrviV/MZVoRVQIESmms0P3UU2+5aOdgqn?=
 =?us-ascii?Q?eeII+AxRpoB23iqWWBVJWIBNMSsWeW4OEkztfApSBmP3o6DbIlj5E9vQ1rgl?=
 =?us-ascii?Q?Hm8+Bwed5G3zCKlW8ie5Sotrmp1h91Rw6Og25EgNNQyK5mcNdOFlzbQViKW0?=
 =?us-ascii?Q?N8XUC2hWA0aonRoKnnyhbbAWs3btydUTq6y3lqOoC7v8va6Zl5K7UpMoYPlj?=
 =?us-ascii?Q?E6Yo2FesONKRwippLY04l1q/w0rCVnlsBaDAYJxaqsV2r9ZZVRLqT6DnfCdf?=
 =?us-ascii?Q?QO4c/DeTjizVjP4eWk0SKlC518f+yATpSQgpsP+6LPkF6LPr+qQfnD3y8Iv6?=
 =?us-ascii?Q?i/oG1zWOYorAvEB7HUMTgyaKFvXkYLubxhznvPMj8CnYaeHVPMg8x/8JEuyh?=
 =?us-ascii?Q?eXhDBVQGbzwneEsg7kcrPfG9i7QuhdcycCu6tC5llSpiFqgy24iE7KQ7rHHg?=
 =?us-ascii?Q?q6ywagJSr9Gykt//JyykuvWKmk73DHrd5GEEa5BJU/ks921s+wbrSMPy59FG?=
 =?us-ascii?Q?GJ5BQ3cP/F+qgaNsvi4QBuQyt0AXUN8NCZudR7zHdhqSPdDWbvOVaQJTF2lX?=
 =?us-ascii?Q?0mocF2/jzYepQyD81F4VggrQtRCe4qIxaymvm0jsl31iEgSQjgP5BnydPNsV?=
 =?us-ascii?Q?x3Nm19b0FPYWk1qdQlFTQDUN?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc80fe1-5cd7-46a3-7a87-08dda1c4ac62
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:00:23.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8176

This patch series does the following things:
Firstly it basically makes the imap-send command usable again since it
was broken because of not being able to correctly parse the config file.

Further it adds support for OAuth2.0 and PLAIN authentication to git
imap-send.

Last, it does some minor improvements including adding the ability to
specify the folder using the command line and ability to list the
available folders by adding a `--list` option.

P.S.: I am surprised this thing even exists xD.

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

Aditya Garg (10):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: fix memory leak in case auth_cram_md5 fails
  imap-send: gracefully fail if CRAM-MD5 authentication is requested
    without OpenSSL
  imap-send: enable specifying the folder using the command line
  imap-send: fix minor mistakes in the logs
  imap-send: display port alongwith host when git credential is invoked
  imap-send: display the destination mailbox when sending a message
  imap-send: add ability to list the available folders

 Documentation/config/imap.adoc   |  11 +-
 Documentation/git-imap-send.adoc |  68 ++++-
 imap-send.c                      | 425 +++++++++++++++++++++++++++----
 3 files changed, 441 insertions(+), 63 deletions(-)

Range-diff against v11:
 -:  ---------- >  1:  3e3ddf7077 imap-send: fix bug causing cfg->folder being set to NULL
 1:  02037873a1 !  2:  ab12f713d2 imap-send: add support for OAuth2.0 authentication
    @@ Documentation/config/imap.adoc: imap.authMethod::
      	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
     -	option, the only supported method is 'CRAM-MD5'. If this is not set
     -	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
    -+	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
    -+	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
    -+	plaintext LOGIN command.
    ++	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
    ++	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
    ++	plaintext `LOGIN` command.
     
      ## Documentation/git-imap-send.adoc ##
     @@ Documentation/git-imap-send.adoc: Using Gmail's IMAP interface:
    @@ Documentation/git-imap-send.adoc: Using Gmail's IMAP interface:
      ---------
      
     +Gmail does not allow using your regular password for `git imap-send`.
    -+If you have multi-factor authentication set up on your Gmail account, you can generate
    -+an app-specific password for use with `git imap-send`.
    -+Visit https://security.google.com/settings/security/apppasswords to create it.
    -+Alternatively, use OAuth2.0 authentication as described below.
    ++If you have multi-factor authentication set up on your Gmail account, you
    ++can generate an app-specific password for use with `git imap-send`.
    ++Visit https://security.google.com/settings/security/apppasswords to create
    ++it. Alternatively, use OAuth2.0 authentication as described below.
     +
      [NOTE]
      You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
    @@ Documentation/git-imap-send.adoc: that the "Folder doesn't exist".
      If your Gmail account is set to another language than English, the name of the "Drafts"
      folder will be localized.
      
    -+If you want to use OAuth2.0 based authentication, you can specify `OAUTHBEARER`
    -+or `XOAUTH2` mechanism in your config. It is more secure than using app-specific
    -+passwords, and also does not enforce the need of having multi-factor authentication.
    -+You will have to use an OAuth2.0 access token in place of your password when using this
    -+authentication.
    ++If you want to use OAuth2.0 based authentication, you can specify
    ++`OAUTHBEARER` or `XOAUTH2` mechanism in your config. It is more secure
    ++than using app-specific passwords, and also does not enforce the need of
    ++having multi-factor authentication. You will have to use an OAuth2.0
    ++access token in place of your password when using this authentication.
     +
     +---------
     +[imap]
    @@ imap-send.c: enum CAPABILITY {
     -	AUTH_CRAM_MD5
     +	AUTH_CRAM_MD5,
     +	AUTH_OAUTHBEARER,
    -+	AUTH_XOAUTH2
    ++	AUTH_XOAUTH2,
      };
      
      static const char *cap_list[] = {
    @@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const
     +	return b64;
     +}
     +
    - #else
    - 
    - static char *cram(const char *challenge_64 UNUSED,
    -@@ imap-send.c: static char *cram(const char *challenge_64 UNUSED,
    - 	    "you have to build git-imap-send with OpenSSL library.");
    - }
    - 
    -+static char *oauthbearer_base64(const char *user UNUSED,
    -+		  const char *access_token UNUSED)
    -+{
    -+	die("You are trying to use OAUTHBEARER authenticate method "
    -+	    "with OpenSSL library, but its support has not been compiled in.");
    -+}
    -+
    -+static char *xoauth2_base64(const char *user UNUSED,
    -+		  const char *access_token UNUSED)
    -+{
    -+	die("You are trying to use XOAUTH2 authenticate method "
    -+	    "with OpenSSL library, but its support has not been compiled in.");
    -+}
    -+
    - #endif
    - 
    - static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    -@@ imap-send.c: static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    - 	return 0;
    - }
    - 
     +static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
     +{
     +	int ret;
    @@ imap-send.c: static int auth_cram_md5(struct imap_store *ctx, const char *prompt
     +	return 0;
     +}
     +
    - static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
    - {
    - 	if (srvc->user && srvc->pass)
    + #else
    + 
    + static char *cram(const char *challenge_64 UNUSED,
    +@@ imap-send.c: static char *cram(const char *challenge_64 UNUSED,
    + 	    "you have to build git-imap-send with OpenSSL library.");
    + }
    + 
    ++#define auth_oauthbearer NULL
    ++#define auth_xoauth2 NULL
    ++
    + #endif
    + 
    + static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
     @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
      					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
      					goto bail;
    @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *
     +						"but %s doesn't support it.\n", srvc->host);
     +					goto bail;
     +				}
    ++
    ++				#ifdef NO_OPENSSL
    ++				fprintf(stderr, "You are trying to use OAUTHBEARER authentication mechanism "
    ++					"with OpenSSL library, but its support has not been compiled in.");
    ++				goto bail;
    ++				#endif
    ++
     +				/* OAUTHBEARER */
     +
     +				memset(&cb, 0, sizeof(cb));
    @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *
     +						"but %s doesn't support it.\n", srvc->host);
     +					goto bail;
     +				}
    ++
    ++				#ifdef NO_OPENSSL
    ++				fprintf(stderr, "You are trying to use XOAUTH2 authentication mechanism "
    ++					"with OpenSSL library, but its support has not been compiled in.");
    ++				goto bail;
    ++				#endif
    ++
     +				/* XOAUTH2 */
     +
     +				memset(&cb, 0, sizeof(cb));
 2:  3a0be43838 !  3:  ba9c3fb756 imap-send: add PLAIN authentication method to OpenSSL
    @@ Documentation/config/imap.adoc: imap.authMethod::
      	Specify the authentication method for authenticating with the IMAP server.
      	If Git was built with the NO_CURL option, or if your curl version is older
      	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
    --	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
    --	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
    -+	option, the only supported methods are 'PLAIN', 'CRAM-MD5', 'OAUTHBEARER'
    -+	and 'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
    - 	plaintext LOGIN command.
    +-	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
    +-	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
    ++	option, the only supported methods are `PLAIN`, `CRAM-MD5`, `OAUTHBEARER`
    ++	and `XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
    + 	plaintext `LOGIN` command.
     
      ## imap-send.c ##
     @@ imap-send.c: enum CAPABILITY {
    @@ imap-send.c: enum CAPABILITY {
     +	AUTH_PLAIN,
      	AUTH_CRAM_MD5,
      	AUTH_OAUTHBEARER,
    - 	AUTH_XOAUTH2
    + 	AUTH_XOAUTH2,
     @@ imap-send.c: static const char *cap_list[] = {
      	"LITERAL+",
      	"NAMESPACE",
    @@ imap-send.c: static char hexchar(unsigned int b)
      {
      	int i, resp_len, encoded_len, decoded_len;
     @@ imap-send.c: static char *xoauth2_base64(const char *user, const char *access_token)
    - 
    - #else
    - 
    -+static char *plain_base64(const char *user UNUSED,
    -+		  const char *access_token UNUSED)
    -+{
    -+	die("You are trying to use PLAIN authenticate method "
    -+	    "with OpenSSL library, but its support has not been compiled in.");
    -+}
    -+
    - static char *cram(const char *challenge_64 UNUSED,
    - 		  const char *user UNUSED,
    - 		  const char *pass UNUSED)
    -@@ imap-send.c: static char *xoauth2_base64(const char *user UNUSED,
    - 
    - #endif
    + 	return b64;
    + }
      
     +static int auth_plain(struct imap_store *ctx, const char *prompt UNUSED)
     +{
    @@ imap-send.c: static char *xoauth2_base64(const char *user UNUSED,
     +	return 0;
     +}
     +
    - static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    + static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
      {
      	int ret;
    +@@ imap-send.c: static char *cram(const char *challenge_64 UNUSED,
    + 	    "you have to build git-imap-send with OpenSSL library.");
    + }
    + 
    ++#define auth_plain NULL
    + #define auth_oauthbearer NULL
    + #define auth_xoauth2 NULL
    + 
     @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
      		if (srvc->auth_method) {
      			struct imap_cmd_cb cb;
    @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *
     +						"but %s doesn't support it.\n", srvc->host);
     +					goto bail;
     +				}
    ++
    ++				#ifdef NO_OPENSSL
    ++				fprintf(stderr, "You are trying to use PLAIN authentication mechanism "
    ++					"with OpenSSL library, but its support has not been compiled in.");
    ++				goto bail;
    ++				#endif
    ++
     +				/* PLAIN */
     +
     +				memset(&cb, 0, sizeof(cb));
 3:  45f5b3f1ff =  4:  3d1a66da57 imap-send: fix memory leak in case auth_cram_md5 fails
 -:  ---------- >  5:  70bb9388b8 imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
 4:  8899f686d7 !  6:  0d00a5e135 imap-send: enable specifying the folder using the command line
    @@ Documentation/config/imap.adoc
      	The folder to drop the mails into, which is typically the Drafts
     -	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
     -	"[Gmail]/Drafts". Required.
    -+	folder. For example: 'INBOX.Drafts', 'INBOX/Drafts' or
    -+	'[Gmail]/Drafts'. Required if `--folder` argument is not used. If
    -+	set and `--folder` is also used, `--folder` will be preferred.
    ++	folder. For example: `INBOX.Drafts`, `INBOX/Drafts` or
    ++	`[Gmail]/Drafts`. The IMAP folder to interact with MUST be specified;
    ++	the value of this configuration variable is used as the fallback
    ++	default value when the `--folder` option is not given.
      
      imap.tunnel::
      	Command used to set up a tunnel to the IMAP server through which
    @@ Documentation/git-imap-send.adoc: git-imap-send - Send a collection of patches f
      other email is when using mail clients that cannot read mailbox
      files directly. The command also works with any general mailbox
     -in which emails have the fields "From", "Date", and "Subject" in
    -+in which emails have the fields 'From', 'Date', and 'Subject' in
    ++in which emails have the fields `From`, `Date`, and `Subject` in
      that order.
      
      Typical usage is something like:
 5:  c2dfd0178c =  7:  999c65438f imap-send: fix minor mistakes in the logs
 6:  4e1b51acd5 =  8:  d0315aebd4 imap-send: display port alongwith host when git credential is invoked
 7:  85c40d8491 =  9:  73352a18cf imap-send: display the destination mailbox when sending a message
 8:  5e24c6cde8 ! 10:  36d50d01f0 imap-send: add ability to list the available folders
    @@ Documentation/git-imap-send.adoc: OPTIONS
      
      CONFIGURATION
      -------------
    -@@ Documentation/git-imap-send.adoc: Alternatively, use OAuth2.0 authentication as described below.
    +@@ Documentation/git-imap-send.adoc: it. Alternatively, use OAuth2.0 authentication as described below.
      
      [NOTE]
      You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
-- 
2.49.0.639.g36d50d01f0

