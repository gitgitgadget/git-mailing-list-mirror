Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012070.outbound.protection.outlook.com [52.103.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3883CD8A2
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860407; cv=fail; b=UzKyVofOU9bEGYX/ZuIzAU93WaMSY5L+Sb8Ex6BBxJCfptWvbmZZ+RfPl6Il7G3I5LTS/oDowGQAYe+rsVZG5rLY1WehjoFT5HYVl21D9oKy5oc5sum0Go+sHc30GLQp7GN3GhFj8koiQki2cUR4oALoUs+9NoRYGbcMhqgv+yk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860407; c=relaxed/simple;
	bh=aK6psIj0otjYnerkHDQQ3u0vRnvLkFQON9yY/nQ4dyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LshTpfOXCodUz6aDXRhUtRiuzm/Z6w4ZSsTx98L1xgl5+KLcWjWwvLHVh3F+rkTlSzpxRC5No7/76pIAC/kkMghDPYYRffny9XIs3ovOVNjNVQVU3sUtESRlWXJkbm2kMWPEOf9SQco18/DSn8V5BSnWnx9U+QzGG3wbGrNCz/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IiZXrbCk; arc=fail smtp.client-ip=52.103.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IiZXrbCk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=shfN4aeyj2V4nFqXPXU5H5Mq9rWdo0nmPlPagBhjoxQ5GISWOn7mUsf9D1skbL/RZkCDK8DOLoRxysKGuqUdwwJMen3AkJ16OLYqCIQ2adu6AbtEmvIERqKgM8+jaMtCh7iohCZ9NmG9QtMPpzdL+GrGaspAY9a/a+4K0qCQFsDh0bCwsHvu3Cw/N7bdDKbTxpmHif3GBIavsxTAnrTpjGBszeI90SZ+e6vsYpEXevmgcuuRAS/0ogUhROE16phlFXlJf6UdiA0dON0dP3FDHqBrISlHgXDssiq8f99y0A8pF8V2h9jTICpgYbO1XozLnjywHPPACAtjAqKFeb0rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kB6BS/S/bvoOcn5W7VWobr/2WhKSrgZZu0VptpMoOSg=;
 b=umvC/waUYB2F2YSuEoGiCJ9IgQagZzobcjv5LMEH4ooPjvPmjo961BeuGrs7T44OrizkTnlgYX9qv+no5py88kokYqnX7b1iwj9LYZ7g0nf3VAjSukm03q/U8RaKHqh6eSJcIqxPJtjDICmc0/NPW+cYDPSHgcXq3oOn2HUiRxiiUKVo4kANakG/TI2LNcS1DwoAw5f6NOqVyLx+mQI/QDGSziXKHBbnklaYZSsNZNfE8g3qe+cLQ1b44aXzU2Ao9uG2oaSAKVaM1TwvV/2mBZ5fPt/EfvrPOx12tYLiME5elKbgY0+fomGMb/16MI6aG3oGrJ6q5HIHWi0C/OuwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kB6BS/S/bvoOcn5W7VWobr/2WhKSrgZZu0VptpMoOSg=;
 b=IiZXrbCkhSBf2dmbUfU6mQjR0BjUYkQbWAI6GduOV6C6hsxkP2zvjHp62WnPznzv/GERuoFubvfhqKoCuVJNe4Lb4hNJ0S54nqwNFchN3tbdPpMXjhp1tKW1x+i5YoDIF7wrc5XEq5NKqmMxJ6RR4zfJNq7tBzYFOXMDR36AKeTRrFQpy8hwi05C6ksG+y+1wuia+9fV0q29WIemdxJqU223aSsu0hOpbw/Q1qaLn4ZK82qFMd1rU5vXZebL1tzu1/i3SmIWipMqPXTqXbtFl1sn857CN0o1EAK5bKjcT8cgzAikUGbF2PP+6r3XEyc4YL4BGN0Xx4S8K/oFlaMOEQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0530.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 12:20:00 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 12:20:00 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: aplattner@nvidia.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v5 10/10] doc: document autocorrect API
Date: Wed, 22 Apr 2026 21:18:10 +0900
Message-ID:
 <SY0P300MB0801D8D5DCD61BE70C05395BCE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260422121810.307862-11-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: ca60cd6b-c518-4f6b-eb97-08dea0697906
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|16051099003|25031999004|5072599009|15080799012|23021999003|461199028|8060799015|19110799012|51005399006|55001999006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2bTkb8As9G+a0PheMDRw4zYXCP88DDqG21y06DVR8eIJo3vi2kkZ3hqtLQfz?=
 =?us-ascii?Q?bflSppxxeq+YkYIfdjHGMXdgardFOqaO0h42JI3nincxo+uyGPOrZywGy6Os?=
 =?us-ascii?Q?Q2ySr14rR9pXzxYr64p2MQCtnLIL2XnnF3mrm9ag9CJeop8FBr2qesIEW86U?=
 =?us-ascii?Q?1ilDC0L9gMxcEwfOsuYI1FFPmTMDWSD5xT1Kv7FmIJET8mcIStb4GMSCq2rB?=
 =?us-ascii?Q?Uq2NW1kbKE442vJ9lW9KXLU9OJ9eRYFtpJeBKqDbQyxOvgUvE9wpaqbRrXnH?=
 =?us-ascii?Q?fJYMW//0k2tjZ6BsaIw/Nr+y2QgHef5xQw4pzXYC02J5UsMEpRA/Ku8DwaoO?=
 =?us-ascii?Q?A5fTJEn3HylrXzDpejot9Wl5XvWj708lCnfwbrEyBmoMzw40PTCAp4YrZeh5?=
 =?us-ascii?Q?6r1RHrEns1bDdGXWzxphm5cJIhyGF9oMKJZUAt6feipc26oYPgbHXpc50KtW?=
 =?us-ascii?Q?SJvZCsLWC4Cn98AIU/DRk1GWEBF4Pjaqq2+DJVf8xSXBBdWyMvuSPivMWxSL?=
 =?us-ascii?Q?+OWpXPgNp0gEhKVY3dbs1mvn6tqUf2UokiKjOhwI7/iMlbpTvDR1CLU+jKm6?=
 =?us-ascii?Q?sT1e58PZxgPV64VQy8dvydG2/UDb88FLpBHru6t7ABFhmJBCK2vK05LsNjpL?=
 =?us-ascii?Q?V94TqBQV0EnB6R5VAV9vxt5OfQXlromMo39gveBUREEFJow7teJPO8lgzvDN?=
 =?us-ascii?Q?e+9O9FWsvhHOQMlN2UYQaA2JqRu89D1hqdSp+Oqql0ftcHwVoPbWtrTFcH9w?=
 =?us-ascii?Q?5qzVROAJ80V/4ny0l02kwMZs3pNnNoeE32sXROAlMIojewU7uwI8lHNTpiCM?=
 =?us-ascii?Q?ibrhuPUDZVUSYaLyWuKXccv0IbfGLmXCrYFz/Acs0qRrC97M9qtq4oQqNlxr?=
 =?us-ascii?Q?kr6Viv95s0+PPwzSz540kp6z9bVBuHKrNDVu5yLHQwyUr1zMeOxIlyw+Cvra?=
 =?us-ascii?Q?FCeXtCENtN/tAZH5wOc5GDTpbUziyBTZNdzOQgXvrr0NQ1JiRHVA1DlGSVTP?=
 =?us-ascii?Q?WArcxeqrUcRLMrA84sa80Kgy+PrLnKyIsaN1rjawez16T2w=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t2NYTg44Q4qJeYB0YMmJwRtZ1/nPQJjs1Pf922YjyD1UQYdpCqY4SjnJIYwk?=
 =?us-ascii?Q?gd870Sq0ZdPoFCzhgkzdKOeCox8ItGMUhs4l0ejGkoqXD7E7SEqVU737txB9?=
 =?us-ascii?Q?jfXlwrnxA069etGn7ehJeSlBYUoZqKEnvrydc9Xi4sh6QCWQhgQpslOLWHFC?=
 =?us-ascii?Q?g52b4t+fbvk06l3flRpCf+k/azGwhdXxtN9wrRbK3BmDpocc5O7vWXs1vXIo?=
 =?us-ascii?Q?CiKXT4b6NH6iNWEN1WibjGj/ZZDbelgqpauRdnlGZuMfen2i+DofsdvTYBds?=
 =?us-ascii?Q?I3c0IHd4JJADtZnXBWvANMbU8h35t/zXa0194e45S7AxkCucjXKKApLIyLHO?=
 =?us-ascii?Q?1PunfhNwBXT+ZiyzIXAOY/ayGWwmk1vQjO0RYrG9CDPUKPsVVFHCj1UUd/PI?=
 =?us-ascii?Q?uQDWf2O8btKqizXWnwaoh298UHh1Yg9IDBPV7Trc/SG9lOaFWcnLjGCcwxlg?=
 =?us-ascii?Q?iVXNZApQJ2qTYf0kBpPvoVzlP0qLTjrPb6tTvDNkuaajg8K8/5OC+BDviRZo?=
 =?us-ascii?Q?cq0Y4hKcLCe2+76vye8RzoNG+TqwHKXBf9AZVJr913faRimW5XNhI2jZ8AvX?=
 =?us-ascii?Q?1PxOuFSO5DsBPSYxIE+Y9GKiXib7S9AqzkKYuOfhe/aEF0KyYSpqweRw9mmq?=
 =?us-ascii?Q?cilNXbnVTCrCFrGKLrXotW9k/JcqsLOzHVR7ilmWDW6XhrDUPFGyz04qnrbf?=
 =?us-ascii?Q?EiYCls6asxX5OzB4/W+04In84ceaXPruW49fyaYrI/lcYR2xH3wFlKKt4BVj?=
 =?us-ascii?Q?cqK4RJyHnXky6lqkRutxI1FeBbRiFW5RgD/ipSpluHytNDItnHtjraldgOPw?=
 =?us-ascii?Q?eRYft1P9q2kaiaxEH+yiWdsJKRpfdwjmTRAJ2hcJ2iNw9mtcpmIueV6H3LYI?=
 =?us-ascii?Q?WCIKTJuIy+aNNviGYF6JB0hpdaJxXRAanirpwF1SLDYI7HVhgAqjymVnsGa9?=
 =?us-ascii?Q?8/ZnVpOCxUOlHuM0p/6xekkyVTVlK5Sv2cqPBdF812y1ylJhxYEagcBZKUO4?=
 =?us-ascii?Q?dsnMVEYS3iFgoLpXMBRJ8ZL+mXUf323A8cJa7w/6az7RATO74kiJx5cZ5TAm?=
 =?us-ascii?Q?SbDzsVoAcZJlXYJ67tN3DBXBy5mi5eX6/hecsv7EqTroAGvoQIkHqMhkLgPn?=
 =?us-ascii?Q?pB9a7ktOrmxLJtzKL9O4E7YfYSTqdau6MEpARiAnZHYKBTTJMX+B0LW0q2vQ?=
 =?us-ascii?Q?Ww2HqX20l0UU4v/ogeJj9573y94OcQZiwk4aMYD/Vm5ai8Z5LEP0uTht1EU6?=
 =?us-ascii?Q?2qxV1AvsaatlyHSnFZkdqW01TV2J4ZmPJvvLQYbaEHopwsM4om7Ft/3eH6mD?=
 =?us-ascii?Q?ksz45uT3vzAW2Yo8F3eSc+MyuYbxhX517+KJSiEOREC9qAjIYJgfPN57RgKU?=
 =?us-ascii?Q?yC27Vny15Pl9wtWpC9atm+2KHTOk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca60cd6b-c518-4f6b-eb97-08dea0697906
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:20:00.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0530

Explain behaviors for autocorrect_resolve(), autocorrect_confirm(), and
struct autocorrect.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/autocorrect.h b/autocorrect.h
index 14ee7c4548d3..5bb67cf6debd 100644
--- a/autocorrect.h
+++ b/autocorrect.h
@@ -13,13 +13,24 @@ enum autocorrect_mode {
 	AUTOCORRECT_DELAY,
 };
 
+/**
+ * `mode` indicates which action will be performed by autocorrect_confirm().
+ * `delay` is the timeout before autocorrect_confirm() returns, in tenths of a
+ * second. Use it only with AUTOCORRECT_DELAY.
+ */
 struct autocorrect {
 	enum autocorrect_mode mode;
 	int delay;
 };
 
+/**
+ * Resolve the autocorrect configuration into `conf`.
+ */
 void autocorrect_resolve(struct autocorrect *conf);
 
+/**
+ * Interact with the user in different ways depending on `conf->mode`.
+ */
 void autocorrect_confirm(struct autocorrect *conf, const char *assumed);
 
 #endif /* AUTOCORRECT_H */
-- 
2.53.0

