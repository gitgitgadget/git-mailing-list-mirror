Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013038.outbound.protection.outlook.com [40.93.201.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131FC3054EB
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 17:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805558; cv=fail; b=ZqD8p1urrkvM4aBdbfhjkm+dN5SR9CCnZeFVAlzjDAlIZdpUPsn08DG5Ix/AXo5f9IV8TsumYmtxRNDY0kudtYM0gST9Y5YpvjQWnO2FmN979XFIUy0MmSD8QIclmpyRlgs3NcURihRjCeiEmJ+UyCQV7Knm8olZlkj7lvI2gD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805558; c=relaxed/simple;
	bh=/sJfrllg85/PvMthjHW1jT3IGRvMHowuZ9PSnVzE3CA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U7B3ZzKcH33t7qLrTcHeviA50l30cyc60LAmuOLIihncpnZHJLM1A9xgg6ossINmkWHlNuvPO1djgBbqJxlq1SKkGDoohX0TnROH3FVK+AVFTUiIswup0+qSY3o8EfTWYocFWe2AJ7VBiZ8gqNttCD+VCsSTyGMss78xZjgUKoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VkMmgZxR; arc=fail smtp.client-ip=40.93.201.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VkMmgZxR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhLGVX3NIAAd2vJ+l+n1YyJ0BO2he9WGPEEJtXovauR5afOf+lrb6vasg+KepAZCKBSuaZAtgUcFBw3AAi+LTBNKFR3FKqhsqpuUl8Gk1sfxi4cl/CZ3ib4ApISMa5IEW1inItBIECg/YzXh/lN4sb0RdM8IVYYM0YNegt+jj/nApqtZeMPug4Vb0yv4tHq1ckHigw7j4VfdWRetiLbsHQ8UD9Vk0pxHbPueAl1aHIwMmZ96dQH0sNGXrA0SJ+2FB3RoYCceG7PF1SANPUvCCpDA/cPnjDzOEFOvejIC/KwKGU+8ATr6DYTuuzlFSqsshg7av9OaH4puwlEyW+b0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sJfrllg85/PvMthjHW1jT3IGRvMHowuZ9PSnVzE3CA=;
 b=KzNvXEu/Qg+E0x0UnzBhIovxJvdkcOMjPYVPTvVF+4BZdaj2s4o49Ifh6xEZCc4ddLPc+ebFDNnkKN7N9O+zA8CoJjGmV+ifhBvpHt+65gwUQwXwY/5DCdMHu7pE3zSbBviaL0D80CF+rWVlOA4B/NutGhwVhLgdRu+tpNw21IPKB86ZCT6+VnI4nTSN9UzjfetsNM5KoDwEPGbto7EgKyKessyIkj9TXVc8pt7EN4zbvCfRV8kMJRn4s47ryHBC5DzZ5ghCRlkgpLgggVszajdaldryfspflgHT9XmxCZXyIBgUkjK7aYCqeAGaC6OIRZ5OyDpMhQVqLLdJPKJVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sJfrllg85/PvMthjHW1jT3IGRvMHowuZ9PSnVzE3CA=;
 b=VkMmgZxRmZNmGPsVqrmpBhW+qRklcm7aS+PKlqAnxwuQTmsiQdMZV0sVbJRLMdOp3PQW4l9FiIWaARfY7FKOU6HnW5qKbq2I0gFicFqler409l+5PYxjELIaecZ7gW7lEDc4nlxRSdxRHjVEtDP/7egvZIYxMGr8j+mc+7Sutq1ylmqdBHYOX8YUWDZZqx5tZ+PTwgnOZlaPM6781LeNpV6yguY0c1OiB9cm7f/2Glc+YmxwjQFhRibOY2TSABolZn81rq29VKl2xq4XPnSxGtg/VoOnapUQKWj3iuJtYR3c6ForacyqBA8fKIuxnnSJoGVJnJLH2bS8DkTniGksxQ==
Received: from CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 by SN7PR12MB8057.namprd12.prod.outlook.com (2603:10b6:806:34a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 17:05:54 +0000
Received: from CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2]) by CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 17:05:53 +0000
From: Martin Fick <mfick@nvidia.com>
To: Patrick Steinhardt <ps@pks.im>
CC: Jeff King <peff@peff.net>, "brian m. carlson"
	<sandals@crustytoothpaste.net>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Thread-Topic: Slow git pack-refs --all
Thread-Index:
 AQHcdebABRaVmXg1XEKj998vyrImTLUzA1gAgABVq4CAB+sE2oADSLCAgAW7ve6AAH4YAIACPJYi
Date: Wed, 7 Jan 2026 17:05:53 +0000
Message-ID:
 <CH3PR12MB90266A2B11493D5E02E90D02C284A@CH3PR12MB9026.namprd12.prod.outlook.com>
References:
 <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
 <CH3PR12MB9026DFCF7AF4ED1A249B16A5C2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>
 <20260102074901.GD2581074@coredump.intra.peff.net>
 <CH3PR12MB90260C4887067C88629BBE52C286A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aVyxbqk-2QQIgDXK@pks.im>
In-Reply-To: <aVyxbqk-2QQIgDXK@pks.im>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9026:EE_|SN7PR12MB8057:EE_
x-ms-office365-filtering-correlation-id: 26281bac-3683-429f-1081-08de4e0f040d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yUYk30MSxKCgHJAw1MwCIP/XwwwJo/1bSTKSq8BwTihnS9sNMAVPHOjWek?=
 =?iso-8859-1?Q?qU3nXj3bWz8WtfKAdhs4E0E5Lpba5vf1tqRxQV/ScmOyd387T9li873zkp?=
 =?iso-8859-1?Q?forHqeguWZ8f22Hmk5G3czgeGayC1i2zsbflGbvqpvx9BpEXhnSQh/Kow6?=
 =?iso-8859-1?Q?BIidZc+bHPOnlGbkRRibJVwKBC8tCX3sKBek583Q+AVuu68exBCE42/TlF?=
 =?iso-8859-1?Q?WXQxH0F4GHVgvTo71Ixa4CGbay+SRJr1/sJX6VB5mpf2LWtt5Zlts4q6x9?=
 =?iso-8859-1?Q?EQiMcsiJVQxjMBop05ObdadfuHSA98TzVOup92LLlFP8+BBAE0Kmdi+3XY?=
 =?iso-8859-1?Q?VKXtXGK50bxtlC55dFZuC0A6FbSCqVJltRQEFS+JUUs+ZuFtdhq9DK4s51?=
 =?iso-8859-1?Q?m07EaRJBZU3K0OvNki4IdpRJlm8y1y6AsWgqC+pD5nCLu0ik/6Lj25z6c7?=
 =?iso-8859-1?Q?KlXllAvRxtruuUqgynZ+RUNOhWzeCs12JJfIyVvwYAUvLc9HWczXC8AqeA?=
 =?iso-8859-1?Q?u32gjcm7kFC4tr2z7LMW0cy4mTJglCLZhNL4Ns7qID3VU23OczQhJbur+t?=
 =?iso-8859-1?Q?ciurbWlO1kjXlgZ3NlekOGeJA0mj1Ypma3FnE1QdxYnA8kvDWQ/9zSEuI7?=
 =?iso-8859-1?Q?0ThqP1ZPk5cBZb64lD41TDfn3zXo/O4H+vvyspLN9Bs0ziFuvIwIXFEiE8?=
 =?iso-8859-1?Q?EIdXzJ+JjwjnQiKI8YgUJ7WLu/Ai8D2K3IepY3UhO//7LcZw7mJhSTTYd3?=
 =?iso-8859-1?Q?DFniM8zZkV4kUPAMt0xh34rvou2ODs4Ko/wx5cVJ+BRvewgMr3P6CfDSL4?=
 =?iso-8859-1?Q?SrtCydNj19Ly/R88AQMlkVkZoZGiyWf7TvKQ63b5HhJHdh0616iD5fEEiA?=
 =?iso-8859-1?Q?aIafeBEo0pLwyPpKlwPNGP8T9OexONZ+COmFQljigDAwNLy0OVyaf7J632?=
 =?iso-8859-1?Q?1QOk7amuigvNuda5glY6BsSSnIicw+QKqM0zsGUfxvoTWv+9sYDgcU55RD?=
 =?iso-8859-1?Q?u80igX8U1X6tVfXDsO08K/URaDeKsPDGpp+XVUobjE+C77EoLVsq7kDnyK?=
 =?iso-8859-1?Q?74jbBu1KHoo366MqYUsingn4EhQ5X51pr6nqYDZgcPLu8YscKR0YIYOSCe?=
 =?iso-8859-1?Q?/suXunoSvjuX8bLPI16+MlwuM7v8gCX6zSh3ID7wvfcqEXX963iIx1ko+S?=
 =?iso-8859-1?Q?/pxK6Bgoo9RAp+8/EhCE+pN3W++2kZXiFWdSrjW/T0GQjK7C8UqjeP1puO?=
 =?iso-8859-1?Q?yFW2cWPgXr+fjmacxKuWnop33pfh3GK17p7IB69fAxBZTeEHc/pd+JKSGS?=
 =?iso-8859-1?Q?czM4IMo5uYA8LTH66oZ+KTCTNtI3bFwFlmXGZG4vQ2+FJz5zTplNW7ORaU?=
 =?iso-8859-1?Q?liElNcuH74szmnnKJN3Y8tcBKj4aqAAUo2aneQ13/LSgZzn9kit2q/1tzS?=
 =?iso-8859-1?Q?2VCW5HY4Xy2Umg9cCHJ7ICXsM9G6sgSVzvws3eAIKuHAc90V1EhDLr93Id?=
 =?iso-8859-1?Q?nVE9rfk+VIAPKtj+u2Dyrbcn0zBip3ZCPrToijSlp3sVtJ/7cYaexqqO7n?=
 =?iso-8859-1?Q?Pskx1Dfa1rxEfe7CSDmiHCPgBMW4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9026.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YgcDdUV/6tX9D5VDfjJOPJdmuV6AqjMMLaSpstYQyoSsdDCg9VAlqCjmg1?=
 =?iso-8859-1?Q?E7RZX0aF6qqAsGGSVoX6LwS/LR3C/9c1KSBeJAim3mtrsdE0By8JwoLdPT?=
 =?iso-8859-1?Q?hqMRISUe6dxVlIdYgBShh+zNJG2f5tuH8HI/2R6XUz6iE5Klc+wA0C9Jvy?=
 =?iso-8859-1?Q?Yo8mFhBff3OrF9v2XhWud7kXaL8Tg3YfRjqHZCwX2Bo+tKDeQw9UPXLOvl?=
 =?iso-8859-1?Q?yXmYjj4LdsaTimUmHXNvKTt+VbVvcIpEbLdngVk24syoHSGLEyITvrReFP?=
 =?iso-8859-1?Q?s58PqAXMYiZRywqAJSXJk8pPjT3FGtN8fNUf7BpctiRWWLeqGQ78Mmae3S?=
 =?iso-8859-1?Q?BgdiFxwOgx0QXpdp43OomGCHH5q28suvnMrnBoTgDXoOAsJGMOOFOrzm9d?=
 =?iso-8859-1?Q?6mmQyyvpDgc4fqrYGFZT5kmWnkgpZ9Qf5NmOvYOd/fHqD9IRdPDZ4nkqRm?=
 =?iso-8859-1?Q?jPjhT10Z4lYrGn92ITJSjC1FROzN65wJ+4sUkPYBEIDx7C0oSThyajizSu?=
 =?iso-8859-1?Q?ap+bO92WHoRdLW73TpPOu6ibfZpZUlAAXISdr2rBluyAtEAFMbVxmEM+5F?=
 =?iso-8859-1?Q?lybHrryNskN7ZWP+U4J/21BK43ljNADMvmP3eqQMES0qA2Vue3QZHLzbH7?=
 =?iso-8859-1?Q?nk3DfeiiPtcP0JRMDcj5cBoNVtdrEE4C0+nYMVZo13uafjcV4w/RH53Lx2?=
 =?iso-8859-1?Q?euuxlbsgZnPLAy1/kZIwHe6fW92lt20IzXhiEL5+YxVn4JvN+1I1/1vOSd?=
 =?iso-8859-1?Q?7475gS5crUNpNWl4huXXilQ7GUfv1EHfHd9OjxWBHlKxHfKTow323bUGmJ?=
 =?iso-8859-1?Q?1Pa74egxi0Tk/Moz/uE9RMG8Ci/3jruAHSBpN7uTyWILLH62vqLKInzLHt?=
 =?iso-8859-1?Q?zNBlLgFxicjJ/Qu4CdaUN1kEKFtA5ysr9G7ov7owo0hbiVWc1DGOGVPBBv?=
 =?iso-8859-1?Q?ZXRf/3VdKrxvyur5LIDXVXL4VGwWcYglOH69FBM7BqHYMqMRIW1AXTdcae?=
 =?iso-8859-1?Q?p2kSiCck9d2MSQr42/QNNvTdjlOy8bjSOCBo+OR6NieE0iN28LCIlSdsBn?=
 =?iso-8859-1?Q?UiKuaS1jijMLpmpM9LetpsT1iGAaTM+9rIKwt7JrgSW7eyiDsNlN9PYVwO?=
 =?iso-8859-1?Q?Lu6111x6XvNbxHtUVtvlY+1kjYU2BdOEvp/cRccdlHDvkwvtxzdrBU8xLX?=
 =?iso-8859-1?Q?HDFLLkS8FYuQAabgKvghahGXKOJkzW04erpD4uP6tE3twdxSqb8oXMaRK5?=
 =?iso-8859-1?Q?8lay6eBtTte4BfQwNCmYp7+iv8RZNE82UChPJTVUN/ciwY2zN9NkjcvFu1?=
 =?iso-8859-1?Q?+0yChdpdy9sG5dpcK11xLeARncCKdQPJarY8vZshlELMcp9/hhdqtZHvmO?=
 =?iso-8859-1?Q?ibFm4X3jRtTF88MpFxsi/l/wbDCK+MlfMBSZqC4ri6zsT09ErbYcw2ty8F?=
 =?iso-8859-1?Q?AGJaGj2vCIKTvCVJkSmLo4kmP0NjTfPUrNfN/Ssg0A4H6SGi7jBMJvN+Rn?=
 =?iso-8859-1?Q?0rraXyej2K3Y95kHojV7US0MQES8SDuhy2JEuyP2AdBmi4gmBgjxXOOZAS?=
 =?iso-8859-1?Q?naQosmP0EKhkZCFWXHrfnTDtKy2jGkrAJ95K4aR9tY89YCMhhX5vwRCcJs?=
 =?iso-8859-1?Q?fcmHlBophkcUc3IKwkFlFvxMOpZhibkP6tVMKlKhzfwM/7TsWX0vpkMdnm?=
 =?iso-8859-1?Q?R586VmUBWPrE2Y20ptFV1pLDw2MM6O/hNd9FQWNEEBCWgp1ZacgL1FskkC?=
 =?iso-8859-1?Q?WjrlCzkYDTpkxdJhhwpltG+p9rhsv2L43bWTmt3dVCa2fv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9026.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26281bac-3683-429f-1081-08de4e0f040d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2026 17:05:53.2320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n3vAfnyVSxXVD+UykVjVLTh6NCVXVnbdbYOOK2pUxU1aTJ6HDftwcNhXyd4yF1dBdk8BX9SHTHSQUskzIzYLKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8057

> From:=A0Patrick Steinhardt <ps@pks.im> Sent:=A0Monday, January 5, 2026 11=
:53 PM=0A=
> On Mon, Jan 05, 2026 at 11:45:41PM +0000, Martin Fick wrote:=0A=
> > OK, after discovering the strace -r and -T options, I have determined t=
hat=0A=
> > the 29K writes were all very fast in themselves. However, most of the=
=0A=
> > writes seem to follow each other with no other system calls in between.=
=0A=
> > This explains why it looks like the writes are slow, even though they a=
ren't.=0A=
> =0A=
> > If I tally up the time between the previous system call, and each write=
(),=0A=
> > it adds up to the bulk of the time (4mins out of 4m15s) that it takes t=
o=0A=
> > pack refs. This tells me that no visible I/O or system calls are the pr=
oblem,=0A=
> > but rather that the program itself is taking a long time between writes=
.=0A=
> > I very much doubt that this is heavy CPU time, but rather I am going to=
=0A=
> > guess that this is hidden system time spent accessing mmaped memory.=0A=
> > Could it be really slow reading the packed-refs file? I can see the=0A=
> > packed-refs file is mmaped() before the writes start, and then=0A=
> > munmapped after the writes are completed. If I had to guess, that likel=
y=0A=
> > means that the packed-refs file is being read in small increments by th=
e=0A=
> > kernel via mmap, and that is what is making things very slow over NFS.=
=0A=
> =0A=
> ... Do you use any special flags for mounting the NFS filesystem?=0A=
=0A=
Oh sorry, I forgot to reply to this last time. We use the following mount f=
lags:=0A=
=0A=
rw,intr,retrans=3D10,timeo=3D600,hard,rsize=3D32768,wsize=3D32768,tcp,noacl=
,_netdev=0A=
=0A=
-Martin=
