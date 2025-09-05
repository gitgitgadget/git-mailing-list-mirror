Received: from FR6P281CU001.outbound.protection.outlook.com (mail-germanywestcentralazon11010063.outbound.protection.outlook.com [52.101.171.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900862DAFDF
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.171.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110385; cv=fail; b=CuHghdCJCBa4BRa20J5vdv2AW9bDL/oFW8CIkh+gORCYy1JYF88zsO5hd+iZVuobIlxj8uWuSyIfLobGBiz1CRpoy0qotWIwOi2d7iXAITFV+uNtMyVvpwe9HSd2peLjP8GENWj159670ETbGVRvQpQD6ReX2fcrXcugT2rQ06k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110385; c=relaxed/simple;
	bh=uHkC53g22FNuMQRzVDveEypM7wtVPEBVNOFvTtIjN2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rc0AivOdzFQMdj10biDby0/vi68wOAwKRKP3W/T/2woEwn8muvkXRw0WjVLWZsT1isQVKgACWXRfQkrXDAH/q0e3S9R5sqqBoYMnYY84I7yrNP+OzhEwL+sTjJeVW/uXFv4lpe48Af4x0x4OcXuYeVPytie2yn8/rNl7exG6gFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innomotics.com; spf=pass smtp.mailfrom=innomotics.com; dkim=pass (2048-bit key) header.d=innomotics.com header.i=@innomotics.com header.b=6W/W8k7y; arc=fail smtp.client-ip=52.101.171.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innomotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innomotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innomotics.com header.i=@innomotics.com header.b="6W/W8k7y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pepJrGVf2c8J5Qj/uiwhwP0kGAkDXjOYNofAu46TmOFnloO7zjIh7d+zxITnPuQN5doF4z9jbkKA7wOi/mrheL8MuTR1SNTDTzPvdsvZvay5hd6xjlE3Q1gxLIhqIjtPDXRhQRZUa6E+dT4ozTwBoUXTpB1Ml+ARflBfXG08kN9chb9i8EepWLvEv6XG77IndJhUvxyhJnPCa4HO0JMpoeui08gc+dBahP26dPRAwqj3C7WkunfpuhanIB9QM8OPhWYMkb174sHHLxk9R7HTl/Mayp7hK7i14eEtffzOWVvgQ4BBTJHysu7HrNHEFJfLzz1+m1snCDuZmUsL0q/JFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOQ+pwQg9H1fx5pLxuWn3V4AWFD745z1NefwRsoJ/Is=;
 b=gIp6G4Uf6/HVTSwBdjvL41AaizfEfxwAZJwuXOZQyXIAaGWdfv7NbKVmQwOjfnt+77Kh1yo5HO/LElxI3yzivoixCVJbhZbkkEJZGhP6lAfWDByAhijGtEEfu5qg/ai+8Bk5Uc5cxB3tzLOb7qvRv9iDXZZfqZ/iLTsbphdRkhgk+9j31qvSOePpMSt7DScmYTvvsBagpFawcGwp2X5NFcoZ5sHbwG0vSOnxvyeisC6ql6A+UbDg56rjwArne6nixYVe4dNgBXXRf/KrNTWq5430D09Pf4dU3oQ7syXnT7lgOrvJb3h8ZksnmuSCHVWPyLL8bsDwOxupf9bnEAWGrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=innomotics.com; dmarc=pass action=none
 header.from=innomotics.com; dkim=pass header.d=innomotics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innomotics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOQ+pwQg9H1fx5pLxuWn3V4AWFD745z1NefwRsoJ/Is=;
 b=6W/W8k7y6koXXNYmoKCAybn2XalvDs4GeUaCzPDheWwfqHCAIfQOJVSgC5yG8TuQDn6MziV+92/MCxnl6GjPIyvwFVnDm2rc0EjhzCDJpG5TTdbmjFTXXqr1TlJuJd6CVRwuWpk0eAcOzM+gSU4qWqPfzBPvYcWm+2HQLjlt4r/Dm0pngEru6CL3Nd7Ts3jBwvK72VNMAIkJQ2OCscjbPQurVTG3HvogwX6j1I57LmvMLX0fM9mHlVrUI/ivFGQt6eeQ0UKZ13+V6UzC1ph1FVM4yRjG5ewYxYtufTfRxY7tRuhcE4n9IJwIRNWVY86Ie4Flh5RIjjBnkr96rSBkYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=innomotics.com;
Received: from FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::1af)
 by BEZP281MB1959.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:5f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 22:12:55 +0000
Received: from FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4db0:74ab:67b3:b6]) by FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4db0:74ab:67b3:b6%7]) with mapi id 15.20.9094.018; Fri, 5 Sep 2025
 22:12:55 +0000
Message-ID: <41515d85-7afd-4c4a-b0b3-4cd902ca5677@innomotics.com>
Date: Sat, 6 Sep 2025 00:12:54 +0200
User-Agent: Thunderbird Daily
Subject: Re: [Bug] Compat objects not added to CLAR_TEST_PROG
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <d8d4266e-838c-488e-9aaf-4a1be0169795@innomotics.com>
 <20250905213708.GB612697@coredump.intra.peff.net>
From: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
In-Reply-To: <20250905213708.GB612697@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:82::7) To FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::1af)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFFBD1D31FB:EE_|BEZP281MB1959:EE_
X-MS-Office365-Filtering-Correlation-Id: c8379304-37f6-4d4d-f17b-08ddecc95d4e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1ZnQldBOVpyS0c1TmMrL0FpUDdUVlhZUkQySUJ2cFBTR3ZvT1ZMc3Z0VVJx?=
 =?utf-8?B?Z3ZJQWtuT1EyQ3RRTGE5NG5EUXVJVVQ4OVdXV3MwRUVoaFNWVjJ0aWg5anBX?=
 =?utf-8?B?UWpuK3BCMWZpWWV4QkVZN2QrQ3JvdE1INVJXT1NjV1NwZUZkeTJMN0w0bjRw?=
 =?utf-8?B?OC8xM28zSEVZdkdBT290QmlqUVZvQTg5VFAyMFg3eFE0c2VCVjhST0Z5NFhp?=
 =?utf-8?B?NU1oNmV5eU9iQU9nY0Y2NHFhalhRVHhyVWFySWg3Vm02b0JXbEQwTzdmTUUr?=
 =?utf-8?B?Qi9NRjFNTlZ6N2FKNEU1bnVoWmZ6ZUoyeEdHVm9QM3lSSFdnRHVGd255eXVq?=
 =?utf-8?B?V2JlSFVFMTNSNGdQdmdSQ2tCRVdmb1pVSTVnNy83UFh2SnhrUHdwYVIvejVx?=
 =?utf-8?B?b0V1MDR1aHp0bkE1T2hpeW1ES05qZWphNUIrSENsamM0TlNVSzU2SWR0TGtv?=
 =?utf-8?B?cmF0WHRScnJVTmlZM2FTbXdZNy9zV2pQbklXcEYwNkNLQWM0TE12bWdzTlFJ?=
 =?utf-8?B?SitrTGs3SVpoamY5K0Y0N1JsUVBGWWYvck95eHo2YlNlNEI1TlpFNUhsRWs5?=
 =?utf-8?B?WGZSOCs0OEYzRWxKWDZLVkZJZWtyQ1hhU3k5NVJzMU5CaEVTbklGZ3Y0eXA4?=
 =?utf-8?B?UDJDaW1SS0EvV2Mvdjg3TnB6c0d3d2RrdFBwK0sxOVl0UXI0ZEExUkN4aVV4?=
 =?utf-8?B?cUo1cDhXREw0d0c1elNCSEV4ZWxNOTVCMmVMUGttdFZucjU0VWpIZWZ0VDlT?=
 =?utf-8?B?cVM2Ry9Eam81SVN4QytJTlVQdHFaSnZKSnhtZDZjN2pvMHRkVGhKNDB2WVhH?=
 =?utf-8?B?UnJMOGt0WXVCbk5FY1RpOW5nRmx6WHVqRit4QWdsSEtnRzJxSm0rVU00SFla?=
 =?utf-8?B?Z3B2Mkh1cnVaTTNHeDliQzUxNTdCYXdIZ25vaGZxc093cWZsdEdlNDFQeDhm?=
 =?utf-8?B?R28ySEJweGpoa2kwVGRQU0ptbkxZSGZyYjBuZTBRdTkvMFlOM0lFa3VHSCsr?=
 =?utf-8?B?eVBHQjc0VEdGZ1g1S0xkZ1pHRHVUTmROaEdVc3BEamwxeENuRS8xVW1FU0pm?=
 =?utf-8?B?RFhwb1ZYUXZUbmdtWW5xTVQzc29PWnpOVGI0djJZc1hOVzRQVWhGZmZhUFFJ?=
 =?utf-8?B?MFpVcllSVDlBUjlvNkhIUU9OS3hVT1dydW95a2lEL1llV3M0dnVpbGZaS3FP?=
 =?utf-8?B?YTltNlJUTGo0RGhOVXJnMVJCMmtzRUxKSWNzUHhub1ZpMi96cDlzWHhiQ3V2?=
 =?utf-8?B?YzNZeUdvNktYRHZMWEhkZDNkZEJURG9NQ1NuUVhxdk1YeENKdXkwSmM1VTlI?=
 =?utf-8?B?SFdMeUFlRWhnTktuRFJWMU12Z1BtMkpmN0hIS2VtWkF2bzFmVHJhdnVna3k5?=
 =?utf-8?B?Y25DdklzTERrNG5yRGgxZXFyL1VSRHR3SW9VYXRtSWxzVE9kWm9wa1NEMTVK?=
 =?utf-8?B?YjhPcm9JNHUvT3FNOXl1Uk4yK1lLWTZXNkNPWEZFdDJvMFk5c2hRVTF6L014?=
 =?utf-8?B?S2QzZHVvc1NWTHJ5RThmOU1pMURLcFBXY1hNeFVaRHkzQUM3VFF6RzZNUzd3?=
 =?utf-8?B?Q1Qvcy9HOWhzV25saTc4em5YM2pzSlRHdzlJOXpoMWF4RkZuQ21YK2ZLd244?=
 =?utf-8?B?RkxmOVVSamdOSDBUNjZyT0xlQTVzSGZoUlF3RFpJZFIwUU5Nd1hFU0cvQnR2?=
 =?utf-8?B?ZHB0WVcwZmxtZ3p4SzFMQTlXdS95cVZNdXNmTkIrTHo3U214S3Y2ZkZPZ1dP?=
 =?utf-8?B?V2JUci82am9vTjJSSElwL0YxS1R5dXpTRXBEVTlmdGR4WDJvVzIvU3dZSlE4?=
 =?utf-8?Q?WLBqefQeFDKzLYt1umToqD7YEXpL857OpZydA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clBkYTdZU1RrRHBnZHZjK2JDS1pPMEZOZHFvU2V1UitwYk5QMXBOeGdheWx6?=
 =?utf-8?B?cmlYQlhTUE4zdG40NEFTZzNWWjZXNGFoVkkvQVB5dm15a3huNHJheFpkM1FZ?=
 =?utf-8?B?eUxaWmdCYzZqR08wU3ZIRUtqRWNvWVR5UVlleHFMUENoemxOdmRSeTNiektu?=
 =?utf-8?B?QU1acGpTWkNjdUZaUzVlSFgxWGZsdVZyNGlJUUZFSTBhYU1xQkducU9mVWJP?=
 =?utf-8?B?Y0Q1TkpSQUNOVnFReXo3Z1EvNlBwOVpYWlUyR2NaRGRBcXlCRnU1WWdqaW5R?=
 =?utf-8?B?bHRNM3Y5eHczajc2SmhrRk5aNWZKYXBKR09ubDhqL09oclpyb3RyUFNaMmNY?=
 =?utf-8?B?ejVFZ2V6UVE4QXNyYzhwNkV1QlUwZmZpV3A5KzNZSTZWVUNkWnJHQXRjYm52?=
 =?utf-8?B?aTBRbHJqWTV4SThKYWFQblFKTDBhek4yd1pqeDFpdEE3SGpUQzg1UnBFS0hQ?=
 =?utf-8?B?YXNnd0ZyUm1yLy9Yejhwd3drRHE1WWJTNnFnakw3dng3M29BTjF1NG9jbm5F?=
 =?utf-8?B?aVVhSmpvWTVnb1dGUXlUK2dZQU13OUsyS3BXT3lINWxsU2FjcXJYQlN0UFlp?=
 =?utf-8?B?WFJEMjB3aEFWdFBnK01CRVozdndwQTlhRXlFeGlhTS9aUmVWZG51ZDlEYlF1?=
 =?utf-8?B?amFFcS9nQUpJUytmYkxJM3NzcVdXS1Y4UTFoQzFCK3IraUw2dmxoeTZNQnlh?=
 =?utf-8?B?RUI4bUxCUkxWdjhMcjBaKzBQTHczRzBCSkgwNWpCR0s5TllIM0JZbWhXMm5G?=
 =?utf-8?B?eWZyeFdCeWZNTitIK2g5bXhKSUhaWWFxT3J5MkwxSUZucTdmRVFKekk5WlM5?=
 =?utf-8?B?M3E0amZvV0FBbjRYdkQ1SzdnS0o1V3ZXOE5OZm1qbWZNMytTRUIrTnZMWGpr?=
 =?utf-8?B?MFpJdi9qTEZremhGakxOeXUyc2FIVXg2bU9jMlY1NnFSU2xkNXZMQmk4TWNZ?=
 =?utf-8?B?L0dkcS81OWpXYlk2VU94bHdZa3dDbUhMK2JzamhhSXdxd2F5Q2tYVGhrNnZ1?=
 =?utf-8?B?QzV0STVRZG9vdGJjRGVMOHQra2hoOTNycnk1Q21uK2t1b28vemRTVU5MS1Z5?=
 =?utf-8?B?SVpEeENiY3lCWHdCRzhzaVdzWmdralYvZk1vQ3Zoc0FhU2RsbGErTksrZ1F2?=
 =?utf-8?B?Uk5ZUEd5amVDcndxMFNvNTRYcjlpMGlWL1pCRFBCaGdld01SNWNSc1RYVjYr?=
 =?utf-8?B?TGRYQkZnMUkrODViVCttbjVDazV4Y3ZCWDNGM0VhOC9TUDAxeC9LbUNsV0Vp?=
 =?utf-8?B?TnVOWGE3UklQR3JJbDJMa0VJcVl6ZnlQMFI2Z3pZaXMvRnFZWERhdUZVYnFp?=
 =?utf-8?B?b1RPNkxZaGd3d2tMbDRyMVBRMzBhQlNMbyt6STgzMlIwY1BQc0tJd1pYTXlY?=
 =?utf-8?B?M2pLcjdPWFkxSjBQaHgvNm00MGVVbi9EcjN0eTVmMVNhcmpJTFhHLzIrRVJD?=
 =?utf-8?B?ejJlQVB5V3V0WjRuL3I4Nlhmai9DaUhJc0QyeDBJcFByS3VBTWhOZHZlZVhK?=
 =?utf-8?B?Y3pEazByM3NBK3lxZjdNWGlZTlp3aWJjay9HUHJRSGloQVpSVUVOeUgrcVlv?=
 =?utf-8?B?TW94MVlmeVVOdEd4Vjd1UndkWFpNR0RCUjhRV3VsbndNU0ptTi90bUlBaVJm?=
 =?utf-8?B?ZitZclZ2UnNTZGZTOFM4cFdDK3ZNbXhjb0FRS0JmYy95SFd5N2wyUnNPSGQ4?=
 =?utf-8?B?V2Fabm9DS0N0VFQzc1dISW9lbW1LYWZWakVONm1SMEMzUlc2QmFJaG5lZUds?=
 =?utf-8?B?VEFLQlNNa1MxM3BDNnVHYXZHRmZ5aTdiOTNBR1NYb3VTR3FSSWlVKzRjOVp6?=
 =?utf-8?B?LzdDS29hTUZ2MlBzYUl4SkhkK2RuOUkvQ2Y2MzVveUdRdmthNm9zM2NPd21z?=
 =?utf-8?B?TFJEd3NkdTFBSnZuTDNvNlJUUEJTTkZ5bDlyREl1eG00STFBOXVPbW1WRkdI?=
 =?utf-8?B?MmhzNHZiRWxFQXNiU0FqVzdoT1ZSRE5CVmxRZG84WXZaM1EzZG51bDBhNmg3?=
 =?utf-8?B?Tm1ZdHY4SWNacTZ6dXNJVDZST2UxeWpzODF4eEN0bXllWm5EWjhCcVBEZWxW?=
 =?utf-8?B?RDJMczg4MHR2c3MvRTEwSzFHR0xyVWw2Rlo0U3BRUmVYS0I0dEttTGFTYkQr?=
 =?utf-8?B?M1NuT2RrUmJWVXJxdTlvb1JUL09INFhITUZhRWpKcGM1bU9BdGdQZ2p2ZnBC?=
 =?utf-8?Q?MLOnhFkmcOw6YllcAKUXoAw=3D?=
X-OriginatorOrg: innomotics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8379304-37f6-4d4d-f17b-08ddecc95d4e
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 22:12:55.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 698c6ffb-74e3-4a84-be68-f22d8d3201a3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EinuO4H4YXT9T0jDzt/5Ya+sdgbc+Ikqr6X9SwL1mIjn3o9k4pbmVIeHLjsSfvJe68u+lYb7/4u6+VD/W7TUsv0LHTGxe2Z/BUR/UiKBXRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB1959

Let's have a look:

On 2025-09-05 23:37, Jeff King wrote:
> [+cc pks for clar portability]
> 
> On Fri, Sep 05, 2025 at 03:19:50PM +0200, Osipov, Michael (IN IT IN) wrote:
> 
>> I am building Git 2.51.0 on HP-UX 11.31, previous releases went smoothly.
> 
> Neat, today I learned HP-UX is still alive and kicking. :)
> 
> Half of your patch makes sense to me, but I'm puzzled by the other half.
> This:
> 
>> diff -u -ur t/unit-tests/clar/clar/sandbox.h git-2.51.0.patched/t/unit-tests/clar/clar/sandbox.h
>> --- t/unit-tests/clar/clar/sandbox.h	2025-08-18 02:35:38 +0200
>> +++ t/unit-tests/clar/clar/sandbox.h	2025-09-05 14:10:52 +0200
>> @@ -2,6 +2,8 @@
>>   #include <sys/syslimits.h>
>>   #endif
>>   
>> +#include "../../../../compat/posix.h"
>> +
>>   static char _clar_path[4096 + 1];
>>   
>>   static int
> 
> ...seems like an obvious improvement. If we are compiling any C code,
> we'd want our compatibility macros, etc. Although it does get a little
> funny, as the contents of clar/ are imported from elsewhere, and now
> we're modifying that.
> 
> It looks like clar tries to handle portability on its own, so I guess
> another route is for it to add its own mkdtemp wrapper, and we'd import
> that fixed version. But it really feels like we're duplicating effort.

I am open to improvements here to get in the compat prototypes...

> The other half of your patch is the linking side:
> 
>> diff -u -ur Makefile Makefile
>> --- Makefile	2025-08-18 02:35:38 +0200
>> +++ Makefile	2025-09-05 14:34:43 +0200
>> @@ -3933,7 +3933,7 @@
>>   $(UNIT_TEST_DIR)/clar/clar.o: $(UNIT_TEST_DIR)/clar.suite
>>   $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
>>   $(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
>> -$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS
>> +$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(COMPAT_OBJS) $(GITLIBS) GIT-LDFLAGS
>>   	$(call mkdir_p_parent_template)
>>   	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>>   
> 
> but I'm not sure that should be necessary. The compat objects are
> included in libgit.a, and we should be linking against that when we
> build the unit-test executable. At any rate, building with NO_MKDTEMP=1
> for me on Linux does successfully find gitmkdtemp().  Are you sure this
> half of the patch was needed?

libgit.a does indeed contain the symbol:
> root@deblndw002x:/var/tmp/ports/work/git-2.51.0.patched
> # nm ./libgit.a  | grep mkdtemp
> [595]    |            0|       0|FUNC |GLOB |0|   UNDEF|gitmkdtemp
> [204]    |            0|       0|FUNC |GLOB |0|   UNDEF|gitmkdtemp
> [278]    |            0|       0|FUNC |GLOB |0|   UNDEF|gitmkdtemp
> Symbols from ./libgit.a[mkdtemp.o]:
> [1]      |            0|       0|FILE |LOCAL|0|     ABS|compat/mkdtemp.c
> [110]    |            0|     272|FUNC |GLOB |0|   .text|gitmkdtemp

Let's try to revert the second half and see:
...and you are right. Since the include does properly replace the 
missing symbol at compiliation time, linking now works expecte:
> root@deblndw002x:/var/tmp/ports/work/git-2.51.0.patched
> # nm t/unit-tests/bin/unit-tests | grep mkdtemp
> [7332]   |            0|       0|FILE |LOCAL|0|     ABS|compat/mkdtemp.c
> [16404]  |     73286896|     272|FUNC |GLOB |0|   .text|gitmkdtemp

We can drop one hunk from the patch, great!

Michael
