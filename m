Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375334502F
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 06:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164887; cv=fail; b=dDzyvT+tZFr+V7NajS7rESeUEQvjXI0y4eRHLmYEcL4Pyz5X7zA4hABhm1bMrP0Z+W/2pH5SrdhrqsJH4nZoWEpMSULOayGv9ic+iXIqSk3MBBFf+b1XNC1V7HYRHBJutMMeuSjnkOUrO2FnJ0cTBZzJ2kVgMpKQ3wyvf4rtkzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164887; c=relaxed/simple;
	bh=p/FYaOoP8hsIus/whdsEQZW88gyQFMJpYiIe/4qZl7w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=uASkiRv7kKtiJapODlFa1rJ+FGPMpbtL2niRcZginvrovDhAYbGbO8HqgqXJvaN7iiNmys0rble5IERg9WhSmNXyc2tHwA+6ZPaJeBEpbgWOgB2PFK9KwZWZk/vX8OobahX8X2PFmrppdygNakYzHX8GIay3iVOy3THvphDjUCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ghMFCYpY; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ghMFCYpY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVtdlmm9AHPwI3DthuLYbfXbdktHG8E1TS9dGXeu1Yjs5Pym4rDviWgYciIevMD8csSDbCmM7UqPGvzeWZNuIwWXzKpa/6gJZxBU0BNnrjVxWNnPzzsGSPW+D2S3lr+Ltco6+0inZLmjBt3+kODCWgEs9a6R9BdbJQC0T30qqkxkEKmoQ3tHEdgUhWGKAAevYmaRkC9lr95R/236XrOAMbDJYmJLwEJpDquYiOnfs9bpPbKbZoI0pLSEnNGojNJNVj5C8hetcZkCtuaFn6Soj2i8UuFf93w82WsSrvu6mZqHxV3cuACiloLjREsK7NXbK7+Uaan41vJm/YFRXayT/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFgKUa1yqEffhlMRX+kc+nXagmImtkklNMOQ09vCkVU=;
 b=T7hSiaMhZBUn7wegnJGUqf/NflC81e9KtsMy+sI/NlDzJUEd0X0p11iOgdKCwNgkL7Y8QP8pSQ1cTG+lEwAMZugUhCM83MzOLs7fFNtnq8sbuB+DhgpHizXZjaEJMpONdFFvBOUYq0gsyxl9BGvPHY47jQEDcNxQcxkexPr41deyKUITr2N5rw3DJtTcB/3S8r1CbK0SorzskCNi/wZkj8z1NxwVoQWdC/qEv3Cg0eL/8dCtAKDAvA3FiUuH+A/qrPTo6pz907a3jixKtSC7scRDa+lSk3oQpBpVXVK2PVHdjx49HxPhkY/tOC9/gP21Miatp/EcYnCHCBH1z6Ynzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFgKUa1yqEffhlMRX+kc+nXagmImtkklNMOQ09vCkVU=;
 b=ghMFCYpYJoJKY5eURC28Un2SBAjSyP6X7LWvpg7MetV19D527O8QWt8SNomYiE22HdULERe6M+5EVjkwP2MyR1ik8zM1OFTLojEhHBt5xg22h7swG59ZkR84x2Tj+VmqUdOxBeo7wIwDkwlm2m8+VqFGPF5q9Dd26TK/i7PEy6og6SVG86dm7SDqhVWsxWjDjh447cr+D/OiC5zkpwdg8pGagO8fRTwFeQOKsP/+25HfXcrcr1Aha2QWT6dAo8KuVLDSpKRh85lKWLoA8VyvLQ45fhSwSilohS3B4HkYpxIE6g8/PJBz4w0ZSEPnsMMv9+hEqANlm46YRZBzG+nQDw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB7704.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:b0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 06:14:40 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 06:14:40 +0000
Date: Tue, 22 Jul 2025 11:44:28 +0530
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
In-Reply-To: <xmqq4iv4x15e.fsf@gitster.g>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com> <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com> <xmqqpldtxsp7.fsf@gitster.g> <PN3PR01MB95976A7BE0F9A54E836FA2F5B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <xmqq4iv4x15e.fsf@gitster.g>
Message-ID:
 <PN3PR01MB9597B8D3D84D9F7660F15E94B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BMXP287CA0017.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::27) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <186D183A-6FC7-4D79-A8E9-97163337CECC@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 20474e99-17d0-4309-f8ee-08ddc8e70ad9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|461199028|15080799012|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bndFWWxRbWVGRHZSdWsrN2VvSzVVV0ErYmRORHQxOG1NZU91TldGeGhqQnY0?=
 =?utf-8?B?eVNIL2tDUGJqQUM5NG1XcGNEVmxFYVBJdjdzZHM4UXRleHNQRzRHaHlzSHY5?=
 =?utf-8?B?eW9ncThXQUVaMmIyUUdScFNqRXkxSEp4Mmd2RDRKSC9MV0dWaVVPcERaam12?=
 =?utf-8?B?eFo0YllhTFMza0pYMUdZakdSTkhFSHNwSHVKR1dIQVdpbU1XbmRUNkhPa25T?=
 =?utf-8?B?ajRUMS9GUjdaNGVBdWlpVmkwU0tmQVdGL2hZajU3b016WnI2WFBwaGxpK1VX?=
 =?utf-8?B?SGxia1VMVTgvUFc0NnlaSnpYdnVyT0FVT1ZXWUNBUzUzU1F0dEc5aVM2TVVQ?=
 =?utf-8?B?eUJyd3drYjBYOWovQnNuNkZUWlhEeENwcXlUbHF4aXk3cEcvQTRZTVJSUFFl?=
 =?utf-8?B?aElkU2RnVWV0NkVUeXJKTERkR0tGWk8xY2pyeWsrMnZEUFd3UDZNU3FsM1RR?=
 =?utf-8?B?NDRVSkxYRGNDTE9zWWVDQUpqeThUTi9xWlhtUTN2WFAwdGhPaFZ6QUEvSVpM?=
 =?utf-8?B?LzR2U3BnZnVMd05pV1dMRy93cWlObHZpYmxwdXRrT3dGc2I2NEtkbnJYWkJ0?=
 =?utf-8?B?aWl0ekJlQWZVYnVWdnBwNnBoN2xXeFkxNGk5ak1pYk5VajNkM1oraVoxcktR?=
 =?utf-8?B?S2VPM2o0SFJTaG1neFFySWp1R3l6RzByY3Y0bUxUTWRpTWtLeGZqQ0RJVXdY?=
 =?utf-8?B?Rm85TE1WMGhadGxTMjNqUHhUSkVWY0l4NGlNWUVKZVk1bGdGcXhmSUUxUitU?=
 =?utf-8?B?aTJTcjhXTUZQSXNwVGpFTjJUOTRabzU4cjZmOXBhT1ZndUtuVWRtaHdRZ0Fo?=
 =?utf-8?B?bEZUby9hNXcyQnhUNzBWdTVPOHQ5cHdSeXB4QVU0Y2V6SmZWWFh4aHlLVFYx?=
 =?utf-8?B?V3ZhWklHTmJ1eS9DOVJTajJGV21TcEpSVGUrSzc4MXJuMVJEL2NOeldneUx4?=
 =?utf-8?B?K24zYXB6bU1lY2JTRmJ0akQ2dC92akNCdlF0dHZianJoMjBIbUgxRXBlOVZh?=
 =?utf-8?B?U1dYV2pCV0FTRUNMOVpRZE5obndnenFza3NjSEhndWsrbzFYMkRZM2FyOVV0?=
 =?utf-8?B?MzZHUzMrclJVZlV6bDE4bDZ3eFdUZ2IwMHNtL2oveHgzOXYzWFBnZHNuT20x?=
 =?utf-8?B?bFRma2JRVU5DZjUxdGRVU3dsVzAxbExCYkhlQ0tRbkF2c3ZoRll0VlhjNDND?=
 =?utf-8?B?a01LYUY1OXVRTkJEM0k4ZWx6ZXRaclRUVUp2bWMzeG96OXMvR1NZa2tGYnBr?=
 =?utf-8?B?MWE2YitCd2RkNmt5WHNlTWRQY2l6VW8vdVZuaWp6emRBZ0tYbm0weE5QaXZL?=
 =?utf-8?B?TDY0N21LNStRYXB6M2t0SGZWVTdERTR0b1JmQUh5TkU0SEFOdnBzL2MzU3Ew?=
 =?utf-8?B?VFh4czkxUVlIWjdhNkQvVTRUQVJyNUJPcEM0N1BmRUJzdStTakZWVGRSUDhl?=
 =?utf-8?B?UVRNWHZlcVFlaS9ZMXFBU3E0ajBUWlFLWEdsRi9nPT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1k1aHFhd1FuWG1CSmVNaEk3TzJRUFNpdFpZRUp6azNhOVEzUGp0SlQwWDFW?=
 =?utf-8?B?R29vUThGLzlGZW5FUTRlNUpTVXphV29rc1ZDTm9BYjhyZ2RoakkzcVRML29j?=
 =?utf-8?B?MTJvM3AzK2ZiWFJXU05pQ2x1N3FPQ0NhV0FVRG43blNKWkxIV0VyQlNYQ0Fy?=
 =?utf-8?B?TEhZajFrdmwrREVRc2IzOHh2ajEzRnVaVHk4WWxwM1FESVl4ZHN0L3NwQVUw?=
 =?utf-8?B?azJyM05FcnU4UUJxNkd3S0FyWjJ3OS9wZ3p3bmJiY0swQmhJdzJIWmUzRGRY?=
 =?utf-8?B?cUdneXdhUWRDWENnUzdvcDdEZTVTc2ZlZDdieEtpUTE5U2Y5dkRMcFJUVXBF?=
 =?utf-8?B?UE5qdlJKTXZtQUd2dDR2QzVXMytXMStPc0dCNG03SDk0NGU0N1dTTmFNWUxC?=
 =?utf-8?B?cFJFK3k3SStsQVZ5WUltU2F3TjI2by82OHhQN3JrUERRYXNwTFFWdWRFWDQ4?=
 =?utf-8?B?a2QyVmlLRHZ4MnEvQmlUNmV6K1Z3ckVhNlZvRGNja05HcVB1ZHFKZjROcDFk?=
 =?utf-8?B?eFVHaFFrbmhDbDZ3bzFYeUt4NzlzZjhhWTZVZVlyVUlndWtnUVExRldGSG1C?=
 =?utf-8?B?ek90ZFFuL2ZXYytjRmpLTGJWNFkrZXNrbGI5aG5ybFFNQytNZmU5V09Dd3JU?=
 =?utf-8?B?aDVVSXREZVRreFgxLzE4dStzbDZvdTVZL21xWW1iNWYrUEkyMSsrbXVYMVlx?=
 =?utf-8?B?c282N2xKeFJuRDFZMk1WUmZUU2JPNi9FSWp3TVA2R1YrRlFqcjVGdXlKNisy?=
 =?utf-8?B?bUphK0dEOXM3RWJHZE53YzlsVW5SNXVmQnowY0k5VEk0Q1psOE1wSWVKUml2?=
 =?utf-8?B?K2VnSDVWc1AwVTZYS0xlaEEvSWcvYmZBZ1hUQnc3RzVoVW42NWgwZmFCTUFU?=
 =?utf-8?B?OHkzVlJXYjVsWHVsTEdNRnZnM29Ybk5VaTdKOTNBSVF3NmFKeDlyY1d5aDU3?=
 =?utf-8?B?SUZudlQ5YmkvZjN4amV3R1N3SGhTWXZ1TkY0NEdaVURLOG95WXhMaXI1TWJY?=
 =?utf-8?B?OVUxM2h1T04rNWx0VmVzelNYU3hObDlsSGhnRlNIZ25CNzdEWTBDQ0lQMGdV?=
 =?utf-8?B?Z2gvL1FDMkFvQ0JBeGdKRmZKbkhxMjlyQXBaRGpoQ1dCdnMvRzJieU15RitD?=
 =?utf-8?B?NmU3UnFFRjVtWWtkYjQvc3JHYWZtN00wNlhCYmVoSG9JYmxyRWpZM29xd2hN?=
 =?utf-8?B?UGhvV2w3ZjdqOGtlZVhPNEpaVFpYM29oLy9pNEEyVFJXTUhGWUhyVnl4SHAw?=
 =?utf-8?B?TUVZL004SXhvZUNJSnhRb3QyQlMvR3B0TWhaUTVqMHkyZ1BITmRZSDZ2UVlz?=
 =?utf-8?B?UFVBUm9IU2xDbmN1Ums0SE5WNXRqOFhpWkhDcmk0NTNtYlVXSmJBc3JvVERi?=
 =?utf-8?B?d2NESEFwekpkcFRGbE9xdDBZUnJ0K1hrWUJQeENsM0ltSlZzTjhpOERMRm4x?=
 =?utf-8?B?NGorbnBVRjc0dWo2dXllblFQQVNjdjZhWmR4RmlhWlJieFl4T3JkNC9TRHk5?=
 =?utf-8?B?eVRFTW9vcHl2MVBiYWtSSFVRWnQzbFhpeDRxbXlvOUpKYlpYSVFLYzNkc2VU?=
 =?utf-8?B?RXZ6S3UzNC9SQVUwckh2TjBvWEFYTG5yWE1aaG02VzZVZ3ppbDM4VUpObkJS?=
 =?utf-8?B?Tm9yQXZZNGxObTRQL0U0cWRaMjEwKzJyVldxb2VMUHVsdkVBbHpibEJ6U2o0?=
 =?utf-8?B?RlNZdjNBa1VlSXUwbEl2OGRNa3lTVWMzWFQvRkwyM1dGV3lLUXpsa1lYSm5j?=
 =?utf-8?Q?fQUHAvI1EvBf/Smz8A=3D?=
X-OriginatorOrg: sct-15-20-8769-5-msonline-outlook-acae4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 20474e99-17d0-4309-f8ee-08ddc8e70ad9
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 06:14:40.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB7704





On 22 July 2025 10:39:01=E2=80=AFam IST, Junio C Hamano <gitster@pobox.com>=
 wrote:
>Aditya Garg <gargaditya08@live.com> writes:
>
>> Or maybe you mean, ONLY send via imap and don't use SMTP? Like
>> this users can use their email clients to send emails?
>
>Exactly.  You sold this feature as "have send-email send the
>message, and keep an extra copy you sent in your Sent imap folder".
>
>I pointed out that "have send-email do everything it would normally
>do before it talks to MSA or talk SMTP to send messages out, and
>instead drive imap-send to store these messages in a folder like
>imap-send users have used the program so far---as the user will send
>the messages out of their draft folder as was traditionally done by
>any imap-send users, send-email will *not* send anything out itself"
>as a possible different way send-email may want to use imap-send.
>
>These are two very different use cases.  We could organize things
>this way:
>
> A1. When imap-folder is specified, that IMAP folder will get an extra
>     copy, in addition to what send-email sends out;
>
> A2. When yet another new option, --send-email-no-send, is
>     specified, send-email would not send any messages out.  Even
>     when this option is in effect, if --imap-folder is specified,
>     that IMAP folder will get an extra copy, in addition to what
>     send-email would send out (which is nothing).
>
>Or alternatively, we can have two very different operation modes
>that both involve imap-send:
>
> B1. When --imap-sent-folder is specified, that IMAP folder will get
>     an extra copy, in addition to what send-email sent out via its
>     usual route (like by invoking MSA or talking SMTP)
>
> B2. When --imap-outgo-folder is specified, that IMAP folder will
>     get the outgo copy, later to be sent by the user (just like a
>     user of imap-send would usually use), and send-email would not
>     send out anything by its usual route.
>
>I thought the latter would be easier to explain to end-users, which
>is why "sent" or "fcc" or something like that should be in the name
>of the option when operating in the mode the patch implements.
>
>This brings up a yet another possibility.  Invoking imap-send can be
>a new third way send-email uses to send out the messages, in addition
>to existing (1) invoking a local "/usr/lib/sendmail" program, or (2)
>talking SMTP to smarthost.  That would be very easy to explain the
>operating mode B2 to users of send-email or users of imap-send, but
>it would be a bit awkward to find where B1 conceptually fits.
>

Honestly, B2 looks like a doable thing, but I don't think people would real=
ly want to use this mode. Considering the fact that using an MSA or SMTP is=
 much better, and commonly used. Also, imap-send was definitely not in use,=
 especially looking that the fact that it was broken for a very long time.

I'll rename it to imap-sent-folder, but the name looks more like it is only=
 for "Sent" folder, and no other folder can be used. For example I like to =
keep a copy of the emails I send to git mailing list in a seperate 'git' fo=
lder in my mailbox. I can set the folder name as git, and thus have a copy =
saved there. What do you think about that?
