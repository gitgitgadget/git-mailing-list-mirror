Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48041221F21
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500625; cv=fail; b=UvD1IlXCnB+9E5m+5N/NX1PoO02TDALEukozc/3rkdV8EcHE7Juy4QDqbmwscg82cUUQhMFsLqii9nDQEs4+heRzQP5J5CrOhynvoVZ16uxsX13KGp1qiEoe0LjJo6QJh2ni5L3wtNiPu/9i8iNFLr5rDsybm2d7ZhrWRBGHack=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500625; c=relaxed/simple;
	bh=V6u5hvNGBB4hT5A2AFUppPndLUeMzxInQDcVwUmqBT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uLkZBdnLpXdjHt+9gfbbbFnc1dTQmbkfD14FclD55ZZNW1X/ZiOq5GxQhmN5mw+hxmKlT565MLaldBrLbvckBjLwJvunjFnXBUnPVa8Z4MKD1PN1/JSQOZ+109rXEvgTep1xCMCARG4zItGiuQZE2/njpif7YZ8kT+TOgQmJuB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bM7pbWTV; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bM7pbWTV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eat9ZRHqck9boPc5tUukwtl2S4/mDdxrpCmTezdgEefsb6XvveSQgIGu5jvNCBex6ZbqVDzlsUwog+9r+6t+HUtQ07njCgl5QPd0qVeRKpXfJbdS7YP+LnHBys6kYq4TRg0ZjDSsh47jOjW3f3zlsBw8uTDzs5ALfXQ37kRBmnsLRxRbzFaShpfq16nBY2XHdMBnJiJKTqt8WJ2voENYWbE5iZXt/wlH+kjS8SP0LmpdCirUlP/2/3DOJTs93EmUzYh26j8q9kv4SLonEYb49J0526gN+RWhY6cXxxFzNAdfIvilR53tNYUKguA1eGt77OxJSp10vkhZPZd7W8+W8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRhVPyAhMOAfXERfvoxjJuhc5L1EnUR38VvmPEHgAYo=;
 b=YEt48qcuVmLIYEq2j1YqxzLKercOTWEsCHEYOXNEZffb6vl5F2HsEFcSQZOdVCOKcBnlzmrdFWvfY7TlaoNIbdybTMkNj5/kcdAWMpQMRJEiYJnX4iRRTvWed5K/Thk2oYFBRDaGYtqP4rC6YIrafhgWny7vX7+H6QYhO15Q50+b4ojtmSPMBvVXff64fjK3YGX3i+9ie7/UGBlKTrXkVDduSW13YuUWgjg0IAsHjZdRojWl3IkIwCWJJf4rYHqsheTt75Kg6pdpQK6iIxJE6FHKM/IhbZTDqeoXbK2Eo4QOAHU8dNMFrlf+yswby+YqndNRtKkKmNwsuEQj8VRcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRhVPyAhMOAfXERfvoxjJuhc5L1EnUR38VvmPEHgAYo=;
 b=bM7pbWTVWjL0UIdMnIO/BVIeMiO0FFsdtfxYsmQ1RaZq149p7cTSy+2Br/yMqfaGWhABEok20UOTXst/VaeZCIm9EhhnIFCAY5Ov0ezXLDlVhTc9aJEuip1cmlHVp/yWd0S8pzvtpFsWiM/Ts1A+erPcjlHXhJ3yw3uRCAmPlKBnOBUW/64IwlD06MhMpf0+R1Qt7i1DuMKORiWxCjrvkgbsdnqZGR3sc8f2rAtQZ8ONsMhuLhY1fK8Vu78SOTuEoIi31QCcDXkGvWm1zQE14fRjAv1w/KVhekSC3+pjYnpV5tECtefWk6wSLSNV3oEcBMe2hhP8ah+/+lVays9oCQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 20:23:29 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:23:29 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v18 08/10] imap-send: display port alongwith host when git credential is invoked
Date: Mon,  9 Jun 2025 20:22:53 +0000
Message-ID:
 <PN3PR01MB95979FE054BDCB5452DB446BB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250609202255.4341-9-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e19df1-3520-4891-e106-08dda7937e7c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|461199028|5072599009|19110799006|15080799009|8022599003|41001999006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oE53J/XK5tncA6N1EEj/JPj5pSrTH2kUsqbWnxYhw3ATSgYQv7BWWLkDHbj1?=
 =?us-ascii?Q?uqw/m4LierCXCy98xctMT73pvedtZJVeT2tkjDd1FDrZSm7LAq+rhR173lu+?=
 =?us-ascii?Q?Y4+Ylehhka3s1R94YiYgRVxz7uNsLnFAAD9+FLHnpd+//LP4PBYB+5LfrYsG?=
 =?us-ascii?Q?5n1i8chhAP+CzGTuT34q2G/VCaEEvjMQniGgU309JPy/J2ol8lPVqL8PxcWC?=
 =?us-ascii?Q?hxclm6Wd47sLLdszvRfb96WT0BJZQ3B4VoY2kgPoJPVWnmTcdZWzrTLC93je?=
 =?us-ascii?Q?kyNI31SwXVOjWUSgn1kXf6Ww8YSHEPsgUQNt6R3bfkGN6f+IC6VLPQqd4bo1?=
 =?us-ascii?Q?BpGqfwsH6UO1utmjN9/jKl9lbcsH+tg0IlaLdQFiTn3Ek3QJSbtEwiqTkX0C?=
 =?us-ascii?Q?+Qe7Sd5TT4SikbsUN9dAdNSklGzLPQyBxLS8XApVwybmK5v7P/XCaeAb/cRR?=
 =?us-ascii?Q?2QsD2QfW/e8kpI1KobtCMHykMiOMbgnZwiTrWJMM9C9HOai93SV0G8oRYCVx?=
 =?us-ascii?Q?Lvv9FcBU8x3bsIcJsb/HjbTF8jYMreW0gMFiZX4sZwKthmHnXasLhdDFCdcZ?=
 =?us-ascii?Q?9C7ZO9fASm2Ovi91xhscdCv/Mw3LggOroExHn28AOvr6pqthSqm3S96vdKOe?=
 =?us-ascii?Q?hfc7mtekcR5NPjf50SojMK3EzMJOEoWSL07o1ZLqzOjDZU+UktZLdxex3YKl?=
 =?us-ascii?Q?AbkReuMxMCR1BfLpUDBt+ICHSMNogDk2/ohGhdVxZIxRJGBCy73oJ2BjvbnO?=
 =?us-ascii?Q?hmeP+Htzq3gwqYyGjha/OtzBHaSfie1o/Uqv1ZQdrlyJX2ZCagNJBITQ81M/?=
 =?us-ascii?Q?kFwrDrlVJ60vyKRMw0SkRbHOwr4Lmbi9IzG/rVeKFRWhDIFolAJ60emgBXlf?=
 =?us-ascii?Q?+cCtLVpRWDki2pz9EWYQVS9n3jEW7iVT+Wt1wpN5ErLuhStlDvgxPQ2eUuuh?=
 =?us-ascii?Q?+BfQRMxH9f+w2WMjt2zexohXYDHBtgWAstnjl+r2y9VRKhWgylTZp7g7CqQr?=
 =?us-ascii?Q?7nZENnU3kAiN580UmpXgTs8r7A9CqmZb0wq7VZxQF/o9JaNDo7ZU8fx2G1wT?=
 =?us-ascii?Q?Da4znTV/T/yB9Py2CExIzYX+rbR388L8cZlCP+OyGLTneL4pJL/3RQ7jJKlX?=
 =?us-ascii?Q?+RzWjhwRuyoTVSQ9WbTfcofQTsxL+p3pLAd7j8wvdNXh9x3hIMQKnDo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fOfxfdZiKnzdwAOByjgTEJdHWXebp+BNBv1hbpMpZR+uVzj5HtgxgbGK2KAE?=
 =?us-ascii?Q?PzchqNN82CDauNH7zif97GAggqlqE8arhaF0HE+WFp49qbaxWMrG7Y3sPpmA?=
 =?us-ascii?Q?YU2Mfd8oMoEypJK5tKtKaZF9A4PpBJF5iui31RpP26P9c+TfvkKD4OlnrfyB?=
 =?us-ascii?Q?vDrNxcnn3iwk9Yc23VD4FrDP/eg0+8VuWKUry8qnRT0iLhwqHVSTAbXSgBL4?=
 =?us-ascii?Q?NteEHi3R4K6xLtXyDLLOUHr7dGwnYdLjA7Vhf+8h773nt3INVdcrg+oJyu//?=
 =?us-ascii?Q?JGJxdg3Pn4ZwSe6L1L6BZZo3iS7a37VJyUwIjBWrSkQ7in5I1UInCF1znLi0?=
 =?us-ascii?Q?IumuEiF+JjKmgGPztxMF6j/paKyuFWKfJOfIHrs+0XxQOHQewML2U5hFGK6z?=
 =?us-ascii?Q?VQobisE3N4iWkmMWT5JfdwdpTNTggxuA3WvOvTPrNrAP1HkG7ns93WLiiqx2?=
 =?us-ascii?Q?9tQDBVADrb9vk2ny2ye/Lxt2WuMoL+Y1BWRJbRtdIJGDccEmanLEUBSlcvnO?=
 =?us-ascii?Q?4RXy5w9OAzfBL0JAnExzq3lQbJW+6gtUPnewtpMi04f3WOltjn8/YrFuJHSB?=
 =?us-ascii?Q?aA+9vN0pp6KNOf+Wcsp3ZarSCOVw9d67VE3ujLWKXCebmBqOmMac76cGO1Ws?=
 =?us-ascii?Q?qXAaExZEO40cq44AhEVryNTtCh8yhheHJ7/joB6HSemKvptE0M7/okrOSBRu?=
 =?us-ascii?Q?ZfCcXVWPa54613ALZdIjxor/Rro1TsXiEcuv4navSewOOkQfZBnYE4+CScBf?=
 =?us-ascii?Q?PH98BlFiy+B69KfQAT0yPVVvjwjRUMil/pWg5K0HxPulmI19vgleEEGWCoXB?=
 =?us-ascii?Q?UiaPCkkvmO+V09uBMBDWlUkJpFkGx6bcS0rmNZXBGFsXv4l9ZbBg5uJaw+j7?=
 =?us-ascii?Q?c0pneIV1tPJ3Jl6UTaSdOp0eRXzWUlShvoOg7pL0rmjkGU9QBTDZ4T05Uvq6?=
 =?us-ascii?Q?BMsjhLE7lQtkIilcM1SyxXP5KyaMu+D7RGjUY/9K+MkwYr/YSesKP93GO1V6?=
 =?us-ascii?Q?h+TEXpoWYl9FI1yzyuFhusyVFhUQEXOTg5vtrIXsKKy2m7EkKN9cgHJWku0+?=
 =?us-ascii?Q?8ZizgZFDiOzzTHMJL9AxWNeN6Loh5hMR4OwA8VrwKnVZ3lZ/IpjpSLNQwbCV?=
 =?us-ascii?Q?CEl7o2pjIVTv+Av6W+0lgyphJA1GnUC+4C6hN9pW1Ya2Q4X6NFKhn05GmnaM?=
 =?us-ascii?Q?9waSI+a1btXsTYAjnrmZrRyA0QyVFCgzd3h7/PXeKM4KvThrzz6mVJZPxLA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e19df1-3520-4891-e106-08dda7937e7c
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:23:28.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4380

When requesting for passsword, git credential helper used to display
only the host name. For example:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com':

Now, it will display the port along with the host name:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com:993':

This has been done to make credential helpers more specific for ports.
Also, this behaviour will also mimic git send-email, which displays
the port along with the host name when requesting for a password.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 77cf2b3da2..a79e7c7da7 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1089,7 +1089,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		return;
 
 	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
-	cred->host = xstrdup(srvc->host);
+	cred->host = xstrfmt("%s:%d", srvc->host, srvc->port);
 
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
-- 
2.49.0

