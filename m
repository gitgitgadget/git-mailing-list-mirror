Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2135.outbound.protection.outlook.com [40.107.243.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728A1DF59
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710457694; cv=fail; b=rRpZ4wXe+g/ntlnBM/VvmadjSqK4g+W67gxL7CDfGq8zwfdLH4aq2QDWTWFHazVjiWIMVCgIiSI7hCmVxMJCDsfIIN/yGfvC74N+h0GbYKVAFwwo3yNhZoX4R5PHSjglsNW9d1a53H7+wpd/AVT4GG5V+70AomRWx79qFrbC7lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710457694; c=relaxed/simple;
	bh=yxZ88X1g7nyENL/khqFUidoGb8CECiv3diM8f7ua+lQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=liJo22yTXWYy8or2gG1PuhRW6DHp0QbjoZA+4v/zjKLe+fFtwGOoEQv9fU3yVsPh8mupbB4H5bgJFY78DSD6mNuuaQEF+c167HE9FazXGIi5xFMwpY/Ipc7P+dpCRVBLm8bB/qmPJ7Vn00DO3nV5yBErlm80WM4YuCtf94v1kWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com; spf=pass smtp.mailfrom=webpros.com; dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b=EQ0dDa5A; arc=fail smtp.client-ip=40.107.243.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webpros.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b="EQ0dDa5A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H73y9fnxpxBqnozlPCkOV81aZTpENVSHl1n/G/9ETmdf1YNZQEm1xDIq9aALyjnPCxbsxX+2W3UFeUk2O/kKqt/ZlmrWJmeOeVUWHu1bxG3vMpsKwHPyzPLCBzXrabs7F80VEsksOfxp14/0dTBn6tsvGkPSBFefe4LGnF4kjHR55jIrECbyj/t5k/QSW1iUEgtBUm7VnG/egoQIn86wBx8bbmEoDBi6MmflOacCSm3kbSlaaPb/s0SgFbgk7lMP37B9nZcsh7x4UlmTK/md9gwxYLe4EzR5RlLgONEtqAIiiPZsyAEEzru/NS+jGvrr8VjYW4S8I8TMhWFZViz8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYQ9Xi22AwIKf/6VLVPmFP958jOthE+2ornm0bwSKzU=;
 b=dGMtTHdPwvem0K0GozsC4ZIrnD78IhyldREw557QTBBvju6S9YhICl1uTAD1w+DEOGBggfUiv3PvEZl4IAZzco4gyWbAEau35XUmCMaqoc4CGyP56xMxgox/EQVJ1JI5dhvITO+PJc5FOR7IpTjuCK25KokwleBfH1It4S9SZTf/PZNRsFERAUCuP5BHN5gS+ZlrDdlLWods81BRG+xMfWqIETT992L96PDpGokqahuEvSHEr4Q8rd1wZzPA/QfD8yPfEv0bfIJhyaeHEYCVVSugYXsXQ/XuceL1BLb3CYZhX1pCu0QFJe+N30B59EfMEekkuU5opiVt0vxSU/+vPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=webpros.com; dmarc=pass action=none header.from=webpros.com;
 dkim=pass header.d=webpros.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=webpros.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYQ9Xi22AwIKf/6VLVPmFP958jOthE+2ornm0bwSKzU=;
 b=EQ0dDa5AA5DZ3lwpd6G0N4KmBvbTs5kekTI7/9fUfrdc3TNAQ4kJ4ml7ZfkJF3IwTxfGjedXr/f6hl52fhZPMFxqOyBMDZHh7Bzz4vdDYtC/NTzEfIvuwJa8tSg6eGKe01ga3nu3DQJkAHOvy9+1KvxUi8WiFgTCwGUASwZzlWphNwOp3MqeuYM0HMWfxjLhc5qLjp3t9hSs6X1PJRGhip5ZyaTMQaKYruu2v7hThLY6e3KrcZVAC+3dMeYcQuiO7XGNtoujzdr+n+VWIAZax+P2g30EJnwV4IwIUOXS+EoSoBmgbQnN3Vek1OEFiQgqc0b5QQRqQiwYiIXrZd906Q==
Received: from SA1PR14MB4691.namprd14.prod.outlook.com (2603:10b6:806:196::11)
 by PH8PR14MB6040.namprd14.prod.outlook.com (2603:10b6:510:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 23:08:08 +0000
Received: from SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00]) by SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 23:08:08 +0000
From: Christopher Lindee <christopher.lindee@webpros.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Thread-Topic: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Thread-Index: AQHadLHezsdN01rhbUOhmHwkmqTtTbE2SreNgAFYd0g=
Date: Thu, 14 Mar 2024 23:08:08 +0000
Message-ID:
 <SA1PR14MB46916648249AFA5D723369188D292@SA1PR14MB4691.namprd14.prod.outlook.com>
References:
 <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
 <xmqqa5n168nh.fsf@gitster.g>
In-Reply-To: <xmqqa5n168nh.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=webpros.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR14MB4691:EE_|PH8PR14MB6040:EE_
x-ms-office365-filtering-correlation-id: 87398f86-0e9f-4865-fd20-08dc447b9d07
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4IiMZaQPiUH/LJCfHpwzpcO24Kz8SZIbyf6eTaOtekEeb1IKVeg6xoZCjIPFapxbnE8HeDKxIfHfF4fhNWZ7JzkzgmXwby4JWojMF1BynuP7WD5Q3ILWWC6Ny/cvb0rB2t8IDxtYxUNtu0sdY8gXxf1fl7ccRw/PZfeq4nEf3YwhS/IQ6cyIbhmZ9W6j/gV7JRuYkk/aEDN2KQnxAoRM/gOGYb6n9eHgdkgjr11I9eFvCF0242q24eBKjP/UJXrJozUuNjXQrscvG9QLaQvLjDdsBct/FtuRuzL/M9udqetjmUJYeJSnMaFUZPrpED7nZ/LDU0Q1Y0n1d3FjjTuv4i6gF6sJgwMpkpu2YJprUKB3TSLtlTVDo9wIExuLvBE31TSCCTxvpOCUVPbJNuFumoFCwblakI4o9QqkV2ApI0E6Sn1gy4P1GPwPI5v/h4gyOseRSiYh0bTdAGxd//Shrx8da/JES87VJpjvsU2yfIvAPUxUULvsnocU7V1mgDtvtRpCNB4ZbVRmTUKvzk13J1JHutK2cYAzV7CNSGTMSMcPEU3P/1iQhevZwQITCxMLkrPx+5nWrewmaEadFbch9fHTAzWS4Pn5ZLftP8y27Oyr+tFFw0QeOZEgi6l08zpLzFhH2oMOXfym2hmYMth5HZn5F67QQr+g0LV8cY9wppc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR14MB4691.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KgMa+9fs1/ugP0cK84xgj+cgGySkv7eSjl+dXRxc0/Zgh40Cwop4eTfET+?=
 =?iso-8859-1?Q?QJKOWBQlN2FbEZoFjvfUL/v0u+yrNWHmuWRtZ++7R/S6vm98TLtIpaPAQb?=
 =?iso-8859-1?Q?NKZG5mREN2QC8jKOQEfBPOX1ZVmyeExYOaw9CNcMxMw7bt1rMexDfRZf5j?=
 =?iso-8859-1?Q?VDXVzD5CrtaEE2RUH72KFtrWbErhtyiAWq1mJVX9Tr5UyJjjz5CIrPLty5?=
 =?iso-8859-1?Q?Iq3d+CuhjbCxD39H9HJWHlAqLRzgNkYCeSeIzuBfcAm3/sLLU0EOBOAjjG?=
 =?iso-8859-1?Q?MQ41i9DEqC8qKXcLT1jrrd4fPiilEMWC1IQxIVT2CjmN1qGl73A7yEPsDT?=
 =?iso-8859-1?Q?xhIh7fL2tKzdaG7UuK3rrvUdOvU0N0qQoxKjLDbC+l+HR4TDdnz/Kul6mY?=
 =?iso-8859-1?Q?p8ZEB9DUO5CtTl4f4EQuHVMV0dgwGxfL7DAHdOa56Bac0fjtdvFlOYeYzK?=
 =?iso-8859-1?Q?6/QTHkdHvWujatBSpR+OR10ARI5FJriSe3+TZK/bKUIvzYXGwEqo4KkFBz?=
 =?iso-8859-1?Q?UlB4EOFb9EsvnoyFP+1JvI5zX9RoAjAUShuBuar3ePprcXmmKOisCnFq17?=
 =?iso-8859-1?Q?L3mQswFuOOgyg8mXZilJwZpzc4iJtmbPkSpT/V3UH3Yd/x51wIHR5gVFgX?=
 =?iso-8859-1?Q?8an9U73hhZZov0RYphjUr5teMxZwZPifY8Ew+gaWqYQ1wukc5U08h6YwwL?=
 =?iso-8859-1?Q?nFMq/sa8/LDCcJTXS/euihS6Ww8YWBCa334hif4k5Vxm86E1hfh1ncZizY?=
 =?iso-8859-1?Q?seJaZHItAK2eRXrolD1wezb7kfLOLzYuMgCoZ5ZWVi9C1VFBjcyypphvdB?=
 =?iso-8859-1?Q?AAHEiifiJU8/E14uh7RZqWQOZNrMDYXxNZEnY9xh9Z1ijKZX40qHreec5+?=
 =?iso-8859-1?Q?iMNFUt3MCKeFNNOCpm7cdh2BoUenLU5+IBgIGtWP4DEwsovsziqVN2ix+Q?=
 =?iso-8859-1?Q?OOfyoT//ibq4C9dOVlYcsRJocHdOgdvOU47fyEvxjBuuF4x5pjKb64cukG?=
 =?iso-8859-1?Q?YFh95Hjstuvgkqqh3iz4UdggzMoPGDJzp4HwO6IFIydY9ryqEvaIiRi5zA?=
 =?iso-8859-1?Q?EYjtOQax9FL/bEPFzPyJHqr2unF3VdObSzAXLaXMAwaCHF7iqNmCB3k2rP?=
 =?iso-8859-1?Q?Pqhhtyyr7i3POcU64WuXbvazO0sdr2fj+J8OPv4pzdkE0JvjNKTt7um0Kj?=
 =?iso-8859-1?Q?TzGorGK/RH8K0tei4BRahMGPafVYgWohD5E0cZ355cuJyGdMmpk1wU6SNN?=
 =?iso-8859-1?Q?VVzgTtWP5k7LMik8qKEk/gkROxb1bHMM1ztoGj7n/lz42EAsA3S3rDqu+M?=
 =?iso-8859-1?Q?casszLEbvwzmv/FPP/pwCLdloMegKktYJ8+/wyuKZ4lomYDvvue4j3IJo5?=
 =?iso-8859-1?Q?zqsdx5EY6FOhJ1SAJZpxdBGHZkOdQbWtOp7I+gxe1KsJD/4Fuhc6mEJLqM?=
 =?iso-8859-1?Q?KJd1Dxl8UDQOnFJdulqvSTjYXtJgNow3CROK/8bmOPokcoTgzGWdWsZgpu?=
 =?iso-8859-1?Q?GgXWtGBjTaDC82cP3qxXGVEUr05zoy+1vtpQZCbpfsqLHsjNvQbGG2cc0T?=
 =?iso-8859-1?Q?XtcUXHKP3meEs294MmKN4tI4V/NCOh0A5JYBYq9gHO+8jEhv2KX+ebZB+Q?=
 =?iso-8859-1?Q?CQlCZQvd2sg3/tYMuiAKciBbPtrVuWDzf1/V6ToggQytl6M5sXYkkA/w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 87398f86-0e9f-4865-fd20-08dc447b9d07
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 23:08:08.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8497356-a834-4060-86b6-d4b1d8059ee0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVKPv8sJpDahT9vafZtkAHM2v38sQOewlmaroYiJcifYyQaHMhVTOX/+Cm2+YAv9FUYbiIk6PuhoNbswTsNtm60EcJqBcMcO/1FzMD6Su3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR14MB6040

Junio C Hamano <gitster@pobox.com> writes:=0A=
=0A=
> Christopher Lindee <christopher.lindee@webpros.com> writes:=0A=
> =0A=
> > Some Git servers can take actions on a branch using push options; to do=
 this,=0A=
> > the branch ref must be passed along with the push options.  However, if=
 the=0A=
> > branch is up-to-date, then Git submits push options without any refs, s=
o the=0A=
> > server is not given a branch to act upon and the push options become no=
-ops.=0A=
> =0A=
> Yeah, the send-pack/receive-pack were written in the simpler days=0A=
> back when "pushing the same object again to the ref was an absolute=0A=
> no-op", and push options that breaks the expectation did not exist.=0A=
> =0A=
> It makes sense to allow a (seemingly no-op) push to go through with=0A=
> an option.=0A=
> =0A=
> And even without custom push option, recording this seemingly no-op=0A=
> push as a ref "update" does make sense--push certificate records=0A=
> what object the pusher wanted each target ref to have, and omitting=0A=
> a ref from the record only because the ref was already pointing at=0A=
> the desired object is losing information.=0A=
=0A=
Hmm... does this mean that push certificate records should imply this new=
=0A=
option?=0A=
=0A=
> So I doubly agree with the reasoning beind this change.=0A=
> =0A=
> > This changeset proposes to address this issue by adding an option to `p=
ush` and=0A=
> > `send-pack` that, when specified, will send refs where the old-oid and =
new-oid=0A=
> =0A=
> "where" -> "even if"=0A=
=0A=
Excellent clarification!=0A=
=0A=
> > are identical - instead of silently skipping these refs.  The first com=
mit=0A=
> > introduces the `--send-up-to-date` option to toggle this behavior, whil=
e the=0A=
> > second commit updates the commands to output an `(up-to-date)` notice f=
or each=0A=
> > branch with an identical old-oid and new-oid.=0A=
> >=0A=
> > Notably, the `--force` option will not send a ref when the remote is up=
-to-date.=0A=
> =0A=
> And it makes sense *not* to update `--force` to do the no-op push,=0A=
> becaues you may not want to (accidentally) force push a ref that=0A=
> does not fast-forward.  As I already said, tying this with use of=0A=
> the "-o" option is not sufficient.  So I agree we may want a new=0A=
> option to trigger this behaviour.=0A=
> =0A=
> A radical counter-proposal for the design is to update the client=0A=
> side to do this unconditionally, without needing any new option.=0A=
> For an already up-to-date ref, its only contribution to the cost of=0A=
> "git push" is from its "Finally, tell the other end!" instruction,=0A=
> which is in the order of 100 bytes per ref, and it should not add to=0A=
> the pack generation cost at all [*].=0A=
=0A=
About 100 bytes per ref can grow when using a ref glob; for example,=0A=
`git push <remote> refs/tags/*:refs/tags/*` would push up ~1200 refs=0A=
to the Git repository, or about 120 KiB across ~80 Ethernet frames.=0A=
That's not much compared to the amount of data fetched during a push,=0A=
but it seems like a lot of unnecessary data in most instances and it=0A=
would add a tiny bit of latency (more on that in a second).=0A=
=0A=
>     Side note: But we have to be careful---if the receiving end is=0A=
>     totally up-to-date and there is absolutely no ref, I think the=0A=
>     current code will not even call pack_objects(), and you'd=0A=
>     probably want a similar optimization to avoid the cost to spawn=0A=
>     pack_objects().=0A=
=0A=
Good point.  This got me thinking about other potential side-effects.=0A=
=0A=
What would happen if two actors push to the repository at the same=0A=
time with a lot of no-op branch changes?  For example,=0A=
=0A=
Actors 1 & 2 (either actor could be first):=0A=
push< aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa refs/heads/main\0report-stat=
us ...=0A=
push< bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb refs/heads/branch=0A=
push< ffffffffffffffffffffffffffffffffffffffff .have=0A=
push< ...=0A=
push< 0000 =0A=
=0A=
Actor 1:=0A=
push> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa 5555555555555555555555555555=
555555555555 refs/heads/main\0 report-status-v2 ...=0A=
push> bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb bbbbbbbbbbbbbbbbbbbbbbbbbbbb=
bbbbbbbbbbbb refs/heads/branch=0A=
push> 0000=0A=
=0A=
Actor 2:=0A=
push> aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa aaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaa refs/heads/main\0 report-status-v2 ...=0A=
push> bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb 4444444444444444444444444444=
444444444444 refs/heads/branch=0A=
push> 0000=0A=
=0A=
If repository locking makes `push<` and `push>` a combined atomic operation=
,=0A=
then this could never happen.  Otherwise, I suspect Actor 2 would receive a=
n=0A=
error (or at least a warning) since refs/heads/main is now 555... instead o=
f=0A=
aaa....  Moreover, if an error and `--atomic` is specified, then everything=
=0A=
fails to update.=0A=
=0A=
And, as mentioned before, with a large number of refs there will be=0A=
additional latency, which increases the chance of collisions.=0A=
=0A=
> I do not know if "send-up-to-date" is a great name for the option,=0A=
> though.=0A=
=0A=
Agreed; names are difficult.=0A=
=0A=
I considered --always-send-refs, but thought it a bit vague since it=0A=
implies refs are sometimes not sent, but requires you to look at the=0A=
documentation to understand under what conditions refs would not be=0A=
sent.  I also feared there might be other conditions where refs are=0A=
not sent that I was unaware of.=0A=
=0A=
I think something with "noop" makes sense; thing is, which do we use?=0A=
1) --force-nop=0A=
2) --force-noop=0A=
3) --force-no-op=0A=
=0A=
I've seen all 3 ways of writing "no operation".  Everyone has their=0A=
preference (e.g. I did 1; Junio suggested 3 and later used 2) and if=0A=
the one we choose doesn't match up to a user's, typos seem inevitable.=0A=
Though I suppose we already have this issue with color/colour.=0A=
=0A=
I also want to consider the audience.  To me, "no-op" feels low-level.=0A=
Meanwhile, "send-up-to-date" uses the same nomenclature as the UI=0A=
displays and feels more porcelain.  Frankly, this options seems more=0A=
low-level to me, since users probably want to consider the possible=0A=
side-effects on server-side before using it.  However, I could see=0A=
GitLab telling average users to use the option on their Push Options=0A=
(https://docs.gitlab.com/ee/user/project/push_options.html) docs.=0A=
I'm curious what others think.=0A=
=0A=
> >=0A=
> > Chris Lindee (2):=0A=
> >   Teach send-pack & push to --send-up-to-date refs=0A=
> >   Add transport message for up-to-date references=0A=
> >=0A=
> >  Documentation/git-push.txt      | 8 +++++++-=0A=
> >  Documentation/git-send-pack.txt | 7 +++++++=0A=
> >  builtin/push.c                  | 1 +=0A=
> >  builtin/send-pack.c             | 4 ++++=0A=
> >  send-pack.c                     | 2 +-=0A=
> >  send-pack.h                     | 3 ++-=0A=
> >  transport-helper.c              | 7 ++++++-=0A=
> >  transport.c                     | 3 +++=0A=
> >  transport.h                     | 1 +=0A=
> >  9 files changed, 32 insertions(+), 4 deletions(-)=0A=
> >=0A=
> >=0A=
> > base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0=
