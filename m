Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D9228E562
	for <git@vger.kernel.org>; Wed, 28 May 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452717; cv=fail; b=ga/McgaY64zfoDkkR9rRCr8McW+U+h6EQ34VU8tD2Wn84Z4fSpleckrWSuXA+JJN67fH/JoSYweCdNtvTfxOA8GCVbIfTEgmjO+HGmcEFhe2NCbh1eaN3QB1TqgEqBCQOBcjRxyYg29HH4g56m2+UgniPm1SlEevBErW32ZJW8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452717; c=relaxed/simple;
	bh=j1wOPnUGPd31pgNM0XAIAAlVm0/Pm5XUWhFQdkcGSwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B2BtAu1ETIwYgEc7+yiV+r+KOaOzORhm3+LcFDf5dyZoXgaTUzdfzMehoFkLcC2Z4a8+hu28LsSbgGDEuAPQkKnAvMw2nHRrcCI2GnWPqCNx+9+PzI3aHBrsB+vuI6Km4trAghG1e4713+bR4h2hQini80OJPOouDC2/1GrCeVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pnA9U+Qa; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pnA9U+Qa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id4KO3NBaeExzMFu153nNYJ/8SA7wEJ2/aT7et/3055uMRAII4SK4mJRjvO+eespulwURwaO/s6KxwHuv7eJsUJ7Hum8xccn29qmyOXKZFLdUicoW3j5H5MYvjK/+O8jaMdfXVwWQc2tD9GNWsf+FpDceN3d8Ogn13BqOxpmuoXs6lKvbTCBToM40ESvSL+p+TS2zr+ePHSXvZ9ZZFYT85uKU9JOencj5LZ2ctrwv5Thpcq1TVuRsAIqgwdjcwkPBcAUzEJ4PJsxP8YgXj7p1DGph6h3jsesI+cPlgfQK+mfJpJW1jVZTHbJePi2m7+iGrv4iCmUMbd5VgAXhXML9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+BOuuZu2iVVWMWZS1hiEO1pEX7oynQ/iqzpUWw7utc=;
 b=nUj4SWUnkg5zRZ4h3PS/XGVFCui3Y+PnOBw0DVwfUzTiZahCZFjriAunnaRLxMPHP+/3h5dnB787JPaZ8J/9EW8A5nndG4Y/fR+NXps6EX0L26WTujwCaTlvu70aQkovH9LSxT/R/hVaAM2G43DwcHEPHTrjpK47EyySDpS78U2Wjl7yQ5CWp5JTQjnB1PMfot4v7V2l+nm+UxPoWtPXFSFo4oUHD0B9N6HRvTQITEars31os6LphLW6bQscmXokKNYdWAnOVbmwcXFZGqvaiHgzHJtoY+iiv2GujR7omjHnf6itV0nG+4AWn4BGO+eoQ0H265Zq8yqTyvu7bqclnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+BOuuZu2iVVWMWZS1hiEO1pEX7oynQ/iqzpUWw7utc=;
 b=pnA9U+QafSUJixCya+n+UAYme0V/Grf3jQlrGCX2dIcVtNbP7WdOb/eGXQD1/vm4vZTirPpUAmtkDFkD0uJiJKjzlYo3SX56b6/xgJQ1RZOmlEFcItWc3CJgUyqos/IUS99PUMofYp38/HKPQAVDzvthwvBpnQU5/WdnfbfM2+R36SfyaEMwRn+45jfjfLSeN+NLPLSOBr2R81Z5OFROWcq2bvcga+YRd4Rg2zuVqhEfgRdYW8sF679iKws6EPeJ4g9pa7buSjGFFymmWVeEb1434xAjw/cuDbkHnlkZhYbn0juP3So5zNxVWenQr/hL77h82i8UqUaX9dFmyK1+/Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9864.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:18:27 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:18:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 5/9] imap-send: enable specifying the folder using the command line
Date: Wed, 28 May 2025 22:47:51 +0530
Message-ID:
 <PN3PR01MB9597D4A0A928A95548774B13B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g5db5b64a3b.dirty
In-Reply-To: <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528171755.90367-6-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: ea5b3429-84fb-4ebc-046d-08dd9e0ba889
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayHzgPFTkOkKHOaNyTn4nQw6/ru12wGiAUzew2+sGXqSndXD/XLwSivs7eFJICqrzlthImCV7BoE2XJauMVm6Mf3mhaSWCq7FoNsv7aC9tA9J3f666jbc0rwPKuBcanp3cvbTEQHGdKN9VgcBRqpJ+MMar9ZPgxdlS8pT0n3AoUw3R09lc06gCys89fo5U1LfKJ7XXaIfwzbTyr81ZrVJrmNhfaDR3a8Opvqt61lnH6OrrF3yyKx+3UojGQtM92tFFc/u3RwFL21LnZKUElZWuHVRCB/u/J15PtBTjMMIR4HKjt2wQ5ByDgL8LcSRISkbtF6XC/gWKW8dG5I7jXnujNHxgxNXDrTMONL4WUFRMsAY0Bl7BYLvdD9bvYFfUUcuAvgrx1CWqavUc29WB709ytoNNleFioWXeQ/Ixoyzz2k4RKmuqQIxXNtT4LWMxz6ookpfTDEXJzj5KeG5DBZiXX02L48TsNKXbGmuI2bbpNk53gHery+z4KM14/6CpCE7QZy+f4yVcUjtoe0PqLh+0TlWUrYumUzLZwIGnI+JKShDkGTmm1ANEbG1SeABgCxEF6n8DEYRIe89uqeHHg9ppjBQ7B7lC23s1GfrLel+lUa8XUv9Q+9BKGQ3cvaK6hiaJtdSJWm34qG793gEgvpq8+u3iuPstbQkl7qALAHnrKF8+N/6SJ5gIyKCVcRJd9U72ociJvQSCQGQoXwj/XKzZLNgemsjFAWBRs=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|15080799009|5072599009|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zaDPaWQgwhWaNXLWfTIsNeVTKxr/GSz2/qQC1Yn76WRRWxptdJBSfeinAt9n?=
 =?us-ascii?Q?x+T9HgD8KmjnBHOO/S1K6G/Y91VzMUbsljJs7ee0gs346Wl8EBgfH3Mmc2v4?=
 =?us-ascii?Q?+eFW2/0T7tKLcpgzxVhY3BNtoVAWT3tadfFjhihDA7xcMRuugKr8ALAazAU2?=
 =?us-ascii?Q?xvTPaW9ZpU664LHCYMbSU5+UzqA+punQT0KlFW948EPs/Ef4faliVFX4w0rd?=
 =?us-ascii?Q?OXCi+J4wYA/m6mRlxbal7t7mXYqpmCA1wtNjei2MmvLKuQpiH4XJFsdgNEwq?=
 =?us-ascii?Q?1uftlM/h7TmLmKsrpze/jgg64fkKxnLiJej8bDIBWCyueTViuXcuEgQEt6/d?=
 =?us-ascii?Q?0NXRtf0rYh0cRV/Jt5UyOZEz0RJlG8EF55Us2cS4KVOqEkM7MpBtp0P6jTG/?=
 =?us-ascii?Q?8VLw1BfgOQ2K6OLBaq2viDkQ16NW/XdpV/gGp1Ty3xY1BaG4RoHZalVzsUuR?=
 =?us-ascii?Q?/g/0wiKM5mmDTLQqp0QpL63/4hOU5UcTZGygBcgtLkChoJUp9EoVwVWWkc7/?=
 =?us-ascii?Q?bS9j3GqAQL3G9O3EJYwVT0TcovY0zNsDh8HjqOeGKmpyMujHDcb8d12Tf7aN?=
 =?us-ascii?Q?tS+RX/tDiglmVz6N+yGgi7lNPgtqoEPS4P9BdWjAYb7X79d+OD/DU7BeWDhV?=
 =?us-ascii?Q?ARf2PiAX0+h9VcPtYp24tjpCW2MWwZgzhI0KqCTYwXnX7iWyJfUENE05FaD3?=
 =?us-ascii?Q?lAg7qqiWzq//XN/EAwPJitiwVQKwLqyoEc2DsOt1wfeAPuPz+qIODhFUxvsU?=
 =?us-ascii?Q?WWiTCVYXl8t5bTuJDI89kuU5p2bReuR01nY2QfpOG8yfJ7OR7iRhR2mfrYnU?=
 =?us-ascii?Q?ozGGjQeIIemnWf4by2+KABdEeeovPXfTqPGrl+3SdKUQ5Kpl2lAgjDuxIfFG?=
 =?us-ascii?Q?Kj3DFWaKz8Ksz/9QwuHa8CopusOgMnVb7sIiTonMHO0ujbquELxi4+pVaYjV?=
 =?us-ascii?Q?9y7IPOhZh8m1lbO/l559zSVr/M9kHpSsI53T/X3jb/o32q3srngoWaBJvH98?=
 =?us-ascii?Q?i88eP7wMgeg5vNlEHfWX5PRJhmTUMxxRlfN+ZpkEdM0ecD31A6+RRWjAokCI?=
 =?us-ascii?Q?KMQFq9eVq1OcpnTbtAnFTgp1QXNKkB7s1SZGLV+1WwXeWABIoICopEVS/SPj?=
 =?us-ascii?Q?h/TS+31kQAmfZEBVmtxRc1uNSIyDFWSpzw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A6/ce+nA9sjMXegrJIeamGGj+fNhhRIgWnxoRM1wr06XL8GOhO0dwFSQQliA?=
 =?us-ascii?Q?O5ZC+TatOhySngSLalwp2o3cBeSNwuE6uI8AYEgvTx/E/klLGDs8bpsylGqD?=
 =?us-ascii?Q?sKK0skt1Khbn9p9txsrJGZZ0qodAH0gF59ZPDBDeCoBDrGozFLqAQZLjNR3W?=
 =?us-ascii?Q?DfguS/8cJOmin3wWJjGdmAj43iPr/+4stdzsAYq9z0FfBGs5Y3JLE00aCuve?=
 =?us-ascii?Q?uuJQwg8bSeEfDck3GQuBBJ3regwTStTcG5E/Mjp1ylpHk1t4xHTkzK7QWPAu?=
 =?us-ascii?Q?8bo4L6JI+9Cln0fgsg7GNlmVOYaV9s/LEYhNoGY2s7pnxsmOfZphp5e+pXcn?=
 =?us-ascii?Q?qUxirKLigpFBD1MeN3rtEY9cebX3ESoEY1L7CiU/URU/r8O4CouwNVlf8SAc?=
 =?us-ascii?Q?toqUTuuA7JzWvwd1ffEwgPBSB6r+n4R8AYKoYljvY3dUXlaWz+y56Zh7sRCl?=
 =?us-ascii?Q?2gjlPnCy+xAW7HaFErc5B4ijZx3xhzQWKU6TSZB3fFUu/Q6IJm94sI5QMMqM?=
 =?us-ascii?Q?WBfmlL5wHnWTzOCiHE+eG37zyiv8ElidY5kDTXE7LCNbyMmYQXv/rhc2eNaX?=
 =?us-ascii?Q?8dbpvt4ejU+16WDrRxLuKTb8T8qYLlkBg6mv/xVxltaTMa7RCCODd3rv4Ghb?=
 =?us-ascii?Q?nec4H6Bgq4hFJ7yw7rHKUwn2HQVFm2DSYgayPBMEzp89f+O07kMGdUmjfNWd?=
 =?us-ascii?Q?kLBXzMMocLq22rkNBiHkWixUbKepKlATTfxamzzTlFsJpuZacr1802+CHdYv?=
 =?us-ascii?Q?zr+ui6rN0aIwley2QM1Ck8W35bVTN0ZyZekxyxolBkxFh4UaUL25oMEhCz3+?=
 =?us-ascii?Q?tfdF2y1ZNmM7PF0Wx9U9VsXlSKawIMLCL2tfMj2x3ToFQiE+HZ9qIW/3vv+O?=
 =?us-ascii?Q?OtEYLUOYkCV7BGpiX9VNacPPxnY3WqjSZUcdwxC9hnXTRbXmPcO0vot/16pb?=
 =?us-ascii?Q?wJK7Q0e1MLL1I8F9Ak7pE8MsUprqUriWOt4NanCmkjJ54CuSTxjE/CVTfYAz?=
 =?us-ascii?Q?Ugh+AqAeiLYErEwFdnWPNgyasp8eFypzQRxMoOHDKxpXnyrJdkA10QfJsy06?=
 =?us-ascii?Q?Ttf8PVwcihNupB4jc+zIzjiCdQZakJED4CtAug0p51tuv61hhBOx/5T7kC19?=
 =?us-ascii?Q?LInlikiZ9fawmYC5ltuYRxWZmVm05sV8u4S8cqOhG6k0o4zD5xdMVF1mYECG?=
 =?us-ascii?Q?VAkfm5UelrWPllD1pltoaSt+WFdF/anTR7Y3AVQYz1C5QCpnARJSmWy/a+iF?=
 =?us-ascii?Q?69ab8w+eB1LgK+QNNCz42DwRkjFHNSVFAsrbN1iFCuy+eBtlZK8/jaXSn1Xs?=
 =?us-ascii?Q?iBTFwmP6/+zTNQqfdnZGmB7p?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5b3429-84fb-4ebc-046d-08dd9e0ba889
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:18:26.9867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9864

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
index c3a46070ac..a35f278baf 100644
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
index d0c7bac030..337f1049ca 100644
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
 
@@ -1762,6 +1764,11 @@ int cmd_main(int argc, const char **argv)
 
 	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
 
+	if (opt_folder) {
+		free(server.folder);
+		server.folder = xstrdup(opt_folder);
+	}
+
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
 
-- 
2.49.0.638.g5db5b64a3b.dirty

