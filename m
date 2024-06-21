Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2120.outbound.protection.outlook.com [40.107.223.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0C84A32
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998330; cv=fail; b=jOPFE2mR5LNkcNGn7ZQyeS+YD0vdyTKGtuy64jdRD4FpjSiWpD+l/fCe88VzgGOsUHL32Ctkdtqa+ZW6EQtrb9fhc5DCHQAorwxh3sHuH9sGp2mt6dHwXfzvQqGHOQ2tZl1nJcqStu6LO+ph3z6D6ujuZTUTIDN8HZK+NX7zycA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998330; c=relaxed/simple;
	bh=FvDtLqYnLhl+OKSUTPEA6sl6kMzgxthBK0Dw81XHsRw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UXfsPlQk6YZFt3xrV0iW8EnFCpuDlm42bQSr1Ni3QzbrVDDMx09EWG3HmtDL08RX0IfMC5JQWqYayVMnd86SZC1JU9GO6rEwqHNOL7mYZqyanZoKOSuxKxLfA9QkE1tuwBdU1YGvS5GXU9LRMtqhzJFUiOG6efEcO7+7sG/QJrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca; spf=none smtp.mailfrom=nexbridge.ca; dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b=BMDsdJMZ; arc=fail smtp.client-ip=40.107.223.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b="BMDsdJMZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je5eiJz+QymPIaQvb4SNM2F36bw3N0ikERoYRK9ozp1uZkMZBmho24V3gxiP0tNT2V6GFea70GysCCtloksMadmpzWNIERqXM9qWT6Ox9eVMk08fw3DFgMgvT2j0jxINttux4iNVVod9XCuw+wIPSbfIPvLXd1LjhvSpmvrI0sGkVv0bwm/NwZGND08wvTm+b8Wf+f3Oo99EtBGautRRRJ/VFGemPRrh3V3FMTVSl2neqjwDzp34W//AS5Mlkmn3c9m1m9StodStj6ntlVm+SGF2w8UuJA3mDvg27/mLzhBJ5zobSdHuDIlNc5Mk3d4m+N/hiNBBSPHMIxqRuC2Ung==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1CRhg1S7GfYmOxeBJGEnLiruU0ytkNhKhn7X8xDfgY=;
 b=QUS/9VUMVgxjHruwHaoMddQQ1nCnUATOKF+lE32N5GR48RktoqgnaqptmvPV9tBKoH66iLlPCoG/K+FQJaYDnKqZNjNSkn9ihFmFkz+qvm31sTZm1GeG0d9f9W1gr3SD2fPQqiduXvvlE9jUVsXlbjZteGWnOSv2cnMh+d8GVyBJVdUjUg6t7oKyY3av18jQqjyie0D7eXmIHkz0tE2gp2CrovpjalPRce+WV1hH6UytiOFRGXPWO5LwRGCooW4Ny5LGZC2C4787GhYCY2ppnqwIMYbCTxce1x0tIMWvcludQI0D7j4S968kH8G5+0sZ+rOoiz2EZPabxYz9X0ASXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1CRhg1S7GfYmOxeBJGEnLiruU0ytkNhKhn7X8xDfgY=;
 b=BMDsdJMZ7OPEsxFP4lqx+bcQB10rGN0cC77/manJ9U3bwxvITIuHj9ZJGnltRdsORnrskIXOnT7OzLKcJV9qcPFkjRG9v6YmY4exGu6Jd4VtfBd71bOqrvkFjjUPWAA3BZvWbl4qLjfMhLzGXPPP5BY8ZrKpwFQMQtAgrI94rF0=
Received: from DS0PR17MB6031.namprd17.prod.outlook.com (2603:10b6:8:cd::20) by
 PH0PR17MB4940.namprd17.prod.outlook.com (2603:10b6:510:e4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.29; Fri, 21 Jun 2024 19:32:03 +0000
Received: from DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167]) by DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167%5]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 19:32:03 +0000
From: Randall Becker <randall.becker@nexbridge.ca>
To: Junio C Hamano <gitster@pobox.com>, "rsbecker@nexbridge.com"
	<rsbecker@nexbridge.com>
CC: "'Randall S. Becker'" <the.n.e.key@gmail.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: RE: [PATCH v0 1/1] Teach git version --build-options about
 zlib+libcurl
Thread-Topic: [PATCH v0 1/1] Teach git version --build-options about
 zlib+libcurl
Thread-Index: AQHaxA0Pe69t/MJsJEK7+i0uhklFqLHSl/0QgAADEhA=
Date: Fri, 21 Jun 2024 19:32:03 +0000
Message-ID:
 <DS0PR17MB60315038F42A05C84A56302EF4C92@DS0PR17MB6031.namprd17.prod.outlook.com>
References: <20240621154552.62038-1-randall.becker@nexbridge.ca>
	<20240621154552.62038-2-randall.becker@nexbridge.ca>
	<xmqqmsnekvir.fsf@gitster.g>	<016501dac409$7dd5bc00$79813400$@nexbridge.com>
	<xmqqwmmijf6f.fsf@gitster.g> <xmqqplsaje6z.fsf@gitster.g>
In-Reply-To: <xmqqplsaje6z.fsf@gitster.g>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nexbridge.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR17MB6031:EE_|PH0PR17MB4940:EE_
x-ms-office365-filtering-correlation-id: d6784850-352b-4645-e741-08dc9228d416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0WB3stvgYKCUcNru2/BRJJ6UuFlzwYxACh6kE2obdz61NXMkVX73FjJ04Anl?=
 =?us-ascii?Q?8m87YbcSR1VhJYKLX76Lq3VDl/sS1SGfaHBtBYMJq6zc7A9w2dMdoojZ/eBt?=
 =?us-ascii?Q?eg0DpXKfSQ49cGkNGN2ICvKRlgleI6bWTl3oGXPns3YuQOj9ia7doN0NYCV/?=
 =?us-ascii?Q?P3FqZIGoQbL2AwzHrrb6BM0pbxC2TBKaUz9qZ58ZrjrsZ2LQ6o4mB9ZeUUGJ?=
 =?us-ascii?Q?YWcZnM2EEbwA1u0Dqealm/N8c36wWrAe+eWL7geawbSOdctaMXrghVMl1OaA?=
 =?us-ascii?Q?5QjbIsFmLvmWkIPoPkfd/ZXaRZVEwS5GEzJ3lFA0P/zgvGB4hrbtX1l8qesY?=
 =?us-ascii?Q?Y+MN8ASaOo0S2paM0jt6yFoRE/uIWbqm1e24oTuG7LoBsuUuC2ar/QYYJwjL?=
 =?us-ascii?Q?r0uaIJ1s0mSiWnWz/TkHACOPL+tKEUgivd7aHgbPAM85H4Y6/FUVQF2HVq+D?=
 =?us-ascii?Q?4+8nyFstvBe8UValZIJ13xnsaRT/xyv4mkTtf6k2Bh0vT91oT9dNOzrBcBqI?=
 =?us-ascii?Q?ooJ52p3vTBpz/Uvr3WJwn7pqFuWq/fAa7jWkWKCeOuN6EDNXVSSd/++SuAwq?=
 =?us-ascii?Q?3Rtpv/q0zRjuomKjgXXx7S1hYB0/OXa2pLdrCMuvp+T9w4fAp+PfF4HYJsvy?=
 =?us-ascii?Q?AwbHIuhD/Ng2RJbkgkH2iMSBcDblOnjmtF8YHi6ucmsXGijbow/cLauFQymE?=
 =?us-ascii?Q?GGG4upKfhtVDq8oPoCno5q6IlbM3RCucKakDpHhIRif9uDxjIPA9wk1gvQ2A?=
 =?us-ascii?Q?WodeYp8hYB15VyJ9trQi90Hq39VgywwPJXJXQx1kU4HUJHru37bnRg2ir2bl?=
 =?us-ascii?Q?EYxreUyDnuDvQN8YknjwXOFt0ivnhj82uuMSMxblLFraHSbWXSvTGO7fNsUH?=
 =?us-ascii?Q?UQ5v7YmA6d0IQqrGLXQ1g9xOiKbEHawF1hk7d7KtHtuneJpZePF0kgQz4I/L?=
 =?us-ascii?Q?LhqU3GxlQ2Pf7zJfPfe/RQqp9ai5j/RnRUkHPZhP9aMwQf+CxpKf6OfBrhW+?=
 =?us-ascii?Q?tgQH6n5ph9HTyAfz5iD7XlsqMC6TZOggZKzEP2fkG9jD4u+feG2A76Qfo27D?=
 =?us-ascii?Q?R7XolyeAFJrclnQppaqn9apGuzSO3ONcH9K9tjyomUkxV82aokuzQC/7sKQf?=
 =?us-ascii?Q?15rmxngN5BwR6G9z3ozUkP+EBH0BY4dnEj7Wd6U0yYMVZ2qYQTJvU0bNMxOd?=
 =?us-ascii?Q?RVcSfcTW6ZpujpPrsp4TOBTDarwYbdiE6CAqno7zAZeSfqUyDcx8y7Oyr+71?=
 =?us-ascii?Q?IvypU+oEcxSgz0FoB3zlYwsRNfxGdsM+E8OP4yvVwGDXxxShoEwhHy1oZBY6?=
 =?us-ascii?Q?X5nyHgDjSoYBUt+yXWEgluYXVVzJO4EwqGp8HM57mpKMU1BlDqtlZRFZlPB/?=
 =?us-ascii?Q?BjlydBc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR17MB6031.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WIuVtCMuENzvVfh5TedJhvkjy9grMfayTB0Ys0TSZfqhbClp5GitYI9JD0U3?=
 =?us-ascii?Q?3R+gAv/LdG8l63/RzKU5r86ajP8wARFKIlpjHJoYJcyHE6h0lP6eFEtp2vcE?=
 =?us-ascii?Q?TuljTtu0qwVuqNIzoeNX39xHLs+GUZj5kONknjmrAYazmxDRSynPHhNu73O5?=
 =?us-ascii?Q?EhItpUCii1/yV8GW7YZClugwTI4tE+OBA/1WdkGiKsqTfYc4g7GCWT8wYORv?=
 =?us-ascii?Q?L6pkapPrDciZ8/LiK2rE1tF1Szdp78Ip7VBVlQbVLoQBBa9TuxP2WFk4zYfp?=
 =?us-ascii?Q?JaF9AdJ0Cj6/eeVtERXndsd3j76vljbjBV+YT5dJsIRBN8dzg9YkQVEzvEnN?=
 =?us-ascii?Q?imFlHRvktyXefzXcT+1PAan5vkBr5UkT/9ULX0NbH/3lcei1A6GGopBNNmLK?=
 =?us-ascii?Q?Get/GAI/jgU1peu0LHlW9Q7t44vTzS3UgybsGI8vQrkrk3fUr/STQPSshMMA?=
 =?us-ascii?Q?/Ri+1lPHez3X0BlOy06ynvmmGReIE5SDAHFECHIMVvIDs1MYu+nJFTu6vAdz?=
 =?us-ascii?Q?wiBW2S+yjwAmP0Ar58ItneKrP4NLNi+O2UgWD5J/D/BiR6wboDz8K2EJ+HCx?=
 =?us-ascii?Q?mpQkPdpm14/UEuuAHlk/feX689xB5+dxEB8l/DAlVdM2hnZ0sMLTSqkpD/AM?=
 =?us-ascii?Q?BtimW9SyTxYQU5Czvh4zBsH/897HyZxh6AiAZbzG4qk6D4ftUnDnPZMJ6wFM?=
 =?us-ascii?Q?jvhr5fdAJtA052UFJ86gFJkDdvWzc76WHI5CmO567EEcxj4cxyqqOXVynhvI?=
 =?us-ascii?Q?nv+ejAjlh+EmriTTPKCv1jNN/orxv89Vsv02iUwAQdARmqpNvzaC7nzHi1u2?=
 =?us-ascii?Q?Qaeu20AJGiIZ9AiLpq48+azpPtASAK9xbw+037dpo3vZlt5sQkDgN3OhRHY8?=
 =?us-ascii?Q?ju39YI0tFay0m0Sqh7NK4VtyGoIxEK5aYaD0Zk+e/q3PgarUIwNGxWKyWPgv?=
 =?us-ascii?Q?cWoizBJbWubQDEPFBYO/J5GILl2VcCn2dtez1Amhws1oWU8IV1P3Ir83OqaK?=
 =?us-ascii?Q?A+EuVakEa+hBEdCiE36HQMAz8exkOwu6U7rKhc2HdWhxjN57u3S5fDJ7+Z6c?=
 =?us-ascii?Q?Q5CNlPKQRD3rALRLRK6GhBJbdXu2caFBL2r92QUwU2BWTc9Bjsa0KcbAYWyG?=
 =?us-ascii?Q?qGKbxMkUkhaziQiojLuzDeAjFVh+GJ7N7nUbEnjCAa+uYa4z9B82e67YIzHi?=
 =?us-ascii?Q?k+k6G00qwWh3Q22GS3KXnmso/ivoFmS5zj3gJidY59nyto4kVeLymIUyStJO?=
 =?us-ascii?Q?7n4GYlS1Pcrlo214wHeVqgdayg8NPg0zJ4wfsq6bzYCik+7a7bpKHgSM5Fpe?=
 =?us-ascii?Q?WtlvrFwMDYXrE5J5owPxjoR42XEKLU31oj3i20CQTdHvcMyA3ULV61rOe553?=
 =?us-ascii?Q?MDK/itPhvYYUy1wHDlIX29WHHp1XOsAMP1cBI4XGtWZ76b1F3qThG+c1ELcA?=
 =?us-ascii?Q?/XdF7xNSloYDVwO3t6jmpkIWpT3L3B+LDRpSIEPMyRYyGpF2EHHTjMJXf7/o?=
 =?us-ascii?Q?O1JwTqY1ASBaYvhYR0sKa+vEB1H6DppxMJ+j71QTntsbkr2u3cTAt1LNU+O+?=
 =?us-ascii?Q?7owjkvPmPtGYCjV0THtEH1ytjV0ldXIL0atDF/I9jb86Viq32YR4emyknzwR?=
 =?us-ascii?Q?kYuIEI5PIX42zSjZnKmbc9dc9YLUKQ1gAxSHsUCwWSvcj8eGEQqqiiPtzLtD?=
 =?us-ascii?Q?NstzjA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nexbridge.ca
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR17MB6031.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6784850-352b-4645-e741-08dc9228d416
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 19:32:03.4248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQXzRtfywxYOuuvpuyHc8em5wcX6N2MCSvseL0csUD17lKsC4vhwjKfq6iSD6gd7G2sM3asTqByi52aQ9v43BIJXCIpQ301im7sD/XJGVMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4940

On Friday, June 21, 2024 3:20 PM, Junio C Hamano wrote:
>To: rsbecker@nexbridge.com
>Cc: 'Randall S. Becker' <the.n.e.key@gmail.com>; git@vger.kernel.org; Rand=
all
>Becker <randall.becker@nexbridge.ca>
>Subject: Re: [PATCH v0 1/1] Teach git version --build-options about zlib+l=
ibcurl
>
>Junio C Hamano <gitster@pobox.com> writes:
>
>> At least for build on platforms without libcURL, you build with
>> NO_CURL defined, i.e. "make NO_CURL=3DNoThanks", and anything that
>> includes <curl/curl.h> is *NOT* compiled at all, avoiding the broken
>> build.
>
>Unfortunately, we cannot use the same trick, i.e. "Makefile knows not to e=
ven
>compile when NO_CURL is set", as this change is to help.c and we cannot sa=
y "if you
>do not have libcURL, you do not get any help" ;-)
>
>        #ifndef NO_CURL
>        #include "git-curl-compat.h"
>        #endif
>
>may be a simplest workaround, as Makefile does this:
>
>        ifdef NO_CURL
>                BASIC_CFLAGS +=3D -DNO_CURL
>		...

That makes sense

