Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225E22AE65
	for <git@vger.kernel.org>; Thu,  8 May 2025 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717744; cv=fail; b=l3od7f/mom73kqev0SwdNECF6GKTjZO39aUVH736nzeukJ3HAO4Cw9CQ6OIL2Lwo0F7VDRQ3PysQjHv9a3nhr8QjdCvN+yRczLWSZfbmVakfSPi5y5KLEbkDaW/lf/BruJpKXXls59xYguak/P300rQFZWznL8A+eswm2GjzInk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717744; c=relaxed/simple;
	bh=oCYnLsG6ZNovVLuzPea9hJMSwArfbWdjnmAlLdDLn2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b41MjS49cihHZFZw2Aei6DjdCXy6y1r8EPVPReRZELql18PO34hIMUQRugqmC1tAsOIympmgRvHSVpESztGhoPvFa6ZTtJVHoG0jYK8pq+ZCWPln6v+gTyCAYXG64ZaqQwRIJ3D6iGa/58pM9Cl+HBTRroGps7+17rRHgK8MZmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=rqgjizdj; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="rqgjizdj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j6FqT8o0mKUnjLz8fmTAT3FPEUZ/jSmuBkDyKmuuWSKqHZQjA+bwsWor2mVb7YqeAzwIp0abIwMg1rAxCgBuK7LgVGyHlySLDQJxgNjZqOkv+cFFEwWHDaXW0X/r1lcsS3m5WBnRgMQPzKWyB+i8Dx4YeFXleT5rJLnPLthSIYb5HxfaBh4pqNoiSuOBz2w0E1V0N7X0lBX8pYKViy1O3dxDt5jekU7Y7/d8Enly2+TltMVOtvSH2cv1fzuFn3FksBTo9mHVstqEam4ptYepVYDcRsqXnPv4zuDLZSYKpR4jarWQZ9PfLYV8EuNk4kEkp/nS1g1OIbN3RD+ngQGqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP6vxGchfyyfG5jjo46dOpSdTC6aif+b0d5WgZtlEjA=;
 b=UZheEjGn++7HWvn8dPyDShPHPGzY9cxtpHCTBqOn1dJ2KuNm+j42KeKGpJHK57IppY+XPFjfuXwUiv0h34oOy9MvYlW6rWz94f+dSJgkflSSHgUrjvM4DJp2Y/s09I7nk1JVoTHgI0/KduYRy68iTWmqJbndRotoiGtYDrFj0qsJhNO0XZlnIDCK5wN3XRShU6v9p8IvP4qf9vXDI2quJsRFmsiLBqveJjU5vXCb55l884YTL1RckTzAO+x2jeMFrigI9QSGNGzan9PX4sm4oSkq6ekEYMB3sZwpUnEZmO5CfumIkbBMjyUaJE5wEMUlAOpAQ8wOuxbr7CJP5BwQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP6vxGchfyyfG5jjo46dOpSdTC6aif+b0d5WgZtlEjA=;
 b=rqgjizdjHMk3qBkwds7VgzND9vXr79zwhMkZDDOME++5twjQM4dIyK7ao0msG3RYi4sjGXhPX7QaqNd6306MzxHFi7qIhm2kQEU/GQS1B2abYt6BPjZkuKoCpjwx5BX8Wnyr3+Z9OMELWVh6eFpvgY1S7nPGXIzKo8o/oyKjvhMjsigk49WAbLz2fIZAOhVNaAQhGNQh8X9IXZWjtAAtD0/t9BON15asd45/ajwgz3Ljgad0vLYwoY7VHIhHUsxNlw3jf5akYIYQLJjlnk+zUkAW50IPyfX2oeWrNoBVoly2zoHKyMmRre7CiC6ZVRIAM6QYHYEP+WWNyth2hk4vjQ==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PPFB4730D036.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::4a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 15:22:17 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 15:22:17 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v6 0/3] Improve checks for valid_fqdn in send-email and update documentation
Date: Thu,  8 May 2025 15:18:40 +0000
Message-ID:
 <PN0PR01MB9588B04D666EBB98AE6EA378B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0065.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25a::11) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID: <20250508152203.7173-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN3PPFB4730D036:EE_
X-MS-Office365-Filtering-Correlation-Id: 719262c1-a415-4445-c3eb-08dd8e441d7b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|8060799009|21061999006|19110799006|15080799009|7092599006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QBSoL0DM0dKq/fxJ6EDVhLFLG5vKGGlR0I5oAxH4l4VTCp7xUMRhHvmv6mjl?=
 =?us-ascii?Q?Ts5jb0qtYNdaI7hjsdf01wqHvELe2NIvpeCmkabYjXpHDolrJ/Bgya83VI55?=
 =?us-ascii?Q?bVnEg5Hc9YZ+BqN9QIgnKdqUtc5ands89TZxitgLm3IS4zrQMcP+IcHa41T3?=
 =?us-ascii?Q?yDku3PLSE1soIVqEG4YpHTHAYtFshpIW2C2owgW6WD/CEE/nnKRrVNMwDz0r?=
 =?us-ascii?Q?U30OaZw+zuAlerd27KJSkYkzhOm4Lw5u7IjXGOmhfIjKzWmNMgXtCQmvHVsB?=
 =?us-ascii?Q?5cFnQoLBnMLjMmkd1YJK07UQlVCSt4034mIOt8aw/viw2J5ZKE0lpSCEV9xL?=
 =?us-ascii?Q?xpZbQjx5K2BPkwiWw5PpPy3miBj3fSMjw7jr2VFLjYUXP7MmJsHcN9rb6PYS?=
 =?us-ascii?Q?eiVbzAzUevNGu7s8/w+11g+Tuv+FYJpj6NEvGq/dDwRqpNXeniyQ9v5dQlw6?=
 =?us-ascii?Q?Q0lMcHdTtOfPl+4o5mywMglYddUpR9xJKSEO0C6wNpSqnLfSKLoZbHx5smrx?=
 =?us-ascii?Q?A6Su16rQM+4CipaK9LjQtA0niqi1lCLG1CQBXDziKbPj+kw4ubkgmFvVMzke?=
 =?us-ascii?Q?DRdSVxn+Ej9UNP/Q9m9zjkWOdUJ8UczCN6Yqg46bmZQTHTXTnLrIQpFwZ3NM?=
 =?us-ascii?Q?8LGz8CyLH247rLNtngxPer3gh6WgTl2Ll0rvfac72TU5zXgHyUyA74oLAKyg?=
 =?us-ascii?Q?S3Qv/PVqjWQRdnrL4TdwYtOkskJmLGJmCvVUYKacYxRjMEqQTFZpUkO03RdK?=
 =?us-ascii?Q?mVPB8Dx6Oa1gBonEaf6N5lnR55aRSlJiDuAbVnolwIh5bF78lXTJK10He90A?=
 =?us-ascii?Q?CtEDegJfdQqcaeJnjaYfP0TfaBUj9PUIHy2XABeHWdP4tMPebVAQT87r/jvo?=
 =?us-ascii?Q?s2Pj9tsuYvm+szgYQI55QNodGLGJ15l3Yn38ihAV5M055BTbbBl9nIopD9ze?=
 =?us-ascii?Q?p34DR79XiI2lt8gqlIOlVoQ2veFV5wo9LZEC8WOW6d5EjSaRhQ2h7GtBIaNV?=
 =?us-ascii?Q?giYfDc6tbhhN6vLMigcsR7WEODaYfPLKODWXffb7hZNEeGoXscLXlWpRyQuZ?=
 =?us-ascii?Q?MlAvEJI3ifC7NeF4TkH+RhZLqQK57tslSOQqfb5YBFP1AbLZyTpsY2qu2/6H?=
 =?us-ascii?Q?Bx4hXlf89j2gJ30x5D/9YEdjQe9in0y04A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+cGcDNj8Xy7QkHh4mWwyCRQlF2nM+BbqKmmdKzPoiz0bhhUzR2fYGqyKsMpW?=
 =?us-ascii?Q?UcR7gMEsRE2TaEo3aa4AL5ikXXGroxr2GX04WyTtXjnDRbNQgvCBW3GNAOp6?=
 =?us-ascii?Q?E54hPiswaqE8lzJ9Do0tSKFRSl2RNoLm+L4qfe8ZsyCC0wPoF4Avw7HV13Xc?=
 =?us-ascii?Q?41Q1emzLEtl7+buJvDCqDIdBhkOl6cNqo/LmTW7Re9QeFzhrzVFq/D0Ag4RZ?=
 =?us-ascii?Q?bSyHurPDqIoCBQAYCz42XyXuhn0ybr/clOyfVTz/mZV5IvPURtpuKjAODLhj?=
 =?us-ascii?Q?udaFvvNNDqKk/978k654Gh2WkivtFmW8oMZqp5tcjuK3c7km+TbYBqNpFt6X?=
 =?us-ascii?Q?8MYXLEC5j78F3njehtEb/jryiii76i7gZeaYHenPMYfBWGnyUJLqHopossKB?=
 =?us-ascii?Q?HAM8Mg7lttaetD2b8wRebrNamPEyPE1Htrk7MI7+qjkqG8zY9ArXYaUvARa+?=
 =?us-ascii?Q?EHmBI2sV6dqhBgRhRrK7eseB1SUN45G4GiNK6xZJXA2nsxGm4OmYRhN9c9Of?=
 =?us-ascii?Q?4bIX30u9XFNE3SPpNHL4cJTVKwP/uCixLLzVvJBEh9ZXJXf+d9KyOSjAnC2U?=
 =?us-ascii?Q?Gyz9PhYbOpM//ZxVWykjwqYUX2VQoep4VbHajJ/KYAT2Da0QRj6YyPShCreH?=
 =?us-ascii?Q?9sC5MUom6yYfwu0UOBbZEla6w3Fh10V5h4czBB/KuHE3ZWnd7eBMwJlJF5a2?=
 =?us-ascii?Q?IqArhg0yclcr7zuaoF5+XmithCziL7S+o3g5+ymAdoU+tpmNXJ2u725fr8/u?=
 =?us-ascii?Q?iOyYB6dYK1gzkX14LYCUD5AzjzvefoAJE/ZQ4yvT8gDF05MRKjhFnKQ+YHqu?=
 =?us-ascii?Q?WSyz5/PYeUAgKWpm70SIGZxX0NwPjTrTVRNLmDD8g1FYK8MUa3ou6L44ac1x?=
 =?us-ascii?Q?j4iE1LekA80YDB/7nynNitUBeNoi45v5apAe+ABQq8CE0NfpxgCWrd7vT6A6?=
 =?us-ascii?Q?FUCmXdMga5BIxjMNu5iYuqtzqWMPG0e1vdlFfDViDa9u9eYbPGrFKibbU/lM?=
 =?us-ascii?Q?v/IYP7yKN42BOFUeTjT0pLlcMgr3tm7rxT9z0aPi4bkm3Lo5qE3XUP45EMh7?=
 =?us-ascii?Q?BIcnVKtTkiaIByrhkS2eEskn6takGL3rjUFIlVCjBMTzWF4jGiO3wIRODs0d?=
 =?us-ascii?Q?CbdWaMQCXdhpcBAeQNzziIJPnVYsZogz6+Noopcg+vIKX5R7TTAIPIVBgtH9?=
 =?us-ascii?Q?RLSeDcCeO0494CgIAXTA6bIs+cATzYDRMqHndaz0+SydcujnHgqppeDwdT0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 719262c1-a415-4445-c3eb-08dd8e441d7b
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:22:16.9080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFB4730D036

Hi all

This series of patches mainly has two changes:

1. Improve the checks for valid_fqdn in send-email to be more strict and
   compliant with RFC1035.
2. Update the documentation for send-email to include examples of using
   OAuth2.0 with Gmail and Outlook, as well as links to the credential
   helpers for these services.

P.S. I have used `git-credential-outlook` linked in the second and third
patch for this email!

v2: - Improve grammar and add missing "" in second patch.
    - Separate footnotes and the trailer block with a blank line in the first
      patch.

v3: - Change link for email helpers since old one was too long.

v4: - Improve log message of first and second patch.
    - Update valid_fqdn check in first patch to allow one or more <upto 63
      octet run of alnum or hyphen that does not begin or end with hyphen>,
      separated by a single dot in between each.
    - Revert the documentation regarding sending patches to a mailing list
      in the second patch.

v5: - Simplify the regex in the first patch to check for valid FQDN.
    - Fix formatting in the second patch to make it more readable.

v6: - Use backticks for ~/.gitconfig in the second patch.

Aditya Garg (3):
  send-mail: improve checks for valid_fqdn
  docs: improve send-email documentation
  docs: add credential helper for outlook and gmail in OAuth list of
    helpers

 Documentation/git-send-email.adoc | 63 +++++++++++++++++++++++++++----
 Documentation/gitcredentials.adoc |  4 ++
 git-send-email.perl               |  4 +-
 3 files changed, 62 insertions(+), 9 deletions(-)

-- 
2.49.0

