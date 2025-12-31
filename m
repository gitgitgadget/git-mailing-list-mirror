Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BA21E5B63
	for <git@vger.kernel.org>; Wed, 31 Dec 2025 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767160096; cv=fail; b=XL/Lds46S3BrG5K07czSQCZEIkLd2rZf8oU4DnyGFUH29oS4FQGlDUF/Ki1DQo1PC3WoPVcluUa7C9piaBAdess4wz527rLm933X1jeinTp8vEFVWNcL530QBNDYvr+w+6BMMGn6j6d1q1dNtBvW0xuGPSQ2zS9nSsvINQi91/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767160096; c=relaxed/simple;
	bh=7rUAVfabjPCeCU4rI4DR4wlsgJMAdpm3zobGTsMe2wY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=etvzXz+Z9JkiKIDTHgSPCE/Ht47Rg4H7nHzdYwR1u7K7+VXNxXfQx6ODkPM2tck0Bc2wboefku3ZOR7EoepH4ITAmt3QhvlEFqF3EWDxCmawUQdNybKWHlzVho7zZfB3urSIL3nj4Zea1HFJML/+d4dGXpsQs1lFRQ+1MCUZND4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SY6r32DV; arc=fail smtp.client-ip=40.93.194.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SY6r32DV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnBQyY/J8WxT1PG5rpy9uD9gUVtE6VSmnZKHRljS8DYaMVeq8KyXmgcUbwMy8X55St8Pc1QIOO6bVomKAB4IuhTsscGsovEfbaqzzUlmv15BvY2+uqBbgs4M8NzPexTLQwghuR9BMc/lCYERcz2qEqKJfPd7JvEhhxlxYjRJWDG5/5arhuqi1hy8Bwde5ytBEIaPi+ljsXRdvE0B/A5v2rg4adoNJNkwY9GrHrCE1aGUgroLLYtQE6GyFs2qUrfW0ZaVtw7CT9RGKmewMQUP+NTe6czaDHfBnyVO9iFDWjhfgAwbbu5HCVDGBU6eZWJ1NqxoLKZ0zLlZDztEAukyDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rUAVfabjPCeCU4rI4DR4wlsgJMAdpm3zobGTsMe2wY=;
 b=IYRDLdqNRQDfP4+J79c8awgv8+RYQzj3X5akXtRIbf/iHBb17WFT+yWgogbHmLo0bYHm2n94aXGSpgof8pQUpHUZtFYP+F0FU1rPldwrztk96fparvJjx/ehkomT/5I7erQviTcFcOqZVAcdUTkMefqGnxUv1QqoXxBoFa+nv/4oyNpJSvY5fBgLTEuO9TiBInZ8XcGayCu1fGvZVxYshqHkau+JPH6+5r9tKnmxhP1pOiJvePyjtia0c5Hq3ysEhAxpAMzDns95MJgohgugQLhw0/UErRnVOsEHzyKHQNVEwwsvXTRpAfbplEfGEb5AxhtNyCPXbF5uVIUa4/+dvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rUAVfabjPCeCU4rI4DR4wlsgJMAdpm3zobGTsMe2wY=;
 b=SY6r32DV+Kxwl7iigXgeRRhtB+VmPQkd89eb5ao2KKCsqSgPJw36vgv8nzBAWGkZXV1k3zVM4ot4qQREWfpObrdRoVi+PTTFZZlCsFuGjsf+6v77afLl74Oc6Npu2QWCQzj4lJmvRXhg0J7fvvcrQnCe8gTHMZTa4qZYXpLXEEWUQ4xklm4BvGYkj8Q7/LsZ+Ab4SSux8Ps3OUo44+8RZB4Mg0P8r+6piaIQJuvwUgtne6T/q5/N8qdoDTQy3k/l4XT7uCMmW+RwdXL7UV5QkiGQuHtE/s4lhh3Ez8flwz/bIuMnGksPan5Yt4rSktxr/OB90G9/cdPt5g1ljO3uvg==
Received: from CH3PR12MB9026.namprd12.prod.outlook.com (2603:10b6:610:125::15)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 05:48:11 +0000
Received: from CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2]) by CH3PR12MB9026.namprd12.prod.outlook.com
 ([fe80::7e83:9747:5352:4af2%6]) with mapi id 15.20.9456.013; Wed, 31 Dec 2025
 05:48:11 +0000
From: Martin Fick <mfick@nvidia.com>
To: Jeff King <peff@peff.net>, "brian m. carlson"
	<sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Thread-Topic: Slow git pack-refs --all
Thread-Index: AQHcdebABRaVmXg1XEKj998vyrImTLUzA1gAgABVq4CAB+sE2g==
Date: Wed, 31 Dec 2025 05:48:11 +0000
Message-ID:
 <CH3PR12MB9026DFCF7AF4ED1A249B16A5C2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>
References:
 <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
In-Reply-To: <20251226044507.GA1971832@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB9026:EE_|CY8PR12MB7489:EE_
x-ms-office365-filtering-correlation-id: 1031a32b-e5a9-4047-f260-08de48302e96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4oEJX2/rg9PQ7ToSEO4AdgbhQUXjxZNYxmP1qrIVejaf3YC08t6KkQoDwI?=
 =?iso-8859-1?Q?/KBFDkPqwdwngm8b7nycMZyyrJtHsuifSSYD17f7aCBlFt3igQuE1bZIxc?=
 =?iso-8859-1?Q?aOP63nLXdyoMSZSUrw79zGm2a6eMlLezoF3Z6bnSk3m3+E2btkNMDOLe8p?=
 =?iso-8859-1?Q?wv/qq98eBzT0Kk40GJLeYKgtERwD0w1jp+Kj1AluGLiO1GuIhOmrcjl1ZI?=
 =?iso-8859-1?Q?+MWyUgRSVLh/0kYE1GXv/5hbE0YKxmPqkYuzT9MNr2btkgM2pHsjNT1FEx?=
 =?iso-8859-1?Q?xD930A5KMOxJnv2DcMXHXRscT22kG/0koMpF0G+6N6Z/HSEPrb4z43r/bY?=
 =?iso-8859-1?Q?rkkd3OnvkK0Op9Cc+P3pqXL8K7n2bVAdnYYNyU53lGx+azxyOWBDT4Kox/?=
 =?iso-8859-1?Q?t6qODIUNhSM3wKU9pbxRAlpavhe+xNk0wxZWBK7AXSE7+kXlR0CzUiXZgm?=
 =?iso-8859-1?Q?XkxV76oC3T3Ix2exI8a8xMQJM2VxPsME4NSSZejl/Iy2mWxOlMDGyVAtFt?=
 =?iso-8859-1?Q?wWtsXvxyGYqe+aF9AKTbzzw3PvvbXFTbiCIfNGw1iuxWTTWZt+QAwcYhod?=
 =?iso-8859-1?Q?VzLO7wckwIJTzkpdrzHHcEPh1Lr74sBl8by8zYul8gyDuH+MfxSo/P3LjT?=
 =?iso-8859-1?Q?iRuExj7IW4tw36ZxTO4COoE20iV4YnIcXlW9s7RTC3rwZ8Dq3jtiTlbbTB?=
 =?iso-8859-1?Q?Zz3GtYeDUQZJQjGMFwalmQoiwSsM0kPDojmmhvNQFa6aRzgtj2jm6F+cCh?=
 =?iso-8859-1?Q?yq/QcwO1TbB96I5dORRy11+RTfSp7/i/a+LyMBMs9Z0Z34f5skfBPY58ZD?=
 =?iso-8859-1?Q?oMeUFF7Z3ZWW5ea7cxGpJCCxL9dcrMtGIxzQD9FXoL2/3DRRYpXXiPjiCA?=
 =?iso-8859-1?Q?MerIeKZokjJSnZQehx2akE5qELnGzi3E5qWZKA6pRN+kauVfLY3QxHN1cH?=
 =?iso-8859-1?Q?f+K35qYOPh/pMEaNBeO6YQWbcdu2fFT1Boo0nScPom5aNmJPAAYdrieYBS?=
 =?iso-8859-1?Q?nSHwAgVyy/2K0fr5h07MtnKY5X17SrQ6whTS6cYD+CdfkeiOQG7c6I+jIF?=
 =?iso-8859-1?Q?+PRBtxolHaEUHTWzixiouF2umrqQr0vn3Djgy1q8ntdtBX9vwJiL2QhsDx?=
 =?iso-8859-1?Q?qaaWzsWaIxuZn/9jJQS+zCm/PwQ3Ugo877Zgxt1Y+HbrA68/63bvDzpNJF?=
 =?iso-8859-1?Q?OzmViS5RRrSYDoP1PIkqpjrkNFBqCkQqqdpCD2HfkULgmNB3o8Y9Y4jWaR?=
 =?iso-8859-1?Q?oLJzRk2PIs6gXEqX4uCrq/DsDcIUkyoIHGHKXCjKn3MPXN8q1wK3m+Ugkb?=
 =?iso-8859-1?Q?3cbGO3hN2cIcvjT62HlIiW8OUGpAoQ27Xa+eIerTouJalwEjfWs4k/2F2u?=
 =?iso-8859-1?Q?K+lPaCIeYrKqVgo516NaZE0sa8+msssA5gLgB956vAD0sjMAqnfeWEidnY?=
 =?iso-8859-1?Q?gLTKDquZkFmItjFCjr3corUVT7ny5PFbFaTl7pl7bTRZ2X/kr7q4t9iIGn?=
 =?iso-8859-1?Q?HqVT28DzfYslSvNVTSdM1fgRkMGq0/v0tTzMWfbxMdMFJoSIvL0gcnWASA?=
 =?iso-8859-1?Q?EHRFZD6zWE61QCxjV4kF2H9KZtIa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9026.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DWvP1w/6W7kOmb0bfP7bY3S93ymuHdCSh903XfatjWmV06BNCwFbC7nNRL?=
 =?iso-8859-1?Q?xgm0MI+X8cK9IOr8PnVoR9+nf5KO/Q1xnoxzK3mYm88LOU/CGuEL08svX7?=
 =?iso-8859-1?Q?9XV/OJN4Ha0kcmwYTeUPeQ7fLtMitnsdydnrOusjDEEluKOO0pU9VWuZou?=
 =?iso-8859-1?Q?yKGGIEMRA+rAy9CqTZY2uDIrTofJ6xH6/Zdgab3CMpbrRyQl0Z45H9+4Gt?=
 =?iso-8859-1?Q?TMP2y2+FTYap/Nh7sbeqZOuV7bXmDRzpRPCsxEce3P5YMAoqtJbwWKJL3G?=
 =?iso-8859-1?Q?GLeHtDgWs3DEGFvZ6Bacs04QTasHUiQEZO/waJbUQD8ni5aVRjEjfjn18h?=
 =?iso-8859-1?Q?wmXgP2xOUXE/0G532dMx7p4oylC/zYrOnaZshZCersAEaFEhi8EzJP7RrL?=
 =?iso-8859-1?Q?sWrAzd5UWNHe9a5Alw1F2qYLNEjJfv6yEdHE59drEbydKbebe+OJJ3Ndt2?=
 =?iso-8859-1?Q?dYiF8aQOMfGYTWVXOJrE2EoZuJTe/cA6jJmnlyLgiqRx5CuN+WmHAgi6x3?=
 =?iso-8859-1?Q?nRCnCgkRcAUkBKCLNrFH7AG4oYO4uavvSdSS+zGR6lWGbjf2hFpkgfeEu0?=
 =?iso-8859-1?Q?oaTuXZY1EuRMBhwYvkU5f5q1ftUttJCWAUQXZtPK3ep85bCzSDFqQWZ/B8?=
 =?iso-8859-1?Q?eWwb8FnGGVmv19Lb9lSdsMLi/HsnbCNUsaMgazPBsLTGX8bkm5kO5HABra?=
 =?iso-8859-1?Q?doSOoROrvHQriR0t09DnzrRfHyQbBNnez0z5efp/3ZXDzP4c/zytA2ebVo?=
 =?iso-8859-1?Q?Mkmrt30+aRiRssaYyBaQAmhHJRU1tuz56YMqqYvKIOciSjTYvlXnX63/nT?=
 =?iso-8859-1?Q?2Ex0BAsEtOsjJHgskewWxzOmfvbcVhFXwnLAM0herXNs0SI6ZfHWuE3R3w?=
 =?iso-8859-1?Q?p2PRJU89UJVgYdoXk+hSFvUkQIu4flRprJ/easUI1lqMie19ho5ZnQWtTh?=
 =?iso-8859-1?Q?6Y2e4QLFdqCt6ldmrm10JClgQZNLOZPWYCR+W1iXu/t4omehBkYIrJwTsc?=
 =?iso-8859-1?Q?cBcEgN9mbBodft0febva3HXRUW+vnt23Nla2ksIK8aNiQfrhzu7ID/DnqD?=
 =?iso-8859-1?Q?W1ShgcXejXNKW6ytmcFgyi+ZS114p0QnLQ1U5TaNBRhvnyeOT+4/R8CbBy?=
 =?iso-8859-1?Q?hk/8mUoP88bdtIscpbStmLvlJG4QnVDf+vsk+7HO5mvJuiH/qq5lQyj+D2?=
 =?iso-8859-1?Q?/Q30H6ZohLhRkkxaIb1Vfhyn/8r18NfOHpBcAvdHS/vyncbHZrRDFj4Pgf?=
 =?iso-8859-1?Q?L5D3SBINJD1XEzyoY+Yx+bFEdu/DkzSnAmBuYGseCdbx9fTmBQtQ0an1+U?=
 =?iso-8859-1?Q?PXUJw5Rsx7ne8/+dr9SBWCo5uu8kzezgZlg59cztR9WKYZ0MCp9GCEXx4G?=
 =?iso-8859-1?Q?ZmyJ4ExvuCtRsRgNjF4J9q1EuloWY1CF+XJ4fqhXknZoRHyaRpO9KFtkyC?=
 =?iso-8859-1?Q?2uzCSDe6bfkDzu8DKZlkPc9MoN+dOh9jekvS/KfrgOWCr/YaHZn8t9j6gI?=
 =?iso-8859-1?Q?lRSbrvtiB4Iezi5aeTND4P98MDWwAFpZDg6MiACob1/hXyuVA/jdr+yL4S?=
 =?iso-8859-1?Q?HJH1OITw98vgxfc3fNxtyVVdaRwxitk8h8V0/C+Ndj9oiT3m9vIfVwBqUc?=
 =?iso-8859-1?Q?lU9jXDc9aUqslw/X3FPfCw2qMeukFp+ElVv0vE2/tStv24r+hZxi8kxJ1F?=
 =?iso-8859-1?Q?xiu489rNLamPP3lPXQYivzMMePfHpCdMn+kwvXCSAe2kxUmmfAgSFkaXRv?=
 =?iso-8859-1?Q?66S0EH2QrG5abQu5eUn5MMh6FLKaTLobvX0aGp98KfXVsi?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1031a32b-e5a9-4047-f260-08de48302e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Dec 2025 05:48:11.0211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xIUp8TScx0rkcm0NeybrJuQCZKQLbcFan0RA4bsn+sq3lpzWtSgB4FlG0dvrYarDOxpBGtiRFNZWnKjZhD6arw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489

> From:=A0Jeff King <peff@peff.net>=0A=
> Sent:=A0Thursday, December 25, 2025 9:45 PM=0A=
>=0A=
> On Thu, Dec 25, 2025 at 11:38:30PM +0000, brian m. carlson wrote:=0A=
>> I think this is from `should_pack_ref`:=0A=
>>=0A=
>>=A0=A0=A0=A0 /* Do not pack broken refs: */=0A=
>>=A0=A0=A0=A0 if (!ref_resolves_to_object(ref->name, refs->base.repo, ref-=
>oid, ref->flags))=0A=
>>=A0=A0=A0=A0=A0=A0 return 0;=0A=
>>=0A=
>> So Git is going to need to verify that the object at least exists.=A0 I=
=0A=
>> don't know why we would need to _open_ them, however.=A0 Perhaps someone=
=0A=
>> else has ideas.=0A=
>=0A=
>The packed-refs file stores tag-peeling information. So pack-refs opens=0A=
>the object for any newly written ref via peel_object(), which has to at=0A=
>least read the header to get the type. That call happens via=0A=
>write_with_updates() in packed-backend.c.=0A=
=0A=
Thanks, this makes sense. However, since jgit needs to peel these objects a=
lso, it doesn't make sense to me that this would be the bottleneck unless g=
it is doing something terribly inefficient here. :(=0A=
=0A=
Except for the fact that repacking objects made it faster, my observations =
make it look like it's the writing that is actually slow, not the reads. Co=
uld there be too many small unbuffered writes, could this write path have m=
issed being optimized (it likely isn't used elsewhere)?=0A=
=0A=
-Martin=0A=
