Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021138.outbound.protection.outlook.com [52.101.65.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761071879
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641984; cv=fail; b=aA3RB8v6f3CyYKAmGDxssQPk3ZT0z2QmG3QNSy80X1r/nNTmI+7dkU/v/TpjsITnCDQlklms1QLYetUZhk22EctSbi3exdnE3GG3WXJ0nPSKffv3vO/b91OQvnoJzlNeBA9JisD34PabCnnPWtsFLAG+fiYZC6A/cLlJuoknURo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641984; c=relaxed/simple;
	bh=0mTWKeC8sKQ0hfRfIJIQRlUep5Edgp/e4ip1cZhaVEg=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PKL5h8LxEpms2XPdCbLHQBDchp68kbDsmgW5vmKC2ZCcdY7K+tQ9RA29pFmd1kKLYwiASutNtp5CnMO1zrhJ0VNHzExRR705CBCUiFjUOUVPm7G//OHyXwJeJTvfVOfQFH5iPdo9eJxF7xxuB8N7IKsfw1IOFHwiWgGMTiG+BQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esave.es; spf=pass smtp.mailfrom=esave.es; arc=fail smtp.client-ip=52.101.65.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=esave.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=esave.es
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWzkdvmu83PQUMtZ9W44TEcm+5fksnZQwdw9MSxvnMIuQr7ASCwACAZGLiqEL8nWwKU26hsINiuEeukM2jcd87cQqylf/GpVRys7ukwCx8bg1Hq/Ym0cc7Fg3PEXn4DHL9QWuxgcJVvC1vn26kmB1dlzAnUdbuRbOFlgO+Vft6KR6+oOsH2FNHU+jzjNtTlXagmhUJlH8VUMWIs6BC/yP0JiDlxBEsdjLx0/GjS2z2lgJlIeB+f+O1kPN5eKfF3VG3Q7Eez/ZiexLHRX16pZjZ6KitEs/xOScdYNpqk+4jE5muQkrBRZ5R9yylmBk2A69wmw+rhmFlASHNWUe24kmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/yDF+vM0zco0ZeUglrtMueX9rab1vu6jHWotDRkeuk=;
 b=oEpC6vdrqkfDIiBt0MVYwaZFEhTga3Qf0M8GP64tLzhvq0gow3+iQv5Ndxy3iaABpGiT1GxNg9r913153f7CLEbfDx862cEwwkmwHhr3s9ZT4ps7K9zxkuvw5535yfIR8PLNSdTtu98Q7iTB4X60dVnMPXwazSuwTTN+EQ887dSeh9/r1YdVKF0Un0NRU5G1TJA7uPdm9ecF6+YchLw2jOxjM4sR3CLRNYGy8Tl0/2WYSkXylvRTu+TFq15v0o0tDlyyusSE5b79rKB+2Fq2cMC0O4HUBe3B2fxjyXNbog1RmUJo5XZaGdRWFahTE+IHnUXimmjf6tTxzRnNSJ2YHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=esave.es; dmarc=pass action=none header.from=esave.es;
 dkim=pass header.d=esave.es; arc=none
Received: from AS8PR02MB10201.eurprd02.prod.outlook.com (2603:10a6:20b:63d::6)
 by DB9PR02MB6940.eurprd02.prod.outlook.com (2603:10a6:10:221::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 13:26:08 +0000
Received: from AS8PR02MB10201.eurprd02.prod.outlook.com
 ([fe80::90d0:ca74:2479:bbdb]) by AS8PR02MB10201.eurprd02.prod.outlook.com
 ([fe80::90d0:ca74:2479:bbdb%4]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 13:26:07 +0000
From: Alex Recuenco <alex.recuenco@esave.es>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git exclude patterns with full static file, without globs, fails to
 capture the exclusion (the file is added anyway
Thread-Topic: Git exclude patterns with full static file, without globs, fails
 to capture the exclusion (the file is added anyway
Thread-Index: AQHa7k2DK6imy3YhqU6wjBrIz5UJTg==
Date: Wed, 14 Aug 2024 13:26:05 +0000
Message-ID: <0A12CB85-646B-446B-855A-C6AC54A65678@esave.es>
Reply-To: Alex Recuenco <alex.recuenco@esave.es>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=esave.es;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10201:EE_|DB9PR02MB6940:EE_
x-ms-office365-filtering-correlation-id: b16b55d9-68cc-464d-8b33-08dcbc64a647
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?UOUxLe/tp68F3Hmcp7B28V/rxFSilP3cFVTzrxGZnzM642BhFeHgDdcAdY?=
 =?iso-8859-1?Q?8LpEo5RvFrIhLWdwRIbvWX4b6IE1w3ddgeMxA8v+VLwYt6WXVWI8ZwhqhV?=
 =?iso-8859-1?Q?RPQPFYvxZay2WLnhvSj0JPTDUT12vJV0bSYuirSnIw7E/GsB6uG0R++6rU?=
 =?iso-8859-1?Q?ACGkg6GmjGLkZYXFhNaoeATMj7X8OXKUq8TBGLUsAc33gtQRwRdGZ3qENe?=
 =?iso-8859-1?Q?7ljyKvv8bz7s0gheowAZpBjxYgNJ9ADkEuxfgKa4nUeeeREYDOfyVBOTPo?=
 =?iso-8859-1?Q?+NJleRVRuKdq3zBMPpmFLDcGFcCAGdBHGnFmhsl+eTg1Ivn6GWg+VNRX23?=
 =?iso-8859-1?Q?6sndAKGgNxoeCqtFxw9BYm2otf64oSPyCtzIuOF9pR3yG6NFjNhHL361rD?=
 =?iso-8859-1?Q?LLdbg58SBsvhDfpWnwCgYdn7NByenshjmXeKEBm5cpYRMp6bW9qA9qUFEv?=
 =?iso-8859-1?Q?7I87CxreXTveuQi8byG2/KXhu9qNwt/ItZraB4UayY16Y83WckBhL7wUXF?=
 =?iso-8859-1?Q?U/2F4mP1N8AIM0szUQayRkuYMeqIMqiP/K31Wbxq5PvN5nvJlfxu/g0BV7?=
 =?iso-8859-1?Q?hhRn5xBdJSpVQphm9EWjiO9AV0OLJLb0d/7CR3sZVCrfExGtXtdYQHHasa?=
 =?iso-8859-1?Q?+bgNauLLsC75XcnYgkZW/J4fgUh+boJbCVHZzgA0kbTKG1Zm/LetF6pI/x?=
 =?iso-8859-1?Q?VgfoY/r6X9JW9ftqdIOocnZ3UN2Fxng0LIWCbKtNN65UJw2djL9ekgDDr3?=
 =?iso-8859-1?Q?UIwiXNfB2rgH6ZcPrikn3gCiupPlBcTZRiGmMPm75WPewFU6EIK9OpG7vR?=
 =?iso-8859-1?Q?4iRRb/nvKYf2NN5EkxyILbgHyVcotow0f5GrrMGMO7CyWHr9KZ4s0goqpu?=
 =?iso-8859-1?Q?Q1AJkiJIi6fBxcSC6tpOxAavs+z16UtIROhXJ7c+5zzEiFzIg4XDCVrJNl?=
 =?iso-8859-1?Q?tnBSQDI/wX3cOVr+nxDmtdsI7p4SQsDmaTnpdCn4hRPpsXkROkbA5DKl6K?=
 =?iso-8859-1?Q?jNFu6bhinFDnA659v2TAU5TaXedpnaAP7w3op3Dlc1Cokm61CjCa2gm+cS?=
 =?iso-8859-1?Q?RUUPaD+XlhGDioSELGaKoQQtkck5Ka54wJShQi9jo8jNiPnuBBWXiBcDHS?=
 =?iso-8859-1?Q?RCKjQ68Te5XItJhYY1nv5aQOUjWupOLpCKWFRwCuLRJQt3n3R9kj0FkcOz?=
 =?iso-8859-1?Q?L6a8lXJhDJ7rvCkvP3QWEQ18Q/dt1HfSp7nKm7I/5zZklD63Oqw17ZQT82?=
 =?iso-8859-1?Q?fwqo4jCZQz8Uo0D4OtlrC1ii8srawRa9MLGiS0PvZCsjAdDqKDirZAXqt6?=
 =?iso-8859-1?Q?zssaSJAOl26ikdMBZfNABwKFrigDwGodj4PYoQtRBlew26yNsboZrJLnRI?=
 =?iso-8859-1?Q?jcOa58SHAU8DYuAHEWRLzJyJ0puToLgqYACIIJik4ebBdpRqAynm4AzWFM?=
 =?iso-8859-1?Q?c5dHxqfSGsuKiadyj8209QnXQrXvuTV/ishNtg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB10201.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+XQKvdndzv5twAQhYKqmIlRNPLzzTEDkuygtXeQNfOv3qLqVuy1WG2FBw8?=
 =?iso-8859-1?Q?SFMCreMf2P99zWLCx50MRQS6G1lLNw0X6lEhgmctYSBDRF+UnnMPpVl+8H?=
 =?iso-8859-1?Q?q13AAtorrmzEl5O45bJDIqhFi59dQqHb3/KCpN0Xf0ukwMU6LQzeIoXXUp?=
 =?iso-8859-1?Q?m6uAvri/CeTG0OUSGPy/0PpIyST+kM/7/EziTMXm9UrrCxLRCOob8/xEkv?=
 =?iso-8859-1?Q?8YgA3m8qfD9s92wAgXRmsEFeWRYgg1qx0LSr2Ny/JSDevtT38ajsR9I+kp?=
 =?iso-8859-1?Q?l92ZjoHZTF24FuJVp4fJuRE8MflZsxZpPPJELa+YRV7FXLe7TnwVRM3xAp?=
 =?iso-8859-1?Q?s90PxWFnZGya2eSfXKLZ+wh1aApR0nnmQtoBvsEkOLGNG9KllyiZ2gTD5J?=
 =?iso-8859-1?Q?VZRNM/2/Z04GhwX7g/vb1qRmzc1XV60oN57ZXRd4m0GFaKFfKI96lYnSZ1?=
 =?iso-8859-1?Q?NTXTaL5jJwBz9DHTXilyhIX1Ke8fhRAdsZ9/GYroDYBRYCh793xIa8Nrb1?=
 =?iso-8859-1?Q?HgWu3BHPvGDNuGxmEu1Wo+D/feMSSL/2MFn6euigk4LSQcXkHeNdPkHqSI?=
 =?iso-8859-1?Q?ETlvo9a73tccvnmQWCAu0grbz7KUo1I1jYeaGOpw7QvqSuhmOb9fpcRsnz?=
 =?iso-8859-1?Q?HRqHu8D/dKiQWaJ6bzD6KeBbbWOcYBEX3y5Fl2IYY4jYs493mVS1gS0OPm?=
 =?iso-8859-1?Q?t8GyXwCrxh3tpv84SHN7REIH+kjz6KLig5yh6oQeIDwx68IVw8BHR/DPHO?=
 =?iso-8859-1?Q?ZufaYvJxiybYwVfHs6nDtQbMTb2QR8Uohj2yl23ClVeRPkWs1KkcEv0tVl?=
 =?iso-8859-1?Q?g+UeH1e8Xz7ucR47YDuQxSz7ElknHCbTttgRocFE59xETOIQjzoM1Dif76?=
 =?iso-8859-1?Q?HaFowNZtQJGT1oV0AgCOBy3/e9zHyhju6WNYdmhxlwbad73LTmiiLbo78p?=
 =?iso-8859-1?Q?gL3Aeh6ohmP1Mw0aZCrocgjk8crjRFuN1k7CblWv5Q/bt/Uaa5EEg1jSbo?=
 =?iso-8859-1?Q?P49WbK33L2HHScCca4FYeI/KWsmG/UyuyrHQM0Eu1oNi+MhEY395P+waLj?=
 =?iso-8859-1?Q?swl/vg+Ugwv02A8MguqonRETTk23jGMeNInzom0lt+U605g7bg0twAF8J6?=
 =?iso-8859-1?Q?7522nY0Oy+YPCNZVBLSsxiiDVuqAWIwR5cjqX/vSrStqgaC9jE4GI5WUzS?=
 =?iso-8859-1?Q?HrxBFvUvRbA4OwocORr6zk4EooF0rDKRVhlPN2yEzrvb+BVfIEwg2xYe8s?=
 =?iso-8859-1?Q?EFMhJBrHmFiglFmiD+0MC0tMgUdt/4eFFYcjX3NPA242EF2uZlSiVBXix9?=
 =?iso-8859-1?Q?Xm5FOB2ucmkgJs48a8ircKsioY7/SC+c6THzSpQ/bppZcnyFmZp3lS0cXZ?=
 =?iso-8859-1?Q?nB1LfNsq2DzqqCjOfDch6eajPmVWP8vaL0/WZls51JhCYkLg9dlivyClRO?=
 =?iso-8859-1?Q?EepvIpqNxynRY8PTb2b+4vLlHhNeFGT2DvxdbbR/mmTYXqfCd444fuKOP+?=
 =?iso-8859-1?Q?CMRafyTZDegevrXL9oqOZokAdZa5gvqdP8+HRDWoNUW2/vfH7hrmQxILb0?=
 =?iso-8859-1?Q?PfZABtSXqmekpBgOOcMrEjs6lVeBhFU+1HCEJXYfK+jwsd7oE/I9yWvNXS?=
 =?iso-8859-1?Q?UIiMY0mqwEFu239CeD8if8XgjVxB4BCHxWhsbxEb+Qph5V4MdNiEOaBQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_0A12CB85646B446B855AC6AC54A65678esavees_"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: esave.es
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10201.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b16b55d9-68cc-464d-8b33-08dcbc64a647
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 13:26:05.1615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b0c15407-bb57-48e0-bd03-bb8838f1abc6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T6Ou4TN9o2pNA2v9Ut00QzfXUVEPvcB3i09K3AtC2hHt0I19zlZaAWVoUavOx8AzSTtJXfQJftzcpi8+MQkt0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6940

--_002_0A12CB85646B446B855AC6AC54A65678esavees_
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <80B7AF860449CA43ABDCEEF012FF5098@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

Good afternoon,

This was very confusing to track down, I can't find any documentation that =
showcases this as intended behaviour.

I reviewed the pathspec docs quite a few times.

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
I executed=20

`git add -A ':(exclude,glob)lib/power.rb'`

What did you expect to happen? (Expected behavior)
The file `lib/power.rb` is excluded

What happened instead? (Actual behavior)
The file `lib/power.rb` is added to staging
However, if I run
`git add -A ':(exclude,glob)lib/power\.rb'`

The file is excluded correctly

What's different between what you expected and what actually happened?

Anything else you want to add:

If I use=20
`git add -A ':(exclude,glob)lib/*ower.rb'` the file is also excluded correc=
tly, which makes this even more confusing



Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.45.1
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.5.0 Darwin Kernel Version 23.5.0: Wed May  1 20:19:05 PDT =
2024; root:xnu-10063.121.3~5/RELEASE_ARM64_T8112 arm64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


--_002_0A12CB85646B446B855AC6AC54A65678esavees_
Content-Type: text/plain; name="git-bugreport-2024-08-14-1517.txt"
Content-Description: git-bugreport-2024-08-14-1517.txt
Content-Disposition: attachment; filename="git-bugreport-2024-08-14-1517.txt";
	size=1323; creation-date="Wed, 14 Aug 2024 13:26:04 GMT";
	modification-date="Wed, 14 Aug 2024 13:26:04 GMT"
Content-ID: <B074E80F69DE224A80EECAF2773F8DA2@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQ0KUGxlYXNlIGFuc3dl
ciB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucyB0byBoZWxwIHVzIHVuZGVyc3RhbmQgeW91ciBpc3N1
ZS4NCg0KV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8g
cmVwcm9kdWNlIHlvdXIgaXNzdWUpDQpJIGV4ZWN1dGVkIGdpdCBhZGQgLUEgJzooZXhjbHVkZSxn
bG9iKWxpYi9wb3dlci5yYicNCg0KV2hhdCBkaWQgeW91IGV4cGVjdCB0byBoYXBwZW4/IChFeHBl
Y3RlZCBiZWhhdmlvcikNClRoZSBmaWxlIGxpYi9wb3dlci5yYiBpcyBleGNsdWRlZA0KDQpXaGF0
IGhhcHBlbmVkIGluc3RlYWQ/IChBY3R1YWwgYmVoYXZpb3IpDQpUaGUgZmlsZSBsaWIvcG93ZXIu
cmIgaXMgYWRkZWQgdG8gc3RhZ2luZw0KSG93ZXZlciwgaWYgSSBydW4NCmdpdCBhZGQgLUEgJzoo
ZXhjbHVkZSxnbG9iKWxpYi9wb3dlclwucmInDQoNClRoZSBmaWxlIGlzIGV4Y2x1ZGVkIGNvcnJl
Y3RseQ0KDQpXaGF0J3MgZGlmZmVyZW50IGJldHdlZW4gd2hhdCB5b3UgZXhwZWN0ZWQgYW5kIHdo
YXQgYWN0dWFsbHkgaGFwcGVuZWQ/DQoNCkFueXRoaW5nIGVsc2UgeW91IHdhbnQgdG8gYWRkOg0K
DQpJZiBJIHVzZSANCmdpdCBhZGQgLUEgJzooZXhjbHVkZSxnbG9iKWxpYi8qb3dlci5yYicgdGhl
IGZpbGUgaXMgYWxzbyBleGNsdWRlZCBjb3JyZWN0bHksIHdoaWNoIG1ha2VzIHRoaXMgZXZlbiBt
b3JlIGNvbmZ1c2luZw0KDQoNCg0KUGxlYXNlIHJldmlldyB0aGUgcmVzdCBvZiB0aGUgYnVnIHJl
cG9ydCBiZWxvdy4NCllvdSBjYW4gZGVsZXRlIGFueSBsaW5lcyB5b3UgZG9uJ3Qgd2lzaCB0byBz
aGFyZS4NCg0KDQpbU3lzdGVtIEluZm9dDQpnaXQgdmVyc2lvbjoNCmdpdCB2ZXJzaW9uIDIuNDUu
MQ0KY3B1OiBhcm02NA0Kbm8gY29tbWl0IGFzc29jaWF0ZWQgd2l0aCB0aGlzIGJ1aWxkDQpzaXpl
b2YtbG9uZzogOA0Kc2l6ZW9mLXNpemVfdDogOA0Kc2hlbGwtcGF0aDogL2Jpbi9zaA0KZmVhdHVy
ZTogZnNtb25pdG9yLS1kYWVtb24NCnVuYW1lOiBEYXJ3aW4gMjMuNS4wIERhcndpbiBLZXJuZWwg
VmVyc2lvbiAyMy41LjA6IFdlZCBNYXkgIDEgMjA6MTk6MDUgUERUIDIwMjQ7IHJvb3Q6eG51LTEw
MDYzLjEyMS4zfjUvUkVMRUFTRV9BUk02NF9UODExMiBhcm02NA0KY29tcGlsZXIgaW5mbzogY2xh
bmc6IDE1LjAuMCAoY2xhbmctMTUwMC4zLjkuNCkNCmxpYmMgaW5mbzogbm8gbGliYyBpbmZvcm1h
dGlvbiBhdmFpbGFibGUNCiRTSEVMTCAodHlwaWNhbGx5LCBpbnRlcmFjdGl2ZSBzaGVsbCk6IC9i
aW4venNoDQoNCg0K

--_002_0A12CB85646B446B855AC6AC54A65678esavees_--
