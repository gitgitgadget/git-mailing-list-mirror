Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C38AA20229
	for <e@80x24.org>; Fri, 21 Oct 2016 16:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755984AbcJUQdv (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 12:33:51 -0400
Received: from mail-bn3nam01on0127.outbound.protection.outlook.com ([104.47.33.127]:52586
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755976AbcJUQdu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 12:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zebra.onmicrosoft.com;
 s=selector1-zebra-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fIk6yf4Q4onCnkm7IEWyJjDWUsdqpVy1HKhjlJijxKw=;
 b=Rc22yDKoRUf1KDMVqwE6g8nfrxDYq16QWIXZCx0swJJzGklUpJ9iuEbmqdCm1HkbOwSkMQbphRMbptTP2g2SK9WTZb+xHScn6Ffmgsj/V6W83xkx8hfSIcV6RXMkGLXqwaWXjAzPG7UUc7CjJcsAQSsgTODh/3z+I7C+LRgrkFA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=CNP637@zebra.com; 
Received: from zama.local (140.101.111.1) by
 BLUPR03MB519.namprd03.prod.outlook.com (10.141.80.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.16; Fri, 21 Oct 2016 16:33:39 +0000
Subject: Re: Problems with "git svn clone"
To:     Eric Wong <e@80x24.org>
References: <500ef24a-55f9-1b38-52bb-17347ebaabcd@zebra.com>
 <20161019204118.GA5982@starla>
 <dea3ab60-be6b-ebcc-1047-6ab28a25979b@zebra.com>
 <20161020004956.GA8083@starla>
Cc:     git@vger.kernel.org
From:   K Richard Pixley <cnp637@zebra.com>
Organization: Zebra Technologies
Message-ID: <3ef5b7e2-5b34-e6e5-d75c-757d17ff10ce@zebra.com>
Date:   Fri, 21 Oct 2016 09:33:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:45.0)
 Gecko/20100101 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161020004956.GA8083@starla>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [140.101.111.1]
X-ClientProxiedBy: CY1PR12CA0036.namprd12.prod.outlook.com (10.160.137.46) To
 BLUPR03MB519.namprd03.prod.outlook.com (10.141.80.144)
X-MS-Office365-Filtering-Correlation-Id: b15bb9d0-a467-4ab2-822e-08d3f9d003e6
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB519;2:Bmc7lGzAAf/nrd9GN+T/b8zrTNoQfQYZy+43OC1BoJrVXWPU0NOgmbcqeWkPSsdspPVJDVMmfv4RDQEsGIniOq0zXL0vA6Kj7mBYTtQOlY53ZQWLhUuFXJA+O/WClXKGtfMrMgOmmrbzKBeaH3FynXfoUUCJPiBFsQO7+UQMZQxdzULAIEg/3inO1pec2HnChqy6seaE0uh2frzs+svl7A==;3:w7nHDB4N8N1LNxjjDzosrv24zr3awxAPE5eVDrNPiYZ8lSheIyNWOuMKqejQ57z4UIPK9oFAXlUOrrv2bnl3+/RgRNId08RNSGw9Kk7YaRh4JvJ6pPrGrS46W1YYP+ND2/xWhqIA0JR3l7R07jC7Tg==;25:PB2ClaOj4rMBAopTzbNksH3G168VntZYFpAsXXnX8flIHZHSJMAPncVm7YZUJQQH1eoUMBmtU25N8EehGcnpDqixwe5Duy2ZZlSXC2Pa54RdmYJ2g2YTJg8G5jssHxJusADgeht2MYVdUdYvlsTBf04VzWwlkWeeSIcvMkn2c7qh59tb0rk52OjajXRq8jBRsp0Uk4NPHI8uAG150GZcqtzNTrsObrlfZEEgeC8cdmueJQq6fdgyHCCmxqPHVDbGaZ5OxNhQuaqjiqgJNy4e0Ljo48j1WRQjmfWmx6Vxum3D5zBCihRiE6XqYR1ZwgRyv+MBAQZDtoeTirIeJ7YSUx9BkIJXFUx3OwQnvY6xD5oEkojbPyppCa9Kk8jOS82bLktRxlcpgNbzm0o3ycNL2tVQ8YkOtVRLzrF341olkfrTdbjCNXlnXLa9uV1Dnjn+aU3V+E6fID6X2uBZMDzOgA==
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB519;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB519;31:LUMmoAD2k1kNR1zFtb4n2G1HsZr97KJs8GhqzgYPrAR5KhydJ5l9Di94Y5BcMvW2aB8ExLsap69KLuzTd8DsYWkDmdm+6iD7U+vroWMLv0e9sFkbVsEuQbL3UwkbjofuKdbj5sJYmymR1bLS1HrDXOoYmc432mnX8pz+YHRGWGxKXSgx0bDDRzG9fsMZLd/RGoz+0RnMN7Hh5AkmGkk4CdnoEZ7ObLNjEY4Nx2S25+e9NczQ2ymu+f7GmIPGHwf/IytOy2ZstqZk/e5enwwYFw==;20:FbfsVhyHHAizP0231qMXiHcN16SCobvvCzx2k+VqXeLvGBVkzXO84oqaPMnVB0Qnpeoj+PQcz4y618iiKfly7F1zWvVfYL897pr9057QvuSWxt1P125qkg7sckQE4ipVz+9tJk3EzWgJyKeCg6zrWeqEPiOcHbDfNVoOMXUaTdPhz25idpvJH2UpcK8MYTDAK10VCAbFf3hk+tK/1vMo9KNZsuRCGOqCTorHB7vwCknTYlNQzBhw7kkYxQbuy4pi8WpJPODp+55HDQih/ocOsiO+JSQL81FsuEJeJms1h4ILHOdJY/T+ZspE/LMIELDPWlam3WFvGy70084fRqH8i8sgo6pmU1y5fSerukHVE0WyvQbAAKxl0SqWCetLezHZVQ2j+f94Ejc4ttAdUxaFQMxcisj0xs8jwTPY3v7K3EoPUlog+3dkx2hf9YZW4UosH7FbdavbyunRw6KBXC2T7xgYs0gXoeacXcgfBD7G4avl+L257kd3aQ1/gSIwrXyA
X-Microsoft-Antispam-PRVS: <BLUPR03MB51950207A8CB1C56AB6F3BA94D40@BLUPR03MB519.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040176)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046)(6055026);SRVR:BLUPR03MB519;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB519;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB519;4:wGda3NEZLHwcQyi5Xe1r7dylsbEyZ1rjwY9CTwl1dSGGb8P1WvoLWulVSPqmQWhlr9G97mxfIbW9DD6vPIFcQ8/byjQFb9VqeVSUb2phqY+rDQr0GYgVXjup4YmalChRvNKrIx8I2v+epQMP2Yp1BzWP+UAY+dkTyh2QI0UBbXwIIlUKVgio14ZqXSFgeTLsbDgRwE7dQ0rWgvw78RUHhY16L5JyMr38H9LFtkDLi3g5moipuFJTSkSgIt6Lrou7Qhz2BnHylefawS7aZq5hboSGwJR7TieowUuLq5EOneMipz5lsm3kC8hBHviEfIA3AuCBxR/51IbQt6wNvmcagUio2YvqL9H0b+okfMiCmKuwl/h73Xg0K0S+ml6FQezXgvz9cOVLzlBhNrls5kLdsMuMWFssRIAZpYQsjBBeWl0=
X-Forefront-PRVS: 01026E1310
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4630300001)(6009001)(7916002)(40124003)(189002)(199003)(5660300001)(81156014)(81166006)(305945005)(6916009)(23676002)(31696002)(101416001)(110136003)(92566002)(64126003)(50466002)(65826007)(7736002)(2950100002)(93886004)(68736007)(33646002)(7846002)(8676002)(77096005)(106356001)(6116002)(105586002)(3846002)(50986999)(189998001)(76176999)(54356999)(42186005)(83506001)(31686004)(6666003)(586003)(65806001)(2906002)(8746002)(47776003)(97736004)(36756003)(86362001)(4001350100001)(66066001)(65956001)(781001);DIR:OUT;SFP:1102;SCL:1;SRVR:BLUPR03MB519;H:zama.local;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: zebra.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjAzTUI1MTk7MjM6MmI1ckFVNmpFRUtnZ1pNR3hqZ01rNWZnMnJr?=
 =?utf-8?B?T1JPZGlXdjE1Z3l2eUNhR3pqVDlZd1JJbnVVam5Hc0cxbmNnR0JnRjdXdUt3?=
 =?utf-8?B?UlVhd0VSMWNDMnBQbDNwc2J3SDRFcnY0VWlFVkJpVFpmc3RwWTBQSFFqYkM4?=
 =?utf-8?B?WmN1VXE5aGE5dUdja0ZxTTFaeHViWFF2cm9aZGRab2w0eXppSmJ4SjFKQ0VC?=
 =?utf-8?B?WDFxalJpdW51NjJQQnIvQUFEWlhGZzVtbjBkdGZqSVVRaFpCQzJ6RW9ROElS?=
 =?utf-8?B?c1hwaFZFNjZzNG81M1Vna3hIcXp1L3ZaOFZ0R1NoK0d4MVFZOHdkeWZmSTJj?=
 =?utf-8?B?Y3BodGJTdmZEay9TcGNtV2NURU9Zb082bW9BRjlCYzRvR1VRQnhMakE3b25Z?=
 =?utf-8?B?YnNaODRkdjN1TkFKMFNhRTZZZEJNbGhGdSswNU5Na0toSitIOGMySzIzMExZ?=
 =?utf-8?B?TDF6bHBHOEx1MnBXVk1zYnNEVWJZQ0NlSnBZemZMeUhMUHl3ZjR3aDcwY211?=
 =?utf-8?B?MStSNktTOHZEZXpRZ1p5SmhlNXAzQ3FuWjlsbjhETXg0dGo4MVZYMDhKSlBv?=
 =?utf-8?B?Y2pRSGJqcmZlYzA4SEZVam9wSytSeWtuTXJPbmcwQVRxdXdJQUZacHEzRExl?=
 =?utf-8?B?aC9tRFdzNldUUVBFcVVGbzJmUHV0Q1Vkc1hYYytWVkI0RloyTjczRUhVeHJB?=
 =?utf-8?B?cDF5SlViSzNqaHdmRHpDbDN0c2NUd3hhTHdWME1tMS9HNklqcWozanJ5TjFw?=
 =?utf-8?B?NUthQlRnZE9yekxHVlZ4eGJhZ0lZTmgvOWgwb1Y1UXkxU2h6dFRVdytpTVVK?=
 =?utf-8?B?a0ZzUDFvNS9heWd4TjIvbVdkOGFsZXNwTngwM1BjaVJUZ3JNRjRvMHJud0gw?=
 =?utf-8?B?bGZwMm9hL3VBcWJEUTRia2RDMjZyQXh4ZmhFSmRnMitrdUhkOG0rbVcwQVo3?=
 =?utf-8?B?RzIvRG9waFJNQnJQNEZrNEtYRFJHVXdxSVcxeXY5SjMrU1ZoQy9CYWJrK0Vt?=
 =?utf-8?B?eTBlVnQxek51NjF2dGdjVVlrenZZUUN1LzJCVEpSajZFUTU5K21RWXhNa3NP?=
 =?utf-8?B?ZklkODQ2WkRCYkYwTEQ4cXkzZlRSbDRTdEZFK05tQVZ2aFpIKzNhcXF6MldS?=
 =?utf-8?B?aUZJZG50S1cveHN1Nm5wU3pwaUdPRy9qVUpYNEp6NzQ3ZU11T2VCYjhlUGdX?=
 =?utf-8?B?eEI2enVSanRDNzl6U2dLQU9zVGpINzVOUVlIRlNObzI2UER5SXozZWxaK3ZW?=
 =?utf-8?B?K1F1NGQrb2hlSzhzWUhXeXFMNytBdGZtMTlyYjdTa3M3QmxEQ1dIdVBwSXRU?=
 =?utf-8?B?a2t4S21JTmFaOWFpalowY0hRc0pZcXFSZ1Bhb3EvdTc3aUtLNmVJT3NlL1M2?=
 =?utf-8?B?c2w4T2JVVndxSWR0cDBycllWVXh0MXB3bVJSbXZROHViV2Y5U1JQcjd0anhK?=
 =?utf-8?B?SHNqSnJScEZQbXg3WSt4ak1KYU4wMHJsWm5IUldhRTRSUzlwNzJVdXZTMnE3?=
 =?utf-8?B?TUU1VXZSTHMwS0dsOWM4RzZ4Y2JWOG5XY09XR3RsMFA5QUM5N1ROYitoOTNy?=
 =?utf-8?B?eE9INTZMZUd6QzlJWE1SQVlKUzFWK1RUdWVSNHlLajRKaDRiUy9ROUhaQkp2?=
 =?utf-8?Q?3vAfmGz8PAJU8fsGQqF?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB519;6:M1yr/LrNIWeGrUEQeb3m0g2PfeCBSB2JK6+olVoPufLWXaj29m6szr54E2tLX0KCEovXEPjA2Lq00n9tMZBr4JbeFC1VaH0qUmKYBnK1nHHRfz3FzuBd1HStyzxLi5+AfPW2U2TLemWUePV/es5PrxMMFAq88qc26ydhoqWC13yQpuFr02btXq3JsSuC2+A2bnXLAoNLzUksnnVtF085mwD/M/OWIXnoLmLWmLWSjEn/zVUkmIa5ghfFuByGeSRW3t2uWTBOb1qgJOCm18e0JyGoi0wqQi1ZCa+vYjrI5JnCtJ2bQi+QjvD7Dn3O4Y2/QDP0TvO1g6b0h5eusu2r3TY9+ESLgDUcX43+J5yy1J8=;5:gBl+5zc3SGIQFltelHEIcQSz1HR9MZtOcqHzMT+6YdAMMmTcYSsR2BvihrEKMqSv9JoK33DRKNCssw9Sy1jkP4hC7S44WAjm5yu78c7NUwqzuDnjRh/wx3ut2V65UoO0rusZEZ171T2CCCp6o3cOGuSGDNd5SYSPo/pybKdPkMg=;24:T+Jp4V9/bvdWhnPHGpVO83C3MaDqjhTVMj3QSE+IaZT0icMpqlLvV5AE7ogMEQPY+fGU9V839Du/QKxLYdkN5PW+u1TzHo/ACF9X6TDS6CQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB519;7:R5KYeaspFoEFYwLs+FC+Kbcw1/bcRXeDHF3ySp+a915/ovTzzwtjjSeB4am2Z9xASQVnu2MUbNLQU6YmUlnbJCmpQfzlSYcYLLGqbTBpeDHpvQ5JMMgQuKXYC39b4Z+G+kKi2VWyeAAdxwYn26JQjqQqCHC4yqAkoa+M0ULlIVTBHk1F9aeeHdkJdawoYSU6QfReqid6NS26Ube3BKqloDuE4THaIIXdAZ2nzI55KfwYXAx1EGEu05H07PK15W6drNlxN1eQStSAYQKy2q2FWBpn98tDWzKeO6EBbesfiMYn/khZOM22O0tenfih8TpEB9/hOrvD1xVOnfpYXPaT/NE8YA0mOrszzFxkG8oXnVI=
X-OriginatorOrg: zebra.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2016 16:33:39.5617 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB519
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you.

Running on debian stretch/testing it got past the 11 second mark and has
been running for a day now.  I expect it will take days, perhaps longer,
so we'll see.

--rich


________________________________
- CONFIDENTIAL-

This email and any files transmitted with it are confidential, and may also=
 be legally privileged. If you are not the intended recipient, you may not =
review, use, copy, or distribute this message. If you receive this email in=
 error, please notify the sender immediately by reply email and then delete=
 this email.
