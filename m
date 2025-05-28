Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FFB28DF38
	for <git@vger.kernel.org>; Wed, 28 May 2025 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452720; cv=fail; b=roYowyt/1H88/P8NFk6/EOH3BxcOkvpiMv6CUZ8AXYDOPNjP9wLNce8vz4XYon9gKHJ+T2iS2HvSOmqGBE53MhPxN4v7w1ti4qCFO4Fcv8BaBUoyS7TUu6y93CtDpyP0LmkuBy6jJHJwz6LhWqLU0DzUfaSZcqAqE8BuPJYXlDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452720; c=relaxed/simple;
	bh=a4nBR3ysyrlXLx/HVSRRuMwcDjv8qea5kyzaV+7+kmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q0wOPqi+OzrGU7T1Mh37OnsrgVweS9kcJm6tM1SBF2uSzozQDCm2+bL8rSb0R5LFh5wAEk2+CSgGzn3iWV3zkr7J9m7zNjZWpNxqoSHsSW+3xBl1yGCA5N2TpvEWwOk/5he1TQNLrHy50B8rvm3NhWnNcgxVIszcuhU2Vh4EUMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=soniATdf; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="soniATdf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3lGviS+iI11cCBRSHAjJaNoUgLDX4ISWcfPlaq9xWuADCrI9ad0D67fbRPGzWKFMScIX7aZFPYDHV/E4y4BM9mTCvjqBKqoVx1TWuCrjJIKQvf+v/EsYqk/SUlK8DogQ4CoDwrozL6MGoNYExdPyBGspInyWUr2XtdyUqqgCnyo1eWluCqGF59OR2hdXl5ZE4/oid0neqcR09KWFlGeE9Pe3AggWKiqwRzhLXMJ4C2KpYAD7I4qYk9XWGQxRR5A2I+9FOV5+iQcN7x2J6v+e0agsPBTG6oISYeaHgC5YnOw7kh+IHHAp0rl0CQ68z/+udmU9iEaY8HltSWhRsxhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBacDHQrJjgdH6DyaWKL/c+bYi0YVEQF4Wb1rbtaguA=;
 b=f00ESofp9LUbUsbiOYjsr1z6XG0ionaTsSGIC0c1OdM5NXpcVIoHdFkg4oOJys6yAI7dnKQMCWo2Fxfbb+EWqjaLu/mw8I2UCfZb64SQfqpl3518UklqsTHvZPug4M/H4gOGcy3d2DBe//O0QLIcCwo5ac6zkyd2JfVe+zLC3oqDqIicrdO5XcmDyo1cG+IjKmWoFyTMtHdwoUoVsebbf5m+A7PzXMVKrCwHrar6tsU5fDdtY21/1gob/1BNxCyunICWMup1qSy+Yz8WlFi6A5Slp94H/R4L+PI6FoLu0DJArnUDj/PVJ7YMMRBDIiY99kv44KWPD0GU9byl9EsPDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBacDHQrJjgdH6DyaWKL/c+bYi0YVEQF4Wb1rbtaguA=;
 b=soniATdfmyPQbI4ByXj2H0JXRAmkPcZbomDowG4a5NL5NDIhXhJZU3nErrkYrVKYbqy4mRUIhYSih0AkyQDOFirWTEK73S4CdhDS3eYPrBXn5VTlaqTaBsw3wlaiwhxRzQwxej7lTxxTDsf428kO54wNE+AHVbON7KDVh6UU7p7s3678ruGAMYmcJVkYUsnEJeo3PCQWmEM3d7hNv3NrLSHaC1+pSxpt49dluUetttqOt5bsOWPTHj0xv1jbXZXBcc17oKw+N7Hs9oksVBzOPLXPNt05EgCwxusvn+9jBMRRaXos9xZQ7XLIHjcgQ3KwFmuOjlqPiprS+DuqaHmvaw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9864.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:18:30 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:18:30 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 8/9] imap-send: display port alongwith host when git credential is invoked
Date: Wed, 28 May 2025 22:47:54 +0530
Message-ID:
 <PN3PR01MB9597328E6F0DB62CA1280992B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g5db5b64a3b.dirty
In-Reply-To: <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528171755.90367-9-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 8103ef0c-3a57-4949-8c06-08dd9e0baa7d
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgni4KszE9nsgeL87TLIH7/JrjBMKzZN233m2wB/pVUdQA4dnai4yfMghGBjnUyTn9exjYlYh3EKuQz+VUnR9r7wHrjhJfyV4IzMfp/vqtRFKB8wOAJwUyP0XyQELkSd34zKO8Wwr+UOQlUzBo7axcKkSsT8QJJ8T3JeCj7zyGTaa3aKbY9LWoLcmrEwPzA6elYzZb0T4H5RKeMVv5sFgtgYBqUe7q2O40sBU6ddbSMc5OD+1qlHKWcvaR2efjiF0IP9JkHh4Ztz+J9cx6tGtMvQlS1b2t0WEZsFDG3DIL/xGXa/rErE9zADsD8SPAdh0/IM/OhLoaZ1KxaduQcxeSYc7ZLWadSqewaiIvLQCS8raG9c2KYu58Z1zvGgwuu+52Y7r00SdJVH9KBcmLdMEib14qv+OEFJy7AagC99SKxjl5iLa5ePX7sHo+GgTYAlFBskSJbeSUgxc4nq42scDatc0+PudBHM2+COSTn0WzvecImWqerq5+ZL+EJSzT06wWFSdqVxaTcOQfqJRSmwFtZS3PDlywW3FTiFbr29VNVMx6Kie/SRzsW3cePO6TsGwQ9KQtsnqjwpQznmRe1P3sRre4zosWvAEJdiKClntFXEe0QO3h4WTtwBzcoomHCbm/vqV/5h3aY7ffveXYYqJKgEPwmcpdRk+dC+fpCutvFEsXi0+q0GAXQCIkFxzwNeeQ+TzG9ReIarp4GC3qmnfkg2+LXxnnzTFoC6/wQg93ELi4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|15080799009|41001999006|5072599009|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?51qpTdEMgJDdVmvX7APQICxBzDaw32UvXTBGdj+wOR/vaGAKy351qhPFWsRM?=
 =?us-ascii?Q?Dldm8j52AZCsvtlZhcC7/sb+qtF08f5tZ5j3PTfJybVyyC3StUOWysjYdfJo?=
 =?us-ascii?Q?7ZkhfHBaWGFwoTH4EWZaCqakG3vB9ThvISjYlZi9+YoCPjSFktKEODbT/fn4?=
 =?us-ascii?Q?eM7RRNXQLeH33DFGWf/oCmFLiD60/AAYhzWDcZ+UgzuTUeVnHAq1vDKV8Js9?=
 =?us-ascii?Q?UVXbs3GZbi57kVFcxckQBnp0abwMCKKfm2wXBEfb0NAVU8gMaUdkUfEpwMA8?=
 =?us-ascii?Q?9JiolSoTjXaIgin7xjMf6//oPxuoe3OwOF1zkmyDj/hE7bQeKZPJcdOQE+KD?=
 =?us-ascii?Q?b13GScT9F1LgJSiZvGuFVR/ZFTFi/phoydKQIr17zaizWyyUYckmYtPVqySw?=
 =?us-ascii?Q?MqXvjebwtjdUJzaDfsr/jHuAqvKBH4+hwlddCYuiT+bWimaPxUQPDxYAQaHX?=
 =?us-ascii?Q?cekuWzKZhhu60lgl+KOJlkfNg79E05FhlLyEEP1QmeqsuTncixVVJBcchaMI?=
 =?us-ascii?Q?XLuL+gBU8Yy4wl1VNab5TNL7Er0t3FVIJuFSfsPiE1ZxQMCUu9vuY+nERnA6?=
 =?us-ascii?Q?AlsDIL7/Zg9BnYxH6AVO1nALMowRs8tyFHRVDbyxPcRMzu81Vm6DQa4SMs9l?=
 =?us-ascii?Q?yaPdd2W2D+Rsp11lFnfkp40FFOC1OW5KzshZzFX14SR+TIWeKqLKWVUj64bh?=
 =?us-ascii?Q?Ue88nzb87Z2SUQq8pT3ksdDI4PMxHocwP9/Y9sF1DmBkxufF/QYZOdsJMJDs?=
 =?us-ascii?Q?rAM/zmEqIevze8iYFnuO2/cExGSUEe2oEUzwghgLcXrxN8ODHVKPV7MAaDX6?=
 =?us-ascii?Q?rg00eakNJCKIyYQTQaYuHpdLu5e8/xh0P4hdUyirisRm+KCyZIwVTEQrOtvV?=
 =?us-ascii?Q?Pqu03O8QhrHIeruB3fuD9uJ5/01mrxPfAZKFvo5kWLl1S3QR6zgkLgnpamjn?=
 =?us-ascii?Q?xU54l+nC6n9oZnzxNdKznUYHf4sJDEZmhnusAgn1M/vjZek6ahslU3uy/FZU?=
 =?us-ascii?Q?7+fNSil2M3HGyulI2i9lGZzUWi3xVlLwM4+PoffqGmY4vbAuuhOGVWdoVOl3?=
 =?us-ascii?Q?PAucDno7olSEBuQVZKGGN0Xc7yoa4uvpsuc4x2twgPTGs3UNfm4M6aA5h3j+?=
 =?us-ascii?Q?MuVjokII7iyfMTqL4EWfMVrjHOZcU1lNRQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VadMGqPNl3BC469RdZi21OeFKqZS+VUj/3n7nDAb4j8ToqntvYXIICaN4DRX?=
 =?us-ascii?Q?pIdICp6w+JZLjG4BzDklt0hYjTyW+OC7c3KV1f0UsLDNRmd0+pw3GYFb15s+?=
 =?us-ascii?Q?Ogc289JMsXNknOsiBDZeYd91vwF78cChWP4vffEbVhvToipPqGJPoUSvVsQ3?=
 =?us-ascii?Q?c8qrGtYoVeQHEvk8x/Cj8t3vSZsTCHzpq6O7XSxlhxcP1u00kVtOJ13O0zTH?=
 =?us-ascii?Q?KXYFGO3kPgm9DXPAGHupfQ3jP6GzYpP5qqnBzFALq+MKvTFizFGT0iYCc8NK?=
 =?us-ascii?Q?Xl8YA3C995nWWm7qYOIh5qw1B7PikwJ46aDwWDGWa13drK5xn0ceHnBJ5ngM?=
 =?us-ascii?Q?nqgo+uUS9le9lOzgh0yv3exvI3Nj9Y0FozctVtS588LPVoYlvt3tMRVs0SxI?=
 =?us-ascii?Q?K7mpyqViFrDCBftfo4NVHryQJXSrcBKPrG7YLeMmjyzrfret/wakJ79FMUaN?=
 =?us-ascii?Q?YJXfatjTBjHKlgQNdSpz5XhDaTfqtMaioYZ1bi4suDHuEtvBzMERUAZatdR7?=
 =?us-ascii?Q?wX/dmr3cR6onMFNUxCx/g+1uw5w36igGQL5nesv2Xtb06bEf5vIJqtIu2/0G?=
 =?us-ascii?Q?pMabV4K3pudGEXt0ozkKo39Tu/oLc3m74xiTXifLCKiMHXdRESgSdYYoH/3U?=
 =?us-ascii?Q?5Hyoieu92cm6rItrXTlpKlwc3b/l4TZSKn6kiqilFT82+MItnDQmDysHCT/h?=
 =?us-ascii?Q?Ul+OG+GcBe5SeRaYIJAs0kJxxTvFVxAM+CM56e2CGGZUum7Z5pzbHNqpvpVC?=
 =?us-ascii?Q?UHzqswuAc6D5DXf32GIpiWOg7Y6MZie11RijlZ52xcjLZBJvQ5KEOIKMf1Ly?=
 =?us-ascii?Q?GkET2+mUZeFrUGsrAFxinIvEsvaW0R/sRS3VPULCQgJmk1ykQgrnK1ijmy6j?=
 =?us-ascii?Q?ZJOzObNeFgQOqNhChDUuzIIqAKEOesLGEKDt4ewi0NhBRvjYufXIsAo9WPzN?=
 =?us-ascii?Q?fK03HD0MNokf/yHf1FK6M661T8yF/qeSv9z6z032KPr8grXnlnVmoD1ha/UT?=
 =?us-ascii?Q?U+4Vj6A9bSDsGvR6WlmI28XYb2C6MaNkgHs2/9cwpWlaFCEgCM2vo/Kics+B?=
 =?us-ascii?Q?83YWew8m9Cqdzw4ggPh0e9ny3DbeM/GNZ33Y9Hn4g386wpFx85jZN5Q6cb40?=
 =?us-ascii?Q?pmDnxez/EaZgnr6pZC3Je2Ik0Wgcmi1JWFsg5dBBLZxse3cPAjuyj9DQvauB?=
 =?us-ascii?Q?OigadRtmtj2HkpQtQomPxC4zJN8MlApPrnpIpar6YVa44SZNPt0Lwk9jfH0D?=
 =?us-ascii?Q?3jY70UhlV6pshkCjuTBxSiSnyf2fq0De3zMvd7eybRUtVDpJBzsaJW7lZMOq?=
 =?us-ascii?Q?2fMoxIsmt7H9uINlYq46odrX?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8103ef0c-3a57-4949-8c06-08dd9e0baa7d
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:18:30.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9864

When requesting for passsword, git credential helper used to display
only the host name. For example:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com':

Now, it will display the port along with the host name:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com:993':

This has been done to make credential helpers more specific for ports.
Also, this behaviour will also mimic git send-email, which displays
the port along with the host name when requesting for a password.

FWIW, if no port is specified by the user, the default port, 993 for
IMAPS and 143 for IMAP is used by the code. So, the case of no port
defined for the helper is not possible, and therefore is not added.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 204d2a14b2..3172cd5191 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1104,7 +1104,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		return;
 
 	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
-	cred->host = xstrdup(srvc->host);
+	cred->host = xstrfmt("%s:%d", srvc->host, srvc->port);
 
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
-- 
2.49.0.638.g5db5b64a3b.dirty

