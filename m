Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682941459F7
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425954; cv=fail; b=EXRfu94pIgRHl1k/u4GprJRY8QqF2n6sevjRVwnVn3Uze/j3GvqKXzSuTgzwmmrGSheWl7guj63PPMu2thG4+ztVPyt9o0C+aCuqXL1q1D/Zp9qMu+A3NeH3IC2tSOal6uA0Imvic42s0g+64EeWa9st8Qn4QO6Nkx7G9gAXjI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425954; c=relaxed/simple;
	bh=Vx1ZS1Kjcy2TGwJky/SMvzDYkYbmd3PlYlcsQPqeZ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ft9OThsdoxbI6DLzTMkX8yoUdwE5RF/vEiD7/E71DmUwaTi9dq2DL5AEjiOfAPK/0dPNBxBvnzhWgC2vof4YEGzcrAv4O6632rTmNU5F+EAvAwEIzR869fBZ6ccnfDTS/3C1y4dXZ7xkYAsJC7N89x/iIXsLX03mPwkcUoT/SXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=aoU8f2Yg; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="aoU8f2Yg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRVDaSVKdt9NNS7cUdLi7woEbA+MC9diXYkO1tu4BHhdToBdnvmnRw9jToqgs0KZlisIgvQ6c2H27PmB4m8kMAQcIEXuwbTMsK6q74EK5lv6v0iDAPKqd9XnjcswmsZKhOTLSpmKbgKS9vmvr3mFDrDx71HA5jnAOZ5jq9Sauwi8KSsdPf2VZHDfO4BGObOMiV7/8ARGhee7kWahmSiEtbc2UNGXVhkZulgt7/OI6c/QMhentx3N9lPHyThcwWZLY6rmLz//Gju/xFWf7IgtdCJiGcAkl54YIGVbTdv+eKXBfem4ialr/9Vq+d5UgP8H0ZRpaPQTexh/0lhmmxEGWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cP6bWjM/IGsUlAOXxLJFRgUunqrzTFnEUwEqauTDfHE=;
 b=MaTg5t8Qa9PLNv+ejfDHbz6D0i91cYVaEMVcN8AWhmkiB669hb8n0YPpWvUE4AptyeiSFukQPbBPGVSCsc1ZpNJ+Pu/pXgko0T69xN+iVNxw1trIUSO6Be42ftwGRYY9lDkX87n99Qb27TndCD5iPqOnBTmbag1Vhqv9k5V+vbG0+q4SySX3+xvvjcnigB0noKz1qD8AI8DwKzrpae6PCMDJzCPZsh39fObOgq5AdmxmsBYpDGkXUXdhUXMDR5uo0e9zi7LY0GxksdA4VcsNj4Oz1zOt42XC++UrGXSJCeLSGy1tFlpccxEtrruXP0XT45Sz4pKd9+tbhTOLIK8Hkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cP6bWjM/IGsUlAOXxLJFRgUunqrzTFnEUwEqauTDfHE=;
 b=aoU8f2YgPqGd6fc/ep+pKHEyPqcY1rQxBjyRbdoAhXTsxevmcVqO/gLYpZsqRTQ2qCJ5YRsoJP3rfN3MHGVJW+VqYMJK7e3FhJV86yl6e0sjgjV/Rc7K3JE8xcUB1zdFlhCFF5U4vpExetrQBSupbMOc26d21CJKhxinKahYmOpGd8Dp4XHRExoO6+QSEtz7jRTQASVJCCF4tTmexEStlHZdd0SinJP9Da93kxDPmHtU4riRjrJgIXEbfOMsNuaP1fqdcnhsML8u5ZKbK7da4oOC6tetZBq3I34AywitESexE/dK5NdLGFD76kfRnUWdZH9J4NXVG+dmb3V68SFwqQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6047.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 5 May
 2025 06:19:02 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 06:19:02 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 2/3] docs: improve send-email documentation
Date: Mon,  5 May 2025 06:16:23 +0000
Message-ID:
 <PN3PR01MB9597E545331A9BBF088329EBB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597827866A582654661102CB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597827866A582654661102CB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN1PEPF000067EC.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::28) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250505061846.11170-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: dd89ac74-66a4-49ab-57a2-08dd8b9cba27
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLR0Ybdxcp7KTbjbpYD2CblCIrg7Fom3fExwWNuvulBvpzkIBLNIQ6Uj7Po9AQwdQEy7JOgVqpzDhh5eLerG5PWOVZefndBZ4uD+SOFmPjEwvSdPfwRIdWWFmlgv8mH8Z597Ih7e8Y0zD8CvnzQcwZ7gjqpCfwCl1vTRJLTdPf33zuFPr6yDlSYzRVnXhidum+rXbtsm84zsAFkbCHwfKv7dK95BM3ikxq/zA0aYiSef7VYYOB8Q2s3lzZ4HSluwgwAr2+xieJiuYccoOBfCTpVfuEYOdrh80aK2PiotFsWZCwLexjkL3yAX/FREKUAmUG9YTeTDUYR79D8RiQ/7BI0JbERsvxz8A729doUUSjaIhlZ4T94L7kxDaDQH6+shk/JUK6U0cNbPU3j6A+4O/jM0OzrCJX5JJYPnlBZE1MLeF1EZyJeolAdd5DaYDgDKVvFxXzcKP7p/9iuJrPN6xdJO/u5IqexWPrdQEYWa+5A5JCLlCckNKyOKcqwt0O6qNg5HHJm0XvVaLnGC7TU8kHWKFLYN5tGakrK4I57RnQROL4nmRNdJ0W+jTBZVU+PW46VMQxrwLoNxDVBMqd7a3MawyISmiJenA1kJ656cc37HI44Rt78swt22fejhHoJUKKSYB2Ete5gDNs5UhCFpv1O+kpjiTTDQ87PIX3eEY5wFdTZlq8xhnGbgEiGUdpVMkek3LSK2ACzJ0gtwIwx/Ve/cXOa/rIFCmhbvEKH0y+pxvTao1T/SSbt40ZOz5zlAHeMrz7pbzm9zHJjner35GLzC
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|12121999004|5072599009|15080799006|7092599003|19111999003|1602099012|10035399004|3412199025|4302099013|440099028|34005399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H3WPtyyEq7wfD5BdIRo9CR/u3VAt6zEMKCROPBClldILELiLmNw/4i81TN1L?=
 =?us-ascii?Q?uVPn5+rRL7kavssFub7BSgYvLdKWHce33R+RM+MOw7LSYMjEnYCHYtsTFWed?=
 =?us-ascii?Q?mLG/UP42lgDi9Tv9twO7yTdy1/TShtE1rb92A5ECdKa1AK+Tzrw+TRAr/Ue7?=
 =?us-ascii?Q?YkDIW5vrxmV35LDr0vRlZNiS4v4dHQt7RTqmncq7s8hKKRAzmIpVKWBwKq6i?=
 =?us-ascii?Q?bn8JZf+bIDkSDdnn67KKltcR5ymWG2OEkVtdblOjC3X03krzMRFalUEK1dW6?=
 =?us-ascii?Q?gbbSQnn4QcqSAwrVZhRfqsgHmuV4AaHD+XxXZI94zT5g87oivQCVMI+I6bsm?=
 =?us-ascii?Q?+X/jz/3HQwAGs5/we9Ahdu14VS9ckv6tQ+obeAU/gFqULrY2zdFvFeypraIS?=
 =?us-ascii?Q?4vZy9j6sfTjrKVqxm41qqYoghwyRvUxQhmnVlalezUtGow2ynVg5tj9FDpIj?=
 =?us-ascii?Q?obvBTyNmwbyYO2kiVxlN8o/zDnFow2o7o4S2Y/DYFBLDtuZktlEgfl039xki?=
 =?us-ascii?Q?yNZydtaYA1BgbrVUhglWMHZ9MXJva3E4nF+LCpI8H78XGM3tBNd4tgcvsaN5?=
 =?us-ascii?Q?QFZ/pxxjTCqbjdwtuDDydy3EyNf9kWdFAt5F/f42ZepTdV2frf4ntl4myB8a?=
 =?us-ascii?Q?LnZbaMxtD51jTXCCZ1QyjAfuhix2ZvikunuVCfk6dJxpOsm8he+H49ZjI1PG?=
 =?us-ascii?Q?iM2WlegWpo9ZxOPD++RAMCRNExZS6ahtE5/uSOU/kd/SKDB/Gjuh9OGZkpJE?=
 =?us-ascii?Q?MxUDJuwBsrHkRoqs7UqEw3onKRSCJed+0vxb713ETtCeslBLEaum4Q0tfvbr?=
 =?us-ascii?Q?fshLNIitNh3lF743JSkpv9I7/ktZmUQrALnDxUEQ0gEA/qv7i4P1RLQohKD8?=
 =?us-ascii?Q?IozcVDTF37FuxxExbLbnQP5WsMtsVT3vRoxb9Wohw95QVPHGpqUw8q4S6dZl?=
 =?us-ascii?Q?UqBMx3C0Oh9hvUosVxWUthkvSa6GYW4T4kaU5zIbhcCAPNfJjgKSBugqV1m5?=
 =?us-ascii?Q?Y2Zq6ecP+3CY+PwdcygLiozsl3Lw9Scyk4MMAQ7Up/4s+GSMWZCZhKB8kLeI?=
 =?us-ascii?Q?NL7uiwp0GcNY+rqIg2gLDEDZF+JZYraaBvP8/tA51sGmOo2MHpvnaVpWUdN6?=
 =?us-ascii?Q?NZV7Qgg/6DJl9FfLX9QwBniIg7c+XN4095bpghTvnZJogYrqhqoIlVddxYAZ?=
 =?us-ascii?Q?qLLb8Squ/POczk2Cw1bACgTaRNWL/8pmhLRnC1V8LZZknXUWVQ/J1kKcuHqf?=
 =?us-ascii?Q?CQWmRDo39TO9XLNg3E7VjOoc2bhTthK6fBGHWU+khUUbvQWeIOLxLvZrzkZa?=
 =?us-ascii?Q?JUqIEoab1ibtEiEY8x3awCSv?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3KmlbzuYiR2ter387FVMKcwutcc0eAYWIDEcDTjtPf5AHoQfoKwhXmjewB/i?=
 =?us-ascii?Q?Oq3uQj+CsM4G938Sbt/McwL4DtnrsdjUPPsD4l+qIg64zsq/Dr9DwzgCuJUT?=
 =?us-ascii?Q?mF6/aQ68xaEMznROpLI5nkRMjQkoe7Z+lY3VzjbGr+nuWeWucfFxkA5yWbvF?=
 =?us-ascii?Q?d84R48MP3Io5tOCPHqYf+ttuZbJ8Bui8RF0ilnPOzhj29x04xtFT0GFn0kE9?=
 =?us-ascii?Q?a++aUjfhf4T7uKxMXFGHGHdQeynj7kifhd6yw9zHEur+yNkErfHDhYYvZpfK?=
 =?us-ascii?Q?FW2k/TTaZhByJ+36uuxkASuoosZW0O3n3bqjvPlXW3TOHJ8E+KrSTZT9+Z5O?=
 =?us-ascii?Q?Kmgn0GM73e9icloItXYZHMPAQ/wTWP3RysXtQt0qCEyZFBRovpJ9QlVY9rvn?=
 =?us-ascii?Q?Q2sAMBhS3LppCA4C5xGUupzHSPsqrAzppRupk+irqtjmu1Nx9tbn52RJuzcA?=
 =?us-ascii?Q?bFTg7+7mA1IodgKl/byWXpWoKRK0doAOrF1ppb4HQeADzjIgtNhBjekPQE/f?=
 =?us-ascii?Q?YIO3VQAHO/CpQyA+bIPg139kFzEV2JituxZDsrIUloAFTHlAl2Ja8WPiOVO5?=
 =?us-ascii?Q?Cud8MiDrqV8fLXFFphG8eHnmKgMcw2iZ4rKbx2JxXoe64lqDhhZFQ/DEb0q5?=
 =?us-ascii?Q?6+yN4FJOqKdmQzDQl0BxeKNmYjXtUTKGHFMFTce2aU7TMpFYIHJzlv6D0l+H?=
 =?us-ascii?Q?iFjmX5Yuv0CtLJjSpnPzFtlcY/oKthwEMsxGAtSqocArSMvsA+9Pk7mM1YWl?=
 =?us-ascii?Q?K1OCOSntTrIw+guEdq3sthRzqkVA9se8FW1Cv7u9SMZ5uTRtTit5T26PoMB3?=
 =?us-ascii?Q?Y1FGqq0/GQwYPufQJpCp7O1jM+60RXD3fd7jw/PiyTFs6+DP1iSvgRcpz9PR?=
 =?us-ascii?Q?2RNmoGFcOZB0XNqjkQiytDEImdObu28duQt7//NZbeBhpzajfk+vp2jGllLT?=
 =?us-ascii?Q?NrjeTlkjM9Q9oiqNyAgvlAf/69FecK7o7BgXYmLUfozVDrIqI02dvnWoGzCG?=
 =?us-ascii?Q?8dMEYL02pMm+tuV01+W+6UEMwaUTlSVtfdOssCk8hdVrcg9yjGmhYZOKL/bN?=
 =?us-ascii?Q?valQ3YcPSChURj3n+K0GyfTnA1Zks3N7HUC//DeOe3sIba79vvPJ7gZK136+?=
 =?us-ascii?Q?rf6DcapFnLjh/Tdpq/8kqgaEnCnVEDXEOkWdHkJQ+3DWLREBk5Grejx1EMN8?=
 =?us-ascii?Q?FoxDgzewRz4mx8IvioUods40Ed+uqoJ+rFMXTyv8cendAkUX+SaqEao4+FM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dd89ac74-66a4-49ab-57a2-08dd8b9cba27
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 06:19:01.2668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6047

This commit does the following changes to the send email doc:

1. Added examples to use OAuth2.0 with Gmail and Outlook.
2. Improved examples to send patches using git send-email
3. Added links of credential helpers for Gmail and Outlook

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 106 ++++++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 92389036fa..af29e61299 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -509,12 +509,12 @@ include::includes/cmd-config-section-all.adoc[]
 
 include::config/sendemail.adoc[]
 
-EXAMPLES
---------
-Use gmail as the smtp server
+EXAMPLES OF SMTP SERVERS
+------------------------
+Use Gmail as the SMTP Server
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-To use 'git send-email' to send your patches through the GMail SMTP server,
-edit ~/.gitconfig to specify your account settings:
+To use 'git send-email' to send your patches through the Gmail SMTP server,
+edit '~/.gitconfig' to specify your account settings:
 
 ----
 [sendemail]
@@ -528,17 +528,97 @@ If you have multi-factor authentication set up on your Gmail account, you can
 generate an app-specific password for use with 'git send-email'. Visit
 https://security.google.com/settings/security/apppasswords to create it.
 
-Once your commits are ready to be sent to the mailing list, run the
-following commands:
+You can also use OAuth2.0 authentication with Gmail. To do this, edit your
+`~/.gitconfig` file and add `smtpAuth = OAUTHBEARER` to your account settings:
+
+----
+[sendemail]
+	smtpEncryption = tls
+	smtpServer = smtp.gmail.com
+	smtpUser = yourname@gmail.com
+	smtpServerPort = 587
+	smtpAuth = OAUTHBEARER
+----
+
+Use Microsoft Outlook as the SMTP Server
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Unlike Gmail, Microsoft Outlook no longer supports app-specific passwords.
+Therefore, OAuth2.0 authentication must be used for Outlook.
+
+Edit '~/.gitconfig' to specify your account settings for Outlook and use its
+SMTP server with 'git send-email':
+
+----
+[sendemail]
+	smtpEncryption = tls
+	smtpServer = smtp.office365.com
+	smtpUser = yourname@outlook.com
+	smtpServerPort = 587
+	smtpAuth = XOAUTH2
+----
+
+SENDING PATCHES
+---------------
+The following examples can be used to have a basic idea on how to send patches
+to a mailing list:
+
+If you want to send a single patch, run:
+
+	$ git send-email --to="mailinglist@example.org" HEAD~1
+
+You can also add `--annotate` to edit the patches before sending:
+
+	$ git send-email --annotate --to="mailinglist@example.org" HEAD~1
+
+Multiple patches can also be sent. For example, if you want to send the last 3
+commits as patches, run:
+
+	$ git send-email --to="mailinglist@example.org" HEAD~3
+
+You can also add a cover letter. It is useful especially in case of multiple
+patches. Note the use of `--annotate` here since we have to edit the cover letter
+before sending it:
+
+	$ git send-email --annotate --cover-letter --to="mailinglist@example.org" HEAD~3
+
+Versions of a patch series can also be specified. For example to send a version 2:
+
+	$ git send-email --to="mailinglist@example.org" -v2 HEAD~1
+
+You can also specify custom subject prefixes. For example, to have '[PATCH RESEND]'
+as a prefix, run:
+
+	$ git send-email --to="mailinglist@example.org" --subject-prefix='PATCH RESEND' HEAD~1
+
+You can also Cc someone like this:
+
+	$ git send-email --to="mailinglist@example.org" --cc="someone@example.com" HEAD~1
+
+Multiple `--to` can also be specified:
+
+	$ git send-email --to="list1@example.org" --to="list2@example.com" HEAD~1
+
+Similarly you can specify multiple `--cc` as well.
 
-	$ git format-patch --cover-letter -M origin/master -o outgoing/
-	$ edit outgoing/0000-*
-	$ git send-email outgoing/*
 
 The first time you run it, you will be prompted for your credentials.  Enter the
-app-specific or your regular password as appropriate.  If you have credential
-helper configured (see linkgit:git-credential[1]), the password will be saved in
-the credential store so you won't have to type it the next time.
+app-specific or your regular password as appropriate.
+
+If you have credential helper configured (see linkgit:git-credential[1]), the
+password will be saved in the credential store so you won't have to type it the
+next time.
+
+If you are using OAuth2.0 authentication, you need to use an access token in
+place of a password when prompted. Various OAuth2.0 token generators are
+available online. Community maintained credential helpers for Gmail and Outlook
+are also available:
+
+	- https://github.com/AdityaGarg8/git-credential-outlook-and-gmail[git-credential-gmail] (cross platform, dedicated helper for authenticating Gmail accounts)
+
+	- https://github.com/AdityaGarg8/git-credential-outlook-and-gmail[git-credential-outlook] (cross platform, dedicated helper for authenticating Microsoft Outlook accounts)
+
+You can also see linkgit:gitcredentials[7] for more OAuth based authentication
+helpers.
 
 Note: the following core Perl modules that may be installed with your
 distribution of Perl are required:
-- 
2.49.0

