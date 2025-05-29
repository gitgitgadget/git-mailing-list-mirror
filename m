Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011031.outbound.protection.outlook.com [52.103.68.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7739D39FD9
	for <git@vger.kernel.org>; Thu, 29 May 2025 14:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530628; cv=fail; b=jVD56IGecfY6RHvQd/4kDXq0p9D+cbuBYpoMBT2d+1gHMGdB7x1A7fBQAWMMkomC8SPaQnl7Aq/9/Hrn0SjNGhRl64JkvR06qtWDQZexoRVkwg92ZPCDU4kuZAXuWnKW95YhvIYDnTuBQtsj7bKP4Ey7Nr33JpE0F+a4ZfNbLkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530628; c=relaxed/simple;
	bh=TCYBJ68peD+/jvW86qvoVGs3Kvt0L3aAasSdfoaeZQI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g5B2bsnRb8tD6I22mr2x6/HzHFDa6OTB9ejPNjW9BlwTShFzzJ4u8g8R2Z6Xl1tJPSo3WINSxMOdPK70FXwy8Alj5gly6UDF1H+3rMa0aiXWip6pXpWZ3NLmbVskwABZCb+SiFDjhV3zi9sot/ZJCCVKRclyt70sZezkdGrvGwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=RQfbW9IL; arc=fail smtp.client-ip=52.103.68.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="RQfbW9IL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu9b3tfDN50miXpn/ZibevalHWL34ZutphKw7MRKv4Y/SUXh1j/xcTT2yM1qi90tU9B25c7ZekK0XKukBp9uZnFIsCaJmkhKODr5ZIBMXmjNeTyLgzgqkHy49uM+xUjPkGSocqUpERUoAn0Oxb9M6rDrgWpfZanTp92iQWCtNe/wRr2urq6DyJSP7FqyJJcgjHe2SAO1mBj9vl+wE6e624Pv9kEKwcd/ogFqX5dHv1Rr9jLwjvmOFZW2eRumWflCDcC1Yji3IwakI1vxRE4BHtebPJQlXRY2lUIwiLsrhXLa16JBRlwq42lXaoN/fsBXIW3D7TYTpOS2I/Fg8mpKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CS3AZeVoxIIqWejBwep0VDWq4qfo3xVfCO2N+ylWw0=;
 b=hoLhO2fPa6ekiGnqXv42i/2B79/90Hl6au/uZpdZomwu5g7rcKY1tnqpgGyA1C07eU4PFS27ZxswXKg1/jGsfDq/51jU/K833znJUT1/WaCm7zSeo5oMFuz44zSYj+RTM9Qo1vN8kcOv+fAGpFIphyNfyuW5TBxoJZSFzizOZmhf+qyVeE85n62IDLVMTtSFnQ+kI3TkzsDaBF8zp4DWb03fa3cRV713HTFCmjhCHD06Hvwii7yw296BvXgxHnTNZsASvm1m2vywRr6dmwqLE9/PA8LLqUmUlC/SQgy2B5tFSRD0tdVAfaU6C6SmYoyq5uIKidcDNVywOpOwO68nbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CS3AZeVoxIIqWejBwep0VDWq4qfo3xVfCO2N+ylWw0=;
 b=RQfbW9IL3fHKo8ZuHIiGniagOqNfrpl6zmjvNS5Uus1RTSlkKZBGdLP1QJfQ9DBmkRiReg1VJmEdVKDmq7w/F4NHPVK4sJNVAckM4bKY6QSiEV7rIm8ZnaUNq6hlfNhGAdaN8WwLJQ4LELnYso2nHsGBZYHyo1Xt0hGe7wzdFkb7I0NV16xMGaibhnyM+c0y7WA4P1hG95nSu+Dw1v0OHD93YjcEmJbRrMAQAy17fIfbPZL24tmrIgjlVQm+NLF5OFaZqXW3cq9G6HUrH0hI3sOphsBf8XyIR9QQtGjYDWAYdnYgxI2lYhVsQctcrzCVMbQvsnN7piVQqlLQ+53s5A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PPFD2CE7FA6D.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::54) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 14:57:00 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 14:57:00 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>, Zi Yao
	<ziyao@disroot.org>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v6 0/2] send-email: fix threads breaking in case user edits
 emails and improvements to outlook ID fix.
Thread-Topic: [PATCH v6 0/2] send-email: fix threads breaking in case user
 edits emails and improvements to outlook ID fix.
Thread-Index: AQHb0Knu8JOh9tnqvUW8j3NBF64dFw==
Date: Thu, 29 May 2025 14:57:00 +0000
Message-ID: <cover.1748529954.git.gargaditya08@live.com>
References: <cover.1748274404.git.gargaditya08@live.com>
In-Reply-To: <cover.1748274404.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PPFD2CE7FA6D:EE_
x-ms-office365-filtering-correlation-id: 99b9169d-6019-4c7d-d162-08dd9ec110f5
x-ms-exchange-slblob-mailprops:
 5fu/r660v9PcXSQ/czQan+5fCOfJxmE94kE4fNhOiQEia4poC57CnrefmTSuG7Z7CV12SQdDVeSN4B2gD1H2t5dirfDE4NMZdvMkWas6JWcHuzK6NUWIXY/stXo34WBmjcKOuEqhVShpDw+i3z0AxJrkGgjVfESxgBpYCEQpZKnFSyh2xbSYVCxV5zllxACrijaMHTS5rliNNHsUHlUAI1wP5HuD/OAI6R78Ai8itXpgowt7vcQzM/Ep9+UHGACfFTDXcX57R2w4ZrfiJXHD3FSJbZDF1j/ym6bBLoaHpY080zUuH4BSNVDkioTmUFFbF+1VcvYVFNGS//u2MM7wvhJwTlVX4BuOuLc5ZrF9I3mtljqA0dtjN0SxZJqwIE+rQeZz8aXNRwdN6WMSiFINnsrcXtAdUnjwhJ317/vfFWt5jxp7dY2kZIsbbRoXup9D+W9qquwDc2yOYnkMYMJcBTRTRFKjsMv0tBhRC4HnFAZbPACNfzR3MfKABoGBGltKE467iDfg1zddW52fJVS/TSJ/3KCtbCXzkyXqo+PQrcU6+nrHRZBZesaTUSa7ZMfHPloJXx+fsixwrZsYMshErwUF5tTYh9WOQ2+Km2EdbjhOWMdV7gCWTAsMF5XJ8PwczUCQg7LVeuL+CkVmpIv0zF/f+pknqu48te/4BDCUVQ1I+GOV99GRsw9eS5yVLGm8ZqSd/kb2RmWy1HbDwXFKepgoP5Y+O0SOB0W3TN7PsTI=
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|461199028|15080799009|19110799006|7092599006|8060799009|8062599006|41001999006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SIjJ5/kWu248oyi5gsJhQnXHlue+7Vy8vGRuC55GkIzhwUHTTG9Lj88v/K?=
 =?iso-8859-1?Q?NM1yGHXHbCT56icywLsCxW8apuG/Q6MGD1RC3y4c67RijDW75nopFxncYR?=
 =?iso-8859-1?Q?RsgkkvkLWI5ufSv7wwX8Wr2gQYeSGdHwsutTGEleeKYWHH9oCokFophZ9N?=
 =?iso-8859-1?Q?HpaV17uBxVdY9VAzgSL9ZPT9oeBYJIppFGXusMWpX3XtM6bYEbBIu0/3Pa?=
 =?iso-8859-1?Q?OGiAah2eDdHuPB7DrqJaT9HjuNo9LrG8Ta1BWCA2PzL0VLvK3Ylsq/Ylze?=
 =?iso-8859-1?Q?nS1o8F4eueyCCmSGw5RJBMQEum9WWk3DNaXP2mhPuLBvJEJkYbbERKvuy/?=
 =?iso-8859-1?Q?22+kMoxl4a/bG40IYvFp+gxNSCOX5RW7u65TaKiCHVPmu3Kb8HFhLwm5Zk?=
 =?iso-8859-1?Q?rOyS9jQpNF+1zu2Hm9/Lr/JNjlsIKICJlHCP3BgjbUDaqHDgmgjZwsj/dV?=
 =?iso-8859-1?Q?03jXX/9j/EvDFmbZJndX4RACqL40XUAzlL16AlO0UGsOW+2ZLbrLfYqS0q?=
 =?iso-8859-1?Q?p6D2gBW0ydawzvYoqhxutQUyAY6TjBvdN7w1xDG6pLq7vUVGz9qGkjMqiQ?=
 =?iso-8859-1?Q?nn/MxLlITEOjWH2lgxHd+wW0TXKKnuuMTCl5MCflU+z4oX4tO8NuYW7g8Y?=
 =?iso-8859-1?Q?iZoQzdBnA/UWNmYkOpZzS/oxrlZc3d89PmVq6/JM9ucsi17YhkzGQZAGxB?=
 =?iso-8859-1?Q?VG6SkBuUM+oGjz6r6XMsVyuC+ap+MDBaZMxXwHX+ATnL4q47MGm5RwtD47?=
 =?iso-8859-1?Q?bQ6/K+zxGTWiO6mqw5Bf0xjReTlJkXV0b2qmI5cxyF5Eabpg+RNiOs2oPz?=
 =?iso-8859-1?Q?lyu2waZh3wBsXxtKtXa3ufcrhSLWSwl136CUYZK8GIcO2mAjxcIlEKFYTj?=
 =?iso-8859-1?Q?OWP8dqYtjrvWvlsYIxJHeqZ+c5+vRwrtORFRbPs5UbP+v+YSBAuAyegSYx?=
 =?iso-8859-1?Q?Px+0GIZoMI0dvrPJm5KkpQJhqNik51RMIhiYSSRUaxpFJMYu/bUw/41FEn?=
 =?iso-8859-1?Q?ZHtBjyqzZBarE4o6Vn/Nx9p+mRePttDGzbQfIo9YoBM/NujFbxNU9qaq0U?=
 =?iso-8859-1?Q?e6S10s7XmhiUsDTytEAfW6uMSbHSooyDoLul68nNuRM/1Y6aFy+vyWBud2?=
 =?iso-8859-1?Q?2ugtOy20OxsW3XvCq+QfbSFViKPE2o7TKVz734BDMiR9yMi/QGP+Na3zwb?=
 =?iso-8859-1?Q?DIvooQBmxwZ7X7CbXYXsqFqC40j2wXaG+PA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?tKse6t474f51tjUU5lKp1EsHGhH8yd9Cae6SVAzEnMD/GjtjftXYuB3U1u?=
 =?iso-8859-1?Q?ADrTDFvBfj93zLpg4/RwRwxl6pMbaL9P8cYcRR8ZhYN4EjVDZxe676d4Ou?=
 =?iso-8859-1?Q?aOpOMkFAydfnvIxDfYOogQscn679/iKAE/8ITsJDsjX3VV1i3t4qrwWmtO?=
 =?iso-8859-1?Q?bb98CYeGkfO7AZx2ML/ruTJ9dn2zlBBl2rd7utawyzID9Ry16nxCrZ64pB?=
 =?iso-8859-1?Q?shUf716ocH5oYa07XyALwHscjcBkzlLc2DgdS6v0rPQjASqc+hxORMvCiJ?=
 =?iso-8859-1?Q?QIq0+7KjWZ2rExv/fUupEQdaMs1UBH0nFAdBz2DGlgxS8ytEXCQNjUtHhR?=
 =?iso-8859-1?Q?i9OKMCYWb47PDXsvW2CiY2jOu07Uw7YaK46e+iMGsWSFonEXm4pYeLdGks?=
 =?iso-8859-1?Q?oKY/JJms0bh+v0O3gBSHsY6YjZJPlpxjI7te2wljrbvkDuGWX1JCOod6GY?=
 =?iso-8859-1?Q?rec5b9dHeImBU7KJg+PSNzLMQla+TOAhNPfDnMMi04rHCnXYwQPdzIwnFk?=
 =?iso-8859-1?Q?iiir/cLFU+VLPbPkwON06h+WG+jL+45tnYRbJlWLJMyd+zFAbP4+UbfX5l?=
 =?iso-8859-1?Q?ZjAA/UUUO48N7tOGBeMug10CiALHjvOxl7+KhiRtJOHUhn3opqkyTg/pnw?=
 =?iso-8859-1?Q?zABML90pKgTT3s3HaJLW5Zp4gxnaThUgF1KQGzt9yGOYvMaN9qllcggoyS?=
 =?iso-8859-1?Q?kEYjh+aW4jpXFBO6/mtbXqCGJYIgPVorC0fRY5/VQh8z3Vf3LEGAEuop8r?=
 =?iso-8859-1?Q?O/GAlyqb/wt5/hABRyRbQhq7C61BQ790O9QmgIuaNGIg0jw7d5Q+QSVdYj?=
 =?iso-8859-1?Q?pQR1GI718CTBu/zjxlBLUqDtybaiF0GoUhWxLjcqVdimXGe2SMM/6R8ZHp?=
 =?iso-8859-1?Q?2h0gxg78mml2YxbtUkO4cs1KlHNLtXwylwrcglM3YBxLwXnnv5+bzHqifB?=
 =?iso-8859-1?Q?Cgmcb01Z5wwyQ4I35bFJEP0fvl1FqEmbn9em3MLcW7v6/sF3ughBQ+gdto?=
 =?iso-8859-1?Q?d4utPqLPOsibCq+ZRH7Gv0ndodreIupDsZge7ojyRmK0ltmUs+Jx4nBZAd?=
 =?iso-8859-1?Q?ZgFvdMLj6g980tOoinPuNWYKk910E/DtBgTQV3WWujblKUI4X1FtgPHokS?=
 =?iso-8859-1?Q?7gmG3EqgsElBqabisPJGUlZpOLF2tc9QNRi/ft3iiNJv7VL3aQw88vcxML?=
 =?iso-8859-1?Q?oEC1SHxZjZKusqkjVdVijzwKJymtusOkybcXZX+iPTia0VRKJKAzgcnZhJ?=
 =?iso-8859-1?Q?TA/tJyP4WT5aSXU7JdFyt4LMwLY+fNTLyfKNmhAl4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b9169d-6019-4c7d-d162-08dd9ec110f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 14:57:00.6774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFD2CE7FA6D

Hi all,

This patch series fixes two minor issues with git-send-email.

The first patch fixes a bug that caused the message number to increase
when a user edits an email. As a result of this bug, threads would
break when a user edits an email.

The second patch improves the logging of the new message ID assigned by
Outlook when a user edits an email.

v2 - Change the bugfix logic used to fix the threading bug.
v3 - Add additional patch to improve the logging of the new
     message ID assigned by Outlook.
v4 - Completely rewrite the commit message of the first patch to
     explain the bug in detail and how it is fixed. Also, add
     example logs to explain the second patch.
v5 - Fix numerous spelling and grammatical errors in the commit
     message of the first patch.
v6 - Change the subject of the first patch.
   - Prefer using "increment" instead of "increase" in the commit
     message of the first patch.
   - Avoid decreasing the `$message_id_serial` variable in the first patch.

Aditya Garg (2):
  send-email: fix bug resulting in broken threads if a message is edited
  send-email: show the new message id assigned by outlook in the logs

 git-send-email.perl | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Range-diff against v5:
1:  5103ea4034 ! 1:  d965439f76 send-email: fix bug resulting in increased =
message number if a message is edited
    @@ Metadata
     Author: Aditya Garg <gargaditya08@live.com>
    =20
      ## Commit message ##
    -    send-email: fix bug resulting in increased message number if a mes=
sage is edited
    +    send-email: fix bug resulting in broken threads if a message is ed=
ited
    =20
         Whenever we send a thread of emails using send-email, a message nu=
mber
         is internally assigned to each email. This number is used to track=
 the
         order of the emails in the thread. Whenever a new message is proce=
ssed
    -    in a thread, the current script logic increases the message number=
 by
    +    in a thread, the current script logic increments the message numbe=
r by
         one, which is intended.
    =20
         But, if a message is edited and then resent, its message number ag=
ain
    -    gets increased. This is because the script uses the same logic to
    +    gets incrmented. This is because the script uses the same logic to
         process the edited message, which it uses to send the next message=
.
    =20
    -    This minor bug is usually harmless, unless some special situations=
 arise.
    -    One such situation is when the first message in a thread is edited
    -    and resent, and an `--in-reply-to` argument is also passed to send=
-email.
    +    This minor bug is usually harmless, unless a special situations ar=
ises.
    +    That situation is when the first message in a thread is edited and
    +    resent, and an `--in-reply-to` argument is also passed to send-ema=
il.
         In this case, if the user has chosen shallow threading, the thread=
ing
         does not work as expected, and all messages become replies to the
         Message-ID specified in the `--in-reply-to` argument.
    @@ Commit message
         greater than 1, and the whole set of conditions is false. Therefor=
e, the
         `$in_reply_to` variable remains as the first message's ID. This is=
 what
         we expect in shallow threading. But if the user edits the first me=
ssage
    -    and resends it, the `$message_num` variable gets increased by 1, a=
nd
    +    and resends it, the `$message_num` variable gets incremented by 1,=
 and
         thus the condition `$message_num =3D=3D 1` becomes false. This mea=
ns that
         the `$in_reply_to` variable is not set to the first message's ID. =
As a
         result the next message in the thread is not a reply to the first
    @@ Commit message
         variable is set to the first message's ID, and the threading works
         as expected, regardless of the message number.
    =20
    -    Just like the `$message_num` variable, the `$message_id_serial` va=
riable
    -    also increases by 1 whenever a new message is sent. This variable
    -    displays the message number in the Message-ID of the email.
    -
         To fix this bug, we need to ensure that the `$message_num` variabl=
e is
    -    not increased by 1 when a message is edited and resent. We do this=
 by
    -    decreasing both the `$message_num` and `$message_id_serial` variab=
les
    -    by 1 whenever the request to edit a message is received. This way,=
 the
    -    next message in the thread will have the same message number as th=
e
    -    edited message. Therefore the threading will work as expected.
    +    not incremented by 1 when a message is edited and resent. We do th=
is by
    +    decreasing the `$message_num` variable by 1 whenever the request t=
o edit
    +    a message is received. This way, the next message in the thread wi=
ll
    +    have the same message number as the edited message. Therefore the
    +    threading will work as expected.
    =20
         The same logic has also been applied in case the user drops a sing=
le
         message from the thread by choosing the "[n]o" option during
    @@ git-send-email.perl: sub send_message {
     +			# the next message is treated as the successor to the
     +			# previously sent message, and not the skipped message.
     +			$message_num--;
    -+			$message_id_serial--;
      			return 0;
      		} elsif (/^e/i) {
     +			# Since the same message will be sent again, we need to
    @@ git-send-email.perl: sub send_message {
     +			# different message sent after the original non-edited
     +			# message.
     +			$message_num--;
    -+			$message_id_serial--;
      			return -1;
      		} elsif (/^q/i) {
      			cleanup_compose_files();
2:  6f2668de07 =3D 2:  caf46596a7 send-email: show the new message id assig=
ned by outlook in the logs
--=20
2.49.0.635.g48fa2f4343

