Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013073.outbound.protection.outlook.com [52.103.51.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D958D19D087
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760173401; cv=fail; b=ecWULdG/S8CxI3HMrWbk93SucYSQDVL+CJja6t+2BeVq+C3QxJAp7u097VbyH5+UMPo6JacztQ3qcRAJtNGrpz8A7jdWC0Mo1ZNrLNmSh53lPx0i5UMGoeBvejxZgFfO+8qwYAR9hPsjYJuz7U8wv6np5qZIchtIpt0/eCr2Ykk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760173401; c=relaxed/simple;
	bh=/DhPJSIGdoquJTXPl72ND19PmzwUN0yTvRS6I2J7jzc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=txiAVFeProKokYxt0SbJ+fyAZl+9qdBNF1R/DdkFfq0ZNE1Z3q4BWFsN/Hpxamb8rImX16xKsGgO/HhUUdVuWoasJ5riiQ3Xxy3St4GsHYKnm/Vg1QQsEDOQZYhzMVptyACClr0B1ZfVW8ALj6QVX9TWLGhn1X/EuIUlQ+IMkoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b=qBuKUGaf; arc=fail smtp.client-ip=52.103.51.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b="qBuKUGaf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G9Tia6mU0fq2E8VhwvXffhKAhlKS8PtdLKZ55WNMY8AWta3bq7Qxe5tHJ1ANzB4/esyLTnLxe/gbZpHLVT3UOdnbLaDkjUbWr5U5Gsv/yF4c/nDRJvS9Va4uaymSkKsHbKbRyyfGYYUEfyr7Yz0azf5IbHGv11FrdzARcVf3D2h9FolYSwFQk+RGu7FQF5ikvTGYnCHY0delTJC+X88PdW58ofeWei9HU7a3X96aaoKYVchGM8AJxLN/qmmRZ087L8wTAKujaIYkqsXaeoX+Kz4LCNVNAX2TDbXY1CQFe/jb+7i6Bap1IOdb8JPRANdWYVUiMBjRCo7PxRuUb28ZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dP9VH9Mnt4fupa9qTyvxV5GsxF1k98yqjwIf4/dZGYc=;
 b=b1DwUF71ADQ5iTlCV0srcsB1G+Fyn8ZnUbKS+1LIQmGEOXWHd69U+hSNwPqyYgpkbZ4Jo5cNyVKFfEa2v42MGSfKhQGvPMjzuVjBL/1EANHZaUt62NR+3vmiQJeJVRw0hZsRqi7oR2d8f36W8z64Lb3NEUhgA2m1XZtGad9x1wiNaKfmxWDh6KgghLNILguPTgTEWzFl7VZaq1ljnfiXc31tfSCTHIxvS2oniah+2VcIUQ0866ABw6zBIHt+S7OYJzPBtyvRyVMg6SlWTGKP+Dt0vP4W5zQ0+kczTnaTOHwUqoS/u8J8c4X9+xQliAIgsFjBt3G0fMseSLhnNe4oCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.DE; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP9VH9Mnt4fupa9qTyvxV5GsxF1k98yqjwIf4/dZGYc=;
 b=qBuKUGaf2a02n4uahXc0baKNJNsJLaiFMfciBbXiuU79cA+oW9FMi8G0rP55CliFlThg26vyNNk1WRG0FsZHy4sbtj6eDNfW4f+Ppbaw5WF0z31NtrAXB/equmeGmhFgwxA2GTMBNU5yBTSsFoBGdJ1d99NSI+GaIl2bVtMYjV6K4ecYG3tSmCvvgV0j9w5z/nShHuSd2q43xw0lzMjLQbhjMN17+eVkbBUeD1q0hCqrU0kBUn1lF7l/8GtbyhSUxSctETe9gwyeOTD31dVDvGRtA8LTodEYCGyRFRq0hLgnWE5Wd+Z0wJZ0TOkWGVtXu5EFh2eApaEDWW+B0g4PtA==
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by DU0P250MB0794.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:3e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 09:03:13 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9ad6:ad31:a192:5183]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9ad6:ad31:a192:5183%4]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 09:03:13 +0000
Date: Sat, 11 Oct 2025 11:03:04 +0200
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>, 
    Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] mingw: avoid relative `#include`s
In-Reply-To: <484ef8b825e5d1d68a61f0f8cc2520457e8f4f3a.1759995961.git.gitgitgadget@gmail.com>
Message-ID:
 <DB9P250MB06929F022ADC9A0544947BDAA5ECA@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <pull.1985.git.1759995961.gitgitgadget@gmail.com> <484ef8b825e5d1d68a61f0f8cc2520457e8f4f3a.1759995961.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR2P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::17) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <495650b5-7d72-1a38-8cb7-356f93e13821@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|DU0P250MB0794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b68c173-0909-4f9c-73ea-08de08a501b6
X-MS-Exchange-SLBlob-MailProps:
	feAVlmA1hHU6APCFGZht2co3ezVs6esnDtYQFpd5BITtBcgCHuooYzPKGHbbfqDBNIJmudZfEEg7hSWUfBCKMKNBRXEHJ2wYAaIImhJWA/NE34Uf3alOQZGpN0pkb2U6vo07r4bVWehhIgh2CnPtG4gvcQclSH6LKAKg8hYduL/CxVQBnCgiq+RAnYlHXj06DkQNiNMSv+c9cx+ls3x3d492mJUWAQSPwxvYW7qlM9X/k9G6EMCois6wnGtJ4qu4VtEVXL05O9VzxNExfL9EzJSTcmLmc9q5CbKT96Y67xtAPnuIbgvmumZomeiwWLCQdZWW4tZG0l6lkCx06uPlQYRNQYZDh2NNyqnCu16L4redQD/B8VpmvgVtAH0ZB84OC63td+GWczvsIDXXRMqyiMT2QdDTEg/HEZiw2fkFDJi8tdlL/Ve2leXryWeTUewVPEcniza0SC6E9mz6Sw0fFEv8bgdM1CDQWreI+8FwUATubIKJ8OAK24N/ODFAYNXmbz1ZCOpaaB37ZKsabr9tu4ba1lSJ6A3/Xj8c6TnrJaoSTFAoyhJjWpS+RerIMQP7KjPgLnn8ifCPEtY8+m042kU0+V9uPVIEYX3xCaeAMBy+hi0vZM0BBSI6zHKaKiV5QKFUoDHqgcFT4706/tJl2MaOs//xn3eGGwtqTOosA1kVsGF2CYrLY+oryUD9ZCJ7wzrwgghacfWxzly1bUnm4w==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|19110799012|5072599009|8060799015|15080799012|6090799003|23021999003|40105399003|51005399003|3412199025|440099028|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LOzRIAYArz5A79gUUzoZpD3fxPvSJNHZcNstd1JuMLaRRx7Z0+73o2ILN3wU?=
 =?us-ascii?Q?CLDXyDTLekyi5UbLAT+0jvj68n3n85v63WwQCN04ncEw4fmu+pTB5QUq3222?=
 =?us-ascii?Q?OIFeyHZZS/AhATOsPGkSesKdG8ZkK62nwTxWwMKgVtu1w1tPhmJkjTr2lSyt?=
 =?us-ascii?Q?5ZULK+bxT0fcTCceFwTw+9LQH3mQhuCxxX1diXzdlVUP4NqQZOtVilYwKpNH?=
 =?us-ascii?Q?Udyj473gkBX5FSl0pmGn2sZWSA1GdGkpGwg71wGEHQS2JBeTU3e0dt/zrftg?=
 =?us-ascii?Q?WZndpd3fjumo6I6WF++YdtdGSeNS+kM3N+pE1Vw7V7xFe/D7rXS0oYLa9B0E?=
 =?us-ascii?Q?mDmrc0a1xCONCgfIdEL8B6XiG3bh38AIkinu9Bc0vPNPVMRiwxNcvYfAyilH?=
 =?us-ascii?Q?yccjweQBNzHOtMcdfTgqqbpWw7ZAXN/PJpVa0PsS1l1Mt/DDgfoLvywWjdMf?=
 =?us-ascii?Q?jfip3i4a9TT9qsARi9qXEXuDpZzVzpBWJO5whnlCeOPQtK2T46DXrXUkavEM?=
 =?us-ascii?Q?rFrlSV3SGMqn8DvOrSTf5Nk4RYXbt/nDjhrZjXlmzP7ws55Lo3+v5LCHpWSi?=
 =?us-ascii?Q?Mi1ipi0zlj4O5gmYhP9Teqef9TDVTDmspjK6oHzRm5bhzwdLZ8TXklUlcVq5?=
 =?us-ascii?Q?ZO/bqayQIeyC+BkCtdJDbGU77h+mjbndoncwYelptDNWe+ysdjJ8NiH6DK0I?=
 =?us-ascii?Q?cO3ghqnSti/JpE+HzhT/vS6xF+sx+j6pRRQAyjdTKz96NnHIM/jhPMqoekkU?=
 =?us-ascii?Q?qXiehlRNIlFb2PUy0TPeiw3XdcdA6guDp2BnfgTN7DtL1mH4MWZ3ReftAKXE?=
 =?us-ascii?Q?OcAT3ycWk7U9+TEhjBd1F+6VgcfMaR2t3paLlZp31fhqxLv9TZXFbioRk2M4?=
 =?us-ascii?Q?E0A9DkG/61jtOPPwtzS5X2Ad7SJNxi4B9Usunv00aGDdWy6okKYXiTGIplvc?=
 =?us-ascii?Q?H+3bvhS2TW3UfR44haixL6Calfh82eW2nm3zsrOKY9q2BD1+PtdW3ZGlajix?=
 =?us-ascii?Q?j4k0fxZyIpobXoKNADM8ZpKI0xPgsBwMzLZa7BHLvdnbxQytVGqbK2QF6DMf?=
 =?us-ascii?Q?3UzzcC3yIGgrQ2g6n1PIYScxWUEb80xRX+rdleDTG40ao2rvg/nqR5OUxnO1?=
 =?us-ascii?Q?Hpla10Wwcgd44wcEnMvBMeaAd1xVbsBRBwjBHRKFfpyQz1yrlZ2NpmWbXVRC?=
 =?us-ascii?Q?Oqot3z9fuqgEvdcJMMnFC21Xyi/1TqPvhjt/T/OBEyfGnvnIIbK54l0FFVo?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZAKi/iGkkThNojwkDwXFRk9bstcv1B4C8/5lufvgmnVZuFBsGx0n2Isn7yJ9?=
 =?us-ascii?Q?mgvwkJFXZpVv+Bvir4ALobNn0d45cw3TOPnRkvhr9MlbICfrlOswnnVyEoN+?=
 =?us-ascii?Q?3RV8W//hMx/XYu8OIC7sADUtbFUA7a+fk9MXhGHfhL8/LVKT8OewfbmZqa6k?=
 =?us-ascii?Q?EpPMWshoMKqS02EKkVs66MgMBkh6gLEVWvlzLvj+Z9bsaEvif8BkLyCMATyA?=
 =?us-ascii?Q?c9QCB/aK41FZf60f2b/mfi1iekaEgICxoIeHVpyKze5O/EI2dTrlTSIcp3eD?=
 =?us-ascii?Q?gx1hxp8YuGSr9LtJpRJeXuNCjOJMXKn8m91GX2B0T/AP9lh3akQrMQlv5YFD?=
 =?us-ascii?Q?v4XZWvqs0xVMIh+6KaKARLJHo2NYed4zMWq0rxW/rgZ+Q8mXJ3wlJSEWi639?=
 =?us-ascii?Q?M93ouovpz2nudJ6RO8cqcKclMsoAwno8Qe26ownCmyBr6nL1dc76HDVLKem/?=
 =?us-ascii?Q?l7Qh8POLa6f9SLSx8kUqdSlbrRzDNOhk1BBB1gXQsABZkmVJbEFV4jCF1lqK?=
 =?us-ascii?Q?xA7wvLqSN2v7WqUdP5PhEuDdae8HAGALapfHz2WoIv7k9FWYNuuEKdxz9XU1?=
 =?us-ascii?Q?w0mobogWqWI6ROAJ6EVQPW7fWeh/C5CguVpHZuzoI9kl/8koFUDIN+oP8NMP?=
 =?us-ascii?Q?GYRS44PD4uRbWS+NwbitpezGTpja/l72VlEi7CX94HibmuZBA20rJox2TQvv?=
 =?us-ascii?Q?U46lOHV0s/IA020cDVa2sk7xS9VRbwBy8AQtiRxclO3ItW1rvBntUF312kTg?=
 =?us-ascii?Q?H1xU8nDmqaVAIOp1h4ZY6fOiCl4BDH2PvjLnLdayNMSNuW0UN77NJ9FJC5Wr?=
 =?us-ascii?Q?zTlAbJj1MK7VGdymjtSpzNyyy881zX8cJbiA87rckX8WsVRk8i2SFXVjh7+W?=
 =?us-ascii?Q?iKPA1u4NAN2x5Mc4h8u7LXKGrhcpf82Xr7EsQaV0H2cgxWtFmcYWseeNJ12q?=
 =?us-ascii?Q?nh189kQK+UkMWySUjg70+QADrOAgGKBn20uS46hZeZJMpNg3smL7nRdtLCY3?=
 =?us-ascii?Q?5ejFRLqq25AE5NHeCcYZP8qTlUGqUEje+EjB2liNcs1hqR3Ws2qWwYZS9uTu?=
 =?us-ascii?Q?JppYowpkdRPkql4K8eXzSDw9eHErAvix0lTrUTmFfoWoY3PB5eHuEuVWL5ns?=
 =?us-ascii?Q?jMsJhrWZ90XEr/hFtkY+cry+pq5qcyjpihr5DSAU9XTS5NpJ35pbW6rXUv47?=
 =?us-ascii?Q?YfG6YTzveoegyidolo7emkotjvECJXSKJ37oj080q9fcpSC3zTexYKPrpFs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b68c173-0909-4f9c-73ea-08de08a501b6
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:03:13.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P250MB0794

On Thu, 9 Oct 2025, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We want to make them relative to the top-level directory.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> compat/mingw.c | 20 ++++++++++----------
> 1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 8538e3d172..da99473f56 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1,22 +1,22 @@
> #define USE_THE_REPOSITORY_VARIABLE
> #define DISABLE_SIGN_COMPARE_WARNINGS
>
> -#include "../git-compat-util.h"
> +#include "git-compat-util.h"
> #include "win32.h"

Isn't this include also relative to compat/ and should become #include 
"compat/win32.h"?

> #include <aclapi.h>
> #include <sddl.h>
> #include <conio.h>
> #include <wchar.h>
> -#include "../strbuf.h"
> -#include "../run-command.h"
> -#include "../abspath.h"
> -#include "../alloc.h"
> +#include "strbuf.h"
> +#include "run-command.h"
> +#include "abspath.h"
> +#include "alloc.h"
> #include "win32/lazyload.h"

Same situation here.

best regards

Matthias
