Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012008.outbound.protection.outlook.com [52.103.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1212222CC
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908298; cv=fail; b=hixQu9afMqIiHrJg+b0jw+wBmsWuNSg8Pxgpz0m/dpL+EGqtq1Ixjv5whtzeCHrpAJcMXPuXnl4QmYDxLc5w+erj67qOWjavd/2lv0uFojgjPg6oue9TQCX4yAWfKwm4h6SrnS/emJXkY33jFuB+uG1St8N3FCpCgvAXjpDJBwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908298; c=relaxed/simple;
	bh=x/ZjpRGwSOIL691lanRpovTz0QsOpLvvVKrtlhgIm14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KzFX54M8c8chClxfX/5Vt8rnzCMms+t90A4nyeAD5T752xPnrNxKucidRxAWsI7WfGdpIMvndn7+EViCsFWo8iAjIDNmaqRM8B94W0RqPOoUUB5u9pNF6zWebav4WZfwOnOWVcAF6t5C+9mdc96XWyqvQHc7w5A6Y9rzRRHwdK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qbpYi6mx; arc=fail smtp.client-ip=52.103.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qbpYi6mx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUuSIZgo12L8JP+Xm2GbFtXqgAD2459pI2DJ6Egb3GG4XttEHxEbGSlWTUH7v7mOXqVqnEwawgFnW1hsxifnprA9ccaR3tsJF4Vqa4+YEysUbEvXvlUNzmkJa7fmRgleef2MsVDDajB4qs7yKxgyDkcQ2f4HwwQtI+HvXjerrZwMJFgKg+kLE2FDUpb/4i8Xiwh0uvDIB3kLwNi74m+RR+QboHXPmjMQk0p0tM5+y2pUsonoK/0GD+EO4zEYu7xKbsrlGaSqSfSBhFoxk0oarctughzm4ngeBldkgN1dBRJU//Oa3GTQ9Nb5ccCLjRupvcBnuzVQdMhVgciHjdHUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LVEenND/ln7DLwPYeMEwY90zVbSrCOjgKIsYqgM95w=;
 b=DeNkhSq5B9ZBQqY8UaIjKpwsT5pUGOTtqwqYxB2kJlT8wtF3eBEnynosEjanfRy79/erOAfarrk6sDQ9lRxcESv13YQRYWnARDFNBv/GAXoHYCkQxx7mRbTobeQNSSJ4vVgIbiBk4r/noUwsDmVXBn66+boEG/vyG0VQeJ+ubI04K5X3T8ddKMZ/MgM6BH0eWpzGC+uudkC2fuEscCQhr6zHvxQhlPbSIK+Xaw0v7L/+nKn7QEot7CvVxLStizhvHnZ2JJy8IxQRRfJ/EpfQ/T4shH0vbc2/EMEdkngqB+OR3ColNfFuHOdT11BiXTV5lzxIWcAzD9dV8n5HFPMHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LVEenND/ln7DLwPYeMEwY90zVbSrCOjgKIsYqgM95w=;
 b=qbpYi6mxJjD1qnNJ2Nta+n54k9eJ6yTyRfNH6aTfydtXuqoAQng41/x3OqkZKOcsa3xxVoTZJz/aAzkzs1ozWia0oRsianPYhu3lmLjOWNqKyoXAnmgdeMTd8+oTnAb1JrYEXIV82L2Cvx+lPZ/qSGCFCHkUKVUuW1d9saiKuC2Uoh5+SYFxe7PkhpdAKK9KHizWdKghAXFhLq/g7RbFHPI7tqeblnFzcEqUIFlXdDGa79TfAb9ZITvcJNgIFQ6taZN0aIUzggUkF0Q3r07cYxMhsX70IAu3g9a/XurFFaiJUI+bcq4j6RnUX75p/0P0zw+hpxTpFJBHvneQxjhN7A==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0270.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 01:38:12 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 01:38:12 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v6 00/10] parseopt: add subcommand autocorrection
Date: Thu, 23 Apr 2026 10:37:50 +0900
Message-ID:
 <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260423013800.82156-1-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0270:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8bf799-3bbb-4f33-9869-08dea0d8faa1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|19110799012|15080799012|8060799015|461199028|5072599009|25031999004|23021999003|12121999013|51005399006|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PKZT+hdJBU1yq/n0BwU5mBANOpbbeQXUozy1yCeLqzhVyQdt/1LyOuRCq5RC?=
 =?us-ascii?Q?Pq0bkRAxxu6Tx0c8psz74z6eNGdSr8bD8kbvpukTo6Mzx+v2S2tLh5P7d6lZ?=
 =?us-ascii?Q?ggAvz9CykOF1Dzv8SqaqAc0yAWkJEIJN4ibylr6DsudXZrpTeChteu7fSesa?=
 =?us-ascii?Q?HN4/FUdPMFlbs/bmDWEI4TA4De9Fgg4FANMF3a352e5+fPC4EHU+33e0sF2z?=
 =?us-ascii?Q?5C4ptdSeVhUyzmXhKxXyy2cQha3JNo/hUgeFj5IdNzSb8kEYyxTMfIxej2u1?=
 =?us-ascii?Q?FEQ7lhYFWG0V0OUOfKEN3ydqmD6t4Zfebglhm+PZY3myW4+I0OePzXqwpW0+?=
 =?us-ascii?Q?+6e+0Td5Fs0Jka1SuECnW1DvjSpPrHihconu/aaYD50J0dcUt8BJ9zicSd5b?=
 =?us-ascii?Q?Dqpa+3XZEPKZ8toEH4mIYY1x0UmLqEZooYJ2nJfoCjEG5x5otaxNI+w+t0Qs?=
 =?us-ascii?Q?U7qf1iH7m1qyZmquyw2OO7cr93iFCo8eW6h0E7aNhvv+/8RuzvF/46GsteL9?=
 =?us-ascii?Q?1V3cOU1OOpPNxUCXerr7YA6Sx/hWF9IzXYbBcWetGwwkG6RsBrZWq1yqa4bx?=
 =?us-ascii?Q?Jp+Db3mbbSdcxyoBwfqSm8EDpBRRO/OrSwOwMXV35d5zZ6FKHt2mlUL05tOx?=
 =?us-ascii?Q?BYk1H34qrcAMLe5omVxRQ9HYnajnw/3BnlAFOt93uqnzKU9uTD8TDPfSvUwP?=
 =?us-ascii?Q?z4qWrD4bSIIx93s49R45QZaDA15r3PXEbV5SeBPvvgTLnsPReA6lODYOkQuH?=
 =?us-ascii?Q?SJGUwLkBJYbszEGpgYidKeR9e/cMGicuLYhJjd1M79M4V3ioCSJY3ebD939w?=
 =?us-ascii?Q?0SUIaP1f3Vnp2KZT6Ov2bvu3UADtOh+3i1tea1wg6+RzW/p8WgJ0NqFXt7At?=
 =?us-ascii?Q?6wFEJvS23KvZscqQHG9x1aT7Oxc0pDwY4QdFS8k6tR/Q/1nBUbS18qK5e5Nk?=
 =?us-ascii?Q?BqMYOBoPVZf5ZGn3nJAGKx1wNIjOBLNbMfqk61CSL9XGQLhPxNxIP8jrfxAI?=
 =?us-ascii?Q?yKwaIRzGOBbS43t8FaPkNHiKHsuqSZ1S2GrL/C/YR0JPXfARK4m2J9fH43hE?=
 =?us-ascii?Q?KjPAJBqf?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G1J2WJ2YsVIUKQAO2+9eSbYbLquh64yROihEiu+0JKlIn37/kf0/QZeD+q5a?=
 =?us-ascii?Q?GKh5guZyY1Ef/f7zofWKax7oueF/eKPGmPh/YBJWup0SvI9vWnlGu6ogdeEz?=
 =?us-ascii?Q?6OzcYF3W05JNGjWgfWwbL3FAbPEtMFhq/pty6KvIdiy7tJ3Us8FTKpqCdG76?=
 =?us-ascii?Q?q48g8BLejgzIedJfhdMnM0rjY+OR1718z2fK5Spj0dHUYkTEIWU3a1t6KH9H?=
 =?us-ascii?Q?7PlSCzQngwHKEV1I89J6Zs9sxHBH4UrG4TSt3V5JVd1ENoRAtczXlmigcfXj?=
 =?us-ascii?Q?z2hK+Ed08gYrGEiagGy6QJmNJFYLKRlowmmN0N8h4kyulZQrR7ikrfA5Y+c0?=
 =?us-ascii?Q?AgwcqkkTwxfgVcMefcpZwFh/ZLXlwKTJPzGXjAypaJXLcidaHsGUsqcvYADZ?=
 =?us-ascii?Q?42pHA25nrToXvLS1dmNOyvglqR0lhkvgKyDmiX1+7wVb99d7lh6ZpFKfJdPB?=
 =?us-ascii?Q?44RjnyfZQif1oqMvC4n3buBAQYaBi2vKL4aWO5gR6ULqK4sZFz+WIj29xEeA?=
 =?us-ascii?Q?mKEXpKhU6ZZdXEEZN1H1LcV7IdlM1qFc7WqTJh2Cs5X0VTFPBb1ublgbTPhn?=
 =?us-ascii?Q?yeyctsBVjrrwvhQocifWt+WfZtAMcI3CZyf/8U8be5i8I0qXMs3SjuLfqqGM?=
 =?us-ascii?Q?viSEq4zL1i/f96tmDW5Obi33QQl4L93sTvwrVx3LzeD2Zby0pdQufoNTr4GD?=
 =?us-ascii?Q?PFmtB1oHwF1ZjSkBZQDBo3KkGDQHvmc8ekRLZDTIjL370e/C2dLy0Wn83Y5f?=
 =?us-ascii?Q?zpe3n+pahAUrzDlTfsV2QtUfYneRaaJgPYgncuxM0I07OCvIicByWuGgIMid?=
 =?us-ascii?Q?F//V55UkMhUMQDCUiqatBFfxUH3jZkvHZW9lxvYwnN75Kyx33PaYwAwX7b0t?=
 =?us-ascii?Q?Ej/KtaCUQQ0BDmn+vyw0NHeWKV8lR0qFVo6jdA0SNTgHgIAuYImb/RTELl3q?=
 =?us-ascii?Q?MjLleuKRtjx4I1P+cI8D37ygIlVdRvSELd5WFooP3TixGc0R5+8O8Lzi/yd8?=
 =?us-ascii?Q?2Soi4Mcxq3PXfPn5kjYZqZKIZoqDQd7eFfFcI5N2p8vrjxak3WCEbrVyC6S7?=
 =?us-ascii?Q?/+ZdhelM3uIPtDwUWWGZmkqCDaRw6WW9wHcvZpX9oI8TzkD0pLaBaB1QdSsG?=
 =?us-ascii?Q?CJI61V7pzadpquoS4hmIM4N43++WzuFi/C2qUAKQ7vdHTV9+gWW21uRSezaN?=
 =?us-ascii?Q?U1P0u3ZvdFkrA9VcZBUWpngpA8zQEOCV/NsLpKJje4iglWzJu14yKsc71wlu?=
 =?us-ascii?Q?/T/UlYUQ1587W/fJTUB1XYtZZEZ6mEn3ZKX6X62D/JVSF1+XaARKAWPLZqA+?=
 =?us-ascii?Q?SE1POZFPlWLO2pEln2rOaMIPmDr36X4erpaYw7XCIUxCcPCrLMtr/L/kMCxF?=
 =?us-ascii?Q?Okhx+oKPtUeNEmIm1bpRNkU/6YDi?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8bf799-3bbb-4f33-9869-08dea0d8faa1
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:38:12.4677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0270

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

Changes in v6:
  - Adjust existing tests to fit subcommand autocorrection behavior
  - Change the similar subcommand hint exit code to 129

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
 t/t0040-parse-options.sh          |   5 +-
 t/t7900-maintenance.sh            |   4 +-
 t/t9004-autocorrect-subcommand.sh |  58 ++++++++++
 13 files changed, 366 insertions(+), 155 deletions(-)
 create mode 100644 autocorrect.c
 create mode 100644 autocorrect.h
 create mode 100755 t/t9004-autocorrect-subcommand.sh


base-commit: f65aba1e87db64413b6d1ed5ae5a45b5a84a0997
-- 
2.54.0

