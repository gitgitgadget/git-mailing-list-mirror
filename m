Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F19612FB33
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708007108; cv=fail; b=KrTkINP9rJH7YybcutXX9Scqd1fhTyQOYCRA6WJTD3WUNdnjl/6abCh2S4kaY2u8Pl5ce5GpMV5fnhAXpsCpTy+xhGjRwgQ934XV17EOlwkNvMazR4impkX5JvKnJeKAzpc3ge9pyX3vzMwObYyqYmUDPU3K/dViPNl5Ydlt59c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708007108; c=relaxed/simple;
	bh=o6WTqEqt1rL9dOojYupBD8oTWjHrbTdfgplv7cISPVY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iiH3cPsoJ6VOd4JGRyaPD/UNJ8WCXoPuP66ylLXHpp/KnoLVocc7AWa6Rzws68dKF0Khb8HYaKgUu6Pzz5qAIyCJoVX391T6CV+mae/WEgtnFjVeTaFhTHmwrprcwWi7vkOhcy9cDDRDkl7j3JX2xkQVunv6qkRgPuYlaJQ5TxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VPnB0GpF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sT38EUM6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VPnB0GpF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sT38EUM6"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FD6POF028944;
	Thu, 15 Feb 2024 14:25:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uTPaDdkY2Y/m34PBNcQ12PfSHY3SF2xdoQeASri2Eq0=;
 b=VPnB0GpFNEujogJD5Zb2zBpLBvzT5yESZ0KISYTeJHDwfYjQymoei7LX2/jF3RubRc7G
 PWc5hOJZ2xfajb36miP+JY8Kx00HgVlKEACck7bxhpCBr8ruI1jNJZAno/BW4Cf2ITfl
 n2BAXE8aeSRE7Qx7JiCJy5j+qD84W+YZafEF2sYLJoJAGxxU78N4jpsd7Gb5JjZng9Yg
 xw39WaGuWQWQ5Ss3gZvZLk4DOc9SYdFt+t9WjAagrsG2OgugoD84z4ZXGHgtFwyQHNUd
 o+fPasiHJwQ9qJDAACkOzYokdvL1q6J/D9jA6XCvxl20OI0tff4VzxjRf8pDIXQLiDup Nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w92j0jaf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 14:25:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41FDgUgQ031327;
	Thu, 15 Feb 2024 14:25:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykajh9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 14:25:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqNAfPChyBubo1j/0Cp3jhaFE/TMcmEQS5oRLkHcrIKYMPKsvJaw6u9b1vj4noBS3VIf8KFOPzP/zTAHEKxN45gBpJgriZDbIDaVUOo9ITrg2aqfW797j18mUX0wdOIkuT0OIvs8FjN39vvj3fRtOEUuVADXwtn+DhXEq8pzUNpjF2GXo0NRoYTgzJMOWGB7Gc6ZHmTKbigeJnNRNUBkP/zAI5NZ4dQIGz534icrL5HU7q3TADVYsDfr8wMC3CNXDZwU9R/RklsIWtZpeym7yMC1ewnzTEphYpDsAo57g/UgPvme2fqEq2VI9nwZTiCU9Q1XKFow5BJeFoc79rhdTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTPaDdkY2Y/m34PBNcQ12PfSHY3SF2xdoQeASri2Eq0=;
 b=bFTJBNW9jbQ5Hj9gMewKUHUXDB+WERbkfEZRoYHjfNYqlb/iAImsACXW8uDK+aGTiBupDgpE+1CIk7aGQ4vRa1m1LclmyIKOTxc3hlBg+4QbLiJp6uUUwHerbREL0r7wEmnz38qhyLLG+0qRXybmXvDxzo66VW7hUq29WU0fvWeue5zBgGQbH2LFdL1OII7CB9WYH+ArIbmIS8eBFIm+iwFKnErwMXNvZoBsymXWdgYwYtZXOZHB+0NwJuLHGPO4DvgMoBNgqSNfde7m9ZmSZ+rOes7KcvK3CH2oE9IUIer62WRD96NVIytJHeDDudRdelVKaBp/ES2NHoTfhK4Ilw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTPaDdkY2Y/m34PBNcQ12PfSHY3SF2xdoQeASri2Eq0=;
 b=sT38EUM6Ko3zFbgwmyw/kGnHlLoovbmDXIMV3IGPYDVz5YTcEmO0olzxhAaCnkTPKORBKO27NSYIJC3GmXMrDnpjchcIe3VguRfIaTVPGx27ywVde5Dt2P73gewk3E1Pk5DFPzfI+BZm8y8WgyygseYN4EY8yxmnSBHxrP/nH0M=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CY8PR10MB6706.namprd10.prod.outlook.com (2603:10b6:930:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 14:24:59 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::6e32:a89a:f2b6:864b]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::6e32:a89a:f2b6:864b%2]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 14:24:59 +0000
Message-ID: <76c62133-30e4-4145-99ea-aeef644d617a@oracle.com>
Date: Thu, 15 Feb 2024 15:24:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec'
 commands
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
 <20240205141335.762947-1-vegard.nossum@oracle.com>
 <ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
 <xmqqy1bymru0.fsf@gitster.g>
 <b3ec5d0b-ac17-4d1e-a17d-d5adfbfc6ccf@oracle.com>
 <xmqqcytal01i.fsf@gitster.g> <4e6d503a-8564-4536-82a7-29c489f5fec3@gmail.com>
 <xmqq8r3wcjq2.fsf@gitster.g>
 <ae8d96b7-93b0-4460-b7ed-ffebaddd6f97@oracle.com>
 <eaf511ff-f9e0-47ac-ae2e-3de0efa928dd@gmail.com> <xmqqv86yoot3.fsf@gitster.g>
 <4073b764-ab6a-4b4b-a8a3-2e898620b2f5@gmail.com> <xmqq8r3r9biz.fsf@gitster.g>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 xsFNBE4DTU8BEADTtNncvO6rZdvTSILZHHhUnJr9Vd7N/MSx8U9z0UkAtrcgP6HPsVdsvHeU
 C6IW7L629z7CSffCXNeF8xBYnGFhCh9L9fyX/nZ2gVw/0cVDCVMwVgeXo3m8AR1iSFYvO9vC
 Rcd1fN2y+vGsJaD4JoxhKBygUtPWqUKks88NYvqyIMKgIVNQ964Qh7M+qDGY+e/BaId1OK2Z
 92jfTNE7EaIhJfHX8hW1yJKXWS54qBMqBstgLHPx8rv8AmRunsehso5nKxjtlYa/Zw5J1Uyw
 tSl+e3g/8bmCj+9+7Gj2swFlmZQwBVpVVrAR38jjEnjbKe9dQZ7c8mHHSFDflcAJlqRB2RT1
 2JA3iX/XZ0AmcOvrk62S7B4I00+kOiY6fAERPptrA19n452Non7PD5VTe2iKsOIARIkf7LvD
 q2bjzB3r41A8twtB7DUEH8Db5tbiztwy2TGLD9ga+aJJwGdy9kR5kRORNLWvqMM6Bfe9+qbw
 cJ1NXTM1RFsgCgq7U6BMEXZNcsSg9Hbs6fqDPbbZXXxn7iA4TmOhyAqgY5KCa0wm68GxMhyG
 5Q5dWfwX42/U/Zx5foyiORvEFxDBWNWc6iP1h+w8wDiiEO/UM7eH06bxRaxoMEYmcYNeEjk6
 U6qnvjUiK8A35zDOoK67t9QD35aWlNBNQ2becGk9i8fuNJKqNQARAQABzShWZWdhcmQgTm9z
 c3VtIDx2ZWdhcmQubm9zc3VtQG9yYWNsZS5jb20+wsF4BBMBAgAiBQJX+8E+AhsDBgsJCAcD
 AgYVCAIJCgsEFgIDAQIeAQIXgAAKCRALzvTY/pi6WOTDD/46kJZT/yJsYVT44e+MWvWXnzi9
 G7Tcqo1yNS5guN0d49B8ei9VvRzYpRsziaj1nAQJ8bgGJeXjNsMLMOZgx4b5OTsn8t2zIm2h
 midgIE8b3nS73uNs+9E1ktJPnHClGtTECEIIwQibpdCPYCS3lpmoAagezfcnkOqtTdgSvBg9
 FxrxKpAclgoQFTKpUoI121tvYBHmaW9K5mBM3Ty16t7IPghnndgxab+liUUZQY0TZqDG8PPW
 SuRpiVJ9buszWQvm1MUJB/MNtj1rWHivsc1Xu559PYShvJiqJF1+NCNVUx3hfXEm3evTZ9Fm
 TQJBNaeROqCToGJHjdbOdtxeSdMhaiExuSnxghqcWN+76JNXAQLlVvYhHjQwzr4me4Efo1AN
 jinz1STmmeeAMYBfHPmBNjbyNMmYBH4ETbK9XKmtkLlEPuwTXu++7zKECgsgJJJ+kvAM1OOP
 VSOKCFouq1NiuJTDwIXQf/zc1ZB8ILoY/WljE+TO/ZNmRCZl8uj03FTUzLYhR7iWdyfG5gJ/
 UfNDs/LBk596rEAtlwn0qlFUmj01B1MVeevV8JJ711S1jiRrPCXg90P3wmUUQzO0apfk1Np6
 jZVlvsnbdK/1QZaYo1kdDPEVG+TQKOgdj4wbLMBV0rh82SYM1nc6YinoXWS3EuEfRLYTf8ad
 hbkmGzrwcc7BTQROA01PARAA5+ySdsvX2RzUF6aBwtohoGYV6m2P77wn4u9uNDMD9vfcqZxj
 y9QBMKGVADLY/zoL3TJx8CYS71YNz2AsFysTdfJjNgruZW7+j2ODTrHVTNWNSpMt5yRVW426
 vN12gYjqK95c5uKNWGreP9W99T7Tj8yJe2CcoXYb6kO8hGvAHFlSYpJe+Plph5oD9llnYWpO
 XOzzuICFi4jfm0I0lvneQGd2aPK47JGHWewHn1Xk9/IwZW2InPYZat0kLlSDdiQmy/1Kv1UL
 PfzSjc9lkZqUJEXunpE0Mdp8LqowlL3rmgdoi1u4MNXurqWwPTXf1MSH537exgjqMp6tddfw
 cLAIcReIrKnN9g1+rdHfAUiHJYhEVbJACQSy9a4Z+CzUgb4RcwOQznGuzDXxnuTSuwMRxvyz
 XpDvuZazsAqB4e4p/m+42hAjE5lKBfE/p/WWewNzRRxRKvscoLcWCLg1qZ6N1pNJAh7BQdDK
 pvLaUv6zQkrlsvK2bicGXqzPVhjwX+rTghSuG3Sbsn2XdzABROgHd7ImsqzV6QQGw7eIlTD2
 MT2b9gf0f76TaTgi0kZlLpQiAGVgjNhU2Aq3xIqOFTuiGnIQN0LV9/g6KqklzOGMBYf80Pgs
 kiObHTTzSvPIT+JcdIjPcKj2+HCbgbhmrYLtGJW8Bqp/I8w2aj2nVBa7l7UAEQEAAcLBXwQY
 AQIACQUCTgNNTwIbDAAKCRALzvTY/pi6WEWzD/4rWDeWc3P0DfOv23vWgx1qboMuFLxetair
 Utae7i60PQFIVj44xG997aMjohdxxzO9oBCTxUekn31aXzTBpUbRhStq78d1hQA5Rk7nJRS6
 Nl6UtIcuLTE6Zznrq3QdQHtqwQCm1OM2F5w0ezOxbhHgt9WTrjJHact4AsN/8Aa2jmxJYrup
 aKmHqPxCVwxrrSTnx8ljisPaZWdzLQF5qmgmAqIRvX57xAuCu8O15XyZ054u73dIEYb2MBBl
 aUYwDv/4So2e2MEUymx7BF8rKDJ1LvwxKYT+X1gSdeiSambCzuEZ3SQWsVv3gn5TTCn3fHDt
 KTUL3zejji3s2V/gBXoHX7NnTNx6ZDP7It259tvWXKlUDd+spxUCF4i5fbkoQ9A0PNCwe01i
 N71y5pRS0WlFS06cvPs9lZbkAj4lDFgnOVQwmg6Smqi8gjD8rjP0GWKY24tDqd6sptX5cTDH
 pcH+LjiY61m43d8Rx+tqiUGJNUfXE/sEB+nkpL1PFWzdI1XZp4tlG6R7T9VLLf01SfeA2wgo
 9BLDRko6MK5UxPwoYDHpYiyzzAdO24dlfTphNxNcDfspLCgOW1IQ3kGoTghU7CwDtV44x4rA
 jtz7znL1XTlXp6YJQ/FWWIJfsyFvr01kTmv+/QpnAG5/iLJ+0upU1blkWmVwaEo82BU6MrS2 8A==
In-Reply-To: <xmqq8r3r9biz.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0529.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::6) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CY8PR10MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 1626535f-ea88-4a0f-efe1-08dc2e31e397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eAlz+QcrUDtNX1nPASiQgSLyDpqfHO7QtuoqC7HUOnkn0FyrMPCODhlz3BH4IYiMf3TtO8rCyvl5Qv1XQGMFRESnxfWPrr3ExaUo8XD+Q4PKiryp0eAykWAGeJKiOPjG5RcoFWPQGpm7CPDqi2V4jretarz5se7Hdbp9ToyNTbpzS6hykCuj9tq9hgxUcIFyctzzzqopFDFmf1ogoiyOozQAkeE94kWNfP3tDjcx/qVZiBR1dE8rqJzFhBcDZwcnCyHRD2iDAeqUN3uln9kObgFFXeg6TLPkxsxutFFyJXvpMDdeOJHAIM+bbbOVymE3xTInTNAUL4gkIRETYvKByDA56DVBTK65Zs83B4MoWBiBsipLFjJy8rmAYSAmrGmvv62u8fUczIPesPV91hjG/dvPbPgUX0TNCBYhKixcyo4EKdS4a+lAzvRZZDok1AVc1xcWe4tppezaOlRy+THIydUbVXqmu7pf9EyhEYtcw8viQrQd5xcvDu+XDkBhNlgTjdPXX4E3kogdold36JGzcxtuMZICbAVxNWDM7cE9wOpqtaDIci7BXzzoe3djumnT
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(4744005)(4326008)(8676002)(8936002)(5660300002)(44832011)(2906002)(38100700002)(36756003)(26005)(31696002)(86362001)(53546011)(54906003)(66556008)(66476007)(2616005)(110136005)(316002)(66946007)(6666004)(6506007)(6486002)(478600001)(6512007)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDZ5cmdKVzJOSkZPa2VkVnpMZ2JoakhIWWlkR3JXcnNKUjBlOUpNaVEyUm00?=
 =?utf-8?B?NVg5bmpNSFY4a3QzS0p2Zk5CcGNPWEZNRkR3QWpUaWhMcSswSFJUZnVkM2F0?=
 =?utf-8?B?azRwSW9qRUZnTk0yMmJGajhSYVNPVm9VYWczMG43Tjl1ZkRqZnQ5bnJBdFF5?=
 =?utf-8?B?V3VuVklkQW5xc3kxaU5RejE1YndIQnJOV3EvMSswdlpUeDVUM2FuMUo2ZSs5?=
 =?utf-8?B?YmxZSFZwV1MzdXZ2WEJLbDlZL1VkM0VJRnUxbmppN0k1WkptejBzY25MazUv?=
 =?utf-8?B?MDlsMDYyc3lHcHp2SHBMWWZhVENLQW82M0FERERUVmQ1QXdFVWVvZnVkTDk1?=
 =?utf-8?B?TG04dkFYd3Y0NEN1SitTazdpbFVSVUVKbEdRLzNrQ0tMMHVRWFd4aG1sSUUy?=
 =?utf-8?B?Mk9KQmNLT01aZ0ZhVTIyekdOV2ttMlpqRzJQK2JFZlRmRUJ4T1BXZGRibDBP?=
 =?utf-8?B?TXhLSVZIN2hTOFVxbkpKVkI1SFBsYXkra0lJWUt3SlRVcUVHRUhZNTlFR1V4?=
 =?utf-8?B?K2QwL1dJWXhzZ3pXOE1HVjRTOUZjUXZjNTlXRW53Zk5MbU92ZHE2QW04bUd6?=
 =?utf-8?B?dXF2SUZEKzRqUzVKREdVY0hKQW1DbHNORUlCcDEvNGhNWGo1OWJXb2hodVJ5?=
 =?utf-8?B?b01mVWdmRHo0ZEtaeHNOSngrUkxpSFpabUdNSXZEZ05JQkdHdHRRdHV5TWVM?=
 =?utf-8?B?dzFTRjZzcW5pTGJWT2FLQ1creVBYRUdRUi9SSUJWVy9rN3RCbnRBRmV1OTcy?=
 =?utf-8?B?empzVWJhMzdMQWxOaS9Vejl5MTA3RS90L1dwZTV3ZEF2ZDZCdFU3T2sxSnBV?=
 =?utf-8?B?U1kxRGp4Y052V1BDcWV4UWQ2Tlh5cERuM2t1eU1mUUVMSGNSd1kwM3ZDblc5?=
 =?utf-8?B?cTkwV0F5aWtmVXdDbUloeFpRSHN3VUNWOC9vQ0xOK1JETXkweU1KK0trTWVB?=
 =?utf-8?B?am1CUllkRFZsMllvZE83cVZTV01rVTllTnA4d0xlbWo0Z012Ky9FVzRoNmJC?=
 =?utf-8?B?cXk1dVIvWVBYS2E3a2NVSWZzdnorWHBDbG9jblg2cUUxcnBUZWdTeVdkSXFL?=
 =?utf-8?B?bkpOL1NtYnRyUkxWSDNReGt1dlJWL1llY1dZNjhDdjd5TTVic09TWm83eStQ?=
 =?utf-8?B?TWtncWR1ZjhjNmdWeFZXOUh1a296T21ZbFg3UEYvZzRpY2k4UGo2V1p0RkVI?=
 =?utf-8?B?SE8xWjNseTY5NmMxL0VQMEtERGpJK0VWbG5LMk1sUzluR0ZWcjBKc2h5aW9l?=
 =?utf-8?B?VVh6aTBoVkQrUy9LM2N6c0c2anY5S1ZuUDZDYmd5WENiZENjVDQvU1ZxYXk2?=
 =?utf-8?B?VGJyTlJ6NXBoRUxFQ0NsaThNT3hBV3h3Q0drU3R6VTRqMkpZeHg2d3BIWCtD?=
 =?utf-8?B?Ymc4eE1vYmY2cTQyMEJWZnMrUC9HbXMxT0RmTEJNblVkRXVxOXo4RkxLdmlF?=
 =?utf-8?B?QW9jSEZkNHZGcEl5Q0Fsa29FOXlaV1RrRzg1eDRDbXFoU2lDeXJhY3VTK05Y?=
 =?utf-8?B?Z1VnajNnWXVqdytyNmJienN5U0FNWitibGxJSHc0cnF3cklrMm5PM2tEWGFt?=
 =?utf-8?B?UWtQSFU0NWtHakNNbHI0OU44VE1PYTg0WTNDbjRoeGxaSnVoMDBoMDdUU3Vq?=
 =?utf-8?B?b01WVGd3TFdnYUtNWFk5ZVJhVjhQYVdzQTVKaGZKV3ptTmdVeFZaOG9iZFc0?=
 =?utf-8?B?UDRCbVljeDVYdm40Q1Vjd3lMdGppQ1dMZjZvMENPNFBEYThZaGo2MGhuU3dy?=
 =?utf-8?B?c0gweGlnK09XYlBqOVVtWEc2dDV3Nm94b3hwb1d6Uzl0Q3VHV0p3N0VFWWgy?=
 =?utf-8?B?U1lMNDlPR3lWaVZXNkhVWGJVOGhjY2FIYUtIYzlLVHpqVDIwOW04TmFDaGQ4?=
 =?utf-8?B?d0tYQW9sR3d4aTdHM25LQ3MrUDEvNFRvdU1sclNBZHQvK29SMzhCdGdIUlR5?=
 =?utf-8?B?Ym5JNDRRdmZENlNkVUl0YUhjcXJKa0RqYVhiOXhYcU9tcW9kbjhudDZ4M1Yx?=
 =?utf-8?B?WFJaRktTVS9lN1dLNzJ3S2JWSFUvdFlTa2ZlUkRSLzN2YXJ2V2JMSVBQTHFr?=
 =?utf-8?B?UE9GcUNhZElpM283b3k2M0xsZFNib0thTW1OYXhmY0xYZnBPajNvZWtjSG0v?=
 =?utf-8?B?MlJTazArejFDYjJwa3B1L0NmaVJ6RDNkK1BablY0ZFNQcXJrWVhJYU5QSnIz?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1jAkblPFm3Y70y/T3DbW8v4ZN/h+d6hHFiI0u6nWqxIHtpjY6UGK7bAWIOC95GZoHThk7IAnSKP5FhnAIxtpSu65XKYmmFXCIqSnDCR23y876QGoQNc1PYY2v3v21gu8LWgxEabVjW1i3SGI420ms7gLnu2Rz+wwmQWdX1Dn6ywkhThXX5PfXFfbk6XJ0e1/6Rq/2B56KRzZn9QTBm0tpFpA7ytERA3h9ccmizlNWkmR2a3ui7oGdv4OKMinVFRy20GHfqss9490Au1IG1gSkxj1ToIpWD3kAhhHDjeCq9xIMCfdwzhc/tcp07CJmdtf+hEvu+/1n+GwlgMgvsIpeLzgbZfvFDtG358RgC3Pyg2HrOSqBXrZFbDTgN+fH6ZTMA3/HuEXcNm1O0cTiU3DDzhFD/hrisxGvT2Jlv+jhyajuOGCmKgr84odCl0Ir+AU6XUjaCQrXd13TziiBf0OBRpEYfCkTeW2qcmbjWHndOF2RfbJNRWw4SGME+tksPdF1JpWL5FAMq0mXFkTvjhJf6Jzkh+Ifsi7Uyt93CHiOaM1t9AHHD4BkQl/pSrqYfTcwaBDRQnyeGbUdNVc+NVIMuOJ5lX2OruTly8UaId6K2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1626535f-ea88-4a0f-efe1-08dc2e31e397
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 14:24:58.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTxlK1ggEAbrMMOL6LdyMXkZdk/h10s+sBJpgJH7RbQRdknetZfVpy6BHye40OCfOnH22p/OdgyUEh88zm72xyKKiP1+Vf21z/ZXmy/HEzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_13,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=998 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150116
X-Proofpoint-GUID: tHMfBbLh01oHnzuZmL20Nxr0BQZ9I8os
X-Proofpoint-ORIG-GUID: tHMfBbLh01oHnzuZmL20Nxr0BQZ9I8os


On 11/02/2024 18:05, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> On 08/02/2024 17:20, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>> It might be worth explaining why this happens
>>
>> This is because rebase sets the GIT_CHERRY_PICK_HELP environment
>> variable to customize the advice given to users when there are
>> conflicts which causes the sequencer to remove CHERRY_PICK_HEAD.
> 
> True.  I'd prefer to see the original submitter assemble the pieces
> and come up with the final version, rather than me doing so.

Thanks for explaining and sorry for the delay. I saw the patch was
merged to main now, but I will keep this in mind for next time.


Vegard
