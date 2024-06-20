Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2101.outbound.protection.outlook.com [40.107.94.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801A1B4C54
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718908577; cv=fail; b=QACvxDUEmso9U5I0IBctnx0495rV5ku2vUXmtRbKQpI36dboK/1uHeNH5VoWp2uHM+jHAzA7MlKWg1qc1/iqQStCqTJUsisawbkeG6ULkVXEOL5T72V8On5kQ5h3nWYA+oS+QPYhvZ4XVSxgSmk5LK8hzeSO1jvNIMGxhTb5XcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718908577; c=relaxed/simple;
	bh=xbS5vtvTAl6zyaK2eux+VHfN1qnj/lAbE6KP11VUzSY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tRDYmrOLi5xE84pde7cn9LZnBWqN8DEzsvmUFtyzoM6UcFEQXLiMTAeBtM/5XRM/XpIpkm5Hl5E9z6q6be6Q1cD9LP0oRw4Z5F+YIu009EbQvSpzrwFZnXJApdcMeessv54zQkge4TEEInGNEySuDmfNK11wifKEVyx8QYeMbJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca; spf=none smtp.mailfrom=nexbridge.ca; dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b=tXPsLRvU; arc=fail smtp.client-ip=40.107.94.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexbridge.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nexbridge.onmicrosoft.com header.i=@nexbridge.onmicrosoft.com header.b="tXPsLRvU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwXNijaRkMUbgYiyczBzY8/+XPqDMirGWRS2XCcaNaAQ06OHxGMhd0YOYjIcD8ES/vbsp7sDWoB92QN8GYqbIqwjk92oQoL9vwA2hllf+5v3mKGKpVwoS3cqud0B7LZIQTmCf1HpR++CUe6G/qdbHppKpoeZChOnNMOITWkaoT+yCDizujX7qEnH2QvTjulKrhLeI1UpwaQB8HMs8hVqMKPSR75ux1B/e3PWBKuT9V8B4sC2Qupw9EE6Z9nL7YoT4ZhD6nskCaxKz4D/8rwDfhYvzAN6uOBYhhtJTnErj7UM+4eXgjm1MUA3X/3qphSc2e8Skg8ZKw0usVDx27WcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TCnJzbRjVNvO+wrRPDwo17Vfk0MNek/KtNnXY/eo4U=;
 b=CklCBinpzc7a91iNZB3kTbjmMyzpdf/3j5Dp8XY/dmtwB82tkxzV2EhrLooOm1/QYI+gt5fXAwIQ8Md+60TZ3H7mRPnCcMqaH7R0BUwC43jLe040qgoDrnbHfwfj08Ju2oR8LNeRaL+Bm3TKdHNpLMu6C7kR4WjHndeNalzIkVxW5eNa4I0RjOiUg3Y1MOIWFG4WfpYGLG5XOhp7nkbtUdeP0WD2DGs0kuIbZ+fMeDDmW4zTEfRHgk7xJQx4enSAIsvqBNaajY7aOmO9EzD87SKTJUsSrapATJMR5jWfY2Ksb5MYG+xQJL62gFE9GTXjesqFicgpd2Q+MfN/uRdI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nexbridge.ca; dmarc=pass action=none header.from=nexbridge.ca;
 dkim=pass header.d=nexbridge.ca; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nexbridge.onmicrosoft.com; s=selector2-nexbridge-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TCnJzbRjVNvO+wrRPDwo17Vfk0MNek/KtNnXY/eo4U=;
 b=tXPsLRvUGhBopnUmedTop56fbmW5NgQZsS5yF46eKU0R5eHkxK/phd7Wree/OC85+KlxO+E15gk+IX8tQ7aFfDmu9gmNYPe/25gLNqWIWL4UlS3IaRed7J/ICDQlK8E+n2KQLVeRekVnuqrWTwTke1K8l4cITt2v2N35s9Qsd3c=
Received: from DS0PR17MB6031.namprd17.prod.outlook.com (2603:10b6:8:cd::20) by
 SA1PR17MB4580.namprd17.prod.outlook.com (2603:10b6:806:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 18:36:11 +0000
Received: from DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167]) by DS0PR17MB6031.namprd17.prod.outlook.com
 ([fe80::17c3:c073:c600:5167%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 18:36:10 +0000
From: Randall Becker <randall.becker@nexbridge.ca>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, "Randall S . Becker"
	<rsbecker@nexbridge.com>
Subject: RE: [PATCH v0 1/1] Teach git version --build-options about OpenSSL
Thread-Topic: [PATCH v0 1/1] Teach git version --build-options about OpenSSL
Thread-Index: AQHawz9/8R0mygVoxk20McqKZnBxUbHQ+K3Q
Date: Thu, 20 Jun 2024 18:36:10 +0000
Message-ID:
 <DS0PR17MB6031B93CB905E771E8EAE0C4F4C82@DS0PR17MB6031.namprd17.prod.outlook.com>
References: <20240619172421.33548-1-randall.becker@nexbridge.ca>
	<20240619172421.33548-2-randall.becker@nexbridge.ca>
 <xmqq8qyzv5a3.fsf@gitster.g>
In-Reply-To: <xmqq8qyzv5a3.fsf@gitster.g>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nexbridge.ca;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR17MB6031:EE_|SA1PR17MB4580:EE_
x-ms-office365-filtering-correlation-id: e446cb7a-e84e-4b32-db01-08dc9157db66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6H1kW4uSRT2JDEJQkxb/FsLmgCd73cbCa6UZyRZDGdD/TT3E0suL7I5m1OI9?=
 =?us-ascii?Q?AU9bsETGZ3eb17jyOcFyvc8Im543H21qADbIiZf8g4uHPmj+o+WMEpd1JCN3?=
 =?us-ascii?Q?GNwRvOFWgaXemku9Cq862LkWc0DCdXqZw7Br1jisuvk6GZGYjcoiJzNONVo7?=
 =?us-ascii?Q?7gNiO/hTv20UpNUCSuRIh4s/1pZmn6LuJqS8EOlny4N2QMY0/gUhHs4MnKuf?=
 =?us-ascii?Q?TxQ3xu6Rds8abbjO6/GvwGdEEBa8a7YSz5clBC5KoERGkAJiLDStaBQ8mBag?=
 =?us-ascii?Q?gq3kUw78WMSs1SDvKfalsiWQFKZe/9JauduoZSUUOOU/O8+VKd/+hCn70TWe?=
 =?us-ascii?Q?nCUIaXwDVLejVW984iQKzZd+CwGFIP/Y3vx13SFRYqIHPO9cX03HzUbAjweo?=
 =?us-ascii?Q?jC/GGom+CrU9w3Iqssif5WxSgX5CZUefX/cYl4StmFceJdh0Ya1G0T9qeM3X?=
 =?us-ascii?Q?FRSY8rbKAr6SfbIBvR5kGp1ed+IYRtK2AeGiOnjzcHTctB6NMuP1+RE4K62B?=
 =?us-ascii?Q?9dh1g+Re5T0SaPuIJpjRBNOgrjzVC37D0qsB70JTCqdC7FgtZ5e5vjgmEeZ7?=
 =?us-ascii?Q?KCp7fZPo3tJgPuzt4zxhQ90umlyRKMDrtPEWSCxv74XYaXsOWYXbSiLay1Nk?=
 =?us-ascii?Q?FED5BsYWVlgwO8HkMC02KA5+FtEoKNwqHoCphnSDGnr2iZhRgOv9FcDyI9C/?=
 =?us-ascii?Q?sVRlZnGXQCV1bUZPFpi6HmDv6OfoDPDlG4dBoqOM+BOpT379zajjaxfh7WN2?=
 =?us-ascii?Q?RBTKBG40Fgl/B3HROtVazRTXsaJdl7McFbqUmXCPx+yOwNjEtJD6wBh8mfZm?=
 =?us-ascii?Q?fM69k2XamRm23BWTbo6JDGEiNdlwyQx/I1lmgbSOBURmKVJECKHj2/rXjrCy?=
 =?us-ascii?Q?JNapmvDg4L++UOzo2j36oPToAqwO/+kkEsflXqikCkBFXIuYhF+0xOuw5ALQ?=
 =?us-ascii?Q?fxK6E+O7OghoV0OZp/lZzI2B85h2cgSzXt3tEfdxEJIk3I1WT/r1qfZx6ZhB?=
 =?us-ascii?Q?ArlnK6292e1TMuz3+Xm6hhz1k0lIdaph1kmtALyLvq1l3fQTVas6oLOzoEQ0?=
 =?us-ascii?Q?FtqHS+aLygz5khjsqdmoFBvp3bB1lIvKCI/hlrB9AeNH6LpY0T8U84jbLzHE?=
 =?us-ascii?Q?54C7qJQ4irZpNu0+5HZUyAxrZykGk2WxRiThSIhVPQtSoNAGzO5GTk7x1/dt?=
 =?us-ascii?Q?KQ7/2MemQMIGVE7v8BEZynRHarAXkqvJHvRw6VNCkiKJviKNCF30JAK0HfoL?=
 =?us-ascii?Q?60jaIxeWGnqkZBEdbRCK5+vv9bYFkAmj23SwcC/QjFSpom2fr9XzALyClokM?=
 =?us-ascii?Q?vWyVI4tr+cQUIbivzYybZIBi6PrLnVnkMrzP68q6omceWgqGrWAC3qEMH1aW?=
 =?us-ascii?Q?mNctwmg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR17MB6031.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aE+INk8YTnY0DByljs4/tfip13f/ON/USDLqDOUkzHuOz3z8yA8eHWgbvbM9?=
 =?us-ascii?Q?SzlVG4zTuNnOr5uBstGYqm1s4o4HRAh++bcYYLAaMwKB+tWlUgq5+8WUxVrv?=
 =?us-ascii?Q?dE8FLNywy4n6mJf3nhi3gIoSf7JOm8AZDO6IXvSLD4bamNA9eI0lNURia8R3?=
 =?us-ascii?Q?Xo1XMKZrCtJsQ4ZWU6HipDoTyra5mE749eLBn1/eIWaAakkKN/zsDvoAalao?=
 =?us-ascii?Q?541ihuHugUuKdeLQs7uBiVos9sHKIjXDD3GsOZD8Aw212IxdMs7IsaePADjg?=
 =?us-ascii?Q?al8TKHRNDSFnlO2YP7XMFlG8cNPCnj3V1X6Bu5sfK4iTGwFpRD73QMWEvbDx?=
 =?us-ascii?Q?V0L4O5XnQbee1vq4VrlEPasCMq8kMmHG5x4vBwopHTO3w1wFE0rwl/DZ9tY8?=
 =?us-ascii?Q?PWcAHBRLyaL/vgMh3m+w6sbIelNUUKP5lRqdTSmQwMCeVOogkj1+ctfztsC1?=
 =?us-ascii?Q?GeGQUHeJuzoTdLiOifcOkI8ILfEmdJwhv46SiHjTN5Lehzy1CLoYTDlZP93s?=
 =?us-ascii?Q?IisPQHv3HlE2MBs+e+p/vWc5n1De5wODEOV0v1XFkHSIQRkMn0EEZetIlnBC?=
 =?us-ascii?Q?KWD8zSae56lAE/w67kTwegesLhrCmRrtT5xv7bS44z1H8FdYiKe//LgAinWm?=
 =?us-ascii?Q?h7exnC142mrUEMFcu5ikaCXIXSMWb/UHx0QUOQyenWws7n0ByCeqs9SaemrO?=
 =?us-ascii?Q?4oaLcAGj2TaXxwuIk2vVp/JAK0kLcT8k6FArCyTKIrbm8NbARImW54st8Fqx?=
 =?us-ascii?Q?g24bJZ/R6hdpkTpC2kXu+rcsRHt5MsXQQP8gq83pwxaxM2YQGmoGHUM7jUi7?=
 =?us-ascii?Q?p7hXOtjLKd/HuKWk33BLwQ3GC4bZxPNY9Ss0cf0mMz2Dxb7BRslIf/dccJDS?=
 =?us-ascii?Q?oS4sfTlkoxialgoP4voypZxAGpUSFzA4qNZiYJKbjodFOL0KL73Eccur6vzo?=
 =?us-ascii?Q?HrYU1T8hBfAk+OA/Zv3v/r+SKYmsA/ut303VZxMXdTFvllAUaWgyRupwZCxS?=
 =?us-ascii?Q?NmQsAS/soJjoAS7NSEtWhha6o1DMzMdV+dIa1dWiWOCIAcqvwVccP5jZCDG5?=
 =?us-ascii?Q?k9CjCpg4nVhPlyAt+8aJ+4ERVCtUS9a+Sgr04qqGl1dbJE+K7swLAErsFpzJ?=
 =?us-ascii?Q?T5KrpJrh6I9LD+UPM9YWM5cwwv8NU+7lepNE2bIb5dq+FD2NON6xoPW6YR0e?=
 =?us-ascii?Q?jovVupQ9DVTzPRkD9ZaUi+5ssqO9Vlqs6nLX70P+bqRAFZBdznQRJ+Ex21z4?=
 =?us-ascii?Q?eMXB6wuCAoBZpkV2nhWCVpdHcxwmRhakCKDoUOJ+Jur0CXyPYPlXkBmvUiws?=
 =?us-ascii?Q?4KcRxc9ezoM/u/he8t3Ea9EzgYPFczBo/aWFk9FYiomJhJRQw3nL+yaNM96r?=
 =?us-ascii?Q?RDO1TCEJ5wCPeQ7EsFyo/oUZ6bkPXcNVBaYCnur4As1BNOz4ETmEL/oussxG?=
 =?us-ascii?Q?exYiaMPE6Ur20uMnUo9ANWdNJ5pmbZceLveC24Xv2irnrrnltehJ8HWsSXdH?=
 =?us-ascii?Q?raiLXikiqyJgqth5W+bfGDkSsdzRsaiXLJtKR9QWzVXV5EsMas+jm6lx14Cc?=
 =?us-ascii?Q?QzGfF4kAsZfwe1FiZRdhRGZ+Py0adit5ndRbO63fCHmRsemeYW1fFJx3/bEp?=
 =?us-ascii?Q?erDlWqCcg1zaHXdLRN0XYkz89hq8VGDmhf3oezWNeTjqJVZvr7W9GhQtor29?=
 =?us-ascii?Q?IpyW+A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e446cb7a-e84e-4b32-db01-08dc9157db66
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 18:36:10.8772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d6eda728-7424-4770-8f6a-462632ca4c1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5X80wAYM8EOEaz479Oo2xtHzVrSLuXQx6lAkSddxaAJUroQfiIpa4ibo5MDwy8NDOtsSJ9NigX2+Mdx0iECZHvpSEyNKcS4TebW7wVcdp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB4580

On Thursday, June 20, 2024 2:27 PM, Junio C Hamano wrote:
>"Randall S. Becker" <the.n.e.key@gmail.com> writes:
>
>> This change uses the OpenSSL supplied OPENSSL_VERSION_TEXT #define
>> supplied for this purpose by that project. If the #define is not
>> present, the version is not reported.
>>
>> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
>> ---
>>  help.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/help.c b/help.c
>> index 1d057aa607..ce55aaa2c0 100644
>> --- a/help.c
>> +++ b/help.c
>> @@ -757,6 +757,9 @@ void get_version_info(struct strbuf *buf, int
>> show_build_options)
>>
>>  		if (fsmonitor_ipc__is_supported())
>>  			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
>> +#if defined OPENSSL_VERSION_TEXT
>> +		strbuf_addf(buf, "OpenSSL: %s\n", OPENSSL_VERSION_TEXT);
>#endif
>>  	}
>>  }
>
>It is kind-a surprising that we do not need to play with any Makefile macr=
os for this
>implementation.
>
>If some unknown version (either in the long past or in the future) of Open=
SSL does
>not define the constant, this is just compiled out and that would be OK.
>
>If some unknown version of OpenSSL does define it but not as a string cons=
tant, it
>would break the build, e.g.,
>
>	#define OPENSSL_VERSION_TEXT 2 plus 4 is 6
>
>We could stringify it ourselves, but that is probably not worth worrying a=
bout.

AFAIK, this #define is guaranteed to be TEXT by OpenSSL. There are other fo=
rms of the version content that are numeric. I think this was a change intr=
oduced around v1.1.1. Now that opensslv.h is included, we can depend on thi=
s being available (or not if it is not defined). Stringification should not=
 be required. It is present through the upcoming v3.4. There are other stri=
ng and numeric forms of the version, but this one is most informative (tag =
and date) from a support standpoint. The only thing missing is the git comm=
it, but it would take a lot to get that put into that project.

>Will queue.  Thanks.

Thanks.
