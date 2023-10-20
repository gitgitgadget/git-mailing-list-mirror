Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A41EA90
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 21:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E+0KLKW2"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3681AE8
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 14:06:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEnKpv7iMVLpM++EC7QVmjVF15hCVu0hNgEJuT32IGvMM7tpZX2atok5yJ6DnGfHNtvE8bbNY6Psjj8dZBM3Euepy+WXoXOevKAQyvvkUDptY13eVHsMlw/9O3LAr3yrcGfQYpYZDrMJZjcKI20jIq0xmlX5oaeFAKyiiqzTN2mu3vYznhOvit49wr59eC220WHOynhw+NNwejNprgQ44niWvvYC5mmuZuXM+0o5eRiLaQ78RS3hsoyVfLtR9HyQjbujeVVfYuKjT1ToGJHP+pOGMpbHMj58VtIadIMgT922yJhp/uEf0WbAKCE2O/rsSZn8gZXDdP8TiW6HXqDb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Un/skKJY9zSSHhLcZNVCCLlKhHHmKPimPps/gOmHu7g=;
 b=SVIWQYvgbybExNYGm6p9MbQ7dtW3y2PkXIdaC1y5V2K3SnA+Dl1nI82lZT9T4Ho71MIRVhUXp683iO9KQ59opZxQblZ7BMGupkXPo1dKO5ys4j3kNbRBtzIS+SiEeH44KDii4jAeMC0wrEkVmC4+kYuzg1hMAPBUgg5G70FKiwTT5KW5QlDQiXV5fVroAlIZGrKCc1YYH1qAIKkC1wTTGG16N1UptLX+bGEZdE5tNF7X9Q4qLFil+/atm4F2IM2x70X2oviqlZH0qDsVXhsmIUfbk792p4pl7IfMiutMln2SR6+3Y/i/sytpduZN4RgaOx72HEUizzRPUPXWHwcMyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un/skKJY9zSSHhLcZNVCCLlKhHHmKPimPps/gOmHu7g=;
 b=E+0KLKW2x5PVUg7Nhk5SNd7rZv6egB2fm/yJawMrXakszk1x5i6tfGTy0h1r3rHUjzonNp8T5PhMusMooPip/uTyfgsjaf6ZCru+JAnlypv1KQxPK/RWt2D6jnqZ+E8FN+tN7vnCDXrZQ1UTXhlwoHWj6+SD7a1qqoZJ1p4fO+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Fri, 20 Oct
 2023 21:06:39 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::1cfd:3535:273a:8097%7]) with mapi id 15.20.6907.021; Fri, 20 Oct 2023
 21:06:39 +0000
Message-ID: <68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com>
Date: Fri, 20 Oct 2023 17:06:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: git send-email fails with "Use of uninitialized value
 $address" + "unable to extract a valid address"
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 git@vger.kernel.org
Cc: Luben Tuikov <luben.tuikov@amd.com>, entwicklung@pengutronix.de
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
 <20231020100442.an47wwsti2d4zeyx@pengutronix.de>
From: Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <20231020100442.an47wwsti2d4zeyx@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0149.namprd04.prod.outlook.com
 (2603:10b6:408:ed::34) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 4754566a-887f-41bc-f80d-08dbd1b073c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gp061+Cs7DoTUgcOTeF9fo0zXcefNDi9OmwuqCG4rrIuglN6QcWHMI5mzGYfGU18S0D6rffywSGKZDKzkRpaZ8FyryVaBKfMsIocoXzVXquudE+3qOghdpODwac4Zlf35Qf+es5kBpVl6Q1V+RQq0AKbdSyQnDqEU5jccJKY56Fwb4MwpqURiQeg6erRtIC1IyXoOT6tdI0yWTP+VQcKBEBbeGdSjLkbDs9mB+DMYz4ztSws5ovGCyO7BM/BYDZ+6BmdIfgCvi/qyfFgkyiZwLsJrkxLNkhoNjHRDT6JBkC2kyeFD2Qdp9SITlCPQZtSB55cMcZKyhj9QPjmAuO2jd7W849aeuoLgGr3U0MAfoW2IyHiAsVL+VDVVZ9UFtj8tSX7/5PQlk6G4Nl+ioA4CBzj5zvsCVN4bGq3p8bTR8UwwR/p6xFNq9tRkEjCM+j0GsvOSqmztANZR1iXmU2X8Mu42eXycFMqSmtK+E58aRzrKUfOIs7EE4xcxLA20AZwOx5CK3b+i7x91835V+Q8MQ7PnQDfc3PQX5QkYfjYh1gxEg3QLDLHifENgy4l2zETwaxvlmpHHS23b6CjOPx1bqPum7UZboPDBq46fpKlmkOXMCx3XiyflfCE44ZZnrabSC7OcV/Mjx9KX/27JvcAEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(478600001)(316002)(66556008)(966005)(41300700001)(6486002)(8936002)(31686004)(4326008)(8676002)(66946007)(66476007)(5660300002)(44832011)(6506007)(53546011)(86362001)(6512007)(31696002)(38100700002)(26005)(2906002)(6666004)(36756003)(83380400001)(2616005)(66574015)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3dnMUVVSnJJb0l1QlhxUDlQQXUrdUdDdnl3NEorUFVndTRFeUNIV3NzaVh3?=
 =?utf-8?B?TjZGNk1Bd0ZVWFBoVnFjVVJvRzlIYjQ5ODJueWlBZkJFdUlFTU1pejAzS2dx?=
 =?utf-8?B?VUxHdlhpQjNZYldQOWNYMnF0UGsxbVRVNlU4VUZRaUNvTENUc0lmVGZMSmk0?=
 =?utf-8?B?UlozR1NaMC9iUE0wa0ltZys5OXJyb1pMSDVtWXEwdDgrR0JDTkJ1RWQ3S2JM?=
 =?utf-8?B?OHcxU0dWR3VlM3Y2RlpvRXU5Y3YwTE83d2hMdmpaVGVXUW96dUhKa1AxL21o?=
 =?utf-8?B?a0EvVUlWMWVtejhpWW9URlA5a01icjVKRTJpMTdvMTF5SXVueDhLRjM2d2Jl?=
 =?utf-8?B?QjFoU0tJMzRURXRnMHlBMVFQSEpqYVNqa2lMNXB0Q1JTNTJEM0xPT240MWtO?=
 =?utf-8?B?N1FMS2VJRC9naDFVVGg5QWxaUk5ML2k3blgxa1dOWXJMSk52OFZqRUpZekJH?=
 =?utf-8?B?d1VQZklDNnNqMmdQd0kydHZ6ZWRTRjZTaXRWWjc5djR1YnpyMHdsd3Q0Vk1r?=
 =?utf-8?B?eTB4UkdJcWJldW4wY0hEK2psV3BweEJoVHBNbXY3eGF6YUhMTmtCekxoeVJ6?=
 =?utf-8?B?MFQrd2xFTnplaVpNRWoyUlZ0aENIeG44MVBLRzluTHdLTGpVby9Fc2pPSlBN?=
 =?utf-8?B?Z25Ic0VYZkpLV0pIaHk5N0tpaUJvOWtTcC9BMVJmSVdwZnJQSDhDWEc0WGh0?=
 =?utf-8?B?YVVac25BdXQ0L3FEWFZYYUh5ZW56Tmhybk1WLzRxWlBTWUJDUTNiNkNjVTMx?=
 =?utf-8?B?ZmZWd0dPcFBlSEFrSXhTYmxmYXlRZTB2bGExcHdvc0REeGZQcERUOUtlbDFO?=
 =?utf-8?B?NGw2TTgzbWRjMlovVDFXMGFTRlFxc09kZUlOUWVSTllQaHlXaSt0aUk2TUxZ?=
 =?utf-8?B?aHhUUzVKUjBHcDByYzF2eC93bkk4L1IyekQ3SVJLdmVGbUszenZMV09xS1dX?=
 =?utf-8?B?aUNTWklBNHdXd2ZOYkdsNkYySGpXVVYvNTMvVjBwWmw3TldMc3hmbDF6aDlS?=
 =?utf-8?B?eGRjSWtXekprYkVaVzh1Nm1ObnpyYnZWK01zVnJKOUFuVGh2RjZyb1dNRjc0?=
 =?utf-8?B?Y0VtdmVIWmVIYlkrTHJOSm53RkxVekpudmpJYWh5aElaTE9Rakx1TlRGNHFG?=
 =?utf-8?B?aFZ4Tk56bFFlT0Nyb2VuT0R6bFRadGFOYVFKbUVFeDNBUlFqZWRKT1NvaXlN?=
 =?utf-8?B?K0QxOE85WENQaEc0QUswRmw2TXpRWUFGMjc5S0t5UHlDaE5CY3E1elRneHIx?=
 =?utf-8?B?QXVCU0MxSFowMzRjUmNkbjdJRUNVMUNwZkZzWldUUDg0ZlBHWGpJMFE5bHFl?=
 =?utf-8?B?RGp5NzRidG00WXc4K0trbmQ3cFYvb0o4ZmMwVnVjdzFRYTZRSnZIcXVtVzYz?=
 =?utf-8?B?RlA0eHl6NXNaUjZYY1kydkxmazF5UWRYcVhtSGdTTmh4ZEo2V1NnR0FsMit1?=
 =?utf-8?B?QnpZbTJKZFY0V3FGaDB3TWJ2STJGVjZ2NnNCRTc1azBwNThJSVpYazdDam0x?=
 =?utf-8?B?eFV3RTFYRUZucWFuUW8zblI5QS9JTFBkNUFwOXFSY2NPZFlEK3djQXZCVUdE?=
 =?utf-8?B?d2RmYkhLa25wdlNabk1OY01sNzJON3dEVmtSUCtobkN5YU5OdVl5SHJ1RkJm?=
 =?utf-8?B?NS9FUW9IalpES2VXeDVnK1V1OWNWTG41S0J6ZlBxS3lna0RmMU90TkRhRXhI?=
 =?utf-8?B?MTdaNG1zSzVUWGRVVGkxWXlWNEU2UWVCbUJVNHQzUGpQZUNGTkVzQ0FwTFQr?=
 =?utf-8?B?bTJqNndycnd4czJuWmhkMFRrT0hXY3lGc1pHN1poMEhFR2Z2Z1pVQ0twQjBB?=
 =?utf-8?B?YUNHK2ZmbEFMSVpPZEdLQ1crTklsMFRsS3RPRTBBTEg1VFlXOFZ3SmlJQXJi?=
 =?utf-8?B?aGFwZG4vMjY5ZlVkeEQ3amQrRDd6d2FEU1dFSldzR3UxQWQzYTRsY2p1Mi9w?=
 =?utf-8?B?OGV0TjRROVpIUFh4Z2piOFY4N1R3bG9RdkVuRzNoNGFEZU9BOGpXUGorTmVk?=
 =?utf-8?B?NytFMTRIZ0luR3J0NmVMU2F1cjcwYklxQ254TkZhUG1xQjJybFdTOTF1eUZT?=
 =?utf-8?B?QWdCL3lOdUZEWDRFU080S2srRFU5eE0wZ0QzWnhsQTVXVDBucVhsT204d00x?=
 =?utf-8?Q?9rYvp5IQFR7llwIZ4XWNb0UKP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4754566a-887f-41bc-f80d-08dbd1b073c5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 21:06:39.1523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWCqrCPN6ihMF9yumHzXQjANYSP68apl6b0/CYzpZBiWm0r6NHh2pNBsanotWbXV0i7/KvDbAr9lbKVDoX8jPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105

On 10/20/23 06:04, Uwe Kleine-König wrote:
> hello,
> 
> On Fri, Oct 13, 2023 at 04:14:37PM +0200, Uwe Kleine-König wrote:
>> Hello,
>>
>> 	$ git send-email --to 'A B <a@b.org>, C D <c@d.org>' lala.patch
>> 	Use of uninitialized value $address in sprintf at /usr/lib/git-core/git-send-email line 1172.
>> 	error: unable to extract a valid address from:
>>
>> This happens for me with git 2.42.0 and also on master (59167d7d09fd, "The seventeenth batch").
>>
>> Bisection points at
>>
>> 	a8022c5f7b67 ("send-email: expose header information to git-send-email's sendemail-validate hook")
>>
>> I didn't try to understand that change and fix the problem.
> 
> Another (similar?) problem with non-ascii-chars:
> 
> 	$ git send-email --to 'Will Deacon <will@kernel.org>' --to 'Krzysztof Wilczyński <kw@linux.com>' --to 'Lorenzo Pieralisi <lpieralisi@kernel.org>' --cc 'Rob Herring <robh@kernel.org>' --to 'Bjorn Helgaas <bhelgaas@google.com>' --cc 'linux-pci@vger.kernel.org' --cc kernel@pengutronix.de -1 --base=@~
> 	Use of uninitialized value $address in sprintf at /home/uwe/gsrc/git/git-send-email line 1162.
> 	error: unable to extract a valid address from:
> 
> Bisection points to the same commit, when dropping ń in Krzysztof's
> name, it works fine.
> 
This is interesting.  Thanks for reporting it.  If you are able, could you please try the patches found in the below threads:
- https://public-inbox.org/git/20230918212004.GC2163162@coredump.intra.peff.net/T/#mae64003cbb72f015bf5c0c04216524fcb6bb8d09
- https://public-inbox.org/git/f5c6a72b-f888-4d43-8be8-3ce2c878c669@gmail.com/T/#mca12dc95ccfd3ce2b94e7752ebaae9891201084f

Thanks,
Michael

> Best regards
> Uwe
> 
