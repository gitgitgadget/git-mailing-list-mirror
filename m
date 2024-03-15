Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2123.outbound.protection.outlook.com [40.107.220.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670DD19F
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710462001; cv=fail; b=GyNr42O+k6WH+pjEg62jxXDXl/uj9n9ODwbz7lsp/hQcb5vvkDmaz+0XVJ5dW1/BYGhItMhrnW7ShDax0ViGsHtb+qHe/IdSh8iRt5L0sQ6mHw79HDj2jcoqe/Mi5DkryZJBoSdOwq8MU7WaKTtGOaqwGzXbGsi0BO5Wqit+1Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710462001; c=relaxed/simple;
	bh=AjYyoyENi4AaL7EAiBCC/jd6SkQdkIAhOkXWI/iILlI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PC3jJ+ivDRjsz2oNJiTlahViellozJHWxP4rFHWctF4gqgDRn0DTSfnWsYLoNv1IbuSxhLSU1HCcQImjj604SoLdPlgCd1VVQZI7I5/11R7ESUaoxTl30aIOsd8tMZgGi6e/whI6eSvKs06Omoe0AuvvB96eSZm4RTyqZ8xqtkY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com; spf=pass smtp.mailfrom=webpros.com; dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b=XPZ96Eei; arc=fail smtp.client-ip=40.107.220.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webpros.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b="XPZ96Eei"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7za628Wsfli5T2QjlvYMMgzY/gFRchUlndUG6deFI1AS/d5qZfIp73H9xrhG8+Uw8VWd3nGFyqSoVGjSyfX7v3Uw8KSSTRAjM/tCe5nnXv298si/jTeQPZOk1U9uYytfxy0ZFRrhvR1JH9T2iLyYzM45rrjvXTZry+3KjBclk68o/1nyDLg3O16igNSMGNZRxusNTg80Y9qLxPxtr55KwETmieE8cPbea4f5xjOj+RLZiTS9v9Ui58QUSnEtNjsKhU3MygVU/fwDH21ZG3arst+9fkrX+bhc002oIPE7bJO3pczqkvNA0eIkqws5F37Vsdy6TSyVxP83h46+fq/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLTeq0bppkGj/dSdX4gvdfAHUM5p2OLiwSkgbNH9CDA=;
 b=l/nGuvmpTaNZstg2+sMrFvbHUerGy8+42/3i4KZSGUigeDSOUuATekGwjfnnpbwuitLqLIKq/RpSHfedGdpT2GmhkpALcV5GG/Y8quI/xpS6G3AV5f/ZCfECNj0GQ83SbL6qtIOx2FYSqmesa9/xSDbBf3xQkqTwoKQswyGlXIukWhL57jNK170asmRDujg5xQ/6wqUh/d/PfKBCfY6fXwT6SEYYq96n6Ehss5hBXTYxd0eH+E81cgCqBoNAmGGpFOVZmuyK70QFffCT1d6uTYSgCwL/BMA4TO6ADgGzLC0nuvSK0zENVFKaYKAALYl70PW0mx45NLIp7Dp+kMvymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=webpros.com; dmarc=pass action=none header.from=webpros.com;
 dkim=pass header.d=webpros.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=webpros.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLTeq0bppkGj/dSdX4gvdfAHUM5p2OLiwSkgbNH9CDA=;
 b=XPZ96EeiVWAM7ymIsOYR6eNL2zx8otxidv2zE65eXqV/DAWi4yIF9XMAlnQdedwKTdpcYnZMxt94SmYpdreFIdeiczlP5KRcCbPqM3PO4xtw5sR6G03/n5ReIRGHkvaj3/KixgJ40KXofY04i2EczjuAsSjGr46ALFTisE7qy1RuuKIP/xCYRN4gLlLpHRm+z0ih3s01WIi8SNeS+4Zv4MLxAband2uLMBxo6WNhPx1Ctsnp1IwdZ1MUwQ4TzOq2k0tLjb9SOrXnGgiEEzNTRBX0o7KtSfRG4Twkh/re9i7FodstvUzPDfRNJ48fLmGaSSLnBf3mofHPO+dKwqqh8Q==
Received: from PH0PR14MB4702.namprd14.prod.outlook.com (2603:10b6:510:83::23)
 by CY8PR14MB6363.namprd14.prod.outlook.com (2603:10b6:930:86::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Fri, 15 Mar
 2024 00:19:57 +0000
Received: from PH0PR14MB4702.namprd14.prod.outlook.com
 ([fe80::780f:93d5:996a:1fed]) by PH0PR14MB4702.namprd14.prod.outlook.com
 ([fe80::780f:93d5:996a:1fed%7]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 00:19:57 +0000
From: Christopher Lindee <christopher.lindee@webpros.com>
To: Junio C Hamano <gitster@pobox.com>, "brian m. carlson"
	<sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Thread-Topic: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Thread-Index: AQHadLHezsdN01rhbUOhmHwkmqTtTbE2SreNgAGRaICAAAl9poAADcBs
Date: Fri, 15 Mar 2024 00:19:57 +0000
Message-ID:
 <PH0PR14MB4702D85D5D40F910A97B49E98D282@PH0PR14MB4702.namprd14.prod.outlook.com>
References:
 <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
	<xmqqa5n168nh.fsf@gitster.g>	<ZfOAdVy9_UfTj3zE@tapette.crustytoothpaste.net>
 <xmqqv85otmsb.fsf@gitster.g>
In-Reply-To: <xmqqv85otmsb.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=webpros.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB4702:EE_|CY8PR14MB6363:EE_
x-ms-office365-filtering-correlation-id: 73f0f506-78e2-45e9-163b-08dc4485a56d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aagK7P1YwTYGkCh/ao0Pxfd2s9UzrvR8kRxi8QUE+L/l5nuNGRj6w4DhgYAoCRMWWj91+fCKC28BY+NClE5JIsa+ruPcqeoHvR6oP5EDOxb93mOajQ1/3K3IUdNabRq3h2UxZQe+yOiX8oyn44JzZQHyGjBRViDpKf+B2XhNVmyGe8x/I7GPm5o35mDf6NwG0lKuhZ0MK/F2GcIQYWWstHh5xQ+8BFQ6qmxqproxx2BuL36q+zqK3noYijsgS4iH1USniu1VSjIMQ84cPK+WqXok2WoeXOQaMK06uuLr2S17DwtbTuSmodICWnk17hCy2W7XmFYNwptcwuSTcXuh6GE19XAaRO4sHO7J6Eb4H2cTDyUiDt/m8wfT8ab9hMmVR3k4NLJZLV3DqT/pZsVPkBzdxVAb5EZBw8WuNr+Yreb9v1OjPVY7AV4VRZsPvNo9JzKMl5Ynx8Dvr+zURGz1XphoLSoDan42unAw1doZpDIMlFDfw9MwjXaTD52AN+uldJVueHw16uuaYQVMA5IDf8jY/ZCoRLPh6lGUcS68JLB4D3E1pfaOiLreQ5ask2tF07Z4hNpGz+50SOiZWWYNefQNKBcouw/8gkkJI9BP+5/n4EL/9RlDimBbPgH98TeKHfe+Q3ZAsISJjAj27t93W0M68oUV71Ya+NlUT1ThdF7LqcfsVX8PGbOYUNL4AreXAhRgzbJPMLD/MgKht5mGqdMAK70xQ1c2rBxKtKMehOU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB4702.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0da8wv1nPh9s2IZEptaolEI4IAWeGq/hl/dkWvN1HMVovgykGDOhhDqRXe?=
 =?iso-8859-1?Q?6vGIiskz+JxNk6+yf5h7TTuTVLwRUaLHne6gF61FiYi+rdNd7WndEz8vs5?=
 =?iso-8859-1?Q?laqmRpUB/itIyt6AiwPqNXWqPeO9j96ayn/0jWCqBo4Gnf6osOdBS+8h0K?=
 =?iso-8859-1?Q?E6z441JzP65AuyC30lzitxQ9a9A8T+1+8Qqik8snUhCUMdc1Gm4j84jwJq?=
 =?iso-8859-1?Q?TiJGfIKS6zaxNhPgOJlaz/qPANd4XkoSxGROYdF0ffYxNTDCDIySoY7YQT?=
 =?iso-8859-1?Q?x9lV4na+vStOgxwTfqsqiOOfT5Y9teJo32x1jfR23Bbj6lqdxCAujgpFnI?=
 =?iso-8859-1?Q?IQ5i6YzOyM7qKRUplDuH+b+TCsf1SZDhnY7cTYyhnApsqqETBo4QFE2OI5?=
 =?iso-8859-1?Q?DFGAoygCtLxy+WrrFAuFB73mLSSZyjaUL6YGfMcmfEgf4CQS7uAn9Vzupn?=
 =?iso-8859-1?Q?ZJ9Rweiv257ftfE4Yjpd3uTD2DJ9wmU4/3qDt/cpWd97QnGCJ5c3mjcyk5?=
 =?iso-8859-1?Q?+WSmP/sBpGIllFNMjE7GKRO5IHGtkxjSFE3o8tJgS331s5zYql8E9PNHOu?=
 =?iso-8859-1?Q?eoQ2wD2ern9ZhAev/yBFsafZ7Gs0ZKBDGrlOC9nmi6YEamAMkwKf2v820+?=
 =?iso-8859-1?Q?yCv3dryFU1skdfhiN7oYxmdROJ7GyDG7zyp6Lv6hdgUod8J6zJ+7K+f10F?=
 =?iso-8859-1?Q?EhvYsrPff34AKimN+gQjwdOXfUyQA9xTm7xp9gowB1l4GdUrcNVn/5wiQl?=
 =?iso-8859-1?Q?ju9wQCWZcOk1nn8Rz1Xoq0Dch5pkHni76YZiAOO1c0JufQgML4nLh1h3VZ?=
 =?iso-8859-1?Q?3nWB1hyPiQjT5XbclG6AzmRqJw5Fb3+vLaT58x/3iRhwo6M6BUsYaMuVuP?=
 =?iso-8859-1?Q?GXzzu1Yj9aRnuFpSIHmvmJXVKmQmHZSZikaz0oBL3nM9+Oe/ue6xnTa7Ah?=
 =?iso-8859-1?Q?dwbJDPdkmigbJwe2t4vHTdLBetpcF1JCweM9AksP2UpfoDGuhqSj2Df/Rd?=
 =?iso-8859-1?Q?4ylB5HQQgDTCIxl9Z3OObs83wS7nHnHVO7M8cxKOeKLC9Q2+B8tqoZITyZ?=
 =?iso-8859-1?Q?bhLUwue+NjGyIqnTzoN5QGSylWObElrXlYU53Q26scV/syhtPi/pOrArPf?=
 =?iso-8859-1?Q?P0AmE1e99hd8oEHI2qmWtxcTVX3rEUhUkLtAPG6sKuN6rzZyVatPNHaw7h?=
 =?iso-8859-1?Q?nSGWIQhA+SdLLTzD2KFgUhTbGADAw+0AKMFzbCBAWtG5GY8dglW0Lv2i1+?=
 =?iso-8859-1?Q?xeTvH0GQcfBrBpxApSb7HLofA9pSzNRIaups4zAovtlIG92oIViACOdx0X?=
 =?iso-8859-1?Q?evgyfvJzYp/YYJBV2SQ49eioORFt3PASqwc1JNE4amPwjDz+EV5pKFIuKc?=
 =?iso-8859-1?Q?pX6Pg9TqoTcB9kKtoTKqF3T+iyOfkgh+zbdn/Dpq5ER2aVLfoBu74QhfQ2?=
 =?iso-8859-1?Q?/Aklg6F7eGBtZoMMl3citMQqW12SgVzt6kszNX6kk8iwhZkUsTuXyMvTxy?=
 =?iso-8859-1?Q?tSREzOt29XcvfM0XNZxCMehr9uQunreav08qoBN8vOh042RISpfvIjd9bq?=
 =?iso-8859-1?Q?za5udg2JQo8PIrs7AfcxPePH1+co7+hY+Ost5i3E5lqmnNABfL9hjBJreS?=
 =?iso-8859-1?Q?mGdDJYoMz8pVZ4hYaq8hIb+SX0ENLrYIg2t/hoPsMDHpy+U57gDDCYsw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: webpros.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB4702.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f0f506-78e2-45e9-163b-08dc4485a56d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 00:19:57.6226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8497356-a834-4060-86b6-d4b1d8059ee0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uwk2qM0ksIfslmyNtLfLHIbAWuMP52YYL678Y/Bltx1MkgRsGtVGSRZfuiZk9ogysyXwMJvA/0oQgx/p8oO0/ZnqycMb86Z9BAxGHAj1jUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR14MB6363

Junio C Hamano writes:=0A=
=0A=
> In any case, I am OK with the feature.  I just was wondering if the=0A=
> end-user experience may become simpler and easier if we did not have=0A=
> to have a command line option.=0A=
=0A=
I think we should have the command line option, if only for backwards =0A=
compatibility.  The question on my mind is: do we default to on or off?=0A=
=0A=
Regards,=0A=
Chris.=
