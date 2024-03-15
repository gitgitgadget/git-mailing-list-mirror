Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2125.outbound.protection.outlook.com [40.107.212.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76CF12B6C
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710482948; cv=fail; b=NnXLxPMpkpQJrl1Kh+NKe7ssRD1F/8jhv46HEGv5eY0qo1a4JIIS1j1OlkEIEYWH+jbwGVfLDTicxkmhZYRSJy+wo9089/ghezNtDNnGYWVTUQNJrLEHCgBAyJi2kZt+1hwxcXMGMo8CoGTRNHShBMGDc7KaHb1nL0Qwo5AoDUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710482948; c=relaxed/simple;
	bh=k71SU1tAKdYFySnb/wTFc83qQC+9MYrVay43bPSiHBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VVZKKX6bsj37cyMyWCM8IR2ZzOO9uDjfo6ds9FJnIRmO5zz7/+VPHcMUIRqAGIRTnnKqQcuUQxe29VyO2dvQNm9E3pvJcDvNJA9NjNjW64AKbnoMDqN7Jnhi/lXXtcdUVf4YHmR5J/cSTJUUXTL+S+7pOcyr3VAshQwdVTiOCYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com; spf=pass smtp.mailfrom=webpros.com; dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b=L0XK7n5k; arc=fail smtp.client-ip=40.107.212.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webpros.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b="L0XK7n5k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QijddQ/NbZENAhQgvR7Decvfo8G+cYug46NS8wYCs52W8uKdh3YW3+Q74pUnTj5Av3woOKyXELGLSELslhX2cwt/B5BHdUe3Bde6IWiZ6pz+UDzOujedUOMYL/daxwUJ5AmLqvF7Qe4DO8n0+IhPWukb20I8y3xShHW6hZZSFgB3ONrxbor/2Fuye8XGQtR91FE/7F/BWVxurZAe6Nusg3D2ltQxm++c/9GvqW5lT1wslRMxYZS+9c34i6r3zYt3mes+FySjQoLpZEHl1ZwtPetDQRTifM29R+wcICZKdyrolk+yJxZEHBAJtcKC6DjTEFO8Vp2BPYED4NP307YxVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOHXJtyfVblDCPa489Q76CXQ8mWWHXFu9M8nd6u/TCM=;
 b=SXtHucIi7Gp+W4xWUDbDqbQELwyn90eikNwbu5VfGuQD4+LoG0fYjGRONQqfJlf4OMslIxbV3ASUCpvI0cfzN2PLBkALP+cR9+oHj1RDtFJTJB5rw+SSNE+CweXfgeYgoIixusW1ir6wRmHkKUoSgKdb5ZG5616tippQyRDDjLZs68CEc3ZqpGz8hfOJVFdwu484bvt1RFEzXrH88igM/PdKldiNLwPatZ9lGKOdRTMH/i1i7Klry4BOoJaG7h5aS9d13plaiUE722rfhWiMMmGbxbplNnrj9NCXDshOG15PbRWmJNa9lxcdQhyIUaameArSUSyk73ywAVwb5mSrNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=webpros.com; dmarc=pass action=none header.from=webpros.com;
 dkim=pass header.d=webpros.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=webpros.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOHXJtyfVblDCPa489Q76CXQ8mWWHXFu9M8nd6u/TCM=;
 b=L0XK7n5kRI5UvhLhzVDw/HDeTmzJNEnnJrdizk5/g5pvNaZsNIK1npIb7cJ+mjJTfEu/vbkYqw1UDoeUnxIfXBFZegJgDf3HE30nlQ08LYoOequNbpLzAnabCRa0c5Crfq2nG/mZazfkpKj86h8XBOP9SGnYkqsRl16MqQD9djXpvsC0+326woePzLztFXWumt00+DhhkBr6dBq0Sb3lOVlLyItPGOIZOkBpE32T/IHiwesXlnFVdj236Glzg/Ah7P+cSnNwUAqlCefBuUwR7Hlv03Gyx+lskq7Khd2cgzf2uTd/QkCE2H7sVcK3QRMuzIgicx28bLYrikYWcBvWgA==
Received: from SA1PR14MB4691.namprd14.prod.outlook.com (2603:10b6:806:196::11)
 by DS0PR14MB7230.namprd14.prod.outlook.com (2603:10b6:8:165::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 06:09:03 +0000
Received: from SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00]) by SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00%6]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 06:09:02 +0000
From: Christopher Lindee <christopher.lindee@webpros.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] Add transport message for up-to-date references
Thread-Topic: [PATCH 2/2] Add transport message for up-to-date references
Thread-Index: AQHadMfJU4Kb2lPtQEKMVlla3PY73LE2XZh/gAH28i0=
Date: Fri, 15 Mar 2024 06:09:02 +0000
Message-ID:
 <SA1PR14MB46913A0B1CB3F3D39ADA6A5F8D282@SA1PR14MB4691.namprd14.prod.outlook.com>
References:
 <SA1PR14MB4691A8AC86E290A3539BE1398D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
 <xmqqttl94qxg.fsf@gitster.g>
In-Reply-To: <xmqqttl94qxg.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=webpros.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR14MB4691:EE_|DS0PR14MB7230:EE_
x-ms-office365-filtering-correlation-id: 229504e9-2003-45ec-7f3b-08dc44b66949
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xXDkeBp0N8B7q7A8MU8qs9fauj1F3mg4/4aHi6inEQ1fw9084Q3qx7u3JL6cBqMuj7xRIu3ngq+Mlm/DtVOWJqw/4+A/QpaXVHmoZlbHZQ/ZZTVnWx4EWQZpExaEBEO19c736qRmIkXm+nku2RS0AuCwU0ewvRQNZYJ4m2jjA1B1isHeIKU3bbohJ/fd9ztZxo4CBMp3DLKi6fHZfTH1wGSk+CTa8N+z1YnH8iR3y3C7oQ5Uu1AVqwx03BXztpLlXcVU4nOC5RE+vlfIjHh4KIr9pXivFdSqDVnSFkMRMJuq/U4k1R238q6O3671I4laSJ9MvvHVevVJNgjFl0tfiekmqJCQEj5xXKRLJpYzC4dGmjGt3US0+yFUZppEIxUV4yXFgkDTUmA+FBikrLLry8mUjCdcYu9ZOtiatSDhCAga5w4buOGtTQeGTXzJ0qXCB0NTbBqq0JY09TXZlRDIviQUoEwLsyyGTf/Z5TtEeiIeAFU8g8qHnLyAqITBHFhKnuMn2tKyMeDSIAXp8PcalECTj+Rjb5ebykLcznNIVl6TC26KZMgOWK32/92gtCOrd6QX+UqCZayrBUsU2hhpwAg23thoproAEGoxi1A2RS2U3vh5nkDuYrt30NL3M2X5QvAPp+pH+43WOnaz2x6zS0JUZStttRyGJNCCDomuP4KtjE0lr1B5Tec7xxvXUKgop8aYkYP1VGs95BC/u8xYVFFeFekB7XP0B+7htPGG2Pg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR14MB4691.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?4hCahSfOyAI82s2J92Mj/k2vqvZy23wBMyyk8Nl7HHEZDWVsRWE+bhqeIx?=
 =?iso-8859-1?Q?4wZ0eyG1oLTTpbqC1xF/NfBAAzjStAziiCo93k2p7bPfPwz0xVoqXJq3BS?=
 =?iso-8859-1?Q?ccO1x/3C4tE5EYI/SDmdoXmZyJFYnMcqv7vrjUJXth85ylZz/4pVWS/16j?=
 =?iso-8859-1?Q?EwrtunEZ8lTbAiH8+xQPjw5b+0xgcgtZbisdr6zY0eWyccc4VtXn9VEw8W?=
 =?iso-8859-1?Q?5Z2Zv1PXv6BJteBNTuGDg42RnImt7tWTYpyu22yitPntsnKgukl8lw6JY8?=
 =?iso-8859-1?Q?V2qNp4N6iCzDLq0rtJ9yIOrSzMwyrUSFRPxOuSt+U2/pTjCrj2HM6SZhGf?=
 =?iso-8859-1?Q?P92qBnfaRFANZEXNp16Qp/Q4s91mNxaqx9WDHxuOLRvLzLKrMS7SWNtV2S?=
 =?iso-8859-1?Q?22n0mqSKCugNmhChNOfp0YdVkkBE1zN5j755x9vNKBJRl+mhMeVk0/CrDL?=
 =?iso-8859-1?Q?zgFdEKdsDW9XUIFNvRSoi7huMNFctzmjwJeStGfQ1VfXBUU8J8i+gPiKc/?=
 =?iso-8859-1?Q?phk9xzAxHo+e/JNHkaEc70vCnxSlVFTBYE6BV0r+iayCJ4egYtBoRoZCBR?=
 =?iso-8859-1?Q?CdASJQP6JRbO2ooAUM3KLBGxZe7mFQauWrlov+4IqP1HP+5QY2N5OxVOVb?=
 =?iso-8859-1?Q?/c0ENMv3BYDjm43oj4LLuT2XLC99DFtcedG+jTDtt8rz9BhRYETqbPyqLO?=
 =?iso-8859-1?Q?eMVsKSVXwgrQccHJeZM0Oo1hI6CGXBvqY8AfOrznDuLTjoLGZc9o2tJf62?=
 =?iso-8859-1?Q?0Qhgk7zbe6qa2BB33ym8bdClmHUfXWdilIF3lVmhAirDSZIGF5QlDXAAFi?=
 =?iso-8859-1?Q?ObaFjlZdEi9wwn8ObfJTp/iWXCgrDr5Z7cIYJ56dDE/q3E70BaIRhZiVM5?=
 =?iso-8859-1?Q?3rGAjxsRx4cQDKqXsyHutBrDo82Gh8te3BmBv4w1YACCRq2uqemMm3FWPL?=
 =?iso-8859-1?Q?IB49gf8oPg2p/2DMf6wex2lcyQkEW0bntRkFuXFtjrexP94n2glbqDmCXg?=
 =?iso-8859-1?Q?2PVZJLKWetIxOsy10l33o/5JhnM1iIJvYqtTFLlvbLT70BvduryAqL0kJq?=
 =?iso-8859-1?Q?DBu2sg6F3gJAkSvz25pGbN16uvpCA8XQt+MHTE6vN14LXLbAvMcYRypafv?=
 =?iso-8859-1?Q?SIca7GgjA7nPFP/+FQ4o0SBe22Nb6ksuY60xUf0hVPkBNjh9DGBKPzLVi2?=
 =?iso-8859-1?Q?MWa5yK5IveOukVkJvb5LdwGB8zJUlk0jGgqQsK5Q+WvVnEETOIXDl9eEEG?=
 =?iso-8859-1?Q?Y+LEnaEdX9g6kq9Ur2A/MkTTxjdqsU9IgjOv2YryQJVaQzeVg1FIc5b2QS?=
 =?iso-8859-1?Q?vDVaPmRuP6XKpWubRbson1G9ziy61UwpAFn5lisoS2F42IWJJMbTLRMQl6?=
 =?iso-8859-1?Q?N/DbBGoqPbmrwWxKQKNRXcqlVKtwW+c9HdcqIkW1p3OgmCfC9YLE60DK81?=
 =?iso-8859-1?Q?jk5JjiESuDw27nT8auV7hrQeaRPFPXW1j9NQ4ibHfPRgC0/ItySY9IvL72?=
 =?iso-8859-1?Q?1gNCxxxuyiP+WnBHdzxX096R7ebovLoXjOf0rvLUHERnKO4byitc4i9NJI?=
 =?iso-8859-1?Q?pBnS7Maz+BmfBGIV/VVKJB/w4gJ3LF0ePO+RN9J95wDZhINbf67tUDWjk4?=
 =?iso-8859-1?Q?SVQdt4U3ozAUGe7jn9y0pxo8q1nj/5UnC824YxNXoLG1YF7tqO1idNJA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: webpros.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR14MB4691.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229504e9-2003-45ec-7f3b-08dc44b66949
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 06:09:02.0426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8497356-a834-4060-86b6-d4b1d8059ee0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BRbbDWWMrglNqMWHiLAf/a/f7w3ok7Ott32KruGdtToEiamClGdJWmk2b4Buu4oxQOozsTTIoQ0/EXuN9IgLXM402zAGn7oAv9qhe6AJrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR14MB7230

Junio C Hamano writes:=0A=
=0A=
> Christopher Lindee <christopher.lindee@webpros.com> writes:=0A=
> =0A=
> > Subject: Re: [PATCH 2/2] Add transport message for up-to-date reference=
s=0A=
> =0A=
> Same comment as [1/2].  Perhaps=0A=
> =0A=
>     push: mark forced no-op pushes differently in the report=0A=
> =0A=
> or something?=0A=
=0A=
Thanks!  I will correct this.=0A=
=0A=
> > If the `--send-up-to-date` option in the previous commit is used, the=
=0A=
> > "Everything up-to-date!" message will never appear, even if all of the=
=0A=
> > refs are up to date.  Moreover, the output `deadbeef..deadbeef` appears=
=0A=
> > suspicious, almost as if a collision occurred.  To clarify that the has=
h=0A=
> > is, in fact, identical & to allow grepping for the phrase "up-to-date",=
=0A=
> > add a message to the output when the ref is transmitted, but no change=
=0A=
> > occurred.=0A=
> >=0A=
> > Signed-off-by: Christopher Lindee <christopher.lindee@webpros.com>=0A=
> > ---=0A=
> >  transport.c | 2 ++=0A=
> >  1 file changed, 2 insertions(+)=0A=
> >=0A=
> > diff --git a/transport.c b/transport.c=0A=
> > index 84deadd2b6..89802452ea 100644=0A=
> > --- a/transport.c=0A=
> > +++ b/transport.c=0A=
> > @@ -670,6 +670,8 @@ static void print_ok_ref_status(struct ref *ref,=0A=
> >                       strbuf_addstr(&quickref, "..");=0A=
> >                       type =3D ' ';=0A=
> >                       msg =3D NULL;=0A=
> > +                     if (oideq(old_oid, new_oid))=0A=
> > +                             msg =3D "up-to-date";=0A=
> >               }=0A=
> >               strbuf_add_unique_abbrev(&quickref, new_oid,=0A=
> >                                        DEFAULT_ABBREV);=0A=
> =0A=
> This code is in an if/else cascade of this shape:=0A=
> =0A=
>         if we are deleting=0A=
>                 print [deleted]=0A=
>         else if they did not have any=0A=
>                 print [new]=0A=
>         else {=0A=
>                 if we forced=0A=
>                 then=0A=
>                         prepare to say forced=0A=
>                 else=0A=
>                         prepare to say an unforced update=0A=
>                 say "updated" in a certain way=0A=
>         }=0A=
> =0A=
> The above addition looks somewhat out of place.  I would understand=0A=
> if the addition happened like so instead:=0A=
> =0A=
> diff --git i/transport.c w/transport.c=0A=
> index df518ead70..bacef94b33 100644=0A=
> --- i/transport.c=0A=
> +++ w/transport.c=0A=
> @@ -666,6 +666,8 @@ static void print_ok_ref_status(struct ref *ref,=0A=
>                         strbuf_addstr(&quickref, "...");=0A=
>                         type =3D '+';=0A=
>                         msg =3D "forced update";=0A=
> +               } else if (oideq(old_oid, new_oid)) {=0A=
> +                       ... prepare to say "same but forced no-op" ...=0A=
>                 } else {=0A=
>                         strbuf_addstr(&quickref, "..");=0A=
>                         type =3D ' ';=0A=
> =0A=
> =0A=
> to make the new logic flow more like so:=0A=
> =0A=
>                 if we forced=0A=
>                 then=0A=
>                         prepare to say forced=0A=
>                 else if we were forced to tell no-op push=0A=
>                         prepare to say we did no-op=0A=
>                 else=0A=
>                         prepare to say an unforced update=0A=
>                 say "updated" in a certain way=0A=
=0A=
The shoehorned `if` was to avoid duplicating the `strbuf_addstr` and=0A=
`type` statements.  It sounds like code duplication is not a concern,=0A=
so I can make that change.  However, with this new logic flow, maybe=0A=
it would be better to have wholly unique values for the display, for=0A=
example:=0A=
=0A=
   deadbeef...deadbeef  main -> main=0A=
  -deadbeef..deadbeef   main -> main=0A=
  =3Ddeadbeef..deadbeef   main -> main=0A=
  =3Ddeadbeef             main -> main=0A=
   deadbeef^!           main -> main=0A=
  ^deadbeef deadbeef    main -> main=0A=
   deadbeef=3D=3Ddeadbeef   main -> main=0A=
   deadbeef..deadbeef   main =3D=3D main=0A=
=0A=
There's a fair amount of room for creativity here.  Of course, using=0A=
revisions is useful, but the existing output contains `+` for forced=0A=
updates, which is not valid in a revision, so there is clearly space=0A=
for novelty.=0A=
=0A=
We may also want to consider what happens when both --force and this=0A=
new option are used at the same time.  When testing, the message was=0A=
always "up-to-date", but I realize now that a server might report it=0A=
as a forced update - it would be odd, but would it be impossible?  I=0A=
don't know enough about the push certificate records discussion from=0A=
the cover page to say that we wouldn't force an update on a noop.=0A=
=0A=
Regards,=0A=
Chris.=
