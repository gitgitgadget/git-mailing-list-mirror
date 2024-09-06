Received: from mx-relay93-hz1.antispameurope.com (mx-relay93-hz1.antispameurope.com [94.100.132.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48D3B1A2
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=94.100.132.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604386; cv=fail; b=DCO9zM8KF6AsQEmF9vUdBYG6XmOW+MEfMw+LWwtyglbezBGQqn6PNwBE63g7PyhKyggrxiYIIdqCSCT4Nc5WCYlaksh6OrKwTua9lznS8jAX5G3nSq/iCiIB4goikZh/1jf8SI2xNgM/0++bFctMglHriDLtIdMiAQQJd7qjtz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604386; c=relaxed/simple;
	bh=D4C/17t53ljNw6gfWLsiYHM8LtDuAX86AH/XTqn61S4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iHzjfE7BmxlhZRPBi6+wD91CblEA8WhOI3/85ytRY1MsPvfzZqI1ia6uEwnSa/2aMPxhnYIMlzscT/7U1LXDv3wmUxXExfZUFNUrVukSYUtG9iAXRdcpPkXtmGfjcN9DbkPhwe3TDaFb9iLCvd12whlx1P9U3XCljyaWAbSnXRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com; spf=pass smtp.mailfrom=miele.com; dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b=dCpMWLIp; dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b=YXu5oqJy; arc=fail smtp.client-ip=94.100.132.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=miele.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miele.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=miele365.onmicrosoft.com header.i=@miele365.onmicrosoft.com header.b="dCpMWLIp";
	dkim=pass (2048-bit key) header.d=miele.com header.i=@miele.com header.b="YXu5oqJy"
Received: from mail-db8eur05lp2105.outbound.protection.outlook.com ([104.47.17.105]) by mx-relay93-hz1.antispameurope.com;
 Fri, 06 Sep 2024 08:32:45 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkK2ORjAGgeoOy1TYeUnuNuUXp5FxVW+Aw7APdTVb3h5ZdVDafPY6KAt8bvqPqXK/1fvP1We65E9K9d2Ka0lS+61HnGMH3l/oSXP2o42KRKNaZdcZU1UakL08Xa6isA/YTA//x727k7yMW34mNMgY6c84dbiqpjZC2xR00CAj98tfcRd9D9WYY7u6bdSayh+y0JBIz92D3vLKMFo5w2gNGHhHfu4GbyyOtjAlJVb+rEm/4MqUmtin50m2A3Y4uGuhewgyroGCKgGelbcTc6NgyHq6L0PyQHsoY9/tLka4xL1ed4MGIe37zMqdlt09uSisVG0/zJvSMzx8ENswHXfIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4C/17t53ljNw6gfWLsiYHM8LtDuAX86AH/XTqn61S4=;
 b=pSq3Qs5hnnjtufL6BrnTFGUzDwEef7AqhF+pginZgfeFq/nRRMI/LWjRfDImQF/xwR/LGFpCmdf3+B2KkaJNbJTvh+DaUjTQtYIqDBWpbMfydHS1gWxSlWvYlpJ61eUzzT5a7tOwQaudJnCFPBpbkijOaS/iBVNHHL3qdHqsRuOJM0jmejVsg8kKcEwTBKNY6KET78/bV5V0AsyiYHt1ThXFSeJ3iNJw1WEwGji2JwPHloxxA49fRENphdDWO7Q/bApChn9m+9mGGgvQq0aKUrKiS6OI+80cQF4Gey/mR1+xPp4dUKk2p5nZq8uoeyfjGS7yhtx1T1s6fLI9ph5r1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=miele.com; dmarc=pass action=none header.from=miele.com;
 dkim=pass header.d=miele.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=miele365.onmicrosoft.com; s=selector2-miele365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4C/17t53ljNw6gfWLsiYHM8LtDuAX86AH/XTqn61S4=;
 b=dCpMWLIpaZ6pa0UafmcmdFGljXnW2tJAEcTU5sAnf6Osje9bkwkMhCeGhqzBDdf0Ed7nvmF13c8w78yJDgPRFo+Z4ai0jVF1p/OexzxG/V12AgPKy9uyaB8pFZLKv6JDKLjewscd41cQBM37nli4DIoI2piKxaQhrD++kyE9JhY=
Received: from AS2PR08MB8288.eurprd08.prod.outlook.com (2603:10a6:20b:557::8)
 by DU0PR08MB10360.eurprd08.prod.outlook.com (2603:10a6:10:417::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.13; Fri, 6 Sep
 2024 06:32:34 +0000
Received: from AS2PR08MB8288.eurprd08.prod.outlook.com
 ([fe80::85a6:7b0e:5297:24a]) by AS2PR08MB8288.eurprd08.prod.outlook.com
 ([fe80::85a6:7b0e:5297:24a%7]) with mapi id 15.20.7939.010; Fri, 6 Sep 2024
 06:32:34 +0000
From: "tobias.boesch@miele.com" <tobias.boesch@miele.com>
To: Johannes Sixt <j6t@kdbg.org>
CC: ToBoMi via GitGitGadget <gitgitgadget@gmail.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
Subject: AW: [PATCH v2] git gui: add directly calling merge tool from
 gitconfig
Thread-Topic: [PATCH v2] git gui: add directly calling merge tool from
 gitconfig
Thread-Index: AQHa+STSGG0G4hMvjU6zVij+Dv2p67JBZ5eAgAd87fA=
Date: Fri, 6 Sep 2024 06:32:34 +0000
Message-ID: 
 <AS2PR08MB828842126285586C19028FB5E19E2@AS2PR08MB8288.eurprd08.prod.outlook.com>
References: <pull.1773.git.1724066944786.gitgitgadget@gmail.com>
 <pull.1773.v2.git.1724833917245.gitgitgadget@gmail.com>
 <61b9b041-97cf-47ac-84ef-1467aba873e3@kdbg.org>
In-Reply-To: <61b9b041-97cf-47ac-84ef-1467aba873e3@kdbg.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ActionId=62ecd408-25a2-450e-84d9-5b701831c9af;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_ContentBits=0;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Enabled=true;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Method=Standard;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_Name=General;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SetDate=2024-09-05T08:12:52Z;MSIP_Label_eef16b98-c9e0-42fa-917d-c446735d6f1c_SiteId=22991c1b-aa70-4d9c-85be-637908be565f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=miele.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR08MB8288:EE_|DU0PR08MB10360:EE_
x-ms-office365-filtering-correlation-id: 5cdbdf6a-769d-4f49-26b8-08dcce3db15a
x-miele-exorule: Spamfilter umgehen
x-miele-exorule-disclaimer-company-imperial: 1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Y3hLYUY0ZzBUcUl6OHpsbkErNldjcDFHZmhiczFnMzB0V2lyZThFUkNla1VT?=
 =?utf-8?B?bWtncWx1S24weHRlRUJQWXlMdVdMVTV1cklkeFRBeTVGTm1NMDFUUDFMK0Jq?=
 =?utf-8?B?RUxaanpja0JMUGdzTFowRFY0WUVBWG5tdW5UcC9tSjdJV3lyeE5GZHlveTFm?=
 =?utf-8?B?Mzk2VmxZOXlIR0VlMTRkV28rTkkrWVFlZklJT2ZwbHU3VG1LVEhFRk5GR0NN?=
 =?utf-8?B?a3VkSEw4QzVsZVdvZGpjSEtna0dQRnJiQzdGN21JelJlZDhVdUtRMDNwWUF6?=
 =?utf-8?B?bHpXbW54TGdROFZzbG5HMUthYytVaFdpa0sxOHN6S2VveGh6NUZ4VUcvNlU4?=
 =?utf-8?B?cmh2blUzY0MyRnpTSFE3cFZmbHFETFBhVDRsRURTSzVFYkpuYU52NGpzNEwy?=
 =?utf-8?B?eGtXNmJDUTJZVUUrUlFKWkVPcU1EcUpHbjJIbDFsRHdweW9iMmU3Zk9LWXJh?=
 =?utf-8?B?MWprU2hPYldIRFFGWXN2ME9IZXUyN0tFelBnQ2c3T0kyUjZPRG9ncmJjL3R4?=
 =?utf-8?B?SDdSaVltMkFBalVJeXhIU1NrUGdkdkI4Tm51cWZSYWtVQTRjYTBDRlJTVXpa?=
 =?utf-8?B?TnYvRGVmaU8wQXJzeEZRdHNBR0NaT25ORWRpVElRQnVGalFTRUtEOGNUOC9E?=
 =?utf-8?B?SGFqSm9LZ09ETjZmd29udlhUK3hodDgrbmtqVWVjMGtRTDVDS3JkWHVaTDE2?=
 =?utf-8?B?LzdFaXdPNUZjelRaMHBKS0F3SFVnc0trNm0vV0xiK2wzQVFaam9zTys0ZXpy?=
 =?utf-8?B?cFVqdHZxNjVNZGV3R0lEY25xK2pBVlZIR3lwbDZ2WkZSbDltM05ESWpsMHBF?=
 =?utf-8?B?RzVOOGRpamVkMExhWjFERlErS1JkbFFVMFc0SGxxemJiNzh3SDBxbW1VSGt5?=
 =?utf-8?B?dVh0SS9kVFdheXZXRUtBbnBMTWZRL3Y0QWUvL2tUQlZwZDI0QWY0OTY5K0hw?=
 =?utf-8?B?RnB0YzJLLzJ3REwvaEh0YjBJUTFoZjBOSmN2ZVg5QVlwalMzTGRUdkU4cjh4?=
 =?utf-8?B?a2lGZlB5VWxRd2dpTjNHTzFYd1NvZjdjaVhFdHMzSHE0TzN3SjJaVmFTK2tJ?=
 =?utf-8?B?S08rMkV4MllnOFlCbzZXLzdndWltb1M0ZlEwQ1BSZ2xtVU5IcHgrQXVleDhq?=
 =?utf-8?B?WEJ1Rnhicy9LVVFmYmNOL2FXMk5TVnVuZmRzbXZzTE9uaWo4UDJzbVE1ZlE5?=
 =?utf-8?B?TEtCK040ZUdFVHg1ek1RL1MydzJvY2gzWkdiR3NnWXdrcThhR3djdFJpL3RB?=
 =?utf-8?B?TVhjWHhXZVdOUHZJZER6clVvUkJJQWVzTXk2QXVlcy9wcGc0dDZWMzFralNi?=
 =?utf-8?B?dTQxMHhJQnRmZTdyUHIyaUxNaDZ5dzNDZnJrdkYxcDFKU1RRMXh3dDNXek5n?=
 =?utf-8?B?dlhNYTJLRUZDZW50NjJhc2xNWStvYnc5MlVjWkVoc2lFdjVFejNQQUp6Qzhm?=
 =?utf-8?B?dFRvbnVYVHJGdDk3ZlZaNTI5NXhLRWcvQStqZzU3Z2pTeEM4S1FHOWVkZUZT?=
 =?utf-8?B?TWZOa2I1cWo1RVVqR09JMlVObmZVRk0yZVVLY0swN2VDQ1p6T1lOOXpNVnJz?=
 =?utf-8?B?emNlamgyRWYwK2x3RzAwQTJOUSttV1dncWUrSmhha2pPanU5MDNoTWdNUGo1?=
 =?utf-8?B?T2RXeWVuK2RJWGpqODBKTXh6SE5oa3hhaGtkenlJQXNEcGwxRElwY01aVE5l?=
 =?utf-8?B?aDMrYTFOc05XWVhNMmNxZVNLaDFMamVpd3VsYndCcHgzd1FZRzBsWDRYSkdE?=
 =?utf-8?B?VXMzc0pQelFQVHNTaDBTMXFYamtUS015YytzZEZoUUpaVnZrN2NyUjQ1eHdK?=
 =?utf-8?B?WTZRYzAwRGhCU1pJaElwR1o5Q2twMm53WFZrM1BmcDAramVXbktsYTNNQ2xL?=
 =?utf-8?B?b2dBZnRTazczbWNHV1BDYXVNMWlMbmpnakN3MmRBRmFmUkE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8288.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?Q3RpSmhxTitFMHgvV3BqL0xHeXBkTWZsejFSSkdvbys3RGtNdGRhZFN3cW1K?=
 =?utf-8?B?SU9kUFY4RFRlT0VLNk41eVJCUmUvZG5LWW8yZUpPNmZzcDV4RldpNXpJdkVW?=
 =?utf-8?B?RkYyeGFsWWREWUpsYjloWEloMUFYWGp3NGxkbC90ZlQ4b0hHaW9OaFNPUzc2?=
 =?utf-8?B?UkJ2Z0xZWFh0OE1adWhBdHlNTm00VnhOYWg2Nmp3Rm1rSzQ3WFF0bnM4THNO?=
 =?utf-8?B?VnlaV1lOVWx3dVJvRlVQYXdEVlNSWUpZRC9CbDZNZEZTbkdOaVlMQlJYaHQ5?=
 =?utf-8?B?TXdsRmczWHEydnFSVW55MFpnVmEvajVvYitEbmhUdVZZLzNIeXBsZVdsSkNu?=
 =?utf-8?B?dUU3dDQ3WVc0aUp0LzA4UEh2S0xTM0JzZS82ZTRZQ1JXdVQ2QmVycnJVbFhK?=
 =?utf-8?B?RFJ2Zm01NGFuVjRBYTExRi9EaXdMZXFhVHFrN0g0MjZrQXRGZDRpT2Z2aWdY?=
 =?utf-8?B?TzBxOWNDRklLTHRSNGxrNDVRT3Y2cG56ZnVWWkhnbXhUZG90N3FTL1hnL1B1?=
 =?utf-8?B?WnRlQ3ZTanBEZHdlMkFGN3J6WGtqNWIyOGl3ZHdxaWV6c0c3RzBaUGtuL3hY?=
 =?utf-8?B?ZGsvOTdBdkIzczBNK3M3ZHUza09jbWk2bFlxeUw2LzVwcnJOZ1RIV0JiVHVH?=
 =?utf-8?B?OUdPdThxaVRwT2o5T25FTitzUWkvenFIcTNzVUxxVXFsR0dKS3RBQ3VPUUhq?=
 =?utf-8?B?QytkbFpWMGZ6cTRRVGdJNS9pMUxzRGtNd0ZEaE1nVXRkenZCeXFOaWNwL0o0?=
 =?utf-8?B?VGZzb2o1M0c5TDc2ZmY4ZE90U0ZGRllQZUlhMTV1MWZRaFk4UDVLdmhnRGt3?=
 =?utf-8?B?UVZyZVMvNFV6RkRqM2ZGaHY4Y2ZpeDRVdWl6RGFZaXRJRnd3eFJId1Q1Mk91?=
 =?utf-8?B?NGZ4RXhHSDFwZ0pSNjRHUHlnQWpMYzRmaFp1eTNSVWxuQWNYa1BURTZwOUZN?=
 =?utf-8?B?MFZ6dFJmVktTT3pzQlNYSjZ1UWJMZjBGUUNmaStpTmxFMlhjTC9mem40bHNP?=
 =?utf-8?B?WmxlblF1SkRWb1RPc1plODhaYnJ4emVzVHkxclhZNEpISGFzZ0tEVG4wb3d5?=
 =?utf-8?B?VTg0OVJqK1htYUVLWVhwcDR4Z043YXphUVZ6SWZkcEZZT05ETnZIbzYxL3NM?=
 =?utf-8?B?Mk8yYVZ0bTg5WXg3QnFzUTZxU1J4aVZJd0h1aHRCNWxQR1prVHJZRnBwUnpX?=
 =?utf-8?B?UFhlYkJ4YVVKZVIxN3BKN1lXNEd4eVBIN1p4dTlyTThleWM2eElWcTRmRmJI?=
 =?utf-8?B?QjIzUFdhYzRzekR6RzVNc25JR1ZGQmZyc21CS3JNUWJia1h4UGIxblgwOVBU?=
 =?utf-8?B?U2xVTTJacmhOU01Ha3ZNVmpGL0toYUZWTXkrWlVWcDBVUmJxNUozNjdNSUlu?=
 =?utf-8?B?Z3ROSkRoM2JSZnU4ZEJyZ043RER4aDVnMzUxUXpteDdkNk4xVkR3L0dVd2cw?=
 =?utf-8?B?c2lPYmpFTnNCZ2JzRzBXTGFiMUR1ZzEvenNnWDgrdVB3eWR3T0xiRnZxUUY4?=
 =?utf-8?B?aWdqaGREdVYvcGE0V2pkUFlIR0crSGtnS0l1QnRZcFNMdDhQVjFic0lJekJY?=
 =?utf-8?B?cVl4R2hmZ1JkK3NVb2FkL1pZUENacHYyTGJid0JDdzFDWW5HcnllT2JGZUgz?=
 =?utf-8?B?ZVd4RTdBZlptdi82SVVSTjh0YTZyVW9xOFRFUjIxQ25jdktFeUtKYUJESXI0?=
 =?utf-8?B?Zy9FZ2xuYUFlSnZTZjhZZ1BiK1hNM3VFNElWMEVFYWVJY01DQWtEdE5IRjZI?=
 =?utf-8?B?dmNoTmlmaHdPWmh5dE1uMk5VK1Y3RmFUT0FYcmlDTXYzR2pvYnNkZ1FhcUI4?=
 =?utf-8?B?azhZcUdHQmphUVZBWlc5TFNmR3Q0MmFxQ2VHQi9KZHdTaFEyWlNVMTI2TmRo?=
 =?utf-8?B?OTBISXdHeVVFOVMzMnIvSDVHaGFvYkd1Y1VQejJhcnpUam8rbE9pdFlQSlcr?=
 =?utf-8?B?TmZlaEZySjMrWTdoYlUwTE1PU1RyTlArMHIvNlJQY2c0WldMdnNvZzhXSWEz?=
 =?utf-8?B?N0RzS2VoNDNRY1Z2ZnFEYWdhQUhra1k1TVJQTVloWVRaZ3RiTGtIWGtreDZ1?=
 =?utf-8?B?a05lbDhidkhmdElWSStiVFVkb1U5dnRJaFZ5enREWDN1NDRaVGZIVGRudXJh?=
 =?utf-8?Q?fvOVInfKBvQGnCLX33eLRffBz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: miele.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8288.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdbdf6a-769d-4f49-26b8-08dcce3db15a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 06:32:34.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22991c1b-aa70-4d9c-85be-637908be565f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VdApHUhSFzrV0Lb56AI+flJ5ris/NSC0Pgui3j1PMeYZ2hVi3GDTYkuPjNMF8c50GXosjB8H0L+isdilDjxRSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB10360
X-cloud-security-sender:tobias.boesch@miele.com
X-cloud-security-recipient:git@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay93-hz1.antispameurope.com with 4X0RH93yFzz3H51P
X-cloud-security-connect: mail-db8eur05lp2105.outbound.protection.outlook.com[104.47.17.105], TLS=1, IP=104.47.17.105
X-cloud-security-Digest:9e4bba82748551e3388daffe26ccda75
X-cloud-security:scantime:1.418
DKIM-Signature: a=rsa-sha256;
 bh=D4C/17t53ljNw6gfWLsiYHM8LtDuAX86AH/XTqn61S4=; c=relaxed/relaxed;
 d=miele.com; h=content-type:mime-version:subject:from:to:message-id:date;
 s=hse1; t=1725604365; v=1;
 b=YXu5oqJykbq02mghQfjKPm4NEO2kkEyWAAvmdhIEGQ9eSJOiqWS41K97//qmTKgtbPcEH3ou
 EQx3wyiXN+w+hWuZ/ylTUARzCcvzYkXqxp7yIvHf0IoX6o/iBpRaq0pXoTdl+cVZv9m3RywOo7v
 rEzwsKW4c9KrIlF7WhBss+0SkqGeDWKPbh8s/Qb4fSqfLvy4ANCEHBAuFTMy2s0h+f87tTgA2AT
 GG/fL6+hizyvjisQRE2JKdGJ1YbKhF2MPn4un6Dc8aGQea8hLnhVB9QBUCcJKXRnFo5lUzo2k+6
 aqsFCMwHaSi4ApWi4ETnobRYm0jFRe1ccisEU6i0zRzEA==

PiAtLS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjogSm9oYW5uZXMgU2l4
dCA8ajZ0QGtkYmcub3JnPg0KPiBHZXNlbmRldDogU2Ftc3RhZywgMzEuIEF1Z3VzdCAyMDI0IDE1
OjUyDQo+IEFuOiBCb2VzY2gsIFRvYmlhcyA8dG9iaWFzLmJvZXNjaEBtaWVsZS5jb20+DQo+IENj
OiBUb0JvTWkgdmlhIEdpdEdpdEdhZGdldCA8Z2l0Z2l0Z2FkZ2V0QGdtYWlsLmNvbT47IGdpdEB2
Z2VyLmtlcm5lbC5vcmcNCj4gQmV0cmVmZjogUmU6IFtQQVRDSCB2Ml0gZ2l0IGd1aTogYWRkIGRp
cmVjdGx5IGNhbGxpbmcgbWVyZ2UgdG9vbCBmcm9tIGdpdGNvbmZpZw0KPg0KPiBBbSAyOC4wOC4y
NCB1bSAxMDozMSBzY2hyaWViIFRvQm9NaSB2aWEgR2l0R2l0R2FkZ2V0Og0KPiA+IEZyb206IGRl
Ym9ldG8gPHRvYmlhcy5ib2VzY2hAbWllbGUuY29tPg0KPiA+DQo+ID4gZ2l0IGd1aSBjYW4gb3Bl
biBhIG1lcmdlIHRvb2wgd2hlbiBjb25mbGljdHMgYXJlIGRldGVjdGVkIChSaWdodCBjbGljaw0K
PiA+IGluIHRoZSBkaWZmIG9mIHRoZSBmaWxlIHdpdGggY29uZmxpY3RzKS4NCj4gPiBUaGUgbWVy
Z2UgdG9vbHMgdGhhdCBhcmUgYWxsb3dlZCB0bw0KPiA+IHVzZSBhcmUgaGFyZCBjb2RlZCBpbnRv
IGdpdCBndWkuDQo+ID4NCj4gPiBJZiBvbmUgd2FudHMgdG8gYWRkIGEgbmV3IG1lcmdlIHRvb2wg
aXQgaGFzIHRvIGJlIGFkZGVkIHRvIGdpdCBndWkNCj4gPiB0aHJvdWdoIGEgc291cmNlIGNvZGUg
Y2hhbmdlLg0KPiA+IFRoaXMgaXMgbm90IGNvbnZlbmllbnQgaW4gY29tcGFyaXNvbiB0byBob3cg
aXQgd29ya3MgaW4gZ2l0ICh3aXRob3V0DQo+ID4gZ3VpKS4NCj4gPg0KPiA+IGdpdCBpdHNlbGYg
aGFzIGNvbmZpZ3VyYXRpb24gb3B0aW9ucyBmb3IgYSBtZXJnZSB0b29scyBwYXRoIGFuZA0KPiA+
IGNvbW1hbmQgaW4gdGhlIGdpdCBjb25maWcuDQo+ID4gTmV3IG1lcmdlIHRvb2xzIGNhbiBiZSBz
ZXQgdXAgdGhlcmUgd2l0aG91dCBhIHNvdXJjZSBjb2RlIGNoYW5nZS4NCj4gPg0KPiA+IFRob3Nl
IG9wdGlvbnMgYXJlIHVzZWQgb25seSBieSBwdXJlIGdpdCBpbiBjb250cmFzdCB0byBnaXQgZ3Vp
LiBnaXQNCj4gPiBjYWxscyB0aGUgY29uZmlndXJlZCBtZXJnZSB0b29scyBkaXJlY3RseSBmcm9t
IHRoZSBjb25maWcgd2hpbGUgZ2l0DQo+ID4gR3VpIGRvZXNuJ3QuDQo+ID4NCj4gPiBXaXRoIHRo
aXMgY2hhbmdlIGdpdCBndWkgY2FuIGNhbGwgbWVyZ2UgdG9vbHMgY29uZmlndXJlZCBpbiB0aGUN
Cj4gPiBnaXRjb25maWcgZGlyZWN0bHkgd2l0aG91dCBhIGNoYW5nZSBpbiBnaXQgZ3VpIHNvdXJj
ZSBjb2RlLg0KPiA+IEl0IG5lZWRzIGEgY29uZmlndXJlZCBtZXJnZS50b29sIGFuZCBhIGNvbmZp
Z3VyZWQgbWVyZ2V0b29sLmNtZCBjb25maWcNCj4gPiBlbnRyeS4NCj4NCj4gT0suDQo+DQo+ID4g
Z2l0Y29uZmlnIGV4YW1wbGU6DQo+ID4gW21lcmdlXQ0KPiA+ICAgICB0b29sID0gdnNjb2RlDQo+
ID4gW21lcmdldG9vbCAidnNjb2RlIl0NCj4gPiAgICAgcGF0aCA9IHRoZS9wYXRoL3RvL0NvZGUu
ZXhlDQo+ID4gICAgIGNtZCA9IFwiQ29kZS5leGVcIiAtLXdhaXQgLS1tZXJnZSBcIiRMT0NBTFwi
IFwiJFJFTU9URVwiDQo+IFwiJEJBU0VcIiBcIiRNRVJHRURcIg0KPg0KPiBJIGZvdW5kIGl0IGFu
bm95aW5nIHRoYXQgSSBoYWQgdG8gY29uZmlndXJlIC5wYXRoIGluIGFkZGl0aW9uIHRvIC5jbWQu
DQo+IFR5cGljYWxseSwgeW91IHdvdWxkIHB1dCB0aGUgY29ycmVjdCBwYXRoIGludG8gdGhlIC5j
bWQgY29uZmlndXJhdGlvbi4NCj4gSW4gZmFjdCwgYGdpdCBtZXJnZXRvb2xgIHdvcmtzIHdpdGhv
dXQgLnBhdGggYW5kIGZhaWxzIHdoZW4gLmNtZCBkb2VzIG5vdA0KPiBjb250YWluIHRoZSBjb3Jy
ZWN0IHBhdGguDQo+DQoNCkkgY2hhbmdlZCBpdCB0byBvbmx5IHVzZSB0aGUgbWVyZ2V0b29sLmNt
ZCBhbmQgdXBkYXRlZCB0aGUgY29uZmlndXJhdGlvbiBoaW50IHRoYXQgbWVudGlvbnMgdGhlIGNv
bmZpZ3VyYXRpb24gdmFyaWFibGVzIHNvIHRoYXQgdXNlcnMga25vdyB0byBvbmx5IHNwZWNpZnkg
dGhlIGNtZCB2YXJpYWJsZS4NCg0KPiA+IFdpdGhvdXQgdGhlIG1lcmdldG9vbC5jbWQgY29uZmln
dXJhdGlvbiBhbmQgYW4gdW5zdXBwb3J0ZWQgbWVyZ2UudG9vbA0KPiA+IGVudHJ5LCBnaXQgZ3Vp
IGJlaGF2ZXMgbWFpbmx5IGFzIGJlZm9yZSB0aGlzIGNoYW5nZSBhbmQgaW5mb3JtcyB0aGUNCj4g
PiB1c2VyIGFib3V0IGFuIHVuc3VwcG9ydGVkIG1lcmdlIHRvb2wsIGJ1dCBub3cgYWxzbyBzaG93
cyBhIGhpbnQgdG8gYWRkDQo+ID4gYSBjb25maWcgZW50cnkgZm9yIHRoZSB0b29sIGluIGdpdGNv
bmZpZy4NCj4NCj4gR29vZC4NCj4NCj4gV2hpbGUgdGVzdGluZyBJIGNvbmZpZ3VyZWQgbWVsZCBp
bmNvcnJlY3RseSBvbmNlIGFuZCBnb3Qgbm8gZmVlZGJhY2sNCj4gd2hhdHNvZXZlciwgYnV0IEkg
d291bGQgbm90IGF0dHJpYnV0ZSB0aGlzIHRvIHRoaXMgcGF0Y2guDQo+DQoNClRoYXQncyBvZGQu
IEkgdGVzdGVkIHRoaXMgYWdhaW4gYnkgc2V0dGluZyBtZXJnZS50b29sIHRvICJtZWxkIiBhbmQg
Y29uZmlndXJlZCBtZXJnZXRvb2wuY21kIHRvICJzb21lIHdyb25nIHBhdGgiLiBXaGVuIHN0YXJ0
aW5nIHRoZSBtZXJnZXRvb2wgSSBnb3QgYSBwb3B1cCBzYXlpbmcgdGhhdCBtZWxkIHdhcyBub3Qg
Zm91bmQgaW4gcGF0aC4NCg0KPiBUaGVyZSBpcyBubyBzdWNoIHRoaW5nIGNhbGxlZCAiZ2l0Y29u
ZmlnIi4gSnVzdCBzdHJpa2UgImluIGdpdGNvbmZpZyIuDQo+DQo+ID4gSWYgYSB3cm9uZyBtZXJn
ZXRvb2wuY21kIGlzIGNvbmZpZ3VyZWQgYnkgYWNjaWRlbnQgaXQgaXMgYmVlaW5nDQo+ID4gaGFu
ZGxlZCBieSBnaXQgZ3VpIGFscmVhZHkuIEluIHRoaXMgY2FzZSBnaXQgZ3VpIGluZm9ybXMgdGhl
IHVzZXIgdGhhdA0KPiA+IHRoZSBtZXJnZSB0b29sIGNvdWxkbid0IGJlIG9wZW5lZC4gVGhpcyBi
ZWhhdmlvciBpcyBwcmVzZXJ2ZWQgYnkgdGhpcw0KPiA+IGNoYW5nZSBhbmQgc2hvdWxkIG5vdCBj
aGFuZ2UuDQo+DQo+IEdvb2QuDQo+DQo+ID4NCj4gPiBCZXlvbmQgY29tcGFyZSAzIGFuZCBWaXN1
YWwgU3R1ZGlvIGNvZGUgd2VyZSB0ZXN0ZWQgYXMgbWFudWFsbHkNCj4gPiBjb25maWd1cmVkIG1l
cmdlIHRvb2xzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVG9iaWFzIEJvZXNjaCA8dG9iaWFz
LmJvZXNjaEBtaWVsZS5jb20+DQo+DQo+IFlvdSB1cGRhdGVkIHRoaXMgbGluZSwgYnV0IG5vdCB0
aGUgRnJvbTogbGluZS4gV291bGQgeW91IG1pbmQgY29uZmlndXJpbmcNCj4geW91ciB1c2VyLm5h
bWUgYW5kIHRoZW4gYGdpdCBjb21taXQgLS1hbWVuZCAtLXJlc2V0LWF1dGhvcmA/DQo+DQo+ID4g
IGdpdC1ndWkvbGliL21lcmdldG9vbC50Y2wgfCAxMCArKysrKysrKy0tDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvZ2l0LWd1aS9saWIvbWVyZ2V0b29sLnRjbCBiL2dpdC1ndWkvbGliL21lcmdldG9vbC50
Y2wNCj4gPiBpbmRleCBlNjg4YjAxNmVmNi4uNGM0ZThmNDdiYjAgMTAwNjQ0DQo+ID4gLS0tIGEv
Z2l0LWd1aS9saWIvbWVyZ2V0b29sLnRjbA0KPiA+ICsrKyBiL2dpdC1ndWkvbGliL21lcmdldG9v
bC50Y2wNCj4gPiBAQCAtMjcyLDggKzI3MiwxNCBAQCBwcm9jIG1lcmdlX3Jlc29sdmVfdG9vbDIg
e30gew0KPiA+ICAgICAgICAgICAgIH0NCj4gPiAgICAgfQ0KPiA+ICAgICBkZWZhdWx0IHsNCj4g
PiAtICAgICAgICAgICBlcnJvcl9wb3B1cCBbbWMgIlVuc3VwcG9ydGVkIG1lcmdlIHRvb2wgJyVz
JyIgJHRvb2xdDQo+ID4gLSAgICAgICAgICAgcmV0dXJuDQo+ID4gKyAgICAgICAgICAgc2V0IHRv
b2xfY21kIFtnZXRfY29uZmlnIG1lcmdldG9vbC4kdG9vbC5jbWRdDQo+ID4gKyAgICAgICAgICAg
aWYgeyR0b29sX2NtZCBuZSB7fX0gew0KPiA+ICsgICAgICAgICAgICAgICAgICAgc2V0IHRvb2xf
Y21kX2ZpbGVfdmFyc19yZXNvbHZlZCBbc3Vic3QgLW5vYmFja3NsYXNoZXMNCj4gLW5vY29tbWFu
ZHMNCj4gPiArJHRvb2xfY21kXQ0KPg0KPiBJIGp1c3QgbGVhcm50IHRoYXQgYSBzdHJpbmcgdmFs
dWUgY29udGFpbmluZyBkb3VibGUtcXVvdGVzIGlzIGJyb2tlbiBpbnRvIGEgbGlzdCBpbg0KPiB0
aGUgZXhwZWN0ZWQgd2F5IChrZWVwcyBxdW90ZWQgcGFydHMgdG9nZXRoZXIgYXMgYSBzaW5nbGUg
ZWxlbWVudCkuIEhvd2V2ZXIsDQo+IHRoaXMgZm9ybSBvZiBzdWJzdGl0dXRpb24gcmVwbGFjZXMg
dmFyaWFibGUgdmFsdWVzIHdpdGggYXJiaXRyYXJ5IHRleHQgd2l0aG91dA0KPiB0YWtpbmcgaW50
byBhY2NvdW50IHRoYXQgdGhlIG9yaWdpbmFsIHN0cmluZyBpcyBhY3R1YWxseSBhIGxpc3QuIFNo
b3VsZCB3ZSBub3QNCj4gYnJlYWsgdGhlIHN0cmluZyBpbnRvIGEgbGlzdCBmaXJzdCwgYW5kIGFw
cGx5IHRoZSBzdWJzdGl0dXRpb24gb24gdGhlIGxpc3QgZWxlbWVudHM/DQo+DQoNCkkgY2FuIGl0
ZXJhdGUgZGlyZWN0bHkgb24gdGhlIGlucHV0IHN0cmluZyBhcyBhIGxpc3QuIFdpbGwgYmUgcGFy
dCBvZiB0aGUgbmV4dCBwYXRjaCB2ZXJzaW9uLg0KDQo+IElmIHRoZXJlIGlzIGEgc3RyYWlnaHQt
Zm9yd2FyZCB3YXkgdG8gZG8gdGhpcyAoc2F5LCBhbiBvYnZpb3VzIHR3by1saW5lciBhdA0KPiBt
b3N0KSwgd2Ugc2hvdWxkIGRvIGl0LiBPdGhlcndpc2UsIEkgY2FuIGxpdmUgd2l0aCB0aGlzIHNv
bHV0aW9uIGZvciBub3cNCj4gYmVjYXVzZSBpdCByZXF1aXJlcyBmaWxlIG5hbWVzIHdpdGggZG91
YmxlLXF1b3RlcyB0byBicmVhayB0aGUgZXhwZWN0ZWQgbGlzdA0KPiBuYXR1cmUuDQo+DQo+IFRo
ZXJlIGlzIGFub3RoZXIgdGhpbmcsIHRob3VnaCwgdGhhdCBJIHdvdWxkIG5vdCB3YW50IHRvIHRh
a2UgYXMNCj4gbGlnaHRseTogVGhlIC1ub2NvbW1hbmRzIG1vZGlmaWVyIG9mIGBzdWJzdGAgZG9l
cyBub3QgbGl2ZSB1cCB0byBpdHMgcHJvbWlzZXMsDQo+IGFuZCBpdCBpcyBldmVuIHRoZSBkb2N1
bWVudGVkIGJlaGF2aW9yOiBjb21tYW5kIHN1YnN0aXR1dGlvbnMgaW4gYXJyYXkNCj4gaW5kZXhl
cyBhcmUgc3RpbGwgZXhlY3V0ZWQuIENvbnNpZGVyIHRoaXMgY29uZmlndXJhdGlvbjoNCj4NCj4g
W21lcmdlXQ0KPiAgICAgICAgIHRvb2wgPSBldmlsDQo+IFttZXJnZXRvb2wgImV2aWwiXQ0KPiAg
ICAgICAgIGNtZCA9IG1lbGQgXCIkUkVNT1RFKFtleGl0XSlcIg0KPg0KPiBHdWVzcyB3aGF0IGhh
cHBlbnMgd2hlbiBJIHJ1biB0aGUgbWVyZ2UgdG9vbD8gSXQgZXhpdHMgR2l0IEdVSSENCj4NCj4g
SSBzdWdnZXN0IHRvIHJlamVjdCBhbnkgY29uZmlndXJhdGlvbiB0aGF0IGNvbnRhaW5zIGFuIG9w
ZW5pbmcgYnJhY2tldCAnWycgb3INCj4gYW55dGhpbmcgZWxzZSB0aGF0IGludHJvZHVjZXMgYSBj
b21tYW5kIGV4ZWN1dGlvbi4NCj4NCg0KR29vZCBjYXRjaC4gSSBhZGRlZCBjb2RlIHRvIHByZXZl
bnQgdGhpcyBpbiB0aGUgbmV4dCBwYXRjaCB2ZXJzaW9uLg0KV2hlbiBhIGNvbW1hbmQgc2VxdWVu
Y2UgaXMgZGV0ZWN0ZWQgKGJhc2ljYWxseSBzcXVhcmUgYnJhY2tldHMgaW4gdGhlIGNvbW1hbmQp
IHRoZSB1c2VyIGdldCBhIGhpbnQgdG8gYXZvaWQgc3F1YXJlIGJyYWNrZXRzIGluIHRoZSBtZXJn
ZXRvb2wuY21kLg0KDQo+ID4gKyAgICAgICAgICAgICAgICAgICBzZXQgY21kbGluZSBbbHJlcGxh
Y2UgJHRvb2xfY21kX2ZpbGVfdmFyc19yZXNvbHZlZCAwIDANCj4gJG1lcmdlX3Rvb2xfcGF0aF0N
Cj4gPiArICAgICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgICAgICAgICAgICAgICAgZXJyb3Jf
cG9wdXAgW21jICJVbnN1cHBvcnRlZCBtZXJnZSB0b29sICclcycuIElzIHRoZQ0KPiB0b29sIGNv
bW1hbmQNCj4gPiArYW5kIHBhdGggY29uZmlndXJlZCBwcm9wZXJseSBpbiBnaXRjb25maWc/IiAk
dG9vbF0NCj4NCj4gQ2FuIHdlIG5vdCBoYXZlIGEgbW9yZSBoZWxwZnVsIHRleHQ/IEhvdyBhYm91
dA0KPg0KPiAgICAgICAgICAgICAgICAgICAgICAgZXJyb3JfcG9wdXAgW21jICJVbnN1cHBvcnRl
ZCBtZXJnZSB0b29sICclcycuDQo+DQo+IFNlZSB0aGUgZ2l0LWNvbmZpZyBtYW51YWwgcGFnZSBo
b3cgdG8gY29uZmlndXJlIG1lcmdldG9vbC4lcy5jbWQgc3VpdGFibHkuIg0KPiAkdG9vbCAkdG9v
bF0NCj4NCg0KVHJ1ZS4gVXBkYXRpbmcgdGhlIHRleHQuDQoNCj4gPiArICAgICAgICAgICAgICAg
ICAgIHJldHVybg0KPiA+ICsgICAgICAgICAgIH0NCj4gPiAgICAgfQ0KPiA+ICAgICB9DQo+ID4N
Cj4NCj4gLS0gSGFubmVzDQoNCg0KTWlub3Igc3VnZ2VzdGlvbnMgd2lsbCBiZSBmaXhlZCBpbiB0
aGUgbmV4dCBwYXRjaC4NCg0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQppbXBlcmlhbC1XZXJrZSBvSEcsIFNpdHogQsO8bmRlLCBSZWdpc3RlcmdlcmljaHQgQmFk
IE9leW5oYXVzZW4gLSBIUkEgNDgyNQ0K
