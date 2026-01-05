Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F21EFF80
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 23:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767656747; cv=fail; b=ZlXh5ud+2CFAFBjEiupBhz3EnQthrGBQdJ9s3jKEyjPvuZfpzzA0rPKy5MtjjlT7ZthnHo0RpE7JMwYsRoqBr4rA+XThVR87ZkcTd9bs/Wze91Zx3rS2XLLOgJRelKNdo4LtyNkvfMtioWeQXdHb0J4XxQrSQIzO1Tnxt8oMzpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767656747; c=relaxed/simple;
	bh=Yw+dLj/IRb3MTpFy8gPenE0SD/iZVvZNFS7XipCmLhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZAelJvFrp8O8qXNcmB6ETUh1gm8VBkBVJg2wt+O/SrpaAFqI9HupIvoXSm+FlHlCoQlbJN4sd7RpGfyukfSlsxlDJKAMFQHD4HQcpgSN0z+nSCNYUQqdhN7pssBQKdM+t1HvPVhxNw++XQX0Ajdki6WkZxw1e5Vg1zhX4U9pd7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cJLwFc9T; arc=fail smtp.client-ip=52.101.52.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cJLwFc9T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WituaBJ3mHFT0pa8b1FlNSc4mWDAuDTtJ+6KE5bxIQzw6y4qWbtudvcss8hgGbfhfYyu6gDlDobeuz8ggcd8C1Piw+h7e6Jf5ngICaHOgziV3cMcneBfJHFC32Ft5bwYfTvhiSgLdNBSXT8A93BfUUL3WNhYlGobSR+vkIR573qZCTUo/ZbzcPiR7eJI/eXVnVcQfpTd80+TEtV7v0Zl/MGGl+mTGbsFSUqTNPJE7ZRXcyoiMZxLTlHGpk2ZPoDXQpG8DKYKgVi6s+rEJG5dLZ4WcF1L3VcU78EuPyhUSvsMTzfiWgt20YaPu+sc8YpCV2/AVEVuh4Ay6Jb944sTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ur7cXp8VQhoiChhAbZFAILlpdXbKredPWtHhCEdZkJM=;
 b=W4boHO2dNwEKFAmwbxH2QG3YQgxV/Sb8rIaxPpvd2t452P73DvSPP8G055sUu+iWgeAIYci9Rx8F1qS9kyhgD7U4cUwenDx/4yeMiKJFGkFH2bIC/GBwuDNFAzTcBDbC/3nXVn28NZAbavjYgL3n9oZGzlTv8MqRyCMnA3aM5ihiX9qVnaVi6ZVZk8HjfJh/GOldrHbKdpaviHKo2L+A/vcyZqumSx5lF8aYhZ3ilrGYPsEccNL/k7/ceufeUYs73up241+fZ5fSvKHS5Ul4fR+iwFAgjrM7LXGx13FlvinZCZs/QQ8XWmJW1YzXQqcDr0cdSggW2IHv3IwpQymEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ur7cXp8VQhoiChhAbZFAILlpdXbKredPWtHhCEdZkJM=;
 b=cJLwFc9Ts+GgzPTTHR6nkhJcMDfaiQ1E08ZVLRK841RH3NnyktGAzO2WTPCkN7qkOONgDs4MMov7f46dXs6TU4jMIRLfST23AHpzJj3Dsh6XMSv/czdLI7voNH14Yx9sOVBksX41UAaqDPVRMz5F8HPszAqa9fq7JW5xBOcHK+WqnvisVpGGdWfhAb6vTuFaxu7vbDfhJ76dHhBCSVMdeg6S4n6LWliGNnf1Kqun3vgCF1fVWYiA/bNNvNbjbq8DL5KVM4iArxnX/IUnQDp3uOswReXxPgi3e+0bnl3qsYwzlJh3wMWwRJL8+JCgZrhVEIRcfoPtyjFl1wH+PsGHIw==
Received: from CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 23:45:41 +0000
Received: from CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2]) by CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2%6]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 23:45:41 +0000
From: Martin Fick <mfick@nvidia.com>
To: Jeff King <peff@peff.net>
CC: "brian m. carlson" <sandals@crustytoothpaste.net>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Thread-Topic: Slow git pack-refs --all
Thread-Index: AQHcdebABRaVmXg1XEKj998vyrImTLUzA1gAgABVq4CAB+sE2oADSLCAgAW7ve4=
Date: Mon, 5 Jan 2026 23:45:41 +0000
Message-ID:
 <CH3PR12MB90260C4887067C88629BBE52C286A@CH3PR12MB9026.namprd12.prod.outlook.com>
References:
 <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
 <CH3PR12MB9026DFCF7AF4ED1A249B16A5C2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>
 <20260102074901.GD2581074@coredump.intra.peff.net>
In-Reply-To: <20260102074901.GD2581074@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9026:EE_|PH7PR12MB7137:EE_
x-ms-office365-filtering-correlation-id: 496c63c5-acb0-4a8a-48cb-08de4cb4894a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?BrhFApacr5YTvLKtYOilfdMrmhmOCupLpPt14WIPi17/X2uCTBeyPLGz1X?=
 =?iso-8859-1?Q?8p7ej9+kn8B1XSQadENC+brdciU3gTvmiBOaQBS+tX5eRUBuRdk+vNaISh?=
 =?iso-8859-1?Q?k8CTjbA764yW5MESWokCBsf22X2aneVgXt31KRhpL9I2Pz1r913qYaRAMU?=
 =?iso-8859-1?Q?8Tn0ojngyC3ina/NJ/UwhNtbifHJ9/chOp0nxtDaBryp5dihQYiyWVIyV/?=
 =?iso-8859-1?Q?g9INRrD5hqzjJeK22Ohqn5bEUwUoNH8+nfhS2/qOXCr93jVFJvph+3wHW+?=
 =?iso-8859-1?Q?DI1QOW+WLrcz8eNY+p5/ErPbJkL/umvf/df5pSbr3gIHTmTtjzXFhH/vdw?=
 =?iso-8859-1?Q?lGNfJY8VsWFSUEMUkraB4ZMCXJSaJwbzFW6gxaO6hYX/3np4CMyKTa61WG?=
 =?iso-8859-1?Q?tdNW1v8t1mGrTVdTPoEudDSdyVMQMV7x0RVdhzrHvD32me8rNgAKTBghlE?=
 =?iso-8859-1?Q?Ff3TrXiboKDeKp/iTWmfIjFcctW2wXBjhSZ5Csr0N46gWEaX0Z2kt29Sax?=
 =?iso-8859-1?Q?+TRlvtonG91VztlNe6c+ihvlkRAo6DHp8oipfp8L4LBL+KZkU9SYXo7sdD?=
 =?iso-8859-1?Q?yAMtcw094ml8fDh5FjaZU0XORrWHlGA3481aZ2tZsTgY0T37+RBF/0t0To?=
 =?iso-8859-1?Q?ggSBuCp8TThpwEkjI9j9/emKLRvMvugvKoOl/d661W42LGipdTZ3w00iza?=
 =?iso-8859-1?Q?gCa7rH8FqKzRmi+4OD9798fS5FdAADfH16tF4KQV8Py7EyWaQFnGYNrxBe?=
 =?iso-8859-1?Q?qN6eV5q8P+7kDuRoIjQXBGH+9wGImJ/xQEVLuy3JnNJEnIHeuxr/hVrPtt?=
 =?iso-8859-1?Q?QW+7E5EGT750weiAtOoj3MmKMoQnNB6ruRo89us1OMr0/oMuf4Evrpb7Cf?=
 =?iso-8859-1?Q?G7LL0kuQFPIixVaFOGULeB9Iikw+Fst58yIOWqYEIEB4UZNt9y7N8/Wqaw?=
 =?iso-8859-1?Q?fwqXpmZ78CGr6GWVj2zbpp46E3n2FRBEFtkXfgmT2DgCQPR2vsztU+iNmB?=
 =?iso-8859-1?Q?fmZTCTU7A9Dxq7OvKDWX16FPPYk6cBGVMES8EhH6Wb8XzNYDiJJdnnIAY1?=
 =?iso-8859-1?Q?/E0FXUYQf9idYUwersZg2Vjr4DCQVzry7s7UkQPdz1Zojsy4BDpiauhYH+?=
 =?iso-8859-1?Q?eqDBaqkJY7gr8TPNj7xJW/qEDGh51Z8EcLa5JQn3q3tBaH6qJiYAF5POJg?=
 =?iso-8859-1?Q?TCfyACXf0MvZ8cAy+UkFIcA84ihuAYkXGP++b04asCHhuTp2cz6X7kY3m7?=
 =?iso-8859-1?Q?04kIfhfjuHVp4fG/xEYqViJlzKdqd8x7H1omb7/ysNkGWuPjjkwTiPw0S6?=
 =?iso-8859-1?Q?eYxrmMd/HZ9N7S0h3+gPCL4GpBfJgGfDA4f8om0Z+nWNviWlxH3tMCXcRH?=
 =?iso-8859-1?Q?Lh61GBg17xuRPaEUx0vSeDxNCeBEzwSHulVOJnVmTUlBo9bWhYhnShXEuU?=
 =?iso-8859-1?Q?UOxx6LPcl/3Ity9SWw3M4ZQKEwUsBYdakTpljdk0RcuTAoDaLc4Sh3oN+A?=
 =?iso-8859-1?Q?QHkg83R6aoj9whnZIqkBBiT2dY8h1CFQcb9bSjetxBFXOh83g2LFkdvcbt?=
 =?iso-8859-1?Q?JumVKzDgp4SyrrsDNsNvPuXqbWGw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9026.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iJrYr9YruBEb9/68EoIARlMmUDRRAeVZx5qrz9IpJV6cXHRduBAoqK0n2+?=
 =?iso-8859-1?Q?KtptdqOyfGt1D+YaQU54xoj0/h8JaWEnuOIS5BcyflI5AsEEYXh3T32dc5?=
 =?iso-8859-1?Q?7GGz0bvLTkf2U1Nv8g8ZZDZHdIgxBlhP+wjrQaHxukkCgHdtbIMbCeJLT3?=
 =?iso-8859-1?Q?Gwo/3rLSlWl/OkoqrRvA6srDYfzMZEcLUVAyADbjFqh8B5WHJpsQDboxyd?=
 =?iso-8859-1?Q?Rnjz9ohSOTcxjr2+X1kPezekPfzpin9/t1HgBRfjrsPsgIm/mAUW+4Cj3d?=
 =?iso-8859-1?Q?2cWHmk7IiPtch8iIE+u6kx5we2RtK6nfaI8FVojHP4K2dTfwwAUa6+KFEP?=
 =?iso-8859-1?Q?IkVE/5EJCJ7pc/h6cXo9HwwjRA6rk+m/7hj1JYeLBmk36vaS5nl6Jl1+7D?=
 =?iso-8859-1?Q?IJHqSNsMAecsKsAsDwsPMTa4/kpy4QXnUXgbW8suAygvSoTPFjU9JiQ0C3?=
 =?iso-8859-1?Q?O56KoCeEZZdQa1mir28bywaFag8+wXMbJkcTPfLIfl8Y121ayVknz+CThr?=
 =?iso-8859-1?Q?+OvFqGyBZOakuT0arMeZSJRYtNjF+8eX6UjT6+wIOhCmgOqRvLCAnXwLhH?=
 =?iso-8859-1?Q?g2FZsKmGVNfK6rJ4aB1C12z5o99W2p2HmDVwNVAPqB6xZesc7O/YDrXqi7?=
 =?iso-8859-1?Q?vDkcWqbXicRm1jjS22+utDWissiUiTH1I0t4nyteWBMnbyPHUKcNQvHSVc?=
 =?iso-8859-1?Q?cIquJ5ofC9Oe1wy2zMGHb9x9FawDtLR7Ta5AZBxCGYbCg5lDCAJ6YDnU2i?=
 =?iso-8859-1?Q?IDHY0iXx4Do2kn5v4DR1c/OkSTpZWf4Dj2NzneAOvRwecRa/3obSa7peY0?=
 =?iso-8859-1?Q?S7oDAeNfQZ6yxDbU3sUufCe+AQ9H+y7mKWZYcNpbahGvnwtX9yfMST4ysT?=
 =?iso-8859-1?Q?29jM5/lAkb/y08lNJWw9y/Eo3cYcbtwaMXP1LKAr/nIBtkbiA+eTIrR6m/?=
 =?iso-8859-1?Q?ETwq49imKtBQrI1EPxU5GlqbXuNWh/W8rZkRDJiGwwnAWQSLc2+E3oHCRh?=
 =?iso-8859-1?Q?Tri/vgNVFRMuU2H9DqzHfZxtdSrD3zTbNh/i6PJzv1FIFhTb3oShmIGPC2?=
 =?iso-8859-1?Q?vvMZ38gVTIHiG32WasSRZKCwUcEN50sMLomeaPR9UQ3Up3KV0SIBpmhAgj?=
 =?iso-8859-1?Q?IhPASpPTuW7qTA4+/hnVsYduXus8DsnBZ4Eu3Ez7tBDwzwB7ECesJxIE3L?=
 =?iso-8859-1?Q?WWjPji0TNjiYFJZZxZx5bkn+YWPYoIklSK/hEOSUUAeyNYl5Ubn7Kjd8ku?=
 =?iso-8859-1?Q?OEY/s3afWwCOmdVxJ4BnKUCJeQuNcQGhQ25TIAhHeId6yi/+P5OoDCPreC?=
 =?iso-8859-1?Q?/Df0VlWIF/JgPgsSciQ0PRTtdHVNzGgf1kCJPICMlJ0e12ctKoaV/9cnhK?=
 =?iso-8859-1?Q?qmeEbCIdffOgIuuD2AT/fRJotG3cv0wisPJ6a5vD3hLyhoKHAvr644wrgS?=
 =?iso-8859-1?Q?07zto8q+WXwtquJdH9KkvJYBy5JTSH94bj2Ji9om6k7qVEHbuU0jSYBubc?=
 =?iso-8859-1?Q?EiW3PnI3XBQNhHZgIEe7h1ea8A10xhmGFdZ1LApCgci5cCN1h+r7E+NG9H?=
 =?iso-8859-1?Q?o+UKGXlxD9L9EBqpYtriPOrFO3SKzYd9onFX+Kcq0w+OPuHeFYpbon2SLw?=
 =?iso-8859-1?Q?potP3AcJjQN69mTXM4Al8O1FbaUS7PjUeohYfjfWaK1BrXJj82uoXLaxz6?=
 =?iso-8859-1?Q?4/wp6mMzRv9UjrZUhpAbGw1KR6AI+ghvIHdAU/5jzBLeodLHrp9JrEdHVH?=
 =?iso-8859-1?Q?ZzfPg1+cTlUJ7In01TrSjFq4/57YUW5WZcbdY6tmVhQ3zD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 496c63c5-acb0-4a8a-48cb-08de4cb4894a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 23:45:41.3803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4CyVxo6caoT4FR6rZSpz1e009TYvMpN/cTM8/5PeYW2Tv9GvpbEP6fRDzsOGKuDd0Td+mET/x6wqgdoFgBY5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137

> From:=A0Jeff King <peff@peff.net>=0A=
>  Sent:=A0Friday, January 2, 2026 12:49 AM=0A=
> On Wed, Dec 31, 2025 at 05:48:11AM +0000, Martin Fick wrote:=0A=
> > Except for the fact that repacking objects made it faster, my=0A=
=0A=
I have now confirmed that repacking does NOT actually make things =0A=
faster. I believe filesystem caching interfered with much of my =0A=
testing. Using echo 3 > /proc/sys/vm/drop_caches has helped to=0A=
get more consistent results.=0A=
=0A=
By repacking to get one used, and one cruft pack only, and no loose =0A=
objects, I have confirmed that pack-refs it is still slow. This rules out t=
he =0A=
idea that the loose object, or pack file counts were making things slow.=0A=
=0A=
> > observations make it look like it's the writing that is actually slow,=
=0A=
> > not the reads. Could there be too many small unbuffered writes, could=
=0A=
> > this write path have missed being optimized (it likely isn't used=0A=
> > elsewhere)?=0A=
>=0A=
> All of the packed-refs writes are through fprintf(), which should be=0A=
> fully buffered. You should be able to confirm with strace (I get=0A=
> 4096-byte writes on my system).=0A=
=0A=
I can confirm that my system is actually printing 8192 bytes at a time.=0A=
=0A=
> If writing were slow, I'd also expect that to scale with the total=0A=
> number of refs, not the number of changed refs (since we have to rewrite=
=0A=
> the whole file, but only new entries need to be peeled).=0A=
=0A=
OK, after discovering the strace -r and -T options, I have determined that=
=0A=
the 29K writes were all very fast in themselves. However, most of the=0A=
writes seem to follow each other with no other system calls in between.=0A=
This explains why it looks like the writes are slow, even though they aren'=
t.=0A=
=0A=
If I tally up the time between the previous system call, and each write(),=
=0A=
it adds up to the bulk of the time (4mins out of 4m15s) that it takes to=0A=
pack refs. This tells me that no visible I/O or system calls are the proble=
m,=0A=
but rather that the program itself is taking a long time between writes.=0A=
I very much doubt that this is heavy CPU time, but rather I am going to =0A=
guess that this is hidden system time spent accessing mmaped memory. =0A=
Could it be really slow reading the packed-refs file? I can see the =0A=
packed-refs file is mmaped() before the writes start, and then =0A=
munmapped after the writes are completed. If I had to guess, that likely=0A=
means that the packed-refs file is being read in small increments by the =
=0A=
kernel via mmap, and that is what is making things very slow over NFS. =0A=
My alternative theory, is that each ref is being looked up via a binary =0A=
search, but I don't think git does this?=0A=
=0A=
-Martin=0A=
