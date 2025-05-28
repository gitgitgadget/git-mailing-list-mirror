Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE524678C
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417938; cv=fail; b=oYWFQS212XtXRyve5HowtNNaTPPwUXFUjJg55K1Xnhjeh/qalxEtQdY4S0fChqF4ceN1qyZhDO3MBSua/ynnjhdIM+SHSo0xkGNEXZVmV6s7U0Kk1tYpNN7C4qOdjEQG5v40QKiazlmj4rVOKJbVIDJssh6RFRMthq6mTX0aug8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417938; c=relaxed/simple;
	bh=aMW+ySwvE80biy56+dljUjJR1/hQm948ajw+ioiagyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zn0CeBX5x19aWQ+XBx6SD7u4PaaMLnZzdKywnGcCnt+7FDD2qggxwNNSIdbDK55ieU0X6eH8otBUBEwjZq07UQOYrWphSNAEyPG/50tS/UuidwoSmB7HS08SZFkxBc/bxHewF+BYeyJuqAYu0rermsYSUAkFlkDedau/ghrgDiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=avRBUlFM; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="avRBUlFM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiPQJm9E5brc3C7FnEZ0dpBNCVsEtQv5atnHtkTUcyJ8+croC9n1YwyhjxU+J5JRKokBdPjEGuVPJ0EkGd+7kkqpAcyHQ/n5aa8aEf0qQfw52DY8bw0p6wmTfWPnFdwDoYRDvRTQRYDq8oMAB14AoQ+VeA4dJGkX9vV+JyDDZeqTNss1f8ylg4L0ZVjc6Aop5a00VHS4X3QB6SmkvMyHcKxrORhpW/uSNGl37dT0X2CGb59gKt1XXwytblVE5/+lII4fxNd5OmwGZUo2SAAQlExAoLpaSaFm1/QWvP26b3ubp3T1qG29Xeid55SMaQIRJIimpu9ar0sNmkKeV/nkRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JiyoJzOFKCBFXq2WbZUoXuq040AToLtbOfBmgtsgzc=;
 b=FXMvrWTLPzpT7G4ZliNAGnDrrBNPawWPiX7UkTDYZVkcAz4e5S9MkWzfP9Oo38N96vGabGOkIgmYJi+TeFk9vxvkmE8UKqYwbCnsDxrR8dX1YVznjfYJQCODHG/IPLWvEuE0SEE0MNmbY7aCfaaJbU1wuTDV+o2QPFh8jAcFSeIprOFl8IdYrQ6JfZyPYTLibfKhOkBwu383vCopj6G/1gi6yMku74JUVadsPUAzH2BKrdWNYyOL74FBCiCi+eTVKRjPAGtxN30fz9T25NJQWcmuWL9P1esUu1Zk28oY2XYB3xsGjR7AT+GLg5coDm4REAwdHpqv3jyDz4uUMG+teA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JiyoJzOFKCBFXq2WbZUoXuq040AToLtbOfBmgtsgzc=;
 b=avRBUlFMMswRp7jYj1+HAV685oSbMCFZtKTs76BgU/yOCj0cya7lG2floB0JmfExD4RbTWfhShOVk4o63BLQxDryA344sjmJAqlAXZnqVu2ojO86bNhN8T5quZad8Cb4aglaHw+woR23Nis7wGqGF8qxnWeokhdwnxUrQPBYkFJR2aap1nrZdiG404YidKNEd2+rZKJ6htZvuYemUSqkNEYIAcMg7zJDPySaVXMutwU4e+x03F9DNBVeLJci86hrHppS20e17CnqZoCRf0f5yL/9LaG7aS383pDJjxKa/ibkDy39RLpkGGVRhnSl7ZtrlIIzkdQI4XbrkQtWvzCUqg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB6577.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:72::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:38:48 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:38:48 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v6 6/6] imap-send: enable user to choose between libcurl and openssl using the config
Date: Wed, 28 May 2025 13:08:14 +0530
Message-ID:
 <PN3PR01MB959731669B2B76C272D63C8BB867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g4769924781
In-Reply-To: <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528073814.29138-7-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8b0368-1dcd-4fbe-38ab-08dd9dbaaf31
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnft2ZtfjQobv12cKDGj8HAXuO7KRJ/8X22IzEw4uZE0RkQbif+cypFevPLLiIKv8mVPDRcVQpI1i174awJTHuXjL4ratgZwQuSAwRg2nSb01UY+62aVwcn/r5whaza6EHz2+OkEoJazA2wKUQXoi8SJCZVv8Vksoihs2jdO/AvBMBOG+/uyVTl6I7qEvF2rxHaS1Feya0Xs7iuvxwdCEXoBuH+vHeVQzclUMaLmR15Y4p9asQ/BU7gYHay5Ss5Dm+voN/XjSd3U+LSO1O6hXn/gaf92oQ/eMDhtOCe2ogsjxfbLT/IScnRk+k27Uc9MB8Qor+ungxWruybQx/2vqY5xD1I4SFMnyYrOoS7hHjd9cz77CQkrB4S03i4BD2h6N04VfPIuCbEoJE9Z9DJjRMWv214zuv0V9Cjz/2XFrvo/guZs2a2Sraf8KbdTLSrgd9cqsLAIv6z33by9oqwYxDk9q9/oTRollKAE7gejBo27BZ3T8GJ5bXnp9r5F1j1RaLACqj57gRAHgv60U8xZdbRU5B5VNo2IQk06RmlbvoSyjP3Ze0teNdHktGTkkAo+nbAOA8abZLXXZnZV/0aEb9rmzzyxBaKZYuek5akZKYOUi9Xu9CzE1k6OcczIOJ5ZGe3pPQ4Ec6pXaC5N7h499NmO/8TuSL1watz2sb9XGB8/eHbn+4S5kJ1SKU06N+XEwCM3vtMqUDAVkZ6pEMjpUZynzn6GfYEpH6i7Bzb7Cgllk=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|41001999006|461199028|7092599006|8060799009|19110799006|15080799009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uIC263g04X0i5yZ3vZAvi9YsdRYLPCMrXX4z7lYAihH4TvGtVQisqJ0QxwRW?=
 =?us-ascii?Q?DMfm47KpE8FQWb3BOsYJnwiH5+zH6WOeBtLNrk+GNLh183GRFXpC+D0FBtyw?=
 =?us-ascii?Q?65S5lIUdpgUyyINohvvDe/F8EYERhT2zTeEZIUKVIq2rY2zmjG5Ty4Idvd2Q?=
 =?us-ascii?Q?Sqm6K2t7Gv46n9h38IKdb//Q/YpAQhg2xmqMUe0a63EkMnzdiQLLUoOIJwY3?=
 =?us-ascii?Q?5oeqUXXsS3FJcOdOuEPgQ9b9ieCtaHeSo2J6CQJ3JBnM75If8/YAoWh+byHl?=
 =?us-ascii?Q?mYDVXisG8OftHTCFqPL+13eh9upM4aLs7kw+ydhdYKrg6h8iLivExGy7sarN?=
 =?us-ascii?Q?dGoG1EteLaZ2QEGuZSPVqMPsaR+teQaLUv6BnofYbobFqBLw/hOkHUE7OzR6?=
 =?us-ascii?Q?WEJwjHGHbRHArmehYqF0q8zaqM2xORkcPJor7k+f6elPd43CR0nKHYR1f6sW?=
 =?us-ascii?Q?5MC13D/1Jrsp/2Di7RivwRhz7ofSQp9GdRCHHAqSknH40VSL+DBJcZaUiUfW?=
 =?us-ascii?Q?t8AhgrPZRkR8VZjny/NKOeSWhPAskrVYHDy35yuCZDGtNEjzfxLC53gYvvIG?=
 =?us-ascii?Q?pv5NaES3FAMIndYOIAedP95DKt1CSu6ndskKy3+ODQqYLvqgntt/bf4oIxAy?=
 =?us-ascii?Q?j/xVsSSxYK2RJUOcRK/Nmm7agNbaLDXyJKZ7sHrhC0AlXNLB9noNXZ2Frh8o?=
 =?us-ascii?Q?D4JWPpMII6D3ZfkTdMwftNCWEG9CUqTb3YzsuGMzCg1bPMAKAym5MSlgP9Q/?=
 =?us-ascii?Q?pQC5ftbta8FK/PeRR5kfG6ISh5PbAZ98pm0Y92FtWUNPF+oVWgAi9Wx6KL49?=
 =?us-ascii?Q?n3QSfRmIzMwYWwhiKPMi1nZK1UrBe6T6MkOEQ8e5dy7guytZjEFtESraliFd?=
 =?us-ascii?Q?J/Eg8hn4BgplhDiP4mosZrSbLKxQ7nZt87fIbTiVOYijt0lDI+LqhT2IrEyr?=
 =?us-ascii?Q?53eb8KM4RrHpYruGHsAm9X1fZNfR5/GUQkF9/szOXZlx26M35OhV3Qyb6KI+?=
 =?us-ascii?Q?RzU1890XsZu6haU3t+QJ3ZHM9zIWZ9Sn9AcIP8hZBtELIrQwsXjSyRa7sftj?=
 =?us-ascii?Q?1UnLx08VuGkWyLITKX7yB5GA43q8bmnXrd/MTZDENjnSB3xj+CKV/PNZXCl0?=
 =?us-ascii?Q?j+IFUP0wQFMZ/hjABF2WDk/9t8ahTdH4LQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?79bSh1vmEKMj6L3R5wc4ew46/sFutdwnCBZKgoeDN0n5db3ftjDEVh7Ork4g?=
 =?us-ascii?Q?BR2LQR5nTI3d7oDSFzqyqUv33ye3Xkqr7AjVLhMPunoJ9peFKDZmFLFbJ2Ab?=
 =?us-ascii?Q?SHsmZmk+sN5sdoaRK2I/ZT6/H7sz26KC8toEKW8AH4RilMamUiH0DdFNyHJH?=
 =?us-ascii?Q?VgFPYfci35JZ/wv4hkAVHJKl+me+9PxGcaDDug+kgm/vDjJIQ9ra1oRC8M+9?=
 =?us-ascii?Q?w3B+U3f/qPLl0k01Y3To8sYZAnRaPg7I4jCGh7lCVfK6aCY+QOGAXNKMuuRv?=
 =?us-ascii?Q?2gjmhn9JjxD0sqb5WtUy/p7Ym2JrQYMU84/p388oX/9H3tfiI+DJf9j9gu2R?=
 =?us-ascii?Q?42ZsaCRZ9lXBshZKjyBJJLfp5r3TReucDXO7I9nV9gGCdP269+/FD1qM82oZ?=
 =?us-ascii?Q?vu3Z1FyxhikG5yq5mxJDQGCum89rkmMP+VeXxNd8g0BJ3rIcKYqfWyFnNjsq?=
 =?us-ascii?Q?LVxqfp1SfbLwdpg4lRQKirnOaaE4ugGxm9gIi70gwejXFss8Ht/wgiQwzQtb?=
 =?us-ascii?Q?HGQashc4ktiAmSfmGBP7CG5fKI/3twlQYesEPwxt49KFtKgUwFvZg5s7a3JC?=
 =?us-ascii?Q?usRjYFDjRs6PgTuU72FhUBPEwXkkUYihhOLRN8y6E+Dkg8vtn3hovLXCoXXx?=
 =?us-ascii?Q?/7rweGA/LqmlRYlJIG67YdIPNS9yiILxF5WhjRWeYT+e+E+/vq+5UtHi9Kx5?=
 =?us-ascii?Q?Z2kIb6QwOVTdVfHTTDhhGEUO21S53XXeXVfazDEb5Hon8p3qwPJkwso/j0QR?=
 =?us-ascii?Q?YOACdj/+spPcq0ljXquHH4bYaqe0Z9qtkErjzcinGqvokmU59KiIpHLrdA6o?=
 =?us-ascii?Q?y56UpS4aj4RhoIb/g7wy0ioILG/+/s9MT1SQ2Q0SK9IXDnWdJBn8Rqc95Ib0?=
 =?us-ascii?Q?hpHA5WqcqWF0ZGAs/6I5q8Hg+ue0pb4NxgvPOFpc42Uhhc3AlKKKw0REJGYI?=
 =?us-ascii?Q?EbRsPh+bHxoiHeZG9WXKtLdA2AJ4M8WNj3xv6bs8Sd5SVIewKuJGR4nUHxaA?=
 =?us-ascii?Q?Z0Y5I5cbvsYcmGimvvEKXSqKMfuyXUYW/fGFiy/A9CN85uBEuYi0r0Bv99ZV?=
 =?us-ascii?Q?xzG3IP7jefGCh4hIGOqGFaXHhPjopJ5hOgQjxe8yHF4HB8sNoTMfkYYf1Mu0?=
 =?us-ascii?Q?Zy4Xm1k2iJ93q2I5vTgi3ZHSbDmtZkRwwxJj707c7YNVHdHBfiTZvgpc3pGZ?=
 =?us-ascii?Q?SqT0Cr35SGcKIRALX+8DhpoEkULJESKI5x9aQ1OIxNklEW66ymDrQSZQdyDj?=
 =?us-ascii?Q?mwFzzWXi7A/0Vhphn1CyTdzib8ZrNuSdeCGdJHfsO4YZb37RiWhWrBIqdq2D?=
 =?us-ascii?Q?EGU=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8b0368-1dcd-4fbe-38ab-08dd9dbaaf31
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:38:48.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB6577

Currently, imap-send allows the user to choose between libcurl and
openssl in case Git is compiled with both libraries only using the
command line, and no option to set a default using the config is
available. Add support for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   | 7 +++++++
 Documentation/git-imap-send.adoc | 4 ++--
 imap-send.c                      | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 829d9e0bac..608c0be7ab 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -25,6 +25,13 @@ imap.port::
 	Defaults to 143 for imap:// hosts and 993 for imaps:// hosts.
 	Ignored when imap.tunnel is set.
 
+imap.usecurl::
+	A boolean to choose whether to use libcurl or not to communicate
+	with the IMAP server.
+	Ignored if Git was built without `USE_CURL_FOR_IMAP_SEND` option
+	or with `NO_OPENSSL` option set.
+	`--[no]-curl` argument will override this option.
+
 imap.sslverify::
 	A boolean to enable/disable verification of the server certificate
 	used by the SSL/TLS connection. Default is `true`. Ignored when
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index a35f278baf..cbbe534ec2 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -46,12 +46,12 @@ OPTIONS
 
 --curl::
 	Use libcurl to communicate with the IMAP server, unless tunneling
-	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
+	into it.  Ignored if Git was built without the `USE_CURL_FOR_IMAP_SEND`
 	option set.
 
 --no-curl::
 	Talk to the IMAP server using git's own IMAP routines instead of
-	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
+	using libcurl.  Ignored if Git was built with the `NO_OPENSSL` option
 	set.
 
 
diff --git a/imap-send.c b/imap-send.c
index 51372e1811..18aba005cf 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1559,6 +1559,8 @@ static int git_imap_config(const char *var, const char *val,
 		return git_config_string(&cfg->auth_method, var, val);
 	} else if (!strcmp("imap.port", var)) {
 		cfg->port = git_config_int(var, val, ctx->kvi);
+	} else if (!strcmp("imap.usecurl", var)) {
+		use_curl = git_config_bool(var, val);
 	} else if (!strcmp("imap.host", var)) {
 		if (!val) {
 			return config_error_nonbool(var);
-- 
2.43.0

