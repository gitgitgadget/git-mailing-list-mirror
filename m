Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB5914A4F9
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425949; cv=fail; b=eC4MjBLp1Pj0avpetVFxISLsUvImY9WoKdHv0gz0Ad+u+KC/jSM/H/OJ/GG9gTl15mmc5bui4g/iaAEL2RHpD2OU7YXmr7VSBJhtOXxUQjgNNCC65BIv2gti1SC/FJEif7t1jub+wOjvSN1i020v0eu8N8cVlhg+XVTdYoys2f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425949; c=relaxed/simple;
	bh=nv0NdZ5jrQTL+E3ogV1jw8cDMjw7UNyjz5Bx29lcG9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oKs5XJA09Md9Xz7RZw3EFA2jjuJvSLcWP6pWwoN0F97HwGICH2VR6ZQPzoCL5TX/EbnjRFMieWc7RU+ckgDZICCbpvBAgDMFb97G0jBXRLaKjuxR+63cycUTaRotrnF5ZWh25FpdTWUIF13rCkks8ztieZn2MI/Js0adzE8tCSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=TlK45662; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="TlK45662"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZtmFVHojean24L94TZBZYUGlUz3aDLzT21nSqx2USWgrcF+phGSm9BBnFEI+zZHv+DKPWBWPbdk1ph2+XH9NSCqwIFruiLQQ7hGyURjO6HHHyPMxyavK6SH21YnSZfMTuXvGByVCdrjFZH5e7S79yUyFZGKMpIMUlHS4bk2doJk5bzBHQWrDMf7HQJgRSuG3E0T5TKhpMUg79dhKoifXPH/GOSZYDagTJRrzr/POkZ73HZBLUqzlDJFG9AREQ+FnNOC7P/4PNuMnGj17ihdML5elozQ+kaFWEXUtNPIAz+oYQ8BDzjR96/V7HUkWJuekxD/T8Qm/jdpduWgJXvmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2DmVAqbTouml5QoAtSPt3w2w20Wp9qQJbP06RC4YfY=;
 b=hJGAh7B2IZL0uBYWrytzWfpCsfPTrhvfBXG1aA27kys65du1mrIz9NC49nX7aVU/euAOw8/4QPCFjpQWxas08aW1xFsvAcdMxQSgy2c/p6BYETPKeltfsdfzmUA2EIpIHPHxSn4aoi3m///YvD40WcgnJnEIqfhbRQ607OHDbuc1r/bnbEXG0m7etnJlYppeN2GyaQuc8xJ2Ng5NKw/6ai6gnPwUug2mKevTx+XSDl5bdiwPx2bixOHNkb588y4GIJF4Ag+GaiU5ODGr+W3iAPAeYoItyNky3mQFuM/u4gcQ7S6FvEkjXBADN7qLmmJyePRSE2zurtTQIuhSwEpeLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2DmVAqbTouml5QoAtSPt3w2w20Wp9qQJbP06RC4YfY=;
 b=TlK456621+3+BcoBcT8kG55LEzU1APHZfiahEp3ki4CkYZC7tfa2y+PpNVi/gb7pCQbh3e4muMSPWvrnnEc7PqEEK4TxEE0jPbmTt+1kZof85oBqGozVeFYeTNB8Sr9hvooIjWtweeDsNZrUFh2r7aCTJphtvz9dS+dasQthAFXE/PL8UYQskDMwiK4uj1jRYqIpq27Nzbu7z+E+YEpnWDOFlpIuiTyEcIXMdXaMIFmACHQ18O2ZVVJEsR97xJbeADr93G5nuG5CrUpLMjneiwSGESeGZIOtdXC3g4Qou9WquARFZMUeYRsXsU4yLuOHSa58H4v/6M1nvD/IPbaQEQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6047.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 5 May
 2025 06:19:00 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 06:19:00 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 0/3] Improve checks for valid_fqdn in send-email and update documentation
Date: Mon,  5 May 2025 06:16:21 +0000
Message-ID:
 <PN3PR01MB9597827866A582654661102CB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN1PEPF000067EC.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::28) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250505061846.11170-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f7636d-bde6-406e-12af-08dd8b9cb9bb
X-MS-Exchange-SLBlob-MailProps:
	gMiuAN0LASIScjX/aS/OnauL17RJFM5J2rpohuCff7iuzjyEiGQXEeIgT/RScgEZqIeHBjtxMjcE/JdtyfuXXLCTDAp1QyJy/PdSPppgZQM8uEYynwsOgudIbkhRWnSI7BkGIs795IS6FyzwpdC/HbRlWpliheBrEHsbgruBO2XEn2gTwSuFt/UhUyKjx4Z56gEqBcDY6KyNAVFKLHA+QB6XDqTthAG4KVCycvxrgHHNkrUR1toPI7wOzNcfGdmtvyqIxmSOJnMzynLjNL8YMU6errVtfDSGFUa5kSOtAgIdLCNEQi7GJ0hvjkW4p0GJSY4o8NW21pUpdGeqgIYkpXQkwHwDu825MrwWVwNvVxyNvThPUmb/l6hAe5f6i8RW2PM1pfSlOVAUDtoyKQJCagjxrThthWkT0RsG3IV1YPivzKzVkgoCx5nx5DSm+ucp2xI40H9ECs6cBH98ujXvUmRPDMufExkly9w9ONTqTmpz25HuwFni5eKAuuEARudYqe98Y+d4JV79e99x9SEYM5ftl+sZnbB+x3bnzAyE3OuKRCUBL5LkMBmP8uoVtJrxbKbSDMdROwdEfJYp8fJ5O28RsGzRwH/3wDjF7bIHzrRVYwMwabHMklAWiPjBIlvmWe0vDBK1n42Qt02jKDXcnoW+ty+B2w5rrakLmxBq4t3rFkBdSg9Rmq7TY6JhMdrGTc6zDqFsAA+07ROpPD5Nzg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|5072599009|15080799006|7092599003|12071999003|21061999003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XYftkhsiBV94HzLOXGKqcmYdmLohUpPPaxuAvpFsWA2FTNs+Vmw8l5iw5eFQ?=
 =?us-ascii?Q?SSy8d0J53eWuQ8wWc96cPn/xc1w15lBannyfO2qsyPlH4qfGR8U5PuB6Mpqx?=
 =?us-ascii?Q?230MswHpdMMu9jVAgcvqu8rsv3PBrEmIG+N/1RfoK9K7cZuPiabxg6m/upk9?=
 =?us-ascii?Q?4zy1bkFPvDsluUk90ykqHl+p5E/Ji08+MVE+LoHlDgsAylsEF4tpe4h0tr9E?=
 =?us-ascii?Q?HCkxA3doi+eNRqFF+G765R78MwYhfpUhZUrY5cfp4ncYGIuuT1/5Sp/s/b/7?=
 =?us-ascii?Q?HVmcwoSzE1QZ1ji994i3x1wB4xKnz/iyJMJUPDaJE2XKbC7JalIYrwl0PYtp?=
 =?us-ascii?Q?lj/oNaWvQGf+bwFyL7zVtylAGEJVPOlwnK+MCHzkZZGZA6xqSk9fS0BOq3wG?=
 =?us-ascii?Q?Sx6hMVroW0wnmqYj+LWgx5htMchNSvSPYSRYZIC2le/mkDzHRXVjq7bdpOtX?=
 =?us-ascii?Q?02744kRENPNk4BrcDd2cwTS9W9cFmS0xlS97guGSbOo5XOc1SD88uanq6DkJ?=
 =?us-ascii?Q?AT/rLbloOX5mS9aVxGdnUHR8csioy01tPZ2VqTStcWVloiI0BSbrj4lFxQl6?=
 =?us-ascii?Q?PqjeQO9EK0l1u8Rpw4onBHi1FZHZfD0ZJdS4rZb9B8PXP4lPOoXhY2f1ubz5?=
 =?us-ascii?Q?hL8cg9OKHAS+b9UKytORYs5uj3DZ/nTQrdwXhyQindsbyu5ixJwBQKchdNx0?=
 =?us-ascii?Q?Tkg2zRQxzcCH1u/CKUGj7gmSntEpGTQqTUTKHEvwxnd98beNZW1qaYegtC9j?=
 =?us-ascii?Q?PK0rdysCZ9UnahiSFzZZlls4y81azPtiRD6UGjM1F1BvQd3rJJkuLnclvyIJ?=
 =?us-ascii?Q?SAPWfyOX68RLZNbtEFnTR+y4xka/ZvpkqyRc+cPvSSgT91Ii/+yN8QDAH56i?=
 =?us-ascii?Q?iTUICLLVczKt1eNo1lX9c18kebBjDWdzflMRl0EptFVcCIC8hUICJG4tB8Ej?=
 =?us-ascii?Q?5PxQPitaqOr0NbbxpSFLZVtkldeUd70Ydh2sOPFEi463T59VD0EdisY/VAiy?=
 =?us-ascii?Q?8Ktol3wbjM2lMBMJ+CyNSsCRVi/lz06FAqsTtCpXQiaNLX12Nh+Nwm63ccU6?=
 =?us-ascii?Q?mQLbLkFij+ixVjrEZt7YZOPD6rpzuypPrzFNE6134lU/eFMqMT/HFUT4iIc1?=
 =?us-ascii?Q?J4h0DG/Nubx0kjZkU4Kob5Tm+rvecPVZjcqLFq6c8z06yYJ0ISiXuFI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?txNLLxXKHJ6khq3Rjpaz2q4rhKooXob2Xsv7X16c/6eMEoaCPWW7awKytfAn?=
 =?us-ascii?Q?FG51Z9CWpEHK8gUzWZB3Mj30P2xSz0kuvIJuctsw8Xs1Xo0A7KTkJT6NnyvX?=
 =?us-ascii?Q?mVE6jlJrLi9NA12LBaPHLn1xt+zC4V0XcJG85fFjLHPWaAxlctnukXNBp57A?=
 =?us-ascii?Q?LCCmOyBGSFaqiLqr3gFwCn0PuU9pGVZ5SBxuuQPGxpcyiWVhb+Y8C75pm3Gv?=
 =?us-ascii?Q?HB5BhG9fPJzqRDLlPIz4h6Ocv12ORiQ13cMnRztOG15lKdMseJtCbwPdl+YL?=
 =?us-ascii?Q?iFzxLbNKJ1gmMAySdvA6pa0Wf0Curp3c/T0oFMBPdU+qDP2hFepyLGIrCIms?=
 =?us-ascii?Q?DSdVMZ2FlVrD2zZWDaH8kocyIOfhjrTeYS6M74En0R6xhErbAaWdlK6QT9LK?=
 =?us-ascii?Q?9vukMcxAznhC5VyMzEMQqT/XC7pxfJmFuPoojlKAF7KhfAuz4Ma8SEVemri9?=
 =?us-ascii?Q?AQC3TAci0D4YB/1SoNLkmN6Z+hNwIKWF5i+Tcl14jmM02dto0EOSyabPmKTX?=
 =?us-ascii?Q?kYRjc4JrKchWBQVNTdEVJE7wZ0BRcAeQGRIH3i5hor6qUJtG/PMIfBa+QuGi?=
 =?us-ascii?Q?x0epPuzGLqZS+OJE66q9H+7Kr3uu5iflz3sHNv57Hp9V/Bj655DJt49+81yt?=
 =?us-ascii?Q?foub1U1o/YgD8Lh6sfiYZNv9+9QoS/4ZThHIU71kokA7oCom4GVL8pDOviDX?=
 =?us-ascii?Q?RBTv5eh/PkXIAwP7PihFrVzvO5nANq2R5DeK6tk+6L+c/8pizRMGYeHGRzDA?=
 =?us-ascii?Q?qhP9+W1tcI/IpUqBEDs+2ZEvh/9Nx35g2Cz+ydcAQfJWeqBGm8oK/lho0Rj3?=
 =?us-ascii?Q?qVQ8gBb5Ps05jadIjtIoWG6CHxJ1A/whKKSAZvMQe8BfKQqNAHDXdWSAIvIp?=
 =?us-ascii?Q?k7qGuFmT2QbSA+KwrktAq/FcfIK9oqGrkfyEpTMupO8OzM9tEt7YhwJ+bC8z?=
 =?us-ascii?Q?/mzFQTxlAnu2xGcB/ZwnI+CxKsz2fJT9LExWNEQPkEIH/GfBzr9JnEVUnQJm?=
 =?us-ascii?Q?xrjLL/sOBDp3mCbekmrdUD3KJpQDSRkIxKEVVG07HQho4Rt671h5oCH3fo36?=
 =?us-ascii?Q?5rOUXbRSgtyBN+MouceXW/uq3wndPEKG+4r3f6GVjN3ctPKXViO9MyJ9QSU2?=
 =?us-ascii?Q?VlIKDH7ZfYVFiT3pbUdWHb0sKLFYa3WhyWu99MXiEmMkMBarLVyyP+RzPjc8?=
 =?us-ascii?Q?eD+umcjemoP3HYLoA8Q5FY6gp04n2FODi57HNZwtExDCUP8Dv6AJvIMCf5w?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f7636d-bde6-406e-12af-08dd8b9cb9bb
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 06:19:00.7037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6047

Hi all

This series of patches mainly has two changes:

1. Improve the checks for valid_fqdn in send-email to be more strict and
   compliant with RFC1035.
2. Update the documentation for send-email to include examples of using
   OAuth2.0 with Gmail and Outlook, as well as links to the credential
   helpers for these services.

v2: - Improve grammar and add missing "" in second patch.
    - Separate footnotes and the trailer block with a blank line in the first patch.

Aditya Garg (3):
  send-mail: improve checks for valid_fqdn
  docs: improve send-email documentation
  docs: add credential helper for outlook and gmail in OAuth list of
    helpers

 Documentation/git-send-email.adoc | 106 ++++++++++++++++++++++++++----
 Documentation/gitcredentials.adoc |   4 ++
 git-send-email.perl               |   3 +-
 3 files changed, 99 insertions(+), 14 deletions(-)

-- 
2.49.0

