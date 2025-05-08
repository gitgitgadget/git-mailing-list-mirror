Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3DD22B8B0
	for <git@vger.kernel.org>; Thu,  8 May 2025 10:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700462; cv=fail; b=UH3bNbULqm2vBx14885F+vRWAfQC5rIPhEd1VE66G88qggVXNRYzkmby43fdAKBe1Ig52iUwEzNVrdWfPexi+cxJHEebFM13+9G23+13Lv4//TfEQ/YepShR+goILXVUTI+hXXFkDxfuABjm+QDlV858AeJv5tE0txuIBqRUnN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700462; c=relaxed/simple;
	bh=xLPWcPUqkE4/EgBTepSoaukeVUglqxtaBz3eqPZsMtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YxcyJaHsjXxFNKwMdCi9YiAF9xoFJXGT4mvkg6sWmrkDOd72lZeCngml8zGUNpOE0OZr7r5SS//I5+IP2OGzamh74QrEiWnp2F+1BefXSpr35oqQuni3A698xPdUg6ufGAFuQGvTyL7zhCq3bBFM3BEL9/Nr6o6gxwvurITpj54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=BbXORRty; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="BbXORRty"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZwvE2lV/xvnlOBG25q7wn31AEvqDzwJ1LfMgcuajeZM6PEAULGl2jgnQSinQ/rvm3fg0xvFwcURoTmwTQVjBaWGKeWaa5WZVZaGvEnkxJIIWT+zN0N6GByx2DQ6wgzhksrVJv5tU7w4bXmWO4/oV8HXQJI9qFXCpZsg9BgKneecSBhaBX4zdNn+etVP5BblMwF1pif80Eaflb8vViTd9yyOMzrSwih35qHzSJZX0pWgwUdPu5KuUZ76MXeIUxt7Js4gG3p8Ss1r4l32dGYQ5rxdO9B+q2v7LL7OUGUtq208OFzfQv3Gp0Z/RVOUilX6kPPqVKAGVkdHVv8TAcH7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6ypactJjV6OOCUj37Td6uLvOGKx9uv5fvE/Jn9L3oc=;
 b=ms3cTru+AW62981Cm4ImR+G6n7x/Pr6gyxsNCbbOU05ZJHPeDOePZcLJ8B9+GRSxYZZV+NiQuHZrz3Plq9LBY4WwwpUrO2ywUDIEW9YUs/H7yTayHTdjY7dqZBrgVFmywSrEer1ANDchpsLF/1Pi58YBkeaV2sS3INGhqjj26UGLn/SU5M9It1s2qs1ZHyw7zJ04mQd9US5s/ewt1yYBKl2Ne5UbqfSCnQTrCQekIaaizLWB2uWLXcnrxzjTqBIJXQYmTwYOxIIEqIRe2RsWX21YoraVHGDV5YUv8vSoJOZ6unrKQvbQ63Tk6Tzb2inl8dGS6XJob7LyWAOaIcdFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6ypactJjV6OOCUj37Td6uLvOGKx9uv5fvE/Jn9L3oc=;
 b=BbXORRtyfq/J/1oX+YH5z7iKAZI/l3wi8bDX5F1s73W/dY8xhZRouV4nyDFWYLn1zi3q/MyqTeEkcT2eJmtw6HUgcCb/LiW6Te6f/th5Ku+HESkm3vD54yVdEldDfDeEMzc6yd6U5BQy9Wt95cxCtPTn0A/t7xOnQHAbekczEansPTTbsqGe3dg9X3nmFVjWhi9PPQm7G4/Y6iENLmRS2T98Gq5Yswdhbd2s+Whj1/ia+urJyPgf+SbrSWp3rNR9HDqo79AktJIx/01diLXEtwXPQ8zNqpNNhgM2dWLbJ45GvmERnoaXIEErjOE5oPWQIekozbpzHqXrhAKICi0rbA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB10139.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Thu, 8 May
 2025 10:34:11 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 10:34:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 3/3] docs: add credential helper for outlook and gmail in OAuth list of helpers
Date: Thu,  8 May 2025 10:31:58 +0000
Message-ID:
 <PN3PR01MB9597583235F2ADD34052BCE4B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB95974932FF37D9F24A7633C6B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB95974932FF37D9F24A7633C6B88BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN0PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250508103358.15409-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB10139:EE_
X-MS-Office365-Filtering-Correlation-Id: 679d0604-f8b0-4684-c22b-08dd8e1bde60
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLR0Ybdxcp7KTbjbpYD2CblCbpJcnjg2/0xeKvlO0iOF8p6Lwcj3c0ah/ydrz9ijayeKk1aKHORixU+/zbuoFw+FV+7kH0EiqG/rgvrNQO1Z0+siJZoEsx0b0hr4CnrtVSEB9mQbQ+K8Aq8pn8B+Jlb3rOoQSHtEyvsNPTt8MHLB3fbJ00WJvuAkqLrQkq1ArWZ4XD7Q9rzJpHQzHbxSg5zQ815SlQ/C1NR0szEs86cqlHLq8fjSf56bXV5peYBqNMc+itmNehY1UaT02DRY8cKqZT9kvdPoYC4Ot3Ff5KXpkbVNOV5HUGScURL9env/784leSHUm8jM686MCUw96yUA0bOrRGYWTh2Ndm+DAB3sBgA88kQ9/3IqczEwMPBAvAKmLclHLcEREgzaMGD/BK61EfcRLTN2cTsJrFrvpVaT5OPj+/O+S29qlSXIozqRARf9ziSwlN/lpBqe9beGZDFPKcehCnqVyF4cTOXl+n0M5GboylgAZ3HP7hheVHb7xnCE6/zRVVzwcOB4TX+4VmOPnmCqqTgUdhGv5xmA022Pk4udd6z/dA2ZnlHw5dEOpezjGpJfZQ0Q7Z9p5WDytNex7vD+Orhetxp3aagQFcwOetK0prgDTy5+OJxa0M8BXdD5FV33z88q9Pppq+z74BLVQk38vLnANmDxZg89i6gEjbe6ZYCoY7OejxC4FdSgTF8wRHgjnj0+1gltmOzx2Sa5u/nsds4U+cmH66dy6eKnpOj2b1+5cboG/S8HwSpP79A6c1SGKV2RtF9LYuZgnALM
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799009|7092599006|8060799009|19110799006|461199028|5072599009|1602099012|440099028|3412199025|4302099013|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CYc7rA2a3TDArzbNOUVHrWSbFM1raKlkudiidwVYJqMw6cxQ6G7xxDcBtrEF?=
 =?us-ascii?Q?Eg0RgXss59afOiLok2KL3/9dRyCToCO+hMvhNElnEpDpL9IkgfHtctLnfwPj?=
 =?us-ascii?Q?qmfFxzFbYweuFDtYVBAs+cor8YP7C/iO9pnZ40c46SwQj/raM6kCSkGXFkoq?=
 =?us-ascii?Q?JXKtGWGr4Ru0o/fk1gsGniTmrr3EZp0xokxW58dHrSMaVcAAuJeDZVN2gCMf?=
 =?us-ascii?Q?PlmQqawVcZcnHJgknSaQA/FU7LNrOLc711+xUS0dh/A/tX+W0q8iN/BeaqPs?=
 =?us-ascii?Q?MOUOyj7s/e4snfjc+JH1I+H5D6t1DALVBVDCD882j+hA483APp19nbi1RQO8?=
 =?us-ascii?Q?RfW9FLz7aHo01bi2yE1XgLzXs+2EF8Dns3xPxjCJLAtCQVCEv85ImsTduWsL?=
 =?us-ascii?Q?09yLeX6qBfWtBohUYGwM4Mb3YmnYu/r5LeNpmHzA1HcdHCfL/zwxhE46xtxM?=
 =?us-ascii?Q?5ThoUnl7TYUcSXRvXnFQzlHQbeY9R/i1/2I48GcuwcJmfOGSv3jMM2gcpjLC?=
 =?us-ascii?Q?T1DhxRJyxzObUkkyncGSnsI678QAEGRBGgdb/VY3ob8zZlp4Ii7lVpDHn3Wu?=
 =?us-ascii?Q?vdUvOTy/G7g2CtNlTH23r+xKX1/90xP3SGRWf3LR/wdfREvsvOISaoHwPNd7?=
 =?us-ascii?Q?ztcfjdgQtWOS+6Lldn3F1lJD1AdxUpylEDb8XoKXLoMS3n1pXAhtTCkx5WcN?=
 =?us-ascii?Q?OJPWeZwM8Xc9QGj13XenUjaY6a1IMJBygYv9N/QoQn6j1cMvKORZZcdgLsHJ?=
 =?us-ascii?Q?uTf0C5xIPS7TadRpIzI3/KhJCfCBWb5vedzdU/L+YVyzsGWFMuWLih4UfT89?=
 =?us-ascii?Q?mItbOevE7RwVwQxWPZ7YWu+EnVGTus2D9PYFMQM+awaSYqwcFQWvK6iSyJSB?=
 =?us-ascii?Q?p7JfEG7Zw1SNTYFmzQg6d2XJzf0ir4ePRp19UXQwb2i4He6voqWAlrRvMwbF?=
 =?us-ascii?Q?LC2E4RxVhLHPpscHM3Gz5o65HGol4jSjO1FDkpNEILnJSQzT3xN5/k9aAbVp?=
 =?us-ascii?Q?/EveO2svS7+lN0L/8cHrNwoivNQPr1PU/iZ4sgT49FoZ2zvIUU33bRf53nHI?=
 =?us-ascii?Q?xuSzmbv/e8m9ca8Ovy6bFu7G7AK0PghZ8FAHsKM9J4uhAF2TZqRoYE4ImDly?=
 =?us-ascii?Q?7bRrCnhnT1h0e/+EhBJVBYUUvCL47PUUy0h4ZX6KjfZ1+ZcgwXAdfTUgFdAP?=
 =?us-ascii?Q?r2YZNSdDpjgg7VoBEsW4LU+Sav/xZ6t4wJisTcxhkcmWtG1hl6JhI8xVGeDA?=
 =?us-ascii?Q?FgBWsYRCI6fyG+zvlZEM?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?do18o4K84tmwRxMXOmqeW2ZbEz+W99LuTMNTdGT73RkbZETkB9sI7an0FKOM?=
 =?us-ascii?Q?BPsluznI10rrfm2H6o40aUS6EUW2do6ybbJwlJ1wsnTrqViMd2UUmv0wFZ7G?=
 =?us-ascii?Q?Hja0TDhonImiitI/S+QrVzat1T48Il6opwJY1GWPtwmebuZLgFBBu9p6iWnh?=
 =?us-ascii?Q?Wrq87+mGALkS/8J6b7K38U+sGLQmTlunEqr+9gek0AwtORTcRYFJnl5rhNs8?=
 =?us-ascii?Q?TgXep46/GI10Juv0XmmdntTo440KaqtL+9/3sbt1NjjRAUpvLzWGeD6CJ6KC?=
 =?us-ascii?Q?FMhy0yPDqjL4Iu+XJsINQrZV0Ez6V5YS7zh1bfhzoKZsIYhDjNLy3q2xBTfH?=
 =?us-ascii?Q?nhssc5LfRfQyqQW/sTlESC3qBlXk3btXdHCk4eKzsniTX/0VZBLcfkzlK+2C?=
 =?us-ascii?Q?2ktj3x61nn6t+pGjv97ddu1+vItN3/Oh1vrAMn3ZC/GwSqEsdrHRuRadCGS0?=
 =?us-ascii?Q?1kMH10z+PpRMDP5sDJTfMFQNRnqmHMfkUl+GPW99ojGxcd5BuhOJ0/UNFEUK?=
 =?us-ascii?Q?Vpwuu7cFKni/EEO2V0dOOa/DaAC/54rKdOB04Kw+DQZsiRvK21/a0r1hRrPQ?=
 =?us-ascii?Q?sPev+1UVnUHujZcOxcjKhXWvP9aEzdW5JyVrfWWuUiKuDMLG+C0n7qijZT8A?=
 =?us-ascii?Q?1ig2XwPkh4znPD7XSQ3noGaFPr5ErnM5bbTZaP2gX26jPn4UAngLAPPVABAt?=
 =?us-ascii?Q?Zu5Vu1GlZFI4tvWirWjnHWMfHt58CQKLNWbNvky4t8xh+FaIuORKDwnUcXkN?=
 =?us-ascii?Q?/jbGrnrTusn1TLbhlSfPmN8zX8bpKf0/jeZZ+TQxYizoWdmoxnHFwHMJc59r?=
 =?us-ascii?Q?0LTUiAcX6rIwNWDlSMmqPIdfysdHmcAyajl6ZhUSt+XIDb7Dl/onGFo8EL5C?=
 =?us-ascii?Q?JvCLbRCpd4a+FQsqi3wNBraUt1enlqP9Hngt2gFmyPicNlvvuTnWcHXOm9Fh?=
 =?us-ascii?Q?BrNQ64Vt+MnGB8G2VP9OotBuU7UNZxPqFo3uJcu8lFd9S2YJDgzzJs3OmrKQ?=
 =?us-ascii?Q?fEawdlxqwRxyN29ZPN91tIUYUh8PullmsuKDD1z1P75h6BKUvwfLrPQe5kmp?=
 =?us-ascii?Q?1fOwxtMg+atK96aEu8yopWLmtBM9svwHZl4E7LW6EcZf6JboISCyFmgYcgCn?=
 =?us-ascii?Q?dCnd0FRx/RJtCt12oKvwvAscyr6nG/y3wZsXfUnzfFxgMmiDBUAIe4hGIZUm?=
 =?us-ascii?Q?dTPPA6HaJuROY2cM3Fi32GinuGSakOe0hcjhq739GT79EkYnJKlAgBh2Ehw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 679d0604-f8b0-4684-c22b-08dd8e1bde60
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 10:34:10.5183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10139

This commit adds the `git-credential-outlook` and `git-credential-gmail`
helpers to the list of OAuth helpers.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/gitcredentials.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentials.adoc
index 3337bb475d..b49923db02 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -133,6 +133,10 @@ Popular helpers with OAuth support include:
 
     - https://github.com/hickford/git-credential-oauth[git-credential-oauth] (cross platform, included in many Linux distributions)
 
+    - https://github.com/AdityaGarg8/git-credential-email[git-credential-gmail] (cross platform, dedicated helper to authenticate Gmail accounts for linkgit:git-send-email[1])
+
+    - https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook] (cross platform, dedicated helper to authenticate Microsoft Outlook accounts for linkgit:git-send-email[1])
+
 CREDENTIAL CONTEXTS
 -------------------
 
-- 
2.49.0

