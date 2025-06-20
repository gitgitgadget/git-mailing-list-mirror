Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011026.outbound.protection.outlook.com [52.103.68.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7759A2222BE
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401667; cv=fail; b=hV0fU8i92qg4/gX6TbZxqiJeM//YZD0bQpS60o5pTBlZDAjNi1m3r41AAzZ2+etvHdCErPqVQZi+8YRob+BTGY8N9leEbePYd+Y58A+PMfYD9vTmlyvXFTmZ8UWmT6DD1YX1nRN+8dmJgRbqbBKIHwF5QMsd87vKmEx2jvRDaYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401667; c=relaxed/simple;
	bh=AEGbxBSubck0npRYSOJuX7O+0A8jMYoLeVr+hVhupmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JhJZz7hNuj6uCw6XzXHpmzvj3qKMrXPi0lm7aSO4dBnaaa7p2ggm/jn6G7ySutRZFzkBxBVZrRwJcyHffxpxCKy1tw553UuNtUk8apIsN2vg49auG1a7n/zo0zvTppMOCXjtNa4oAVvEFwGu0lDlFnbEY8/bOFVM2MYVbkElq+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=IbQrrKH6; arc=fail smtp.client-ip=52.103.68.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="IbQrrKH6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMQhTu1Hpt0BOEVbiPFryPdgjtTaRXvngUESApmZIjHDdDqTLS5/QbvN83NUuwfa8VqcNoO+OX0oGkSxDiCkanv192XAH9pRYDoRAJXb36TXF1QcR6MjSBdEMTZdhVAvlVfEOfLotCpD12yCBUXOhpUCpaocjGoJWLj8qGwrfmcNgZbvr6Gze3c++eO1GNbWF5wZl/WGmAa7aqHneNxkU6w/NQ8xQQlilCKZJzdUIoQxYtx9ErgrWOItYvm+ftLasMW326jwDAYdRuTVvsIiSepHAFs/vvxcRPI+BSGJ5O4IP7tHMXSfvYq+hsP7GttiJguTKz9Jqm8uh22Dx3UCWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZU72RDnLnHMFKbatfL9uIRdjemyuRY+YXVCyrlJHAA=;
 b=WEOLQg9yHXFo96yQ8WPBbh28/GlsddUsM0IPc2H7LKRLwzLMowvqz0hyAq301dwGb37aOHp9Ebl0wa/e1lXX/04NtypQK6RXvUQzZZAU6mRUrKWCz6XulIbzjer5HbldtDLybemZyes1P7qItUGDRhBHDKNHWEsoafMHGOzj2fTNup5GwDrw2U9pNEnZ7o2PGyHfi97pOUnBZhm4r2kQeO/jCEfS1vPMONUyVqqAY78ISuF7CeZDh9Euk7O+iu+jbszh7b2kCWv7g+uqG+e9UtzFRr5+lTiXbcUY3tn/17Vi4CNVq2C3Z5T+NT0paXms2SsLTU/Of4gprOfCXefTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZU72RDnLnHMFKbatfL9uIRdjemyuRY+YXVCyrlJHAA=;
 b=IbQrrKH6DeoIjWNN4I4/00y/lc8GU+rGweJ3WqcJFkofMEV5aQQBcZi/Eb02EhAaYn5nSSitZ89EjrqKFs6a5/95WA0G4egzVNea54g6Ch3JYi9kjd2I62RRF5z5wexL4fV2oC0LHRHEu6FhRwMr8OiqwWTTIrV/Ps6gth3hk1cVTU6SV/KYG4lhipzqTai/YzE1JsmYxFZj/JXakMM3VHd5R5zH+CrQCZBtm5TjxYCu9gEDe5VurX6au2PPJchl3B/n9Y9KW4enwMaiHK1Q1IT6M7mgUF27XffBGthRSZ2RgahnAiaOIpLFFV13ScWlmJau7nIQwsvg80yVbfgsbA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8150.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 06:40:54 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 06:40:54 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v19 07/10] imap-send: add ability to list the available folders
Date: Fri, 20 Jun 2025 12:10:30 +0530
Message-ID:
 <PN3PR01MB95979DF96F8B65497A9CAF81B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250620064033.15814-8-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ac8ffa-9a2d-42cf-f034-08ddafc56743
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|5072599009|8060799009|7092599006|12121999007|15080799009|461199028|41001999006|4302099013|40105399003|440099028|3412199025|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HPU8v+WSKLPjV7kwhrwtPs6VUncQys1utt8FaU9T2o6KGv3rhKN5U9O1+5XQ?=
 =?us-ascii?Q?MpN5dIII3a4aQUgLSNfw76Wylk39bb96pOe9P5MMntfak/GsjY/MPFV9qLGt?=
 =?us-ascii?Q?3Y4pXfmM8QMKwB73HlhOd1SVa2MNa371qq+f1Qsdy/lmtt5jl96Dkpz8nXpx?=
 =?us-ascii?Q?VtxmLEh8b/sIpjyyZs+xEsTafLlXPFAVgMMwtPvis8jgFn//2OqrYOYeeV7F?=
 =?us-ascii?Q?v0wTIza8c/V95UMD460f3yrg3HLpHBKkIdc/8ErZXzYniHi+JewuFYFxg9fF?=
 =?us-ascii?Q?ZlRp/2CyEmVAogVzODz0WX8l4MYPBZhKja/jNgY0yN7sk7gCei7i+9hv8gYc?=
 =?us-ascii?Q?orXQEo7qMKi4+X7VTDRSoCDeCZWmNpgDh088/1H3NBxeJYX138+9oOYRTtgh?=
 =?us-ascii?Q?olGPWqJrKhzVrCMXyvxG5jop0PKypnfTTL8SWZuLj3oU3G5h8U4OB+TS3wQo?=
 =?us-ascii?Q?EBnEqNYXpGl7g4Jpj7Qajt/8zdnkzz2UmrFf383CmljkOYL9HGt2y72TJrg8?=
 =?us-ascii?Q?LjbP2nSP8yghKMDkOCET8zfemaXGpqOHmt5PcmubLxCnY8zhp6iO9ycYkWOO?=
 =?us-ascii?Q?X+UWwW2T2gPFfbs7YHHcvh40tJo7vCrM1yvtQVZam+6v5Ah1f/PpI9zXrkhq?=
 =?us-ascii?Q?z00UDDi4G3rlvF2hcLvKQicjIzpQ95HlBuQzfdhyIw+7zWzP0v5HNFDJPMQ3?=
 =?us-ascii?Q?3v+VcjjvhWC03ramwK47PD2PA2b7nXPsZELWVTlAksI6zmd2RbeTZauCMs7x?=
 =?us-ascii?Q?SNpUibq55R7yMsevkxLFrxDFJsSHIsgSER+ZJ6lEvVzGPizXcec7UpLjiFLa?=
 =?us-ascii?Q?AJuAzudkpHoXE5oxo1YdgZxIzPfrA+8rmPt25koUX9pfIm/W0V/Fgf4dOog7?=
 =?us-ascii?Q?SAADKucAkGWOecual2MYRquyl6jIj4UUXcaj3jRtxJ7eaEWoMPvC/kJUKnVl?=
 =?us-ascii?Q?mvuWr9HDFMofY2/POvGGKcUGa1XGH8CQ9xbnITv9BbeokSBFdcAG34xzCQL1?=
 =?us-ascii?Q?LUZXy6KsgmXX1Kc2u31Ej3TuehVwBkB8cmsXGptJZLBNy2rE7CQIMZJ6wRuv?=
 =?us-ascii?Q?8hnTaTQKFWFFd7cmwGCgooLc6EELJNPTKI4ihb5fC4//8fN+S0RdeCxrLeTb?=
 =?us-ascii?Q?89//d2x73A/CRQqeCSs4MtPF+E3YM8tQCFOPuSyzDuSixYocCcI09n3FFN7R?=
 =?us-ascii?Q?FDZcUjWtRL+PVFo0Nlc5yiGBZvHPDheeOVy63mBYX0NcgfI0/FJ0XLJWfSo6?=
 =?us-ascii?Q?JQgPQzeOdPVSZSOUv3O5g/I1ELBcblxiVPhFd0DFN5CWW1S7zdNAbiA5vh4q?=
 =?us-ascii?Q?A9AUxzyZJFoJEnebjQzSJkyyQ0L+STq0sq+kk0eeobXw3bHYo8+wjUEQDBPx?=
 =?us-ascii?Q?srtxKF0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yEbzCTpGVv0YVBdJiIp/mQWa+hmWpafXkx+ciMBRJt43T5Z60E7MxcrSUBSK?=
 =?us-ascii?Q?kkfjS97OMWoA8JPNdHgLLUkhAddVWkxUPaOL7G/0+B3dxFi/PXGhW2bE7XHA?=
 =?us-ascii?Q?UistIpE4qxIeU0eLS18IDJefVwxjyh/z7lQVA+bnnB6s3/ND2B+RrRJ4pUpB?=
 =?us-ascii?Q?Z/D/ercL9BicYJ1v1VpR5G5vX/eV1/TAT36EsSeoX3k07s8DC/lIs64hkZ6V?=
 =?us-ascii?Q?ID7NcCN9ZtZawVq45CKyz1YKjoa/CMpT2xY0JF8X/y3Ig70Fw949VCkN149q?=
 =?us-ascii?Q?igL3WISxff8d33DCujw0tE0seOs5i7Pnevfo9Zx5YObMEgu1bbCDSmoaOd1T?=
 =?us-ascii?Q?Ke7wsN5EjMxxaORfTIfPyKf8QRFi2o0q9Hrl0q/wJM7uqz9JzTMac1sdrYqd?=
 =?us-ascii?Q?1G+B3TLsmB0CEUcA0bOrcvkJTAmF/HRJ+mAUCqUmAUV0C3yEdq3Zkz2cwLtn?=
 =?us-ascii?Q?x3J+voxLPInFMgQHff/6kZrJf1P9y+d8YJcZAnQWsqDeMtOqAkSiPoLqvl/S?=
 =?us-ascii?Q?RR622nDoAGKZuKQBl3M0MV1cr37TY1kTdpJP6AquG/Hk8vuZQMg/lYFbMuv5?=
 =?us-ascii?Q?kTdC3GnMDFe/YefW8BscMViUxA9N7PYbhbx5r7omovkt5fmUSysEwz6S5tSM?=
 =?us-ascii?Q?AFaKLzRDJWKIwuDZmrzMz11ugZ5VGRSZuyP3BT9s9zvTxZIPWQWEcXg1d31c?=
 =?us-ascii?Q?kXC8HOTaYxGKHEMlnvOFonjb9SLbe8W7lMOEgK8rSdfoKUd/Lw9hyyJmg61B?=
 =?us-ascii?Q?WoA9SYAOApi7lz3DI6Ho5N9xHsBj+R0u8CPzBAwXNgafphtUce6qhnrZ2PRs?=
 =?us-ascii?Q?639nldsTsZTAf3oRUehCLc6n4Wp7oZbFWTSjqAwLk2KhhCgn229KzifjzqfR?=
 =?us-ascii?Q?ZCV/cPeapWrN55LieXLX27DIfho9Q5oWiAKtWta7oV1hB7XZwNyyrPsry3GI?=
 =?us-ascii?Q?M04OLFg88Bj6+vItCm8FcJV1Gh3U2xToJrtPp1gW3aI5LFNDahg9MR/aLyRh?=
 =?us-ascii?Q?w77X2Wgxs3uC12X71ufqqMOTzFTc/eH1kTeHCzXHRXlyZOYPTOUWpvPc4ZMc?=
 =?us-ascii?Q?1SsVkbH6rE22deDgEawCy/NtCtgQ8Vxu3wxcqvMqsEK0QFkSz3CLhSnVrUJu?=
 =?us-ascii?Q?TSZP3s52wDWUeo0m93Zmip13DYIDcsI7rbYSRgXMVQ+5K3dXZGpwbqDmEsFD?=
 =?us-ascii?Q?Yudc4RBrMigDwEptm+wnYcGXVhaHaYkURUXdWrsPzKOUoY7U4oMBffIwBEDo?=
 =?us-ascii?Q?pfvavySj9kuFy/GD3L/ByBuH75I64rlBC/l4fi0Zj3ghn0ZBr1aCKuI9w74q?=
 =?us-ascii?Q?1CI=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ac8ffa-9a2d-42cf-f034-08ddafc56743
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:40:53.6208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8150

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
index 7e021c8392..b1dddaff3e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -45,15 +45,21 @@
 #endif
 
 static int verbosity;
+static int list_folders;
 static int use_curl = USE_CURL_DEFAULT;
 static char *opt_folder;
 
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
@@ -1572,6 +1578,26 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
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
@@ -1605,11 +1631,13 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
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
@@ -1640,10 +1668,6 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, (long)srvc->ssl_verify);
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, (long)srvc->ssl_verify);
 
-	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
-
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(curl);
@@ -1662,6 +1686,10 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	struct credential cred = CREDENTIAL_INIT;
 
 	curl = setup_curl(server, &cred);
+
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
+
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
 	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
@@ -1707,6 +1735,31 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
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
@@ -1747,11 +1800,6 @@ int cmd_main(int argc, const char **argv)
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
@@ -1761,6 +1809,24 @@ int cmd_main(int argc, const char **argv)
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
2.49.0.824.gcc76007b2f

