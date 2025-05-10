Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011032.outbound.protection.outlook.com [52.103.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7FBA27
	for <git@vger.kernel.org>; Sat, 10 May 2025 07:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746862723; cv=fail; b=ejdhn4AXvEOH8De3nPjFbBCnqqx6wlDiOlEcS8pVzKV9wnsQHJo/wUXsSyAqKCvgb7xwWd7vi+3B/0gdmsrya9rWPP6lMjFF1jUFKZ83EFE6U1ZtUCZqUzY/uk6qKJ5Mx1+NwQAIfzFYQIFgWBXDs+Oqz4vFWqzz2mDV6Ws1Ix0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746862723; c=relaxed/simple;
	bh=NSmBp3sI6Wz4tX9yFAwAT/FyMa4QR49xVqXuhdY/eK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NaWL9zpVwZ3FBP3kAvMqEu4rEjX3CiAhCEMkDlxCX0Cmd2SwfsV+J64dVVV75iem03AGNmUsuDOW7eV3w0uOPTfkcxC4rjyvg/2brHk/gUT/Ggb3M5s2RskWWjk84sDu5tGFEZO28fh2A/a5trT7uH5vABXhqMEQzzp7lwQeyds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=hUqKosce; arc=fail smtp.client-ip=52.103.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="hUqKosce"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cX8VtYknnyR7JwEREDMHXNLiBaSBi2j7UiELqgNQKfZLzyQY4q3uggvSin5bL7KR7CjALrhSg5U2BFUiQ0OM5A5Q69fW5Xk+32ZvqJZfhloldb5ElHxDY3yp1+MT4K5PFVcyDg/ugNWzitgO+EllyijoesIxx9QPy7K0sjDmhzG2Rx/a6plhWjoWllXClyZhuDUbLKHjHnK4uSoc+wS2QnDw3b3MkArOqJt8ipM4czNWupANuhGh4uzCPLuSreTOYeQsd5SSoP0q8p1kBfYbH5U8TjyLZyEE0JaZxANpY4Idn4lFnM9D5hRNCOsVavVXJuwmHtZGm6ayrDNJhfCHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Im5POUNCy7PN3u5kcm4kmCsLj7PpGYMBK82kue3Tv/c=;
 b=ykRnSEoeFF+s/PfqtBUmTJsA8po5GBkVrIRsMctrGLCBkzXQuQh7yYl8EwySdNbj+ofPG9phyPv4CGIy+Zr9FaUPBp5x7Xk3yLdkTfCraJii7+v7JRnbCCCkeqcKyaEZzKMj1/pxslb8xpoV+MGb8xSBPYfS1ZW6mC1wrXHpyHe/oZ2iO0ulLoJTPmoDt8TVqmGQR9TaYHYzQeErgABgAQIukt6ttKXeXgE1IEmtcUgbk6d55rlN1e+QOVnglWr0aRLBbENKLqb5ZpncENYsmfTzvxSz956mz4ua20M7dwMkkr9RI4+zjJErfwl6BnZe5xFHXUFpy6Oxk0dFRm4gzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Im5POUNCy7PN3u5kcm4kmCsLj7PpGYMBK82kue3Tv/c=;
 b=hUqKosce76qAh7NnpWicZtnuYkTxZaXeKeZ5LFZ1HUL/JmaVDh6ujRlasELk4qhv3Q/OB2mmKs5MwKc68TEq8rb4xF6OgXykhY1nRiQN3GtpErvOJVsOAKh3aWSAYX7tI9+Oh+GhaIU0t6ITCA+UEvzvlm6lcYe/rCz1ztxIe/NLgnGWNeUfeHsgNvL9Xdc9yUtzoYdITSxuAbtgGY7EGizYZmz3FRNqHrCYKoBUqwAYfL/TT05H+k4p6ENXSiFzRnNlUZbjPKWZ1KXLndM3dAhS6w5ZIxFo1U5i/VEWSPfSX8C106SvOQLdiUQOHmb/jDl2+oe6PDLvOKbBrkV9/w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB7625.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Sat, 10 May
 2025 07:38:36 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%4]) with mapi id 15.20.8722.027; Sat, 10 May 2025
 07:38:36 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2] send-email: try to get fqdn by running hostname --fqdn on Linux and macOS
Date: Sat, 10 May 2025 07:37:13 +0000
Message-ID:
 <PN3PR01MB9597BC2E1B526A11D21BAB24B895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0107.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2bb::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250510073821.3956-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: ccca5991-0fff-4768-40ea-08dd8f95ac1f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|15080799009|5072599009|461199028|41001999006|3412199025|440099028|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4hQYR8ImCCwH+1CrRhX44T6ad2IthbE1Hu1h/0zmpDTBsXYlzJgFCVtB+OYL?=
 =?us-ascii?Q?GVR8XGsrHuMCynjfdcpMVTb7LmjDsNcbtgEwRINK5Diznuc+jnoMQ/yPKTra?=
 =?us-ascii?Q?MPbcGfoxBvez7wI0sWmjd+7XOiJHv6BuSe5ZH2J7OAKpYl8WIuUymPhR4/UX?=
 =?us-ascii?Q?fhJkzQqCPG7jLaT+Y4xHdyszX/YBpb+DBnkD26+RglifzaaAYzP4jOUE2Rw5?=
 =?us-ascii?Q?Oidg9rm5XrBnA0ayRdvUULo6EltPY91E1U/xcZ67Cp2nUU/GR5ZjO2oqKo/B?=
 =?us-ascii?Q?uQidQ23TbJNQv3oBUW0Hf24RBYNdCqONJ39eYqN+8XVEZ9J48lvIeocnDNGu?=
 =?us-ascii?Q?jqKJCebs7snMKNB5+y/Q63Hu/SoVunq+eRnDyKP9o3yru/6slpuTzvPn8ldD?=
 =?us-ascii?Q?CdTetrcSEFMaPoXVUusQ+whKEjXeMlNRTn30Vd8pt7om2tDfQ8xfD8daYOaj?=
 =?us-ascii?Q?j5iqtLUkBzwIX4rAp0gfgkgdyfOVlJi9m9oWwvuSWydjx+zJQEH1YPhmZMcO?=
 =?us-ascii?Q?mV9jL5YPjOLsKK8aKEjy2tj66K4O9qAL0FJCenvdnMc6FYRspgqy8gW06b3b?=
 =?us-ascii?Q?nI+1isNzJ9G2ZQx5rys364DveIgDrthKRc9acHycEt9oshix53K5gOPEFZhM?=
 =?us-ascii?Q?f8eE38oYGnF5EBHjqpIWsbC429rDQm8AuxbagHgIR0BYdZ4z200cvJl9ZcKX?=
 =?us-ascii?Q?kzbslwSk9joYFt0H9WIbMD7GCyLIuaydqFyMatUekYIAjwH/d1fGynNz0WBu?=
 =?us-ascii?Q?AcqX19s62MCocAbQfFC5s0T5bA7YxLURjxx3gu5HNKeDlKDCNcirOH75KBdB?=
 =?us-ascii?Q?1mJ2wUzrMeMRPDGdaQrZ0EYrfOldpFSbDWVZiiCCiC15zSRLy9yUR6MY1d7t?=
 =?us-ascii?Q?+hIfQOEYZiR8Ca+pRPZJRGPrRrbEGSu24lW9YaxYiqkCmH6676YFq4+eMk9U?=
 =?us-ascii?Q?Xy0w0RRyGnz1lm2LSvjcqblkwi7MAl858jMf8HGtEN/NLyi5UR75QVgdOKkr?=
 =?us-ascii?Q?UHGCYTJJZcMwPEX33dGjOGlLNq9zcLtVkM2aM2nY3Ug5Dh4sW9OMXh8S3KvO?=
 =?us-ascii?Q?wcUP3H4M9wznOSYqDWuzJ+J3otNB9LneARCvRJ9wjJqIMeyT9UVYRwkkYBmk?=
 =?us-ascii?Q?2yBOTdLilmVr0fq00JVMOpd83EBNUT+lwDsAgB6p80dp0gKtYsdVFh1z8Dom?=
 =?us-ascii?Q?idHYQxG6QSy1+yskpifNxlMiLDKjkzCYRM5FpSjsIaZtqhZrZ3UvLbdNmJQ?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IO/afyWNt6atBSgzzo2UhtGMf0OgTnIgC8RB9YHRTgdiDc12YSk8ShJRPW6X?=
 =?us-ascii?Q?9nUdeI/E7FGSkbszAyFJRHdj3aL2zmac7oWwubN5uzfySZFqRkPLtTB3oLrn?=
 =?us-ascii?Q?QG1OrKFeG5cMMEtF6ICL2pq6vqD3Ie5o2hFwDLr0rg3YWlC+8zAF2qNtwbvH?=
 =?us-ascii?Q?etz+MKQ+WcyPlQPklWrxwUYONS7bWVF/S7S1CC8HS6jAY58IgsaXw2n/eTaE?=
 =?us-ascii?Q?DY9i9WMRXfUjpPpEpnPFVFCm7r8VNL2JZFZzzpKy05vdpUJHvXiM296S1vvb?=
 =?us-ascii?Q?Zk4KnF+/vg/TxRMuDqCysqM+j+qr+RomRefy98gwGjrlcbpa9k/qGX07HwQE?=
 =?us-ascii?Q?jhdTod0AKBNWCBkeaVKonUrlaBKV2b0jzSgFryDzoCS5gxpYrXfxytwk2CdS?=
 =?us-ascii?Q?HQWrzBm9DQ/F4XgTxmvO1vatJiheyWTdF0vqLlBBJZ31b6ZYCnYZK895m91d?=
 =?us-ascii?Q?xDeBfec3rkvfrsb+/e8Cq6hF0VfaWa9k+Qh8iYha8MDAnfNquTwzIkR8nSw2?=
 =?us-ascii?Q?46+/QnVvd2v4DU6FvA5MbM15rJe6wFgfLHwyMldeLwREOEl6tuCM/am+hIp9?=
 =?us-ascii?Q?12IoZSxpqjXW5asDjtIcd4epylYhI4Hq/1QPd1pKjG0BFl4vZoQD4OLQnITU?=
 =?us-ascii?Q?SOeZ8e2L74TCRjdYg0iz2OhlVG6idq28yUQTdlguDgDi7zI4X4z1eexSGfaM?=
 =?us-ascii?Q?ZiGvr7iRcc+TyaU9A7kJbgn1yrK4KAHTl0EXXbFActFvUtR9bdiae10ASOuz?=
 =?us-ascii?Q?cW+lDlQF3qRv04dpZN1dwN1EHgc3sddL39rtG3dx90A73yIeYAeF+FvuKbNU?=
 =?us-ascii?Q?5i3e3lWPnO6UKRyt65g6deeUfIC3LBcmoFLHWQMHfjLrObNYDKQrKT57pKXp?=
 =?us-ascii?Q?2hUMzzai96OkwGoOsaNrFRJpuiqs3e6D1MMEb/OaMl7PGsNqDi7+QtmfIkY8?=
 =?us-ascii?Q?UCYKMjZaTyqq3sJiXhgts7uu05VBLrLnPYRcP12yBYNWRxUcB8/772tfxOsB?=
 =?us-ascii?Q?Z/OrcHhgVMW6KJoV6KJKaVpw96//zvhLabT24+v/Ibd3FHnioH14uUY3Ik1d?=
 =?us-ascii?Q?UNzRiY6f60vy9pdjwkoMZCMtH02mPPXfCZ1e9GrLTnHeWsu3FN9OL4GRTYus?=
 =?us-ascii?Q?NUW9GzQ1hbyxp5TBcUP8ghB/+bE/6ZK6RHkUc76j6/sahXmYOA57C/FJul72?=
 =?us-ascii?Q?ehMgop6J9fQowSI38zWzHYTtc9/a5Wkg7+/OQUzaxwW3LyK2KpSpTgZ7aws?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ccca5991-0fff-4768-40ea-08dd8f95ac1f
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 07:38:35.9293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7625

`hostname` is a popular command available on both Linux and macOS. As
per the man-page[1], `hostname --fqdn` command returns the fully
qualified domain name (FQDN) of the system. The current Net::Domain
perl module being used in the script for the same has been quite
unrealiable in many cases. Thankfully, we now have a better check for
valid_fqdn, which does reject the invalid FQDNs given by this module
properly, but at the same time, it will result in a fallback to
'localhost.localdomain' being used. `hostname --fqdn` has been quite
reliable (probably even more reliable than the Net::Domain module) and
before falling back to 'localhost.localdomain', we should try to use it.
Interestingly, the `hostname` command is actually used by perl modules
like Net::Domain[2] and Sys::Hostname[3] to get the hostname. So, lets
give `hostname --fqdn` a chance as well!

[1]: https://man7.org/linux/man-pages/man1/hostname.1.html
[2]: https://github.com/Perl/perl5/blob/blead/cpan/libnet/lib/Net/Domain.pm#L88
[3]: https://github.com/Perl/perl5/blob/blead/ext/Sys-Hostname/Hostname.pm#L93

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
v2: Avoid chomping $domain and assigning it to $maildomain if the command fails.

 git-send-email.perl | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 55b7e00d29..511f627ba6 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1393,8 +1393,22 @@ sub maildomain_mta {
 	return $maildomain;
 }
 
+sub maildomain_hostname_command {
+	my $maildomain;
+
+	if ($^O eq 'linux' || $^O eq 'darwin') {
+		my $domain = `(hostname --fqdn) 2>/dev/null`;
+		if (!$?) {
+			chomp($domain);
+			$maildomain = $domain if valid_fqdn($domain);
+		}
+	}
+	return $maildomain;
+}
+
 sub maildomain {
-	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
+	return maildomain_net() || maildomain_mta() ||
+		maildomain_hostname_command || 'localhost.localdomain';
 }
 
 sub smtp_host_string {
-- 
2.49.0

