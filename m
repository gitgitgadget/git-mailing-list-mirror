Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020116.outbound.protection.outlook.com [52.101.189.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906758F6E
	for <git@vger.kernel.org>; Thu, 15 May 2025 17:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747330254; cv=fail; b=TdcDMjt53hZIKbBGNsZYzNvpLqNS3pikz8l4YGZHq1DX4BWMaLk/yGUGho02e1U++D+vaTT+p4Ki2cqvI8U09GDxLLGLPnb0Gb3cWqXP4TS49VAEj/x1i9jvFScYbPUWePJgJ0UYNjEUQ1du24EhDKbpNLwOrwLZ5YfdGRVZ2r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747330254; c=relaxed/simple;
	bh=sfMN7aQ9kbI52+YBcE0WUF8wqp5qtl1lSPPWqToT2Xo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MzgC1rE3uCdQPUiNaKWPbXS8qoOkMlfjcs97IPMEQ1JXHXLhjtCzjozIHY3SdoRE79P2o24EYYygehI0ydE6X+HxYZbu9f862UwLslEI3B5RBdaCn6ntHnSykuYvxwYU1PBUOJqTna2wq3D4BykMK5Z9VVgE821Vu1pA24mTG88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=py3YNsAl; arc=fail smtp.client-ip=52.101.189.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="py3YNsAl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNhYMJ/+ix5NMeVCQAvgTRd0J6RtsAxtoWTdsqQTSqrl5EcK1phjMwXHXjfxhV1uO+BnaozHH2QOZ4a9sn3AUGwZwOJm1hHQFb9m5IJTV4/Th2Jti/i5wHOPVSvm9k2V0sQYcOoP7foXLllqNmb5aGQ29o6GP7nKJoZbjR6X3Vam8RvCowMs/9RP5p061enafAnMH02vWi8n6Qn+Ltaab+OWP/A0DiKC4enqH0iXyAfTgDwL+3w6r3JUgEogzk/+Ga8G1uLIWf9ETXMEgnBqH+Y4DTn4NYxO6Wx592P1emarhbpHs4fsPF15rwMaimJlGDY61TX/b66MO62VFXlrJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j8YBwULVHGK2MgpbUBXCquQq1EKb2GBdnBZzrSYOkA=;
 b=QNpw3adOF+FkwaZuneIz9fl1trrbMDFXbYjef1XmmGwtFi03XpkXpnfVtLuWB6M3E5GbMwpIKjz7Xs/7UFZnMAbFV0ht1D7n33RdoPONIUz3xyaRKzmaCgEjCDyWot2QybVyoEZkSYI/tD/ixvrNkaEb0omdVgF2u2g+lZRp1zahnckipKgTckuVOP+HUxu6zGXTRuMB/vNb+5CvXYNtnr7S2VvSdRiNmLOcd/j8BHMcWtTLcwvJpB7lROPkEpYAPzWb5tKLKuAOBZQUA4wWTIoRFawVcmnp0OkPoJROWCimNNJmRu5lKazDeLgNVcil0esz8gmVPlTk5zAj1Dl90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j8YBwULVHGK2MgpbUBXCquQq1EKb2GBdnBZzrSYOkA=;
 b=py3YNsAlC2tbC2ggKJTmMGhpPfAYEKHaxjk1Ru5aG4tsGyyUpF9iBrd88QraMPIpEjvZ808YFE3zEfAF9s3w69EWK8dije+FnseHzx+L2sTFIn75Q1FuwSb+jxYH2AXIhKt1eT1dOjlz22JkhBMn4S+m/qMYtcAYp81RIXHMF2xgfB7bfQb+ldtwnMtjhqQdhQII6HjqyT5DKcFmZW5Epz7C/nzaLaAUFhGTDeUUSinvHtjQj0pN4zYWz9ceKqQjGT3ru1OV90zP89KC0khJ3kJxak+rbtiDeEMIPsw2rpCBE9sxo9KetBdz6aljWzwpiv/9fi9UJnIEVLZvmF15xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT1PR01MB8907.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 17:30:49 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%2]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 17:30:48 +0000
Message-ID: <f01e1e88-c161-43ba-9845-4fc7c9f85d0e@xiplink.com>
Date: Thu, 15 May 2025 13:30:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Toon Claes <toon@iotcl.com>,
 git@vger.kernel.org, Jeff King <peff@peff.net>, Taylor Blau
 <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com>
 <87ecx0ijqt.fsf@iotcl.com> <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
 <xmqqjz6sb15u.fsf@gitster.g>
 <7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
 <xmqqldr789gr.fsf@gitster.g>
 <9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com> <874ixnjltf.fsf@iotcl.com>
 <xmqqy0uz7zzh.fsf@gitster.g>
 <0f491261-bbe1-474d-a240-0ddbf22cc754@xiplink.com> <aCXsKHiP4uIzCMrt@pks.im>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <aCXsKHiP4uIzCMrt@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::10) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT1PR01MB8907:EE_
X-MS-Office365-Filtering-Correlation-Id: db4b3636-9f06-4dd0-3531-08dd93d63b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjdmWklCL1MrK1RxanV6aklXcVZTRHo3ODgrTmFiWmo2c3FJK3hEVUNMUTBt?=
 =?utf-8?B?Z3hBNkloNTVJWktPZHJVellncTN4RFNMS1FTbk1uY1h0V1Q0ZUsvZWw4aGxv?=
 =?utf-8?B?ZnhLVmVqL01XRjRRcVFMWnd4ckhyaDNhUWRJanAwVlNtR1dBVzZsd3gyZjlH?=
 =?utf-8?B?YTVaV2tsblA4MDhkbmVKZTFSbGtMR3pJdzVqZ0JHK1BnZVgwMUY5SVJCRmxD?=
 =?utf-8?B?cTVucWFZamlldExhdThPaU1MQlJ4YjFsVXBOV3ZjV3VraHhpanRXYVBYWEox?=
 =?utf-8?B?MlFkL052UDNrSGxLb29QdElwNHlHN0t0aEp6UmNlNkFXTDdzZ3ZMSjNRQUFM?=
 =?utf-8?B?c2tMNklKdWRvWVd4cEY0dTBDSTNNbmMwdVZKOFRIcnNvSEJ0YUx0ZTJDUzBH?=
 =?utf-8?B?QlRPK2lhTG1hT2dkenU5NjRJaWtoeFNTZ2d2SFFtYWhZM0FZRkhIUHlsN3ZD?=
 =?utf-8?B?bUxBa09aYU5FcmgrYWFDenFIK3FQaG0vWVh5MWlFcXdmai9kZkZVRkJkNkhD?=
 =?utf-8?B?V3o5WjBXOXJ3WG1CVUxZWEdNdjZFb3NSOHN6endHaWQzNW93NEc2OThxSUdB?=
 =?utf-8?B?V3BEbDUxWndPZWI3RDk0eUlvT2tKcDFzSEpyeGVtT3NhQjNicWtIUGtVTE1P?=
 =?utf-8?B?eHhCUEtGVzBPMGg1TjJsczNsdG5wazYvcXNCREg1RjNyNWRBK1AxTUtLMURh?=
 =?utf-8?B?QTdrQjN3NmhhWGJZbzB5eUN0dmxNSHN3SDRITFdnM1RuS3U1RXN3cTNGNWJz?=
 =?utf-8?B?OUVvcVJZQTNmdnJLUXhYQkRnS2wzN1FRMWZvZ3dPT2dSVUt3dVZ1enFuOUQ4?=
 =?utf-8?B?QTFPK1pYL05lM0g2dTRVYXVjVkRMQVVHQk55UnRFWGpacFJtKzFidjFuRW16?=
 =?utf-8?B?azB0MlNBcHZaQU5GU25xNnV0TUlJUVFPSXQxSWpJWmNjMFl6b1JsOE9qdWh3?=
 =?utf-8?B?dGFZSitmYUFXRDI5dUQ4bkVteGMzRzN2bjg3QW1rK1ZSOEp1MGlKcFphYjUv?=
 =?utf-8?B?S0VYcExGeHlZUFBvL0tSaGJmb0J2RW5JUVpOMDZuaDhPdHd5bCtSZ3JwVWpJ?=
 =?utf-8?B?cFpRQXh0dnl4L2ovRzBTRElDcExreitrcFhDNjJNamJXL1VmYjhmM051U1Ft?=
 =?utf-8?B?ejFXanA5TDZsSk5KOUc0WEdIR1Y4aGhXOUppN1ByNGdSU3AyM0E2OXVTZE1L?=
 =?utf-8?B?b3NJM1VJSWxjMHYyTkpXVmtZQTM2UHQ1cFF4Rm9Yd3lvdmR6dVJqSlJ2VGd1?=
 =?utf-8?B?dW9kR2c4TkRrbEdyQnFMcTN6djIxa2ZPbnVCbUs1eG44Q2lZYUtGREFBUlFm?=
 =?utf-8?B?TDZPdGEvNXgrTVBhVGYrdWg4MXJUNmRqOVp1YXdieFZIU0JoeU96T0F5YW04?=
 =?utf-8?B?ZUp2clEweC9OOURtS2JKOVBzQm1qVXBpUDRKMFJiaVA1TnYrWmdWbWJYMUo2?=
 =?utf-8?B?SDNOSUhBK3BCM29jMFdLODZ5Z25lNXB4aUVpQUl2d0pZb29UdHNvTDRGQkNv?=
 =?utf-8?B?bHhFd3kreWhFeG9xVG4vaElma29OMDVraW80dUZkSVd4dU45ZkFVNXpJMG9h?=
 =?utf-8?B?WjVEOEYwTE1id1Jqald6QzluSm9XUTVFdlB4MjRrYXREVzdUaENwVXBjSjVy?=
 =?utf-8?B?alEwb2NrTmpzdll1VGlqOXk3VG9KWEVuVCsweTV2VkRtSDVsd3ZPMkxYUXo2?=
 =?utf-8?B?ZjRMK3lFUE94M2Z0cjlnZnNRSlNscjNSenRHcWFqcW9qL2d2WkNzNDlTU09D?=
 =?utf-8?B?TzVFdHIxOU1iSGhRdUpsSkVZb04vUnV1OVVrTlhYRGM4Q2pRbGN3S254T3Za?=
 =?utf-8?B?Tk5RbFRSMXJTRW9mbFlkN0RITDk1c21CY2J5Q2FXdGY2cUNtMFZTUEt4Tmhn?=
 =?utf-8?B?VC9HV2Y2REkxUmhFU1FvcS9qYmNsbGxydG5wVVNoUmRtRFJhOHVxK0FGSFlx?=
 =?utf-8?Q?ZScvKPwwuQk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1ZjdkxlNEpJOGsrYTQ4ZndvVGhjM0pZL1RQU29yMWhVVGpXMllZWHVTZlFR?=
 =?utf-8?B?ZVA3YS84WDNUQzRiekxkVDFqOWcrMTVWd0lpcS9IbEdyZktJNHc4S3BQU0ln?=
 =?utf-8?B?WXdyWXBUWmN0V3RJZldtZkNjRXBXdFJvNERzVXVMNmJZSzFsTDhOOTNIMzJa?=
 =?utf-8?B?cUR5TGR5VjV4ZTh2WTBCVGMxRnkxYTEzVzg5K2JTTXJwUTBOVVU3NitFcVUz?=
 =?utf-8?B?cnhYRG1tdEp5bGdCSmdLNnlvcHcxK1JtVDVuc3NjMm5Dc3hreUVhcjA0a21s?=
 =?utf-8?B?b29ZWjZ3anBNRTAwS1dWRzFnTTNCR1BFQjZYSXd2Rjl2L0JpclBkQThYWHh5?=
 =?utf-8?B?UEEyTUlLWm8waktLTVl1QmFWa3ZwZXV4cEFleW9rMHlDT3ducjBhUksyZ2sw?=
 =?utf-8?B?Ris2WEdNS3h4QU1ndUlkWWlWdkZTR3IvUnlTQ3VGRHhYQU8xL3VKY2N3aU5q?=
 =?utf-8?B?KzJnc2dML0QwN0RKNEdpY2grQVJFMUswTGVidlNpUnZLRnZzTkNpY0dyR2lN?=
 =?utf-8?B?QjRhVTFPckU3UTE0TFkvMkptSXhLLzFZa1dwSVZNdzBjY251YjVNTU84Q2VI?=
 =?utf-8?B?K2RUaE0zVXNJeDJpcmhEcnM3dEJGazVNcWRkMngzeXU0V2VJeWozSTB2bCtw?=
 =?utf-8?B?L0RtZ2c5WW1zME1KMlUreFZIUTZ6djBpZ2JkYVVVRDJ6UDAxelFSd1U4V3dQ?=
 =?utf-8?B?QTlEUjgyMEtGNHFRYlNKSXk4SEJTRE9QZEhtODRXWUx0bGN2aHgybkRNbXR3?=
 =?utf-8?B?WXpHY2pIcm52U2h3MVlyVi9sNERuZ2FyVndDT3JKUjdERDZjSVNnaXkxUHlz?=
 =?utf-8?B?ZVVzckJYZERBSHJsUDBTVXFRTUdTR3g0cmphRFFoWmJPUVBFOTlLRnJ6K05x?=
 =?utf-8?B?cVd4YUFFQWNqUE5tYjVseUdrTzEvOVdabnNOY2lMS0czWWxIbGpneFpMSHRa?=
 =?utf-8?B?V2Z5MEVsUGFxMU5jS29XT0F4S0pKbXY0ci8rMXN2YVdyRkt5amVVenQ3cW9S?=
 =?utf-8?B?a1U3ZWdqZUZ3MVQzSUZGa0RYQkRaSXBvUExocGZUYlVuaFV5d3JKNDkrNGpR?=
 =?utf-8?B?RUJabWJpd0w0WHZ6VnA3QVlDd1pMdXBrOFMzVWVEa3JwRy9ZcGFJb3V1YjJV?=
 =?utf-8?B?SFhHTit6S3NlcWNndGlhdXowVWZCY29TelFZTkRDU1RUeG1adGxqa2NGM05Q?=
 =?utf-8?B?RldyajZ2VHVRNSsrYnBDOVRBNVZOeU1DdDVNQ3N1Z1N3MFNpbTM1ay9QaVAw?=
 =?utf-8?B?VUZBeTFsd3ZLd1RnTkJkY09ycldJaGo3bGR6UnMrak50SmJsaWUwUFFFYXBy?=
 =?utf-8?B?Q1hPTUdrK1gzcklxL3VhRWdLa01tN2tHa2tjNG5yYzEvcjhVeUZ3VDlEK2kx?=
 =?utf-8?B?eWRmYnJiSGVhdlpKdTBSV010aWdwanNtcjJZV3ZEakxiN29uOTNkMjdwTzlT?=
 =?utf-8?B?NWxzN1FVOVVZbE1VbVBNejhXM01HQzJ3SEE1RjNwVitoWEpXUWVGcENOeG4y?=
 =?utf-8?B?anBBczhPTk13UngyZzNTWWZySUJuamY4ZGdTWTBxVU9KWGxCWVRwaDVxazBv?=
 =?utf-8?B?Q2FIOUV6Q05LZi9idFZQYm5NY1FWcDNiUEVicEFoUkNWck00THpsV2JUR250?=
 =?utf-8?B?KzVBM3VOSDB2RzdxZ1Z6N2REM1VDSjlqQTFWc1p2Z0o1VmRJMjJWU3JIVytj?=
 =?utf-8?B?MUpmWnp6ZERMRWhhR1QxMEdNU0ZXdmtWWFJXTmRNQ1ZQSTlpSnI5Q0Y2Z2Rm?=
 =?utf-8?B?UVhteUF6YmJTakErZG5XVXRuaW9qSjF1OEs2eG9iWVdYTXU1WW1rM0MvaUdm?=
 =?utf-8?B?WFB0dDlteFRIM2FMUHJCOVlmYTJXdEJvQUN3cGY4UGxBY2JEV2NUd1RnMFpp?=
 =?utf-8?B?cit5dDJYVHhsUjlBZDVQRW5RQUQzTzR0dDFpTldRNTZnS2preGNyWUxxdzRD?=
 =?utf-8?B?SEpVNFVISGZZbCtzUzFnV21WV1ZUb2VoTGN1Q2t2bDVyWWZzV0N5UWVnU052?=
 =?utf-8?B?NmQwRWtuaExLcXA4ZkRmOFJ3eDZFMUloMHpuek5jRFRpSG9JUndlbSs5bEFV?=
 =?utf-8?B?SG50SUFZNXQ4cURvL0JPcnBsT0RTSllZR3hqdz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db4b3636-9f06-4dd0-3531-08dd93d63b4d
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:30:48.6483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdlDea2zlY7KAMRf4yXsu5sMBmTQCkpCFnbAYqill8KoyWGg0LQyG3ddcnYCW7McO/oi9eIQuvDaKQ6JyOrlOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB8907



On 2025-05-15 09:29, Patrick Steinhardt wrote:
> On Wed, May 14, 2025 at 05:15:30PM -0400, Marc Branchaud wrote:
>> On 2025-05-14 15:29, Junio C Hamano wrote:
>>> Having said that, I personally do not think of what "blame-tree"
>>> does as "blame" at all, and there should be a better name for that
>>> operation that does not use "blame" or "annotate".  So a separate
>>> command that does not even hint it has any relationship with "blame"
>>> (because it doesn't; in my mental model, it does not do any "blame"
>>> at all---it just does "git log -1 path" for many paths in parallel)
>>> would be even more preferrable.
> 
> Curious. Isn't it exactly the same what git-blame(1) does though? Taken
> the textual representation of a tree object, we figure out when each of
> the lines has last been changed. That to me sounds like exactly the same
> thing as git-blame(1), but just for trees instead of for blobs.
> 
> Sure, git-blame-tree(1) goes further than that. But conceptually it is
> exactly the above thing, isn't it?

I think the operation can be perceived in different ways.  My only point 
is that if we do conclude that it is a form of blaming then we fold it 
into "git blame" instead of a new command.

>> I'd also be happy if instead this came in as a new command without "blame"
>> in its name.
>>
>> How about [[consults thesaurus ...]] "git ascribe-tree"?
>>
>> Or maybe fold it into ls-tree, e.g. "git ls-tree --ascribe"?
> 
> I think anything that needs a thesaurus to come up with probably isn't a
> good name for non-native speakers. I personally had to look up what this
> word means.

Yeah, that was a bit tongue-in-cheek, sorry.

(Honestly, "ascribe" would be really bad, precisely because it is a 
synonym of "blame"...)

		M.

