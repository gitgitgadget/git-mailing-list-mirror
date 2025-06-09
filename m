Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010010.outbound.protection.outlook.com [52.103.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453A61624CE
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483759; cv=fail; b=E+eLCx1Vxk2MU5nqDDaS3XC3iI2LUcocok//Sj3MBv0KOduohcjVF0DNxol+7lnBrvf/iigByD2mDVEOsMi+eOUL26TGZSKVMVanD8kAFiSm44EuLgFacp92y2lC0zwZTZMcI+L4lDCYffkWr24MqAGnatIDBK4+vnjxpHOOKn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483759; c=relaxed/simple;
	bh=dtUEHkNCUr39JiAjwNpB8qSOXKvkgCq6KbBjnnfBQww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dj+ck1jkGt0UV4+0MAOWNYuQz72pEKwRagZ3DcRXVbMGw79q+R5Hehoyk+PZBWBN86Lgqba+a/j8QHolWcpqY4IoYIKb943GURS3qjTJDgStY4tdIP/ImGdAxMqaTUBqcE8lgiN3zqv9ZmUnUEoUNbrnFnSy5lyz1OrWV/vQf6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=b0UK7Htc; arc=fail smtp.client-ip=52.103.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="b0UK7Htc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0N2m5v5s2F1J4Hu0sXTJPkGoEgoQRWd5p0onTavu7+j4hUu6NB0IGElG9uBJQcFx5h5An9qwYZxCRmGmK444SocZYsnKKmev7yylhf1GxoKQQhzcBrD/h+/GyWXZ3xkY2lTCZV42+SXtMexuDUXNAwvIL9Hyj7uUWVjBA/zHCQ9e46zFIDo2lOnxWZxQhp/iwrdaJqrvYdrNjjAnHz//bwdzDff9ZpU7DYa4SqbDwwuExMhVZH4oqr0PRAf/9Pjhp41b5R8X63B7y7cnPWX06ycHsC3XReHiRoh137E6atNDhuO3xjsvdp8W7h+pmuQOyV0OntqLGAzkBeyYYSE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHAz/qNwpp3ZxV6eRMsnGy6Ymp2sVEAsI4IY6fGJSO0=;
 b=mFHbVXdiKA74G1HHHe0lVb9EnAAeoLyO1B97SxydlzXRokFAbe+EU6zFLdw9+CHQNl6fU6b9icjdAvr7cPhURHfY4kIGs84TM+G079HiIl7hAc82gsw3gSta1MPlb26LWtqpILbRgrLDYK3Sxm2RsgOpJmoPBTU5Mymz+Z2cerDipkP54TmMvlCjrg3aKSIQXiflfXHevu+qesmtdGEEq8RsDrYbckX2jEn6ECpnHdJsA9UqKJIAf24PYckycnr7gj+IUmlaQxT+atSCXMAHhMZ2SMREYV8BXq5LDWo5n1w1Cm78JPqr/uzpqIZ6i4LJOVx17JcHmUNrLixwov8xLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHAz/qNwpp3ZxV6eRMsnGy6Ymp2sVEAsI4IY6fGJSO0=;
 b=b0UK7HtcxDRdxLMeJao3lTgV1X84vGRWr5w6XF2IJpm2quzN0vWGov8a/akEGS8ryyyON9eF5xpgNdLsS33+iJj4ZJhdyQAHi1T8pB/R41viFB/IXTjnj1Rr8j2mVKjO6RAUP+fjjLoYCw5P1lrElTaSn+ctYyjl8X2HrjLQgGs/MQgzsEKPkdj03QaMdba8sDt8VZkaqceLiBM3XCQHgHfx5ED5iPuHAJ4/86plMrywKeXU+LJtRaSV2zsynirAYtPknrQqYxUgbHqcUXZl1XU90MBirAkgACniUr1zFdKr50X/YkVyI3kt5soqdgGqaa2BwxjVUhgfEldYiLFigA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB5751.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 15:42:31 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:42:31 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v17 00/10] imap-send: make it usable again and add OAuth2.0 support
Date: Mon,  9 Jun 2025 15:41:19 +0000
Message-ID:
 <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.824.geaff4db692
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609154129.13552-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: c281820d-e2a3-48d4-7781-08dda76c3dd3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7092599006|8060799009|461199028|19110799006|15080799009|8022599003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2scHO9XACbbEBgGXwKsq9Sy7r8rSLUx6tuMbKQlSQ1nE56IGH4eV9OyeGP9C?=
 =?us-ascii?Q?W8XlcvqruwHWD3J0iQLUzqJIGJDIWSQPd13hQ7Z3wYa9YzKoQn7AiKDEmeRa?=
 =?us-ascii?Q?VxpsG5tblAlhD4FDK6VuB4VN9Y+UBt/llTs0jX1LLRHLis4W8eOkg7AV6xaZ?=
 =?us-ascii?Q?R5nJP1sbuTLBfi/lMhjYBCru+zgqngQA74IDQZAltTTb/W0mHURWLPePAgvq?=
 =?us-ascii?Q?tK6Ma8RywBMhQbdWdTzgDLgy3CbqKHDwn3KPHG8bd5AJgH4yf+XujIvzJ6/A?=
 =?us-ascii?Q?GP3a6ooklEa7iPEh3mitaOJNnUET7R0Zp2pB+r2pZktNaWcjCs5jMu+Uqftk?=
 =?us-ascii?Q?LrePfp9iXq4syUufzFeXH/NBP9ZQ5Ud06IHfJXVfLbehHxowLZEoC2+XL5YT?=
 =?us-ascii?Q?xv6u8hOdb4MvRvdKpMcz8n6A5ZHgWrAZyOTTnX+IzIYXxamF75EUbWb2X9Q6?=
 =?us-ascii?Q?UZAghK+/yWUiBgjjonczRFgj2km9YuPUYCriKblElT83lXGbjgdkoElbkUFU?=
 =?us-ascii?Q?FrVCtQ0ujITXj9JTH/4MUcbFEbz35Pxlg2mDhNnBMspfZhLI21XX4mA1c/by?=
 =?us-ascii?Q?PUL6hmThPSkXWnnJGh6pyDh+LAM4KZTjebgKze4xIm/+xX0i47QBZFx5bTtY?=
 =?us-ascii?Q?xFRZ5N6fApBw6ixZGyqrtmEixdkWqcOSJdFsJ2uEfY9aOA65bjFe9YQejGtR?=
 =?us-ascii?Q?EgnGKL4fcBG+dbSOM2Dj81jwXyOyeTA/evNsYciF35VZIfGUdJTl4gqZTHWM?=
 =?us-ascii?Q?thHWCnTcsEl0evUErj/d/AKB053HErAHKfbg+zLM/HANO6DiNY0W1gVJ1vOj?=
 =?us-ascii?Q?6xo+QZQgeuuawB9JgSwY7ALUfCy4+OuMMp0vkW8iYtIxExRY/kjqwCDQ/3/I?=
 =?us-ascii?Q?FCv28vkm07aNIW3u99rMK53yry6kuESJB4VObPxDiY1sMrW7axQlKX4xytel?=
 =?us-ascii?Q?gEEjDh7chWr8rUl83C/QMazK9Yp6+QvVO7miCkf72TRXilg5lfsoIO6Wr29P?=
 =?us-ascii?Q?fljm9ib51l2U+YCeIT/dDdHokEvfeV3+O9eVxCvt3LgWqNc+ip1WQg3XkPut?=
 =?us-ascii?Q?xV85nfjoShHHbt5uJftiHnV2VzccW4UayCHoEjkaE1H2L1e0WwZYNEpqqnGT?=
 =?us-ascii?Q?Oc3Vt+UHxWTwvDCNcprMDczcctvjddNW1HK9wibxNQ14232Ex3/evBU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EBiN9XjX60UtmzogMkaD1vGlDAXsGbQIgq7COH/fOc3WogjCH7SD0yigsr21?=
 =?us-ascii?Q?Fj7RhWGvkJ16zTVOWCLhefz2nQk17bEasQPAuFwqJOnoV9KvdxdGB8Z1e+30?=
 =?us-ascii?Q?jEGLjeXVd2ccoyjsMQzFyJ/N7yzrMrS0N2GAuLa/GmKkaiAaXwOtWjD4Qzxm?=
 =?us-ascii?Q?Tl4OnjPX3Xn8dDv4RhFoqvbuRQSLNQzzV6ToMeMJJoA9hyGoH0wcp30ygDev?=
 =?us-ascii?Q?21BYosA7/YyXSQLDvCpA13cHBvEZEaBHMmAnNOJ63bBwBr+wNpwFE/TF/KIy?=
 =?us-ascii?Q?oBk3CtfMozzB129t82bftNEnU3kLLqX7rU/I5dQpdGsi5sBUgzADjmtMBERi?=
 =?us-ascii?Q?QRrV4b+zVCLUFXbr9ZahwfGEmrUiKU03LaQmk53/wB0CFPmJokDfwW4EF0El?=
 =?us-ascii?Q?/7gTkhX0fwphZ06VTUEYo/xLwJnY0qRnze6Y1WjIMsbZC7FafLvLwxaI6BO1?=
 =?us-ascii?Q?KFJT6tOljlqVaXpKqHhohEo9ES63kh6kbE2inplsSAp8QSWEBCpE+Fjup79+?=
 =?us-ascii?Q?OSKzXvRSk1mvjnbSViS1uhGkIsjmu4dPSdFoTLBl1WKopXwxXMJS7ExOek0U?=
 =?us-ascii?Q?llOq3HUSGDuiwHq8t+KbfhXI4XDGpMevpnYQYzt+X/gs+YAr67bOIiHb0wnR?=
 =?us-ascii?Q?Vsx0S2chQtMmp9LeUlNhiEguF4cqULBJXl02/r7txdYnQkVXuxxEOq5IZxg8?=
 =?us-ascii?Q?fezXImNNmjz/Mm4jrJc3CSkxjIJbmlZePNw/bhqbCQaqeRd4UDcvoRjn38YM?=
 =?us-ascii?Q?4VHGlSsjRxPAXHQhwqPI1yxa9oALAGh5TcwTWUkFGT4jgMBfZyEglZMlZC8R?=
 =?us-ascii?Q?YAI2Tb+ASl0M8jCN4B8LmuzyN0otsy9jibkiqJsKtvP36gU5qmN96bd+ihlO?=
 =?us-ascii?Q?KhgvsqQqWZfhgjHoZnjmECyzL7U2yUO8uZseTGH+oHkqdQNkmWT6mzeXrx2f?=
 =?us-ascii?Q?xwZkookrd7NLAPIOh764njeqw9DIAM1iYs5pTHdBUNfLJE1nVcNjss2h254t?=
 =?us-ascii?Q?BZ1bz1yM77IwqKS4DBExk4ZxPPirdrIPG71PKTAT9Es5wmD2Iz8pVubd78Gp?=
 =?us-ascii?Q?2sDK7sLb+kEaLZZK6/52LE0F6UPD/90iYyHMai+MyZWG4OUfonlHei8IqlQL?=
 =?us-ascii?Q?bpv+2Mc7HId0wmdj+8mB+vVPGyQp5856m+9iocAQXSnYhVVREUCG3Mm5BMl0?=
 =?us-ascii?Q?q0ivWPmAp0UtG4cX3dkZAX3Qpw058RMS/imqip9pNmHdakoH3L2jK05GMgs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c281820d-e2a3-48d4-7781-08dda76c3dd3
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:42:31.3294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5751

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

Range-diff against v16:
 1:  194d108e15 <  -:  ---------- builtin/am: fix memory leak in `split_mail_stgit_series`
 2:  798369e8ce <  -:  ---------- t1001: replace 'test -f' with 'test_path_is_file'
 3:  dce2b90fb1 <  -:  ---------- oidmap: rename oidmap_free() to oidmap_clear()
 4:  9369c83cce <  -:  ---------- oidmap: add size function
 5:  f0a73c8578 <  -:  ---------- raw_object_store: drop extra pointer to replace_map
 6:  c4b2850438 <  -:  ---------- reftable/writer: fix memory leak when `padded_write()` fails
 7:  a795acc6ed <  -:  ---------- reftable/writer: fix memory leak when `writer_index_hash()` fails
 8:  8fdb6df271 <  -:  ---------- reftable: fix perf regression when reading blocks of unwanted type
 9:  ce0b8c96b9 <  -:  ---------- The sixteenth batch
10:  3e3ddf7077 =  1:  4accbe6ecf imap-send: fix bug causing cfg->folder being set to NULL
11:  417b3b8e38 =  2:  1cfd66ccea imap-send: fix memory leak in case auth_cram_md5 fails
12:  c4216528e7 =  3:  12ff5135be imap-send: gracefully fail if CRAM-MD5 authentication is requested without OpenSSL
13:  b38fca0e6a !  4:  43b18dbfb0 imap-send: add support for OAuth2.0 authentication
    @@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct crede
      	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
      	strbuf_addstr(&path, srvc->host);
     @@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
    - 	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
    + 	curl_easy_setopt(curl, CURLOPT_PORT, (long)srvc->port);
      
      	if (srvc->auth_method) {
     -		struct strbuf auth = STRBUF_INIT;
14:  86d3d2c54d =  5:  1ebf9f935f imap-send: add PLAIN authentication method to OpenSSL
15:  7674e749c8 =  6:  0c6283407c imap-send: enable specifying the folder using the command line
16:  90ce3a63f3 !  7:  f59cb1dca1 imap-send: add ability to list the available folders
    @@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct crede
      	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
      	strbuf_release(&path);
     @@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
    - 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
    - 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
    + 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, (long)srvc->ssl_verify);
    + 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, (long)srvc->ssl_verify);
      
     -	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
     -
17:  1bdd054908 =  8:  1247afbe78 imap-send: display port alongwith host when git credential is invoked
18:  e381120ab5 =  9:  c30ecbf508 imap-send: display the destination mailbox when sending a message
19:  6561d45bee = 10:  eaff4db692 imap-send: fix minor mistakes in the logs
-- 
2.49.0.824.geaff4db692

