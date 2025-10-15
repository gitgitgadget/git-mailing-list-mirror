Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0184A3148D0
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514637; cv=fail; b=VPeK+L470JmKhfis8fFuLTJyZRi1v+8chQ8W/xKH6z6ZVwJf/vDtUQa3tKCJJX4Znfy+pFQnSCYJRzejNdaWphFkOkL/iXuuDVU3Ab9B13hPEIv0ok65kX7Jk4lhPLsVZ+dhHO7TF7RkN8gmIm3b628zAxM4GoQNDYswHwKgXjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514637; c=relaxed/simple;
	bh=UyfHvagDGdTFnck6m3wlwgZ3UfC3FJeq+eKcg5xLbZw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=klAAWKFh3HAyyuhltd0MP61M9HqbnYJvyjzEzgUIQVV4FU/pykoy4DrWr1Yauef6kJVmm0I9AoVRvIChs7Q8w3DofKbTtP+HHohURJBW2pbtt4LfwHlPxVIQl91FyLTffbWMBUtCptpzq4Ns4/sc6aj3wldd98PuzxHlxHV1nFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=knorr-bremse.com; spf=pass smtp.mailfrom=knorr-bremse.com; dkim=pass (2048-bit key) header.d=knorr-bremse.com header.i=@knorr-bremse.com header.b=cQ/4F+wE; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=knorr-bremse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=knorr-bremse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=knorr-bremse.com header.i=@knorr-bremse.com header.b="cQ/4F+wE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqvDf9jDKXqImTFnu8RkzWTjWOGtQxKydeK7X9A2pzUx1Ko+J5T2229+VB+j24aU6BjivyK3S6AvgEpD6jc+1e+VLpE4fGmGxvmnvHyuucjGwKxR4R6+yV1poLHHmOP5s9IQIHKchTz0DUHAlS2QcnPbOXEc6G+D/oN82Hy2OwivHdXXT86OT7Wh2PanHtK/WrCxAeEWGqKmZUFCAHyTrbajgd+eqHJc76zuWKw+w6XFksQzB/uliildC6H5jAL6ZteCLt3f02oTlLTmxSv0HvpBUiX/U7bSMoJlHCZG7Rp9ijDjWb9HM2SmySQc5W8+ld2p0zArkuBIwVfFHS8kWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLm6fIsgu/MnTznIxlDWN9/gnVxwxk7urrVCzaM+t2g=;
 b=btSvpHHXhBGSbMdxaywvy37FJ/f06GQWb5nfj+zsnCvoavUyT4hFdPO/pquQqYJ4mVMv1LB/WXC00372JzIrRWk304piN445a81dmmcHIx1ByoJpyGItCv9xaWHdFGATfzurOkp4grwG+Ryiety04D8bPhR73mKAjiGVcHQOjTNrI1zXozDoPK5vRv3BQTudl0pj3cHSqbbaNybELHlELvpZrtBq1bsYo0Cysl4c8DiP0JEuqrojnAt5dEESOU5yFwtoZMGagMqJjsjyEg6AKKzOozUFB9aWwDUuZRi8jDeTlQmQ4Na/MsVbYei1tbS9wIQv7BIzHXZbsxw1VSDLDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=knorr-bremse.com; dmarc=pass action=none
 header.from=knorr-bremse.com; dkim=pass header.d=knorr-bremse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=knorr-bremse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLm6fIsgu/MnTznIxlDWN9/gnVxwxk7urrVCzaM+t2g=;
 b=cQ/4F+wEgedEpI7wBLk3TTmj5e8aGIRKWBnZK489dFgGi7zzTK5/C9HPvXtHRgoCtaKZdHBzmAGGqyUPkRwJi1q5tvAqhvxgthulJBDpFEX4mHrM+8lE4jgUTRzdRMOZHAe1F7/KQ7bEvMvM8RMarLrTU7iAmmkBVqBG8bSMtZ3HUC8KG89HpHRQS94gvdBRaj7FaeV5N9+bnW9BMV4dmaXBDGrC5Ey8CVW2HZO1XwAtBpmucer1BNMZj55xGC8C6ibKD2hyI7bDZgupkZCk7F8TTIVI0PqkGxkJs0uD17fonobW+dLDWsycSe2xTBqW8zBzKxaonaKu+pVwtTfb5A==
Received: from AS8PR04MB8436.eurprd04.prod.outlook.com (2603:10a6:20b:347::23)
 by VI1PR04MB6927.eurprd04.prod.outlook.com (2603:10a6:803:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Wed, 15 Oct
 2025 07:50:28 +0000
Received: from AS8PR04MB8436.eurprd04.prod.outlook.com
 ([fe80::33d5:b7ef:7c57:980a]) by AS8PR04MB8436.eurprd04.prod.outlook.com
 ([fe80::33d5:b7ef:7c57:980a%5]) with mapi id 15.20.9228.005; Wed, 15 Oct 2025
 07:50:27 +0000
From: "Srivastava, Nitin" <Nitin.Srivastava@knorr-bremse.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
Thread-Topic: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
Thread-Index: AQHcPEb1j6JE4EIRbk6QAHtMkLViPrTAKDXNgAGYKACAACwpKIAA6tjA
Date: Wed, 15 Oct 2025 07:50:11 +0000
Deferred-Delivery: Wed, 15 Oct 2025 07:49:12 +0000
Message-ID:
 <AS8PR04MB843639DC158AE8E035D83FA4A8E8A@AS8PR04MB8436.eurprd04.prod.outlook.com>
References:
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
	<20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>
	<aOjsjpE1vuFUXXbh@pks.im> <xmqqwm4y538p.fsf@gitster.g>
	<xmqqh5w250lw.fsf@gitster.g>
	<CAOLa=ZTRG=x5PofmSSfHhJ3Lig2NjhU8buVWAXU=aKom2PDsDg@mail.gmail.com>
 <xmqqldldxtoc.fsf@gitster.g>
In-Reply-To: <xmqqldldxtoc.fsf@gitster.g>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=knorr-bremse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8436:EE_|VI1PR04MB6927:EE_
x-ms-office365-filtering-correlation-id: 7e94c1c9-48f4-4bfd-1093-08de0bbf81b7
x-kbdisclaimer-set: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|4022899009|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZIS9DSHDz7p8+HQq+IMhjLeYmpOvHZxeiQIqJMv7B2HKOQKie0Z1PtuJwb9L?=
 =?us-ascii?Q?sCbYrs9J06kRLERhJRX6Q9oEUMIkHLKZOdCXP0gez2UzY3JPmHN0esEQ5+gG?=
 =?us-ascii?Q?YBCCtswdEQ7Yi1mjwoq5a/oKM6XkLWzAFSiu9xhn59GmY92lZMcXGBl6/Q+i?=
 =?us-ascii?Q?VRjD/0AortnqcqnKd1bXIokRTA6cRSZ5ixpjyYgTbjHbotvHtvPwv6bUxQX6?=
 =?us-ascii?Q?FhEBJaEO2ia0ReciCNshECRuOyhzbPbAQT0jP/haQR4KImYkXAbj61CIdQQC?=
 =?us-ascii?Q?x09w6X5i4a40Yerm81qf3l/TT6u8vTBAQa1pPDoiLwNUMX/PVLaY/MDhHKWL?=
 =?us-ascii?Q?zxjTStma27SNchTQMYGXoH8OtEckq0LMIeTA5tdOW+3StFEefyl5+eVJE3j3?=
 =?us-ascii?Q?kJ/IAQzxlcxH9EFyOTagU96mVwesu7EGtJjGS1jd6lnxD6Vt7tWGxm6L2LQI?=
 =?us-ascii?Q?kcjx2guFsA34I7QftxHKUNYEWlW6FDR0ZAzGMxVva2Ttjf1TdpBWZtVvo1pI?=
 =?us-ascii?Q?RHRHcz030FoyRbWvu3wn71NZ0oVQaqHHtpfcUU7u+RXi3YW3HpPL4Rbv4BFc?=
 =?us-ascii?Q?6C88fHqytL5A20pI1okUn/Kq2Ij+N0Z25DMmsTG367qY3GrPGaNk8Kmz/SlZ?=
 =?us-ascii?Q?SGx5voODzEkRpbtPGFHu/N0/0NlwN31mH5XurHSCvd6l7E6Y7Brqr+1Viril?=
 =?us-ascii?Q?loYLg+AIeY5DAr3DdFVnPuLNsJXIpn+ET+wAT01uZHG9xNdPsaapCWTHkUIJ?=
 =?us-ascii?Q?YIq6xksqtIGQRHdJhWM0SkJBhwvPcQIz8ln2/SEjuz2M6pmZRJ1jXWo14OOT?=
 =?us-ascii?Q?gjtN6EjwsVZZ/yFMIsjcF7uYifXysxUaLtZtwpfQR7aWJ4RBy6qKoCusTnq0?=
 =?us-ascii?Q?STyBG7xmLkoQkzKWazZQK4Oew+v9qOsBbg0wfr4tcuFpFFBXv6OrN8o0jl4+?=
 =?us-ascii?Q?C8soegMTQ/j6w+7FwlduvPtr1tvSk+LWwzclr9PxcBz0rH3I34bpV5mWKKB9?=
 =?us-ascii?Q?zoffWHHEop5PND7VhHljO6WsiDhXOBqZT2Mpee3BlJ/Bu7Li+z1x2d58FCsS?=
 =?us-ascii?Q?knrPfOyZeVkPz/2ncKMMuEofR8xJ3Sroys6OxBApPIGsoTd9/4JAqryLfrYF?=
 =?us-ascii?Q?je4mFrr1yFuOnhKBB5gHgd6WMnfYUo8zidNPkEM17DvmmTb4gECX/dzummvC?=
 =?us-ascii?Q?OskI92Z0zMSLQ45Qbu/u+loU1PaiDannHSphVo6oZWdmYWxPvh7YyJXZtf7T?=
 =?us-ascii?Q?0ek0OvhYCxsMo5qn5jH8aOO40g1D90iEwkE5XTscrmW0OHxtojn37bGElreT?=
 =?us-ascii?Q?fZUOPgW5Hr3oZ7fqCiSPzvhBEMIRsO32e2A8V5ZyyKKu7eIAGwuSd9AHhDGU?=
 =?us-ascii?Q?UURExEQ2v7C+08bpxVf25IpDApbfLzs3IEEJiNzQDhwmQ77bGhHBJr/VPJrs?=
 =?us-ascii?Q?Pmdb3VWbQTJAKw2wDFjDWuHrgclQ8J5BkXBX6NhJq1Fq2H1WW9+oDRI3WSJx?=
 =?us-ascii?Q?g2idAU1XSvNtR82iF+/6zszgw9HCPdDq5Fc5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8436.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EuGjLBW5+pj0bSlG3rl+6WSu8+yFZRrasREwZSpPg1drdfSae1Wj8Ag2CaO7?=
 =?us-ascii?Q?I7vhdS2+InitbXdW+Whd6ALL2hoo49SUJe0/ZHF7kAtB+5vG/TCyUpfrXOVH?=
 =?us-ascii?Q?uOexvszBIVoTwZ+plXKCcGNl7AQXpxqonRVSgxxRWsNemEsAq0XGZoT+hva1?=
 =?us-ascii?Q?WcDsqOw4JC/7ZhllNkBEFAo2cMqyHSPCHIOFd6LeELh7VnM08QB9NWQmHEyL?=
 =?us-ascii?Q?sWlqIc6WmHMydkdyk/qbWdfohVWCji+P9bHkNRNCpggNVT7A5+g31aBOSWPy?=
 =?us-ascii?Q?X0bFCrPkP7anK2K8+GxuRSj/4GI0l+nG+gjNxLLM8JYkbTxEAEotFnAvhJfm?=
 =?us-ascii?Q?fMRFYgQasl4kCUJSSNW7Ev8sBbFUvET/zYVrlI5tvdgD8wxx+s/tR7uEzXIS?=
 =?us-ascii?Q?GxtFCOoGGeYZE1NMK8Wvh5kKf67qx08hfcHyLJvO1QHDPli+iNJL6n8jGDwl?=
 =?us-ascii?Q?AiQFKrsLINYdZA+yQBuRVZxYGM//xUobpomRgxmF+DPuhJp5un2GBCAiW7r5?=
 =?us-ascii?Q?pH8XEQopKKWbXo+t1s7CMxp8fkPtsZCgz1B7qiVkLUBcVd6corbTYVPVhHEI?=
 =?us-ascii?Q?tzsNfYUPZ086vzQqELo1RtwmNdodr+x0csZmWVEcU+FUVa70JlGDnmZCfvnT?=
 =?us-ascii?Q?0fZTfrn2s/keC3uFYlEa6hHE4CUrBuCF+UQxrA15Gxt0tkhIBtMsnfr6evYg?=
 =?us-ascii?Q?CNVDTuJZ5CsgdHb2GsEXPaJma0oLWkXiOr9RLf6CJatRatWh7Nm/it16ynao?=
 =?us-ascii?Q?sL8JYySBUHSCMnyLV+qOKyhaT1wTCa15e6eEcY33W0z4pnMbIobq4JSzcOwN?=
 =?us-ascii?Q?bY36k/AmIUM6Z0kG+4btkFuYUG2acRdpiAfBRUbDspESSs/Y0hwqLoBEEW5B?=
 =?us-ascii?Q?Ne/foUPiOEUXqhNuOhUvL7BhP3GDmWCd5OdXtk/gEeRvWknx8BHNSvi9RqiB?=
 =?us-ascii?Q?/YA9re/wCQv/dPHDnn4fq0eYkL7hO3qefh45xHSQxVkVkFH1qRSraJI7ypBB?=
 =?us-ascii?Q?uJVUsCYznc9Ld7+NWl9OISQHKTF6pr7crE8Ret6YV1GlVAJhkN433VfMTCH2?=
 =?us-ascii?Q?+HpWmpev5k/J1FqcTUZ1PU/KBKcAgXbL7Nn93/0diZEkuQzaYuJjcSJNc2L8?=
 =?us-ascii?Q?wOqCuefK7SI4VLEfUVOXbd/f9wJaiRG3lVtqm0B573L0OVMtoH47wqeysyrx?=
 =?us-ascii?Q?Yl7kGW219OaVx2HUSXeASyh42r4FsS9iwtmXD/ZbMzFm+yjjSxXhV3FvI+vI?=
 =?us-ascii?Q?9fc6rlS5Q97DQjMmdXjCqsHaofCW415I+I+h/p6djHoM6P61DUY6H3cPP1Oj?=
 =?us-ascii?Q?cle+d0MFRg1ikgQqp5E//+u+llVNosnnc5PrXk7XgS7lHXmMin8SgRorrxAp?=
 =?us-ascii?Q?iKAZ11FY5uylpnRlag8Ht7gpDhhYWMA7O4wqj4Z9es1gvnJx3XC32BwVJSek?=
 =?us-ascii?Q?4mhUOl8loSiZJoNUSpXvawx6b3KrUUcul6EadhjGpJLtFtFInW4VSACoOQMh?=
 =?us-ascii?Q?HJPEKG+RsmPZL/lCff33niS34P7F2kKWgkBuR7HjnZr3cetwxPsJ8wQ3wBEh?=
 =?us-ascii?Q?gO2eCAxrX1pp9MKdZQygmNwuKZyxuVZbmdWzbHs+rNIzH3ZGVIsCYNQea6dw?=
 =?us-ascii?Q?rtBIT+Ztj0jJfvLrdxZWHCU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: knorr-bremse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e94c1c9-48f4-4bfd-1093-08de0bbf81b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 07:50:27.5522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66f6821e-0a30-4a06-8b8b-901bbfd2bc60
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0OSCpzYQhbA7TBEKZFW2WUFZIaFhd+AwzDpdTb8QQjHEsdQ7PhwSEY4h7x2N0e8fk71+7DOSOIPaPYP3b2frKK3KgzCNHKA8tE792se0Y+f8yw/m598ssOQ+5TUY1Rgo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6927


Please unsubscribe me from all email notifications.


-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>
Sent: Tuesday, October 14, 2025 11:17 PM
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>; git@vger.kernel.org
Subject: Re: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimiz=
e'

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Perhaps "--check-" followed by a word specific to what we are trying
>>> to achieve (e.g., if we are trying to see if auto-compaction is
>>> necessary, "--check-for-auto" "check for auto compaction")?  I
>>> dunno.
>>
>> After reading what you did in the previou step, I am reasonably sure
>> "required" is a wrong word to use, with or without other words like
>> "check".  Semantically it is similar to the should_pack_refs() check
>> that we use for pack-refs even before "optimize" came.  We expect it
>> to answer this question cheaply: are we better off if we repacked, or
>> can we go on without repacking for now?  It is not about "are we
>> performing so poorly that we MUST optimize now?"
>
> I agree '--required' isn't the best name, and like we discussed
> '--dry-run' wouldn't be either since that would imply that the work is
> being done but not persisted.
>
> I was leaning towards '--check', which is simple. But It might be
> nicer to be verbose here and simply add something like '--is-worthwhile'.
>
> Being verbose here is okay, since it will only be used sparingly and
> specifically by those who require such a use case.

Nah, "worthwhile" is relative and it would be less meaningful without expre=
ssing for what goal we are judging how it is worthwhile to do.

Choosing a phrase around "check" is better, I would think.





This transmission is intended solely for the addressee and contains confide=
ntial information.
If you are not the intended recipient, please immediately inform the sender=
 and delete the message and any attachments from your system.
Furthermore, please do not copy the message or disclose the contents to any=
one unless agreed otherwise. To the extent permitted by law we shall in no =
way be liable for any damages, whatever their nature, arising out of transm=
ission failures, viruses, external influence, delays and the like.
