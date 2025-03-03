Received: from esa5.hc2065-58.eu.iphmx.com (esa5.hc2065-58.eu.iphmx.com [207.54.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727841F4183
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=207.54.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015303; cv=fail; b=Jsnzvo2mrConNbYCYiPZClvcwlIyLOQtU/UxOcEU1RwbnJBd6FIYVPza0lkvxGJNF3gAviB1+0yZfv8Mm+LpxyC7xJCQ3hUZiITJ4qP2utUTRg7/3dwAU3yr4fwj2ckbtDtuPUCJmkWr6BUR/VAQt/8ZCmTSWFl5LbsflGAT6Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015303; c=relaxed/simple;
	bh=xwTDCb0avx0FTh7jmLXWljKiLEb2aDVrwWYFXma4RNM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cZqB2+ps1oaN4U6NOeSdL7E4z/mhYSYDvFm48sGMWRyW1Bc9UjYGNh50+8gZVWyYkmA1JMBauzbJVwQw7qMtSMmqvMDza/bQvwVH90yagMx8bKXU0+vD2FR20vmh1dVVdfwLrSBBi1tAXFq6XGoJpHUxNaQB4dEzDETnNI1Y8pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=capgemini.com; spf=pass smtp.mailfrom=capgemini.com; dkim=pass (2048-bit key) header.d=capgemini.com header.i=@capgemini.com header.b=CiiG3nJU; arc=fail smtp.client-ip=207.54.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=capgemini.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=capgemini.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=capgemini.com header.i=@capgemini.com header.b="CiiG3nJU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=capgemini.com; i=@capgemini.com; q=dns/txt; s=group3;
  t=1741015295; x=1772551295;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xwTDCb0avx0FTh7jmLXWljKiLEb2aDVrwWYFXma4RNM=;
  b=CiiG3nJU87kgNmpOpfA0FOWsfQzQT20Hq3wIgLbIjHh7PPSpz1EgOsHE
   vkX0XoULKh8x/b4hzyeVPeKjCZnJq00QWjFrjBR4FlbQNmrpIpmB9TfaW
   9JZclJRZJ4RaY5R/4TMIkx5qtu5z3YnpMFAXp4+xQwzbYkqIg4Ay3Se/a
   gOHP0RXJagi1CWUSsvmSgJmpyttHS6FNwTkBICX3/6aNWdZ3vCOuZT7pO
   bEhZOxGXSeHClYyZECNY0ADXl0qQAcjiLXC7Ccqyi9WJkbwEKXDF0r52s
   o8lUJUy2V8KZ7/zzwUsyJ7SuSCs2mk3VEG3CVEtqcZZApF7gZY3Qn2oOQ
   A==;
X-CSE-ConnectionGUID: SmBubRKgQ6KzqQ2tx8HPhw==
X-CSE-MsgGUID: 8QTi2++3RCO+oFBXP+9krw==
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="16192611"
Received: from spfnldca01.capgemini.com ([80.253.212.216])
  by ob1.hc2065-58.eu.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 03 Mar 2025 16:20:25 +0100
X-CSE-ConnectionGUID: oLuH+3cjQZGM7KQrBxAJNA==
X-CSE-MsgGUID: n0isYcNwTyib0aUM93o7UA==
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="309364443"
Received: from intdlp.capgemini.com (HELO gddlppraplv03d.corp.capgemini.com) ([10.247.137.141])
  by IRNLDCA-C695-01-D2-incoming.capgemini.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 16:20:26 +0100
Received: from GDDLPPRAPLV03D.CORP.CAPGEMINI.COM (GDDLPPRAPLV03D.CORP.CAPGEMINI.COM [127.0.0.1])
	by GDDLPPRAPLV03D.CORP.CAPGEMINI.COM (Service) with ESMTP id 64B636002C23
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 16:20:25 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by GDDLPPRAPLV03D.CORP.CAPGEMINI.COM (Service) with ESMTPS id 3ED776002C09
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 16:20:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvMVZApm2KdFTMZY3lSwDI6smDgh6g/ymM7DHUwQvaP82Vj0xjydf2HhYsiBSsCkFFCuwprl55hiCkkN/5kzzv6XrWwfn3ojvtT+71WnVVwUkYl8M4uVJOGVGp4er27sBtfLUSf92RC81wc8pbKKhAlJI1fKueeR75UE2VvoF9nJJnjxoEZzmlySxRRnCpF7G0SJu45SuqwtDkgKzjNvFyi4KHEIXvW8W6uzO0fNOhUqIyjcEPe2aus/6dkF0OfMolfUya1QUHjZGCFSo6GGYgqmw+eGjeokOOHCyAZIwYsmVWBuWhomI/cCuUaZqZDOJPFOaNv7mjCFgh1Zw/Hfdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD7iFStl0Wvh+5FplaDr1/7KRd6+hHPGsAQd7OSi1NA=;
 b=s3DbWwC4EjxoPseDlQgMKoAZFTMA+vPnYarQZru92KZDheBqaCzVLasAGHPmzCGcMUP1PVkpssWEc4k8x9l9akiLNnYRl3AVdRpBSOCyKnQL3HOK0WEP11Pra7j0pyvgZBw1oI9c6z4kkQdZCC7LgowlUsgEsv6gF1tvXVeaqKqHgeF4edCYKdKQ66lDOdTuMbQ9i8TPoK1eMhcXKxwAIp9IZ4QZcYBIJZTOIRIDDWgXIgUNG6ndOJ4VlYMhhKxs+GMxms4u7MBtI0379SnHSPaC/or1fY4SR7i4ddDoZ+UcF41TfYA2W0sbdfFMb83iDGewGunxayx0TnW707V1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=capgemini.com; dmarc=pass action=none
 header.from=capgemini.com; dkim=pass header.d=capgemini.com; arc=none
Received: from VI1PR02MB6495.eurprd02.prod.outlook.com (2603:10a6:800:193::8)
 by AS1PR02MB8230.eurprd02.prod.outlook.com (2603:10a6:20b:471::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 15:20:23 +0000
Received: from VI1PR02MB6495.eurprd02.prod.outlook.com
 ([fe80::1c49:fbf5:fc0f:25b7]) by VI1PR02MB6495.eurprd02.prod.outlook.com
 ([fe80::1c49:fbf5:fc0f:25b7%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 15:20:22 +0000
From: =?utf-8?B?SG9od2lsbGVyLCBKw7ZyZw==?= <joerg.hohwiller@capgemini.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [Windows] Severe problems after upgrading to 2.48.1.windows.1
Thread-Topic: [Windows] Severe problems after upgrading to 2.48.1.windows.1
Thread-Index: AduMRF1FlKoLPIQySq6CTv27PYhTgQ==
Date: Mon, 3 Mar 2025 15:20:22 +0000
Message-ID:  <VI1PR02MB64955FD0B8A0B8C4438F605FFBC92@VI1PR02MB6495.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=capgemini.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB6495:EE_|AS1PR02MB8230:EE_
x-ms-office365-filtering-correlation-id: 1f322aa6-1018-4640-1086-08dd5a66eab1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:  BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|1580799027;
x-microsoft-antispam-message-info:  =?utf-8?B?eldaZHJ3dDNxcmxrRVJURWNIcE1CN3pYRnF0TnFkWXBUWVdyKzl1K01tQ2dT?=
 =?utf-8?B?TWYyRFd4aHNYaG5ISVRSQ0QxeHFYWVZoM2pWQjNjc3UxRDNGZFNlaDRtWDNM?=
 =?utf-8?B?STI0UFVURlhTVWRXUEZLVExYYXpHaEZKUFBpTUZZL3k0SXNRRnh4Y3FPQzJI?=
 =?utf-8?B?aER4SFBEWnJqbzdwbHZkT25GUTk4RzlSamxyQ2pWcTUrckRVN2VxanpWeFFS?=
 =?utf-8?B?NFhFKzZoVk1IeXQ3U211QzQ5VS9vS1E2Wmw2dEpBN2ZWdW5uYjRkaVpic1Ay?=
 =?utf-8?B?cXZGQkNnVlRDelhqYUlGbEFPWDZrMFZPbFZWNmw2UDF5MmtWb0tzL1ZpOFJy?=
 =?utf-8?B?dHVXWVRmQ1N2MXJxTWxRQzJualNYT3pETTF3ME9OR1AwRERZU1JiYUVCRDB1?=
 =?utf-8?B?TzhiWHNralNKUnZMWVljRnFZMExINXUyMy9hakY2UEIxOVdlcE8vZFZ6OG90?=
 =?utf-8?B?VVAwSTdDQmdUdXBDUCtxbFI3Mk9ZWmhIWjV2N01jU0cxNjFWZmpneDJhV21w?=
 =?utf-8?B?NFhxcGlRNFlXUGcxQ1R1UW13NGhYVGhhU0tFSTF0TmtaT2RUSVBMK0NCVE04?=
 =?utf-8?B?N3ZONEJvNnJadUFvWjhHNjRnRDZmcW04Z2hMVjJ3YitVcGxsYWhGY3RXaDBR?=
 =?utf-8?B?MkwxNGFFdGEvVTVKdm1xSzhKckxhdXl4OUMyQ1VDZXpXMUFEZ0c5YkNBclpz?=
 =?utf-8?B?allrY0gyZ3Z4MWR2T2VTMWl6UmNaTWJ2Z3N4QmxWaFdxYjN4OWozM2E5TFR1?=
 =?utf-8?B?UkNuUE5PYThEWjNWUEdYWTBZeThDQTFZbEZ2RUQ5bHFnQVJxOWdEQm44UHJ4?=
 =?utf-8?B?RzdWVWc0NnFkY2lMb2RpMS9ndmtaTkZUd2NjeTI3U1JJMHpkN2tETGtiUm1S?=
 =?utf-8?B?b21DR25LTnpXM0wvRmZvU1RaZ2ZJVzg4dmFhRTBlRytZd3U3bnFCUkwzNmRR?=
 =?utf-8?B?L0RLeTJXNCtmL3I5ZHozRllCUENManlPcktJNTNSZ2cydmlPQ0FZSXhpNzJy?=
 =?utf-8?B?YUFoZjRrL2dUUXkzRnFiUnUrV01BSVRHd0dieHhWaVlubzkvcC9jbmlNMDR2?=
 =?utf-8?B?MTErSjBmNWFOeDhiZDhCcG1Jc3ZiL2o5Vk1GRWdXQVdEZkxzbW9xWUVabEQz?=
 =?utf-8?B?V2xWMm0zaVJjdGlTL2dMUU03QnZ0bDFCMS9CR1FXWlJyT0JPZ2pBU3Z3NlhV?=
 =?utf-8?B?ZGpSeVJOUlkvdjF4YUs1M0Q0Q3hCVmp4NUpvWnVicU5FTWdmSzk2ZHU4Zzhj?=
 =?utf-8?B?cmlGRFNkSCtIQWx2ZkRDakpabGpZa0JpTUFMakhRcFd5bWFlV3M5emNUR2Qx?=
 =?utf-8?B?TTNnK2JJd1M0N1B4aitEanVDRHUxdUZCNkdsVkVwU2FCRlFEN1dwMUJSZ2Nm?=
 =?utf-8?B?RTJxTkM4QlFrYnJVbjAzVC9JUG5ZOVpOL21WekRPQ0V2b05OQ01za2c0V1VG?=
 =?utf-8?B?cjEwZ0JWY2VYZFZyS3RJL3YvSmtTSjdQZ3N0OGZiMk5Qdm9tWTVlSXRiRmpZ?=
 =?utf-8?B?RTJhRmlVR1VJMXpOODhQa01ocVIxaEcyaGptUFlPQVNncEcxMmE3ZS9JU245?=
 =?utf-8?B?ZmlkNnZkMHcyeWlnWVdMVm5NYm5tQzErSWhCcm5wLzAwdFFaS2hlMVNaaVpz?=
 =?utf-8?B?Lys1bkxBWjZ4RDFUUHZoK2hhWE53OWt1Z3ladHdQR0E2SmpmM0pwVWtxYmNO?=
 =?utf-8?B?ZnhkNTg2Y0NFdmduVUJmTHZwS0czazR4c25wY0RrZTZNcW1OT1Iyc1BBZnVF?=
 =?utf-8?B?aG01WXpaTGFEWGNjU2VtN2o4UFFXZnJQZS8xRXRqbTRuU2ZTWEl6Sko3aEpE?=
 =?utf-8?B?UjJOM043SXB6WkRPaGN5SmtFQXZzdHZmR2wwYjhFUnBaWVhIMjFJTVhaN29x?=
 =?utf-8?B?TjJJTkpnR1VsYmNvRGsyU1l3SjVITVllRDNoVDZDSmRqRXdTbmtZQUtnS25y?=
 =?utf-8?B?RVljNWpsdjBBTGZXRFdkY3V6OStYankvV3Y0dDhvdlZSaEpvSUk5dTMrcUJF?=
 =?utf-8?B?d1Q1bFhFYkRRPT0=?=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR02MB6495.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?N3Nobk9YT004RUNNNVV6WWlGZE40cDJ5UGhUamJ6RFlsOFJGUHg2U1NYRzZz?=
 =?utf-8?B?UTVzc0RSSUxKNWFFeEtnV1hyYXNGYVpqYndDaEZmb0NkRXdHMjhrRExwcmFY?=
 =?utf-8?B?bFM1NHU2SldmcUV3NDQ3Q0tXWmxPLzcxeTNsOFJsUStyTWhkZmVvb0UvSmxv?=
 =?utf-8?B?ZzlSS2t3N0NLSkJ3bURKVlNQRzR5MHBwY3orS0VnWkNHZCtOa1gvcGIwanNR?=
 =?utf-8?B?Y2Z5TzI1VFN2OWxrY09LK256UmtXd0pSZHBhM21xSDFDdTQ3ZHVWZXVQalY5?=
 =?utf-8?B?LzdjSDE4N3JnSDQyS2ErUXdTdktLOHBKQjcxUEdzRS9ZTVdLOEYrbTRVUXc3?=
 =?utf-8?B?eUlWcG5ucTVubWk2SGdVUm5lY3o0Zi9tZC9lTGp3ZE5PZ3ltTmsydk5sZFV0?=
 =?utf-8?B?QmgxWWtIUnFScSt3ZnhmTEp4cjdKNDduelVSOGJmS1lyMU54UklkMVlKc2ow?=
 =?utf-8?B?UHo3NlFaR1k4RkZBRCsxc3NsMG00bm9Ca2RsM0xyUjF6TnFOSTRqZ2ZabExv?=
 =?utf-8?B?cmxBdTlZMVdENmljalhkbjJGR0hKWktzUkNUNjBmNEFrTEFQR2FWVjlScEc0?=
 =?utf-8?B?S3lOR2grbVZzcUhxSVhCVVVIOEpLK0YvMWVJSGk5Y2lnK2pEM3NJK2RLbFR6?=
 =?utf-8?B?WDc3Zk9uU2loSnhhUDQrTitucVpoK3QxRHIwVEpNQks3ZklpUmlPN0YxVEpQ?=
 =?utf-8?B?NmU0MnYwNU1HLzFkR2RGWVJ3YjkrN1hpVjhwT28vUVhQVnc4WHRWc3N1Q3Nz?=
 =?utf-8?B?dTNSTGVLSGRxdzcvVDZjMHZ6aWM2aWRqZGRxdFlXWVVteGZJYXlCajByd05P?=
 =?utf-8?B?RkV2K1QxS04xemhtUldkdEl6Tnp2Ynl6dEp5U09zdG9qK3ZuQUJseERrdTVN?=
 =?utf-8?B?Y0JUOFJWemRyUmNFZEpGU3piZTJ2SHhhT3lhNzY0TVJ1QWlKUU9jVjRheWEx?=
 =?utf-8?B?cXIvT0M4MHlDajhULytnTUJuY1ZBWUlJR0VmcXFqbTdmSmdLSWR6WXU5UXo4?=
 =?utf-8?B?VnZ4OGQ1RTF2WVZFNzNLcjdsOXlLKytOemZqYkdmelBOb0lpNzJnQ0NheUlU?=
 =?utf-8?B?a0V3TGp0dWR3STlaaWxVUUgzTURCNmdGakh1cW14NDh5YVMxUEphUXFRaEdO?=
 =?utf-8?B?SWJZTk5ld2JEUU0wcXVtU0dOY25uaFlxZlIxbU1OV0JlZ3BuUEQzZysrT2Jq?=
 =?utf-8?B?Q2RpTnNpOGVsNTZnVnNmbzlQODJVWVJ0NXJtdUhTcFUrY0NUejdFZGcrR2NH?=
 =?utf-8?B?ZmQ1eEN6V002d0ZrRXhuY1h6aTAxY2psWm4wbzk2YVBHSyt5V25reG1PSnFQ?=
 =?utf-8?B?QlkrSDNUZ2dBaEtMVzRRYWMvSlBjaEdxL0htWFE0a0dGUnIwZVVlcHhzR0li?=
 =?utf-8?B?YmlVSU9vYlM0cXZqUzNEQmM3L1Z1K1J1bHVUejZBOTdTQjVpR2xNU1loNE5h?=
 =?utf-8?B?YUdWRXIyS1lEMndZRHlDSGU0ODVTMVp4akZxVUZlRWhxdWExUHdWZndIY0ZO?=
 =?utf-8?B?Z1JSbDRndm9pMVRwL1ZWMy9SbkVIU0J0Z0doK0tqMk85VnlITjgxbUNLUEhX?=
 =?utf-8?B?Y3FQMlBINjNjYnp2UnN0cmdiakh5akxLZkpyd0drVHZNTTFPNGRXa09LQzgy?=
 =?utf-8?B?NjhmZG15VlFlUWowcWV4WVY4U05CZXg1U21NUzcrYkNiZ0JxMzlJYmNIK2VL?=
 =?utf-8?B?Q3RFNjExLy9TZ29uOEtPRFZwOHRzaHVXYVdFOXZ0aUp1RDR3VHFjR1NCTkdV?=
 =?utf-8?B?OEdBc3ExWGpXMkRkblBDS09xbkxEaXNRMml6cERHR0hwU2JvdkJrRE9ncmxE?=
 =?utf-8?B?Y1MwOWN1RzlnUEhOKzluZEVzb1VNRGFtTGMvZVRMU2xQMXhpc2Q5MDNXQWlz?=
 =?utf-8?B?d0p3M1puc3JnMlV2Q0RoYng2dTJCeWVERDRKRHZVK1RQSFFuQzcrRlU4VzhQ?=
 =?utf-8?B?cUZHclNKd1lZcS9XeXdPYkdEV3VmbzY0aENjTklFNG1ZRDBMTEVkY0hYc1Rj?=
 =?utf-8?B?amJqbjFlQnM3b3U3VmxSckkvOVg5WXBENzZpN3pacU5ERTNJSksvSGJ1RzFO?=
 =?utf-8?B?VlBnc1FQNktucVJXckg4NWJaV0x0NjBLQU1wdWVzRHpJU096cHNqNTRtRFRL?=
 =?utf-8?B?aVpheWhnS1NWTDJNN2xQNGJBVnEwNWE2SUdjdEtYYi9GUHNsRHpNd2tCSnpT?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: capgemini.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB6495.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f322aa6-1018-4640-1086-08dd5a66eab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 15:20:22.6845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 76a2ae5a-9f00-4f6b-95ed-5d33d77c4d61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fj7V8d6uySbDcOflp46MJgrT+yVSYzG8Ye9JiZ4uEF4/ePRaDpvbdEOUerEqwT8sFpYbla1CTkXHameM0BGu/zBuk+ZK5P6Rq7jMT1/lxXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB8230
Content-Transfer-Encoding: base64

RGVhciBHaXQgZ3VydXMsDQoNClRoYW5rcyBmb3IgbWFraW5nIGdpdCDigJMgdGhlIGdyZWF0ZXN0
IFZDUyBldmVyIQ0KDQpJIGp1c3QgdXBncmFkZWQgdG8gMi40OC4xLndpbmRvd3MuMSAocmVpbnN0
YWxsIHZpYSBHaXQtMi40OC4xLTY0LWJpdC5leGUpLg0KQWxzbyBJIGtlcHQgdGhlIGNoZWNrYm94
IHRvIGNhY2hlIGZpbGVzIChuZXcgZmVhdHVyZT8pIOKAkyBtYXliZSBhIG1pc3Rha2UsIGxldCBz
ZWUuDQoNCkFmdGVyIHRoZSB1cGdyYWRlLCBJIHB1bGxlZCBzb21lIHJlcG8gd2l0aCBnaXQtZm9y
ayBhbmQgZ290IHRoaXMgZXJyb3I6DQplcnJvcjogY291bGQgbm90IGRlbGV0ZSByZWZlcmVuY2Vz
OiBjYW5ub3QgbG9jayByZWYgJ3JlZnMvcmVtb3Rlcy9vcmlnaW4vYnVnZml4L1hZLTc0NDg4Jzog
VW5hYmxlIHRvIGNyZWF0ZSAnRDovcHJvamVjdHMvcHJvamVjdG5hbWUvd29ya3NwYWNlcy9tYWlu
L3Byb2plY3RuYW1lLy5naXQvcmVmcy9yZW1vdGVzL29yaWdpbi9idWdmaXgvWFktNzQ0ODgubG9j
ayc6IEZpbGUgZXhpc3RzLg0KDQpJIGxvb2tlZCBsb2NhbGx5IChldmVuIGluIENNRCB3aXRoIGNv
cHkgJiBwYXN0ZSBvZiB0aGUgZXhhY3QgZmlsZSByZWZlcmVuY2UpIGJ1dCB0aGUgbG9jayBmaWxl
IGlzIE5PVCB0aGVyZS4NCkkgcmVwZWF0IHRoZSBwdWxsIGFuZCBnZXQgdGhlIHNhbWUgZXJyb3Is
IGJ1dCBubyBzdWNoIGxvY2sgZmlsZSBleGlzdHMuDQoNClRvIGF2b2lkIGV4dGVybmFsIHNpZGUt
ZWZmZWN0cyBmcm9tIGdpdC1mb3JrLCBJIG9wZW5lZCBhIG5ldyBnaXQtYmFzaCBhbmQgY2FsbGVk
IOKAnGdpdCBwdWxs4oCdIG1hbnVhbGx5IGluIHRoZSB0ZXJtaW5hbC4NClRoaXMgZGlkIG5vdCBn
aXZlIG1lIGFueSBlcnJvciBidXQgZ2F2ZSBtZSB0aGlzOg0KJCBnaXQgcHVsbA0KRnJvbSBzc2g6
Ly9naXQuY29tcGFueS5jb20vcmVwb3MvcHJvamVjdG5hbWUNCiAgIDcyNDc3ZDU3ZjAyNi4uZGU3
OWY0ZGJiZjY4ICDigKYNCiogW25ldyBicmFuY2hdIOKApg0KKiBbbmV3IGJyYW5jaF0g4oCmDQoq
IFtuZXcgYnJhbmNoXSDigKYNCiogW25ldyBicmFuY2hdIOKApg0KKiBbbmV3IGJyYW5jaF0g4oCm
DQoqIFtuZXcgYnJhbmNoXSDigKYNCiogW25ldyBicmFuY2hdIOKApg0KICAgY2UzOTc5ZDYzOWQ3
Li5iODBiNzBhNTZkYTcg4oCmDQokIGVjaG8gJD8NCjENCg0KU28gd2hhdCBjb3VsZCBiZSB0aGUg
ZXJyb3IgbGVhZGluZyB0byBleGl0IGNvZGUgMT8NCg0KQWxtb3N0IHRoZSBzYW1lIGhhcHBlbnMg
Zm9yIGdpdC1mZXRjaC4NCg0KSSBkb3duZ3JhZGVkIHRvIGdpdCB2ZXJzaW9uIDIuNDcuMS53aW5k
b3dzLjIgYW5kIGFmdGVyIHRoYXQgdHJpZWQgdGhlIHNhbWUgYWdhaW4uDQpBIGRpZmZlcmVuY2Ug
aXMgdGhhdCBub3cgSSBhZGRpdGlvbmFsbHkgSSBnZXQgbG9ncyBsaWtlIHRoaXMgYXQgdGhlIHRv
cA0KJCBnaXQgcHVsbA0KcmVtb3RlOiBFbnVtZXJhdGluZyBvYmplY3RzOiAyNjksIGRvbmUuDQpy
ZW1vdGU6IENvdW50aW5nIG9iamVjdHM6IDEwMCUgKDE0My8xNDMpLCBkb25lLg0KcmVtb3RlOiBD
b21wcmVzc2luZyBvYmplY3RzOiAxMDAlICg0MS80MSksIGRvbmUuDQpyZW1vdGU6IFRvdGFsIDI2
OSAoZGVsdGEgODkpLCByZXVzZWQgODcgKGRlbHRhIDg3KSwgcGFjay1yZXVzZWQgMTI2DQpSZWNl
aXZpbmcgb2JqZWN0czogMTAwJSAoMjY5LzI2OSksIDU5LjM3IEtpQiB8IDIuNTggTWlCL3MsIGRv
bmUuDQpSZXNvbHZpbmcgZGVsdGFzOiAxMDAlICg5NC85NCksIGNvbXBsZXRlZCB3aXRoIDUxIGxv
Y2FsIG9iamVjdHMuDQpGcm9tIHNzaDovL2dpdC5jb21wYW55LmNvbS9yZXBvcy9wcm9qZWN0bmFt
ZQ0K4oCmDQokIGVjaG8gJD8NCjENCg0KTG9va3MgZmFtaWxpYXIuIElzIGl0IGEgYnVnIG9yIGEg
ZmVhdHVyZSB0aGF0IHRoZSBsYXRlc3QgZ2l0IHN0b3BzIGxvZ2dpbmcgdGhlc2Ugc3RhdHVzIGlu
Zm9ybWF0aW9uPw0KDQpJIGhhdmUgdmFyaW91cyBvdGhlciBnaXQgcmVwb3MgdGhhdCBjb250aW51
ZSB0byB3b3JrIGZpbmUgc28gSSBub3cgcmF0aGVyIHRoaW5rIHRoYXQgdGhpcyBpcyBub3QgYSBn
ZW5lcmFsIGJ1ZyBpbiBnaXQgcHVsbC9mZXRjaCBidXQgcmVsYXRlZCB0byB0aGUgc3BlY2lmaWMg
cmVwby4NCkhvd2V2ZXIsIHRoYXQgdXNlZCB0byB3b3JrIGZvciB5ZWFycyBiZWZvcmUgSSB1cGdy
YWRlZCB0b2RheS4NCg0KU3RhdHVzIG9uIHRoYXQgcmVwbyBzYXlzOg0KJCBnaXQgc3RhdHVzDQpP
biBicmFuY2ggbWFpbg0KWW91ciBicmFuY2ggaXMgYmVoaW5kICdvcmlnaW4vbWFpbicgYnkgMzg3
IGNvbW1pdHMsIGFuZCBjYW4gYmUgZmFzdC1mb3J3YXJkZWQuDQogICh1c2UgImdpdCBwdWxsIiB0
byB1cGRhdGUgeW91ciBsb2NhbCBicmFuY2gpDQoNClVudHJhY2tlZCBmaWxlczoNCiAgKHVzZSAi
Z2l0IGFkZCA8ZmlsZT4uLi4iIHRvIGluY2x1ZGUgaW4gd2hhdCB3aWxsIGJlIGNvbW1pdHRlZCkN
CiAgICAgICAgZmluZC10ZXN0cy5zaA0KDQpub3RoaW5nIGFkZGVkIHRvIGNvbW1pdCBidXQgdW50
cmFja2VkIGZpbGVzIHByZXNlbnQgKHVzZSAiZ2l0IGFkZCIgdG8gdHJhY2spDQoNClNvcnJ5IHRv
IGJvdGhlciBidXQgZG8geW91IGhhdmUgYW55IGZ1cnRoZXIgaGludHMgb3IgaWRlYXMsIHdoYXQg
SSBjb3VsZCB0cnkgdG8gZml4IG15IHByb2JsZW0/DQoNCktpbmQgcmVnYXJkcw0KICBKw7ZyZw0K
DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQoNCkZpcm1hOiBDYXBnZW1pbmkg
RGV1dHNjaGxhbmQgR21iSA0KQXVmc2ljaHRzcmF0c3ZvcnNpdHplbmRlcjogRHIuIFZvbGttYXIg
VmFybmhhZ2VuDQpHZXNjaMOkZnRzZsO8aHJlcjogSGVucmlrIExqdW5nc3Ryw7ZtIChTcHJlY2hl
cikg4oCiIEpvc3QgRsO2cnN0ZXIg4oCiIEZlbGl6aXRhcyBHcmFlYmVyIOKAoiBWZXJhIFNjaGll
cmhvbHQNCg0KU2l0ejogQmVybGluLCBBbXRzZ2VyaWNodCBCZXJsaW4tQ2hhcmxvdHRlbmJ1cmcs
IEhSQiA5ODgxNA0KVGhpcyBtZXNzYWdlIGNvbnRhaW5zIGluZm9ybWF0aW9uIHRoYXQgbWF5IGJl
IHByaXZpbGVnZWQgb3IgY29uZmlkZW50aWFsIGFuZCBpcyB0aGUgcHJvcGVydHkgb2YgdGhlIENh
cGdlbWluaSBHcm91cC4gSXQgaXMgaW50ZW5kZWQgb25seSBmb3IgdGhlIHBlcnNvbiB0byB3aG9t
IGl0IGlzIGFkZHJlc3NlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwg
eW91IGFyZSBub3QgYXV0aG9yaXplZCB0byByZWFkLCBwcmludCwgcmV0YWluLCBjb3B5LCBkaXNz
ZW1pbmF0ZSwgZGlzdHJpYnV0ZSwgb3IgdXNlIHRoaXMgbWVzc2FnZSBvciBhbnkgcGFydCB0aGVy
ZW9mLiBJZiB5b3UgcmVjZWl2ZSB0aGlzIG1lc3NhZ2UgaW4gZXJyb3IsIHBsZWFzZSBub3RpZnkg
dGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZGVsZXRlIGFsbCBjb3BpZXMgb2YgdGhpcyBtZXNz
YWdlLgo=

