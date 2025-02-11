Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2136.outbound.protection.outlook.com [40.107.212.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD1526A0B6
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313524; cv=fail; b=eKxfg5CYoh11EZWvGi9jKAqN5LZF1S2vdREGDiKrwlWmq3qZp/tzIJsQcAVhMPVNI9+4/taFjnN9irX9zqux38KffhqL0GUlXuVaGSK+DW7uicwa+R6q/NiIe02VEANBp70EArNx1mnn7MzZiCmrpwLar3jEtm6FchQWJnRfXEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313524; c=relaxed/simple;
	bh=8IIHalEg7UhK4G/YQSbbnKfXTchy7EkXPJIyyYPJsMs=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PbXiCSCe6R6aMqGIH3ZFthIRrX6146Q0OdzVod53X8U+XzDlTu/tUROPqTUZErOKvT6VNwdjgSGj8L3p8DcdTR3jMHpnmf5T1BOhilHwa0bIgB4K5owOuC2Ll2pF5jUS8ZoCRCF6FN19zwB3wwi5zbLYq/M821Hv5f+0z+fgv1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inertial.dev; spf=pass smtp.mailfrom=inertial.dev; arc=fail smtp.client-ip=40.107.212.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inertial.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inertial.dev
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxtTU8sa5A0gB2oEEzA2NyMHuhktONAJZBgJtMwjoPO0cSdT2BUbDqWSEVE6pDs1Wx0Scylf0qI6Q4qYHHj4QUxXQ4+mVOWGiikdSAkzaF6TVxq61XhOi/btjox3u+9ckjcFVqxcNcX0coXwC9C+/3oJQDVZI3x5v1t0qozQqij6kYV/TT/3HTjfO6df68X0ql8fURA7H2AMUWTWfiyF1ecE66dZ5wjbqXSoyj7AzQajvWP7676AcHdS+nd9dUCI1qrrSNRqD2vgkVi/3JcDyBvIX8Dea8LpF9jNHXj0iEXvcU4zZEvFKh9/417nJtZyAj3YIyFMRBIfFmddcxNFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IIHalEg7UhK4G/YQSbbnKfXTchy7EkXPJIyyYPJsMs=;
 b=VkuRR7Mc9MS0PnZ9CGqwGIYaP+pm1vyCgjh3HBr1HOxVZAVMs9H1ba53NN5gQNHk4XmpVsRJjeW0LhZBUqoKUpG/+lr4Z1zSA9y9w3KIA0VfwS/DBKITuGwSUde23PAYAy6xujSXfJgp8TbDmMDsW/0ZD57B31jpasmOMrG40EeFbk4GojXjuvjVng91LUMy1Cru9VPC3Yn0aRwKG+li9ChKH990hbnGiaIldgsbkXtfZpwSBTWnl2uLV+GIuV9trY2rTVnDE+LsYla2wOuzJLhCht6dOq1piXY90IoWMAzUIn3JFCRaan3zHEL2Ob2qSj7u5V3+sZEk8YRIqXTgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inertial.dev; dmarc=pass action=none header.from=inertial.dev;
 dkim=pass header.d=inertial.dev; arc=none
Received: from BN8PR20MB2273.namprd20.prod.outlook.com (2603:10b6:408:c4::22)
 by CH3PR20MB7419.namprd20.prod.outlook.com (2603:10b6:610:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.10; Tue, 11 Feb
 2025 22:38:36 +0000
Received: from BN8PR20MB2273.namprd20.prod.outlook.com
 ([fe80::80bb:3c2e:c015:129b]) by BN8PR20MB2273.namprd20.prod.outlook.com
 ([fe80::80bb:3c2e:c015:129b%5]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 22:38:36 +0000
From: Brian Celenza <brian@inertial.dev>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Question: Git protocol with bundle-uri advertisement
Thread-Topic: Question: Git protocol with bundle-uri advertisement
Thread-Index: AQHbfNWE79vsjBz6G0qHsAHLYUtIhA==
Date: Tue, 11 Feb 2025 22:38:36 +0000
Message-ID:
 <BN8PR20MB2273206F4E3691B12AEEF072D5FD2@BN8PR20MB2273.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inertial.dev;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR20MB2273:EE_|CH3PR20MB7419:EE_
x-ms-office365-filtering-correlation-id: 1437bcf7-2831-4661-bfd9-08dd4aecd2e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|7055299006;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?fwSkk3BUxPI4VHg14egmSxGik3yX0GMi5xgaz69dTejdZXSl284TfCH2?=
 =?Windows-1252?Q?CMg3UMessDOVvpYzROg6S/8LhFquYOdsIxyPEVP1dCzFy9T0vzU/I5aL?=
 =?Windows-1252?Q?RUnetciz7PX+s/qkHn2Ot79MAEfrwyZwEmXiFE4WGk/hG3ldTeXOfbHS?=
 =?Windows-1252?Q?In4AM4lXQE401VsnGzkhyVd/2Ukw0qgwN2MLcOohu9dY9vhbpw1PVwzS?=
 =?Windows-1252?Q?UJYCwyeS+N5LvGYEaYfWpy4c6D86uB3fz8WjVwgmEo//3UKVgZ4a6l6V?=
 =?Windows-1252?Q?B7bM05hC8ueD+E9B6QMEIlvut2D+tdKoLx/EmykEYu6FKZP5UQHF/gSy?=
 =?Windows-1252?Q?8cQ4ImJE6exiRJDyDgv0LVxLrAWnAUMOaVcoYNsNbehNrBm8P9APdi4T?=
 =?Windows-1252?Q?Ya/Yk5zs3iNKgRF240KTZNVHvYv7bsOrmncMFyJXl5XmnR6/MGSGkR9u?=
 =?Windows-1252?Q?MZS8OXIj9tBPj7JbP9FqlQhop4N2ZzPdSYn5AW6qZT0RdJEp4fUilPu+?=
 =?Windows-1252?Q?tQz1gKAb60ROnzAeIS1zIzw8LwA6H5bpxQaXbZcPOBR6KTpsAgSc7MoS?=
 =?Windows-1252?Q?q0e9ktTlB5Bo0fjRxxIdtqJdVXXbnrdK3RGrg7qBTKTRbdPDVkpNyIEM?=
 =?Windows-1252?Q?evIMj6Im5tHrmZ2dSEsmR/PrLUCHRE6smCiEDablJ2yEMZqCVBed37IO?=
 =?Windows-1252?Q?vkRsPPTbsjKRlxtIILWt1qgm7montVo3Ejs9lNURC89SM7p2yHq+c0Cy?=
 =?Windows-1252?Q?6Tj+Q6vhyNvKhx7OxpZd3x5hv3+olIu4zf2Xi53IVUdYhq8ru2ingnoO?=
 =?Windows-1252?Q?2TKsvNv1SCnx1k3MW3kyfPdir4BLUFodbh9C2nYYDBmu3bABIIReKfFa?=
 =?Windows-1252?Q?xqS9i43tCKn16YyoXRlZm0Lku5iQKkdvj0Q9bALG3WTgGYxM9yrzuW0h?=
 =?Windows-1252?Q?86rSDJrKwBEwr43AIR3zQo/EWGkGZEOjg7R9CU6PE6p30ArhOMQUwo0M?=
 =?Windows-1252?Q?2iiEA0smMHoLAwk5tSX/FNGHvnLwcosXNJA6IV6NL3Vx1SRt0G5+U1xa?=
 =?Windows-1252?Q?tcQc36oievlWUg2ZjDmbt2K6giY0pLsbK4RF06+iMyuPJaz3RrrXhR9b?=
 =?Windows-1252?Q?UlSsyUBUVZ5HTqCIq5dLkRzMyMCnVidVVe68lvOCryzq3gchz/iQEeAY?=
 =?Windows-1252?Q?T72PgnKbxnsvnhdpAoat72vNK1XZRjU5S3MSqkqZ6FId2hmygWUacSre?=
 =?Windows-1252?Q?j1TC7iStJBpImgDpcTHFiAOwzHNfuYPoe19PYj/AS95OcGm+kCeCtNzF?=
 =?Windows-1252?Q?Tx7ODVr+JfVL91rrEyetw6v2ZSOiJMDsIyHKfutN6ToMmCZT7p9muM0A?=
 =?Windows-1252?Q?3mXPpbzkhdE+OxNcX+SvRIzUqhK3VeKFZ/YLuG4hu9LMm4n+8tBkgLLb?=
 =?Windows-1252?Q?UqBzVmtzXF99xNC2hlgM7CFlQ0KAwzQ9dMhflJq2LdlAtC/4LzmgA+31?=
 =?Windows-1252?Q?a6iJj4Ry/vN6ZVzNHWMd5lo9dta9dC4ZX2i60kzMRpcOSYVPwx8XD8tL?=
 =?Windows-1252?Q?Cm20NqNATdpCzgI2yJBMaWkvxM2To/0HMIzjSQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR20MB2273.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(7055299006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?rsRJdMtCDeTt3CoR1XenvE1rqpI/jtU+APr21tpryda0lCEoqIoN0NYL?=
 =?Windows-1252?Q?/IayLowcPk/+zAwmqwEwtKQT6EmwmzYwndX4R6U9ldZWoWgRvV5hwsIW?=
 =?Windows-1252?Q?bVSx7OSfr9gDDNjfOMwkw/6pTs9eUSkGApVWaMAJAbEvt447+vkJlodl?=
 =?Windows-1252?Q?7VtFLkXqRVOCtYWm72Ke04c/YaqJpBEIrQYJkPE1cOcvVtLel2UrbDEo?=
 =?Windows-1252?Q?3uGZbo+05MYIzC9U5p89U8Pxim9TlZ9I87JGOHjZuNkGY0Wu+KagZoN1?=
 =?Windows-1252?Q?UvjZ6+EOwpFEbTwSQNRp2fkBhA036oORgw/nTT79vq6wfaqXGhE7nARf?=
 =?Windows-1252?Q?tOPtZSdUJNW/ln0STYkcCDSuR39ug1owAf5+hiTeycgnppBls1taenBf?=
 =?Windows-1252?Q?vCAqCX6xKZSAZWZ7ewU661zyYsOtPLWSFPjf9i1H5jKA9zKjp8hFKFuF?=
 =?Windows-1252?Q?ROYB+RATpBs7kWRun4m5akSFTInxwsrk4KrcdNGycpUrPbjCdxEI1Xeb?=
 =?Windows-1252?Q?kNQhurDi9YuAXVP+9ujA09RgBkR45txnM6jwVB8Q1kdzLmegELywT0VP?=
 =?Windows-1252?Q?HxEONrIeEiIHs26n7Pfu76brOlM5ipgS8BmrMDkUCwMULqU5eADPynxa?=
 =?Windows-1252?Q?TiAYNm9+v3EKjRD6p1ywXcrgwOhqpfIS2hSyKZfXCF5UAP315xzb8bNU?=
 =?Windows-1252?Q?6egi7D+A82ChLU6TAShZaZ4M6H9RKOX3lZCf5k4PMRsNBrXMrOxTbakd?=
 =?Windows-1252?Q?vpnW3Elu2GKCGkiD65BRtjvwNXE9ra6BO6Zgg6OCkOMAARyhuIgWanOl?=
 =?Windows-1252?Q?OOQtwX6L3qMbBuLjbjPEbS7BLwivD0tCClR65oVA4XGFMO88pkRzqV1o?=
 =?Windows-1252?Q?K+txCdZwJum4riGhwbrJdlZIJRc9GjbbIPxoP5SXN4DJ4gkUpNF0U2RH?=
 =?Windows-1252?Q?z1l8QDNmP6qWC8XgwCoaPpAhNFSRJiPqAZZHDzO9Bxt4EmpqBB4d+KHi?=
 =?Windows-1252?Q?lRSuR2QDaZZiWLpqz7vP1EnUxLqcEW+UM/CH069Y5mu15lyQ5IkBrOWO?=
 =?Windows-1252?Q?ykM0c4/sTsxZorY3MLJzFNnYsOGs3JxHwYN0LWEn5u+wRvZlxDzsT08m?=
 =?Windows-1252?Q?P6N2G3hLhr+uv4w6zGK7j3R/ufbl5PIEsJMUs3eX8HFL71dmMXIq/Bof?=
 =?Windows-1252?Q?WE2MrW1ypghFBxDJ9ZrEvvWguBy5kHf1iNXV4XhZqfWZ1GraPUlMIKao?=
 =?Windows-1252?Q?mQjPYLGz1zLfqqImBnUKZtgeNuii3SFo7azRJ2pDKXXeVue0abNSvm/L?=
 =?Windows-1252?Q?C3gW9Y9rScVyfTE7uC/OnsQA98Ke51e0Zb8B3lhNoHOdv8nh7NguHZCt?=
 =?Windows-1252?Q?n+F65LNla+u1LUP/aMzPUHfhsBtYmKtk2ndovhH4w0KT1js7T7MjKAbg?=
 =?Windows-1252?Q?nyOX81hbWUIQ3KY3kfQDAQ+QH+h1mvDtDzkaEWlkHwspDAeRitrj2o0h?=
 =?Windows-1252?Q?TCwm/7e+CLG/pNmu2D4cKBYsLv6w5YMxxoN8cjQFiAAFyQvqZvrkbD2+?=
 =?Windows-1252?Q?65mMTyG8QsZidZI5QdatQMWdqM4upPBrzsREZaQIQdi25tvl9o3SHvsa?=
 =?Windows-1252?Q?LE2U7lK+3LCYCze+Y72cxaUsAbhGazVBuKoNNFEEWtqXYn0gczbdYbFp?=
 =?Windows-1252?Q?ULcdncGe2iA=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: inertial.dev
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR20MB2273.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1437bcf7-2831-4661-bfd9-08dd4aecd2e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 22:38:36.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: abdb5251-fed1-414a-a162-06fac411f40a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPxfIAXFNkNu0rCPtidJH5lTsRxpCWILPGT0VSjbNfadte0ndVSvf9D6poqRo21Kcf9YJBhX8VpHS2YnQ+gOrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7419

Hey all,=0A=
=0A=
I=92m working on a project that uses git bundles and the bundle-uri server =
capability and had a question about how this works with the git protocol.=
=0A=
=0A=
The goal: advertise a specific bundle-url depending on the type of clone (e=
.g., full or filtered) requested by the client.=0A=
=0A=
Context: When the client attempts to clone from a server that advertises bu=
ndle-uris, there is currently a strict ordering of the operations that occu=
rs, namely:=0A=
Capability advertisements from the server (including `bundle-uri`) and clie=
nt=0A=
`ls-refs` command sent by the client=0A=
`bundle-uri` command sent by the client (if enabled)=0A=
`fetch` command sent by the client with options (e.g. `filter blob:none`)=
=0A=
=0A=
Overall, the command ordering makes sense: to know what to `fetch` from the=
 origin server, the client needs to download and extract the bundle first. =
However, if the server wants to send the bundle that best fits the client's=
 intent, it must guess what that intent will be, which may result in the cl=
ient receiving more in the bundle than was intended. =0A=
=0A=
Because the fetch command occurs after the bundle-uri command by the client=
, the server does not have the opportunity to provide the client with a bun=
dle-uri that=92s a best match for the filter options it will eventually tel=
l the server about in the follow-up `fetch` command.=0A=
=0A=
The question: am I missing something, or is this just the current behavior =
of the git protocol? If the latter, is there any similar prior art for how =
a client could provide the server with some form of hint about its intent (=
e.g., =93I intend to fetch with this filter or depth=94) ahead of the `bund=
le-uri` command?=0A=
=0A=
Thanks in advance!=0A=
Brian=0A=
