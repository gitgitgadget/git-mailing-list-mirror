Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C17289353
	for <git@vger.kernel.org>; Thu, 15 May 2025 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747305254; cv=fail; b=VT6uWLhhfC+THRLnRTX0OFR/QmCVsFjWXOjvHh5g5r3GaCB4EzhQEaLTjLRsNnWtCsOm+/+0TBJeXUBvpa5u4eSzuMLW4ETWHb+Fg1Gq2DFA3V9iVf/ZVmUqddztR+FfIlMpiQ0hXyl3t81nuaLpybMzr/XteOPMp7FgQwUI7W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747305254; c=relaxed/simple;
	bh=PLaRJWD3//4MN3PU1ZjMN3Ki0DxP5cztveqFrFcvHL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Js3IOfaA1y9foMN3jhWfBG4snKc6cgdIIAnlKKj2ox4uyHW0dB8ATvKEpPM8kouLy9H1l/Ulpuro34a6YwgoVU19RbApLGUqzyBFS9vMIVyKegMP2CMdFh/C9GxUhslUJdkUBgNrU5T1Ndr1DV3zPredSDAIv1lkO1L3+hNMPNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=mAjdFPWd; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="mAjdFPWd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkZlvO8d5gBEUUjGCSnSTyXTMkeWH9TAIQ43U/Nej+dMW3RzilwqEIIgQBbngvKt2zq7xXc+NRCSnf/KuVJrrlWO/LgBcnYNQsXO6gLW8eQZTRwy+Eh/ZXQjTovLhsOrF/46SJu6ETEX479eTUVVhFvqjNZBWYDxvKm3n/CLWguLPoBM8BlyXXsAlC1OxBY0u+8UL1eWcSxAxetEINWJecih6vgByes5G/1dF3LZ6L1P3GddEbJ5t8VEXqwoVM1WHiSpWNIT8rpsxaebgjoxWFStwu4DPW0voGkV/ZaH8FBNfM3T3WVDHIKoTIVE4IC2hW6e4uXWwY2gd3MaNVeRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtkv/XyV46CK2vMi9EzxKymo93KQ/cAjpLVoLWxlBXU=;
 b=V2zK7P+RhUvKWNOBeGEWgcbftuLWMdQ/IXVFbcsWYMaxygBlIYMY/FUbnQohk5F4Md4OBmz6k/7WUsL+0XralqLUErNI6elyYvO511dtqftaJmtJ1rnjWeVWQJ6IjS4mK684HmkHyx+FwVXpBIv/TZoO4YFtLS7qiJx/5XkDdUBFlWnmJgRcZixVwyMwXuEt2WVXyVvMjZUJRbfi0hGYrLD1nZFYkEl7WT+IE3moQ9SkTlyH2G0jYXqR+8ynjAJqp9LvSLXpThPE4D2sm+gwdzpHr/gtb+52m36UKJm8e1OdPwBtNssqZiXMFvju9gGH0FzEXO5qlkkMxNCbVAqXDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtkv/XyV46CK2vMi9EzxKymo93KQ/cAjpLVoLWxlBXU=;
 b=mAjdFPWdC8Nvp92VWG0/tYzljijmI9/VuHGn9U+NTLH3CgxvLbF15ORtyFNQodBE3AK4TH3wgqguZl6rPXr2MqvNc72ZGY/q8gjuMoe0HA8Ktpg2ZK8a65oEZ9MPkc7wWF3QE4v5oZPiRRtshi2ASgK3sowlKCKBJEIC6bOAGVAU+pifIa9D5qWTZ4RPp/PhzOyio5r2p25hcswVePd/2lGU28rsetozwOLOIW14Sv7r+QI1p16JW/P4Xlr34pV3UAyTk7Ko3ce31s89Z3+H4zQ2kzT8E38j4jHpx69HZ21JW1tWAnr6S/T0aTtX5AFWIlnIHc6QrVvtM6RpYBDs5g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9257.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 10:34:06 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 10:34:06 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	sandals@crustytoothpaste.net
Subject: [PATCH v2 0/2] docs: update email credential helpers
Date: Thu, 15 May 2025 10:29:22 +0000
Message-ID:
 <PN3PR01MB9597D6BAA98013269897A963B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:261::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250515103355.37250-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c0f8ea-c563-4c58-2aba-08dd939c0490
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnuXninf7Jju6oSeeaZEKE9NguNtR3XTSyOpi1q8o3zwXPLfO8L3hB9d3HedVGCwhufuzd9RalFTY9n9tkL0h7eSY7D8bMWQ6OlzyGBXSab+RlwdcxevmvLf9KNzBTaD9NYsi5gNSqX6ROaWE2QFCwYNwY0TEVOnLyIgoxvRD83Ymy8X8c00rVuFGzmJXAWMA7xS9nCa89QcY9ymBWQUQLW+ULTZGZtT/OtB+uCAz8P1UgWdiZ/pTSr+66VKqzeHz571/EmUXt1eKBF4RUVKOmlK85+gG9SH4N3vAwJrxQlr5xEFEcfa0wwASiW4nsHG5l/Bhbzwg9hj/Y+htgl2Atwyvupza/hsv8J0+z2m8IuJBgegLPgn8MpZBBN/GS2RLDJXpykGGGao9O/PmOXJD1QUgOBr84HVLIWRVRTxLFaNmwj/1FwPakBtTbjPAv7yu7F2VUY6Njzt7pASeZPPa90r6wHde1XKAmByRWIykhWlB1tn4i7B7UsyPM0bRJ9sEZNEPKBhUofpYnrArtAyV/av2OWBBw5/PGjjA0TlN5de2+r2cmn8f6Nw42p48IIyCWqJ+ZMRbzI1yZAD54RAyLtEH3TePmYsWmfMqtl5r47KpcRJP8JxLNwJmEQ0TzV8jfXVT0lVUG+ADruqt1+jiPrzXWIM3aindwb6IgDb7E35zGzr4Ngdot/zisvDtmJgngoZKtChWheXaCFHJu7P8uEkGdpmw3+NKTYd/apkGKAf0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|7092599006|8060799009|19110799006|15080799009|461199028|21061999006|5072599009|3412199025|440099028|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ed9qVYr4bb7lWSqlQXZE7b3hjFu9Hv3QBaUdakNUYZsHDghpBnyg96cEANzQ?=
 =?us-ascii?Q?BMqxBO9O55eGXMRCD9fYWrHuU3QPUQHz9Z3nDdQIItjoyS/ArdrRo9Z+qyvH?=
 =?us-ascii?Q?DbeQnJiE03z1Qxr2BHIBJihKuJohD4dZBQ24ZvsLql+k/zu5WkFtmhAEOe8Y?=
 =?us-ascii?Q?3ZCJ0bozMkD0sbTNAj0QEtGpgywRV1rRKrV98fTbP8U2KwqrQdxzpxsFlA1M?=
 =?us-ascii?Q?81UJSDckUEuQDbwyEy0Qt6EurT6LX+mRjgUYsy2IJvz77GKFjkPt+SvkDqwc?=
 =?us-ascii?Q?TSSks8WSWCWOYE9yvxU78HJbjnzROfZKWAnQGsphI4X0H3F/q0HIftmfEv1k?=
 =?us-ascii?Q?hNBTDHc2RDE4hclqS6YpQAxMl2q8UB2I6AkOtk2w2+cMDXKwxQO8e1fSsN89?=
 =?us-ascii?Q?3DaytI4CVOKIRZeScbQQeOIehTLPehbE58adSCpzAUAy1jgj4KGf1ELAqIYn?=
 =?us-ascii?Q?h/cag2T+mhaE3R24YyhuZnGwd6/+oWY/gvDVnbmKVKx0vykWmEqa1tk+9irI?=
 =?us-ascii?Q?ks+120AgDzaX4ir57wp/yFmlwUwz9YR+tWoHUYkP9nE9qJvrjHaCHXAEu7np?=
 =?us-ascii?Q?htJ8i7pWiItJ3KTIzBWI+HqEEv8jkKetkRH1BwknZXeaaCJ+i88iuhzb5ujF?=
 =?us-ascii?Q?ApXSjSqd1nm1uCmiXDKdd7hJqUFb/nUSxBLMffF5sW44IvwVoe5M5XhN14ru?=
 =?us-ascii?Q?GsvQBjGcm1RdX2guqVrzCMFLmeFPJHBefn0Q52Hv4kica4X8qyciYjpIdplQ?=
 =?us-ascii?Q?xN22ZoLJRj2uYf8cqy49S47fbXxIxwPHzjl67YzSJSdXJ3GWMKGOva0IuNk1?=
 =?us-ascii?Q?T+aqC7qIK6RpIkxF8tBNYFF5OBq6CKnuwNYiUWRO9QwE1grtgbkHCFttrVEz?=
 =?us-ascii?Q?pTqthzXQuA/C3VJcpFTVtuyR/hj92/8aLItgZdC9EtSCrrFP78DZq0iTZ02R?=
 =?us-ascii?Q?mljSTDUSDxXvEplPJv1fCj5HPyGjrP8ysHzn+6PB1uwEz4jh1Che4nSqVkp/?=
 =?us-ascii?Q?/ulivGDPkq+Uvpk+j5YXmy4vY0e1GG+Kcbg0Afb0CQXLp6xoMMti8doGvzxc?=
 =?us-ascii?Q?D8qvwtRDr78iYME13BYMH3VIvuBCM2fxxGstUOqLJGg6um4l7b2sVDJIQoBJ?=
 =?us-ascii?Q?i0Ykj1vaFd6B0XL9apGdL1QMv83piaOzeeeuX+VYA0JZnxlepCiPW8qKtPfX?=
 =?us-ascii?Q?voAZ4ufxQ0rGjaDd8OVT0RatXvasadmPTG/rHTvUScB53Dk8WCNt8RIUUeGJ?=
 =?us-ascii?Q?TORQ7YanBsfnfgjsoul/?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EBvi52fiXLSSTopvJhLC4LQhp0vc88ko/BzmBN9US5p8dTH8eT9E99Vt55Dk?=
 =?us-ascii?Q?mbBMfX8KhHlF9YsshJbENhrOqYq9Fih8FDhdo8LS+JOvVYkgUBCeEud2JhSW?=
 =?us-ascii?Q?qBLA+ABGgJISz+UtYf4KlwKsEElhgY9fslAQhZG2CDVkBJ+fxZ54h8oWvwrB?=
 =?us-ascii?Q?Qp99Hswk1PZALRlic/N3xVvyK99K1A/WLvNHZ5xpF53c6YGeVEH2YdTxrj2M?=
 =?us-ascii?Q?/btHQO48c17hRo6xoTKmSoj20WJCCLr3xh9UWOlde4+KU08ySBczNuY0toMj?=
 =?us-ascii?Q?8snLvk6juWY+JI++SBaC8IvvKJlNkcpNG5zz6nAIqMwxFrqe3mp+nF5rPVhN?=
 =?us-ascii?Q?pjAjxQRupnO8orqYssLRGy0cihsY5dFpvWIAoHuHFdNfuJLPeLhqgeaABYtv?=
 =?us-ascii?Q?+SKWBruGuNUJeNTbt4TUw+57YNu8EW+IKWBuzIjKRrQwmy32bbaHWoGb33//?=
 =?us-ascii?Q?IPwM+n5yg7snqa6imunpx/iwWWWxOiMtkifkMYBbZ+JSe4jS2ZA4ZZxcwpBd?=
 =?us-ascii?Q?HiUFhdo/aGhTaLO5ib2MygQoJZcYLZHzlhTDAN0+KJj+2yWdtX1dgEE9GjWO?=
 =?us-ascii?Q?xCCaftL0hU6zi0Cv71okp9Tnq4RMU248IZPwj+6uUCVJ0PHZvJE4EOuz7P/9?=
 =?us-ascii?Q?jsiAM7Skmgf+j4aVHK3nysv3zUYmkQ1BZzV5z3oz9mzKigtDtZdXvSYxCUwP?=
 =?us-ascii?Q?k2TEchGHznmcabehvROztFw3RKizOBWmr0Y6uGDK/lk4EytcC+GbhueOTzB4?=
 =?us-ascii?Q?kswDw4jJLt8hWhMnX2Qnr5slzhO3uuPQSd81/VZwJ5aYOqvCQLUckLftnj8i?=
 =?us-ascii?Q?OQNa3d5pU8O/41BU/UsxkDUJa73DR06Lun+IwjJxsOXnNl68xaAsJdJBUSDO?=
 =?us-ascii?Q?3MCaakQt6eJk8KI1pb3S7TPzjlotxnEWSd7bHAQsJcwLMlt/ByjIEma8GIAK?=
 =?us-ascii?Q?iCvCkBf1xBZzIFEac1RVngb1eDow8fN2CvMFQ9qEcpmdvUprXQ9900xBQPbQ?=
 =?us-ascii?Q?eatw/aaIIQzK0YDDt8Z0N8MjBcDBDYBsG+SnxXKptazhLnrD2kkpR1tEWU6Q?=
 =?us-ascii?Q?Pw1+FhD1RoSuuWxO3ur1I2/L1DlT/XdWV1pzaJLdJ5fxYXzuNQijhKmiE58O?=
 =?us-ascii?Q?Uzc9Jb/3bYpIIaAtyfjMYkP7GqywD4SQR4n962o40IY6bajsjLZXMDXanD93?=
 =?us-ascii?Q?6awY6cfSOxUM3+X7lQWZo4AKXX8R06robPOP7enRIbtbuQEyi2k6xRE9GT4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c0f8ea-c563-4c58-2aba-08dd939c0490
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 10:34:06.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9257

Hi all,

This patch series included two patches:

1. The first patch adds a link to the `git-credential-yahoo` helper for
   Yahoo accounts and links Google's `sendgmail` tool as an alternative
   method for sending emails through Gmail.

2. The second patch removed the email credential helper links from the
   `gitcredentials` page. The links are still available in the
   `git-send-email` documentation, which is the right place for them.

Detailed explanation of the changes has been done in individual patch.

v2: Removed instructions for Yahoo SMTP server since I've realised that
    Yahoo *was* a popular email service. Also, the instructions were
    just making the docs more crowded. I've also added a link to
    Google's `sendgmail` tool in the first patch. The second patch has been
    added to address the issues that came up here:
    https://github.com/git/git-scm.com/pull/2005

Aditya Garg (2):
  docs: add credential helper for yahoo and link Google's sendgmail tool
  docs: remove credential helper links for emails from gitcredentials

 Documentation/git-send-email.adoc | 10 ++++++++--
 Documentation/gitcredentials.adoc |  4 ----
 2 files changed, 8 insertions(+), 6 deletions(-)

-- 
2.49.0

