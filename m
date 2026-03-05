Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010002.outbound.protection.outlook.com [52.103.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1904639B4B7
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730101; cv=fail; b=o26sXMxhleaQGHG3Mc8V86yzFBMs2YoAWsWX0GMOFdqJO/nmexVegVaW9uNhc18bBNOjB6SKOspsbqzk6wVCYTiqy03YOxGN7FCrmaIstxCdxzrPVIYUj11UqHCrZRK9T+ghPO9TUhLV981um5PIvwOhukcmiC0g8vCuEjFRJG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730101; c=relaxed/simple;
	bh=mNyjF60qpQhKXhTuQ2Wxu8X12ZB4y4bBdQ0r5q35q9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LuP+6C08CIhPHLf3XpZdI7kyXnBfJ682KQyuQi55aGBs3Qd5NjvKtWk4ro9nPUr32qW+UbiFN35kEh/N0KjllWnh7Wt4pOhE/0SkAGz8M3MBp26JDN1j2Rk3nlTfuNaSPT2wA24RyiH5pZO1lJw78c0dBFEAgOnb6glQtclOTYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=hfdgJqTh; arc=fail smtp.client-ip=52.103.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="hfdgJqTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkHobOBlgBwIbyfg9sNJRWaapl5BcZ0Cht8ia3/ItpIf/6+IBod0l5szbPCKru2gBmuyzXD1ykuDo0GiM8NK6Wjum94I4YnrKiH06qi+AYEXYJFMVMZ9JacB833GWUz3OnH/CeTeh29Pij59Ge/a7jGiESx6KLVkZat6sdFo+W2Y40+klShEs65nWsIv7zt1/cP0bbpN7M8sfKyCuETCfPXhhWDpPM5/PjAsRsyTn2qxyNpGBPBt3F3g09JnJn6FUQ1DNM3jiGFdA9PbtKDiZ6hMl5S2pLQ1tvTTe9vXFoff1b3zFrv5bGXc0Y3Gv8VkrQgV8pxR/cmT+DLbGOpI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkZgFai5bvr+BmhePA2v1hsq0yhznKwZMUQKVDYRhHE=;
 b=lXyDGWoNsj726fpqDnMY1wdvb7V3NHBnAOwErOK+HJHJfyC+X/XvNCarueFNITrPxuHeGWqidFKFn4fUL8fGwmE+qu17qF4W/Wj4rJKd+CBAsG7uAEi4z3Z3biH6/oZtKyvuNG39GhzzF2j0NwyDlZmyPy+SCxHxkGsX2ftltA5blnUrK9IjqhLhKfUK7WYCVlPCNUUbVLmwLZMnacJxkBQ3wIutp/rceCvivkQl8n6YV6EgIdnb0EdEuZUvgTUxipFhZuH5QGJmQOiRa6GZYAgS5oAKmN6SVe6BmzsKO8ckDfL2IhHS20ZLP7gG3L4X3v55bHGXL+dhs/M2cxYvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkZgFai5bvr+BmhePA2v1hsq0yhznKwZMUQKVDYRhHE=;
 b=hfdgJqThFOAIsijjyedFDn709az1PmpbTe0RO+MvTMEz6OML6QsTaj8rXm7OTGvgtJG7R7oTp+ej81y+1rW25QY9NRM0by1f4PKW74ITccpIgGpiwDdvXDslzvRMee0x7FS1+eKBkzBe/O2oVPN0WT2P8cSh8oAIxTLuLCWQEmRgO+FMxRv4Q/Kpoe8/BpUhvFueP/7a0G3cu6kAu2AxDYYeIK9b6Z3HXyyEnB1mbJwGxIul9aiARIVd5r7mZeb6J7TM1P6UhlLwvnKPDTJEb+mEquYvtYBoduds6bSiz+Y6ht99vWKvhqJq2kB+pOJYA/iEf++n0Qy09JOMNgy2BQ==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MA5PR01MB12084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1be::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 17:01:34 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 17:01:34 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH v2] send-email: pass smtp hostname and port to Authen::SASL
Date: Thu,  5 Mar 2026 17:01:15 +0000
Message-ID:
 <MAUPR01MB1154634CC04D29AAF7CADE5F7B87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <MAUPR01MB11546AED093D8641767AACEFCB87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
References: <MAUPR01MB11546AED093D8641767AACEFCB87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0114.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b3::12) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID: <20260305170115.6996-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|MA5PR01MB12084:EE_
X-MS-Office365-Filtering-Correlation-Id: 166c1546-1e9b-448f-525b-08de7ad8db5e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|51005399006|19110799012|25031999004|8060799015|15080799012|23021999003|10035399007|3412199025|440099028|19061999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b2oB8lTY4/56MZk725s035HvL5bZ1IpZFP2vTF+XD7iwqZCI157LMRePoap6?=
 =?us-ascii?Q?kkFUXU8MP/Z0OUb3AfqZ3Tleugmsj2wLb3Mh18aYyy+AOZmvfPZIGzEwrL4k?=
 =?us-ascii?Q?o3H0uiz9tPOCPIjQsjBpTGazst/qD+3GE1s41BoHUoLuL/opYw9IbpLeisGE?=
 =?us-ascii?Q?gI6WrbCftWY+TJZLV6izeDN0ozkjXzlOgV9oZYDf5D06ObgW8JE5WaFlRdyY?=
 =?us-ascii?Q?4txszzOXFFzFhHmFoFaUUCd4j8Ru18wX4z38c4X7ijecit1vN1COpWwhLKrT?=
 =?us-ascii?Q?log5t/RanEv3QhlriH10Xnrm9sEJONknnT3/zdyZdbBhJ4qGUh/RZtHSRVAo?=
 =?us-ascii?Q?pcJKaTP3WcURBc0WnzOsuMkOu0Ed1TdjNtEzXxkoMr+8+q5vFNcyKMVl97zS?=
 =?us-ascii?Q?u/e8RMxmr6tnVdAOz/ga0QleE7gxaQYHMc9bq8vr+DDu3Kr2pqgSURmSjTpn?=
 =?us-ascii?Q?grIsZGKO9wqOQnoIRdhFRgNnqinw0b10DL7MBd3hIxA3hA43YpvbvxDfdbQg?=
 =?us-ascii?Q?bitf0NLhxOso1PRhJh/LeIK4NiFXqnSvKUNkWGrV+2A0MHip+NOC1LlnaXmD?=
 =?us-ascii?Q?aD7qOe6GAF9s6Hk07vft1mMgj8s/wiq+USjaA3k/73YdRLAh9hn5Teb3KKfS?=
 =?us-ascii?Q?vjupvLlPBo1v4r18f22Jlli4qTRiSrE7VhJblsJJyBLOwVvH+1o1Z5peQEpU?=
 =?us-ascii?Q?qmxvprrDGNAwUpZQW4KPBgHlOWIM5Mwv4qnM0L3x8BkZ6Z9u07R58+td4tQ8?=
 =?us-ascii?Q?aADZMm5+2mb29Vrrl0wFd3OZbgDS/BffD0rNM4ehoIO+LTWnCCQcxd/d01uS?=
 =?us-ascii?Q?e5yE5A8I0ggdmr3Uv9HyMkHnUVT40uTaHtnSaFaeT9dq+PPQmTFJye5148CZ?=
 =?us-ascii?Q?opkQUr+btiv6mBmeyhBnxzMpZdUl+5M7TtSu9g00koAZe3ocPRJ/UwKryujE?=
 =?us-ascii?Q?A1+SlOL6924MZPVrk0c2jkkdS6PMMP951juDPq/imfc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6MrxMzfDOdsAgpkdV4Y2ejrp+a38PL63oWt4/8Tb8WEBJM6jv3zh0mJfmEZF?=
 =?us-ascii?Q?T/rAv5yOWdbArtPNzXmVRki+YQ0uLqY+eLVCfna0IshenLvln+YSC1GKdXqx?=
 =?us-ascii?Q?lqvR39fM+gA4muYqbOW61Yr91euZRCgL5wVVcQzuMIUR3s403shx2fUpDF1e?=
 =?us-ascii?Q?EqlV16ejk9vXB48uaRh55ANlhONE48UIXx7002xdpyksBRxyI3YRypCHHjsk?=
 =?us-ascii?Q?Fonsfd376hQSjNqOWrgAcr6szGbXaGvjEM7hJlXIDWRmjQ4NXdGqUJoXWNXm?=
 =?us-ascii?Q?fjs/PVd3/F+SC8/8xAbHIMZkHlFq1mbr5sCQJGUESM27pRzxLy+f9Y9apYQR?=
 =?us-ascii?Q?OBRp/V220lXlrQpDaCMMEB6Y6PTUObHo5tPtlOnvs9oEAp7OUwH3hUZ6Xb2K?=
 =?us-ascii?Q?UTa/9puR8d5SxaVogEnIwH1Rq6IBO+eYc4z5m1PBghsrbfpqZWRJxxOOzLNw?=
 =?us-ascii?Q?sKYyIiepGQZKiXAN/OFOGlIMwGyDnX3S+fbj9NQ/k/GUFQHvKZIqFTEESrOY?=
 =?us-ascii?Q?cnxQn7UT2tQ8UdlHMzqS/jSiKKQSbPbBunBjDK6iNN17dl3HghyAuss9nPSX?=
 =?us-ascii?Q?XBw5MuCjsYBX/7Xm1Q0xZr28S6AmZZDTMGixp/EIDYrA/WmJXhGI1ZkjS3t7?=
 =?us-ascii?Q?mvglqWL0JAJFaQ+Pt3+8gTDvQoATqi2hKCVuc4AQUfd5RGSXffv2foDLoFQW?=
 =?us-ascii?Q?cryISBf/3glpocFyzsU9PpyvQme5dVZWNJaB/9KHzlbSWIwR1rXPWZ5QO0cb?=
 =?us-ascii?Q?EUZxxllqJFawNM+5KAb/znrc4dwOOq2YxuBKvdmh66rim8WhvMF0t08sgUAu?=
 =?us-ascii?Q?1k9kPrR+JLaqvXBeMENfJ7mOtE4prSgbYcwv4ZmXKVwFLD/cDd5cZuAJa6Kv?=
 =?us-ascii?Q?tKT5zzfk71hD5XPhBm9lZSiwpGlIqIRXbFenhVkbQ3yrtLdXYkpAcrbUu4Ma?=
 =?us-ascii?Q?ABWuF9SBWLIbikEMFDc7bXqd6vS2i2lRhVDbesRZvXtlcTUzqYd4yBe0p8C7?=
 =?us-ascii?Q?298NYJxLqKsU1NkauXxmyh8RUUp67mBNkKvnybq5q5zi1v1jnoO14Dbe01Ng?=
 =?us-ascii?Q?NCjJ0pbOJu8Ujg55h2ZEq6hk+wPtgx1n/UM8QBcsEKcG2noro9Vu2rVt0wFs?=
 =?us-ascii?Q?TbEwJkiwKDWSCIpyyoUMk7I3c+PYWjDJAkTWydvfSWZtM4bYEOKRwweCjZ2t?=
 =?us-ascii?Q?1uQaRsrSeTKBkEGI37d3dLu8p3nm3ookbbkezGJU+f0sT8y80AjRNOKuMv5C?=
 =?us-ascii?Q?RwJ/eDTkK0ZKeoHxSbJ6U251u0eLnp8AzlhbfL8BNtECu/zc2M0mUeAUm4Yz?=
 =?us-ascii?Q?R4vOgdavJ0KGl39jVLfeGoq4+RiJWPPHwujT077p4xQFVsYVT53F4xoegoet?=
 =?us-ascii?Q?rfBn9yg5rEbTlwsQRjke+9WWDLLK?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 166c1546-1e9b-448f-525b-08de7ad8db5e
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 17:01:34.7350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5PR01MB12084

Starting from version 2.2000, Authen::SASL supports passing the SMTP
server hostname and port to the OAUTHBEARER string passed via SMTP AUTH.
Add support for the same in git-send-email.

It's safe to add the new parameters unconditionally as older versions of
Authen::SASL will simply ignore them without any error. Something
similar is already being done for the authname parameter, which is not
supported by every authentication mechanism. This can be understood as
declaring a variable but not using at all.

Link: https://metacpan.org/pod/Authen::SASL::Perl::OAUTHBEARER

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index eed5420882..0ac4d634e8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1474,6 +1474,8 @@ sub smtp_auth_maybe {
 						user     => $cred->{'username'},
 						pass     => $cred->{'password'},
 						authname => $cred->{'username'},
+						host     => $smtp_server,
+						(defined $smtp_server_port ? (port => $smtp_server_port) : ()),
 					}
 				);
 				$result = $smtp->auth($sasl);

Range-diff against v1:
1:  9b48ca57ae ! 1:  5befaa626d send-email: pass smtp hostname and port to Authen::SASL
    @@ Commit message
         server hostname and port to the OAUTHBEARER string passed via SMTP AUTH.
         Add support for the same in git-send-email.
     
    +    It's safe to add the new parameters unconditionally as older versions of
    +    Authen::SASL will simply ignore them without any error. Something
    +    similar is already being done for the authname parameter, which is not
    +    supported by every authentication mechanism. This can be understood as
    +    declaring a variable but not using at all.
    +
         Link: https://metacpan.org/pod/Authen::SASL::Perl::OAUTHBEARER
     
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
-- 
2.52.0

