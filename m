Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3204C20E6F9
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483773; cv=fail; b=cypmbhNOWYsokcYVTySd7lyXlktySF+h4B3L46UcfpQbwwE6SFGkdUIA/Yu8Ll7wL8590i0clyT0JN/Qz5+QQa+4zSAPWNrAXpiAELHRHgIUOqqOanwkZwVTxd3rEeDmBJwiaWg3uOmoGg5OVDk461ab2/ktajrXVNw4TaJtZc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483773; c=relaxed/simple;
	bh=O73vWi5xy/mZrZ2j0EiM7LoWWEgjyGzxnM0qlkhjdc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q0gYl9vJ57nyn3kcrKhGwqyv4a8MR/PS7BcObcEuA9a3tAMH5UMgE6sRIjOO/pYBuqSdDrDNkaUK43vbpA5q/uXXOVCuLAptGTPFRuWhLs68E9akAazoRGWhxoGLOq9rPyWINwmXGDzqFspULlJf+yxrBBUwmoFzREoSeoxQETU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=RgPxFm2O; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="RgPxFm2O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLyz8h9nwSRcx1y18hf7OW/ldJTZjn0HBYbfEd327JFRW2rMipKPnt2Fh4QcYUkl9gFlrTsP1ghHtGM3yWsxtE1yymc8d7WEY4rlgwdt53I04daUxZoc/D/MD73egNVMT7f1ZC+EsFm/XhTRFJPgYXGCwpX6J0SPvgbd3ynXEur+Xot1rW4CekeQd6QLH46F5FjqW3DRVjCdXl9bO/i0LuM+7Gn9h3lMgmliZ+1f5/psFxENIOQf8/Pp0gOnSIML64X/4GxXenaWBVYIUfPZQrd7WFBG2YEs3Hji6YOI4dbZ/SRs1KhRUvRWURmAzxqhtwnuQdSbgY9U1ADygV+KgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZlO8wOWqsU3xlnahXU3NicGp/qJYkirx8pzBcRdZTM=;
 b=alUWa2oQ7RUWb4pbjvnFcEsgahGZHC4a9X7A2br80fCHEXFZMrF/NMVjcAQ1687RzdvPWJ9+2XKlTapQgUgrPGzIwhRXR+ZcufCPg+SLVeZHhAAynnC/v5aP614eSvtjp4vtrzhRXT7vaMP5AgT1d8rDvbDjhstr6pTr5LYziaMR73jG6a9l5IfiUCNIA12MHnKfeDgKuP6T2D6SHS+7uJZU5ftTZWT68jcAf4oUJS4YdiyE4xumcyeHFlzGlaSFvfZJ7NHBC0csR3B1woxAgCXR3W5PXv4MlIzmqNqw7MWFQoAQKpX6bHTENcFuGemUcKy+uvrSJavRDZaPePFS7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZlO8wOWqsU3xlnahXU3NicGp/qJYkirx8pzBcRdZTM=;
 b=RgPxFm2OoIjypp7ZR3jyRVDtaPg0V5SfNCsnj68n8tHKHi0tnexJT43b3wAhIlJC1PxRpoxkKz4+qfvcRbV/YpWXNQkyCS6vUEHWv12AFyIHMWVlDqkByw1Oy3YrroLjnuZVOp8TueU9yzaD5qbo/QXxHHqIvQjVM7vXrV1++B4DMW+uPpscpEdZFrHOtdG9F1/lRikniCc+Kk+OatB0GGm7OAu9dTA8BK6FrC0NQ5cfHzttodoHLbMacSAUo5xQ2m/zsu+9ZqA/Uu24pMa6nmURPUJrIgQ2QIuyeipD0wsKy0GxuDejNpuSKGYmyPLl/hJfEP7NZ/CB9VF/Z5XmQw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB5751.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 15:42:41 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:42:40 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v17 07/10] imap-send: add ability to list the available folders
Date: Mon,  9 Jun 2025 15:41:26 +0000
Message-ID:
 <PN3PR01MB9597374F0302B72B71574CB8B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250609154129.13552-8-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b631935-bace-49e3-6c15-08dda76c405f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|12121999007|7092599006|8060799009|461199028|19110799006|15080799009|8022599003|41001999006|10035399007|4302099013|3412199025|440099028|12091999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZzessVzA6rwYAsR1IwnWLvWVX9wfBJtQYlm22V6yXqTJ5UKx7gMtluUb3WJ6?=
 =?us-ascii?Q?2k3XEyHdBwa1/tML4lcDcgwxrb8VBgyXtPurLQvqrMTpORzoIfoxKK01YFJS?=
 =?us-ascii?Q?uhAPHOiE+D4jP34BIAoLdKaTU+gPfaQ8uuO36yKCgVBNgDkaPB046JVQcdgi?=
 =?us-ascii?Q?l2xYu4wsW3VOYxCEJP/z5ZmACBb9XWt4+kwiaekwIYjpdpg7Tzxhc3IVTqJY?=
 =?us-ascii?Q?GXdMOoL571dHjyknWKewRpd/UZy4x7Zi/RABR1SQDIGUPYhRsT9AJM39AO0G?=
 =?us-ascii?Q?Z8cuIMb2dxVOt3NxDh7FHel9bWhgGFY8VTZbYn1r1wvUGfV5qoZywRMUcuDE?=
 =?us-ascii?Q?xeum7so6K7VwB7HtEJ4La+2ObHiu7AJE/7aJpsk9IJVpbri3xyA8Pk4/eyQL?=
 =?us-ascii?Q?d9tLr/FZl6CNrxlGENZGtz8yVSK9Kk5iZBx8QZefCDVgaQbu6YNQMrjJA8xw?=
 =?us-ascii?Q?8fhwzIfK7m8Ui+jVmNSlDHhURcKN63bRF6HLKgCy1ZS8UdzY/Mp/SgeM6NF5?=
 =?us-ascii?Q?zDWGkpmGtSqqGnOC3kXDmicwM+Rl4iSpHEcdqhuOq7Kp80Nu15XD+rnapwRf?=
 =?us-ascii?Q?8Ie/QB96yJ2SifQh6LjBsYI56CKnnl4bD5Hs0P8CRE4oyNj/Be1rJNGPHB31?=
 =?us-ascii?Q?SkJlKjvmyYD4EFoybDWsFDN8YztsvsMs90M5atXhgSl9cVQpLGjKBzszmUc/?=
 =?us-ascii?Q?QieNPR/ssaUn2xowMQsa62E4rvDnkiGbbkOFx1W88lBiU+Wz1+4HmFC0pyLr?=
 =?us-ascii?Q?dOcagPy3D0mXHstCuskPSwFdD823yRzzkaPz3hU8q85V4b7ADXx5u2VaYgAM?=
 =?us-ascii?Q?S3k6JZg5hFCIcfpzXk+i4KWGZE/gMHRUM3D6Ri2hM1HKXH1hmyA+mzgU9Dk4?=
 =?us-ascii?Q?0WJNAyucvK7NS2by4algRgq/d1QVo7fajFfrYbuldYlnn4P9JW9jKlqZj3P5?=
 =?us-ascii?Q?9/eArj3a9QD85HlljYLwI/Xnamu7DsTQJjS3xIH9tfE4gq3RlmTJdwVRlM8+?=
 =?us-ascii?Q?CxwKKC7bMjk/IdhfnhjrFxsUN8/Sn0mdsd4IQcu6TT/q41EqSHBnGx4XWzKe?=
 =?us-ascii?Q?GrRVwrDeztk2xWh+qJn8X0500giJQHgvGKA4rG3HPOfN6vvoCmifS3mWhZe7?=
 =?us-ascii?Q?ryPcth2I0oKIWFlpGbigzZm+zZEdG2XZJbmVCbBuiAkVpisQ1/iXWnSn8sFN?=
 =?us-ascii?Q?irx9YG58dRhnNKARkxAvEGin5EULkOlYmhQMDn8XDFkF//C2zwSZWYMCS0Yx?=
 =?us-ascii?Q?FUXZfexP65SwSTSRTD9PoWo9HseInpaIA5a0igM5z6r2hUmyC3eN09WlmqEh?=
 =?us-ascii?Q?al+qK0D6ZA7//qLNbKhw+V2boZAPR4qLIED0d1tRkjeLogEiX64rn3l6SCf6?=
 =?us-ascii?Q?rnxx+UM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ffSnaBb5BdWlcDJnWjxvKjR0pyVuBBFWbBwV2ALc/oKzoSZ7Vl8uD/NwhZO?=
 =?us-ascii?Q?rthvrJqO1aqsmJ51ci05leAkailSGAWYvhM65K+gNO9QR0rJBsev0jtB+Dmo?=
 =?us-ascii?Q?B5Q/LSiPwsxsY3RZbVPxgsI8z2g/oezU96W4dw9L1Xb8JPj3phlCD88o8jTg?=
 =?us-ascii?Q?Xxifzehkl56fECPTXgn6sTWcvn/a6PbghA9LENX6X98Fh00YsF2saJUMKBGn?=
 =?us-ascii?Q?5g6L9VNZ96r2xxzIP8Bdy+PKVDd8I8nahkQa0akMnzDXXURg9g4f3JqYmoG+?=
 =?us-ascii?Q?K/djqGHY6ffccCYjfCKdM2HRLo8GJ1KJyXyhYPtbh2bH2dRrDruA+5XTAILb?=
 =?us-ascii?Q?nMl6QE703JvG0B0/fHrSwabahXVyQgXWVMRqMVjKmw45WFnAXGUiGGi4pCbq?=
 =?us-ascii?Q?ii8EFzXWJz80cgKsePM6mduKh5RmFqQObL5R9gP/bSfzGs6JRiIoeQtf+2qD?=
 =?us-ascii?Q?q+sgy8VQ2gbnln/6jGyoL/EuZE4p3aCI2+ZtPesTDS0LlKJRRHIuG5rZUEFw?=
 =?us-ascii?Q?Cu15qq2L+YksswRM804po38WMqUF63yiYYXGFq7twWi65k3grCZmqihXmZ8P?=
 =?us-ascii?Q?/vtbsiH1WLKfbwxj6ji8A9nhDXpLYjRTvAbHeGmpowO/2ik/n2qnWaN0rWFi?=
 =?us-ascii?Q?G8ybqpBI8oKNmFOPTtqlqg3vEnQVcjtqOHYq+ZwCLwQUIZCg4wW77LM858qP?=
 =?us-ascii?Q?Km1cd+AtsQyjwaLvQx4+k9ju+KiF29Q81JWCz5EMa2tFrntFugCxD1YnH8u+?=
 =?us-ascii?Q?vUaEsQ80kCncG5VFCZy4y3pb5A3gZ4acH5fADiR9r1KagVaYqnGpWm8dVqa/?=
 =?us-ascii?Q?abuRlMVvY+n4TqWN8+zvP5z1LW0RkVPwAgc+PBX9VoboYgLRnm8PeJ068jrY?=
 =?us-ascii?Q?orO0SEKobjfSjwHGRcpOAwNv3zvAbFpl2kZ8ykaZnVleoIYs1rb9w11hHRph?=
 =?us-ascii?Q?FBIApqeOFArcta/QelkSz48v21i19vR2sSU9ERpy5j35XQWx1FjTHDwccpUh?=
 =?us-ascii?Q?o3OPc2lIRxWM1j4+PwPclcXJAgp9PmQ1ldPwa/Kdjybhq81tMRLLgkYpkRMN?=
 =?us-ascii?Q?FOmvC4Z0w3+bTBa3+po1F/6ZBq8h7dw4wCGHG/OAeDXdvaHm5jW1ik/f+KUu?=
 =?us-ascii?Q?ziW7HOcWbTPer1ZCLz5juJJSYUDuYTUAurC0bf/cIlZkXxYmueWkl6tX3lCJ?=
 =?us-ascii?Q?Ppkh5mgrVu/OTVC2R/89dSd1C4rDex4psMd1l2IZOMlcOAtCJkwzv+BhB3A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b631935-bace-49e3-6c15-08dda76c405f
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:42:33.7198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5751

Various IMAP servers have different ways to name common folders.
For example, the folder where all deleted messages are stored is often
named "[Gmail]/Trash" on Gmail servers, and "Deleted" on Outlook.
Similarly, the Drafts folder is simply named "Drafts" on Outlook, but
on Gmail it is named "[Gmail]/Drafts".

This commit adds a `--list` command to the `imap-send` tool that lists
the available folders on the IMAP server, allowing users to see
which folders are available and how they are named. A sample output
looks like this when run against a Gmail server:

    Fetching the list of available folders...
    * LIST (\HasNoChildren) "/" "INBOX"
    * LIST (\HasChildren \Noselect) "/" "[Gmail]"
    * LIST (\All \HasNoChildren) "/" "[Gmail]/All Mail"
    * LIST (\Drafts \HasNoChildren) "/" "[Gmail]/Drafts"
    * LIST (\HasNoChildren \Important) "/" "[Gmail]/Important"
    * LIST (\HasNoChildren \Sent) "/" "[Gmail]/Sent Mail"
    * LIST (\HasNoChildren \Junk) "/" "[Gmail]/Spam"
    * LIST (\Flagged \HasNoChildren) "/" "[Gmail]/Starred"
    * LIST (\HasNoChildren \Trash) "/" "[Gmail]/Trash"

For OpenSSL, this is achived by running the 'IMAP LIST' command and
parsing the response. This command is specified in RFC6154:
https://datatracker.ietf.org/doc/html/rfc6154#section-5.1

For libcurl, the example code published in the libcurl documentation
is used to implement this functionality:
https://curl.se/libcurl/c/imap-list.html

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-imap-send.adoc |  6 +-
 imap-send.c                      | 98 ++++++++++++++++++++++++++------
 2 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 4a0487b66e..17147f93c3 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
+'git imap-send' --list
 
 
 DESCRIPTION
@@ -54,6 +55,8 @@ OPTIONS
 	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
 	set.
 
+--list::
+	Run the IMAP LIST command to output a list of all the folders present.
 
 CONFIGURATION
 -------------
@@ -123,7 +126,8 @@ it. Alternatively, use OAuth2.0 authentication as described below.
 
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
-that the "Folder doesn't exist".
+that the "Folder doesn't exist". You can also run `git imap-send --list` to get a
+list of available folders.
 
 [NOTE]
 If your Gmail account is set to another language than English, the name of the "Drafts"
diff --git a/imap-send.c b/imap-send.c
index 522d01c88e..4ac0ba606c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -45,15 +45,21 @@
 #endif
 
 static int verbosity;
+static int list_folders = 0;
 static int use_curl = USE_CURL_DEFAULT;
 static char *opt_folder = NULL;
 
-static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
+static char const * const imap_send_usage[] = {
+	N_("git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>"),
+	"git imap-send --list",
+	NULL
+};
 
 static struct option imap_send_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
 	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder"),
+	OPT_BOOL(0, "list", &list_folders, "list all folders on the IMAP server"),
 	OPT_END()
 };
 
@@ -429,7 +435,7 @@ static int buffer_gets(struct imap_buffer *b, char **s)
 			if (b->buf[b->offset + 1] == '\n') {
 				b->buf[b->offset] = 0;  /* terminate the string */
 				b->offset += 2; /* next line */
-				if (0 < verbosity)
+				if ((0 < verbosity) || (list_folders && strstr(*s, "* LIST")))
 					puts(*s);
 				return 0;
 			}
@@ -1579,6 +1585,26 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	return 0;
 }
 
+static int list_imap_folders(struct imap_server_conf *server)
+{
+	struct imap_store *ctx = imap_open_store(server, "INBOX");
+	if (!ctx) {
+		fprintf(stderr, "failed to connect to IMAP server\n");
+		return 1;
+	}
+
+	fprintf(stderr, "Fetching the list of available folders...\n");
+	/* Issue the LIST command and print the results */
+	if (imap_exec(ctx, NULL, "LIST \"\" \"*\"") != RESP_OK) {
+		fprintf(stderr, "failed to list folders\n");
+		imap_close_store(ctx);
+		return 1;
+	}
+
+	imap_close_store(ctx);
+	return 0;
+}
+
 #ifdef USE_CURL_FOR_IMAP_SEND
 static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 {
@@ -1612,11 +1638,13 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	if (!path.len || path.buf[path.len - 1] != '/')
 		strbuf_addch(&path, '/');
 
-	uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
-	if (!uri_encoded_folder)
-		die("failed to encode server folder");
-	strbuf_addstr(&path, uri_encoded_folder);
-	curl_free(uri_encoded_folder);
+	if (!list_folders) {
+		uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
+		if (!uri_encoded_folder)
+			die("failed to encode server folder");
+		strbuf_addstr(&path, uri_encoded_folder);
+		curl_free(uri_encoded_folder);
+	}
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
@@ -1647,10 +1675,6 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, (long)srvc->ssl_verify);
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, (long)srvc->ssl_verify);
 
-	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
-
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(curl);
@@ -1669,6 +1693,10 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	struct credential cred = CREDENTIAL_INIT;
 
 	curl = setup_curl(server, &cred);
+
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
+
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
 	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
@@ -1714,6 +1742,31 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
 	return res != CURLE_OK;
 }
+
+static int curl_list_imap_folders(struct imap_server_conf *server)
+{
+	CURL *curl;
+	CURLcode res = CURLE_OK;
+	struct credential cred = CREDENTIAL_INIT;
+
+	fprintf(stderr, "Fetching the list of available folders...\n");
+	curl = setup_curl(server, &cred);
+	res = curl_easy_perform(curl);
+
+	curl_easy_cleanup(curl);
+	curl_global_cleanup();
+
+	if (cred.username) {
+		if (res == CURLE_OK)
+			credential_approve(the_repository, &cred);
+		else if (res == CURLE_LOGIN_DENIED)
+			credential_reject(the_repository, &cred);
+	}
+
+	credential_clear(&cred);
+
+	return res != CURLE_OK;
+}
 #endif
 
 int cmd_main(int argc, const char **argv)
@@ -1754,11 +1807,6 @@ int cmd_main(int argc, const char **argv)
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
 
-	if (!server.folder) {
-		fprintf(stderr, "no imap store specified\n");
-		ret = 1;
-		goto out;
-	}
 	if (!server.host) {
 		if (!server.tunnel) {
 			fprintf(stderr, "no imap host specified\n");
@@ -1768,6 +1816,24 @@ int cmd_main(int argc, const char **argv)
 		server.host = xstrdup("tunnel");
 	}
 
+	if (list_folders) {
+		if (server.tunnel)
+			ret = list_imap_folders(&server);
+#ifdef USE_CURL_FOR_IMAP_SEND
+		else if (use_curl)
+			ret = curl_list_imap_folders(&server);
+#endif
+		else
+			ret = list_imap_folders(&server);
+		goto out;
+	}
+
+	if (!server.folder) {
+		fprintf(stderr, "no imap store specified\n");
+		ret = 1;
+		goto out;
+	}
+
 	/* read the messages */
 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
 		error_errno(_("could not read from stdin"));
-- 
2.49.0.824.geaff4db692

