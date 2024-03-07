Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C30A12B145
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836692; cv=fail; b=WvX4p5U2THngCAb9ar032eoxXkZfQ4PrB0/WyXTwe9rW0+wTm6112yKXr4vs7jbGEQjGtD7gdtc/Sd/uRtF4yBe1+trc3uyjpc4soKRk4lSzp/FHUczj7YaiREE88s49yEw4kancTYHVH2skO/HsxmakXE4x8YlGVyX3vXNC8zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836692; c=relaxed/simple;
	bh=BCuni2UdBenmHLm1YqFppZKVaB3qdXtXLycvtCwWuaA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qn9LCq2lwSt3ZZLRfX6L+tsW8UYcZvjCVe/VqWRC5SCNCVy4fy8nnG/TTBQPgDkrH2XdSQKcoHc1xdADGFg15qb6hRQPadWZMLpaLRS1ijjzr1N7AbfB5FbTKlNOAtnOKR9lNexzvYigHvAliI4yd1SnNjIPJu4DA1/dLVjlXl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=kfRny5EG; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ojLfcPke; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="kfRny5EG";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ojLfcPke"
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427Gk9YQ002448;
	Thu, 7 Mar 2024 10:38:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=proofpoint20171006; bh=6a+zUSy6Fp8
	XqrrkGWKSAgGU+wgysfycZDBUZEHyGVI=; b=kfRny5EGbh92KWy3lF9DqQ7kT1C
	x0am9GUzCxCRKX3GuvUOtf7nZocRpQnz0uKRCFzTJM3VVJn7Wx30wiNcgSqKJQOn
	n7G1rg/RP1wR3E/ujIJYwsEBeMHaVdhMdNd0qPV35LbRt5xigtxGQYMfGN+0T6KU
	s3dJt9Odtc1YxTdut7+SBExqBZxQgEfRcwYp7CeqS4xz4iW7KCuybV5HKb/vB9OK
	U8KapTqhPQ2O4n4qSAfrsYvog2TSSqebmx+Yy4NHnfWNXy491N0JoO+C8IWXxprY
	6jjKC8MgO6kdq5nC15sJ31zRm5EF7fLylp52OZvgCimgB1nPNKXf6Kjh3Fg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3wm2hbck4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 10:37:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F9S7vIN5GVlXGPynYAjoSoGzYU7Fz1fj+ACGKAB9De+jhj4BaVEVzw7keD1euQaukOaNpqUU2B4HC4Hwsg1vGOGLbdX32fHLQIR2pKs8luGKxfc3j8Ee7XB16P+BYMFd3x8/+eswPurdp1ICLKkiaS3theARA736JVU7SkIPHcyzJzU1aBjrhU5nxnXOKXC3CE+aDEisATK7K60RM94rP7eefXbl1d4La2MSYGd3ZQc/9IobbGhlYaQTnG5GMLCWWyddmqpLghc5y8wjrSouW5XFRCSg7wu2jZEuLiPCDfuDVJHTG6Be1x0mj5FCYSu2mbFKGNkuQrOfgxZ5K/bC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a+zUSy6Fp8XqrrkGWKSAgGU+wgysfycZDBUZEHyGVI=;
 b=CuWVz7Oin1dSE15lS+F2PUZcxjBOj58fJqqXZ06Zv8FL1wwDzUPw0E6+YZx3arJI0qd7Qc9jA01Zi+wsjw03pABLgvyLgUp/EglG1h5SRSOzlkLrPmwRx3iznPdloCD57Q8PeQJDJqqqBVGztXVFjoOcMG8cwbElI3Im7XWR99hfwzqQ5DaC9PPY/cLeaA+wOUkN18Toy61yI6lm1mivVcDf6lNjIGwXrqT925efuKBj1bopKvCL0xu6CE7P9OGj1Rn9kE8yOpJGbXEj5GNmEgCy1Am7a5HYHSUK9Q0NBASRP8xrLFQGjI9xSrTMH1TFFwaFneOcfM1Kmg6vElOhCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a+zUSy6Fp8XqrrkGWKSAgGU+wgysfycZDBUZEHyGVI=;
 b=ojLfcPke8iS/KVyLxIMOG2oFL67uQ6PxhVk/H7sNS1EOgtHtk8RLc60w62qNZNPPI1pTss7p1RXnZM6zP4GhYxCpufNPt7yv0YDaE1aRuYNIpPyx8EvIEoaPGzTtnE92wrZsZsw9zYy1QsqLzOc//4+lFxKKUuzQo2BfQWqjr8hAOxHj0soTNTzCUv7fIhLB8Vq4+pwDLGHpj5gFKpmaXJwK2envfWE1FGmwJ2TkYSBnyU0h75rh2fZxJSQ75wB1l1JErCNkiLRnw6h3EPvmIf5W8WTP4ghci194YyGON/kj+3ld7qbz51tk4d8meJ8EQSHgmBvvQvQsftd/B0C4dA==
Received: from BL3PR02MB8217.namprd02.prod.outlook.com (2603:10b6:208:33b::20)
 by CH2PR02MB6821.namprd02.prod.outlook.com (2603:10b6:610:ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Thu, 7 Mar
 2024 18:37:56 +0000
Received: from BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::8c3a:4141:fb11:c684]) by BL3PR02MB8217.namprd02.prod.outlook.com
 ([fe80::8c3a:4141:fb11:c684%7]) with mapi id 15.20.7362.024; Thu, 7 Mar 2024
 18:37:56 +0000
From: Florian Schmidt <flosch@nutanix.com>
To: git@vger.kernel.org
Cc: Florian Schmidt <flosch@nutanix.com>,
        Jonathan Davies <jonathan.davies@nutanix.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>, Denton Liu <liu.denton@gmail.com>
Subject: [PATCH] wt-status: Don't find scissors line beyond buf len
Date: Thu,  7 Mar 2024 18:37:38 +0000
Message-ID: <20240307183743.219951-1-flosch@nutanix.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF000132E8.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::28) To BL3PR02MB8217.namprd02.prod.outlook.com
 (2603:10b6:208:33b::20)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR02MB8217:EE_|CH2PR02MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ddaad7-2dcb-4773-087f-08dc3ed5b49b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f9guRBzuuSp6HpLCJoVSzXbR8wjktFStEUwuit65vPCGbECNBCqBd8uRq3xHXD2wFZrvH4rnwH997PhNfyH4UFNRObW48vQYXmYc8JXsDmRsdyyxpx7lM1DL2bhV3SGBCVyMw+Gq4dNVFOkkGtiaZgPRxEx2mfYdofogTr7tm+F1/VBxN4Yt42MitZquiIHgO4WR9wF8axxBDwPgfT9GLZsP8l91UeBBaukASBcxm3WFvhZT0NbjZVPoN5YJaX7jOJN6eGxBYvVwmYH4Bp4xURy3mpElX1aedPD9624Yh88Va8yoHQt9Ct7u1HUiPU7Vi32Jhe0gTqBKbTvIfsO9Hx0Eubv6wckgFGdpJo9qyUQxkXvrIE2pKagH2RWiLNpSXvgqpvLamkjwzyOF5jWlvMFxhUFPRVN/hx2f3mpDFA0LWPyFMMyy5NtPu5qjqJRv+37BD0ImJJSTW4cz0XzM3ogJEWeBu/3ClZ20fVpsK9vFINGihRyHSrF56lKbLSmLjJ+DrnqKhcC2hUa28Z6hfd3GULj3oEfbwZuYs4hG47fRId6g4Fxp7lato6/DvdqFHNVHEze5DUlaILzZ7QW2u3KtxPWAHTmGSg+hs4CwyJG+NFSgzDxLS4ydhXkaVkumcWr85FVUjoPgUu0B/IbXDP0q2OBj2UZavD5TKcXQYS5u+8eR/MB00RR/ElzjvbVZzXIZQdCBVzuNBraLY018BmeZQ7qBFLXF8kpTj6TY7ss=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR02MB8217.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BBFrS95TOQd0A2caMEPEOsjCTutzdQNkB8msN9CbpElM4G4rDTEKx6uNIYlE?=
 =?us-ascii?Q?HGF5EfwX2otph1VoSVoOcdxPwWo0w3dV/KUdrjJGks6ZuVqnoYzXJI8P5zMG?=
 =?us-ascii?Q?TBhvbmG5Uokol7GXbM6isD5L2BPjjJpLCJQs17MH4u3i8UdDg42zuyM/RIkM?=
 =?us-ascii?Q?s7d8/M4ZWgotqzZ0MIME3xqvDV+nCiEk+iR0rToTDS1ULIo9vjAohe0Xjmi2?=
 =?us-ascii?Q?ZXZIpSDNNre8klm57A5ake2UtQZc9m/38SywIsMDVNZYHLZvn1zmculnJOlZ?=
 =?us-ascii?Q?0FfXGgrOzEdsK6NycFPog/wvzl4fkQkocz6SvFyGub0fpyk1mghK3VqgnU60?=
 =?us-ascii?Q?7PExvVTITyM/940z8oat+fuW1NkcpA+FV/lc5i5ybCT5ew/TMy/ms84JLsh0?=
 =?us-ascii?Q?DghMFftePblHf14kCkmslf1h0/B1eG3p4MPHI+ekLvAIKObqr+xVRlH84XgF?=
 =?us-ascii?Q?xZiK4bSkbPCEHEu7OveblqckQrsDNDrgPkhE3vU7yg0UZSfXI3lKI8g7PXNb?=
 =?us-ascii?Q?3ZqYA1GFjqhRZlveGQhkgjOyqT/6btSEbrE9UDY/9sFoIUD73bJv1sBO6t1K?=
 =?us-ascii?Q?l28+KyfuCRX0GbaXzcHrnjQ0gPtfl4zVIHEJUstXBZQ98c0PlACkYKwk+3Ul?=
 =?us-ascii?Q?lHZzBLZMdlBeguDU0Qdlg4u0r4yAP/TgZuG/KJZAc/kl2TIFJUg214QJBPYT?=
 =?us-ascii?Q?xGskodwsefncCOnDSzTdPNkzdQLPWtGDViOjYy3jPkglrF9fg1eHSi+DlhlK?=
 =?us-ascii?Q?Vl2THz1rXei0Ta3cNSbSS6mzULDO7JrYS/XPvL9Kvq/qDOlSohnITMsINvRx?=
 =?us-ascii?Q?EOO6efHcEyL7Op5OYG+Hap9Et3lkxx5VIJ02E/3umaFNbrAHuHqoEWOxPmK4?=
 =?us-ascii?Q?/ZWK6j+A70OLN39tpnCbn2jJYBRzANeShep8mL4zKoB9Il2zcJnTmIc//ow6?=
 =?us-ascii?Q?KHTP42tS210mgZngk+0jOnoYsJD3Py9ovYSS6TfT8gYj93L/q/MJQnNN5F5j?=
 =?us-ascii?Q?XqbOeX5/229bYwyR4sHWkooO6cyK44ozSMr9vGSOgnH4hLGqBCePPFdObJDH?=
 =?us-ascii?Q?YadWrdXQvIoV6yadcoSTT+4TkO6ckd15RVOhOlOz2rv/qQzGksfP2W9EpB+R?=
 =?us-ascii?Q?LNzfb1KMNqdCEe9BCduHgVi9uzmq6Tqetg4kREB01XuNeUsn1q3Z0JFvTt2D?=
 =?us-ascii?Q?sKe3DI2arhgPIznh/e2K2XeetpbhUIIxy459km2V+GLLQjqKb07D4ifi20Dj?=
 =?us-ascii?Q?ZEQyeeI459HSETN2OzVqQ85plnx5SP2HrFFsYucVABAScZk/Mp+0zwemF0O7?=
 =?us-ascii?Q?nOSvHv3OwJWR2WZQPaCtWTB7HFnnfJ/6vyjXnowe2Yy5sc0VaJXw1BXlRtMd?=
 =?us-ascii?Q?zopaAS9vHEAjgOF88NbnAoGFejnA9RIKhRyfLcjmmR6qLIGrkJm/9bcHDCPS?=
 =?us-ascii?Q?Dp42ENaCM4mki6iPi0tLF0qenb4kyEBurBZP/UT7kFIhbNFhqlIdIi+LQmCl?=
 =?us-ascii?Q?Q1mNXc448UcJoGJWKirB1aUT7VMJd87yj8CnpX0p4zOVX7bnipe6yduBqB64?=
 =?us-ascii?Q?AdbKRjmLHmQ7+nL1vqL8oqGBalKrRtxvkfDNZ8fWm3/4cbPubwm1E0PVG21T?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ddaad7-2dcb-4773-087f-08dc3ed5b49b
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB8217.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 18:37:55.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 035e2AO0TCwq6GFt6cpIJ/5sdzD6rp5JLnCCOAylU+SCKFB2mD/4/PQK8swPgig5IWTarpvxeo5FlNPtM3a9A9/3b13nLP2/qfow2DbXJDM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6821
X-Proofpoint-ORIG-GUID: -HltQUDlII838HHV8zSbgJH1kmOQ3NsI
X-Proofpoint-GUID: -HltQUDlII838HHV8zSbgJH1kmOQ3NsI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe

Currently, if
(a) There is a "---" divider in a commit message,
(b) At some point beyond that divider, there is a cut-line (that is,
    "# ------------------------ >8 ------------------------") in the
    commit message,
(c) the user does not explicitly set the "no-divider" option,
then "git interpret-trailers" will hang indefinitively.

This is because when (a) is true, find_end_of_log_message() will invoke
ignored_log_message_bytes() with a len that is intended to make it
ignore the part of the commit message beyond the divider. However,
ignored_log_message_bytes() calls wt_status_locate_end(), and that
function ignores the length restriction when it tries to locate the cut
line. If it manages to find one, the returned cutoff value is greater
than len. At this point, ignored_log_message_bytes() goes into an
infinite loop, because it won't advance the string parsing beyond len,
but the exit condition expects to reach cutoff.

It seems sensible to expect that wt_status_locate_end() should honour
the length parameter passed in, and doing so fixes this issue.

Signed-off-by: Florian Schmidt <flosch@nutanix.com>
Reviewed-by: Jonathan Davies <jonathan.davies@nutanix.com>
---

Side remark: Since strstr() doesn't consider len, and will always search
up to a null byte, I now wonder whether it would be safer to create a
new strbuf that only contains the len bytes we want to operate on. If
anybody ever thinks they can pass a non-null-terminated string into
wt_status_locate_end() because they already provide a len parameter,
they will not have a good time. So it's that traded off against the
slightly higher overhead of creating yet another buffer and copying a
potentially large-ish commit message around.


 t/t7513-interpret-trailers.sh | 14 ++++++++++++++
 wt-status.c                   | 13 +++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index ec9c6de114..3d3e13ccf8 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -1935,4 +1935,18 @@ test_expect_success 'suppressing --- does not disable cut-line handling' '
 	test_cmp expected actual
 '
 
+test_expect_success 'handling of --- lines in conjunction with cut-lines' '
+	echo "my-trailer: here" >expected &&
+
+	git interpret-trailers --parse >actual <<-\EOF &&
+	subject
+
+	my-trailer: here
+	---
+	# ------------------------ >8 ------------------------
+	EOF
+
+	test_cmp expected actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index b5a29083df..51a84575ed 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1089,14 +1089,19 @@ size_t wt_status_locate_end(const char *s, size_t len)
 {
 	const char *p;
 	struct strbuf pattern = STRBUF_INIT;
+	size_t result = len;
 
 	strbuf_addf(&pattern, "\n%c %s", comment_line_char, cut_line);
 	if (starts_with(s, pattern.buf + 1))
-		len = 0;
-	else if ((p = strstr(s, pattern.buf)))
-		len = p - s + 1;
+		result = 0;
+	else if ((p = strstr(s, pattern.buf))) {
+		result = p - s + 1;
+		if (result > len) {
+			result = len;
+		}
+	}
 	strbuf_release(&pattern);
-	return len;
+	return result;
 }
 
 void wt_status_append_cut_line(struct strbuf *buf)
-- 
2.42.0

