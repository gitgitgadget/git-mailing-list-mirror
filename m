Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C091DE8BF
	for <git@vger.kernel.org>; Wed, 28 May 2025 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452711; cv=fail; b=OR4NJhniSDG9oGbUBF7rVhv5i4uQPcjgEF07d8/5Ygv6Dy3JZfA9oP4D+b5fCJVXNif1rrkVmLsjOa+7GuNtD0dpy0BSd1GSbSn2Rk5X1nlxstMM7Ey+M/p9vi3UHbTO0+ZEQTllti0PTg/CoXROFLzPpCEUcuB8F3RBRLykRO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452711; c=relaxed/simple;
	bh=n7Vfi4iKUuSGlGhG6tNoqd6UobFKERMYH3uDjmdWync=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CokZoP9/j1hMrcErSNXYQnZRzztzOUcHqqM7jBuVAOx8lLae5AwDms672LgGp4qlGL5oPsGyJuemet+fbRzlMzoMVhtRyG2M9J/5DKJc350PMLos0gPLV6NmHjE3ik8p7aE091MzgfCYN17oUphy7t7Il11Xzq7AKT3lPsFs8NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=nxyFPmft; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="nxyFPmft"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaskubJFQSUlTCQr4EIMFf9w81E0JpupgNmfRm37Dm+qjAEhZ56jcO+Wg5axeXgThaL6+J+qIBe0TH+UfFVkHNKPkoV6obhgJsqjQo/H4F8tPUzVX7VEwgbOPNBBAgzYbkU+qGsPZyJQWzoDxUvI+slwsY1XW7CAt0KVNIe6M7SORtAYw9Lz6s6FrhhPmQSE1isL6OMU1ARrdH7uR+Q1goSiKfJIDHDYauA6PsGdRD4Z0yJUyo9RcYMaXHVU2z4wqfxsuTGW1Nx9TrZJOcBpLmzt89VAZeDObS7RQt/j0Qc7shqY/EWBBaF5DvQxr+phJy54XW++d3whF3la/xfj0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpbl+hxcym56JSdKzs1tLjiniYERvzQjzHBVoUPKHUI=;
 b=Z2h086gGwIJDme0woMTFiQ7aocpMbvtSJZKZ8+fR32h6Uzz6IMLzjW9KMKGetOGRTk8uHQyir+YahjN9jdqsHo68xgG2/rrEMsjqsacIe0wVsU0gzwoK9rvg8tH5SiR9nj02fkgtFxnfsGow3CwPc7xfVL4/V1KaKp+ru2yjWb29xfibPReOucObpXIILT7g1uxMxguUHOwBD8DPT6R3ptijs+A33n+ZvILKbC1S4JJrD4WYM8DiL2zYE4nk8PG6ElpWvfUDzbwetxEu5q3/ZycXTTO/Bg86XleqWWkkzzs5rl7ShaeJpvJ8yi/zQP46UL4pwKLUKzYrRTNzbCG5Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpbl+hxcym56JSdKzs1tLjiniYERvzQjzHBVoUPKHUI=;
 b=nxyFPmftDreksJt46t2JkqaboQLgg1hFYDeDDaqKgNuILv+stkMEEbv09B7HAohaKOhISkKIZdKddvxnbHUiMDamBCTBYN9dnBgZQtrgYTpwCr0F+09fjuC35kMr5t3HZn8HATmwxVIRgsxUdbYnEGPMnvUwVy7vJjUClmy23MwiU8yZn/H6VvHxxrED0lRJPz0kcvBIDPd0GlbTgY3U4/VGAYlKEcERP026zbI9cjz2cwthCMMWeYPX6XZLtjy8cnP+e9ejclL7UYagED5Q9co/PY94M/vjw19chv3a5HuDE8C3AZ8fkPye38rlz19E5390SjDR7A7lns0DgfOclA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9864.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:18:22 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:18:22 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 1/9] imap-send: fix bug causing cfg->folder being set to NULL
Date: Wed, 28 May 2025 22:47:47 +0530
Message-ID:
 <PN3PR01MB95979D54753AD690BCB4F092B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g5db5b64a3b.dirty
In-Reply-To: <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528171755.90367-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 5613a00e-cfec-4b07-8f0e-08dd9e0ba5bc
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnpXacx4mG+8CjKYrijm3xLdhK7MQRuoSCWw8QB2aMthoPVROtnjyaLUo/OdA+lrWl+SQAHfozF0ZcmvfglDh9FSIGYC0cEEapG0fDabQnVg1G21Im7VmRxaC/Ak2ucmW/FjhX2U7wrhLtSMYnkpEh03BkV4jb46Yr/PO+IrUoSa8OlBAM8G0O0NTui06dFDvi9t4dIRC0qbwt39yFLa3oKofK1XZJzSH394g6v/2gK9HUo7ZTBy/CK5UBpR6C4gq0PjBl3t+XZj0KFSMGhUjUprjcaiL0NyWIoALKPt76oDy+WJkmLPcMjA8lbJ9Hi4rHCe0eW0nWSpb4l5hRQL6eWdLhP3/z9dWfvAnLzcyMDzgUBmGQ1FhBL0uexXkdbm1bedpom/ojgdBjX36wjxY4h9/kEjgrwSX64HevIadT1/UlVu/pQ5rMnANuwLwxw+2SQM/5UaVu3nkcN4nylYmtHAEKgkfGLdpopu2nZYfrYNez4ElXOxG7DyfaFKe0TstlHZQmHEnvfJZpPCi8n19QCl3Uj6z9wUffw3B8H19RO9bazsT/7kAW3/Wlms37k18df/lrJ/4b9qoVKZrGNidqVA2oBWynHgoJhAQVNH7bwtPO9fk5VbquNUpgHo5/kTbSLme3CWP/+QhvXue/tV9GKYhRZK+iFoQXdpmaxIyF/m7/KTJJcSd1ASCMRUXiaLrzwB9OncTq1ThZJBz7wpRhq61R2t/catIWKsYCT5oaNA4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|15080799009|41001999006|5072599009|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IjGfMNFdISpN7Mv9Z6yAwJ6jUd38bJ4+IWeV2ONf6B0agnl2ZRtVI9e0nq55?=
 =?us-ascii?Q?a6TS1v6vy3DqKQDXGtv2Z+bcrQ+H8UfCpWI03QrnjsO1CIDT9PVpt4x0xX4u?=
 =?us-ascii?Q?G7AbAnjKvHWihe8cxutirbIfN7x1gq4fLuULwMdvTbSqAHAgB90AxlYpSUx2?=
 =?us-ascii?Q?soJv0MNUXwZ7MSUKK0k8hp7atfGKf6FIB4lE3Exm75VzKjUji7x9Ji+3YkU2?=
 =?us-ascii?Q?9gwJp9EyyShuzTLkS2jq1Ghp0pEkEZhoc+uFFzWtrqPhz8LLne2toB8bafqC?=
 =?us-ascii?Q?pyO9qlwn6RQ9pHoUYPzRGPrzQUAXOV4EYe2eansamdGavocd97Gn94+TJgnU?=
 =?us-ascii?Q?JYvn9jUKk6qL36nXBP8A/QL9AL9muvCHLFeZtfrO4GLZHVBd46IIaA2XZQNS?=
 =?us-ascii?Q?praUAxhHtKJFGeVbJ/AoOVROBE/ihp2GxJ+hBqbnABKkQR7Dga5vi2/qMLAT?=
 =?us-ascii?Q?CSSy28MFpvK33Xj2aWD15Q1pWz06fxJe+66lcJKS2PnDSK0LiPYuqFv7KUv9?=
 =?us-ascii?Q?defnDX/KVFy49jBpexXaKhBpOmJq17AmFLdgg2ZBVQoZoDgi3NNjH7G55ScS?=
 =?us-ascii?Q?P8vVuK66lwJ2N8XXQelyP86+F0DkoRzuv8wDE6UvrfyrGOni6nre5Xlz293N?=
 =?us-ascii?Q?GfapUoh0fUjfL09EyhhqaxBs5oneS2WnW1+5p2HRN3STKaTL70Lgwq4d07cZ?=
 =?us-ascii?Q?Ah3KN0zYELnyEjakE1pMS8L5tft6Obo6zCT6aXEsEkdwWMGyGXYJMp66oxuV?=
 =?us-ascii?Q?vvviPOwsKiuEJ3tB5EOb7m3MDalB/0yMl4iaAz6vEh16I3MfeSJAau6KN1uN?=
 =?us-ascii?Q?OYrhRG5mU0aO+JdHlm8ZvgPOyqExBblH+0rIlqdRbLo/4m4WTGt4Geus/XQq?=
 =?us-ascii?Q?7Gg/FLj/bYS14E2i6F7JB0Fy1Gs7hN9hKHWptomuwtf3pjEgyC3kKrIDu9hy?=
 =?us-ascii?Q?mEERTAYdxjWkGnGTWQ7fkUxP819dpqX6okQit2vsZJcA3xgx+djLtew8YL4F?=
 =?us-ascii?Q?+sqj7ACogLCbrUngTV9sqAhuP5gdzFt1yGl3Q2FKI1EyH7hFtKRC+7LBy7dz?=
 =?us-ascii?Q?4ArJaAva53RF+RBtLuYUbGCvHg/WOfBmYnx9cnBgsL94WlWYVCqKc3jtfabk?=
 =?us-ascii?Q?W1IPFUg0GTPlNILFpqFmnUzgD4OjWUYeilUd9SARnu4VDRJW+t67y7k=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VtlaVXzyobCfC8m+9LEETBlwWzhDIZoE+qgxPViSCIf9Kch9Gl7CEy0Vs8p3?=
 =?us-ascii?Q?+yF1xXOyoEZ4m0km/9sdpuqZ272ZCKqwhkf0EFhFYjyju+ZHiRyueFuxdDyX?=
 =?us-ascii?Q?I5LXO5Y4tD9oz2NjLsjyUEZBrdFM26paYQo7UyCFtNG2fKzeHw/bKTDmI7vk?=
 =?us-ascii?Q?U5R3rD0T29tWxZehEbclsPZPE3FihPEOYPEDb6Ixo3Tv88j3Ag2ko3ATqjZ+?=
 =?us-ascii?Q?x7bt29fXirqF8IHq6CvS5IC/Rs/8sZqThBS7gRXM3mVvFO4ANqhXor9krfWq?=
 =?us-ascii?Q?f8Hd5XvVah96tSkRIc098UMCQqNsI1hJqMXpgw8yyvrbzJNlP+PLDntgzqlI?=
 =?us-ascii?Q?PGC9LLn6tQ7FD7zBlr7TexJbnpiZ6hNAXeYnoCPSonqt0tMCs8rSHdZF8yaQ?=
 =?us-ascii?Q?z3kw5hYc7Yp3AfpypjS5LunyPtg66XqN43LV4koiPqLq/5OWGY5I7yXKTnXa?=
 =?us-ascii?Q?223QUPIaVi7YH6aIzNTv1LJtRaq/57cbY/vOEp2+lacZMowF2EJNKoQb3NGo?=
 =?us-ascii?Q?NyFA8wJb5OGhtbFP7a2Z6fBPziWsN94aG8j4fKV8jAVN/iok6q6TpkCM3rM/?=
 =?us-ascii?Q?aioiJHMSGCVW6Llbm1zyxcEjLMFIbExFn4ILegZjLJVHN7fnA1JD+GyQ5F+u?=
 =?us-ascii?Q?y3Xad06N4K9JF1bPIlPDIOPabFaY7uWh3o+EVNw3bv8lCzmU00Eybrszs1Hc?=
 =?us-ascii?Q?jwNIwMtTKFjDPNEDObBuwiqRIJLjVso3k2TLvbyb9BkyKUGuJQ88nzleg08C?=
 =?us-ascii?Q?KZ7PPcW9ApbR7wvM3U9nmtTcRVFv4jmz0zzCsDUaAcz+MJIGWUiLHBA1Jn0X?=
 =?us-ascii?Q?VC4g5ayGsKnENHXryL4P7crvKb+NFKrX2dtZJmodXIJLaQMMxQzIspFk1nGa?=
 =?us-ascii?Q?F7jD6x7iInajyqx0nBMmSyQEcNhqt7PsYwo+gZzALpu3mVN/EyoJk8wFzO++?=
 =?us-ascii?Q?AWoADfkU13VG9Ay4fch63MPEXPtwFH9EWcSW4pJGWOl9NAvR3HrM66rG+Dgz?=
 =?us-ascii?Q?255pxCghYGfWlJiwLT9Yq6PA463Oe0RuQ0S8WM0GK3OYsbZKgz1NPZyBmtqi?=
 =?us-ascii?Q?EItzN8jE6hqeTPP/hnnkiVFdW8Ph1uZE6zsHTm/acN1gn57Q/ENIUAxiOg2R?=
 =?us-ascii?Q?Beg0+2RcijjOs6t7hquvI9qztHG9pLMEzOnaNlMRG3wqLgpmZr3/y6ZxZJEt?=
 =?us-ascii?Q?0hgG0f6edh0guXphutuN8jw1tTFnpWQdljgNzlQ1MQN2kOS24fxiARmmoUbR?=
 =?us-ascii?Q?4QIIDbG84XHSELi2dyqmnhBG3E/APKIyHxNHxzmwqYbpaEZcSVkrIOkVgMBo?=
 =?us-ascii?Q?q2K49ltIfLKJ5scsNAhPVV78?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5613a00e-cfec-4b07-8f0e-08dd9e0ba5bc
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:18:22.2721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9864

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
2.49.0.638.g5db5b64a3b.dirty

