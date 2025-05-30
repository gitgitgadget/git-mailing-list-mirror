Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010010.outbound.protection.outlook.com [52.103.68.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92532226863
	for <git@vger.kernel.org>; Fri, 30 May 2025 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748605040; cv=fail; b=NmJMLm2zicCLFoxnt5FYiTAO0a8DQNRKOqiUFv2LUcysYjzCsewvlnAlgMw2GviWrllWt52ZJ12x74t7DY1t0pPESzyr7iui9cGq4y28FMHT9TGjIIvPVe1rp6eh/BS1d29VGk/3WdtCwkuVQECdCAzvUPllavDXvqXWo1p2hyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748605040; c=relaxed/simple;
	bh=xC3fijxSMQ21tlgKTEULKZR1Wg0cCCbNSSZoNDWmpNw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OSUw17jVV+kBMcw0lBIqpoYkENEswZ6vvQIcV5ev6Rfxi/Tv64b/2vN2DYdDaiKORPwLeWo8SPXSZALLOUl0MLOTaPZZtoW23NHiEp21ngXKX9ygCo08cSz/ewjC9Vey3GCYx3ebZyaHn8TiQQv/RcFvNu34qyVtR2BUcFDbLZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MElSj+Ki; arc=fail smtp.client-ip=52.103.68.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MElSj+Ki"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wakwI+Hpj7LmGXoNYPAw+/8ouNYDriWaf3BnstFVmGbaL3vNn4uC19KE1nfFAWvLZzdanhO8OZYttIcmzQQScq4orAni2be1MlRc0vktp5MlzYy0dCZWOkLHfa3gxpk32RiGt5QrIyLklCKofPYHQS94mSmJ92wKWsFVG87mBrsrnOHqfDH5YS2Uva2JFRGGM0F1KDGiL9Ey/8DANfLI6ETpz6ahFLoJvQad6sP07oqjL66CPOYYXjF080a8lVzpMWkxD5ighmbsW/n5GRgo9dKZNAJusgYWpuvLzcdlJtPLT0Y/qDQJ8tJ5rrMWkInD7CJKGWu/EQ6iZRmvdj+5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rO8er39scMLRH8C5TEIPjPuWv3bSNTEaUIe5OALZF8o=;
 b=h1oiwNhHjFt/923rwGYomxJVgeBB4InMHCsrSnYjm9EUu2/sU6G0S11jl3fwP4uhVmMZW4vnb6oPTqrHHwBa5v3b60fjuh4xgQKoXQSG7/A0RlTqW9Emo6FRHCmrHSY02/aY5TEMLSwQqfbApU8ulHoBhSWNvGdtQ1keS0ADupRWMBKcSZcRrAG6z+oQKgnaNeEfTmxzOkT7rHS5WDDI0JGB3CZ24GiKFQvp9IQ6GMk9UYgpQohp8PFQtz2Mu0dmv8H/FJGKaBQ6D6acHjk4f4hJMgQ0VuNcuDEwRoG1jYTOov2rww3ksWhQjVihXu4Wwd+4P7H6wyzXpdAsTNMqNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rO8er39scMLRH8C5TEIPjPuWv3bSNTEaUIe5OALZF8o=;
 b=MElSj+KiomQSBrIgdkqpFhQXzJ8mFgOEkxO5FPj9qTXn1TuiwQzXdTVLrOwaxB4Po5/WR4g2Z50xTWscBHJiwaN1GbyoBBCyY/o/Bg3COH9Wmzmg2otG2yGfORwEh98AWfcRiHBwkPDJByMIC79857qZ6NQ70w7FWi6U2LEtxO5JI8tKWFEFF8ltJC2b3WQy307Ax3Q946PUu0/56ZF9xuOa/BXmCRga2GLT9rxMxonYNf/8oBBX/RS9zAGhglOOjJcj9CAz/BGjUa5rJv71ipTb7Xl5NsxjamNuj5VcsmiJrxQZWpfd0CPX+Qfok9jj5Fakw9Fv9P7N7Z1krAZLIg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 11:37:11 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 11:37:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>
Subject: [PATCH v6 2/4] docs: improve formatting in git-send-email
 documentation
Thread-Topic: [PATCH v6 2/4] docs: improve formatting in git-send-email
 documentation
Thread-Index: AQHb0Vcu/CJWf4SXw0axbQk7jDEIGQ==
Date: Fri, 30 May 2025 11:37:10 +0000
Message-ID: <20250530113627.8639-3-gargaditya08@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250530113627.8639-1-gargaditya08@live.com>
In-Reply-To: <20250530113627.8639-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNZPR01MB4415:EE_
x-ms-office365-filtering-correlation-id: 9cb613d2-8a33-4bb7-acf7-08dd9f6e50f3
x-ms-exchange-slblob-mailprops:
 BP6inkMtVg5OhxqEuIe+Toz6TZPlcmhHOFj+wSVfdKB3Mq+u7zZog5S6ITrpZFH+EV2KMZbRJDJptr7IWWyt4ji4wm4U2nbga+DA65tv9qbx2iuMnuQHniIrOZubKqYNaPl9Tj6ja0e6XK+aUWZg3X/7Dsq7xQA0+F2lBiv1Me8mHMrmRHzTx85FNcmXvZVDITvQF2YIo7gCBMVg7Vox9TubCxq72c551ReJK2ac6iYy5w7Vs6tSdpZfTq1rZbHYlEaQC6DmTVCERAymr8e9IkkCmQH3wTT7vxVE4RdmjfysQ0+K4iIxS8/Ivd3SDGZhdayJWN/JBHrxIUWOz5pVLGS0iWKGgMOpGCHKgYJ0DeY2gAjJIM4y7n7hIHyRU43d+yM5PC+GHYk8CmoZbkrZLx1NLGbADYl691nywo6aER1pkrYtKbxtLeCzWsLhztq0JZ5Go9p3HULfooVwVHlX4yTTAUlhnt6IjT6ebSeyULNYTHSJVrMMehIY+t3cvdP2yQbQIs2Xig+RbyFihI6f2LkUfoHKFf/2FmTkmq7VF3iYghTjKH6xdffhmPhqlCWc6jsL1i55mWecoRjNSNlomHtKn/4ekaeZqfXPkgSv3UpEfCM017yNdFXYrL80M63umxwj1sVfKPZDsdCL0MSDKSp+s9wRhwMyfuOT9Zq/+n2riomLOkV5ErEoPzyN5apDANQSR293VdKxII0CDabNUDX1JKJNTqiJGmGXiH+P7Gde5lf4m4VtvuJTSTDD9c1JwwS4NuOdgGnfQqQZUygheoxQz0Fpmvia8rOmtjBcyZq3yGO8xUM25lgtwCtfRGeoVzMuLImlID7UjcAVu1hpGnNUZkv8ArMZoVsfXRkrckM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|8060799009|461199028|38102599003|41001999006|19110799006|8062599006|15080799009|12121999007|3412199025|440099028|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?NW1lG8sS17LRk9yxmi18GAeu8Y1npP2EkaxQclNp0Pd1VP2Xdc0FkEG0z1?=
 =?iso-8859-1?Q?S7/A9OzuhOSYWk6xszd7OT5552JYZBxSfh8dTMVu/djbONiCpoJgGIE3wF?=
 =?iso-8859-1?Q?vm1VWi/KsajcGg/boFGKYqs4fihXibaj2sF+neAChRZRSUC7yW1aFV386p?=
 =?iso-8859-1?Q?p+AKGSm5I6KJKWyxRYjbSRdm1SJ07wko1K5fdWL+9fvAGFS24KtzPNgffp?=
 =?iso-8859-1?Q?K77Ahp5T9GXaQbEe006jRp7vOMXcN3NbZZB4IBv57Nko+mKv47v+bVoNlk?=
 =?iso-8859-1?Q?O5+4hPX8wMo/l5q0VElRpc6q/aTZh0XSjlRrcCMO0+UE9oqYh0+EVQaZWI?=
 =?iso-8859-1?Q?ZLCkCHCxRL2cymH7WdyUwvq3qQqaXgLxxnJJjrdUVoMucVU+V16LCJJPzU?=
 =?iso-8859-1?Q?r5wcUXrAK2QenSdE5WbIo+ILdL5SkfXkDjoNvcd3VKNZWMTeqGbAFnhnsO?=
 =?iso-8859-1?Q?bckbObYxsnQ1Z6VwCjWHEMHkUK6JleP045sINVcZl6IwRxjj2IDyqO+HZK?=
 =?iso-8859-1?Q?jzJQDnfCCpZxM0inLZPJSq80xun/bKXujeUmxu4U8d8mF6dCe4KqBMwcSm?=
 =?iso-8859-1?Q?3mk8ZB7CkFQAjfgU7+pPzAuD3yIsCuAAIs5SBZAyzP74VqMIk4+jlAXbcs?=
 =?iso-8859-1?Q?rL7jgHypowvexcqQ9QawETOBRF9rQLoaTYLXn+MxtuGK6A9N286net0w43?=
 =?iso-8859-1?Q?Qvwcf/YJRpnTSN4b2HIPeBy1zv30MOuaAOvjhPHcNMwUmWnqfZvtYLPHmX?=
 =?iso-8859-1?Q?7lTnP2CGlYUS/Nee/+iaL7hX/DfXKVRLU0lgJe2LJAKcLOjmV5F14EkJhi?=
 =?iso-8859-1?Q?nPB/+40O1mXI3wtHh1F2cabLjpA0JyM7CcI+l9UwPPvh2PJ9qG8EObQSl5?=
 =?iso-8859-1?Q?5lsqwZI8c6JYeYUz3K8m4ROGBqars397N6FPCWj/XTGzapruSkqiD/iP2C?=
 =?iso-8859-1?Q?1d0UFEn6w0p0a0d7Em4Zg5P1kmrKfMVgaEo5T7kiqJqsT0jUPVKJL5c0aG?=
 =?iso-8859-1?Q?rEdoycY5YFyURy9R/dncAwro/RwUSZk2k61hIzGuJkDVcIG4I3vl6lxap2?=
 =?iso-8859-1?Q?ZoqfEBKcax8K2KnUKQpr1hv64twc5FDFEiH/Xg3L+xfvIw7HrOkCPDAr9N?=
 =?iso-8859-1?Q?7wCjDlcPlJ/3KgK5CdNKwmq7AxKHKJBVK65Qg++ry5rKroeLfNbIDmdHlP?=
 =?iso-8859-1?Q?vOic0fGT59IybUm0nCVAjyZCepX5HezdYuBnKhEflq9bzrft8WKK+af6SK?=
 =?iso-8859-1?Q?KfDjOSySAGvBZhqjEFxx3y5JiOyOWV740RVPpYuVcSTEk5jVLQZ/jD/p6H?=
 =?iso-8859-1?Q?SbWH?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yS60Ebgz+ZdFJi5b6wf8dYKk2DSzJ8YOJCqBLeB+4CAxFWNavcXNddJ8Cf?=
 =?iso-8859-1?Q?NiyXHjT43lBuw+aYNeAqYqF0E2DuSo0N8uizEuCR+gRn/yoTE96+TMpJiw?=
 =?iso-8859-1?Q?ynPhcdTPVvSoOin1QOxjctQ1eGIaNn5sjPKA5OeVi/LH98YnVFJx2bvkws?=
 =?iso-8859-1?Q?WKCmzIUvwE0z4UQK1yMEwpwv/TaHp+OMoEPm7pEuLhuzVLdN7KXRpk2+oT?=
 =?iso-8859-1?Q?2uesMMt4fKYR6xW1LOiHVuww3nYyusZPajNpMDuSYGYgl7EIIT/KhlQ+cV?=
 =?iso-8859-1?Q?AfouHcxc5U7EC/oChCxXThX2G139KrRAa5ctg5WUcQ1RQ8UOMkO9yBuuQb?=
 =?iso-8859-1?Q?4U7V5/Mh2gWtyn3S1oSBmolX1EvvBh8EAIUcy1vtZL8Qkr+WGxNhEk/c0F?=
 =?iso-8859-1?Q?1Zc5ARFRdLswiSwmHWNvSYiUjkh4ue7UrPGNfbE4cuGBG6dS5eMjdtDD21?=
 =?iso-8859-1?Q?ymqb0fKKbF8SCijocZvn+8Aw/yOQ0eWYYOYHY96/ef0QOAuNoCq421hDxH?=
 =?iso-8859-1?Q?ldsBLLEjOCQFPsGi1YnZvYXva6Ord/qixzR9oDvKCbCyNpjzNCEzr3Srv6?=
 =?iso-8859-1?Q?NdLIT6GGxvJ1pf1pYWCKpjgq0+qrYd4Lwpvqq/M5etkyq+t0fQrAELblWa?=
 =?iso-8859-1?Q?uXngm7xgdp6lKdDdW/ygR3csqSKx0UenKgYHkAk7spesoe3LCEcZRpKo40?=
 =?iso-8859-1?Q?bo3FnC2FcOFHCEst7HLDJhFV/s26yNn8wEgzXDukNb5lBAY6GySa/yjFuz?=
 =?iso-8859-1?Q?MLEPLeIwnld7scEStO5BzF92g34hPjPxt7tBb29Qhbs7wrZv9DQm54T8d8?=
 =?iso-8859-1?Q?Ue+c0WxFILUeft9tMJAvHEG7U7kXhuBLGIR27OqFVNdhuqMdJkB/xiURfc?=
 =?iso-8859-1?Q?mbVovTS8wi/dPXiMV3cYx8OdD6jfnqqvkLQ1Fz54lxJmDJjQ/83zdJXT8L?=
 =?iso-8859-1?Q?+S5Qlwh2pYTQrcVwk+7CUzvsbaFGTqCAUTLw8bdZ4IOH1nCBskNFZ6Hvrf?=
 =?iso-8859-1?Q?Buz8w63napG6XPtGjlKO2LntNDjOjzR/JNm6WUOLviRHQOOuEuqAd4T1h/?=
 =?iso-8859-1?Q?/3b0AL4tyXJkfYy9SJJF9Ot6fDNJuuZMgCCGAkJ2U64tgStiOkWKUs0Vg2?=
 =?iso-8859-1?Q?Ld01I42zq+COlsb3QYq/QBP0nv6qGEbu7xKNhullKHKpX8sJtkf1ew6SuT?=
 =?iso-8859-1?Q?umbYtVtzpKnBL8MA3jh4COlcC1la/3t6p7PdLGvBn/cGn0xvx4ttukf/ph?=
 =?iso-8859-1?Q?N4Y9Gaz+Sh3L+nMDpS7KSDz15boorhuvmmUfKe3So=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb613d2-8a33-4bb7-acf7-08dd9f6e50f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 11:37:10.9605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4415

The current documentation for git-send-email had an inconsistent use of
"", ``, and '' for quoting. This commit improves the formatting by
using the same style throughout the documentation. Missing full stops
have also been added at some places.

Finally, the cpan links of necessary perl modules have been added to
make their installation easier.

While at it, the unecessary use of $ with <num> and <int> placeholders
has also been removed.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/sendemail.adoc |   8 +-
 Documentation/git-send-email.adoc   | 178 +++++++++++++++-------------
 2 files changed, 97 insertions(+), 89 deletions(-)

diff --git a/Documentation/config/sendemail.adoc b/Documentation/config/sen=
demail.adoc
index 5ffcfc9f2a..0b1b2766f5 100644
--- a/Documentation/config/sendemail.adoc
+++ b/Documentation/config/sendemail.adoc
@@ -19,9 +19,9 @@ sendemail.<identity>.*::
 	`sendemail.identity`.
=20
 sendemail.multiEdit::
-	If true (default), a single editor instance will be spawned to edit
+	If `true` (default), a single editor instance will be spawned to edit
 	files you have to edit (patches when `--annotate` is used, and the
-	summary when `--compose` is used). If false, files will be edited one
+	summary when `--compose` is used). If `false`, files will be edited one
 	after the other, spawning a new editor each time.
=20
 sendemail.confirm::
@@ -101,7 +101,7 @@ sendemail.signedOffCc (deprecated)::
=20
 sendemail.smtpBatchSize::
 	Number of messages to be sent per connection, after that a relogin
-	will happen.  If the value is 0 or undefined, send all messages in
+	will happen.  If the value is `0` or undefined, send all messages in
 	one connection.
 	See also the `--batch-size` option of linkgit:git-send-email[1].
=20
@@ -111,5 +111,5 @@ sendemail.smtpReloginDelay::
=20
 sendemail.forbidSendmailVariables::
 	To avoid common misconfiguration mistakes, linkgit:git-send-email[1]
-	will abort with a warning if any configuration options for "sendmail"
+	will abort with a warning if any configuration options for `sendmail`
 	exist. Set this variable to bypass the check.
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 81f8cbc6f3..04e1c459b4 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -21,7 +21,7 @@ Takes the patches given on the command line and emails th=
em out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
 last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email, as well as options understood by
+be passed to `git send-email`, as well as options understood by
 linkgit:git-format-patch[1].
=20
 The header of the email is configurable via command-line options.  If not
@@ -35,11 +35,11 @@ There are two formats accepted for patch files:
 This is what linkgit:git-format-patch[1] generates.  Most headers and MIME
 formatting are ignored.
=20
-2. The original format used by Greg Kroah-Hartman's 'send_lots_of_email.pl=
'
+2. The original format used by Greg Kroah-Hartman's `send_lots_of_email.pl=
`
    script
 +
-This format expects the first line of the file to contain the "Cc:" value
-and the "Subject:" of the message as the second line.
+This format expects the first line of the file to contain the 'Cc:' value
+and the 'Subject:' of the message as the second line.
=20
=20
 OPTIONS
@@ -54,13 +54,13 @@ Composing
 	`sendemail.multiEdit`.
=20
 --bcc=3D<address>,...::
-	Specify a "Bcc:" value for each email. Default is the value of
+	Specify a 'Bcc:' value for each email. Default is the value of
 	`sendemail.bcc`.
 +
 This option may be specified multiple times.
=20
 --cc=3D<address>,...::
-	Specify a starting "Cc:" value for each email.
+	Specify a starting 'Cc:' value for each email.
 	Default is the value of `sendemail.cc`.
 +
 This option may be specified multiple times.
@@ -69,14 +69,14 @@ This option may be specified multiple times.
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
 	to edit an introductory message for the patch series.
 +
-When `--compose` is used, git send-email will use the From, To, Cc, Bcc,
-Subject, Reply-To, and In-Reply-To headers specified in the message. If
-the body of the message (what you type after the headers and a blank
-line) only contains blank (or Git: prefixed) lines, the summary won't be
+When `--compose` is used, `git send-email` will use the 'From', 'To', 'Cc'=
,
+'Bcc', 'Subject', 'Reply-To', and 'In-Reply-To' headers specified in the
+message. If the body of the message (what you type after the headers and a
+blank line) only contains blank (or 'Git:' prefixed) lines, the summary wo=
n't be
 sent, but the headers mentioned above will be used unless they are
 removed.
 +
-Missing From or In-Reply-To headers will be prompted for.
+Missing 'From' or 'In-Reply-To' headers will be prompted for.
 +
 See the CONFIGURATION section for `sendemail.multiEdit`.
=20
@@ -85,13 +85,13 @@ See the CONFIGURATION section for `sendemail.multiEdit`=
.
 	the value of the `sendemail.from` configuration option is used.  If
 	neither the command-line option nor `sendemail.from` are set, then the
 	user will be prompted for the value.  The default for the prompt will be
-	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
-	set, as returned by "git var -l".
+	the value of `GIT_AUTHOR_IDENT`, or `GIT_COMMITTER_IDENT` if that is not
+	set, as returned by `git var -l`.
=20
 --reply-to=3D<address>::
 	Specify the address where replies from recipients should go to.
 	Use this if replies to messages should go to another address than what
-	is specified with the --from parameter.
+	is specified with the `--from` parameter.
=20
 --in-reply-to=3D<identifier>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
@@ -112,14 +112,14 @@ illustration below where `[PATCH v2 0/3]` is in reply=
 to `[PATCH 0/2]`:
       [PATCH v2 2/3] New tests
       [PATCH v2 3/3] Implementation
 +
-Only necessary if --compose is also set.  If --compose
+Only necessary if `--compose` is also set.  If `--compose`
 is not set, this will be prompted for.
=20
 --[no-]outlook-id-fix::
 	Microsoft Outlook SMTP servers discard the Message-ID sent via email and
 	assign a new random Message-ID, thus breaking threads.
 +
-With `--outlook-id-fix`, 'git send-email' uses a mechanism specific to
+With `--outlook-id-fix`, `git send-email` uses a mechanism specific to
 Outlook servers to learn the Message-ID the server assigned to fix the
 threading. Use it only when you know that the server reports the
 rewritten Message-ID the same way as Outlook servers do.
@@ -130,14 +130,14 @@ to 'smtp.office365.com' or 'smtp-mail.outlook.com'. U=
se
=20
 --subject=3D<string>::
 	Specify the initial subject of the email thread.
-	Only necessary if --compose is also set.  If --compose
+	Only necessary if `--compose` is also set.  If `--compose`
 	is not set, this will be prompted for.
=20
 --to=3D<address>,...::
 	Specify the primary recipient of the emails generated. Generally, this
 	will be the upstream maintainer of the project involved. Default is the
 	value of the `sendemail.to` configuration value; if that is unspecified,
-	and --to-cmd is not specified, this will be prompted for.
+	and `--to-cmd` is not specified, this will be prompted for.
 +
 This option may be specified multiple times.
=20
@@ -145,30 +145,30 @@ This option may be specified multiple times.
 	When encountering a non-ASCII message or subject that does not
 	declare its encoding, add headers/quoting to indicate it is
 	encoded in <encoding>.  Default is the value of the
-	'sendemail.assume8bitEncoding'; if that is unspecified, this
+	`sendemail.assume8bitEncoding`; if that is unspecified, this
 	will be prompted for if any non-ASCII files are encountered.
 +
 Note that no attempts whatsoever are made to validate the encoding.
=20
 --compose-encoding=3D<encoding>::
 	Specify encoding of compose message. Default is the value of the
-	'sendemail.composeEncoding'; if that is unspecified, UTF-8 is assumed.
+	`sendemail.composeEncoding`; if that is unspecified, UTF-8 is assumed.
=20
 --transfer-encoding=3D(7bit|8bit|quoted-printable|base64|auto)::
 	Specify the transfer encoding to be used to send the message over SMTP.
-	7bit will fail upon encountering a non-ASCII message.  quoted-printable
+	'7bit' will fail upon encountering a non-ASCII message. 'quoted-printable=
'
 	can be useful when the repository contains files that contain carriage
-	returns, but makes the raw patch email file (as saved from a MUA) much
-	harder to inspect manually.  base64 is even more fool proof, but also
-	even more opaque.  auto will use 8bit when possible, and quoted-printable
-	otherwise.
+	returns, but makes the raw patch email file (as saved from an MUA) much
+	harder to inspect manually. 'base64' is even more fool proof, but also
+	even more opaque. 'auto' will use '8bit' when possible, and
+	'quoted-printable' otherwise.
 +
 Default is the value of the `sendemail.transferEncoding` configuration
-value; if that is unspecified, default to `auto`.
+value; if that is unspecified, default to 'auto'.
=20
 --xmailer::
 --no-xmailer::
-	Add (or prevent adding) the "X-Mailer:" header.  By default,
+	Add (or prevent adding) the 'X-Mailer:' header.  By default,
 	the header is added, but it can be turned off by setting the
 	`sendemail.xmailer` configuration variable to `false`.
=20
@@ -179,8 +179,8 @@ Sending
 	Specify the envelope sender used to send the emails.
 	This is useful if your default address is not the address that is
 	subscribed to a list. In order to use the 'From' address, set the
-	value to "auto". If you use the sendmail binary, you must have
-	suitable privileges for the -f parameter.  Default is the value of the
+	value to `auto`. If you use the `sendmail` binary, you must have
+	suitable privileges for the `-f` parameter.  Default is the value of the
 	`sendemail.envelopeSender` configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
=20
@@ -189,8 +189,8 @@ Sending
 	be sendmail-like; specifically, it must support the `-i` option.
 	The command will be executed in the shell if necessary.  Default
 	is the value of `sendemail.sendmailCmd`.  If unspecified, and if
-	--smtp-server is also unspecified, git-send-email will search
-	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
+	`--smtp-server` is also unspecified, `git send-email` will search
+	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH`.
=20
 --smtp-encryption=3D<encryption>::
 	Specify in what way encrypting begins for the SMTP connection.
@@ -209,7 +209,7 @@ Sending
 --smtp-domain=3D<FQDN>::
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
 	HELO/EHLO command to the SMTP server.  Some servers require the
-	FQDN to match your IP address.  If not set, git send-email attempts
+	FQDN to match your IP address.  If not set, `git send-email` attempts
 	to determine your FQDN automatically.  Default is the value of
 	`sendemail.smtpDomain`.
=20
@@ -223,10 +223,10 @@ $ git send-email --smtp-auth=3D"PLAIN LOGIN GSSAPI" .=
..
 +
 If at least one of the specified mechanisms matches the ones advertised by=
 the
 SMTP server and if it is supported by the utilized SASL library, the mecha=
nism
-is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-au=
th`
+is used for authentication. If neither `sendemail.smtpAuth` nor `--smtp-au=
th`
 is specified, all mechanisms supported by the SASL library can be used. Th=
e
-special value 'none' maybe specified to completely disable authentication
-independently of `--smtp-user`
+special value `none` maybe specified to completely disable authentication
+independently of `--smtp-user`.
=20
 --smtp-pass[=3D<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
@@ -238,16 +238,16 @@ Furthermore, passwords need not be specified in confi=
guration files
 or on the command line. If a username has been specified (with
 `--smtp-user` or a `sendemail.smtpUser`), but no password has been
 specified (with `--smtp-pass` or `sendemail.smtpPass`), then
-a password is obtained using 'git-credential'.
+a password is obtained using linkgit:git-credential[1].
=20
 --no-smtp-auth::
-	Disable SMTP authentication. Short hand for `--smtp-auth=3Dnone`
+	Disable SMTP authentication. Short hand for `--smtp-auth=3Dnone`.
=20
 --smtp-server=3D<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  If unspecified, and if
 	`--sendmail-cmd` is also unspecified, the default is to search
-	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH if such a
+	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH` if such a
 	program is available, falling back to `localhost` otherwise.
 +
 For backward compatibility, this option can also specify a full pathname
@@ -260,7 +260,7 @@ instead.
 	Specifies a port different from the default port (SMTP
 	servers typically listen to smtp port 25, but may also listen to
 	submission port 587, or the common SSL smtp port 465);
-	symbolic port names (e.g. "submission" instead of 587)
+	symbolic port names (e.g. `submission` instead of 587)
 	are also accepted. The port can also be set with the
 	`sendemail.smtpServerPort` configuration variable.
=20
@@ -269,7 +269,7 @@ instead.
 	Default value can be specified by the `sendemail.smtpServerOption`
 	configuration option.
 +
-The --smtp-server-option option must be repeated for each option you want
+The `--smtp-server-option` option must be repeated for each option you wan=
t
 to pass to the server. Likewise, different lines in the configuration file=
s
 must be used for each option.
=20
@@ -279,7 +279,7 @@ must be used for each option.
 --smtp-ssl-cert-path::
 	Path to a store of trusted CA certificates for SMTP SSL/TLS
 	certificate validation (either a directory that has been processed
-	by 'c_rehash', or a single file containing one or more PEM format
+	by `c_rehash`, or a single file containing one or more PEM format
 	certificates concatenated together: see verify(1) -CAfile and
 	-CApath for more information on these). Set it to an empty string
 	to disable certificate verification. Defaults to the value of the
@@ -298,18 +298,18 @@ must be used for each option.
 	connection and authentication problems.
=20
 --batch-size=3D<num>::
-	Some email servers (e.g. smtp.163.com) limit the number emails to be
+	Some email servers (e.g. 'smtp.163.com') limit the number of emails to be
 	sent per session (connection) and this will lead to a failure when
 	sending many messages.  With this option, send-email will disconnect afte=
r
-	sending $<num> messages and wait for a few seconds (see --relogin-delay)
-	and reconnect, to work around such a limit.  You may want to
-	use some form of credential helper to avoid having to retype
-	your password every time this happens.  Defaults to the
+	sending _<num>_ messages and wait for a few seconds
+	(see `--relogin-delay`) and reconnect, to work around such a limit.
+	You may want to use some form of credential helper to avoid having to
+	retype your password every time this happens.  Defaults to the
 	`sendemail.smtpBatchSize` configuration variable.
=20
 --relogin-delay=3D<int>::
-	Waiting $<int> seconds before reconnecting to SMTP server. Used together
-	with --batch-size option.  Defaults to the `sendemail.smtpReloginDelay`
+	Waiting _<int>_ seconds before reconnecting to SMTP server. Used together
+	with `--batch-size` option.  Defaults to the `sendemail.smtpReloginDelay`
 	configuration variable.
=20
 Automating
@@ -318,7 +318,7 @@ Automating
 --no-to::
 --no-cc::
 --no-bcc::
-	Clears any list of "To:", "Cc:", "Bcc:" addresses previously
+	Clears any list of 'To:', 'Cc:', 'Bcc:' addresses previously
 	set via config.
=20
 --no-identity::
@@ -327,13 +327,13 @@ Automating
=20
 --to-cmd=3D<command>::
 	Specify a command to execute once per patch file which
-	should generate patch file specific "To:" entries.
+	should generate patch file specific 'To:' entries.
 	Output of this command must be single email address per line.
-	Default is the value of 'sendemail.toCmd' configuration value.
+	Default is the value of `sendemail.toCmd` configuration value.
=20
 --cc-cmd=3D<command>::
 	Specify a command to execute once per patch file which
-	should generate patch file specific "Cc:" entries.
+	should generate patch file specific 'Cc:' entries.
 	Output of this command must be single email address per line.
 	Default is the value of `sendemail.ccCmd` configuration value.
=20
@@ -341,7 +341,7 @@ Automating
 	Specify a command that is executed once per outgoing message
 	and output RFC 2822 style header lines to be inserted into
 	them. When the `sendemail.headerCmd` configuration variable is
-	set, its value is always used. When --header-cmd is provided
+	set, its value is always used. When `--header-cmd` is provided
 	at the command line, its value takes precedence over the
 	`sendemail.headerCmd` configuration variable.
=20
@@ -350,7 +350,7 @@ Automating
=20
 --[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
-	email sent.  If disabled with "--no-chain-reply-to", all emails after
+	email sent.  If disabled with `--no-chain-reply-to`, all emails after
 	the first will be sent as replies to the first email sent.  When using
 	this, it is recommended that the first file given be an overview of the
 	entire patch series. Disabled by default, but the `sendemail.chainReplyTo=
`
@@ -363,21 +363,22 @@ Automating
 	the value of `sendemail.identity`.
=20
 --[no-]signed-off-by-cc::
-	If this is set, add emails found in the `Signed-off-by` trailer or Cc: li=
nes to the
-	cc list. Default is the value of `sendemail.signedOffByCc` configuration
-	value; if that is unspecified, default to --signed-off-by-cc.
+	If this is set, add emails found in the `Signed-off-by` trailer or 'Cc:'
+	lines to the cc list. Default is the value of `sendemail.signedOffByCc`
+	configuration value; if that is unspecified, default to
+	`--signed-off-by-cc`.
=20
 --[no-]cc-cover::
-	If this is set, emails found in Cc: headers in the first patch of
+	If this is set, emails found in 'Cc:' headers in the first patch of
 	the series (typically the cover letter) are added to the cc list
-	for each email set. Default is the value of 'sendemail.ccCover'
-	configuration value; if that is unspecified, default to --no-cc-cover.
+	for each email set. Default is the value of `sendemail.ccCover`
+	configuration value; if that is unspecified, default to `--no-cc-cover`.
=20
 --[no-]to-cover::
-	If this is set, emails found in To: headers in the first patch of
+	If this is set, emails found in 'To:' headers in the first patch of
 	the series (typically the cover letter) are added to the to list
-	for each email set. Default is the value of 'sendemail.toCover'
-	configuration value; if that is unspecified, default to --no-to-cover.
+	for each email set. Default is the value of `sendemail.toCover`
+	configuration value; if that is unspecified, default to `--no-to-cover`.
=20
 --suppress-cc=3D<category>::
 	Specify an additional category of recipients to suppress the
@@ -401,36 +402,36 @@ Automating
 --
 +
 Default is the value of `sendemail.suppressCc` configuration value; if
-that is unspecified, default to 'self' if --suppress-from is
-specified, as well as 'body' if --no-signed-off-cc is specified.
+that is unspecified, default to 'self' if `--suppress-from` is
+specified, as well as 'body' if `--no-signed-off-cc` is specified.
=20
 --[no-]suppress-from::
-	If this is set, do not add the From: address to the cc: list.
+	If this is set, do not add the 'From:' address to the 'Cc:' list.
 	Default is the value of `sendemail.suppressFrom` configuration
-	value; if that is unspecified, default to --no-suppress-from.
+	value; if that is unspecified, default to `--no-suppress-from`.
=20
 --[no-]thread::
-	If this is set, the In-Reply-To and References headers will be
+	If this is set, the 'In-Reply-To' and 'References' headers will be
 	added to each email sent.  Whether each mail refers to the
-	previous email (`deep` threading per 'git format-patch'
+	previous email (`deep` threading per `git format-patch`
 	wording) or to the first email (`shallow` threading) is
-	governed by "--[no-]chain-reply-to".
+	governed by `--[no-]chain-reply-to`.
 +
-If disabled with "--no-thread", those headers will not be added
-(unless specified with --in-reply-to).  Default is the value of the
+If disabled with `--no-thread`, those headers will not be added
+(unless specified with `--in-reply-to`).  Default is the value of the
 `sendemail.thread` configuration value; if that is unspecified,
-default to --thread.
+default to `--thread`.
 +
 It is up to the user to ensure that no In-Reply-To header already
-exists when 'git send-email' is asked to add it (especially note that
-'git format-patch' can be configured to do the threading itself).
+exists when `git send-email` is asked to add it (especially note that
+`git format-patch` can be configured to do the threading itself).
 Failure to do so may not produce the expected result in the
 recipient's MUA.
=20
 --[no-]mailmap::
 	Use the mailmap file (see linkgit:gitmailmap[5]) to map all
 	addresses to their canonical real name and email address. Additional
-	mailmap data specific to git-send-email may be provided using the
+	mailmap data specific to `git send-email` may be provided using the
 	`sendemail.mailmap.file` or `sendemail.mailmap.blob` configuration
 	values. Defaults to `sendemail.mailmap`.
=20
@@ -441,12 +442,12 @@ Administering
 	Confirm just before sending:
 +
 --
-- 'always' will always confirm before sending
-- 'never' will never confirm before sending
+- 'always' will always confirm before sending.
+- 'never' will never confirm before sending.
 - 'cc' will confirm before sending when send-email has automatically
-  added addresses from the patch to the Cc list
+  added addresses from the patch to the Cc list.
 - 'compose' will confirm before sending the first message when using --com=
pose.
-- 'auto' is equivalent to 'cc' + 'compose'
+- 'auto' is equivalent to 'cc' + 'compose'.
 --
 +
 Default is the value of `sendemail.confirm` configuration value; if that
@@ -460,10 +461,10 @@ have been specified, in which case default to 'compos=
e'.
 	When an argument may be understood either as a reference or as a file nam=
e,
 	choose to understand it as a format-patch argument (`--format-patch`)
 	or as a file name (`--no-format-patch`). By default, when such a conflict
-	occurs, git send-email will fail.
+	occurs, `git send-email` will fail.
=20
 --quiet::
-	Make git-send-email less verbose.  One line per email should be
+	Make `git send-email` less verbose.  One line per email should be
 	all that is output.
=20
 --[no-]validate::
@@ -525,7 +526,7 @@ edit `~/.gitconfig` to specify your account settings:
 ----
=20
 If you have multi-factor authentication set up on your Gmail account, you =
can
-generate an app-specific password for use with 'git send-email'. Visit
+generate an app-specific password for use with `git send-email`. Visit
 https://security.google.com/settings/security/apppasswords to create it.
=20
 You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` and
@@ -599,9 +600,16 @@ helpers.
=20
 Note: the following core Perl modules that may be installed with your
 distribution of Perl are required:
-MIME::Base64, MIME::QuotedPrint, Net::Domain and Net::SMTP.
+
+https://metacpan.org/pod/MIME::Base64[MIME::Base64],
+https://metacpan.org/pod/MIME::QuotedPrint[MIME::QuotedPrint],
+https://metacpan.org/pod/Net::Domain[Net::Domain] and
+https://metacpan.org/pod/Net::SMTP[Net::SMTP].
+
 These additional Perl modules are also required:
-Authen::SASL and Mail::Address.
+
+https://metacpan.org/pod/Authen::SASL[Authen::SASL] and
+https://metacpan.org/pod/Mail::Address[Mail::Address].
=20
=20
 SEE ALSO
--=20
2.49.0.638.g03d7d6a772

