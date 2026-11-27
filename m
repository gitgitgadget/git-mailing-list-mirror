Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795739899;
	b=msFw3vgn+HGNZZS5XRFpv8YxH4pSSH6MKs6vy2g+ngn8x2qkRgfljpz/Q5jGD0+TxnnV
	 TPVCTtvFF+HPP/dts5ns9LlllKAem/P0aABk1p3xY7iUcfYbPM48avazjcUYlmn+ettwT
	 mj+DsRcKntLfLydck5mce4fAsl1rVDVaGgEg3CSluy2snQMsKwyw3SBrPUMW6Nww5YfFO
	 TcW0Agw8KBZdT3qqG7OFA9upmBiv9PKodX2LOueR2vq+fHFD1tz/6ym1v20aVWfbePcQG
	 jplk4gdvIKi919eWUm0R9fbf6Ev6D/43pA9tSEdZS1oYHKYp0YNV4D8/XiCwt8EmvNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795739899;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-txstate-external:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2mpHaPU8v4Ht84O/ZPt4tk+MvOJ9jasQY9zO0bXzTpc=;
	b=ESP45mvRyHdzp0jMTE86BhZTHZ0z5Ur++/xMyan37wN7ZSO9fn7OKElX2qgTggSHJ1F+
	 AW2CDVR+sgzr9EmCZkbcnR4E5I66f4JHpzWd+26TMxg1A/cdsR6mW6qVP0ZCea3MEO6O7
	 8Z+a3GeY04NFvBps+0VenD3RaeGffG2mC8U2XP5bb5Eob9gn69tiBTc+gkXmLw+hMUUao
	 Mngq2mE3ejeK1u87MffjtCPaVPkO/uJdjEqFpcL3ySwAV89S6hmifH4l8igxhnibc4IPY
	 hPmnI3LIT6zDo0y6MPMvevZ48Z6GIczE0j5Y7Ldfc+LUz+mQK73UGP2adEFUbZuetOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=txstate.edu;
	spf=pass smtp.mailfrom=txstate.edu;
	dkim=pass header.d=txstate.edu header.i=@txstate.edu header.a=rsa-sha256 header.s=selector1 header.b=RBhnxBPC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.111
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020111.outbound.protection.outlook.com [52.101.46.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3D3606A32A
	for <git@vger.kernel.org>; Fri, 27 Nov 2026 00:38:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A3D3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=txstate.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=txstate.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=txstate.edu header.i=@txstate.edu header.a=rsa-sha256 header.s=selector1 header.b=RBhnxBPC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYFkmR+A9LwDJfA0ukaNRDQvQuZxQ4NN0JmKOJdKMmfFgBTXCFFZiu3L2hF1llIsWthkAxrCDgjl+Aphe2bjXN+USZ8docdDZGXOcX2ZRJSWf85c/yvTslbBZM9KJ2uIvk3imG6z03JeScrcDcs9vmCY+Dcuu9Ks+3fehE8o2o5SC0XCjE+AjjIhRRdgspMyFvKPcAHk4Hwj80rfNuwS9OFPH/7aW4M0ZcPeSMqf01LAfoGJ4YfSD/2k28BiPf+mqxXdUITR0Xn/rw81BfJA+IfvQGHU+nHW+neziV0rCGtrXRqZ0D48bvJEzYe2Oy3Cc1ZSU+Q86XLP6pUL87lhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mpHaPU8v4Ht84O/ZPt4tk+MvOJ9jasQY9zO0bXzTpc=;
 b=O+baMuHeUJKzagfEqu+lGeT/5O2LWBFkXIGp2lH1EGkIAx41booRRGB+oM+W4UN/w3uovs0UveKyJqtTgw7RZcS8g6jIptI69AKDLsQFs7rjOlOU4dqaAj+n6e6aZIh1iHNOZMXT/A9K8DY0An18P85TBcezOo5tVW/yt79BQ9Zurqo2Oa2Ypvsos7T+IKmA0jfSlR2O/ErlWDbrMnInyT7MJs2+RJCn5oDmbUq/x5yljtKu7isl1b9GUZv00GGfwA4gdlnNLi0ABQTakuAuZPeWRbo+jfm6ue4KBN0KEHHaEdOZ7pa5szJ1rZy3m7efHOSngGa/h+GM68ns0RETKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=txstate.edu; dmarc=pass action=none header.from=txstate.edu;
 dkim=pass header.d=txstate.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=txstate.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mpHaPU8v4Ht84O/ZPt4tk+MvOJ9jasQY9zO0bXzTpc=;
 b=RBhnxBPC1JccXoSBShor9HZD7A0CH6Cm1wITo6YenoDW/iwXf1OterzoR/94qZ9DSkeKETTfeL45RODpg3zFzQvvCanL4KkoI1ox7wJB0k9EDYvbJBb4C/5VZ7+JAmwkickqTCx7OK8+NANs9Li0eoa6rbbLLtU0lFP8KIi68BQ=
Received: from PH7PR11MB6795.namprd11.prod.outlook.com (2603:10b6:510:1b9::10)
 by CH3PR11MB016496.namprd11.prod.outlook.com (2603:10b6:610:362::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 00:38:15 +0000
Received: from PH7PR11MB6795.namprd11.prod.outlook.com
 ([fe80::350d:ad9f:c2ef:a5c8]) by PH7PR11MB6795.namprd11.prod.outlook.com
 ([fe80::350d:ad9f:c2ef:a5c8%4]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 00:38:15 +0000
From: "Prova, Maher Niger" <vse25@txstate.edu>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Request for VPAT/Accessibility Conformance Report for Git
Thread-Topic: Request for VPAT/Accessibility Conformance Report for Git
Thread-Index: AQHdfgdwZSHoKJBa40uWtJthFW1FCA==
Date: Fri, 27 Nov 2026 00:38:15 +0000
Message-ID:
 <PH7PR11MB67956F9A406338B2F76B7B9ABC412@PH7PR11MB6795.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=txstate.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6795:EE_|CH3PR11MB016496:EE_
x-ms-office365-filtering-correlation-id: c0e2c2a8-e092-462d-8c63-08df4c1eb9ae
x-txstate-external: BYPASS
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|786006|376014|366016|1800799024|261009223027099003|18002099003|10067099003|11063799006|56012099006|261028144727099003|261026121527099003|261026140227099003|261021135927099003|261022075727099003|38070700021|261022105027099003;
x-microsoft-antispam-message-info:
 xxGpuFTvumRMFqyiiodI8FTbgvw7+wmDW/DU0wEYgGDiUk0Tj0j8hkNgWLdMMDMWgbzkLcnUUOquwQjhZhQyheY58mYTuKagmswWMf75eZZxPB12nxoVuU2+6EQa6hoAPvt0twy4caic52cif7nIyc6pUGgaXSv0yGmQKw7vE1wkiEQrRUdNSgyd7EDoQH69kRFhzLoi9jmtcIuA1m588bcoH52kFVDcFaRFFR035toAZzcBmaXzvDQ1Ew9JC/QOZ/4A0oG2zxPFYxLTs/0N8/Q4Lr+U5dhtkKhovze6NTBADEQn693lY9SwRLxLoayQeXUO9b/zJhM2uGwDpFIJ3+JNEct6HGd6ugN4yRh1RDETLD7nEj4cDNPx0d0lD+mL1kvdYEDwUt1Zv1CNpDET7dIpcJsHqG2hoUarG2FKe63PyXY3mTmmvl/odKddNJmB96cTq7LMlBX0rS9bXdjjDVN7ruM/tzzaAiVA9Vdca+CqAPUGu7jSBqS+sDm32Bn7CnpcDPUNSQSLtDOJxQJ+ag7xVrO2uDGTTG7DAtA4gi3EPvMA+FN4G0RSl/Ckp/weDBq78nTH2+3V4tAc70c4bYG9JOAT1RKUEq1FRUh+bPdCzLhAT0JIuGswI9D+z0ZYzzWOeBPinS4xm1OhF46sI0T/LmIPMXaD8bbhwXoXLSg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6795.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(786006)(376014)(366016)(1800799024)(261009223027099003)(18002099003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261026140227099003)(261021135927099003)(261022075727099003)(38070700021)(261022105027099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5qCyPYidYWteNhHAYW5Uxiq1HXLxnoaPGMA8Tc15jh6TncSqlwXvLN9Pi9?=
 =?iso-8859-1?Q?Nmk85rrf03g+60/7VkHlSkRKEKctokzObeMEuGmdjoQ0QmG8SGOYbmFw10?=
 =?iso-8859-1?Q?ZnsN6x1ajSs1pP+MmhV8nEtRJ+FU8y+qAjan+jCy2gF1OrKr/pyMiaO8Db?=
 =?iso-8859-1?Q?lEVBfjhyN1EFn2oLznHq0giwuV+c4tpH96Wb601lLjo2KtzuoilFi0WAPm?=
 =?iso-8859-1?Q?dyVeX4OZWR6lw4H1h2WFmn4vudix4xHL9sNIJ78wyTzW8lFvjnN/mmhwwm?=
 =?iso-8859-1?Q?dqH2rViq4mdk1aXTBBcSqLbc+EFjwkrOo8C3h7O+ZB3n85tBgOeGNPxLaX?=
 =?iso-8859-1?Q?77sYhD159+Bt6QeDHNlGLcjEsOerOqsWtaNJ7d+l+HpvDWZuS8xJLV06qh?=
 =?iso-8859-1?Q?MfvAOr6q7DMvPR6/lr6CT+w8TULBNRQG4/HXGByXt5Tocm90Vokp0DTDiB?=
 =?iso-8859-1?Q?svFaSKEuH7FlYvKOHQ3St+Uhm85SHqno+6FrBMKDxFv7P28nsULZjODmmB?=
 =?iso-8859-1?Q?XciU4XkNAMpKIrTJFZmjdhMZfvNNWT3JUAvQZ/KpcZn1Tm4TCOERWbRL1t?=
 =?iso-8859-1?Q?DiCSoeIsFqTy33erquq6SQY5JhN2MzXY8zLixQ8fZLp4LXAJOsrGuiDQAl?=
 =?iso-8859-1?Q?TJIA6abXEaBygvaGnD8rJrDgulSKd4WQyXrzXX91gXwjjuvI2qYQsgmgry?=
 =?iso-8859-1?Q?MEhxfQrctL2rTSkXPbXhTt1FBL6pKggBU50ySEq6+DBsztyjkRz4mejY+L?=
 =?iso-8859-1?Q?VoUkI8KXUYEzCBnE8mcES/dyP2d6fBfb4t7ALjdg/KwLKd8PKsWpRYPq71?=
 =?iso-8859-1?Q?nzaiLH9IvCMn1vSjOzUO3C2T8TPJp0cTrvze8kBDFQrJixTARkbBtrtkxt?=
 =?iso-8859-1?Q?pyV9nHXPYPctnZpbIMfjLNuVlUDAshgdZtsESm5yaCgvf+7j06MniBlRAx?=
 =?iso-8859-1?Q?Mwc/EMxP93PpusaUzmuaeF5p4etyaEqoJqJ9Yf4RMo9Ho+I9aKMAeyVY8T?=
 =?iso-8859-1?Q?jY1PkzO9ajbhKPY69J7+TaXC4tPvA2dUYiaSs9n9/mfQFgexO+JLLopzJR?=
 =?iso-8859-1?Q?TVYOaN6HjRysdkm8Xs2xLFNZUMpeUcJlrCyYwpWKElYKlA04YrwL7DR7Ar?=
 =?iso-8859-1?Q?gHsoEunDdoZNSP/gB/weC8mQWKiBVHb38gS6CJrBEf6MFLn6E5KgX/J2PR?=
 =?iso-8859-1?Q?VR9bHPDwrjNm38hmX5YZ3LjZ1OYXXQHuFG3mJW+AeeP9WSjDRxQrFlrakF?=
 =?iso-8859-1?Q?JFou8PYFLmPXEhPCWJVM1OK8lIZoWTz7iNB3XZJFm7zJgYJCwxglitiujR?=
 =?iso-8859-1?Q?HMmDwiAkD5YDENg7L0cib639kxIlGCf5Ct2u3fcro9Pd8aI40/zrRKr5Mc?=
 =?iso-8859-1?Q?gDxGPaiVjzZxHX0NHSplNiwKgjTHnXgmKimA4ojvDMn+eQaq8BTaVtNqYU?=
 =?iso-8859-1?Q?BK8J6LzR4Z0mooWwHzwT/yebI/wQULnlpXjKpMiKu/0wTJGuYjT6ybTVHA?=
 =?iso-8859-1?Q?mPfmcI5QCUcmhU8KOjhCRfzfLkaGMETGm6np7yLWKi2IDq0Phl0b6v3+vx?=
 =?iso-8859-1?Q?rLJEnfD5TcYoJVs6pQ7QecIkauPReEUAUHaaI88wbem0ckIWW/xaf/mJid?=
 =?iso-8859-1?Q?/q0JC/xUex37mSKa0tm95V70AE4i1K31AUNKhdrmw0sOi0EBYlbJZWtZQ8?=
 =?iso-8859-1?Q?QgxgpCTNdnNhD+0Nv13GH/O/5EWfa5hCWtMCdfny29hQ83NlQrcsmOe/mG?=
 =?iso-8859-1?Q?+DcY8TCoFr2hyUzzVSwfKGLPGHV3dogEtgheR7wQSfHKul?=
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
X-OriginatorOrg: txstate.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6795.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e2c2a8-e092-462d-8c63-08df4c1eb9ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2026 00:38:15.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b19c134a-14c9-4d4c-af65-c420f94c8cbb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cDkQlZc7oZENhmvb10WJL4BZqIrBuw5eNDiw9jltwzM+IhMNAp5ex8ajOp8RfXf3aIDNYbPDpuc1e56wxlE3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB016496

Dear Git Development Team,=0A=
=0A=
I am a Ph.D. researcher at Texas State University, requesting institutional=
 approval to use Git for scientific software development and version contro=
l.=0A=
=0A=
Our university requires an Accessibility Conformance Report (ACR), preferab=
ly prepared using the Voluntary Product Accessibility Template (VPAT).=0A=
=0A=
Could you please provide the latest completed VPAT/ACR applicable to Git fo=
r Windows? If a completed report is not available, could you provide any of=
ficial accessibility documentation or confirm its unavailability?=0A=
=0A=
The VPAT template is available at:=0A=
https://www.itic.org/voluntary-product-accessibility-template-vpat/=0A=
=0A=
Thank you for your assistance.=0A=
=0A=
Best regards,=0A=
Maher Niger Prova=0A=
PhD Student=A0=0A=
Mechanical & Manufacturing Engineering=0A=
Ingram School of Engineering, Texas State University=0A=
Email: vse25@txstate.edu=0A=
Pronouns: She/her=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
