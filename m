Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17552199FB0
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748761940; cv=fail; b=IApQFUO6b3+y7cpSBJyOes8PyFlUM/vzGMYIaDyqwQ4GVmeYur5smYFTYRPGd/JeIMqfzmz9mPS8Hdi18MVBbgtc3rRxWwqJ41Ttse+schBtPXLzG4KsN/ndQjEaXoKEQSTki0rhQK2+rcnr+Z76I0eT+bMq9ophOe8uYJRmDJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748761940; c=relaxed/simple;
	bh=JMZuiShi4kHNmBv/Nko5aoxev4bVaaf6aKNi3RMgu4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rOLMVwYeJzyUV+0ydeUw/RwNT4aetJuE4bDWG+gV7PtH8lIQch2NEDY0ncaKL/0pgktGkYgYIRnbDtsmAyKVYaQUVGQbPHVttgdP2D5SIF4k1Xig8+rXFEG/N4rNJvtKKq8NSJOl6Y2itKBNYJF1OqnMKtGoBrg77DOc3E00IsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=eWcm6k5U; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="eWcm6k5U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNvmOLDhV0f+9heQ8GhKy2mRB9gpANFwfr22PqqPyVN31Mpk20PsZDwPYgXB8SF8T56Ty6ETcQsF4JsFw/P1IxO0nmQYy0XKTZjxcPFYc+Zn456QUHnoP9px4JciETUnWcLplC7WnywXscgL/0gxA0CpcMaFD6djL2BMZhpBmPlOt1nQ+XF9jrY3uUjbKNoroXlP9MF9VcR7kbz32Qeo+oeqzbwgg/L+YI3AyhvY01gcmATv2DgWW6Gm69+ByyP+Aw+dA7QAm0NmWLIflfrwvewus7lOjpajfyLav/XD5i5xzE7/srJ0rdtJhBLn/ZkLgEEQUdX7I0FzDhzeSrE00Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adq05syiW3D6v/mdYzbGQ1NrwF1HcFCFwICytiiC2o4=;
 b=VaduhbPS8xlDdUfxStbMiG5oQL2/EZrMux1rHdva3HU8tkbH2k2kucoBxg3hiteq/dZqB0OlRc29m6/SJ1S24qORLemCFyqh8tqKTj3P/rY2HG+fdltJ+fQGNaFetxZPWy/978Id0VDqVBnNbFEuJFBy5y9rFCQnVLMYymvFivtJtzEQyRSS2PcUUUQEePS8SlErqdY2K43thPJQmemdEbHec+NNRHS3pAAv5tCe7vcN0RG7fio5qMA/93VtloPHO0DTIBGSTJYbpl00Lr+4vTypJYo/ZZ7y4e/2mcjGpfiF5MMXH8cMpbFnZTytWf9OL/c9hRwBr6bPWj9B5ag/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adq05syiW3D6v/mdYzbGQ1NrwF1HcFCFwICytiiC2o4=;
 b=eWcm6k5UJDw2CW+mSSu4Wu/sSwTbLibWZ9iQcg9a4IrhjnZz+U0GB2B90GI/Hsp/KOMy6t8dWwymmfbVljf1ciV+gzzHy6I4eiKf3CIxkbHLt5Y5Pn4hv2VBKtetafBThq8OJB+lRMwdo0EBK1TidhF/nl04C9+nHosJuSfGCKO9fx4NYyOkETwhevfsGak4uz0Llz7zyy7DmMukhrn3wvJoPM2NS8wLDCqxKOuMyzL4+mHCc4VofXwKOzwJhpyHYKNGFV8Vp98OWYBX169MIyncUYFA44FbOc2yotHlNeaQOIPDK/4Cvj4NbWzWzMi0pkTsSIaQ7js7A1kWMZZ7kA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sun, 1 Jun
 2025 07:12:10 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 07:12:10 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v10 3/9] imap-send: add PLAIN authentication method to OpenSSL
Date: Sun,  1 Jun 2025 12:40:29 +0530
Message-ID:
 <PN3PR01MB95973304BB7834B25377396EB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250601071035.2412968-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 008e31f5-23aa-45d5-8e2b-08dda0dba04e
X-MS-Exchange-SLBlob-MailProps:
	8U9+OAG/EBLERCSHXadvhc9ELuiLr8N5ggUrDJKCLnnWuwHPmGcihvgacFADHaweVtznkxwM1R3C0VIfaLmR2ha03VChPLX3uTZoW8R8fUb+v3OZ4OAtOZmu90MoxOVfKZDZ0vd1mwezxJrhgRWI2l/610UixAeODFMTctx8kPC1mQ6t/9QvGJrl3lwYHJhI1r5lnGN9lIhNfLPdIyZhq246jDdCus+/2uj657kUglT6x21RnPyibbuY1X3NtacyUNevKzwmjDXUlEp1F8LvzMJwGaNF4EcIO7hv7fo+2BZ1VOZ5jV7E1QaBtJJ5qePBHMN4ka9WvZd92EUbrENg/t0msgcfgXcAirw2euainviX4EHjWGqbq5tlTapV48zB5Z9vbmKQAFfvfDJNNVRJ1V25mRPBpbcdMSJg1gTHJ0wfcMdSmws/YawpZFhpwCkkpw3gsWcsceEoCAcdtVEoIvj/NBYRxpGz2ZIOborHg4aJEiGVmQqEAuq85qrqOjdYajH5QXuMb8DbP1fAPv0ryyWwavcbNS12khzbFDpv0w/acWNm/8OnIsua/frI2LcV32ipPnSu9SB+NNSAOV/lLa0ceUcxjuuHpR0E34J5XCZKR9riarNNV0Tb3NauCq2strVv9nx4eFcPFiTA+HtkuWARwqoTI534+TBJ/F+GikVX6N//EIXgnH58ROYDQO5k9oIHjDdbtTxc2A3eyQPiPw58pPXrxubPBIHQ1aUGPllAbdy9dGq8jhCHehzeCt18JgtBQp+9cU3dv8uzYS76V0uSQCUFg+LlzI/eoX419t9MAv3L5bdci0xNHlBR2su6/BLi3pd6FoffYNPtyKHKGg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599006|8060799009|15080799009|41001999006|19110799006|5072599009|4302099013|3412199025|440099028|12091999003|19111999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cy8GOcn1rmh56S0JRpi4LkDOZe4wFAtJ5VvWPuQW0oig//5GhY5fihLOh23e?=
 =?us-ascii?Q?Jqnljb/6oNEj+7yvMot768SzaOaelH/P8RNKsqHxgXDYyInUpYzmjmoFrUoB?=
 =?us-ascii?Q?kVwbvcxwQPkUraYgdgo9WYSzFMh40g00GPvxRI4roqYMa0HxOR7ALwqmsVPY?=
 =?us-ascii?Q?f4m3Qvj/7o0ocvMf5RCSocfOz1hEblY/gbEyWpshVMIMATll3EYhqX8vUTmg?=
 =?us-ascii?Q?1PiOpRCS7/2KAoHje0jwr9RmGyI+yRrpZYXwlVCOB6cBQHuzOJu+A+Fnfb+k?=
 =?us-ascii?Q?BW8qEEAHoRVxVknwQ5eOk0scEGwPpgtdlelGyb7NymckfSIR0s/uVaqWrdoo?=
 =?us-ascii?Q?sEX6e0QcQe1EGbXqxRY19P/K0RFYq2pqMzPSLyYlxsPezvajNNIxNd6rNdL+?=
 =?us-ascii?Q?p98W+edZxvSVXV+b14fE14XvuT14uHWVnW463VMYPsFsdvhpV2b8yCbOMJjG?=
 =?us-ascii?Q?ZHHatH4xtVR6/2USb6nl4Q3m5a81/hrfD/P1Zi8sdyWt66CTPPJsob/JNenL?=
 =?us-ascii?Q?Ma17Mwtn9sIjVR3rOwamk/OzGRfEG8jU8iDwKeRc7sDIPt47d1cp8RnnI2p7?=
 =?us-ascii?Q?juR/I3BlSqtsPgVjRQKdYF+wOfH91XkhxddowNVutEBIpU5Hbi8pxexFfq5O?=
 =?us-ascii?Q?Gn53JON1CLr5a93YJMHAiHM4W7ldpn9kGMAYgBRXEXlUmYp8+vZJYKChGb+U?=
 =?us-ascii?Q?3Mqjd6KQVBF9I8o6ORxXUJIX1i1sTUUm8y6+/XIliZO79dE06ssXR1CYAJk+?=
 =?us-ascii?Q?iOuo/ZjZzoZMngHJJwGs2Ggo4Zor8mEHU+Q+Bc09Ao1WVGF/FJVda9prSmtD?=
 =?us-ascii?Q?gZpBY0PChzEoB6/eGIXFQxOK05nEjXXd/lIxecEA6Ep4FUwto4lFhoVC8mNo?=
 =?us-ascii?Q?WiRX1dgm/CnMK/WUvpDHMmji3aewTmOmQdKC2K6KHhtzfQPyWfl//3maors/?=
 =?us-ascii?Q?NebKXypiYlGYRu06m9zRy9/NaWcgRomZtWSAPMyGcbV4nHYsgOSDNAXr1TWG?=
 =?us-ascii?Q?HAgfizlQFYI4bkWnlVffhq5R+qlERRszs0jdaw8InB9Uf8gVAx/KiFQndNtK?=
 =?us-ascii?Q?tfoPuyrHooXR0QqqO5DHqetDRGqwMW1xF8McL9pwJBFwmEOfEHVH6u8wi6Ik?=
 =?us-ascii?Q?WSJu7C66loYpSrcypDVXWSRk+BzjVf7zRsPICi6mU/3hiYiFBQnnhBP5QJIY?=
 =?us-ascii?Q?avnNXZUp8tI2JilwgI1Jg0/SW/rtkzr3scRa8fB93tWoqjc3z+rjc1FJrd5M?=
 =?us-ascii?Q?kmmMEfIg+cwVfUfng7ClcbEMC2WLXIVsSAWmMDlyOkkPFKlzkVNN8TrWmrtG?=
 =?us-ascii?Q?uBwIo+ASnmvEyIOuZSexZI7C8XSYaj4uUKUksYShkLS+M7lPdm3WcwZBtcgN?=
 =?us-ascii?Q?WQG84thzXMdakQumDeB5ZefZHX13?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgM+KjEpaoZOG2F3GNkcaCkPpx12ml9WuO0WALQPahifiSiq2YKM1kJEX9Oc?=
 =?us-ascii?Q?eir4jAxiMlKfSFIqBuug8UPY/zPJrcFtKBgS0gUQPvAYvw99STf4X27HHYAZ?=
 =?us-ascii?Q?V3JW5ChWRC9zyVtmnz7lydm0R2DPTiKSWs08EUzuCJOzicENEXlGWxa01bOM?=
 =?us-ascii?Q?kSfbKRKfVZRfParw2n1SC+Wd8KQtUn6s9MP44PN/mkHYGE2zj5KvHYRYXoHu?=
 =?us-ascii?Q?OZ7ltRQAxUgPkrmP7fzkEht42+gQ7Cr8OvOYSGPn+1K7B1I/9YgNiAPsz/CL?=
 =?us-ascii?Q?yK8rXqsFhnASkHgvGm7t4qEnfbDClEU59FoydAl0SzXeUYqROaa1/87Ih47W?=
 =?us-ascii?Q?Q89SENXGP9pa0jxds1qfhSfZPkJ40fif5j5tyEj7QWgVl1uWQa8udbHeMw1i?=
 =?us-ascii?Q?DJq7mz6eqY7LVEUop0ciD82l6Pinj5YlKTom3My3BVFVneH4TBOhiDfN+ImN?=
 =?us-ascii?Q?DPwtAdwmqgQAbndvLsGJHnJJgKK8ukuRY7FYAL+prOOjx0h89mUKc8ZE5BoG?=
 =?us-ascii?Q?bAudn9ploo8kKu816uGUBLx0DrJMgQfS1VMBnpUa01w8lkKuxZdEFbo4bSkM?=
 =?us-ascii?Q?CcmRwySknBRddsONTaWGUD2VjIe2m4X8G1M+6etMVtY9ZDlHWGGTzVxfxEzl?=
 =?us-ascii?Q?7cZ8GZbz3vVGuwTdI2RJUKBTRGYe1jKr/kUhjFu4drmt2RTfdAiwg2A61if6?=
 =?us-ascii?Q?C4dHRIyojtYhk6VaHxn7VA8Aluj3TfJnb1ffayYbWhOy+PEss78Z6emWc2Im?=
 =?us-ascii?Q?RPryLn3LSAt4b9fSjIjqm5/O94DViUrcscCWkiE4m1UWDoyg9hh3uGPcsHER?=
 =?us-ascii?Q?xm5hSRhG81UC7ugrEiGJgO1NbA0ZPUXe6OGzPJxXctbfYOzBVj0AGC4+fATj?=
 =?us-ascii?Q?Nxc6VcfWG7erIeEV/rMRcAEXCfKfmqBcYM8mn6Q6cjuvLq6ZiDtEtM4/3AhZ?=
 =?us-ascii?Q?pwWnfDf/oZfLd0hZ63DEHQiUCkkvPxE8TogoAGhk2IS9rGMi/HU/HvOQUu0B?=
 =?us-ascii?Q?i6//LFXy1SaALGJi3V8Z6+cQL9h5OIRWhFzcvQmJqNwMU8WPHgcoQ6Klt55R?=
 =?us-ascii?Q?6KLyG9kB6TowqQD1QyfCGNHxIvYfyx8L/MEV2cgZqH6/vHID5Tp7uhBBA65A?=
 =?us-ascii?Q?YOBc0r0F9W+abd1tq9SvE2Lka9CEaz19m/bBe0uptFXlBTVVwRKB4ZjnT1R0?=
 =?us-ascii?Q?U1jrCoVnsWiohYc2GZGgoKWmnEAvQjRBTHsOjBfLEVIEMOki1+r1zAaeu3s?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 008e31f5-23aa-45d5-8e2b-08dda0dba04e
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 07:12:10.6763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9108

The current implementation for PLAIN in imap-send works just fine
if using curl, but if attempted to use for OpenSSL, it is treated
as an invalid mechanism. The default implementation for OpenSSL is
IMAP LOGIN command rather than AUTH PLAIN. Since AUTH PLAIN is
still used today by many email providers in form of app passwords,
lets add an implementation that can use AUTH PLAIN if specified.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc |  4 +-
 imap-send.c                    | 81 +++++++++++++++++++++++++++++++++-
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index fef6487293..24e88228d0 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,6 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
-	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
+	option, the only supported methods are 'PLAIN', 'CRAM-MD5', 'OAUTHBEARER'
+	and 'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
 	plaintext LOGIN command.
diff --git a/imap-send.c b/imap-send.c
index 4f3a1fb5b1..bc26abd150 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,6 +139,7 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
+	AUTH_PLAIN,
 	AUTH_CRAM_MD5,
 	AUTH_OAUTHBEARER,
 	AUTH_XOAUTH2
@@ -150,6 +151,7 @@ static const char *cap_list[] = {
 	"LITERAL+",
 	"NAMESPACE",
 	"STARTTLS",
+	"AUTH=PLAIN",
 	"AUTH=CRAM-MD5",
 	"AUTH=OAUTHBEARER",
 	"AUTH=XOAUTH2",
@@ -851,6 +853,41 @@ static char hexchar(unsigned int b)
 }
 
 #define ENCODED_SIZE(n) (4 * DIV_ROUND_UP((n), 3))
+static char *plain_base64(const char *user, const char *pass)
+{
+	int user_len = strlen(user);
+	int pass_len = strlen(pass);
+	int raw_len = 1 + user_len + 1 + pass_len;
+	int b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the PLAIN string
+	 *
+	 * The username and password are combined to one string and base64 encoded.
+	 * "\0user\0pass"
+	 *
+	 * The method has been described in RFC4616.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc4616
+	 */
+	raw = xmallocz(raw_len);
+	raw[0] = '\0';
+	memcpy(raw + 1, user, user_len);
+	raw[1 + user_len] = '\0';
+	memcpy(raw + 2 + user_len, pass, pass_len);
+
+	b64 = xmallocz(ENCODED_SIZE(raw_len));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, raw_len);
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
 static char *cram(const char *challenge_64, const char *user, const char *pass)
 {
 	int i, resp_len, encoded_len, decoded_len;
@@ -953,6 +990,13 @@ static char *xoauth2_base64(const char *user, const char *access_token)
 
 #else
 
+static char *plain_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use PLAIN authenticate method "
+	    "with OpenSSL library, but its support has not been compiled in.");
+}
+
 static char *cram(const char *challenge_64 UNUSED,
 		  const char *user UNUSED,
 		  const char *pass UNUSED)
@@ -977,6 +1021,26 @@ static char *xoauth2_base64(const char *user UNUSED,
 
 #endif
 
+static int auth_plain(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = plain_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("PLAIN: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending PLAIN response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 {
 	int ret;
@@ -1209,7 +1273,22 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		if (srvc->auth_method) {
 			struct imap_cmd_cb cb;
 
-			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
+			if (!strcmp(srvc->auth_method, "PLAIN")) {
+				if (!CAP(AUTH_PLAIN)) {
+					fprintf(stderr, "You specified "
+						"PLAIN as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* PLAIN */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_plain;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE PLAIN") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE PLAIN failed\n");
+					goto bail;
+				}
+			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
 				if (!CAP(AUTH_CRAM_MD5)) {
 					fprintf(stderr, "You specified "
 						"CRAM-MD5 as authentication method, "
-- 
2.49.0.638.g67a2d115ec

