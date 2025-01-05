Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011027.outbound.protection.outlook.com [52.103.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8BF29B0
	for <git@vger.kernel.org>; Sun,  5 Jan 2025 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736081891; cv=fail; b=mLcDmMab6EZVoB11q5FvR9rpDfSJK3GnOJXp8uEyK9qeD3l4zbbTcDoWM5e2t0Pw8FeQAVJF7wt76tVLt3obvASH+n8VFSPl3a2+EAeyhGQorxcR85a8ZRV6QpXDwPTxS4tSMdc2qLAF2yB1qSKpR+MqWow0HjENgQYNHJ1vskw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736081891; c=relaxed/simple;
	bh=+PjJvgx8y16GXQlGtVR90J/d4BemtDyPS2aEll1BTuE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OC4iv05IOYZRCeE915gzJqsNStkmhebPWho5RdBrzH4tyf+kZy8Zzh6oOZEyM0LC2Ds/2UCx8Z077WnmzmtJ11K5SHx/y/G6euYR10BYoGaVObQuy3ECr7mlS3uS7vvWj+4DzYs9W/oWFC6sX3Dcbi1Hb8CK+Uc/uMQ9T6XALgw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msn.com; spf=pass smtp.mailfrom=msn.com; dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b=HOv1+F5X; arc=fail smtp.client-ip=52.103.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=msn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=msn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=msn.com header.i=@msn.com header.b="HOv1+F5X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrFovOk11pPufToZiWgxIgNOYYlMna5PwbSNXM+LEcJ/0q/RNIn4CazYENbFGC+AYvRRvxlFBTpYeiTLF37anP7GVJaGwiyzoj6ERxLioJ4FQC963GbmXLXL5qJJFD4cDrrS2J9lhusrOfkv9zA4APsgiLHeM8n1W2PSBm/dC6PbYDAV0yYZlVVOz3KNwH5vi195ew0pZgcancizdtc3vhlYndG3KlXgqga+dFIIqr5m4kCtIfQ1WNnIgdlXc8DqeY8pnYgIJPJt0pzZa4C8UAZxgLKVo6FJ05kUENBXArnWgTim70Cbtkmf0+roR0S+C0h4XXF5SNatiTDSJArQqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PjJvgx8y16GXQlGtVR90J/d4BemtDyPS2aEll1BTuE=;
 b=BnCJY0dgus3Rr+rG5NbKWyYu4K4a8aI85Vw17sODAhc7q30QqhCt0dcyjg5i+3sgnipGaXRZ8mRRjbiNBtTxRK+4ZzNtX8GheYHHmTmE6DvylRt0JPKsFOynZp/yuqz078jaSgAHeRjnLB5RJa6jrLCcdaF/vhCmFHrWxHCHPmAWpFyfASqIJyYpGJPDLvo1xdVdiDvMpUq074x6SaKuZ1G7cY5pgLc3N4wZzTPtS+TOISiTMXyBHPWYShEcK6gNbbxeKrZKI6XHvKQQFyk/iVnt0sldwE51igWm9n9SJi0Dh6LNcA97Y9S6wUexngOmYVff5LE4HqJt+7u71CjQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=msn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PjJvgx8y16GXQlGtVR90J/d4BemtDyPS2aEll1BTuE=;
 b=HOv1+F5Xs80tRyRUVi6BRaf/YTzZS+WJzib2cnDBPB4P4X5C0NaZdaCI+7p1s7TD+mseRgOgYvuz0jqqPRuJfv7HWR8Xmxa5I3/3k3fJBWfR/vyY11wzJh4mBrsWQpPNfjZEH9e8OlXZEAG79wEeASs3KsvcwCkSDPCsR1bR4+S9KzLVojlV5jM3dalCM7Kp5H3kYck7zBzYQx4jOMX2Pr+PEg8367DZxIo6a2M6pe5cV4872fVBQ7wIe0ho/+Ug/1QiQ7qPizsA6pxzk8Y3ekit7cvwWBV/X87wWOeqfdJfybHF+m3gI0BjF8IaLKocx/W0igImjgJX1LS3nLMVRg==
Received: from TYCPR01MB11736.jpnprd01.prod.outlook.com (2603:1096:400:3e2::5)
 by TYTPR01MB10923.jpnprd01.prod.outlook.com (2603:1096:400:3a1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Sun, 5 Jan
 2025 12:58:08 +0000
Received: from TYCPR01MB11736.jpnprd01.prod.outlook.com
 ([fe80::76d0:50f8:9313:d67d]) by TYCPR01MB11736.jpnprd01.prod.outlook.com
 ([fe80::76d0:50f8:9313:d67d%6]) with mapi id 15.20.8314.015; Sun, 5 Jan 2025
 12:58:08 +0000
From: Youtian WANG <wangyoutian@msn.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Full absolute path in a commit makes checkout fail
Thread-Topic: Full absolute path in a commit makes checkout fail
Thread-Index: AQHbXq9WWyn+TfRRkUyJFZTo0v1Fg7MG2nuAgAFK6kg=
Date: Sun, 5 Jan 2025 12:58:08 +0000
Message-ID:
 <TYCPR01MB11736EEBE8552070648620C99AB172@TYCPR01MB11736.jpnprd01.prod.outlook.com>
References:
 <TYCPR01MB1173678128DCC128099726865AB162@TYCPR01MB11736.jpnprd01.prod.outlook.com>
 <Z3lsJZt-9N9IWoe-@tapette.crustytoothpaste.net>
In-Reply-To: <Z3lsJZt-9N9IWoe-@tapette.crustytoothpaste.net>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11736:EE_|TYTPR01MB10923:EE_
x-ms-office365-filtering-correlation-id: 28ad2eeb-04b6-422a-9a21-08dd2d889a31
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15030799003|15080799006|19110799003|7092599003|8062599003|8060799006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4wlHyL7kuKAC6xAbe/jKAHanOSrT4sRiWBgytqcyIbf4HvK+GORfIf/SR3?=
 =?iso-8859-1?Q?o6Vz3F1VgTFFpEv36bH/QkP8B9Qhsn8tQ2tx6j/9xe/iTlLFWtVE8dq1Wv?=
 =?iso-8859-1?Q?9nfMt1y9t+Ji4NBqa665UTv7cmDjKJkgqh/NmgH5xaoHiPI1l4+64U1x4d?=
 =?iso-8859-1?Q?jMWlIJIfxoRH/1Fg+xCWqNAMk9zuDCjdneJka8PD38AZ2HaIJqQXk8Jn9D?=
 =?iso-8859-1?Q?UjFq/KYgXk2C1mOWvuHl5AVReJifl+ZZrEx3WkemZ5xEAd/3HIfBbmgVnB?=
 =?iso-8859-1?Q?U1V6E1tDE8ciGvQ9tbOb4AdLDe6HrxP/9cdsxFF1hjCF86Uktn6Cva8yDf?=
 =?iso-8859-1?Q?aRL8O05GDa0gWeReub3028A7KJFgWFBATsfZ+4h7kuj+Uqk0ZeHzalBhZl?=
 =?iso-8859-1?Q?mor2fSP3lK350fXFdt1F3iWczWIKzfi2f2BDZcB2NdsZeWZZpCfVTSoHA9?=
 =?iso-8859-1?Q?CMWXeMwqJYRjznlOsnWzSZi/QO8/UneTuEJmw9def8T5HukKCYp3E3Pc2r?=
 =?iso-8859-1?Q?Gp9m/5XhUN6V3/eGTt75qGOBzdzxN9P6t8HQJ0KRUEmTgnoyIBr95h5SEf?=
 =?iso-8859-1?Q?MXWJQYdCJ2IGOBLKyjXMSMFZQTPL+UY/kBvyHXFLl9S5IBtdF7nHny4rbz?=
 =?iso-8859-1?Q?9d46YRLyBYXspyxP2DCynGd8NArrYPj7OxnVGhNv5ZqEL/A53XgxyagpTF?=
 =?iso-8859-1?Q?0RqlDbnerD+QeiczhjG9JoY0K/4yNxh6ZC/cawJZRQHsqll5ih0hM+zt4r?=
 =?iso-8859-1?Q?hc5MapyKVmoeo3fwjF3HQeQxi3B5j0uBO1svhU4hShD4AleWLd+RRJeZAD?=
 =?iso-8859-1?Q?b6P5ktfOLrnp3O6LWitXDFF4AoYzB6K50nt7WAY7W8ZyZ/YC2BHbzvP1ky?=
 =?iso-8859-1?Q?z3Oh6IdpGkk7hGdViFpeD2+P6+bTcb02aHj07a+ERlpz3YU9LBkc8PkUhY?=
 =?iso-8859-1?Q?usmj48KblhjgVAdBjz5CYnR6/BSfL+ELOhqNs83kdk4cPgGKkH95Xfap4O?=
 =?iso-8859-1?Q?VR4c++APYeYK9cAkcuNmL/RnKLGdGwnHSmr4wQbcvHldxfAzPVi9TM2D+f?=
 =?iso-8859-1?Q?bE/yJ1SagUoco8dU3SyNBIwIVk8HaBJDtvMGEcTWnIRHbAeuVcV6S0MoIO?=
 =?iso-8859-1?Q?KhI3gQ28IjcnRMbvgRDfsOz4N08ic=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?79agetaBvNd54A+taYRX69gQ7C9DlV079WbcxC2Cypd9f8LReF6dWE0LbE?=
 =?iso-8859-1?Q?1DkleWg0ICi1fieqDSGYMksjlvEwimI0//oCa3xOIg0RxCP5ujLURriKWP?=
 =?iso-8859-1?Q?iKF27zgpoJpQ4P7phfRavtVNyAgVeWA7bygQ8BK5JdjnoghwTvLDYaRZtC?=
 =?iso-8859-1?Q?AMKJWd/2OwK/OcOW3II2CNIGUWmE/CnkXX7POgs9s83O3PYGZCjv4tC4NX?=
 =?iso-8859-1?Q?75Us3U9xLVqD+C5aqDO3M5CpCnafID9i8ExweW0pGT09CBjcEcXoH9jbBL?=
 =?iso-8859-1?Q?Vbab6C4s79f0nwkOXIIBBHiOFi4N3TwhZ4+kOPWsgNsmRvGNUuK+TBocta?=
 =?iso-8859-1?Q?xrx8B22EgNOFQ7ci1ZIQpiVS/eUiplHBSNZOaccKAi78xI+MFzFqC7rckY?=
 =?iso-8859-1?Q?feFur1wikQuz0QCQWfRHT3KvRcNoeIKYbpTIO8XGZt5QL+g5lcIT9yCqRA?=
 =?iso-8859-1?Q?kUuFMI+CxEaFWUhvYFAq3CjEcf0I6SV0KxtTXcpN+EZjYyCxzxP7E9rYp3?=
 =?iso-8859-1?Q?p6Y3TIv1lJKAdVSDOG0rzNmXmkPsojH6nNEzqDzRmj0BWhTwy6fPORjJHi?=
 =?iso-8859-1?Q?+HKtKQL1JS9WZSfrLahYUUnk+49Q18Ly/ju8R6AZ3qLy0TYPhx0TOpn/Lf?=
 =?iso-8859-1?Q?Sxua+U2FVo2swjOsvMktqfKfaKqcg7wINkjzbTcMc/yqsR9u7paj9y1KFx?=
 =?iso-8859-1?Q?KBKn9AjcvrBXnqqTjVoFu6v7qKHi0xOTMZ2e5ydac6Hi1bQkw7tyLodiv3?=
 =?iso-8859-1?Q?rXHq6HmTV53+hvucnhx4aT7Rg+oUdcSPQt6cLlKHfYjmIsVBncCuQreCpV?=
 =?iso-8859-1?Q?fWMfCustzktylpaBavUxKsu6bb8V1L5Dj7UsLzJJUTqBEY/vs7A+wdP9fQ?=
 =?iso-8859-1?Q?pvG5jp9zYL2jAvM/HlHiwucWyk8b9S21a7oMD39h7ECdun9ypctcpknqVk?=
 =?iso-8859-1?Q?LKjJdNqUVaBeVaXFxYdqxxoNuuG8v8fqzC4y/bw6Ri5FEWUzFYJPdpdoK5?=
 =?iso-8859-1?Q?fSaULzUQGgAJwmRPv4vhO6dBiDL8W7ut44hKfX3yXGBaK3MhU9rvvhpCqS?=
 =?iso-8859-1?Q?C0WiINR/rUHRi8113NULWTSJqHlHzaUbkQqHXaKmR0tDVOtpaUt5/yaVU9?=
 =?iso-8859-1?Q?9KlQugDnzPNDF3yj1oO082EeaEGsBzr/zYpTble7rO8UXDOj+CWzYi2G6N?=
 =?iso-8859-1?Q?gbic+LGAyen+W2/PPa1vn5RScKHfqx3S7t0HV0LSJDpgQw3N4k8Fe1v/og?=
 =?iso-8859-1?Q?d1MhKuLKGa1E44P+G5Ww=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ad2eeb-04b6-422a-9a21-08dd2d889a31
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2025 12:58:08.1835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10923

Bingo, this clearly and completely solved the problem that were on my mind =
for quite a while. =0A=
=0A=
Thanks, Mr. Carlson!=0A=
=0A=
Youtian Wang=
