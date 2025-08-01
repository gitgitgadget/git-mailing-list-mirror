Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19011027.outbound.protection.outlook.com [52.103.32.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E61DF71
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754079217; cv=fail; b=Ue88j4YXw0yZ1aTCstPBY/ZbldzK2ul0x5Wp8IAhZf3/U0sGvFg2sh3m4TRZlzB/szcymB8Xmqh+4m8aT+JyAv2SGrz/vls54YiH0OIOw1SeAtwl4w6lBVm3JxN65bJLmxXzTSuAq42km1N2v3zqKv13xNIohskKZolufkPUK1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754079217; c=relaxed/simple;
	bh=dGvDjiqAYlYwAxfJueahT0VpifR03ChFyg3KxXUyjMw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XchXWOOOnKMbX4k0VSED5BvCB/h4TK8su2I1+zHtLd45VEJ7z8X1tx+ckafRWDhbaH4/n4c3uaAZRn4ZtNiv/1HYijcy2wfPBovgE9W0XqA2MlfNj5AngY/sbgCGYMZT6Ze/0L45lt/YCiIv86WvdKX3/cpXB9eEceD2xnaT0Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=dqBEDV+e; arc=fail smtp.client-ip=52.103.32.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="dqBEDV+e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0gpvmJVZ2PzKBN1HXIEFf/cDqEAP6HIDH3P4PAX0RkJ6eL36ZeGFxKfuR+1GSkK8woWpBmnyK5fHq1yzLreMpApdSUkvBiRJfLID6VMUYH38hgPtUx6MeABfk39maPHE6qq7/QE6ALcJwZGo56/GoMyLgmJZy8kWW2EfCiS7EL+vY+PAz3BnS0Q40mPGTJeVd/bSFTJZmIO0HC8zPb21hkMFqlLGX8i+eW9rvcIdWBEbh6t5SFgJYw9974gGSNbAee1caDHtDDMAWjwnEOS2m1/OCpB0csp61xDYOkfnEkk/kAeThi8Rni0mhHRdHjKXSzDIzDzSjBZZAaJPip7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGvDjiqAYlYwAxfJueahT0VpifR03ChFyg3KxXUyjMw=;
 b=nneZVKke6lj7WIqjmTVsW/ODAw7l8ELoP8JvzIFapN4oKZxVHHKwJEt3Hs4/5gkTX46LtEIYM7PStLVN/thkhhOyEgYFfHUdMVrcg67RGGwfsbj97AAJqNl2phKrmY8+ajgJHNjLhtKzSKg4mV3F3MGfP45LuKBNAt+Q9dM7pUtaMQLWutUtsTwxoYVwutoozpmda3NNKBiJDyh2l2iXNdmUn0+qCoJMqlYA/3aXHtcT+yJl/pGk4IZ+SS07OFMFiLgh5uh/oWQad/6EmNykTTQCD7QlyVJY2VLKVejoAFdwnwUFdOn6/zERVW2bL9H54PQGqMoq/lWdvXAZiQ9qRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGvDjiqAYlYwAxfJueahT0VpifR03ChFyg3KxXUyjMw=;
 b=dqBEDV+eOcTkFer7yvr3/7nHq9LDe3/RyKY9tYSwI0sQADIO27TeyjHoGaKQOAOjiVHlPvqpc5OBWAoq6NVVorRrKx7LAKf0sis//tlJCxRbcRMuyv/4L/X8lbx2XCtAFq2LU1oVwVz+Jb9nlGtKFXcv9MMQBl0Xi+YyaoipvHanWJZqU4LVd03wEvuVQy3vn4yI+GgdJxBbqJHSloeZbpRMryXA0oIZxC+Z9toHeW4QdklqgLDIayOrt+46Gp4oL1NHpjxgzpQtMUK6H2kSgUkjNyaZKv4mw1N32UscgZ3EBihpti3eXsiWlgLS5hCfd4kk0t7yr02zgi6vYnAmXA==
Received: from DB7PR02MB4265.eurprd02.prod.outlook.com (2603:10a6:10:43::19)
 by AM7PR02MB6305.eurprd02.prod.outlook.com (2603:10a6:20b:1b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Fri, 1 Aug
 2025 20:13:33 +0000
Received: from DB7PR02MB4265.eurprd02.prod.outlook.com
 ([fe80::1f5b:401:f731:6dcf]) by DB7PR02MB4265.eurprd02.prod.outlook.com
 ([fe80::1f5b:401:f731:6dcf%6]) with mapi id 15.20.8880.029; Fri, 1 Aug 2025
 20:13:32 +0000
From: Skybuck Flying <skybuck2000@hotmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: .env is not being ignored by this .gitignore file.
Thread-Topic: .env is not being ignored by this .gitignore file.
Thread-Index: AQHcAyBpdtcVSzZQpkWdqQxZo3scOw==
Date: Fri, 1 Aug 2025 20:13:32 +0000
Message-ID:
 <DB7PR02MB426582D352EC00FDCDC5CD45B326A@DB7PR02MB4265.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR02MB4265:EE_|AM7PR02MB6305:EE_
x-ms-office365-filtering-correlation-id: 2c24d777-9d76-4a5d-3a78-08ddd137e3ab
x-ms-exchange-slblob-mailprops:
 /OoUGmN/RpXIszFohXgnyf6kgYVrUpTWUXn5e9QM1BX1A2iCzY/Ne7BmqrO0ZDfEXiXV51FPEhAuxd/Y7y825UCRjVWRwvg/6AyHPUwZqUIO2bTjgtUcVRb2dCkI96PbWBr/qA6ekE4lYxIrL414T9dUzvYHKiLPSw0Ym/MRxoJ2ao1OZudKj4kJTt+0DB60i/1xqoqjBwM1B60sp6uFSBr0p7XSnppGiM0hEyTI3ODfhFteNHrIcCUqsetq0Oe/ZgF3DC3ZV4uojQgUZXJ6EdNWi1s+SMORDssSYqJikmtx/KxQIZG5XZMsV2MTKUYUtHAdv+iCcnyLCedopzaKd/utxpKSwNKSTvlYAN2YCI5887wDX6lpd7Y+O/mp4JIC8Qei+HwCALtdTLbj9336W4aCCuj0k2v4q4pkSZS66dCPOjLD76N51f840vmG7upjYZCGM7HULP0sAb3RG+YP+dRX5ZgxYYULPtydaMalDbTKxOq4bj0P+us1pcdvWN1TIYOOLWVVFUt3gi9t8SblbBc+pGwHMADFIZdv1eZCaWnn71uH4BQ6ic5J3g7U/mMxpGWYYMdhnlHcarSz8H0XPsG8PqKtMBxqYcmmWaWlvBq70laDqQX1dVPI9DnvbhRBmyndtDEUDyR+5/fN7T2zquWyl6SsARfcxW0+QZaF2FFKtzWAjbS4Xcoboq2IexRSvrqYKC3FxyvZ66XHzU65b4LqyaQ9KfZkx+w6tZSTJXtyjJFgSl2e1DvtKvZXM2Lp
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|19110799012|461199028|15080799012|15030799006|8060799015|31061999003|3412199025|440099028|40105399003|102099032|26104999006;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2P+jaL/YQ1EEPDnxgNIc/lAl57Ulk8E9qMDAZfKKztcJg9PPKzxBSuS/41?=
 =?iso-8859-1?Q?w8izT7EIeZ9VX1tR2sX4BR5GHFE/9BethBTyNxGMkWLG7UfLtHuUqwQhQN?=
 =?iso-8859-1?Q?+G/ZeZPa/Nu+TkYOtDueQ5D5sF4yZXjIczQYjyxgqhoa6smf8PkSTOpHF8?=
 =?iso-8859-1?Q?OZh+UW9iGetXhFsDIvKWKRLF5X7TzlNQTbuK/Nbrtd3QZE4mFuKTgfh4zh?=
 =?iso-8859-1?Q?6tSwdVP7GtdNoiaHOOXOXe8IssliI5+HS0N/o4LYUjm7Z4pfgLJg/OGD59?=
 =?iso-8859-1?Q?zQieF7BcXSDQsdtbCROKf7rGbKb9/pn5we9Z4CH3OyJMNAr1vn/XAVr9wV?=
 =?iso-8859-1?Q?7ak3eVa2BNdEWejAgAfgViKadN9u6hBEygXQFA6LKjx4H66utQK+6B59/G?=
 =?iso-8859-1?Q?LnGqf26JX3AdtmEEX28ZSnYRHt17f5Ep3m774BBsIfFWYgjjY6b3ApGiFB?=
 =?iso-8859-1?Q?37JFLA+FR2YdvcuAO2VhMwxckNRptUqled6gCz3lQ/q+3Vuwr461y12DGF?=
 =?iso-8859-1?Q?zaYtH/+7Araou11zexbpCh6Xm2kiQLG7JLti3QV8fQa8qPInajBgnYEE3t?=
 =?iso-8859-1?Q?jmmh4hXTCdijxuPKcF7JwdFdR6Glz4+Xjyi/RFp/H3rfBy++PiVFhDO0g5?=
 =?iso-8859-1?Q?FJa7H1l7scyVEzMbwYnmQ9s3oO9UVWaKt0aljYRMWIsoWKkDtCMoWzW0DC?=
 =?iso-8859-1?Q?RnWA2ZT7b7LH05bjb9I4K1mQed34ONhLpDyO9by7+S45Cm+pk2GvIME4Q6?=
 =?iso-8859-1?Q?wh2lq5TRGzsJADiNYpV/uQjbQ6b12rB713qIBVFzFM8Wa4WtcDTQ38epHI?=
 =?iso-8859-1?Q?3pmC1j/YbDhoDQ6SKXF0dGtUHVHquHjO3Hgx2CqKh0+k1V6mfMU2xYEIYE?=
 =?iso-8859-1?Q?m+7U3sY2sxDE3jstGBQ3dwAwyNeXJWhu1JSJqbm7ILj6Ao6dUjMpfAV/G1?=
 =?iso-8859-1?Q?Kvmg1thnuqvM/AgvkubpUg6VZXts+sL9Bpk6vpREkPmMq+LWpFM5PJlr24?=
 =?iso-8859-1?Q?58VHP89S33A8O4hvswHNutqdDpeJgb4ffnUgTpL52FbyyPf2vfbq7gOhBQ?=
 =?iso-8859-1?Q?A5O5sLbJyySzT7HuJsyWlsldVRIx/JcIpHOkquTqR5cyxDGuD3RT/CKzPO?=
 =?iso-8859-1?Q?wxrASSVxIw0FDsu8do+6xgHHqWZa6cEebRBYhbDcoxH3uJH2AKSRZkGd8V?=
 =?iso-8859-1?Q?/cErxFJFCwCruvmU/f+RkF3tue/Fu9hppvl7M8ypJdsIBjCkPpBHQKQysD?=
 =?iso-8859-1?Q?2EPBw5XXVOze4LCJBzxg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?fUoCBJG93DkhMLNYf9Etw/Xi8oZ3DktFTCYpZkLKxbz1EBMSPj6JqrOl7s?=
 =?iso-8859-1?Q?eVG1iXzveJ8h5iWu7lW587rKtaiyVrRpSwltL/QaTAOMcVTsMIMutNxZgq?=
 =?iso-8859-1?Q?XH9gkdVyDDeB3l4Dr8YbhUEstH+F5hmBMH4Z/4mQU4MpzYCbUBDNTiGmM8?=
 =?iso-8859-1?Q?Ed7OJPTEY6biXcJa3pnt2F4k1V+uLghLcA2ExR1EyETBXEzl5uZNLzKrIm?=
 =?iso-8859-1?Q?XglnZWlmtUq2YCYmo/iOyqPPLtxzdJ4Y8zZ93Eo0ERzRPcoIQQrH0bFFsi?=
 =?iso-8859-1?Q?QF+ZSrCjzLYfGv8Y+XhJiezXQkZ2AkH3n8LP61iMZCjIWX3cqL2HMe79RT?=
 =?iso-8859-1?Q?n4GghXy7Otm38MtgDqjr/ij2NGqO4SmaSqQDv5TiFSv0MJQKPfKqTJiVf0?=
 =?iso-8859-1?Q?GI0TNvG+hgf8POv0s7S3CaqRONZeb1B4dwxe3opgSH0pMIHlkplsG0129F?=
 =?iso-8859-1?Q?cr75FqpYDCNIeAgmuFzpiYNqMqD/DdPer+3G85sdOJ1UZKhdRFG1ACaqXi?=
 =?iso-8859-1?Q?MK8ayK78sxhkHJtn46eHXEaPLpoKVUDf8XWb+gwskPRIk7ncWwQrKnHrfy?=
 =?iso-8859-1?Q?1+02z+7aYDPnX/IxKrlGF6Y2js+Ol/MS0nTXbrrKw8pR9B1RHpdTpGLfIN?=
 =?iso-8859-1?Q?+VG+1G3zhfuiZdifx5QklwkUS7g1QVWuobTwaVxxOoYccsuR/TqMG9wX5g?=
 =?iso-8859-1?Q?570MSUlDVIQAAHISyqbfo33zx5jb+fhaOuWfW1JcL0T+Not0/q0SPGJotd?=
 =?iso-8859-1?Q?l+PnKooagJIqjdJt/EfdXihPXSPOb+gTcLyTCHEzxoG5tFtiGJTNGEydR/?=
 =?iso-8859-1?Q?j5CbuwqrVvY6UEYZ0o5y6r3t2hfu3sRLLSYwfn4MW2uUl+hyoyOlb6rPsb?=
 =?iso-8859-1?Q?pQ9A53fKJKCUTtFnmOKK+KBdGyuP2YCeU8RFFvOg+XQuNkYmfy/iz1wEF6?=
 =?iso-8859-1?Q?nJwId9gxbZ1m0uI/dWP/ixQfQ5KHs8VDu6rmlF5rfqPjMZaeoX2ZULxC+k?=
 =?iso-8859-1?Q?bIST5/KmoxS3e3/NorAa+I7gBvKyUjZmZw5sicZ2IdbRZPo9lUTgau60k2?=
 =?iso-8859-1?Q?9CBJyiy/CpFPuqqwttXDdZpIwN7PA1itU+lVEYn65StYSH4qFFW4Gpu3YQ?=
 =?iso-8859-1?Q?JDWw34xdtu0j+9T+nZgaWmQJbr0J4SIe31cb0/mMutEL8V0gBznA7lnz9Q?=
 =?iso-8859-1?Q?jjieKTgMeZaugmX8vEK3Lz3gR8oYewzMqRRCi3A5xtCtpfzp/7Bmitdlw+?=
 =?iso-8859-1?Q?ypB4DbGEeh3FTmC6AH97VzOYjbGNTCdz5c6ldWObcY2pDM2BkzWmsiy6M0?=
 =?iso-8859-1?Q?vnDEPE517iqE3zIJlqn25ZZh24gYJIVaKUvPnm38SQYjG2Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c24d777-9d76-4a5d-3a78-08ddd137e3ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2025 20:13:32.9379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6305

Command line tool "Gemini cli" uses .env text files to store API keys.=0A=
=0A=
I am trying to make git version 2.43.0.windows.1 ignore these .env files.=
=0A=
=0A=
However for some reason it refuses to do so. (Any idea why ?)=0A=
=0A=
Here is the .gitignore file:=0A=
=0A=
# Modern Delphi 12.3 .gitignore=0A=
#=0A=
#--------------------------------------------------------------------------=
-----=0A=
# Delphi / C++Builder Compiled Output & Binaries=0A=
#--------------------------------------------------------------------------=
-----=0A=
*.exe=0A=
*.dll=0A=
*.so=0A=
*.a=0A=
*.lib=0A=
*.bpl=0A=
*.dcp=0A=
*.dcu=0A=
*.obj=0A=
*.o=0A=
*.res # Compiled resource files=0A=
=0A=
#--------------------------------------------------------------------------=
-----=0A=
# IDE Generated, User-Specific & Intermediate Files=0A=
#--------------------------------------------------------------------------=
-----=0A=
*.~*=0A=
*.bak=0A=
*.old=0A=
*.tmp # General temporary files=0A=
*.temp # General temporary files=0A=
*.local=0A=
*.dsk=0A=
*.cfg=0A=
*.map=0A=
*.tds=0A=
*.drc=0A=
*.rsm=0A=
*.log=0A=
*.pch=0A=
*.ipch=0A=
*.stat=0A=
*.identcache=0A=
*.dproj.local=0A=
*.dproj.user=0A=
*.groupproj.local=0A=
*.groupproj.user=0A=
*.bkm # Delphi IDE bookmarks=0A=
*.tvsconfig # TestInsight configuration files=0A=
*.history # Files with .history extension=0A=
=0A=
# Legacy project files=0A=
*.dof=0A=
*.kof=0A=
=0A=
#--------------------------------------------------------------------------=
-----=0A=
# IDE History, Recovery & Autosave=0A=
#--------------------------------------------------------------------------=
-----=0A=
**/__history/=0A=
**/__recovery/=0A=
*.autosave=0A=
=0A=
#--------------------------------------------------------------------------=
-----=0A=
# Output Directories (using **/ to match at any depth)=0A=
#--------------------------------------------------------------------------=
-----=0A=
**/Win32/=0A=
**/Win64/=0A=
**/Debug/=0A=
**/Release/=0A=
=0A=
# Cross-platform output folders=0A=
**/Linux64/=0A=
**/OSX64/=0A=
**/OSXARM64/=0A=
**/Android/=0A=
**/Android64/=0A=
**/iOSDevice32/=0A=
**/iOSDevice64/=0A=
**/iOSSimulator/=0A=
=0A=
#--------------------------------------------------------------------------=
-----=0A=
# Common Temporary / Local / Sensitive Files (General)=0A=
#--------------------------------------------------------------------------=
-----=0A=
*.zip # General compressed archives (often backups or downloads)=0A=
*.env # Environment variable files (CRITICAL for sensitive data)=
