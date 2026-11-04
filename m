Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.209
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793810068;
	b=5PgHgQFqvkVS21xSbMvHlOXWxPQISghbmjsx1yFnSnCJ6kiy+omZzuFKM3XFDu/RBjIe
	 WqDBmnNx6ZmVeEARtl0QGRL3RNwkUoJDtjmwQf7woOUmRhbFciQKG4pUQ7ucs6/th9gOZ
	 xwIuCIHwyWfwWgsN1TjxA4SF6EWziIKkrjCTF6m7KjJk6Fo7ipfu30r4fiHW4KK4vDf3f
	 r7UH15EvV67690QzookUZPSw0Mg+dwM7+YhjD4SkpraoFnhY34te5wPZ9vtQNh7swxyG2
	 zVTY52h41B/xLArbC+itTNLwqnfdD55HxT/hva//o6dPsLaqEkuOk5CQr1THYTuLAhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810068;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details;
	bh=y2RPoertj7mwUCcXZSaBJ8svevOEu07rkFAI/L3IFt8=;
	b=YYtfn4t3Xn/8K9a/e3Mw2BMVQlnXzh26845YxoMCVzFgwGg8JC0IYdmeCcBgHBxYFOR1
	 uMb2OCfAgx69ACWhGp1gBEGsSiyp1d6clqN2yCGcZurOYvam1Km81uYUojJOdSDAOC3SG
	 KV9yBPJLIvjuzztGl3CTlBgPusRV8mlVIWldjLKUwIQnm5r6oDIBae8/LfDWORaTFd5Vb
	 2DCD6RUkOehOQshCLISgU36dICH4dmYqbGFgBW5soEnkX2BXFbUIWckiqR0ItB+DCBMcm
	 MEEuf7bWdgAwdDoiOMdGuK8Hc+ubwY/HorvlnzSivxsKk/29YKtXDojhwfNW1Cy4KKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=epic.com;
	spf=pass smtp.mailfrom=epic.com;
	dkim=pass header.d=epic.com header.i=@epic.com header.a=rsa-sha256 header.s=2k26 header.b=1zF3yKjq;
	dkim=pass header.d=epic.com header.i=@epic.com header.a=rsa-sha256 header.s=selector1 header.b=PqJQOwYC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.209
Received: from mx0a-002b1501.pphosted.com (mx0a-002b1501.pphosted.com [148.163.150.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C0606A326
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 16:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 550C0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=epic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=epic.com header.i=@epic.com header.a=rsa-sha256 header.s=2k26 header.b=1zF3yKjq;
	dkim=pass (1024-bit key, unprotected) header.d=epic.com header.i=@epic.com header.a=rsa-sha256 header.s=selector1 header.b=PqJQOwYC
Received: from pps.filterd (m0119676.ppops.net [127.0.0.1])
	by mx0a-002b1501.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4FkCNp2935903;
	Wed, 4 Nov 2026 10:34:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=2k26; bh=y2RPo
	ertj7mwUCcXZSaBJ8svevOEu07rkFAI/L3IFt8=; b=1zF3yKjq7KJ43l+p5a2z7
	n+unCesnjXt+U5oWYJIyJxuwJFApXZ62iWsiJNwH5GcC0MJgiZj3My8lrEIWzrfs
	v63EqrobDUf+1WWTvo3M1jjQ+Pp5aAonE/HoIPllDS9tkAWfQlw89HNVfNuuqaJb
	ccK7v9W/5aHMTHA8E+WTRXs9adRDyV5IWyTTIxz+KApubpWTMHNgHfZf8oAWMSW5
	eXKbIf7kBULQ2BOve3Y34556U0j5WcaZfW5bJKS9ioyBuclvibx1rO9d2DOk8Oeu
	zh0OJdEcs+qUJ17YcQuX6Hsx5+PWPGvlCrah97EA3Q15zU10NMcQyLs+c32hgx+T
	w==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	by mx0a-002b1501.pphosted.com (PPS) with ESMTPS id 4hqnu6ufcg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 10:34:25 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drukykPhxpU+2Rn9p5EPdnCrVr6wEYJ1Rv4J4Rs4hTn4RQRun6vuKbSlvklP7KoZdfKiiVPBThnP1NPEoAXOcPybRozVW6+Rj+Un5jFrPJhWSVFGYl1mai6sjSf/BTuj6e7cvwn1MVMvJ5Aorffyl9J7F1AHYQopRheTMpA2/cvlYCSMNIKjr7rCK5d5wGfAfFMA5pAfMhwf1gbTbs4Fvci9FPa9jSsdqrsEkzbdP0P4YbS7KS61SahaKn90r0Jt898xkJh7r3ENbI4MMD4940P6C5iPOPymaL3a8trJvWUJd2yeiiWdU2hKpNxTiWxd1VKNnxfBI/HxD9ab5wl09w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y2RPoertj7mwUCcXZSaBJ8svevOEu07rkFAI/L3IFt8=;
 b=OEQwREnA7qYJGkaGA0lVI5L06bSH/Mebb8IhQiQQ9VdQs8VEhZME9Gvvyo7R9XGIhwbw5Ru2U70W9Gvi1Qgfb2Fhm6ouTnBgsWDgoDzvFojxzjYxzK1V7kNwlvcKE8Kkt1r1VxwXuakOkpRq+EIBQz4KWzM9qDHVsFPteQ39BS3g7TqwavZET1hZIHyfbENYSMAHKI8g84z2R2pd+5al81aMz3XW6SSnoEe33VMtMEBigtsiUgQtYPSyMnbPjf+rbPHdKYlihuPzkHz4B2VFx1XWTfwtzwL/eTs/eRZ5++aVBKde7pB/Huvwf7xVxZKDIz5nwcWTsCOfFLfrJtg8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epic.com; dmarc=pass action=none header.from=epic.com;
 dkim=pass header.d=epic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epic.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y2RPoertj7mwUCcXZSaBJ8svevOEu07rkFAI/L3IFt8=;
 b=PqJQOwYCX8JRcz11p3HHpPVfByqu48sLW2/89luaaeFp7Fgnn6UvkvPL+MCD5P4rFisaloTLE4t5zbLUesOq/OWzKdJpYoohcY34nrmlpO2S7eWKOT7tvZ9zThO1U80Umly9pzj9x0AS5ETrRWyzc/DadqvdAEno3lF7mxaAb+g=
Received: from CY8PR17MB6236.namprd17.prod.outlook.com (2603:10b6:930:94::12)
 by PH0PR17MB4987.namprd17.prod.outlook.com (2603:10b6:510:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 16:34:22 +0000
Received: from CY8PR17MB6236.namprd17.prod.outlook.com
 ([fe80::f569:c479:a03d:d640]) by CY8PR17MB6236.namprd17.prod.outlook.com
 ([fe80::f569:c479:a03d:d640%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 16:34:22 +0000
From: Kevin Lyles <klyles@epic.com>
To: Chris Torek <chris.torek@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Interaction between pre-commit hook and git commit <pathspec>
Thread-Topic: Interaction between pre-commit hook and git commit <pathspec>
Thread-Index: Ad1rzaMcbrOe4sMXTwGSdQqQT+fa7gABk6yAACX0m6A=
Date: Wed, 4 Nov 2026 16:34:22 +0000
Message-ID:
 <CY8PR17MB62362ECA0192916E14234BCBAE682@CY8PR17MB6236.namprd17.prod.outlook.com>
References:
 <CY8PR17MB6236D16AD8CD80720FF1342DAE692@CY8PR17MB6236.namprd17.prod.outlook.com>
 <CAPx1Gvd3H2-e5RBoH9e1r0cWqe2uo1tm-eUSop0ffNBc2Pj6tg@mail.gmail.com>
In-Reply-To:
 <CAPx1Gvd3H2-e5RBoH9e1r0cWqe2uo1tm-eUSop0ffNBc2Pj6tg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epic.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR17MB6236:EE_|PH0PR17MB4987:EE_
x-ms-office365-filtering-correlation-id: 6df3a7ff-2805-4022-5814-08df3a917b33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|10067099003|38070700021|11063799006|4143699003|261026121527099003|261021121427099003|261102123227099003|56012099006;
x-microsoft-antispam-message-info:
 ddnT+i+MeWhwULDUchr9y35krY449sAHFHoFFhzQKHS9tJWyu79at9uN4FtWfubnIpdGtY4vZX3OKrJ4xd4f3qsHzrWgUDrG6hUswOihcjO8S6rEhscTdvu6H9H/JrPWpGtci9ocfXWkgJlEz0Qy/P6JFoU/H1hljokS5He5gW//RJSpADbH7Uba0CUuA2pX1wfxT91IkjZ6voO9EI+SkB9fWYeejKPritgFrvh0WlG/e8A4q2+lgMAmMVTbK+InnyJ4W3yBD2nhP+KPX6Cvzb+Kz0KtyBxBtN+lPuHMB+f7pszNj1OMSzG9G0ackyIStLeEEF/B2aLenfzwWAJx5EQHphbaJLNXKIP/ku5piUSJKMvJuJ/kS0X7sMXlqfmZc3RJW8XQYUnlTjnH9iODOSde4WNVgASqw4xnh7ttmkh9re1ikAaOQlmO/1xKCAWgkVOYDeg7YdqqRIdWoVX49tdtgse94CQ6YgMOV6tHmAyg5znRCqPpAtXMVnBDg0VXWcIwsg6XZP8oRNzKo/UBE0bBdlPRX1V2Wzkx8AjIlWeAOm+UD6nYUiktFrJgXfTv3CEdbOvFHtDVtq0AU+DV7RyzEN8IiM5zaPIdMyrnFxpSODhXpdoT9aawhM1E3ATv89QJREF0gEVIaZSe+gBeysxHo2YaGb8j0L6Ya+NOOVcbsVSgVD0LktbF7/JKLiuCJY+J4qtgamy4CyFTSiq6sipYxxPwQ0S6B+D3Mj1FBTw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR17MB6236.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(10067099003)(38070700021)(11063799006)(4143699003)(261026121527099003)(261021121427099003)(261102123227099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?E6b3qel3P1R29BitbrKLGaJbZ6O1HSk2Q5AJfCJv4lHkgJLwf3/twbBizV?=
 =?iso-8859-1?Q?h1E4gHudDPP7bL7kCqTUicrIuHQO3D73zVNRhpb3jHCqEpj+z25p4K5HsI?=
 =?iso-8859-1?Q?1Z2VdqBowZX3wp/vjteCJFGxgutB6+CsAy09J+VPfwfbOktB7ruaLU3giL?=
 =?iso-8859-1?Q?aeaIWNGoOT2sNYfUltdHzoeVdXjd7zU9VKrkuTmk8YpFBRMLP34YfG3Vs3?=
 =?iso-8859-1?Q?1RewmyaepL4+n5itBg06cDsgeFaHP+yXX+ydS3ke/0BtdE4etiJkhpIX++?=
 =?iso-8859-1?Q?fM3UoU7JlnQoSE/g1gx9ImoVuYXU18YBmJeW6MR1R7Tc7aMBGpCls3rj7w?=
 =?iso-8859-1?Q?AzHluYzWY56GTl2BgZvHXFy9T24/MK6GM3k75+/ycXNcxjNW+jvrt/NUVF?=
 =?iso-8859-1?Q?22Fl1is+h+T82spDjDtNUHJkW25BheZYaAEVqHfA5ZUmygCQ/OLAPMvk2k?=
 =?iso-8859-1?Q?ILqozupr/NTRIo7HeHYraMc8BHXNXId3YBuMIg5DuX/JvFbial5n1YZ0dd?=
 =?iso-8859-1?Q?NdF6WUh/uaJqHjlM2vrhNB4Mu5FLkpSf6nfh4G9Dhf6W9Yv8W8RVRc3X65?=
 =?iso-8859-1?Q?qrix9xTJ4x3PZaapRBv86Z3hY7Sbeq02STDtM5lx+sLPp3jub7oQgkQjBv?=
 =?iso-8859-1?Q?cVzBycELtH8KUQeFfdPoHOgxnCKszQ2gfH/7JzFKayxWqTKfI8GJFMdNYW?=
 =?iso-8859-1?Q?pDjszbqAbt/hUAInsXHfS/yv4x5KnpBXRkhQLl1Mfq7vhwcbK5H/CK1985?=
 =?iso-8859-1?Q?bHoXFX3ZCrLEsDNOnRASnL64MfKUOhvxB1cVds2QAhqFb7anSpu6Otdip8?=
 =?iso-8859-1?Q?4X+BamXyymXCWQ2kTCRg5Kqxy8WbmlRzqB0bULqn1gBXrkEFVJqncGaVFB?=
 =?iso-8859-1?Q?SMY4zCM/FM1atUDEbgHwU8IanC/gxOayPBojeNjyGHGF+bOJLyWfsJyjhA?=
 =?iso-8859-1?Q?5KNRwxUnd4hEX0QPcUFmdvoLcS20NteVZj3IJv/WNv/yG9l+2LezVu9rmR?=
 =?iso-8859-1?Q?TYrSmn14jeYKLi/f9b3E1MAttWqJfzb6ItDBUa4VxuNUbvdVBK9uH2mdy9?=
 =?iso-8859-1?Q?9MbQ0QHUQKYBOuYAVbX+V9oi0ImO32AAQNW/lGlWxSu/9FvrpV3iMRGyno?=
 =?iso-8859-1?Q?rD4BZA7rk67nbUSxMmAEbGrPB9G1vvS1ymJs/mkSfAGbZAM3xyiZGq84U/?=
 =?iso-8859-1?Q?Q0Xec3CfeOXVaXjGWT9OfvyBmddqqoFjSaxJC2jAz81A5SNZfc+MiJOT2x?=
 =?iso-8859-1?Q?9iW/OcKPT6HbI+lNZ9mYmRUGVDJyxGyUJ4nIWYnPK+fyrBR2IthrLO/GOa?=
 =?iso-8859-1?Q?vtytV657ehqxYXyHLBtkdpIB1pNSGppY6NSNniMtZJ2zl0upyrgXN7kOp2?=
 =?iso-8859-1?Q?2v+GJfdrftyLScr5PmE555dzK4rZssSZlt/bqnF8NF44LUTW/zZ8wOGXZs?=
 =?iso-8859-1?Q?88b2BhrjlvSkknKj25//UInfoNjiKBBzuxleHjP9HD5Ccm6RwAPiyw/uOQ?=
 =?iso-8859-1?Q?q52KFZ+0SUEhGDBRDxXnszUvs9TMULDzT18ykTxK/HFVVQiU93mUUH1HGa?=
 =?iso-8859-1?Q?5Bzrj+Yrc9U6NehEqJya2F2b6bD8sJoWqyNT6Y4Xojt7TZfXl1OiknbqWW?=
 =?iso-8859-1?Q?ShLtAnD+74U1xegfnbFZ2MEc0dBkDkFukUi8jhhL8SLC/5ThuDC5dgUXKB?=
 =?iso-8859-1?Q?TFFpqeFyjEQO3o5TdxgUZn5X79qPM7wQZVMLvvTePVKhVjR3B2HoQL5FCI?=
 =?iso-8859-1?Q?5vX7CdRBObxxF8XctySIAdmZ3f7rPUL7staKx/31JGYIdh?=
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
	yLZQzFkB4+fhsbLici/SNPu3UtdfpqRKnqYgiq2Z2Vsf9lYjg8guEeQVkLVzvzkTSCxyqcA+MdpOqTYY7RPr+6yukqNsRGdHARh+5de6zASkhkDV+O4mZGHtYzV7eM/xljN8uRjL1VjIdZKkvLWmWF7Sk2Wyu1hbmx92sC1/BwwXf8Xb01zdvXZ9mzvvihc1ghphW2GVP+n8vb7KdBsL3EVyzr4Qj9wsZ6lJTrlogE/KcNjSmTEkZoc6UjHd4Ttau1YzZEcQG1qsY2R87V9wny+MRwMaM4nJ+e2Se9Pls/HR6IE2bV+8rTzHw382MtNlkPP0ETo3Jwmzbsi00Qq0kg==
X-OriginatorOrg: epic.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR17MB6236.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df3a7ff-2805-4022-5814-08df3a917b33
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 16:34:22.1134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8d598e0-2fb2-4605-8514-1967b50e2bd6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6s0NUbSVaZwYg5mRUTzsNcv2gklL1AZEtoHf0njWvFGTSpypUSIoUZdqmgJnJpr0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB4987
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfXx0iYxcvratmf
 VOPjUrxLEuwy+12eQo4GoE0UCud1c/ywFCRzyH4ewvlxFv1Lwo+4LYaosVcsiZ5YEQ8SGQ2Ugxi
 m/YS3mAHa7WjC6T9zXL5pFEQ++GEYRQy2/JDr/ctZe+9sl8LJps/QtVCKpnINWs4JwuHF3K2znn
 IudCGexVy48CP0O5qcC7zib3PXAI1/mWj6/Gob6c7U+aNHyIMtPw4NpbVxXoCw19/9vQR35S6zq
 P8Xvs8p9M4cBMLC8zsuGJikCjAAZeW0j93BUW7mO5W+y6Kt3dlHZuvVnHkVl00TJjVKVm2khOk4
 gRF34Z1j8ncsTOnO3yjiNMmJ8CkWM2PODnq3s40WvgyGdCd6qq4EX1mQgCpfP3zwhfMlstLzD6j
 ExOfGO2tJwxqv382gAtZ6g3MVgYC0MeMmTH0h6askt/tsIjs3D3aqOhJOAsi+GHtij3SUK/tGWv
 I9JQdmTuJLCrlUG5CCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA2NSBTYWx0ZWRfX9c9QAGVfZNJX
 M4A6F0+fvk+eTsXjbDL8XeBqZtNX4RtKS5SSJ1Dg44gIcvGJvyqRXzjCRIB0exWlOL1CtvsdI/w
 NwW2hFv8s8C4kzfZ12TEc8o5n4FOSwk=
X-Proofpoint-GUID: xYS8mcI9_bugXuSUP4u6VDHXpDOWJrpi
X-Authority-Analysis: v=2.4 cv=KrPYSmWN c=1 sm=1 tr=0 ts=6aeb5e91 cx=c_pps
 a=n8CZQ1v8Y1OZ9xNCwzzv5Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=zJRp6_cAMcgA:10 a=fLxXaBswY2kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=HcFE1RN0hNOP7eReKWeE:22 a=hIemKeEHeFGqBWBdPxu6:22 a=pGLkceISAAAA:8
 a=FDoTc83laSV68v-_jgMA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: xYS8mcI9_bugXuSUP4u6VDHXpDOWJrpi
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040065

On Tue, November 3, 2026 14:43 Chris Torek <chris.torek@gmail.com>
wrote:
> If your pre-commit hook attempts modification(s) of the proposed
> snapshot for the new commit, it may need to update more than
> one of these files to make all three conditions hold, and in general
> it just can't. (It's too hard to know what the correct names are,
> since they're different in a work-tree and the "--only" name is
> randomized.)  So pre-commit hooks are restricted to "ok" or
> "not ok" actions.

It sounds like this is one of the "not ok" actions.  I did look at
updating the "primary" index as well in this case, but ran into issues
with the current commit needing to be done before I can get that lock.

> Instead of running "git commit" directly, why not run a script
> that does the appropriate "git add"s, then runs "git commit"
> for you?  The pre-commit hook can then inspect to be sure
> that this has occurred, and if not, remind users to run the
> script instead.

This will be rolled out across my company once we figure out how to
implement it.  The goal is to avoid changing how people interact with
git, while still making these changes automatically.  In particular,
we'd like it to still work when a file is partially staged.

We could pretty easily validate that the files are in the correct state
in the pre-commit hook, but we're trying to avoid an extra step for
each developer in normal workflows.

I've also looked at implementing this as a clean filter, using a
long-running process for performance reasons.  However, also for
performance reasons, we need to know the full list of files to be
cleaned at the start. Otherwise, some commits will take significantly
longer than currently, as we need to know the presence/absence of files
near the cleaned files to correctly update the file contents.  We can
batch finding those files, but only if we either know the full list of
files being cleaned ahead of time or always get the full list of files
in the repository.  `git ls-files' takes anywhere from ~500 ms (hot
cache) to ~5 seconds in our repository when listing everything, so we'd
prefer to avoid that performance hit when possible.
