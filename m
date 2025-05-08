Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CBC207A27
	for <git@vger.kernel.org>; Thu,  8 May 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724698; cv=fail; b=h9Gn+JuOhOzIGPZpfGF7zX1gSD01/unl00p0SgEaoUMnoHaieJl2bgirfEg3VwxPW3tavJmUjqKWGpvU0HTuBoo9rr9JYEFmvRMcHxQQyfseUpA1zizgrL6FhcMGhiFKLX7GNlFKlwlMoSCFimvbpeLV9+QjfrvYwaY0O3j0y+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724698; c=relaxed/simple;
	bh=RtQggVIoeAKO91QACU2wkyJiEsl0rkh8b+pdR+NusyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D6ZqZ5NlZmCUkh4kRyrv/UBk9pcrkulbd1ZiVi3pajnE6WepNopApTKqqAUtFLBxq+eR/vLjhXkDNhHyyVCyQTzosgEKzBmwxHMpEq35gINJO6ARRdNkjYKd7OS9zqVr37x6sYZ2CxmhkVijHVVd1oZd3wpEZRbmrJyvTo2i46E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=kcFVdn+B; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="kcFVdn+B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxqtcEq5hd55OY8ZV3Xvyf/WwRiuQgD/DtN7NRV0nzRssaqzYb8W/ALIFfX5t9K2KZqIisdvQPWkgxOqPYRLoBzWjdPy6e+cCRciHJfYKblEwtzOcHaij+MrC9SSjcWvtW+sRORcb7t1qCSAgyFaERGNMYptWQ6WEJM5cV003dmFkWiAawFH9YaOYUHHxoVPSGIEp3m4s851MtKM167MOOsyP2V+P9//TWFc4SRZB24fay8F9CJqyQSoMh3chiosfVll+a2yqtRPptXghwU+Pn9uV8plDp6KIiNz89hm1/lTZQrGPvadyZ8+ZWj4ZiPzFpQvzfRDGvpCorydlH7drw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnedz9AFtu0COAdPUoaNJQIUR8GJlo3sv3HliufjjuA=;
 b=AOQVACfyzDnJX55m8rwoEKR47lJT+8bFoxerfiJNzYJ+crVMihiv9e3IKbuR6qvUAJenRAOrn/rUB74IoTjgohEf2hxO8+K1Fdp+u2ctHWsabWQ5AubhNyMLwr7RymMqw3XFspC9wuzGxSfYC9DdEtT/6iDroqYd54L+Tiv/Dklz+lDg4utIscbx9blXgQbtA2wxfqpQTGpX6tUBw+gK9aQG2Di0Wonb3DbkSYVwLqnPGvyD3QmyPiN36QRqCjZV4rQqGhPcxhgDAE/gHz3/QAKeCrYRPAmfqa3teO0TfpSBpsbQPANjDKo6ojGHmJTQ9u1PKNu0919zYuw69u/RUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnedz9AFtu0COAdPUoaNJQIUR8GJlo3sv3HliufjjuA=;
 b=kcFVdn+BDrBIUNwt0sWHzKE+cc0luwkts6WwizerkEqU1tyXeW4VxjIb600dC/axN598oiOYTTQfuDn4T6VFYr39JzWAcTYot5UYNgJ7SG5Vgc82prKV2UHqqrb0AswbqCU+XyEhcRO/7hxYOtM004n1b8kE9eT6+uSjEK4PSOZV3MFK3hsjsj62A8/ickpqr3WihlOyf7+imVYZE2Ze3b5SQU1K+AGPUUdVWzGOwOq9U1wQuiUQ/QTLDec2RMPnUG/M/hVFz6J49+RnBbYC0E7jUpeHvf8gtARfuhXzwiof0b+NLh4ygumh2+MyfTq05V3fOyo7AXMqJELUh4wHhg==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB7253.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 17:18:10 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 17:18:10 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v7 0/3] Improve checks for valid_fqdn in send-email and update documentation
Date: Thu,  8 May 2025 17:14:26 +0000
Message-ID:
 <PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:265::6) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <20250508171758.19119-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN3PR01MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f29bb1e-3736-4242-9b2f-08dd8e544e60
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayHzgPFTkOkKHOaNyTn4nQw6ketNNKUQnLTUO6mcr0L+h1ZYlHhmz3Jt5cD2nubaPjbDMd6YJ12vEpjkXEBV3XHytazQqmjmOZ9LhacpISgIDz0RiSz01u+cf9sIyJMOkrFCGEHyo3W4yugjZgA5PupZxtKf2tFMfgKJtVTg2uNAMKl7O8wPS2uRUYB2F2coUKr+cvY02pB6cgmac29OpPsyuJHRf+IMbdU8IlNslOHMUvOyQIt3QhTgPPNI5YICZiLFWosSvOyJwg9CheBM05Wf0bovABzyNhvi8SEn+PFk7piOquHPyu6wd+9g2SbETUgRQwQGi36s+AbTUzqeKSlG6vCA/7PrRlHHg8OwZ/TdSSQHLPwvvjGfVxi1uZfts9pS2Gs8SC0W+evHOb3sObQPvSVRz5IaLjEoq64EA3/hKkryTZXUYj0TsOGGxl60J5Om8mrNTUDvoADb8j0UAUNDELNzZhANvL/cdtbqpGeSbg7C1NH06prZ8M26ncYslXlDXhi6WlLluLKea+W+TRLzcR9TskHRXOhuWtNHllL8HBC2m1OhE0g5PWhHXwAlxak1Ztk0+8PXWd3JKzkxACjVmOYOUM2AXzB4h3l/TMKTr2on6oG+4gE/iBZH4xI443yGOeZRO2qTXwhLEv+UIr5GR0NcI5ewgF1hQESvVVKZb2fCa5kokDBVvEPR5ueJ9HTaKHNZLN1Biajd3H2mIQjViKUh9dJM9H8=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|15080799009|5072599009|21061999006|8060799009|7092599006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wix4UoU7dpMWtCUwj++iv2jSOUS09g9los/NRWDb27H7Ln6MUzKOejI0L5o5?=
 =?us-ascii?Q?7Dc54DkKAelJsP7Kc8szCitGY6ivzfeaR1AD0vTfyYGZyU9XNerCmeILcLlE?=
 =?us-ascii?Q?Dys+kwxSU5cNBBOvZOtqZppE8/RhnLUj+doVrAlnzMf2Z9516Scb4Cc83eX+?=
 =?us-ascii?Q?6PNFEU4wCsk72ok0rZQrMxR6FT2SeprbJGVMMJHnulwbFlfvzKwPNpfCPjot?=
 =?us-ascii?Q?Hb0hFKKzc2UCk2DvreG9JiX2uHN5MjIP5k7aEZxWDPQKq41NQivmzdutWLBs?=
 =?us-ascii?Q?W4QYpMA2Rj2Q2D+JRvWFAYNLHptiKSd+SRFyK6dX4Sw5xLn4tGTR6+12tcYx?=
 =?us-ascii?Q?Bn55PXHWxfvyH/HYE8NNCcAAuJhSzgqTBBEQrgEgvyUaBszKiy5MTLPzG8lr?=
 =?us-ascii?Q?or6YNCsHu0YE+DLjNIPfK45wThVabdvYLtEaZg0PL3Y6k95LabIUY/hd2P4I?=
 =?us-ascii?Q?TrSEpJAYk7yKH66twPy7jRSyL+bXKjTqvFkn89X8gbIISTXyWarHekjjLZWx?=
 =?us-ascii?Q?RiR+5WBu/Z8qUBTmUl0rNODc0JjanKMDfTpLtSYKs1Ds0DxpFQpDn0dnkwUB?=
 =?us-ascii?Q?FrgQV57GSorsMLeQhRLGp4QUY+Lh8mZJHQEK73SyX1h7ZxYc8rGLLyVxqdAo?=
 =?us-ascii?Q?nFtgamQrhXODBv5Pv0l7fyOcJibw3bcxgjtsm9LQitH10f8UwjkBWzkvSdsL?=
 =?us-ascii?Q?we6hV53nlvlOqmBibuGmEZzGGdnjNm2ASBZH61yOHko/swCht0bEth/GI6QC?=
 =?us-ascii?Q?41bk0hZZx6sU/OqodfKXATV5ZIHVdkr2RqaQwFt3CXCZqScEuaTEnsFLz3fy?=
 =?us-ascii?Q?GlbLYorannf3yPh8gu87YpxRxiBitY92ZGStyhmQUtjuWRWjpC6vBT4DycZG?=
 =?us-ascii?Q?s+VCIUQS57iHsKrER05va5w5io+wjhAT3IHY0VVbHX2DJwqNsVHXWX0Q8PF6?=
 =?us-ascii?Q?usJqwVXSJcW/7VhwERK7HJkolfN+/8/Nb/dpoqWkqWul6LlKtghObAth4qfF?=
 =?us-ascii?Q?9phBFuABybz3iU3tWOfXgXTWD4EehMpQUEyQzAy3kDwsoJa/rakqJsXtahrA?=
 =?us-ascii?Q?IBgSTi7boW7AO8Ebpf0xZ4f2hz0MhyreasmZffzx7OatBhKgMJPOzBceZSgl?=
 =?us-ascii?Q?M/wl6cRl23bCQ+tru623dGOC6A1fagcu+A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?To4LOOSmKNs/auCvs9kN7OY3HNViWsaEMj0E02Qa34YGDAUkAcFRrplxKw9X?=
 =?us-ascii?Q?Bnl35TogGBM/cF5WQbnSStAB9o0NhAp3FZ1Jf48ETgt6M3GiqOozVRFlpiRN?=
 =?us-ascii?Q?c8o547ftSwT9Dzc+2bef7D6nonb1M1TyXdFpPLHiSRGkUGP8StPOJkKXR+eN?=
 =?us-ascii?Q?AX6t+ysboVPcyrS/ejubuJIYUOfQ1qdQOi4LCEvzW1/zfUQlkC8hhHWCF7tw?=
 =?us-ascii?Q?+6+N2uiOZ7dXZnlXGbgIPd3IDLIjjidbehTnR5zX6euvVanNKLJlMt+d3cr8?=
 =?us-ascii?Q?6LAN7phVdGaoY/m4umiR3RdzWzXoAXPQuEBVSVzpEMksPB+1laLC3+wItyeB?=
 =?us-ascii?Q?Gwn8d4EUbpw9NCjRxbzLagysC5dfPtS9eP1RVSr3cQL2saE3WIM2XLerVIVA?=
 =?us-ascii?Q?3IlGTFtafrZeMZZefcc9XrZeyvHov65QT0o0Bxi3gJ862oqu37u+SZzyWISV?=
 =?us-ascii?Q?E6cJFVjuiUDa5lUkgYUAtMSqdK1M00YoFg9obHf8ktDwxm+p5gN/OQPH1aHv?=
 =?us-ascii?Q?tVC999lMCMr/5sFFcrRIbMUT0OrK3aXHFa1c9pKVjwZIlyGvVZWLTcbJ8bOt?=
 =?us-ascii?Q?rbtH90C5q6BZaP9Q6N5JHy47mjG9c4Dze24LAsBGZFyK8wWTNX6gk6Z0zS9U?=
 =?us-ascii?Q?EdYxogRwKFegAPTdxAaYX6G5LoOrXtORlCwCoA7i+ix9XFKhLmHOhYp4CG3M?=
 =?us-ascii?Q?S3DatllX6HrOEkDxGYmsunlaNKCCtQYAcgYZWO4z750zvbB1jWaqFkjXoSf6?=
 =?us-ascii?Q?bT452tcRRziKuAm+NL/76uCoyaOX40jNtKKDfq04lMKVo3S7csKkjPESDSJQ?=
 =?us-ascii?Q?F0qGHeyv39ATKmAJdVhhqiLyOMi8tpp/WNuf3WG2KE+5sAagpAot9/Ro5D9B?=
 =?us-ascii?Q?Y4IK7KmfJmO9kqaLPLJuho5jdkbzXA/qDGtxM1GES/QvGcfQUTNvtldYninN?=
 =?us-ascii?Q?4Dp6bKe12iQUv3yg/vEkTgs/pm7cc1f6DRcqdpXwvC9Y2ZV5SzoqRzc+ERu2?=
 =?us-ascii?Q?ClGs5y7DgT4Is+E5MXMSL5gArWpLRNzYuoSpcWtTQOkobJ1dc/5KR8Re87nv?=
 =?us-ascii?Q?+9HNeRvSzkF5OmJyaITSsHAoDv1pza4RgH+fG2lMYnzBGIddjJCeU/Utd8XQ?=
 =?us-ascii?Q?Zp2V3oX+fzScbf49LPK3cvMq2uLCFATif6hc4mCjgJ1huz1xsLiNbWOlBfuf?=
 =?us-ascii?Q?Qyh6x7J0ABzOdTwEalLnkfCrKyR+7CQUPwpn9qTBbcfoOSNfirdVaEGq0l0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f29bb1e-3736-4242-9b2f-08dd8e544e60
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:18:10.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7253

Hi all

This series of patches mainly has two changes:

1. Improve the checks for valid_fqdn in send-email to be more strict and
   compliant with RFC1035.
2. Update the documentation for send-email to include examples of using
   OAuth2.0 with Gmail and Outlook, as well as links to the credential
   helpers for these services.

P.S. I have used `git-credential-outlook` linked in the second and third
patch for this email!

v2: - Improve grammar and add missing "" in second patch.
    - Separate footnotes and the trailer block with a blank line in the first
      patch.

v3: - Change link for email helpers since old one was too long.

v4: - Improve log message of first and second patch.
    - Update valid_fqdn check in first patch to allow one or more <upto 63
      octet run of alnum or hyphen that does not begin or end with hyphen>,
      separated by a single dot in between each.
    - Revert the documentation regarding sending patches to a mailing list
      in the second patch.

v5: - Simplify the regex in the first patch to check for valid FQDN.
    - Fix formatting in the second patch to make it more readable.

v6: - Use backticks for ~/.gitconfig in the second patch.

v7: - Clarify the use of `OAUTHBEARER` and `XOAUTH2` in the second patch.

Aditya Garg (3):
  send-mail: improve checks for valid_fqdn
  docs: improve send-email documentation
  docs: add credential helper for outlook and gmail in OAuth list of
    helpers

 Documentation/git-send-email.adoc | 67 +++++++++++++++++++++++++++----
 Documentation/gitcredentials.adoc |  4 ++
 git-send-email.perl               |  4 +-
 3 files changed, 66 insertions(+), 9 deletions(-)

-- 
2.49.0

