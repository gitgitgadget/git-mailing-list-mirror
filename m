Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A807A2111
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626369; cv=fail; b=ZjcM4H8zYWBgAsR2cp81KpNa7L4kXXcUhQvq9Js7Zaa4ci28FbvvVtZOg8aBYC47uHpquaZqkhd2AcHCg5Xzxpyekkkkj8EccacfYm/cGOU2Wy6gcZcTD2riK45oN3+WCKngK7vMz0P29o2/FhlHWODFq/WPn1YGa+7WeFJgiZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626369; c=relaxed/simple;
	bh=XQFlbUCBkfI0iXvzDEcqO4DQwmDQ4A6BKlpMgGiIMug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PGt62aU7DfKhJB768fWud+Q4B+y9dtQCxqExFZUt5BCvKQYlijuRk+FyyXm5Njfbrlk0Of0cNCaE2j7+obLqXAGD9HHwobgi1ZdiH8CgF3TtJUNgTPoQ0o9YtVaq6lEfjLaYuD0LxrXfomNyoFyGJBT4RIsbr2WIVLpjhTofklU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=YJSwHIVs; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="YJSwHIVs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDVMbuO2L0qlMDJ5ZLMTVxBQ36Pmdp+Gb0gV5UfBI54MukxYkPUxVzJXTXhbx5s6ze02Hy+PuIZCu+a+zJ0sPGcfP62eAsDACuNN1p7R6eSPxom0UShOyMleUAlcestsQrHELpRKJZIV5L1vqu79AnjMjg9tJkHouw5tvq1fi0hD/hrumhK3XXVRpCu1QtPibqxQ3DBCLxXXBlIZoEUnpKCpOypTzNblgAw8VGQpfUcGIaVBQ6ZIufIHfabieKhizqffPAfYrdzOJJ1Z+N1jRNc0XTeC8Ibd0MCEdam7s89o8qA2KhzeMWUmuOmbTBLnfKnkfAAhcNH/PEchyg0cZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sUq4TqoBYerzGgVWGxpg2QZ6y7zhcxXZTTHrp13TY0=;
 b=PN6wyY+WcWbzZY/yR5a54awH+tPyiwZ9LMWN2XG4l7yAjQegIN1+HRteJFM0MoBGGAornKKtO3nF/bZfxibN++EXXfsSzRf+6WT500yGKDDq+cGnmNJHaaKgnwpfMkml1uSssQMTvWIUJOkEJBuQjWWBXs5jHI4xiX4e7Qtud6nZALkT0wticrWbno9qz4OJrv8kDzT1x9WihANXjpL0ctEdqc4BWeMn+H9fwm1nKTP+7LyEhFVDIpvOI3WGIATm02y0Xrb3ARYhD548b/ztr7sFjUykkAoMPo5j5wN3ECUX2pBxoc3Q3KZvzy/Va3RohXNh+Yei9ZbvPFF0M/XSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sUq4TqoBYerzGgVWGxpg2QZ6y7zhcxXZTTHrp13TY0=;
 b=YJSwHIVsv9+nIPOeF6A5ubLoMQlJuHUOuSRdYxgGf2hHMSW6HJeZMBjYVQNeaP0y4vEOGG0RTCPc9wSPFqbiO5WnXvqRQo8wreSzFYQQBRSryTmBIsLAPES2VIZHZgaJ7LOCi/SeedEsYMI2fwZpWnfY01qMfqIoYImfBD2aozLy1l8Ny81uNxJNNKvHrUtv0jkvFrb3lsJJpgpFd6wGfkx1m8bL8qj8z5lpm8MDSL0wuCG2cfGD5Lo+fi644rX+MEvS5s4vwPhc3L5kIeZG7hPTKyY5BHqiqiE8bRwCq6SklPknfDMRdvpwZir8kneYq6469v+/2JT/q2vJkdmQoA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5501.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 30 May
 2025 17:32:42 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 17:32:42 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v9 0/9] imap-send: make it usable again and add OAuth2.0 support
Date: Fri, 30 May 2025 23:02:13 +0530
Message-ID:
 <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g6f2668de07
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250530173222.20211-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 593a5d02-a60f-4f96-8548-08dd9f9ffb34
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|7092599006|19110799006|15080799009|8060799009|12121999007|440099028|3412199025|19111999003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZrD6YpkOIrXsNOIl99xBW40nkZFTcZHvrXfnUQ3OroJKPgVzzlIfl5NkEPTc?=
 =?us-ascii?Q?rAq0Gwy2d84o0ApWJ00jFlTsEprcIcR/lMJ/sfn2IFW/hh2ktmI3+WXe/cFX?=
 =?us-ascii?Q?t7a8Zfot/iGuldAQnXzF03NMyYpmQJmyoryz4iiP6Sw54DKCaK/RYMdFI0NI?=
 =?us-ascii?Q?NX/7IEbYiIjEJwmOg7XjrPlwPPN3dCZIhFJLGdEfNbUTPNO32DVUlJct6v9e?=
 =?us-ascii?Q?s0z33td0lj3ccr0Cr9bQN2mVQ/hDZUS8QvdGyhW7TWScKISVcZXDaBfZdUZo?=
 =?us-ascii?Q?HEtcn3Y488b9cjQVawBsFyrVcFG10CJk0F9AMIGLCVOun4pOzZe/8TsLtYsv?=
 =?us-ascii?Q?UOZbnMzeuNQ33mYRWXNZIHb3W7+BLQV6iEHsTOhFi/uus3uiF6pnhUk1Ke/V?=
 =?us-ascii?Q?TI25hmw4zGRBVZ1bZAihKg5UJG6KFt1eAsNPnGEOTQsfrbBpNpLlJSkolNIt?=
 =?us-ascii?Q?0RJ4GDbUf5Vq3KPgM/Y1AZpNWv794YfLRmVufYhk+dsUI5sFECgspUelDili?=
 =?us-ascii?Q?EeiHntU2uXR3losLhUFRs1VzOnHNhUPefn3QIehsqMpcULOkFFZOpxzXIr2F?=
 =?us-ascii?Q?5w8f/LArHGdjtHdpMKclui21xEAHtQaXWFAGCPXMMpxI/UToydOyrdZStmmz?=
 =?us-ascii?Q?ZHfRlMBRF2ahBMmlQJNgLaMOoI4pURib9nXgohzv7ugayQq9UzSnfnMLigcf?=
 =?us-ascii?Q?/o08vf+lmU3oBq4a3ayz3VBt7E4icEPlu9MRoC8yIzsUKX2/AtSTphYJLQxz?=
 =?us-ascii?Q?RUt80PwOUWunUyjW4hM1QV4X2som6hkMF3TdCwC614iod1/dwcyWG8B8QOWT?=
 =?us-ascii?Q?lwwXNzswZVvTcDWRYJqW+tza9/Xen+xZS3ImCRqykPTuKicbgKhyyfXunXxl?=
 =?us-ascii?Q?GEEvjKsli9tkYPS06FIOJ8NRQ+N0l2dnOiWuvsp99kBJPQufUFN+IsZ3gXMB?=
 =?us-ascii?Q?3Yg71kGHhxBGaVNdOKv01T6Hu26craGqSjMf0AjllP7kKVV9u5205+uiW2w4?=
 =?us-ascii?Q?okbNw1CqMAauP8AiDkYsqAS0UI+k/1fEiVRmRMKcspm+fhUdflO9BzHoDxSz?=
 =?us-ascii?Q?Zgq70wNstirkeEF9yo+IZ9Wq7fJLdISnrAN558nHTmbtwvuOkwZyn5WByHnA?=
 =?us-ascii?Q?AZ976eP9aiCdSe+jtHx2w3NPpoRpslqneAI4wyymcFx9wkcrniT1vxUKNVTG?=
 =?us-ascii?Q?u66IVwtZnnnOqe0GU+7rJ68Y1S+g/lz/Ql+mJ2M6k9OIUXrGs9nyvVFr4xY?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RmWmx7P2eWWsd2tI+UFZLeKALkbD81p4Fd9PcsFgPjBVYA9Eyvki/t23ckHf?=
 =?us-ascii?Q?Os6m4ZUqSDDVnbLgvFo54caGED26G4GpyJgU1nY/CpjFV/pR/BFHmtSCg1s+?=
 =?us-ascii?Q?9kbhMdyUJI+AWq5y5nKQ2uQpQJr47kjf8G0z822LUhDHsx5de/BSh0l9iUlq?=
 =?us-ascii?Q?6bw8Ukjs3+MSMpQHyWK79YQuyWyRAw+bky5I4qqrAju2rCPGSyhPheBG51Yn?=
 =?us-ascii?Q?BUw1cEzD+YiFF7esoDOzO+xrcRqvoGAYUHYLEy4QwSQ2ALxNbElHGuaVfxsk?=
 =?us-ascii?Q?YUs7fSpv0dt2H5gDeLLD5brdD5rCus/qo++MUdWnMLSvTjTtSPE8m6ZZiWKM?=
 =?us-ascii?Q?2egp2+tD3e9lzzvv+9RfWmrICTz/gxQ6CZ37zxPLXWqVsEOYIK32B3aWqs/W?=
 =?us-ascii?Q?qAdGO5edCrNHUDY7qYyHQFznks5LhMJUEq2ig9g/O5cDW2NLudVTefkCQ3T7?=
 =?us-ascii?Q?rnHPyYLlagJbqcvbRd1PgX5VhshSqTtqRnfg2leUmOozUAoTsGxVE2cCPo18?=
 =?us-ascii?Q?YIQgXyn/DYxI4QaVJYcyBa+hCaWyyPEgqNuHG71J0FAMCC3DzmPeGCN51uWj?=
 =?us-ascii?Q?sPpZdC3vL4kCvvboUYJWSBBRBsYhFrFQsFrK0uo8E+nOCxjKfHuOVOhmk0o7?=
 =?us-ascii?Q?77SibE9+ZFRj4Zl6xcyvMGgDspwShhO+MVQOHZgQQnwZ426fi+WTNPYIazk2?=
 =?us-ascii?Q?X2q5glEIsyjqlxoI9a5dpEanU+pGGZ24+JDeEhdc/SkWVLy8PeRx17R5zdBz?=
 =?us-ascii?Q?ZPWm54oIT/5+kSYqMPEANnl0cffA1DR2Uln0zltrzlTNevki+xOQmpbqTxBF?=
 =?us-ascii?Q?BLHQ+junW62OO7cC33KSfnBHl5BKF7d1TjES/u3djWriLnkBmZyFoXtVaj+T?=
 =?us-ascii?Q?QspAkWFz22LOBRBmQdUPmbejZb9Zb3z/9MpRlq9uJgAHFf3iTjPG9PbBjvLP?=
 =?us-ascii?Q?tQMd1tPAd9SydUgSuAU/hKkFL6yIWsgjGGGKS0awip8i4q4BWbt+PoVtBUJJ?=
 =?us-ascii?Q?WmcGJcLIpegCLOG+zR5JmtsKe4ahKsN0XjMb8Qm+617tx+5YSxWQ1Msg0uv7?=
 =?us-ascii?Q?V5zQW3anX2t4OJnMrHwKLIkvW94bLwI3g6/5UaM+lKxLK5/ZG7No7j+PCWjg?=
 =?us-ascii?Q?XfrAlril4E+dun3SqaiRzN/WuADeLzpbBV+5nSYH5i2kw+71saNqiynZBSxb?=
 =?us-ascii?Q?AyvH0nY+vIuh8fGxQAylEfVaGkAclGdWf2qSw1LHp3eW8SMn1Re7ct0cz2wB?=
 =?us-ascii?Q?xMcj66CBurmraNod24vpPPe8j8UJJ4WgHBELAB0inEPLJiTh6idKOSG/FFgu?=
 =?us-ascii?Q?ectCLuLxFzgkIaqTxNh63p17?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 593a5d02-a60f-4f96-8548-08dd9f9ffb34
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:32:42.2460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5501

This patch series does the following things:
Firstly it basically makes the imap-send command usable again since it
was broken because of not being able to correctly parse the config file.

Further it adds support for OAuth2.0 and PLAIN authentication to git
imap-send.

Last, it does some minor improvements including adding the ability to
specify the folder using the command line and ability to list the
available folders by adding a `--list` option.

P.S.: I am surprised this thing even exists xD.

v2: - Added support for OAuth2.0 with curl.
    - Fixed the memory leak in case auth_cram_md5 fails.
v3: - Improve wording in first patch
    - Change misleading message if OAuth2.0 is used without OpenSSL
v4: - Add PLAIN authentication mechanism for OpenSSL
    - Improved wording in the first patch a bit more
v5: - Add ability to specify destination folder using the command line
    - Add ability to set a default between curl and openssl using the config
v6: - Fix minor mistakes in --folder documentation
v7: - Fix spelling and grammar mistakes in logs shown to the user when running imap-send
    - Display port alongwith host when git credential is invoked and asks for a password
    - Display the destination mailbox when sending a message
v8: - Drop the patch that enabled user to choose between libcurl and openssl using the config
    - Add ability to list the available folders by adding a `--list` option
v9: - Encourage users to use OAuth2.0 for Gmail (similar change done for send-email docs).

Aditya Garg (9):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: fix memory leak in case auth_cram_md5 fails
  imap-send: enable specifying the folder using the command line
  imap-send: fix numerous spelling and grammar mistakes in logs
  imap-send: display port alongwith host when git credential is invoked
  imap-send: display the destination mailbox when sending a message
  imap-send: add ability to list the available folders

 Documentation/config/imap.adoc   |  10 +-
 Documentation/git-imap-send.adoc |  68 ++++-
 imap-send.c                      | 417 +++++++++++++++++++++++++++----
 3 files changed, 432 insertions(+), 63 deletions(-)

Range-diff against v8:
 -:  ---------- >  1:  3e3ddf7077 imap-send: fix bug causing cfg->folder being set to NULL
 1:  f0743d46e1 !  2:  c5ee87051f imap-send: add support for OAuth2.0 authentication
    @@ Documentation/git-imap-send.adoc: Using Gmail's IMAP interface:
     +    port = 993
      ---------
      
    -+Gmail does not allow using your account password for `git imap-send`.
    ++Gmail does not allow using your regular password for `git imap-send`.
     +If you have multi-factor authentication set up on your Gmail account, you can generate
     +an app-specific password for use with `git imap-send`.
     +Visit https://security.google.com/settings/security/apppasswords to create it.
    -+If you do not want to enable multi-factor authentication, you can use OAuth2.0
    -+authentication as described below.
    ++Alternatively, use OAuth2.0 authentication as described below.
     +
      [NOTE]
      You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
    @@ Documentation/git-imap-send.adoc: that the "Folder doesn't exist".
      folder will be localized.
      
     +If you want to use OAuth2.0 based authentication, you can specify `OAUTHBEARER`
    -+or `XOAUTH2` mechanism in your config. In such a case you will have to use an
    -+OAuth2.0 access token in place of your password.
    ++or `XOAUTH2` mechanism in your config. It is more secure than using app-specific
    ++passwords, and also does not enforce the need of having multi-factor authentication.
    ++You will have to use an OAuth2.0 access token in place of your password when using this
    ++authentication.
     +
     +---------
     +[imap]
 2:  b1602644b7 =  3:  17e263ea27 imap-send: add PLAIN authentication method to OpenSSL
 3:  49790e60cc =  4:  5c471f640b imap-send: fix memory leak in case auth_cram_md5 fails
 4:  2efe897379 =  5:  db8ee71785 imap-send: enable specifying the folder using the command line
 5:  8f6676a046 =  6:  a8fbcdf9d5 imap-send: fix numerous spelling and grammar mistakes in logs
 6:  69fdae55cd =  7:  a5dad0f2b2 imap-send: display port alongwith host when git credential is invoked
 7:  187dbccd03 =  8:  d2569a5e36 imap-send: display the destination mailbox when sending a message
 8:  03d7d6a772 !  9:  cf844b2632 imap-send: add ability to list the available folders
    @@ Documentation/git-imap-send.adoc: OPTIONS
      
      CONFIGURATION
      -------------
    -@@ Documentation/git-imap-send.adoc: authentication as described below.
    +@@ Documentation/git-imap-send.adoc: Alternatively, use OAuth2.0 authentication as described below.
      
      [NOTE]
      You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
-- 
2.49.0.639.ge2dd5d9d81

