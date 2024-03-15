Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2108.outbound.protection.outlook.com [40.107.212.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0179E4
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710493120; cv=fail; b=HXqsAkSIEMxKadEajPul571SI9kdNcpuu8FCG1Rzy4zNJRt1d/BtZhJV5BkheCF1z6Q3IGJ5NybGZ8PxdY9PeeiZNFeaOTaP4hNzqKce/FIOpG/LhxjidFJEc9r2SGoLWdNMU4hH79ZzqO5rqCcA4YdaMBqBxn9RI3OYODsHaYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710493120; c=relaxed/simple;
	bh=lKmKTFNw6xZu1rttrC+c0lxO+0rPdlrJCKOAll0grkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mgx7XBLAPsy3MU9dtMWCXUpclHUrC+H/mDbUXlWuR02SgGaBau4tyOK4T2jhUtJgeHSwJ+jdqg39UxU/ARWqwBN5prD20AR669VT/Q+hrUojjE9/hJhBxkv0qtX8Kt6pswZWVDUrF+MXk8MmqwHKlHD5uV7Lo0vQ2ZdWy7wLT0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com; spf=pass smtp.mailfrom=webpros.com; dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b=pjVtQxkQ; arc=fail smtp.client-ip=40.107.212.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webpros.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b="pjVtQxkQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzg8wH91+BvPEWo2F07FPJMVh4mNuBZLOagC8wKrQAuDeJLJRNy0qlXgOD4Kq+2ToB3Pie2zPmYCL0gtJKmOfnEojMPo4ZMCYtjSnCIT8ITPRk20TyBsWgfySnz1cH7GxxWbUPhkd3faAqw+rIz3sGvDkVUuoPZEkdmWuJXSdxsnwyhhEPfLOJZH9lakU+/BP74+stPOBsDguABuNfM6EZpq2s0pQRoTfinhDlKe0kKk7jl0rQna4atwcRiABqbkU2lLpx1UvJRPrBEmwL1ZVxUz+8nn3BHq3hnlOALe9y910G4NdsCjabXlNA2nFC0KMWyvhagyrBoWamv2qBuBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOVEhL6F2IUNVEsmLGIs6r45zn9tL2VC5aw1l4zg6DU=;
 b=VDNoT8YLShSnEjzhcvxEduMVR0lxYixXf+mLoj0w3FvHi5Uwt4JWpezKmibAqVQwkLiFqqdJLCywuww7Zs1iAl2+eO+Rt/k0vPuxT4I/jx0/szBJO6Xg10RGV9tdO3lppNwco7TnmnLxcq4BanaklKSyrN5DWIYzFiPiWnoUCvzP7UHwcgMA6cPRWTmkQnx3VOtR0edpEJ5wK6oZh4TE00pCsorKzr9382LTwl9l6rDwcgxz3k9LgsI1J5C8ubCMdEOYnyy6PwwcrhZ8MfSq8YtjipqSBFS+aTC8ztgqrVCfPfGUZxijjnbcoSW7m76b12kC1+RVkkLxKZ8DnoANog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=webpros.com; dmarc=pass action=none header.from=webpros.com;
 dkim=pass header.d=webpros.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=webpros.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOVEhL6F2IUNVEsmLGIs6r45zn9tL2VC5aw1l4zg6DU=;
 b=pjVtQxkQEDu9v0JNkjMTocUs9auSAqCCHBhqSLtvGtQ7uKvpFvAUb6CmkgbOIlaESEoBxdKMW+BgCV3EDUmidaC+MjLq1yZiy5MA9gwX0bbMUZXoXjBpEM+xSxP95Nh8tfXimbBWtu/x61AeVwqgtlTEwYjUejXw6DjprARLWXcVThw7LkvEFhODnFcCN4J+Owma5rvwti7vAdZq3sIJueCQj7wsyPL3jHPxUbBUuyaHAaQErnukhHODEOD0/fn/GJKSPDVKmwA1GJOq/zOqezyleWUNjjgI6RTc3eXvtCYxSGn8klbSWO6CyBocpOS/PHPTbrG6t/DYyPgX5Aj6oQ==
Received: from SA1PR14MB4691.namprd14.prod.outlook.com (2603:10b6:806:196::11)
 by BL0PR14MB3809.namprd14.prod.outlook.com (2603:10b6:208:1c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 08:58:35 +0000
Received: from SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00]) by SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00%6]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 08:58:35 +0000
From: Christopher Lindee <christopher.lindee@webpros.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano
	<gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Christopher Lindee
	<christopher.lindee@webpros.com>
Subject: Re: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Thread-Topic: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Thread-Index: AQHadLHezsdN01rhbUOhmHwkmqTtTbE2SreNgAGRaICAAAl9poAAE4AAgACFF7A=
Date: Fri, 15 Mar 2024 08:58:35 +0000
Message-ID:
 <SA1PR14MB46911007FDFE3FFADB4FB3A68D282@SA1PR14MB4691.namprd14.prod.outlook.com>
References:
 <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
 <xmqqa5n168nh.fsf@gitster.g> <ZfOAdVy9_UfTj3zE@tapette.crustytoothpaste.net>
 <xmqqv85otmsb.fsf@gitster.g> <ZfOYxnRHwyFdU4Y3@tapette.crustytoothpaste.net>
In-Reply-To: <ZfOYxnRHwyFdU4Y3@tapette.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=webpros.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR14MB4691:EE_|BL0PR14MB3809:EE_
x-ms-office365-filtering-correlation-id: fa2a16bc-6b1a-45e8-6b60-08dc44ce1909
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7OHenYoNNkBTsV+IxeCV606i1nSdR8xqWug1rIjY9M1QedWS8qoDWTXs8tCazTa85+XzvM/StrrgZuN68Rz8NFIBu/lVsyInIKGVvIklnKs697rxBMH1uwfYGw/mhQFeJg1n1+ZVHZKy5vj+GYd7s36Ysm325Ln7r6tpFudFeP8zWEp42ZkDXeh9oa074Zl4SkL/hC2zypDDuU5eWS1Ytco1gu8LKfoL/A/4yY6NTEol8HPwEuLedU1f8iReieIoIxlx7S2oOSzl0oxZcoHraS40oIfKyjSgcHZR8YgTjCucE/dcGlRcJXJIvOISjQqq43gy0eBUo4JOTOVChDqQV5LAT+HBrNhCmZvao0/mmtIVkodX5wQXHFKAZcPbhFWNGoPfN1n9amyl2aYNGYntIrv3sr5TezLmFOlmqz1l2HKpRGk9sEbHvS+7NOiEJcviX6QXjgo9rfFZHgmgUXkeUHaJjT5wV2ai/n7dTDT8geaRVhjkxM2iGpECaUTpFRuAf0yeyGnxI/++ZL0wLFpcR3xt/GUW0Ggw+zppNdCaJdMdPEcJpSePZ1oy0G10s+5PhLSt+FQuWZBMhyesbkhqzPhpd0Jno/MMMY+SnKZ89ndnDZp8xJQEiVkHpPc3PX+AtKSnNy2lmedPttM7Ez0oNtia6BcMskw9cjOPVopg2uI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR14MB4691.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?S8qa5gol6NaZqfNcazgU6r78ZlF8qtG9zpSjuzlZJ3CGZD7n5LazaQ/Kuq?=
 =?iso-8859-1?Q?8mK/31H+oypUIJURpBCNCmi1pYGjwECMDT0WVHpATXM+RM065u7Lu01g3e?=
 =?iso-8859-1?Q?5Xnd9o5WrgH9h9gUEWas5JQC8eNrhVYlhtMjqnzpuy63HZSZwjThR68Md2?=
 =?iso-8859-1?Q?RgfZrF+1V/yLJFz13BJuu/0Bpa/5V5LMXlL2H8wnZ7afFYUm6e/wBve3m4?=
 =?iso-8859-1?Q?W3GfpQsIyQY07zOsDH8+lmG4RwJoi6kTMmlDdE4uSo4jOBBNML0mA3NJPO?=
 =?iso-8859-1?Q?oW/iwwKpiT204laRE2pnOeKqQV69fpwh1gfqorKGPuwf66pmTEpNYOqT2c?=
 =?iso-8859-1?Q?ZsxciRAmfEuTWHXU/iwfvYORRkPEwj5tR2Nhg1mitO4Acr7sYib+YWwtJC?=
 =?iso-8859-1?Q?at37YphLnti+qVnYL45yncgy/r5Ky6b1IyssKC5DmGgJRtRiq05ci/Oh25?=
 =?iso-8859-1?Q?npJlMivo/qZpCcDUHvXS4tbktnFdO+oFUc3f3Xzcy3p7qZZGVTHjV23xkL?=
 =?iso-8859-1?Q?ZlTpEYYWei/4WNhz8K7CXPPbtXjrrBh/Gipi1cmXthYZxoKExNbhewx5Z7?=
 =?iso-8859-1?Q?pokR5jih6P9FUOtjpaxd/YlNw73+O7TSGoTFhFcN9D532sZO2BMU1Udktv?=
 =?iso-8859-1?Q?JuKLLkm3e5FVMIUQOgbVjsIgi4YtwCbDzJMpxAlVmDdjgCyEUSmw0K/d8e?=
 =?iso-8859-1?Q?IZCjeFcckG/LMUkL2qpgWOj9o9j07hONL0A7Zdd8P/i+eil/L5ST5DoF6x?=
 =?iso-8859-1?Q?nEBD9RdLx7M8HaEp4f/0daxPqDbW3vsy7ftzLXTozhOL77UJc0BHmMyvLm?=
 =?iso-8859-1?Q?rYXtiDYphYbS5Y520PDmOu/342BbFJVKC5KVzTdRBUuyekD4uMKmUXUvSy?=
 =?iso-8859-1?Q?UyPwBpZX4WggjKuBk5x4Kxm92QqcIJXExDpfqreZxRziZbJSlnCqZA685r?=
 =?iso-8859-1?Q?TC/wmiHqoFBEIDFaaX36dOTaryCCPFbJP1TNeV6mRMd1JqqCb1hv21SHFX?=
 =?iso-8859-1?Q?1OHmiO7hIoKUxmRIZuI2P7wyXoeUQ2uhqYhAbKw17DWLH22uFG+eayoCkm?=
 =?iso-8859-1?Q?xkkocwx6DpX5jD8wOlIffnUQkFcXZpmaQ9+45LWaUzWebZT8pHzfbl2yo3?=
 =?iso-8859-1?Q?62qreHHh9dgBeuZHkqhoP5zAv7IKWwhclHzv/WTvdH3FnsN4kKxK4c2Uvi?=
 =?iso-8859-1?Q?eKxGcbnOWCeyyRByZniP2hAlUd8Zz/OgKnHmF2fhXS0Y4rgOx/fB8LCWqg?=
 =?iso-8859-1?Q?XHyx60OElsQku+0eTT+V+MEnAFF4kdKf/r+vzKluhzfD7+eFmthGd/JX50?=
 =?iso-8859-1?Q?wX9lVfLKd2/pskeZTort0WlqcP5+b+7lnVo66XUQhW8KNsKVW93t8T5jEk?=
 =?iso-8859-1?Q?Rh8Y1RupOnHnvexvbSR+bcz5v7FNyg/JifPLoHvH0z/I5f7rTNUvlutBOd?=
 =?iso-8859-1?Q?Gfq2cCiZjXEAjR3pmzl77ARroDoc38+OAmxVhN5yUiHN6gTrZn7HKrCEg2?=
 =?iso-8859-1?Q?xoJNXn6dTTWAZx+N4CJC23vod0iihqYBVM/ZtTKcwdyzNWDDMq6wHXLEga?=
 =?iso-8859-1?Q?PUJWt4JQ8gDmunByKdRvRsFZuUV0woMTjwB+nlW1XoCOw5xvKx2VmEkZWO?=
 =?iso-8859-1?Q?owNAKE/+FVkEzKoBDqdC1Pm3EuRNgDFnPKdYNELhgUcMSUpaO6ZPOGyA?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR14MB4691.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2a16bc-6b1a-45e8-6b60-08dc44ce1909
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 08:58:35.3323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8497356-a834-4060-86b6-d4b1d8059ee0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FyROmDkRq9GfEZJLT0Za5chx4r8F82TuY72BXRKBZAMfj8uZgjGdG7lSLDV3dvEN3dfOIPb9jaUo1BLP1uPRehnvYpSb0ugmd8X9xigkGY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR14MB3809

brian m. carlson <sandals@crustytoothpaste.net> writes:=0A=
=0A=
> On 2024-03-14 at 23:29:40, Junio C Hamano wrote:=0A=
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:=0A=
> > > As a server operator, I also expect that there=0A=
> > > are people doing lots of needless attempts at pushing in automated=0A=
> > > systems (because with enough users, there will be at least some who d=
o=0A=
> > > bizarre or inefficient things), and I would prefer to avoid serving=
=0A=
> > > those requests if I don't need to.=A0 (For example, for us, reference=
=0A=
> > > updates need to go through a distributed commit protocol to update=0A=
> > > multiple replicas of the repository, and if there's no ref updates, t=
hen=0A=
> > > we cut out multiple services which we don't need to contact.)=0A=
> >=0A=
> > Yes, but if you have an extra no-op ref update in the bunch, that=0A=
> > one is excluded from the set of changes to be synchronised across=0A=
> > replicas, no?=0A=
> =0A=
> =0A=
> As I said, we can't do that, because we have to verify that the old=0A=
> value is correct.=A0 Even if we did perform that optimization, once we=0A=
> know we have a write, we have to contact every replica (in case the user=
=0A=
> does indeed send us a pack, which is allowed by the protocol, even if=0A=
> bizarre), whereas with a ref request or a read, we can satisfy that with=
=0A=
> a single read replica.=A0 I'm sure I can satisfy at least one to two=0A=
> orders of magnitude more no-op push attempts with the current=0A=
> optimization than I could if we didn't have it.=A0 It might even be to th=
e=0A=
> point of three or more orders of magnitude.=A0 (My guess is that reftable=
=0A=
> will improve this even further, but I haven't yet measured.)=0A=
> =0A=
> =0A=
> I'm sure this is also true for most other implementations; serving=0A=
> reads, like ls-refs, are almost always substantially cheaper than writes=
=0A=
> and most server implementations are highly optimized for serving large=0A=
> numbers of reads due to CI farms and such.=0A=
> =0A=
> =0A=
> > > Note also that no-op ref updates cannot be simply omitted on the serv=
er=0A=
> > > side because we need to verify that the old value for the ref is=0A=
> > > correct, or we need to reject the operation as out of date.=0A=
> >=0A=
> > Yes, but isn't that something the user would rather want to find out=0A=
> > earlier rather than later?=A0 Your push without no-op update may say=0A=
> > "ah, we are up to date" when we are behind or worse diverged.=A0 If we=
=0A=
> > do the no-op update more often, we'd have more chance to catch such=0A=
> > a situation where the worldview the end-user's repository has is out=0A=
> > of sync with reality.=0A=
> =0A=
> =0A=
> Well, we were up to date at the time the ls-refs operation completed, or=
=0A=
> the push wouldn't have the same old and new OIDs.=A0 The client has to=0A=
> declare the old ref value that it got from the ls-refs output in order=0A=
> for the operation to succeed, since the server-side Git won't update the=
=0A=
> references if the old value doesn't match.=A0 (This is how the client=0A=
> knows whether a push is a fast-forward or not: it computes it, and if=0A=
> the remote side has an unknown value, then it's not.)=A0 Other than=0A=
> updating the push options, there's no functional benefit to making a=0A=
> second request, since the ls-refs output already told us where the=0A=
> branch is.=A0 That's why the current optimization is functionally correct=
.=0A=
> =0A=
> =0A=
> In any event, there are alternate implementations of the Git protocol=0A=
> which did not implement our current optimization and did, for purposes=0A=
> of mirroring, make excessive numbers of no-op requests, and we did have=
=0A=
> to ask for that to be fixed.=A0 I assure you, the no-op behaviour is=0A=
> better for users because it's faster and substantially more likely to=0A=
> succeed (because it is effectively a read-only ls-refs request), whereas=
=0A=
> a new ref update is less efficient, slower, and substantially more=0A=
> likely to fail (due to functional limitations on write throughput).=0A=
> =0A=
> =0A=
> I also expect there will be poorly written `pre-push` and `pre-receive`=
=0A=
> hooks which will not like getting a no-op update and not handle it=0A=
> gracefully.=A0 I'm pretty sure Git LFS will handle this just fine, but=0A=
> lots of people have various shell scripts that probably will not.=0A=
=0A=
Is this a potential avenue for DoS?=0A=
=0A=
Clearly, I'm not the first to send no-op ref updates, so this change=0A=
doesn't create the problem, but it could allow non-coders to exploit=0A=
existing problems much more easily.=0A=
=0A=
If this could be a problem, we can take the time now to solve it.  A=0A=
simple limit on the number of no-op refs received before the server=0A=
terminates with REF_STATUS_REMOTE_REJECT should be sufficient, right?=0A=
If we bake that expectation into the official Git implementation, then=0A=
other implementations will be empowered to take similar steps.=0A=
=0A=
For at least one service[1], GitLab only supports Push Options on, at=0A=
most, 10 refs.  If other server operators have similar limitations,=0A=
then this is an easy bud to nip.=0A=
=0A=
Regards,=0A=
Chris.=0A=
=0A=
[1] https://gitlab.com/gitlab-org/gitlab/-/blob/master/app/services/merge_r=
equests/push_options_handler_service.rb?ref_type=3Dheads#L5=
