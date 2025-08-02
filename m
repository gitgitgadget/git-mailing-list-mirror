Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02olkn2075.outbound.protection.outlook.com [40.92.50.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508AB672
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.50.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754121217; cv=fail; b=Mtj/X0bpKqwzUDB2EY3m0CkqSV9y7QF8+Tpg1D3NcTG86zzJHO2RGJuSn/xQ+PibAu07HmsanK5iyRI161WP/Bbzy2W241Ycl0I8nafvH7HurwULLSldmRgqrrgEJtnElpdbithWHbmzoffC2TzKhiF09O4c9Rdlhc7YyzUJkrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754121217; c=relaxed/simple;
	bh=m69lSZIgonGNxQNBASifTDlbMJw5dLsTUqUxFZUaBZ4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=u3erb4ulLP76L7R4/wWDfdjiMdj+IAuidcee/qNNsLkjaCKkk6W1Jb0sMrn9xBVzMxduhAa7c0+EDHRhwByy/Py1oN9Sr/DCfF3id1i3LkPc3H4hqvSt/619hw0FXJQ1oa8KRbvxCC2eYgukiUwp4Hc9TK6Er5WFndI8IymbjN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b=SoSNMjRh; arc=fail smtp.client-ip=40.92.50.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b="SoSNMjRh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yu0+l5SjMcrSK6oUtut8DZaeXtsQsHV6ib34QM1a3CxgoZ9X78arkWjVsMZrCd7whCZE2t3g0eBaZpwPA+VZEWShisXGTYXLauOkMU+0kQo/mLqWUZw5AA/hcWX21+m7leoj2V/GPJEgRLAdtsLg2/GGtmxbt+JDkcxKdkAMj77yyc5IUrfRkn9BIiEclQ523/H4RrTJ8rrexiYuYBr89oHlZ7O8Mvpr2QOUA1ZvoLTKKGYca+snmb5gGLKGyUnbbNF2ZkjRNKNlaZ9PZpAa9ReGbTTc5viTz5tonWoq6rhKh/iNNt26KuPJuP5AkcVfinkX2Rq4HAKj+i0TFqhcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9Dmnw/M2JoxFipYe/lOWBCHQbFwx3OB/dGb5Tys7Ac=;
 b=MCid1e3aXyaysCQGMexClJzXKA+9N8AiLWrZsBsFC/P1qTIx6f+9pulvxXuoNIT4CKPRi0XFI+BSv82FXL7e3xxd589GDVEV1SgyZ7I4+cGBLV1EDrB1wTwILKKNyZuhXXZFyXvW1imRFYU8dstBrKxMFRIhv1X/fm13N7Jc+vPQz9lEoa7r0qsmj32WY9Bnp1eEMsrLBpucmu6zu+fmtY1EdtATHDcEwiIaRQg5n0F2kKO5Pd3HNwyfSunp1b+lGnQRCqj/KCDhb5fVC1Wjtp1qF+mZ20jFxZpzu2t7VvwbFP3jmFDzgsO9QV0/qPfyyPWSwwPQUffvuUrEkqLL/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.DE; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9Dmnw/M2JoxFipYe/lOWBCHQbFwx3OB/dGb5Tys7Ac=;
 b=SoSNMjRheNc1uV1rQqH4rO634yPfYETpbkW6mMyJzM2sElRH9vSr482vy/qUxxu/KPnQ0JPkE6lVNRxsVd8XgUK4gUroCGf15R8XF167GKGqwxbgr1vAs/eLUp9KUQN0ppy654dLAOAhhOLNSAj78nASrW/fFob1MEsh2m/2Cb0k0lgFZPCfWi+Jer3UzYCmVZOKgdHw/uuW/ZRW1reLyWuJoHvzuzbfxx5RcyBgTvI4OXeV+bijidphGDaN5AETO0hcWMJnVqLfNJ8KV4iHcLE+017zmQMbPF+V2J2BB3wnMUikN/OuyQhYDVp8aB7exMhSybGxyEwYwvhumq0KIw==
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by PAXP250MB0520.EURP250.PROD.OUTLOOK.COM (2603:10a6:102:274::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Sat, 2 Aug
 2025 07:53:32 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1%7]) with mapi id 15.20.8989.015; Sat, 2 Aug 2025
 07:53:32 +0000
Date: Sat, 2 Aug 2025 09:53:25 +0200
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Ezekiel Newren <ezekielnewren@gmail.com>
cc: Junio C Hamano <gitster@pobox.com>, 
    Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 6/7] xdiff: conditionally use Rust's implementation of
 xxhash
In-Reply-To: <CAH=ZcbA-OWxbLJoqf1EtDetnXwAieXQjBr5Jmf+G4GiQsTv-hA@mail.gmail.com>
Message-ID:
 <DB9P250MB06923B3E881C33DE457DDA63A521A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com> <xmqqzfd12ujv.fsf@gitster.g> <CAH=ZcbA-OWxbLJoqf1EtDetnXwAieXQjBr5Jmf+G4GiQsTv-hA@mail.gmail.com>
Content-Type: multipart/mixed; boundary="1121930767-12399-1754121210=:22940"
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <2302f3e1-8347-2c5d-dc17-73a6e59667b3@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|PAXP250MB0520:EE_
X-MS-Office365-Filtering-Correlation-Id: d58aa8bd-e187-4105-dd3f-08ddd199ac92
X-MS-Exchange-SLBlob-MailProps:
	AZnQBsB9XmoK1BMhJ23Kz7EyK/dzMULTAi+qbZ05xZZqkTHsQxHvE4sKlGWMPz4H6xJ80bTvgjnNv7G6BiCkvE1bS2Z0VMk3j8Rqmb2b4MDbwZ1ECo3qKB8mzDrglZ03RAMcbe4UIUntE3lqK+yH00w9mjKgkpMxsSPQlq12JD1ZQB/ePFAl20enV4CmXHLe9r4d+3vl+Qj1FL+UmInnZuIjADD9JLmkcc207mI0MgewibLG08FrZfmrwsfVQ2LaYyhwvctEZOBcbMk+xdYdOMmMeUjqBIVenIm7KrmttGaEnI4pzgYvPEvgL7xyhoR1cK93bfL2pk6ljxgIhnjWwfTXVbyoBbn7YNdhperupT3ay8BwLFbXIZd1FC/WMcHDFNo9nSOeMJcbVZvLOaP7HE8E0y37FLV/EpazcI0rHOEGYAZRHCrC80kTsfEd2OIe6fzC18l0HdqQDMzUxVfOzjHpn/1DYPLvOXh7FA0Qf9NYp/5s2j35NZ3pjfR5Rzjy7yfvm2jSZEbUlOOUmY17Y/b5KJ03XFazWtt6UZoR7ZTlJ0lH3ZznTvbjkLaKZJPggriAGIU3CM2gsiEI3x/Tq2btGtpTxxt6siYdfX3GJIPhZkmf2Dn2hgdV3Py7OwOL0ZUdYnhO3vaOmdaCv7uN9k5pSCL4T+1bUrbS8Y7Gt5uJjbFMY7GBSQr7Pi6NikUfudi6KRFGxolJ+7QwcRWp+7riCdX+OATnq9osPtLI1lOcSroVgbkI5OkfA8OpbODQGJCLMRtUj4U=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|19110799012|8060799015|5072599009|461199028|56899033|3412199025|40105399003|440099028|51005399003|10035399007|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFd2R1lQRHRKajVXbWQ4RFFwcWtPM29Hd1dPamxrdDUrQ0xhVWRNQ2pST3I0?=
 =?utf-8?B?MDRTVExNUnBCLy9nNmU5SzBESkowckZUS28rZDhvOXViWnZ2MTdPM0hEUVpn?=
 =?utf-8?B?ZG5nWnN3Zy9JUWp6bU9sQjExWmY1dzZ5bkdISFRmWG9zaXIyZUtMdTBTVDlQ?=
 =?utf-8?B?b3hTQ1VZWXNkbDdDUVFBcFhES2FXay9JTHpVMzZ5RmJPYmE0U25LK2VpdFI3?=
 =?utf-8?B?clZ4c05MUzVzNUh3a08yVE5MYzlkYkhrNXJZcEtIYVk4N09ZQ294aWdwRnho?=
 =?utf-8?B?UHQ1dFQ1Wm1oYWlTOHZuTDlxUFI3ODNhd2hocnpnbDR6MW9UT0V5blpyaG1Q?=
 =?utf-8?B?T3JRazVndE8vL0s1OElzeXlnL2RJcUk4M0FIUHJOU3JwWXpPMnFleDV1ajNP?=
 =?utf-8?B?bDVrL0xuWTZjOHF1WmF0bmdhdFdDRFFqZnJESkRHSnpQSUJ1THh3S0JHdWlE?=
 =?utf-8?B?QkRuMzJIV2grMlB5MCt0eUlZWDBVQkc3dGFHQm1VNVoyNHBmZFg1OU9lY2I0?=
 =?utf-8?B?NjVDRnI5TXJsS2dMRmg5NjBucmxCVmtRSFlGODcwcENiZFBNYnM5N1RWa3Bv?=
 =?utf-8?B?dGNhSFl5MGNuWTloeXh1ZWx2V0VTeEM3VjJPVHAraFdWeXAwNTdPanltR252?=
 =?utf-8?B?b1Z1eFNKQ21DODBOdUVuRWRxejhNYmVFSFlrRDZrWHNtYkswTEpqNnprLzRK?=
 =?utf-8?B?U29PSXlpOGRjZTZ5SUE1QzhsY3FrTTlMbkM1b2pwU1o0QXNRUElIVjBWZHNh?=
 =?utf-8?B?bXJwTzJQWVFJcGJ4S0g5dHlFRXFFKzhJZ2dQNGk2V0JXQU9mQmVEamtZZjNY?=
 =?utf-8?B?cWVXaHpHU1JReHRmRks5VXZ3RlRIblpiNmUxQjhodXlKVWNSUXB6d3IwS2Zo?=
 =?utf-8?B?QlE3M2oxNXAzTGt1S2x0ZW9ZMWVQTzBjcE1yUXowZWkyVkhVTFNZU0M2MnJn?=
 =?utf-8?B?VklDQlpWMmNKRTV2dkdsejdLaitBV21DdWNLc0lwd3N5UzFjWlNZdU5zd0xJ?=
 =?utf-8?B?RE9DRVV5OXBSTXloQmFVSWo5VWt1anF2V0g5VW9yWnVZOStMcTRZeFBtRU16?=
 =?utf-8?B?WjhwUGRmZkJVU0NIeFVwSTZ6anpKZUVZMEVTVFJuWmFvajRzbUlXWjVNVHhS?=
 =?utf-8?B?TzZuY0dES2MwRnR0QTBsWVNTd0lucGNKajZxT1FuMnIvbTVYdVhuWjdxR3NF?=
 =?utf-8?B?U3NEQjFYS21iWm9oSStTeFRRREFvbTZRSkMrdHluelVaWG80UGpWcFo1cmZa?=
 =?utf-8?B?d0h6Sm9BbzNKbTdnd0ozbUVnV2U0M3NDZElqeFpSMjg0VVppQXJMaXVhT2pU?=
 =?utf-8?B?MFJldWhJY3J5OGc5NFYvTWs5MTNSUHloYUxSRjZqVnRaQ3hLWFFBR00wcGwv?=
 =?utf-8?B?d0ZOam1kbno0T0E0cEFMNkkrQmNaY1JPNWF3d1NxdzUxWVUzMFdDMnZiZi9j?=
 =?utf-8?B?M05TbE9qR2F3OHMwOENnU3llZG5CT2hIcEJleVlzUCtIRlNBRTV1Y000OFVV?=
 =?utf-8?B?WGo1aEhKcUNUczN2RUR4ay94aDRaakxnN0txQ2lzOUo0MnVIejZsWmhBNmox?=
 =?utf-8?Q?4fzP9mCuobKBsja8I4ST7vOxOCAdCCrLO4gMS0+UsMZsn/?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1ZPVzZQVVo5MytKQUE0YUIrUUkzUjB2WlRlTS9SNGVmZUNkNTNTWkJZazFD?=
 =?utf-8?B?aUJub0g3aGQxSmpVTC9MY01Ma2ZvdDIvaE0ydDdwKzJ6YjM0SHBjc1lJOEMv?=
 =?utf-8?B?Ui9RVVdDeFAzdUdXWVNqalcyQmZudEFobjhTeXQwL013U3pIOEgvWUwybEgr?=
 =?utf-8?B?UjJoTFFnM2lqd04zVXk3WVF6NlA1SlBRRnNvSkRFbUo5NU82Qmd1a0w3Nm5y?=
 =?utf-8?B?YVdZaTk3alp6cFNUdDZmKzVEeVdZR2xndVUySjJTS0FHSUNFSE5lTkRMS3Ja?=
 =?utf-8?B?TURrZGRkRUE5VEl5UzZYRi9BWjdndzU5OHhHdDYyTkxWbjlWaWcya25YU1NN?=
 =?utf-8?B?Nk81V0NnSGlJY1JONzQ0Y3VZUCtkcVpqc3YwRWJHaWJSUDhnSTVISlhiZlAx?=
 =?utf-8?B?Q3gzQTNSeUlPbER3cUlTMTVMdlFVdDZUaHJkWG5HS2NXSTJJbndXREdiZEFu?=
 =?utf-8?B?UlVTRFRDcllvTXlNVkQxa0xoRlY3MEg5eHVnWFJZbzlGa3pSbkdhWjRldDdV?=
 =?utf-8?B?SDhjVnBqaStuOWVuMFdOd3h4ZUdVSXlWRUNqYWM1SW01cXJkb1pzV1Y2VTRP?=
 =?utf-8?B?NjhVMlBaWkRkT0FycjdDOStETnZyOHhhTFUzWkc1bEkyK1pjZGtuSlFlVFNE?=
 =?utf-8?B?ZDhzZThHQnc1elg1dFpEYWR3YVZQWHJPWmNiZ0dxNFQ5bk5raGpITXdXTzlu?=
 =?utf-8?B?MTIvRW4zY2EwMU9rZkRuRGZTQW42cXRnZzQ4WWJLaEY0aHdEYmVjK01vUWxZ?=
 =?utf-8?B?Y1ZmTnB1ZjlCeFdvc2JYM0ViMVkvK05JQmxtSWdaQllmRVhnNEFONDhuK3VW?=
 =?utf-8?B?UzFKS1ArK0F3ek4xcDF2dmpadENnbVdYRVJILzRrTHBCVXAvT1ZVYzJ2VVdK?=
 =?utf-8?B?eWlMZU1wVStRY2tkK0I0MkYyeEIxaVdVRUpaZ29PU1ZRQ2lNRVVVVTVYcmpQ?=
 =?utf-8?B?aHVnN0VsK3hnYjVkb2ZqTTQ2dytjRVNCelhEMGdBanpiekpGQXNtcGlpZUNt?=
 =?utf-8?B?SXRBVWR4M0JkNm1TNjVya0NiZDZSWEtJOEUwSmxLZHVST2lhTEpwOVpPdm5m?=
 =?utf-8?B?dkw4ejlMOEMvYWxjeUoyUjJSb1JBU2VlNDFXRWZod2pyYWZLaUs3SHQrK2xo?=
 =?utf-8?B?QVMyeHYrd0tjTTlXK09FWXpXMlE1eGtrK3llcDZrQ1BaVTZkeWh1UUQyakVE?=
 =?utf-8?B?YlNzRWl1S1lTR3ZjQWhRN2plMWhBcXc4aGtyYXRiVDJUOWl0bGRiQlRwM1pF?=
 =?utf-8?B?Z0gzOVcwNUFhNWJ3UnQ5UGtKNUE4K3BKVU43eTRQV29paXlvZXNWdEt1UXQ2?=
 =?utf-8?B?ZGZaT0xQRVk2TG91ZFIrQVVDZEIxSTAzdGVNSE1INU13aEVxWmRGMDFMemhN?=
 =?utf-8?B?cm5KS0xid3FVMXpucFA4ZlQ3OW5Hc3BlNmFXMEw4QWFkdjVPSzErR1pPNllk?=
 =?utf-8?B?d050QlBQTVk2T2FjYm9GMnVNbmdORGFpRHhXdlV1ZTZjOFJvNHdXb1ZzdUdx?=
 =?utf-8?B?UC8rSWJpTDBnWkZSczhPNjBFMWsxa05zWTF0TVRRaEkvck9hR1BNbEZxY3BR?=
 =?utf-8?B?NkFhL3k1OXZKWi95cWRzSTY0R3RrT0YzT0dEMkpiemZDTmlHL3FqRmhkQll3?=
 =?utf-8?Q?NrNEliZ5M1bNKhLxqSGwquXPn8kcvf8RwhdWJu/7psNc=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d58aa8bd-e187-4105-dd3f-08ddd199ac92
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2025 07:53:31.7429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP250MB0520

--1121930767-12399-1754121210=:22940
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Thu, 31 Jul 2025, Ezekiel Newren wrote:

> On Fri, Jul 18, 2025 at 1:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> +extern u64 xxh3_64(u8 const* ptr, usize size);
>>> +
>>> +
>>>  static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_t const *xpp,
>>>                          xdlclassifier_t *cf, xdfile_t *xdf) {
>>>       unsigned long *ha;
>>> @@ -175,14 +178,26 @@ static int xdl_prepare_ctx(unsigned int pass, mmfile_t *mf, long narec, xpparam_
>>>
>>>       xdl_parse_lines(mf, narec, xdf);
>>>
>>> +     if ((xpp->flags & XDF_WHITESPACE_FLAGS) == 0) {
>>> +             for (usize i = 0; i < (usize) xdf->nrec; i++) {
>>> +                     xrecord_t *rec = xdf->recs[i];
>>> +                     rec->ha = xxh3_64(rec->ptr, rec->size);
>>> +             }
>>> +     } else {
>>> +             for (usize i = 0; i < (usize) xdf->nrec; i++) {
>>> +                     xrecord_t *rec = xdf->recs[i];
>>> +                     char const* dump = (char const*) rec->ptr;
>>> +                     rec->ha = xdl_hash_record(&dump, (char const*) (rec->ptr + rec->size), xpp->flags);
>>> +             }
>>> +     }
>>
>> As a technology demonstration and proof of concept patch, this is
>> very nice, but to be upstreamed for real, we'd want a variant of
>> xxhash that can work with the contents with whitespace squashed to
>> be usable with various whitespace ignoring modes of operation.  When
>> that happens, and when the result turns out to be more performant,
>> we can lose the xdl_hash_record() and require only the xxhash, which
>> would be great.
>>
>> And that variant of xxhash that understands whitespace squashing can
>> of course be written in Rust as a part of this effort when the
>> series loses its RFC status.  At the same time, those who want to
>> use our xdiff code in third-party software (like libgit2 and vim)
>> may want to reimplement it in C in their copy.
>>
>> Thanks.
>
> What is the git precedent for replacement code that is easier to read
> and maintain while also being more secure, but is slower? I think
> hashing with whitespace handling in Rust might fall in that category.
>
> As far as I can tell the Rust code for dealing with whitespace is
> going to be slower than the C code because xdiff used a hash algorithm
> (DJB2a) that can operate 1 byte at a time and combined hashing with
> determining the length. Xxhash requires that the length be known
> beforehand and the memory to be contiguous or to hash it in chunks.
> Hashing 1 byte at a time with Xxhash is VERY slow since it's just
> copying to an internal buffer until a full block is ready.
>
> On a broader note. How do I show the mailing list the changes that
> I've made to this branch/patch series? I'm not sure what the proper
> procedure is or even how to do it. What commands would I run, or web
> browser steps would I take to show my newest commits?
>

Since you've used GitGitGadget for the original submission of this patch 
series, the easiest way is to force push your updated commits to your PR 
branch (xdiff_rust_speedup) and comment "/submit" on the PR again.

Alternatively you can send a version 2 of your patch series using git 
format-patch and git send-email, but that is a few more manual steps. 
MyFirstContribution.adoc has a detailed section about this process, 
including a part about a v2. [1]

[1] 
https://github.com/git/git/blob/master/Documentation/MyFirstContribution.adoc#sending-patches-with-git-send-email

Best regards

Matthias
--1121930767-12399-1754121210=:22940--
