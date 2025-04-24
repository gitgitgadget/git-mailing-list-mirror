Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010002.outbound.protection.outlook.com [52.103.68.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1170628B514
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519047; cv=fail; b=bJW6RkVzIeEd7SYoszQKPUXTXri4ADWw869QShgQKqwtXVlcSAd/UWtJxmsvF6CD33AmiVQcnYgRjxxKsAY2KGN4eZjrMZ/DRKe/9HH1M+rfy6Smc3c/y2j+ER7oIVTMxoEn51D+f8cz1zsnOulaqSJFfqBAa2i5yBck9KIRHgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519047; c=relaxed/simple;
	bh=p+NElpEt20H5b3lqc5J40/YPqjw6rT8Q5Qb73jlTsfs=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bHZKRi2FacsZ1EbkQ3yREg7we5bU2UvhaD02/Jr1xeBtzDXZPx2O7S0djUEnc8IPp0rd9Hn5seUrUrYQ6ViRfuqhkMYYridV0WzE/lVvwipqOyblO+X/52EitjTRqAJANxMUIgfH3qIP8eLd/cNc150K5kbh6zTJtJ4Eyv2Oh1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=qGFA9KF/; arc=fail smtp.client-ip=52.103.68.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="qGFA9KF/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsLtit1FPvHgt7neEyyILluft72HD3Zf/8TzadzlQB7+6j2EYiW/yBQzNahHPe0W4pEuX9SgtRq/8OmqGMMD8iueBHSNTgYRFdJRIwB/qgDmud7SK4vLVt/ZsqiBKKxh+OWrGPxEwhX46yI2uz86jnmcEgPPAT4scGPnJhMP89tXIg2HYMyhJhMXNIJKgHEDj3PpulYjzih2Vul+XvIfjgb8Br/So4zUobeuaSNx/uqLJOXYtE3l+wt3kismATHWjZ6Xo1gG4oHdE3jUE589sJFBe0DjA++sUnp2X1pa6cncp5PHFdckC28U9yXH7pIVSq8Q8EbZQ2JCenGxDwJhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoqxjvAp3ADnpf0DP4MSsIQZ84xkKlNddpAGq5oUkQU=;
 b=kwQseeK8uH6I3JOhBjjbTREWqsYkNpzC8u6I+4dc2mQ3QjudhPhVusi/GTvDtONVQ2UcpedyZlgcuPtE4to7If5JzDczzA+BbLXCtEVuQcWeC1yG9De0je/JsFnLmtyP07PrHD6xxl90UzOyqE7vlIFS46SwI/g1SNzw7phm8BZRbtSF4squ+TvwPNQFXB1lNJT/Ps2zP/uv5YqI4J0xwftmmdSi3zAhWf7QybRMp+YMB1xRj4vqSTxnNuW3kfRUAiABPwp+m5mCtnQzPMZ6XsCS6x9dAcfpBXrUnP7A+pS17Hiv3JpZN3YV1zG0MKXmYWBaiOtia0he8htSOFaagA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoqxjvAp3ADnpf0DP4MSsIQZ84xkKlNddpAGq5oUkQU=;
 b=qGFA9KF/j6YLeXkVN1h54qRES6q+tWRmWJORZj/yswnXNHXS/jH87HPW76i42dCGd44wZYW8RxkBMbGINcqJhyZd7QABBzUkAi9Z6pajvYIVfJKdUydBi14cItsCaPABiXLeU4lvLfQBzxlVijz1hZFLDt7b/aSjDyW/T+cfIIPl7Lgsj4JZZwPUYgFXrgAxfBy0TT3/tb47ywZzziVobFhLOBO9MN9rtydOlTQWbU7FkbwmL+S3C9NW7LF0C74EZySqLqaEGC2HeYyaij0/kuvrjI+w7+xMLzMUTF0iByk2+X14pcO+ghIVMyDCUKnsMJmvTC7aiIzsLhsyi0uZ+g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN1PPF5423BCB81.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::413) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 18:23:59 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.038; Thu, 24 Apr 2025
 18:23:59 +0000
Message-ID:
 <PN3PR01MB9597338B9ADC246F990E9AB2B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 24 Apr 2025 23:53:56 +0530
User-Agent: Mozilla Thunderbird
From: Aditya Garg <gargaditya08@live.com>
Subject: Re: [PATCH v5 1/3] send-email: implement SMTP bearer authentication
To: Erik Huelsmann <ehuels@gmail.com>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, M Hickford <mirth.hickford@gmail.com>,
 sandals@crustytoothpaste.net, Shengyu Qu <wiagn233@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95880D1DC65D0356F93B0C55B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <CACOoB6jE=DgpYYaudhqTVDRd2SCz++aog7QYwTQs6-MAD8dBuw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CACOoB6jE=DgpYYaudhqTVDRd2SCz++aog7QYwTQs6-MAD8dBuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <df30fbef-455e-4740-a69a-d9b9b95e64d8@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN1PPF5423BCB81:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ac137a-80b1-47a3-b638-08dd835d2ec3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|461199028|19110799003|7092599003|8060799006|15080799006|10035399004|440099028|3412199025|19111999003|41001999003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0JJYjJZK2xYb25PcjhxL2R6NTcrWWZnSjZMajZnQW1HV1U2SGVDZVFaMUtG?=
 =?utf-8?B?UWNQTzhTbFJwMlRCKzhQQUN4OXd1VXNscEk4elptcTNNSEZaT2RJQ1dYVmdX?=
 =?utf-8?B?RkFzQ3hjbzlPNTN6ZXB0QUhUY0NVNnZibmxFbllxUWJ6OFNBLzRNY2loSEhq?=
 =?utf-8?B?M0lENENBQllmNzZUYnNuOHZWYll4a2Q3cmorVWhhazB6SW11dDEyb0J1cDRO?=
 =?utf-8?B?Z0N5MWIxenppTDkrMDJGNkVRVjkrZWdHVlhPbDVSSkJ3RnJKQ1ZldWZjNnhZ?=
 =?utf-8?B?VnNwc2NIaWZPWEJhbFFiZkZqajJpZTBBSGs3VWl3RDIzZ09ta3I0NzFYL0w3?=
 =?utf-8?B?a1pQWlZ0clZ1VDBGNitrdXVBbG5lSWxHZXVOaFRrMU5ZOVZzMWh3OVpRNzBz?=
 =?utf-8?B?MUx3Y0JUeTZ1TDYvK3hvY0F1VlluNG1FcXhBOUtHMUFHOWZyV3VmbXVPckdj?=
 =?utf-8?B?N1BhRFJlWDh5c0xaUnU1UTJ2RnZoZFUzS1FpT2EvY0w1MnNXdnZQbmR5M2s2?=
 =?utf-8?B?ZVlCVU54SXNpNlVLM3NkSytOQ3BWR2NvSnhrTnlLbDdTbU9URFczVFNFd0F1?=
 =?utf-8?B?L2xnNG9VZUR4R2gybGFPd2ZBNTFxUnRPVHNhY2cvU3F1YWUxRE1PS0xqVi9H?=
 =?utf-8?B?ZmorS1MxTFBKc2U1MmFwTVYvdGluR00zb0RCN0JudkNyZjF3NHh1YXluNzYw?=
 =?utf-8?B?N0sxUXZDcXpXZ2RmMlJmb0s4dSsrRTEwQk9hZS9oNDVrYzV1K0M5R2swVWlI?=
 =?utf-8?B?cSs3Mk4wSmZ0Yi9yaWhkYmJZMjNxQmVUUm43S0lGdHlReGxOVWJGL1NmWjJ1?=
 =?utf-8?B?aStNeUdtOSs0V2YreUxDRXlEdmN0eU1ITjVSQ1VaWWpmaTFLeDI1cmxBcWVp?=
 =?utf-8?B?SG1KeHhKZXZna3VtdE13bXNJSTBNVGdUUWcyRmlGOWd1TDZiNGJ2U2VSa2dG?=
 =?utf-8?B?OGM0OEJ3Rmg2RTN4R3dxVEc4clhKcElVcS9yNHZtSk5OU3FxNm1aOTJ0UDdD?=
 =?utf-8?B?RkpiMXdHQ1phMkUzbGdvQWpJMXNFamtaUEwyWHYwcXpvdVUvMzArZlY4aHhI?=
 =?utf-8?B?aVBYY0VDYVlsdncyRWZpSk5kdU04ZUFzb2JxQmQ4NXFac2ZVakc3cHpjT1p5?=
 =?utf-8?B?VnVFZCtzaklxbkI2anNrSG9yV0xNc2QwY3ptTnpMUUM3cXd4TG9OWTkxY09h?=
 =?utf-8?B?R0x3UjFISzUyWVM2alluZE1OTUxXQWwxRnl3anNDV083WlJuY1VFNUdrMjNN?=
 =?utf-8?B?RUtpa2JUQThCdG5qa1hEOEh6NTNJbmV6SXhzK3JXbFVlNWZSNTB4eUdyZTlZ?=
 =?utf-8?B?SVhxRmdQalVyK1Y3OCs4SlJUUENnKzJ1RTE1cTlXUFpaMTFwK05NUFZWU0Yr?=
 =?utf-8?B?L0pzWWlxM3ZsY3Rkd2RPcE9LTUI4OVFTMHFxYkMwYVl4OVhicUlyVU8zK3ZU?=
 =?utf-8?B?RC9FYXUzVVU4Z0FYVWVqQXREMENjbHh2NzdkbGZseWJkTi9kY2ZMekRodCtX?=
 =?utf-8?B?RjJQY24zaERxWWwxS0UwZkJIUlREc0RTSmtJV0UyZDBBV05XTWRiTWxiaXBt?=
 =?utf-8?B?Z0xva0dHZVBXbDV6dmpLR2lnaHhIZ0VFYlQ2cmluRnRxZW43YVR4clBGM3lB?=
 =?utf-8?B?MTZUQ2t1Vm5FSk53UDNrTDBTWkg3SHM4Z0pjZmY2RE1IUzlhaDlrcUF1eWhF?=
 =?utf-8?B?a0lZUzhPbGc3NmxOM25IZHo5eTd4VUl2OXZ6UTg1OVJWcVgvM0FycGV3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXN6ckk3bkdMeVBQWjBESm12Y2w0UGkzQWwzbFhZTkVMZVlSaDVVMjBLRFIv?=
 =?utf-8?B?UDVJZlJpU1FHQzdBa3VKeHFURndrMDdXMHBHWENvM3I3OWpZTmZmcHlvanUv?=
 =?utf-8?B?T29seDVXTDk5a3orcVAwdS8zUXVRUVdkUFJlU1dJSmt5NTBzQVh6MTE2V3h1?=
 =?utf-8?B?WUtvd0ZpVTBaMFpuUFJPanQ1K2VkZFlCN0tvUWp1TTgxOVMrMmZRQUNNWnd0?=
 =?utf-8?B?MXp2RFNFLzRyc1YxejZhRkk3NGRoeUVVOUdCdVMzM05rSGJBQnNkSVFNeUxa?=
 =?utf-8?B?TlVjdjBJaXppeC90ZENJNmZmZ3VsVU1UZHNTTXdTaG9RSTAxMG9xVU9pdUZS?=
 =?utf-8?B?QkttVGNUYkMxVkdVVDRvSkE0ODZCRkxJemlYK1JEUHJrYmFaZmM3bThpT3Nz?=
 =?utf-8?B?azMxQU1nK2g3RHZaTUlQbjRhdzlnRlBpbUFYc0JSWEhRRGp0SGE2N2lyMU1X?=
 =?utf-8?B?Y2dZckJRMDJ0NDdEL0llLzVzd2QrRzBhRmE2V1hNMjB0V3FWdXNnaGorT1dB?=
 =?utf-8?B?Mm5KZkVXYUQwSGFqbFBaSDdVSGk5R0VqZjFGTWZRRFlZc1J2NlZUSkU3WGhs?=
 =?utf-8?B?THg0aGZ2MmZxVXg5ajNxanY5aUhTV0xPcXBxT0J3MEtWYU1CQzgzTkMwdW5x?=
 =?utf-8?B?V0xubFM5aDdXbUZRNVJHQWg1M3JtTzZmQmNYN0RRcWQ0RU4zTjV2UngvZUdR?=
 =?utf-8?B?bzRqQ29CNnptRVRLcTMwM2J6UHk1QmNwV1J6eEdLOFh2Q1hOdWVBSWRvT1Nx?=
 =?utf-8?B?bEZmN1R2VFIzaVRhaXBTQXhXNjBrUVppN2hjWGwvcFhYS0RmaEFpSisySHZX?=
 =?utf-8?B?MFBwdno4S3Ntb1A0U0R4Y1JCT1dPL2pHUnFqODNQUENKNXQ0QUlmVk5PU2Zy?=
 =?utf-8?B?RDJQOGQ4akcrcjA5M3BSNmpqR1FPa1NQdHZqU05xVkg3V2xnQ0gvK0dhZ2Vl?=
 =?utf-8?B?aUlpNHl6SldqbkdQNU9tTzFXOGdVellISW5qeGJNOE1uOEpOQUFYMDF4ZzlS?=
 =?utf-8?B?cnVvd1NwR0V6M3FyNnlyalpsZC9VTWlMR0NFajZkL1hNSWhKbG4rWGovdVdO?=
 =?utf-8?B?ZFdUK2RmZkptNzZPVkx0S2F5RnorOFk4NjF1bUxRRStNNVEzZU40Y3YzNGx6?=
 =?utf-8?B?NHVYcitPUE0ra0FwcDhUQVU5S2J3Tm4xZFJ3RWNxUm5sWDBZdVdvdVJrQ09T?=
 =?utf-8?B?YzlWbE82MkU4Ny9jOFBDTFVOWkI4SVVvSFRlOWVEYUVIbVU3VkRuQjAyQnZY?=
 =?utf-8?B?MEgzcndKRmZVSmxqRlFtOEtvMFJoQjZMUG5vb0hRcVR0eFR5VnpUc0dZYVpp?=
 =?utf-8?B?QXRpZDkzdS9GWlJiN0tiSU1Ja2tZeUw1TXV1M1ZGRTV4TG9NVk9VNWQ5ZzJD?=
 =?utf-8?B?NzRvVWZkaXVvckJ4VXRKRmltUlBuNDQydFdqV0luQXJvQzlVdmd1ZE8wRkJZ?=
 =?utf-8?B?bWFSbi9zZEV4Y1ovbTF3b21GSTRETERTZmhxVkZtTWIzZzg1R2NTaVZBaWpG?=
 =?utf-8?B?Q3MreGE4Q1Nob3JsNHU3OEFJcGpqN005UEFJWUNCNkVxdGQyYkQxSmVVOE1J?=
 =?utf-8?B?aDRoeU4zRVBCeXdsSHJ0eHBYWnZSK3U0WWh1MktsK0JMT1dBVUQ2aGhweURp?=
 =?utf-8?B?dk5oU0EvaEV6ZnZjWWlneGNsNFk1ZTFtcHFZcjhmU1F3QnhxNHV0WnNHWFZ4?=
 =?utf-8?B?UjFFSTlPNnJHM0FQM29aYndPd05EUlJ2SC9QRzR2NFpyRHlHSGhkWklqeXhv?=
 =?utf-8?Q?WP12Jn/ZBlmvhN+NKNtgLoK8a3+iUmkxuux2XoZ?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ac137a-80b1-47a3-b638-08dd835d2ec3
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 18:23:59.8133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN1PPF5423BCB81

Hi Eric

> As I said in https://github.com/gbarr/perl-authen-sasl/issues/18#issuecomment-2453040190 <https://github.com/gbarr/perl-authen-sasl/issues/18#issuecomment-2453040190> : I'd love to implement XOAUTH2 and/or OAUTHBEARER, but I don't have a setup available to test with, so I need someone to provide a patch *and* a description of how to test, preferably against a publicly available service so I don't need to go through complex setup myself.

I saw the code of perl-authen-sasl and I miserably failed in porting the logic used here to the repo.

Perl is not something I am very strong at, so not really feasible for me to work ahead. I do was able to return the formatted base64 encoded string as per the logic, but still I got authentication issues. Currently I aim to have git-send-email working, and a review from an experienced person is needed.

I would be happy to be able to test any proposed patch though.

Julian, you might be interested here?

If you are interested, you can checkout my XOAUTH2.pm file, which doesn't authenticate for some reason.

-->8--

package Authen::SASL::Perl::XOAUTH2;

use strict;
use warnings;
use MIME::Base64;
use vars qw($VERSION @ISA);

$VERSION = "1.00";
@ISA     = qw(Authen::SASL::Perl);

my %secflags = (
    noanonymous => 1,
);

sub _order { 1 }

sub _secflags {
    shift;
    scalar grep { $secflags{$_} } @_;
}

sub mechanism { 'XOAUTH2' }

sub client_start {
    my $self = shift;
    $self->{stage} = 0;
    '';
}

sub client_step {
    my ($self, $challenge) = @_;

    my $stage = ++$self->{stage};
    if ($stage == 1) {
        # Generate the XOAUTH2 authentication string
        my $username = $self->_call('user');
        my $token    = $self->_call('pass'); # OAuth 2.0 access token
        my $auth_string = "user=$username\001auth=Bearer $token\001\001";
        my $encoded_auth_string = encode_base64($auth_string, '');

        # Send the encoded authentication string
        return $encoded_auth_string;
    } else {
        # Handle authentication failure by sending a dummy request
        my $dummy_request = encode_base64("\001", '');
        return $dummy_request;
    }
}
}

1;

__END__

=head1 NAME

Authen::SASL::Perl::XOAUTH2 - XOAUTH2 Authentication class

=head1 SYNOPSIS

  use Authen::SASL qw(Perl);

  $sasl = Authen::SASL->new(
    mechanism => 'XOAUTH2',
    callback  => {
      user => $user,
      pass => $access_token,
    },
  );

=head1 DESCRIPTION

This module implements the client side of the XOAUTH2 SASL mechanism, which is used for OAuth 2.0-based authentication.

=head2 CALLBACK

The callbacks used are:

=head3 Client

=over 4

=item user

The username to be used for authentication.

=item pass

The OAuth 2.0 access token to be used for authentication.

=back

=head1 SEE ALSO

L<Authen::SASL>,
L<MIME::Base64>

=head1 AUTHORS

Written by [Your Name].

=head1 COPYRIGHT

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

=cut

----
> 
> Please let me know who to talk to to have it added!
> 
> 
> -- 
> Bye,
> 
> Erik.
> 
> http://efficito.com <http://efficito.com/> -- Hosted accounting and ERP.
> Robust and Flexible. No vendor lock-in.

