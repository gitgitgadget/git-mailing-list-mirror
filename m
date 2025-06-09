Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A60D217733
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483774; cv=fail; b=nlzKF4NGHZc8MVq4oIlY+Mk6YDvAOFz67r/rQ2RBVfqSd3BaaRkIETKkZqUCKOBcPM46PgNK6fcimcw7HmGXyHo3bG5SciU4mmpn4UC2eywiAHFmjxjBMQcWtoMx16ZW2LaMh72+icuoAkpOkIqQxIX0r8TB2xmFodHWD/JoN3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483774; c=relaxed/simple;
	bh=UzlI03Ln5sEWbx3shHJ2sSmwhDldDEtxTeL+SOI12bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OtuvPQngVED/DoEbkBN+LN8ys7KckKK5mdR/7+6FFm3LMOZ006koqu+ZODOL+IAQ1ToJXiQUp770w/B5hcmTShoCUf1+41vxQIPUvPtfDzly61SxALVuAhdVODTyMJfbSZp5tzu5SynCaeKtw/lJTKGTuAv0LMX5iakmTcgCRNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=WwE7jS4d; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="WwE7jS4d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovFuRmk6i12W19pnm2du+umwymi6Bponvzd3s/elWLJuNWqkjnS79FOLCnLwgwdRz7pU1FI1K+prlHJ/UKzrksYh66bzzKMcYkDjKWLf8lwGnLr8VLJ6P4DdzDC6bGBhkGyRP4jqZqRTFatUd8hjR8ZfNAmNqQ0AB/HnxgajjX3qLFc18Y3J+ekiYwNR9ZyhJ3O188gN4lOHspWYncS+6vYppQu0iED95NJMXz6HrOI5MNmnwfHK9ZKJ8svjk22aP2Wr911jLiQqnF37HdSz2DoweR9/nKGpNAG9atABYj9YQmwLOZKqVj4CFwXvmXJ4ny73UQH+B2+YB+cU5AD/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lL/Q+8mAWb7r6gqeKX8rPELn7fuWjUzv5rp3cWFCA7A=;
 b=m23zqRE6d5ax0B004BJHrnesTAbiffCwypOuhgbLUmYS/z2gvxTUNDLWwNv3+NH2igrKWuAsCW3014w1q021Ri1qSwzshaKsuV+XvuWDat49upy8umDkKxjxnahR935juiG398WGNZI+7Lt3QWZVExK5MSXvXage1f/FK7wTNwNWV0UbvW8XT6xzvScwUTpmTUX8lSkYYauAYNVj/QVho6r6JRf/McSQRX2jGgB8eJbUJFUWttf7TfwI8eez72eoPPH8mYxTnnf7l949dVHhBZzumPJnh7jtQI6ZDhfLMrSo4HByctdKxNJyK5A3sYkxaVhSVV58o1GQBP532iLKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lL/Q+8mAWb7r6gqeKX8rPELn7fuWjUzv5rp3cWFCA7A=;
 b=WwE7jS4dqY3Dn8IO6hcrcyhh/oQE60OoKYi5wH9stqVWAc/3uZ6BDXSXDGpRQNwcEGq+xmQWdKheEn4PIyjot8iBp5VSF2n4+VmXZHMwo847z5oQPk5WG7kv0wgu3MteM1FW0OfrgEMMRIqb5HHBTIVzXTHOJGij4WZMwXeZjFhgU7PxJbdzvJkxdzjbVe+B87Pe1kqDRkknGE9ZXYjH1K664Toivo3CSbkQFCTOUyKFDNVLT+hW9kr6eo8jPAx2ysemfkMSxEp1xs34aPfnBI/+gy3+SUBvvHZH4xRU65qecgEqLIehtryqDFgU/7SQgYU0c4ZH/FfzKMTCa3R8lA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB5751.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 15:42:41 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:42:41 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v17 09/10] imap-send: display the destination mailbox when sending a message
Date: Mon,  9 Jun 2025 15:41:28 +0000
Message-ID:
 <PN3PR01MB9597440B6C555EBB31A5069AB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.824.geaff4db692
In-Reply-To: <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609154129.13552-10-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 7926b7ed-dd17-482d-56b1-08dda76c40c0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7092599006|8060799009|461199028|19110799006|15080799009|8022599003|3412199025|440099028|56899033;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?84sBazlj1b/OH/FkAxILNMvXYAK561TGeeHL8ZyCfOFI7XLYEOfxG/4vUGAS?=
 =?us-ascii?Q?mNKVyQzQgroORsqxNcvB9Ud8OCmNcGF29TyuOfsprpPDn2XqZgfXwGWIlcwH?=
 =?us-ascii?Q?JL3jZ/L7RQ9I+UIGfRTgxBWhhtH4TpZQS7pOOO7rGnNpUfzkz3pCxr1RFwPb?=
 =?us-ascii?Q?mJIIhvQ3H4u5W6use8iiAKbyafaA6Ib+S416teXfvMMorW3quH684QNJAfZW?=
 =?us-ascii?Q?gR+CcQD0XAgIuVOqaNSvWHuN6TtdoGgUPOKo3WRI1qeKW1U1F2ZUB4+OTzOe?=
 =?us-ascii?Q?zWkMXgU3E/yeZZE1Q4zkbSzic4uuRyF4SVNpp2XETk6SL/Lne9ZlIFdro4oj?=
 =?us-ascii?Q?ZPtFQRxBisejrHUAoT6p2GB1UlJwcXMrWznNKA8eohsh0HYU0+aY+HhiIn1t?=
 =?us-ascii?Q?uEtqwXFc0kTM+wlmbbabu2x0ruJvvCYmTqeeiMrz5ItxY94KtsTkYfTGmEEO?=
 =?us-ascii?Q?dVaguRYpBjaD3ZUKFvqCqY3xhkrDzhaxea2QHB5I3xkmombJGi6vP24qnvtk?=
 =?us-ascii?Q?5duWiCRwXX6kRK51EtmmKPb3lNSFrTsOHcUoRH9oLgtJ0edxI/4yAIpBYUMR?=
 =?us-ascii?Q?bfYzHBGJSBDmWSCJlfKMi2fEjktXltI8xIkgXruDUs3Zo+X7V1HDfQrQ/Vmo?=
 =?us-ascii?Q?yZ3EeIqero6Sbi5g1RUV61ujE/L12UNjSCjJE+pWiOMdki03Wl06Rb6gh+EF?=
 =?us-ascii?Q?2XZ7zgfb7123qmbGrXdNxfoDXEpz86jU/U5WJLvJ77+Cw4+UlONh6n9qtjKz?=
 =?us-ascii?Q?MTABkV1WfFKWKXAFXC3emMZ839SuE932GxV5Ebo9oEuBg4vdp88MKUhJRPzB?=
 =?us-ascii?Q?0+WOOM5IOEgRRJPPEM3lRi8VHSnt20bZtXgZEPF65XncIDnzSdqdVN8fUpoR?=
 =?us-ascii?Q?1D2CGpiBz1ixWbeEQXhMjLn6LTppac1Jeu2UnLIdU/y5efDAN6xNKb+niVI9?=
 =?us-ascii?Q?y+kzO03gmlR3MpqzGS+MZv/8B8vfzd0LeCswmCQwl3n4zg9YSOBFZ6/WyPgv?=
 =?us-ascii?Q?R4kYbYmkAeIuQpBwVvknVx8+MWwbOwrfgCjuUL7e0NHkSGW5vqQXf+NxNCAZ?=
 =?us-ascii?Q?Gb3CczxH5ptWugneyDBPMf950XuSu+VZLk1oDQFvp2OZjfVejBy53m3g7kXL?=
 =?us-ascii?Q?QMZKSgxr4YmwCn+kra026uzcL95r+RiZHQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6zxBrIhgO6LX+9YVeuLybPfPNktFgiHwc6qd1oYTJvdxmlbl6oQdUkUmy+aB?=
 =?us-ascii?Q?+zX8iRGV/FhXRrv4ZTJvbSCRIFNUBBhgCH2KbeQEdDeo8FuIKLyz0t/iJVKj?=
 =?us-ascii?Q?nhP8BNCmfclV3r8RRKqFforjfn29zuupLeqJEk3ZAuAz0EpbST5inJL8S/n/?=
 =?us-ascii?Q?JJu69XFzZjyoXI9zuCmTM4XFCONES52M3SoRVIFcy8DmpeLdxjqCeJKwnvep?=
 =?us-ascii?Q?CcrFIsmIyIheSj4nrf0HKTMvwoaGdtosvuP8S7rQiaOFCc9GZnXUNYxc/4rB?=
 =?us-ascii?Q?NoCjFMyzofTU5GJGFUFtmQGemcMSVRUYk2jvcMeQnjS5zLkNxniVUogNXDH6?=
 =?us-ascii?Q?pztT2EeIVu29XRFB8+IQbIm4FIx+HS5q6DyMnxqeQogRLSje4GPgIgqag3Ti?=
 =?us-ascii?Q?dZ78bBYgg8M3wH2Dsda1divg6ndyvsXkPr4X+CnNQ2YH9IUz1jxNBa/cUUs6?=
 =?us-ascii?Q?9Jl4mtkkv3SX5SIlyhKcHDRIO93gH+i1ltaIopzjHiO8bPL+2csktizE9iKw?=
 =?us-ascii?Q?X2dMhew8l7rmZ+Z/r0+pmcVgl5VlU5z3gXXVAw5Ro8bXHEOW9qo1nujZi2R4?=
 =?us-ascii?Q?/HWNT0kCYgtynfuZJ/2YSStRj3EJyFkgwZVhtjgur+5WOozraNADyDfFA9iv?=
 =?us-ascii?Q?Qqh098AHP96dIM0JnqDtSFPcLqtqVCIRrtx6lvt7unJNJO2mhW8JkxvQFV+K?=
 =?us-ascii?Q?gMjMoidsEMPwMrQgjKY7kpX6uX0O3G+EbwWWONXWv8tyy/9QadgVkaIqMOd6?=
 =?us-ascii?Q?0x2TQW0wmAqzHv6cHQ1Stzf+RlfJ1PA1f7y5PxfDybRhD77Y1lyaejwmUZBe?=
 =?us-ascii?Q?cDpGJBtDNvpPXhPenZ39ugEaAoVS9tcDGkz01RdWxqydYrEgp1hBZEPljrZk?=
 =?us-ascii?Q?u+10YLwOYAYzIYBVxXAXYj+QJDY+PwB7X90XoHEKnMakSG2ObA6GM36tDfjN?=
 =?us-ascii?Q?EiGtN0QxqU0HrCvIOJ+D/28AdGSdiZRP+37VSmfNcwDFaWngJHzgjbR9XX+G?=
 =?us-ascii?Q?AT5YgI+BGlFCJ9R4DG9064zrJODwV74gb5f+lapB6HfBgzwMqPCrQyoy3JUV?=
 =?us-ascii?Q?G6Mjyeai1AtK9k9odj4vwqHmoqd964jMAlFikhNDNMDVvniU3AqaBujTdejU?=
 =?us-ascii?Q?+dOhpVg/JPX4sKzn18nrcLPbMwveXnxADEHEMBMvG3Asw/dDyLqZt/BnEe0+?=
 =?us-ascii?Q?3/pKGEjSalmslibF/Rz3HbTwE/aRDsAbhLX762F9bp+NREa8cVWn8vGMNfI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7926b7ed-dd17-482d-56b1-08dda76c40c0
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:42:34.3712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5751

Whenever we sent a message using the `imap-send` command, it would
display a log showing the number of messages which are to be sent.
For example:

    sending 1 message
     100% (1/1) done

This had been made more informative by adding the name of the destination
folder as well:

    Sending 1 message to Drafts folder...
     100% (1/1) done

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index da85a6ee9e..7d5df3d049 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1563,7 +1563,8 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1699,7 +1700,8 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
-- 
2.49.0.824.geaff4db692

