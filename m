Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020080.outbound.protection.outlook.com [52.101.84.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F3641C2ED
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768997502; cv=fail; b=HwpCFh3VjDDnc3ViB+k8UWzghUtx0VPk+9VPvarOgsI01fhQf/OPbl55kjd6CqBXwliNVYeHEfG6p1+P8EYfWuaxyX/XD8qxdHtcl4WzmhNnr+zpub9C2+dnEskvCvysn+jdPFum5bTVhLmF6RwxZR7tQ6D7DHXQCkgYtXH1HcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768997502; c=relaxed/simple;
	bh=UlxiERl4RmwQGZpA6V3nTO1Fz0AW1o9ogvYL6gyaRxg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZD4ybdmvNWMtMwipYTjWQeQejHw0ermYEMuwQb5/vhCQtcx4R9nQ9RFY48F0c11RVbn2szUliusnN9al8NGf4ZiKhjAz1nzp31lcu+AMPAgQxncOXYRPWBDU47Hdnb7I0gno30nNvzVfoeygNxAU8b99+KH7LnG7tXiCs1SRH0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cis.asu.edu.eg; spf=pass smtp.mailfrom=cis.asu.edu.eg; dkim=pass (2048-bit key) header.d=cis.asu.edu.eg header.i=@cis.asu.edu.eg header.b=SaxN+941; arc=fail smtp.client-ip=52.101.84.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cis.asu.edu.eg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cis.asu.edu.eg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cis.asu.edu.eg header.i=@cis.asu.edu.eg header.b="SaxN+941"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vm341QPzN0p7qCJ39qdGRF3R1lpzlheSRFReIkEJiSrMLZuBHAzSHGzM7Sbz38A/uqcT8kff9eHLDIpsDrGBYRRqC7TXR1uc/xvTE4Pko9oaIUPx5kKa8H33SOB+I6Ywa7l1ZqkEWoRZptU0BOqvhkZ4UF+njAx2hn5N4d97F56uWa7p3tl6ppMiNx4YikVs4UhBpHbw3AbrivmByG1q7gO7YlOjsYnsRAchtxm/6+ZRuPjnI/SVpmXpYfrdcRv5Q1JSsaEy6LN1ocOMA4QyNu0R4D4z995wiP5MApBarbzf+yoOgyMtNahVEkGOcMzEs5e9YwxyM31yAZX+/cDACA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlxiERl4RmwQGZpA6V3nTO1Fz0AW1o9ogvYL6gyaRxg=;
 b=eggRwlO6L2U1ELoZfEmXI74M0q7Dv4aBvdQBvMMgGp2jMp+/hV5rxpUUa5Th62GijSapO7hZ2jkxWIydmOBjxcQcCmZqMthc9aL17z6JHCPZUgC87U8c3NNblR+N+rr2aGlFYPjIYDX7cJ9+PYptvWfLLd06F+oBV7JQUWlfeLLaFCwWkHrFI7IEAHQkZ37dodpKvBaiYg2EW8pPq/hfS/LfmEMQZO42xT6DWBFIujO9xTzLt9yOwQmiZEkBewjhq6vuYUz8eRm1xBDOoe3K2SEadNY1dMxWX0vrbJEaNa/CVUt+614Ci0l6Hxt6YRckNQu4uxLqGzSGinc/5/KXdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cis.asu.edu.eg; dmarc=pass action=none
 header.from=cis.asu.edu.eg; dkim=pass header.d=cis.asu.edu.eg; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cis.asu.edu.eg;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlxiERl4RmwQGZpA6V3nTO1Fz0AW1o9ogvYL6gyaRxg=;
 b=SaxN+941JuWauWvjSylWbGc/a3bVhlWitMkdnRslOIzd/RxTv+Wa1OWyGw6lCYeFDUTj7+wXd2AqDfrmR2guM/JBzY4ovf+CjMgYXo8yf5a51qMXY+HcRKrWZiODcYWqkzV+j2dimOqomnwltvoKJZ5Ml58merI28dQAA6bQAOZ/HjGHyaKUY5yEDTkVB8AOpEtEIYfMB+IHEnX30u0GpsLivp1KSXuvrPJT9q5xSccq/QJGo2l7gPvZiBBTplldVyjbAxXuhVKVBd0mBwhVh/MmQSI+TpseGqFWsLmIiZZ121mw79oNmC6HxE0IkIYJba6mcOb32Fo2bqxYpNjlFw==
Received: from PA4PR01MB7263.eurprd01.prod.exchangelabs.com
 (2603:10a6:102:f8::21) by DBAPR01MB6758.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:183::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:11:37 +0000
Received: from PA4PR01MB7263.eurprd01.prod.exchangelabs.com
 ([fe80::b2cd:7a91:36d5:794a]) by PA4PR01MB7263.eurprd01.prod.exchangelabs.com
 ([fe80::b2cd:7a91:36d5:794a%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:11:37 +0000
From: =?iso-8859-6?B?5c3lzyDI49Eg2cjH0yDN5dLn?= <2022170867@cis.asu.edu.eg>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [GSoC 2026] Inquiry regarding participation and newcomer guidance
Thread-Topic: [GSoC 2026] Inquiry regarding participation and newcomer
 guidance
Thread-Index: AQHcis6sZLdiwOXGyEin/WNnkfOwvg==
Date: Wed, 21 Jan 2026 12:11:37 +0000
Message-ID:
 <PA4PR01MB72634EF526D35A2AA545D54EB196A@PA4PR01MB7263.eurprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cis.asu.edu.eg;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR01MB7263:EE_|DBAPR01MB6758:EE_
x-ms-office365-filtering-correlation-id: aec61a99-c5f5-4f58-d9ff-08de58e63a37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|42112799006|786006|41320700013|1800799024|376014|38070700021|3613699012;
x-microsoft-antispam-message-info:
 =?iso-8859-6?Q?uPx2f9OwBqZj1sc3Pr9HUieWvRYi4wwYy0LivD9mrYLgmYZFR7mEi0BQEy?=
 =?iso-8859-6?Q?FDqRkb0MRZ3NHUSHhZammdzcVXgUcct/sGlSVXDNV8PhGEewePPsBQktFz?=
 =?iso-8859-6?Q?ua5y6bzz5hC6tzXZRsaaSsmj38WjakoqLmbr/oewSKf9MxtfxWFDn1Xy2W?=
 =?iso-8859-6?Q?GsFHDI54lhDz2k4LZCgz6gDhCm2ZV0P9oSQJoEPmGFuWAlDDd5sKwOo34L?=
 =?iso-8859-6?Q?HgxjHh70wsJCtgTCCvFrL/4s5Zs44bbPC7x0dzqe9tOZEQQOyXhNqpDMCR?=
 =?iso-8859-6?Q?0dVNdJ7U1bOMehM2DN9He8DekFYQ3MhwxSjLwo8kE46yvChjhbHaJJRlyK?=
 =?iso-8859-6?Q?cy3zWokik5H+P+v7otYVg5w/40n555cTraikqm1iEK246sVl/Cj2Qyodfi?=
 =?iso-8859-6?Q?uIdce/YbymmkRTnqn10ruNW+gCDSC60EtgJ82Z6onhvhXMc5DGgzIacO1R?=
 =?iso-8859-6?Q?SK8w0Oir6uE6Dz1sKaqcGN8Ry0RJ+D/M0W36fkIX5Cq0wWOE1srRpO3f9+?=
 =?iso-8859-6?Q?Wn79ttsBvRTX7AbtHaJrbvwBYUitrm5mpaPLgj4Sz6do2b/PrRudmnYTld?=
 =?iso-8859-6?Q?gL6twgBvJpY4OS0dFllvlFBhxmo5XrcwWriI6uvC8XGmhaUlgKrTuG2kl3?=
 =?iso-8859-6?Q?XP59Jd9kR9YgMIyRb1ZaNDlK4i+cwURSxo2snTfnm0NSeH5luU2s0cI8ba?=
 =?iso-8859-6?Q?dLwHKcQslbBl5EjE5tSjbw9xM987qjN9e9jHZPoFWaYxAMkFRpqwCutw5K?=
 =?iso-8859-6?Q?yzIPxxSTU3f8RzTz9cJOXskl4mEDTljnLPq9tthPJ9z1TUGKvqJSpSaVr8?=
 =?iso-8859-6?Q?bs7IrLf1dKsFfahvMTnCsNZRR+R/zjaEaMLYz4/pviEe+niSGrAK/U7R8A?=
 =?iso-8859-6?Q?Lxc8XA87exsDYBM5pLd886XilOm01I51F3vfpyfm4/NTpCXccv920t4vox?=
 =?iso-8859-6?Q?flYc5hwPI4u/RRltP/g0u9+MbNk90vITRe/962e2qg8Y174WmHZWjGEqh3?=
 =?iso-8859-6?Q?i6wZNCvnVuTUK5haRimZ3KxQe5Pa/tvUgZwFSH+IIB3pFK2SrdDGF5QTU5?=
 =?iso-8859-6?Q?YXX7dEMasuhw1Rd6EpGH29U01srjfUcGufutCdmQXlcqQtUDUvCg3kNB+G?=
 =?iso-8859-6?Q?gBPL6YmITLyG6dtAFaTdxayuOba9AGEndNsmtdDyUPPypp9tpncr9E95JO?=
 =?iso-8859-6?Q?f0uM0psm4BUISr0tFEAd5pYsF7B+3eSFJrRjyk7DQvg18k4uka9v/RrHua?=
 =?iso-8859-6?Q?C3qS7VpgB4KlROdLqMOfEc6dxJ+6m8A0UNCOkBxGrBx5dWYtz7XBHe6P1I?=
 =?iso-8859-6?Q?1ghh0GaMLBMd4+AGuRWbN7v2is/Qz/R7RrnuXFjiE2IwzM9EKnipMfN3Pw?=
 =?iso-8859-6?Q?FR7OTSeKHypUX4KOmFUORLRMEQCHKbd10IYv+tcm5UOzYdenZDfd+Vzf76?=
 =?iso-8859-6?Q?zg9L4SqoUoDs7Vih30RRuFMslDSYyyygqxRtpVJVhXvZxH7eXFs1m8COT7?=
 =?iso-8859-6?Q?7cihuR6pjQ7pggRSnQ+MDjzpJYHKcdvd0DxlGStzFAV1OcCXidB+UJUKy7?=
 =?iso-8859-6?Q?YFCk+XGd3x8VdlarcH49j2R+4ojN1DKGYF64F+hjABdFTdt0qK/srM50HK?=
 =?iso-8859-6?Q?0hr4R+AZbKKXqhyYMIpRIAO56Mdg6VyUtnZTHYRNCPB2f5J/Lw28k37lHN?=
 =?iso-8859-6?Q?7RuNWGuHTze13MAJLY/XtjwTF8xbyJHZxqgNEMPp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR01MB7263.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(42112799006)(786006)(41320700013)(1800799024)(376014)(38070700021)(3613699012);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-6?Q?scB2pYJ9vJAwuBA6jgFCN3TXLNUMZTEPIqluilSKZjd2atzNYb2Z+tcc3N?=
 =?iso-8859-6?Q?id94hmARI0cBVkqmpG0Y9/5YEO9DfPl2AZwuRl8HxiXivNdZt6JdnwKIEi?=
 =?iso-8859-6?Q?fGDrZjAiiQrw5IX4trjUh/olRZTSWXwOgIR3CLTo8PN52CJqXkbUcvho2e?=
 =?iso-8859-6?Q?s0L6jhx39TsPyYKplQ7pKxhDDmmJuZxv7A8QR14NQIOM5SudXW5OBgIClH?=
 =?iso-8859-6?Q?pubLzXwWRQv2BHjTghn2Q8dKoFDcK9TkJjr4m3oliIRV6dKQkP5nbFeS+M?=
 =?iso-8859-6?Q?uWx5CQrJcZJDWNUAIGU/sybV4q77K5U33pioKbUecXIrLLiUVMOr4mizM2?=
 =?iso-8859-6?Q?mAPDi9ipcSDcoACdm1B+W1e/rkNao2TD7NCY8VNMfLbdal6Ug313n358Ml?=
 =?iso-8859-6?Q?QPiRi7udbVF6PHfhN1es+nW3I1T+N68KsaUB+c133UtxiOYsPE6N44nhax?=
 =?iso-8859-6?Q?bohdwIuHqC1nOE9QZRGY2XUtWt/FyJEMgoS/s0toB53u0cEh2OcBKwbUPT?=
 =?iso-8859-6?Q?/M7P4/hWeDjuAODtwVakQoKhi/XpVCQJbvJKbft6aJgBoyd9StylSk8TKn?=
 =?iso-8859-6?Q?F3uhc+ucnFR7dKhi8c6V1dUNzXeSnwP9UzckB5fG9ZOcoeO8Y/G5LRUpx6?=
 =?iso-8859-6?Q?KNyUSslW3VJjbpLiTF0yXBB2sxaGFnmf6S39ebSpTTuBFRlnPwwymuX2RR?=
 =?iso-8859-6?Q?jWaKZnQIA0pO6kYKwYGPYGqTAR53ncrJ14EspypgUugxG/5dW9Vw/XgTFn?=
 =?iso-8859-6?Q?4ZFFgF4FM4TLbqqIlcA6MApGy+0RJChraXiWD9iLTf9yhOFY1JdzmqcTn6?=
 =?iso-8859-6?Q?BFuconXz9HyMVcSegHiYnZm0NDlYZH/kIRmz4yGffXHqpC03F3E4vSNPhx?=
 =?iso-8859-6?Q?y6kznbYbGelB9YkOkC0EHhbXkka5J5y5kzoDcmIXlX+vkBGzih5YHEBqJ2?=
 =?iso-8859-6?Q?duhkQ8xH1WDIGzzlcr1TfMxQWsyQndwGlrraUneha7YCG4ssPi7/dswWAm?=
 =?iso-8859-6?Q?T1xPbofOHCt992PlAg+96z1c1fAkh0Q8/0wsPMRh+muMC5ki9WIA5enqX7?=
 =?iso-8859-6?Q?6Hc+cHnjyOFRWcsWeQqA1d4V9rPQWBeZloS2w6hk6ZRGEwi6eMNEQ1NHNj?=
 =?iso-8859-6?Q?d60bC/WEDzQkUtlKjDHL51OUXBAoKQZ3q7Aff+boqpBO4ffcgavvcRLQG3?=
 =?iso-8859-6?Q?mNhjxGraognTyjjaNvTyqH0jmFIHS347l+xLDct40U6wJ8xGM6pM2IpvWi?=
 =?iso-8859-6?Q?/4ULzzD3CByrQDQ+Nti2K5vwKIYPqhwxDdrvsNtMxElMZT7qWO+hCcxSSY?=
 =?iso-8859-6?Q?QRVx0P3+R5plDDc8+usnNDQms3CvZ0J6/7wHYXmVJApZSijWR+WOIZihpB?=
 =?iso-8859-6?Q?LAyzelNVrUhMfirLUVmwcWXJWot/l/cnZBP+guBWnjRU/jRz4/IR2QHJBi?=
 =?iso-8859-6?Q?ZfZ31QujLgjXIneXK5wIm3YnLTodBFI1WCrNaYYiCxQU0MaBYjl6pGwT/V?=
 =?iso-8859-6?Q?lq5jaLmiFweZXJWw4gzD8tm2ge82/p8qqAGcblpjErc8Gj/mYEOo7soVUE?=
 =?iso-8859-6?Q?CcQAPQywOklclD48C6NpVNJtE4jxM/KDDTz76I6ykHGT7dw0lqY9QIIYOO?=
 =?iso-8859-6?Q?EKRLXQ679c7p/KIIFBicmoxzLynqQZ4uJu6lFm90i1+dfVLwUun/AsOPoF?=
 =?iso-8859-6?Q?+XhIk3tAsKnruEmoCY9tdnqXBsMPt8PaIeoIiIJqn4oDHdOe16I3/NrQnX?=
 =?iso-8859-6?Q?T8wjgnI8aPjFrDEpVLWqYoA55kyfPEjT78H8Uryo6ecsf27sxhqO8HDJTI?=
 =?iso-8859-6?Q?XmyzD0OYWg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-6"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cis.asu.edu.eg
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR01MB7263.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec61a99-c5f5-4f58-d9ff-08de58e63a37
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 12:11:37.5467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6845d6ca-1ec5-4c0e-9e9d-34130ce0a0b8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92qpNzxNqnYV9fNQVgHBa5f40NGkJ6TIg/KMfbvWbKD/UkxwYcBl4bFA8ltf83M6TeLJLdix2fnbDkRo9r0cIvzEDtEyrNBsYjSZmEVwp14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR01MB6758

Hello,=0A=
=0A=
My name is Mohamed Bakr and I am interested in contributing to the Git proj=
ect. I am particularly interested in potentially applying for Google Summer=
 of Code 2026 and wanted to ask if the project intends to participate as a =
mentoring organization this year.=0A=
=0A=
While waiting for the official organization announcements in February, I wo=
uld like to begin familiarizing myself with the codebase and submission pro=
cess. I have already reviewed Documentation/MyFirstContribution.txt.=0A=
=0A=
Are there any specific "micro-projects" or small tasks currently recommende=
d for newcomers to practice sending patches to the list? Additionally, if t=
here is a specific mailing list or channel dedicated to GSoC discussions fo=
r Git, please let me know.=0A=
=0A=
Thank you for your time and for maintaining such a vital tool.=0A=
=0A=
Best regards, Mohamed Bakr Abas Hamza=0A=
=0A=
https://github.com/mohmedbakr1911=
