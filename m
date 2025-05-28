Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C01F1311
	for <git@vger.kernel.org>; Wed, 28 May 2025 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414387; cv=fail; b=CPBH3UPviAJsopVXm5F+nZFFevXPiPawBNNSadwopgxh1cxnqyiibZW5PyqJjU+toht21ddi5djHymVCgYiypeG3Ycs4Ad29OTLky51hrqRuJPodMPoHG9SqSq670CiINPzB03Kz9BZwfBOtI2bNqxXRACmks6T2vDov9bjEZoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414387; c=relaxed/simple;
	bh=9+ps83vVJPsP4gm5uuFx9Ob30xOniHSdP3yuumqmVMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RYNPYBF1YWOOU6UY9rcz0gYWVa58t/Vau4jtqwTLG1lsqydEjtiJwK4CyBciaxdKvZE6XdzZodqa1Y2qkwUqdSD+K2GkMm2i7F0JWNr1JKOc4XlW9DaihZjFgKI7t1+HfcYZqcL9iyIZ/sSp0djdcGOVJn4ivyCBcCCNf1XMldg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=gbiJZyqi; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="gbiJZyqi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYQ6erw1+PgeRXLyhh2Kz+Qx3Wnv8ULO5hoyLfbjDSb3KON1LHrzRqedTkcUia641kU5PqojzndIge6/VUHC+TapJRLZ2/0mJyxoo/cF+tVz42Bx258kiWl/TnYLBgUmOhidJ1jWaTQ6mIA2qHstU9v4xKyKf32UHPL0zUbno6oj7MThtWKNxODJ+v0uZYthUjVOhLy1u/NvXHWMxiVgLi/Pa9R0T/9kPwy/tthBRNrw0iqaEFvc4yctSk+AoiHM5TxMNQM4kxYBjEL0pR4Nhjn7HUgpSIVsxa9otmii0TGgf8zhZ6nTJTl20yKu06SIgVJIALArzTBa5+XvKMwJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QicSlGZDIhv3UlYTvAHtk1RrMl1DEJC7TTysKxdVCAM=;
 b=ny+th/cjAmBg7Iy2Ko5Xlg27PfD4iHwTTpehFrX2hOk8Id9b7a7aoZWl2QW2SyZU3/PP5EwHGtwrR90UnuK25EHEK5a1ukZk4juEVW/PwbeKHkPzHWckZc202mpMfWJrJ6t3Be/ehNCCJjtklb+2E2wX+NtEtrHIC3+v5S7saisT5A+JkU1OMaaGjsPEH7Cbj9ILivjKZ3mtsrJuV0kGOk/A+nPC5Q9GOEpQXukUgo/yprK9HbkRgbVjAbQRDeGJG4uEqLRRC/ktzK0eFDlmPAC5VHVVn0W5TBrqHwqagXPElK/xQ5uqufTi9Axx9w//qA8WVKNGsEn9FIeUTwoOhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QicSlGZDIhv3UlYTvAHtk1RrMl1DEJC7TTysKxdVCAM=;
 b=gbiJZyqivDSp9ETFhNZ4+tulwP2C0RRm18+PcG9NijZQy4ESg45GEzb6vujrO3swgcJ6a/BsGm9AIf59jld9F1l8kY9XaE9yU1DpIukEoRQBoZ8E29qCQh/QsesueSnfTOSU8JbCpchM5RRYMUHqNLc5JYz530CtiTiwVkRus7oBAei/NRwKxUrMIeFP5L1wo7Z3ZfkCTwqGYe6slEawuSW9z6bFVvjsK/nVwOZcNVy6f5Xx+8UUnooEbXbaB2T/+3yv6ouylzIeZ79wqJNh+SQX6S2JkUmD10FE5Liut0XEJP+L4PS3m9KBPnAxSsCbdp6l+Ta8kaNS5j9oklTt8w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PPFD2CE7FA6D.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::54) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 06:39:35 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 06:39:35 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Jacob Keller
	<jacob.e.keller@intel.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 2/2] send-email: show the new message id assigned by
 outlook in the logs
Thread-Topic: [PATCH v5 2/2] send-email: show the new message id assigned by
 outlook in the logs
Thread-Index: AQHbz5tGmC5dsF8sO0mp1kSAaWv6Vg==
Date: Wed, 28 May 2025 06:39:34 +0000
Message-ID:
 <6f2668de07ecd1558888f382ef5ebc8b8bb10f51.1748414082.git.gargaditya08@live.com>
References: <cover.1748414082.git.gargaditya08@live.com>
In-Reply-To: <cover.1748414082.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PPFD2CE7FA6D:EE_
x-ms-office365-filtering-correlation-id: 8aa6c5bc-be37-494e-1ba8-08dd9db26925
x-ms-exchange-slblob-mailprops:
 02NmSoc12DcHu/Dr1OK6cqcYKvfIm6M5e+i3ByPbHt6kKOTHN4U+3NtuQRcQQvMPfZNafs3bib7+21kb+pMt1R82V/9GDa8/blFZYt06AsJezmOxe3RLRDCypSjwbjgDWpOpxHlZpFphw0YV5BGQ0XxXHdL3ZlsB1j6gyeJEw+PVQAOoM8qjtKlkhenkDe+NFbVC3cZOEBuXwQhMOYqSkANDI07ch2Zo8mjP1j0jb+URzkG7EyebTC6Lcz3AqHQgygRuTHry16UBc9r3ERUiPF2nkZdGmiIcWXkaZpZzRvNvWqQdVFL+FnEJXtgYUctqpQdFM9w81dt26mI2XYB5OLxV8t+YuOe0oOCC69o0gsRdV/DkMWQtUUDWqzuamoURWaqZC2TVoKfOHwJfflgXsWlJymGw6rtjmprWawxHFrIGIcJJNGkVk48UhqIYbml7QfN4AP2nTYybSrp39V9m04vM6JmItG1MlmRqFMcUq2IPRoRz6WMr40msd0fnqhF6A7b2wiuJCzJIZXrJZBfaQvYGvFl6sm9Lg001JyFioX1FkPygYsFxRJXacUsbkDwAAmTldQuEGajDEvwkkXlZ5YLsiw7e5nPJlC5aexpXxskCybgz1yChBjmQ7XkVVBUGwvvPsHbH1ygJ2r7QRI9KU+xVyPhGsaWSrUIdGPVncRaMBJ45C9UDxeXSC3n1GrZ8GpAgdNkJxw/7i7Dx5y7lC2YMJj15hij59N51/fTODLSLVnnm+0M5YMew9xXSfDqT
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|461199028|12121999007|8062599006|15080799009|19110799006|7092599006|8060799009|102099032|19061999003|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ysJp7KQj/ZkPUsTb3ww0WFqfL7/shyE9HiEEJd71gbTDlptbgj9+Krbpia?=
 =?iso-8859-1?Q?d3POcxUG9JWxpDEPozwbTwHOyC97LYJv4gNd96nvdlIAXBkBmeYu/XrhNe?=
 =?iso-8859-1?Q?w5jsi+qzb1wd/uNwSVdDjOB+pmT9bJdU70kUNm02Xw1nk4dSubhwUVlV+g?=
 =?iso-8859-1?Q?/3SYnaJQOgJFJTeuLw4fkjeQJNLpwZFmxh5CU2ZQJxpd8bNTZgBPWmvd10?=
 =?iso-8859-1?Q?Q2Gz+Tk4p0diqt2eLgO9xHP+BtQQ/Td1GjATPkPdSRd1zJn28tGaaadoW8?=
 =?iso-8859-1?Q?t8OhSQ9ixDaYvad3aXzyS70/KzaB2rFc0qLeyRDTDth7KDMfG86ZGJmNli?=
 =?iso-8859-1?Q?rOCCxvQi7rCPHa+ApASDMtQTqUftWbd5F+IwmePpOpYQOMeBF1Gx8ALurq?=
 =?iso-8859-1?Q?DDSl1uujjhXN2ig5rlJwOeDua51eABVl8Xe9AzegKgTNTEBSQbc4DpLrax?=
 =?iso-8859-1?Q?st7Dwe7j+z2Ezt/0N4bPwqjrhKKZe8kZzI5RDvqL5R5iVs8SFYFgfDZlZR?=
 =?iso-8859-1?Q?E8dSmca85wfCoow3dpEgTI2nwP4NtBLD+7FoYLb8y1Nkz3/Xa1iYatfbnt?=
 =?iso-8859-1?Q?fjSaCLi11A3Vba9+nxEb5JFsiO7j5ug51QVl/sRu4kAyVWR5kNLq5qE+LQ?=
 =?iso-8859-1?Q?REI6qV6mUOZ/opRuxtdvzFmTT2H4812MyOSJJAX60FWGw3FTdTr9J35ieS?=
 =?iso-8859-1?Q?6emn//iRfswStBBRRBspkaw70TCfi2dyfEIuymypIiO8JzyPTJI9frlxA/?=
 =?iso-8859-1?Q?PinbdaDPYSltS0A1v8r9WrojbZ92cf5ovcG7RMJ5vhu4w+FxQqKVBlYFdk?=
 =?iso-8859-1?Q?NDJjdjcA6WpW5YrLEDcqBcN8pgebfxdqB5gS7yPtvQ5SLURe6mHkC94goR?=
 =?iso-8859-1?Q?UjzYaF/WSU63pcLReENXwPq5a2f30NbENRU2ZYdFtONUYQndfZLz8jjNZu?=
 =?iso-8859-1?Q?fWI613GFd2XxVZcMKwMBICW9pkfQtx64ukai075tgqlntzIcZpmKk50d66?=
 =?iso-8859-1?Q?DZ4O4ZxibyC21I7ClIkRi7N9wpuiY6PqLg63d471xbNdUdY2KIcATkw0OQ?=
 =?iso-8859-1?Q?6g41dntOXmm8b0s9Xv3RFtKR0Nwl2dSTYBsNhyGjT0XL2eZcTKOkLq9ff/?=
 =?iso-8859-1?Q?UE7y8/8W55hlzoL4LAwUN7X40bIXUXs9FkWJBixFOBcJ6Qvz3ZasqOozc3?=
 =?iso-8859-1?Q?fZVVo934RQB2lTgnyrdvswEvfFuHBxj/VlliBMh9eegWe4IBZkKRvA9p82?=
 =?iso-8859-1?Q?2cgJJPBEY2bKF6bb9/mw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?suFo9TGLwE5kbb/AHy6JqdsN7s3hBO8Sd+CwtEDTnxFavFPzVvUGZMiSfH?=
 =?iso-8859-1?Q?sLEdpv8xG175qoNpizD/VxJt45UPeoVOQlnHwzlKeSSBTj0fBaZRj5GUR7?=
 =?iso-8859-1?Q?/zTWUhAd5BPkLRpeyNRnM3vwuPxzmPKsRVXYRg/6BnE25vd0+UHp5/SbVI?=
 =?iso-8859-1?Q?g00YK1NYG1+B2xZb5AD3MFW1hz1CyX5IUzewW+IfqwteKUT2YGeT508TeV?=
 =?iso-8859-1?Q?o+9i43ug+O0Taj0bcbb6VEJ4j3OCQUOZW9agkMAr6UNWrwY+3SBCKATOsA?=
 =?iso-8859-1?Q?h5AV/o3LBpsVP3BX/FxpZMj3T2z1SoMFbMto/p//mHIKBvelwxDZ+QHhbe?=
 =?iso-8859-1?Q?B+OiNdL/t3618Be/Eo4He4ZU41ghAkwAryfy1NSplb47QN0d59+lGDr0AJ?=
 =?iso-8859-1?Q?xUaa9YZK9zNybhKyE/6BAa0/seQnhwH3ZEqHtH0QgxlOaT08Gsik9CsgJE?=
 =?iso-8859-1?Q?xlkMUywPdqytbRQUpqYa4TMOl7mo6xO9NxYoQ/7eCLKWL8KPeCWskiseOo?=
 =?iso-8859-1?Q?BieUjEa4KjuAqXPFnN+f3CZQqE6jr1yIz4QozvNswvdhdw+njuRRRxR703?=
 =?iso-8859-1?Q?1/1sscDZnjjeu0MlcF+sP1AHJrMYDBETQDzWAcZ8cctHIBimckBEGVtiNG?=
 =?iso-8859-1?Q?9cDNwzPmsh4/t352aI8JjyxpmW85p/sxmlq/Xa18SU7E3ZkJwe+o9CWlD7?=
 =?iso-8859-1?Q?vp0aGa7u+K7XwK3ABXMfS0GBd9G556JYjuUgfV/noum8v4ThONCuCCflDh?=
 =?iso-8859-1?Q?RzLHKrQ+k13F6EJdKWUazYOMaNR66/ESaDpEzZuK7aumcDzt4CrKNzTdkt?=
 =?iso-8859-1?Q?PkoqGgR5pv5Oc1FH+a+rowAPylmUsbDvQL9XNNpKMN4qe6gI41AOs8pMCW?=
 =?iso-8859-1?Q?R2QEq6xPLH50JmGXGkHIc6MTk5Wwz650OPsSx01PWOpe2uvg1KcKzLhuos?=
 =?iso-8859-1?Q?ipJqRL4uqVBuRZAOLjBmPBS5tRiHhCjpuy/+mPlQtNX5FrdFE9yJ3v4F0t?=
 =?iso-8859-1?Q?iOOFjWgDH0rYreGRgy7p43iPldZGR2959sU17KVruwaxfLTcuyACWvDqLw?=
 =?iso-8859-1?Q?B2ygA8ePb3YoANkEoy+cVDgJh6yMIh8lfvAHOZhWLLpw2haQkLqWdWFDv9?=
 =?iso-8859-1?Q?wBxGa09o/8wcq1I1rZDgT7Xp/a44cUuhGNBE/f7k+VNRxNgdPTn7b6H73P?=
 =?iso-8859-1?Q?RcdJYuOjTDKeLog9qsXYu+9Mo11sYGTx+Y7lQTkSlbeuNkmXqjAs6z5aUo?=
 =?iso-8859-1?Q?hIAeOfPTrqpVifsGNilbnpALBuyNpgq76J10RN9WU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa6c5bc-be37-494e-1ba8-08dd9db26925
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 06:39:34.9704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFD2CE7FA6D

Whenever an email is sent, send-email shows a log at last, which
contains all the headers of the email that were received by the
receipients.

In case outlook changes the Message-ID, a log for the same is shown to
the user, but that change is not reflected when the log containing all
the headers is displayed. Here is an example of the log that is shown
when outlook changes the Message-ID:

Outlook reassigned Message-ID to: <PN3PR01MB95973E5ACD7CCFADCB4E298CB865A@P=
N3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
OK. Log says:
Server: smtp.office365.com
MAIL FROM:<gargaditya08@live.com>
RCPT TO:<negahe7142@nomrista.com>
From: Aditya Garg <gargaditya08@live.com>
To: negahe7142@nomrista.com
Subject: [PATCH] send-email: show the new message id assigned by outlook in=
 the logs
Date: Mon, 26 May 2025 20:28:36 +0530
Message-ID: <20250526145836.4825-1-gargaditya08@live.com>
X-Mailer: git-send-email @GIT_VERSION@
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: 250

This patch fixes this by modifying the $header variable, which is
responsible for showing the logs at the end. Also, the log which states
that the Message-ID has been changed will now be shown only when
smtp-debug is enabled, since the main log having all of the headers is
anyways displaying the new Message-ID. It should look like this after
this patch:

OK. Log says:
Server: smtp.office365.com
MAIL FROM:<gargaditya08@live.com>
RCPT TO:<negahe7142@nomrista.com>
From: Aditya Garg <gargaditya08@live.com>
To: negahe7142@nomrista.com
Subject: [PATCH] send-email: show the new message id assigned by outlook in=
 the logs
Date: Mon, 26 May 2025 20:29:22 +0530
Message-ID: <PN3PR01MB95977486061BD2542BD09B67B865A@PN3PR01MB9597.INDPRD01.=
PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: 250

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index b09251c4fc..e8019c40ba 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1776,7 +1776,9 @@ sub send_message {
 		if (is_outlook($smtp_server)) {
 			if ($smtp->message =3D~ /<([^>]+)>/) {
 				$message_id =3D "<$1>";
-				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id;
+				# Replace the original Message-ID in $header with the new one
+				$header =3D~ s/^(Message-ID:\s*).*\n/${1}$message_id\n/m;
+				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id if $s=
mtp->debug;
 			} else {
 				warn __("Warning: Could not retrieve Message-ID from server response.\=
n");
 			}
--=20
2.43.0

