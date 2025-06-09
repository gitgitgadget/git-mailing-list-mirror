Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2981D86FF
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500613; cv=fail; b=bQBY+LaCrpoVXeI8DlsvEplpL7L8sUSwfG6suG7oLl6TCjZYrTIWaUwrIVVLe3apNShtCDS2yU7ZLv5ce1D75oLBj9DZPk4cw7P+FlDstkNerNt2rk7YGVx2huAjcEDEBg7KwWxJVpQDA/J9Xz7INb7tdsyxJVe9aqVagsZ8Jyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500613; c=relaxed/simple;
	bh=TGN7fSy4mcY7m+2+WPV/bOtJNut9Q2pKGdaTaegKRl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XvVKghzY73+RMH5Ilp+4qvOgzZZlsIY/+33FW/yJwur++kyIhXuToT6BmSsQ9xDR/MGp5WpdJg6d2gjyCLwwWnhP0h47zhw4boqYSbSon7ucljC+2+VzAkb3lTljjqpjNRc+nwf/dBpohuIZlX3fCsl30YEfnmE+M7MqPg+kbdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=F7s2zqa2; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="F7s2zqa2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YE1R+BOjzHihkatHME07zNfPFKZV6+b6VKuIaQtxrwjqCIffKDp6cqmAuY7w4uz9NbrKr6LQkvpNT37lpOFAJerswbYh9O/ZLS1nyKcNZAn2qbQYgEXzeuUoow4YR3wTFtD5qqUVQ7LRw1PPKDTXcZFveKCeotNE/uxwNqbVucBWz/fM5GLAnVYdzuR9MvZSnaSzf/fifhNoHYdEOeBOgYFw5LTBmv1osxZL6JBfx1YR8CP8fu5Q1pjZHGUgKPq4oXqHFQ7kbn1LYmqVXTVZYcuXBYC2cDNrSod4V8GyOFHtFlUgvYExlPEkvFuKf4d1jAGju4MB2CJ4Z9tVSc5YFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lEnIszzIzfnk5aO8pcdIvRHa9zICDoIakCS3UpD+SM0=;
 b=asTgnb0oFb9J2u2oKJ7KUoRkHLcrsl/6iVECRnMcAfPUSnGQw1NSFS/VCb9S3I4fcTHO9ASTOQRO5cF3KWdXwvo8S+lWzYrCsTaSEjqW+f1tUeL9ub6yp7qUYzWP+4rTrCOqes2XKgDMWMvfmLCzVY9IRMxyJlRuAt48c7PAspI9tyrNsd40k0fxWBQIKc0OBP9hpKgUDf8jMtAzdNUat2inRVtg0MgRpczIOTmzMsOihM6yDb6Yq2fhr2GDHNJc7N6MuN4p1VbW8QPOpMELEzi1GgIMHC53rfezJ9oIupeWdWMaxhGG9U8nw1xYY0q6AWNdlUsUPlFSlZjJ6dwGZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lEnIszzIzfnk5aO8pcdIvRHa9zICDoIakCS3UpD+SM0=;
 b=F7s2zqa2YH9zJ/BG2uZC1xrGOr7xtB2JHP6wdMWx5M0SppwlpyHJ41yeVCwN+kauFiyHZFFetBUXej+gkq4sBJI3H6vo536aWboPWlvhY93rOG4jaSePdW36ycXt55yXxIkrOK9euBNdXwjJCEuYBsDET2pqkItT3XuyaeK9saH9pbY+jpfrr51kWudFq0MaNl6Oo/Uic5u/o/x13UEOgzjpSC+AiEgHgSdsO3rh/Pzt93HG5c124W9s0GhdxicclBx8sEbOPdk6hCwzB+HyKQVVzrCHj3WAJ7JWwZznA/8RGCri6kjG1EkOVTE1p+DXnaaQON6TWd9ScgUYeD9pyQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 20:23:26 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:23:25 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v18 00/10] imap-send: make it usable again and add OAuth2.0 support
Date: Mon,  9 Jun 2025 20:22:45 +0000
Message-ID:
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250609202255.4341-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: c746ab12-8e1e-494d-6200-08dda7937c3c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|12121999007|7092599006|461199028|5072599009|19110799006|15080799009|8022599003|41001999006|4302099013|440099028|3412199025|19111999003|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wqwwxuPHTGN1xfYnSAZaca74aJJoTJsE+9Pp4tklxzoTmyEODlkX+zY1LMHr?=
 =?us-ascii?Q?zE3VZS0MlZYe4ZqTmXNR376vMgxwVL+/uhiH1y4G/QV55O2pR39/+efin5Fi?=
 =?us-ascii?Q?syKUJbyKf/TRxU0yXSSWbo4hW0RkcLL3rP2CGXVjEfBua40igYxJ7oZ1tHtm?=
 =?us-ascii?Q?oK8uTVLv+j3gd+w6iwtbyI7QoJX+QiAEY0mnRmtNVqflTn1Ye6v+84FXp77F?=
 =?us-ascii?Q?3c9pS444aX1+g3iwEG6PvBTiyDwp6Xm1MQCihKyvXLdx+fI+iJ1uGQ8vwbOC?=
 =?us-ascii?Q?yAC+dg461WZEFCIPTat7P55lNjfuPbazjmb7WmvFzXpWDOLy8IZr/qWDOIJA?=
 =?us-ascii?Q?gzg+FZhEjBvSXZK0231Unkal6nUfMvjPZxjyLR8Dus0LfZnSvcs12fx+3SLo?=
 =?us-ascii?Q?BKn/moRmTUhF9UzefD0IUtob2L0AKbwWpz4FTW0+MG+CYzuUGDd8fL1gQngM?=
 =?us-ascii?Q?oFdGa9OUSvrs8g510CBoUqi3juBm/VJflIb/SZxfGfagmncpef6eJm7bsdoj?=
 =?us-ascii?Q?fcYYtHt3uWR2fqTLvd73QjEa/h6caJKwSWXZ6nZDRmFF/XVe42PvToCrugIi?=
 =?us-ascii?Q?fEELdR8+5G9v/hp7lxV9ectfBE91lu9a3v4QkIV9Cn6auPMSoPIEMHXaWPeS?=
 =?us-ascii?Q?4/WELKAYaILtbPBOWFSwefSWAEpq9LvkepF4Y5AoAn/InrYC5/F4KnuF3fL0?=
 =?us-ascii?Q?sRCU2Cr+9oYEm7eqPRUlM1r1pFYkXUaiJVLtLlcnR3Ezi2pTxQzFVElWGi9P?=
 =?us-ascii?Q?P60GrkjrIfJMNjAX9KV3tfen9sqRNzajoh19etpL0p1X03LzNjzqaIxmZ1MS?=
 =?us-ascii?Q?uht2hxsNsW0CHYje5WX/dpD/y8BeprwRrP7964DSdOGv6Su4+5aIV5RB0MbY?=
 =?us-ascii?Q?p1qerxoMNmWybzJO8YHxlgffhNnz6Yh6mwy8P9fkvLIXXjzrz4xzOiMEHqI4?=
 =?us-ascii?Q?XmDjB68O/hGyRh4znT0sulib+e/fVj5ULzQiO1Wvqwc7KwqVf3UK5TjUTY2F?=
 =?us-ascii?Q?7OhYTitrtmDIoKgvr5f9UGXNbjk92XqnTE9fbWThXnysyyLCoFw9obgV4m6S?=
 =?us-ascii?Q?Xl4tZ7uWIjPg1CFfuHwlV4MF7NUda3SieAQEMGxhuxd5joH8xJQQ36MrM1jw?=
 =?us-ascii?Q?6l8oN+oxcxfqu8V6DCId1YZA5G92Y/CAqjqf0WWbK8Oaym43cuqFqBExWOjR?=
 =?us-ascii?Q?uortPD7X9O22bIZw1KOcqOodRQMnjcWchwG8Y+p4q0ZJJ6rMgYz0r+Ms9Vk7?=
 =?us-ascii?Q?nsut+LLRgDjkhqGawl3OJxnMsh1F+4CspDdSD7BcLB9MRdF8njPJ+ATQ3x0Z?=
 =?us-ascii?Q?95WGsbbpjjqPdiOo8B8kE8P2i/Th0sUexmj8zkVBrZqiUmuA2FLAnShv5SV/?=
 =?us-ascii?Q?sNOaxisCeMqDb0IQgMJwqQmLxBBikOxwRciIgiotlIWwhyytMQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eyU8HeRuJgS0+a0wXygHLnyVu+wBI8qlfV7ZaYMu55LQmnh5TwcV4XxLrnBQ?=
 =?us-ascii?Q?my3svs+BYFCjA4qQ0HuTaaUlkAOOSSBlkdWtsY1ZFy3WKe05StAb2nSszyxQ?=
 =?us-ascii?Q?fr5wGc2iOHsLdFb7a8lsri/TTrYIqVTSmeq0X0TFheEgXX5BEQftDIiKXJ/r?=
 =?us-ascii?Q?neCCOORHyAyOmFWMiX5B8wN40/MpFSjGchBnz79Yodn30CcuWcL8GWbfbYlb?=
 =?us-ascii?Q?q2T5JabtJYSwwngGRZXsszgnlx69UDO9dT05y7bSxkp33R8dz/ZbjWGeGFT6?=
 =?us-ascii?Q?Ds2oqHujmVkFivHbkQhmN3xgNFseoHOKngMSRXc4btqtizxoUJzpCyQZV5ip?=
 =?us-ascii?Q?CtmQccx+r7alXSbpyCIquOuRxnakeetMKAsL0Z85MdFORWMAWtDzg7bPZZCy?=
 =?us-ascii?Q?T8t9A2qe0SuHC+yUI/ac3d6r09fcN5sdqZkrpIpbt1fI+85XSycNvzHM9Yrj?=
 =?us-ascii?Q?ypBGgMBmzUujeXcneVuv9j1Cm2rQQ3rx6kIXlmnsmkNbIrIHIc709Ve1OLCP?=
 =?us-ascii?Q?db10WNv0z+gbbJF/2lKAkdVTgd7dsRIPpTJ+/t2h6EvTEyQEQ+Tl5aewpBQu?=
 =?us-ascii?Q?pDx/Icsj/0jF55sNpcY0ow5W+FZ1PmiSYflh1nrqh8hyymKdhq0go8pXHSD9?=
 =?us-ascii?Q?HzWrVxLMwjao2CtIZ9fqJuTZz9ii3xbgWbfDm0h5xD0v3FZwmF89MKRejYXH?=
 =?us-ascii?Q?NOitq+3ngrKoqtaV/BR1stZsPQQceWUU/pZZF7+DNZ/8wxGO+lrMNmpanEOt?=
 =?us-ascii?Q?cJ2+GCmQE6CFtMyipnVGNOqlqkHv2F/6DLr5JPHkbzVE0YnHwlczfGop0wHm?=
 =?us-ascii?Q?QUfFRwrQPXa45+75A400rm3l8Aeqo5wquX9hhVRyhLBEgCKI6Q2bTRVIRSZX?=
 =?us-ascii?Q?KeB5fSsuYFuoMY47zgJ5o0aW1G0pUUM3ZE+MKyyAuOAhw9PnAbFj0p2l1cZC?=
 =?us-ascii?Q?yrV/JOdPZOw2kiiXysxf0e8LhKbtdVsUo+6qd1zQS13CZ0gSfmSQeuMjS8v9?=
 =?us-ascii?Q?hfdsO0mGqBt8BI4IevP586mMmmbzlOK0bQ6rQWCVuhttZvGDOC9eIjblTlOK?=
 =?us-ascii?Q?Ktbobnuu1aYOcZt73vqqdvsunpnWPhw5HjS2n1pr9H71giF5ANfT03RrQ4Xo?=
 =?us-ascii?Q?GIIi170GRkYIiHutKjX998bVq5a878pFXp9ZdTkQFtTx+n6Lg7AsIMHNNMgL?=
 =?us-ascii?Q?gkhoOrhljHH0lIz4O+jCLLly2M2AnYNtdszEGmh5fNK32hx6lDceSbTAlg8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c746ab12-8e1e-494d-6200-08dda7937c3c
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:23:25.8982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4380

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
v15: - Simply rearrange the patches to make the cram md5 patches come
       before adding OAuth2.0 and PLAIN authentication methods. No 
       change has been done to the code itself.
v16: - Rearrage some more patches so that the two new features, i.e.,
       --folder and --list come just after the new authentication
       methods. Then the two patches with minor improvements of displaying
       the destination mailbox and displaying port alongwith host have
       been added. The patch fixing other minor mistakes in the logs has
       been moved to the end. Just like v15, no change has been done
       to the code itself.
v17: - Rebase on top of master where 30325e2 was causing a conflict.
       (Sorry for the bad range diff, but I think its easy to understand)
v18: - Avoid initialising variables with 0 or NULL. Let them remain
       uninitialised
     - Add a white at it note to the commit message of the patch that
       adds support to specify the folder.
     - Add another minor fix to the log that displays the unknown auth
       mechanism used. It was displaying the host rather than the mechanism.
     - Remove unecessary and pessimistic lines from the patch that enabled
       showing the host alongwith the port.

Aditya Garg (10):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: fix memory leak in case auth_cram_md5 fails
  imap-send: gracefully fail if CRAM-MD5 authentication is requested
    without OpenSSL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: enable specifying the folder using the command line
  imap-send: add ability to list the available folders
  imap-send: display port alongwith host when git credential is invoked
  imap-send: display the destination mailbox when sending a message
  imap-send: fix minor mistakes in the logs

 Documentation/config/imap.adoc   |  11 +-
 Documentation/git-imap-send.adoc |  68 ++++-
 imap-send.c                      | 412 ++++++++++++++++++++++++++-----
 3 files changed, 414 insertions(+), 77 deletions(-)

Range-diff against v17:
 -:  ---------- >  1:  4accbe6ecf imap-send: fix bug causing cfg->folder being set to NULL
 -:  ---------- >  2:  1cfd66ccea imap-send: fix memory leak in case auth_cram_md5 fails
 -:  ---------- >  3:  12ff5135be imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
 1:  0c6283407c !  4:  43b18dbfb0 imap-send: enable specifying the folder using the command line
    @@ Metadata
     Author: Aditya Garg <gargaditya08@live.com>
     
      ## Commit message ##
    -    imap-send: enable specifying the folder using the command line
    +    imap-send: add support for OAuth2.0 authentication
     
    -    Some users may very often want to imap-send messages to a folder
    -    other than the default set in the config. Add a command line
    -    argument for the same.
    +    OAuth2.0 is a new way of authentication supported by various email providers
    +    these days. OAUTHBEARER and XOAUTH2 are the two most common mechanisms used
    +    for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2], whereas
    +    XOAUTH2 is Google's proprietary mechanism (See [3]).
    +
    +    [1]: https://datatracker.ietf.org/doc/html/rfc5801
    +    [2]: https://datatracker.ietf.org/doc/html/rfc7628
    +    [3]: https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
     
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
     
      ## Documentation/config/imap.adoc ##
    -@@
    - imap.folder::
    - 	The folder to drop the mails into, which is typically the Drafts
    --	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
    --	"[Gmail]/Drafts". Required.
    -+	folder. For example: `INBOX.Drafts`, `INBOX/Drafts` or
    -+	`[Gmail]/Drafts`. The IMAP folder to interact with MUST be specified;
    -+	the value of this configuration variable is used as the fallback
    -+	default value when the `--folder` option is not given.
    - 
    - imap.tunnel::
    - 	Command used to set up a tunnel to the IMAP server through which
    +@@ Documentation/config/imap.adoc: imap.authMethod::
    + 	Specify the authentication method for authenticating with the IMAP server.
    + 	If Git was built with the NO_CURL option, or if your curl version is older
    + 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
    +-	option, the only supported method is 'CRAM-MD5'. If this is not set
    +-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
    ++	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
    ++	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
    ++	plaintext `LOGIN` command.
     
      ## Documentation/git-imap-send.adoc ##
    -@@ Documentation/git-imap-send.adoc: git-imap-send - Send a collection of patches from stdin to an IMAP folder
    - SYNOPSIS
    - --------
    - [verse]
    --'git imap-send' [-v] [-q] [--[no-]curl]
    -+'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
    - 
    - 
    - DESCRIPTION
    - -----------
    --This command uploads a mailbox generated with 'git format-patch'
    -+This command uploads a mailbox generated with `git format-patch`
    - into an IMAP drafts folder.  This allows patches to be sent as
    - other email is when using mail clients that cannot read mailbox
    - files directly. The command also works with any general mailbox
    --in which emails have the fields "From", "Date", and "Subject" in
    -+in which emails have the fields `From`, `Date`, and `Subject` in
    - that order.
    - 
    - Typical usage is something like:
    - 
    --git format-patch --signoff --stdout --attach origin | git imap-send
    -+------
    -+$ git format-patch --signoff --stdout --attach origin | git imap-send
    -+------
    - 
    - 
    - OPTIONS
    -@@ Documentation/git-imap-send.adoc: OPTIONS
    - --quiet::
    - 	Be quiet.
    - 
    -+-f <folder>::
    -+--folder=<folder>::
    -+	Specify the folder in which the emails have to saved.
    -+	For example: `--folder=[Gmail]/Drafts` or `-f INBOX/Drafts`.
    -+
    - --curl::
    - 	Use libcurl to communicate with the IMAP server, unless tunneling
    - 	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
    -
    - ## imap-send.c ##
    -@@
    +@@ Documentation/git-imap-send.adoc: Using Gmail's IMAP interface:
    + 
    + ---------
    + [imap]
    +-	folder = "[Gmail]/Drafts"
    +-	host = imaps://imap.gmail.com
    +-	user = user@gmail.com
    +-	port = 993
    ++    folder = "[Gmail]/Drafts"
    ++    host = imaps://imap.gmail.com
    ++    user = user@gmail.com
    ++    port = 993
    + ---------
    + 
    ++Gmail does not allow using your regular password for `git imap-send`.
    ++If you have multi-factor authentication set up on your Gmail account, you
    ++can generate an app-specific password for use with `git imap-send`.
    ++Visit https://security.google.com/settings/security/apppasswords to create
    ++it. Alternatively, use OAuth2.0 authentication as described below.
    ++
    + [NOTE]
    + You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
    + that the "Folder doesn't exist".
    +@@ Documentation/git-imap-send.adoc: that the "Folder doesn't exist".
    + If your Gmail account is set to another language than English, the name of the "Drafts"
    + folder will be localized.
      
    - static int verbosity;
    - static int use_curl = USE_CURL_DEFAULT;
    -+static char *opt_folder = NULL;
    ++If you want to use OAuth2.0 based authentication, you can specify
    ++`OAUTHBEARER` or `XOAUTH2` mechanism in your config. It is more secure
    ++than using app-specific passwords, and also does not enforce the need of
    ++having multi-factor authentication. You will have to use an OAuth2.0
    ++access token in place of your password when using this authentication.
    ++
    ++---------
    ++[imap]
    ++    folder = "[Gmail]/Drafts"
    ++    host = imaps://imap.gmail.com
    ++    user = user@gmail.com
    ++    port = 993
    ++    authmethod = OAUTHBEARER
    ++---------
    ++
    ++Using Outlook's IMAP interface:
    ++
    ++Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Also, it
    ++supports only `XOAUTH2` as the mechanism.
    ++
    ++---------
    ++[imap]
    ++    folder = "Drafts"
    ++    host = imaps://outlook.office365.com
    ++    user = user@outlook.com
    ++    port = 993
    ++    authmethod = XOAUTH2
    ++---------
    ++
    + Once the commits are ready to be sent, run the following command:
      
    --static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
    -+static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
    +   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
    +@@ Documentation/git-imap-send.adoc: Just make sure to disable line wrapping in the email client (Gmail's web
    + interface will wrap lines no matter what, so you need to use a real
    + IMAP client).
      
    - static struct option imap_send_options[] = {
    - 	OPT__VERBOSITY(&verbosity),
    - 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
    -+	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder"),
    - 	OPT_END()
    ++In case you are using OAuth2.0 authentication, it is easier to use credential
    ++helpers to generate tokens. Credential helpers suggested in
    ++linkgit:git-send-email[1] can be used for `git imap-send` as well.
    ++
    + CAUTION
    + -------
    + It is still your responsibility to make sure that the email message
    +
    + ## imap-send.c ##
    +@@ imap-send.c: enum CAPABILITY {
    + 	LITERALPLUS,
    + 	NAMESPACE,
    + 	STARTTLS,
    +-	AUTH_CRAM_MD5
    ++	AUTH_CRAM_MD5,
    ++	AUTH_OAUTHBEARER,
    ++	AUTH_XOAUTH2,
    + };
    + 
    + static const char *cap_list[] = {
    +@@ imap-send.c: static const char *cap_list[] = {
    + 	"NAMESPACE",
    + 	"STARTTLS",
    + 	"AUTH=CRAM-MD5",
    ++	"AUTH=OAUTHBEARER",
    ++	"AUTH=XOAUTH2",
      };
      
    -@@ imap-send.c: int cmd_main(int argc, const char **argv)
    + #define RESP_OK    0
    +@@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const char *pass)
    + 	return (char *)response_64;
    + }
      
    - 	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
    ++static char *oauthbearer_base64(const char *user, const char *access_token)
    ++{
    ++	int raw_len, b64_len;
    ++	char *raw, *b64;
    ++
    ++	/*
    ++	 * Compose the OAUTHBEARER string
    ++	 *
    ++	 * "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
    ++	 *
    ++	 * The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
    ++	 * * gs2-cb-flag `n` -> client does not support CB
    ++	 * * gs2-authzid `a=" {User} "`
    ++	 *
    ++	 * The second part are key value pairs containing host, port and auth as
    ++	 * described in RFC7628.
    ++	 *
    ++	 * https://datatracker.ietf.org/doc/html/rfc5801
    ++	 * https://datatracker.ietf.org/doc/html/rfc7628
    ++	 */
    ++	raw_len = strlen(user) + strlen(access_token) + 20;
    ++	raw = xmallocz(raw_len + 1);
    ++	snprintf(raw, raw_len + 1, "n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
    ++
    ++	/* Base64 encode */
    ++	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
    ++	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
    ++	free(raw);
    ++
    ++	if (b64_len < 0) {
    ++		free(b64);
    ++		return NULL;
    ++	}
    ++	return b64;
    ++}
    ++
    ++static char *xoauth2_base64(const char *user, const char *access_token)
    ++{
    ++	int raw_len, b64_len;
    ++	char *raw, *b64;
    ++
    ++	/*
    ++	 * Compose the XOAUTH2 string
    ++	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
    ++	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
    ++	 */
    ++	raw_len = strlen(user) + strlen(access_token) + 20;
    ++	raw = xmallocz(raw_len + 1);
    ++	snprintf(raw, raw_len + 1, "user=%s\001auth=Bearer %s\001\001", user, access_token);
    ++
    ++	/* Base64 encode */
    ++	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
    ++	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
    ++	free(raw);
    ++
    ++	if (b64_len < 0) {
    ++		free(b64);
    ++		return NULL;
    ++	}
    ++	return b64;
    ++}
    ++
    + static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    + {
    + 	int ret;
    +@@ imap-send.c: static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    + 	return 0;
    + }
      
    -+	if (opt_folder) {
    -+		free(server.folder);
    -+		server.folder = xstrdup(opt_folder);
    ++static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
    ++{
    ++	int ret;
    ++	char *b64;
    ++
    ++	b64 = oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
    ++	if (!b64)
    ++		return error("OAUTHBEARER: base64 encoding failed");
    ++
    ++	/* Send the base64-encoded response */
    ++	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
    ++	if (ret != (int)strlen(b64)) {
    ++		free(b64);
    ++		return error("IMAP error: sending OAUTHBEARER response failed");
     +	}
     +
    - 	if (argc)
    - 		usage_with_options(imap_send_usage, imap_send_options);
    ++	free(b64);
    ++	return 0;
    ++}
    ++
    ++static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
    ++{
    ++	int ret;
    ++	char *b64;
    ++
    ++	b64 = xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
    ++	if (!b64)
    ++		return error("XOAUTH2: base64 encoding failed");
    ++
    ++	/* Send the base64-encoded response */
    ++	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
    ++	if (ret != (int)strlen(b64)) {
    ++		free(b64);
    ++		return error("IMAP error: sending XOAUTH2 response failed");
    ++	}
    ++
    ++	free(b64);
    ++	return 0;
    ++}
    ++
    + #else
    + 
    + #define auth_cram_md5 NULL
    ++#define auth_oauthbearer NULL
    ++#define auth_xoauth2 NULL
    + 
    + #endif
    + 
    +@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    + 			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
    + 				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
    + 					goto bail;
    ++			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
    ++				if (try_auth_method(srvc, ctx, imap, "OAUTHBEARER", AUTH_OAUTHBEARER, auth_oauthbearer))
    ++					goto bail;
    ++			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
    ++				if (try_auth_method(srvc, ctx, imap, "XOAUTH2", AUTH_XOAUTH2, auth_xoauth2))
    ++					goto bail;
    + 			} else {
    + 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
    + 				goto bail;
    +@@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
    + 
    + 	server_fill_credential(srvc, cred);
    + 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
    +-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
    ++
    ++	/*
    ++	 * Use CURLOPT_PASSWORD irrespective of whether there is
    ++	 * an auth method specified or not, unless it's OAuth2.0,
    ++	 * where we use CURLOPT_XOAUTH2_BEARER.
    ++	 */
    ++	if (!srvc->auth_method ||
    ++	    (strcmp(srvc->auth_method, "XOAUTH2") &&
    ++	    strcmp(srvc->auth_method, "OAUTHBEARER")))
    ++		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
    + 
    + 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
    + 	strbuf_addstr(&path, srvc->host);
    +@@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
    + 	curl_easy_setopt(curl, CURLOPT_PORT, (long)srvc->port);
    + 
    + 	if (srvc->auth_method) {
    +-		struct strbuf auth = STRBUF_INIT;
    +-		strbuf_addstr(&auth, "AUTH=");
    +-		strbuf_addstr(&auth, srvc->auth_method);
    +-		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
    +-		strbuf_release(&auth);
    ++		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
    ++		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
    ++
    ++			/*
    ++			 * While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
    ++			 * upon debugging, it has been found that it is capable of detecting
    ++			 * the best option out of OAUTHBEARER and XOAUTH2.
    ++			 */
    ++			curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, srvc->pass);
    ++		} else {
    ++			struct strbuf auth = STRBUF_INIT;
    ++			strbuf_addstr(&auth, "AUTH=");
    ++			strbuf_addstr(&auth, srvc->auth_method);
    ++			curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
    ++			strbuf_release(&auth);
    ++		}
    + 	}
      
    + 	if (!srvc->use_ssl)
 -:  ---------- >  5:  1ebf9f935f imap-send: add PLAIN authentication method to OpenSSL
 -:  ---------- >  6:  ce2cfa34cf imap-send: enable specifying the folder using the command line
 2:  f59cb1dca1 !  7:  5c36e68493 imap-send: add ability to list the available folders
    @@ imap-send.c
      #endif
      
      static int verbosity;
    -+static int list_folders = 0;
    ++static int list_folders;
      static int use_curl = USE_CURL_DEFAULT;
    - static char *opt_folder = NULL;
    + static char *opt_folder;
      
     -static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
     +static char const * const imap_send_usage[] = {
 3:  1247afbe78 !  8:  cc4f88791f imap-send: display port alongwith host when git credential is invoked
    @@ Commit message
         Also, this behaviour will also mimic git send-email, which displays
         the port along with the host name when requesting for a password.
     
    -    FWIW, if no port is specified by the user, the default port, 993 for
    -    IMAPS and 143 for IMAP is used by the code. So, the case of no port
    -    defined for the helper is not possible, and therefore is not added.
    -
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
     
      ## imap-send.c ##
 4:  c30ecbf508 =  9:  82432c7b21 imap-send: display the destination mailbox when sending a message
 5:  eaff4db692 ! 10:  d780afc026 imap-send: fix minor mistakes in the logs
    @@ Commit message
     
         Some minor mistakes have been found in the logs. Most of them include
         error messages starting with a capital letter, and ending with a period.
    -    Also, abbreviations like "IMAP" and "OK" should be in uppercase. Fix them.
    +    Abbreviations like "IMAP" and "OK" should also be in uppercase. Another
    +    mistake was that the error message showing unknown authentication
    +    mechanism used was displaying the host rather than the mechanism in the
    +    logs. Fix them.
     
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
     
    @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *
      					goto bail;
      			} else {
     -				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
    -+				fprintf(stderr, "unknown authentication method:%s\n", srvc->host);
    ++				fprintf(stderr, "unknown authentication mechanism: %s\n", srvc->auth_method);
      				goto bail;
      			}
      		} else {
-- 
2.49.0

