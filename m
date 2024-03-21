Received: from smarthost2.eviden.com (smarthost2.eviden.com [80.78.11.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EAB85286
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=80.78.11.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040146; cv=fail; b=kwUdOkrAp6KVBdWPSh+ddx6gpSfVKqZFfYVtWBBQTXHXHCkcvFQGzKa6i8YmN1DMt4dOvv8eSjbU4MqHQPlhqG5JNQhOK3s67S2zfdZ2kexyvIbPqkqstQIqZGrKqLy0jgnLgbbqestFnJ5noyYhi0GIkOxP+RWTTbwrejfegkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040146; c=relaxed/simple;
	bh=UZzbAMa2atyuv+pWkvIiBuZZw33kVCreR060BI6wmSo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jDSnq1zXmGFumpKVJk2Zk0aM7UR7w3vEMCqVhISJj2WcPnuxE4pfBsgLtzHB349h1st7ssOq4Rc9BsREcOMFAYlF0l02vyCRXdn/P1UqarzMFIGrao9L28no55ZdwlHMhDLl7FsHs8Qgd9+oG/We10HLJAogaJVuWMYi4cw6HWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com; spf=pass smtp.mailfrom=eviden.com; dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b=bh1O+ixQ; arc=fail smtp.client-ip=80.78.11.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=eviden.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eviden.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=eviden.com header.i=@eviden.com header.b="bh1O+ixQ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
  t=1711040144; x=1742576144;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=UZzbAMa2atyuv+pWkvIiBuZZw33kVCreR060BI6wmSo=;
  b=bh1O+ixQmGatfkCxMqhaas31ReGEZveySASiuqZdk/7gwMw+TrbLj1kw
   587tUV058c7qb+1NYqYkRen8N3s/Kn713HQ0G34QDLdw4DxsPn2gqKYwX
   8GQiiDoWtXwlRsDTN2SeiQ99ZhaUR/x8ac/D1ncxaUvCa9zz+DB/9cUvR
   gIePc4sub/19l5jJIsUvyvDim0fVM8AtH+qS6BhBoR9R1nAFojZvUKoIi
   VYwNs9YpFEWpk/yLtxe+trzS77FtLy3vZio17j2JASiZ3/yo3lCAaS07+
   LnKj/xhDat2St0IfGUTCBJ86uX5YVqzZteXZUdH5nxDwa+EZu9P9yYsMw
   Q==;
X-IronPort-AV: E=Sophos;i="6.07,143,1708383600"; 
   d="scan'208";a="8844734"
X-MGA-submission: =?us-ascii?q?MDEytlDFmxcaN+YwWmpsFzOGJgibBdfJ5MW0zz?=
 =?us-ascii?q?Vc+IK3UtTDDKM+RICSOh/pKw2bnj49wpjxNUGECvTaKPTiGKv5+xkDsn?=
 =?us-ascii?q?5X5QhqHtAvhTVSzr2EqiOqqJITdKitoht9X+IAW1mQjh4a/RbF8bK9lb?=
 =?us-ascii?q?Fz?=
Received: from mail-vi1eur02lp2041.outbound.protection.outlook.com (HELO EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.41])
  by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 17:50:32 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUBq4j/CsvCXFi+JkmWk9WE+UkKklLt3mmpt33I4e+XLSplPzvANa+8xEDBf/GEEq8D2CzxZejOT8/4Mwzps9ESzJlECyj55o1yy1faIaADetEJjxp4zJHCMYEtbflRtP7+HAHfGcK6bgcvCLxKbPH9rTXX46U6aLwUtRkkpFnVVNKBDQB/editBDIrv56jb34BTFTNHKmcUKtsjWqmL/GeRdh4q/UG6Js/71kUVhrgbToI+13a4ODMjI9dBJkOrEwyyEhjzRAMX1VErY6Zpvqn6LWi3dfjTuogYGEQbQ7ZOnMQydBWzZFNDxZW5QsBRSK61jXRiKy3UlaaU6SSMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZzbAMa2atyuv+pWkvIiBuZZw33kVCreR060BI6wmSo=;
 b=eJtCERwDkKY+xKeqLcFWFnmxyZOvghMGbF2cqAXo9AWCV9n8PY/Gis+ljLW8XBKW7lfa3w2OozW4WzWnFa5kLHRFgQqAjeUc3EoNA4/tKoTLAQMPgxVIn6Q2NeCmTSD2Ly41458/MS2R3akxqoTawHh7DlsQTIAAyslnMhvP6rh7TcLdwTarcpgKm38YmQC68P88q58TH4CtSWgC2z3Qzq/kaEOd7Cb0+0+p1yme1KjAsjaoeVTF/cj8sgvsJMlr+W/UhgB/PDFlq0VYLGdxxcz/yo13GooLEZ/qgM1l8cM8mw1zg+AbL/op7w3MhQr2zza/LkO1tSI6DgEksLBsfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from PA4PR07MB7406.eurprd07.prod.outlook.com (2603:10a6:102:c8::16)
 by AS8PR07MB9545.eurprd07.prod.outlook.com (2603:10a6:20b:63d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Thu, 21 Mar
 2024 16:50:31 +0000
Received: from PA4PR07MB7406.eurprd07.prod.outlook.com
 ([fe80::a03c:8914:932f:7884]) by PA4PR07MB7406.eurprd07.prod.outlook.com
 ([fe80::a03c:8914:932f:7884%4]) with mapi id 15.20.7362.035; Thu, 21 Mar 2024
 16:50:31 +0000
From: Richard Kerry <richard.kerry@eviden.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Merge selected files or folders
Thread-Topic: Merge selected files or folders
Thread-Index: Adp7r8ohXguDylajRFeMb0SwZpAX+A==
Date: Thu, 21 Mar 2024 16:50:30 +0000
Message-ID:
 <PA4PR07MB7406FAC1F8C00E29979FCFF59E322@PA4PR07MB7406.eurprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ActionId=ac09ca5b-227f-44e1-bf27-071bc299010b;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=0;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=true;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2024-03-21T16:49:21Z;MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR07MB7406:EE_|AS8PR07MB9545:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Emu/Ed3F9bxZn8kT92sU70fXVFhHSUdtx08iAeQyVMfsNP9AjLUgPqTldOFs+citc4jvgF6g1JlsSia6bc92+Ht1PesD08Djrm/Er09Cu0d3Oi/AvT/2YToXjj/ESqtTOEBG2f4UxObO4t4ZD1EUNFIAfZiESRis44T9Bx4hr5G5LO/dtj2HzU8hC4pAJS/Ac4Q03BJZ37M0BpLf6jobTgFN3mAE4iuSkDN7E6VkNbONO61BjxKhvuJRieG9MQZ3MMrju0245p0cb2kXBISR6q5goqvFQUlYXyfaHQrz7M3DToOVGRLFG7Y3Bc6xfgHXpeEo61JH1+UGBpu8y2VcqJDhPju0Kn2mkpVaLVaj+93jfwqi0UQHrGqImlWG0CTpAomeHR9fMI0aZDXgXROTNtScSTUZitl9hxrkvtLFDvdeoNtGCqAxfOa96K5MU7f140WO3hC5La3/8azaDa4dfWVdOSTE+imyTYxiObmiG+Q+r0qAEJmsxzeGu2RNQZu3Q3GLxTdGmRY5658ECxv3DUIj7dZlExSRydhT+Qg9gz6eZGXyU2fSJZMNyug3n238V23DZt4YZo0bqYLDjMwh7iIPOhuk164TjFzlYj97Ij8OfqrdBBbEX/XkqN7V3iRkzF6bLyGNZmutW+vfppn+NiIijSzx88tFkrUd1OO3j5g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB7406.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?mBJpK1L7gwFTQpinLAwfHRwEdeZwHpFEgOHTl08yZtPJtOz1EnsQr+fzrU?=
 =?iso-8859-1?Q?+o1ECnVvh4QQPOscKi1ifENUhuLa1Sia/y0KkbEyiZoukjvVvph/bUvZnl?=
 =?iso-8859-1?Q?ywIMrnk9+n09EcuX9BGjXvTie0erpLNU82weLeiuWl0gNsNWpnRafx8NmH?=
 =?iso-8859-1?Q?AGmYnF/Yu7bu243iR5u3nwFUeBOoZ+CPGvv+S8fEdQU1d/x7CcIsLwB6mM?=
 =?iso-8859-1?Q?uj3oF7CqYi3Y/BPFIHXVVhDEqEyGzgGzivj3T5rZTNkx0lexrB8GnKoVfq?=
 =?iso-8859-1?Q?9KBLzP/qQtwgoAJ1uu1UAlkF0ezh1czVVwsx7pxMRhIRSYnjUjTrsPWEU8?=
 =?iso-8859-1?Q?864dts6hxD3blaMBn5qhswBcHEn722TSoCLKIYZLtNrjlWaM6f6AoxCpp7?=
 =?iso-8859-1?Q?cE2Nbw1wHTVyC2V/+4OL4AiCYwt0fszZHWnvH0xFkdxYQPna1j8sFhprzf?=
 =?iso-8859-1?Q?16NnWIBaSA006Q7s1vZHAw3g2bJxTP0aB9kq4sPXW3l+pH+5ILrHAFW2I4?=
 =?iso-8859-1?Q?Yxjoy3wiVGYn4tA4ctg8g46taeufK7BNTT2o4zmPvvQ3T3ipMD2PJ2iH7m?=
 =?iso-8859-1?Q?DzBM+/dFQF26J7iQ+TZMCVkUBWcMi7VhN2AmrchunOKgzEx6q6jmSFG69U?=
 =?iso-8859-1?Q?CO0tTXQLfK6F7MFHZZSH7f5ilBci/62IrzNrjkaER0MrenYLNS3Db7n74K?=
 =?iso-8859-1?Q?Orr0tNk8/9lcK+texr4fD6pH/ifHJUBgFEQ7fQvXRSkGsRI78M1yazO7Rl?=
 =?iso-8859-1?Q?1sGpOYf2HjMzdszBOYxRK598FHNXKmAIrGNj9YIMwwz6iwkGSo9HWNfFJk?=
 =?iso-8859-1?Q?wrS7hH4fTdJD0YBvXVeAdasIM0jBNjDtOAofb92+3GJXy88DeHYwAeYBgM?=
 =?iso-8859-1?Q?JTgz8ZJP+VgT24sC+jNoJoS+02VibFUAfeg4n9iNr1UjdXy+Z8sSYTScvq?=
 =?iso-8859-1?Q?dtCGamrV8oZxYOnTqGTGVmmXIq3vEb8W7SG1JVl+UL70H+BFpgpouKEfnd?=
 =?iso-8859-1?Q?low0beMY5E5aofC3pg3QCc9mjArCqeulLVghqga6TJBTDldJBnuHv7cL+V?=
 =?iso-8859-1?Q?MZ2kCTxypo+mMrkw4Fh1lQ0UC++kg1CYMpGPp2Q9dD4MhV0kEPOSvF/HPy?=
 =?iso-8859-1?Q?1Btb3zDtdRLq+1sxzeB0IcuMrSCGue3a3H0z6ARsG/WOHqXfcuaYkOpfMo?=
 =?iso-8859-1?Q?kJrDr/2xIerLxNjU8h10nkqhb4jtpbEjy/8E3BjHIuuCmIR7ujv7tQLe2V?=
 =?iso-8859-1?Q?BkreMe0a9uyiW0hkbxykABQ0CNbyJEpY/X8RRTGOpD4QIeJn447oAOlapa?=
 =?iso-8859-1?Q?1wlbdJ4+3bYPCk+yjKQlXs65XAuUZVy2E7oEgqJjSLyl308R9N5B2FnNcm?=
 =?iso-8859-1?Q?LOVu8+t4OAExDchtkjidR9cr2FFhCA014iOD7N11KqDRq5/E9G/oYuMTvu?=
 =?iso-8859-1?Q?FStbaRr9+4AQ9ktGdIItD3ak5r4eVCY1jIiNQGL+/wiBvmWLq1yVL0Er6g?=
 =?iso-8859-1?Q?OsQqBGpxM44u55CQqgsNzw/KcV8CjC8WbA8p7AaWPWX3JnAYvTOUfDaNUB?=
 =?iso-8859-1?Q?YKHHZ3KqqfXYzj+tIeKz3EVcHV8/YeUWC5I/CuYCnb8CoKuliL5LA/CpgY?=
 =?iso-8859-1?Q?xDGPtphkhWFrB0XLKCAKvPSnsdTGdC2yPR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR07MB7406.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5439a369-d75d-4f14-7f4e-08dc49c704f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 16:50:31.0522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MeMjL7NzyCzKP9ecZ6RLC7UxzsdOtZ4nYr8vxU0qlgArhKeXjvxwmYnZ5vNCIJ2hTjYtTvzPBPJfhs6DVT166+Pc0gQjNdpF2W5K4fcQ60c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9545


I'd like to merge only certain files, or folders, from another branch.=A0 W=
hat command or options should I be looking at to get this done?

What keywords should I be looking at?=A0 When I ask Google I seem to find v=
arious answers which then get analysed as "actually don't do it like this, =
because it doesn't actually do a merge" or other unsatisfactory results.
My colleague is mostly working on "master" and I am mostly working on a bra=
nch.=A0 In most cases my branch should fast-forward to the head of master, =
so I'd have thought that behind the scenes it would just need to re-point t=
he commit identifier, so there ought to be a straightforward implementation=
 of this.

I know git expects to merge a whole branch throughout the repository, but t=
his seems like something I can't be the only person ever to want, so I assu=
me there is a "proper" way of doing it.=A0 Or do I merge all then clear eve=
rything I don't want, which seems tedious.

Regards,
Richard.


=09
