Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010015.outbound.protection.outlook.com [52.103.73.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7D2248A5
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906867; cv=fail; b=CwnUMRFaYc6BX74WS8KDFTRkvulbgIQc/tcA0Yoa6kqNPqIdDWC4xjI/0ToZBac0ro7L62LORu6LyoTVEFrA1tRwUn8XWthCMJx4FSCL52RfCT5rzR/UIMmluN2Gr7IDPSxzjIoikFgaE3n9PbDofdXxlgvubE7LyfMAGPz8ArE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906867; c=relaxed/simple;
	bh=lXJR5dwMDip6KEo3VDMpAsiBj+bxmNauOMXMddZyfY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EFtxMFQt+3SwasauWLCnIVMAEasZckc3+Ofs3kKKvcqZJY4bAe+QnK8Wtiuuv7cYdhjm34IpkACj1YCr6ZQMZBaLWdycXD/oQPOdwoyjZWg9pxrjw7u4UCvBTAHnGQFOCoKPeh2gFfLBA2sCovM8wZ8EWVbpEdu+X8uq2wJtkPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Ms816nuM; arc=fail smtp.client-ip=52.103.73.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Ms816nuM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIrns+Nz+18193oyhx19vU581qm1ZU8DOw5uha4/s4PU5+r5GT4Ye6gTPo8RyzSsYmb4l+2aH8bJbJLXuYTgKW5ycclVyv3cmg4ZALJsm0DYGFxP75ttj7JlxdTcvQlUtsQzz09QByjsshm/rw3LO8MG3KMf7ZJV6yXcApWLj4MdmbazSVk4ilVIdTlpK11pMTAxOTBsbv/F04OSeExpqX80XZEDtvX640oRzOqhP/AVoNMSY4WT/tP19yWP8gGndWVQJPdRUb0fP5/dZFT0IR0IE0vBK81zlEYq6WSgZlDenXi0nn9B4f8l8CLnE7WMqwxZhRat27H/VgUiytmvmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qbxpbg/RnMu1z1koqdohrNoVX1/0GLVHnnY/WO37TaA=;
 b=gCHeitGKT5Htk+xfwpo/fG5iOFYSTfS2FODejyJRbBtGRRdeCLFLamWDPcDiIk8xuTFzY+X4WxnoECmMnveqPeTnSKP8wVTanjt28TOUS2V4ELYRZVUDi7RLsbfRpkha31QKwtgISqUMBWM1hTzhu0rqjrbHZqX942B45TZAJl5SblDjr792P/lij6kpeGwMjPjv8e01PnaW4Grs6wk55pqL9EP8syEZytTle9bkHAtxT2zAbTR55C0YzrcoCmPrkynmmgemva0Hj8v5losqxxP2/ucgOaSQm2KgkxbEQM8MVsy7+necCyovl803DvyU45zpwYTMIMNMASteuIQgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qbxpbg/RnMu1z1koqdohrNoVX1/0GLVHnnY/WO37TaA=;
 b=Ms816nuMRypF6sllQMkAHdDT8LngvmmE8IWZZeMkb0+qyKp6Nt9MgYELXIsz6GOJk1C7Xv7kAW4/CiJecoUCBQAv+Z48mPVurkl6JIWkDspRX5Wxf3GRufGqxKG9fHgCzU8zHo+9ae7PmmrfJomWc0CNQsjFNvNbF0tHQntDGR7TKBSZafE0ihOaQFo31ARTniMT1+q31gJ/g5x88Klddd0AaBVHpWg8vbev/f5t2EJ2dpwsk7qFCMX7UQZNYof/0hTbZN9eX+BKePL1ECYmKQyU9sAwCqDI/XeKNvfZM3awdXHNGtT6Kd5H+do2Fwxqyk3cShSl6+DWmGYCv5arSQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB0258.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:238::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 01:14:20 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 01:14:20 +0000
Date: Thu, 23 Apr 2026 10:14:13 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 00/10] parseopt: add subcommand autocorrection
Message-ID:
 <SY0P300MB08012E039329CC8EF7C3EB92CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqqwlxyo7w6.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwlxyo7w6.fsf@gitster.g>
X-ClientProxiedBy: TYCP286CA0014.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::8) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <aelyZd7pMqTj9vkE@raider.node>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY7P300MB0258:EE_
X-MS-Office365-Filtering-Correlation-Id: aff8d452-30ed-4d33-1ec8-08dea0d5a54e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|5072599009|15080799012|25031999004|8060799015|24021099003|19110799012|6090799003|55001999006|51005399006|461199028|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZfE0A+zZcIZbjQJ3xQXBhPajVDg/QRjjIVxMOTX/U4RqUg3KhZlWmYKDJuwO?=
 =?us-ascii?Q?N4lxlO/8W869CvAA+i9eLV/CSrLIvci7aBx4Z6G0ghUz0i6mVlBgdYzgk6sY?=
 =?us-ascii?Q?weImCJUE9hYX2Vv8vS2gjEKpCI6LEkhxuGDfgO3QEsLWr5HkeFDXPjqCmOag?=
 =?us-ascii?Q?2QQ/u8OAeKmdFp3slz3dWHn6ZKyeU7vBREdckXiHz/Dvoa5pl5xE4WVDkIjf?=
 =?us-ascii?Q?FUyONaKlzKq5aHUM7jRKWgQ9R+iR6pdKJdPMWsZZ+02EYcArPbSzH/HSr38p?=
 =?us-ascii?Q?4W9oei4YzfOsCZpWMaISB2jo5yVAMGYhi81axju1YrXyQVLAG3HZR94SLaBW?=
 =?us-ascii?Q?Xd00Ufq9RUTIiimyWtx1LScxtjp3ZOU/GL6WnS1lQAdv7YEPHEmBx5cQinqv?=
 =?us-ascii?Q?333c5qKfwBQoKPMR4jHf7ET+xJElezcpRIsaXiNLPS5jKNDjwuPd6O9ymdra?=
 =?us-ascii?Q?EV+LfHVGuTCpvAE383i3634gPxbvc4yGkl+SoNYkSAn3miBfvg0/W8tAA5dt?=
 =?us-ascii?Q?cbdFalPMTr/s6VfLlOK2imMuk1kxmrjMQQ+8WzzVt5IEhE0WcQ6f43WISQeT?=
 =?us-ascii?Q?WXwJAgDrIXwuw/4s5bWEyHgkj02WITuE9l3Mt0djqqOlnNQ6TZP65EIDKde8?=
 =?us-ascii?Q?HRwqQXvRyprd3b26zIIv/8S1wL6ogXQdS+c+/SCeFqCZflJxm2k9W/1eReer?=
 =?us-ascii?Q?oZMXJi5vb0syhv4k6do+MJ6ORKD9qot0l/lKXdXqrb2HRLnJ6MGcZ3DlvALS?=
 =?us-ascii?Q?gFT2m/02dSwULt8gd7aMWiSxSmFeza0cD8istvijJvxpjqhxE5qGNJAyD+8c?=
 =?us-ascii?Q?S5WB71k1sOjvIRKvCuWl8VPV0guQ/frM0MvwIcYfumcJfkY3NcqH9Vt1r7Mt?=
 =?us-ascii?Q?4KMuwQp1ZVhQ1z7flYrA1XIBqKDoHfa0OF8y5O5wPjuxLVGxmbTdxGlkIOE3?=
 =?us-ascii?Q?lr+Yib1bm8Pz8TyGDG6PaIPoP8UNeVPWOisOQfCeed4XriQPGrCyI67uFyG7?=
 =?us-ascii?Q?883AvOG3QZIOK8/nEyQkZdToqA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ayN2jAFdhtH2B03FP1zaVu3WeKRtCDaBzRR7kdMuyzeNARnbVDD94h+HYRbg?=
 =?us-ascii?Q?x6fp7n8p5DkcXL7xWliPylMSy45UzpnMr+vF8zkbMKTT1i+13ldZHvF3C04Z?=
 =?us-ascii?Q?VZUZGscURwxzRz8kjxNHZC1ZMoSZsutT1P+yZPItq+uSZ409t0lINpLBRAYa?=
 =?us-ascii?Q?K3oor8nzpxdT1jFZA+AWQqY9KJwk/QMC6gfeRz9p2TQGcNxjEJ+Rk5bQsrff?=
 =?us-ascii?Q?BxJuB4wii22BV547/E8RzaDk4fzST/+kWoKEC1moMP3AXUCzobBJk75fpEOI?=
 =?us-ascii?Q?ovBfaRnwIn1jtIqlxrvL6nwK3Ese44+VR3VdXjSC/9dNnu63e/4VfOh88fUT?=
 =?us-ascii?Q?fyLaJeZPWdfcu/H1oU+HbGpZnqwFuWXL29EaOeCpeghs2RvAL7U5HlHfJh6e?=
 =?us-ascii?Q?XUcia+vwafVfOoSC2vyLIctwtF5WJlJienQ08vXBVzL83M+t1zFi9tgCWFSv?=
 =?us-ascii?Q?MpJQQKm/MpS4tRw7IvGPShxd9VD/AKxW5zAQ2Q+hsEORozfJf7/HgEi79DCN?=
 =?us-ascii?Q?9L5y9ceo5rE4VenlJ3JsKNJFGrS3GggbdeHvO2Akl/Q+5guecs6ZIqgl49wk?=
 =?us-ascii?Q?PbFsX268O1dMfBcUM20DMbjATA8OUgkAQVXlCIoJ6RXEuq5fnVn3Z19wy7cp?=
 =?us-ascii?Q?cG3AnTYjXptLlznEeWqy+KizEB5O0hyOERSyjTSZyaJR9VKVNtO4AowmgbAR?=
 =?us-ascii?Q?O6vX1n+c0X5Qi5PoYNeez3dMDVjO3v8cNgIstW/JWVQJsI54Y3YBJMlBDuhI?=
 =?us-ascii?Q?2UPrfOo+Ozg+QDXJ/njFX7gyIl5G0hMmvgLs68aIb9BFYhj1KNp4i9+fRUdN?=
 =?us-ascii?Q?DBCH9JfEXfjEXUffJsOOTfb2OrPWBdw97vKhKfe85Rff+AleZCdWh/3mLqo/?=
 =?us-ascii?Q?sZ2Mxk1+VnxtIcjK5OoFD9POFT015y+ieI3PzBRIz1y8eNOOAnyv3ChEDPcG?=
 =?us-ascii?Q?+QJDt7GulGkFw86AacPfWFLy/A4EnXP5X2bZYebV83q7RKuaOU1rbDdZ9IdO?=
 =?us-ascii?Q?ZuTm9dzhwGvN/hAsEzfQWC2c7JZ6q+8nwtMN5CDzrobhOvHxooWrJ4AwuYES?=
 =?us-ascii?Q?S4luZkPH53X6h2Sa6rk/DK1TLIe5xqJEJUT80GJRWuVWrp4MkSxf+UUXRdrc?=
 =?us-ascii?Q?RWOoxvaXXp7U+ewkZIkE5gxIWeUepvazncMw2oX6Wh9TzpGmjkYj6LkKF737?=
 =?us-ascii?Q?fe9sSgKSk+MfgIHpV63iBPZt7Q6IqUkxQK8OLVRdSHpKVm8FPLd3OPR18Bqy?=
 =?us-ascii?Q?M+5lPB8OIqrSqe3ajuR1yluDsao7Q7QF0+c6TXFr7I65LDcXzf71LaUAQKFk?=
 =?us-ascii?Q?+L1AZVgulRPZzUqfcFo5m5wHedrjzDW+PqqPXDnx99zokfRSvdZ9EMAnB3T7?=
 =?us-ascii?Q?wckS48L5Jg328nlv2S3mv8wN8qFA?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff8d452-30ed-4d33-1ec8-08dea0d5a54e
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:14:20.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0258

On Wed, Apr 22, 2026 at 05:08:41PM -0700, Junio C Hamano wrote:
> It seems that the exit status of some error path (subcommand parse
> failure, presumably) has changed unexpectedly?  As I am mostly
> offline for this and next week, I didn't dig any further.

My fault, forgot to adjust these tests. Since subcommand parser learned
to autocorrect misspelled names,

> t0040-parse-options.sh (Wstat: 256 (exited 1) Tests: 94 Failed: 1)

	test-tool parse-subcommand cmd subcmd-o

in "subcommand - subcommands cannot be abbreviated" test now shows
similar subcommands.

> t7900-maintenance.sh  (Wstat: 256 (exited 1) Tests: 72 Failed: 1)

	git maintenance barf

in "help text" test now corrects "barf" to "start".

After fixing these two, all tests pass.

----
All tests successful.
Files=1043, Tests=33202, 465 wallclock secs
( 7.02 usr  2.23 sys + 1244.78 cusr 1642.22 csys = 2896.25 CPU)
Result: PASS

Also, I found most error paths exit with 129 in parse-options.c, but
the similar subcommand hint exits with 1. That's inconsistent, will
change the exit code to 129.

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
