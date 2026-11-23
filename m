Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=193.56.114.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795426348;
	b=Dex8MbwLwbHasnQBvXeoiX3j/nazFTlEbDnyvqpM838gVWRFOZKbZ20TWYPsvEkzQsFZ
	 mO97VxuDQjdc7Cq4/ntWaRTodkxtJblH77Uw0luvUfop44PIMETH6aRi9K1bXwViuhkH9
	 BfTbtPUROKYMALjonWIACZR93wL3oVIvQGNyZniETd74csdLj5Gnf6LB2TxXAEosUUYvB
	 8m/Oj7VNvoNUPXU+f5ANYgmJZmsAgQgGhQto6guL1Tt3UgMhLX3mjTOdSHyrN9y+u72Hk
	 Pdcm3Mii6sev+/gQAnrlfTN1oFWf+fiMKZGkMhdIGDpAYq3NnUMRYo49QganDpsKaFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426348;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-MGA-submission:Received:DKIM-Signature:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:
	 References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=SVUCWL1BV15ttThkWVA4TE4nveAsvZh4iTf17bCsSgU=;
	b=wOBeV5RQLnLGNwJmgZCIqKo8+/507SX8bD6K9GBfFUboQZnRicXIBKuZ0uBTeOnKu+Fm
	 Otrg/D4j/d/sAhC2AV0pnWVoPRyYgJVKENhFPolKwzjx2PJeOPnENhUlLO1tXyhAEpi3I
	 VgGhL9kpHTHxGXAZAPQeIF1Gh/5N5/lln0UqHTjayPv8ogAlzCZBgNlxM/QsenGkFxYnY
	 E4ciggZOLrExx/4Nj8VcvPsaSBjbJ9nwCjCRSPQPEzbKGDBCAlq4sJRF+Da+nxv0HNHsF
	 IEk0XUd5x6/NykOUmQLXfLNO5vGh8cEyQFXkiLNu9Qmgd81aoQbPBICy19fOoGlxuDQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=atos.ai;
	spf=pass smtp.mailfrom=atos.ai;
	dkim=pass header.d=atos.ai header.i=@atos.ai header.a=rsa-sha256 header.s=mail header.b=PWou4HjE;
	dkim=pass header.d=Atos.ai header.i=@Atos.ai header.a=rsa-sha256 header.s=selector1 header.b=PqalVH8O;
	arc=pass header.oldest-pass=0 smtp.remote-ip=193.56.114.177
Received: from smarthost2.atos.net (smtppost.atos.net [193.56.114.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103A8606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 09:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 103A8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=atos.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atos.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=atos.ai header.i=@atos.ai header.a=rsa-sha256 header.s=mail header.b=PWou4HjE;
	dkim=pass (2048-bit key, unprotected) header.d=Atos.ai header.i=@Atos.ai header.a=rsa-sha256 header.s=selector1 header.b=PqalVH8O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=atos.ai; i=@atos.ai; q=dns/txt; s=mail;
  t=1795426347; x=1826962347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SVUCWL1BV15ttThkWVA4TE4nveAsvZh4iTf17bCsSgU=;
  b=PWou4HjEDF3TtNAtN0PufgZ46p8MqfiJ/4QufuINnAeLsUe4evNrV3NZ
   REa680kjh7rypYNcGw5LcJiVW/Xk10Pxdzp1wLe092O16Crhf65JcJNdp
   Z6ETjI2j1PMSCJTUZD1R9pb/H8kPQZsCA0ZZnXGDFaew/nCCcjeci6Lzs
   YmLmRXTMW0Hj9gNDeqG/xIU3xjK1LO0BasF6627OdsWvH34K9nk0GoGKw
   kLyiIENWczgsCfdygM/KPErfMF7orZ3FHmFzCJFUJ9OddKIj0PJdvv5zA
   Dx2Zo/2MGCD05d4wrxdb3Ke5Tmfye5nkof0HHIKnEDAjA411Jm1dHlavF
   w==;
X-CSE-ConnectionGUID: a9mU0FZITqm4d7AstYF5GA==
X-CSE-MsgGUID: frYFUHxJQVWpgPxTv2y0Nw==
X-IronPort-AV: E=Sophos;i="6.27,227,1787004000"; 
   d="scan'208";a="889733932"
X-MGA-submission: =?us-ascii?q?MDHEmU3TS+h7vf0wrrJfISGYPj9IemfNeQMGGa?=
 =?us-ascii?q?6XreeWnC3bDkNzuo5Zhdlp3VnZEwjVBoGNDHMYNNQ9lKNiI5WUKhHHhd?=
 =?us-ascii?q?JivSpOUsqDzZ0wVuGVX4dcddkgC5HTMiZxO+7QrkNWjMLSrwp2gTI2QB?=
 =?us-ascii?q?17?=
Received: from mail-as8pr07cu00300.outbound.protection.outlook.com (HELO AS8PR07CU003.outbound.protection.outlook.com) ([40.93.65.48])
  by smarthost2.atos.net with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Nov 2026 10:32:18 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sAXPkMJviT/sZRlol2cAb7E8dN7Ngt4pBxiaoSnmacYcOck7jJl9p//JRk4t7c1bqfz+kSLpdk1K44+32dZVX3Nq5gWMTvhrdAB+iKHnSd0DgUfdrlhsn5l7ijU6zpiac94yiUsZ46YiadWOSNwL+kmmwifVAadmcr07Uj5aCl2CRVH7+5ipxHARhz8G0Aac/JFJ5qawJ0+zzYYBb9srJD6vogY8GaYAgE+W8dxGVOnpvjPz6GaEZ9yTCVOWmAvOG2TrFNHGtryf66XwIcPim3FkC95u1+e0kk5rKNOdaHIGy89TuPOUZta4pDSvyWVMUyp/ITYWQFcFqzW6Q//Rog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVUCWL1BV15ttThkWVA4TE4nveAsvZh4iTf17bCsSgU=;
 b=wJZwZ4O4aKMBmIQpl0gsuMbZ8vXZ0Bg8iOT2sSP5nh+hfF9xpH89WPiHlq8J1/kIntmORxGui1W9HDJV1BS3LoCKuCwSN+wPncqRjdo+MLBH1XOd//SD0O/qKGdn7RHo97ehsdDR5c6XWN4LO7z6TCy5UnVmQcKDaCUjMv+H4NdwLiwHlcQtzw7ytLB+3IYCbK5TIpEyNe2++tjARM7C5InHfs6E3ymRWUoRrEvSp0oB8bFMqmZNeII0i2MpfAhgPWaP1V1sJdH/iVAr/P9+566bPeMFDb430mRAHhEwxoH2eCLCqeJc8GLIiyDJC2NJ4BktfvXmlfgD0pfGJ+vhDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atos.ai; dmarc=pass action=none header.from=atos.ai; dkim=pass
 header.d=atos.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Atos.ai; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVUCWL1BV15ttThkWVA4TE4nveAsvZh4iTf17bCsSgU=;
 b=PqalVH8OMdg0JENf6wienxunU6IH8pmwR224BaMrPY3FOweNqiwFFl9plKtEXm8yBEitzsTfMSjPZib7oY6zY/yMeLmS9Dx4C0L5/jiS6SdkwdkRKypZ3dRcku/63Z/OXpyJi8Shc+liuq/tx3dbMZpRRcTX0FBvDAQT9yS6Zs0MPyJmv2gtPZypS150E/YpzXsFxTtnC1a0XeG43a55SVznjbOVJt/lfjZ6f3zSm6Tbf8spCaZe5GgMnER1lPo1mId+1oYhXzBKKWnoQQyLvlul+PdZuFz51Uv6HuGtRdnrtutW9i+rH6z9kp9oGdUyloUuY/8HWfNNi48Jq3E7/A==
Received: from AS4PR02MB8336.eurprd02.prod.outlook.com (2603:10a6:20b:517::6)
 by VI0PR02MB12082.eurprd02.prod.outlook.com (2603:10a6:800:321::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 09:32:15 +0000
Received: from AS4PR02MB8336.eurprd02.prod.outlook.com
 ([fe80::b6b2:4b44:41b3:f6ef]) by AS4PR02MB8336.eurprd02.prod.outlook.com
 ([fe80::b6b2:4b44:41b3:f6ef%5]) with mapi id 15.21.0639.010; Mon, 23 Nov 2026
 09:32:15 +0000
From: Richard Kerry <richard.kerry@atos.ai>
To: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
CC: Ophir Bleicher <ophirble@gmail.com>, Ophir Bleicher <ophirble@gmail.com>
Subject: RE: [PATCH] git-gui: fix typo in comment
Thread-Topic: [PATCH] git-gui: fix typo in comment
Thread-Index: AQHdedU5c/9mKcpQtEK5jgjqHge4GLc7ZW7Q
Date: Mon, 23 Nov 2026 09:32:15 +0000
Message-ID:
 <AS4PR02MB83365A1D590B3CE05BEEE39EEB452@AS4PR02MB8336.eurprd02.prod.outlook.com>
References: <pull.2498.git.git.1795278449118.gitgitgadget@gmail.com>
In-Reply-To: <pull.2498.git.git.1795278449118.gitgitgadget@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ActionId=e5b77714-1965-47e1-aa77-ef43184d48bb;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_ContentBits=0;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Enabled=true;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Method=Standard;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Name=All
 Employees_2;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SetDate=2026-11-23T09:25:15Z;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_SiteId=33440fc6-b7c7-412c-bb73-0e70b0198d5a;MSIP_Label_e463cba9-5f6c-478d-9329-7b2295e4e8ed_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atos.ai;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR02MB8336:EE_|VI0PR02MB12082:EE_
x-ms-office365-filtering-correlation-id: ff5e25b8-aa01-4c71-31aa-08df4944a91f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|366016|38070700021|261028144727099003|261102123227099003|261021123027099003|261021135927099003|261021130227099003|261021121427099003|261021133027099003|261026135527099003|261026140227099003|261026130827099003|261026121527099003|261022115727099003|261022075727099003|261022105027099003|261022113327099003|11063799006|56012099006|10067099003|22082099003|18002099003|261009220027099003|6133799003|261009221227099003|261009223027099003|261009221727099003|261009223327099003|13003099007|4133799003;
x-microsoft-antispam-message-info:
 o08ufYVJmat2D5Q6oqM+ZOm7o6czWyvugB3Dr1S7JpNoQqd3qeMtH/wahFoidttJpsLdVm+r/Po9Qg2jI/wMd7R4WV8IHhRSo4IWYfIuxqt3+LaIvBRBlczHJ0Tz4wiiqj5HQAYXh626Mv868hFCTf7r2PM1GXAO0D5aBmwGKiSRxdUhCbFrZr11lIcl3FqGFoT+Lcw48UDnm0lGiuOCHT9xM4fYE8dacXhgjc0CGH8MFQC96U+hk41N2dUwHVB+T4q5LusKMGo85q3CoxwW4+DlDgecz81g1cI+AQqX+I2l3jbW32goqccfIkBCEJg+d8zJUikx6nNQdAZWpf5jlCDAY6X84UVwpRIcD9cYTrC67K5pcfYba/gAWB4Aif2HEukS9A+jbR5YY9IJ4mZxCCPnOmmvm7X7Zv9jVUS/+5G7OR2IfmS+pz782eJDFYnWkOroVAxEalPipB7POo6tn3uHXZSUBVvG3l3qPQQ1qLG+dg/io0Gpc5nfGFwu4IZ8KvJIdzsHEtFKWpVkhevUaMweTAuMfdjgID/yD8B2BKg2snCIqiiYocs4R5MBFnv5CK9/7xLCqUoDTQjKTqynkXs6pPxgRKl2J0GuBfI93ugcs85jpPNqE4hWJhRJNI1AJajAcTqN82l+mZ5BFfu5eeSCy6svlh471hhLn10dk0U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR02MB8336.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(38070700021)(261028144727099003)(261102123227099003)(261021123027099003)(261021135927099003)(261021130227099003)(261021121427099003)(261021133027099003)(261026135527099003)(261026140227099003)(261026130827099003)(261026121527099003)(261022115727099003)(261022075727099003)(261022105027099003)(261022113327099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(261009220027099003)(6133799003)(261009221227099003)(261009223027099003)(261009221727099003)(261009223327099003)(13003099007)(4133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DgOBDxKcDwL0ELcQ1iyYB76FYkEFqwezetTAmOFmhBGg+MnXbp88k6TErl?=
 =?iso-8859-1?Q?TUz9TSZX1XMmzrM+x3+FgAGwfHl+o+QNiGLIwvaKTZqkgGTyfCMkmeOmqW?=
 =?iso-8859-1?Q?Pa/YNu6T0q2c3Q53iEyEzJQo8VpSU+x82yWoHQ3jequ0l9tscineCRTJzl?=
 =?iso-8859-1?Q?Eqvx+GxQFcwav6gnnR4J19rEW+MQgWy0n7okJVvatYzo5uvWys3rtNOPRd?=
 =?iso-8859-1?Q?OZsycy5v3ftic/9QuXBnjO7WhlSuW4NgkSfsoxE4I3bSr4+PQ+sk6UFFGj?=
 =?iso-8859-1?Q?BC/n0yNedgQgIL4P8OGykJsjsy0EUM9OY5JrpKTmywuxBPlkumlEOMWzBS?=
 =?iso-8859-1?Q?99Z1ERCYpejINaQAguF88QqQ9Y2ck5CTXgeGpcrIyFmGLLVHaWM4OH+IXl?=
 =?iso-8859-1?Q?ZlQoR/TM6ehvRn2YoKEhpe8i6+AsEj/dIoL8gXMzc2mrRxCVwhWuxf0ESc?=
 =?iso-8859-1?Q?0MkkEjb5eONfvnf+kQNeHPftftxbIPr/nkT+kyZq/eH58drVll4mfvLqf0?=
 =?iso-8859-1?Q?OgYvOyACtjQlp8VXgMc/sSCm/rpW8dpoit9uWcPYdX4SrQWecZfUSAIA34?=
 =?iso-8859-1?Q?Rif5uJvG714J6UWU5mgCHVphXCUMmRz8JB1o8HtRBIkdtu/YZwkTI0N/LI?=
 =?iso-8859-1?Q?tt0jejx/CvrRiQMZsTp7tLOF1FoAwZfan1Xq/HWbwuSJFxU64ShZK2qJRO?=
 =?iso-8859-1?Q?o0niy0Kpl0VHlW97O2zSg6AJ15PO9/uIc7qdGs/1fW2ZV+oW+WS/xHuamg?=
 =?iso-8859-1?Q?+/dK0mA2QpeRKNjo5UvD6dKWpS/XwldYVmM2YO6NgkTCptrVL4r/U+010C?=
 =?iso-8859-1?Q?R69FD+RanETuTzPdhMYaT0SD8c0xPke1X4tGjlPzWSMgpzjAMLvDC3ySgE?=
 =?iso-8859-1?Q?1wQcFZbTdgzNrp00J3P3gk/XUFSUoOZ2igb/7GAeAeve6i4/P7hy9or2rL?=
 =?iso-8859-1?Q?5Q1a2kmJMjD0eiA/9vmMz0kNmkXQ7jsKnR3i9PpGx8xw2aizANU7ckeSDs?=
 =?iso-8859-1?Q?BzaXyJahp1CLRxDX+XsD2SPzZdJp0anjLvx13XWXHIDyyANxyWq71v+yGS?=
 =?iso-8859-1?Q?5tX73Aj/55nvtaNHEI70SaVMh7cyK+kCP+QByhz/HD/XH8WswzcyuCxGQh?=
 =?iso-8859-1?Q?mI+rzlc37miNaBq2lfDmDq9xbhdIIzNzdaZnnkLYE95YyRMPVxbN9RDgdl?=
 =?iso-8859-1?Q?eQpghTit5dObW7VcO+Je0wMl2etLsROG4mw3ljnPon0/fcOn+GBBkqJdvV?=
 =?iso-8859-1?Q?qrD9cpnLa7jVn59VayJuxvo+83XPQcgV2brlZPED/ECBUUDRIA6pj02Fc6?=
 =?iso-8859-1?Q?5JTYiDW31vSrtkXpC3GHcU/b1Z7NWgNu0p2Sfflt+cozCBHSterDZyIwuE?=
 =?iso-8859-1?Q?8AWMgGQN9NAnXv+PWNxykJDN1RQLJqN+WA8dOj+ZhPX74HVSVPQY9kxfuZ?=
 =?iso-8859-1?Q?ePFbnCtnubLrcB679N+2Sl7xShJ3fzsl99yxSbIBdlut52TeScWYyeMe6F?=
 =?iso-8859-1?Q?UPBDgK38wJhtCyKerNMGWGR8E/h+TI7oKGO7UZtIC4aVMddDqacA7OejIt?=
 =?iso-8859-1?Q?aCXGIZFF5ayhBTHLeNFspeMicw+CNsObxdWYhZaJy0zfnCTnMKuqoEbEJI?=
 =?iso-8859-1?Q?LfrbZbh1jcDgaskYgCfMEeMXsPBe2/6+iACd4htfjBoEUMHmtLLDVe+Rz0?=
 =?iso-8859-1?Q?TNe3g/PsCi3eb4ZnH6klOyOLASNnahMHHWjd7L+U6rBp/ULyKlBFf9Vz+i?=
 =?iso-8859-1?Q?Yu/PIDMnK0XXyVGiQjqNOoKHV6JMfoPrAVa/9dfs9YKQZbgoaslB8Bd2Qs?=
 =?iso-8859-1?Q?VqcB6T5pPg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	JiB+Q7FZ3LdBlPDM/f/VU5Y7p8N9l3dVRYuxac0gqQG38xud4vg77CncrmwHoP3l6qPdqY9Ep/auRpSrfLBmmprWcrVYQOhleNHIuMK99IFpgNP+Wo6a4QDHyQh7z3hGi2+oxeM5LdYk8GIVfMf0PPllhafhf+47OwNkxN0sVsJ5HikfxwM4CIY64+jt78X4EV8jQISztEK0ExPM5z46muiiIuAXt8TnuB/oa9Xz2RGJKdgE9Z5YxA0+ao9WLzHm+VycnoPtrPnPyABXhi5QRK6Jztdk/XFjIUh/kpe91QyOUvZJQ9g154HY+02D5EsmqXHA85zOGTPGQSrC/zoaxg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fdgyN02QJ4ty+RnMRM97ngZrlFBz6TYf8Tee4HPu7bHBeVxWdwwlBs+TQ2SugIYBNRlvJ8a5qGQg3jXy+47jQ8NdElLp7CYigB0KhsJdWoAHiZqMb9oLY2RUobBfyGGc+UsInnryjDZM40mCexH02QXwSwVrN+dYyflrBBSyrZwaIEeBGhVmH8hV19UKkSBZ4ZgFZ9Ktgn/xwa0lLVbIYopzkewFZpFwZYR5BK53EsVjNwocQSUyGc/ArNyzlPIhWQxAY4Y45SV3In01Uv7JUdow7bkP+ZNXIs/EpuyroeeSeazuV+x/XixFzodmaqWZ9VT8+1M7lhWf2O3CwzEhKu7uylRqnAa+KvyS4q7FeANCktBE6L08oZNIYe4mKiHImpdCEMBBtKfZa9syoHXdNXrOX18DiPj/Ql6R6pvjEggMRN23afSKyb1FLdTrq4M7ysDrEHv6xd7OVRN0V2vpBnXFUieaKS0hcb0r50Dm+/bMI63OosfWHome6DfiTlTAWI7rYGOdqZOk9lJXvB6ON7gvYYfIZHDAwVJXSLcOf3Vk4/1vNwHOCxvzqSy+3lHE/pL+HyBAD88vX6zLSXBW3vhj4eUQpVkvOn40RxXZn7epYRkUsZ30zaAo8rpnu0Dal0iUCa9QeWh8OIXJUbalHO45vObZgVq9FqWGP9clJ7vRwXi/9ppdr1luWeRzmD4w
X-OriginatorOrg: Atos.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB8336.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5e25b8-aa01-4c71-31aa-08df4944a91f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 09:32:15.3319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYxZW6pI1UTVJggFbXXpQ8NmNP/IErPFZLtspHwAkfajISKQn774+n+etJPalf0P9+HlSVTzvfwS930x6Db+Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB12082


Don't do that, occurrence would be correct.

(double r as well as leaving e)


Kind regards,

Richard Kerry
BNCS Engineer - Media Competency Centre
MidCity Place, 71 High Holborn - London WC1V 6EA - UK
atos.ai





> -----Original Message-----
> From: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>
> Sent: 21 November 2026 16:27
> To: git@vger.kernel.org
> Cc: Ophir Bleicher <ophirble@gmail.com>; Ophir Bleicher <ophirble@gmail.c=
om>
> Subject: [PATCH] git-gui: fix typo in comment
>
> Caution: External email. Do not open attachments or click links, unless t=
his email
> comes from a known sender and you know the content is safe.
>
>
> From: Ophir Bleicher <ophirble@gmail.com>
>
> Fix a typo in the comment in line 112 of git-gui/git-gui.sh. Change it fr=
om
> occurence to occurance.
>
> Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
> ---
>     git-gui: fix typo in comment
>
> Published-As:
> https://github.co/
> m%2Fgitgitgadget%2Fgit%2Freleases%2Ftag%2Fpr-git-
> 2498%252FOphirBleicher%252Fgit-gui-typo-
> v1&data=3D05%7C02%7Crichard.kerry%40atos.ai%7Ca6efdfe58b124f6ebc2008df4
> 7ec58dd%7C33440fc6b7c7412cbb730e70b0198d5a%7C0%7C0%7C63930875258
> 3340552%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIw
> LjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C
> %7C%7C&sdata=3DN0wm4FFk9jyAX41rAbt1D3rxBrhpNzcylh2FRicwJTQ%3D&reserv
> ed=3D0
> Fetch-It-Via: git fetch
> https://github.co/
> m%2Fgitgitgadget%2Fgit&data=3D05%7C02%7Crichard.kerry%40atos.ai%7Ca6efdf
> e58b124f6ebc2008df47ec58dd%7C33440fc6b7c7412cbb730e70b0198d5a%7C0
> %7C0%7C639308752583372617%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1h
> cGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjo
> yfQ%3D%3D%7C0%7C%7C%7C&sdata=3DE1B9p5t7zGmjiddTuvOmLbKghloYtI0ACJlt
> 9v%2F5gwE%3D&reserved=3D0 pr-git-2498/OphirBleicher/git-gui-typo-v1
> Pull-Request:
> https://github.co/
> m%2Fgit%2Fgit%2Fpull%2F2498&data=3D05%7C02%7Crichard.kerry%40atos.ai%7
> Ca6efdfe58b124f6ebc2008df47ec58dd%7C33440fc6b7c7412cbb730e70b0198d5
> a%7C0%7C0%7C639308752583395363%7CUnknown%7CTWFpbGZsb3d8eyJFbX
> B0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbC
> IsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DGUB69gN5u4AmUAJknLsIstG1DI
> C%2B9KCmlP5kkqWik%2BI%3D&reserved=3D0
>
>  git-gui/git-gui.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh index 15dd2b3a84..1d=
eaa5edd3
> 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -109,7 +109,7 @@ foreach p [split $env(PATH) $_path_sep] {
>         if {[file pathtype $p] ne {absolute}} {
>                 continue
>         }
> -       # Keep only the first occurence of any duplicates.
> +       # Keep only the first occurance of any duplicates.
>         set norm_p [file normalize $p]
>         dict set _path_seen $norm_p 1
>  }
>
> base-commit: f7de81456940dd6f3274e461149bba12965de609
> --
> gitgitgadget

Atos is a trading name used by the Atos group. The trading entity is regist=
ered in England and Wales: Atos IT Services UK Limited (registered number 0=
1245534). The registered office is located at: Second Floor, MidCity Place,=
 71 High Holborn, London, WC1V 6EA. The VAT No. is: GB232327983. This e-mai=
l and the documents attached are confidential and intended solely for the a=
ddressee and may contain confidential or privileged information. If you rec=
eive this e-mail in error, you are not authorised to copy, disclose, use, o=
r retain it. Please notify the sender immediately and delete this email fro=
m your systems. As emails may be intercepted, amended, or lost, they are no=
t secure. Atos therefore can accept no liability for any errors or their co=
ntent. Although Atos endeavours to maintain a virus-free network, we do not=
 warrant that this transmission is virus-free and can accept no liability f=
or any damages resulting from any virus transmitted. The risks are deemed t=
o be accepted by everyone who communicates with Atos by email.
