Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07217214225
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 11:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862046; cv=fail; b=GPMo+RrdG+PyJgB+LXQbAJUFyL2Zl86pbzNk8w/yK6vTvPsALxNGtDca34ng7lWaPtJMnrOnQLunPkz/nN24uht1b/90Bjm+gj1Sv2p0tHzkYwxa4TDPNuKTOQ0mjlimhuGGMYg5Y8UukPx4TnhoJMmMG7+Kco0OSuvDYY/AibE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862046; c=relaxed/simple;
	bh=sB8SEwQ5aSyd/Gq2Hr8J5BeRSz8W8RXo5YUcT8P7xCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ctVew5O0BHWXPpE1AmYB/IXt2AwiSU6fKoAZ0PTGrxECRNFUIazp1V297pvOngJPKZxhcmj5XCKnUB9A9Rf+FBTvMvoDiXtOZOvNEDRGYPpqyno9E+klBTSNgv0sqC5kW0KDDggS48toXFLNzwrURqE78vjSbIj+nt+0REsfU8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UTIldZy8; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UTIldZy8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoD+EOgLfoUzIiDhHxTvDsMonCNq8lsQPim4DI5yOjKD0pebQJh2M02x+YJCUx5zcnxah6/cNYvZiA/bij0YU6jHhMYEDes83ew97WuEMj43cOrfQI/oZYjH7zthahctkhZwOZwRTa8cPtCjrVzYMjNases0maeoBHbyzDU5jQo/1aIl1BYyw6R9V+DzOeaSE181Z9zqIJBn3uiNcWcyWE6VSFgL//IT6uAO9xlhXOpty9FHOZR9nm1ynaDDXu0DYAGGnCxKGeWBzL9LE1DEYaXj4dao4C6toDs6i2I993lqzd0Z6l+k35ABK4/t5RnDtJRWCjs/sjd41wSqIVJ4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAdsuQ1I0vKktwb6p3oV/4vc7SJrUAZ/vkNNwQYcPS8=;
 b=t+vA9NHSmanfJLNxiqySw5tJdY4ooGRMM8TteesTK1v7VLSlW83kZLwZPEazaKErTqbYidDesj0iD7S3X0iyxzXL5oXVCIX+82w5Hi7WudCgx3O+3hjgd3rCRiVXxsPbViE2ojrEJ3BMiVBufN1FNZ4vwkrYozGpySP6vBxWBgzOlYT1O17e+OHGsqFibm5txLgMkwp5BODD+qr0uOHtA3AAz8FSUvJLp4sQEO2OA+lhrdEV5ZkhhvICrp6MQxJ7nzankMYSFEmdcKTHPBBA050wlVNZVhvTDRjJzkAFRrUhXCYfHBTcmqyILg8qACgQKFTa1bOq0VmW4xHWZDytGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAdsuQ1I0vKktwb6p3oV/4vc7SJrUAZ/vkNNwQYcPS8=;
 b=UTIldZy8CIXI8nN5tQcuK8+Na4fyAm8Fs3oeJGNg45oJNwRR2g78BHOABzsRtDZ4374vadP4EyYJ6OB4OT9UwgqVROvj021e5bd3XrMf/oWWwY+k1J7quGsxeJ7OVl8Ce2TQYaRXg9nrsumM7cnwjCcBzRXDZ9/o1U/LXX/xOhBmYag3RgFdR7v2ITLumhMHVPL9l1HSE16zOVwv1ZUZ5rVoXaAQIPyIYU71GEBIxlc/WgifU1iHOZ3Es0Qn3EDj9lDoU2qixfTjKVtkXBPU1PQdKWiBJoMHs9+cZfwI/N5rhLm1FgO74BO0In5scOZn2Z0bPcN8ZkWtZS42PXVUTw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB8176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:00:32 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 11:00:32 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v12 10/10] imap-send: add ability to list the available folders
Date: Mon,  2 Jun 2025 16:29:41 +0530
Message-ID:
 <PN3PR01MB95973C7522A3E9EF20A2DACAB862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250602105940.75439-12-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: a835543f-c7f4-4f1f-1162-08dda1c4b1b5
X-MS-Exchange-SLBlob-MailProps:
	+b2+gf+2pHTCneSIcPJPlYaT7iOJWPDao+hHtLqqQPkZsGwz6abp2B92Gw/nN2knOm4zuOLV9JZfcBBnmkKq3lh7Y3Aps/iBli89p3NCxSDLy2EEfvJrHqUCWAsqLE0PQAEyrw4aeqftbYXjLIlMPudKGn1O6RAx9qZr+F4v/f2GAJ9hxbjtz+wWG7ZomofzoVNDpJDXArS8SZlpyLGqPdPzHiauHNWBiiKdx+OLAsIVQT7Zn82HnrEqdl1zjSsVAmJnCexmxQjMaIk+yR3sa3lDc7UUxyzyyuncQR2SGRMgQsmMetS08IfMbwnNIPZQq5M6tMXGKXdMyWhEZfyTKxIEAloShuX/CfUwMCA/wntLx3dGwBcc9wHLXTKAyib4hoR2VOi3sdUIrzCiyponlYy5C7HluEIIEk/rIEjV25sn0Bx786Zwtf4jLjzDRok61Zjrr+mhgv0sGEX13eWBnkNFJUY8nFLL/aehWqrd1y3UcKALqzNvk4wMw3deK1eTPoW88WoHzBoXp3EUuk+qqamU7/BjVHfDJwOoAgKoA7IuQ+6wFqTQf6TNiMD/QxmNS6E2eA+RfePlM2AsUUtopVQIkvHCWVapnlKps4tVSQr90vnMItg+4S0lnwj+EkpguxXQYgSEiSldHETDFxz2sff25WuNLwN7sz1mYgxnw1LmmpBvJ/kPY2s7DcGnpqWPkhcvb3R1OGCEJcMmrhaZnY9OXWbYHbBqr6f+phLaFgwesFeu1aZHoJKGrgnBnpTyM5YBiYWf8+ZN7+BuhI8KrOBZCBdchJq4Gbsq+YbqS/TZ1mH+cGdO6x50NwwsnXt9xVkSktE0OgiY0vHLe8GvT1RN2TYJ0vLtXMU0mFU+jRt5JGuSoUMtug==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|7092599006|8060799009|15080799009|19110799006|12121999007|5072599009|461199028|4302099013|3412199025|440099028|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VK5VKpumfLI+v06zz/6NlLoSxOzjDKk8Mb99BTPHnGre6MVPSnR54KXVL0NV?=
 =?us-ascii?Q?B/LFsJhgKLJB0ipZ3bvoVnyUrywTU0jt6kNu/uttVsPyW6E3Q20pjzARohrd?=
 =?us-ascii?Q?gj0vf23tB987fKeeTRj1EqoPBMrsEUBBPLSzoXS5vHgGHb+Gw5TDAjRYQ9Qn?=
 =?us-ascii?Q?aHjSIzN8MZpnHeNSA4FD9e8ct4aTsRqBJ8hIUxahAHHW96sMcSF9N3sFO7LY?=
 =?us-ascii?Q?Bq7ZDrYvBAZqp0SN3ANGPWK+opbNCAl1Jio04avCgxdNYYYT70YfVuMnWiOI?=
 =?us-ascii?Q?JoXOsDRCF3rtwJSBDO4CPedKaW55UXlmuy2xegyBaq86sbf7AMCUw/tcUIRh?=
 =?us-ascii?Q?0tOx/RslZ9H6CbjaU+o1ZYZdS96Sc+/a+VGOmJmSXOSUQdMwkcQFfkBnvciE?=
 =?us-ascii?Q?4f3tHjQu9HOjm8r5TTSzSMKmTP5kAi1l7OT//a6uT1Sz8CRhXGQf6pDJEX6F?=
 =?us-ascii?Q?0V83OQIJVMPEjg9MPRnsdrOT/M4Gcw01Zi8MtsNunWaWs69dT0ZALfmI+tPD?=
 =?us-ascii?Q?okq60vv28tlqkpJ14EmBHfuS25GuYx8n+6qpZ89BYMT83NTqPqYvt0OPbtxK?=
 =?us-ascii?Q?kQpfHvRDtTpl1v80gpueKJMKORdYlTi4tFMUIyc7nEyYsUeXanJpWEj/k2KF?=
 =?us-ascii?Q?4iKaVV9RcyPHanRbtCUEHJLh1dlzyoNoRUrTpRXqUyZP8/igMOCLkjhLXtCH?=
 =?us-ascii?Q?SldCN5Yhhivpcl565oZ7J9vESgpqBHXj5r22TyWk7GtXnpNzLVujReJOe+qU?=
 =?us-ascii?Q?Vfa23uDu6jdeshjMByLdkRgqs5A09jPf//Tx8y1Z2qqaogGYG53+ESjStraI?=
 =?us-ascii?Q?7E1lTrX3/159+Wop6If8XeH5XjweJu7UQBfr/jhfMRp0ROiYPLe+6bvsWZs4?=
 =?us-ascii?Q?v44iTLUU5uf50YjHvBfvVZDLqzg2zfa7eavX+2uqNcLjzwTeNo6GzKlEBVX4?=
 =?us-ascii?Q?L74UEVsKBG/mEv0Cb9kr/94GjFfTWDq5ICAaL0GT4kAxcXD/kBm2gp4jhMgs?=
 =?us-ascii?Q?4YXsMRXwLZxLyowdmQj/FWYrLzGbb3laF+9ra3p8d1MxGNQXjBod3yvgc91H?=
 =?us-ascii?Q?hXvkDxeHFab1dVXVJ/Kp+YGCorxZR9W+dTxJB8R2MFhdIwGVFWw3iDWojP2f?=
 =?us-ascii?Q?KGkN869E0xLOG8B2xHJ9uZP/5briF6T8PzGQ5TYFigWxR0UxiVSLQfzLZRT2?=
 =?us-ascii?Q?38NhEY45xF9tSLsyg3Bzh3VCKhl4qdIrGzjzohmC+a+ORLjP5tC4UZehJPct?=
 =?us-ascii?Q?EgA3i+7UJa8WVYP507lh5rmUQ3sZbEDeU/lXsFJJ+FkhJ4FcnKqqr+a66inB?=
 =?us-ascii?Q?znS3l2f8fvu9faS9x+oZxvYWZZZUF3NXgzFbCt1yubGruw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gKIaxPuTTkZDsUVO6Dc+ttKeF3lf8p2jtt/NB4KQTVxVW0uqvTyvbLVT70VH?=
 =?us-ascii?Q?OFbL+iFMpSP/Rg/MCdZ3o3Rp+FarmpJQOnYb6RkWss4r9vHFYmDcTwWb0K4/?=
 =?us-ascii?Q?PxUl2Mq3kEvppnnE5hNLT8SFh9MekxcjbElK0PdhnCX3In7y/2cVeojJsi6a?=
 =?us-ascii?Q?vK1t27XsgVNt3uJfmq54hCcSjmOS4GsPMjDcTj3Sok+wEqF07d5huWkpgJr4?=
 =?us-ascii?Q?9qMKMqWDNHImi4OxCDkaVFLhSzEMGt9SWKlF64bvyVCMqmWL9HD5hmGITkJ6?=
 =?us-ascii?Q?5f5olCsuhUuruOgGITGj5kQ86IwwuXJ1kNOsocW9j08UyK54d+Hiw1dQRRpW?=
 =?us-ascii?Q?hySnP0/O9wzkOvWOsRRyI6L5tuQt/gQFbPC1/l+WeUsDr65xw1DJztWNGYyI?=
 =?us-ascii?Q?A6brGYZRR3E7JVZz24Hl9+ZT5FsXyQGWNKcQhQVHR3dnnIJTwDfTEISKUpx6?=
 =?us-ascii?Q?DqVQR00YhBeRIA8I3j0sYQRDRzPSusIhDLlubX34qaRcYTrU+n6i7pgb1sDn?=
 =?us-ascii?Q?pMNtW6DJRV7sktQF6XpZ2+Zx1WyqqWL/N1lJlIBAWVzNHABvsxlV0zlT4EEe?=
 =?us-ascii?Q?ApVBkqkug/ZvHVADk7KyvxxgKzGq3MlvQThL6Oo4GR8YCGok57Rv/cPdJcg3?=
 =?us-ascii?Q?Q0vqX0InHoRxH1YmyMvJGaXbvv9VwpmJBAY6tMBmrEDh1sG8BLzzMEtVD8rv?=
 =?us-ascii?Q?GWZCnsSIlFS5bouUyAoGaIHjqCGS5slXeXLPJa5p5rG3d6mtyGp2UrSSwuhT?=
 =?us-ascii?Q?yxAqTuJmXyfZCqaZ6aTC14bGZhjP6+KPCBD2paVx1v7RqXPSIfBrK9nhkoD8?=
 =?us-ascii?Q?0qkYAMMVvq977NIDFB5H6sJ7TBYbC1ldbzGiQ4VDb+pCBRXQbLD3vaVupxmu?=
 =?us-ascii?Q?sDUS61F/guQCQsYEenlfG4MOFT4i28uoUATzoys2O3kV/3rgKcAFU9J2t+y0?=
 =?us-ascii?Q?2na+Ua8ngNRrD1rOLjIz+FdxVWelUFPNvDXbLMx0dDJvOQUGhz+fpFGmfDZA?=
 =?us-ascii?Q?0ITAYYvZz2UJ+1nHWcFgROPIdnnrLqZSgLgTqvm9iHfLwxY8IQmxePTDcp/g?=
 =?us-ascii?Q?TrthFiHDp6PO8UUHXbESnDzEM9q9q2vgffhQikQrim0o845YaOL/BaQ/5JDG?=
 =?us-ascii?Q?veryjOFa+85c7Ts2cvPF7iaK+uD9hn8fQMwVzWYlyUXmu+AV1FWgUO5OYy8F?=
 =?us-ascii?Q?0CIMbUl3fiL8nHu21gtKbM82o6GcztrdzOBgYXNPlMvLMohVFhIKHH/gLJyC?=
 =?us-ascii?Q?emi+37kijDXohAGjsrKZHeEvvwPPMTZgsdLx6R2pQ8g5pO3Hf0wy5TO7+u8O?=
 =?us-ascii?Q?eULbhhwJ75d2Ijs6Pt8S7OxB?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a835543f-c7f4-4f1f-1162-08dda1c4b1b5
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:00:32.6652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8176

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
index 39a42e6bc8..f6049222fd 100644
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
@@ -1626,6 +1632,26 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
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
@@ -1654,11 +1680,13 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
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
@@ -1689,10 +1717,6 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
 
-	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
-
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(curl);
@@ -1711,6 +1735,10 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	struct credential cred = CREDENTIAL_INIT;
 
 	curl = setup_curl(server, &cred);
+
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
+
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
 	fprintf(stderr, "Sending %d message%s to %s folder...\n",
@@ -1757,6 +1785,31 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
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
@@ -1797,11 +1850,6 @@ int cmd_main(int argc, const char **argv)
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
@@ -1811,6 +1859,24 @@ int cmd_main(int argc, const char **argv)
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
2.49.0.639.g36d50d01f0

