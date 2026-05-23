Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BC35CDF1
	for <git@vger.kernel.org>; Sat, 23 May 2026 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779532772; cv=fail; b=MyBgDKvi2j/FNaxqrAW8Qc0ml77+GlrOMQ5z5MCdRNPcCFIwgQ3uc5V3rPbkFfBuL68XMp36pXoMXytgiaSTul8UPgS3R2ijaBdZyA5vYZzR2FOr+W+EuHc7nXLQoFauFQKXYC3aYn2Q+AN5kQd3cJMZ4dFj29JgkZssScpnUlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779532772; c=relaxed/simple;
	bh=lCaBe5qJpFeSnHlkIECzNn4SlDrfC19xIoxZcB9cY4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o/5b9gK6sBpJRNLBvx9W9wu4UHMidhghuRPk9fh7L0GSvKOlvHS3z4/4wwxwYdGJXvAfQTKHeEbbpHfP3zHiwfQRsVjN3yRBvtTRsLpLZ2JSZidKhTdIQhcDf1ZgKYOdCGLnUc+L0OaKn+vMq/xgHZ2U0nXVAOJ112+UFUPV8ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kN3ugmDd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UP8yKwNF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kN3ugmDd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UP8yKwNF"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64N99ekK3617572;
	Sat, 23 May 2026 10:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=f5ywQv/rhsuqZeCDhqjC6WU4EZvQgW4j0cWKvbHLEzw=; b=
	kN3ugmDdrUYwt7ZskGEytgNjue6i+GcMsR+pi6d0lGnZUtNNL3si5d9VEtbv8Npl
	BW7wd12VxwbKAjQps+m9lni07iQ7Dm20Eik5XA1H5JTq0H8N0qDP7UI8utoGzinx
	wQeL0sdlE8RRtRm4TlVVBelNg+i9WIjLd8lEz23oVoisj+PhOWmaQpKEYCe33+GR
	98+kc9o2ATZUGLvj7H7HR9EPigxbTY+o83Wzu/oSplkPuPHgEjtYitZdl9Wlao4L
	TN7bQvapnV2v3nyIliS0q3cBhsfZbVlnP7KefOT0BCH0Nt2StkufOEvgi0ODruhl
	mBu7G8BEu8gEovweOJEC/g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb495g6vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 10:39:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64NAYnK6014936;
	Sat, 23 May 2026 10:39:18 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4eb2pcrwva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 May 2026 10:39:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZ1sLBg9/nHr2nK9J2DX4ns+kMdU/7axx+NvrwwjtkZhTgbs0GlFjhM1ZEcs8FFtXHTPEue6nkoSB1umyHx8Ru9erzoyMFYoEiiHbIjmj0VMydXcQqvB2m/gI8JCTzWXm4+/7rXQVlj3ldBDbdx+sUCjK6p6zWyM1dhTjwaI4XrvYjEABMBFYozSKiOHfTkzfFE+hQuGTC5WzkIlf/Bw0gh1n0tD6LUPur671LSnt2vRlJy7Ya/WCthzoRFEApF/8WXaAaJsiCBnx8KUIpePj73Z02ot4erqLYC+S5SXXdcifYnw/5oj7Dkaq5WEjfD+GkDV0NOduNlMTzu09YBAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5ywQv/rhsuqZeCDhqjC6WU4EZvQgW4j0cWKvbHLEzw=;
 b=bGrvAbhW2sX2j7ikZuJ86X2gcI99x1azK0FLR28gCwwYejanatNRSPdC4Ip/lzbYP2qYYq5lBXbsqRpIWLfzt037Q4VgHbYdFICmoEgv08dY9yHWAJ7+QCXF0N4a1TcLisGD/aGKj7eYex4OMeqn+cQRbf8a5PvlB5yTydViFFEmF+vJEXxeMzwFZaO+C9tmYPLfsEkrK07arqIil9qsMWADFCrniwF/WX4ZHr/C36hIQgbm/Utibcpt8jsMo2k7y5BJgb1BuxVQlQV9MUZBVaXMf9QAW7fSRpmmakzd0pEYfSuMcS5/khfVx+3nHo5GGc6pfInLKNyt5WkQxbxvyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5ywQv/rhsuqZeCDhqjC6WU4EZvQgW4j0cWKvbHLEzw=;
 b=UP8yKwNFgX1b2uBV94hWBK2Zy+cheEOPoEayXgKGLpCGwu7kpTLH4Dra2lFInwpSdXZk8vFPMm41qaH8UatRO/GWxNxwFA4grvmLBD81stiYuzlLoH16F9X1FQlaLNGiRp7p3kNFmj0sqfO1xMIoenFUqhQ1ex8SszzEt34p8H0=
Received: from DM4PR10MB7505.namprd10.prod.outlook.com (2603:10b6:8:18a::7) by
 SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sat, 23 May
 2026 10:39:15 +0000
Received: from DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c]) by DM4PR10MB7505.namprd10.prod.outlook.com
 ([fe80::f14:5389:d117:967c%4]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 10:39:15 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
        Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Elijah Newren <newren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: [PATCH v3 2/4] wrapper: add support for timeout and deadline in read helpers
Date: Sat, 23 May 2026 16:08:10 +0530
Message-ID: <49efc097154be9f7c387ecbaafcf54e612028d9e.1779532562.git.siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779532562.git.siddh.raman.pant@oracle.com>
References: <cover.1779532562.git.siddh.raman.pant@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0151.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::14) To DM4PR10MB7505.namprd10.prod.outlook.com
 (2603:10b6:8:18a::7)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7505:EE_|SN4PR10MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: c911e2e1-7050-4f92-7b83-08deb8b788d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|22082099003|56012099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	nUOZ8IygDUCzZ+8G+RDbwyt/uruxfg44sABuDTKyfF3LeFIIxirxummEcs8aA9UJ0Up1gH1Jjc6uhksJu5+xghnPfDDltNrNqNsbN4K9Nj/0n2zCiDAVzrWmAMk0cDCqr8UXBQu0WI7USSwpsMcCS0BjF7fzuSm3L0N/5T/6ypptqpSJ93oz0m+TE9Z2D2xZjbER25ktU7ktH1jozvtM05fdjKtvTIiPcYLkJtWVrXci7ds9q4ZbaDcjmpDMT5s+deHQSBCj2XIYbLSU82cK/NKKrbG+q+h+9TowP5O0IKKHg+ozxvtk7bnocgucyjAPhBpxe2dA2qeAmvjNeWSornRpuuiwNArVaaKQxRdBNdq27p4zQtcHWRrfoKITHOTIT3bN45dP9BhFv95s7eVSxLhUNyjLzHumlTeiyo79HNttOQsVsrV5kmd95o9TjPTkTC1mYFajduzJpB0DFBz+hMlyGUX8ZqWfp8/ygF2Ze/MHaPc3WyINNJfcFN9LfYUzO7hp7Sk6Vr8GwvQnQ2Bn7wouvw6Zq9vAo6KIKoUffvFeLhNMxZvvFhPn4NXgP1T56RKMXYnHxpfDHHKinCVBVVF62VRMjtx4cAZjb1Xzj5vVdCDwRljZNWH1YrKGu8RoaLLv67R1MO4HitoibtouFxAN467EcNTcFwrM4G8orG3k6DrEXzuctF/MePgn2U4s
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(22082099003)(56012099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gvw4pe76B2BO6QhxjW3UO7b5Je60mnaQqtFf8FBm2XWgxhvsFngJNSuIi5V2?=
 =?us-ascii?Q?gImwTKdWLtbBZjqiJzE+/HUjXDqR8vP3Dn+RD8J17mrFv5qrJxJ/q7kyR1d5?=
 =?us-ascii?Q?NGWlcVE7QhLxeG1i0PeIWJtq0/T7orS7uCXf/c88bUsIJqOfLw7DE4yzE2Ic?=
 =?us-ascii?Q?sPfhujJ7QN6XSwJo23kxMMzpWsdkVH150FBMs0VkbJfRe40vdObQ0Q9yXT7c?=
 =?us-ascii?Q?k24DjOE7rAExxrF7tzTuGFNaQ5dWX1tThj3k5T5NlM/aAytffn6l1EKHcEU5?=
 =?us-ascii?Q?3OY9rswR/vdlN6uh5aZUyRUUy2Jo9k2KDiqf3Pu+qgE4RoWdWTVrJNtayv19?=
 =?us-ascii?Q?D8+9AQbpKnHcSYti9HvwHSFLzeOFAsK4a46NAnojxP8jLgYnwIu/2NZUdMyP?=
 =?us-ascii?Q?rChjesWqWQDO/MfA4MuXeREPocPdSLwmpJCwKTAhvJd5lZCH+KuPnd3X7jNx?=
 =?us-ascii?Q?xNLOUYeA2mevPkuhjvUeOUEsrEqwm2lDOZqIwnTzKQsfnEyfD4l6Cns4Dunj?=
 =?us-ascii?Q?Ll8xUzAdw1BhfqaAgqsbMGrDImVS8BksAEtn3DEwWf7CLh5gAR/FmzwHeK5z?=
 =?us-ascii?Q?3WlN+kV3EmeBJjlurkPmv0eYVVO/78UXhrncExKNjOEt9HRb/ujS2y2DCuG/?=
 =?us-ascii?Q?8tsRv2l6z1ixUKYN8Yc5pOOIebLJ+WbE2oB07L3qmIo3a1dY29pwrEsmcaS+?=
 =?us-ascii?Q?1WGdp7Or7KsIXe1f3EZfNBms2PmQKK7RrImPJsHbfu90ZvgoQRRre5NcHmp6?=
 =?us-ascii?Q?IZel5PmzThXo97P44NGbJdLI+ul+Xdx0B3FVdD1SGbewxjiFxEUGKhq3E4Im?=
 =?us-ascii?Q?K3nyEuQFPjMB6w/x7LTEpwtJ1JS5OBjfhUvhReK40O6fDxa4Wn0G88KFALDc?=
 =?us-ascii?Q?LodqMXLKFBl19Mz5yMpeDzvprdYlb1u+iB3JISEtsHQGLCfgs8iyOYTQFY8G?=
 =?us-ascii?Q?EikBDAdWN+I7c+BBUrJm+6dseIGmZIa9/6K9twuy+GcDuYrj8p1rMJ5CJBPW?=
 =?us-ascii?Q?9rywKmXWs5XVjZ4YVzmAQmLaUR7t3d3fT/r/0Acj1qxW6PKIaGvDgkTyAowB?=
 =?us-ascii?Q?XGL5v7SMHdNjw0skEzMm1XP5SIqHlkG1fLs0Yf0Cs+LtEo/BbLxaHK29BM9n?=
 =?us-ascii?Q?pmOvUEgF6w9pijcnIZA899gTtZR1rxvcUfp3g//gb4tksDBpFvHrF2VOGKXE?=
 =?us-ascii?Q?1/kKcZD7jfx8/battRSdB60ezD8/t5qKZM+AXz1/3SBKaXTA3kc1mkiDjjsJ?=
 =?us-ascii?Q?KKCT2i3q1liu4Uc/omzInaUHsxO1a6HCji+/DdqClHmGhNI13B+vGpSrsL/w?=
 =?us-ascii?Q?kNpVHtbvFBZcvYsemdpOUkuqT6gVzXsL8B05ktpCTFjvtxU0Yqwb9uKlINxD?=
 =?us-ascii?Q?QQfw1Z0slLJKPb64s0rnnZbBimMckVYm8gVd5iQESPVqekYCkCXDR3JHcJIR?=
 =?us-ascii?Q?lFOgEknhUv4zsPMU4yr6wlh7ASL/AqP34TC1gdE0uHjgviw+QeH9nBa627S4?=
 =?us-ascii?Q?PbVmexOLj1lDXHEs3eDF2f006Va2UWX3CQ/WqTKQvzimZbQFS8u+k4i+lLFo?=
 =?us-ascii?Q?qcULD51yMIGhwqFzyytyLM1yGuiuOVbCbnUZyIeKjj7vCRvQQ1YFQqNnWBSb?=
 =?us-ascii?Q?QVWOHN7rCsB8CI6/U+Wm1TgTcZg7p1gznKQjLdVsB5I2DYevq4532FiNkpst?=
 =?us-ascii?Q?VYeqOFrMYJJPglDjbUGsmwEJx5l7bZsUMJF7JyDcFcHd/XgA82PBX6l7Dyg/?=
 =?us-ascii?Q?YEFibCztCOaH66wvZqRX3OjC4myrTSS+3oi5CnpD6lyNes1mU3JFtNv0YlAk?=
X-MS-Exchange-AntiSpam-MessageData-1: asNYRHEEBI+45kvBbiAu5cCLG5qN7ojEWE0=
X-Exchange-RoutingPolicyChecked:
	V5FREXDEyqwBQC2oYlmlXWLzbctdXGYui1GAB4cfc2yjx267Ehl60xekE4jFWsrGYEOzFso6Ens/Yx+XgkqpJv0XN6ULIt4k6X7SmeFq5pHiZLWJ08+m8GmvsOHKel8me0RH/X4GZK5mT4IXiUfiDe+bENwqblc82tJL9oITQ6GR1O2rT8H9nt9CB70a7kCchHwkLXX/HPV6wBfn7Sf7EyxYjBSS4lUuJuxsKZz4DGj8y19aP/OBD0eVN4/j4+am0tVX45n+XV3cR5y7D3gMlgisGeHMJ+g0b2UWc3XGXpPz4bnRtstm3u/0d5oREU0B8muWRKLVVgSsVs0Rpd7VdQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TB/SDoF8EXnUMQBgvp1KGShUmZWGqByVJ8QCpFJzEP63Phs8ey+Haxi1NMZ4Zj7qPTk8fVoOMRLm0H72yq7nEMv6Vmis8LUHvudm8NX0LLzguJowEM5AwKiK9wT5/dMNJTz37ETls/if4H+b3qD8kPHyPWT/r/f6Cx7Rbp4Fk8OBMAcocCPMm1gwTbGUTz9yCvOnvTzOH49igQSOOcFg9Y4QS+QWj50O9cHZj102yAcyqxOSUmdrWxLgnJbz6m4qLODMhXFUEW2aBF9Qzc01DfPu4ha5FG67fdkiAlB/pAUDTf2reb0g8OzCy/F4uYQnS4QcUx8MPPIGOCjzGHRoqf9Op9X9r4ZfUaWMI2fXjX38xBrqvDIf+6/Q/nrWEdKrHADpDWsezVCb2DTU6T29wxxZlosNS+qN/2jVHhlWsa10gF9a6pMu9g7bUUw/WRK+4dj13HMlwHLYc3IXCN1NRKsEjTm6v9etu79MCfBdTuFxgB9/7Lzm8syrqguSEnpWqXXIkXRHyJ6EgWulluiA9rZh/YELxBn8kydjkH+rv81FcY8Xf7oeUK3+BGYmjb8opUCQdX6D8+OHecF+nGu+nPrtBwPStbS0/vI948jrzN4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c911e2e1-7050-4f92-7b83-08deb8b788d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 10:39:14.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JFMbCBrHoUzS6t2uTsz+pN4LFGbDy81yAjaGWp5Xfjwt9QWfz2cT61Fria6d5vrRXMp0tJ/OF+O40WpoNj1VaoMhlzE7r1EB1J1yKj62HA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-23_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605230107
X-Proofpoint-GUID: hkrcgn-0iJBP4aANN0uxRZl_wRE3RwLl
X-Proofpoint-ORIG-GUID: hkrcgn-0iJBP4aANN0uxRZl_wRE3RwLl
X-Authority-Analysis: v=2.4 cv=Ld8MLDfi c=1 sm=1 tr=0 ts=6a1183d7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=ElfticSEwONjoEU1SbMA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12301
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIzMDEwOCBTYWx0ZWRfX8T+IbUGG2ZuF
 f94qXaHOS9x3rQl+isU//GO5HCDGC6m2/AOc4frIxW56zVtQpvY+sZSxwHTbW+VcZIaqnR1V11H
 fDYemUxZB3iWLs0xRJMsNY/srE3gvwFknUj162fdxpDg/GWh5Nsn8q0E4bBlAiQO8lUvPJKLb0K
 rgQWnqjTG2lG2PiZZHczFHjoY/qf75guv2Q+abQO0vY5vhEKlGsektVKIoGsd9DMiP2QSUQ5El8
 vtqotDoYvGdX6OLZuSotidXHMNEtOfPiLCaRJFF/ISx1M81gzpqfnlMn1qkGoxoTT1bpE0Ngoft
 gizoQhTYIUziS3eluxbNCklxHPeJOep+kcfD9PUGHDLuMAU+mlMqljC3CrGKdJgUW8JwHDW8Cke
 B0o1z/fBH89tgHe5hQ9zJlMEMU0KG4ueHfa2y89+pRAiU3xrNlrgkM40bas3dcmXGHi+T5AQdhy
 e7FLsb9oxrbXbffPUBGwY6ypnzqBO4SKg48MzglQ=

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
index 16f5a63fbb61..1f42845e031e 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -9,6 +9,7 @@
 #include "parse.h"
 #include "gettext.h"
 #include "strbuf.h"
+#include "trace.h"
 #include "trace2.h"
 
 #ifdef HAVE_RTLGENRANDOM
@@ -220,28 +221,129 @@ static int handle_nonblock(int fd, short poll_events, int err)
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
@@ -283,13 +385,15 @@ ssize_t xpread(int fd, void *buf, size_t len, off_t offset)
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
@@ -302,6 +406,25 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
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
index 15ac3bab6e97..10d85c467b86 100644
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

