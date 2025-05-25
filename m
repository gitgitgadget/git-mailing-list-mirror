Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6969C25D91B
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748199314; cv=fail; b=lZ792tB+wdmj9iE/UiIMQ7sJmLnoVf4xoA4165/gV/S3z2u6g2OCrje8+qPatLSRE9vWnwz02WiNzyk02NDADgMMyqDFX0KIyWfzFS0sNd5Pt93ZTP6Ohl6z7845Y3GO/PLh2AyBaHS5wiKUPEtYBOky/GEWuTH5OMK6tY3rJOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748199314; c=relaxed/simple;
	bh=A4dqUGjS/dCXr97DvX4ZZaPzWwci1OKEs3EeWEkFXgw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A4xu3fBfWZ6rJ7MBVyF1BfpWFcSaAiMjpwbwIcSyKudnJVuOJCCBhBxdV9c/3vGKntQ3lOTO5+IdWG1MN5Tj4k4NzMzmR8+h5A8lu1q1qpXevmZhzrS2YtSU8V41rY89FloEsk7Q8SYHhuVo3UHf2xdeAVYFKqyWs1MIXlfkF3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ceFXmMGW; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ceFXmMGW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qy1frOFRGh9J+vkSt93s0gN+FwB3hIdebiKwicrg1n39PaxsWeMX9TqQHVY+7lKz16386smpLjs8GwvsnQQolvyD6WyRo4STjODbaH3+G0Yj0Mne4lIYcCKDD5v/iANS17dEE1QC40iAZm5VDShfCOtn36MwT4v++dN/G0Xb9P2HSy72jVIWR0Eif2ZK6Oh+f5xBchs5l6OCXxTx0KQ6b6MyfC6tVX1WfIt1gIBZ3PIoytVRHqiSx7G6Ka1/8B6CqF04NBUYYWuys7AaztQ+oSYmLYyX/lqwogrB5lCFDQHUzmhkRXQTW/ELpPY+EuG90XOY23xnABU4L4Q6IP5jMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXsjvN8hs5762REDQsEuTiOTmAHz8NRYlDiPxZv+zoc=;
 b=YO0Zg9+amL6PQa17jJFW7yJciahp1hJHRNh9+aw0pVjVsz8YBAFcdHrnYcqkHzLGrONKleDM6TM4pXphkAw/uYxwBWgjCA+Yqvt1rj23SK1UhAXdaatuANwDuCt3CFUnE7Wby1WRIURJs8Gp6kYhYA4Q4VVwVJTfHWum8itkedIxfi66irqw1KKqFhigv1HSFXyg3YKTkscbaCawqDXZ++qppalX0iQhP0kNdnhW1q+xymv255ES9VQdpxpyrpZNA+UaLaCy5/Od0fZMJJWnxuLHojULW8+gX3l9R1G4hGxnJpJGSfi46QGVjVGf0aGxtWLHhCYXm3dYcSTdfVQcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXsjvN8hs5762REDQsEuTiOTmAHz8NRYlDiPxZv+zoc=;
 b=ceFXmMGWLTtXRVLSLCj1AIhUrLPLQkTSJp0MTerHuxsAz8mHX2n89hub20EC8w6UvP41LRlrIPOPKitDJrgXKhyuQfa4mgpuZNmfhhp6NYJvfM2ZdrUBtv7FjQniqh4bvvnr+jFQpvmMTRkCiwRxDJZr+cz3qVIMRY4zCyD9IY9SXTXuu57HOksI8MIs3/zxz9n8HcWGza8yvq2N/Gw9KXWbIHg6H68j1mXgV0fRYqrYvgGVSl0GDPPWqz0HUTCxyqV40C5UK/w75FxqvujN/Yv3V9VFQcAmFRo7Ccd/4afeDaBmisMIE2NsGgj10CgEqXqrAzybCSj912Uqox/EAA==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB10362.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 18:55:04 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.025; Sun, 25 May 2025
 18:55:04 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>
Subject: [PATCH v5 6/6] imap-send: enable user to choose between libcurl and
 openssl using the config
Thread-Topic: [PATCH v5 6/6] imap-send: enable user to choose between libcurl
 and openssl using the config
Thread-Index: AQHbzaaGyDbnJ04nPE6htPbXbKuynw==
Date: Sun, 25 May 2025 18:55:04 +0000
Message-ID: <20250525185447.29982-7-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250525185447.29982-1-gargaditya08@live.com>
In-Reply-To: <20250525185447.29982-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|PN3PR01MB10362:EE_
x-ms-office365-filtering-correlation-id: f30d8b9c-2b7e-49f6-07f5-08dd9bbda8dc
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|461199028|7092599006|38102599003|15080799009|19110799006|41001999006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7sUTa94jg0h+Gk87pyobJ3JZNtqe3QTo5mDSvpwWkwJueDctHQzNaxD1wZ?=
 =?iso-8859-1?Q?QtYHfBedpMJPcBoCj3GpFOibV6OncAsSgfK9S9kCuRJedmlFNIdxpRWGJf?=
 =?iso-8859-1?Q?LZguFpoFkan05cyZH9RqUQvuuT7mMOrqYOvBbX6nZ8TNVM1WxyOIDqaSDF?=
 =?iso-8859-1?Q?0zSNBZ8OB9CM/CHb5iiv/LPaXv/lnUc/2HRysZ0NQG+txt6q8pndB53wIi?=
 =?iso-8859-1?Q?jhkCCdAkQCAzCpAOmDKrO9XCFsxhrAi9aBjodFFkubMfOmMTnxOy9W4oFM?=
 =?iso-8859-1?Q?RQ9NukRPv5Y+f9t0psiBxMO2jqyV42PVN1SSTIJSpX30837EcTyNSpVzn1?=
 =?iso-8859-1?Q?zAFTkZs847mFDWgG6qt/7656b2qKcS5zKFk/O+Ofg7FX9yPuttT0syg2IM?=
 =?iso-8859-1?Q?H34GOBB/D3jO5XZM2jABL59U/Lz7+AdIG7JXmnMIBkCeuhow6c7PK5rlln?=
 =?iso-8859-1?Q?6jOmNRX1iMGDb+QiFIfru4xUbiwoaOBsJwP4AcRkLYo+zv44uDyTH8MFdE?=
 =?iso-8859-1?Q?oe2M5hixp/OLiAS6HzEDlzlclj5tar7/jmRaSvIixtekXiKSSVJ//x6/Cv?=
 =?iso-8859-1?Q?XFZl7I1XJPFBRK1NBQp+92by3PMOSD77BgNMJDdvr/XAN45A5HijBudv7k?=
 =?iso-8859-1?Q?xDhhho/SVDGk5XNdTK/uSlLolZfnHxGgU2Gk07wRQ6WAEeMaPeVentr+nZ?=
 =?iso-8859-1?Q?Vc+P7jkBTzAIXz75Bxv5c4lx5nOfaQATTzkwa4ry86+3hjdr59wl15RH0k?=
 =?iso-8859-1?Q?gE1GqHRlFMPJPuSIzEEZ0bmmEGwbhUJrL18LYeGCB8Bt5b/C5C7UmDwjGt?=
 =?iso-8859-1?Q?pbDp9Z4U5OlzCSKThCRlYRvPdKSymISUwHEyM88vpr2H/PdqxfaBJ8r+5J?=
 =?iso-8859-1?Q?dC2qPpSRS3rkly9CpT9hAdM+64ua/BfYxfos9AAJ3jIGxhz7fAVdkZHeOM?=
 =?iso-8859-1?Q?zxqCdcu0rAe4UNmqR+m+GEYZAxHoQRIAZsGX/GxXrciqn49IvUEO+huZ59?=
 =?iso-8859-1?Q?TvRn4MBuxreQzA7OpGf34Jb16iGQKRqt3DChV1yW1oy6BNYDCAaYnj/a8x?=
 =?iso-8859-1?Q?Bkt0oMYUdrO0GGBWGBcEapjFKOBBDE/uqPyUtvLc1S9LEgoyzVZN6XqPyk?=
 =?iso-8859-1?Q?hGazb2g9p3Ez75bbIhCFua/0NZ0uI4YEwcIqysMyMXcs7JDKBnt1Vv+82F?=
 =?iso-8859-1?Q?LXHvNkRWblO5NDeizMa6JB4pDjXWSQaWq1g=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Q1y5j1pS9h+qOhXspDlxSJL8SJo9958cLGG1XAhjl83e6LoD1Md+V5silR?=
 =?iso-8859-1?Q?O35OxRR2iW03Dx5icFdnkbgOFY/MjxIEqfpKLXJJHEV4eLgZtgeC8dM8xW?=
 =?iso-8859-1?Q?ThE3vjcheCawtJpAhOHcHVzowQYsFbtWkcVJNsxP5pJWFPJ+SUJUnbVf8Q?=
 =?iso-8859-1?Q?0pnrvAAZNTJACW6lzPsbutKHTw/h9p67vrw2nGEjB+AzMaoXhafARYlbKm?=
 =?iso-8859-1?Q?NWjxkCR7U9gjonPhj0lwz31a2p728N/ZlgJ2L2FjqAu+Myhf7m3rEydqdg?=
 =?iso-8859-1?Q?Zi1q9YQ2tm1Oed4q+krup9iN89d4VXzCe4KvKQUzNpVps3NVfFP4AAq2DS?=
 =?iso-8859-1?Q?QQJfeKmQwAMjOTT4EYz0r98tqESmobSQOn3l05+L/LLMXlm8h6IBkC0cup?=
 =?iso-8859-1?Q?Adq85mAywTPKlcz48Zqe0zAVZ4y7tnsLXHuZF7nodF9v3bCOQ2GxPfgOPr?=
 =?iso-8859-1?Q?Dqi7hfSOeqRRbmor9X6avSyMfPY1BoCdxN/0MYDrI5NgiWMIRlagBxgBMp?=
 =?iso-8859-1?Q?/T/k4DC2oXPSbfzZm8GXkt4VeRlnDm/wv1TB5aBQVAwPLYmQsdr0br+fn7?=
 =?iso-8859-1?Q?apYp+VgY8/IJgQVzx/7WSz5pTx55Tu9jpuZgpxkOPpFR1/hWADNVwb6RIU?=
 =?iso-8859-1?Q?f4uZ4VI+TIEQg6rPL9SXSUBppZJI8J3HTeWH6RdGxkNsncSLLdrY0YkMHr?=
 =?iso-8859-1?Q?xw2VaF01M4mZ78i/GwrQhoRqGMU8nYWA2oVHzWpo7YhydaB/xWZ010DOsS?=
 =?iso-8859-1?Q?WwOQh024i1O5ux8+ZwTxAMFB8YojZBRMXmJlMcNJtU0s4JVLbwdljhz6Xg?=
 =?iso-8859-1?Q?JrrNjB0k2mj44CwPYTDstMyOp06HSZyONB+rI6+fiof+L6KEwUsShs8MvM?=
 =?iso-8859-1?Q?2OQcH6ecBqvLNA1CkHb0GxhX2X80xMIdtOEQ4yKI1TuHU+L6883X8wTTcZ?=
 =?iso-8859-1?Q?nmds+irIu0DvhpAMXe3wewXHyJxOxqOKVNMN58tr5Wl5+9SxzmA3uIj+I+?=
 =?iso-8859-1?Q?7bFoEiRbBiuYYTWD+WUk1vA5uEcxPDx/Nq66JQQx8CiGMnyRaBzBjTHik4?=
 =?iso-8859-1?Q?HKI+5EGsKMME/x3quCHY2ragZ/snwpdOUo8YMsyXVIjpImt7CGPge/kvcy?=
 =?iso-8859-1?Q?g3g2Hmi5awhvq5QVXvgZRrfzudaoHtYTlZ2mHR1ZkAwiG/q//vl3/wRrxu?=
 =?iso-8859-1?Q?KHzkuYo1TqFZ7bQ1560fqL7/VvC5Yzs0VLjmz5yZriTF1AcVVthOQktyBh?=
 =?iso-8859-1?Q?ghsSn5pzgmD5mAc7N8zb/xhnty25L2KV40hdYvK5I=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f30d8b9c-2b7e-49f6-07f5-08dd9bbda8dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 18:55:04.0561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10362

Currently, imap-send allows the user to choose between libcurl and
openssl in case Git is compiled with both libraries only using the
command line, and no option to set a default using the config is
available. Add support for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   | 7 +++++++
 Documentation/git-imap-send.adoc | 4 ++--
 imap-send.c                      | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.ado=
c
index 829d9e0bac..608c0be7ab 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -25,6 +25,13 @@ imap.port::
 	Defaults to 143 for imap:// hosts and 993 for imaps:// hosts.
 	Ignored when imap.tunnel is set.
=20
+imap.usecurl::
+	A boolean to choose whether to use libcurl or not to communicate
+	with the IMAP server.
+	Ignored if Git was built without `USE_CURL_FOR_IMAP_SEND` option
+	or with `NO_OPENSSL` option set.
+	`--[no]-curl` argument will override this option.
+
 imap.sslverify::
 	A boolean to enable/disable verification of the server certificate
 	used by the SSL/TLS connection. Default is `true`. Ignored when
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send=
.adoc
index de3613928f..efaa2b774e 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -44,12 +44,12 @@ OPTIONS
=20
 --curl::
 	Use libcurl to communicate with the IMAP server, unless tunneling
-	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
+	into it.  Ignored if Git was built without the `USE_CURL_FOR_IMAP_SEND`
 	option set.
=20
 --no-curl::
 	Talk to the IMAP server using git's own IMAP routines instead of
-	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
+	using libcurl.  Ignored if Git was built with the `NO_OPENSSL` option
 	set.
=20
=20
diff --git a/imap-send.c b/imap-send.c
index e062758198..90819eb856 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1559,6 +1559,8 @@ static int git_imap_config(const char *var, const cha=
r *val,
 		return git_config_string(&cfg->auth_method, var, val);
 	} else if (!strcmp("imap.port", var)) {
 		cfg->port =3D git_config_int(var, val, ctx->kvi);
+	} else if (!strcmp("imap.usecurl", var)) {
+		use_curl =3D git_config_bool(var, val);
 	} else if (!strcmp("imap.host", var)) {
 		if (!val) {
 			return config_error_nonbool(var);
--=20
2.43.0


