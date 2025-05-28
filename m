Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84F244690
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417932; cv=fail; b=iW1ocIcKCXOkKoaLOLUI7Ubl/r3n4ltCAmWnMIzSK0a1A1zfhUdKjsMZILTstnkFl0K5yzxwI+jcsIkC+pMRJTWsdV8N0PkIlxkEBYHiNn22YEYGZcKj6XUm2o5qYpch+PujAMM3wYPTKxl2+6QpNcGOwKjopCS2bTrmtGnqTvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417932; c=relaxed/simple;
	bh=HUG+UCkxLMDfvKJjWtf5JHQ0vHOkIDL2nv1FFG8PfHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LIYoThY+fshKjerUuaMDFfxXKN9wLMUDf1TcIkIdtGbpa4/E/6+/p+V5Oec+8/YnoeYfy6x2BUQ60LvR3SXqCTeCQcJAcrubs8S6wEFq0g57ISW95Ddqdbs5K8C3+YhISwxNpcXSfCKbat5D0ydOB1u5Uj6sEgFF4hDjHYXZ6VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=KCPolZdl; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="KCPolZdl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPXMZgmBdUqoSOHrLdW389aWlHP5365xRV+9vlxEqaUYoSQHG/ktPos+FKCNv1lJ4mdV1xaOJM43LSvkAUMqn5RzZYXiirs8vmo8cTdv4f3Lrj6B2NGQKag0Xx1ebHxkENEuhJrkOBERDzj760WIzAW3cjx8f7kXeUOp4XfuI6ysWjt8EAroB5/6N62n920AEpogIt7DD5MhgJhqUw0elDdACzg7ouKVxqS8kIl5818IyWW4IUF7Ktekf4PNxOJD3igSdOc+n86dNRKEIoZGSp45+bOFT9i+FZ1bbYJ99/NxkKS6zWkxHf9k7CPHNjbwxqvZ59YeoMtjISOf7qWajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9xvrnsGGipSlukcrY6oHMiIpb3y6sci+Bv4oJ0zI+o=;
 b=vRRqAT/IRMkwZLkPQ5flHj93FJO34gTgnuYeHCvpTmxY5TsWaX64CM19ZDQzYiSl5oMg6zOKZtOAHmK4Pq3HgA4+yb7tlUbi21PH/J76Yy7zUNOhS9KLdVFRiZ5moHrFrgQYa8HmYbdRZ3t1ndGE1U45c3vyTvB6+pixpWOwyE7boifBeh8gzA6Z+K8azSFOzHgM2eaj7FAh8DCe2JW0Tzjrpgq62j6cAuO/M51O0cXmCkUCDFXMXRddnZRh2ERpbRPRzipOgPn6SNRr8zjfSn5OPSZq30o8/sS2SuQHrDGU44W/Xi3aCgOnSqjQxrLC19wK25IIMDA5e+f5sSUUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9xvrnsGGipSlukcrY6oHMiIpb3y6sci+Bv4oJ0zI+o=;
 b=KCPolZdl5fRVAE98SczcapNWgjNIh/wrmLx5gl/cHdmj46OlHsCJwNAwtiUUl++f6XQBnkP3VOeYoJZLgxacVZCBCZmbzgUKtUEQ44wbCn6uyhygLabN9fJ0SQQPY7P6V+sKRXjCpYjgoYgxBOxkBP63zeTG3z7+iFviee7EFhU7fUGWgHhS+jLn2yijXdd6VRpx7oIlhGV1ybnmUq5URSUXVNeuruFDYrdtpocgv2S2fAG5p4fASj6LYWrfHuHNRU40dUMuyJNBPSDApXheX7KOzsCCB2nLEzqFVqaUeKC74+9WVyxtNB4PdhwwcAN0YQiv3k6yLUkT46AaGW4ORw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7904.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:38:43 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:38:43 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v6 1/6] imap-send: fix bug causing cfg->folder being set to NULL
Date: Wed, 28 May 2025 13:08:09 +0530
Message-ID:
 <PN3PR01MB9597DE5A2B08B546D3837183B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g4769924781
In-Reply-To: <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528073814.29138-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bde284d-da12-4ef5-630d-08dd9dbaabeb
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnpXacx4mG+8CjKYrijm3xLUEPnW5cCE+gIRax3Ls8dy/yOrFKzlinaMpZX4ID6jHMnovw616RUR4a7rvffnNApq4x/ORC9rm5UYuG75MbG5MMYJUx7DWbT6KlRCRXYxvRnqTnkGMdjNNVOPq9dIH8LAztYUc/0n4Wlnm2do7IWP+5heH//TS8q70NN92JpDGtDdyYVF91YaQR+cI3FHXSmrj5KzgOQbM5O4RKeqC8Zq/fx0xxXqXtm08PvNGVaxWnx85z9GMl6UnWrzaDitroQ9PRp4TT5kEmBown1JLrNSCepsmgMyXlbxUJ6gTYIryyFE+0GRZzlnzBinZKSxVtzq7hzNOEC1gY26CHrkVZ+wlyQmSjXRHf7MzKnAFq4iMfUpTFBA5L+a+jkDs/EjbA2pW4+OMIxVW88mUJiauMOnRnQSW97KdsIGaup7kPgnz1FbM7eWnOf0GyHQPcMkLxPwnZ2zb0PKS59ApmGlchoixfI0ulGNGyErvK0yu/7nI4IgVaqOSwt34jkS2E4YOkf1Wh+9YHHrbCvVEGq6U82Kal9oTRPBBoJItQTlTSHPtQ9ZDAPunUgkv6Zn1rHnXsqgOIUK/rUXaoEDwARWIAvoZMu5f/BkNNd2zxZARCp4Lb8Tnhv+BAjHDl/bbZ2CvtJgf3yXkAfgpYY6SjtXbmBzAQPOd3pvt9IvVCEUoUfrulND5pOj8vmNo0H49/iiSbbJyh6mpx6WxixaWzH0BsXVg=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|41001999006|5072599009|15080799009|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U4L669lI5pjoQL9UBVCs7FS8QqdyQn3nATkmDBmPiVp77uWX03ZE0eQFBQHE?=
 =?us-ascii?Q?o3uxcLFfs6PK9LKLhd9WDhmw7GrZppfCkgYWQT+5Q0j8xQKF87IgqUm5Cnot?=
 =?us-ascii?Q?LGsirzkMWBSw7+61tI0zczpRexhMNCHoYICueGDySRixrnIeNxEP34LjZ75T?=
 =?us-ascii?Q?WfFXKlxl3UnTADPzhqiFO2u1KovY5ycQ+rpqu5F9TvXz3muwFkV+QeNtfaFY?=
 =?us-ascii?Q?45dShoNaPde9Hw9h9BG/oOgKlOjJU1zAMsL6uaYzro1S0MG3Omy2e1TV0PkB?=
 =?us-ascii?Q?vb+dko+fy9NxsiSe/fhY7wwEE/FRQy1wiWUEXj+K2Q6iZSQleFNOa0XGMQak?=
 =?us-ascii?Q?XvhEc5/HGRz686Sggrvtzqeb1Ui9kxpM0cqgD6j7O/8jwfdKmEM0AUfnVgAL?=
 =?us-ascii?Q?ytQe3bOQjBNQaJ/covI7wG1G3T+k3KYYA8tM3ECKXKxnNXY9JMYOKhVBplbU?=
 =?us-ascii?Q?5B+7utRLPB51o//eiAXtjH06VFXh1j/iGCaloY36+2NrePNx4EiKO9NANrH+?=
 =?us-ascii?Q?PtZkBECjRjfno228DUCJlXBypU6MUFU6XVXXL6GX2+NdMlMqRA8FoISoKgZb?=
 =?us-ascii?Q?lnT02SoUSbSh0i+Lvzko5aBjA2pbeBKix0OqvzOyu6Ir4rMDEOKgWCcMOeIj?=
 =?us-ascii?Q?/tAV1Q/9FD6Y8fioKykRvkrhgI2OKVbzx4itvYtuM5oNzR0o1KBt+9CbFOQB?=
 =?us-ascii?Q?HiFuoKd4+7o7OtLiZjsLEGuqWX8Phs0Cd/8X43A51eDE702lv4cBUqrpWu4E?=
 =?us-ascii?Q?EAliwayDOj3sohqT/1UOaIOy5wIMjfISYG6XSxSIJCJf7bPjgbZ/SDNGitCz?=
 =?us-ascii?Q?NziQwKBy+iywXwzlaWfdGT9aJLCWge95jht7mFiqHM3oZSPsiw2RlCgyBFKB?=
 =?us-ascii?Q?8GQzDB65FbU67d/0Sz1MwS2vofCeFINPZz3EaOHnEjPTrQW0Q36tl+MIFFuO?=
 =?us-ascii?Q?dgqM5+DBDiVqF3w8YGADG7f1HGpu1hnLS6xy6wjlGtg3Vin65IVNdBKaeRch?=
 =?us-ascii?Q?AyxtFbk4ZeKN0Mj2NfB3drOfXMQEJYM6EQKIu7335uBBnl4Rxhu7ouOvBsqC?=
 =?us-ascii?Q?RjlWfXM/Zn9vpqvSomf9KjONIrTqD88O/0+3NVo8BcYdASjmduBIBkFdza5N?=
 =?us-ascii?Q?lH/J48kX7kJ7YmcC8P4IIG3cafzJ8P3Wgdy6KK/yNa2uftrE7RfqzZk=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rBZOIMSfAw8I04q6hUXE0J7LlW4Aq+EYxnWZaunAa8QaOBIcT82ZDnlO1+QS?=
 =?us-ascii?Q?vE7HhL3AO9dKoVXpS5TKjHshjg40IlFquX9QmXeH+Wc3H0uZCChyAG3fhgS0?=
 =?us-ascii?Q?i3vF2AeJnl9Mbx25mjN6Qer6owo6tZLmIKiUP5SrUjx16zTfTHR8pTgcv3o/?=
 =?us-ascii?Q?otXUX1tgf6OItU1xnXnlE7Bit4ki5uT5+FthSxaat9RiU3JOt1iicy1N4th5?=
 =?us-ascii?Q?ghHwSuxjlk3mJmlRdNcE3UuB2sITBqHcQvvBH9zYNFWR0MGr11kY5Z9KP6o+?=
 =?us-ascii?Q?38GBx0zGGibwVFlNleG0UA0MK7/bhY1Lrpu1NmLb88rZejYU/0zYtH0ixqGL?=
 =?us-ascii?Q?Rl1bERBW4MvOL7kXDHm5aZt0F9KVYa3FcI04N04JynsS34XCnUNCPBv5+kCx?=
 =?us-ascii?Q?shqjVYxHPR5iQf2z21Ev97IUQhh3hYFjKw9Us6gkf58JJjSmwDjYJ5CIKWoG?=
 =?us-ascii?Q?l/nIa8FzAshKyz3r1qkZbv9NbtvIWuwnsM4PfnYSN5RHY2wo2W5D/QThKXsZ?=
 =?us-ascii?Q?yC2ZpyJI0YvH1yV2Do5p/d1RgtZFMaO22V8KRdh/xEniNAyPxqnTqvvYfbYp?=
 =?us-ascii?Q?E3eidDu225WhzcKfQv/FsTjamdB15orMCLDIKKzO68QBanxEkLkwKpsrQrgY?=
 =?us-ascii?Q?QMegg+pmc/4gc6ldA69OTsZh15O7rQVFcP54W27CQEzSGwZm5eRCBbc4Vmvm?=
 =?us-ascii?Q?DXG+q9m2tlg0QkxjgRWySGwyTeFKyPAsvp5m2PJfkF8mV0oeWZyQZwrSJ9MC?=
 =?us-ascii?Q?xURRWs77cTAWp1C6gVsC/MFvOpkgJIu71U/lxrvGeFmjS0qk78VyDZoV5Sgg?=
 =?us-ascii?Q?jZ1ksUR+YrUtkpFfcACSu9lS6jWphGs3CBxcVtbaMdEh+1DoNO0LyV+fnB4Y?=
 =?us-ascii?Q?TiWBXhKNmCFCAcGPsm3Mwc6yZfTCkFDTrlvyzHqcTOHCTky8rWtQ8NE7U4Q8?=
 =?us-ascii?Q?I/ko1NdD9gAbEX0uZhBuTehWp6g0fz0KsF+gS2RssUF2/885WGu3zz6Y5eMT?=
 =?us-ascii?Q?x8/IbrbYOKlqty+hnMbrg0KgesliTTKPiaMvGZ3BOMtFcYfm6snJSOhIt4g5?=
 =?us-ascii?Q?atCM1qvA+J+EWgcbHc3xAc9RKrhhHQRnSC+oKWm0LdqihGv9RrcZYTDX56xD?=
 =?us-ascii?Q?QzLQYmxdPtAHi76BuyvyE2iDSxRxZliV5ksaKfqlCEAXb67J2eHWyA90FoF9?=
 =?us-ascii?Q?hy8/Zw829J1b5zjikhhV7JdXShziSiY25clYMopdTxAiTNDe0KlUerX01bAz?=
 =?us-ascii?Q?e4ru5IRg/d1b3LO5NNGvwKfXuddNV0cyaSJb6/+CP1P60YRHfgu1bACWRXO+?=
 =?us-ascii?Q?hCw=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bde284d-da12-4ef5-630d-08dd9dbaabeb
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:38:43.2907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7904

6d1f198f34 (imap-send: fix leaking memory in `imap_server_conf`, 2024-06-07)
resulted a change in static int git_imap_config which resulted in cfg->folder
being incorrectly set to NULL in case imap.user, imap.pass, imap.tunnel and
imap.authmethod were defined. Because of this, since Git 2.46.0,
git-imap-send is not usable at all. The bug seems to have been unnoticed for
a long time, likely due to better options like git-send-email.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 27dc033c7f..37f94a37e8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1316,16 +1316,16 @@ static int git_imap_config(const char *var, const char *val,
 		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->folder, var, val);
 	} else if (!strcmp("imap.user", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->user);
 		return git_config_string(&cfg->user, var, val);
 	} else if (!strcmp("imap.pass", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->pass);
 		return git_config_string(&cfg->pass, var, val);
 	} else if (!strcmp("imap.tunnel", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->tunnel);
 		return git_config_string(&cfg->tunnel, var, val);
 	} else if (!strcmp("imap.authmethod", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->auth_method);
 		return git_config_string(&cfg->auth_method, var, val);
 	} else if (!strcmp("imap.port", var)) {
 		cfg->port = git_config_int(var, val, ctx->kvi);
-- 
2.43.0

