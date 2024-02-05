Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65B47A61
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707174890; cv=fail; b=s9gnsgnDIsjO+hF/BuNWXN6HOU3BOI/6V2BV19mGBqHVemuiDyXhL//0vIT+zD/UkJ0b7SGTaNT/0FimKAtroghff/B3tYYvFwK/4sl8QOEHCMgoq4DMijqPsKfVaBDSqEtRgoBplEH2ZjXOJOUVBEYHX4kbHE6O1BWRvoDQTW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707174890; c=relaxed/simple;
	bh=RtG28ek9oQlkq6eDbY+zOk5CHZ19uWKukKQ9q6bGgtE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yfpq8ASN1NH/B5e7Dsf5AuX8gIVr7d0rULX3BzbqdmsRdVapmYf6Tbox8aXokLEtQ0a+6hjCUJgkeNuOlIzb2BrP2aZdRRmrBDA1GDjN5pjfihzndf4RdCUjsY/d3yVQh2UlKyALPDV+9oFN5YXQBMSuDiCcm56pCfONFhVvHxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OcSg8bIZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oodapwoQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OcSg8bIZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oodapwoQ"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415LFko7024987;
	Mon, 5 Feb 2024 23:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=E0FfZb3W8Ny1mAYvtISMYSU2KBN7W9lbD0ZdDdutiuw=;
 b=OcSg8bIZ0T+/35j7GYOWok085nQkCE/ADQi7HNodvIeravXhPlGAN/Pgbj2BbXYGUv5C
 wAhB65ImcKd276mgJqlW4mcuPqPhtlUwTvLNUYiEHV53FCf3P3rFJvVAI4MUuIecjS7k
 Y4PJKRYXsepRf/JI6MA0vx6g8hofvUPbe04mhzoa+Aq0t6Sjqw4BbHrdXJ5qcLSvgtn4
 6NSqA/RxSMf9eDexF277ON3q4uIAt6PCTyeGy6D+JXdpF7QfBLLayWuHj25yDRloQYEj
 UE13HzudoQwr6gSwoBiobrT8lz0o/GHDVPcNMijSjyaBQQP4On+kFXd61GaKNtzuJbwg aA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c32ncvn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 23:14:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 415MHQTS036818;
	Mon, 5 Feb 2024 23:14:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6fr3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Feb 2024 23:14:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMQVkOUB4Qkhite3R5iiBActvNEJ3X6ydlgNuRArEloEXicHvZAlAQX8UtKMvNdkQVnHPVYMRBv+sKKsMjbv7ugR7N9vcnqIaxq/5OnUFUutKmRwIKzsiPe9UNgN4YyoNEGtnTmf5bXnVw45e2Ghvn4E6cpraWuAxySHrs71ik3cld0Uf12Qew+KJAkhJRB9d28xl1snvEFJ6ceAMysfOCFFyfIKoFyE+LhCk5r7+1wtpbOhLXCxDDzBSsGjWOoJ1DhdMhObSX1mRDQhNGWwEOOwhlXmlC2tZEdRPapS4+v7zLjq/9vZk4H7uxscrCeMKCTT3ClbnoJnlVKFVLxJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0FfZb3W8Ny1mAYvtISMYSU2KBN7W9lbD0ZdDdutiuw=;
 b=QM6ittYSZQyilF68FXqCTayT1i5im5gEDO5gutV4QEXqQWqxgU/VNSnuDKDfY4ulK+fVyrIzhRZzGkUmqENie2VwIhque3N5CqSG3fnwXv1cqYYivZ0z/Hp1qtPDaI6t5ubuVuxKJ7XrI7Hn6/qjgAdUToUHIpz/g5g2MWl24updCyoV9VXv3HWCrNeUq0Ce1JwpwEP2c6a4DKhutESxNQx/DxZ7gcW7ivP7e1eXzn7JALIH9phCt+jGXzb0C1DggRFL6EafgMuJYq2OPDIZt66YKvjtxTJ70B58xU12LSI/34Bk3Jc3gKovikMT2Ji+uSxgBmcVe9JwwkXMBztSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E0FfZb3W8Ny1mAYvtISMYSU2KBN7W9lbD0ZdDdutiuw=;
 b=oodapwoQl1GTM3FTD9idw0YyvymvKCnE+dxT0IDWWa8y22JDw8C93FNLAcGSABETAF+dD2djcned6HcfmfdLAqSvEZ9ML3V/TCCncT+UD+wdZoP8b4Hd4UzEXLQqrkcBpBsZztuukcS+kWee1c3GkRM5iiucJapGtlIAr0McRpM=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by IA0PR10MB7325.namprd10.prod.outlook.com (2603:10b6:208:407::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 23:14:32 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::2e34:ae4e:d7db:ab33%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 23:14:32 +0000
Message-ID: <b3ec5d0b-ac17-4d1e-a17d-d5adfbfc6ccf@oracle.com>
Date: Tue, 6 Feb 2024 00:14:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sequencer: unset GIT_CHERRY_PICK_HELP for 'exec'
 commands
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com>
 <20240205141335.762947-1-vegard.nossum@oracle.com>
 <ebe188e5-7289-4f7b-b845-d59a47cd06fe@app.fastmail.com>
 <xmqqy1bymru0.fsf@gitster.g>
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <xmqqy1bymru0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0527.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:3db::29) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|IA0PR10MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: c63ace73-649b-4ed1-f6e7-08dc26a035bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/ZpuACjC4N/w6+B/b1Uhk/BCb1r3JGNRHqmrTsAkuuvXHZ0zH926kk8cml5fe7Gn90xrVn/0ImSEMOYC/bTB9KvYFQvPyO9FNbEY6L0gBhc6FOFTs//A/3XUm2e6THpqImXwlDmIQ28GEwhryhS7PJRCjpPp/oV6MY8ip4DENKpu4NL604b2p1YxGUP5OW4T+UsoeYgRLP1N1vqjeDnMlThDgY5xcqYgy5UtwMImh2NbtK3nhqr+oi0eES7uVOe3ODeIyzgcigioP1t1fnrC5zJu8jFT8gERuYM3MR810qp1KNsIJ/rEqyYyYZDSW2Q7GVHE6p3oyKq8Sj9VFzS2YjdRMHZQM6rQ6pObMlAuU8msdsS/5JEmUtvQjDNX9e/KDymREpP+8t9mfPgpT4Eba0CnwFf2XcWS81sJjkn3S/gHFsDibVvE5fWU/UUAfUao8nN9AtXOzQ47ceUVnNjvDPkG935kw1077gNOJ9pIbap+feOxiaDUq1SN8Jcvf7/ki+3z7ixGOOR0JjZHaWTG2Sf9LGwv5BnO9oSur94y+EgXAmZrpTTkhgykEImbhtaMc5PnJT0+gSMIwJKsNhzhhIXRd9n/YJykziL+4z56h1R4dLZsXrspJ0ku2a4ri8oR8SbOn6hUZBPcPqd/icT7UibCXr999EOR7XKQgBnYLxs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(66556008)(66946007)(66476007)(316002)(110136005)(36756003)(66899024)(5660300002)(4744005)(4326008)(8936002)(8676002)(44832011)(54906003)(2906002)(83380400001)(38100700002)(31686004)(6666004)(6506007)(6512007)(53546011)(6486002)(478600001)(966005)(86362001)(31696002)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TWxla051V2NzNmI3UGszdnZsUFZZUTJkTnNveTBEWTRGblEwSm9YSXRPNGxw?=
 =?utf-8?B?VDA4ejNPNzlRczZTWGNSNDlCRjlwTCt4V1lIczZLUUFSSWJtN3I5WDJEaDRJ?=
 =?utf-8?B?b2ZEMHRGWlRUdTlKRGV6d2M4aEZSbGpIVU1ITU9yckUybmlqUnZNSG9QRzEw?=
 =?utf-8?B?MUpsclNLTXBOd0VTeWZHQWtjc014NS95a21VYXE5UTdOT1JJS2t2bHU2Uzl5?=
 =?utf-8?B?UExiRXhVOXZGQ3BxdTFqVkxtWSs0b2xKeEpZZnh0ZzR5a1ZnVFBJR0JnZ3gy?=
 =?utf-8?B?TDdGbU55aFJZUEkxS29UUFYzTGJEdU1uc0h5KzFaS2lYdUxOb3FmK2VjV3pG?=
 =?utf-8?B?UjFrVWY0cXZmVzlLbHIvVllLeEExVXVEWGhCVzBQcG9icXdLWW5OZWtna0l1?=
 =?utf-8?B?QklLVEc2dnFUaWZQZVN5Y0IyNktsaHFKTXNmM0ZtdnZhdjBKSkFGNWNWdjRr?=
 =?utf-8?B?ajAxVTZ2UENxR2w5L0ExT1oxNmRoQzUxZmptRzBrbkt4eCt3T2FsN1J6eXBE?=
 =?utf-8?B?cjJNU1ZHY1cxcGJ4QnU2YW4rVjY2b0NVejh0Q0xINGo4K0padHhHcWVQbjdp?=
 =?utf-8?B?dlJyRXNxa3hycnV1OEd1ZUtQTWVYQWFIbVVZSzNGWTVZWUp2QVRhL0dndHc1?=
 =?utf-8?B?MktLVkZxeStGdzBEWkwvemVnVXFZMmpXNUVwaVNVN2lLM3N6Qzl6UVBZYXdz?=
 =?utf-8?B?ZWJIMUpRdVNhdDFrVFcxRjIrS2pOUmtvUXdKVHQwN0g1SnV5aFVFZzdjbkZX?=
 =?utf-8?B?SUY4WnI4MUFzVlNWOVBDME5aVGZidzRJQ0FRdC9hY3pldktJdWk4T1VaMzVM?=
 =?utf-8?B?SHNUL2xjOEFjVUh2NXlxR3g4RTdjL1dzNWNWVjZhbTZLbjY2RDRub1hqbTlt?=
 =?utf-8?B?ZTlrTTRFekwwV0RGcENxd1ZSQlRuNnZsd0VxS1BDUXFTbUFmODBwN091OWla?=
 =?utf-8?B?NzdnK3BhMk10SmNwUnRmYXduQjM2bWx2M2VzRmlUQit1RGcyRmtsQmYwdTNJ?=
 =?utf-8?B?Uk5JWFM5aHhURnh6bDRVSXh0cnJMbVFCcWY4SU9WbHhlNkJMQWV4MUtkTFRm?=
 =?utf-8?B?S3h4akE2OWVxbWpZWGd4TlNDRmsyYVFQL211Yy9QRUM4K2tUZ2FCSGdwcFlt?=
 =?utf-8?B?dzV1a3hoNzBRbWZ0dGxCN0NncHhrSjFaaFRkZFdVNXNrT1ZTUkg0Y0tXOGN3?=
 =?utf-8?B?TytDTi9XQjk5VDBRTSsxOG1TT0MzWFZGMmN0amcvVlRsdjE5a3N2bUxGc3Nl?=
 =?utf-8?B?SGtpcm9GWEt3MVlvUlRLTkhpM1AvcmlpVURoUkdQUldEaWY2U09kVTEvTE5V?=
 =?utf-8?B?SnNnZklmaHg2M0RVb1VMdWVzZnVoT0pZc0ZBS2E0UXIxS0xNZVRENm5yV1dE?=
 =?utf-8?B?b0tTZGJjRzNkZDljZGg4dUFwcmx4Q3EwcG1HZ2lzbDVDU2VycklHV2FXbTdT?=
 =?utf-8?B?U1ZtWHBTQkpCMnZnK3pvKzlEYWY4YWFNM1JBdExLSFJOYWxsQ1RVMjZJM3dN?=
 =?utf-8?B?M1JrM1lIWnpkYis3eVg2d1gxYXBDRVNJcFc5SGZ2UGgrTTZTWUpvak9hbU5v?=
 =?utf-8?B?cjY3cmhYaCtiL2tJTHhvR3dDdFVhb2FmMElJQ29rUzRiR3VMWStNcytFcGVI?=
 =?utf-8?B?bXJ3aGNvNnM3eWZkSi85MDBaYTRweTM1SitIUlhCalFEYm9NN1NzWDVaN2xT?=
 =?utf-8?B?U3dDdE1YMGdVOFMxRkI3OFhzSHhWWFY2dzN2eitJYkpDZDJ1RXo3cWR6djVE?=
 =?utf-8?B?WjBuUVgvUmpMVXpSQ1U0eEk4Nk1uQVhsNzRMcjNES3dDOEZLWkNidmFHRUQ0?=
 =?utf-8?B?Rm9QY1k2V0FqM2ZxMjJ4blBVTFVLTUxabk8zL2xOUXVidnlWamhWT1RBU3Vv?=
 =?utf-8?B?SkhNcklmbUIzeDNFMGN0YUJtWmJCL0RuaVoydjI3Vmp3WVNud1FZeUVxRy9J?=
 =?utf-8?B?aEhVMURxWFNibEtvUEVqcy9MQVNnZkdHN2JFb05xbVdDUHM5LzF3ajM0dTUr?=
 =?utf-8?B?aUF6b3AyTGNiQXk5ZUNWZ3VGeEFQZjJ2Wng5eWJab0ZHemlWdld2ZnRidldC?=
 =?utf-8?B?bzNteFFPd3RqUjBYVUFtdXJlMHNUTjRwb1J5ZVNMWWx1dWQzTCt5RnMzcHJv?=
 =?utf-8?B?Y0VUU084b0NiRmFXTHJib1hqNmVMY2Q2UFVJL0tWUkRWdkk1dXIrOHBDMXV4?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cgDp/y3FGzmS3pptnp4ReTSDwYHwU+X5LdSyIP7+KzoYwo5A7hShvLp57gdESOHJlAOYcv1Y927qW1lnKQBDIAIdf4AUeLbnznXIcoY6po3jGeN5sokw8N0g0NwXMHw7y5sPiAvMAwr+9/oIqYhnWLLC1bwZzPptqVuHRkc0X5B4nN3IY07jg/V8oYutJCLA4qaxslndBpVrNDZj7I+TWF9nA61P3Q4b0TxyI9RoQMCZ4J6X1LqDfH6V9Kkk8022j/cgAgo80B3LZ1zvqyIQ1cWH9Hy7vjME/kwvBSm0RyNJC5V/HDyAySGY6en5Ni7sWdlRzDT8y7j0bMQf//nDjzUS+wAOGtlL8oM9xkjO2aBsGbF9uc43JXjBDIJDH4AFisgDGAElcP4AKw1TqtED78zC3GZyA9QG68XPMnEFfWMbkTZrOoKjQd2jo3LsMqHneurf6wKSq1RJTM8OeTXkpt2t6i9ZW+zFvIH35j2jfSg9odDnd4BetSjUoyhwwWAMXeHDCC6t6rVzWxGTI0hLKd87NQutKZy6a7+5mUh6NGvmE80M8LKmoeEqlTUIqrxroqTFgF1FsA71M6+SzDBC9wD7gaHROi5VBIgUElCx4UM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63ace73-649b-4ed1-f6e7-08dc26a035bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 23:14:31.9943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3XnubQ61kIdoqkA4hZZMcwmqJVCBmLH58yRBtOp2ei1B0OnShbExS0sQN0WqUxJ+EuLLIXSi4pcAZimvffYC63Ky8I6V0gn7WwBrkFNPNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050173
X-Proofpoint-GUID: -ehjJGwXip-aYRH26loEnLXW2gV2jSbn
X-Proofpoint-ORIG-GUID: -ehjJGwXip-aYRH26loEnLXW2gV2jSbn

On 06/02/2024 00:09, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
> 
>> On Mon, Feb 5, 2024, at 15:13, Vegard Nossum wrote:
>>> Link: https://lore.kernel.org/git/0adb1068-ef10-44ed-ad1d-e0927a09245d@gmail.com/
>>> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
>>> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
>>
>> `Link` is not really used a lot. Junio’s `refs/notes/amlog` will point
>> back to the patch (which is often close to the “suggested by” and so
>> on).
> 
> Good.  Also, is there [PATCH 1/2] that comes before this patch?

Yes, kind of -- that's the testcase at the root of the thread:

https://lore.kernel.org/git/20240202091850.160203-1-vegard.nossum@oracle.com/

("t/t3515-cherry-pick-rebase.sh: new testcase demonstrating broken 
behavior")


Vegard
