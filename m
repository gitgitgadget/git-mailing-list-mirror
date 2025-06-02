Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010000.outbound.protection.outlook.com [52.103.68.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659761FF61E
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862040; cv=fail; b=f+HZ6/z7syQzGxRwcIsMmGVcMvmYAkyjJvxwsEagTVVh6wV6oJNqMuJO7NwRK+52rJ9AiuGx3VMxcye8KKJioRNwXtYr2Y7xKTcNR53B/yjbzR+SYBhibGbH6iICHSVNESyTKVSnQQZX5Hc/MtX4IEANBuOrb4GesdY5Yf3eJ/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862040; c=relaxed/simple;
	bh=AXncUTnd97XeG4ZGcTTtHSd4lEvpLTo83TGzR6HaV+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jgw4UIVbD3q18XVvltRu3MAyP3T9SKMylyFq1fFD/yqpohKG/VtsH6f9U/7pGeN+Ic5ByCbpWkna5SqnC7zIhr0GP0pT+Ds/Q1vf5trfA9t+RtoVt2+ZOcyS+ihMdD3/e1z+PljOo5raY4I0Cte5g67KonLg94x+PIPJawRF2hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=oRuGGpOC; arc=fail smtp.client-ip=52.103.68.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="oRuGGpOC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J17lUipAzUbHerFSfd5KEtgP+x7qBG7lLS/JrWd8BuUHg+0ZWoAfSFBWL0tOlrAemEwFqO7iLWCdB81IPWQsR7rFGeZv4Qln/6hECvxnJ5TTaBDP3fTTY8A2xOy3uqzrqqQ8ynTPCEjbnUzvu5ZLVejFJs2YBlMviuJx0hppe1VWvi+LNbK7hvXuj/6dTj47OJmO7g0HpbsxbnkE+TnRbefKdpqL7yr1xRAbO6Ynu4iYJI7sxyZTw1yizHayfkR13rSenHV/oOYnJz1W0jBpHlsmiznDGuU/q4aHB1cgzM0KNI5pOovej2ZfKoHZ0ViiQrinw7zYLw2pDr7sWYVs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bd/kdir2hTL3KoqaxMkapMoSwfUXr3Q8Lct+5U0sGOU=;
 b=uzJrGE2kIPXaVpt6YafnEiXCKHt4SmeFn30/5WV+qMJjmDbyoAPYRDWHjcQIqc+exMyrRKiZeojuBAIhsyS0jojQPlIdqaQCyhLfxovohXJZTRohQZH2t0DSmSGC39gr+JEPmdge2+2H5ucwu9V2K0qhxV2+JiHquItl202S28v0FK+3uy4zRKB7gl9o1kAmB+ml9B2+ojRBehHIS90i1BkGE1kNgWD8ItXxMR7+JZPDlRiOceme5ENVJ+XNLUCm/evnZKfLRVfgSUmXfHnLAW2yezQT+PCs/8RwMfEqaPuTeN9XZy4oh+jS/SOh5naq8xd084QUxJhdB/Tjr33N2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bd/kdir2hTL3KoqaxMkapMoSwfUXr3Q8Lct+5U0sGOU=;
 b=oRuGGpOC3stIVtX1UHbj6WfqVLBZ94FHpt3TrEZ5aqlTrb3SYCmczQZ/24vsyWIIV4cnOE7ZuyxTbTVad2J37oQDR+569Pv3OxKnheOQhhB3CgRQ68tr+s/qDSlGdFIr2u3zxUbqNsiS5GOYF+v4GPuT4Oo3jfMxB81S1h+0xF1TEH/KKTTzW3J4p/g5A70TGLamEJCOBc5V2ftgdwaHt6Kpgvg/77ol2btM3w3/nwyHh795vfI0pjYf6UrlrysSgwWXiXTZIvTjGzZh8M/0S61SjhECxfbIhueSQhNUirRR+x+ZgVaX/k/CzbvonIfILGgSdS6vWe4j2LgRLleRVQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB8176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:00:26 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 11:00:26 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v12 03/10] imap-send: add PLAIN authentication method to OpenSSL
Date: Mon,  2 Jun 2025 16:29:34 +0530
Message-ID:
 <PN3PR01MB95977FE5E93334FA30C704EBB862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250602105940.75439-5-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: d1419a79-083d-4f53-e263-08dda1c4ae09
X-MS-Exchange-SLBlob-MailProps:
	8U9+OAG/EBJNszHrPNOoN+ihv91wetF3bSrkRIWm4acAqIrRQXeV6J/fXZ8ZlJqjkpwfR2In0HwKfvzt/y9iKm1Hfath4ePvd8aeStt2zGF2y8yCfMgocIYm/eZYUUWlPdkvjJ879xiUzkCXB1KcQY0XW9ACtFcPsSouRiW9E0cP8JUV6+pEU15R9suyXvsOVYcpSa4G2FmbLXolW9uU+5j6i3YKg8G9jrxPOhV5nTEfopwrZuV15Ggr25Q3g0EZY9tX0M/LNaz8qrNcYvsrVoRnpMTCfw/EuX+3xOxotqiwCEZoUlcHtX3uIGBY4sNIXiKMI5x5LJBTWIoEnSGLW3MVkzw18JPdLAaR/3pkqFFcRKSDDMdN9zL2JuqbQ6oetHLTjQhwVHh7CU26CXHAtofItPzMrISDqrzzlRB3cI6Iq3r5zW147FwKU0zCUR/NNVnf1aOxND7/mLzEF8vDezEL6sjbOYo6fyqRaFLuEnndTcJclkm68FeVQpxgy1IpZCO6KZVUvy/yCns6ZEC1hCfiALYZt2QpjgFNjhiIdj0+O8aaVtEngqJvOQMI1CUITwFUasgnniGy7wX1BMH7yh02zeIP+Dhb15SJk29GSHhSFHTiiNIytpE8pE7gNgjZmkTPTfZkUVF1R6+mbT1kH1OjA+d+du3p9NSdfOUyybX5lz5gi2G2RcD5LL+EJTZU6uMcTiyI8X8D/gFZpq/MQ3wZYawtUSj5o3iDa3D0BS6wl6HvEed0bS7IgHOiuNjA2QbiT/b5HEjknvO2F45BqTHg5MIu5jW72RBEsqDQ5Wn3IJhyYXj0pM1jvcaZLoE9P9mIL47dwvdy16TBnm3dIg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|7092599006|8060799009|15080799009|19110799006|5072599009|461199028|4302099013|3412199025|440099028|19111999003|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ykj+u7iVujh9D9b5Yn3h+ZIPnQd1sWzybDdGrx+vAjG7tF5FumdSQMZylFjB?=
 =?us-ascii?Q?2H+esnvHP6RINRd9yIVnED8AaZbOgxAx85loZpHKll+o6w9iD6Lpbc8xZVQ/?=
 =?us-ascii?Q?DWkHsAWxVRP2HeUO3AKTPQLGzeEBYjjDYrLzpP8b/1EtBvMr7wYNkhlXr0Ck?=
 =?us-ascii?Q?SbsNsw2ujsP+Dm0aMASnyHA52o0q30Iv7YbCe3lscG3X3p2QHW7vwIh4Xmq6?=
 =?us-ascii?Q?LJZQIxbR/MuuGuswrbSVGivnRaVyO6AsTCtDH2PhxpJEcjelcyd53qp+/+4y?=
 =?us-ascii?Q?uLTc9uGYxp+MpFiW8zhri5w89Y6fSBClp6xvSYKBVep38F9wIcDIOoutlW1i?=
 =?us-ascii?Q?+pdVEsBVGMH5zOYWePcsXukmMHAiXvkCXCzRjmMYc8uaEUj1FzkLPRBx20w1?=
 =?us-ascii?Q?TTDBOuL3aTP6cJwVWC5I4c1a7uVvzoFASN4bM3e2ezLPbrC5UEb7UHGZdom9?=
 =?us-ascii?Q?cWkfc3ZQRkEO4NSb7Q4htPjhemTRDaIXzodjXgaL4et6TcE2qGcXGn+bAHAV?=
 =?us-ascii?Q?ldc8azQvptehLQaLF/s9I2NUDm4Fe+SJ95zsxgP+hhfq5sZnccEU0SggSXkk?=
 =?us-ascii?Q?OVHkiTio0u0rBQJ53veOb8OjZauRPd1qUgiv+e0nUNqQd1waSRnVxoxe0hAQ?=
 =?us-ascii?Q?DVkMBpgB/uWXZX0AAu2CVz2Jj8Qlxsx02tBCQi4Gn3KXrhONeUUQ0kg2F8V6?=
 =?us-ascii?Q?6Urjw6kURl8aq5O94UXSlN5K4u3WZ2yQDXB70YooZ7qaBOb74WsniYUwM8vh?=
 =?us-ascii?Q?qws1IhZBqNw/UPKaEy30LkYHTdyqu6w+1jj91VxDVJblGd21hTNwy8YyUCp0?=
 =?us-ascii?Q?DABgMtc02gbZw6l1ZslssA1G83EjGGgTy3Ng/LYr0rzY6qCMHzCS1nzq+yeE?=
 =?us-ascii?Q?RhiE5vPYh+3AfeQ+Bx22+r2PUdU/IfV3MQ6wcLrn8fV0RoVLKcPwQsnZ2zsf?=
 =?us-ascii?Q?ZMmTJ4ghfcVNbIq93VwisJS4586wkZpdHMji6en2TMLEKFecitB2tTztS/Cj?=
 =?us-ascii?Q?xaKYj7P/083punaFQNrpnPeiqClb3LSPeSjiNRBJ1MgOaBmXbHWr0ycZ7PKz?=
 =?us-ascii?Q?3iECb8FT2fZwZk9pD9O0V5EnmBMia5d82uHBuI9/jdyEYb1zGosNMl8DvnRY?=
 =?us-ascii?Q?W24no7gDhqvFeggXtS5UeRUd+2VvqV4pG1UaimQS0HUvVszX4+aC2DmsIIdl?=
 =?us-ascii?Q?x3p+n7gRbk9yzBB014ZlY5gddY2uweD5dgQZ7hNdlWDgWiPi/6w9DV9m2Oyb?=
 =?us-ascii?Q?HoPosiLwb8aV2KGSOLSxyDQkki5cYjZuOy5lm9Ntv25J+v2qtIa3spzSU0mU?=
 =?us-ascii?Q?aiY3Y2k+Sock2TVpbeYagi2xkaaawPeB5gJXytpI3W10zjOd3z00ItHuWjnx?=
 =?us-ascii?Q?8KN17XdzojKYf6weK2s7CRLjTBaY?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q+FPe1YXHnaWjO2WJ8Ct7bvq0mjUybR9hJi2aWtpvGH5LBAHfYvcLDtZKVcJ?=
 =?us-ascii?Q?a/OTZ8ZNWCgtTUvvpD/yc2AS+QgeIL5876lc/Pa8Dcwj2sms1PF4/q56XL0N?=
 =?us-ascii?Q?VAEVOJ6qWqsx4bMh+mZf6umRt60uIAeYj6rBnwEjmQTuo/N7T98BGVZvpkLM?=
 =?us-ascii?Q?5D1M0yq9AG6fAXEvkfrwiG+cinmLH0lcF0AtyRClVtxYwiTfYdmFUinnuPEY?=
 =?us-ascii?Q?lh4xhFEZUzA4l9Fw8I9qT517NAwPX4BDLHqUSgNT3Y58zdnmqXBGpNALOc28?=
 =?us-ascii?Q?I84D3l75uRxSR7WMU6/t1pMgJXLqE2iklbaLD+v7kdahYgtXSxyOXKJCTTCt?=
 =?us-ascii?Q?c/PvlTXKKlcfsvkUW/WFVCZMz5kLv5gX9iTubEWxl7CQLRl07KmzumMnIpub?=
 =?us-ascii?Q?D1ykw0AUkKCGb+TOCTcuOEVzletVPOccvh40xcDKDd4eMI2qdfBJLgWrEFfQ?=
 =?us-ascii?Q?eeLHfhgaWPequY87al1KqG0B5t9JDSjFOJUlrqT/b1MdEhuynfpSyni961a0?=
 =?us-ascii?Q?sNNL1MQRlf37nUnJgG3A8BmybCJU00QzuidWItojE7xmNpFRbB6hXATdoiqn?=
 =?us-ascii?Q?S21yt4isKSFiKM5Y8E+bvDKYX3BDzW+psHEoE3jgJgaimxc2zaHl9rIeiBZo?=
 =?us-ascii?Q?wVr6604OO2IMfl+Gt/qPUXXkMwKxXylVo44QpqDoiOcgx/E8JYhmfO9pwamO?=
 =?us-ascii?Q?Bpkaq05Qlkc3EergBTdKG9cDVXXQZo0rm+8wb4lKrjXNNv7ZlM6Ll3mOPzxZ?=
 =?us-ascii?Q?Ooig8FsF+iuklFwdZnf2I0A7C3Fl4q6jESW9OUJp6n9+RHAl1Gr3I8JR3QjK?=
 =?us-ascii?Q?kdJK9ULmxqqu3TbNEF+/24Ok9eKjVIGOVfv8tdZ9lk+08DqbJcdlBReoe1Gq?=
 =?us-ascii?Q?GhAfoEHwzoeu90JqdSqBtWxT2iAz11DMiEZNlUtaEda2ihwXNH5FgJB0gjzQ?=
 =?us-ascii?Q?TwegjgvuwXOkt8POhHUeoFkiXeiZ4YaIDLd5p36KexIH8oTbU4w9LZiYAV+N?=
 =?us-ascii?Q?mWIdrnkBlNWGtbu31F0NGavTi4XJW2c7npjetPKt2bjuS77Jv4omxNrjs4eT?=
 =?us-ascii?Q?z5KgiGcr1Rkb7m8CHIrZYGnIvODVGdEWtVMcMIhj4GnOhXFb/9ZUhgb82P1B?=
 =?us-ascii?Q?TZ90svkvMmm7Z5b8vYAabuMmV/6MGsE06l/3XkOt1TeUzk9tk+D8dHyBhiW+?=
 =?us-ascii?Q?ZtQpv1mX0ErOn2oPtlsvgIlEZecFz0N+iWuoXYY3USIHtVRbtNLMa/tiRurw?=
 =?us-ascii?Q?9Mv3OjhaWqmnvbZJREBi836XA3UfW/b3VfvgKhI14MY8xcB/IZL4ocvHKyyP?=
 =?us-ascii?Q?+i+UQDQTGaCWUk21NH7weB/N?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d1419a79-083d-4f53-e263-08dda1c4ae09
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:00:26.4671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8176

The current implementation for PLAIN in imap-send works just fine
if using curl, but if attempted to use for OpenSSL, it is treated
as an invalid mechanism. The default implementation for OpenSSL is
IMAP LOGIN command rather than AUTH PLAIN. Since AUTH PLAIN is
still used today by many email providers in form of app passwords,
lets add an implementation that can use AUTH PLAIN if specified.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc |  4 +-
 imap-send.c                    | 82 +++++++++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 29b998d5ff..7c8b2dcce4 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,6 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
-	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
+	option, the only supported methods are `PLAIN`, `CRAM-MD5`, `OAUTHBEARER`
+	and `XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
 	plaintext `LOGIN` command.
diff --git a/imap-send.c b/imap-send.c
index 37a8b48ea2..67077c2bd2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,6 +139,7 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
+	AUTH_PLAIN,
 	AUTH_CRAM_MD5,
 	AUTH_OAUTHBEARER,
 	AUTH_XOAUTH2,
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
@@ -951,6 +988,26 @@ static char *xoauth2_base64(const char *user, const char *access_token)
 	return b64;
 }
 
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
 static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
 {
 	int ret;
@@ -1001,6 +1058,7 @@ static char *cram(const char *challenge_64 UNUSED,
 	    "you have to build git-imap-send with OpenSSL library.");
 }
 
+#define auth_plain NULL
 #define auth_oauthbearer NULL
 #define auth_xoauth2 NULL
 
@@ -1198,7 +1256,29 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
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
+
+				#ifdef NO_OPENSSL
+				fprintf(stderr, "You are trying to use PLAIN authentication mechanism "
+					"with OpenSSL library, but its support has not been compiled in.");
+				goto bail;
+				#endif
+
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
2.49.0.639.g36d50d01f0

