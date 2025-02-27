Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E252314D43D
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671506; cv=fail; b=LjOoNh6HlLv6BB+qBSE7lvFBdXrj83/P1nLx1wZwFXU5EEGcuOSmJei3JRdaHavR4G95b5Q6DnTu6mC3ig+WyD14MUI6oYUSWGkPUlxBMP/Q+ROW0XKlKswaK3BxEEwpiIcFPONBe8fHX/dkliqI0SKjxK17gmZiKXSj6Vd4Htw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671506; c=relaxed/simple;
	bh=1vfiniL0FCiJVtK0Mu83sx8vaCWyy0mEQowsGE+SiDg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A1S2LJzG7oq6frlhjEncJEHfkAV2YQOO4zNiB9gaJhnzZJd5jLm5vkhqOqnuwQ0OrZOoZ2/4dj37pbmUGXya+RsPG6s0mVsJWEHVonxnu4aWzsaqQ6RuMJgwPDwYq/51kjpg2ZrhZfuqCJUMCpqEGvTxZ3kRS6NsflAEeQrpLrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=jvhfHIMg; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="jvhfHIMg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTNp7dEIUgDdiVfRMIZmqP8FCtA/ovnTV1k/Ym1Q4Dp35I6Zh/z1nmrbtrIt6wbM8VCa4/HGnsssxmQJGajZ3Ukh4kl3aLvnyWI4BkMw2YbKa1ta0Na7W7zh5qmmvxTb2uYtYXavD/AZM8m1OhouLK5t3e1VnKnNj1j0YuC4dDTf1ZI+oEC26YTVZoRtAB2FEIBR5fPf5L9zG9wMDaN7MmTtOf8Cm5AO7xzuh6qIJf89hsSPHrHLpTvsvw1b9CJe7encb1RgDWf3DS/DXozylFkQaL/fcLtG4MoE9pemGTQpgN145YUE8DSDVbLOkckW5Y4Rwc4DE1VNPhFXRcWeig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdhZ/wlPYOul0kBrjqhF1qfcJ1akQrUFc3FLxXHqfLI=;
 b=e0BslbVUnFmmtVFrfjzKp/5ATvNuL45VlRwSbQm1hX0efhOHoTIcxF6bfMF6Fl/dVk9XdBPfS97euQpCysOZU4u6akoLhSCXxBHjX2AqV25dubn0hRKEjHKMtQB2AkSIc1i9ehxWnNsPzyGITcH0RA67U93/VO3YXX9NrL6nCD6sotKZhxqQivojGUTUPc7b9i3hB0A8z7+Zuuf/S+nZgSfb3QiE0PIpKFhsL3JIbHkWKkn0zETnTjdlzrDc978/rRtr3h8Qf5pEbSEeUmoqGgdh2v2pI4xL3HGjjLYkyxr+h+YFDy9ec1evWHtedpRTmIB5IA7n+WXfWZaHxOlkTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdhZ/wlPYOul0kBrjqhF1qfcJ1akQrUFc3FLxXHqfLI=;
 b=jvhfHIMgEfdcWKeV1Wlhvp1JqLfcBYTpLsBbCrABdcpdmPsaRidT4kWk6OqIEKxv1D9mxUv0r5Kh/+vDRTG56pNQVmE++vuBvUfpawVrovRUcsO6UUhFRK2aGvfxUGPEk69Wy8tt+TgmtC83Et0XSgjrOGASxt0RW77H7fZ+lQsI5gvMp0e4RY/ebt/GZF6k5VOPN8/jli/4BX0WdV+udoSfRUptOsxRcpo74EUuVOM2Vqp6HQgtHnahB5Gun9YKoyGzexXmIG2bjMG2iVLrTYqVUc/7o7pjatJGWOGR21QF3NS5wtWZTz2z/y0/5YzEi685JK2xvqzHZwvhVlqk/g==
Received: from MA0P287MB0641.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:114::5)
 by PN0P287MB1222.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:182::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 15:51:40 +0000
Received: from MA0P287MB0641.INDP287.PROD.OUTLOOK.COM
 ([fe80::ba42:3965:e5e5:a255]) by MA0P287MB0641.INDP287.PROD.OUTLOOK.COM
 ([fe80::ba42:3965:e5e5:a255%5]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 15:51:40 +0000
Message-ID:
 <MA0P287MB06412DF70BCDA0D99641129FE4CD2@MA0P287MB0641.INDP287.PROD.OUTLOOK.COM>
Date: Thu, 27 Feb 2025 23:51:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] upload-pack: no longer use hidden-refs as
 exclude_patterns
To: Patrick Steinhardt <ps@pks.im>,
 SURA via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.1866.git.1740660371583.gitgitgadget@gmail.com>
 <Z8B8u_d37IFOpSln@pks.im>
From: SURA <sura907@hotmail.com>
In-Reply-To: <Z8B8u_d37IFOpSln@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0418.namprd03.prod.outlook.com
 (2603:10b6:610:11b::19) To MA0P287MB0641.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:114::5)
X-Microsoft-Original-Message-ID:
 <fbc09cb4-5950-4fae-98da-d7a6cc678e85@hotmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB0641:EE_|PN0P287MB1222:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f6fe799-8e48-495b-a889-08dd57469f11
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|7092599003|8022599003|15080799006|8060799006|6090799003|12121999004|5072599009|1602099012|4302099013|3412199025|440099028|10035399004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFpVWlpyTXF3aVZwVHp3RFNTM3ZoTFVjd3QxaS9zSGs1NTRWcDdVdFRIQlhm?=
 =?utf-8?B?SThtSGlFRFA1TmdJV1FscnErdmR6Nlp1cUIrenMzMEtzUkRDb01RbkNDdVNt?=
 =?utf-8?B?UktiUk1Iakc2VldBMXNwbk1MSXJmVzJSY2RPV2hrZmtneGVERU1TK3FzUytV?=
 =?utf-8?B?VVBCMWNwQ3N1d0J6VEhtTGF5YWdReXhna2t0TFFCL0tBZis2YUVvS3BwVE1U?=
 =?utf-8?B?Ny9IOTRKSC9JKzZmaTkyd3JoRktpTlNVb2FML0x5blgraFBWa2RITHh3SlpH?=
 =?utf-8?B?a1h1RWxTRCtnWEdnV3JjbVZTNnIxeFZuMWFHTVc0UW84VlluN2RRbmZaTDBB?=
 =?utf-8?B?Y3RjMm9WYVI5ZG0xOUU0RWl4RHJHVE9VRmVUSWVWblY1eHZMaW9JYkdUcWEv?=
 =?utf-8?B?bUV0akhiM1hqQ2pJMTZiU0Z6dncvV1lVMzBVcGNBRy9lY3U3Wnk4TjZ4Y2Jj?=
 =?utf-8?B?ZkloRU05UDRIdUdOMmdvZld4Snd5OWtTaUtyTWdkcTZyZ0ptUk9Za0xDbkJk?=
 =?utf-8?B?VnU1TjFvZHVYRnNiZVZtclVCTnJRYlR1M3llMjdxRnpJdnR2bkQ2ZzRPNSt0?=
 =?utf-8?B?cGdvajhnYU41bWVyb1dienBkajRiZDVjR05hejBXZWlXZ0NCVzNNUnNHVWFO?=
 =?utf-8?B?cnV3ZnBhZk5MWExZUnZkdmE2Q0R2MDQ3WUNtZDQyVEtkd0dpZWRlK3Y3NFlD?=
 =?utf-8?B?dmpkQVN6dE1BeXJuZjRvUUVCNWFTY0J0ZkxyOUQxWnI1VXNGZXBDeVZnVlpI?=
 =?utf-8?B?RG9wK3dydDhqNGk1UWhBQmFxUEg4djRNTnpHSi9ONXpheFpGcU5zSUNpNUV4?=
 =?utf-8?B?WXhqZ0M4dDZsSEtmaEdyOWdzbldUK1dJdHhhWEN1dzRYc0drZG9QVHYrQmpZ?=
 =?utf-8?B?bTRCM1FGQkNiNHBOUjc1U0dXdXBCcjB1VU9HMGx5V0xxNld6eGFrSFlZc1lC?=
 =?utf-8?B?enRGVDIwQzhtRHMycUMwZGxyNmU5Z2k1c3BDenc4Q3g5OFFrQU5nYXU5OXhP?=
 =?utf-8?B?bkVuaG11NFRZb1Q4Q0ptYm9pWHBWelAwdXh5SzNGbDlUQzV0N2ZJQ3V2QWY2?=
 =?utf-8?B?MnFld05ZUkdVYXRIZUxIZlhaU291NUxhOFR6di9FS09OT1pzRmFrQUhocWhD?=
 =?utf-8?B?a29EamFzRjRadnNISVAvSGFrNC9qaWw3ZEgvbHB1ck10TmhMclFkQU51OEpH?=
 =?utf-8?B?M05BYUI4Q0x5QWkwUmdPRDZRV0h0SXcxWU00R2xMZis1cmU4YVBYTmhPRTVa?=
 =?utf-8?B?RTNpaUIydENLeHZOTTJlakJBUFZ3L211UjFzMnZKL0kxWU05bWdBZ1VkKzBO?=
 =?utf-8?B?bi9RalY4V2Y3QlprWXNUYVZvZkJ1R1JyMENoZ1J2N2dvUjRlQkM1Z1dCUGhK?=
 =?utf-8?B?Qzh0QTV2SGtnVU5STHNqVTZxczJpZHk4dGhsSm5XLy9kb0xpRE85TUljQ1Jw?=
 =?utf-8?B?Y3AyczRmSGNsWncrRjRTQUhnZmJOMFV4UlhSNzNKcldQbnhtTnZqZnFtNXRT?=
 =?utf-8?B?WlN6SmpIdW9heTNibTdmWE84U3cwd0tMeEVkelRIK3pYakliTWtkU3VtQTZH?=
 =?utf-8?B?Q2cvZkorSEZqN0c1cDNhM3VsSFlVYkhyU1NnSE1OL2VxODV4OUM5Mm9OS3hF?=
 =?utf-8?B?YkhCdDZBUEhDQSszODVrZTVSYU9wbmZab2FsQWJDbWZXajZIaEtxVW92WTlh?=
 =?utf-8?B?YWcwamZ3SzJYWWcrM1l2cERqb2xTdEc3R0NzaHJOdnhFVzlmd2IxNnhhc1BP?=
 =?utf-8?Q?wu61TAj1BUSQnzJGJI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YkM0K0VjdzJIdkp1OTQyWFEwN1Y2ZGhaWXNlNzlaYmxrNXpuT2VadGFaWk05?=
 =?utf-8?B?RktLOUJRRXNaWHpMdUhiNVdzN3Q5anphMEswZEhDUzZqVFZ2b21xMDNGQnpD?=
 =?utf-8?B?UUFWZzBIM0tyNFViRER3RjFJUEtxS01mTUN6aEVqaVg1akMrVWRRcVpRZ0VF?=
 =?utf-8?B?c2pVTmxRWEtuTUV4aVVROTBPMEVXVHMyTUxiVHV0eDVJUFRsdWtNT1dOZjg3?=
 =?utf-8?B?dDlLRVpLWnFFSE5UZDREengwaktVNnJpY0h5ZmtDcEN2WUNEdDUvMkoxWHRD?=
 =?utf-8?B?YlhTWmMxWC9pQUt2bWkxL281TG9iQjRpY2tpV3RRcldhUU5lK3lWaVduTXcy?=
 =?utf-8?B?NHc3d090UG5uUnB4MnAvSDg2cmZTT0Jlb2UwZFlkQWNYck5JWVh5Zjg2UzZT?=
 =?utf-8?B?dkNoUU1tUU9zVUIzSDhGdm5uRlhKaUg4cEZWb2dMcnM3UERhcFZKZ0dtL2Vp?=
 =?utf-8?B?SXNkWHFRQXBmZ0x3MFdJV0RlUzJGQko4THlmSENaZWJjaVlvajVrejA2ZmFR?=
 =?utf-8?B?WjlHaEZUa2t5cWo5Mm9ldlNrOExidWluSlYzY3BhcXlCa1Z5c2IzYjVaRW12?=
 =?utf-8?B?S2luSlU5ZzRubG1PWEV2M2d5NEtiU2gzenZYdUtaVitiWXAzTzg4dmt6cWVB?=
 =?utf-8?B?VTkvdlFqbHdqNHdVWVEyUmt1SVZSMVlIWWliNmd2ZDBDWDVCdys4OUJkV3o0?=
 =?utf-8?B?azZtQllaMkwrL0s5OU1mbVBwVG1ITENVQk55d2c1a3BMRHFpakdJY0p6NUlC?=
 =?utf-8?B?RWxoZ3lRUTJvaUx5eEJuYVppQm5qVmdWcEdWekZsRWdmbTYrY3BPZk5MdG5u?=
 =?utf-8?B?aFdEZXBlWm9LT3JMMlFBWU9veExqQzQ3ZXpwRXlPajZiUXAzZjUvcks2WUo4?=
 =?utf-8?B?TmVxY013Y01GRFZIbW9GelkyalA2eFhJZHlEbTRiY1h0Zk5UREhNYnJyNjlw?=
 =?utf-8?B?NW0xeUs4emM0aDdObTFhUlNsSndHUGdGSk5wZmFiS0F4c3ZsY041MzFNbmVp?=
 =?utf-8?B?S0wzclVMdWZNcW5qdzRBS0dxVkljYlBrSVBCUUo0RzZtMmVqa2k4c1pucTE0?=
 =?utf-8?B?Vm5BbExHM1dhdXlTcWkyOW1tWG55ekxRK0g5TmxLN3FOeVlnMGExTm9qdFo5?=
 =?utf-8?B?TDI1S0ZFVmkxdUl3RXpPWHA5b1I4SEttL2JaUFVNckxUb3RqL1ZCZjFRMnM1?=
 =?utf-8?B?QzExcGwxUHhPbjlIMmZsNWd1aFpUWitjU3RrR25jenoyU05OYklxUFAwSWlm?=
 =?utf-8?B?UmxxM3VneWo1d2wxN1JZc3MvYVZ6Tm1NeEF3ejVOcjZKYk9nS2hwelB1OE1y?=
 =?utf-8?B?QVRQaHRmSkNTSGcrQnUyUG9McjY5dkV4cFdsYUxlN01MUER3K3lZRjY3QW1Y?=
 =?utf-8?B?dXFJRUxUM2VXK0gyZlJBWWhIYTZDRGtFYVRudTJkaW92Ky8weUk0clJVVVFh?=
 =?utf-8?B?Ty8yQVZtaWVWTGplNEdlWUx4bi81OWZwaTVXWHhqbjB5Y0dSMm4xYlhuY0k5?=
 =?utf-8?B?OEJuN2RWWVordHlKUkxkN2M1YzFQT2FJaFdxanhyY0ZkWDRiMUh0NURFdDBB?=
 =?utf-8?B?MldLSHVaWGIxQkhkeVRUZTRqSHFQNzNIV2pSR1Faakk4OTZ5d3F0ZUZsMnFw?=
 =?utf-8?Q?gCAaO+mCVfvQ5aZNgjv+bzIRr3DA9THAE4CNaE1etlc8=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-24072.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6fe799-8e48-495b-a889-08dd57469f11
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB0641.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 15:51:40.3714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB1222


在 2025/2/27 22:54, Patrick Steinhardt 写道:
> On Thu, Feb 27, 2025 at 12:46:11PM +0000, SURA via GitGitGadget wrote:
>> From: SURA <sura907@hotmail.com>
>>
>> Signed-off-by: SURA <sura907@hotmail.com>
>> ---
>>      upload-pack: No longer use hidden-refs as exclude_patterns
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1866%2FSURA907%2Fmaster-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1866/SURA907/master-v1
>> Pull-Request: https://github.com/gitgitgadget/git/pull/1866
>>
>>   upload-pack.c | 15 +++------------
>>   1 file changed, 3 insertions(+), 12 deletions(-)
>>
>> diff --git a/upload-pack.c b/upload-pack.c
>> index 728b2477fcc..9ae42a463a3 100644
>> --- a/upload-pack.c
>> +++ b/upload-pack.c
>> @@ -609,21 +609,12 @@ static int allow_hidden_refs(enum allow_uor allow_uor)
>>   static void for_each_namespaced_ref_1(each_ref_fn fn,
>>   				      struct upload_pack_data *data)
>>   {
>> -	const char **excludes = NULL;
>>   	/*
>> -	 * If `data->allow_uor` allows fetching hidden refs, we need to
>> -	 * mark all references (including hidden ones), to check in
>> -	 * `is_our_ref()` below.
>> -	 *
>> -	 * Otherwise, we only care about whether each reference's object
>> -	 * has the OUR_REF bit set or not, so do not need to visit
>> -	 * hidden references.
>> +	 * config transfer.hideRefs of upload-pack is diffient from arg exclude of for-each-ref,
>> +	 * We should not set exclude_patterns here
>>   	 */
>> -	if (allow_hidden_refs(data->allow_uor))
>> -		excludes = hidden_refs_to_excludes(&data->hidden_refs);
>> -
>>   	refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
>> -				     excludes, fn, data);
>> +				     NULL, fn, data);
>>   }
> This message is missing any context _why_ we want to do this. For
> background: setting up these exclude patterns for hidden references is
> quite an important performance optimization in large repositories, so
> disabling it just like that is not an option without a good reason to do
> so.
>
> So what is the issue that you see and why is this fix the solution for
> that issue?
>
> Patrick


Oh, so sorry, I should merge mail message

See: 
https://lore.kernel.org/git/CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com/T/#u

Copy message here

---

Hello everyone

OS: Linux Mint 22
git version: v2.48.1

I found that packed refs are excluded by the transfer.hideRefs front
match, while loose refs use full match (when transfer.hideRefs ends
with '/', it is prefix match, which is normal)

When the server uses git, after setting transfer.hideRefs, the
references that the client can see before and after server repo gc are
different

It seems that 59c35fa accidentally damaged upload-pack when optimizing
git for-each-ref

It seems that there is no simple fix except rolling back this commit?

