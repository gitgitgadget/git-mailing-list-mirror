Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37598217F27
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380247; cv=fail; b=rKy9O2vDIiqepow5++7fo8jH7v4GJKLi1SlAYGGZkTCFa7s7Va7Y92BcpMOqlH7ocsIe1N+7a/UBDVIHI5sVpMRH/qrNaVHRxXk95dN3G/aN5KtxxrZThcyoQzosVSpo/L93hhMExykbPx8UUQ5ScArhqBsj+5XqI1ETndtXNAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380247; c=relaxed/simple;
	bh=Fe8LMwED4V3yOyFrEKVtaCrEitEuOEvka8m9saa+Xmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g6moXTDh4S9ZLxeX6KG9uOD4KQZ8IHXWoGq1BGghpx2bli4HYgXz4UaX5GHuDMjPSC0oDGFKJwQ3feB2t0WIirW+i4y8XlaVjSNodiJNCSAeQbhqdtXw5m6kfCR6X4BLR0uKZCIex4S7y5cm1Zz1rWgraNlDVK6NT022qYU82yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=VSXZH7nc; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="VSXZH7nc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JB9A2CJsAX07uuurd6n57IJHgowcrzq6vD4v0mjJBtDg0Qa/qDNY9NJjXL3zvx0rqtICOfYFU2CnAo1zoosSTqkdWD3ieqxS9woKUNljF3lHAbfpdAU/pfWGj+f3A46scKDV8VrrOlkBK8PB/GBshxpMjiho2KK92I6QDiK75LmwhBpkRs42uU2xLpe/QwHE9uq7j8lhtieW+fw0KIYu5OnqhyXe5nPFn9lRBemfRecEOOmJcjfl5UIz0q1i2+WqXPda3MH3nSF0oCcOq1/Kjs9ifxZpxSz+tZP8NlQuYS7MMPq9l9LmsKAD9IRHQcuL1dl+KuXCRjbqBxZBj3JyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEF5TeQEpluE/gkTErOYtqC9UHlY11Vvit16iF2x9jM=;
 b=qkRzteJjq8QmXwWpKe8217gbsPXjS3sOt4FJHtu7Vt0wV+/Px/uGpJgR9GMbI1KPcbQHV6z8zfT9VFB0TSN7hfGFOpKFDwLzapj41P9fs4/2vZ20Ig/5CMx5dL/gtNv79s19umyod2HMlzjnpRBhvYqbeeJskCFIX6siF1tesYWdQgoEgvSZqK8fnWZltMsCdE44UJG5umQP5XtZdTEzmjxdwmkFYEXeezgZwbFcNfb3Q0B7jT/jffaY8vp3Yr+IIS9kCcrROzElzp/Vw/jVpsnr/gsW9r+HjXc1LdmjrFpS3zW9IIJSzVYLKxWxOJC7SEDiwEp1tw+rif/Yo4/jdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEF5TeQEpluE/gkTErOYtqC9UHlY11Vvit16iF2x9jM=;
 b=VSXZH7nc1Iw2km7rEA4d/8p53Py4JF4DlemI4TlmXabD09MGeXCEQnF58osfq1jGdDh5nPF3gJAvyschqGM1zvVSNz6DPz4jP4LqN9B+7ggzK6JoMIVmew5tmBv2a1qtqwYAK/5zWPtUoZN5C9+RO+qQjHWjpR2XQqzKyo/ZlltBIWSAAKQzgp3/4dO6BdMnQdtxcT6C2MGq0d2r6x6OZVXeeVpTaTYStRGMilcRcWKFScxVtTnLLyqrey5bU4ubG7V7mlscpPwkWwLk1YiBgRYrpvs1OYQ+sM/AMy4hCa59nLGcbVs9EqgXcdcT9MiJ7JaTXhWtOSfBh845PzO5fA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPF9841FCE60.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1bf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Sun, 8 Jun
 2025 10:57:15 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 10:57:15 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v15 10/10] imap-send: add ability to list the available folders
Date: Sun,  8 Jun 2025 10:55:19 +0000
Message-ID:
 <PN3PR01MB95971D49AE9AD546D13F1398B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g4d9a3b5661
In-Reply-To: <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::21) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250608105520.18264-11-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PPF9841FCE60:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbc75df-1a86-44b7-b786-08dda67b37f5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|12121999007|8060799009|7092599006|461199028|19110799006|15080799009|41001999006|4302099013|3412199025|440099028|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q9jPQzYNEPK/fSvjGBHjGX8L4OWaTQGPzL8G6ma/gb0n9KuRSEzjH2hJpZ6R?=
 =?us-ascii?Q?8joviEW6vVgpzJHQP5U6x759UJzXBxqTUCAbyn5AO+x/bF+EgegC1ZM8UJzx?=
 =?us-ascii?Q?VAUHmcku+cHqzfei89ff+0VgtNIh9TYsU52Qrtpp0R/kpLGnRoRSM6gfxiIH?=
 =?us-ascii?Q?+bSZvBSKCgoQyCNKmz3ceAeHC7y6T4JpULDPreUFSZakWkXUVfZJ3xk2paJj?=
 =?us-ascii?Q?ISXZq0IoCrPzJln+FQrc5DAqZmOPdIIwwIz96wu8nvbrVZmFq2DqkD7B/FjL?=
 =?us-ascii?Q?SdH0jzA3FSpL9U8+soNPHh3L4wYOihVzOZk8jDU+KZjL/qpLd2pY7X7sraz2?=
 =?us-ascii?Q?n5Ypy8eWl5+sp3D1CaTAh4WRCS/WHFXI8YN8CFxB7i5nXLOEaq76OEdthhG7?=
 =?us-ascii?Q?AF4kFNCfwyxfY7v8NkPqV84xtXwXXU3renx4zZO/yyn4qH077viqrHFix1t2?=
 =?us-ascii?Q?n2+IZir0PW9Sb77pWfGcq5Q10glkIIWVA0y2MOpvq4gc+wGXTOjmRC0A/dEF?=
 =?us-ascii?Q?uKQScLhJ6s5hgpNH6awVExTNAXVxGa5abeoppIOHR8mqFAJfpyRnwRgLAdTW?=
 =?us-ascii?Q?7wGdybshv5AkjWGtlNdivzHxMg/wJJO++jUfdie7f5IvGAnw6pLKtaRuxtem?=
 =?us-ascii?Q?CQ/ePHbukmiWc5s64K8izUAFxT2jnnaq8XyN03M5UCs3sOtkhYMAkSTGKiX8?=
 =?us-ascii?Q?4yC7VTH01Q0Wl6c8f0B6UFgYnKATC5wofgB+n/Sa6sA81Sc/t6bAmyjMaZJh?=
 =?us-ascii?Q?SPnzal+DgI9BDMdMkx1dxNccBi4WBFOTO2O2cSq4uqMEFzOZ6wHleCD+JV34?=
 =?us-ascii?Q?GzKTo7mj2oQgZkTRNbB36ZzEHrmDfmzAv7oClMW+hIGAKEqmftFU1fRdHBHj?=
 =?us-ascii?Q?TZ9O7LsasEWm+/r6AEhuuVK49Q/9rYVqR+l5+K1pdDTN5vVdcNNxwwSvi0+A?=
 =?us-ascii?Q?FHUZgbMxR13MVzZPbrkzgcWN7icEXvhZ00Zl9Oyuurfhf5xiwkm+YiAZ8k9D?=
 =?us-ascii?Q?RO+NWaqr9iZZfAbmyHahtjMhe/f4afefX9eXtAPBVLsaiWQgdoAJN+i+A8hi?=
 =?us-ascii?Q?wTP8kuc+dIsgKW5Z/DzyA7jjaShAuYPOyRnr9WY3NN/N4HIo7kZ7mrDRpvN6?=
 =?us-ascii?Q?OzW1hsnazrYPcLabpJfvwpFde8k5uAsx7Q3+KDrHseU7jTeKiMMYRLWaOm8c?=
 =?us-ascii?Q?b5LCKoQQOvis5J64JJA+1gML7UWD89ISvtSl0N5mMiiwcB3JDKJHZtupKCBD?=
 =?us-ascii?Q?sLLpruxtMYU9o0WG20jN9KpKVuDTeMosWe2ahNXfi/QedhhoaYm5zcWFLRvH?=
 =?us-ascii?Q?Txj3e4rKn6/Qz5bUb5KpD/BuWiyaeEw0Cz+bTsyTyDsRJA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dWYgPKNfD3BQVFjGPr8Yk7xIy/MIlGUBJMLpzZtAUxFFUwIo7CUEY8+prCn?=
 =?us-ascii?Q?zWbZ1Yj9IoNmH22YUALyECRRRF7/NP3RJi92diLtEY/Ay/9vA6EmUtnd7mO4?=
 =?us-ascii?Q?6xg3vt7po13g3JSCyxeBAnbEh89Ewz6RH0hoQFwYlPgdd/1Mj0TJ0hcFvQgP?=
 =?us-ascii?Q?h/+wfSf6MMSYQ6L5PcHGP+PCalghlCaZIb0b8JBdAqPYr/pmx92hTuQvb0AO?=
 =?us-ascii?Q?4jAIvsWSyznFV2Q3gUsnhjABMWyrku5ArFXgpjmYEoCf6dp2C/JMFiVEgj09?=
 =?us-ascii?Q?Wu+5ApwtHtmKtJn51Ceh2+vaKi+5Xc6ZopDtHu6kBtHUXegImr+10FNVDD9N?=
 =?us-ascii?Q?SXcYX0567Qiar5bxeHcOZ2KsaC7b/8aX/jmSufcXYOZdrSr/eWw87JrgaLGT?=
 =?us-ascii?Q?XmSUwo+ltXnb1TaEMmDzDEW1da9BoFHOyXk66/48EdN6VJVxq9Ai6B9JtSo2?=
 =?us-ascii?Q?+oXi7udGuzAUqJCy+rdp7aU8Hkalsvpt/4hlY3oj+RzuOLfm37+jV7do0PFn?=
 =?us-ascii?Q?7MidFISXGq1P9Y2Tir873WfJqVMsYXlYxnFkLu9isdwM9/X5BcVZHijllSFh?=
 =?us-ascii?Q?Gfwmh3+rSCFB8upnwoD9AkSl7R0JGaed25u1fWt6KR2JkVe1euOO2poSJlfA?=
 =?us-ascii?Q?ibtGayHzOMTVpAZyXKu74er0BDzSjVsVUCv+Z5HVVxl7TpdtncNezC+hkluG?=
 =?us-ascii?Q?VPXIhfQRx2nEtefkiO54EkCwA4E6ZaLZMbds+jwxVef+WnR0TYQ8YI+JssDC?=
 =?us-ascii?Q?TqSST6IwcqgtCbMVgZ0LrGO1+HnwcAlwku8/hwEDPz/fDVlY8m+zy3oK7tMP?=
 =?us-ascii?Q?rhDEEfyWzJiPQx+H394kZHZvIxN+OQa9fOlxjaeZIOMvXGYQns3fHGx6U3sa?=
 =?us-ascii?Q?J/U3WPkx3r2yZsk4UODGc63XG1oxTJekKcmn7hV4Uh/kX0K2/B6VP7XQMoTy?=
 =?us-ascii?Q?ebzlTsDRMR2XD/PPImu4I8+2eLrYSQoYQUfGw7R7nP2XqTspO0iZcFhSXJja?=
 =?us-ascii?Q?ah0ZF9gLvJE1f9tKTBNCm7zPe4SAWbjz7ON+iWoEOzKY5JlurlCtO6hrrLNf?=
 =?us-ascii?Q?BURBBHtqNgZxfxRlaqbof8VzDrm+c3WyAQqL5JcFse831BwP+j1jD0pGmFRG?=
 =?us-ascii?Q?irM1rJqaDQTswsiVJGO/i3GSqsgemh4sfPOMArEkIXbXCtvURbiIyZ81UJ85?=
 =?us-ascii?Q?uMSvtuwj5/YbYo537YRM8ITTnNasM/VGrhmWf8GWZmBc3jO5VJX3jIfhO7o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbc75df-1a86-44b7-b786-08dda67b37f5
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 10:57:10.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF9841FCE60

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
index 9281112bea..16c2e641ac 100644
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
@@ -1580,6 +1586,26 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
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
@@ -1613,11 +1639,13 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
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
@@ -1648,10 +1676,6 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
 
-	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
-
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(curl);
@@ -1670,6 +1694,10 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	struct credential cred = CREDENTIAL_INIT;
 
 	curl = setup_curl(server, &cred);
+
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
+
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
 	fprintf(stderr, "Sending %d message%s to %s folder...\n",
@@ -1716,6 +1744,31 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
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
@@ -1756,11 +1809,6 @@ int cmd_main(int argc, const char **argv)
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
 
-	if (!server.folder) {
-		fprintf(stderr, "no IMAP store specified\n");
-		ret = 1;
-		goto out;
-	}
 	if (!server.host) {
 		if (!server.tunnel) {
 			fprintf(stderr, "no IMAP host specified\n");
@@ -1770,6 +1818,24 @@ int cmd_main(int argc, const char **argv)
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
+		fprintf(stderr, "no IMAP store specified\n");
+		ret = 1;
+		goto out;
+	}
+
 	/* read the messages */
 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
 		error_errno(_("could not read from stdin"));
-- 
2.49.0

