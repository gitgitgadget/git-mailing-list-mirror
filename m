Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2112.outbound.protection.outlook.com [40.107.93.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEDC171BB
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 06:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710485253; cv=fail; b=fkDf52FKFiNwbEDEmTW1v8BxN9OvR964SrgF4biSqxqtg6DzxP++pDyoB4i90L3QhRIi1jMm/AopSh4PAW0zn+FkofLWp7yQHqcu0phYx9JEIX0A8UIvucNn+DWE5oo18kkuE/FWjo2FEq1Sy5TM0gIhoSeBYEwsmJskLzrrod4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710485253; c=relaxed/simple;
	bh=//FiWTo1DK58+A++vnXr0OpLSH9zl+SeU+Zl+xcxoJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kBf/nI6fa8OrUa4qKH0q2b53/xE+uuPVy8OKIbP+xD0NuRRCOtEiqjIDGE99JOW/zHBCHwynVIrULzJVnmEeE+pMBN50rXn2jSrCWE4yUqUb1Hp2bfcynVrL/BPYWKYg6Uj09GqlOEAzOxTxwnixaEUzF2sykfI0Y3EMYGVQEJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com; spf=pass smtp.mailfrom=webpros.com; dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b=W4wJYhA1; arc=fail smtp.client-ip=40.107.93.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webpros.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b="W4wJYhA1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lm5eU2FFfNjUjiTOWfMC+a5/l7Ssx9D3S6fETOHJOW99S2yKi7LUUguTdzMJIZ6AoXPOhZo5ejvrqDdlK6QyqmunAApFPYl43ni4L8p3LnEF7KBTyiMje053QN0kOiBjwpAD0bpRggczZZ/lLX1PAmx4JcwXscaUdOfGX2yWJZqPGHbvDTMrhMqPjlqznQfiYo8MSA/WJhFrHr1/V0q4z/NQkyuCWdSNz7fJixAI8qY2jvMsq15/KBkoA5KI12EvCbNk2O9VZSfTGVmM9lVfDcCS4AKZ7qXGbd+SYaZ78i5EDo+BWRv1r8FZGmsoaKNHaizEva+4psSsMPU7QDejiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHGDl7v5XFNHO2JrYmymPePh3RZjrvlLjWg0rhgqp/Y=;
 b=ZKIt7iLAtKDq3+Ka/ma58fMJ0E/kUL05bpZGquOrlOQHfZ3OT4Kr49RgTTzTQQdFTqyJ1gBL3hmgDksSpcNBoQUcCZ7NufYA+eYvM4/ROUADOqVcSYQYaW06FXvskfd8D609VCuVzhkSqvpP8MjHXttOdARzJLUWm8I+6WsYTFbAAIAM1WJnH0iuHfj4lLzB0udpaC3pEx0wPKDgJkHG6EIe1lHJiGoKjVGvB0eSyj+lUIGj1uIm0AtLTdryUh+BbU+E0sVWtshqPckaeYwhgsY7xnTP2ypVaN5jhJRGzcbWKmCFbFAOWn8jMmaU8+VWTjXJ/5WNRgZznj1jPefGHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=webpros.com; dmarc=pass action=none header.from=webpros.com;
 dkim=pass header.d=webpros.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=webpros.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHGDl7v5XFNHO2JrYmymPePh3RZjrvlLjWg0rhgqp/Y=;
 b=W4wJYhA1dJu8q6e2Iv0IeTl2z6gQzX2Hik5oVlY7ZmdKP05+hE33xsQwOCyOgHw9OxZwTmv/CxhXXiKVOKsX7T5MJ207xWOD5rLCpOMgkhCs2+SOnCXMQq//ME43bb14d4+BJBW1y+9CXQvYGmtR4cyMLdGuqeCH8ms8qQ/aGPzYp6Cm+cS9hZcwjhoqsMrGMiVlc7KtnvkBQ1xO9GsA6uUCcV6c6Nim/qAKEOugYziwi8F8Tohq8YOTFvVqnvNelQuGWHrk4xqD0BIyJE+vRmmtm654lw/jtxQBn/ry5Au9pXcv+4gfMEv2U6Xu8TzKDmiQI6c7n84iUV9iGSjvyg==
Received: from SA1PR14MB4691.namprd14.prod.outlook.com (2603:10b6:806:196::11)
 by DS7PR14MB6932.namprd14.prod.outlook.com (2603:10b6:8:eb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.22; Fri, 15 Mar 2024 06:47:29 +0000
Received: from SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00]) by SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00%6]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 06:47:28 +0000
From: Christopher Lindee <christopher.lindee@webpros.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] Add transport message for up-to-date references
Thread-Topic: [PATCH 2/2] Add transport message for up-to-date references
Thread-Index: AQHadMfJU4Kb2lPtQEKMVlla3PY73LE2XZh/gAH28i2AAAg2Ng==
Date: Fri, 15 Mar 2024 06:47:28 +0000
Message-ID:
 <SA1PR14MB469129D76D1C65832FC10EA58D282@SA1PR14MB4691.namprd14.prod.outlook.com>
References:
 <SA1PR14MB4691A8AC86E290A3539BE1398D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
 <xmqqttl94qxg.fsf@gitster.g>
 <SA1PR14MB46913A0B1CB3F3D39ADA6A5F8D282@SA1PR14MB4691.namprd14.prod.outlook.com>
In-Reply-To:
 <SA1PR14MB46913A0B1CB3F3D39ADA6A5F8D282@SA1PR14MB4691.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=webpros.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR14MB4691:EE_|DS7PR14MB6932:EE_
x-ms-office365-filtering-correlation-id: 616230de-c41c-4188-3e26-08dc44bbc842
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /ysmLFhOPB8fif4eZUBB8tLHtu+YOgjp/sKbU+WPMKSg3kJ8LOoLET0bcOIb/NbOoiWDhGUT8U1gMtwHKJX+kIkYAXOZ/w2WXlwMsq19cvIBBTmoXquH8D7LnB7BQ/sFLH+IoK1UUXpPjQ+FOzWm2dUuTnQIKuIz35acsDwGi2R8dl/1tC1QodZmsj3N1jxLGlXzhfXeleZ1v3Z1woWoIIbPm8Fv/IPZLMllR2WBtvfA3cYRAcUAIAywxA+pBw3ENs/71W9Ufxiax2vfXeT5YqRY6hed1T2yGjEJsBD45djRDJHyfMzyfSGwpHrrQeMOEulRN02BRSGN8nzocmPf5TvgIUZryN+7i9Trzb7lX3Mohwrtp9NajKPTrzeXsfddDfQgI07IzOmMs2Hc0NvCbRqvhehTx6IZgqw5TWZYd7B4opPEOKitIXqlySuC29LaOJtYKjVmjVVnHs4w+sflxdLfxFt6Blu+tNTRbHJLGXdMpA22CHRVA30a4N+og734hGTIWTM9ShN1+M8nHj+82i3SfL4rChJJoNUsf1DP9NP6u2CjwRb0BvBi86yoOofWXiIKo2jMyV7XrF9Gw3cTJKkXpmqCj8vqgYwVWEi+siOFbJWZqcizIw/LS4QxWf/renlmxV7aZQyVcj6IEZrpwBUKCbfJcs8N9EOx62abXBO01uAdzJeR4woMrcBnvpwJP9IBP1Y+EgxBrWYkiQ0ExheuXzLsTgIqyOPYJtIl2vA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR14MB4691.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KRc1NioM3ePj8Hdoia3qAEqeSe3nJIlmpKH2IyUTgh3d4ecegPY89xkpfc?=
 =?iso-8859-1?Q?yqOahA8gHBeCk7omhsGWdJEg8QVTlBsfWGNchpJ5RHwb0R+7fBa92UUN1z?=
 =?iso-8859-1?Q?GDAA8KHJfoieE1ej1dzRfMh9kUo8hsAhypX0zCAf86TE7U8kb6E/1sOlcg?=
 =?iso-8859-1?Q?1nxyQH7QYqUsVEsBo6oppFF71B6+je+Bw961hRBGJZFxuM8WZSqrFO+mJs?=
 =?iso-8859-1?Q?cXdDUtCrpKjbIVPf6UBXth4wfJuctFctqcGxT9IJ+hC64R6bXsR4y9RIv2?=
 =?iso-8859-1?Q?Jw7YhG7H3/+mr83Js7ORb0AQSAdte2sLSUm/Y64AV7Q9SYePzpFDlfyP35?=
 =?iso-8859-1?Q?pOO/OwPGCkd3LmYraXcfEyOvP72S+5FSU9KtKCivc4Vs0VbJq2WtnRHLjY?=
 =?iso-8859-1?Q?TMCCWy+oQMQV5npXpOETz6faFmvdcQVSpXajG5jb6js+nwvwbYwxX+VESj?=
 =?iso-8859-1?Q?PvybSoq9Bn8EY5CPlGAuD6W0UNsP/ESxFBoQlGgOt0MU1plE4ozVD3KVWl?=
 =?iso-8859-1?Q?CDlKK9MkPK2AO61ebQQuWMkNivCAxXbBu8kle8c2i0wxPuEMXVlhzQni4Z?=
 =?iso-8859-1?Q?NMjsof3mvepR1kHcCqVYNvt5Psb3BYTqzQdT48TJG5abU5LSOYo4UEoW9/?=
 =?iso-8859-1?Q?t6dR7jv6DlJU8r/K1ay9xok3sWh12KADNUMHfUt3v8xjj8EAbXljmmq++j?=
 =?iso-8859-1?Q?pgc8Xyzgk3TRS/nOI/wKvN4JxQFeb2bi7EUm6cfDC4mu8GrbIQxRnQBNaP?=
 =?iso-8859-1?Q?IaM7uK89jOHyAVrrd7iRiro0Rp1/E8BnBFLaGGYr1Gg6vahqlgyYFt1otE?=
 =?iso-8859-1?Q?m5xDzPfJhLNFxHEg93z/avwsrmM6ZnqKFJnKAIEs5RttzsEnF06azLgiJb?=
 =?iso-8859-1?Q?f+9cE2zOzOTMBe4usPBUuIir0RoAXGZ/9ZWyuAyAn8Mxky/859o0kXVNBj?=
 =?iso-8859-1?Q?9vO6MHa7Nv41728Ku8L3tLFg9EEBmOTgTOTuHjCZ6vacpHr+8H3p/xHNNN?=
 =?iso-8859-1?Q?3ByLGHJq2GAc21ryOZIiYeEINZyEir91JEt0roBiSt9lvwY/HwnUAHAl5T?=
 =?iso-8859-1?Q?rlXGniWBlzwoLUY1qEQJ6GJVMpaPpbh4ymmC7/CLqodG3Jmnvi8d/7+MzB?=
 =?iso-8859-1?Q?3rUg523HxmwwNNGm1olXuurk7woX49JMVxsEgEF0GQkzuC5rkh6cHXq1Gw?=
 =?iso-8859-1?Q?L1Qo5MZgSIwusyaCrtBayT8X6L3DTzrFfqvOAJOcol/LhXRiQf/VuSyesC?=
 =?iso-8859-1?Q?bVI0R7paUfqcVtqkNG0ofgQ0bK6aehpOzbLRk4Sgm4xCFCsifrdQ3aBLYi?=
 =?iso-8859-1?Q?g8qZgok0zgDsIZvVm42vVyLvaHLfupsdygvEreoNJDsdnY3LCP2S1u+Muf?=
 =?iso-8859-1?Q?DH3mtwzMoY3K91VPK2dKkKVXdiUPbOMpB3M5MeTXALC/kKW7M16NkgoNS+?=
 =?iso-8859-1?Q?VPP/7Pt6KWfDEbocE7/Go05vJDRXr6ICLAtLeS0h44mGK3gfFjSVQdvW/R?=
 =?iso-8859-1?Q?oRx+GXueU/7mst7Dzpfzk0GzqfEcPpLLiYyZ/EvcyfNi1MFOcouD9YQ+BF?=
 =?iso-8859-1?Q?NbmMLLLOaL7SNjuNE2A/58Sq0lzFK1LyD6vZxjlLGPfGAWlUxQZ09iSR2w?=
 =?iso-8859-1?Q?V8yuIbk6tAJIonyKL5cn1aasD3I6ny4L+2LxtmbSrbev9lxurR8iGdNg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 616230de-c41c-4188-3e26-08dc44bbc842
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 06:47:28.8532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8497356-a834-4060-86b6-d4b1d8059ee0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tb/3XrD6z0WtDbNEp6XjRalq/nvps+gaVhBvu7Jup1FBofSOVfPqQj3VfRs8RfaycsblavimKkotGwbhXkYWk2c+x2hH1k+Y9l6Qf5DHTRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR14MB6932

Christopher Lindee writes:=0A=
=0A=
> Junio C Hamano writes:=0A=
> =0A=
> > Christopher Lindee <christopher.lindee@webpros.com> writes:=0A=
> > =0A=
> > > Subject: Re: [PATCH 2/2] Add transport message for up-to-date referen=
ces=0A=
> > >=0A=
> > > If the `--send-up-to-date` option in the previous commit is used, the=
=0A=
> > > "Everything up-to-date!" message will never appear, even if all of th=
e=0A=
> > > refs are up to date.  Moreover, the output `deadbeef..deadbeef` appea=
rs=0A=
> > > suspicious, almost as if a collision occurred.  To clarify that the h=
ash=0A=
> > > is, in fact, identical & to allow grepping for the phrase "up-to-date=
",=0A=
> > > add a message to the output when the ref is transmitted, but no chang=
e=0A=
> > > occurred.=0A=
> > >=0A=
> > > Signed-off-by: Christopher Lindee <christopher.lindee@webpros.com>=0A=
> > > ---=0A=
> > >  transport.c | 2 ++=0A=
> > >  1 file changed, 2 insertions(+)=0A=
> > >=0A=
> > > diff --git a/transport.c b/transport.c=0A=
> > > index 84deadd2b6..89802452ea 100644=0A=
> > > --- a/transport.c=0A=
> > > +++ b/transport.c=0A=
> > > @@ -670,6 +670,8 @@ static void print_ok_ref_status(struct ref *ref,=
=0A=
> > >                       strbuf_addstr(&quickref, "..");=0A=
> > >                       type =3D ' ';=0A=
> > >                       msg =3D NULL;=0A=
> > > +                     if (oideq(old_oid, new_oid))=0A=
> > > +                             msg =3D "up-to-date";=0A=
> > >               }=0A=
> > >               strbuf_add_unique_abbrev(&quickref, new_oid,=0A=
> > >                                        DEFAULT_ABBREV);=0A=
> > =0A=
> > This code is in an if/else cascade of this shape:=0A=
> > =0A=
> >         if we are deleting=0A=
> >                 print [deleted]=0A=
> >         else if they did not have any=0A=
> >                 print [new]=0A=
> >         else {=0A=
> >                 if we forced=0A=
> >                 then=0A=
> >                         prepare to say forced=0A=
> >                 else=0A=
> >                         prepare to say an unforced update=0A=
> >                 say "updated" in a certain way=0A=
> >         }=0A=
> > =0A=
> > The above addition looks somewhat out of place.  I would understand=0A=
> > if the addition happened like so instead:=0A=
> > =0A=
> > diff --git i/transport.c w/transport.c=0A=
> > index df518ead70..bacef94b33 100644=0A=
> > --- i/transport.c=0A=
> > +++ w/transport.c=0A=
> > @@ -666,6 +666,8 @@ static void print_ok_ref_status(struct ref *ref,=0A=
> >                         strbuf_addstr(&quickref, "...");=0A=
> >                         type =3D '+';=0A=
> >                         msg =3D "forced update";=0A=
> > +               } else if (oideq(old_oid, new_oid)) {=0A=
> > +                       ... prepare to say "same but forced no-op" ...=
=0A=
> >                 } else {=0A=
> >                         strbuf_addstr(&quickref, "..");=0A=
> >                         type =3D ' ';=0A=
> > =0A=
> > =0A=
> > to make the new logic flow more like so:=0A=
> > =0A=
> >                 if we forced=0A=
> >                 then=0A=
> >                         prepare to say forced=0A=
> >                 else if we were forced to tell no-op push=0A=
> >                         prepare to say we did no-op=0A=
> >                 else=0A=
> >                         prepare to say an unforced update=0A=
> >                 say "updated" in a certain way=0A=
> =0A=
> The shoehorned `if` was to avoid duplicating the `strbuf_addstr` and=0A=
> `type` statements.  It sounds like code duplication is not a concern,=0A=
> so I can make that change.  However, with this new logic flow, maybe=0A=
> it would be better to have wholly unique values for the display, for=0A=
> example:=0A=
> =0A=
>    deadbeef...deadbeef  main -> main=0A=
>   -deadbeef..deadbeef   main -> main=0A=
>   =3Ddeadbeef..deadbeef   main -> main=0A=
>   =3Ddeadbeef             main -> main=0A=
>    deadbeef^!           main -> main=0A=
>   ^deadbeef deadbeef    main -> main=0A=
>    deadbeef=3D=3Ddeadbeef   main -> main=0A=
>    deadbeef..deadbeef   main =3D=3D main=0A=
> =0A=
> There's a fair amount of room for creativity here.  Of course, using=0A=
> revisions is useful, but the existing output contains `+` for forced=0A=
> updates, which is not valid in a revision, so there is clearly space=0A=
> for novelty.=0A=
=0A=
It seems I just needed to look one function below to find precedent:=0A=
=0A=
  static int print_one_push_report(struct ref *ref, const char *dest, int c=
ount,=0A=
                                   struct ref_push_report *report,=0A=
                                   int porcelain, int summary_width)=0A=
  {       =0A=
          ...=0A=
          case REF_STATUS_UPTODATE:=0A=
                  print_ref_status('=3D', "[up to date]", ref,=0A=
                                   ref->peer_ref, NULL,=0A=
                                   report, porcelain, summary_width);=0A=
                  break;=0A=
=0A=
Is this a precedent we should follow, or is print_one_push_report()=0A=
special in some way?=0A=
=0A=
Thanks,=0A=
Chris.=
