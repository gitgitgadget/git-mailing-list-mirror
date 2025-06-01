Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010002.outbound.protection.outlook.com [52.103.68.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C690719CCEC
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748761945; cv=fail; b=PCw7DfRXVy0Wri2pf66YhLFbrWFEUueedW+1ML9csSmG6WP9YLrsf1tQ1F6fAcWq/3p4tGuQvyXsWODskJKPKoJxZgFgcP4EZbHroYzGwYQReJ7H8wj9+G43D6KGYcoisSKm5l91B385yx6Ayk4a2w/xOaRqKyiY12O4WThDZ4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748761945; c=relaxed/simple;
	bh=0qkLsa6Hn1uIEgFxjY8EB+0RoaVEWMwlK1jnzIaZF3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nQ4bS2edJFBl4hyTjqQcEn+1rLdG8kSAZU42zuJLFr6+I8JXTEQJA3R3ln/IvjdQTiTw+oVub+xVtO3V7i6AsFXDwe2XlcrNUl4AadKISAnd20Q6Ftbtrhhj8lk+b5ZXDAr7uF0jLcx4cnJ0DDjJ2iPECq2g94elxrR5yT+mqJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=VHIS3aVV; arc=fail smtp.client-ip=52.103.68.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="VHIS3aVV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QjDOQnBxNf+91kldVbDW/938Puv21UcUj5BTcKOGXIrtmdvnuHmsn/BatcFhJZi6mucyhC6/G4Z1tlXJteq+4QLlYm2WubQhM3eBv+UDN6Nl0PrbXkCG5naF4OjluZJAPrLIPe/z6wYfX8Z6ZHgtphvmLu4rGOVRAMCbiO3psLcKqxjXYSOFoTgi5wo04pfT+J/Cd6PvZW1WNDLVeGHkj6L+AsJZS/mvP/uNPmVw/Ys2FvjzcwDnV/iIL6we8qmVUXUUNVZHg2ucAPd0FMx1bpPjzPCC92SZnxsQJBC90Ett5Xk9bnI58UIBMfDJvUJ8qH+wBiGAubI1T8iiZLGNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB+Pb5J64O3eG/JOTXIPoZ1ufZmBcXXoQrDPwV+qLhc=;
 b=tDjI9uKSzS6B7GeL82oPkkO+FfYfCNq+OnJjRSpHhujTvlmt57M5GVKsZpqW26Fu8yCCpDe6bBnvwT0HgFAk1dJMhSFu3KnxwG7yRMjK3iJiqyx8hg+hE9xPKJmSo2d+YrAjkzQDGpJuoefDFKsZUBFgLP7TDxgsSjbpb/f+EkAqfbnO5r/Vmx7DLYcN3fPv8DMJ5SJh4kJvGexBBPGn6f3ikdV06UVq8CYwZAo0YJOHvoJhLJgBM81A+8oErbp3lN7X/UU/ScXowAy2XbM0qq5iy62xcLjVwPJfQh4F0hZvEcwe5MHNjYMWy1tecL9XWlOewhzS3TVZgCfnuJNDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB+Pb5J64O3eG/JOTXIPoZ1ufZmBcXXoQrDPwV+qLhc=;
 b=VHIS3aVVR68xaX3fjH/IoqywfTfWCxyR3kRKI6W7FuWE9JE/ZTO8UeCNMIr8CDh2TbUvyV78O/TF9gKYnSfSnSaOyO9RoW0I7FFWIi52YotHQhewiW/+/fHAj6rxtaxlnxURLG/8e/tMqhO/p0RVjU+tsGbQBiIu5QQn0VglC977/TPNrWBzVMxel9kcTUSZ1inW+Q1ubIgrxb34M/xTvyi82jfriG+WXJR3xLRgNFvtwQ/i72j9m66S2SqfeEmtsSiSa3nX57WXnyA4/DTPdQYVytLqQWOwfy8PT43AkfTU2jEPZ6ZBRunzdxYbwaJVQWiKUE/3s6vco6bJQSyDHg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sun, 1 Jun
 2025 07:12:14 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 07:12:14 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v10 7/9] imap-send: display port alongwith host when git credential is invoked
Date: Sun,  1 Jun 2025 12:40:33 +0530
Message-ID:
 <PN3PR01MB95979E9E58704262074EE877B863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250601071035.2412968-8-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c41355b-f41e-40b6-e926-08dda0dba269
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgni4KszE9nsgeL87TLIH7/Jv7/riJkbypHMDUc9K/pqKZCARtzWOa05kNd07JNILZa0XHCKl7HNcdxUrHPOoivVVq+KyQjCZIRcNV2mltTngZewO6JZRpedbtk5bjAJrLC4If1pYE/TeoenxWteFBZLnE89k6Gg86Vw04SRQgUz7sctAER7o0eU/BKHmizldbE1/tLp6zpQMexrmKK+JbTlshJfj034XeY76OiD/0I6XlJMTWA4o7PqayQk9JvSu6htvhayrdDB3l8OamyfMlUFkPzcUk70QwI+McZUMj4LlZGUU2Dq+iVhIWe+nESUDs+on/nd40c0rRv42mOrtgQWi3bOW6+rLxW0dvJg+dqsPC7hN+VueWlmZ0anu1VjfQaRzC2iZ1lPKUhdKRXyyWwtVhLtuY8ESS+GEmXerrj5KhmjYDuPcmCNV1WZB8zosnSkNYFF1AbXf/CoXAGTpaJkMN6onJOB4+twP1ukyVNgQXwtDLIYmiN93prxGVXqtmCRpGhHQiO//OywcrBSVkCnFHEH+6hq6DSm3QLJNxdLIC61hd/tF7C1PnWxcVh8xygOQkA01qpf67kpqJ7wRo+Pue6zWjvDh1OY9DoJ55CTjA/AS88shsqP/kQh3W9g6yxijoBF6MrFdIzd5f1GVPUbvkFBlYrEJoRj9bTlC4AtGuQIjj3vTWaJXNv5I6mPylOA3NL90ynIZsjpwDdb53XxHbnQ5jdUxGjzxdEgzdSxnI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599006|8060799009|15080799009|41001999006|19110799006|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Db34+S6TBn+QqtlOkbnBvZa9LYbYol/FUEY21bgVHn6yUvkZcvGDajFt4Y2+?=
 =?us-ascii?Q?Zs8axYD6XOcZm51BpaNdQJUhFnMy6gbQl+8VQEZBiT/LwSVlJNWpydpgHsQ2?=
 =?us-ascii?Q?7CRTu+wvci7ozcI4LAc86Jd0hQZUHSPBJS6LdSLqgKyWYnYgk/5rJn5wnWuA?=
 =?us-ascii?Q?5etFHGv1gfkXsmbrVF9R3I5+rwSJwwDliepDqSxvy4J9rm24Zrqn1RhmTikd?=
 =?us-ascii?Q?gKtuXzINhigZMKAJDrYr5FfaNT3+uDNpSOVcaAt6Vf+Lv/2vygREUi9iz6Bh?=
 =?us-ascii?Q?7KShEH/NLWNA219ufTbwHSmwDlJ5YDu3N6AF9b6eoiIwhLN31RQ7MlFcsGXx?=
 =?us-ascii?Q?mb2SwbXMwE8yECzVkSnMj7nO65S14SAwdsqoBVqjYsQoG3fjYX8TY9J17Qkg?=
 =?us-ascii?Q?Dc/jW6Z5mxqe7+cOawMjS+RL+E/5ByyARJpKeUXXR//RFLXIO+Yk3Q2gR/UX?=
 =?us-ascii?Q?iW4NX3EpwdIMOnEjsMPuxlO+AqDf2wPNjbOAXU2338J8kW9buLFD1ljTf9Ft?=
 =?us-ascii?Q?eQelMF1v1IsTJQ8KS9Vhq8+0dFv+SiZK8UUKWvSHlBsRsbSTIu4otFUikybR?=
 =?us-ascii?Q?7h4cttYtsMJexyZpLqp3UTizSImZYtfcM+ONyyHJ+9DmUZhpPeMUB5id6LKw?=
 =?us-ascii?Q?FasNUOXgYCAsqW+DZXQbdJfG5VRuyzWv6ykuXzM1vrfIDU0DDMT1YWuRKEN8?=
 =?us-ascii?Q?ZnqtqOWbfJzo6A+ybfubw2IG7KcAsDXW6FuSGQ/lx27OAEf6MLrs7jPIHY3g?=
 =?us-ascii?Q?oNtv9U4G59VUtJ6olRfMvxTj5Gw+XZhcCd1i7m/WU/MgV64KmbvxXnuKUhSh?=
 =?us-ascii?Q?FnZtlvWR6NaPVXtb+FaNQDR3zxCyYajLd251fGZhz06JZs3gE8iWwpOOFBIA?=
 =?us-ascii?Q?dGVQJpom9c9HiJA5EuSDPJUCAHNil8v83q/PJ+FQs45PfIL+PJh3ReqLgKfO?=
 =?us-ascii?Q?YM8NjcT/4ua5Y1fr1xzmNxLYodOAU3+ErDvfdPHVD0pZxfYGQiu/sdrgNlRU?=
 =?us-ascii?Q?Bzp52gNcdcLJkOqDJ/woRDyc1T70Zr3vK8URvYnhgZlTXO70m56Ps6ELSrMZ?=
 =?us-ascii?Q?fo74JwgqdWUO2KiBOYpc1jURJZQzPPw7Y5fMkJ0ZPvSQZku5j2wfIiaj6QpP?=
 =?us-ascii?Q?5ZKVo5V/fG35aKyVFbPe/3c94quHfQ1WUA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HvGMPytQzb05GKHW4eBvCqdZ0aCrvNOfjTI0w8hYyrOBekD4UTiMZalx2H9l?=
 =?us-ascii?Q?ItH5/ad5UKwPFMDmM3IdCw8Ddyj9wtYt9B4EPV7lsCZZEAR/0vNUKA0Ue8mz?=
 =?us-ascii?Q?ZoccrGjLnF9ZR/q5E/DapHryRtHTsCfoVH/vx+YGYRDkd1JEcGSjnwIKtaeG?=
 =?us-ascii?Q?lTCHfgITcOvVq/fr7gKrIQdv6Ra/SKdf+vI/uacVOa4IPivPNiDGC0LSWWHB?=
 =?us-ascii?Q?MJp54PFf1v7QVNBAkg5NS4PbH6EOatgBB25nbaLbKSelNUDYvZSuoIBfTvkp?=
 =?us-ascii?Q?QfS4Sqcsplso9XA0gdvy6tk/oCTTHIjPr0XMRUiVvfKTLQyzqc19wv82V5vN?=
 =?us-ascii?Q?Cg6Wz8W4cBS5+TAyG9TpKWRYh2a8M9Oi63FHPLPrznWT85TXAMkVR9QDlFNm?=
 =?us-ascii?Q?iAWrPRczqslQw4TVnGpgUK5GOtPK8grRoLAC3Ao9WPlUU+9jCqtCwABgp9XT?=
 =?us-ascii?Q?nAuEwnnc3PV0kjSLIXzSFFGjpAn19pq7xdy6UYMZkBzkgfAPTwn08Gp2a97t?=
 =?us-ascii?Q?liCfRiIv6G5tIsIiwhgk87J4C3jOGabn4m7ASbpSMnZhjj+oM91XJTNjTtdD?=
 =?us-ascii?Q?S4t4f+N2d9SMbOYZZgBfcQbhLM0St9/0DIR/GHwSg+5In51C6Mk2uD/0+UR2?=
 =?us-ascii?Q?bsE/Q81H67vWpD3BOnK1jJrtyYTObdCzJOuwY7QlMQTODMutfH/ji0LuusQF?=
 =?us-ascii?Q?IQPL9ZTufTD/ABMBVkj7W7StDaQnVA4nsFiFmr3VCmYuB9UgkdUsqne/IqHN?=
 =?us-ascii?Q?y3JdjPt96i93OVn06RlSFDEkqhRfd1EjBIfMaTxG4+3znw0OpcGAGcCYVyWL?=
 =?us-ascii?Q?koK8tf0xsCzo/F+m5PRQiMMJc0kdJAWWtONn0U1F9UeSHf/niLreamDiJ+R0?=
 =?us-ascii?Q?UnlYsspwpnofKNAKoy9DXNZrekCURUP4KVcNinGP11EwaKBtQkNiWLj2hoQQ?=
 =?us-ascii?Q?vzSx3Tlj7+H7C9471IZBAn4lLvEa780ZaJ0BApOFd1DsgpQpiIt1C0LKASfV?=
 =?us-ascii?Q?zMojiJ/R7B4QmzG/tUYBfKpx4U4df3Hbedb3sVDTGdOYDjvkbrhVFbTA+maO?=
 =?us-ascii?Q?yuTeXNJA6XdB933R66WVe6N6GJeT9QONIy1OwEcA+8js/areBlCNBJPlTFH/?=
 =?us-ascii?Q?uERjF+odFlsUNODxrxaE3PsI7NqbQA8/mvVGv/RFiDV7u+77IAoX6ghkUK5B?=
 =?us-ascii?Q?KPyl7vYCjfsq11meM5lILRRKr7yUZsn9lDjU9Z+oW4F3sazAIXS+/WcBJB8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c41355b-f41e-40b6-e926-08dda0dba269
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 07:12:14.2353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9108

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
index d791cbff43..3ffe3ae5cc 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1107,7 +1107,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		return;
 
 	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
-	cred->host = xstrdup(srvc->host);
+	cred->host = xstrfmt("%s:%d", srvc->host, srvc->port);
 
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
-- 
2.49.0.638.g67a2d115ec

