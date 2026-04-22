Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012070.outbound.protection.outlook.com [52.103.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBCD19D065
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860391; cv=fail; b=pSfF7TS7W9bztDLIhf+DWc9zc/GAID2R9DWJxEcREwU6i51MIX4oFUa+ig27p2xBKChm4CtQAjw4q09MnJXFM8nBiCt3nw7SwPEWg8GHKI02EglaX4uxYHz9xYD4bWwRhX/X87ifrGCRgIWy5feD2TlmnIQnLpLNDvdq/fTnSps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860391; c=relaxed/simple;
	bh=1Cuk9VLm7GL7fXFXXNsxnN+L5HDUmCtPI0sB5tAOtMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LfvecjTPepM5bgk7a94qlcspWK+BV/gw9uiObKd+YXe6FCaYGV6TXW6u0xdofdlpJdOhjbB472Lp5Z/0TLS1QYVKm6pIAT50hcWS7I7RNiXdz8dmL79m8OjHqMITbJ80pKdR5CgfFzjTL3EZ1+BM/wJDnKYFXcjHWDXLqRj5hfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BmJ8T0mr; arc=fail smtp.client-ip=52.103.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BmJ8T0mr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX2ChvHY+akJHTDthDUNKWtQraoPxbtQFnjt3UrngmC14COOREFqO0dm2FIaBx2K98Qgq8ruP2OUyk2Zs6OVtgIEz9iULHkA8xp8rWY4EjxxANxDxbJF4y9Q2FE6F/S4eDpvcfPMtK/Rje/zKRCPmJ+f4HglNMxZBH7zRQyQoBbLE+BxN0sp+fQTfFVzaVdfMXcTHxuqQxE7L5UB8XT97Oekn9xsnOq7GVoDWNJuVXLrQnF0HxVcF3OIV0TWZpzAtRdjxnGODUhFqY4EBvxPhgQtWbjcW5sX2dEUV6fAv+UdxSdbVqwsXWpYc/6P7HfQ/xcSzc7JzHlsRP1Lm66VVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ukR3By5h2svVMJWSWlCpSNO2lsRSBQfYoskQGMsGcY=;
 b=CgGrOCLnfUibhmYWS9nnjrhCwuC+0IX2VmGmPnkov9esRKG4N/MM16O1iYykdaPt64s4vOzr+cGfjcpCngenjV3/dE9fk+5c+0dn6bnVvThgRK66Mk3DCdmEoVHaU9rQZxq9GvXQSXVqerLbesqlrNVBo4qpu3QcDPFunSo/1amNYTJ/VCr2m7b5vRhp442r8NYzj1fzAY5kPZh7kCI8nXD9L6c/UFuI2PYOzsHAQ7w8ya9Muy7NoGmPhzwVPhH50yMe0ItQgqbFj7vXft5HVDKBra4c3fJ/poA431b9s7ViK33kRtSGKD1pSzNqXM79iPockxnA+icP/DiHCuruDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ukR3By5h2svVMJWSWlCpSNO2lsRSBQfYoskQGMsGcY=;
 b=BmJ8T0mrU4Vll9IajUc99mtZzaFZxDdmFGPqnj42naF3CCxd+WHL2jj3WcmdK0P5ZJmpTp3cw7ElOuQrZCK/k2MLMtPgpkGziRSFwwOv76QEOBN56lPoFNQiXr0a64v0dvfGPfnfhjgjP407IvR80NHntM2yQzWRqE/IGtS3tsVeTFDv7Bqc5fhyKNP3RNwCfFm6sEaGjMjPtkZc/oHmsa1EgK9VPQRv7acQujvsWTMI/alJN1W54m+GorJZz40v6erLSebrtDKJmFjKhoSZ5R/jm3HsLCef0Tw9SJSEns04PZm45ZUDDi0qOz6vRNF7qxH0zsewG15KPsCPHtEycA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0530.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 12:19:46 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 12:19:45 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: aplattner@nvidia.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v5 00/10] parseopt: add subcommand autocorrection
Date: Wed, 22 Apr 2026 21:18:00 +0900
Message-ID:
 <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260422121810.307862-1-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY0P300MB0530:EE_
X-MS-Office365-Filtering-Correlation-Id: 3210ddb5-c392-4174-ed3d-08dea069703f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|5072599009|15080799012|23021999003|12121999013|461199028|8060799015|19110799012|51005399006|55001999006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NEcaGT+Zk+GCZ75fXnautejqCZmimr2BI82Rse97MRXbx741LEvqWqhMcEqC?=
 =?us-ascii?Q?It5ryW9hJdojoqw6TqC/WC85ZDyKJccCNtRdtnNLXS7EPd2ZLk6ttyH2yWVy?=
 =?us-ascii?Q?LRuoas1dTnlEDP90geUUykwZxMVnrMQFgy/aOYUe9O7MA4OZJSk2RBPSY8Es?=
 =?us-ascii?Q?kr3spDJk5AeJDUidPm3B1sK+r8flx8ZgTJcrFq4N2dD0oC9dOjArd/S5fjpv?=
 =?us-ascii?Q?XT+s6EWQDi1PKfclIv1pvvP9GuuvqxKC6P89yybhSZfqNW0VYNIIrz6IDdA7?=
 =?us-ascii?Q?wsQQvgJfTZ17qabWItzAzYtzO3MueNb3n/nAJsyp8vJ5jbafWCP2VUCiOkxe?=
 =?us-ascii?Q?BRb9nf6Mc4XCu4P0jKwsrrnrSwFHXeezRQEBt/1Mz3yv2O5W+rV7LWGzlk/F?=
 =?us-ascii?Q?s27kJy64pUjtvmig15GSk0tmE63zAdOziRnEm2AzdsMGCyqX2fma0223ZROp?=
 =?us-ascii?Q?wiAJljojz6mgomvNj6yipB+deR9v6UYbiKJNyJShAapXUOzmO12wHegy7KDP?=
 =?us-ascii?Q?f3hgOypacLSLZR4grMDobHTDrx9p5M70rZJbUvQj+V7jMJRD4EkBa7mYhO5L?=
 =?us-ascii?Q?BJGYJV8ZBld7EUB3zHMOGfQQn5CQCKysODGrHB2M76K52JsjfHCbAN7togew?=
 =?us-ascii?Q?jmHyAeEK1bgkC/0VAWE/rK8u3yTwowy6vtIckZ/6+uLmsZcXHJ26WiE4pba4?=
 =?us-ascii?Q?Yr9Kb68VEN3gYstXo6f+bq4AdaLHvWJWKen7TrTyaGoxQFC8h7ktHs+0l4/Y?=
 =?us-ascii?Q?7JtnC+BtJJoZBYluTer0WnRbeGBNMsf7+SvI9hVeLALki3K67RJXyo9nraV2?=
 =?us-ascii?Q?YrSkMlzcWTguFP6267PtkNv+pJ1YE+nq0cOmwYOcd3jFv9Rti/bTg6hK6deD?=
 =?us-ascii?Q?X0Z5M4tLG0EgWsh6fMcHFUzz6/I9OXjTCUTZx5Krd/1LiWHS1g/P863fpWe+?=
 =?us-ascii?Q?yp3sAvMwACm3VFCUX221IVZkood8Ds6WBjzoiSNczbmGXEJpTz5SaufBk+dF?=
 =?us-ascii?Q?eu8el0kD1j9ZZdsa8Ic7gptzAkuuy0TvPC+dVJk4lykqNqo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t5t5ExFJNcYu8o8UTIceuKj1gkwrVFqPTSU1bXzlFa03KX0JrDNaSj+mIv5J?=
 =?us-ascii?Q?xUMc/sda9QtK4Wi02kOfR0ZunUaxgi1o+gjJ+VL5YJFYarakLl0quWakoMgl?=
 =?us-ascii?Q?vK9gexVCmggA1U3zVWe7kzYIVs7braf/L1xOysAWb94MTvvvldtbpTOgUjtc?=
 =?us-ascii?Q?DunX+7QBE6LFjSJjw62D/TscgSwY0WVUW0LUm8SBw+ayasUfl17LHrKyd9mC?=
 =?us-ascii?Q?pRYm9uhPROPANM0fKIiIkxZuKzJo+h7goKCq3LWSA8wj+2VQWaLCdqlcqT3h?=
 =?us-ascii?Q?rsl2UVK6nDSJAMFTrmEhwo/XksyCsJvFHMCANNdwWWAFKQrMvO246MZX8ZFV?=
 =?us-ascii?Q?YYJeimZmwwN+kjUr4+8RxqknenBllfo3V0Yn9Q6xz//0ULlgAZqc1llREN9X?=
 =?us-ascii?Q?YJjBrppYCPle4IR8iP3IGJ0ollHKrPffkxLqh7n8cKqFkKj72JtLDa4IoUbl?=
 =?us-ascii?Q?sMu61ycOHMdbBWTfbzcOJloxxPpr/biY44Ek8WL1IXTl5SvPXB6F5Ds/syeW?=
 =?us-ascii?Q?XXK3NtF6laaxKOKvkkD01SqjqUJ2yw2HhPpZRw7uCGqs/DUB2am/1QSHnGZ/?=
 =?us-ascii?Q?Z8Xk45LPJvOpO+6BzRAQ9M9me9A3CjZS+/yk9y3ucBW4F5nEBTLFJ6vYjQ4a?=
 =?us-ascii?Q?qOe/s4zhZ1gxn9cqfki+nNsBT/gSKXn80e3pjvV3eOcAKhQ2xQQKa2Su2AP1?=
 =?us-ascii?Q?qu4CAjwaql+Gwp6Jqsw3jk4cHFlPjvLq6BTsxWnXRT+lM3E4ShRHsKHCVYn2?=
 =?us-ascii?Q?t2ODIDtezBCPsQgFFsgwcZx8wmPOTt/nZ3GsGRTmFk+P8zH2IMm4AdCUmmze?=
 =?us-ascii?Q?96EVG6Vde33dQRD/m9L54sjvyNRGnNg/ZrCc5zFq16LAsklSXV7ywS0Tqt+U?=
 =?us-ascii?Q?ZmQzJMMuvEbHuDu0+gAIM0r7fiPYwO4BnOCtdhEqRA+DAv+IOCXVHTECDcBm?=
 =?us-ascii?Q?KXxUZXJNgC51iuMnpvlmj8EH+kfivyZ79HUpISkG65rdW3yrOSx1jZ0CVS9Z?=
 =?us-ascii?Q?2XprdBa4I/6aDxO4GdZ2wZWwJcVoDiVWIFLfXj7Lu5PmVHLBVaQVok3HyrO/?=
 =?us-ascii?Q?iI17lyjfkV1MnZwT881chdY3tuTI9FPemTOruFwHB5wc6PrQps1i0d36CydU?=
 =?us-ascii?Q?s7YNxlY0eCPy+ST6fCRhFal1c1tV0rdlTThkBaBW+fFkeF6o9yNXbiLUVryN?=
 =?us-ascii?Q?7Eu0WsHAEBqBf0FaRXuTdvQ9OFDRKhSq5kKUwuKKsrFxcW0H6hjbRktW1xOg?=
 =?us-ascii?Q?PtufSB+lpQ6zr3FTGCXE8MKzwq/HNFZ1+Xra91QgQC/744fF5Z6MqX8Gw3ac?=
 =?us-ascii?Q?D3v/fu96mP9lkQqgGD2PWs2n8ldxW2E9pbtM+liVSMBtVLvf8ZQBp7zErRJZ?=
 =?us-ascii?Q?ReLX7d6Ml9DyoLMGKeLDex7wmVp3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3210ddb5-c392-4174-ed3d-08dea069703f
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:19:45.5671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0530

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
this series adds the PARSE_OPT_SUBCOMMAND_AUTOCORRECT flag, and enables
it for git-remote and git-notes.

Additionally, the existing autocorrection logic is extracted from
help.c so subcommand handling can reuse the same config parsing and
prompt/delay logic.

Some string literals are also combined so the full text is easier to
grep for.

Changes in v5:
  - Make subcommand autocorrection behave the same as command
    autocorrection
  - Rename PARSE_OPT_SUBCOMMAND_AUTOCORR to
    PARSE_OPT_SUBCOMMAND_AUTOCORRECT
  - Adjust subcommand autocorrection tests to fit new behavior

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
 autocorrect.c                     |  89 +++++++++++++++
 autocorrect.h                     |  36 ++++++
 builtin/notes.c                   |  10 +-
 builtin/remote.c                  |  12 +-
 help.c                            | 120 ++++----------------
 meson.build                       |   1 +
 parse-options.c                   | 183 +++++++++++++++++++++++-------
 parse-options.h                   |   1 +
 t/meson.build                     |   1 +
 t/t9004-autocorrect-subcommand.sh |  58 ++++++++++
 11 files changed, 361 insertions(+), 151 deletions(-)
 create mode 100644 autocorrect.c
 create mode 100644 autocorrect.h
 create mode 100755 t/t9004-autocorrect-subcommand.sh


base-commit: f65aba1e87db64413b6d1ed5ae5a45b5a84a0997
-- 
2.53.0

