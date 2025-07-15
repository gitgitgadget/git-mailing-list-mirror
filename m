Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2031.outbound.protection.outlook.com [40.92.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B224677B
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752603949; cv=fail; b=HfKIjoEYKNe/ygh1D+cuaalz6KZwxqLDYdSEMk2MgzwVn6iYjaiEtSjQ3SqymDOfHDQ/SDPycj4PoKZrX8ogELJCcqbSenwSLiRu8AXFLrkCD/Uh5ogoWfZl9m28IAVIQwcYAn7urKjmdVEdnD7KHczDKnJIZs2PdDMQG7Y72Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752603949; c=relaxed/simple;
	bh=FLcTzSuxYPLphFuX6zdRDrYviP3vkI4nkHbQcl71cDM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oagQ/7ZDEafZlPvV4+0JHTQaRe7UcZwLi1uBt7lx1p2j40vac9rTy8M+Yb519nmFmAc+fYYIB51rTciG+CUuuNm4Z5JT9MBAAfzPEcwNIHXgB134A3b420bYUqE4hDfUpTpNth8NgYSqX8o30NHSqAB/sZbSt4Za8FIJBGgSxmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gCQk/gDW; arc=fail smtp.client-ip=40.92.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gCQk/gDW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBVj6xYW7/MnCHIwajhO+Y8DgWe3QbrRkjndL+IVxkyMIQ+J4JYBTh6VrqIjYVNF0/icALo1RwGj1kwXlIhGKjgl0iQKpQJhtCAX7RX93uyQdA6I2MA9QHoPIc3wcJuXdo5p/zGABfvTsARny9LQX1D/8H+I92pCZLmrFfiji6NLm1iSaivhDP2n0NkiU6qhzDVRd5rmJuCz7be1iTEDj+Onx0gFz0Lzc7TOit/t9Yy+nnk4be4l6kJGSvfJsxOxVoXQ4WNIo11HqLrUs483mlQbi91GNXDnNXMjEGjT6kAmAV6cAK/jtk0ZoglBhIA5qAJYuACGO/TlKNarUSyi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FLcTzSuxYPLphFuX6zdRDrYviP3vkI4nkHbQcl71cDM=;
 b=DbRvTFwN9hDuclr0hXNkw4ghRfIXUxxEBCYDz+tohDK+0m5HheVOAdBQXUcgWEFNhVObltIL52YAjyFS6rZXe+qZge/TY2X4xrV36ywN0x01LinIcu4twPlJKig3Uv1W/ANaMYRHsm/eftLuh6JjQ5CztipiK3vEwr1Oy3s414A2A7aoEWz2/BAJn5FnmIWLE3ixVa7LBUifD8uzSfy3o+bQn4UsqRcYWMYhTdnyqn7WEIZfVQnFhlzYrASAgV+rkm72M7h3UI87UJwZenzQM7cespFx3RnQRSbXSF/0IA+ziU5zlfTi9l1kb4K8psrFr+iQQ/cJLMlxxKoLAYpOrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLcTzSuxYPLphFuX6zdRDrYviP3vkI4nkHbQcl71cDM=;
 b=gCQk/gDWL+TVg6Yceql9bSoyA7PklOSEiTvL/WQsdacyuSgZ2fOHILb3k9D04q73kBVbpExgH/XEwV1b05ZaTfbbvatiUamirkcgC6/F2TZXR/s/+dES+cxiFUz3J0vJNKw8sliLNMcErY6jRAnHhXe0AEWGDUYoruaM7pnQ6yyCWl6KX7Ty6Yzzjk8XiTW4JwQVc5z7wM4VhucLxZi0WkQvZuz8t6I+BWQhHDjpKElYbW3XVCL/E7ZRgXxYyAL4hg3NslKKGKa+tcN3ZDSQSr+nllrnXBQvV0bcZG+xQWoxpJ/GlraoIXlVVdGCt7YEpUl3EPq9Y2DzAl38bXdacg==
Received: from SA0PR04MB7324.namprd04.prod.outlook.com (2603:10b6:806:ed::6)
 by SA2PR04MB7740.namprd04.prod.outlook.com (2603:10b6:806:145::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Tue, 15 Jul
 2025 18:25:46 +0000
Received: from SA0PR04MB7324.namprd04.prod.outlook.com
 ([fe80::f7d3:b390:e9c0:2b9a]) by SA0PR04MB7324.namprd04.prod.outlook.com
 ([fe80::f7d3:b390:e9c0:2b9a%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 18:25:46 +0000
From: Isabella Young <Isabella.protechinsights@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Fresh Leads from GSX 2025 Expo
Thread-Topic: Fresh Leads from GSX 2025 Expo
Thread-Index: Adv1DMizBEGsw7vMRvOjuIOhqgHQPQ==
Date: Tue, 15 Jul 2025 18:25:45 +0000
Message-ID:
 <SA0PR04MB732458EC8EC12D66F0F5242B8D57A@SA0PR04MB7324.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7324:EE_|SA2PR04MB7740:EE_
x-ms-office365-filtering-correlation-id: 51024ad7-d546-4765-74fd-08ddc3cd0407
x-ms-exchange-slblob-mailprops:
 bHQ38DpbEWAD47zqKFKNkWpsu4QAv0As3YuQzgc6uY4nBWIhu7gK13ov+UhxRKt3SJ1H92OPmsE9vczfzQs77+QzsOG37BQSiYFJaXgHI5F5PWgRAp5qN8Tjv/7RMHn3YjP+b3SKjkp3UfIgjZoEst79eOIXS0u+5C5Kw64wao4rR+W2Kv1ZXi3teX7dQ4fdV3llXzDCbFUNWcLz5YcNFPA2H4p3qdqmpWOl6iMO3g5Jfy2TULnQCMw8InQCg2v3+JW6L0qeVqqRZMuvrDIh0De+fNn9cdA8Px/k9crj7OROD5vBoAG1IaQywR0ZHn9BcRBJLHgYdMsJPaOxlqa64OcNDFn4ilSwd2zDYEatpbY8HwxsnMrgFJ0QcnwustCm2ztIGaKKVKZKZXPion+DoEqe/Z6UhkLdhb+4M25+STtk05GVOkcspCNlrJmafoj8hh3RD8BNZrQ+bSFOplRAgmWin6kU8D0w9kyLaV7KYl3PYt54Uig+GV3EoSWPcEsvq47F/QfKigNzUGMaSUJ+6SyyNG23JhRinsCl0dJmV3npPwYQpRtCcCt7Yze9Ni5hsWQ36OnAM1jzB+0MDndSOguyCsZY2dmLIOGMr1Nw0fTp4ltcsx1pBCgtqyStwxWUXD0D44tBWGTQ5I52SAqVMDGibECy2aNZVgLFWoSEdAnRb33a1PY6gQ==
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|41001999006|39105399003|3412199025|51005399003|40105399003|440099028|102099032|19111999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?dh2wEcx0Wxz1cPBuDPRLi3K1PZWEvBHh0IXJNow74kWeD+ltwXJ4oHmX25?=
 =?iso-8859-1?Q?ckUXoIkwIvO8HonWotDhuB0U+q4lE+jxp6PSI+iT9dJWr5k08/TtuSYeLj?=
 =?iso-8859-1?Q?QCvufrkA1YzIZbSqDxkyyb+7Iq8qogd6Gpel+zq85PH4FW6FXIUkanXKEi?=
 =?iso-8859-1?Q?rNgIBk5gQISd7braM/pTu55o7NKPriJgZI0ZK23Gf0kVp7PBVQb/Xu985x?=
 =?iso-8859-1?Q?DzfQ/EBkrLxWzVLiix/VtDzFI3iGLN0lixUYlS3el/R7V64j+xFqAPi/S8?=
 =?iso-8859-1?Q?PdxKocy+EaHqL/nIChLD39mr7oYa47y/25C6XjRHxabOEFBB+OUoUSfHUn?=
 =?iso-8859-1?Q?RnIAsKZU5B8J88oL244DLbGQk84Jsu7A08iH7L/LypNuQ2da1HcTm3gCFC?=
 =?iso-8859-1?Q?HusqmSVMusrGe7sCU7nzOTSRzGB225CO7tgVYzUD6ScmoOMjZihhFzOOMp?=
 =?iso-8859-1?Q?v2XQUdU4ZlFnFXPtXvmnd6H0iL8xCU4dE+AyKPDtvC48Va0b/o9AM4FKrH?=
 =?iso-8859-1?Q?k/X2IAiJ26GYNGYkKsIwp3/z9wxVBe6FQFu/1dQqJYDo8dfw8oyDpvaDQE?=
 =?iso-8859-1?Q?3icFXS2vKlKLkB2C4k5yB7NeCm5ach4wjrpx+OPJWpAiqum1aFbyaRXd43?=
 =?iso-8859-1?Q?5Yxky0oZpmGOowu+bkCW4upmEgvtHG5Q+qs1Ez01rLFXZJvW2l5pvyqNEX?=
 =?iso-8859-1?Q?epei+Slrzzu4JwS0nEONrVfrDDUE+RRLBMMwH+fzKDO1bUuzKSmoi+SbSM?=
 =?iso-8859-1?Q?QNJdotZ0qKoK96kdKZ9DfoQelkUWg5aeLxT6sMcDSeoZGDDEUoiN/uUwTR?=
 =?iso-8859-1?Q?Mq5HuSI1iHBWmfr5qXlplf3a+Wqhizvw2m/J8klrNseHd6Jzwr1y4EZn5c?=
 =?iso-8859-1?Q?somjtKM+yFlD1JFvwIzjSn5L533nVrl8rwfqcm7icboChVvdUuN+sg5n8P?=
 =?iso-8859-1?Q?Zplm0g+c9mTFoXqCrVQzVHPvdOFWhPNZdZRYP6SbewAxIir8OBTg5A3euV?=
 =?iso-8859-1?Q?CRXqpeLzknZVfkCVvygN1Vi4gMIadjcLrhz4waMmEDpCO2yiUZ4CUaSwYd?=
 =?iso-8859-1?Q?uGCQVxORbepdP0noFGY9RfyjP0ZN0/vmIYbIAcUovZJ/4apCqrMoRNBkIa?=
 =?iso-8859-1?Q?c2w4msKZAqAauO+TORNIiJ/0CSQ2mF/cd92HwdiBvUoxBpsnl4xADLXqxn?=
 =?iso-8859-1?Q?BL0K1ngrXnqkAA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?uavG9Rz4A3/6D+Niorh2iHCAF97ySWBWZNDtxiHZMnRO8eMVT86CEd9Mv7?=
 =?iso-8859-1?Q?A+twrqetDpRpkMoWAmPP8Hx4LsqJl+95ejzElwIu5qkH0q7i0ezQx9vIMI?=
 =?iso-8859-1?Q?hDiWsqHmWaxC+Q/9Emxw/Nf5dA5XIOKgubc4t0EawiBvNihCc/BYcHoHWw?=
 =?iso-8859-1?Q?Hi4t4dYBVgMGAmSzQ835c8epQ6Ovj+PfSIANsnEggMCrifTDC1pvpyjaV6?=
 =?iso-8859-1?Q?PWYWlVw4JiI5kM4j/X9ZWIZ1HiuBMQqdfkzSq3J7m03qADvHdG6BYh9Sd/?=
 =?iso-8859-1?Q?V4Ra/oV+5cgE9JlJ6lrifANC7ryhDEbteo5OX2P56wWyRGQUmt4E33CzRT?=
 =?iso-8859-1?Q?OlGe2NnjchkfjcyENe487yFVIgwbEoZYMwnEYlGAwcnVI/rgXcIDbrXxXq?=
 =?iso-8859-1?Q?WlC4h63mag5Pu/CP4jWZmEYrhgAbkyB1UAKZb12PbreVHB3ulhZdqr2SZC?=
 =?iso-8859-1?Q?epm7nHw+hyL5oVSfBads1HZ2BHX9+xk14Psb7W2VIjzcuHhI/YkMetVIZL?=
 =?iso-8859-1?Q?9kRiBmZ+3obdLsJn/SdQ4LTfPPQQf9i0yzD3IPeL84BZ8uUCsE8Ri/uOBI?=
 =?iso-8859-1?Q?C4G1Psr8RuiuD9sd3oXlqdq9kTq9wMq9EMjzkQ8Pr5lrIRXIO6E1CoUxwf?=
 =?iso-8859-1?Q?sfG+GP7d3njn3IxZJG6LwAilqYrwAgHFnzu1E2/hTOwonPPn7ekV5Mn6FD?=
 =?iso-8859-1?Q?10DBgMlMoGhzuFDtF8JShxhCUi9igq91HPzXkjy/0o4ISp/E7RP4417XoR?=
 =?iso-8859-1?Q?HRWUh20PHRKw0RltardiZ/D4R+3Rr2BfUAhjuulHc4zRcFPlRj1TWxv0H6?=
 =?iso-8859-1?Q?oPhVGAJr1s7IJt1qMKS67MIZ4a4vVL63fdzSJcPgyixsK+VZ3cEOgwBq9F?=
 =?iso-8859-1?Q?MeTvXswZUj5od5jbgHbBuRKDBKvi5VqcnwKshwoS09oofIuXZm333/5p6h?=
 =?iso-8859-1?Q?zUHi8uS5TEm+TASv0dC+EyLur8M6191DGN4EAN4DOdYmrN4yB850esSLxZ?=
 =?iso-8859-1?Q?yLY4wRsLJdHVyTwYP+kagTvC56NektFd8BCooZpkYC2snAum02WwTzKXAb?=
 =?iso-8859-1?Q?DbNW+kTKQfmo1cYdW42BkvJ3BabTGDxnqI8U14ZLv2TPNJTrC9Kfy09Es8?=
 =?iso-8859-1?Q?gIcfe9ILm1lTecjgf0gvOzPlCWacBj9dKub+1Ee643oMYFjy6kU+3RfwIH?=
 =?iso-8859-1?Q?I8YLfukm893dQojXxRCVRCCIHv5Lmrpe2eQN07RLbfeMe800exKllxdi2S?=
 =?iso-8859-1?Q?4q0PEoa0S2V/2xO919a5IHl2RVdDQOnwSzzIaVMNo+4KDh0ik+nuRAi9jy?=
 =?iso-8859-1?Q?+EdZn2iSGbgfhfMWEBmjp63159uQ/uQws7IwRakXIf/tfOUg/xQwavqLzL?=
 =?iso-8859-1?Q?9SXkctemlCQbRB61ZDZ4uKjz0RGTMYlg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7324.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 51024ad7-d546-4765-74fd-08ddc3cd0407
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 18:25:45.9415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7740

Hi ,=20
=A0
Is the attendee list from GSX 2025 something you're interested in?=20
=A0
Expo Name: =A0Global Security Exchange (GSX) 2025=20
Total Number of records: 17,000 records=20
List includes: Company Name, Contact Name, Job Title, Mailing Address, Phon=
e, Emails, etc.=20
=A0
Do you wish to buy these leads? Let me know, and I'll send the pricing info=
rmation.=20
=A0
Anxious to receive your feedback=20
=A0
Regards
Isabella
Marketing Manager
Pro Tech Insights.,
=A0
Please reply with REMOVE if you don't wish to receive further emails
