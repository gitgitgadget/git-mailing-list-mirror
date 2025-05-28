Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D0224469C
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417930; cv=fail; b=k8l9q2BxWB1ZAxUUN+3zdhgiQIRuON5wDDUToVjYgUH3SY2aWGEg/7RDnFOObFDZFACCdVIz8AaedM0Y/0q7zNXe7MRrJGr5WYnfDJ0j1NcFaWPTkdTdjSVhUm5qJA/8MdH1T+k/fhB3nUxHje5o3j9ry7aKZjKRZTbsVWMtqdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417930; c=relaxed/simple;
	bh=FVxyp22TAtQsngSbsTm6Vtha1EH2oRiGxo5S5nr3WgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=klEpCK8gMVh7YHGP93/2TdLbV3BJFwjKSqB8KB3fO5vPmlbJH6KhwbP3vcbOvlUAoj0iXZ1ndvhdfYpi3i/TFzM9G5QcR9ZKzq5SPKiJLGMOaKlETK79vcEMxVAe9KJwxe1bWLpjwmdllkAZVrQ55zm2Ngv7y0E27lhKpzGyKBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZGNPhx/3; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZGNPhx/3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCIPtOQtRtVAUo3SWujnQfZesmZe/mdeGMii4QID1d1Og1sLEOMf9MGuAvDo2T3kQav1huxJfs0svmaQC8bSAyLoA04HL8rkYJvz6xlVGnPi07fhZ0EPaR7aokc2HQwUYwz8LuFRR7bl60LY788+Z93FTLTECyqDpXerhswJ6BWRZNqaDv7vLNPYk66m43jptDcVmaCghwpa5bsYtSZQKW9/brD5jF+h12bNEcm1gMDrVRzrW51xJR+Cxrxub9/YrXnzi4TmM6w5ZU9DpIqsHfHIOxme6vYYnoWRPdJV5RF1xM2qaoQdeKUs+gOh8tgapI8iocVs8U9ZGpiTYmx2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CUCRN4xrBYXY2pU4pb6Fm6IOAim2OmHRGnDT7LA3Pw=;
 b=zHlGzEygwyY+9uC1VgVBrwvHNCRr2eouSp9Us9fQBp1owXy+sd2tAUkkuc6HdY2HoxSL2E4iGj5jJWruv6rkQ+KUxHHxPZ+xsXdDj7gfjcBwqAPrdyuqc/y5VfjmSJN4g0J1h0iz5tJFk6KWWlFO5aJdiSzGGPMtGFIwWinsr7G4qYouWcANrL9IKo0tGfH+CV3xaXCDDs9vvGQfVxd4bVa4P50A/OKNgua1NuIR88iCz8oySadOFLrruO6UKaRA2wCzIlpLy5kbNjbAZu78EICXEFJtxxdYGgTSkty8lITYJvRGOVMP0bN1+f/K9dm+ZN920YtRXqbSsshoYFkyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CUCRN4xrBYXY2pU4pb6Fm6IOAim2OmHRGnDT7LA3Pw=;
 b=ZGNPhx/3OHj+Yy4NyoiY/FHHDGRspDJV2YNs9ToVdXVc8k/hkF6ZP6z2B72aHzoQ+GlSqjTMPjBOFM4Gm4Fgb4MncHsrN/tN76/QtJrxgt9UXIoEv7bxkek88udh/L+TqmiWu11GBV8YhkYjFCgfrhCAV6dNSWWWrDgs2BVbLyyU1pHIRl6vBOCrhtSbdgPJD+XmZ2mNsaBJyHisLhbX9BZIrGWVfOMV7zwVfMVdzqQ0Cxpx7+SbOBViReSHuwBEtNO7j0xt0Syvw12RdOCAeuoNy5F3iC5uaMxQaBUG4XV1rn8OsYfFsKlKDwnxD6ymoyRuw8EzNZ10gb8GOaBn+w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7904.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:38:42 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:38:42 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v6 0/6] imap-send: make it usable again and add OAuth2.0 support
Date: Wed, 28 May 2025 13:08:08 +0530
Message-ID:
 <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g4769924781
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528073814.29138-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a37f18-2e72-467b-ae51-08dd9dbaab26
X-MS-Exchange-SLBlob-MailProps:
	30ekHghIwFpWJZJ/S7H67WW7FVejyf+CWYbqV/31z/Go3EBvbramUVIYcz1aPyLfIE+ryvHFyOWXRe4oPjBLhAN3zfyO6UWZl19uBEwujx61qhsJO3mFb+ICuqwdHBa/jSBmcBeqyUgMhEFBDXtok0Vay29gpDIcimexV+YHQbzJ0+f3ebVziMJKYdJxbkUR3C13OSK7CXXcNG44XntVeVfkjVwGOKBvKEy6dEE46+VVXPpRSB4dLtj9Aj1PkPpgCJDN5UU28nr5eo6RzdMS2BxwbI9PjE0ninrg4AXiT4td8khLeh1uRTXutep/33zsEGWOHB0c1ltcmcBynoD3PNWYEQv4OSla9z7ffeM7k6b/CpLf9tlReKnwXFSFoHuSxzP+E3QBna55LoscNmdeJGG+7cNRst6Atb2I42Dv/pYdFoLMDZr8FZZQyxMATP+1Ft62AKanTNtpj5iYGNvEOh7E7aJl2++QJMBI34oiBQbZ4OaJPztAFe+DOv5K3n78+B3iD41JfazDUgMgKF8/Eb5TLiLmJSeNYWEivPKw5dWsfuCusG1Z0JVPDxgBTedx9lErI13yyNJaDxlaScMHZQXpfqFXWqR6q5yOOOKuM7CSz27ugy8wp1QwDDFF1iL4JcesmY6zfvQzXQff8dLJ0bbxSYPX0KT1KQ2PiXqQvmVnN9K5FxdNOTcmSwSfC8vqrQSulq2OU9c7paJVDsT9sBxH5SAzl2i/oAAD9DDZQHCSPudsNfwAGaahbv/IqvQn
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|19110799006|5072599009|15080799009|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WgMCJ0Qdub5mdJKtPvkIhOKZPc8m8325/LvbcOvAGPSRp60HRu6MPMoGW2ie?=
 =?us-ascii?Q?DtGUVd9GbWO2BCwhP/A14+/jSztOkvxX5bnpMNMqpeHUQuu2qWolqe0vuz4H?=
 =?us-ascii?Q?z3LE3U15Zn+vNSWIN7c93khMIxM6l6cW6IzBW0FbGF6umaIskh8IdVCDJEBx?=
 =?us-ascii?Q?9VKpCcSyz/q0lnjD/sHT/21AEp0B/SnjDpaijcFXyNRJaERp+RrGl39/IY/z?=
 =?us-ascii?Q?u9AJ4DTqaQUN6MfQHI1jbCBa2Tr6XEnbAqSGXRc82sNWcYnU7Czc+tHlhUOQ?=
 =?us-ascii?Q?dn2Ttr+hqXTYORQatcpiaFOg4cMdG+jo9yawia3CU8Alxu1YbjotGrIqrcN1?=
 =?us-ascii?Q?5LIPrxf5vZW8QQ8t3eQmlsbTOl142MubO9Uy5iuqtrGQ8i3TZl+aYmD4XaSk?=
 =?us-ascii?Q?wOCMnHS3Bxt2IKmtof0GwBPi+9lltmt9XqX2ZvQQgD6baN1Gksvo0JS0sF7e?=
 =?us-ascii?Q?fS7Bm5AjtP8m3T0glgP6OrGsxDDA/NgVkYJnrgv3KUcL2aFTcJ4UFeeVzDxR?=
 =?us-ascii?Q?3BJFaYaA5c3wNAkCmAJX5Hcl278NO8xXFX+iBjDfX3IZc1HMhymtRIHGsbyt?=
 =?us-ascii?Q?O0pxQZc7S7/xDd5uHv3LRnGrlpEENOFAGijvVfkOkni4znJVETVTmdFkLE/U?=
 =?us-ascii?Q?hMuQLvV6y78j2L8+fAtVafS7QZVzQQ+2fADeXQDCDy2/uZiM7WeJRaFsOzYu?=
 =?us-ascii?Q?k/AhpuEY8dTBnJsjPRita6dg/qZbQucydr+G3NlnSdWLPxUxMQjfChEhgemi?=
 =?us-ascii?Q?TPuhGH8fCML4Wnna/03hTTC4xXUFkQ+vSr1X958VvBl2Hrt2rUQCmkJTwFvg?=
 =?us-ascii?Q?RHk1aZxovORCLPQPuykMLmm6MJ07sagURr9BYOZ+eHhw0A/RK26SsFk35Sao?=
 =?us-ascii?Q?M48RWfs1EtX3iUZ5qaHxpyRP5qi5BIpr1TyF3TSF1PbBLjSTNouE5ntLC9AE?=
 =?us-ascii?Q?8Op9dCBiR1m5FF+K/7KHxsLLYOTZmWD+UKrO1jMInuY70Y0pL/NAUSnYLUuA?=
 =?us-ascii?Q?Prhpcb02lJu3CuAyVuvNEiq1vISaK53N1Z69dHvCO6O8QTiXkMWy2KTbHwkr?=
 =?us-ascii?Q?uwraeeXiqOVtPCZJhKj1OftDIJZsRMu1GS51y6J3wVEfMXDFrlY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W+GARpiaAhY07t5L6Vibm7C4SjXGvjckuunRciaE53lBADtAXrTF01pV9JFS?=
 =?us-ascii?Q?HQgy1i/uSJTjD73CmMe65Jdb20316FaKhYEndHkDQwfHXO+CRUQVHLrF2Y24?=
 =?us-ascii?Q?hStZBGWQ5QSImDbDo+vgo+4u1VgDTMvJNnhsgd52Uxa5DCDPzNuRrfRMQ4M8?=
 =?us-ascii?Q?4PAaJAwjmvGzp1z/6WI5rOGMZ6BoqbMnEShulG1USYK0daHF56xlaOgRb2Pe?=
 =?us-ascii?Q?HaMK5OsTokvtFhziO1OIJysasz8YULbJSvVieyFWAhRlqNiDWqT5Q1hKlgNM?=
 =?us-ascii?Q?lUA76U/s1Q32FSa99ektpFDb8yt1cZF4jSUOl1/1kcD2erNG/NyUAZ4PjPAM?=
 =?us-ascii?Q?7hrKqILnQu/qj1s9YcZWHxfZEfMqecQ4f+m/cg6ZYTxxomQoMhGSUB+jAuMK?=
 =?us-ascii?Q?SYVyqskvKAlWV95vnMm6SUvMvdFi6wjCGEWzmJZy7DqzIJDi7bqY8d3nivkn?=
 =?us-ascii?Q?DeSfjAjViEaurq7dy0vB8eZtPxmUDtjcrRtc2ckhTesqDdHF8LxZaBqhA/IY?=
 =?us-ascii?Q?SQbbzzgdHTDTHmoouB5kOqEpu+tGmNwTXfWtV2QlTELG5iGgxiZUI3GE5Ivc?=
 =?us-ascii?Q?+ZVQzOwgf6Oi+NgVDhu523+TPLiXG93r5MAq9gxRXRjBuMXzCSNAR+GBtRCV?=
 =?us-ascii?Q?BVAV58/G8TmbAiAR4naCAdMLJvHAk4gxfJGMB+69vsPcB/w3xZKCzjSh+qqX?=
 =?us-ascii?Q?I3nvtr/GTI94nFyMuNbq4VEWHGejtWPCwS3M0GcSZ0DSmnalAmDuiONdwFfJ?=
 =?us-ascii?Q?HRgjxdPGh48r0wAdWQE6/l7Mhd02ma07Eg4rNwRUCZJHUHyQGOu3xJqTFJR3?=
 =?us-ascii?Q?IpSBH+UamHHAW+JD2Bgc/OrKe83LnlcWFDCfW0+Bs9NnZXazct1BhVLXkZes?=
 =?us-ascii?Q?oZGkBGqMj1ffVgT6GM11GU+DoGEGzoTOq+7+UZpFLnWg5qy8K1UFzelMUxbV?=
 =?us-ascii?Q?IBaimBk1hVUVGhsHYbHw+WkmLPpqATmX69glTTW2y42jC6YqeaTW3yfKVCqK?=
 =?us-ascii?Q?WPYnbj5FzNalalfgP7OHl5kCyuc8QihjRUV8+0cB4QG3NJCEVDzT0CHcbSIP?=
 =?us-ascii?Q?VlNmYeAuNgHYZX2ycNKV121eq7zfuOnK3eO79xAnzNVQMOag9f03gKUH320+?=
 =?us-ascii?Q?iAsvKwbyhCoA3qHt3cWdFYB/EVjaaPMFolffk9uOSSkdn4C3UDVfguFy8ixd?=
 =?us-ascii?Q?8SZ5Ki3ZqeKoA4F53CUT075L2o/nVbEmyflNJg7dK2c/HwMGT28TsK3UIgKR?=
 =?us-ascii?Q?+o6mpgcmSbA3ndcDdoAkqVPsFv95hMZMrvxo+8zje+uugFmjgr4u4IcUPfL+?=
 =?us-ascii?Q?p/o=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a37f18-2e72-467b-ae51-08dd9dbaab26
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:38:42.0530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7904

This patch series does the following things:
Firstly it basically makes the imap-send command usable again since it
was broken because of not being able to correctly parse the config file.

Further it adds support for OAuth2.0 and PLAIN authentication to git
imap-send.

Last, it does some minor improvements including adding the ability to
specify the folder using the command line and set a default between
curl and openssl using the config.

P.S.: I am surprised this thing even exists xD.

v2: - Added support for OAuth2.0 with curl.
    - Fixed the memory leak in case auth_cram_md5 fails.
v3: - Improve wording in first patch
    - Change misleading message if OAuth2.0 is used without OpenSSL
v4: - Add PLAIN authentication mechanism for OpenSSL
    - Improved wording in the first patch a bit more
v5: - Add ability to specify destination folder using the command line
    - Add ability to set a default between curl and openssl using the config
v6: - Fix minor mistakes in --folder documentation

Aditya Garg (6):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: fix memory leak in case auth_cram_md5 fails
  imap-send: enable specifying the folder using the command line
  imap-send: enable user to choose between libcurl and openssl using the
    config

 Documentation/config/imap.adoc   |  17 +-
 Documentation/git-imap-send.adoc |  65 +++++--
 imap-send.c                      | 279 +++++++++++++++++++++++++++++--
 3 files changed, 333 insertions(+), 28 deletions(-)

Range-diff:
-:  ---------- > 1:  4757d0305d imap-send: fix bug causing cfg->folder being set to NULL
-:  ---------- > 2:  f5ad01abc5 imap-send: add support for OAuth2.0 authentication
-:  ---------- > 3:  e3dc19dc49 imap-send: add PLAIN authentication method to OpenSSL
-:  ---------- > 4:  11f7ac1325 imap-send: fix memory leak in case auth_cram_md5 fails
1:  62edbcfc6e ! 5:  f6e7a5498e imap-send: enable specifying the folder using the command line
    @@ Documentation/config/imap.adoc
      	Command used to set up a tunnel to the IMAP server through which
     
      ## Documentation/git-imap-send.adoc ##
    +@@ Documentation/git-imap-send.adoc: git-imap-send - Send a collection of patches from stdin to an IMAP folder
    + SYNOPSIS
    + --------
    + [verse]
    +-'git imap-send' [-v] [-q] [--[no-]curl]
    ++'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
    + 
    + 
    + DESCRIPTION
    + -----------
    +-This command uploads a mailbox generated with 'git format-patch'
    ++This command uploads a mailbox generated with `git format-patch`
    + into an IMAP drafts folder.  This allows patches to be sent as
    + other email is when using mail clients that cannot read mailbox
    + files directly. The command also works with any general mailbox
    +-in which emails have the fields "From", "Date", and "Subject" in
    ++in which emails have the fields 'From', 'Date', and 'Subject' in
    + that order.
    + 
    + Typical usage is something like:
    + 
    +-git format-patch --signoff --stdout --attach origin | git imap-send
    ++------
    ++$ git format-patch --signoff --stdout --attach origin | git imap-send
    ++------
    + 
    + 
    + OPTIONS
     @@ Documentation/git-imap-send.adoc: OPTIONS
      --quiet::
      	Be quiet.
      
     +-f <folder>::
    -+--folder <folder>::
    ++--folder=<folder>::
     +	Specify the folder in which the emails have to saved.
    -+	For example: `--folder [Gmail]/Drafts` or `-f INBOX/Drafts`.
    ++	For example: `--folder=[Gmail]/Drafts` or `-f INBOX/Drafts`.
     +
      --curl::
      	Use libcurl to communicate with the IMAP server, unless tunneling
    @@ imap-send.c
      static int use_curl = USE_CURL_DEFAULT;
     +static char *opt_folder = NULL;
      
    - static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
    +-static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
    ++static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
      
      static struct option imap_send_options[] = {
      	OPT__VERBOSITY(&verbosity),
2:  245cc89cca = 6:  4769924781 imap-send: enable user to choose between libcurl and openssl using the config
3:  4b91d3bf89 < -:  ---------- fix
-- 
2.43.0

