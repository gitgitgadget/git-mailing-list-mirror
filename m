Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11021082.outbound.protection.outlook.com [52.101.52.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC511F4C90
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759951183; cv=fail; b=E4csTKZBxFF7jfH+p7OKRtH2PPnvgSF2enqdeFVQ1cv1xYAevyIUoIeLU9vSqZsX7+ho/PmYgBwDD1wxbG7tfmhEpPVmsVmfYcdz4zwSpaxVjB2S0qn0FacSelLl8j6h6UgL6vd88tOKztoxD34NYu56zMGKU/r7YUYhiiii/U4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759951183; c=relaxed/simple;
	bh=X3X2QyeGLIuv1orxwwBwRTtuhSTf7bqfOvKY3zJPEH8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZOS0/PuwwunzUlMqYczv5P4J0YjNqlMhn8jkgYpkNy31Af+GK2YuJuBKapbJPtvFu58xga8+f4NwMqBywZMDekh0qbBGXTHY0a4c78Dh6+1EtcFFqNqIVGUp1apNxLugWAXgPZ/J7BkJRcEIFYs56FqfHAwxtJitxGL9y0kEFr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=signalquest.com; spf=pass smtp.mailfrom=signalquest.com; dkim=pass (2048-bit key) header.d=signalquest.com header.i=@signalquest.com header.b=i/nztaQE; arc=fail smtp.client-ip=52.101.52.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=signalquest.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=signalquest.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=signalquest.com header.i=@signalquest.com header.b="i/nztaQE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LCceQE4ywGSQL4NvqD60H9niR7gqSHgiTNiaiaUjsnAtzQZs824ZouERKdaregn8ycCXt2xSYgyXPxsAQkCR8bo4+8CRhzqb6xRlzM25JswUb1RLIYiuTSvyzCWymPHJz+bw3N9AZWj7LtWBcDy4du7In00IUDbEiL/ZbROO237w6sERt/9uyLzRNLgWsQ2eeKy76Um9Vrpzb7WbtNepx94ji2jMdrTbmXPXc3pxSFX6LarDE5dllC0HSXaKF658J5BFJQgg1qrjjDENueUNc8fAiVU2PAk8b2Bd4VgW4GJfs2jjmkxYunDBpNpXChZmUe6TTQ0VDkx2RHqptoppKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiS3oJP4u3DsOoxZmTPCc4w68A2XiidPsXHODrUQLZc=;
 b=uqiaQlzq6Ahl4/z8cokFVUIisrhQpiRrtMQzlT+pWUA0xE4kNVBDD927sud3EUv5DGeFR9X6Q2opjMTLDRWoPKFoIZ9YYOCKv6zHmHHad+9S2DeYhN+PPCXiDLtP/yTiAc8qzDy6k+xy+QxgpoMsujYmr14pHyzyQY1ezrADN0epfz+F1ISxsvNeTwL8ni5YnAaRzHZs+2ycK+GrFEtbjNM2x33cprtVOQHKuB25Ato1UpVAqtBkXL/LNuafcVYble8P6qFNWPMB5fcOBgVG4L0I83yQOqfvinFfo0IFcpguvoyR/Ow+acpWe5Ff2eIiqcM6VYmmJxxcu/I824gFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=signalquest.com; dmarc=pass action=none
 header.from=signalquest.com; dkim=pass header.d=signalquest.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=signalquest.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiS3oJP4u3DsOoxZmTPCc4w68A2XiidPsXHODrUQLZc=;
 b=i/nztaQEMCk5trGBoXsRWhS59LYFiiHJop2XERphnMMsnSjCbxyBA2EAfsiNwAbUKJUqhcCsuHAWm8oJqsst11/+C25zT2e6DAQBpHT2ZCuJAkw5Pbc5Pk2evCLpY/XgCrs+q95yOuap68u738eu6kieELPCwdPloFcja/uLwz9cyWF2fbv1Wt1ZVm1rP0H87B8BTDqP+LvgGfhSiNxAGxCMBYzhPt0vrg/sKTNM2zmO05oD9+pokiv2HUeSzgWU5wY1Ns+T92ThPLkxRkaDv4KPnyZqDjAKuppM40b6Ydp6We/C7enwlirl2gGz/rxhZFLWqByUf2BXzwIGKt2xrg==
Received: from BN0PR13MB5216.namprd13.prod.outlook.com (2603:10b6:408:158::15)
 by IA3PR13MB6936.namprd13.prod.outlook.com (2603:10b6:208:520::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 19:19:30 +0000
Received: from BN0PR13MB5216.namprd13.prod.outlook.com
 ([fe80::46e4:e2f5:eef7:5deb]) by BN0PR13MB5216.namprd13.prod.outlook.com
 ([fe80::46e4:e2f5:eef7:5deb%3]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 19:19:30 +0000
From: Andrew Harmon <aharmon@signalquest.com>
To: Andreas Schwab <schwab@linux-m68k.org>
CC: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: RE: [BUG] git clone from bundle with --all does not fetch all refs
Thread-Topic: [BUG] git clone from bundle with --all does not fetch all refs
Thread-Index:
 Adw3zvXxbRTGKqPhSiiq+FEJEt0BagACOg2wAAHn6tAAJjSTVgABcN1gAAGllqsAAEeM8A==
Date: Wed, 8 Oct 2025 19:19:29 +0000
Message-ID:
 <BN0PR13MB5216F02F4FD2C3F0FC0EA770BBE1A@BN0PR13MB5216.namprd13.prod.outlook.com>
References:
 <BL3PR13MB5209A87037FC19CBB9B2916EBBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
	<xmqqa522icjy.fsf@gitster.g>
	<BL3PR13MB520981A726145113DCA8B910BBE0A@BL3PR13MB5209.namprd13.prod.outlook.com>
	<xmqqo6qhfgtb.fsf@gitster.g>
	<BN0PR13MB5216EC49DD37699C766B8DD6BBE1A@BN0PR13MB5216.namprd13.prod.outlook.com>
 <87ldllw7jk.fsf@igel.home>
In-Reply-To: <87ldllw7jk.fsf@igel.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=signalquest.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR13MB5216:EE_|IA3PR13MB6936:EE_
x-ms-office365-filtering-correlation-id: 365eab1c-db24-4825-8f6b-08de069f9ac7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ko6P5GX6FLiRW1iknCQ86+FtTERZ5nwwqG0ZHVeixXo2BB2oNquqLMJ737Uv?=
 =?us-ascii?Q?jkbAn7klDZwhKavsy3aiblsqgJbVetlHjUlHcboRzdQ4pMe2itiC83So2NH3?=
 =?us-ascii?Q?Z7atb8+eT020kqcXUXXs0rp2Bav8c9U9ICgwJQnHi4qQhlesgjylWbZdjD7+?=
 =?us-ascii?Q?rSfWUmQzYbUNDMglXxn68iZMzJGKoVeJLStAwKh1Pf30GcFGayiS4Jc/S6SH?=
 =?us-ascii?Q?HMbahEPQMJaxBXng6xqMtyoFAbhTKbVCuuH8B8+3RFhlXn/P7iywtIt1dpbK?=
 =?us-ascii?Q?1jb8t8Gwr0Sgw8FcRzzd04hDvCIca9QdBpoKCRTAjh54zZMfPd0zqeEyHIGZ?=
 =?us-ascii?Q?NbqevIFUHgnPOyTLCOvlkjD6p2IEcJBBjGkZaHiaxp2sTUBrcYWWypg0s8br?=
 =?us-ascii?Q?LgilpROc+oNq+uISdOr3ngPjOPCH1ZeceweHVhNgsCqK1nBG4SfR9S1CZAna?=
 =?us-ascii?Q?WWawMXRYkguXiQXOZLJ6Z9oMp6Ril8J1iJ3lRCXg3Io6JUpMSFTYy5NBMC3n?=
 =?us-ascii?Q?BD4p8flDjEdDymmQc0ceBDem5NdYEjOQTYYYBODzkHz9CTJ16g9NgxdvFB/Q?=
 =?us-ascii?Q?N5lrqhk56qoVPso9yo9f199f4Mmv1QFSdjT3OgeTtDvA3VGqtFtyzTVLNfyA?=
 =?us-ascii?Q?vA2NjJuEBko5EMDEj6RDf1GfKg0PykHea2PMRnhme9NXMsx37TnTpcbe6Cei?=
 =?us-ascii?Q?ZMeAovwWskqyJ7sjM5mCmnjluQmQa9CMThVjgHVmbPw9RjyXYre5ptN2W3lH?=
 =?us-ascii?Q?TwfLkPAATDFwRPgVzT5NCwOGIQ9nn2SjB6EotPhk8Ze40nmQhhHvIUIt6PLq?=
 =?us-ascii?Q?mxVYmHcTrATfUWKt7TBlxYGoW0lGlAWCHVTKV8Tr8JywlsMjlkJLzMlQBXJu?=
 =?us-ascii?Q?tCatEAiVKkiFs5tLi6+W/cVAaQBkno0E5fWikvlp2zsy8e/Whno6dr7fJ/RA?=
 =?us-ascii?Q?5ChlLh1MU7HgrKpeDJAVoN8BZUO7VNAXTWR6SMuZBZCbAc/2IyQzHiWOSh0T?=
 =?us-ascii?Q?7Soij3QTT0LWRiKh7REpW3E/pqrPrTAaNetzeSnx4BT0+uM3g+IeyBNgr13Z?=
 =?us-ascii?Q?bVa9PyEDJQ4Ea4F0Clw0TttmHUhWKtdP/N1+/ps5E07Kaol/NPSw+EAzuG9T?=
 =?us-ascii?Q?38wNTftom+FXO+s59cDHgt0d+Cq+WR6sqoIQ88KjsKwekQ4bx6JtCBJqDLCT?=
 =?us-ascii?Q?izWIWCz7UBeGhmlS5hsmIPdcbu8sEliWMCNv+YHeaDbWZ4Rxs13BLD76Fn37?=
 =?us-ascii?Q?mHyb86TeN5mDjRj43hYnTjQhurWGPkCyq5cyKeey/44ceFxGbdEv/SG8qJCB?=
 =?us-ascii?Q?iq5ipT0WzE5UTzhucJu2ch4pOqlDuZUyAv9JWUgM0Qytpj9hvJOjuHMUUQR4?=
 =?us-ascii?Q?335y+2vaHPpas/o7E1QbL4BiCFcVtUNLq+I2YSwq0U1srs+dl7QuVSWLhx/2?=
 =?us-ascii?Q?ROABtsCj2068XThNSk0Pnr69fSC+yKHcyy1fvn+R/H60/GLfweEuggBrow7X?=
 =?us-ascii?Q?dhsC6vcq+JpmXcub75m6IVOxnRGHniqBbupu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR13MB5216.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qK4srW2SE6ydkydJ2rgL/nNhejmMqN+wyb0lM00LcwAVyizZVv5wW+vPMqan?=
 =?us-ascii?Q?oOQoUVR0RlEIV9o7blTx+HZpi6Zmw0spvW2TRDxBqC2MhoR/rC26ldYrrEhY?=
 =?us-ascii?Q?dxY3rOmQrvIHWMXI+dRj6TFKfB9+gQ+A0DaCxOPd2TiSGTO2n6V68p4HtHNa?=
 =?us-ascii?Q?4QVF5BypQ4ygCcI1WZkkFRuVYkKNudqESWq3V3ailURRyOnAAeySLHWUZ4Ce?=
 =?us-ascii?Q?xXeuXVgBHM9rQmuT5CTnMXIeHYExP950Op1Tn/MWqPVH+2DmcciW9IccOWYy?=
 =?us-ascii?Q?yzUUpFXVZz+IUS8X0MzIk2EpaZjPLbu83EDDc0DDZ468RCreFGQA04+dfX3r?=
 =?us-ascii?Q?eyvclY5kGpkkpnp++rwac/2FALHeNnzHR8kKf8EwgWYZt4SfNVoYh6FscwAR?=
 =?us-ascii?Q?P3vrMu0H8xNeJReDxR5q/W95F+XAuiTWun95HyLKqAzECHMeI+2Y2qnAswIU?=
 =?us-ascii?Q?NGz9F8OrgmqcpMlA4QPTWUmdk8ykyeM++LhpOYQb3R1qDAiLFT7aS+Yqq23O?=
 =?us-ascii?Q?/Ti652v9LjEUIw6boy1SNKy2SijB+chXU1Sou7xrKmtAavhfTycc2HSrVcVZ?=
 =?us-ascii?Q?FSAns9+MACet9+OYVDGGO1yAIzhZDAElUudX/Wn9YZMJ/vwRG8yMbXlNtyZt?=
 =?us-ascii?Q?r8IhweVyQXxmtTB8zr/+ewKiY+TzDcLWAf4ggrEJNeuvPwNiN2hheRoIQNnt?=
 =?us-ascii?Q?lordPcyEjXAvxXyc4Bc+MBoTGj/Z9ujL37JijpyV5WaL1+wfpdGh3cn3CErn?=
 =?us-ascii?Q?/3NOlOURJMHvA0pFXqIxPg6RFv6ItqRxXNLq0xvk4SJtzwcjkDkCsxaBBwKU?=
 =?us-ascii?Q?oY9aJbGhZbC32m9+HOHIvIfaq9lOC890/lZIIoYX187zuQr08U4cZYy27v83?=
 =?us-ascii?Q?PGY92kMKhppNCryabUkx/1qSCl0As1UjJJWxfH2WJI7lh1uO4yLHolRmHI29?=
 =?us-ascii?Q?/kb+wiV/VKBE7B5oD6dSP4T0CgryJCQvHo251P3NqxwKGJG8NnW+PAQgHT7d?=
 =?us-ascii?Q?A0U0Q633/8oXwpQHSTBDTy/N+/Nnr73ihrUCV/E0MAQo5qtXfov04AZGkZna?=
 =?us-ascii?Q?TErt/SrAEhxh1Fy0ltUGcHFVhz1VKqXTQgZi93iguh7XaHMJwZMahqwh6WAn?=
 =?us-ascii?Q?02ZHLTy45wgenLfQzM1KQWidB+Xoq/LWZkRUkI1zXm+2zAthuLRj245f4TbD?=
 =?us-ascii?Q?E0+iBgcIIkFLe+Yibx+eHi3eTrsFl7SgbwE+EEezxowxA5A7j+uIKXWPEU3D?=
 =?us-ascii?Q?rrszp5VSU/Yzr8K430ohYZ8qOVlQAcVu++8WHpH/5z4Q3M/SUqPCIJx3Bus1?=
 =?us-ascii?Q?vPWpZKgi490M8F3/sjsUijmURPI2mRlJeRGqKXA0HkLl+NcaGPPVuiF7pSko?=
 =?us-ascii?Q?VklhEWiVMCTcDgDj1mAmgVA8OG0loPnerbq5F8c/IGBmM6OQXWpVXtDC9yYw?=
 =?us-ascii?Q?R+RJtimCU3tlC3VghwMtwLcA0rUDUHyKENjvhNnRqgCmswPgYevLlAy35bEa?=
 =?us-ascii?Q?ycONuks/jAFEtgZhYBV4THtX+/iK1ng1QO4eO3RNZCwhMERPn4MhkLioLS2X?=
 =?us-ascii?Q?eRSQytR54Q4NA7buQJHpI0p5rSO09KTymfkUWvlD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: signalquest.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR13MB5216.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 365eab1c-db24-4825-8f6b-08de069f9ac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 19:19:29.9295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d8c969d8-33f2-4029-8dce-76d1b998192a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifBYEr4VtDPCOYTG/JmM3SDU7cUNSjQwCXuTiMRFFn9XVTE39Kgdk/+fJYGf7wgv6roKOZ1F5cJt/PsIzSUYng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB6936

> If you want that equivalency, then you need to create the bundle either
> directly from <ssh-or-https-target>, or a mirror clone thereof.  By using=
 a
> regular clone as the source for the bundle you already have a different t=
ype
> of repository than the one you see at the <ssh-or-https-target>.

Thank you! This explanation really helps. Creating the bundle from a mirror=
ed clone of the ssh target is exactly what I needed. This could be clearer =
in the docs. Several hours of time with Google, Claude, and ChatGPT all fai=
led to point me at this simple (and now obvious) explanation.

I appreciate your help, and your dedication to the Git project.

Kind regards,
Andrew

-----Original Message-----
From: Andreas Schwab <schwab@linux-m68k.org>=20
Sent: Wednesday, October 8, 2025 14:52
To: Andrew Harmon <aharmon@signalquest.com>
Cc: Junio C Hamano <gitster@pobox.com>; git@vger.kernel.org
Subject: Re: [BUG] git clone from bundle with --all does not fetch all refs

On Okt 08 2025, Andrew Harmon wrote:

> As an end user, I found this very surprising. I was expecting to call:
> git clone <repo-bundle>
> and have this behave just like:
> git clone <ssh-or-https-target>

If you want that equivalency, then you need to create the bundle either dir=
ectly from <ssh-or-https-target>, or a mirror clone thereof.  By using a re=
gular clone as the source for the bundle you already have a different type =
of repository than the one you see at the <ssh-or-https-target>.

> echo ""
> echo "Clone the repo via SSH"
> git clone git@UBUBEAR:external_sources/matrice_sq.git matrice_sq
>
> echo ""
> echo "View available remote branches"
> (cd matrice_sq && git branch -r)

Compare the output of "git ls-remote matrice_sq" with the output of "git ls=
-remote git@UBUBEAR:external_sources/matrice_sq.git"
to see the difference between the two repositories.

>
> echo ""
> echo "Pack the bundle for offline distribution"
> (cd matrice_sq && git bundle create ../matrice_sq.bundle --all)

The bundle picks up the refs from your local clone matice_sq, which is diff=
erent from the list of refs you'll see in the external source.

--
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1 =
"And now for something completely different."

