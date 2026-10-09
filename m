Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012036.outbound.protection.outlook.com [52.103.23.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A2733B975
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791515257; cv=fail; b=Yt/d95n9gg/tnWjbkcoyapc5qk/rNr8mP6RpFijTOFBF3u+abG/X/m/g3/SrfjCF1XLCr1r8iYCTCMCOd8+fq89OFVb0iSJnELWIYXOKftUvnC0Ln2NfO/6EdOwHY5wORiFXFjoKwc5WxUOHV8ehlpRej0w3lgE/jT3WA15Ue/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791515257; c=relaxed/simple;
	bh=fkFDCze5KqYqZ2fg4Osi27Z/yuqpXjjcDvBcivfOkCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vFN5OBdtP1OEnLItzgSln1Iza7NBg8mHImFQpQFBh33lnyPHds2RKhJTQ1pnJi7OQAsveUoLo5POXI7K1Z4RsiyIOmghmgTKp0enaUIe+E4EeHWq9pHFHd3UzGCZvom1I9PjQKRT1pyAtVsC3J7JkKjC09XOfsLbfr2CoXsfZWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=NzQAkryn; arc=fail smtp.client-ip=52.103.23.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="NzQAkryn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ao/JECgDPpWxiice40SXmhxINVpFwvDmNXOELCNEwjk/hLqiQ0GZUKh2HsjPWz5w5JYBV4N6nGPDDbfToGDBRtbUaUHM7Iiy3N13EuL2WHrc9xQKAAhUm9TcgX+tILSdcea+yRsayF4XjLFzTd4hTGBcWYf/4zIl44UyQVWMFfxBRJ91LA9f8OlK2+DmAm91IceXgwhA/b26ONFKRkDS4XuWoaGvjy5UDttbaZeXUnI624URrR/xfzzxb92kQPzvTD2Ee58/kT8qyaPNSHLwOHBTHT1SY53MwfaXjTh5W3gbelu2ICXNccjwVJHi8pRbjevzYy0+KYNFpjRdraidzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMYeSCPPOfwXaacpNidLzKoI20H4ofX3XsC2sGWDecY=;
 b=sEiIAu1+K8IIkGyPv2lAK3MXLFUJ51g1o3ArMGIXEaTrd0gkQTD56MnqiNa5rAuDvk/YWyDuxH9vTjc+jwywBtqpsriuzcF5STEm8ZwyrJvNUX0ieIFWwQHE8sMP9o3aZOj8H5gdTYQMslSbQghVz23G+fXmFJD3j2Nax92Omcum6xsTxlhrPJSGr2i4J9jOFjTh58gdV49zeyCI/VBIwgbD1PmIol9/3ScF72Uh/qlDq186qVHHTZ4GozD/Rc+w4g9AuMQDMqFFUzGlVm/bv0JyRpULvNAQAK9X/atAL02nh7YFFzXMd4MK1NC5UINamPBMpeOTTw8gl+UDNv9Ltw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMYeSCPPOfwXaacpNidLzKoI20H4ofX3XsC2sGWDecY=;
 b=NzQAkrynBPi6LC0I8OOHOqeaTHVxtttKwvp4nQTPha8rz6mt/ymJIOHkOp3MOaa8Oec4zJ8VbPIkY3kUqIvELNJR03EwJjvUvKvBNcVB800Uda9mmV7eqYlmEckRGgEr30noK+XEWWuVQs8Wi95HYsFaV9k6/FbhfIXdWsHOMy/IcA6lTQMSrVDri9NarvTpSfR2qQkh6JB+oUCT+ZBaCZh2yS/3xUWJedAuTsNQxKPZVlyNw1oNo077Xzo54X7ZfBHC/YEXtw/oblQvcRjsCe9iWsavp7d0nkhJZt8BQZS+/UoK1lNVxk7p0bcWcMQl7juF6/wVLS+2SmgTAS9uRw==
Received: from SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:43c::20)
 by MW4PR84MB3170.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 9 Oct
 2026 03:07:34 +0000
Received: from SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e4da:bb3d:c38e:1b33]) by SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e4da:bb3d:c38e:1b33%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 03:07:34 +0000
From: Qin ShiCheng <qeesung@live.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <ttaylorr@openai.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 0/5] repack: don't lose objects to a ".keep" that appears mid-run
Date: Fri,  9 Oct 2026 11:07:27 +0800
Message-ID:
 <SJ0PR84MB29933F55E298B09B37F2778EDD922@SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.43.5.22.ge710c7d180.bgit.1.11.0
In-Reply-To: <xmqqv77cyp8u.fsf@gitster.g>
References: <pull.2219.v3.git.1791453141.gitgitgadget@gmail.com> <xmqqv77cyp8u.fsf@gitster.g>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:295::14) To SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:a03:43c::20)
X-Microsoft-Original-Message-ID: <20261009030727.10437-1-qeesung@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR84MB2993:EE_|MW4PR84MB3170:EE_
X-MS-Office365-Filtering-Correlation-Id: c2747f1c-e8a8-4e24-ded5-08df25b276fa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|23021999003|260925184616899003|24021099003|51005399006|15080799012|19110799012|25010399006|8060799015|440099028|3412199025|40105399003|2607281247196008;
X-Microsoft-Antispam-Message-Info:
	Gl3YLRI5VyYEcPz2ornkLuOsLQqsATLGKNuDtHQK3kRRBpYO5Eu2TTT5su/NiVIk2aBMLmV6DNCrd/9XW7+0W23Jw7VrlTt5xSUEn34dhHDy9DpZeXu1BEW58tjx+nFdnq2F/hBEaWM0HkVEtaA7F0F1h0JjEJ5pDA/FJm9pRy1bYmwtHt+nZs1jU50idl8CcWu3cEgmSHTp8U1TR+6aZ26xabZbpr/nFdiUf0sBPly29PKPWeaBSlQATlK1H5yCG7ZZdKAUEFFSdunFtjYmy14fk5NWOG2HfvGLhB9fQWOB/w/dXEK4Z0BZOKRG1z9lqL4e3U3nswsS2eTKMRF6azT69eVrBWN/7fttGogFCLxThSQyiG3UzIIqYP0dMs8US75IICBkvMVz9pm80bBe5dDxE9FaSF88Gdvbs++9UnoxkpwK491r4bxD7Ig2z4/BD3LrzTttwd30At4BfkZyTo8216d2QBwvXWEH8PIMuWDiXK+FOaCC3b27KLEqESPbVSl2piDzBEpvArEOrHi7auLtCKJjqgh9VX/+DnSHfhxDSmULws/WV1hAoXP/YRLkKc7AmbzC1Dey8EiN6Tp4YLRWuOZqDFLUiacfhr9FEWyEHkafQRwR7fsM0l4UStbuyK0jOSdsrRVYN1Y72PZiAo/c9kChbl5vCMDYNEVbqI/FeRDJutA/NnRP+34hQMNhWHnmBBDsmro2Yx2MSxQ4F77sSe6jK0hkf0qiKhe8vuNgw297GSx3+jRqT2l8hDVSMggDcJc5dvqbkZ81KNOOz6AOD4/944/Dnv+2NAzp8Um6Sk3nqiUDzJyMsgkHVkvH0BiFw9aEYwEgglCv90gEFC+KZQ/LlY4US5/xgohoeePhkGuuCUGWI2rIrBTflO2GdpOruosqPQaofblrwSRdo+PZ2gHt9Yo1i9G2wVSrVrPEH/b4f5ph9Q8utong9gJW
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VM5741Mcra0Qw9HhFg9cPDFlknofeHkOnxJQIQXGEyTKfJkfvUdn1bU1ruRx?=
 =?us-ascii?Q?uL1u5uBvGX7GD7b7qvglg/e2tdPsGouRzN9/IIvLLsf0wG4Ta1w0Sji9xMr2?=
 =?us-ascii?Q?aIKOlXGTvNi/yQQ+muxjEP19IiVqrSw/beKJB42TLHdYVWVL4PZ6bmuYU8+y?=
 =?us-ascii?Q?khFoq9cOYvJl70SiwUxc+e+yFz6hqMqXouuB1OY6LNOWWcDC0JYw/O17Xy4h?=
 =?us-ascii?Q?/OsplV8vBj6opIDYCkCHMRE9E/lnfZGypsRNplUGVt63tOFPIbIYcX7tgubv?=
 =?us-ascii?Q?RsVqwI4LK+wZpimZbBH+sIagEzoSzzUVW7Sd2Xb8H8Aa4S40OKtD8DGHnXq4?=
 =?us-ascii?Q?7SSXmQmNV9U5RWurQFhfx2Wm5JqEzT30mGBVyL9Uf2DZN3acEjfdamC/klCY?=
 =?us-ascii?Q?eHTMIzN2tlKYjGuhwDp85p4Lg1zlOHi3c/zoxlxCPKBOuxkCp761TsyI9F63?=
 =?us-ascii?Q?9z+SZ2zcScF+fFNx1qnszW26OpY7UsLycliqGk+mbf3yGnbcVnE07XzGogaT?=
 =?us-ascii?Q?ddh9bPwrN9WeZGjQY5HJmFP/xcVw2E4GjyYiUwF1HKnF8mFJ2LWxxpeXahN8?=
 =?us-ascii?Q?Sy2OJiSCVzSUN2SJjqq4TzWL70QDr9jKr441K5S7Blsna1ZA7gUMhySNZE1f?=
 =?us-ascii?Q?29bxp4zaX+CPJnDzz94CmTnNjwuX5RvX27pYfdMyzoBS+o6Be/QLnAO6J41q?=
 =?us-ascii?Q?ZLIKVe+QkQGKDekvBvq2SG9NmvbzTNdxFTaE98a86khKXPiyoVXif1nQDMxV?=
 =?us-ascii?Q?y4ckasa/OyE71MbY+FGOhOwJe/g0/4jjoczGujqLuIc9D9PQ76ZcEC5Gcx94?=
 =?us-ascii?Q?R/m+1BJq2KQCLAhcHZdOVpmZKKboehkYN2Fps3pRwaVPdLLYEkkczkmkqi8d?=
 =?us-ascii?Q?P7oBHoVT+oQoivgc3IO5IX6wSh8A1Vgb+RerEwr7BGd6UQ4DQVKi+oy1mGT+?=
 =?us-ascii?Q?ngmLwbp8dA8DwHjiORYl73X8mOKpan27XQJBNblgK6WmfLYNbjqtb9dlRIUt?=
 =?us-ascii?Q?pLCS4jxjzkL1DsnXV5FE6dvdQzpoLtncvAMZ8Y+LQKfQEHnd1KuHiL6HVvO+?=
 =?us-ascii?Q?q0ttS26FvBY8lb85JZkfuRZBld06+JLU/5BB/s/cdyjY48IDvvfrNV2HsTRV?=
 =?us-ascii?Q?qvKDWizMOe2Q6Rikw8Ju1qzofYVsQ4D20YcsM0Tvs1Q2hD/lFtlTmApRtRsX?=
 =?us-ascii?Q?YtgQQo06XzhN99gnrjsD7nbKaP5lH4xLbRbQGAeMXNq5W0+dBvPapXYuykl6?=
 =?us-ascii?Q?Byhp4eejQDP1c0ZwPzukrF/ekcsxL/+0KEsfnTCykZDwiG5Vo6mGnZdPlbE2?=
 =?us-ascii?Q?rob4+qyGMfNBSq68ur6plgvtjb7UfdXmCQJIaCBfG74oc6j1cIQrlC6z0Rgc?=
 =?us-ascii?Q?08bkNbJ5hALTNA/rkxzZRX9MyMxl?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-4a72f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c2747f1c-e8a8-4e24-ded5-08df25b276fa
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2993.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 03:07:34.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB3170

Junio C Hamano <gitster@pobox.com> writes:

> I do not know if you meant to cram a function on four lines this
> way,

I did not; GitGitGadget reflowed the indented block in the PR
description. It was meant to read

	void repo_invalidate_kept_pack_caches(struct repository *r)
	{
		struct odb_source_files *files = odb_source_files_downcast(r->objects->source);

		for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
			invalidate_kept_pack_cache(dir->packed);
	}

> but I suspect that it may be easier for everybody to stop and
> wait until the other topic solidifies a bit more, and then create a
> synthetic base that merges the other topic into the tip of 'master'
> and rebase these five patches on top of the resulting merge.

Makes sense. I will hold off until ps/odb-files-alternates settles,
then send v4 on top of master with that topic merged in, and say so
in the cover letter.

Thanks,
Qin
