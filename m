Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011037.outbound.protection.outlook.com [52.103.68.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEDFEEDE
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155649; cv=fail; b=Z8ATAmCcG4H7fd1/fN8eFBsRYq9hyHZAQGjJG03gFBcCAHF9YzXMxRu2vd7cJobVS3qKEqBwhUmE06rbXmFhRcZuyqAboC04RZnzuWB7GEbNggs9xlr4bzPMHOB/MWlAp+SvGmn7erMeF25cGuNBwSieqiYY/h7eH8/jWTxxcWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155649; c=relaxed/simple;
	bh=Xm+pWQarJOQD/Avy6UD291GhBvEvshc6Himj+TN7AZM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=VVkiD4QfQ8FxEiDQfug6J/wQDBAQ6nlUmyTX7pSeKo+TMgMQUhN/2OqA0aTFSWygBg0waq34FLCmcREon6Ek1Cp/6YHGLy9c+99l05JVGG6zILZdZqsgDE0j+TPEC7FJ9d3a8fUUxJ92wpEljZn6N2tNU2r1c077jQWK2/XlSFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UoII7X39; arc=fail smtp.client-ip=52.103.68.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UoII7X39"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVzBkeiA3wjeEMmCq16QMNSGEXKQGJIg4DUpfzagEZ84bx0cKnsNtfgHalBEd+MhfAuXiUfuBMiD76EXDHzMyWgAiDlmtCOluflwP5OWp/GasEMNJ0qQ2Jgffp7neBxGiS6nd7L+PXOy8u/WCsbAizLO/7fH0asmIXHMW/D/mt17USGRm4HkB3rntRPJb38kh4CeGt5zsXLQCLJQmMg3Anrps2MkceGqsEgnogzVmNI5Re0U4sM3ZOUqlPDy0AUDt5+l2n8CEee9CueJ+yx+8Ft9JEbh5NgDgxn0K9magEO2N5v6ybb78mEgclnrudlkzm4h7GSij7Gq9P66MdyFow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFI/WxZdjflgyCCkNpldixuUf/dM/BhTD16yAFX7w90=;
 b=b6KyinknhJQpnnTcIGD3gaQBsPRFpCiDPbNZnAfedY1ekIx0Htqmz0m32rckQMYeHJc/YRKr+ZBUIh7K4jazBnbexIbJMmN/8L0JflFvYuJp9VgNDGA8gWnjWab20lv/bgPInhmG27bBh9RE7r4F5WdU/M5VNMgiyt1KhN/h1NSZ36926kRSRwtrToLOzsP2ThY/2KdtfN22T2atNSLm7Im1IhxtrMuOq2v6mUQ/A8MTVlum98lga2BdxB0QPVITzPV2cxVeQ4QVugcDm9IVXJTqlmDXQEN3XiUGS20oxWXlhEoMs/4pO16aqq23Tkq5wjed+HFaTGoITfnDLTyOwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFI/WxZdjflgyCCkNpldixuUf/dM/BhTD16yAFX7w90=;
 b=UoII7X39ewis8Uf7oUI//7ADAv8mumX9IPrHzh8ySD+F6hkGwp3z19dVHZkTXYWG9q+24B0zsjWAkVVO0tDUvHvKADM1D4tCQSoNy7AdAcaHG2SOCZkNNQrXAliPWgf+mvDY2li0YFGS42EttVZqpnLPc05QjRx0W10CoyIboDJR3KXyQdCcEtlAguHhjb1Bsrw8lbWSlf3hc7p7E7aWmdXobE0/kZ6PwqeHbTdMlDbFNTY/b8gh7V4Bl5xJsHjW8h4M44wjVBWstbnvw07X3qzL24jw6dWi3OG/gtyc/0NctKJ6660Yqigq5hljraUjAyltZiGO4++g0KZhUgayEg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAUPR01MB10973.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:16f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Tue, 22 Jul
 2025 03:40:42 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 03:40:42 +0000
Date: Tue, 22 Jul 2025 09:10:40 +0530
From: Aditya Garg <gargaditya08@live.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_send-email=3A_add_ability_to_s?=
 =?US-ASCII?Q?end_a_copy_of_sent_emails_to_an_IMAP_folder?=
User-Agent: Thunderbird for Android
In-Reply-To: <aH7ZHlA4CtIBHSgX@fruit.crustytoothpaste.net>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com> <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com> <xmqqpldtxsp7.fsf@gitster.g> <aH7ZHlA4CtIBHSgX@fruit.crustytoothpaste.net>
Message-ID:
 <PN3PR01MB959761400F09B60093A5ABD7B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA0PR01CA0050.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <6FFD8CB0-519B-4718-9356-45B33E52D089@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAUPR01MB10973:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c211ce3-9ac9-4a82-3b79-08ddc8d188a1
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|6090799003|5072599009|461199028|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUhub1lvTWdXV2trTWF0SStxMnhzS2QzQ3VPZHhnY1k5b0x5dHpUMmVDS2Rx?=
 =?utf-8?B?RkxiNE9xU3cvTzl4ZFQzV3M4cVkvSFZ5OWY0cGticmFpSzJSYVBRUjF0N1JV?=
 =?utf-8?B?NFJNS2pFUVp3cG5GWjUvRmltMkRGSE5JZEVudlVyc1hnNWFTU2p4ZmZoVzlE?=
 =?utf-8?B?VnVSa2gxVDBOSDJteVROdTV1QU9JSE41dnVweVBHZnJucUVRNDdJM3hqN3VQ?=
 =?utf-8?B?Sko0NU54QUE5RkNJdDlvdHZGK2RGVlBzRTVvTW9jSDVFc1RhMys3a3JpR0Rh?=
 =?utf-8?B?djJjVkt4OEl5c0NreVdNWXR2Sk9MZWZpNFlvNWRIc2labEtHdEt2eFozQTRR?=
 =?utf-8?B?bEdYMGR2TWZoUXF6cy9zNnJhTjc4RGxmRkZrbmNSNWpCMkI3T2V2Q1Z2WmIw?=
 =?utf-8?B?VmpWeUo5RUt4N0NKNklxcTVOQ1Z1QnN1UjFLb1g2VG5xbkh4UWUyZUlvWGpJ?=
 =?utf-8?B?NFFzMWNLbG1MUlphbWVEcmJ0NmJJM0pVajg5S0JtbUNEQTlDTytBZlJoSUJB?=
 =?utf-8?B?bHY5c0didnk4OHRzVUJ3TVdId3FNa2ZKMVFIVXBmclBmV0Fxa2JFektKTEtV?=
 =?utf-8?B?N2pKSWpLVnlybnAzWEplRUpYZ01Za29xbUk1bDlTMlBpaU5aT2gvREk0QVgw?=
 =?utf-8?B?dVVPa01SbHE5bXNHb1Q1WUQ0WnVhVDMyOWxXdDBlaVFXZllvc0NUU3dCaUZZ?=
 =?utf-8?B?Q0ZKTXhwUlpIZUZTdFFZWEl5RHpBcnVKNEhSRjRMWXhoODJtYTl0TlhuVFdL?=
 =?utf-8?B?ZmpvcTBqZGRhZzJtN2Qxck9uKy9SZ1hMYnE3M0lwRVV4Qk5UMlRBWjgvMHcr?=
 =?utf-8?B?a2ZUVWpSRGo2WGVsWUhRNExGdkZtZ1VNOVI2WEpaUmZWRmZFRE5BQlVQa2ts?=
 =?utf-8?B?VlV5UjdEVHYvU1ZIbHkxNmc4bUFUSUdTYXY1cytpSmtlZ285RnI1MFRRdUJQ?=
 =?utf-8?B?dWk0VWxkV2Z1T3lFWFBqV0YwMkljNEpTT1JpVnBuUWJpaWE1TlhGM1pZb2N4?=
 =?utf-8?B?UVl5eEFablNOeFVpb1BlVFZkUEZpTis1YXVKbnVKc3Jsc2tUTHNPOGw4N3F4?=
 =?utf-8?B?WlcyZ1pVUmV5cUk0aE0wZ3MrcC9FenJ6VUJmSHhOWkVuM3lSRjNJaGtLZzBN?=
 =?utf-8?B?TVJBSEpjVFVHVDBQNlI1T1VCTk9UQVhmQjdzd3pMR1FzZVVQM1VEOWladWlV?=
 =?utf-8?B?WTZVV3poQ2IyOGxMQVBvVlRnd1lWVm5PN0thcE9BYTM2TDRBcnYyM3E1VTBx?=
 =?utf-8?B?bUhKQVNNRDNibFgxK2JaaStoaDV2L2Z4UmlOVll1WGw2YVVUWTdZSmtubzZR?=
 =?utf-8?B?cWRCcitTeWcyd1JUSVZxNFJtUEFxQ1h1Q3dNQmszbmpMUFl2UVlkUU5kZHpV?=
 =?utf-8?B?R2lzYytqSFgrWlFYREpPT29rYmpreTZxWmM4UnNkZ210STRyYU93ZnpVSVpS?=
 =?utf-8?B?TEZRZkorNDMzSUUwOVBRejZEaDRqZjArSEltQmx3PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0krSlgrcmZsQTdUZVlySEFLQWVvemxKQmRzSDhyQTJDdy9SL29PK09SRE9O?=
 =?utf-8?B?TndpL3ExR3BjaklXa0J2ZUtOUENXUTRTVVlFNzJHc2JLSmNUWjhlVU9IeGxQ?=
 =?utf-8?B?anFsRG9hR0NwenhZK3FNK2t5dFhFRUNjNjY4TTBwdkdCeWJNSS9OQlN4NlFu?=
 =?utf-8?B?WUQ0UmFrbmRTRFcyNkQvOXRSYW9uMGdodnovUkdzblluMUY0SHlhTkxXQXll?=
 =?utf-8?B?NXJaeDFnSXdPSFBDVFZmbVpHV3VLeVk1LzhQajlmeWl5V3hNWEFyb3pZOVgv?=
 =?utf-8?B?SThUTnl0aU84TU5weHJCUklCT2hsZzM3S3l0SmpiTmtFcUZqSUZCb2NRZHYw?=
 =?utf-8?B?aXRxRUVEU1lNTDlLdm01OEhZb3JIcEFLeFRDbGh0dDJVQjVaOGxOZWo4RFp5?=
 =?utf-8?B?NmIvc1JudU5heEw5eXBrdTg1Y0U3VUFNMVhLSStKSmp6UFhScHJSVHlXcjJD?=
 =?utf-8?B?N2RxUWU0eTRqcmlSbUEvNFUrUXRUa3NxckM3UzYrMng0ZWVQRitRWW5RWG9k?=
 =?utf-8?B?UXp0RWtMd1FiSDA2S1pjZUdaYjNOYThOTFFFMGVjY1pYWVRJZHQrTWxaZTJx?=
 =?utf-8?B?ZG1oSVlLK1NYeUZuNTlTRWhLT3Q1a1huOStEM1U5SGZLZVkvcm0rRGE5aFpy?=
 =?utf-8?B?VGhsRkRFZXhXL0FTY0NPTFcxRmdZd2N2TGh2Zi9UTmQrWm5KdktxUjgxOGRu?=
 =?utf-8?B?QlBzSGE1U2ZRWk5yMkxNbnkzeDFaVk1aM0Z5T0JDa2dXU3p3bUx3REJJYzJ0?=
 =?utf-8?B?a1ZXNGhTOHlRaVpEZHYyR1pUVVkyVi9PSElzTTArTk9QL25USUkyc2dzaHlu?=
 =?utf-8?B?YnkzcjY2Z3FuWS9wSEdGaUFrcXhoL0lKbEZabVI2ZW8wOWs1WVkxMUVZVU9V?=
 =?utf-8?B?VEZrTVNGZlgvTmpxTW43S3d0eEtCQldpTm9wUzlOaklJcklCSFR0anFOeXpW?=
 =?utf-8?B?TUZjRGtaM2R6cEtadm0wbmwyVVNhNmx2bzhpZ25ncytOZVovUEhUNXBFakd3?=
 =?utf-8?B?WTNFSXUvcmNuNVRNS0RHeXhOUXBGUWlZNjUzem01ak5pcjEvNDhVZnBlT2ZL?=
 =?utf-8?B?RVFzd2d5dTBTVWFVOGY3bmpuYTdSdTNXNGwzNDUxSDVDSlZVdTNxMitpYWM3?=
 =?utf-8?B?V2EvbDJsMXlxZkZtalNucjI4c3hxeXRlb1ZoV0lDZWhXMWpnTStsNkgwblk3?=
 =?utf-8?B?TkxEOTFnR09QWW5Rdi9aNWU0SXpka3hjM0Y2UnZQSVVDbnlBbVpVc0c2cXZ2?=
 =?utf-8?B?RzF2dHN3ckJ3c1ppdVNURE9zRmxCQWVFeGJLQVhGb0J2Mk5ybEJGVW5YMTNx?=
 =?utf-8?B?bXVqSm5lb1pEUlN4VEIvY1IycDlYMldybVFrOEE5SWkzRlZIQjUzdzg3UWRR?=
 =?utf-8?B?WDdzU21ZYjFWbEwzUHJjY3lTaGhPRUtBemZrQ3ZKaWlQWlBsL0xrS2t0ZkZI?=
 =?utf-8?B?NytIUW1xNFhIamtHejFrMjg4OVAyVlhCcHhvZEZVdk9qN1ZaRnFQQWw5TE14?=
 =?utf-8?B?YmZvc081UUpObWFreXUvVG50NWFqN2JhZ09BeTl4Q3NldXRvM1pldnhjdEVi?=
 =?utf-8?B?RkxVL1RvMHFMN2lqM2U3b2V6Wnp1Z1pQeVJVQmx3NXZrUWk1NHJPNTlLVll5?=
 =?utf-8?B?NzJzQm1FT24wV3J5VVZsN3p6QXBJNWh6a3RuNkhmOTdEc0w0NzRKMnhSblBk?=
 =?utf-8?B?VU9talV3N0JDRElzUEFrWitsb2pvbldLd2R3dmcwZGpFd29FRHY0Z2d1ZHUr?=
 =?utf-8?Q?Q3ZS0+hpBNPtMY3dJxfvTwnNC4LOG/43g64JEwT?=
X-OriginatorOrg: sct-15-20-8769-5-msonline-outlook-acae4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c211ce3-9ac9-4a82-3b79-08ddc8d188a1
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:40:42.5359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUPR01MB10973



On 22 July 2025 5:49:42=E2=80=AFam IST, "brian m. carlson" <sandals@crustyt=
oothpaste.net> wrote:
>On 2025-07-21 at 19:13:56, Junio C Hamano wrote:
>> Aditya Garg <gargaditya08@live.com> writes:
>>=20
>> > +sendemail.imapfolder::
>>=20
>> Do we expect that the use of IMAP in git-send-email will be limited
>> forever to store outgoing e-mails to the Sent folder?  I highly
>> doubt it.  For example, would it be plausible that given send-email
>> has so much richer feature set compared to imap-send, it would not
>> be implausible for users of imap-send that want to stuff messages,
>> with Cc's, threading, etc., all prepared by send-email, to their
>> outgoing folder.
>>=20
>> And when somebody wants to add such a feature to "git send-email",
>> how would they find this variable that uses imap-send for quite a
>> different purpose squatting on its name?
>>=20
>> Same comment for the --imap-folder command line option and the
>> internal variable(s) used to implement this feature.
>>=20
>> These things should be named with words like "sent", "fcc", etc., to
>> clarify the use case this new feature is trying to support.
>
>I think this is a good idea.  We should be thoughtful about our option
>names here.
>

As I said to Junio, I am happy to have ideas on better names, since I would=
 like to clarify that sent folder is a typical use case, but the variable c=
an be used for any IMAP folder.

>> As imap-send is not part of my daily workflow, I have no strong
>> opinions for or against the proposed feature, and I didn't find
>> anything glaringly wrong in the implementation, other than the poor
>> naming that would block possible future enhancements.
>
>I would also like to advocate in favour of the feature in general.  I
>run my own mail server and there is no magical functionality to add my
>outgoing emails to the Sent folder, so I can definitely see the utility
>of this functionality.  I'm sure there are also other, larger mail
>providers for which this would be useful as well.  (I suspect the patch
>author is on one of them, in fact.)

Fortunately my Outlook email which I am using for this chat has the magic f=
unctionality of saving a copy to sent folder, but my personal iCloud email =
does not, which after this patch works as intended.
