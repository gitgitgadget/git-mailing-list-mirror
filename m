Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2051.outbound.protection.outlook.com [40.92.57.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003BE16E863
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748977447; cv=fail; b=XFy1zT704oKi8treJI17lfJ3UPF4oxiz9CPcQVjMsX9Qjd0ZCOY8xwm+SVdnSy720QfZbPvvoV2LPEJjrLcH033Hp0YxcSsXL6496b9eQeLLFeRV+RLN5BjVIq9g9Eq75oo4mJxqCNMKTyPCRmLEzxC1XkMoAlp0SVxBLdflIUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748977447; c=relaxed/simple;
	bh=aiH7DHYzEh5scGFcUj8UXrpb9QP1WPtwa/04Ncu1PKw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=G9hgNQS/hIdbQEQHr3V/y/LtC8kYdhzEY2e2RdRES5ZrXDFtQ6py8yZKKG0tNKcTXU81V+NVc+VYviv0r0QJ0t4K5EwRnfpz58JU1Y9SeqXnBVP1RB7GPqBWXl2AL2DzTS5OhTNu8rKufCdrGGsSeXqXNOL36l1LbYivoWlezAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=VvjIaLAo; arc=fail smtp.client-ip=40.92.57.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="VvjIaLAo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QJN5t699qoj5xvhoORyP1PVQu+nlW5jxgCrQX4pK86D1pftDacW+FY0zbKrStG1QFzXTjbekTfAscwVgayWgpcEFVGkDDXA+1bH2XZU5mYKArGYFXCWXaCp04MF+VmhLfRKi4j2PzoXxwOKP7fE+fdeLo7+nY/nAumjvy5nJ98l/lk/LDUcsGS1+BslNJcZcUrdvx14rtxjheoF1Lz+LAjhEkzfzETJpxrOMPIHpGxMsovc1+AFL8jYIMpQ9h1/PdEzcc12THRllqyrPC+c/sD+u5s4p6SYxDnZOhDDn70nZNVwQnyexI4psIrHItA+3GkzV+rl72mXevv9ObXi9JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aiH7DHYzEh5scGFcUj8UXrpb9QP1WPtwa/04Ncu1PKw=;
 b=v2jr8bLxaPveEjVYShaIEl61eDFJ0n8vXeTPHAqvfhIpkyIuuR6dp1tLd+8o87Ir7AAkQbNMQ9y687c3PeG5Wn5ZwOBfw8FgZXXh3HxUohXy+8WE1COfHJ0z+1wE9aKLW2s/b/+yfVmtOWbIkCOjg0fmyOmxgpLoJO0NdpbrNNpOS/YFl3uMxH8J74v3Mo5uqWwr/ThcogQbmTnrZVS8Dqm8tqkZwmoiEDdyW4YFg7qJmE9/hNwn7LZbAbkviB+JrBeU70dRGuNByKHBoxT9vPWOLmEWKo6tHcMIYGn/BEVgOMzlVqf1n0mm9nXF5nzVCSb/s/UALuw7Q5INXquS8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aiH7DHYzEh5scGFcUj8UXrpb9QP1WPtwa/04Ncu1PKw=;
 b=VvjIaLAoo6WE3yXxZbt3aUP7mEG1G2xr5Aegw+xH8X1hlbuLMOVTUkH6j0SZ1Lo05wp5IrKnIClkIoQIX+zDEjCXUIv3laURD9tL+ddK0p+ZHDTgRx860qdZw4gLfCkCow7FZ8eX6P4TPznEqlkXIyQLrqkEHAV9fL70IkxzQPYQ9x1pw3ZgzBa5iwMBDjSDZc4mgKeOJOH9LmbgqjyN0ofUr1rzfz/uhVr0FSpGzYwKLzaQVC8z2orwdl2/CHbGqyQtCsMFqO/Sm1n2hWlz1jelBSW206jyk4ZW0Gn14/mJRyTz1nxnZxvgDjtqmQ4rGqTeS5kgRwFueUyNqotfhw==
Received: from DB9P194MB1875.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:39a::13)
 by PA4P194MB1021.EURP194.PROD.OUTLOOK.COM (2603:10a6:102:c9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 19:04:03 +0000
Received: from DB9P194MB1875.EURP194.PROD.OUTLOOK.COM
 ([fe80::cd1:cffc:b1ee:b3c]) by DB9P194MB1875.EURP194.PROD.OUTLOOK.COM
 ([fe80::cd1:cffc:b1ee:b3c%5]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 19:04:03 +0000
From: Sara Pots <julei.pots346@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: # git@vger.kernel.org Offer  report Re :Increase Website Search
 Visibility
Thread-Topic: # git@vger.kernel.org Offer  report Re :Increase Website Search
 Visibility
Thread-Index: AdvUsEA1bXEEMIdDTqCGnaovSmBLYA==
Date: Tue, 3 Jun 2025 19:04:03 +0000
Message-ID:
 <DB9P194MB18755BEF84F3D8876E4CD804B76DA@DB9P194MB1875.EURP194.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P194MB1875:EE_|PA4P194MB1021:EE_
x-ms-office365-filtering-correlation-id: 99927add-a738-45a9-5d3f-08dda2d167f6
x-ms-exchange-slblob-mailprops:
 Vs63Iqe4sQlaWPeXpnF+2P0N5cr88TRD7bGFHJ8inLxK6RGf61EXXISU/Pqr3XDK9SxXMtvWwpVQteLOcfWIfFKEGfOL8UjNRGxlSPj4FThdK3Tp5GSJBcXjkFyCsG6n2sAsroMv9xDexs9zt1rRfls3LlN36G600LsTGU2x6H15px2qGjafUTfQM8rnCU7clVK3Y38U7BItiatkAUVIvKcK6llyNqbQv1nOpsznn2M9ZBhUM5iXHqBo2SJhb/tS4JrXV+AI+tmu2jYJCB+nFR4ZxNIhtHTv7WaEr7cLW6aKeF8zRRveTfyy8SmYNoeBKB22Ohkp0CDOxmKshBYOarzjJo8XjTiqmBpYyStcgvmZHsMsNPPhXf+FpfBJRvrTe6rqUJb3vgjLMd3qeDImCG/m1OHL1vz4hH4PuilcpsOti4M4LdnfNVq7fJCH9JmJ0EExnu5f9IgHhrxW2D23qj1MyHQWYNTh+sC7xhJfVhLItA/K6Dyg1wIkY7KxnLLM/F28D7USmdCNcv16/Hl07lviLDLqnJRCC0DqT+j8xJd1u2LRwp3rlXf2LS0uygoJjVTFvmqqc0PvPtiJ9xDNkYSK37DH41SNb0UkFcSxHLe6aZaXvOAVnI43vhs7SBHMngx8XDjVWAYXnkDj8yKr7JwDfPhwsUa1HnwNzGVBvmFpmYdXBajUQBHsaGMadFOaZiiPhL4xokQbqiIFs4Fwfprk32pF4oA+Ix+Ho5IHmrc=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|19110799006|8062599006|8060799009|5062599005|36102599003|461199028|3412199025|440099028|11031999003|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?1tbPwzlk5qZTay83JZxKozqucF2M2n4tZztnky3AgigUjjAmwU5QGjj3OqHF?=
 =?us-ascii?Q?ZF7dPsIAsyI3CHtrkjHjggCVz6tlGFJJnq0EO8XYErfXQ/Erf2dmQVblv5Ai?=
 =?us-ascii?Q?XJm9o6oJR9Tu50GCP+d67mupcpNj16uyt0O7lGAXKWfS+HJbMqihidiejEm4?=
 =?us-ascii?Q?N9jYNzM2em2gYnEHolgxmdawQxDqVuo7u1kuZlOqNNifCcb/ilbz+qwpePD9?=
 =?us-ascii?Q?PHVofscRrmx34qFub0QdXyDGBv/L/59ROn7ECAxsHr7tTwRaE10q804rjL5t?=
 =?us-ascii?Q?su7V2nnASiuXBTN44ZkjqIUwfsDcFF5NCR+347fTgLmVcz0b2yrzF7/ZNNMf?=
 =?us-ascii?Q?ybASmuADucpV0JPsQ3A7wpXYIL/3RXvL8MIQ00mRnmdqr1UPfu0/LkLhs6iB?=
 =?us-ascii?Q?99XAs6HQaihNowVJa0MOXl7WxrYAB2rGRM95yPTbIBJBNAeieMj4n02GIP3V?=
 =?us-ascii?Q?1h4ikreXn7QI/Wrx0n1rv20TwvBw1Js4+6I9ynLyVIwomr0vtQnXN71sH4Ng?=
 =?us-ascii?Q?k18ykimBS7ttegky2XXWRX9n+dssBLqMUoMrQ5efTEXX3lILYrWNP0gz+fnM?=
 =?us-ascii?Q?Nlb4KI1aFcT5fboSYHJ3rzBKpoYOM9Y3zNxGGY+C6kWFHuvMayXLuV1zdoAO?=
 =?us-ascii?Q?bzbaTQH2S1tlQvrxcjLAFVqairtsIPMDsWDdcmL4Y6jd0dGb5C9Ul2du8+9l?=
 =?us-ascii?Q?EUVydC+XPp07RDe7FRLMVyK5x0Y7/pWzz/w5J7mobVjeI5E9p2m+uTiH8f7v?=
 =?us-ascii?Q?iU6Z0pxnSLbKKb/Z28EsolpUd2emvzx87+xfOGq6LRAES1uz7DwdeJs7hZzG?=
 =?us-ascii?Q?muGoIM1cucYRkeLLDUEJ787jljpGnGx9oWunwiF7nwEXYzZUVEmnJY0qM4Og?=
 =?us-ascii?Q?u/tmIFHC3yzRZQh9cMXOGy5BdyQMfPGj8P2rXgnOvAkPEEwl72HQQh64hadR?=
 =?us-ascii?Q?9v5HAI9UnzM4dJTcD6NqFsbhvWbhpqa9RCxRRxL6+NnTawWKfWvR3pcFmv/S?=
 =?us-ascii?Q?WSkhvSxJY6A/CuIerqAC/uhxbWkX5jETRVdT9yCyu/n7tJd++ZpiS7AtSCsB?=
 =?us-ascii?Q?8j4w3WLVTK/R9ngsiKuxDfGDRlN53LiYUKMVMbosNnWI11fHx9oopdQaw85t?=
 =?us-ascii?Q?CqJhWqqxaXKlVqFcrt6+pnYtfz7dBocH585mkQWcBTa5jEdmVTTyliriwi86?=
 =?us-ascii?Q?CLukygyeB2ZfQjodZox65S0wV6sDLgRo4uyEpA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sXbrR/A2jhmtNAHWAv9CLL60tMRlbYtZdC4umQP2MKFqJl6LefRfK59BW45p?=
 =?us-ascii?Q?ybT2N5irZ4PXJQ611VhAm1Jq6owmT8Wrxk0PZJU3bTCQdV9+R6OQ/AX3XNWo?=
 =?us-ascii?Q?i1OWGEoSp7x39Kc8Ysy294Tzka+hsdrBB1vfwt7TC6gUQkvWOeFNGbJU/tDG?=
 =?us-ascii?Q?ncxmcXy25LBsUN8F7H0YIq4ceqczfmR/oHYV/wplgHvSxZJeCvPLRPlAjpcC?=
 =?us-ascii?Q?exMQne6jvBJ2qs+6zJbGO8HxKOeXh9UdbeGrMBF1RViYMwq3Xdj+1IuKp8sZ?=
 =?us-ascii?Q?lRhOjxwh/K0wQza62Qxf6mmFJKWDQPyADD6VwggYNrPyjEnxZhiSfAx7cOzS?=
 =?us-ascii?Q?FviGAAG1vyIwCNDaEdRBwm1DPJrLlmvA2TMEwHzPKvTdjmlv5BwhlvmhT7ty?=
 =?us-ascii?Q?t8D+x/CTPpI4mI5nSl1DYua6Ol40juiEUEVcwQEKpRdNEPyTcFCEtM6rzR7L?=
 =?us-ascii?Q?BOQMXEVFj7tj5jisaGNloTF0HXLiuAjw1FS2vcDQfYOd9YTbmvu3RJLk/NBN?=
 =?us-ascii?Q?23KwnmSSqdqVZ4WVAS6tcxhQmX3LJNLi8adOxHaMZbGXVc1+JH3dcm3BOsm9?=
 =?us-ascii?Q?9a32HZ0gKbU2LQl1+Zc2V6N0kmsSmKi5FmQM7o7cqdIDCdpVv80e8l8PIVBQ?=
 =?us-ascii?Q?BQjaVdQxCG481bLn9Sm7qfamJ9YjvFVR5QW30dfGzWIAnx8XCddh4uwkuUPH?=
 =?us-ascii?Q?zZfWB/GwyaJ8CNRuHXVIg4haCgSw5UN0RjC8d7dP/50AgGlRXgbzlJSEqTNM?=
 =?us-ascii?Q?DK/RwO0LQzrHnImqhvOQBFfBZE1KPX9PeKzg1VhKCRbPlWoSrJlbcjC9KbVW?=
 =?us-ascii?Q?9MVxj3qNz6MxIo7x44/DJWKCa29Nc2MsuhKTEdqW1zTCMHw/1czaZWbBucxe?=
 =?us-ascii?Q?r5PwFcHBl3Z08qI6Yd/F07YqKC5ub+lboWi/YbHlp47sAU8IL2+L0knhirHj?=
 =?us-ascii?Q?tiEF3S5l8Ncf34IRsIJ8T/GLYcFNom9csOwegBvWG3kS04pEJIFZeLRzO9eu?=
 =?us-ascii?Q?EVHaWqDYxfDaHXFvgiEvyClyu5QeqaXlqAAEwbBAgShP/NSVMAteIVZnGyHQ?=
 =?us-ascii?Q?reecPKuVEXrWINIbnWiG74cz+JvVl2+Gke5uG756HHVfqzqBCQcUFwCHpt2M?=
 =?us-ascii?Q?m1ah7h1R84vvKbWzBLIOlngc4+fqZ3/jb7qSHdr6fJFEC7q6xtaLWB/hUmCR?=
 =?us-ascii?Q?mWFneADSBLeK4kjZA+c0esFQPcBWQywM1zqXPa+dPNB9eG1CKlsHOCt0f5Q?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-9bdce.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P194MB1875.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 99927add-a738-45a9-5d3f-08dda2d167f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 19:04:03.2324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P194MB1021

Hello git@vger.kernel.org ,=20
Greetings for the morning.=20
I have your site [git@vger.kernel.org] It has great graphics, but it
doesn't rank well on Google and other major search engines.

I am an SEO expert services provider and have helped over 250 companies
get on (Google's first page). My price is very cheap.

>> Can you send me a complete offer?=20
 Thank you.=20

