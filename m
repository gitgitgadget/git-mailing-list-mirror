Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011036.outbound.protection.outlook.com [52.103.67.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3851280CD0
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453720; cv=fail; b=hKaUgmLg2LTtZoIGLHPMsFCJnUpoaBxqG0hEHSFhEXLb6VdapZSetx2bnIW1I3RVwtO5TXKYU5U7lOx/3eyewt43VdCo2z/H349R0jbkT6x3WE2qCxB+UWWWwsv5lciupdHoxHoPNBY/4HMeP2ocQNvg+PP/3wjxaFfphZ0IbPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453720; c=relaxed/simple;
	bh=MDyonNs3S9hMnIOUtjYFpzasfd3yBhpFyKq8ijA/yWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tCpJfAxw/BhjmstmEGeVVYtoYx5MEEZzYOPRwLw0bg3lvYAjn5fiqs6JWj/ii8zVT4165xxp/8KsSkd3psHQQpdMQvVqaAgYtTU7V+v5PZmhavxnBue/vvgxT80XBlkWYz/IB8WxmDmV5iHEfX2gSFcK2eQmk6l0JccV677AnnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=k8dVQBvR; arc=fail smtp.client-ip=52.103.67.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="k8dVQBvR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T4Dj3HyZkgKyzapP+2wrUU5aEgdAIK8Wr2/pdp3mjNIJs6PDe61tiiHANgy9D7N1kauVZ3TXB/Cmd0GSxroEo7i2IsYU8kTE06S20l1iPPOgbmO0CV8eLXvuo6R9eY5A1PT7I3v4guB1hj42O8Kml0BKImcWgc6DHjKHxnqbCdOhqbZhaJN93q9SO+1o7VD0zNkU4RXyyoq/R1PAlrcDCyHOVzUIbdVAFBHhLM34puOHTArTUlRv/RW9sS0ytschf/0piOKLDHbS9D0ETAMRQ49Maw6RoMy3HpfOMeUQEykYT3i+9aEMlZ51hkYC1FAwqg5i7edlFxpwjgtVYhDjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJiAQOZ9kHCIzZ6xwRzao2EYd2XYbjJI5KhEb9yerpA=;
 b=TeWBIRIi/2TaIDa8f1e2FFUcEWSIGx/x3JqthNHNW8vsQlvTuszlkrGnpjdTw3lwuCmXoDdqiLgsR6wQ9+2STKjYdKsl6heyP3w1KsWUBWbi0Yx36GOTPNLW2QzVCpTnAuyWUj9gPoMSAHHjJwpfz3kWYbLuC39RXgTm24t2Hk0835sadt0NTfji71cYrTPVJNpZ01bDZQ5nT9uj8hm36jMXslH0LYSkCBwSM0yhbQUuPupAhlPtndBsn51i2beBJBgKGwqbKM28zgGExSrMqOkLDBdcHPYADDpgbBieniNLlN1HOzAnnbXRONg51FFU2OQput6Xnpt0HdVSNgZ9GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJiAQOZ9kHCIzZ6xwRzao2EYd2XYbjJI5KhEb9yerpA=;
 b=k8dVQBvREcLyzghMa81b0MoSoC81X2qLSangZo/RfjZp/yvVzaJa7CaiYEJrgdDe2jdYMY+QkhkJG4Tfc4hyv4D1FvX88lrmgEMYtn5/1Oy9caSMmbiHcYOEdjFH15zny4gm44lMAsUUyx7kUCe7pxhka2T/HslOBkTKWLDreIjI201cA1bz8mL3EfLZejBrzgVjpmyxgZg2mvy2zMJ2s+eNMBOs8c5xrorNQ/24oii1gpZuPx6yiBGkRWj0uQlrYjX0NJdQFajgCzB80FEmS1r1348OcPIEaO0iQ5M2/SMfPdQgP27PThhOv2o6zgxHh4zUcnKligYpqPeBxzuq2Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7959.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:21:46 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 07:21:46 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v16 04/10] imap-send: add support for OAuth2.0 authentication
Date: Mon,  9 Jun 2025 07:20:35 +0000
Message-ID:
 <PN3PR01MB95975D9E41AF28D2C67BF0C0B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g6561d45bee
In-Reply-To: <PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001B5.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609072041.12114-5-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ecbca0-066a-4c5f-cd32-08dda72647cd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799006|12121999007|15080799009|41001999006|7092599006|8060799009|1602099012|440099028|3412199025|4302099013|10035399007|12091999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RDQAMVjvd/v+HzqBA/oWfwbwzrDrMlVuho1YfjC6h8Q7LeTtV6Z+iDHFZ7BL?=
 =?us-ascii?Q?wlfZo8dYxtJ1Rnf159CvEK4HylJ5QS1A8LJnUwZHWznE9Wv67qWTYYuVkQwB?=
 =?us-ascii?Q?oEtOCVRjtkpHaoLBsH1CKl+DWr/0MTV8X46L4H0QXjnK1Gg2zJ/DBlS5Sn2A?=
 =?us-ascii?Q?Sep+L84WVpqlKbqJuItRmrKTt8nqlFyLtXy2yCa/iynHw4mnxrijaMhE2YPZ?=
 =?us-ascii?Q?DC8JheUUdTVMhU5wli4XS2ENgqf2kQnjhb4wpm7QBlYg9wL6xa3jbMw8M78R?=
 =?us-ascii?Q?jtajYVD3ExEf6dWepN5KXWW8lXYoMaJjvEKm1xXnO8sXY7azSUmTQkuAF7vJ?=
 =?us-ascii?Q?eMHqRg68XJ60N/7Sww/et5VlaSQd9ARn5yIO4ZWWGaRWYGqqWRssPopO78hV?=
 =?us-ascii?Q?xbwQyuIyql8W0ixMmWFTgg91+m4oNqZSMJ7vusmDLknNNOWATej9oe8XkEAb?=
 =?us-ascii?Q?WmIASjl1wBVPgfigNm+BHjSWS7VqPMGDGB3QakVonhT9EXU0srXv8ufWYKa9?=
 =?us-ascii?Q?AxAroJaEnuL6SEy5tVf5nMuYipHTr1suYcskLTzyqoZ+sruwzxmAAvEpzzps?=
 =?us-ascii?Q?E2HKP3ENleD2KaLkYmTszdRgWrwa9KkAang6zj99nvNRtVhIqa7x8sPbIN7n?=
 =?us-ascii?Q?LYC5ohT3qH2x0LseWl0nfoR6kzz1G7Ur0grxdfYKQUej074F/BW2qg9P77KM?=
 =?us-ascii?Q?r9AnN8nveyzIomiGgH12LKI/r54QORFUMC70USgF0g6QFzYjndz48jY1irG8?=
 =?us-ascii?Q?s5aVqpPZ/YJtzDbUngNTBDqMkv5eNkJqRUkm5Zbfn18kyZozYHWxkl2UyMO3?=
 =?us-ascii?Q?AhVNGAkedyTnQUcJZA7xUpmYfUJqLs+ZMGT3Dn2TK264Eb1GYDr/5EM5RabT?=
 =?us-ascii?Q?tlRw0AIjPi/kS4UDymfloj8KQ+r41Lqj3GZK6yWZDs71yyEREyOhpaY0UzW/?=
 =?us-ascii?Q?oMYOfowsJ9SevoRhB9aHHFN8NsHeMSnLfiYfOGo5oFc3Fovn44qvBmFf7rUr?=
 =?us-ascii?Q?EpHVQIYOIWrahalK9cc1uKEYDV5hgQ7z6rd82J3F8OgZmv9N4LJmIsrcEK39?=
 =?us-ascii?Q?FdWGzi8yNAVXBjV456JEG/1ODr3yzG/aK0XIgnEt+GlLBLW2MwXh9HnVKkdN?=
 =?us-ascii?Q?q/kEjEeR4ZGjQl6jKr2vJkocy9yO5zLnFKxJ5KCT9fv4/ngfRqtXpfrXyNPP?=
 =?us-ascii?Q?CgOu3ddk5xa1AJl/0Xtshi+Lvm/cRBKPSnW7R9NIs7NrioJe5sJ607gZkoxO?=
 =?us-ascii?Q?FO+jJfzgaoZREkmUJGrUbjRxiYdT1gXttITDRt4gheF2jUBwq5uy01WAdyDm?=
 =?us-ascii?Q?PEe+KijkiMuTzPLbiMrPRc7v/DIgvmRNih4iyHEYA/C6r8phe15IIFf916Nv?=
 =?us-ascii?Q?pDprdNY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p1XcBpazCLzDK+1vEPqe9AW50Y7T+aQqQsxHI2XEVrMQqmxnViBj76m0pVLU?=
 =?us-ascii?Q?flBeMpn6U0H3J7P+mDiHLJ6imwHEgiDvJxtP8YyqKaOTT4ATWQ62HNqIbE7x?=
 =?us-ascii?Q?iHN2a8IU6fhh/lHQlhgYaaswJBZVzvZ2cvbPH8+sV5RZ+A3cDU4LW6uknPHo?=
 =?us-ascii?Q?QJF+gyPvyXfFDZjLBGZRKXBfPRedvOlWpkIMnu6ER+ile3f6jhZl4wUR/2RI?=
 =?us-ascii?Q?QcdeLdxMU89KbZ7pt/Nry2r/swa44uYHIN/BejeTRkbMAX+169OJnlNC0QbN?=
 =?us-ascii?Q?SYQA1B3W2cP+acG7RRQJmgz4OtThl8JLAG37/baCQMwhCuVRlAQRhBSD2lBH?=
 =?us-ascii?Q?vZ3bH6oxk/xDKL2Hb3R9TqKWco38WxyYNEmQ1N0Qg/S3MlBCsEBl6La1LglX?=
 =?us-ascii?Q?C1/WpS2DOkwASuSCDHOueL5W0Biq5n16Otp6XcFtIfwTY+4PxiUTPqytW8k/?=
 =?us-ascii?Q?jXUOM8KQMRLP9n4y+ZBdOZOqryOjB8iAhLpuaQ7DlTU6Hhs5BEoCSGRimdHn?=
 =?us-ascii?Q?1HjXVKsxvNwsD4XBLGbELJ1jJFRRBafrSg/toR+M5PcSzqeYqcZWgH8e2Ckl?=
 =?us-ascii?Q?7shmufpSkLcGjiEg5LDUxfT8FUSz1FvXNlOYFgmIO7Tw/lUeUiwjuoJTB+Qn?=
 =?us-ascii?Q?ifvP9JXJLa+Hw3IKuPCVYzqg12fLSntq0W/L4cQWrPNDrJtzvXMTP0L4m/NC?=
 =?us-ascii?Q?KR/vCAArTEMrx4AX7TUsVH48S2BpkqkZi2WEKryGq/o3WTdwO5B/e3KcTcqe?=
 =?us-ascii?Q?lU+2I30rjKUVQ6hUn0D1ll173IzM9/wTjDLoEGPbMarx+JHRGNt421n2DLur?=
 =?us-ascii?Q?yv0ZQVJgAoQrWdrmAK2KIWZWqS0uhGNBTRK90Z//1y3ow6Kp05VgorLVEH3f?=
 =?us-ascii?Q?ijfTxEgv4QQ/rtuaTjsr+/KiedNJ321afPWSZhZ97g91w6dX+NX9m6m5Y1Ri?=
 =?us-ascii?Q?mAp2IyWZs1/uVqh0ykWuQsfPSod9OQ/j+NwdmAjouhExv4N6xbPMdahSqg8D?=
 =?us-ascii?Q?ptAinCctiIbJvXvKS0VFa4ieG+Tt5gFqf7P6HN+oQwvbN09ytlcmR2qs6dP6?=
 =?us-ascii?Q?qWGr5NRmJPq7kTIAvtA4Xz+feKvznnnfowBfRJFI8IsOov5alO0PNbphFJe2?=
 =?us-ascii?Q?5/HCNsmpnSTHthf3uhK/BFw5XE68G/9c8a+3eTdVgzPaxp7dxL9PW397jc3t?=
 =?us-ascii?Q?FyACkLDIwpyaynB60oUyOPAyoyT8V8Jd5p6yq6rzqbFuPqHEHbesoeYq2nM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ecbca0-066a-4c5f-cd32-08dda72647cd
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:21:41.4455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7959

OAuth2.0 is a new way of authentication supported by various email providers
these days. OAUTHBEARER and XOAUTH2 are the two most common mechanisms used
for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2], whereas
XOAUTH2 is Google's proprietary mechanism (See [3]).

[1]: https://datatracker.ietf.org/doc/html/rfc5801
[2]: https://datatracker.ietf.org/doc/html/rfc7628
[3]: https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |   5 +-
 Documentation/git-imap-send.adoc |  47 +++++++++-
 imap-send.c                      | 148 +++++++++++++++++++++++++++++--
 3 files changed, 187 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 3d28f72643..29b998d5ff 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,5 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported method is 'CRAM-MD5'. If this is not set
-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
+	option, the only supported methods are `CRAM-MD5`, `OAUTHBEARER` and
+	`XOAUTH2`. If this is not set then `git imap-send` uses the basic IMAP
+	plaintext `LOGIN` command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 26ccf4e433..8adf0e5aac 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -102,12 +102,18 @@ Using Gmail's IMAP interface:
 
 ---------
 [imap]
-	folder = "[Gmail]/Drafts"
-	host = imaps://imap.gmail.com
-	user = user@gmail.com
-	port = 993
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.gmail.com
+    user = user@gmail.com
+    port = 993
 ---------
 
+Gmail does not allow using your regular password for `git imap-send`.
+If you have multi-factor authentication set up on your Gmail account, you
+can generate an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create
+it. Alternatively, use OAuth2.0 authentication as described below.
+
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
@@ -116,6 +122,35 @@ that the "Folder doesn't exist".
 If your Gmail account is set to another language than English, the name of the "Drafts"
 folder will be localized.
 
+If you want to use OAuth2.0 based authentication, you can specify
+`OAUTHBEARER` or `XOAUTH2` mechanism in your config. It is more secure
+than using app-specific passwords, and also does not enforce the need of
+having multi-factor authentication. You will have to use an OAuth2.0
+access token in place of your password when using this authentication.
+
+---------
+[imap]
+    folder = "[Gmail]/Drafts"
+    host = imaps://imap.gmail.com
+    user = user@gmail.com
+    port = 993
+    authmethod = OAUTHBEARER
+---------
+
+Using Outlook's IMAP interface:
+
+Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Also, it
+supports only `XOAUTH2` as the mechanism.
+
+---------
+[imap]
+    folder = "Drafts"
+    host = imaps://outlook.office365.com
+    user = user@outlook.com
+    port = 993
+    authmethod = XOAUTH2
+---------
+
 Once the commits are ready to be sent, run the following command:
 
   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
@@ -124,6 +159,10 @@ Just make sure to disable line wrapping in the email client (Gmail's web
 interface will wrap lines no matter what, so you need to use a real
 IMAP client).
 
+In case you are using OAuth2.0 authentication, it is easier to use credential
+helpers to generate tokens. Credential helpers suggested in
+linkgit:git-send-email[1] can be used for `git imap-send` as well.
+
 CAUTION
 -------
 It is still your responsibility to make sure that the email message
diff --git a/imap-send.c b/imap-send.c
index f55399cd9e..5373f18b94 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,7 +139,9 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
-	AUTH_CRAM_MD5
+	AUTH_CRAM_MD5,
+	AUTH_OAUTHBEARER,
+	AUTH_XOAUTH2,
 };
 
 static const char *cap_list[] = {
@@ -149,6 +151,8 @@ static const char *cap_list[] = {
 	"NAMESPACE",
 	"STARTTLS",
 	"AUTH=CRAM-MD5",
+	"AUTH=OAUTHBEARER",
+	"AUTH=XOAUTH2",
 };
 
 #define RESP_OK    0
@@ -885,6 +889,68 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	return (char *)response_64;
 }
 
+static char *oauthbearer_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the OAUTHBEARER string
+	 *
+	 * "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
+	 *
+	 * The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
+	 * * gs2-cb-flag `n` -> client does not support CB
+	 * * gs2-authzid `a=" {User} "`
+	 *
+	 * The second part are key value pairs containing host, port and auth as
+	 * described in RFC7628.
+	 *
+	 * https://datatracker.ietf.org/doc/html/rfc5801
+	 * https://datatracker.ietf.org/doc/html/rfc7628
+	 */
+	raw_len = strlen(user) + strlen(access_token) + 20;
+	raw = xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
+
+	/* Base64 encode */
+	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
+static char *xoauth2_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/*
+	 * Compose the XOAUTH2 string
+	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
+	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
+	 */
+	raw_len = strlen(user) + strlen(access_token) + 20;
+	raw = xmallocz(raw_len + 1);
+	snprintf(raw, raw_len + 1, "user=%s\001auth=Bearer %s\001\001", user, access_token);
+
+	/* Base64 encode */
+	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
+	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
+	free(raw);
+
+	if (b64_len < 0) {
+		free(b64);
+		return NULL;
+	}
+	return b64;
+}
+
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 {
 	int ret;
@@ -903,9 +969,51 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	return 0;
 }
 
+static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("OAUTHBEARER: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending OAUTHBEARER response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
+static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
+{
+	int ret;
+	char *b64;
+
+	b64 = xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
+	if (!b64)
+		return error("XOAUTH2: base64 encoding failed");
+
+	/* Send the base64-encoded response */
+	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
+	if (ret != (int)strlen(b64)) {
+		free(b64);
+		return error("IMAP error: sending XOAUTH2 response failed");
+	}
+
+	free(b64);
+	return 0;
+}
+
 #else
 
 #define auth_cram_md5 NULL
+#define auth_oauthbearer NULL
+#define auth_xoauth2 NULL
 
 #endif
 
@@ -1118,6 +1226,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			if (!strcmp(srvc->auth_method, "CRAM-MD5")) {
 				if (try_auth_method(srvc, ctx, imap, "CRAM-MD5", AUTH_CRAM_MD5, auth_cram_md5))
 					goto bail;
+			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
+				if (try_auth_method(srvc, ctx, imap, "OAUTHBEARER", AUTH_OAUTHBEARER, auth_oauthbearer))
+					goto bail;
+			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
+				if (try_auth_method(srvc, ctx, imap, "XOAUTH2", AUTH_XOAUTH2, auth_xoauth2))
+					goto bail;
 			} else {
 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
 				goto bail;
@@ -1419,7 +1533,16 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	server_fill_credential(srvc, cred);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
+
+	/*
+	 * Use CURLOPT_PASSWORD irrespective of whether there is
+	 * an auth method specified or not, unless it's OAuth2.0,
+	 * where we use CURLOPT_XOAUTH2_BEARER.
+	 */
+	if (!srvc->auth_method ||
+	    (strcmp(srvc->auth_method, "XOAUTH2") &&
+	    strcmp(srvc->auth_method, "OAUTHBEARER")))
+		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
 
 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
 	strbuf_addstr(&path, srvc->host);
@@ -1437,11 +1560,22 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
 
 	if (srvc->auth_method) {
-		struct strbuf auth = STRBUF_INIT;
-		strbuf_addstr(&auth, "AUTH=");
-		strbuf_addstr(&auth, srvc->auth_method);
-		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
-		strbuf_release(&auth);
+		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
+		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
+
+			/*
+			 * While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
+			 * upon debugging, it has been found that it is capable of detecting
+			 * the best option out of OAUTHBEARER and XOAUTH2.
+			 */
+			curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, srvc->pass);
+		} else {
+			struct strbuf auth = STRBUF_INIT;
+			strbuf_addstr(&auth, "AUTH=");
+			strbuf_addstr(&auth, srvc->auth_method);
+			curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
+			strbuf_release(&auth);
+		}
 	}
 
 	if (!srvc->use_ssl)
-- 
2.49.0

