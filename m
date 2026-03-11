Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011062.outbound.protection.outlook.com [52.103.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18F2EEBB
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773269130; cv=fail; b=FcU4U2IoXYaAG9kEt3qNyJBIysiXC1OoGRvZJJatQcPYDck0m95xbqAFxyxxzrk7Ao4MZp7kfxyQOJp4oFuP0TTOKmhQn7uG1xv8/AgYcLcoq/STIzckNw8Nd83czDiWcqv56HRtDEqHabQieO6/fSawZAN4w+Z+eu9/7tPaT0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773269130; c=relaxed/simple;
	bh=fJFaVr9r7mX6IkLYJGBcc8R9/siOMpxA7ceRhvSV50E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gnVKfrTpYeiatQO1qrLs1VRyRnlO+BDPZGJ0aFqc0eCkarzYpinhzZa7bWiySV4+pm0bawX1CC7JATt6++QJaVg/ivFrecCB05PBkjVmzTL+MfqGEpG1LVijPLZZIZp5nNyc8M6WIq+X6l9YqZ1U0oX3DWZfxn6n+ox5kh9G3GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oUOSpYq5; arc=fail smtp.client-ip=52.103.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oUOSpYq5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4OqcuTr+D7w27RxCJknYwAejPaA9XTxkn+CR43z4fCSoKq/GkATMY2tvodB/hmwjtgaKyK4gZmTAopGjqJzXBh6ppBW9ti8uCeX+reiutgZd9qHvHCKLOE9gLnlJUtuyCTeAmiRTZuhQxgtbrLCnu44QQv/MEnBIkQV5ACZvV/qGWBAg4/Mbfz3GUy58KrFAMYO5AXT5cIeLGkLSQjm5wUra1b8SRC4o8Ck6trwQEni6iSQlSbogmUhQYqkRf/W/fPKYy+5QANBQZrqq3/eyRiOOZqIDP6c6cBwIJGLYtfhsjndTo4MQKa+9Y6i1NCt4jcn5m21mMLY9Aen1sP0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZBwHtchcRvyLf7mFcI3muK65iQ7RbOCDX/dN7v3KKk=;
 b=RvMJV71r8KuBP8LjC6bV5vv8D7O31pMEtv+/yTVqf4jReQ+szhrSW1vWw6P9IrxQBEXtKCwelUwnLSgJXf+t81DMSCy5N9M8hbaqGd30DACspYXpT178qt/zzVpOkM11BU9r/vAT5D+cOI69szrY+sKKatXf9xw14smGUAlxsjheIHNqpb2zIT0gvFiRzFlrwJlbMNJHu2gpGvyPewyI24z7YgVLwDPWVhYrCmGKaLwpIKfwwtgc2TuyV5uZZVlLxQMhx1N9REhzooo/9z3qul0b47GM5WjnLJqurkByF9aa4ZK2+nuv4Qaf5cjF4h9qsrw92rzPPQ5tkt4SSMQsYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZBwHtchcRvyLf7mFcI3muK65iQ7RbOCDX/dN7v3KKk=;
 b=oUOSpYq5cQ6nx2XjgDlW+gOy4mURvkQTmhPnPbw5FayJKaINryzFU0aP4nMDKjjnpdarWgqELxEHAUqFsbWmddGZB/1c+l1L96I9xva2gQ09QSrRI97uw1xM01sWogLlc7J82d5NGx+fECOzGZ83A3SPmI6oxzMl9hrMz3QoGHunsFmx/QGwZ+Lql3eOybWnnDR9frkFKRHqQHSZj/SmvhN6eGjWmVJJwLrXmtnQ91Ys6k5eDS9sdGErjUsIy4YIw57QDjJR3Zium1VM59CgDp/2Bm4PZtH7Lb9vWEsv9E5yNym5Y4t1K+Ge3xmt2ya1EtFnmqRbnUy2X05XrjDZCA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB0637.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:28b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Wed, 11 Mar
 2026 22:45:25 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 22:45:25 +0000
Date: Thu, 12 Mar 2026 07:45:18 +0900
From: Jiamu Sun <39@barroit.sh>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] help: add tests for subcommand autocorrection
Message-ID:
 <SY0P300MB0801600E6ACF38D7BC715D66CE47A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB08015B9BA815B2C4F6CDC639CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <7caf4a0f-f11c-4a4f-864a-933142311a68@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7caf4a0f-f11c-4a4f-864a-933142311a68@nvidia.com>
X-ClientProxiedBy: TYCP286CA0269.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <abHwftGKtfAnCPQY@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY7P300MB0637:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f0c0b7-1b26-42b7-c8bb-08de7fbfe252
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|19110799012|51005399006|25031999004|23021999003|8060799015|15080799012|461199028|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3BcnWrVbf7hv4xkd/a+ri2/nz1Wjokrr21MjqqgdtLzEU8Vlqc+/EiN/FsmX?=
 =?us-ascii?Q?hcI/4AWeBL/LeGAnDCI47sQG4GFGol8hqIVhTCk3gUpfUqR1+gCyCIArAsRW?=
 =?us-ascii?Q?j9YL+Fs3znBY0SMq09MFFGQ0oCAAnj0rZ221wK/4Fs0zfofvaU5CR2AaMeN1?=
 =?us-ascii?Q?XDV4aux9k96oRyz1/3wTYaaSe/AlIkxydOWtmTLFPa5UytpsdRbl3Q5bDxRn?=
 =?us-ascii?Q?l/QQVkrJ6Zw0VBuWMRJU7+3WBQ1KOqeEyt+JNtVvkndA6qqDsWznHFy/mJ/x?=
 =?us-ascii?Q?tnTti0PcmY2cM5MOpzqQ69drP6UhPYuNI8t5bZ7JV3G/cj6MtX/k4aUQrckp?=
 =?us-ascii?Q?h4UNskZFVzIVSXDkcl3NpOtF2xPGx5IAmjBKI/fPt4cpralvVhQWE0PP63bx?=
 =?us-ascii?Q?bSsnEm8QOjTZTedyLPOLNw6bBqeBCVv5t90baHJ1f16+Wcyo5Fx6a2O4Co8e?=
 =?us-ascii?Q?0oGJgTpp1y+tu4lEzu1kQvHB0zSkZaFJ3W4prvSBt6PUTVYlanxYaYxrzx5n?=
 =?us-ascii?Q?GCJtVOWRo/WF9b7x/Zz5COLs+3xrayvM86A3Xb8Le2bTevUJG8Ia/pK4cYBb?=
 =?us-ascii?Q?bFIvllJsk9+Jt41IuD5vK82pQfQx7aASTraDN0dTMhP60fmpr0Ra9qJ8TmH5?=
 =?us-ascii?Q?m3oBBwoBwi07EOn4KIXF7N8BwQ2Tl3QKmR3+Xu4gf586XLa2w1fDcfy8LWJ5?=
 =?us-ascii?Q?zxFgovE6/Dnoaxbn9D6aXN6i5lb33ypy7tZX6KWxjNHpqKfq4v3tV9BliDEq?=
 =?us-ascii?Q?vlVKUuJ4Heh5me1+CvTuoimKg5xA+bseJWufl5T3cjtb4UsspRQZYJY3QmMm?=
 =?us-ascii?Q?yoHJyAKFOZqEjO+XeWiuGmGR677rNO0Tv1ZcEqrkWOjyRVTimIVjPBdt82hH?=
 =?us-ascii?Q?KhDP7gHMMechv8CaIqVxmdu4VOJ03YLkq9cbEyNQUQmPlSQU5zpxHyUHM3GX?=
 =?us-ascii?Q?CyTeY/Lc2y6uBCLzWCDdfQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pJKkzyOcjOM7sE9DKCBYOn1GKMz3kGBlH8WjIxn+jiME52VRqgfKsgny4JTf?=
 =?us-ascii?Q?dJ7VdKNj07cgjNHYOj6Y0kqFF1GZMlHrHjjKs1OW4FmnJxxAjt2xCt0CgtwZ?=
 =?us-ascii?Q?XdjopfOt+0oJiGoagEgtrfCDqyxA+jcwR0qLLE+Oh4t70Tr7HAdBo9+panSY?=
 =?us-ascii?Q?cMXD7eSbBbo+j9Cqzzd3u094yOv2vvoA+CeDq1X94/6LNiQuJcfJub9bN/Um?=
 =?us-ascii?Q?AZb4/A0x6KwG3/r9kquXJNbZwXjO7QyH6C5BFl0QgSSnt+J/Dd12XhJldSw8?=
 =?us-ascii?Q?HVpwKQRJz45KJSN9W6gLVXdeff2cCs13W8rUCZB1SxZTgMVnWLYAiuWqZXjh?=
 =?us-ascii?Q?DXuSZJKuEgSzfbtMQdUXTU4o8cV8Jy2q/lJxO3Sx8dCRAzZwqw+S2yehhCNC?=
 =?us-ascii?Q?xX6IsGiigJOCMxgZNzunELJ1DmX6mECY66crmk8fVAzhg55mNAvSmEFcFfEM?=
 =?us-ascii?Q?oouH6pZK+PiI2H5HM0a5oBTQHnw7DpMzhrc/fnHJB3CmjeWCzYLUKf4tERcK?=
 =?us-ascii?Q?sYBdEblCCVUFGx1iF5L1p7RRZOJeoCWeAQXyoBVZJJuE8U8Yq2yYaQQSlcQm?=
 =?us-ascii?Q?zb12HGeEyzwPtgcS9z84PIIH7khwgEACIHH2pCmPoau7hBTsBDJmU+rt53G+?=
 =?us-ascii?Q?tR79NuO8I9jfpYjbtVKDL0yzyQ+H/1PRUJyvv9UiXzq2fvsqJsKfGlc6TDtm?=
 =?us-ascii?Q?NuzpJAF89F2KZDgiqGcxKFeehncWf++xGMnKB1Mb7YyGeZWNfRVhkdll7z20?=
 =?us-ascii?Q?6qRipOemv0lCdmxEj8myQcIWY1yhYmQPodG2Z4Ni2vIGE5XeyIzGBpbfiBj6?=
 =?us-ascii?Q?YFmUGoR73gLcTbsoqR+61+w0xdGVj3rd6b/mZmObmUyFCvyncmqMjQbLq38H?=
 =?us-ascii?Q?9rU2cUd1vlIAigxVPHydMtDLJZlNAlPNP9XseqsCfuywxIt5qWjtQ08b6o69?=
 =?us-ascii?Q?YcUnKT5eoKbjLxyxwPvCI9Cs5NKel7qQIUmVuFdzpV4/+rAAFXlev6oH8esW?=
 =?us-ascii?Q?XcfFEtw9WKX3y3DgaLi3xpS5QiEx++j0cmppCih9v4Pp/XHMrRyYlW5TO69O?=
 =?us-ascii?Q?UQv+Yein5Q1/ZEO3tlNGlekoebYSz7LX6thZMGZOTmyIjx+XYmkDXmCLFySS?=
 =?us-ascii?Q?a/uWYUX6oavlUIOm5Z+a5mMdDOH9tiCHRTXUs2GNHpV8zcH2uD3LzkmfuO4X?=
 =?us-ascii?Q?8R/fsKCBsogGO5GPJ5ihTlMhpsGJZZYokc5cp8b8OKJvFyqKrKQqWNTXY50x?=
 =?us-ascii?Q?1qQf3aJ3dsmBH+tnFtr0ZnPnA1xS/QBxZryvOsM8zfm2Ldd7/R4q3BHv8YY7?=
 =?us-ascii?Q?V+lYqWUHJHsLspmuGU//NcBOf4/ghFVvVkK9aOryhpgMJMz713WPOKadS0ca?=
 =?us-ascii?Q?kvVw6hSSafjxNcJzV5hqed6bvmqc?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f0c0b7-1b26-42b7-c8bb-08de7fbfe252
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 22:45:25.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB0637

On Wed, Mar 11, 2026 at 10:01:55AM -0700, Aaron Plattner wrote:
> t/meson.build:1193:6: ERROR: Problem encountered: Test files found, but not
> configured:
> 
>  - t9004-autocorrect-subcommand.sh
> 
> 
> I think you just need to add it to meson.build:

Will add it, thanks!

-- 
Jiamu Sun <39@barroit.sh>
          <sunjiamu@outlook.com>
