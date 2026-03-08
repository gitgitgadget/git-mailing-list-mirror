Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010012.outbound.protection.outlook.com [52.103.73.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008E12CD8B
	for <git@vger.kernel.org>; Sun,  8 Mar 2026 12:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772972275; cv=fail; b=j8ZLzxXiPKkF4PQ7h1XwivsqlElusPlL0nq9VK8u27z3MOxPiKOXbF4YQZ9Xz8m3tp5QA0+Bmw9pObZuPgTVCVFOjNtyDQO6tRyg2LUmN1FKqgiAyFyM02JDG5nuWiSuvb+id+Kw+Q2Hd67BDltqHa43zL6N2YVO/XnEkPyTW9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772972275; c=relaxed/simple;
	bh=1XgTu/tHk1a7hZeyCxDYZf4DjoGF4Q8qEtByq8oe3LU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MZ6XNa7D8BMzaL5dFE/Qj5+lELq7Z2C4tSJudz8JonoMfCmF6d0uQSijzqLb3NuTmZxHvBvReKosTpgskL6h3pVUsVGyUqFEc8VfTkRmpnnf8ADWcPWuXVlLtBv9o8y8VI9/BOTKGTBJ4xAiDllWzzttwx4ZZTizeuhcnkpapdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kCds8Fu+; arc=fail smtp.client-ip=52.103.73.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kCds8Fu+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6omesIZXe9LisEDfTSGaTyLvdmqHq3wn85AjPiQHZ1gEzTnaoVBPoo3d2G/AVfA8Tua9COpkTMPG318wIZH++M1lCKgweGYRsphfo89KjergOg934lSgs72hZkbZscygW9N+pULv8kBNWZAUGpERuXQ2iEOsfnLoc1YbbPIuC5/dr6mQAKpL7l2FyH+Y5U0LsPKngXZ7WO8n4C2oHTGAlsV0V0ZncnwtgOC0V48qefQGw1CL4qBVahs+LUN/uO1xraDbY7RYSj49vpY+/BHcprhWIjgxIAzZ0IvktpnaqJNAr9txpiNZWjRwzenkm3vAwFkrqMQmObDM2CtEZJOVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avt4ODOC6+ish65iIS5kEa6BIxscIGs+IBbD5xvCKxk=;
 b=aYARHA49ksAPc3ln/a7xD2m6Dj16mD6yG4Zm/yY91Vw/ND3dK1YYhX6DxvBAucRLG18dd+lqVrYytdLuh3GMUxwymloheqflHOY3V7pyiX5DpDXLS+uSPe3XqUXJ6vKBVvRJg3aKzBT1ONpSeiYb+JCJXTRs7HielVUxfYO03NYEnJmkAB0zYHyYKzZyMecefRalU5ZFd00ZvxnYyhf5oVT7nxp5NfYdUQBtF3MxwlmfsqZbMJDyOFFkbImqB7fId4Ztr3+xc4QsVnugFn823NpD2zAaDyGLIw2t2TDLWHyJPXx4W1UkaxOuSgSh+XuI/7e848oJ+hQQFA/taYcCLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avt4ODOC6+ish65iIS5kEa6BIxscIGs+IBbD5xvCKxk=;
 b=kCds8Fu+EFTJg4K2v863WR90zoM+xPHtOWkg87/g6aimUS4jgL4vSzzNGZZu8Ejp9k2ycx7ALOBNoTlXX4yETeItB5spa0QZk4Eemj7VUWe0OrpSFjPLx7poDDQSmiFSl5FwfxLfzIPuQYwohu+UjihaIttMaOIJPrREPiNWK/wggx07sf3xhXLdDuebUlYFeldpDQNHOj1cpQRdVH6KWzZ3rQgepVbDkG6/R877sFS2FSu1J0zopaHF+v6R3rwphXivqOQTBamH/L3aox/naokpkVF/V0QV8sATKhUBrcKLuG8y75RnqIoZhjhjfqtPG1NXEWD01UJH2bM02u2bqw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0080.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 12:17:48 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Sun, 8 Mar 2026
 12:17:47 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH 0/5] parseopt: add subcommand autocorrection
Date: Sun,  8 Mar 2026 21:17:20 +0900
Message-ID:
 <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:a03:60::27) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260308121725.2333643-1-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0080:EE_
X-MS-Office365-Filtering-Correlation-Id: 929fb888-11ab-4c0e-7b98-08de7d0cb5aa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|15080799012|23021999003|19110799012|8060799015|461199028|5072599009|40105399003|53005399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9ajKLhU4nteaZ27U549PDyNjyyOb3zoel/Ng7HHj7xzatasrYoIKqKrEIhQg?=
 =?us-ascii?Q?yPLZcv0KqlFISZz1QVWGV/IdTTNFimMfkANoOYcX4jw8BQurQ3mDEgaAktKh?=
 =?us-ascii?Q?5nos1j8rGRLSYQie4QhocoG3lmOY8fJHDJh3UnIPvs9kOp42u2X4zsmZ3s/q?=
 =?us-ascii?Q?/dl+Zmbio0smLTnPGcWyr1naN1314aqbFFRATIY8VTG0Gjtz9Kyi56z/o0IS?=
 =?us-ascii?Q?ul77Szh4fqwUWIMxcUapL9bN8V7GGmta2zQA4OlEXBUnOKP30FA2dzHhyvtq?=
 =?us-ascii?Q?RfikxkZdNFqmP7+kmQE9SNwM210gwWGoqZVCOly27ZTyPdwv/ICyjLpMEhK+?=
 =?us-ascii?Q?6dHxSn4tAzDBKIiTrI95m04FKgsMjaqBGpf2Hj771BkMCnLon/4jy+el1aLb?=
 =?us-ascii?Q?cB/ijW7Wnp3MMHDxJx6AIUeewTKrna3NZI/rZM0Dafu6tKq88MtnUFvsWV8T?=
 =?us-ascii?Q?+wH1rhVAMOI/F3t9HO0DrV0To4MmmAbBQTcDARfkGq0B3VMFj27mpEp16Zg4?=
 =?us-ascii?Q?zOUO4tyjI0wcJhOHFFDsWEYpkQDNR+ENTH8sNGcqzpr8kCs5Ai1bppHC1RWb?=
 =?us-ascii?Q?Fvh/JiJuLtkEFRtDTSb+ZsGVZmBkleCbkEHUTaPSpfv9OvCu/maB3dowa6c4?=
 =?us-ascii?Q?u019cGGcglBGWsaWCsVr2m8jMbOjATE0KprM7/rCT1/IB2lSzYCzREyHlrGo?=
 =?us-ascii?Q?vXZecUuSBoHNqY/hXQ3kpGj78iMpofcfBog6+l6FL15Hva7XeZmqaJUOWzgO?=
 =?us-ascii?Q?10SDZsbSE46FiBG1Oe5TWVfLasW3+q/kv/SCp3R0wL2nibUW4fDeYcEwzuCO?=
 =?us-ascii?Q?hAgLwO8jpRGXZQAv1FiUUjFu7Cl3eSD4cc14kSbQkHJD+dDKf9tzZUGS16HQ?=
 =?us-ascii?Q?OzR93Q46NdRGMz5cK0eqtmRLJuSleCmxW/bCWDXPk4IDJAJzzURrVl+CDWj1?=
 =?us-ascii?Q?6ESJ3qbGKyMEAFmCzUnIdA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N+erdhHSeyug8xA0fnEcjSDmH3KIsruj1G0EQuo5n15rGxuVsLToVwGb5e5n?=
 =?us-ascii?Q?wG4NZi1Vzn7tf2PcM/PiiU1MK+vI96MBOsXFDWgkQb2Kle0GjT7KN7Eaee9G?=
 =?us-ascii?Q?SQRMsRTIU1GyKdXgyWx0/zBUvEawwzD+weSsQ7/WSCKS8eV+aQ5SwMX/oIC+?=
 =?us-ascii?Q?NHvhX4SroqlUtEMnTDyA6uBpd/94oEQjuYHIhmIVI2RNElKI7RBNBgDDDn1E?=
 =?us-ascii?Q?qhkVpIBKs5y1/wzC7dvW9FziBmUF23mRKF61juAwVoFgnOfZgw1Ec1DLiQcU?=
 =?us-ascii?Q?FiYdb4LYVIDRr0QZxsPbz8IqgCY+pZnIxM4AydKFf6G/BxMmR93I/eGuIVGJ?=
 =?us-ascii?Q?OaiGFLkwgE9Gd0xLp4QqfiqGtkslhV0PmK+hl4BxnzExEGAy1WNfBmpreQMA?=
 =?us-ascii?Q?l8dEhiypNfC1v3CJ2H7hXKlHa1EenynlU2pPMUH0G9Hxgq+9TjPzYYVCdxYx?=
 =?us-ascii?Q?/ORM35gzlPg5ZnTefn8lzzfLnQ6YjKimaeN3VESVDbwVi61A4hXhdzN7JF+V?=
 =?us-ascii?Q?7hqDB2NXBNAIzH9ZmE2Wavu40E7bI44zVTgSGKJSc48kCIdRcUxePk4f1ero?=
 =?us-ascii?Q?csI01UaIHMzMXbApE9PI4veW9gpKUDYjerCX9andaQB9zXfYmAjccX39W/+r?=
 =?us-ascii?Q?82xMgragPg0M0OK6wJQL84c4CqBG5YzEeExoZdh+vWAt5WOcn3rVmoDLfati?=
 =?us-ascii?Q?APpRez0Igo5rrd+vf8r37qw913CZLqSdtZhTo3yO2KqMneqIQqX7l1gfEAbn?=
 =?us-ascii?Q?gWuYjIenFV26t+R7iTJR8PVlQIPUQnxLdaw1Nm3CHQ1H15o+AfGXmJjp/A8Q?=
 =?us-ascii?Q?2pWHBm5HtrfC6syPFUFq29DweOAH0Cu4v9SEyMh31i87NYNXYmThB/Qddq9K?=
 =?us-ascii?Q?DxqX+c73zXBlrsuK2MtbOay0WYMCtP1GMEvaRJ+E+8UriIWfNz+rLHIa2kEQ?=
 =?us-ascii?Q?1vyZ+BNGZcCk5B6m/tpMhEpyojdDr+2/Pgcadn84FymtcrhX2/b+4dTidlIv?=
 =?us-ascii?Q?GRyFyE23kosMHD5S/HQ+yk72aHF2EndnmQwUVvCUbhNJLIz8kjBP1EYkAp7z?=
 =?us-ascii?Q?RUU51xIsdEStn/2CKej+YDPuX9GxqJwHuRqikOqLQaG3LtshLBt+lX/0HlhQ?=
 =?us-ascii?Q?EeEslYUelpI6bpHzydVb649pwIjZC6bzpCX3BzsaCXHv99Vloa2VkPB5LRC8?=
 =?us-ascii?Q?E0Wwmz5ebLKi/3T00B5Czt9Taui0VWhOpTkWWtHC5HMyqDxKet5tvcu1aYsR?=
 =?us-ascii?Q?i6yXe7uUEDIUBdryl3fBLMZ459Fd6RoCnuQsj88LPGfbD5l7954oJWzX+m6W?=
 =?us-ascii?Q?WMetFJZ2YqLIoZ30tfTa5r+rY6LJOjbkdqwYW15RfhpMCZczq45Nb9acUtEF?=
 =?us-ascii?Q?ATXFpErL2bAtSHBBfubCS6TyzZmx?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 929fb888-11ab-4c0e-7b98-08de7d0cb5aa
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 12:17:47.6313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0080

Git currently provides auto-correction for builtins and aliases, but
lacks this functionality for subcommands parsed via the parse-options
API. Subcommands are also commands, and typos will occur, too. Like:

	git remote add-rul

So, this series introduces subcommand auto-correction.

Currently, builtins with mandatory subcommands enable autocorrection by
default. However, those using PARSE_OPT_SUBCOMMAND_OPTIONAL skip it to
avoid treating valid unknown arguments as mistyped subcommands.

This series adds PARSE_OPT_SUBCOMMAND_AUTOCORR, allowing commands with
optional subcommands to explicitly opt in to autocorrection. It then
enables this flag for git-remote and git-notes.

Additionally, it extracts the existing autocorrection logic from help.c
so subcommand handling can reuse the same config parsing and
prompt/delay logic.

Jiamu Sun (5):
  parseopt: extract subcommand handling from parse_options_step()
  help: refactor command autocorrection handling
  parseopt: autocorrect mistyped subcommands
  parseopt: enable subcommand autocorrect for remote and notes
  help: add tests for subcommand autocorrection

 Makefile                          |   1 +
 autocorrect.c                     |  92 +++++++++++++++++++
 autocorrect.h                     |  23 +++++
 builtin/notes.c                   |  10 +-
 builtin/remote.c                  |  12 +--
 help.c                            | 106 ++++-----------------
 parse-options.c                   | 147 +++++++++++++++++++++++-------
 parse-options.h                   |   1 +
 t/t9004-autocorrect-subcommand.sh |  49 ++++++++++
 9 files changed, 306 insertions(+), 135 deletions(-)
 create mode 100644 autocorrect.c
 create mode 100644 autocorrect.h
 create mode 100755 t/t9004-autocorrect-subcommand.sh


base-commit: 795c338de725e13bd361214c6b768019fc45a2c1
-- 
2.53.0

