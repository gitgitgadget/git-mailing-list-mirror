Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167C142DA43
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 22:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786055179; cv=fail; b=jJXJS0RUoUWYM6abRvgnfeetCe4X0gj0YjtR9Q3m2GLubEUgt6SxGYIVxLWcHR/TfRaYOrzBL7QzKOIaLQByC/rsLIh3dC3cJN4gO8gDXrtV3bfGHyWwvkZ/dMaVE36G5+DDYhIVs96LGVM1NOct/gysu1MQAOZGO8RIY5KDH5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786055179; c=relaxed/simple;
	bh=LYFToTUjcSaGKVRJEbRhn6DfTYURYkDnzwyqi6cpZp4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VtT9bbzdB+Q6qrYcKkxjTtpau+fjLJR8i2XItLVV8lvKmgDljQ48ouv1IjwAmx9SGPWi5R/vzeGNvisGjExv3I6n3gPeKRplyWzYLNEs8UczdS0yXuZhMILJfm1J90u7SM4kMPBx7+PSNi90tHgLkrfefOEnz+PukVhopwYRLXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=RFyg8tDT; arc=fail smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="RFyg8tDT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1755; q=dns/txt;
  s=iport01; t=1786055177; x=1787264777;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=+rp61CO5+l2pkmGq5pBhl5ry2FTtWITLXWNfp3oXSjQ=;
  b=RFyg8tDTEOr3BAGhsLZk1TqFcviexa511MKpCHPOUgRjsoRqPIBmCDmh
   G4uxY4nz9kiPOYSjw/TK4He44g/QJdCVnmagPwia8p+uHRXt6D+/jUpde
   UxlGaqF4M5ALafOXKnMJBxK949x4hTuBCJepcNDHuCHw4vjAs00rWVhez
   3tdaUKMX59aJmgO6pT1+jNGxqy1jFWqwg4Awv6s47tWXhUiZZbkcGLBjG
   bNIbTKKP0ZgoPZ9NiNnHbjdT9AN3jCZheeNydLtDNn2Z9aTiPTZKQZ6ys
   uoCJgEsGjySFc4QcLlxVjfV8jBrFrZ/XHdJxrj2l3rScb5EASMrMP6p4p
   w==;
X-CSE-ConnectionGUID: MrVbJQzwQ5qe9WKxU52kcg==
X-CSE-MsgGUID: oy2ND/t+TJaGfMIJ4EGbZA==
X-IPAS-Result: =?us-ascii?q?A0AFAADXCHVq/5IQJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBZYEXBQEBAQELAYFtU4EKgSGIbAOETF+GWIIhnh6Bfg8BAQENA?=
 =?us-ascii?q?QFRBAEBkm0CJjQJDgECBAMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGU?=
 =?us-ascii?q?AyGcyhRAT5BJwQ1gmABgnQDAQKzGgGBPQKKKniBNIEBhH3bNAaBTQGIXAGGM?=
 =?us-ascii?q?IREJxuBSUSBPBuCOIFaGgGHUoIwBIINFYEMiEWDV4ZcgUocA1ksAVUTFwsHB?=
 =?us-ascii?q?YFmAyovLTI8Mh2BIz4XNVgbBwWBHYEohGcjGTZ8gQlegS0qZRIXgQmCYQKCd?=
 =?us-ascii?q?4E1BAttPRQjFBkEkS8+gRUrLoEFVSkKLgQ4kyyPXqMwCoQdoXUEL4QEjRSZV?=
 =?us-ascii?q?JkII4I2oTEBhQ0CBAIEBQIQAQEGgWg8gVlwFWUBgj1SGQ+OONAEgTYCBwIHD?=
 =?us-ascii?q?gMLkWgsgVIBAQ?=
IronPort-PHdr: A9a23:SaXrahKSZvMASDNCAdmcuVQyDhhOgF28FgcR7pxijKpBbeH6uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1oNwg==
IronPort-Data: A9a23:VCREcqB8ZNXUyxVW/2Tiw5YqxClBgxIJ4kV8jS/XYbTApDtx1jwBx
 mdNCzuDPvaDNmbxL910aoyyox4BvcSHmocxOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZvCCeA+n9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357jXmthh
 fuo+5eBYA/9hWYuWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE5u9QBmMPL5Ihp/96UF5t5
 cFFcjMGYUXW7w626OrTpuhEj8AnKozveYgYoHwllWCfBvc9SpeFSKLPjTNa9G5v3YYVQ7CHO
 YxANWQHgBfoO3WjPn8bEI81nO6snVH0ciZTrxSeoq9fD237nFQpieC8YYuPEjCMbcJExGC04
 X6Fw0bwLR8/Ff7D5BWPwFv504cjmgu+Aur+DoaQ+f92qEOcy3ZVCxAMU1a/5/6jhSaDt8l3I
 kgQ/G8q6KM17kHuFoi7VByjq3nCtRkZMzZNL9AHBMi24vO8yy6SB3MPSXhKb9lOiSP8bWZCO
 oOh9z8xOQFSjQ==
IronPort-HdrOrdr: A9a23:YPvbi6v77zxfPQtFmGkRVXnd7skCZYAji2hC6mlwRA09TyXGrb
 HMoB1L73/JYWgqOU3IwerwRZVoIUmxyXbsibNhd4tKLzOWxFdAS7sSoLcKogeQUBEWmdQtrp
 uIH5IObOEYbmIKwfoSgjPIaerIqePvmMvH9IWuqkuFJjsaDZ2Imj0JcjpzZXcGPTWua6BJc6
 a0145snRblU3IRaciwG3kCWMb+h/CjrvjbSC9DLSQKrC2Vgx2VyJOSKXWl9yZbfyJEwL8k/2
 SAqArk+6Wlvci8zx/Xx0XT455VlNaJ8KoNOCWLsKcoAwSprjztSJVqWrWEsjxwivqo8kwWnN
 7FpAplF9hv6lvKF1vF4CfF6k3F6nID+nXiwViXjT/IusriXg83DMJHmMZwbgbZ0Uw9p9txuZ
 g7n15x9qAnTi8orh6NouQgZCsa0nZcZkBS1tL7ukYvE7f2roUh67D3snklSavoVxiKl7zPWN
 Mecv00oswmP2+yXjT+onRlxsCqUzAYGxeLRVVHh+muugImxEyQCyAjtZYidrBqzuNnd7BUo+
 vDKahmj7dIU4sfar98Hv4IRY+tBnXKWg+kChPlHb3LLtByB5v2ke+B3JwloOWxPJAYxpo7n5
 rMFFteqG4pYkrrTcmDxodC/BzBSHi0GW2F8LAX27Fp/rnnALb7OyyKT14j18OmvvUEG8XeH/
 K+IohfDfPvJXbnXYxJwwr9UZ9PLmR2arxdhv8rH1aV5s7bIIzjseLWNP7VObr2CD4hHnjyB3
 MSNQKDUfmoLnrbKEMQrCKhKE8FIHaPjK6YOJKqj9Qu9A==
X-Talos-CUID: 9a23:WLOCjWO4Fdoa1O5DfTNZ/mwtCN8cL2TQnUjzM3LlU2ViR+jA
X-Talos-MUID: 9a23:lKgHfQUFHurHpGrq/Dj93hdOc9sr34anJ04osLdaluaOBwUlbg==
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-l-core-09.cisco.com ([173.36.16.146])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 06 Aug 2026 22:26:09 +0000
Received: from alln-opgw-1.cisco.com (alln-opgw-1.cisco.com [173.37.147.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by alln-l-core-09.cisco.com (Postfix) with ESMTPS id 308BE1800021B
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 22:26:09 +0000 (GMT)
X-CSE-ConnectionGUID: cpGt5TxzQwKUMdaLEC8+yQ==
X-CSE-MsgGUID: 2ehMLicYQoiQeEP7Vr35ag==
Authentication-Results: alln-opgw-1.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.25,209,1779148800"; 
   d="scan'208";a="82760065"
Received: from mail-eastus2azon11010031.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.31])
  by alln-opgw-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 06 Aug 2026 22:26:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msDK98OobVwhFpTP0JFhgUCZxR4J5Tp4yiGzu1uTGaAw55YWn3L44qqEZ41E5zU+3LLqOlau2EixxHqewDnEzHq142NufXnMOuhyYD1f8crZ6n/pkBnXB0dkU1W8Gi7be/8ksdPExzk1LbtHoKJO0VBiYpHjba0ID1bNGjg7bpjv+O9iwlvuaLl/KtJF0+4NQW7VQJJ9GOvJILjK+AxO2U8xvolMFKuGsZcbmZxZt1RfBz02SPtjcTPud5jAH92eyiiCUq6qbhLtP3nIFHsjxUNDoW+4w+p74EYdswsnBOmWODeGwkGrKkcxWXTtrXOzkFHC2v7EC5Cog4zXqtyZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rp61CO5+l2pkmGq5pBhl5ry2FTtWITLXWNfp3oXSjQ=;
 b=Vk11Upc/ZsJbU2QS3raiVxv5FjyIAorL3HWryJQIjJDd46QjOiulKHBEZu4wfhvT7ERbtJ88/grZ9t4XDqmV0l/CBi2x2FdKfnIITWOzdk+B/oVIw+Sn4/ycdA8BeR0YMB9BxbV2ojtZuYdEmyq9R9O1Yiswy3QahQqfAKXWMt4Eq05JGTl1UNtb+lcX1vInk0uXrwQ2bSDbS/ujA3Ph7aYKmc0dU3R/4j0YL72zbZpYQcSLOKQHViNFefKX+J8qsM/57f8/S+unRyW0HyqSZWTzkNLcRGuHTMCQofG+43gtZcOUkodSob8BFxEQa/V+pKzr1tBfTcnVB+4oFILmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DM4PR11MB6405.namprd11.prod.outlook.com (2603:10b6:8:b5::12) by
 SJ5PPF09F392AFF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::808) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Thu, 6 Aug
 2026 22:26:06 +0000
Received: from DM4PR11MB6405.namprd11.prod.outlook.com
 ([fe80::a1ce:2981:4693:faf3]) by DM4PR11MB6405.namprd11.prod.outlook.com
 ([fe80::a1ce:2981:4693:faf3%6]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 22:26:05 +0000
From: "Douglas Puchalski (dpuchals)" <dpuchals@cisco.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [Feature request] Separate explicit fetch mapping from default fetch
 selection
Thread-Topic: [Feature request] Separate explicit fetch mapping from default
 fetch selection
Thread-Index: AQHdJfKSOjaZZcnTKEyUIGaNB1l1Qg==
Date: Thu, 6 Aug 2026 22:26:05 +0000
Message-ID: <C47215A6-B86F-4AB2-B20D-54D048B9B2BA@cisco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6405:EE_|SJ5PPF09F392AFF:EE_
x-ms-office365-filtering-correlation-id: d6c5e1fd-5191-4043-dfad-08def409b4d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|10067099003|6133799003|56012099006|3023799007|18002099003|38070700021;
x-microsoft-antispam-message-info:
 qcKoeDULBOsAeEV7c6F5Rx1V2ZHwkk0Y0Bc8ZfYZKT9Hc+DZexxC65At3QAa+lZNLq8L6iegvIS0ZT5lyk+OC1L1fJFcVtQlMdMYJoR6nS/kcfbnjMaVeRFeEUUMvUOKLu0y2azzfl26WIhaQTxrdIHjBQ9t/l2ph7FAtSUMBETvW85U5ZVX8P9eX5DBoSarZP0sli8Uy9E5c12rXroIwvVxBpusak15hpbGzm35j8bo6FFb1m8akTpreLTCGXtgrBWkmMvP0mD7tDVai8ukamabXuDHsbE1vMGOv/CrdmnEhgKtRbwh9f5zrc9aHY+MmAMIu3JsBVV25l4lfZg9Rag+tZ98n+sPmJVmtu2evXCToMa4vdAmtBkmSiQv6NhRGPJd+gnoODzOaeLH4H9A348to5rqvVqlolQxednEo5AhXLIkEiBj3nBqa0gquoo1b33L4mvtNT3xsJXjjA7uAtXCnJS38iY1r85fAeJ5xaxWxBXVGEqshGz57SgE7p5sIZKlvgAzmRMWktrGyKRUq3TkSBhDLMPK5RcewagtovvR0cViPmc05sdp585ZZA2pYPnYLCIBek0/8pymdxBzMl/NswUhb6qwzSzseCh4I5XdOCnEUGGLQJqJxK2Iq1eUTG6AYtr+jx87kMYNbBeclc5I/7Zf/PjtSYpnxiyi44flBs5efOV8en8cv2V3lK2p3fsEB0RJ+mfSrhMQcfLEpcctrBUegQOyJtFiQ0SMgg4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6405.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(10067099003)(6133799003)(56012099006)(3023799007)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?K56+uQkjLU1zbVGpqU/dw2ARzEh0xtz5nm9B1Bgl4JmpjEolud4a0+MjaPuW?=
 =?us-ascii?Q?OZluz8Hds+nFnMztwn6l4vf8mkdogNghYBHQGhutN3whpVJELtcv3Y2pdZ3M?=
 =?us-ascii?Q?2N5wW99rNMSCBEYtzCPEfgPS4H6vdWIHnSf58qmmX7qRCAgD1q9V/ta1j5PP?=
 =?us-ascii?Q?H1ByANXli5H02tVFbukhB0IFr7ysEhpMQ7I5bV/lWMEFFm9VayRo6Cp8t823?=
 =?us-ascii?Q?e0wXvsL2lRMucfEQKlKLd/NgMM4KGYnQSrtRFdT5N7RiDGdiELWVdnx9GtOg?=
 =?us-ascii?Q?XEaKiGKWjElo9gAxamRFhjwlEEfSRTdu4Yn+DlcI9SPN+npwR3e5L0xU7pBX?=
 =?us-ascii?Q?QXxCorQUoF/RlLg5aaksmImQjFHCQXDtziHH+3vP8BiXuzQ+FS+OZTBh0C2R?=
 =?us-ascii?Q?PZerwO6vybELPT7R1A260eSRQBnzUm/qVRae82IjrGrkbjkhe0yCGdGAf37T?=
 =?us-ascii?Q?GWiJ+cBUAmgjATEYMqpNORW1NKfgShfJDW+Ad7dctpUSslHW3XtMsyG5UJvl?=
 =?us-ascii?Q?nl6YqXdbMMzXOMpEWUex/M8Oo5RFNRnAqfsrGGcbScTuKvF3IIhtFy5hZK0G?=
 =?us-ascii?Q?RmcMogzHYO8KZcmEkETcH/2R+Hr3U4ZM/14eRzu8BGSBpw9knm9i3N5F5tpU?=
 =?us-ascii?Q?vqgl3zNrxVLMDtSXBrnbknlvkDbwy2FGMtKHw9nA+KWrFd7ZKqYkCjMcgbn6?=
 =?us-ascii?Q?hZL+PjAAg1KRwz67FXHS1NO3X/0UgVgBk19BONpHw8fziccuC0CDBiwaCgVe?=
 =?us-ascii?Q?Tta3YH8dXTvnCAESodTEy3Y6qihngFJaMg3r7s8BCoVbcKo0zvwQcGuKaAP6?=
 =?us-ascii?Q?K+8TXnvBZJWycExtfM8xKA7y9o/YVtbisH0yUoetHQl4qk3823Or9mSp+FX4?=
 =?us-ascii?Q?wnLUPC5y3Dct+QSmPr6a5u+nzPevWWaTCm/vLk7nXvRgcQydHR5lDS9m9+rS?=
 =?us-ascii?Q?EkTNzamgZujSAiar0ehshpqypz+E9PMgP8hr06rBwksCBJIuOU2EwssLpBDH?=
 =?us-ascii?Q?wy+E6eSYa8O3j9U2Gtf8tvP/55WWlJjWLfCgQ1AhamUCq9QpNDj8/u8eBvl3?=
 =?us-ascii?Q?VpcmFTHP9EBOyxJOJMYwcYE/pZgEqtLzyG7UHMvE0nKUih3RFCozAaqkYbzs?=
 =?us-ascii?Q?zWLeghQBztUtI2DPh/GT+0AXzX5FkgMgonb9soX54Pyrh6hKGTJb7cT98Cti?=
 =?us-ascii?Q?wBKRuZpr+97yjjmibg5rTX+F7XarX6hGbBf5+l6IapXfwcqpyAQC47kU4Pii?=
 =?us-ascii?Q?Aj4LXaSc5T1wricuOQBRQeYTrgEms5ylaqdBOg0nbtQWBAUgZ0Amo0UZdBwe?=
 =?us-ascii?Q?cHKVWK2v69BfkWKJkM7fS+4XFIoY8kllY6I0zW7L0I8wLkUDIhFmK3+txUa1?=
 =?us-ascii?Q?Lcbxg5vlKjM053iqOw7tOBB+Nw7PyvnwzUml48nxb9mTqoqnpVAaXIgsMWWJ?=
 =?us-ascii?Q?DAY+wgvw5DiR1zJc2dRZxw78+2tUBMhQinxULu9gX2uuYFQrrbKgW72VbEHD?=
 =?us-ascii?Q?0N92n+W/3b2kEoj9Cx+HSl8y8ZNvI1eW/mT5gGFFcnXA20hJSSBeM8/SeYmx?=
 =?us-ascii?Q?SGCKQKWLRxXiRG3k61m8iKpBuYy2+7RgaIcVBEXNQo+CoNqVDvgVxknexIoY?=
 =?us-ascii?Q?AV9GdAONtKcxWQ8RdV4jY2I3yqqFaB1T3HksQahH4/4ui9wGRXgq9lT9Z/up?=
 =?us-ascii?Q?GVZYutL95GfsnQrsETGVsrCp6oODxSCYP4hc8H5r2s9wVe7IcqrBgyR9kIr6?=
 =?us-ascii?Q?LhzLVUoJlA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52D0B863844E344192A66020BF572CFF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	YwO0XxlezyQNtNNUf5JIvQC0HtVmRGheZasaKAcJ7WdhZ/tW4WRaU6ZPZg3rFEIeFoXM1tQ6qnjAKm1bBo7DnFuXfzp6+KPK/RxQ8QzsrpvxDh+KvU7M3uDqEnVqWK4CoD4wZoXynUoiSgRC0IqKtc1IK4s0m2IURkgSTXSETo2T2HYbs2Wvr7+TRGqg5zKJJXBsdbJ1EtvIBMBIQJ9meiq0Dwd4azBLWzyTEtp6sHRAnjy1qpI6d1rC9oDd9VClQuSToWY7UFWqNrcpXMhxpOQaYGx36PqG7QLQOvOs8rAYTMxIUuTyXQNvPBPMJTU3oEMHlGdZP2BsxB52+UGzSQ==
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6405.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c5e1fd-5191-4043-dfad-08def409b4d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 22:26:05.8469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unHRFBd7Npx0wuz00z0CM+cNhXOF7xYjJDx+6/bo1U7SWuT9QG+f+UbtF6Y/DEx/2ERU0VPWPxhKrqnLvaB4lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09F392AFF
X-Outbound-Client-TLS: ANONYMOUS;alln-opgw-1.cisco.com [173.37.147.229];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 173.37.147.229, alln-opgw-1.cisco.com
X-Outbound-Node: alln-l-core-09.cisco.com

Git version: 2.55.0
Environment: macOS 26.6

I configure a remote to fetch only a small default set of branches:

    [remote "origin"]
        fetch =3D +refs/heads/main:refs/remotes/origin/main
        fetch =3D +refs/heads/team/*:refs/remotes/origin/team/*

This prevents `git fetch origin` from fetching and updating a very large
number of remote branches.

When I explicitly request another branch:

    git fetch origin topic/example

Git fetches the branch into FETCH_HEAD but does not create or update:

    refs/remotes/origin/topic/example

Consequently, the natural checkout command fails:

    git checkout -b topic/example origin/topic/example

The documented behavior couples two separate policies in
`remote.<name>.fetch`:

1. Which branches an ordinary `git fetch <remote>` selects automatically.
2. Where an explicitly requested branch is stored locally.

Please provide a configuration or default behavior under which an explicitl=
y
named remote branch is stored as the corresponding remote-tracking ref, whi=
le
the remote's automatic fetch set remains restricted.

With that behavior, this sequence would work:

    git fetch origin topic/example
    git checkout -b topic/example origin/topic/example

It should not require fetching every remote branch, repeating the branch na=
me
in a two-sided refspec, supplying `--refmap`, defining aliases, or handing =
the
result between commands through FETCH_HEAD. FETCH_HEAD is shared mutable st=
ate
and can be overwritten by another fetch between commands.

A backward-compatible opt-in configuration would address existing scripts
that rely on source-only fetches remaining temporary.

Relevant documentation:
https://git-scm <https://git-scm/>.com/docs/git-fetch=
