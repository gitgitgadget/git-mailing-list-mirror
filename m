Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B40C18EFD4
	for <git@vger.kernel.org>; Thu, 22 May 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747934955; cv=fail; b=NfVQ7gAGhMyOSgMyI3GWdIwpav3SWJiQpuznf1rV2k2ctFae9eNckKHa0+1SyYKzsD+/eQDKB71WYflAAWl1Gt97xV8RV6fPiQUNLb3ZQimo915dhnuqby6X3xh78w7+WdJVWKrxiqbj5uRoFsBxh03X9dQnAeu0naImPiErzzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747934955; c=relaxed/simple;
	bh=Wy9913VsAz3XxISQl2P2vGS6c4pn0R2tbjCs1N5QPLI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SZqfRzEz985SUW9sC8Q8y3HTtGSpSj5VvsKosQHM9eZbyQ/ukXlPiAnX+3fL0zAMWaNLw7w9xd2EnWD0ALbO3cQy88nUdBinuSKVqj99CPYS63VH0tvzxKsOa/w6d7CXBZfeKU9hixkJmSXCRSkmgaxTe+NOgCiEU7lJzx8nhi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=oWF+Kdrr; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="oWF+Kdrr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ3TaHgd+NDj8N1KI9J7+p3fiNoKZ25fbAVeruLjMq4hI2l+YGOHw3bP7B250EVATNkKLOXohQXvnbD/7D6BhsaHiAV5FfZL4/CWL9lbSsV9TZujkseQQVyszK+skmCPM1jVBJYHBVQFZ/IRewRxP81dqgjsd1q2F4r4dOeB5cBRu2FQ1vpuSLc4VHh6hHHBgMgRp9WCeZldwlSp6tE51VdCNwsP92ksLQFk8nleMEM8iH+Zq38L0zNeHwGgpdovT0cxAUN+L9JAeqky8tMvZKVYEKOEq5Z4mnhM5FRSQIrKHNYSFKbYgqHRgghUXkr1Fem7kOGjqryE9kHw+/Qc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zm7PPfutsRS2eFf68rJYp8NPfqmq+bOeOkgy73uFQi0=;
 b=EkqiSm9lBS8OCtzqy568vS9YeNgG0klauzg412QbbaHstqpm59qq8pmjY00mSI6YTAwgzCjGYJpSqH7b+8IOFElHLTYYk532T48kJHapEOfSD7QJfxHtfhbGWG0a2ocD1DVF0LuuKXembuT48eYKbCWIS0yKwQiBiKNwC8eknHCvEaVVrIcDYN2MZcQggGkFFLW9jguJG8qsaT4dL4JRh0fylYVbbCge+tgF0WmJ5J5ALOn80oK0/q1w+G3/Wv2NFR/6y1lAeqfG9wJ/aevgOeOdlEHUH8W+FP5CJ1mxVmCCwa4Bnvdggj7B0X0VXvJ1CgdmA2m1J6Mwrhm9LM9mqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zm7PPfutsRS2eFf68rJYp8NPfqmq+bOeOkgy73uFQi0=;
 b=oWF+Kdrre9zujfr1O+jdxqWa/nVbmv9xW3m4iyfS38IYynGTDDIx2hrzNrvjlaLEU0WIgcr6atjtBmxK4YcsFptIo8uAWDnToJWfVydK5zlHZQ+bRCUbs6m62c8uZ2NM/Ufwka02jrS83SxbtU8oQKYmCXywaPEw14WBpxcczuOV892jILJ7H1ChF9sMp7lvVqjDyPeN4PSqppLzpPw0WqMzuJhwd8VUcWN3pibeVKiuJcXbj8BAqdDeUGowwVf9SdAI4BlDHRF4k9Hlfk6xyW3w7JfZ5z2U9Unghp2RCiW8WPaTttrXIjXEnM0JQKr0OUEAb8iqo0orLQGLtEKJnQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB6547.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:74::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 17:29:09 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 17:29:08 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Julian Swagemakers <julian@swagemakers.org>,
	Shengyu Qu <wiagn233@outlook.com>,
	Zi Yao <ziyao@disroot.org>
Subject: [PATCH 0/2] imap-send: make it usable again and add OAuth2.0 support
Date: Thu, 22 May 2025 17:27:14 +0000
Message-ID:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0079.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25c::15) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250522172854.43999-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b48957-31ac-4199-e5ea-08dd995628a8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|7092599006|8060799009|15080799009|5072599009|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fpffKFjVA4EKXFNXlWQGrinZJaNM0dLyMPZV3FuDI1FMvop/Kfu4dCZ/jQFz?=
 =?us-ascii?Q?P27ZlZ4K4KH6nrjhb8em22VHGVX+YEO0yk8ywsIX7ZxBGuaxdofDaXqtai59?=
 =?us-ascii?Q?Kya8OAiO6k2ysZJfQMuOmVJfNo5yoVqhj10oZEBzP5gdPNN289L8t63kliO2?=
 =?us-ascii?Q?KoKlC8rrmxFrc5y3wKaoRr6u9fgPd+ht2ki0NOj/5qUSo+D+8pWomZV7MBni?=
 =?us-ascii?Q?R/OB94n3kYU5JBqWynjCOpqHee4FIEDRdWGkI2CRfYIUvv+wgK9U29lLmPq7?=
 =?us-ascii?Q?3cgcwHkkqag9GMfNjapeP5avuiG5LuFr93Qxfk8y3udbhktkRJqkPtRGjXoD?=
 =?us-ascii?Q?AZ7958ReOq6MjteDMCZDc3Pje0Aodx4Wb5CROpV5n6UHF9BBJStzqWMw+pjN?=
 =?us-ascii?Q?muW2HKnii6uIUa2l7osnVnFwwBoa7QPTLzFJuc4nS7dv9zv+gQaIjl7DGweI?=
 =?us-ascii?Q?ErSEcmLkKXTWy1WeXoEpthsUjvYQd0Jd288sRKGHiHhPa4TXPwUVkJcdsyZL?=
 =?us-ascii?Q?dV7CALmF2GiIKkC/5z/j+yGC8kNyUg2mq/aPsxoWEuSPlYAkIagVOVfO6fsg?=
 =?us-ascii?Q?t6h2f4W99A5foCIvD/Oju9E8nC2I556PsMZS2Slug2Vc1hSEyEYHLbcF1KlC?=
 =?us-ascii?Q?FZk8TaovEUlAxd24564TfX6nUQLrfeZENcTVv4eW6zDCfVEnRIYlvH/KqMas?=
 =?us-ascii?Q?V5yHQl+r5MEhmPnvSDBhcy8Mhu5MXRaDWVnrWp9yjao5Lo7Ek6MF+C8qzySF?=
 =?us-ascii?Q?O0yWxYQqKFxBGc1KCh0i6hd8WIDYLK0MFJvjbrQC4XTXNDCAXXCfy0Ia5b1M?=
 =?us-ascii?Q?i1OzBQT72i8zG4B/V0hsNh2sw11+80kEvb2fzHn3asITHf1Mie2Q5QDMw458?=
 =?us-ascii?Q?IarPfTcTaAbxAIF+aT0pQHkN/Dnm5PoqSZL0Og9zSSWyCTd0eBwVNedoNfaE?=
 =?us-ascii?Q?GnPITAsYm5vMqk/G7CP4HugIo2G2NYBAAD4MgDuWImgKQfKprrLZD6B/iAUF?=
 =?us-ascii?Q?nOXIUPupsY2gnxpQz7qXs6G1ETjtxR01ezhSY2fJkncDZI9aTL0i/oKqum+M?=
 =?us-ascii?Q?4EGwlStkZgUGlp72iPTyfB/HPEGU2duKvJl7MBKV6kPUvNH2Hm4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7sabFnr8XAZgXvriOkgNcitN8h5DuZecRjCzZnBQewc/kshLs4COdE6wxqwW?=
 =?us-ascii?Q?hWKRUbEy8nbxguT+ypclgJlKbr9n0Ko7gt2RdE3IJ4XCmrJxDfr3PFSK8B5G?=
 =?us-ascii?Q?lInobrbNtSugV6ojA2VAo275PTYVDnBBdScDRDXZEp2W0Nl2PGk216zmb6qB?=
 =?us-ascii?Q?4iZpwYT6dYiHzLetAblGxCh+V7hw2BDEFNabwipeU1bEkaUtjJDbS+qiwJxf?=
 =?us-ascii?Q?VYLW8QwPCti4opl9GihtOV5N08H96HWzIpZ/9Yp8vVdkrU1+CKm+FD5Vrhg5?=
 =?us-ascii?Q?T3+/LcoapLAlKCzLE0uWnCNL8IVXIGNbB+cDKq7fHJUdY/Fwj4LBgpC/CQSr?=
 =?us-ascii?Q?+/ey5mF7pt602XE1jYqg7CTQjGEAl7mH/7Uot/yN/6a8FCG9RcQbC/eN00NQ?=
 =?us-ascii?Q?tIHWS+7yYW7I1gTddGSgeCexjdOP0UOLpq4doHTx8+OavsEz6M02xy46pDKj?=
 =?us-ascii?Q?ZJZbVygoqnQYSEzrM2QqSuRPNpzNPDPr6zOev/Fgq+j1+mTLLi+F2S6UPRAG?=
 =?us-ascii?Q?uASvQHx3qJuKb4WxWfTxfaR8osy673j6201udu3IdQe+GELwUtAcb6li/34+?=
 =?us-ascii?Q?cUuakf6u8umT+7g07pt5aydNU/Zfh+QNcUq1UxPxlacrs/ci+Y2Y2k098JYn?=
 =?us-ascii?Q?/85oN7iO/KRp4bv4DN6m6L3AwqdZK1NFGMPIj6ELwUntE3SI68dkzuYVOBvJ?=
 =?us-ascii?Q?kpsPqngGBLRcNbB31m+JBbV2466JfV7rWc9v9z5JIdvWputF4neMLf9FHWl7?=
 =?us-ascii?Q?hTkI/EfJz7BSnBMZ1S79Cbloqg7rttXbKQ73nmWWJKrCvgDquLf2LBXY7gCg?=
 =?us-ascii?Q?Nl8xvigp4LpInvES95/g63unj3frcEfJYZsWNs7dz/rQbKT3WiwnWWwF0yF/?=
 =?us-ascii?Q?0FPV721HgKfj7/bmxDWE4Pu5BfEa4u7i66p+oLEyHS/+bL0G8PB+coWxlx1s?=
 =?us-ascii?Q?+J0wQzJWgyYVVYtt1/ha/Iuf8pucrsUTlm4FQqyzbhTFUwUhcnuDCqEJ5AiX?=
 =?us-ascii?Q?RNSWIUKRx1hBZWrWCxwtYvTey7hbE2/2LZZYsusJZ/Wgs7esC5ExVo7OsBpH?=
 =?us-ascii?Q?Wst1nT+Vy7FB1xcD9iz2xokOvpIIj9IUPxJn0JbhPb2fnKI8idXMNvnEwZb4?=
 =?us-ascii?Q?LpgolOz7RoUu/3Fb4+Y5FOlBuVC36DOq7EWXosUpGuciiwX9btPPOhPl4lXE?=
 =?us-ascii?Q?I9qWwmbsJS+ReT48GGGwctNINayBwFsvwzBdcMkBYA0mPUzSD6m08gH9dXk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b48957-31ac-4199-e5ea-08dd995628a8
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 17:29:08.8580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6547

Hi all,

This patch series does 2 things. Firstly it basically makes the imap-send
command usable again since it was broken because of not being able to correctly
parse the config file. The second patch adds support for OAuth2.0 authentication
to git imap-send.

P.S.: I am surprised this thing even exists xD.

Aditya Garg (2):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: add support for OAuth2.0 authentication

 Documentation/config/imap.adoc   |   5 +-
 Documentation/git-imap-send.adoc |  48 +++++++++-
 imap-send.c                      | 158 ++++++++++++++++++++++++++++++-
 3 files changed, 200 insertions(+), 11 deletions(-)

-- 
2.49.0

