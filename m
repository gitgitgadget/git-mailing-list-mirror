Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8261F463C
	for <git@vger.kernel.org>; Sun, 25 May 2025 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748193146; cv=fail; b=I4P28xDF9qaq2yMAQvWZgh4OCp6HL8QTYJS3iSk6DtuHSnOOjkorBYUFH7iECr4UVjZi8/mAQU2NtYtuQoiiifdN5I/PIhJPtngKXMn/TRgXcbBzkKQit3EGq/JxqardV4YPlU53sbtG7O8KH78NuCd0jg83bGbyLt0T1WPYZJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748193146; c=relaxed/simple;
	bh=eaoCJ2DDCSu1v1mk+pFNhXsiaQs5O6Xr9vmR0G3jSuA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q2eTciTon9dphA2+QxTZgCQASB/7NVVgmUge4leRsQhEDpBJ2baO4QIiz4JIJjX3qNAm6DYDDRpHnQ7UREFGpXvwyJRltyGlQDjAAezEbu/gRRHY7kgUOdJ/VVAMoJ3WeAOvAjXkPSNAykHtnuP18U1s+/Enct1zSpFbalbUFFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Gc96JaPm; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Gc96JaPm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pG/W8JlV4taBNw8UC3fv74gKRGb+5yXIMo7AnIxiO2iheYA9vVUjAdhr/WHE4/KI8NKBxPXUIN0oPmhmNWYQIUcuGeBXE/+dpWH4ag/dKuE+xj+JH1ka2O62IwaWFPhlMPA5qJj4apyV/yH5s85v5wlJIR6StlwWhiqxPjHyOZlrDzxyNeXnPoQC00uIHoGt6aSWuIczsOX9xutxWEhkn74ogm359PLVdwolr4uTVv+e11c7tBd8pKpkRwb1Cdgvj38cFFQI4NpvzgBLPGTke00LmTEy6SausOomrGZS7mEGPyEVOeiK/6T2BL6dYoISVx/+B5q2kG664j/mE8AjfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3og6h7lFw6L4BTONRInSSww2Cyze6vAbrfpxX/DFf8=;
 b=dZBN62rCcbnBv0PbHm8MB17y/UkEjjnnrB/1049rHGVLW2BfMqxg2x20FX8/ow0UsCTaA/74hHtbYDYqfDeymyNaBLhpdRrZ4GN1XR0/8gHVpjwbm1ZQxeBtii9555OInMwef5t1BTqRTN8iLXRD0XiZ2SJnGBQRtLiIZUSOlrY+7w5OayG4S02fw1Ny1aEmCYYjNs4GhQz5XXQCbSQNbeykFg0Xfv/+2RBNLDdgW/0Q7dOBh6MJcNyLt/jZ935WWcigUp2jNsY5KoSYKyvw+tjZLHqkg5U/rQZlvlGGetK7NY91MAK/QL5bK581Sb4kWFyr7b0Sb5SkBbQ355ZUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3og6h7lFw6L4BTONRInSSww2Cyze6vAbrfpxX/DFf8=;
 b=Gc96JaPmB6oro/KTySL24SKFCwBcyWLNXlbkT8Yo+TY7PbuKnSAULX+tmgtrmZCiPGLWndedzERmZpNDbnQ3/T9jPf6kkmWs8GSAzxG0z2dZWqwg81GEqGXU6sUaQCtVqEska/hP6Wkojh+POcfAKfzEIEMwhZo6lMJBs2fiFEwnbkCGrVglKIfXDIJ4iQHkjBU0us5wNVZbgSaVhAZ0/MdrKd0kVnZMbTm3+hGR1mX9whEHl8Tim1BxHkid+z+kJ6HkJytQJoe2fRCs1YNO6DVjwghuNj6n0jbZlCEX2FYMY38bOL/7DTe5dhthGXG9jI0E9IcwiusrR/OoYGd2vQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB6803.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Sun, 25 May
 2025 17:12:18 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.022; Sun, 25 May 2025
 17:12:18 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH v3 1/2] send-email: fix bug resulting in increased message
 number if a message is edited
Thread-Topic: [PATCH v3 1/2] send-email: fix bug resulting in increased
 message number if a message is edited
Thread-Index: AQHbzZgriz80RC7Pk06fJDqlkHBMXA==
Date: Sun, 25 May 2025 17:12:18 +0000
Message-ID:
 <259e20261e35908d5c7f6c36352f1f03be6da6ff.1748192784.git.gargaditya08@live.com>
References: <cover.1748192784.git.gargaditya08@live.com>
In-Reply-To: <cover.1748192784.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNXPR01MB6803:EE_
x-ms-office365-filtering-correlation-id: e1c37cd1-6b2d-453e-02c4-08dd9baf4e1e
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|7092599006|19110799006|15080799009|461199028|41001999006|38102599003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?20k0hVymuiShBA1z9Hy/xUp4+EmmeSkld8uBB55a9tFTYxfwSg5BORlsgl?=
 =?iso-8859-1?Q?pN+j+NbsDtjVo3woC1eYE8tagD8pAh7BuoANLtG33fuRaDEFxtup5rlQZt?=
 =?iso-8859-1?Q?r5p0DNcr/5zvYRyzh4jTwB3xJTxXkokWO7Lc5eHC7oLadUpqupXo+wcK05?=
 =?iso-8859-1?Q?Np356R3lARQLly70hBmrtVahctMC67iEsJ3GPSLqwg/mf4m6UrNZiiPXsG?=
 =?iso-8859-1?Q?VgIgT2zIahskCL8znMVGc68WPagad2VLcPciFUOGbYMgdwH1JlnLNC6YuX?=
 =?iso-8859-1?Q?X5ck/gfMnMQk+0wXdwKnS1fPQzGUp05+Lh+6gH2vG4Nf+dGEiOxL9L+QhA?=
 =?iso-8859-1?Q?OR1r2UAv6dg2ITXvdmAzvdHuXQkayrROMsEn992LMW+/JamwlY6S+gTiA8?=
 =?iso-8859-1?Q?SqrIeHfsGxDW/hgecMugPJgTdvJq3FyWOtlb1osl7iYr54hwWN9KNJ77Nc?=
 =?iso-8859-1?Q?Chz/V3Ov8yapNqGvCjWRUx9nYhOgWBx3QhTU1BSyKAOajwjHpgxvAXiogW?=
 =?iso-8859-1?Q?DAHh2y5rI8sKlRJTvXGs/E3OKZeVM8xjP5oqCnP1tu6FDxnhc7jt2omzwj?=
 =?iso-8859-1?Q?NmkwhnXN/b/e2mU+fdMFkMYmssJmst4cgsrYNkPaYGaaLKhIUWRKusks2+?=
 =?iso-8859-1?Q?SWn+ipLdjPNkxou3FQfdxaWR8W2FrSZOjwdsuetqzAKmBuN5Ex/lejRX8t?=
 =?iso-8859-1?Q?Hh/Xox3pCqWwG+0XuOmFIXCTQSGRZDgUhUV2YUK5P4ahMqcYw7iFOMHd4H?=
 =?iso-8859-1?Q?uZfuuxkrrB6ZarYOIhri0q9tljgX6ZCdM72zCsXeV75yI2DRCIWb6qLeHG?=
 =?iso-8859-1?Q?7u2HdagPRtMYZrjqS95NVNn3Dwcz5itiRW7pLjatb6SGkMvvidUnOtBUja?=
 =?iso-8859-1?Q?veOXXaO7RMRyzEuO1NRlvAxJdwD7pSLQ1XxhU+oQLV9P1M23jfzh5kHvNd?=
 =?iso-8859-1?Q?/yYYqCczvNOo6NdTH8A+R3Jk+mkVOOPnH2vR8T1G2mGqENESlUxBtDr66T?=
 =?iso-8859-1?Q?PGIcnp9h0zjwlqATeUuSB0zHtDQqYZMxn7wN3ZiMNw1bHlxwQ8NteGaLsk?=
 =?iso-8859-1?Q?N6UvuajYRww+Pg59p7YiZmhl3g3/qzz+0bF5DIJdK3SdsFck4VDAW9xxQm?=
 =?iso-8859-1?Q?jToizaGukYnJS+hzizagrzj/gdGwPnOLtTCjpcuhpjbY/yUuz+KKUdc0Lo?=
 =?iso-8859-1?Q?qfd3Ah3hpJtCmjhyrQdjE41D+j9H3Xcf3LE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/xMv/YojEdBpCCGYkFKM28CZU9B6KHjXZv+me3SwW+7fadvpJ1RJ36VoCy?=
 =?iso-8859-1?Q?P+Q0sEKw94pL1UNMQORqo+x45X1vdArOPrwv6MAHETFoI47H09H2j0bgWE?=
 =?iso-8859-1?Q?t+VI0KtWabTFPRScZXG5zecRAquGkiDtRBTHGpcBUk3EPdCTaSe9cUPO/7?=
 =?iso-8859-1?Q?kzfdTNnR2G6rjqmizV1naQ1yXpelIrUq8PH+CKXNdRRAqm8ZrZkMpD3Zys?=
 =?iso-8859-1?Q?jTINbnvr0dAaJOWVwa3b3nL9yWMlT9kTaboWlWkiBApgbG0IOn/2R/JxAe?=
 =?iso-8859-1?Q?r2SeJTlFdUWuoFzQK+i/i0lsRg+hYwr2IxX6VVBuhRMreBUEbogOb1Vqui?=
 =?iso-8859-1?Q?OXq0ibcVzHXGqT4yP16TBcINj1EqahqHZpd5/aOgP1sLEsSa1A+PvgtsXL?=
 =?iso-8859-1?Q?0Anc4I37jc7ZZMxKfCFarJFhvCSAgplhjngEvnJki9ZbugidI0OfPyiIbv?=
 =?iso-8859-1?Q?WAzTNCxgxLa0ORDCE1BfnH2beNBwEZGtjHo0ChpxFXTxmRU2+Wi+Ah6jn1?=
 =?iso-8859-1?Q?ZprfdyW9dhSRemYejkNo/P14Sw82SN1rODsbR3MP3xhXR0fX855SZ+p6Wi?=
 =?iso-8859-1?Q?K34Ru8J2tz3f34bCSVzNxhwVtiaJb+tr1SwVhP/hoh8Lne1yvOJEgrOeJo?=
 =?iso-8859-1?Q?Ud+kwvXeN6K/zu6sRwgQs/oBJ40/lZMK2wcDVU5Ln8FAo+LrDxY5s8DZsn?=
 =?iso-8859-1?Q?a9PduLiUS9re1sGpeKMdJ4u23RHB5m45pYQElyoHtIAln9ac2T2516ZSqY?=
 =?iso-8859-1?Q?D62ighLIMt4tambxEPgCiuzwE9vKI8aOmssHgRk+TgZKWuOVEgfcyfkD1d?=
 =?iso-8859-1?Q?bTVmY2NEExqzsEqDggo/rawamFSeANKjgVWj2Ckp5CKEESkHQ2OwpvJ8+l?=
 =?iso-8859-1?Q?nSme6nRbfmxo4cZGqw0Uq7nqACsR/GrfFeOaEYsLMPcUAFEzJvYC7x/dot?=
 =?iso-8859-1?Q?cGaO4lO7khgBbtR9AeblxlXggCB9m3zFpWX4tjvQi4XaRakORGhTGX8KL1?=
 =?iso-8859-1?Q?YX7TICcL9dQS+6YLpPwEdeF4iScKE4dkh5ZeWNBzwjs4r5tlLI9BfQdpwX?=
 =?iso-8859-1?Q?f4SwdJ1H02+jwI28YX1y5A20gYtpakDCqap7w3pKzHX7+NJPDJ1ve9BUrs?=
 =?iso-8859-1?Q?yo9bZSHtjhI3RVYaJnti8cOeoOJJNf044GOZQMH3ze/4wKi6KKBuiQl6q3?=
 =?iso-8859-1?Q?LDbCd5PrezQSv1fWXdJofYqjIdtxtUtdZWtSHfdazWjqmt7ZIc1ofvOkbb?=
 =?iso-8859-1?Q?Bqrv97AfQ4JST9kbdvEiK8nGx3bPq/2aStgZZffEI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c37cd1-6b2d-453e-02c4-08dd9baf4e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 17:12:18.8136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB6803

In case a message is edited before it is sent, its message number gets
increased by 1, and so does its order in the message id. The cause of
this bug was that when a person attempts to edit the message, the whole
sub process_file gets terminated, and the user is asked to edit the message=
.
After necessary edits are done, the whole sub process_file is executed agai=
n.
The way sub process_file is designed, every time is runs, it increases the
$message_num variable by 1. The reason for this was that the function ran
again everytime a next message was sent in a thread, and thus we need to
increase the message number for that message. In case a user edits the mess=
age,
there is no check for the same and the new message gets treated as a subseq=
uent
message of a thread, therefore increasing its message number by one. This
breaks the shallow thread logic which relies on $message_num being 1 for th=
e
first message, and it gets changed in case the user edits the first message=
.

So, upon scanning the whole code, there are two significant variables at pl=
ay
here. First is $message_num, responsible for the message number and second
is $message_id_serial, responsible for showing the message number in the
Message-ID header. So, whenever we edit a message, lets just decrease them
by 1, so that when the whole process to compose and send the message starts=
,
these variables increase by 1 again, thus get set to the original values fo=
r
that message.

We also are doing the same thing in case the user chooses to not send a mes=
sage
out of many messages in a thread. By doing so, we will simply decrease thes=
e
variables by 1 for further messages, thus ensuring the whole thread doesn't
break.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 55b7e00d29..b09251c4fc 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1639,8 +1639,20 @@ sub send_message {
 		         default =3D> $ask_default);
 		die __("Send this email reply required") unless defined $_;
 		if (/^n/i) {
+			# If we are skipping a message, we should make sure that
+			# the next message is treated as the successor to the
+			# previously sent message, and not the skipped message.
+			$message_num--;
+			$message_id_serial--;
 			return 0;
 		} elsif (/^e/i) {
+			# Since the same message will be sent again, we need to
+			# decrement the message number to the previous message.
+			# Otherwise, the edited message will be treated as a
+			# different message sent after the original non-edited
+			# message.
+			$message_num--;
+			$message_id_serial--;
 			return -1;
 		} elsif (/^q/i) {
 			cleanup_compose_files();
--=20
2.43.0


