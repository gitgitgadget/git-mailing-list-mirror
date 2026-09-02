Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011027.outbound.protection.outlook.com [52.103.33.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDC0275AEB
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 00:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788308837; cv=fail; b=gQAUZf7IkTAK4zn3XKG4/1NkwFX+wDcck3Iu4p3EhhKup595F0OhznfOJZ7Z2Wy6t9zRMdbIgXdzClcl5tHUYbw1dwg0Yl5P9dFgb820OUx07EPubIJgMNgYskKmzp/uYSf75Y3rf81Pvycc3Vi6pOxPzfiqAWqBuEmlkjmVYsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788308837; c=relaxed/simple;
	bh=kBZn0RsvGxkqh+xiVka7pgq8HOGJIML/Iy6MtYTwLSw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KJfvP2Twm+FaMpJepMYDsvtUMeqtd1xRG3DGoABmsi9rj74z448qwYmU3ebZOT5V2Tv4+yl+T0ZbaRRlcM9zbln9o2xZSUczgcr6M3RAq8CP7nF5QhcAjoNXwQbJNvGWIAzeehQuNTO/C617oLMCvTFNOK888uO/gmmTrktqA58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=i8OEmKN5; arc=fail smtp.client-ip=52.103.33.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="i8OEmKN5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mcxirxw5k9TnzfT+gMI4PitHzQAY8jg9BP4vmvciFlmidZdaFRofge71gUuMuYaUY/FPB2I2ff2BiJgpY7jdXkB8e4Lkwb4oEeS2HSWAMam9+OJlH0ayDlheD50PT4QWi7nLWG+QuHZ/WeqZwOVvRnPKf9OLrs7K/KF9Ek51xsQBjAOOdsRZijzJNhI+g1VrbBU1743WZHt5RaTre0T2xw88+Vs/xaXrk9Gu02jzkVs+j1jpS1gXYusUdBucUYr4sLMy2gabWSKt6O74VLZpyoYyKy528R5DiEtvB2hs+J7XOkrMsh9TjTh/PVu/2narqaaoHyo8NCmujo1Jwf2eAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zx/up4K168Ylt/an3lB6rixgSoWdm6IgQAUJ8JJybZc=;
 b=PrUchjuJ/mq0PFBJeBx3Oitx6sQtCwWR2aEs2MWM2UAM67N180VTzlCWwzo9QuubinFP3fLeV7GKdbc+iHkqjJBDOK73LYFcLxvnXHQcILxE0IGsRa2yyZYTOeFjPpyg4mnt0Qx8bCVnWzFo50qLSSeY2M/D1nqWpq9cTGQQMLaWb1AVEY+/xlT4XC1T2gUHySZGbBuL2YwJ0zPPkrc12tLx6U7ihIDnFQKPvkGvA/TcCneHg6WEFOdgpqqij3YTzwaGb9ZH4+lwAcKuEIviF6kXohfkwZUHPVNa2qcBjhEmnCGW1cYH/jXSUAJVTa+QXDHHP4pM2MhkRF/i2q4ypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zx/up4K168Ylt/an3lB6rixgSoWdm6IgQAUJ8JJybZc=;
 b=i8OEmKN5xx/m3ZVeZEYn9uh4EamxvtJQet+GN4XqGr1qSCYpaq+Jy/wY34ro5q03mNmCMCeGGz06XFGZhRph6wCpXPPOZCa3WvTqCjdyK9azgJYG089TFG/QeJnxDWGEjPwyjH0hrjuVx7LDeDiP8FaAo4f8NGA+6B0DT3gX1zLrWv2v6ODm2qEn/J/vSbWFoXwttt4EOrknENZBG1WO20JxyxkWJiskOMkxY9KCT2ad8cJPq7DN4nlk9vATOIpga74WY/+XpmrZmV2cjkNi+ORFUoC/FBviU47tXSqOGj9BgMaBElTWSzv6scctJDPwtGVxzoDe7iUEYsmlXGGHgg==
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com (2603:10a6:208:f4::27)
 by DU5PR02MB10552.eurprd02.prod.outlook.com (2603:10a6:10:51e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 00:27:13 +0000
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf]) by AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 00:27:13 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: 'Git' <git@vger.kernel.org>, "rsbecker@nexbridge.com"
	<rsbecker@nexbridge.com>
Subject: Re: AI Textconv filter misconfiguration on Windows leads to silent
 corruption of diff output (ongoing investigation)
Thread-Topic: AI Textconv filter misconfiguration on Windows leads to silent
 corruption of diff output (ongoing investigation)
Thread-Index:
 AQHdKSpeW10CNT+9OEuLP9VqvpTkMLaYG2wMgAAB2zCAACCveYAAtQjxgCFVgo+AABufAIAAKwyQ
Date: Wed, 2 Sep 2026 00:27:13 +0000
Message-ID:
 <AM0PR02MB4450445A9B2889A70CA49D5EB3B72@AM0PR02MB4450.eurprd02.prod.outlook.com>
References:
 <AM0PR02MB445096594555DAD1D9EE1505B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB445083767BAE669D4656CA6CB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB445013B3CDAAAD361FD93A86B3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB44501AFB0A97E2E097B8795AB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB445092119D0BA1921E2BAADFB3DD2@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <AM0PR02MB4450EF826479360A3A262277B3A82@AM0PR02MB4450.eurprd02.prod.outlook.com>
 <000601dd3a5b$3e4be8a0$bae3b9e0$@nexbridge.com>
In-Reply-To: <000601dd3a5b$3e4be8a0$bae3b9e0$@nexbridge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB4450:EE_|DU5PR02MB10552:EE_
x-ms-office365-filtering-correlation-id: 67c18e59-aaff-436d-79c9-08df0888ef57
x-microsoft-antispam:
 BCL:0;ARA:14566002|51005399006|15080799012|15030799006|8060799015|31061999003|25010399006|19110799012|8062599012|55001999006|37011999003|24021099003|31101999003|3412199025|440099028|26104999009|102099032|40105399003|2607281247196008;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?8SxSY4BQceGOQVjQ2OnX+6MDmSSzpHhEKuYEQr3YynOtaGv98Dm/QPKj61?=
 =?iso-8859-1?Q?LpJxT9HPigj2iIAWDYaxZF7NshLz7nWjZlz7jA7BW0MNPP2F/ldOYM2xW+?=
 =?iso-8859-1?Q?Hv9D9mirfj/ddM+shf9DPYK6LHnPeedVtfdMYLGShHY4P6tR7tfG+XLOL0?=
 =?iso-8859-1?Q?qm7GfRiNy3JQ58i1Se2ZqzmfamDZQAiOjpXTv/bd1TfR8m2hNGu7NI3qR2?=
 =?iso-8859-1?Q?VLnMK184bowLrOEIaLIwlzOBf+IrmnRF4Po/t19JtD6rZiARy/nsXg/oR8?=
 =?iso-8859-1?Q?HWvtqWt5KDzgaD3iJ53L8eOG1CEno3FAbER7YdfqQkZXMCeoIxnh4a2M0Y?=
 =?iso-8859-1?Q?GJ5Vjman8VeXQlLfi2ue/1TfwpAxnCJsaGJy2NpKgaRRtX9qjal9LY2aRi?=
 =?iso-8859-1?Q?SuAS2UoasgrrYvh3BAspgM/4ht3sSvfZUzImMOHrytdNve4aqwGYLNmgng?=
 =?iso-8859-1?Q?aW3/ErsUzZqLNq355+x39hR+OIUx3bIjRiTlxhv75JQCoDx91vsugWviYz?=
 =?iso-8859-1?Q?vCTLTBTy1Ju3WnQgYwS551QCcmihcyWAVViX6NlPRqqWbLe6vdJDkDT90F?=
 =?iso-8859-1?Q?gkBKc2WOv+BXc83xzXjP/ZV6p9LLS75EyVkfh3ZRke1jjWfGxlKSc5tr6T?=
 =?iso-8859-1?Q?zQVC2WxsFyemckJ/UZre1s2++bgixju7ZAJOMN/ty4nrUYG1vNCIqxqFJX?=
 =?iso-8859-1?Q?h3t9ahaD3p8OmvLvCYXH2D1TFrzzTEyF+vPDmCfwVbiT5YgDwcU6cO5ybm?=
 =?iso-8859-1?Q?5GDK4dRsxKava1lhpM83kYx2WePZRsvyJbeXcmPhfLwxo33JL5xe/R4TTQ?=
 =?iso-8859-1?Q?DJlWMtnC+i95FYNU9vu/lVmo9LwPvZ0n/ubpa63wWK3y+zF1BAbkoxHYG8?=
 =?iso-8859-1?Q?7yVOaBCBRwuoTY9SwLNX8ETx/Bq8pfV1CyQd/MX01T8b8ipjYlqRfViPaS?=
 =?iso-8859-1?Q?EeqvEzNXXuxgEJCCgplDydQCZBNcGARvSNL4gUM8t7l8Pu6OXBG+TL6QqT?=
 =?iso-8859-1?Q?kOIy2Wwlzdom2zW8nGN8VfeMUG1812ehHimDgRjl4qLvWOdJ9IpvHBQ2bO?=
 =?iso-8859-1?Q?dL3TyXt622UViXEHEz+8lTwBHsfAygqd4dKGEEVdr1+8?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?TzJY1FVxFbmaoE3e4POEau/AbSd1ep7T7NNcK1nsPqK6JcAP6vTz2fVD5K?=
 =?iso-8859-1?Q?qLsmnbfEYycCggETZ0h9wga4vuC+dO0/IKyNU8lf1DtwlXJgYeaFPIaG5f?=
 =?iso-8859-1?Q?jUj6nXW8uCyolt3cAw85HINcZoBnFkkg2KlNy625spvIrGda+fPx/3a4NZ?=
 =?iso-8859-1?Q?/Q2gU5KBSjgyHR87BUTUqMThuHNkW0IbyKAMkjK/8ZHkDM/kx2X8ihHYFm?=
 =?iso-8859-1?Q?7/8bYC575ctRi+aWUbS5DNQGgPxOxT/RPXnf3USTfUyKiohpBfnycxnyHH?=
 =?iso-8859-1?Q?TWOXgUNNv4K4KCxGEq6J+cuH+E0KNQUexAOOQOllp9wUDKwMzE2PQMQbTe?=
 =?iso-8859-1?Q?JYvZdmzGbbZPekuGBp8vMf7IxEFGkkGD6d1Deb+7gCwKgzVtbs/nUaELGZ?=
 =?iso-8859-1?Q?w0qco3vp/v0Nw4Jlx8s+qJOUgylPDSE97ch9FFnBOVMiCLqvhg/N1yNS6v?=
 =?iso-8859-1?Q?l6cJfp+bqeReZpI0tQWc7fb0ZxpEEvqW0HJQ4wIrqXbc0n+beG0UXPx+7B?=
 =?iso-8859-1?Q?bLZnbvtFql7FdNbe3PB0+HPpIDaoH025awLS4g4VvcfmCgvH3SbtJs6edb?=
 =?iso-8859-1?Q?Q7U5/ZjWyV4EZQfZ4b2mFyOh5KrbOw1M5SzLS9CIiUyQXW0g0A8c3ZWrT1?=
 =?iso-8859-1?Q?ldgLoaTCr/jdx8brPDSOu7YQP5fNIeeQbsYWBB7WOxVQi6ylr1lZIJeIpl?=
 =?iso-8859-1?Q?EVFbiA6c58Q84vfp6ifYRZyzKYK1PWJV86hZxMDJLGS+ov9HDiZ/Lm930t?=
 =?iso-8859-1?Q?D1isnGbeKKSQgrHm58HhcmlNyH7gb51A9SH7Ruyg7smcvnRzJhKT8lQCA2?=
 =?iso-8859-1?Q?Mo+jVYbPrhfR2fDZv5/rmi6+awiuB+GQSfNhkcI4fApqJFLJ1EIOTK3kJP?=
 =?iso-8859-1?Q?Qe9NO8V7A6vm+eHrQuVgSn6Kd5pdz3HOmRs2z0kbNskKJPRi905xr6stbH?=
 =?iso-8859-1?Q?eGbbAM0JC6wwXdpVbsRlNzNLCPVMZvkNc9f7MxN/Wzxuhr9H+GbcZp4Mqs?=
 =?iso-8859-1?Q?511smwO12iaZB+87sytTgQ5o2SUGVy2CvAslUi0+G1jDT7LBLuxhUZmIXS?=
 =?iso-8859-1?Q?cA8MFt62bNXYhvsUlZYcYbK9Oz5ZDu79sNjtL68xu4WJi37AuPfKp94QIM?=
 =?iso-8859-1?Q?CaKBeoV7bDYzcggQ+lf/MKQ57ZDm0ksqCK5VPLpRvA4EXqWiICVBOgdR7P?=
 =?iso-8859-1?Q?JRylk1z1E2nOonM7Dzch3XKoTii5d7xmbQj7/AvkWHO9jS/5f9+tM8+VzC?=
 =?iso-8859-1?Q?1KTVgo/DMiL2+N9NyYW3Ist+FV3yFBHcBiVPSCpGGtTUZQqY19LZho+q43?=
 =?iso-8859-1?Q?6iLF5QNM+7ZmSYi/CX8qjTnMSqr8atW84VMK3BQV4OiFfDNUX+sE7t8eHy?=
 =?iso-8859-1?Q?/6b0xos/S9Lslx1FCJetZW9FrLqE0+O4HQ8aSdphkZ891zOQ/WGYnyrC9J?=
 =?iso-8859-1?Q?C9DRmNYq62WwaB2pM9rMjPXvXlB9c1Ku97DELYE8EwHpoCWdDu2gK/FTru?=
 =?iso-8859-1?Q?n3k0RRUC/8Sq+dfRk8290k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c18e59-aaff-436d-79c9-08df0888ef57
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2026 00:27:13.3769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10552

Hi,=0A=
=0A=
Thanks for your reply.=0A=
=0A=
I think we can come to the conclusion there are no real text files, there i=
s no real text standard.=0A=
=0A=
All text files are ultimately binary files, some are ascii, some are ansi, =
some are unicode, etc.=0A=
=0A=
Some have codepage encodings, some have LF, some have CR, some have both, s=
ome have vice versa.=0A=
=0A=
Some have BOM some don't.=0A=
=0A=
Basically it is a GIGANTIC MESS.=0A=
=0A=
This is probably the biggest flaw of git, assuming that there is such a thi=
ng is a text standard.=0A=
=0A=
Perhaps it's better to start treating everything as binary, and also creati=
ng, yet again a new true text standard ! LOL :)=0A=
=0A=
PDF, DOCS ? I once heard "top demo coders" use Microsoft Words to do their =
coding in. I am beginning to understand why that might be ! ;)=0A=
=0A=
Perhaps a new text format where there is no such thing as nil terminator an=
d carriage returns and line feeds, but everything pre-fixed-lengths or so..=
..=0A=
=0A=
This would also solve the "nil" character frustration you shared, thanks fo=
r that !=0A=
=0A=
Downside for this new idea would be text length limited to what the number =
of length bits can hold. Which would be plenty for 32 or 64 bits.=0A=
=0A=
Alternatively, Skybuck's Universal Code or another flexible coding techniqu=
e could be used as well.=0A=
=0A=
However, the alphabet itself is an encoding as well... Unicode feels a bit =
over done, with emotion smileys etc and other strange things, but it is a b=
ig world wide standard.=0A=
=0A=
Perhaps it could function as the encoding for the characters.=0A=
=0A=
This would leave some binary format for text to be developed which would be=
 suited for coding and editors.=0A=
=0A=
Editor could would become a bit more complex I suppose, to handle the prefi=
x length fields and can no longer inject/delete characters, I am not sure h=
ow code editors work internally, maybe a doubled linked list of characters.=
=0A=
=0A=
Perhaps line numbers could be hard coded as well... or inferred/counted a b=
it more quicker... right now AI would have to count CR/LF characters which =
might make AI processing more expensive to find actual line numbers...=0A=
=0A=
I wonder...=0A=
=0A=
Plus some code could also be stored in "line number segments/ranges"... lik=
e lines 51 to 56... and perhaps line segments could be stored on disk direc=
tly, even randomly... and could be stitched together later sequentially for=
 rendering purposes.=0A=
=0A=
Historical changes might also be kept a bit more easy that way... like some=
 kind of diff form... so I do see some potential for this...=0A=
=0A=
Bye for now,=0A=
  Skybuck.=
