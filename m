Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BEC20DD63
	for <git@vger.kernel.org>; Wed, 30 Apr 2025 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001870; cv=fail; b=sRe2k+PwYqrpScRMWFGXqsWxdUjSkVWtnnEwovSG33bfVltneEQ9H3+WxEs1jmhfXnHBbvVbgIvzy+xohWprrpf/c1MQJDpmyVhP651AQq+SBiJGtHnwHrJExzZNoea8Hyuiuu9Lex/7T6nnPGo3WbXJMzU2DvLzXd8EgoKMe94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001870; c=relaxed/simple;
	bh=M6gqHqnmdD2lHoOkVSdH5+osohLS5VZoHY5jHPIbnQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R2zQnn7mol3EOCIqtie7YWbtpsvIcxPXs92DRQ2zRQASPkzc+Vb/YQU0gtcw+M8lWMFUuu216IzM3mCmVqYguH4JgYwPJNydRTHoUUe+mHrm0oWICbRd3URMMtdgu12eNByi7MDdLJ5drVh8SSPmCSliSQSzMGBynxaBPJXIfrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bgcRIj1M; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bgcRIj1M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwWJxMx/NaHv11x2s+c5nSnVJyA4ewmDwHA54KMjgRtxT9YgmdzaZj4aTOwR957grPTWgYkwr5thIQ7pq6lQ0t9HXqC4M0UOo7BZUJ6Ng/9miQqCKq2FemMmH6pIRZxloxXeMEOU6jaUW9Qki96nc0JNLZhejdI2P2SqxGFSGgU+vo0UIRxGTAB16ZiLxkaS/t3FkOffUjEvcqgUI+3muWSRFSawgulYsw5avuw7ph2FmQeBNOdnpwxXD/oZK93lNfYrHhRM21hY8T96GZdU5FXeF65oqqLzy6aCZQPtveOZJnplSZRxZ5F9tl9B4hEDLaGpkq6fmMVG3AopQPS3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mlhc0vXU52+dciDGJ1Q3Y1HTlKg+nUxTsYaIkomqIHs=;
 b=PSvv5tkC7IzPxU4PZsiv5GUhemOkarCRpHTPDcJP3HNwYroKIOGhg9+jYYKX1ohxHEeaL3pH8Dj37Dh+p9IFRO5/jdJsR7DvSvLYOvmz5Nn5SjDfdQk7AWsH5mPiLSPYYU/EQpSUeat4eppnTD8CSftiX+Ari+nLdAmu41JRJKnIo+J7Cf170ml0uka0Ei1o+A3fY6/r+7+9vMl4xR4qCod/ZVihg5LJF1LmNlzu//jPZCjWjBqASjMCipvO93JyMj0svbTnMVarTDBhfUnaJPFaVD2VCozcAo9DWzY/v55RxqWmZGoOxMbWxcVHL2EDTI413+Nx4URGih3Wy8PORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mlhc0vXU52+dciDGJ1Q3Y1HTlKg+nUxTsYaIkomqIHs=;
 b=bgcRIj1Mzc1H3dd0fxOIjfepdAnUf/6TtS3ZnFEmrG/NzenEOYROjr0mJRtvtmkfqfXVpHqKwLvqB0I+Uz7ZPoHyOFASPgbKbRwf5fyaBhzS86yk7AAVUQUc5zvAD8ZUsAeuLPfYqVRm3z/MfyacCibkcxu1yhzGYXG+O4H0pMmvcUTSn/6zLE1NyUM4jsFbc0iePeSmOkhZFuyCk8SQt1TY4dPjumeUaIvkArlJMvJrUm79bVs0Z7A9sQK9etk9JQWBvvKOSBYfGH91uHS8jTy8EThvEB0ulVogN/l8KCNMpvEmT7jtgMoGhBinleEX1ck1N9X5NmTdA2o8uo4r8Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6320.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.21; Wed, 30 Apr
 2025 08:31:03 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 08:31:03 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Julian Swagemakers <julian@swagemakers.org>, "git@vger.kernel.org"
	<git@vger.kernel.org>, M Hickford <mirth.hickford@gmail.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Shengyu Qu
	<wiagn233@outlook.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Erik
 Huelsmann <ehuels@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, Zi Yao
	<ziyao@disroot.org>
Subject: Re: [PATCH v4] send-email: add --[no-]outlook-id-fix option
Thread-Topic: [PATCH v4] send-email: add --[no-]outlook-id-fix option
Thread-Index: AQHbuSVZCBQZq69jsUmxgTDHbfgc17O7RQY6gACdGCA=
Date: Wed, 30 Apr 2025 08:31:03 +0000
Message-ID:
 <PN3PR01MB9597E1E01B3E8FA0F8BF209BB8832@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597AD101D75F316C722E84CB8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqq5xim4lcb.fsf@gitster.g>
In-Reply-To: <xmqq5xim4lcb.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB6320:EE_
x-ms-office365-filtering-correlation-id: f11eac89-274f-446e-14cf-08dd87c1580e
x-ms-exchange-slblob-mailprops:
 WYrkjVEqdmOzyH2mhcTcZDWXXhR8FYs94dDzVwgcLGJ5VaciwPBdKns3W/meftyE1icNczABZX6OuaMaXhh7uH1r6xlAM4pB7AzfwWyt0NWfCWwFiOEdjTnMt9o1Vb3eW7L9aV/jHeLgoevY2HFBf+LK0EN8q0Ww0aWlU82fzBO8VjfYLhxKAb45YN/Gtp067BrBQXRb1jK7ut+gCWb/djUm6CdEV400em9lNZRk9++u8vyUAsnLFr7TT2zxnFsKbeRcJ7RDgGwCQiVVg/NemhMPLeiwUKPbe5Ijb07hCRsX6dv3Zeu4DlOrGj2H04VEqYgw1gRUOnb1kY+0dVrtA2yukU7SUdAWKq8iSsFjJwMXkAzi/9+AlKMR5iz7kK9nJKHLCJEG1bW6geA6SI+Q+SaPP2lPd2AN0ki1dxQcc6eOu/KCwU9M+uiQUrV2JHfD26I3ztnyeka8lJtVMJkx8RjPDW7O35U1Fb81RtfI0x83tU7TonYsQO/cTfactQEvN1pbvA3a3DZRASkOg2t5+qrEmoVWYYAyN/h6PNPKWX/nC2makqp0eXV/e5lvBq81NWgHiuKeJ0TuoQvmVWQqQWktsNqvel8LyXsgeeuMlTqRtMIvDf6OcLF9uCDn09Ef
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|7092599003|15080799006|461199028|8062599003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aCS9h9IS8lqQeuWq5xxoTKi+yszRRrM2o+2vLC1gPTdjemJK/zeRBD6yoUrv?=
 =?us-ascii?Q?3fQuT0zWrw0Iwb9S10qia0H0Cchgl33yoizzHhGjIbLh5V8+EsRNkpp8nlHN?=
 =?us-ascii?Q?gjRt4yRLkoyVUpGH82frBGnMvri6oQSSQ6ZbBsSAvzzn0K4KHzRg1y7wk5nI?=
 =?us-ascii?Q?jmcDJtk5y3pA4xEcpoe06CHh9XSYU71qpIUQXybzLo0o5lhg3Se1ZlQMts6U?=
 =?us-ascii?Q?uIcUP5yd+F0Z3uv2p4l5OL/87oBcPwXJkvJif3nIDlCW9hSIxKi1OzPyD0qK?=
 =?us-ascii?Q?UTevJh/HrqQ8tJv1W70RgtdLJ7eNWZQtwf0SHxD4l95eHsJ/jeZk7e2LmLLV?=
 =?us-ascii?Q?DFFU+p0Yr9MWzuDtkbBEy75P2SB4SiITzoO6x1y2yj5z/hPwwb+T7YHYcwQd?=
 =?us-ascii?Q?hF4ms1esLXyiFAhUiNTQKwrG8tC0tj2bzuSG5HHujQRuXhp0AxKBVX+ysL1s?=
 =?us-ascii?Q?46oxH7EvcIo0mg3oKCidZeAQoiBgk7pOaMdd7P6fFNXM0AeMCk4Ec2LmPgBZ?=
 =?us-ascii?Q?JApjo2gfkzM2eWvr71AJK1T9zg1GTqPTx5mxn+7kVHv+GC29SbHC5kGjkCmi?=
 =?us-ascii?Q?UG+GphfKuo9CSvUx8L0nrUsGajQfbh6khMIbVVXrlRaopjNrPolEiMYsPPpD?=
 =?us-ascii?Q?J+1+G15ZMiBJdSfKBidYZxf63cDQ6HCl9XxgUIxqdzZu3GKLzMCKG3ok7SHm?=
 =?us-ascii?Q?9rIFqpprbndENtYPK/4FvVEEPuXThOxYXr1g1URPBdxU1HA4U0TPung7Hvlf?=
 =?us-ascii?Q?9dD4WOUvqaqWpXpCxd469QHo9wzLJ1t9jVgwUZ/tQCbOFEQfRAb8ZXf+xRDp?=
 =?us-ascii?Q?tVFOp+Kcys3gDXS+aeBUIwzPTLM4oWWaUh+TXbEgAOkI6T8fq361QxcWdtl+?=
 =?us-ascii?Q?3OXVVD0mFnnHAK4rkMAlWQQDLnezRKHfI29AwNJWqe3EO/YAT+6Xd+skTzGd?=
 =?us-ascii?Q?ODSPQY5XIJcw9MqMc3dPtsS9mkAWNQ986cnH5N54kUtSaxHWic3V0CW1A0U8?=
 =?us-ascii?Q?tekh6ioJtlBH/L2Lna5vGSk6jye1gLBtgJNRe5amYWjmYhhkid7o5n/6W+jo?=
 =?us-ascii?Q?b4l22i4RMdpqvlet3Ek3LePJctJ3BjU8zLYVlWIS+W+ts8NFueE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?puSGYVhmM8ITpiOXb/M72C8ufO0nIU+AdwGh5IvOppBfvUqNktlpk+h7EhmW?=
 =?us-ascii?Q?7gIzdIuQ1OJJBr9f968S3iix960+pfWan+Wq0Slkm2/cOP8F3J3Hdwt8Sg53?=
 =?us-ascii?Q?+NNfDQKzn7S4dyeUemHFYVt+YdhjpnecXbWFdejgHsWpjT6snHyChaIH+v52?=
 =?us-ascii?Q?EQPT2LFAmMuBu6NONhcfMTWcd+ewktXfDY/nbKIQMhH2+BkYfdR6a9iizqvy?=
 =?us-ascii?Q?O8aNRyK8wcUwO1bkJwjFH2nCbpqG7k23XCwyOMhH/HVYDfMiiNoKhxyfDdAv?=
 =?us-ascii?Q?wiTayy3M1qlUH5DjGuHtVq+jKC0jKdusFXRbyvCFPNKPDqxwSaTiUzDJeYnd?=
 =?us-ascii?Q?AmNi7NkpcrwITbpS/PdqsvUiKayyfd1Aw5qkiukxT8r11MU1GuzQdI8xyq8c?=
 =?us-ascii?Q?OS2HhWRMrfPYsIaQcY42hWcimHw+MhYH7tZxzqHhGG0ZooQceIkQGIbvs0x8?=
 =?us-ascii?Q?rpcECQHk4ncQpbD9YVHbuMbiNythStkXMLjafOHrKmRRM9U9Qy000YHbx+uj?=
 =?us-ascii?Q?5shH6xb/KRmHJflpMuq7WfCAN1PVfMyCrUPJvU4mtIaq4cOpGX26emVZBlk2?=
 =?us-ascii?Q?yoYJprz6fI55f6p7hBu7l9xw8FXB/GZFMyrRysyAQ+GI3WHG2ljVx3lZ6prc?=
 =?us-ascii?Q?3Sb1Y7mIwmwV1nTzaDb1N4IRk8Ba8YPoFqLuzN8HikEXL/Zj5WZZjZK1bp09?=
 =?us-ascii?Q?71nyPuzENRi+GPzbwIy1LAJfcN2I4uWAwDen8AW2FOr8m+dHwpJ+0LOngEia?=
 =?us-ascii?Q?aBM+C9brVxYVOUE3VPAS1jask+xxXnvYBwh9vqD+lSXj7G632Y+SsPchys2y?=
 =?us-ascii?Q?TqM7vMHaAHU91ZzRJU/pWgY+x6WJcUUBPfHlOkzEJbTZinw7m2Qux8XDqiI+?=
 =?us-ascii?Q?Ikl0ZaV5GGGeKexfKUo2zQsuDoie1X+2iE8Zgx4xWy8HtVt+vfR4XyR5cqaA?=
 =?us-ascii?Q?GTL2WiOaefgOd+pRdF4jcq0vLCbXdfi4TcV/B3ZlhaenFVo+FLL7tPzhqdu2?=
 =?us-ascii?Q?KIeKaq/K3UqzAyEJ31TAY3uaQRjYVIvdqsdiR56A5DsirxiWTiBjImf1Qj9e?=
 =?us-ascii?Q?071DiHkyp462StNjGk0I5wFoO/CcvfF6DYu+KMMVUPWYv15oM/09eqxOOLu8?=
 =?us-ascii?Q?LMy4Pz5uhiQaVjq5XsmZcr7MB1JtwyfbourOYzeQJQJ0vqZfQiYp8KY0ICUd?=
 =?us-ascii?Q?uCB6hklhhxR0Jtps5QwApRURbIkdwJtyFyYuulfN9yfwNXIGpow+/l96490i?=
 =?us-ascii?Q?8UmoDdmxLz9wf/g/pT5nVw3tKbc4et0k6Hghma5ZDVFt2pKXfkZeLxgNLSs9?=
 =?us-ascii?Q?6Cw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f11eac89-274f-446e-14cf-08dd87c1580e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 08:31:03.1841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6320

> You'd need the usual "a line with only + on it as the paragraph
> separator, with subsequent paragraphs dedented" mark-up.  I'll tweak
> this part on my end.

Thanks!
