Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E1722129F
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500620; cv=fail; b=bWWGkaxVZLKQFxmhFoB3HCzFKKv95sVtjbSDB6Ad+xEJqSGEYoDTR3DJueELGMqyweyu3WpBlqXbWI3t2H1RM4FxR7Gxw8CVZgfmFK+wyHBzULdRiT1fpd0P2zV1dSTGj3qw8UUnVxGTppisPpEtdEcupRZV24RqgCPxVK3YYTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500620; c=relaxed/simple;
	bh=kf6mRwJeO0A958ItjQ6HvEEcLYbGpPEHOelSt0vfbcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FIL6MWKcYVB0oa6Ff+vG8QG3fIds6Vmym0Wdo0loh7kJXoAjKLNri/IFPbv00btUEk1lVqR//zJDNtdUfVtevyk/lmOvf1sprpOChhWRpbhISjcTdddLbz9DnYh4/12U+zAV7rFAMJNjFxxDgDX3qaoi09N9UxFyph+hSaUPS+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=hyBc4z0z; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="hyBc4z0z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+Mkm85SIbGk/MYyyBKJEuM0OZG71ztRPYwwhs8dGiYzBqHQ6T0KmAGBUnBhQlyYpArEFcshDaugiCRvkoak1HW3+kbjS/2hm+y+3dWyrs68hztBAIQwRexWdnIp9JcRtCkBPB/0dQ6U8IlMx5qXzJqmxITcrwPR17mQmeXaJ/rDD/8VYDK3TCfxHidAXvukd0tVwND5/YbS4ZAUiq3KJ04j5k2ABANw4x2u8mdI6U7HG3Wi2kIoRwg0Y1kbOpifQ/3u2fqpoR8cK2bEB1kMqPzfJO9aA0UyuKQ3V5XyHVIegNteQM1tCe1ptW7Ce1L2ZFqAYGYGjNfAJWaofKy+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5XcWF7Pbt+vf6e2/0xwul6B6OJNYCYRv6QpRIhKYiw=;
 b=B90jM6u8f58tGIU9i6LDrHdnhIdiCORXSSDx3iRa2B/vSIsbIQJH42TSUqwmYy57HTJwvKM6jGcSdoIvCX7PwrVueg370r9lRZeRIXVAq27i63ovtMFVkweCMdp3k5GHKB9gE6hBZWTE0e5GCZZLCR5J8X0YAuMaPFgEyiHSX54irqrTm9CxBMVU2ShtFcfpq4gJXf5Dq1eyXrZMJMRwkGN2EZoiqzussGRL5bqm93shhyxOWFWl4TfXnQOm1BLs6lR83zcrbJ9kturWVZEiSxaOYn4/Uw5tVO0Wy2FJRyn1TwKeVFQluUMfj5gO6tvL69Yahp4H+3oOyensq+ufIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5XcWF7Pbt+vf6e2/0xwul6B6OJNYCYRv6QpRIhKYiw=;
 b=hyBc4z0zvQgVYTyrWiiuIi4BOf3sJIborLUeZmnLQarqkuATmARAhbEpgYuiuyUZqet5uk+5lKXrHL3UVLWXTBGWnpyxxUrw2ebCkRRFT1mgKmxbBWqdlopBWpm8SLRt2/PvKlDSSWwo8Rtjf4v/g1pveH/AQZBGj79mvp/aEWVetbOl+YIA2HhV54bfGob3zm6P+VX8mPYjC3m2s2D5RTbZonYBUfdFBWaanNuzb3VpgytjAYJl+9eLliPT7NkeaLwfYbeXUxXii7YgiiZjw849b6uanAv9pqrvkDsaSBw5HwICUPq63n7XMVuDhT0GeWoiNHMwecF1YNDWo7Luog==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 20:23:27 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:23:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v18 04/10] imap-send: add support for OAuth2.0 authentication
Date: Mon,  9 Jun 2025 20:22:49 +0000
Message-ID:
 <PN3PR01MB9597607108917195B9690F67B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250609202255.4341-5-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f0c803-d132-4223-a8d6-08dda7937de1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|12121999007|7092599006|461199028|5072599009|19110799006|15080799009|8022599003|41001999006|4302099013|440099028|3412199025|19111999003|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c1TEMixeP61B/JWQWkyX6tMXRN4IACCG/fRCLlhCZguavaSSeImRK2heu17f?=
 =?us-ascii?Q?I+3Q7DWcBXtcr826TISd/qUEQvZ+MjasSkdSyA/bW6GzAdmWy/aYqr9a1lT6?=
 =?us-ascii?Q?3F0OP2kQ1E29eMdbNN1la5aGnN1cN5YC/eypCrgdR1bGTfBnIM+ZIsri5KNn?=
 =?us-ascii?Q?6aTMlmBumbH3vqEpF2AwF54p8GGkJk6ufz+Spi0lnXEXO3vq5SKXJZYlUu+R?=
 =?us-ascii?Q?1WnpkRtRqD8sN4ZpKHyHm5AZq6ZBa/lXqKDEkas4U9Oekd5UpipIF8OKNJiP?=
 =?us-ascii?Q?8gD0rJOYMoAaZwlFX3O5y4Nv01M2R8zbc8pQZXL2vXmAK5A9eM7LkP9AOEf+?=
 =?us-ascii?Q?1VFZjQ3dWa1YM81WVkNolZkEmvn6lXOMZNUaNsBCQeWeKMguz9SlXGIrXBti?=
 =?us-ascii?Q?Pcp4Irq8DjdS64v6LYzxGbWhpreCb+tfdvxK9Ic/QytwvLnaBn850KlK3+AF?=
 =?us-ascii?Q?Oyz1p4yQD+XSg7y4tOrBpXJfuYjfIi9zfiLB42PkObfAqzGsBxYX4QLcaI6M?=
 =?us-ascii?Q?4Ul4DLl/laLgcINCxB5GGaHNY05beIVP2WjQcqc23b22Aqo3/om/LqHQhTxx?=
 =?us-ascii?Q?G/J22E4/euDTMTnWIgtMu/VLsI84yUy1p4CrFo0tnBMXoagOuq2n9210JTiM?=
 =?us-ascii?Q?P8h9uyWN64vWHhtoOzI9ILEknBbbRr9KwD7o4cBoS5871saTPDnyHi1Mi1G3?=
 =?us-ascii?Q?AXZXPqtmGZ3uQPv85OrMb8rCMJrurCfLgZ5Ml8zQ576Tw4D3wXdI29rRIAe1?=
 =?us-ascii?Q?Vyb8O0ptm+M+Ip8hWHnumWqz/Slvh9TLiT3osa+YKmd9AMb1sBxU/RvixC2W?=
 =?us-ascii?Q?sQ7sxgKYAS/ZzbAErajbo26KpMoiwSoHQ73UaLkM7hoDvkwHydEbTFh5KezN?=
 =?us-ascii?Q?PsC2Y0eja1+/vis76miYwEjPjRlIhPji7nXN4TvmwxHRDIPUY3pqmgdrAt69?=
 =?us-ascii?Q?I+Qx06PYgOaBhutVgNbTH82nJxCk+jeSd3IDiGJVNAH0SR2CzvcBOABsIVtu?=
 =?us-ascii?Q?NbSn0mHT8If0uGEBTb3EmXOCXPsn+GXAWD2BeGIiTIvHvQdam8fdU60dtyng?=
 =?us-ascii?Q?jSE/PXICOzC7m99vgAa/OuI8QXVnzpOqhjqA1xwpKtZyJwJGsCjB0OOQamtO?=
 =?us-ascii?Q?3dfln2R8e+YsBwmti51cVbyeqEUJoyREhqGIIRcWw3yxT0qmFLmSU0EMCNl9?=
 =?us-ascii?Q?h8bzWeFN/R0Bff87+BSxRm9l/1XrCOiaXyjvUB9XczqvFb3081Upo3yLgbkF?=
 =?us-ascii?Q?G3hzEWDcl1rUz0RQ8XcNgS21VkByqRr2EQmEXHoVVRpBBSQgCGBUKQifoWLJ?=
 =?us-ascii?Q?5fyCbu5X/jqitCw+FEPO9ph9mjD54INFxE7D30AnmnqbocY3BfGK1CKQNBth?=
 =?us-ascii?Q?veL5v3wAlyxVYkIaU4U3qQ7ZrQOTEZN7oX9Ws4y+d1e/S3WMJQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7fqb63DoqAe8nKgGB3ziP6sCT65l6hxDB3rxemTje9cXFCRQc25VT06NMlJQ?=
 =?us-ascii?Q?1RF/23vompygAO1AseZF6uSjkgvKqoeoT7KuJqVJ3TmsgtBy8EWlXwcZMVUg?=
 =?us-ascii?Q?EnwRZ2McqacmTBXZOhwbzs1Dy7lPbqMq0iW+Qxygacq8dcdbOrJBIOIPbHgn?=
 =?us-ascii?Q?FwP3NNCjvtdnG4bp9ogu+SIpK+jEcN3p/bHSk21aUpTQVVcj8Nh38+X1HUmR?=
 =?us-ascii?Q?estLxWALYmsVlcvmhKc9+a0VNRRNSHBr2Plpr2FaQJ34ZCwqXnU/kM9a798A?=
 =?us-ascii?Q?Z8X+rhi0c4X8yjqFL6aSYT/46oYSRHilYCwDKFQ6hXSIlR3jl0JsNYKmy1KD?=
 =?us-ascii?Q?NoLGic0kLn3xyVpIws6oQmQ8UyNOAHdQsdY4TP8/Y6gB/DoBzPFOBHZhubMB?=
 =?us-ascii?Q?D63K6rrSRNgn0NSETjwrjzyUqpS7Nbl+IxpXtEoaD6GA4QtqV3HvaR/49m5/?=
 =?us-ascii?Q?lQ13IWqvmRckUFnrbFP8wWu3ot8v/0kUkrWHoRR8QPa9ucLbxlMboDM4IxXH?=
 =?us-ascii?Q?tOAtafILnygNEjrbEfYBfJtYmcAN6wWpH6S03Xm+RFnU/MCUmQ79sfZBLuUi?=
 =?us-ascii?Q?3kg/3LwvlN6BqpscVWsSMWr0t0f/10pJDoVWgx05FpVV9v+tpK1WxXIJvCo4?=
 =?us-ascii?Q?amCgFUPuPeorVEt1nbURlxKBbjbUAnMBm6W/QZEmZgPr1q1U5kNk1/72LNQ9?=
 =?us-ascii?Q?1oQHfiP+ar3loUekawDm2L377H2PYd4qJIcKL7t+gafwuksK5WGGDYAVl39l?=
 =?us-ascii?Q?DTft5LhGT7te30V4FoAAbbodyC4ARwbWOHYXuGlMU1ONh88IDvIHM4Cer1p6?=
 =?us-ascii?Q?mta+zBnpboaff9eqNGdUvNyF/rmQ4Bq5Fpp03bGdCPLN/HzaQE986JxaqqBX?=
 =?us-ascii?Q?Jpw2rJZhwZmuCeUsmoPNq4JcW6P7F+9x7o495UIVBYjwssnnIhvHQ4GFynOw?=
 =?us-ascii?Q?e4qNmHbv5p97Ft8u6wnE/96iZfADop0NjsHOj8OTXuYrGJr87Hbvk+JyMumI?=
 =?us-ascii?Q?rdl0DqPqiNR4Btax2BKB7mkL1P9P8ZgtSoBg17geQ6QWMCUJn32nItGNd7Vd?=
 =?us-ascii?Q?Fxtldt+DtedMbMXEs32Fyei9lfG2THl0U447DPCZfKU0YIhT1ZUaRkJc4I8F?=
 =?us-ascii?Q?1ZKy0wWyosebvwUggt9w4yVxKhM9FCBV+BEpnpub9zoG6csPSY6Zae+mfdbk?=
 =?us-ascii?Q?uHHcMStvjUXxcbcrnH8zrLMoCAa2XBLL7VFUBvRFCDabo1mRafUq7Fp7S3U?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f0c803-d132-4223-a8d6-08dda7937de1
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:23:27.2272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4380

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
index 39013330a7..24eab86a1a 100644
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
 	curl_easy_setopt(curl, CURLOPT_PORT, (long)srvc->port);
 
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

