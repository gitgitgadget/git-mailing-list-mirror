Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13C1148850
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620209; cv=fail; b=qONZJq+DDHyW28y4iYk65zuMRAb1BVt6z9XUcGWl6+F33KAXD8a4Qk66HgVxJkRuNvx1nXG1P/Hk1Gu9lCupMAI+v6ISpLoNLznFK/VDrWovriA/PM1/UwqS18aWwcR27vD7xA/7uVq24T5zhTpkhtn4wqdyXx33efOlRSXaFXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620209; c=relaxed/simple;
	bh=MZZ5IFF0wPZLZZb2ZWwSbpZssVBS0RanmFWO87KO0s0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rtqOUO5l8rTlUYBUwEuCNkrWwUwgnNJtDxQzSQi9jk4+uQSFu0HInl869H0sbuZR1TSdiuqqiPoS7Ixn1MohEQ+cZtvPAUU/2uWh/5fzLpSdTxGQyCfaAP3IncveiVLG3QfI4WffUyG4vRWSZp6wDpDZKhwhGArXdiAl8WS+ZFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=NfTWXfPU; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="NfTWXfPU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2ubkYEF+0tnPhxogmy4owQ+GK8MzJXt2hOOWHpBGiis1cds+ezFqkoxuHT9M5OWLJrZ7l5szjIaSKlEgQpO8pdLY7AhOYrDMjEe7qMaetDFlqIHO/RUTX6y+Kr1Akxmw76m7ZXjAUP0uSvOhEOaF759F2z0tqL0dgXDy7/GDQwZEKKuB5H+3jecGD+G3z+V3Mz0ddOv2G+t8JHOEvociU4rwhWkJgdMzoIe9/zDku8JuagwruE/Uxsqeje+FL0XY3iMBcBp27wotq6jArcRMLFH1h6TRwOmxdOyXVaLt/8Usxewb1AkshhpMfiqAIcJ9oV7Exa5tMB4sJBkYORyVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yxi0H2V9S72e1UDBbhrVAOT3N2MvP6eo+oy4a1M6M0=;
 b=qMdjXNBGl5W1QDRNjmpss/4WYOLoFkxU4sJ/cmMq9bs/GDW3UfCDxCPNk5w1YXU5vT7L7oueRavSdM/NkaZ6DCTEl7vAtW/dAQwFoQz28YIRKanbaDF+PJ4MRvvva/bASABkExRD74J7s+oQwPH9rgSwd+fqDy0PYVt12zM2hsRc3XAXiEULyGrbmz9ipEcwOt+m7UnjHR9Mrq2MYG7/bpxVwvtimSGBE48g4NMbv5cWCVky5z8cJw9HaF/qBn9tX8s3zV+EGRT/R8so1Jma5Rn0T1u4y9X/3Nt2czvIkJCLlSa+lhDK5WganBrxrozh5W3CIWns1LNQGSxaNS0eBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yxi0H2V9S72e1UDBbhrVAOT3N2MvP6eo+oy4a1M6M0=;
 b=NfTWXfPUmWM9vg0jI7JRQI9QFHSEHCsLSxdAhSaqjQxhfP52pc0ga+Pek9FeDJoDJkpt2NB19csVLsS9EQemwi4i9LK1DxroVrbSfInDLEGhBlg9M/5f2rB3eqWOgslwRaXSBpBMYBh6/bB28eRz3KQxkrJ3jaDGVpe2AiARDZKdTJRz8ji1tOdGfmsofaoDUdXmssu/CjbIDf4+Vg+ZXlgTwZHTw4wr3z5AT33QUEeJi8BGjYUlF9gy1l3mD2JkNL5TVniK6RkvvXHozKIo34E/l9q9ORhJQ7CUDajfQ6l+f7lM3A3zOutCBwyaIFFC5P7k2IGatTHv2trZAK0sxQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 15:50:01 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 15:50:01 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>, Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 0/4] docs: add credential helper for yahoo and link
 Google's sendgmail tool
Thread-Topic: [PATCH v7 0/4] docs: add credential helper for yahoo and link
 Google's sendgmail tool
Thread-Index: AQHb0XqAiqgxth8SOkypAy7svruCpw==
Date: Fri, 30 May 2025 15:50:01 +0000
Message-ID: <20250530154934.10077-1-gargaditya08@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB6024:EE_
x-ms-office365-filtering-correlation-id: f64802a0-1198-4490-0ea8-08dd9f91a325
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd+Ewy2R3Pu64sHUJuYJdjG8fO8Z6swY+J8D7j78M7YcPOzMr38TU/zbuRa/s5DN/8Ty+E7CkIyk/wZOHuYSajaHKxLiE/pwgUMywY5mzuzIQvVcAW0AOQwgnmtlzTns2ntQyAB3TDClY4c4fVNzJ47Jr71jFqo0g7qYCKYraZKW/JX/g3X7VZyI2QkEJR5VMomkYLH4cl+0Cuz5Srzi3kXPpQa9hZqEsUxNLtt4aGQBRLrQIo5FP/CFENbpyNLroSs0SR8B+hT0LhTne80w96kTNVGQjjUsA6eLG8Eqs/o5lX5xSN/SI69oJgdVaVcLFZMPdsiHM1ZnibWf7/JConf/z9fiJLFtzqsT1+FcI3HHfzrY60PlFlnd+7DpDwtymLTh4EKgbyGZMQIBDA6h9VSXB1PVPtP7VAeKuPaLF30ULAOlCcx7QRKeWd/5TmVyONK9381KIC6OvsAzkjV+KyyJEPOZfHZXDsm+DthexMlvP4HVZx4WfMhT5aY7lDLyPWe5CSb7fVV/7aqtUUhWMubpNM8R82ITon1qtES6PWt0+SJ4z6AClvwhPu294X3RsFZHHXQQSr1dDvIcaB1ZEjMU1XBni7+4HBzs7hutYDCcBQ54BewGui9g4gyC6rfVgq63cLawNzYsB30iYp9LXlW2lnFDl5Ra9jkTdElV23tlkv6apz1Gbz7UZfOFHiKQbZIjrnM9XYC3XMLkBj40EVw17EOQnYoscEHbSN9JVBSrzEvPhZTfmT0+ZimAwExqRsxOaAxAThkIGoPNxu5a2A43yKgCL85spMie43+904tHrw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|7092599006|19110799006|8060799009|41001999006|8062599006|15080799009|12121999007|3412199025|440099028|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?gzrE2srLDFYagnhvStHc4/WX63Si0yRj2FgzMeHG8L6ZYxYAZ5lvOulSjd?=
 =?iso-8859-1?Q?ol6SOaCfgF6jfnSQVVjPlHv/jmxYF7XPWU88YzmbG0q+it2YtmFvxljHUr?=
 =?iso-8859-1?Q?POZDZhGktKfKSnea+yaqZA/9pEM88sUcVhgafurXfkhDcszz06jSjKbz3x?=
 =?iso-8859-1?Q?2Bzro7rWF61DVTw++qMls+N0r5ViL7/kt+TDGPtoZCbQs2pyiQ7cFyZQGo?=
 =?iso-8859-1?Q?fIQm37u6aUOT/vi4lN+/O2UBee90Ck0sMA0/z5C9/VpZxxMsA15irkNKRc?=
 =?iso-8859-1?Q?a4tYzdVbq783ge3cuBLvEwnN6qE+Tksgg8/TgrvW38cD1lWdgf+SON0DNd?=
 =?iso-8859-1?Q?I19pMp47q91+8uhS5ikj4R7zWFN12IF+wc02iIKIU7QPUzJLYgrZN5ags8?=
 =?iso-8859-1?Q?0aYhXZUaeiSyQQ5zZTnlmp69CSXAWv+2vvKczoSuseCCV44Vyyyh4DHIAJ?=
 =?iso-8859-1?Q?W5xFy42sVeYPfn91jN9Gce51ESlp8jfZ3BLbpajDfMN7+q54zXYO753P93?=
 =?iso-8859-1?Q?U9guwE9dF36VBrovzWUBKtTcFIBWK6JXcGbnfZPBGx1+ip4t8fs/91/68t?=
 =?iso-8859-1?Q?e3tahiBvfUJ2+Xva9gP8Y8tlurnWyLp34fAoV+zZlDRwgOyy4P0LkvhxN3?=
 =?iso-8859-1?Q?X+bn8yyZbOgmuALz+MAWc8wfRCHNc9vwGgNuv/EH2eU3M2UqeRoREBNE23?=
 =?iso-8859-1?Q?WxNxKWoIOOZZ4GOdD/hR0vSAmQDiu2xC8oI451yA1yA/VcNtEH08d6eipa?=
 =?iso-8859-1?Q?e9Ll5G2FhLK4rb8OxLBipmoi47pooTgwO/c+cIhT/m8CfPcsIRHc1wihfE?=
 =?iso-8859-1?Q?H4I/utc5BkLV0r438ZLcATTWwE/Su/MJwM/Dwr2vezBvmgQKbeQcHG8eXk?=
 =?iso-8859-1?Q?h+JiYEXog2a9u6tef876s9FTZDwXJwu2b478mEaxUZLxDl6mv4BLTwrFeQ?=
 =?iso-8859-1?Q?lc88UXTPgJubwJ9+MKM5eCVWr6/SjdZfzXnMs2O8sIfmkftMTiDgTNGDiP?=
 =?iso-8859-1?Q?pfsJIDbBhKEtzxHzxjiv/izI19jCo6FyKlb3XVlwCG5T64mryWj75xlz7J?=
 =?iso-8859-1?Q?h9BZDwMC56fAskDalsUBmo4J2ujA8RNM87bKybGD4kjqnQJ3hVPQGtEiPe?=
 =?iso-8859-1?Q?TAp9I3hvZallNyF+fHZ5eQFdyelZldrRoyX4O9coNEvhbp7R08Z72rjTtc?=
 =?iso-8859-1?Q?t604CVOLEj0CFpaFpyIQFTwKSdTFGAdrmOW/WTljKnIRNxH/SdcdFlE5vF?=
 =?iso-8859-1?Q?R6Oo3lt8DiyeP+CMqoZGgcQESSyux88JdWlDuTL73dphGsuoBfmxRgHgMs?=
 =?iso-8859-1?Q?mbfJ?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?zx1bp8A5yNXJMebnwKGSrnlVOP4KKmW4zr/rjrRAXo+iXlyt3/FhBCoDyK?=
 =?iso-8859-1?Q?abu1KwsS5r7MosIv3utxb/4W+xFCeoPoyVB1Wwx8r4mzfgF1hNnzT9xhCs?=
 =?iso-8859-1?Q?cxfupSPAbg83X4lNIQqWPRvCsrTVypxGh8c8pORX2KHoxr+9M6ZItP3iOx?=
 =?iso-8859-1?Q?LntMoMD29thnRX5yQ4b23U/RJwybWhpxK4hI+42M8Pbyds3S//VQqPAaZe?=
 =?iso-8859-1?Q?NnTAzXGAhy61gcUQ1Tag/t2Dvg4RZHseqXgQckTo9kfPFgRn4ISl1JcUMt?=
 =?iso-8859-1?Q?REVvw8C+tA8k7Y9AmUt405wAlpfulA1sJZpCotgg1L0Xxid8DK3djHHD9X?=
 =?iso-8859-1?Q?I08AGMLO+PiWYaDHhRnoEXcvG2HQTrFHMW+2o5yKUK8km9Q3zrq8ulC0zB?=
 =?iso-8859-1?Q?3MBzFzQSxX8Ql0eh8TqnK0cZsrlbpXpkF7xoBZ2MNUvTcJKL8ZVodTFFui?=
 =?iso-8859-1?Q?rPdjOsYC/6iIEvmvHNAsKwe8NGL/yLWSMZ3JhF3SBdxBzyXIpnVfb0gSub?=
 =?iso-8859-1?Q?vXk3EBVgMIJ8gPSlF27fldlGUWC0mKksNd2vmCXAAYAkQIjaDZVS8zeC1i?=
 =?iso-8859-1?Q?WYAML3GkfnVuxxBqDdWyHPaE5C184p3U2oMYe+7Hn7AuQQBTBxU772sa7T?=
 =?iso-8859-1?Q?dTaGx8GmxAfOQqzxkES7i4UgIip6GoIRSQC81b/NSQxAi4uQSumfoAOpF9?=
 =?iso-8859-1?Q?hLLQtarzhY4KkzkShcf27eGS0CuhCXXSKel2ExoCFM/laBHlLGAGG5ecEQ?=
 =?iso-8859-1?Q?ORsBUYXsfJiI60XXXzzLuo0CyewUTKzAG33j4lLZXqcPNuYCSm5KxbjJGV?=
 =?iso-8859-1?Q?+nRj673Xt2fltSLUa4uO1DQSD5P+uxrU11KYh6WDdPJ7iQAZDPjDyIvEZm?=
 =?iso-8859-1?Q?9KOrLU2k1ocGCb0ylLt9UMSrwtoL5tDPFGT3nZHLoDWOeA7swRomleeIQE?=
 =?iso-8859-1?Q?KzGR1ewDT4R88FqZeb99bTvxaFJNIhJBA41K6BgHWed7LmQXmebvrgFnPi?=
 =?iso-8859-1?Q?45RDxpJPA68wKlYtojDm5ZoZ6ri4Ksz85TtfJ6dz58Jh6HNEVjoVcanopy?=
 =?iso-8859-1?Q?7J/yw15NOuWsIqT5MyR5jphlkVWu4OLpZjhu1CXai/KRJe2Iav4ynmmTfh?=
 =?iso-8859-1?Q?Upv7Ryv58Boc4KBZlOm8tGXVtizuukXtaT7PIVrHM46c2sPBYDGyWP8HMd?=
 =?iso-8859-1?Q?xC7z7R3zUrHAQYM9pcAzBFu8WfUiM9oZ/5gMs9XvePKJauSVXJLi/dFy8L?=
 =?iso-8859-1?Q?FAVznY1hW9CnyWFutGHXWD7w3kdRyvq2Q11j+rekw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f64802a0-1198-4490-0ea8-08dd9f91a325
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 15:50:01.2275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6024

Hi all,

This patch series includes four patches:

1. The first patch adds a link to the `git-credential-yahoo` helper for
   Yahoo accounts and links Google's `sendgmail` tool as an alternative
   method for sending emails through Gmail.

2. The second patch improves the formatting of the `git-send-email`
   documentation, making it more readable and consistent.

3. The third patch removes the email credential helper links from the
   `gitcredentials` page. The links are still available in the
   `git-send-email` documentation, which is the right place for them.

4. The fourth patch clarifies the purpose of using an app password for
   Gmail in the `git-send-email` documentation. It also encourages
   users to use OAuth2.0 over app passwords for better security.

Detailed explanation of the changes has been done in individual patch.

v2: - Removed instructions for Yahoo SMTP server since I've realised that
      Yahoo *was* a popular email service. Also, the instructions were
      just making the docs more crowded. I've also added a link to
      Google's `sendgmail` tool in the first patch. The second patch has be=
en
      added to address the issues that came up here:
      https://github.com/git/git-scm.com/pull/2005

v3: - Added a patch to improve the formatting of the `git-send-email`
      documentation.

v4: - Added cpan links of the perl modules requires for `git-send-email`
      to work.

v5: - Added a patch to make the purpose of using app password for Gmail
      more clear in `send-email` documentation.

v6: - Reword the documentation a bit more in last patch.
    - Markdown Git: -> 'Git:' in the second patch.
    - Restore the non-existent link (atleast what I believed that to be) in=
 the
      second patch.
    - Remove the unnecessary use of $ with <num> and <int> placeholders in =
the
      second patch.
    - White at it, also prefer using the word "mechanism" over "method" for
      `OAUTHBEARER` and `XOAUTH2` in git-send-email docs since that is what
      official docs use. This changes has been done in the last patch.
    - Sign-off the last patch.

v7: - Use backticks consistently for all headers as well in second patch.

Aditya Garg (4):
  docs: add credential helper for yahoo and link Google's sendgmail tool
  docs: improve formatting in git-send-email documentation
  docs: remove credential helper links for emails from gitcredentials
  docs: make the purpose of using app password for Gmail more clear in
    send-email

 Documentation/config/sendemail.adoc |  20 +--
 Documentation/git-send-email.adoc   | 257 +++++++++++++++-------------
 Documentation/gitcredentials.adoc   |   4 -
 3 files changed, 147 insertions(+), 134 deletions(-)

Range-diff against v6:
-:  ---------- > 1:  2c47cc5396 docs: add credential helper for yahoo and l=
ink Google's sendgmail tool
1:  20da5d6a58 ! 2:  660305721d docs: improve formatting in git-send-email =
documentation
    @@ Commit message
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
    =20
      ## Documentation/config/sendemail.adoc ##
    -@@ Documentation/config/sendemail.adoc: sendemail.<identity>.*::
    +@@
    + sendemail.identity::
    + 	A configuration identity. When given, causes values in the
    +-	'sendemail.<identity>' subsection to take precedence over
    +-	values in the 'sendemail' section. The default identity is
    ++	`sendemail.<identity>` subsection to take precedence over
    ++	values in the `sendemail` section. The default identity is
    + 	the value of `sendemail.identity`.
    +=20
    + sendemail.smtpEncryption::
    + 	See linkgit:git-send-email[1] for description.  Note that this
    +-	setting is not subject to the 'identity' mechanism.
    ++	setting is not subject to the `identity` mechanism.
    +=20
    + sendemail.smtpSSLCertPath::
    + 	Path to ca-certificates (either a directory or a single file).
    + 	Set it to an empty string to disable certificate verification.
    +=20
    + sendemail.<identity>.*::
    +-	Identity-specific versions of the 'sendemail.*' parameters
    ++	Identity-specific versions of the `sendemail.*` parameters
    + 	found below, taking precedence over those when this
    + 	identity is selected, through either the command-line or
      	`sendemail.identity`.
     =20
      sendemail.multiEdit::
    @@ Documentation/config/sendemail.adoc: sendemail.<identity>.*::
      	after the other, spawning a new editor each time.
     =20
      sendemail.confirm::
    + 	Sets the default for whether to confirm before sending. Must be
    +-	one of 'always', 'never', 'cc', 'compose', or 'auto'. See `--confirm=
`
    ++	one of `always`, `never`, `cc`, `compose`, or `auto`. See `--confirm=
`
    + 	in the linkgit:git-send-email[1] documentation for the meaning of th=
ese
    + 	values.
    +=20
    +@@ Documentation/config/sendemail.adoc: sendemail.aliasesFile::
    +=20
    + sendemail.aliasFileType::
    + 	Format of the file(s) specified in sendemail.aliasesFile. Must be
    +-	one of 'mutt', 'mailrc', 'pine', 'elm', 'gnus', or 'sendmail'.
    ++	one of `mutt`, `mailrc`, `pine`, `elm`, `gnus`, or `sendmail`.
    + +
    + What an alias file in each format looks like can be found in
    + the documentation of the email program of the same name. The
     @@ Documentation/config/sendemail.adoc: sendemail.signedOffCc (depreca=
ted)::
     =20
      sendemail.smtpBatchSize::
    @@ Documentation/git-send-email.adoc: There are two formats accepted fo=
r patch file
      +
     -This format expects the first line of the file to contain the "Cc:" v=
alue
     -and the "Subject:" of the message as the second line.
    -+This format expects the first line of the file to contain the 'Cc:' v=
alue
    -+and the 'Subject:' of the message as the second line.
    ++This format expects the first line of the file to contain the `Cc:` v=
alue
    ++and the `Subject:` of the message as the second line.
     =20
     =20
      OPTIONS
    @@ Documentation/git-send-email.adoc: Composing
     =20
      --bcc=3D<address>,...::
     -	Specify a "Bcc:" value for each email. Default is the value of
    -+	Specify a 'Bcc:' value for each email. Default is the value of
    ++	Specify a `Bcc:` value for each email. Default is the value of
      	`sendemail.bcc`.
      +
      This option may be specified multiple times.
     =20
      --cc=3D<address>,...::
     -	Specify a starting "Cc:" value for each email.
    -+	Specify a starting 'Cc:' value for each email.
    ++	Specify a starting `Cc:` value for each email.
      	Default is the value of `sendemail.cc`.
      +
      This option may be specified multiple times.
    @@ Documentation/git-send-email.adoc: This option may be specified mult=
iple times.
     -Subject, Reply-To, and In-Reply-To headers specified in the message. =
If
     -the body of the message (what you type after the headers and a blank
     -line) only contains blank (or Git: prefixed) lines, the summary won't=
 be
    -+When `--compose` is used, `git send-email` will use the 'From', 'To',=
 'Cc',
    -+'Bcc', 'Subject', 'Reply-To', and 'In-Reply-To' headers specified in =
the
    ++When `--compose` is used, `git send-email` will use the `From`, `To`,=
 `Cc`,
    ++`Bcc`, `Subject`, `Reply-To`, and `In-Reply-To` headers specified in =
the
     +message. If the body of the message (what you type after the headers =
and a
    -+blank line) only contains blank (or 'Git:' prefixed) lines, the summa=
ry won't be
    ++blank line) only contains blank (or `Git:` prefixed) lines, the summa=
ry won't be
      sent, but the headers mentioned above will be used unless they are
      removed.
      +
     -Missing From or In-Reply-To headers will be prompted for.
    -+Missing 'From' or 'In-Reply-To' headers will be prompted for.
    ++Missing `From` or `In-Reply-To` headers will be prompted for.
      +
      See the CONFIGURATION section for `sendemail.multiEdit`.
     =20
    @@ Documentation/git-send-email.adoc: This option may be specified mult=
iple times.
      --transfer-encoding=3D(7bit|8bit|quoted-printable|base64|auto)::
      	Specify the transfer encoding to be used to send the message over SM=
TP.
     -	7bit will fail upon encountering a non-ASCII message.  quoted-printa=
ble
    -+	'7bit' will fail upon encountering a non-ASCII message. 'quoted-prin=
table'
    ++	`7bit` will fail upon encountering a non-ASCII message. `quoted-prin=
table`
      	can be useful when the repository contains files that contain carria=
ge
     -	returns, but makes the raw patch email file (as saved from a MUA) mu=
ch
     -	harder to inspect manually.  base64 is even more fool proof, but als=
o
     -	even more opaque.  auto will use 8bit when possible, and quoted-prin=
table
     -	otherwise.
     +	returns, but makes the raw patch email file (as saved from an MUA) m=
uch
    -+	harder to inspect manually. 'base64' is even more fool proof, but al=
so
    -+	even more opaque. 'auto' will use '8bit' when possible, and
    -+	'quoted-printable' otherwise.
    ++	harder to inspect manually. `base64` is even more fool proof, but al=
so
    ++	even more opaque. `auto` will use `8bit` when possible, and
    ++	`quoted-printable` otherwise.
      +
      Default is the value of the `sendemail.transferEncoding` configuratio=
n
    --value; if that is unspecified, default to `auto`.
    -+value; if that is unspecified, default to 'auto'.
    + value; if that is unspecified, default to `auto`.
     =20
      --xmailer::
      --no-xmailer::
     -	Add (or prevent adding) the "X-Mailer:" header.  By default,
    -+	Add (or prevent adding) the 'X-Mailer:' header.  By default,
    ++	Add (or prevent adding) the `X-Mailer:` header.  By default,
      	the header is added, but it can be turned off by setting the
      	`sendemail.xmailer` configuration variable to `false`.
     =20
     @@ Documentation/git-send-email.adoc: Sending
    + --envelope-sender=3D<address>::
      	Specify the envelope sender used to send the emails.
      	This is useful if your default address is not the address that is
    - 	subscribed to a list. In order to use the 'From' address, set the
    +-	subscribed to a list. In order to use the 'From' address, set the
     -	value to "auto". If you use the sendmail binary, you must have
     -	suitable privileges for the -f parameter.  Default is the value of t=
he
    ++	subscribed to a list. In order to use the `From` address, set the
     +	value to `auto`. If you use the `sendmail` binary, you must have
     +	suitable privileges for the `-f` parameter.  Default is the value of=
 the
      	`sendemail.envelopeSender` configuration variable; if that is
    @@ Documentation/git-send-email.adoc: Sending
     =20
      --smtp-encryption=3D<encryption>::
      	Specify in what way encrypting begins for the SMTP connection.
    -@@ Documentation/git-send-email.adoc: Sending
    +-	Valid values are 'ssl' and 'tls'. Any other value reverts to plain
    ++	Valid values are `ssl` and `tls`. Any other value reverts to plain
    + 	(unencrypted) SMTP, which defaults to port 25.
    + 	Despite the names, both values will use the same newer version of TL=
S,
    +-	but for historic reasons have these names. 'ssl' refers to "implicit=
"
    ++	but for historic reasons have these names. `ssl` refers to "implicit=
"
    + 	encryption (sometimes called SMTPS), that uses port 465 by default.
    +-	'tls' refers to "explicit" encryption (often known as STARTTLS),
    ++	`tls` refers to "explicit" encryption (often known as STARTTLS),
    + 	that uses port 25 by default. Other ports might be used by the SMTP
    + 	server, which are not the default. Commonly found alternative port f=
or
    +-	'tls' and unencrypted is 587. You need to check your provider's
    ++	`tls` and unencrypted is 587. You need to check your provider's
    + 	documentation or your server configuration to make sure
    + 	for your own case. Default is the value of `sendemail.smtpEncryption=
`.
    +=20
      --smtp-domain=3D<FQDN>::
      	Specifies the Fully Qualified Domain Name (FQDN) used in the
      	HELO/EHLO command to the SMTP server.  Some servers require the
    @@ Documentation/git-send-email.adoc: instead.
      to pass to the server. Likewise, different lines in the configuration=
 files
      must be used for each option.
     =20
    -@@ Documentation/git-send-email.adoc: must be used for each option.
    + --smtp-ssl::
    +-	Legacy alias for '--smtp-encryption ssl'.
    ++	Legacy alias for `--smtp-encryption ssl`.
    +=20
      --smtp-ssl-cert-path::
      	Path to a store of trusted CA certificates for SMTP SSL/TLS
      	certificate validation (either a directory that has been processed
    @@ Documentation/git-send-email.adoc: Automating
      --no-cc::
      --no-bcc::
     -	Clears any list of "To:", "Cc:", "Bcc:" addresses previously
    -+	Clears any list of 'To:', 'Cc:', 'Bcc:' addresses previously
    ++	Clears any list of `To:`, `Cc:`, `Bcc:` addresses previously
      	set via config.
     =20
      --no-identity::
    @@ Documentation/git-send-email.adoc: Automating
      --to-cmd=3D<command>::
      	Specify a command to execute once per patch file which
     -	should generate patch file specific "To:" entries.
    -+	should generate patch file specific 'To:' entries.
    ++	should generate patch file specific `To:` entries.
      	Output of this command must be single email address per line.
     -	Default is the value of 'sendemail.toCmd' configuration value.
     +	Default is the value of `sendemail.toCmd` configuration value.
    @@ Documentation/git-send-email.adoc: Automating
      --cc-cmd=3D<command>::
      	Specify a command to execute once per patch file which
     -	should generate patch file specific "Cc:" entries.
    -+	should generate patch file specific 'Cc:' entries.
    ++	should generate patch file specific `Cc:` entries.
      	Output of this command must be single email address per line.
      	Default is the value of `sendemail.ccCmd` configuration value.
     =20
    @@ Documentation/git-send-email.adoc: Automating
      	this, it is recommended that the first file given be an overview of =
the
      	entire patch series. Disabled by default, but the `sendemail.chainRe=
plyTo`
     @@ Documentation/git-send-email.adoc: Automating
    +=20
    + --identity=3D<identity>::
    + 	A configuration identity. When given, causes values in the
    +-	'sendemail.<identity>' subsection to take precedence over
    +-	values in the 'sendemail' section. The default identity is
    ++	`sendemail.<identity>` subsection to take precedence over
    ++	values in the `sendemail` section. The default identity is
      	the value of `sendemail.identity`.
     =20
      --[no-]signed-off-by-cc::
     -	If this is set, add emails found in the `Signed-off-by` trailer or C=
c: lines to the
     -	cc list. Default is the value of `sendemail.signedOffByCc` configura=
tion
     -	value; if that is unspecified, default to --signed-off-by-cc.
    -+	If this is set, add emails found in the `Signed-off-by` trailer or '=
Cc:'
    ++	If this is set, add emails found in the `Signed-off-by` trailer or `=
Cc:`
     +	lines to the cc list. Default is the value of `sendemail.signedOffBy=
Cc`
     +	configuration value; if that is unspecified, default to
     +	`--signed-off-by-cc`.
     =20
      --[no-]cc-cover::
     -	If this is set, emails found in Cc: headers in the first patch of
    -+	If this is set, emails found in 'Cc:' headers in the first patch of
    ++	If this is set, emails found in `Cc:` headers in the first patch of
      	the series (typically the cover letter) are added to the cc list
     -	for each email set. Default is the value of 'sendemail.ccCover'
     -	configuration value; if that is unspecified, default to --no-cc-cove=
r.
    @@ Documentation/git-send-email.adoc: Automating
     =20
      --[no-]to-cover::
     -	If this is set, emails found in To: headers in the first patch of
    -+	If this is set, emails found in 'To:' headers in the first patch of
    ++	If this is set, emails found in `To:` headers in the first patch of
      	the series (typically the cover letter) are added to the to list
     -	for each email set. Default is the value of 'sendemail.toCover'
     -	configuration value; if that is unspecified, default to --no-to-cove=
r.
    @@ Documentation/git-send-email.adoc: Automating
     =20
      --suppress-cc=3D<category>::
      	Specify an additional category of recipients to suppress the
    -@@ Documentation/git-send-email.adoc: Automating
    + 	auto-cc of:
    + +
    + --
    +-- 'author' will avoid including the patch author.
    +-- 'self' will avoid including the sender.
    +-- 'cc' will avoid including anyone mentioned in Cc lines in the patch=
 header
    +-  except for self (use 'self' for that).
    +-- 'bodycc' will avoid including anyone mentioned in Cc lines in the
    +-  patch body (commit message) except for self (use 'self' for that).
    +-- 'sob' will avoid including anyone mentioned in the Signed-off-by tr=
ailers except
    +-  for self (use 'self' for that).
    +-- 'misc-by' will avoid including anyone mentioned in Acked-by,
    ++- `author` will avoid including the patch author.
    ++- `self` will avoid including the sender.
    ++- `cc` will avoid including anyone mentioned in Cc lines in the patch=
 header
    ++  except for self (use `self` for that).
    ++- `bodycc` will avoid including anyone mentioned in Cc lines in the
    ++  patch body (commit message) except for self (use `self` for that).
    ++- `sob` will avoid including anyone mentioned in the Signed-off-by tr=
ailers except
    ++  for self (use `self` for that).
    ++- `misc-by` will avoid including anyone mentioned in Acked-by,
    +   Reviewed-by, Tested-by and other "-by" lines in the patch body,
    +-  except Signed-off-by (use 'sob' for that).
    +-- 'cccmd' will avoid running the --cc-cmd.
    +-- 'body' is equivalent to 'sob' + 'bodycc' + 'misc-by'.
    +-- 'all' will suppress all auto cc values.
    ++  except Signed-off-by (use `sob` for that).
    ++- `cccmd` will avoid running the --cc-cmd.
    ++- `body` is equivalent to `sob` + `bodycc` + `misc-by`.
    ++- `all` will suppress all auto cc values.
      --
      +
      Default is the value of `sendemail.suppressCc` configuration value; i=
f
     -that is unspecified, default to 'self' if --suppress-from is
     -specified, as well as 'body' if --no-signed-off-cc is specified.
    -+that is unspecified, default to 'self' if `--suppress-from` is
    -+specified, as well as 'body' if `--no-signed-off-cc` is specified.
    ++that is unspecified, default to `self` if `--suppress-from` is
    ++specified, as well as `body` if `--no-signed-off-cc` is specified.
     =20
      --[no-]suppress-from::
     -	If this is set, do not add the From: address to the cc: list.
    -+	If this is set, do not add the 'From:' address to the 'Cc:' list.
    ++	If this is set, do not add the `From:` address to the `Cc:` list.
      	Default is the value of `sendemail.suppressFrom` configuration
     -	value; if that is unspecified, default to --no-suppress-from.
     +	value; if that is unspecified, default to `--no-suppress-from`.
     =20
      --[no-]thread::
     -	If this is set, the In-Reply-To and References headers will be
    -+	If this is set, the 'In-Reply-To' and 'References' headers will be
    ++	If this is set, the `In-Reply-To` and `References` headers will be
      	added to each email sent.  Whether each mail refers to the
     -	previous email (`deep` threading per 'git format-patch'
     +	previous email (`deep` threading per `git format-patch`
    @@ Documentation/git-send-email.adoc: Administering
      --
     -- 'always' will always confirm before sending
     -- 'never' will never confirm before sending
    -+- 'always' will always confirm before sending.
    -+- 'never' will never confirm before sending.
    - - 'cc' will confirm before sending when send-email has automatically
    +-- 'cc' will confirm before sending when send-email has automatically
     -  added addresses from the patch to the Cc list
    -+  added addresses from the patch to the Cc list.
    - - 'compose' will confirm before sending the first message when using =
--compose.
    +-- 'compose' will confirm before sending the first message when using =
--compose.
     -- 'auto' is equivalent to 'cc' + 'compose'
    -+- 'auto' is equivalent to 'cc' + 'compose'.
    ++- `always` will always confirm before sending.
    ++- `never` will never confirm before sending.
    ++- `cc` will confirm before sending when send-email has automatically
    ++  added addresses from the patch to the Cc list.
    ++- `compose` will confirm before sending the first message when using =
--compose.
    ++- `auto` is equivalent to `cc` + `compose`.
      --
      +
      Default is the value of `sendemail.confirm` configuration value; if t=
hat
    +-is unspecified, default to 'auto' unless any of the suppress options
    +-have been specified, in which case default to 'compose'.
    ++is unspecified, default to `auto` unless any of the suppress options
    ++have been specified, in which case default to `compose`.
    +=20
    + --dry-run::
    + 	Do everything except actually send the emails.
     @@ Documentation/git-send-email.adoc: have been specified, in which ca=
se default to 'compose'.
      	When an argument may be understood either as a reference or as a fil=
e name,
      	choose to understand it as a format-patch argument (`--format-patch`=
)
    @@ Documentation/git-send-email.adoc: have been specified, in which cas=
e default to
      	all that is output.
     =20
      --[no-]validate::
    +@@ Documentation/git-send-email.adoc: have been specified, in which ca=
se default to 'compose'.
    + 		*	Invoke the sendemail-validate hook if present (see linkgit:githoo=
ks[5]).
    + 		*	Warn of patches that contain lines longer than
    + 			998 characters unless a suitable transfer encoding
    +-			('auto', 'base64', or 'quoted-printable') is used;
    ++			(`auto`, `base64`, or `quoted-printable`) is used;
    + 			this is due to SMTP limits as described by
    + 			https://www.ietf.org/rfc/rfc5322.txt.
    + --
    +@@ Documentation/git-send-email.adoc: Information
    + 	Instead of the normal operation, dump the shorthand alias names from
    + 	the configured alias file(s), one per line in alphabetical order. No=
te
    + 	that this only includes the alias name and not its expanded email ad=
dresses.
    +-	See 'sendemail.aliasesFile' for more information about aliases.
    ++	See `sendemail.aliasesFile` for more information about aliases.
    +=20
    + --translate-aliases::
    + 	Instead of the normal operation, read from standard input and
    + 	interpret each line as an email alias. Translate it according to the
    + 	configured alias file(s). Output each translated name and email
    +-	address to standard output, one per line. See 'sendemail.aliasFile'
    ++	address to standard output, one per line. See `sendemail.aliasFile`
    + 	for more information about aliases.
    +=20
    + CONFIGURATION
     @@ Documentation/git-send-email.adoc: edit `~/.gitconfig` to specify y=
our account settings:
      ----
     =20
2:  a05958c7aa =3D 3:  4916bde9e5 docs: remove credential helper links for =
emails from gitcredentials
3:  e2dd5d9d81 =3D 4:  66c75485e2 docs: make the purpose of using app passw=
ord for Gmail more clear in send-email
--=20
2.49.0.639.ge2dd5d9d81

