Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2099.outbound.protection.outlook.com [40.107.247.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2688210F60
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999404; cv=fail; b=VTjnOFKVBo6xoOLFseiNkfNEm0hX+IpaOQIIOSWK0Cy4Zw4Q9JIagCrHRclbQcVhhnwk5RHeR2SQ0AAfHsVh3NeWRZNnFuwAtN/BiLOSOqdkjhN70RO8psxfRsY6dEfziEZa6vLsKIVNEqUjKFRJ7tl+TblsMTTMoeBlxQP4W70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999404; c=relaxed/simple;
	bh=LIDq7uahpf0liBDGDzSUsJwprtb1a8TAlKtG2dfYaMA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gaduTTMphn6q9DOy5LDBZ3kmbTrjBHIUveCbvpDcnvvocvdlTreM1CM/9FmGZHyItuJ2rOMY6+ruGQ3cc/UFQ24r1U3ftlcgrOHXVpVYzZV0xK30FaQ9OMo9Kji6JlwDD/nbrEWeP/k3HOBOgzARD0Tap4MppqgBCFxTwIVQcBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tracsis.com; spf=pass smtp.mailfrom=tracsis.com; dkim=pass (1024-bit key) header.d=tracsisplc.onmicrosoft.com header.i=@tracsisplc.onmicrosoft.com header.b=ZmSe/j+9; arc=fail smtp.client-ip=40.107.247.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tracsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tracsis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tracsisplc.onmicrosoft.com header.i=@tracsisplc.onmicrosoft.com header.b="ZmSe/j+9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cS2DWG1OXPI6w49Wdb2zQDxLtE6rJOf1kSazZLjHHi0c0edJ11aSSS988aiiMVItAZHGwjwfFgncUvKXcymQhE7jV+UJCSmALhjSRoJnZdUsQG9YS7aSvvHDuSqfiySZN0amML38mir9XuzXBUd+arKalxPcJTKxLGXQ1JV7UgKVmxUhybqgfnDU3TApQsRQoWvEyCU8WQgAsD9cBqJV/CM9oSAHpw/qaBbsi4hXpnoqQFwgywgUewjIN4yFzr6U4kdD2Nqm63RCS8mDqw810cTbdLStYxqpuJnGmJUO/VbPOqa2QylpHkD4zlNnnprBac8VY+jKS1APT3c0yElKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LIDq7uahpf0liBDGDzSUsJwprtb1a8TAlKtG2dfYaMA=;
 b=qXW3teq+7gxqwuRqVGVwWPPjqcZhbB8oGnZZt7OqHLH7Jng8tOpkMjlIvlFGSBPzKRdq8xHlnVKm1A2hSTNukP8KuSss+eY1mi8/Bc3tW9AQsZiNNn4rnsN+xtZSQ6zpo0h5sFOjcZGXoYi/W6baNT7wIGPk5ca9LLj6vEWfgObsc8dOOuotZsc5T/biOvUgXn9H4vkZSCkXm3uToUkiua3e8jsHhCcRikvAXGcfcsk4EWQWKhs5Xzq1L0mmkuiWGIdPIaz3BUozPjutt3xjpaaUuDjmN0KqZKNPmQnQzCGo3ngxn3UUteD4I9OitksV0DaRWYoYs98lWsmNVHiBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tracsis.com; dmarc=pass action=none header.from=tracsis.com;
 dkim=pass header.d=tracsis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tracsisplc.onmicrosoft.com; s=selector2-tracsisplc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LIDq7uahpf0liBDGDzSUsJwprtb1a8TAlKtG2dfYaMA=;
 b=ZmSe/j+9G3c2DfOEA0F2pWh/1VXhYBVXs6lunb0Z9MchGkCeyRKWegQxxP2mjhljVD/0OJ6Py5/rd+YjAHenSEE/oVm7ybW2qUarh6drrKDM3GcSxTCZqN0Bwn0lgD7lLUHq4HQZj7BlWcR6P+r9H1W7t9HT7l81ZtVMDUTIPNs=
Received: from DB9PR08MB7194.eurprd08.prod.outlook.com (2603:10a6:10:2cd::21)
 by PA6PR08MB10768.eurprd08.prod.outlook.com (2603:10a6:102:3d2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 10:29:59 +0000
Received: from DB9PR08MB7194.eurprd08.prod.outlook.com
 ([fe80::add6:5598:f30f:fd6f]) by DB9PR08MB7194.eurprd08.prod.outlook.com
 ([fe80::add6:5598:f30f:fd6f%3]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 10:29:59 +0000
From: Francesco Occhipinti <Francesco.Occhipinti@tracsis.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: New checkout --track behaviour?
Thread-Topic: New checkout --track behaviour?
Thread-Index: AQHbTIBrkyO6uFJSqk+vXLc0lrp5MLLiaE87
Date: Thu, 12 Dec 2024 10:29:59 +0000
Message-ID:
 <DB9PR08MB71949D21F5F0E81911F0D50F903F2@DB9PR08MB7194.eurprd08.prod.outlook.com>
References:
 <DB9PR08MB7194822B81F17420B2D3C149903F2@DB9PR08MB7194.eurprd08.prod.outlook.com>
In-Reply-To:
 <DB9PR08MB7194822B81F17420B2D3C149903F2@DB9PR08MB7194.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tracsis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR08MB7194:EE_|PA6PR08MB10768:EE_
x-ms-office365-filtering-correlation-id: c9d04efb-35bb-4903-2ea4-08dd1a97ee73
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?gFPvBsIhZAHhzTnXQHdyC33YgBNK/i5fbfQWCZiPeW8LgEUtJNdewZwmKq?=
 =?iso-8859-1?Q?Z+LP3a0E2CnZL9y/WZJrY6g/mNIdMnPcpc+M0g4K1+CpV9Ub4Zrptsi5fY?=
 =?iso-8859-1?Q?tO6nJUi9L8Nm0mIRiW1JvHC4Ouwpa2YiFisQpWrtYyP7kiKqxrl9+RnffN?=
 =?iso-8859-1?Q?IEwEy1PhV+ZMJRbQ6m8QMgvNPrZSjobXDoNNDXoc1HsIWhZCe/LS2m8/yw?=
 =?iso-8859-1?Q?7aDG5YBEFrApjR3fC8/BlKe2md7XwoTkFbmcZXhK/3lyHKB4rS8mq9Jl0w?=
 =?iso-8859-1?Q?56ram3Wi1/b07LDHlzGoItHLCWabwCHrtPVhKNm1HpBmTiVfpZMYPfXNXh?=
 =?iso-8859-1?Q?o0hf930QjC+ehnjEFx7MNMZdD8uB6BWCqZWRiVVMMI9w2od2VIcvY9plIp?=
 =?iso-8859-1?Q?X1jBF3IU+L3XM0sRv1X5hRHjBAKbUWXqznlcGIXBrEJ5XFWSGNTSpLgVyZ?=
 =?iso-8859-1?Q?5HFyX77+oQmBtgVBTA4UVQ3FxT36T9bhcaltkSpajzSmwvAT5GdbmjPkwr?=
 =?iso-8859-1?Q?PSe7zoscIY/5ZbCSNK7YOlZ0yOgM5JiQmImpjsMesMzrTsAjIXRkPZjep7?=
 =?iso-8859-1?Q?8zWpJqFb9iKmtPlVJrODdMKfOgpN/IhMF2MiWjXQOmNlnRgSxunL0zIPnd?=
 =?iso-8859-1?Q?rsNr1OBw3EAtcHxlS+Kk/A7KHzbvdvax4rSNqNfpQPhsoMj07P/MPZuc0W?=
 =?iso-8859-1?Q?KXfARSOpnrquTnC+mLFbTDtJLXStf3LnMjBYUEUeAWvSwf+Y9NEO1gdKG0?=
 =?iso-8859-1?Q?wYbHd1Ixjv+9gOUdEJV+fDjLPTa8hmNS/M8SFzZQTncHwt9SAEeSFeBDh2?=
 =?iso-8859-1?Q?PBc7//+IV4bBuUN6tUU0hM07kktONXLFTGPwht9yVUbG5RIfnHB9/6I0Ff?=
 =?iso-8859-1?Q?UBSok9caSF2NoI+TjNzPBsZ0hzrM6sRvpDxgZKa9yX8SbCd825NOIYj7C4?=
 =?iso-8859-1?Q?ijZIL9jfHNwSRuyJT8njKiOYPSf6UFmYTRsVyYpFhiLgkdFwMnGP8IjhQp?=
 =?iso-8859-1?Q?GKOcMyFbyc9szKtZJ1j6G2Pre/aDR66Ph5Jju47cGWNskFxdNm292TTHto?=
 =?iso-8859-1?Q?6wcFlFkRSn8a5mq7OwhQdNSOcUuCeN+bcytAtfpZgJdrhcgleZyv1HgAE6?=
 =?iso-8859-1?Q?4axfZZUsTs9qW5pEq+RHw0tslvDPqhKPus5+NHuTkKYz0qCNrhMS5ACC0f?=
 =?iso-8859-1?Q?/F8j6kfAzVB0hbWKiqYIkEKubnOnFj4XtjxRZ+gCi26bNAGI/VL2DNNdEF?=
 =?iso-8859-1?Q?XiUiWRj1Mtp4jpA8EurFmJSayzLt0DdKhQGyhyhGvDuqgNu+5y7bXs7vKx?=
 =?iso-8859-1?Q?uX+iCFdKTrvrqRU+ykp/kOjTfCTDoj777mzAFXr6zr2AsmiTOiQ6X+q4wU?=
 =?iso-8859-1?Q?arOVZ31xQniBhLxtyeS/HOgQpdAw5Dbi2altTbuEmiSI8e7bnT8QVIKdf5?=
 =?iso-8859-1?Q?ZZ+5NlW3EiD95YnEslewCvqUsmdF4AnG5uw6GA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7194.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?H42g4knIrPK+gmveZDOpIhA/j22bnjHgnmz9jFnCLXNhLgZUNIBzOOyzwm?=
 =?iso-8859-1?Q?PjNn2oGRJldSMhV8dhEaGNtH9MIYccOPka1ETe4F2AsWwKO2mS6A/Y7uaE?=
 =?iso-8859-1?Q?XxjyC346kivf3rk5GIYWJv1ZPWH/cYCTWsgqZgrCr6tTwJXjZunwmG/lzk?=
 =?iso-8859-1?Q?f0Zy+PaLpqYFVx+ziROJBq9FwhceyIWfdc0yn0OqhKVlUakZLVWx0kNd7T?=
 =?iso-8859-1?Q?70LMV2nbL9rgTo3OHqvcHhemDHmWImAt118EgGz4GMO2r6Q5bA4IkU/YX/?=
 =?iso-8859-1?Q?R1OgFUOcE9WD+1ub17YWMiMBTQ1I4FTbemyeCAfZT1B/b6/TL/Yr94cPwu?=
 =?iso-8859-1?Q?EUJBQFKbho6nUNlBdU7w3DRY4Uzs3LkaUpEPQQKVlhxBpvBJI9aXMA0v4I?=
 =?iso-8859-1?Q?JQ7Lmwh/Oj4uRKuvBPPcYTNgaEz1Jp5ynvdy0RAZQiK0PYdDU4a5eAyxbe?=
 =?iso-8859-1?Q?rPO1dUzrEwVS+PWDgV65+k4yRLt+cJaLlUH5eS6CPwIMFadxD3Knjs4bao?=
 =?iso-8859-1?Q?dE1zfHCx9ZUIvxSycqh3w7j9DQF+ESEZI3zdGTfQikhOJqnJQOSBRtDfPw?=
 =?iso-8859-1?Q?oveh+/DQISWyKGId8ydZRRMnSOPdG9kMAeRnxM7ZXckkHSImRzkS3LU02X?=
 =?iso-8859-1?Q?GNCx86QvbMjGjMvP2IgZVD9gzY7qmXogL/LWr7WYwwIfGz3i6KMmxDq8Gf?=
 =?iso-8859-1?Q?AeG+Vw2L7KkPkQRtytrllKNs+vsiwuQilhHyns0zRyOzI+meaC/UaeNns7?=
 =?iso-8859-1?Q?sQA8wDbUnETPV7KFnioGQzv06P2np9QFiv8ZqqORU8WLLCqIg1r7LydzZM?=
 =?iso-8859-1?Q?wJ+piAIfD4rdlfW/V3HrWbuTxk4mWjJAqqIkAcjDiceofHkW1BPU989m6X?=
 =?iso-8859-1?Q?IPtJyiGMCplelmtJkk6DcHlXxYcQczSlE7KlP8vH6ZnS6BfnGgvUFcm9Vd?=
 =?iso-8859-1?Q?At97lOGeCJuNWu+ROwNi2owjS4VBBMjCfwHfzbtxM4qVXx9zjK4fZXuKlR?=
 =?iso-8859-1?Q?a/W2jk/QEjK964x5SU6M1Fcj6DyVvLVOGQT7H4FFlRCVuAbQVN8nJwvOPH?=
 =?iso-8859-1?Q?KjBMdLEvCwuwajJazsbZdImwjJuIO9YHLVII9R4nZukNIqW3pRWIHmAo2P?=
 =?iso-8859-1?Q?UwNC7+9ibBr5jHxSZhdcFsLoBNqc9u4ETmG0V1R5gxjtDYKR282M0M4bV+?=
 =?iso-8859-1?Q?OMCoVSAxV9uXOi28eVZ0fRu6IJ0ndgt0miDWIc7KnfcQ5zbtGpbFM4lAtJ?=
 =?iso-8859-1?Q?hWcgPJfYr1F8ttBTd5Cq0AXNtav+oFoyDnundwO7GgY3EgwoIH4civEeo6?=
 =?iso-8859-1?Q?cPea9Lwmr+mQACi5ETzEJmdnybsndGCaYs4SaGaFKkSzUpxSl3ySR0i6bl?=
 =?iso-8859-1?Q?uU3YXhr6ht2nn/2QjPBkXCwR3jM34VLjNe6UcoD0Uw10jd4HLkxip3bDL7?=
 =?iso-8859-1?Q?GIRMTpi36kMopNHt2eFlsJxLNpoaCBw4u3qI4y7/Zkd0BGDK2GivzsGGnN?=
 =?iso-8859-1?Q?EhkF0nmwPi+EvH0jOf7H5jn/1GEopV4kdW+/an+3a9Y3f7+U7w+6aWYOCp?=
 =?iso-8859-1?Q?ZcxW7/IIcuhIQ9XgyvT5qu9Mr5wzOuZHDYCBWyle4Dh1Q5MqYtIi0RUZaj?=
 =?iso-8859-1?Q?14pFz9l8/KxH13VRAx1MUMYv7trP8Q79dL4jSJcwH+fnKdRojdQ7F4ag?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: tracsis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR08MB7194.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d04efb-35bb-4903-2ea4-08dd1a97ee73
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 10:29:59.9151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6b98f266-7d23-4d0a-8b8a-7e4cf7fded86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tod+0mNzER8XcYzZZ+V026/JvwEwBE4myODuAf//qG7dxCKNgzGRwBtzo2wJdFwtZnWUjaxmDZM93jvBgKD5H8HSSoo05NLWKWu0kMz26l3h8JaIBpCyluJPN/DQ2h89
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10768

Hello,=0A=
=0A=
Did the interface change in recent git versions? I am pretty sure i=0A=
used to git checkout -tb new_branch, now getting error: option=0A=
`--track' expects "direct" or "inherit".=0A=
=0A=
User `geirha` on libera#git helped me troubleshooting. They noticed that:=
=0A=
=0A=
- git help checkout differs in its description of --track between=0A=
=A0 2.34.1 (ubuntu 22.04) and 2.43.0 (ubuntu 24.04), so looks like it=0A=
=A0 did change recently=0A=
=0A=
- according to the commit message at=0A=
=A0 https://github.com/git/git/commit/6327f0efed36c64d98a140110171362b7cb75=
a52,=0A=
=A0 -t is supposed to be equivalent to --track=3Ddirect, so likely a bug=0A=
=A0 rather than intentional change=0A=
=0A=
I did read all options in `man git config` looking for something=0A=
related. Found only branch.autoSetupMerge, but neither setting it to=0A=
`always` nor `inherit` helped=0A=
=0A=
Cheers,=0A=
fran=0A=
