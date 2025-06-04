Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764F24A061
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749041770; cv=fail; b=fAIA9BzfZ2fVcYJMCJjZ1Zje5mG0t/NMb1DjefGyWaERtzHd/ywwvhtyBAXhZpOihsb0s/JNcHszJ220izLAtWwrNUcx5A4MeMSEvQnleeCs0hAHE76eB51nCSqrE+RnZL7pe2ZQTL1f2qPORhHpJFfT0tKhokkA8G8VXxbk0tY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749041770; c=relaxed/simple;
	bh=sJPskM9yxAsMs2Ek4oqVYeCjNdIH17rP0YkDXQxLSEM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CI/xLrHudsflO84+tHUeb5MjCStSbY+sNx/h43Jf91mb9Eoa+xQ+GhPgPWIhjd6zbOAB4KYLW4wLL45rhD0W05aDQyNRSVUOoae2ncazFy0MhQlkVC2KLHcn+cTZHTTdd20iSatIZz82XWqpcLcQjKc/ETShBQrPjcLrpNA1QRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ELjWNyxv; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ELjWNyxv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnO9u9r+aEF610oIUQMRp5/JbnsK8FkTgJV3GlLor60/ip8PCSBBU9rX3fDZwa5D1Z0LZ1WA7SeKuXtqyV8WtyBXlbP54aAdvhZ6DWPdYwRx72VfyL86GwsUKCF5ziwS1EcxmA3hJkgbmZRdFpYeBbH2dvxkYPziRDMSzpM/cd9lRoYoyQM1NGmtArqV4vPR4eSmg3gDUEychaDLB360hUhng61s/EKzQ+svsCmvf+HqudpnTE8ySuBm5iZKKi4B222JGDtWyhtIfisbL0/8Aby1jNL8Nzm5YvHzNAkBOmL0vgINf5f93U9gTDWaBMD37lLR3C5x44lrirKrwllRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/3cIX0PkdS8qDoBxsvMQTWxVsu1iNr99pGV67Icv2Q=;
 b=QCVqsLTXu8G05qsDz/zLh7hfYZwla3kUv7cRzOoOM4wPtJrKvD/iYqVo5/PhmCSShlaVTRAyFpSZYq8RAOjTCrTgkBgH8dvAZ/ZqC//uF3kj2J2N6pwSesc1OOSdM203cLo2vopx5QiipGeZx6zEOxoobv7Gt/wxn1SVgJpj0rgzsi3pIY/I+TwtBunCh2lf4zDMTMTDqxS3ABSaJoTxBxDvbRtEN+Qj2YV0+l1QjJFpaDlfie4S4ebL1lDtmlxV+APtGRRI3qL5pgYm2S/iiBwljJpBlNoK+UdWYKgPmZQVwX/haqenTqNv35NS+Di8h88IC/H1nFk5Rfivd6rr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/3cIX0PkdS8qDoBxsvMQTWxVsu1iNr99pGV67Icv2Q=;
 b=ELjWNyxvX4llZBxoifiAemD7x9BQysdAZ4y+gdtFYS48HI1i44uuRx0/IBGD11YIpwFBnV6vFhk8jzhfB3uhPctHjt/zkDbTVFx/iuY2KQmjcl14KQpnmrxM9zjaW3xkeuv+oghKGcutFZppOKdieJkEmX+u1QbFw618mWhqkNOazDLc2/2Qx5IPH0aiYI/5qY2S0U66kpQb3LVo4cnTiwgV31Vzh26fAINhmjV+azEA7/xzgTVattW/SGy+zhcWbIo5i9W8UzEddfLSG1kTf4W6XWAUp6YKa9cREKb6dyNxU5zF4Lr0oeecHrrBfLbGxkMiyRxV0RoVeKwMUZYhZQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PPFC2BBD9DFD.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a04::a8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Wed, 4 Jun
 2025 12:56:02 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.018; Wed, 4 Jun 2025
 12:56:02 +0000
Message-ID:
 <PN3PR01MB95978CC57C19CD03B67EB782B86CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 4 Jun 2025 18:25:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] send-email: show the new message id assigned by
 outlook in the logs
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>, Jeff King <peff@peff.net>,
 Jacob Keller <jacob.e.keller@intel.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <cover.1748529954.git.gargaditya08@live.com>
 <caf46596a709df7205495b75da569baef2c7c9a2.1748529954.git.gargaditya08@live.com>
 <xmqq5xhjmmno.fsf@gitster.g>
 <PN0PR01MB9588AF2A370D8A1F50745C97B866A@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <xmqq8qm7g00q.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqq8qm7g00q.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0121.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <7823bea9-e94e-44c0-b682-32daffd773d3@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA1PPFC2BBD9DFD:EE_
X-MS-Office365-Filtering-Correlation-Id: 63381953-d18a-4d2f-47a6-08dda3672900
X-MS-Exchange-SLBlob-MailProps:
	KW6s2gPZH1cExVdjXhOoRdEbNE4IE0VVV1RSohrYoBGkB7CfXCEwEY1FSyUmjTaGkuobBZZgeFDB8EjcLb2nPeaCOsfuM1WbMwww5d5uEq/bSjJNMs7mGBLeEAA3ayqsoKWqjnVnPjVbESbAsc7zZMAmmVOb9duYekpMD6FDt48OIQeP8qUhaZlDnjsWWsHspo6DJBz50RrELHLKWE9LGHSdMqpxXa0JwkP1aNN7zqdamjoDLBBtQ+JQWcss3hQqE8CaMh4M+CRyHdxbOBg02E0PbK5VCN4frBu7UVqXEDvELIHHWD57BSeOMy1EvGpoxcNwi0dt2FfE/k/CTAWYc9Z1g4R63GZutkRuumEKyajw3r7shcAklvYFkq04bQzT/UQxtQi3qGGUKbb0vhwJanLuL+P6m9XbI1eh7YYM8ZGGUa7eGbOmDQtDG9JGuVuedamLMTo3s1EMHi/p9iECQQH9DU12omPCiyzI4at5q8CG1IAn8u1RUMW6JsI3VMPSQwB5HtQGVUSLaKYL6ml7n7o5DWiWspsdzHlE1FOYuz6/Uba8EjAhiDyMqREbYE0V+NRNd02zz3XvUNlSudCIg4mT+MuDX4Q1xo6vWG75kdPbTQ93XxuyloAcMl8WwTS82mT1abifR4oxbOocHshWClxjlFI45sOldSMc7sxPrErM65yvkbZREhK1ZucWia3cp5mL41nk/SuGHcAdbutwl+6+Tsi8MaKQl+R5KxQfAxw=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|6090799003|19110799006|15080799009|8060799009|7092599006|19061999003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXkraGQrVzJOT2U2eEFHUzVTdlA4bnIzMEpYM3lpSEhLWFZaN043R1N2TjVy?=
 =?utf-8?B?cTV3RUxXZ3lOTlZxMjRPYldacTJOMC9yQUQvNW5jYWVuV0NwWXpGR2NnWUNS?=
 =?utf-8?B?cGdSbjE3OGhoSGJhdEFzSGFXRkcxVVo3Wk5zdEdVc3BEY0ZzZ1Y2b2o2N3JD?=
 =?utf-8?B?UUNuL3RkUmRETFlpYVF5ZUJpY3VRRWo2YldmVDlreVRFN0VRVG1uZVpTamx6?=
 =?utf-8?B?a3dIRjJUdjdZUlJVWEdLRm1GMG9JNWRjZmFzNnBWRTFhcFFNWUVjR2xpT3dy?=
 =?utf-8?B?dTBFL3BDVThxMjhld2c4bW5scXZ2d0ZFMmZkZ0JlSnViYURlaXN2U2FTZElH?=
 =?utf-8?B?bHBhK1JENEQvb2FITDVQTTZNc3RJMEx3b1A1c1lWRG14bUtxMWR1OWJNTDB0?=
 =?utf-8?B?Vm9vRnJLWm9BVWNjU3gvSkwxSzM4U3ZnNThRajdPNDkvT2Z6eUdDZW1EalJy?=
 =?utf-8?B?c1I3T2tWR0ZjSllMbXhQcHN2c2wycEh2c1VSTDJzalY5U0ZLSDY1ZFJGWHNQ?=
 =?utf-8?B?T2tmeE9RQk1GRk9CdElEVlRwZWVDQlZsUzhOOUJGTldWdG1iNkhTTG5XQTh1?=
 =?utf-8?B?S3U3L2FMWGNvKy9lcHZpZCtjVUhuWDh0Tmc3N0YzQVB2Z3k5UHpTYWc2RGZi?=
 =?utf-8?B?N3psVFFSaVdVNFF4L3JqTVRyNXptYlY5UW15dUtoeStYem9HTklsWlhiVzcz?=
 =?utf-8?B?SE5sV05hYzl0U1RySVgwdit4QVhDbkdWRUtJWm8yWDFnNGMwVXRKRFVUSlRs?=
 =?utf-8?B?UFZ6NkRVRy9UZG8zelM1UjhpUm1abmVDekVUNm9TZTB0NUY2c2R6SU1DSGd1?=
 =?utf-8?B?Q2RYaVRvRU5hOG4ydExUcmRwZ2VVT3M3b0RSNU9hWGVRTk14ei9rOGdQRExW?=
 =?utf-8?B?cWsyeDFqTXFIcEV3WlhDaUcyTmxReWQ0b21DWENmbHJJWlh4Rm95a01TWnE5?=
 =?utf-8?B?cEJVVUE1VU5HL0QxcE9sY3NPVVpKOFA2VnBSckJVQWZ3QW9laURkdHN2RVJl?=
 =?utf-8?B?a29nSDJmVDJSSklzalZBQ0pvVmJmd0d2NHJucDNqZEtvVXBJSzkvdkVvbGgv?=
 =?utf-8?B?Mjg1SHdnRUlVY2g3MlBpb0Qwenl3WlN4QUFtR1l0b0dDU0FKOTY5ODhLbnIy?=
 =?utf-8?B?MTBuaXUvZXdjQjM5ZmJMMkd4MDhTZVJNQkd2V2t2bU52SEt4QXRQeldTZ1Qr?=
 =?utf-8?B?ZUl2QzVXZS80U0pwc3dVOGJoMnk0YXNBNFkwZkFseW9MOGEzNEFLT0JUdFlL?=
 =?utf-8?B?SGluVVlyc3I1ejREQ3RMbXlXQ3RZL1JMUlR0WGZOWkJGVjhuM3hxR2pyOXlD?=
 =?utf-8?B?dm1GSnljOUEwM1FoZVRpbU1VVEZpRkt3NTZPL281anFjbkNVRTAvSWJ5R2tW?=
 =?utf-8?B?M0QrbkhJbjB4QUl6R0F3OFlNYmlhUUtDYStaUVlnWFJ0UGV6aTVmTUFaMGZl?=
 =?utf-8?B?UkhzbE1qdHlDUFFZNFAzQm1zT2NGWkZVbksreWZJbGVtUGx0c1ZtOURDMCt5?=
 =?utf-8?B?TjBTcExiaGk0N0ZoMGVoK0YvQitXSzExQTdwV3p0a3ZHY3YxWW5TL25HVHkv?=
 =?utf-8?Q?n1fMZUGVgVXOqKsGU1pVz3FKv8Pew0ojSHMI0IndN83N+I?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUJNZnNRSmVWeW55U0UzY2lxalZUbTBoQktISGFjODJFSWhqRkhta2I1RXpT?=
 =?utf-8?B?MGJaN0pUVkl3TEJyNlpaNTZOVzIya0lobjlDeU5CVnVJeVVaZ2k0ZC8za0kv?=
 =?utf-8?B?bGlrY09qUGlHaVFpekVCa0lnSCtJbElRa3FiYjVJSmZiWWZHRFFzZE56dCtG?=
 =?utf-8?B?RXBkYkx6dDI1N1N3d1BtRDVydUdkOU1mQVVFTURqRE1uL3YvOVgrNWZhcjdJ?=
 =?utf-8?B?eE5uVWhFa0dTNGpNcFBNc2FyNHMxNldndDB0NG9IS1B6cFppazJVV2x5VHV3?=
 =?utf-8?B?dE1ZdlhDVmVzaE0xRFJLK1BHVWRYdWJ6WENiSlJ0VEMvTlJNZHF0Z01HOFBz?=
 =?utf-8?B?THhXZy9jSEU5SWRlTWQwWm9MbE9pVm9DYTBDc3RoQXFIWGF1MVVyNjBXTk1S?=
 =?utf-8?B?Tk51OGdReHZDYjZPOUczSDdIcjVWZTFFT1BQOGJKUzVWditQQlNxcGRySC84?=
 =?utf-8?B?MDl2enUrdVhTRE1RZGhzY01LdGVxRU5uTVRZN2hYMGhxNXVuMDdUMzZvUWVx?=
 =?utf-8?B?Rm1qV1BTdzl2TkdWdS9NOThyK3BjMEdraUFaZ0VUc3hOL2Y3MUliamtXOTlz?=
 =?utf-8?B?TTRWWWNCZXd5dm1HZHYvVG5MenBjcDdIeDFScVVmSEphbUdyTit0eWRkTDdu?=
 =?utf-8?B?NkdFNGhlZmFhb2hmSnltdTNkRXBxQWNFQlFXRDFaY0tDdmE3SDlodDFRajl3?=
 =?utf-8?B?QTQ0eWdPdmdCV0dBdkpFL2xUUWgxRzAwOTdHU2c0TzdzaEJxR21yU2JlaWh4?=
 =?utf-8?B?UE5RN2lHUCtqTW13Wlg0a1Uya3Bab1M4am9iT1lBaUtjdCtBdldnWEdiL0Nz?=
 =?utf-8?B?VXM0UW1JaysxRXFDcHd4bzJsSm54aGR3L3IyRmVMK0FqZE8reTV1T210UDdE?=
 =?utf-8?B?dDlJbXdGZTRaUkhKWU01N3VnWWE1eXM4V3JFVFIybTZjOWhkRWFEOU5sS0sv?=
 =?utf-8?B?SlZ3MTNCYmd0OWN6dTB0UEtKampFQzBGY0FCUmdTN280UjVCc2NKRXhWbXB5?=
 =?utf-8?B?N0RKNnN1L1ZxdnJwcHJ2RWJ1Um00SjhML1QvL1ZBcjF5R2hHd2F4MWlMdldO?=
 =?utf-8?B?RGpTSmcranpHSTc3eG15Uld0SWwwaUs5Rkc0NnR6Qi9BdG4wWUg4aUdGckJy?=
 =?utf-8?B?MFE0dURwR3JrYTVmL2xMYVRBeVlacEFweWdPWlI2V0c5Ry9QUTFBL01zamwx?=
 =?utf-8?B?SmZzQkl2YWJ1aXpOTFZVdkpROVpucm0vOE96UjFuU0pJSmw5VW4wQ3NLVCs1?=
 =?utf-8?B?aVFubzNxZHhFei9DYUw3TnhCV3h3VVk3c05UTHdwNEZmUVNEZW0wOGFuL25j?=
 =?utf-8?B?MGR3OEpaUysxRC83RUZ3Q1kvSVh0MVYxOVk1aWFkcXJRUnNZTjdWSHVpRGIv?=
 =?utf-8?B?eEZzcDFFc09GT2FhZUxOL2k4MWtpV0VCMThlV0NkSXJPSC9XMUlNWlVkQ0c3?=
 =?utf-8?B?RGhLb3lPRGh6T3AvWkQ0ZUtXSlJOaU5QYVh2TWJjYmtGRmJlTWtFSkloLzFa?=
 =?utf-8?B?NDZLWU1rUzNKWDAwZjZNZ1Fjc3lrWHpjaXYrNnprN1IvdDhJUTZsVWxHaXRN?=
 =?utf-8?B?akxOY3RVZjBCT1BESzE0eEZwQU80MlBDdTV5TXBiZG1PbS9ZSWFleHUvN2F6?=
 =?utf-8?B?dGhoWnVIcU1ZdkVvUlA5eDJJTVZoSmd0RnlDMUdUUmJ1THB4a0lBVWdxdnov?=
 =?utf-8?B?S0FjdnpxSkhFenNtNjhRUDR3aEh3QzdaVW5qVHFBUEVqRTQzVmVqN0YxNkth?=
 =?utf-8?Q?2AYW6GRmYt1BzNZphI=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 63381953-d18a-4d2f-47a6-08dda3672900
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:56:02.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPFC2BBD9DFD



On 04-06-2025 06:02 pm, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> 
>>> We do not say "This patch does X" or "I do Y" when describing a
>>> change.  Rather, you give an order to somebody who is modifying the
>>> codebase to "make it so".  Something like ...
>>> ...
>> Ok. Want me to send another revision, or we good for now?
> 
> As the codebase will be frozen during the rc period, I am not in a
> hurry.  But submitting hopefully a small and final reroll would be a
> good way to conclude the cycle.

Sent

