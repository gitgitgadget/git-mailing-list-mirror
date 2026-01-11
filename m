Received: from mail01.iavtech.net (mail01.iavtech.net [185.225.140.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A421DF248
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.225.140.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768151146; cv=fail; b=OKBykEE0YBR5keq1WC1nSeRsvbpniCVnc81BsGp45H3uGMyDzEblDQui2N3Gv5/RJEZ0wTf4xB3zGbHUaJkSv3MgoFTmoWF2QrnScILbeUSXOAapWYAeA9kFUTQjstcWeHNwph60k0m582fTlgz7VQTwJ9WrF/T7Fooeh7XiiTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768151146; c=relaxed/simple;
	bh=Nxz9j1FM30khyw9NirMAHgrcDcybKcJrDRPq0cCkjYA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bEckrbxmJRdUjMZDPiPwJFVJTL/HPNeWiAnBUfyavNvQ14PgPwirFj+V6W7aoEvJrlK6rs/4LPW7JrFMkobnXx1httXzbcrCabdrnSq2zGRn06I2cR7i9XP+9sYdK/CsjZ4bqidurKhCf6QHvfzcJPlUOFLmY+YQmeTt+ZKzHHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iav.de; spf=pass smtp.mailfrom=iav.de; dkim=pass (2048-bit key) header.d=iav.de header.i=@iav.de header.b=INkou4fJ; arc=fail smtp.client-ip=185.225.140.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iav.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iav.de header.i=@iav.de header.b="INkou4fJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrqKOqJM1izOj8FfVAQZV/7dEp7e1aOpLFYmlGLKoPZoaw2qfRuwikxQoTwvzToCHjzoOER7fcxUAK4UmqFe+OOtoi+4g+7qdvgyJ0vxc35Jaer+GueW9yXGHhvDUsPOEhVZgy+mE7wRG9l21g3yneLscW4/It5zpnDI5V9PQ95ovHelUPWL2WhzAnNi9Dxnd9uUkPHlEAS4j0E0RKL0rZZP3LQty5I/88ikOjtaPgDUua3dF2fzzouxpNbI6D2DQ628NVOZlmBqEq+18RU0rCqGzHkDvhEiWyp+Ky5AYqiVAQwIxH3n0RWYI5U02t0N0FJSmI78an0riLDuVTnPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHIT5FW8tVMNk914qYFRgy5fzHIP7QMUl98eCjAPzH0=;
 b=M/oGz+qoBW1ft+p8+tQNj5i0vmIJjdVGPzwRmajnfvo+5jkT/TaqS6NPcMcS702G5XgFD3r8FAHy21VASttZabBJWfBepTh7xuL9Aj/h6ntL32Jxb/1oMmodyKaHik+J/dVcO9Sa8S8jlnqsh9JYnYM0yROG83U3AwoAlOIzxptfCIurKJ3ptocpYV0+7d8I7EwwRZmuRZvOjJ4xVxIVMRqWr5iCtvMlE08K8eqWJOEEJrbtn8foLnbV9jp7nHNtFYTcrvWKsA54OsRWQ9XFog01tMOjr1hV4UTLcd43ypdPgxPWW0QXN3EtMHFHgjx3NulXOeVJ/cujuLqRgLQr2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iav.de; dmarc=pass action=none header.from=iav.de; dkim=pass
 header.d=iav.de; arc=none
From: "do Carmo Lucas, Dr. Amilcar (T-PSC)" <amilcar.do.carmo.lucas@iav.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bugreport
Thread-Topic: Bugreport
Thread-Index: AdyBcJFkgtGdqVkKSsSYu6R/zT2G8gBq8lUA
Date: Sun, 11 Jan 2026 17:05:33 +0000
Message-ID: <AMDPR08MB114092D81FA58009E840692ABED80A@AMDPR08MB11409.eurprd08.prod.outlook.com>
References: <AMDPR08MB11409C5DC2EA9B3D8C71FC12BED82A@AMDPR08MB11409.eurprd08.prod.outlook.com>
In-Reply-To: <AMDPR08MB11409C5DC2EA9B3D8C71FC12BED82A@AMDPR08MB11409.eurprd08.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iav.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMDPR08MB11409:EE_|DB4PR08MB9216:EE_
x-ms-office365-filtering-correlation-id: da22c89c-4576-4c44-2ea6-08de5133a1ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|7142099003|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?V6Ogku747s2v3meb80CHcA2u26/LVDcOgpJjpTVNxUSQcS+A6t7WykOYrU?=
 =?iso-8859-1?Q?6UcTSqzX5YHYMYRpIABCGQyVI7saFbFEinfEqKcTMA06eOZhg4JGyS40VX?=
 =?iso-8859-1?Q?8k6K5Jrlq154Ynq3vsviqx/x/jltMPy2DTbutRXOt3ObY90zAXzowym1Xj?=
 =?iso-8859-1?Q?egXs1YaXYJW+iIWuiOC4mAn1IGCs/HleqLB0w/Xib6hNZoaLiyDEDK7Xou?=
 =?iso-8859-1?Q?YiSGZw17U6V/eLbsBWkKzvY8/n0N682RE7MPK8npojfEEzbGWj+updQaQ/?=
 =?iso-8859-1?Q?T+7CHvZadX8O/oKNUmpE2D48Uc3JRcMcDUNx740+7dYADRyupodC3T4m/S?=
 =?iso-8859-1?Q?O0ayDrt/cTq4gvmAIYzC5wQle68p06LXIhNjh9/qOD5hlDcbKeX42Nb0wv?=
 =?iso-8859-1?Q?gARTHJiL+tG3Jo3+Hs6CucjQZRPPrVUss8r5qsUlh8uzXiUCJiyUl368Wm?=
 =?iso-8859-1?Q?xrpPkU+6VkXzKjUq7Q8jXncACf5q4ueadZ4LD9rRjBfyxgqgJYHoH99unf?=
 =?iso-8859-1?Q?oCovOqN3Q+Wuyg8RfI5PplG+Kplrbm7n4BujkMV2azXOm3mk5pUYpJjFuf?=
 =?iso-8859-1?Q?FaoGrHqXdeq74S6xS6Fxmi9KFgyy6O4iqmQqSlOEHoHwLzT20LHbfpZ4t9?=
 =?iso-8859-1?Q?7MRpi3a1/uq6kUH6DYGpiFa7LqRWa41zxdpcqIfixWVqwMaUSEq52fX9h4?=
 =?iso-8859-1?Q?iH7qIDTccmaFMDvBYBepbkdWSCSmd/jL7diFxki8WlSj2IeSMfCeuW4586?=
 =?iso-8859-1?Q?ld4PDA8zPRPAo4keerZzXY0puH8nQaUrd2THCDIjqqVTkJagF3PLe450b7?=
 =?iso-8859-1?Q?yVYOZLde/2bxjbTy7IrDB/huYtsi0soeLucJwkeHoW8QMu8a8arGnZahTu?=
 =?iso-8859-1?Q?C+syeYaDQVWyU/leVUen/6krwqgGeWC96kUkW2HrubZNxHy1KlNKSjiIdk?=
 =?iso-8859-1?Q?f2u3NEcbZD2SLmn2SOtTznjYD7qG6zfku+AjFL2jlABZtC4Fe9OrRRh4ax?=
 =?iso-8859-1?Q?37JkRciuaN8PDFcvnouQLVjwXEnccCQA4N9G+WZrtv1Q0dfRQyCpz7qnuw?=
 =?iso-8859-1?Q?H9mhpXzRt0Sxep0PQ40jumlW8tBv1RuqFfYZR1eQE6xXrKXW2QZ5StSwik?=
 =?iso-8859-1?Q?6To1q8aTpFc80IXIfNtVeeNncsM2ujT35/cNcC7XV0gOTcpQgnyY/IOG9h?=
 =?iso-8859-1?Q?Ye6LP5Ry1aKbYMHeIruUObMSyHGY7Yk/uzobzFTh78UQWfiIJ9qTw7h689?=
 =?iso-8859-1?Q?c1OL9xzATX4vhoQGMIsVsgTfCuHk2Ca6zcMhiqSXVGfZfp5yw6FxWJrdM0?=
 =?iso-8859-1?Q?xU2Kjxj0agxVJ+WVuiEg+BaFzW9Du7CX7auy0lKoTpXwHkMMLad3cqwLAw?=
 =?iso-8859-1?Q?+rd6Sl2nqfX0J9rrsxbDTBfVVraXTnX4xjMKJwYKtQ77ZLsllf5359vLNY?=
 =?iso-8859-1?Q?sEjxCzfANDYz0NU61mDywsT4uYnK3i4NGmyqc5J7sw3GmNagmDnu687dvH?=
 =?iso-8859-1?Q?cJhg01urCQKJIuFtJlSBC+AmqTDOD7/KUpOip1i4JinpQUBHB4TAOzK2pZ?=
 =?iso-8859-1?Q?RQAuQlRvINBmFW8UpYttSPRXWoGb?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMDPR08MB11409.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(7142099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MnbOYMceRpI4F2MzA5Xa3cy1t+3a4Oa/1Hif0eZv1izNCBtga0d8xyO6Ff?=
 =?iso-8859-1?Q?CGHGvSM0HG1tXYv5NvPmquhNnEamMZCCgWHdTAgBceuZuVMtbC/4fBMM4i?=
 =?iso-8859-1?Q?ir4mzzUHvUas6d+grUXtfazv63nY3GGbaSeDxAW4Yzj7MmaB1pUgCtjxN5?=
 =?iso-8859-1?Q?f3JOaGMxN5/8ESvmwo1mkDnGWEqQ4032QT+ZuD6+igjpA0JU03QHU5yOe7?=
 =?iso-8859-1?Q?Hu1qNfEiYn7jwPKoAut4nbOW14Ov+1lfzQgMiScWRmQzSHT74OCjxuw2Qo?=
 =?iso-8859-1?Q?Wy9mriHjMylq8r0X1EKdQgcu8RR/7maChW/33HRtyAJmLvSI/VuDEFdEw4?=
 =?iso-8859-1?Q?4mDYgMiB1/2JHjZrEIIRh0UTSOQLUCpqyKiiO2OBzZ/J6uscpy6pdTcClf?=
 =?iso-8859-1?Q?gwprubmnQZ2Lg18rA5K/U/XLbZIHuhMONnEQz/Shf+kB9iVbf3ma9IA446?=
 =?iso-8859-1?Q?k3ER+BXQHWCacJJWs1l6qNDCwufmtJ9g6CcB+L/fiSP5zy5f2lMYXufsZd?=
 =?iso-8859-1?Q?Njx++tJNGt55ZkhZVH0p+z7mrlcAu8Zv+R7F1nxT8+ZJUoTyISR0y10wux?=
 =?iso-8859-1?Q?v+2uU8pVB3OVmSlEp93TYYgpOojgOflIHCRDb+lGCJKCxPox1AaeawR+wE?=
 =?iso-8859-1?Q?c3lACmfpqh4pnopiYBoZDnI57LvKWGmjcnljO08OqJpqeX4wvembyWw+gz?=
 =?iso-8859-1?Q?6qbXUK3wXRHAMjrahoWn8MPRWgmvRfbe9w2WhPeAmg3mM56JiUuO4CVgz/?=
 =?iso-8859-1?Q?4FLDU0sBGcnizOb6ncLg1Aq3wspYtyeKXh/i2DK6wf0Q0AnWXiZvrPLb7N?=
 =?iso-8859-1?Q?XI5UHxiSfQEvyVFbHlloTtblk++NvPIpx30D/Qg8xf5LVeIb1thuUMBu4m?=
 =?iso-8859-1?Q?aQkWs1gl9xlYzfMbO6tr3a33hdlPeRChd9aUMGpKvhuRpa+vbvCKPrzHvA?=
 =?iso-8859-1?Q?SNt9T4AunJvdswtDewxUcpZm/dvPCPefB7Lt8Zvj/7i42GoEa8z12xTA1v?=
 =?iso-8859-1?Q?2nj3AWKISbZRkf922jlMKTkuCjf3yAuOoDsyaUOp0WK+gPhq6v4nFMB30q?=
 =?iso-8859-1?Q?tl//qiq+kiV2RMOgzaFPh/M5bA0QrnL6JVanMhp7D0SZAPTYZJlpJ++cZc?=
 =?iso-8859-1?Q?ajDkC7taNnMAmLgesGLSjAQ+C9FRVWwhz0e4skSJf3u10bvS1bOBa7J4NN?=
 =?iso-8859-1?Q?bwbXMEiuS/0Ifb8P6OVNVWYud4myWupU4ARN9Fv14eR/xNJCI+hNWg3k9e?=
 =?iso-8859-1?Q?PYwXl2AMah8RT1x4bJOVd6Sc+baQUKMNUkZjwQ9Vyt3oc6J4W7OzdrmeYb?=
 =?iso-8859-1?Q?mNzI9JEuEDjMyLbUILmg2MsaOTcdPUSAqwyI8Y6za92foV/Xtvm/ySHYfD?=
 =?iso-8859-1?Q?rnWNeoRFzK07NNn2dqvG2oEcWX5Kj9tPfZqFFyA6P/HMfXYc0q5XrtDO3l?=
 =?iso-8859-1?Q?WT+9+/NP0ZCZ4bZkU0z/udFTPv3IryA/DRujy5LSCNpWBUg0LQxr6t6dyo?=
 =?iso-8859-1?Q?xaJV5iGkbbO/gY/oEUc3R3VCf97p3cBoMVzgNqU0B8lu0thM8kmI2l65/H?=
 =?iso-8859-1?Q?9PGUBE8dQwKRtF7XwgsHHB2hGholLZTQsMV988YPMoCLL07gJyOrZw5Hcs?=
 =?iso-8859-1?Q?NMFyUxJD3jOMbE/j8iq0Enk3B08ktPPRpwWAxXWzJMXXPyg1TJfSGDU/J3?=
 =?iso-8859-1?Q?nVlSZOQzeyauE3K8PSOGRPuFJNZqrtUz8gEROfQgPtwV1S+tBSulogfHMU?=
 =?iso-8859-1?Q?a/RGfoEShJ1zMnLaWv/WyNnIuPa7wYLBm4Fu9l2iQme8Q21wAC4VDhS1ks?=
 =?iso-8859-1?Q?iNbbFI3WmLXZIgYBOYUwLC5+fZe0CgQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMDPR08MB11409.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da22c89c-4576-4c44-2ea6-08de5133a1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2026 17:05:33.0556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cd726fc8-636c-4794-8425-41f9d8b0d7d5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shu4TGdOf5vhjaprhZ/ycrOJ1nrDBlSLfn6Ycid/Fk2nOefjBsN6T/068ogcMrbf2mBLqNuDNHSYfHrRiA0NV8vJmZ6r9OWAcHlEA5EAhPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9216
X-OriginatorOrg: iav.de
X-EXCLAIMER-MD-CONFIG: 5368bbe7-c951-4377-b276-f0cdd6deeb51
X-FEAS-Client-IP: 10.240.199.17
X-FE-Last-Public-Client-IP: 2603:10a6:20b:71c::17
X-FE-Policy-ID: 2:2:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=iav.de; s=Januar2025; c=relaxed/relaxed;
 h=from:to:subject:date:message-id:references:content-type:mime-version;
 bh=Nxz9j1FM30khyw9NirMAHgrcDcybKcJrDRPq0cCkjYA=;
 b=INkou4fJqvYwIHI5ToaVNsJIPlNLe1wr4so4W3VW5I25I93gEWEyhjNrPl/xuZvyMAF2HEWFXi+s
	uDTfGIjvcgWKwSfzePDp2F3k7kefuC6DqDBkQgqLrR8JVpHXVKRbHNEMfOw7VlWaI96jc9FnCxC0
	i4LRRG8Xf5OSnWjilRvKsUsai/RuUc+QV8LGNfgHVgmUWCGc8bhTfAz6c5GHnrn/J5aV/kx9ZzPL
	QBfB4m0SdHmWm0lJb1crG3p/Fg7u/RiIFnXoQIwTmVJtHfZfRNO7tRkQGyzLtQ2L5V6tcQtyhAjE
	KSujLiW67YPdMXbIkLn6pn6lgj7DTXt1jP7+IA==

=EF=BB=BFThank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)
Using git "difftool --dir-diff" on windows on a lfs repository

What did you expect to happen? (Expected behavior)
I expected it to call the configured tool with no errors

What happened instead? (Actual behavior)
I get the error
error: could not symlink 'D:/xxxx/KUS.a2l' to 'C:\xxxx/KUS.a2l': Function n=
ot implemented

To fix this I need to call difftool with "--no-symlinks" but the documentat=
ion mentions that "--no-symlinks" is the default on windows. Well, it clear=
ly isn't.

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.52.0.windows.1
cpu: x86_64
built from commit: 2912d8e9b8253723974b7baf1c890273b1a1c5bd
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
rust: disabled
feature: fsmonitor--daemon
libcurl: 8.17.0
OpenSSL: OpenSSL 3.5.4 30 Sep 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26100=20
compiler info: gnuc: 15.2
libc info: no libc information available
$SHELL (typically, interactive shell): <unset>


[Enabled Hooks]
commit-msg
pre-commit

Mit freundlichen Gr=C3=BC=C3=9Fen,

Dr.-Ing. Amilcar Lucas


IAV =E2=80=93 your Tech Solution Provider
Your one stop shop for the Software Defined Vehicle and all Powertrains

IAV GmbH Ingenieurgesellschaft Auto und Verkehr; Sitz/Registered Office: Be=
rlin; Registergericht/Registration Court: Amtsgericht Charlottenburg (Berli=
n); Registernummer/Company Registration Number: HRB 21 280 B; Gesch=C3=A4ft=
sf=C3=BChrer/Managing Directors: Joerg Astalosch, Dr. Frauke Esser, Jens Pf=
itzinger; Vorsitzender des Aufsichtsrates/Chairman of the Supervisory Board=
: Dr. Nikolai Ardey

