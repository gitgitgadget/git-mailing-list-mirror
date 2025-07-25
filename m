Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazolkn19013085.outbound.protection.outlook.com [52.103.51.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F83D25C6F9
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.51.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477795; cv=fail; b=A32eyH2ti5LM3OSYzT5TEsyP+0dIcBCQvo3BI0YQ/cd8DQ/ZkuN675hxZ87v9/bqk11k6dNFgNeT+hkl+039R8RxL/gjMCAB/ZgE/G1t6MGlZtq3e2IfcaREUlYnjfkxFdNeQm1CTLm8UovetQlEMFsZbD6xhwGFPrdI3XocGbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477795; c=relaxed/simple;
	bh=rpxdnTauw4dkfBcylHE8+k26MzhWsC0ByV9idZxrzx4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=V8+o5UZ+XHiOmzNQPbcyDMlLOqbn8y3U/kFD1qKHtqAR/D1d5L8WITSLKuPwTb/7CRZSYR7Wzu+WTvOKNnthmG22qt2CRHJ87sG4qxad+jd0T+VH3IzyKeW8J+US+n/7UU2gdOAMjH1L+JFZu2CZe1q2NiNdlARHvL1Zm9Vr444=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=T4CFUpqK; arc=fail smtp.client-ip=52.103.51.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="T4CFUpqK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SBbWg/XXwvzdKZMojPp/u8CXkoDw3NGLYLllSy9zObsqg8ku8zkWS5L5a9oFCzbcx/NTvFEBkHHzad4rTSQ9DpR3FSuN2lbADEiA9TGXGZE15DNjhdeTzoBejGieXRVY4wWAo7ViNbKhVTX+hSmwJIvKDsgxvv07fn6Rm0+7OeVAyEyWGPZbtVRsIHh5AhidTw2LzbKEGwOetXn9CZvGtht/Aonnzl6CKEcom5Hh9e1+ltOG4/Shrc9Oik8lrQgs0pQpwSqlgzq1EO0nAE8DBDgA2rYzPjkm/YjWbdqUUEsi/JgdVBgPj4mLNOhL7B2oboOttPT9wz5A1UzItEohYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mNZIKXgbCriWkujkNthMbz/hUW67Wc99Ub2fE22OHkI=;
 b=ZGKkwtlTxqLzf0iPI6jj1fl0Kq9hZNS7AkSz6jSXVlc4YaQGPHcuK6iVF7Y39lkD9sJ9GSYUWE0pTdwnBtGb+o1n02P57Bn8h6StLblf1NVO5pK7iL8b3inx1jGuEu1qxouqWWW+xlQGeavWtv5c6DMKABLE9Eo+VUh3L56NC2K4yISlOwptoUA8/1gokdnEeWEu2RhVPpJQaumlc/7+mI/9Fg2AF7R2Dw1ICGmbggDTzzhTX6aQGnwmrpqzDhdgJiUAV2tO3qw5HmOHXvNMiYcpfwrKEEo//Z7lbSolAiFrmpOhbPO3KRAGMjPRLa3d6SDdtkaAUuknC9XDPfOYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNZIKXgbCriWkujkNthMbz/hUW67Wc99Ub2fE22OHkI=;
 b=T4CFUpqKhplVasFxqMgb0c2jw+qB0qn0JbqBRUjdN/u/K2m0P5419odPbN94NlUzql97xZYL43HNG1+Px8KvPNobYJsO2LESFjEqchp+mCJ5BH3Xtz7wbTR2XA9YrmW06n9/RgrCakyehOsyTm+M2rnIbZ461irno48+qACCC4vYmsD7PGu+0qb/iPdkISt4P7Yf1STj/6IzZ8S+oGxWSgVa6VgYFWk1NHVWfGsrsLXAS5cUHTVsVsYCnrGbKEqKB/7FyOTmcroHleRk+e6Ejfspkx3ZSbn4fDxEYky7VSuAKIQy17t66MfyHdgUyjK+c/IWlfgkpuf53ErGmj/BKg==
Received: from DB7PR02MB4265.eurprd02.prod.outlook.com (2603:10a6:10:43::19)
 by AS2PR02MB9835.eurprd02.prod.outlook.com (2603:10a6:20b:609::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Fri, 25 Jul
 2025 21:09:50 +0000
Received: from DB7PR02MB4265.eurprd02.prod.outlook.com
 ([fe80::1f5b:401:f731:6dcf]) by DB7PR02MB4265.eurprd02.prod.outlook.com
 ([fe80::1f5b:401:f731:6dcf%6]) with mapi id 15.20.8880.029; Fri, 25 Jul 2025
 21:09:50 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "dyaitskov@gmail.com" <dyaitskov@gmail.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-phoenix - repository recovery tool
Thread-Topic: git-phoenix - repository recovery tool
Thread-Index: AQHb/afLK63StfZ2CEO1I5j6mSN4LQ==
Date: Fri, 25 Jul 2025 21:09:50 +0000
Message-ID:
 <DB7PR02MB42650FA1779D5A3608949423B359A@DB7PR02MB4265.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR02MB4265:EE_|AS2PR02MB9835:EE_
x-ms-office365-filtering-correlation-id: 7d7c1529-00af-46cd-663e-08ddcbbf9810
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799012|461199028|8060799015|15080799012|15030799006|8062599012|40105399003|52005399003|3412199025|440099028|26104999006|102099032|4295299021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?OXwvoYBVUcWWvYAvVkPaWUCj3vn7hTi+pEkr7HOAttvtdvWT6yiWWJR01w?=
 =?iso-8859-1?Q?MUF9l5dJQFerA9aLrgaz+kvuPdb3nJ757EbqJHXeB8ABZgnygg+Ixn/pXQ?=
 =?iso-8859-1?Q?/ahxKCSaiPjy9dN/Lt6MKTbS1pyOXy+UTH5/NlFGurWCKZ54ykV+CHMwPh?=
 =?iso-8859-1?Q?I5BXpJ2LaQwFZyUHvVg32X2l1yG8r4JFJDrimb3empMBlJSjBmB1szQ+U3?=
 =?iso-8859-1?Q?4h+tzWDEarA3bjFLAQRRdWIXlBoP9ChrdhlYc5GRxclVrVYpiJpe9uHbWz?=
 =?iso-8859-1?Q?iAxeJc/vyb0KA8m+msCaIlEuD3IQSNoTrByT3Mo+OXwfHuDKbEsv5kES6i?=
 =?iso-8859-1?Q?oZhIjtUyP0T8LQ7/yRF43WTQVw/7SxZrwakY1GTM6fm+LdLQospi2H+Vcz?=
 =?iso-8859-1?Q?GSQ9k+q6VAAPmQgEsDXnFeXSi6KaK1mxVGmSHblAMwSbAJxTmKx4QMf3Op?=
 =?iso-8859-1?Q?g/XLnGTZQlz07RzDrSaYRs2puIFxEYiFqoTO/xdThzZ3a1Ahjd+VPtI49N?=
 =?iso-8859-1?Q?9korKVm6SCs1HX4QgrTOb734MkLEjsIpk9LLfSGFWYHZcU8NrPQIkJBIYh?=
 =?iso-8859-1?Q?V5gborPXx4zGbO3MfpiByixpDJ/MiksZnsX6UX16qlHOqfCeJGJBVZ7TYF?=
 =?iso-8859-1?Q?tAPC3nM9uBM+aKZG6AxpVhZq86OzDfaJ5xvazrUYp4yMf/ECAq63GQEXXk?=
 =?iso-8859-1?Q?lA0jkTEGEwUgXpTDUam04n+ai6MD7EZWzRtgvNWFplIYw/WAclFy8zgtvu?=
 =?iso-8859-1?Q?F9xaTO1rromLD6OLBYvYUChLTDpbTWavRY9OUV2YMGd6NMuF7Rb6bN8e6q?=
 =?iso-8859-1?Q?XiqThRfwqZrgkOYyXk/AJNf+d0B/qc0mG/W8LWK2ZRweUxxZcUS43+VC1K?=
 =?iso-8859-1?Q?RSxSMsk1I9a389ukDdKt5ZHFwVCMRbOI2hj3aW3yK4zdd5Pdb4L/wk4E6u?=
 =?iso-8859-1?Q?Nhfrawrr1rcAHsAjdbeHZxUAkjbQEAbRxoEfmPHXnZv63Wt7HDpW/nuZ0o?=
 =?iso-8859-1?Q?8IJNSR0SRkwSlIFm92vNcwv8hSdsmPisA0xtNGsCm7vjDRtC39l38nxo2t?=
 =?iso-8859-1?Q?xoAVnth/fd72uEnh5mfKAHMVeNeNpHYeHekFrYKC3F15MG3OvdjA9taAzm?=
 =?iso-8859-1?Q?XPB5UfdqQYWVX1gHGGGfbn3fKanrUWEyxJuPvB8H+DHoAcPw+F64KCY6xe?=
 =?iso-8859-1?Q?NrBFpncpWw5D6a9fgN742cs9b2bt1B+9k1/qfIY5u6IHJN1rV+Fjkjl5CQ?=
 =?iso-8859-1?Q?RzDbPNojbh4zH2m0YEbA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EpPKIxDwc8rhcrLw02qqY34W2THFw2oULnJquKbZcaOghWSeI5+QTDi0LP?=
 =?iso-8859-1?Q?w7jOrUQ9agwVEIL501KQw+sUrbEGrTrFBDfDudljQlrZm+3y6uRe7jom37?=
 =?iso-8859-1?Q?HI2ZMRVFpalLPSRLzPkZtyCh2eNs9MyiaLO6UGRO7gIwvrvR3B7ONJoQtz?=
 =?iso-8859-1?Q?AmHQNQ8GMRGQ/43RpZj3IDO2THVxJwg5eAfVbr6CIXL1Ncv5Bt7kiDSpgT?=
 =?iso-8859-1?Q?7mt+d0ZVXQ6/OIg/dYRZOlJTddbD1CmssHiAoimnshLF+fN9Qou6YGv6O1?=
 =?iso-8859-1?Q?JGTF1jvugY7RtMfHspewVa3Z4JHHxmkVBvokL4C++IHwFYvIs0vh8aVh97?=
 =?iso-8859-1?Q?i43rqCZWDiEOpUtU3OoKYxgRHTlt25EuJKV+5gk+tbJhAMmz7C1jRc131d?=
 =?iso-8859-1?Q?UL0ac+AjLB7L0/EtJhCfCi9UCnFcdIN7JTZhRSMswWJUWMdtdfqBB/Z/uh?=
 =?iso-8859-1?Q?2Y8wDBwm6NGwzXFHAxCD2TTes6IOZIh5RKKo17CME5RwvgGxIemVEPo0JH?=
 =?iso-8859-1?Q?+0Xt8XTCpuzBU8XQiYuvCARNhVJUDIj9tzt9wU/ZpewX5KEgvKYacLAGeU?=
 =?iso-8859-1?Q?V5/iXEK5ptI20gpisB/+zpZyifc/01V4YVmjBCxguNObKxS5dfiOjzv9gq?=
 =?iso-8859-1?Q?dgrZoTNYMpzE/ij5Kuq7zl9/mrBYDswLe94eB2EvqcT/IJOVRUAhm2tIfU?=
 =?iso-8859-1?Q?lNsDe4mMqOyIOJoi6HVvzCv8mCjqgNFf4wNJdviv+YoqtQIDSXMlS8yI6q?=
 =?iso-8859-1?Q?nNyWVYlAghRoopPv5hIBcQ2VPghhnKfd8XpZt8IH9k9Fg1Odo/FScJfpbr?=
 =?iso-8859-1?Q?SyNxzx4zbGnnCF28Y+cTHMpMiYv2UTZKB/aQRtK9SaDBtVOnBY/Y0mj/Ot?=
 =?iso-8859-1?Q?yyDtAaV4NdKzjQzVr6QuLoxYTn9ix0JYvrCQNqgUnD3AVFH1JgjH3J651V?=
 =?iso-8859-1?Q?dIMDl3Gy8d7PUswLIEQC2XYPsvZrkMe4q6WKdS/eGOCabsfPsMh49YLneP?=
 =?iso-8859-1?Q?jgXRm2on2jNwVbA1tD203pqywczuCVRJDgkR1VaOzSRPCsDn0se/62yPQM?=
 =?iso-8859-1?Q?sAOZbUlQ7SRfK3tJk/Ays6AStxZ0P+i33Du/PJUpUXDgZW2ClHZsx6ZFni?=
 =?iso-8859-1?Q?n1nz0Rx72WrZrcgKcoTadH2don1CpI0X59IUdrg7kSrxnSo7iUHxTYBAPa?=
 =?iso-8859-1?Q?j+OsExIurZbJJQo+XMNdZfUxNiZTMmt7XGzxMH4Yku/WcqAsXcwi/eIURB?=
 =?iso-8859-1?Q?V/3AhW74QH5Dr18Hqb/rPYAVZfoRf+WWaNN3SVEVMAKCB3UBI88PAusSbO?=
 =?iso-8859-1?Q?myIdvVcz1aIhp4J7p3rqbqBazH0rw7tx97o5A3XamJ/aYlY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB4265.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d7c1529-00af-46cd-663e-08ddcbbf9810
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2025 21:09:50.6735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9835

=A0 =A0 ```=0A=
=A0 =A0 Hi Daniil,=0A=
=0A=
=A0 =A0 I saw your message on the web about `git-phoenix`.=0A=
=0A=
=A0 =A0 > [ANN] git-phoenix - repository recovery tool=0A=
=0A=
    I am curious how this accidental rm rf * typo happened on your system ?=
=0A=
=0A=
    Could you tell us more about it ?=0A=
   =0A=
    I guess the user/you was trying to remove a folder or so ?=0A=
=0A=
    I am wondering if I should disable this rm command, but the AI seems to=
 like it a lot !=0A=
=0A=
=A0 =A0 Best regards,=0A=
=A0 =A0 Skybuck Flying.=0A=
=0A=
    P.S.: This is an attempt to send a e-mail directly from windows 11 outl=
ook to the mailing list/reply functionality, manually, wish this mail luck =
! :D=0A=
=A0 =A0 ```=
