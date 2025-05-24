Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D248B23BE
	for <git@vger.kernel.org>; Sat, 24 May 2025 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748090390; cv=fail; b=ZyI55DacFQhTYXMaLirdQMrZZSNALTNoxVlMadgLaRkoMfpenEQnPimG/vWpRq8opOexppzT6c5QrnJA3ddPa3y0kBhYtcbCNTUKPz2nX7NG1nSW4Rp8wPJnE2Dg5YZrba8vmhfW4l7fEE2dh+Hx+3nL7MqyyjYZKgOtXlIB340=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748090390; c=relaxed/simple;
	bh=ubtujk0eJBl0j9S/rgyuH6B2YZie0DewMNv1jJ9lQ8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qnmcu5Dsh/of9TQiuuoVch4c8Z9J0WvlHSPkidtn0rABdzHv7kgFWNj0vElo5Qx2+o4BiODcGAu8Npipf0PXyUUmTz97590j2RQtgocBObfHTOBfbuePHzNBoYqk2yolbvsARxmOc1CKviSYRo5op50iEHIx9CTHe30u0FH/G7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=SB8DztEo; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="SB8DztEo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SS0MwopcsmxlsCjThttZYmH8sbjL89M2qa30JIds6nVOhsn4izBAwdT7ru3Zaj4Yb4+6ixds28hTLoZM7Lpqpu/Hv2IHX3XHemPIHcFPCEcN7zaIRh0YBQvX71oX4pgMCqVGzfmw3j/gZa7J3egz/1ZsdjYopnmj8KtugBavOMizW643Xk+iPsZVOkP+6RebY1AbgFWrIzCJSOG1Ko+V9l3SgTxpkbCzuAaCvGRVu0P0lvX+evMc8XeBHmDZrAkxt6J2pqOJl08SujXvU7Ckcmzo4Vg589OCCYt33aKHoonrIMkC8Zvf8LomBot3mmrhKiSaMKSNDg7vY7Nh1mtvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzYvahJTMqhqfNqfjbT/RCeExMbUXWZJ0RrIVFH+R/Y=;
 b=Bc6lN9uzbTzg/j9JqeIVprVmn2+H1SY4iwBV/gnSBw/9sfNb1PNqKW2oLc2aBxY/9ntjAG8yjRZx2+OcKVCxNQLZ1g5HvJYoLoWLsMq/PB0DI0BgY5ZEFPvkdrvP5rEOCXVCJdZZIEyg+nNc/eJFbdXOg50S/ogjdJa8FrEzphupD5+1niv4mbwt+oTcEDVH9hwXMWjEA4cG5MzuvLqn5Y89o8DlF9/sWhK2lpaDQ0NYCmmgsdm6AbHwCB7Sm+X/OGsKvgCuwd2OQYac+ZlRATF7iylDNncNwamETY6ggbEMRaX7wSM5XLdlX+yH1j7+rlfZlI4yDBmPIWNI1FbxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzYvahJTMqhqfNqfjbT/RCeExMbUXWZJ0RrIVFH+R/Y=;
 b=SB8DztEowlrYlj4VrQIcHLzavtiSZcjMvCiVA5dn21T4My/DODUsTld5Fh5ZxochyWhlr048POMmjt+SbYgMJes2/oTfTAmqSWFKiFzYMh0xDBkpTpgqNy6d7tOAeVd8iX2HjXwVqWN8liZOSQ7Urp8ZdO1fiswhnfIyQ7LbP4/vzG0q9GCpeWcyTSdfof21DXPHCLhhv/2zaiqRFq6+G+KwtSjQdLuH39vZYg5MjKNbYamFswM9BlRd7WCQUgilMsTr0Po0IEvgB/ROJ/OrCQdH2tJng6MgDd4sU8YUtdc8TggajbZwWWAtfiNGxU/bA0mSrb/N6vvwub1q3evxXQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAYPR01MB10556.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:156::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sat, 24 May
 2025 12:39:43 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.022; Sat, 24 May 2025
 12:39:43 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH v2] send-email: fix bug resulting in increased message number
 if a message is edited
Thread-Topic: [PATCH v2] send-email: fix bug resulting in increased message
 number if a message is edited
Thread-Index: AQHbzKjsHHT2u1KCjkOT2stCywR18A==
Date: Sat, 24 May 2025 12:39:43 +0000
Message-ID: <20250524123911.1160-1-gargaditya08@live.com>
References: <73234CC5-8712-4B7B-94BE-F643345677BD@live.com>
In-Reply-To: <73234CC5-8712-4B7B-94BE-F643345677BD@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAYPR01MB10556:EE_
x-ms-office365-filtering-correlation-id: 724f98c3-dedf-4c48-1464-08dd9ac00ede
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|38102599003|41001999006|7092599006|15080799009|8062599006|8060799009|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?ek+KwyGOtcYXLCvsrKbhMYQZjv2X/NTFXahbq3MUfOYsYYjhpNQpEUP0Bp?=
 =?iso-8859-1?Q?3TOINMsleb7GiWRxfLVzfIPQnfuhWZyQR0Ghqu1CmDThu4cjeFD6im/X7t?=
 =?iso-8859-1?Q?64m8ZxDXk7CrtGFm/qzfPMiQxx15uqZ2Hyu1ltD8o1hScnYidgb8Nqzgez?=
 =?iso-8859-1?Q?u0iB0yKo4/8SDR+3PnvwYzl2dkWPftdqtmYEpiV1byztqLLxBn8Cy5eKkU?=
 =?iso-8859-1?Q?b8S1ymCIkCIGffFSeKnM8ZrOhBwE5N41SL7ywbzn0hs1taSkIAaNlG1lT2?=
 =?iso-8859-1?Q?ZvwYbX9/U3FSBtL+VMbwXSIhhL8VmBxNJIRt4jUh4KErMPyRuu2FBVuePr?=
 =?iso-8859-1?Q?5mVVWTpPQwkxmebgPU6RF8Hy8znN8UAECMwfhcrjqkcoGrTkypdwMRe7Zv?=
 =?iso-8859-1?Q?U2bkFzNnNK1WOuUHucNzowZje/14+eXiYpFxst9WWW77SNo9qeg7zfHYeZ?=
 =?iso-8859-1?Q?xk4SKWTuxSJAj9Tqz5Zf8Nvwc/ne98rwabKmFHZaQo45tPgzVvJAJ6QsQC?=
 =?iso-8859-1?Q?NJYcXr3F36arVM/r3K3amfZFob+w7Cf/T863ZYdWpp/swzQqa5oYpv4saU?=
 =?iso-8859-1?Q?ahD3+q8REypFmpR/avPBvxBqgnPK8E1ZMKYdkNlQdJ+98WKZEaGQLkyzZ6?=
 =?iso-8859-1?Q?oIMoo7yITCSsDn2H0PPmQpTn14uK2/xiu5q2MtvgztLEWVSj4GKHIPSXBn?=
 =?iso-8859-1?Q?xuq7lgYtysTs7c+FEesQN5j0+x1Y3ImtaiQgphlgEDmJJ+ZR57SrFjYjE0?=
 =?iso-8859-1?Q?vMGx9Hvlv3pmIjkFagCGegZph8j9AmgPwnUi+NCluzY8wH8FJxLcHP3tiF?=
 =?iso-8859-1?Q?OKLKa20qbruXImn8bonfFOTebNjqWVanJ013iqfigd42jJGswFNeEYoJvz?=
 =?iso-8859-1?Q?5ZnrS7EW+g3rbOFVS+sSITVFHVQ/p/ZsV5PbZ7MAiuSyK3uIqbI+0eVVFw?=
 =?iso-8859-1?Q?Yl126SrnHNf+uWTBOPxVCqQYn+zbMqDm9WNZABS1jP80F/LDsy+VJG6JGe?=
 =?iso-8859-1?Q?5+G2xASDJCDdXWt86RZ8XKz1eMREuVpnDc3K0qo9wvOocWYkHstbSLfYic?=
 =?iso-8859-1?Q?3UH4OoPuCYDrXqiHYcBKaMWwy2dFfejo9IAFNLOTjdrbzvknuLTQAAnp1L?=
 =?iso-8859-1?Q?JJ98//SYwbRBSY/24i3WoC95NsCi63qgYcO/tjwgtCwsE2/TOtOuZlBrer?=
 =?iso-8859-1?Q?2OFBRILShQufj7oVFJ8NpBx6kSyUhWnGsro=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BtTyCvNrfRNSqcCtQ9784AG4CVG0i7CH2yYqicsbNBMz5bzDafuh0IBn9H?=
 =?iso-8859-1?Q?LA5KMnJOpa3hUKncmT4TK534uJffJtDzEX5eT97CVDJdIuZe/CmSTSNdD1?=
 =?iso-8859-1?Q?cdr0bWrWuvxbj9uvC4Loz/US1C//mvD+b+bXXMpNdgQMtd7GBk6Sp2u+6v?=
 =?iso-8859-1?Q?gkHdw6nuyHdMEw5FFfMtp28SAjzEEik7/69+Z1DsLRkcFyMGN4xcG3YFkY?=
 =?iso-8859-1?Q?h0FpPomWm+RNZzCLOKLa8t2Lh4Xbwmau7KMB6JJfMvn0SsXizPH3xV/9aq?=
 =?iso-8859-1?Q?ZXcqKC8kyxmUIzkH/7NjdHDOHYWrN4dTzRgk4gDqS1v7Iegz0Y426rHcnt?=
 =?iso-8859-1?Q?cZTSJYel71hpQpHaeErDsv0VqxnMZmTOaqrI/s/FAZpW17oYHXFaKPa9Ht?=
 =?iso-8859-1?Q?rZYgZ/n7h0BlW1hZaEmtgpMwNmoUo2T7GHbTBP0sJTIsOR7ccdUsKP3Bmm?=
 =?iso-8859-1?Q?0bj8c4KVcLj1snEi7tEx0gNJENt7Sp0sj85i5xHdT9ZIh52bSmiQPEBE0u?=
 =?iso-8859-1?Q?iDMTxKefaZACrxJP8Ozgg7Wg9OHjxaotb+MpT5mEFap+Bl6wI3clz+YUSv?=
 =?iso-8859-1?Q?XQfsKL+PNR4xZUh9vT35NgbanANd/fmzvgi7wdbFttm0m5ogF1K/mqF8RO?=
 =?iso-8859-1?Q?1eDC1bs9BfFOlJtcOjS8j0lcV80X1Cz1WJy0mDAxSDC+ihghMBN15MtwTY?=
 =?iso-8859-1?Q?d8n/ottrc9PnH68lmhHH/e0i6LcSGhq6tACOLD5HSlwzXONBv5juads3rQ?=
 =?iso-8859-1?Q?YYCzNVFfB8pR4cVNw9nyG5K4b247HXZuNlxerUTgsbCMinX90UiXGFQDnJ?=
 =?iso-8859-1?Q?aeLcOB1oeTdCzVxHb0GWMR1Tx2epOqQYbo1mckHm05HmI6TFzN6+bIomFx?=
 =?iso-8859-1?Q?4c5iP6ukzub2ZuQu7je0ZbFQtiyEkQczSRZ8hXQZojYtLzfXdnLQWIXHw4?=
 =?iso-8859-1?Q?9nWuofoF5QooyKdqTxYmIRS0T/mtUGF6aktObatxR16qUyJtHWPfYaCsfV?=
 =?iso-8859-1?Q?bURCougyMgm4JgjRcjn4Jo8MoAOA2JJrqXgyck4U6qLiUbII87SAj5MzeJ?=
 =?iso-8859-1?Q?y4yxJlj+KTO3cBr7jmqqqO0iOgk2tKiHVVSLYojNePHeEgFTyNL/xebAm3?=
 =?iso-8859-1?Q?rZ2c5HpGD/yUmbivrdpdO0nH2KVIFvi0w8uEt5KToG3C72BbVwd4DMhenX?=
 =?iso-8859-1?Q?QD2/EFWzpWnTJ/bVUxQEw3z1VPZRC6y46t7b7+8Q9ydNgoNojXqeTSFa9B?=
 =?iso-8859-1?Q?BLN5G8QvSBixV0sLxXuYTE7MB/MancwUvry1vDR6U=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 724f98c3-dedf-4c48-1464-08dd9ac00ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2025 12:39:43.0276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYPR01MB10556

In case a message is edited before it is sent, its message number gets
increased by 1, and so does its order in the message id. The cause of
this bug was that when a person attempts to edit the message, the whole
sub process_file gets terminated, and the user is asked to edit the message=
.
After necessary edits are done, the whole sub process_file is executed agai=
n.
The way sub process_file is designed, every time is runs, it increases the
$message_num variable by 1. The reason for this was that the function ran
again everytime a next message was sent in a thread, and thus we need to
increase the message number for that message. In case a user edits the mess=
age,
there is no check for the same and the new message gets treated as a subseq=
uent
message of a thread, therefore increasing its message number by one. This
breaks the shallow thread logic which relies on $message_num being 1 for th=
e
first message, and it gets changed in case the user edits the first message=
.

So, upon scanning the whole code, there are two significant variables at pl=
ay
here. First is $message_num, responsible for the message number and second
is $message_id_serial, responsible for showing the message number in the
Message-ID header. So, whenever we edit a message, lets just decrease them
by 1, so that when the whole process to compose and send the message starts=
,
these variables increase by 1 again, thus get set to the original values fo=
r
that message.

We also are doing the same thing in case the user chooses to not send a mes=
sage
out of many messages in a thread. By doing so, we will simply decrease thes=
e
variables by 1 for further messages, thus ensuring the whole thread doesn't
break.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index 55b7e00d29..b09251c4fc 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1639,8 +1639,20 @@ sub send_message {
 		         default =3D> $ask_default);
 		die __("Send this email reply required") unless defined $_;
 		if (/^n/i) {
+			# If we are skipping a message, we should make sure that
+			# the next message is treated as the successor to the
+			# previously sent message, and not the skipped message.
+			$message_num--;
+			$message_id_serial--;
 			return 0;
 		} elsif (/^e/i) {
+			# Since the same message will be sent again, we need to
+			# decrement the message number to the previous message.
+			# Otherwise, the edited message will be treated as a
+			# different message sent after the original non-edited
+			# message.
+			$message_num--;
+			$message_id_serial--;
 			return -1;
 		} elsif (/^q/i) {
 			cleanup_compose_files();
--=20
2.49.0.windows.1

