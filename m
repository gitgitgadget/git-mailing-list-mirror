Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4365C21B9DE
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240546; cv=fail; b=HMJ+Jd7TBbTYFHhDOqGyoyGcIopvpa3W7zc77EsunOm0XvNgAvG4qFMvOlTZmcli2tNNUOMCBBCD251qlEJEc34BO7eJJTJq5FOW2UUMjo7SNTnJqqsv5K5XYpRrITKQ7v704z/Z/S7nG3AVTeaTyQ1FeSnW4U7dbXtoNAD3l+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240546; c=relaxed/simple;
	bh=8HIDF/+pZ+rhOKoWEiqsJiKTbKrHz0+a3DXtIr+zWa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gdenxr7zWM/PlD9onvxWUKy/hMnsfFqMcnQfbkWI8yGYSqG5+h3RFyyyuUNs/F5WhXPNpsh2opLaF9Cap0gNECXhzCg4xCWt6jvrmOpuZXobFonb7dXTLyzRtizubfypxyMaIrEihrI2PZW2chQkhZfa15sEQebnFFThTs4Wfoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=hIdiARRv; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="hIdiARRv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4lXbeBOCdl3FG/Ht59cs+KE7NGraDTydPLZ8MmYxFhubhWot6T5B38mWRthgv/9dACOY1tRtvAkAYQvJDCF7xw3/KW99Vex2WUPgjGLcc8r8b49qHqe47G/AN6I9In+/cZ9CC92F9aytgwfrPEsVbBVyATzJ0CIAA0SJ19BgQhDwQCIVPKGEHQes6XIQ0kLuU5/iFHUlu3rN6dtD1Y5jmct+iGvdXQkFxPDvPwc2dr48PKqlqGI4jwVkT4jNRtZhFeF3iPD5f1u1sOGreAxqU+tG5oOcmOt6eagaKHOnw91FA9dmZTwX6mgn4LE6MMWfkXjtr1lkq2Gak37/xUjwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylrzHANaOSK4H9JBIVYzREMFCTM5ER3rqbNbc7gbtCU=;
 b=gzGoFu0Ji1eJCrUC4aA2uioIoHqR5evEsNwaJH6UGDpd6YGe3TzaY3WBYMkVFmjW8dgTvIRe5WuyK6w6e8RaULuXVv1+1lCfbUuSvGhlJrajb4KeKqVWf1Y6PhvEHE3gpVCJWHbee5P60+el8kCa6N3M+pJdxRXw2hWrBH3YMOpPeNjR+kRobLkoMN8kyDNLWYhsUe62IScaNYT1pPdlPzU2wxcbUAw4gJiPrhcYZCBDJGAUIeaho1+GDSfKOPDwM7LDhXto23oiaitxoLqnse1E6bMB/vCv/MDB7HTYuy1tjj408WIa3MUBwiEhmKR1bALm0wRRqG5A/U26U8oyzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylrzHANaOSK4H9JBIVYzREMFCTM5ER3rqbNbc7gbtCU=;
 b=hIdiARRv8SjHjzDGOKM4O7OzbzaRjp6jpu8EHfAKY0we900M4bdq8Yx37FEsLwBayQqoL0aK8vHA5uCxX/8t5jaHTlhLxfssDZZuvkS/jNJsrUxXQbylbMU2hTjRQ6T3L4AVQN7nG3x1UdarjFJ17X6P2uxaoIGW7lg14H23d3ivDscDc3IlixWk3xhNALt1o4UwLrupNWsXCL8Spp04Eg90tqaDunMWSt/xu8fmPSwU4+CxtLAAZTvSup/8Fl5Q/c+tpwnKlNXB6hBNIehtB5GV8nzcq5meQN6OWCKsFinzXefaOsL74hI50RlpYJZCWmjCL4Oi6BhrEVxkfzDlAg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8841.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:08:54 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 20:08:54 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v14 07/10] imap-send: fix minor mistakes in the logs
Date: Fri,  6 Jun 2025 20:06:29 +0000
Message-ID:
 <PN3PR01MB9597DB8D8E40A2428DE345EBB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g0975df9fc0
In-Reply-To: <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250606200632.43298-8-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 29add3dd-f70b-460a-7dca-08dda535f405
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrOwsKBlx1JOgp74JtkuEUkOPHF0aiAi190wpzA/Ahy97yHkkkfM9YxqXKffXYoHHmQ4U4dwKXrdCdTjPN9exLS2AKjHJD8S6vaJ79aacXvJma4NfouSbsxUcoIzJXrHvIAZJ67FAhSebVu92B8yYfW8za1qRgw4dcyh9QN8VVF5N2gnu42LxPvZGUHmQmbfMlz/eYUk84KPff6kXoePqMFUWoB3ZcGBTWWyxGmB/+C8pdwRMkAC1QszfYWsCfRQSbTrSR4qmUcg5iccyccS0OENSmIluVl3rqfqsY6JfLwzqsU3mVBXKIBHH2g4GAGGmSWzqnrLP7FBHmpwM/ROsuUgLXCdo4OC1XWJHfx4m0FoOfsqskKo1XOVawVzkg2RxSDrRahxa2+kgc7pk/YDMWjsRscdNHrzyz5/45MZIHFyBq2VnUXxYb7xnhME7WnawZX9kTClbtiH580rz76vMVQrIqFPOU7qTsF33wmxM77q9OzIzT9FbRaunntItIEv0ADb5dJKhOpw7UjTmA/me0vK5l3YucqcKwXs5KlVkJdqZeKQYq6lUKbo7R8tQtkpKse5vvH9vsL67Cwicr1NU6T26vDVBtaz83L3FDQKAXWX98xcrL4LSCWU9cl19kmnkW2Rt8ya1+OL25IFXM8FRWvSBPvCLYKksxM6sK321udVJYE+xcxOVN73lPfEwtbFBclE5MwfQhmYnfepzbEAaB6MD+yxXRaxHGCGy+PcLbR6cDRrxxOtUEG1+9KsJlNOH80=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999007|461199028|41001999006|5072599009|15080799009|19110799006|8060799009|7092599006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8VISMJz73H370S/zgmJI9ZXMrWl2ppZ7CmPHIsSjqzyF/c6KWC7fMTmZutje?=
 =?us-ascii?Q?bxAR6WNeTJTINTvV9lFoaz+lQEjs1P+OTjJqWwsj8W1o9FyMK5aOhu4XOem/?=
 =?us-ascii?Q?+nqABDCEKFnWVZX5FDWOil1g3x4CfqeNz/LlF8sGj2celUBHZbbsozDWiKsA?=
 =?us-ascii?Q?BNg+mUJGr33KSUS+Hc7CG505vfrLz8222CuujwokJHQrlI0SwB/GjV5Ax8kp?=
 =?us-ascii?Q?bRJfI65h+8GT0Fy90heGGEVFmvjKvbnGOQaLC/RgV+XfyfxT2H3RB1YqLYb6?=
 =?us-ascii?Q?jWx1rsnJbtYbFW7d4sey6D+MeaqSEbdxJkDyWaKKypTmz3Tns+Gt5b2W5yoM?=
 =?us-ascii?Q?lvNjS81ssziqJXmUnKyUXLYNdDzMckxCUQ+wzYvXK4QIi2ItsF3CmP7YorBS?=
 =?us-ascii?Q?hmmApxyf1I/RdmsOYQe6lUCviDYFLjRixc9Tj8W5nLVaerEgt5kl6zEaaKQt?=
 =?us-ascii?Q?mmnGG/8eYSg5sxTtzQLMJTMZ1HdmUfl3u+JnB8vEiJ+RnkeeAJ2CQ5Dane16?=
 =?us-ascii?Q?Ak4zwEAJF/q4wDwWFYWFAZgZ0v7aSdsnennLhHtfxaL6/GqAfSyiKnrhfaKP?=
 =?us-ascii?Q?wM1Aru8I8lrJZNh9ICU23ocHiEyj+AMButhaD18tLzjzG35MgNDbHDfoJk8n?=
 =?us-ascii?Q?plhN/PQZzTHeqKvBArB4W16no1M42uTgFmwD5B2CQuImweDmeCCvFMHDoMuG?=
 =?us-ascii?Q?dClke0+B4akU7t+GqHyoUe/H481JbRUFp5ASTSqYdxHeIsp1ET7sTVWMiXtA?=
 =?us-ascii?Q?nw6POzyxdA5C6Z3dCJap3MdygLIUiSw9JTALKSq3CpBU96OxcUVuSZcjUsIL?=
 =?us-ascii?Q?CJFr/lT+C92H1Ejn/IBMnkfjDqJhqOH2T9QLdWEekJOAl9YLY/B/JO8YrCUX?=
 =?us-ascii?Q?7N1++YJk2UAvqXNTjuJpinyjo3m6rtcxi1S8zpYfur6+a69eyqraLtRWOkS6?=
 =?us-ascii?Q?lrno6K7kofgvoGqx7rKtJV7qiFuWkfOY75CsaoL1b/dz24YpHFc5Kh59FRM+?=
 =?us-ascii?Q?BL0U2mOppEX2JR1wDRd37q4i+6XJ0ldiBfTPFctfI2Lhkg4ERX7V8IL/Kg+p?=
 =?us-ascii?Q?sb+hq7xJEGIoyH8Zs+0O7BTVVr+Zix7mHbjXn+2Zl7rjdhzKgmy1UozZlvff?=
 =?us-ascii?Q?MK/UzOHanbl2RWDD5n8gRaGSHdqP7Cb5M8OntnolUdUnME2Nhp+BkIAL4WxM?=
 =?us-ascii?Q?h8fcmtmPrn2Nhqml1ofFO140sb9DP0rtugl58A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6IxZKLzwdB6tTPV6onR583ohVUcJ6nRlRtt6XHY9uQeo99vXbW3fvOY7Hz1t?=
 =?us-ascii?Q?WRsKvqVS/wiXgW0jOnVi/5GwL0KQ07GW3z+ODVdnTpNT7sRX5dOQFT2LooGF?=
 =?us-ascii?Q?qMkuoeQw524Gz9MiFeISNbN7KNJyQJsSLtzGvUbSDwkSQPb1SNb3erHOb4AU?=
 =?us-ascii?Q?Bea74ytzT3OQ5JDt/UcwtcEV2eldU1+gKjHx80LslNFMU0qkmF5fVEdQVnlZ?=
 =?us-ascii?Q?cVTMDO3ArP/zB//bbOuwbEPFF571xL+gmHryOX2KzYAM7i6TnfAeZdEfyyBp?=
 =?us-ascii?Q?UZhSO8y05aBQA2wwuKPxbzBSpwYv5Ckxu5qD/5fzjLPqlOBX1yyRoSMYWfSu?=
 =?us-ascii?Q?Iq49OvCaNC5tUHNcZ/bru9JHwT20s+ZLZ43IsSnojOjl53LOrhwjvDSpWZ5/?=
 =?us-ascii?Q?ybD/6P/gFRqVSTiVyDYjIGezNPSLmFPrlVEWHzbtvOsnuvhgqrD/ufjGlYMH?=
 =?us-ascii?Q?bAA6P2xt/gWylEa4dteOZiuEX6oDFyanD7uldqU1VYZW2bfcldUWdZV57tWv?=
 =?us-ascii?Q?UIV0Lc+MpvG9ZaLFzVUsx+wXDAeogGax/OjjiX7a+PnlZlye13V0B/bSTy9c?=
 =?us-ascii?Q?ZP+5nVnDh76jBhv1PrxuIjmns5rPDfKuK9ePb8wBwrUDUZw7+4BgY2+OAP2f?=
 =?us-ascii?Q?HCYYeoK4Q796TCr4mP3GadIZGc4GsTkZilqNQDpBH2RtRL7xPXj/nORewk0H?=
 =?us-ascii?Q?SgddJ/H78m85q8sV5dwLZrdzYO9y/9Ts1ScWVCxm2XdpRldYPk0OYebPn8YT?=
 =?us-ascii?Q?P4n9ToJD7DL4KfUNJmYvq5sVOE+3ffb/05RLOqqg1RPqhkBpFGwrCkmJ12NS?=
 =?us-ascii?Q?4ecHDX5VAPKHU8QQfQqPgv+6ddNsGkgwpQcpBg/UjtVQvcCF9PQ56T03yb6I?=
 =?us-ascii?Q?BcWUprARGroWv0o+vnH8Tpmrm9K6ATuLAvc1uFW82F06hXD/xXRlp3j9QoWq?=
 =?us-ascii?Q?tYdA7/DBphFlE0PDrpHtuCWk+6IZ0+OPp36Fj3xQWGcdYe2LV2/iMEJXAFis?=
 =?us-ascii?Q?080COlqz4k4d0/ZDfw2qIfCI7KWziSG9jbZXDr9HhK7/4HTz3UrrTn5z2gVb?=
 =?us-ascii?Q?1OF6q3mYzSVloLKysZnCz0aS9csk2CZRXqfT5/7Rp6Pu7lsMoDXhln2aZw9D?=
 =?us-ascii?Q?eSFQl9W83yXiZcps4QV+8Mi5q9I8HcOt7egscIYfZkJTe60suxq8Bd3GIvWM?=
 =?us-ascii?Q?ioKJxVb+qnmgjRTe7C05oYiv4rppOHiCstRrAANsbLYmAQ0P2ZpfE1f1eMA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 29add3dd-f70b-460a-7dca-08dda535f405
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:08:50.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8841

Some minor mistakes have been found in the logs. Most of them include
error messages starting with a capital letter, and ending with a period.
Also, abbreviations like "IMAP" and "OK" should be in uppercase. Fix them.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index a4cccb9110..a9dc6cfad6 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -205,7 +205,7 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 			      const struct imap_server_conf *cfg UNUSED,
 			      int use_tls_only UNUSED)
 {
-	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
+	fprintf(stderr, "SSL requested, but SSL support is not compiled in\n");
 	return -1;
 }
 
@@ -1020,7 +1020,7 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret != strlen(response)) {
 		free(response);
-		return error("IMAP error: sending response failed");
+		return error("IMAP error: sending CRAM-MD5 response failed");
 	}
 
 	free(response);
@@ -1160,7 +1160,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		imap->buf.sock.fd[0] = tunnel.out;
 		imap->buf.sock.fd[1] = tunnel.in;
 
-		imap_info("ok\n");
+		imap_info("OK\n");
 	} else {
 #ifndef NO_IPV6
 		struct addrinfo hints, *ai0, *ai;
@@ -1179,7 +1179,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		for (ai0 = ai; ai; ai = ai->ai_next) {
 			char addr[NI_MAXHOST];
@@ -1217,7 +1217,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			perror("gethostbyname");
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		addr.sin_addr.s_addr = *((int *) he->h_addr_list[0]);
 
@@ -1231,7 +1231,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		}
 #endif
 		if (s < 0) {
-			fputs("Error: unable to connect to server.\n", stderr);
+			fputs("error: unable to connect to server\n", stderr);
 			goto bail;
 		}
 
@@ -1243,7 +1243,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			close(s);
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 	}
 
 	/* read the greeting string */
@@ -1296,12 +1296,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 				if (try_auth_method(srvc, ctx, imap, "XOAUTH2", AUTH_XOAUTH2, auth_xoauth2))
 					goto bail;
 			} else {
-				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
+				fprintf(stderr, "unknown authentication method:%s\n", srvc->host);
 				goto bail;
 			}
 		} else {
 			if (CAP(NOLOGIN)) {
-				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
+				fprintf(stderr, "skipping account %s@%s, server forbids LOGIN\n",
 					srvc->user, srvc->host);
 				goto bail;
 			}
@@ -1557,7 +1557,7 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1671,7 +1671,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
@@ -1755,13 +1755,13 @@ int cmd_main(int argc, const char **argv)
 		server.port = server.use_ssl ? 993 : 143;
 
 	if (!server.folder) {
-		fprintf(stderr, "no imap store specified\n");
+		fprintf(stderr, "no IMAP store specified\n");
 		ret = 1;
 		goto out;
 	}
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf(stderr, "no imap host specified\n");
+			fprintf(stderr, "no IMAP host specified\n");
 			ret = 1;
 			goto out;
 		}
@@ -1783,7 +1783,7 @@ int cmd_main(int argc, const char **argv)
 
 	total = count_messages(&all_msgs);
 	if (!total) {
-		fprintf(stderr, "no messages to send\n");
+		fprintf(stderr, "no messages found to send\n");
 		ret = 1;
 		goto out;
 	}
-- 
2.49.0

