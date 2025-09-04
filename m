Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023127.outbound.protection.outlook.com [40.107.201.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8772737E5
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 23:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757029517; cv=fail; b=fm1rN2/S4thrNIISjhgcgO53Z7VjSFSvHdoy/0Ed8zcnf+EkWI74SShhcrmhjBJOgIMmx5Z2jQ/2Gzx5lHmcmh5orVX2gVwRIriSYwoohHf0iy7ZQIQc0bjjWFn7nAfTZqwxLaj719t+6gDpt22r1lkZ27IclITGIVfJ7N/D+xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757029517; c=relaxed/simple;
	bh=KhnH0DBCHTHSOO0Bjxzf6ktKcxklJ287EVcR9sJMCNc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l9C2OGmzCoEi/YxCRpoZb6mgN/obnCtFyKiVYUfXgpnTsLlCtgZc2Cjbk16VsT4wpMnGDxBfk1r4ccsu/pLiJtE9NozDgic/iUZX1Ae4zEfnzYb/OEr1D+6ZPM5FNyxNnQNOt3ublaWFu2DijDcK1n0yZhKdKhblFM2Qvtrk2qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=KhOZIsMa; arc=fail smtp.client-ip=40.107.201.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="KhOZIsMa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqZWucw25um4OYPQS8bE/ZEz5r7JGxjWjgHPpqnXY+/2gbYZ/3Ig1Y8n1zCQj//E7xXEPhhorsm9Oags3UxDcqHhCUhj29pkNbXAJT84+T3xOYa31maUnBjN9043/QGVVt80G85bYclMZ6K9omjXb7RrNf9nzFPbHkFJdAGrNJBWpTWvs0kQN9W03mU3C/Ihu86U1F7I7QGFw3Gbw/7KNfor+njh+1udDTCkup12/lYYOjs9maoX1iQWld650PbOFovXnUcAA+N1YspV7iuNvJIfMJ24v56lJf8uJVC+EhXvEtwTWwYSztqolMFvjV5nSXyWcLsyJl1FKbPww0NF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhnH0DBCHTHSOO0Bjxzf6ktKcxklJ287EVcR9sJMCNc=;
 b=eHYKkE3PBKpkN2uOxN4pTQksz6KyfezFFo8cXRqzpZBU9mHIPbBNfNoHUwHLo1qyomkC9xGHe5tgC2Bq202NRlPHnaIYCELZhr5GLRv2rPtVGDfX37VBj5zd8gyQ3dtUSFXYuTkMxcrsP97/wBoNMqNrr8qJG4B2wQN2nqPew1nE9cVHJLw+TG9sAb/hIJsSvuJ16mD66KQ55ewQtHPRScsibgjaiiealiptO6lMUpYWr8fLcHxbbyRnlJKTnJAC25TOxHZ2tK3T+Ar0o46CPqatnG6LhC3B/PS5VRbqT0dzgSvl7vGnWoXHY7MW0MRgGShy1eZ0XDzIL1Vj7q3QpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhnH0DBCHTHSOO0Bjxzf6ktKcxklJ287EVcR9sJMCNc=;
 b=KhOZIsMaTSWYUzPYMlBlbHFNaeDb1N7lAzveCVhkklYZjELvDWmLGmaZyFw6aQzoqk6iVqt08q/qzLQbaLkPEEGapVEQtsq/W1kmD8u1KYeCulzUUGTAaafcUFmx6jj5XtmJd+YziyLEyGVXwDGoI0EoPij5yLTnRk4Y+1Vhq1Y=
Received: from CH4PR21MB4613.namprd21.prod.outlook.com (2603:10b6:610:265::20)
 by CH9PR21MB5688.namprd21.prod.outlook.com (2603:10b6:610:2de::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 23:45:13 +0000
Received: from CH4PR21MB4613.namprd21.prod.outlook.com
 ([fe80::5965:18b9:4e58:a176]) by CH4PR21MB4613.namprd21.prod.outlook.com
 ([fe80::5965:18b9:4e58:a176%3]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 23:45:13 +0000
From: "Michael Tourigny (TERAWE CORPORATION)" <v-mitourigny@microsoft.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git whatchanged
Thread-Topic: git whatchanged
Thread-Index: AQHcHfWQuMB4F8A4d0uIvJDHvjTnPQ==
Date: Thu, 4 Sep 2025 23:45:13 +0000
Message-ID:
 <CH4PR21MB4613E73BD3A24899330002B89B00A@CH4PR21MB4613.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-09-04T23:45:13.312Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH4PR21MB4613:EE_|CH9PR21MB5688:EE_
x-ms-office365-filtering-correlation-id: 389b9d56-8115-4d1b-2d72-08ddec0d17f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?98rngyNgUckMgaq3GzBJzZ+jSSGVeth744zpGEMKF9INIu9ha1/YzxHh3F?=
 =?iso-8859-1?Q?Bej6g9Rrp6UhemCWJtmiIojbOKz7YfVLwoSxAbEOOFlrqfQJfJcTX1rdbg?=
 =?iso-8859-1?Q?5Ob9jYzXOgRieZvWoAc6t0TKoXBfPRDY94tb12+79kDVG1pnXqKCITuS0S?=
 =?iso-8859-1?Q?FGoFvpkFhxIXA5p2tTot0Qe4VbuqeNR4DLeugtlVg50qFSuvticrZxD94e?=
 =?iso-8859-1?Q?Qt+TjiQPjiHbzOaSWrP5Tn15/6vZ3F/Rcm1x5xZy/6Y8QTOhEtePWMLUmz?=
 =?iso-8859-1?Q?MiiWxR/0QF9Bt4W/+llk8P+apMluvXTf09NAiRfdVplbz/lE/P14pX6jAV?=
 =?iso-8859-1?Q?XlFUvTybTYte1lvinSmUETbkA4ORws/H4+SYCzf2PBVsibz3F18SiXmPnE?=
 =?iso-8859-1?Q?uquLQp2ruUiGjQAUuuQriV3Ady2eHojYfuZkl+y/SK2gNEz6b9z80e7i22?=
 =?iso-8859-1?Q?5D8kpaAJ8ZHYEMuZaiCUCFvWkvChZrOhXuJqy8fj5YjNBXgu6r4nehfpNN?=
 =?iso-8859-1?Q?vbYM4biZazOxWKBtoq1QPkCs9UzsQq9ci10nrKY67fLa48vSeWiY6SnytW?=
 =?iso-8859-1?Q?46kgbOoP7r38mW+61r1bUjChWbdxpMVH4PnDMO1zwO+ZbMhYkCM3TY99sq?=
 =?iso-8859-1?Q?AnjXapO2yxMWCclil/f9670ytl84BydGP13+WjpZjQ0LKay0+rrHfrJFdS?=
 =?iso-8859-1?Q?1S5evdsIECfuwl0SdbaXNHxUnsT13YBrpUpl1BcmMH7ednsf4jEjzX+C+q?=
 =?iso-8859-1?Q?CWc0XmlO75Y6d03bRM0II1uPto/6L38V5lMCTqWBULzHaL3IvaL8Yaf1ba?=
 =?iso-8859-1?Q?yHNoVg9+bDRDprATwfk0WxfWJu8pfsAp+BmjQEeYIMcIq92cLHdqHvFX8x?=
 =?iso-8859-1?Q?/HLSmk/hApLJdvFUEYiDNlVV90gjj7kuH/pmN9C8k0QhJUkstjpiE5jB5f?=
 =?iso-8859-1?Q?zjkb2iFDsMWvL+UUyt4rJZVtILeZzUOS+hh5+v6ug5g99wFVCRlxCWCvuu?=
 =?iso-8859-1?Q?zR6a0mVnD3aKJOQNmjESTo6wYnOW6s2bh9yjpE7l/LtITqzVLEQMHYv1EM?=
 =?iso-8859-1?Q?gVVRw61FJGIx33aApigyNoSnggZtDTFaxtZLz0IWQFl6tYYnYgwCUjzvpH?=
 =?iso-8859-1?Q?fkJmOf7PFjFRGzKU/8IqBFV9I2fdTwy31pKyTYJEZ8qG/WJv9yrOVFzZWG?=
 =?iso-8859-1?Q?fnay3cnnJQ1MKjBkYf2xfFJbkp9MFTfQ2WQsCvrveGQfFdhHIse/MZQoaf?=
 =?iso-8859-1?Q?cUCyzYjSUlveqiN1eA2+avroNCV9lndYbqBsgERruXv/YIiZtfQ9HYKwev?=
 =?iso-8859-1?Q?/My/fdT680OvGZXP1m7lH7GCJXv4ZLDCRUMP6DBxmakFpMKElwMvQtTpqm?=
 =?iso-8859-1?Q?AUGlxaeebYOeX0cEMwsZ+exjMOFRU/SCAWwlAbfuLRk/HR4eLfao+0lqup?=
 =?iso-8859-1?Q?BoPt5qQO8H8RwscTVsdXIpFhGgcOoO8n4mrkZloqV21NHreaxRA2WO4+hm?=
 =?iso-8859-1?Q?+o/INoDrLGtVMtGtRpGK6SUPgCt8N5r51fhTHV3Z4C+A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH4PR21MB4613.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HjtG9uzXdDputPpCaqhqg3XqvUdyNcIDha1TPh18+HlM2TNceFy41xG8sq?=
 =?iso-8859-1?Q?rjo8IbRZZy0R52aUZBWeKYbtGCcz0gFfwmA+vutBMXBbGN+yREWjIF5VKg?=
 =?iso-8859-1?Q?ADhtptNGRnufEXQKn/ZVu3I4btWmtdZFreoCJnnTHBy+fenoJ49GBQK/Mj?=
 =?iso-8859-1?Q?xrXA6YoIiedV16NCgieym74TaJ4l++b7PHnRWDPapG96bFFek/zfzSOKqR?=
 =?iso-8859-1?Q?CupnIzfXyFewOSCWZ2Cgu89P69Xh5G+TmkixsUX7GazkrloRCDS1/dJttW?=
 =?iso-8859-1?Q?hJ+gOA2IcxpQNRRewxSQN3KP4I1EeNt60v8EObWmsbi2psT7KdPEl+ksT+?=
 =?iso-8859-1?Q?i1De+0CCAd8ZpkBqHZ1ZFoZQDsKz1oRsVzlcswem58EP33B6uFjkCAuj3D?=
 =?iso-8859-1?Q?OQQXV7ZWNCXIzQx3/0750FDNjlIxDXypJQD/g3AGaKhE6//Wd9o8StCKnq?=
 =?iso-8859-1?Q?rWaufSFbDvIo5hvO8lNzOim/dvyUl1el+IYSjSHCaJEtEJ+0oxKek9VB+K?=
 =?iso-8859-1?Q?cjtWzgJrsgA1QjEi+0SOf1WMbBhePgTBFmsBqNO4GByBMPaY2XO5a4p8C/?=
 =?iso-8859-1?Q?iLrD9M2dKykKTDvWTGitGuBJSztJsqmvze/CkH2Knn77+SZDa1wfqDnRww?=
 =?iso-8859-1?Q?1NA+V8naw2I/KOZu7K3LUUVc4HIGHJ1ShUzhV+RI/HqQX58YKhryBUZEsC?=
 =?iso-8859-1?Q?sX7jxgBhWapQQwEnOcf7oZ3R7kB8L1QzHXDpWmHOf6eAEt+82NKWsro+Tp?=
 =?iso-8859-1?Q?ehoqBRfUdSVmqrdrpUggBufRBTukNpfQB0Lw0yAulIUrbcgu9glVs74ro7?=
 =?iso-8859-1?Q?AQgQKkVbhQT36rwkv1cxBzH9S+7+zdyoSlDj2RlClAlH1qRLLQFieY+uJC?=
 =?iso-8859-1?Q?MMBKLiAliT5REbl0FYPZv+1EW9Jl4rDOdeoOVfGrW8L+Jqwrm6+2Niqs3c?=
 =?iso-8859-1?Q?R6Pt5G+ehz90DbANLVJjiVJADMO8eM1UK4PmxAzlwqq5W92AfIClTd47Nt?=
 =?iso-8859-1?Q?lY054tMBVRFMsnU+PvY0gnvACs+1qjPHxxlhdIGcs5jqIpItHUj8qUE9Sf?=
 =?iso-8859-1?Q?AGnt5bc6JjWlFqRLTZ9Et6FBTG+fOW1NIywJ8mWRKBX84YL4a80/v4H0ev?=
 =?iso-8859-1?Q?6GZhtLCWMuXbm9qp5jMqEfWhB8U6VJaUvqbAF2YrT7eWnPGuHhdGFtTxmr?=
 =?iso-8859-1?Q?yy4OYu+rZi/E+sQPqNciclN9B32wx2cgbiIBzdTnzS51x6M63bTf3l/0I2?=
 =?iso-8859-1?Q?GOlFgkEUkvC/nsAn+e0sQwY+O2d75hbWbtBDRKXYyaSo+c+bfS8EHcWtDv?=
 =?iso-8859-1?Q?8NclOb0xii7dxSLfCsGY4+mU8Sc5x17wFPVZTA3j1VCjgOjO4uERtu+Yjp?=
 =?iso-8859-1?Q?tHqhW6HiFvt73e6gRXxqQcIT65VrOW5qfHNhCiYXO+b9zgLDj5smyRGjPk?=
 =?iso-8859-1?Q?Xc21qukiZQgkRobl5ji+eg8SEiav9xp2cCi95T7hzy7vTPqlXpXUhzdr0R?=
 =?iso-8859-1?Q?7NP/5pPmmbjc24QR2KWV4o/V86ksM01bFlXzgtHAsEtGSoTKmNGhk1IuBH?=
 =?iso-8859-1?Q?8XsY6hdk/rvbCkQArNGqwbrGRuh5?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH4PR21MB4613.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389b9d56-8115-4d1b-2d72-08ddec0d17f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2025 23:45:13.6788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: arCwZMZOpsqLUbkbsvpD53A28CJ/J4LE+AVEZpKDpsKPi7CkAFnVzowoLhQatKRy3KjQYPbKExpEKAWLerWjnRI1En14aoFtYH6Q1xHFzJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR21MB5688

I use git whatchanged once in a while.=0A=
I like it because it is easy to remember.=
