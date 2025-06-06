Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50303218AAF
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240541; cv=fail; b=q+qjaog/NdnoMP6DbF4iBYA2hhlpvEZP1SYEldgCJPWbRZqveghNDV0B+wlnyg2sy01G76PSwOayAdwF9q59WcwL5t4pu7w9CemL1L3yF+exNcjOHFjiRWIzM7Ym0xtresBAc0NOafKk5KJqndr4ddx98QiHl+TMUCwItePuh08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240541; c=relaxed/simple;
	bh=t2M4kymPKctJbWNXyuvBdHauqQG3y7yMllgU9zqULIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qWyOOHWdlMw435tbuyQOiYHv1/AcOi6xmBRn65UX49QcKdXo4uaTZKRLaRzNg0lYCz1d2vsH5zeG0QbZXLotqYgJg5jcaCf+ZJhU6XcI7yQpsZ/iZ6LtB7GuFp4JXGKp2U2lBhnZsPLD0dFOwPNIbD3bTE8rUWSf4r63sgOxbYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=LRsjbH6Y; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="LRsjbH6Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIlFcLxYRc7Ldu+U3gp8wbSgs7d0M8SzXIW5enYdrMFsb5Vas5HxZJ8+MnERGbFrRHJyTvmCxPbRHxXB4zde7bbqIuUhA69p0IsK0wzNZfoPnjDOE+T/qkNLhoNA14TOzddRmERS2pV9iYysOygvJdIy5oNfBJSUXT6MGaD8Gnj6SgGqyPYGCdG1VDpW6meqzJpDzPF8qVHQImOv3+QbEyl+xCsCMrCu+rEK/NelCiAq+WhGtTT9IQMOVFYs251aEVqCSwq4KWtLFX6teyZPN0YeR3l8YzW2/iMHxWFz85T1i/BC1QhPoK1vkoyxU4aivphIa3YxanzlXJ+QAVi8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GphErmTak+bRyRGc2WoQsDJmA6mIHhnAWMeIfX7ovCQ=;
 b=So+8TRtQn85QEdHtN1+yJ9kCmLPZCQZ8aMl80QL28gT29BcwycJSXJo3O0awUa74IQyaX6GjKGMzQzZV5y6l6SICne3+3aNMiIkwdcw3ChO1yy/ZNYBkuXEUR2whP2/Lmjp2Rfr3M2bdg6ik5KWfozf+qd3pAO/jPrqVtMWF5rI3A1fFw/kbageys3XNkFgm/OHBwF1iH0dr0jlfHiWnTVwx7UWFaQbWqeD2yftNhFXKPndQdXaF9ttEQC+NcDyVobFtWZp/Ol0UCVwRydxFGfLNSqjVCB6Nunw6yZHD3QTVDhnoShi1B/vEs1mrE+hcp6JIt6g8hlpBZKPjHzBSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GphErmTak+bRyRGc2WoQsDJmA6mIHhnAWMeIfX7ovCQ=;
 b=LRsjbH6YoXHHgVcs7z2OwS61d1LopjSZqtPSrATmxrzRH+fnkJVi80k5vuj2xnc7d0dS4wqLmkaOxZkxQu01VCpnBWPuPqymGBlXeczCqfBNcAI+sD/FiJc1OzFYb6j0nk/9RUN6kBdqRUK03NNCOi748gVYm13u8UQgFXk/tQlZp+xxCowNtiGoBFn0FXGo7R5dl/J0OpkZyq5/HS6XsLRWNOz1wmXS41faYxzP8zXDw4Qvh1ZjQHY7ASZyLw2c/NiGGUePU7yg6MxaSrKnGhAzu0t0zZCHQR2TWtpVDyLFjr+DHjqGFN5k/gwiaigJ1Iwxc2a+QTBZnkr1yLm9IA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8841.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:08:49 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 20:08:49 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v14 02/10] imap-send: add support for OAuth2.0 authentication
Date: Fri,  6 Jun 2025 20:06:24 +0000
Message-ID:
 <PN3PR01MB95973CD16B82F61B6CEC7A1FB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g0975df9fc0
In-Reply-To: <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250606200632.43298-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e1bb60d-0cdd-42e4-e4c9-08dda535f317
X-MS-Exchange-SLBlob-MailProps:
	0HFyhoHfXaTHQGhCzUuaH2VJemPxhXhxoW9CzU2WBuq3jYxKiZjDUXneHk7zrpgtXRPecD8CwkX0nAoGwgsgBhVcwAa+LmnBPxwiqUNhFc4T9BjnzEPm8Wbx3EcMOmQSIZWtOgFnqH9rnE7NDegl8qQYbGerVLfL4+5UEs5vxajvzh1qHFz4b2jehR6jXveq0xjcRy5j/LOLp2TxTk+lgd10W1xKwUfPnPNmO3z06ehk75pevQ9EEwytSgN/tcsC6DQzK61OwIttR0eeZkr6WsXMAimqzTeLmF//A/Uwuf3cqQt4OJwEAoBPWu9ONb7aYfOHkQ8sk4ZLU6NY3muIv8hi5tB9lKB15KJQZXproY0s8miu4bufHVbsHxbcGT+7SDdBK253Zxmy48bQeECTSKjwe4U14t4NPfwOMjarrIwtC2Ihhb4H4yZ4gyPmYYmCC7+v+npiZWqkRyoTjHj0inWgdX4lyGm4IWZr0H0vHWVwiu4MnEI2RHaTb5PwY4Um0bPAuQhDYLNNuR26Nbsufbh1YD808uiDb544jFRWF3cLFgVCYJTIZ69/4vICaR2+4bq2X7tsAqAMt/+NvLvsn0/t1UuWpjpnyia9r6NCtqCNmelHfW/Qfg2D7tM2w6CThTscOR8zKshOQYG6HDhrhZBbRyuVnh3sCLZd7q/g9xbSTzImjDXInLjQLX/3XD9+HVVtk7ef0fbax5F8WDD+oecjeKHHStUZYbVmQJUlVSoPq6A3pq8ojUjQeLo5qYXLk4SjoeYQERwY0N/6gg5ViX5Ed8WOIImNIYl+rce6Ma7Arr/pF4m22AIgQc7GGR51i49raZTTRbGkmzOLi3THsLcw2awAvna0EaEbV4jBlt7cJtHcleo8q9+otHFEgQVkqRk1QCe5n9g=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999007|461199028|41001999006|5072599009|15080799009|19110799006|8060799009|7092599006|1602099012|440099028|3412199025|4302099013|10035399007|12091999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O7hfSL9rhelEP6tT6MoVuwb3Txdyallwb5Xra7C+Z/M2yPHX14YHJZPfeswT?=
 =?us-ascii?Q?aKMSeoBhCHuPq+JSHXYzqB1WOpJgsT/Suc5ibjO52oFntT2nD7CknSfwloa+?=
 =?us-ascii?Q?gWV7zE3jDTSStG5+jVuVdGX+wSVGIk3/oKZ9DJNdUL8EAUlEUA3pcGd0jlGd?=
 =?us-ascii?Q?cUKHMTT1/H1SYDNey1TSoHhbsrBc2UlhtZsucgnfL1WGZWLzQb5x2sO6Ixq3?=
 =?us-ascii?Q?OJ7ATPpQt4whLVeMfjId3VqiFHumFZEkMmnETuqXyrD6Y3Nomn/oQHg/Eui3?=
 =?us-ascii?Q?vyhwgXLi9Lv2ehnD1VFlbSJdNljRiI0RnOifTpiFh30meFzGvnigu/RsWNa0?=
 =?us-ascii?Q?hNvkGl3P1xJ8XWOSO/T6kAFcDodoAFW/TiE5pzQYmajGnq2QkLq2gTDao3hD?=
 =?us-ascii?Q?srLPP7R3reH0tVzGaXyW3TRyQUT7J5uJwLOHBHQ4GhW8RI5N7Qtqsmykg4bK?=
 =?us-ascii?Q?j6i+HcLGaCRO3weflBivpt0vzOFqNcB1SPGReBYOgp74e/cHVR+d0lUEQoSY?=
 =?us-ascii?Q?oXAEWWJHneBsFSubwAXn8L75tulKp61nWyrGsMCKhYD0SjAlnsrLxHu03Z2/?=
 =?us-ascii?Q?7WW2eCo0HSlBFgZRdoCmej7pvQNtq9gTQhatAkjjsjT0z6WUt0taGJfiJtru?=
 =?us-ascii?Q?0Ra6/6YJwS4YFh+Ena84tlrQMBsnd9+lZOiTwbAWXSol8zLB2gE6I1pLDyv4?=
 =?us-ascii?Q?H7jK8soIvALSbbSPwl4bLPwbYkdCM1fZfmMJoxw0E4lIbR1p9LEb8ZrhZGCk?=
 =?us-ascii?Q?ot8UP1XryHFP5xV3j6wKof7Cml+fOPJtBE3x9EeoxFeejIiz8nC6xpIqWOSi?=
 =?us-ascii?Q?OabP/gk5bIhTqY7YyKY8zNZ0+UQFZFA7mKxfmE7X+E9EukyYpG4pou6Lu+aG?=
 =?us-ascii?Q?4hIKueCuWOfK9dbZC42APIHthfvNQusatCpVBZHED/QPPvlAAxubJJ87doTL?=
 =?us-ascii?Q?LKYfN3Ht8wSACWL1Pxg7k2WqCdSC036UtPEiHpzrO6xzooo1vLXyReS9TUBX?=
 =?us-ascii?Q?tosc6QkQrtbuZy93PV08Qyr6dkSXSXYl0DhQgTuhDrwcL97rQeCtoj7Nw170?=
 =?us-ascii?Q?pLh8EavS3L53/zld+nDWXqlTu66KIKY4NQdVZhc4vBmHW3pMfcW5XtVLoFgK?=
 =?us-ascii?Q?8qAt35kG8d1rL+GGjMeeEF4eH0ICHQakBO11BXOVYt4uxtOAT6ZbNHbvwEY9?=
 =?us-ascii?Q?ZGX4TKZsVWUOXGWeakXFlGJSAunBWdxlwLcoglZ+i4JiqgFu1fikaEH202HD?=
 =?us-ascii?Q?fw4H8ub7cXqeA7KVlf0S4TOtlf2dOXshZSunzgcbJ9RP+SQObmJVXudwKPij?=
 =?us-ascii?Q?MSh51vIUi53Fyb3c7gb4meQayH7dunF9+hENnDVtyJHWIQejxeI4ZkHWkjaX?=
 =?us-ascii?Q?PSi/QM8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oXSQZGFISOuLFwxK7SVvnJoqKCP5MCMoVN3pjCWyuAHmlfk6GFPjhtZKVsam?=
 =?us-ascii?Q?t/rri5cKDAUMyO/dslDddKRCR4n2W+H8T8UrKreBT2AZ5ysOLBLFbN7lHaTN?=
 =?us-ascii?Q?SsGMGeWziNOscmMvPrZgXZUKnNm9nvqpfLGUbLltvmfIIgY659twyS6VyomP?=
 =?us-ascii?Q?E+Y+dZs2N09AFXSdcAYIiKXhJa+qWnneao4l9JikIqdIDX1KcE613BE+TqBa?=
 =?us-ascii?Q?hycCKV8ADcT4WRNy0ok8Ikj3qD+vDYwv8jlUowhIkBwI35D/8hU1JXHYniDZ?=
 =?us-ascii?Q?fRrH+5+7OPXSGr0VwHqhGYuBexxoZnHCUE5MMbyanWgSRsLRWpaw5XUGbBGg?=
 =?us-ascii?Q?MVPj8zyapqmyfuRYe7O9tqXGjPtOgQKra7k+uBkHsBrJGYlPuF+veedi6tIu?=
 =?us-ascii?Q?i8OR8pj6/KyHge78cdM/Dndxknu9UxFkiA61K06NiE3Itoap2TkFxJKZbCMu?=
 =?us-ascii?Q?6Iaq0SPvvdvPxVyR+rht3whmTwuQyh6dILrJ9ab56ZeG4dWZTNNoXqSTJ/dx?=
 =?us-ascii?Q?o5LdcSo6S9VeUo6odv6Gu05qY83g/uoZU1HdZKxjrJNiNSKgEPdbQjeN/9e/?=
 =?us-ascii?Q?v6NCJBgYyMSS+7zQcfJ5MS5+0sxbJvosih6t2NrarSHelEfOjfDQvb72V1zx?=
 =?us-ascii?Q?fBFXXJwbTfYG6MF5rmQyVAx/rTEODrAINIBOS6wBf3cR4xz55x0HN4yz9POe?=
 =?us-ascii?Q?UBhW63WhY5jvNJdmEIq7qnrSmO62TUserzmhdwAVPxrheaSog+zAlRd1SLWx?=
 =?us-ascii?Q?Qn3JPy5IsdH/u5QQm/VVopegEx9PFH0D9SImKCSdIJKgdxkeF3+idDJ/RAcp?=
 =?us-ascii?Q?4RgLU3N0tmn7E30qNm6K0tS+81/lwtSwHmokNCvEP3kswcItK6+PTZ6A/bB4?=
 =?us-ascii?Q?Q1zWE9zrnbkfZs99nl7QrD4TL79RaheIsBx5fxr4rB/Z0nU9GNGRJ9TEj8To?=
 =?us-ascii?Q?BNfMiByHKOPoa09pHjtgIEqzXRYjOCHTQQcDggdfj8/73rkpTmcRNM9J5o0L?=
 =?us-ascii?Q?UImdnwbZoQuSqSISBAPa4oYYXd5GpaAS2hHF5Mu5G8kPj6HX47vd161FH75M?=
 =?us-ascii?Q?Hyi4QR5lSvW+q8JUxt1YkmUlbFWuAgcSd7eJXpodw6JhYxbc+y3LrWTozfzf?=
 =?us-ascii?Q?9015Ow8CWNWwnCEoTmj75qM7MZLp/Hlhdyrtd2arFP01rypfdVt1ipk28ydu?=
 =?us-ascii?Q?y6jwH9i3XPi8Ld3NZhev9G8nz/KDAxA3iOSWtAy5CcbsUG3MQB8lSWboaws?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e1bb60d-0cdd-42e4-e4c9-08dda535f317
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:08:48.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8841

OAuth2.0 is a new way of authentication supported by various email providers
these days. OAUTHBEARER and XOAUTH2 are the two most common mechanisms used
for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2], whereas
XOAUTH2 is Google's proprietary mechanism (See [3]).

[1]: https://datatracker.ietf.org/doc/html/rfc5801
[2]: https://datatracker.ietf.org/doc/html/rfc7628
[3]: https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |   5 +-
 Documentation/git-imap-send.adoc |  47 +++++++-
 imap-send.c                      | 181 +++++++++++++++++++++++++++++--
 3 files changed, 220 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 3d28f72643..29b998d5ff 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,5 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported method is 'CRAM-MD5'. If this is not set
-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
+	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
+	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
+	plaintext `LOGIN` command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 26ccf4e433..8adf0e5aac 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -102,12 +102,18 @@ Using Gmail's IMAP interface:
 
 ---------
 [imap]
-	folder = "[Gmail]/Drafts"
-	host = imaps://imap.gmail.com
-	user = user@gmail.com
-	port = 993
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.gmail.com
+    user = user@gmail.com
+    port = 993
 ---------
 
+Gmail does not allow using your regular password for `git imap-send`.
+If you have multi-factor authentication set up on your Gmail account, you
+can generate an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create
+it. Alternatively, use OAuth2.0 authentication as described below.
+
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
@@ -116,6 +122,35 @@ that the "Folder doesn't exist".
 If your Gmail account is set to another language than English, the name of the "Drafts"
 folder will be localized.
 
+If you want to use OAuth2.0 based authentication, you can specify
+`OAUTHBEARER` or `XOAUTH2` mechanism in your config. It is more secure
+than using app-specific passwords, and also does not enforce the need of
+having multi-factor authentication. You will have to use an OAuth2.0
+access token in place of your password when using this authentication.
+
+---------
+[imap]
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.gmail.com
+    user = user@gmail.com
+    port = 993
+    authmethod = OAUTHBEARER
+---------
+
+Using Outlook's IMAP interface:
+
+Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Also, it
+supports only `XOAUTH2` as the mechanism.
+
+---------
+[imap]
+    folder = "Drafts"
+    host = imaps://outlook.office365.com
+    user = user@outlook.com
+    port = 993
+    authmethod = XOAUTH2
+---------
+
 Once the commits are ready to be sent, run the following command:
 
   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
@@ -124,6 +159,10 @@ Just make sure to disable line wrapping in the email client (Gmail's web
 interface will wrap lines no matter what, so you need to use a real
 IMAP client).
 
+In case you are using OAuth2.0 authentication, it is easier to use credential
+helpers to generate tokens. Credential helpers suggested in
+linkgit:git-send-email[1] can be used for `git imap-send` as well.
+
 CAUTION
 -------
 It is still your responsibility to make sure that the email message
diff --git a/imap-send.c b/imap-send.c
index 37f94a37e8..9df4519fa3 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,7 +139,9 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
-	AUTH_CRAM_MD5
+	AUTH_CRAM_MD5,
+	AUTH_OAUTHBEARER,
+	AUTH_XOAUTH2,
 };
 
 static const char *cap_list[] = {
@@ -149,6 +151,8 @@ static const char *cap_list[] = {
 	"NAMESPACE",
 	"STARTTLS",
 	"AUTH=CRAM-MD5",
+	"AUTH=OAUTHBEARER",
+	"AUTH=XOAUTH2",
 };
 
 #define RESP_OK    0
@@ -885,6 +889,108 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	return (char *)response_64;
 }
 
+static char *oauthbearer_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the OAUTHBEARER string
+	 *
+	 * "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
+	 *
+	 * The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
+	 * * gs2-cb-flag `n` -> client does not support CB
+	 * * gs2-authzid `a=" {User} "`
+	 *
+	 * The second part are key value pairs containing host, port and auth as
+	 * described in RFC7628.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc5801
+	 * https://datatracker.ietf.org/doc/html/rfc7628
+	 */
+	raw_len = strlen(user) + strlen(access_token) + 20;
+	raw = xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
+
+	/* Base64 encode */
+	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
+static char *xoauth2_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the XOAUTH2 string
+	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
+	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
+	 */
+	raw_len = strlen(user) + strlen(access_token) + 20;
+	raw = xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "user=%s\001auth=Bearer %s\001\001", user, access_token);
+
+	/* Base64 encode */
+	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
+static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("OAUTHBEARER: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending OAUTHBEARER response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
+static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("XOAUTH2: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending XOAUTH2 response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
 #else
 
 static char *cram(const char *challenge_64 UNUSED,
@@ -895,6 +1001,9 @@ static char *cram(const char *challenge_64 UNUSED,
 	    "you have to build git-imap-send with OpenSSL library.");
 }
 
+#define auth_oauthbearer NULL
+#define auth_xoauth2 NULL
+
 #endif
 
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
@@ -932,6 +1041,38 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		srvc->pass = xstrdup(cred->password);
 }
 
+static int try_auth_method(struct imap_server_conf *srvc,
+			   struct imap_store *ctx,
+			   struct imap *imap,
+			   const char *auth_method,
+			   enum CAPABILITY cap,
+			   int (*fn)(struct imap_store *, const char *))
+{
+	struct imap_cmd_cb cb = {0};
+
+	if (!CAP(cap)) {
+		fprintf(stderr, "You specified "
+			"%s as authentication method, "
+			"but %s doesn't support it.\n",
+			auth_method, srvc->host);
+		return -1;
+	}
+	cb.cont = fn;
+
+	if (NOT_CONSTANT(!cb.cont)) {
+		fprintf(stderr, "If you want to use %s authentication mechanism, "
+			"you have to build git-imap-send with OpenSSL library.",
+			auth_method);
+		return -1;
+	}
+	if (imap_exec(ctx, &cb, "AUTHENTICATE %s", auth_method) != RESP_OK) {
+		fprintf(stderr, "IMAP error: AUTHENTICATE %s failed\n",
+			auth_method);
+		return -1;
+	}
+	return 0;
+}
+
 static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const char *folder)
 {
 	struct credential cred = CREDENTIAL_INIT;
@@ -1104,6 +1245,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
 					goto bail;
 				}
+			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
+				if (try_auth_method(srvc, ctx, imap, "OAUTHBEARER", AUTH_OAUTHBEARER, auth_oauthbearer))
+					goto bail;
+			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
+				if (try_auth_method(srvc, ctx, imap, "XOAUTH2", AUTH_XOAUTH2, auth_xoauth2))
+					goto bail;
 			} else {
 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
 				goto bail;
@@ -1405,7 +1552,16 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	server_fill_credential(srvc, cred);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
+
+	/*
+	 * Use CURLOPT_PASSWORD irrespective of whether there is
+	 * an auth method specified or not, unless it's OAuth2.0,
+	 * where we use CURLOPT_XOAUTH2_BEARER.
+	 */
+	if (!srvc->auth_method ||
+	    (strcmp(srvc->auth_method, "XOAUTH2") &&
+	    strcmp(srvc->auth_method, "OAUTHBEARER")))
+		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
 
 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
 	strbuf_addstr(&path, srvc->host);
@@ -1423,11 +1579,22 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
 
 	if (srvc->auth_method) {
-		struct strbuf auth = STRBUF_INIT;
-		strbuf_addstr(&auth, "AUTH=");
-		strbuf_addstr(&auth, srvc->auth_method);
-		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
-		strbuf_release(&auth);
+		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
+		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
+
+			/*
+			 * While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
+			 * upon debugging, it has been found that it is capable of detecting
+			 * the best option out of OAUTHBEARER and XOAUTH2.
+			 */
+			curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, srvc->pass);
+		} else {
+			struct strbuf auth = STRBUF_INIT;
+			strbuf_addstr(&auth, "AUTH=");
+			strbuf_addstr(&auth, srvc->auth_method);
+			curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
+			strbuf_release(&auth);
+		}
 	}
 
 	if (!srvc->use_ssl)
-- 
2.49.0

