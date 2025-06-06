Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B19321D3E6
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240548; cv=fail; b=WkrS62Pb5KWYAMCpTZZKu3hHiCT4JZ6GizF0Nd5HN9NfdZst7WzSPhkYSDKTLDC30T6jclrf/E72FDHwaUsWkzWA/2rPil2m8adNOyOE6+fNfzyE1DRRcwXEmsnhrxRl/lr3JgZ+ykt7Y8+4/Q1uSbvFg9xRXpeDX7iXle4pZqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240548; c=relaxed/simple;
	bh=iVexQj3ZkMF18cOKy8JRTgIUKuxukEVHUmFMayp84L4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E9rvb+dqELWn9o4P6qkRIdb62/fY0MTYPuABI/w69XlQJy84Rj8f0FKVWHvSSAPKFsxg5pmnRXuJbTXeIsYYudgTJ1TA82lBxoZWoplwTj81hnLemKaDFM5WBEWeIxmWuOl4wi0gaNr3nGY1YwUhY5ski1ABJBux80FXHAiAjGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=oNZiSBPL; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="oNZiSBPL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OXdA4pRbiCJ8j52Ls6nVGvPLuel2UYMLSoUryG/DVFgFbTkahLP/ndx6BdjptaWwjGQ2SmI+ChCA/wpEwCOvKvjEquJq5B13vJ+qenzTJzy+3Zl2HUItv4gctpwdyS1kPQDwh9hjf+lgls8O2214bx8sNkgLdHQqWMwReeH6z3FUYUW/isHY8oCHWyHh9fRx+7ygPusY1+r9PXdiKN+RDlPoT7Zn4ctLUDQdLaIwwh7SAzRfq8q3/eEmByNArrzqM76zS/eJWO77tingPALc1su4ZSs2w8sno1WBDcSBay7r/yTq9uIqwRk30cJYyoZrIosgK3A9Y65oozSZHfcLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ER++bDmWJOSOP9Z9grLaV7/lOOHQYGc2CGArGUVCr34=;
 b=Uj3EE1h64ANBrcpPGr/hhj80GdOJE+q4M+ovS1y8LxYqLhDpY2f3PNSuYKYBSqUFdop2m0uVwT403Fq+kn5I1HEhcRnDkSy7K7pP8FNlwmZUgX5WTjFh1/5bAEUzsfVIC07J4iwjBBbKqOpaAzdWLi2xqDgkQKwCucvcMf34XG6Zh3mugxjVbNiyOGWFy6fNe16X4lWvJ92VeapAWvfGOZejTVNjBcgRNc9D5s161ym9JX5AVcUxH3uuFw1DZSwsVt6BACazkmicvJAHuAMKXqJk0GDePJhvknCNxuHaCOdFIQnyHJM3A3ZGluh8OqjWkOSexzUEX9dFev0RPY2KbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ER++bDmWJOSOP9Z9grLaV7/lOOHQYGc2CGArGUVCr34=;
 b=oNZiSBPLO1YEHGQssGrUcRDnriSLywLSYBrH+MCSXXwlXrCAazgncQlkjYi9Aw476lBDRy0tTFEJZzXs05L1+lz5sQt19LIVi4SWMg4dPvWCOW5/mU6m7sKIBlUQeABeu03X9n2EW2N/kz9+f4cuD8/UFb28fNkRgifVhcPhWR9uJObdKGEOzxEABWyckVfRo7dLbSUEPJCie+L26eia+/ISDWoCt6Xh5cYdVD5jSB0aouIXodLONLlcC5X/F6WA3Pk0BYuMJoq5PgPe09sHgUx7NlZFvGGHQQSPPnD3dM39M858hb7oSawxu6u0PPU282OAn1SbdZzyyvIlxQIcaQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8841.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:08:55 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 20:08:55 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v14 09/10] imap-send: display the destination mailbox when sending a message
Date: Fri,  6 Jun 2025 20:06:31 +0000
Message-ID:
 <PN3PR01MB95972B1FA7082FE85A6EAC26B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g0975df9fc0
In-Reply-To: <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250606200632.43298-10-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 5508b20e-310c-4fb3-5f69-08dda535f463
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrOwsKBlx1JOgp74JtkuEUkOcqllrRWo9Qa+9JRKL+6CihcL4LnfZX6DvR5nr4py480XXEpKRmfTGLv4GheO7CM0nmQNCF2IXqx+AkMHsem4lfyNy7/HXGo7ynNKAKBSWjLn808gifEZUZftToHhoSdX9RxTP9I68yz4DtBubH9ikMobJOcZFVO4D6tkGO8VjEgcW3WoI7AUY4eyqwXxK2zuwAG7e+sNZ/o6fbElH+rXW/MnC3fa9aiFTFR0zldsr4gy87/9knPkiJKB3nP9sj/4eJ5ecbx9FfjHg283a2gffon0ooNm5rbC7lKOp3OKmMlqmD/3AZ/l4cfghdC3Eo2+2b6mTleag5b9WIUuBMjbwtB/UckGWp89hs198YPleqZoZ7qXISpEtnx14T+kVsMlqW9BPt0evCwaWoMjW+aAqwwO48FMICEvJvIWAbIxz1HKa7510bbz5H4Qvz+wVl78GTW8VvfEoFaknn5gt6DMWOa2P3areVVXajEs6mcnFbuehB1XNPVrLDNqb6i0m2Z9Yzg9UG9R9Me0loWf7HXhrjrcsWohgcWxdOXWm03398LZoMdZSgjIdYF4GxiEwA0XUzyp/dgey2ha8LOqtezjzl/9CImqaCiPdD/lLQEh7UKg5xNFiAiYSABYX2XlDjyIpTy4Hd3CmQgTiCttyAktOXrnJZQmwJzov7dEwJ51+tigJyO0Mrp2KiBHQiUgnT0ElrCc2Q8k7uL8SUViIil5Dkr+dz4vJAmc4LmHWhoiNSI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799009|19110799006|8060799009|7092599006|56899033|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RJUO1icZf87ipYR1oWF5IkRqawwbZOSBvd4BfPEUaT2IVzsNl2rHcy1hoH87?=
 =?us-ascii?Q?YqWuU7n4hwTuIKwGUR8dGYwcSRsibyTTlwhW/h/tDjRXXStWWRdAcuxhWoJf?=
 =?us-ascii?Q?cojHHJmVUIEMDMLHTOOJHUBqTe5GZFsmBQmP3tiSmzkNw5GbXoHSEkfOJrhM?=
 =?us-ascii?Q?RqVRzW7CZ+8uN/YWu/9XVcnL1QZsWifmlECupFS8sbFAroxhM1bTFzgOELVo?=
 =?us-ascii?Q?PIZDayNhJDCiRgHNhU8OfeahNsb1jAu1Do5s3rSdElyYxVrSgd6NLCKZsN23?=
 =?us-ascii?Q?xQUc/biF6fpVEahTswwMGm4o2yHHbXdagRfyUePTQIjHqYounw3zIXPeFoRD?=
 =?us-ascii?Q?4lJcMJ2CZhgKrWm4egFuvVf6Iw1qry3r97suSotJlbPdWdyqjtYzH0btD3jo?=
 =?us-ascii?Q?dC5IfwC6AYGO1jlmnyIIxhnQJUr/+lfFgoW66smA1Wy8XEXXaQrfEtjbcHkP?=
 =?us-ascii?Q?oy/1fMQmR51pMx+5vr7Ev11Rzh/0KYyY2rCm9dQr8YmzkW2qOprthbX0qC66?=
 =?us-ascii?Q?oOzJ8M2ITkL/yfUgAauihM6e62iX1YP4HmfUDGeDXwaYWgUWzlQrSGJ5fm3L?=
 =?us-ascii?Q?subU9CpMNkLJPACoFdOuOWwff/WdrqihjL5PtzcHOKygYohRoGI1eDNxP+EB?=
 =?us-ascii?Q?DjVfgOQLCdUHqxhrRleowDDfBXBNmzPbmLi4FCLl2Eql5t5mrKkAm9baimuw?=
 =?us-ascii?Q?Sfi6zEwoN8qUCIzIcyEhK6x1uI7ppiyRUtJ2rPubTiV1160QJf8jD+EE68Fz?=
 =?us-ascii?Q?nIe9WHbICGtp5X4OHMiLAhXeneQbPuxTZXwShaoQWuwf26e1VKheUVqgbFl8?=
 =?us-ascii?Q?iKyP65ntjN+2mrp54lBeu6lLfL989866QSlkQRpnfamZI1wDQ/hxBh627Gfg?=
 =?us-ascii?Q?mMynF40vwe/uNENpRf/xxtw70BypIJxNzrVOt/txznjWXC2ddXI1unoplZx4?=
 =?us-ascii?Q?69C8ce7E+wXHKF9a8G4pPr8HPFK3y7rUtLZ8BgHQZuwiDYS1qjfrBtcHBMu6?=
 =?us-ascii?Q?81hDbIZJvAn5jVDm4pDHwg/GtypqFj/X0ZSheNKNk/6d/i3+5fSwqbZp6pGq?=
 =?us-ascii?Q?vkNbahVpdDPKzZw2zCNJm8/9TuyhpyTK8uu1eobOf9NhyhZ6nb8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CdNbI/AwBSFBjPeySjWNjlOosd0pH4qfRt802pyHqsurKgesN0bMuzu+ExEH?=
 =?us-ascii?Q?MoM58RKCgrdScCqebOX8GZRhjJ4qS4UJWzZy317bGgnSavPmoAt+NgAmLvm5?=
 =?us-ascii?Q?Qa2eRAxNk5m9X6vF3g6Hf/l0ABoZOAcww3ZTHw3v7yOszPG+oFeKw2TxikWO?=
 =?us-ascii?Q?dt6wlX4ZBk2m4PfrKf1LEkNiy1hgGsVS6qG+aSnAZZIqe089H9xkqwJbMRXn?=
 =?us-ascii?Q?dunBrVGmeQNHZEv76uUV2KpA1VcfnrGXi3fMxdqpwRw5a95YiJ6GJGSduxBR?=
 =?us-ascii?Q?Ul0RhYzr5eq4EZEX3uPE7/l9fjV2GcxPabNn9NYqXdkj/FI7hNHaOaGVJNEp?=
 =?us-ascii?Q?CyNQa2lrSmcREKTmi4uRd0jEovHluTD341NZlPqgJdFd8FLQ8ZKtL5VEvD5B?=
 =?us-ascii?Q?S0/8FHFZG0qizQjlBMm57QAYyPiIQqcuOnloZ7U061BWFR81ecAFeMwPdVCU?=
 =?us-ascii?Q?raeYqnTuOfYjxERquQPhTCwG17LtLyNqoiCbqcFFS8F0i0odF10SjHbJqikX?=
 =?us-ascii?Q?iWtvOFUk9k+0DMdZrBCmemVZrfxeyrwtjYr5CcbYjDMxUqVhHDoU1ikCLqfd?=
 =?us-ascii?Q?o00IU665c5/L/hn56bqLh7jQ/5iYtlBqcPwYz5a8oUuqnnduSFp7+huGy5DO?=
 =?us-ascii?Q?vrlsaxhhF/wHK5F7O+B5ajxy4+lDpIRaTAsEVIgqueBLJQjhR+h5Eee4Jiy1?=
 =?us-ascii?Q?IvuAEyNZb6kbC5ZU9zISAK/lfOspbF/B+wdWXklT+GQlSW6ykEMYAtZclSA/?=
 =?us-ascii?Q?M/Hd+1nNSM/DfMWvRgWAYuIl4DmA8dKSjrCXRFvtREZ3es9I4AA4xtj1DPN2?=
 =?us-ascii?Q?EvxPSC8F1F9bXGUfod1irNBA8KpepvwgdMuOsUMskBesrfaSFJQNKK032t5g?=
 =?us-ascii?Q?Jr1JrpHYRBnrWYkDDuVJTEBV52tnOPe03cwwJKsAkDhXCjB8z9ObjJHxnsKK?=
 =?us-ascii?Q?OiU8jF96pnq3WCLz9Pz+WB7ld2xL8NMApx5RbEjMhZsacQjqL/hzkqquryTH?=
 =?us-ascii?Q?mHlxtJ1F6Vk/5xR9q5uXmmoxZj5GW2aGLHMiD0hS1CUUeAIwCaQWmy0KOsB/?=
 =?us-ascii?Q?0EI7Tapq61tawKzoHxPl7gGefeZ9pD590k/4UbX94ba7eeQfpe30NiQMHvb+?=
 =?us-ascii?Q?lKzKa083Ec8dowPoCNQWsJhGx0Mj1tcp4k+od4xALXlIOKK5thtqrLJD5U9w?=
 =?us-ascii?Q?2RPzLyhjvWdSh5+NVoa9V248rpUss5DoAUmb85AgiYfmdqFUyN1G3s2YWkg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5508b20e-310c-4fb3-5f69-08dda535f463
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:08:51.0676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8841

Whenever we sent a message using the `imap-send` command, it would
display a log showing the number of messages which are to be sent.
For example:

    Sending 1 message
     100% (1/1) done

This had been made more informative by adding the name of the destination
folder as well:

    Sending 1 message to Drafts folder...
     100% (1/1) done

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index e3068ef1fe..9281112bea 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1557,7 +1557,8 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1671,7 +1672,8 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
-- 
2.49.0

