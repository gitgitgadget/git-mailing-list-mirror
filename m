Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010005.outbound.protection.outlook.com [52.103.68.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0114286
	for <git@vger.kernel.org>; Fri, 23 May 2025 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748014585; cv=fail; b=Nj2xdKP8L6RfIUz5UvEO+U2MonVp1OAYrFvvwlTBudex07tlDdLEt/hE8KxYMszTLEDgdY+jU/DadMEz0H0sCLsBWTPWP0QH4XYmWfJJF6ytciWo7FLqbg5FAZsgeVaMrztc0K9lEZ12xFH2eMGRhN6w3ZqAQMxTzfvoI0BWAoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748014585; c=relaxed/simple;
	bh=G1i565bpsZB8tChBpA+AHAVuJkSOyvT0u0wwJhY4kbs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LPfravuHKY8G0BbWRjBd2UCJncDKk4nqlOhy7W+QJQtkHfW2R0TwDD1Uz19XYFdWWs4QhfD1RW3Oz5Mp9Ake/mdpA50sCKZVZv8fPaKrM96idFkgXYVf7NmGkMpOSsq/SFU0LRTljWU66O6AEuI2ImsXPaYdGzQjY0Dq6qIVsqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=S3ePugSN; arc=fail smtp.client-ip=52.103.68.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="S3ePugSN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WD7osEJY4IcDwxW1ZN3SkyWgHJlch7lxY5cnvSdBO4y/SjTF273GF3tPD5hKNFEuUBo25jTrbob/shK66kAfyUnxyRSYCN3ZvRO1wFcFaB8yPUBdHkQtgAeERgCGP6i/IBAj9M2RE1QkXE2eI5QdEALZLklyVqt+R0YeN+8Fpi80zkbAeeMhHhYklhNa4qy4WP7v5VqYFNJVDPXHUHSIMbcL6eb0q0TgDOTHY0Lk80go1Ugq4upEd7czMK7QaPJac+5kvaSlPslxdpHTCq1TMJBvWz1skBtSM0w0dSaRP8DUyhvK3n3ao3uJFEIczF5+e3yjEr/4bLNx4jqhkLtqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eReqKfAhwpghSA1pdgwhE1F0yaJWa2qbfq9OejlNwW0=;
 b=kpa4YB1xQ3YTx84Ggk1CTa+fVkdO8qooTBmm686n7NqoqcYFra6KLmdmofqfuvELmsvErh5p8B+dmRRW5gutjUpbdh4E+WV7MyZHhDanMepuOf63KAWZDmHg8qRN01U66UXte8JSB7pgjFikN5YKxIcjhKp6ypogaWA1AJFZ5kdagQTq6uFpmuuuPytTA4iXTteodQL9sbcpCT1VXb7lS13BnInGLwBTE40dtoUcu0b2AvKm23Tzc78Jvl4XM+YRYqm7v88oxT+x/TUVZBZUADuavUi1SVzsh9ndpx4x11he+oiPmMwZmNR8FSMkKJsUQzvQnRi5eYxzaxa8DQ7jSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eReqKfAhwpghSA1pdgwhE1F0yaJWa2qbfq9OejlNwW0=;
 b=S3ePugSNAqHlJGvAWTmoRwwOp9yHNCtv8lycp5mOg01p+jplX+JaauFYGxybsn6uI7zcbc3zSLdeAiqyScGTGcIgO866zYase7NuI1hngv7U778/tVBPzLwyhVgBYMbS9SPZBiCLhwmSOjdGmoFCqzzipHlrTvL6F9a3azw5bFtxu2Jg0qLbFTOpZkbs2QXP5eeGDSEh0GaYEAbo0c4Qe/VrOpTdZM1B/8V8gJE2IMTtwULgljyVcRObHOMUAaXwLFdy8tAETU6E6k5FG6tpW+4qqLKUcacmmvfFDapyPbpXCB5ydmmBfh4vbPes7WN6stN98Yx8l5I755449n/Kqg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB7955.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:95::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 15:36:19 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 15:36:19 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "brian m. carlson"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>
Subject: [PATCH] send-email: fix bug breaking shallow threading if the first
 patch is edited
Thread-Topic: [PATCH] send-email: fix bug breaking shallow threading if the
 first patch is edited
Thread-Index: AQHby/htPhLYecFMe0mY9gKP056A6w==
Date: Fri, 23 May 2025 15:36:19 +0000
Message-ID: <73234CC5-8712-4B7B-94BE-F643345677BD@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB7955:EE_
x-ms-office365-filtering-correlation-id: 4483d667-3d90-4c15-92b5-08dd9a0f902e
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|15080799009|19110799006|7092599006|461199028|8060799009|8062599006|41001999006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oDpyExaoVW7zm7kCjFcv0OdI/WRzJnhin35cF0qN759RhOb1FeLm0KNatoXJ?=
 =?us-ascii?Q?UMn8bC0zSGdbZbMrK/spaSUSh1W3/iS+eoIfScypDNytBac0rVYBSW2sJe6d?=
 =?us-ascii?Q?pTpfonRDC/AVjHN8Bcjy2937K3va7wY2OzZ5W05ycjYqEwgZojAb7wRB4wt3?=
 =?us-ascii?Q?WmbRvB1oagQQKv4IgV+IwH6cGMKfAOoCgKt+ChNF+w4r7np/KjYaVqJ5Gwgs?=
 =?us-ascii?Q?OnA/g/pRPRQ5tUo4FhOlUHXnDIlvVuxnSUlK16xJg32eFX40WVslzgnn1T9a?=
 =?us-ascii?Q?j7yCzRTZSjsy0TgtHRp0cy0LIAQQg3dnq4dzafAqymWqQA16dqKDjN8F2asb?=
 =?us-ascii?Q?704O4cXZxKdcuPVhhVFTFufc5urfHJ4Pt9qBZnxAtGOeWvk/oL17Zwvxdh/W?=
 =?us-ascii?Q?+bUIonf864JGbBOGxedZXrX+BqsBQW0HkrEFRehXxX6M2uk+9RO2Ok7LNYa0?=
 =?us-ascii?Q?5+DYkUaHPnmEM/9XXWQY3JzYf//vgBmGB0PMjsSxAI327njEx/AE6lgftH9f?=
 =?us-ascii?Q?kTia0r8X5A+ItCuZrXPc8TM7hUgrPUhu3j/SFW5VguqBjrD4eMMQ7MCb9cdI?=
 =?us-ascii?Q?Ch7mxvrGcMX8kBSiE1xwQCgPfkB5MGHekxNQ2zp5xiVtFuSuQloX1+JNYgCi?=
 =?us-ascii?Q?DVRb+SHks9dTAiswkCKrH5T2FsQE4LADXlYtsNcv4/KLuvB/sp1AHfbr4gxn?=
 =?us-ascii?Q?YHimSjhelczIdZgzXVzMwQePIRz/jOIyPYpFFa6VAT7Crh5NO+UaqehbjlYc?=
 =?us-ascii?Q?+Lo0+qbhil0nrERfLBGVAZT+30Hj8ZtMG3F9FbBZvxbY9aIdSU+0L2ObA9pF?=
 =?us-ascii?Q?sK+NEg/dCQjpmMC3bN1trwpHvV5ZzqVu+BBd7eeK9RyNN1wZdBRXxjNwZ2+w?=
 =?us-ascii?Q?pgao60/cjE6Qgiea1FAVYyy52oJNRr2KSCrxs0jhlrtZgrDPJK0ZJ7zpGqfx?=
 =?us-ascii?Q?eFJKsUtAJZE8AF2FZpmVaWyWf8opGQcNBi3IjcLwYKTzYOWjsc2K2RB+Bfj3?=
 =?us-ascii?Q?mjVvpqv1zlKL8ZM46exWFleUJHg4fcjggmR6BW40ylWNzvWz/hsq0ERvaPOZ?=
 =?us-ascii?Q?609TiI9k5gqIq76E6cHwhgrBqBVN8xpQgYCYKbVxvB+cxQIj8UqCJpWTCVia?=
 =?us-ascii?Q?HQr+Jkbch33v6w56oR8q1Ak6cLwBhCer3JhIzEjgakNQnEp8ZFFEZ2I=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UXHy1zVAgSDSYZ1Hi3cHh9mDrAIz//+YIj+umUz3TUZkxIaWBRjzGGNIyRO7?=
 =?us-ascii?Q?9KEOajofIpH7sJD5gyXn9DmVEXmzNrDKZj1g7EvKObOfzRKlTktiI5vMcqFj?=
 =?us-ascii?Q?A3xrjAUWD0hvIDFpCD3GdkcUqb60SkP2W98LLb2aP8BOIye/kd8vwNNfe+kH?=
 =?us-ascii?Q?DLO3EKT41Q52J3rC6V82SbceHUXekDmB5WDu+PIr6ShzbeZi/Fvgluro2HYr?=
 =?us-ascii?Q?EjbPn4fiKaBSntf5NnxoyajiRaqSEkPVlzckWBRiAQQwKnz2j1tonLqsdJv/?=
 =?us-ascii?Q?HbKWnBTZbugSrmlqez4+ElXdt8czW1wRrlSCBHxZrpoRdFpW6So5XGVCVx8a?=
 =?us-ascii?Q?ZiL4la8RoJShj1uii2Ceuy+nS2lxbgVkXLTOV4XqkL+dYZkfC1iGA3FvZ1OX?=
 =?us-ascii?Q?DOOTrBwCWluRfbHLQAXE0vLOft2/bQ8Jig+bAOlp5+KXPnZF9cuOuVp3jJSx?=
 =?us-ascii?Q?vywsTGprvbT3cANCmWO/VfELTfImPbXCasSGiW8/iYsddP4P8hfyEY7W41Fq?=
 =?us-ascii?Q?UGY10wAMDa8GI4U3SnVnFpUT1noYzL6XPxtV0CDE3A5eEjbDby/f+JRDu+YP?=
 =?us-ascii?Q?xZzgqw1ErFVWdU6Ie6uSLvDefYF1mM9UFqDVIYiAERyulfDeqOjf43piCFOa?=
 =?us-ascii?Q?HEdMV3RrKAQBmL4jDvtxG/raik40pHF8PfrUqdWXvWGPzO+QMBabkwX/puty?=
 =?us-ascii?Q?FASKA22XiQT7AI17OIahmGY59vHV8mDGuR5U7l0vVsX3ZNUzwDJcuiyAUo2U?=
 =?us-ascii?Q?FbAeemWNiCro2IqSpSrrUr8vg0+RCRFib5cdO/CmtwuoPS2clfwyCQiTC8hZ?=
 =?us-ascii?Q?BhvKNshJCo5Ly0nq/RZ3eg8pdhBcniBMbcXDvXrITmv2bL7TsV3aN/u5VCei?=
 =?us-ascii?Q?WOf2HxFV9dkam9ljyCXBAoflBg3ngyIyH72MAmCBx45r248chRYEmdltgqc+?=
 =?us-ascii?Q?JibbYA2a7klwTj394G7zfPJHOrj2fBElR6WKFFQMSiI//S/3yHKPjsuggc0Z?=
 =?us-ascii?Q?A/uEaIxFf4iJkH7GuiDksxBGrw3xqcOJu6sfR78APDvXH2vuYFP9aQmR4f3T?=
 =?us-ascii?Q?8ieCF+1wThWbC6rkrB/+uVhCXLGJO74V7Jl0UIXG/O1A8rSXZL0RZJk0+F94?=
 =?us-ascii?Q?DUVkrcvXLFK1mEArm82dbO3oknYskQhw/hjD+Yy7lYiW0dcNfBztbg3wInCy?=
 =?us-ascii?Q?xFBoslfB2Kx1tHs54qunRZDIWHo4kKJ/5dgHSi2vHnO+ZImj403Ni2el8AIL?=
 =?us-ascii?Q?ExD0RH6AJxqJOQWHGjFAsXQQlB6zP4weuFwjD8gUk6+7I1AxEdXTrmKthCtI?=
 =?us-ascii?Q?x/mfEyYs4+A9wdRkVKh3yd4O?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B05DF1C20F1967469A9DFC0B3A06B008@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4483d667-3d90-4c15-92b5-08dd9a0f902e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 15:36:19.0194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7955

There is a bug in send-email that turns off shallow threading if
some special conditions are there. Those conditions are:

1. An --in-reply-to must be specified when sending the patch
2. When asked for confirmation before sending the first patch, the
  user must edit the patch (pressing e and enter).

If these two conditions are fulfilled, the threading will turn off
and all subsequent messages will become as replies to the
Message-ID set in --in-reply-to, rather than becoming replies to
the first patch.

The cause of this bug was very simple. There are many conditions
that determine whether threading should be done or not. The
relevant ones for this case are:

1. --in-reply-to is not defined
2. $message_num is 1

If ANY ONE of these is fulfilled, threading will occur. Now, in
our case, we have defined an --in-reply-to, so condition 1 is
not fulfilled, and thus is omitted out. The only condition that
can enable threading is $message_num being 1. As far as I
understand, this condition was based on the assumption that the
first message being send will have $message_num as 1, since in
case of shallow threads, we just set in-reply-to only for the
Message-ID of the first patch sent. But, in case we edit a patch,
its $message_num increases by one, and thus, our second condition
for threading is also not fulfilled, thus turning off threading.

Luckily, the script also keeps count of the number of messages
actually sent using the $num_sent variable. This was implemented
for people who have set a particular batch size for emails. This
is a more reliable indicator to track the actual first patch.

So, whenever the first patch is sent, $num_sent will become 1.
If we replace the condition to use threading from $message_num
to $num_sent=3D1, it will always be fulfilled irrespective of
whether the user edits the first patch or not, and thus threading
will turn on.

This bug will not be triggered if --in-reply-to is not set,
because the first condition (not having an --in-reply-to) gets
fulfilled, so the script doesn't care what $message_num is there.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
git-send-email.perl | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 55b7e00d29..2cfd61b4b9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -2041,10 +2041,11 @@ sub process_file {
	}

	# set up for the next message
+	$num_sent++;
	if ($thread) {
		if ($message_was_sent &&
		  ($chain_reply_to || !defined $in_reply_to || length($in_reply_to) =3D=
=3D 0 ||
-		  $message_num =3D=3D 1)) {
+		  $num_sent =3D=3D 1)) {
			$in_reply_to =3D $message_id;
			if (length $references > 0) {
				$references .=3D "\n $message_id";
@@ -2060,7 +2061,6 @@ sub process_file {
		$references =3D '';
	}
	$message_id =3D undef;
-	$num_sent++;
	if (defined $batch_size && $num_sent =3D=3D $batch_size) {
		$num_sent =3D 0;
		$smtp->quit if defined $smtp;
--=20
2.43.0

