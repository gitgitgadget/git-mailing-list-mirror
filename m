Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294EF3A296
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 19:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QJLXt4l5"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F8210C3
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 12:00:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMUV/Y8Kv+SvFqLZXkHQMBeOKmVA/VrRBzIHElMb/d/1PybM7LD/bQlBV0iZ553w88N0MwwSMFsBo3BOwjifMyxrYAi3IF6OgnI2GjYsue+yOx143AfENtsQx7Iwk6r9FJ+QXFPC2bQcBOwixO27qcdt7YH5fVdRx+VP6R5a6ZDuDF2KNbM38fRXOy/jccZbPww7S7Z95uHa1lFkfSo1FInjMWq1P0SfX1Adc2cAMYknN2G4i23IuO1O1PHHeYD4kPRzil4qWDvu8aAp4JFIWRBiZx1ia4iEXnuBQbsygoWpFBtpBt/BuYXXftS6n2g3AkiUscQlWY7YxVVyQ9GePg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PohcDDlvAXmLykewACP2rSluRDYI+IVXZq1/ZigCd3c=;
 b=C4QilCcw6qRWXr/9MLqpjwpnxjAf2mR5Z59T5PlQ9TmfuDDvPudcizbS2Abji/KMpGBNljMpTaC40rYRuGMl1YmFZMSENxyDv6U9/SjaM64I5rDlGDG1nvi2wlZ1LOuYVs/j3CUYO2qSSAGX5uptYGhwb4wOvy1a7uKX5IfaORdhUX11eydnXEO7BuN0xLDmyPonSJAj+Q0JEO4CUaD27ij2PZm1w1d4F8uue5AOToYgdnONAznysnHNIImUjQoF3NverTLPlq+h+FFKXBDSHh/LUEikYumXrddrxVDpgOQcpiusJPrhNyemOw5qW10X1jVxqaCX0kAwyEYhoUswRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PohcDDlvAXmLykewACP2rSluRDYI+IVXZq1/ZigCd3c=;
 b=QJLXt4l5UJa2dtZHCO5yzCkcytya9MT/xIlHVtiKamTpk363Ya4boEIRYpGmM0WlcI9tXUcCJoZaBbQOE/gEtNpjhPgUKmr9lJ6LURAZan3e9SJGfOr2U6z3kyrGcmGku1laZvu0AvUNrdElGwxaRBLm/1tByUDYbB8bRqR6RTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) by
 MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.33; Tue, 24 Oct 2023 19:00:42 +0000
Received: from DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b973:5b73:8e3a:e170]) by DM6PR12MB4356.namprd12.prod.outlook.com
 ([fe80::b973:5b73:8e3a:e170%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 19:00:42 +0000
Message-ID: <89712aea-04fc-4775-afd4-afd3ca24ad01@amd.com>
Date: Tue, 24 Oct 2023 15:00:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Regression: git send-email fails with "Use of uninitialized value
 $address" + "unable to extract a valid address"
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: git@vger.kernel.org, Luben Tuikov <luben.tuikov@amd.com>,
 entwicklung@pengutronix.de
References: <20231013141437.ywrhw65xdapmev7d@pengutronix.de>
 <20231020100442.an47wwsti2d4zeyx@pengutronix.de>
 <68d7e5c3-6b4a-4d0d-9885-f3d4e2199f26@amd.com>
 <20231024130037.sbevzk2x7oclj7d7@pengutronix.de>
From: Michael Strawbridge <michael.strawbridge@amd.com>
In-Reply-To: <20231024130037.sbevzk2x7oclj7d7@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:408:f7::29) To DM6PR12MB4356.namprd12.prod.outlook.com
 (2603:10b6:5:2aa::8)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4356:EE_|MN2PR12MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: adddfe55-0569-4bc4-014d-08dbd4c3851b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oSvayg4AroaTYmI0BnDfZPzPQGYAY7H22C+7NUiec8MNQ7td2pbF1nxW/8xlzel3JuIq5oFsLng3rkl2KkJDodBVll610gKyF0vomVIkB8EWLCgZQoH4uMyRF/D3tmCcqkBmbDE7f6rbWeNmqPqw2Rydm2e7oRMc8HjJ96D8QQdRD2kgB/mLKIhOFguT1I2aPhb/CccbNB+rubeUCO4FcBMNvVwLlkNuVMqkoSyBZpUy7jDXir8PL7Gty13+7LyZjZxI4So5SiAho4zptyn9zLFtBaoWXw34/3Kbu1nN/g9t/bDh3ieEJpFT6ba5o9OeoZqC920T1OWoWJaQZq2WGbbBMIt+LNeejKzDaYCvwkmYW2JV6P79tPW1DnocG5XJoSKy6LAsGyI5rZ9Q0cKBUR1j1594FLZxlpJA/R7EtH+ftR9cy6LPrZSxRJB42h2wiwPlfx83vNePS9I0PrL6hFHtDh3IkxnLArGAtn2aPUKTIOuLV1d1QMlRlY4Mu6RBj8wszgqLG3O3+tKUbAkg/4Ra6XbN5tcVswQb5sdrz3XmLJPZOPYUWX8scMyWSsEStMgXZ9XMDKzv3A/YCZEPo2FkHYVWAdTTIVmsFzTn6N1y2KAYxrCm8v689iLJ9w6eXDTGuGHJngJaeYIhkQj7ug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(376002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(66946007)(66556008)(66476007)(4326008)(316002)(8936002)(8676002)(19627235002)(6666004)(478600001)(6916009)(6486002)(966005)(5660300002)(41300700001)(44832011)(31696002)(86362001)(2906002)(66574015)(38100700002)(2616005)(36756003)(53546011)(6506007)(6512007)(83380400001)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjhPMS9vZ2dEZEVyeHF4bGdQUHBjZkVxS0tKbnBwU1drclVnY0lRMlVsMzhW?=
 =?utf-8?B?Sm41VjI0N0t4Y2ZiYU9RcWJGWGZKdkMvcDFZeC9YSUNRak0rc1dYenBabHQy?=
 =?utf-8?B?TjhIL1p2N1B4akpReUdvd1l0U2ZUT2M3SzlTZ1RLWHdjdHZhVGMvT093Q0Zq?=
 =?utf-8?B?bm5zZDFnN2kyZjZUZSt1WUE0T04rN21WbzVyQzF1Vi9EdEJSYzZHN1NwcXln?=
 =?utf-8?B?LzB3RFRya1IzRlgvVlhRMnRTUTNXMnFaTDIzZG5EUW5lY0p4U2N1V1Q5dXF6?=
 =?utf-8?B?RmI3azFwd2g5Rk1GWlFzWmlwbWNFWVdMVll1UmZKbzBJNFM5ajBjaVBwbDlx?=
 =?utf-8?B?RVJQYXhTZXQxM0NENUcxYnB5WElneDVST0JMSTJwdjQ5MVNMODBBVVAvY0hk?=
 =?utf-8?B?Y2pCRDNhQk1yMmFWUzNQY2pVLzZWdi90amorU2xOZzZzMFl5a1pMd0hkMkNW?=
 =?utf-8?B?K0t4amJDYjN6YlFhS0ZLTThlUGtwMFJDbHJGR3JnOWZ0eU5PVitwN2l3a2Fs?=
 =?utf-8?B?STd4WXI3azROalhwQlV0YWdmdWRoaGZoYkI5SlZSVm0yYncxSlUrYlFNVjFt?=
 =?utf-8?B?SXhaNTNxUGo0RklFUWRLRGgrZERrSzROeTV0STVscHFpZXlpTkNyR051dHhm?=
 =?utf-8?B?WEhLcXpHSmdDVVJpWjZyYmpEUkcxV3FnTS9aeW5ZTXYrNEhuWUhjS2dRd1Aw?=
 =?utf-8?B?TC9JcWx4UDJ2MXJqdDVwMnRqZjZPYWRaV2Q2OWJGYVg4Y1BuaEFFbUZTZGls?=
 =?utf-8?B?SkJoVmhxSDIwSlY5dEtJYWt6dXhDWmVpRVgxczlpeDN1WE11S3Yzb2RIMmRu?=
 =?utf-8?B?bU1YVG1ENmRqQnlvSTY5OHpHdGRzOHowYjZNNXhaTllhbU9KQ2UrYzN3aGNu?=
 =?utf-8?B?Y0RLUFBaclp2U2dySFBIZTFtUkhkcmFTTmFuWGYvd0pzblVTR3JOZlc4QjU2?=
 =?utf-8?B?UFM5WlhTbVAxdWpxS2tKUkNwajZ5MzhKNFg3UXZ4eS8xM0QxZ3JZd0ZTUGoy?=
 =?utf-8?B?OVprVHNLRWZIMElUdkRIVnpwMTFUSDY1Slc4dGoySngrcWc1bWZML05mOVBp?=
 =?utf-8?B?OHFvOHhVR0dZTU9ZRGVtN3FFSzRIUGdJZ3VDdWM0bmZ6Tmg0NmtaUTl1NDhO?=
 =?utf-8?B?dzdPZ1JnV2pnRmNWZ0ZNdGI1QWZmeFpLL2lPSGFiK1l4UHpsVVN5YXJkLzlp?=
 =?utf-8?B?MHY5ZG1SSGVZeUl2ZFBqcGh6OWpZWEV5RTBtQ1RheFNnMWVSei9qVE9JOEZu?=
 =?utf-8?B?elpaa0JGam9zek01WGVYUGRCN1YzY1ZzSnJYWTNzZGZKZFVqbWtoTkg5TS92?=
 =?utf-8?B?YXI4N0NwTE1ZU2tYdURjUlJKcGZkeFQ4OWlGeng4T1FpTE0vYVFZL1dmbXJI?=
 =?utf-8?B?RUh4SnVYT0M2SklXUnVqU1BBdm9NS1FPa0hTU2t3dktUemM0bG56VjVEeEkx?=
 =?utf-8?B?SDJDcDJQaUEwMzVJRXJMbFNmbWxIZEMyUldiQ1ZLNEF1Q2dBWklDdGVZcWR5?=
 =?utf-8?B?eEJ3NzlQQUJBbUc2eTE1RUVtYVRuVlJpSFhjUFhIK2k4RUdyUjRTVnFXejh3?=
 =?utf-8?B?anBkQjlNQ0NpUDZoMU5yQ1kyYnB4WmpMdmYvQlh5K0JzK0VhL0E2ajBZNm5v?=
 =?utf-8?B?MlhMRGpQeVdBR2NRa1M5YVZmb3FRTEV0VFJRamZHbnh3ODJFaDRNYjROMWgx?=
 =?utf-8?B?dmtzTXpWdSt1VERUYTBVdE5vdjV2WE5SeDhqamI2MllFNFZDKzFSUUFGampJ?=
 =?utf-8?B?TlRxL21JU2NtK0pPSG1OanYwQStxMXJWdWtGVjZ4eHBmZ09SMDVqaEtZWXFa?=
 =?utf-8?B?ajBxTGlhMGtyMXNGc2pKeU04NUVPdlQ2N1pLemhma1dsOHgrc3VXSjZ1cUJW?=
 =?utf-8?B?SFBBeEFZSnl1SzNMaEpya1VKWUhnb1RLeHROZkMrcG5ITFhqdjM4UGZUdVE0?=
 =?utf-8?B?WDZ3cEpEV210S0NUMlBVZ3N0U1k1K2dLcEpCYW1tVytHODJpWnUyMmMrL0w5?=
 =?utf-8?B?R1c0MHNJRVBURWVxeXZRQ1E2VkdwZDlHMjA4UjBCUjlYanI4dllTcG9ZZE03?=
 =?utf-8?B?NFc1NlhCZDdGSFltOUc5aVM4ZHB1N0c2bXB2bU9jSDI0MFZwbGt5MUVOc1Vq?=
 =?utf-8?Q?BSxf1VRdsHG0H53mVX5mup54x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adddfe55-0569-4bc4-014d-08dbd4c3851b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 19:00:42.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U4CMaaK7rTvRu9vLoDyJrNgh1LWp6+zc9NGjv5ngwslZrpOCa9Bn7Cp/l+/ObmjC6borZs6wjFY/NO6kwnC+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125



On 10/24/23 09:00, Uwe Kleine-König wrote:
> Hello,
> 
> On Fri, Oct 20, 2023 at 05:06:36PM -0400, Michael Strawbridge wrote:
>> On 10/20/23 06:04, Uwe Kleine-König wrote:
>>> hello,
>>>
>>> On Fri, Oct 13, 2023 at 04:14:37PM +0200, Uwe Kleine-König wrote:
>>>> Hello,
>>>>
>>>> 	$ git send-email --to 'A B <a@b.org>, C D <c@d.org>' lala.patch
>>>> 	Use of uninitialized value $address in sprintf at /usr/lib/git-core/git-send-email line 1172.
>>>> 	error: unable to extract a valid address from:
>>>>
>>>> This happens for me with git 2.42.0 and also on master (59167d7d09fd, "The seventeenth batch").
Hm.  I tried reproing with master (59167d7d09fd, "The seventeenth batch") but I don't seem to see an error:
```
$ git send-email --to 'Uwe Kleine-König <u.kleine-koenig@pengutronix.de>' -1 --smtp-server="$(pwd)/fake.sendmail"

/tmp/FEGzLrm_4U/0001-test-test.patch
1
(mbox) Adding cc: Your Name <you@example.com> from line 'From: Your Name <you@example.com>'
(body) Adding cc: Your Name <you@example.com> from line 'Signed-off-by: Your Name <you@example.com>'

From: Your Name <you@example.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Your Name <you@example.com>
Subject: [PATCH] test test
Date: Tue, 24 Oct 2023 18:33:51 +0000
Message-ID: <20231024183350.10-2-you@example.com>
X-Mailer: git-send-email 2.40.0.rc1.1708.gbffa95ed23.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    The Cc list above has been expanded by additional
    addresses found in the patch commit message. By default
    send-email prompts before sending whenever this occurs.
    This behavior is controlled by the sendemail.confirm
    configuration setting.

    For additional information, run 'git send-email --help'.
    To retain the current behavior, but squelch this message,
    run 'git config --global sendemail.confirm auto'.

Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
-i
OK. Log says:
Sendmail: /git/fake.sendmail -i u.kleine-koenig@pengutronix.de you@example.com
From: Your Name <you@example.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Your Name <you@example.com>
Subject: [PATCH] test test
Date: Tue, 24 Oct 2023 18:33:51 +0000
Message-ID: <20231024183350.10-2-you@example.com>
X-Mailer: git-send-email 2.40.0.rc1.1708.gbffa95ed23.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK
```

I think my terminal may be mangling the UTF-8 encoding but git send-email doesn't seem to complain.

Only when I go to an older git (version 2.42.0 for example) do I then get:

```
Use of uninitialized value $address in sprintf at /usr/lib/git-core/git-send-email line 1172.
error: unable to extract a valid address from: 
```

This would be expected because https://public-inbox.org/git/20230918212004.GC2163162@coredump.intra.peff.net/T/#mae64003cbb72f015bf5c0c04216524fcb6bb8d09
is meant to fix it.

Just in case it was the "from" address, I tried using 'Uwe Kleine-König <u.kleine-koenig@pengutronix.de>'
as the from address.  This still worked without issue for (59167d7d09fd, "The seventeenth batch").


>>>>
>>>> Bisection points at
>>>>
>>>> 	a8022c5f7b67 ("send-email: expose header information to git-send-email's sendemail-validate hook")
>>>>
>>>> I didn't try to understand that change and fix the problem.
>>>
>>> Another (similar?) problem with non-ascii-chars:
>>>
>>> 	$ git send-email --to 'Will Deacon <will@kernel.org>' --to 'Krzysztof Wilczyński <kw@linux.com>' --to 'Lorenzo Pieralisi <lpieralisi@kernel.org>' --cc 'Rob Herring <robh@kernel.org>' --to 'Bjorn Helgaas <bhelgaas@google.com>' --cc 'linux-pci@vger.kernel.org' --cc kernel@pengutronix.de -1 --base=@~
>>> 	Use of uninitialized value $address in sprintf at /home/uwe/gsrc/git/git-send-email line 1162.
>>> 	error: unable to extract a valid address from:
>>>
>>> Bisection points to the same commit, when dropping ń in Krzysztof's
>>> name, it works fine.

I tried this as well with seventeen and it succeeds:
```
/tmp/GfTxbwKSx_/0001-test-test.patch
1
(mbox) Adding cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de> from line 'From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>'
(body) Adding cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de> from line 'Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>'

From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] test test
Date: Tue, 24 Oct 2023 18:57:16 +0000
Message-ID: <20231024185715.10-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.0.rc1.1708.gbffa95ed23.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

    The Cc list above has been expanded by additional
    addresses found in the patch commit message. By default
    send-email prompts before sending whenever this occurs.
    This behavior is controlled by the sendemail.confirm
    configuration setting.

    For additional information, run 'git send-email --help'.
    To retain the current behavior, but squelch this message,
    run 'git config --global sendemail.confirm auto'.

Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): y
-i
OK. Log says:
Sendmail: /git/fake.sendmail -i will@kernel.org kw@linux.com lpieralisi@kernel.org bhelgaas@google.com robh@kernel.org linux-pci@vger.kernel.org kernel@pengutronix.de u.kleine-koenig@pengutronix.de
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Will Deacon <will@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>,
	linux-pci@vger.kernel.org,
	kernel@pengutronix.de,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] test test
Date: Tue, 24 Oct 2023 18:57:16 +0000
Message-ID: <20231024185715.10-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.0.rc1.1708.gbffa95ed23.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Result: OK
```

Perhaps there is another variable involved?

>>>
>> This is interesting.  Thanks for reporting it.  If you are able, could you please try the patches found in the below threads:
>> - https://public-inbox.org/git/20230918212004.GC2163162@coredump.intra.peff.net/T/#mae64003cbb72f015bf5c0c04216524fcb6bb8d09
> 
> On main (2e8e77cbac8a) this one is already applied, with that the error
> message reduces to:
> 
> 	$ git send-email --to 'Uwe Kleine-König <u.kleine-koenig@pengutronix.de>' -1
> 	error: unable to extract a valid address from: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
>> - https://public-inbox.org/git/f5c6a72b-f888-4d43-8be8-3ce2c878c669@gmail.com/T/#mca12dc95ccfd3ce2b94e7752ebaae9891201084f
> 
> This one doesn't help either. With it applied on top of main I get the
> sams result as on vanilla main.
> 
> Best regards
> Uwe
> 
