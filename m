Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18309313552
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675399; cv=fail; b=aDsBOT7oHhlDVFVFwgV00aHUUp4xrfUyIm6DabI1asDK/jNrlmEWs40/zjRzdAUNPzMMSm6fhO1eVhpXNJbZfuhcnrt03ulCMkhe5KXhb6ji+Z3xrRTHjNBSluUC3g3tv2OUVVxj4bOAcgqP6o0dzgCw9mpMkfu95JaNyae4T9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675399; c=relaxed/simple;
	bh=6oa6Lfs2Amt8or5rH5DObZ/b6Up9boiKHvfyKA0erzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UD0V7mXC/ZOXdC/DIEb55TQLP/zb3NMwQpQbsQrGjX5sOhUAIhH9wOz1MVliUeoVE0j40IsIcSV2EtRxaUOokpJKS2pGn4wrHN660AvgGNsAlCsiQ98YxtRYo/tuPkZhJf8ALM/sRRNCoy7sj+92jYAEyRvXa5vUx8DytlDEu6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PnsE2l7M; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PnsE2l7M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JH64BZkB+ocdBtH0HWO8U0yucqd1wX8rzY++ztJII7siVIu9Q1L02qVKtL2xCmACFHhGQun8tO+U4Ahpm6PxG5yrdhTg50zZQFJkhFo/OLN0eg/eJlgAhK53saDtNiA8x8igcSqrR76S9fRV3Wrf7PPPkfdWiN+LKHYb30EewFRUYhwHT/7Qyr3VnLVcSgi/cDK8q8Z8GCN3tCqyOi2zRd+Dn4AJXi8mFzSM6ANtOsP3C1fxA4HzEQjGq91f5AsICvsOy1KLhpcDy39l5u+rP8HNggJkgXPV9wb4MhPwzW3gK3VmyY9hl7NvM+IrdFh3/1eHgnQxL1XwHofP0Qhx9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5N6yPgR1yZaN1t0tYumXs9jZ+/rz/HBcswmBXreB+Fc=;
 b=dgxOH3QJOzLVpzJl8LZBj9WGbYINs2rGJsRU2AtOOKQoipwR5bi0vs5Ug9vxqCIsRknto4MwveYAEuickG3zW7Fp1dnK4O8fH1V1gpfn45u4+z1E4deDT9P3sIyByeNcRXMoBfIaZEcLHb1lkQXxM651IGkJ9XMdTRVbtFtaKRTiY36TZTWGXBiuSeXi9/JxEpOfZVayEO46NsoMYRtjbocPNnoE8O1bWkUFYN3Yih3dgI/0GUri4U1R/yhrwYLAeYRQxdxJIagDPB1BPkPGWC63sjUPpBACX7oJcSLnwwdlDKasJXt7Sk4Un+FeuPpTcHKO4R3WDRO/4ZYOlqUYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5N6yPgR1yZaN1t0tYumXs9jZ+/rz/HBcswmBXreB+Fc=;
 b=PnsE2l7MIYzH5FUTq0n4fwZbTL34w3oG0jI5Jt+YqEtoavxK3V5u9aJFmWtEiFKdzKhJPDlKKBE2+E8q8coo86AjxMhmPLgwDHdFicSUXSj+DSfvcjTvEx23PV5E9DCNT4pZJLGr/2zVBCjUry5Oe7eEKtSjmxZrb9oLWe4FJyABcsGyPSg8N4jreGBswLn/6P4DeKnGfEnRSgzzLWZfPZ6NfEgaWEQj/KC9YIf7qtRAhWTpjCfrNaeZY88XYPRpO2SMiQQhXKjFzhiCEXO20seuP4SYs9OJGGAx52AXE102XXXGz2iabILgX1nsqr1nada0ZV/jKELc/T3VSqoncA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0774.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:36:34 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:36:34 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Aaron Plattner <aplattner@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v4 00/10] parseopt: add subcommand autocorrection
Date: Tue, 17 Mar 2026 00:36:13 +0900
Message-ID:
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260316153623.569881-1-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0774:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a27229d-46d9-4e14-818d-08de8371cd77
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25031999004|19110799012|8060799015|12121999013|23021999003|15080799012|5072599009|461199028|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BAfVNKt3ydlPwiKTTFRDC63BUxqCY9x0mW94Z+9t1rYKUIHRyGdGY77JAT42?=
 =?us-ascii?Q?SM5AwFUh2qG5+cpRymKju8nEmpExVzRU2La0k6fWBybFJgpQGFzPf/uV3qL4?=
 =?us-ascii?Q?tbQ9jySqnqotQz9OQdBiui/swpKYD+EKPzNwz4NTl2n/KZDZQs+dFfFqBc4B?=
 =?us-ascii?Q?zViaDSJ/jcf/L5XK3ADou7Gon/u0Q3+B0MVGMz9ru2UBGb8APR9+wCy7cNcH?=
 =?us-ascii?Q?fvH2YsjR/UB4REAJeIX2Jt09+9nTC9TUuqHilGJj0NU2ouG9MDl73wFa3cYn?=
 =?us-ascii?Q?KfI7BNaSq7jjDxFYTtCiTyWzDmwc7bUyxBkw5KjdYHfJP2VSw7JKD5Ilrrid?=
 =?us-ascii?Q?5BPq81vYugkyFyaENQaOW1x9sV+RG++LpBa/vq4x8x7UjlJ0F9bGWljgJjtf?=
 =?us-ascii?Q?5vpkUvBXMLUSRBTAiLuasoUl1u7ss9+1rzdKd1RUT2L/X3cYVVfwY4+hW7Z2?=
 =?us-ascii?Q?l1a08n7etuTw8MGOS4yz9ACV0sxn+MHqlRlcsQbLv0IFS/Ct67KitULmgC0y?=
 =?us-ascii?Q?9tii5uR2AzXHsSxh2TreQqdFrM1SemI6RD1Ks4Drvac7P3x7VrUNld4DeoOa?=
 =?us-ascii?Q?Qnb4IYMP7e63QBtJFXwH0+IdjT4HkWHKrGjHuZ4FTWih3QfRVB8F460sqZ6v?=
 =?us-ascii?Q?Kyd0tz4ToyTJSHIbLwKCcreOKrnodMvtomor8eJGaB++UwwPeXbisvwawsfV?=
 =?us-ascii?Q?9NX4ln3og8OEg85FbMFRicGPU75fXigOxm9SXr3RqW4F9zDPOqyyJsOJC4lA?=
 =?us-ascii?Q?4WFw2cwQcUDU+iQop455xWxuTzEy2ZK6rGWI90y9H8fI/m9OTTeq/vO+RkEQ?=
 =?us-ascii?Q?XthOtkZn3C2QN3I0qXLPouINIbOG6zZu/iEhLapQmDR4DWPwrfUT41OcqhTF?=
 =?us-ascii?Q?lUkdAb9YWXItFSBAVxNAfsEUHTu1fqkJgLU9CZjB7YV/cZ9N2PZojmPHintt?=
 =?us-ascii?Q?nWrxlN5b0/GXyRv3k8PyjVUcyG08W3CGqiRHdGlb8EYnFaR+RSS797ySeVqR?=
 =?us-ascii?Q?ognR?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jKgj4pUBMvmBv9VQrLc/yRvkosYgiT69q99ZVFXOv5vqXJmHUw7IeJwjFI59?=
 =?us-ascii?Q?6Hl2O5beiaas9zxtA3E+/gT66+GA1pUhKbWuHelJtdCWOjTooE3pFbqdSsT9?=
 =?us-ascii?Q?N7BRYpXyyqsKuV0DxiR8JGWYy1UWnP+Q14goUMc4ZMW+ImEXnYhTwtwGwykV?=
 =?us-ascii?Q?0+MeqlieFd263wh2ZyF5K/v32TPkBu/OGxHLUHKtUR7M5nSgzF3hwiN8oAso?=
 =?us-ascii?Q?D4ULfpfh8YcS+sXq/l9D+f1ePdBbvtPNea1/WpmJvzkgdYLVapbsP5nYPlbA?=
 =?us-ascii?Q?MpvskNjUO7KVdoPHnsjCqJkyLJW2D3NB5D/turPZX/1RcSj5zxCDkDRdMhi8?=
 =?us-ascii?Q?0XX82A7juIyo+/aDUZXpHT15iiK3E1sbOkhKb2Sknn1gjEsO/ut/c5U6U7oo?=
 =?us-ascii?Q?UdpdVwf+XgKDBtvkRrvK3XR/ugMheRuq9rRSYGkqEb99yYca658PxL7v3TT3?=
 =?us-ascii?Q?W6GGpFcgmvh/b7S2xmr3XrUaRz/CmsbMLl/ObKbCfuv3UyD4ltSf3CPW8C7l?=
 =?us-ascii?Q?YazG05jHUskkxn/+1wsN3YvrlXqVb7hbKsh//mmmP9Twq24GGmRXbanqB4lz?=
 =?us-ascii?Q?vGOeOUuoGXOEpok9NXbBiSKGnaPtyGK26/qZDXWgbE0d2mzMIIsAtcE5eRaJ?=
 =?us-ascii?Q?C96b71p1gTAB6ZLvvDJzWEuvKaeE7xhUQa5TV2+Zy8izZeWQKFxQ4HrY0+m1?=
 =?us-ascii?Q?KUhNSTiy59Sfd2egD3lijKWCwl61j7UF67pVu7It16XpuZe+u7jrQJ+DX7W5?=
 =?us-ascii?Q?JavBXFf4H4yzXNVKrguzRDAGGPSXTNXnYg41SA28dNR+cLd3J8xNLLl8nYEv?=
 =?us-ascii?Q?YuAW40bIbuRFWv5aA1cl3P2/VOb7ciepi+b+kgaP1DfK1BDvdyQa8FlZOEp6?=
 =?us-ascii?Q?6Vu3KSJJBmD8LY7Yfd+baEyyQpU5CuwmpVk8MTK70VXYBq+5rtmbyCK/DdJ8?=
 =?us-ascii?Q?tkSNjlxlVvWzwSbAiWJPdBKrgY4kMQQGZG0T+ZLMxfjRtAfWYbB0BGEYRgVR?=
 =?us-ascii?Q?XQ3PXeTZ99woAhvkJq5Sty2IYbtNHooHzNYSOpBxntCpMV6y+M6EuKS/iPjc?=
 =?us-ascii?Q?8R8qmhuyPPoquKPtW6OOQqfYLr4dVoiTyyD8SuTzV9svczWJbMEwwk/4xPKC?=
 =?us-ascii?Q?kAvrOu5zVNehQF2yCDGO3q1xxe+Yp+vKVjyi/zu95tdBCQww51S5flLs3Sbu?=
 =?us-ascii?Q?E7w323yMLL/6CVrfLKk/PH7HjcSQKZkjwlVykJ5wjbiTqOciuKkWcucLvbaJ?=
 =?us-ascii?Q?ZgNH6GZwhHXRvvl/vuNg7VFhpmJS6OJSP0VD9F3r3ffMTZTfBQJg5wKjJ05j?=
 =?us-ascii?Q?QY5jztdif4TZBXYpKSUM5Sv2mg36bsTwxs5RAc1xqxhcVfXI3dU1eAM4joMA?=
 =?us-ascii?Q?90VAQNQ1LOEZzUuz0pyC2qFWNikO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a27229d-46d9-4e14-818d-08de8371cd77
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:36:33.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0774

Git currently provides auto-correction for builtins and aliases, but
lacks this functionality for subcommands parsed via the parse-options
API. Subcommands are also commands, and typos will occur, too. Like:

	git remote add-rul

So, this series introduces subcommand auto-correction.

By default, this implementation enables autocorrection for builtins
with mandatory subcommands. However, for those using
PARSE_OPT_SUBCOMMAND_OPTIONAL, autocorrection is skipped to avoid
misinterpreting legitimate unknown arguments as mistyped subcommands.

To allow builtins with optional subcommands to explicitly opt in,
this series adds the PARSE_OPT_SUBCOMMAND_AUTOCORR flag, and enables
it for git-remote and git-notes.

Additionally, the existing autocorrection logic is extracted from
help.c so subcommand handling can reuse the same config parsing and
prompt/delay logic.

Some split string literals are also combined so the full text is easier
to grep for.

Changes in v4:
  - Add missing files to Meson build
  - Change API prefix from autocorr to autocorrect
  - Split the commit that moves tty code
  - Add API documentation
  - Use standard Damerau-Levenshtein distance and common practice
    fuzziness thresholds
  - Rename AUTOCORRECT_HINTONLY to AUTOCORRECT_HINT
  - Change commit subject prefix for tests from "help:" to "parseopt:"
  - Fix coding style issues

Note on the autocorrection thresholds:
In v3, there was a discussion about why specific thresholds were chosen.
While attempting to document the legacy magic penalties (0, 2, 1, 3), I
realized those weights exist in a system where prefix matches are
completely ignored (due to a historical side-effect). Applying them to
subcommands (which do evaluate prefix matches) makes the tolerance
overly permissive. Therefore, v4 abandons the legacy weights in favor of
a standard Damerau-Levenshtein distance and common practice length-based
thresholds.

Changes in v3:
  - Align with the coding guildline
  - Split patch so diffs don't get hidden by code movement
  - Improve commit messages

Changes in v2:
  - Reword the explanation of default autocorrection behavior

Jiamu Sun (10):
  parseopt: extract subcommand handling from parse_options_step()
  help: make autocorrect handling reusable
  help: move tty check for autocorrection to autocorrect.c
  autocorrect: use mode and delay instead of magic numbers
  autocorrect: rename AUTOCORRECT_SHOW to AUTOCORRECT_HINT
  autocorrect: provide config resolution API
  parseopt: autocorrect mistyped subcommands
  parseopt: enable subcommand autocorrection for git-remote and
    git-notes
  parseopt: add tests for subcommand autocorrection
  doc: document autocorrect API

 Makefile                          |   1 +
 autocorrect.c                     |  89 ++++++++++++++++
 autocorrect.h                     |  32 ++++++
 builtin/notes.c                   |  10 +-
 builtin/remote.c                  |  12 +--
 help.c                            | 107 ++++----------------
 meson.build                       |   1 +
 parse-options.c                   | 162 ++++++++++++++++++++++--------
 parse-options.h                   |   1 +
 t/meson.build                     |   1 +
 t/t9004-autocorrect-subcommand.sh |  51 ++++++++++
 11 files changed, 325 insertions(+), 142 deletions(-)
 create mode 100644 autocorrect.c
 create mode 100644 autocorrect.h
 create mode 100755 t/t9004-autocorrect-subcommand.sh


base-commit: 795c338de725e13bd361214c6b768019fc45a2c1
-- 
2.53.0

