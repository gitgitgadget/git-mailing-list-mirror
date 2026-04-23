Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011063.outbound.protection.outlook.com [52.103.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F873B2FD6
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908334; cv=fail; b=V1sJcvM3bw3Om1SQLRoeI89JlHihMor6rlDTwL9/y1k0G8Q6t9J5c0ynBNfg0eqa4nC8q6u3iioORg+ylCjj6IonmTS7lXU1qs6OHW2pvcGtrp4mEDsfJ/N82an7ZMFA4qUt/QFw5GZLqQ5H2GahLAf81Fv0Rum0eA7YOPCZReM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908334; c=relaxed/simple;
	bh=JRWr3L+xaVyJ/cPBPH0FKFpeT5km5V6pL9Od1cIXOOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ubHox+H84hc3/7apLGCvq4vJ0Hr0nHuu05PORfcQ71m6dUrOGibBpMSPertqk4MxT7TgK+0060ZtvrxNpMyCp8Y4gmhANDmtaHvn9cbSe8GK9QmihB0ISTJcYqBHd8s8uHiAuYQ+6p046R3Iv0WyOdJTlbJzPzQn6x/YMMNfC8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YU23PVrN; arc=fail smtp.client-ip=52.103.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YU23PVrN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NoygZnK54hkUmZB/1Inhcjh7CBPukX0gtBrzuovay4amyudpl6xrSer7MInRb2JuccOFbZ0GVow1sFxwjYyIwKgVMRTbi1Bd7j/XL1IPhpi4GMG27/rBzf+ZZMJrW2oqp5tFndnnUCJiGOSmFUhEGzAT3fZmyRz2R/p+4lDm1hL818ZvNvXsLQApAJ7sxQrDWY4+IwNQeQMkyWllYXQtK3DnCSXET+suBluy+4gcc2rnggKYxcZii4+jpHX8L1xkcmuf7Rnf2eCoqDWi0+r2rLmElposQFQF0hL+IpSFxtx9A9IbM0/lb3WTGgzrsqcoa8hwLho9SK+Opx7DNZuNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1QcnYErocD8sANzFkyjxbNqZbIhLnfrHqjRYPUIU0Q=;
 b=jJg7NlCGedL90nczTjTHiVAf5NCMPKEaDGOnVlJ8h0OMt3fGe2u3Nnqs0vAEVRQ+Cvf18/JIPCYS44Ajfzbgqu0rpv4bSm6x3Z7l3lwDwWxHX0/XQ59LA12jofviKjmsgxGGKBq/i6SQtyEoqanpOv2an8pvcJQSfG1T/STaMQ/uB9MnOagC7jEDl/YKDldVLzRbqUhZKKSlBjH4DeUHxXymtHM6dOByxG3vcNzzgAPE4e7Tp7FLti3oc67O9zdKiiybTJp9NCiGPeXy9V8T6YOAxqhvWxluiAG9aYfUz28p4icbxMBZuaqtEKFjvLUDpRY8vnJf14IR+WMHBefVCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1QcnYErocD8sANzFkyjxbNqZbIhLnfrHqjRYPUIU0Q=;
 b=YU23PVrNeXTWIjxwCzzS1U0d2cgwshGlaoOp+8yAKP2jqapihj5nXgrUiv0UM+b/hIYY4rDbmSpDK9Z/49qiTwz1PyAHJBdlTNmiFi3AOA2awyRlMcKcsZWFpEtFOziMKOZCZSYROxsr0yB8lAenPop6pfwzkwbN/jWVaIRB7yn+LM0fobSCKlVAq2+RULEtHvfBa38EbOgNo41cqlXu02HhoI726sO6VexlS7XDQuB2OAQvVJem9tzO654tm5WW43GN4We05lUhYiDOntikLH1dyEULdvszEAkUF6YdiAzPHJxA7ZwXsUe2E2OlmpjblbOwXYwdOiFrdDw5uDWFfg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY3PPF5F39D32ED.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::498) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 01:38:34 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 01:38:34 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v6 10/10] doc: document autocorrect API
Date: Thu, 23 Apr 2026 10:38:00 +0900
Message-ID:
 <SY0P300MB080173C8CA87881A110E19FBCE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260423013800.82156-11-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY3PPF5F39D32ED:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa2f168-e3cb-4e66-1085-08dea0d9084f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|23021999003|25031999004|8060799015|19110799012|51005399006|5072599009|15080799012|461199028|55001999006|2604032031799003|16051099003|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FRDChiFFZG9N5oCe31I6OyF5Xw2u389eQmjc2Oni7zbvnvlhbmGi38TNnBDS?=
 =?us-ascii?Q?THMVOUKrWhr2+1foSipXOCR15gDyo5rTqN1QBO7pWHa7tKPnqUZSQ+7tclx7?=
 =?us-ascii?Q?mesiLoXCo/XXL7SumcZoVdqdD6nbyVhVG+frakCSDt+WFay0fQTAdNZeQ+vT?=
 =?us-ascii?Q?ApUzgcZkuzUNxocG5FYW2+Hpa2ELBEL2fTISiaOb2LZ+yM+H5R40y2oKRJlG?=
 =?us-ascii?Q?XtJMVE2Qt+9hrGRIajwRa7EyKfd3u7MunY02krV0XPkllNH3LaO+H8IVV1Ry?=
 =?us-ascii?Q?B4PWCMOOiyME6ktaHOUePx85gVm08CQr+NgvAcQ/aS6VBqXiFIFxf37/WCbH?=
 =?us-ascii?Q?1oyMdU5jLC2WZ6tRXPqtAcSQcGcRp2MucFTaspejdqDbEPRY16kZ/zkcbELp?=
 =?us-ascii?Q?Zqi2eL0+MSguoBmPC7N4dvB3/wBJPNs/Bge369UD+ttj8uot6bPjCJS5qYhe?=
 =?us-ascii?Q?mUugotJuOtcRUGeUmpKCwlnWR2XkkESlCNAadIyj+FtoxiWoGLdoEpzHOgqI?=
 =?us-ascii?Q?SU/XPTTkB/8MZtZ3foXwifh+/vqpB9ZIYwy7gM6TLvnoyI5NJSv1F52iASPV?=
 =?us-ascii?Q?N2xLIigyohH19VBE1sm34IaBo0papr79oMs1AZgOO8ZrA5Xpuq1TBRBrjM6q?=
 =?us-ascii?Q?fXuj7DyzKNIFrdFHTm6RJ6mU2SZcnpmw81hfPeAWz39/x4M2zl103E1hOVTt?=
 =?us-ascii?Q?KeSfesA5AmmLpyjPFN9K29zli13uOFSy3bhK6EeizJE+xSWgBjHGnymKPbdQ?=
 =?us-ascii?Q?dQGhkRAb2P05fB/wPLuVCtfC5+YHVvnurqeWjFaMHf3XqjafjPYExNBnA8w7?=
 =?us-ascii?Q?V+poLpiP0W449VwpNApVIilyfLCNZiDiT4q/pzQg5FhyEwm1GKnD8+vYl6mO?=
 =?us-ascii?Q?D5j/FrDobzUOeBCKcfzAalCRMbxEl/9/cH4LEyEJekG8rGzjMOXNHGWEtlQs?=
 =?us-ascii?Q?mjU3vd2tqpya1fpx01+9kxq+iuyNbkMPT1xrYFeMAKh7fD/WYkPywyWKT5Or?=
 =?us-ascii?Q?VKt2WLj4M+QUGdHUkj/krnFX/lcmPhj9dtNBTtJhjTDSB5HbLKWTEFg/3Yt8?=
 =?us-ascii?Q?ObQChypdxwKcb5NH6PDVkAn6wxpttdTvWOKp+dPcoi+oDprG5gc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VWZquDudJ+3DHPwGMK3keKUebTKjAx38+LWR+j3lkF2ZyFJHH0UT2JqccyPh?=
 =?us-ascii?Q?IE036Fngh2KhI6T3VzwMis/ntnAoFnZlELv3SxX8d+RAof0zuNJBPjLY0dfX?=
 =?us-ascii?Q?ZQtEoUOdhdxJVs7qFEKz0zDbtm25/zesehXE6sxq6/IJXBtfYr5xJQ5VLE0T?=
 =?us-ascii?Q?n81IGUaAnZmMkWTU+rFlE+OPOfNuXwVqtxywzUrwj0V9yn+33e7ISczSgEGG?=
 =?us-ascii?Q?2EGa7Kq+2w51RFG4ivAylaelRWYBX7htgM1po8LL8ERGWbKes5HSELzANOEL?=
 =?us-ascii?Q?2HaQ6SHwsui8FP2EdRME+5zGOZGlUdU1YIU2cZkGX3ptTivMYFeKnZUapnm0?=
 =?us-ascii?Q?roEMCZWhDi6UT180+n+X1JOaFct/2kY8br9cmCfrhYUsAn4Uo5xLeZZ9U66f?=
 =?us-ascii?Q?kMHOhwkGeMEYvrfmlftTGf1USLtdm+gEHjZ/8cpsOdVunFJy7LqrShok69Ln?=
 =?us-ascii?Q?TXnQiq05xJonyNFutMxCuHuxjeTGYUhrgVcUR7xLZ8U2VCr7uCpUugnGJGLJ?=
 =?us-ascii?Q?4/afu5F2bdwgZAyQzPREWrvwfy4FqvAcDeozUQufEtajRYx/yDsjEqT4aqmN?=
 =?us-ascii?Q?PhUSQ2e3tU6VeTw8A9KbOYZi7sJ0zZ2cxmkelHGOs9/zGvsiE85ROFGMcc0I?=
 =?us-ascii?Q?iCJvdSmilBuI+vc/PT2FvZvRNJ7GkLKkbXz6IcTMrLqpkQ6PLVSeQ5/JDo9W?=
 =?us-ascii?Q?/J8q3KaAADgRSNsbe4eUuvPYxwdhtVSkRK+LLbPuLh4SrowxWTN40rLzb33L?=
 =?us-ascii?Q?jrbcyyMP12RQOi8Ro58/cg5VGGk6tCrnzvVNeJbR+mFZPZZ2lA8zcpe3wd1i?=
 =?us-ascii?Q?e6DxDsjeBPM/Vq0CYc2d8rDFQM9G2/WlcguTxqVdlB8dnRGi2rnSHuf2fxNF?=
 =?us-ascii?Q?35aXqfWiPrd/U569PtSqW/dLU5FcS/Ddeu6ctpmIvrJzqQYw/dSb6GpFOElp?=
 =?us-ascii?Q?v/iPEmo6j70Tbts4m3dIwT64+OWbCcxpemLjB5A3vplNSffXTiFGfD+o0PpK?=
 =?us-ascii?Q?hTtZgIn7YGt4AzhtvQiizlSweOoPhtsXpFMS8IvJiPmrXvGw0krL0zJKFnaq?=
 =?us-ascii?Q?3ZfOK02QOAhBUWxmZUseboQi6HmskgjoMqjWuPGQvBmav62yURgWozcA2RLA?=
 =?us-ascii?Q?Ll8RZQEgRoLKJVNYMnJNuQZAXFllh/2UrvxRY5QIyVhCv1SrEukj6cX04ic3?=
 =?us-ascii?Q?IzXpVG3+0uju57jUEj0aG2SfJzPbh46TP1BHenc4sAMQfYUivGHSiT/UuV3G?=
 =?us-ascii?Q?vIQJ04vx65o63+1wjLbXJ0QvvnoCODlnWurDX82k5TpWP69kGdEbtMeTn6G3?=
 =?us-ascii?Q?6tWv62tykqTbLFCMtpTzVS0PuLi0Uc88PYOvevPKglCvK8JVzOQ3iSZbKmfD?=
 =?us-ascii?Q?TrHDDMtIdgZUWmgLwxqQZAwLgNwR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa2f168-e3cb-4e66-1085-08dea0d9084f
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:38:34.7598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF5F39D32ED

Explain behaviors for autocorrect_resolve(), autocorrect_confirm(), and
struct autocorrect.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/autocorrect.h b/autocorrect.h
index 14ee7c4548d3..5bb67cf6debd 100644
--- a/autocorrect.h
+++ b/autocorrect.h
@@ -13,13 +13,24 @@ enum autocorrect_mode {
 	AUTOCORRECT_DELAY,
 };
 
+/**
+ * `mode` indicates which action will be performed by autocorrect_confirm().
+ * `delay` is the timeout before autocorrect_confirm() returns, in tenths of a
+ * second. Use it only with AUTOCORRECT_DELAY.
+ */
 struct autocorrect {
 	enum autocorrect_mode mode;
 	int delay;
 };
 
+/**
+ * Resolve the autocorrect configuration into `conf`.
+ */
 void autocorrect_resolve(struct autocorrect *conf);
 
+/**
+ * Interact with the user in different ways depending on `conf->mode`.
+ */
 void autocorrect_confirm(struct autocorrect *conf, const char *assumed);
 
 #endif /* AUTOCORRECT_H */
-- 
2.54.0

