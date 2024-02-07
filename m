Received: from AUS01-ME3-obe.outbound.protection.outlook.com (mail-me3aus01on2092.outbound.protection.outlook.com [40.107.108.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D11CD19
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 06:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.108.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707285641; cv=fail; b=OV+tYgfjTeMmrwVzCp3nTZgJrIcjFjT6yX0RITS7UunkqhBaRZkhOJQEn30bB7Fq2KaVtaQDTMet4Q/5vqRzAg8iaoqVLB3krXVKJop8jDRZ+B5SdLAG9DVnW4xuQy/+xZ1PaQPt4fouUj/W2Yn5wm7mcKIL7DYopfRSVpn6cCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707285641; c=relaxed/simple;
	bh=JLKrEBPslo86tyODRtMovrsSzImRJobBo0zCoG4v0MM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kwEXouXVLmjZS+uV6bLsPYRjOEVRex92o4AmIEOTQ4bcfqlUfpgJeYxd/eJLmipdZkStV4XkjiHU2XAvFVtCGyEYLwwIk/ZWn3Yd2r/V/3uneeS0nFQvQ8rDmnZktlGdaCgLXiuTRigrPRLrD9vG7omxl7SUFuuObSrNZF2jo4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hambs.com.au; spf=pass smtp.mailfrom=hambs.com.au; dkim=pass (1024-bit key) header.d=hambs.onmicrosoft.com header.i=@hambs.onmicrosoft.com header.b=buuHFfGS; arc=fail smtp.client-ip=40.107.108.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hambs.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hambs.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hambs.onmicrosoft.com header.i=@hambs.onmicrosoft.com header.b="buuHFfGS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkH3kPGpv0zkJ1J38V2AUXBZBngenoXdLxTJuzg74yVEnssqwxvzdCK6qvjh/s8U7V5gJb5T9iyg/Xbk9Gq42Td3t2334dx03EkaQqsow5agHbr3j4VSIjyr99KEnuBN69bFWl/Nvowag/BNPNn5IOFp8GtGS3+5bXWcl8pDLRMwTVAqGXCu0xgHO4mswBtRomJYyHjVPDL4P2ho78Zhsz7huEeTVnL3+erVPAmFEMKYwrRBW4WQIpU5dboZaAbzTyo97fx+5+pFqUYLVymoVS+ovczp4lmAIn8BSOzRGfr5GWHUajoibUTsL/R8yPUOvFqJ+3nNFj3DWgky1ALArA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLKrEBPslo86tyODRtMovrsSzImRJobBo0zCoG4v0MM=;
 b=huASPzOGYpOctAvFIgq0/OoUvwUbrO24Rmuc6PnR6mfvWybjORXNVNhfhjZFT4liFTm/Fw528Z9XXDO47u7oJl61V4mESbmMWr+SAW1giSq23xliWOZo87ZFLiiqvLn+unfJCaRgbVl9iS0QCtHzXRqC3QJt5MWQLC19vLtQr/zz1l+NFZvm8yIqNRBMOAu9BuhBTdULFi+qLovbuj1E9aA6o7mfptWgL7S3aqSORsdfrhxCAxsbaGadQt5kidkcwl9ymy7TGMOJQkwWebYHYauIbQurMjUtxDOo/v/8QuUUvxJy3bUANgWBx6iyFMjGUM4npwJsXj6RGEVbkjH8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hambs.com.au; dmarc=pass action=none header.from=hambs.com.au;
 dkim=pass header.d=hambs.com.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hambs.onmicrosoft.com;
 s=selector2-hambs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JLKrEBPslo86tyODRtMovrsSzImRJobBo0zCoG4v0MM=;
 b=buuHFfGSggR3ZtvD9PEjgkJdRuHNJbJiYXEYIEWNBMoibKakxQfKDUhrln5o27TfozFsTVDZ+llb+jl83FYH6vKcSdHTci1by+3G20kPEhsXwYxOji/xvdCmwYANmsOMXfzgLR2/kqsS9tbPvxfc1XyVVEXPZHCQcqnhNNnOAg0=
Received: from MEYPR01MB6534.ausprd01.prod.outlook.com (2603:10c6:220:119::13)
 by ME3PR01MB7864.ausprd01.prod.outlook.com (2603:10c6:220:190::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 7 Feb
 2024 06:00:34 +0000
Received: from MEYPR01MB6534.ausprd01.prod.outlook.com
 ([fe80::d48f:6852:530a:b9dd]) by MEYPR01MB6534.ausprd01.prod.outlook.com
 ([fe80::d48f:6852:530a:b9dd%6]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 06:00:34 +0000
From: Allan Ford <Allan.Ford@hambs.com.au>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: GitGui tool - new local clone is missing commit(s) and missing a tag
 on master branch
Thread-Topic: GitGui tool - new local clone is missing commit(s) and missing a
 tag on master branch
Thread-Index: AdpZiusRmUutWI3hShy/4SpxjyWWGg==
Date: Wed, 7 Feb 2024 06:00:34 +0000
Message-ID:
 <MEYPR01MB6534B74E07CB2231EAE8D5C7A5452@MEYPR01MB6534.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hambs.com.au;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYPR01MB6534:EE_|ME3PR01MB7864:EE_
x-ms-office365-filtering-correlation-id: 3d4a8509-3390-4103-20e2-08dc27a21980
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WqRjlTlKqePhxziHpeM+y+OZhZnlduiwAYOTIcSeYRRtsjYjSjb5hizFfw9e9LFiAm+qjtKPsmG7cjuiRcmqewHmBgraANbCjuk5KycCfVPV+6iv8F1Nr8YtbgbCpsehXTyoLUvpz1km+tN0OPuHWzfH+a+5O9PXJpvOSms2CpqqxguZwT7dyycH9XIWzf+Y4GereVuzgTi4ZJkflIrAyeAM6/hSQvP4A1S5auRKN7UKA7g3n3Mic9cE6jFRTqVs5gu9MMPKBgTj7rxirInhk6bQFfIUrBe58ksLIayPF2EgTEkR1YLaFgiJ1CIgsoAonFIoeo+weprAADMSQaAs7th6lbIt9yIH0LEH2cTKynElsLaBJrcogf5IJ53tg3OczX2OYwBac8sIrKloh/EWEwf+4xcnUlZ/2HBK0ctOoYA4i8UAS3P1Bm4kXrIovGU9C55E/GqL07pm2eeCr7zCfCXKsh0wfCsiDbtujli5N02a76YZj8EKvhHWJ4CjYSledNy3ldmLvk/y57aoYW0vN2vrm/nA3P/fawIeaAUyWOfnYLqW8hYLMc6WaxBYchnSRafFbzsOYJFneuRmrU50VM2/Bt6z4ZErwkribK+NunE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MEYPR01MB6534.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39850400004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(55016003)(83380400001)(38070700009)(86362001)(8676002)(33656002)(15974865002)(26005)(5660300002)(66556008)(66476007)(2906002)(7696005)(122000001)(9686003)(38100700002)(64756008)(41300700001)(76116006)(66446008)(71200400001)(66946007)(316002)(6506007)(478600001)(8936002)(6916009)(52536014)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VW6jBn8SGsVwD6GyNwSmNAlb6zeP5G46xV1b5W/VaUc95BTj7QU8oVK8ZC?=
 =?iso-8859-1?Q?gvtxsB4x98fmGJfidSANbx1T+2K7TMZoFozoSe5BU/J+3l6w8Q/GAWbzGM?=
 =?iso-8859-1?Q?Y2S1sIiNYCYT6JrUYasPBDKtFfwdkaZlh9eZjv+kF38TMd8a3a1faBouz4?=
 =?iso-8859-1?Q?umJkxBv9IFuk52p4wGsOzL5tIadKYUzcgED05DKPiLwn9cr3oFbqMmlOw/?=
 =?iso-8859-1?Q?FapPp13kN4nuxPTgvxM0y0tAJA6M/BiPpvJK2EsRIeuQ1gE7icgPMaOgog?=
 =?iso-8859-1?Q?oDowUkojnc1uGaEgAxAkenbT7ga606yBtuDFyw0ywQeWvi+yPzfH73zW/w?=
 =?iso-8859-1?Q?8nydmKgx0RJFQEhYYZGInDDeeTYYyY4Wtjhm2FL7zfVLdJrxDmBKB7O5qD?=
 =?iso-8859-1?Q?b9wHbFtwun8oPdnKUTIbv9iszT8Q+f0+o8eP51lMXCRUNbKNPphAa+38cF?=
 =?iso-8859-1?Q?7KU6XH+jGEkO/IAAfM30Zhgkb+8R50RYVR8gne7lSppnryArHGr1OV2mTl?=
 =?iso-8859-1?Q?8Y1f0fHRlo7FkL+mo9DQhjqyPqcuLNcP3WwrbYEHV7Y/tXOqGRwnjYA+aq?=
 =?iso-8859-1?Q?TQJrSJ//Ge31QtY9ojruUvDuaAs1d1m9pewMgi/7h9uJWUBHXwPPjR7ZWz?=
 =?iso-8859-1?Q?SeiQNarjfScNJH3VxQ1AAERqU/y9SgVel9uJUSL95vVm05joEJxxPVjqVo?=
 =?iso-8859-1?Q?O4mO+MN42neyjJlZA0ACBGSlcpYZT3joE+i1C40+X8ekK1VwIG0vnFBgOa?=
 =?iso-8859-1?Q?fSrmCHa9OxlFfRZ3BIt9vX+v2vC526wSXUBPCdT56BjaAz29R5g6mXpa/H?=
 =?iso-8859-1?Q?AbR1kdcTi4QzCFNGJuDeweGmselQlYW0Kuo7YSo1dF2Tl4El8lu3lVPlka?=
 =?iso-8859-1?Q?xsQk1t9b6T2kelGYHokqdeVCJnqDV5UVF/AJ+D2zhTsSCX//tBrl3gLfGQ?=
 =?iso-8859-1?Q?YydCc0LqBYv3RlOcOjWFKwBXwkpPXEd9MB1op1GxFgiQ+6O52WNuFNeXt2?=
 =?iso-8859-1?Q?RKGlykCFxS2jVVkmzNG1T8u0RyK92t++2+sE7XDJKDJaHsa9GD33POoHvw?=
 =?iso-8859-1?Q?/JAKuS7tUVG87eFHtq9/Zdmv4B/jXop3SUG4kTLguBkFcsjfOQhwZTm5YK?=
 =?iso-8859-1?Q?5M8BOrd92xhSiarxEn1YEH7nSgjZHWfM0/FS4BeHghJ1zZU7WFCxQu5skb?=
 =?iso-8859-1?Q?Yw2SVg6s8U6gCZkwbE+VLs9A9dUVQqXeLuGuWWUm/fl920k5pi0n6jcThW?=
 =?iso-8859-1?Q?EM1ftg7o2ExSdYCiRlIz+CVLa8F3dhvKy981DR9ltm2UUyNs+yw+8ClZ4O?=
 =?iso-8859-1?Q?g5tG3aFP/5mHlWCjRoHqE2JGqFD5iqfX2hkbftdxbMlsYEf84HKhduNO9n?=
 =?iso-8859-1?Q?Us83zZkSHj7FKHgPezClRfiZ5NtQC4A/YVxzAYnM051inzUriwp5LTG57J?=
 =?iso-8859-1?Q?N9BFghDrWbPPmDAzy6FeVCLhSLRVaF2RrDvmBgJJO5AZhbYLeYZJeUUZpk?=
 =?iso-8859-1?Q?NBskLJx4x5tcNI8a+WnxtMJGotgypqghG4R1PyVEmEMcg/vk9UwY5I+MsM?=
 =?iso-8859-1?Q?7NNc85yuQYfNStlB4QYw+P/27Rdvu1BY1bJP9z/yp6jQnqD4mdvTfKz6qb?=
 =?iso-8859-1?Q?TcQtZu3hiCXyfL6xyAHDmRSyB5bzWZFJz4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hambs.com.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYPR01MB6534.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4a8509-3390-4103-20e2-08dc27a21980
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 06:00:34.5706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 91b8ad2f-423c-40bb-96e9-6b3df4ce581b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PlouKECr3r28FC6x7XXL1UH2BiFqHqwnWH4V5romM9ZR5mgXzr63dMNpUviLtSiefODpFrd9VU3rHrBN1b+7fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME3PR01MB7864

Dear Git devs,

GitGui tool local clone is missing commit(s) and missing a tag on master br=
anch
=A0
As compared to using Visual Studio 2022 or Visual Studio Code ..
Wondering if a bug somehow / somewhere ?=A0=20
Other colleague devs observe the same ..=20

If I switch to the remote master branch then I get right content ..=A0=A0 b=
ut I should be able to do a new clone of master and hold locally.

I have trusted GitGui tool and it's new repo clone for years .. but it has =
let me down this time ..

Kind Regards,
Allan=20

Allan Ford
Application Developer
email: allan.ford@hambs.com.au
www.hambs.com.au


