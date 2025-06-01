Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010002.outbound.protection.outlook.com [52.103.68.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D0919DF98
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748761943; cv=fail; b=WxCCTXFM0E0uNFFzqFKQgd74gTDUijX8s+5EBXnvuzf7D51XuoOSULCLAk+1HuLnUagV5arvnKzywYp0VFz0OoxwrLX6W2ATujq7/9yqikzbRZDgVgBrD2YrKR8dO0921uYt3ZqoHWDg2UQCk3q8BjYpuCwVG/9G0J+/GQrT9qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748761943; c=relaxed/simple;
	bh=Zf+25oj3gHA7k6XtoEq853+eZcuh0LMr72n+PngGsxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l1enaxaVW7hZKQSusmf8OxsZiozoMuWBls51BMz87oY3S+WkSuxuRdrSLgi67oxe3xgLt9g218lveys6SLOizGrG0XZQRBQAx2XhPKNXTyNgQ5K0DMNNZQ1sfp2RPXq54T32Vdi+75zZuz/pte8nBWdx8tbUws3sycN7RCQROXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=PHY4hLsE; arc=fail smtp.client-ip=52.103.68.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="PHY4hLsE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1RDT6YkWm6ri97COdCqDKo6l8Fkyow68NktlxB+QikjlWZqfK33M2emMRVEOQCRqoaFKoimKN+PnJJ6fyzgOGBeyq6egJpI7ONX24Nhm0e9skL0q3iaAD9rtkj0Y70dOMpLgeyQrXK9N7Y7S1uV/FvP8v+lqwKd0kUn1yA1SwfUSJQbD4jemjUUG7d6JlIUqGa8Mud1GCU0DSip4pbI6gu2iNFbVMKP/0RJSI+izGu/I4BFvUtMrmRMWindbwSnjcFPePiJ6yeQOVQGGix/Hh6SN+B8tugnyniTrkUhdKY62scDxvos/nGfAhoyMzDIDAY0TShlPuIgreAMrZIM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtwMNPiZ213Gqo+IwhG6e3nff4P32AlC8InsMiBtKYg=;
 b=LfyH8uj+Bh/IiThnlNTAjOumQ+WI2taX9c9bPuvvxwfAI7EYkGUML00rwhkG2LD11vbjRM1ADYxjLVn1k2//8QBk/xIUPph9cmIs84D85qPuN0SgOIiZRFedMY20XIkeTPCUvhOtYTSODkrkefgHlSoiC/2Y3tTbBPHDu9Pfq4tipWLXa8ra7btg25a2hj8ClN8VXdfN/PcLjRistBMXF7wFfNcqm2ERWZ+TGjs7fC0lbRSiOPJ5ILn7XcXal9RRTLgAfeFT9ady4R14En3voz78ktrs0ED+bsijpU3smUi7OsCaKNLzFCKW3dgGDbdC8bjrGzLpXQJWX/UFqFG4ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtwMNPiZ213Gqo+IwhG6e3nff4P32AlC8InsMiBtKYg=;
 b=PHY4hLsEuBbQISx81kyxcYfSPDgmp9KKkOSsQmHaM/Oe4CKT5qYifYfEQp7ukfPy7THlHYMAWany5zBuAQl3UZ71hI93hLx1XHG9rAe2xWNPU9nYKS042DohgXqGAff0b2cBwaVCtJPiMOF6vFD4/MkTHtZleOHsXcXZSafTVoZ1LcpgzFuDisSx/UIBqR0bUR/178gfW16Sf5uq+cR/asEDku/L5rHzxnkXsErWEiyCtaX2qnxjShpGGU4gzud/auJvJeyNwQX7FEROIQjW1ke9lRxN9oqLQvIOeYziEvEf0H+ck4XE5SuuLitN6AYWCmEXKqhPZTJKFt6beQOBuA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sun, 1 Jun
 2025 07:12:12 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 07:12:12 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v10 5/9] imap-send: enable specifying the folder using the command line
Date: Sun,  1 Jun 2025 12:40:31 +0530
Message-ID:
 <PN3PR01MB9597B2AF1ED0AB5902C72C93B863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g67a2d115ec
In-Reply-To: <PN3PR01MB9597C4D1176FC7E9A459C42DB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597C4D1176FC7E9A459C42DB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250601071035.2412968-6-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 382a74a6-bd38-4d0a-fae3-08dda0dba14a
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnVpqwGBbaZZVJnOMts183ZjSbyZJjCOsMfzLwKYbYkWccuuZSavOrQDtGon8yb44BMrUp+7HL0OmcOjA76sva2Jv95x2kdCBa2O6UIfjacAV3n5zW30oihT4UQt1ul4+my8O/OC6rHBVl9Z3MkRw0jzvNoCMmi8JNxPIyc9WlFug90laHVY7bm2TValSoWUFeTaQs5uJ88TEERdjiQtcV36VhCL0oisjjbMSZAoIe5r5sZO+3Hcc9YAYUauEV3opz4sQKt02xOFxzY8J6YvLfgz0xl1fndaiV/Kb7PqAC1+pB5rOVYoztA8u/bThmFqdP9Z+jORHDvJTcDmjkj/FyBoPqlmVRXkbu9Lj1RTUrXofhxCi7isa+YT9qVtWjpScKIT8e2jHL0PsCXQ+Htnk/5osVpEPo05WElcsEJJzBaBt7qANOv2BTnrbvoGFHJXC8QSTbGMw35S+Pq+56xGjviIu4Rr7loyIlofsc9s9tr8pxh6pNtWBfg7m9FmiHOrL7/5Dv2qRIj+Yz3MV1cH4WEVnwBxjXJoroU7S6OY0mt10hewAql/Fwr+76sWOSVwjXiRvFpRy6uUfdIDqKrL1sgqSBGaZ/s4ipcnjah/JrRCi4WsjgcWja/NhJkfVx+GCVvVqrnlkcsLKJWbCwxIChc/quXj/Lmtz2RAR7wpdsA5inLV+2HA6vPfzywGhf4QtyE0xZstwdk0dKtln3xS0bJ5Nv3KVS0K8RE86CU1Q22xA=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599006|8060799009|15080799009|19110799006|5072599009|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9yTlAwYI00mgHfkwx0bUX1jY1JUNSGE8V9vSIFD2JrA1PxSAGX/9IBa7+HNp?=
 =?us-ascii?Q?vBFCu0FbNbgfgipMg2Rmp/SWPTGqwRkR9TTDuZl7D9CGpmSesIF/9FNKdg8k?=
 =?us-ascii?Q?EJPQzz/rNWH0zyEnsjeUfIX5ujBKkzAcBlKxQ8+jCyJ0xo55OxlhfHkGCiff?=
 =?us-ascii?Q?RPKJceaK1jUw1tU/ivI7NC+KkzOgNlcox2ZyBOoN4K0BlKOPolNRrgIPZuUd?=
 =?us-ascii?Q?Oyo18gOnCk6DLez/N93JJtQwu9amJyJuzXXW6QkJgdfrI0YAE1Exnwnom/UQ?=
 =?us-ascii?Q?OfWj4qo9GBLsJQUp8Yk928WJufMIW4zXtx9hUvoISLzs9FpZlds3W4rGWVIZ?=
 =?us-ascii?Q?JMPp7GzLA421yOJgTpWNHE/Dwz6MB0jBqRNzvffhVlY9c6IdA+jnSh1fwe46?=
 =?us-ascii?Q?n59lqDjoVNwqShIt6kVCVSJXJEETi1iL7vJVXaTfFkyiswcsn4ZfNhTFxVKl?=
 =?us-ascii?Q?u9i6z75Ort2j/Rbm7j4mZx4oKtiQd9n75wuN3TliqrXhk01osFUWC6jFIY4u?=
 =?us-ascii?Q?4HPonut5QCu3jhmGS1uwO9Zlfnfim9r6w6WskoatDAZgQimT/MIsSDCqjHmf?=
 =?us-ascii?Q?Sld/k/MZre9BvWlGZopzv4STQ+JIQF2pfAXXVyXBBPT8tpfayskD672xEAoT?=
 =?us-ascii?Q?fQlGk01T3+Rsc4ylkEX2cdwKWV7XH/0EyGcLR45tWDBZ75xLxnpVSzgJTTBE?=
 =?us-ascii?Q?MboGw66OQcPLRHTOQGLtOftuWPzz1+l6IAmDk/CsBdZeuWEgB7AG+ZMwFFt9?=
 =?us-ascii?Q?cfljWW2ejLDFyVE5O1JP2nato+UR/g/GmMr3LtdKjPFe2jpN07PpB2twBA++?=
 =?us-ascii?Q?f1EQJ5PWmFQLZCdbst2o1hFiECUaU/xI8bphu5NQ6KsfmR/9mqfHo/aNaUqz?=
 =?us-ascii?Q?RrMQoCE9MX0Mnd5cb41sMC/uJfpIJyxBrNZWEI4Ll2dupri316PpeYLVlIAf?=
 =?us-ascii?Q?GK+3ZBoipK0YMrO8DVx7QU6JQLTkZDs9VqKzvz7T+l3VaBVS1fLSRrERKGe6?=
 =?us-ascii?Q?t4medrqaC6tJF7QuTzjLaM7k9HyLR4RGEiZHgD9phCXzLdfbU/sfKfpnyLav?=
 =?us-ascii?Q?OE97Kfu10XIis0x7YBh2cZW0STZOuxc8r2qZDzt+pZ9jgryABRnV9lLN4hZ/?=
 =?us-ascii?Q?/fnCIzTKaqa/3YCiJadLMjff54XOQla/4A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VRY9Sem8ZUCVfnOhz2DGNz9ZNkgp5xs58PudA/FUl+bu43o60kEyjMI9RKbZ?=
 =?us-ascii?Q?1vCYoCFd2zTv35Z3eZrcCxvro9QboMcmD1pU/lVf9RDgRl1rfN2lpxlvpGYK?=
 =?us-ascii?Q?6aPQFr8i864moLQ/g9ffWvRiA/QMkTmlY/lVlXsCVVaDNQ7ETg0MtewEM34J?=
 =?us-ascii?Q?SXWXHlLKXvvJRvrQ5egosY6Eo4/It4Pji/ZnnchnzyzEC5l4Juym63WsvKDN?=
 =?us-ascii?Q?AZMOzUgltIQXzBPkPA1s/459c+0UhHLpzLuLtcXga1Rj0VDAmxLJfsLbKRjo?=
 =?us-ascii?Q?Vxl0/oT13dGC4zEYZTsPbQlTtnsYgNTl/4fHq+8zjWzTKEFUK2sKDUzzXlGr?=
 =?us-ascii?Q?OMDBuIHViUCpKO7xqYZ7etudgn8P7lJWXv9cna3E8K4puZbPsDd1DI6L1tXa?=
 =?us-ascii?Q?GHDD+CJbXXimabqaXkUMA4B93LgeWpqLqPuqSCSzFkAZd3fSALBAHPU4NSwP?=
 =?us-ascii?Q?Er8W8G73Vrko/6ZxuXwqmydiV25ujsXHC3EIj310Bw2Le21UEqOVjCf19uda?=
 =?us-ascii?Q?HDn7IejOuLjI89ERLSy//zcTJjo3w+aQzaG8I5uPbxlk0h6Zut6gWiD+p/a2?=
 =?us-ascii?Q?hXFYjctuYcvY2p7/3poJMSUw+WAF0IEzD2JMSKYCvsScLfa4N4VzTTnJgtqM?=
 =?us-ascii?Q?8/UJJXSP7wXdazRCBMWvtIn05V94SuqKOfGsvdCFU0HtDXNUNkyWI9QehOsn?=
 =?us-ascii?Q?u/jPiuCqPo87AwGqQlxxhqm+rY6gPvzlUQB0Mk9l2vdSNeowot8q1cQOlW0q?=
 =?us-ascii?Q?ahhfUByoU/BrURKs2Vm9XGducph5vTTQbHOoyLEZTAINKDP4Ra4azf9LeARO?=
 =?us-ascii?Q?4b/uBF+/hBqNT7KMOJd1HV9dvatEeGIux9nvDJzC/OqTpUIWbNHCX3tTUYeb?=
 =?us-ascii?Q?AdhOKojfa76NVX0G6FWQOlb9QKNchaJlb8Ck8YdkNWmTJMQxIVaYFwTVfB7j?=
 =?us-ascii?Q?/1nvsZaLMfiostk52005s9liNKzpHoW3AZv5TM2Wkx4FziAb0pwEabv6GbLU?=
 =?us-ascii?Q?YdqJG5BlIKSPyT0IfwHAwftPnp64r5u/FzzDKN4H4/s07+NlLDiI/DjG1s7i?=
 =?us-ascii?Q?rkmqBWnVAkph/ZaPeSuJs012ZylpiCAdjk5ebi4SWDbUXnCx3aVvGfgRSeGO?=
 =?us-ascii?Q?tqvCYG4/i/B1NMOD5rgsJ2En4AcXY7BP+fB5G+acnlM6UVhe5wetpvdE7s/5?=
 =?us-ascii?Q?NAQhtbFTM3JFzcTusHYkGYTYtgrQytexnxtQLYJe7izsq+XsppeRLWINdIA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 382a74a6-bd38-4d0a-fae3-08dda0dba14a
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 07:12:12.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9108

Some users may very often want to imap-send messages to a folder
other than the default set in the config. Add a command line
argument for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |  5 +++--
 Documentation/git-imap-send.adoc | 15 +++++++++++----
 imap-send.c                      |  9 ++++++++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 24e88228d0..829d9e0bac 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -1,7 +1,8 @@
 imap.folder::
 	The folder to drop the mails into, which is typically the Drafts
-	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
-	"[Gmail]/Drafts". Required.
+	folder. For example: 'INBOX.Drafts', 'INBOX/Drafts' or
+	'[Gmail]/Drafts'. Required if `--folder` argument is not used. If
+	set and `--folder` is also used, `--folder` will be preferred.
 
 imap.tunnel::
 	Command used to set up a tunnel to the IMAP server through which
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 08ecb1e829..8f221240d0 100644
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
+in which emails have the fields 'From', 'Date', and 'Subject' in
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
index e169c5e919..cfa335b647 100644
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
 
@@ -1766,6 +1768,11 @@ int cmd_main(int argc, const char **argv)
 
 	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
 
+	if (opt_folder) {
+		free(server.folder);
+		server.folder = xstrdup(opt_folder);
+	}
+
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
 
-- 
2.49.0.638.g67a2d115ec

