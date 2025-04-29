Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011025.outbound.protection.outlook.com [52.103.68.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255A211A0C
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924094; cv=fail; b=lPX7eiRAvYyzyILe7TYPvmQUeaVCpblijSKQioVrLq0RWFfUfx3kgVJAT5qA5d1blIyiOQlpvjIkPBCMpali9/6W+mFXV/DcNvu/WILKXVfj1BbW/luy7shgb6Tyy8nkHvukSwr4X49G7RhNcKcLRxicVwAYbfExjygHVnLqEn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924094; c=relaxed/simple;
	bh=o8W5g8bUq/6CZYgnhSPaQBY+OJKQqL6SIP/NDkFQkEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TJLA+aB0rrOpXjcn61nxUfkxvSDwyszJ8quvk/3wmK3lwKvj+t20WQa3aYd0EhmwJEFmI9TPcszWDbXt4saVh6OK8G45CO1hPwreRdEkFZx9jJ8m/KGMYAvd/hfOCDq072B81P5BDROHVDzzjpGkbZFva+isSa8toSHoSigMeW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ovvR4J+h; arc=fail smtp.client-ip=52.103.68.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ovvR4J+h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZOm9VpifD9/+xL1ZUfoco/zYcu1b9Wm8uHXcwIlp1khydhiOlMaMnXcY/zy/KhJTGS9FEawDRxtAQs7fq/UstWuXG/BYGBF2TLfaE4EWGPYFgi+fTeo0v2J1V+Z0sCyag+lhsdKsBP34IqZQ1gtyQ2Qb+3GxyoEmC4JtUvIgONTORUw0Q7XQ7nSLJO/wmG/GuPml9CC/yB/juNOcJTVC6h+KkseXrMVPr2cNqT2sYMCwOoCbnuEwxh6iJypYRNQ2glV6YMNk0hQZidi+SGHaITf91ZuHJIyD1slXDaAtFFuLCO8i6doueAoLA11ccu+qy7WIcw6u6yvMQ3sUX80a7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JydKdaqXGpsGDalQsgWca34y11fBVpRBEFegS5dTy74=;
 b=StXH7Y+iM1hOBTuy8XQRNPzAn3HOu+88Xz9QO97YTPJmrnPI6/wv4QVRF5LUmxxXr43kQxbMsXNIpWBfR4O5fdunHW+uC9H0lKnFNh3mKaf8EBGu8sHLMV/IStuqHa0ExHp6Dnu+24kxXIq4VvpqW4kwz6q62xBWx5A/9PXSWJL5rzFkkL3H0Q4tBAai21Qse4pnu6ueamgHsDh2qd92PIbJ0KjByX6AazuRak7YAjDWZQFu0eiwY+HGmTVehEX8oPdjZcUfNSbfr67FeTaz8GD60G+TOX9rmwL+YMg+47bT7b+RGt3svelJA5ZjfFvJ059+W9MKy+h66ME+BpGeuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JydKdaqXGpsGDalQsgWca34y11fBVpRBEFegS5dTy74=;
 b=ovvR4J+hRMKohrdSk2oxpusSVJem1gRW8twDr0kFvVbNJYJOONRQ/f4Qtv2QsPjO382OvMuwpXUkQbbzDyjs2HgTJZXtrYNi7InV8LPhX4Gec6hyPCetMlJnhbsZNe+L1dvBLRwWLoqaQob2GJoq7y27KNFWzWZ9tWfYoOuaOxrne9uATtcVT8ka5vrhWYPCSVc6ryWw5IV0Ginf2LWQGL4H28yHv+ZWpD/Gk1WPiR1yaKoLvrwJYdctA3kCpdjc+G2gFtm6IB4nCXBNQpZM5cRVEteACCdV+RZkrZY4CGt3SKxLXbo1cgGg3XNe9cKDDRWolyUUW468lOdrOkZIow==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9625.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 10:54:46 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 10:54:46 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erik Huelsmann <ehuels@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v3] send-email: add --[no-]outlook-id-fix option
Date: Tue, 29 Apr 2025 10:52:47 +0000
Message-ID:
 <PN3PR01MB9597274E541169BDB8DC4297B8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5P287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:265::13) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250429105246.29809-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB9625:EE_
X-MS-Office365-Filtering-Correlation-Id: d6493dbd-4ce9-4480-57fe-08dd870c4114
X-MS-Exchange-SLBlob-MailProps:
	gMiuAN0LASI7fc4EPd4bfKCsouzBTQ7X7kfouj21ZvNCunYVodi0jnKe9TaXmLaVTcQJGYiS9YsUA1S60R30zqhHCfv2/Ywi3Y798d1PaHkr5Usw2XYRrc5cOrf0c/OmtmhrMiD5uFo8r1lo55NCyWd/M8zFKPuIaMeLo/UCy58+4F9RwymgkRMJU5dLCMlPFM/6tg+5s35kyVs47+KOxfy4gUFSM0Ceyu25qrWsSuBTr3u9Gt3EtZveU6SPRFUa4EFJKqu2YUmV8xKF6y6Y+AenKKc5xnznCpKcfaP+HKuCgpJ99tU8BcdekQtmRHgGZQYs4H/Al896QfhVda8OEa2mMQdMI4/3ysah3kZIB4/LMUy65bjmWlFRc7IOk8VwqIPxOLrWKj4bW+PFgqu8Prloo5YgZHBVJHQH1+nLmXkbpPiehTAobPebQlnu9y9t6K/eh6+BH/lxQxtsCQmkjwUB29kQdmmMoS92y5++G2L8KYZyzKa7dVuXmym4vXbTWY8q6BaVmJ0IYKjD1AsPpJINZCOLr8PqAH1euk7COtlsT9wJml/voofntW2uV7SZ1YxVGFz2DJqUi9mLcL/93dS7CGvzSUAzYpbq5MzplXwXpZtly1c/jPOFtUlhSp1P+eyOPm8FrzV+jLJTZC6ftZ6gn60mX0IV/CJWO7VXe2cIW1Z2hKfzkTDIyIUvaLEEwmhu9tjfzgBswmCBR2ptlg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|5072599009|19110799003|7092599003|15080799006|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SBb4pBPE+nT3gF48BOTYUAe6Z92UMQZc5bGawtCD6SuDETMDv7xjpq+HFJCY?=
 =?us-ascii?Q?g4x1g5c/5aoxB12puj///w3UGSWXeqqteMgXV5AW+sr6SFusWznd7DbgW25d?=
 =?us-ascii?Q?MA6xYJKSq8bDnY8C7JCw/NRCSdHzC0lEKso/uHPUFCrCNoixqfxyUFP2l0+d?=
 =?us-ascii?Q?/JFjV/j9XpQf+I0TOdEALukA8TeCnLnON4u9zjrB9uvpssNsHLc5cfGp5pMw?=
 =?us-ascii?Q?ULQ6T8sHDHNRvSs/KfCRoaMkkSRxUyb6OGnNONtqYkMD60D5coNJMl7uM6Yj?=
 =?us-ascii?Q?TRN9WZ39H+WuYhrDo2QYjEm/iVuFISi3YQgkldu7nynOvfnmeLWHRHV4kg8U?=
 =?us-ascii?Q?DtgUgmptaL5va0GhCvu9aj4HOowScLvNVDsdfk4/23NSI2vYvhjjnR/TbVmG?=
 =?us-ascii?Q?wybigZu39zdS80GAjdvmPlzcV6zGdyBR+t6vibQ7UsW/IaR9HzERI7iT4G2k?=
 =?us-ascii?Q?O6j12l+uulEyzPfdS+TnH31UOHM7QfwNjpPLlzyowSls0aR+GGWgj2QlN/AB?=
 =?us-ascii?Q?VSQcSTnvh3KtN4MkS5C9tBqk88uZYghnx91nQDRy1ZP/uD5rY9hWUcWdnvo8?=
 =?us-ascii?Q?qS9LgoFPF7A3mD+qqxsUalHT4SmzqE390veMLzUEswz+RgHOXyMEX7/YMPDj?=
 =?us-ascii?Q?EtTyp2Js1NDVMdpGWhU56K+AJB9AtDEZtDpIPj2en3jOsZfZNuAfP77lEXp4?=
 =?us-ascii?Q?wO+6RHrB8HSqkgzvq9vZBFfwZID7Qna16YZK7XIBzGb3dF2shQnyXccRicON?=
 =?us-ascii?Q?/a8+NaTRV/CT5nL+xCHSzupZxJi/z3amegFsdaVO+esYO9gpyIEy5CADlsmU?=
 =?us-ascii?Q?7ZSf/jbTB8BVZKAc2oyxnpvSyUFd84nCsUazqZkX947FqsUNt/UPaf9glBip?=
 =?us-ascii?Q?mIdyHxRy9SXtfSA6V5Gdy1Ya9RL0tAlDA3J9c2jFlKfVUnJkQRdTwA6cb7VJ?=
 =?us-ascii?Q?qNBeAH8xrEPKuY5QNMxxuFAIoAkJfjaPXNXzyLlu8lmhngxz3BYnYobTufL6?=
 =?us-ascii?Q?pPQQQrSljEnmEly+qdq6ZRa5vSacaSqm47s3RYssmETFy2NP9UtCL5V56IJu?=
 =?us-ascii?Q?j5xuceX4U+10X9B0Cerruo/PU5WARQGis0+/EXsr4WyNr498B92eVqvwHAmJ?=
 =?us-ascii?Q?WZQcYGWdMDudKUdlP/mSmo6wTntp5rhOpw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QWFQJFOLIPg3fM+0Wy0Rr+Y0GmPxzYMK6kyOfRYm3OCGDADw8PYwsba/mE35?=
 =?us-ascii?Q?QnQsPP1Ua/20ls66bFnWUYb8efBqu7tUsnvQPFENro5og1nAxTtE2IM1ujmK?=
 =?us-ascii?Q?lysHcwegpIzmJPzTwp3QdvxCTR4ebXc8CDoPVs4+eqj+Ow3M+4mmOkmOep+X?=
 =?us-ascii?Q?PSTOx4Dl5XYxpUl69iLEL23ryy6Bmif6x8yQmemzfFY8ILkIYbxFiGEBN8qN?=
 =?us-ascii?Q?oGdhlK8f+Q6R91R7hMQGnGrxQukn+mSOjZAFOMdNorOCdzpjGNiDT398tYDD?=
 =?us-ascii?Q?Q8PtxVVVCojipz/GhdWLg5Qz3IJbiulOBn4T/kMQVRWp27Pizx1ayS3n+Fck?=
 =?us-ascii?Q?EtUHSBvn2tu8wGDzLUp/2Au7yh4VbroMx6Iso2HMgXcggn2ZKdGkqVszQGa9?=
 =?us-ascii?Q?iBTKqjj40Htq/FoSsN6wLZGvbgccz+j3rXtPwSN4HRsmooyKfQDYO4EIp4Lo?=
 =?us-ascii?Q?evCdS2ERRHz1fGEZCUKoYwW3h/Zscs5sm3Bz/MUTgBtFItDz2aaPsCQ2ILsb?=
 =?us-ascii?Q?gvQOrJcj2ExZYo7yWByjmsh41VRq3ef/seQEK9uKRLsw1e4uh14WbMvNVuiG?=
 =?us-ascii?Q?j4yTvxLhC5GhKOJPYvqdKSP5uYDrVvy8aPwoRjXFHTsvnV4zEUFE6KhpY3yM?=
 =?us-ascii?Q?CTPw+XFaeOBvGlQXezuXfiFivUd4D52LeFx72oe8Ofc5I6q53BdBEbZ0/x6f?=
 =?us-ascii?Q?3QMAnhIr7w3WncajAj/2evf8dEvBACujwrj251NSkZQDdXh1m1+IqT/tuyvW?=
 =?us-ascii?Q?BEoq35FyL9hVf//GjPWQ7MLlawKjGA/N6skdlCaH5Vb81btpJ9j27+NZMWTM?=
 =?us-ascii?Q?ROVE+joBVM0j0CMS9SGc/ePrBt0/fSe/wCLa5jE/NLg+tjRkbhnIg3YhSvok?=
 =?us-ascii?Q?vuSXSCVrJ5KuuV6qrjkoFNhSwyF8aGpUoU3plK9h6TK+eMEPKv4Bc+pMt0uN?=
 =?us-ascii?Q?OjajYPWkHsTPuFzWIReeG58dTGsqq5vgWAVWFnvToUVniG6e8CXA7VgyZYG0?=
 =?us-ascii?Q?XM65Lgp/o3V2I93S6rIICRLKUfpEfv9/5/OEUEyTNkkPANqAcjGVyOkmvbkG?=
 =?us-ascii?Q?lILPOj9gdd8RvkSnVDqEnHrTKYJTcVoimElW5PJL4Lo2KMa+F/vswNZkwfhS?=
 =?us-ascii?Q?XG5wgqAtxxdA7PO6SRADSsGR61sbJ9xCR1RByt/kQXtkaYQ5mavuNXfTrZnc?=
 =?us-ascii?Q?CCrjOCeUnRUtE9CWIg5pMAM3T1zBDc+IbIoGGHLsSgZ6bRGTToqTG7mL8uY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d6493dbd-4ce9-4480-57fe-08dd870c4114
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 10:54:46.0893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9625

Add an option to allow users to specifically enable or disable
retrieving the Message-ID from the Outlook SMTP server. This can be used
for other hosts mimicking the behaviour of Outlook, or for users who set
a custom domain to be a CNAME for the Outlook SMTP server.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
v2: Replace tab with spaces in "outlookidtweak" => \$outlook_id_tweak,
v3: Rename to --[no-]outlook-id-fix and make it bool. Also add missing
    * in description of --no-smtp-auth.

 Documentation/git-send-email.adoc | 15 +++++++++++++++
 git-send-email.perl               | 13 +++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 7f223db42d..5760248893 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -115,6 +115,21 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
 Only necessary if --compose is also set.  If --compose
 is not set, this will be prompted for.
 
+--[no-]outlook-id-fix::
+	Outlook servers discard the Message-ID sent via email and assign a
+	new random Message-ID, thus breaking threads.
++
+--
+- '--outlook-id-fix' will attempt to retrieve the ID from the server
+  irrespective of the SMTP server being used. Use only if Microsoft is your
+  email provider.
+- '--no-outlook-id-fix' will disable this tweak irrespective of the SMTP
+  server being used.
+--
++
+If not specified, the default behaviour will be to enable the tweak only if the
+SMTP server is 'smtp.office365.com' or 'smtp-mail.outlook.com'.
+
 --subject=<string>::
 	Specify the initial subject of the email thread.
 	Only necessary if --compose is also set.  If --compose
diff --git a/git-send-email.perl b/git-send-email.perl
index 618474916e..ed707bfa46 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -41,6 +41,8 @@ sub usage {
     --subject               <str>  * Email "Subject:"
     --reply-to              <str>  * Email "Reply-To:"
     --in-reply-to           <str>  * Email "In-Reply-To:"
+    --[no-]outlook-id-fix          * This server munges Message-ID. Retrieve it from
+                                     the server.
     --[no-]xmailer                 * Add "X-Mailer:" header (default).
     --[no-]annotate                * Review each patch that will be sent in an editor.
     --compose                      * Open an editor for introduction.
@@ -68,7 +70,7 @@ sub usage {
     --smtp-auth             <str>  * Space-separated list of allowed AUTH mechanisms, or
                                      "none" to disable authentication.
                                      This setting forces to use one of the listed mechanisms.
-    --no-smtp-auth                   Disable SMTP authentication. Shorthand for
+    --no-smtp-auth                 * Disable SMTP authentication. Shorthand for
                                      `--smtp-auth=none`
     --smtp-debug            <0|1>  * Disable, enable Net::SMTP debug.
 
@@ -290,6 +292,7 @@ sub do_edit {
 my $mailmap = 0;
 my $target_xfer_encoding = 'auto';
 my $forbid_sendmail_variables = 1;
+my $outlook_id_fix = 'auto';
 
 my %config_bool_settings = (
     "thread" => \$thread,
@@ -305,6 +308,7 @@ sub do_edit {
     "xmailer" => \$use_xmailer,
     "forbidsendmailvariables" => \$forbid_sendmail_variables,
     "mailmap" => \$mailmap,
+    "outlookidfix" => \$outlook_id_fix,
 );
 
 my %config_settings = (
@@ -551,6 +555,7 @@ sub config_regexp {
 		    "relogin-delay=i" => \$relogin_delay,
 		    "git-completion-helper" => \$git_completion_helper,
 		    "v=s" => \$reroll_count,
+		    "outlook-id-fix!" => \$outlook_id_fix,
 );
 $rc = GetOptions(%options);
 
@@ -1576,7 +1581,11 @@ sub gen_header {
 
 sub is_outlook {
 	my ($host) = @_;
-	return ($host eq 'smtp.office365.com' || $host eq 'smtp-mail.outlook.com');
+	if ($outlook_id_fix eq 'auto') {
+		$outlook_id_fix =
+			($host eq 'smtp.office365.com' ||
+			 $host eq 'smtp-mail.outlook.com') ? 1 : 0;
+	}	return $outlook_id_fix;
 }
 
 # Prepares the email, then asks the user what to do.
-- 
2.49.0

