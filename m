Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B154B2111
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626381; cv=fail; b=hYZHYAFQD0+wyBxXYfJPhYHKyFX+PGmjzUu82xth/SV14jEAKauPgmOpVWYhKdg4tsiw7SwORNnZAEBY1Bvdaxi39/YZtGKIlX0AtlIZVZt9iVprZjWxyhwc5wRw+QLaYB7TggwGzosdTmGsaNs0DUoyHF2zflzSB9B+wxk0nXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626381; c=relaxed/simple;
	bh=lziWDQXB7+rCnShJTAHMC5pLhPZPTZb5yAKCvEfpsxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YpYJPJA+tqmbD9g2/ZK4I210qoSQxdhaH8hLbdQOko0n/KtM9NFlQjsK4RkAG1i8qT7/odaVOm1BSz3XPwj5/Log+Qn5BOHqp20YSW+BwNZzguzZvk5pxCRxFm6u+xvYiBk/TpNRxe0fP17Ti4vyZqaKAgx1jPAEiIYdonuT3f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=aiZ0nC1m; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="aiZ0nC1m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwpLFH8WXOBgPEavk0dwgfmuAxtcyEzmLryooz83MkB0fFFloifjIOuFwaFr/qeG19twc88eiLHsELeVh11pTf6JTQuUW7R461fW59oSLGbhroyz8KR664awCHWrB7KbNZUFPIosalsdL4F5mTynh+wp91ADxx4eTps9lrw6Y4104k41HLDmwMEE+CWxVYpdhInQJ3CtViHuC+7g1CjbXBx8nFzXjW789V6mDRa1AE5cOorN9HUlMOeqR1scStweZsN52rK1GorEefLInXq1S3Xu4uHqugRUxuJNqDlFJE6TpR+yeudTbKQCyy7YAJVe/XUyx/gEqhRznsbq7D7qqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG4MoCEMEpIDAgKrgqoG1uAxUBdy83rlOVM63awSbac=;
 b=cCzHy41GbTQjyXasVXjc+oznYPzC4qUACdmUOrWnFYwqgKqF6nlHFyeefqkxotky2kzUJQIjl9FWI4eoyScFdVHQOpW9ZKWq4sU8fdX0hLUj86ZvcKWN66kUWrBfjYTfLnSuA60qpUvkAhoW0hpXBK+0rzSygznX0KehmUrOXqRcByrvp4QAdLLERNKqLF4B34go3w9ptktnrSW++kDzzd7PkbpQj6CSNhq7L8KdrdxRDrioddi5o/+7UZOwRdgSIl43KaOxVKXErV/ctP3CmyfIzQLkEtpL9FzwwCUpTdlSSzPnASvtz/hbJ53ZFssGNcwfV1+UeLF6wT+L6rRexw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yG4MoCEMEpIDAgKrgqoG1uAxUBdy83rlOVM63awSbac=;
 b=aiZ0nC1mlO5p70/Qkn9mbDbQjwGKQme2bPYsGzqF6BoOnooJrUjnemZw+QOud3+TtdZ3cJDMuUQThrEBOZEv83lw8TJjFE+OeiFSokSvuIu9n9XMQF9JkIT8q3l9Myl7E2fM3VLwrH3etkR9YNYxOllUbjdbGh5rpuWv6/5tzaOpJUPmvx9VQsHc4y+3KgwBdPSwUfcd1huPchyMZuGh662HXOamn0XUoZDpL0pCV9jg2dKzXaNjO4LVW4u7xuZwwX7HtGx2Y2ZeGArVWlwLB2h4Ukx8GGvCyO3553UIeDey36wRwgP0PU5doB7OJOXeTInwCd97CQ92ba5RV6RIQQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5501.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 30 May
 2025 17:32:48 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 17:32:48 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v9 7/9] imap-send: display port alongwith host when git credential is invoked
Date: Fri, 30 May 2025 23:02:20 +0530
Message-ID:
 <PN3PR01MB959702EF7D8B0DFA146766D7B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g6f2668de07
In-Reply-To: <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250530173222.20211-8-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e8ed91-4f07-41e8-eff9-08dd9f9fff18
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|7092599006|19110799006|15080799009|8060799009|41001999006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cCVebTTzh82v1FhFwdwlooQp4g5BONX7ZM4XKQ13spTSDgfreBvLI81X8GG7?=
 =?us-ascii?Q?ctPyko1F0b45R5P9AqN1XR9Gi/z9sgtCIg/PvwZe7PquHK/x/7wapXztxEoi?=
 =?us-ascii?Q?mCVXw0t1A3pm0lX+72fdQfuNzipkLlweuCDeyZDQzjlGPx7BGkFu+RcI+qvE?=
 =?us-ascii?Q?TGuEeRYz+6E1A8Gx0e/g+IgaWt0dCrfQ+D9NnZ4k06MD6QYheVzEGkf8wuaK?=
 =?us-ascii?Q?v3KvWfVfAtm/nNb2EzkTbQuiK9nEMImtVz6oVbLmiIlSuPNVb/HfV+gqxSja?=
 =?us-ascii?Q?RCkW6qgaJJ+tqJDHANrf32VaWCULei6yD5Hs3nqicPrIrZGVTkiDjtB6RUbt?=
 =?us-ascii?Q?2B/32t8jstlcSImrtyDb2DCqCggRCuaYaNApZ+a1u3SmHgCsfRcQQBnBFKyh?=
 =?us-ascii?Q?xN4+SN18uXZgGEIL4vETfFK0IW3lZ6YnQWxruZyZYxTDAb6X0P1bs6T63wg+?=
 =?us-ascii?Q?B4bq5E1fIyc9MlrgFG6EEb/rgXb50ukTQciN7YcqpccFT3FJDDc7+a1xgEkq?=
 =?us-ascii?Q?vMebDY4qdSihsQlF+zOKsRotkkA2nbU+3UmqENMGvLnlDU+i0z6SPnqTeWjb?=
 =?us-ascii?Q?ddlfUOf3nTtQoOB5vCdVVfelpfBJDCb5X8oI7iO2el/U4EQd2kGGtHc0IIa0?=
 =?us-ascii?Q?oXjhfvl47/0q/dFA4xk4CCuZE9SrdE5hq85iODv7etIk810OCQ1HOPibRoRJ?=
 =?us-ascii?Q?K/6i9Bc1VOROi37EmFulVe/y4/tiCRgJPdo+w4RX6zqszPU6n7hb2qkWu+90?=
 =?us-ascii?Q?NbVbhxZ1S9orTAWRyfKdLePkrj3otcrYhxDZUz0ie+2aUuKKcvkM3h62EdeN?=
 =?us-ascii?Q?4ksbTXJknBGCpvzI4xnIL7El9HkpYNRSprnSVvtMehVG+j5Pz6U/Llux64dm?=
 =?us-ascii?Q?cOqxPyXZ471sOM/fsPk9ZJZK4FcVqaJ8vM8l3XUBvPJuslXiIsHts+5nxRJD?=
 =?us-ascii?Q?fj27MO6QGjG+JzW1t7v9UyskxoGseE34iHzrWLgRksr1WTACXetHMnm6GCDu?=
 =?us-ascii?Q?b23u9JdW1oZBuqJtMMTTAhS/HNMwPTeP5lLcwSyAMJP8eaLUEKxAXccCbHfa?=
 =?us-ascii?Q?Ih7HF9V+C/pWjr8fVR0HpjfjdiV0xPDK/tpBA1FkseaYrUHr3VYS+UIZ3kCq?=
 =?us-ascii?Q?Hg68IYjdKY+5F4i8sVvZT5hyq2avQN2LZA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ieseqJsOsfOTOO1qZk+1nuCZmFali4s0E+75MLNWLPVrdk+EMGfFiw5EY9qz?=
 =?us-ascii?Q?aI8Zy/YkU5nyjSSUZjsgmHh7SyWUgxXpcLyyJFYKEUMNnOw/o4DudxSIM6Wi?=
 =?us-ascii?Q?8nHMA3zCzuvtbJFRRWlO3oo0Aw8uO8D9UHdy4UybZcsGr+MH4Ovqk1qKGqRO?=
 =?us-ascii?Q?6ai5qGDof5QwNeTzt9qpH6cVXFfy6D0oR8OAcZHvJRYvfVG37gSkeP807imv?=
 =?us-ascii?Q?XEQ1RQ1zifNEcrfkxTRf66ztVU6eVarMUsMRSTQnefDN8D0Qk+binkn6p0hy?=
 =?us-ascii?Q?w1w15KzkxtWXzVUntuCfapgr6qUOamVpqG+yBDZV69AwCs9rkvMCa4UNfIyx?=
 =?us-ascii?Q?nOimEGzT64EfcRO8n8bKpdFeCpbEu0pOhuHFqOjmdpqCrnMueCtW7hdnMd+M?=
 =?us-ascii?Q?IgKAnp1rJdIh47/6ovlhF90pcL0AJOD34fR9zn1nX7pscJZKJH0zuw4HQolK?=
 =?us-ascii?Q?YfiQrD747Bi6gOZYYQc/hrnECvNBMWjCKvcIg/2fg0S4QqTtwUnKramTPO8k?=
 =?us-ascii?Q?9Oz7175s6/0P+ZD+KOdjsvxZXlpOvb2/hwyOi29n700R1qRLIw7zwp/r1nNj?=
 =?us-ascii?Q?+n8qc3owNwg6XV9qqkvk6cJqq5t06Awfn5uU7kZfSHIkH21EtaDyq334pRTy?=
 =?us-ascii?Q?0tNb73WB5SYwyr/oFvuyKYjXjBCcHt4KhtLbip/RNbw+j9k18cbfw+eeK/jQ?=
 =?us-ascii?Q?yTGctAIa0PheuH83Q/sdQc2/ajd2LPqqK9n4JXCKM+VgppRMU35Qfn1e3oxi?=
 =?us-ascii?Q?Jt/HsuxZ/Pka06Pm/N6xBMHlbh2DZMZimWKnllthAOnI/C6UScsE7Qq5zsud?=
 =?us-ascii?Q?ZkYKogvcSv0qv/jveCvCTA5xJrkHSPWN4GpfPVBo6jBc2RsDdEve6qlQeEX+?=
 =?us-ascii?Q?3s6VOY6tziwVoEgDozEzuMeDQxDSdEXznW0LAPA8ElMv52ac/XucpZKIn4L5?=
 =?us-ascii?Q?GeaZzx91KgrIgYlRMaWLpX4SU3vI+RVWsPH+g8xUnxqceLTU1HI0fLKir2wD?=
 =?us-ascii?Q?U4Pgup/exkRkU9dlCh+gPV6SCfWNEMz33PDVD8KpJgBDnsEpY1UKcrU0xUDm?=
 =?us-ascii?Q?6i2ZCkC+DEW6XuQohCXjA4oIii/zq9x0QzevMuEGWwlxUgtXYe1ScwFStEie?=
 =?us-ascii?Q?eBvxH38C2tL16yHDa+5HDEHl0SJBY57dy8NIV27LIwRfiFmeZWy+nySZmDp/?=
 =?us-ascii?Q?Zzfl2VobPJc6LKqF1mXQ2rA+B8ITnhY4XJYNE1PEQmjT5hVC/En4pbw1gwZz?=
 =?us-ascii?Q?2pDazezCRA58TczHa9HHcdq1tQmJSwVyjGY7BFb4dM3kQrguiRcImFJAiVhO?=
 =?us-ascii?Q?O3mVSOriQo0ueqEIS6KsPzZY?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e8ed91-4f07-41e8-eff9-08dd9f9fff18
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:32:48.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5501

When requesting for passsword, git credential helper used to display
only the host name. For example:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com':

Now, it will display the port along with the host name:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com:993':

This has been done to make credential helpers more specific for ports.
Also, this behaviour will also mimic git send-email, which displays
the port along with the host name when requesting for a password.

FWIW, if no port is specified by the user, the default port, 993 for
IMAPS and 143 for IMAP is used by the code. So, the case of no port
defined for the helper is not possible, and therefore is not added.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index d99eed0659..c963ce62d8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1104,7 +1104,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		return;
 
 	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
-	cred->host = xstrdup(srvc->host);
+	cred->host = xstrfmt("%s:%d", srvc->host, srvc->port);
 
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
-- 
2.49.0.639.ge2dd5d9d81

