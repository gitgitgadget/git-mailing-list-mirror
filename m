Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF41A315E
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425952; cv=fail; b=pgOD75arrjmafuZk+KgpxUW/upenLzpzvd5f+7VikL850TaZiWRxsJSW3APVxhKF6GGOfnk74EFny7WwzROoZNiqpZzlhGbR3PbUMru6Tq15yGue80q/DEZ0Hii0BKMrFdlaTHu4TUfUTJgBsRU3dxYsCuaPgqTY+svaN6CNpNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425952; c=relaxed/simple;
	bh=ciGjbfjt2FKhMxD5OMd9rfFBCWTYCV9XOr9TOQsv8Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6/rRLLIovLcLTVSvUTfYFtbSYrD1DDgecAUcfFp3qdLIeNkz73tJV5J4dX+3eyLDJoTHRLRETk1/H/eYSuSK/UssHmgi7novVQMSNWNh+cBDT10+0TOy2akZ2AnRrjPN7zUvdeugTol0v/zfKWgyD1FSP4sOKDfOABoM8yrLgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ecXFvlE3; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ecXFvlE3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o24PXdnzXQ0wQdTi1EWdslkRyHi2ULFYQ0zYqUww8BAicPJBhiU7z7YziD1S8hRFTkcGKN5buWID+6WQaVkXcXjtE0GhAaGAYaeGt2KneORDBhQOE8TR2uYjonc1dTF7/DqlClpVdNSunstt75+RPaxyIa72/h9m4pGyJ1qZdzjnhBKSfdoXJifmHqcbD4M/CTEOjZd9sspE5dvy7Wp3NWer+38kxGl9kbNLmrrEn5Slx1aywBEb9abbLBwbBjsgDMMj1I6JSlUrBYRpZqUy46vM8CFnkkzSe7PU3hqsO3zEk/mZ8aUIGE9Lgi6q/oYgCP4UtXSWcDkCqG6B0mrC3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXeokw7DK0iCpWAXOWmAF8It8o2A8peAjtOOKKvn61U=;
 b=Q/MQtoHbdwiMOEhvCrO5E9mhtwz/tFFkBOFEnYVmL+G0SAShkzIIh1+AHt8kiysA0z5OQ4C7CQ6HS8cV4aZeZ127LIluvuaYcdaUN16BaUffjmvMwbJuWRjThoWs6RtIzAjCK2mx5XV2Obj10PS9ISDjYLghx3T/tY9IBGL12Vxa/ZvvLjt2udNZz1djhpzmd5PI343B1H9BdsSW0Pj4o5MlTaE3Ivm77Lpl4NYf741yEAzGbKPJb8WgTnCJrBxLMfYcFxZ3yCvJwn3c6TWaJbQKDwftcpDWHRJ19+hsJXxqquQwIsGzJ3cMfqQm+j7Rp4Y6zxhlNoWOagmhL6DGvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXeokw7DK0iCpWAXOWmAF8It8o2A8peAjtOOKKvn61U=;
 b=ecXFvlE3Qb2aNSIsRHU7Du4UKIHGtczUmCbeY5UdlAFPCMQtv5Kfp7mIxHCl++VcL2e+4D5TKfv4XEAtYR7g30CeToJm1k8Jl1RmnDj1857kx3U9b9TdmV62NRBpjUa67CuE79y3AHekfRGBQVKcyTKdw3ZD3uHjTRiBZu8Dm2BKi0tV6N+5iIt6c2BB9hEX/mHQvs31jld+mv9deheTvITHzQ9BfkI7RTCuGbOxql847KHFrXJNlxx+VXWWF4TVgECC8I0wrsi4v+hGCK9vqk7bLAbVMjU06P0FAcwMEQL2n/lA5/LGrxdI0Ipk6rsjLtjoaiJ3hj0JWC8omxXPUQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6047.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 5 May
 2025 06:19:01 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 06:19:01 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 1/3] send-mail: improve checks for valid_fqdn
Date: Mon,  5 May 2025 06:16:22 +0000
Message-ID:
 <PN3PR01MB95976908158F1091EC482088B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597827866A582654661102CB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597827866A582654661102CB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN1PEPF000067EC.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::28) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250505061846.11170-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 09abfd13-854c-4eec-e6b1-08dd8b9cb9fd
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnsOjthBlzVaa1GD4xhPUXjXmGOSh2E/3oul42Z27Dxnaxr+ocG8IydmRRx0VodGf0HfEMcfsHwn22FBkPLN1rr6+Zp70EaGfjqOFaMg79snCoYBfvKkzmCUmNfZQcBvu4lVBV5R+7czfiEve/8sjao2ZuL2QcJEkr23zExDPo9hZo+PP63/lpb6oQZIA40Q/kHhbtzbBGpq8oS02zD2qtvbMfrWKDWElUhnV0pSwjrJ5Ceu18K7YAlJWTAITBevdCEAqyfMZYvOxZnRpVsvXQT5bkH5MXby537ls8Us4V4SO3yT2XRQ3w9YpoFuloo75R8ESYslt+8VyF+Yx3uTRyVxyzPgZN961Rw4ljzrcphaE/Lxu2KMBy4mCZWWQibxQtgxssZKl2vUIkGNlJPg+AK3wj2nBiQXoQin8Fa08SsiqOX6Xt24pIpThsuBUOAZNe+lHWWuOlBPU1pP4T7eT5c4KaX29D8KDYr/G3kN17aoXTi8JH/EZSS4GY1IitTPS9HXtF046djV7/nBmMysJ1o84qHHHkTnD9YQSa0kE6Pba4M8WjCAaxVPKnalrJVz5PkYLRUqdm2ryKxjlxND1GstirQ2Y8jTsrgAa9ZZexxgIV81Fx3xqh1Ll51NnwTeu2skxFt1P/efUHnwpm+Es2KEKEdDAwJyodEuFGkos33iOPyiPtxlsYUL0oWrOsT1gUtIC7Ywl59AsiPbY2D/Z2HStNfvNUyPTpW4xZF3DKMZ8=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|5072599009|15080799006|7092599003|41001999003|19111999003|1602099012|10035399004|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EtiQgp84fTOSh4yWpfTBwfgoWV+1MKNi/UjGQGqMeunb9plYxEZCfSiuf8r2?=
 =?us-ascii?Q?JN0Gag61Bp0uCq+v9NvkmP9MXYZfriE9YkHd5AtFJLu0JbZbhsas0/o7pur8?=
 =?us-ascii?Q?PrTwcvC+dDC8kahEvH2PD6RYCBImlxDHdOZjkzpQRHFke7kuT/2b/dFFobXL?=
 =?us-ascii?Q?lnXG0Tf87FRaSww1XnveRzK5NHYiDqJNblEbbJCbKcwuknnxopmnWsW7X2vz?=
 =?us-ascii?Q?BujJmnOEs75JNW6NG3qaDa6Tit28rSURv8WodQ/X5rzKtJtGfr6vZpLVl8Bc?=
 =?us-ascii?Q?EWbc0OBidGsxEj6SctT5gfhrjcTiNeXn7dn+FMS/FQg3W1FOFYG8VSE3nJfH?=
 =?us-ascii?Q?1VxZQg3n/wqHnwuTxLR72Xw20k4oCwMUPRragaJ72fYNOa9p6PU0nHV6fERR?=
 =?us-ascii?Q?qrbKH8Cs04TF0IRBLRf1eqKmz7z4L9B2NZVAPNDrxvB6QH+rbITWWWE9884k?=
 =?us-ascii?Q?WmJeLzLjgGYJ6kLtktONcH2q42KuTTLVQClVaVWR8E3K0m7UJZ7fFJdt2JwT?=
 =?us-ascii?Q?BDBQxJkj0cQ/YEkHscj9W1p/bpCj62qm+O3E2NSCJNqKndBBL+GpaaHOEKMn?=
 =?us-ascii?Q?IAhzF24fBnLepc5TSZehOww1iS6TnTf1O6jE+2PCPqwdlzY0aAjzP4aX3Utr?=
 =?us-ascii?Q?YgBe3WxDfZFGlLAhJ1Z1t/tqQg5uCldCiSpQxDlZCTc/3HYwnG8JA9fbGAmQ?=
 =?us-ascii?Q?TchEEifrL/NGQiVbaJPesoPwlPPIWn0XZ4LuxxkVG08HAYeJbxiwAspzZXq8?=
 =?us-ascii?Q?W82VGV0q7eTl9Zja/Y0p5l19oqTXRPe4e0At49rBIhmdBVPCKdhAm1lrZ4uZ?=
 =?us-ascii?Q?mnUo+do1QmZhPAPjP4U2KShlcAa/08sXvFdaXPmrk2L7VzSzHIoy18kTllF0?=
 =?us-ascii?Q?u3S5Vm5aJSPnTSMrXbj+k7bK6+r2tFGIn+yE5ZOwrqNWEtR1ZoExCvbnullj?=
 =?us-ascii?Q?aOwq6qkXuC7j/ncgotaOwx1OPTGmvU+FuKTA6Hv+pzfh032v9GiehOUEIJ18?=
 =?us-ascii?Q?ImEz1mMwhO6orfNyr+t6mna0T9ANkvZcBQILL7ydAv1+rR1Mep0yPk2ms7FW?=
 =?us-ascii?Q?w4Q4YB9IUrl91RluhfbwJbUO/nvFO920YyzXHST3Kn2JYA1uO5erRJD86ZtP?=
 =?us-ascii?Q?QnCLDon7pceU+OVHwO+PnppjT8G+s3NfNIrK3p8bSUMRB4OlV8PjdW7jB9MD?=
 =?us-ascii?Q?vEHasZ3enlRlW6VrWki0bg37QZB+QR+V2Hwn+gUm1ruwCorkACCjwXMEGME7?=
 =?us-ascii?Q?tCHLyYRIYia+H1cAsKjnEJ04AsernIdxQtsMc9x/M8fnjGKgXvYIfO9xLseI?=
 =?us-ascii?Q?dSidxYE1WDL8lWzYsB7JhpKpNpAJinU6qiBxXFGUhtfvww=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UjJwc493ydWLJFrlHECpAj/DRoAXsyYFqb8QAI8aWU+z9JM9luWRflK/HTAo?=
 =?us-ascii?Q?MoZMvsQkNtf31+SLbAQfpOhXh6tEYQlG1bfjCjKWQEuQPrCex5LnXPsHPPh5?=
 =?us-ascii?Q?jPLc/XN8BzacExDtKK5UOnKBTFSZMsESzLC+wXKVTtbMr/X+vCP8DzfvJhoW?=
 =?us-ascii?Q?OOV+JLwkvRvZkigZFxUXKSruNibO+uikxa3H6/WXDZpo1euKK3PSoLYQ+IGN?=
 =?us-ascii?Q?fDf71NkUvMMth3WUSMyjRcp4LoXCxXfZ/Cq7J9tCEYuUIZ1lOwLW+gfYcrQ0?=
 =?us-ascii?Q?c+biOIGFEnB068BUQq41XunzqfFN4SsPtDTnjTNMM35souaCalKPXT6nLAQs?=
 =?us-ascii?Q?wSrXvXJCWYSBmVF2aslZNGpM5B5v80RkRrV8tqGy6/KGKx+KFnpw8cDwyoGV?=
 =?us-ascii?Q?dKF748UJ3FVFvWHwRSSwp+AbAf4jj0OV9Rxp7+vUiE3XRDyImGxPtocwUVdn?=
 =?us-ascii?Q?ex4LPjEwXB35wq/VilzqnwmCt6sR2BO34fhUXsGgW4MQz9+8T4b4/mitNx5/?=
 =?us-ascii?Q?nHA4LEiAXyLB3rcVbZN62Vs/6WC4WjyGjeToHQ+5pd7oHHaFx0BbHMU6Il6n?=
 =?us-ascii?Q?/a+xgC6O6+fScMepb1vOWtTofKshRQmScz08+SMN1YKdbnL9g2W104aaltSm?=
 =?us-ascii?Q?wtWYmyGnTztkn9Hn+KOCaVXJbU+v0W7VRkDWkdCLND/W4f3fV/twSsKs0VCN?=
 =?us-ascii?Q?pOAosO1O3TntvGY4+2Ys1kF+qwmxPB8EQZKM+Ew8nk3wBKAWkwdRqMUPYY40?=
 =?us-ascii?Q?hCyURkloWGOnBpxAXmtb1I9rGT7g8Ui856a1IMjlWeEkBrAUfTJHWLoSoRms?=
 =?us-ascii?Q?dNe4nQVHNqXtc1OJ0+3tUoq9jKkqe//12Ew2HvOkbaT0mk19NqfrUcbFJf0W?=
 =?us-ascii?Q?1VAWfk07lvV5I8hVo9pitNw7Vx9/2C3rxlFTfVfKuWXLr8snEkgeptM14oBz?=
 =?us-ascii?Q?MLaYQpqSrHtiGSzGubAxSmyMT/LsedQKqWH6jB9opNYX0IBJWstT/FhIO68P?=
 =?us-ascii?Q?KjX0cAtyGe/caVLNDtp6qKGB8//t7mEw9ekWJqtWSfQI0r98EesGNpjELRmq?=
 =?us-ascii?Q?2htTos7o292PhhJY7vUhPCPK2tvHdw0yovbBVKtD0+MOawYP9DQXKAkdlsyc?=
 =?us-ascii?Q?fXjyq7LT1M6rvsa3MkVNCtDXJoTIAVC7LQINP49WJvkIhSuQ4GKCcVlzLVhl?=
 =?us-ascii?Q?hiZas+aw/IJdQ2GYfBU0ehTNhWmomfcyzETDDoD8NQQFdVHk1m3nnaLn32I?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 09abfd13-854c-4eec-e6b1-08dd8b9cb9fd
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 06:19:01.0069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6047

The current implementation of a valid Fully Qualified Domain Name
is not that strict. It just checks whether it has a dot (.) and
if using macOS, it should not end with .local. As per RFC1035[1],
from what I understood, the following checks need to be done:

- The domain must contain atleast one dot
- Each label (separated by dots) must be 1-63 characters long
- Labels must start and end with an alphanumeric character
- Labels can contain alphanumeric characters and hyphens

Here are some examples of valid and invalid labels:

'example.com',          # Valid
'sub.example.com',      # Valid
'my-domain.org',        # Valid
'localhost',            # Invalid (no dot)
'MacBook..',            # Invalid (double dots)
'-example.com',         # Invalid (starts with a hyphen)
'example-.com',         # Invalid (ends with a hyphen)
'example..com',         # Invalid (double dots)
'example',              # Invalid (no TLD)
'example.local',        # Invalid on macOS
'valid-domain.co.uk',   # Valid
'123.example.com',      # Valid
'example.com.',         # Invalid (trailing dot)
'toolonglabeltoolonglabeltoolonglabeltoolonglabeltoolonglabeltoolonglabel.com', # Invalid (label > 63 chars)

Due to current implementation, I was not able to send emails from
Ubuntu. Upon debugging, I found that the SMTP domain was coming out
to be "MacBook.." and was being considered as valid. As a result
the script was failing. The debug logs with the failed script are
below:

Net::SMTP>>> Net::SMTP(3.15)
Net::SMTP>>>   Net::Cmd(3.15)
Net::SMTP>>>     Exporter(5.77)
Net::SMTP>>>   IO::Socket::IP(0.4101)
Net::SMTP>>>     IO::Socket(1.52)
Net::SMTP>>>       IO::Handle(1.52)
Net::SMTP=GLOB(0x5db4351225f8)<<< 220 BMXPR01CA0083.outlook.office365.com Microsoft ESMTP MAIL Service ready at Sat, 26 Apr 2025 18:06:30 +0000 [08DD842467C8274D]
Net::SMTP=GLOB(0x5db4351225f8)>>> EHLO MacBook..
Net::SMTP=GLOB(0x5db4351225f8)<<< 501 5.5.4 Invalid domain name [BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM 2025-04-26T18:06:35.781Z 08DD842467C8274D]
Net::SMTP=GLOB(0x5db4351225f8)>>> HELO MacBook..
Net::SMTP=GLOB(0x5db4351225f8)<<< 501 5.5.4 Invalid domain name [BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM 2025-04-26T18:06:40.828Z 08DD842467C8274D]
Unable to initialize SMTP properly. Check config and use --smtp-debug. VALUES: server=smtp.office365.com encryption=tls hello=MacBook.. port=587 at ../git-send-email.perl line 1727.

With this patch, it was fixed and was being considered as an invalid
domain. Logs after this patch:

Net::SMTP>>> Net::SMTP(3.15)
Net::SMTP>>>   Net::Cmd(3.15)
Net::SMTP>>>     Exporter(5.77)
Net::SMTP>>>   IO::Socket::IP(0.4101)
Net::SMTP>>>     IO::Socket(1.52)
Net::SMTP>>>       IO::Handle(1.52)
Net::SMTP=GLOB(0x58c8af71e930)<<< 220 PN4P287CA0064.outlook.office365.com Microsoft ESMTP MAIL Service ready at Sat, 26 Apr 2025 18:08:13 +0000 [08DD84B323498C1A]
Net::SMTP=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello [2401:4900:a052:31f0:9beb:e613:56e8:f897]
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-SIZE 157286400
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-PIPELINING
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-DSN
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-STARTTLS
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-8BITMIME
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-BINARYMIME
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-CHUNKING
Net::SMTP=GLOB(0x58c8af71e930)<<< 250 SMTPUTF8
Net::SMTP=GLOB(0x58c8af71e930)>>> STARTTLS
Net::SMTP=GLOB(0x58c8af71e930)<<< 220 2.0.0 SMTP server ready
Net::SMTP::_SSL=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello [2401:4900:a052:31f0:9beb:e613:56e8:f897]
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-SIZE 157286400
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PIPELINING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-DSN
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-AUTH LOGIN XOAUTH2
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-8BITMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-BINARYMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-CHUNKING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250 SMTPUTF8
Net::SMTP::_SSL=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello [2401:4900:a052:31f0:9beb:e613:56e8:f897]
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-SIZE 157286400
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PIPELINING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-DSN
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-AUTH LOGIN XOAUTH2
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-8BITMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-BINARYMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-CHUNKING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250 SMTPUTF8
Net::SMTP::_SSL=GLOB(0x58c8af71e930)>>> AUTH XOAUTH2 (OAuth2 access token removed for security)
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 235 2.7.0 Authentication successful

[1]: https://datatracker.ietf.org/doc/html/rfc1035

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4215f8f7e9..4c143e24bf 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1359,7 +1359,8 @@ sub process_address_list {
 
 sub valid_fqdn {
 	my $domain = shift;
-	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
+	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/)
+		&& $domain  =~ /^(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.[A-Za-z0-9-]{1,63})+$/;
 }
 
 sub maildomain_net {
-- 
2.49.0

