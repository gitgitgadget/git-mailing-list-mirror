Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752222A4FE
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767740547; cv=fail; b=ebe275Zme7JGck2+NF7mt0MFNRh/VNaigYaNVRa5NXQqYrRx2npfyQk2nqdYn3helW4/96tngP33Vdvj2bheCv5iDS/6g+fdnE4XL1GuhYknfASmjipQDv7nByXMUsdQgy4mVtF/syHEeNwX93KxK5a/EV2zAzPyBXH2z8+oLhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767740547; c=relaxed/simple;
	bh=MCVz7udII0vdyxP+Cbhvu5/Q/cyon/GjADnfBBjmCuk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d+u+LQNAIj/mDzFcqhIUnGI+K/ywQQGTr7b3ws61MHWqjapItW3BxLHxAOoyKUtSvx7zwdY80OHQkCTkuD21V8884vOGLQbAbQYSmcfmxezYk9rfINicJ5RpbUfSViuMlttwc9eLZqo8EpuZvcy1jQ9C8xJDT6iZsDwBuRIDBwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VOS1uPJ/; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VOS1uPJ/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVw0ygJHTc95uBKAtVTJN5oBcMXqbMXKpu8YWXmNPvuKcVSIgMdSE9Z2yr5gz9jwnBP7sXnwY0V0BSdXTEyR6Y8OCqZwPuaD5q3ZFJOEutfOxW6PHFBwyE9+7rBoaApGjDBueeNqpV+tpvBuEzurIErwf15/4kfJIdAedG05hawQKBmHK6Oyb13RaKazSVIgwt3Fi+1e98A2/aDTSYIJuQtXUg58AKUvakIzuJeAyR7OypZu0rjWvE+xygZQG2aS9Xbx+K31f6U2AkgNZ0hQNmY8UoqB2ce7F0EUBkw6po8LY0mRn+sMVpeT7LlYFwV1aMDkju2j1/6fpJv7dk+HdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNJxFstDwPbX+Paqk7uY5/zIs8t5O1gsWmSXysE+F80=;
 b=Qborbm6sPccoER8TN5uKM4tK8lSHnooRAELhJOddk/RlOdENzOF+3SuNDZokkHgm/riVi/VVohCUnn22hUiFOF6pin3h3MA5/50Kw9WP+oWPFJGiXgOOfy7/3hMdltPJZwvdvu3p0LF/9D2o05ktasCT+estqlhYDFNxBKRZmURNDAsn6Wj3Xw6doaivsmBtmf6Xc91WeOsq2JVktAjNAt2CvclRba5jKfMQ2S+Trs6jkl1yf4MO4XTRxqyNR0FvWskqekywamMZs+9m8ScE/W1yvEO2KLu7iLnqDepKw04w9GlSPQbp1N0Lc/jq5dq4nd4YVY41S69Hh8+sddz2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNJxFstDwPbX+Paqk7uY5/zIs8t5O1gsWmSXysE+F80=;
 b=VOS1uPJ/UuZLR6vLGHPAjr3ZGrZZBWbO+1/462Jctw9AExKttdO3XIRYjWejb1xC6VA7u4AKyzAFKQhVLTPpZI7A4opm+WiP5vR6xD+nLaK3uaolrDAgBSz/e8G67czAewwXbMPBH2KhHRJRCL7vbf6dZpQkmAlZ8fo2v1v/VwM+uMgqmXkb+tn3KYZCBLKu7lkg6lxLNkh/e1noFVV1PvAp3rouV3s9YUH/kbvIG1RyyLze8lHXcRPnsTjB6zrE/FDvCPFwCZFnQzSDgmzzlvJAmjfcX1qCE5hJR7YpZcF0lPlyAweuhfx8lVylfcAuWSrK/r/WgJMl0gO2MAXgZg==
Received: from CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 by DM4PR12MB5963.namprd12.prod.outlook.com (2603:10b6:8:6a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.2; Tue, 6 Jan 2026 23:02:19 +0000
Received: from CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2]) by CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2%6]) with mapi id 15.20.9478.004; Tue, 6 Jan 2026
 23:02:19 +0000
From: Martin Fick <mfick@nvidia.com>
To: Patrick Steinhardt <ps@pks.im>
CC: Jeff King <peff@peff.net>, "brian m. carlson"
	<sandals@crustytoothpaste.net>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Thread-Topic: Slow git pack-refs --all
Thread-Index:
 AQHcdebABRaVmXg1XEKj998vyrImTLUzA1gAgABVq4CAB+sE2oADSLCAgAW7ve6AAH4YAIAA2VTy
Date: Tue, 6 Jan 2026 23:02:19 +0000
Message-ID:
 <CH3PR12MB9026F1E4B99D32E138800EEBC287A@CH3PR12MB9026.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: CH3PR12MB9026:EE_|DM4PR12MB5963:EE_
x-ms-office365-filtering-correlation-id: d378ee1e-70fd-43d1-79ab-08de4d77a506
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?cAYPflYrxy0jjPmOaztldtUC5uliZmE7izjpA9jrTK5+3wL6Lqrbq7XJ2w?=
 =?iso-8859-1?Q?X8/YO1rTclkJDcb5uEETMrkSwR/VmuG47PRAvJJByIX7kOMyCky5/MZaUe?=
 =?iso-8859-1?Q?pva91dGXJHiUj5uWzwcuC61STb8DI5ugMQdTs7uxftP3WRyjGX91gQmaJN?=
 =?iso-8859-1?Q?kPXH+8MXlFfe/WlGe9hKJ2KUb62ICy0fDt9r/lVl1wg1ANfJN6vSio+V7d?=
 =?iso-8859-1?Q?knqn8pxpqzChfUhOpGGHlc8ALPyVYoojDthtZf7bnw0ikklIpkod8sXJB/?=
 =?iso-8859-1?Q?An53uXGaIbU42KNiu/z2y0abWgxt4GdypmUxzQrQVQ4I/UaRk/MG7k2iYB?=
 =?iso-8859-1?Q?UmGl8iTP1FdqIQwJeNLIQ3RlkXbKul0P3i/RJxapBWZyhgG5HCSA5OMF7s?=
 =?iso-8859-1?Q?j+j743JQz0vDvhiqKf9/Tj0z2rirbCj5+HgbJNDIV3v/yy/ftHJQIgGm83?=
 =?iso-8859-1?Q?OjJm/RWZdzVqJ9gvew8neWASUzcLMV/df81Fj+6GF0DthVkDl+3fvHy/ll?=
 =?iso-8859-1?Q?p3OVbLjPCjwGy0W63vkdIBnG9hkoS/YQz6qqeC3mNwKapIOBQf3lrZelGd?=
 =?iso-8859-1?Q?IicZGlJoUYpSGvQiDJk+26owia82FjQDlfPPh0xDo/ohbZtAB6nFYqhu8S?=
 =?iso-8859-1?Q?3JhIoEyGVmJIdwT994Iy+z84sE0YJZI94bsglU8JaqwXeJ48E7tFkhhGgj?=
 =?iso-8859-1?Q?ORAGE/FQIOWkOYx+WrL0gzjoeWCnG06uVfkiMOtqd+nx1WJe+1O/T3yhNF?=
 =?iso-8859-1?Q?xEHcAF34k9ZiyBFLMY30yqE8uGRW6j8lSCKiQ+95cFLtDb9s32xYnxlv87?=
 =?iso-8859-1?Q?orHmX0IHFQbOuSppo1VBb4rvdsauv+LB9NGpS/fD4JTT3ygTOhDJGLPlMV?=
 =?iso-8859-1?Q?2FNd0sJhtXILyLZ+JXQjrPH0vFkuqLRfrc+Srq3vXcR1BWslVhQmEUc5nt?=
 =?iso-8859-1?Q?yj/ffqmt+OCqDLAKgcxFoCYpG8lyc/gcQ3fsp1fkrlBQYVaTK30aFxBPry?=
 =?iso-8859-1?Q?f0r/o8UOORLCWKMQQZC1en9Z5p27+jPpcYhRXA9dtjK44I8bRDziMHh6H9?=
 =?iso-8859-1?Q?8oKWSl38qOyYRs04EwjxU31Gvb+3keZzmbAZ8MyqxJPkDETZ8B6HrL7+yv?=
 =?iso-8859-1?Q?3UQSAD/ycPIOq+ef8LdccpDGzmUI/dnrGVqecukj47tXIGDYBYmK2DttSq?=
 =?iso-8859-1?Q?ZaG9A8ppKbfJ6sWDgmKJneaYD5DHwkujEaOjte7LmCBFMFOZhoJJW5xGY1?=
 =?iso-8859-1?Q?lezENKgxMz5JfosC6HQ2KGADI77kvVQs3/4TINPcI480WTHtIGKPdzyeX8?=
 =?iso-8859-1?Q?OGRR+zIxu4StfF1DCD0CbQSt906qANvCg0F3XAQv4Fm5LsZD/MNIRInudG?=
 =?iso-8859-1?Q?akjGLnpdLKrSBRM9u57eC04AHPxolzuI8w/ZZccXZkHJxQyn0uWHo4QOdS?=
 =?iso-8859-1?Q?OnAVmYRgewipA3zP+MGOfPHstcDrKRsg6zgYso5viF+pSOEkCm5JP65ctm?=
 =?iso-8859-1?Q?zBKHGpJSGK5UJQOkUgp88VY3uYmWYpnUhRrPwYmDymFuh2RF/G6J5h295y?=
 =?iso-8859-1?Q?U3nVnCPiCtpzj1mB610awu4NYkL4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9026.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?irXiEJkqd5sXPetWVveW+dezX9r9943us0t21WUgtqzxNBRH/eCQZZ2j/j?=
 =?iso-8859-1?Q?HwVFBuyF56RPWSKl8/IF2+CZH9V3UiRQQSqd7pv06lxyA9S6yrTUieTl4H?=
 =?iso-8859-1?Q?XdcXHSj57OX9uR81ZMEYwmkuZIAVAnWeeds4EdNRSGdltJ29lgSxk0MqnZ?=
 =?iso-8859-1?Q?eiycZPEvxH92BrNnoYnV3f3P/AaGe6R0GyE/1QDc4bAbz0x2sf6FpTW4FX?=
 =?iso-8859-1?Q?NpCaTWLyZ1xlMwFWSruJ4eIGkxQwCcK6GXNJBUJltTDG1t8JZsyR3hiSbl?=
 =?iso-8859-1?Q?O8e5gN89YTyAPucwYLo5Y6pLwlchzt3sbPEv6u2Ojh7AAxCUJ5Alwy9k5d?=
 =?iso-8859-1?Q?GJG1/oESV5sFmaFKJU7Z8iQx2IYo9Iotg9P8KmaT/rFeM1HPUJ4j5+fUUJ?=
 =?iso-8859-1?Q?ChJwdD/GoRJ6wbekYSWGfjmf5XgAmWvHqNnc0RbgfEr7EUhQG0Pguv8xS2?=
 =?iso-8859-1?Q?NJ8E1g9SlTnTXd/0VY6Zm9+e9BqOTFXmgJ9g87JTtha61Ys0jOhaBBescG?=
 =?iso-8859-1?Q?qadYZTd213vi/7+2Ct4g97aw08KL0bTmDFyvhPiROZYowi+QQ6rB16rvcD?=
 =?iso-8859-1?Q?4yXCmdWCb5Prpu1XrnAqsn2FqrFkwcM1mOLvV328aY1sRQqbLzWHXss8Bb?=
 =?iso-8859-1?Q?7toCEHao/Qs09b5tZu/243B8kKoqoEjD1ogYaknnQ8t+V4bJzKNpmrm9fA?=
 =?iso-8859-1?Q?pQ9gMsJr9nexq/tPpEhzi1xDNqJQ0jSsSgo8Fx7YYz3aeZPkgdz+DWTWNq?=
 =?iso-8859-1?Q?XRsSY+Z1oEbjKJ7eyLiWWvBBqVehS8SKxjRcIg3bZPzuHK05fJcmPbK1i8?=
 =?iso-8859-1?Q?PbtyewVp4GyXq2KSEaC0Ab8I8oKWCwt0inajJl5T1EkU3myY1knVll/+np?=
 =?iso-8859-1?Q?N9B0VwyPAnrhS/Q0j4IVxHaS5QXeN/EY0uaAdO8SC87T+Ijnnx7CXbpxLR?=
 =?iso-8859-1?Q?WCPxKuS/EWCRc9ev//MdioGiEexkGKApsahrtVaD6o4+u+rj4lXrLwSNAw?=
 =?iso-8859-1?Q?8VufpuI8m/vaZSHfoTgpoGvTFBOwXYPfmUmnUXMfkjdOZDcDHqYJRJW/wF?=
 =?iso-8859-1?Q?1hFd1eYgAjJKjPum47k9KJLBVzVAC+pSbOSN7xPteIqwBI4fcPylJwempN?=
 =?iso-8859-1?Q?GcfaPDUjswXA5ImEJazeHJL+0j3CkO3RVNGENEtPt2v26pUsL98hgYiTaf?=
 =?iso-8859-1?Q?Qbg5HyHkR8uPeAkLNOMqS7VRrGYmKBE3B6qwQ+DiExJUoI1qGEaN9qnrLs?=
 =?iso-8859-1?Q?fRczVWOnPNkJa/UfdbjdUp/pyPdAu27k1TZ9vFqJL+eqirRTGy28Fq+5QU?=
 =?iso-8859-1?Q?tVpd79WyFA+4js2GxVI2SBb4QNmkbpJAkSFaB4TAqEKjiJrt++fC+h0xZg?=
 =?iso-8859-1?Q?p5kBVET+eRh3Cduz17fBsh1TS2io9WPuL88/LPNKxEbOwyDzI6FyxrPD34?=
 =?iso-8859-1?Q?ZKFCSZrbfTy+owWCF1MdGH0Fv4q5n5F2fWn2bCNCXryef0YsJHeSF4TJ7E?=
 =?iso-8859-1?Q?mSHwJE1OT99ZZS3/9JBT0uVbsAOQYWGzFZmqBQDItVCAR/xCQvBShQ5tgH?=
 =?iso-8859-1?Q?nTa0gHWXUaJSHzu9gqNGwuxwPwzozMbFYRweh35EH6Vq76NdDC3tE+gz2n?=
 =?iso-8859-1?Q?yDcuN/rWL6a6DFIbJq1T63vc62twypcBtw6HWkzZFcnHbCFPMdxQa4oSTF?=
 =?iso-8859-1?Q?8N6nkMVDHKw3sxLQY8GiLxIZNx9QUb+wdRqPjEI0RaCEl5ObE0efnYwwBc?=
 =?iso-8859-1?Q?c+7G8Pqz2So1KIS/+hLvpZHRG+DTEyUCC2hbFGeRghI15l?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d378ee1e-70fd-43d1-79ab-08de4d77a506
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 23:02:19.7971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Q4pIW5cnecHj+isVtz9+S9MH3TmMus1CqzkEsej2P1K/2xe88tfSKj6KfBIWkfysyZxDaqelAtpkS1nGkXVdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5963

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
> >=0A=
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
> I wouldn't be surprised if NFS was the culprit. At GitLab we found it to=
=0A=
> be a constant source of issues, which is why we eventually sunsetted the=
=0A=
> use of it completely. Do you use any special flags for mounting the NFS=
=0A=
> filesystem?=0A=
=0A=
I am open to alternatives to NFS. Do you know of any NFS alternatives that =
=0A=
provides instantaneous replication to potentially hundreds of mirrors? I =
=0A=
have used Gerrit and git-daemon for many years on NFS, and it generally =0A=
has performed very well for us, and it solves many real performance issues =
=0A=
which I have yet to find a viable alternative able to even come close to=0A=
matching. NFS with all it warts it is for us (and likely will be for many) =
until =0A=
there is a viable enterprise ready alternative with low (zero) replication =
=0A=
latency and high throughput.=0A=
=0A=
That being said, NFS can cause many issues. In this case, I would say that=
=0A=
something is particularly "broken" here with git, and I believe that it=0A=
would be helpful to the git community to be aware of this fairly specific =
=0A=
broken case which clearly has a lot of room for improvement (as seen=0A=
by the fact that jgit, in java, can do essentially the same thing more =0A=
than 10Xs faster). While I have been mostly assuming that this is a =0A=
particularly specific bad case since git daemon generally is fast for most=
=0A=
users, this might actually be something that if improved would greatly =0A=
improve many parts of git (not just this use case).=0A=
=0A=
It would be nice to improve git to not hold the packed-refs.lock so long =
=0A=
to avoid this blocking behavior on servers. Of course, to be fair, this =0A=
likely only blocks Gerrit servers since Gerrit uses the packed-refs file to=
 =0A=
perform atomic updates for many things, and most other servers use =0A=
loose refs instead. It would be great if git were optimized to avoid any =
=0A=
unnecessary reads while the lock is held.  In theory, almost all of the =0A=
data that git needs to read here (including tags for peeling) could be =0A=
read before acquiring the lock, and it would only need to double =0A=
check certain reads after it acquires the lock in case things changed. =0A=
That wouldn't make git pack-refs faster, but it would drastically =0A=
reduce the impact of any problematic I/O by not holding the lock for =0A=
almost the entire operation.=0A=
=0A=
> Did you try using perf(1) to profile the process and generate a flame=0A=
> graph from it? That should likely make it immediately obvious where Git=
=0A=
> is spending all of its time.=0A=
=0A=
I will pursue this. Unfortunately this might be difficult on this =0A=
particular server.=0A=
=0A=
Thanks for the feedback, and suggestions,=0A=
=0A=
-Martin=0A=
