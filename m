Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B502125D538
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458781; cv=fail; b=D5vqJDJ+o9/P9bdtBZiJvNQ9vyX9TF9qC1OYPaYc7C+XSR4EZ8yLwF9lR8dHEhusjEciVZkBd96ebXsrUrX8jz/0W0I8BJxr6UXTf8POooQlsG8PFBvDPwnMxAwpcDtJJjQjHCsDMRED6HXPSFRrj7OvthUIYaeo4+kBJ8FujWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458781; c=relaxed/simple;
	bh=ciGjbfjt2FKhMxD5OMd9rfFBCWTYCV9XOr9TOQsv8Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdaYqtkkQmDsLhlqYZwNIR3EqNhltMFconvd9n5TaTXoBitw8vrcqwuPCXYBD0953lfjRwRlyf9eL6HUrnitvPuzSjv1JLGG3zsCcD70nrlWnZPteX06JNjpss1UlfX+Ju2KxUV//OvL761a+gWSrjdaQkaLkGeZJ2+LYgNt89U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=NHDipbhe; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="NHDipbhe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kelBDT+dTy9sDrHXzlrnnwdGymPFOkE80LFVsn/dPG/jpalzMBmMQwzQgfdwjweudGL/7YlTjwJ94qn8Qk/cABAfBBPqENhN7BVXb0VqfoqWbXQwN+VZSuHvq5PMYChy7UYOPCAhId01JblEoswAgrmN1MEevyecRwlEXM9IL45fZoo3Qj2tmtYmYgFrz/m9TH6/eVNMGx4GYj16yo+D9eAEF5CMybroDSnEQuYhcPGW8XyYo9jNEv1+2ccDizQpSTXH6wfUswWjaE9Y77Tn9xtVeDZN98Dpvtfu0HcXxDbq+8OAICecZKBUqEx7JJ5Z7inGflf+4nMq5UfepwVYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WXeokw7DK0iCpWAXOWmAF8It8o2A8peAjtOOKKvn61U=;
 b=zJP5ceDZuGJSwCP0CTqsVgohKmAQ6PYtGTMCcWzHIPNGtDklnwRHAoRo4M6UVzkUyn+7eQAHZj+B8VgRJLxH/BdwXCtoHwKjyNUbY/CvFsPpnRyVwhnSTew7vLWFVPaD7fDedSQMrKx0PB2GGPe/VOLycrtkIhQd6yObUEPBGqDMrEDB/+PO5fwWlEAoV5N5535StjZ00c9MOR7SH6J7QjCcNZk8dCzbNLGIsb8BNeDsxbVwM0948HDQ57vI6KYzsNk/gBX2E137qBDzMrgwR2OxhJyqp8u/LKWa8gOScEOhCtQFBIZL05mMB+fum9q//TgxXs6xIA3QzXJ34NHm9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WXeokw7DK0iCpWAXOWmAF8It8o2A8peAjtOOKKvn61U=;
 b=NHDipbheDN/8O+J43PurIhV/VxtFpXXx9ZK7ZG6SUW41gI0ht0BP4N4afoRKfIFwdswpzLKApO9JzthrSMXvbMwhjQeb9Q8djG1/tF9cAQAYZxpxYmepWCoE0HEZWZoipWrt8+CoJoxjIa0qgo6dQD022czljzzeAmq8tZLMFktRyYG0bG3KvJfkD5IBOjBJ8g0hLSxoWFkYIfrtPYxqTOKxV/ewAftz7z6mAeLKf9qRy1nEwb0r2ZiwJS/Bm/kNFn1AS7eDMyy70m9OBL44FUUYrvrXUnqdfnp40bVXsc3H2fi6GLSeODkhH25z4pRldngT2bErxJgDaP027axZHw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7742.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Mon, 5 May
 2025 15:26:10 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 15:26:10 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
Date: Mon,  5 May 2025 15:23:03 +0000
Message-ID:
 <PN3PR01MB95971B8A202ADEA412010B35B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25d::11) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250505152557.4937-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c497ba9-25be-4e44-2b27-08dd8be9295e
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnsOjthBlzVaZIxSWkFCubLaz0qezkKHC8GQQlOOmJmWGW122LBle4KXdonwQyz7cnXxjHBqm+Tw3G5etF8OXU9Ek0/9YZrLzi0sUqnp3pT0II06KETNVlTcbDP0X1svF0W1wsV1diYKdPXg6QDH9r5TVf2CbpwjlkvsidJkmZ1XdZf3iQxwwcGLHVj4FLVD57TdOIsJbkyzkAH+iloNou4xBkQ01D8ogOfAT+NpZnpbLLDoXoX24RjyuU61WjJGuZ/8cZfs9y2eh93WvKZNIWEI9FQ6BffDSFppBTCfwVxIUeyztR/x2e1OMQ3WOe7SeOFJp2Keq6Wo6GIC2uAFSXqzR6IjS28xBkEJ/9/9FWO5oIsSMny6Je1LzbN/61tUgmEO/LvgYbHQRuWld0DEdwMDguLOBwfkKXfEQjvEMnnmskau80vnuwhfhPszxLG8WELScOuoWa1C5ltfFg5Xr7b/tkWdcnwVw4QBFVB//4vcPHqaLINkKYQutcz5O1RaFb00b+OOiI8U4dx4d0jhv74WEqo1pfmIRQWD4D6Or4f/qmmzDu8Vgr3jAChiclrQuiBPl8YH1F/VQOhin6+260+jMRBV/2d9+t79WJGbUDOAdhhT8jcOwTl3ko2zWFUjRi5hQvaVNfW+nL5C3Ob8s9FhYTrWqOwWAGNG1jGA6AhVIR2HplXjbKxGPV6xmmkRJYEBvcpvxdt7BA4FxhQVFDmjJllbcWUfy9mTdhNRQbTig=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|7092599003|19110799003|461199028|8060799006|10035399004|440099028|4302099013|3412199025|19111999003|41001999003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EOIjhjmOYexylZKcKkccrzgDeoQeQlUQwL62Xxjrotls62MW5ats6xprQtKo?=
 =?us-ascii?Q?yDfIMC37fHkurChREuoMcJmgp+GMzJV1xHzgUN6e8dsYyMjETFQSl8en2Emv?=
 =?us-ascii?Q?h4JW4IraWxbYQsRYmgxTFbKUpNAu5lRduOXWy7W0FbTje+jQszscH50dUozk?=
 =?us-ascii?Q?LZXAW9/YhcErCp/HDf0cduM7Z9c+V3skzyvKIV946l7XM8spIUvmOuExL/3f?=
 =?us-ascii?Q?Lls55z6u9+lFGV+LPfLyeFqFHB8MXqJL87rOfR1a9Q9+dywN1oggFcqpnf0t?=
 =?us-ascii?Q?opA7YVEVwrGHaKwruYXmafELWTfxLVogG4NYVoAjifxiIQHa3492RFtZN0Ou?=
 =?us-ascii?Q?Z6PBOxzTibpzBSD3n3UX9H0wCeMU4dyJZOvEliZGshX2R6aTFv+YtBvFRQhh?=
 =?us-ascii?Q?EYGofO43AmM7SuidzksJ7sfFnWa2mMX3kLrwDt+aE8hZIT1AjtxxyqdNG41S?=
 =?us-ascii?Q?tupEC4AN0FAOCjKv7Dsi7wfoAAs+EPHNS48xYcYSx0jd4VvWXu2UM2XYKyFj?=
 =?us-ascii?Q?DKUYHAUikdKpTh2gnuazS+TrUQeUvEy9U4gm2qpd+tPBj6lRDjqyYSHjQ8B5?=
 =?us-ascii?Q?OYLHSvY1zOg/SkhGdEiBq0FewBhfWf2aOH+3jGoUPH7Pfm5uE7OiDzjE3qcT?=
 =?us-ascii?Q?8frfrieqekVKdfQ7kmrTocNH7agxg53o1U9hTzjdxcUcI2Zr+YY8imJ7uE5y?=
 =?us-ascii?Q?zgtyPo0kLdjpD3FzT+Kq/sQFAZfdJWhw8ztn9+9rHhdk3DO/Rpu9augRW/3V?=
 =?us-ascii?Q?xtBvPF33zucjqpjfY2zTLFVJHt0Wt1m+gWsh8o8RE5aeFST2dDFTPTrKMRbJ?=
 =?us-ascii?Q?o2/BDRWMctf9Ir3KAjdBqmB7Yf/ZORsU3r2716vhHdPE+FfLkyRU7Sw9lGUj?=
 =?us-ascii?Q?2rk6xmS71VJuqaskGMyfzlLTDwTd861Lft7esguK4kVwC8doxAcoZQqqE3q/?=
 =?us-ascii?Q?Nw6JHQwtOEBBqbksHRZNOIn1VkmMciKKGaF8w+1foxtB+1o98o3zhG+jZhoz?=
 =?us-ascii?Q?oD8fIM3dFoCRo+PjnUzgUMucOzsM8AGFlhn47ZhZiKuAwSzDL63oT38RlfEB?=
 =?us-ascii?Q?x3HKPG2iyImJoV0fs4UaFaiIiP/kYzQmYGnVRNxzstwudQNmVC1zyeQ+Mkdn?=
 =?us-ascii?Q?/yFfdq+3IMKpO75O3BYnri1HJEHZk4Wv+a2DFaR2PVWMT83iwi+/kQ3b5JTY?=
 =?us-ascii?Q?pBv50AtMzTcyZ60WisS8Hj8F3vzbrvXfYKVaD7+muDIYfS/92ORupG8fU7mB?=
 =?us-ascii?Q?QdGUWDe2SpouHUSNBEWQnZakdk5ViNKKbHuu/SYUgqNwA9iq6lr0yhebcS4i?=
 =?us-ascii?Q?pcwOsAHNEwzGPJfTtj5XtWpuB8fxqfvF2SU/5LQ0YrigUA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qnymf0xgm3plzB3xzKPTYgsBGpWh7e62/TC7bDU/8l0a+feUU8z4821m7Iex?=
 =?us-ascii?Q?0CuxKebon5zvShpgcc6hulLcJ86prPo1kOV5wUWKTLDNxz5D0CU2UN+oIdx7?=
 =?us-ascii?Q?zif6UCdqt+Q4m344faXxExHRbBohgtbEwboZ6oVDGqBWquuWZzPc1PBuzBUy?=
 =?us-ascii?Q?8Ckbd1wVhQX+gpSOwLBCxoVSLGvLDKQVv1cifvZQ5JF/wQPrnO6dVK/CuVOm?=
 =?us-ascii?Q?Zi8lLg0Ipw7GGrVA2r8GqLWVtUqzVkra9RjpoQU04q4QGfCgh5JkXHJ49K7c?=
 =?us-ascii?Q?fwVGSQM9MnGLQMzwUPBcVBcm5myYp8AF8pb4gz7oBfZivwZuZWfqfzmTwyw9?=
 =?us-ascii?Q?7f5cON1wtwIg+iQ5zpZIM2N+IjubotnwnUlDKiyGjJsZEWCCJ6lRqAfMU2r1?=
 =?us-ascii?Q?lYymktJdwftkIxkuGDrg3VETf+hoWBofhVq8aYcLtcYhg4XLZSySc4Ix7gnE?=
 =?us-ascii?Q?yynTzxT8vaCT+WSQ+QVDDuzjJEp4bj22w2khRBGZ75e26rQ08TkGAwygEKKW?=
 =?us-ascii?Q?lvgixJCCeEV7R8HkAQlPJzD+cv81kU02tem1eaXCdQAzGaqYGJ5vGdkdzqos?=
 =?us-ascii?Q?o5xhYBfSaEAM9Qbe0OwKFF+dgBZUxBipSXUw2+/obTQ8YSgr96Dvc9/ILZmX?=
 =?us-ascii?Q?Oyr2xaRGHcmNtWaTDMvKDqFbkDlLZABvE/GRVcWib94NUYCJfGAvs8ahNWnl?=
 =?us-ascii?Q?CzWC0WnIVrEQxcGztKbnNFxlLOfq9mqYYYRgcf0KmCB6h9ez769bXEyhPeuT?=
 =?us-ascii?Q?C9/ighsAwNrVmozHKz9DWfNU/nQ25NzOtq1yCOWhPPq0rV7ioVlnEUendKwg?=
 =?us-ascii?Q?xb+lG0wNVeig3oKgdK26UsI14tZNR0hxVQ1uPj3cv0mJG6m5mlaglkFLEoIK?=
 =?us-ascii?Q?ao31v1gE0oAh17RXzVZC6vaE/UxU9DmOuVhaCdpEEvT+mojYxu5cdnvWJ0Oj?=
 =?us-ascii?Q?pAz14MeDTBF2t0u2TKQYYQu9UoQIo/vYyg1Nd1Lj2F11OIbnNjsWFbU8w0Aa?=
 =?us-ascii?Q?haNohaSuJ5g7C8BIA+nD6kCSRHLq9pdKMg52y0EOf137wDFuxH6cDn8PIoAL?=
 =?us-ascii?Q?wJTtBHKZNrVVVuFExW57kf77459f0+PvPtCa20fTrD4Xg3VgpdtCurCOpLbd?=
 =?us-ascii?Q?Rc1pV4bHK/P+h6IAbWe56AiVoONoG33BY99PMMZMrh9XtWM0LSQq3vTihk90?=
 =?us-ascii?Q?SsJfitQLEjEbrxIpcppp9geX9DKmxIYXhVoqJgKbzV3PG6geWPCsGCfgDYg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c497ba9-25be-4e44-2b27-08dd8be9295e
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:26:09.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7742

The current implementation of a valid Fully Qualified Domain Name
is not that strict. It just checks whether it has a dot (.) and
if using macOS, it should not end with .local. As per RFC1035[1],
from what I understood, the following checks need to be done:

- The domain must contain atleast one dot
- Each label (separated by dots) must be 1-63 characters long
- Labels must start and end with an alphanumeric character
- Labels can contain alphanumeric characters and hyphens

Here are some examples of valid and invalid labels:

'example.com',          # Valid
'sub.example.com',      # Valid
'my-domain.org',        # Valid
'localhost',            # Invalid (no dot)
'MacBook..',            # Invalid (double dots)
'-example.com',         # Invalid (starts with a hyphen)
'example-.com',         # Invalid (ends with a hyphen)
'example..com',         # Invalid (double dots)
'example',              # Invalid (no TLD)
'example.local',        # Invalid on macOS
'valid-domain.co.uk',   # Valid
'123.example.com',      # Valid
'example.com.',         # Invalid (trailing dot)
'toolonglabeltoolonglabeltoolonglabeltoolonglabeltoolonglabeltoolonglabel.com', # Invalid (label > 63 chars)

Due to current implementation, I was not able to send emails from
Ubuntu. Upon debugging, I found that the SMTP domain was coming out
to be "MacBook.." and was being considered as valid. As a result
the script was failing. The debug logs with the failed script are
below:

Net::SMTP>>> Net::SMTP(3.15)
Net::SMTP>>>   Net::Cmd(3.15)
Net::SMTP>>>     Exporter(5.77)
Net::SMTP>>>   IO::Socket::IP(0.4101)
Net::SMTP>>>     IO::Socket(1.52)
Net::SMTP>>>       IO::Handle(1.52)
Net::SMTP=GLOB(0x5db4351225f8)<<< 220 BMXPR01CA0083.outlook.office365.com Microsoft ESMTP MAIL Service ready at Sat, 26 Apr 2025 18:06:30 +0000 [08DD842467C8274D]
Net::SMTP=GLOB(0x5db4351225f8)>>> EHLO MacBook..
Net::SMTP=GLOB(0x5db4351225f8)<<< 501 5.5.4 Invalid domain name [BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM 2025-04-26T18:06:35.781Z 08DD842467C8274D]
Net::SMTP=GLOB(0x5db4351225f8)>>> HELO MacBook..
Net::SMTP=GLOB(0x5db4351225f8)<<< 501 5.5.4 Invalid domain name [BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM 2025-04-26T18:06:40.828Z 08DD842467C8274D]
Unable to initialize SMTP properly. Check config and use --smtp-debug. VALUES: server=smtp.office365.com encryption=tls hello=MacBook.. port=587 at ../git-send-email.perl line 1727.

With this patch, it was fixed and was being considered as an invalid
domain. Logs after this patch:

Net::SMTP>>> Net::SMTP(3.15)
Net::SMTP>>>   Net::Cmd(3.15)
Net::SMTP>>>     Exporter(5.77)
Net::SMTP>>>   IO::Socket::IP(0.4101)
Net::SMTP>>>     IO::Socket(1.52)
Net::SMTP>>>       IO::Handle(1.52)
Net::SMTP=GLOB(0x58c8af71e930)<<< 220 PN4P287CA0064.outlook.office365.com Microsoft ESMTP MAIL Service ready at Sat, 26 Apr 2025 18:08:13 +0000 [08DD84B323498C1A]
Net::SMTP=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello [2401:4900:a052:31f0:9beb:e613:56e8:f897]
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-SIZE 157286400
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-PIPELINING
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-DSN
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-STARTTLS
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-8BITMIME
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-BINARYMIME
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-CHUNKING
Net::SMTP=GLOB(0x58c8af71e930)<<< 250 SMTPUTF8
Net::SMTP=GLOB(0x58c8af71e930)>>> STARTTLS
Net::SMTP=GLOB(0x58c8af71e930)<<< 220 2.0.0 SMTP server ready
Net::SMTP::_SSL=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello [2401:4900:a052:31f0:9beb:e613:56e8:f897]
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-SIZE 157286400
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PIPELINING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-DSN
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-AUTH LOGIN XOAUTH2
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-8BITMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-BINARYMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-CHUNKING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250 SMTPUTF8
Net::SMTP::_SSL=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello [2401:4900:a052:31f0:9beb:e613:56e8:f897]
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-SIZE 157286400
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PIPELINING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-DSN
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-AUTH LOGIN XOAUTH2
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-8BITMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-BINARYMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-CHUNKING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250 SMTPUTF8
Net::SMTP::_SSL=GLOB(0x58c8af71e930)>>> AUTH XOAUTH2 (OAuth2 access token removed for security)
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 235 2.7.0 Authentication successful

[1]: https://datatracker.ietf.org/doc/html/rfc1035

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 4215f8f7e9..4c143e24bf 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1359,7 +1359,8 @@ sub process_address_list {
 
 sub valid_fqdn {
 	my $domain = shift;
-	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
+	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/)
+		&& $domain  =~ /^(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.[A-Za-z0-9-]{1,63})+$/;
 }
 
 sub maildomain_net {
-- 
2.49.0

