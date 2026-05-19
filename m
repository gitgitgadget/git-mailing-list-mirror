Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31574963D2
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779208283; cv=fail; b=IcYJyBUA2zF/aexhcDGBLqD6VUSeq8/j5NjPdP6Lfmi3zibfvPcOr5aVLsXRcGJ5m3JWTtDaiD3SYyUB5OTgfVZmD/JDu/7xl5/9QK+4BEKXALqIvLIFuPdlq9gNcKT6L+q/mJV2XtofUvpAWz6gNoR1u5l+GqwN4C81JRCKj1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779208283; c=relaxed/simple;
	bh=YAWjd8j3thbDGP/pPPujl9Zv1DLkSAQ9wcoajz8ukvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7H4pDj5Q5fEr+5G68D4AQlwo38Vj7/KOYJPDW7LjvuEycJX7e/kyDVuWs7QrwZ5Sl3cviFtLiiW32WDFyT9FotIP7w3bEDOTXswjyOdbn9jXrWAGOp0tJDBsd200+vYg61D9ZUv7iTL5cegEFFvwWUrX0Ght4dOoclZFRlMBsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J58/QxIe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XHO2JE7H; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J58/QxIe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XHO2JE7H"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JF8fVV2763493;
	Tue, 19 May 2026 16:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rIPZgl56q8YDhuMavf3+2wNvu1aGvHlGvnqrhcm/peE=; b=
	J58/QxIeaaqQs6X4xfj6zyx+EhAFz2bUSVjBAzJ+ZJVLN8UF6xcJs3Z72NjLFP4A
	ThbW6h4rCCEq4TQn5ynKmX/Rm40S/IRv4vi5byGHdl/IilAm4nLx51RysUgrP8Cs
	sy4Z03motjROl/EOqFe0YbMEgvwuNhzdSYLQrUH1JfANiiB3Dq5bydvVecRUs+tV
	O3vmQwk+B9vuUeUUW0IZn2dPC72b7LNDn7DAsnYsUnq7L2TTWDTMc3SbMuQ7wIux
	bc5/ZfzvWImOxBb6Q+jlGZUmH3JNldU+3rClL2ActC/KGmowoe2hWZqZvaA2AJh+
	Qxa1DDzqEdDrrHTpocV+vA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e6h1svyx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64JGTk4k011829;
	Tue, 19 May 2026 16:31:16 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4e6f1b0s5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 May 2026 16:31:16 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWfGaDeUjSNJ+LftfFJU3shy2WkS7A9fahJNO7GtJVyz/NQvy35dmpbadsgI9WEy4qFI8CUzQxg+zfHNfyofqmR61l6nMe4WKbfeO32hv1NtB4gTl7iObd99LToysCC/oiy1sydWPmoS5NBPROUFerhKkiuvJpklbFyVckZwQvYYX/P6R37PaYwGVI5g9OKvCXrWFxvlgZDjnmUkXOynn3PTp3Rqeilcv4i2yYmu9Q6uP/tOQ0/ItBCV5asvtINuSVxwFLpeiuVNr3zBaiEhjtIYvy5cjV3EcnB9InDMdlyurszFhSA3993SRk/QRTtx2G2Jkrj+pqNFvRPp3VRqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIPZgl56q8YDhuMavf3+2wNvu1aGvHlGvnqrhcm/peE=;
 b=WI/TACr8O1KGRBgpKHWeO/9rNNSAoi5m5VKeqC+HAMgoPUvDbSW9Ja/M11VU0JJTEazP0KAd+Sax7fsyBsuL9lmkFd/CYIueyGgGG63tQFM/BO5KMnwWA/lKUqkZ7j/xMwZG9orFtnPNTC40b/XJZt7E5NsLAcuqUztJQDR253q2z3IQ15ihMWL04vuaL+VKurZdRsali7s3rCwBdgrBvOnyAdvvUkNwmVbZSgW/F2/3mfs+j6NLO37WdQljMoyIXm/gZPxW7K6hrvnyXcC+JMHWAXYOVnH66iRej0hztJfzTWe/kK0tz/J/h+VORDzbaKawZffZajuK4TbSYWd04A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIPZgl56q8YDhuMavf3+2wNvu1aGvHlGvnqrhcm/peE=;
 b=XHO2JE7HJ1B08fXuAWPKHkWDjUX4U0fEdnEaJmsDOiSdCwZemaQwxR6Bh/VtCkCr5ijtcJGjHiM2u1EnaklvAObuaROwHGxse8P8X/OIjvxY6cGHp63ClFxH57KZ6KKhILcNQB5tz8N1ZNa/ZX+cmUPFk91hVn0m8yS6+pV0X5g=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Tue, 19 May 2026 16:31:10 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.013; Tue, 19 May 2026
 16:31:09 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/9] wrapper: add support for timeout and deadline in read helpers
Date: Tue, 19 May 2026 22:00:34 +0530
Message-ID: <c5c1005bae14c963ca1f717c3a82200e4ec7a5f5.1779207350.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779207350.git.siddh.raman.pant@oracle.com>
References: <cover.1779207350.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::28) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cbed54b-34bf-456f-078b-08deb5c4088a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|3023799003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	IIBjKEtYHPhtyTYp8I5hGU/RlwZE3ShDTmKts6KQykeBPnUox5mVI64L8RZXRJYmer2rBtrUkwozYR0mf/UZsgt5ne33JWcp6JpMwAM3IGkkc2MwDBrUsnDNkAi/mxQ3xGLAc03rJzX0a87oVbLbc4eeR3vj1HbHZD8yxsrKvMc89ExM5Q6DRGt9rIBI2vg0lNrzZhfqT0RLmrgZCeKSb2LvG6e4HMn+ub8je5Wsfhxsqh4WnrSO4jtvr5hDT3HIED237WJ5N0COeTFhJCd/N45Nx92vjJxZtpC8HYSYTv6EmSPFOKAV/2Ce2A1fVPtIw9BwBio99rRWb+C1EXOIfoqDK8yDDp4BKibIA/WFT2JCqJYcNkIlNAjQZ70JbgsTiYHsMLEpLaJcyEyzZJUCiCCcmS3FOQ+Ex/L1plED+/bMTbouA3Hi8Y0uMelCY3eLwZkPNNe9dcHUlm+wZ+La1JDSVCBNr659T0HwN4aNXevQBEQnRLKU21FfFMJf5KwE+MYd4XxUcb4ed63VJqhWX0j0/rwXRBXYhZ8pOoqQqYZ7x6LWQ2WLZEfI057AyFHch8gnpSHY/Z6cNHh3dAuVAw1Ta3jchlR4x0qpq79ZH7uDNvF137tVFa+c5am9HOS1TLEbO54WZd1zsLrpMQ6KrIIR5IeQ1O5e1pVEUExU9XiS5UjP1HXIftBUiKYz+Top
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(3023799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6yOwmkaSb/bem4M6zx1IFdLovwvhSvZqPiCWkm/vlLRN5ueT3RGlxEIzwtab?=
 =?us-ascii?Q?dhfQugLLErBvQvpJkLdwkMg9nwNYM08jBwnpQQef7l9Q9Vn2wWGrc6O+rPzc?=
 =?us-ascii?Q?jkGxKGqgHMX0PgyQ2WStUisDnuZJuutlX0mAhE/6faja8XtYGifcLhQGwbmo?=
 =?us-ascii?Q?lNJkbjUTonULeujxCVwVXguZUcgczPkMwjD1zoVr0KheZR9dkKns3BwvPa6m?=
 =?us-ascii?Q?BtuzRxxJf9XXl+G3JV65KvSfNrQPu6gSfiormQ+gCya4uCyEDtFypI44oFG2?=
 =?us-ascii?Q?c+ylArB+t86VzRXbPd+8AOqY3PmuYxrnGDsBe36njSXe2TVAzzOVqIB52BXR?=
 =?us-ascii?Q?UR11Nol8Gs8cL/7mLJpYyO+oaopcnBb/129gsFaZL/Z/TRWcovR6NtzFv+FO?=
 =?us-ascii?Q?Sbx/G5TD9oz+thpLk+7PA6JszjxkJak3um4K5znan66BNkOe7biwo4PL/xx1?=
 =?us-ascii?Q?DR+NEO6MUO62bQtKeLZRynbtuNFmjntKROLDo/vJ/pQdcNbp8/a3+VED+6Pu?=
 =?us-ascii?Q?hMAp9mc658v7mGHpZRTE4ovg+W4VMP2H45xaqPhjgxe+N6kCSh0D3D2IBLqE?=
 =?us-ascii?Q?ihwSgvkZNEUoNqsTPLoIBJJFW4c/1ErmfzxqN52KlxhpzZqiflouAR1vgg6U?=
 =?us-ascii?Q?wYlps67K37yfghgSdmlqzCtcXuc8AXGfpPKdTaIOOpUChcqIJjcmZG1E5Rlp?=
 =?us-ascii?Q?6f2sPbf+ehAJ8LdjifU8+qPa5gLGpnw1sWnrQj8Le68Bk824rlsP+aKID25F?=
 =?us-ascii?Q?AlOcoWpHGECvTuphTBYzjQ2O8JGMsjBOqrRVcoEkC7O2wRBAF1GacA2GTNpJ?=
 =?us-ascii?Q?WmNXdN8AxQjMTI0kXNjO2xZvgpdxr6Oywqp+pQaAk21tD4EfaD2yK8m3VMLo?=
 =?us-ascii?Q?oDOtySlf7nN0zMUH2oWmHIqZZobA0+Tf1W/tVD6jz1Uj90KpDqrZpOXPjb2t?=
 =?us-ascii?Q?VIvmOQPJW2cKbZAcTAwd/NO+rSWQmZSetlaJRkgkXMY6fHqVdG4PqWzBB7fG?=
 =?us-ascii?Q?Iu0XeVknLhhfMFKMm7blY22+HGyoAWo7G1E9FKOyjIzCxUl2x47zSmFSIhUa?=
 =?us-ascii?Q?yYZuQSNaYCQwNsAKFdvygSVu+lPOS5Mvk1ikIARQmj3j5JrWC/XL9NLEqrj0?=
 =?us-ascii?Q?/Qz0X4YzMdGXDrBmrkHWHGuNi1o1JnDpY7C5RHc00obkq4jFg/y9IV0SsghX?=
 =?us-ascii?Q?SAggaXc8vAqSnGY23dHojTXb15pcAigWwVGU4eyybi3WZQWhHFObmRgvKJhN?=
 =?us-ascii?Q?Gb2UzSvQVw8oaRdTAyasUh3NUe9O49V8pqwT8Vi1BUko9tpH+mINtWslzmJP?=
 =?us-ascii?Q?VE+MeFBfW2HsiZKfY6UKGpsodOl7FNSAWnoNGJsm73Ux6CZkjRcIh8Mxa9LR?=
 =?us-ascii?Q?QZ6oaoCpYo3QZNkaobyWyE/kUjkN7tmKRyrfRZjGUJQ8oWld3l06NScXGbxj?=
 =?us-ascii?Q?6c7ybUjj5zoyS083RzlbB5cK9h2tsLpe0rzI4uGKEiWMpZV+dOAgiZbhm7Cg?=
 =?us-ascii?Q?paYN4YeZS/T7TmSEvOGHAl55f2NohihhsT27xKCpC7nCK+VQWYhjodFXyc57?=
 =?us-ascii?Q?IFoVGFj1YprYAtK85xXD4Xo20rHMJcRXtD8/QTvKsYHdrpNnCUrTME3ZUu6w?=
 =?us-ascii?Q?ct44JETqv0+p0CrXb6PH+9sYCCJjS/g81wyLPvAFbEidwpHKE25xMlenL4Nf?=
 =?us-ascii?Q?lVeySvohY9pPi5KHso/BKk5p59D2iaeyCAf1cyxInL8QkUIq6gSApidhhtgt?=
 =?us-ascii?Q?P5ES/ItG6CkWz5bxUQg0E38ei3SIdlZEcGmlpbVSZsz5wPdnP+nLY6Okk6Px?=
X-MS-Exchange-AntiSpam-MessageData-1: iB5mYfs64Qju5Ekx8HXN+nttI6YuWYHO3iE=
X-Exchange-RoutingPolicyChecked:
	KEcKoEx9jLnS0tNrttN4Q+cEhu0p0g2gnmusTQ3d86uJSE6/3Pp2R/+0GmaP3hkeXoTuOBKBDW3vNI4GWJXcN+iaPCK3/eCpfaJqPegEB/pl1ladnWvRjqAKJuH4mHSfDdUOiBT4DQ8xmiqA9nG3C+ZSlyV/ph9umE8sh3oxOAma71UoX6q7LnOerPnqK8frRKgnbydoEJA5Wf3SmR8D1Vo2bsDDMqiOCZaUvzETDDHvoTe2DPJvbX54prICPCWAJxC0b3gg0v0tX2cFm9FD1bfpw4U+ATFoIPywQLdNDbye6ftdPVLjcWpF+y3UTkbqWj1+DTmh4SN8v1nWj1B1Ug==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5appdULvhikkIBieoQ7bekD0CX41U5fisSTR67rdUx0OHV0miFdFfmzsC93780dY9DMPt9RhIikTePidCobL+8ohwJAc+pRTKZXgcMPQDnJ83xh5lSr62KUuME7n9PtGguGTphc4qh02OkTQPlQhLbQ0AlxUutjMfNfLOH9KBQQLUcYVMnmSNXTM6Jc3Oo1COcRwowafAXq/DGXI9EnK/mr6mCTtGYsMHS3wXPDtAyfGbzAOBqbP0aSBKebcF6vn9VpSa0yyC05UBz6UrUn2tYJW1KSBnTdEPv/6NcGS0KSk4Bl8eVYlKuTdy/GGp3HBAz3tuL+wuCjmNXlDLqSsf2y291UtgNvWJUSGLvtRyIU0CYpgZUEYh47r6n+pOQuhU9EhTVoJ0bCm/y6kExyVhplzs0rGAVbUNCiAiUjKiLs947nLKj2clIJbYaDNj4Tub1wTeYUIw8vDiRi4rrHwa2YCTYRNrSOv/ma+YSvMtB0OFQCNPjVg3YBa/gPVepF17PimA4z8EUXnNZqyVFZToR+SOeKSvVRa8NetQHg1ijkKa/PydzpOaw2J2LvSikiTAZWz4gzYxNnxOdhXmbcWEY7/Knk/MFmMWGSbL1U934g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbed54b-34bf-456f-078b-08deb5c4088a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:31:09.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaaYRATwvHbpvvWKK324O15o2kDOI9AJNG8bi7H+ORjz42s2aU47bmvazizt6ewVdobT/5cLUxtj4q7LSQpjxqAVF6jSlNvBiPcZp5A8V+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605190165
X-Proofpoint-ORIG-GUID: sF5jbY9GtVIwBDRgmuUxPrdijVXwAc5H
X-Authority-Analysis: v=2.4 cv=aoKCzyZV c=1 sm=1 tr=0 ts=6a0c9055 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=ElfticSEwONjoEU1SbMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE2NCBTYWx0ZWRfX09hTesEMOtDz
 mHMZ11+bNsDA0YjLdukGXGphb7Ta+ZFdAV/EGoLRN2FwRr0u+ZAjU7xJWkTNcB8QOpkZ0418hn8
 m4qMlpUd10yjtMMs8oIlu3/KX0X8QgxhECgEPXEMnUGVbCUDpXoFaAi53kAQhU2zT8N4YXr+/dL
 /O1vJU8GzEqePWbyqXMvTNMO4NskdD+RMLDt0aWLaln3+6xFqLMRtLNxtCUaXBnL3Tr4IbewGS6
 4M+18qlBt78K5g2hcMJ6ZtkUFsABmV+wI37ohoTCd05hI4FFKMPI/68C5k/q4aE3z1GWY0XPmV0
 bfBLlmRE3sAYbi2kEBN8ZnCfOGTo3xcMk6rWHv7h57hdENCvnZdinp6ynyl3bkkAUFSH4pKwlhY
 d4LUDqDdg6zNmUtNUHrh2LMGQCdRUh0U3xXRBa+qtwCF+4Lpxmev7BH29AjxXaHG5L0efXwVueK
 7Rwwnw6M0mSZSl9txKw==
X-Proofpoint-GUID: sF5jbY9GtVIwBDRgmuUxPrdijVXwAc5H

Add read helpers which allow a caller to enforce a timeout per read,
and a deadline for the read in case multiple reads have to be done
under a common timeout.

Assisted-by: Codex:gpt-5.5-xhigh-fast
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 strbuf.c  |  26 +++++++++-
 strbuf.h  |   4 ++
 wrapper.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 wrapper.h |  23 +++++++++
 4 files changed, 182 insertions(+), 10 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 3e04addc22fe..b3fc7c624aa2 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -749,13 +749,15 @@ int strbuf_getline_nul(struct strbuf *sb, FILE *fp)
 	return strbuf_getdelim(sb, fp, '\0');
 }
 
-int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
+static int strbuf_getwholeline_fd_with(struct strbuf *sb, int fd, int term,
+				       xread_cb_t xread_cb,
+				       void *cb_data)
 {
 	strbuf_reset(sb);
 
 	while (1) {
 		char ch;
-		ssize_t len = xread(fd, &ch, 1);
+		ssize_t len = xread_cb(fd, &ch, 1, cb_data);
 		if (len <= 0)
 			return EOF;
 		strbuf_addch(sb, ch);
@@ -765,6 +767,26 @@ int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
 	return 0;
 }
 
+int strbuf_getwholeline_fd_deadline(struct strbuf *sb, int fd, int term,
+				    uint64_t deadline_ns)
+{
+	return strbuf_getwholeline_fd_with(sb, fd, term, xread_deadline_fn,
+					   &deadline_ns);
+}
+
+int strbuf_getwholeline_fd_timeout(struct strbuf *sb, int fd, int term,
+				   int timeout_ms)
+{
+	return strbuf_getwholeline_fd_with(sb, fd, term, xread_timeout_fn,
+					   &timeout_ms);
+}
+
+/* Non-timeout version for compatibility. */
+int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term)
+{
+	return strbuf_getwholeline_fd_timeout(sb, fd, term, 0);
+}
+
 ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 {
 	int fd;
diff --git a/strbuf.h b/strbuf.h
index 06e284f9cca4..f896da1277a6 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -535,6 +535,10 @@ int strbuf_appendwholeline(struct strbuf *sb, FILE *file, int term);
  * descriptor.
  */
 int strbuf_getwholeline_fd(struct strbuf *sb, int fd, int term);
+int strbuf_getwholeline_fd_timeout(struct strbuf *sb, int fd, int term,
+				   int timeout_ms);
+int strbuf_getwholeline_fd_deadline(struct strbuf *sb, int fd, int term,
+				    uint64_t deadline_ns);
 
 /**
  * Set the buffer to the path of the current working directory.
diff --git a/wrapper.c b/wrapper.c
index 1349255f1eb4..3e0d65724e47 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -9,6 +9,7 @@
 #include "parse.h"
 #include "gettext.h"
 #include "strbuf.h"
+#include "trace.h"
 #include "trace2.h"
 #include <time.h>
 
@@ -221,28 +222,129 @@ static int handle_nonblock(int fd, short poll_events, int err)
 	return 1;
 }
 
-/*
- * xread() is the same a read(), but it automatically restarts read()
- * operations with a recoverable error (EAGAIN and EINTR). xread()
+static int wait_for_fd(int fd, short poll_events, int timeout_ms)
+{
+	struct pollfd pfd;
+
+	if (timeout_ms < 0) {
+		/* Negative timeout makes no sense. */
+		errno = EINVAL;
+		return -1;
+	}
+
+	pfd.fd = fd;
+	pfd.events = poll_events;
+
+	while(1) {
+		int ret = poll(&pfd, 1, timeout_ms);
+
+		if (ret <= 0) {
+			/* Retry if interrupted. */
+			if (ret < 0 && errno == EINTR)
+				continue;
+
+			/* Set errno if timeout happened. */
+			if (ret == 0)
+				errno = ETIMEDOUT;
+
+			return -1;
+		}
+
+		/* Invalid FD passed. */
+		if (pfd.revents & POLLNVAL) {
+			errno = EBADF;
+			return -1;
+		}
+
+		/* Some error happened. */
+		if (pfd.revents & POLLERR) {
+			errno = EIO;
+			return -1;
+		}
+
+		/* HangUp => We are ready to consume output till EOF. */
+		if (pfd.revents & (poll_events | POLLHUP))
+			return 0;
+	}
+}
+
+/**
+ * xread_timeout() is the same as read(), but it automatically restarts read()
+ * operations with a recoverable error (EAGAIN and EINTR). xread_timeout()
  * DOES NOT GUARANTEE that "len" bytes is read even if the data is available.
+ *
+ * Fails with ETIMEDOUT when no bytes become available within timeout_ms
+ * milliseconds. A zero timeout disables timeout handling, so reads can
+ * block until the file descriptor is readable. Negative timeouts are invalid.
  */
-ssize_t xread(int fd, void *buf, size_t len)
+ssize_t xread_timeout(int fd, void *buf, size_t len, int timeout_ms)
 {
 	ssize_t nr;
+
 	if (len > MAX_IO_SIZE)
 		len = MAX_IO_SIZE;
+
 	while (1) {
+		if (timeout_ms && wait_for_fd(fd, POLLIN, timeout_ms))
+			return -1;
+
 		nr = read(fd, buf, len);
+
 		if (nr < 0) {
 			if (errno == EINTR)
 				continue;
-			if (handle_nonblock(fd, POLLIN, errno))
-				continue;
+
+			if (timeout_ms) {
+				if (errno == EAGAIN || errno == EWOULDBLOCK)
+					continue;
+			} else {
+				if (handle_nonblock(fd, POLLIN, errno))
+					continue;
+			}
 		}
+
 		return nr;
 	}
 }
 
+/* Non-timeout version for compatibility. */
+ssize_t xread(int fd, void *buf, size_t len)
+{
+	return xread_timeout(fd, buf, len, 0);
+}
+
+static int remaining_timeout_ms(uint64_t deadline_ns)
+{
+	uint64_t now, remaining_ns;
+
+	if (!deadline_ns)
+		return 0;
+
+	now = getnanotime();
+	if (now >= deadline_ns) {
+		errno = ETIMEDOUT;
+		return -1;
+	}
+
+	remaining_ns = deadline_ns - now;
+	return (int)((remaining_ns + 999999ULL) / 1000000ULL);
+}
+
+/* (deadline_ns = 0) disables the deadline and short-circuits to xread(). */
+ssize_t xread_deadline(int fd, void *buf, size_t len, uint64_t deadline_ns)
+{
+	int timeout_ms;
+
+	if (deadline_ns == 0)
+		return xread(fd, buf, len);
+
+	timeout_ms = remaining_timeout_ms(deadline_ns);
+	if (timeout_ms < 0)
+		return -1;
+
+	return xread_timeout(fd, buf, len, timeout_ms);
+}
+
 /*
  * xwrite() is the same a write(), but it automatically restarts write()
  * operations with a recoverable error (EAGAIN and EINTR). xwrite() DOES NOT
@@ -284,13 +386,15 @@ ssize_t xpread(int fd, void *buf, size_t len, off_t offset)
 	}
 }
 
-ssize_t read_in_full(int fd, void *buf, size_t count)
+static ssize_t read_in_full_with(int fd, void *buf, size_t count,
+				 xread_cb_t xread_cb,
+				 void *cb_data)
 {
 	char *p = buf;
 	ssize_t total = 0;
 
 	while (count > 0) {
-		ssize_t loaded = xread(fd, p, count);
+		ssize_t loaded = xread_cb(fd, p, count, cb_data);
 		if (loaded < 0)
 			return -1;
 		if (loaded == 0)
@@ -303,6 +407,25 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
 	return total;
 }
 
+ssize_t read_in_full_deadline(int fd, void *buf, size_t count,
+			      uint64_t deadline_ns)
+{
+	return read_in_full_with(fd, buf, count, xread_deadline_fn,
+				 &deadline_ns);
+}
+
+ssize_t read_in_full_timeout(int fd, void *buf, size_t count, int timeout_ms)
+{
+	return read_in_full_with(fd, buf, count, xread_timeout_fn,
+				 &timeout_ms);
+}
+
+/* Non-timeout version for compatibility. */
+ssize_t read_in_full(int fd, void *buf, size_t count)
+{
+	return read_in_full_timeout(fd, buf, count, 0);
+}
+
 ssize_t write_in_full(int fd, const void *buf, size_t count)
 {
 	const char *p = buf;
diff --git a/wrapper.h b/wrapper.h
index c39992893a81..f8592599216a 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -15,6 +15,8 @@ const char *mmap_os_err(void);
 void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 int xopen(const char *path, int flags, ...);
 ssize_t xread(int fd, void *buf, size_t len);
+ssize_t xread_timeout(int fd, void *buf, size_t len, int timeout_ms);
+ssize_t xread_deadline(int fd, void *buf, size_t len, uint64_t deadline_ns);
 ssize_t xwrite(int fd, const void *buf, size_t len);
 ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 int xdup(int fd);
@@ -44,9 +46,30 @@ int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
 int git_mkstemp_mode(char *pattern, int mode);
 
 ssize_t read_in_full(int fd, void *buf, size_t count);
+ssize_t read_in_full_timeout(int fd, void *buf, size_t count, int timeout_ms);
+ssize_t read_in_full_deadline(int fd, void *buf, size_t count,
+			      uint64_t deadline_ns);
 ssize_t write_in_full(int fd, const void *buf, size_t count);
 ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
 
+typedef ssize_t xread_cb_t(int fd, void *buf, size_t len, const void *cb_data);
+
+static inline ssize_t xread_timeout_fn(int fd, void *buf, size_t len,
+				       const void *cb_data)
+{
+	const int *timeout_ms = cb_data;
+
+	return xread_timeout(fd, buf, len, *timeout_ms);
+}
+
+static inline ssize_t xread_deadline_fn(int fd, void *buf, size_t len,
+					const void *cb_data)
+{
+	const uint64_t *deadline_ns = cb_data;
+
+	return xread_deadline(fd, buf, len, *deadline_ns);
+}
+
 static inline ssize_t write_str_in_full(int fd, const char *str)
 {
 	return write_in_full(fd, str, strlen(str));
-- 
2.53.0

