Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E95242D98
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415942; cv=fail; b=f6WXZPhSZ17BJqBGvlkXL54uAJ0OBH0lRtBe67+usYoXEO5TJVWmuWizaRosBInVB2OZTn7IqKWnV4EaBxneB6Q4v+o2UebDN8wTcvKocNdGesUM44fumj9w/k8MUwZvWzmdcu2FZThJNUzRnoRCte10U/RIKXgtggo3gX3WbWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415942; c=relaxed/simple;
	bh=J7BTRcqVC6Nh4lfBbJ7tFs5L6VmuWPUoPw6DCO1sVv0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MWvfxufMOnnbSV3HCupdYmS3NZF+yvCaFj6W8meY+d86u/CcbCEi/7cB4CLpQAFdgxjrJbDxYP7rppY5FDNuXNMcxCGK7EUj8/M4G99skg86pVQ5xUsDfCkkoe32Zu3UET/zpQ/RfArRDCqk4jRNn8/SQY/rN8dO244Q5dZffpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=AqPL4LuL; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="AqPL4LuL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYUj+roAwJtV2RGQo6R6uPLQjsdovEhpAKKGII/7IPxTV+XLdIu10YP0vQbuhKK9jof9cKSVg4+GlYcMGIVoGdXBecUkT1KaTvMYTQbHmztc3PT40AOIYvTppKPUF4mwxiTequV7LBQwFr60xMCi0XLL+h1HKofSapgoZMVUd9hyKeT0u0agtrGNDG+UAzgyZi6s7J+knGnm3vDETcEElyLtDgWOhOnnmDaI2XvWiLcu46r/OELzZqiaPLdO4Mh0RMIyFQCcLzuVxUkbcOCcxSA5azrRfZL7B8lFSRTofUIvB74572leUMt3DKMWWUcnJg7CoyRHkRwZIEdnVTjeeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gtDEqCRXBJplxTOOF6W08Z8+EfqaZGVhYMJKt9eklrE=;
 b=G2FsMqSHG/nKiSvJFrqjh5PRRAcRjCLnpFU6EVHf6giXZuWn1hEvUkod20yUOhvpYzeDoMKE517CxCuBV0Vk4Gdlj/Ojj3OWwlHtyV9f+lVEZIpgxH5A+nPvXpsKrv1lLDsgg9ihsS217WP0J+zovKOQQ3lsawX4JhiX2rCCtyhRqt9tBwPpr00DEyCmY0C3zhqtaSipbwrlN/hjdY/0VR/GB1MnRLOXpnCuk1otGZC6sqoSOAUHk/KPXaI+4fNWZgngthRihvKruqbFA0rFApANYuQRHslFj6t7nETLF3v+P59Ae8rawDSqr3+YLUHgzreIRlK243GrgPUFls/Q9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtDEqCRXBJplxTOOF6W08Z8+EfqaZGVhYMJKt9eklrE=;
 b=AqPL4LuL+JAnV0GxXruLDrYEPNOnU17OU+Zcin/kUEdeQdWCCKnvLSIDEaiKrknm0zJsKTqRLANmMU1ArWnyoKbMbyYKhgJze2Tgm+hMel92N5JpVhOUUnIJHVhWb5Mxfcuc9bI7+bQzAIGMGyflNP1o9ozytlzjqxZ2u0A9tJWp3QI2QH6vf+7pAxg+KYixqsbsjizJQkHrDzm/jlUtjEXgB0fIuslISJAk/i/e5/zf4AMw4fmhJ+W0VYPLZTrutVAueScIzAlsF7IAMbWJOX/hRyigFwWEHgaQCB28+Mt7/IZwWRojYMnTkEdqud7gyxaPdvPk3fC4C8obJZB8/g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB7259.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:05:34 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:05:34 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>
Subject: [PATCH v5 2/4] docs: improve formatting in git-send-email
 documentation
Thread-Topic: [PATCH v5 2/4] docs: improve formatting in git-send-email
 documentation
Thread-Index: AQHbz57oJD/WCXZ7hECPdkjcTXR6SQ==
Date: Wed, 28 May 2025 07:05:34 +0000
Message-ID: <20250528070521.17379-3-gargaditya08@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250528070521.17379-1-gargaditya08@live.com>
In-Reply-To: <20250528070521.17379-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNXPR01MB7259:EE_
x-ms-office365-filtering-correlation-id: 46143041-08ef-45d8-62b3-08dd9db60ad9
x-ms-exchange-slblob-mailprops:
 +b2+gf+2pHTK0hJWfIOsgR8XTzjzRgQk4SVjS83dvrl6M8WTwvPHt9JHnseTCYJxTeGKEh2RTE/Wt4p2hzStzH8pSMr1TUVR+9Bm3Mpk/MEkGFuPoXzpi9zs65BUzRbX4SWgywZF8LXIrfWY/XbFWuR5Ab4urqNyrd1/0dcXv44LOpYVmKo85YL39Ib93qGbJg/c5JSCeCKm+xDdDFJ1lfzpMtN7W+VvKk5RsdhrCD1PSQnligIPPFHeb5FnbrtgJz1JPghlm8JbP+w31pmclhlIgG/fd+P6SLAqz5U+skWd8/qFmwJ6bScGFCwMkHRMhrixtJaFEaPjk4X/Vtel/GPLsc8ELE05G5JN62LP68QrV6haotic2e2vRWNwuBSKyY/kBqIiayo4a5Rhj/nW5m56FDehymxeWAjiLYZ3nQSSmV+VLAcyuwzVasrcg3fG+4WCgahR8di/2lXzLdCO/Br0pZdRF54y3egDmANNWirR6fUOpHjXJf9NU8daBNsRNufrGdSQxr9zl5N6OlPAhDO9qwSWGAMotjepsD1J41EQ+5cAcr8T78z1k4iE8vDgoGRjV8X9Y/QYw3Jeef5/NeMyrpZGDxxah5jAYmX7Jd7KCFqBC+chlEKoCqZLFd4bgHrgzesaDLOzZ1mveUSuCUOG5xrC4Tn247oGIaOVWZlpeWRwAWVth5ZrmYvkfyWn2YSbGH/NHM1EQve6oIRmo6mPPQ99wEJqdK5MnjuUT84zPW8q/FNSYUNrJoEGpWVW4mDxg8bSMhuLdXaHMzVmK8fMJ1kIim/7ffdqSqPf16OsnDsC7iv4/Mg3Uo/FCKvhfCMQTKi4n8pDUywIccSFeI+m9+gjwjOpywgAvSruwAQ2UBTUCqz+Yw==
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|7092599006|19110799006|12121999007|15080799009|38102599003|8062599006|461199028|8060799009|3412199025|440099028|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/WX8YoIZQlgXMVTACrusM4WqmhhQeqhgL4TQUL24/peQhUd432v+zZEbJ8?=
 =?iso-8859-1?Q?2Qn6dCe113JL62NiOmCpoy+T0G05cDzwd8QqaDMAW9Q0i0od+U5NjsCI8E?=
 =?iso-8859-1?Q?NqQrG+VlsHD56/bmnzep9P7Ctk1klawhJP8Cz9eqWOuYceyT3kHov2RUV4?=
 =?iso-8859-1?Q?uJBdi1TfpHLfzC7I18wzNK23DIVSxI0DuS3lImRuxAGoXryNBZ8b6AlOU6?=
 =?iso-8859-1?Q?zJuXhZDab9yZgxu6vVOLHKs4QlZbRdHPssBlsJ9tqHJm2N2w5SYFRUS+pW?=
 =?iso-8859-1?Q?b/jBbpjUtkdqoFpgAlOItxOHYivMvmV75KB2oEar03T9ID38MS6wUm5o8u?=
 =?iso-8859-1?Q?IPy4sI8196nnBOk0ndTXPy0IhNv0NXuKLpuIavP2yMFDXo9CPbKujIsU81?=
 =?iso-8859-1?Q?ouVrkQDgHs56aF35fT04nPjVW/v8h53QPVa1eYwAfDtqno+8anRSemj0tU?=
 =?iso-8859-1?Q?t3iASpRbBhO5bzCXGhphpUf/MlrLKCK08Psfhd+JA9RnOw/HPGWqTDDZRt?=
 =?iso-8859-1?Q?x1O9sS1B2z2R1UHAW6pyacsKKVIwxDpK2DroW+rc21JylcZNsj/UHWbDFq?=
 =?iso-8859-1?Q?qMDqbppJ83mVUVWVY0m6LNiMrQSTrsiGDzatYh+Q3YoBM9X2KChkS6DSWo?=
 =?iso-8859-1?Q?PMGh7yU1XObgLjdPTfi/WHmuylfjYdW4KbNPiGGztN285TBoejVHe5HJof?=
 =?iso-8859-1?Q?JGLb0Ok1al3de+IeGtiXtvUPK/yt14Ge8RgF3uRo59iUAhFvSp8KtBXGKs?=
 =?iso-8859-1?Q?Fm7Bf2YLgjrUfNoaMxq70PUA7FmDw+uSoWutLQimzuHSGwAb+EZbIkS7MY?=
 =?iso-8859-1?Q?VEZhN6DsusTys1awLLAEZG3olLNQIJet9Dks9h6Mok7dvnvnxVoZNpQ48P?=
 =?iso-8859-1?Q?vilErC2jntVPz57RXt6dV7A0OaTO+MArTiGg4A9VilfeNTcSckwdRhDqH+?=
 =?iso-8859-1?Q?MNG8zitKKyMpNCjgPBQwg35q+3P5I5ECC/ScTGYwRz44i0Lak9URWCdTEF?=
 =?iso-8859-1?Q?Gf+T3E7lfSfZaaJRRKbaJquKyHm+PWeQ+oYYBs9hEOMpIA1XSKJFwbOt0w?=
 =?iso-8859-1?Q?y3hhBxI0UmH8tsUQhIWBOc9oQoNzLr/LDwqvUKdl6hx9Y4q+5Zyxw9Qq52?=
 =?iso-8859-1?Q?XzldymLKRjYB/NwBQxXmsoI4lGNdHEUl+dXJW0dO06BddYOucLALepbt46?=
 =?iso-8859-1?Q?eRA4o6NPSTLMC5AfuJYt9OJh5TLtUCqcRG3xx3NSL6NFvi69PI+7aGnSVc?=
 =?iso-8859-1?Q?mWN/VCLjruww7h/lIea3uJ1PoQjWEwy7jNJOd89vF1qrcjdCvraVzJtLrn?=
 =?iso-8859-1?Q?+yvw30jJ73fqB8STurTxcR0MGg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vvhCSaTlTu82OuyuxycBtoHjyL3f4kpfwiuAIiOC/k2PPLlpuvoTNPXTIn?=
 =?iso-8859-1?Q?yVxHYdUEb/jxSvbOhYei0kLQu4fL7qCwetzAdcTvwltsTY4naJK3FeyPRt?=
 =?iso-8859-1?Q?Kan41dafKdR3gX1Aav+UpgpyFMS28h3YZ79sAJpEtBybflVt/MnaTa0dVQ?=
 =?iso-8859-1?Q?WSaSOxjX9fBtCH2703hTG2/eQUZ3VLI4ETgudi10fawMRer/XRR8g7d7xE?=
 =?iso-8859-1?Q?p7QyYYFBGf+UNRfOEKJkAKYafSltEfSgV6o3R5VokI6JqRkEG+Puzdt7kd?=
 =?iso-8859-1?Q?F4snVQqjyTtuZabTZUiYyi3rGF3XCpbMd12NIB5TtkJTXerZlOwp7EWqSv?=
 =?iso-8859-1?Q?shVoKcQ+TiIiPgLcKfmnuOlDzlkdMBg34WSJtKOzNFqgdj7ywIuopv55RE?=
 =?iso-8859-1?Q?yAxf2uJ95VcMXgtEJfzIOu5ee9SGvh2YGL9pp2anIORJPIkjofefYOsys+?=
 =?iso-8859-1?Q?0laap3DvQl5ypWdm9oqMpHppQ4/WM8qm9dFM+9Z5JRl3I1nF/KcQVLjmlK?=
 =?iso-8859-1?Q?iEmmBSeDeQU5OSQoEdWU03k33VP0ruLDtcyuuGOBNakAL0JuQxciBZiqzG?=
 =?iso-8859-1?Q?EaiUSVAqoicK48qFgwbjM5T20Y/OOqrjcd547aojcgALbS3S/YETO3oyTn?=
 =?iso-8859-1?Q?OE/pA041ieSpj0lQhU8GF+1wTPGMazJoSxBJN8l3NpWsIoBQYlW/XkjhPQ?=
 =?iso-8859-1?Q?k/UY19PrAB73xVSkpkXdrHv/TQyS0bZAEMH5shrNm6WCCS1ydC7FtGRG9Y?=
 =?iso-8859-1?Q?DT8+rdMETsddps53d3MWL00WirUaWAX/7CVuaFDTj0alskBmWon/Y8DrKw?=
 =?iso-8859-1?Q?+rguvKl5eXKaevxbaULyWogg0SJK23VRctJqUAKNfm/p2CHQTxWixEYPPZ?=
 =?iso-8859-1?Q?vf9rBOmL7TB3/7xaQNReRfk4fI8zl33lOD1dkDh5OLcUmTKxLz9+39kFhg?=
 =?iso-8859-1?Q?8UdFx8+XhIKnJcdrzOl96lPgoN9+TnZwSLDGlSiqkhyMco19Yk/Kwnm1ec?=
 =?iso-8859-1?Q?dqhNj7VEsJJW7+22fKV7LuPGuzgcWkdN2A6EaCOah8Umt7bOD6Bf0by8Bg?=
 =?iso-8859-1?Q?lb/36qGUIymwbxDfMFq6aFAnuEymBRP6nnWblIHA+Kja/Mol4i6CU5br5O?=
 =?iso-8859-1?Q?xSxJgSAVhGZx9Q8lNlup59LyIxrDJ7Xf9j7oATH+og07bJC9FxzwYdM1kY?=
 =?iso-8859-1?Q?8XzaxjVapl61ljAq1XOIwO5+/SgvLxf3e8FjDJh+gb+LZaG6LEukWkcDeu?=
 =?iso-8859-1?Q?iXbD8zUVCO1y8/vXknLu/nTgtl9rgvL1T/+goKQvg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46143041-08ef-45d8-62b3-08dd9db60ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 07:05:34.7879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7259

The current documentation for git-send-email had an inconsistent use of
"", ``, and '' for quoting. This commit improves the formatting by
using the same style throughout the documentation.

Also, at some places, minor grammatical errors were fixed, and some
non existent links were removed.

Finally, the cpan links of necessary perl modules have been added to
make their installation easier.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/sendemail.adoc |   8 +-
 Documentation/git-send-email.adoc   | 181 +++++++++++++++-------------
 2 files changed, 98 insertions(+), 91 deletions(-)

diff --git a/Documentation/config/sendemail.adoc b/Documentation/config/sen=
demail.adoc
index 5ffcfc9f2a..0b1b2766f5 100644
--- a/Documentation/config/sendemail.adoc
+++ b/Documentation/config/sendemail.adoc
@@ -19,9 +19,9 @@ sendemail.<identity>.*::
 	`sendemail.identity`.
=20
 sendemail.multiEdit::
-	If true (default), a single editor instance will be spawned to edit
+	If `true` (default), a single editor instance will be spawned to edit
 	files you have to edit (patches when `--annotate` is used, and the
-	summary when `--compose` is used). If false, files will be edited one
+	summary when `--compose` is used). If `false`, files will be edited one
 	after the other, spawning a new editor each time.
=20
 sendemail.confirm::
@@ -101,7 +101,7 @@ sendemail.signedOffCc (deprecated)::
=20
 sendemail.smtpBatchSize::
 	Number of messages to be sent per connection, after that a relogin
-	will happen.  If the value is 0 or undefined, send all messages in
+	will happen.  If the value is `0` or undefined, send all messages in
 	one connection.
 	See also the `--batch-size` option of linkgit:git-send-email[1].
=20
@@ -111,5 +111,5 @@ sendemail.smtpReloginDelay::
=20
 sendemail.forbidSendmailVariables::
 	To avoid common misconfiguration mistakes, linkgit:git-send-email[1]
-	will abort with a warning if any configuration options for "sendmail"
+	will abort with a warning if any configuration options for `sendmail`
 	exist. Set this variable to bypass the check.
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 81f8cbc6f3..aff0861d29 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -21,7 +21,7 @@ Takes the patches given on the command line and emails th=
em out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
 last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email, as well as options understood by
+be passed to `git send-email`, as well as options understood by
 linkgit:git-format-patch[1].
=20
 The header of the email is configurable via command-line options.  If not
@@ -35,11 +35,11 @@ There are two formats accepted for patch files:
 This is what linkgit:git-format-patch[1] generates.  Most headers and MIME
 formatting are ignored.
=20
-2. The original format used by Greg Kroah-Hartman's 'send_lots_of_email.pl=
'
+2. The original format used by Greg Kroah-Hartman's `send_lots_of_email.pl=
`
    script
 +
-This format expects the first line of the file to contain the "Cc:" value
-and the "Subject:" of the message as the second line.
+This format expects the first line of the file to contain the 'Cc:' value
+and the 'Subject:' of the message as the second line.
=20
=20
 OPTIONS
@@ -54,13 +54,13 @@ Composing
 	`sendemail.multiEdit`.
=20
 --bcc=3D<address>,...::
-	Specify a "Bcc:" value for each email. Default is the value of
+	Specify a 'Bcc:' value for each email. Default is the value of
 	`sendemail.bcc`.
 +
 This option may be specified multiple times.
=20
 --cc=3D<address>,...::
-	Specify a starting "Cc:" value for each email.
+	Specify a starting 'Cc:' value for each email.
 	Default is the value of `sendemail.cc`.
 +
 This option may be specified multiple times.
@@ -69,14 +69,14 @@ This option may be specified multiple times.
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
 	to edit an introductory message for the patch series.
 +
-When `--compose` is used, git send-email will use the From, To, Cc, Bcc,
-Subject, Reply-To, and In-Reply-To headers specified in the message. If
-the body of the message (what you type after the headers and a blank
-line) only contains blank (or Git: prefixed) lines, the summary won't be
+When `--compose` is used, `git send-email` will use the 'From', 'To', 'Cc'=
,
+'Bcc', 'Subject', 'Reply-To', and 'In-Reply-To' headers specified in the
+message. If the body of the message (what you type after the headers and a
+blank line) only contains blank (or Git: prefixed) lines, the summary won'=
t be
 sent, but the headers mentioned above will be used unless they are
 removed.
 +
-Missing From or In-Reply-To headers will be prompted for.
+Missing 'From' or 'In-Reply-To' headers will be prompted for.
 +
 See the CONFIGURATION section for `sendemail.multiEdit`.
=20
@@ -85,13 +85,13 @@ See the CONFIGURATION section for `sendemail.multiEdit`=
.
 	the value of the `sendemail.from` configuration option is used.  If
 	neither the command-line option nor `sendemail.from` are set, then the
 	user will be prompted for the value.  The default for the prompt will be
-	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
-	set, as returned by "git var -l".
+	the value of `GIT_AUTHOR_IDENT`, or `GIT_COMMITTER_IDENT` if that is not
+	set, as returned by `git var -l`.
=20
 --reply-to=3D<address>::
 	Specify the address where replies from recipients should go to.
 	Use this if replies to messages should go to another address than what
-	is specified with the --from parameter.
+	is specified with the `--from` parameter.
=20
 --in-reply-to=3D<identifier>::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
@@ -112,14 +112,14 @@ illustration below where `[PATCH v2 0/3]` is in reply=
 to `[PATCH 0/2]`:
       [PATCH v2 2/3] New tests
       [PATCH v2 3/3] Implementation
 +
-Only necessary if --compose is also set.  If --compose
+Only necessary if `--compose` is also set.  If `--compose`
 is not set, this will be prompted for.
=20
 --[no-]outlook-id-fix::
 	Microsoft Outlook SMTP servers discard the Message-ID sent via email and
 	assign a new random Message-ID, thus breaking threads.
 +
-With `--outlook-id-fix`, 'git send-email' uses a mechanism specific to
+With `--outlook-id-fix`, `git send-email` uses a mechanism specific to
 Outlook servers to learn the Message-ID the server assigned to fix the
 threading. Use it only when you know that the server reports the
 rewritten Message-ID the same way as Outlook servers do.
@@ -130,14 +130,14 @@ to 'smtp.office365.com' or 'smtp-mail.outlook.com'. U=
se
=20
 --subject=3D<string>::
 	Specify the initial subject of the email thread.
-	Only necessary if --compose is also set.  If --compose
+	Only necessary if `--compose` is also set.  If `--compose`
 	is not set, this will be prompted for.
=20
 --to=3D<address>,...::
 	Specify the primary recipient of the emails generated. Generally, this
 	will be the upstream maintainer of the project involved. Default is the
 	value of the `sendemail.to` configuration value; if that is unspecified,
-	and --to-cmd is not specified, this will be prompted for.
+	and `--to-cmd` is not specified, this will be prompted for.
 +
 This option may be specified multiple times.
=20
@@ -145,30 +145,30 @@ This option may be specified multiple times.
 	When encountering a non-ASCII message or subject that does not
 	declare its encoding, add headers/quoting to indicate it is
 	encoded in <encoding>.  Default is the value of the
-	'sendemail.assume8bitEncoding'; if that is unspecified, this
+	`sendemail.assume8bitEncoding`; if that is unspecified, this
 	will be prompted for if any non-ASCII files are encountered.
 +
 Note that no attempts whatsoever are made to validate the encoding.
=20
 --compose-encoding=3D<encoding>::
 	Specify encoding of compose message. Default is the value of the
-	'sendemail.composeEncoding'; if that is unspecified, UTF-8 is assumed.
+	`sendemail.composeEncoding`; if that is unspecified, UTF-8 is assumed.
=20
 --transfer-encoding=3D(7bit|8bit|quoted-printable|base64|auto)::
 	Specify the transfer encoding to be used to send the message over SMTP.
-	7bit will fail upon encountering a non-ASCII message.  quoted-printable
+	'7bit' will fail upon encountering a non-ASCII message. 'quoted-printable=
'
 	can be useful when the repository contains files that contain carriage
-	returns, but makes the raw patch email file (as saved from a MUA) much
-	harder to inspect manually.  base64 is even more fool proof, but also
-	even more opaque.  auto will use 8bit when possible, and quoted-printable
-	otherwise.
+	returns, but makes the raw patch email file (as saved from an MUA) much
+	harder to inspect manually. 'base64' is even more fool proof, but also
+	even more opaque. 'auto' will use '8bit' when possible, and
+	'quoted-printable' otherwise.
 +
 Default is the value of the `sendemail.transferEncoding` configuration
-value; if that is unspecified, default to `auto`.
+value; if that is unspecified, default to 'auto'.
=20
 --xmailer::
 --no-xmailer::
-	Add (or prevent adding) the "X-Mailer:" header.  By default,
+	Add (or prevent adding) the 'X-Mailer:' header.  By default,
 	the header is added, but it can be turned off by setting the
 	`sendemail.xmailer` configuration variable to `false`.
=20
@@ -179,8 +179,8 @@ Sending
 	Specify the envelope sender used to send the emails.
 	This is useful if your default address is not the address that is
 	subscribed to a list. In order to use the 'From' address, set the
-	value to "auto". If you use the sendmail binary, you must have
-	suitable privileges for the -f parameter.  Default is the value of the
+	value to `auto`. If you use the `sendmail` binary, you must have
+	suitable privileges for the `-f` parameter.  Default is the value of the
 	`sendemail.envelopeSender` configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
=20
@@ -189,8 +189,8 @@ Sending
 	be sendmail-like; specifically, it must support the `-i` option.
 	The command will be executed in the shell if necessary.  Default
 	is the value of `sendemail.sendmailCmd`.  If unspecified, and if
-	--smtp-server is also unspecified, git-send-email will search
-	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
+	`--smtp-server` is also unspecified, `git send-email` will search
+	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH`.
=20
 --smtp-encryption=3D<encryption>::
 	Specify in what way encrypting begins for the SMTP connection.
@@ -209,7 +209,7 @@ Sending
 --smtp-domain=3D<FQDN>::
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
 	HELO/EHLO command to the SMTP server.  Some servers require the
-	FQDN to match your IP address.  If not set, git send-email attempts
+	FQDN to match your IP address.  If not set, `git send-email` attempts
 	to determine your FQDN automatically.  Default is the value of
 	`sendemail.smtpDomain`.
=20
@@ -223,10 +223,10 @@ $ git send-email --smtp-auth=3D"PLAIN LOGIN GSSAPI" .=
..
 +
 If at least one of the specified mechanisms matches the ones advertised by=
 the
 SMTP server and if it is supported by the utilized SASL library, the mecha=
nism
-is used for authentication. If neither 'sendemail.smtpAuth' nor `--smtp-au=
th`
+is used for authentication. If neither `sendemail.smtpAuth` nor `--smtp-au=
th`
 is specified, all mechanisms supported by the SASL library can be used. Th=
e
-special value 'none' maybe specified to completely disable authentication
-independently of `--smtp-user`
+special value `none` maybe specified to completely disable authentication
+independently of `--smtp-user`.
=20
 --smtp-pass[=3D<password>]::
 	Password for SMTP-AUTH. The argument is optional: If no
@@ -238,16 +238,16 @@ Furthermore, passwords need not be specified in confi=
guration files
 or on the command line. If a username has been specified (with
 `--smtp-user` or a `sendemail.smtpUser`), but no password has been
 specified (with `--smtp-pass` or `sendemail.smtpPass`), then
-a password is obtained using 'git-credential'.
+a password is obtained using linkgit:git-credential[1].
=20
 --no-smtp-auth::
-	Disable SMTP authentication. Short hand for `--smtp-auth=3Dnone`
+	Disable SMTP authentication. Short hand for `--smtp-auth=3Dnone`.
=20
 --smtp-server=3D<host>::
 	If set, specifies the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  If unspecified, and if
 	`--sendmail-cmd` is also unspecified, the default is to search
-	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH if such a
+	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH` if such a
 	program is available, falling back to `localhost` otherwise.
 +
 For backward compatibility, this option can also specify a full pathname
@@ -260,7 +260,7 @@ instead.
 	Specifies a port different from the default port (SMTP
 	servers typically listen to smtp port 25, but may also listen to
 	submission port 587, or the common SSL smtp port 465);
-	symbolic port names (e.g. "submission" instead of 587)
+	symbolic port names (e.g. `submission` instead of 587)
 	are also accepted. The port can also be set with the
 	`sendemail.smtpServerPort` configuration variable.
=20
@@ -269,7 +269,7 @@ instead.
 	Default value can be specified by the `sendemail.smtpServerOption`
 	configuration option.
 +
-The --smtp-server-option option must be repeated for each option you want
+The `--smtp-server-option` option must be repeated for each option you wan=
t
 to pass to the server. Likewise, different lines in the configuration file=
s
 must be used for each option.
=20
@@ -279,9 +279,8 @@ must be used for each option.
 --smtp-ssl-cert-path::
 	Path to a store of trusted CA certificates for SMTP SSL/TLS
 	certificate validation (either a directory that has been processed
-	by 'c_rehash', or a single file containing one or more PEM format
-	certificates concatenated together: see verify(1) -CAfile and
-	-CApath for more information on these). Set it to an empty string
+	by `c_rehash`, or a single file containing one or more PEM format
+	certificates concatenated together). Set it to an empty string
 	to disable certificate verification. Defaults to the value of the
 	`sendemail.smtpSSLCertPath` configuration variable, if set, or the
 	backing SSL library's compiled-in default otherwise (which should
@@ -298,18 +297,18 @@ must be used for each option.
 	connection and authentication problems.
=20
 --batch-size=3D<num>::
-	Some email servers (e.g. smtp.163.com) limit the number emails to be
+	Some email servers (e.g. 'smtp.163.com') limit the number of emails to be
 	sent per session (connection) and this will lead to a failure when
 	sending many messages.  With this option, send-email will disconnect afte=
r
-	sending $<num> messages and wait for a few seconds (see --relogin-delay)
-	and reconnect, to work around such a limit.  You may want to
-	use some form of credential helper to avoid having to retype
-	your password every time this happens.  Defaults to the
+	sending `$<num>` messages and wait for a few seconds
+	(see `--relogin-delay`) and reconnect, to work around such a limit.
+	You may want to use some form of credential helper to avoid having to
+	retype your password every time this happens.  Defaults to the
 	`sendemail.smtpBatchSize` configuration variable.
=20
 --relogin-delay=3D<int>::
-	Waiting $<int> seconds before reconnecting to SMTP server. Used together
-	with --batch-size option.  Defaults to the `sendemail.smtpReloginDelay`
+	Waiting `$<int>` seconds before reconnecting to SMTP server. Used togethe=
r
+	with `--batch-size` option.  Defaults to the `sendemail.smtpReloginDelay`
 	configuration variable.
=20
 Automating
@@ -318,7 +317,7 @@ Automating
 --no-to::
 --no-cc::
 --no-bcc::
-	Clears any list of "To:", "Cc:", "Bcc:" addresses previously
+	Clears any list of 'To:', 'Cc:', 'Bcc:' addresses previously
 	set via config.
=20
 --no-identity::
@@ -327,13 +326,13 @@ Automating
=20
 --to-cmd=3D<command>::
 	Specify a command to execute once per patch file which
-	should generate patch file specific "To:" entries.
+	should generate patch file specific 'To:' entries.
 	Output of this command must be single email address per line.
-	Default is the value of 'sendemail.toCmd' configuration value.
+	Default is the value of `sendemail.toCmd` configuration value.
=20
 --cc-cmd=3D<command>::
 	Specify a command to execute once per patch file which
-	should generate patch file specific "Cc:" entries.
+	should generate patch file specific 'Cc:' entries.
 	Output of this command must be single email address per line.
 	Default is the value of `sendemail.ccCmd` configuration value.
=20
@@ -341,7 +340,7 @@ Automating
 	Specify a command that is executed once per outgoing message
 	and output RFC 2822 style header lines to be inserted into
 	them. When the `sendemail.headerCmd` configuration variable is
-	set, its value is always used. When --header-cmd is provided
+	set, its value is always used. When `--header-cmd` is provided
 	at the command line, its value takes precedence over the
 	`sendemail.headerCmd` configuration variable.
=20
@@ -350,7 +349,7 @@ Automating
=20
 --[no-]chain-reply-to::
 	If this is set, each email will be sent as a reply to the previous
-	email sent.  If disabled with "--no-chain-reply-to", all emails after
+	email sent.  If disabled with `--no-chain-reply-to`, all emails after
 	the first will be sent as replies to the first email sent.  When using
 	this, it is recommended that the first file given be an overview of the
 	entire patch series. Disabled by default, but the `sendemail.chainReplyTo=
`
@@ -363,21 +362,22 @@ Automating
 	the value of `sendemail.identity`.
=20
 --[no-]signed-off-by-cc::
-	If this is set, add emails found in the `Signed-off-by` trailer or Cc: li=
nes to the
-	cc list. Default is the value of `sendemail.signedOffByCc` configuration
-	value; if that is unspecified, default to --signed-off-by-cc.
+	If this is set, add emails found in the `Signed-off-by` trailer or 'Cc:'
+	lines to the cc list. Default is the value of `sendemail.signedOffByCc`
+	configuration value; if that is unspecified, default to
+	`--signed-off-by-cc`.
=20
 --[no-]cc-cover::
-	If this is set, emails found in Cc: headers in the first patch of
+	If this is set, emails found in 'Cc:' headers in the first patch of
 	the series (typically the cover letter) are added to the cc list
-	for each email set. Default is the value of 'sendemail.ccCover'
-	configuration value; if that is unspecified, default to --no-cc-cover.
+	for each email set. Default is the value of `sendemail.ccCover`
+	configuration value; if that is unspecified, default to `--no-cc-cover`.
=20
 --[no-]to-cover::
-	If this is set, emails found in To: headers in the first patch of
+	If this is set, emails found in 'To:' headers in the first patch of
 	the series (typically the cover letter) are added to the to list
-	for each email set. Default is the value of 'sendemail.toCover'
-	configuration value; if that is unspecified, default to --no-to-cover.
+	for each email set. Default is the value of `sendemail.toCover`
+	configuration value; if that is unspecified, default to `--no-to-cover`.
=20
 --suppress-cc=3D<category>::
 	Specify an additional category of recipients to suppress the
@@ -401,36 +401,36 @@ Automating
 --
 +
 Default is the value of `sendemail.suppressCc` configuration value; if
-that is unspecified, default to 'self' if --suppress-from is
-specified, as well as 'body' if --no-signed-off-cc is specified.
+that is unspecified, default to 'self' if `--suppress-from` is
+specified, as well as 'body' if `--no-signed-off-cc` is specified.
=20
 --[no-]suppress-from::
-	If this is set, do not add the From: address to the cc: list.
+	If this is set, do not add the 'From:' address to the 'Cc:' list.
 	Default is the value of `sendemail.suppressFrom` configuration
-	value; if that is unspecified, default to --no-suppress-from.
+	value; if that is unspecified, default to `--no-suppress-from`.
=20
 --[no-]thread::
-	If this is set, the In-Reply-To and References headers will be
+	If this is set, the 'In-Reply-To' and 'References' headers will be
 	added to each email sent.  Whether each mail refers to the
-	previous email (`deep` threading per 'git format-patch'
+	previous email (`deep` threading per `git format-patch`
 	wording) or to the first email (`shallow` threading) is
-	governed by "--[no-]chain-reply-to".
+	governed by `--[no-]chain-reply-to`.
 +
-If disabled with "--no-thread", those headers will not be added
-(unless specified with --in-reply-to).  Default is the value of the
+If disabled with `--no-thread`, those headers will not be added
+(unless specified with `--in-reply-to`).  Default is the value of the
 `sendemail.thread` configuration value; if that is unspecified,
-default to --thread.
+default to `--thread`.
 +
 It is up to the user to ensure that no In-Reply-To header already
-exists when 'git send-email' is asked to add it (especially note that
-'git format-patch' can be configured to do the threading itself).
+exists when `git send-email` is asked to add it (especially note that
+`git format-patch` can be configured to do the threading itself).
 Failure to do so may not produce the expected result in the
 recipient's MUA.
=20
 --[no-]mailmap::
 	Use the mailmap file (see linkgit:gitmailmap[5]) to map all
 	addresses to their canonical real name and email address. Additional
-	mailmap data specific to git-send-email may be provided using the
+	mailmap data specific to `git send-email` may be provided using the
 	`sendemail.mailmap.file` or `sendemail.mailmap.blob` configuration
 	values. Defaults to `sendemail.mailmap`.
=20
@@ -441,12 +441,12 @@ Administering
 	Confirm just before sending:
 +
 --
-- 'always' will always confirm before sending
-- 'never' will never confirm before sending
+- 'always' will always confirm before sending.
+- 'never' will never confirm before sending.
 - 'cc' will confirm before sending when send-email has automatically
-  added addresses from the patch to the Cc list
+  added addresses from the patch to the Cc list.
 - 'compose' will confirm before sending the first message when using --com=
pose.
-- 'auto' is equivalent to 'cc' + 'compose'
+- 'auto' is equivalent to 'cc' + 'compose'.
 --
 +
 Default is the value of `sendemail.confirm` configuration value; if that
@@ -460,10 +460,10 @@ have been specified, in which case default to 'compos=
e'.
 	When an argument may be understood either as a reference or as a file nam=
e,
 	choose to understand it as a format-patch argument (`--format-patch`)
 	or as a file name (`--no-format-patch`). By default, when such a conflict
-	occurs, git send-email will fail.
+	occurs, `git send-email` will fail.
=20
 --quiet::
-	Make git-send-email less verbose.  One line per email should be
+	Make `git send-email` less verbose.  One line per email should be
 	all that is output.
=20
 --[no-]validate::
@@ -525,7 +525,7 @@ edit `~/.gitconfig` to specify your account settings:
 ----
=20
 If you have multi-factor authentication set up on your Gmail account, you =
can
-generate an app-specific password for use with 'git send-email'. Visit
+generate an app-specific password for use with `git send-email`. Visit
 https://security.google.com/settings/security/apppasswords to create it.
=20
 You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` and
@@ -599,9 +599,16 @@ helpers.
=20
 Note: the following core Perl modules that may be installed with your
 distribution of Perl are required:
-MIME::Base64, MIME::QuotedPrint, Net::Domain and Net::SMTP.
+
+https://metacpan.org/pod/MIME::Base64[MIME::Base64],
+https://metacpan.org/pod/MIME::QuotedPrint[MIME::QuotedPrint],
+https://metacpan.org/pod/Net::Domain[Net::Domain] and
+https://metacpan.org/pod/Net::SMTP[Net::SMTP].
+
 These additional Perl modules are also required:
-Authen::SASL and Mail::Address.
+
+https://metacpan.org/pod/Authen::SASL[Authen::SASL] and
+https://metacpan.org/pod/Mail::Address[Mail::Address].
=20
=20
 SEE ALSO
--=20
2.43.0

