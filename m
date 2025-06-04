Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010009.outbound.protection.outlook.com [52.103.68.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCC428DEF4
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749041757; cv=fail; b=e6naP3MQGSrFzKjpJ18fIfwKFe2SAXDyR9V3Z12xqgpRPYGEtCWUzl1Pn3DMKD/c+4J0VMxYpT+i+K7fWQTUF0FwMI6Q/pd3VOXs3ZtJA0OjHO49v4yDfcjmaQPq57n9y+vAUi2FmBEWzeaQ12IxHJuncVcAS7EX1Fz/UGpaXew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749041757; c=relaxed/simple;
	bh=0ZxgWoMwlUXukwMvVbjWDX8wPL2XasKm5dlLoOF8LPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YqbS9NoXzUih1a97QwmN3hXPd/4KP1RNDTOyc9B6KW7hVjXo+KBnc/DJ3V70aQAZbA9+Om6l9hFSrg84InU3By0ka64x5DFehO8AHPZCnel5BwWKNZvDKM+xOKP0AXlHzp6llfGlffWHD4+/h3kxFgkrAPZ9NiSudWIpmLF7HJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=cAA1m5N/; arc=fail smtp.client-ip=52.103.68.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="cAA1m5N/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUN4rJNbz1HuvBk/bP9gbaxjoMTxi1S/vpgTMeM1NtSNGjf8rsHXkamN4faPFO4h3lVGB8/5uXRgKXpm3h4W5dIV9Z7CB2L+GR7rDIZ3hxlrKXhmIy53+J2+yszQ8BqjzgGudDOJzIGNN1OEOoWH88qKgYUu8v8b/Yw1eTW0VbPJ3PkmIsWHx1L1dPxXhPLhRnYglwUKpbfGrK9/GJvvsYUo2DqwyoNkbvlglpiN5azix2RPAmZFkk9qRXp4V5DirnVo9+CXDceXftW3V8RH/7FVHL/KkxhebB2KOacL2SBebYJ6sAwjPd4TOoDIkw9Eh0BCWUFzvGMVG6KmylJukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zoq3s7n1hPTSpwNJJbHVeyR+r+yKToguEdJoT3RYhc8=;
 b=vL6l92keuXsy9c6yCH/U5LKDxCnHqdfNP3biiXfivZp++CQX1HXXtNmCHV30y8NdZPGHvHAPyzqWAQ/8LNvMP8ktsQKLOR/GJYvLrcC3yq+KbE8SLBdRKp46+REa6H92I9SN7bkFmAjtA3j/I4iCgHuOcGiw1xG3W4kdzSYHg5L/sfbszBcCMEbxSDAULLMHe3ROC/rlGXgivmZ3Gkd2dL72bHTDZhtPVRFHpNzMzlO/04IS2y1Su+tO60QBs3sPXwZfjUlt29UvVpqXgsYnyARG+JzFZyIOckzAOPLBKj9Lewn6IlGECfrC/7qV6zowzcDjQbF8RDPlKv2/yEIetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zoq3s7n1hPTSpwNJJbHVeyR+r+yKToguEdJoT3RYhc8=;
 b=cAA1m5N/3DLSvNPeuUgziCg18bGQM1/ojPp5ZDJBpn3JKw3+9FpCykiSv8ph3czRUnH1HwR3U5Miqe7hQsQPM/mPK2qZW1acVe27yIwQqUnIXcSOZG8MrDCnVKBROCjmT1FKm3mtZmmjjGI9G1Bz+TvZZo9kilN5LMbC5AyaUwVo/P4H8/wmzvml87HZ/FOCx4tflSAaK3ISLAgBQaXecgTksf4JvVWsTZNMUE23KXPxFW1TXqInlZU/2pqZG6P9XebkZUUuVuJmrQcl9PLPo0dvRTQv+oyhIymLPohmwsiFJJMRz3fCMoJl5xRo7uJdZD0fB9TxUVl19qX2a/3t9g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PPFC2BBD9DFD.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a04::a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 12:55:48 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 12:55:48 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Julian Swagemakers <julian@swagemakers.org>,
	Jeff King <peff@peff.net>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v7 2/2] send-email: show the new message id assigned by outlook in the logs
Date: Wed,  4 Jun 2025 18:25:14 +0530
Message-ID:
 <PN3PR01MB95979A02866CF1AD640E48ADB86CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB95979AA8114CA26405BE02CFB86CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <cover.1748274404.git.gargaditya08@live.com>
 <PN3PR01MB95979AA8114CA26405BE02CFB86CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0013.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::35) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250604125514.1059-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA1PPFC2BBD9DFD:EE_
X-MS-Office365-Filtering-Correlation-Id: 2809f8f9-7980-4820-2236-08dda36720df
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayGf5nD+lJ0vysoGaXn+0TSqOaDTQB0+D6PQLEXXnr9zyueO/UM68ulsBbabhAsqHjrAxMJkHwnN3haZCtC0hML73v4Jzp3QfVaFxvMnvIpMrJzxN/nCmwUNur+h0z3D5UpP8OAhhRMXu0ZL1IAu4WwidD+2jX1oA7DzBHAiq+SFx+T8OT7pDgX6Di/8YeQSpDWB4BNoZK8Ag/z8xqMW7heAw78XQ5d9VI32GQoXc5GVbgxupg6epcqNAWObiC69OrLb5bz3EbVpKWBuczsxrnS3KlZlQhPubDm+/Vf+t2aaAToU5+MOqeT70LgeGPPoNRtq74qqadj8VU+avjcjHrK0FDkok9bDSLKI7KEvpSIrvY+4apGaBU4iGjgrQ3ZGgS3i/EVTVlPkeZ+qB79RcTuR0tM44NcUZNWPBfseGRFnR7sGOHyaLhwa5zWTWN4dP2aREKr4HrqGs09/teJvmMPTeL6VR33rxvOUClZgTSfs8yvmnQrFpG8PW837loJf/HUyPWj2JExIphE1SYVq7nXtoMGIeQFFEnzkSoyQfXBcwTJwhhpN6iIo8sTmHVNV7sK7YCcm2mkO3iQREGhM5DkQbXBAyvaDXuLNi1KUCJb++ltLVdstF3/PnlJvO+E+AGl42BolSb3WB3m+cibwk0SV466plldATbn3dhtIm/+cAmPPwtaZTIiMzJBheKZVk6kZrej3Vvc3M9buxZRebc+sfKXBjio6D+c=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799006|15080799009|8060799009|12121999007|7092599006|19061999003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yzVH38Ky59/wanY6X525c6aqjBEJUYE9nnNEbP6Z6By53FYvor5m55Nqehcy?=
 =?us-ascii?Q?bEjxYUfOno9ygItwujnkJPD7e1icREZTZ7FAWDrBFkIp49mnmlZ+MKDMIctJ?=
 =?us-ascii?Q?FroXbV+EGfvlkC1QHnej7AYp91SV8He+dH7r2EjiJoQtkkKWvGjeTHVjCdP7?=
 =?us-ascii?Q?1NfSOdkVLkHwqQLIQzC8XVU+rCvWYOL9rr2oHj7Wa+pwd+iKvfo/81M6iU2B?=
 =?us-ascii?Q?yBvtgCfz8wMlGmKyCIfRhL+9JJtZfKUSCEndB9pvpyKTKzW8bI6xAHm6WyCx?=
 =?us-ascii?Q?FuYqW35s57O2X8vjT3D+JgIAbjm2+XB0PhcQJpxHrpV233u/CqCuSlFDSZzz?=
 =?us-ascii?Q?KiaLxJ7KROnNq5+IXbnxoCD3uUkZpVbNQV4oMO0URZJNO5VDGC8D1EYJirlO?=
 =?us-ascii?Q?H3ffFWl7jaT+Hr/rr68NaRfwmPmLHil0hhcTqsaaMhiI7yM/NbRdrrBR75zE?=
 =?us-ascii?Q?YjUQTFqviE4LrOYfUDEcmxraIiKhaBTifjGFKfxJNs+7tCo0g3cS8zOFUp6R?=
 =?us-ascii?Q?y/4oqlPSsc/X7WyAFfAkPlmDKtmxXnZ/J8mENtdLJ9sjmryeIQoG5sX0w7Lz?=
 =?us-ascii?Q?gTz8rdK+Nd2He8ssb0FiDVs3L3r8pXbSOEvN+lqzCY8fXRSM+UQd25s/D5u5?=
 =?us-ascii?Q?WPKhSvZKgdJMEq56fx6rLnyIH5h55DsurbeuG6BvLKXdDPd12kyDojaT7amY?=
 =?us-ascii?Q?kkrl+R0Glvpt5oa42lNvx1lMeLkfKNSWOZEHptsxdCurFdVZaVizmteclXAS?=
 =?us-ascii?Q?d8+3NvVb+a1ngyRIc7Pnq/7TCrWMcmEvUk81FZVg6h/Uvl96vlaQFvmpfUlq?=
 =?us-ascii?Q?QGIVdV1Y6nCcKrngOZr/V33n1DWX0MxWZTqKFnLXqoDFCsL2hflCZeh/7owv?=
 =?us-ascii?Q?Blk7NBZsAOozie7jmcphj9WC/EvLfZiw8kn3YV9MFiOsn3WiVw8eMVjLZUld?=
 =?us-ascii?Q?GeINjZ7NXt24+LrUkcFPq+pO4DsiYjoF+J/PyJ/lgVuVp5kHJ0y3PBEAbnNS?=
 =?us-ascii?Q?crWpYPuA/zD/mu3iA0Q61tSHc7sQz1MauTF0kDNU3k9rs36vHrloT2B6V4s0?=
 =?us-ascii?Q?/C47FHA9KWV2cFIA6JAt6RgoWe28dK1AefIvlI6MX2H6oN9lYFByuI+aaQ0I?=
 =?us-ascii?Q?dGNVoZzm2uoR+DLgue0Q98G3KpwzV7s/N31td2nN+80E3/0nmdycYY8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i8k/2zpliIGDhGhnaVGDmBKM3gJIccprDdHLYSJtc2Vqa/bSxISyfOEX2Mj7?=
 =?us-ascii?Q?nHaBX504FdBsisu6+urh2RJ09UdIYC+T58VGc5IG26cx1wEz22jtK5xCbIBp?=
 =?us-ascii?Q?6J+YoKLV6hAOpnqqsBgup1jIa5ZMX4BYs1VCkYiczbvyCJ41ps+mCvf9Fehv?=
 =?us-ascii?Q?eNebRhVG7kGXGPPjwts8xqVLkUu4m1aietThUAa0pN5yAitaU7ueocmH4IWF?=
 =?us-ascii?Q?PX7c5j6XGIUIrx0xWeB+vQEYzl5dz+CxSLPSk/z1XitkFtULD/V+2SQz/0wu?=
 =?us-ascii?Q?E1AZJGG5N+Xdbc80S1BwUL4TpsgQB+sjgg2uwSxps2pVvoqiUNVCCbSibzmj?=
 =?us-ascii?Q?/WytZwSpmZAcNJgDMJt4Nnv1sIonbLfw6a44LTEtaCTzG+LNSbrtwHzJ5xx8?=
 =?us-ascii?Q?Z6ezVSis3ls7yCjMEg07+Ecga1BEU0IOiFUllpBWI53KnT34IDv1n37X5+zG?=
 =?us-ascii?Q?76DqYwSw5TidSSPeGHUJJ3Gl26X+NRfAxJh6RiMvJDkVK1WWZ17kqobqfgd1?=
 =?us-ascii?Q?mffxvuQXWZe7Qb8gAwzrl5Oo4pwbMCL0CSUSmNxwH68GLTdkWPCrRTFflaVy?=
 =?us-ascii?Q?+8RZ48rlSjqJuBG/S52TynXmWn72yfqmTao6hIfQXju5osC6zJ1XmS+AxJ8k?=
 =?us-ascii?Q?tXU1CiCdLv0Tt6+EphYQz9xwT/rYym6vhvF3RvmJ57132Ja3fhW5g2Q6eda5?=
 =?us-ascii?Q?Pd3naZ95SOXtZk41N8idGYAIkAoDuwXWshTIXdp3WyiMX/r4cx3lStr73r09?=
 =?us-ascii?Q?scsGWyobton5zq0i3eIUImfJeUJrgLfAKh312UHxBmRBXE39imXpSMmQxw0b?=
 =?us-ascii?Q?kYvFs51JP6iUzKt5o+tqWnjz5Xp0Utj9E7/o0w2yTPFw8Z3v5IRWwE7uvJvl?=
 =?us-ascii?Q?yoqDKciScm5yp1DYI+8d0muHIgSORSoUx+hq4chU6P5PVUcSfs6eM8YY43Vz?=
 =?us-ascii?Q?SW9F6MynfihuQr0oF/j7ekaeAuFGguHM6Bdfou97AwJ7hrttaNz84qt3YQdv?=
 =?us-ascii?Q?OSQMplRR+jtcrWxN/xdp23Sb5/r3VeDN8YGp2q2nPf4Bz9xhIp27pRcr5d7C?=
 =?us-ascii?Q?kMcdZX45vXVTQI95Zey/dm1Cd2DYsR8g/giPJq4IRo/Yc/Lo4a9L9w++VSv5?=
 =?us-ascii?Q?EIjD+DaNUdW8XsGCnzE2Il5+spKnUsYo5a9lVSZGoU3en1cCp1PQGJzdsUAg?=
 =?us-ascii?Q?StnpCug1pqA0RP2rzLqV/2SS8Q3oPJaj0zUdj0NykG/Ug9BO7DksIp9ToYIc?=
 =?us-ascii?Q?+36Cs6W7+Zr7auf77etMYB5RT4EJ13uLfC+Xtynwd4upVbsw3Ofr539zMSMD?=
 =?us-ascii?Q?mus=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2809f8f9-7980-4820-2236-08dda36720df
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:55:48.8244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPFC2BBD9DFD

Whenever an email is sent, send-email shows a log at last, which
contains all the headers of the email that were received by the
receipients.

In case outlook changes the Message-ID, a log for the same is shown to
the user, but that change is not reflected when the log containing all
the headers is displayed. Here is an example of the log that is shown
when outlook changes the Message-ID:

Outlook reassigned Message-ID to: <PN3PR01MB95973E5ACD7CCFADCB4E298CB865A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
OK. Log says:
Server: smtp.office365.com
MAIL FROM:<gargaditya08@live.com>
RCPT TO:<negahe7142@nomrista.com>
From: Aditya Garg <gargaditya08@live.com>
To: negahe7142@nomrista.com
Subject: [PATCH] send-email: show the new message id assigned by outlook in the logs
Date: Mon, 26 May 2025 20:28:36 +0530
Message-ID: <20250526145836.4825-1-gargaditya08@live.com>
X-Mailer: git-send-email @GIT_VERSION@
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: 250

Fix this by updating the $header variable, which has the message ID we
internally assigned on the "Message-ID:" header, with the message ID the
Outlook server assigned. It should look like this after this patch:

OK. Log says:
Server: smtp.office365.com
MAIL FROM:<gargaditya08@live.com>
RCPT TO:<negahe7142@nomrista.com>
From: Aditya Garg <gargaditya08@live.com>
To: negahe7142@nomrista.com
Subject: [PATCH] send-email: show the new message id assigned by outlook in the logs
Date: Mon, 26 May 2025 20:29:22 +0530
Message-ID: <PN3PR01MB95977486061BD2542BD09B67B865A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: 250

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index ac1d5b7070..175b0c184b 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1774,7 +1774,8 @@ sub send_message {
 		if (is_outlook($smtp_server)) {
 			if ($smtp->message =~ /<([^>]+)>/) {
 				$message_id = "<$1>";
-				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id;
+				$header =~ s/^(Message-ID:\s*).*\n/${1}$message_id\n/m;
+				printf __("Outlook reassigned Message-ID to: %s\n"), $message_id if $smtp->debug;
 			} else {
 				warn __("Warning: Could not retrieve Message-ID from server response.\n");
 			}
-- 
2.49.0.windows.1

