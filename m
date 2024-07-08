Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2104.outbound.protection.outlook.com [40.107.21.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3708B665
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720444821; cv=fail; b=Q2lE6guk2Sb9Lt4wbUNmVuFyDzehJ6rRl4CUFJqz7fNAAiRD3y+hoVT65q7hvs1npkSVXhzZj/QVi3q4PCjuF4jYN+Kvq59sGBnsUE692jD4sMWlDOQHg9N1LFHFwshrzAQ3CRtonvKmB17R5XZj8tpMT8ntCImiRFSdMtezRfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720444821; c=relaxed/simple;
	bh=O9A8Veo7/60ThsAfIHfIUtwJD56p150Nj31k+uytDZE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q+5df8hWD4FIDMHxKlMANuo6oYZspNMgqsHsMkWtJcrHx1jdwu3POXOHQR51A1nzdb1884sxsprJ8fENHbJkPOC2wVhkHZOLcGoaoXAH3Jn1DLxmzrUdfnv94QKs0JEtatAhhARQZ0T4wPLM+opQ8+44qYZn7FehsUdnZB6d1dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=envirovent.com; spf=pass smtp.mailfrom=envirovent.com; dkim=pass (1024-bit key) header.d=spvg.onmicrosoft.com header.i=@spvg.onmicrosoft.com header.b=TAI8xqNB; arc=fail smtp.client-ip=40.107.21.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=envirovent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envirovent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spvg.onmicrosoft.com header.i=@spvg.onmicrosoft.com header.b="TAI8xqNB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GD172/v0S2ZWH/g4zgwr98OZ4VZG6Arhws5emdlmrVbhMdka0ge5xv0aTv8ui518Bi6K7KrNnGRp8N7DBEo6BEJOViQNHRBKbp6rR7DN/P10FIDT2xjbGpEFMd0jUzV9unLte8uXNpxqIjpgeKG5lajFAWSF+TUOt/TUDvuMEIpkO1eYX08wYYzUup0yABeqHqH16/13EHW93gcBVRlHacDzuEcMSuqxcqNJwDZyj9XVXUl/nB2HL2VjCxhDLLZzwoMLUKoaLE4cG9+WQ9VpYDnTYz6k1cY2J3ZuJ8kJqtBTGUWQhmB01TuJccFKNrNjtIzTYYJvoEL4gKzpNybrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O9A8Veo7/60ThsAfIHfIUtwJD56p150Nj31k+uytDZE=;
 b=HvG7HQV8QbDXEdjmLebdanqYhje/qN7FuLwNHAHmA+Jj9wpUIdm7kVad+deYKHmdhExt93GLwLccXdThjuh1F1eHUypjIGJmDca0Z6W2DYckts0SErSvVSbXvRJX6vi0ZGes/apdWz0faGDp3x11lU/t57H4M+5uH96c5zcoBJfgWfWqvUvc0wLz5VlkyuQ2sKbs1wrEAriZpXVaIZWuylBootQqBamd9Ch6KZjiFWLxyKTA5NALrE2he5LBXf4PagzDo9mBUo1hbz78z7UyNGbCrYg64pNTDi+2ssmTOWxN5q65CU3lz9KBgxoblvZzr/Sosyf/b6YDiraXpNhNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=envirovent.com; dmarc=pass action=none
 header.from=envirovent.com; dkim=pass header.d=envirovent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spvg.onmicrosoft.com;
 s=selector1-spvg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O9A8Veo7/60ThsAfIHfIUtwJD56p150Nj31k+uytDZE=;
 b=TAI8xqNB9OFUzs39XC7JQhoUPCs11dHSu7fUoQ3f6MQUVU/Yb8ZGZW2LxFxTZBgK3Q+PgzBCIB2QAqZWW6MEiTu6twdSWyPjbOxkPWc+rSCJiraxMB1FYoneTfNARG6afAvGRFmtPlsJMKyUiqYWGz5S8RLLlCEXdl/oTBTDA9Q=
Received: from DU0PR02MB9942.eurprd02.prod.outlook.com (2603:10a6:10:449::18)
 by DBBPR02MB10795.eurprd02.prod.outlook.com (2603:10a6:10:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 13:20:12 +0000
Received: from DU0PR02MB9942.eurprd02.prod.outlook.com
 ([fe80::baf3:8eac:68d8:5652]) by DU0PR02MB9942.eurprd02.prod.outlook.com
 ([fe80::baf3:8eac:68d8:5652%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 13:20:12 +0000
From: Adam Pickett <apickett@envirovent.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git Update for Windows - Cloudflare Direct IP
Thread-Topic: Git Update for Windows - Cloudflare Direct IP
Thread-Index: AdrROEHkn/MB1lnUTc+FPo5r16SQYQ==
Date: Mon, 8 Jul 2024 13:20:12 +0000
Message-ID:
 <DU0PR02MB9942C645E78AC23619F05D0CA0DA2@DU0PR02MB9942.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=envirovent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR02MB9942:EE_|DBBPR02MB10795:EE_
x-ms-office365-filtering-correlation-id: cdb53f9c-0111-469e-7942-08dc9f50b2af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dUgMgVg0PnZxFntkJNDZ7RtOXnAZDB6kWL7lvLccVKGJSftAnQkSgc2P4CGn?=
 =?us-ascii?Q?0c8UfqOFGZIfUIHiwbrVv8f5/zNAsjult7ta5MwKX1US4z0pN+ek28t8BlU2?=
 =?us-ascii?Q?v+VnQiHdW1pspr+O2g/NcysPU512p1zGZJf1wTRI1lI2Psdm8S8qGXQi7n5E?=
 =?us-ascii?Q?T3JRj6Kpke1sVo6QIQYU0SX/BjT8tIgq99tVzFn9f9J2AKiYndxH9Kw1X+gr?=
 =?us-ascii?Q?WSzfSMXQ8CPPbJc83YLjFYV0QXKcoNlWpdoRz/7iHS380ebRLz3e1ibLnPkP?=
 =?us-ascii?Q?42uOnq+VFl4FO7+5sXWWBJnHuT1MWdv9H7Z+Px3Bd4L78qgQitU2FW+66Dex?=
 =?us-ascii?Q?g1TpwAEqNYkOe56LS0qf53Nh+9CLmaYe38VI0QSJ5CTNqRfzPJiJG3S694+i?=
 =?us-ascii?Q?2loz5hOmIaeEXhbwy+FXajyXwZOixmO1EITg8HyjszgI1cBCl1TlDvEZICei?=
 =?us-ascii?Q?ReyXpLUWRRXaJMaq9aenMrDHGBQX9yaP1XJaTi4mdgaegz7aWwa2KXI22Q+Y?=
 =?us-ascii?Q?eeuRouPGj40yzYO/ZRp2UiksXumf/dYeKM4fWnJ0ckY5nEdsmC9EodYjO4yH?=
 =?us-ascii?Q?6LsPAuQUqw0rMb4gy19aDAwGtVvpQSI0PBg4KctgQ4++8AB1Y+ug91P5Hw+x?=
 =?us-ascii?Q?2DFG/340itRuk+Z2oGVTujPHbC5c0QqqOOGMZEzbRpZt0zgoTZXAYqXICqXE?=
 =?us-ascii?Q?sYPQbkR8/VPnBxKrB8yRCwa9CU/BQBAe3P4Me3V93fEi7zfuj0g5JJPswG/c?=
 =?us-ascii?Q?MQtpMEGZoeSVw6rCMF8kYK0SETp46Vymvr1+vlYsfi1Ilpugloo+Qyw2bl3r?=
 =?us-ascii?Q?PHQ2Fdta2KUTp1j3hwIa2RQ9i3+iGHcfOjf306irKIYTpFHkmqMrO9+CYO3q?=
 =?us-ascii?Q?9vENKQ9rIuVx3kDLmTzgkBejvtL33jVpA724aSd1ZiCVuedNp5kciIdXRXdX?=
 =?us-ascii?Q?vnH+Z9fjO6UKOvq0u+EWiTqEskuHMd6x3DIiisqpk6E6JTIMSzotG8UCVM4Q?=
 =?us-ascii?Q?iMGYMzOFyTpxN2KFpgMvw/PvGy37RCsCZy4faRIqA9uB10MKGJTD8UhSErb2?=
 =?us-ascii?Q?1kSzXdT6nNO12p20aeLyYUFUuZI0mc0N4ru4kdeRlAaW7Xcgo5C/5rWGVrzY?=
 =?us-ascii?Q?145p2qI1KGtW2oxZEseYlmYsmzTXUl50fO9+HaZScqpSLWHQvxCSH4yf2m6j?=
 =?us-ascii?Q?YJZdaTG1h7DIRfBCBhh7Z8LBbR74GfWPpiHdxHYGLKybu39hScZnUjV8wp3N?=
 =?us-ascii?Q?15+rpzjEUeVWKBVRxLwZVhf5SC4Hgt1Dk/etMHamOgCCp9CROANPoGJvRfRb?=
 =?us-ascii?Q?faBX3JIV0xIsmzhGMnyRhTBUj38xskidX5AWAlXLDpJVAgTCuLiMM8SqXhMi?=
 =?us-ascii?Q?xfsER5tRCpZPZ+Wab1OvPr02GG2L1bg3FnVDGLHXf+FOaiMrRw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB9942.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NUSw8pVzHrb+nh5Qhk8dgPu1vPe1ec7RKAFUr95L+xYyMgM+e5aJ45M+Ey0S?=
 =?us-ascii?Q?hIUJnEPENJwLoIEkD5qXCF3lfL+dM6oekpZRli7LE45o0RiaxvoiNMy+wkan?=
 =?us-ascii?Q?Nghu2zot/CUhsNT3f9sNnVCy/Bx55QU8TtiKjwH7Nwi2i3J9k359y8hHRwek?=
 =?us-ascii?Q?ay4+3yIohhdGx+l31K4Y+liAmHOGX0dY2E6vASqkhVd+Bc8DVSMuqeMjAvKU?=
 =?us-ascii?Q?K8vEl62vs5VrI+GouZ1z3dbENfZ8d1JMaWv1dlPDz4kxNu9EwRp7wx+x8KBv?=
 =?us-ascii?Q?VaQGZu5oPALCuaTyO+sv87RKw3Y37DryWuf2UdhBQkzsPiidXGtDVbZBtr1g?=
 =?us-ascii?Q?RudVDpDmNwilY47NC8Lrv7AqwPsVLCl602Ecm9Oj9+0QtnfE/mJ8n8kbYo4z?=
 =?us-ascii?Q?rYLdI/qJ57OK8mVzU3EkU9Cx1r+JNV24dRLFruMz7GhWz6j3LArma4I3zlhw?=
 =?us-ascii?Q?bftuXlRGF6vGeup1tQGsP4A/5EjYxBOu3uvt9s5ePc434lUPYCCwfoV7zuYa?=
 =?us-ascii?Q?IdAnjpyY1b2IHCtB6/91pZprwoEZ+aNdKwCy/PD5oehBqIbZtTQNWWya7OK1?=
 =?us-ascii?Q?Uk7t6ApUq80CALO5CUthe0teg/63ghARDhfiCvv2rQm7tDehqAXahcKv6qoE?=
 =?us-ascii?Q?0m7oTkjhDWxVR7FVPoOB4E3d6MuLuv+5xQu7wQp8+LegZ1XiSlp2pIGgkGG6?=
 =?us-ascii?Q?KAK4Yk4fDHBS8z50RiR8K1bdLVN/VPu9CaRlbacDWx6jIlaGIkFdygmKieMc?=
 =?us-ascii?Q?oYOJbGprncx6FBSqfATpzjh+K698aloDCMnvjH/QfaJMf1P+sYUo3IruNEtd?=
 =?us-ascii?Q?qEOPmSR03+3KqOaermS+dZuxAe4PPCxXEsOaUeoL8funTH89e6val1rggFG9?=
 =?us-ascii?Q?VopA7jMm2/35XYfIaOaGrR1wTWmAHXpo1GgwjfIJTlkYYI0aCdLxrh84+C0r?=
 =?us-ascii?Q?WAjs1J51eXNZCS6Qr+cva/dIPIa6hg3DH5WR2WyDs+Mo7sLjBdN5nlmArfnD?=
 =?us-ascii?Q?PDWe+rQylRl0ZqLNxGKtztox9Pr9CM10iFFCrpt7OiSjCF+cIvXp80JMFX8t?=
 =?us-ascii?Q?4NG8Qv0gEE4AFB9gGCjfpMuyqfUmIVcDcG9tRKHnmypi5GsxDlJsRmeeUUSZ?=
 =?us-ascii?Q?jnzan2+3H5wIEemEB/+PLXMHH8d2WauzfH1ZVLe7dXO7dGzPFOMcQA4TV3oF?=
 =?us-ascii?Q?gyHNRmFMM7zEFMMIaI+rRnLFk2bqqCWjH7PUHk16OApCVo2cRwnlsn6pSAQA?=
 =?us-ascii?Q?qdnJDyUctPIcyy8VBhPNExR0G2B9FXBt5s7z4GWv+4M6yjXi68XiMEMojVcl?=
 =?us-ascii?Q?74CIpKBqnxsYoDdGjxsn3a0WSSnryC/6C7rGlHcDuYZ9kn1wdESdXv7GUh7Z?=
 =?us-ascii?Q?j92nMRd12TEtOpy4y9uTu0epOOFXQoFgJl0E4VASqYZ0Hm3kRgW2Ym2D4M3k?=
 =?us-ascii?Q?C6rjXIwVp7m8vDAzZ47dbr42vn/Uifj1M+JbFqm808YfhSyyDCqg/zM+gp7Y?=
 =?us-ascii?Q?+pAs3yV8cG/69bkKPylEqswb+lcdbVdtJAOa6OBNA4mZu9OhMMtL/Mh3F41h?=
 =?us-ascii?Q?ZUWTkBmhkyk4CCe1IBZFOBaBXfGfKt7It7lIaEGH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: envirovent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB9942.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb53f9c-0111-469e-7942-08dc9f50b2af
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 13:20:12.3378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 89f218fb-501e-4768-9b1f-d1fc4a69cb9a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +oEMdm7vXaOxMcSnuPSxH8/N/Q7y/mGGgK/EKxVhK8H3WhBCplKitCVaC9SwPMwHu4mXtOcPaHYl3vSV3HnPqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10795

Hello Everyone,

I'm having an issue running 'git update-git-for-windows'

I get the following error; curl: (35) Recv failure: Connection was reset.

When speaking to my network team that have advised that they are seeing and=
 error from Cloudflare.

Error 1003 - Direct IP access not allowed
A valid host header must be supplied to reach the desired website.
172.67.12.172

Can anyone confirm if this is a general issue or limited to our network.

Kind Regards

Adam Pickett


