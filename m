Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010014.outbound.protection.outlook.com [52.103.67.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473B828F507
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518986; cv=fail; b=e7TZMdU+e5xvsQtHQS/+L9o+tLEkms53pTbsk04L+LbfPJwMLABgpsBovRVQYzGX3LJ0eXPVaQUoSd3h+yvisBofq35mySImZdzUdaLOnxsuE4LFwMnW5DK8jKTVw14MnMlsgrfpzpQNxYY6Ys9hHAYNrIiFuUl0dWnTUu2KeuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518986; c=relaxed/simple;
	bh=p+NElpEt20H5b3lqc5J40/YPqjw6rT8Q5Qb73jlTsfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UqeXxk4AzPq5hgFGkyLdbRj0Lm5S0mJCgdwFqeeccfS1tcYRVKlrkjblXYE/aInFPJYSzYZO4mJq7JmOQifxrBUCVKAMUc8Na3E85eRi2Ye+NSyZbCzzquYOiIAJTpf5zCl18jV2mf1MlODDt77PsnDDLwkkoyPyDYBxbYgkaBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=RE+CnZzJ; arc=fail smtp.client-ip=52.103.67.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="RE+CnZzJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M8rj5wXkR9oWRikAJHsWr4DJL2TSArA9H/ZZ2S93x1H3s3mJu+FLd289FF8RhbPS1cV8lSmUmiRn+0f3xBTX71l1mOKAPoK50DCY7ac3m5aPgtfs/Pf9RaFVtY1m5jwrEZfczSYdvxGXz593t03JcQ2DTSqQbyPaJS7ylIed3hf2mHm++bKw2+rJ2923/8lZ1UUflfJ0SLWa/As1Q/89zJpXt26dc84cZbPs8dIgCFgCG4xpJXYwaabZT1fY4DW2g3P9RFLPQ1dQqNXPw2ks9oDNpRVP0rC92/OqKvJUrHde4U3e6VcjKlqlvAzZdi50U06XXNJpBQDdWtbLV8N74A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoqxjvAp3ADnpf0DP4MSsIQZ84xkKlNddpAGq5oUkQU=;
 b=CF1opppRj4QXpOjZ86v9BZZPuUeJ7Ml1Xn4LFf1F/DEwnKx+sSU0XO86admIsf13u4VImPu4GbRdp6eLIPoSEi0S3vl5Auu+8YDJfe3rXkm3ihOccoK5fySetOvetN0A+J/zxSphrA7qaiMQ4KykOqj64fktHmPMlVVmlg8Iab+CyL/gyPFRN7Gx0ylvfaP8VSFUtsr27bdk3abF4ZEMwHwrp18kLDicJNwRnP+QZb4PdcuBqBN7IA+6LjKRb7cFDZTU4tkdwcCs0i+VbcnGMwBz+6RkiZhBntSnOIoml7inZFw0anm9PhPL5DpocyVZe9x1xCfGkIpH2Y4vXmbxgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoqxjvAp3ADnpf0DP4MSsIQZ84xkKlNddpAGq5oUkQU=;
 b=RE+CnZzJjZ4PUDiJoKYLZ18e1NCzB/gB0P7ZCv16/LBfLPH+LLrat1y4AJJC1K9JEwu5X4libOeF+guP9EkCiUy3qbiRcl6LNUal682OV4g9yYCbpLL0BH3n5+D2qnL+WktLf/rBYyTuz13VVXSD/vD2c0U9NNuHme1a77a3MRnO5ImVockWzg3qI+5v7yR09KbwkiT7VzEmQAKcwMW1xu+TBtnO4plL8P5dLrbsu9Uw5X3kGpMstcYfkxNRxacRtR+LCd0Bgz6U7l7R2p2oT2gQQkdbrht19MkA52GZAGe06WPH9vr3N/aA7GFWBA5bHYtJG+4/QXaK5vKkm1hKKA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN1PPF5423BCB81.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::413) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 18:22:58 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.038; Thu, 24 Apr 2025
 18:22:58 +0000
Message-ID:
 <PN3PR01MB9597922F495805CA728A0B31B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 24 Apr 2025 23:52:55 +0530
User-Agent: Mozilla Thunderbird
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
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CACOoB6jE=DgpYYaudhqTVDRd2SCz++aog7QYwTQs6-MAD8dBuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::11) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <76bdaf21-95da-48ec-ac7d-0e59a3853229@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN1PPF5423BCB81:EE_
X-MS-Office365-Filtering-Correlation-Id: e686fc56-34ad-49f6-ad49-08dd835d0a38
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|461199028|19110799003|7092599003|8060799006|15080799006|10035399004|440099028|3412199025|19111999003|41001999003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SksxT0VXbmVDa21tR3A0Ly96SUozKzFwbXAvU0lUclpNYWJvY0VRekZ5T1Vr?=
 =?utf-8?B?MW82QnR6NHJSajFBNjVhQUJTbElsZXZXT1JLZUpFK0JiZ3VaK3N6UnptOERT?=
 =?utf-8?B?UjFia3JVNzA0dEhmTWF6eTg4QUtQanQyNlRQMVBjZ3ZEMUVaY1F0aThrUTdS?=
 =?utf-8?B?UGRHdEwxa0RrWDNydUVINWN1VHhhQ3lmR1RhRXJraDFheFdycHVuTHZ3S3NE?=
 =?utf-8?B?ZVcwMkd0d2ZoVXB6OXV4M2hWMkxFS243aTFyOEJHM2tRZnVSL1BmeXZkREFH?=
 =?utf-8?B?U0VGY0FLczhNUnhVY3dPWGNJL1lCUkZnd3djMUNMRUY3b3dWMS9lckxUeHZt?=
 =?utf-8?B?TGpyUUpVbVRRd2l1VUdDTXpYMjdQY01JaXJxZ0xFNkpzd2N4YWFJVDQxdGMw?=
 =?utf-8?B?dXJ4YUU4VGd6SmxQdm1wZi9pbElDcVpVNmlXOGtZTHBSd2k0OXFqZFBNWFZY?=
 =?utf-8?B?TnI5UXRod0V4ejVoZXFEMmRleUw2Z3FDV2xrdEtGeVdYQ2NBNEtVSmFWWlNV?=
 =?utf-8?B?aVlzckV1WDBUSjM5M3R5emdKZnBETi91eDBWWVpxaTl5cG94MC9uakhvdTQ5?=
 =?utf-8?B?WG11SFhDQUY1aFM0MmdNeW1heW4xV2pmMkRqSnBtWGJNdENBY1FXak1YRlQx?=
 =?utf-8?B?YXpYSkl4VmhaRUZ2NXp2SXZGT1lVank3NHorNG0rOWxsU09ndERBMWZvSWVt?=
 =?utf-8?B?YUpRV2pNMHJhcG0wd29DZi9xR1ZIMy9WZVA3K2kyaFB5WlY0THMrbmt2Tk1r?=
 =?utf-8?B?c3FxQkpPZmhxc1JzNnpXcVlzNDY2QkRJZjB1b1dxa0JRL1VUTk5Dc1puQ1RU?=
 =?utf-8?B?ckQ3V2pJRmx5Y0NuNldIY2VuS2RGaTRLcWI5bTdVbFRlZmIxb0t4WFQrdE9m?=
 =?utf-8?B?NlVGTGNmVHBxSnloUWJEK080QTA3ZWJ0aWR5L1NITVNtZjMwUlJWcGlaRjVP?=
 =?utf-8?B?ZStwZXRaTVlyTkltTGt0SUxtdm5ZMWUwK3R1VEJtOStpN0kxWGwzckZ0QVhQ?=
 =?utf-8?B?dDZQWTF1N0lUMzdjRzZmSlpLajZXeEU5emJablEyR1crSGVHcUVXOCtCUWYy?=
 =?utf-8?B?TUw5a0gzcXd1dEFHN0loNTVMbklNOEZIaDhBZllaMnJpRTN0dldBdkNrQS9I?=
 =?utf-8?B?empHQngzdWlJdkhlM1kzaVc2QjVIc1JYQ2l4WnExNk9RdHAyemFKRXdCelFn?=
 =?utf-8?B?SWtsaE42VnhuT2Fmei9JZ3BhVmIxb2ZoSC9iM2VSeDJlaTlSOVpLTStXR1BP?=
 =?utf-8?B?ZFR3MndIRWR2Q2szYlQ0dmJJcjZBYSt3Z0M4RkJrUDhERHhXbHdlODlQYzV5?=
 =?utf-8?B?K2tNRVpseHd3c0x3N2duRGk3MkZ5T0NQZjJrZWNzQitVQlBoQVE5TVg4aGFM?=
 =?utf-8?B?TGZRUENwcDQyZDZBOVFMZjYvVThsVG1SNnd6Wmd0NVArZjRLalNnQXN1WUVV?=
 =?utf-8?B?NFdVeHZjRmEyWkRGV3A1QnpCa09OVm95eTJCVis0Q2hHdVdRa3Q4eWNqZjBp?=
 =?utf-8?B?RlJiSzFaTWRYT2Q2dUhHTi9nbEN5Uk5XeXBXMTBWdk5UT3ZtVGcvMkx3REhK?=
 =?utf-8?B?Ui81aWFxLzYzUnp6OXhVa0JZRkcxTHpSSnEvYVI5TXJBQXFKc3lYU3krOG5G?=
 =?utf-8?B?UmJGbVVvOTZTUWxyTmNnZVo5cXpVbXRjdzczeThiV1R4d0NRMCs1TCtWSlNW?=
 =?utf-8?B?ei84STdmUzloRGpZdHMxWkZ1RkNTbXk1YmNHTHlaTnlMaXRBWjlKSitnPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wlh6c3graUhzZEdid1BKd2NvZ2RKeVY5QzhRTTcyMkNwN0czTUNNRXVNSnZw?=
 =?utf-8?B?Y0J3Zm55RjJxUGV3Y0V4QnRjZUU5MXVGZ1N6SnFoNE5IWEp4MGorTWVKM0NK?=
 =?utf-8?B?eGRTN1pDNXRGUjdqSWNla1RkbDE2SWw3VDBXd3NqbGtxb2NqV2hvY3p4dFl2?=
 =?utf-8?B?SVV3ejhUT1hOeE54elNmK1liZFRlUWQvT0tRN2RKWm13U0o0ZUxKaGRwdXJX?=
 =?utf-8?B?SlU1anA1WVl0aklpdDlQS3UzNGNVOCtBa0dkZG9Xcm5WbzhrUlJ5NU1nd3h5?=
 =?utf-8?B?TWpUM0dHckcyUVZwclV6cSs5cldZNjE2WEhlcTRvd2dZUE05a3YzbUROa3A5?=
 =?utf-8?B?SXNyTTRnMTdZaUc4aFdFSll5ZHBVK1dRRmNzSmhvb1BzdnBZWDNkeFhIY08y?=
 =?utf-8?B?MFJycHdEV1dDallJbUd5elAzV0c2SnlaWHNuTU13eE1lbkNaNllqNnMwYmY0?=
 =?utf-8?B?cjhKOHJobm82MTNYU3QwczhhdG51SThBdVhlSkJ0UEc1ZGRMT0lhMnNzeFI5?=
 =?utf-8?B?c1VHRzgrZjlwbEp6Smxza0ZZTCs3NktPeTgrU1dQSTFRTlJZaDk1Y3dZVkJx?=
 =?utf-8?B?cEhxUlB6ZTRDRGxIMGRudkdRYmo3Q0szbmRvcnFGMmg4aGRQcXVwTEg1c0Zv?=
 =?utf-8?B?eENaNjZFNWUrNHo0MWJmRWFPVnBEaUE3UFJGQnA4c0lHcFJUaTFUQUNQc0JN?=
 =?utf-8?B?YmszREorSDkzRTZubDJ6NUJDaERqeUFUYVJ3ZlR1K3BXaGFCWjE0Smc4NDBO?=
 =?utf-8?B?QXdqa0NlSGtOVFllN2tYNE5MNGo5elRZRXVlRUg4VHZLQTN6UTF0clJONFJk?=
 =?utf-8?B?WjIvQ296dStER2Jncmx0VEh1ZWxua3NWeXQ1a2twc0lueDhvaUZMbXBybzNq?=
 =?utf-8?B?dWhueDNBQ0ZKOWpuYXhOaW9vcDZpODc0ZHdjblE3MWVWVGhlMk5RT05jUVBX?=
 =?utf-8?B?UjhtRFRnTVNUR1k2YmVHSlZpNjlTaUZkZ2xYdWRrRGZzMjNCM3Bsa0ZsZGsz?=
 =?utf-8?B?UjJJOVZuMmlwYXVKQmlIc3lKVGliNjNoaVZoZzIyY01CbExoMFlzOUtxUEI0?=
 =?utf-8?B?L05INTFtaFV5Z1RmTnlpSWFQclJvY0NlM2doaUhhNHBId0xQeVNld09YMkRk?=
 =?utf-8?B?U2RZRk1VeTJ0QUdvdTViOGJ3THZUa3lOM1JUdGtlSFF3Y2hCcU5IaHprUnha?=
 =?utf-8?B?Tmg4d0YvVkFOaVcreXNtZGZQdHNDZ3JqY2pjY2ZwMnBKS20zSEhZS3B6d2Qz?=
 =?utf-8?B?TkcvWWR6V0d6K05xR1hrMys3VEU2RnA1Z0E5dnJ1LzlvV0RjRUltY1NPRTA4?=
 =?utf-8?B?Z0JsQVN3M0RwYWd1c3pTSW5QSWNJcStPRUk0alJISm1mbFRHWHR3enlIU0Vr?=
 =?utf-8?B?K3VJUjJXMVk4UE9namh2Zlc0RXZJYlJMcnJxWGhGajZHM3llazZuV2xuQnJL?=
 =?utf-8?B?c0l1cWkydDBQZnVVV2h0WlNrWGhHNlkxaEFSQUE3QWkvaXhaOXdPbzB0ZHJu?=
 =?utf-8?B?aTNqZFNyVnA3WE5yN1gyaEt6KzNXMlplY3NnWmp2eXRqRVpJZkFXV3liUjdv?=
 =?utf-8?B?REdoY2hCdG9JTjI3YkJ6Z3pjN2lDSE5kdG9CM0llSFB0Zjg5RXhvOE9Md3J3?=
 =?utf-8?B?dHNCeEsvMmh0azJFUVpwTWR4TENrRFVKVWNJWm5LWENmL1h2WkNDUXhtbXVY?=
 =?utf-8?B?MXRWamE4TkRqWnE4My8vcG5Ld0FZU2ROVDVoOUljQ0JTQ3pCdmNLNitHL1FM?=
 =?utf-8?Q?p9BtnQORTZ+Y2i6Ea9kM6BMtqt0LPgZhkXgXrLP?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e686fc56-34ad-49f6-ad49-08dd835d0a38
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 18:22:58.5386
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

