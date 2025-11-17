Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazolkn19011038.outbound.protection.outlook.com [52.103.39.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F1C331A7E
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.39.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386049; cv=fail; b=O3FMqDq92W9Ivdj53gmfG6cfMsywfheO/brcDUa0QD0nAS85gXU2MjZG5OOs97mejh83DxfriWP8GKjsgKpqduVJJi1bRf1zjX+y+4y0DsltLr3mzn1etkJOctQPUz5u8cuzhhqehWh2KyohpIJL9/32wBOTGyW5hA1ZLn6MU3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386049; c=relaxed/simple;
	bh=Zyq4c6Ih6TD7RB/TUMGNpeJLBvz42QVX6daXJU1wEl4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q3VChCHGnofoYWFEHqcLz+elHCecvk2zFb8LcMZEDhfVzIfUep6ujGQjaU/R+fmy7kQIFRMA71gFPsfP+mItwfVt27hYpWXicjT//1jiJFZdF3mAGkeZ/L3cdKq2gL5+T56XSQmp9uhhmX35zIhdELFwBhGjUzStXyehRpx79Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=FPEIqEJJ; arc=fail smtp.client-ip=52.103.39.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="FPEIqEJJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4iLsApYbdE5UQ7ITvFzMNNy1g3nI5Q/XU3YeKlg+0r/pEFSS6S2mol+bEarx2SLqL+Sf2Zf/EkViKFafSD3OCGvwALXLAXsAGzmu2bLIsCZ7H6psv4VMp2KCXOb8u7jBcdvdxCeg5eoz0WkCTgaVY7pLeYv/hrYp/LHebIIVo8aXSXWmT/5tmCgPJt5I9Y/qVe8ihjhmYUHAUAIEl6aNoD9FyZ4c2Q079/OdTMBPaURkXtw5kzGaYHe2yppoELR28kiHgQNE8gjSg6haOothNSmgzpjvpobDRyNq0+A9CHs8l37zRJFYCOG5W1E+rPaIuS0aXmOsCvkHmgy0JfI9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zyq4c6Ih6TD7RB/TUMGNpeJLBvz42QVX6daXJU1wEl4=;
 b=Z0vERJoILj0Cj3AU+j0rRRpQvSClzCeJWwm89ajoCEXGU2B15sVktiEdSWsaiQjSZb3T5r8gxKbqMFyUyR44Z6QHtn3diwaJu+dnpTIAlx8CeqI2yb9/ezhaOSlOm81g1et9fSMWXCmn4eDOQ8Bzgo5NLA8ft20bHKZVxM6gEYIoUHi0cJyfO2CSAU5qM4wFnVu5gIR1CQxg4wUad8uLpvqFwZ4nZ/LaOx+LYrYsRP0D/lZz0dbNnGZz6VzsYNgC+ydpeGauXX4Xi7NdfyIZbuH7m+mJskWdbFvZ15Ac6DycMdqc9Y232T0wPi5AMJynrdGQNe/UY7ySZa6cfapSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zyq4c6Ih6TD7RB/TUMGNpeJLBvz42QVX6daXJU1wEl4=;
 b=FPEIqEJJ7wqVXOzYLAnfSvPjr1up14y5tXxD4ntds2n7rRj+g5HqYu/FajeKncqWLLAIblH72HrPiJkXayxA3FBj2LZNnpd/Rq2M8Ta8bltCisCKgKALnk+lUf/LX7sglVecsXPFKsmbnr48ZcfNoVJv4WjQcRerymD7Gf2nVY3jK+yrz4tIGrfcAYgHVZzm+W44tS5+zx0qxrXYMEkb3+Np9rECKImwe8LczNbkSgiZ+X3nGHtMbKM9Jb/Z9ADdFyY6CKULU+LN5vjSVmkFjHFsn57FQ71y6LN74H5GI7oy6//A6r4NNxRLjVVbuf+c0nZoxPifkuA5N2/Jt049qA==
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com (2603:10a6:208:f4::27)
 by GV2PR02MB11420.eurprd02.prod.outlook.com (2603:10a6:150:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 13:27:24 +0000
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf]) by AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 13:27:24 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] Adding a native, opt-in versioning system to Git (distinct
 from tags and branch names)
Thread-Topic: [RFC] Adding a native, opt-in versioning system to Git (distinct
 from tags and branch names)
Thread-Index: AQHcV8S3ldW4ZJAz1Uu0pvK/B7r5trT22/wD
Date: Mon, 17 Nov 2025 13:27:24 +0000
Message-ID:
 <AM0PR02MB4450024F0F7380A5DE6B2006B3C9A@AM0PR02MB4450.eurprd02.prod.outlook.com>
References:
 <AM0PR02MB4450D1D8A6B6BB9B8AEC5BD7B3C9A@AM0PR02MB4450.eurprd02.prod.outlook.com>
In-Reply-To:
 <AM0PR02MB4450D1D8A6B6BB9B8AEC5BD7B3C9A@AM0PR02MB4450.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB4450:EE_|GV2PR02MB11420:EE_
x-ms-office365-filtering-correlation-id: fe379d62-e1d8-4a7b-4724-08de25dd0bb0
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|19110799012|8062599012|8060799015|31061999003|13031999003|461199028|12121999013|15080799012|51005399006|15030799006|3412199025|440099028|40105399003|26104999006|102099032|56899033;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?e0NCrfSA4cgRpKTu3DBnhOsS92cE21k7RvdnxV9UYTGldG5IhEs3C3mc?=
 =?Windows-1252?Q?4H/5cCIGnbjLyBaAw6vIPkAmMsRtFhSVcu+U+8f5+tRbzEUw1jghgDEz?=
 =?Windows-1252?Q?bis/JVOdtXRYp5ZQf/3CIagfycJ4Hf2qIrMyfW2nkU4hPNXC1+a6/ohV?=
 =?Windows-1252?Q?NYv/bYr/WzkkNBL0MRbFF95/5na0A8aeK1JzwoK5ss0RV6Sc7geE754H?=
 =?Windows-1252?Q?xI5thn7GiJr7H9zcO8l20gES6m/1LtTVYBgRKVrNVL9RvTbo24fTfMXR?=
 =?Windows-1252?Q?0L2TQjlEOt2SCc5XV6i6iYe4bx+5pYg72Gv/4UJp4OMW5k6Eeuvl93YW?=
 =?Windows-1252?Q?ZI152nnLAnU9Xf+vv+GWJ/x+bLLNowOpyJHf1oL/yym2whj/h6CiV13X?=
 =?Windows-1252?Q?tzzYWfZr1Tq5cO78gfHexqksjIqXUW+sTUx/M+Wsey9oxj6J+fmdhyvZ?=
 =?Windows-1252?Q?SFdJonf7V65+4okhgUT2Gxso1mHaDrfs1jQZbI4JVWybEI2y8/s2H2fH?=
 =?Windows-1252?Q?whI0WkHLIJSyWipf/4FhsPbPseQjwDWSxwkwfR++ilmbF9pEmaro2q9V?=
 =?Windows-1252?Q?sQhFpSnGysYYNH2+IEQgEzDbNTP2gDmioPi/E53oTXLRZoEGDtwrZcRQ?=
 =?Windows-1252?Q?HR6MjdBRl46BdxDLIJdPQf/hRnkjNbm2q7oHSpPlCMOU0PH+69DzLrI9?=
 =?Windows-1252?Q?iEuM0qSYB52gv4rK5cvSl/imxhM3fLRemHoeGocNYqquJnhdNeZTpHEk?=
 =?Windows-1252?Q?KFroQm6YtvSGVBnjn3LQiMbV9c4uBxg9Pm0Y3TimgN+qTi3FLF6xNmk9?=
 =?Windows-1252?Q?2UghL7K30WY8k4H+9crdlY63FUTK/qR9RdD6zPJrW5wOVyTMMsSkUcKd?=
 =?Windows-1252?Q?8T6z3SVIDyD1PHcxR2+GcJiC4DSMc1AUrFiyyjrHNyCMkxAvlHWIP8k3?=
 =?Windows-1252?Q?AhHu+EfSyN6UElLeXzkQ4kqupfe4001xW3KNV5oelZw9Lk9lySaCtvFQ?=
 =?Windows-1252?Q?uwZynNU8w8hoBSlwRuwmgr1PXgOV2tLXvYnZt//Wm1E2EZxBJ52MwKAz?=
 =?Windows-1252?Q?gWPLM1tX0y/anwiL4i42/t5gmpSCzzNuREDR9zVz+hoaItqykI06mi18?=
 =?Windows-1252?Q?xL0cG3GbwB2e9GIMXrWSQT5eotof66zFMIxMbKBpYfWpbzFJuFum7e16?=
 =?Windows-1252?Q?sOzc0FfRVMJL/DsF2+rBcPXb5NUE7y1ekPVX2gUG2G8Uk6ptgv9H4h2H?=
 =?Windows-1252?Q?682m16zC/hzHLG5Gxj2YkkpEZySmFjsi1mbmZi7xK+w/HQo9jwqonK0X?=
 =?Windows-1252?Q?n0orVoyS9GOIVxvY9LGDs+zRWhPLG5CcSj7dtdnUxxgh3uilgAETLcv8?=
 =?Windows-1252?Q?swkYfC74RuDXl+OTtIVixGgosRv/o0kqqsv2Q6rq83mkTgExZWnUVMXY?=
 =?Windows-1252?Q?s37zDYuIasBZDIqfcKBdrw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?Vu1bqPvG0pDphPPcI9rnALfmfX3kw/MAuoBTqXTO3BVjWMAHtrHNA0fj?=
 =?Windows-1252?Q?rlTBJa2zGGPhunh01pI5XnEefTyexNMTXqODLGGcTP6K071Mzreh0Vp8?=
 =?Windows-1252?Q?i/jxsEdwEpjU6E870x4HSaiphYOYH8ABHxIkd91mZB4NeYWvnyQ9z9oY?=
 =?Windows-1252?Q?JuTh+NbMWkawsse0RRT+dsuqBK5sQmfqlDxpd/do0Cuk4dLPwkbP8HUN?=
 =?Windows-1252?Q?GbjB+7gcq+YJLw9MAIaTdyfJASr+F1dQj8Qez+U10HnUu1SVrotJgxhu?=
 =?Windows-1252?Q?7o3hPDzHStaawg5T8OVNTMFojuTJ1Fw1lhdoAP1dOKqvXkJ4R9TKo2fd?=
 =?Windows-1252?Q?sk2WBn6nyRRch6HfIH/gIrt8cTD+zkOXIA1PZxHnYxryMIOTVB+AaP5f?=
 =?Windows-1252?Q?Bprewqy/71jVR44XVkypgY+p1uD3gHfSfXd9KBv405kqOuKUK5dcRDZC?=
 =?Windows-1252?Q?6vbIPCkhrH5og83prKWaXKeBSBAh+TGVdY+bkidboHw0P4SJI7gFF0eK?=
 =?Windows-1252?Q?ITceYLZJfP4hXCGpIHFjQakTUmZcdDXwXkj+2ODsZiP48u76k0XX+vxW?=
 =?Windows-1252?Q?KF6h5nUDkE0gFJdr61VG3A4Ed3mgJKNLlSNB/AcnojEnoLFvq+PoCJsS?=
 =?Windows-1252?Q?D81ro57lPwlLesONgkgQo8D6uezSNOAYDtOR1EncY0z4sbvb/GXGu10+?=
 =?Windows-1252?Q?JGDnkXQ51q/hZe8NIjRPBbC3YVwYvWvOXOCTMd8tTuaIMK7XvwjpIWJs?=
 =?Windows-1252?Q?suchiudUMB9mBP1pbtpfXJZJJb/21vgzxo95kqHTOfGMXawCNkZ3No6f?=
 =?Windows-1252?Q?5780YULSYEbFds4w1tpnlCPNAudf7lOUpXiz6nn8Z3qV17cXUpFL/O9c?=
 =?Windows-1252?Q?48FX0wp5/wA9xV5WoVbhmM4YZq1gpCXBC9Lwcah2Yyse0FbnWC4Ee3NC?=
 =?Windows-1252?Q?WB5moMfPYHvAAnw3BV9fP/innCTPDJJWzL/27ocLnpvmr2dy3UJyElQ8?=
 =?Windows-1252?Q?EHBE5MVwLCwWMVr2qaYOl8ZuHj32nyOiwsp/GqCa0FYtgDG6jv1WWMq3?=
 =?Windows-1252?Q?pJQZc27COtZ4ISlKr4HvCzzpvrMkwAjJoQ1gVt1bBmy0Se8B22iNkmCM?=
 =?Windows-1252?Q?DtrbeJK+KetHA9MNpgX8+4WjiPFZDuXdRWDlNv+USRf8wOIf7umXyxb0?=
 =?Windows-1252?Q?IgDbljLiAJD00Oiz6RW7JyX7fPk9I3t9FGVuUIkHTy4/VFmtNV7E20QI?=
 =?Windows-1252?Q?OE2dw14S+lBrBgT6O1lopWs9TXsgG+QGKio0UJYAIT2LXnWFYCewPvhq?=
 =?Windows-1252?Q?Bl0a9LwZ8SuZFWY46/WjJtLcTgaKgDD9pzo9t9kFYz+mK4gMdnGi/a98?=
 =?Windows-1252?Q?lRUnUne9rHJmEodPTvM65kZ4RcNVi2EyARE=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8534-20-msonline-outlook-5faa0.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4450.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: fe379d62-e1d8-4a7b-4724-08de25dd0bb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 13:27:24.7040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB11420

Further ideas/enhancements:=0A=
=0A=
Subject: [RFC] Extending Git: Native Versioning, Enhanced Accountability, a=
nd Repository Health Primitives=0A=
=0A=
Dear Git developers and contributors,=0A=
=0A=
This proposal extends the concept of a first-class, opt-in versioning mecha=
nism=A0(as previously discussed) to address two related architectural conce=
rns frequently raised by larger development teams and security-conscious en=
vironments: Accountability=A0and Repository Redundancy.=0A=
________________________________________=0A=
1. Core Feature: Native Versioning (Recap & Enhancement)=0A=
Git is a content-addressable history tracker, but it lacks a standardized, =
machine-readable version primitive independent of tags and SHA-1 hashes.=0A=
Proposed Feature:=0A=
Introduce an opt-in versioning subsystem=A0that allows every commit to carr=
y an explicit version identifier. This version should be treated as mutable=
 metadata=A0that survives operations like rebase unless explicitly changed.=
=0A=
Enhanced Version Structure (Addressing Accountability):=0A=
To maximize clarity, auditing, and trust, especially in projects with many =
contributors or automated commits (AI/bots), the versioning format should e=
xplicitly support encoding the commit author or base ref. This moves beyond=
 basic SemVer to the more information-rich structure discussed in Text 1:=
=0A=
$$\text{Version Identifier} \approx \langle \text{Base Version}\rangle \tex=
t{-} \langle \text{Author/Branch Identifier}\rangle \text{-} \langle \text{=
Sub-Version}\rangle$$=0A=
Example format (custom): 0.0004-SKYBUCK-MASTER-0.001-SUB-FEATURE=0A=
Rationale:=A0Provides instant clarity on the lineage and authorship of the =
base commit, which is crucial for auditing and accountability=97addressing =
the security concerns around dependencies and supply-chain attacks.=0A=
Storage Direction:=0A=
Continue exploring adding a Version:=A0header to the commit object, allowin=
g the version to travel with the commit object itself.=0A=
________________________________________=0A=
2. Feature: Repository Redundancy and Health=0A=
Git's current design relies on local copies for redundancy. A single-bit er=
ror in a repository's object database (for a clone that is not regularly re=
-fetched) can render the local copy unusable, requiring manual re-cloning o=
r repair.=0A=
Proposed Feature:=0A=
Introduce a primitive mechanism for internal repository health and redundan=
cy tracking. This would focus on protecting the Git repository structure it=
self, not just the checked-out source code (which worktrees address).=0A=
Initial Idea (Addressing Redundancy):=0A=
Repo Pointer/Reference:=A0Introduce an optional, well-known, trackable refe=
rence (e.g., refs/repo/latest) that points to a verified, redundant copy=A0=
of the repository (or the most recent successful backup/mirror).=0A=
Self-Verification Command:=A0A new command, git verify-integrity --redundan=
cy, could check the integrity of the current=A0repo and compare it against =
the health status of the repo referenced by the pointer.=0A=
Rationale:=A0This would standardize the process of managing redundant repos=
itory copies, making recovery from corruption easier and more automated tha=
n relying on manual, ad-hoc copying.=0A=
________________________________________=0A=
3. Feature: Improved Branch Visualization Metadata=0A=
While external tools handle visualization, Git's structure can be enhanced =
to support a clearer timeline view, addressing the issue where history is h=
ard to follow, and commits can appear non-chronologically.=0A=
Proposed Metadata Enhancement:=0A=
If the native versioning system is adopted, visualization tools should prio=
ritize the sequential version number=A0as the primary ordering key, falling=
 back to chronological commit date only when versions are identical. This w=
ould help counteract the common visualization problem where older commits c=
an appear above newer ones due to branch/merge complexity, allowing users t=
o "Respect the flow of time"=A0as defined by the deliberate version progres=
sion.=0A=
________________________________________=0A=
Conclusion=0A=
This expanded proposal seeks to enhance Git's capabilities by standardizing=
 versioning (using an accountability-focused structure) and introducing pri=
mitives for redundancy checking, leveraging the new version data to also im=
prove visualization. The features remain completely opt-in=A0and do not aff=
ect existing workflows.=0A=
=0A=
Best regards,=0A=
Skybuck Flying=0A=
November 17, 2025=
