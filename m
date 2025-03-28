Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D046C4A35
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743158270; cv=fail; b=OdJkfjS9TRvEJ39GWIHBzBZWJm36YFCiGdE3cPouI31zD+Z3ZOPM3/kQqsmgi9z3NIYum3fdg3eUn2scSOgtizp0vBK+qzy17Jubs7XJRh2MyJyrYW6PZdIe/oQsXMA2xZXRdWt0V17c7DMrRj8jAnyQBgnnzOzqUmZ+dQ5kS+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743158270; c=relaxed/simple;
	bh=/mIb04wGrWbgRd24yvi+UqrAIXXU7HAugxObkNDYQwA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ajVTK+kjuHRHdmyXxYu2kOdlWc5HXJrb2ywe7R2gdUBqOnNbwexhda/iow//xtThmrVLUp8HeVHaH2qMRl+hAZFJhHmm+DDGG9jgjWfvku88MSSSq384NQyutIG7bLMUsA4pYR7J1261ScLsyVJRxz/BUPGEDhgMv/i6WkVQiv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=commvault.com; spf=pass smtp.mailfrom=commvault.com; dkim=pass (2048-bit key) header.d=commvault.com header.i=@commvault.com header.b=QyNpa7gE; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=commvault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commvault.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commvault.com header.i=@commvault.com header.b="QyNpa7gE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IMBT9UQJzhkpakD2UZ1yPhjdLrD5BjYlqfv74nTzC8PvR34LRQkYz6BVqZI+WgEpPpHXmnYqFk5ANjJHYgF//lNxkYPY0gw2xdJVjfMkZBf18C3weZ4M9S/+2gCjwizeJtfOUcDB9tySrYvvJvBPWVh1Q8QrtDEXFmLB62gxnKVhjUsbno4SwUCTkKeYMVP5JAb35Yu/8krOszrseAYyAlO8O8PcKngOfcdyCHy09nwiP1PealR+4SWS6g60ctIZT3xLKUNKTt4ACSY3tzQJ+Gp+a/kWe2xH7u8BdgJd+Y7fEtKr81wAZ2b8Xluzugy7hgY1CiO1QOAzMdMx7Q3ogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mIb04wGrWbgRd24yvi+UqrAIXXU7HAugxObkNDYQwA=;
 b=VOvX/D89C40vCsROs7RYG5XzGTnjrkRuhktp8qicy09Oi9BF0eWvMRbYfcdPVtkn4SUTRG21qMD8B3q/i/lnwAPUktTziaasGQkNt2sVVI7kHsFen++39bkPybtp5QH2jf3SRV9NPqy3Upn5XeWJb+nVt9RaHXzLKnFjU1Ot0QfOHEmNO6YrPZcegb/OZloiXWWyAwIK056oQzwMNg7YUrWuFwxh4Sntia4dSk68TQ02QeSWHIRO39Fyww3xOeaCo9oud5vJXrcqG+ESJcfsfl7MzvbPpT/1RqTMfZVccTGbcU/TbiPPM732ByyMqRkrPX8jUO2eleVuEReZQEfqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=commvault.com; dmarc=pass action=none
 header.from=commvault.com; dkim=pass header.d=commvault.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=commvault.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mIb04wGrWbgRd24yvi+UqrAIXXU7HAugxObkNDYQwA=;
 b=QyNpa7gEHFljf4no4nU+xqxwSSyrR/j29QiYZMO41MS8xC86xuXpk73ROnffCQkH6SuA2EKzoVp9k+CQ6v0wXk9PlR3aGbdoEn+XkQRLyQIR4M8B2xWpyHR8g54tu0KNCv12hY/MYSFug3VdMBXlFej0WsyPayzg4XWkmzGouL/1DdnT2N/3Vw2tSPWLdAhZXAgY8uHIvKkhtVrRp35n0Ham6Ar0MkDWj78jyXvHll/5y6vhke9dFFohamhkrIQXrT+G4+OWzALLGNp95TjcPMfxsLXbF3whDzgWQz0FG06Uy8xf8sb341uHMNE3Ool82I27IHBtVdac2uncNGYsEg==
Received: from SA1PR19MB7013.namprd19.prod.outlook.com (2603:10b6:806:2bd::22)
 by SJ1PR19MB6164.namprd19.prod.outlook.com (2603:10b6:a03:489::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 10:37:43 +0000
Received: from SA1PR19MB7013.namprd19.prod.outlook.com
 ([fe80::24a8:69bb:604d:3b4c]) by SA1PR19MB7013.namprd19.prod.outlook.com
 ([fe80::24a8:69bb:604d:3b4c%7]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 10:37:43 +0000
From: Akash S <akashs@commvault.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
CC: Adithya Urugudige <aurugudige@commvault.com>, Abhishek Dalmia
	<adalmia@commvault.com>
Subject: git push --mirror hung indefinitely
Thread-Topic: git push --mirror hung indefinitely
Thread-Index: AdufzW7TVmABLLOOQZ+8w7Ln2MUnlA==
Date: Fri, 28 Mar 2025 10:37:43 +0000
Message-ID:
 <SA1PR19MB7013490588962D983094128DC0A02@SA1PR19MB7013.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=commvault.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR19MB7013:EE_|SJ1PR19MB6164:EE_
x-ms-office365-filtering-correlation-id: 753c5adb-c267-437b-cd7c-08dd6de49277
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?s6uSBn8LbC6XRBcrjGeoksZwjoun3GGEguxsM3VoHXHYvqzzwyWSEzEDv4?=
 =?iso-8859-1?Q?VTlrJkk3DmX4gSVc2C/XFtoWawyA7E0jqx9ZMVhfUIAcudm+hkAr1JZRL9?=
 =?iso-8859-1?Q?4hC3pjJuv9n5S4OfY8RSSoXdov7N5SQxpAiKEnChB3QWE4PfkLegrkd1JO?=
 =?iso-8859-1?Q?n/2N3zHp3m8LDxO0/DRSxG6CPiR28cD8bhCo7ydZrs7CBr7h19xe3Igzok?=
 =?iso-8859-1?Q?Fr6xm9OoB0k0tSwqvWTclIhbdGSLn3NZ6JWtyKTV9ooXNZ4unV0dRJeV5j?=
 =?iso-8859-1?Q?qYauLLYWDeNPjs3jMmWnAjSwkqQt5jQeOY5UDKC5lJV/u9Q0Ju3QFo5qx3?=
 =?iso-8859-1?Q?W0oOCzwMRpCm7wkSewfw44Ei6gykBBQWxkEJLFSEEAyE6uCdHf/AK3zXJh?=
 =?iso-8859-1?Q?0jExS2a7PkoJDjZ/JYmCD/HYv5+oA4SVf0ezW6U9LOKyn60tG+I3GC93Wy?=
 =?iso-8859-1?Q?bMR/NQwVZ7l7uFBKhytrt9YG3DzU2n4EslSRT59rV3lVIHW8cD06TimXZr?=
 =?iso-8859-1?Q?JrKnfUHGrJFWKP1rF79B0kQLXc2A1uG6zpHdYG089QXsHH6ouYPG/HLqOm?=
 =?iso-8859-1?Q?btkgIH0JTluGt+1ZZLAO5J2Iqj1xUYhEP6DV/MgiHqfwqQKxEJWADlTxiV?=
 =?iso-8859-1?Q?lqCSDTfR3LTqv4ozyAGoMp964NwzgTPxJg2Mgd0rBcYCuYESMndNtubPfh?=
 =?iso-8859-1?Q?fos7wyQC8ihyM9oMS9jbgq89zBfv63MuUhdoaPIevEh8hsYb0GDGR7z0cO?=
 =?iso-8859-1?Q?ZlF7JE8r73wHOOq2gW5qQgwSXUXWtKo0VULaKHQphArKPzEVMM3c9pFY8p?=
 =?iso-8859-1?Q?6ni2rDBzBuG4+HVyGqZzStw8kjTc4I3Bl5uTpD1j7TI1RQUn78dUybOOJl?=
 =?iso-8859-1?Q?FtaBeYtR9cSUaEj9KEKey6+yJjrui8nTL933nE6UL2aBXH0PyUkctRjAHm?=
 =?iso-8859-1?Q?NEbecHw8jlXkPoF/pZ4e4N3LVsNZhoAyg6nt/ByTbOhfp6Q1v+u0xW/cWK?=
 =?iso-8859-1?Q?4wiBJtH9zR/6LobYhygBEtOiut1XrlAd+mit4LhFowQYdyHeKKOY5Ky4rz?=
 =?iso-8859-1?Q?4fSGD9p6RKtmU0qURJv2A6p7MwrY7FlF2dSuzDFTOn7rqpYeX71p+VbUQI?=
 =?iso-8859-1?Q?NQQHBtDQwdybzyQ/7UuxhlZztT+Ws6cuj6Uc4ZWBzdYY3NizHe0Scom/py?=
 =?iso-8859-1?Q?Izt75/RrCewwJqcvrbcQvOB1Y9GxaR70nKQzp3fLKdsNIx9QGXk4N+B8cf?=
 =?iso-8859-1?Q?ZEPJeslZNQxDe+fFHWS6CRpdzv9YEBkJBWTmz6YoZWsTcHr4Mre8QLG50i?=
 =?iso-8859-1?Q?gcN368oH1Tr0mo68AdCwkTKiGDNs5HGhTGtw5FgPsFu5MJmGo0h69T42QW?=
 =?iso-8859-1?Q?QDSrsqWL++MmhSVKIfBEdCR16QWkaytPqfXgyXHp4qlhopztPmRQgijQ9x?=
 =?iso-8859-1?Q?sg2f8YLhJwVUBQJegJ4xpQkixemaSPmMNPCIhQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB7013.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5EMplpd8dE3VAUh/8Nd00G9C59gtTwlFAUhfJmaz3TfKHow1BgCcEK72KR?=
 =?iso-8859-1?Q?PRgmkFc1jxZQUtZdSjErfpk43oGgDNusSnx31HIBEHV/wgvxxURSfAQ4jX?=
 =?iso-8859-1?Q?L3YtHInmM7ePYMMGTRspcZJs3D3+yYGUp8FC//LQQRSUKfZ7SlURhEZxe9?=
 =?iso-8859-1?Q?uafZj/cFEQBdFMVb3dLMtRUXPbJwfvfDkdFMVylFHyAOar9TeQDC5iJzGG?=
 =?iso-8859-1?Q?lqHwZSVyYcY/sgYiqwyhVSv0v/w+0NGf1mgImKCrAbRIdeb19r85bjabj4?=
 =?iso-8859-1?Q?5GWsOluk/9PGaxkio2x8dHoK46s/cqlDujKuVIm9Pj8/9tenVkLAaRU3xi?=
 =?iso-8859-1?Q?tk93L+D0JKrlGumGJzgHOiIf8xcVRMZ75uAPe8Sp3EkfOEw7XWOWk43vPT?=
 =?iso-8859-1?Q?t5/iKARq/BEwRmM64K0O+KoXTcUpbNVgP+D0/s6eIRulH4n8i/rwQFbvno?=
 =?iso-8859-1?Q?c3xL0HUjvT4JI6MLYGMEBrH2NAIb/vOvAS2N9vwDw4UqntDAaVSlszuMPW?=
 =?iso-8859-1?Q?TBGjGORku62jh0WBdUQEm2G5YuooNi+Ij+BKCqIJHKcr0QvtaF44WI9T3O?=
 =?iso-8859-1?Q?UamMwJFkH5Fp3wWZTN550+SQXfj3FqQcBGVQXbNKVIIT/KIbLG36O5AIc0?=
 =?iso-8859-1?Q?z0fLj0kpDJ2OvPn0mQTJY4jvs1VhnaxNAKl+KRwe51DjMIBH5XDZZZ29QN?=
 =?iso-8859-1?Q?/ZSYB/HSnXZzVugzBJSXzRSief+HESID+pg9PCwqZEG4CufVoENKYZmyIz?=
 =?iso-8859-1?Q?pmKC2weDi/bdU/Ny67xtj7kFAeXt+3Xt8Lir53M5E7s8hZwA7XUVLAR4iF?=
 =?iso-8859-1?Q?oIh0yUOdOLZPD5yqpp10FVB7WzViXJMfarU4bVal33bi23pqR/Ab/EWyuT?=
 =?iso-8859-1?Q?Imh6wIXTx8Hq74P4LG7HTiEFt0/nNENy0mBAskHxg2T4b0etzBwbb+gLfT?=
 =?iso-8859-1?Q?Kfrmu/wJ9KHiBr8dP9VKSzYm6xxzqu8Fz3IgTYgaquuQjNclxXKE/GxWkY?=
 =?iso-8859-1?Q?D5gcbYkJYr7B2ygujfJav23q0JkYLK/KudKUD8d0HcBgg4RYX9tc0HZtGJ?=
 =?iso-8859-1?Q?JCnGzYLhE2d5E6jVrniszcpMCn6oboT0UemhbDbZgr0avhReMV1sPLJfdm?=
 =?iso-8859-1?Q?nMJyqlHtrrUdxXYB6loqMcdpIH3/bXsJGJ2daMc5DvU+NW45VC4ScKmHxD?=
 =?iso-8859-1?Q?DzmIjmFw3RbGy9MroI6p8vr+8+P73oWSXRrdbBGrh3vF95sHDZtezPQZum?=
 =?iso-8859-1?Q?Dpu0URzzIb4mrrc9Z8k67JbOu+oamZmghHSlyUB/+bpeI6p6OAYxjn3i/K?=
 =?iso-8859-1?Q?eOksjxjZUGQeRSnAGACGywVvAVokVAYQBBhnpyRBiKy3HtdMmSEbw8zu0T?=
 =?iso-8859-1?Q?UXNoPhP7o4m1ZH/58/7rAbPwiUXsrHvUxkY266Lo5zbeK1vgBXCDbbEITJ?=
 =?iso-8859-1?Q?OaQtAvmkMZb3SOwBEcwsUvK2566hV/EooNwcUwU18XoXgCozoMxykyK6Tv?=
 =?iso-8859-1?Q?p0alRzu7hUpBxms6bmz69q5xr1RY4+UROXNcYPiZ/92bxq0cJ3USG29sly?=
 =?iso-8859-1?Q?ke3kudYK8v+tAP0C2mpN8nW6+NoqzGw7rTqnJe/A43Tb+tPZ27FykrGHLz?=
 =?iso-8859-1?Q?2AYDLBYNtFTDPiUTiq5IOfOKckSVlMh7xj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: commvault.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB7013.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753c5adb-c267-437b-cd7c-08dd6de49277
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2025 10:37:43.3744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 40ed1e38-a16e-4622-9d7c-45161b6969d5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0smUeI2akgpVBoHIiz50sWz7qTiMlXkXWO81kC9pK41oQD/55Jglhs/vT8D56ZMBJ/KG6hWDdaO/Qq+a3hthA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB6164

Hi,

We are attempting to push a bare repository on our local disk to Azure DevO=
ps using the command "git push -mirror <URL>".=20

Git version being used: 2.48.1 and no global git configurations exist in th=
e machine.

Issue: command progresses for 5-10 mins and then the git processes get hung=
 after we see the output "Storing index (done)" and remains hung indefinite=
ly.=20

Steps to reproduce:
i) Bare clone open source repo (elasticsearch or node) to local disk.
ii) Run "git lfs push -mirror" to any repository in an Azure DevOps organiz=
ation using PAT authentication.
iii) Issue happens intermittently, so alternating the push operation betwee=
n the local elasticsearch and node repo to the same remote repository shoul=
d help recreate the issue.

Workaround steps taken by us to not face this issue:

i) Since our repository is quite large (1.5 GB), we set http.postBuffer to =
50 MB, it did not help in resolving the issue.
ii) We have set GIT_CURL_TIMEOUT=3D180 along with =A0http.lowSpeedLimit=3D1=
 =A0http.lowSpeedTime=3D180. But nothing seems to make the process exit aft=
er it gets hung.
iii) We set the http.maxRequests=3D1 to avoid concurrent requests and that =
did not help either.
iv) We used the -no-thin option, did not work either, process still hung.
v) We have tried with different values as well for the above git config opt=
ions and nothing seemed to bring us out from the hung state.


GIT_TRACE=3D2 GIT_CURL_VERBOSE=3D2 outputs:
remote: Storing packfile... done (43758 ms)
08:26:52.444122 http.c:878=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D In=
fo: TLSv1.3 (IN), TLS app data, [no content] (0):
08:26:57.457679 http.c:878=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D In=
fo: TLSv1.3 (IN), TLS app data, [no content] (0):
08:26:58.309172 http.c:878=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D In=
fo: TLSv1.3 (IN), TLS app data, [no content] (0):
remote: Storing index... done (5865 ms)
08:28:09.549750 http.c:878=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D In=
fo: TLSv1.3 (IN), TLS app data, [no content] (0):
08:28:09.550215 http.c:878=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D In=
fo: TLSv1.3 (IN), TLS app data, [no content] (0):
08:28:09.550751 http.c:878=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D In=
fo: TLSv1.3 (IN), TLS app data, [no content] (0):
08:28:09.551245 http.c:878=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D In=
fo: TLSv1.3 (IN), TLS app data, [no content] (0):
08:28:09.551768 http.c:878=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D In=
fo: TLSv1.3 (IN), TLS app data, [no content] (0):
08:28:09.551850 http.c:878=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=3D In=
fo: Connection #0 to host dev.azure.com left intact

Processes launched after running git push -mirror:
[root@dop02108c1eu06 ~]# ps -aef | grep Token
root=A0=A0=A0=A0 1043353 1043352=A0 0 08:17 pts/10=A0=A0 00:00:00 /usr/loca=
l/bin/git -c http.maxRequests=3D1 -c http.postBuffer=3D50000000 -c http.low=
SpeedLimit=3D1 -c http.lowSpeedTime=3D30 push --mirror --no-thin https://To=
ken:%3cTOKEN%3e@dev.azure.com/TestADOPATPolicy/cv-restores/_git/cv-restores
root=A0=A0=A0=A0 1043354 1043353=A0 0 08:17 pts/10=A0=A0 00:00:00 /usr/loca=
l/libexec/git-core/git remote-https https://Token:%3cTOKEN%3e@dev.azure.com=
/TestADOPATPolicy/cv-restores/_git/cv-restores https://Token:%3cTOKEN%3e@de=
v.azure.com/TestADOPATPolicy/cv-restores/_git/cv-restores
root=A0=A0=A0=A0 1043355 1043354=A0 0 08:17 pts/10=A0=A0 00:00:05 /usr/loca=
l/libexec/git-core/git-remote-https https://Token:%3cTOKEN%3e@dev.azure.com=
/TestADOPATPolicy/cv-restores/_git/cv-restores https://Token:%3cTOKEN%3e@de=
v.azure.com/TestADOPATPolicy/cv-restores/_git/cv-restores
root=A0=A0=A0=A0 1043377 1043355=A0 0 08:17 pts/10=A0=A0 00:00:03 /usr/loca=
l/libexec/git-core/git send-pack --stateless-rpc --helper-status --thin --p=
rogress https://Token:%3cTOKEN%3e@dev.azure.com/TestADOPATPolicy/cv-restore=
s/_git/cv-restores/ --stdin
root=A0=A0=A0=A0 1052699 1049394=A0 0 08:32 pts/14=A0=A0 00:00:00 grep --co=
lor=3Dauto Token

pstack of all above processes :
[root@dop02108c1eu06 ~]# pstack 1043353
#0=A0 0x00007f7face375a5 in read () from /lib64/libc.so.6
#1=A0 0x00007f7facdc7418 in __GI__IO_file_underflow () from /lib64/libc.so.=
6
#2=A0 0x00007f7facdbbdc8 in getdelim () from /lib64/libc.so.6
#3=A0 0x0000000000635eb8 in strbuf_getwholeline (sb=3Dsb@entry=3D0x7ffe7067=
cbf0, fp=3D0x1cf02c0, term=3Dterm@entry=3D10) at strbuf.c:645
#4=A0 0x00000000006360c0 in strbuf_getdelim_strip_crlf (sb=3D0x7ffe7067cbf0=
, fp=3D<optimized out>, term=3D10) at strbuf.c:727
#5=A0 0x000000000064dacc in recvline_fh (helper=3D0x1cf02c0, buffer=3D0x7ff=
e7067cbf0) at transport-helper.c:76
#6=A0 0x000000000064ec6e in recvline (helper=3D0x1cf8570, buffer=3D0x7ffe70=
67cbf0) at transport-helper.c:923
#7=A0 push_update_refs_status (data=3D0x1cf8570, remote_refs=3D0x1d2b3a0, f=
lags=3D10) at transport-helper.c:923
#8=A0 0x0000000000650c3f in push_refs_with_push (flags=3D10, remote_refs=3D=
0x1d2b3a0, transport=3D0x1cf82c0) at transport-helper.c:1088
#9=A0 push_refs (transport=3D0x1cf82c0, remote_refs=3D0x1d2b3a0, flags=3D10=
) at transport-helper.c:1189
#10 0x0000000000653faf in transport_push (r=3D0x993960 <the_repo>, transpor=
t=3Dtransport@entry=3D0x1cf82c0, rs=3Drs@entry=3D0x98f1f0 <rs>, flags=3Dfla=
gs@entry=3D10, reject_reasons=3Dreject_reasons@entry=3D0x7ffe7067cfa0) at t=
ransport.c:1502
#11 0x0000000000491cef in push_with_options (flags=3D10, rs=3D0x98f1f0 <rs>=
, transport=3D0x1cf82c0) at builtin/push.c:387
#12 do_push (remote=3D0x1cf7b50, push_options=3D0x97aba0 <push_options_conf=
ig>, flags=3D10) at builtin/push.c:442
#13 cmd_push (argc=3D<optimized out>, argv=3D<optimized out>, prefix=3D<opt=
imized out>, repository=3D<optimized out>) at builtin/push.c:664
#14 0x0000000000404eae in run_builtin (repo=3D0x993960 <the_repo>, argv=3D<=
optimized out>, argc=3D<optimized out>, p=3D0x971fe8 <commands+2184>) at gi=
t.c:480
#15 handle_builtin (args=3Dargs@entry=3D0x7ffe7067dbe0) at git.c:740
#16 0x0000000000405f1f in run_argv (args=3Dargs@entry=3D0x7ffe7067dbe0) at =
git.c:807
#17 0x00000000004068d6 in cmd_main (argc=3D<optimized out>, argc@entry=3D13=
, argv=3D<optimized out>, argv@entry=3D0x7ffe7067ddb8) at git.c:947
#18 0x0000000000404a67 in main (argc=3D13, argv=3D0x7ffe7067ddb8) at common=
-main.c:64
[root@dop02108c1eu06 ~]#

[root@dop02108c1eu06 ~]# pstack 1043354
#0=A0 0x00007f64b602b468 in waitpid () from /lib64/libpthread.so.0
#1=A0 0x000000000060fc0b in wait_or_whine (pid=3D1043355, argv0=3D0x298f5f0=
 "git-remote-https", in_signal=3Din_signal@entry=3D0) at run-command.c:559
#2=A0 0x00000000006115c9 in finish_command (cmd=3Dcmd@entry=3D0x7ffe5685e60=
0) at run-command.c:989
#3=A0 0x0000000000611679 in run_command (cmd=3Dcmd@entry=3D0x7ffe5685e600) =
at run-command.c:1015
#4=A0 0x0000000000405fe7 in execv_dashed_external (argv=3D<optimized out>) =
at git.c:777
#5=A0 run_argv (args=3Dargs@entry=3D0x7ffe5685e6d0) at git.c:844
#6=A0 0x00000000004068d6 in cmd_main (argc=3D<optimized out>, argc@entry=3D=
4, argv=3D<optimized out>, argv@entry=3D0x7ffe5685e8a8) at git.c:947
#7=A0 0x0000000000404a67 in main (argc=3D4, argv=3D0x7ffe5685e8a8) at commo=
n-main.c:64
[root@dop02108c1eu06 ~]#

[root@dop02108c1eu06 ~]# pstack 1043355 #No Pstack strace
[root@dop02108c1eu06 ~]# pstack 1043377
Thread 2 (Thread 0x7fa246a18700 (LWP 1043384)):
#0=A0 0x00007fa24ce568e4 in read () from /lib64/libpthread.so.0
#1=A0 0x000000000066a07e in xread (fd=3Dfd@entry=3D0, buf=3Dbuf@entry=3D0x7=
fa246a07d7c, len=3Dlen@entry=3D4) at wrapper.c:234
#2=A0 0x000000000066a1eb in read_in_full (fd=3D0, buf=3Dbuf@entry=3D0x7fa24=
6a07d7c, count=3Dcount@entry=3D4) at wrapper.c:292
#3=A0 0x00000000005c4d32 in get_packet_data (fd=3Dfd@entry=3D0, src_buf=3Ds=
rc_buf@entry=3D0x0, src_size=3Dsrc_size@entry=3D0x0, dst=3Ddst@entry=3D0x7f=
a246a07d7c, size=3Dsize@entry=3D4, options=3Doptions@entry=3D1) at pkt-line=
.c:354
#4=A0 0x00000000005c5827 in packet_read_with_status (fd=3Dfd@entry=3D0, src=
_buffer=3Dsrc_buffer@entry=3D0x0, src_len=3Dsrc_len@entry=3D0x0, buffer=3Db=
uffer@entry=3D0x7fa246a07e20 "\001\060\060\061aok refs/tags/v0.10.45\n", si=
ze=3Dsize@entry=3D65520, pktlen=3Dpktlen@entry=3D0x7fa246a07df8, options=3D=
1) at pkt-line.c:422
#5=A0 0x00000000005c5fa9 in recv_sideband (me=3Dme@entry=3D0x6e35ea "send-p=
ack", in_stream=3D0, out=3Dout@entry=3D5) at pkt-line.c:586
#6=A0 0x0000000000612bf3 in sideband_demux (in=3D<optimized out>, out=3D5, =
data=3D0x7ffcfb7a3b08) at send-pack.c:283
#7=A0 0x000000000060fd8e in run_thread (data=3D0x7ffcfb7a3930) at run-comma=
nd.c:1040
#8=A0 0x00007fa24ce4d14a in start_thread () from /lib64/libpthread.so.0
#9=A0 0x00007fa24c974dc3 in clone () from /lib64/libc.so.6
Thread 1 (Thread 0x7fa24d49cb80 (LWP 1043377)):
#0=A0 0x00007fa24ce568e4 in read () from /lib64/libpthread.so.0
#1=A0 0x000000000066a07e in xread (fd=3Dfd@entry=3D4, buf=3Dbuf@entry=3D0x7=
ffcfb7a36cc, len=3Dlen@entry=3D4) at wrapper.c:234
#2=A0 0x000000000066a1eb in read_in_full (fd=3D4, buf=3Dbuf@entry=3D0x7ffcf=
b7a36cc, count=3Dcount@entry=3D4) at wrapper.c:292
#3=A0 0x00000000005c4d32 in get_packet_data (fd=3Dfd@entry=3D4, src_buf=3Ds=
rc_buf@entry=3D0x7ffcfb7a3968, src_size=3Dsrc_size@entry=3D0x7ffcfb7a3970, =
dst=3Ddst@entry=3D0x7ffcfb7a36cc, size=3Dsize@entry=3D4, options=3Doptions@=
entry=3D6) at pkt-line.c:354
#4=A0 0x00000000005c5827 in packet_read_with_status (fd=3D4, src_buffer=3Ds=
rc_buffer@entry=3D0x7ffcfb7a3968, src_len=3Dsrc_len@entry=3D0x7ffcfb7a3970,=
 buffer=3D0x99af00 <packet_buffer> "ok", size=3D65520, pktlen=3Dpktlen@entr=
y=3D0x7ffcfb7a398c, options=3D6) at pkt-line.c:422
#5=A0 0x00000000005c5d10 in packet_reader_read (reader=3Dreader@entry=3D0x7=
ffcfb7a3960) at pkt-line.c:640
#6=A0 0x00000000005c60ac in packet_reader_read (reader=3Dreader@entry=3D0x7=
ffcfb7a3960) at pkt-line.c:626
#7=A0 0x0000000000612d98 in receive_status (reader=3Dreader@entry=3D0x7ffcf=
b7a3960, refs=3Drefs@entry=3D0x1583c90) at send-pack.c:183
#8=A0 0x0000000000613bbb in send_pack (args=3Dargs@entry=3D0x98f5c0 <args>,=
 fd=3Dfd@entry=3D0x7ffcfb7a3b08, conn=3Dconn@entry=3D0x0, remote_refs=3D<op=
timized out>, extra_have=3Dextra_have@entry=3D0x7ffcfb7a3b70) at send-pack.=
c:746
#9=A0 0x00000000004b64de in cmd_send_pack (argc=3D<optimized out>, argv=3D0=
x153e660, prefix=3D<optimized out>, repo=3D<optimized out>) at builtin/send=
-pack.c:320
#10 0x0000000000404eae in run_builtin (repo=3D0x993960 <the_repo>, argv=3D<=
optimized out>, argc=3D<optimized out>, p=3D0x9721c8 <commands+2664>) at gi=
t.c:480
#11 handle_builtin (args=3Dargs@entry=3D0x7ffcfb7a4580) at git.c:740
#12 0x0000000000405f1f in run_argv (args=3Dargs@entry=3D0x7ffcfb7a4580) at =
git.c:807
#13 0x00000000004068d6 in cmd_main (argc=3D<optimized out>, argc@entry=3D8,=
 argv=3D<optimized out>, argv@entry=3D0x7ffcfb7a4758) at git.c:947
#14 0x0000000000404a67 in main (argc=3D8, argv=3D0x7ffcfb7a4758) at common-=
main.c:64

strace of all above processes:

[root@dop02108c1eu06 ~]# strace -p 1043353
strace: Process 1043353 attached
read(3,


[root@dop02108c1eu06 workingDir]# strace -p 1043354
strace: Process 1043354 attached
wait4(1043355,

[root@dop02108c1eu06 workingDir]# strace -p 1043355
rt_sigaction(SIGPIPE, {sa_handler=3DSIG_DFL, sa_mask=3D[PIPE], sa_flags=3DS=
A_RESTORER|SA_RESTART, sa_restorer=3D0x7f337607eb20}, NULL, 8) =3D 0
select(4, [3], [], [], {tv_sec=3D0, tv_usec=3D795000}) =3D 1 (in [3], left =
{tv_sec=3D0, tv_usec=3D794998})
rt_sigaction(SIGPIPE, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[PIPE], sa_fla=
gs=3DSA_RESTORER|SA_RESTART, sa_restorer=3D0x7f337607eb20}, 8) =3D 0
rt_sigaction(SIGPIPE, {sa_handler=3DSIG_IGN, sa_mask=3D[PIPE], sa_flags=3DS=
A_RESTORER|SA_RESTART, sa_restorer=3D0x7f337607eb20}, NULL, 8) =3D 0
poll([{fd=3D3, events=3DPOLLIN|POLLPRI|POLLRDNORM|POLLRDBAND}], 1, 0) =3D 1=
 ([{fd=3D3, revents=3DPOLLIN|POLLRDNORM}])
read(3, "\27\3\3\0006", 5)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5
read(3, "\216v\301[\367\322\25\326\25\266p6\322\211%\2237\305$W\21\r.oK\241=
\207f\306\232~\23"..., 54) =3D 54
write(2, "08:28:09.551245 http.c:878=A0=A0=A0=A0=A0 "..., 95) =3D 95
write(5, "001f\001001aok refs/tags/v0.10.45\n", 31) =3D 31
rt_sigaction(SIGPIPE, {sa_handler=3DSIG_DFL, sa_mask=3D[PIPE], sa_flags=3DS=
A_RESTORER|SA_RESTART, sa_restorer=3D0x7f337607eb20}, NULL, 8) =3D 0
select(4, [3], [], [], {tv_sec=3D0, tv_usec=3D795000}) =3D 1 (in [3], left =
{tv_sec=3D0, tv_usec=3D794998})
rt_sigaction(SIGPIPE, NULL, {sa_handler=3DSIG_DFL, sa_mask=3D[PIPE], sa_fla=
gs=3DSA_RESTORER|SA_RESTART, sa_restorer=3D0x7f337607eb20}, 8) =3D 0
rt_sigaction(SIGPIPE, {sa_handler=3DSIG_IGN, sa_mask=3D[PIPE], sa_flags=3DS=
A_RESTORER|SA_RESTART, sa_restorer=3D0x7f337607eb20}, NULL, 8) =3D 0
poll([{fd=3D3, events=3DPOLLIN|POLLPRI|POLLRDNORM|POLLRDBAND}], 1, 0) =3D 1=
 ([{fd=3D3, revents=3DPOLLIN|POLLRDNORM}])
read(3, "\27\3\3\0\26", 5)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D 5
read(3, "\346\302h\301\6g\216s^:\301\352\274\341G\6\245\3AT+7", 22) =3D 22
write(2, "08:28:09.551768 http.c:878=A0=A0=A0=A0=A0 "..., 95) =3D 95
write(2, "08:28:09.551850 http.c:878=A0=A0=A0=A0=A0 "..., 97) =3D 97
rt_sigaction(SIGPIPE, {sa_handler=3DSIG_DFL, sa_mask=3D[PIPE], sa_flags=3DS=
A_RESTORER|SA_RESTART, sa_restorer=3D0x7f337607eb20}, NULL, 8) =3D 0
read(6,

[root@dop02108c1eu06 ~]# strace -p 1043377
strace: Process 1043377 attached
read(4,

Thanks,
Akash

