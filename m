Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086DE272E6B
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 03:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155460; cv=fail; b=aVINrJKH6bYmH2zkTOluHny5kDZBSTcTGZC/J5Tbzt5Pp968Ai8Vp70DoG7zMG1EW1OjmYFw2c02EL2bMMW0e5tJQluag4mgI3hEHai0bjVaG3VwXLgKrmhdG4zXRSZbLev5R7fwLLlBh1j01GuG3ZyJZpzcT6TqdKJaJdnYdHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155460; c=relaxed/simple;
	bh=gyF1cU4xWDthnSeKArpmbii4oHtqLrYXBIgNJFfg68A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=smcFdGY+1armQTJkNFZX8MqXcGCgbmZJ41lK9f9KL1vSJjxD416IUJetIirih01WlT86JmVHVh8mD0xYSy01OnMcZvjaj227BC4hmeDRzSuhWR6RiNPH95DF/lKzhAksV76IkLlbTWdPtJmEhM9Xi02hy9X0U188jIaHlQWpH6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=XFf/1RiL; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="XFf/1RiL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LTstmmVVRHtw9uZC819p5lL3yNTpOod6/L82dDYinOtYQF8zTRJlg+SkdkUXiklQl7W0tg0XJI2R1F70cGVKvnduN2TTbCeQ7gTcmOVAsZtmCRzZJ2fidcyIDQX4euOZP7LzBbbLviZOS+lZtF6A81/PpVyah3PGRjJwEBUdgImyVDfmPpfzDRhxgxt6LLuFbzVUGhThB0CME5TXrX74JuYGZPK8umr8xwb6E9ooSK0EuGzU86w9tp66p7gP9NrecvzpRKeWpJ4liyXivXs+qVIjLCAuG4deM6rVldXcH1TKNZxbQnPVzwrG6TY3wqhclVITmRtOsep3FZ61Fp38MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMxch4eeNeTPFG5opZOvxN5MtCfNNj7Z2E/vX+ixxW8=;
 b=ykyYZtWa9z1H89JPlfggPkKn8gTN9VwUMQkt1BQQjVyKXnq6N91RrgaYZvPb76+T/YG0CLtOSaKq5l1bdV+EcooRFacvnX3M0eDl3cA8mf2FBU5QM8q9dQzpkN7nkZv3teYdxpkyYTejX6St/UYlgvHcbEHjJZr7zp3fREIpjPHvIyVVWf5zbYj7363jwK2PVzY426865MwosveEqrRQIJItaWeiOW3/mOzrT14iH851nEXHArqTM16GGefMB+AdLW/iasYifHE6O4s2AOyxDRU6Z5+R/myS6ETPudkWajWfDG2bL6xBNH7IfcO1xYJRIlvVKEJSU+SNXQMcLr/S0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMxch4eeNeTPFG5opZOvxN5MtCfNNj7Z2E/vX+ixxW8=;
 b=XFf/1RiLld+ngy/3Uc6PtZTy86U6yzlLEST/nREprfSfjr0/gwX1Xg4zagZ/svMWsbpOWaCzdDPSclwAO6ozskymTT3rljOlKVwkwEMspHiem1oL3V9akmOV6GlS9B7W2KIa1bwRDVwZD0rMraxfQrfElW+jJ2O0b9dJxxbL+C5uh1qOz1cq5MIUAbII5j/XbCxUyEhlgmiP/pv4N3lnORCdtRxqAQzS9ezggoI1jz4GrzkaS7em08dVHYE/irAdnsWJuPmVt1s0RXGtDw2yqu/GPEjli7zfwG9bnFT+Nw1LgNuMe5gjjJVPLNegZ1mDLLic+XkBCuBmBE16OSGepg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB7984.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:46::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 03:37:29 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 03:37:29 +0000
Date: Tue, 22 Jul 2025 09:07:26 +0530
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_send-email=3A_add_ability_to_s?=
 =?US-ASCII?Q?end_a_copy_of_sent_emails_to_an_IMAP_folder?=
User-Agent: Thunderbird for Android
In-Reply-To: <xmqqpldtxsp7.fsf@gitster.g>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com> <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com> <xmqqpldtxsp7.fsf@gitster.g>
Message-ID:
 <PN3PR01MB95976A7BE0F9A54E836FA2F5B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA1PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::13) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <E689D02A-6B74-495A-A0EB-79F9C8F64872@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fff95e6-d9af-4137-f4d5-08ddc8d1158f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|6090799003|15080799012|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTErOVh3UnVLM21EQTRKczhvT3l6MEJOdWV5WlRXZEJVMGgvSnp5Vnp6SHFw?=
 =?utf-8?B?TWpGbzhHZ2Iwb2VuaVUxZS9DbFk5S2hUbU9aS2VQbkk5TFdsb2tqcWgzWCsv?=
 =?utf-8?B?ekxxVVhpZ1pjemtOL1Q3ZElDSElMWC9VUUdYU21GVlk3R0ZodHhqTjRPbVBD?=
 =?utf-8?B?YnNPL2txSW1Ucm9MWXAvT1lpWWcyMTQyZm5rWkdBeDY5VXZXVERpWTYzOFpq?=
 =?utf-8?B?ZzhCSUMxVXhWWENxL3cxN016bEpIejhSZndlZ2lxTE5OZ1hWLzNCeGZNMita?=
 =?utf-8?B?S1ptYUJWeTRsRUdhd0cvdGhtQlJGL3BoZ09vUmRNMENVeVZGaTM2QXFJT0Nu?=
 =?utf-8?B?VWpobytoNGkyb0dRL3dKTC80cnIxN0JGTWVXbXNBTXo3dXNpb1lUQzVQdjZw?=
 =?utf-8?B?N3ZxWlFSREUrbVRpMGM0U3RHVDY1cjcrUkZhWG9iY3BnN1pJQkpwelZpUDUv?=
 =?utf-8?B?ekpkOE14YkFOYTBCWkFmNERRb084anYzN1Y2SFFCQUlhY2VRREQ1V1JaTDJJ?=
 =?utf-8?B?TzRKaE5xMVBLbmsxeDdwc2lIT0J0NjVuaG9TNE9LbzZRKy9jcm9NT09Ma09R?=
 =?utf-8?B?c2ZUNmx6WEtyQUVFVWNzNG9IY0wwUEpoSUdFNSswSUhwWm9PbEdFZnpZYTRq?=
 =?utf-8?B?cUtNellFYnFVUjRUSURyTnUvVXJNUE9lOTZ0Y1RMeDNGeWdKdmhFS2NneGlt?=
 =?utf-8?B?ZXZmcXRxbUFJU283aEw0aUZFRXBWOU01dE9wWnZheW1nZDZHNVkyUHpKRXpV?=
 =?utf-8?B?aC90M2puM0x0aWR0MHhCTGZNWkV5ajNVUTYzd01HdkMwRittZG9LZmhQYWM0?=
 =?utf-8?B?ZHBUQjc5NFp2Q0xEMEpxbTNOZGdFRlVlMDQya21lRDhDbXoxMXR5QmFzSEVK?=
 =?utf-8?B?VUExaUl0WWIxMm5JaUM2M2xsTWNIeXlCZHlmS2VWMzBSNDU3ZG1oQlNjaUpl?=
 =?utf-8?B?OERudHBjRHVMOEc0Z2RnWTZrUS9zcDYxTElyUnVZMjVIZWNLZE12clZVZFlH?=
 =?utf-8?B?eW1KY0UyZ1k5NUFORGtjZ1BvWGR1QlRmc29WRFJIWjhxNXN6elNuUEhkR21I?=
 =?utf-8?B?ekhmZTBWUlFhK1dSMTVjRDJEV0xVZzNjcUdNTzRUZU9oQUF1RXltS2ZkanNo?=
 =?utf-8?B?bDh1SVF4d3k3cS9WNW5zQ1ZIMkFIdW9vc2hJdS84UTFXYVRUWFl2OGRtcHVF?=
 =?utf-8?B?WmY4N2JtWkNOa2hrKzNLUDJucS9BTitSd0ZvR2NjalJTOUhXa00xK3Fab1ZI?=
 =?utf-8?B?aDBzYzFxeXBXYWNFMk04K09xUVpTbjZFK0NaMnFtTUx2bnRYVElwVjdCWUpz?=
 =?utf-8?B?dWNKQjNZZWhkcWlQeGI1eVZ2REc2a2d4V2p2Q3V3NmFoTmhzTEVjNVpyWXht?=
 =?utf-8?B?RzZaMlZlWW45a1pyOURzc1NqT3NkYzBqSmJYeWtIV0QxNUJaWjJqYm9MV2Vi?=
 =?utf-8?B?dEtmOWE3U0Y0a0FxaFRnZjIraGhTakphdlAydk1nPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWx4eWd0QnpLMUFwcnQ4SVFkRjMyRXRxUHkzeDlVS0MyTzdFNXE4eDFZZVRt?=
 =?utf-8?B?NDdHTHhORkdrVXdoL1VKRDdYZ3JLdWl1MURiZEtVUUNEUFlhTFNjUStPQ1Jk?=
 =?utf-8?B?azRBdWdxTVRxenFWcDI5ZkNSTWNIZlFVQ1ZtWGxqcGZKSXFqRndpSlUyRm9K?=
 =?utf-8?B?Ukd0QXhqR2lBMGhSVUk3TmphTDhTM1lwQ2creURwWXFPOTRIMnZKMGNIQ1Vw?=
 =?utf-8?B?V0t3QTJuWVZJQzdOaHI2Tkl4Uk9remR0VUpVKzd5Y0FTYUd0NFZDSUpNUFd6?=
 =?utf-8?B?N0JtZTFreUxCbi9HaWtFS1hrc1pDRWk2dm5QM1ordjRqM2VtaEhTcWdZbE9u?=
 =?utf-8?B?aVlMWndJS0N0K01VaUU1ajl6bEh5R1gyRWcvdmthcW1QQzJneDgwZFpnS2lI?=
 =?utf-8?B?RFg4TVBBZHVidXJhT1FiUXZ0dEp2aDNzNEZLMDZqSFJZYXdCMXlsaXlTd1R5?=
 =?utf-8?B?anY2aURUUkxkQkFJQnp5UFJwMmxMM0FmUWJ5akpEV1JKWDJ0WlN4NWJYNTl0?=
 =?utf-8?B?SmpTbEZPMkF1RFU0eG9pL29jWEt4S25FaU9lOGR6U0k5VnVsYklDZWpKeWdk?=
 =?utf-8?B?bHNiZWhKU1dmWFlPSnBKbVV5a3Y1b2RKNktLL1VCODlydVNnWUc3RFJPR0N6?=
 =?utf-8?B?dk5Sb2N0OStrc2F0RzFMeXE1WG83Sm1PK1JKOUhzejBoZW82SGwvU0tKRGMw?=
 =?utf-8?B?bmxFbW0xeWFTdWVPaUR2T2NZdXAxWTZiVHU5bmFIeTIyZTZWMWlPY2t1aVd0?=
 =?utf-8?B?TjlBRVo3UURITmpIUlU0VUZHSkpDRUNCdTQ1a3RjckJxY09teUY0eXJPRG03?=
 =?utf-8?B?UzQvc1pDRGIvQ0dWeEZuejQ0YnZKUy9kVlhwRHFwbFNoOGFWc3pYbFRZLy90?=
 =?utf-8?B?b3VCeDROL0JYNExNN21ud1FBYXNocUpaeHVUZ1gvbXNzWFF1VitRMkN4amkw?=
 =?utf-8?B?dlJqNW5DTFVqQW9MNWdLOEJqYnZ0d2c0ZS8vSzQrZ2s2QzcwUm1CbHlWSDc0?=
 =?utf-8?B?YkZVSFZkcDdpNkp0aFFBQ2NRQ1pSQTBMOHRSWDkzclE4L3Bwam9LVVMxVE8x?=
 =?utf-8?B?T01zaytIQkhEbEFSOGtkY1BXYUZ1My9ycWJUM1BCZ0N1K2FqZ3Y4aVd4cGp0?=
 =?utf-8?B?V0xUSlpQVDBsekVrdURqL0xQcVZ2aEV4MDZQNnYrcGYrMEJTWDRrVTdrTXM4?=
 =?utf-8?B?V2R6OWVFSS9TMmN4a0lLN0RmZGxBWUNVYm5MK3VGY3pua3YrQmozdEg4VFNu?=
 =?utf-8?B?NHFTNTYyYmRMdVpmWEtYM01YTVdwVWFNbTBlSGhjaGh5M2s2VkJRYzRhVlUx?=
 =?utf-8?B?dW81M0t4RUdxaWZrOForb0cwWmovT0ltZFpKOWpJSVFEOVRvMWtpNFI4TFEw?=
 =?utf-8?B?RnN4ay9PdG5DNFBFNjlsSjhkYTRpK3paWnpRQTJiSmJrTHEvdVI5Y0J0eUR3?=
 =?utf-8?B?TmlacE5VRXQ4ODVRbzJPMzRacU9vSU9wWThDOTRkY3NucFBZMjJzRXFOU09K?=
 =?utf-8?B?ZTNkVWNZbFNENHNSZUI2Wm5OMXJRNk1yN1Y0SWoyUXF2SWJPNHZFMXRsd1N1?=
 =?utf-8?B?QzJRUU9PYzJvVCs4T3VpNXlZbWxnYlBRT1lhbDllUVVGcG9GVHRGbnY1eW5y?=
 =?utf-8?B?VjMyRU5zb3J4U096Ynpvd0xUbENoYXFnTXppZXFlakZ0azRNM1VUSUFNdmZj?=
 =?utf-8?B?SnNNYVB2d2pqUTVIWFFBdE03dHBkTExzZ3NaTDFOYUNyL2ROTlYxUUZ0ZW9v?=
 =?utf-8?Q?LZLEFZ+zqXFQ8FwR/tZAEMWot7YJof7G2cCNdnG?=
X-OriginatorOrg: sct-15-20-8769-5-msonline-outlook-acae4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fff95e6-d9af-4137-f4d5-08ddc8d1158f
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 03:37:29.4517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7984



On 22 July 2025 12:43:56=E2=80=AFam IST, Junio C Hamano <gitster@pobox.com>=
 wrote:
>Aditya Garg <gargaditya08@live.com> writes:
>
>> +sendemail.imapfolder::
>
>Do we expect that the use of IMAP in git-send-email will be limited
>forever to store outgoing e-mails to the Sent folder?  I highly
>doubt it.  For example, would it be plausible that given send-email
>has so much richer feature set compared to imap-send, it would not
>be implausible for users of imap-send that want to stuff messages,
>with Cc's, threading, etc., all prepared by send-email, to their
>outgoing folder.

I have left that feature opened, thus I have not hardcoded and folder name =
here. You can simply set imapfolder as Outgoing, Drafts etc as well.

Or maybe you mean, ONLY send via imap and don't use SMTP? Like this users c=
an use their email clients to send emails?

>
>And when somebody wants to add such a feature to "git send-email",
>how would they find this variable that uses imap-send for quite a
>different purpose squatting on its name?
>
>Same comment for the --imap-folder command line option and the
>internal variable(s) used to implement this feature.
>
>These things should be named with words like "sent", "fcc", etc., to
>clarify the use case this new feature is trying to support.
>

IMAP folder is a simple variable that decides to which folder the mails nee=
d to be sent. It can be sent, outbox, Drafts etc. I don't think any future =
enhancement would have any confusion with this?

For cases which want to use ONLY IMAP send, a bool like use_imap_only etc c=
an be used with imap_folder.

Although, I am open to better name suggestions.

>As imap-send is not part of my daily workflow, I have no strong
>opinions for or against the proposed feature, and I didn't find
>anything glaringly wrong in the implementation, other than the poor
>naming that would block possible future enhancements.
>
>Thanks.
>
