Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037AA216E24
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240536; cv=fail; b=Ij/G2MODl/SXS/jc/EDG3nCCOZBmTyQST4x8fM6E2iwNvprxPvb4dg2SS6bR6IJbDWHLf4rfcxAv52I7M4Ey+bnksg+BLdG40+HxLimd8ah0cO/cYzVak/LRaIqbeq27778NdE5a0T1Lzrl6FC4QhzeW8k+H00zyguGzwBwCoCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240536; c=relaxed/simple;
	bh=UY3g0LZ83oq7ugL0JBFIy1csPBvj/DFApO+LVjwrQ+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c/rI81rup1pnMCgYNWpBx7K+5YcTusqk2BTifvBFQATvnOu8ADwLn5csrL/GsfhSzLuicpnEtc8Jw3+m/oHARU0vj8JXeFDXvswHmJkaZJpr8xG7N0+tVkVTQZnSZWdB7uV3jYysH6mtGTYj6PhQUnrYJlF2JCU9nVJFAzrbfPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=IR6MKKg6; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="IR6MKKg6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKOqQbWm5OfyQtGf2S7L4zEzQ7u+9hZzteTqZGBe6THwV/v//kG8IK8qpt9szNuSr5lv47kmg9UiJ1/1KCjd9iNPqImU5UMvVF+JrSkjveRJ7c9jyRPf+MrRRBVhr56j7IfJPkT8XRhWyd8HyTr/HKtDRTrN0VXizfj6Kf4XP4f0nLvEVsiFw+pd6EWchGScTdPASBNEUiBqFwxK3lhXGajnWO9vAcHuvMc5RLgUGtwsYDZRvAi3v2JdsGivenQazOTSp/mSd0+c/E/P6/0VqggFv+50Pi7zbGs2TOw729wSBls8oU7SXXPKAY17U3zA4xNgRRhuD8k7T7Nd0/UYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVsnSkmlzGmGGGSptE+nYU2GkeYvEfq25+gtE4eM4pE=;
 b=XvMbVoIZI6cx/hn+wd2wdwIZXjQzwpeuytP+AHRBAD5LyMHWwfB4qg+fDO/XYRx9J/DZlHvDrhJ8ppSrYYIu206wDO19VNoLSJ9aBVwSakYfoW7I9fFkO66ixf65Wk2qNbplPD0bgZ8nSsdEPjB8agn+cy/Uhi+7D8lznLskpjlsfbFJFrQg5VmMRcTZNHNL6YCHhLYCVvGfqK5Z555fW0+r9fncq3Iya3ejk2qxRRE0/BZyc21o/6HSvwXw4BWzIjwL9RpjxpkatI4xbQXzp8jNxW568Xp7sElRHR/J9iF00hPfR9AhrgwuU1+WRdTav8wl5waitaIDjBHhpKtvEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVsnSkmlzGmGGGSptE+nYU2GkeYvEfq25+gtE4eM4pE=;
 b=IR6MKKg6OxZW8ihTc6b79svfc3Mu/m9+KI+oGcAASaaVkv3de5SG24cGKE0cQk5/l0csCbW1vIWMkHpNGFM9HGGf9zJyQQlm6OnI0BB8sGZNmfP38mS9OIAOGSglbnaP+Md4NNn31uLlvgDjPrLMop4bcASDeDhy0NgAPQqP1j/ERIJwFSeTliCEBgYhRR0EqOUQsySjSaEZiXkNsSNzpj3UlbRca7SooaO/K75tT6LESQK9KU83NlRw+l7iXeHoutDGHRaVcS48twS/1Zs7uAROABP3XuRdCjirHiaJfK34FkS8UzKXT3v56HqBoG9g74Nxwbveqy8Cz+0XvsCK/g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8841.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:08:48 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 20:08:48 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v14 00/10] imap-send: make it usable again and add OAuth2.0 support
Date: Fri,  6 Jun 2025 20:06:22 +0000
Message-ID:
 <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g0975df9fc0
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250606200632.43298-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c1a50ec-ddb8-482f-6718-08dda535f2bd
X-MS-Exchange-SLBlob-MailProps:
	02NmSoc12Dd5repmuE6xIjyt8OoXYIeBiUlWgdhSZKH5ScT1xUQYxJgLFPSlUvfcKwKEGWZr3XmCJHLE8+tkeFp/pO88oYYOOzICtEw8UCATTib8LMOsi6Tzn2gEbgC65fL/MohycIwAoHMpnzp+z0aXIu44i/dPBsaKGvi8gZJEXEVdVO0pDH12YLFceAMbmbRfZUI+lJjPgRCZkUurCIPhT+NJ32mgPBT8yZ01JS628rJxSKfS3rt9f7z/x9x+mD+4NK01M03NyJBH9Wd4fesQvw8yO6ncA7S+pOrwBw4ZM7MRmQb13hbiyzJw+kHlmtnIVhuMnpSp3KjoPIPG04KnsIBrdpVAWi7XfBZXVrlo8A+To5r9fGNZo+hy+JYS8InAMK5fxpMzHMmiT3jB8bJRdWGfh5/nvO4HEWiXUbt5DS12tYDOAbUJf5R408Qy1QU8ItLE26KCHvTOZ2wk5wRrkZQ/MofcdaApm/jk0qi0Jfd9CF9z6XUMossW526QNADiHiBUWB3FnSZTEo4P/fty2d2US3ixuvd3dRd680vYcIEPDStdDhbA4vKS73Q6UtAsMBji+tajePgrkpleHa0q1y+ZXyXW+D4GcYZHptsQqJ6IpzWLSyVlpRIDUjyvCtzmjPdV/R1g1ciTm95uC+AREIPQ2xbK2G7yKpwi5lJ9Ll3mBQte4DTuHToq7jmSTBRo8L2bEKC06cIkTjoIaYlXRIA5G/e0Ug0tr35Hzosbgt1ok2LiDPHKrqHEJlXP
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|41001999006|5072599009|15080799009|19110799006|8060799009|7092599006|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YHYQuFf9+D96B+DzCxRxwgwdS37vZRnU7Wex3q6h3b/LuhofNm/zCfwrseyl?=
 =?us-ascii?Q?uzCioY5GxAel3k/ZGkPveYf00glyxOAeA9aBsRafrtkOAfVBz+yXeJrIjI/k?=
 =?us-ascii?Q?VFgiArWtb7WEJ61pFCtQaj5SsOFngOYtlH91Zj6Ir7XSXhKvcWOXz9InpjdG?=
 =?us-ascii?Q?BTBLISw9B0n9238oawAnzRF2NvVmz/6reS2/CxrBB1x9i+c982rdpk/0i/fC?=
 =?us-ascii?Q?u1usUkNY/xRKQaGyCvxRL7RPn3ZaxrZkxPNWXPE5eEyLvEdXC7X+6DGUmHTU?=
 =?us-ascii?Q?d5F0ItwhUhYBZqC8WOvbm2SEcna0no13uAVSvyFkhgh3XsI26msB4p4X+u0r?=
 =?us-ascii?Q?sj9Bj3ry4Aqw1kycNaUP7gdynFR2Z+vn+NdmAjMTUhUQ/FtbE/DZtUN1LshA?=
 =?us-ascii?Q?EL6LDqpvvQMQg35zGWShUiDci2+lEkzowldntbyZOQNCbPSuOwpG/C4hIfJ1?=
 =?us-ascii?Q?oxXz7+jNrAO+pHYv4VCBSFa5Kg6xkXcLbw8Ucme4zzIav2oaSesM5+83uWc3?=
 =?us-ascii?Q?hqkYQyNLQzvl7VAtptUKyGc8H/9NdiE9BqM4tn7amenOqThENP7R6LHbbOLj?=
 =?us-ascii?Q?R4e0RUGXtVFA+Ow7pkVeQldtEdc7QDl1TO3DegPBcbKfAQ2iEG8J04OaEQua?=
 =?us-ascii?Q?kCK5meEefLfygRJoRfMIc3GUfvrUSKDc66R3ijuGgBxZq+tVkHgdTWAb1kYy?=
 =?us-ascii?Q?9JfJ8DsHT3B6axJYODhPBBH/Jet8qIeLu6vg/DHFKXk8qsend7M9FgvYPcP5?=
 =?us-ascii?Q?+V2jNQOiBOknPWFjcV3O760qs/l2qiLGDSvsn+dvJt1/n+6sWdV9vQMk8eu7?=
 =?us-ascii?Q?sQBhERIPmDuk6itFloKbdELBkGk/nvAffM9+DqAa3Iy2Mo/40MD7EIVj9feu?=
 =?us-ascii?Q?kBdB7m/PXiSf/rQ0oazEUX1XKDKurSXLtrINdbAIRoZnLdbZS+08CWeULaGo?=
 =?us-ascii?Q?4pe5C1Waub1CD7LkWoN2yicw9SdGbZQzKVKOQ45SzI6H4ltIkYYNfGI0iYaY?=
 =?us-ascii?Q?pr2P2cKVjp9VN/cTiWozG9UFm/6u3wdASLQzK2B4upijosJAJgQqBSA7NzuG?=
 =?us-ascii?Q?nZS+49Q96rWVWvqi58Zj9Vl1ON4UXhm7TbzeOGnCW7V8qM5TY6yno5OAHFZ3?=
 =?us-ascii?Q?CIl73Cj6sNcke6We3m9EhY5TJKFDospmfw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oWTQmR8AM+7oBwSpA/7U6gwcTmAVB+zl6geeiu5fSQxGuPA2kxjffJK253Zf?=
 =?us-ascii?Q?mOS7EzGk3oIOHuDLx1GHSPVZjQL3dyrlIMmAct/xaupACXs4R8E3Bk8oa8gA?=
 =?us-ascii?Q?MTIpdtWJpxWkS9lqD1UtUiplbo1KqYnm90YI+r9veeIl4RKMwIqciEdbftx5?=
 =?us-ascii?Q?ihZWl5jP9NgBGKePJX/WInJbXfMU6lF9VpAtvmWPZXx9hennYFP+D9Ns42LZ?=
 =?us-ascii?Q?SSauotb8dwnWrj7+po7y/WUUN7cM4814AJ1vLyFt7ixFOXNXenkH2uRAY7B/?=
 =?us-ascii?Q?dJrour4uREVGcuUbcr0bJeeaIIKltskGDRl4lUd61PaP+Iv17h8QM/78/Gm0?=
 =?us-ascii?Q?P7Ev6RGGe3oAYa+Rc5TOYeT2+jo3mbrv70QS+zEd9oKL5svJi8pXu0hBsqkS?=
 =?us-ascii?Q?8krybER/mMk6O53Hf0ug0Bc0tGPFRxCs/V3hoYOURTWtAwF/3LSQB9pHgM/7?=
 =?us-ascii?Q?WTnzuCA/jUqMowlvsnF1ZEeGJVTALX/TpzgZOYgASaULnKOwcplNjhh08oKr?=
 =?us-ascii?Q?HWyHK6MpoXZXwVFL0TstEWQdFMnmZ4a90I3sQ2mEc8foYtKoe4YejMiJ3Sai?=
 =?us-ascii?Q?YcM3aZMJILdegOSBoSvhkmYKN9PjGdAG9Bbf/aOX4N+zaLs+YVG8uSO1uulD?=
 =?us-ascii?Q?nmg4NPKSBcWPyX0SrDG6N/doMnx4rzdFK4zELwYgpQp0+iOdalysszEnTQWe?=
 =?us-ascii?Q?Ylo4jcCkeGodFzqKaJ2rE1k5AVWpoH5LKb5AW+m24FgqKO1MTVQkyME52EBv?=
 =?us-ascii?Q?HOXDyvQRt+aTa05gR8PfGwpeeCMJiHzRvO2E38vSk86/WW0+I84uAKnSUId9?=
 =?us-ascii?Q?9kq2PeG4iO8wvsqV+CYHpc8sJbdNalbdou9E8AoXwUHxXmcaZRpSkjE9lEfA?=
 =?us-ascii?Q?iX6IS60sMxMQwqLDD8Z9WOsycadCjx7tEV6bw16jLdYej4ydc9e0MaTw1QIo?=
 =?us-ascii?Q?jMqh/dyzkl3Diu3Gw276O6KrI3cemQZ6UtxMtGLcCkPCekgSeZcsrnk77AsS?=
 =?us-ascii?Q?DMipWIbfIt5B5nt8XqMeQcutxGDxsyfwLnYjFCetZF6/zp6i+VnwtsfVQQM+?=
 =?us-ascii?Q?trr/qq7iyFp6TOlS+Fju3ZG5Lz6HsHBKOPkyaakdsiJ2xr62rUxCPITOU0GV?=
 =?us-ascii?Q?KDSGNUEKu0b9ig0b3xj9EZG08dy+IZYXf+79rFyr6DX/BhUXn+nuSHuPMPMs?=
 =?us-ascii?Q?7nJGNSf6xVa6QZmsDr9uVsEkjbbSnmPjZr2uWZrUPYhPzUegx0uhKEsDYhA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c1a50ec-ddb8-482f-6718-08dda535f2bd
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:08:48.3278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8841

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
v11: - Use lower case letters for the first word of a sendtence in an error message
       and avoid using full stops at the end of a sentence.
v12: - Gracefully exit PLAIN, CRAM-MD5, OAUTHBEARER and XOAUTH2 authentication methods
       if OpenSSL support is not compiled in, but is requested by the user.
     - Use backticks for string literals.
     - Wrap documentation text to 75 columns.
     - End the last member of enum CAPABILITY with a trailing comma.
v13: - Fix logic error which was using || instead of && when checking if
       the authentication method is neither XOAUTH2 nor OAUTHBEARER.
v14: - Specify why we are not using CURLOPT_PASSWORD for OAuth2.0
       methods using a comment.
     - Add a function try_auth_method() to reduce code duplication
       when trying to authenticate using a specific method.

Aditya Garg (10):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: fix memory leak in case auth_cram_md5 fails
  imap-send: gracefully fail if CRAM-MD5 authentication is requested
    without OpenSSL
  imap-send: enable specifying the folder using the command line
  imap-send: fix minor mistakes in the logs
  imap-send: display port alongwith host when git credential is invoked
  imap-send: display the destination mailbox when sending a message
  imap-send: add ability to list the available folders

 Documentation/config/imap.adoc   |  11 +-
 Documentation/git-imap-send.adoc |  68 ++++-
 imap-send.c                      | 412 ++++++++++++++++++++++++++-----
 3 files changed, 414 insertions(+), 77 deletions(-)

Range-diff against v13:
 -:  ---------- >  1:  3e3ddf7077 imap-send: fix bug causing cfg->folder being set to NULL
 1:  0d28e337cf !  2:  34d56c3b57 imap-send: add support for OAuth2.0 authentication
    @@ imap-send.c: static char *cram(const char *challenge_64 UNUSED,
      #endif
      
      static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    +@@ imap-send.c: static void server_fill_credential(struct imap_server_conf *srvc, struct credent
    + 		srvc->pass = xstrdup(cred->password);
    + }
    + 
    ++static int try_auth_method(struct imap_server_conf *srvc,
    ++			   struct imap_store *ctx,
    ++			   struct imap *imap,
    ++			   const char *auth_method,
    ++			   enum CAPABILITY cap,
    ++			   int (*fn)(struct imap_store *, const char *))
    ++{
    ++	struct imap_cmd_cb cb = {0};
    ++
    ++	if (!CAP(cap)) {
    ++		fprintf(stderr, "You specified "
    ++			"%s as authentication method, "
    ++			"but %s doesn't support it.\n",
    ++			auth_method, srvc->host);
    ++		return -1;
    ++	}
    ++	cb.cont = fn;
    ++
    ++	if (NOT_CONSTANT(!cb.cont)) {
    ++		fprintf(stderr, "If you want to use %s authentication mechanism, "
    ++			"you have to build git-imap-send with OpenSSL library.",
    ++			auth_method);
    ++		return -1;
    ++	}
    ++	if (imap_exec(ctx, &cb, "AUTHENTICATE %s", auth_method) != RESP_OK) {
    ++		fprintf(stderr, "IMAP error: AUTHENTICATE %s failed\n",
    ++			auth_method);
    ++		return -1;
    ++	}
    ++	return 0;
    ++}
    ++
    + static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const char *folder)
    + {
    + 	struct credential cred = CREDENTIAL_INIT;
     @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
      					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
      					goto bail;
      				}
     +			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
    -+				if (!CAP(AUTH_OAUTHBEARER)) {
    -+					fprintf(stderr, "You specified "
    -+						"OAUTHBEARER as authentication method, "
    -+						"but %s doesn't support it.\n", srvc->host);
    ++				if (try_auth_method(srvc, ctx, imap, "OAUTHBEARER", AUTH_OAUTHBEARER, auth_oauthbearer))
     +					goto bail;
    -+				}
    -+
    -+				#ifdef NO_OPENSSL
    -+				fprintf(stderr, "You are trying to use OAUTHBEARER authentication mechanism "
    -+					"with OpenSSL library, but its support has not been compiled in.");
    -+				goto bail;
    -+				#endif
    -+
    -+				/* OAUTHBEARER */
    -+
    -+				memset(&cb, 0, sizeof(cb));
    -+				cb.cont = auth_oauthbearer;
    -+				if (imap_exec(ctx, &cb, "AUTHENTICATE OAUTHBEARER") != RESP_OK) {
    -+					fprintf(stderr, "IMAP error: AUTHENTICATE OAUTHBEARER failed\n");
    -+					goto bail;
    -+				}
     +			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
    -+				if (!CAP(AUTH_XOAUTH2)) {
    -+					fprintf(stderr, "You specified "
    -+						"XOAUTH2 as authentication method, "
    -+						"but %s doesn't support it.\n", srvc->host);
    -+					goto bail;
    -+				}
    -+
    -+				#ifdef NO_OPENSSL
    -+				fprintf(stderr, "You are trying to use XOAUTH2 authentication mechanism "
    -+					"with OpenSSL library, but its support has not been compiled in.");
    -+				goto bail;
    -+				#endif
    -+
    -+				/* XOAUTH2 */
    -+
    -+				memset(&cb, 0, sizeof(cb));
    -+				cb.cont = auth_xoauth2;
    -+				if (imap_exec(ctx, &cb, "AUTHENTICATE XOAUTH2") != RESP_OK) {
    -+					fprintf(stderr, "IMAP error: AUTHENTICATE XOAUTH2 failed\n");
    ++				if (try_auth_method(srvc, ctx, imap, "XOAUTH2", AUTH_XOAUTH2, auth_xoauth2))
     +					goto bail;
    -+				}
      			} else {
      				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
      				goto bail;
    @@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct crede
      	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
     -	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
     +
    ++	/*
    ++	 * Use CURLOPT_PASSWORD irrespective of whether there is
    ++	 * an auth method specified or not, unless it's OAuth2.0,
    ++	 * where we use CURLOPT_XOAUTH2_BEARER.
    ++	 */
     +	if (!srvc->auth_method ||
     +	    (strcmp(srvc->auth_method, "XOAUTH2") &&
     +	    strcmp(srvc->auth_method, "OAUTHBEARER")))
 2:  d934bdcb82 !  3:  69fb8f63f1 imap-send: add PLAIN authentication method to OpenSSL
    @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *
      
     -			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
     +			if (!strcmp(srvc->auth_method, "PLAIN")) {
    -+				if (!CAP(AUTH_PLAIN)) {
    -+					fprintf(stderr, "You specified "
    -+						"PLAIN as authentication method, "
    -+						"but %s doesn't support it.\n", srvc->host);
    ++				if (try_auth_method(srvc, ctx, imap, "PLAIN", AUTH_PLAIN, auth_plain))
     +					goto bail;
    -+				}
    -+
    -+				#ifdef NO_OPENSSL
    -+				fprintf(stderr, "You are trying to use PLAIN authentication mechanism "
    -+					"with OpenSSL library, but its support has not been compiled in.");
    -+				goto bail;
    -+				#endif
    -+
    -+				/* PLAIN */
    -+
    -+				memset(&cb, 0, sizeof(cb));
    -+				cb.cont = auth_plain;
    -+				if (imap_exec(ctx, &cb, "AUTHENTICATE PLAIN") != RESP_OK) {
    -+					fprintf(stderr, "IMAP error: AUTHENTICATE PLAIN failed\n");
    -+					goto bail;
    -+				}
     +			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
      				if (!CAP(AUTH_CRAM_MD5)) {
      					fprintf(stderr, "You specified "
 3:  f2773c646f =  4:  1510127888 imap-send: fix memory leak in case auth_cram_md5 fails
 4:  c111ee6bc1 !  5:  731fcbb602 imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
    @@ imap-send.c: static int auth_xoauth2(struct imap_store *ctx, const char *prompt
      {
      	if (srvc->user && srvc->pass)
     @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    - 						"but %s doesn't support it.\n", srvc->host);
    - 					goto bail;
    - 				}
    -+
    -+				#ifdef NO_OPENSSL
    -+				fprintf(stderr, "If you want to use CRAM-MD5 authentication mechanism, "
    -+					"you have to build git-imap-send with OpenSSL library.");
    -+				goto bail;
    -+				#endif
    -+
    - 				/* CRAM-MD5 */
    + 		server_fill_credential(srvc, &cred);
      
    - 				memset(&cb, 0, sizeof(cb));
    + 		if (srvc->auth_method) {
    +-			struct imap_cmd_cb cb;
    +-
    + 			if (!strcmp(srvc->auth_method, "PLAIN")) {
    + 				if (try_auth_method(srvc, ctx, imap, "PLAIN", AUTH_PLAIN, auth_plain))
    + 					goto bail;
    + 			} else if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
    +-				if (!CAP(AUTH_CRAM_MD5)) {
    +-					fprintf(stderr, "You specified "
    +-						"CRAM-MD5 as authentication method, "
    +-						"but %s doesn't support it.\n", srvc->host);
    +-					goto bail;
    +-				}
    +-				/* CRAM-MD5 */
    +-
    +-				memset(&cb, 0, sizeof(cb));
    +-				cb.cont = auth_cram_md5;
    +-				if (imap_exec(ctx, &cb, "AUTHENTICATE CRAM-MD5") != RESP_OK) {
    +-					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
    ++				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
    + 					goto bail;
    +-				}
    + 			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
    + 				if (try_auth_method(srvc, ctx, imap, "OAUTHBEARER", AUTH_OAUTHBEARER, auth_oauthbearer))
    + 					goto bail;
 5:  f12713f24b =  6:  36154d3276 imap-send: enable specifying the folder using the command line
 6:  d38caeae5e !  7:  85ce1205ca imap-send: fix minor mistakes in the logs
    @@ imap-send.c: static int ssl_socket_connect(struct imap_socket *sock UNUSED,
      			      int use_tls_only UNUSED)
      {
     -	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
    -+	fprintf(stderr, "SSL requested, but SSL support is not compiled in.\n");
    ++	fprintf(stderr, "SSL requested, but SSL support is not compiled in\n");
      	return -1;
      }
      
    @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *
      
      	/* read the greeting string */
     @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    + 				if (try_auth_method(srvc, ctx, imap, "XOAUTH2", AUTH_XOAUTH2, auth_xoauth2))
      					goto bail;
    - 				}
      			} else {
     -				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
     +				fprintf(stderr, "unknown authentication method:%s\n", srvc->host);
 7:  3ba02f2b0c =  8:  8dd19a4613 imap-send: display port alongwith host when git credential is invoked
 8:  6dbd0bf0bc =  9:  cc1398bb7c imap-send: display the destination mailbox when sending a message
 9:  f77f2423e1 = 10:  0975df9fc0 imap-send: add ability to list the available folders
-- 
2.49.0

