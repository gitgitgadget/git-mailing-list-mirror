Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946A28DF04
	for <git@vger.kernel.org>; Wed, 28 May 2025 17:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748452715; cv=fail; b=g2xi8uel4fWKRNUmopT4YzPVj+FUENECH3q8ATL7AqCYGh5UYNcyJimLKzrRk9SRkds9hzMNeyIFjXyyvBFfudEO7dqb9AoAEFb1pE157JVbhFAhQoGAjr02giTarydUPbQ3Cc/SIsNs6S9C2+aQIdYh76Obv1ZYRt4vAcANFqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748452715; c=relaxed/simple;
	bh=AFO8qVTP7JP7Fk/9e7xgJbDW4aMRnWokJg3nZ2hRPUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/pQ9oGfErGBTmryipIMMIAbuVVkDtnzHA0mKJ6l7pQvFaU5f523agh/tNvrtlJG35SP3mtVbsQoUPfqCXr3prXtlMdufRTd5WG7I74NOih2JqKj3bnjyKN6wqL6JIhTp8G4rNyxfbhR9G5WSsjFCwXDdlEXuHfy6Ivf1i2qifA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=PrI+fiCl; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="PrI+fiCl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwOy1tpMB+ju9Bi4r9hksbq0DL4GYnr+TrmUBK54he6m7fY8xBOLYPvDQ+SrzSGeRkz/NUWg1u2G/EqkkItygNVpuKuIf9zkz1my/uRqG/ivN1ciSxJr+DiG1TqI/korYBaDIEAFI28ChdTUUKwYVGALsV+dhIdYK5F1Lx8GiZJ87AolIkRNkgGagO72DomEm5CfsgGyt+bNY+ceZuBG2tR7Zkomzzq4NR1MD72L3ClJJIPwHlgKbnb2SZymbfYvKD8HWOS37oIzBv5YTaIRRxaLm/FHT7xWzUq907HPtZd2dMki6oStU99SMMYb7cJ3tEl8QYny/Gdgd0dZfGPUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkrQm32/a0TmVfUWaCqEbHkH/q6s+Gqe0TdV2Zq4J6g=;
 b=kP6z+PGll7bBtPbTxL/wGlu/8QiMlIjhVnnhMz32Iqv4gb6kSeT90hyUh6lUU5fSp4Y8hLNRbcTqjsk+hHD13kLuA1MjDHwlmwtKRs1wfq33tsOyNB7Cm6WF4QFIXpbQCmkwpqloHGAltZUvBsQUaH8Yb4upWwstncUrvVzZhFDWfguvLVRXUUUZWTxaySXkTa85SYnLlELxuHJEgocHJx9JXNSXxsVSbH7KEzn4RVCEEYw2vI5aa73ZoMS8e+nIkLFDuV3DJpcJQjRRrMWOyqwW4CyPn3grxInVvCE28XOdya1yVR4z4LEp1dvHls9XT6RTpusKyqfW8iEXRG+xEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkrQm32/a0TmVfUWaCqEbHkH/q6s+Gqe0TdV2Zq4J6g=;
 b=PrI+fiCloySlGyA9yUciGPV7VH6DViWPoicBrXM+hg0xzXuijLCf/vc0mbOUckOcsZZX6zBHC4B/aoE5OQt0pP/yD5gNKsK1nETxlK5tJVnSG/+wr+yGQI1z+5t8EON9JjTAXamPvcXjmdd+xAzgw22Uo5gXv6/9xnA1xbwtftSApvKTH8PWysApckEuPL0U1XGT6b4meC/mDplN0sb+d55LCfMt0fK1DMtqYhIZsWS4oKjs/8N0cQf8/ZkGriewjoE5HTI4BZ/cYWut4UTFTD/xaQkNr6jhf/TCcQPGiUA5k8aDJ1LtUEaEUdEUxnbKVIexmhYWEhJfkhiV0uK8fQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9864.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:153::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:18:23 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:18:23 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 2/9] imap-send: add support for OAuth2.0 authentication
Date: Wed, 28 May 2025 22:47:48 +0530
Message-ID:
 <PN3PR01MB9597FBA69F0E45E02BB224BBB867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g5db5b64a3b.dirty
In-Reply-To: <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528171755.90367-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 59ad922c-d68f-4d42-6abb-08dd9e0ba672
X-MS-Exchange-SLBlob-MailProps:
	+b2+gf+2pHTK0hJWfIOsgR8XTzjzRgQkiZspJtoIFtTR4GCWjlafbOKKIe89b6IiIuJyJqZWdsx03iUX4w46kY7aBcy60vxcv34RGjj46GUSlIlMXmfxnNgevTtAaO9H2kKDlyQavpVDLz4cV2boCTsARe3lVrN5NoubRaciT3Ob8i2PatsvSW96rxZJjtjeOIlcMXVw1/eK/dgy5N3M0iaynOpmQGPa8sjI938Eg9HhZHIC3wd6yinLc4xjaD5E8P6i9bpXSvr88UlTxDjYXU73vrvlERRh/Cqiry44BPAMCGOaCpBa6zYJAx0tNvjbv1EHb/Q+TrS5WeBs578v1U5aSBHKk/lhJe3uz6x1MUB4d3lja58rUX/AdkloRd9nUukW1Op0HoGwspjxsyqjWzj2my0k5oDZ4+6vS9mJD63jZsT7Rfqi3JdyAA/rwYzVt1+mc63EM6Ur0BqfxEYs0u3fvw+x9W2pAzk/x5x37cEjvdzrewZk00O0FKz1xDxBkWsd980HuLM8mf1aYeD2m8c3dEypLkgzUyOzZ3Y/HhSkgzw7X0HkFlLoRUN1KM8LLQbsAb+PBUwtwpojI5jX2t5h4r3mHzy1WaqK+KpmhWn9rO4JFgfjVVZnvk2Af22X7VHahNQu2VHDDQzYYYouA3vHfFG/yzatdGTZYjQpfq21GASErI7sp1szv3Y0gbpxSMhS0PILGNdiIKE/JhvuOc5sIXHnZsuO1vmg07rtt9uifYg54xNTKvlnvC3LcU6loha6StpbMxU/joijGO73+b7B8bonfQCzneT7sbXmJRVsAUfsFcVPTTEmMC8LGjFNzZgY1DDMwzWRo5qGd3MnPl6rsJUtAiZrwbHRxCxBXW+WdQQwXwANow==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|15080799009|12121999007|41001999006|5072599009|461199028|3412199025|440099028|12091999003|19111999003|4302099013|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xwaTL9dEklbc8w8R0DuL3snh+LKWQDtxKR561tfqfwsGZZ8x9rlTgGyRXejA?=
 =?us-ascii?Q?xzMxjJVwOJ/pMjGDhFiogmYuImF9Q+b7NSCLueYL8bGh7gcnzAZgZIletTu0?=
 =?us-ascii?Q?lTGpw0XYgRetK1qVWFLGXy2k+7Oo48QcQcG8BfFBouF8luO4FUNtFhrk2NHC?=
 =?us-ascii?Q?rI6uE2ApB+k4gCqJR0hhpBq0wDwvrxl1ID/6iyxv+Ye/G75kXiX4OhSth+TN?=
 =?us-ascii?Q?fHu0JqUzNcpVfCACGH/R39BLIjYqOUDjEykNzUghqZIzzQ8GCOm47DYT1/jD?=
 =?us-ascii?Q?U5DUwyPKhmOJwwfrmtrI4xM0SwRUawqTo++JnOq8sUScBPZGeLF8ekVUKMNy?=
 =?us-ascii?Q?k2dy2DjuwHeg9/0fn4LuvcgaRjkvUtTDZ7KDS5FTOWmZlpxGsNCAG+oyGa9V?=
 =?us-ascii?Q?MrWKcOlXj/o097ZERaymObko/lwJJen6U0NLA7RIcsnFHCVeHznwKz6Ryec2?=
 =?us-ascii?Q?SwHNIKirlSdEMSEsEpcazGHEn+rUpN3mnDPx3Dyjufuqn6U3j8f916xkszfl?=
 =?us-ascii?Q?MVc7eqbGB4eefj3sNHE50AKwGIMUeJe8VAMez/f7zTrXC3T1DTEexI37NMXx?=
 =?us-ascii?Q?AMKtLvzpakrm6UKRQowMydx+UIDw1wf+GBXk93PVp4YAlml0drHUHIREf8/J?=
 =?us-ascii?Q?JOw8aazIaCpHkpNQ7SxPP3VLJj+pQHaBTUKM+kPChPL6Voo9wGyoq0I7tD5E?=
 =?us-ascii?Q?slq8iYKst6XCs0cZofL64XEoP+hbdu58H0yvA66kuffTvaekCXbBeEblPCzF?=
 =?us-ascii?Q?lT+Xtf+9T/c3OXHdydbhptMLoiVouZIt5hqvH/qLuNYWBR4fbU7R/SSRKmPw?=
 =?us-ascii?Q?BsaY2tcff5sSsyWpnmxmxVQMjLem1TI6jGU9QW9dlAh42TTf1pwemNo/aZnB?=
 =?us-ascii?Q?5i0M57oSE6qEvxpQW2v0VDZNyXTa+qn9gNZatFDxMwPG3JzJ7OiiIJHkTD7h?=
 =?us-ascii?Q?MU1T1Y16R7AYId0aAVaIHTy2VAGxGS87fB8EYKdsETnzz8gh8RlseRX/wqTc?=
 =?us-ascii?Q?/vB+lqNXzda08MLnFZ4cBYld3uEseg1cHHufEhmkDYs2iwyPILPuk+fWXi05?=
 =?us-ascii?Q?/01rf8jankwXov762CI9otrQxQmVm23pc8Rn8i14GotUkD9AkZ76ZYsP3t+2?=
 =?us-ascii?Q?tWivhlqWQdOz9vERSIOCfhGNAD2DZ0/Khp6jfCd/e0lEN07BxcctJt5+zA1P?=
 =?us-ascii?Q?crcBw0ZO+X/LhfxCMuLQ1RBdKfG7aRibV9KOLQzcW3G8NFad5FgmKgIjgb4K?=
 =?us-ascii?Q?TWg8us9Wkg9ecz7h0jKRqEFhQOvBkXd4aRtYUhtOmv1TiZp1oA8mimzdL6AB?=
 =?us-ascii?Q?LdXR74jPuMVoLkx1F52iiQ0078RpJWull8bmjPNukReuxCv/kUnLHpAgnvQ3?=
 =?us-ascii?Q?3mTYm0A=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?18yFe1E7Hgbo3tu5yr3MuSXh2T1aMGnFLIVohbk2hPZS3llGc1oF0Hp3FvVb?=
 =?us-ascii?Q?leQRCWZjkOYKyDCalpLi+SEJdatEWG3Geb1h24pgqnWo7uj1FKvk0CrG3XZW?=
 =?us-ascii?Q?TwRng/6rXLTyWZzkix0H0nU36VvZs7QU3U8XX+MIS09tZ+noYr9jkPCnpAJx?=
 =?us-ascii?Q?n40x1AoHqqv/lqGNhVZO5r9iQ20zBCI0eD+JOZdy0rQgVKzXp+7ssLqrjiAX?=
 =?us-ascii?Q?HmBCsBYX7bcD9ZrQi1eP4E2sIUcxrrvdUvHItyjNujUrZRcmU8+wujXQec2+?=
 =?us-ascii?Q?wFxL44ncc6ggWRDW9bQorTZgg8Su7VXw32pyZ6RUaVXYL/HsTSABB45Q+NDh?=
 =?us-ascii?Q?jKm5zMqElVvOFyYOP2KMza43NNaGgSE9ZKD5BqAel2C3a8r2s/1MWCQKYg30?=
 =?us-ascii?Q?FvazJueUcaTczgcA1jc9Pe5Usp0TOLrJTP1b8FDpV3RpKjY200zFb0Ei9SMM?=
 =?us-ascii?Q?VUrovlXqakwz85KvajFH4+ZQLjDwTvmhE0EwDDCmmoSIN3SVUWfYFYKK1j4Z?=
 =?us-ascii?Q?hD5Q4HBZu33UzRZQdBSgbBW2RgW488d4vdxzY4gz3c0MOXDgt8SlGEvPut7P?=
 =?us-ascii?Q?d3+20hfg9YhQs4HPmdrgEKZoP5YtKpJzmMOx8M9nt8EbBKOLJO5mSp43jt8g?=
 =?us-ascii?Q?VXkJU3Y44YfLe/gZLrJlayPeLqcRJ7ngmUJAKjUKNbfhUEs3NL+6xY1UG5MS?=
 =?us-ascii?Q?kUqiwEX2J/AZx91M6GogkKA22ajN0PO0sUdZQZaSbqOQKwwPnFSGueSSCn3W?=
 =?us-ascii?Q?EgFMCWQUsgb5zYCwydtmiBILcggL2WQGNZA7SHlnLbDNtxZultx5VK6ClByq?=
 =?us-ascii?Q?FUmYBTOtX3H9i/BZ37/N7wT+Lc6FfeFpbAaOtQw8ZqTpzXsw991uCrnJ4eT+?=
 =?us-ascii?Q?kPnI4R2XH4AnsyO+CkKreD2M8PltgEqDNDMCxl3r4/mz9sn0QflB33SAujZA?=
 =?us-ascii?Q?5/kBZWPY43nTaGOfIrPTSBP8c7UCvgVx1Zq5kRbaQU/mLQZ3jyVdprpJ4okU?=
 =?us-ascii?Q?1nxnvXTcWJlZzYFFRLNMlFQyyGkNHMpxTLnwrXkL2H9beAVlTBgIQ3NDU0UI?=
 =?us-ascii?Q?h1SRJHrVhP2y2SJpfU51myk2/ti2L145qWj7A18zPb2JxvuagdDuXA764nwg?=
 =?us-ascii?Q?fkz471VAinPVYvr5nZWuD46ngXTfHWIBEQQC8QeV7y3E2UgPPdoe618sVB7B?=
 =?us-ascii?Q?R4kEMU60JaWkwIeQfLJ2PUKB2LQ7CkfSVc7R9Pg7XsUeGw70oE/6fH2/LVrP?=
 =?us-ascii?Q?796nhzE92O8PZP5TKbK/lB0KfoApgO9Gfau7rBQ58UjggAqy/LWrbz+vbVyi?=
 =?us-ascii?Q?gOlFqk+AGCI4/alzSBbfAqdQ?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 59ad922c-d68f-4d42-6abb-08dd9e0ba672
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 17:18:23.5522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9864

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
 Documentation/git-imap-send.adoc |  46 +++++++-
 imap-send.c                      | 176 +++++++++++++++++++++++++++++--
 3 files changed, 214 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
index 3d28f72643..fef6487293 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -40,5 +40,6 @@ imap.authMethod::
 	Specify the authentication method for authenticating with the IMAP server.
 	If Git was built with the NO_CURL option, or if your curl version is older
 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
-	option, the only supported method is 'CRAM-MD5'. If this is not set
-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
+	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
+	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
+	plaintext LOGIN command.
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 26ccf4e433..c3a46070ac 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -102,12 +102,19 @@ Using Gmail's IMAP interface:
 
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
 
+Gmail does not allow using your account password for `git imap-send`.
+If you have multi-factor authentication set up on your Gmail account, you can generate
+an app-specific password for use with `git imap-send`.
+Visit https://security.google.com/settings/security/apppasswords to create it.
+If you do not want to enable multi-factor authentication, you can use OAuth2.0
+authentication as described below.
+
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
 that the "Folder doesn't exist".
@@ -116,6 +123,33 @@ that the "Folder doesn't exist".
 If your Gmail account is set to another language than English, the name of the "Drafts"
 folder will be localized.
 
+If you want to use OAuth2.0 based authentication, you can specify `OAUTHBEARER`
+or `XOAUTH2` mechanism in your config. In such a case you will have to use an
+OAuth2.0 access token in place of your password.
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
@@ -124,6 +158,10 @@ Just make sure to disable line wrapping in the email client (Gmail's web
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
index 37f94a37e8..0c7844aff2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -139,7 +139,9 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
-	AUTH_CRAM_MD5
+	AUTH_CRAM_MD5,
+	AUTH_OAUTHBEARER,
+	AUTH_XOAUTH2
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
@@ -885,6 +889,66 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	return (char *)response_64;
 }
 
+static char *oauthbearer_base64(const char *user, const char *access_token)
+{
+	int raw_len, b64_len;
+	char *raw, *b64;
+
+	/* Compose the OAUTHBEARER string
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
+	/* Compose the XOAUTH2 string
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
 #else
 
 static char *cram(const char *challenge_64 UNUSED,
@@ -895,6 +959,20 @@ static char *cram(const char *challenge_64 UNUSED,
 	    "you have to build git-imap-send with OpenSSL library.");
 }
 
+static char *oauthbearer_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use OAUTHBEARER authenticate method "
+	    "with OpenSSL library, but its support has not been compiled in.");
+}
+
+static char *xoauth2_base64(const char *user UNUSED,
+		  const char *access_token UNUSED)
+{
+	die("You are trying to use XOAUTH2 authenticate method "
+	    "with OpenSSL library, but its support has not been compiled in.");
+}
+
 #endif
 
 static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
@@ -913,6 +991,46 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
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
 static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
 {
 	if (srvc->user && srvc->pass)
@@ -1104,6 +1222,36 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
 					goto bail;
 				}
+			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
+				if (!CAP(AUTH_OAUTHBEARER)) {
+					fprintf(stderr, "You specified "
+						"OAUTHBEARER as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* OAUTHBEARER */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_oauthbearer;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE OAUTHBEARER") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE OAUTHBEARER failed\n");
+					goto bail;
+				}
+			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
+				if (!CAP(AUTH_XOAUTH2)) {
+					fprintf(stderr, "You specified "
+						"XOAUTH2 as authentication method, "
+						"but %s doesn't support it.\n", srvc->host);
+					goto bail;
+				}
+				/* XOAUTH2 */
+
+				memset(&cb, 0, sizeof(cb));
+				cb.cont = auth_xoauth2;
+				if (imap_exec(ctx, &cb, "AUTHENTICATE XOAUTH2") != RESP_OK) {
+					fprintf(stderr, "IMAP error: AUTHENTICATE XOAUTH2 failed\n");
+					goto bail;
+				}
 			} else {
 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
 				goto bail;
@@ -1405,7 +1553,11 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	server_fill_credential(srvc, cred);
 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
+
+	if (!srvc->auth_method ||
+	    strcmp(srvc->auth_method, "XOAUTH2") ||
+	    strcmp(srvc->auth_method, "OAUTHBEARER"))
+		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
 
 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
 	strbuf_addstr(&path, srvc->host);
@@ -1423,11 +1575,21 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
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
+			/* While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
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
2.49.0.638.g5db5b64a3b.dirty

