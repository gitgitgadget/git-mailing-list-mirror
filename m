Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011031.outbound.protection.outlook.com [52.103.68.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C622B8BF
	for <git@vger.kernel.org>; Thu, 29 May 2025 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530633; cv=fail; b=mX3CinYHYCiTZqT4DVqzcE3LCEFagDLtg6Pq32wHCwcxPNITCVwlOdYwY/yWqu9lU30gcFGIiLwPskFp+kThr9e2J5c2QMdhXk52XFLW2gJXdGxlr8clR5VzRWqs6NRG8rF2PXv7kpMbMhQuPQcLS+j+bGFvosAYipxE6hjx/LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530633; c=relaxed/simple;
	bh=QunR/DVd55bi7sArMYSxEdULqma8fhfGfyTe7XSluQY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eb7ITD4fnM0kh1kis5BAon37UUwCvMbpwp4qK4X99eTB9J12lJlHafBqQaI0Ng/kGm8AzeKPuYq85mdCnzMkXKNWNbADWn1cMvrN53eNP3RhP4OQpdl5fNgV8jOXBQ3l3jtsUqwr3EEWKCWPTMkYyR3rFCQIav5Nn6Vsv+lxE4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=SAGyiinG; arc=fail smtp.client-ip=52.103.68.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="SAGyiinG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ONiJxYyRJwo53aRuvJAXw/KLpqtESzq5x+188a1Q7gWunEgprXJWh/RYk1P3kBiehtfTK62Q9N2ZwEzXE2iu5gJRTupZuH5PiRF/r83nrTerd3xZi0KKUZb08A6nBWdoIIIgGKWiOTMr0fuX5jy55LgrziB+oDc/RrYzRXsdqMXmzqv4bvr7E/BoPkWpq/Kz/MQI4rYTa502mVnN41Tjxw4vZCzejfNesB54IrfsvSHeOLpD6P+5U64U0TUmMmjBv5AqdZLd4FzltD/zt9uebAbFEOXaNx4raGvMYYSP7kmex/s1O4wOaUkEaH8HWr32OfgxfwH+9+Aiutd8uXhQ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X+jwQfDPBn6384LAxCF29w15PnXPsaY6AM52+xvAxM=;
 b=bILdcuCBXlKXaWGcvZ57zWyrbN5WwKsYAppdOw8tz1EERQL86IWPFnHhmuj0Q92qttexfBUETG1Du3kVeJdkTG2Ln5sNmB78NOAsULRX0yq4sKVlHnelSa3iD3mCXAHgRjJyh9FNaam/pWOJFUCqic0DzvMSZKT7JrsAw3f0kiEt1zYtbeKcc4b+5awY2MctsqYTp0wPqIwnisL72IE2Brj9Hn1pn8P5FpUNNA2bxFajGHd2Zmt9wsXk6fxGLYSenHBqvzKbDBAUanCU31IQxzDSbHkAzK45YjJwaaKsk3NQ+U3MHxKksyKpNwVc7claTbBZmlgI66jT3vG0CHpGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X+jwQfDPBn6384LAxCF29w15PnXPsaY6AM52+xvAxM=;
 b=SAGyiinGqW4/z3LisLX0gpc/GPM3yjecdfTdpEngFm+cNerLgglMuHL9RVsq1RBC1W3PQVdnDjeeOmfgCkvTjKit7nrsPvjpwENaCdnBmFYS+9NFqs29bN+oST+Y1Vhk1VHpg3+t3nkp4eOZEb0eoFeHyDRkh1HI6rJNVfXUR/vSv+Wfp3YGLMPTHH52EboTWeFqAJ0xrRvX59GDOcO2K28jEkcInzUewJXr5pKtCQ/9bT3BZos8LlrkOS5PIrYNj4BtSlYfp2+ZtDumkJ2/5Elevg63iVr7HDEApuXnnIh/wBvn7jAVkfFcjJi6m9JYeaBIZ9H7tUBa5xSSxlhPQA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PPFD2CE7FA6D.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::54) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 14:57:04 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 14:57:04 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>, Zi Yao
	<ziyao@disroot.org>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v6 2/2] send-email: show the new message id assigned by
 outlook in the logs
Thread-Topic: [PATCH v6 2/2] send-email: show the new message id assigned by
 outlook in the logs
Thread-Index: AQHb0Knw0IQxLgcnK0qIdqhjCzYfLA==
Date: Thu, 29 May 2025 14:57:04 +0000
Message-ID:
 <caf46596a709df7205495b75da569baef2c7c9a2.1748529954.git.gargaditya08@live.com>
References: <cover.1748529954.git.gargaditya08@live.com>
In-Reply-To: <cover.1748529954.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PPFD2CE7FA6D:EE_
x-ms-office365-filtering-correlation-id: cf499552-6f65-42e3-c98a-08dd9ec1130d
x-ms-exchange-slblob-mailprops:
 02NmSoc12DcHu/Dr1OK6cqcYKvfIm6M5e+i3ByPbHt6kKOTHN4U+3NtuQRcQQvMPfZNafs3bib4ov1GnWarifxWGyzbNgiwQuU+pXwjT5njMHGnh7aez3yKzthwmUjLO6qtdpHQNWwZdL8X+sew/BuPrth+IVURVMqyhElhRwT79JjutUEFq0/pCBXRflfbHv4js8pA+etujvVD1dumwQ+CAZitHKrErmYW+hTPCb9Ixq573Hgznrf7CsO8QiLiOgFroJ6LLGVtma00/CP4bf7rdWuJ4CMmBP2Xw+FWtQRR7tCQUR950/Kswfe6KfyX/MYXKKV7Occ/rPVcHZAjTnY/vrptDggaiymfPYlBVy66YcyFpjXXYb02WwNlPNuq6/rxjQ/CVjHto9iwIP0+cSYOBMiTaYEgeHR6zNQK9ykFnyhnJDTWegSa/Ow4Tl4gUiyT70BDnHVgk3mosG4Y18GeIkmLdOMkzE+xFcbfdAtcGJP7WT/AHXvtcmw4WGTnOrBX0NbqxlYkhS3z7fyI3L6CoBI+4J+wJHcucZgVaxDxOb/QM0gaoTSs69KUNrzJuoDMnEn8NlSzP8MFGA2oSsUObZiVQvBWuo9PjpzluNAGHK2GgeRqI2HQNmIptiiHYa6g6HH2d2gzo1GGHXwWHn+SO/qsigH1bEyfiWh4G7YJPYm4ozmn2XMg9ORSX1OexL2+3UeGRCcCr5csIXfOC8f+aKRK2vka6UijLeWSoxCkCozIW3fsJGeBhTvhyRmgC
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|461199028|12121999007|15080799009|19110799006|7092599006|8060799009|8062599006|102099032|19061999003|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?03uLsfjFa0OMjVLtYqrOvybUfEa/bpfrNP62rERzhKwv5pxX3RJAtP+qSu?=
 =?iso-8859-1?Q?UOYpf6v0YiM6na2kdVbpEyZOeyECYSlG4lI4Otp/ww/zWhCuOfReqq5YPn?=
 =?iso-8859-1?Q?UZxhLHroTh2jwi3JUhCSyim/9mpmJO6PBP3OS2iZqP4JRROnTr+D+pri0p?=
 =?iso-8859-1?Q?QVmhB3TsgASaz9PoOVLvQ1pVyK2nh/bTq658UNvQ2NbsK1DwDnlp877eUU?=
 =?iso-8859-1?Q?f/FlJP5p9+hvz5AZ6adZsq0T2AqmuQKzHZVviPmDf9n0ZFodfwUUKu/9nX?=
 =?iso-8859-1?Q?9Jhy4O/6Tgik8BJaeIr0bQ4h8JYdU1QziEdPjDtrHlCbcj9XmF980Kn8uc?=
 =?iso-8859-1?Q?B2B0f9lCErJC+3P39NWAW7d3cJYcs7X8QqZWdL9rdfNRlksEyO84q/KKxD?=
 =?iso-8859-1?Q?BKi2WsbzndvhT8SFJMd0/swgC28syxVrtmnoe7eJTP9ayBd1yFegiuglCO?=
 =?iso-8859-1?Q?u7miFRNnzERtfyRmDN9/4Av68k28/H45vkldHgJfCth58JWeSNozGgi4+a?=
 =?iso-8859-1?Q?WaJyOnCIEV43YOsuTEel6bGYcOEsahDnBxY3cRU58ehFAU6Q7JBl6ZG560?=
 =?iso-8859-1?Q?0pkb0kGbR3+QuplnKQ+nkoLmKHJtUwKhc+3mbrmGzzcjEmOVGA0ZPzvBIL?=
 =?iso-8859-1?Q?fWT9EbPv9wWf/kOGKp9Wb27zNWPkUQPKwkx8CPyrCY92zCqMlqXFHcEpwl?=
 =?iso-8859-1?Q?Tp4muVEdhGVDsOYvyOj2T/AnB0zIvK04tWMqPMyMp0HWEicrfPhNt7YMwS?=
 =?iso-8859-1?Q?YcquvSLlPF2omRp5NiDWas+RcWvPByHg+XjOx9KbHYK5cWHtTFPkd4LwHb?=
 =?iso-8859-1?Q?3KRSGYGS7pek9HKjXZ0DPvMlaxcEzuMI7Hon7LElE7msdaUrDww3utmsUS?=
 =?iso-8859-1?Q?+56cblSZ6lD/6FuTpFmPln3GQRToY9izVaS5aRfb7wva6TQAvR/+CBgeX8?=
 =?iso-8859-1?Q?OmEDuZdoRE1dIRurFw9dakaJwRGeRLhigJbWLuUARdN48k0PNrER9IgcNj?=
 =?iso-8859-1?Q?u9jCSkHyEGN+tv+gcvhE70PCv0Mo86lStgTMoiU4SwlmqCA8phdf7Ul4GM?=
 =?iso-8859-1?Q?d1f1USmY2JIuJIzQPxGtW6+Y1/19b1ljF4/xd8j9wEgSqrV+Fw1hwLBZu/?=
 =?iso-8859-1?Q?tQmCnDqzKfqJNsR5KKOl1AFib3eKnVRR5RB9B99K0CNYMognojJcEZB2ul?=
 =?iso-8859-1?Q?AWL/hdy8XJ5Sifs9Qr0kcnQUK/wccaABgfU6HzJ3cvp6hDQQ59ApaKv3Pe?=
 =?iso-8859-1?Q?2XsLiHdUwBes7u8ymlLw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?qoEGIvuqfGMwLJCBUE3wgn01R9et1DeMX5XsMrkYhVRXroAFG+FPgikcdt?=
 =?iso-8859-1?Q?rEQXIp2ZWm6NJrGwXvdBPdQeDA4e/UFDJPm+lN6Ry+j49GnQFu4zWIE2Eb?=
 =?iso-8859-1?Q?9TrH61fNeeIakCpzX6FzMsGFpzpgCbQm5rAZYiq82G4spnxwaysiEfLv8s?=
 =?iso-8859-1?Q?+1iwLf3S6o9b1WF01Qh+tPUQdwA9SSlE4k0MQXtAfXVri0wX4bNvw9q7H7?=
 =?iso-8859-1?Q?H98FUMYYij78KAPuVxMAvR3mhHMdOIivFO3F0xTTC+yHHIBPlPdxePf9vM?=
 =?iso-8859-1?Q?R+AzPCL6rsma17Omh2HmvFqO+evhGuYHYeZqLYFeR7+aWuZyzCPAYuJuE7?=
 =?iso-8859-1?Q?q0NdJYS9l7ut3C3seV/1o6oSF0pi4QhBSQbxbTfUsmwszT09KGOy8aT+gs?=
 =?iso-8859-1?Q?980v5itPow3HiGx4O0acfkqdQPPmIaxL3Hn+Is6pCRmCcBlEzsLvcPNGWF?=
 =?iso-8859-1?Q?u/BZ40T8WsRt9qs3Fpm2Rfq/lDFo7YjOlokNV7xlm7b9fnpAAWpjsBSIqP?=
 =?iso-8859-1?Q?rUvu72yIp2qkeIOxBCkEORe341gfGqd2npXhaBrafLMQ51DSMmHCUMm6PE?=
 =?iso-8859-1?Q?Vbgrm/Vxv/C8Ia7+Hmyk1qFttP1OWh6wx/J47R57ypMTTKE554fLlYioN0?=
 =?iso-8859-1?Q?BLGmCKJRsO3xtPJ4usaUhPkz2rAho/Nz3xebpw3jHoOe/2bRNxsAEsWZtD?=
 =?iso-8859-1?Q?G/OBO+2jAuWfD4WyAfQ27KoIAAZBhe5Z7gh2ThTQLAjp2dsA4ibZkglXMw?=
 =?iso-8859-1?Q?2VfZXSBxKbKvXlhku9hY1DlVMnrFSo4cpX+JM4AE5usjmaRqaUKAEvqIZR?=
 =?iso-8859-1?Q?QLm0YzsapxftVS2w7OPKpLS8ygd7VopSbrRs7CmGhsKobwntfpHiMfGA3P?=
 =?iso-8859-1?Q?QIfcFTKxo/TRBRAYOA2KXV3asmIFgk0OAVXUAZobORx7PxU2owJBengW0d?=
 =?iso-8859-1?Q?W7jS3Z77UmMnfcYuC5uYIAxI7BA/3jszFtVZgddhLjqQG93Cd08G9FaelU?=
 =?iso-8859-1?Q?ryxujTcolqgpswyTM9cViY9+OyjserxL7TDVeCojGVREES/rmS7fhJESi8?=
 =?iso-8859-1?Q?YCJtAbqN2U9nKv+NnYbnVyelr4CUQpRtphOv8r1CZ2Gxz3V/QcVJbDx9ct?=
 =?iso-8859-1?Q?+CiOu0wD8sdKNEj+8q56k6wDE7pqY4Cf6Fimqz/4Qa+XGYX8bqjqEDA0Mm?=
 =?iso-8859-1?Q?UaJGAByZYC+07dxfulaQ/rCR8VEvBP4hT3hIDISU3PnZmunvKxQm2aJ+xY?=
 =?iso-8859-1?Q?TzDO+S/bwfIE/pdJfYtfaerOSHpv/lllkBFaNz4s0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf499552-6f65-42e3-c98a-08dd9ec1130d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 14:57:04.1632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFD2CE7FA6D

Whenever an email is sent, send-email shows a log at last, which
contains all the headers of the email that were received by the
receipients.

In case outlook changes the Message-ID, a log for the same is shown to
the user, but that change is not reflected when the log containing all
the headers is displayed. Here is an example of the log that is shown
when outlook changes the Message-ID:

Outlook reassigned Message-ID to: <PN3PR01MB95973E5ACD7CCFADCB4E298CB865A@P=
N3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
OK. Log says:
Server: smtp.office365.com
MAIL FROM:<gargaditya08@live.com>
RCPT TO:<negahe7142@nomrista.com>
From: Aditya Garg <gargaditya08@live.com>
To: negahe7142@nomrista.com
Subject: [PATCH] send-email: show the new message id assigned by outlook in=
 the logs
Date: Mon, 26 May 2025 20:28:36 +0530
Message-ID: <20250526145836.4825-1-gargaditya08@live.com>
X-Mailer: git-send-email @GIT_VERSION@
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: 250

This patch fixes this by modifying the $header variable, which is
responsible for showing the logs at the end. Also, the log which states
that the Message-ID has been changed will now be shown only when
smtp-debug is enabled, since the main log having all of the headers is
anyways displaying the new Message-ID. It should look like this after
this patch:

OK. Log says:
Server: smtp.office365.com
MAIL FROM:<gargaditya08@live.com>
RCPT TO:<negahe7142@nomrista.com>
From: Aditya Garg <gargaditya08@live.com>
To: negahe7142@nomrista.com
Subject: [PATCH] send-email: show the new message id assigned by outlook in=
 the logs
Date: Mon, 26 May 2025 20:29:22 +0530
Message-ID: <PN3PR01MB95977486061BD2542BD09B67B865A@PN3PR01MB9597.INDPRD01.=
PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: 250

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ac1d5b7070..79d230448f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1774,7 +1774,9 @@ sub send_message {
 		if (is_outlook($smtp_server)) {
 			if ($smtp->message =3D~ /<([^>]+)>/) {
 				$message_id =3D "<$1>";
-				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id;
+				# Replace the original Message-ID in $header with the new one
+				$header =3D~ s/^(Message-ID:\s*).*\n/${1}$message_id\n/m;
+				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id if $s=
mtp->debug;
 			} else {
 				warn __("Warning: Could not retrieve Message-ID from server response.\=
n");
 			}
--=20
2.49.0.635.g48fa2f4343

