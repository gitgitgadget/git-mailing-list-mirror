Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19013085.outbound.protection.outlook.com [52.103.14.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089982F9984
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164444; cv=fail; b=lXtAwRppIbJmPPdlIgFLZRyxzAHOiDVPunJp+KXz8gM5AbVejshoCcVahGS4m1gI0C7VtHES3zPT1ob8dkTME2qYplsgCqgSgypnO1BZxmra6QQ2ydqtrPDyPNNrL5F16MrbQ6fHkOvlzas70O1/TbkS6TLT2eElQUxzWB1USE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164444; c=relaxed/simple;
	bh=vh11IAXN93vFsc0/9H0SATjU1acNw9pOqx1CosxhygQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SQSZ9XmjyZuKegkylSianYVPTHYN84oO5zS9Y/lrr/3aj48vkeD8oMnIGzlbLoKYYt4M9RYDLIVujugvEK9Ly/DdJMzDi7+2E5qRvLOq5LECCOGAL2mD43Cmnn+yCiOezXJtgSTvULT7530lA0ch2OJY0sktcMk6QeSJdgm9BCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Qiu8obqJ; arc=fail smtp.client-ip=52.103.14.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Qiu8obqJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpC9xdKE+PANRKzyv4XN9oRwQuLhOape6N01e3Dz7CdwrfXsklr3mciy+xYvrIQbTzGcBCJhzP146+UkEM+okEquDuNOGzOEtKpOkMUJ5imG4MOegsHQZC2QkYLydLBcq1+9mzNX0VYJdOvFSc5aL4Up2ljwScs+1scPvN+Hc8FfJoO8Tv/sCHafoHL2fIaX3kG+Igxftj6lDV1mp6NZQnJGHsYlA1JRRvn90LEBuxYkOkHxh4HENAyzS/zGpfYDDYT0iZVu3wqWFbxlX8TjDrMD+H7HsxdCqI/sfAQ7+XvBWvi++XLYEkeyvI3O59EttV2XoGvHvFuqmCLMQUPdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AI/yCrQ1mW2Ur1KK9QY7pOyk0JJD+n8resc88VL6L6E=;
 b=m5DRwdtCHAo7/aBlSO1ne9NLTPxBSUvr+yu/nmhCx2YmHndF2cq/DL2i6hq6VaVp5wUZy/zyzRXKljDpm0D/J5FesbSrzcc3qaXcmQxilmuyWrtcs1Zp4s+P7Kmh0M0/D4RqJPKDYMLyMmcd3jqud4C8yMy4vVYGQ9F67N48yjfzU8AmKZ2b3sKVI3lOnIeZJgJHB4oKrHt03cMP33cibGrIiJUvfutuTGP1hK4HiaT1QUFxWXVr+W/VzZ3U6Al2niyy68Nfx3MxVESOQaVS/br9afkyLFuZknZp38xGfJcilaD2oAn2lpuDNY4pyNYbukx/UuNmwuQTR0aDY8LWCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AI/yCrQ1mW2Ur1KK9QY7pOyk0JJD+n8resc88VL6L6E=;
 b=Qiu8obqJtrcf5g2NeaWv7WV2VCVFL5O1CjZhYEwSkauQ8nPkTxSBysR9v+lL5BlBsJ5/QwDzBrh1T5gzGe/zKXNz17GTWnmAMK27GSZNK1gA68xHkRHQ/vvAWzovBoY/4dNSIWh5EygX+TDPziPjgvEwjjsAVGjSVNjq5zmO6pSi1y9H7S8Hbfl2cPKyrD6u4KC+0iq+v+LRn0szKL66f15tqpnKCAfn4KQkVM0DOQjJvjw6fGhNypg+/iJ4IcBKzpsdkAXNt7zWoGmmwsmy3YW9DK6PCkTuqmr956E68hRvzsmPFXBLWwWO2odvW868eP+1RepyFQ85YGlsC+HLuw==
Received: from DM4P220MB0817.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:6d::19) by
 EA2P220MB1497.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:24e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.13; Wed, 22 Oct 2025 20:20:30 +0000
Received: from DM4P220MB0817.NAMP220.PROD.OUTLOOK.COM
 ([fe80::adb3:2829:6496:3772]) by DM4P220MB0817.NAMP220.PROD.OUTLOOK.COM
 ([fe80::adb3:2829:6496:3772%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 20:20:30 +0000
From: Ruoyu Zhong <zhongruoyu@outlook.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Ruoyu Zhong via GitGitGadget <gitgitgadget@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] bisect: fix handling of `help` and invalid subcommands
Thread-Topic: [PATCH] bisect: fix handling of `help` and invalid subcommands
Thread-Index: AQHcQy7vryFHw7fRgEG6u4xzwTl/0rTOe/lSgAAgRgA=
Date: Wed, 22 Oct 2025 20:20:30 +0000
Message-ID: <E1128C6E-C711-4742-B6C9-C3CD487CE4E6@outlook.com>
References: <pull.2078.git.git.1761122173126.gitgitgadget@gmail.com>
 <xmqqwm4myetn.fsf@gitster.g>
In-Reply-To: <xmqqwm4myetn.fsf@gitster.g>
Accept-Language: en-GB, zh-CN, en-US, en-SG
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4P220MB0817:EE_|EA2P220MB1497:EE_
x-ms-office365-filtering-correlation-id: ebe4aee8-fa45-493d-d92c-08de11a87239
x-ms-exchange-slblob-mailprops:
 B8gWPGiJ24QACcg/I/2fzWGpLOR3wYL3LDMcwza1x3iFP7doJJ1SA/5wheD7/5DNaxLU1E1vvjphTsOo0bt/Ew3i4c6Qb4gqOmneehRKNHADGq3KPkDOxTEXbp6CxZdhTpgFue8sJJS/1IqmQnhcGJsoy3EXjeBy1/Go1pfH5ie2wUfLrP/wcs4vFmBXj5gZ1aJDLAoF5dlWHHNMjaMs5gaFdpB1wcY2SDk61kpML2EERyIqT0XrxbH4l3JRHyGg1OV6QAe3gBBVsmC6FX5saMCrEdv2DfYriqKMLryRxDRzvx8GncAK1BSUUPGOmj3QfmA6YmnVfTjMYEI5GsYPYYyFvtJ+7EMXDDxABi0Zu/xF1Ir7NvRigteWBvdBcP+tmqk9oi3iJ1B8LaogcvvQ3SpQXnrn7NXrDpfyohgDgIytDVoOG7AhfYi+Yd6vOuqO9vjVanq+jPrbyDFMliMA4Bm2AUww6Bt2aWAkIIeo/vPIJIEHIyxF59/b0dGbPyOnhQe8sOv9KPqSpoJC8Kvh8oOwjAqiMR5HxcgVjx0rWIO2ogFXYkGZ16glmkSkN0PXz+0Cuawc5/18VNRrz+OU8BG4JbrT2kIjD5amlENTrAuPsXUf6nA7Si5mTLvqbnszE0HbrYF9VD4TBqHbPSwAeqbMw1+/IEAsez4Pt1dSJgPh0O+37kshCPnknjz4MGpyOM3yUudbbB0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|12121999013|461199028|31061999003|41001999006|8060799015|19110799012|8062599012|102099032|40105399003|440099028|3412199025|26104999006;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mNdWjREhRJCw4wDOWGya/mwUpheTQsciuXxxnGjSL5TRLg7/nx1qGyqQHSaZ?=
 =?us-ascii?Q?nfzIbc2nAnFo8+ST7ZjbIBWqyLASR5jfPYMkUw8oXP7q4OVlHoo+4h6pwspY?=
 =?us-ascii?Q?bvlSpqLoh/SfTLI68KE27JagayzUGQQEa0/ISMYOwCS4SW4kvSsXolKZH9Fz?=
 =?us-ascii?Q?SwtGB6wUjHw7ze6piqG/k1pwL1z1h+L6KUr8iGmCdyVXidck3cLhD4Kn9D2h?=
 =?us-ascii?Q?NweS6sQxbj9dL1eDdwUYLmTtX7uzuehztVv44+AQ3wD78t/nXv9+i09KJ3lk?=
 =?us-ascii?Q?nFgM6lnFCIgQg3eJjrqSb76gPRpLb3NwiX9MDUzXai0WEtrpeygupryJaplv?=
 =?us-ascii?Q?2lK5lMKQVR49yDnv7WVn/NNfR9jr1fWydwbMcgkDPa1A5+5xQqdV+e3t+PM0?=
 =?us-ascii?Q?K8qRy0h88RM1QMfFqlwiZYebybaMjfKICxaYLlzTmGLQFuGtDfnyYp/AOLfW?=
 =?us-ascii?Q?G5LdQFO5J8zWbj4c4n2MEq3Qxtp1IfyvfsnCc7Oy8E54Q7ufFeGcB3qxEL4x?=
 =?us-ascii?Q?l5I3AMpuTMWD/q+/B0UwjeYyWDwLx/y+eaqKNhiEWFsD/qC3HPblyQKq6e2s?=
 =?us-ascii?Q?QmImkmBl1LgcY/daLeQjVyPTP1Jbm/FAPGn0xX7veDug3xe20+/OQToPL0Tc?=
 =?us-ascii?Q?E061nH950hzryB5NnnlOJOu2URgbaWmVGd3y0Z00gjCQUL/QGT9zehT3geQ4?=
 =?us-ascii?Q?iNNbeKYCHWDzO/fwkf82FOYsjDeYiN8X6EWXeB1bWqYQPdQjxz658NzdV3PZ?=
 =?us-ascii?Q?wDVNE/n3BUeUuL+myCbd/Qtp1kcfwayn0qw8peZv51P+JzGFEU+1aZVFyDvn?=
 =?us-ascii?Q?vnv+xGKQVO8XMQFRw0K0GtnRLbynhC4zGF1purs4rqxOwE9vNf6cd57SvOiJ?=
 =?us-ascii?Q?roLn+JdjcyuXm6iNOSYAHqO9pcUyf1ItWccuxTP8xBVw9SexoXyNllDfcrrK?=
 =?us-ascii?Q?NjOAERrfoonMtrFx49SS3yUnQoqh33HpMv+6LmTAEIb4FYRsVqOCRZ7/4acU?=
 =?us-ascii?Q?+YxP+pldl4qfjm3WFgDzc3g+l1B6uDBHVkcTVVqCvw6uwwrRT73wg/b5OIvM?=
 =?us-ascii?Q?Qj7sdDA97mV52zygvlp70Aga/bfGckG0S3nCWmcJiXti3gdUFhYSOA34qVih?=
 =?us-ascii?Q?HsGVQuaClwV/evTF6S63NT23ox6jbWvnjXc/vxHB8np2BVArfYCYfzi/HryE?=
 =?us-ascii?Q?m/GSc0Og7zN7G3THpz5t0JytbJAtS9KC70poVEId+NCUE5WKJ+rjZEg5CML4?=
 =?us-ascii?Q?Dl4bxkMuXnGTuCWi8zY7?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MLxR6d0PyRfQjF40z7cNx6NgxCgJt9sx/7XCdObDwYLgcTmTqGaCiZNRzdwA?=
 =?us-ascii?Q?e4/t8NIWsr0/NT+JB+pYiF7Bh9uFmtlnGkMUH3WANRzjvXYA6EVx2mRDxslh?=
 =?us-ascii?Q?tZqTRd2LyfrK9vLO/HU1se6clUDEn8wuN/vKmb0FULh9fDuRCqlEtOYnTxtF?=
 =?us-ascii?Q?Z8Azn9DteSXiGiNuItnGA4kJFQEDxVHS/vdPb94i5ntT69og0yh+S6rWYdY9?=
 =?us-ascii?Q?pRwML19cwEjh4uyoQSGk2fDUNkoSbAGDaWXKpcmWAemmJ6uT6G/v7t5NwJ4M?=
 =?us-ascii?Q?7NLYd4c3ZdryR+N680ofsQ2arfrRYrboch1c9eVTf5CK2Wm0f+a/KsikyZ8u?=
 =?us-ascii?Q?J9Aw52iYLZKxRgnGX3hGmhN6Slo1MWS6Eng18bULQGLuNzPzcYaFFucgwTr+?=
 =?us-ascii?Q?xXfqp8A8tkok2IWFV4pOy2rQSZA8xH104b/JV+AO1qEiXw41yRrHLXNkmY+0?=
 =?us-ascii?Q?C/+mtmkwnWJkxDMfX/JH6/LGfnYSCU05HkHJGTJweAM3bL52nGKICz6YwKJ7?=
 =?us-ascii?Q?896+/GUPVKmUGRMEzvYUPlcT2RPjLt+crVHq8ZGQ6Qm3BcXKs0JRywV5Qfq+?=
 =?us-ascii?Q?u9BzbW3gF3RA1mWuYP3hK9HjA4Y7dXxz3DekKbjR9enai4VT44zdJvPX2Lrv?=
 =?us-ascii?Q?w9eyW/3wrpt8i2YAQttB7HMNqMqV/uotlbLOFl3tvWH3Vc+x6gvJUKG+POvp?=
 =?us-ascii?Q?nhHpqngjMVIiUcG8pPjSNSmsXq0fuzQPk8QqETyH/HBYLfzmn48926xoDveN?=
 =?us-ascii?Q?C4qEPQlbYsogwhlGYOTFflPwjOa1eoj4vvx+p8cTizj2oX2iM1eDCumbb5BO?=
 =?us-ascii?Q?YOrIX6PPdiyIOaffLxiqyMdq4Z8IlWB1JF4MgIKy9PdKCzvkggm2H7CAOyBN?=
 =?us-ascii?Q?GN706rpnBXz3aHi5zcTMBLeqAYVxb/zlArx4o8HfExrdi6TQXqIACHFe+Wn8?=
 =?us-ascii?Q?xe5Ox9RBH3FLyXPgrKiIFKIFMMx97u180oSLubnknjsAbud/W6PJnudnWmWE?=
 =?us-ascii?Q?EKBMjuerfM//G+phiPrhkUTqR8CoFRjRolQm/zIDSyYuuN1HnHmyqj6qxVc4?=
 =?us-ascii?Q?smViivon/hd4ns6rm5X2bAOnvPaPyQOZ9g5OWiLuDzM8C/p8UJ7J9Ozl1WEX?=
 =?us-ascii?Q?8cMtDADPO8t6494gRylHDbyWCNjcBV+Q3PueWrM59cBWRNWEk7z4pJt76F++?=
 =?us-ascii?Q?1wK3VJW2KljoTWlrX9773Qgv65lftv/U25g6rdvy+7c0JLlKME1dYe3tTo7b?=
 =?us-ascii?Q?3Xmf4X2i525NMB6TY7nSeWJqh8IYK402PDHh4AmF5zP+r7/D3wSOYqnDEQ62?=
 =?us-ascii?Q?225z6q/ajLvRPxRo8UTyMHes?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92021442B7E5F147966C8AF2CA385AD6@NAMP220.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4P220MB0817.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe4aee8-fa45-493d-d92c-08de11a87239
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2025 20:20:30.1603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1497

Hi Junio,


I appreciate your detailed and thoughtful analysis and I resonate with your
points. Specifically:

> I also wonder if it would be cleaner to add "help" as a genuine
> subcommand to the options[] table just like all the other
> subcommands.  The above would not be needed if we did so.  But I do
> not see huge upside for doing so (i.e., a single strcmp() with a
> call like we see above, vs. a new helper function to make the same
> call, to usage_with_options()), so what is written in this patch is
> perfectly fine.

Agreed. Will keep this as is, as I also mentioned in my response to Ben.

>> set_terms(&terms, "bad", "good");
>> get_terms(&terms);
>> - if (check_and_set_terms(&terms, argv[0]))
>> + if (check_and_set_terms(&terms, argv[0]) ||
>> +    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
>> usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
>>       options, argv[0]);
>=20
> This change is a bit hard to reason about, so let me think aloud.
>=20
> If we were saying "git bisect olde" after somehow changing bad/good
> to newe/olde, then we do not want to say "unknown command", and the
> way it avoids that is to see if the given command is one of the
> terms check_and_set_terms() have updated. =20
>=20
> In other words, if argv[0] caused check_and_set_terms() to return
> non-zero, we do not have to do "unknown command", because the helper
> would have issued a warning already.  When it returns 0, it may be
> because it saw a valid command "skip", etc. that cannot be a custom
> good/bad/new/old (in which case our one_of() would be false and we
> end up saying "unknown command"---have I just spot a bug???), or we
> haven't set custom terms and argv[0] is one of bad/good/new/old (in
> which case our one_of() would be true and we avoid saying "unknown
> command").
>=20
> And it turns out that my finding about the 'skip' etc. is not a bug,
> as these valid commands that cannot be good/bad/new/old aliases are
> already caught by parse_options() call and we know argv[0] is not
> such a valid subcommand.
>=20
> So after all this looks good.

Thank you for walking through this. This is very helpful and also matches m=
y own
thought process when I first looked at it. The key is that this part of the=
 code
is only reached if fn is still NULL after parse_options, i.e., argv[0] is n=
ot
one of the known subcommands.


Regards,
Ruoyu

