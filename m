Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013083.outbound.protection.outlook.com [52.103.46.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223E4B04B7
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786414410; cv=fail; b=gehtEr8zfM9TZM5aDiuN7ZCbvEd6wDJoTpOmpp3bqtfiZ/Fl3lWEgl8f8KubIaz4Kl8Gh8RSeHGk5/7UTtN6Iwbbj6Id2b97DoYsSKhlKwCBhHngiAaoMJsH2VC4ycN1H2HyHuG7FJiCEbBCZcWF9mnIwtWsjq/jtHjpP5AdcJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786414410; c=relaxed/simple;
	bh=6lVl6/5IGMmwyB0wO/BiDMscsvMVRTc0Ip6lWlx55EA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QX3TveeoQ61VxUat8ThS+Vycqw+DQaLhNaRD1lttjTFu2rPoVkrMuZqfAgrnEFcMVBGDZyqVNSYb1qTwYBNe8zMYUSvhn8qFQ/uYuK21n7Mpl3D6QQ+gU/pdDZjO5XZJTsMg1QOhgd3983LeEqvXc82pRwQYOX6GFlyJsR9i8nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=n8Z8Syyk; arc=fail smtp.client-ip=52.103.46.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="n8Z8Syyk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD5ln2DY7JLGGIK+pJOorHjGsTVQnGiuRs0kX9mqvovqhdV6Ptb9DEKShQ72+TyyU7Gw81Ha6KWq65DKWPZVMOsQsZ7HMX6T0VKvMSf4b/vYUDpUinQKB5SL6/ozSlgc+OKR3THVOurIuSJo5W9TYomd635dtJyfrCgtCd20VRp/thYNAREOhWt+7ZbFnO2Xnc/b2Lb7BPnNe3HJwmTKJQEADTGCp6H3s8aeFEgfAU+2PPZi0GNdFGzD8cdh5ZSgK/hPEtVGS0rPjnr+uSsd2tY7rVvedpnSnLse9rpDi6LczFuaMp3jd/FxU3vWzrfFJGQm+pOqyEpQIpCj2VEuWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3U5s740QRGJwSCV1Zh981XJGM/8BKYSnsV81LxfTdmY=;
 b=Y0uO0wmvHQdvO96FdZLlz0XhsaG4f53VCudTgcn9VbjkUM/R8wOgJWnMpuD8PviR376kmSQ3ZTwenCcNZMFe8UvEHtoxVYZFMojZfh5jQ/49hCT4a/5dB6WQXICDc1MzwQ0QGnFN2FSNnr3y/Vj7cUcCKF9njoqnFFuHyuKmoDq+GmmquP1G2/2SfWdvTfmPWxqEQhu3em9rimwHwV0RCRVu8GuzQn9Qc+2dztISBk+Jsojb5rA38Hp1fV/gMpscG2sEyGs09SfgU556BE1TEQuHaRILOaTcLKD643mBj7Ret5B0oy68enrivbyWSqR3g+kQ+NgJeU5rpxOf1kMv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3U5s740QRGJwSCV1Zh981XJGM/8BKYSnsV81LxfTdmY=;
 b=n8Z8Syyk/vPxegdFeGL6DO8D8AKyD6PTl3O4BDHexYllTFunkjVv3xxWo5KccMDiwe1RHGMFk1OI3vsXSdmhYCEZtsrW2CpmdTdE/fEjkrFSkU22YZ0D8nNC3MbHhA6ZXhN+GSviyW+WeLsPWqhjGQQK6R8a9Kwoq7396DzEH5WE02RZtSszRbAzQQWhuBNQq48MO1kOMvAl/ymtBz/AdMZGf/Wr+09nqsFWypaLd9dSwkC5hHjv0qypj0hjlY5x/p85WN/hTxAiRA1vcTj9Ihu7ZSR+IyRfX5RE+d+V4L45P5iDF+g1hOabM/Isc0ESJVg7j/tM2A15NFTuFkp3JA==
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com (2603:10a6:208:f4::27)
 by AS4PR02MB8382.eurprd02.prod.outlook.com (2603:10a6:20b:519::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 02:13:25 +0000
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf]) by AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 02:13:25 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: Git <git@vger.kernel.org>
Subject: Re: AI Textconv filter misconfiguration on Windows leads to silent
 corruption of diff output (ongoing investigation)
Thread-Topic: AI Textconv filter misconfiguration on Windows leads to silent
 corruption of diff output (ongoing investigation)
Thread-Index: AQHdKSpeW10CNT+9OEuLP9VqvpTkMLaYG2wM
Date: Tue, 11 Aug 2026 02:13:25 +0000
Message-ID:
 <AM0PR02MB445083767BAE669D4656CA6CB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
References:
 <AM0PR02MB445096594555DAD1D9EE1505B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
In-Reply-To:
 <AM0PR02MB445096594555DAD1D9EE1505B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB4450:EE_|AS4PR02MB8382:EE_
x-ms-office365-filtering-correlation-id: cfd6a396-46e8-4224-c07a-08def74e205a
x-ms-exchange-slblob-mailprops:
 /OoUGmN/RpWGTxMtatzpld+Cz2zns/tXxKmxbkwepqKRCS9Wxng6lQ6RxtiZcm1h33jGSd1DAVV+Ouur11AhzzXV+D7Y2FtRK+MwqYo/t17RWVpUfM+BqG13TRXDekBojjdyiM5/PmBOT40WwTGd3s5hRQYKdBsLG/bEZKckOF9tgYHqLJWuoQDaX6hton/79ESbOaQ9IO3w7tvd42sn635ZbqldP2iUwlENdTAveiyf5HTf0iDnZLj7TUP5A9PHqPpb+N2aX5aXz9d2LH694132utHYAJJtFPx1NGUVi/zZcbvOeytk/KaNwlwmdH1Q8FHDO5s/Z2/DiQALbwSZPyaZqohDdDtMnH+5iEJHkkaumB3BNcQOhVu47YPDlfO971+fccYMTft0N99NWR87J4/KENXVSdp2NEnMwfS27x078/4eX1X+ilHv2GCW5S5PofV3MwE5WwvbHdAKF197HnI+7iOfnfmOxkOOK+6IYyul1KR6xk0//78OR98qLbZo50O0EDppaDA8xYviWHuQ+n1cRG5BcmW/2Ri/b01mevMJLh1k1rHFDgRxMj4umsS6yEk5yctz4unWCEfEI4Lpk9+3uRr1PtzmN7/znbRBrLQ3DgpYKr/q5ebRUCA8uM0IDSR/5aTclW/06mr5wA9k24wrAdbY3q0cleT3K6xK99ivodpeySSFLE3NYxXLgQi63Dy+OP7rxm/fF6lLkilhfhgLNKVKpZkx+I8ifTcyGcNy8uHyTCZpO+XHm7y4ImeP
x-microsoft-antispam:
 BCL:0;ARA:14566002|24021099003|55001999006|41001999006|8062599012|8060799015|19110799012|31061999003|37011999003|15030799006|51005399006|15080799012|25010399006|40105399003|2607281247196008|31101999003|102099032|440099028|3412199025|26104999009;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?Tm8xOFZjZ2wzU0hQc2RQeXEzbWVkbmQ5NU4vQ1ZDRUpaRnI3eFdLSXZT?=
 =?iso-2022-jp?B?ZlRrVUVHM2VCNDB2VjduMjIvUzZ4NjlOazhWRnZ1TGVBcHlUNkM3NGJp?=
 =?iso-2022-jp?B?QWVaWkF0eGhybUw0ZGFVUzhVVVM3ai8zUExXVUdWNmtlZVZtMWsrVndD?=
 =?iso-2022-jp?B?R2RldmprWkR4b3F5ZytKOFFvbS9aU3ZuNTkzUFhlS1d1MnVDSzRpdEpw?=
 =?iso-2022-jp?B?c1NxeEsyb2RNSFI0Nzg3NlVNYm95OVpOVG81eWNWRE84UWtFTytPejE1?=
 =?iso-2022-jp?B?ay9WcWNLQTlIQXdPbzcrUTZRV2pWajVITmhlMEU4RGlqRzJ1MnR6WDk1?=
 =?iso-2022-jp?B?RDRqZndPZm9nWTc3aGxwZUp6aFVvQThvTG5IdGRRbEF0anNVVE9IbEp1?=
 =?iso-2022-jp?B?cGFwTlcvVmNkSmRaZGFBVVFIdVdvMVR3MWgrT0RkVThkeHpIM2J5R2FF?=
 =?iso-2022-jp?B?WlZtMnQzb0dwM1RMU21QOFZYWWR6SFRkR1hOdytHdlNhZWVvSjljZWor?=
 =?iso-2022-jp?B?UWtuV3F2QnFJQi9pNDZBUmNWODRYRHpBUHR3OXY3UElhNVVhMjZNRkF0?=
 =?iso-2022-jp?B?UTlXbkVCMDhkQjMrVGllV3Y3TVpXb0c4MW1MMHRndDZWVzRYdG95VE9F?=
 =?iso-2022-jp?B?aFk3c1JlVyt3LzdyWG1zMHZ1QStWNFFDZ3A2OFNEMTl2QktzL0NKY1hw?=
 =?iso-2022-jp?B?YVd6MldqUDZvOTlwR0U4MDk1VFFzblI0NHQ3Z1p0US83aC9XZVdxeTRK?=
 =?iso-2022-jp?B?aStRaElMYzBpWFNtcWFJZVJrZTBHbUEvMytTYVhTR1BKR1hSQ3c0d21i?=
 =?iso-2022-jp?B?SGl5YW5Dc2ZiblhITjJmeG5hMC9oTjVjTUpONEhTTTh4dWMxOXpxc2R5?=
 =?iso-2022-jp?B?b2VDSVRQM0N2RU5TM2s4Rm13MkdtdkkwQ0ZrS25IdVVHcTlqbTlSS3ZC?=
 =?iso-2022-jp?B?MkJIdUR1dWtPREdMRjdmU016R25EWlFVbG5IZmJmSXN0U3g1NDA5ZTJa?=
 =?iso-2022-jp?B?RXVxVUlDQ2MwQkRLeERyK2NUZEgraGdBQ3FUSjVrcDhwOHJ1SzVRWjA4?=
 =?iso-2022-jp?B?WXJGWWNYRGJQVWg3RXh5eU9lbGhaVVl2VVpXaUN5L0JkTGxRRWFRWit4?=
 =?iso-2022-jp?B?RGQvQ0puQUo1ZWppU1NBZDE5aHlnRnVxcS9EaUgvaERIMC9acEpWWmpB?=
 =?iso-2022-jp?B?eUZ2OS82OGpyZ2p0bWkzNGE5Wk9wYkpTeFNtZHM3RDh0U25iSEYrZXlU?=
 =?iso-2022-jp?B?QWxwcGNPV2JUVWtNbGRvSFRXZStRWjhmQmx6ZVB6eFNTdzhCM3BqMk1P?=
 =?iso-2022-jp?B?Q0p1MVBSblJCdDVqZlpsYUFsV2c4RmdPMFlKRHQ1RWJQNERMdi95ZSsy?=
 =?iso-2022-jp?B?U21EOTBRTHc3TXBVcVBrWHhqamIyalJpeUt0cExJT3MvL29MTWVoM1NP?=
 =?iso-2022-jp?B?b2ZSQTNIWWZjUDlEREdabkwzeHp4VmNyelpWMGZCaG11dktNNFAyNFY1?=
 =?iso-2022-jp?B?dHJXUFdQYXMyczVIRHpydXFGRFJLbzZ3S3FIZnBvZEVLckIxMHAzN0tw?=
 =?iso-2022-jp?B?K3pNMVN3elVtZXZzOE9MS0E3ZGYwYlRxZVlxcFRIaDVKayt4RTFZPQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?aWZsNWZGOHk0dHp5dWJnUU1KL2tTN2dZeExKZmhWSlFlRjlmaEc2Z1pT?=
 =?iso-2022-jp?B?aTNRRVJLK3hESmNOYVVaYmF2L3hFMTdWV2pLNnVFRTEzOTBpb0dwRjJY?=
 =?iso-2022-jp?B?bzFOWGh4R2o1ZUdNcUwzdWcybVBJSkxkYXVEVXMzNnR1MWJoZks5SGdP?=
 =?iso-2022-jp?B?WUpzc0hZc0tpaVkyYmJEbnNtR2JUcTNpbXJ3THUxaTJOeVYxRkRHclQr?=
 =?iso-2022-jp?B?SWpuU2h3LzVyVnRqT29IZ3M0MllnTHo2WWRJQjBVSEo5Tk5HcnRpK3Rt?=
 =?iso-2022-jp?B?eFhUeWhMZlhMbGNHRG9DRmhjY3M4azJnaC9ncURRNnF4d0x5RW4zS3gy?=
 =?iso-2022-jp?B?TlJVQkhnNDY1MExseWhja0lrWUIzRDlSblVBQ0JoMkhIa3JMcDhVTjlh?=
 =?iso-2022-jp?B?bytHTCttOWsya1hON3ZLd0d5SU00VFBOYm5tcEJlWEw4cElyb0c1NVpN?=
 =?iso-2022-jp?B?VUdWLzY4SnVCNHJZVEtVRzBCU3J0MDU5b2Q4eDFJcmszOWREKzZZOXJY?=
 =?iso-2022-jp?B?MWRNeUNXN1o2S1VXNHNYZEhvTWhLbitMUWUwRWVzMnA5Y2ZLaTFSOC9w?=
 =?iso-2022-jp?B?aGpHWnpnY1B2eFBoOE1Ba1ZaV0FTTzQzd3RuaGZ4UTNRWnhXeXBzL2d4?=
 =?iso-2022-jp?B?M3dFZ2JYajEyNWRxajZwQ3NZMEhza2dySytpWm9UeTBsOU1VUDdNcmNV?=
 =?iso-2022-jp?B?WXpiRWphWDhPSFh2TVhGc0pGYWdOOVZPdElIY1VhL0xmUHYzY2NnYmlt?=
 =?iso-2022-jp?B?Y3ZiMnU4S0xsS1F5emJaZFRRQmdKajYzcFROZVpaRy96V0tMazhNdCsy?=
 =?iso-2022-jp?B?d1NIZ3RrL3Q5T0R2dkxwUGJPOEpZcnNHb0tESjd1OGFHaVhuRldGaUVO?=
 =?iso-2022-jp?B?M0s5SkVtSHFVS252MElZWStzUVBTK3JqaFk3OHFYSS9peU03WmQ0Q080?=
 =?iso-2022-jp?B?VXVMUVd0R3BkUXVKZG5CWnU4djRrNWZzNytDVWFFdFYrR3M5aHllNWJC?=
 =?iso-2022-jp?B?clJTWTdxRlZDV1FTVkhmd05uQ0xKeitkK1hPNlVHc1dnc21aRktqN3VY?=
 =?iso-2022-jp?B?NW9qV3o2eThjdUhQTFo2Z1VpaVhrY1VNTkRDc3VvZmEzZTI5OWNpUkcw?=
 =?iso-2022-jp?B?QU1CamNPU1MyS1FUeVdNaHlUdjVzUjcxQ3A0NEZOVXMwZ0dnc2V0OGM4?=
 =?iso-2022-jp?B?WC9wMlp3bTNla0pzNmNXQ3pWcVQzUkZXV3FyVlpBVW1iS0N0ZEdpS0x2?=
 =?iso-2022-jp?B?dUZOZlpGdGlQaWQ3L2F6dVQxMTc5MW92VkFVMFdrMHZCRVIrY3NuVnR0?=
 =?iso-2022-jp?B?K0dRbUxISWF4SzEwT1Z0blJ1ZlkyZ2VmdUN0ZnhwUWFEeW5RZlh6M0hq?=
 =?iso-2022-jp?B?RGswY2ZSdHk1bStyVHUweU5jMVQvT2JBS0xyditRUnplRGtVbE56Z3lR?=
 =?iso-2022-jp?B?Y015SlJ1ZnA3UDlRR0p2Uko0dEhDZU1ZelVpQ0NVVUJPZy9hL3ZDK2JY?=
 =?iso-2022-jp?B?U0RpQ2tndy9HV2JubVBlc2dobWZYZ3R0QXRkUWZPeVVYcGRCdy9GelZi?=
 =?iso-2022-jp?B?SGtVejAvZUFkK2ladmRtNEM3c3FSZjhlL3UzVE1peTMra1VVMUtUTjAv?=
 =?iso-2022-jp?B?M2hwTFY3amNiNm9MRXBqN2t3VHYxaHNYaEg3MlRFd3ZhekxkVXJJRnM1?=
 =?iso-2022-jp?B?YStSdVNDeUc5Y1FVVGluR1RCQlg0L2VhMWdIY29sQm0wb0kzeE8zL3p0?=
 =?iso-2022-jp?B?L1VEdkZqM2pnNWszSGVGNUdNa2N1dHQ0SFN4T29CcHd3M3VLZzBvTEZK?=
 =?iso-2022-jp?B?bklkK0NiS0h5MWZtM1BvTUtnUXcxdmdUUG9Fc3d5SXpuRDJuakdDaUJO?=
 =?iso-2022-jp?B?TmpIeDYva3dTL2JnVTFnOFFSRzFaTDlncE9LdU5ERUhuUTFxanp5VnhT?=
 =?iso-2022-jp?B?eE85MkFQWHU2Z0Jld0RFeFdEdmJmTitJZ0VGcXVXT1hPQ2cyWHNqdTFB?=
 =?iso-2022-jp?B?UEFHMzY3MHZhSTJiQVFhNVliUmJxVDE2Mmppd2dwWnpuM1NCclhJTmVO?=
 =?iso-2022-jp?B?RjhteXVYZUQ0Wm5CWTNQZU5FM0ljS1I1KzljaGc1bWpkL2hObHZodEUw?=
 =?iso-2022-jp?B?Sis=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-9f624.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4450.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cfd6a396-46e8-4224-c07a-08def74e205a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 02:13:25.5293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8382

I confronted Co-Pilot with it, according to Co-Pilot you will like this sho=
rter report better, more to the point:=0A=
=0A=
Hi,=0A=
=0A=
I encountered an issue on Windows where a textconv filter intended to strip=
=0A=
carriage returns ends up corrupting diff output by removing literal 'r'=0A=
characters.=0A=
=0A=
Configuration:=0A=
=0A=
    [diff "lfclean"]=0A=
        textconv =3D sed -e s/\r//=0A=
    *.go diff=3Dlfclean=0A=
=0A=
Environment:=0A=
- Windows 10=0A=
- Git for Windows (2.x)=0A=
- sed from Git for Windows: usr/bin/sed.exe=0A=
=0A=
Problem:=0A=
Running `git diff` on Go source files shows corrupted identifiers:=0A=
    compareCache =1B$B"*=1B(B compaeCache=0A=
    return =1B$B"*=1B(B eturn=0A=
    for =1B$B"*=1B(B fo=0A=
    cacheReader =1B$B"*=1B(B cacheReade=0A=
etc.=0A=
=0A=
The repository content is correct:=0A=
- `git diff --no-textconv` shows correct diffs.=0A=
- `git show <commit>:<file>` shows correct content.=0A=
=0A=
Reproduction outside Git:=0A=
=0A=
    echo compareCache | C:\Tools\Git\usr\bin\sed.exe -e s/\r//=0A=
=0A=
Output:=0A=
=0A=
    compaeCache=0A=
=0A=
So sed removes literal 'r' instead of carriage returns. It appears that on=
=0A=
Windows, the backslash in `\r` is not preserved through MSYS argument parsi=
ng,=0A=
effectively turning the expression into `s/r//`.=0A=
=0A=
Impact:=0A=
- Diff output becomes misleading/corrupted.=0A=
- No warning is emitted.=0A=
- The issue is silent and difficult to diagnose.=0A=
=0A=
Suggestion:=0A=
- Consider documenting that sed-based textconv filters using backslash esca=
pes=0A=
  are unsafe on Windows.=0A=
- Possibly warn when textconv commands contain `\r` on Windows.=0A=
- A built-in CR-stripping textconv filter would avoid these pitfalls.=0A=
=0A=
Thanks,=0A=
  Skybuck Flying=0A=
=0A=
=0A=
