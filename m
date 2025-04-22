Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9B22F3AB
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304950; cv=fail; b=BmH5e0Kt4XF19rh25tYmFF2xMuZJXouF38UTO4HMCKm2oZ8O9p/F2uOhTK5XTdnnXImeFJ0HEwHL6QtrKhFqst2tcGZGzUd03algMRmf+xPoAZGdiELEwByWElZfv16dMI6G6iK6g1c+Ji2aGAxwCaISHbKz7BkcT7gkECrQOU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304950; c=relaxed/simple;
	bh=AIwgi+8vj7J3e54bsUQfb8pXYo5zimKliS6u49OastM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QU6ooE8e/z+xWq4TUm4zjzCguoa8rR9TdrfzFZDQ0PP+qAIdH8aIuVx7RRDp7VHxPjuN8idfe/JtA5c5e28kc2WBsodRWmrlnm2U4NcQ+LF4zLUHTQiUF8vDs9ZMtDICJNA4+7FMEbHBUtc2is/Fh9/bG6JEEZ3/QA/k/85kx4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pA6H+q12; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pA6H+q12"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOEkJI1TB3QISfF8qnq6IF3ipNbGqyytsQsF6tX/+DMqUIecQIq6VJUg2/DovV5ikQHiJX96Q3wzUkOsUzEdkTEmczfpVZT+q5mCyTWxeXPQnMj4JqHwg2Ls4ZpAVxgDTYtbDrz9sdTyTaGriP6Co+1rw2t4mzRR511nywj9uupCjhjw5nATQr3VyLz20JC9aA5AlLPHTE+xAbYtmXYq4WOVmKD74sr3muKyFbrBtBBKeSnEPwKPXfLu9hN9LKZrEgeomXEFI8zT3E7Gi1+VaGj+LzOWcs4s6ihTgt4lwUHbXAd1LezNcvGmb31Wz9S6FjCV6fEsTZMwmxyQtJF61w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRmDozzkv/IeQPqI1G1yYRVuFww7/D+Z4Kz/dzu4oPA=;
 b=QA46UJ5ZjuGsDSlEFeJHN3S+R3nekg6xkq79pOo1tbakcrhAK+o+TEMdrc3lmLXivEbbpeFH4whZMENA+mu7BtfOoJsB1cjaNez2ZePk1hiusKRRyMECd8F1lyutq/WfI1udG4sf5r92PTEtD1TPwFO+WdhGiEthYwiSKpOpq3dZYVhKlsrELxerIXfJhpEIz7QAl9gvjZ3DeLindpWSftOH+k5x6n0Lr4mFj3nnZzRZpfFP/0T3dwZFAukNgD2M45uGJX/ram/040SOi0leEeuMaQekUP1hs9+GHAmU/rdZpJ7KbnYaApY+iFoZIJTkraMIxknR26WAGhZbxr/eAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRmDozzkv/IeQPqI1G1yYRVuFww7/D+Z4Kz/dzu4oPA=;
 b=pA6H+q12TrHRDPX5XV1zn/O9E3cAdFueTyASRpjlBcVhLECb8QpunkRdt1R75WQzNfBND7sX6oH11cyZvqhWo3zBjPq6EkAeOlsvpcJXoVM/aPWQzr3gbfge5kB3RaKLOaTkSAUAsHpbSWGA1YF62Mn12zHDM9psIVcUeD5kZPTbQJD1+Nx/EocEHE0nVnqE/CwVruyM3Xc2FXn/UBefJjVoY+uNSRLxAbDvITAy4qeqYfelPGomBGxSkzt+O7L8L1VSNee8sLMPtcgCL7amn3b6+m9hHsBUTOWGEyuAgBolv9cM7hkdraZIqxVOyseYOnYVWkQx470zD4QSnPgq0Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8199.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 06:55:41 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 06:55:40 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: Shengyu Qu <wiagn233@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Aditya Garg <gargaditya08@live.com>
Subject: [PATCH 2/2] send-email: retrieve Message-ID from outlook SMTP server
Date: Tue, 22 Apr 2025 06:55:01 +0000
Message-ID:
 <PN3PR01MB9597D2F55B26ECB634A2C717B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB95979D98917E3986E37267A5B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB95979D98917E3986E37267A5B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001A8.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::e) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250422065518.96853-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8199:EE_
X-MS-Office365-Filtering-Correlation-Id: 9979db5f-ba5f-422c-744e-08dd816ab114
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|5072599009|15080799006|7092599003|461199028|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?swHAM3DLkfwEOKIDiFcXrVwQAh27gWf6GLqqOhtbsLilyesya80cPiJ+bLSC?=
 =?us-ascii?Q?jU+/KtDNmnwicWvcqENYH4MfTeV95R6ee4K2As2rniBhdo3bmLzkqIHNt+KA?=
 =?us-ascii?Q?WBt05ZgoU1If/tlYupKQzxCp0YXfe7iJJWQUpaxYbUhhw3djS9LC2vP9Ped9?=
 =?us-ascii?Q?uUDOsf51tju7TsdVve+nvwB7ooF6a0atjmUiup5BuY1ZkEX84DqdSR1SQuX+?=
 =?us-ascii?Q?Z8UQuBHd6FZYks3EpJspyDNptsEqox2cpvmeiekDQlNGQbFhvsOa2dYJ86qV?=
 =?us-ascii?Q?HPDUE7CHy0+I0tnPxOKsX6OnyqMYuVhjqVwBUJ2VmlrPZ5vRHz9FjN40xD15?=
 =?us-ascii?Q?L9FJKeOUEBpZ8K550iBUBeT5/v8YbWywhJDSdwwAVBrXik7yJXL4Bpu7ElqE?=
 =?us-ascii?Q?GLzoxPv6v649AcVT99+A7Uv41Cu2TEaw2mopXKLpCcy8C0XLBCm9PL/j3Vxi?=
 =?us-ascii?Q?bH+dJEYfBMHe0EkuBGJqJqzaLWuFK3p4Lz4tGhPNPTDQLm4yRikuJQogaJmj?=
 =?us-ascii?Q?o+7V5l4/qEQQ5l/pKKYYXorXrypqJ8hX8NCkpCuU/35d4dw+nxSSZl34u52n?=
 =?us-ascii?Q?7ap0NkYr6ehn2wgnm6A0HKgx7GZHkyXhcHpSdJwPjNtlwpVLBWFq2RipeI5x?=
 =?us-ascii?Q?Sv5G+cz/U5Wg+t+hpywkI3xwpH/dna7LkUUaPWN6UOUcbiZX/goqZlkYB404?=
 =?us-ascii?Q?9r1ucP4UbcGYbHmrTf/JLog/Y3Zo9N3OiSpnLpsaoeOP5ADZGG5xSgTazYoC?=
 =?us-ascii?Q?bKH2DKBUjrT4DONZT8MLPn5Ns8nx+xR4fK3Hd7IBscmBPz7VR5t8HvgxAg9Q?=
 =?us-ascii?Q?E9lO/B7qSnK8Ml5bDGfu6GpOTu7IGl5+Y3Kkzhku03h6PFo6IGEnzntYbT1K?=
 =?us-ascii?Q?WG06XTHuMz01w5WiknrW3M3B1xxqUytAEFXDAkVoh16+4fgBA+CcvgORK9FP?=
 =?us-ascii?Q?zO2the1jRuawPaMgXmVHbdT70HlGTH2zSJMjlV3vdKyfaDNwzRNSWn2wqbw2?=
 =?us-ascii?Q?OzzEIBNHYsVgTZrSGHQoQs/ZTDPyg0vAZ0rPolvkJ69z0pyKhvpOyXPfBg1X?=
 =?us-ascii?Q?MEmxdTA2hiWV9yXXnNoEnxyLOjD8yFs5eSCc4qO2yHe2FaVDh0vtz839Lab5?=
 =?us-ascii?Q?rZnRaNC5VY/AFsrrcGenABHiWQ3ENdBSJg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LGXHeb7xZjwRX/wB18e2IwElAWW2RZg1gE0SbcgR2ZgZOC9x7Hvdqa+VClGv?=
 =?us-ascii?Q?wWgh3ks9eUa3E7c7xT+pZUWffx4WrohUDUjayIr+n5asaQuFruWosh7t2kZL?=
 =?us-ascii?Q?FiIiz/s0TRStqx2fTo9wAxPqK/e9c0Temd6/Cz9g3tUp7nz/QoFegLhZoPUV?=
 =?us-ascii?Q?MHl/IsmheVDMOcElvBQcdlCRi3D5PoQXyOOJkPs8QoxlyHSI3EE72fAJvkVr?=
 =?us-ascii?Q?mEmAAmjHAnQT2yKIjgpyxpkPkQB4yHQebacNDDg9nBTw45E3+FxLkbaa65tL?=
 =?us-ascii?Q?tZNEO1VOgfkHx4m/F502CbE3XKYr31cfPXLbsmilPPOtiM0Lrp3ZYm8mLsxq?=
 =?us-ascii?Q?V+4CytYSa+0u6lXQIN5/zLnT/O9GS6rHY6Cr4xITBJQYCWUQX9z31aakeh6Z?=
 =?us-ascii?Q?wLVhTE6u5c4v7+4IFsL3ITpPQrwkEolX+09Dv23kYQnbkLruuzS6/DqWkLKQ?=
 =?us-ascii?Q?auJ6doBKipXDoOkl3uRyoz32/0LzIcbayNHgQZfgE9RMht11bkdfhkO/vEv3?=
 =?us-ascii?Q?9xKnat2zZKC3D5CY3wfbaZb+gju7V1TiBkTZhYKdr+RAlBEG+7bG87VE10id?=
 =?us-ascii?Q?qNXPj5ZMJlYeiq9+baLyVGeo6IpMPQzvins+M354lTBOOqOD96XMhJT2OXFY?=
 =?us-ascii?Q?ETbf3xu6eICGnEGtRRnhdWDZU4kR3W5BE1RDBsQrRJhZbIBVyst3nhs3uVOx?=
 =?us-ascii?Q?5hHJS9siDy9VjRoFfdOLdekhuBPmdTotF+IzHe8U2VU1eH9y28XqbESj+z7f?=
 =?us-ascii?Q?BVaCoizg3udXtF/lbaVu5M59I9TH9BtX52X/E7LOWVy8WBtOI46FuUlvrhTc?=
 =?us-ascii?Q?aUpfCgqf82eo3eIgaprW+mUN4ehfEhZUNN3DAjV+WJoYN9IHgL4fiip9ffEa?=
 =?us-ascii?Q?NSV6rNUM4YY4chUnDc6rrLsNmLPlagOGN6LulK3KM04kOSFzxgL9OPJI8p81?=
 =?us-ascii?Q?5S+ixY8L+2hFdYTTIZSvULBIX/RShwgwxYgBsp1PJFjGA+HGGgkxzJJ6Xt5I?=
 =?us-ascii?Q?H7LK7fS61D535anoZrNclbo/N1zV3jLAnQUNsew4tD9K/dmCwVU8MXSemxwX?=
 =?us-ascii?Q?Vsts4LYdyl3Ul9yiwsAw7cClcvnZpVc9ce6q88tLSFgs1PlIc6ciFwJ1iR+P?=
 =?us-ascii?Q?dGsfcGoHRih2ft/cJlwNdp5ioMiLCQDwOCJuZmyF+lICoI1jdgIqKZ6D4l1G?=
 =?us-ascii?Q?3oGPBnmV9Q5r96HxGvbibAvj1lcu2cuFPgtkOSOMhuOMO9Y8i3gq+IENzQE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9979db5f-ba5f-422c-744e-08dd816ab114
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 06:55:39.6868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8199

Outlook does not accept the Message-ID header in the email body. Instead
it saves it in its own proprietary X-Microsoft-Original-Message-ID
header and a random Message-ID is set my the server. As a result,
replying to threads does not work.

The $smtp->message variable in this script for outlook is something like
this:

2.0.0 OK <Message-ID> [Hostname=Some-hostname]

This contains the Message-ID set by Microsoft in the first <>.

This patch retrieves the Message-ID from this server response
and sets it in the email headers instead of using the self generated one.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index aa6aad596f..f2a926872d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1799,6 +1799,17 @@ sub send_message {
 			$smtp->datasend("$line") or die $smtp->message;
 		}
 		$smtp->dataend() or die $smtp->message;
+
+		# Retrieve the Message-ID from the server response in case of Outlook
+		if ($smtp_server eq 'smtp.office365.com' || $smtp_server eq 'smtp-mail.outlook.com') {
+			if ($smtp->message =~ /<([^>]+)>/) {
+				$message_id = "<$1>";
+				print __("Outlook: Retrieved Message-ID: $message_id\n");
+			} else {
+				warn __("Warning: Could not retrieve Message-ID from server response.\n");
+			}
+		}
+
 		$smtp->code =~ /250|200/ or die sprintf(__("Failed to send %s\n"), $subject).$smtp->message;
 	}
 	if ($quiet) {
-- 
2.49.0

