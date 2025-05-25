Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D461FBCAE
	for <git@vger.kernel.org>; Sun, 25 May 2025 17:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748193148; cv=fail; b=RaOv0fmW+ny1b+k0A9rLyCd+7+UpGGpfGni18U51jTAb5sP3wA2oMHm61k+iG++SscroA7Mijf74Ue5BR9YlTkbhfx+2AsMT+DDwLfh1Slt19GuBwbirCmHF5tUcuWr7/X8Y5H6oSXmQI3ioz7XZ0boJPARKl0egNWvhya5E2/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748193148; c=relaxed/simple;
	bh=CLy6MKrANVowiaGbcz8FQzaytEG4xrottN5iB31mj40=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R2ZbX4hW0xgXAl3jPTiQ5+Uxk38FJ0UMyrZqXPknPEKfiluUf4uswTAGvgyxhTfYN6bJ2wdJh7iHUPq6mF7FRgoJXDRgW565ppE31dKmyobGMZHh7kAoTcib9jFM5FvTKQNlF8QdXI2FaD1CPVyjLUZjy90AowoxB2CYGqCSMEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=gsszd2bC; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="gsszd2bC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guJQX9H75GPxJcft8TZaVW0KwEfTzUKKtbjz4dAWZmCE6uh+6RtlVl0Rrcz9g4HXdvNNmsvnMrZ62JN3FyqPVW2/ROxiMJIGujjUzk7eTxA7D9RhEGcGOyxSgP5m4IdfdQO2LH+5pVhDHqhw9NGFOHciXgWc1vxZTlNUn3uryJmm8/1ul03mbv2opzqAz8voMS/lQmcDRPq7TZxHQiaMthUol9b3SvYcKZ0FXgrXEmpmmQuCbQCr5YO62ReweXcvqk9GImxHsyve5xrzaKNTSmOKOlQPgfHKy0zBBEZa6wbcVlMVBWqoihE8GIDfPKQW/bEJ5viT1iihnLdabQZVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a4+3NNNsb2sCkS3YtgoJ1a6mI4tkq9U7Tqmd5b+MeP8=;
 b=jTC408Z41adBLg9pgDGpAxIiEbuePyKgXnzUpriOGKLXRQqxhH8atAbdlY4xBgH9qcGGj9Van4PkvRWeW2rllq88L14TkO+6hwfZhx7uDe/z6PxuJN+9zjRLaheAqH3a8NsfPqbDab84GRCuIyhrKwGgZtu3qmQ2ehxnzinibOEEkrfc46rwpZphaWABvIQQiLwHYeC3XYnMQYsP74TrOk08BAVkL+Ay2T2jDjJcFYVZGc18qZyQg5s185nSCx6/nXF7R9/m9loBzWnlDtMQXpX1bO3V2By+q+6UxU/iLU6b/STX8DU841Ji/aY7h684gc52gJfFLW1yyXpLvfRTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4+3NNNsb2sCkS3YtgoJ1a6mI4tkq9U7Tqmd5b+MeP8=;
 b=gsszd2bCF9Anh0a6i6eAoI+hqau4nVTJ8yRpgrluH2cRcnBOxddhRfR+nNBQbivIuQvP7IbbTI6Q4CcKMEvtBLJ1PUgtKUnltYhUDoTl8+PhJA6Ewgk5xCW2LljzgWcwEqaAUsP2iA/LUm0Qm3HzNNiXCrOS5j7nOI837Io/dpWn3CKVlGxv5gTvLq8nS4RoxGrj2mTcuKxE9MZvM3rbuoHOWr4hagzJoJJLivqS0I4y7rzEOOm+byZX9olwlXXzoL8bjbINpTVWU5tFZ47JQwV0SnvTViuIcGCBSt9ZclDsro2KPOzrmcpCtx3DM/oNvH5icupibz4A29MyxTxIow==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB6803.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Sun, 25 May
 2025 17:12:20 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.022; Sun, 25 May 2025
 17:12:20 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Jacob Keller
	<jacob.e.keller@intel.com>
Subject: [PATCH v3 2/2] send-email: show the new message id assigned by
 outlook in the logs
Thread-Topic: [PATCH v3 2/2] send-email: show the new message id assigned by
 outlook in the logs
Thread-Index: AQHbzZgseT00pkvcYESn8XDo9qjWfQ==
Date: Sun, 25 May 2025 17:12:20 +0000
Message-ID:
 <65619ac4d7e4891a6f0ea157c7d30b0d2072d3fa.1748192784.git.gargaditya08@live.com>
References: <cover.1748192784.git.gargaditya08@live.com>
In-Reply-To: <cover.1748192784.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNXPR01MB6803:EE_
x-ms-office365-filtering-correlation-id: 257b1e48-176f-448e-1283-08dd9baf4f16
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|7092599006|19110799006|15080799009|461199028|38102599003|19061999003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?WeYEcMig88k3MkGM45RXKa2IhW4uXRNDP8Xcixiom622UvDdCUjh/ZlDnI?=
 =?iso-8859-1?Q?c7LC4H2PtO5og0JF84wB8tlYyaoVgb+MK3nQ/8xVV6yjwp9gnEqGRZlLCI?=
 =?iso-8859-1?Q?tcJi7+k80yYNWkjeLwjMkHJVr+f/YLiFEFaRmBx0T26k4oCB0KdVUTnHzX?=
 =?iso-8859-1?Q?rdgQEvw7NRCxuwz/NrKIvMaKS4QDILrbMVE5jAjbv5CeIFbxDlO2usZZjP?=
 =?iso-8859-1?Q?8YW0LX+KMrWEL+2vpSe415OPqe8aYX0qsFdet+T9vEUmjlmHWVqFlExVrw?=
 =?iso-8859-1?Q?RIpQQaLiAjVFL4HEi+fbWdGvr2aS1NlK3mL+lzvkOHwT3esGATd8lgny+P?=
 =?iso-8859-1?Q?bgk4lQ7SN5VWzGvfBBOLUJuQ/MGwpX0ok5v27efvV1Yr/3Pzgwxx8SAYFa?=
 =?iso-8859-1?Q?JWr+O2taYJdc/wgJoiF9DGQUqbJCEiyFudTZnuHZnBRLeKlZOpBNjkkLe1?=
 =?iso-8859-1?Q?D4QrkPgfE+1v5G9HWyt040aNb/Ac7oTcxslh/4Hy1i8kbG192wGg+SKmHx?=
 =?iso-8859-1?Q?Ye3AGvUA8pXlf00L5zN4w3+F1XMXCZ06lhz/vGBpF8qmF7f5T0jUvGL0M7?=
 =?iso-8859-1?Q?YdQ8JeDTtJUNOP3wjygTaW1QrxaTSHLWGlrAf9j7qI1PMVLsvRnEL7nv0H?=
 =?iso-8859-1?Q?R1bFDmzj7wUe1IFlKgzd94Qy4oygDcSiPnG7yonE/Xz+Pqi5DE53+LnZ2H?=
 =?iso-8859-1?Q?A68R6TZDz9tRukYDbQ7ZeGJvIIVvOxYSZdOl3EccAEOr19xRsSzoLqtoHC?=
 =?iso-8859-1?Q?6J3AdnUTprrA4FjUBW2IWbphzwN6KTHUguzWGrrpZYC7u41uq4v2aJRBgv?=
 =?iso-8859-1?Q?bXaRJDJugK7UNm/yWjE+DLHMgKkqqYttsDXxxZg0wYevHYRwWTXznUEr1Y?=
 =?iso-8859-1?Q?n+Fa+NyBUSbTAVj7I6wVtTKzbdNeI/H0gugOhkvbZ0zRA7Kd280jFCSy0G?=
 =?iso-8859-1?Q?7WqkKtY/ZL0JNBiMIavqY8CqDSBy+CnognCD/V1jxVDkA5irNXPDmtkpX3?=
 =?iso-8859-1?Q?xwH6Mnm/vQrr8N23Hmf8u/sH9wJU9uC6QMIyeqU/WABCGUHC5Yflckvmc9?=
 =?iso-8859-1?Q?weSJ1sf555JbS+fvtLn0gRbvQz4eV2smuY7sgkoSsZIsEFEiCi3HJWq2GD?=
 =?iso-8859-1?Q?EL/E2jKV0/lEPvFqSaFFPLY2z6ZKPnX4vUMLIwA8BboORr1i6LAyc/ZvRD?=
 =?iso-8859-1?Q?EnPIr9XkjjMs4hBHMeRuQi+5YwqqxDxf4YE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7QPbY8efR1CU0Ks2haKtLWl4cSHN8j/nl/QZjFvvYrF7dKbmxtkq3GWGCb?=
 =?iso-8859-1?Q?Dqoh/pq3tLGHGKjSwKOyS9JGkGDXQadgkBr2Tj5W1nnGoVjtVjS/7nQsRJ?=
 =?iso-8859-1?Q?ZWjLRF5HPMwsLPw0ldT5wVpeQQUMXSo9m2ujhYXR4yLX1zzx9RLTO8KQY9?=
 =?iso-8859-1?Q?fmix0NGxaLJ6e2fmVymjc9nLBkYDsqy4oKWWsxLNB4KbBczuYnC4R1NDEh?=
 =?iso-8859-1?Q?fWkHNPtLGclG0VpitUrkiYzgomuawIeL6liw84y1gSV/C0NpqEDs6QHkSn?=
 =?iso-8859-1?Q?SbPyezxkmNOrHOUt5CRAsJHVnAZJGc23OLrcCleKCS3JR8vtLMtcPgElCz?=
 =?iso-8859-1?Q?EKGsC69AlzGtyfXtCYjbve/pVtYOyeMU1dPadP1IimtrHsqh0uReYi2HLg?=
 =?iso-8859-1?Q?B+xLCL7BYR2FwAG5URiWoLbUEOw1gnUOwtMmVxWiNK7VSvxrL9spp67bqj?=
 =?iso-8859-1?Q?IxI77ibJpYFTfI1XrIbN1ksR3LJ/1x9F+9ZWeY3kOeWwjttGEZ76Of6BzY?=
 =?iso-8859-1?Q?z7apMPQ05tAgLzoBjn8Vylr2HB08VRgwMs5pP3m12qVdrDUzlWyk5mnkWZ?=
 =?iso-8859-1?Q?OHQw4a0DU0k1huOP11zwFWrT7AtpbI+m48Q0F+6E80gMNYXJHLpAN1CsnJ?=
 =?iso-8859-1?Q?xlKBE1hsq5wJh5fpCKcs+NkaRUTHhaECijomLvfwVwCBJyH3nNY1l56r95?=
 =?iso-8859-1?Q?3C0GuCUJ3z+wTI3dI7B4Wlf/P++pk4XBnTBJT1gTrAY/h6pPb/D2VBOyMh?=
 =?iso-8859-1?Q?atkDnneMZdziEvR/BDSkPH+P1rzA24OYQ7Ix9YECyhMf2h1rQGy4H4gLMI?=
 =?iso-8859-1?Q?IjiCQln9mszY4N6FiUKTYeMi/4ags8E9jtW6BnTR//odp1UbXqcRsmZb1S?=
 =?iso-8859-1?Q?d6xJjdF9N1o5+ZYGutRZwdnBAbXHPaAXp+2DJRjioXL02GpWZsQYT9vayH?=
 =?iso-8859-1?Q?3rmJVDsz06prUqG+eQPKsiYBPTsh9SC2MYcg5rvK7D9ge28daFJmlBLwZ0?=
 =?iso-8859-1?Q?nmBRH+1bMpFL+s+s/4IVZkYwQmus2PwyOcZKb1Avwb5DpBRuwalLCuaLAJ?=
 =?iso-8859-1?Q?6LEdKFBHa+SZvX1yZK66G2+chh8ZbG2SAbuK8al0UnEsLIlVtrF/8mxiAZ?=
 =?iso-8859-1?Q?PteqWOiRYmVzla2AEXItcbOWSAQLwAB9PCoJxtTsak7d+qP81Rzpgy22Y6?=
 =?iso-8859-1?Q?K7GaErSsUkKSEFIvaEUpV8wDLlSGqerOOEVCvdBQOvd68Q+O2TY/xbbIjk?=
 =?iso-8859-1?Q?tIzNtRzRzsRqL0V9dXHOSPPD1rnQEW0tYacNKVQD8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 257b1e48-176f-448e-1283-08dd9baf4f16
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 17:12:20.4619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB6803

Whenever an email is sent, send-email shows a log at last, which
contains all the headers of the email that was send successfully.
In case outlook changes the Message-ID, a log for the same is
shown to the user, but that change is not reflected when the log
containing all the headers is displayed.

This patch fixes this by modifying the $header variable, which is
responsible for showing the logs at the end. Also, the log which
states that the Message-ID has been changed will now be shown only
when smtp-debug is enabled, since the main log having all of the
headers is anyways displaying the new Message-ID.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index b09251c4fc..e8019c40ba 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1776,7 +1776,9 @@ sub send_message {
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
2.43.0


