Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010003.outbound.protection.outlook.com [52.103.67.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29949202997
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112951; cv=fail; b=m7dX1RiuuFkybkp2Au8ZBFnokXFLDNtdFm63qXCUFiGGwhAtrqzFRXnwuimFH3GjI0dCJdI7bdwY8DHphRKfBJ9Zqc/AlnnO0coWXdg92zsF+IocA+0/fS3F1hbetmypgRAn9i6N7Z+vz1j+IqFdC3r29BpfR7JWj3wSVS9PGA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112951; c=relaxed/simple;
	bh=60Wujm626cdP/GNxMbtPmJLAHjBWF6c82A04tFbDxAM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BB7uJ26BPX2RFX8femn2QaL5GYF5N0fJMdNb6mRGK4mY7FpqkWOgBNFTiuWtCUUtVgdDxThZpPyMSN8uCevJY+jQOWs0NKs/LSHQbD4oUIHzEI/jW4ZPI6r92uAxipy4LZk6nHRjB0KaSUMPB0EQb7v84sUYO2wkFodF1AElHV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=X8GxEMCe; arc=fail smtp.client-ip=52.103.67.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="X8GxEMCe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9p4IPJmzqkThSVqITGdg38b0N0e9XfZr3L1XNhzDmjIf5IfA87oI3SgCce4x54w+wqIk66gld2zy3SVISb5rlBZdE9mezW7ePVZNMrUMNpkzCSC2WMApg9MO64ZRDXd3UpQP7iYbrEHxWqq7SqpNBbRB0U7WfLvfvga/TUnP58GmD8us22OgB5EdH43OWB/XdBfe9Toda5JxvW7fhfPzfc7FYxtfG28qe8u2k3zFR104JTlZj1yZlFIxQhzMuzNAZROyN4vas35127beJ5RPFLmKWl/bf2VibrOvPnoOBkq+gS3LyMCiA0NMvexhGWl9SOyGEjjrB2OV9HG8xFDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PvI1+23UUG8yxwnIF5s8/YjE8rMiOVkToHP5LqrZp0=;
 b=R1bhGvk6Pqf0gD3qq3bcFGUtSGDL66vKsl8fyAUJAz7KR4CeQiDZArcRImbHTK2P6qm03xK+O0khTx9RmeFzB837IAj3JkS+PAt4eSb2eGr3QA8ubkZjl7g81YYVUXn5nWfmZ/XbrqpA9X0FgzO9bdiEV4lhktNNuAN1Vuavq48HmHNXgLCBmw9XKb2b+ELwPtegB9p6492EWyPsgl6eMkF/XgdDQuG+jh9Hzs5EdU5IsT2Qln8/eq9Qvm1S6hUky16J/w5avkda1KoAx5LbZQuKEHB1wUGFN/FBxT5UdUnPcHMAsKIO1pwdAFw88wEOW4hOxdH8aw86BxY6pjNfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PvI1+23UUG8yxwnIF5s8/YjE8rMiOVkToHP5LqrZp0=;
 b=X8GxEMCeVCDvE318baOoPoKzN4VuiGMvdlrvu7A6RO6Qn5Cd0uRR1oupyWTFQ2Pu730LLH8CmK2nsgC8w1VHl6LaHMDu4YbSdtXICwh4JeM7tDhFnOD9OljOxEaOHSStoQCZliKp2q4fmYDdoK6qCZacIH+v4MAK3a+mIxkxOm59sxZESTm+CrXwEogTKLdEcB93OX+5KJHtQgoyIMXsASwrWnqmPNNJ5RMy62Sr4ayit3oJ27tEsLUOd0+qJFfOgeNouvkssBNp+rlddPY6as3fmj8TMOzyQ4qwyZqcCC5fpGSDqtKCgnJVxI1hYzBZS6t0nU2jRYIE1CcrjrWknQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPFFC37E0415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 08:42:23 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 08:42:23 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v13 00/10] imap-send: make it usable again and add OAuth2.0
 support
Thread-Topic: [PATCH v13 00/10] imap-send: make it usable again and add
 OAuth2.0 support
Thread-Index: AQHb1fXBcFdovuckXEaD7yRtm75J5Q==
Date: Thu, 5 Jun 2025 08:42:23 +0000
Message-ID: <cover.1749112640.git.gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PPFFC37E0415:EE_
x-ms-office365-filtering-correlation-id: 1b259dc7-c016-4101-d810-08dda40ce478
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|8022599003|461199028|7092599006|8060799009|8062599006|15080799009|19110799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SOsCTPSWX5QiwQAiifmb41kUnd/ZM8vgnSPE+0Epx1sZ9HtACBUXjNfx4x?=
 =?iso-8859-1?Q?HyycCScz3Tdk7qEK269+zA4Q9mwRmRRB6HPVn71nsyBksfReCJb8tAhLrL?=
 =?iso-8859-1?Q?ejCTI9T3u6BjvW9jktPEPfNOEEKvbZpLehjrw3rBiUlQZ85KtO1EMtLFB1?=
 =?iso-8859-1?Q?QtLRRCYudpwBnKZXU4pYF2MiTJm2BnyZQ062zlrbJis6m+IA0ydmPOMal7?=
 =?iso-8859-1?Q?nNCXyDzt5YdM1dR5eGCP6SaLLQaquu2GvZxumoyoGWc531IrOr8DrqZ5GP?=
 =?iso-8859-1?Q?2FLL+sMdAr5c1HI+OVX4qx6ykv/49IHs8GKICzA5ucGJJl3L7WiO3QbH0f?=
 =?iso-8859-1?Q?a3RBcGCd4QV+gS8franqfi/ncyYHy8nfWkrPrvX86Eg8XGYZ0sJEPuAg3W?=
 =?iso-8859-1?Q?v5xDdN4k7jVfjYIb1SeRS62MIuDo71glkHkwuPedGs+/A9F8RQ1GZMFX5G?=
 =?iso-8859-1?Q?Lrxn6IX/vLyLpLTRNbbvkyNhJ9L0rVBNEuWxuYrQWV+jUFL6WkBoUZ7m3O?=
 =?iso-8859-1?Q?ilYgIskxbFCZDXfYZMlkmc8iHTRIivdsJ6MMFVuXAW9JmdDkGStq2ddgs0?=
 =?iso-8859-1?Q?T3kWObVBnqNevjtK5nsJxZxaRYbchLQtq77b3N37W0dTGSqnQP3QVKfynr?=
 =?iso-8859-1?Q?m7Qxu3xVjfDrx/ncCBAh3YVjqmuexG1XNO/MCreyIZAbjbhhtgYxMtmoAI?=
 =?iso-8859-1?Q?jCBZ10isqltMknEenErEKoMUfpvrZ9Rc5yFjKxiReNUiMWpNIz1yKZZFh7?=
 =?iso-8859-1?Q?Qkku3hlyCAUyIdmDs2aYemR3Ynq/bx1R+Kz9BrxVwxdnvT3axLwbmSTafA?=
 =?iso-8859-1?Q?tc3QWyFq/ZOq0wXbWdoNh+/1RB7YDMzNJv4oeIQiTzo010VEl7y37OyMIL?=
 =?iso-8859-1?Q?bDrJiogoI09etBPsIEqND7S7q2Ivl61+mZ5OGjNsvO8wWblaSogVFqFnNz?=
 =?iso-8859-1?Q?+8r0PhKc//6Jeqz+qTpMsgZDcqTSSJer76qoPMm1N4MUuisr/20M860dT4?=
 =?iso-8859-1?Q?dwUPmiDRGbJ7QA0NdKFZaKRGS8+16ZxzJV1iWKZ/dFLV1/7X+p/CeObTXS?=
 =?iso-8859-1?Q?V3q2s2Nqkqii+zaKnS+acKt13I4ZUVfZXoSh0+cDo0LDDnKMKH0XkMMt1u?=
 =?iso-8859-1?Q?5FYnhUkk0CM0bQWDuudlBQpiWsjKJaZVt+4taLSfXwdivP/ObOVKTSqIDH?=
 =?iso-8859-1?Q?Ml65SpK5xveZ4+Y7+4ENiHFUyIluNe44k8M=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jmPhf7qMQ5sYnlsQ3AhdtgZwcqll4SgrLPGo7OLWnNRaRlxYAetQ2ZBHbw?=
 =?iso-8859-1?Q?ec1Paqc64/48IuwlWydIfj+K0fIqNoKw5rq6T8ukSScI4i0pRiZwXmaYEL?=
 =?iso-8859-1?Q?xk1WP+D7KAuapgdkjiQHLp071TZFuDtoBAWmyw/a0wbEJMFbiCnaCrHf8R?=
 =?iso-8859-1?Q?NDaiZ9VuBMes/XNht0XUWinpo92uAcbbsjlYm5WT9meZ/fLO9AMBNt6/w7?=
 =?iso-8859-1?Q?vn6DFjsEdG2plvfbefCAJ/WdRzvqd+6IRzfM4zibMXQGnnk3aM9tOEm5Aj?=
 =?iso-8859-1?Q?lEMNFUjPAXi6XnBeFil6pNFJi/OFU6OSmpcdE/XvBAkjoUPc3nOkyMLB4R?=
 =?iso-8859-1?Q?9l6icJvl2+wKzHnXUhbdiVrv59cmM8qN1k2k7bUZ/xyZ7OdPoJhx9hHO/b?=
 =?iso-8859-1?Q?SNGozwpvkeqo4BV686OAEHMsmXoOPhFB4D65hs+BtPlQu1AnoIJd6YoAyU?=
 =?iso-8859-1?Q?N0bD2+/SsPIW8Llrnj3TSwk7XkNmznWD4/c0DeNkvQxNIFpoGbkojUaDQO?=
 =?iso-8859-1?Q?CDv3uhViH3EEP5ZY2ZQxWQqFpvgx/0SKPuzQfpUqQ5Fs4oFV4oqfyirqtS?=
 =?iso-8859-1?Q?7KZxN4o5PilBxdO6EqN0fA/CYXw1EoXMGfZNwNVcmTkDX0m34/gUnqBeBx?=
 =?iso-8859-1?Q?O+YIBAHeXjHApCsnz79jVUBsVlFtom9fPHbu5M+ErXuk1qw8vCpktj1ipq?=
 =?iso-8859-1?Q?VrW3xXZF5Hp9aGzidEcyYYna75NhmN+8TBDaDH30FVzgdKJD4z+Nw7cK4C?=
 =?iso-8859-1?Q?1zlVmlf3J1HrA4Jqcxcgjw+ujoOAkQLclGXjzUr/034B5YnQnoJHpFtwuj?=
 =?iso-8859-1?Q?eE7LN+IjkEESSWUZqbI197IRQ9rGPWi/i5f8mKbzaJ+OICcR1AeXlzPLZ9?=
 =?iso-8859-1?Q?FoYn8axCkbU3p8hfG9R4KeCWb2ERMgVEHMtQ4B7eako10YvIx7cO6c5UBM?=
 =?iso-8859-1?Q?dnyj25PRUY9puiaG9wJhn9z3UtXb0iZOpzBn6zZGzWwlymZexaxQlPCcwD?=
 =?iso-8859-1?Q?JjIa4sGfl6q1/W9xcm3phjg/orFBElOjBhQ9N3T7Pe05CHzXDRRCyqXTNY?=
 =?iso-8859-1?Q?AqSUdrPzCraz/ABU2Q1fwBhJdgQtxci80zVoocMcKUxeKskYVwem/HsdZ+?=
 =?iso-8859-1?Q?kcA5JeY6nAnBnsGL9N9IWxktk185RT4y45zf1cs8yRfjfFQ1a0J/kH7M7C?=
 =?iso-8859-1?Q?vMAzXoOHcdV1pcxd0uTue8NE9YTBQE0Pp93n8s/ZJ418loCGbjergNhgHu?=
 =?iso-8859-1?Q?rpqQvzHTNO0MFXyW6cHcNbAaEXr0ZFXa0N1up/ez8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b259dc7-c016-4101-d810-08dda40ce478
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:42:23.5772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPFFC37E0415

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
v12: - Gracefully exit PLAIN, CRAM-MD5, OAUTHBEARER and XOAUTH2 authenticat=
ion methods
       if OpenSSL support is not compiled in, but is requested by the user.
     - Use backticks for string literals.
     - Wrap documentation text to 75 columns.
     - End the last member of enum CAPABILITY with a trailing comma.
v13: - Fix logic error which was using || instead of && when checking if
       the authentication method is neither XOAUTH2 nor OAUTHBEARER.

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
 imap-send.c                      | 425 +++++++++++++++++++++++++++----
 3 files changed, 441 insertions(+), 63 deletions(-)

Range-diff against v12:
 -:  ---------- >  1:  3e3ddf7077 imap-send: fix bug causing cfg->folder be=
ing set to NULL
 1:  ab12f713d2 !  2:  0d28e337cf imap-send: add support for OAuth2.0 authe=
ntication
    @@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, =
struct crede
     -	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
     +
     +	if (!srvc->auth_method ||
    -+	    strcmp(srvc->auth_method, "XOAUTH2") ||
    -+	    strcmp(srvc->auth_method, "OAUTHBEARER"))
    ++	    (strcmp(srvc->auth_method, "XOAUTH2") &&
    ++	    strcmp(srvc->auth_method, "OAUTHBEARER")))
     +		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
     =20
      	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
 2:  ba9c3fb756 =3D  3:  d934bdcb82 imap-send: add PLAIN authentication met=
hod to OpenSSL
 3:  3d1a66da57 =3D  4:  f2773c646f imap-send: fix memory leak in case auth=
_cram_md5 fails
 4:  70bb9388b8 =3D  5:  c111ee6bc1 imap-send: gracefully fail if CRAM-MD5 =
authentication is requested without OpenSSL
 5:  0d00a5e135 =3D  6:  f12713f24b imap-send: enable specifying the folder=
 using the command line
 6:  999c65438f =3D  7:  d38caeae5e imap-send: fix minor mistakes in the lo=
gs
 7:  d0315aebd4 =3D  8:  3ba02f2b0c imap-send: display port alongwith host =
when git credential is invoked
 8:  73352a18cf =3D  9:  6dbd0bf0bc imap-send: display the destination mail=
box when sending a message
 9:  36d50d01f0 =3D 10:  f77f2423e1 imap-send: add ability to list the avai=
lable folders
--=20
2.49.0.639.gf77f2423e1

