Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F7618EFD1
	for <git@vger.kernel.org>; Thu,  4 Dec 2025 05:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764825009; cv=fail; b=tRtn6xXujYr1sMuqSH0/f+84Xm8w0Cq4Lpitxvrr2VOxQuY3oxKhqaCxuDoeJNSQxuH+gkAJOULK+Uj3eGZI+vUfm+XvIXoKBIelZa9s6R0Hl85ZLpclgGLBs86lBCAfVyOt0jYf6cSSvhOkFKkmxbuLYeGCQbktEDP7iO3QQqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764825009; c=relaxed/simple;
	bh=jH+8ywqG+nrGA9+AaTRsoGhmHBJv8dMYWNzjV+LIaCI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P0hOjVNbfv90L0WIPHuN9negie9r+9v6enN5e6Y7cvZJpLBHvS5RjdzoQqDBzjbKtXnyHyeuZ0nxlUvzq9n5TXZOy3VHwJYYNzh5zwsnRRnIMJK01FAVgLOVaOuLQRFRXyrVPNuNzRGdEeLSKai6kSwHAoRStfBfogHs1Rurjvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=pass smtp.mailfrom=us.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BRSudgdB; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BRSudgdB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B3Ifug9021771
	for <git@vger.kernel.org>; Thu, 4 Dec 2025 05:10:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=FiuNUK8E9HIA2GUu9dh2hW05u2/t
	h81ylA33mLUTPjQ=; b=BRSudgdBzqvPE7V88RsEpjPY5LNF+LmOqBly0b6GcwAs
	NOmlm/0VqTnzw5o7m/hWPaF9SuoMiWHFvSGPSgsQae8YpIQma7x4qZhyRCp8nERx
	p5GkK7HwGGTfFZFTWHPlu4ml7dtrlGLFrAWEG0rxRx4RWFUapArh3Rsc++qSfpWF
	8/8s1ifWJf5O2gM7pjY1iBd43ezDhiB4H2hkf0LWnfbrJ6t4BAjxoOJKR/thzRpF
	BU4hRz7j5wW6mG5q9E1idvqWvUpBAnXYmFDupEkKKPXCY/U1bL8bvXEz38WkMoYI
	vWzZ7I0cNuDm1wht7aWrejObrSeb2ckrHCBlEAiAig==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrh76jn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 04 Dec 2025 05:10:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kikqq/+Vwc4nhKlBKfKlHueGs+Ngkm73UeRAz8eWWCnsRMAtPmjbkyL3MZWabYwghDTZXHcE2mrSGIuS8E7Rgom3oPe7l9kPf9ImHe4zLSdnRxPYDj5lwT3J69M5aNKSA5XtwNpaaiY34wlNjI+JyCbwwXxDQhHurRuGtMq4h2MhalKSzDdQ62K7NjMs6QirsjaM47BA26jnCsaE5YkB4jAGzzRmIWWHmD5Zlcd/uE/qo58xUZPQSmmjSGmHCiXkPhr5znpaHvt8RlcSyCYMfrhnbtUg8DrTL0X7fBArMv/EMf5NBxYtFDrmZj2U/tpepfTQk+GX9rfgtR7Cu3F6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiuNUK8E9HIA2GUu9dh2hW05u2/th81ylA33mLUTPjQ=;
 b=NyxuevpiMAgpJfKl+O5toijlY19LXkUOuf6YlTWyOnGVYbRlnxBspgpAMQh3x1Yld4+yFKMuE0BZqx1SDOKXSjvIOyK/BjhjqJ3O+cgEWdoka5s8DzR7CMIeiLMh4Jis487xnXGt7z4tXchzbAXfjE9GnThxzyiROYx1f6/TsdY/51U1Ub6OfmM0Z0qWMkHVLMX4frJZf4l2XsEchF2xl/t9jEmN27f2BvMqB4fBBRIJ54b1Lmv2oM5g0tLv4Rstgvw9k1Hp7aD9D0Gs7BaVIW7aDClQXP4FzzhYrGjEf0hCBkqacHmKVgZIhWhKMDUc8Kw7WrE3t/9FWRja7gnhGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from PH7PR15MB6179.namprd15.prod.outlook.com (2603:10b6:510:24a::10)
 by CH0PR15MB6113.namprd15.prod.outlook.com (2603:10b6:610:193::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 05:10:04 +0000
Received: from PH7PR15MB6179.namprd15.prod.outlook.com
 ([fe80::4396:f62e:4382:4273]) by PH7PR15MB6179.namprd15.prod.outlook.com
 ([fe80::4396:f62e:4382:4273%4]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 05:10:04 +0000
From: Mark Boonie <boonie@us.ibm.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Command line query for teams
Thread-Topic: Command line query for teams
Thread-Index: Adxk3Cdeu6cbR8HTRly4quq/URY5yQ==
Date: Thu, 4 Dec 2025 05:10:04 +0000
Message-ID:
 <PH7PR15MB617958EEAF07E4C5F8CDF0C5FBA6A@PH7PR15MB6179.namprd15.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR15MB6179:EE_|CH0PR15MB6113:EE_
x-ms-office365-filtering-correlation-id: 2f762720-ce18-4437-f8a6-08de32f36289
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?A9AnXwqwc/vvvV22RZn8FL1NYTmlTieCMsEkWO6W+ySeercl/NpH+Pg0cNqR?=
 =?us-ascii?Q?19qkjAdT8b5offIZCW+LaaDhpAuoqUcIIcvPi16sP1pjPhHRQPy7Jh/KmBvn?=
 =?us-ascii?Q?33+uy+OVVt9YWlCPg8vr10wN1p3hTgO1rEKcwavpWebwRXACQafjNvIsheXU?=
 =?us-ascii?Q?OsmWvm1mP85GVDKM75JkXHNimmjUJweI4Ml9VpPcbp3pxAKK8NVjooGfqgLN?=
 =?us-ascii?Q?l7FhtIXWVBtvAOqczCWfE1ZURG/JtOrTCSZ7b8dzt4Cjv7XYyOteeiMqp8JC?=
 =?us-ascii?Q?rUOqTU9NzpiFmPOAEJyoQUo9H16OheqgG7gxNxLFTGOSSR/eunfeuaMbpHat?=
 =?us-ascii?Q?RwmKFJWXYfpfAON9CY7PPc6fRwUAauYqiVDeoDfKkIRmeYdB+A9tXG/TbDCC?=
 =?us-ascii?Q?NXgfvDoD32uga9mqaSwSN7XG4xLgzdfEJeA5zHyee4BiDs1g1FRTvS7jPc5Z?=
 =?us-ascii?Q?bFx8hEzJItY4rfsaVCTBb87aOPFm5Kod7/UgA+axwT3ebRUMigq7HjZF+Kwu?=
 =?us-ascii?Q?S6LG/iKrkkWloH5ByyefpQACxYk5TETUHMShYMg5xpQhrFiQwR/cW3IB6OYN?=
 =?us-ascii?Q?UOG6kO/i/6vGGxcTfS1MWH7ZP0yqzJilWYdioGW8+Iyh5Bkl+yFTUKjogc5k?=
 =?us-ascii?Q?JaJLZay/DvMeT+YnzX2u9aPwplV6Q83h+VWZ+Rl/RbVuGhFHsMvOg5eC0c7o?=
 =?us-ascii?Q?McwRkZ7Y5CqspbZUGwmqF0g3g17yKsTZcBR/zDk2oaBXYpJyLQwTEFU1ZSEm?=
 =?us-ascii?Q?JI+ixFh2xjeocvmXymPHjjmoIoroX/TV7DpMOM2rd8m1EB/FZWhViLXRYpTK?=
 =?us-ascii?Q?DZFiaLXnG7gLKksObc0P7ALhdOxY8Uhq3how420j8g6XHtRxvn5AoVWvMLXK?=
 =?us-ascii?Q?WkMBwFdPmVojAA/aZW5MPEVW3ecccIBc6iCNejBuT/obzTtTu2dndT9as+lJ?=
 =?us-ascii?Q?kW41y9ErlhWF6c/PcHx+xxU1bz8/fZ7uz4Ebb2AUGBMOZm7uynFe29TX7w0l?=
 =?us-ascii?Q?mB9Ak9aNaDfycF9DGVAaYR7XkRg5gnvwL6476C4F587HJJrkEgv6iwQpZhpS?=
 =?us-ascii?Q?FGjWlrxWmuRBsAgg99FxIsd+X3FVfqm6qC8u9Wt+LO9l/QbElA/5XSVeXMiS?=
 =?us-ascii?Q?UfUmJ/gjZxAeIvj1ysXlXGZjS1ta9D1nV6PQJSt1NmVt/TX1zYjjpm7p+XAC?=
 =?us-ascii?Q?KbknDuv6rMX0sykj2Ap68X+PYaBopOuBgMeZPKH93qqC8z3eViagckKK5AC8?=
 =?us-ascii?Q?SyOW6bFKtvbHgauEOj8b3Mj7p+4uPnTVU3nK9HsA0+s/M1Y7y1+7PBHo5Y54?=
 =?us-ascii?Q?CdeG4AUOmGvT/c2W6miBC+in/T0ZM8uqT/STQl7vIxE354irpFOAhIjMvpJY?=
 =?us-ascii?Q?aFch7/OYFtQy1ydxVGRL3MxaNeOn0zJhi4K/750nYN5iBXCnJXrFQZWM3yq1?=
 =?us-ascii?Q?zWpx0vsD6eWbbcPMbZqMOC9jgMggWkozThqUHwm+kcH91FSUdj0Q6n3zPtVa?=
 =?us-ascii?Q?HUZOiu7/YBz07r9hSImoeM1a7o99d1QA2KY2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR15MB6179.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?svufpWiQr85q3JXIDoXJ57kMkC6oHlKQkRjw02MOJHZRI5jrDqkyjXmSj1b+?=
 =?us-ascii?Q?a7WSb47ecYulOlIXX339Fl4mGtevP4fl11pgnSj1Jr/UBQbWvO6VHYeBYP6C?=
 =?us-ascii?Q?wXduavVnC7eoj61LDwXWjXbhLJoPHA3Yh5InJABOHjTOy4mmmkICO8kox8XK?=
 =?us-ascii?Q?EEZG2ovdqEPFGy078f3iFgQ6T1QG3yqGLXsBABsfyE3gPNl/A02K4mXHOcdR?=
 =?us-ascii?Q?a4PeEoefnL0U9KqnY6015CrMFqYDsOVUl2J8+IZjG96Jhn1A+onHN0/Mvh2p?=
 =?us-ascii?Q?Sn5Eu7Fe+hDy7Lwg2DN0JmzmcEU3AIpRz/y2mD/jDJAE1pe/JaebB6SWfY9C?=
 =?us-ascii?Q?RvrBwUQpwmYGdRjMYVW4rqqUeIWl3HjGnwdggOxOg5UAk314Qtn4SQFXfj/f?=
 =?us-ascii?Q?OaNUlYRcB1BJJhwTBcMXVkKmZCBBArhN9iQ4Q5VVwtzWlLCCt1iW/72TtvXy?=
 =?us-ascii?Q?coJmsSwuOBLaB2o7KqV3I1zO5c/YpOHWN1gyTtJKhPFUwLJOAU4AeuZ3Mds5?=
 =?us-ascii?Q?HyM2AwlCpxAkB5DIJIw3CEO76ZxNmNi1xJzyWwtE07Z5qAt6NpgLJIRiTNl7?=
 =?us-ascii?Q?CwzegyEVd3w0t8Ie0x09COFWKTZ5tWhLDzZyDvmDB8U+HFQaJTyoaDtPhOxQ?=
 =?us-ascii?Q?BH2fn43IvoTiDyG2Mo9IOMgriiJ+1WwJyr+kyxn/0YOOqrtmZVYSaOSP/ivU?=
 =?us-ascii?Q?JdaC6wZ4c6SJM5KjVajGKQzutimVnxnRdDTCooYbcfkW3JwO5yOXMakkeN/P?=
 =?us-ascii?Q?d9oNawsMk2s0QqEYJ+73ceiULlkRl6rUokvmCk22an1tn74ptma+D+CF9qZp?=
 =?us-ascii?Q?J880jBSZ58Q4d9G+VTlg01+5FYEz3QQiTmtpSjOuxAftS2cRmjgBj2OKY34K?=
 =?us-ascii?Q?Gc3+bk87Jq1XUCGt+MeQfUoFQmQAmARI5KWkc6X5gG13cSJwAnmb8Hd+q5wS?=
 =?us-ascii?Q?yeNUE5UvHIMY/l1VrOud7Wf5B2SBC8eOQSALT4A6UPmDiffs6E155CY6xmPd?=
 =?us-ascii?Q?PELhuTsUyxYOHjPRDcDsxIC8GRnEUEyBvgoCNWFGf+3M98Os6j3RqLMABZwn?=
 =?us-ascii?Q?BKd3qdKrw+NRhwEDRTF4X8CQ+XBO1Xd0e6gQuN4A+I+jEwmzm8A2idMqGRMq?=
 =?us-ascii?Q?xccXi8P1JLsvtC9dPZAuHdhzj8rcI9uPpCX0lZB5PK90KT/0fudAFd7Yhq3T?=
 =?us-ascii?Q?n/yFvI26/+6xGwPtJ68Yq1d5CX+o4wOJ6pAQAPhy+UUmtRl/N+dvmT/c9ogE?=
 =?us-ascii?Q?HMopL/gH7DBJXXUtWC1LQgAqWI3Ev4Fw52hQIgNrcS7QbW3HCK1VZzE6B1Ve?=
 =?us-ascii?Q?S2BAJVYT+AJRuo2EyRPI1H/htYEf9qRlc/HaWxCQW1gGGSqughTOJMM4l488?=
 =?us-ascii?Q?lx3ENV+3OxiBFtC0Yz0pgcQ4dYUdbKb3ddPwkncoHg6qk6iNjXw5LTD4cGfe?=
 =?us-ascii?Q?aUI+10QssMucYwugCQol3VUYZvihZR+zjDCMGy3HGaFpkMV+WfkgIekg9Izm?=
 =?us-ascii?Q?e3SdGkSxBXC5s7FqeRGZjECIM0SGZFYRu6RxCY3AkbL0JDGncrIwliF2FzPq?=
 =?us-ascii?Q?kof3gJaHbBgOFzfON6A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR15MB6179.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f762720-ce18-4437-f8a6-08de32f36289
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2025 05:10:04.4461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +nrK6PQOiHOYFYJU0jpNH7J7x8Ux/d/gT4r86k2CTVPlLpn+xiOFhiAT2fqRYGf1UgdpgT53FPD3TXdSQIUCAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR15MB6113
X-Authority-Analysis: v=2.4 cv=dK+rWeZb c=1 sm=1 tr=0 ts=693117af cx=c_pps
 a=L/RFU+sPSyhylg1snxNseA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=GgyVRnK4ZO8_njy9ssYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: B1mRekvs-fFFn6f_Q7lXysUebA1DlN8C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfXxt1ohHFetHYv
 7yNvWwWz8H9hphWLZYR+UXQDoOW1sIrRvLRQYvNoxX3yMk5YKuY524WObzzmeyvlBafhtDVeDbI
 6gkekFRuB10Szo0zb02QKtGiBvfQhgnVTsU+1EzUVN8Pw6tnx/ipZ+rpetKgjRN0gwqFFYbywIv
 lfC4rgirawvJd1/4NrgQnphC10nvfoLidAixXyj/bc56I1Fb50oTLvh/yPeSq0jWQFinTPKnsEb
 ZPCU2tfPZq2dhknHE8YhxK5/BX3QdtBr+S+/2B3IYGmztGrInJcyq4/QP8KCnyMu5yFtNDGD/nO
 tEFbs363xG+RGvUcomwTiQU5m9WVha4ylXt4J20fRx5LjpYEtQ8lrdOQ9DzpezKQ9syYOnqBDlb
 0JYHkQCdNAtRLz8WA7iGs48HQfJhXg==
X-Proofpoint-ORIG-GUID: B1mRekvs-fFFn6f_Q7lXysUebA1DlN8C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_01,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511290020

I'm a git very-newbie, still trying to find my way around, so I apologize i=
f the answer to this question is somewhere obvious to everyone but me.  I'm=
 looking for a command that will return the teams that I'm on.  Someone gav=
e me the URL https://github.ibm.com/orgs/ztpf/teams?query=3D+members%3Ame, =
which gives me the information in a GUI, but I would like to get the inform=
ation from the command line.  Any suggestions?

- mb
