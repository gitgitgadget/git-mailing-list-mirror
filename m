Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D070814
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748761935; cv=fail; b=uVfPjJc5p6UVa5R9Z9Gec9/lWds9a1BB2ZvF5coy99h3fjal5KaqlXOM4eUBTWSYs2N/deG0qxoUhtDsrh4IcqyTV4eyi+3f7PnZhRU9dbU6RAFoNlL4Nf3zixQ/bMbjVSZbWGTtVVzJ4pWdjPSh0XPh7bd44jaL4HXry2T4Sdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748761935; c=relaxed/simple;
	bh=hRxFeIoxvvNiSBnkFMkFVYO+3B3ZAOBUcWHldy999mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQ7+3fAHpiy68blBJvSVpxQpvENDGLjYgidCGJXktw5NCGo6AHY3MlWQWGrzPcfTgUxcAAT/9ipRVqF0jXN2RnVtj1bQ994w5mNMCfwG5FmnoQctVyCnr+74RMwjTWNtawGI3pCj21i5/DfxzWvPxfqQ4NJzcnscnwpRV6f2lMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=gNV293tM; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="gNV293tM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tC3ZGff2R6iz5SwCuk4QvVuI7+CFAp8a1f0TU1SyXus9Fad/YbBEOQvWKb3gHJMV3s4eLPBfExeiQxc+hjD5a75PIuFSZ+vnaWdOO+zdXgvgv6/x49MLJ5rrQOVm917vHCbqkbXYSvO5UZwldSCIU3cClq+bdYtxuZFQ7jzYz3xDVupA5S0h3tflGej5nMd3W16Ckbqr0nK8d10L8iLYmpiCrf+9iCmyoERCXuj3KE9hOCM8w93zo/8TUK7qyKA/2Q/cPbTrum62zG8h/MUHnshDTwO96F7eB9SEp9RS5fp8EFNCsjfL0tKmCv8EMC0XaPF/lSLMFR3Int2K7Qs8kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptlf2qbYdJD3cf8YTU25jIA0JNnmQNhPH+H3X9EG+50=;
 b=utpN4nIZHSLGd5Nay8JdQFXSpYF4KotCJWYlOvZ0L29nxoq/CX7U17Ca+YmFOBpAGZeXV4GKAfsO6HxqQ8s3KvYCYcAof77QccqH6B98aEomE8ycBqIaugMduF9jsqk6tjNtjCu43JuhE7hQmPTgkKqUXgdmTc4+SF1XWVbzrpapTwY+6zdNeXPevu95JK/1kYGzylGF6oLb3YZtO1nfLWYvPAc+qkCwolgYvwc7UFEXB1byRkW5Ayt6SGcWB7IX2cKmd38QrRS3Xe3hSdZQBYiBNefRCr2Hjrz0h4unClssWZ9INbcgNm57iqmG3UUTZtU/9rGJRd6FhucJ13TTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptlf2qbYdJD3cf8YTU25jIA0JNnmQNhPH+H3X9EG+50=;
 b=gNV293tMl9ZcBTtv5gPJUcc+sCW4m00ds+ydir/xaU9hsudQHoQnWODG6VtzCwyDqIJo8xemtDS1bynBHFKPzEuKzsyUFadKuRW0hwxwc+MNose+tAEVKv56bUUMDtCAO7iTJaTTdYrdVXQv69M4Ck4TSnBN1uwcj7FdpOv//LWo8EpSkhePmgcu64AWKMkfO61dbbJEmgmMn0bEv3Sn7zDrQDfYytMltp+ALI2uxzaT+4bxs8IqlO87NHmtA71+NEIULgdpuDEmNcThLjoUMHAg70bCOf46K3AX4HPrWm1csz/A5fC+mEh8o+oPmh62G9ZZljFv6SZUljqK3p/VRQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sun, 1 Jun
 2025 07:12:08 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 07:12:07 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v10 0/9] imap-send: make it usable again and add OAuth2.0 support
Date: Sun,  1 Jun 2025 12:40:26 +0530
Message-ID:
 <PN3PR01MB9597C4D1176FC7E9A459C42DB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g67a2d115ec
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250601071035.2412968-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 33fe7715-bc52-451c-c4dc-08dda0db9e9d
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnzabMPtH8MgpCmW/Xc0AW1XxNIDoUqLjNtloUpGJFf1iLALr2VUAgZgdR9ssIdeBJLGIqlyVZf6hamIW+/gN4zD8hLe/REjCg5ydk1ZH1plEHNFeIoc+lf/b3NOAXlrXuQfzwWEI5BEYku48x42EyKNCu1mnseStcwf3E2x0Zgcb/zzY01RttBEd33AC7XCUXbOyjnubOzo90ytituWcFLJ0YY0/se00TmSWTwF4E1eHdmyKCysLmOE1a/AJLFOBn2D+p6pVS0FKApjrG+I9derofXppsUpTdg5zDjHR/PHP6IV9qfStFXKj/oGY/TrrVZcoWzr2lf2OxugS5CtV3YijF0gDNweRcF63inhZNX4vFxoy0DrFlGi8QhVmvC+Q4usBa1+InjKXTU21G2ldEEAAokUct8Jc9rozTbt+nInSbfhoasFtx7tJ8RbXacgbscfiXmuQ9JszfakZEU9n2xo15CjXXkndckc3qryR4iefx95dh+2dRcdo3bU6Vkou5NfKASt8pZInyXzevZzQz/PfC1UZ7RFdRpbrtYiyXAhayocHvlUkm7XA60uTpc2vrD850UGI7RR/iXWJ7REEedsBUKByGn2fWzExy6razjCy+eK/0XwuaJaw0s0+gip6M3Jj/XAFd50iciIF3zoAb0xHkNOU808WYqoLbfrc8iCtN08J31PRznnj+b0tMk7RfSpxWo4jI8GW9E5d5sAImOZZBBal/qfTuAdM4r07oNM4=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599006|8060799009|15080799009|19110799006|5072599009|4302099013|3412199025|440099028|19111999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SKx6bY8u0oJygi3OFPjO1MKsEGhmXnQQ323E8Lz6Z5+xyrPJ024bFsA8O20a?=
 =?us-ascii?Q?OGzcUsKxJXtHQDJ9ye+v2ZaRiM/GsKbI/CthasszCp65+47rXu8ufk5LfQ60?=
 =?us-ascii?Q?rAf9iFZU4tQMAh6onuQCAGnT60cA+/OddZ20cVanTvzGj7ijnlewORWoSezQ?=
 =?us-ascii?Q?X1a/HOKM+XVT+6q+x3chvitRe+1gZlA8AIn+yEbijSp+umovboN4VU6GTxel?=
 =?us-ascii?Q?MS8RhCyh/Gpgw3yH5Y/1JIAnGyMmXOL2mRFk8xQlq02iT1lNPFr9emea+NUU?=
 =?us-ascii?Q?PKSF5efTEoFsTKwwMx9VOOzvgzi+82Q2MJlLDbDj8r2NKXkP1nckNMH3Wyyy?=
 =?us-ascii?Q?ReM2ry2wun2zZ7NTJHX1RYgWShfxOn4MTV4BgRYy6/l9piCuy18p58yaUbU6?=
 =?us-ascii?Q?4pRnyNzfXwGizhThnlAXhxNlyzQtHasnUf40PUJJZM6KuV098bhFoHaB3Tld?=
 =?us-ascii?Q?6j4OOIZSgPjirPOt7tDwMHSvoFqUlnnkWckDb0YdDIw7T77dvUhMn4K8heQm?=
 =?us-ascii?Q?zYu15MKYq8nQugZPP/ARksiv5QR2Pk64tFAP56KnlpTtwyGMYKZDS8lHYDU1?=
 =?us-ascii?Q?APm6RAMgR2WixJ/PrL37nnIShU/5Nxd+eRo8t+ISeHfkLFzOlWVVM+Nor/na?=
 =?us-ascii?Q?6WSy/nnqJ/Du3qoyQH66V+kSdkPP90czr1Ht9rv2w3bULikXiX3V0DDxFrMh?=
 =?us-ascii?Q?ARY8YdwSzET21Cwo+0iacAUIRboUP5PrUXXh5/cHU6I1NZIkHH2tIHVhAgPI?=
 =?us-ascii?Q?mA+mFXCLLkE1gK37RmJew9ZO208WDU3KeTs6vpCRFP+jDyU5E+Kots1vWKxn?=
 =?us-ascii?Q?TcoSb53kzqlT8NUhkLML9vT5/RqJlPy5am4W2lyByUM0ZotBwbFEobisZr0h?=
 =?us-ascii?Q?C3NyRgJT8HXry/kJdPv8o8V/rP/2kbCM3DglxqlkJ/Xxhoj6JLGERgtN6+wW?=
 =?us-ascii?Q?lUOVGeaFMLXrZuEIpGx7wI4gNn+8Up8hQbtewDhsl4Z9USUQF9wbzjd9/kaO?=
 =?us-ascii?Q?N2JA/WKkll6JCFx+Ln/+xWKmn7yrb+KPoPF1Z5u0ol6lZeIsquKf7D2uMhzC?=
 =?us-ascii?Q?m7Hom2BZLy+X21XuWz8evaoMGybUAGkpRnWvy86J7YoX16/rdPaWPqQQHKCu?=
 =?us-ascii?Q?pKLNTapnrxhOvvPdvnEslgh39bYesdplRz0UGf1Et52x11r/vCAV5os4FI6z?=
 =?us-ascii?Q?QwW+/e0/eFHcPEYeiK7nBSLOsoYqsTEU+JQGi1jKoZRoTa8n6RilAxEy43Q8?=
 =?us-ascii?Q?BTq6JlNuXeBJ0EPBrzf7?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ixfgRMj65WB34NcFN9BZrcukvrbC5wRlpyJ3EVpAa9DzrpjFQAxK+n81impy?=
 =?us-ascii?Q?n+xqXKl26XdAlfcFxGxdCUdrOS4zLAsxAy4zzKV2u2KJcU7pqq+AAuJ2RXJV?=
 =?us-ascii?Q?WHpLPrdffN+9uSGSQiLly3TxpS2602CEVuGRZpdBiI3txGdUf92gvTYIcFBF?=
 =?us-ascii?Q?qhBas0phY4NiJGDjDZwzMIodpwXjh36y8LVTmcOq2aJNpIUGvW5a6vhvbs8G?=
 =?us-ascii?Q?WRbUY5GCQSotOjfYJsVsi+4S5+w4Tmv5d396QlSExBBLOOusJsywvw+NIzP3?=
 =?us-ascii?Q?ARiSANbKbRvTgS0ESez5JXTvZM3wVRwkNqEas9+gw8GU5/rQ3NQuMSMlQPlL?=
 =?us-ascii?Q?ZUpvvLuYUXd02pbAmTfeYmGqbSa5OzSdRMjcs743KMqF5rqtK0VQEJPRbp8K?=
 =?us-ascii?Q?/I7z5c/qnV7A4+nPv0Cj0A3No6mkUfPpaAhq6WtDXuIJoz6kJgz92FI9wsoC?=
 =?us-ascii?Q?IFQiY4ndVOp4wSp89+PEswrRFIRyuWTxIAgQd5uv4OwvOeK2gUdJbJjZ1ico?=
 =?us-ascii?Q?UCaFxfPahw/H4Geug8AeTfkddrUCFvzqgC/aqZW8MGySwqe1gyhWGjaZL5ln?=
 =?us-ascii?Q?n4rBhpOBI0LLDzrlrimS9msHkaSBnYkjdR5rrMqKHH0PSNRnOgmKwd6d6pxI?=
 =?us-ascii?Q?gR7Bz4e9UdwV65Ekbzrewwu0iUdc8TD6zroOC1sl66voHODINA+11EGGwwek?=
 =?us-ascii?Q?8JlbzRG/D3GiMhD0IxJWXhI1dLt5elitHHIYqtQG05F5pGEiYW1lciB11vaA?=
 =?us-ascii?Q?QNH0p+obJkeSA0kIfDvSgfTvjxjnHiTKx4l5aW+9Q/BEH1gOE5Id42JiCQtw?=
 =?us-ascii?Q?yGKmAAhHlfbzY+lfocTN44VLrpd1fJcjxrtX9RC4cAo1jcJNi/8O3v7lJYNY?=
 =?us-ascii?Q?B7oVv8ErPzVV+SL2TIwBKo8gXRG12uXelWUlD8JJmf9QrNKxJePKy9Trzqxx?=
 =?us-ascii?Q?0OmFoq6C19aNm3YKk8vsH0ErJ7o6xPVWPgeDOy/OGuHe42c0jTcYPk/xlX9B?=
 =?us-ascii?Q?XCf2t/G1oaPboPmcqnMA7Dqt58Tgr0tzOzRxM+qrBefx5OLvMv3Rcpb/2YD1?=
 =?us-ascii?Q?jzxwKz3ktZaOyp8OyLEJDBSrW5wrrmzJQph9oZcZPCLQe/+asVzb/qPdo/EN?=
 =?us-ascii?Q?4Q5IeZHcgAuhBDjP5PWj1cNzyAte2fpM7cWsO0yusDG/wnJ2dp/2eg5YBinT?=
 =?us-ascii?Q?dJgWPeW3389sFW+urFktgHkNfiKsBRmPF4B12oSSjQqf9oTL4Zhvav/qPpQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fe7715-bc52-451c-c4dc-08dda0db9e9d
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 07:12:07.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9108

This patch series does the following things:
Firstly it basically makes the imap-send command usable again since it
was broken because of not being able to correctly parse the config file.

Further it adds support for OAuth2.0 and PLAIN authentication to git
imap-send.

Last, it does some minor improvements including adding the ability to
specify the folder using the command line and ability to list the
available folders by adding a `--list` option.

P.S.: I am surprised this thing even exists xD.

v2:  - Added support for OAuth2.0 with curl.
     - Fixed the memory leak in case auth_cram_md5 fails.
v3:  - Improve wording in first patch
     - Change misleading message if OAuth2.0 is used without OpenSSL
v4:  - Add PLAIN authentication mechanism for OpenSSL
     - Improved wording in the first patch a bit more
v5:  - Add ability to specify destination folder using the command line
     - Add ability to set a default between curl and openssl using the config
v6:  - Fix minor mistakes in --folder documentation
v7:  - Fix spelling and grammar mistakes in logs shown to the user when running imap-send
     - Display port alongwith host when git credential is invoked and asks for a password
     - Display the destination mailbox when sending a message
v8:  - Drop the patch that enabled user to choose between libcurl and openssl using the config
     - Add ability to list the available folders by adding a `--list` option
v9:  - Encourage users to use OAuth2.0 for Gmail (similar change done for send-email docs).
v10: - Fix comment styles
     - Fix failing tests

Aditya Garg (9):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: fix memory leak in case auth_cram_md5 fails
  imap-send: enable specifying the folder using the command line
  imap-send: fix numerous spelling and grammar mistakes in logs
  imap-send: display port alongwith host when git credential is invoked
  imap-send: display the destination mailbox when sending a message
  imap-send: add ability to list the available folders

 Documentation/config/imap.adoc   |  10 +-
 Documentation/git-imap-send.adoc |  68 ++++-
 imap-send.c                      | 421 +++++++++++++++++++++++++++----
 t/t1517-outside-repo.sh          |   2 +-
 4 files changed, 437 insertions(+), 64 deletions(-)

Range-diff against v9:
 -:  ---------- >  1:  3e3ddf7077 imap-send: fix bug causing cfg->folder being set to NULL
 1:  c5ee87051f !  2:  02037873a1 imap-send: add support for OAuth2.0 authentication
    @@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const
     +	int raw_len, b64_len;
     +	char *raw, *b64;
     +
    -+	/* Compose the OAUTHBEARER string
    ++	/*
    ++	 * Compose the OAUTHBEARER string
     +	 *
     +	 * "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
     +	 *
    @@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const
     +	int raw_len, b64_len;
     +	char *raw, *b64;
     +
    -+	/* Compose the XOAUTH2 string
    ++	/*
    ++	 * Compose the XOAUTH2 string
     +	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
     +	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
     +	 */
    @@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct crede
     +		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
     +		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
     +
    -+			/* While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
    ++			/*
    ++			 * While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
     +			 * upon debugging, it has been found that it is capable of detecting
     +			 * the best option out of OAUTHBEARER and XOAUTH2.
     +			 */
 2:  17e263ea27 !  3:  3a0be43838 imap-send: add PLAIN authentication method to OpenSSL
    @@ imap-send.c: static char hexchar(unsigned int b)
     +	int b64_len;
     +	char *raw, *b64;
     +
    -+	/* Compose the PLAIN string
    ++	/*
    ++	 * Compose the PLAIN string
     +	 *
     +	 * The username and password are combined to one string and base64 encoded.
     +	 * "\0user\0pass"
 3:  5c471f640b =  4:  45f5b3f1ff imap-send: fix memory leak in case auth_cram_md5 fails
 4:  db8ee71785 =  5:  8899f686d7 imap-send: enable specifying the folder using the command line
 5:  a8fbcdf9d5 !  6:  991f978c22 imap-send: fix numerous spelling and grammar mistakes in logs
    @@ imap-send.c: int cmd_main(int argc, const char **argv)
      		ret = 1;
      		goto out;
      	}
    +
    + ## t/t1517-outside-repo.sh ##
    +@@ t/t1517-outside-repo.sh: test_expect_success 'imap-send outside repository' '
    + 	test_config_global imap.host imaps://localhost &&
    + 	test_config_global imap.folder Drafts &&
    + 
    +-	echo nothing to send >expect &&
    ++	echo Nothing to send. >expect &&
    + 	test_must_fail git imap-send -v </dev/null 2>actual &&
    + 	test_cmp expect actual &&
    + 
 6:  a5dad0f2b2 =  7:  e436a12198 imap-send: display port alongwith host when git credential is invoked
 7:  d2569a5e36 =  8:  5183253004 imap-send: display the destination mailbox when sending a message
 8:  cf844b2632 =  9:  c33469a5db imap-send: add ability to list the available folders
-- 
2.49.0.638.g67a2d115ec

