Received: from cathaymailout.linyuan.com.tw (cathaymailout.linyuan.com.tw [202.154.200.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC70513AF2
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=202.154.200.155
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788952; cv=fail; b=JqZ218Ei9JY4vmgcAWXyiUWM5LfQ9D3PPGwItyRaqU15XQcrsUmaDbrfT0dgZ4xP8DWfRG2u5jtfBdEtmBAqvjJPEH5XMW+Gv0U7smTTxqZbwkspyU1df9YruykCYQQ3buEtNy+nPgLxpspRXOmfmA10O2kUj7DV+5Pz4vWwXlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788952; c=relaxed/simple;
	bh=8WdCsxdUwVAWju78wlO8pR2N793rBdR6gxZ7+k9omes=;
	h=Message-Id:From:To:CC:Subject:Date:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bNBGsX/Y7xXJUppd2IzQj2JBc+pz8JDIvZdkBLufJ6eL52nWq2kSND1peyyH2Pn+dv0niwrpY9m5fGeva6/yEg+e51YkvQxUJ60Okb4I/PJYUCoQVPkFQZ/6nsKibV1PxfHe5SIMgbqIO8VtjOxtNhjah5eBNkilgNMBG4mSrHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cathayholdings.com.tw; spf=pass smtp.mailfrom=cathayholdings.com.tw; dkim=pass (2048-bit key) header.d=cathayholdings.com.tw header.i=@cathayholdings.com.tw header.b=c1uTatl3; arc=fail smtp.client-ip=202.154.200.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cathayholdings.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cathayholdings.com.tw
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cathayholdings.com.tw header.i=@cathayholdings.com.tw header.b="c1uTatl3"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cathayholdings.com.tw;
	s=cathayholdings; t=1744788955;
	bh=8WdCsxdUwVAWju78wlO8pR2N793rBdR6gxZ7+k9omes=; l=5018; h=From;
	b=c1uTatl3sGG6MQH6Jk2T+MFD4jeftrtrfeueptje1jd/FT61lP1J6QB2k2muwGOhL
	 56FCDNiSQup0CNJXUMbH0Cq+aWOYOkXATYGbcOJ38k5HX/2lWQPz3BSNgjssfEMp0o
	 7G/ijxz/7J3mDQ7fQ6dsRHD0KEsgX7j4dTrwMjWsQsu9Yy4sn9mVAsSU9JT+1OqtdV
	 a6IyyCCa9GUUxJ12JGbalXXikILX7z4PngL3Z7NpYPgXDoMgs1kHMJIojA+8UiVAp3
	 SgW7duXbbl9AaTMIRRmMve9HeUUoLQE4CwBxIZDPWML1/GI2160nfxXC4fHPKjTl+x
	 7FpBvXyqQHDhg==
Received: from 365mse01.symphox.net (unknown [172.16.20.143])
	(using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by Forcepoint Email with ESMTPS id 546FC70AA13A553DD410
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 15:35:52 +0800 (CST)
Received: (from root@localhost)
	by 365mse01.symphox.net id 53G7ZjeU083840
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 15:35:45 +0800 (+08)
	(envelope-from kittychang@cathayholdings.com.tw)
Message-Id: <202504160735.53G7ZjeU083840@365mse01.symphox.net>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by 365mse01.symphox.net with ESMTP id 53G7ZdYd083725
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 15:35:39 +0800 (+08)
	(envelope-from kittychang@cathayholdings.com.tw)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o43nO+DDA79xsR+Kzq70iOkdfJmrXmN1yZNgI0P7vpo1TLRvNlKTba/FxDo8dNDah360hsjZb751n02XDsetSjZSMklbOKOFsN39v0dIw9hlglaxyxPtNKih0tqI8WNbWFjaeXrBFcSZ7DMq3DGWZ+YeFugfD+BUZSep1odHM53ib01gos2aKlTUPWb62/p6cU0oloiAYns5J4Za+azc9vUc615e8ymCIskrcA3sH8HKwZqI9hUqSI35rMvJA4D3++sCwOcftn6gT4+8Ku5hegvhQvGUgCmmAh2ee2YPP6G/h/0ymzAimtMZCiSGKnUg5p/sRZJ81/N4qLFU9w8sgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WdCsxdUwVAWju78wlO8pR2N793rBdR6gxZ7+k9omes=;
 b=lpelcmY4SNAIRUODB2jAN7H4xIvhVBsQaPdV3kJfQitXuYMQiI0KIWDJAB6qk+lLV46VeNnm1YYroWDbVGbPdONHYmRbWIEECTBWj1VpkwEGa0tWw2UzfKJqaibMpkfMEwXDLUhLcdu3oYv9rk6KgLbgC8/C+gwO5slhvW93P9EPqSTgwlLgY3OjrtmZbi3BZDg8vm+9U0gqkSKfGP74sawLl8WJJCCOdkv4GOEv08Kdrqf/nK5aRNlMSXMrXKhMXpnTQ3fw3D0HeAVgjV+j4X5nGSKAhhFRKoZSb6oPq6JpntGtppbYA6DkA/i+bA8T9YNbzSjrwlzFwEAXPjA3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cathayholdings.com.tw; dmarc=pass action=none
 header.from=cathayholdings.com.tw; dkim=pass header.d=cathayholdings.com.tw;
 arc=none
Received: from CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 07:35:39 +0000
Received: from CH3PR12MB8711.namprd12.prod.outlook.com
 ([fe80::ed6c:d961:3742:b02a]) by CH3PR12MB8711.namprd12.prod.outlook.com
 ([fe80::ed6c:d961:3742:b02a%6]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 07:35:38 +0000
From: =?utf-8?B?5by156eA56mOIEtJVFRZ?= <kittychang@cathayholdings.com.tw>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: =?utf-8?B?6Zai6Kmp56mOIFZBTkVTU0E=?= <VanessaKuang@cathayholdings.com.tw>
Subject: Get support
Thread-Topic: Get support
Thread-Index: AQHbrqImU4so53rCkEiei0CJzVbqQQ==
Date: Wed, 16 Apr 2025 07:35:38 +0000
References: <1744786449-14024-mlmmj-0f30ebef@vger.kernel.org>
In-Reply-To: <1744786449-14024-mlmmj-0f30ebef@vger.kernel.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cathayholdings.com.tw;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8711:EE_|SJ2PR12MB8831:EE_
x-ms-office365-filtering-correlation-id: 4a1cc323-b1e8-4e0c-1aa0-08dd7cb948ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|13003099007;
x-microsoft-antispam-message-info: 
 =?utf-8?B?bUY5bGNhRm9HZnErVU5sSDh3OGlsZm5tL1pKZ1h4M3JJam9rZWZNMENEZDZL?=
 =?utf-8?B?SmxoTlAyY0ROZXdmdksrMHlKd2toUWZXZzZPenpIU3pXcVJScWk5WUhqbTdW?=
 =?utf-8?B?dmY0TGtZUHp0SkhIR3k4SGpxVmc3SVNUVkpiSE00cXdxWUJZTmY0cUpuMTNB?=
 =?utf-8?B?RjYvM2liTGRKUDhMT25IWElNdjBFZWQrUUpHRVhrVnBqQXpiQ2hIbzhhczVa?=
 =?utf-8?B?NTVyaTlENFVPUkh4eHl1M2hOeW8vbHZ1dW91UklDcHNKcFhyN2xUQnZKTkM1?=
 =?utf-8?B?amxXSGJJSjB2dUhOR3l1MGxuOEppbmd2TmNnNmRFQTBxdjVYeUMyL21BODhN?=
 =?utf-8?B?NC9hb1RoZEt5M085a3JsWHc2TnpUSHhKRnEvWUNoYVRrTFFKZnhlWmFIWHRu?=
 =?utf-8?B?QkhENStVNjNQL1ljeTUxRURjdmhRaTdiZEd1aS9vQmZJbWNYZ3NFTExiV0Fh?=
 =?utf-8?B?dU9GQjFKV0hwbkpXZmZLcEVRUjgzcHBTQ0F2ZDIyOElBaHZwYmJicmhBZllL?=
 =?utf-8?B?OTRvci9jK2F1eG9hTk56d01KQk90SWw2dkhETUM3RlpvU1ZmazJoQUVhNllt?=
 =?utf-8?B?M0V3Ui9wYWlxRVcrWG1HMmdPVXlFakdTRnZXdktCcjl5amZYUThFdG41TktF?=
 =?utf-8?B?ZjEwV05VZFN6OVhITFZyRFlQOTRwU0ErVVQ2OUVJTGhpb3ZublNLdmk0aFFD?=
 =?utf-8?B?OGFEZTNzVmFVZDlEZHRlL3Z1WllKVk1ZNlZRNEgvVk8rK1dIWWNSTkhndDdE?=
 =?utf-8?B?b2UxNEFIU0FSY1FPZ2cwTlgrbk1kMyt4a1N6YlRDTHo1bGZvZFZzaFoybEt6?=
 =?utf-8?B?RnMxSFdkVlU0MDBGUU9kbndnWUxBK0xYc0dzZDFpZThxOUNMUFU4bS92cjNU?=
 =?utf-8?B?QTM2V3owbTlra1kwbHE5UjgzdkNVbmdLMk13YjZqTUcwcXMxR2lZbFpvaVM2?=
 =?utf-8?B?ejhPdlhOUUo5eUpOQ01rbnYyYnNUTFU2ekNpaStMdzltbC9CK3A5ZG9NWkN3?=
 =?utf-8?B?NTJxYm9ueTV1dllhLzdrU2ZyZnlNT1NSOHJtTHR2TzRLdXhyWGtzazZIVDBQ?=
 =?utf-8?B?NytoR051WmlrOVNKc0lWdFUwVmJpQnNEeFhENXdnRDAwN3FNeHpUVkp0VDM0?=
 =?utf-8?B?MnNhdTdNamZIMjQxblF6T3RUcU5oaTFDNkYwNThKNmJNOCtnenhVWW1JMi9t?=
 =?utf-8?B?cGZCWGZHRzBPKzJDL2pxaTR2VVQ4QmM3bmxFbWZkQVZHbmtwQWtuUXQ3Lzhv?=
 =?utf-8?B?RnlReHd3Y3FvQXRyV1BndTZ4MGs0UnB6Z0hWQlAvQmRIYWRZMWN6OCs3Snp0?=
 =?utf-8?B?emowcFhBQWNDeEhCbDVyLzF3YS9rNGtkUmV4Yy8rcnJGeXlvZklyeGx5Lzl5?=
 =?utf-8?B?RER5eUpTUkZpTTdkdjJvSGswcjNvZ2lBV1FsMGlKZ1hTTVI3ZXZmbFZIK0NH?=
 =?utf-8?B?dFFVdU8rVnJtd3NJeXN1VGdTbEU4TVI3ZkJFYnM1b294VGV4bHh0UnlQeUwx?=
 =?utf-8?B?TlB4ZHIvZnkyZm8zMTNaUkhMMEE0R2FVTHo2d1c1Z3RWb3R5YUY1dDV6cDJN?=
 =?utf-8?B?d0MyQjNOR3BCVTAyTDEybnJCalkxQnNvQjJZd3JBVHNNdG1WVE51OGQyTkx3?=
 =?utf-8?B?ZVZUQnZIOFhwN1AwRnVJV2l6bERVbXd5N1c1RFhkcVFQOGFFbGtONUQ2OGlG?=
 =?utf-8?B?NFZDeUVjV20zWTBTeFF4SUhGVzBxM0JxV1NPaU5uUlFIVEdpVWF6dWphNjRw?=
 =?utf-8?B?ZVBKdlZ2UjJ6MW1HWE9CNy9NTTlUM0xRODdBcStLUlB1UXRQRGJGYnRuaVUr?=
 =?utf-8?B?eXZLdllzdjBoa05RQWhZazVLTHNOREl6TDR0SUVJUmxQcmtNSXU3ZklOQkNV?=
 =?utf-8?B?RjdobGFsaWE0OWJrS2k3dDl2Yk5RWURuazY5QXFXZHhkT2huTTZ5VFNXRDdS?=
 =?utf-8?Q?Q4CSyNWnmR79776ANnlL9LlrCCJzyZqL?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8711.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(13003099007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SVJEMjBHejhERGdRaklyYUhBaW1FNnFkbHRjdkx6ZWtraGdFb0JjaC93a2NN?=
 =?utf-8?B?SFhXU1gwQ0xNOXBGU241YUlPdWxQR0hnMHMwZ2RHYW1NdHRQeDZDSjllTmgx?=
 =?utf-8?B?OStvemxkTDNJRkNvd1ZIN1NQalVGZnRPenNNN3FEeFh4bzdDWWkxRVlTSmlR?=
 =?utf-8?B?ZVg0Rnc5ZkN6cUJTK2llQmowa09hT00vOEJXMGJ1eWkzNFBxMXJkb3ljUk5Y?=
 =?utf-8?B?OTJyYStQNDJVRFhmSEh0bEIwQmpGTGljUlRqRmsxd1A2WHdseHQ0R3FaTkFm?=
 =?utf-8?B?VnNNTXFlR1gvejZrWTFCUkxDWFB2U05QdEVUUGlKekNlL3d1a0VkNk5RM05F?=
 =?utf-8?B?U0tNYkZwN0pWNnFEUHhDVjZEeTJMTno3dWRTV0JWMjJlQnVtVVo3ZjB3RG1r?=
 =?utf-8?B?eFZ1ZXJPQjNHeXdoOGtIdGdPWDM0RGVjNzExdSsrUGVGR1NFWFlQLzMrNW0z?=
 =?utf-8?B?Z3o5TTZZZmxISDV2YThDQmNmc1pxNVpJM08xYktNb1E3NFVoNTZ4MFloS2FZ?=
 =?utf-8?B?c21qdWVSWW5yR2o0Mnl5UXd4VG01YytiaWZoVFUyWFJ4OXljdnBWU3FEc0Zk?=
 =?utf-8?B?a0ZQRmFPRWtUQXpUYXRFWk5zTnBLUVhHSVlyM2Jvem1CQ2dRYU5Ga2F3My9F?=
 =?utf-8?B?bUh5cDBIMFZqcUpQZkVOS29BMnVGSVNwUmU2azRzeEFtaFNhYmRmRHhtMVdF?=
 =?utf-8?B?M0k3S0RHNjJwQWpxcjBxQzZiZ0J3NVdTR2I5VGp1b3NWanFIL1JaRkhxNkJq?=
 =?utf-8?B?K05SL05pNlZXSjJJSmljQ2pWUzQ3VjJweHdlVElrRUVEWlgwRnRzOFgvdWxR?=
 =?utf-8?B?a0hrWE1qbnpWbWZkUEZsTjJ6NzZnemNBaEZJSitzWjEyR1BiWEkveUcwdHJV?=
 =?utf-8?B?RlJTc2FnOW1uamtBOGhNZk9BMUlneW42M3k2L0x2M28yQkU0em9GRnBBZC9R?=
 =?utf-8?B?cGlhdUtmNDVMSWg4alZ2bzQzY3JjMlRmMEF3Y1J6clNUWG91SGExcXIzS1Nw?=
 =?utf-8?B?ZGMrcE53WnhoOVlpK09KSkVBN1JTM3o4ZFNLY0JKc0lSRFRpTVlsUlYwQXUx?=
 =?utf-8?B?eDBxS214TWxYVEpRYVpzWHJqcmtyUVRQaXFhdVdJemJNd3BlZTc4ZkxzRGE5?=
 =?utf-8?B?KzQ3OTN6TXc1RUh4YUEzWHI1UVBaR25hQnVoeFFuR3hWV2ZOM1d5WXpOcnVn?=
 =?utf-8?B?UnkvdG8yb01NRzNqTGR1eVEremh3UCt2RENoZkY0UjRxZlpzeUswSThoeERK?=
 =?utf-8?B?T0k4S2lETW9IRG9xVHBmOU0wbnBRMHhHL2FiZHZncjJDaVgrdTZUZUNtdExx?=
 =?utf-8?B?RnpLVEJycFdZS2dpY2lXMlk4YW5GWTFZaGRCeTJPVFVQb0R1SUpFWldQUVlG?=
 =?utf-8?B?SnN3Nk16bWM1ekdWVlFtKzc4SGsyYSt5anZ3K0pCaU9lZjhTVVVDM1R4enRJ?=
 =?utf-8?B?U2lHNmZHQUpuSGgzbjMyUlVzdEtxNjF0ZWduOUR2K2MrdVJUSnltM3BvT2tD?=
 =?utf-8?B?c2x0Yktsb1Btc2xmbnlxUyt5M1BaM3BndE1XUnYrd1dINUtiOGRhWmxoMEtF?=
 =?utf-8?B?bGtSck1Wc2NlOHUzL3Bqb0krb0Q3SnBvcFgwcDdaN1VTNGdLQVhXTm1XUWZv?=
 =?utf-8?B?b25Kb0s5S1JJZUFya1lXNjVzQi9wK2QwTmZ6WEozT2pzOFU1Q3B5a1dkR3hj?=
 =?utf-8?B?bWkvVGxHa2V0ME5LcTFoV1kyTmFvbFd5WTdYOGUrcjNIY05oWHZIclZhWW11?=
 =?utf-8?B?bjJQTDlPTGd6YmdwaWxuOS9sUWZBaUVFd21BR0FEb0RHT1ZlUlZFMzYyYzVp?=
 =?utf-8?B?OHRZdjVkVzRJVm1UM1BVS29nMHpiTTdZbTAwellNUWlUb29rQXhMNnYydEt5?=
 =?utf-8?B?dmp6VTF2U2x2RENZbDNjNWxFREZyT3Zpa2pQVkhwL2VlTmtGdUdOWkt0cXR6?=
 =?utf-8?B?Q1JXNmhwRkYwZ2gyQ2ZWQUpMbDd6YnkyMmRCb2FpYU1iaFp6K2NKcHMzTEU4?=
 =?utf-8?B?WWZ3Rm9MZDh5VmZDUFhLUTE4S2x1c2owT2FGZ2lodms1S2VNRWpXSWpQa1VM?=
 =?utf-8?B?Z1FUVk5hZVJOc1NJdm1PRG05cUZwSzlKbW8zQXJSbGx2Um1Nd0I3TW9PTnZi?=
 =?utf-8?B?a1FhSEdRU2dwRDh2blE5SDZ4cDMrQXVrZmdJMDc2R1FiVVVOK2owbDV3ZVVm?=
 =?utf-8?B?akE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ec3WMuuFSL/xZoTHdOGv4TDdR6yBPQTdVBFby0lDS9c11HSumVU4BlmTRgFDZ2B6hprehVpUOXQCPpAKhMuVrCV9a6TeFqB6XTDK0vWDyHThVcz/B177nDD5DD7KYnNFqxF8tPSfff5tJS28ggJp7+xnJiUFfn0KJgBTNL/yw4ycSmEzzek5yyEgAbkfsFm3HugFKHWkS9fUwF4Yz63ihgirfzHnM3NP1whMWUnR16IGVwHxrYz64CdPm+XeVVAq5I/s3ITXYSAcnM5kRe4B0UEFUMLjm2cQ01qZ/B41zhvN6zaIMQptY0khDoMBlBg1dLHmrAv+FEio/pUdV/OZPl1nGDdtqbrS/SBp+7zZnvyjT8qVa/N6sWQ8FFUeRY56URIwhIdiy3CXQpL3Lq0gHfwzKpiucEp5zTjOmrTWuK3Zk1rz7dlZb2D7FvUM8dpsTYu3TocbcSFw/uVbe+Bn/6l0YJQ6/Gl4hf9SkguGeAQP4fBf9f6wMcbVCnIuudhHeHMEAVDygElJcQEVSXG4p4mac92T3kNUuRWxD6JaMyfCgifyGiarBuIqtkOHF6flvVdc7D2GhcAZzqu/EqJjEYld/4eRo6efDPAirDVFlzI=
X-OriginatorOrg: cathayholdings.com.tw
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8711.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1cc323-b1e8-4e0c-1aa0-08dd7cb948ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 07:35:38.8680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9a3c2dd5-a013-42f3-beb9-ee956e5222fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vcabcY4sa5FIzGOD2nLxC7ICmTpv+mefj1y3tIz3twFbpLYol8s59GLbMawxvt3i6h/HHd+d+TfwyYXpp6/aSpzGbL1RIJ88zscGutT2anBrCQlaVbX1oXj+gzfp7Oad
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
X-MAIL:365mse01.symphox.net 53G7ZjeU083840
X-SNFILTER: =?utf-8?B?6YeR5o6nRExQ?=
X-MSS: RELAYRELEASE@365mse01.symphox.net

SGkgZ2l0IHN1cHBvcnQsDQoNCldlIGhhdmUgcHJvYmxlbSDigJhjbG9uaW5nIHJlcG9zIGZyb20g
QXp1cmVEZXZPcHMgdmlhIFNvdXJjZVRyZWUgb3IgdmlhIGNvbW1hbmQgbGluZS7igJkNCldlIGd1
ZXNzIHRoaXMgaXMgYSBNaWNyb3NvZnQgaXNzdWUgYmVmb3JlLCBidXQgbGF0ZXIgd2UgZmluZCB0
aGF0IHRoaXMgaXNzdWUgY29tZXMgd2l0aCBzcGVjaWZpYyBnaXQgdmVyc2lvbi4gKE1pY3Jvc29m
dCBjYXNlOiAyNDEyMjQwMDQwMDAwNzcyKQ0KDQpEaWZmZXJlbnQgZ2l0IHZlcnNpb24gZ290IGRp
ZmZlcmVudCByZXN1bHQuDQoNCkdpdCBmb3IgV2luZG93cyB2Mi4zMC4yLXJjMC53aW5kb3dzLjEg
fiAyLjQzIC0tLT4gQ2xvbmUgc3VjY2Vzcw0KDQpHaXQgZm9yIFdpbmRvd3MgdjIuNDQuMC1yYzAu
d2luZG93cy4xIG9yIGFib3ZlIC0tLT4gQ2xvbmUgZmFpbGVkDQoNCg0KVG8gcHJldmVudCBnaXQg
dmVyc2lvbiAyLjMwLjJ+Mi40MyBmcm9tIHJlYWNoaW5nIEVPTCwgd2UgbmVlZCB0byBrbm93IGhv
dyB0byBzdWNjZXNzZnVsbHkgY2xvbmUgcmVwb3MgYWZ0ZXIgdXBncmFkaW5nIGdpdCB2ZXJzaW9u
IHRvIDIuNDQgb3IgYWJvdmUuDQpBbnkgc3VnZ2VzdGlvbiBpcyBhcHByZWNpYXRlLg0KDQpUaGUg
RXJyb3IgTWVzc2FnZToNCg0KLS0tLWNsb25lIGJ5IFNvdXJjZXRyZWUtLS0tDQpnaXQgLWMgZmls
dGVyLmxmcy5zbXVkZ2U9IC1jIGZpbHRlci5sZnMucmVxdWlyZWQ9ZmFsc2UgLWMgZGlmZi5tbmVt
b25pY3ByZWZpeD1mYWxzZSAtYyBjb3JlLnF1b3RlcGF0aD1mYWxzZSAtLW5vLW9wdGlvbmFsLWxv
Y2tzIGNsb25lIC0tYnJhbmNoIGRldmVsb3AgaHR0cHM6Ly9jZmhkZXZvcHNAZGV2LmF6dXJlLmNv
bS9jZmhkZXZvcHMvSVQtQ0Jvb2tpbmcvX2dpdC9jYXRoYXltZWV0aW5ncm9vbSAiXFxDRkhWRElG
U1ZJUFxDRkhfVkRJX1VzZXJEYXRhJFwwMDkwNDgxMy5DRkhET01cTXkgRG9jdW1lbnRzXGNhdGhh
eW1lZXRpbmdyb29tIg0KQ2xvbmluZyBpbnRvICdcXENGSFZESUZTVklQXENGSF9WRElfVXNlckRh
dGEkXDAwOTA0ODEzLkNGSERPTVxNeSBEb2N1bWVudHNcY2F0aGF5bWVldGluZ3Jvb20nLi4uDQpl
cnJvcjogUlBDIGZhaWxlZDsgY3VybCA1NiBPcGVuU1NMIFNTTF9yZWFkOiBTU0xfRVJST1JfU1lT
Q0FMTCwgZXJybm8gMCBDb21wbGV0ZWQgd2l0aCBlcnJvcnMsIHNlZSBhYm92ZS4NCg0KLS0tLWNs
b25lIGJ5IGNvbW1hbmQgbGluZSAtLS0tDQokIGdpdCBjbG9uZSBodHRwczovL2NmaGRldm9wc0Bk
ZXYuYXp1cmUuY29tL2NmaGRldm9wcy9JVC1Db250cmFjdC9fZ2l0L0lULUNvbnRyYWN0DQpDbG9u
aW5nIGludG8gJ0lULUNvbnRyYWN0Jy4uLg0KcmVtb3RlOiBBenVyZSBSZXBvcw0KcmVtb3RlOiBG
b3VuZCAxMCBvYmplY3RzIHRvIHNlbmQuICgyNSBtcykNCmVycm9yOiBSUEMgZmFpbGVkOyBjdXJs
IDU2IE9wZW5TU0wgU1NMX3JlYWQ6IFNTTF9FUlJPUl9TWVNDQUxMLCBlcnJubyAwIFVucGFja2lu
ZyBvYmplY3RzOiAxMDAlICgxMC8xMCksIDIuMTggR2lCIHwgNi4xMiBNaUIvcywgZG9uZS4NCg0K
DQpCZXN0IFJlZ2FyZHMsDQpLaXR0eSBDaGFuZyDlvLXnp4DnqY4NCuWci+azsOmHkeaOp+izh+io
iuiZlQ0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KDQoNCg0KDQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNCuacrOmA
muioiuWPiuWFtuaJgOaciemZhOS7tuaJgOWQq+S5i+izh+ioiuWdh+WxrOapn+Wvhu+8jOWDheS+
m+aMh+WumuS5i+aUtuS7tuS6uuS9v+eUqO+8jOacque2k+WvhOS7tuS6uuioseWPr+S4jeW+l+aP
remcsuOAgeikh+ijveaIluaVo+W4g+acrOmAmuioiuOAguiLpeaCqOS4pumdnuaMh+WumuS5i+aU
tuS7tuS6uu+8jOiri+WLv+S9v+eUqOOAgeS/neWtmOaIluaPremcsuacrOmAmuioiuS5i+S7u+S9
lemDqOS7ve+8jOS4puiri+WNs+mAmuefpeWvhOS7tuS6uuS4puWujOWFqOWIqumZpOacrOmAmuio
iuOAguacrOmAmuioiuWDheS+m+WPg+iAg++8jOS4lOS4jeaHieimlueCuuS7u+S9leimgee0hOOA
geimgee0hOS5i+W8leiqmOOAgeaIlue3oOe1kOWlkee0hOaIluS6pOaYk+S5i+eiuuiqjeaIluaJ
v+irvuOAguWvhOS7tuS6uuS4puS4jeS/neitieacrOmAmuioiuWFp+aJgOi8ieaVuOaTmuizh+aW
meaIluWFtuS7luizh+ioiuS5i+WujOaVtOaAp+WPiuato+eiuuaAp++8jOipsuetieizh+aWmeaI
luizh+ioiuS4puW+l+maqOaZguS4jee2k+mAmuefpeiAjOiuiuabtOOAguWPiOacrOmAmuioiuS5
i+ipleirluaIlumZs+i/sOS4jeeVtueEtuWPjeaYoOWci+azsOmHkeaOp+aIluWFtumXnOS/guS8
gealreS5i+aEj+imi+aIlueci+azleOAgue2sui3r+mAmuioiuWPr+iDveWQq+acieeXheavku+8
jOaUtuS7tuS6uuaHieiHquihjOeiuuiqjeacrOmDteS7tuaYr+WQpuWuieWFqO+8jOiLpeWboOat
pOmAoOaIkOaQjeWus++8jOWvhOS7tuS6uuaBleS4jeiyoOiyrOOAgg0KDQpUaGUgaW5mb3JtYXRp
b24gY29udGFpbmVkIGluIHRoaXMgY29tbXVuaWNhdGlvbiBhbmQgYXR0YWNobWVudCBpcyBjb25m
aWRlbnRpYWwgYW5kIGlzIGZvciB0aGUgdXNlIG9mIHRoZSBpbnRlbmRlZCByZWNpcGllbnQgb25s
eS4gQW55IGRpc2Nsb3N1cmUsIGNvcHlpbmcgb3IgZGlzdHJpYnV0aW9uIG9mIHRoaXMgY29tbXVu
aWNhdGlvbiB3aXRob3V0IHRoZSBzZW5kZXLigJlzIGNvbnNlbnQgaXMgc3RyaWN0bHkgcHJvaGli
aXRlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlm
eSB0aGUgc2VuZGVyIGFuZCBkZWxldGUgdGhpcyBjb21tdW5pY2F0aW9uIGVudGlyZWx5IHdpdGhv
dXQgdXNpbmcsIHJldGFpbmluZywgb3IgZGlzY2xvc2luZyBhbnkgb2YgaXRzIGNvbnRlbnRzLiBU
aGlzIGNvbW11bmljYXRpb24gaXMgZm9yIGluZm9ybWF0aW9uIHB1cnBvc2VzIG9ubHkgYW5kIHNo
YWxsIG5vdCBiZSBjb25zdHJ1ZWQgYXMgYW4gb2ZmZXIgb3Igc29saWNpdGF0aW9uIG9mIGFuIG9m
ZmVyIG9yIGFuIGFjY2VwdGFuY2Ugb3IgYSBjb25maXJtYXRpb24gb2YgYW55IGNvbnRyYWN0IG9y
IHRyYW5zYWN0aW9uLiBBbGwgZGF0YSBvciBvdGhlciBpbmZvcm1hdGlvbiBjb250YWluZWQgaGVy
ZWluIGFyZSBub3Qgd2FycmFudGVkIHRvIGJlIGNvbXBsZXRlIGFuZCBhY2N1cmF0ZSBhbmQgYXJl
IHN1YmplY3QgdG8gY2hhbmdlIHdpdGhvdXQgbm90aWNlLiBBbnkgY29tbWVudHMgb3Igc3RhdGVt
ZW50cyBtYWRlIGhlcmVpbiBkbyBub3QgbmVjZXNzYXJpbHkgcmVmbGVjdCB0aG9zZSBvZiBDYXRo
YXkgRmluYW5jaWFsIEhvbGRpbmcgQ29tcGFueSBvciBhbnkgb2YgaXRzIGFmZmlsaWF0ZXMuIElu
dGVybmV0IGNvbW11bmljYXRpb25zIGNhbm5vdCBiZSBndWFyYW50ZWVkIHRvIGJlIHZpcnVzLWZy
ZWUuIFRoZSByZWNpcGllbnQgaXMgcmVzcG9uc2libGUgZm9yIGVuc3VyaW5nIHRoYXQgdGhpcyBj
b21tdW5pY2F0aW9uIGlzIHZpcnVzIGZyZWUgYW5kIHRoZSBzZW5kZXIgYWNjZXB0cyBubyBsaWFi
aWxpdHkgZm9yIGFueSBkYW1hZ2VzIGNhdXNlZCBieSB2aXJ1cyB0cmFuc21pdHRlZCBieSB0aGlz
IGNvbW11bmljYXRpb24uDQo=
