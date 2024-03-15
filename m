Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2135.outbound.protection.outlook.com [40.107.92.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4736FD7
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710472197; cv=fail; b=TUBurJ8SZBc2vtGE1v2wSu4emrviqxs+yy/xBrHuTYQrSO26Id8TxLrmX32HwMrOg5gVUJxgOsFR4/x7yjXYKZtAhztSsq47M5VemGo2xtFXFAEmW8mBbSz+r9eLAbyFKit4ojCgz//4J5diOcU7Gv4K/p3Vls4RjQJeIfh3e2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710472197; c=relaxed/simple;
	bh=UhDcOaKlpn3HgyWjxaP8EwRgckNRdaV4opP68A4g/EQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFPVqKlLc1VL44tD743eW9duW0Dob5BKGZl6KylYuHVqkj88+AcxEcMIAuKWDwoWdt/SGY4U2cz9TG+7zIHUogxNWdHK6rT5OqkhmMSaBp9yAO7VF1qATzwvjm87TjEVbem5t6Z7RXcihzr+8048ADYXWmlMx6m7G8ild+GHUy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com; spf=pass smtp.mailfrom=webpros.com; dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b=UEdxjKdw; arc=fail smtp.client-ip=40.107.92.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webpros.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b="UEdxjKdw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUQ4VUwgAI+KrTRFvA3A1hAl0yXp7uh4NKIhmEWJWi0W8EPsyIoWf/p9H0x2CNLmyY0MJRICMUOD9hIYj1dojH3yNgSUaqnZewFD/hut6MqiPQwXH7MxWm7XbMG4HA+Yo0bHRGPDmOKfGms8yh8wLSQ7ot0pE4ocWBgDmrPZMLetQfTOqz5g8JwY255YjJRKBhKKQPuoX5J9p9S3lj4L9vxWhvyAtdl22ukBYPAmbyJPZLyEkrqL3moV1vTwaKQcaXNOO6SFhy/tCVRwB/1kMMgSJ0Ujb7Nzie63T1/z0wOz6LOjlA5UAAtNXLH9+VxI3m+GjFi3XdxjVRYZs28kKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV/9eJVcN7KozD1ZBP7G973DNQ336njdXHmUfWtB4HY=;
 b=lFI4rMTeKYXflpu+WsLYBInUEXjbhFBLqTXuCZvJKaUctGGFY8NWPS7SLRa2hGNz/qcR3T9QWbudD5mxEfmOLKY/tBAq/3rpUum0qudFnhOsyRGSNBEmNltuDyu+4SZgDtgpiyE/7CqDMSq5BefbnLZLM4AblEUaiHgQrYhnuW9cqKtFx2+SrV37emA7EcZRicpJVOlGDtnGe9A7L6VZnhac4g6a2c/zrM/fxWxyyYHoY9hSywDQJySU4r7xv7ZC9nF8iJxB01L0GIhnTuCSixyvhwIiGf/1+vzhio0j3fZNrUU2SKMhbZM9xWFGCe2PogBmBZlSMpXiamAsfNAkrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=webpros.com; dmarc=pass action=none header.from=webpros.com;
 dkim=pass header.d=webpros.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=webpros.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV/9eJVcN7KozD1ZBP7G973DNQ336njdXHmUfWtB4HY=;
 b=UEdxjKdwsNAln95rr4IkZ+t5igijgY2mAIWmC5KWNrzFmf/i7j1JrDiXv3yioepk5AwEz0Ch/GvT8+HsXFQI52pLdt3TlsZnuHhLN+so8Cm9XjCaQsPzQutx13zFsTLbeUJsDjIlINISFr8JB6nL4CjTZ/yTa11VY9g4i6PNVcQ8JUkpLM8ODhRrGD3CQ2KT73eDY0LWwXjXYGRUfhVYnIMHajFZKGIfHZFxhPKYeyVi47q1L8snxWtfg1PKqqMNYKO4jqdhWzITZslgVRpVxNiIwDLmhuBsWqnRkEcDCY8Rfi1y/HM8vOX1VKVwG6SyJ5epH3I+3xUV4t1G0R5IbA==
Received: from SA1PR14MB4691.namprd14.prod.outlook.com (2603:10b6:806:196::11)
 by SA1PR14MB5981.namprd14.prod.outlook.com (2603:10b6:806:2b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 03:09:53 +0000
Received: from SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00]) by SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00%6]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 03:09:53 +0000
From: Christopher Lindee <christopher.lindee@webpros.com>
To: =?iso-8859-1?Q?Martin_=C5gren?= <martin.agren@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] Add transport message for up-to-date references
Thread-Topic: [PATCH 2/2] Add transport message for up-to-date references
Thread-Index: AQHadMfJU4Kb2lPtQEKMVlla3PY73LE3yAIAgABTpu4=
Date: Fri, 15 Mar 2024 03:09:53 +0000
Message-ID:
 <SA1PR14MB469168B6AAB246344190D9038D282@SA1PR14MB4691.namprd14.prod.outlook.com>
References:
 <SA1PR14MB4691A8AC86E290A3539BE1398D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
 <CAN0heSp2A-sx_WA__90WGhP1yD3EBBtR7_N7s5ZPWqe559xpKA@mail.gmail.com>
In-Reply-To:
 <CAN0heSp2A-sx_WA__90WGhP1yD3EBBtR7_N7s5ZPWqe559xpKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=webpros.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR14MB4691:EE_|SA1PR14MB5981:EE_
x-ms-office365-filtering-correlation-id: bd1a5cd9-a959-4a03-e1b4-08dc449d626c
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1bSXmZr8VquZiZfPj+Azm/OoBdvFqr0TkP4jdWioi5vh9nGyv5Jqmtf69GGnb1nXSXao5tkkgpuJb1op7kja8//cqVDV3+IViRS0hg6Hw6pEjXa/QavHuvekJ+sf2NwmeB9bC1IOuXbuk9yvmzLoCt+kzQxHQvbxIspj/jt4rdJNMb2JUTefZsx4qLc+VYWopNb+n0+FmQRwQTSgj5X2uDTQ0D5YjQ9ERdMKE/3gBf8q8sLG7xXICJ+srhd1YtoyPGBZELHBU6SGfKQtcdYyBioFGCq1QFV/1lkfOl1LqLCllIdrEBm4bcQuhyX3ZzIXA1d3N9O0AjKRHHTCRJy4YnXUS3QI3Uv7kokpEI7pFeR99HDx7Qub+O7U1k8t6EXas60AIfjLJ3NKVVHtU2UejmwewDNwHNUiNkSrzw4J6xfjQB3QCsjkjtEWk/et66yYF6kSZOxB1zJVJx042gCzlSOwmwG0BY3rtg9D2hhLiPHt5bHqxLhVoWhlubdIdrOMto0StAdHu/VTttLRS87s7iR1x3c6MCfsBFftYqBB+0cNUp1udzXAhT6HW21vMzByUE4ouIv0B7EirKI/dCuybzpJ/riYlY4f6Xqve1eJvLbgVG8l1FPHwvSDybL1H0/khFzJ7ceAYX+YenQzPF88g5MAKbazFjfPzuaPSWPJXY0osAOwLFSNDLYM2zTjqPg0VzpEODZ8r4wg3JS2vr9yuM+QXjHb3f8T0OjbcznV7fE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR14MB4691.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HQsZiHWGhmvgHGoqlxFDRRvm3zQGl+DTKtEkNq3NAMBav85YaQgjXdoMcG?=
 =?iso-8859-1?Q?zcS9EgPDU2Ww4DqdJeitBU1n5fQGbdUwkjKSW1jkSqGMVBY5FL2ateT7bn?=
 =?iso-8859-1?Q?LsWk5nMSJ/KQ2bLoaThJkHZVSXTc86m7YPAr5NMl0Bi1GlGyH7uu9SR04a?=
 =?iso-8859-1?Q?Fr4DLBs7DVv3EWOq7hCnGMS9fF6HNfdsdBYtcgP5cDKA7ZdRhaCZnHyBO+?=
 =?iso-8859-1?Q?741FGZvt6gSuJSFMqdPl33ednemEMhjp6W528Djdb17gudifd3gu4WzeIz?=
 =?iso-8859-1?Q?ZU+vnuOr/B/5E6DI3sIrhX7Iraywr1moctxTWkH5hSrV8xQfAloF4uWP7X?=
 =?iso-8859-1?Q?bpB1FxRZBwR6ahadEc1+A0EFEKDxjtXrG4/6YLjq4SIUM6B0S5cG9I70wz?=
 =?iso-8859-1?Q?ADxDpcmvKOOUkQmTwsSW8G9bXje2rt+HhRGphqU9hlGD8SSZSzMe7eiTJV?=
 =?iso-8859-1?Q?8BY95sSXPmVrwxpI+ch8QuEifGP+/vkSLwU+DUEMmeIsJ74+lVf+zDStjL?=
 =?iso-8859-1?Q?kP7bBthPM2Azn2+yYiUCujF0K/vM4QowSslmvc/gkZDMnfGUZE4V6XHhTI?=
 =?iso-8859-1?Q?eShHBIW8QYK+iQPlKtc6zJnkt3oESRUjDSfm4IchCYZlSXCjQBfzjBIyO/?=
 =?iso-8859-1?Q?AO+wbYeTx66LnYUT2XiT/1IFqVWXx3mKi8oDmKfs9qci8RJ2S5IbA1+XrZ?=
 =?iso-8859-1?Q?Cuu1UUm1yCiWkzurfuh/S8UIZVT51J0W5ZV/8zwATy8DHX0ElrQbkqA4pQ?=
 =?iso-8859-1?Q?M77EHEbA6xn9sizemLjxNvRQS3kSrqIN6qmItMYMlap00iOTxNMZbPsHlI?=
 =?iso-8859-1?Q?n+jAQR359jpdxkAJmta2ROjr8XOtPQBHGRbOV5xCV+ZDtsF25axUH4KdVU?=
 =?iso-8859-1?Q?VbrdhK40GyKuKZ631m8JM6GT/ENbETx+MfK9ncEk+g2ZwF36tePWM40AjD?=
 =?iso-8859-1?Q?vBcn3ergPyLS2odFi+qkfCu1HF4LGRsUCQnaWYX1su1/pkTl3Ataj8SKGi?=
 =?iso-8859-1?Q?GcpXRbWJ4ue6j1N8nGddk9SktmOb03CM7nvC1SfFOnwq1qC+Sv8z2tyDdM?=
 =?iso-8859-1?Q?fhBg3aKwdvmy6VlcVh60N4Kg6aR2c8T27jYgzS2Gf2ht9iYXgnUPiMAjCj?=
 =?iso-8859-1?Q?n7P8hNgzqIRVKV29Ot50rZLpjm1a2sl2TZx+qQA6uWMqbZq3koCU0peUe/?=
 =?iso-8859-1?Q?x3KFw7OHvXhhyk4hrftHmeTyfL2KIjCPvp8HW97aITtOCUPgS1iyr0ft6l?=
 =?iso-8859-1?Q?h+VNrDHZ8ANyS7gU8hyTuzstcJ2XcLcrzjGqEDYJ8EzyRL8mknWUnSixUj?=
 =?iso-8859-1?Q?FjjlbiSljEZTnOyaicYyTU8i2ft57FrVohzeO+rHJB5D1eTEbG7bqDUPWv?=
 =?iso-8859-1?Q?Wgxjk/Zb7UWblMc233Xy/QlA8a+ilm+8tlxGdFO9FRxcY8C1xtNCrG1yg2?=
 =?iso-8859-1?Q?FRuOeS7jXR2FEgmvTMDoYIqPa2MrYqvDJcvebGDaO7K0fVDLnt2GletqzY?=
 =?iso-8859-1?Q?gsRJJ6UEhCpzZ9bRn6M8czEoWfVgdYDOpaWhlOiV2M2Wq47tSVWgLyj0fs?=
 =?iso-8859-1?Q?5h4cGpJAIsJltIIYLYq9bBSLQfHSB/ZmJXdTI024tmtAmyT7Fk4pGpc+Pt?=
 =?iso-8859-1?Q?89WBL6Vb6EQ0MwM86XfoyXhOEObSTsHIKDi/3H2eMpmOqL/PwGr5amkQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1a5cd9-a959-4a03-e1b4-08dc449d626c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 03:09:53.1374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8497356-a834-4060-86b6-d4b1d8059ee0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pX3Gq215G+NRYFwI3GCTP0tvo5qXj77EFpmHZ+V0EX5N4KlcTppQoCq5nURsQJA85cax6p9038Te3jue7yQHrqiiAz4C8d/g7l+WSaGm5zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR14MB5981

Martin =C5gren <martin.agren@gmail.com> writes:=0A=
> On Tue, 12 Mar 2024 at 22:55, Christopher Lindee=0A=
> <christopher.lindee@webpros.com> wrote:=0A=
> >=0A=
> > If the `--send-up-to-date` option in the previous commit is used, the=
=0A=
> > "Everything up-to-date!" message will never appear, even if all of the=
=0A=
> > refs are up to date.=A0 Moreover, the output `deadbeef..deadbeef` appea=
rs=0A=
> > suspicious, almost as if a collision occurred.=A0 To clarify that the h=
ash=0A=
> > is, in fact, identical & to allow grepping for the phrase "up-to-date",=
=0A=
> > add a message to the output when the ref is transmitted, but no change=
=0A=
> > occurred.=0A=
>=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if =
(oideq(old_oid, new_oid))=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 msg =3D "up-to-date";=0A=
>=0A=
> From a grammar point of view, I think this should be "up to date". (A=0A=
> branch can be up to date, in which case it is an up-to-date branch.)=0A=
=0A=
I wondered about that; I will fix.=0A=
=0A=
> There is quite some history exactly around this phrase, though, see,=0A=
> e.g., 80bdaba894 ("messages: mark some strings with "up-to-date" not to=
=0A=
> touch", 2024-01-12). If we really want "up-to-date" here, I think we=0A=
> should add a comment similar to 80bdaba894, although it does feel=0A=
> awkward to knowingly introduce a new instance. So maybe better, go for=0A=
> "up-to-date ref"?=0A=
>=0A=
> If we worry about how "Everything up-to-date" disappeared in the=0A=
> previous commit, maybe that commit should instead detect that all refs=0A=
> were such no-ops and emit that "Everything up-to-date"?=0A=
>=0A=
> (Part of me wonders what kind of existing scripts [1] would be helped by=
=0A=
> us sticking to the dashed form. If they go "grep '^Everything=0A=
> up-to-date$", they won't notice this new output. If they use a more=0A=
> relaxed "grep up-to-date", they might get confused, possibly much more=0A=
> often than they could already be by a branch called "up-to-date".)=0A=
=0A=
This raises a good point: if we default to the old behavior and only=0A=
send up-to-date refs when the new option is present (as is currently =0A=
the case with this patchset), then existing scripts will continue to=0A=
work.  Moreover, scripts using the new option will consistently have=0A=
"up to date", so they can change the grep to use that (since it will =0A=
never show "Everything up-to-date!").=0A=
=0A=
Thanks,=0A=
Chris.=
