Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3AF382F3C
	for <git@vger.kernel.org>; Sat, 23 May 2026 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779532772; cv=fail; b=PoS2zTwEuFGstbwDCDsYdFNBp1R4c9niHjW7aO2jDp6B7CnEXnplt4qd2v4hR9GBUS2DULMQPWJlsA4H2/kqedfAehbvAF8aCicotECofTAmuYF5xgaFl0Wwyp5iB4Wz/cbsQTn2LdVC89/VpjuOgBiW7ijVKoJAT1juJPmMqTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779532772; c=relaxed/simple;
	bh=oN/bYL8VwcXhQc0zbU37UhFYds3Dibdn7ld7g0Jg308=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZG8fu9eIb/d/2j9rpQzYLmzIMThBvcu4HM3nk7JP36dMTa49Hjwu+S6VLx+OhLnbpxlICi+ZK9HSrW7vPNlB5N2+9UHKbVX0e+Nwa6zPu5UK6edLvtqUmbG+ZaKunTkiYhrC7TeleftgAzr4gjxfT1Vt6c6GCWgysA5a6Mn1qpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VH7LzFu4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AqwQILYZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VH7LzFu4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AqwQILYZ"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64NACOgL1250201;
	Sat, 23 May 2026 10:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RGGbF4sfJZh2O7JedZ1lIRVqc0nSz9Du/1COYshP1do=; b=
	VH7LzFu4vJJKcqxXzCykNOr1+kYKgriOKNbD+sUrWl9inzdbEsCQCH6asJVFo8em
	1tnIpbD9JG3IL9wAhsfpnvU9l4gMpwQo9FdcLQ8lcNINMcJMRRNm80/EsivTyQ8D
	9P78neruBxw+zMqyBZnw5PfcxiOcRD4HTMg63GT7y52WmRvmz84537CnJ1d4AywB
	2wB9YGVTt1DgLnUfg6w/az1XDzrHCTkBTegKvZOHpRReVeUfOrtYjZlksi5Bvnd5
	QsqfvquLzMfd0ga4+hXGHPlJLNBxaNWv8MolPqG3qg9BfYDgoJ5OSxLB86vcy9jY
	S4v7ayyPXue26hJqo/97Hg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb4sq06ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 10:39:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64NAYiEB031358;
	Sat, 23 May 2026 10:39:15 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013016.outbound.protection.outlook.com [40.93.201.16])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4eb2p6rn8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 10:39:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOfpy8P5h/oLl8h5bwrfiKEPiUJcWXQICO7z/QcZ0kD9qUQ/n3h33brpXqrr9LeeDWG+ncY4lkEqrdlIc2K+TUgmhFZS3NLsxM0P1p+yS4bsSRw5ZlSqMaJRn5Mz2gNQ/FBy+J6BbB0h8B8waOHEzukx4JMBZU8HqUC9Z+ngPlrTlXl15xZmZ1qnBv7hq7AOiOAC+EfBOZkQRyvKRHNWEEvzVSaBs21PKTxC0wU0YNJHDtsuFn07wU4elIkpYxcL9AOFyYbMRGR5UkzL+lHw8dorsRKjg58ibgi08butuQ1ws5PMro4FfWUu6P8lPTRxV6lMZYXgmYwUuodnVDLFyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGGbF4sfJZh2O7JedZ1lIRVqc0nSz9Du/1COYshP1do=;
 b=js9i41cSmqiPc8z5JfOUGwTcR0yvrHNY3ZUqBEJF9+sB2oqcOmAASPfvEWoNbUMkL1JN88ZF75b9WhGYYkNiJAPyfYPR6V+/A7HVk156X7VADaLB8ka2voIteZjB64c/DWQoKQVBtEZvEvxXajeX4rNZ+zo6MDBim3mMNRk1k4HFDfZSctWgEym+2eMSnglXL0rnqyze5I6kh/6/VMSP3p6R1l1wSmmLpndqWMXErq9vC1qMvfyESX8fVvxmHN6htuvOlkmYpl9xV7TFaMLQ5xl0oPCxgVNPQHcEWebCeDOrieajhfk5FZkzzQX/EGPo8QZz/t3FkxXFi7KQyoQ/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGGbF4sfJZh2O7JedZ1lIRVqc0nSz9Du/1COYshP1do=;
 b=AqwQILYZwb/sbbsH1RcaKrsqk6LIu+hzl5gwVeObLDXgP/0eqrtaSaez+GA5aGPG5Y6fJSkV8HyAgJdo5EPPmjABpUdBGquKEbNFpx1Do6xdpht3SGu+dj2/md0f08Mkg6d9QEX6KHJkYX8Hgwy62wQ2F78fkk+S7mj+Tj/4nK8=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 10:39:09 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 10:39:09 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 1/4] notes: convert raw arg in format_display_notes() to bool
Date: Sat, 23 May 2026 16:08:09 +0530
Message-ID: <f5199e24faddbef3edcc69bd627590c9fccf0db6.1779532562.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779532562.git.siddh.raman.pant@oracle.com>
References: <cover.1779532562.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0123.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::6) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|SN4PR10MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e300fe5-0ff3-4580-5f47-08deb8b7851a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|22082099003|56012099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	0Uoz3JJzmjvL67x4YOj9qxEYoDtM0F2YJkYYrNe/D2BAzwGokWNlr4tE6m0VF+lJIjSDFzTpKsAXSPABmRt6m7o9ej0vo+xZ8h0cdvsURSB+qACSlnh+EXiZxZCIVG1bP1FRBJ4Cmc/g9nJV5Mbf69xbWQM81h+I5Qijt1B81nPxcnU+7McbeYDBU6GZj3kn/AjQqnqFhXA7Ff6RCDYSW/vh7Qnxx2udIqDx0SL01dL11noeBUnc5HOAKlcp15ZO3DrCW+uCnrBR4t3hEdAEe3C2OdtyiEUWAJxeZNK4mONwLL2kayFlLcUsN874KaIbWR00SEVzjH7b8Qxi3oKXRpuJnIfcljr1y0Xy8HjoHYH/w1MpsMlpAUj54UuvEiHiPiyr/UyYf2FVas4x+AuKZ19+haAciPtppFnvoaTCD6W6yJ4LldG4SXDhtdoArJcHJsh0FoQuLit31ZvZ01OtngngvhDqDBSILzdlfc1yqdrxa4Ihur2oubOSipQ0sZ/rtWC3ijG+Ank3KxsIg+yCQMkaM/jtadw0lt8y7jTywEvNUKewpOAjSpg+ST768lJJz9xwO6xpRrHl6MPI5+01odvYKOO9d9WKOpqiOpiWVV5ZEJ3M0dXk2Y3R+6qLxMZVscgBCTJWvDtSkoMLpvn9UmXlmeiCbQgeJkxHbDOhiFH649wn9I8AaO1OTZ78DpL9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(22082099003)(56012099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ZbY23tijGNmZEpIy8+1EnOaHQBywlR2mOsBBtT+b7VEth16ldphbc8T2kW4?=
 =?us-ascii?Q?UXsKOxO0g2CejqzrLmTjgyAnaE6xtlhjySVGAgO7kw9aK/qcMkpPE7+H7Luw?=
 =?us-ascii?Q?M8LhION7Kd1rpjPV7cHTP7pkvRyXynYfdxY+3UjGdKl6+IPiQnW+HgCMEOnT?=
 =?us-ascii?Q?Znc0sPyNO4pUUGZMApWaFq3VsX6JTS6/D52oisSshxzzzzEIkfXkIqGYC4uq?=
 =?us-ascii?Q?cp6mtm0zGXjxsvnISlMzWntSrXBYVh2T/o3r++nD//sskuBQ974TG/ikdb+Y?=
 =?us-ascii?Q?kpd73EFmLJQB6p5VEb+G9TZeAH3tuzLejav7QGkHumMZzTuv47AkxbymSZ+v?=
 =?us-ascii?Q?FZT0u6WmEoOcGJi6yyv/FcPwgaMUHJDJe/OF45naZIeFdUKaKX3SEYU/m/xt?=
 =?us-ascii?Q?nxEPZOeac9FDaRk+Ehi5UXv3k5M/sc4OjqADafLp6apqrrRdZCySNTmSCsaP?=
 =?us-ascii?Q?ZsCJtVabn6q7AREfMWE8JmdXkPklu6RanTrx+sR9oQtZzkA/fuUM9mGNbIR1?=
 =?us-ascii?Q?JEPKismYuxD4rZcmqGrjcmnPS5p7cGmVeTrGcQN7X+3Git9GavduwLRAZPoZ?=
 =?us-ascii?Q?k1X3SlJTLXAzRhZCrjyGDqbsZZD074non8DoJCnppwmSxPXipGcXmptmsmEG?=
 =?us-ascii?Q?vPTD69U/eRExaVMHGRWgyaj/D361Y6BEJGXiFi41LBQW2q/FSY5tFn0eHPSQ?=
 =?us-ascii?Q?osKPlUFm5Uk8pUZlomJgRR8HDjFKSWDtz/Cr4AIyNn0X2ghNzIHD+A4o2aRv?=
 =?us-ascii?Q?Xx9FneAJQm72ypGcgfPHxNKDZ6+3VWzzsqW4Z8HVLuEsTT4ww7l40RS/5SH9?=
 =?us-ascii?Q?7+np4SqAFmdalnrl68lLYO/jx7VwUM6QwjyHXone1ZGRKJDih8BuJ7m+3WG9?=
 =?us-ascii?Q?KZ+IQ/X9KV0sT0LQCp8xPgqvyG/JFqZfXGSHkIeRtQ9fPknNgYJyATjm772m?=
 =?us-ascii?Q?Nj166CweRRHe/3jts1f9hreilDHvqf7vza/8L2wLCKND5JhEI6Sb6C5QEYu4?=
 =?us-ascii?Q?6w8AriPYYxv2L8kKDW7hvor5DVPR2TErYDiFiEwG4EZotXnH6cKzVpaFq+w7?=
 =?us-ascii?Q?2Q2tNS2xOnulqnQzMa7nu1tISvG/cyh+RQTq/tCsS0SVl9pHdpC1SvHtcvPY?=
 =?us-ascii?Q?thEsQTDj0o1PSx0c9JEMclcHx05DzPE9obwxnQTIIJe9hJ1PWZavzyqbZG2c?=
 =?us-ascii?Q?vkwXvgUcwiA/Jm3AhK9gDClOCs9OBsUzglGTlPmcYY+vDqJlm6n3TiKLDaLC?=
 =?us-ascii?Q?RVq863fo/dznDaR/0yh1H4XoM/G8qMoRhz6kj9gzHFRMo/GbbBYEwCGxclpC?=
 =?us-ascii?Q?Xq5KFn9OOaK5F0tIcascV6XD7uk3515cb/BNcbCsAVxnFIv/xQwdZx98gbOJ?=
 =?us-ascii?Q?MBu5zne9+3tmVYo6D3EsIk71r26b+itucPJH4ndjKPLveDEUF9yIuHWCOfBv?=
 =?us-ascii?Q?VeWRqYRTN2hAbFiOa7SXLmgexEDllYMwlZU9MM0FoQMza0ZrzvKsCdgcqkpB?=
 =?us-ascii?Q?r5ecC5Vsam/C/U7pmOeXmyyoL1Knpt5eAvxG4xlA/1xv1G3V/MHUsadaZObC?=
 =?us-ascii?Q?miciieu5HIs1Su77V7skx7mKQ4KWNLcLnHwEnm90DDhDcADuMOYK0VEjd6KU?=
 =?us-ascii?Q?YQB0CKLm525xw8PiOxejUWr1z4xcCQyfdHShQgdWJQ1jH5Eac8mppFJM23C/?=
 =?us-ascii?Q?b+Rk1k+KoFDbyFW01CZzm4ck2tr0BFgq0rCswehfQU26LkN9dxTQBM2zNPKO?=
 =?us-ascii?Q?shEbdaDTm0wTe5nwGPxa3g/g6jt69viIGtMjq3SzBd0ppzDlxFRkn23mJz+k?=
X-MS-Exchange-AntiSpam-MessageData-1: VyL+2JxtPrPGXRd9xZSwf1as5jIWo/KMTzg=
X-Exchange-RoutingPolicyChecked:
	iDumIJnARAXPGPy34wjrEmkBxExGKoou0uGcKqfZNM4rk8JKeATxsq0RQtdcWQbnP/2Q5Ght+DpGwbDNplz1GAmizy9JmWrIxqeX9pTZQfQfrKgdn1dai0w6TXQ3SHDRfYs076af6ZlZ188oq1Gp281n94ItF3Vub5BxSSvEkNaV5rm/IXyUHURZzX1B3UuMtG/lfP/iPxYD4m7qx2slcsYWpv8uUGh+pE5TXlp+DwsTgyrmE9+w+YWzmcLmkY4LNrQcpWjTMBTpDei+6vzeKbwChnUEqNJwB0DBdKbeYomDNpqGlCGuvE3Xns9AlpZDBuNVIOYRdZJNabLxCjqaPg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b79doSRtf+Syoy0v6hl/FH6A3yGbDRgdhgli3bxeRnXbTMp43MlTqqKD3DxE2XARDVb6P8k/U3933i87c69pjhG9Kmoc+9UcasvLyqWIeT4gwH20toDaYslBBVkcIyvhi2ubOym8Ibp+hHfv4NK2y/uIq71ZQVNxvXIvNY/NoGLDoR2VFvg1fGQrX1zJ8cu3v0LAH/s8a4GliHjv6LfqsptfJ7zjrj5RkfZBG1G8LzG4mlXTWoc3/VwQoXJc1cob3EZa9PoUe8CQXOC0NYj8d5bsXgPzytKG6O84V2FNXo6eHArWZe+lkz9VSDza3VDrMn4Gw/0+EG/idL3L/WssHpmYLHaMedSkWfl5zQT5M11XAA62TSyI1UBOhQwXlXDnD5cSA3xNlsDempqlhKyADQPEPNCdjtdWn5qB1Gtdt0ok54q+k6aXLnfR4YvzuU1FW4li/5nC0NlXaFbkic0EtwGrlKDS4o9EV28h2A2LObL20owB4rpN/dl9OA5+QymZu20RAa5p4FpYR3tz3M+GPK0t5FxRNuMpZEsaTqlERaYkExMbMqpiM9PN1If916wUFhoTk2DnjYhGnr/JvMeWyFYVLbaY42nWehluit/DMd4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e300fe5-0ff3-4580-5f47-08deb8b7851a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 10:39:08.8375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqqVOpLeLquB3NtayGUK2UR5XPzgXVDE4A1BCm95BdCmScbDvI8S+7NprzWRLfmYjv5JgJHcQijoEeWE5AnWPOGXwSmkBi1oV8+l8ZuiMeY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605230107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDEwOCBTYWx0ZWRfXzVQHMdcLk6SX
 aFhP+T/yQpQCDlpuPOh/TcKCNY2XY7vXM6Sf0e134m9Cqw532H0EkN7JgEV4HEM8ElTBWUB0oIl
 hByJqHuuHq6Ikjh9sMI9yB3ZmzcEFx2DBeEQFjcM32i7u/5Dim9cd9LVcfoxPaP5023gJ4K+GZr
 LhFRl4HyoTmNf0MzGx7ldQmXu3Gv6ux+RNdKAAOh7JUoD0izp1wTRKhN0ilBP0AZHE6SFkoE+rY
 bvv5XIsnHdszdFQRzipesjNnCzYVP2hVaaFCXVuWmLvufOiGHz0LGFTabqpZtzXS8Hx25JhqkMf
 mgq0gOxubmrn4y7Ue8pZTo+1trMNe3Eo2yq3KCW7G0xQyGUfR3qftW/V0UAC5l1tw3KEo/en5TV
 hqq2xWg1FjtlSZvPYXKe6STYpIiExLDSBVHmGn2tlcPpq7nQMoetDwc34NtPZxjzoRJSxf5+sQd
 LvqPcrf468rUIzTSy1A==
X-Authority-Analysis: v=2.4 cv=eNYjSnp1 c=1 sm=1 tr=0 ts=6a1183d3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=5U6ET3mjoD1Y2LAbGjMA:9
X-Proofpoint-ORIG-GUID: dA0tIxOwzd-LhFeb_ep1yajAT2nEG3OM
X-Proofpoint-GUID: dA0tIxOwzd-LhFeb_ep1yajAT2nEG3OM

It's used as a boolean flag, let's not use an int.

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 log-tree.c | 3 +--
 notes.c    | 6 +++---
 notes.h    | 2 +-
 revision.c | 2 +-
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7e048701d0c5..4503a42dde6b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -854,10 +854,9 @@ void show_log(struct rev_info *opt)
 	}
 
 	if (opt->show_notes) {
-		int raw;
 		struct strbuf notebuf = STRBUF_INIT;
+		bool raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
 
-		raw = (opt->commit_format == CMIT_FMT_USERFORMAT);
 		format_display_notes(&commit->object.oid, &notebuf,
 				     get_log_output_encoding(), raw);
 		ctx.notes_message = strbuf_detach(&notebuf, NULL);
diff --git a/notes.c b/notes.c
index 8f315e2a00d2..201f1df3dc29 100644
--- a/notes.c
+++ b/notes.c
@@ -1273,11 +1273,11 @@ void free_notes(struct notes_tree *t)
  * If the given notes_tree is NULL, the internal/default notes_tree will be
  * used instead.
  *
- * (raw != 0) gives the %N userformat; otherwise, the note message is given
+ * (raw == true) gives the %N userformat; otherwise, the note message is given
  * for human consumption.
  */
 static void format_note(struct notes_tree *t, const struct object_id *object_oid,
-			struct strbuf *sb, const char *output_encoding, int raw)
+			struct strbuf *sb, const char *output_encoding, bool raw)
 {
 	static const char utf8[] = "utf-8";
 	const struct object_id *oid;
@@ -1338,7 +1338,7 @@ static void format_note(struct notes_tree *t, const struct object_id *object_oid
 }
 
 void format_display_notes(const struct object_id *object_oid,
-			  struct strbuf *sb, const char *output_encoding, int raw)
+			  struct strbuf *sb, const char *output_encoding, bool raw)
 {
 	int i;
 	assert(display_notes_trees);
diff --git a/notes.h b/notes.h
index 6dc6d7b26548..f6410b31e1c9 100644
--- a/notes.h
+++ b/notes.h
@@ -313,7 +313,7 @@ void load_display_notes(struct display_notes_opt *opt);
  * You *must* call load_display_notes() before using this function.
  */
 void format_display_notes(const struct object_id *object_oid,
-			  struct strbuf *sb, const char *output_encoding, int raw);
+			  struct strbuf *sb, const char *output_encoding, bool raw);
 
 /*
  * Load the notes tree from each ref listed in 'refs'.  The output is
diff --git a/revision.c b/revision.c
index 599b3a66c369..cd9fcefa0a88 100644
--- a/revision.c
+++ b/revision.c
@@ -4107,7 +4107,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	if (opt->show_notes) {
 		if (!buf.len)
 			strbuf_addstr(&buf, message);
-		format_display_notes(&commit->object.oid, &buf, encoding, 1);
+		format_display_notes(&commit->object.oid, &buf, encoding, true);
 	}
 
 	/*
-- 
2.53.0

