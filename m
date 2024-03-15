Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2103.outbound.protection.outlook.com [40.107.92.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFC7171C4
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 08:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490737; cv=fail; b=FcDcM5wiyEKyPj4GDQxoWhT+kQ/oWq1TWHYFm6kMrnn17q5R10SCzKSWR/DrzsfA+aWM4l/bijKT5LjmbbZ04HlNToEt4jZ8LjMA+lKPYTC9GuUKi6TTeIX9TiynLt4LIFTJh7Ej6jEBh4srtE8kVxWv+eOEetZZ9R6xkwSJ09U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490737; c=relaxed/simple;
	bh=GecUDl0TSldWJeXMHj6k7I4gwTlzl6U+PGTKFtRxNdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sKdYpzpkhrVm2P4yTqt3ZgUhQmHAz1ZgDLcDOPI+llSqRnjnE6x78HKX140xj29kSbkzeUnKkkfnfXaExtwgcIkVHrwv4LcvloSMZo6Hr7mHhhIpbysiVDppiNB/xebj/bi0MH4DnSnG00jCaLpzWlkVWjS2tx9ITv3RPeXM4AU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com; spf=pass smtp.mailfrom=webpros.com; dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b=gITaj0s8; arc=fail smtp.client-ip=40.107.92.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webpros.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b="gITaj0s8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rcg5z5jKpoAeVw5Rh35uuS3oU0zz8JOLHiK/TpvRkS3ran6TLh4HvpBsU7guoIqNR0fy9YXhhv170p/BK7KNL/U0kiNrlNk94L29X8gIKlvoawvEpNkzdfyinv8wwLdg7vEBaDN1AoFaWT/kEoJu65gHqJuIMdkzKRZlDoeZRpWrIwk3dOD3NPJ5IPgGemDLcgLwlQghAqcJJdM/1r6kNVMl+6VfqIJiUqPbaUDC1mJylxFfqO4bbDW5I9JtI0rK1iKGjmKN+RYg1bu3g0o5Pls5m/dauIGyMJGAZu9U4bKnrV9NINpmNHlqkTM3d0GG+Ap21AiAFY4uIfkBvF0YJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5U4DY8tWQS2ac0M2YsPpoCRVvZy/pWHLX/mzlpykV8=;
 b=H/wSg4ufUb1UTTLoyp5XISxHps6ektMARIBPHNBx3tPGm+3QDU/DvvaCuUXCESKzgKwfUhOToDN1d6TyhaxnuQSNDtOMNY8FMNF1t5dAZPxZ+d2l9sltiPXguNUAf/Hx7ghX8XSplQ6ASCcn9hwA1svLIZ4SpmJhfd1cZMKcN1AAsiVmeYx+Lh3ZydMqTZmFEjYnJZffczHq+sj6MAu81NPoSes3haOfgGoqcoOZzZ4HPo3rZZWBHllTtRmSRX0jUBZIcignNAraiuIDcMCW4maYMPEKKvOeX6CRQ3+JNNaN+HcdCQVNACiMw5CvqBX3wKYnyqyuO1ZlOsdx6Z+wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=webpros.com; dmarc=pass action=none header.from=webpros.com;
 dkim=pass header.d=webpros.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=webpros.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5U4DY8tWQS2ac0M2YsPpoCRVvZy/pWHLX/mzlpykV8=;
 b=gITaj0s8HuCgMZYvWq63yXLltT7cyx2uw2Z4pnyABZAhHgNdO9qo3AVQ6ZJt+N32Hx67veBycXVRcJSVG2dyOTXbOkxOnoKqxJO/6VWgEGAGG/luRk3NuZ2OFzpvG/XJonpS6/T/x9sjarZ34f6aicYcgXEvckv3H+/FKhhffR6euboiwAX7Y0/+PNavUKbph4MV1jlTyFcsvqTPhkp3VE6v0Y5sHplcdlSr5YnRDfmIrrOkWe60rB81qcy2OwZnwpUmNHZa09qz1yG9OfJwzoPjAJKl7KwsiluG0FaXyX/kIuv5v2kfpv9/e6/mnjrJYRyDfe5tBaJiXADNYLlsQA==
Received: from SA1PR14MB4691.namprd14.prod.outlook.com (2603:10b6:806:196::11)
 by SA1PR14MB6579.namprd14.prod.outlook.com (2603:10b6:806:333::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.23; Fri, 15 Mar
 2024 08:18:52 +0000
Received: from SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00]) by SA1PR14MB4691.namprd14.prod.outlook.com
 ([fe80::acf2:4ab7:1c71:e00%6]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 08:18:52 +0000
From: Christopher Lindee <christopher.lindee@webpros.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] Teach send-pack & push to --send-up-to-date refs
Thread-Topic: [PATCH 1/2] Teach send-pack & push to --send-up-to-date refs
Thread-Index: AQHadMdLLrOfHThu5EeIsu1MpASt+bE2Vbg0gAIiEZI=
Date: Fri, 15 Mar 2024 08:18:52 +0000
Message-ID:
 <SA1PR14MB46916697B71E56C4AE9262358D282@SA1PR14MB4691.namprd14.prod.outlook.com>
References:
 <SA1PR14MB469144B8903909F65493323A8D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
 <xmqqzfv14s8d.fsf@gitster.g>
In-Reply-To: <xmqqzfv14s8d.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=webpros.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR14MB4691:EE_|SA1PR14MB6579:EE_
x-ms-office365-filtering-correlation-id: 59ea54b4-5b7c-487f-3688-08dc44c88ca6
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0CsRRVKC2zUo2IVUBp4XOdeP28m69PoggauQ0grRiLGVjMzThJxY0e4GDe+q3WyX37o/CgsbuDDm8aoEJCdvBlDPSAuAx9rAYY06Nfq3h1Xxn7bMNWLaRiUu28ZV0/xIYvmqDTYs8oeAm7uqc8EztfUhEpRhLaB5EjH5wNTzacKLyOhONxN5m0NLDceZt5MXAICwkY5oyr9gW2XW797snlHMIFJXLFiHA6U/2UZrCwg4iumeCFN5q3ScR6Ey2xJT6o2u+MUX0GbzqNH4BzkV1rFzz41oj6IHS80p6Row6M0OTbZk0Sp9LnA2gclaBcRyWIhhQ5E/9prIpj0LRVbOxOY+ErEhgrVjV6cwsmmAjahs/01i15nsyHAi40TXptVIvKVnM7pVXIkOCQWmfniWu8Jzkg8oBFDSCIajEC6Wz1Q8ofYr69xalvRfn31LbRsJySnk7n+qgHoO7X+imOBgTpBJAUPh33ktcBKpOXvoF/ROfKGIbt59gIGuSa1xoV5C40oNh0bQRYufBCmNp/WfprLrpTk+nyPQn0F5idAFdLZOCuKTgZWYgfWeitqsVdI1zfLzdOil7nnXc18x1jHMzA7WggoNs4sbRiNkNOxltGwbINLLig6emdHb9lC0s5IsuAMQ2KGk0BDJfh8xGSj2t5fLa0hmg+6JWtXSbQKTpoM+96pdB6h38Uw3tavPSJAM9jeS/C0RReiD4QekBvuVRWwyUi8RmkdFIRCv9A1pE+A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR14MB4691.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?CybPBmePtSio4mHGJfducXgdEcwFhgexEMourSQea0+IALGpeuJ4zFgG1v?=
 =?iso-8859-1?Q?RjB9U5i2/sGwe7NgIYZE/0jf7lkDP9ZHHuDTKtCTGqEyExB74eQ/lILMr2?=
 =?iso-8859-1?Q?EPk1JIzaI3M7LxeffNLaoa+fLad8SqxsS+Ai2O5hLeKNqdOZg9t6YeGURz?=
 =?iso-8859-1?Q?wu9uyyMwzkKUR39Of7CTEYEtQw5YWle1p2iA3ju9d1zl0hX96Vtk/aOKLb?=
 =?iso-8859-1?Q?bwmbV6kuVwNwkYXxy1ntlRCk3A0A6xiKxMk+f0ryCStIROmTsmSBe4bOjH?=
 =?iso-8859-1?Q?LsIT685D8whkWMW2UAuDdKLLsxaYkiTEvuYHmGl8paCis3HbjD3lIOgdVZ?=
 =?iso-8859-1?Q?+cJqQbUD+WqbXfPuVh0ZIf96b/81FnZGtM0sp6Szvh2FNVzoehvqvwT3at?=
 =?iso-8859-1?Q?enoo+S+WyN2meXxpMjtWhLGHdqqn6beH1hcPlilfkOnRRbD/jHQsEL8aEH?=
 =?iso-8859-1?Q?3W+9L4FzXPUnpjBmNANffVFTw9zFDkMJupD00SmiNKxEauWZy7ldw7LZjR?=
 =?iso-8859-1?Q?eFTnuslK9PwGkfucIJ3qJ797Y94x2q5fdwXfqKCbWh3SE73+RiThR7N7/X?=
 =?iso-8859-1?Q?fbPYr+MSuoWM/79vTP0ULcWvPwwAfOAwSMLtO0xgptF3Fi5wZ4BXeDtBWj?=
 =?iso-8859-1?Q?9VAnlNZ2oRRpEp3/msNSPiiuciocE/MsHBFOtoF1eyEE4NNZtnY3lUpaOw?=
 =?iso-8859-1?Q?cubAEjQr+nbrJpEfqWHmoskXkf9TvLIJd3vj3d3USNNTs8kE+s+hYED0JB?=
 =?iso-8859-1?Q?o3PlAYEuP5TFZdNg1gGH8kTxO3Sf03y9zlh/gBJUCYQk5S8LGzIBD6eeMN?=
 =?iso-8859-1?Q?bCJHEzUBzwsknqOGqKoHLGXz3R+rFEspsjY62R6GuwcIbHFYzIem4fnb0A?=
 =?iso-8859-1?Q?anfTQIx6QgQYpGRTjChA75TJ69+hf0rtMfMKmk4INyoZsfGYoud8xvQ9tY?=
 =?iso-8859-1?Q?qaEkHoN6aMGxeS9WACWcCxz3EL8aAaWXZFId2N09jEU6lEgB2pEIv+IYcl?=
 =?iso-8859-1?Q?9ctaDZAXLSwdXvqWdqWz5iRtPRQ5YwWwkaEvo5z+fiQX9yW3jaD3MStFwV?=
 =?iso-8859-1?Q?bVMbCOw44z5v17vYQqJO1ID2jadW5qUsOH1dD3SWOGAlfArwVBN4V1LG9g?=
 =?iso-8859-1?Q?lA6jk4UOPmNLiVvX3p8v8SuBEqVVOwK4sP4ul9wrVyJ7CrdT8TDlfXPWc7?=
 =?iso-8859-1?Q?wggV2fTveuMHc6KGPM4iDtVsy5bHyBWOhPNtT0aVYOUIRZweWvB8WKzzh7?=
 =?iso-8859-1?Q?QgHHZxddHW14k+WhqaRTFQaZzdU6M3U0M8I3hUMEUvK0dcCPyoWF/cYn+t?=
 =?iso-8859-1?Q?yoCzs69w/oj175CfW1yXILSreNgmk8MGP8wchcKNEInaTtRypsax10cTFh?=
 =?iso-8859-1?Q?MTcb0EQFJ7m/HHQLo3sAc64WvcbI7LW/u/NfX2tZ1Pnia8INZvaiaB10WM?=
 =?iso-8859-1?Q?A8NcidXoMWJUWoT3TcEAOBpNBWMHeuWQVI2UG9YZ4KDVvsF4qAWb+PVNIe?=
 =?iso-8859-1?Q?wWipNoR6gSUy2g3iM1BO1TJZutjNYkkE4IA8B9VwcuWZ+xaA9XUsSWxDcJ?=
 =?iso-8859-1?Q?xsU3sQRadT9qyepF3czz4untppBTN6X0YVfUpJZTHsxBRk5YJEPu22OtcW?=
 =?iso-8859-1?Q?Nw/aGqoCLjIiRKildYZWQncZ1IPJf8nbYZAMyThsoMJNXkQuHiolWBPA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ea54b4-5b7c-487f-3688-08dc44c88ca6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 08:18:52.3080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8497356-a834-4060-86b6-d4b1d8059ee0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TwbCO0LRqPw2xuXt508Lw5pIPhgXF9WOBV3xhspTZDyt0g/lWdV5nYjmiQPNL4gAhnWz5idq+JyJWKfSi/HrqcGz5VOLlWLo6Eiy+5Q6/4Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR14MB6579

Junio C Hamano <gitster@pobox.com> writes:=0A=
=0A=
> Christopher Lindee <christopher.lindee@webpros.com> writes:=0A=
> =0A=
> > Subject: Re: [PATCH 1/2] Teach send-pack & push to --send-up-to-date re=
fs=0A=
> =0A=
> cf. Documentation/SubmittingPatches:describe-changes.=0A=
> =0A=
> Perhaps=0A=
> =0A=
>         [PATCH 1/2] push: allow pushing a no-op update to refs=0A=
> =0A=
> or something?=0A=
=0A=
Thanks!  I will change the commit message.=0A=
=0A=
> > Provide an option that forces the local Git transport to transmit a loc=
al=0A=
> > ref even when the receiving ref would not change (i.e. the local & remo=
te=0A=
> > refs point to the same object).  This is not done normally, as no chang=
es=0A=
> > would take place on the server in a vanilla Git setup.  However, some G=
it=0A=
> > servers support push options and those push options decide which branch=
es=0A=
> > to operate on based on the refs that are transmitted alongside the opti=
on.=0A=
> > This option ensures the refs listed on the command line are always sent=
.=0A=
> =0A=
> Flip the order of description to give your observation of the=0A=
> current behaviour first, your perceived problem in it next, and then=0A=
> finally your solution.  That way, those who are totally unfamiliar=0A=
> with the problem area can just read from start to end straight, and=0A=
> those who know what we do currently can skip and start from your=0A=
> problem description.=0A=
=0A=
Can do.  I wonder if the new message will come out justified too.=0A=
=0A=
> Also, it would be nice if you throw in the issue about missing ref=0A=
> in the push certificate, which I mentioned in my response to the=0A=
> cover letter.=0A=
=0A=
I'd like to get a better understanding of the feature before I comment=0A=
on push certificates.  I'll read up and see if I can include it.=0A=
=0A=
> >  Documentation/git-push.txt      | 8 +++++++-=0A=
> >  Documentation/git-send-pack.txt | 7 +++++++=0A=
> >  builtin/push.c                  | 1 +=0A=
> >  builtin/send-pack.c             | 4 ++++=0A=
> >  send-pack.c                     | 2 +-=0A=
> >  send-pack.h                     | 3 ++-=0A=
> >  transport-helper.c              | 7 ++++++-=0A=
> >  transport.c                     | 1 +=0A=
> >  transport.h                     | 1 +=0A=
> >  9 files changed, 30 insertions(+), 4 deletions(-)=0A=
> =0A=
> No tests?=0A=
=0A=
Only manual.  I'm happy to add automated tests; can you recommend a=0A=
t####?=0A=
=0A=
I was also hesitant since I did not know what to expect and thought a=0A=
wholesale redesign might be required; v2 will have less uncertainty.=0A=
=0A=
> >  'git push' [--all | --branches | --mirror | --tags] [--follow-tags] [-=
-atomic] [-n | --dry-run] [--receive-pack=3D<git-receive-pack>]=0A=
> >          [--repo=3D<repository>] [-f | --force] [-d | --delete] [--prun=
e] [-q | --quiet] [-v | --verbose]=0A=
> > -        [-u | --set-upstream] [-o <string> | --push-option=3D<string>]=
=0A=
> > +        [-u | --set-upstream] [-o <string> | --push-option=3D<string>]=
 [--send-up-to-date]=0A=
> =0A=
> I do not know if the new option is a name that is easy to=0A=
> understand.  I am not great at naming, either but how does=0A=
> "--force-no-op" sound?=0A=
=0A=
I already gave a response in a reply to the cover letter, but I also=0A=
have some new thoughts:=0A=
=0A=
Is this something that can be easy to understand?  It seems to require=0A=
some knowledge of transports and server behavior.  Moreover, with the=0A=
server-side implications mentioned by brian, we should encourage a=0A=
deeper understanding before people use this option.  In that case,=0A=
perhaps a simple name is not as valuable.=0A=
=0A=
How do people feel about --aggressive? ;)=0A=
=0A=
To discourage unconsidered use, we could go with a scary option name,=0A=
like --disable-noop-optimizations, though that particular name has the=0A=
unfortunate American vs. British spelling issue.  It does exactly what=0A=
it says on the tin=AE though, which is nice.=0A=
=0A=
See the cover letter reply for other suggestions.=0A=
=0A=
> > +     Usually, the command will not send a local ref when the remote re=
f=0A=
> > +     already matches, as no change would occur if it did.  This flag=
=0A=
> =0A=
> In the context of "push", 'match' is a verb that is used in=0A=
> different contexts, like "'git push master' finds a ref that matches=0A=
> 'master' and updates refs/heads/master".  You would want to avoid it=0A=
> when you can.=0A=
> =0A=
>     Usually the command omits instructing the receiving end to=0A=
>     update a ref to point at an object, if the target ref points at=0A=
>     the exact object already, as no change ...=0A=
=0A=
Good to know.  I will avoid overloading the term.=0A=
=0A=
> > +     disables that check.  This allows push options to be sent alongsi=
de=0A=
> > +     up-to-date references on the remote.=0A=
> =0A=
> Aside from options and push certificates, there may be other side=0A=
> effects from this change.  I am not sure if we want to make sure we=0A=
> enumerate the benefit all like this.  Perhaps drop "This allows ..."=0A=
> altogether?=0A=
=0A=
I think we both agree this is a option that is difficult to convey, so=0A=
much so that I think we need examples.  How obvious would it be that I=0A=
wanted to use this for push options if I didn't explicitly mention it?=0A=
=0A=
But I also think you're right.  There are a decent number of things to=0A=
consider before using this.  Perhaps a fuller discussion on the option=0A=
- with examples - is warranted in a more deep-dive document and we can=0A=
refer the user to that document here.  If so, would any existing pages=0A=
be appropriate?=0A=
=0A=
> > diff --git a/send-pack.c b/send-pack.c=0A=
> > index 37f59d4f66..30b0f2f276 100644=0A=
> > --- a/send-pack.c=0A=
> > +++ b/send-pack.c=0A=
> > @@ -313,7 +313,7 @@ static int check_to_send_update(const struct ref *r=
ef, const struct send_pack_ar=0A=
> >       case REF_STATUS_REJECT_NODELETE:=0A=
> >               return CHECK_REF_STATUS_REJECTED;=0A=
> >       case REF_STATUS_UPTODATE:=0A=
> > -             return CHECK_REF_UPTODATE;=0A=
> > +             return args->send_uptodate ? 0 : CHECK_REF_UPTODATE;=0A=
> >=0A=
> >       default:=0A=
> >       case REF_STATUS_EXPECTING_REPORT:=0A=
> =0A=
> Given the existing flow of this code, I would prefer to see it=0A=
> written more like so:=0A=
> =0A=
> diff --git i/send-pack.c w/send-pack.c=0A=
> index 37f59d4f66..97d01726bb 100644=0A=
> --- i/send-pack.c=0A=
> +++ w/send-pack.c=0A=
> @@ -313,8 +313,9 @@ static int check_to_send_update(const struct ref *ref=
, const struct send_pack_ar=0A=
>         case REF_STATUS_REJECT_NODELETE:=0A=
>                 return CHECK_REF_STATUS_REJECTED;=0A=
>         case REF_STATUS_UPTODATE:=0A=
> -               return CHECK_REF_UPTODATE;=0A=
> -=0A=
> +               if (!args->send_uptodate)=0A=
> +                       return CHECK_REF_UPTODATE;=0A=
> +               /* fallthru */=0A=
>         default:=0A=
>         case REF_STATUS_EXPECTING_REPORT:=0A=
>                 /* already passed checks on the local side */=0A=
> =0A=
> to make it clear that the caller gets 0 ("go ahead and do it")=0A=
> unless it is one of the cases explicitly listed abouve the "default"=0A=
> label.=0A=
=0A=
Nice; will do.=0A=
=0A=
> > +     int do_nop =3D flags & TRANSPORT_PUSH_SEND_UPTODATE;=0A=
> =0A=
> Here we do call it "do_nop", showing that at least to you, "nop" is=0A=
> a much more fitting word than "uptodate" for what we are trying to=0A=
> achieve in this topic.  It would give us one piece of good input to=0A=
> decide what the end-user facing name should be.  In fact it is where=0A=
> I took inspiration from for "force-noop" I mentioned earlier.=0A=
>=0A=
> > @@ -1010,7 +1011,11 @@ static int push_refs_with_push(struct transport =
*transport,=0A=
> >                       } else=0A=
> >                               continue;=0A=
> >               case REF_STATUS_UPTODATE:=0A=
> > -                     continue;=0A=
> > +                     if (do_nop) {=0A=
> > +                             ; /* do nothing */=0A=
> > +                     }=0A=
> > +                     else=0A=
> > +                             continue;=0A=
> =0A=
> Drop needless braces around a single-statement block.=0A=
> Alternatively, we could write it like so:=0A=
> =0A=
>                         if (!do_nop)=0A=
>                                 continue;=0A=
>                         /* fallthru */=0A=
> =0A=
> but I think what you wrote, modulo the unnecessary braces, makes the=0A=
> intent a bit more clear.=0A=
> =0A=
> >               default:=0A=
> >                       ; /* do nothing */=0A=
> >               }=0A=
=0A=
I was having trouble coming up with a good name when developing this,=0A=
so I went with something that was 6 characters long.  I'm open to=0A=
identifier suggestions that might be easier to read.=0A=
=0A=
Thanks,=0A=
Chris.=
