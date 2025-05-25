Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2098.outbound.protection.outlook.com [40.107.92.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763BB53363
	for <git@vger.kernel.org>; Sun, 25 May 2025 15:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748186404; cv=fail; b=T+7FTjHbI6KreZMm3DeyT5ZGecJ9Mf+kIP4PiESi6I64sIcXjlwbNjOzhJfqh9XvVMkWUowqfcCbe7NEuJPjP+uIT+z9SlAOoEtxeJVs/T3UcTn0fIRuHoUA4hcy7kHUGarYTd95odN1+oANAhCEjcO1FF4KMj6GfhfVNcv72aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748186404; c=relaxed/simple;
	bh=ON1t+t1qY4VfI9A+IXEJ4gLW2mWc3hjfh8nCyTn4k3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XBcL7u3CUKPNU19VOkkX1bt+HlErXBYLJrK1mX8gWcIoMJULOT+Rpeu6K0dgtVUtnEi79D1oQvlGV7eq6WWWFN/Fj/KFHexZ7kN+ojPFKgeG3aaspEQadsggWqiqW3O8VRLmrEDJ7Gsha+OMTyOnFrZvA4HJpJe9nSdIx5PaY4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purdue.edu; spf=fail smtp.mailfrom=purdue.edu; dkim=pass (1024-bit key) header.d=purdue.edu header.i=@purdue.edu header.b=fVWi45ZY; arc=fail smtp.client-ip=40.107.92.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purdue.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purdue.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=purdue.edu header.i=@purdue.edu header.b="fVWi45ZY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9Bj+rOy+naUc2xCg42Tfh3vV49HBwNySFfzEPv43zt7xmmqr0VHkUjjT9qikAdiKcDIKQYn2Zm2BQ7SlotQ/6CJZZ38z/ooZVKiQ/SFcU7Uw899O0SJ9rrrylHHR3HsA4mwZBdD0fQF1rUQ6reQ5E98a1h0qzLgGsfFyCMzmeLVBhNMkJ/pSh23XeosDp/ba32bjZoRjUuVI7r885EEpXc0C3QhhasuzsA6LXD65lNWWNlEb337eNDzttqElL6Rk9HhrotnoJp6lnT3Dac4rA5vPaiNGYuhiwy7hWJmFErTKUuARqByK4bLducuqYPHDSlBTKUqwzuwMiS2HKVrCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ON1t+t1qY4VfI9A+IXEJ4gLW2mWc3hjfh8nCyTn4k3o=;
 b=MEKHwXsqs1KuvAKErqp/EimGKfUVE/6fyNUQSqEer9YUEemtBEDzg4SUvVikfPzX+GsBTD8dxnqOmAfo1+7sWHt85BcNChY1plvk7irJ0KCwBljkRXvdsNfAH7XDQ9gBiqURQpwqyKcnuaDx/RAtZ5E+4tfVc7I4r5iE7vO+U2ye89UL+DJ2cFojI5XBxr8PeQ7XVFbJSLoAQyQddRX3C1c7HwcXhpP8TVYDhcX14MuDTB8xD+R0c7Vtdu35n+xo17JRdknH0zVy3zJZwnCPlGsWE4PP5Jq4/8qeJyhCa2PaY0IqCJFs4UazbXVwM1AEGGxServsDFfjUAF9YhOfag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=purdue.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ON1t+t1qY4VfI9A+IXEJ4gLW2mWc3hjfh8nCyTn4k3o=;
 b=fVWi45ZYtfnZxSjKBx8vvPDpNZtzLRRxTomB7wPhiTXTyqzMibWnlye8zi61c82aAUSM25eu7bldT9zHNmS7//yu2WiaW855BATDTTaI/G/unidsyrX3oZsfMPDEGdHB865QGX3j4qURcSXHMwj+OVO4tfbLr6S0ZKmkKEsWjgE=
Received: from SA1PR22MB3999.namprd22.prod.outlook.com (2603:10b6:806:324::10)
 by MN0PR22MB5688.namprd22.prod.outlook.com (2603:10b6:208:4c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.34; Sun, 25 May
 2025 15:19:59 +0000
Received: from SA1PR22MB3999.namprd22.prod.outlook.com
 ([fe80::a1f7:3705:aa9c:6392]) by SA1PR22MB3999.namprd22.prod.outlook.com
 ([fe80::a1f7:3705:aa9c:6392%4]) with mapi id 15.20.8746.031; Sun, 25 May 2025
 15:19:59 +0000
From: Jinyao Guo <guo846@purdue.edu>
To: Junio C Hamano <gitster@pobox.com>, Alex via GitGitGadget
	<gitgitgadget@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Alex <alexguo1023@gmail.com>
Subject: Re: [PATCH] Add a check to prevent max_children from being 0.
Thread-Topic: [PATCH] Add a check to prevent max_children from being 0.
Thread-Index: AQHby/6tNZB2LRwtvEiHrzIKEY8GNbPgmlfPgALdJIU=
Date: Sun, 25 May 2025 15:19:59 +0000
Message-ID:
 <SA1PR22MB3999A0C9E99E607A793A591DE49AA@SA1PR22MB3999.namprd22.prod.outlook.com>
References: <pull.1975.git.git.1748017238130.gitgitgadget@gmail.com>
 <xmqq1psfxgyv.fsf@gitster.g>
In-Reply-To: <xmqq1psfxgyv.fsf@gitster.g>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR22MB3999:EE_|MN0PR22MB5688:EE_
x-ms-office365-filtering-correlation-id: d0122fa8-f78e-45b2-68e9-08dd9b9f9d26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?P3ZjJ4NEo9NWazqFua3IgMJIUnO4IY8Y3OeHt8Hu5URSwQs1JmyM87hqqn?=
 =?iso-8859-1?Q?5rE3MhR0YF3Pnv58LkVDVIKustq0I8oeIQ+WIec+b5MrsidBKUPJLx5JM8?=
 =?iso-8859-1?Q?kh2fEPimG7yv/6kgvu3+A8wZjbeZdib2FqzPKXGaAsOmeSRWkoLC1OkwWi?=
 =?iso-8859-1?Q?Z5bZzHiI+oM6NnZ/WYnQno+ljzSIJWRV87gPTHHL6BlvEj0TariRglkWEq?=
 =?iso-8859-1?Q?C31KJOsVt3qR6BACXo5MT9pkYUrqraBU0Uoditq38dz+EdEhx5/RLiGk0w?=
 =?iso-8859-1?Q?t95s+K6HaPPsNDSMhJVYR8dK7vRBOl+wW8j1NftMZpSU3X3bqmZ6GNRLXF?=
 =?iso-8859-1?Q?0FzAwmhh1FTCv32R0wThwn9wMqq019V8ucl8LXaVe7LhYvDnIYqHGK6gF0?=
 =?iso-8859-1?Q?83Xh2EXXc0xBmA9JUfNK0PivdfpD15KHEuJmP7fZQl8sRUbV3o0eBFaY6z?=
 =?iso-8859-1?Q?AIJADLatGbk3zhjdi7xB0SFhTis1WNmGpxQdkEAaVqj1f70dR1N6JLm2OI?=
 =?iso-8859-1?Q?ZwHtsuXv8q2CatX99zPV/+I0dhL4xzEkCMg8iG/msrOnTuM1kzL4XitfkQ?=
 =?iso-8859-1?Q?6hpx9zTzkuWJ+/wsPehaHNYYmeU5aD7/yThWA6XcSXW7M4ZfnQx8aj5EiN?=
 =?iso-8859-1?Q?AIbVMezQ/oF4T4BYFjGEvdcJC2k77tS24p6cYUWX17LruEORKBbUhhRXPz?=
 =?iso-8859-1?Q?GQz7GK+R4CX2fE0MDe+LTnMxaEVIzV69dE8ITjSte3+vRmTaIGtW8A40K2?=
 =?iso-8859-1?Q?b5ANdYohGpNw/AB+g7JZ9rBNwfiUzMmGIHBXqUscAPedbtDpzI2qrOJXy9?=
 =?iso-8859-1?Q?x0rEawV76u/8P534Jrnj7C/ennpglUnUuCXzLQgMYWiXrlBIHy1ZXgherb?=
 =?iso-8859-1?Q?EakbOjOCECEbRAt1oUITn11lKIVRA34eoFt3IwNsIFHXSc0sDmkRzYpfqn?=
 =?iso-8859-1?Q?+2qIK7efLl6VEga1x8daVy+R8rkBpGydVBthQVQ6XozD2bq/hmbm3eLoFf?=
 =?iso-8859-1?Q?OOLJQTzZejoEJWm1XAtM1oW6v4s5zT5Zh3AALs2j2sYI28zLGgfznHI4Ft?=
 =?iso-8859-1?Q?UsJCLfbzERLU/I7CQb73GwgrVF/l5ieygDODwuhEquIfNHR8VG4Cj5P+E5?=
 =?iso-8859-1?Q?EK5u5glskB65//JisubG5qDd/i3W/ZhDgbp60MOkhNYUpErarrv+yYlTub?=
 =?iso-8859-1?Q?hXZanOrs60FxuEMHcIuB/twZOlBSk/JcJ3p5SYkQ1mSIbO9aiOu5tbS9dd?=
 =?iso-8859-1?Q?lVR9n9f3LnCGCtOT9GVHHYo5SpORZSKERGj+O1TTzOjlAnLV3I5mkWHV7c?=
 =?iso-8859-1?Q?Tdji/wOFHNjb6OhvvhydUVzUgI+AiH7PVqwrmoNtLqfchqW24AtZMYlrHG?=
 =?iso-8859-1?Q?RTtKScxLItv4lJ9RJoiwRkUqi3SBQJ60+XaOzvcel2P/YxrGLv9QJbNjyE?=
 =?iso-8859-1?Q?5rT28HJ7usTMlENbVZ/naJ4Dz8yHH/90IoFk45Nq1abScSdEiX1WH1LpHM?=
 =?iso-8859-1?Q?TsDVTpbabmjqIMr1Y6zZpuR0QEJ4+JL0M7ETxLfpIjqQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB3999.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Ax4PhtnO6Mwoy9mX8vAp3PlgJlBojWi7WdIh6JiFfeQ+lfOo1LEjrpi3SF?=
 =?iso-8859-1?Q?0NP4Husrxky4kb8IOgcGbTMnspmu5xiTJ7CxawQoIgO+ssgAGtmJK0dPWl?=
 =?iso-8859-1?Q?j+dCOUSn1eWDvULYw5KJFClrcX2yvwvxU7E+phNDl4dpHI1qfmHk+Ign71?=
 =?iso-8859-1?Q?OltYq++o6vM3v5YCAqeEU49eVkiqd0hxO1y2xuXlkb5PfqjFnH0tBcuaEi?=
 =?iso-8859-1?Q?ARhNEoHe9lM9+5x5PAnDqCaXVhcrs3DJew2Qvc7UvL4Rt3JcbGwQlWQ6oV?=
 =?iso-8859-1?Q?k+mTI0e34e1TX0FlGXPEUn7F2+fCDcGQk0icDHGVVDfadSx8ZxcWdphVy6?=
 =?iso-8859-1?Q?NqN+ziWb3KpOy1J0GaZMO3/mdx9aFeGlbnpkL/5Ax+wjsn/AhWNd+fsJaG?=
 =?iso-8859-1?Q?xisFsesqzxqLSpVAs918eAbTb+MHslvFx8TdpHl8on6jYQPlnhD0YzmuV5?=
 =?iso-8859-1?Q?Nry0DZhm8MvTAx1Pi9sRL6RETgKmNFjGxbAgeaLpzHls0zWEByQPjjoQD6?=
 =?iso-8859-1?Q?LINYxaBg1in3dkcAKBFRRO1BbvYONLehfPgyAp+JKflVpaqqY5JtEJltc1?=
 =?iso-8859-1?Q?ScK2Y2Iyt3gbb8qmp93JsuUdZxCr1KdI5+W1vpqqBlqPoxHT4Qw4NJqttQ?=
 =?iso-8859-1?Q?x3bAXHVIX2ylqpiB4rb/5EszsAGJXeOWUdIOkZgxNIymMv06NfSxOl5TtX?=
 =?iso-8859-1?Q?MUCulUqyr/HhsB7UQORlfdFRes+t89gZHgn5sddNr7QLOA29ot+DNC4pZo?=
 =?iso-8859-1?Q?7iK668XXyLv9654MQVthv378wIR17WWCxWYUrNFGQJndiLbxAcYCoBSvAs?=
 =?iso-8859-1?Q?sBtZqbo1Mj7TV4C59fAQAC3/0aiCBrmdGIaHy9oLtrqogc2UppJFHkOo8d?=
 =?iso-8859-1?Q?Fn+1lZQjIFLTWNmnShaY6gxMj/KlrQIy3KnO0DDtY2BCv4J63IlZAEt0XF?=
 =?iso-8859-1?Q?tq5Qet7SYTxGVmw4LWzoXD6yrL71mqCqcGYL5XvOLadrVsfUJMB+8kGezv?=
 =?iso-8859-1?Q?4KIc+HSM8mMMtRnLrkGAPiHy5qfj8xYxQpDD/LxdXTSL649qKae2wQaSCg?=
 =?iso-8859-1?Q?gw7UZLSvRsRejumvHDh5MyXYM8cBsqueXaUUvDOS9d6fsLk+aXgwFpLkpp?=
 =?iso-8859-1?Q?AIUiMny4jasA+mnt0k4lZpQxUpdehN4+iAdQj4X9/e6Nt1po/RpyzkMJIa?=
 =?iso-8859-1?Q?KpMURAB3t3oSkTgf5Lakoh3rDr05P5GslG7OM+K8xPKK+rLx2AfiyBCUnW?=
 =?iso-8859-1?Q?5NXISilVXLdG+61iKxjHOvCCqwMnUNa+BUOCN6MB/VQLbq6KbWOnqX50ym?=
 =?iso-8859-1?Q?ui+OkhVEGwoYkcDltquaYUUjEh5kNB30GuofExN722N0dROBiV2olhwre8?=
 =?iso-8859-1?Q?IwKNoQ/iietcIA0cX2FGB4hlR/YKXwFehQkLR4IWAqFskVfup+PAsYjfUt?=
 =?iso-8859-1?Q?Cl86Nn+HEv4TRGem3iAeD7V76qqgOQEGom21EqgbgSPE4ca2LrMSHNC0ho?=
 =?iso-8859-1?Q?M93MvIFtqJfZNIb8ArheA6TUR9beXaWgUvnK5PP3TPpT/ikIxYqe8zdFnk?=
 =?iso-8859-1?Q?7extengoQS8X8n2TsZed4ACC+IWRvAm0I/Ppfjof1b95bo4/vT8UA89WQu?=
 =?iso-8859-1?Q?grC7hI3zFlkgTp4BADOCWYWjWd3P9WvnLFDOz+luKs0BMj2SuYn1TIXQ0P?=
 =?iso-8859-1?Q?FKePfubnv5BnjsWKOxM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB3999.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0122fa8-f78e-45b2-68e9-08dd9b9f9d26
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 15:19:59.5108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h9sZHLejlFRJeJ7UzP8tm/2nsxpDJIQBNQz1o0aa87XofSfE66joc2CwqOvHyJvgXXjUShFB2GFjeXgwQkmM6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR22MB5688

"Alex via GitGitGadget" <gitgitgadget@gmail.com> writes:=0A=
=0A=
> From: jinyaoguo <guo846@purdue.edu>=0A=
=0A=
This name (i.e. the author ident when you do "git comimt") ...=0A=
=0A=
>=0A=
> In function fetch_multiple and fetch_submodules, `multiple` is=0A=
> stored in `opt.process` and later used as a divisor in function=0A=
> `pp_collect_finished`, creating a potential divide-by-zero if it=0A=
> remains zero.=0A=
>=0A=
> Signed-off-by: Alex Guo <alexguo1023@gmail.com>=0A=
=0A=
... must match the name used here you sign your work off as.=0A=
=0A=
Unless you are forwarding a patch that is signed-off by somebody=0A=
else, in which case, their sign-off comes first and then yours.=0A=
=0A=
> diff --git a/builtin/fetch.c b/builtin/fetch.c=0A=
> index cda6eaf1fd6..b668187627a 100644=0A=
> --- a/builtin/fetch.c=0A=
> +++ b/builtin/fetch.c=0A=
> @@ -2591,7 +2591,7 @@ int cmd_fetch(int argc,=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die(_("--stdin can only be us=
ed when fetching "=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "from one remote"=
));=0A=
>=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 if (max_children < 0)=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 if (max_children <=3D 0)=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_children =3D config.paral=
lel;=0A=
>=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* TODO should this also die if we have a pre=
vious partial-clone? */=0A=
> @@ -2613,9 +2613,9 @@ int cmd_fetch(int argc,=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct strvec options =3D STRVEC_INIT;=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 int max_children =3D max_jobs;=0A=
>=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 if (max_children < 0)=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 if (max_children <=3D 0)=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_children =3D config.submo=
dule_fetch_jobs;=0A=
> - =A0 =A0 =A0 =A0 =A0 =A0 if (max_children < 0)=0A=
> + =A0 =A0 =A0 =A0 =A0 =A0 if (max_children <=3D 0)=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_children =3D config.paral=
lel;=0A=
>=0A=
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_options_to_argv(&options, &config);=0A=
>=0A=
> base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0=0A=
=0A=
I think you may have identified the right problem to fix, but I do=0A=
not know if the solution is correct.=0A=
=0A=
If max_children can be 0 at this point due to loose parsing of the=0A=
end-user input, the config.parallel or config.submodule_fetch_jobs=0A=
configuration variables may be set to 0 due to the same kind of=0A=
loose parsing.=0A=
=0A=
The command line parser parses -j0 as max_jobs=3D=3D0 and then calls=0A=
online_cpus() to use. =A0If the function returned 0 on a platform=0A=
whose online_cpus() implementation is buggy, max_children may be=0A=
initialized to 0 there. =A0If fetch.parallel is given 0 by the user,=0A=
config.parallel gets value from online_cpus(), so it has the same=0A=
problem. =A0submodule.fetchjobs has exactly the same issue in=0A=
submodule-config.c::parse_submodule_fetchjobs().=0A=
=0A=
But otherwise, I see no plausible way to have max_children to be 0=0A=
here.=0A=
=0A=
And if we want to protect a buggy online_cpus() that returns 0 or=0A=
negative, which probably is a good thing to do anyway, perhaps we=0A=
should do so at the source of the issue, perhaps like the attached=0A=
patch.=0A=
=0A=
Or if you are trying to be defensive to withstand the change to=0A=
other parts of the code that may affect max_children coming into=0A=
this function, I think it is better to add=0A=
=0A=
=0A=
=A0 =A0 =A0 =A0 if (max_children <=3D 0)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_children =3D 1;=0A=
=0A=
before we enter the trace2_region that calls fetch_multiple() and=0A=
fetch_submodules().=0A=
=0A=
Hmm?=0A=
=0A=
=0A=
=A0thread-utils.c | 9 ++++++---=0A=
=A01 file changed, 6 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git c/thread-utils.c w/thread-utils.c=0A=
index 1f89ffab4c..a5d644bb38 100644=0A=
--- c/thread-utils.c=0A=
+++ w/thread-utils.c=0A=
@@ -36,7 +36,8 @@ int online_cpus(void)=0A=
=A0#elif defined(hpux) || defined(__hpux) || defined(_hpux)=0A=
=A0 =A0 =A0 =A0 struct pst_dynamic psd;=0A=
=0A=
- =A0 =A0 =A0 if (!pstat_getdynamic(&psd, sizeof(psd), (size_t)1, 0))=0A=
+ =A0 =A0 =A0 if (!pstat_getdynamic(&psd, sizeof(psd), (size_t)1, 0) &&=0A=
+ =A0 =A0 =A0 =A0 =A0 0 < psd.psd_proc_cnt)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (int)psd.psd_proc_cnt;=0A=
=A0#elif defined(HAVE_BSD_SYSCTL) && defined(HW_NCPU)=0A=
=A0 =A0 =A0 =A0 int mib[2];=0A=
@@ -47,12 +48,14 @@ int online_cpus(void)=0A=
=A0# =A0ifdef HW_AVAILCPU=0A=
=A0 =A0 =A0 =A0 mib[1] =3D HW_AVAILCPU;=0A=
=A0 =A0 =A0 =A0 len =3D sizeof(cpucount);=0A=
- =A0 =A0 =A0 if (!sysctl(mib, 2, &cpucount, &len, NULL, 0))=0A=
+ =A0 =A0 =A0 if (!sysctl(mib, 2, &cpucount, &len, NULL, 0) &&=0A=
+ =A0 =A0 =A0 =A0 =A0 0 < cpucount)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return cpucount;=0A=
=A0# =A0endif /* HW_AVAILCPU */=0A=
=A0 =A0 =A0 =A0 mib[1] =3D HW_NCPU;=0A=
=A0 =A0 =A0 =A0 len =3D sizeof(cpucount);=0A=
- =A0 =A0 =A0 if (!sysctl(mib, 2, &cpucount, &len, NULL, 0))=0A=
+ =A0 =A0 =A0 if (!sysctl(mib, 2, &cpucount, &len, NULL, 0) &&=0A=
+ =A0 =A0 =A0 =A0 =A0 0 < cpucount)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return cpucount;=0A=
=A0#endif /* defined(HAVE_BSD_SYSCTL) && defined(HW_NCPU) */=0A=
=0A=
=0A=
The patch to `online_cpus` looks good to me. We can ensure online_cpus() wi=
ll never return 0 or a negative value under any circumstance.=A0=0A=
