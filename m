Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8921B4231
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535668; cv=fail; b=L1LNiWi5mCgP3KNrQ7/j22M2uIGr65aDRJZM1IebNiIWJMDKSjEXS5wJMVQx4px1UPehIYuINm4fewS5ScdKyLRwHQUlJenIx9HuX2T+0rp6TqcLuWsLYSixZLcN0gQ77Mj0d0qqksqDcvvQaVoiUmN8sS8JB4BfvJ6lo7HaduE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535668; c=relaxed/simple;
	bh=cM5qScKdQFy6ACmc5UKiksP+Yub8y1sXPi/55WR7ZSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MqwJkIYNXbslH5BesA517JV574Zph2ofude1KtYBFc2ITYckO9hoHavGdqhRCh6DUhiJ+nbY3e/9UYzjrmOMl7DmbeE7rcQtjNYTMJq183gwjom3i7LsQHegODzAna2YtI630d/HQRf0Xs8vw7rtoGQjWDg3bVRv7PbvXF2iAZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Y+TYhcZ3; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Y+TYhcZ3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5Xi7VPXagUXl7avgl7Q/BUBAXLxcoOWp87wMVZoWgpmsc4rk5wDWS1azgZ8nkcY6C2IilM0eczlb1PDbzcRyaKA/O2VeiaGi2D56N3fthMQlm+BS0oF03k67qAUcBfFlqGoLNKMCtEaClZQHZnkleyVOXKoqk3qK1HBRiMMrsAYHBD0ePbPQGbcEjvVPu5r6PWHX+VNwOeqlHENIKiSKp6EDZaPTFuQDwgvrbJrjoB/ogv9Xw17U3EsODNIlfpRb5wtznxwe4lZPmf9ve4atNf006U6khAG+dCELYGdY0UHjfzasWDIgM1LpABavQ3vYBFPtjw666KUHeNnRwhdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/moazRnu69iWeEmiqzFhD2zxzEZp2x2LP0kqcEDZ2RE=;
 b=kr5z3BDm11/eFVaHedcQqgxnjp7P6QwF1S8uslEYb4gC7eKgGqQ54D6CxXKfkQCt2hgH576FjfWeIOr2B9Gk15BHVe49a+3AinsqrgIubg9cZOlJjKwgdrduJUz7rUHE3QzWvuO4Rris0P8s5UxHwsA747BQBApaX8rX3/FoYSvqmxQDQ5bFEtd7H+OnqAex/cySyBkGuXO6coxpKFguoV0TdfNc8rLS8jYQfu0s1czE1nGTF+MvCcyoKCAhOqOEvSCiKveJ1lTSPmB4oXChxab6vVTS/+nJ12BM9Ti2AYZdhSJ0JRAJjPzoZ2tOQ5TstW2P+bWyez/YjANkKTyUcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/moazRnu69iWeEmiqzFhD2zxzEZp2x2LP0kqcEDZ2RE=;
 b=Y+TYhcZ3DuR2rZgMS4OU2UVIKvi9RmT75Th7LmaxYHvp2fR1LQY8g3+lVng3M3U1D3V+eGKHybtL/Ik3v9nu8Q0+hi9tFoc1IEA0uInjfJsh14qRL0dTZCNnj4e5jtA9kHT3jCwrW6JZBIxvsrtFgYnK0xufB2irEwYe/htKnbJaze09ag30tzNvX85vJJzWiueSphpwD3/ymfeOfN9bwLd1aA3P+kZrdMq2WTDvIuJu1I37MIDzCXgOHTjLW7fQI88yrsF3d6DRYHhDdZb8IdlZJQmp2P0+DW3yvz04pwNVpijKqFnVPNFzgM+y4lMFQxXu023h9KLkKH/GBXegAQ==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 16:21:01 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:21:00 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v8 0/9] imap-send: make it usable again and add OAuth2.0
 support
Thread-Topic: [PATCH v8 0/9] imap-send: make it usable again and add OAuth2.0
 support
Thread-Index: AQHb0LWq4dz3X9KeCUyUpw+GXN7AbQ==
Date: Thu, 29 May 2025 16:21:00 +0000
Message-ID: <20250529162020.45187-1-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|MA0PR01MB7067:EE_
x-ms-office365-filtering-correlation-id: a70c5a1b-b61e-49fa-8bdd-08dd9ecccd24
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|38102599003|12121999007|19110799006|461199028|7092599006|8060799009|8062599006|15080799009|41001999006|102099032|1602099012|440099028|4302099013|3412199025|10035399007|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?Ge1cjPU42Xx+f6DC6rN1j7FbdABU21wnBqSh9LlEmixzhJyIYGkK9tATqe?=
 =?iso-8859-1?Q?g6rw0QoijfYumlKc5Y+AqSh9xumY2971hlbBab0TFWNZbrxOVt8FTG4y5Z?=
 =?iso-8859-1?Q?oazEcP5XJL55llrw9x8S1Rg6oG1otT62B5ayd3wZn6mL3MJ83ciAa1XKdu?=
 =?iso-8859-1?Q?emFE76rNAcm+1WJ7Z6q6UPOO4Ai+kX5SOsc8lW8m2ipR4CcV6mp3WvfuRx?=
 =?iso-8859-1?Q?+8Rh9lfEUSM2aavSpWiI11ZD5udXlNBGGbLwFO/UEwuY8H/RFhVMcQ8GmJ?=
 =?iso-8859-1?Q?ojDS2fy2DQaQ08U1noihdssCJlYSx7vTHj8/NiiTdf3UkPdoJ4XCOsZ40S?=
 =?iso-8859-1?Q?UlDxO65FRJOdIUCYU7sT2Th/06xY6JZqWBnzs0au+G4jHTQbh904m2/EZY?=
 =?iso-8859-1?Q?7uAuCSpv01wezwTDsVwvvyKcQdDhEfdGVcOTIBA2jV4/KWmyWjdbiS1hI0?=
 =?iso-8859-1?Q?uMD2if6UqU7YVZIyBN/MFmJRwlioM8aMIyehZEWS47EFXA0TMOiaFVPhFF?=
 =?iso-8859-1?Q?2rFLAaIseN25aXpyhjg5/Rvq8zc4Yvnhzgy1ELt9jx8mg1o/Yn/vcqa9Zu?=
 =?iso-8859-1?Q?8E4Bb4tlzmRYNLSs3ZlP5lJAzEOzGXty5vE2eb3+3NaVSKquk4E4RtBysv?=
 =?iso-8859-1?Q?qTIFsIskUVbuypuqdfjKP6PlS2hYWW65NpoupWcIaOUVdwgGxK1zm180rD?=
 =?iso-8859-1?Q?55lG73jUfrpafp/9QuS9I4UvUf3+PiuuRisZV8SBmgZftrwoLjy3KHVv0m?=
 =?iso-8859-1?Q?IKvilcBI53GAMNom6ImQTfs+4GoHfPBj1eR4DuE6lLr1EwTfZa7ywk/Hmm?=
 =?iso-8859-1?Q?NpsHj2M+m65Ff92IBVXBxi0CBbXmhL2Uaf67s3z92xwlf2rKduLXtreFnL?=
 =?iso-8859-1?Q?rXpmRGDnKCL5grLfdn8A7105wXisWklA+m8o2Ys+7vQjjctp79X6BNoq8i?=
 =?iso-8859-1?Q?PMkouK9zQG/rj5HE8pRV/K/DGlxvWzTxOKLBvZB1ZUdK6rJGICuzMc31Oe?=
 =?iso-8859-1?Q?q1gbiF5evIhufRWP3sDCL5imCF1RczI2tqL77emeFvbe/bckWta0Cq5aA3?=
 =?iso-8859-1?Q?gLmyVJ+yclsiO0ZkCnovhx9JZcuQY4QNEWSCEnrDRZEFx2qHAZvQJt8sUa?=
 =?iso-8859-1?Q?J2/ElikW+mbWc+fk1VvVbYFcfZB6eLCVD6LdRPTcheS7iRGrR7LbCiWDxY?=
 =?iso-8859-1?Q?9npUJiZ31qP8aFg0u5m4tlsoANmuDhUhFfGA0ul7cXBgTZnU4hD8f7s+SU?=
 =?iso-8859-1?Q?23lG+n0aiLzK/c0dqbbzDdODXyibjESICTzo0vz2Ovz52FWg2d7dAMCsYR?=
 =?iso-8859-1?Q?TytI0QsbS0H475X7j26vg4z+u761lOCJKWCK1fPMs5J1QmR6hRm4htrd2v?=
 =?iso-8859-1?Q?8WxDpnZyE2hzGhWlH06WrzRbnD+kf4Ll6o2pdfsjvnWo/ftVjBKfUFSFWw?=
 =?iso-8859-1?Q?0oG+8AuEAbiemd0D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?/uLquVBTW4fO88s+xomOnn3MzPpNqYproKTRNlpeQ0nZuL7d/RAMnHp7OD?=
 =?iso-8859-1?Q?NmHFkBgQpQ7TBDSMvKCwr4tuwLRrTf4b438w5846BrOg8tIsbP7zAI+k1Y?=
 =?iso-8859-1?Q?kAzGBydQ2yqSMKOpSTxoHlvQKSX7SSFaNPy5FLBVQepm0FGB2Tt+zMNhbk?=
 =?iso-8859-1?Q?UeoqvY6sMvmlu8a2lTjGiGeG4rTL6HtFnA2kAovRMHrlpl83IWe/wrz8qo?=
 =?iso-8859-1?Q?Wi9Z717gtT15H8fwdComxvrnvvuvmK0oANe50XDwgrgyGF6ddgzpGoasQT?=
 =?iso-8859-1?Q?h1M7RcYJezQkpLW3ExPVwJ6/kl97VGL5Jj02Yia06meAh2Rng5Amh/jmNu?=
 =?iso-8859-1?Q?FVDf3V3YZnhxg28x1q8F6c7NkH9Gf+kynrK+ytBfy7yYDHkTgwV0TWWWs/?=
 =?iso-8859-1?Q?Xveum6CU/CWycETuubgYpj0hAWMaiFHI4pYF2YZeQeVKmVJWp+DI3KEcUk?=
 =?iso-8859-1?Q?lhw82dRvdM6KCxJemicD9L4NQPa4aZzn3yJ0X4A8PFNgjz18JLqZ+1Qnfz?=
 =?iso-8859-1?Q?J7SHs0Yp3G7mtpdQnZnn33nmCsYpDX2UPDvSztKI+UUCnZ6hBDYjLLTECJ?=
 =?iso-8859-1?Q?L9C4mMKt71GvSfgk5TKQvMpRB1g6XS87GZcu4RUb2QuZyf+TyJUn3PRhAH?=
 =?iso-8859-1?Q?p4Uh5RK8gcUsRH99XPmmud8uIVTBQ91zxla0EbB+RncYEcUBfHAA7lQju1?=
 =?iso-8859-1?Q?ZOHutGy9UZXs4SVYbz9YCrtFCc/WRwlk2DuqNZ06MgGv9ugLNWVHvNEf3H?=
 =?iso-8859-1?Q?bmNETv2Bt/fenSXsAXHKyp9o4Po8RuqFq74wRysnhlrVgEMvVTKK4m8Gz9?=
 =?iso-8859-1?Q?FB/CvMGwzlR4rfT6CgywaACSZ2JBY3IWFa2UJ+knwXmcUxLPMlrmNAiuwg?=
 =?iso-8859-1?Q?djBmHH9PwY1BaKUiSy+o1OfUb1lw9m/V2neayjjk41NKaOc6y/8ER65NiO?=
 =?iso-8859-1?Q?OE36L3DSE0QmhUy2ZjhuPY+kSmV32sa69kx4M6DmZRaghiygBEQTM9TnZf?=
 =?iso-8859-1?Q?LV9UXgYr6gqkriulEtFysj9o6tft+LeVBaMQ9OZh4ubuoUosQHZlQreHkC?=
 =?iso-8859-1?Q?xiig30fG8OKeQF50Djn0e5LtQw4V2wTuPp3UdqxS/OBsTpjP5O+0jnJZeT?=
 =?iso-8859-1?Q?VB0IrOwlqmebf51aCFCMbCq9pwI2U+Nb1PlUFrxL60PXEQEZyLxU+PwaPh?=
 =?iso-8859-1?Q?qzK2FcjUJYPJEzd+0hvREX2BYRsLpEkjkRMv4wv+/BBDMyze7vYOEfXbZa?=
 =?iso-8859-1?Q?6srfqok9NVzfVJIyFmVq2zKktT0015Kse9lwuLILU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a70c5a1b-b61e-49fa-8bdd-08dd9ecccd24
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 16:21:00.8309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7067

This patch series does the following things:
Firstly it basically makes the imap-send command usable again since it
was broken because of not being able to correctly parse the config file.

Further it adds support for OAuth2.0 and PLAIN authentication to git
imap-send.

Last, it does some minor improvements including adding the ability to
specify the folder using the command line and ability to list the
available folders by adding a `--list` option.

P.S.: I am surprised this thing even exists xD.

v2: - Added support for OAuth2.0 with curl.
    - Fixed the memory leak in case auth_cram_md5 fails.
v3: - Improve wording in first patch
    - Change misleading message if OAuth2.0 is used without OpenSSL
v4: - Add PLAIN authentication mechanism for OpenSSL
    - Improved wording in the first patch a bit more
v5: - Add ability to specify destination folder using the command line
    - Add ability to set a default between curl and openssl using the confi=
g
v6: - Fix minor mistakes in --folder documentation
v7: - Fix spelling and grammar mistakes in logs shown to the user when runn=
ing imap-send
    - Display port alongwith host when git credential is invoked and asks f=
or a password
    - Display the destination mailbox when sending a message
v8: - Drop the patch that enabled user to choose between libcurl and openss=
l using the config
    - Add ability to list the available folders by adding a `--list` option

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
 Documentation/git-imap-send.adoc |  67 ++++-
 imap-send.c                      | 417 +++++++++++++++++++++++++++----
 3 files changed, 431 insertions(+), 63 deletions(-)

Range-diff against v7:
 1:  4757d0305d =3D  1:  3e3ddf7077 imap-send: fix bug causing cfg->folder =
being set to NULL
 2:  c4e2a5659b =3D  2:  f0743d46e1 imap-send: add support for OAuth2.0 aut=
hentication
 3:  af9aa85cab =3D  3:  b1602644b7 imap-send: add PLAIN authentication met=
hod to OpenSSL
 4:  2ca10774db =3D  4:  49790e60cc imap-send: fix memory leak in case auth=
_cram_md5 fails
 5:  190bed0bff =3D  5:  2efe897379 imap-send: enable specifying the folder=
 using the command line
 7:  6a839e5f4d =3D  6:  8f6676a046 imap-send: fix numerous spelling and gr=
ammar mistakes in logs
 8:  a60d8f458f =3D  7:  69fdae55cd imap-send: display port alongwith host =
when git credential is invoked
 9:  5db5b64a3b =3D  8:  187dbccd03 imap-send: display the destination mail=
box when sending a message
 6:  469c05321b !  9:  03d7d6a772 imap-send: enable user to choose between =
libcurl and openssl using the config
    @@ Metadata
     Author: Aditya Garg <gargaditya08@live.com>
    =20
      ## Commit message ##
    -    imap-send: enable user to choose between libcurl and openssl using=
 the config
    +    imap-send: add ability to list the available folders
    =20
    -    Currently, imap-send allows the user to choose between libcurl and
    -    openssl in case Git is compiled with both libraries only using the
    -    command line, and no option to set a default using the config is
    -    available. Add support for the same.
    +    Various IMAP servers have different ways to name common folders.
    +    For example, the folder where all deleted messages are stored is o=
ften
    +    named "[Gmail]/Trash" on Gmail servers, and "Deleted" on Outlook.
    +    Similarly, the Drafts folder is simply named "Drafts" on Outlook, =
but
    +    on Gmail it is named "[Gmail]/Drafts".
    =20
    -    Signed-off-by: Aditya Garg <gargaditya08@live.com>
    +    This commit adds a `--list` command to the `imap-send` tool that l=
ists
    +    the available folders on the IMAP server, allowing users to see
    +    which folders are available and how they are named. A sample outpu=
t
    +    looks like this when run against a Gmail server:
    =20
    - ## Documentation/config/imap.adoc ##
    -@@ Documentation/config/imap.adoc: imap.port::
    - 	Defaults to 143 for imap:// hosts and 993 for imaps:// hosts.
    - 	Ignored when imap.tunnel is set.
    -=20
    -+imap.usecurl::
    -+	A boolean to choose whether to use libcurl or not to communicate
    -+	with the IMAP server.
    -+	Ignored if Git was built without `USE_CURL_FOR_IMAP_SEND` option
    -+	or with `NO_OPENSSL` option set.
    -+	`--[no]-curl` argument will override this option.
    -+
    - imap.sslverify::
    - 	A boolean to enable/disable verification of the server certificate
    - 	used by the SSL/TLS connection. Default is `true`. Ignored when
    +        Fetching the list of available folders...
    +        * LIST (\HasNoChildren) "/" "INBOX"
    +        * LIST (\HasChildren \Noselect) "/" "[Gmail]"
    +        * LIST (\All \HasNoChildren) "/" "[Gmail]/All Mail"
    +        * LIST (\Drafts \HasNoChildren) "/" "[Gmail]/Drafts"
    +        * LIST (\HasNoChildren \Important) "/" "[Gmail]/Important"
    +        * LIST (\HasNoChildren \Sent) "/" "[Gmail]/Sent Mail"
    +        * LIST (\HasNoChildren \Junk) "/" "[Gmail]/Spam"
    +        * LIST (\Flagged \HasNoChildren) "/" "[Gmail]/Starred"
    +        * LIST (\HasNoChildren \Trash) "/" "[Gmail]/Trash"
    +
    +    For OpenSSL, this is achived by running the 'IMAP LIST' command an=
d
    +    parsing the response. This command is specified in RFC6154:
    +    https://datatracker.ietf.org/doc/html/rfc6154#section-5.1
    +
    +    For libcurl, the example code published in the libcurl documentati=
on
    +    is used to implement this functionality:
    +    https://curl.se/libcurl/c/imap-list.html
    +
    +    Signed-off-by: Aditya Garg <gargaditya08@live.com>
    =20
      ## Documentation/git-imap-send.adoc ##
    -@@ Documentation/git-imap-send.adoc: OPTIONS
    +@@ Documentation/git-imap-send.adoc: SYNOPSIS
    + --------
    + [verse]
    + 'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
    ++'git imap-send' --list
     =20
    - --curl::
    - 	Use libcurl to communicate with the IMAP server, unless tunneling
    --	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEN=
D
    -+	into it.  Ignored if Git was built without the `USE_CURL_FOR_IMAP_SE=
ND`
    - 	option set.
     =20
    - --no-curl::
    - 	Talk to the IMAP server using git's own IMAP routines instead of
    --	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
    -+	using libcurl.  Ignored if Git was built with the `NO_OPENSSL` optio=
n
    + DESCRIPTION
    +@@ Documentation/git-imap-send.adoc: OPTIONS
    + 	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
      	set.
     =20
    ++--list::
    ++	Run the IMAP LIST command to output a list of all the folders presen=
t.
    +=20
    + CONFIGURATION
    + -------------
    +@@ Documentation/git-imap-send.adoc: authentication as described below=
.
     =20
    + [NOTE]
    + You might need to instead use: `folder =3D "[Google Mail]/Drafts"` if=
 you get an error
    +-that the "Folder doesn't exist".
    ++that the "Folder doesn't exist". You can also run `git imap-send --li=
st` to get a
    ++list of available folders.
    +=20
    + [NOTE]
    + If your Gmail account is set to another language than English, the na=
me of the "Drafts"
    =20
      ## imap-send.c ##
    -@@ imap-send.c: static int git_imap_config(const char *var, const char=
 *val,
    - 		return git_config_string(&cfg->auth_method, var, val);
    - 	} else if (!strcmp("imap.port", var)) {
    - 		cfg->port =3D git_config_int(var, val, ctx->kvi);
    -+	} else if (!strcmp("imap.usecurl", var)) {
    -+		use_curl =3D git_config_bool(var, val);
    - 	} else if (!strcmp("imap.host", var)) {
    - 		if (!val) {
    - 			return config_error_nonbool(var);
    +@@
    + #endif
    +=20
    + static int verbosity;
    ++static int list_folders =3D 0;
    + static int use_curl =3D USE_CURL_DEFAULT;
    + static char *opt_folder =3D NULL;
    +=20
    +-static const char * const imap_send_usage[] =3D { "git imap-send [-v]=
 [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
    ++static char const * const imap_send_usage[] =3D {
    ++	N_("git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] <=
 <mbox>"),
    ++	"git imap-send --list",
    ++	NULL
    ++};
    +=20
    + static struct option imap_send_options[] =3D {
    + 	OPT__VERBOSITY(&verbosity),
    + 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the =
IMAP server"),
    + 	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP f=
older"),
    ++	OPT_BOOL(0, "list", &list_folders, "list all folders on the IMAP ser=
ver"),
    + 	OPT_END()
    + };
    +=20
    +@@ imap-send.c: static int buffer_gets(struct imap_buffer *b, char **s=
)
    + 			if (b->buf[b->offset + 1] =3D=3D '\n') {
    + 				b->buf[b->offset] =3D 0;  /* terminate the string */
    + 				b->offset +=3D 2; /* next line */
    +-				if (0 < verbosity)
    ++				if ((0 < verbosity) || (list_folders && strstr(*s, "* LIST")))
    + 					puts(*s);
    + 				return 0;
    + 			}
    +@@ imap-send.c: static int append_msgs_to_imap(struct imap_server_conf=
 *server,
    + 	return 0;
    + }
    +=20
    ++static int list_imap_folders(struct imap_server_conf *server)
    ++{
    ++	struct imap_store *ctx =3D imap_open_store(server, "INBOX");
    ++	if (!ctx) {
    ++		fprintf(stderr, "Failed to connect to IMAP server.\n");
    ++		return 1;
    ++	}
    ++
    ++	fprintf(stderr, "Fetching the list of available folders...\n");
    ++	/* Issue the LIST command and print the results */
    ++	if (imap_exec(ctx, NULL, "LIST \"\" \"*\"") !=3D RESP_OK) {
    ++		fprintf(stderr, "Failed to list folders.\n");
    ++		imap_close_store(ctx);
    ++		return 1;
    ++	}
    ++
    ++	imap_close_store(ctx);
    ++	return 0;
    ++}
    ++
    + #ifdef USE_CURL_FOR_IMAP_SEND
    + static CURL *setup_curl(struct imap_server_conf *srvc, struct credent=
ial *cred)
    + {
    +@@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc,=
 struct credential *cred)
    + 	if (!path.len || path.buf[path.len - 1] !=3D '/')
    + 		strbuf_addch(&path, '/');
    +=20
    +-	uri_encoded_folder =3D curl_easy_escape(curl, srvc->folder, 0);
    +-	if (!uri_encoded_folder)
    +-		die("Failed to encode server folder.");
    +-	strbuf_addstr(&path, uri_encoded_folder);
    +-	curl_free(uri_encoded_folder);
    ++	if (!list_folders) {
    ++		uri_encoded_folder =3D curl_easy_escape(curl, srvc->folder, 0);
    ++		if (!uri_encoded_folder)
    ++			die("Failed to encode server folder.");
    ++		strbuf_addstr(&path, uri_encoded_folder);
    ++		curl_free(uri_encoded_folder);
    ++	}
    +=20
    + 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
    + 	strbuf_release(&path);
    +@@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc,=
 struct credential *cred)
    + 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
    + 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
    +=20
    +-	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
    +-
    +-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
    +-
    + 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
    + 		http_trace_curl_no_data();
    + 	setup_curl_trace(curl);
    +@@ imap-send.c: static int curl_append_msgs_to_imap(struct imap_server=
_conf *server,
    + 	struct credential cred =3D CREDENTIAL_INIT;
    +=20
    + 	curl =3D setup_curl(server, &cred);
    ++
    ++	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
    ++	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
    ++
    + 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
    +=20
    + 	fprintf(stderr, "Sending %d message%s to %s folder...\n",
    +@@ imap-send.c: static int curl_append_msgs_to_imap(struct imap_server=
_conf *server,
    +=20
    + 	return res !=3D CURLE_OK;
    + }
    ++
    ++static int curl_list_imap_folders(struct imap_server_conf *server)
    ++{
    ++	CURL *curl;
    ++	CURLcode res =3D CURLE_OK;
    ++	struct credential cred =3D CREDENTIAL_INIT;
    ++
    ++	fprintf(stderr, "Fetching the list of available folders...\n");
    ++	curl =3D setup_curl(server, &cred);
    ++	res =3D curl_easy_perform(curl);
    ++
    ++	curl_easy_cleanup(curl);
    ++	curl_global_cleanup();
    ++
    ++	if (cred.username) {
    ++		if (res =3D=3D CURLE_OK)
    ++			credential_approve(the_repository, &cred);
    ++		else if (res =3D=3D CURLE_LOGIN_DENIED)
    ++			credential_reject(the_repository, &cred);
    ++	}
    ++
    ++	credential_clear(&cred);
    ++
    ++	return res !=3D CURLE_OK;
    ++}
    + #endif
    +=20
    + int cmd_main(int argc, const char **argv)
    +@@ imap-send.c: int cmd_main(int argc, const char **argv)
    + 	if (!server.port)
    + 		server.port =3D server.use_ssl ? 993 : 143;
    +=20
    +-	if (!server.folder) {
    +-		fprintf(stderr, "No IMAP store specified.\n");
    +-		ret =3D 1;
    +-		goto out;
    +-	}
    + 	if (!server.host) {
    + 		if (!server.tunnel) {
    + 			fprintf(stderr, "No IMAP host specified.\n");
    +@@ imap-send.c: int cmd_main(int argc, const char **argv)
    + 		server.host =3D xstrdup("tunnel");
    + 	}
    +=20
    ++	if (list_folders) {
    ++		if (server.tunnel)
    ++			ret =3D list_imap_folders(&server);
    ++#ifdef USE_CURL_FOR_IMAP_SEND
    ++		else if (use_curl)
    ++			ret =3D curl_list_imap_folders(&server);
    ++#endif
    ++		else
    ++			ret =3D list_imap_folders(&server);
    ++		goto out;
    ++	}
    ++
    ++	if (!server.folder) {
    ++		fprintf(stderr, "No IMAP store specified.\n");
    ++		ret =3D 1;
    ++		goto out;
    ++	}
    ++
    + 	/* read the messages */
    + 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
    + 		error_errno(_("Could not read from stdin."));
--=20
2.49.0.638.g602e07a80b.dirty

