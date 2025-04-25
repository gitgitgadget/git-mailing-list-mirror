Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0ED17AE1D
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576067; cv=fail; b=XxzkAtcJ7uwrp6X8U8SnctLWMjQH3oID6Ycdj04fXiHji3cfDNxzRT3C5AqS7UTUykY1XJ83Q0vNOPhz4DTI1fs24K78t1pMf/hEU9VmoSrX4OO3Y90Mplsh79q6a+CCWOqMrbSpujuX5fPsHNPPxq3O2KWJNNqN7546yiK6lf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576067; c=relaxed/simple;
	bh=zV2ACZ1pRVhKhT5pcll/elmbGQwiPucc4O8D8TObbmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nPSTWzJws74qWrHNSqQUHrzqV244qtEo4iy3h9CyUAKDLEBHya2kOjCP/4fNu+VQXA9Gd2SFUHjUugMqcejLN8VGX3HxR/YHUibjTVNPBWN7Wuxx0Lu0+85GCjEQqQ1mpsTAmmJ0jHN+C084iEnLyDOCTdqHjFlJOjCKlBrhLgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=BRmPCqCr; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="BRmPCqCr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/vaYODYWV6cQ3FeC1vUT9TkkobKzfiUG2hsvti7C7R3Le5CoqCzfrmx8un7dISXlPHIb9M4WEE3TYjcu5kMQ28StXL77ngcJuVnT/5ZfNCcToKtisG94VLxBNRc0PVFXDzUlLRPo3idZtSWtWjmz5rVyuDPJwip5bwuf7Kdd5PcmTIIxcuGrVM/WfQf/X1CtRGsp+GkPbELSc9yLjGmLLC3XzPsoAJ8rJ1Ly8equ7tdFXRjAQu3F/j58DC6fm0Q0wxzhXHtXQHzO5nRNMXFrRj6knkQmYO6wTYf1i1Wk52HExLzNZWNGXxYHwyFKAJu4Kx6WK7qoSORGs/udzOfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHv6Z/rITWVQh0xaKz8s0yGrLdDfjyqNdVk35LcG3II=;
 b=l5rvPsXG1Un5BZTRN5YcR0E3Q+tnDZ3K7d+r2R61FMeQ/b1OICCvza55UKXaZqZYtQGdgfBMCp4+3Z9tY0R0NAcgoT4vBftIcPEAX7GgXp1EQVoCRYd3OZfRTcGj42UuhNSWULWVUMTJsh8y0fXYa1kTG70qBw2TEi7YvP2ZRhZ0a1sngFwGrmPo7lNdaAyG1L/KAcyJ8LgPlFaSiw/821fUVdvmSLvv+PLqpFcv+X3BZ5sneJJYtc41OCCXPcMvCnsR21MoMwOFy6zciBHuZFPi77EX28BG85IaS9t+qMZuaURwD1Z7n9swVzeeKQJyzIUfucJVXbS6AVeZesxJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHv6Z/rITWVQh0xaKz8s0yGrLdDfjyqNdVk35LcG3II=;
 b=BRmPCqCrCub+JXhRlZdgUUQftf6ew4+jpUIBJUJa06n3s7VS63aFeN3JNa1uH6gEf1q1jgJt3ozNAmV9Ye9KetfO/jMrKpiHKRN19GCrCWfk/IHzuxV8p1zsJ4ozAnHAflsbB6PK8SdB8wtQrgxlU/NQBS+49qF4DlEdSotUbnhG6pTT8Ly4zwJ+fx4X4q3V2BjG3IxIm7h15NtaY+UKNu+DC2dwdPXU+4Z3uU1alBzMLtLqFdLVxRgkyjUqdsK+IkeCo7TpiJaHtFicPZaVdEY7JFg0cxjv85RcAbLH27ZIL+1WXCsFZXtu/jMgTtmPGV6QyyBFd31IMvCNri5LUA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9703.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:14:20 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 10:14:20 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erik Huelsmann <ehuels@gmail.com>
Subject: [PATCH v6 0/1] send-email: add oauth2 support and fix outlook breaking threads
Date: Fri, 25 Apr 2025 10:09:08 +0000
Message-ID:
 <PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0078.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25c::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250425101407.51465-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef7384b-40e8-40e2-7717-08dd83e1f1dd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|5072599009|7092599003|15080799006|10035399004|3412199025|440099028|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RzNr18VJKBNvkj3ueRGrnzkJhEGm4GncpcdHSsjD8Msj4RXJXQhQE7PTMAX8?=
 =?us-ascii?Q?PSXWOi6UI0HfqmqG2urwSPLbO+wiw5OyxHr/p+ByeKWRDohALKv/xXqDE6W7?=
 =?us-ascii?Q?W4o+TrIR5sosmRvi80KDFE4bBYProArbKLMyAF9qzQjfsjAas6EBLDuAG3be?=
 =?us-ascii?Q?Ml8D1eg+25LbqnsPSuewUBY5bVOwtBw6bb+CtevBJKQoI435w/F4tqqbdq86?=
 =?us-ascii?Q?TIPrA8AbGJmrHJuk63y8jggXQ6y6WDIqd8doMsYuQrF8hTY5Lo0Jm1JG9Y81?=
 =?us-ascii?Q?jnvYsdZhyPZjd/yMzHHEkF1W8c7QSESrX9LeQxeIkWYbH8eg6N7F83PAPk0n?=
 =?us-ascii?Q?aJc5asQmrFRM4HWE5zpBo6tD+CqWUVcA5FBS+clTtKkfs4FnsJIp9CkCN7XW?=
 =?us-ascii?Q?XACs5vGg/lZNgCu0v/J4QmmmcLTDRd2A2suigWW3omIJnRk6SgKbatIRLVEW?=
 =?us-ascii?Q?pBuBTlZRRv/Zef85E+qgQ1b6WpJNm+FNSXnj7dVQWU97VpFJcPuroJD0LL0h?=
 =?us-ascii?Q?hP3oZXQLSwYzySWwf8byb0Z98wVwd1XJlVIkfWKRd78y2W2QX/o37JIGXryd?=
 =?us-ascii?Q?Jv76/7Eya/emLyoQ/v9BaCWVIzOsL0szHA2leyEfL1E/G4GQ4EaBK+vQJBur?=
 =?us-ascii?Q?ecodFifRcJo/gV16FixutpwYDXylJabKQL4e0cfW4+mtvoBck2Zvo+fciLBr?=
 =?us-ascii?Q?uq8zQhawB007Bc4doivGlVAAWtmvdOzHUNCHMNWFtJqkJ7ds5z+HjuOZY/it?=
 =?us-ascii?Q?oUG1MOmHEw9yxohli4W/JnYsQfn8yUKgdR8Nsth8IAod5B9cLvHlKEDj2Cpz?=
 =?us-ascii?Q?X5QIKNN0+/plYL1Rv2FEpZjueAqaSH1P1HAcrYRXFdId321t1mUjBj89LEOF?=
 =?us-ascii?Q?3vgi6Ex7DTNEjPdoSGJ0sK4dFYjyHXOIrLsx9SU8Dr7Kc3o1plpbvzJinUEr?=
 =?us-ascii?Q?aLG6ax8haHJi3t0pQJaXxx2eQPqXVeJyA4fyiVF6ArvAHORBCnUSWbs28iYs?=
 =?us-ascii?Q?nnkCWt1QfC0SCfd4gnSHlbu5LAtgBGotwdlR7zTWSrHa8QEwnmOVKseRS+JO?=
 =?us-ascii?Q?VceONKeIFlWGTvpzW3etgBqFX1gw1DwscZy3omEOOeBBiwpZpmzrM8w7Z2AQ?=
 =?us-ascii?Q?3DEfP1iP8SAYwFul6oioOApv0vawQvO1GiSHHQ6R2SCI3M4QgbzhJfqP7Oio?=
 =?us-ascii?Q?8mRGkVY+XDyClt/W0snopaIaWPSiVIr6xyU1/shZcqCFHuudw6Zil5oNpoBf?=
 =?us-ascii?Q?Fy5aZs5uCrXO0nxCpjRkZrnchpMgxmhSeugswVRxCA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pDkVzu4uDX3sp5swQxolD05yi6KLHK4jEEiJRCEUYF2Z7sfJ3qfpSZjdxiJ5?=
 =?us-ascii?Q?6pI5wLyNEpp78C7fTsBeI6x9URj4oWN2rDVib30tSmCgQk0nzP6GSIMElVM2?=
 =?us-ascii?Q?WEUiTeITOTW3bTTQJ/nSW07YiPrNYvi7GD6GaMJ8YUdQnv1RimO2HHtYuVCC?=
 =?us-ascii?Q?YGwCYDkKs7p09S07GswGSpHtt0JiUx6cmr7DoPldC66dt9Aqgft5ssUitF2u?=
 =?us-ascii?Q?z7vg9G6/TD2Wd4RDfuq6vGjVEx8VS2H6YllmyjC7QSa9eWakEWDGNz9Qn+05?=
 =?us-ascii?Q?edwUX7pEmkPDPCq05b/21K/kyPa6C8hsslB3mQ7hfy5EGfHZex5QAwDOTKcN?=
 =?us-ascii?Q?dOjp4Yr/fY5qWSeb1ja/SCMNkpL8kJDJDAGtGqGVlq+mb1oWph18/QCqap8e?=
 =?us-ascii?Q?uipMcwdoWD36KB0IT+UrOKazTmdVXrNIFN8lKMUOR3eBzh/ZnLha6jJnwPbR?=
 =?us-ascii?Q?jpMXPUWZkiaWR3xyXr/iQuvWIHxhTxnbOtMruxjmsCNy9+1lJDR10dWkPzgr?=
 =?us-ascii?Q?g8d4+wTDZYqpuP2O/9620VFKa1lTcM8k32uKO8utHiSsbDrvp3LQj9g8jV8a?=
 =?us-ascii?Q?BeEAfuhIrRlw/jWyq62YnSALL9gY0M19tPRGhIbhLrvSWmupIHxGwXbtSogB?=
 =?us-ascii?Q?2xnB3mqN4Mf+0QKwzmnN327puhMQId/WdzBp5yNDxkp0kPOLF0Q3NHtSBDvv?=
 =?us-ascii?Q?e1jZIW2UQeXiDJ8ChOwylvP0+DRwM+KVDtD7VO12Avxh8Ii9HDmEPz9N+Dcb?=
 =?us-ascii?Q?0MBkgWEwjiwEQZtC2ZQPBwwtQLRB8XbKBUBSY4e0XXlRSAXD6m7yy0clp7h/?=
 =?us-ascii?Q?9Eluki48HHkjuy2gzcgt52kjflgOhDfTBmW5W7v1ZgIhvi7GxfCCpLZBrhvR?=
 =?us-ascii?Q?/pP8Xe1J6h0mpwgBPMHm8SQ1+cSWmSdfLSGj6NtpjzRqqcO5RRHNT2t4dnLx?=
 =?us-ascii?Q?VMBn00MPKAJUjtBHyxZ9t+uCMbC7P22jNFs6fuCL2v4Rz0/A1z0R0918CaZH?=
 =?us-ascii?Q?JAmjcg7HvNV6okioiKG3PbxG+jyzWv5R7WVJ+zZoWLVktBZ3IvxNHOEh63H1?=
 =?us-ascii?Q?hUQBQIyh4ytCAxNEr1vKQyYl9ATH43ew6nXdty/MLExsPmTm0ZfOi8IV1Qch?=
 =?us-ascii?Q?i0Kz+Xep/LY+pcsjshqhamiZENaQvYRCqpUcTIn9c9n7JgxMXyGUPi1OMX4e?=
 =?us-ascii?Q?1G1O6Fdnin7suG5c46MwUk/1RyEbiAsv6EqxQHlJ18Q0EHXA8IjSEV6RF6k?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef7384b-40e8-40e2-7717-08dd83e1f1dd
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:14:20.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9703

Hi all!

This patch series includes three changes:

1. It adds support for Oauth2 authentication, which is now compulsory by Microsoft.
   This patch has been rebased to the latest version from the original version
   at https://lore.kernel.org/git/20250125190131.48717-1-julian@swagemakers.org/

2. The second patch makes the script reply to the message id set by the outlook,
   since outlook has its own proprietary way to handle message ids,
   and does not allow user to set their own. As a result, threads were breaking.

3. The final patch adds a new option to generate passwords like OAuth2 tokens.
   This is useful for users who want to use a script which generates tokens for
   OAuth2 authentication.

Detailed description of each patch has been done in the respective patches

BTW, I am sending this series using the patched send-email by these patches from
Outlook!

v2:
- Fix errors flagged by the CI

v3:
- Add third patch to generate passwords like OAuth2 tokens

v4:
- Make log message of the second patch more clear.
- Change "Outlook: Retrieved Message-ID:" to "Outlook reassigned Message-ID to:"
- Update documentation for smtp-passeval.

v5:
- Fix minor grammar issues in the commit messages.
- Attempt to wrap code in 80 characters in 1st patch.
- Create additional sub to check whether we are using OAuth2 authentication

v6:
- Remove smtp bearer patch since Authen::SASL module can be patched
- Remove SmtpPassEval patch since a similar mechanism exists in [credential]

Aditya Garg (1):
  send-email: retrieve Message-ID from outlook SMTP server

 git-send-email.perl | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

-- 
2.49.0

