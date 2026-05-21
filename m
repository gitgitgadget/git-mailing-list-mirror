Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41F242D6A
	for <git@vger.kernel.org>; Thu, 21 May 2026 05:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779341338; cv=fail; b=b2dZ9gaaUfhQYz22ehcK5FJBww7UcZ9tD9ntPeJdTIoYbiBNNyCPKrg6wOLaldRh5A2RlVcpTfhW5oLWgTCDYAfSaPtuP/QmA3Gzjx+F4K3lsloIVB7jU8L4RNJ9sj4nFOGwAMrOLHQxmdaeqpKydW9rYJKsSVeF47JlVMoOL3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779341338; c=relaxed/simple;
	bh=DzOe5SR0NLmuRiFqgXJZWhHYVDuy1L8hg2rBQ5lBKGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jy6UZ8JQfKKDjnwokP3hdX4eP3GyM4L01pN+uiCiEYsU94X9xxd6mY2/b9h8S7gzTN6v+kTwSlo6/aRR314VIOvLEoZTHtiIQg+W8vf7K6RSeUICTSXb8XqJ9hGOHNF30Dmq5mmV0C8YVz8+dW5l+EU/rlfyIjLNDhGzJxNA8bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UACKNPb+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pIwmiuYn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UACKNPb+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pIwmiuYn"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L1NT1r1868650;
	Thu, 21 May 2026 05:28:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bhjBY/Zchn1ofLrjJ+K8uNX1K2jmGNk2aLmWikXmytk=; b=
	UACKNPb+7xVaK6ak1DbgIa/gtkfmtYiPXPiL4G35dYiIlOZXKIB2gZAnwCugFLeC
	3fkKke2JqSEkbhNnA6Qr1PNV+0H9QsCvy66tJbNFbdxt95j9SNqJmensCZof1/Bl
	YJ1KYbvJyzsgHrw6KapIumMdBoQ7KST2mpeFbKVoCPqhmKkR9fONTxMmKZyC+zVR
	hItZ03W/pwLN3LC+j/Vm0UQttS1CQAbbBQpOER8huWq5CF+T9IIIIA8wzOh3MvKK
	R4Lx3Gqz/kwfonSuSGSd46wG9W+blnXFwdWgicpr4ARVOjeDKF27W+wCbVGeb8xw
	w7C14HQ+YmXtg5yGSo8hEg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h1t0ghv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 05:28:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64L5JjVv033234;
	Thu, 21 May 2026 05:28:51 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1d4b76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 05:28:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/8+ne70VXbj8Sith/UJKrrp2r9l5CpGhLoJKhIg1+t0ZBtJC6KfuauQW7M1pp2wbBPIuIqMch3cbwk5NkYPQa4TKjBUP23m0G9vJyv906PFa11zaJ20TZbksa6RHt1atdw/9XSJbQlfN6cjICuOa7Xhk6HKoX9S1kD4sxJ3zl3Khscu9YxrEa3BC70DR57E+jwQbNAJ6I5WDnhi8JZQfItDFmpqwUm/zkxR8ORRzS92GybQDRqAHyHjWkGLWGWFuj8aAas0KfXjarWJ1HjVlMFcG4mCvPMo5gMZbaa9ncP+tQuTU/580pk0icOa0wiSq+FyiazfyA3laWdbNZdEhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhjBY/Zchn1ofLrjJ+K8uNX1K2jmGNk2aLmWikXmytk=;
 b=Pi75f8T+BZnv7FYxj0EEhToBXQSW+7Y71OK5pxMZnUH3fZ9AcQ3BNm/YLJh7307B10NfB/+Yeifw8kb+U9OtVMbc9fk/6eoC3oMiwej1c9TWRdfiYuG4cYf0puO034GPLueQjFcG3vk0vmFYfinCVzGcMCBs5b8zifyX6K2vwXzJpeogFTBUvfEWGvjhJIXv5DG+mvKUG9tjtE875iAiwW+YVCxpiApYj8KC3b2fttPNPsw6mEHmVdnMRiHH2DCfHCGnvGgya0IjAZR+wzcpkXxolOAcc8TSesd8jWvXJwmN+kCFV5lVHP+S7iA5ZtWbdCGdAhV4zvzHmKmdyWKLOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhjBY/Zchn1ofLrjJ+K8uNX1K2jmGNk2aLmWikXmytk=;
 b=pIwmiuYnUCOJuMWt4pE8p7WKJejhvzy2Wqj4o5E2cDACTBCvBmS00TVo4xgJ9CnakqH94FwtidHhEx/YVtG8zP598JrmHBzslBW6qwrZNcfebUUHhvXsEsrkPyeNvnRTppPwEEn/5jwOmwgqy3w/CT5Dmacig1ueyaHdkdhldD8=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CY8PR10MB6706.namprd10.prod.outlook.com (2603:10b6:930:92::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.22; Thu, 21 May 2026 05:28:47 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 05:28:47 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
        git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] Documentation/git-range-diff: add missing notes options in synopsis
Date: Thu, 21 May 2026 10:58:41 +0530
Message-ID: <20260521052841.73775-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <72839071-153f-4306-a705-3be0dc203109@app.fastmail.com>
References: <72839071-153f-4306-a705-3be0dc203109@app.fastmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0006.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::18) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CY8PR10MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: d63e7e39-fc37-40f4-6b72-08deb6f9d4d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YYktJGlsqDJfUmhq+YdsNvR3x051CHlDbocpi8htkwEIaLgbzJARH4+oFLRoaJ+AJmGq6sWtu4ZHhwgNCPQrmTwXMAKbqLA3aP0+5muHpDy/SzV3oTPZ4FHPxT9lwmnHdj8m46XgTarG+7epQmXwZyn2ZNsjq6NfASMjIELLl8NSM6jg7Cj+QKyMGfyJT94xHXJVL/Kb2tzGl1LHLoCFCAMrnhpToQb1kf2IeFhcqIkvBd6t/AMqIKY8HSvgHvMpc3SaHKSqMZltZVbv3s8j02J9rUbEgh2YkiBNVhPEcaaun7ipO0A3vSNPoWqIGYLs0lSwE9IpMmdwIvJgTzTBYkWHj0G3Vk15knScFk3Gi5StSkLXdvsPbTo084yhvvjDBwSLS90J66TfcJs7cbTPJq9XmhAJpG28mcWQHUyW1vkHSOzEB/L9230MGnBdz1zFR3X0Rv3Tbdw7JMjcqHxK9xk7WeMd7iQtq5PEkJj2kxkr6TJSFbmpf1Jd6jIwKQwJNPF2T0uQPYNryHwmHV0IxYHgVzZHXURxpFCEMSTYlDyKPDGXUkPR+jtUUeCw0GaoEPyGxKsHdWgmwuqOuUQ+vWLa1OKDiBNc544+pl8tl5A9TkbJdh8Vy8hz4BDmbjFj5/OXnWybntq9Hv5s4y4N9pwlW94d71gX39FfoGE1JMar7AmzPbvT5dOFDEveQ1Wl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PnYX3qGN8wTb044ikz42aMw5Qb32P8011Zg2cHr1Y3Vf6ISNeXXltSLPnB2k?=
 =?us-ascii?Q?orMzM8qDX0utQrWaIbWVLGuGQz6KM6cURSs3lPxNziUMrLwu7I+VocOo3DAQ?=
 =?us-ascii?Q?V7y5zevQruMhIaxEJTE2PGeeEwG+i2Kb+3ZoiRDjS3wrFi2492KlPicynkpJ?=
 =?us-ascii?Q?IaeaghizqW+ncTofKv99H+dZXgOGDjcVZabQodpDLszBAznQKo/Rhe6I12gY?=
 =?us-ascii?Q?vCyz1pQ/8J93lSChXjdfyTq4RSGPe/L/Gx+5ofziflQMIi2xhTZ4/ePhKrBd?=
 =?us-ascii?Q?ZRVC4QyKasXU/q3xvcsjQ+lNSDmmp+ByI/aeSYqvt03gvXAIyd00uRIRJYQW?=
 =?us-ascii?Q?9GKyN44Haij6ahB1ZBRxlR548LHULyRCTnUC65DvdEuxbxiehrDoxwzWXS3Z?=
 =?us-ascii?Q?dLgu6h6naNCt8RjAzyYF6IxVlTXv4D6xVv93FBgqFUXM8gmx/5QkmYGgqB1I?=
 =?us-ascii?Q?cc+bRNoZ3o9jGqXMdLY1k2qsKvjoe1Y8DdPgzn0GlBDfGZEWUdbNrYbHUZc1?=
 =?us-ascii?Q?lPH+hLkIC7Sosy+6bQDBR3G4g14CYkMPSij3mxV3qfGGN6lSsjh9I8wHUztx?=
 =?us-ascii?Q?cRND39vlLRYR6BiGZB5jzbZ3MhSCuxH28PZRVhxuumUCEISojEU1zn/l0M3U?=
 =?us-ascii?Q?utDtPrLHT3qL6GdTJ+tDyLXvgx6ICJj0FW4xNqCfaRzmkSGMczI81tUFyGb+?=
 =?us-ascii?Q?/IHw4cgPaV5F05JkzIagL5MYbg5dsME+yHE1Ff6U4yEiZUujLxspCjY+6dn8?=
 =?us-ascii?Q?WvjOxFeytx6dbbwZO/EzKnt8b83JaoaTvgNCCx1VYTv7Fso7iw5TNk0QnQoD?=
 =?us-ascii?Q?kA722yVQWqKaXib1zQUVpoAJZf70Pbh9Ubyi1llVI0cS+JfGH2rG9gvIrejk?=
 =?us-ascii?Q?gl+jh7dxw0HHIiPaqjLLx0Sxo15W2LRze+4Mh3r17sWicaaOX+z++e4+p6pI?=
 =?us-ascii?Q?0O2FN8OrTm5y7yja1AUA0MhUpOKAAnoynspy40lw+Y+Eq8u9eb0OFCHdydnn?=
 =?us-ascii?Q?SJt9koCa6BO8fBc8/qEnD/LpKgJyhpXhP2ZX25FLcp0lsVxuiuDVhceYnCFn?=
 =?us-ascii?Q?rFeLQvhulnbzjmraAH15gE0VjualXHRn8uOPod/9ytbuz/sGbD5SepXeUMM4?=
 =?us-ascii?Q?LnU5lF/5iZYUwhn9pqyhl11l/ExdfgY2X5LJLUbUxIAPsdXDbjaD1oftswxj?=
 =?us-ascii?Q?58AeUCSZjSEiFe1JjWNF+9sM+JVOYAqH+tkzvM1zPoAYMnUjVHbreEyccOJQ?=
 =?us-ascii?Q?VjpbYV+JB66UAGmr2PT/x3hwdr/k5ndGRqHvBuC30Ahp5574n14j1FAusx0/?=
 =?us-ascii?Q?0VfUSAIbjYWB7rLcEgV1vfpZzbxiY4GX4wgdE3adfumz+Epc8XJKBJOz8EyX?=
 =?us-ascii?Q?a3n11RoG8pGvzrQn3++7PnoWAgfQWYnQKunvZA+Ra1cEvxVrAmZS3f3oDxtI?=
 =?us-ascii?Q?765GduB0ltml8cBauMAxJW/2b05MdM4OYtDAz38o6OMqt1OMYzostZDKUOYR?=
 =?us-ascii?Q?UdCK0468IkzCMftnT29cMiGXQrysIeQe7Uv0QEyoJ5qhXA945BBfZKOVBSPB?=
 =?us-ascii?Q?okiyYGNik6bf4vvVDgFn321BausWz6Uqldc+HKz/osnEFVTlJBIqfx9cdodh?=
 =?us-ascii?Q?rMshiLGU5MXj0vEJXlaRVMsFheRHY1I8+RdS0dIjy+6M/CJ5Yk2E2FnvCZg6?=
 =?us-ascii?Q?vVjMubPPsPpn+SUi7tI6BAGlqssvjDBOQJ31wJXeNfLzDoW9kHbkR/oIxYJy?=
 =?us-ascii?Q?aFvq3wxQ0xWng2aXspn/nle0BA8ySecucTM8tgLLIueozP2PIhUlkmzAEwKt?=
X-MS-Exchange-AntiSpam-MessageData-1: VHodv9mnaYg2H4D8mWHyuZaJxaT2bTO5ejk=
X-Exchange-RoutingPolicyChecked:
	sDk4E/nsBQ/l+cNEzLP10134mq+UqvUf5EbRSw83JpoXqR4R2nz7YBe0ZIXkU3osKCG0KRXDvYVh5LdkNBw3Q2Xd8FTFck5r9LQD9lUQxju2JSbsNoFwO4p6HfEYY4liWG49VdBjhjHpjRG2R7pBFZjnv4LjfM1gk3Tj4zfYmkmMsg6/4mInL0yKYqHAygKG6eSDd/G8usgxaLLU1Ua9LAy+qzO7zCDU3dgB6wJ4BJoS/x7w7MRA9FuoF1RG9icpPoR+0QzMuViosyWeBXOUsuoOf9opt/+DeBvxujkjnVK5nEKyyAmXScagzOy4y/jXAwfMb4ejSx6EN2lH310Wuw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P+HH2d9YNQZbPo/ihPgQeHlgBIpnJ5IvROg627vQdhYlt2SIXJRXf5BYjU8xlwUC5MdlMa7XMvsrEvYi7+X1GQ9DOjOs9BVJBK1bOETjM/GlSVytokR5mdnXwH/QuLBv4pfCig901hzESIHCfMQamBZ8J8lj2P11IKv7Ey/PTKRACL09aRARFM2hHHU2F9YhLw/AmYQsz6m5VKnxk41dN4fVkhCo8riRaoN9K/2B5HPJnotjd8jqbItMwlyZw0ffkcj3YAx4A86a/sSdgApFjl2c2FDbTN1aWyZD1rdlgE/9XBlJPOUGuQpBz2cU40HerZtByGJQ+CxPchMSaOtAe1v4+a8iUPVLROMI9ZkN9myWTm61EkkN3Yol8BYK0PDWTXkggLCWomLsAe3gJpxTPfFJ1UMgaBIHs2VTaeP1SFuvBoKbCV8AhV8+hoL57aGmh/T6mBDFMdrqBK70LWFOXuv2sGswwss4AVvRQ0yA4V+sQ8m6p8693vlfzvlqnzhy6HIrTbgbc2qArb7YB6EEbFQntrUGRAodUZ5iFCYNkGn8XsOQXFgeCWVWh72l+EOHejFCvraosYlLEKovYI5w8ZQ2wJ0P6bcrq5inoyfwoVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63e7e39-fc37-40f4-6b72-08deb6f9d4d8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 05:28:46.9709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yN031BAx7gNwUCbANwwsVe5j2AL59hY+9jSAtiGZ1ox7q7PuqJjWFIyB3+0DNyjy9lTCo3T0Eq9HMHW1Iqt/QRt7SuEOuszSkX5uDKUQWVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605210049
X-Proofpoint-ORIG-GUID: 2tuzyOeLmvTaKYipj_ODDlZN4DPMEEaj
X-Authority-Analysis: v=2.4 cv=aoKCzyZV c=1 sm=1 tr=0 ts=6a0e9815 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=qdcGDM-7Fkr9Ez0Dw4QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA0OSBTYWx0ZWRfX9H4nZ6mHAy4c
 RSwVZuSBbPVz/jMrx/OvclvU7bYpIq2zNMG2wWZ68rvhL6wJiK2XuIn3gTW7aKg8xWO54mMltwT
 sgFwOra55x3fVk4zV0U5W51p+nhCNnCpQZthVcHatCOvIwSeBBla3Kkn3/lRppqKXz7fcFXZOUO
 3cCwRDFN6/viBy0Vmsx8c2jRi9tqNTQJ8WUrZIfAf1GRDhUj9sjg7NeoR5K4S9qQhA8xnz8UUm0
 HvE7QrTzBKEwHIPyu8AwmbN8v+8jk6qoOwTbIHCYTrKobxlYFj/hwpUqdeu9Z1SsR2a7XFdl2s4
 IGKyFw1tUtJ1zy4yA1PsCTcAEMlOxm99ltvln4oJXMRRY/HWU79BLBa15m9qnJ2+BmuM3it6W7E
 zL/i8vv+zeYlXg9Ej0uOTPCVAP/slpAwW6wxCZPh+9fmBbnQciKahOPiNxTjjEjWow8SdXWl6a7
 CtiiYl6pwmIiiMEwGdg==
X-Proofpoint-GUID: 2tuzyOeLmvTaKYipj_ODDlZN4DPMEEaj

git-range-diff supports note options which are also mentioned later in
the help, but they are missing from the synopsis. Let's fix that.

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
v1 -> v2: Fixed typo and removed fixes line.

 Documentation/git-range-diff.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-range-diff.adoc b/Documentation/git-range-diff.adoc
index 880557084533..5cc5e2ed5673 100644
--- a/Documentation/git-range-diff.adoc
+++ b/Documentation/git-range-diff.adoc
@@ -11,7 +11,7 @@ SYNOPSIS
 git range-diff [--color=[<when>]] [--no-color] [<diff-options>]
 	[--no-dual-color] [--creation-factor=<factor>]
 	[--left-only | --right-only] [--diff-merges=<format>]
-	[--remerge-diff]
+	[--remerge-diff] [--no-notes | --notes[=<ref>]]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
 	[[--] <path>...]
 
-- 
2.53.0

