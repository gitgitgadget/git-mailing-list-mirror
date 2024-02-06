Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2038.outbound.protection.outlook.com [40.92.91.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADED5128807
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707204155; cv=fail; b=DL2oWBfbMUhS1+SUuH2j55IEDV0n1CDyGF1Jiix/seH13zs/PFoaGITzasITCPD2JdAaiaohoT1uISqxdeiHKg06ERUO9C8njlFRDMEMnC6cCeBpKZyj1SfQuEJisrCu/Ap5SXfehg9zLJ1UhBENAwP46A2Aoq/SGZ5mQWNJCls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707204155; c=relaxed/simple;
	bh=WV8diuwnX47WT3o+EAJBYNxkJTWPBhro2+AzWQktl3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdzcvjJNQbHHMqvKKS/n8/yNA0CHGSiJ52M2+twMKxcAVGuDKqecDTl+ynMCNVHJ3s8Y3MpjTivKA4aM8SE5cvJIBAMm1z5njx4XDLfYbnaW/xvRvMR2wQC577BD8VYpZ8lJcOaLnfE6855yyBv3CqsrHtr5+9XQX9VYgbd7/dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=V2WoJ5Ka; arc=fail smtp.client-ip=40.92.91.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="V2WoJ5Ka"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QutNzkknPnmbnyKENh89HQy1oWNs3u3HZg0lwwlG7MR8P4kNqaGiBE07Rb4mpHmkGvlkWU0fsx6JmLcOJsFkVoW1aYvUEsCM/kTGV0mj3Eq1Qq3gfKOC2XIi9W4PcJ172LXFqzPayZmD4YkNJVfIM12dinx/4dXwBohXsGaNBKna9rbVb6bxs7dKLbkzpPJcLUcuN0wrruJoUErRMKzkBHVoB4S26fgLfrdqSZ+4SGGq49AZyhnBfrk7nsoZyxLNuhe32jqt1upEfcpH/9KYjzq9ff7BWOEuFS/qXw7NUiarsm87m04X6u4+CzRgns2sIbqrINAVBn8CeIp/bXuHmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7I/Xe9hHTwow85x7XwfjEbMfr68tbajpLz7cB0yJvuo=;
 b=jZJX4XlJ6zVQmWVJqWrJOtppvmcnOevvYp6/6973xc8ZHPI8tA/cXyYqQoIUzYeqiqM/RbyeT25h7AFCi8q3AcuK6E1vKyO9u38fBwdpHPXIhLsdFP5/8zSC6ySepzRyUzzeEY/RV9Ww0FPTDuwES8Xciy7cXLY6UwPn6u5p6XXZMpjDWXDeU2XXACZ5Uj4XE8xAhvEc0+FzetNE7xoveLMirrxOXILLoH7SZ3ECVLhlRYAedNGuaLDGPMS5Wf7mJePkNWKNFhGcVgCIDgJg1LVh8Fqp8b+v9/9gs6Est5NFmz2m9azk2tIjh/ZsYBcO/6AtBrVu4epfMaCipXGFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I/Xe9hHTwow85x7XwfjEbMfr68tbajpLz7cB0yJvuo=;
 b=V2WoJ5KaMMOXthJUSFWHGgKt3Zb/ueOuWBZvg4tMX78LBRTxW8xNHBrPSinLwBrQYLyGi6nRRKO+vSDPnBxKwqBcWPhr7QPhd7SKTW4q7v3Ib6DfIW0BzJIix2BFerEF6A+27NAXgzdm7Xp0Wyizstsn+zabMCOTVFu3aLS0+sfKdMWw3ljb/VsHtlL3bAk0YGyugxRFNo2GH+IFs3W4qFUR3o+dedMwJeh64V3PMlB2D063lUiRxSB51hmmQxIY4yPKDcY0L7k3+Ix5T3zR/0dJMC+xq2iMysoqChF5Y+TYEkFu0TelAFN4uZQ6UiompWLLr6/ruM1h4tySrJMY7w==
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3d9::18)
 by AM9P195MB1062.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 6 Feb
 2024 07:22:31 +0000
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::c20f:d11:9817:7754]) by DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::c20f:d11:9817:7754%4]) with mapi id 15.20.7270.015; Tue, 6 Feb 2024
 07:22:31 +0000
From: Hans Meiser <brille1@hotmail.com>
To: Theodore Ts'o <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>
CC: "rsbecker@nexbridge.com" <rsbecker@nexbridge.com>, 'Sergey Organov'
	<sorganov@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Topic: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Index:
 AQHaVQX2n79jCmLH3kymUsYhfKUndbD1ZQcXgAG++MuAAAksAIAADzSAgAAu+tmAACgKgIAFXFpI
Date: Tue, 6 Feb 2024 07:22:31 +0000
Message-ID:
 <DB9P195MB213080E6DD9ECA0EE3D2B491E2462@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
References:
 <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <877cjm53bf.fsf@osv.gnss.ru> <008b01da55eb$9f3c36d0$ddb4a470$@nexbridge.com>
 <20240202161643.GD119530@mit.edu> <xmqq5xz6sn5i.fsf@gitster.g>
 <20240202212809.GA36616@mit.edu>
In-Reply-To: <20240202212809.GA36616@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [3Pl4xQTOWRRGddSz58wlUdNHy0D/Vhdk]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB2130:EE_|AM9P195MB1062:EE_
x-ms-office365-filtering-correlation-id: bbcdd4cf-2c5d-4190-e54b-08dc26e461a9
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 p+fKOInCGiPXElIu8CNKnhjXqV+KarGU3DtUY3OX9YeevUJKV6bYC96NDIXiYFDUo9uWUfZxWVd5BRIrEWZC5YHTB+tQat38Rkz0MTBqQB07BPgOESL3M2dqIU2zju3wIeCm1ni3sH1/zUn59bE5ccCyJwJL4/6FTzki95LwGF7MMiuYdhP+1LVa9KrDeNWV3VOcAzipDgLLGxI7VstUdbgYZDMmqliq8+aCU+Z4yWvKrbvEdYW2JI2csZslXXgXgH6HoleWSx4qCpAwqf3ABY7TR3TBfsZbQJwJ93rS2Mxdmfx6UTYlwbRpuHRFqWF05nmIgSFZuCdM5hoXVafq7rb7ppWbIeMNIGdrZ0uWtU96r9bA413Dk+HT5ytukFUlKhZcrxvFzeW9KdLxI48VjK7jyd2eUCXN4By/iOyB2FC9X8iY4SVwFMHoFxo23+IqSywR3lVKdvnqrRNtpqSvW9Fy32KxK9QRCmj5UCQgJgURSCs3MRCyvmC3Vak+4QVucuuiraus++slmBuV+WdWPW0uMI48PKLsuuSAnLiPSsNjB8OFyrZwwAbYZa2kVa4CMKuQqyQVRe7n6TxpnRLQDTHzpqqWKoA34V5luNVcVXk=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?KBI3xqzJ8O+FxTqyurc6iIrCNlD4WPNZxWLuqqfF3kpdPreLMtF/bEwDax?=
 =?iso-8859-1?Q?ysVv12bqL/NeWUIMBXPhwUMVuBy5wSOpnXl7rUgTujo7S+z6wkRVBFKFn6?=
 =?iso-8859-1?Q?OV1gUrUJgCEOkdjz7Ro09DfT5+R9ybYiR960uuRrA9oUcnvquHA65AsGoJ?=
 =?iso-8859-1?Q?iFagCFDEDBBWFHOyYo3XhlTbKl/mGKIo1sMRfHu7YKIypiDdyFG7d9lJse?=
 =?iso-8859-1?Q?sGzQSvM8ZhYcPDqVR8vD6nqZgo0FMCs2c/43d2syeeR02BUTEUK9F/7Grg?=
 =?iso-8859-1?Q?zG1z3TH1LkC9zOLhilyhpvSufnBTw28DG7bjX9rgglWanc50NzdI0MniG7?=
 =?iso-8859-1?Q?ASTdd0cn7cUWqK+awJo3x0/Bx+M3WcajzJdFJu6+wOz27qbgSVQQQUfcI5?=
 =?iso-8859-1?Q?wdhIJYC16KnmSNFiHrBLF78jQ2jgYGrGa0/ZsnrBLA07BYioTqKGmmT71Q?=
 =?iso-8859-1?Q?+CTgEhGEjrWntbPBAE4XjbLzfLHpg8jm54wM4E4+H5KhFjgcFk0OR87j4W?=
 =?iso-8859-1?Q?U12FYzrzZl43bAtKTLyFSeqtGE16srGPc+iptYKynypnj8Y1+EY/kWBc6i?=
 =?iso-8859-1?Q?WpPLAeIjHAJdbo4OrwjSw0sNPSX5Hlfo8vFeX0D6c/08IXPFabXyVaTwBr?=
 =?iso-8859-1?Q?EYm9u+ATG2jcLo0cstLR81WiOCaCTJXu7p0hew3KF/ZUydWivvrIlmAHWR?=
 =?iso-8859-1?Q?X7LQFsg2HzgkubuJeIU5KB63DJ7Q5RzzbXst3a5QVJZpqxyXpQqcjn5RAP?=
 =?iso-8859-1?Q?Aw596FUqdoB+0jSzMwIMClRben+lsJ7cDcwmy2+kU+5VZ3EqSgC3MJ4bTB?=
 =?iso-8859-1?Q?doJQ89nzHixiD/bgZKvrzCxY/EBgPwQxVeEI0CiSs+FspZBbX0FEd4EKNV?=
 =?iso-8859-1?Q?EKdYEf74Xu44e6kUMBdtsnQzokYJ1/VJaImxnIyWe8LfUOpVjFw6yuBema?=
 =?iso-8859-1?Q?Nr+YjXuWlE9m+Cf9AThH0CLGbTGQhplK0HDA9Gb4V+zEDi7tUNszibHHD1?=
 =?iso-8859-1?Q?mw2cLMJYP8zh/Q/s3nboht63miPsjchC87yH14Hi1Trvru6Yh2UGg7TAwl?=
 =?iso-8859-1?Q?Ghju5tDvg2uqBqNoDW/8GjvXFZFyDpwMAIEGRiqRptqdo5AbJTCWCn7VeG?=
 =?iso-8859-1?Q?Fu4o6FF3psWWctMIWQDyfXxoRuI7/WQ188zjOOCKTUqLh5DdMe1jJqhsSc?=
 =?iso-8859-1?Q?1brrlkoY7qyJC/NAfuFo8PuNz0yqLu0/fF1XOy/++QGcjJ8lihLOZmDI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bbcdd4cf-2c5d-4190-e54b-08dc26e461a9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 07:22:31.2486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P195MB1062

> Please, keep in mind that not everyone lives in a web browser and=0A=
> loves to click around.  Some people simply prefer to use the CLI=0A=
> utilities and to press the keys on their keyboards, and are very=0A=
> efficient while doing that.=0A=
=0A=
You are aware of the fact that all these Git collaboration websites are pro=
viding a REST interface? So, you are free to access any function by means o=
f CLI?=0A=
=0A=
=0A=
> As a Linux kernel subsystem maintainer, I am super grateful for those=0A=
> who do code reviews and those who work test regressions, because in=0A=
> general, that which doesn't get done by other developers ends up=0A=
> getting done by the maintainers and project leads if it's going to=0A=
> happen at all.=0A=
> =0A=
> When it comes to requests like "you should migrate the project to use=0A=
> some forge web site, because we can't be bothered to use e-mail, and=0A=
> web interfaces are the new hotness", the entitlement that comes from=0A=
> that request (which is in the subject line of this thread), can=0A=
> sometimes be a bit frustrating.=0A=
> =0A=
> Going back to the original topic of this thread, my personal=0A=
> experience has been that the *vest* percentage of pull requests that I=0A=
> get from github tend to be drive-by pull requests that are very low=0A=
> quality, especially compared to those that I get via the mailing list.=0A=
> So making a change to use a forge which might result in a larger=0A=
> number of lower quality code contributions, when code review bandwidth=0A=
> might be more of a bottlenck, might not be as appealing as some might=0A=
> think.=0A=
=0A=
Again, you are aware of the fact that Git collaboration websites provide a =
powerful user rights management? (https://docs.gitlab.com/ee/user/permissio=
ns.html https://docs.github.com/en/organizations/managing-user-access-to-yo=
ur-organizations-repositories/managing-repository-roles/repository-roles-fo=
r-an-organization)=0A=
=0A=
Using Git collaboration websites you can easily control and filter who will=
 be contributing. And you are able to focus on issues and filter out spamme=
rs. It's quite the contrary of of what you have now with your mailing list.=
 A vanilla student from the "axis of evil" could bomb your mailing list in =
a snap by just registering a dozen new e-mail accounts and writing a script=
 that bloated your mailing list. And you cannot thwart that at all.=0A=
=0A=
With your mailing list approach you don't have ANY sort of gateway to keep =
away spam or "low quality" contributions other by means of the intrinsic cl=
umsiness and intricateness of a mailing list. After having subscribed to yo=
ur mailing list, my e-mail spam rate immediately increased significantly.=
=0A=
=0A=
Again, on Git collaboration websites you can hide your personal access info=
rmation and focus on your repository tasks rather than wasting your time on=
 cumbersome additional and unneccessary work.=0A=
=0A=
I'm getting the impression that you didn't yet seriously investigate on the=
 features these Git collaboration websites provide.=0A=
=0A=
Let me finish this thread from my side now. I suggested a way to improve yo=
ur daily business by employing tools that have been established and proven =
to raise code and documentation quality and that will allow you to focus on=
 important tasks rather than wasting time on an old fashioned workflow. Wel=
l, it's up to you now to decide whether to stick here or to migrate.=0A=
=0A=
Cheers,=0A=
Axel=
