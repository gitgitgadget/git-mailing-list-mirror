Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD079221FD8
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500627; cv=fail; b=eKD2G8FfH1klmErQo8KyU2/lK0c3fVBHg8d0F1gsbQFDYycdXXZ0pMI6aWmSCgZJCzDm1xmjA64sMxBLtCHJUKJOF4EhTqJ4gliugFlVPAFIe02tqYZv7m/po3es/mUiDutu2juRCEIBAnuN4J/3RnxW+Mc/+gQiG+rqrVTcswo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500627; c=relaxed/simple;
	bh=AWT7e4nI26hHA+a20/oCdJBtn/0nrR+xUH80FWMdEQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P9jev1x+GD+aeY0mmpRJMZgAF1kP2OLlImMTM9SbqI4UC4/ZvMmd3A6m8RqAriVhPdX06cyAVB3gn815745VeHfwOLFcOew9OhUT8/l3jwxQ9Tn+U023en93IhtMhTqKG+GLrI0Wdb4bVmnivlVeCOKiB/3fYvjT4Cn51Nd8too=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Hxr08aCQ; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Hxr08aCQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ro0t7iLHBbasEWbElHtZki3xPodGCPfzIsDfwbR+2PtFU4thw8ShX/on9nxkryXe2ufNxeQWmH7YA+SZKHk47lIVngDA3vRvHnhvGe5vswAGmV5muinXkilx6o3eoXjcFz/n9MZNhkOlb5Tn3BeuIztoifqsvW/8FZnohgbYv7zM3cW3jXN5M26H42RqcKywFkv34Txh9xdmFig+lTFmuDTnlwgcX73PlNV1g88IayFe6Hyvv88KmeqoVh7QaPmFyODemuF3c6OWAbjJnOFVsxDp/T4keVvYt4qrif/aBVs2oiCjsBa5itNWfDMevo+RenQ/X2l7rSmRhM9/JPgiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/Cw1NCdCehBSGjQW/tlBL76llLzqBd0iMklksOsZeQ=;
 b=lgWrBh9Stil2PaDcL9rZzd6x1TjNAaaKZ5z46EexAPbuk8UDW1RdQg6799WuH0igGxxW912EUmIPl+Fnb+dn+zO2EU07oxY2LHuuGGnsCuV5nbJpY/QJ6QcS21qlFYbtX0IoLBwQpHqpjCL+GItGPormRSlJXWPMzVeCWiceOEp1H3wASCWv9Df78OLiq+9pmUp7XEOzQcmols9xM+EwgcPwfNUBRftlkm3Pr7HiV3/zPTaG4Bdfu0uZeh7pTNVWf6xj55ENkNhE0dMR1ftFNsrj/zeolUr5HmnlsBr8M30WGEsW2eTMGBDv319JhpnqIgMZxTzOoSl8M8mM+Nr9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/Cw1NCdCehBSGjQW/tlBL76llLzqBd0iMklksOsZeQ=;
 b=Hxr08aCQ2pYm20gH4sCr1uIthuOtf79IW2ZEtjy+dazP8lLFB5Z0ieMLbqWK7xKM9GHmqpwlPGQo61V9+GAbQIWR2VfzAy7x3h7gIh8Ljl3nL0R64aD6pWf1tOAVlTzu9clV9AkMaoRaS/vFuPa1eGC2EGhNZr3fOwJ87rau+SmQHtRQR7Kybm20ZaK9McXNssiXOAP10ivIHFppwN4ERFnxcubDtPOgidTPHHcF54Z8JSOhxXgh5tfWB5VU4nJPKR1xtD7FIPx/N253gnUvMwELPoPHgOlQf4PMlmh9+7YAz/S5kZf7qdviWxToMHNSFNJz+LXSb46TunA1fCx8BA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 20:23:29 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:23:29 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v18 09/10] imap-send: display the destination mailbox when sending a message
Date: Mon,  9 Jun 2025 20:22:54 +0000
Message-ID:
 <PN3PR01MB9597FF7B6893EF278EBE6F7AB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609202255.4341-10-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 5320cfcb-9810-49b3-cf58-08dda7937ea6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|461199028|5072599009|19110799006|15080799009|8022599003|440099028|3412199025|56899033;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JyJiPa6wiDqr3peoiym4vPaT6qWw9/2AAvXPQyMGgvaeggcCARhjtQXnSHv/?=
 =?us-ascii?Q?yGEcQWbukZYn0Kla4uKG5Vg5aHkjUXI+OTZIPdwny36DtsVm2tQBVU8xTRJQ?=
 =?us-ascii?Q?RBAcZLW4NyuapWOMug4mde/HJ5fx66I50onLD0bt9f+f7XWbJBLlJHvZZ9Qp?=
 =?us-ascii?Q?OKJ4yF6xPi3fIkdW53q541Qz/3c4zFW/EbT0K6plOmy3Cl4TkTo3z9W8VyPk?=
 =?us-ascii?Q?3PX0N8Vu5hqTwvh1C/QSj0X8JZ78qBaI5uRaEYhePcCRqNz+SFuxjZw4JMtD?=
 =?us-ascii?Q?wWAllcTsfG8uBNj34x4ry1jldmVUmYXvd7M+J5Zy1d2VDLqkIjo/wgYMh5va?=
 =?us-ascii?Q?2rmiKTWBMS+NIiLRdYVizwvPPVmcp06GgaO+7fwdYvgtFfM0iaUv047xabe0?=
 =?us-ascii?Q?G07FKLQKvxfBys0pAt5qDWRacfx1AcUR8vWhQaxIX0k07dUopS2ybzmbn57Q?=
 =?us-ascii?Q?Gf+3EdAC+iXSVjKcysRj+gXWxukP4RopWtwDJqgn/4rjGZxINYlpBcTVskyD?=
 =?us-ascii?Q?psVEM4/EUnC3U9MIOdhSVgfe60OGnB73D1oX95JXYAHODRuV3XsUnBECMMVU?=
 =?us-ascii?Q?wUnTq0cO/WFCVdh+6j67aEotHckfOVLhznASXkD8pk0rXzusO1/yQdHiYPUD?=
 =?us-ascii?Q?24x6CBwAbqALdSDnDJAMmJfaFn6D9a/mR66u44CAkOSfy/reKS+MoW10WzS3?=
 =?us-ascii?Q?Fho2gA6GBj7vj7xxPMwIDMABR3baMU39lBj09SEyqJ329HK/ScbDmiD8HeTN?=
 =?us-ascii?Q?1eGoiPMGIesVmxpul4FW8IKTff0SxnOZw6HEyRFvdsqZmvjnimoNJtzKGtHl?=
 =?us-ascii?Q?WU1ZKpHmxqRkb/o81h12KapwTb7E/9WmCIK1Ku08FVvAnEeWZwRqvs4RoxEz?=
 =?us-ascii?Q?23BW5v5jJQfKYYb5glsUzz6/KcMzF3dY8QTF0HjkDOBMw7VI3sLqF0OCoHRk?=
 =?us-ascii?Q?d1296wXmNzOZRB4wIEdv9UuRLg8GDzlMXz1GJh11i6gveN9G1ksl3aXKd9+x?=
 =?us-ascii?Q?p9DlTWMGeq5lCBdc2a4mdhT8s8Ucu9IxkYz/efuNBpLtuOyhXF3GYs79B6km?=
 =?us-ascii?Q?aJKdsAdctXUMV0tU7i2i75zWP16CtzuHQVWucIHotvugM302ItT8gOUMy6wb?=
 =?us-ascii?Q?GXYYamTEkuScLvN+YFnBf9RUdTEHPw8+eA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHRg3lMDVWnz9UQbYIjNCZS+0i79dXNrWF3Ul2a3bZEY3jG3KUP/N0a2sQ6R?=
 =?us-ascii?Q?lRnY1Asog/qzeFoblzIirslanOUTSbaMv2Mbi93kmghEGIQVwC3/309XEqi2?=
 =?us-ascii?Q?aZfPUhXJYbb14WR5TY+R3ZShjAjtVs7AshEm0zQfCWpjCZQMAEhM7oTfBjL1?=
 =?us-ascii?Q?66tPwQjzQZpRRYCIB6qRsYekZeKnXjuolfnPvP44OvP/fFSdhpqB1DDKoQ1y?=
 =?us-ascii?Q?Avl1rAhyZjuaIGHimyBvkZZHcgfLEsd98PtomxaIwSKHoVPhG6qZ57o02u8A?=
 =?us-ascii?Q?Ikp1BQ5IP7nXiODKpadEp4oxRUJ3wZ9BFMInnl6rhRR9ERPqSVDDUDhXWrYB?=
 =?us-ascii?Q?UwV3abItymBFf1yzXVhvj0PSSa0ZdbcaNVmhrBIcEMgaijg7TqoQ6u2z+ipU?=
 =?us-ascii?Q?UzkxYNZyf24gNvp4ESdykVR0txh7uCElARX/XSNHxBrro+ui9zBx7cwFjAgh?=
 =?us-ascii?Q?Js/+rym7TgdKRMUN1s0XO52VQBVoaknD+FOiiDvmrPdxwCnAmWC2kR9JDx/U?=
 =?us-ascii?Q?OYh5AyvpfN85Lh3EHR6g0e9iOqIxGfkFyiHak26gxQjjdsyuFbyv5gWEkcrE?=
 =?us-ascii?Q?f5VsOJnUCpkc7uMm87n5QaGgrNPX1FQxe1IobNvrFDFRMKgGS9OD9oVlvdBD?=
 =?us-ascii?Q?j2Gym7hoR2XyrVdveRf0zLeJZgmISxpXSnSxS5l7ERyHXj5uq3AVLcCFS+OA?=
 =?us-ascii?Q?O3QtznTxOzeunzRlQzaJPDncsbxMlIc0EVB+iZgQ6It0Rc0+LXoWJS5HpvX8?=
 =?us-ascii?Q?XS3g01khA2sBzaco9Uu2UsnI+hJoup0s+mqEFTyyKUkhnt5QjgAY4oYB4XZE?=
 =?us-ascii?Q?rA0H7qdEeTmqHJ575o1O7l+6w59LmFvzGJBr1zdCWAZYh3CSb0EbHIwXyHC0?=
 =?us-ascii?Q?kicrt0lCe0l/ZIl8PUVapy997eSiWkHxWzcdsBl0ztsYZoPRvs5poqmARIeT?=
 =?us-ascii?Q?t1LuxdqVefWB87bMqMFrH3G5C+6AadSxbi0kp5Luu60hWQbp6IAM/kKs0uTA?=
 =?us-ascii?Q?zPyZGhSqW0BxBydq9cKhtvF85p43tb4B8T+Yzt5GnRoXBKb599BbmSVjQFVw?=
 =?us-ascii?Q?8NDILSKz/Y49qet1fqUNRhMo5BScKrjdFwhL6TeWE5uyRhT2iuvW/Sb5Vu4F?=
 =?us-ascii?Q?q/BPjU6XbTnn0Js7/3W7HcYzSDGvb8/Vta8bP/uvkFa1QZ8YTMMim2tzftPU?=
 =?us-ascii?Q?t5fi9y+iubLtFEbThn0kN/vDPFsatEZcwtQ0B9Iur1vQck+K4D/65/yA8yU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5320cfcb-9810-49b3-cf58-08dda7937ea6
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:23:28.5420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4380

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
index a79e7c7da7..fe4e2fbeb8 100644
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
2.49.0

