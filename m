Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2053.outbound.protection.outlook.com [40.92.91.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC481A3155
	for <git@vger.kernel.org>; Sun, 20 Jul 2025 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753001145; cv=fail; b=MQiqJLPI9nQQzQvj69g8w+Q/IKSsN8Qm/xJJFUi1/Cu+sD77lqFTGxwqtvuBSGVzlPTe84cvI5LG6BiLTyuVoY7/R8gIrZ6T9CV5BcpewaL/Sq9f6Apcbyf3hnpXDlUMRyRzgcAcF6sL40IzrcCpqIEds7xvAL3Dim/56IJ5Pb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753001145; c=relaxed/simple;
	bh=8Bqdc09QGmgBjCnNjy9TIo0bRyG3GyDDmbQ8vYgmwMY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=dbIiUcRIzUq+8AV7U/6fqwFrRI0mvCFTBLa79V7PcpUozk3is187BBu/zk8OT6GJ7h+hFhDnzIsFJhEcNrv7m6S9jwy0Eg3ouQNIy8emcn+1E5mXR8hRp72/kt9XFcBgi2Huzv5ON1rY8FhhqF92aKA4QbO6jdeI4y6MVEqf54c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b=rvjwnPEi; arc=fail smtp.client-ip=40.92.91.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b="rvjwnPEi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upeI+LzzFa4d9HAp2snH6uXD/WebsN/Ay7HATI1nsK9N/xTgLJMZXAqyoV5aYyZ+vCyyNSOeHkPBCNqjgt/qXcxuUAPhzHYXRfKEb2qzW1c3hHmGXGKP5F5QGfO5Nra7HD7euJLW6D21JvZXcuPFeSx3xfkLNc+JLc4AgHEn1vmLpHp6f1xJDZTVmDNJi0fsXphPsn1OrMZxNm6OigVKW4yeiP39+vekcKJlmPoyJj1EZXrVq9o5+09hLBUkFjf0avjQpan7GwwRHTl61DqqLFAi35zJVC8WJeBqIv3w6nVCubCXGYDB70BxHdPjE4GcLwau+kDa+6CyBrt7L4mGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9NOL6ahqlM0Yq8BdEZt2b2KTRcbjfplKyGAtqTSnsc=;
 b=r0LnSrgTwjSFxZhLOxTo4CFF9APFdcW6IlcADz7SCLTwTej8C1JMuFbt9oNCwPcRqL0qpNl/VstgkrRF41dD+YM3ml78dlEeYgZHBQ8necyL4LaIFVroYfFZul5LCi8up+hWEEVks/tRvjXqz3tQoZQ1UsFZny/0zJ8HYSbTIkx/1mKEXs/PW5fwjC5awsIWSMFLWUsCQ3DRd0l79WZ7nQWh2azuvVBR3YxfTaYZXnDtNcUl/1rHFXiw7LSzhiIdv6bDdZr+XchZ9XG8AnzJfnxgCBJ+usV2eMkyyC+dXKmtJ7EuiU8RYLxOPa8rCY9WQZeFvAptOQuO0CHxNksyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.DE; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9NOL6ahqlM0Yq8BdEZt2b2KTRcbjfplKyGAtqTSnsc=;
 b=rvjwnPEiryDfYbK+4CLLsUE4BSk4UHozTysIrpp9eB2Q0/UszE2womyDXo1YcENigym8ytGLLQZuve9HdnbtfF2MrsSAl9nIJL/7XBJnmnJUdl13WgAtnd7sb4o9SuE0o+s5ZaReAhJokZxe7dpdtlkooWhPsKWzMwtPDCUICd/JmFci1NzRTIMJVctPIEs6u5hVOOIE/Y0UJe2VW+jy5PeSJXKt3I46s+tr8AQInJl1z1ugAuIVwCXT3/aQ3PWKxlYngIXOwG2WUso4CHGWb+IaeHECV+Vp7kPcEekC2psxirj8LkaP+NQwS9O+mWjRZpN4E2lRueWdmeGIkbEs7A==
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by DU0P250MB0604.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:32a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 08:45:39 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1%7]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 08:45:39 +0000
Date: Sun, 20 Jul 2025 10:45:32 +0200
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
In-Reply-To: <ac871bc4-df93-31f4-55f2-d6fc538a422d@gmx.de>
Message-ID:
 <DB9P250MB06925F4833A534245FAA0A2BA552A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <ac871bc4-df93-31f4-55f2-d6fc538a422d@gmx.de>
Content-Type: multipart/mixed; boundary="1851393-29647-1753001138=:22940"
X-ClientProxiedBy: FR4P281CA0272.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::13) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <5b5b0f83-6925-1879-99a6-a2f1311bcc1e@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|DU0P250MB0604:EE_
X-MS-Office365-Filtering-Correlation-Id: fa4ea85d-d257-4054-9683-08ddc769cdaa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|461199028|5072599009|41001999006|1602099012|52005399003|40105399003|4302099013|440099028|3412199025|10035399007|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnVNaHZ3Q2krOXJOaHJDUml6b0RDTGlQcFNsL1BqaDRMTndQSjNFYWNMNkl6?=
 =?utf-8?B?WHp1azFUdmFjaG5IbXVieE82R21RekVJRjVRRGVCYXM0NjBGaHpFR3JLUDBk?=
 =?utf-8?B?UzdINW5oeXB3WjJGSmM1OFVDS1htWmk3QzQvMEVxK3ZrUUl1R0duRkl4Ym9T?=
 =?utf-8?B?NFJjR09CbkUrbXp4ZVFWQTVRUFVsMENtckRVSmVaOUxKZXZ2R3FXZDdRKzJ3?=
 =?utf-8?B?NTR3WjZXN1Q4Q05HWHMxRDkvaHBzOUlXMWxSSU45RDNtOWI5cTBreTNiQzRs?=
 =?utf-8?B?bHp1MTlyWWpKdjN1NjlwbGtycTN4RXphNHNXZUx3LzJEOG0ybC9WQ21URWpE?=
 =?utf-8?B?VTlzNVhMTW5tWUFJdnJtMjJHWGdMQjBwNzE2UysxYUZvUklxZGkzbGowWWJp?=
 =?utf-8?B?Z2ZSdTc3bEJwMURXOThldnFLMmpXaWRCTGozZ213UnlraEc0SGV0Si9DRXlZ?=
 =?utf-8?B?bi9jRmZJN24yMUVLS0lBalliNVJDaVltSWx1RlFScnNJUUJ4emRjeGtoallH?=
 =?utf-8?B?VnlVZkkvd3J0ZGJOOTZBTkNDUm9oNmJEYU00eVVmQUdMbU0rNEJ5Y3ZFako3?=
 =?utf-8?B?VzE2RUM2VlVKNXo3RzlhVXZmUnJjcCtKNHF6ekRHdlhrNjh6WGxjMkJOS2ZF?=
 =?utf-8?B?V1RTKzhjclp3UmluaE83VUpwcjFQQ3N3b0JrRitIb2NwbkpPb0Nya1pFdk91?=
 =?utf-8?B?R1ZDSGNIcnVSbFNWQkZ1WHNuT3dmbmtqZnc0N0x0aXhSRDIzbElDVHkra09K?=
 =?utf-8?B?N29pVzZNNE93bElvRHpFUXRYR0RrY0V2R3VOYkJCTXdCekR6RUdNdkdHam9v?=
 =?utf-8?B?RTdSMFZRUmF6d0xKc24zOXhWeVZlWEM2a3lVSDJRb0xaRklXcDRVTlJGdERW?=
 =?utf-8?B?TVdTUWJGS056NW4xWFVrYUFPbTIxZTU0NU81djRHTXFaNkFUd1E4L2UyMm5w?=
 =?utf-8?B?eDVmbUdYdTcwNGJjUU9KUVorSHpoLzRETngrRFpXRHZKK3NvaTVhVHg4SDQ1?=
 =?utf-8?B?YXF4WDAzZHBKYmdQNkx2N1pWM0RYUXZrRWxxRFdGRHBqYXRLSHAzVEpGZExE?=
 =?utf-8?B?aldVUVMzOGI0aUowalRNalozZFlaY3BRK1IzaHBzcGNHR0dzcnBhVW80YTlN?=
 =?utf-8?B?ckY2aTJwelIwVDlyRnN4NE1KV2pWUTQ5L24veG5rNjZqcVczQ3hzZWx1WE5Q?=
 =?utf-8?B?a2pleDFDVGo3K0ZRSHdNRlpuRkFmOTh0VWtudmd2MXRXVFVseVNtNTJjQlMw?=
 =?utf-8?B?RW5XYzVLZG5pQjUrZVRMU3Q0Q25UdmZoNGZnMXhpN21VTFhSazYzOFJjMGV4?=
 =?utf-8?B?bXRicHZGVTZia2NsaDRYR1JMSXk1WkxTWEJCVWtxQU1aRUNESnptRTJibnhx?=
 =?utf-8?B?RnBiUGxYa2FnQ0wxTHpteis5K252UWRIWXNscnNiaTEwNnNIMUVMcUhPT1lk?=
 =?utf-8?B?Z2d5Zk1WZlRmMURmRkFNZ0txaXF4VGFob1pIc3UwcHR6WlRVMndBaTlBaWRn?=
 =?utf-8?B?YmRtanV6c25tK2sySFdWVFhoZldrRWtGYlpCR0J3NEFzankzdlpubksvNVow?=
 =?utf-8?B?QjJQZmZXYXZmcC9oQUhxRjRNbVQwWmJjbkc4M0lBSEdKb0V5YkEzblhnb3lx?=
 =?utf-8?B?cU5hYlhsRWx4c280Sy96T2QyNVQrWWc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2MxRmErNkRTOXJnNUNrTFd4N3BsSm9rYjNGTnR1a2UrbXhPMWVZaFVBby9D?=
 =?utf-8?B?dXoyN2dydU0rYVdidWYwSlRxL2JtNldISTVrVnc0OTZkTmd2YmVXa3FEaWVr?=
 =?utf-8?B?czQ2OFZxc21CazVpckRWZDBtK1ZNQ2VhazY3dFdFemNBUENDWU9tbVhxcHpO?=
 =?utf-8?B?b1lQT2hwZnMweGY0R1RlQStHT21IYkpzdm1WR2swZEc3a0tNOTM2Qi9CbVVV?=
 =?utf-8?B?YXczc0NnaWg2ZnYvSjJaTE8zbFIxTUNQMlM4b1JKdS82eFpuR0NIYVNselhq?=
 =?utf-8?B?ZmRib2I1bElVbGJhbzduYzV4Z1lpazFWOE9WUEZmMitlODdpYURFVDVUMkZD?=
 =?utf-8?B?Sk5zcEZaSVE2RlJzd2c0MHRQOC9OTFN1cnhhWXhKaDF1N3R4RmcxM1FyU3c2?=
 =?utf-8?B?VjRRWDNqVnBOeG9Qc3hjU00rSWRRNEs4TUgrSkhKdGczYUZuYXhmb01PTHN0?=
 =?utf-8?B?RDdsMExMbUFmQ1RuREdhWEtlRzdQaU5xeVJHSWwyTmVySE1ydzVsa1NoY2x2?=
 =?utf-8?B?S054ZlBvVTd3NHB2T2tIS25jSlhBVGROcmhOUTI2dzR3MC9HSTB4YVpORVVJ?=
 =?utf-8?B?Z0c3MDNBMFRVaCtHZzJ0eDhaYStzT1UrRTN0L2lhU2hqcmxSaXB0S2xxL3RH?=
 =?utf-8?B?MnYzaXYra2YyM0t0NldVUHRvUmVORGFOSEVNOFV5RkxXckgrRTdSSHNRb3ZC?=
 =?utf-8?B?WlUxZGplbGxDMzV6L3NxVUlrbzhzU1RFSUZkOHZPWGlBMDUwUEcyNHBYTmlM?=
 =?utf-8?B?MnA3Ly9VS0ErckxTRjlua1NGZmp5YVJndEpOaHI1U0s5WHJ5dEhkVUVqVFB4?=
 =?utf-8?B?bTJDZ2J6MmdmWHBEc3ZBTGI5eUV6ODhQRWtpbWFSbG1pLzFNdzlIc2tlSzVP?=
 =?utf-8?B?YUd2K0NuRHJZWkdGVHR0T0h2aDVyT1ViR3FDL2hMc0VjVVlsYWJ3aWg4ZzZU?=
 =?utf-8?B?cGQ3WG1xaE5OVmxWL0tJUDl6OFFKK3JVOVFwVXVveU5NSTVPNGREZ21MNEJN?=
 =?utf-8?B?aEFrMzVTaklDNFBQZTJiZGZZWDhEK3RoZHdjYTdkcmQ5R2tqLzVScldGUmRU?=
 =?utf-8?B?cncxOU5IVU9WL3cxT0V1QlJFSFh2TCsyUGx6Y3RHUW03dFg0NVJJNzNYS29Z?=
 =?utf-8?B?UHJjRUVvNXFHVHRXbXV6OHNUR0xVSU9KNytnVnpmS3pkazBXSkNITGE1N3Zi?=
 =?utf-8?B?cFRaU1EveVVFeVoxU0UyMWlLRGRpMDRXdks1enV3dXVodUFPYXJjSHAvSU1V?=
 =?utf-8?B?TzRUY1dYZWYyWVU1Snhucmhrb1VJb3RVNTNvaGd4dEVRNWQwSnlJQzlvRS96?=
 =?utf-8?B?NFdueVEzRVY4STJwVnBhalVDVXo4b3poUHhjWS9aQlJHV0MwSlJKYVJITk1q?=
 =?utf-8?B?Q3ZzaEE5b0JWdGJRWDN0MEhoYmxpcXN1c05NYlVER2hBOHZqZ1RHTzhCNG4r?=
 =?utf-8?B?aXVWQzMyUlJIMlV5RFBKcE5JSWxKTXFjQ29zeFlZZVN0bGNNYy8xekYxV1Br?=
 =?utf-8?B?S3JDc1BhZ3ZhUWwwQmp3UGNERlhRYXRVeThPWGp3cUNEQUZvM0JYOXVjVGp3?=
 =?utf-8?B?MzZxQlEwTnZONkQ3ZlNZeDNtV0I2QWg0MjJLaE51RlluVlQ1MDJYdVYxUDNE?=
 =?utf-8?Q?siH//28yJEdXdjq7PTfEOD6NmtEF2hM2wt7v8UfB3Cwg=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4ea85d-d257-4054-9683-08ddc769cdaa
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 08:45:39.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P250MB0604

--1851393-29647-1753001138=:22940
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Sat, 19 Jul 2025, Johannes Schindelin wrote:

> Hi Ezekiel,
> pleasure to make your acquaintance!
>
> On Thu, 17 Jul 2025, Ezekiel Newren via GitGitGadget wrote:
>
>> 1. Windows fails to build. I don’t know which rust toolchain is even
>>    correct for this or if multiple are needed.  Example failed build:
>>    https://github.com/git/git/actions/runs/16353209191
>
> There are a couple of problems, not just one. Here are the patches that I
> would like to ask you to take custody of (for your convenience, I have
> pushed them to https://github.com/dscho/git as the `xdiff_rust_speedup`
> branch). Please find them below. They _just_ fix the build, but the tests
> with win+Meson still fail (and as "win+Meson test" jobs keep the logs of
> the failed tests a well-guarded secret, due to time constraints I have to
> stop looking into this for now).
>
> Thank you for working on this,
> Johannes
>
> -- snipsnap --
> From 72c50ee3f9df5ccfe48bf6f44b2c6bba05a680bf Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Sat, 19 Jul 2025 21:24:07 +0200
> Subject: [PATCH 1/3] Do support Windows again after requiring Rust
>
> By default, Rust wants to build MS Visual C-compatible libraries on
> Windows, because that is _the_ native C compiler.
>
> Git is historically lacking in its MSVC support, and the official Git
> for Windows versions are built using GCC instead. As a consequence, a
> (subset of a) GCC toolchain is installed as part of the `windows-build`
> job of every CI build.
>
> Naturally, this requires adjustments in how Rust is called, most
> importantly it requires installing support for a GCC-compatible build
> target.
>
> Let's make the necessary adjustment both in the CI-specific code that
> installs Rust as well as in the Windows-specific configuration in
> `config.mak.uname`.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> ci/install-rust.sh | 3 +++
> config.mak.uname   | 9 +++++++++
> 2 files changed, 12 insertions(+)
>
> diff --git a/ci/install-rust.sh b/ci/install-rust.sh
> index 141ceddb17cfe..c22baa629ceb7 100644
> --- a/ci/install-rust.sh
> +++ b/ci/install-rust.sh
> @@ -28,6 +28,9 @@ if [ "$BITNESS" = "32" ]; then
>   $CARGO_HOME/bin/rustup default --force-non-host $RUST_VERSION || exit $?
> else
>   $CARGO_HOME/bin/rustup default $RUST_VERSION || exit $?
> +  if [ "$CI_OS_NAME" = "windows" ]; then
> +    $CARGO_HOME/bin/rustup target add x86_64-pc-windows-gnu || exit $?
> +  fi
> fi
>
> . $CARGO_HOME/env
> diff --git a/config.mak.uname b/config.mak.uname
> index 3e26bb074a4b5..fbe7cebf40edd 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -727,19 +727,28 @@ ifeq ($(uname_S),MINGW)
> 		prefix = /mingw32
> 		HOST_CPU = i686
> 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,_mainCRTStartup
> +		CARGO_BUILD_TARGET = i686-pc-windows-gnu

While i686-pc-windows-gnu is fine for CI, it would mean we'd have to bump 
our supported Windows version up to Windows 10. If we want to keep 
supporting Windows 8.1, we'll need i686-win7-windows-gnu, at least on rust 
1.78 and newer.[1][2] We'd probably build Windows versions on rust 1.88 
currently.[3]

[1] https://blog.rust-lang.org/2024/02/26/Windows-7/
[2] https://doc.rust-lang.org/rustc/platform-support/win7-windows-gnu.html
[3] https://packages.msys2.org/base/mingw-w64-rust

>         endif
>         ifeq (MINGW64,$(MSYSTEM))
> 		prefix = /mingw64
> 		HOST_CPU = x86_64
> 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
> +		CARGO_BUILD_TARGET = x86_64-pc-windows-gnu

For x86_64 we'llprobably  also want x86_64-win7-windows-gnu if we want to 
keep Windows 8.1 support.

>         else ifeq (CLANGARM64,$(MSYSTEM))
> 		prefix = /clangarm64
> 		HOST_CPU = aarch64
> 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
> +		CARGO_BUILD_TARGET = aarch64-pc-windows-gnu

Are we sure this target currently exists? It's at least undocumented.[4] I 
think we might want aarch64-pc-windows-gnullvm for CLANGARM64, either 
way.[5]

[4] https://doc.rust-lang.org/rustc/platform-support/windows-gnu.html
[5] https://doc.rust-lang.org/rustc/platform-support/windows-gnullvm.html

Best regards

Matthias

>         else
> 		COMPAT_CFLAGS += -D_USE_32BIT_TIME_T
> 		BASIC_LDFLAGS += -Wl,--large-address-aware
>         endif
> +
> +	export CARGO_BUILD_TARGET
> +	RUST_TARGET_DIR = rust/target/$(CARGO_BUILD_TARGET)/$(RUST_BUILD_MODE)
> +	# Unfortunately now needed because of Rust
> +	EXTLIBS += -luserenv
> +
> 	CC = gcc
> 	COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
> 		-fstack-protector-strong
> -- 
> 2.50.1.windows.1
>
>
> From ef6e4394ae26d8f28cb0d9e456810ce0818e623b Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Sat, 19 Jul 2025 23:08:11 +0200
> Subject: [PATCH 2/3] win+Meson: allow for xdiff to be compiled with MSVC
>
> The `build_rust.sh` script is quite opinionated about the naming scheme
> of the C compiler: It assumes that the xdiff library file will be named
> `libxdiff.a`.
>
> However, MS Visual C generates `xdiff.lib` files instead; This naming
> scheme has been in use in a very, very long time.
>
> Let's allow for that.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> build_rust.sh |  7 ++++++-
> meson.build   | 12 +++++++++---
> 2 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/build_rust.sh b/build_rust.sh
> index 4c12135cd2050..694d48d857a58 100755
> --- a/build_rust.sh
> +++ b/build_rust.sh
> @@ -44,7 +44,12 @@ fi
>
> cd $dir_rust && cargo clean && pwd && cargo build -p $crate $rust_args; cd ..
>
> -libfile="lib${crate}.a"
> +if grep x86_64-pc-windows-msvc rust/target/.rustc_info.json
> +then
> +  libfile="${crate}.lib"
> +else
> +  libfile="lib${crate}.a"
> +fi
> dst=$dir_build/$libfile
>
> if [ "$dir_git_root" != "$dir_build" ]; then
> diff --git a/meson.build b/meson.build
> index 047d7e5b66306..5e89a5dd0e00f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -277,8 +277,16 @@ else
>   rustflags = '-Aunused_imports -Adead_code -C debuginfo=2 -C opt-level=1 -C force-frame-pointers=yes'
> endif
>
> +compiler = meson.get_compiler('c')
> +
> +if compiler.get_id() == 'msvc'
> +  xdiff_lib_filename = 'xdiff.lib'
> +else
> +  xdiff_lib_filename = 'libxdiff.a'
> +endif
> +
> rust_build_xdiff = custom_target('rust_build_xdiff',
> -  output: 'libxdiff.a',
> +  output: xdiff_lib_filename,
>   build_by_default: true,
>   build_always_stale: true,
>   command: [
> @@ -288,8 +296,6 @@ rust_build_xdiff = custom_target('rust_build_xdiff',
>   install: false,
> )
>
> -compiler = meson.get_compiler('c')
> -
> libgit_sources = [
>   'abspath.c',
>   'add-interactive.c',
> -- 
> 2.50.1.windows.1
>
>
> From 9c3b017cfa069211027fbb1f6d3b97c8e7edda81 Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Sat, 19 Jul 2025 23:22:57 +0200
> Subject: [PATCH 3/3] win+Meson: do allow linking with the Rust-built xdiff
>
> When linking against the Rust-built `xdiff`, there is now a new required
> dependency: Without _also_ linking to the system library `userenv`, the
> compile would fail with this error message:
>
>  xdiff.lib(std-c85e9beb7923f636.std.df32d1bc89881d89-cgu.0.rcgu.o) :
>  error LNK2019: unresolved external symbol __imp_GetUserProfileDirectoryW
>  referenced in function _ZN3std3env8home_dir17hfd1c3b6676cd78f6E
>
> Therefore, just like we do in case of Makefile-based builds on Windows,
> we now also link to that library when building with Meson.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> meson.build | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/meson.build b/meson.build
> index 5e89a5dd0e00f..af015f04763fd 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1260,6 +1260,7 @@ elif host_machine.system() == 'windows'
>   ]
>
>   libgit_dependencies += compiler.find_library('ntdll')
> +  libgit_dependencies += compiler.find_library('userenv')
>   libgit_include_directories += 'compat/win32'
>   if compiler.get_id() == 'msvc'
>     libgit_include_directories += 'compat/vcbuild/include'
> -- 
> 2.50.1.windows.1
>
--1851393-29647-1753001138=:22940--
