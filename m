Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E18322DA10
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535679; cv=fail; b=UpJIPPSJ/euahfhWMY9me2WqhzWCG04qDtZb3yRJlcAO6b/+iiorYQBSPZM/MjXnF13X6hNohWDtqGnkkLCBWCSnTnXzMuLvKQtgOidOvefBNAOIzcVvSF3PUFql2+El/AFdhGGjUzy6CzFgZ40lDSiJ7JdW16gL8ofzYJMD5Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535679; c=relaxed/simple;
	bh=LQioHDOSucAjwqGgz/ICD5m3mwBqo6SXEKCltC698DU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KDXUx9t0zarlzAATf2x+slF0G+UKgW2cKqMn67JBwN75tzH8iiHNSzmZk8YgnJa1OXAdEPes6CFZxEU661imNxB3GqZYnnnlt8aNrn/YmZYykJg3fyTXQmoTA9X4iybFNR0hdeimSzYPsjr7kybOHn1AeVToN/qqoMv9owFWOWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=dHI9Xu21; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="dHI9Xu21"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SATm2go/X15wbnxjgUlmmSMWCXSoqYImm1s2Pez3f4vQMGjhusRNqaiQMoTpJ6cIIYJD8eTBMGJ0d0OKib02zwnVHaspo19RvDlq+k/t1SiQI6aNAJwe5TLYUKjNZ7IsN3SQEoFV+WljBABh/L0+SKZoRhuPMcGXK/q2SqCPYEBlaYc0Oq+NtEejTki73LFf0bRxwY9PcpaXocZiMHiR+bsNC79yULfAiLU00GECEMpz4T+oTjPe4/4/j3fP7SbsJUJbsIupkdov7H2n0lKu+waG3CwRAYTFNQR3KYflNWIOHAcW7A0AuPFi90jxiFPLBsKV0eJwLNY5J+ddlzRmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9W+L+FvpE47SaDb3Eml0vUbu4b8G6qIZAucIhoc6EFE=;
 b=iDuk5HnDG7EN0k7CAEWGVL2dngF7rH79lfZlvVRxO6vjaR53EOa0z5oDxtLkLZOazKqFyQAAbm3MMFoDhVnhsRzAqxdUAy5EDaVrtfyj+tb9cPxe9wmuvMK0uSmRg5kyRDAdtp/3gbPvmFXo2uJwm7Trm3F5P0xHoXhmV0yo7oGBDVWUHj/gUAvkNCv4sC9TttwmImmmzzhexbktK0n39EeU9BvPQ3tl3V4by5A7ushtc3cc23rV2bIg1VuA1na9kl1AXHsIx4QI4Os6z+myIjvIWo6L5kAiWEq9Bxt6Fjmt9cfEWjJTVnOXkLYOXjRHJIZXh8HsLX2J9t4nInn2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9W+L+FvpE47SaDb3Eml0vUbu4b8G6qIZAucIhoc6EFE=;
 b=dHI9Xu21U4dmVvIr8fZvTa9QWbPBH71FFCijsyh0J2rPkkWNMNZcBzMJ+O3dTlMixTpnGQts/3qK1ovfOwhT7K0oJkQQDL2+0ssD/lb+p0pD4yfpTs8dj7H8AWGIe3rQSuPV98cABOaT/6JsxJzZB1ZO/Nez+Tg4rP4SW0V7rdX8uG1sq59VvN9f/Nc7r2qEYmhsRmVy2wFEE78rFgtyudHEHrZft9dtxm6LxrEe8Z3miPK6WRurMXLBxK26Fozucyq1i8ouy3mlcyPbbXOKMuo+yl+C6WOiSqA2r1EC6E8eoeYVkQAIBNqNxJZ6k9fPpEmG0kOv7z4aEw/IG8YUvg==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 16:21:09 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:21:09 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v8 5/9] imap-send: enable specifying the folder using the
 command line
Thread-Topic: [PATCH v8 5/9] imap-send: enable specifying the folder using the
 command line
Thread-Index: AQHb0LWvzEpWVVyFhUSQjB1lwmrzzA==
Date: Thu, 29 May 2025 16:21:09 +0000
Message-ID: <20250529162020.45187-6-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250529162020.45187-1-gargaditya08@live.com>
In-Reply-To: <20250529162020.45187-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|MA0PR01MB7067:EE_
x-ms-office365-filtering-correlation-id: c17a59e1-15c3-4046-dfa1-08dd9eccd237
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnVpqwGBbaZZW1pMskFQwysgFgQakmuqJzv8LW81XRu6+2sy/CGhpbJN1r3tITBGUUUmVlSXDAdyOazlIhmo/CQB+2nmc/bNtNojnua9PTsrryYW/5kPFPkPOhG+6oBqQg7fUW9VQs5eFt8xvv2fCF+DFAouS6y7AkJzRyAB/SJQet+xMrTqls2zsZBU/LJdfa1medSrbl7fcr/r20j3NtMF6xnWMdOdhQFKU6eGqb2CfMFFZitt0HpcoAdhqPi6MhRSzeu4V11zLsay5SdLcCU/LdkjhiCu2c3epF83bPDHdtN96nHIDCx8PtXIApCr295e1rcxhz69yDR0bn08H9to+nId3VJExilo9c5sg+a9rr5/T8Xornk846ZlIYDx1ith1UQGZgQnBxfGdWytaRYxRzu/3bWauD2AO/RaNVU/+nETFvCWjpr0oowtv9lhQbm5EkAVT7NVLDNy9W9blQeshoYLkR+Q+EnZ60u2poRoV3K2a33yECNkbFFnXAyweK8yO53sBISxKVXPdn8iHgOP1cnnD0U0T+eZZ6HAAobjMvfn3rYsuWnysHEkDI4cGt+yVbgAgck2Nn5WtffnXKo3eX1rhh6WrMXX0gY/SaVXSFApmaXbhWhsoAu1gro0vdB08ChK47u8cj9kqiqdmR6qZiBOkJu9f6T/lXxB1Ly0uRrn7mb2Sc5X7mrevh66Ovf7fwZgdpV/Q2kh8gkErHWKWlbKJpwqlez13+Rp9jYNU=
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|19110799006|461199028|7092599006|8060799009|8062599006|15080799009|102099032|440099028|3412199025|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?pifIEdxGY2RUZVb362OJm40FyvXUfxbV5RR+PfjepZvAQmhizGWm3STFHw?=
 =?iso-8859-1?Q?0hl0o8m3bP5vYyvCdEQDGW4qB7FlGOU32vdT/Oyjjpm7G6do3yjP4VBS9N?=
 =?iso-8859-1?Q?Vr3VRJCEKqHpGj39iRbY83wfAroXwbgH2tyfwZj28ZktnmyxTZF8+HTOsA?=
 =?iso-8859-1?Q?wUnrOJHt3VFNX+RU27Vftg/9xkJsoujf7uMIq/Zd/LthsoseKKoAqZBfjS?=
 =?iso-8859-1?Q?Y6Rl01sTZt9DddRGHzpDMLgkYG95phfi8OKfXAgtzHvbdX0kDR8cebfdYI?=
 =?iso-8859-1?Q?1Flcor1SmgzQvOHOEralCDB+LCXT9ckmFfomINuWLcKYZ+OqdgY/MvZ9zS?=
 =?iso-8859-1?Q?RWwj801WJ/Ayxt44dZvhzqYrvz01rFLxWxjJMfb7uAuYf0yYBp4Xk7bNIM?=
 =?iso-8859-1?Q?9U8M/UQnz/WbCQzvejkTy8YkV4rpvIBhWjCDQpvtbTZEI2YQZ7SZ/SG+5G?=
 =?iso-8859-1?Q?bE17LdRUXY7NgoXWASLaZ3HTIjNXwXVD3ihWRX5w9+CGPGDZrEuiOVkDZV?=
 =?iso-8859-1?Q?8rY0cNZhZ2P6/BdG0Mj1Yyypa1skvaxVanmqfkLEWgQXXQqIsF33BpN2Ri?=
 =?iso-8859-1?Q?oKcwDjZS57yu+dXXjUZ/nAAo7bksESK+NBYqy9ooZvfRoxDgDQ0LiCGVjz?=
 =?iso-8859-1?Q?W5kCOfNI7tSj2pnIe/aXRz9MTr2ZuoDCdeLPi934nnMgYFnrKivTVMt8W4?=
 =?iso-8859-1?Q?er+ay6uHisccS2Rkx2uIGBKoMWIoMv2xs3KWptJiKAUqa6wvPqpAcfTFyH?=
 =?iso-8859-1?Q?zdBipHLroK9IzV+Z9ut/Xt2R9KX3FT573s3EwXg7FpTdydjYjybrDJFB3J?=
 =?iso-8859-1?Q?Z9I9cRtIiegsrAdViU2p96Uf1eMIbgoq0OJXUJLnVV9+iD+g/Ap7kNNdIQ?=
 =?iso-8859-1?Q?1RAj0G4VM3jfLFc/OdZmOiEGeYRW1gK1JXpAQbToM9ehWYAE0X6dAPOvrc?=
 =?iso-8859-1?Q?mSFal3Wn9uW9WixZQgZ/lAUCoJ6tg10tOFNbl/0hGGzkTiyz3c6ff593vI?=
 =?iso-8859-1?Q?Sb+8cmG5yPdWkt/Dm0f0UtGZK0I+B7zed3eHhfZQ4j9cbDPKrwOF1qJwgB?=
 =?iso-8859-1?Q?M+JlKqjnM+2v4S53vJEHRsUdJ72tR/y1wKDyPr82qmuXtIStQORRdYhDgO?=
 =?iso-8859-1?Q?QomIEpkuHB/uBM1+eN2zTDd6ouPlUBwClt4iFsI+3EDHtkEZp/rF7F8Xkx?=
 =?iso-8859-1?Q?+0jUcdcPetBX7urlEOuy94wXft9CMuGW/8E=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3kY7TVc5cw70qBalKXM6pIkmBoqZfL8SPzTcnJk0ONBjpPc6mHpM4g7Z0u?=
 =?iso-8859-1?Q?QudOxmdEhwEilHRMk99wJ9CCxqQthJxhhEb/z5HdM8kz6uE7mZNbrQP5Ma?=
 =?iso-8859-1?Q?PPfNvTqFtxEoKIhgqUmbqdv/ojcfzZYyMlWbBXnm0BhEHUfS5gNsq16o6e?=
 =?iso-8859-1?Q?JA9PfPNcdRmABi+nG08c/5tlZuKuWR9aQ4VVQgtUKMMyGViuV3Z03RWspO?=
 =?iso-8859-1?Q?dF9xyXILQEmIO4iQAt1llmZ93sgNj+t9O0mQvXe7VR6wwhXf3DNMrRlW1X?=
 =?iso-8859-1?Q?jiXJKM+jWVzcY16CtrTbNucX43H3egAQ7Mnt8CAgJxoTTSI2+G4bbxngTs?=
 =?iso-8859-1?Q?d9zh43+bmAF73Jtm08YFqoP5myhjn8YPZVcM//dySEjwS1UKuHabjK8c34?=
 =?iso-8859-1?Q?IAhXn8WStVnhhbQKSi8cVgORMnNwjoE5/Iho9ntpeVTRWEnt/uuRaAIhGM?=
 =?iso-8859-1?Q?i8+3Fpb/ep5PkQcUbPe8BWy1/2K3BEfpjr5WViz0qB6fNJKblUcT4zXwca?=
 =?iso-8859-1?Q?IHmSCjkVhffZg5Zw+q+qB1C3cikh8CMw6Aj3LzxAmKUO72SR/bs954GR9A?=
 =?iso-8859-1?Q?ANxmDhWhqx4N636QN5jXQlUbIy4u8kTd4heAKBBLfpWQKOwXUKVh46QBri?=
 =?iso-8859-1?Q?EjzmzasuYXIUUXGI46G8vk/4pGrh2FfHIOvUo0fSKXji+aU57+gQTnKGWh?=
 =?iso-8859-1?Q?OX0b1TvY4hJM5sOFjZwih1NKYGBqs4pZTmYHWIWFUUayLe4lymuMtM+UCI?=
 =?iso-8859-1?Q?g9mWV8ttwoJqmkNYwBeRA2TpDARi8vcoXBNXR7xbNeWLgvGDAt+bTBI5fi?=
 =?iso-8859-1?Q?NZBqGcaxtry65uy+G+rLVGl7LA6y9axBuYuQVJrfGpTOdWu+5dUEyckaMM?=
 =?iso-8859-1?Q?x14g0JTLlKPdFCXP4flxos9cbuGbHsNkUxi/tEb2DCK5z0t2XdBFxPQToo?=
 =?iso-8859-1?Q?egKb1zh5jhaE8vYwzTXR5EsNjDcUC99I0yewwbFGXCec/8xk10yTWzsq+w?=
 =?iso-8859-1?Q?42dXkTTzC4DutAWkjde3mg9cNs113Cqo/Tlp11Aaqd0iFSRzCclS0BJrLa?=
 =?iso-8859-1?Q?+ntsWWObAsTjAK++prRiDZXIrQPSTyabtsztgUCXN0P0iDVP1Py5dA/eAd?=
 =?iso-8859-1?Q?N6mAcwkkHlR3U4O3MysSguN+EoJAbryKg12ZiKfXf/JNe7JPoF2i9+k1ai?=
 =?iso-8859-1?Q?kgMARm+lIT04zxYFrD2ds++YSQF7lCGd8PEaB5G44gf+ZvdCHUWspFvqNr?=
 =?iso-8859-1?Q?3e/By0qfzeBR0Rcb6RW/yK7sQaUpI8Wh0dM8qyzqE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c17a59e1-15c3-4046-dfa1-08dd9eccd237
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 16:21:09.3676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7067

Some users may very often want to imap-send messages to a folder
other than the default set in the config. Add a command line
argument for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |  5 +++--
 Documentation/git-imap-send.adoc | 15 +++++++++++----
 imap-send.c                      |  9 ++++++++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.ado=
c
index 24e88228d0..829d9e0bac 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -1,7 +1,8 @@
 imap.folder::
 	The folder to drop the mails into, which is typically the Drafts
-	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
-	"[Gmail]/Drafts". Required.
+	folder. For example: 'INBOX.Drafts', 'INBOX/Drafts' or
+	'[Gmail]/Drafts'. Required if `--folder` argument is not used. If
+	set and `--folder` is also used, `--folder` will be preferred.
=20
 imap.tunnel::
 	Command used to set up a tunnel to the IMAP server through which
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send=
.adoc
index c3a46070ac..a35f278baf 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -9,21 +9,23 @@ git-imap-send - Send a collection of patches from stdin t=
o an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send' [-v] [-q] [--[no-]curl]
+'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
=20
=20
 DESCRIPTION
 -----------
-This command uploads a mailbox generated with 'git format-patch'
+This command uploads a mailbox generated with `git format-patch`
 into an IMAP drafts folder.  This allows patches to be sent as
 other email is when using mail clients that cannot read mailbox
 files directly. The command also works with any general mailbox
-in which emails have the fields "From", "Date", and "Subject" in
+in which emails have the fields 'From', 'Date', and 'Subject' in
 that order.
=20
 Typical usage is something like:
=20
-git format-patch --signoff --stdout --attach origin | git imap-send
+------
+$ git format-patch --signoff --stdout --attach origin | git imap-send
+------
=20
=20
 OPTIONS
@@ -37,6 +39,11 @@ OPTIONS
 --quiet::
 	Be quiet.
=20
+-f <folder>::
+--folder=3D<folder>::
+	Specify the folder in which the emails have to saved.
+	For example: `--folder=3D[Gmail]/Drafts` or `-f INBOX/Drafts`.
+
 --curl::
 	Use libcurl to communicate with the IMAP server, unless tunneling
 	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
diff --git a/imap-send.c b/imap-send.c
index d0c7bac030..337f1049ca 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -46,12 +46,14 @@
=20
 static int verbosity;
 static int use_curl =3D USE_CURL_DEFAULT;
+static char *opt_folder =3D NULL;
=20
-static const char * const imap_send_usage[] =3D { "git imap-send [-v] [-q]=
 [--[no-]curl] < <mbox>", NULL };
+static const char * const imap_send_usage[] =3D { "git imap-send [-v] [-q]=
 [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
=20
 static struct option imap_send_options[] =3D {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP =
server"),
+	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder=
"),
 	OPT_END()
 };
=20
@@ -1762,6 +1764,11 @@ int cmd_main(int argc, const char **argv)
=20
 	argc =3D parse_options(argc, (const char **)argv, "", imap_send_options, =
imap_send_usage, 0);
=20
+	if (opt_folder) {
+		free(server.folder);
+		server.folder =3D xstrdup(opt_folder);
+	}
+
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
=20
--=20
2.49.0.638.g602e07a80b.dirty

