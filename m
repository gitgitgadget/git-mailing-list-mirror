Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011037.outbound.protection.outlook.com [52.103.43.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832AA42A8A
	for <git@vger.kernel.org>; Sat,  4 Jan 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736000510; cv=fail; b=Ojf3TOL3XxENmUEEgdG9XxebfcTxxwdaIUHBnExd4V5iKbbBDXxKZePDIIHSW/Vhz8GYZ/I3L3cBIVmxSChn/QWH8wv6BDmAzsWJ3E1tWuGsdHfqtKX5Zgyr3GG8ogv4hwfI0D3d2+hf0eGAxStpYWJD0qNfCyRE+rcPqwApLxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736000510; c=relaxed/simple;
	bh=MBqIfe5GKCgnyp4crdE9wG66rzuC/77uvE68HFTpCCw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j2kcxgS5pVs60PnaE9FT9YtwFJw8j2dZMEICFbMj9N2RKuKBkhy2BEqfSEgIcwJkIzmw4VqkpxCeRV2RPgfv/lmyfeOPxtCb06bIK6v9M/N+JgImKKbjrc0vo6HRTRjI9LidMUuwGl+8C9jvxP5eFYqEKieKINLSOdcO+qIHi/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msn.com; spf=pass smtp.mailfrom=msn.com; dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b=Odj+i1vx; arc=fail smtp.client-ip=52.103.43.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b="Odj+i1vx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtYvIK+OheSV8iQCPwhHyN2Qs0fCmobOJODSFGBgvHK8T3p2edlj5Se8xehC76hJoHEYo9I1uKVao42lDgKva8b4+cQf80yqdk9WXaOM6F/04pESFA1wzbLBAz3ZMIGTeKfuy1skp8tuuGDuOss5Nhcc1Kg9F3gHOAJQ0ZTCrIcHPMTTC47WpGFM604eK8Tq1poxcWdrRHqV86TERO6xFz7ouF7k4YZvlUQVPAMvU4TTVr3xuiRQQIiAiusViIVBR80HlYdOZZ+y4DMlREXNpT99Id/Wr8lLE7my9YMBlndlEKPJqx5okWSXu1RiGAXYeK/RMG5/4a9kQwTnL9V5wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYSdh1a9CSJYT6nPXDbCdT9kV0ZQKB8+igYlpQ9KTS0=;
 b=decWbP2kKQmwGpLJAfoK+yzZNBN3f74UUc9HIlitlMF5CD25rZuvnmnXso4aT7M3WciO1vvVHYwC8gCn8QoToBOhmcQVDAAxV4zZ1outuIchiUW5xiJeEYO7byQmQq4ly4rmlU6m7B9apWyhoD4t5DMmSTiuEnjCC3TIwtWmdVp6umWBVzV6qY46olJYsUEZ+WXZ6AnfY2PRrwlJ6Sc9G5dp2LFFtyMRhEtF3j1mr341mO2AufB4oTnhpo2OGIDJzTp4K6BC05k2hp/XVBHbji7wug5HNChhlkWH86/gOQcd/teNJK/cBuZZHQfG6V0iZe56vFphbzZhB1hqniyZxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYSdh1a9CSJYT6nPXDbCdT9kV0ZQKB8+igYlpQ9KTS0=;
 b=Odj+i1vxg+x/3nT675eprSboeckS6IX18rVYHr7789rn3BF0p1ndKQkuvphMCf3P+r5kS5Xy6r8QXtKLudFmSUomAq8yzw7KZ/IaKSSn3G645ZDvkikXjKHHvsv2uhjU+MeJzP9uC7d79dEXhPyj1l/7FXax9mO3Jcg6AyC68vD21LDiwqjIKeau6VHahP1+iUFHHI467EdAJO0GwwM+WSMUrbGtMq9aDB7Qeb0YGXgzjaRgXx64f8hmuMrYIzqMAqSXYcw1BiiTmyGjNzIVGVc19XE1UmqBMI8yRZERCP+Ns3B+KCpcrPdORUp99nOYOHjM2Wy9FWclbeyNxhkkxA==
Received: from TYCPR01MB11736.jpnprd01.prod.outlook.com (2603:1096:400:3e2::5)
 by TYYPR01MB14151.jpnprd01.prod.outlook.com (2603:1096:405:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Sat, 4 Jan
 2025 14:21:46 +0000
Received: from TYCPR01MB11736.jpnprd01.prod.outlook.com
 ([fe80::76d0:50f8:9313:d67d]) by TYCPR01MB11736.jpnprd01.prod.outlook.com
 ([fe80::76d0:50f8:9313:d67d%6]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 14:21:46 +0000
From: Youtian WANG <wangyoutian@msn.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Full absolute path in a commit makes checkout fail
Thread-Topic: Full absolute path in a commit makes checkout fail
Thread-Index: AQHbXq9WWyn+TfRRkUyJFZTo0v1Fgw==
Date: Sat, 4 Jan 2025 14:21:46 +0000
Message-ID:
 <TYCPR01MB1173678128DCC128099726865AB162@TYCPR01MB11736.jpnprd01.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11736:EE_|TYYPR01MB14151:EE_
x-ms-office365-filtering-correlation-id: df452e47-5938-44fb-5330-08dd2ccb1eb6
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799003|7092599003|461199028|19110799003|8062599003|8060799006|15080799006|102099032|10035399004|440099028|3412199025|4302099013|1602099012;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cljzYwRYIHuW46l63wIba0l0FOKuw8knuoVuQfIP99VkkToXYJTML1sWD6?=
 =?iso-8859-1?Q?buZPD8T6MWb7zYJjBBC9w1nLomICX10yPwIW1xOcQ2LZEVsTEza3eldqXb?=
 =?iso-8859-1?Q?jiAgXOgBxGPaNUPAJUyRywdqbkIyUzi25+LRzvyQzIfEC3qMT5m39BUy1+?=
 =?iso-8859-1?Q?4lXQ5km6tU0GXHGdjD2bmXjYhek4X+uzpdHuQr0XrdV3J43D865HW3RiCe?=
 =?iso-8859-1?Q?TyMdnbl9zv+bicD3fj3Ub6RhGwAg831B6BKd/vYt5dxKhbyDgYFyCoXuyR?=
 =?iso-8859-1?Q?bDWENcwcppLjsY82HnjIyErcMqygklfpFhAwgQkNw6c6R5yGGmI6LS4weD?=
 =?iso-8859-1?Q?5HbwQXYfGS3+TSjM2hL5ShC9XTOA3zGLjqtnxbe9FuZjMcLUE9Oc79W5ZU?=
 =?iso-8859-1?Q?x9xTQDmblg5c5qRJtEO47LWtwj4nr6fU8uonjZwkoNmL/orjNe42QipHqx?=
 =?iso-8859-1?Q?ohe/bj/R/ZLxDmbmU98ttHlyTMOOzbXGu8CYu9R87zbCSo/+RrqGsmjVbR?=
 =?iso-8859-1?Q?aJNCMHaTvJeUqtnI7aZG2gxCVMM6iouhOjoIlgJycBGtplzlLwMlSXBeWI?=
 =?iso-8859-1?Q?u13qz/CReoAkVZNmWtG9S0QhpZgjJA1afNwfEZAoojCInTK7svbIH/PrYz?=
 =?iso-8859-1?Q?6IRLgCtaC4KAqQHMdmCN+RpEeM+CBDT5ezXQ+IzebYCn+Tb0/Yo2o4fxKv?=
 =?iso-8859-1?Q?MUQdH2ql2/rIH0q2lG7uutIlPDDEan62SibCbnDXzCWa07mH5Mw47NC8Z1?=
 =?iso-8859-1?Q?klqZayBpevxkpyTAte3s43s5gFnqIl65OjIBiuMjb3tmRNeflZPLMPTz64?=
 =?iso-8859-1?Q?uRMCN63bPKwHDl+sYrLody29sOLoZA0Cg/SjwNDYynIh6UdzTN6eYPbrcS?=
 =?iso-8859-1?Q?e8jtSZlh1EhI1/WAwKXcghzWhmo4z0iVMwzDZYsYWeGUk7ptXBkXtAzHri?=
 =?iso-8859-1?Q?U9MvtUsaIw85dkNKfv3YRgCCjRz43NYbuKLpZdDKq8OkUAuVZHemB5OP8D?=
 =?iso-8859-1?Q?dPPsaazkF9q5DCCIs6Xu+8hAKNdOid+3FhtKCkfuXvvaaSTPNe2oPy5MPs?=
 =?iso-8859-1?Q?3AA+G/KjDTY0ySHx0PUXQqmmwPvhp7/iEA6p+5P5QDhPXZoT7W++Eb3Vx/?=
 =?iso-8859-1?Q?aV1gl8qOJhcfbT+eYSZqtSl6Su+liIzEidS3e5vxhBvPBrneYb+Z4+cAqM?=
 =?iso-8859-1?Q?4Xi2KOIFKp1lkwky6z1sxn5JJmlPOYccCTU7tkaA97f3hRvR5jruOO7RDb?=
 =?iso-8859-1?Q?YjrLXIULiObzCdhbb/oA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yXlsPvT0TcGUcbAq7ty+hkrJxntok7iuzOHS96NbTHb6LlRGRCAUdvT4sB?=
 =?iso-8859-1?Q?L2timtSkU9azCiaS5o+8S0CrUB6eKmPIEFSo+8CQfXqmKw27lWSDaacayy?=
 =?iso-8859-1?Q?vPU8qjx4xfEvYbw4uP7kmjChKK6N2mUnxpwqKiUfk9ri/0QsQfawPV09Nd?=
 =?iso-8859-1?Q?212ixJf0O93NsPUJEar8PtxIWRY3d/EisQtcSlD7GpnyXJOU0b4ENouMzU?=
 =?iso-8859-1?Q?sn+WkUeYkoFDECxHNkBZYHGTOcBPBzjjv/IEdQLTzMtKT1rVbHMZj9qCiT?=
 =?iso-8859-1?Q?qWp8TSNlcAenLipMAvERV5yI0O4Rn3GPL+9+hlx8c9nN39MnyK8/L/P4ZO?=
 =?iso-8859-1?Q?f+bZiXT5Upw3Y35GvTBSc8lqDJ1NcEh3nPNLWXArbN6KOCxQLwTpmRMo/Q?=
 =?iso-8859-1?Q?v3bXzLonrvX4AP+0AsMiJmqqR/kLsDn3IxK/rBr/FJCMLGc+I+pRHNIrSv?=
 =?iso-8859-1?Q?4HR9dD1wCGrvQSQaKIgn8KRg9iN5kKY72101m4gn59lgJBfAaX7oXKi+fs?=
 =?iso-8859-1?Q?bVQiXKjpfkeehKei0AeAittAw7FZ2vcrbSOaJKsfyjr5qfXkHzv6YyPMZL?=
 =?iso-8859-1?Q?913C6DGcdgRClWSmK2GXR9Isu2tlockozUNVnbHLY10M//iiZz8NQ1EjB+?=
 =?iso-8859-1?Q?oC0tjQewXOkyNFo1lz7Uj4xNUr9q+umqvS6drHGwyBj7oQxbyTL1GCoOY9?=
 =?iso-8859-1?Q?EOPYmFR1axF/HhmZaPbWEj7ZJTJfI67L8xexNssV5JRe4yrLpp2p6W/PPz?=
 =?iso-8859-1?Q?75B9B/QTunt/ouLEkD+0Q/2NkUDioWXSESw7ZYf0raakXvYWEZk7IncpFZ?=
 =?iso-8859-1?Q?oc+C/2LeCazEeG8e1M/BXvf0kuQDo6PK4dM8HuvGvs28NOg+2iooRgBmhV?=
 =?iso-8859-1?Q?1WQ8eNFOwwForu44wEpZKESi12xY10hHLP+Sv1cDyMUQLV7Hbx+CIZrByQ?=
 =?iso-8859-1?Q?6tCIffyVA1kdc+RpnN8wYfYmP5GP4TcuUDmo71fM9NHSU79glLBx7I3OzA?=
 =?iso-8859-1?Q?nB8gCQddWPcLv0R5KfOKxo/9itiaGHdRZ7DyBiRlVob8IOlhn5AS8wZYNc?=
 =?iso-8859-1?Q?B1fJZURldfUSVHyQwXsaUNx5kk4ftf7mkNcQ9yShCfnqfBpj0H978kG1yY?=
 =?iso-8859-1?Q?Sk+9aEo3Ufz0LXxQJytZw/llRf87712JnhKlX3pssbjt3IALnn2sm4kzxV?=
 =?iso-8859-1?Q?HM+dwk2eDZ+7CeVJs4L6fzLm4+EbNFFd0nHZ2ik7+jOxYkscPOGAHAGIBl?=
 =?iso-8859-1?Q?SD1NJHdyUF2WyrpFLayA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-15995.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11736.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: df452e47-5938-44fb-5330-08dd2ccb1eb6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2025 14:21:46.1643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14151

In a commit of a public repo (which might still require a sign in using git=
hub account, etc, due to possibly the service maintainer's configuration):=
=0A=
=0A=
https://gitee.com/whyyouteach/erg4eye/commit/f5e2c1ea25aaee24868a1790cf59cc=
d0a8288c3c=0A=
=0A=
, a file of full absolute path (including the volume, also known as drive l=
etter, in windows operating system) shows up:=0A=
=0A=
C:\erg4eye_3\xiangxun23080202=A0=0A=
=0A=
; I'm not sure how that path gets into the repo, as this is a repo for a pa=
ck of students. Maybe it's due to a 3rd party tool, or a direct upload via =
the web page of the git service.  I noticed that in:=0A=
=0A=
https://github.com/gitkraken/vscode-gitlens/issues/932=0A=
=0A=
, some similar issues appeared involving a vsCode extension for git.=0A=
=0A=
I cannot checkout outWith the above described commit; the error message is:=
=0A=
=0A=
error: invalid path 'C:\erg4eye_3\xiangxun23080202' =0A=
=0A=
;=0A=
=0A=
My question is: =0A=
1) Per git design, such full absolute is not allowed as it might be out of =
repo, right?=0A=
2) If it's done by a 3rd party tool which might be buggy, git.exe or the gi=
t server would bury the problem in the repo history as long as it's not che=
cked out. As a git hosting service wouldnot bother to check it out, hence i=
t will not be an issue with the server. But once it's cloned and that commi=
t is checked out, an issue would emerge.  Is this understanding correct?=0A=
=0A=
Thanks,=0A=
=0A=
Youtian Wang=0A=
