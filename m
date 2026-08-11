Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazolkn19013014.outbound.protection.outlook.com [52.103.33.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4162472B8
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786422388; cv=fail; b=Pg0uPxi5QGLLo+w/VLgqBbM6hytxLEt/00jojEgiNc0D5oJNJKuFQo+s//Pbd62lRMqKvu70T5swoOosaONKnYWsn5VvSpPFbLiF48NFGN/LRpqPFOzai0wXcaZJAzUXEDt/gV/t1h0Z4c8Zhkov5+2IHTG3UJlzQeUaMQ1AlBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786422388; c=relaxed/simple;
	bh=HLX3Afc27E3TVUZ/5KgfHBPae/M/C50jAMBl7AtDAiQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rjb3Oatq6An79cAqMbrLWKmzdZ5gqk25d59MxmQu8z8F10Jg7wrLtEfCH8+PtvnqqeovgGlAmU4OZiyJ+CCrD95GJAmt+ePdXRaR4EpA7n936C1ESyrEWAHtMSYLk3lpO3hC+657V+strn3kMW0iFKaDqhgJvxCQQLTvADvX6kQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=S8JMg//1; arc=fail smtp.client-ip=52.103.33.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="S8JMg//1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffq9fyMw2WoElzLcwSB1h6xr87uWvtXBhLVKvpNtWpaUwfV1t8Uh6/CrjQ7G37EcGYrw+OBwy+qIQC6mEco9oGm8iqKqpr1RaHIBNkb/mXONJ8yfxBq6p7edHTNBJKjrkH4D0zERj5ADmga7CBte63HN3pXp7SEYQsnJQymJuUgK7EK6JeJCRtFeREgwOQ+j99hFIuI0T3W1NVFztH8TNowiBG04lhmQxWWeKlE1tTnCufqgAP76sUTwASPJMwf9d1IfrCQUddzQsu6tcBGGjJsDY+HweZ8XvE2rqw20K6Lz2Th2hV19BJe0IjGkta3818YjVCESlWEFqFWHAnG8jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnGZzXo3L/0eqa4VRSVYHgwOqGgZnt3wj/ETynutJ1w=;
 b=D/lPoI+Fipqjkzufum1wU2BwmMzLI9P9lYGGhRWkwTlBMkjc/dXv4g5gO7GFTY6Y8eRbk/RFeubg9ryF2LDQhLlV9nYKHQbDp+UadDB1ckIOCFzQTHagMGj/q8GTYVqSQEqJEodNP6Fu9Y/q/GhAm5O3/vE4JQE3cXmfCvXcsy7ATeStq05yWJL59/hIYL21DCNm19czP0g6PrNZ8uRvXZaSF2qxJdJVkFdNJDmZMyTX/4vGOlin8x1allxS5Ic/gidE3x/qpglWqwf5oH6eJ9oDhCMnBVK1HoZoALRAwLH/RiZjYdgQRGdGFR7YrXRhyfjJN1T7mui6ZgMieF/KUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnGZzXo3L/0eqa4VRSVYHgwOqGgZnt3wj/ETynutJ1w=;
 b=S8JMg//1JtSd/uD1cQxfC4vFY9w5v79HEvo2WLmtiytwjrz3xJv1Xe+qoxjtzJvFSitUcTAbN5Fo5h77kUgmft+ZS4gLLE990GQWUc49iEvXZcVLPaNbNhh7Ii571cdDl4zOa9VcTeK5aP8hKQEmTPHPITlUi61G+Fb23oQqDDuYcAZKEC83Bo5pjUcD3b8ZoxeEnfnmk7CeI+psfQinfUwjpQ94LAn3zLRnworw6ZnEfgROUMmB4rIKxaD0DcyHgwV1FYRtejZlRN4ZPCUnWydHBxFJ8Xw4SrK4scHWN8vNIPChnFvu/kmsTHmZ3AVXHI0LGfcewG6R6tHuT//bAA==
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com (2603:10a6:208:f4::27)
 by DBBPR02MB10771.eurprd02.prod.outlook.com (2603:10a6:10:53a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 04:26:22 +0000
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf]) by AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 04:26:22 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: Git <git@vger.kernel.org>
Subject: Re: AI Textconv filter misconfiguration on Windows leads to silent
 corruption of diff output (ongoing investigation)
Thread-Topic: AI Textconv filter misconfiguration on Windows leads to silent
 corruption of diff output (ongoing investigation)
Thread-Index: AQHdKSpeW10CNT+9OEuLP9VqvpTkMLaYG2wMgAAB2zCAACCveQ==
Date: Tue, 11 Aug 2026 04:26:22 +0000
Message-ID:
 <AM0PR02MB44501AFB0A97E2E097B8795AB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
References:
 <AM0PR02MB445096594555DAD1D9EE1505B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB445083767BAE669D4656CA6CB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB445013B3CDAAAD361FD93A86B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
In-Reply-To:
 <AM0PR02MB445013B3CDAAAD361FD93A86B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB4450:EE_|DBBPR02MB10771:EE_
x-ms-office365-filtering-correlation-id: 1efac5f4-9ec5-4e27-7bfc-08def760b307
x-microsoft-antispam:
 BCL:0;ARA:14566002|25010399006|15080799012|15030799006|51005399006|41001999006|37011999003|24021099003|31061999003|8062599012|8060799015|19110799012|55001999006|56899033|12091999003|31101999003|3412199025|26104999009|440099028|102099032|40105399003|2607281247196008|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?MOl7tZkgjOqLPK5IqqZvlxvzLlsbJi05C2NaAkxwLofppFyEndMixdfs/w?=
 =?iso-8859-1?Q?TounLns5Z1WDT4cDDTPMEqB3Hh1WLDO53C4r/gcN5uoLD4n0Tfs3IbN71Z?=
 =?iso-8859-1?Q?cq+n0bECwNahBlN3IlwrB0ToaGFHSkyvQ9P/jajoU/B34I8gR2Ox50Vh8A?=
 =?iso-8859-1?Q?B/6j3Tn/GJMGd9z8wRRdIgbJTW9WfgG1LrXoiuVv97/4BtIibCeYxi0w7V?=
 =?iso-8859-1?Q?+t0mqLHefuGcbAqCIx3BTuGoYBnGrHT7HfuD2D3nTU1gZQ9nKwSNbJpdmT?=
 =?iso-8859-1?Q?fuZKBJ3yw6e+GWkNixO5pTXU5uQhA0UWf5V0TLri2LfV1IIUHLNG4V3LWl?=
 =?iso-8859-1?Q?ooHfGQ/l1fhItxHAgSA0RuaQ3RnmfmcMB/1luYtCAkQRZCchpQp/SZlT6Z?=
 =?iso-8859-1?Q?5HSXQMYc0/wsED2Ye1AvnDnEmMem7EmF6Qv18LsIf8JgqWIpEAdYF6TEG4?=
 =?iso-8859-1?Q?BPnys91i92WKEjZcr4I1ZQfjX8TqZw7JuN4BCFl6KvEjL0DsPtAc553z4T?=
 =?iso-8859-1?Q?I/045REtbgLLiRBFA0VAN/rhaALAsVep8LZFTzxifpN6t4GmPB/2pifM7E?=
 =?iso-8859-1?Q?m+MQvnUeGOlmtZl353nZiWRT4DWBa1dsWA4FKqr2BonD+UWU1HOHbzZdJ6?=
 =?iso-8859-1?Q?ZRzKa4g9/wESyrwj9SMfoBAFAUqWeKSObklxNgVosVtHTRr04iRY6tJh0j?=
 =?iso-8859-1?Q?VEfomIPDLLH1gy/1VqqIa05JVDAuSu30Lp+UODMbR8hIEetIBx+ZbN+8ge?=
 =?iso-8859-1?Q?UBRD/94RpzgwzspAj0ifMrjPCQTpM3LCm9o4sHqBnIr+LnZ4tGmh9sDeF5?=
 =?iso-8859-1?Q?8nEu80ZuISPbmbTJ0hOLoIerXiwk8uF7yBD8twgpQ5DPI0Dq8E2bbfBPHO?=
 =?iso-8859-1?Q?6yTystJLjQIXLEy7zJCTBKZZBppFSkyc9V3Ip9TXMhpWMgSjBsrt1Xnpfo?=
 =?iso-8859-1?Q?qJQOKkuDR+oriIQzT0zBckfDmL2XpVQV9st4Yvn1uJPGdj8LxKutChb9Cn?=
 =?iso-8859-1?Q?WnXdzswRQ3+94T6XB4zO3bhRt50vVyzBu0coD6zgZq0cixcS5sz4WlF4KS?=
 =?iso-8859-1?Q?D8LzxBknM4GidvuF7Iuvb2hn4fveGl7S2DkWC1TCRUXUMcUB3ZGF+GWfc3?=
 =?iso-8859-1?Q?ecRQXPHpb7ZHqr1XlTxvziHxWT55o=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Lgk0ElrZZIsx0MPU6k7lWeYhTyRxQuHJuz+vKICh4rN+ZKVa/Ad8AX2n70?=
 =?iso-8859-1?Q?pfE6fNekKo9+7CG3L7XW8I2c9s6TwiQGguEQrCZKZWId8uFiyKm87vETap?=
 =?iso-8859-1?Q?YBKv8+rT1C6zmvTWQpfNH5vvdEJMRQEc6Q5tE0Od+AR6AWXNUlj4maStIn?=
 =?iso-8859-1?Q?9hIPbwWukOysvkPy3aSgpAJX7HDd1ItIAkJX8wxH/EeYBp2p0szHdc/EhP?=
 =?iso-8859-1?Q?6FKCeE9TNuMDMcE032Z+jr1T9fw3Rpb7iBkw/cvgmrO38V9rZE1kjFZXe2?=
 =?iso-8859-1?Q?YSe3/Ps/1BWA86nT3VrIRON0Nvj7u01nRj3XsfNmMza+eVrfKM1YAMdqWi?=
 =?iso-8859-1?Q?kzGIz+nMEGXBiF+vDj9z5xWg6L+dd9O68Y7EVjLXk9UqbbQYtQIkzmCW+s?=
 =?iso-8859-1?Q?k036FNBpfG4EAQ6Qy4mHh7I1imNgDhcbQLzekk8aZy6u6tia4gIiVgvtg/?=
 =?iso-8859-1?Q?g0xmH6QvssT/PhKfQmDpx1kMOb6WCxB4NieoU6qFL9DYrBi2dZKpFm9v7o?=
 =?iso-8859-1?Q?+cLzHu7nLqeWDtWgoTJ7VBxuY83FvGS7FoqbTfXVX4PPDp5AcyKE6MyuqD?=
 =?iso-8859-1?Q?4i5JrioNqpXAuMBzgJBHl/T/OkO339Yjw/i1yPLWb0kQvlSAYCGWq9a7Vp?=
 =?iso-8859-1?Q?/sJIfX/ID+xsSab+Nh/JwRK/7fMKG1olA+YVEBPSE37E0vvMKUouVGb42B?=
 =?iso-8859-1?Q?wj/8oC76XllBFXor7SNbQrZtLX34zoz79N5EXmr+AGy7EEqmjf6XjCOXq8?=
 =?iso-8859-1?Q?5QBvSm6Bd6fIi1eOkmoKYWlk5UyA56mW1HyqhX4r3BkLkpaO0V+F3D3H/5?=
 =?iso-8859-1?Q?49mKQoxPXEVu+ApZaHE8/yLxela6R+VGhedbZcwV40HoGnhX+hBllIsDmO?=
 =?iso-8859-1?Q?aaW1dHgFul2eOA3kHRcwg5JKpzh7Jq1s1/3TD377GJljviSWTOJMB8oAN4?=
 =?iso-8859-1?Q?v5j5Xr57flVpj6jXgpvaJP1oiytNX6WsH9DJqbmKDK9Xy7L+t2UNsMs4J+?=
 =?iso-8859-1?Q?NPSxsJeJXJihQCAJPn5mILLNNrJfBxZVMLaoAsBnDtfxIXv6ktv9UPBqcw?=
 =?iso-8859-1?Q?ms8ShPj7QBKKpUL1D0iBJ/4DRVWP698mKgbiwWYZ9pFRfV6t+i2ivabKoE?=
 =?iso-8859-1?Q?Kbi3230GdrsRgsL8aQ9+cf0Z8CwFPk8JHhpwyfKsPa+JaWnoP8aAwrP9OB?=
 =?iso-8859-1?Q?6eEGzgz9zqJvvCu5lhjguwhsElAjo8nphu9cgZkapmZAIRN4n0itsjfYk1?=
 =?iso-8859-1?Q?ErpXgKTyhKes5hJtgV+IjgHcBfhQrsy+u0nfpwPnxRpRgFGopBzOuFuU0o?=
 =?iso-8859-1?Q?8l/HpwAH4u3T9pgmgwzsca2HWQ08rPNKJawtwT35VcOi08ewokOQK4Mo1R?=
 =?iso-8859-1?Q?otJq+CrEsheRpPF8blTC8tNk83tO3fl5S/nPdqME2LUmun/Wvmh0RpAcJQ?=
 =?iso-8859-1?Q?EUKAn9mqUJ4uH5sOx4LOoMrg3Gk5o6wv1Jiy3Vn5GlgNinUijF3oFqLXVE?=
 =?iso-8859-1?Q?uelnr1aTJk7zTf5eHyI873?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-9f624.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4450.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efac5f4-9ec5-4e27-7bfc-08def760b307
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 04:26:22.5558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10771

Faulting application name: WindowsTerminal.exe, version: 1.24.2605.12001, t=
ime stamp: 0x6a03a6ca=0A=
Faulting module name: Microsoft.Terminal.Control.dll, version: 1.24.2605.12=
001, time stamp: 0x6a03a3a2=0A=
Exception code: 0xc0000005=0A=
Fault offset: 0x000000000002c924=0A=
Faulting process id: 0x0x5E3C=0A=
Faulting application start time: 0x0x1DD2916AA80F175=0A=
Faulting application path: C:\Program Files\WindowsApps\Microsoft.WindowsTe=
rminal_1.24.11321.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe=0A=
Faulting module path: C:\Program Files\WindowsApps\Microsoft.WindowsTermina=
l_1.24.11321.0_x64__8wekyb3d8bbwe\Microsoft.Terminal.Control.dll=0A=
Report Id: cd357657-4241-4a05-95d5-54ad0292fa24=0A=
Faulting package full name: Microsoft.WindowsTerminal_1.24.11321.0_x64__8we=
kyb3d8bbwe=0A=
Faulting package-relative application ID: App=0A=
=0A=
As if this day wasn't bad enough yet, windows terminal also crashes, trying=
 to copy & paste the command line used to actually fix git.=0A=
=0A=
Many copy & pastes were hurt this day. uBlock origin also started fucking a=
round with copy & paste functionality, blocking it.=0A=
=0A=
Hit the big logo which looks like a power icon to turn it off... or read th=
is horrible dev issue thread, which contains some more manuals how to add a=
 by-pass/circumment/exclude filter for deepseek website:=0A=
=0A=
https://github.com/vitelabs/go-vite/issues/656=0A=
=0A=
It's good to read this anyway, to see how SHITTY your git actually is, it o=
rginally started with trying to apply your git diff output via the patch fe=
ature which miserably failed !=0A=
=0A=
None the less a branch was created anyway, with commits, which is a more pr=
oper way to do it...=0A=
=0A=
I can't believe you linux faggots used patches all this time, it has rarely=
 worked for me, your parsers are total shit. You need to start using AI and=
 first SPEC THE HELL OUT OF IT by using every AI in the book: deepseek v4, =
gemini 3.6, grok 4.x, chatgpt 5.x, meta.ai spark 1.1 =0A=
=0A=
Only then will your software improve.=0A=
=0A=
Anyway, thankfully the entire browser didn't crash yet, I should be able to=
 at least copy & paste the instruction out of there:=0A=
=0A=
git config --global diff.lfclean.textconv "sed -e s/\\r//"=0A=
=0A=
=0A=
TO ALL SOFTWARE DEVELOPERS AND CODE FAG BUNNIES ALL OVER THE WORLD:=0A=
=0A=
TEST YOUR COPY & PASTE FUNCTIONALITY 1000X BETTER=0A=
=0A=
TEST YOUR SELECT FUNCTIONALITY 1000X BETTER=0A=
=0A=
TEST YOUR DRAG & DROP FUNCTIONALITY 1000X BETTER=0A=
=0A=
I RUN INTO THESE KINDS OF MALFUNCTIONS=0A=
=0A=
ALL=0A=
=0A=
THE=0A=
=0A=
TIME.=0A=
=0A=
BLOODY=0A=
=0A=
FUCKING=0A=
=0A=
ANNOYING=0A=
=0A=
BYE=0A=
=0A=
FOR=0A=
=0A=
NOW=0A=
=0A=
I =0A=
=0A=
HOPE=0A=
=0A=
I =0A=
=0A=
GET=0A=
=0A=
BANNED=0A=
=0A=
SO =0A=
=0A=
I=0A=
=0A=
CAN=0A=
=0A=
PUT=0A=
=0A=
SHITTY=0A=
=0A=
LINUX=0A=
=0A=
SOFTWARE=0A=
=0A=
TO=0A=
=0A=
REST=0A=
=0A=
MAYBE=0A=
=0A=
I MAKE A NICE PARODY USING:=0A=
=0A=
"SOUND OF SILENCE" BY THAT WELL KNOWN GANG OF MUSIC ARTISTS=0A=
=0A=
TUT TUT TUT TUT TUT TUTUT TUTUT TUTUT=0A=
=0A=
OH YEAH I REMEMBER NOW:=0A=
=0A=
=0A=
"SHOUT !"=0A=
=0A=
"SHOUT !"=0A=
=0A=
"THROW LINUX OUT !"=0A=
=0A=
"THROW THAT GARBAGE OF THE PLANET"=0A=
=0A=
"COME ON"=0A=
=0A=
"JUST THROW IT OUT"=0A=
=0A=
"COME ON !"=0A=
=0A=
"AND IF I"=0A=
=0A=
"COULD JUST NOT HAVE TO DEAL WITH LINUX"=0A=
=0A=
"I COULD JUST CODE FINE"=0A=
=0A=
"AND I WOULDN'T BE WASTING MY TIME !"=0A=
=0A=
"I'D BE CODING FINE !"=0A=
=0A=
"AND NOT BE WASTING MY TIME"=0A=
=0A=
"SHOUT ! SHOUT ! THROW GIT AND LINUX OUT !"=0A=
=0A=
"COME ON !"=0A=
=0A=
"GET RID OF THAT GARBAGE !"=0A=
=0A=
"COME ON !"=0A=
=0A=
BYE FOR NOW,=0A=
  SKYBUCK.=0A=
=0A=
P.S.: DON'T DEVELOP YOUR OWN OS, IF YOU CAN'T FOLLOW SOME FUCKING SIMPLY ST=
ANDARDS LIKE CARRIAGE RETURN AND NEWLINE=0A=
=0A=
BY FUCKERS.=
