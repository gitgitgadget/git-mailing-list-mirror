Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010010.outbound.protection.outlook.com [52.103.68.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25111C861B
	for <git@vger.kernel.org>; Sun,  4 May 2025 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746367122; cv=fail; b=JKywYs5QABdcXb3g8sL5reA+Fha2FY9ClP2OD24X4X8aCOZtdeR33hBHKKRh1ycKpNkeIgYthOFjDXRHv8GJmrzm7sTjvSngiwLPMojkWPQw+/zpsM9zoN5VXLU+Hv41pJdRgJj2YMR9CghNil6cD/WOEIxuynCii69BhazSFUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746367122; c=relaxed/simple;
	bh=MmBwvOqaM8pbYr49lFDYJzD09Y+OgdclN6RHmKn5FC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJQ5GhNlPax3tFVSI+hn9SlnZMp2Uz2yi49c0m4P8eBA6BGhkanbaoqHxH1I7NB8i5+V5NXzirhoxZtfRwx8mMemDCRMxedqlgze2IEXrSmuO8DdA+yMlMC9XTD+A11W9/x4lzS9lJx62xix47y7HGSoWpYIHjUHX9JUoM3X6fI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=GGajOUW6; arc=fail smtp.client-ip=52.103.68.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="GGajOUW6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tD/+Wk7dqpqbGycqReXPaoG9OiDuuNPBh/ocnRVUA5oIDQVoBEJvKSEFxKNSEsJWbL9YB2Dp9jS5K4WCNuoNGUYp/QD+keDknC4Y+RCuliVm/X0sLoauHAEEqa5EYkwHZGA1k9WmWfv0JZBvN8Lq3abJADkkG9ArZCDkmLQaikhGPD75plwHXgPUpLX+0T62jykN7pJld5h/ojrWn1XdbHMTt62fbx6glH/mvFNk2iIZPjkIf7q6uMaqiHiKCMAKnyc5EUxN/MPCnjxlBM+9J9iwzYKjVD1t+QsD+42BMI75s6Uvn/lBw29p+XuSZAhxcLKNTFsqrEday5tnugYK7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seODZuS2uyxb+X3QcE9vCk3VDEUUcT2OwHKodky+lJ0=;
 b=JJEdchTkHKXIOjqn2Qg46Ef5h9H0keC3y7vio8oyAiOFd7U2pNRlvBuVXqH7ZphVMLXEUlljVUZsgRJbbmk3/eKpNLn4ZppyBn9D0mKWySrAnF7AQaLH1GMj2G4xPr+jv92yZGtq9AIu8VUisRZ7K+ORmAkIwEBYtq9NqsLHZ5ndJP8RBzRtM+WTB+zZuBuzBdUKO8PWqhpw9kBaSQ+G3PhsO0ayzlRV+x8pwDcS4YOihkMsTr9s9MSd8MV3t+EgpnQDzgbzwSjQ/kfU3yectA+oFIN7LV3U/l3dyC0lOs3OiCF3WIL17cQ9dvVIzxUMLYl272ZvHOohotrMNMB/eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seODZuS2uyxb+X3QcE9vCk3VDEUUcT2OwHKodky+lJ0=;
 b=GGajOUW6KjQRRKqu+hAeh3XyLGgUGZ9tGAJu5e4qSg/yiLeZQWE4pindHmM4IQ+lMNAesG7EzYnC1XXUeaD368VLwh9r5dj132/CGwsBbn1m2Z5jNrEsttAp09wB9/TV7r6eLOAZlMHFI13XEJxCJZBrBMp0HYN0o+zMMbRBplg5DdRD9yA/mzF0Sjz4OLyV/Lob9vU0K56YZkUgzdtwJctUCv18TxAaJG+f95IsHvSBBRPITDPde1ono5H47G219cIfxWBNMs1toMatrHyxq9eVQ6Lcvt99DOndz/KPb1yY3t/yFUA6kVf9OGohVgWGS3wQvsUi9ulX0AznWulKgA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB8169.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:3c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Sun, 4 May
 2025 13:58:30 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Sun, 4 May 2025
 13:58:30 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>
Subject: [PATCH 3/3] docs: add credential helper for outlook and gmail in OAuth list of helpers
Date: Sun,  4 May 2025 13:54:58 +0000
Message-ID:
 <PN3PR01MB95976CCB3C645470DDB73C0BB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::20) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250504135816.6575-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNZPR01MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 99bed9e1-5c3a-468f-5744-08dd8b13bf0a
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLR0Ybdxcp7KTbjbpYD2CblCNO7DPdRHYTVclU3xGqvfxYEkbBLDSr7U8Mr5W6FaErTA+KrS25tIuynX1kv4TrnFydx6413zetUwuCejlOyg76B92lBs9xxNeDVBKCKmzGwzGdw91DPKMvvE1vgrZ1H+TtA3vixsExkc8VVXes6TE00nX3WHQvjLxH3SwNA7bmzflslUWTA8hFGQLssCxGZZLahRiIkG4b55An4yi+j9zfoDSIxBF4rkjvyLqLn8qzs52qAIH86mO/BYdtP99VYmaEsshXQUD1QWFs5eAfepIt7KS4rNolxd9MRnk7A59xV8QqiyXSO35QMgGTYvlMl0RHlxlJvTIfzxWJRNMf9EbeSRtclqynqJylWNdMuIs0AVb2AAXyWtXg+4lQ9DLpaKXGEMxLXRRdfi6YL1UjDOZWbyFXb/e4k37izxhzo7gjxogyjxEtdHEUIPz8X3oqH8K0hz1+XRpY/1l55v5q546obUAWjL5qSKMUvU1TbuBfwk9dw2JsENbDzVPS5h+fXjlkkMY6WE0teRohaDJM5p6SjMLtF/BnVvD57CfCr6pg2xla2fts8WLCkWESamJ5TeDtbTOcEMbKjBLUkMkbvd9teL5txHLgkJRcHSOIFe+JqNGTSqbMug1HGNCiTCLnpgUUxdzNK6AmzRBxxRREC5zAvyy5cuHezsedaQL60ZtUkMpG+QLEpMz9xuHTXI2JzoXBpBi9Eh8iOP78ENUZ80ByIzF7eJbgZvKZg+cGmx0qE1pN4X5cWs/n8vZj5f4VbD
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|19110799003|15080799006|7092599003|461199028|10035399004|4302099013|3412199025|440099028|34005399003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uUiNeTcu9HKyyJWjVYdo6W9xnx8mhe+/azRJN3yMLAp0UbgH5OSOQi7y8Kj/?=
 =?us-ascii?Q?bvJohQvqcT35nOy9jJBPnGUEvK4u1GOVbnMOqEiBekKecJ8mGFgzRTIej8yP?=
 =?us-ascii?Q?QEd3S1B6GkwA2Rvg9S75nmQnMlPengaLjA9goyisvfyrecT0j8Ox21FCmraf?=
 =?us-ascii?Q?9sPHpysEXgsCaJfbd78rYo6nylnWUW4fX3yjydxkssjstwmYD4B2p01Mdczz?=
 =?us-ascii?Q?hV+ohWhI/mR8dXweucKncYIlcg9d2JGyG9BMaDOMG7I0cnji4HzsIZvOSrfY?=
 =?us-ascii?Q?mDDKLQp7e0YQd3e9XYr3WH2/OyRQ0yfWOoCpiqFVS4qqN3HRYFL/OcSGI74w?=
 =?us-ascii?Q?8uXkP9uDcji+0cZxNxxfb16d7Ee1CoOwSnXAcAi9uxPVibvoDXqLn/6TBJc4?=
 =?us-ascii?Q?unrxQRyBwZGfv11tl4sYS3DFIwy/3ZvSeNbe/vlgsXWDSjOy9Pu4eKQq9HyT?=
 =?us-ascii?Q?et63LGPaSh0meX7I0AcD2+rSusHli/LE+5nvju17sRvc67KtXmYMqw5eWxPM?=
 =?us-ascii?Q?5h55mCegjk2Ct0w5f3ieTMniPDgJdj/YHLeEAHdXeRRiGbziQnNTD2lNasbe?=
 =?us-ascii?Q?M+7ahmyr07AGYSYUttdMQKWClRDDA+ifzXKyxKfL+/lKe4dHl2AX9OR017Ak?=
 =?us-ascii?Q?bivMwMnD6qPpfwzPHSqHTy0aq5o2g+cQdQ4/EV8DgQJqUV3cyUU1ypZwYQf9?=
 =?us-ascii?Q?ezVzwf97T/R5hrQrwDupfPs+UOqPc4PUTf1e2QkUyNlkabNmCQUVhWtxdlE/?=
 =?us-ascii?Q?flT1OGFIRa3fmJmqRIM8GnK4lKe39UJTDLsqNGmU2E75er9F816mmgEHAjrG?=
 =?us-ascii?Q?i1jqnIfsd+WsjNDGAahDo+XzJtlAgC3D9TH6tSjADOY3gRUUIg/dzics8x1I?=
 =?us-ascii?Q?7NrboDaiFZklBqNPAc3xsgiBTYZDJvcy1mGgNVXQKtmK4ot0rPYxXpFntdFN?=
 =?us-ascii?Q?D+MzeeHVWxTcy4OoVIu9krItVa/vOYnBG3nno/IQ/hWcsZ3bW8rbnPOzPaDZ?=
 =?us-ascii?Q?R8VL5CwIR7sDze0xSMzWhgZwO8kIjo3IdqyZuAwbr0r03OfMjrW2anaRZnz2?=
 =?us-ascii?Q?tmKLrX5CYNtZlzFp8NW0dj2jPdCi/Kv/Xt9ZZ5fyapvETHyMVwtSuuNzdVMy?=
 =?us-ascii?Q?pSoAzlCSTxPUp2gZL3jFpR3M9jCsVLeErOn6+nGlr6VJxEagO4c+jsZmGfKK?=
 =?us-ascii?Q?Sv+xkhk4vYti+fVxXdKgOpl69wwwqceT9vVYo4wSTHGAuah92G92oPdfQ3+q?=
 =?us-ascii?Q?x0IKhJykAtmxYtaAsRVv2TJFQ6E0Gh+6nfUp+hjwcg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GLCV+nlsdN0rM2XC/5gb9YD0H0cOY+jVzMVHqTv4EbZhmViUmG8So57CspmX?=
 =?us-ascii?Q?WsHFNIX9zaBl1oRdcu0J4VAVYep0FMmuQeQUkdmYkUqqt+FYD6mggjbKv8tI?=
 =?us-ascii?Q?IlaWDhSYvdhkTlcK6CC+gzNMxt3x+Fz2Ex6RHyo3/xlPkwJg1LCZ312vWpiA?=
 =?us-ascii?Q?h5GFi4i+hy3ZNCuPCRMaPQNE92nVug/grBF5M30QwKKTjh67i15KvgIKWmV5?=
 =?us-ascii?Q?kzHy4yJe013N1KqZW3HLDkShdgdKcuThRGWVEAQx5jYXYIDy1wX1WhueZcAy?=
 =?us-ascii?Q?eG3XFVweDyUx7dkeBhTvewdWkCX0jo9N8DvnVeo/kFVcfQ6O6Zoqj6hX6KUG?=
 =?us-ascii?Q?q9bmds2FtzLNR0QfNPfC22o0BZTS6TlInvtmHdXPiLoyqEJvZBASKcWCsnDX?=
 =?us-ascii?Q?sjyeE/rYRJkmLgHOfnGsaqD+b7CU2nGHH7g3o+I8VqYMrsz+VLCMF9ZyXGMf?=
 =?us-ascii?Q?mS83PTX3kMlyNjyMwCyqzlnZ1oMBGRp15vHg11Fd/2eqGtf2oriPj8oKMw+s?=
 =?us-ascii?Q?18g0wMCUbcQjY7S0cCur3WAkhH+OLts08J60yRcUNp17jog8p4kjIuBS2qnQ?=
 =?us-ascii?Q?DTa7lQmB2tXhjuNKOVKBulGDxe/cw+DbZIasXRQjKPl1JCU19jfM9XZaiNGD?=
 =?us-ascii?Q?dpHiofmt3kWWDurgdwYtlfrqD9YdWmFwvm/mM7Qu3kKyCAERQG59xw8jv/Ya?=
 =?us-ascii?Q?HBi+1C7nXX6jYtSetGbiE431E97TECTTsPyh2wkyFMlEaTFHOzmdQd6X//ui?=
 =?us-ascii?Q?HkBrgywUf22l78Tv3XPrzslT+GeHS+9yXMiTiC36hKUj41hEXMQ2XYci793F?=
 =?us-ascii?Q?/6GmyH9bUBKJoC/t9WqXFYCuIS3RzCCPEh5GxNioleadMqHBZWl6PKa4YH2F?=
 =?us-ascii?Q?iCQ0tNgeR53PRj8vepwHfTJt2WNmJlN/EH0jWjwLXmp09h1vTOhBqljpPT0f?=
 =?us-ascii?Q?we9oxNF9oRZjSzhlGYvih99ew4jGzf9KOfmXs5hRiv+VMiXQL9G521usjjFU?=
 =?us-ascii?Q?WJ7C8VzyVwO2elwnnlRf+OH16bq7hkuRB5PDkXoBQU/v091cy2Gy7JElarVF?=
 =?us-ascii?Q?aYp5gz59Wajo5UZAil7VRFNAtU8Kp+WSlLXglYTrSO3+YOcHgdwLPx2ZEp1V?=
 =?us-ascii?Q?dp9biK8pLUb+Em9tViKPw+4DKoT0ouF/YAp2B/nQ97FRGUFqLD7qLaorPUIF?=
 =?us-ascii?Q?U+urgxT1wrUf+N1rikp6XxSZod0ncwm58MTlxvAmMLKqrRGcvVx+lLabZNk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 99bed9e1-5c3a-468f-5744-08dd8b13bf0a
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 13:58:28.4164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB8169

This commit adds the `git-credential-outlook` and `git-credential-gmail`
helpers to the list of OAuth helpers.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/gitcredentials.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentials.adoc
index 3337bb475d..62718a0422 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -133,6 +133,10 @@ Popular helpers with OAuth support include:
 
     - https://github.com/hickford/git-credential-oauth[git-credential-oauth] (cross platform, included in many Linux distributions)
 
+    - https://github.com/AdityaGarg8/git-credential-outlook-and-gmail[git-credential-gmail] (cross platform, dedicated helper to authenticate Gmail accounts for linkgit:git-send-email[1])
+
+    - https://github.com/AdityaGarg8/git-credential-outlook-and-gmail[git-credential-outlook] (cross platform, dedicated helper to authenticate Microsoft Outlook accounts for linkgit:git-send-email[1])
+
 CREDENTIAL CONTEXTS
 -------------------
 
-- 
2.49.0

