Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03076205AB9
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862044; cv=fail; b=QhIUxNmJElF0jMhBbEA1Ar4R+FNc8vLonfCP09WjoQfoBqk8h+vEMz0+X/SYTENtFTRqOz+IPtXIK9jE3qO4ykPAJXx9tsZW96WJMyAHWO9Jzj+sX2ZT8ghfJ53SQXWe5mgbHP2pwD5hYOV56uSN4j9vfg5XI7NvLGiIklmgfuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862044; c=relaxed/simple;
	bh=jrYGcZXCL/IzYi5wtogjfKKQk5WToo4x3okZ0W1D1Lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YwMT5mpXc8/7B/FmNYDcQxwZiUVpnUGi84oBfPeu9wtSxwiIglQ6EifZ7HZl3VxW6MmSvkwIwF5AbXApjOeiqhcKanaYfV2Rk6EC0eOSMg0X5Xsf1sbOzEwyjz2tsPSQ5DDSDmiFGlSnTGH676UzKUKgFd6XtGrl9khWBh0XRTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=etEVefx/; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="etEVefx/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoUufSdmovEK7e9emSlloSySJmD93WqaHwSB/3m6cEhuU4hOVmSKL1QawBMMGXiM32776AGecaKTl+E2AHMo/Ro6vSEFXcdHQTc9cGugw60QnMIjlSUfJTijKEkO/UrpAlwBgqcIesslupsVuoql/nGV5fhRem52JahxxlyC7b4zIZLnCRFujhuwgXNE5fWHcG1UJsbsPYG2bSrtkEbeP5EC9CUtUSTjADUBSXOI/mZQbdG1v70bWZcyfYcTxgiKNrAu43ryfAZvlYmIBZESIx/mE32DfNuREasEl824Yq3UsLUHQ8l6juBTVSwxAo9X05ktJgj17aPlK1oa0vdyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDMS6u6tYLWjYfdgDXsE0tibB+SRe45mpC4aDB29h/E=;
 b=n4baqTWuhooiUt1e3N8GLeuavMzSCwqkR/YK4d2bgLzW5OszzFAX0XPE3vODi7EO5PmPRj6NWacSDQgt7R7QRjsEUk3VJr4aAJh/aEbScDvY8tg+W7btx1v81xndH5nN5Gu+MpkN65Q6f+X53P9/rzW1vWoSXIjQKiNT5PW4b9wpmEue6kUdVjCOXtUZtfl8ZvVjF6/dqyR2uL5M4pD2Rm5VX8V17MQpi/BSeUkKWQh7vbc8/0auPJIYErTZxOOPtF75gmNDW9VxWE0KObkzEv13s0+a9qQ/o9SF4J/+EdvfQKEDnbjYjPtJK7kU5Ew3jf9+mNzLAoL2amjarDW2Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDMS6u6tYLWjYfdgDXsE0tibB+SRe45mpC4aDB29h/E=;
 b=etEVefx/GUii/CY57VsKEtu9RcDQ65NrZ0IzSIGcH4IiEn+4gk8p6jDguDNc6BUQdw+42V/SoaA80IN6W3adCkF7bF9nlg+R4YndDuUcJwZ2v8Nf5KuZf9nIJ9nx9yYDyw6Ydi9iOwQghw4UanuA56eIMA8XB2uJ81WqpgY3SMEvDYx6iI0ytDF8LLi7NXwSEmxu6+I6nd7I5ghleZjD98SPFwsGVkLOmCxFgxqGtlBnhuy6rwO7Gt1t4YruhT138IanC67uPhHvW+PwZIVqGrVt/GHsLdiWG50WmBn7032CoMt4XSbMVdTN0jQsXeJ3Y/BC8HoIU5gJIjhBVhxSxg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB8176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:00:31 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 11:00:31 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v12 08/10] imap-send: display port alongwith host when git credential is invoked
Date: Mon,  2 Jun 2025 16:29:39 +0530
Message-ID:
 <PN3PR01MB9597A414C65979F459895172B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250602105940.75439-10-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: d4113340-b600-47f6-6577-08dda1c4b0b9
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrN1Uple1Eat7kdR7nOrSpOl6GxWKg0bdvA9YQm5XK0bHYJ59TOTXOkdLAu1SPE77VI4dwyrhNpb02iUq7SJgrsia4es+FRtX8SfZtYDSg6b2tajWXZ4Ct9r0G523EPKAd4rG3evDr+eBeZW8AqEru+iKxHAmMNa1rA9DU3uAv3xOX76BCqrC0SS9xmc6/oQAYxefmTdBLl9KfEEZ4kfv+7MZMnNnQ6W7QCQ7q1gBt36wsSmEfGqFg75fVp0vxqiyZyWs69WZYMrTBzTeeJWjIBjIpZed6OFXzpPjsrFGuBeuZKrOegf4P/uJuqm6Zq+5q/apINlJjiBHcQTJqWwm89ix0u/TwP9NN4oiHgJW+N3vkFQF4zUZ4sGMzDdCwZZtWX4vAtIgCwWZg68VVSf/yNaCu0+UVa/nCVNrall1OkLADWmY7q1i8x2MpaTjdH8YxDmgfegozvpQrJ4i3NGsj3f/bHLMa/GPp3egraWEjQzK5b42sNbH6ulhqzq7+jW9Lj6SHbbIS6oLRKzd2gCaxRsePnyR8ekydqYwE71ndzGnMnHOD2mnd0UheVD3TkHItBNc9ErRosDqo2Z11psyOKrtKCmp+AfYA2atK8xVqp1dFGVFO5ghe3Gydx4c8H/tlyv7eFHhJHw/EZnFgwryZFnVF+5+1YCUKo32zIZRtUOT0CQclx+L5tBjcN1gJz8puwtPWMgVbhpnftD0oE+gSycELKJwN3u6oPPa0TKBRjYAP/Dj+s8s2nx/GZEXHewpKA=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|7092599006|8060799009|15080799009|19110799006|5072599009|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e9s18rXczEDZ8QVVuTz4QSScy6U7BJpTdeoX7lLB0vQdGTAzSTPEIHZWVDY0?=
 =?us-ascii?Q?oNAYBzTKcpeTA2+cexO8UoBj6dK7fK+MB6pKyhYo2RUeKhHJrIAmBUMAGudD?=
 =?us-ascii?Q?TdMH/K7blITelfVcBLQTiukHcqfO4zRcG0ggca/NUp1M7hlnHXEMPvNi1Vj7?=
 =?us-ascii?Q?PataXzgOWZhwpraSjMq48MMouCgwpJm5HJpRxGD6HVlXMofdwPVu1Rv7h3QX?=
 =?us-ascii?Q?Q7iI2Ot4gzUm8Wwvedw4tOsuFCKqxUN3Ew6+vfr66GjY3lqv0iLKgksINqn1?=
 =?us-ascii?Q?5c0Af0Fk0bpUS7JcUOnR4MpkGZrI332e4oAS/eXa3Rx52aidY41FJW6luJAr?=
 =?us-ascii?Q?Xd+yC+3SbdVvOzKiKTlt71Y/bBC1CxO4fbGz3wrFcF/LokAtJLUhjrpiwPc9?=
 =?us-ascii?Q?Fmks0gWfUHq5lVjyVtyW/6eSHJb6jvKVq4Th0TjNuqtyZRc3Gg3V8wyGlEHO?=
 =?us-ascii?Q?UehEairhwdi8/90ftL3kYhxw9+QFNQTvLMkkRcYf7LM81VqtTIO++Nv6gvph?=
 =?us-ascii?Q?yV0FhtQmythmzzl6nG5YlmCwXUE/mqg9mU/3ia/hyKIwf0WWGd2D7bh3hfVa?=
 =?us-ascii?Q?58iXdZeQnC9e+EwbVAjwn71OTFlXeb6Am0ymGYgFGEjcQIVLJGTCkY38Dk9C?=
 =?us-ascii?Q?i1T0aucnrnXJCl/H9/TUPPTXb7Byi3DT+ZvlKlsm6ZdjHrLZ/qDrMsGX9k+2?=
 =?us-ascii?Q?dCKVtDXXigHHTb3I7sRln73KrRZ52zQZxMuuQSwAYh9WDj84fc8xfa3GL0T2?=
 =?us-ascii?Q?ST8AIYzay+hpdx8sqyAa21RVD+jLd3MJEfZ2fhQ6Zk+APLxAwAQr4apYTfVM?=
 =?us-ascii?Q?fwRV3z1fSmc0fp+3zPajqIWtETdvLe7/kuP7zGeQGIcGiVFcBSC1o2TwN8zB?=
 =?us-ascii?Q?8QN0LbHveEtLoIs0N3aj+ubvN1oSh8WKbYFvC75u5kENxujVyvhUnxgOynaj?=
 =?us-ascii?Q?Hybng6UEOoRTase+ZEya7VLCR4VLL+1ch4+249anXtawo6gZbE4N1E9REbbA?=
 =?us-ascii?Q?EhNw7uuwY8piyPjZaMMI5UokqNe8E/pq0kETYOrzlpkmQaayqFy3KqiByL8c?=
 =?us-ascii?Q?EbvttH7fVll2pCr2I0JuvLtKLBidAijR12k7gR7OEjmaixcq7iZMXCRP2JAk?=
 =?us-ascii?Q?qAnFwdX7QKdxNQsxE0m1ZNT9YQyigOgZHg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KgTbv1RERvd9psvcUmWtCpdh0o6k37z1kYbfVp2mN9wImCbEyhN2FH0/d1CB?=
 =?us-ascii?Q?lY9cxP8owwIpKeGXa5SYrkPID/ibWfvoCPc2i/IpkuUVKVJC0LL7ErDR2x88?=
 =?us-ascii?Q?ZaPSO1+SdIsBjh9NBuz55A3KG18AtFwVJrMLyj2R5/4tmmgGjmQ0A7/8bfWq?=
 =?us-ascii?Q?ICvDhTYfC1lSeIijgRE7zg8AqzivCfvg7KMknQe1VQSpU9ixItMpyKddcqx9?=
 =?us-ascii?Q?1h2zIniJjgGWmav7Ehc0X7F8ddXgYxOqeMltYxn4DeFFrsfnaPPKZ+/swjy8?=
 =?us-ascii?Q?/hwyBBp2u558xFWGJJyZGhZeaLMiYNfch7YIDdoslaE0hzaTH6jfzixURJ9Z?=
 =?us-ascii?Q?IHEGphfWRhw6BS5pmIl43nUR5LG1XHNs7WLH/N7rc/AlehdJ76m8W8b1RnHd?=
 =?us-ascii?Q?T1pESrWnhMhiPgbInHvI9g1gtfNL6DatXEWG3U6Qdk+AYdLdaqyOedK5Al81?=
 =?us-ascii?Q?O5RJm+XL68YB7NgPiVMywtKUx7+Go3rYQcU7J7CTBQggv28lXdhgLEDwX/Nu?=
 =?us-ascii?Q?wC44MPqVTN9Gn7V0lTZMUDoZul5s84RBrRKjuF4vhdQOidBE8lnGFcLBO4Ug?=
 =?us-ascii?Q?Xt63oLsSAdE0GZbLRcbS8hShmWIwqDoypDTka2hBWpAJjFWLJhccdFJDbPcA?=
 =?us-ascii?Q?TitvmLTAjYrBPMq9PcUdfWfTXj9oFFl7dZ9VumWYfD54Lacp/DwgQWGlDaeA?=
 =?us-ascii?Q?yEWe3J5keve1oKIKe8WtWg/f/HHLCb9NSIQbV7RD25FMlXoAfE66XM3xtEND?=
 =?us-ascii?Q?Pm2SrJJcJnWpL4LRuXH9NyuRvpuAXKAp9efCHp4ujnLrM7zDz8t7JTtnKvGI?=
 =?us-ascii?Q?gGIZpNN/9fQK41wjO72x9+5ZS3em0emVRbirTz6yh8U+Nol5r1mgkoQKNe5m?=
 =?us-ascii?Q?mYNh2y4BSUwkKfLSd8YToOLDbmXQVpuvH66ls0wncQqoZnzD1Bk8VS4JET4L?=
 =?us-ascii?Q?gtjmUSFIHhMQTT2vgO/9LcmHKI0ShYvrRLphkI15+0CHwN/UWJXoMyZ8cpSU?=
 =?us-ascii?Q?kj/BpEPaz0zWH9f929RqGFkKBOdFDawDj8QuSC5VIozm9j+eQwczkL3kaYqq?=
 =?us-ascii?Q?6q0q9Mox5UHM754DCOuCcSA2prfwV/neeTlY5vn4fUo+8ekfVyhWtvV7u7UD?=
 =?us-ascii?Q?TnXW+3ou3M6WNMmbDSIf6zLXU52YKzdlNubW4PdpaFFceKTCtK6WQAhB3avF?=
 =?us-ascii?Q?5Scxjq4yegp34OKU2F1OtknxAnM6JDtoS4tSDhZGfZg2rf5sWoKTkTu05BFn?=
 =?us-ascii?Q?Ws1K/5Mgs2bfwacP2i3FRmaV5KilrqEwZKDUGHSjyaksFkYDlvxRhlcl0X/y?=
 =?us-ascii?Q?Uxic/FHyFiMFnmlPlaSV6mm9?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d4113340-b600-47f6-6577-08dda1c4b0b9
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:00:30.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8176

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
index 3a1940e4a4..61d52878c9 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1083,7 +1083,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		return;
 
 	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
-	cred->host = xstrdup(srvc->host);
+	cred->host = xstrfmt("%s:%d", srvc->host, srvc->port);
 
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
-- 
2.49.0.639.g36d50d01f0

