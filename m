Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010008.outbound.protection.outlook.com [52.103.68.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431F5335BC1
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756284882; cv=fail; b=WA00WkhBP6ug4z5YvJ7B36L2eyiHqZFONWOcugxqex+DjZLNGXmyYmLI0qfRx7663XNG+ehxG7FA0BmGo3Bhzx0WjG3APZ5LqfiId3gc4t2CjP3b9vfTcPZ4QK1U1yZnpU6ENWy4pklvzNSGsffjyjS7wSP3c/OH9KxkUgW88uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756284882; c=relaxed/simple;
	bh=qSSS0+PwnQ3SBCPvEqZLeNKp1fXFrbv/SZ4tS1JMYdc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=An1LNnH1le9UfLGfQNJ5lIzANbAfcL/dR9JLlh9mQT2C52AbrpHKaDOI+36FgY6SxtZjZqMUXD3joWpUR4n5immzx+cn7TjDrIG7EDNVq04G2RK8pgtK6HMJHXWF67d0LS0rFxOxZBdFYJi30WRHbIkfCV+nFxH2B2N44yZGN9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Eyph3rdo; arc=fail smtp.client-ip=52.103.68.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Eyph3rdo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnDcKnaN5+K436JXvQbSxREbtDCTMfluBfSkvSqm3Qn+fWtFbgj+Z2KlGiumDlDkNiXmNV9d2xZJZbhI/pB09ROmb35GSdmmtAOVsRgfYFqE3Hc6F9uTr9kqaZfQFafmDARASQoX+jZMsT289D/LqFJFrRH6MkHqLXyDLBZchvqgXoQEznO6ebE4wfm24V+EZArsMvi36oHVeYiWPBdgB/c6eRc1/6X02gsOkiYNxTwr/loDykmSnz98P2ZCPY4r9LLccNjbmeizqLQpOjDvV7aOMcSurXEyZC7tudv7dh2XG5bzl03ZNVghEcowiM7cZDLNFHhEiy63nchPKl1umw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPB85ONfZwBimzFGyv83KKhE4722LkejqYPii4hjN9c=;
 b=UDJNrvRDgnj4EA5lfHjIGcOB3ZiEo8KvxNaYCPCZljvwRy3ldRdfemdD/jD4t5gmgbfAvtus1+iWLuNVMnOF9bFGtA4TKq+yuZoBQbL4LxfJh2jaCPXdrBCRyvBx57oXUKvfgXH2rLjAAKPiXpbtXaU6y7W+LDGPEt43l3qJTGLQRcXZv1ebLxm4OYJW3RsQVm29Wnu4NgL6ZbWMRJ51AbPWMJEbcNKPfuwIcxJc7KDZ3zeRT09V4XYLgdnVOiEzz3lDfJIBAPKmTeC1C2dWCpEI8FKOc+54U0opXb4mTJEBvysCCn4P/o+C9ahILGcjNMDZwVT4op4zv9nRoCwsDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPB85ONfZwBimzFGyv83KKhE4722LkejqYPii4hjN9c=;
 b=Eyph3rdoJ1mZ9MNA5bHSMx8sWbsAklsjBv9L6CYrVHmTR6OXdFRRw1Sp6NRgOj6QK+WgNbkoAliZicqpWKi152Acn2gyXQdCONF9HgK8NGfUxIaqbunobiLBvS0SNYgLUUZCQ3I06cU5dYiTynKCKLxE6LWZzgi0+FZSN/FPwALIFEUt2g9UzF/h6JKx6delsrs8ALfmpNKJon7vxy2RhXnuFGSRzvDaojxTSD8ZAqCJh5Fs+xF+YWidxbUjupRSpHYg5E5nN2uHBoH0ovrIh408YYxppI958J3GFPz66Xc0Hna1D9jA53Ydk3b4ab8lVyFhVpEGjKXbUs93hCRZ5Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5755.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:48::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Wed, 27 Aug
 2025 08:54:33 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 08:54:33 +0000
Date: Wed, 27 Aug 2025 14:24:31 +0530
From: Aditya Garg <gargaditya08@live.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>,
 Julian Swagemakers <julian@swagemakers.org>,
 Brendan Abolivier <brendan@thunderbird.net>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4=5D_send-email=3A_add_--get-sm?=
 =?US-ASCII?Q?tp-server_option_to_fetch_SMTP_settings?=
User-Agent: Thunderbird for Android
In-Reply-To: <aK5RInMzjC6vuLv_@fruit.crustytoothpaste.net>
References: <20250822151039.36006-1-gargaditya08@live.com> <20250826133936.1569-1-gargaditya08@live.com> <aK5RInMzjC6vuLv_@fruit.crustytoothpaste.net>
Message-ID:
 <PN3PR01MB959731225E912FDCA7308508B838A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BM1P287CA0009.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <35E94BC7-9D46-4EDF-80B3-85F3F4139CAB@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e405df1-99d7-498a-cd69-08dde54757b4
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZlps6CageNK96R3p6oJJ6xNiydprFFyXgjXC0jtbkb+8CrbK4OO2ysYRGJevztlLSNPNXfV5ni6ePPcv3egWDOBaCE8NThn59RGr/IYb39aNMpoheI/EEuR05lNWjTkiKebfkJ9+lklas9Q9N9KGLdm+6Z0/gO5qHxdcyDAIE/Wa2RpASZRgkGORkhSjss5mnrTZsmTF6kyqVRRBjNSI0L2L1ga3gupUxOrDm+H/QxH178xvr8nh0UhBl/l3HsUHOe+CVSczhQepZ0e9KdFwnp+BZWnwyaPGYXVMb3a+9a4O7Spgz0Pn7RpA+rCD0h5T2N2DnhKzSqy3rxoSFwKMJdhRLEhxNwYeDiFLKLTKJs+NRLSij9b9Bd6yi18d9jnRZghQ+zND+/IipJHofk/JYSA1VfdK3QnOgT0HFRK9t2njNptbFeQV/vpMbDh5CyCVNYDjd1D4EO1CaicA+1UYb4ySGUy3Pq3NsqiPUSeaVnjItU5C0mnNl0syGSAPbkyllq2+cFNr+2jJg4ai6xxsqYxO33kSe2klKXmfV8OfGt18qWJCWQOGHTzsd7SeB300nlyBrRvEloPbErBq+KYdJRYS8C9CFD5ZqLsABlUQ3bMFjw/wFJzUmzhkaW2q49CKmpMTSLTWSIaEVm5ErB0UpyvAaryH2yurTt20GQyNLBZhY8wcP4KhsVKzluG4Jk0PkSk4TzyPLRp69qrWATUyRKVLokRMo1MAbO1Vfs3kAc9DIkN7FfvUl3CAhhiOUTHgeGQqm6ZZmhsoRZKeM5MXq+Ewaiy9FtHDoOakBdE9tU6DS/6jrGd6gRk
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|461199028|15080799012|6090799003|41001999006|8060799015|19110799012|1602099012|3412199025|10035399007|40105399003|440099028|51005399003|4302099013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEdOSkFpWjVhcmpTQWdKSTB3b1ZUbVdESkFtRmpzRGhHK1dLY2pydVk3MTBF?=
 =?utf-8?B?UWdpMFVQVkFrbmRDVVA1bUp5VmplV3krU3RycDFmOXhUTnVhc29hK3hiVFNW?=
 =?utf-8?B?U2JTeVVGRzgwc01Bd1QxNWNoMlp1MjdwMHNLWDBoSmhPNVVIN1RTeDNJOS9W?=
 =?utf-8?B?eS90M2h6STRZUDJScnZnK1FIVXVvWmNJVTZwREZ6NFAzRTRyNHlWMVFVblZQ?=
 =?utf-8?B?TWtGWTJ0cmZFSkJpeHFLTi83SXBiZFBLYlNpd2MzU3RVajB0ZE8xa2dDNTJr?=
 =?utf-8?B?WWhEMzczN2l1TjNmRXhKelN5QWk4R1Y4cG5hb3hOK0FWK2hyamZ2RUl1ZlBD?=
 =?utf-8?B?bUdqcG9UM3BTbDQxRVZiNGlWWWtFNU4xUmtRL29pSmtTSFR6VzNmOEYyZ0JG?=
 =?utf-8?B?UWRYbFEra2J0eGZWWXFEcFROa1g3d3dJK1VEK1dJY0E3ZURLRDJ4STlsbWlJ?=
 =?utf-8?B?Q3p2SzJGMGVYbWpNNmtxZjBzMWpKbExPNU9JZHVRbGdWVnZTcDU1aW82TXAv?=
 =?utf-8?B?RG1oaGM4L3haSTFManF6aVVpOHRUK2JkS3YvVUQ3Mlc3ell3Z2RJWnBkdWx2?=
 =?utf-8?B?Y0lqZ3Q4aUw3aW1sZjVzR0gxMWxoNzV0cUhFMDZiOE52M2drSmU3V3hpVnp5?=
 =?utf-8?B?UmpMNmRmbVJPS3lWN0cxelE2UEdSVy94YmhiZTE5cUhSK2xmSmZaN1RXVGZS?=
 =?utf-8?B?Y3BoSE9FTHR1THltVlNNQnZ3bEdvSUk3dUYwS0Fyc29aZnVXcnFsdk81YWY2?=
 =?utf-8?B?QVQ3bXdxV0h2ZFJQbkVuZFFQS3V5bmhpUFMybmlYektISURKQUQ0eStNdmNE?=
 =?utf-8?B?L3VPZ1dHcThKNXh2TU4rN1BZQmk1ZkQwVG9wQitTM21WYnptaEt1QlQxYTcy?=
 =?utf-8?B?bDlLYXREMXpzS21iZFJicTZZWnBidVhoNnpWa3drbkMxbzJKS29TMmkzQ29w?=
 =?utf-8?B?U3QrK0FERmNKTDU0K0ZJRFl5UlVKOXNWZDB6SmlJYjJraWpEbDM4b3YybXo2?=
 =?utf-8?B?ZFN5OTIveGFVLzd2Q0Q5bmc2bVJFa3lFMXJlV3lBMEtIeCtOR2dOckhFTWts?=
 =?utf-8?B?bEJFNHVsd1FoNml2QlBTQWRDRlBIekNjQzRQenN6T1g0QkQxT1BkWU5BTlQ2?=
 =?utf-8?B?STF2ZS9xZ1EzUDBlZVJpUFdKcWZJcmltaHpRenhGb0ZtQ1EySWkxUXV2QVQ5?=
 =?utf-8?B?R1liK0tNY0M4SnR4K0N6ZmsycnZUMG9ySWdSR1p0cTVZb2pIVFpKQW04WXd1?=
 =?utf-8?B?bkt0aUxaUXd1THpqMHkxSERxemFRQ1pYMkQ4ZngrSk1IQlhST1FYRExVZWNK?=
 =?utf-8?B?b0kxWGJKSTA0KzNMamtNQ0xobGxJTjYyTE5GZmFobUhVNUxMNXU1OTkzRnVL?=
 =?utf-8?B?WGorODRiK3FzUGI5WENCUENFWmU1bnI0dzZEL1pvaWNibVhVUGFjcUVwbk9y?=
 =?utf-8?B?YUhRWStuRytPNDBsZVM0a25WOWNvdHAybEZ0R0h4ZW83L1VCSzJpeGFtVnBQ?=
 =?utf-8?B?MjdxVnRWT2MrMjRUbG5mYllzUThsVk8xTlBwSHcvbEc2ejJpemVZOVg2dHQ2?=
 =?utf-8?B?ZXo3VyszZ0M0dFRNVTJHREJwdExiMlNGWXg0TnJRc3VKV2FFeEltOHpkQ20w?=
 =?utf-8?B?ZHVrR2xVQU1HeG8wbTVBWDVhSnNWTVZTL3BNbkpvLzV0cG8xcUhZQis4c1V4?=
 =?utf-8?B?M3FabnVvN2V0eTBUSUxGSzNsRU16TDMzSWU4dVB3TXVOTUwrNUlTM1MzcS8v?=
 =?utf-8?Q?v9JwndmRHdGF++JPWhEouN9r090k4U97EcT6rI2?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWZmN3k1cmNOOVBaT3d5NkhhOHNvNjA0VUQ5NEJGYXVxYjBTdHU1SERWOVJp?=
 =?utf-8?B?SFBpT1hmZmNiWUJBamVpZ285NDEwNGNtcTZxVk1KOHBSenhoZkEwVTlUS1l2?=
 =?utf-8?B?cDFwQzR4UnNQekpjbVk3RnJUOGhRSXIweUloNTdYUWg0UlJjaGNpa2RPYzU2?=
 =?utf-8?B?UnhNdUsyY3dPMWVaWGNiblVmZFlkb3FreXYwbzZWT3pKVGtXOXdYZk5oMllQ?=
 =?utf-8?B?MDZiY0VUR2JValNCeEVGZVozMWZTUTdzQUlPTkU2Q1U4b1p6eC9jNGZLcnBi?=
 =?utf-8?B?bWo4eVdEQU1SSEZnTmdlNGJ5dzlQNjR5L0huWHl5Z01kUmlmQy9EcmNpdG5D?=
 =?utf-8?B?YVN2RUx5QnErc0E5Y2JRWlEzQWFiWU1xWFI1b0RMTVJKOG9QWkpqMHI1d0FE?=
 =?utf-8?B?dVFxb2hOZHF4WUlRcXhPUDhTbmliMm13cVFTbVpmb1dIZEpzVE5KWVBOOEgy?=
 =?utf-8?B?SUg2azE3bGpNMndGREFmQ0JhbmpXWEYvWEpvOE8reTlSdFhxUmVUZ3h6cG1a?=
 =?utf-8?B?bFhrNVd5UENZYzBxbGhGaWpTbCtrdElKQjYzU2VENWFMQWl4OFJzamZTZ0tG?=
 =?utf-8?B?WUNDeG10NU1ucElzSWcxbzN2T2diNmR6djB5dlB1a3VKQmhMOVptTWRCVHpY?=
 =?utf-8?B?VlVXOG4xYzdrUmt6N2ZmSElaWFZEWWkrMitXbTdSYUZoTW9UV1BKWkl3NVN6?=
 =?utf-8?B?dVhsSFhnaHhGeFJGbkZXUnBxZUhEdzM5OFhudXpxcml6RkZvQmd2N2JacFVy?=
 =?utf-8?B?T3E4d0hZSndad0hQMlV1NXYzY2hnRTVCYkZRUTdReGg3VXRncnNpNmVCWHl5?=
 =?utf-8?B?dngwSXkyS1gxdGRrZ2NjSkFLWkxyZjlDQkpFVFZBOHU2Y0lCOGJmMktFZTVs?=
 =?utf-8?B?b3I3eFZvWnc5MHBEZGlVanJHUkgxQ3dvTUk0STAyZ2RNYTliZi94K0VxN3F6?=
 =?utf-8?B?cUxXWkJsZVp1amZMNjRnWUY2cnVMZHhSUWl6eitvQVo3Ylo3UU5VVFNnaStY?=
 =?utf-8?B?alNwMUpIejh6R2lrNGFvclBjRWU4b1k4NUtCYTJCZGJnTThaSlhkRGRtYmRI?=
 =?utf-8?B?NllqazdmOW45TC9rMnFKc3k3YjU4a05hNHNWT2V6Z3ArUlBRMlpRUEdFWHEy?=
 =?utf-8?B?MXdKVmphQkRFV3dlOXBLUTg4QkV2cVg1SmlHTUNhZkc5eUpvZktHTC9RWlR6?=
 =?utf-8?B?MDROYnB1S0gxVUVteDFWZC9CMENLdkFvUDRPMHdVcGp6MGxpQXEwNFFMS09C?=
 =?utf-8?B?aE9rR1dBeVNqWXdVOGFjVHVpTWpZR1AxNEE3RlVNREVGUWlqekQyRzFxU3hn?=
 =?utf-8?B?UTJsUWhweXZOYTJFT1NSWG5LT2lSS0drdkxlQWZHdXZ3dUpFUzk1dmp6ZXhk?=
 =?utf-8?B?NVRxdHR4dTVYcVdhSytaTmxxUkVZcWx5VkJkYWNrSHIxcjk5akl0WEFiTFls?=
 =?utf-8?B?cVlGYnVTSmphdURmOFJCSUc1SGpwSUhteTZwUC82TTBtNWdtN3dvR3BkS1dr?=
 =?utf-8?B?bkRFdHAwNDVlbXJUVmFQclNqdFFSeXBMMTNYOXNPZURobmYrdDlMbDg0dzFF?=
 =?utf-8?B?Q01QeWowenpUQ2h4d0JOZUJEc3p3UkhJajZ5L08zaDgzNEE1a3E5TVAvMmo5?=
 =?utf-8?B?U0IxNmVFTm9WWHpzbXJaUERHUktBWFBNM3AwYXlXV1IwTHFXTkpCYUd5TGZl?=
 =?utf-8?B?MkxWS2ozK1A3WnFsRWtTalZ5S2FNS1IrbC83eThRZ0pPNG1IRzhWUmZJUFhD?=
 =?utf-8?Q?9MlshU9d1rwohzoKWyH/cFrpVt3PphXV5o9ltu+?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e405df1-99d7-498a-cd69-08dde54757b4
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 08:54:33.6204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5755



On 27 August 2025 5:58:18=E2=80=AFam IST, "brian m. carlson" <sandals@crust=
ytoothpaste.net> wrote:
>On 2025-08-26 at 13:39:38, Aditya Garg wrote:
>> Autoconfiguring SMTP server settings is a common feature present in many
>> email clients. In order to get the correct SMTP server settings easily,
>> this commit adds a `--get-smtp-server` option to `git send-email`. This
>> option attempts to fetch the SMTP server settings for a given email addr=
ess
>> via the following steps:
>>=20
>> 1. It first attempts to fetch the autoconfig file from the email
>>    provider's autoconfig URL, which is typically in the format
>>    `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=3D[ema=
il]`
>>    or `https://[domain]/.well-known/autoconfig/mail/config-v1.1.xml`
>>=20
>> 2. If that fails, it tries to fetch the settings from Mozilla's ISPDB at
>>    `https://autoconfig.thunderbird.net/v1.1/[domain]`.
>
>I'm sorry I didn't ask this sooner, but it just occurred to me.  Do we
>have permission from Mozilla to embed this service into Git?
>
>The reason I ask is that sometimes software vendors embed external
>services in a way that causes excessive or unreasonable load.  For
>instance, some router manufacturers hard-coded certain NTP servers into
>their firmware in a way that polled too frequently and then effectively
>DDoSed those servers, all without asking permission first.
>
>If we embed this into Git, then it will be present on systems for a long
>time.  Some Linux distros are going up to 12 or more years for software
>lifetimes, so we should assume anything we embed here is going to be
>present on OSes for at least that long and will be used at least
>millions of times a day in a highly automated way.  Even if this only
>lasts one release, it will likely be on a nontrivial number of machines
>for at least 12, if not more, years.  (Not everyone actually upgrades
>when their OS goes EOL, unfortunately.)
>
>Is Mozilla comfortable with providing that service for that amount of
>time and having every Git installation on the planet potentially use it
>at top speed[0]?  If we haven't verified that, then we should probably
>not include this service in the code.

Good point. Ccing the maintainer of the autoconfig code with this reply:

Hi Brendan

Aditya here. I was proposing a patch to git send email which uses Mozilla's=
 ISPDB to get configurations for various email providers, and makes things =
easier for users. The original patch has been sent here: <https://lore.kern=
el.org/git/20250826133936.1569-1-gargaditya08@live.com/>

brian believes that I should ask Mozilla whether they are fine with users u=
sing their ISPDB with git send email. I agree with them and thus, am sendin=
g this message to you for your views.

Hope to hear from you soon!

Thanks
Aditya

>
>> +sub fetch_config {
>> +	require HTTP::Tiny;
>> +	my ($url) =3D @_;
>> +	my $http =3D HTTP::Tiny->new(timeout =3D> 10);
>
>This needs to set `verify_SSL =3D> 1` explicitly, or we'll have a security
>vulnerability due to not verifying the certificate.  Our minimum
>supported Perl version is 5.26, which shipped with HTTP::Tiny 0.070.
>Versions before 0.083 defaulted to not verifying certificates, so we
>still need to set it explicitly.

Will do if Mozilla allows us to use their service.

>
>[0] Even if we don't think users will use this that way, with the number
>of Git users, there will be a nontrivial amount of users who do.  Many
>of them will not realize they may be causing a problem, though.
