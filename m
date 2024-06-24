Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2127.outbound.protection.outlook.com [40.107.244.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B119AD67
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239892; cv=fail; b=u2zmH8kQLy1wDyYU+2z70pTtrnOcbMtpcAmVoBTHwUA9eCw7Mb9VrrD9XbELlNbcR7A6rAPQHVgfoteCwOhaMaADF8tpooeu6mLbol5+xoThEivbv83JKPzB9bO1Wf4La7vkySF9yOkOo4lGpne+7ee1Rew+MFyZuDusu2VFmYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239892; c=relaxed/simple;
	bh=5CHH/pZdBFsWCmBBlH//JgEv2Bhcg8DC0HYGSrCzxoE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IIHyn3F3P152CQh/J1qnHN+m56DiS4OIBjtVtjKoxHmL7vRr4wwzlt3WlExhjjWptWYTBJnSOxL7rHZg9jRQoa1cADb0NBxnjBAT7cXWEqM1ZI1YjmXOUrytOSNRWmefduwmg49+hymP7HDb+oaFybFM7IE3L7kU+XhfrjmPLns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca; spf=none smtp.mailfrom=nexbridge.ca; dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b=PaqumzAf; arc=fail smtp.client-ip=40.107.244.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b="PaqumzAf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DMYzu8Qvdhve8dl/V8a/9CyM6UJGR/B2qEHXenvStQHXVk4GfK830j1CnSt041XR+BC/U05f7mr0Cc79rhw8axCTgSfJ7VZ55ooby4MDXJOT1vMPxjX6RYF1cMOSgK4/yCIkgPEf3V4JbTmA1FGZzteuKzbPLfwfUDBE8JuPlH/osPtNC+L3SMemOLEPHkqKYXeLvICqWRrsahDnjdYSu4g1ZbNbsaXT8sNES3XhlOp1pVgmoO6x+A4PbA/KheZ9zO30cqvskZbCJgTBi+SSkrheKNVV54hjml0PinMm8HqrcaVcRvI68nOdge1KdnP3bqKBFRIMkPDYRnu453Nt7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nplcytlHopNKpPwHvb94gpBR5aRPiKA9r4BuY+C9Y9I=;
 b=j/s1etTlv6Ddxgpil1v+fIab3KECZ0J/vCyOCX47N/vrj448OjLj/SkUEZsxsF12bJb3cqkW4ADDpfdEH9uQcoZK2yJolKAKQTBVrPNw19OI6Qttd1apszEjsPWjTwNwoyxww3anjyHnYzZ0w4QJHxFEpO9bR01ShXYYbLGbjz2xrgXPke+g/S9JT2zO1OaRXwqBbgLZO3DcUB2TrFnfkRQoQvsWg3P+wtd5YtkQ3MpCnYLT3u+fhCsTfzeX6qoePClxi/r5ngb3yoUQcB+psT0JcnlJOcLTLbYbQOPcxJHI36Klt3eN6qw4c1bNtG+f9m0zDcenUBeAcqaC+YBtXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nplcytlHopNKpPwHvb94gpBR5aRPiKA9r4BuY+C9Y9I=;
 b=PaqumzAf6wScklWuciBdslXaAYvGhlGTx7hWWjaIQS7GAcN4Y2WhyunFJzHhiqOFg8ZWavcULUhD91uUawM91DSZ8UAtmjxSnJu1fksS33kcoua2IN0cOu5Sum1Fh7r/LCbb20zgSqmCLjzcsswFkQfBhXObCICV/IEge/ug4XU=
Received: from DS0PR17MB6031.namprd17.prod.outlook.com (2603:10b6:8:cd::20) by
 CO6PR17MB4915.namprd17.prod.outlook.com (2603:10b6:5:359::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.30; Mon, 24 Jun 2024 14:38:08 +0000
Received: from DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167]) by DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167%5]) with mapi id 15.20.7698.017; Mon, 24 Jun 2024
 14:38:08 +0000
From: Randall Becker <randall.becker@nexbridge.ca>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>, "Randall S. Becker"
	<the.n.e.key@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, "Randall S . Becker"
	<rsbecker@nexbridge.com>
Subject: RE: [PATCH v2 2/2] Teach git version --build-options about zlib
 versions.
Thread-Topic: [PATCH v2 2/2] Teach git version --build-options about zlib
 versions.
Thread-Index: AQHaxkEOQNNXjGXhfEu8oPtEokiJvLHW+qHA
Date: Mon, 24 Jun 2024 14:38:08 +0000
Message-ID:
 <DS0PR17MB60311800BF14CC1C5C7E707FF4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
 <20240621180947.64419-3-randall.becker@nexbridge.ca>
 <80112f79-f2ec-28ff-3ced-9df9d7ea87f0@gmx.de>
In-Reply-To: <80112f79-f2ec-28ff-3ced-9df9d7ea87f0@gmx.de>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nexbridge.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR17MB6031:EE_|CO6PR17MB4915:EE_
x-ms-office365-filtering-correlation-id: e07ea94e-5dbf-4940-4fdd-08dc945b43f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/SGfRVO/wILQqe3TtgGn7n3oEXK3aP9DCzdt/MPbNWsv9HWQnyzmAfC1v/AS?=
 =?us-ascii?Q?F2/ovl8cPOcXyNdytfGvm7F4GY2nN9XUlc2htcM+F7NZj/xbmx3nUcPIE1+h?=
 =?us-ascii?Q?SkOpzNVBqeTpX/EvY3RcyCOh912Mn6WtZjuW5xWyL6WSPu/lA3uRD9IHW08m?=
 =?us-ascii?Q?rLn+nwIGsYvBRb6plKyq1nUIkIfck7ZuhnpI6ujdo8xIzNtYW5UI8N0oAvQX?=
 =?us-ascii?Q?B5vHpsdH5s9982GrQd8Ox2krogHWmXusNbi25gBSX13bkiJE3nZ8zOcZ3roq?=
 =?us-ascii?Q?IVkEqmOYWyGWYgb6L5NWQKZcHm6fz/5g8QeDHZjWYHj6JmfxqTb8vK1P9mey?=
 =?us-ascii?Q?Di2chbxJKVubv+jFGaDiX/wlpt2L5oMadThFK6b3Mev2mzaR38kCb1SMd3vF?=
 =?us-ascii?Q?NPbPBse6Sbs3fws/5Q9embiiexcliDIDuRYfMGgrnbsWv5+Botb+9orWwC81?=
 =?us-ascii?Q?57sRpdO/eE8dlwoMpC6FmR3UeDeSzcvdvgdk1+9O5TUcR4T+im+DzZiVoajf?=
 =?us-ascii?Q?2HE7HjZYD2xU2Hvw8XvJ9mFcEE62QeZE49ZLJQagbO68u7fgpBGXqr4se6Jy?=
 =?us-ascii?Q?Rqr9EWeSCfoTk4Au7/KljnfqkN04mJbc3riql77lKIVpgUGXN0UDmIFwPonQ?=
 =?us-ascii?Q?QBipr9ajF1lJTA2lGqPTNdH7rI+FfZC5lG/YqNDIIIllfEbbsyFJRTMaHmNl?=
 =?us-ascii?Q?8b6bLI2mytuesUAoMDKbP6CnZ+zsmwYMqI8cFOiqUv3oRpMsF3TXfmNUJYuu?=
 =?us-ascii?Q?3bv2XFBchdAtbBSF+gpoRHtMyjBK0sLZU0XXJUN79RGk8zmzqOFRWFuR2YfG?=
 =?us-ascii?Q?mSztkjm0i8x7g9PTp9ThAdDvd+wtCwQvZpAn6kAscfQMmgsKfL89phiaFbsW?=
 =?us-ascii?Q?mMbPojE/yLeLYaPMqo9uS3Sjat/CQWiQW8fIbltKr2dC2KCQrtohDRTjby5Q?=
 =?us-ascii?Q?A8v76TSDsjNhdm0HT8ajPf8iH3CBJY9YmXYIwa2LLAw8HSXF2DFFCwmr0L8h?=
 =?us-ascii?Q?c9U2exCpavoDQeupvIAV87Sizna2szdpibc4eZpr15K062fV3LisPm3d3rDU?=
 =?us-ascii?Q?1xM+57JYYpnIPwvjbtUW6bw3jJbuujhqyoAwMuy4E7F9NK5SzdEtvtEn6rWz?=
 =?us-ascii?Q?qinZxR5KxdZDdw3O01z/j3q+2DN6H+66vEQnnkVTscWDt6+mn+3f4fzyBSie?=
 =?us-ascii?Q?807EDCmSsVIRgTx9UXasBJRpgse427OvpKR60/r272xRMe7BJxTb541f4+Sb?=
 =?us-ascii?Q?ZKpz7Lvgsstc63tyzaACBSIIGKzIMPnBh9Njg5m0Yu9ue/T1eMynVe9hsd0C?=
 =?us-ascii?Q?Pg4ZoS2nsb9VsAV+CEHR1VfC/l6k8XjL1Gf4z6RvLb56RDxnkVOE5qGK41EI?=
 =?us-ascii?Q?YoLAQGI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR17MB6031.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1JZmw9e8a0MLJou8DQChdc6VC9x+VzohUPAbRsZeJnCgVWQ+aqYNh7r5Qhp0?=
 =?us-ascii?Q?HI7sDkCxonxboxdn/xJY8KotyunO30Kz2N7JntIW6xIFACdek1tlWcNIdb/J?=
 =?us-ascii?Q?docgkB/+TvH1dLIw21pV9o7J/J7S3yJ0qRsehFzBdTUlgC4k75FfTU7bWeoc?=
 =?us-ascii?Q?rWfIJNX7RQs65Yc7+ZAGPKQr0k+z52j84CwXQPKtELBAHddC0UN6DHOEWfUQ?=
 =?us-ascii?Q?Uq9kjnVmqp8hhl/h5YL7nZZfzQw8URI7ZaZPNt9/E73PShcFjQ2vShQKlfV9?=
 =?us-ascii?Q?UKV9+9D9XMsO5Hh3i0mhVqpscweh/3Du2EZFx7B8a8FC95wXZBZchxwqk8WG?=
 =?us-ascii?Q?P0nhreig+HAwZnWh3wEoEACgXoNRTdNP1F894F9o2FlKWZhE8qirv+r8EA5i?=
 =?us-ascii?Q?Qn60Az+BnZUO+uLq9UfwB38DkapafKVv6s0Bvqlvn1ymWi26dkd5L5ZtN4pJ?=
 =?us-ascii?Q?LSkSBSmhiGUg6q3UhEUgQrrzdQfHXhPmKki7wZyL7r6hSzFU3hZhKW/yb/LB?=
 =?us-ascii?Q?rSx13uQGFHJJM5du7Xa+Tx9VQmzOKkFkACGi6uHyaAw8cDhysZ1R+7YuuFZG?=
 =?us-ascii?Q?+sYWTu1jPFydOyIvBz7XzEe4FwpKGrg5h725zHdmxudHdsGqaWvaMaWyFzHA?=
 =?us-ascii?Q?6dJmNh8KGYgdfu3Ak7xV8gce10zsNIhZKERfasCaM83e0wjwlihgzLyY7cF0?=
 =?us-ascii?Q?kQmslIiXdQ0XvqrnNDqEsSONn14ybihT0mWKYb0w6xYmeOi+LiNYO+HVe2eF?=
 =?us-ascii?Q?rBJs79Wc9bRyIcB8xYBacxdLE4HywWxW3gJXlegN4vvxOitSE+BZCBgxul0Y?=
 =?us-ascii?Q?/3yZk9DMQ3ohgzQysvyTuVUXlXgQcPPR6xgX4li+ECFAmlOV1Uo0f/emCibO?=
 =?us-ascii?Q?5VFaVfi+tM+CdjECSrZiSsw1pYtYE7AnocTjw0S1eOylqS/AYPKCFh5PY2bO?=
 =?us-ascii?Q?SZSzl06ktU5tdvDVqXBInzhtvtGwt2R1t8gAQVbVbP59k/+M7dWFQr/L/2uu?=
 =?us-ascii?Q?rdQ+q76LAPz8POTblzBnQV8ujdMJ1MQ739TY0rkvl/Ojy4be3/QXjnGQV8vc?=
 =?us-ascii?Q?hDfKk47Plg16i8GjsnCee3G6lVERQTgSul+i+slUFU+Jy1i88U1Wf/EsrVKf?=
 =?us-ascii?Q?oxoHgPSGnTDlfDgCtPyETuGgZ40UhfuVlo3100hxgrxGVYSQMZoHfapzJePt?=
 =?us-ascii?Q?gzxf6uNIZNNYvb6MG1KbrxDCfEBuT1TjFleTVvIeNANFlJ2OXoB2U3/gOmbm?=
 =?us-ascii?Q?v/XtxmNyMj3ukcBTzm8Ep81hxdLCrI1q8487N6amvrOtdtQl0YSMwENPRWXH?=
 =?us-ascii?Q?V29akfYW2tJVsvLCPFvnBIAt6+GVYKkB2fphG2aDQsKoNrZh289JCMc73XUy?=
 =?us-ascii?Q?/no8cygFMwEx1Lat0mZFr2Gr7Wd6GFoV+z0J7NLiX0ZxYNbRr7yROMxGmWf2?=
 =?us-ascii?Q?RvJ8Kj3AFTEUwCHFo36ogxEaQ2iX0HP0Pztv7YKkYbTmUJFf2laOY7AmtXHc?=
 =?us-ascii?Q?gu412n3HT3N/n2Z+nUqBOWZTF3pcYpu7+IGfN5vYuVelp4pR4ujbGr3n72fZ?=
 =?us-ascii?Q?CinH4jA+HiGG8ct+NWqZGPHqKT56jn0/7E1RnWGOmWJ4ATcj4V9pzkvmoUvS?=
 =?us-ascii?Q?z15eLfqdH3aiNAzg1mpsaACoJpVKaoxxZHhKxt5YT9oxZBEPvuMtqD54P2Bt?=
 =?us-ascii?Q?mu4Wag=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e07ea94e-5dbf-4940-4fdd-08dc945b43f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 14:38:08.2762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j6fWVdLjpMmxBWndDsEdWM1g2sI0ZC/J8oHVXZ9eCId8NFc/7euchlsSJqu+e+44DNLXYOv88N6q8jjdT1xzEhhtrCKhnWiL4YBAhZVON7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR17MB4915

On Monday, June 24, 2024 10:16 AM, Johannes Schindelin wrote:
>On Fri, 21 Jun 2024, Randall S. Becker wrote:
>
>> This change uses the zlib ZLIB_VERSION #define text macro. No
>> stringification is required for the variable's use. If the #define is
>> not present, that version is not reported.
>>
>> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> ---
>>  help.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/help.c b/help.c
>> index bf74e935b9..f378750af4 100644
>> --- a/help.c
>> +++ b/help.c
>> @@ -760,6 +760,9 @@ void get_version_info(struct strbuf *buf, int
>show_build_options)
>>  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");  #if
>defined
>> LIBCURL_VERSION
>>  		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
>> +#endif
>> +#if defined ZLIB_VERSION
>> +		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
>
>This reports what zlib version Git was linked against, at compile time.
>That may be misleading e.g. when running with a different version that has=
 a bug.
>Would `zlibVersion()` be more useful here?

Please see my comments on the libcurl sub-thread. Same logic applies here.

>
>Ciao,
>Johannes
>
>>  #endif
>>  	}
>>  }
>> --
>> 2.43.0
