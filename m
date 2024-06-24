Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2121.outbound.protection.outlook.com [40.107.223.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32790135A4B
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 21:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266197; cv=fail; b=clIrnUEUHJYnqTXkEzL21ArI/8BWvReeqomxf1DOhBnukiTIQxrLaY0HzEKGSRmDCKG2FUpDx/hFnYkLu/84tQe61EipDefRiRC10lJfUPWD0Bp2Wa0InjYPtz0fQgoa1LxK7SW62JBnW8OcP4QK4btuVEac23+5GXct+p0mLO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266197; c=relaxed/simple;
	bh=gpLmqO2fbrrF+rSs2cLs0wqimg36Jq0GEHqy8Gc/vl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DrtbD49FDLFmVDCgKvX2AXHknmhR5TNCckVp3uihoAxFzfF1roiAKUPZHqlQtiwtOpbAnpm3KIWEn0nXLyqaTYioSa5957cx87yjEVU7lGS4qO//WR1kQkGoBEdOODlSQdbTYF3G2P1hScg1m2Hv+GaqlCrpwk3/8GePWGzN93U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca; spf=none smtp.mailfrom=nexbridge.ca; dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b=M8UJNM5R; arc=fail smtp.client-ip=40.107.223.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b="M8UJNM5R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieg6ygGpU+XTX0exSLV1rbkMF57u/zawt6id6QsbNvj4UsaT6xyQC7cDzH1aD8CxoG3lCieScjlqzyywYhfNyOAL7T6cXzodo2WYUiRelirGCz4vY6yLs1d6PzeicPL2oVzj6v7Kum+x6igGpc0gUpA257YVHt445J0Aue7U/pdFMIjYynax77qnmUFxQ5wG+4tjAVChVoRe3VpsOocLFADni9jn2iCf/zhuJrqcAdxJS0HsR2/nT/H2Rwj6ZmHN0B0rJMXZT/LM7dDtxMsiyFTbI7MQ+Sez0YNbFFQXDFyeoeUzHvA2ooveciW1ObahI82rGoxiWHN3/0ZMBf0nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IH60vBBjmLry9UjO8QxlzGc/sFGghKdb2PBZFZYMLU=;
 b=koQCZQT8zozqzt88+M9f//YsZrETtz8rvEdQ9CzSTwULW4eZ/2YH9xngTWY4Gw0QiZA3SP4fVqU8SrVNsmevr4iZKavwEVXk91ZiJBjyFKp+Y7tbywStz/LJEZaU/c7FtlUpmbOt8ZgE1VEBzciWbkm6Zdm+mMdKL2UKtSGNYH1CnPRAJwbDy2aM3V/OHpd5o8gsPDS8ID6z/Gf4b8vSvTooLVe2Rg73W9bvKYP8d8o1pMtb17tuOM+B+CX1kEvwJaxp4HD8BZlH9iVJIuZUFBdanV9V1XzUIHchJ78rCsA9NXYs/bFIrOVU/rMT+SKeLpPZb1A1HJe5vW802IBbsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IH60vBBjmLry9UjO8QxlzGc/sFGghKdb2PBZFZYMLU=;
 b=M8UJNM5Rb9Bb3E6Bk3Qo3tsVXSmUrHttmZB3sENZAs9sSRn3W2bh455hj4wYOBjYnra9xLTrnd1ZSnNd+7nQr1OvpeV6H7cFifn9SXArOTL6hc29fwpy4kmV2j+4GdOIA55E5R+VrTXTpbcVjMGyjjAR1hbTqnv26RmBJqOdhLQ=
Received: from DS0PR17MB6031.namprd17.prod.outlook.com (2603:10b6:8:cd::20) by
 PH0PR17MB4655.namprd17.prod.outlook.com (2603:10b6:510:84::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.26; Mon, 24 Jun 2024 21:56:30 +0000
Received: from DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167]) by DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167%5]) with mapi id 15.20.7698.017; Mon, 24 Jun 2024
 21:56:30 +0000
From: Randall Becker <randall.becker@nexbridge.ca>
To: Dragan Simic <dsimic@manjaro.org>, "rsbecker@nexbridge.com"
	<rsbecker@nexbridge.com>
CC: 'Johannes Schindelin' <Johannes.Schindelin@gmx.de>, "'Randall S. Becker'"
	<the.n.e.key@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] Teach git version --build-options about libcurl
Thread-Topic: [PATCH v2 1/2] Teach git version --build-options about libcurl
Thread-Index: AQHaxkC1Q8lpHEETNk+PGGsbnZgMpbHW+LUAgAB8kBCAAADY4A==
Date: Mon, 24 Jun 2024 21:56:30 +0000
Message-ID:
 <DS0PR17MB60317A8F2654973F1C60F459F4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
 <20240621180947.64419-2-randall.becker@nexbridge.ca>
 <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
 <DS0PR17MB603115E943565C4281FBE199F4D42@DS0PR17MB6031.namprd17.prod.outlook.com>
 <5dc18b418f57cb8376b9fd9a5a4ad9d7@manjaro.org>
 <036d01dac67b$a6457da0$f2d078e0$@nexbridge.com>
 <cd0f4bee77c6afbc5deda43b339d22fe@manjaro.org>
In-Reply-To: <cd0f4bee77c6afbc5deda43b339d22fe@manjaro.org>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nexbridge.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR17MB6031:EE_|PH0PR17MB4655:EE_
x-ms-office365-filtering-correlation-id: 3f7834fa-4d6f-4326-4d4f-08dc94988137
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iFqOLquF/T/UyYYul3+5wck58rSHZRacbVAiyPTN7oPPGLw8l15SMLWnU/PW?=
 =?us-ascii?Q?7MioetMAzmeKkXqKjBpRyH6qBU8haWqyDQVVO1t4BPql1cmHKeqi+MN6mzDm?=
 =?us-ascii?Q?z1uoSzRx3a0l8D1fw11YstJne08faqKrRvE1FUTrUQEc+Owxf3HbazCs61DD?=
 =?us-ascii?Q?nR39zzuhPrLbkzoGtMSDPwo9QZzheawvU6ZBTgFrG9VbNKS3eIJ2UYls0XGA?=
 =?us-ascii?Q?E7Bx8qAEXql+eGOIxssTyitYVPYAE//4q64I6sTGQvj2J8l2GERkZSGI7PCI?=
 =?us-ascii?Q?AwTla8ytnbj+LoLBS2VHfPDs7Of2fjGDlTLgXXG5wvhA3GC6/2ceWS6StyNe?=
 =?us-ascii?Q?1t3a4dM11R2k57GoXesp0wYHUHh6RbVWO9Ysu9BGvhy14MJzvzvEXMsby9GO?=
 =?us-ascii?Q?2DXTqNO9ELv7klm1b4yAu77ZMG1Dv9rCwrzTdJLJIhowHv90V9Wjgwn7Lewl?=
 =?us-ascii?Q?aJdM5d7vR16DPfLLuzBYaZP88IWclHCaM1/J9iErKKVXsdEz6S/uaX5Bn5JE?=
 =?us-ascii?Q?0dw4JLANZR0V94L62JTEYR7qac/6CowXBt2ZNyGXgpjHm6MgqQ5MS0RTR5uO?=
 =?us-ascii?Q?CSJhNNHORcFDuowQmthglivJSS+MnStKhfHaqMHtVTYifXGRlD/RbbkOlX3a?=
 =?us-ascii?Q?OtVOTeX2OdHzl61xGB2MEt7b5RPcMKWHHcnzCQFeNvfKqYzxe6b01iT9Owh+?=
 =?us-ascii?Q?WlOc15og5UhUAm3aEQpIgsSBNjVRntLkv7DxDzsMXncpxygQiWLEOTv7vOQt?=
 =?us-ascii?Q?GPD+9uP45QsDQ0Lh2aInnvXTVamZ+zLTFC4Uov/sBer4E/QV3NRBbZTRzehp?=
 =?us-ascii?Q?2xIBOGmAMtUP1BAEo90/0AtXoUrsi3erZoXDnUTDptZ/jsgCLjRYSK5tvabK?=
 =?us-ascii?Q?rzsiGiKf4CuIqEOMVSLApJsFJ2TqnrHJOczyYoc3yTyMWRtKNoh/ItJkPeFw?=
 =?us-ascii?Q?aAT5EFp1gi1uqfkQpU/ZnIsvmoAQlTCferyUKx/TCSVD10qJK2whsHoMmSeE?=
 =?us-ascii?Q?4US+7g1rHUlop60WK3JhxuAxVBf7YIqw8GkRH3JB4xhwsugTzx4i1FwtTjAK?=
 =?us-ascii?Q?fqV35yv1ym24mB7eWGnqypZWx1shNKESsbAYXzfb8Wj0SurGgFfcu8mjT5xC?=
 =?us-ascii?Q?BT9Q3oEs65O8iyA/0kBBQsxjVtpNrol6e3hiKp4Jt5RjPiuRL3kUYROLqvaQ?=
 =?us-ascii?Q?8SfpeOsWz2fADlvBdDMNBHjgc20T2zKEO1l8IT+Ey91BnyH5a5YPcn+mHPxf?=
 =?us-ascii?Q?VF3MeMEodM0Jk3ecT7w1JrDkGqDAzdpYxVXvlqwyuq4p08Z1KsSyyAjt/v8R?=
 =?us-ascii?Q?K7Oua4Gl1AGpGj0CK8GeLeSbLCQgtgb2qRuLcImfYgiiuZTt+9I73cRsAiAN?=
 =?us-ascii?Q?hLosVkA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR17MB6031.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nGi/FOYsMhkJ9klIQ45e4w+Lfd+5ovKzYq5Swi0gsKHsJqJ8XQG74ScKaiIV?=
 =?us-ascii?Q?kYXtkz4Tg9+IN4w1GcHqlxfeB7NTSOO2u8tY1t7+zJFhTRKGrVxPDqXstizl?=
 =?us-ascii?Q?E4nops8GSjYsCjFo8E8TUI/1DihDVm3EE0b46oduL34g5FEhy7z9ON5XdEBA?=
 =?us-ascii?Q?5/aLvSwKrO181cL1yEyF1WSqyoxB51/cgJhOOrcTGh8euNQmeHEnq2dkHoEK?=
 =?us-ascii?Q?Fa4yhvI482JKcUVxauyDuQfMmaGLpcmxm82x2CaSoipNEatxZuHpN/BHeAfZ?=
 =?us-ascii?Q?0+EQHBTrelO13M4pyDeoQRVm0BtWkaJYQAHYQqX5k3ATlpnu9p3RiPWbr1EL?=
 =?us-ascii?Q?ATIzpOJF+C0VjkdYvsr2KQykySlcge/f4s9ZXHtMb7weGvhFVALAFMqm+68E?=
 =?us-ascii?Q?otWjMDW7sBuYgMYtfYWx1HJr+ZfmGemrETyzQlPGHue/g9bsJxaq4Sce4pb6?=
 =?us-ascii?Q?t5P2JkksVjCYGb9hFXhFcNrT11nFpVafHHPyF56Cv+nHE0eB4aHEr5sfzKts?=
 =?us-ascii?Q?LRluHY0Yun+jMQlTukJaObx/u7kQZcuAkpQmJ/4+rD1E5Qx8O003c3Q3GAfY?=
 =?us-ascii?Q?E5bu7kme1CACD8Y7iJP1fLOZeFvcNeZGX7sScwRt33ncfn+SQyaHl9gLB7KI?=
 =?us-ascii?Q?qDjafiZqr6LxhaARmF+6wHkXY1GuovanUo/gDjGJFahAyzXk1DNDRhZgKubm?=
 =?us-ascii?Q?GCNQNDUE2y2Tz6Rr7pek3Xyg5H3R73hglrWOOxV0GR5mlHK5PTOItxmdP5On?=
 =?us-ascii?Q?EXcAI2mds37Zx1LPNu5PzH+hiLaobKsSr5mZRi7s5UU0I77PPDgRf+FcOBfT?=
 =?us-ascii?Q?75SLs96hzNz47poQxt+n08xRe1oJiuZGd78aWwk/UrfI2vDZfW2FkYG6Ia+N?=
 =?us-ascii?Q?a+qyN25C5SjomvXdBLRykquMeQuOXYjniUCqfbF9Isib8Uj14ZdSw+NENkeh?=
 =?us-ascii?Q?VTCbsTDhAmlAyHP4Mm/dKDKDl5TG26xMfcb/B3IpWMgj7e+NYFTXF7U4xpwS?=
 =?us-ascii?Q?HdarxLtvNzNXBeGAN7oZAPLbfJTpMuhnTa4pwD0opr4mhsaBfxGah9s1wCqn?=
 =?us-ascii?Q?DCGvLr6RZGBZWZXKJ5CpS30Dnno0wYrVb1u3BQ5SScLHkYeFcBkl2fRkKZcy?=
 =?us-ascii?Q?Qmy4Nxx1kk8LXmcUx7nFFmkp5ZQgZmUXJrKAa5I7HqEWtS5IpOBHzjUiWQwZ?=
 =?us-ascii?Q?ADC/fOLvpCJ10QDokObYIPkMzsxfMDzEg5iPdexExYBHEoPX0Sl6zUCvVkTl?=
 =?us-ascii?Q?uEKf15olN1gR3ZEBItFTiEiBZInobq53nVFszlH+yOVwAZiDQ9QY+8CypuES?=
 =?us-ascii?Q?z5o2+lKsemrfobqp9BRhPukGAQPkFdYSm2j4PJXl/DJ9jqV/6UNRRfGy+mYN?=
 =?us-ascii?Q?lFxjYv6aUqxN0EJ7p1OBUmtN6OsV7EbFvHWjco9/KgxJUn8TmZ64ecJSDz2U?=
 =?us-ascii?Q?m3LLyNIoX5Toj2zAXmolTlIVcSa/CYvJn9MvLyeWdqplP5Txd4Ic9VY3qi4p?=
 =?us-ascii?Q?vfoDpMgeu6uYqwMy9UnwN9FpE/d10RiPPcwDZScA8mqVtuEE1afipCcGXjZP?=
 =?us-ascii?Q?bjiSGsethybZa5NhYj2ar+yVByCJAQ5EKGq+xoBKc1hRxLoB6peE+BsgOzQn?=
 =?us-ascii?Q?xJ4XmuiIbhz5uuimtLose2mjiKqTcT9oHbVL3J/bOwFz1UUijqYgnWVvW6zt?=
 =?us-ascii?Q?G6H6gg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7834fa-4d6f-4326-4d4f-08dc94988137
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 21:56:30.3458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vj3VlxiyIENv3sMI4ysgAjsplXdAUheK5reTiVfr5ZSAStfcaqGMtfLnR3E76EoBphnJFQm4sP2Kn+9iJRV9jEMZYcprs4ScwYjNWFHozI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4655

On Monday, June 24, 2024 5:53 PM, Dragan Simic wrote:
>On 2024-06-24 23:15, rsbecker@nexbridge.com wrote:
>> On Monday, June 24, 2024 1:09 PM, Dragan Simic wrote:
>>> On 2024-06-24 16:33, Randall Becker wrote:
>>>> On Monday, June 24, 2024 10:13 AM, Johannes Schindelin wrote:
>>>>> I am not sure that this is the most helpful information Git can
>>>>> provide:
>>>>> It reports the version against which Git was _compiled_, whereas
>>>>> the version it is _running against_ might be quite different.
>>>>>
>>>>> Wouldn't calling `curl_version()` make more sense here?
>>>>
>>>> I think the more important information is the build used. My
>>>> reasoning is that one can call run curl --version to see the current
>>>> curl install. However, different versions of curl have potential API
>>>> changes - same argument with OpenSSL. What initiated this for me
>>>> (the use case) started with a customer who incorrectly installed a
>>>> git build for OpenSSL 3.2 (and its libcurl friend). Git would then
>>>> get a compatibility issue when attempting to use either library. The
>>>> customer did not know (!) they had the git for OpenSSL 3.2 version
>>>> and I had no way to determine which one they had without seeing
>>>> their path
>>>> - hard in an email support situation. Having git version
>>>> --build-options report what was used for the build *at a
>>>> compatibility
>>>> level* would have easily shown that the available library (after
>>>> running openssl version or curl --version) reported different values.
>>>> Otherwise, we are back to guessing what they installed. The goal is
>>>> to compare what git expects with what git has available. The above
>>>> series makes this comparative information available.
>>>
>>> How about announcing both versions of the library if they differ, and
>>> only
>> one
>>> version if they're the same?  We're building this to serve as a way
>>> for
>> debugging
>>> various issues, having that information available could only be
>>> helpful.
>>
>> I don't have a huge problem with that except it will significantly
>> decrease performance. We do not currently have to load libcurl/openssl
>> to obtain the build version (it is the --build-options flag), so
>> adding additional load on this command is not really what the series
>> is about. Doing this run-time check might be something someone else
>> may want to take on separately, but from a support use-case
>> standpoint, it should be covered as is. Doing a comparison is a
>> separate use case.
>
>Yes, the additional load is actually a bit concerning.  Perhaps we could w=
rap the
>current series up as-is and leave the possible improvements to the follow-=
up
>patches?

I think that's where we've gone, yes.
