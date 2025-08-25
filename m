Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55781286D50
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104937; cv=fail; b=ri0AWitL5AkcDmdSb1XouIWOSl8nb0cwnPuoXmdBZo/mGNVy7efl05u7iaJfX1mV6N0QAlXrwBY1RmyXi/heurVtO0RIMVy8rzxy2BHWfEg++2mkDXyGRpr29IJil8Y8Yb9NTbYB4F2tSWeGbIjEbL1xLtzne5qQtiwrnpj4Op8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104937; c=relaxed/simple;
	bh=YpFsqHzk7TUx3XYfcTO+TfyzJQbZrLiGUin8RAmOdF4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K9UW+PBIEm+yJrX2jmJ2YeGhVWAuz9xXaAenob/6rdCMOqvURa8RRwScgmimeLqMouYmIOGABWXMTsLWUAciu1osPE/+Ex9S0yI4Uq54RYMwiQ0a+VhjQa0d6YcgVAuH/bl9MX2NuVRcQ5xdSJf+N5VYSJm/knyS8VjRVf/4x9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=J9wwD4/v; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="J9wwD4/v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PH2FoSwzxdhEQFqCd3BRam1r56PWOVrFhxmwvEG/8a+amDu1Yiwu37LoYKcJPv2tlI6OiMN8GKtqGiEo3qLykp3BsZvu9M2joZkNki2sExX02W9/Ao9eGA3avv3STP/ltAWWx00MLMD3It2V0WRBaZ7tmfLG6FLNgkjteLW88qxkfAegjm87CZpeUwqOFayDS4yXqkmf5XSssHyeuFIsSReF+d48DNYu1vvG9wgR3Ibo5FN7KgFnCHu6K0NpG+yyzX8sv7QVR7RV+4eHZB5pvgc2Yi4N6oZGCuPPR+1riSfs7VCP/QcmKFpvd5cwiNIfsT2yHEuJVEEvYoARiSjxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pGncp8N/6pOXoQ6UG6LnZN0UPFI0c/4qN2TR29kRXA=;
 b=iYaByWMHFgZqkz/gOrTc26Agx1FOtmfofM7zw3+X3oNlWI6E7I767AaDLRhTlnra5Q+Z724+uEf33DbiX+IImyYu91EUDETyWlpC5ySowUOEwMJt0jsb47UNdR/y4BfWfTLyI8JriFQ8ixUnpCHIblnKw/83NrjubErUD5OReKTLNTs13EB0YvtB+/XeCmPdLfoIcd9WExJ21ATBkq7b8F2I1cBIT/HbHlVPfARJ/xFY5mbqMQV/FFn2YiqFYvjCHxBVJuJB6/ZsXQe5MkeG7PgLDzcnsOuqLD1KCJ4QICo/4jIZeCDegGGr5SnQcfY7KAjYcKfT/l/McvAWv8ZvMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pGncp8N/6pOXoQ6UG6LnZN0UPFI0c/4qN2TR29kRXA=;
 b=J9wwD4/v3E1OxGuoYk145e4MFl4m780krI3U4lGGuOdiv6RaygU9pJ/1nAGxONmSZEjkBKHmF3ccjRbtJdtd1Pzwh8IsZvBRZvp2/UDOgYGtfMpm9BnK0gcnLdvIrQ0L/Ve6VWA4WHA/BDZwgSjILKr8sM2urZH94Yi1NEoJQcmuAnUiiTylnWaBnXqogPT1xOIMkLxgKf0ahTaaFrN2s8AiaHLM2nxLCdcry1D6QfJhqd5uwVHV2XDYBI2Il1VG0MPaTYW9Nbn2cAybzMe2DDdvrtWWn8rlzKoHXRH82408oqRMC02oa0N0/afm1GhpT55q8BIZmfrMSu85++jBCA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB7371.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 06:55:31 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 06:55:31 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] docs: update sendmail docs to use more secure SMTP server for Gmail
Date: Mon, 25 Aug 2025 12:25:15 +0530
Message-ID:
 <PN3PR01MB95973B72C16F68D63BE2B410B83EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0122.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::11) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250825065515.7808-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNXPR01MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: d50ea07b-75ae-413b-d712-08dde3a4617e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|8060799015|19110799012|5072599009|461199028|15080799012|23021999003|21061999006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0v+UVbvyKGqa7VMiPiZQktlQ5EVsZtg4sGivZcutezVz5cXfQghFRUE8Qvmp?=
 =?us-ascii?Q?W6PdjZJo7tiQ0V9w7YgHfYwigDuGNa6cqiq0bmVcIic5phBMYvXlOpkdkK08?=
 =?us-ascii?Q?E2JlIAcqz5F49SuaIpm75BCHyCwDdEromqZMbHdo6fL/0xgEFMGKGjj8jzME?=
 =?us-ascii?Q?YLAnnEjEPGENb+gEoSGatWt19h/uDLNVLKdlBurHV2zlvMJtajzMwtOZLcnX?=
 =?us-ascii?Q?AYwlkSavRPCfjn+1UJKNPG90vGghw80bhWcnTQaIaaU0o505NBRvJHR9DULN?=
 =?us-ascii?Q?7uq/AtZePJjmLrXONjN4aQXQtfDf9WwxFV9Eo1q/a27cj1x3nBQUES3EAlxM?=
 =?us-ascii?Q?SEdnR35Xam5GaQgUxhPkh8LsL1559JEiRFZIJ3M5skQDG5nYrBb45247X3IG?=
 =?us-ascii?Q?FBjlmGnpQSO1u2OxpZ1BHVH8+QUEqigFasRAJA4bgPa0E9n5YNbtORNQGD5U?=
 =?us-ascii?Q?DSn4FcE3qkNNTHTTKGMNSkSa0UBH9/4PwtB2GhnN0cXqMd6B+rA2LIZ06X+H?=
 =?us-ascii?Q?dX9oEflOs083hcdzTMzILtXnowzBmG5llFDKJ6zAoaL7zfzJWjG6tEfhB5sq?=
 =?us-ascii?Q?KmYoRAjIbETAhcI97j8fPj1mlHrQxsmlnpwOPZnKdzt6PBosYOawqtRpFRGi?=
 =?us-ascii?Q?fBZjlxMyfpjcfPQMmnRhnoquXFFWjv7GaWH9zJKuseF8X5vPnfjs5yZFCeAo?=
 =?us-ascii?Q?JI1UKOt6x+qhkc8qsLnYyz9dbKKf7OtT72qD6FYhxtXpNa47JMuLe83RsR8A?=
 =?us-ascii?Q?hGSs8FlJvfSB9OZh338T5xlWX7reaFxHwkT1CjZCVgJTiXYT+EtGDmkfTWUu?=
 =?us-ascii?Q?efOlmr8DwQ5bEKjUVIpn+cgYXLX/xkjh09PUqEG8Tzfa4Mly8uoc04tKtXOX?=
 =?us-ascii?Q?p7jxNE4oOn7DVjtY+0EQh4/N8QUrY5MytiyvtE2ZfQDxkTu2K2xcRUbzlEER?=
 =?us-ascii?Q?/ewNR9VTGxlsr8F+/aD+5HmwHzO9AKTG2N0ooD55orlTjkihQt2z64q4OBJg?=
 =?us-ascii?Q?hHZSyfnHea+yVV0mrCUy2sLNivcdJrtHor9O8241JhrE0m7hIX3BKh/dmIVe?=
 =?us-ascii?Q?RFo5pyiT8NDwpsF5JcyAF9Hzzh99PinxXd039wrRcFD0GgPjLfGH9FNwhtgD?=
 =?us-ascii?Q?+2S+iI81uiXBtIc/lLMqK1smJ4VXkQ2APkaSZLCG530CRHiWaxzwph4GTzDy?=
 =?us-ascii?Q?q9al0inAtdQ4K2SJCPdzAT4YTaGVezGrMrC68Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HAapMEE3pgxknLMTB8YwfecZMG+EpxqPgtM131sgTwbMwZiUXdl1fHhsSTvY?=
 =?us-ascii?Q?YZJLNS8T9ZimeMNmdezujqhGLepSDHXXNKvB2EwifdOgA4Y8hYVwBHiQ0zPy?=
 =?us-ascii?Q?aIg2U+EJiWQlq/LvUo4gQZocruRzax5ABsI1HQCmSIDk3CTmAUlfoWPNOhrK?=
 =?us-ascii?Q?AhBvbrrp92RKbuYJBRmit55j2AHs1dLAKhFzwHRv5U8v+kSAig+Ki7n3KGqS?=
 =?us-ascii?Q?qfl2zLY8XifHW7tFFuI5qoyS0fk+Sdl0LzOjpJaQvaJoFvNGHX1kZAzEIwaa?=
 =?us-ascii?Q?BD0mrznGAb5znGRSUk13BqIPe4emQTeS+PQEMdeIou/ZoYNoxX1Bz9NmOMAh?=
 =?us-ascii?Q?LFXDjGJI2+5uUJUUsJrsHkqkD/xkgpuUGsb6gO6CnJ4uFVECexpbPZ3zQ3/g?=
 =?us-ascii?Q?3/iS3t+dZjM0geGXKAMhQscn3V1WQNJiSnpp7stfkTil7EdwiDDqNKnKVCu3?=
 =?us-ascii?Q?L2/Pio9VR7lBkaVsICFkgCRk5O+Ztl75/wwBYEADGadfdqg/2ZbFj4dlQbe3?=
 =?us-ascii?Q?YmuoF7bnvR68IfzBaGaFcdh8Hs69+rxhQpc5hvEbXw7wyV+1xT6HT+vRR0VS?=
 =?us-ascii?Q?0+z66G1mqV6gYIOJDr6oCIDQXpAjI+fAYe+Min3+3m59QPxqc9Y4vHBUwtES?=
 =?us-ascii?Q?L53MdCJZWH/OZZM4hwq4/0MbRqXrPBNmyapcqSGo/pgPLA9nFVAdsSPfhv1v?=
 =?us-ascii?Q?XbIuaWF8qVuu+5KXf61NiITiWU49MJTYgBTUqwg4p3dHb02v3RjNXqe5jzb5?=
 =?us-ascii?Q?0pvEganefbMslvWpmOOMRcX1icf24YP3zgU5wRpJTNvQkVVL5jCgRbCT+A7H?=
 =?us-ascii?Q?M3mV/Ic3FuMtsiHbZzJ/r0gPIxmVthvr58sLhL7wEmOLZpwtX3seag0rZoJc?=
 =?us-ascii?Q?/vBhvm+ktOgkX7lqOBjAmEmEKlrHX8rmirsTtlkznVjN3/XX2ZewiH4y2fVq?=
 =?us-ascii?Q?YM4+zVcD7APaw+gHchWp5iRktz/oxHxT9FLbWfO9W+oqLEjB6pN5GQMNUftv?=
 =?us-ascii?Q?nV3ZtbCqhu3DNXYX3ETEHeSvACJaSS86LDPYY42mKqTH5BX5wJ7jqgDbYbqu?=
 =?us-ascii?Q?R3XOXlV2nKbnJre4wHiuY984rx2kaa5WKEbj65j4CTtmyzQkgAHF1qd54VRk?=
 =?us-ascii?Q?MEnvRysrJ8lilBUSMzT4dTrHdjNDE7ENQT745yCwtYGJlMIAU7t5qP4g/Kim?=
 =?us-ascii?Q?Z7rj3Z1I0HcdK/DKbEjVwb8nVLzS/QZVJsu8rkTFjTQps0dyXKtAwnpZrUFs?=
 =?us-ascii?Q?uVkS8cQAnBnGi5ZZK7d5//XecyQJyX07pApBpaEZ/DvlUIrfnrWlTKplSLcY?=
 =?us-ascii?Q?Qx0=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d50ea07b-75ae-413b-d712-08dde3a4617e
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 06:55:31.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7371

Gmail's SMTP server also has a port 465 with SSL/TLS encryption. It is
more secure than port 587 with STARTTLS encryption. Update the docs to
reflect this change.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 5335502d68..c610909a92 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -521,10 +521,10 @@ edit `~/.gitconfig` to specify your account settings:
 
 ----
 [sendemail]
-	smtpEncryption = tls
+	smtpEncryption = ssl
 	smtpServer = smtp.gmail.com
 	smtpUser = yourname@gmail.com
-	smtpServerPort = 587
+	smtpServerPort = 465
 ----
 
 Gmail does not allow using your regular password for `git send-email`.
@@ -542,10 +542,10 @@ if you want to use `OAUTHBEARER`, edit your `~/.gitconfig` file and add
 
 ----
 [sendemail]
-	smtpEncryption = tls
+	smtpEncryption = ssl
 	smtpServer = smtp.gmail.com
 	smtpUser = yourname@gmail.com
-	smtpServerPort = 587
+	smtpServerPort = 465
 	smtpAuth = OAUTHBEARER
 ----
 
-- 
2.51.0

