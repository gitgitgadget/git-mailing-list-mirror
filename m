Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E83385D6F
	for <git@vger.kernel.org>; Sat, 23 May 2026 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779532810; cv=fail; b=RYMLBDMlU9gwXmebDtjxqjEWsKoa8ZMfr4T59K6s/GNU3uzLlcF07V4Qtk8KcCZSCpGI8tyNqJKM4Qo1qvsFlhWbBEsyQqBjlyslP9MkByTDqubDh+5kZcxFCSwTE0ru0JTpeZjolAm0TXGvAk2p+5piMsM/dOTmyXlXa1qtbT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779532810; c=relaxed/simple;
	bh=s0rnZZklgsrx/Ad9PCkF7ma7Qn8pXs6UrGmGjQs4PhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RhAH42iWseHKt5bddPVbX1zb4G5CwoyQlKZ0UM7YGNS0RtP1ugvFAatchnW87ZVY5tTOmoabM3OkgzVeO8RTUchbRQVbsKl7KOXeAxh25q+EFHW/Sav1/XKJJuG6P+k4XVnGUFYJS67PMcUrEv7CZ90V3udqnshApyCl7X5+pFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ex/sCkMR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=maQQgme1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ex/sCkMR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="maQQgme1"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N8pGNn3387232;
	Sat, 23 May 2026 10:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ssagK/XgcJdT5GYf4qjjR527gONXZABvoqKyD7Po+iE=; b=
	Ex/sCkMR4gRzPFlbZni4oiW7ZbNwcSO3gNgbGDy0NU7pJUV5Q6JxwiJIPxQntGkf
	dpDax9ts8Zfk+xJ0i6Hcos2BWGCOEX9J9BVA9NqumegypGSbg5akGRmjHc84RTIq
	vDavJ8+XyJOsyjWr/uoVH8adAySaHjV8VjxPqnXY4WeSHgPgi2Rk3ou5yW0oAP3f
	1bzCMRv3tE7mMMMdXvQA6wBbvDClm6uu0F3aPH/fDyRhmMjkpkOJcPUPblt3EHow
	cdKRckPBKIN3nRl1boqcflsoRye2UH/I2ISnuT4pw4H/t3MzhUKo4M/1vXpNIlMe
	nQQNZ28drBQ2ZwBB3SVNxg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb48c06yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 10:39:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64NAdjZS000638;
	Sat, 23 May 2026 10:39:46 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4eb2p6rnad-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 10:39:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcI7+jL+LoGtaephL9dT10Elzk9xdwTViP8DPeSSFEoU+P0Bur+ug3nn0vTptBBcUIht4pWRPevGCB1Rfy7+gfjkQoGghp6TD7lKzavFkUZoRtH0bpM2WN0rC7kTydUQnVLd+GOOvkv0vuMfalu2JUHTUxyHNfPsQcPXRgp4WJrures4/geW0yYskn4k2wtnPzNxJFUwZhaNRdDMuRU0VNpc8QqqbVCyIoJO8hn6Q2vQ0ljsNRVoj3GBZ7dvjJMhqNKIUsQA8DXB1gZ7vxFpYKM3xXSUOHPy7vHdI76B2Aa+zCDclfOGjMySWFC7WJlehl3eIju+RlGQXj3hwZnY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssagK/XgcJdT5GYf4qjjR527gONXZABvoqKyD7Po+iE=;
 b=bcC91r21V47kaGqyAI+d+tlZEwE3ch12rjuLslMNXKGf249u3zk9WFAMek4IQLQhsxwL8DWqDwax2S/Kqs3hybojwLu91BDIoaFnmkmCVzlxIPQTfEV+rJ5EpJW2URAcsyXP0BeAS3LtfofwwpWhlFS5XKHWOFsCF0EBsBCZ4LXyMgWjZGsb+VzQIOAKj/4zHvWoTsLv6xIseabB+g1pivbLpSXItYj4bS/25uaanZ10JUFdHd2MFjD0h3Xb1Ts76WlbWpCXRJGU4vtodrqzTNGbDQZnIHtFTnt1wyulErr/J6NXFNvim1um6DZ2Yzmjb5i1h788zybU9RAbOKDFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssagK/XgcJdT5GYf4qjjR527gONXZABvoqKyD7Po+iE=;
 b=maQQgme1PdtBMW8uXnKHVYyupwlSY6QOB2jYJEB/+TnSh4iq5QqECahhWCgc34c++lD0t7ptWK32D258f1GKvn53Jls4/LhE3tm+1wFndHynMrWrOtJjxEbxQehmBcpATiOwoxmxp1PqTvy1BbklmmhK9JLZxxDJUBMgzhv8oDg=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 10:39:26 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 10:39:26 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 4/4] notes: support an external command to display notes
Date: Sat, 23 May 2026 16:08:12 +0530
Message-ID: <7284a8bccb6bfb5734adb09f05ae4b61a63da2df.1779532562.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779532562.git.siddh.raman.pant@oracle.com>
References: <cover.1779532562.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::18) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|SN4PR10MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e43efc-9457-4689-195d-08deb8b78f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|6133799003|20052099010|22082099003|56012099003|18002099003|3023799007|5023799004;
X-Microsoft-Antispam-Message-Info:
	MJ5VNXhMKuq3rBrk9xv83+ZeXq0HRJuUvG3sn44Z8a7S7qDQHNXz8KgdDCurmy6nyADDydxaRF5cwzcasr09UzDJhNoCmGCcIX1KjNeKaOCAak9y93FjSn68G3vi06nNSqqjIggMUkX2CaEQ0KEY/8Wn2ycfZv4I3Z4SokXy6+js6Hv+RdTaVRlkVuE1+PAjynR1WhICyQs8bhvbnuuEFQQVzNQSS+ctzRjAFtC5l2j5t4l+wgtUswuPD88JPf34EILiyZt1+vDIYFG6uXu4rQemliWCM9yhwHMF4GkqT4c3Ak7OOakjpprKFEpHSlL13bs5gYFdr3phLfnf/oJU72SEHCd1kedUvlzL6ASY1+l8vvodbP3MnSItMlF4E1shtDySlfTM9A+yH2yuHdjB3tcxVPuDYMVbWY1KTDSJsjiIQt8YKFxR0yPf2Gvm1SCH4sMye8VrTzd/M+IIFtZKRiOP0Og5HX5aYu0LmC+hmZHhaXR86+HSk+sTx/A9QUyP06vwyhxgtJG+4s+nchHDTMmz2366yYxwCXJsipGnysZhTTq+ALEROk4Opj2pYuTnyKXqEHSr7DGhUe3r16YS/GRbfO3ehF8697UUIU2ctjDgZIy/y7xaifhB95oKiNqvRS2pNgDolsYPBSJPQrAC1ePpXSyYxxAQMmQtKKn2Ys4F1WPTjvVz8RA0+yLgz9N7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(6133799003)(20052099010)(22082099003)(56012099003)(18002099003)(3023799007)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8bLRF7/QT0XsBoIEArntlmqLE7AOgQqOFXzZ3inS83D6yuubyOuzlmdOmJ5N?=
 =?us-ascii?Q?kDzppxrwD7OFr7eyKrMEtSDieFfhLVRH62EZFljVCBrjzuIYqGTYf1Enhk76?=
 =?us-ascii?Q?HrFPIUr0uDpiTx2e0TBhtVVo4abXBocM0AtcnPkbWaoPpNJpAn+MBjXGBx7a?=
 =?us-ascii?Q?K0FoyXKob/AeLEym8lqWnU0qX+F0fDT2slL1Cfmvp9IrsTEgIJ1m42Ny2CcM?=
 =?us-ascii?Q?WYeyOtMvpGkBW+XI7xt5uzxzBrKDqK9Qh7XxbqejzNM5dUUO7Lpe4A17Yh3R?=
 =?us-ascii?Q?FVBuMGiM9cAWUCoZvv1qbcWKtyU6PZ15zW6M47T3uzo54rF/Eplnk3xerXhs?=
 =?us-ascii?Q?kO9kUuO9jeBSbR1BcEGF4J+2nSDKofiderCvxTIDmYIRvrcpzmpy1nWV9q33?=
 =?us-ascii?Q?PJxCYWfg0ktCj82gxLC7Ttsw20b1MhqFjTD++KdjVTauok3DPvn8wIFmmN6Q?=
 =?us-ascii?Q?HnjiWoOX5ZemUct5FUcnLPyl2exLbUqE/rOFH+11VXjb6+9VJCVzu6a+5N7H?=
 =?us-ascii?Q?tpvzL1X8tDkFtA+zPGHJtMppYzaqHXv45scWnqXREsgCSErpba0+dLreDXjn?=
 =?us-ascii?Q?2+BkOhyJn9X1lQHn5FfNVZy1MSuQnUSrxFxdVjU+iiXAarQJ8rKjBBQ6TQq/?=
 =?us-ascii?Q?asQ/K9Td/ArKvL6PADd2jh45ayZmVAlJ1SGh1pmKwHThGN90dxnzs/jWRm0R?=
 =?us-ascii?Q?oMMJ7P8IANmMyWf12/iwqxajwYQwKH3r48B9dlmxTlUZh6j37chIB8TlDU4K?=
 =?us-ascii?Q?t+hksL93Wjw4BvW4e83EdkhUXu7Jnq2c9gFJypcSH5dtN1WgbEtl+4f9LBuO?=
 =?us-ascii?Q?pPm9sg52DInViQ1NumvKnUzRoEUN/DlJh3MmBFT16fYuSftSz3N0CCRo8hfX?=
 =?us-ascii?Q?wd8mNdWkEbzXaJ5G7+ffHf8FosTEPcer0KNZstS0BBrDn49iV3Se3jwnqsQe?=
 =?us-ascii?Q?T8AEwOt1pQmShkM4FmBpyMrjzbf73OYLe0i3kQt0tTZ2WTL7SJS1o9XhC/ai?=
 =?us-ascii?Q?qcZD6KxVcHiwNVFlk+Y6+yjsV3Ea+snn4TV32PkmvH3ruI4QPKBAkVjIQ4sh?=
 =?us-ascii?Q?omYdsXEvZY3Dre1VGdo7ijyWnpgiX2TS5qHFRpicZ0S/yUleJN63A2Ux7/BU?=
 =?us-ascii?Q?gRjAsccG8Kq/lbTHHH/nzb15m0grdOEw87grsv0OiWYtRUlVQ7SQrrJ4ddDt?=
 =?us-ascii?Q?QjXTgJbZx9HLtzXIc2cQEV1YOhbiMpTSu8ZkKx4U8wm/hDHboJZQbnEq/4Wt?=
 =?us-ascii?Q?8FPNdNaByfuGVCdzHNAATgVr7BoVHQygW/KYuRY70/Bemjti7xfE18gVaPvI?=
 =?us-ascii?Q?frAZk4sJ+myg4FwhYLynBwNvC54ywpBkmFQRKEE/ofgB9aLzueAY8akz0EYG?=
 =?us-ascii?Q?bvXJAduwCGNudfZZxY7lMOJu33Wg/LWKTZOBxUIjgrNzcCut+BYkjeb1ATC6?=
 =?us-ascii?Q?L6Bhl8ppFk1wyKZg6SJNLqll1Wz3VKqtHtGkkGmp8dBOQlngGy/3OYrRojdv?=
 =?us-ascii?Q?9jdpCMgBPvecdIERnRDFmlnyAnUHO7AfEfNmUgghxe19tI7TWmmB+XeVfBpF?=
 =?us-ascii?Q?8wVZnTetfpjzh52yXsBnLE1mGyh8AG6/DoiXz2Vvu9SV5iGtq+aP5/kVwRA0?=
 =?us-ascii?Q?PVIaTWyjJXFjWcqNkLaRlxNV3hkw0dCFiKF2Qg8LCSZNJ/y+doO3P/gRYFXg?=
 =?us-ascii?Q?aI8+b3YemIZMI5jbkZofO9oqV+KZSqNQImRyOi8ytD1j3sXo2sw2lObIHtu6?=
 =?us-ascii?Q?jZwx5NXOH38ln1ypR/er5guxSinHIeGFlwk56emWNW3KkHGDH1X0FcMVvl60?=
X-MS-Exchange-AntiSpam-MessageData-1: 9s1iccSGNtziN5EbhUo3PMry5zZVs95wGQM=
X-Exchange-RoutingPolicyChecked:
	obvKn3+UonL/ag6ic4lUMivLPjjbhtINaZ3Avyy/nBDwlHSNAKie9Bj6Hjd12+BqRQc36hk/wTkWBnQNuO53glVdTOUYxkiO4JkbJzz7SrJeuDT3d9OJie/ZP6hrVcUsAzkE2opdBUzYDeSLb8+xeBlz6xiJaigNfYL/mEiQSPk0d+4n7LUGhkF2PEjAWhv971tPifZOH4T+QVwqeyrKaF/TO6fL1DKPKOnTKIiRzyfCfEFDfqbk5YbeQCPa4YChJKN+Mn+oW/wegEkU+p1C/b8YsJgxfEbv06E2TWivyTe2p+XwAIDas8GhzRMOTPu2YovcYesTLvEO4n+FMzJrQg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R5mX8TRD35bHX+9kTFpUA5UrFyK8UE3bVb8auoTfN4M1lgBUEAAi8lTPxSCLVwm53V9qyg4O/M5Z0rFvw9JB/NafcAyxFfO2bP7F0LdTUxX54i1doq2KLXTW0i6O2f4Z/YjiYJH7VdfCvNf+Q40TWgEvNz3crrpgOXIxSIETKAvstKsADYTsGsJQZSTzvLYRFJ4hFt+3M4YtBrHKCN3pd2AcfLK3QcGY/9zZy8B83G6t/gKuGqZ8iWp/Vkm1KFnF1QiHZl1GxpF2KonMUlpIkUdAz5Z/HGAtCf0AqPl6iLS9sYD+f8z7G5ijL1gWWlHeOTTgxYmPDOTIgRaut9cwPI2JCNSRxJ5Ss+NHT7xFdc4RLx0UM9S/WTL5ER1+0HBxCDH/Ni1+mCHxC9CLf7T7cnR/C3WPfrrxKWPR2/yEeyF40jEqlgOjBcREy2N/tXao0utJ5Ap3qL+B9WIBIzQvNVBr3/I9VVcR0Iqfc0sca/6n8lY6qva9AhE3SAnon5pQOY1N6LsgGB2s0lBMqmj4ZPIoTALUcRVHor6bbgf72vui7EID9bcLHuywOKmMPWDLgsvKIS3Vwu1od9X3LuVOAPMVp86QG9mfVCYHferyRTE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e43efc-9457-4689-195d-08deb8b78f95
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 10:39:26.5237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gVGWkXqYA5LGclnf1AsJYEdONTh456YyXq29HK0jrKi/vsnipqWF4fgDXW6/Q0J+s8EcS65lz3Faz6DAolti7lzD1GHZhyEoP2cuv4YSO0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605230108
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDEwOCBTYWx0ZWRfX4yp2ceUe4Qyn
 3h0BNRTZ4DpWzJy1B1C2P5Ru5LaG7d6T1i/qOjnmuPJ1UpwbO0yXBgHxw6vwunW8FNW1/O52Yyd
 5/ziCW58O0JW3KfTVk7o5EyON7Wuf+64gqt3tBLfEV3TENqeI4mkz6I2G+7P6cR1lkv/PUqywU6
 TAL1/pvfU2WKiWDzc6b3Iol8n8MepiFrOaPeJzyCbKNrYRVuHPx4Wr439JqH3Fyl60XO6FC9VcD
 ga9Vv20Yt9qUeVP6qooFbSfwpb+GZpMzjrYuCYioCWWV0Z4yMZnL/370QKWkrSjcEQE4Qpaev1q
 mBQmZm/Yns+axAwsP2lRXfTN7KbEBmjyfirDkFjLynNa+2mNEzjbZINGRDnY5/FjgAqxNBEoTX6
 eCgZqOpKjppsJ0mbxrZ9lMpS0jShx1YKSXgTkz36dj4My4JwNND3cfXzXGqzNGZ7GOLX7ZPmX5Y
 YwFKradqtCvatsvVVsw==
X-Proofpoint-GUID: smJKl9jzdy1QPbAXJzDt_ux34h5FLfoq
X-Proofpoint-ORIG-GUID: smJKl9jzdy1QPbAXJzDt_ux34h5FLfoq
X-Authority-Analysis: v=2.4 cv=XfG5Co55 c=1 sm=1 tr=0 ts=6a1183f3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=PfZEu2nMSa5nMSoqsNIA:9

git notes is a very very helpful feature to show user-supplied
information about a commit alongside its message transparently.

For distributed teams working on large git repos (huge number of
branches/refs, files, etc.) and using the notes feature to mark
information on git commits, the problem is often not that two users
update the same note object at the same time. It is that the local
notes state used while reading history can be stale.

In kernel work, the same logical upstream fix can appear as different
commit objects across many downstream branches, such as the stable
branches and vendor-specific branches (based on which the released
kernel is actually built). Different developers may be working on those
branches in parallel, and a review decision recorded for one backport
is useful context for the others.

Today, seeing that decision in ordinary history output requires first
synchronizing the local notes ref, and then interpreting those notes
for the branch being inspected. The latter step is workflow-specific
and can be cheap, but keeping the local notes state fresh enough can be
expensive in a large kernel repository with a large shared notes
history (and if we are to extrapolate, a slow git server conn/ops can
be a factor too).

This TOCTOU problem exacerbates on scale (rapid updates, more devs,
larger repos, more git server traffic, etc).

One solution to this is to move the freshness policy out of git so that
it is someone else's problem. We can have a realtime fetch or faster
updation via external helper means. But unfortunately we lose the
coherence in the display of information, and so the user would end up
reinventing git log in his quest to have same workflow.

Let's add support for notes.externalCommand, a protected-configuration
command that git runs as a long-lived helper when displaying notes. git
sends commit IDs to the helper and displays any returned text through
the existing notes formatting path. This keeps presentation in git
while letting the helper decide how fresh note text is obtained.

We also add configuration for the displayed notes header name, timeout
enforcement for the helper so that git doesn't hang waiting on it,
optional --grep participation, and command-line controls to enable or
disable external notes. The new help text should make the usage clear.

Assisted-by: Codex:gpt-5.5-xhigh-fast
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 Documentation/config/notes.adoc             |  59 +++
 Documentation/git-format-patch.adoc         |  11 +-
 Documentation/git-range-diff.adoc           |   6 +
 Documentation/pretty-options.adoc           |   9 +
 Makefile                                    |   2 +
 builtin/log.c                               |  17 +-
 builtin/name-rev.c                          |   9 +-
 builtin/range-diff.c                        |   2 +
 contrib/completion/git-completion.bash      |   4 +-
 log-tree.c                                  |   7 +-
 meson.build                                 |   1 +
 notes-external.c                            | 414 +++++++++++++++++++
 notes-external.h                            |  53 +++
 notes.c                                     | 264 +++++++++---
 notes.h                                     |  33 +-
 revision.c                                  |  36 +-
 t/helper/meson.build                        |   1 +
 t/helper/test-external-notes                |  64 +++
 t/helper/test-notes-external-config-reset.c |  24 ++
 t/helper/test-tool.c                        |   1 +
 t/helper/test-tool.h                        |   1 +
 t/lib-notes.sh                              |  19 +
 t/t3206-range-diff.sh                       |  68 ++++
 t/t3301-notes.sh                            | 424 ++++++++++++++++++++
 t/t6120-describe.sh                         |  17 +
 25 files changed, 1483 insertions(+), 63 deletions(-)
 create mode 100644 notes-external.c
 create mode 100644 notes-external.h
 create mode 100755 t/helper/test-external-notes
 create mode 100644 t/helper/test-notes-external-config-reset.c
 create mode 100644 t/lib-notes.sh

diff --git a/Documentation/config/notes.adoc b/Documentation/config/notes.adoc
index b7e536496f51..023ec6c5d8d1 100644
--- a/Documentation/config/notes.adoc
+++ b/Documentation/config/notes.adoc
@@ -34,6 +34,65 @@ The effective value of `core.notesRef` (possibly overridden by
 `GIT_NOTES_REF`) is also implicitly added to the list of refs to be
 displayed.
 
+`notes.externalCommand`::
+	Command to invoke as a long-lived helper when showing commit messages
+	with the `git log` family of commands. Git sends one commit object ID
+	per request on the command's standard input:
++
+------------
+<hex-commit-id>
+------------
++
+For each request, the helper must respond on its standard output with either
+`<hex-commit-id> missing` followed by a newline, or `<hex-commit-id> ok <n>`
+followed by a newline and exactly `<n>` bytes of UTF-8 note text followed by a
+newline. The helper must respond to each request as it is received; Git does
+not send all commit object IDs before reading responses. Empty note text is not
+displayed. External notes are only used while formatting output by default; see
+`notes.externalCommandForGrep` to include them when matching commits.
++
+If Git cannot start or communicate with the helper, or the helper sends an
+invalid response, Git warns once and disables it for the rest of the Git run.
+The process is closed using SIGTERM, so the helper should not trap it.
++
+This setting is only respected in protected configuration (see
+linkgit:git-config[1]). This prevents untrusted repositories from running
+arbitrary commands when notes are displayed.
++
+This setting does not take effect when:
++
+--
+* the value is empty;
+* `--no-notes` is given;
+* `--no-external-notes` is given; or
+* `--notes=<ref>` is given by itself without `--external-notes` or `--notes`.
+--
+
+`notes.externalCommandName`::
+	Name to use in the `Notes (<name>):` header for notes returned by
+	`notes.externalCommand`. Defaults to `external`. This setting is only
+	respected in protected configuration.
+
+`notes.externalCommandTimeoutMs`::
+	Number of milliseconds to wait when reading each response from
+	`notes.externalCommand`. Defaults to `100`. If the command does not
+	produce the expected response in time, Git warns once and disables it
+	for the rest of the command. A value of `0` disables timeout handling,
+	so reads can block until the command writes output or exits. This
+	setting is only	respected in protected configuration.
+
+`notes.externalCommandForGrep`::
+	Boolean indicating whether notes returned by `notes.externalCommand`
+	are included when matching commits with `--grep`, wherever notes would
+	normally participate in grep matching. Defaults to false. This does
+	not make hidden notes searchable in formats such as `--oneline` or
+	`--pretty=%s`; use `--notes` or `--external-notes` if those formats
+	should search notes too. When enabled, revision traversal may invoke
+	the external command for many commits that are not ultimately
+	displayed, which can be expensive for slow commands. The note output
+	can also change which commits match. This setting is only respected in
+	protected configuration.
+
 `notes.rewrite.<command>`::
 	When rewriting commits with _<command>_ (currently `amend` or
 	`rebase`), if this variable is `false`, git will not copy
diff --git a/Documentation/git-format-patch.adoc b/Documentation/git-format-patch.adoc
index 566238245028..472b37e5237a 100644
--- a/Documentation/git-format-patch.adoc
+++ b/Documentation/git-format-patch.adoc
@@ -26,7 +26,7 @@ SYNOPSIS
 		   [--[no-]cover-letter] [--quiet]
 		   [--commit-list-format=<format-spec>]
 		   [--[no-]encode-email-headers]
-		   [--no-notes | --notes[=<ref>]]
+		   [--no-notes | --notes[=<ref>]] [--[no-]external-notes]
 		   [--interdiff=<previous>]
 		   [--range-diff=<previous> [--creation-factor=<percent>]]
 		   [--filename-max-length=<n>]
@@ -395,6 +395,15 @@ configuration options in linkgit:git-notes[1] to use this workflow).
 The default is `--no-notes`, unless the `format.notes` configuration is
 set.
 
+--external-notes::
+--no-external-notes::
+	Invoke or do not invoke `notes.externalCommand` to obtain external
+	notes. Like `--notes=<ref>`, `--external-notes` names an explicit
+	note source and by itself does not include the default notes refs.
+	Use `--external-notes --notes` to include the default notes refs
+	too, or combine `--external-notes` with `--notes=<ref>` to include
+	external notes with specific notes refs.
+
 --signature=<signature>::
 --no-signature::
 	Add a signature to each message produced. Per RFC 3676 the signature
diff --git a/Documentation/git-range-diff.adoc b/Documentation/git-range-diff.adoc
index 5cc5e2ed5673..1de23f300517 100644
--- a/Documentation/git-range-diff.adoc
+++ b/Documentation/git-range-diff.adoc
@@ -12,6 +12,7 @@ git range-diff [--color=[<when>]] [--no-color] [<diff-options>]
 	[--no-dual-color] [--creation-factor=<factor>]
 	[--left-only | --right-only] [--diff-merges=<format>]
 	[--remerge-diff] [--no-notes | --notes[=<ref>]]
+	[--[no-]external-notes]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
 	[[--] <path>...]
 
@@ -101,6 +102,11 @@ diff.
 	This flag is passed to the `git log` program
 	(see linkgit:git-log[1]) that generates the patches.
 
+`--external-notes`::
+`--no-external-notes`::
+	This flag is passed to the `git log` program
+	(see linkgit:git-log[1]) that generates the patches.
+
 `<range1> <range2>`::
 	Compare the commits specified by the two ranges, where
 	_<range1>_ is considered an older version of _<range2>_.
diff --git a/Documentation/pretty-options.adoc b/Documentation/pretty-options.adoc
index 658e462b2533..aad851c92cfd 100644
--- a/Documentation/pretty-options.adoc
+++ b/Documentation/pretty-options.adoc
@@ -93,6 +93,15 @@ being displayed. Examples: "`--notes=foo`" will show only notes from
 	"`--notes --notes=foo --no-notes --notes=bar`" will only show notes
 	from `refs/notes/bar`.
 
+`--external-notes`::
+`--no-external-notes`::
+	Invoke or do not invoke `notes.externalCommand` to obtain external
+	notes. Like `--notes=<ref>`, `--external-notes` names an explicit
+	note source and by itself does not include the default notes refs.
+	Use `--external-notes --notes` to include the default notes refs
+	too, or combine `--external-notes` with `--notes=<ref>` to include
+	external notes with specific notes refs.
+
 `--show-notes-by-default`::
 	Show the default notes unless options for displaying specific
 	notes are given.
diff --git a/Makefile b/Makefile
index fb50c57e4f25..898da8936e84 100644
--- a/Makefile
+++ b/Makefile
@@ -834,6 +834,7 @@ TEST_BUILTINS_OBJS += test-match-trees.o
 TEST_BUILTINS_OBJS += test-mergesort.o
 TEST_BUILTINS_OBJS += test-mktemp.o
 TEST_BUILTINS_OBJS += test-name-hash.o
+TEST_BUILTINS_OBJS += test-notes-external-config-reset.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-pack-deltas.o
 TEST_BUILTINS_OBJS += test-pack-mtimes.o
@@ -1206,6 +1207,7 @@ LIB_OBJS += negotiator/default.o
 LIB_OBJS += negotiator/noop.o
 LIB_OBJS += negotiator/skipping.o
 LIB_OBJS += notes-cache.o
+LIB_OBJS += notes-external.o
 LIB_OBJS += notes-merge.o
 LIB_OBJS += notes-utils.o
 LIB_OBJS += notes.o
diff --git a/builtin/log.c b/builtin/log.c
index 8c0939dd42ad..bed4c1576f2d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1337,9 +1337,24 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
 		   (rev->notes_opt.use_default_notes == -1 &&
 		    !rev->notes_opt.extra_notes_refs.nr)) {
 		strvec_push(arg, "--notes");
-	} else {
+	} else if (rev->notes_opt.extra_notes_refs.nr) {
 		for_each_string_list(&rev->notes_opt.extra_notes_refs, get_notes_refs, arg);
+	} else if (rev->notes_opt.use_external_notes <= 0) {
+		/*
+		 * rev->show_notes can stay set after
+		 * --external-notes --no-external-notes.
+		 *
+		 * Since range-diff's child log starts with
+		 * --show-notes-by-default, explicitly suppress
+		 * notes when no notes source remains.
+		 */
+		strvec_push(arg, "--no-notes");
 	}
+
+	if (rev->notes_opt.use_external_notes > 0)
+		strvec_push(arg, "--external-notes");
+	else if (rev->notes_opt.use_external_notes == 0)
+		strvec_push(arg, "--no-external-notes");
 }
 
 static void generate_shortlog_cover_letter(struct shortlog *log,
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 60cbbfb4b7d1..5a0e7daac803 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -277,6 +277,7 @@ struct name_ref_data {
 struct pretty_format {
 	struct pretty_print_context ctx;
 	struct userformat_want want;
+	struct external_notes_state *external_notes_state;
 };
 
 enum command_type {
@@ -525,9 +526,9 @@ static const char *get_format_rev(const struct commit *c,
 	if (format_ctx->want.notes) {
 		struct strbuf notebuf = STRBUF_INIT;
 
-		format_display_notes(&c->object.oid, &notebuf,
-				     get_log_output_encoding(),
-				     format_ctx->ctx.fmt == CMIT_FMT_USERFORMAT);
+		format_display_notes(c, &notebuf, get_log_output_encoding(),
+				     format_ctx->ctx.fmt == CMIT_FMT_USERFORMAT,
+				     format_ctx->external_notes_state);
 		format_ctx->ctx.notes_message = strbuf_detach(&notebuf, NULL);
 	}
 
@@ -879,6 +880,8 @@ int cmd_format_rev(int argc,
 						 &ignore_show_notes,
 						 n->string);
 		load_display_notes(&format_notes_opt);
+		format_pp.external_notes_state =
+			format_notes_opt.external_notes_state;
 	}
 
 	init_format_rev_command(&cmd, &format_pp);
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index e54c0f7fe156..41c27250404a 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -56,6 +56,8 @@ int cmd_range_diff(int argc,
 		OPT_PASSTHRU_ARGV(0, "notes", &log_arg,
 				  N_("notes"), N_("passed to 'git log'"),
 				  PARSE_OPT_OPTARG),
+		OPT_PASSTHRU_ARGV(0, "external-notes", &log_arg, NULL,
+				  N_("passed to 'git log'"), PARSE_OPT_NOARG),
 		OPT_PASSTHRU_ARGV(0, "diff-merges", &diff_merges_arg,
 				  N_("style"), N_("passed to 'git log'"), 0),
 		OPT_CALLBACK(0, "max-memory", &range_diff_opts.max_memory,
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index a8e7c6ddbfb2..146444e65860 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2023,7 +2023,7 @@ _git_fetch ()
 
 __git_format_patch_extra_options="
 	--full-index --not --all --no-prefix --src-prefix=
-	--dst-prefix= --notes
+	--dst-prefix= --notes --external-notes --no-external-notes
 "
 
 _git_format_patch ()
@@ -2215,7 +2215,7 @@ __git_log_common_options="
 __git_log_gitk_options="
 	--dense --sparse --full-history
 	--simplify-merges --simplify-by-decoration
-	--left-right --notes --no-notes
+	--left-right --notes --no-notes --external-notes --no-external-notes
 "
 # Options that go well for log and shortlog (not gitk)
 __git_log_shortlog_options="
diff --git a/log-tree.c b/log-tree.c
index 4503a42dde6b..f37c8b14e9a1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -856,9 +856,12 @@ void show_log(struct rev_info *opt)
 	if (opt->show_notes) {
 		struct strbuf notebuf = STRBUF_INIT;
 		bool raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
+		const struct display_notes_opt *notes_opt = &opt->notes_opt;
+
+		format_display_notes(commit, &notebuf,
+				     get_log_output_encoding(), raw,
+				     notes_opt->external_notes_state);
 
-		format_display_notes(&commit->object.oid, &notebuf,
-				     get_log_output_encoding(), raw);
 		ctx.notes_message = strbuf_detach(&notebuf, NULL);
 	}
 
diff --git a/meson.build b/meson.build
index 052c81f2887b..83845f84fed0 100644
--- a/meson.build
+++ b/meson.build
@@ -397,6 +397,7 @@ libgit_sources = [
   'notes-merge.c',
   'notes-utils.c',
   'notes.c',
+  'notes-external.c',
   'object-file-convert.c',
   'object-file.c',
   'object-name.c',
diff --git a/notes-external.c b/notes-external.c
new file mode 100644
index 000000000000..09da102a7901
--- /dev/null
+++ b/notes-external.c
@@ -0,0 +1,414 @@
+#include "git-compat-util.h"
+#include "gettext.h"
+#include "hex.h"
+#include "notes-external.h"
+#include "run-command.h"
+#include "sigchain.h"
+#include "strbuf.h"
+#include "trace.h"
+
+#define convert_ms_to_ns(ms) (uint64_t)(ms) * 1000000ULL
+#define convert_ns_to_ms(ns) (uint64_t)(ns) / 1000000ULL
+#define EXTERNAL_NOTES_DEFAULT_TIMEOUT_MS 100
+#define EXTERNAL_NOTES_READ_CHUNK_SIZE 16384	/* (16 * 1024) bytes */
+
+/* Configuration helpers. */
+
+static void init_external_notes_config(struct external_notes_config *config)
+{
+	if (!config)
+		return;
+
+	memset(config, 0, sizeof(*config));
+	config->read_timeout_ns =
+		convert_ms_to_ns(EXTERNAL_NOTES_DEFAULT_TIMEOUT_MS);
+}
+
+static void release_external_notes_config(struct external_notes_config *config)
+{
+	if (!config)
+		return;
+
+	FREE_AND_NULL(config->command);
+	FREE_AND_NULL(config->command_name_value);
+}
+
+struct external_notes_state *external_notes_new(void)
+{
+	struct external_notes_state *state = xcalloc(1, sizeof(*state));
+
+	init_external_notes_config(&state->config);
+	child_process_init(&state->process.process);
+	state->process.out_fd = -1;
+
+	return state;
+}
+
+void set_external_notes_command(struct external_notes_state *state,
+				const char *command)
+{
+	struct external_notes_config *config;
+
+	if (!state)
+		return;
+
+	config = &state->config;
+	FREE_AND_NULL(config->command);
+
+	if (command && *command)
+		config->command = xstrdup(command);
+}
+
+bool external_notes_command_configured(const struct external_notes_state *state)
+{
+	return state && state->config.command && !state->process.failed;
+}
+
+void external_notes_reset(struct external_notes_state *state)
+{
+	if (!state)
+		return;
+
+	if (state->process.started)
+		BUG("cannot reset external notes config while cmd is running");
+
+	release_external_notes_config(&state->config);
+	init_external_notes_config(&state->config);
+	state->process.failed = false;
+}
+
+void set_external_notes_command_name(struct external_notes_state *state,
+				     const char *name)
+{
+	struct external_notes_config *config;
+
+	if (!state)
+		return;
+
+	config = &state->config;
+	FREE_AND_NULL(config->command_name_value);
+
+	if (name && *name)
+		config->command_name_value = xstrdup(name);
+}
+
+const char *external_notes_command_name(const struct external_notes_state *state)
+{
+	if (state && state->config.command_name_value)
+		return state->config.command_name_value;
+
+	return "external";
+}
+
+void set_external_notes_command_timeout_ms(struct external_notes_state *state,
+					   int timeout_ms)
+{
+	if (!state)
+		return;
+
+	if (timeout_ms < 0)
+		BUG("negative notes.externalCommandTimeoutMs");
+
+	state->config.read_timeout_ns = convert_ms_to_ns(timeout_ms);
+}
+
+int external_notes_command_timeout_ms(const struct external_notes_state *state)
+{
+	if (!state)
+		return -1;
+
+	return (int)convert_ns_to_ms(state->config.read_timeout_ns);
+}
+
+void set_external_notes_for_grep(struct external_notes_state *state,
+				 int enabled)
+{
+	if (!state)
+		return;
+
+	state->config.for_grep = (bool)enabled;
+}
+
+bool external_notes_for_grep_enabled(const struct external_notes_state *state)
+{
+	return state && state->config.for_grep;
+}
+
+/* Process management helpers. */
+
+static void mute_routine(const char *msg UNUSED, va_list params UNUSED)
+{
+	/* do nothing */
+}
+
+static void close_external_notes_pipes(struct external_notes_process *state)
+{
+	struct child_process *process;
+
+	if (!state)
+		return;
+
+	process = &state->process;
+
+	sigchain_push(SIGPIPE, SIG_IGN);
+
+	if (state->in) {
+		fclose(state->in);
+		state->in = NULL;
+	} else {
+		close(process->in);
+	}
+
+	if (state->out_fd >= 0) {
+		close(state->out_fd);
+		state->out_fd = -1;
+	} else {
+		close(process->out);
+	}
+
+	sigchain_pop(SIGPIPE);
+}
+
+/* We set this as callback later, so can't have void argument. */
+static void cleanup_external_notes_process(struct child_process *process)
+{
+	report_fn old_error = NULL;
+	struct external_notes_process *state;
+
+	if (!process)
+		return;
+
+	state = container_of(process, struct external_notes_process, process);
+
+	kill(process->pid, SIGTERM);
+	old_error = get_error_routine();
+	set_error_routine(mute_routine);
+
+	close_external_notes_pipes(state);
+	finish_command(process);
+
+	if (old_error)
+		set_error_routine(old_error);
+
+	state->started = false;
+}
+
+static void stop_external_notes_process(struct external_notes_process *state)
+{
+	if (!state)
+		return;
+
+	if (!state->started)
+		return;
+
+	state->process.clean_on_exit = 0;
+	cleanup_external_notes_process(&state->process);
+	child_process_init(&state->process);
+	state->out_fd = -1;
+}
+
+static int fail_external_notes_command(struct external_notes_state *state)
+{
+	const struct external_notes_config *config;
+	struct external_notes_process *process;
+
+	if (!state)
+		return -1;
+
+	config = &state->config;
+	process = &state->process;
+	if (!process->failed)
+		warning(_("notes.externalCommand failed: %s"),
+			config->command);
+
+	process->failed = true;
+	stop_external_notes_process(process);
+	return -1;
+}
+
+static int start_external_notes_command(struct external_notes_state *state)
+{
+	const struct external_notes_config *config;
+	struct external_notes_process *process;
+	struct child_process *cmd;
+
+	if (!state)
+		return -1;
+
+	config = &state->config;
+	process = &state->process;
+	cmd = &process->process;
+
+	if (process->started)
+		return 0;
+
+	if (!config->command || process->failed)
+		return -1;
+
+	child_process_init(cmd);
+	strvec_push(&cmd->args, config->command);
+	cmd->use_shell = 1;
+	cmd->in = -1;
+	cmd->out = -1;
+	cmd->clean_on_exit = 1;
+	cmd->clean_on_exit_handler = cleanup_external_notes_process;
+	cmd->trace2_child_class = "notes-external";
+
+	if (start_command(cmd))
+		return fail_external_notes_command(state);
+
+	process->in = xfdopen(cmd->in, "wb");
+	process->out_fd = cmd->out;
+	process->started = true;
+
+	return 0;
+}
+
+void external_notes_free(struct external_notes_state *state)
+{
+	if (!state)
+		return;
+
+	stop_external_notes_process(&state->process);
+	release_external_notes_config(&state->config);
+	free(state);
+}
+
+/* Command parser. Essentially the main() function of this file. */
+int format_external_note(struct external_notes_state *state,
+			 const struct object_id *object_oid,
+			 struct strbuf *note_buf)
+{
+	struct strbuf status = STRBUF_INIT;
+	char commit_id_hex_str[GIT_MAX_HEXSZ + 1];
+	const char *arg;
+	char *end;
+	char ch;
+	unsigned long len;
+	uint64_t deadline_ns;
+	bool input_fail;
+	int ret = 0;
+	const struct external_notes_config *config;
+	struct external_notes_process *process;
+
+	if (!state)
+		return -1;
+
+	/* Exit early if starting the command fails. */
+	if (start_external_notes_command(state) != 0)
+		return -1;
+
+	config = &state->config;
+	process = &state->process;
+
+	/* Fetch the commit ID hex. */
+	oid_to_hex_r(commit_id_hex_str, object_oid);
+
+	/* Pass the input to the external command. */
+	sigchain_push(SIGPIPE, SIG_IGN);
+	input_fail = fprintf(process->in, "%s\n", commit_id_hex_str) < 0
+		     || fflush(process->in) != 0;
+	sigchain_pop(SIGPIPE);
+
+	if (input_fail)
+		goto out_fail;
+
+	if (config->read_timeout_ns == 0)
+		deadline_ns = 0;
+	else
+		deadline_ns = getnanotime() + config->read_timeout_ns;
+
+	/**
+	 * The output for each commit is either of the two:
+	 * 	"{commit id} missing\n"
+	 * 	"{commit id} ok {num_bytes}\n{str_of_num_bytes}\n"
+	 *
+	 * We can have "\r\n" instead of "\n" due to Windows.
+	 */
+
+	/* Read the first line with its delimiter. */
+	if (strbuf_getwholeline_fd_deadline(&status, process->out_fd, '\n',
+					    deadline_ns) == EOF)
+		goto out_fail;
+
+	/* Reject EOF-terminated partial lines. */
+	if (!status.len || status.buf[status.len - 1] != '\n')
+		goto out_fail;
+
+	/**
+	 * Strip LF and then optional CR so both LF and CRLF protocol lines
+	 * are accepted.
+	 */
+	strbuf_setlen(&status, status.len - 1);
+	strbuf_strip_suffix(&status, "\r");
+
+	/* Check if line starts with the commit ID. */
+	if (!skip_prefix(status.buf, commit_id_hex_str, &arg))
+		goto out_fail;
+
+	if (*arg++ != ' ')  /* After commit ID there should be a space. */
+		goto out_fail;
+
+	if (strcmp(arg, "missing") == 0)  /* No note available. */
+		goto out_success;  /* Ending newline is already ensured. */
+
+	if (!skip_prefix(arg, "ok ", &arg))  /* Neither missing nor ok. */
+		goto out_fail;
+
+	/* We are in "ok" case. */
+
+	/* The next thing is length of the note. It must be unsigned digits. */
+	if (!isdigit(*arg))
+		goto out_fail;
+
+	/* Get the length of note. */
+	errno = 0;
+	len = strtoul(arg, &end, 10);
+	if (errno != 0 || *end != '\0' || end == arg)
+		goto out_fail;
+
+	/* Ending newline is already ensured. */
+
+	/* Read the trailing note in bounded-chunks. */
+	while (note_buf->len < len) {
+		ssize_t got;
+		size_t remaining = len - note_buf->len;
+		size_t want = remaining < EXTERNAL_NOTES_READ_CHUNK_SIZE ?
+			      remaining : EXTERNAL_NOTES_READ_CHUNK_SIZE;
+
+		strbuf_grow(note_buf, want);
+
+		got = read_in_full_deadline(process->out_fd,
+					    note_buf->buf + note_buf->len,
+					    want, deadline_ns);
+		if (got < 0 || (size_t)got != want)
+			goto out_fail;
+
+		strbuf_setlen(note_buf, note_buf->len + (size_t)got);
+	}
+
+	/* Ensure the ending newline (LF/CRLF) after the note. */
+	if (xread_deadline(process->out_fd, &ch, 1, deadline_ns) != 1)
+		goto out_fail;
+
+	if (ch != '\n') {  /* Not a LF. */
+		if (ch != '\r')  /* Not a CRLF. */
+			goto out_fail;
+
+		/* We have '\r', let's read the next char. */
+		if (xread_deadline(process->out_fd, &ch, 1,
+				   deadline_ns) != 1)
+			goto out_fail;
+
+		if (ch != '\n')  /* Not a CRLF. */
+			goto out_fail;
+	}
+
+	goto out_success;
+
+out_fail:
+	ret = fail_external_notes_command(state);
+out_success:
+	strbuf_release(&status);
+	return ret;
+}
diff --git a/notes-external.h b/notes-external.h
new file mode 100644
index 000000000000..1b5c2d3919a2
--- /dev/null
+++ b/notes-external.h
@@ -0,0 +1,53 @@
+#ifndef NOTES_EXTERNAL_H
+#define NOTES_EXTERNAL_H
+
+#include "run-command.h"
+
+struct object_id;
+struct strbuf;
+
+struct external_notes_config {
+	char *command;
+	char *command_name_value;
+	uint64_t read_timeout_ns;
+	bool for_grep;
+};
+
+struct external_notes_process {
+	struct child_process process;
+	FILE *in;
+	int out_fd;
+	bool started;
+	bool failed;
+};
+
+struct external_notes_state {
+	struct external_notes_config config;
+	struct external_notes_process process;
+};
+
+struct external_notes_state *external_notes_new(void);
+void external_notes_free(struct external_notes_state *state);
+void external_notes_reset(struct external_notes_state *state);
+
+void set_external_notes_command(struct external_notes_state *state,
+				const char *command);
+bool external_notes_command_configured(const struct external_notes_state *state);
+
+void set_external_notes_command_name(struct external_notes_state *state,
+				     const char *name);
+const char *external_notes_command_name(const struct external_notes_state *state);
+
+void set_external_notes_command_timeout_ms(struct external_notes_state *state,
+					   int timeout_ms);
+int external_notes_command_timeout_ms(const struct external_notes_state *state);
+
+void set_external_notes_for_grep(struct external_notes_state *state,
+				 int enabled);
+bool external_notes_for_grep_enabled(const struct external_notes_state *state);
+
+int format_external_note(struct external_notes_state *state,
+			 const struct object_id *object_oid,
+			 struct strbuf *out);
+
+#endif  /* NOTES_EXTERNAL_H */
diff --git a/notes.c b/notes.c
index 201f1df3dc29..624d4aba223d 100644
--- a/notes.c
+++ b/notes.c
@@ -3,9 +3,12 @@
 
 #include "git-compat-util.h"
 #include "config.h"
+#include "commit.h"
 #include "environment.h"
+#include "gettext.h"
 #include "hex.h"
 #include "notes.h"
+#include "notes-external.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
@@ -983,18 +986,59 @@ void string_list_add_refs_from_colon_sep(struct string_list *list,
 	free(globs_copy);
 }
 
+struct notes_display_config_data {
+	int load_refs;
+	int load_command;
+	struct external_notes_state *external_notes_state;
+};
+
 static int notes_display_config(const char *k, const char *v,
-				const struct config_context *ctx UNUSED,
+				const struct config_context *ctx,
 				void *cb)
 {
-	int *load_refs = cb;
+	struct notes_display_config_data *data = cb;
 
-	if (*load_refs && !strcmp(k, "notes.displayref")) {
+	if (data->load_refs && !strcmp(k, "notes.displayref")) {
 		if (!v)
 			return config_error_nonbool(k);
 		string_list_add_refs_by_glob(&display_notes_refs, v);
 	}
 
+	if (data->load_command && !strcmp(k, "notes.externalcommand")) {
+		if (!v)
+			return config_error_nonbool(k);
+
+		set_external_notes_command(data->external_notes_state, v);
+	}
+
+	if (data->load_command && !strcmp(k, "notes.externalcommandname")) {
+		if (!v)
+			return config_error_nonbool(k);
+
+		if (strchr(v, '\n') || strchr(v, '\r'))
+			return error(_("notes.externalCommandName must not contain a newline"));
+
+		set_external_notes_command_name(data->external_notes_state, v);
+	}
+
+	if (data->load_command && !strcmp(k, "notes.externalcommandtimeoutms")) {
+		int timeout_ms;
+
+		if (!v)
+			return config_error_nonbool(k);
+
+		timeout_ms = git_config_int(k, v, ctx->kvi);
+		if (timeout_ms < 0)
+			return error(_("notes.externalCommandTimeoutMs must be non-negative"));
+
+		set_external_notes_command_timeout_ms(data->external_notes_state,
+						      timeout_ms);
+	}
+
+	if (data->load_command && !strcmp(k, "notes.externalcommandforgrep"))
+		set_external_notes_for_grep(data->external_notes_state,
+					    git_config_bool(k, v));
+
 	return 0;
 }
 
@@ -1075,17 +1119,21 @@ void init_display_notes(struct display_notes_opt *opt)
 {
 	memset(opt, 0, sizeof(*opt));
 	opt->use_default_notes = -1;
+	opt->use_external_notes = -1;
 	string_list_init_dup(&opt->extra_notes_refs);
 }
 
 void release_display_notes(struct display_notes_opt *opt)
 {
 	string_list_clear(&opt->extra_notes_refs, 0);
+	external_notes_free(opt->external_notes_state);
+	opt->external_notes_state = NULL;
 }
 
 void enable_default_display_notes(struct display_notes_opt *opt, int *show_notes)
 {
 	opt->use_default_notes = 1;
+	opt->default_notes_suppressed_by_external = 0;
 	*show_notes = 1;
 }
 
@@ -1102,31 +1150,96 @@ void enable_ref_display_notes(struct display_notes_opt *opt, int *show_notes,
 void disable_display_notes(struct display_notes_opt *opt, int *show_notes)
 {
 	opt->use_default_notes = -1;
+	opt->use_external_notes = -1;
+	opt->default_notes_suppressed_by_external = 0;
 	string_list_clear(&opt->extra_notes_refs, 0);
 	*show_notes = 0;
 }
 
+/*
+ * Resolve the default-notes tri-state in one place. Callers must not test
+ * use_default_notes directly unless they specifically need the unresolved
+ * command-line state.
+ */
+static bool display_notes_use_default(const struct display_notes_opt *opt)
+{
+	/* Options aren't specified, default to true. */
+	if (!opt)
+		return true;
+
+	/* Explicitly enabled. */
+	if (opt->use_default_notes > 0)
+		return true;
+
+	/* Undefined and no explicit notes-ref specified, default to true. */
+	if (opt->use_default_notes == -1 && !opt->extra_notes_refs.nr)
+		return true;
+
+	return false;
+}
+
+/*
+ * Resolve the external-notes tri-state. The unset value follows the resolved
+ * default-notes decision, which means "git log" runs the helper by default
+ * but "git log --notes=<ref>" does not.
+ */
+static bool display_notes_use_external(const struct display_notes_opt *opt)
+{
+	/* Options aren't specified, default to false. */
+	if (!opt)
+		return false;
+
+	/* Explicitly enabled. */
+	if (opt->use_external_notes > 0)
+		return true;
+
+	/* Undefined and to use default notes set, default to true. */
+	if (opt->use_external_notes < 0 && display_notes_use_default(opt))
+		return true;
+
+	return false;
+}
+
 void load_display_notes(struct display_notes_opt *opt)
 {
 	char *display_ref_env;
-	int load_config_refs = 0;
+	struct notes_display_config_data config = { 0, 0 };
+	struct notes_display_config_data protected_config = { 0, 0 };
+	bool use_default_notes = display_notes_use_default(opt);
+	bool use_external_notes = display_notes_use_external(opt);
+
 	display_notes_refs.strdup_strings = 1;
 
+	if (use_external_notes && opt->external_notes_state) {
+		external_notes_reset(opt->external_notes_state);
+	} else if (opt) {
+		external_notes_free(opt->external_notes_state);
+		opt->external_notes_state = NULL;
+	}
+
 	assert(!display_notes_trees);
 
-	if (!opt || opt->use_default_notes > 0 ||
-	    (opt->use_default_notes == -1 && !opt->extra_notes_refs.nr)) {
+	if (use_default_notes) {
 		string_list_append_nodup(&display_notes_refs, default_notes_ref(the_repository));
 		display_ref_env = getenv(GIT_NOTES_DISPLAY_REF_ENVIRONMENT);
 		if (display_ref_env) {
 			string_list_add_refs_from_colon_sep(&display_notes_refs,
 							    display_ref_env);
-			load_config_refs = 0;
+			config.load_refs = 0;
 		} else
-			load_config_refs = 1;
+			config.load_refs = 1;
 	}
 
-	repo_config(the_repository, notes_display_config, &load_config_refs);
+	if (use_external_notes) {
+		if (!opt->external_notes_state)
+			opt->external_notes_state = external_notes_new();
+
+		protected_config.load_command = 1;
+		protected_config.external_notes_state = opt->external_notes_state;
+	}
+
+	repo_config(the_repository, notes_display_config, &config);
+	git_protected_config(notes_display_config, &protected_config);
 
 	if (opt) {
 		struct string_list_item *item;
@@ -1266,47 +1379,31 @@ void free_notes(struct notes_tree *t)
 }
 
 /*
- * Fill the given strbuf with the notes associated with the given object.
+ * Append one already-loaded note message to the given strbuf.
  *
- * If the given notes_tree structure is not initialized, it will be auto-
- * initialized to the default value (see documentation for init_notes() above).
- * If the given notes_tree is NULL, the internal/default notes_tree will be
- * used instead.
+ * Notes read from refs and notes obtained from notes.externalCommand both use
+ * this helper so they share the same encoding, header, and indentation rules.
  *
  * (raw == true) gives the %N userformat; otherwise, the note message is given
  * for human consumption.
  */
-static void format_note(struct notes_tree *t, const struct object_id *object_oid,
-			struct strbuf *sb, const char *output_encoding, bool raw)
+static void format_note_data(const char *ref, const char *msg, size_t msglen,
+			     struct strbuf *sb, const char *output_encoding,
+			     bool raw, bool literal_ref)
 {
 	static const char utf8[] = "utf-8";
-	const struct object_id *oid;
-	char *msg, *msg_p;
-	unsigned long linelen, msglen;
-	enum object_type type;
-
-	if (!t)
-		t = &default_notes_tree;
-	if (!t->initialized)
-		init_notes(t, NULL, NULL, 0);
-
-	oid = get_note(t, object_oid);
-	if (!oid)
-		return;
-
-	if (!(msg = odb_read_object(the_repository->objects, oid, &type, &msglen)) ||
-	    type != OBJ_BLOB) {
-		free(msg);
-		return;
-	}
+	char *reencoded = NULL;
+	const char *msg_p, *msg_end;
 
+	/* Convert the note text from UTF-8 to the requested output encoding. */
 	if (output_encoding && *output_encoding &&
 	    !is_encoding_utf8(output_encoding)) {
-		char *reencoded = reencode_string(msg, output_encoding, utf8);
+		size_t reencoded_len;
+		reencoded = reencode_string_len(msg, msglen, output_encoding,
+						 utf8, &reencoded_len);
 		if (reencoded) {
-			free(msg);
 			msg = reencoded;
-			msglen = strlen(msg);
+			msglen = reencoded_len;
 		}
 	}
 
@@ -1314,37 +1411,106 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 	if (msglen && msg[msglen - 1] == '\n')
 		msglen--;
 
+	/* Raw mode is the %N userformat, so it omits the "Notes" header. */
 	if (!raw) {
-		const char *ref = t->ref;
-		if (!ref || !strcmp(ref, GIT_NOTES_DEFAULT_REF)) {
+		if (!ref)
 			strbuf_addstr(sb, "\nNotes:\n");
-		} else {
-			skip_prefix(ref, "refs/", &ref);
-			skip_prefix(ref, "notes/", &ref);
+		else if (!literal_ref && !strcmp(ref, GIT_NOTES_DEFAULT_REF))
+			strbuf_addstr(sb, "\nNotes:\n");
+		else {
+			if (!literal_ref) {
+				skip_prefix(ref, "refs/", &ref);
+				skip_prefix(ref, "notes/", &ref);
+			}
 			strbuf_addf(sb, "\nNotes (%s):\n", ref);
 		}
 	}
 
-	for (msg_p = msg; msg_p < msg + msglen; msg_p += linelen + 1) {
-		linelen = strchrnul(msg_p, '\n') - msg_p;
+	msg_end = msg + msglen;
+	for (msg_p = msg; msg_p < msg_end; ) {
+		const char *eol = memchr(msg_p, '\n', msg_end - msg_p);
+		size_t linelen = eol ? eol - msg_p : msg_end - msg_p;
 
+		/* Human output indents note body lines under the header. */
 		if (!raw)
 			strbuf_addstr(sb, "    ");
+
 		strbuf_add(sb, msg_p, linelen);
 		strbuf_addch(sb, '\n');
+
+		msg_p += linelen;
+		if (msg_p < msg_end)
+			msg_p++;
+	}
+
+	free(reencoded);
+}
+
+/*
+ * Fill the given strbuf with the notes associated with the given object.
+ *
+ * If the given notes_tree structure is not initialized, it will be auto-
+ * initialized to the default value (see documentation for init_notes() above).
+ * If the given notes_tree is NULL, the internal/default notes_tree will be
+ * used instead.
+ */
+static void format_note_from_tree(struct notes_tree *t,
+				  const struct object_id *object_oid,
+				  struct strbuf *sb,
+				  const char *output_encoding, bool raw)
+{
+	const struct object_id *oid;
+	char *msg;
+	unsigned long msglen;
+	enum object_type type;
+
+	if (!t)
+		t = &default_notes_tree;
+	if (!t->initialized)
+		init_notes(t, NULL, NULL, 0);
+
+	oid = get_note(t, object_oid);
+	if (!oid)
+		return;
+
+	if (!(msg = odb_read_object(the_repository->objects, oid, &type, &msglen)) ||
+	    type != OBJ_BLOB) {
+		free(msg);
+		return;
 	}
 
+	format_note_data(t->ref, msg, msglen, sb, output_encoding, raw, false);
+
 	free(msg);
 }
 
-void format_display_notes(const struct object_id *object_oid,
-			  struct strbuf *sb, const char *output_encoding, bool raw)
+void format_display_notes(const struct commit *commit,
+			  struct strbuf *sb, const char *output_encoding,
+			  bool raw,
+			  struct external_notes_state *external_state)
 {
 	int i;
+	const struct object_id *commit_oid = &commit->object.oid;
+
 	assert(display_notes_trees);
 	for (i = 0; display_notes_trees[i]; i++)
-		format_note(display_notes_trees[i], object_oid, sb,
-			    output_encoding, raw);
+		format_note_from_tree(display_notes_trees[i], commit_oid, sb,
+				      output_encoding, raw);
+
+	if (external_notes_command_configured(external_state)) {
+		struct strbuf out = STRBUF_INIT;
+
+		if (format_external_note(external_state, commit_oid, &out) == 0
+		    && out.len) {
+			const char *label =
+				external_notes_command_name(external_state);
+
+			format_note_data(label, out.buf, out.len, sb,
+					 output_encoding, raw, true);
+		}
+
+		strbuf_release(&out);
+	}
 }
 
 int copy_note(struct notes_tree *t,
diff --git a/notes.h b/notes.h
index f6410b31e1c9..5ac6a7e01dfb 100644
--- a/notes.h
+++ b/notes.h
@@ -6,6 +6,8 @@
 struct object_id;
 struct repository;
 struct strbuf;
+struct commit;
+struct external_notes_state;
 
 /*
  * Function type for combining two notes annotating the same object.
@@ -264,11 +266,31 @@ struct display_notes_opt {
 	 */
 	int use_default_notes;
 
+	/*
+	 * Less than `0` is "unset", which means external notes are shown iff
+	 * the default notes are shown. Otherwise, treat it like a boolean.
+	 */
+	int use_external_notes;
+
+	/*
+	 * Tracks the synthetic "default notes off" state introduced by
+	 * `--external-notes`, so a later deprecated `--show-notes=<ref>`
+	 * can still preserve its historical additive behavior without
+	 * overriding an explicit `--no-standard-notes`.
+	 */
+	int default_notes_suppressed_by_external;
+
 	/*
 	 * A list of globs (in the same style as notes.displayRef) where
 	 * notes should be loaded from.
 	 */
 	struct string_list extra_notes_refs;
+
+	/*
+	 * State for notes.externalCommand. This is initialized lazily by
+	 * load_display_notes() when external notes may be used.
+	 */
+	struct external_notes_state *external_notes_state;
 };
 
 /*
@@ -304,16 +326,21 @@ void disable_display_notes(struct display_notes_opt *opt, int *show_notes);
 void load_display_notes(struct display_notes_opt *opt);
 
 /*
- * Append notes for the given 'object_sha1' from all trees set up by
+ * Append notes for the given commit from all trees set up by
  * load_display_notes() to 'sb'.
  *
  * If 'raw' is false the note will be indented by 4 places and
  * a 'Notes (refname):' header added.
  *
+ * If 'external_state' is not NULL, notes.externalCommand will be used to
+ * append the note from an external source.
+ *
  * You *must* call load_display_notes() before using this function.
  */
-void format_display_notes(const struct object_id *object_oid,
-			  struct strbuf *sb, const char *output_encoding, bool raw);
+void format_display_notes(const struct commit *commit,
+			  struct strbuf *sb, const char *output_encoding,
+			  bool raw,
+			  struct external_notes_state *external_state);
 
 /*
  * Load the notes tree from each ref listed in 'refs'.  The output is
diff --git a/revision.c b/revision.c
index cd9fcefa0a88..f9581fa82f95 100644
--- a/revision.c
+++ b/revision.c
@@ -6,6 +6,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "notes-external.h"
 #include "object-name.h"
 #include "object-file.h"
 #include "odb.h"
@@ -2583,18 +2584,40 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (skip_prefix(arg, "--show-notes=", &optarg) ||
 		   skip_prefix(arg, "--notes=", &optarg)) {
 		if (starts_with(arg, "--show-notes=") &&
-		    revs->notes_opt.use_default_notes < 0)
+		    (revs->notes_opt.use_default_notes < 0 ||
+		     revs->notes_opt.default_notes_suppressed_by_external)) {
 			revs->notes_opt.use_default_notes = 1;
+			revs->notes_opt.default_notes_suppressed_by_external = 0;
+		}
 		enable_ref_display_notes(&revs->notes_opt, &revs->show_notes, optarg);
 		revs->show_notes_given = 1;
 	} else if (!strcmp(arg, "--no-notes")) {
 		disable_display_notes(&revs->notes_opt, &revs->show_notes);
 		revs->show_notes_given = 1;
+	} else if (!strcmp(arg, "--external-notes")) {
+		revs->notes_opt.use_external_notes = 1;
+		revs->show_notes = 1;
+		revs->show_notes_given = 1;
+		/*
+		 * `--external-notes` names a note source on its own. If the
+		 * default notes ref is still undecided, settle it to "off" so
+		 * this option does not also trigger the "no explicit notes
+		 * refs" fallback. A later use of `--notes` or the deprecated
+		 * `--show-notes=<ref>` can still turn the default ref on.
+		 */
+		if (revs->notes_opt.use_default_notes < 0) {
+			revs->notes_opt.use_default_notes = 0;
+			revs->notes_opt.default_notes_suppressed_by_external = 1;
+		}
+	} else if (!strcmp(arg, "--no-external-notes")) {
+		revs->notes_opt.use_external_notes = 0;
 	} else if (!strcmp(arg, "--standard-notes")) {
 		revs->show_notes_given = 1;
 		revs->notes_opt.use_default_notes = 1;
+		revs->notes_opt.default_notes_suppressed_by_external = 0;
 	} else if (!strcmp(arg, "--no-standard-notes")) {
 		revs->notes_opt.use_default_notes = 0;
+		revs->notes_opt.default_notes_suppressed_by_external = 0;
 	} else if (!strcmp(arg, "--oneline")) {
 		revs->verbose_header = 1;
 		get_commit_format("oneline", revs);
@@ -4105,9 +4128,18 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 
 	/* Append "fake" message parts as needed */
 	if (opt->show_notes) {
+		const struct display_notes_opt *notes_opt = &opt->notes_opt;
+		struct external_notes_state *external_notes_state =
+			notes_opt->external_notes_state;
+
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
-		format_display_notes(&commit->object.oid, &buf, encoding, true);
+
+		if (!external_notes_for_grep_enabled(external_notes_state))
+			external_notes_state = NULL;
+
+		format_display_notes(commit, &buf, encoding, true,
+				     external_notes_state);
 	}
 
 	/*
diff --git a/t/helper/meson.build b/t/helper/meson.build
index 3235f10ab8aa..15b6198c19fe 100644
--- a/t/helper/meson.build
+++ b/t/helper/meson.build
@@ -35,6 +35,7 @@ test_tool_sources = [
   'test-mergesort.c',
   'test-mktemp.c',
   'test-name-hash.c',
+  'test-notes-external-config-reset.c',
   'test-online-cpus.c',
   'test-pack-deltas.c',
   'test-pack-mtimes.c',
diff --git a/t/helper/test-external-notes b/t/helper/test-external-notes
new file mode 100755
index 000000000000..5e9dde3977ab
--- /dev/null
+++ b/t/helper/test-external-notes
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+prefix=${TEST_EXTERNAL_NOTES_PREFIX:-external-notes}
+response=${TEST_EXTERNAL_NOTES_RESPONSE:-ok}
+line_ending=${TEST_EXTERNAL_NOTES_LINE_ENDING:-lf}
+exit_after_response=${TEST_EXTERNAL_NOTES_EXIT_AFTER_RESPONSE:-}
+exit_delay=${TEST_EXTERNAL_NOTES_EXIT_DELAY:-}
+delay=${TEST_EXTERNAL_NOTES_DELAY:-}
+char_delay=${TEST_EXTERNAL_NOTES_CHAR_DELAY:-}
+ignore_term=${TEST_EXTERNAL_NOTES_IGNORE_TERM:-}
+
+newline='\n'
+case "$line_ending" in
+crlf)
+	newline='\r\n'
+	;;
+none)
+	newline=
+	;;
+esac
+
+echo start >>"$prefix-starts"
+
+test "$ignore_term" = true && trap '' TERM
+
+emit_output() {
+	if test -n "$char_delay"
+	then
+		LC_ALL=C
+		payload=$(printf "$@"; printf .)
+		payload=${payload%.}
+
+		while test -n "$payload"
+		do
+			char=${payload%"${payload#?}"}
+			printf '%s' "$char" || return 1
+			payload=${payload#?}
+			sleep "$char_delay" || return 1
+		done
+	else
+		printf "$@"
+	fi
+}
+
+while IFS= read -r commit; do
+	if test "${TEST_EXTERNAL_NOTES_BODY+x}" = x
+	then
+		note=$TEST_EXTERNAL_NOTES_BODY
+	else
+		note=$commit
+	fi
+	printf "%s\n" "$commit" >>"$prefix-requests"
+	test -z "$delay" || sleep "$delay"
+	if test "$response" = missing
+	then
+		emit_output "%s missing%b" "$commit" "$newline"
+	else
+		emit_output "%s ok %d%b%s%b" \
+			"$commit" "${#note}" "$newline" "$note" "$newline"
+	fi
+	test "$exit_after_response" = true && break
+done
+
+test -z "$exit_delay" || sleep "$exit_delay"
diff --git a/t/helper/test-notes-external-config-reset.c b/t/helper/test-notes-external-config-reset.c
new file mode 100644
index 000000000000..a64d03346fb9
--- /dev/null
+++ b/t/helper/test-notes-external-config-reset.c
@@ -0,0 +1,24 @@
+#include "test-tool.h"
+#include "notes-external.h"
+
+int cmd__notes_external_config_reset(int argc, const char **argv UNUSED)
+{
+	struct external_notes_state *state;
+
+	if (argc != 1)
+		die("usage: test-tool notes-external-config-reset");
+
+	state = external_notes_new();
+	set_external_notes_command(state, "helper");
+	set_external_notes_command_name(state, "label");
+	set_external_notes_command_timeout_ms(state, 250);
+	set_external_notes_for_grep(state, 1);
+	external_notes_reset(state);
+
+	printf("configured=%d\n", external_notes_command_configured(state));
+	printf("name=%s\n", external_notes_command_name(state));
+	printf("timeout_ms=%d\n", external_notes_command_timeout_ms(state));
+	printf("grep=%d\n", external_notes_for_grep_enabled(state));
+	external_notes_free(state);
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index b71a22b43bbc..b4de5a2f5c06 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -45,6 +45,7 @@ static struct test_cmd cmds[] = {
 	{ "mergesort", cmd__mergesort },
 	{ "mktemp", cmd__mktemp },
 	{ "name-hash", cmd__name_hash },
+	{ "notes-external-config-reset", cmd__notes_external_config_reset },
 	{ "online-cpus", cmd__online_cpus },
 	{ "pack-deltas", cmd__pack_deltas },
 	{ "pack-mtimes", cmd__pack_mtimes },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index f2885b33d58a..e74d4d934b14 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -38,6 +38,7 @@ int cmd__match_trees(int argc, const char **argv);
 int cmd__mergesort(int argc, const char **argv);
 int cmd__mktemp(int argc, const char **argv);
 int cmd__name_hash(int argc, const char **argv);
+int cmd__notes_external_config_reset(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__pack_deltas(int argc, const char **argv);
 int cmd__pack_mtimes(int argc, const char **argv);
diff --git a/t/lib-notes.sh b/t/lib-notes.sh
new file mode 100644
index 000000000000..07422540d58f
--- /dev/null
+++ b/t/lib-notes.sh
@@ -0,0 +1,19 @@
+# Helpers for scripts testing notes behavior.
+
+# notes.externalCommand is run through a shell, so quote the path.
+external_notes_command=$(
+	printf "%s\n" "$TEST_DIRECTORY/helper/test-external-notes" |
+	sed "s/'/'\\\\''/g; s/^/'/; s/$/'/"
+)
+
+# The helper above is a shell script. Few Windows CI tests (3 out of 10
+# in matrix) are spending more than the production default timeout just
+# starting the shell and exchanging the first response, so tests that
+# are not about timeout behavior fail. So let us opt into a wider 1s
+# deadline for Windows instead of 100ms.
+external_notes_command_timeout_config=
+if test_have_prereq MINGW
+then
+	_timeout_config="notes.externalCommandTimeoutMs=1000"
+	external_notes_command_timeout_config="-c $_timeout_config"
+fi
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 1e812df806bb..96adeb9bc4fe 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -6,6 +6,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-notes.sh
 
 # Note that because of the range-diff's heuristics, test_commit does more
 # harm than good.  We need some real history.
@@ -690,6 +691,37 @@ test_expect_success 'range-diff with --notes=custom does not show default notes'
 	grep "## Notes (custom) ##" actual
 '
 
+test_expect_success 'range-diff with --external-notes' '
+	topic_oid=$(git rev-parse topic) &&
+	unmodified_oid=$(git rev-parse unmodified) &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		range-diff --no-color --external-notes \
+		main..topic main..unmodified >actual &&
+	test_grep "## Notes (external) ##" actual &&
+	test_grep "^    -    $topic_oid$" actual &&
+	test_grep "^    +    $unmodified_oid$" actual &&
+	! grep "## Notes ##" actual
+'
+
+test_expect_success 'range-diff with disabled external notes' '
+	test_when_finished "git notes remove topic unmodified || :" &&
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	TEST_EXTERNAL_NOTES_PREFIX=range-diff-external-notes \
+		git -c notes.externalCommand="$external_notes_command" \
+		range-diff --no-color --external-notes --no-external-notes \
+		main..topic main..unmodified >actual &&
+	cat >expect <<-EOF &&
+	1:  $(test_oid t1) = 1:  $(test_oid u1) s/5/A/
+	2:  $(test_oid t2) = 2:  $(test_oid u2) s/4/A/
+	3:  $(test_oid t3) = 3:  $(test_oid u3) s/11/B/
+	4:  $(test_oid t4) = 4:  $(test_oid u4) s/12/B/
+	EOF
+	test_cmp expect actual &&
+	test_path_is_missing range-diff-external-notes-starts
+'
+
 test_expect_success 'format-patch --range-diff does not compare notes by default' '
 	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
@@ -780,6 +812,42 @@ test_expect_success 'format-patch --range-diff with --notes' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format-patch --range-diff with --external-notes' '
+	topic_oid=$(git rev-parse topic) &&
+	unmodified_oid=$(git rev-parse unmodified) &&
+	test_when_finished "rm -f 000?-*" &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		format-patch --external-notes --cover-letter --range-diff=$prev \
+		main..unmodified >actual &&
+	test_line_count = 5 actual &&
+	test_grep "^Range-diff:$" 0000-* &&
+	test_grep "## Notes (external) ##" 0000-* &&
+	test_grep "^    -    $topic_oid$" 0000-* &&
+	test_grep "^    +    $unmodified_oid$" 0000-* &&
+	! grep "## Notes ##" 0000-*
+'
+
+test_expect_success 'format-patch --range-diff with disabled external notes' '
+	test_when_finished "git notes remove topic unmodified || :" &&
+	git notes add -m "topic note" topic &&
+	git notes add -m "unmodified note" unmodified &&
+	test_when_finished "rm -f 000?-*" &&
+	TEST_EXTERNAL_NOTES_PREFIX=range-diff-external-notes \
+		git -c notes.externalCommand="$external_notes_command" \
+		format-patch --external-notes --no-external-notes \
+		--cover-letter --range-diff=$prev main..unmodified >actual &&
+	test_line_count = 5 actual &&
+	test_grep "^Range-diff:$" 0000-* &&
+	grep "= 1: .* s/5/A" 0000-* &&
+	grep "= 2: .* s/4/A" 0000-* &&
+	grep "= 3: .* s/11/B" 0000-* &&
+	grep "= 4: .* s/12/B" 0000-* &&
+	! grep "Notes" 0000-* &&
+	! grep "note" 0000-* &&
+	test_path_is_missing range-diff-external-notes-starts
+'
+
 test_expect_success 'format-patch --range-diff with format.notes config' '
 	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 27439010dfbc..7fd82767c1f1 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -6,6 +6,7 @@
 test_description='Test commit notes'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-notes.sh
 
 write_script fake_editor <<\EOF
 echo "$MSG" >"$1"
@@ -16,6 +17,11 @@ export GIT_EDITOR
 
 indent="    "
 
+run_with_limited_time () (
+	{ set +x; } 2>/dev/null
+	"$PERL_PATH" -e 'alarm shift; exec @ARGV' -- "$@"
+)
+
 test_expect_success 'cannot annotate non-existing HEAD' '
 	test_must_fail env MSG=3 git notes add
 '
@@ -909,6 +915,424 @@ test_expect_success 'displayed notes are used for grep matching' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'notes.externalCommand shows external notes from protected config' '
+	commit=$(git rev-parse HEAD) &&
+	parent=$(git rev-parse HEAD^) &&
+	rm -f external-notes-starts external-notes-requests &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log -2 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	{
+		printf "%s\n" "$commit" &&
+		printf "%s\n" "$parent"
+	} >expect-requests &&
+	test_cmp expect-requests external-notes-requests &&
+	test_grep "Notes (external):" actual &&
+	test_grep "^    $commit$" actual &&
+	test_grep "^    $parent$" actual
+'
+
+test_expect_success PERL,EXECKEEPSPID 'notes.externalCommand terminates helper during exit cleanup' '
+	commit=$(git rev-parse HEAD) &&
+	test_env TEST_EXTERNAL_NOTES_EXIT_DELAY=10 \
+		run_with_limited_time 2 \
+		git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --external-notes -1 >actual &&
+	test_grep "^Notes (external):$" actual &&
+	test_grep "^    $commit$" actual
+'
+
+test_expect_success 'notes.externalCommandName labels external notes' '
+	commit=$(git rev-parse HEAD) &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		-c notes.externalCommandName=commit-id log -1 >actual &&
+	test_grep "Notes (commit-id):" actual &&
+	test_grep "^    $commit$" actual
+'
+
+test_expect_success 'notes.externalCommandName is rendered literally' '
+	commit=$(git rev-parse HEAD) &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		-c notes.externalCommandName=refs/notes/commits \
+		log --external-notes -1 >actual &&
+	test_grep "^Notes (refs/notes/commits):$" actual &&
+	! grep "^Notes:$" actual &&
+	test_grep "^    $commit$" actual
+'
+
+test_expect_success 'notes.externalCommandTimeoutMs rejects negative values' '
+	test_must_fail git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandTimeoutMs=-1 log -1 2>err &&
+	test_grep "notes.externalCommandTimeoutMs must be non-negative" err
+'
+
+test_expect_success 'notes.externalCommandTimeoutMs times out delayed response' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_DELAY=1 \
+		git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandTimeoutMs=1 \
+		log -1 >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
+test_expect_success 'notes.externalCommandTimeoutMs applies to whole response' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_BODY=x \
+		 TEST_EXTERNAL_NOTES_CHAR_DELAY=0.02 \
+		git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandTimeoutMs=50 \
+		log -1 >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
+test_expect_success PERL,EXECKEEPSPID 'notes.externalCommandTimeoutMs terminates timed-out helper' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_DELAY=10 \
+		run_with_limited_time 2 \
+		git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandTimeoutMs=1 \
+		log -1 >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
+test_expect_success 'notes.externalCommandTimeoutMs=0 disables timeout' '
+	commit=$(git rev-parse HEAD) &&
+	test_env TEST_EXTERNAL_NOTES_DELAY=1 \
+		git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandTimeoutMs=0 \
+		log --external-notes -1 >actual &&
+	test_grep "^Notes (external):$" actual &&
+	test_grep "^    $commit$" actual
+'
+
+test_expect_success 'notes.externalCommand handles CRLF note bodies' '
+	body=$(printf "A\r\nB") &&
+	test_env TEST_EXTERNAL_NOTES_BODY="$body" \
+		git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --external-notes -1 >actual &&
+	test_grep "^Notes (external):$" actual &&
+	test_grep "^    B$" actual
+'
+
+test_expect_success 'notes.externalCommand accepts CRLF missing response' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_RESPONSE=missing \
+		 TEST_EXTERNAL_NOTES_LINE_ENDING=crlf \
+		git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'notes.externalCommand rejects unterminated missing response' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_RESPONSE=missing \
+		 TEST_EXTERNAL_NOTES_LINE_ENDING=none \
+		 TEST_EXTERNAL_NOTES_EXIT_AFTER_RESPONSE=true \
+		git -c notes.externalCommand="$external_notes_command" \
+		log -1 >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
+test_expect_success PERL,EXECKEEPSPID 'notes.externalCommand rejects unterminated live response without deadlock' '
+	git log -1 >expect &&
+	test_env TEST_EXTERNAL_NOTES_RESPONSE=missing \
+		 TEST_EXTERNAL_NOTES_LINE_ENDING=none \
+		run_with_limited_time 2 \
+		git -c notes.externalCommand="$external_notes_command" \
+		log -1 >actual 2>err &&
+	test_cmp expect actual &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
+test_expect_success 'notes.externalCommand accepts CRLF protocol lines' '
+	commit=$(git rev-parse HEAD) &&
+	test_env TEST_EXTERNAL_NOTES_LINE_ENDING=crlf \
+		git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --external-notes -1 >actual &&
+	test_grep "^Notes (external):$" actual &&
+	test_grep "^    $commit$" actual
+'
+
+test_expect_success 'notes.externalCommand missing response shows no external notes' '
+	write_script external-notes-missing <<-\EOF &&
+	while IFS= read -r commit
+	do
+		printf "%s missing\n" "$commit"
+	done
+	EOF
+	git log -1 >expect &&
+	git -c notes.externalCommand=./external-notes-missing log -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'notes.externalCommand empty note shows no external notes' '
+	write_script external-notes-empty <<-\EOF &&
+	while IFS= read -r commit
+	do
+		printf "%s ok 0\n\n" "$commit"
+	done
+	EOF
+	git log -1 >expect &&
+	git -c notes.externalCommand=./external-notes-empty log -1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'notes.externalCommand rejects invalid note lengths' '
+	write_script external-notes-invalid-length <<-\EOF &&
+	while IFS= read -r commit
+	do
+		printf "%s ok %s\n" "$commit" "$1"
+	done
+	EOF
+	git log -2 >expect &&
+	for bad_length in -1 +1 1x x
+	do
+		git -c notes.externalCommand="./external-notes-invalid-length $bad_length" \
+			log -2 >actual 2>err &&
+		test_cmp expect actual &&
+		test_grep "notes.externalCommand failed" err &&
+		test_line_count = 1 err || return 1
+	done
+'
+
+test_expect_success 'notes.externalCommand is suppressed by --no-notes' '
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" log --no-notes -1 >actual &&
+	test_path_is_missing external-notes-starts &&
+	! grep "Notes (external):" actual
+'
+
+test_expect_success 'notes.externalCommand is suppressed by --no-external-notes' '
+	rm -f external-notes-starts &&
+	git log -1 >expect &&
+	git -c notes.externalCommand="$external_notes_command" \
+		log --no-external-notes -1 >actual &&
+	test_cmp expect actual &&
+	test_path_is_missing external-notes-starts
+'
+
+test_expect_success 'notes.externalCommand combines with explicit notes ref' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --notes=other --external-notes -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "Notes (other):" actual &&
+	test_grep "^    other note$" actual &&
+	test_grep "Notes (external):" actual &&
+	test_grep "^    $commit$" actual &&
+	! grep "^    order test$" actual
+'
+
+test_expect_success '--show-notes=ref remains additive after --external-notes' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --external-notes --show-notes=other -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "^Notes:$" actual &&
+	test_grep "^    order test$" actual &&
+	test_grep "^Notes (other):$" actual &&
+	test_grep "^    other note$" actual &&
+	test_grep "^Notes (external):$" actual &&
+	test_grep "^    $commit$" actual
+'
+
+test_expect_success 'notes.externalCommand can be enabled without default notes refs' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --external-notes -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "Notes (external):" actual &&
+	test_grep "^    $commit$" actual &&
+	! grep "^    order test$" actual &&
+	! grep "^    other note$" actual
+'
+
+test_expect_success 'notes.externalCommand combines with default notes refs' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --external-notes --notes -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "Notes:" actual &&
+	test_grep "^    order test$" actual &&
+	test_grep "Notes (external):" actual &&
+	test_grep "^    $commit$" actual &&
+	! grep "^    other note$" actual
+'
+
+test_expect_success 'notes.externalCommand obeys last --external-notes option' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git log --no-notes -1 >expect &&
+	git -c notes.externalCommand="$external_notes_command" \
+		log --external-notes --no-external-notes -1 >actual &&
+	test_cmp expect actual &&
+	test_path_is_missing external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log --notes=other --no-external-notes --external-notes -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "Notes (other):" actual &&
+	test_grep "^    other note$" actual &&
+	test_grep "Notes (external):" actual &&
+	test_grep "^    $commit$" actual &&
+	! grep "^    order test$" actual
+'
+
+test_expect_success 'notes.externalCommand honors raw notes formatting' '
+	commit=$(git rev-parse HEAD) &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		show -s --format=%N >actual &&
+	test_grep "^$commit$" actual &&
+	! grep "Notes (external):" actual
+'
+
+test_expect_success 'format-patch --external-notes includes external notes only' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		format-patch --external-notes -1 --stdout >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "^Notes (external):" actual &&
+	test_grep "^    $commit$" actual &&
+	! grep "^    order test$" actual
+'
+
+test_expect_success 'notes.externalCommand is not used for grep matching' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		log --grep="$commit" >actual &&
+	test_must_be_empty actual &&
+	test_path_is_missing external-notes-starts
+'
+
+test_expect_success 'notes.externalCommandForGrep includes external notes in grep matching' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		-c notes.externalCommandForGrep=true \
+		log --grep="$commit" -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "Notes (external):" actual
+'
+
+test_expect_success 'notes.externalCommandForGrep does not search hidden notes' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandForGrep=true \
+		log --oneline --grep="$commit" -1 >actual &&
+	test_must_be_empty actual &&
+	test_path_is_missing external-notes-starts
+'
+
+test_expect_success 'notes.externalCommandForGrep honors --no-external-notes' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		-c notes.externalCommandForGrep=true \
+		log --no-external-notes --grep="$commit" -1 >actual &&
+	test_must_be_empty actual &&
+	test_path_is_missing external-notes-starts
+'
+
+test_expect_success 'notes.externalCommandForGrep combines with explicit notes ref' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		-c notes.externalCommandForGrep=true \
+		log --notes=other --external-notes --grep="$commit" -1 >actual &&
+	test_line_count = 1 external-notes-starts &&
+	test_grep "Notes (external):" actual &&
+	test_grep "Notes (other):" actual &&
+	! grep "^    order test$" actual
+'
+
+test_expect_success 'notes.externalCommandForGrep is ignored from local config' '
+	commit=$(git rev-parse HEAD) &&
+	rm -f external-notes-starts &&
+	test_config notes.externalCommandForGrep true &&
+	git -c notes.externalCommand="$external_notes_command" \
+		log --grep="$commit" >actual &&
+	test_must_be_empty actual &&
+	test_path_is_missing external-notes-starts
+'
+
+test_expect_success 'notes.externalCommand is not used with explicit notes ref' '
+	rm -f external-notes-starts &&
+	git -c notes.externalCommand="$external_notes_command" log --notes=other -1 >actual &&
+	test_path_is_missing external-notes-starts &&
+	! grep "Notes (external):" actual
+'
+
+test_expect_success 'notes.externalCommand is ignored from local config' '
+	rm -f external-notes-starts &&
+	test_config notes.externalCommand "$external_notes_command" &&
+	git log -1 >actual &&
+	test_path_is_missing external-notes-starts &&
+	! grep "Notes (external):" actual
+'
+
+test_expect_success 'notes.externalCommandName is ignored from local config' '
+	test_config notes.externalCommandName local &&
+	git -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		log -1 >actual &&
+	test_grep "Notes (external):" actual &&
+	! grep "Notes (local):" actual
+'
+
+test_expect_success 'external_notes_reset clears cached helper config' '
+	test-tool notes-external-config-reset >actual &&
+	cat >expect <<-\EOF &&
+	configured=0
+	name=external
+	timeout_ms=100
+	grep=0
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'notes.externalCommand warning is shown once' '
+	write_script external-notes-fail <<-\EOF &&
+	while IFS= read -r commit
+	do
+		printf "%s-mismatch missing\n" "$commit"
+	done
+	EOF
+	git -c notes.externalCommand=./external-notes-fail log -2 >actual 2>err &&
+	test_grep "notes.externalCommand failed" err &&
+	test_line_count = 1 err
+'
+
 test_expect_success 'Allow notes on non-commits (trees, blobs, tags)' '
 	test_config core.notesRef refs/notes/other &&
 	echo "Note on a tree" >expect &&
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 8ee3d2c37d02..abbdb42dc9f7 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -15,6 +15,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-notes.sh
 
 check_describe () {
 	indir= &&
@@ -867,6 +868,22 @@ test_expect_success 'format-rev with %N (note)' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format-rev with %N uses external notes' '
+	commit=$(git -C repo-format rev-parse HEAD) &&
+	rm -f repo-format/format-rev-external-notes-starts \
+		repo-format/format-rev-external-notes-requests &&
+	printf "%s\n" "$commit" >input &&
+	printf "%s\n\n" "$commit" >expect &&
+	TEST_EXTERNAL_NOTES_PREFIX=format-rev-external-notes \
+	git -C repo-format -c notes.externalCommand="$external_notes_command" \
+		$external_notes_command_timeout_config \
+		format-rev --stdin-mode=text --format="tformat:%N" \
+		<input >actual &&
+	test_line_count = 1 repo-format/format-rev-external-notes-starts &&
+	test_cmp input repo-format/format-rev-external-notes-requests &&
+	test_cmp expect actual
+'
+
 test_expect_success 'format-rev --notes<ref> (custom notes ref)' '
 	# One custom notes ref
 	test_when_finished "git -C repo-format notes remove" &&
-- 
2.53.0

