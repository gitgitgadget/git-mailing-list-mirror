Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CA137932
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 10:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380235; cv=fail; b=mou5frP2j0+wQ8DtWaPU5vFthgIyDtV4F8XYiiVr9WetqlfOT8G+f3vWkIGsNRA7BtdhRArA/NpDZ7/wJ2gj+xpx/Qp4wKcUpWFg1aKqRfKST/vGgCOw1VRXpRSAu62BrHGlep0ti1/QBKavYW7nubibFgHf8nCdQEDtbVlW2Ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380235; c=relaxed/simple;
	bh=67Ye/At76CelkvRx+8997jFbLTcmOlen4kAYoz1ROHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s7lePtrfFnW/JvcHvKKRoZT9X0H5lYxINR5Yx40iEJF3icpQ8ZrAc0BR4Hm7NkzZjgbb1MVYOC0kchPfGiw5SEqg7iINIW49/flJND4ocRs03dUiTsWl433Q9Ewd5ZAr61tnQ2YhLQajLfAYe+XCjTSWqEGanGam4zDADzhS/o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=BwQ+tupL; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="BwQ+tupL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McgYjIGPBEtdMtaJt/V8i0mIzahXMd1Y+zYZTSPC+xfjfyhj3B752cyCw3JI95WfhDbWuayMLPnTYHJm3VmJeGiTEP7NT+Wf6x0omVh0zOVFeV7wgb29Was1UzjAgLanssSp78ZA7c9YC6Oi9oOumcs8KGwIC5pa15dNydW7G0kTmEJsQaAwvOi+Mh4S0ro3kETBa1beSnmPC8qyO/txpw4bxn7A1HGmXiLGfE5QbaDqJfAyh3b0s9prX2P5mKLefin9Rk862nOnLlG6FBf2tVDrxX/jzauhHXldA9HvTjW/Jt5OkfFTEOjyF4aURgwwlRPXD4A4Im4EcS00oVTwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHjeiGInUJ/TonfSkVJYimKfXsZ0CT1QiSLmWiOed5k=;
 b=vQxzcof8UNXbfEFbTg+GZ4tyFLVhiA54gWkAyZEPy3zlrvidwGIdhr2t89vzozdcfcXH7Raqd4lS0rtu2voEc8cSSoXmYuNeU8Tcs3o5RgGNkQ9YJ8jnZE/0rqtD/wJhHM2ppLISXPH6xxetyHI66/ePzyEua2ZzEKPDBfvXZuiG9OPsVgMt3KmYmXEPUwBE1EgrlKntHoYI5lLOYB9W7FDnIMcxy82g95UYoLrlUfgnq7iDotInICYLEHg/ts3eyDYCpEWApw56wvfy9ao2unO7yDHLadiRs7u6mZZmxnPJB90SEpFWUgiWtxgj9n08U9bIcVfouE+BN88ExOH5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHjeiGInUJ/TonfSkVJYimKfXsZ0CT1QiSLmWiOed5k=;
 b=BwQ+tupLwB8L478kQLTrqTmBrcejVbY4stLBBH2FDM0SFlNP87Q/cz7X18R7C+JsUov3kB9ywTHE6YwUE8yBK3osz2C2+6CEH801pavcWDf/tlskJaEw0QuODjq3iDttcbqDCy4NYDA4gXhG0HWLbEuFBKmq3OI6/CU5+1zUmaUCbNWr+rvGaCLTfhetC7F8I/nGqFbpeV85WdAWG4HOCdeT4TrbD+CLhLChHNuJIK0hiMij1zZTlSZyymMYFTx5qoyt+GqJYlS8fPVt1agZJDf9IBTqmD2d+kKYvYXK5dfFHza6S1mRRZC5MElshID7KB/ZZrFqQX/KxEs1Jj/UNQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB8974.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Sun, 8 Jun
 2025 10:57:08 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 10:57:08 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v15 00/10] imap-send: make it usable again and add OAuth2.0 support
Date: Sun,  8 Jun 2025 10:55:09 +0000
Message-ID:
 <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g4d9a3b5661
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::21) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250608105520.18264-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: ca255fd9-5f82-448d-f67a-08dda67b364a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|41001999006|7092599006|8060799009|5072599009|461199028|15080799009|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CNuLhENgpEzydPBNwZ9NN7zet2/jOaLHWWeeEf/Y+cz5H9hF9//6oSpGhVCy?=
 =?us-ascii?Q?WOAy+bunW/nklr7t2559BM5bTcK5Q+xbc0+YRHtigNE60Pkd67RSH4KALvmn?=
 =?us-ascii?Q?OzLie/ColZojgdEAgVbns3nGE7uCYzf3Z8+vROB5Ihj9Xl3GaaAS4P8rwaPe?=
 =?us-ascii?Q?3rdy8EU3vxJ8PaZIDoGoZnAMxFvmAYmDNM0DIQU4AwDZOKymuKy9UB/BRPoU?=
 =?us-ascii?Q?YZUdvkOjqMGy6q3pCqjjURjL51s51qeSJuDPG4cfsrAj/MPkblrtyxhxTLc/?=
 =?us-ascii?Q?JRIjPysl1KKhYz1Ndz0tUg8MDgzS+URBZ3mNVtAzd8Uk5WUe4Yz1m6KYr4Jz?=
 =?us-ascii?Q?odPU7lBMozr6k1OdikCMUqxN6r9lh8InprU4CD4uRBKJRnWOn0+lOJxbbDHu?=
 =?us-ascii?Q?J0FdS/3rbVDEgvSBBBIwk/4pQMNGH/bvfSBvGmTNgsJXvKmv09cOZ4v3b2Vf?=
 =?us-ascii?Q?pM1St/saB8EBZisIKuuCNkOl0NwA9DUfqaVaz6+SVy/ZczqZr4VxZtKsgmkW?=
 =?us-ascii?Q?EKNLI5kvwM0sr+5pwBX5o4qAmVKGwRilY5cf6lBCy2P8cBJk8CINFw0fpTqZ?=
 =?us-ascii?Q?A5hwXV2K5lp9P4LAnsqChC5DSvEVhaG9ixtOoVd4t4lq+2qf+SBdv7jBEEMN?=
 =?us-ascii?Q?2M5ikRZnVytXUKIY+bmQS5Kw8RBZAo7XPc67UC9Zfx6oP+uF09a+iiaJA15U?=
 =?us-ascii?Q?15untTwgHUj47tyX1wA3pHUntX0wgZ5JN1UrnAjPuGQ2JTutADQ4RRdEfinX?=
 =?us-ascii?Q?utoH8rnDKuDnz7OsGbkz0W1UasxQeFf3eD93Re4+K0M6XARHV0Qlnyh29LNI?=
 =?us-ascii?Q?DS1kLa4Aw3+hO+apKM0eNWYiaOWWOP2N47x/qdyX54HS/i8ptNkiIwlLD/3r?=
 =?us-ascii?Q?00EXwG6XtbXLIKnP8LNqaJ+6ofq3D360wWkx1Z4nFSiMwx4f/Kua24iixb7b?=
 =?us-ascii?Q?OPCHZIdUMkUhXme1ke8/zMoNiA8kFlhCU04yc2g6AQX9jmyEgp58JQk4pIdE?=
 =?us-ascii?Q?oupVbtlQJBdlvJHspNuDfNumjgONs74v9dDQRE5w5E9Ho00c2lGCkULu3QPl?=
 =?us-ascii?Q?ybJ++Rg9i1oAcC8brClGmyrYpjKnFTqkgGyfHFOL0mij3+ojZiNaDCumwi61?=
 =?us-ascii?Q?VT/q0ZIBdSTtxJPyiYzs2AwGyYgbyCt7GukxZso+YHnGEhSVaR2Qr8U=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BXMYiSX4VdvIw/G9KrXBeslLx/+x91tw9Ci/XOvI1PqbI5nlGu9aFHPUO7WZ?=
 =?us-ascii?Q?Raco9Q+fhaLtZI80UYqsTXD2SxgSrdQMQtuoosPvnGmN9JSKxK93G669YdNI?=
 =?us-ascii?Q?QaBY95k+LTd8FRsNjuectP7VN4VOiScCa7jNb+dTdsR+0ePBK6o+k05XTRft?=
 =?us-ascii?Q?0PtALUfGOiu2RN+paCg79Jdfod6OHgM0DOXFE213iiAaZe52YjCdNJdjorcE?=
 =?us-ascii?Q?KMCa6CC5wRIa4CklW97ywmAuRdSsHxtnQV/2ZUjfpiZAO6o+3cKQBE0QGj+U?=
 =?us-ascii?Q?Rsbm4ukiKFsZ3fOCFc6aFWlFyIkcfjNK32Tyza/YbOz1gM9WCOs3NE4q8o3Q?=
 =?us-ascii?Q?N70r2LOGMFIYLGHligBwGVJpffZ+byjxV+qIycYHWEfNAdfG3zCaXYU38tq7?=
 =?us-ascii?Q?GxTgM9mgiw1nnySVH/1czpByKFBTPviWmKRCma8PMmET+Ab0NxPHD22zCurV?=
 =?us-ascii?Q?woF20iP1HiQkKTXo96MqbUUMALKyjwKw1rSyhXpdFUYAFb0arVg8nlOklZ1H?=
 =?us-ascii?Q?/UGowe2qzrMSG35szbtNdcXYYicJ3ts/c1CiWwwun6RmwpJCCUxFPjI0x7wf?=
 =?us-ascii?Q?iViyGha04VtcjaY2fAoWza/BzaXBp9XHq8vsvW5TcNKlD903Rk8YVjHNr9Xj?=
 =?us-ascii?Q?8P0Fs1y5VNtjJXQnzNoCwk0mVKGgdD4kHROEVsZgtrFx5k0FskYNfwfkgPF7?=
 =?us-ascii?Q?IfdUu2GtILp0O4TIPapHS/XHQ2jYnG8a7VK0r1+/HU/BMGFm1+7UvLsK3pEZ?=
 =?us-ascii?Q?uoMxdOT3MrMPONyOWtKjCkF5SG+eEfU7WVYSebhyLurWdmWudKplmeHwT1sF?=
 =?us-ascii?Q?1fdX7x66tZ9fmkdOw+LH2PkENo81qKXRgUZuKjs6UC4JDKPrqJuDgKyQvx9Z?=
 =?us-ascii?Q?SO0jbZ6H32CGaosemeDDb+5kJ7YCWL/dandAP7Jsa1DEs0c4s33Lw7UIRs/W?=
 =?us-ascii?Q?ljUnoxwuiVguBVDS6xVa1qkZLC7ANMqBFJ07cMKKDUf1A0qr6jstJKdbBgyy?=
 =?us-ascii?Q?nJTzjoXcyPGCk/8vS0U56d2fJeXk4tQEYpFya994Gb3O4rIaSUM6gTntVWEd?=
 =?us-ascii?Q?aAYOGSax7l6Ejmb/KPsI46k9+PL4I7EocOa/N96aD9D8Bh6s+01elPJvxztO?=
 =?us-ascii?Q?5UWZW5wJnh1Sc0y/GX0ats8Ya6vSvFzelBs2JSdI2g1JEjoQYYCma+X2psLf?=
 =?us-ascii?Q?l5fH3qD4J3Fvk4WwpNYNSVWPrJHkNpap3MJVhAwtnGTISW0E0N8HCSwXw88?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ca255fd9-5f82-448d-f67a-08dda67b364a
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 10:57:08.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB8974

This patch series does the following things:
Firstly it basically makes the imap-send command usable again since it
was broken because of not being able to correctly parse the config file.

Further it adds support for OAuth2.0 and PLAIN authentication to git
imap-send.

Lastly, it does some minor improvements including adding the ability to
specify the folder using the command line and ability to list the
available folders by adding a `--list` option.

v2:  - Added support for OAuth2.0 with curl.
     - Fixed the memory leak in case auth_cram_md5 fails.
v3:  - Improve wording in first patch
     - Change misleading message if OAuth2.0 is used without OpenSSL
v4:  - Add PLAIN authentication mechanism for OpenSSL
     - Improved wording in the first patch a bit more
v5:  - Add ability to specify destination folder using the command line
     - Add ability to set a default between curl and openssl using the config
v6:  - Fix minor mistakes in --folder documentation
v7:  - Fix spelling and grammar mistakes in logs shown to the user when running imap-send
     - Display port alongwith host when git credential is invoked and asks for a password
     - Display the destination mailbox when sending a message
v8:  - Drop the patch that enabled user to choose between libcurl and openssl using the config
     - Add ability to list the available folders by adding a `--list` option
v9:  - Encourage users to use OAuth2.0 for Gmail (similar change done for send-email docs).
v10: - Fix comment styles
     - Fix failing tests
v11: - Use lower case letters for the first word of a sendtence in an error message
       and avoid using full stops at the end of a sentence.
v12: - Gracefully exit PLAIN, CRAM-MD5, OAUTHBEARER and XOAUTH2 authentication methods
       if OpenSSL support is not compiled in, but is requested by the user.
     - Use backticks for string literals.
     - Wrap documentation text to 75 columns.
     - End the last member of enum CAPABILITY with a trailing comma.
v13: - Fix logic error which was using || instead of && when checking if
       the authentication method is neither XOAUTH2 nor OAUTHBEARER.
v14: - Specify why we are not using CURLOPT_PASSWORD for OAuth2.0
       methods using a comment.
     - Add a function try_auth_method() to reduce code duplication
       when trying to authenticate using a specific method.
v15: - Simply rearrange the patches to make the cram md5 patches come
       before adding OAuth2.0 and PLAIN authentication methods. No 
       change has been done to the code itself.

Aditya Garg (10):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: fix memory leak in case auth_cram_md5 fails
  imap-send: gracefully fail if CRAM-MD5 authentication is requested
    without OpenSSL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: enable specifying the folder using the command line
  imap-send: fix minor mistakes in the logs
  imap-send: display port alongwith host when git credential is invoked
  imap-send: display the destination mailbox when sending a message
  imap-send: add ability to list the available folders

 Documentation/config/imap.adoc   |  11 +-
 Documentation/git-imap-send.adoc |  68 ++++-
 imap-send.c                      | 412 ++++++++++++++++++++++++++-----
 3 files changed, 414 insertions(+), 77 deletions(-)

Range-diff against v14:
 -:  ---------- >  1:  3e3ddf7077 imap-send: fix bug causing cfg->folder being set to NULL
 3:  1510127888 =  2:  417b3b8e38 imap-send: fix memory leak in case auth_cram_md5 fails
 4:  731fcbb602 !  3:  c4216528e7 imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
    @@ Commit message
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
     
      ## imap-send.c ##
    -@@ imap-send.c: static int auth_plain(struct imap_store *ctx, const char *prompt UNUSED)
    - 	return 0;
    +@@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const char *pass)
    + 	return (char *)response_64;
      }
      
    -+static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    -+{
    -+	int ret;
    -+	char *response;
    -+
    -+	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
    -+
    -+	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
    -+	if (ret != strlen(response)) {
    -+		free(response);
    -+		return error("IMAP error: sending response failed");
    -+	}
    -+
    -+	free(response);
    -+
    -+	return 0;
    -+}
    -+
    - static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
    - {
    - 	int ret;
    -@@ imap-send.c: static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
    - 
    - #else
    - 
    +-#else
    +-
     -static char *cram(const char *challenge_64 UNUSED,
     -		  const char *user UNUSED,
     -		  const char *pass UNUSED)
    @@ imap-send.c: static int auth_xoauth2(struct imap_store *ctx, const char *prompt
     -	    "you have to build git-imap-send with OpenSSL library.");
     -}
     -
    - #define auth_plain NULL
    -+#define auth_cram_md5 NULL
    - #define auth_oauthbearer NULL
    - #define auth_xoauth2 NULL
    - 
    - #endif
    - 
    --static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    --{
    --	int ret;
    --	char *response;
    --
    --	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
    --
    --	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
    --	if (ret != strlen(response)) {
    --		free(response);
    --		return error("IMAP error: sending response failed");
    --	}
    --
    --	free(response);
    --
    --	return 0;
    --}
    +-#endif
     -
    + static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    + {
    + 	int ret;
    +@@ imap-send.c: static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    + 	return 0;
    + }
    + 
    ++#else
    ++
    ++#define auth_cram_md5 NULL
    ++
    ++#endif
    ++
      static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
      {
      	if (srvc->user && srvc->pass)
    +@@ imap-send.c: static void server_fill_credential(struct imap_server_conf *srvc, struct credent
    + 		srvc->pass = xstrdup(cred->password);
    + }
    + 
    ++static int try_auth_method(struct imap_server_conf *srvc,
    ++			   struct imap_store *ctx,
    ++			   struct imap *imap,
    ++			   const char *auth_method,
    ++			   enum CAPABILITY cap,
    ++			   int (*fn)(struct imap_store *, const char *))
    ++{
    ++	struct imap_cmd_cb cb = {0};
    ++
    ++	if (!CAP(cap)) {
    ++		fprintf(stderr, "You specified "
    ++			"%s as authentication method, "
    ++			"but %s doesn't support it.\n",
    ++			auth_method, srvc->host);
    ++		return -1;
    ++	}
    ++	cb.cont = fn;
    ++
    ++	if (NOT_CONSTANT(!cb.cont)) {
    ++		fprintf(stderr, "If you want to use %s authentication mechanism, "
    ++			"you have to build git-imap-send with OpenSSL library.",
    ++			auth_method);
    ++		return -1;
    ++	}
    ++	if (imap_exec(ctx, &cb, "AUTHENTICATE %s", auth_method) != RESP_OK) {
    ++		fprintf(stderr, "IMAP error: AUTHENTICATE %s failed\n",
    ++			auth_method);
    ++		return -1;
    ++	}
    ++	return 0;
    ++}
    ++
    + static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const char *folder)
    + {
    + 	struct credential cred = CREDENTIAL_INIT;
     @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
      		server_fill_credential(srvc, &cred);
      
      		if (srvc->auth_method) {
     -			struct imap_cmd_cb cb;
     -
    - 			if (!strcmp(srvc->auth_method, "PLAIN")) {
    - 				if (try_auth_method(srvc, ctx, imap, "PLAIN", AUTH_PLAIN, auth_plain))
    - 					goto bail;
    - 			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
    + 			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
     -				if (!CAP(AUTH_CRAM_MD5)) {
     -					fprintf(stderr, "You specified "
     -						"CRAM-MD5 as authentication method, "
    @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *
     +				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
      					goto bail;
     -				}
    - 			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
    - 				if (try_auth_method(srvc, ctx, imap, "OAUTHBEARER", AUTH_OAUTHBEARER, auth_oauthbearer))
    - 					goto bail;
    + 			} else {
    + 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
    + 				goto bail;
 1:  34d56c3b57 !  4:  b38fca0e6a imap-send: add support for OAuth2.0 authentication
    @@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const
     +	return b64;
     +}
     +
    + static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    + {
    + 	int ret;
    +@@ imap-send.c: static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    + 	return 0;
    + }
    + 
     +static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
     +{
     +	int ret;
    @@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const
     +
      #else
      
    - static char *cram(const char *challenge_64 UNUSED,
    -@@ imap-send.c: static char *cram(const char *challenge_64 UNUSED,
    - 	    "you have to build git-imap-send with OpenSSL library.");
    - }
    - 
    + #define auth_cram_md5 NULL
     +#define auth_oauthbearer NULL
     +#define auth_xoauth2 NULL
    -+
    - #endif
      
    - static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    -@@ imap-send.c: static void server_fill_credential(struct imap_server_conf *srvc, struct credent
    - 		srvc->pass = xstrdup(cred->password);
    - }
    + #endif
      
    -+static int try_auth_method(struct imap_server_conf *srvc,
    -+			   struct imap_store *ctx,
    -+			   struct imap *imap,
    -+			   const char *auth_method,
    -+			   enum CAPABILITY cap,
    -+			   int (*fn)(struct imap_store *, const char *))
    -+{
    -+	struct imap_cmd_cb cb = {0};
    -+
    -+	if (!CAP(cap)) {
    -+		fprintf(stderr, "You specified "
    -+			"%s as authentication method, "
    -+			"but %s doesn't support it.\n",
    -+			auth_method, srvc->host);
    -+		return -1;
    -+	}
    -+	cb.cont = fn;
    -+
    -+	if (NOT_CONSTANT(!cb.cont)) {
    -+		fprintf(stderr, "If you want to use %s authentication mechanism, "
    -+			"you have to build git-imap-send with OpenSSL library.",
    -+			auth_method);
    -+		return -1;
    -+	}
    -+	if (imap_exec(ctx, &cb, "AUTHENTICATE %s", auth_method) != RESP_OK) {
    -+		fprintf(stderr, "IMAP error: AUTHENTICATE %s failed\n",
    -+			auth_method);
    -+		return -1;
    -+	}
    -+	return 0;
    -+}
    -+
    - static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const char *folder)
    - {
    - 	struct credential cred = CREDENTIAL_INIT;
     @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    - 					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
    + 			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
    + 				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
      					goto bail;
    - 				}
     +			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
     +				if (try_auth_method(srvc, ctx, imap, "OAUTHBEARER", AUTH_OAUTHBEARER, auth_oauthbearer))
     +					goto bail;
 2:  69fb8f63f1 !  5:  86d3d2c54d imap-send: add PLAIN authentication method to OpenSSL
    @@ imap-send.c: static char *xoauth2_base64(const char *user, const char *access_to
     +	return 0;
     +}
     +
    - static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
    + static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
      {
      	int ret;
    -@@ imap-send.c: static char *cram(const char *challenge_64 UNUSED,
    - 	    "you have to build git-imap-send with OpenSSL library.");
    - }
    +@@ imap-send.c: static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
    + 
    + #else
      
     +#define auth_plain NULL
    + #define auth_cram_md5 NULL
      #define auth_oauthbearer NULL
      #define auth_xoauth2 NULL
    - 
     @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    - 		if (srvc->auth_method) {
    - 			struct imap_cmd_cb cb;
    + 		server_fill_credential(srvc, &cred);
      
    + 		if (srvc->auth_method) {
     -			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
     +			if (!strcmp(srvc->auth_method, "PLAIN")) {
     +				if (try_auth_method(srvc, ctx, imap, "PLAIN", AUTH_PLAIN, auth_plain))
     +					goto bail;
     +			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
    - 				if (!CAP(AUTH_CRAM_MD5)) {
    - 					fprintf(stderr, "You specified "
    - 						"CRAM-MD5 as authentication method, "
    + 				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
    + 					goto bail;
    + 			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
 5:  36154d3276 =  6:  7674e749c8 imap-send: enable specifying the folder using the command line
 6:  85ce1205ca =  7:  a67322ce06 imap-send: fix minor mistakes in the logs
 7:  8dd19a4613 =  8:  b2e7ef35ed imap-send: display port alongwith host when git credential is invoked
 8:  cc1398bb7c =  9:  668e62c0e0 imap-send: display the destination mailbox when sending a message
 9:  0975df9fc0 = 10:  4d9a3b5661 imap-send: add ability to list the available folders
-- 
2.49.0

