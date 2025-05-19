Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010000.outbound.protection.outlook.com [52.103.67.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECFA3F9D2
	for <git@vger.kernel.org>; Mon, 19 May 2025 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659167; cv=fail; b=IRzdVVXv8wvR3DIWzuk1M+B2PzPr9iefZU7aUBWpwA+jVkqWMcvdST8HFMirZuKlvUNPefn00RDRbW1r1CvzO24wuHBNj44S1kJiGdn2rV+MgFMrW/8+Wo2jJqzCEx49dKoftxas1qiV/8lOR6eE4eKz933vcdf8SWLb1XGuaSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659167; c=relaxed/simple;
	bh=YRQ/pe/Zjyg6uHSuMChsBpouQEz3NJwF0Kqe7IlAbHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=td7Zy9asyLW2RnexJYzFj64KkC/cExirVpV4RuY1uPiKPQM4H9hwIhqE/FM70sakyexjp78frGLHWfG9Ew3OG/vZ3LGcfiRdetXMqpcz8ISFAKsS2YrXmnSZDeNqGITS1Gorp2/j2ect8tz+mWdne/zWVl/7niBt1DYg4VlAi0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=dcndXIVR; arc=fail smtp.client-ip=52.103.67.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="dcndXIVR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikxAWTBTg+waTy2//dLWtB9M0Cb7cXQW+nWCbnuKj/L1Pb0pp5ZlIsi49XVCcC4/4GXKLWiLChu1SvBN7SLVpudYjjOfZEC8rewH4+GnIzeJ3ptaBHHEEKdrlh/2Z6uFvaqxf+A9gBmgQlaywBqO7bC8y7oj37BOsT17bnllzWaj6vPkpvboHsqmBBePom+gIrAXJjI69HIIieXlZMM22Wg6Js1o2zb4xBxGMqjtZuhCHQisesY2Hw6/ozX4z6DBAtzYaRKKn3tWCrKkcByzihGepsWzmIhP6Bdf7uupQ5+sfl3oX732MrBzLWd7ajRChi+wuVMb0cGUqz7mesN2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWQVS9grtSBAnZ9Fx32D0niO33BXqYVcNij5xtgHiVc=;
 b=O95eVUiVTJwJLDz5wSS2H8MKdaBTTGQDl9rVdurRCnubPmP3DHNdt5hxAbHWVpIprhul4eggHxb49CtO6XmJfUK9pamvPp4VYAN4UQ4VoPicg+1KK54PzZ6Wm1RQ2QOTBgKOZbfqzhg2fiAzdBGeEomC8t8aq8h3pDb0CI8Ot/PXcpa1szzObK7BpP3/xWlTFKFw1oFAXmVGo3CVIIVa3KIgajfGcqAjYM/wHk6D2FcXOyxNIz0DY/JYK3+FlG7zqfJdLF8cyJleVMCxVjxpXAU+uhKT4UZdinUEEEqxddxBGdvsi6QnIgchbHHbXDSrlzVe0UMf2Qe5hYHc4LkX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWQVS9grtSBAnZ9Fx32D0niO33BXqYVcNij5xtgHiVc=;
 b=dcndXIVR1vNswNv2YppmHVUyl/qG3gXLhxGv7QLnXyQrKG/sjJT3q1oeGkwUYCQuAGkmPQNX/+RsPsR0BE+lYs6qeSwv3PYnIoUd+v06pfqfNQGcN9Lx5wfCvIEh0UxLcUvybuDIV5hT+yte6u7ei/GUl2b9kp7FK+JS4PGqmQZWy3WKXeRR1EIHb0YO0r9izPUPIi8b+Sgx8g7+eHNQTBkDwWOyv2wGhovgDMPr+QECqZlDBm9iKcX4z35XL8sklVafxgFSgSFaXipY/Mn5WK+PdYq6LE5sQPvrdVaG8y7yJfMEx7w9TucNfsbswt0JikfKAiGuC4iqYLqNDH6bLw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB8026.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:5a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 12:52:38 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 12:52:38 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v4 2/3] docs: improve formatting in git-send-email
 documentation
Thread-Topic: [PATCH v4 2/3] docs: improve formatting in git-send-email
 documentation
Thread-Index: AQHbyLzmV058MVo1K0mZylf5XpCkJw==
Date: Mon, 19 May 2025 12:52:38 +0000
Message-ID: <4AD5E37D-323C-4AD1-89AF-1FF7A8F6EAE3@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <A84F634C-3423-48E2-B648-068A75423037@live.com>
In-Reply-To: <A84F634C-3423-48E2-B648-068A75423037@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB8026:EE_
x-ms-office365-filtering-correlation-id: 2e4fd756-d803-4b6e-6ff5-08dd96d408e0
x-ms-exchange-slblob-mailprops:
 WcKQPEuhm/uvlEVs3zy/duofypRrmGdNTMm+bu5SsfDRc1R/if351Wny0LJxAfOkLM0iMst9dtiSTTBWvV/++uif3LlbaLbweSUsUe//p+E8kUeMJZ/tdzU4m9gMu2Xsk4QSj0izqRaftYlb4N81Yz7ZIuEehnpL36PoL/WM6aRK+zCNBfW5mgv4x3+4jBp9OSNCxxmExfZVBgRRrm4RJJ6yWXPZCX1NGWgAcQOAIe3hCF69OPl2a/HlRFb7HabzRyGh5gXO3IJUGqK53gwuUA3AM11d595unvO3uE9TlYbsr7a90SFa6YRjvOfxdcK5oCQ/gM6qWHw3Ig1g9VW60Zt8TxG2E0scJuYRWLQsN7nu/AKbG93UhcnmL1OugPLS5vIQdqGpcsC+cS/gT25ZmrZVMRUZqQXjOO/Nm60b88HcIFShXG4YFLzQE0zTy8FSFsPGdz+Obd2ghrnLTufJT5UkMtd/wMxhWpQ5keBLuXFoqSi8eOnPdXkHGGizTIvGCSMwnkRn/tOlOWudBSb3sTx7aTKtGIE9i9AajWs2Q1lkfMYhYHjOF3UcUKO1tRl+30upu4v311KZeNyHTu9ECbYwa0BORBfUjbuFwykE8DrBFWnN8fBBz6YLVJ+e6fW/4/V9XRlP5uNvh3SYr2F1WPEIdUpAWI3h57Cyc7GkJZg2UhzmiQEgHFwmhhv7ucln1/iaTbLsZI5N9LYqRAUWnJ1N4ov2HyEJlRcA2U6GAlDAsMgfhcOBAjnRgd/s4sBdIhPhs2sBj5NbcoCC2ZMKwoRLlBXFCF3aXqCp+Hg+LNYhCs3t//7ycBjianM4frWOQFGto+QgtSAFxhaKvm1P94Y/rcB5TZpNsid03HQ7cwQ=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799009|19110799006|12121999007|41001999006|7092599006|8060799009|8062599006|3412199025|440099028|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Snwt8E1wLiYeSDp5z2PqI1w30aIkID7udo5K35Ph1MfSgJI1+UISKtmibqKT?=
 =?us-ascii?Q?NKHStdoeC24ulOnXtHMJf5oMW3oHIAJ0HorGxOblt8Y+insKvHF5MsR8oWD8?=
 =?us-ascii?Q?kJ5bn/2EVUjNjqXtilFUHwtEpSyrzFlgkZmwp5LQlO44M141gDRyCWiHbSn8?=
 =?us-ascii?Q?n8EwaaPCmDKpNwKl7ROuAZSnXa8xcOJo2V06Nsb/7iZonCJWR2rMftJ+bovq?=
 =?us-ascii?Q?aRjD2QjbWPdKwq/ZT5D+vz7FBQ4R93sDVgpcORRgzjzsZw93QEADlXGZBPea?=
 =?us-ascii?Q?Xgpzw77uEmi5uOClJjC7e8++xKWnBNG7V7Gl7qkrQq/0D8HfpAzGqUllbvoW?=
 =?us-ascii?Q?74shL11/EAcMiSqVUiqcFrCgB3CNB3ayO5Jj4iJeKvmw3nn/esVGzrBzRJba?=
 =?us-ascii?Q?aVOzfzb9Gl3vvVptTyNlgwVpE5U0m3h/cxaGvMClvDOZ4a90fXXZgjXNxyOO?=
 =?us-ascii?Q?BIy1T27FDdirEDi6H83FFnR4q7Tgvn8R3JJ7zGDOpGj7yOujszyaQYSAdNyX?=
 =?us-ascii?Q?+y2S1XA5XkhO6bnyz/dQoiiA5JY3JUNGa5EBR2AZdRGEzw5u4JJon8UhNHVT?=
 =?us-ascii?Q?cATjaM3rIRbLYOme/vw3r91ilpJgz55f8Ege+CE3FuWBedf8lF+vQ57A8FNx?=
 =?us-ascii?Q?ufUOBa6YNJm2jyJflMpgOyc8Jzw0yxphEjSHT/QVFai1glkgi1PDmjJkxvwn?=
 =?us-ascii?Q?pNMMiy8FugbwKtV5JXKutYrH7PP8LbCMhyJpBbu8RmaRL3UPO8lIIOT2UllV?=
 =?us-ascii?Q?NMfmA3B56CiOLYmUTSGb7NQa3bOAuwNJjwNh+mdq0rKAgG5gzUxfuQesmqrP?=
 =?us-ascii?Q?bIlrJsvINbeOHYwk01sJYLKvRMFFA0tzHzR1uZCol4buMwIDubf1RV3jT5tv?=
 =?us-ascii?Q?z4dIquLNBkaV09rIf0GhhiYFhTq5hrDWxuVGM6BT6yE/GnSk+odqJUPHZQBO?=
 =?us-ascii?Q?hz32L01825fGc17H1VfUz8KZyqIp3PZ2/LjmCFBYtw5e7tq4ML8dRKF/s3z+?=
 =?us-ascii?Q?753ujbeWQcBDwb/N99+8oyi6obOc8JbpYRospx4x4rJ9HQelG17TFptoDR1y?=
 =?us-ascii?Q?JaZtom2XjT8dzlyAvevCIJBhigQ3Uns8NHrLUQSbf645STdLL2WU/Vc9raon?=
 =?us-ascii?Q?gGlPS2BfZYorMxIWMUSacaBujnE2txnoxugCnHp4Z1iED1oIVdKDfnK300WY?=
 =?us-ascii?Q?fKHRV5UYh5rAPWFFo7iWnV0cvLCKm3MeuEXGCXM8s+2go/9/ZHd47XzEdwM?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9/o9rUPDjYHb5ny/egE/St+85lyIWPZDpfO8DV8JDs7+hiZ03yqQjsJTsknk?=
 =?us-ascii?Q?M8O6hNB7r+61/LhfdQioXIHtu5D0QJOs2lEtuKYk6IiQXpL6Iuy4gtl1eCIj?=
 =?us-ascii?Q?GcU4Gp93oeMOBF/Sxf8l9RUrPOzC/CKZgQDnbUsZ7P9X2vD8e33nrdxFrT2B?=
 =?us-ascii?Q?wDYxRIGpnbgrDX177oWMgst9am9gpJlog0gj1dgJ1frTfyCn7gU4nVCh8jeD?=
 =?us-ascii?Q?GjWxMXeiU+ERhzUSjJanfw/TvRM8FoQAQcioi4YHRBkFrlj1yfxoGYwrJljn?=
 =?us-ascii?Q?Ap75LxiQEZ9k9aowX/Za9vVyU21nHHTv2mSYf5WY11kyCx+yTLKc/9RvmAxh?=
 =?us-ascii?Q?XGYVxPD1x6Q093ZB4g20q/kSN3gziYWyejKX6+0FHlqpqnoYwhL+LPvrNpmm?=
 =?us-ascii?Q?W9zgQewck9tpLF6rxitcWDckdjM+8YeMokW4wrgqdEoIM+5rdNWUhCg2ZaAd?=
 =?us-ascii?Q?OharHlFBOpt7J8rwvfRP3crCBtswPgesGsUg1yP2n6Mxxzgm0VKc6dkRgGOe?=
 =?us-ascii?Q?nOmLOxI51jBee+vwaWIKGoJpomvxuqtytBp06euCQDW+Zw2hxCQHJHTflo/s?=
 =?us-ascii?Q?4D+P+p7paWeeawKxeRKCOU8XQqzwhMDOEWjkAZ7WU6gmX8zSqUpg9CPCglu9?=
 =?us-ascii?Q?J1PrKQ9lP6kwcv1Mm3wY6Pb+xTmx6RDqAO0OaRJyGcTxVjj+AwjPm1lho293?=
 =?us-ascii?Q?KxPbGTTYsTy4SRIvpRpEbOZTt4cllxnmrnLWkHt8hgy7ioCLFzpypSKXFB1e?=
 =?us-ascii?Q?znZc+VFJ0nI70RbfFQW0ZYsZiOScASzH1QseGjk8b1HPLxbFQNJxhwu2qQ8H?=
 =?us-ascii?Q?vEsMPn0Uu89rUzZ63T6ngCFn3BlVuDRzxxAdPqj1sUMB871BW7FduLNAbcse?=
 =?us-ascii?Q?57SuRuDRq+uoYllOvzRSA/rSeZAt9B+yWHHm5ZEVKp0Rf8KUZR2TiqDbq8Sl?=
 =?us-ascii?Q?n/deZu7lwEHGJkhD8vNb/HooeS1Lk8MNjhJ/hTqUxEVtZGK/jhQa5wfCPwms?=
 =?us-ascii?Q?YmBUn+kvY/1dglNMpfVxBnf6IEjx7YLcAgGvwuGuApoUdxlTu38ckOHSzrLh?=
 =?us-ascii?Q?AebtdN8A3zHJrf8RuaiZUN9QikWajZgmqGXBz5qFyoFIrOPYEJf8PpaLGMNA?=
 =?us-ascii?Q?w95qhVCvxtgMYXG5H4PIdNpP44Vyuh1E2eWW/2IfxnFpKw/oSSIu4dbsVHqX?=
 =?us-ascii?Q?bh3kNBs4LkHprRHk1oRXq+KGsbQduFvovKI7y1IPbqntjUQ1FOvSLjOnBf7h?=
 =?us-ascii?Q?EvM49g3FmJpUS6A0jA6DoO6qKuTflPftPuU5MDO7SluTZmc0kKsWcqi7CvRR?=
 =?us-ascii?Q?OjIbBRWRtBzdAwP5VbVh+e7w?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE8E7684DAE858449A2520DF7A486124@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4fd756-d803-4b6e-6ff5-08dd96d408e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 12:52:38.2591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8026

The current documentation for git-send-email had an inconsistent use of
"", ``, and '' for quoting. This commit improves the formatting by
using the same style throughout the documentation.

Also, at some places, minor grammatical errors were fixed, and some
non existent links were removed.

Finally, the cpan links of necessary perl modules have been added to
make their installation easier.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/sendemail.adoc |   8 +-
 Documentation/git-send-email.adoc   | 181 +++++++++++++++-------------
 2 files changed, 98 insertions(+), 91 deletions(-)

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
index 81f8cbc6f3..aff0861d29 100644
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
+blank line) only contains blank (or Git: prefixed) lines, the summary won'=
t be
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
@@ -279,9 +279,8 @@ must be used for each option.
 --smtp-ssl-cert-path::
 	Path to a store of trusted CA certificates for SMTP SSL/TLS
 	certificate validation (either a directory that has been processed
-	by 'c_rehash', or a single file containing one or more PEM format
-	certificates concatenated together: see verify(1) -CAfile and
-	-CApath for more information on these). Set it to an empty string
+	by `c_rehash`, or a single file containing one or more PEM format
+	certificates concatenated together). Set it to an empty string
 	to disable certificate verification. Defaults to the value of the
 	`sendemail.smtpSSLCertPath` configuration variable, if set, or the
 	backing SSL library's compiled-in default otherwise (which should
@@ -298,18 +297,18 @@ must be used for each option.
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
+	sending `$<num>` messages and wait for a few seconds
+	(see `--relogin-delay`) and reconnect, to work around such a limit.
+	You may want to use some form of credential helper to avoid having to
+	retype your password every time this happens.  Defaults to the
 	`sendemail.smtpBatchSize` configuration variable.
=20
 --relogin-delay=3D<int>::
-	Waiting $<int> seconds before reconnecting to SMTP server. Used together
-	with --batch-size option.  Defaults to the `sendemail.smtpReloginDelay`
+	Waiting `$<int>` seconds before reconnecting to SMTP server. Used togethe=
r
+	with `--batch-size` option.  Defaults to the `sendemail.smtpReloginDelay`
 	configuration variable.
=20
 Automating
@@ -318,7 +317,7 @@ Automating
 --no-to::
 --no-cc::
 --no-bcc::
-	Clears any list of "To:", "Cc:", "Bcc:" addresses previously
+	Clears any list of 'To:', 'Cc:', 'Bcc:' addresses previously
 	set via config.
=20
 --no-identity::
@@ -327,13 +326,13 @@ Automating
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
@@ -341,7 +340,7 @@ Automating
 	Specify a command that is executed once per outgoing message
 	and output RFC 2822 style header lines to be inserted into
 	them. When the `sendemail.headerCmd` configuration variable is
-	set, its value is always used. When --header-cmd is provided
+	set, its value is always used. When `--header-cmd` is provided
 	at the command line, its value takes precedence over the
 	`sendemail.headerCmd` configuration variable.
=20
@@ -350,7 +349,7 @@ Automating
=20
 --[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
-	email sent.  If disabled with "--no-chain-reply-to", all emails after
+	email sent.  If disabled with `--no-chain-reply-to`, all emails after
 	the first will be sent as replies to the first email sent.  When using
 	this, it is recommended that the first file given be an overview of the
 	entire patch series. Disabled by default, but the `sendemail.chainReplyTo=
`
@@ -363,21 +362,22 @@ Automating
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
@@ -401,36 +401,36 @@ Automating
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
@@ -441,12 +441,12 @@ Administering
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
@@ -460,10 +460,10 @@ have been specified, in which case default to 'compos=
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
@@ -525,7 +525,7 @@ edit `~/.gitconfig` to specify your account settings:
 ----
=20
 If you have multi-factor authentication set up on your Gmail account, you =
can
-generate an app-specific password for use with 'git send-email'. Visit
+generate an app-specific password for use with `git send-email`. Visit
 https://security.google.com/settings/security/apppasswords to create it.
=20
 You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` and
@@ -599,9 +599,16 @@ helpers.
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
2.49.0

