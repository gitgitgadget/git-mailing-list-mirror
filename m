Received: from mx0a-0024c301.pphosted.com (mx0a-0024c301.pphosted.com [148.163.149.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94B926A0C1
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.149.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278387; cv=fail; b=ECdA0I1zXyoV0uVFsrHCUIYujY0G+pJBKXp/kT1wzaJXkp6KSMSaXcPauOYl5QXJClP8yc9j090zzfKj04UA48czRzF45h4SaQBnJBhiBGQ47wGs35bT529CdxRc5OFdjVBC5FualcbBeDyrkNB+lRBXaTd+9BRgohALuVJmFTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278387; c=relaxed/simple;
	bh=JBZU0sqNhF27kKBbgPGcKwJAkMTGx4dhMRVhxw900aQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=TDsVeG4RL2kOujKkmW/OxD+1PUbWxVMWYJPDgfqM0oHG/ys8NMDrNCBNk4YZecW10KXIz+WVCS3N3LXcS98L4HMw+YPcYXWGYfxt4bLjL+1Xm81iPuCCltNkm6Zte3YDhCE0DWHLhGD2GZrRLhAofADhCot4zhnZEMLLt/jTJlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com; spf=pass smtp.mailfrom=silabs.com; dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b=VEo5isGu; dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b=K0vImoIo; arc=fail smtp.client-ip=148.163.149.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=silabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=silabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=silabs.com header.i=@silabs.com header.b="VEo5isGu";
	dkim=pass (1024-bit key) header.d=silabs.com header.i=@silabs.com header.b="K0vImoIo"
Received: from pps.filterd (m0101743.ppops.net [127.0.0.1])
	by mx0a-0024c301.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A7HDNA020020
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 04:17:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps12202023; bh=nE6MvaP2w/TmV+9/Xifs
	UVyVDUo5CqOs1+mCg4loEzg=; b=VEo5isGu14147/dhBY6E5CHB8+arRSepaxnf
	C5e71B1MTxOmRrJ/UiMezFcgcCxSmSWP02jYgf9NuhGf3R+Bq0flNfpR8+MLX87A
	qFus/1zhrX0XR9A4jncnrkE/1zajy4nJIDcrPnrVvxDheTq+OCaASqY3AFDIX4ff
	Ki28ak8MhapGH3I/NVLkylECoWZq5i0cZ7lpraWfOgXzNzcwij5mSQ1mlP9b0rgT
	YIa/PbS9YDFdVzZd2BEXM9qtfbT8LtSCjoUmm0mrXk6JfoghlWz7tdkBNEV+cnzm
	JqBWMiPVqwaSFlp6d+S0ii63lUt/nWEt2xRBirlM+qsMlQh98A==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by mx0a-0024c301.pphosted.com (PPS) with ESMTPS id 45whh1k6jh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 04:17:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWfnN+7swLgecwzPrVmU7DWEVOKC7KWx0sQRZ3TZQU9XeUFDLzUmIfW8tcHYAldSCS63SPKZ9nMo5idDO05OPEF7yl1XesryUVl9lfugYo/9FyDWr8YsAxE0u78BWdBVYXHPPx99hXVyAYLydz7VL+7laTCzr8VR3vmNvJb9knkAnnQVayo3lMV1MvgJt3USwBE4Zt34TgwFTKTTAXtjGbgERewpW7jtetk9/BBsPsqfi2MThH0k8I7MV7/G32hNmU2CLdwkS0tPwAOcJtsYnosA9UQ/8AorqvKcuhA5CEiY+QOzerhN88IMDqN3mF1C6o76RbfPw6EYxwUiKb+umw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nE6MvaP2w/TmV+9/XifsUVyVDUo5CqOs1+mCg4loEzg=;
 b=uEoWryF+G3bQJ3Ec/at6KJ87+vJ3+ssg7sRQ5h7EVfPir4+qq9XzlWyS3rDZdsEO+1xF8N+JDFYSXecmr/mKZU2mKbXuLzC8jK29i8H78M1E2Dgg/4CWQGfoD81COPfHZnE8+W9igzN9TwKrizW4h0YP3LWdSJt3SUDNSmXItLdllq22j7gfnUqmICOshz+9KgLVkCA95UPx7YLpggdzC0tdnJHmIn0Fgr9iXZjBD0fMGLv2jwfOnQW8wE401Ru1pRu4f4wbM7tNOzLLrs/4Vy8CuIedjh9DAfboraCHsw1Dlb3dpeWH/+XrtX2oyEgFuDS8NAx7x6NroBMkGoBCCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=silabs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nE6MvaP2w/TmV+9/XifsUVyVDUo5CqOs1+mCg4loEzg=;
 b=K0vImoIo/GtiPSFbx0K2KyK+yJiNYYXvEaM8YlFU583J6q9+ZQIBkIm3D+2bgoZ3kVr760pVwdrGkJEWx9vw/mlsCUtLVrPXlhYbx5Rl+AApLTd8raujPuaqhqcBoh6R/V4iprYRnjajjzWs/3nyhFWdNQR8wJwoRulCq5C0elo=
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by SN7PR11MB6728.namprd11.prod.outlook.com (2603:10b6:806:264::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 09:17:40 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::e78:8cb8:9f49:4005%7]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 09:17:40 +0000
From: =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To: git@vger.kernel.org
Subject: sendemail.smtpPass is truncated
Date: Thu, 10 Apr 2025 11:17:36 +0200
Message-ID: <2020782.usQuhbGJ8B@nb0018864>
Organization: Silicon Labs
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: PR2PR09CA0002.eurprd09.prod.outlook.com
 (2603:10a6:101:16::14) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|SN7PR11MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: bf00d93a-9662-4f82-468e-08dd78108ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|52116014|366016;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?M28OjqS6nwHrKtFUKqyrX4zecbtxYrNri2H4ESSmsmL1s9A6Ujy0UMFb97?=
 =?iso-8859-1?Q?7dXmloq7hIYUlHZfoLdN/lNuGIf2jkMrV29E+Mexa/F4s/O1pRHDELz7zR?=
 =?iso-8859-1?Q?c1O9fKSxCcUbGNkXkCHGkY5PxhJz36HW6iCO1q/YMYa8gsyAhSTZElOB0t?=
 =?iso-8859-1?Q?cS5ljsUjOEOm28BdXQ7eUHS63GuzdOMB+6mpgZuhvrbxiD05vbkq64EKaN?=
 =?iso-8859-1?Q?2UAzEO6oPE9W2liq7dqqZ3MGcYCyNJgdVAboLeWoYrHqTPceiEjYuNj9FQ?=
 =?iso-8859-1?Q?6LmeVd6EUQHkaoixc51Funz5iB/Q58ce56t96viEFeiBSPAbyXiiZRT0BF?=
 =?iso-8859-1?Q?miVsB1V1rVbWDSdOcbk73gwWO/Xz/VvVHmyCP+fMeHGeq8/jex+zLRabzj?=
 =?iso-8859-1?Q?allZ6ymWAkIByf3PisYMqHaY7Q75GQrnryNuLsi+F8+HYhxiyjxkEcOtq6?=
 =?iso-8859-1?Q?ZZ6mZeg4fZMhHTyfdEyo12ZNMxOgvDlxLxNI/lsMfqBmhfAnmUxi5YX6EN?=
 =?iso-8859-1?Q?3Wpz7U3aqZICubi6Pcp8NG+pc+o5vajgGm57geF54CJKuPpswDuFOjeSFU?=
 =?iso-8859-1?Q?Z1dveLi0i9x8nS/jFZ1XAh/0RY0rIIWGsOAmzitSrBqryFbqUHfOfwhI5l?=
 =?iso-8859-1?Q?ZfEZQ9vD4qI+77oODv0leVi+q7SCGr1dK7jnF3JhdYDLSwvHLFY6le6DpQ?=
 =?iso-8859-1?Q?MrHs0xVmlQ3QWSTNqJC0BgT0MLk+Lv968zE5ap6yCpxffMi3Mx0DqOT2I6?=
 =?iso-8859-1?Q?Y37IkLUTx6SorRBeFGoTH0NfwTAEs59IJoqsfLia25I2rD1y6szmWPVVqS?=
 =?iso-8859-1?Q?OkZeKdiyojRhm2+NGWsFuRBr6P6j0c63xoddyJJun5DT1viPdzGIxcF2vh?=
 =?iso-8859-1?Q?y+9+6RrLEnCVfAFkd/oHH63w8mScO+O1ZAYvXln7Ho/0wGcTNlurfDCpIO?=
 =?iso-8859-1?Q?3GcsNNaWx2zwc5bw/I/UG8smMMYbZ/SX4IJ6dl0GjjoNlNOGdqo6jVYcX/?=
 =?iso-8859-1?Q?bmzjcdQd8tn6l0E/BsfIWYvAuHdbb/O63s/+X2DKbBs2Z3xRccUTRdrFqx?=
 =?iso-8859-1?Q?WrujY7x3oUDZJ28XToUx6NJUdGVyZ6/MkYP2aZRa5lPyH+RQ5+Xp65Jkru?=
 =?iso-8859-1?Q?2oRp0L2uhamAO7JvEdcObFisjIsApT9xAw6r8BYB26cYo8p08f5ASvKgFy?=
 =?iso-8859-1?Q?RXW9pJeY6SPT7KOJO11m0FFz0qB2Yax2KHer6Tpj/w5eK9Jl2Ikdwg/MaM?=
 =?iso-8859-1?Q?jOAZVzwK/HuXRSqOqjS4VancbG0pmXSxFJS9Cgt3ZTKuUOVDbeHszv3UPJ?=
 =?iso-8859-1?Q?VmE1n0u9X2MsgHGk6XLNlDca14CAwTCyKgiYA5YrtFdMeRcEN3xOD5D6UM?=
 =?iso-8859-1?Q?KlO/HiRd/8SSTvCro7kqvLDvfIYFF++1P0tNxigBj35YQev24MWCtnBQiH?=
 =?iso-8859-1?Q?t/BLWJlT5Ia4ORGdMRCGjZz5079nychfFnhtlvY6KUuMsfSZMRoFfa9FC8?=
 =?iso-8859-1?Q?4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(52116014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?jaWJ2uypz/IGZUfOQzDCFnYnE3QltcClXwtQJvoOHCJmsJW8u3hnPIl2tH?=
 =?iso-8859-1?Q?7DlJTdFa3G1gdHmfyFB/e9Yzn3Du0iu/jFbyGX6mbFM16Z7R2vOqLgnaPX?=
 =?iso-8859-1?Q?jAo9v6VvHmFvMJxTfpIbCybC2VUjvCGeS0gefQCcecoTtBVUtsmAZdgiPd?=
 =?iso-8859-1?Q?YtAWwh+Jfeq1oHbWtEOSIzkzgxG60egi9wSpK3S23SLvngvGSyo5yKPtx1?=
 =?iso-8859-1?Q?iFLpyM+UJ7hKXtQG5E9OUxqP6gRR4hRQ90Fuh4XIffiNnRYzbWiuHagNa6?=
 =?iso-8859-1?Q?cn1PJWAfouS6XsWYLPsY1qiO1lHcNraVLOPAlJ4/VLvaBEGmFWOVcJ6aOS?=
 =?iso-8859-1?Q?mcxh675Xa5rAMVBC4KKcP2lEXY9AOKtLxUFupJTawUUM0q0lzayqvLjXot?=
 =?iso-8859-1?Q?885ykD0mim2OJHp2Ge/d4EjCpO1NntEYVSjAm/EFx+FNyDeOHnH9wpUGSi?=
 =?iso-8859-1?Q?0ADr3zsXBIENBCKluzQx3LF6ErsDSJaHQFMtekpg9VP3T5Kk1t3bLb7RZ7?=
 =?iso-8859-1?Q?Sq7aNTqeKX4SnC5BfND3Gev75TsQh8jXeqkH/Ozm+6jYv5YGYGS4PtIEQW?=
 =?iso-8859-1?Q?E8jM2yZ1q/wtP6+GGWID4cw7koe35nH8K5MTMRkESiwUVi/pxEnPPDI/4+?=
 =?iso-8859-1?Q?QeGVNsF68t1RJg/4i84bormYZAsoEXN3B4SG2cI03ividd57WEfqbRFcZN?=
 =?iso-8859-1?Q?/TMhibYdPyX12ws4JmaselZrp6eizviviOenztcMUfXVonDZy6zWNxXZLU?=
 =?iso-8859-1?Q?U467Bu1vMOts2JTTgCIixjmyj1jwq3a9GACtu8LYH3RrHGIuxci4wxWAPp?=
 =?iso-8859-1?Q?G1pVKIdRbJxDC+ZQaiwCtwgfe8+ZkrzDS2vA4b1e4h0DwxidHeS8RU+jRo?=
 =?iso-8859-1?Q?OHw5v1tO88+kYJoJ1drVQdjhrXhcUi+TbhtRemUh6Eb7q1Hd1ljdslSC72?=
 =?iso-8859-1?Q?Bu+rdJbfacucTAiv8b/Q9Z9RuJK5dnJnkbXAiv1BLxhd7ZcIn5AaBl3H5R?=
 =?iso-8859-1?Q?/IAuNblt+rjbFL7BEqbVyifsJzdzMeA2NDTHf3xjEIKAFVU3TvFkJ6TOwi?=
 =?iso-8859-1?Q?4MHFJ6WHCzT36KxE9WwlkjVnis1SAY8SwbQ5FDPkMwh9gX2iBJpKisuR15?=
 =?iso-8859-1?Q?pPO0fqyPSnrREqAXIHSaHsYmdO2szKF3/QwaWgMHe4fzIiYrHtflunL+RL?=
 =?iso-8859-1?Q?wJfAnQ5UGza6xPJY8xwXWOwXZtyxDlfrweU2E+Wu5QtghN8fOZej2ESuyE?=
 =?iso-8859-1?Q?mpEdGAkJPYqukMDfUqUZP7VAH9kpDHgtXipA+iKDU2IF5k06fpNvG8xWX9?=
 =?iso-8859-1?Q?DRS9oG/9AzTk7iM5no0nyAAMwuzD6t73Jxnyp1K8U4ZuLQMhAdocGtPCZh?=
 =?iso-8859-1?Q?B7LikLuG7ZcpRtZKrVcoi/3GaBLOLnYlKLCODUjA/XbWBfE6N8xBB/Phha?=
 =?iso-8859-1?Q?+MXsDSXdh1Z/2tlml+iv2fc8S6F1+5Zukl2Nm8KrtbVYnj9Caw6NCF7/uf?=
 =?iso-8859-1?Q?8WPTd/R5KXiYhubbeZMHtyYcPrxjOebE5aSfYf/+dPTwXfRLFW43ztPiz/?=
 =?iso-8859-1?Q?5Caw690y/RvfNaD1PsU1H6SdJwfP+VTEQ0pnPSkUYgX7PwfecFGJ1sbgxz?=
 =?iso-8859-1?Q?x500KBgqkBCfEcKCeDEACibZ7h2vghF0QNe9j5v0R3mgn/SFTUJ9FFbjcM?=
 =?iso-8859-1?Q?AVcBinC2O1RP9TcrntRn5kLdhpyNZTx0oIgurNDI?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf00d93a-9662-4f82-468e-08dd78108ab9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 09:17:39.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bVkdTxK+baVuAjfoFT7yIUY9W4HSGdg6/8bLCapQT0oUYf4IcSqdTJn07vRR/vnm9q5T8tgV2oTpPbWMzHXf/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6728
X-Proofpoint-ORIG-GUID: hns8j6hEU85bYxY4R5LsptvBnEeOUbD_
X-Proofpoint-GUID: hns8j6hEU85bYxY4R5LsptvBnEeOUbD_
X-Authority-Analysis: v=2.4 cv=D5BHKuRj c=1 sm=1 tr=0 ts=67f78cb7 cx=c_pps a=X8fexuRkk/LHRdmY6WyJkQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=LLPZWm0_0O8A:10 a=i1IsUcr2s-wA:10 a=62t0Db2yXcgx0OCB4LMA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=943 clxscore=1011
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504100069

Hi everyone,

"git send-email" started to complains my credentials were incorrect. If I r=
un
git-send-email with --smtp-debug=3D1, I can see my smtp password is truncat=
ed.

"git config --list" show the correct value. I am also able to properly use =
my
password with "--smtp-pass"

My password is not insane:
  - < 20 characters long
  - just a mix of ascii printable characters (no unicode)

My password contains characters like '#', '$', ... So I need to quote it.
However, I use special characters for while without issues and "git config
--list" returns the correct value.

I have successfully used this command 5 weeks ago. Meanwhile:
  - I think I have not changed my password
  - I believe git-send-email has not been updated
  - I believe none of my Perl packages has been updated

So, I have to admit I have no idea from where the issue come.


[System Info]
git version:
git version 2.39.5
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.1.0-32-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.129-1 (2025-0=
3-06) x86_64
compiler info: gnuc: 12.2
libc info: glibc: 2.36
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]

--=20
J=E9r=F4me Pouiller


