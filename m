Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30A5218827
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240540; cv=fail; b=Ik0zPgCAr6oBC6fzHTMG/M36yCNz0Cux/RPIz3s1t+5i+UWMyTKIb7H3YyMSCSIlZqipr+jCsFFgAFoAVfeTDKnjRN7/EfU9ud4eTKB7vfAkvnj+FCvYHMBN8Hx71px8cImQ1hf5U0sp2LnNs5SO/6OlfdNm9XxxVAUlGjJGJho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240540; c=relaxed/simple;
	bh=x9XBBvW/kjkhwUDVpVrD3Xs017c2GPH7z/RltLZXjSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bGYSmyrXZrcro/HEgESjDffehsI7ErhkmdBL4710JW0NXBgl4xLyvlDOQpDCqvCDOm1G0tpdyXcnxs87HQ92Vkcd1YFxjxZyjyAUGF157x69YA9bMmJX/KmGob1ZVjdlOKSXjCxp2XiW/4k9PtNvSPGhAZmYxwPoEmwC3E99GYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=jbX1uwqx; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="jbX1uwqx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdaO+mSnVy+Ls67l3NIYBpPrYtdK++Wqzn+X9jotjrmmJ5kloLLOesLPLIR2UByu3vMr5njnbq1c8ZHjL8udUmX11bKm33IrtD9vIQXSPBHO2s1wTQ4anaoNWiDPcJSbICRjOYuSJa7zvvaLcyuHNdYXEOFMXVq+mrW6KkN50u8ROrKATge38SrrDU0VjKjgKOqR/WiNJfdKOPOQcoUpYcZHy8AvN0vuU70wm1XJIZVW9wHTdCqHf6XCF81Em2wat19w/M31a5pyErblWB9JJwhVuI/bHTmqFIu/LdWrb4S1wHZfmC+3TGN3NKVefXCeOHcLFWyWpTE9rOIDoosjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRm27F/TKFhNA6iSjFzqG7S339STLavzRLma7ENaCN8=;
 b=qv2CUu7qzBwLEc+ts+0Zi1HyF+jYnOZEdcWDp+wiAGVNhc993Digm5Nmbgx/xNb3ZxWyfbSQF/kHYZuaDDUy+b1hTeijKsVFPCUsCZvC0Z9d/rWkuAm18u5mMdtIXxiR+ZQZ1COt6JOOET0AMfdz6X4H2qlFyNHK2rsu5yXEZ0ZI7Vrs78/eFkvJf8TAouqHecgK3reE4QiDNz9RQUElZfWJ05BVJt517NMrc2Q5+rjpYrSLybOkKY7BRUMFYIYvk3rGRaiGR5kaYT45+Gx28MqIhV9HurJqBM/KN7/IcMZGdXCQflW3myR6w4eaK+gZk9Fjpt0Na4Pbf0cBjCEtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRm27F/TKFhNA6iSjFzqG7S339STLavzRLma7ENaCN8=;
 b=jbX1uwqx/PxzdCTOnSyTWLiEvoRlM20xjgQgREAOcIVmAdFGjhL5auVJcBGqyU2defg0OrIVzKCuGxpmsngziZvZQa7BkzGvko9tT9KOk3YLckTxATzcm1uoARvlxZkNKF9HlCA3bSEJHqyPScePJNAQjjAWawE7rkq/iZE27MxZclle00jYvuuRjTf30/hzOBC7z3Em9nvppSU8c7yKaKsl4E1qDRL37/qArOs08P+F4BfcWBy9QVNX64pjrw8AUbAD7gQslnhOVPrZRB16rb9P96YvxKIi4dxYPcdWFWJzHGr5emHzPyQIf4HpSjHyp6bBnSu6CnD2JARhdZXe8w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8841.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:08:50 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 20:08:50 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v14 03/10] imap-send: add PLAIN authentication method to OpenSSL
Date: Fri,  6 Jun 2025 20:06:25 +0000
Message-ID:
 <PN3PR01MB9597243869CB8CF4D50CF505B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250606200632.43298-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 82611980-32d7-42e2-d02c-08dda535f346
X-MS-Exchange-SLBlob-MailProps:
	8U9+OAG/EBLCjEga+mmej6/q67y3GGop9A0nFqU3fl3fogBQ72VUNrrsDuafybH9maQdZkhSYhcLUteFNZMtobXEF+B4KI2ye+WFButqlx3lF3h2ebsWkI+wSYE919N+NUxrMN0a2t0UItJSWILC4tuH5w1huXoeDLNKpybpIwvVvTyW67gEALoMnhmqIszd8sSSYAAWzR1SWPnt+gv2vDa5RhqUDr1o5A0MfChJpMe4uGZCfqGq838b6TPQGWAm0qIJmwrsNg/FtYbBkNc6H0uUAGQvghQAD1Fece3TffMNz1bJ1XHV3yZUE/haa7z1X7rpby7mYZ/gz9aArkLIaXvAPqYRfZb5gpdqNqUu48gF31VxA1cHoL8E08xztFFaWsrOZu5BV4bEGpuTrWlMiXkB6pjDEuIPf4srBQ7pZjOm/NW/AEFBCv/R2x9X/EX4VU8iPf/6l3eshjCji+C7/HwhXhADqjoVuFncaDIr+yYtFes4UZNsZKWRheY4z4CRn2nUhHXPoW5xcVjVmz3LFgHVNVrMLoWc1lsGMXb+2/9T7ptOGJ3F1TeziyGk7VuBro7ZvmctsuUSTsMnm5zxqp+kD0ot0IMMFMBnx7hTpznKZAsBGVhphmc5FJkVgJ9UlYdZ7rG8AER4gdl8lwmIChU99BpJivlYzacfB8k/X3xUCI7HQIGd2e0sGaRODhH3aEaVwrVpq2p+hNyw3NVzUUrMhgROsdG2jOWbvnaEZqJ3um/yklCytHlrDDNylaKy8HhsZ6TqqhqIh2efifVs//og6C4mqdnftBtY6N9kGi8S99bc/HeSSXLOTPiu+3nDNYyLMZk8uiIh1WIBj5YeTQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|41001999006|5072599009|15080799009|19110799006|8060799009|7092599006|1602099012|440099028|3412199025|4302099013|10035399007|12091999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GG95pRewt2w7L9i8i1IPGu8UrxlK/Wwmg9Fe0TZVFJHElqh0Jvzle1FQ2WRR?=
 =?us-ascii?Q?J7h6rvZ0+YnHLi/1SKSgrtTFjeB4i7y/hzhcdockD4gtQ5Ufvrs3yMu54Dw9?=
 =?us-ascii?Q?9GRTiNv8CKJqiyB6g2+6r3B2p4ENVRFf2G8ZjKz7pP1Dwp0ehRclDQtWVNei?=
 =?us-ascii?Q?ADu7JI6CSgogZEqZfquDGRFtDDItM+uE1yDJJD4JnrnyAE47KlRq4SWrJeor?=
 =?us-ascii?Q?e8qwcb5g4rGFruZ3ZpzO/FwphPSSQasyGmviaChlAZIdOtt7uHttyUYTR0AP?=
 =?us-ascii?Q?gcKo+Nt9ASEWqUdF+rJzAyDhqiarmtC4b6qWGGlH3mevqN0aBhXMb2kLtvpD?=
 =?us-ascii?Q?//JelXQ7N8GAk/FNyCHYpChade+g+iUFO6ik6Kp7IIQhBANX+pvhozrwtfZ4?=
 =?us-ascii?Q?alsffHqNsKf+ahvwv4btIn5+Uc++HjA5guFhs15oJCxlaH8SSeO9tRpgK+se?=
 =?us-ascii?Q?JtEnufCFleAvTxniOATZKuPpiUG+U5jUvxQN1y5hA7aOUs7pYlDwqzdKTb1Z?=
 =?us-ascii?Q?E5A/4asHP1pltRVaXCoAhlGuS6jMv6S3wn+1Po2iPoVT0x2wYr8S25bhVcTO?=
 =?us-ascii?Q?JaFOgbvMFeihTmf3jCdmNOrUuaWbri1jzrwZoFLEJIVzSGO6LQJkKLr19pLQ?=
 =?us-ascii?Q?vrcfHZjED6ngBYTOfr9ra9+RTgW7ZtUnr3x4lVRfqS44jgmAeR9JhpLbzFu3?=
 =?us-ascii?Q?o+peyVrYJPa1IA6ygnRdEG6GnVR1I6F9XPCTjhWYUiMkv61lXYYB5iuArwin?=
 =?us-ascii?Q?PIhYnWFLsDLJt2vakE7qWPV5cBHPnkDBXUYCcTLek31UFndVWkjrHgiK4WAs?=
 =?us-ascii?Q?17KVSotZ7z20SZXCWpYrm/gHCswMxtc0M4zPRGkfuNnaXc33uX2DBN3xCgWn?=
 =?us-ascii?Q?jXUmTQHYvQ4gXuFeeA2i2Wb95D9MLFAZ9FV1upou8VTgA9IqQ8fc/MubLqh6?=
 =?us-ascii?Q?3cxQ0oxetC2368GNrhwRtwaMj0xMex6kXmvVPlXx9Qxm5GnheL+DR+nJHz2y?=
 =?us-ascii?Q?FB4AVja5QT8GG2QH6nrOKhDbqsqEkfRR35IeYOCwjG977pijB8ytBPvTh+Zt?=
 =?us-ascii?Q?zTkWiWOI2Rtht1YBh5NK83WcF5OdNS8JSRccyZNUCGNIWMezavsS6d89PWhS?=
 =?us-ascii?Q?yiBfX3+Ji8E5OnomgwWYNHcrpqDKJb1NkUQ1pdpL4fGmgFS1zfwBHIvXNFKV?=
 =?us-ascii?Q?DyrF4vGuxcJSFGzlIVGUtFePRmPGRjz7w53YJron6EHkAlL5EWFJ0NJY6Ii+?=
 =?us-ascii?Q?vrY6DdrKyAwGdtyWx5CsIuADqASC4kgJd5eElcSkqvI1VDzXJejC+19QJfKF?=
 =?us-ascii?Q?Pbg016xJsGXwNFCS4OiN1riVB3hUzzq443t/Gs1MhPAQ2//wWbvpwYsV1rE0?=
 =?us-ascii?Q?Z5zWvS2KZcdlZljRghoU/VkJanv1?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WuvicHuz0uH/bXgoSJ9iozRd2gZ7dh3crVV67HTncTnJrWOYVKbZ1s1ZezrX?=
 =?us-ascii?Q?YIyv5Bgin7oVmlyAYEKU4YTD4DH4UGFbYEjbdoeS3TdO3hrC+9mFk+U/YUBE?=
 =?us-ascii?Q?8vAIOYVE01oH/NVtzZvYcWlAYgV49qWkUyCEZm+1yaMi3M7/Z/5OGumogsye?=
 =?us-ascii?Q?kJJGTfJxa1gxqvMSLpSf9avfNiP2K/cYGJFqNFVlfdXIPKeSmga+dDoP+nj3?=
 =?us-ascii?Q?tmj4r4wuBVYboi3otiy5qwnkEWaUzWBNlfKBEt9wQpi8a1c3ZcrWctkvHE6V?=
 =?us-ascii?Q?y/vnPRbOtpMkdobYa7GdRRMgIvynvURvmVulKYorIw9VRoP7NTFMRPFJM478?=
 =?us-ascii?Q?97lE3H31oGLSu7Osq3uh8Bevyd7SCSlSfkQ45WsqWRdKMKyaE1FNlOOsB2Zw?=
 =?us-ascii?Q?5ROkr/Z9VbGqa+Kv/Lunol8lkK2XAonBJLTV/3a8fynC6isjO6CHUovbswaf?=
 =?us-ascii?Q?vUw+s3iZZ5ydyc/fgDLtTuPmL6j81SoLL9BQinr3OIAbJAYRfnp8uYQMtmJC?=
 =?us-ascii?Q?pzoNhuaVTOcrTlAdL5N/56L15zh0R209u/LUQD1Tj8oxoAhI8S9jF6WSuznw?=
 =?us-ascii?Q?FKKgiQ0ElXibvh/8MHs9+dHSMELHP+tOy/sOOZulw3WYvlqu1sva2bnSIx+D?=
 =?us-ascii?Q?olTXRPP7N8TRTUvqImfr5hPzuzLPrHfUavi9I96ho29JvIexGfJapCqfCr55?=
 =?us-ascii?Q?8HG8Es7RLx5h+QJUj7NSiNT5bCKL0sgs3ITZLOLZgm92ICQLGh0t7t5cCvpr?=
 =?us-ascii?Q?M69gtyaolB4Y8JzCpC3k4LP7u1hRSjvpGeDG4dq3DQD9r6jEYhWY7ONqFhEQ?=
 =?us-ascii?Q?adjAV6VjY0oaJc+dDE4mR2Gj368dSC3UDn9lKTEQ6Bn02fsukEcKNP8c477I?=
 =?us-ascii?Q?yZ/BnXljvESmlkxSLTErhh7O6sGyXHIev/ZkUv6ZDAjcuAB8KKR+n3Hpr8wX?=
 =?us-ascii?Q?dH6C9QOZxhmEvn2Nx0e14iDYNMqlC0igsgK5ByypeLKwtx7cmDUVC5EMCPH8?=
 =?us-ascii?Q?VqXglYtBz/6v08WY5j0A56Axuc/49JdkKqnuSiNBmPFafgVXI1lS8lAzocio?=
 =?us-ascii?Q?8MOp/KV/edTq9wxGc4jf+LWdhtgqgE/eC38jMBBAs8IXGfxKT9Mx08QAuFOU?=
 =?us-ascii?Q?+gFrmV0cpSh61zPCauhSMlTfja9wCKmcJkcRerDftom1zE4l1MPwVpXk2WdR?=
 =?us-ascii?Q?2m2ObVcyYxYy/xII8AEeb5kg06CmRGOWoa8XAXVGNkYSyWiPfxIHV7HtWxI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 82611980-32d7-42e2-d02c-08dda535f346
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:08:49.2719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8841

The current implementation for PLAIN in imap-send works just fine
if using curl, but if attempted to use for OpenSSL, it is treated
as an invalid mechanism. The default implementation for OpenSSL is
IMAP LOGIN command rather than AUTH PLAIN. Since AUTH PLAIN is
still used today by many email providers in form of app passwords,
lets add an implementation that can use AUTH PLAIN if specified.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc |  4 +--
 imap-send.c                    | 63 +++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 3 deletions(-)

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
index 9df4519fa3..f7e59397d0 100644
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
 
@@ -1230,7 +1288,10 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		if (srvc->auth_method) {
 			struct imap_cmd_cb cb;
 
-			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
+			if (!strcmp(srvc->auth_method, "PLAIN")) {
+				if (try_auth_method(srvc, ctx, imap, "PLAIN", AUTH_PLAIN, auth_plain))
+					goto bail;
+			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
 				if (!CAP(AUTH_CRAM_MD5)) {
 					fprintf(stderr, "You specified "
 						"CRAM-MD5 as authentication method, "
-- 
2.49.0

