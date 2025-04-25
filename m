Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAC22F3BE
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576069; cv=fail; b=d5HVLDMEfMy1AdfH3rYkD3avFJiL/wm7xCjQKWRM2WC/TRvaR1r4FfF15CnchIx35Rbpb2w/XyL6gZxHaIsXMfsDzQyFUbxJFxVYFV8mzF4ILRH0QQjNiOgC3it7RqxcPcNQJ7QjWs5rE4qCbgGYZ3Jd4oIZA9Pm5LnjC48GvJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576069; c=relaxed/simple;
	bh=sBaz01TJRUCIZcadLH7TnsS8w1w4u6WitRPDgyrOAkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MFmM+t20kc8JhJtXJUYTHY4d7j6UGpOqlxgKPBGCvvbbLiGW2rLi6oScj8CgQ5KZdXCJqxbxs553Qkcmcb4RCCGa2jMK8ySzQN46Er8ekxlyBz+IWeetTNBZ1O34pWOLnf/HwpGOnaFAQEyLMgcgLChYxXU8s2k3UMbuSmnawEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=vGGKdSEb; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="vGGKdSEb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sh8VYvS0kMKnRcaqSeon2Smjs/Q/rBqWrlEST4e7ZAQw/8w7039dC12FYThYf2osRiSVVaiy2DIHK+88pCE9QlpfYn2dXrSbB91DjC8U1s3dU3RoBCM34filzyUYMKAifNAhIreJoHNrpHyaqwHVyPgCcDGHp4BZZQgiqU+C/p8BuagHhjANl9fZlZz6ga0Z+3oLSXHCYHfXbF/NtHeKPfhEwLv4eHZt5pgIZ8DTNNL6R82E36hfZtKGVhsrGdcMcoks+r8zElFwATcaP9dLSD3Jr4pPnuvLBdu01HV2RJr30Q+NBjw2PO9rmiVtkgqr1RQYlG3qKAVhnUXMKTZLbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPgIELxR6BNskg/iUiL/gctsReEQnmnU0Sqxzc4uJDg=;
 b=HA7Y2/Y8F9qC+W5cvFDv2sot0MjMEaL0657TYzdKzDRqvWNrUegoWAi1a0pl61cE1hl3yKUblBb34GXlXhb53NXy9O0JUuiufIR034njqI7mpx/Uk9UVo+fc8ZUVWIZ2S8ULVv/us7zSC5GpSh6PDyoh1bD1rCwiQvB7/Qmn7ABwL4+MqgPmwOfsNmTpODgLOesMh/2rfWFJqx2BJmeVOUiXv8LaJQ0+oF7GaJzYWeZBE/H+Wk8DOEywHz1tEb8dD9g50te6Qaau/yQ7EoJWHyIEX5bA9rdd46kzQhpssTMvANQ4xDzIy55skBJfScBe1Xqev6h+C/ADEKsgIvewDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPgIELxR6BNskg/iUiL/gctsReEQnmnU0Sqxzc4uJDg=;
 b=vGGKdSEbQLUYdiOk9vDnlbFM+8rKS+pz/w6EM88biJzqjjQpQb/nvJJyCvbF90Aqi4OWGKaUqiI4YIfwHfTetfBOXuDX76+L47BXT48Dueu+BrPeJKPmtC3CdGfMsI1e7x/r/CyveSTHCgHOTJJ2YWV75bvuSkFPWskEAv3gvY8B2JabY+krKDaoNraYy4xujcuR9fl9W4B5UhNN7tAoN6qMdzJnL3OYGiLpDzPeLSaoEHYo8HM204RQxKoaVOR/mtfvQv+cmEIm1iIjFAIsJjK9hZDPi+IXf2t/80zOYAilBmwDbmRRDzs5rWQxh5GZBdXJy6h3nXO/QxlSVPWtKw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9703.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:14:21 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 10:14:21 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erik Huelsmann <ehuels@gmail.com>
Subject: [PATCH v6 1/1] send-email: retrieve Message-ID from outlook SMTP server
Date: Fri, 25 Apr 2025 10:09:09 +0000
Message-ID:
 <PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0078.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25c::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250425101407.51465-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: c9f00955-cc27-4940-3137-08dd83e1f20c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|5072599009|7092599003|15080799006|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PocmOBDaopInj9Gnjp4jdLP+uiNaeLtlxnKVWrDr/4mMB92hSVRpWCw3Hxk5?=
 =?us-ascii?Q?/WkLomJmgeoLPsRXfll999mgwUO/m7qc0wLDtYkFwyKqo5jNEz/+QSd3V2xo?=
 =?us-ascii?Q?tKflzp3SPYUYraiiSGdviiH/WP8rO7GEIzb2UvKU75M2Y5ca9EMtLP6eW5Lm?=
 =?us-ascii?Q?dSofxnu8Gl8b7FrULsZ9sahm2rcUvlF5PDU1M6g7xxC7kthSGoQiKg4ODKED?=
 =?us-ascii?Q?XIYA3RjvpO21A5/xv7ATX0ixKRzawEqZJkWxELFO3rHCZ5B2Nkq20SuV2nQl?=
 =?us-ascii?Q?qBhArti7ZrCGA1MbTk6vr6UquGTpjl8f48T8UEGu7+DvJxdkbbxQZTp36rX5?=
 =?us-ascii?Q?kZMSV8cQyQopYEnrz/CwiDcY+/ziF3jyf1nO+lw5bbaoyJ9EcP7wEZnXHyFh?=
 =?us-ascii?Q?iZmk+ZpzCyKAxia2OWtprGmYg5G0al/it1JuDnt5UuBjNGZdMMYKqMD6DHic?=
 =?us-ascii?Q?pqVKNpSv5C4iojlcb9IyH/hmkHNw+GF7bf3//ptl9l44UI1rigOdqC5Ra/e1?=
 =?us-ascii?Q?+dOtSVWQfCNxO4f10N9+sOvNndALUmGjh4GR+xDIQi5TechNT7TqW+B//gKZ?=
 =?us-ascii?Q?TLlflyL7S6aRhGD24fxbPwfD9aMbPSWbXkRXGHwpjSAZbz9W/iAoF4bHQO87?=
 =?us-ascii?Q?il58bmkovcRVgH0uObECDj11rbDopBffYHDTgynQMhGp3OQBio2TTeKNIWzM?=
 =?us-ascii?Q?fdQh5RRoHaoheeV3YCeoLhDxfUF12Gu648eePiDV8l5aBisEFJ1+2QV/DPmU?=
 =?us-ascii?Q?IUX/jA09tBpK8BEE7KPcSfQkgzsL7MLxqtTcQSX4USir0iO53eJzd1oMbIbQ?=
 =?us-ascii?Q?rbM4aQyE3x9oFa+1DawbxqXmFZlm1IIJYXlUs2guuIBghcQ9l1yvOGF7w3cI?=
 =?us-ascii?Q?Z7FkRzasbCgoFJEMEB5OKscrQFsOK+bt9PoNGCdX8OzuEKjPLaw6weA/BcXv?=
 =?us-ascii?Q?IjkkKiNrT7ve9oaLaStOoCZP3PdW8Agsj5yWIEFawtv4XlFJqBNRKS8OyXHp?=
 =?us-ascii?Q?lM5ffPPZeiusmYaQzFKdT4IgYkksBIWaoBodhKAMHrI2JP8vtRlF9NE+vsAR?=
 =?us-ascii?Q?zFXGHE2vRT9DwY4fgXBnxdutppxzYJIVEkSCv+gW1G0imrhFe+DpWZXxPN/u?=
 =?us-ascii?Q?kXxBvk393ebNh+ICD9GLXFzGsVK0XX/oCw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qKCIFNIIsIULh0kMbpWnEco3nRSiOAOuiSSz+6WQtp+6TXAK+dK4kWitDpi+?=
 =?us-ascii?Q?QsFlP7KzVsoRu3gaaBL2f3x4SH93ONBQIzChA9BkVLZOhyrAw4ZqjZf+86pV?=
 =?us-ascii?Q?kKFBcbqpvfI/VF6v3q6qI4f/stxU8Etig0P0r2Tu1D7kGOqRK/xQ/lLVHaTn?=
 =?us-ascii?Q?0AvmKvp9J1I8Ze4afX5kxfg37cqtQLGFv7pKtJcCUNhPIBelvWTmjof027Co?=
 =?us-ascii?Q?SjpA1JnbYrvldU9gsv186u1fDV+8o1Zrx2GohJCYzP8JKm76+P4XmAz6Z1Y+?=
 =?us-ascii?Q?RvhDwbV5ZaMyyz3ZhdJ48K7qvLpdOqDo+DWNR/EkuyDsZmWC+Q8qcktxTnR/?=
 =?us-ascii?Q?1fxolVDfkDizLBadeIKH0t+go7San8ETdFztAoaXtdrOLE3W2u0YVl/HF7xp?=
 =?us-ascii?Q?Jkl03+B4IzSFLr+tabTwgAhUdgIe1pa6Rzm/TJk1xJ/LIZCWUStS1POSWDdv?=
 =?us-ascii?Q?31IMB3KOpcR4bTtDIqSKj5XpSIZEpIQCEFxU9NBleE/1uPoNcPgDWehepHj0?=
 =?us-ascii?Q?KVbhohs/JZaZmcOFRAKI8PsRchAXy4XfgVXu9QlYqy40R6fNKObEsxkMRIoP?=
 =?us-ascii?Q?aqE2M1Vm0HUfgKDvp5XZjHgXmBH3wr0NKSjJATzdiZ5EynUU0giN2SNb44Oz?=
 =?us-ascii?Q?R2MifP8QX5dlyuuTgdTUa5v0MvwKOoO0Tqn4MnZws3FA1U/YZAEayUf4+kak?=
 =?us-ascii?Q?apyOO0FxRKbg/JDzKXzgH7WgMCSdrDl0unscoYE6RgtFZ4woTe8XAmjSZS1X?=
 =?us-ascii?Q?n2vKvqrO5XUoj3H/sN0kw8cqw4JzLL9d/NXzdosf0r9weHVwnbWBA/x8gYJg?=
 =?us-ascii?Q?ixJfxMNKurr8APAyCmXEtDCcMNXp6zordS4ZuNydmdWjyE7Ds/9l5NFSUbWE?=
 =?us-ascii?Q?Gff9poAfMimfYLL7kI/ig+Q3e9YnoJ95oL+Vx6zrE+Qg08NY1c/FNuF1WRxo?=
 =?us-ascii?Q?WCOPaM6pXP5qbjmjQjRw1NYdAEj0DICkEWNEwosHQTEiG06LjVToL56oc/+/?=
 =?us-ascii?Q?BfevbW43ozC6b+/3ieYGCFzF3NrNb0pRSVcGg6RwdWmekTwMuIyDZqi0QIkz?=
 =?us-ascii?Q?vh0mxpmPOeo/JgDLGhVweYms+wmnV2jgUozL+CjQOuQcHSBiDWlDVp8SLGE3?=
 =?us-ascii?Q?Aq3JGHvDsGyt2MqRy7DPb6GANzxQKo/Vkq2vS3e0uW9RanPmcM1H6QdT4wG6?=
 =?us-ascii?Q?dkArOib0ug2sZIZ4xIgH7qjr0WKkbE3a5PCtqjiTgv3U+rjZQilb6GmVzzc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f00955-cc27-4940-3137-08dd83e1f20c
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:14:21.0536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9703

The script generates a Message-ID alongwith the other headers when
gen_header is called, and is sent alongwith the email. For most email
providers, including gmail, the Message-ID goes unchanged to the
recipient.

But, this does not seem to be a case with Outlook. In Outlook, when we
send our own Message-ID as a part of the headers, it discards it. Then
it generates a new random Message-ID and that is what the recipient
gets.

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

The Message-ID here is the one the recipient gets, rather than the one
the script generated.

This patch uses the fact above and retrieves the Message-ID from the
server response. It then changes the value of the $message_id variable
to the one received from the server. This value will be used when next
and subsequent messages are sent as replies to the message, thus
preserving the threading of the messages.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 1f613fa979..618474916e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1574,6 +1574,11 @@ sub gen_header {
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
@@ -1737,6 +1742,22 @@ sub send_message {
 			$smtp->datasend("$line") or die $smtp->message;
 		}
 		$smtp->dataend() or die $smtp->message;
+
+		# Outlook discards the Message-ID header we set while sending the email
+		# and generates a new random Message-ID. So in order to avoid breaking
+		# threads, we simply retrieve the Message-ID from the server response
+		# and assign it to the $message_id variable, which will then be
+		# assigned to $in_reply_to by the caller when the next message is sent
+		# as a response to this message.
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

