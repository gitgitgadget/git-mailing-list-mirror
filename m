Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010015.outbound.protection.outlook.com [52.103.68.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B19460
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748767139; cv=fail; b=JEMUXf4AHtdEjYwFq323osYRTtqoDnuXnwWEfF0rNvi6+RvNd7QQlOeBFsMfLj+3u4gZvsVXNeqRHxRY/AVY05ZanIUqQpKL8ISK5d1h7WCrqwu5C8+HDKuFrB1rH4nYPqCKW2oaAXT3CW2ohRtMf+iEMTJND2QSJO02HeBDa6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748767139; c=relaxed/simple;
	bh=ItTbh0kkWs2bMSb5t71ebBElUwwVh9YI9E+NQxG2cGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p/YklypV1Nc9dUUxjuB5uBhlLehMYuGKRmxej7XUTkASfT+huJ1cwS31LKQpAOTKgSiKVwGLhwszp/CdFT86oQwcQ+xIHkBhGrr7drcpObX9rs34IbJ3+iA4S0XOCKcJ3XLU/fsxCtFkHfuGDVdMJyYom9pMwL6BlB+pPeE5qro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UMYHlq4A; arc=fail smtp.client-ip=52.103.68.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UMYHlq4A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAQUCf2ggXZGNwQ1VmrzqSPT+IPD8Je2UDsJu7Wbq5MWRMMxrHyYtUyvnNKhyOtdQjNQWLnsbNS7xRBnetuQE0Dl+g5alE6PmN2dCl/dPg4tDPiivgpBxKtlEg1QA4pzj8uFN8nGKaSPwPTSOR1QMsx9sLKi9td3dZmSLDPJ8sQDlFZeU/x7yXw6hJ/WQ+Yx3miUmOmlO9XBUltngYt2JQydYB1ck/a0m6oLsy9kMn1OjPPW0De/DBXSDB7ZTK8ENZLrF6/Hi08TObaSfI9GdrhUx7MgecjOblqiBF261QPfjk7M/9YTvjrrkewO5AyeERyP9q+7h2e0v/yNYEgPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDI3rYobXLL64x6FW0SwVRZY0xnDJZQq8nDuhF0fd9Y=;
 b=c1yAQU3a7+tXr3AvxeuXePWIR79NtAh4LuY3YOw/i56i9ZZkjeSWSnT7ZlYyMlPb+ad9mF8d2c9wY8ktuthZ1DPYAqJuZxdYZC2t8VPEN7vMHYKdiArij4WE7vXa9pGODjLFqoYtUksh6sdNKA9IGZYkwR8UnSycQJp5yjY8nnnIQZobK8RRXe+u853CVLibOZ5hgOLZVPKKNGiReIYm19WK/HWaVGZXsYors1zxgVYGlcfWroij4wOH82PkZ4flB2DWscysDv/aLcTenDiUBbLlhUdyp77A1/pKGYFE8LHHjShMO7QhzaRxWnk4rjqkvJJ6qJ6Jg4KLE5UXD1eBuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDI3rYobXLL64x6FW0SwVRZY0xnDJZQq8nDuhF0fd9Y=;
 b=UMYHlq4AHehkxmtreGlo79OIujL5NdYEdDr2YNsgUCsLZqW1zQ76b+HjCTmCSQ1KOh3QlWZAiGnm+WqCNNXrvn5lmJPKY82aUfO9jr7iK8voimQerOIv1PilPByaF3tt7Lksq1SWY12iiNH61IL17pd8PXPAJawpnH8jzl0Io1cNm0XsBuVqrU8NyR42Wfj7cYNMR28y/ee5KhDSkGDt5TGdis0NvIge4lzb86xvCdWtggqm3Mj1IVi5YGzCIA0ReYTDtF3oO64744UIY+Zt8NYwMR+4q1oPpgq7kBTSYgFdJ8dTa0Stpul8D1+EMI8hS1ySosScTaN8ioGA93x6Tw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6304.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Sun, 1 Jun
 2025 08:38:49 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 08:38:49 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v11 0/9] imap-send: make it usable again and add OAuth2.0
 support
Thread-Topic: [PATCH v11 0/9] imap-send: make it usable again and add OAuth2.0
 support
Thread-Index: AQHb0tCYTZlIR31fgkSXXyTxe4TPTA==
Date: Sun, 1 Jun 2025 08:38:49 +0000
Message-ID: <20250601083821.2440110-1-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB6304:EE_
x-ms-office365-filtering-correlation-id: 2426a610-aeaa-4ddf-bc38-08dda0e7bb62
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|41001999006|7092599006|12121999007|8062599006|8060799009|15080799009|19110799006|1602099012|3412199025|4302099013|440099028|102099032|10035399007|19111999003|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9kP4FaIYxMxC8gcePhGNi9kd/ozc8mkQghhkq4wu5ST6rTkhvNeTgE36rI?=
 =?iso-8859-1?Q?G6/kmTesYY69TjFA04BxzI0uZZ+mFy4z3Sjtot8lSuAr+AMnHqP7jPuMaB?=
 =?iso-8859-1?Q?gOuHdofx2T7wzb0zDAl5UWLKnu77R6jonj2J1xiucjzMLiz/1jyMxslCL/?=
 =?iso-8859-1?Q?Fh2P+RmLxuqZ2J/YFm6Uo7WXIA5aXvhW0LZl5do9960aK4ToOLDM+xywoW?=
 =?iso-8859-1?Q?8Jox33Reoak0qfvZnMyfNrSI0aGNzA82mmKBqSZPCtejW4MWJ0j605JZVr?=
 =?iso-8859-1?Q?J+sbqExT8rX9SbhEhYpU72mqVVTetf4iP7WjrIR6XD8mImjwl/s9duuQUH?=
 =?iso-8859-1?Q?0skkT3BhZKnqE5Hq/CkADAXCY70xvpRJAJpFjBOPomTFxjpUMhyXKk5ch4?=
 =?iso-8859-1?Q?rjyULap8Ux29zMbSp1ErVDUIgre83pWbfKPLMCo612i/jlZa4qFfthI3Bi?=
 =?iso-8859-1?Q?NKGWnEPyRGoUWUOHSl7gujQUNbywY2vfFXf1boSzlYqvZDRTMe3WnVvEWu?=
 =?iso-8859-1?Q?6g4ydKDzUS3AQ6vynX7bxAHIZzVdOgjNzEPGxA/4yhBXhuqxuyLry8GJRl?=
 =?iso-8859-1?Q?Fn0Ng0b+C0YXv6bsW9Yq85N/YbKCWokKukosc9rC8BO3KV/j/dVlQKzTcB?=
 =?iso-8859-1?Q?89HlogMQwf50qgUH9PHn2wO2QlHxa1wT4uikTRScMlU5l5zpyB6b2sHY7r?=
 =?iso-8859-1?Q?Ny+jPmIPQxiM5gjitMxxI2nuaaL1RkhaloLieKdoOd8pf3bjpxcoYWFELM?=
 =?iso-8859-1?Q?Lx1lqD4KFCKIP74Sxi5iDNcZDZUUVa/OeC030+DyxKszu/EBw4PIrbPhZ3?=
 =?iso-8859-1?Q?3VMb4El/FBY9gFHfYM17ZdixuM5TPW8muJYso1SQMUp44ekNlA02XzXvK6?=
 =?iso-8859-1?Q?5fX+3kNbAeS/fpQIsW6f2EVd3SKxYYBAb2lCfCJvgp87ABQQ2QyUi8slkJ?=
 =?iso-8859-1?Q?AHLY0qWQxLBq00Diq8Ul41S5q1vkiBnjijrX0AxXZENNQsp1kHIMC/AlvY?=
 =?iso-8859-1?Q?M38ubXMmYAZTX1r/WPuJGx11RDFQIPvAV7kdJohK6KL2bhCY29i1CG4lBc?=
 =?iso-8859-1?Q?C19oKrKtvE4VGQFjfY/ojqdW9Ze0cmYd/KY2opqVpUCwPSjwXEyFZZVtdJ?=
 =?iso-8859-1?Q?vWRlIC4pOnMHsYHvr7r1Bb62Xi53caU48PzPQh4mBpvRVT6Q7o10qSZbMb?=
 =?iso-8859-1?Q?NEr9HKAaYODd1YHZBbc0dBL6xqLs7IfJe0mT9Vb+iznlwbzGVhrALYd4tz?=
 =?iso-8859-1?Q?K+N68O5Z6klGugK2PKCu3juHeI7GAFU9ZGerTc1YQgFJ+YlVept8zaLULr?=
 =?iso-8859-1?Q?bVATpAjcOZcddmjB7BywSYMNrjbqUEcs66Nrl0z9x1jR4tKdNWZOz9tORr?=
 =?iso-8859-1?Q?+k1SMc3iIxM4MjZ5m98teKcwBNi+/dIfToVdNqR/BnBcGMLC87BZyZsrm4?=
 =?iso-8859-1?Q?tDiaEy32okCegJPhndvjDVr0JR+rkEjHrMcSXQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6j14SpfK3SjQLrP5M3eMPZtzI9ea3SgBG4tqC8TR+pvoxudfbZCmdbbChE?=
 =?iso-8859-1?Q?tZbcCe60lVp6nlC5QBMvtasCk7hZftKH2afjme/I+45yYYQo+d7EH7LjQv?=
 =?iso-8859-1?Q?kDwceV3q5/EalXQZbtSVgkHTDRmnnSvSzeSPnvBPLiNeMAyXEvTeYy5FZC?=
 =?iso-8859-1?Q?HJUqGZvCuQG7nLR/zWwwXttDZEas2KpbnfOtthwywUS91YYYoylgv5ffdI?=
 =?iso-8859-1?Q?fcjXvP5AQn7s+t4cGIopqS2FDut09i9NtXKYH2Ikt4J074kxYtflHLrrnP?=
 =?iso-8859-1?Q?y5aWSYi9hAfgPPSCxBAKrpnG+trG8ogGF1i8juOOcKJudWUWuutqe98IFy?=
 =?iso-8859-1?Q?Fj7syTo12YTwjfLyEaDINq1jXpDvCjdIzd6FOmFj9UJPWvUqyTw/xVtNiu?=
 =?iso-8859-1?Q?d7z49+x0JUxHWzhoLKNOrmEQQDHIvEV0V11yq+e26XBUYrIDBQgvmDJOJv?=
 =?iso-8859-1?Q?bTMZ+8+VeOnVEk3vriWzbVrE64em1V+6RQTLhsk/8uzKP94Uz6HzqQvwIE?=
 =?iso-8859-1?Q?cgIbRwk+wRXBcjaaxHZem1yrFAlPhORqaaklKZ/qBevbigfXpuwYeWV0SG?=
 =?iso-8859-1?Q?gcFjzLIIn6e4M7eqwTbnYSBTo+VuBNFHiLivlfI218pe3rviwvnFOEGSuP?=
 =?iso-8859-1?Q?9yBYt95X+X10zPR1Iv6Hknl7+7y/X0W0b/Sf/Guk9pVmt6JISE6CJZtcTM?=
 =?iso-8859-1?Q?LzmZeQAHWXg5WQUAIGuGTUTKFZd5sjxuFhG1ZpD9HgdCEN3SATiuMRjecT?=
 =?iso-8859-1?Q?/y7n7UiwsdfgQEc60IlFj/xMOd0hwTXuL+GBZMjWq3hMDeobyemKtlUuqU?=
 =?iso-8859-1?Q?TDXP7kYGdGs4H11rp6jPwtfc+pBWo9sytEsoAHXGVCftYm8rjzwu5NzB50?=
 =?iso-8859-1?Q?5cYdXBOVMSGyCJvacm78gn1Jx5ldxMkZ25Pd4ePeMjqKqvmKfO++hKR6x2?=
 =?iso-8859-1?Q?lh4nj+DxcZv4MLFL2owaPG8DuyoFidFhNDmGcPKH7xLrtAMUQHo8ev9H01?=
 =?iso-8859-1?Q?TaYtvUWOK8Dc8APE2ieltIsdwBUhUM1jTEs29YG98/vTKKr9Q1rChffvvL?=
 =?iso-8859-1?Q?OOZxLMB+fLmebp95HK/u9Lmo2aRs49U8ezt0/jA515Fi4hHKM6HugBLbjn?=
 =?iso-8859-1?Q?luGyiYlVBtzOzYtAvteViWMg8z0B7+4pCXf0dr9+URuURCsXjGKRpA8xW4?=
 =?iso-8859-1?Q?KiQheHQ+MmdGzrbDPpKEGuU2yVZiSjBD71OCoJ24qBBXDK0wRcl+674v0V?=
 =?iso-8859-1?Q?+4mLH2aNHnlhzzVJem5/SIW0yIRl6aBwX0qeMoxh8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2426a610-aeaa-4ddf-bc38-08dda0e7bb62
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 08:38:49.7593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6304

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
     - Add ability to set a default between curl and openssl using the conf=
ig
v6:  - Fix minor mistakes in --folder documentation
v7:  - Fix spelling and grammar mistakes in logs shown to the user when run=
ning imap-send
     - Display port alongwith host when git credential is invoked and asks =
for a password
     - Display the destination mailbox when sending a message
v8:  - Drop the patch that enabled user to choose between libcurl and opens=
sl using the config
     - Add ability to list the available folders by adding a `--list` optio=
n
v9:  - Encourage users to use OAuth2.0 for Gmail (similar change done for s=
end-email docs).
v10: - Fix comment styles
     - Fix failing tests
v11: - Use lower case letters for the first word of a sendtence in an error=
 message
       and avoid using full stops at the end of a sentence.

Aditya Garg (9):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: fix memory leak in case auth_cram_md5 fails
  imap-send: enable specifying the folder using the command line
  imap-send: fix minor mistakes in the logs
  imap-send: display port alongwith host when git credential is invoked
  imap-send: display the destination mailbox when sending a message
  imap-send: add ability to list the available folders

 Documentation/config/imap.adoc   |  10 +-
 Documentation/git-imap-send.adoc |  68 +++++-
 imap-send.c                      | 407 +++++++++++++++++++++++++++----
 3 files changed, 429 insertions(+), 56 deletions(-)

Range-diff against v10:
 -:  ---------- >  1:  3e3ddf7077 imap-send: fix bug causing cfg->folder be=
ing set to NULL
 1:  991f978c22 !  2:  02037873a1 imap-send: fix numerous spelling and gram=
mar mistakes in logs
    @@ Metadata
     Author: Aditya Garg <gargaditya08@live.com>
    =20
      ## Commit message ##
    -    imap-send: fix numerous spelling and grammar mistakes in logs
    +    imap-send: add support for OAuth2.0 authentication
    =20
    -    A lot of spelling and grammar mistakes were found in the logs show=
n to
    -    the user while using imap-send. Most of them are lack of a full st=
op at
    -    the end of a sentence and first word of a sentence not being capit=
alized.
    +    OAuth2.0 is a new way of authentication supported by various email=
 providers
    +    these days. OAUTHBEARER and XOAUTH2 are the two most common mechan=
isms used
    +    for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2=
], whereas
    +    XOAUTH2 is Google's proprietary mechanism (See [3]).
    +
    +    [1]: https://datatracker.ietf.org/doc/html/rfc5801
    +    [2]: https://datatracker.ietf.org/doc/html/rfc7628
    +    [3]: https://developers.google.com/workspace/gmail/imap/xoauth2-pr=
otocol#initial_client_response
    =20
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
    =20
    + ## Documentation/config/imap.adoc ##
    +@@ Documentation/config/imap.adoc: imap.authMethod::
    + 	Specify the authentication method for authenticating with the IMAP s=
erver.
    + 	If Git was built with the NO_CURL option, or if your curl version is=
 older
    + 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
    +-	option, the only supported method is 'CRAM-MD5'. If this is not set
    +-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
    ++	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
    ++	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IM=
AP
    ++	plaintext LOGIN command.
    +
    + ## Documentation/git-imap-send.adoc ##
    +@@ Documentation/git-imap-send.adoc: Using Gmail's IMAP interface:
    +=20
    + ---------
    + [imap]
    +-	folder =3D "[Gmail]/Drafts"
    +-	host =3D imaps://imap.gmail.com
    +-	user =3D user@gmail.com
    +-	port =3D 993
    ++    folder =3D "[Gmail]/Drafts"
    ++    host =3D imaps://imap.gmail.com
    ++    user =3D user@gmail.com
    ++    port =3D 993
    + ---------
    +=20
    ++Gmail does not allow using your regular password for `git imap-send`.
    ++If you have multi-factor authentication set up on your Gmail account,=
 you can generate
    ++an app-specific password for use with `git imap-send`.
    ++Visit https://security.google.com/settings/security/apppasswords to c=
reate it.
    ++Alternatively, use OAuth2.0 authentication as described below.
    ++
    + [NOTE]
    + You might need to instead use: `folder =3D "[Google Mail]/Drafts"` if=
 you get an error
    + that the "Folder doesn't exist".
    +@@ Documentation/git-imap-send.adoc: that the "Folder doesn't exist".
    + If your Gmail account is set to another language than English, the na=
me of the "Drafts"
    + folder will be localized.
    +=20
    ++If you want to use OAuth2.0 based authentication, you can specify `OA=
UTHBEARER`
    ++or `XOAUTH2` mechanism in your config. It is more secure than using a=
pp-specific
    ++passwords, and also does not enforce the need of having multi-factor =
authentication.
    ++You will have to use an OAuth2.0 access token in place of your passwo=
rd when using this
    ++authentication.
    ++
    ++---------
    ++[imap]
    ++    folder =3D "[Gmail]/Drafts"
    ++    host =3D imaps://imap.gmail.com
    ++    user =3D user@gmail.com
    ++    port =3D 993
    ++    authmethod =3D OAUTHBEARER
    ++---------
    ++
    ++Using Outlook's IMAP interface:
    ++
    ++Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Al=
so, it
    ++supports only `XOAUTH2` as the mechanism.
    ++
    ++---------
    ++[imap]
    ++    folder =3D "Drafts"
    ++    host =3D imaps://outlook.office365.com
    ++    user =3D user@outlook.com
    ++    port =3D 993
    ++    authmethod =3D XOAUTH2
    ++---------
    ++
    + Once the commits are ready to be sent, run the following command:
    +=20
    +   $ git format-patch --cover-letter -M --stdout origin/master | git i=
map-send
    +@@ Documentation/git-imap-send.adoc: Just make sure to disable line wr=
apping in the email client (Gmail's web
    + interface will wrap lines no matter what, so you need to use a real
    + IMAP client).
    +=20
    ++In case you are using OAuth2.0 authentication, it is easier to use cr=
edential
    ++helpers to generate tokens. Credential helpers suggested in
    ++linkgit:git-send-email[1] can be used for `git imap-send` as well.
    ++
    + CAUTION
    + -------
    + It is still your responsibility to make sure that the email message
    +
      ## imap-send.c ##
    -@@ imap-send.c: static int ssl_socket_connect(struct imap_socket *sock=
 UNUSED,
    - 			      const struct imap_server_conf *cfg UNUSED,
    - 			      int use_tls_only UNUSED)
    - {
    --	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
    -+	fprintf(stderr, "SSL requested, but SSL support is not compiled in.\=
n");
    - 	return -1;
    - }
    +@@ imap-send.c: enum CAPABILITY {
    + 	LITERALPLUS,
    + 	NAMESPACE,
    + 	STARTTLS,
    +-	AUTH_CRAM_MD5
    ++	AUTH_CRAM_MD5,
    ++	AUTH_OAUTHBEARER,
    ++	AUTH_XOAUTH2
    + };
     =20
    -@@ imap-send.c: static int verify_hostname(X509 *cert, const char *hos=
tname)
    -=20
    - 	/* try the common name */
    - 	if (!(subj =3D X509_get_subject_name(cert)))
    --		return error("cannot get certificate subject");
    -+		return error("Cannot get certificate subject");
    - 	if ((len =3D X509_NAME_get_text_by_NID(subj, NID_commonName, cname, =
sizeof(cname))) < 0)
    --		return error("cannot get certificate common name");
    -+		return error("Cannot get certificate common name");
    - 	if (strlen(cname) =3D=3D (size_t)len && host_matches(hostname, cname=
))
    - 		return 0;
    - 	return error("certificate owner '%s' does not match hostname '%s'",
    -@@ imap-send.c: static char *cram(const char *challenge_64, const char=
 *user, const char *pass)
    - 	decoded_len =3D EVP_DecodeBlock((unsigned char *)challenge,
    - 				      (unsigned char *)challenge_64, encoded_len);
    - 	if (decoded_len < 0)
    --		die("invalid challenge %s", challenge_64);
    -+		die("Invalid challenge %s", challenge_64);
    - 	if (!HMAC(EVP_md5(), pass, strlen(pass), (unsigned char *)challenge,=
 decoded_len, hash, NULL))
    - 		die("HMAC error");
    + static const char *cap_list[] =3D {
    +@@ imap-send.c: static const char *cap_list[] =3D {
    + 	"NAMESPACE",
    + 	"STARTTLS",
    + 	"AUTH=3DCRAM-MD5",
    ++	"AUTH=3DOAUTHBEARER",
    ++	"AUTH=3DXOAUTH2",
    + };
     =20
    -@@ imap-send.c: static int auth_cram_md5(struct imap_store *ctx, const=
 char *prompt)
    - 	ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(response=
));
    - 	if (ret !=3D strlen(response)) {
    - 		free(response);
    --		return error("IMAP error: sending response failed");
    -+		return error("IMAP error: sending CRAM-MD5 response failed");
    - 	}
    + #define RESP_OK    0
    +@@ imap-send.c: static char *cram(const char *challenge_64, const char=
 *user, const char *pass)
    + 	return (char *)response_64;
    + }
     =20
    - 	free(response);
    -@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_=
server_conf *srvc, const c
    - 		tunnel.in =3D -1;
    - 		tunnel.out =3D -1;
    - 		if (start_command(&tunnel))
    --			die("cannot start proxy %s", srvc->tunnel);
    -+			die("Cannot start proxy %s", srvc->tunnel);
    -=20
    - 		imap->buf.sock.fd[0] =3D tunnel.out;
    - 		imap->buf.sock.fd[1] =3D tunnel.in;
    -=20
    --		imap_info("ok\n");
    -+		imap_info("OK\n");
    - 	} else {
    - #ifndef NO_IPV6
    - 		struct addrinfo hints, *ai0, *ai;
    -@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_=
server_conf *srvc, const c
    - 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
    - 			goto bail;
    - 		}
    --		imap_info("ok\n");
    -+		imap_info("OK\n");
    -=20
    - 		for (ai0 =3D ai; ai; ai =3D ai->ai_next) {
    - 			char addr[NI_MAXHOST];
    -@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_=
server_conf *srvc, const c
    - 			perror("gethostbyname");
    - 			goto bail;
    - 		}
    --		imap_info("ok\n");
    -+		imap_info("OK\n");
    ++static char *oauthbearer_base64(const char *user, const char *access_=
token)
    ++{
    ++	int raw_len, b64_len;
    ++	char *raw, *b64;
    ++
    ++	/*
    ++	 * Compose the OAUTHBEARER string
    ++	 *
    ++	 * "n,a=3D" {User} ",^Ahost=3D" {Host} "^Aport=3D" {Port} "^Aauth=3D=
Bearer " {Access Token} "^A^A
    ++	 *
    ++	 * The first part `n,a=3D" {User} ",` is the gs2 header described in=
 RFC5801.
    ++	 * * gs2-cb-flag `n` -> client does not support CB
    ++	 * * gs2-authzid `a=3D" {User} "`
    ++	 *
    ++	 * The second part are key value pairs containing host, port and aut=
h as
    ++	 * described in RFC7628.
    ++	 *
    ++	 * https://datatracker.ietf.org/doc/html/rfc5801
    ++	 * https://datatracker.ietf.org/doc/html/rfc7628
    ++	 */
    ++	raw_len =3D strlen(user) + strlen(access_token) + 20;
    ++	raw =3D xmallocz(raw_len + 1);
    ++	snprintf(raw, raw_len + 1, "n,a=3D%s,\001auth=3DBearer %s\001\001", =
user, access_token);
    ++
    ++	/* Base64 encode */
    ++	b64 =3D xmallocz(ENCODED_SIZE(strlen(raw)));
    ++	b64_len =3D EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)r=
aw, strlen(raw));
    ++	free(raw);
    ++
    ++	if (b64_len < 0) {
    ++		free(b64);
    ++		return NULL;
    ++	}
    ++	return b64;
    ++}
    ++
    ++static char *xoauth2_base64(const char *user, const char *access_toke=
n)
    ++{
    ++	int raw_len, b64_len;
    ++	char *raw, *b64;
    ++
    ++	/*
    ++	 * Compose the XOAUTH2 string
    ++	 * "user=3D" {User} "^Aauth=3DBearer " {Access Token} "^A^A"
    ++	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protoc=
ol#initial_client_response
    ++	 */
    ++	raw_len =3D strlen(user) + strlen(access_token) + 20;
    ++	raw =3D xmallocz(raw_len + 1);
    ++	snprintf(raw, raw_len + 1, "user=3D%s\001auth=3DBearer %s\001\001", =
user, access_token);
    ++
    ++	/* Base64 encode */
    ++	b64 =3D xmallocz(ENCODED_SIZE(strlen(raw)));
    ++	b64_len =3D EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)r=
aw, strlen(raw));
    ++	free(raw);
    ++
    ++	if (b64_len < 0) {
    ++		free(b64);
    ++		return NULL;
    ++	}
    ++	return b64;
    ++}
    ++
    + #else
     =20
    - 		addr.sin_addr.s_addr =3D *((int *) he->h_addr_list[0]);
    + static char *cram(const char *challenge_64 UNUSED,
    +@@ imap-send.c: static char *cram(const char *challenge_64 UNUSED,
    + 	    "you have to build git-imap-send with OpenSSL library.");
    + }
     =20
    -@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_=
server_conf *srvc, const c
    - 		}
    ++static char *oauthbearer_base64(const char *user UNUSED,
    ++		  const char *access_token UNUSED)
    ++{
    ++	die("You are trying to use OAUTHBEARER authenticate method "
    ++	    "with OpenSSL library, but its support has not been compiled in.=
");
    ++}
    ++
    ++static char *xoauth2_base64(const char *user UNUSED,
    ++		  const char *access_token UNUSED)
    ++{
    ++	die("You are trying to use XOAUTH2 authenticate method "
    ++	    "with OpenSSL library, but its support has not been compiled in.=
");
    ++}
    ++
      #endif
    - 		if (s < 0) {
    --			fputs("Error: unable to connect to server.\n", stderr);
    -+			fputs("Error: unable to connect to server\n", stderr);
    - 			goto bail;
    - 		}
     =20
    -@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_=
server_conf *srvc, const c
    - 			close(s);
    - 			goto bail;
    - 		}
    --		imap_info("ok\n");
    -+		imap_info("OK\n");
    - 	}
    + static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    +@@ imap-send.c: static int auth_cram_md5(struct imap_store *ctx, const=
 char *prompt)
    + 	return 0;
    + }
     =20
    - 	/* read the greeting string */
    ++static int auth_oauthbearer(struct imap_store *ctx, const char *promp=
t UNUSED)
    ++{
    ++	int ret;
    ++	char *b64;
    ++
    ++	b64 =3D oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
    ++	if (!b64)
    ++		return error("OAUTHBEARER: base64 encoding failed");
    ++
    ++	/* Send the base64-encoded response */
    ++	ret =3D socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
    ++	if (ret !=3D (int)strlen(b64)) {
    ++		free(b64);
    ++		return error("IMAP error: sending OAUTHBEARER response failed");
    ++	}
    ++
    ++	free(b64);
    ++	return 0;
    ++}
    ++
    ++static int auth_xoauth2(struct imap_store *ctx, const char *prompt UN=
USED)
    ++{
    ++	int ret;
    ++	char *b64;
    ++
    ++	b64 =3D xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
    ++	if (!b64)
    ++		return error("XOAUTH2: base64 encoding failed");
    ++
    ++	/* Send the base64-encoded response */
    ++	ret =3D socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
    ++	if (ret !=3D (int)strlen(b64)) {
    ++		free(b64);
    ++		return error("IMAP error: sending XOAUTH2 response failed");
    ++	}
    ++
    ++	free(b64);
    ++	return 0;
    ++}
    ++
    + static void server_fill_credential(struct imap_server_conf *srvc, str=
uct credential *cred)
    + {
    + 	if (srvc->user && srvc->pass)
     @@ imap-send.c: static struct imap_store *imap_open_store(struct imap_=
server_conf *srvc, const c
    - 			}
    - 		} else {
    - 			if (CAP(NOLOGIN)) {
    --				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
    -+				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN.\n"=
,
    - 					srvc->user, srvc->host);
    + 					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
    + 					goto bail;
    + 				}
    ++			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
    ++				if (!CAP(AUTH_OAUTHBEARER)) {
    ++					fprintf(stderr, "You specified "
    ++						"OAUTHBEARER as authentication method, "
    ++						"but %s doesn't support it.\n", srvc->host);
    ++					goto bail;
    ++				}
    ++				/* OAUTHBEARER */
    ++
    ++				memset(&cb, 0, sizeof(cb));
    ++				cb.cont =3D auth_oauthbearer;
    ++				if (imap_exec(ctx, &cb, "AUTHENTICATE OAUTHBEARER") !=3D RESP_OK)=
 {
    ++					fprintf(stderr, "IMAP error: AUTHENTICATE OAUTHBEARER failed\n")=
;
    ++					goto bail;
    ++				}
    ++			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
    ++				if (!CAP(AUTH_XOAUTH2)) {
    ++					fprintf(stderr, "You specified "
    ++						"XOAUTH2 as authentication method, "
    ++						"but %s doesn't support it.\n", srvc->host);
    ++					goto bail;
    ++				}
    ++				/* XOAUTH2 */
    ++
    ++				memset(&cb, 0, sizeof(cb));
    ++				cb.cont =3D auth_xoauth2;
    ++				if (imap_exec(ctx, &cb, "AUTHENTICATE XOAUTH2") !=3D RESP_OK) {
    ++					fprintf(stderr, "IMAP error: AUTHENTICATE XOAUTH2 failed\n");
    ++					goto bail;
    ++				}
    + 			} else {
    + 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host)=
;
      				goto bail;
    - 			}
    - 			if (!imap->buf.sock.ssl)
    - 				imap_warn("*** IMAP Warning *** Password is being "
    --					  "sent in the clear\n");
    -+					  "sent in the clear.\n");
    - 			if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->=
pass) !=3D RESP_OK) {
    - 				fprintf(stderr, "IMAP error: LOGIN failed\n");
    - 				goto bail;
    -@@ imap-send.c: static int append_msgs_to_imap(struct imap_server_conf=
 *server,
    -=20
    - 	ctx =3D imap_open_store(server, server->folder);
    - 	if (!ctx) {
    --		fprintf(stderr, "failed to open store\n");
    -+		fprintf(stderr, "Failed to open store.\n");
    - 		return 1;
    - 	}
    - 	ctx->name =3D server->folder;
    -=20
    --	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s=
" : "");
    -+	fprintf(stderr, "Sending %d message%s\n", total, (total !=3D 1) ? "s=
" : "");
    - 	while (1) {
    - 		unsigned percent =3D n * 100 / total;
    -=20
     @@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc,=
 struct credential *cred)
     =20
    - 	uri_encoded_folder =3D curl_easy_escape(curl, srvc->folder, 0);
    - 	if (!uri_encoded_folder)
    --		die("failed to encode server folder");
    -+		die("Failed to encode server folder.");
    - 	strbuf_addstr(&path, uri_encoded_folder);
    - 	curl_free(uri_encoded_folder);
    -=20
    -@@ imap-send.c: static int curl_append_msgs_to_imap(struct imap_server=
_conf *server,
    - 	curl =3D setup_curl(server, &cred);
    - 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
    -=20
    --	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s=
" : "");
    -+	fprintf(stderr, "Sending %d message%s\n", total, (total !=3D 1) ? "s=
" : "");
    - 	while (1) {
    - 		unsigned percent =3D n * 100 / total;
    - 		int prev_len;
    -@@ imap-send.c: int cmd_main(int argc, const char **argv)
    - 		server.port =3D server.use_ssl ? 993 : 143;
    -=20
    - 	if (!server.folder) {
    --		fprintf(stderr, "no imap store specified\n");
    -+		fprintf(stderr, "No IMAP store specified.\n");
    - 		ret =3D 1;
    - 		goto out;
    - 	}
    - 	if (!server.host) {
    - 		if (!server.tunnel) {
    --			fprintf(stderr, "no imap host specified\n");
    -+			fprintf(stderr, "No IMAP host specified.\n");
    - 			ret =3D 1;
    - 			goto out;
    - 		}
    -@@ imap-send.c: int cmd_main(int argc, const char **argv)
    -=20
    - 	/* read the messages */
    - 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
    --		error_errno(_("could not read from stdin"));
    -+		error_errno(_("Could not read from stdin."));
    - 		ret =3D 1;
    - 		goto out;
    - 	}
    + 	server_fill_credential(srvc, cred);
    + 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
    +-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
    ++
    ++	if (!srvc->auth_method ||
    ++	    strcmp(srvc->auth_method, "XOAUTH2") ||
    ++	    strcmp(srvc->auth_method, "OAUTHBEARER"))
    ++		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
     =20
    - 	if (all_msgs.len =3D=3D 0) {
    --		fprintf(stderr, "nothing to send\n");
    -+		fprintf(stderr, "Nothing to send.\n");
    - 		ret =3D 1;
    - 		goto out;
    - 	}
    + 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
    + 	strbuf_addstr(&path, srvc->host);
    +@@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc,=
 struct credential *cred)
    + 	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
     =20
    - 	total =3D count_messages(&all_msgs);
    - 	if (!total) {
    --		fprintf(stderr, "no messages to send\n");
    -+		fprintf(stderr, "No messages found to send.\n");
    - 		ret =3D 1;
    - 		goto out;
    + 	if (srvc->auth_method) {
    +-		struct strbuf auth =3D STRBUF_INIT;
    +-		strbuf_addstr(&auth, "AUTH=3D");
    +-		strbuf_addstr(&auth, srvc->auth_method);
    +-		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
    +-		strbuf_release(&auth);
    ++		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
    ++		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
    ++
    ++			/*
    ++			 * While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUT=
H2,
    ++			 * upon debugging, it has been found that it is capable of detecti=
ng
    ++			 * the best option out of OAUTHBEARER and XOAUTH2.
    ++			 */
    ++			curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, srvc->pass);
    ++		} else {
    ++			struct strbuf auth =3D STRBUF_INIT;
    ++			strbuf_addstr(&auth, "AUTH=3D");
    ++			strbuf_addstr(&auth, srvc->auth_method);
    ++			curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
    ++			strbuf_release(&auth);
    ++		}
      	}
    -
    - ## t/t1517-outside-repo.sh ##
    -@@ t/t1517-outside-repo.sh: test_expect_success 'imap-send outside rep=
ository' '
    - 	test_config_global imap.host imaps://localhost &&
    - 	test_config_global imap.folder Drafts &&
    -=20
    --	echo nothing to send >expect &&
    -+	echo Nothing to send. >expect &&
    - 	test_must_fail git imap-send -v </dev/null 2>actual &&
    - 	test_cmp expect actual &&
     =20
    + 	if (!srvc->use_ssl)
 -:  ---------- >  3:  3a0be43838 imap-send: add PLAIN authentication metho=
d to OpenSSL
 -:  ---------- >  4:  45f5b3f1ff imap-send: fix memory leak in case auth_c=
ram_md5 fails
 -:  ---------- >  5:  8899f686d7 imap-send: enable specifying the folder u=
sing the command line
 -:  ---------- >  6:  c2dfd0178c imap-send: fix minor mistakes in the logs
 2:  e436a12198 =3D  7:  4e1b51acd5 imap-send: display port alongwith host =
when git credential is invoked
 3:  5183253004 =3D  8:  85c40d8491 imap-send: display the destination mail=
box when sending a message
 4:  c33469a5db !  9:  5e24c6cde8 imap-send: add ability to list the availa=
ble folders
    @@ imap-send.c: static int append_msgs_to_imap(struct imap_server_conf =
*server,
     +{
     +	struct imap_store *ctx =3D imap_open_store(server, "INBOX");
     +	if (!ctx) {
    -+		fprintf(stderr, "Failed to connect to IMAP server.\n");
    ++		fprintf(stderr, "failed to connect to IMAP server\n");
     +		return 1;
     +	}
     +
     +	fprintf(stderr, "Fetching the list of available folders...\n");
     +	/* Issue the LIST command and print the results */
     +	if (imap_exec(ctx, NULL, "LIST \"\" \"*\"") !=3D RESP_OK) {
    -+		fprintf(stderr, "Failed to list folders.\n");
    ++		fprintf(stderr, "failed to list folders\n");
     +		imap_close_store(ctx);
     +		return 1;
     +	}
    @@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, =
struct crede
     =20
     -	uri_encoded_folder =3D curl_easy_escape(curl, srvc->folder, 0);
     -	if (!uri_encoded_folder)
    --		die("Failed to encode server folder.");
    +-		die("failed to encode server folder");
     -	strbuf_addstr(&path, uri_encoded_folder);
     -	curl_free(uri_encoded_folder);
     +	if (!list_folders) {
     +		uri_encoded_folder =3D curl_easy_escape(curl, srvc->folder, 0);
     +		if (!uri_encoded_folder)
    -+			die("Failed to encode server folder.");
    ++			die("failed to encode server folder");
     +		strbuf_addstr(&path, uri_encoded_folder);
     +		curl_free(uri_encoded_folder);
     +	}
    @@ imap-send.c: int cmd_main(int argc, const char **argv)
      		server.port =3D server.use_ssl ? 993 : 143;
     =20
     -	if (!server.folder) {
    --		fprintf(stderr, "No IMAP store specified.\n");
    +-		fprintf(stderr, "no IMAP store specified\n");
     -		ret =3D 1;
     -		goto out;
     -	}
      	if (!server.host) {
      		if (!server.tunnel) {
    - 			fprintf(stderr, "No IMAP host specified.\n");
    + 			fprintf(stderr, "no IMAP host specified\n");
     @@ imap-send.c: int cmd_main(int argc, const char **argv)
      		server.host =3D xstrdup("tunnel");
      	}
    @@ imap-send.c: int cmd_main(int argc, const char **argv)
     +	}
     +
     +	if (!server.folder) {
    -+		fprintf(stderr, "No IMAP store specified.\n");
    ++		fprintf(stderr, "no IMAP store specified\n");
     +		ret =3D 1;
     +		goto out;
     +	}
     +
      	/* read the messages */
      	if (strbuf_read(&all_msgs, 0, 0) < 0) {
    - 		error_errno(_("Could not read from stdin."));
    + 		error_errno(_("could not read from stdin"));
--=20
2.49.0.638.g5e24c6cde8

