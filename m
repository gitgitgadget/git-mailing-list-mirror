Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010010.outbound.protection.outlook.com [52.103.68.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF6433D1
	for <git@vger.kernel.org>; Fri, 30 May 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748605035; cv=fail; b=IZD/3ssOReC+6LeBh7V6Ksa5XCrnrK25G3CwFKy0WL9uZ4BqYZhYAMBv8KCIkto+jM+EvNWJbRZbsMMJKwD8pOeRlJmShHoAY07HViOyvolLEusJPmomnLhBh1X5feNgBv4Nuy4UVWcvmo2U2HabrJts/UVe2wsLps2kINwAnpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748605035; c=relaxed/simple;
	bh=8lAoLXIANguibcLl7zQl5YUuK2Esm55oMBm+NYTw0zI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vz1ipkQPGpbRjJpIBoQwDp8NGLriSPjYdTixdciWifknVSe6PfXkB5rSnakz0GYkeVNH8tPH1XmSBe6+zxVnYfoXUHS9P3ZL9HlZ8aR0MPHC1mRHd/OBHFwvF5Oib0Tf+hsbnIDlGjqR9p8E6wk/pZvUWC/u7PYuv8aJW5J7NfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=LS6arl3e; arc=fail smtp.client-ip=52.103.68.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="LS6arl3e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHHRE3n9cKepszMiF3alxJrpbLOnkoVI+Y7CRJ+T/10txAce13LyZgLzDhwcH2TP9Pl5fYlv9pqoM+tBgWeMSYKOyS77+d1eoi6ivjwmOdYkFBKeZUe/uFOLc/noJLYb4tRTmADGj6p7C1s4PRFtePhZ+SZ4dgZhwDzeEYPtUZuiIlJAGeyBYm3DOM5zV83XCI2dlMVnmyS3wU3NAbMcOuAS65mnxp75VQcZG9TPQi+JaWStUc2Rm9sc0hOTcXrIc9lFQME73Sfog4LYN+3C3AWJC0QxD92EuRKalHYECtnVgokBkpbfPAyYhlMyMX/x1tdvKD6/SE69bmTxxuqOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75E1kDn8Q4kTUmbHDeNwB5fluTaqC58Qy30xkDqXsuI=;
 b=yaethiRml6EySmpQsV93zs0grOs2rDDwKYCtS2XE//ERDOUswUiThLOW/bfg/O9+1g4K3RhrI4uEpOI6TZBpvGpOa4PMeiz0bFCLPs8f541OrHTbieF8LaVxrtygtZ1EMMiusfPrCJxswZ1q3OIP9cJE/PtrUaCGdR8WWF3LllGg1hsbxuO/Sumx+I4wg4s75upZYlDrQadIIGkA3YOhieNTrFwAIBLGgtNokVnJ5jotr+/dJCnUBR8yhfMhtOkb5KYUcyQwnsuOZ8amSww/LY7OtDWxY7HGEZu4rzPa/TquXwBcQiRC0jFndz146Stff4aRoUH0cMf85GnddB/wkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75E1kDn8Q4kTUmbHDeNwB5fluTaqC58Qy30xkDqXsuI=;
 b=LS6arl3e3cgMST0kOqx+DIjBRTCIPMKamSkF6uRXmTKv4dhC1KnWgj3dBGKgn30PUZWdfQgzvTM9XrBiU/JZC7lFSPKHgN+RQIrO0XJ4HqANOB319gC4yWYl5U6PplUo9fCuFTNr71rUgmSjM1qJ97U6d4IfWpJwwDaF7LvnWigCIyz/KgJU+ZrUVkG3Yi2bJEepdqOkUJ8q/AbcVvNWqzEc87vhnvlGqomK9y/17RMwFPouY4jvd22cyVGEsLc1Ug683r9rXQipH8F5llptq7vljWgZbnNT0Ps3kKvnm5A+X+aixlIPxpE/XNeQSlVjSfuoyLyBLhFz7apCnz4EkA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 11:37:07 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 11:37:07 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>
Subject: [PATCH v6 0/4] docs: update email credential helpers and improve
 formatting
Thread-Topic: [PATCH v6 0/4] docs: update email credential helpers and improve
 formatting
Thread-Index: AQHb0Vcs3+xvSq2CtE6EqQ/ZeWKDeQ==
Date: Fri, 30 May 2025 11:37:07 +0000
Message-ID: <20250530113627.8639-1-gargaditya08@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNZPR01MB4415:EE_
x-ms-office365-filtering-correlation-id: 642fd6b6-77e2-4470-190b-08dd9f6e4ee0
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd+Ewy2R3Pu64sHUJuYJdjG86zL2F6PXWqjgiQo3phGyk2FCLYVDVfwEF5Ztck4MMMB4ekdzMQ6rZHTYMwVpeeRV2mAGkkNumYEGhZMF5jKVd4ZWtjtNtS8zCvMWJMuso0AGaHNCKlw2XBVyn8e7CXSl5ZmOPx3IWayVP9JM3NTLEfbDRj9KDDQoqTsk2nL4PvNX49tElGUCjh1TtB6HPZ28nhKhZc9YOFcO6WRfJS5phAkg3CMHQ7jcvVSsQdkph0USwK3yeXN7/xB955iKjLXmkCaJ0h16LLamfSyiA6U/0NqmXzQmk0Ki1FvO05qlCHjyK1zDdmDd9Nc9PwdPmkDOyJg7B2IY2N5qOrBq7919wor8Ds01rnoDEZRfuJuRD0525qTic2mkxqYbCsAOkg90lLLWqctIV7d2mwlqYN+6udvFOKgqZHIOGTxh85Vqmyur3QZEGnPgEEd/j714gJUPmqz4dVoBiKUCyvo1Qn14kXsSdxYGz+LZgBppaxJE7qMaONssoLQ0XH7mEAwnauePy2v3EM+bmmNF2QM6S7fBjWCWKzY7YIzRuKoj2x+//aaop0MkXb1nBGvF/w7Gr8BbnA46xF8V8uBT4SBd4fiKcJZrT91kuPPc2bdl13WtUGnS9BtYiQ4q1Ft7s6VC7sheWCDZuUFSGQ9td1iDj7YecJDadyyfcH1inY61ZoYpndsBpu/2M/SjkgrUhVpLhuBTQ/17YTqHuHKceuMxcIjtwMFeKbjywyc8x/rt70ADG9tuiwMAywA5HZGb2uZNAK3We8Vg3PPj6+lPBVwm9cRAfw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|8060799009|461199028|38102599003|41001999006|19110799006|8062599006|21061999006|15080799009|12121999007|3412199025|440099028|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?FatfJkx+4YYpqAGFLK3AH4t92TB/cMRX1g6bSKPuC2wxA/4zpcYH8ML6rm?=
 =?iso-8859-1?Q?W5T2JFmTRlyYyCpDoqYEy6bRqNuJTE5fQgjSXFXHJh04exfiVm3108mnoc?=
 =?iso-8859-1?Q?BG2xzcHhW/e8IG52qOuJSKkiK8/fA5OplyocJUDIHavscVtKNmHE1wXf8N?=
 =?iso-8859-1?Q?ZdAwwxLsRE4b6rrUTiDqwAREFKf5L601NGikx69UHjXw3WYrfkdx8wIwEB?=
 =?iso-8859-1?Q?w77+7ch4WhJza4Hwrw5YTt/UIjO3YYr0Vzpni33NCzwovfB954m91nSOFN?=
 =?iso-8859-1?Q?Ap7fVg5x2QgVPcLW4gZpD6lYxayj+Nj5OKltoOqF8i7oiXdEnJahCgEjc/?=
 =?iso-8859-1?Q?9EZP0AX22P4q2//BkT920Yy2ESlej5/3tdg8a+BLHjLy2kFtiDupt+c8YI?=
 =?iso-8859-1?Q?UvDvjQPTQRxx7lS7cDKzEzqWEAQDE3TFxYeQi20UGWsTttUiPQ65qc1BwB?=
 =?iso-8859-1?Q?13+hmvoHzy2r5HR+bxxbrNJZWRl4p4yPwAJzoeLMJSPMwF0Qm8tYSrT4oB?=
 =?iso-8859-1?Q?2Fo+w1UfwmjTvyFkPj61C6kBJZxzGEt1RBsicmVLBiA/8cptWmEsvAw9Kq?=
 =?iso-8859-1?Q?WEBHv77dMlxpsbdyPpaCUQC6yvTTRMnlkzRyLpjqaBBbeIoj6oZaJOzL7Y?=
 =?iso-8859-1?Q?BQc9H20hpkaO/PSp0OoVl4GGzb6rp0mbIl4ZVXiBrqtngbtk7zOEoBA3+D?=
 =?iso-8859-1?Q?byG/0VDYA/0Pjc/ghJOpP3gbQ3d/rx18y1qgwifUCcdH13COlW1al0UXX1?=
 =?iso-8859-1?Q?JawBoW/eOvatI4evG/iCrUB8/j+ucOn/I//nKx5QuTh0LlMAvck0AfGXNa?=
 =?iso-8859-1?Q?M+fN25TZ4u8UMPVwppP1GNY9xl4eF/VbzAiI/vXFiRXeuojlXJAHxsOggj?=
 =?iso-8859-1?Q?lnv2VaJVJE6eTMrKsbRXXGikndu3muAOtvWUmW63Z6DOhskZLwIc+KJrSj?=
 =?iso-8859-1?Q?J4RMd1Gh/xPrUL52d2gZru+NjI3ZTJrOrcXQuY0HqEka/LxNUzQK7ce1y8?=
 =?iso-8859-1?Q?1CQV0yj7QE8hvsMyJFU4hln1+I4m2cQvbEu85bijSD+0Y32/mqXHTduX3z?=
 =?iso-8859-1?Q?vCPnsRgMJfKGvGc45q6ZMdRhOqkh6mGD9VMwxY7EzFI5Ku90fvC12OUaUx?=
 =?iso-8859-1?Q?wvCKBnbtwsrr/T6ci/BMUGmU7n7IV3lZuPKMQ6f9O3Fn5YguyH/G0sg+wB?=
 =?iso-8859-1?Q?PXogMbHbZ223e01i/UwjfgEn2EzGSKNIcXWI0c2VJAfyQdVjQGqDl5KU7s?=
 =?iso-8859-1?Q?DgzNYY/EEGvlwNGt0EDApf2vCm7xk9p/NfpC6BpxCdIMPkBSyN9iweW99W?=
 =?iso-8859-1?Q?rjvNpLvWu1rYdVO/3p0TNYtjOWyESzMJyNyY+rVykJSQadI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?YU07EJ9AetLr++jQM5wFqlaxDQs+JxRCWz8BgIMpVW05djYs50N/eRUKzP?=
 =?iso-8859-1?Q?wKm+vvfjAkbKhJ9DdlPg/fL+2HIyFQTujT2jGIreFq2ux9OPKL+FosLTrV?=
 =?iso-8859-1?Q?h+Js3X3TE7ApxXWd8HK/37etJxumkJ6yaFzGz4aMaxWTyUMUjmd8oz0xPH?=
 =?iso-8859-1?Q?BwHB6qRDieLQwtDs4kD2zHpVlm2ttzaXbzl89zoDO8eaTY8ITUeNOg1jaD?=
 =?iso-8859-1?Q?OI9ULjgJFqjw3XjBvmdxgK44QMSgBoowrCWaJ400LbuxDy4hl7dyX0aKHa?=
 =?iso-8859-1?Q?DUBlDUo/0zopHHArhEfE/bp7uZNMl6pjaO/E1MBNOnIp2fO4pH0Pd2RLl5?=
 =?iso-8859-1?Q?0ImE/M0OLViOhya69kX4xAqB8Pe6bJseuMG4GtzkCllO4r7HiOXxeNfb9/?=
 =?iso-8859-1?Q?3ROIJGekeExhLn16JKrpsd/hrMRwPR5AW7aHxoLIPHU2ux/6jsbRrSRwDm?=
 =?iso-8859-1?Q?FuucgWjvyd8z1lWR5Y6G7j8golBkc7kHPuzqni7itlWV0jRvi/cLAPIGjT?=
 =?iso-8859-1?Q?EkyYbt0qtzilpL7oHK+ZefY/KdLEqd2Y1NJ4bJQn24AacYhCVywURmHdAQ?=
 =?iso-8859-1?Q?/YR7ylV7Ie9P/xgG8u+zOvxgLxgkp//h5kuf5vjXprjwSyyOG3dEB8Dwyr?=
 =?iso-8859-1?Q?iwLh4kvU9urMTuZc5+yT5XDkEiSJI8YCT6lSVIyAIDiSq/TJoHZ5tNH/rb?=
 =?iso-8859-1?Q?1O9/8e/bfjy3r7MJVOGRdkem2dapDymVm5zpfPASiNpC8TTlV+7cDFYvVV?=
 =?iso-8859-1?Q?eQhN7H6JxegISXe19Hka62f/IChOwAQHTgtUdphnklBfWH3ZO8ki64gm/H?=
 =?iso-8859-1?Q?cqJzY2HisZtauczl5QHmHQGkx4sFcJXCGn0/8mM7VKZcuouIgvDbtiYWr4?=
 =?iso-8859-1?Q?LFpnjT6pQLpRdIyB/YUx1sq4XK8eY9U6hrl5I01V+7XieZGw5WwItyYV09?=
 =?iso-8859-1?Q?kSMtdnKjTCyc3/S35lFXRYA8uQN71uyCjnbwvQbcOMloc8fFSBOVFJuNlt?=
 =?iso-8859-1?Q?BRX9a5kW2GCawp2HhTC4rfqo7xwKY3JPf8nww+nn7D/h+C0guQXv3OoPWc?=
 =?iso-8859-1?Q?6w9L/DPMNGycLf9w/saqig3B4gheummoWh/N4RRY6AsHMBdDOY35et06nj?=
 =?iso-8859-1?Q?uu8r4eyaq2B3FyJjOF2dDVFCOB5XQbQzOkjlyEe5tFPYuAVu0EUTl3bZ/i?=
 =?iso-8859-1?Q?0SzEW62t1FHP9f25hwXRfJWGk2X1ZNnT1HWAkfW3w5f/m+wkglugXZBc10?=
 =?iso-8859-1?Q?LVeJtfLXM59s1ypi9yTyaBC+7B85ZGpc1ZbRMHwM4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 642fd6b6-77e2-4470-190b-08dd9f6e4ee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 11:37:07.4788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4415

Hi all,

This patch series included three patches:

1. The first patch adds a link to the `git-credential-yahoo` helper for
   Yahoo accounts and links Google's `sendgmail` tool as an alternative
   method for sending emails through Gmail.

2. The second patch improves the formatting of the `git-send-email`
   documentation, making it more readable and consistent.

3. The third patch removed the email credential helper links from the
   `gitcredentials` page. The links are still available in the
   `git-send-email` documentation, which is the right place for them.

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

    NOTE: I have not used `` for Headers in the second patch. I think its o=
k
          to deviate a bit from the rules and not be army men here. If I
          markdown them as code, the whole doc will be filled with codestyl=
ed
          blocks, and I think, these headers demand "different treatement"
          than rest other code and variables. Codeblocks everywhere are mor=
e
          of hurting the readability of the documentation than helping it.

Aditya Garg (4):
  docs: add credential helper for yahoo and link Google's sendgmail tool
  docs: improve formatting in git-send-email documentation
  docs: remove credential helper links for emails from gitcredentials
  docs: make the purpose of using app password for Gmail more clear in
    send-email

 Documentation/config/sendemail.adoc |   8 +-
 Documentation/git-send-email.adoc   | 203 +++++++++++++++-------------
 Documentation/gitcredentials.adoc   |   4 -
 3 files changed, 114 insertions(+), 101 deletions(-)

Range-diff against v5:
-:  ---------- > 1:  2c47cc5396 docs: add credential helper for yahoo and l=
ink Google's sendgmail tool
1:  bc1d0471ca ! 2:  20da5d6a58 docs: improve formatting in git-send-email =
documentation
    @@ Commit message
    =20
         The current documentation for git-send-email had an inconsistent u=
se of
         "", ``, and '' for quoting. This commit improves the formatting by
    -    using the same style throughout the documentation.
    -
    -    Also, at some places, minor grammatical errors were fixed, and som=
e
    -    non existent links were removed.
    +    using the same style throughout the documentation. Missing full st=
ops
    +    have also been added at some places.
    =20
         Finally, the cpan links of necessary perl modules have been added =
to
         make their installation easier.
    =20
    +    While at it, the unecessary use of $ with <num> and <int> placehol=
ders
    +    has also been removed.
    +
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
    =20
      ## Documentation/config/sendemail.adoc ##
    @@ Documentation/git-send-email.adoc: This option may be specified mult=
iple times.
     +When `--compose` is used, `git send-email` will use the 'From', 'To',=
 'Cc',
     +'Bcc', 'Subject', 'Reply-To', and 'In-Reply-To' headers specified in =
the
     +message. If the body of the message (what you type after the headers =
and a
    -+blank line) only contains blank (or Git: prefixed) lines, the summary=
 won't be
    ++blank line) only contains blank (or 'Git:' prefixed) lines, the summa=
ry won't be
      sent, but the headers mentioned above will be used unless they are
      removed.
      +
    @@ Documentation/git-send-email.adoc: must be used for each option.
      	Path to a store of trusted CA certificates for SMTP SSL/TLS
      	certificate validation (either a directory that has been processed
     -	by 'c_rehash', or a single file containing one or more PEM format
    --	certificates concatenated together: see verify(1) -CAfile and
    --	-CApath for more information on these). Set it to an empty string
     +	by `c_rehash`, or a single file containing one or more PEM format
    -+	certificates concatenated together). Set it to an empty string
    + 	certificates concatenated together: see verify(1) -CAfile and
    + 	-CApath for more information on these). Set it to an empty string
      	to disable certificate verification. Defaults to the value of the
    - 	`sendemail.smtpSSLCertPath` configuration variable, if set, or the
    - 	backing SSL library's compiled-in default otherwise (which should
     @@ Documentation/git-send-email.adoc: must be used for each option.
      	connection and authentication problems.
     =20
    @@ Documentation/git-send-email.adoc: must be used for each option.
     -	and reconnect, to work around such a limit.  You may want to
     -	use some form of credential helper to avoid having to retype
     -	your password every time this happens.  Defaults to the
    -+	sending `$<num>` messages and wait for a few seconds
    ++	sending _<num>_ messages and wait for a few seconds
     +	(see `--relogin-delay`) and reconnect, to work around such a limit.
     +	You may want to use some form of credential helper to avoid having t=
o
     +	retype your password every time this happens.  Defaults to the
    @@ Documentation/git-send-email.adoc: must be used for each option.
      --relogin-delay=3D<int>::
     -	Waiting $<int> seconds before reconnecting to SMTP server. Used toge=
ther
     -	with --batch-size option.  Defaults to the `sendemail.smtpReloginDel=
ay`
    -+	Waiting `$<int>` seconds before reconnecting to SMTP server. Used to=
gether
    ++	Waiting _<int>_ seconds before reconnecting to SMTP server. Used tog=
ether
     +	with `--batch-size` option.  Defaults to the `sendemail.smtpReloginD=
elay`
      	configuration variable.
     =20
2:  b9e41e2492 =3D 3:  a05958c7aa docs: remove credential helper links for =
emails from gitcredentials
3:  a6ad7ac810 ! 4:  0bf48ac27d docs: make the purpose of using app passwor=
d for Gmail more clear in send-email
    @@ Commit message
         enabled. Most likely the example was written in the days when Goog=
le
         allowed using normal passwords without multi-factor authentication=
.
    =20
    -    This commit clarifies that app passwords are required and suggests=
 using
    -    OAuth2 if the user does not want to enable multi-factor authentica=
tion.
    +    Clarify that regular passwords do not work for Gmail and app-passw=
ords
    +    are the only way for basic authentication. Also encourage users to=
 use
    +    OAuth2 as a more secure alternative.
    +
    +    While at it, also prefer using the word "mechanism" over "method" =
for
    +    `OAUTHBEARER` and `XOAUTH2` since that is what official docs use.
    +
    +    Signed-off-by: Aditya Garg <gargaditya08@live.com>
    =20
      ## Documentation/git-send-email.adoc ##
     @@ Documentation/git-send-email.adoc: edit `~/.gitconfig` to specify y=
our account settings:
      	smtpServerPort =3D 587
      ----
     =20
    -+Gmail does not allow using your account password for `git send-email`=
.
    ++Gmail does not allow using your regular password for `git send-email`=
.
      If you have multi-factor authentication set up on your Gmail account,=
 you can
      generate an app-specific password for use with `git send-email`. Visi=
t
      https://security.google.com/settings/security/apppasswords to create =
it.
    -+If you do not want to enable multi-factor authentication, you can use=
 OAuth2.0
    -+authentication as described below.
     =20
    - You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` an=
d
    - `XOAUTH2` are common methods used for this type of authentication. Gm=
ail
    +-You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` an=
d
    +-`XOAUTH2` are common methods used for this type of authentication. Gm=
ail
    +-supports both of them. As an example, if you want to use `OAUTHBEARER=
`, edit
    +-your `~/.gitconfig` file and add `smtpAuth =3D OAUTHBEARER` to your a=
ccount
    +-settings:
    ++Alternatively, instead of using an app-specific password, you can use
    ++OAuth2.0 authentication with Gmail. OAuth2.0 is more secure than
    ++app-specific passwords, and works regardless of whether you have mult=
i-factor
    ++authentication set up. `OAUTHBEARER` and `XOAUTH2` are common mechani=
sms used
    ++for this type of authentication. Gmail supports both of them. As an e=
xample,
    ++if you want to use `OAUTHBEARER`, edit your `~/.gitconfig` file and a=
dd
    ++`smtpAuth =3D OAUTHBEARER` to your account settings:
    +=20
    + ----
    + [sendemail]
    +@@ Documentation/git-send-email.adoc: settings:
    + 	smtpAuth =3D OAUTHBEARER
    + ----
    +=20
    +-Alternatively, you can use a tool developed by Google known as
    ++Another alternative is using a tool developed by Google known as
    + https://github.com/google/gmail-oauth2-tools/tree/master/go/sendgmail=
[sendgmail]
    + to send emails using `git send-email`.
    +=20
    +@@ Documentation/git-send-email.adoc: Use Microsoft Outlook as the SMT=
P Server
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + Unlike Gmail, Microsoft Outlook no longer supports app-specific passw=
ords.
    + Therefore, OAuth2.0 authentication must be used for Outlook. Also, it=
 only
    +-supports `XOAUTH2` authentication method.
    ++supports `XOAUTH2` authentication mechanism.
    +=20
    + Edit `~/.gitconfig` to specify your account settings for Outlook and =
use its
    + SMTP server with `git send-email`:
--=20
2.49.0.638.g03d7d6a772

