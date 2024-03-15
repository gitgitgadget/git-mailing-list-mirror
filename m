Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2092.outbound.protection.outlook.com [40.107.237.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C556117
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 00:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710461473; cv=fail; b=THwr553P6mOqHVWtJt18ABd/XY56O24+U6B0UXEB3k5SijGhmcdpL5jAP7VML1+uoNOo6HWraJx4QD0mZHzVQo9UGl4KG/3CRPjbZdyGSInM+dxepxOqSrEZXqqMqkmnzk2IXdC8Wv+zJB+P/P0DydIGnB0ogdgQLc7Y4WkuSus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710461473; c=relaxed/simple;
	bh=YvNfqehDh872o6BcO0Qzn+SikdTnzgPchrwLTgIgInY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y9hcmYIALRaGzYc5ccWLB7nWOeKX2RN02SofA+P+JWPSgLR1AntbAYa5kQxUwERenNpvOYdfPuHdb8Sp4FE7vSZM+Op3s/K3FpJOnpmpnzUFMfOeGsddmeJJCotaXtDNrMZu7gLokmeZqD2qVUFyIMTTPHP8XIp7Vl2AMFYRBQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com; spf=pass smtp.mailfrom=webpros.com; dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b=mzkYf0Zr; arc=fail smtp.client-ip=40.107.237.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=webpros.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=webpros.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=webpros.com header.i=@webpros.com header.b="mzkYf0Zr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6gGjavmqDWkIEoPoE/2/2jzzNGpDbPDoDucpIyDEE+VBFgjps5OtKBrTlKAbQMWiuwub3PLx/+Nj2UM07vWRjqrm8msuHtGnao/1EQtFRYuczQE1M//p7I5ieAKlvzJEPwkkC80hLNup6EjOOAOqKLoXFl0BZoTo9LZwbJJpOEx3sYigtEt6yEU+kMOzX2ET0qHQSbSvkCdgV3x7Qs2WQ2fSkq3Gzx573cBY9RLjw16sSGieg1ZC7CpeRqo8+jlTB5Vv2fxRBBL2RjmPXbZ/ZpX2ddIiD79mTY6icEwpVzTvZCkIVyWBhDTsK9cnWq/89npEVrSj04Gdr3ZbJYmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBUPslRwMo7Ap2xDL+AkcQiOWdg9pRLydKhjhkMqfuk=;
 b=ium0nIHGCRsdTNhx4OdqsgmFbo/PTkc54Op7qYdrn6SawRvGkEGGXbaXsPDd0x/SISj/5BazlGdmcCwn+wDIimMs5EMkApw15dK/Mf1Qol22t1gup7LveCbNpiFGZd1HElPAEf9DtED9FJ8GKcXhxryegBSSD5QBTx+S5UJ/TxlAkUwuL6dgdAlowLJcDemEOwNXj/6ILZpINgY1f1Kh33i5SasxPxttlMlTeYFKIBJmiX25lCq+deSCR8zkzX1xhg5SOqdUwMGofZNn9IKHFubNR3CR80iCiBQ17HbCmdir6pMyyWqMp250ctCoMAlo4jDVuCeER2m6sJrogsWoMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=webpros.com; dmarc=pass action=none header.from=webpros.com;
 dkim=pass header.d=webpros.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=webpros.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBUPslRwMo7Ap2xDL+AkcQiOWdg9pRLydKhjhkMqfuk=;
 b=mzkYf0ZrNaePM8PnUy3ilbaocR69WEDGLR2U2+Qd00l5VfkKj1iQ1F70We+jmvA8B8MLt7rC24eTEYzZeDmlVvrxDlGX8w4WTTnl/+MxGj8VZtvOqCis1gdNA5Xgs/VmHwEX9sZj3A02k0jTGiwWLydrBR5WtPT5A6X0vJaYHKrP6xlSeZkjoAG+dLdygjDKiQOkr3iUy3H71hCktCRqWcLWXUrPCLwKKIIchpJ4nftZDLzTigfdnmD6wAorVurc4BivAEnByR0HEHFn8/k3JNW9MfiyMvYUe8SSmWFJAZ6CNDLDHhEHMOmSoBlpm4XOuT32kOhRHP4G0lKLAtfXuA==
Received: from PH0PR14MB4702.namprd14.prod.outlook.com (2603:10b6:510:83::23)
 by PH7PR14MB5846.namprd14.prod.outlook.com (2603:10b6:510:1b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 00:11:07 +0000
Received: from PH0PR14MB4702.namprd14.prod.outlook.com
 ([fe80::780f:93d5:996a:1fed]) by PH0PR14MB4702.namprd14.prod.outlook.com
 ([fe80::780f:93d5:996a:1fed%7]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 00:11:07 +0000
From: Christopher Lindee <christopher.lindee@webpros.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano
	<gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Thread-Topic: [PATCH 0/2] Optionally support push options on up-to-date
 branches
Thread-Index: AQHadLHezsdN01rhbUOhmHwkmqTtTbE2SreNgAGRaICAABTk5Q==
Date: Fri, 15 Mar 2024 00:11:07 +0000
Message-ID:
 <PH0PR14MB4702D52DAA9AA81BEDB32D1E8D282@PH0PR14MB4702.namprd14.prod.outlook.com>
References:
 <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
 <xmqqa5n168nh.fsf@gitster.g> <ZfOAdVy9_UfTj3zE@tapette.crustytoothpaste.net>
In-Reply-To: <ZfOAdVy9_UfTj3zE@tapette.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=webpros.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB4702:EE_|PH7PR14MB5846:EE_
x-ms-office365-filtering-correlation-id: eeaabb25-0d39-49c0-6bc5-08dc44846950
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cmS+m41Frxd+3Y7xa/qgDalaZdT/FAFxlYVEjbTahF/1XvAmjgSMr+6u6/uCFouckzaMWROUJ2V15zJOiMcG72uoBuyhcudr7Gd+hF069MveJsoYmyvdW67T9IHrifrlVTZSKVEeCLeb7fibdROgeu8KolQ+Yo93zDVkQsVhj5YOo6OAab8fs+2N5jZfn1zCBGNOsWdTX6PvC/KJttFqy3Bvk9XDxHduzcvy87ncLa76i8TyWHDpH2BjgP/WOqEl/IWOMfZhBvNsk9zcnxK2AY54i9fNwHR+ePp6bZwA2c52SSbsrXzEB+4zTfo9Qp+29cwWx0kEoSJjEPaANacO1KaQnKQlT4xcbOcvJvfblXuEO1kY8zj6YemGlN60vbJIsuI2YJnrUiqNZs6kYNlqAn2YfMDnjkVv8zXRowiBH69mz7IetZQBIi+ALlTY669EgLoP77LOhgBQzW9MVj8lgfi2G5bIjutPSulaJs8u+lt2XUNbqb8An0JjFjsW5vfnsiYj01E6q0fd9Wu7Cx1qEnk5PiFGSfBInZDrOrvF98ibbL1VECOYTtlIZAy5neKJHZb+JufEFL5+OeVpFZDb8QHDlz1MMv2Tf8+yxl1tH+iJAjgylLjhscgJiiD5WCwfKHS4T2sdEeYf5X7mbjgxkIKbtDY5Pk1ppyaffX5droPM+DH/iEr7ozQbdhu0X+7BVP9Zsfp5lwMyQLtLIPTLtRpCQMEJcreKvhubEAy8KZ8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB4702.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Qu3KwLtf5HegWI+LXAEUgNgumJu+lyXXaRA/Cw8QE7CjBe4Dogop78lGHH?=
 =?iso-8859-1?Q?ZbU9bsNrK1NkwkzxFz7ZdRqPyraqqI92TssC6XSTfqZi3208GbDsxYD8CZ?=
 =?iso-8859-1?Q?jzghEnL8GbqVxVtgcRFUtuRN+mEKYeMW1EoPN2cYn5kGIszusLVvtbPvdI?=
 =?iso-8859-1?Q?Leoxck4q/zHv3j9sTlRoCKt39HxNsA5453S/RsRCE5OWmMLG9CMjPUdL5s?=
 =?iso-8859-1?Q?O1W1r6YlAEGtUjkgoay2e4EjonZ7lNbFCeqmFMy3gPRUQ/46SS/J9Is42I?=
 =?iso-8859-1?Q?+h8zkXJMn6un+IgYvkVEI2hGb1574qPhzKJvQPsDAHLnfNNIfsR2iHThbz?=
 =?iso-8859-1?Q?6XBQJMp1uWlxuY6aaTDoGWjZQkXf8/XZmurzzui7sTI00isWuwOT6suv1W?=
 =?iso-8859-1?Q?P1AGgy06Hiv0E8NAQX3qFPl9DVRCDcAnOAQshNJcP02Jcyoi3h3upb2o6z?=
 =?iso-8859-1?Q?Zt5l6on43PMDbPsWS1UWOhOYwIILsznUEs8b+0hxZcUghd0HLTY2ZEHpap?=
 =?iso-8859-1?Q?PJR48cwkDPVP4i4uw3+pr1eJ0yZiKDNUzgfLYW+zhlBA1x3tRRq6YIvfPl?=
 =?iso-8859-1?Q?4wYohiitYbmqV6hhS/zIkuXZu7R/eG5OY9VE2Sq9Yd2XgH0l/LtUtTV0kl?=
 =?iso-8859-1?Q?OxG8BXO7xj93/djF3KPYJPsJHTuHJLtenY2SjypF3rpydhWa/1OhuiacW7?=
 =?iso-8859-1?Q?Ujwj40cLJJIPm4zaaJgg9QvQmUV/IiK16KiDKl7caq1kbFfRHdVVKoH9LP?=
 =?iso-8859-1?Q?8RGWt79ln/y+LJeE9vSVespmhn5vmVfXSKCUaqQqukuSZicBOgHupcaDv3?=
 =?iso-8859-1?Q?Ge5A/62uu+3IFUWo4BiJ5UhHY6+eBpwmBLg2GaeGbNKrHLv2QdRjKR3cMq?=
 =?iso-8859-1?Q?GuCKHama1QkCjEV9eIjN8S9UYeFFm28BpQybZsRabAhI4gbEMeV/K/rlfj?=
 =?iso-8859-1?Q?6ZDWoKmLwe2Wjs2EY/200zbWWpk3qaT3Zx/sXlzmxY3s7lBF3v6NrL/+U9?=
 =?iso-8859-1?Q?1AT4lOLiB65RTl6+6nmghJnAvdunT087PP0hRoCKI8OWNjtlr7jtjcDGf5?=
 =?iso-8859-1?Q?8kMbQxDGoZN9ZStjYnHDELqUeuQikeqdrV+UvsIfLTZB/RWdmjHAFKqxbO?=
 =?iso-8859-1?Q?MDsoPULFGp+aocf9QcO1n0EUYIEFxv5BMVaKdxIHbcymmuVGrj7uYnEMcN?=
 =?iso-8859-1?Q?40c7bGPCkEZkry9JTPiKD3tX+njb3oRMcswTaUSxO6HMQiuXOUAyCtZQJt?=
 =?iso-8859-1?Q?7+CF++0ig+fyP2OOSKSdKmWPqJIzvvA6dYUz0fGgdB8x8el4n7e9u37kF6?=
 =?iso-8859-1?Q?weEBhsRzgeIQhnY+z7rGjPQiNCBvFbBcjjEEoWBz+s20l9pZDb4Lo8gdzH?=
 =?iso-8859-1?Q?VOy4wnnolDWi8OqFShlVh98rSy341fdXo2X+nEcsEnwI4qsnuzIeuYAz9I?=
 =?iso-8859-1?Q?r+LJSWXhVZ+9h3Cj1kx5sMkMRRefcdzXrC21aCbpNU/+yFaeWRedwe4Vno?=
 =?iso-8859-1?Q?qEK/Mirvu/sphvJLH1L7S1KKoEEQWA0iL2jBhvIF2snUD2KRenMVEcxc5O?=
 =?iso-8859-1?Q?JJb6FtirjdiCA6jYRpw+AqZEngUpCj4+DzFEmqaktr+7LWdYT8LroP1qZq?=
 =?iso-8859-1?Q?6sEmDUzqX3AG48y4DYAYMEF9k9KrR2xfh/nlGOq0ebrcZGaaZSS4lRjQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB4702.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeaabb25-0d39-49c0-6bc5-08dc44846950
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 00:11:07.2587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f8497356-a834-4060-86b6-d4b1d8059ee0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ysjmRUK4IKL+BPYyRKIRfEqS/bLgLi8scjZz3cZMVRhv4Pecb7DBInrihNDKEnUiNqtFODqv0Tq7BRICIT+7mNP3U/Y8VLE9N52WhJtOfqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR14MB5846

brian m. carlson writes:=0A=
=0A=
> On 2024-03-13 at 22:58:58, Junio C Hamano wrote:=0A=
> > Christopher Lindee <christopher.lindee@webpros.com> writes:=0A=
> > > This changeset proposes to address this issue by adding an option to =
`push` and=0A=
> > > `send-pack` that, when specified, will send refs where the old-oid an=
d new-oid=0A=
> > =0A=
> > "where" -> "even if"=0A=
> > =0A=
> > > are identical - instead of silently skipping these refs.  The first c=
ommit=0A=
> > > introduces the `--send-up-to-date` option to toggle this behavior, wh=
ile the=0A=
> > > second commit updates the commands to output an `(up-to-date)` notice=
 for each=0A=
> > > branch with an identical old-oid and new-oid.=0A=
> > > =0A=
> > > Notably, the `--force` option will not send a ref when the remote is =
up-to-date.=0A=
> > =0A=
> > And it makes sense *not* to update `--force` to do the no-op push,=0A=
> > becaues you may not want to (accidentally) force push a ref that=0A=
> > does not fast-forward.  As I already said, tying this with use of=0A=
> > the "-o" option is not sufficient.  So I agree we may want a new=0A=
> > option to trigger this behaviour.=0A=
> > =0A=
> > A radical counter-proposal for the design is to update the client=0A=
> > side to do this unconditionally, without needing any new option.=0A=
> =0A=
> I'm not sure that would be a great idea.  Since it's a push, that will=0A=
> trigger authentication, which may prompt the user (e.g., for a password=
=0A=
> or token or for a YubiKey touch with FIDO2 SSH) and which they might be=
=0A=
> able to easily avoid.  As a server operator, I also expect that there=0A=
> are people doing lots of needless attempts at pushing in automated=0A=
> systems (because with enough users, there will be at least some who do=0A=
> bizarre or inefficient things), and I would prefer to avoid serving=0A=
> those requests if I don't need to.  (For example, for us, reference=0A=
> updates need to go through a distributed commit protocol to update=0A=
> multiple replicas of the repository, and if there's no ref updates, then=
=0A=
> we cut out multiple services which we don't need to contact.)=0A=
=0A=
I agree.  I could easily see a nightly cron that backs up all refs to=0A=
a server that would then trigger server-side action.=0A=
=0A=
I'm curious about authentication though, when I did a packet trace on=0A=
an up-to-date ref, I noticed it ended with:=0A=
=0A=
push< ...=0A=
push< 0000=0A=
push> 0000=0A=
=0A=
This suggests that something is sent back to the server.  Does that =0A=
null entry not require authentication?=0A=
=0A=
> Note also that no-op ref updates cannot be simply omitted on the server=
=0A=
> side because we need to verify that the old value for the ref is=0A=
> correct, or we need to reject the operation as out of date.  While it is=
=0A=
> _unlikely_ that the ref has changed since we fetched it from the server,=
=0A=
> it's not guaranteed, especially if there's an expensive `pre-push` hook.=
=0A=
=0A=
Regards,=0A=
Chris.=
