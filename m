Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795017598;
	b=p/mXBXITyFKtK3H1uKJEnxtDu4DLsfK9G/3VQlcRB7vUb8IECBOMKEroUYT10NPSEHzq
	 83/nPDhrUljpdPfjINAlUEpg7LM8wjDqhmCFkzE2M1v/QUAk4FNGDt/qlsDKiIZx5SEUz
	 FY6EF/Ll6pjvFyyjj/377eDjD8hU+pg+Hj59bqfsIYwpgR7uSv054nBfufhPjFKhQs3HU
	 U2YI9J7iYwhhFE9Z4rqJIKG53qkbD5LXL6NOI/t+t2u/uLSVY87nwMTu9nTp/eHqMDh41
	 OSmCpta6XTwNPzjwx7GlbXZGuP09ZSndXjMmY2zl6d82XH5+onlJzL9ULqN4kFTdxPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017598;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID;
	bh=FSoKfnrqy3P11hsUJ9ad5yIQV+pS1DeIPcBxGbKTqq8=;
	b=TC5jeJHqZUG4B8D/xrFYsX+ZD7YNuNE3L9mwdXsxY3XW2ThnaAE7QHLn0KYMNqs2HxLc
	 SzeUBGlAxx6rSiB0odkgxU1oD1k8O36Q8ptgaq0p3Gjdfkvxycu6bCESF8NOMZIcgyenf
	 d7m+ck4soGAxZ6f+S5F9IdCqov/xx4XCaTu5SCcl9ao7r1WYzKkKgcas+NWM1PTO6uzgd
	 x+ueYYMMuFhCF2ZZ7G9hJbgMFF6qM16QfeWap+485VuS4Qc2Xb1iJhhGLuYK4tVrVsn/r
	 DyKnd99+BH6Zdcfm7r9+nH1N8Wr3TUw+Ys8wUQQeuwhtdIErIdhCrOwv2IaEmK+2D0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b="ZGFCd/FL";
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=boRLjmIJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E125606A320
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 15:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E125606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=ZGFCd/FL;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=boRLjmIJ
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIE3imc2337443;
	Wed, 18 Nov 2026 15:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FSoKfnrqy3P11hsUJ9ad5yIQV+pS1DeIPcBxGbKTqq8=; b=
	ZGFCd/FLLatSPOadt+fQY2KYDRbOxEaIkY5BiPEvdYxy3qE2z3FYeL7ACWC3W8dT
	qW5kqFLFR2R4I76oLRyQbleTYs3CVi8vA3ceV0KiF8nYY1tzqWikfnydWK2FUEJH
	cbSW/D4r4EU6+ymuiMC6GCL60n8iES6qpXnznGk7FzlG5l4P4hoP2xPQ4YuXp6Gb
	zZLQtqgzCU4Yw9fLGqKHdMYskNZGYZvXA09KNqTYxUMzDVEUi3Ui2q6+zjVbKw9E
	xyzsBYK3SjmQo9TDBk4nOuV41Z7DzKWEOVimVwqloKB/M+hnQxNjO9NPB5D3RJMN
	N2y/wdUEZ5qD6ox6ZRBNdQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j0yts99bh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 15:59:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIFjLLZ1972668;
	Wed, 18 Nov 2026 15:59:54 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4j1cwgp3k6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Wed, 18 Nov 2026 15:59:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVplKPtoarctAOKEZGbg53uK8xeYgQH2hV+AaBEYpO+3LHIiarU2gPi6GNrp4G0gahnQWi8awUem9IarQ/L2nBkYzUjxPVQ8ZKP+KBlDnJZwry6Z3Zkzv1Wl8o9vfmttd+5WLtrCCzr/d3sEO8NYg38V7DJnwtd1x/Ovg04wC8mmAvsRFwJ2eD/LJRR+cirVZoBaLAshJ1LM48j2BYC8KN2zKM+FgCMIm4zr3KBUB3bFOiT4uWV83rwX60oe5pLSkSPyB+WoJbgO/vABkXu8K9+43tnJEvdMn7whyPaOTgch0jPzUmHRutJblHJSjaWtcl2N5I8Q2w3Fr9leLYLY6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FSoKfnrqy3P11hsUJ9ad5yIQV+pS1DeIPcBxGbKTqq8=;
 b=LEe0D8YoTz5n+HboXnj2vC2ComuNKq9vB+vFOr75kYkFAoFsKCHGLlHn+bPmTHJfnOIjzOul0k7eOIpOmejYnqy1PJXo6szzXwKGnrWTB+nLyhnt4H250iKdbSKkooL21I/s9qIB9d0l7CrEtRtqQ/N+8g+gbn7s9jAaWNYlUvykdMQ14dqj+AU98es5eDshW50wvT3YQ1sOY8fVMGQbpTc+hxMSs60foL/v52iC/v4nhr9ns+LjD3x8hVC4r1GFJtop09iktk/IuGGyNdr+ZZAXus/eo0wHgrCaN8XH0AbIsYK4oPV86Vmq5EGFgzYd/175FE9c0GjJLGDvPqKSYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FSoKfnrqy3P11hsUJ9ad5yIQV+pS1DeIPcBxGbKTqq8=;
 b=boRLjmIJsDXVViJS0JJiCeOlWHp/G0tcNz3OOwmEcCqFoQLvPvUF0O8HQzXfOivuPV64VXRhghxvu1Z6BIbwX/P0b4/cP7cFM5mjgXv6FzfFdRi2SmbexN0/dITebhIlP4/k/MhKDUBwFghAYwcBXxAWX9S5Clea/NnKduUiOBI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from SJ0PR10MB5785.namprd10.prod.outlook.com (2603:10b6:a03:3d1::7)
 by CC6PR10MB729833.namprd10.prod.outlook.com (2603:10b6:170:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:59:50 +0000
Received: from SJ0PR10MB5785.namprd10.prod.outlook.com
 ([fe80::75ac:f00f:4fe:d1de]) by SJ0PR10MB5785.namprd10.prod.outlook.com
 ([fe80::75ac:f00f:4fe:d1de%3]) with mapi id 15.21.0615.012; Wed, 18 Nov 2026
 15:59:50 +0000
From: Jakub Kulik <jakub.kulik@oracle.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, Jakub Kulik <jakub.kulik@oracle.com>
Subject: [PATCH] t1017: add missing quotes
Date: Wed, 18 Nov 2026 16:59:35 +0100
Message-ID: <20261118155935.60345-1-jakub.kulik@oracle.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <xmqqik21hiqi.fsf@gitster.g>
References: <xmqqik21hiqi.fsf@gitster.g>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0338.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::11) To SJ0PR10MB5785.namprd10.prod.outlook.com
 (2603:10b6:a03:3d1::7)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5785:EE_|CC6PR10MB729833:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a08799-d78d-471d-e3bf-08df458cf9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|261021123027099003|261022113327099003|261021135927099003|261022075727099003|10067099003|56012099006|261026135527099003|261022115727099003|261021133027099003|261026140227099003|261028144727099003|261021130227099003|261022105027099003|261021121427099003|261026130827099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	l6awbb9hMznrsWWAZrM/Ona/B7E5nUHY3jc6l+tCsCueOVlKCucTPnH5sWaXSF9ePsidxX6bUHnwWCfCEjyMefLr3aYA9FZ8hjW34bY8mCini3Z6IbuJdbxhO6RzBIj9/0dPdwhPXHX68HMSWpmNhTILPTS6X9PiXz10HDhLlJqKZl8TxSyGWGn/27E9cF/URqgduGZ9ybfo/1UqpIws4DHkjL+nnGtHq9IkJ1x+fvShZAAHzTib/6ku8bkxUENkae5Y3K6Py8HL1QaVU9M5CsaMailDIxQb7+OBapAExiXu4ym46pCWiRq9CjZ4zXPpc7ALsOU5ir0oFY3r67jTG7eWhSGOaulGV9wYd1NodRazy4F/XsJHeiV4vzhV6/od5V+WEJkG/4oTQszmgX2GQsJzReZHLkuN9bjUaF2hYqV5OFDCjXO/JECIKblIY9NqsOcCY4nE5UWbuG1kNA2aZ1AxWZ/I3/OI0O/pvf74qSaKhFvIoncZgMgmZuKS99E38IyiDIN8/YqcBeBF8wUTrQcjXtwff3RAtVXTOqkNKeE4ikbUbzk+C6e2YxsPdHgr1m3/yp8nOjki6OcrD9TveZQe01VgNH/S6RF4FVMOP4gGDfFHO31xr0bytu/eXyPl2YVRbuhpLtb4N4J3aOm766I6hzLfVsDPbT889K2eaEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5785.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261021123027099003)(261022113327099003)(261021135927099003)(261022075727099003)(10067099003)(56012099006)(261026135527099003)(261022115727099003)(261021133027099003)(261026140227099003)(261028144727099003)(261021130227099003)(261022105027099003)(261021121427099003)(261026130827099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z1VHnQTi0saNgGin9lw192jhTUTbs+i8vOsJtAqMWardSBEX+eBI3KVv/k18?=
 =?us-ascii?Q?tCy9GRzRxllnmpGM4vy84T7Naqp546fV1ZWLTSpXdARjDHZPf0fAjizJ7awt?=
 =?us-ascii?Q?dS0iM+Iuz2cuyHeuBWEHzjhzJmnCJQfVmEGbkDlkQ6NHKeTwahYj4tA9pqhd?=
 =?us-ascii?Q?i7BLIlpf+r+Z27fdilTyvjqg1Ke1Ib3RRN1d/EzbmIxMwjxzw+ifwQhfV9t0?=
 =?us-ascii?Q?rrX4elQcB0VwlfhnFUV9xcqqjbYeGVvK3hMTm08s6NRqoQ0f28xQsu/zWS+K?=
 =?us-ascii?Q?HzOxIwKoTQiu4bdk/8OEzQREd45ajoXu4DK3L5FsmbEVYe2rOgNJ9xfIjGBG?=
 =?us-ascii?Q?Ir3tUn6KEAMxIzWk2yBVzu9XxfD4TRBd/eCLsS6xfm0eidzlB0wA+6iHPb98?=
 =?us-ascii?Q?AyUTg5vZomsqIf+bt0ajq/9J9Vf5mjRhtgry24ctXU2VTLVFlIkSztazZYMZ?=
 =?us-ascii?Q?T57OiuUZ3Dt18Jw8fgFy9b8UArZnbLeYJsGxv8Dt+fYQ/9eXcbqOudYAeBmQ?=
 =?us-ascii?Q?6K7Kt6qinWJ8wXdWyRn53+mTDx0DnqNTAdP/TP9X5999a/q8VOc4y0AM1qqR?=
 =?us-ascii?Q?DC/BA0fnnB5p3qK/jiKPRf/XG8+XgeiLwPAPCiN0WhWYl3GQiiK55UQt5Eze?=
 =?us-ascii?Q?u82KPbcKphxoJUCYVU/47uIGCQGu9Hf1Q2/pCxYqh3nWFxJjt3x6HguxzTlX?=
 =?us-ascii?Q?AQwPGhE8uxagtqJtdICCPBfj78Ha/evOFkxShzH9OqL/ZOdpMkTw9ouzn5m0?=
 =?us-ascii?Q?2UpsvjPYdwb4X4d+xewMbTPevJlyaFBhkLkHHgF5ATtB56gcaShMU5lGyINV?=
 =?us-ascii?Q?Vjk2OEUa7I4wkMbT/Oxjpt9xsZrHfRKo3DSG+4DujFB7QrxXjOpLv7MSOVhe?=
 =?us-ascii?Q?rViPzz76mc+eeFNciaXnEzgmHi3nbuxvNp2jbasHdbD19HhansnCGCh45nTR?=
 =?us-ascii?Q?85M9T6eLqi0MrWwn3vWvDC4pDRbLFQRD/sat3F0WAejHvQFkmQc1pFePRsi/?=
 =?us-ascii?Q?5zaJg7ikmEbquymuba9/DzXp3KqGNbpZ3YJFtVrLUi7vmyT6jiLKnQP9etrw?=
 =?us-ascii?Q?udiEA9w+6xFCEbmYewABFwgMFn67hFx70og4EICKicLghqwBBmwbf4feKT0x?=
 =?us-ascii?Q?Mlsi+so51c7jcsv/nVBHWNk427oRTKxYmcHmODiYmEcrCXojQZV30lEWZlyD?=
 =?us-ascii?Q?hr5bqlMfpRMn8hV61Dcqxo5JsUBXN5lR7sRi+ywycMTywHNH9lizb9LtNTuF?=
 =?us-ascii?Q?2wwQ3z5MFI2KGrF5F8BKkyxkRF5Y8echKV4WhNqS9wBxgx9/iUwaBg8FXOxO?=
 =?us-ascii?Q?vP3bYwRvxrV/p8hwd8ZuBvZbmldNDjxfrejrmKYH2/tOe5YeQ83zhBg3UbEC?=
 =?us-ascii?Q?XPJyKFigVOyNYWDQQujH01XKpwXRz+OnX7nYIznXjUeaZDFuWL41x5fI0Bck?=
 =?us-ascii?Q?NwHCEz+D87LwEUYfPYzHjBFEhU04fahOrop3NNNpM9ZWLDBz93GhqQaoAZ1R?=
 =?us-ascii?Q?slRvOwJuFNdsMn29GmGege6oYrt7uMRpOMvnH2Jcon5FSEp3EqELt1zQv6XC?=
 =?us-ascii?Q?RkTgBL3EiO74PhnFnXKwUZhBPEqvowyOZLUCHGnkp0Y9/rCC0sQzcHWeZBIs?=
 =?us-ascii?Q?e80X2psH3dWPVt8/uHC8J1E4c8SJphpzmuV3u1fPFLsbppMynxycZR4s8Wzv?=
 =?us-ascii?Q?DKwbfys9m5qozSMYSJmHWkyuz6+I/ckjQbF/KiRwegH8+9Cy5yyVlSQ7kVEQ?=
 =?us-ascii?Q?aj4doBB+rg=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	oXc3wjX2tkTM3s2ZwSBazZx8dyz62nZ7O4R2U+w/hIp59EW5fXKq+OPqVARYVXcBFsEoJyFCZCs8iOkPnN11vhX1G5UhgHAi00ZXg4k4qrkACrqfX5Q2NQIsszs0nGnF/zfdq4vPK7GocCV4xw1b6DBr3OEzemGNQY+XtIz8GfmBnH3+kJv1MgNgEbwN1XeGwhcwxUf1hVDWuGEOka+aIcmZR/6Gf/cqU3aF/4JYBgfegXfQhHXi95oSFS7Tuqsuly5MMJjU0DUbKnl6ncAjY0j+05QEg08fKq7PzdBJIrPjegjRO5Fhzv5t6b9A5OUbW7tppIFqTtZmDYArIhmC1g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GqWbozIsAnPPbq3L3bmt4M4Z1+wi38iui8ZJ2G1oYnsVGgkTCXLsHBog22/g+Ze9JUZs6weOjkzeSVB6ThfyLXES3P7ZyzloMU+nTytYjHYhdEjTqxnrnE4thhHyMN0IewHL02yYbjQUbM7tg67UQeMSDtq2aTHegobwvxPD4ZNkn8JW81gNUhOzkWUNaeT1GTZwMY3mfwCATf9VXau0+eMKpqQpVgUCY+wfw15sA9kO53og6FrncDAONTrYVLdKCk4eNTy0bcJvZKYTo1sAbqmIyydImcYjKj+0q4u3l3plY3uomwMaOJqwIYvCXD/BxGwmlSANeCrCPE0JG2seMExfCTj97u63hY3AeKLyRHpxfqTcfIKig8pV+qfv2gIggolzZE+crkv3dCliXy9L9YI9HdiExIdLaseKCFOQC6O8p9wpUNkSOf7JWoNFxZdHMGVxuiy14UILcu54zmXfYSNc6gPXrizki6U80VJ/fIzQFH3wDAUm0M7fP5rCXQRoyv2Glx+LwqPo/GTSC/HUR/T2feb6+RjSTmWZBO3BTykNTKqI5ejYoqZF2lDG16RjUZ3mJjNyTfgbi20qCkn+c+AB83pKV0apFAq4AbhicH8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a08799-d78d-471d-e3bf-08df458cf9e1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5785.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:59:50.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azFm4wWGillYVJSCYV209lgNJv+L5E+sF5mB6fslEOj1QKANKCbF2u6nkmtPrBBLvWhA3/u7bnmRqGWGBUlcTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR10MB729833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180063
X-Authority-Analysis: v=2.4 cv=APpTTis9 c=1 sm=1 tr=0 ts=6afdcb7b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=4TrZ4asytSZga1RBp3kA:9
 a=lqcHg5cX4UMA:10 a=z2U-W3hJrleVIN9YIjzO:22
X-Proofpoint-ORIG-GUID: tVJoniQU_nOHk8VrqxcKIi-ATTj6cFDb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MyBTYWx0ZWRfX8ynTIoU6fo/a
 N2bF0pDiY8FB8FI744dzTB5nZDXfMmvzZjl168uIaczSlPnWzYzbX+UqfPvnA8gkJvnIslVETSK
 eQ2qoH4+UrK/16uRJ+NWFgwtak8CLGP+wNxQ5wA93TwHDYJ3sW83
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MyBTYWx0ZWRfXwQXiMyImt5+o
 hQ7HX/MibK+zLtWg7QULPqRHTD6283rPFVHa0xF1zkMSxbf7H1QBGoQXJ+4Sr19DhCjcaenvL07
 OjP55znNob3i9U0PdsIANK96gqcVyHn60FU9MOZlAQDR/Ntl59reYVVE9icFZFbiZVzgW8wEJ8O
 yTv4i48M6xT94g2XDZ1JIerVmzYG8MsR3EbE8xCvT80zYs5zi3zlQXW4bypjX2mUOdYCkGigNZw
 2zxRwb7oFopkN2owbrCQ5IaZ2zX9axp9rECvmy5BmdTlnj/wxnJTOkYI7f45inFn0TZmqGVsEzh
 0IXMqw/3/8ngQ3Ia83lCXRQTH+mVtXCisQBUcUROxYoVRFwX/rD8RqOiM/0HawiGVzGBoPwVloB
 +/FZGg2rbdB9YJoeL9Lvi1KNWwfE5naIPivfz2oFwqo6WRQvhndsmAP7V2IfYlV0mYDh+bXaZrx
 jvhrt9XWIqfxx4p+s9g==
X-Proofpoint-GUID: tVJoniQU_nOHk8VrqxcKIi-ATTj6cFDb

Signed-off-by: Jakub Kulik <jakub.kulik@oracle.com>
---
> Strictly speaking, POSIX compliant shells do not require such
> quoting for pathnames that are used as redirection target.

Indeed; when I run it with `bash --posix`, the test passes.

Here is the patch with space between > and the filename removed.

 t/t1017-cat-file-remote-object-info.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
index e2919aa061..8a04cfdae8 100755
--- a/t/t1017-cat-file-remote-object-info.sh
+++ b/t/t1017-cat-file-remote-object-info.sh
@@ -69,7 +69,7 @@ daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
 
 test_expect_success 'create repo to be served by git-daemon' '
 	git init "$daemon_parent" &&
-	echo_without_newline "$hello_content" > $daemon_parent/hello &&
+	echo_without_newline "$hello_content" >"$daemon_parent/hello" &&
 	git -C "$daemon_parent" update-index --add hello &&
 	git -C "$daemon_parent" config transfer.advertiseobjectinfo true &&
 	git clone "$GIT_DAEMON_URL/parent" -n "$daemon_parent/daemon_client_empty"
@@ -519,7 +519,7 @@ test_expect_success 'create repo to be served by http:// transport' '
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config http.receivepack true &&
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" config transfer.advertiseobjectinfo true &&
-	echo_without_newline "$hello_content" > $HTTPD_DOCUMENT_ROOT_PATH/http_parent/hello &&
+	echo_without_newline "$hello_content" >"$HTTPD_DOCUMENT_ROOT_PATH/http_parent/hello" &&
 	git -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" update-index --add hello &&
 	git clone "$HTTPD_URL/smart/http_parent" -n "$HTTPD_DOCUMENT_ROOT_PATH/http_client_empty"
 '
-- 
2.51.0

