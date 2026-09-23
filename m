Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012054.outbound.protection.outlook.com [52.103.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2B939EF1F
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 03:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132896; cv=fail; b=f5Gf/iURZ7ZGzONeAxGwvcocIokM2yGxhAVMJuyC5SBM+oAaKPH2Ud1cx+oUACa2WiW8kWw8d73UruEHPXTurCQGr8PQuX5k5lxY5zjZhWtMfHV7iJS1BzZGIsgXpJ/1MrjAK2kZ71mVB3EbB5CTKlekhDiz/ZEZBkpwFjSSsEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132896; c=relaxed/simple;
	bh=GwBZwAY1eC+4vPdX59QMSbUnne/QthIBtCfeaH1aiX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HDwbalJdAooAe5xgK04oy44Xe8sVxr94cgCwiU5QD+XovOYbTZ1WcQ5ydWJEPtZlnIlTGynuXqHvbIQl8BovZKeArvoNZORXjMzfmX7IzOVOXirXMFevjAHe7chCORZTqelcwAdZFIfpHY5YQeiTleAbgvTUAAv1atQf/oWfgCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=d1VwFuPN; arc=fail smtp.client-ip=52.103.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="d1VwFuPN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNy0n/SZpI/d0GsakSTTzq50x0rLkjApJc0FfKKFr8YVa5hDj3zsnO/6+dS/7sOng2Bm08bbU2rXZF5ZOs6jrgCgifbuShBzXcI97bNs42oXhrUy775RqiG7a/8nhcpX0AGh7d1GF4RIO9C68LRxDG2QeWPEQc2cpg9KdTTOtq9JmWr3Dw0Up55cfl7pZ/PMHeGnliYvokB43tuQZh/DB1G23c3U6dWEb3+TwR6HqgaVis4gxSl0bd5zvelgLeTRR+n7whu7rkDskQjbA6d5W4R6RrEqDBDqX+NqCOEw1Kum09Q8vOGGJnPMyKwVvwzfMAO/hupD7cw7nve70iZugg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/H246paM7r0b6mB0HJP/eE+eVj5K4mmwGLUW10iZTg=;
 b=hL/QXhHNOfNycMO00ttEvLJHQMjgZMeoyiB+AX9ARRUl78gVIxll6fDyUBnoKVug0xu6vuJIAJqHZ0fS2k9HJQIIrsKxgQAWgMT8VP1kYJAM4fcMK49+0tQgyFdfmTsrQlZrRM6xmSqRCt00GhwkD7SS0leLmo5Mi/Zc9eHyMNJioqrG4MhDlF5zuqVEZQXVQBi0YvcfPFrNt61G8a1tYn/DfYRlWUA4vNJIhutCgPCn+kb8VOBfn4qX7D19Qlvlw0RrIwc+FpX8QaT/rkN/efaqPwhxYjQnDI0fEqWJA5Z+41rRYI5EoY4H11CrbKiylnL9ZryUgCBSeJ8SLF40cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/H246paM7r0b6mB0HJP/eE+eVj5K4mmwGLUW10iZTg=;
 b=d1VwFuPNTlnfID8paiWKD6H0/J0jbnOIfHKm3e+NaSK3UnccwyOJ318ZhWlX5FuOUFj75Sh+G1rWFcljPjI+CKDTzuADbC8rYPVMpJ/WrtAll9KkpC2+zFW7nU2x/tHxt9LPkVilOllK1xw9lKbdiBumihfXzQbRTEuHqmh2DLmf7pmd2nE795APymjxsFDDNstwbMVHGwuqYTm/vKJinaZYMOUoWTCdLbOG4cS4bJ2DpVhoPM6Jw5PI9ar2u/4TjLZ7pQNUgT29jNWttTw39QKk7M+IVuf62Rixpr5LPwjcJZUYBUWA3ggq3FueGwnwm/zVsOwBfi+0TfM7ushoLw==
Received: from SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:43c::20)
 by DM4PR84MB1805.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.13; Wed, 23 Sep 2026 03:08:09 +0000
Received: from SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e4da:bb3d:c38e:1b33]) by SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e4da:bb3d:c38e:1b33%5]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 03:08:09 +0000
From: Qin ShiCheng <qeesung@live.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <ttaylorr@openai.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 2/5] pack-objects: reset kept-pack cache for cruft walk
Date: Wed, 23 Sep 2026 11:08:00 +0800
Message-ID:
 <SJ0PR84MB2993BE38DCAD2ECA5159EC24DD822@SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.5.22.ge710c7d180.bgit.1.11.0
In-Reply-To: <xmqqjyocdijn.fsf@gitster.g>
References: <pull.2219.v2.git.1789700615.gitgitgadget@gmail.com> <77aec8941f5d17654f58956c7c643b47dd5a8d93.1789700615.git.gitgitgadget@gmail.com> <xmqqjyocdijn.fsf@gitster.g>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0045.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::6)
 To SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:43c::20)
X-Microsoft-Original-Message-ID: <20260923030800.52569-1-qeesung@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR84MB2993:EE_|DM4PR84MB1805:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bbe2dc5-6912-49ba-0972-08df191fe4d9
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrO+2YmbT5jW+WUSUt4IT5vR/cNygAe6r/lSq8csyguTHo8gyeV+ukw/hjHibXcbBBkFmB9SlZMhGq3R+zo/HSCGzszSa4Yf4DfWTXPLa+1Tn9eQKzdxY71Kcnf/bgb6sp288KI35Z/Rt8izO3Z1H/8qvK9HR+UviMW5gWZkPuZDGjaDiJrkgDufxRGkGws1KiB02QvT3HQY+8LZS3Q/dPvd5CAzt2F8j4kFuJTucfwUE8GsIKEqf7ynOtRI4dstUs6Ln0onFsBNy0F4bqFHxN2jGM34YKqJ3ex4wRl65lRn4Z86Ris7lyyInADilIiJRRqBBLG0hxkzKaLj/WLnDBMql2gKUlo9Ugaj3A/QFFYPq6lX4xWpmLX4i9r1BOj1bWPfgxC9MBOhTu80nFntTiPA74f/3BeHnQSeta108UnMBXU0Eibf+1SZPPm1Uc/T5IAVi+Ak/J0Yq5fUeFJQ0L4MA6vxT61GkjzegOUzD8whxeViR+G9BM08YVjzdykgS9IU/D+sqsFAtihJu+6uJpiIb4jcIZgzN/ye288drV32qtEI1h8MBxpT+mtoDchY0Lix0UaF72ZR1xtEuWe3TSMIrrAT93/s4UBnABeTSpl2WfyYUQOqlrwuwiyaOyx0oSLOLKlBvzSa06kbU7t0O+6dc0MnYyKUjHO3kmGHY57UFuKz1yxlnwPzKGm6M8EPSi238V+mqVkAJuZHKm0GEiy10ETkuG7V/sHyrb3rLguEQqt0X2e9pjg6JB/BNgy+nd8=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|21061999006|5072599009|8060799015|24021099003|19110799012|23021999003|25010399006|51005399006|3412199025|440099028|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4FvCSJe/ZufEl9MCce4qWEwjHlXppisa/2CGmFCWGKuz1syq8fMMpBG6V0T0?=
 =?us-ascii?Q?NCq5qC87+xQ8Fq7mfmEKo2BNvncwKlb4UrBkoVU+fY1bxjVdgcuja1h0E87x?=
 =?us-ascii?Q?itaaMsGBVoAD2XvY/Zp7YAWtszqNLbYCgFRQG1vBmxLSxkKF/OYWfOHiU4LP?=
 =?us-ascii?Q?LSLA3ijP0KhXX3OnOU6S6fhCHO82step1K5x0gR/R54YbBoc6dlJ1v9hoPtI?=
 =?us-ascii?Q?hLf3r5qfFSPJJHsGgtBTXoCtsOdSitc3tNo3M4d+J6rxNlp9tI7X9yUGMN+y?=
 =?us-ascii?Q?fQIJUFsQVkXAyFxb8HXwbc2dnBvYeF/gIhzkaZbSdv9n1DIhQi683Ko81WFn?=
 =?us-ascii?Q?6nPHGRv5m6BpL4VERaBTdJ4aUCg5V1MUGFSLaTPcU05GprpzEGl6DsHOaCL8?=
 =?us-ascii?Q?xbu9US3mMlhOizwedXbULa7d5tE/vsFq0s2JlKba2sDXIAs2XuiF/HSPK5ER?=
 =?us-ascii?Q?UywP49mq7g4yYkZEG/J7CAz1KE103IatfYS4czGkriEUFlyzlNGJRvSwinYB?=
 =?us-ascii?Q?o0z681QYEpbsmu2M3u0G3fFdrhKnCndMpfVG+FUjmSZYajurOhwdkZlvwLAO?=
 =?us-ascii?Q?EAjDtOQRkrtKBY9rXAVg3CWFo0+W6/EI78ZX3ktplXoA5geQI9rGVmv4I0lD?=
 =?us-ascii?Q?qjSATWj9GBd/l3cFH2yHIJr1cdG4atZsNIrB/t6whSyCQAjy/d0QwYpAsiR6?=
 =?us-ascii?Q?80PzBioODlHGbDwFQkYzWHk6CFV8wUFQ/8Jx0MKp2LFDMEMcT5CA1BxdcCCE?=
 =?us-ascii?Q?lW97xAICqg3e9vYHb6/P5zEHH0W/B2QuXEMKCx0VdxnfWzdo0Y4n3F/bjA7/?=
 =?us-ascii?Q?UeZHAC670ih13Q87FIxBYSeKknjLgLnVthiAXZXaGZ1hRVHHrnOhGcqcZ6km?=
 =?us-ascii?Q?O4+FtP+swCc95ugDA3Wu9w31QH+QJXINkqUawUB3XZQNu/PCkDY8Y7+7T5l1?=
 =?us-ascii?Q?WTORa3Erc88gYPZsdn3Giw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6pvudAlrBSamYsAXqgNAhFMYrx/NT7jiTwdTu1bILp755EuQ9LU+v92lvgDL?=
 =?us-ascii?Q?pHpjRgg3XW4AL5TV24mItcSZ0YqaAHsF18rA3NNAdJy+FJo+ZFg/E3R+WQk2?=
 =?us-ascii?Q?6kFlMZKDrj17PM2IK+V3EYKP8Q1ix5rhPbmEabkOAupxYl7djXNrz5qt1CMd?=
 =?us-ascii?Q?wR+n/XXxFP+RrUEp+D4/4Q1c/spjlFQDaNW2qeIjPOL2+09oJDrQmnbpw0lo?=
 =?us-ascii?Q?+BQ/Psd183CA8hBRwJ8UKV2mbk08HfuPdsvFYuhsuliAC+YvxgXO3E0UqVhN?=
 =?us-ascii?Q?Dl6mrltRzaBkP+yhevkwo63i57GB8BD7M4M3apK5vQB/HrnGahJDkHNRInjO?=
 =?us-ascii?Q?2n1xciXKyyNEcAEMkmV3irhfXg58x/O9/tZL1LGF3hJddVX/n+iJzpp3e1Bm?=
 =?us-ascii?Q?HHhCeTcC5kQASxQE7HQP72VuvZm8oLzVeBunMTkUdsLP7GBYSPy8nugvbLCu?=
 =?us-ascii?Q?8Ba/vcCiwQyT6tU2Onay3tqWRAHmvvO6S0pZ+LoI4f4VD4QRd4pMzZYTtdNS?=
 =?us-ascii?Q?QfLyJsWk43cR9Q0BtcSmlq5naexr4d6wBkQ7DiSwEFsXUMD+cDLqEG5NISuB?=
 =?us-ascii?Q?ByhKL00j+9C00z12EhtLOC/2H0C7WtfVPp1evMVCdswg/zAdYAsif5hLulTi?=
 =?us-ascii?Q?6dkdW1nEQR03kVp94diHt+S79eFbY7aQ3nVrqBQnGpk3HqkyrHaifNnfCSnR?=
 =?us-ascii?Q?cFnQ3R8GT/vhENMbxeOXwKXtQIDceDYd8zhZoZxJyQFoAsnLgr7BZV6N4cpS?=
 =?us-ascii?Q?Fnvl61FcPVHVw9PwgcwP8nH40hUp+1C9ih/MsWFYsF8+yHnCAnOLmvJ0OjyE?=
 =?us-ascii?Q?RGQCNFhgDgV0Sh122tQAy62QtNKDDzcMFOkj6DXAZuWfD/oz688JQj+1/gRL?=
 =?us-ascii?Q?2esdJrFwmgsUKhznjYL6eCfqv302cMUeGhmueuMKBd8iSihhHxUFlPTbX56i?=
 =?us-ascii?Q?9myalPZ/w/2FOBRdtXy3iifhNCa1p9eD6LODvlZnUpnIrLTSjPD+v2z14m67?=
 =?us-ascii?Q?69To/ITGH59228nEafohVmqvK9ShVSTeDLmk+5WCdp46Dg7OWIvFVZz3LC0A?=
 =?us-ascii?Q?ta6xh7n5XNCdP210uVItRiZiZk4FrW6aUEsWhvnoy8d+H74V4YZgMl2BMnwl?=
 =?us-ascii?Q?Z8eVsArmm4MGwakjqvGmwNDpxqQjuc72gWLcnyHlEMGPeOqpwC5HHORFJ5Ar?=
 =?us-ascii?Q?O7cBf4DjriUdcZcPbUaY/uwZJi7ZSEvSJwhxkg0EkTjw3rK6lr4AMWmVV5Vx?=
 =?us-ascii?Q?PJjLwuB9oXa/CLAXLvQh3m3DkZFlf14wDZrVF3lOzFiy5T3BtPlw/IOYbEg7?=
 =?us-ascii?Q?qE+LlnS0+0KWyhHCHZvPo6SIkeSbF16DwWCwo1NCoquxFrQ3erhLirPWJZ24?=
 =?us-ascii?Q?vNfnCL4/WgcBDz4aQzkrxyfHF/6p?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-4a72f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbe2dc5-6912-49ba-0972-08df191fe4d9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 03:08:08.9475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1805

Junio C Hamano <gitster@pobox.com> writes:

> When downcasting finds that 'source' is not from the files backend,
> we immediately hit BUG().  Is checking the type of 'source' first
> and calling packfile_store_invalidate_kept_pack_cache() only when
> it is from the files backend a sensible workaround?  That sounds
> like a blatant layering violation.

Agreed, and I would rather not have pack-objects look at the type of
a source at all.

The assumption is already made two lines above the new loop, though:
repo_for_each_pack() downcasts every source in the same way, and so
does has_object_kept_pack(), which is what reads this cache in the
first place. So the loop is not wrong so much as in the wrong place.
It belongs next to its reader in packfile.c, not in the builtin.

For v3 I have this instead:

	void repo_invalidate_kept_pack_caches(struct repository *r)
	{
		struct odb_source *source;

		for (source = r->objects->sources; source; source = source->next) {
			struct odb_source_files *files = odb_source_files_downcast(source);
			invalidate_kept_pack_cache(files->packed);
		}
	}

with the per-store function made static again, and the caller in
pack-objects reduced to

	mark_pack_kept_in_core(fresh_packs, 1);
	repo_invalidate_kept_pack_caches(the_repository);

This does not make the code work with another backend -- nothing
around it would either -- but pack-objects no longer gains a new
dependency on the files backend, and the downcast sits with the
others that will have to move together.

> Do we need a similar
> rearchitecting of the code here, pushing details like packfile
> management down to the files backend layer, before we can properly
> fix this?

I hope not. Without this patch, a cruft repack with an expiration
drops objects that are only reachable through a pack pack-objects was
not told about; the new test in t5329 shows it happening today. When
packfile management does move down to the files backend, this
function should go along with has_object_kept_pack(), and nothing in
the fix depends on where they end up. Patrick may well know better
how that is meant to look.

Thanks,
Qin
