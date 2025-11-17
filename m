Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011075.outbound.protection.outlook.com [52.103.32.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135C3314A1
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763385601; cv=fail; b=s02es5ZPpodLzPRbjLIuJljl+zv0+vpfEdU16zSdtnscSCvRYXsahgDDpANkJlXKDJaAZ5s5zgEFIR+evKYz+zIqwpZZodJTfvptdLF7CB+dT/RVfgwx1nE/z2OGIBFV2UBd+BW3+bqp+FznE+Ok6QwAtIld9EfOmca6St6qoiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763385601; c=relaxed/simple;
	bh=PoVQvey2IGxesEsF6CJtM6idMIdajiabSKIGw/y7Wqw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=am66gSgyw5M/LyDrdAF3o8JxSKGrFsxcIxUtQHrCN1Hv8WJJwVENui6iFRxpyOvwkeUenMq+d5MWzI/Kybh7VNdvj6JFyw5Hu4hCIVYFgt7gLkgak3fiWEK7UlKx4D19TtCHTq+xOuI+CI0s7NzzFxQt6XD63Iy5S8fGOTB4GBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=ioZ9Oj8Q; arc=fail smtp.client-ip=52.103.32.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="ioZ9Oj8Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abPYiMdt3/3DUu1pQHXnxplHFtbO0yFOHOHQrLww1AtN4wFzU9Pu628IjWp8PF9q7hb2a+StnWmWVFt5IQ1R/SSR94xMdu7svuG2TUX3ZfKT8lUytEIIpxcFnBYUc8/jrfwnlHvMDPfbXNko+0eg9jtqJX8B+h8o892ppIf+HZvpgfOnTHoCTa+fLJdgY+X2TpEO2xSzli9BlBDIpipibCeA/kcjPec01eVQXBPI563bEP4+Kx+blfvZUhiQa8neXFqeMTePm71C2EKLDj21046HInbRmBKmN8OgEWC3uSAV3ahusvbe8HrUSkc/hUtX6x4E/J8g6/gXc/6Jdp7WwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoVQvey2IGxesEsF6CJtM6idMIdajiabSKIGw/y7Wqw=;
 b=WSJpzdhf00MtSvsQhlivys34Gm6kYSORS2ZcFcjWwfUAli78rhiUCxh3k+BIMhFQHKrkXICvZjGRyxFrecSegjSAvEiKGINGWerQWcPDtYsdgkstYMqTGYVE9sxzYydfmua9v9343qpX2MowxAoxvkCUjUsbpIxHBZGyd16JsxP2hE6w3mO6J9noHMWssin2Sb2M0w0U4DXBPNo7/N0w3OCN2RNa3oA7kUl9mz1SvewMcbtVGriAGWzSItyCekC2JTUP175EaGjaLbMfLePdmozqwPqV2IwfrQjCJRK4ap6Nl+J6o3vjnROvtP7ZmXTnbhkSzrIgs8kcLb4m2TlUXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoVQvey2IGxesEsF6CJtM6idMIdajiabSKIGw/y7Wqw=;
 b=ioZ9Oj8QQZY8b7JEMDpIbXwJTdAarm1oktRqNLKoyjZVbP2RSndS57RfOP76yyCXbMjO4GzJyTwSn8CID2ErLfWfr9bP/8Fkf64tQWvpZfpn7QO1RjHpc/EFWO4rGhWx3TXocCOXlj55q6x6ZCIRBOCX4UKZRCLUFuvZ7TyljkNVNQeqTzhHzCXxcusMhPyNFZ5whn4eqi8JnyPhd45+ZL0FuI236+3YgluQJi7zqZ4bsJrNBck0031kBTuOhE6wPjqRb+/G4845n6iT6madx2BDzTy1/zB2mcSXeHnr5y4gCTXYmwbLMdGWzrQx1X7+6kuZe2/4eGGZOchrFJpUTQ==
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com (2603:10a6:208:f4::27)
 by VI1PR02MB6029.eurprd02.prod.outlook.com (2603:10a6:800:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Mon, 17 Nov
 2025 13:19:55 +0000
Received: from AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf]) by AM0PR02MB4450.eurprd02.prod.outlook.com
 ([fe80::3b82:1ad3:b24a:7baf%5]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 13:19:55 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [RFC] Adding a native, opt-in versioning system to Git (distinct from
 tags and branch names)
Thread-Topic: [RFC] Adding a native, opt-in versioning system to Git (distinct
 from tags and branch names)
Thread-Index: AQHcV8S3ldW4ZJAz1Uu0pvK/B7r5tg==
Date: Mon, 17 Nov 2025 13:19:55 +0000
Message-ID:
 <AM0PR02MB4450D1D8A6B6BB9B8AEC5BD7B3C9A@AM0PR02MB4450.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR02MB4450:EE_|VI1PR02MB6029:EE_
x-ms-office365-filtering-correlation-id: 10e558af-9701-4f40-ad47-08de25dc0003
x-ms-exchange-slblob-mailprops:
 /OoUGmN/RpVAjouTXUgUPX+o0ch3BuGwUu9XiSwsBpB1ItTykJwgDbjX6m3LTUYEF2G6SepCoo6BJIwyMMFWLVW3UPXaQpoo9YapBzN2majo9bN2SXLpUH6FTTw0SOrudXXm8kYqv8ZB4P7hUPsY87QEIhZDTjKPxVgrieWqGreGYlVUBi6Q6X3BK57S7pqyd6gZjuoegpxmNwqyOvU+7DuE9cJ4WptRrhPY1nnRZ/Pn1qOW4jr3xKnWUBx9YBjBZFO+F+cZLQsz8hWBcncxrK2mWg6cNrpO+iyIQbDD1GEcelfdWFXwbMUzrMv+8Mnl1BfyU8QCMrpPyMxbt5BqYHRUq6Eau0tTP/buNdAlBUD2kPnPGT24rARNheG95JZwkfZeOuI9pHnGak1xy4q5Pcx2uHgTXwoLMTRZzItZOwm/HfDRCekPrIkq2QkzOUElRfaPQTFnhx1fXTgemboRgSqfUGdTz1aMFZ8ZMWqRIxDQjhxmsom32oOvmThGjX/SxQoAD4Zvng5QNOZOiyTVIR+WcV7TQWmTIn2eLa2xAz9SGKzaEUCdGlynqna0m3A5C/cTyCu7FetxobexfyOWmFIirvHAXi1i6BTf7odnbaokgXJXVUdteZMSqHbBbcentQ1lXmvji7AAHLBFQIywh1g7wsv3cDVyeJN0nRI1x3FoTedI1etl/a4mDOQM23A32oX0utD+G8TC4bFjGh2yHxrb70zEf1h7tfMCARLluvXArEpQfEzbtBMkfL5/V5i+
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|15030799006|15080799012|461199028|51005399006|12121999013|8062599012|8060799015|19110799012|102099032|40105399003|3412199025|440099028|12091999003|26104999006;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?cNsCohSPiNgiszDRqx9mUaYGoqQ5a4ytXMHlY/dYR0BXvJJqsbyFH+Du?=
 =?Windows-1252?Q?yM94YbPrp/qxbz16U0dcnpikmw080ORkorCAiOOXs6PIhKrNf4ynx/y4?=
 =?Windows-1252?Q?Ui2oHxH3nIn957LxfgBN5MUCFDDlGBa/AZsK1pRf8A6YGkQVg2uMy5GO?=
 =?Windows-1252?Q?gWB8H9Qn+9IkBW1c1CbUSahGqcIvkI12HMU1Fj0E/C2w24ZhKTs9K5bC?=
 =?Windows-1252?Q?r9GGxSdm9M61VnVMMaatNiDMCOpq48lzUt8mByfbxc2TKVSiOvUFqrku?=
 =?Windows-1252?Q?CEgLCUxxcTIna5oI60KNHm/PWs4Z/vVHK5sNRd3Lhbgy7r8tQvyLJchb?=
 =?Windows-1252?Q?ao1GTlLu7RfgjfAPjxH6BwMu8vk9WRwNHV0jKnz9B51EmigqhWN0d4gF?=
 =?Windows-1252?Q?0oxIQZcEERTE5kWO/tCsX829dvXZDsHxMLWNbXkXMFbQTO0zIhYGzNLr?=
 =?Windows-1252?Q?jv7eSefyMraMNHLFZH3aMu5/ltBNJZn8mMPxeKD+AnybGguC/05IEXS1?=
 =?Windows-1252?Q?+hYvSRLvMWpyQIFWzU9TuYzEPzisILodATMmFZd04yICIEP8Vapboiw0?=
 =?Windows-1252?Q?hKlz7bD1N1+V0IULt/p7/z3vnAwlKYMWO2EgJ0bKJEg5N9n7GZgNnIXq?=
 =?Windows-1252?Q?ivUwAOAPQaJwoXNTaqGzqjP5x7tczrKalC+DJxVXFxlhh+dIrCI4FjJ2?=
 =?Windows-1252?Q?CUNYTaQ0piHUoc49sST+QjXMzBbFBO6Q7kWSh1qn9KmdSCaJmNMZxe52?=
 =?Windows-1252?Q?d54TKu0oaHC8TbuTsv56Ucce9gbSkpifoPLRf6cPWJ+fV9FQls6HTSPW?=
 =?Windows-1252?Q?swkBkUZrRolA4AyzOxPvr0Gi0peGHH6NzW5ImUdA7DQdKHWLdgzlnhKJ?=
 =?Windows-1252?Q?xASDIZWSMwtSMuuVnweRWsjbx2eH9+DRA6aLE9IhbBw+pFMn42q2dsTP?=
 =?Windows-1252?Q?qJcLUS92UUEqGLTYgJBT/VXazBwGScX/QXDol7hcU/bAlarHiKz3zD4E?=
 =?Windows-1252?Q?1fgD1Eu3KzAfwpQIeQIwAPMRqvzK9m/o8oXXZS9Kmga1j5JLTKrUoN5l?=
 =?Windows-1252?Q?z+P8edbd5j8Hh5N1ucGSJfc0lhS0OMJcnMlGQ6mlrtVmQwN/9gt83vXQ?=
 =?Windows-1252?Q?ap6ajU+Z5Ql6I/viG5R/sYKS2zXOwLm/GCCtQOhRzESAr2XAHZ/ogOYr?=
 =?Windows-1252?Q?wA+wyT9mSW+4M4uT1bwn5V4dQKoYUnEVBIarRYOyyh5vi7I5mENBYeN3?=
 =?Windows-1252?Q?oXO9cW20s5GnJ5rhORF1SfU0LLsM02nROgJp+pz2UdCxomW9GrEJcwOD?=
 =?Windows-1252?Q?hImXGJNdBXSii1AN/2S0pw2p6xyky9zhHOQjLMMRCb21FKlmMLgnaU50?=
 =?Windows-1252?Q?L4mWCpCVLcOEE48+UyU4mieln0puWGHbPt5qnEQdtSQ5kx5j/VrkBNRh?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?iU6uAdpYg3TsWf9CuHTOn+bTOXAvEkP0rMt10nL48sLUXilmvykv0dZj?=
 =?Windows-1252?Q?8Od9CwqXNevgntjm8AMVBqMakznAcg+DIQ0orAgV6psS7exWT7lEcJcd?=
 =?Windows-1252?Q?Twp1ezMI8gcG6CBSZ30GzoG31g717MkUD765cTpWIzETlL+wF0qFNE7N?=
 =?Windows-1252?Q?hOkb/TlbjglEad3HvAyHZFsVsd7tyJWZ9m4ZMsfHDEibfL7NTpzRFAqW?=
 =?Windows-1252?Q?uTjYcdSk8py8uRYcSiThtsNMzW+37+I8EByWATBPXRVHNMJQLi1whDQm?=
 =?Windows-1252?Q?nrhlNDAjtehpjHkmkFbIw03B1luB9o2FQzWd/gLzQ5UIll8mwQkQFoiM?=
 =?Windows-1252?Q?YhwvUfWh+n33Bq/JA7tJ0db7n2BpGUm8fE3ZO3QS9dXOYwqrbLclLrmR?=
 =?Windows-1252?Q?EZNLT4yzFaDRc08J0NmWL2q9mqCVX39tTFC/MkgupMs1VM4773BWamhd?=
 =?Windows-1252?Q?6Pnzp2YFMwci2C9ajUT992eWy3ZXBmL08ElHkSApGQFdQk84Ooq+bxc/?=
 =?Windows-1252?Q?hpWsZo9T4INxsCAOPt461vCFMnh5Os3G1tdV6qz3/kS2JYCZ32Ag+KU/?=
 =?Windows-1252?Q?Xmp/TaQ8zhRXQxMfszYesHPr3RiKqEzXcwjQj2T2awWsISbpRVnBepRF?=
 =?Windows-1252?Q?0V4ec2cSYy4jIkNbOdIBKKN0lHug7N8+ObduG8dv4lFN+18AVcRHIX0Y?=
 =?Windows-1252?Q?bev/2dBiVrjnUTGg4QzbelN/qDAzwe+gQexMO4vMZo81AxBtoTqr0Ge0?=
 =?Windows-1252?Q?gY/gz574/L9us8aU1PHoLRwCL2g0GFARWSaxlO8HXCwvPJA39XDKIbZi?=
 =?Windows-1252?Q?jUZ91BTwRVIgNay5e+TYGX8buNRiPXyRdkf6m1lAduwQUmhs014ZEJnW?=
 =?Windows-1252?Q?NuqDNG+Ctg0RNIO8ZfNOsJbfphflfRlXm1PwTd4PPIjmRz5BBXoWqm4e?=
 =?Windows-1252?Q?scIwoaOMX/JNl6WqsDhkqv2nPHmPpGEVwzHD0/qAPHfJ5naazgdE2/Qx?=
 =?Windows-1252?Q?IR7bbr2nAx4+MjuWbapneryM4n/l/rf1b6tmWTdWy+gVRATi3+ITqNGr?=
 =?Windows-1252?Q?9tFiVKPOuLxyEkChOe/NCrKFvy5JHsvdYMMUVtMQoI3Ch8iCYp5q0OXk?=
 =?Windows-1252?Q?n/5hrs9d9QSRj0uQLm50X8ZRjBhA06hhlspFxQtMVr11MnYy4ryHeJIx?=
 =?Windows-1252?Q?j2cIMAcUvfep1NsJ3HYtEbajeKpw0GmeT7yLfWuVGASDykJONQy3f20m?=
 =?Windows-1252?Q?9AD4/uKQ/NkYZ2RMTcyEXpyeqsk/26dTZWc+PJcaClDCS9nmBb7VAi3q?=
 =?Windows-1252?Q?bM9Sa4HayVQUfYXBNQbKzG5NZIFr5iEel3pXGdd5EvJ+sQvXp4YKLrQp?=
 =?Windows-1252?Q?H9Ipfxi62ubWGYC6hDjHgWJWpSAbE0tJArg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e558af-9701-4f40-ad47-08de25dc0003
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2025 13:19:55.5985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6029

**Subject: [RFC] Adding a native, opt-in versioning system to Git (distinct=
 from tags and branch names)**=0A=
=0A=
Dear Git developers and contributors,=0A=
=0A=
I=92d like to start a focused discussion about whether Git could benefit fr=
om a first-class, **opt-in** versioning mechanism that is separate from the=
 current tagging system and from human-readable branch names.=0A=
=0A=
### Core observation=0A=
Git is an extremely powerful content-addressable history tracker, but it de=
liberately does not provide built-in semantic or numeric versioning of comm=
its or branches. Projects therefore reinvent versioning in many different w=
ays (tags + git-describe, VERSION files, external tools, custom branch nami=
ng conventions, etc.). While these solutions work, they remain conventions =
rather than enforceable, machine-readable primitives.=0A=
=0A=
### Proposed feature (high-level)=0A=
Introduce an optional versioning subsystem that can be enabled per-reposito=
ry (default: disabled) with configuration such as:=0A=
=0A=
```ini=0A=
[version]=0A=
=A0 =A0 enabled =3D false|true=0A=
=A0 =A0 format =A0=3D decimal|semver|custom =A0 ; e.g. 1.234 or 2025.11.17 =
or free-form=0A=
=A0 =A0 auto-increment =3D none|patch|minor|master-only=0A=
```=0A=
=0A=
When enabled, every new commit could carry an explicit, mutable version ide=
ntifier that is **independent** of:=0A=
=0A=
- the commit SHA-1 =A0=0A=
- lightweight or annotated tags =A0=0A=
- branch names =A0=0A=
=0A=
Possible technical directions (open for discussion):=0A=
=0A=
1. Store the version in an extra header in the commit object =A0=0A=
=A0 =A0(`Version: 1.042`) =96 simple, visible in `git cat-file commit`, tra=
vels with the commit when pushed/pulled.=0A=
=0A=
2. Maintain a dedicated ref namespace (`refs/version/HEAD` or `refs/version=
/<branch>`) that is updated automatically or via explicit commands.=0A=
=0A=
3. A separate =93version object=94 type linked from the commit.=0A=
=0A=
New porcelain commands (all no-ops when the feature is disabled):=0A=
=0A=
```sh=0A=
git version =A0 =A0 =A0 =A0 =A0 =A0# show version of current commit, or =93=
unversioned=94=0A=
git version bump [major|minor|patch|decimal] =A0 # create new commit with i=
ncremented version=0A=
git version set <v> =A0 =A0# explicitly set a version on a new commit=0A=
```=0A=
=0A=
### Desired properties=0A=
- Completely optional and disabled by default =96 existing repositories and=
 workflows are unaffected. =A0=0A=
- Orthogonal to tags (a commit can have both a tag v2.3.1 and an explicit v=
ersion 2025.11.17). =A0=0A=
- Survives rebase, cherry-pick, amend, etc., unless explicitly changed. =A0=
=0A=
- Can be ignored by tools that do not understand it. =A0=0A=
- Allows projects to have a single source of truth for =93what version am I=
 looking at right now?=94 without parsing tags or running git-describe.=0A=
=0A=
### Potential benefits=0A=
- Standardised, scriptable way to obtain the current version in builds, CI,=
 packaging tools. =A0=0A=
- Easier generation of reproducible build artefacts and release notes. =A0=
=0A=
- Possibility to enforce version ordering or policies via hooks if desired.=
 =A0=0A=
- Reduces the need for complex branch-naming conventions that try to encode=
 version/author information.=0A=
=0A=
### Questions for the list=0A=
1. Is there interest in adding such a native (but opt-in) versioning facili=
ty to Git core, or is the current ecosystem of tags + external tools consid=
ered sufficient? =A0=0A=
2. If there is interest, which storage approach would be least disruptive a=
nd most future-proof? =A0=0A=
3. Should automatic incrementing (e.g. =93bump patch level on every commit =
to main=94) be part of core, or left to porcelain / hooks? =A0=0A=
4. Are there strong objections (technical, philosophical, or maintenance-bu=
rden) to adding any form of mutable version metadata to commits?=0A=
=0A=
This is deliberately an early RFC =96 no patch series yet =96 because the d=
esign space is large and community feedback will heavily influence whether =
this is worth pursuing.=0A=
=0A=
Thank you for your time and thoughts.=0A=
=0A=
Best regards, =A0=0A=
Skybuck Flying =A0=0A=
(The Netherlands) =A0=0A=
November 17, 2025=
