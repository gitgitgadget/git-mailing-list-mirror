Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010000.outbound.protection.outlook.com [52.103.68.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDD921128D
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862043; cv=fail; b=R1ZXzunrfS2EpRGRDS0fdzo5ifSLCDhoO///by+iVQbzDjvtlGrEF9ZFf4PaQVehKV9MmfpOaZLI/4ifvXCc51gw7KorBExtPNTM4Ovhrrkx2o7b/7OOcb83fbaxGrdRv6IW5BPbh2EtNO128myGp/HLCyBvtdNK1U7fszyg67E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862043; c=relaxed/simple;
	bh=DNcjn+NZcZFe+5RBb4okdyDaH4OBEZ0aerBGfEzSYkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MhRcmoH8J3MNmlddcmRnZQVnaNL7yE9aPZs6tK+/5BVQhOZiEzjRlShu+PK8uSSkHh1ApZwj4Z+hXH8Bsx9dNiXW6ZQuPQxC8oK53BiDiREKVc9BpECR2U2X3t5Ywc9do5SqnBXDxhvoCfuiC7zxVymx5wPcsfffyi3EpJIk6yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=g71B5A1s; arc=fail smtp.client-ip=52.103.68.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="g71B5A1s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njA90CDj7shYWWLbMTvp3SJmYx9QICJB4YeU3X5N+OOUmFfCl3Hpvsh/5RzyoiwqWdw4vx6CB55QxZ0FyHvCNLHmL6CzlRPb/vYuiwsSsS+N+Vgs6E9CD3o9z5f/M7z9v1rbufaejOUZanTxZbr+4bzi81+BYSXtN/Yh+F09tcE0nUeIjW+yOxO3wljEqp6J/d+y8EkOsSCQ5rW5x7ROjAr/eS70OWvrLT3tDMuvzaT714d948Tu0GSCzyhwjsiEn3NjKlE/tmXltb1tfJojXdoKriyY8FGSK3cpB+uFPUleshMBWXNzznpDHpTqtj93kAsEn7WJo6QHTT/PnPFtQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtH+h2xfDZr7zgOpPcSP4vPFyS1RVfTdO187xo0g/Yw=;
 b=Nagdrt/A098KAm8mfDlTzN3p7lMCTE0iahlNdhqIbl0NdjaGf4xAOcj5N4hNE6G2RRSDqCvFIa8RGt1Rgxl/eAlGRtYnx3MkoQV3zV0RZcizh3Owkt+qcTHnFOotRGEQhWATDBDrar6XzDDeBBCfE5ym9fzNRoXlxVtAwedLVDmt19lvuoUypbnlznc8B0YNI3agqP39i58ob18YmC/F4LXT0Yd1+D0GGDs8stSdW0rnfBfjckykednkVncZe1O5klIgVxtMNtdmioVACcVt7sa+lh+wam3LKEnWkAKjnHJPiEv6+QMvXttbdo/Nt8IIuso8crGvHXWX9D+29u+oxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtH+h2xfDZr7zgOpPcSP4vPFyS1RVfTdO187xo0g/Yw=;
 b=g71B5A1sunkhPj+sePugcd9Cdmx5JAvhpiSm2f2CVY2ElGQuSZKMpdauBoPCDSiXgRl65OXFVTiGIq+K8r8ajvZYfriFmsCDv1daCiKc4qBEE4MMpYIFD0BiUDbLmY2VlwmrPKIia349PVct4PkbydJ38mQnqMX1wUpOehDhNj1SSKmn1oDfbQCE2O96OwLy61UUJoMn8p8NTgx1ZPeod4mVYvg0D3ZmldIL2FVNGhKxQDSN6vZEHhzueP777N6FYb4p6yVGoQRk5lITXq8Ecc13CL0V+frglFOasj+amUyqVZfZzT6gmtG426yJa9FU5S3Rwu0VV3AFbg8Nk7VgEQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB8176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:00:29 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 11:00:29 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v12 06/10] imap-send: enable specifying the folder using the command line
Date: Mon,  2 Jun 2025 16:29:37 +0530
Message-ID:
 <PN3PR01MB9597F8EAACCE5E8879391536B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g36d50d01f0.dirty
In-Reply-To: <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250602105940.75439-8-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b183e8-a7ec-4bec-42ab-08dda1c4afab
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrN1Uple1Eat7kdR7nOrSpOlklljXR100N1WdSiV0iEZKHE5SFJKL6LCR5qXdSwbQatI4/q8nA6E0bbRekgegJ10WcvxYkxgUw38PZxJVGiA4a18vD4kLbmbOIlT1t0VXCn+CsPadYVXjvLRTjNdhGWPrbodhp4LRclVRTagJGW8Rt+36wLv/6SQA8l8Yzk3wTfUWKAaaKpCOJSa/sii23qRf9Lf3YZZ3bIgI44fu52nsb96kUc7NAlqvU7yrLkTkcCQCBrhazpv7wyQAD1ugiCrmkTBAuIzqQWY/PQNMJA97vYMqwBlJE35zJDEOBffof9AK3Nli6+xyOfr6PtSDunuylt/7mJ8MSuAukyqzg1k0I4V6AfEkH8QknSYMKxfFRiSjzl3nsySSdaGLmXfNYYrkSxaVBLaRw6tIY80AerJMBRbJp3ZW2skTDRDtiPqERE3FKLjmwCDVljXiQtVd4fQfN9GPWbtX3sS1F/l5CmNQHDo+3ZbTbbn3Zvm9qqD1q/aZDVZghAxHzwjoY4gqASN1DQjM/vVQxecjuvW/UPkMHCHHM4DthHTQqLqLuUHU6kGy9p7FSUjm6HH91fu+ZMSV/2OyCjA7+F3K65ST5dF7A3mBWZ73kq84pRIaEVctCvT8juYgM3k1MaqTKJ+JKPqXB5yrpQVPXqIMq8+eWTQfjm51leyvxuf5Ai95HxWY2loVMdxQIMMBOb/lWmo3lIryKKWv39edCX0Q2A9hHUSrHavW8LHlevrnzNZLOVHsec=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|15080799009|19110799006|5072599009|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rsdPf3oqTcwWddQ73GF+X2db/xfj7+U8/u5pbM89ms/1za0uOE8vlgLmvHIM?=
 =?us-ascii?Q?1T47wHl42pPu2qotZ2B3wcHsdUN+UOt58DrGDFCinHA1cZsix8D2FEIoHOjU?=
 =?us-ascii?Q?F/ActrY1cq6PPWahDsoF46SgpwtNAEADoR2NmHTi+TyALkASjUpPrM6ZWo0H?=
 =?us-ascii?Q?Rn2valbTWKjMcNnNnAflDZW1kznu4gSh0LlTsHBye607+qf4s52P5PGIWuJm?=
 =?us-ascii?Q?t8+T0Q+8jDPxVS8AKBZdyyJoflMkat82z/PNaLVQMiKxkdAsjvhHxJFH7j8B?=
 =?us-ascii?Q?Si+W/cbzBFPEguhapAyimBVNUQB+mNGjDIEgbItkzYeXapP4jsl1I/MmGvaB?=
 =?us-ascii?Q?M+t6IictgP8yQn7S6CQ/Go4pA6BvPUgV78jRQPAuN5o21W910fEHU++KLeeQ?=
 =?us-ascii?Q?HGwua+t0c5AucY7oFH2nRW+Kpq7FUXSCwtHv496dNVruLCBVKxjeOXpyQYFs?=
 =?us-ascii?Q?mO7rBNvMM9SWbgaERxLFTC1PbdaA/fdbL/aTQ44Ty5igTqgUYndX3u/Z47Be?=
 =?us-ascii?Q?UZStJZSo/NiMszpLmHi10iA6F7wUoa/3nPg2XpPVSSk50SICyezsD3R/XyZb?=
 =?us-ascii?Q?i100UKp/x9X5PO4GitjZdC85I0eKey1dorfarfFkRmnXoShClRzSfeoBtRC/?=
 =?us-ascii?Q?S7MWHQVzWiufC88u8033sT9w1mjINzGY/vrx8OmZR4OZ95RAlSR56eC61tmq?=
 =?us-ascii?Q?bQRl0bsjCP23d5fKPYNwtewqyg/xVFWhggYqdaSB/V0MUYgDHfZ2t3NI2oB5?=
 =?us-ascii?Q?PsbFHJsB3yBi9nqpZt9HYOgKfon39QpeFj969POiqwK33qlnwCKjS9mhWMDk?=
 =?us-ascii?Q?MH9t1jv08Ue67uID1cydybsHtQec9B2mHAf3by8GFt9nJ9DrK9sWBc25Z5oF?=
 =?us-ascii?Q?8dij1gv12t7iOLdlr4cSXsOcKNRDKL/V/trjHI6hd3ldO4oUM6ZelCdejm1q?=
 =?us-ascii?Q?FM2kH3W6o6XNgWzqNyq4A2Ud9TQWxxUOfxwOsKJukKkQjbVidKibnUdOBmi7?=
 =?us-ascii?Q?29x2oXjd9WHa7yesZ1KNt2exGJiYMKRY/YRUXEh9MxXdhgq49TU6najpqG9+?=
 =?us-ascii?Q?5yTfDUS1w8E7il6gQ7x3RZ7/YXQ0kpUNlZIzK65n9XOuVRgjJPcd+XJPPiT1?=
 =?us-ascii?Q?CrdpaPtezrhFV7aDM3f9+caErzU+rL+2ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8d3x/zFYi7fDKgU68dbndsoqjaZdCfEroUNBVtlnO+B7VTwSFUITWhzHd6Wo?=
 =?us-ascii?Q?1u781c4h9Jqr44gxQOIlKj0D6A/UdVRIlgCH94QLarsTXeTSFVFobwzVWZei?=
 =?us-ascii?Q?N5kJ38M6YUFMZE7Y8eZtDUMeVMSLsa+OA1Z9442cINo6b4bxO6j01bYSqX8G?=
 =?us-ascii?Q?zrmm4JCxMm7EPQYY2xmczCRdal/o8XUelOzy1PVhK/JznA0Esncm9b6odmek?=
 =?us-ascii?Q?Vp6Ogt7eACNuSfZNboc0ZukVzxjAVWkEQd3wuyL/iop1Mwv7TS1Um6QcNR5/?=
 =?us-ascii?Q?QNeynseBt9J37E0l4bq0XZLvBxoNQXAw5NsPWSW6LxLD616KXHK99llsJiXv?=
 =?us-ascii?Q?roIxrOqyzJEo5BUER/chaesn092UsGOrusfdcnsmETS8vlkBd1x9EYp6k7+D?=
 =?us-ascii?Q?yOvmqIyxIavOTpeagtxj+KBUAzb5UdAjDN1vUCP1HEJ7EOuVZO4EcHkxzYbN?=
 =?us-ascii?Q?TvjPXS4OumOc/pkt4oyWhXDtQrBJBFGYkp/0c3ryRiyhs/v1KJ+GnNAFZRO6?=
 =?us-ascii?Q?dBhIaxkERftm6/wny1oqsiOgkVMmGcwgn6eJCl/KOYtsPDJkTWSRIbBrQTbK?=
 =?us-ascii?Q?LrS8FbkvmXmB5zTlg5NiMpkZlNZ9fnB3ujcqa2wm7X/EIkjz6hnWTp3aeug4?=
 =?us-ascii?Q?ghLa0A6QMPcAar54gJLWGq7NBB7fPhee2YdoZGe9NGpPmqVWWocwavCePrhb?=
 =?us-ascii?Q?ltn/AcRmt1Q7IT53Jyl3Yy+EfcjN7an3Thw5upb4gCRe9H6EcnsIqpWun1Hw?=
 =?us-ascii?Q?KomVBEV853wUGMPf8K8gJE+UTzLfyy3jAcSy/YSeGdafkokAj7dq8VxHG/GR?=
 =?us-ascii?Q?1ysKkviQoG3WeYMp5Utct7wQ/e9JHYwRQwUijSIzDsucEoqhmtqU6K7k5Zjo?=
 =?us-ascii?Q?k/lRiPAqzT31NXD7FsbKi0AakvVoLWJt+63zWmFP6OJpbSXWcEKPi0ChG1jx?=
 =?us-ascii?Q?8Ov0v3WfcHYutNRNB7OsV+9Hi2ZWtb9SWxYo0run6IiZTscEyCc6m0PNdbZE?=
 =?us-ascii?Q?byNtPPrG1hHt9hOJ/ke15+ekovOAgU9XKXUgBce5chDyJcLerTckC0KUZunB?=
 =?us-ascii?Q?4lqa8Tt/Y8r52v/ESrjpXm8lSQSZaN8RaLuo38kQNDyeEH4HBLEQHOolijPm?=
 =?us-ascii?Q?9Wykjmo+6GzY9aL5YBzjE9sDI9lZgl3ih+7lzGu5j3ZKoiKzgm/hVBr2HFMB?=
 =?us-ascii?Q?ypY3SfKdk7RT3GjP8lE9hTUVTvKweFseWuv/eFLCgtnv/nbUzsvqSdedlUC2?=
 =?us-ascii?Q?Sb69zAYERD1vlOCOP4waDQ5On2Zf7+UIJa7X44UIztLzf/2m40u/IVpJtrs5?=
 =?us-ascii?Q?NxfKVNSSXWgQcTKv3ZUGO8Ra?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b183e8-a7ec-4bec-42ab-08dda1c4afab
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:00:29.2023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8176

Some users may very often want to imap-send messages to a folder
other than the default set in the config. Add a command line
argument for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |  6 ++++--
 Documentation/git-imap-send.adoc | 15 +++++++++++----
 imap-send.c                      |  9 ++++++++-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 7c8b2dcce4..4682a6bd03 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -1,7 +1,9 @@
 imap.folder::
 	The folder to drop the mails into, which is typically the Drafts
-	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
-	"[Gmail]/Drafts". Required.
+	folder. For example: `INBOX.Drafts`, `INBOX/Drafts` or
+	`[Gmail]/Drafts`. The IMAP folder to interact with MUST be specified;
+	the value of this configuration variable is used as the fallback
+	default value when the `--folder` option is not given.
 
 imap.tunnel::
 	Command used to set up a tunnel to the IMAP server through which
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 8adf0e5aac..4a0487b66e 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -9,21 +9,23 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send' [-v] [-q] [--[no-]curl]
+'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
 
 
 DESCRIPTION
 -----------
-This command uploads a mailbox generated with 'git format-patch'
+This command uploads a mailbox generated with `git format-patch`
 into an IMAP drafts folder.  This allows patches to be sent as
 other email is when using mail clients that cannot read mailbox
 files directly. The command also works with any general mailbox
-in which emails have the fields "From", "Date", and "Subject" in
+in which emails have the fields `From`, `Date`, and `Subject` in
 that order.
 
 Typical usage is something like:
 
-git format-patch --signoff --stdout --attach origin | git imap-send
+------
+$ git format-patch --signoff --stdout --attach origin | git imap-send
+------
 
 
 OPTIONS
@@ -37,6 +39,11 @@ OPTIONS
 --quiet::
 	Be quiet.
 
+-f <folder>::
+--folder=<folder>::
+	Specify the folder in which the emails have to saved.
+	For example: `--folder=[Gmail]/Drafts` or `-f INBOX/Drafts`.
+
 --curl::
 	Use libcurl to communicate with the IMAP server, unless tunneling
 	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
diff --git a/imap-send.c b/imap-send.c
index 879c72a606..0e33baca7d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -46,12 +46,14 @@
 
 static int verbosity;
 static int use_curl = USE_CURL_DEFAULT;
+static char *opt_folder = NULL;
 
-static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
+static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
 
 static struct option imap_send_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
+	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder"),
 	OPT_END()
 };
 
@@ -1770,6 +1772,11 @@ int cmd_main(int argc, const char **argv)
 
 	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
 
+	if (opt_folder) {
+		free(server.folder);
+		server.folder = xstrdup(opt_folder);
+	}
+
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
 
-- 
2.49.0.639.g36d50d01f0

