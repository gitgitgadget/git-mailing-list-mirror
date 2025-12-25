Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDB31624C6
	for <git@vger.kernel.org>; Thu, 25 Dec 2025 22:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766700842; cv=fail; b=XT32KC66XXaSF4QWYuiv911l/xN4Qg3/NcuezniYH0NTyfFAp6wbvKCo58zF0vzEiSfpg/a+uIBOMf37pFyyiBkn9Do7oudwf6CT/INulYmrNbftf/IfFwsHtEvyhzB3vWzKmPxVlXlLI9UnW1M13VRo2JN2JoNqJ7v8dDtilCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766700842; c=relaxed/simple;
	bh=/xp9WIeHIUWjDSJYdY1aAvT4jnLyaf3p6RNEJcTh0NY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gLsmh6IkPwYtGFioZp+JFS8XQmh8jYckyPn6wrZsDn5Bf+tx9WGs6u0/gnocOW973++Z0o0XPIBcx0l0fr0sAb7GbF2XkJK+wAKamQfn5esmtnAbsWH8GKTF8GnQmasofl/YeIOHM6K3+WGwFV4eAZBTQIlCMZoW4ahfdBVzJfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AAOx0NKu; arc=fail smtp.client-ip=52.101.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AAOx0NKu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hR12QjZ2WhTbfWNZpTwipvvuih2tlOhC+nlKSkVr9qUgQ2KuKJ0Nh49SUuspdqmfHFSGKQXMKe4j12MLf8lbHddeNt23jmy0G8xP8SzW8waqWWfg+meeUr7XhLJRd3fE4i/18w3sdDvHotdUYlwmC8rktqtRLn6jb/Jnefgi+Id2lhD2Asa3/j6iXv0QjgpzLaWRaeEA9cQp+gspgUk3aOILb3dFvA7UHRU10TrVYpDwjEpUJ77E8mvhJdvXaHELL6IRHOTJYdVs53DZ6KIDQyO08cP0R5BhJu5+CXSpQ04TcD052+hUOVbOD7mQqBIqeK0U4QTJwuvTgl/uPLf3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xp9WIeHIUWjDSJYdY1aAvT4jnLyaf3p6RNEJcTh0NY=;
 b=nweJqyRv+/AEgKjcVlzrlzI1iUvdBH0QpGN+SzqaCBLtZlL/+KCjxOQK5FYeX/M9ZroF78WRxFNeR1XMSteuWfHERuNqtqzQVjJyAS4vP4VZcfqZ1v5eo4KW9Kg5To4IfRcc8HdBk0C/XIGyTuKJrJzJJJFsZflD0clm7gau6G02JR1ePUhpCWfAydOsn1ZJZMb0u6QJmmY0CeZiMTdcTfcb7HUSZ/4McgvH3v0VtJ2khZgXwf4UzscM78xjH/YLOraGM/oLvmDPKSAU7A9gJS/Mj1E8F0DUZh0zoW0cNbO7SxXKnu+f49WZVRyWVpraUYsaF4XGqdUiFaYFZi1yBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xp9WIeHIUWjDSJYdY1aAvT4jnLyaf3p6RNEJcTh0NY=;
 b=AAOx0NKuAaqE10Ij+nm7FlIY78izZCFNmauZqqa9I1a5QT0hQY7CXEfW0wB+mJZQEV1uKTSaq4WgUMNDzMGFCAhA6KVycTL08CWz63GOTSXcWKNe7xp8yn/whgCq5prQ1msAbrYw0rtpFMI2szyt3W27gj7hdgMk5EYTRBJ5k9mQpksFO1RCrqdmynnlEdtf35Q2DeLaSlK837pBsYqSZVYvfpJeRWiAv2p19qUFb8uycSpx26NGDvngKNPzoiqkba04uX/J7UL/JnCyR3d6aIqrhVYXuRGun17+JCQlCG2qJnT+Xq18VxURqG+7FYiErWpsvq3UF2Nb00zq1qGCDA==
Received: from CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 by MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Thu, 25 Dec
 2025 22:13:55 +0000
Received: from CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2]) by CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2%6]) with mapi id 15.20.9434.009; Thu, 25 Dec 2025
 22:13:55 +0000
From: Martin Fick <mfick@nvidia.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Slow git pack-refs --all
Thread-Topic: Slow git pack-refs --all
Thread-Index: AQHcdebABRaVmXg1XEKj998vyrImTA==
Date: Thu, 25 Dec 2025 22:13:54 +0000
Message-ID:
 <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9026:EE_|MW4PR12MB6777:EE_
x-ms-office365-filtering-correlation-id: 41d18ad0-ac57-4b37-fde9-08de4402e4b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?NXzlL7uIWF9dyJQ7M7x0IT8XFZknbbg+jgXhJU6Rsh7kjL2oEDg77LRaIE?=
 =?iso-8859-1?Q?vfq2fNQvzcQVwBvGSczdayGwAF2Jq4d4dpviOMO1paXVlwz2X0FQ/ilCSL?=
 =?iso-8859-1?Q?ByOrxKphJB3o2X6dquiA57GMYIxBPa7XMxpCW9080Y5tgCZanUsARAw6/d?=
 =?iso-8859-1?Q?jrPmRx3Wvx3Lo9LxkoC65bbyPXgIDjah6LoPzoMNP2dTXfQkymlD89k3lY?=
 =?iso-8859-1?Q?/LCsQgJB0/zUxZMAD7z6/u5Avpwp4yqS0c6369Y6cLWNgiXqnzLSijAtM5?=
 =?iso-8859-1?Q?iQtR8OmQjCny/ug6TqiDqTjl3sbEvPLMbF6nEryKuzXl/0WlWDZfHEyaeY?=
 =?iso-8859-1?Q?HfF3aK73UXNKP9X5wFDjqWS4VeAa3wz3JONWRnuqKOpUXGGIyfyYNX0wPQ?=
 =?iso-8859-1?Q?BsNWx2Av/qYSU7BHFNvN2nOr3hcfDKerOhlGsxo1zT0Q7cROWBNDZtpNEq?=
 =?iso-8859-1?Q?3ybSCNPO/RQIUGnWlePqHTKPyoVoNHyjfCzWGn3wdpugyC2UTl7AJUyiQL?=
 =?iso-8859-1?Q?6zcHGpVj2vX3t6twaumcibCkAnmCq01zFrmLApB8ucl+UA6TmyWoakNIah?=
 =?iso-8859-1?Q?2IdBzaubuLbsup43kbegSb5xmdVLaNAxepeZ3MolOJk119QjNcXl+xIklc?=
 =?iso-8859-1?Q?155PuG9W1Z+/38cMNUixGYTq7QJqXNUnVo2lxT6YKmQsQ1ky72hT3V2t0l?=
 =?iso-8859-1?Q?HHkxEuzNF0W+cTg8cK/JWm6hRS8rdQsasygVths8J/e/v9o9XJE96az8rT?=
 =?iso-8859-1?Q?qfLitnI/ryGX5+C3kfxye89BnpS66vafZAyedqP0ZSlmam2JHMdEF0MWUA?=
 =?iso-8859-1?Q?gqdRYgWDNMQ7+T6MmLeWwgKpMzidwzPoV6tejSfuSOcuI0NQoZy3UvzJkW?=
 =?iso-8859-1?Q?jU40KkOKyatm8rSmq3tzmOgvPp0+h/IOvkNlFgNCPrsziwaXhFjimpLyzD?=
 =?iso-8859-1?Q?a6H2PtaxU8cQHghrwZYqkm1qGA5foU7jzanHzk3TCfRZUY0P/PphNqg7U+?=
 =?iso-8859-1?Q?XZfo+ihE8sWJ+axCv3tNUdqNuijdZEIouaMh4/+jcZXNExls/lnFScYrY8?=
 =?iso-8859-1?Q?uEReh1HRB2Fl9Hamg4ONt2n7Nf05Zz93oQC1O71LE23Wwq8Je2ZS90CDV9?=
 =?iso-8859-1?Q?XjP1uDBoJnXzJZhsthnxB8/Qf5M4dJ13KsuSGkO4mnSnE/W5/ZuY36LGW/?=
 =?iso-8859-1?Q?inKmb6ZtSSYaIoNoJ/5+QLfg6CfMpMNfIKyh1WQBJaE8DDee9hG/RQgtF0?=
 =?iso-8859-1?Q?QLPq0SXjCYjVibb+s5JNIIIqU/YxA6Xnun8rQzA4witnYpm4kys+2jkivI?=
 =?iso-8859-1?Q?djH64u7e91Jl1VlQUTeq9F49DbqV+X/+6hEUJ/NrUQLyyTcQEUDgJzhYGY?=
 =?iso-8859-1?Q?CSqoXzXL/4bUQaBoO9usz2x82iiU7WSIQOnJl6+hD71GHqhrMcP19Tie0/?=
 =?iso-8859-1?Q?wyg3tlk9mXsradfahrKH4e55mtFYCrOxPYQpJQOTXuMg0FLoaLWs6aZcRW?=
 =?iso-8859-1?Q?4RxGi6bkwvnZQhUTg3+yETHWEO/HJ1cS9HtC4fqdg9c7G2dTJVTHUjCKv0?=
 =?iso-8859-1?Q?AKI5aannrG103q7N6N++j9scTCMg?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9026.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VXFmyiOKBqNooP0O6acbIx8hKsi5TYN9S2AFbcsxrGbIb8Rn1HDF++e2ml?=
 =?iso-8859-1?Q?u3sXvLoxvHD9W2Vzx+wp8ATgtIHRS43L3b7UnE7THltghq9UnTb8C4Jf41?=
 =?iso-8859-1?Q?Q0wRBtFC/UtgVwJJQ4ZARhoVV1r8pxIzzjBZ6fwfX/SgjxwJCk8glKupC4?=
 =?iso-8859-1?Q?MIabKuRjQWIIBt8CP8fL4bOSo7V+sZs1oh/tlL+LzLd7XM0UbrJiRxOgFW?=
 =?iso-8859-1?Q?x9ZNQJPxuGt+w9G4t19ySxWkpeEoIYFIZXStiM0a3QM4Sm4m3fuAtgkYBK?=
 =?iso-8859-1?Q?NZ0uuyJHRYT9yHZsQttyA0o0LL4ou+dT9/dm/7Rkizqtzm5m3KjYlUyMwu?=
 =?iso-8859-1?Q?PobiG7E59LP/BXRAf+xq01BYMZhi03u7NlpIEgWf5oGEUu53+A7tdwCUpb?=
 =?iso-8859-1?Q?xJH9YngE8lfit5BSJC69zWBlogpGi75rEWNlvuxLFIgGnnWez/piNmTZtn?=
 =?iso-8859-1?Q?ppWMYuhUXeb6nxUVByqE0HY6AeNPVFa4SpOHXY5rgoXoGzUOx3xL/6wW5V?=
 =?iso-8859-1?Q?sXGIcsxeERgBgslVsBUDD5H5E6tKtCR15dyLeVv/Em5ffJRQRW36moEl1o?=
 =?iso-8859-1?Q?6BfWCvKKWvJJYt2OraIfTyB/Dj/5QRepPdDuzUjf6grZ66HrM33EQikuXe?=
 =?iso-8859-1?Q?wNOZGY51qTfBzJw5J9JPas5i/5lXOHC9KZJbu3y2JS2HDiwH5RSe+KeN+o?=
 =?iso-8859-1?Q?PXbcy+TEug7CzL4IdajvQEUH9oB/sDfbmuqWlKRN1aByehph9GAvBT1MJG?=
 =?iso-8859-1?Q?jlNN6mqid0WWC3m3oot7swA2K0X4OgDTBrLu7ZbDAte1uhEnGS7INL612r?=
 =?iso-8859-1?Q?tJQLqMLpSN4aIBhu/k2uO0ccLnYW5nA6Brh7wRpUakKOxJlewZmuuDxuTm?=
 =?iso-8859-1?Q?nxcV1d3soi5dJJQc9ii622Df1w0L+MACLhPnC775HgEYBaDhArohKwKFEC?=
 =?iso-8859-1?Q?iQwe5iR7crHO3+GMeMeE/Ae/JPW4TGWA60jNQtHdsIUI6yJLc5gasGSpPj?=
 =?iso-8859-1?Q?vuo7e5KAdpoUv9uVN+bg1tkcTTQ4wi2CGX274vM04AZGmpIOarHHVUn9Kk?=
 =?iso-8859-1?Q?7Hlh1syo8SvKfUwI4ws0LM6fLzqsXEHH1983BUhzY9JGBj0ZTNAYijcwcy?=
 =?iso-8859-1?Q?wEML499KOaBZsTdEhjT7KTef56+DeuU1itlIVOMZ0MSktxi09D/NmJEbkq?=
 =?iso-8859-1?Q?1UyZMaB0LGHkAF/OkuyWL2DLLs8W+O9oBsmmqFlulT7lJd8vrmKAnMN55L?=
 =?iso-8859-1?Q?05a/74S4C3gIPAzR9vb3vMHJTIWo8UtQ5n5+3bhMNleKBHsdFCCdYD9LB9?=
 =?iso-8859-1?Q?UXCQ6sXOIQiH385yfktVya8fC4LNjhmXkk6LPeyCcCNA3st2rmDGA6Dyns?=
 =?iso-8859-1?Q?PkhR8kd0yH1ekNG+exIOaocjsHzbF53Mk6gXpAJcV7RXghdq5GeE0XB8hz?=
 =?iso-8859-1?Q?DDkZMEs2288HvTHpWovncmevlln3v1grXZFgFRQoDhPaBtDUjCV4wRaTID?=
 =?iso-8859-1?Q?BpZHGsQECkxcY8oxv7OU2y/V43BdAC+rbjTq+y1LrQc1njfjKrxKSU/2nf?=
 =?iso-8859-1?Q?YsCcdDalE6V6LMmsNfBZ9MM+fjHkC29K+KeNzbptqaq9b5VvtcbNMkqAoE?=
 =?iso-8859-1?Q?PyfHKbmeRUplqFW20Wvkba+GVB2Zw/sskorKCqNS2bZXT2ZNBEK3BJ2KjU?=
 =?iso-8859-1?Q?ehlq9G8A/55qSaDA6MWChmbYxw9DbB0uQg/lbjphNO4RwxZW/bAcq4KdWA?=
 =?iso-8859-1?Q?ZkGVdDN7u/Tit2VBn1ar6zTjXBPaqASYzhtg6qu4AjaJee?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d18ad0-ac57-4b37-fde9-08de4402e4b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2025 22:13:54.9981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5tfRqE1+HVbuToKueZwqqGIDf0Pyt+/d8MClqdv3gr9CIazkLnUAn08uOug6VBAYFFNyn9Ra84tmryYwVA/MTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6777

I was hoping to get some help debugging a busy large repository where git p=
ack-refs --all tends to regularly take over 5mins to run in production. As =
you can imagine this is particularly problematic on a busy Gerrit server si=
nce it tends to hold the packed-refs.lock file for most of this duration. A=
ny help is greatly appreciated, see the details below.=0A=
=0A=
-Martin=0A=
=0A=
What did you do before the bug happened? (Steps to reproduce your issue)=0A=
=0A=
I have a large repository (~90M objects, ~50GB, ~3M refs) which is regularl=
y (every ~2hours) repacked and maintained, but generally gets at least 300+=
 updates per maintenance cycle.=0A=
=0A=
What did you expect to happen? (Expected behavior)=0A=
=0A=
git pack-refs --all to complete in under 20s when there are only 200 loose =
refs=0A=
=0A=
What happened instead? (Actual behavior)=0A=
=0A=
git pack-refs --all takes more than 3 minutes=0A=
=0A=
What's different between what you expected and what actually happened?=0A=
=0A=
This is much slower than expected=0A=
=0A=
Anything else you want to add:=0A=
=0A=
Although the packed-refs file is large, copying it takes less than 1s, so t=
here isn't a writing throughput issue with the filesystem. Additionally, jg=
it can pack-refs --all in under 20s on the same repo, so I don't believe th=
ere is an issue locking the 200 loose refs either. When observing the files=
ystem, I do see the packed-refs.new growing at a rate that seems slower tha=
n expected as if much more is happening while writing this file, than just =
writing the file.=0A=
=0A=
An strace shows about 200+ open("./objects..") calls interspersed between a=
round ~26K write() calls. I am surprised to see pack-refs reading objects a=
t all.=0A=
=0A=
Although the repository is not in terrible shape before packing refs (~1500=
 loose objects, 37pack files). Surprisingly, repacking the repo first does =
speed it up so that packing refs then takes under 20s.=0A=
=0A=
This repository is on NFS.=0A=
=0A=
[System Info]=0A=
git version:=0A=
git version 2.45.2=0A=
cpu: x86_64=0A=
no commit associated with this build=0A=
sizeof-long: 8=0A=
sizeof-size_t: 8=0A=
shell-path: /bin/sh=0A=
uname: Linux 3.10.0-693.el7.x86_64 #1 SMP Tue Aug 22 21:09:27 UTC 2017 x86_=
64=0A=
compiler info: gnuc: 14.1=0A=
libc info: glibc: 2.17=0A=
$SHELL (typically, interactive shell): /bin/bash=0A=
=0A=
=0A=
[Enabled Hooks]=0A=
not run from a git repository - no hooks to show=0A=
