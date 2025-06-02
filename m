Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122501FF61E
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862036; cv=fail; b=E+ZkTp6apDD7XI3t4ktC8Cot0DaC6y/6VrHBXDTFL5+lHvZFw3y46qHRMALdXxKwa7ZGOAUl6UH5lRQq+S57y6V+C0iA2joqXuTX9lTyvNj6L/rA5/w7eA2PzxpbXK/4pIXbMcTq+gonJGwQncLQ0Bg4jAt/VTAK4b+mPw+1ewI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862036; c=relaxed/simple;
	bh=nr59dOoEL19RFy9ufPbKvLnjVSNLL1TvjVGC/53DLtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l/1Rj11SccePFaOSotB4jVd0pu4P893Mau0HKLzW2trmpMK7VIAwVudZX5SFKcGCg0QeC6rl/yce38UnKRXQ8nR1Ohs9pOk2B1BbTXVF/vA8uSs61Fo4oB9Qx/1g3v3XXuC/zgaynV1ZdeMqeDgTzG2HbJapAyNM/CiPbcdGmqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=NFGnoCwU; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="NFGnoCwU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Te52zLY5ihX8n/UY3x4nNO/cuI8/RpZHTVD8jjPn8WzouN9ScKaFKEkmfU9FokYQd9sRZM3AbJJi18TTfaT2RUGmse9hhUK1ov/I9aijc47U67vO7ESDUmGyA5NEahws2z9BKPhYaVbLkSJMAh2lMFyoC/JEDU6oCMYYqS8MmT737cQ9wEa8jnPDDKm2AVGiXLBIozsBaVX0GOpw8hzLuuZ7CO9h/5XN/d/1OXTOHhJkzAn7xUegHDgFyswjMMi5qDTS0kQp5JIlRle2VW/u2BAxHviEreB3AEKn1mZtC7+0B/uuq2C3569O3KC5FfGUzoCsrZYTLuOfNUynvFC3sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIR93KLhyIgWZGPMv6nDzPNe8M98BLt1NVMpsMcSvKs=;
 b=v457SLQCL6d4pHXQb8kmm+sk0eQnZM3RveUpgJhfnHABIuxqafjcpxQgBi2+aNTqmJq7bhcVo+RksS0k2i9plxmActx9gu1AUlZuRiyxprjVOZn9MRAdEbmZvpnxf0gpa83NOY9MP9wZnrpMwamwZdnjyzgvWExljvqYj7rZJgL89IWkMSy32RkZT4zhp0nvdcV7fAFI/lRRQRlB6su871cGOuz/0StYyD+m+j2uZAiotajrCuHnS+IGOC/olyIYGLGNuJj3o0PXtitxR2OayjgzvRsCRZzggs7JaYqkMcPO0DLMCLfPpJac8rMdlljh/ck6ZsDbwlPSVItbFhFjWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIR93KLhyIgWZGPMv6nDzPNe8M98BLt1NVMpsMcSvKs=;
 b=NFGnoCwUcFtip46JniYe8XBE+rUjP/8pazoP4eSZmWp7TIQbT1f0yJAfZk3B90RKzmrNrPu2yJMhwTaydfWmFU3vFD7NrYPGTHN9qPuFkFJ/L7mYISmfcNlFjkfUugC5Eib0KkkGU8So7zwlDNtnBYiIE1DbQVXsIRfweP+I41HnodtXgov6dkl+BL7wna2oxRe6NEguRz2Ba0V58X1jdM6Zj7nVcX5m0tyqdxq28doF1RjVl7Pl4qLI2boa5wFjf31G42ZhZLLqDL5msfKls3rr+u1XGR4mC3ctNGbtIXCMVexYJG24TPC479D7ImYEQY4S09hbINwXiOJZkESbuw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB8176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:00:26 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 11:00:25 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v12 02/10] imap-send: add support for OAuth2.0 authentication
Date: Mon,  2 Jun 2025 16:29:33 +0530
Message-ID:
 <PN3PR01MB9597D1C148578224A02B9773B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250602105940.75439-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e48275-6318-4a88-1e72-08dda1c4ad8f
X-MS-Exchange-SLBlob-MailProps:
	0HFyhoHfXaQB0yCf3lfkc5dN5Wk6/UFIZ3M2iI4jQlNfpv0LCTdi1X/pX/L/wtmrWb83B2Us1VkVP377tHzr6zdAKYFu2iiA9BBE/3C1Q0MFDW0/dELbIh62zcV6b3GoFwDlyr3nnuV4eRC+QRqXZM27/YBbBXg4N3SPR1bXaxvhC523SvJ7uUjC7jIMKQ5A9KA6xYYO5v1BH9NMDKuxcY0XvewSlqJqjFd0psNhR3GsCEJvSV0/jsabR7iYGrdDGHrdhr9msIl6mN03tfx4lKsxtgXdYckv40d689u2RLFn988d3CUszSM/uRwWPFO6mV1rrJgYHiPLvUWL/qJVksqMJwJDrwOjeljYLs0/RQneRHrx3V47IW7mXJxbT6V2MQ7eIlqMXtnkWLuT/nP5UF1L4X2FJLR08TEUb2hxFlAZs8L9J6bqJCbcyT5Ej/D9AiJCU+uM93NFhIqSFPCaoZnBxr5beVqwiLTcqLde0uASVpv3PS2o7Y3jgjwTT0Ht/4VbEeU6G9HGz7wxztpN1nFPMm/bLj4mvoyIU0xFNpqF/fmVn7gmzqlGM8dDbdHNhJbXmKcMhWwKMEYYZtGjwqhC21MbOnxCSHwmWxh9KQo6eGWaxBLAtsIbuKrie7imz/kyh4cb2Yt8TnfpssyWEy0GvinZOW/G+1aZ4ReIhjBLjX83fMBLTox2S23JvXWd2XSy2dT5gvUTjos30a7cBBXb/9Z5Nj5TPIy/EEEy7xIRsEJ04vdx4xGbuA4oDGRWRUBn2L+e8T5RBRbkKFpjfH07DGmwNLRpm48Ey6KglrjcMeGD6zFfNFgwqcI3fs+zP+I1uhkCyMwjS+mXLA4YuPYEw5pnLbRUb3c5U2Qyl9ncccG3PNnFTzcr18m1j+J9LrWgZeROE70=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|7092599006|8060799009|15080799009|19110799006|12121999007|5072599009|461199028|4302099013|3412199025|440099028|19111999003|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jcVAJnYbGODhP3b9nV6yuQmOjBljFOEZF4WafLgBkNCZRJWEzEXA1l6vPegm?=
 =?us-ascii?Q?AEBqO+NDuzV0f8CHJs4j2c+1Zfvi0W096i5iwPwtqyB4lgaIHUS/YSQ44r58?=
 =?us-ascii?Q?Gx2CWOeKYXJbJ4Qkh1JP99TBpm/mU8V8WsfB4EQG/bNqTx0DLSMRe6RBLyV/?=
 =?us-ascii?Q?pt7dYFK77Ct6sShmAfi3SH5gfc3PU1bAc4+VzeMI6rWADy91rDpqubXT1thr?=
 =?us-ascii?Q?AEynYqo1xHWiRRSr2SvrajoPxNbzq+9l2er9mBYYXcR3v8DXwOUpuI4NzPSV?=
 =?us-ascii?Q?tZQoxs1D4VGj30WHJK42mL/QolYyG+l2pjNiXPYE1aqE2M4PsYrDXHXoZq+L?=
 =?us-ascii?Q?u3Do0CwweQowzbyfm+DkEweUDCrEIoDqZYUazvWu6UZC1RdXfab0qjTvh681?=
 =?us-ascii?Q?vbCbltlR+evI0gsyVRb/EJcIRIjjLKdRIhTAnQWWls9SRRNhhdVDbQb1f+eX?=
 =?us-ascii?Q?fu1WOa5rvejJUZ6kD4dolnVbpGw1ziRLjCvxYlYc4r8cNsLpv3yEo80KJOzT?=
 =?us-ascii?Q?qf5R+EgBpo/OmzAaI3/9/7gr1rJ2t6MI5LGC/bNtyeWOKaTVsCBvc/0qquo6?=
 =?us-ascii?Q?czkdBOYmEk2c5z/fqkJjUy+re6FCFuFi4Z5D0tZDu0dqfPNZSLvI/EJYbJIP?=
 =?us-ascii?Q?+Vbz2J/UW+LXfKA5AGrzRzMUO9g4ngrAfoZKDe32CtGkrxUjNsOUQZbUICdA?=
 =?us-ascii?Q?w6SRxOzYSQZFEG0y+ObyxxzBH6UnbJH0Wptew8PaouQqbdzQTcjWtX1UWrLI?=
 =?us-ascii?Q?Qoczu70iDAGSmbQiYMgSYPPbMIUXbrtAM50JUvPmhhQueXsECbLEUaMSy7UR?=
 =?us-ascii?Q?wutWpBn1JkG9+CWd2YZiFldId/YHorVP8dNg4Fc2093SYHC7bsY4K2Hwpx3T?=
 =?us-ascii?Q?PTE9l9eFAvkZpSZEbGoM341iL+kb4EdeawyJyigPHyCK910y2AjrJ8JOfhZ5?=
 =?us-ascii?Q?qXv1MeLEeFn6ucfwt73FO051RWC8sYo1XLUVvCmjmKTM/g9YM1sLWXaqnxrm?=
 =?us-ascii?Q?PhGQ5uGLP7EJePweKPUxFkpS1X5+xrPptDuJObWJmyt5EkUbPuxYoEx9km50?=
 =?us-ascii?Q?EB1DC36SEE63rrcYFUluKHikvSMoUh/xflFIAwMR3hwR4jk2jmwVDuZKJvEs?=
 =?us-ascii?Q?KwnFlAFnVExej7rbyyHuaG48vNmlA3PEGdWAa4dhwshxq6p0RLV9lbKXROdu?=
 =?us-ascii?Q?JHDEtRZydqQD1ZwH5dJk/iR8z/HXZrxOGD3j6/rdhFkzFOm5fxm6+hCeKUHe?=
 =?us-ascii?Q?cLnN6pfjQp2YY/kcU5HceRh2Rs5IxvvPcwJC2wmzF+L0TWBaERVG1lWOidgi?=
 =?us-ascii?Q?+S0F8QYxKLvdV+m1jHzQV5KVTJfGp2aw0WzGCDJ3jgQuAEkk5vv3FgzM6aaQ?=
 =?us-ascii?Q?QZ7GC3A=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pSWxv+0YZSHl6/5miBSjBZ2aQQKAjQlwKGU6KJ0bQuzav+tDNNXxNgq8CdA/?=
 =?us-ascii?Q?ehKqjtJwlBxll2TLCHxDwAKxZlcc38pvxhpRefNUiKk0e7tpCVbcS4Gl4WZa?=
 =?us-ascii?Q?dtKpPYgOqKWOs2Z1UFl6lRiwms4+6Gc++DG4zcby61Q5MXS2FXU3OOtj/inM?=
 =?us-ascii?Q?X1ckweW3Uk6jL/sOu0vrqffBJuXZMZdnuG6SkmviMDKrFs3hflqCr+0G+YGy?=
 =?us-ascii?Q?4k+iRnxU3MJRdgpsuTPVSZ4zH1ukthqZZJTlpS4AzVW3rBsJS6TnVW15RyzO?=
 =?us-ascii?Q?Cwf/9/L/icAUL3v0wY5GODYwp0PR8bXjUc8pn88PuZOzWvZW6qhFURPYkhQu?=
 =?us-ascii?Q?mqrF+tLKsAv2cdXWUf6Hwfuz6GXtMI7buZDApUxJk5YU5+WXEYSaWN6kdCPM?=
 =?us-ascii?Q?a4IaaeDHi3+w14OxCHgmg8Iq+GsTcjmSZnpC9KCDgVvCi1Gjnu5H1J186jMc?=
 =?us-ascii?Q?13Pqe1CRsMceyftoDO/vD4WK7fEVoD7shVaH3YfoH7hiiBzuk2sIrR2PvKdM?=
 =?us-ascii?Q?+PNoDBIwN5g9FPERkz5kmJw1fDyKD9G7TzSKVN8uHDrRHjTpMyvaOaR15nPP?=
 =?us-ascii?Q?tkP7OXVpezZ5iqRCGf05DyXxYG/Qeyh7ky0mM0SCAop4Z2ZckTlIPRkiPBl3?=
 =?us-ascii?Q?WLNHxevYxF5pIvJFDHbWVROwedoKNttnnXotfmJghnLJyPkSoGVP2/MjLPCW?=
 =?us-ascii?Q?1pbzqUUxMVmKbDRG1iG+jJFz3WdNsYiMVyrYJdMdq8uPZGxhZEjvwaLBXfTt?=
 =?us-ascii?Q?g/JzK3bVbGRRftTicum6St6XcrK4nEY5h4BEGoVfcSJpu1HxkkjwvR3kRFTr?=
 =?us-ascii?Q?QsQWdr3vyuAh/1u34AAKuf+VU09TTQKKXI11faWirwdWI7PlK1LxMzsZobFJ?=
 =?us-ascii?Q?01mrhe/rDbDXDqaN+ICqQO5Vd/7o0hEuiKb6z1mKZvKUmqbKhIP5mDqmrfLQ?=
 =?us-ascii?Q?0eYveKvaBqjAi6w1chZKKFN/4ie2WS4WFQCE0zFRMzMy5I6mhdrx6yACT2o3?=
 =?us-ascii?Q?J/bGWh/U0eETt8lZD6SpTTgbRcNWiVhaocMq4QUxgImlRCbe5YkItoQl3n7p?=
 =?us-ascii?Q?iRX2B/joTJ3ibb4x6Lv2jmy5SvsRaWY+YTAY+H2reqVnT6kf8E8eXNlFq2jI?=
 =?us-ascii?Q?SOB4H60gxJ8DXsIRKapkTebdm88VDXhzsVMCrU3hM7Hh1dNMgn0D1S5FRSSf?=
 =?us-ascii?Q?1TbN4SOsopeXsxF8yxQMjBKJDXs+mUzPB3YSKg+o3KoO/f4aoFCAliWqZPbM?=
 =?us-ascii?Q?JLrHmFPRV8xvQxTQIj24H6Dl4u7FJ+Z+ZCIMN27ZNU6xHPOno+Py7DDl+GVi?=
 =?us-ascii?Q?WOHmtr+FXZiAyVwCd2hbCUf4?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e48275-6318-4a88-1e72-08dda1c4ad8f
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:00:25.6661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8176

OAuth2.0 is a new way of authentication supported by various email providers
these days. OAUTHBEARER and XOAUTH2 are the two most common mechanisms used
for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2], whereas
XOAUTH2 is Google's proprietary mechanism (See [3]).

[1]: https://datatracker.ietf.org/doc/html/rfc5801
[2]: https://datatracker.ietf.org/doc/html/rfc7628
[3]: https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |   5 +-
 Documentation/git-imap-send.adoc |  47 +++++++-
 imap-send.c                      | 182 +++++++++++++++++++++++++++++--
 3 files changed, 221 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 3d28f72643..29b998d5ff 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,5 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported method is 'CRAM-MD5'. If this is not set
-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
+	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
+	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
+	plaintext `LOGIN` command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 26ccf4e433..8adf0e5aac 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -102,12 +102,18 @@ Using Gmail's IMAP interface:
 
 ---------
 [imap]
-	folder = "[Gmail]/Drafts"
-	host = imaps://imap.gmail.com
-	user = user@gmail.com
-	port = 993
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.gmail.com
+    user = user@gmail.com
+    port = 993
 ---------
 
+Gmail does not allow using your regular password for `git imap-send`.
+If you have multi-factor authentication set up on your Gmail account, you
+can generate an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create
+it. Alternatively, use OAuth2.0 authentication as described below.
+
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
@@ -116,6 +122,35 @@ that the "Folder doesn't exist".
 If your Gmail account is set to another language than English, the name of the "Drafts"
 folder will be localized.
 
+If you want to use OAuth2.0 based authentication, you can specify
+`OAUTHBEARER` or `XOAUTH2` mechanism in your config. It is more secure
+than using app-specific passwords, and also does not enforce the need of
+having multi-factor authentication. You will have to use an OAuth2.0
+access token in place of your password when using this authentication.
+
+---------
+[imap]
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.gmail.com
+    user = user@gmail.com
+    port = 993
+    authmethod = OAUTHBEARER
+---------
+
+Using Outlook's IMAP interface:
+
+Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Also, it
+supports only `XOAUTH2` as the mechanism.
+
+---------
+[imap]
+    folder = "Drafts"
+    host = imaps://outlook.office365.com
+    user = user@outlook.com
+    port = 993
+    authmethod = XOAUTH2
+---------
+
 Once the commits are ready to be sent, run the following command:
 
   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
@@ -124,6 +159,10 @@ Just make sure to disable line wrapping in the email client (Gmail's web
 interface will wrap lines no matter what, so you need to use a real
 IMAP client).
 
+In case you are using OAuth2.0 authentication, it is easier to use credential
+helpers to generate tokens. Credential helpers suggested in
+linkgit:git-send-email[1] can be used for `git imap-send` as well.
+
 CAUTION
 -------
 It is still your responsibility to make sure that the email message
diff --git a/imap-send.c b/imap-send.c
index 37f94a37e8..37a8b48ea2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,7 +139,9 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
-	AUTH_CRAM_MD5
+	AUTH_CRAM_MD5,
+	AUTH_OAUTHBEARER,
+	AUTH_XOAUTH2,
 };
 
 static const char *cap_list[] = {
@@ -149,6 +151,8 @@ static const char *cap_list[] = {
 	"NAMESPACE",
 	"STARTTLS",
 	"AUTH=CRAM-MD5",
+	"AUTH=OAUTHBEARER",
+	"AUTH=XOAUTH2",
 };
 
 #define RESP_OK    0
@@ -885,6 +889,108 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	return (char *)response_64;
 }
 
+static char *oauthbearer_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the OAUTHBEARER string
+	 *
+	 * "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
+	 *
+	 * The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
+	 * * gs2-cb-flag `n` -> client does not support CB
+	 * * gs2-authzid `a=" {User} "`
+	 *
+	 * The second part are key value pairs containing host, port and auth as
+	 * described in RFC7628.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc5801
+	 * https://datatracker.ietf.org/doc/html/rfc7628
+	 */
+	raw_len = strlen(user) + strlen(access_token) + 20;
+	raw = xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
+
+	/* Base64 encode */
+	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
+static char *xoauth2_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the XOAUTH2 string
+	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
+	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
+	 */
+	raw_len = strlen(user) + strlen(access_token) + 20;
+	raw = xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "user=%s\001auth=Bearer %s\001\001", user, access_token);
+
+	/* Base64 encode */
+	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
+static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("OAUTHBEARER: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending OAUTHBEARER response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
+static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("XOAUTH2: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending XOAUTH2 response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
 #else
 
 static char *cram(const char *challenge_64 UNUSED,
@@ -895,6 +1001,9 @@ static char *cram(const char *challenge_64 UNUSED,
 	    "you have to build git-imap-send with OpenSSL library.");
 }
 
+#define auth_oauthbearer NULL
+#define auth_xoauth2 NULL
+
 #endif
 
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
@@ -1104,6 +1213,50 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
 					goto bail;
 				}
+			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
+				if (!CAP(AUTH_OAUTHBEARER)) {
+					fprintf(stderr, "You specified "
+						"OAUTHBEARER as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+
+				#ifdef NO_OPENSSL
+				fprintf(stderr, "You are trying to use OAUTHBEARER authentication mechanism "
+					"with OpenSSL library, but its support has not been compiled in.");
+				goto bail;
+				#endif
+
+				/* OAUTHBEARER */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_oauthbearer;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE OAUTHBEARER") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE OAUTHBEARER failed\n");
+					goto bail;
+				}
+			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
+				if (!CAP(AUTH_XOAUTH2)) {
+					fprintf(stderr, "You specified "
+						"XOAUTH2 as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+
+				#ifdef NO_OPENSSL
+				fprintf(stderr, "You are trying to use XOAUTH2 authentication mechanism "
+					"with OpenSSL library, but its support has not been compiled in.");
+				goto bail;
+				#endif
+
+				/* XOAUTH2 */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_xoauth2;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE XOAUTH2") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE XOAUTH2 failed\n");
+					goto bail;
+				}
 			} else {
 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
 				goto bail;
@@ -1405,7 +1558,11 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	server_fill_credential(srvc, cred);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
+
+	if (!srvc->auth_method ||
+	    strcmp(srvc->auth_method, "XOAUTH2") ||
+	    strcmp(srvc->auth_method, "OAUTHBEARER"))
+		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
 
 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
 	strbuf_addstr(&path, srvc->host);
@@ -1423,11 +1580,22 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
 
 	if (srvc->auth_method) {
-		struct strbuf auth = STRBUF_INIT;
-		strbuf_addstr(&auth, "AUTH=");
-		strbuf_addstr(&auth, srvc->auth_method);
-		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
-		strbuf_release(&auth);
+		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
+		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
+
+			/*
+			 * While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
+			 * upon debugging, it has been found that it is capable of detecting
+			 * the best option out of OAUTHBEARER and XOAUTH2.
+			 */
+			curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, srvc->pass);
+		} else {
+			struct strbuf auth = STRBUF_INIT;
+			strbuf_addstr(&auth, "AUTH=");
+			strbuf_addstr(&auth, srvc->auth_method);
+			curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
+			strbuf_release(&auth);
+		}
 	}
 
 	if (!srvc->use_ssl)
-- 
2.49.0.639.g36d50d01f0

