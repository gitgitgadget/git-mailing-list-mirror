Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B463D30ACEE
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 18:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968388; cv=fail; b=Ek3BVlMSX81Cb+NZ0ah42mhT93KX2xWkRG7bFuLwzny+Dc6K8MAzmIxPIboLURLc8beq18kc/p9NaM1IWm+0hkhG2DU13DAa6j58U7XM9xyy9s0aePh055zyT/PXO++85Q38jtYho8Nw/ib/RnY9t1l0GbSAU4hi3iBO3Pmg6fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968388; c=relaxed/simple;
	bh=f49HQGNklna6/iRavA5KzhjnoXND8Rnb6Qr1+40XyZo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kek4e0rJ32kOyLvpI7N2VRr+N8I8OldfiM9otogqmFMcO+/VncXhCYy0dA5c/lKDYkQ9ItpxLdE3tukQ/ELw56Dh7UsyFX/chRh+aDs/i39QSxrzJgsAIXYqrZ2fJOugzofj0qRw1Nlhr0CuHCv7CrBs6VXkcqQ2gObzQ6tT29M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ns++xBS0; arc=fail smtp.client-ip=40.93.198.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ns++xBS0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUOusrz0d4GkKCOolkb+r2jLA0VMVuvRH+dBboQr2HH6uSHlf8Po2xxv73jRPeL1Q3PyBKEVIh0rWg+1kCi17oytzR/cMttTl+dCGKtpW+ud02L/Gsk6L6wdTsSzSJGG1vaz41xjDlczLG6abNCu0aHFNU90EFcubWwsgOKhnfmQCojEQDoTIR0qmaFRDEL8bQtg0N0c1TypWOcsyeyPCaNwWi3r0UhwnLaE6AAOxXdG0Uv34N53MPVpA3hxhkhZp4yPt9mJJ1qFvy5cRT+t7zAnf701VcjfdAxf+6rI5xXdgJfzl5Rv6jnY6gIFRjAJgbEbqgSQCn5xih6lea6Luw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygZ9gXPazyXxGEnPHZNPlKSy4CoHPyS3Uj8ecfq4Nhs=;
 b=IMTwl1vq3XVwa7FyZrWyjW4m/xUPlPDZp60FbnK/Mo5H9CFQq3R/kYD1BDQginmgxj1buT9MtLILiqd1ZVHHVMAw1Koi3G8teqJLZhOYBfL6CSGs/7nP6bO6sWpdSNqoPhD9QK5CIX3U6mJh9FPG1GdnvhlAhKjhnUFSeW98MGWlIyeqwKX81iocN93WFSWqQbTjCM//hxI6dtOwUlkcLLcRCLyLYbTL6IM2VaQMBWt7BFU9UywWpSZvEhFXsraLh7Z1tgYAZSeq+FU1b6jSSI/SBKvq3xmHkaPLB/WiB4/rGcyOE/+V7ZQ4W4clQWPGa/8MfhoWVw9hFCkJmueQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygZ9gXPazyXxGEnPHZNPlKSy4CoHPyS3Uj8ecfq4Nhs=;
 b=ns++xBS0+7YsJwuRV028vuzQeeo4eO06oXVYXc0FPbRYITkgtRXLQC3nx5lBbATxBqGRHu7MWuQeKqT44aQNZS/1Of6w0jZIsKwFYqPla0rphnTQrf62i1fc89zG08cv86VXqDzG5TIR5sdweb0HZN4/gy+E8s2XgowK+aeK0zg=
Received: from PH7PR12MB7331.namprd12.prod.outlook.com (2603:10b6:510:20e::11)
 by CY5PR12MB6645.namprd12.prod.outlook.com (2603:10b6:930:42::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 18:19:43 +0000
Received: from PH7PR12MB7331.namprd12.prod.outlook.com
 ([fe80::71ed:8ae1:dd61:386b]) by PH7PR12MB7331.namprd12.prod.outlook.com
 ([fe80::71ed:8ae1:dd61:386b%4]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 18:19:42 +0000
From: "Grossfeld, Michael" <Michael.Grossfeld@amd.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug: Hierarchical Aliases no longer work in 2.54.0
Thread-Topic: Bug: Hierarchical Aliases no longer work in 2.54.0
Thread-Index: AQHc00sjm1kDq3EdikSWCin3kcbjXw==
Date: Thu, 23 Apr 2026 18:19:42 +0000
Message-ID:
 <PH7PR12MB73313034573C59C73F821BBFE52A2@PH7PR12MB7331.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Enabled=True;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_SetDate=2026-04-23T18:19:42.958Z;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Name=Third
 Party;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_ContentBits=1;MSIP_Label_7ab537de-9a15-4e91-8150-78a9f873b18c_Method=Privileged;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7331:EE_|CY5PR12MB6645:EE_
x-ms-office365-filtering-correlation-id: 3d2239ee-2866-42b9-7c2b-08dea164e405
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info:
 p6f85KkCaonE2JNfnRt9SvAvqADC9LT+a38ADTkRnfLuOD9sF+zJZSrcXWTderBXc+PuxX1kK34jmpayA0v2cbLh8Th1rGxanbqwQ4EulTNhiIDhAUAD51s2Y7b/ahFVPJxedF2cr7vyYzQDwogzKTLJTIHFkgZTZP5dPBzpsr+Tqm/hsQzVafTNJideq6tr55zIqQgNGnc8HgGkU+lPsHsJsE5zGmxyJ2m8KXX13EnfcAkyo3FF+mG7FAb+R1sZ7aiPsD07NGxiqyREvwN8JEgzKAmLNMwXU4aMX5Cf5flfYPScH6y2CH6rc9sg2CBvrEK6NQMzPZYeabbF65lq92+l38oJftzEG9Q+lTAv/n37st263kXcIzhsTNmP9Il0p+lQJDxM00Dcy8u6UdIWsQhXySPkf9MMuEwgyoHgQpxQojUeWhlkaJBThVBa9JnTCAk3EYcKTQhmNRmUFpqdVioaAjNsiIs96YsbkPcOFzjTzNeu7koezxnAX3miqrgPsNpT+W0f5GlyGyqwf8ibmVVxAEq1mAnXeOIxMAUCuE9mgAyaBKfBr1L/HkzMIo8lVCAOVX2hXx4A1ym0x4uc0JFLbrUwORB4VOGF7ceumVm5K3WJVOLalhO+9NUdHzDGJVTLPPoKGDA5fF2EEry/T4NsuLDJMEXpLlYe8IW4oWCY5qZp5vXVv7q2b4CWLfRJwY4/onGpTa36RewF3l2cvWqVYv7WLKK7H7Eo6QVAfiMwFyE7S6DXVYzlv+Y7GmdbiYXSvwUQaPz2sGasSHeF9Fg/5Cavs7Aiza5zb2aboQI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7331.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?BakWY92pI2Dd7LnQPupIDrPZQ1WJ3pxzdEMy7E1MnZ0e7zTRBovHar5KFN?=
 =?iso-8859-1?Q?BcOmje9wzVf0K8XJJn35uaWliwLryKBeBM0j/C/Bi+p9l8DD6miSdHOyrd?=
 =?iso-8859-1?Q?/PmhLypQTWP8Ndo14OIXKLuHFQY4pwBkvq1rZ9zxAXC7sjtf7XWyoQQPno?=
 =?iso-8859-1?Q?zUlo4gcf9RjhJW2uFrRkRk7xn2hW12KyvcovUutRPbPqWiIaUTkxrgbu+v?=
 =?iso-8859-1?Q?wrlG6l6Ql4tqdjpSQQ0c58knV1nFaZVOtspl7oVpp6gUVI9HZ4tOCKqzOS?=
 =?iso-8859-1?Q?dO5JOQyBnVCsdgHuagOXyCGLCfYAWLxvIQKHnrydJi1+fFquqhEm9ZT9GO?=
 =?iso-8859-1?Q?uZZL6lYDIGoYXnD3P5ztZ/gLfcGoQLAIRcBL7CyHb9Bt3VFZYCzkwBekoC?=
 =?iso-8859-1?Q?beKRNx71EF+84jpI8On25vgg+6slrUuZfkSwRkFptxuR0ZVO4kpPA5veQg?=
 =?iso-8859-1?Q?zEczczfwKHoCyhSg9BYlZ6rSVNUHpmDUF/qjPTN1H4ZQYPGTjYQcoLz1d+?=
 =?iso-8859-1?Q?V07lSyGk3lkc7RcQu5lU7ulmkKp4nk5Qu1nAhQ0eDsyJdnnzmx7ucaT+lH?=
 =?iso-8859-1?Q?M6bHiGPZc7Wgrv5s5eX4n6wO6FfyDTnpVv7DUW+YkLQtbMkviq7pmsc6It?=
 =?iso-8859-1?Q?7D92oXbO4+NLVkrkjRna4uHnHq716SKJS8IrG1DyWqVI7hVsaD2mukeHk/?=
 =?iso-8859-1?Q?CQpqim2D9627EI94F1FRF/xqmyhPLh2oJaWxHxOBBnlmf68bYJCQxn2S9p?=
 =?iso-8859-1?Q?DxSMElHNO5HKbQ0Fi8rKW2mWgNQKjeQZ632Kd+RC1af8JfT+UqPRVq9NJu?=
 =?iso-8859-1?Q?z5XlbtYaLo6/j+zX7J/XzMnh3Co/A0iyHxlFVVHVxBVGXcV7+9Brg6x3zY?=
 =?iso-8859-1?Q?oX/Q3wdSTJPrUOz05MnNiz9shG4mrTqxP4At8qkk5NhifNa1+e9wrSMU/p?=
 =?iso-8859-1?Q?uw3NZQ9vCSme/ugbkvBkxPOKJVsP1eOGxOB5mbBN4W1cKQxp/iFzgOsmJA?=
 =?iso-8859-1?Q?PD+Pqx4SuzBU2DfLzCsAdrOKGXniJAAHGewwI5AC5FPPxroQLPe+gRaIi8?=
 =?iso-8859-1?Q?GIt8O//4KwM3vKE8S49uTfXO/ntrJcBK13WQzMW9pFMZzU9ansxcQrVI0N?=
 =?iso-8859-1?Q?TVHI16cctm2IvMqkD0ff1HmLZ59wPMon9Is1OsUOMEIeSOV3xkt/O/Dag7?=
 =?iso-8859-1?Q?MorI2Q4xlmhqnbLvBnAAX5rbmELMvD/yf7V/sq/iyoPxfRmo4ZF39jmrch?=
 =?iso-8859-1?Q?9+2f0paTT9n1idr3BJcJyc1XeYT7EyO/daSRMXEjbEnKB+PhgIltQVmM5g?=
 =?iso-8859-1?Q?TEb3dffokwkNO7kL7ZSPsmrfDeWrDb5IbQ/x9nx3aPpYs8OR4q2zYwANUh?=
 =?iso-8859-1?Q?/IAiHoHTqITRdOT5iajr7FkyWAKysxpupAk0ym+jJqiIQfyQUVB4FGtVFn?=
 =?iso-8859-1?Q?i9Od2aqJK9YCmG/1Q1wERAEE40YZiDIyqiegqtGxGb0GiDc2+6md6J1DQb?=
 =?iso-8859-1?Q?YjJNmAIV+4vfM+dnBWzjy2L0Hh23uPeOu/StYXCpZb1vvsPn0OVj2F6EEZ?=
 =?iso-8859-1?Q?Pr7dVxvHldYdgeTjknjXKValBa9ITfiIseo/xMs9HaeQwfMe6UZAVvD4qD?=
 =?iso-8859-1?Q?UTRzVVX3KZo766u7FtnO0u62j50ncEB/WHi1RsQZbeTrzTQRuU4L8qMKlf?=
 =?iso-8859-1?Q?h7To/IseBYeSeL+xPYqNav+Wb+pj+CrZfGgLjLiOMSNfbGgVD5QbkLO/iC?=
 =?iso-8859-1?Q?eykty9drqJ7hp40+KlJWQ+Lo13jWDtAuUeVLcdhNShYQsG?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7331.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2239ee-2866-42b9-7c2b-08dea164e405
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 18:19:42.6968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f4Cs9Plw3ZiXATBwwAHaOvnhF2T2BGdslFqVUph9S/ZD6YbT+nGSkuD3QFjRo0CGhCP/1Aa0gO8OlF+D0Zgu/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6645

Hello all! Seeing this issue on 2.54.0 and it didn't look like anyone had r=
eported it yet.=0A=
=0A=
> What did you do before the bug happened? (Steps to reproduce your issue)=
=0A=
=0A=
Attempting to use the hierarchical alias "pull.sub", which was working in 2=
.53.0, is no longer working in 2.54.0.=0A=
It returns the following error: "git: 'pull.sub' is not a git command. See =
'git --help'."=0A=
=0A=
> What did you expect to happen? (Expected behavior)=0A=
=0A=
The git alias should have firsted pulled, then updated submodules recursive=
ly.=0A=
=0A=
> What happened instead? (Actual behavior)=0A=
=0A=
It reports the following error: "git: 'pull.sub' is not a git command. See =
'git --help'."=0A=
=0A=
> What's different between what you expected and what actually happened?=0A=
=0A=
git 2.53.0 to git 2.54.0.=0A=
=0A=
> Anything else you want to add:=0A=
=0A=
The alias was defined in my gitconfig as in 2.53.0, and remains this way:=
=0A=
=0A=
[alias "pull"]=0A=
        sub =3D "!f() { git pull origin --recurse-submodules=3Dno --ff-only=
; echo Updating Submodules...; git submodule update --recursive --jobs=3D16=
 --progress; }; f"=0A=
=0A=
It was written via this command:=0A=
        git config --global alias.pull.sub '!f() { git pull origin --recurs=
e-submodules=3Dno --ff-only -p; echo Updating Submodules...; git submodule =
update --recursive --jobs=3D16; }; f'=0A=
=0A=
Trying to do the following (with .command):=0A=
        git config --global alias.pull.sub.command '!f() { git pull origin =
--recurse-submodules=3Dno --ff-only -p; echo Updating Submodules...; git su=
bmodule update --recursive --jobs=3D16; }; f'=0A=
=0A=
Results in a section of the gitconfig that looks like this:=0A=
=0A=
[alias "pull.sub"]=0A=
        command =3D "!f() { git pull origin --recurse-submodules=3Dno --ff-=
only -p; echo Updating Submodules...; git submodule update --recursive --jo=
bs=3D16; }; f"=0A=
=0A=
[System Info]=0A=
git version:=0A=
git version 2.54.0.windows.1=0A=
cpu: x86_64=0A=
built from commit: 2b8a3ab140826ac423c2845ef81d4c6ac4f7bf3c=0A=
sizeof-long: 4=0A=
sizeof-size_t: 8=0A=
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh=0A=
rust: disabled=0A=
feature: fsmonitor--daemon=0A=
gettext: enabled=0A=
libcurl: 8.19.0=0A=
OpenSSL: OpenSSL 3.5.6 7 Apr 2026=0A=
zlib: 1.3.2=0A=
SHA-1: SHA1_DC=0A=
SHA-256: SHA256_BLK=0A=
default-ref-format: files=0A=
default-hash: sha1=0A=
uname: Windows 10.0 26200=0A=
compiler info: gnuc: 15.2=0A=
libc info: no libc information available=0A=
$SHELL (typically, interactive shell): D:\develop\tools\Git\usr\bin\bash.ex=
e=0A=
=0A=
Thanks for the help!=0A=
=0A=
Michael Grossfeld=0A=
AMD=
