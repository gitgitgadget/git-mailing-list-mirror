Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011030.outbound.protection.outlook.com [52.103.32.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BBC2D876A
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788378238; cv=fail; b=f/uMIzz4urgfpqZAOC3QKZtYJitMApUFVsUKxKNjCSKUapO0VmDgVRvnUKCS8KUIl/h7tUF1COAL1qG/zFJdC+wlR3McZXgWpHz8umXbqXT9kl3UdqYYc4tOPyKIJifzPplbQcvVTSga+6mHGUcEP/4tv0PreLPVFyfo2Uu7P8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788378238; c=relaxed/simple;
	bh=dc9iq1z7iOGX7ZQ8LCO3f8JMLY3PtdFPXvaye5rPSsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A/HMZOn8xQGML+Q/0QeoHSq3kyrL38iB7xOdtXCHOTtlMWS0IxupvYagRWN79daKWxl9x4WIifVYS+gOHaMWjnpjs+o//q4q9XFF+YDlJwilLAt4iU36RTHZxo1hEuYwkKDASLLpLSF2E3us6iPrdgibTK5SxBwCQzeFM9M2a1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=VDnU1Gzp; arc=fail smtp.client-ip=52.103.32.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="VDnU1Gzp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhFz0C/JFBTqwJtAVRG/q6CwEY4mOkVXxcxfg7gRuVgZqL4O9cinTnxgGngkwuYSWkKxBPa39at/lJ0K/m1rOKfRQjKBLcRuDq7CZ5rZWeGZ3dg3Jmv9kzoM43znLXnBdrQC0Aqqs9D3XKazr3Wyc2togOHkHMNaR27pSg0xf7ymuoLAnaVhCWAPppeIXI9+kFuiZmixU/XVoAcMgTXh7mxi3l1wt+n0teCg/qsh+vt6NofdYyFjUU1LiLPlJZDeop2rVAMSoUeDv4TH7aVEJJBB8F5lAraZUbd1xaRdaELMGtfJ+lFxMgDZG/obq5d+LuctU21mvNh/RNPYBJoA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYo2EJzgFTs7rImlll9ZZ58EInhvPvHkB+0QHtewhV4=;
 b=Qqc14IMCblxrxMGzf/5CztUKikLPNzhq7M1V+WsFdgWKfRPisRRbxM8HN2n1Zkw+EZXPHx8ctVss4QqrIAL0Fa144XYs17Jqq0avq+v0DQuszxLcjndxn4ElvSldqltElTLuJyJYdtj2vfn+0txdwJi6tXomxC5bMVGTUEdTgvVpB23IMdpQKG7EBrnJb9p7Of8zmvt8aqvZ4Bngkp6V6cnofaYh/brSehxsw33WPlm0RPXDCUETpuz/syesmLrxqLdVyTqQBzkcgaKGZXAnu9XHIFCyFptdgXA50pTAwlInGcINBcz5uMk8r3tEFXUU6aLPz2Ly4YiiymdJe5KD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYo2EJzgFTs7rImlll9ZZ58EInhvPvHkB+0QHtewhV4=;
 b=VDnU1Gzprh1UQmlMiql2BnXogm7jhPJFh7sRi99tOCxcjc4fSSLmjgFUGcKJz7Smv8R6x0GzB8I4RznoSiInLF/wJM6wxwxvQKOMYZROoop9lp7l9NA2m7PVSk+An5luiUsPvkRiqgJBbOmPNqnvQJWUHHqX06ihDIsvF/JBjRMgNoq53zYJGRWnvQwYtoBEXTHmrosF34S2g3gdj0D0688AA2HZUNkzkr0gtMllYOkxQwEMwqle+BRMIpiKOfiMPq/PCRCBlpt25Rhac4DyDZ8U6IBhAlgUYRvU/TuPFS7Og0S8mbqa0CagO6YwuZWqkOXRZugQsAuQCllHDSy5oA==
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com (2603:10a6:208:f4::27)
 by AS8PR02MB7285.eurprd02.prod.outlook.com (2603:10a6:20b:3f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 19:43:34 +0000
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf]) by AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 19:43:21 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>, "rsbecker@nexbridge.com"
	<rsbecker@nexbridge.com>
CC: Git <git@vger.kernel.org>
Subject: Re: AI Textconv filter misconfiguration on Windows leads to silent
 corruption of diff output (ongoing investigation)
Thread-Topic: AI Textconv filter misconfiguration on Windows leads to silent
 corruption of diff output (ongoing investigation)
Thread-Index:
 AQHdKSpeW10CNT+9OEuLP9VqvpTkMLaYG2wMgAAB2zCAACCveYAAtQjxgCFVgo+AABufAIAA8rWAgAB6wmA=
Date: Wed, 2 Sep 2026 19:43:21 +0000
Message-ID:
 <AM0PR02MB4450D5755BA65E3C2CA324C0B3B72@AM0PR02MB4450.eurprd02.prod.outlook.com>
References:
 <AM0PR02MB445096594555DAD1D9EE1505B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB445083767BAE669D4656CA6CB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB445013B3CDAAAD361FD93A86B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB44501AFB0A97E2E097B8795AB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB445092119D0BA1921E2BAADFB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB4450EF826479360A3A262277B3A82@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <000601dd3a5b$3e4be8a0$bae3b9e0$@nexbridge.com>
 <CALnO6CAhXeADt+pZbR4=RaksmrXLtwtCXhnxMHHtAy3spuhptg@mail.gmail.com>
In-Reply-To:
 <CALnO6CAhXeADt+pZbR4=RaksmrXLtwtCXhnxMHHtAy3spuhptg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB4450:EE_|AS8PR02MB7285:EE_
x-ms-office365-filtering-correlation-id: cf0de73b-59d9-403d-b53d-08df092a722e
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|13031999006|8062599012|19110799012|15030799006|15080799012|51005399006|31061999003|55001999006|24021099003|8060799015|25010399006|40105399003|2607281247196008|31101999003|56899033|102099032|3412199025|440099028|26104999009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?0CusCzBC3t0ypBWRVkkfBh//x5jKP0hNRW0/BPuhx9vodM2YSz7ZgQ4u5c?=
 =?iso-8859-1?Q?dqzvpoVNWg2caDlvgskh+yHDqEhlAt2qxi5m1L1gpCr4lFW1fyat4YEwAB?=
 =?iso-8859-1?Q?x3dRfeeUdS9hRnMbSmnBmw44f068fS5+3f33CgzBSpveSqEaK8n84/3f9h?=
 =?iso-8859-1?Q?02gPlFmPRVVNyoY5FQoaultNWL7+K+b0pMMftvYcp3tuwRfPXnMZhpZXUy?=
 =?iso-8859-1?Q?fkxl7W86lnfIyCjbL07Uz92NooYtojFsX3vwhhz03diNLdVwl6b0/8pwFM?=
 =?iso-8859-1?Q?QGsTWs7dJoONm1Sw8Va+9zKjtZRto+hUK/TI5tGlKokav31QpvabZB+WVI?=
 =?iso-8859-1?Q?BiCKiXd9ppL6uzRQisQEsbtN4upPbUDdd3MgSQHeCSaK+dEZA7uyVd2ny4?=
 =?iso-8859-1?Q?z0WSwrTaNaTcbWyNMGi4tTnK6Cjw+yliOYzBTlWJpaKo1OpTak3VdHF78A?=
 =?iso-8859-1?Q?+YPJ6MNXxJg1CRgZIeGgy75TogELYzndOqLxsRwwVUvIFkFRvydX1DX3d7?=
 =?iso-8859-1?Q?AnN1RHwtBsUeQA8qCB/z7wKRSHyMzer6f03oh7tLLTQ334Nu4+UqbAyTSj?=
 =?iso-8859-1?Q?Gax4rx8Y4o7IMT7sy3Bl8yfOadX8d3jD8oWAyyiCgIBNsVyiWJN9dY9UZE?=
 =?iso-8859-1?Q?1AqzPg0fz9WoLtSyWbmNgUgVR0OttVhuQLsL2gAfjnzrspf3O1LY+971Wo?=
 =?iso-8859-1?Q?R3XUN+ZWKHqSwvLFKUSfQxLtklFpr9ukhJskWrbxr71vhCKDSnU54C9G6O?=
 =?iso-8859-1?Q?hZTZ9LBeUPridGunB7GhebvSCnOSK0HwR3lU8ZD1DrPlf9q+NjLSaRAdc1?=
 =?iso-8859-1?Q?hXxbxYlFDHSZjzRLgd9MxZqCg3i4HI7iy7PQ8zFRUN8IY2gRGhldf2UJ9+?=
 =?iso-8859-1?Q?UokyTRW0kCC7c7OesiZCYcP/1eRfVcrYKInvSninYbvJ6MTVjW9QoYbOER?=
 =?iso-8859-1?Q?NWyA/1HTeNa41EfCwwQl2dEFfJ40Nx1ACiMJbqBO8WsJ90bhuVJhbAKiDH?=
 =?iso-8859-1?Q?8644yiOhWTI8NLXMJ8JuLaXIY3fpxjwXDr/xE8VhK3nDUw1FkIpfBNtA4h?=
 =?iso-8859-1?Q?BptBArlEqalUKpn8kfGuW0EFxae1AO5StJcTzsnfW8XNePbrO0S3jcbGF9?=
 =?iso-8859-1?Q?FHwsNoL7wQQ06ThJqnkvCqZBf6Pzo=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KJugkYxAWlWqFLJwkzz8PwOQzNsl5oGkh0W4mZTdWKpMiHtWKL68zJz8Oj?=
 =?iso-8859-1?Q?DW+zG8Lli6x6Dkd15fEb8KLK7/0qPPNHBQ+ByMUU1JHbKQCLvW2KLhAcaT?=
 =?iso-8859-1?Q?RQFvBb2BYF4GB2KYPBIyLOLPBVkeC5mVrBYAEYB4OGuO+gmg4HwM5h79jc?=
 =?iso-8859-1?Q?wJdSwL3nYwI6zRUprYf1Wywc0cgChEdoZo1eJZb0v+i+TtD6/6953atCa+?=
 =?iso-8859-1?Q?N9TQmAcZyqyMQOiBd0eWkQo9musrahX0rsXXY0JmMb65wcZlgJaVaFEHHJ?=
 =?iso-8859-1?Q?x+w/T6hK1xB/VZQC7Fq83cWqDwCHHzY6y5kJM3ehRCo5HSRtG+diMIgyE8?=
 =?iso-8859-1?Q?HTUXyPk9jCAVQkIp8MNztSS+xmH2L1BkLcWClbFzYjpoZQIhgHT0qj248T?=
 =?iso-8859-1?Q?byak0QBLHrUjhmPxVx9fSiu2oFdofU9NTSCL6vqsJVCJnj42WhwYN2GI5F?=
 =?iso-8859-1?Q?BMxKKlqtZZaNBaYyQz8DCMe/f/qZUbFV8RkqZDQbb9CFwExhcLCfo9yxY2?=
 =?iso-8859-1?Q?Ro0JpNUK+aLeSfyX6Z5v2qw5KkNr3d+eJyfHe0tmCEkhS92qfgTvEbZab1?=
 =?iso-8859-1?Q?MmAwUeaOk4GI1vWpA2K35U3jtFEAVRvlcmwmenrcwDgMZvJFNSYxqJ1jMK?=
 =?iso-8859-1?Q?oFeb4IMK2kJNMIlw1MAa+ZJG0sxowxmL5LM4oZAHAOa8FuPke8YBvCutYU?=
 =?iso-8859-1?Q?TdjE84iEPy0gRpIwoHApJrbnq/2pmq3AiIvpDigOZv4A0pF5hLfpxAwuh0?=
 =?iso-8859-1?Q?JsmwNuPuf9fABqKwUh7keN69pQrUDGlRGquZCxsbJjPXRsagIP3MyLNqIR?=
 =?iso-8859-1?Q?Ky7S6GNhYsl4QxtFBBGoGtpvQt7fZqHS8CRRoUme2lSrr9hVjKBXM3ryu7?=
 =?iso-8859-1?Q?tBL3oQIbPkbk9YSFk3b3A3qrmtiXxl0J16TfGBLAQ6d2vR3ZU8pwfQ4dzW?=
 =?iso-8859-1?Q?LkTyQwVAhHG79Upou+04Yj8G+BHvC5/ALG/LuoM/c7pgtK9s3dwtQ3xjup?=
 =?iso-8859-1?Q?e0vhF3Sr6bRv4S+NmBL/FcGrUfInOMzq0Ed+XJOtr4bxmsR3cDf7tDWd0m?=
 =?iso-8859-1?Q?gcPEwTDsiVSBKlSfeEFw0q7RYt1Wv64EeZl4NXBKQNEwIU8kg8RLe5+E6g?=
 =?iso-8859-1?Q?xOjfRnciXlN4mwVEV1UlkFv4XU0hy6hdvXiFJEhI1uH5ejL6qT4hWHPZPg?=
 =?iso-8859-1?Q?kek6FSg/kiP6/UCPa5SmVo+5CsBXfMSlJrnrSv8wRHsZQ+mXK8XlryXyAf?=
 =?iso-8859-1?Q?gB+erEg8Rl+qkPv1kqJvpXtjludjNW46+7wt6hqPJvJZDksx6uOuJx20Gt?=
 =?iso-8859-1?Q?eX3EgcXCjBQYPZrca5xTgDkZh24rEbfBYAWDqMUwR2VOx/Tv1yn6AdaHYt?=
 =?iso-8859-1?Q?yu/9EABBcPNiq1zVgKbEsa8SLVhCP4wwGHsKAUZhxgBRbJeyd4R8o7t1sQ?=
 =?iso-8859-1?Q?Xv7dcvAAo0+dmbWkZEfD14gBbYsXsqohsVfJpWQ2G6eEdcEjVxLbRC1Ckt?=
 =?iso-8859-1?Q?s/aPLgUJwbI93+GMdXvQiJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0de73b-59d9-403d-b53d-08df092a722e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 19:43:21.8752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB7285

"=0A=
So as Randall says, don't tell Git files are text if they aren't :)=0A=
Using "* text=3Dauto" might be safer (allowing Git to decide whether a=0A=
file is text) if you need line ending normalization.=0A=
"=0A=
=0A=
Yeah, same conclusion as AI.=0A=
=0A=
But the real question is:=0A=
=0A=
1. How to do that ?=0A=
=0A=
2. Is it truely safe ? Or will it lead to further problems.=0A=
=0A=
3. I don't have time to read obscure old git manuals from the 70's about * =
and all kinds of strange rules.=0A=
=0A=
^ Thus I do believe I have a slight point here, the command line is ancient=
 enough already, apperently it requires some .gitattribute file and set bla=
bla * text * png * bmp.=0A=
=0A=
The whole thing does not make much sense to me, the syntax don't make much =
sense.=0A=
=0A=
* is in ms-dos everything... so using this in this way in git is bizar/stra=
nge/alien/non-intuitive/can't wrap my head around, doesn't make any sense..=
. etc ?! Get the vibe ?=0A=
=0A=
Also my 4th though is:=0A=
=0A=
4. Do I then have to do this for every possible binary file and tell git wh=
ich files are binary ? The whole thing kinda stinks... but maybe there is n=
o other solution.=0A=
=0A=
For now I have "better" or "other" things to do then keep experimenting wit=
h this dangerous stuff for something as silly as CR LF in text files.=0A=
=0A=
For now the AI advised me to delete .gitattributes and I did just that and =
will continue using a more or less default installation from GIT to prevent=
 any corruption which would be horrible.=0A=
=0A=
Yesterday I wrote two programs with AI:=0A=
=0A=
1. One to scan 68 repositories which were posted online to make sure they w=
ere not corrupted, thankfully non of them was corrupted.=0A=
=0A=
2. A git repo finder/scanner which scans my folders for .git folders from a=
 certain date. Thankfully Co-Pilot still remembered at what date I enabled =
this flawed git filter.=0A=
=0A=
So finding those repos was kinda easy. I found about 3 to 4 or something so=
 far. At least one of them had corrupted PNGs as well. (Doc folders)=0A=
=0A=
Two of them I re-cloned just in case...=0A=
=0A=
So far I have been kinda lucky to find this issue with 2 months and have ha=
d not too much git cloning activity... it could have turned into a much big=
ger disaster if text files were corrupted instead of binary files.=0A=
=0A=
Binary files kinda rare in git repos and with a bit of luck they don't have=
 CR/LF in them... Text files on the other hand are everywhere in git... tex=
t file corrupted would have been a major problem.=0A=
=0A=
For me a simpler solution where git has some kind of "list" of files, and t=
hen enable/disable...=0A=
=0A=
Maybe some list which tells git if it's binary or not.=0A=
=0A=
Something simple like:=0A=
=0A=
PNG binary=0A=
BMP binary=0A=
TXT text=0A=
PAS text=0A=
DPR text=0A=
JPG binary=0A=
=0A=
That would make more sense to me, without the * etc... why is the * asterix=
 necessary at all ?=0A=
=0A=
However I would demand a pre-made list... because this is kinda nuts to do =
this yourself.=0A=
=0A=
Plus, this is still not ideal.=0A=
=0A=
What if an application saves files in a known extension from this list, it'=
s supposed to be binary... but will be mistreated as text...=0A=
=0A=
I guess this is the risk with git after all or maybe not, maybe you have a =
point with auto detection.=0A=
=0A=
It would be amazing if git detects a *.pas as being binary... because some =
tool happens to use that as it's data files.=0A=
=0A=
So for now, I would agree with you auto detection maybe best, but why does =
this not solve the diff problem with ^M everywhere ? Hmmm.=0A=
=0A=
Bye for now,=0A=
  Skybuck.=
