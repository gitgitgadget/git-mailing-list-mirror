Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011037.outbound.protection.outlook.com [52.103.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6236921ABD1
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745411366; cv=fail; b=HYhPL3aApL8jbiVV6YYGOcr7Lealc+UZ24laulTpseQv09BI3KAh1IHBNjKI/i56Q+IfZtNtxVtB9V4CAJRknyYKq2Fl0JD7eaH7CC35LiWbh3mQb4J7oiM7PDIB56PoLQPFVCgbwMqdlonW8B4eWdDyd3ib+bOTle5bseGLqFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745411366; c=relaxed/simple;
	bh=F/QBEhqdRIN36CQkgTKVivQgV+sAu4jRyW57S48DpL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ozxKLU1nytTF4gIoP3rYZ98U2T9OebRWOQXZlVtHG246fXdzAYvat4uOZwJYWO0/J+sdUkeEBoRqVhj8K7g+PW/pL7l7uFnz55ySx2WWPQ/45I1FxeWUrGwoQI/XYvuXfujDtBPuIY3wMNXhoroqYov+ACsxVjGXqOHQwQsalfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=cJ1Mwn5d; arc=fail smtp.client-ip=52.103.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="cJ1Mwn5d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMXwyVom82AOTRzlH1wAfxCMJcGEny9e3QzjquGO60bJJ8asvSDqr1AwnHfcDE5siBAZRb1rbHLqMhFzkFLrpBkLIA9ckA647DkiP9bM3SPCgeTSj6SGMLqR6sKtLhaHHAJyCgIf+Qw5+DdkUeYw8SvwOPLjSNcDyXUiX1Pr1KMEUzZcD/BBOM5E0O5C1OvMkzUF8/fkMluOV1Q1xWCNSJW+PcXZ1wc+i3uCAJMWcYPgKGsE2ac8MyGNaQ3bohT3RddsaRiOrxazezdxELR4NVwdc4KVDpgo39rYACwyy5cHysnCYaUeQjE427A/JkHgprEznKHklGkErKJIiw24VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hC8Tm0I6lTk4E8/JtffizdCNPMNNYvyMp7oxOQ9c+oQ=;
 b=urMxeyPjl5GYy5ghkqMpVa7Q+Nedvgr8omxPM/bkyAvs4lyb/oXYvdP9FJR9aZy4tQkRmuI5ErhNzmnwuNbD8xDp8c0EAzfx0KNARgjEElKuJismAhZS3U1hN1JRF2U/d/6slEL5/NsOTJbL7Ga3LP63lKOVIW67ItHLFCNlCLmNCF560X1lU5HWD92ueQYRssdy2SpSwvgi0oLq+boe889GuqDGOx4ZAaMXsWFdIstTJNyDquRyi1Xt07nIBdhS2AzQRfB2J94f9WLA6/GqqgANgqJr0o495y773P2G/CFvnRQ0KKa76UMyOTdcbg2EwosC1aFFtULnoXHUhi/zmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hC8Tm0I6lTk4E8/JtffizdCNPMNNYvyMp7oxOQ9c+oQ=;
 b=cJ1Mwn5dAyaJlRqi0M/OaxGHak0xHDb98BvnS4aQ1pyhO6m9F1ZhWHl8NpsVrOjrzD7vel59leb0mcz23kyDWphrl7Wvl1os/yAFwiu8CFHvniAosD7Ggq9GI0INiL9VapIXThe2JedKhMSlJPnGoUMWF15H2E0/t334Y6piYEqZ4NcK3JRJlD6teMRYb0t/Mv0vFLY8v3iQwj+/t8KXOaJkfjHuOsStyKPDd4VKvKKmB8wzuKc6+HIOihBGAqQXfi84T8oIV/+Bfeh11BXWKLfzT/dYnc/q+R+3hegCkXcbebzZlQwGYGFVYZQ6IjLK/iu8OEO/bfw+v/HG1kqmkQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7143.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 12:29:14 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 12:29:14 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v4 2/3] send-email: retrieve Message-ID from outlook SMTP server
Date: Wed, 23 Apr 2025 12:19:46 +0000
Message-ID:
 <PN3PR01MB9597EFFF817F0FD3D8B3772DB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::18) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250423122903.43547-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 347e05dc-a6f9-4331-e5d9-08dd826273a6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|5072599009|15080799006|7092599003|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0UbRzQmpEvfHLh77nUkYs5rTvpwxGWUs8Z9hJWYTFICWb0QPxcFG+ctxJVmQ?=
 =?us-ascii?Q?0z3zoSGBic1kMdICskFd3S+rvPsybxiRphDhnCEoeykYwEmtaT8JceO4AtMO?=
 =?us-ascii?Q?Wr1CEnju00Y9w7cQeZyfpLwTakSplbxw/GNSeVW3Ni5Qf84G0NWmT678+7vT?=
 =?us-ascii?Q?mZRo8lYjzUqNO1x17Pg4DaLw23mC84y0F4iNIJvFfSaaszoq0CVE+TqZsxRr?=
 =?us-ascii?Q?YP0swEAPTi3DHNNYpDd7uUnwStvuBUq7h+YgPul4mpIbTnlo/0reMR8EACVy?=
 =?us-ascii?Q?9uLXf8o+CNfq4cEULSn9spdqT9oCZ6wQAg4eshDI6zmjBe6TI6mEjxbpazrn?=
 =?us-ascii?Q?n87LoOL7OLb9VzQotnemH4c4JydAtYRmoaeTQyzuJAR6FqEjJRdQHPAl1w/T?=
 =?us-ascii?Q?paJKY/N1z2gh/91GWPq9Vs7YkYDyRUxCBBg7zTFbP36NO+yXp2hsTBJ/dsge?=
 =?us-ascii?Q?Zd/H91ed1OeMe9MRE0YVP36PUyHSxWl3zfBHxJzk1lKIA6ZgvR/PQ3BAf+sP?=
 =?us-ascii?Q?OhJSp7FXX8d+tacwupOpcb7nrEHp11QUQa08abbfqbOKOXfA84oNGbPXTC/w?=
 =?us-ascii?Q?B4sDrKEfEbhn1aLAo6x6QissB44b/8dNgQh0uBnn9paZxpJvviZrqljqUA5L?=
 =?us-ascii?Q?lk76Up3bZnqX9eSWYnpScT7f3JomHz3Ehbl4lvLxlWRAqIn2r+QNrCGxKiTS?=
 =?us-ascii?Q?PPWngKUQNhQBr3lG4tLQr0NYhTE/BGvvJIpTwbLA3W0Lwo+ZBfbtNBUeOB9F?=
 =?us-ascii?Q?r5EGj22gCHe4arQ5VCVutd21r8XvmABqttDydjDsakobB87o0F6/MOmMR7w0?=
 =?us-ascii?Q?AWHWK5wOGp7Crso8LSQ2EF982YqVOdU+Is6vYyglnzx671Feh7MR3JI3sdHi?=
 =?us-ascii?Q?KXmeIHDPx9WXTOVtCXOZDM4B/Wt+m+h9llsy7Mv6Ljb0jsSDXk8ABybPeonV?=
 =?us-ascii?Q?UzI5lVWspmnejYYtYAdWzp7kXy4bUylxnlEXlzyMk8PNp9DY9kaWTR7rZT0N?=
 =?us-ascii?Q?1ExGsTDy2UAxtsxGRX5HImqa/ztRrn0ve+yRXn75EWF7asDm9f+cseKn4AbF?=
 =?us-ascii?Q?vRTiYWgAX/NPsiXkz4j+B7MC1jBjU5wXeoJWERGtER+Ma5pqpEzq4oKNym4v?=
 =?us-ascii?Q?KEfNtwz/vOONWx2Rm0XHD5F1mC9LG68K/w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ivh971f0MiPeFocDFsni54k9CjaGUQQ5g1l8jCRHvm2oXxCXdcrSx9wvUKJK?=
 =?us-ascii?Q?K9PTXONE7bc8VF61jmPAFAcfaw4+YpwOwKya+nsBrYQio2NRRo5xK4F6WWNe?=
 =?us-ascii?Q?UeOTXxOvcMXjfn2SNIOeZUJPtsrZedW1CzkdwAGD7RVwpI6az6Q7uDN3/Tgl?=
 =?us-ascii?Q?ZV8nQm7dMZtz9LPqVm5nnIbkVXv5lT3zyQvMjXnyAqWLuWfqNzkT7nQ0JObW?=
 =?us-ascii?Q?TnwkbV+7vL7EXHWAd1ZNJusqJ+PAy8TlUvucEsr5cgKTsoctFAkDqxnJQjNC?=
 =?us-ascii?Q?9yzy7yKSHG8ft12NHPSBtdJHj5PgbeX3uJ5pKbjWVlg3B/c91E+QP+tKclo6?=
 =?us-ascii?Q?m8y7a7EiJ/V9fUC4KTrcvvxBKGmyQFSMElbX0HzNNOT40h/5EKZZIoy+8fqB?=
 =?us-ascii?Q?RYOc5b2mc+zZeNjAeiFzlHz75/mdBx50/hyip5XaZi7FsZmQ4fENCvlwSuTg?=
 =?us-ascii?Q?XqxsDxf104awOSefw4DTIVu5Sm4qQvdO7q2fJtrNBlxtyLXrYK9AojzUUyC5?=
 =?us-ascii?Q?OXOJHoLBoUDzCmQSuwM3C5NNUugyUCFwG3oNRVc/XrjGkWcvEAa4378ycYqz?=
 =?us-ascii?Q?JX3gqG6Vx/DQOb2KhXcxxobY99AJtppsscxJ0zGMBF7e6QSoIAWiP95RIM7G?=
 =?us-ascii?Q?HZQJB/Z1MS7YT05Wtg/3Si6p25bfq9XIs6MK2toAApCPx4heLAdH0T3W8Cch?=
 =?us-ascii?Q?jU+xlXvgOJ+SHZ4GjFiBc33RyuyokYZMQUL0qTKeWa2vcnZ7Y86CKwa7VJU6?=
 =?us-ascii?Q?hq6jvFlFi20j7hSAMbpmeP3PjBLTT7vErKgdzXj5I+WMIYusoTZIxUzvORTI?=
 =?us-ascii?Q?6SYKhHcIhhaBp9FdFGHJ2TiHUGCTWMb3cWSvsPfCgRC5HW8Sfl6UNhqF4Vzm?=
 =?us-ascii?Q?kmh7LCsx/KyiN1UHYZsoanbEcUyJBG/W7kx16G1/IkrbSzmFd8Iq3gVrnig/?=
 =?us-ascii?Q?7kAi1MQ/lx+2CLZvbUOzR7iJff4jHV3aEZ/bCAO06U9yZQMrNvnMBMnUCudq?=
 =?us-ascii?Q?DySAh1bhptSlXjnTdM+RtEica0znbxy9iduDbBf2fIxuF3GYRGOVvDBQ7Z4R?=
 =?us-ascii?Q?pHKqJnY4Vzaj1Pio9DQodtGwnAFHxqCnyEeM6wA+yZso+ZCrI9tB4aBrEyQs?=
 =?us-ascii?Q?8R6iV8grrZRwLwmqOxv5za1MyEQ1Ppmfd5gZJmxYqp8ihfkF/ut+nsMNzUiZ?=
 =?us-ascii?Q?AB2k5htpooQpMlcyvWhlcINpVmn6SkCa9oJYZERfdtv8OlIV7qJrk+/RN0g?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 347e05dc-a6f9-4331-e5d9-08dd826273a6
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 12:29:11.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7143

The script generates a Message-ID alongwith the other headers when
gen_header is called, and is sent alongwith the email. For most email
providers, including gmail, the Message-ID goes unchanged to the
recipient.

But, this does not seem to be a case with Outlook. In Outlook, when we
send our own Message-ID as a part of the headers, it discards it. Rather
it generates a new random Message-ID and that is was the recipient gets.
The Message-ID we specified get stored as a part of Outlook's
proprietary X-Microsoft-Original-Message-ID header.

This is a problem because the Message-ID is crucial when we are sending
multiple emails in a thread. The current implementation for threads in
the script replies to the Message-ID it generated, but due to Outlook's
behavior, it is not the same as the one that the recipient got, thus
breaking threads. So a need arises to retrieve the Message-ID from the
server response and set it in the In-Reply-To and References email
headers instead of using the self generated one for the purpose of
replies.

The $smtp->message variable in this script for outlook is something like
this:

2.0.0 OK <Message-ID> [Hostname=Some-hostname]

The Message-ID here is the one the receipient gets, rather than the one
the script generated.

This patch uses the fact above and retrieves the Message-ID from the
server response. It then changes the value of the $message_id variable
to the one received from the server. This value will be used when next
and subsequent messages are sent as replies to the message, thus
preserving the threading of the messages.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index a6cafda29c..a18e978e22 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1636,6 +1636,11 @@ sub gen_header {
 	return ($recipients_ref, $to, $date, $gitversion, $cc, $ccline, $header);
 }
 
+sub is_outlook {
+	my ($host) = @_;
+	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
+}
+
 # Prepares the email, then asks the user what to do.
 #
 # If the user chooses to send the email, it's sent and 1 is returned.
@@ -1799,6 +1804,21 @@ sub send_message {
 			$smtp->datasend("$line") or die $smtp->message;
 		}
 		$smtp->dataend() or die $smtp->message;
+
+		# Outlook discards the Message-ID header we set while sending the email.
+		# It instead saves it in its proprietary X-Microsoft-Original-Message-ID
+		# header and assigns a new random Message-ID to the email. So in order to
+		# avoid breaking threads, we simply retrieve the Message-ID from the server
+		# response and assign it to $message_id.
+		if (is_outlook($smtp_server)) {
+			if ($smtp->message =~ /<([^>]+)>/) {
+				$message_id = "<$1>";
+				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id;
+			} else {
+				warn __("Warning: Could not retrieve Message-ID from server response.\n");
+			}
+		}
+
 		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
 	}
 	if ($quiet) {
-- 
2.49.0

