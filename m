Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2019.outbound.protection.outlook.com [40.92.91.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A72B74C07
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133787; cv=fail; b=bSAy5PdbFe2PYgKelA+9mOpMZyRmrT98vnQc9vnhRox+1Xt1pRDxpiuxFLi9cXbv1KvLewc1KByzO8eWy9ijAhOFbpC8leeIbulFZyZxvrlHJnOS2nVeNOp+s3DBwVVN8qWnTXtaNhW/Y05dM9heNSaYc8ScfpyjsNcH0M8SXak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133787; c=relaxed/simple;
	bh=GEPTc9MECQo0FpVVUEHZX6zrsGf6jAms80W4Ddm/rGc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=qQdZlJfpzNBgbDeyfqOP0cpxHU2w46aTsneHm3zzKehXx6FQuo2+g/PpmsEx+I5Q4NrjiwpCvqd3PbTqM8UsQthMhYUWmrFRjAYEnuxJ2z2I1G+XWC/yHlhsDNZKKozw6aDGLtyOBbqGwm3TvhI+/Pe0WM3/ab3SnNvZOb3/2mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b=ZU6ZvMUy; arc=fail smtp.client-ip=40.92.91.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b="ZU6ZvMUy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZO0wk+8D309PKEhwlJTDDq5hvpfvpPxYKoRQH6OywOQFrNCFupe8CtlczT17qTqaHHaOb7h18N7HTVmDcDyiPTR5lqIwkuufzVNXpTVru0RcU0xIXApjLxMeQGU4K6PTqwKMgXuCeUOsBFj+wjF6U5GWNxcShcnFhvZ1qGKBkPSE6+8bypgKN0GgHDALit3JaptZBFscw3+sZpBHzGiFO3sN69t8A11vyIdHYvBfQcCoaQ6fnsj0Wbzyz1EOLqL7w+/o3oVP+YUuEdJdgu3RwHYShy6ZY6VI01Dw1ZLbgNzPSYL7EopMPb3dpaBV6nPdlHWMkZJoO3jBkVaMk0mAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vJ3HkBNMYxh5E+hVvYrQQda80cyuEh7miQd582lEYI=;
 b=cxfJ5Ld0DT8IFryBwnod7A+/S5w/Nzm/NHQ1Q4NShUJsiA2maZaVRjAlJQhyKwbJ6A8/r+MBi/39SV899HsZZ1IuEW+LSXrPEhrnBla4esjUumj9BzY+bYMMDx1CZOkkOoaARnHbDE+MElVtf94GTYCYCGAxdBrA6kRN8Xc8RGCqVX6iihAhrKPTGL30tl3hGFosre/blntdLJfiD3bxk6OBNa/SE0D/AsMpEKPB/Dxiy5CDcKSqSk2vb0IXBuUdCfr70hjjwZlqryjL3yq2pPoiCI16vAqfMQUNwrtpflywSbIKwdFO1fQWA/68G+1NHblabvNbOW/q0GgLjsVsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.DE; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vJ3HkBNMYxh5E+hVvYrQQda80cyuEh7miQd582lEYI=;
 b=ZU6ZvMUyBCqyHao0i2E6oOrn7LgnoceEegUXnPt1iVDP7VzcOU5yEu4Oq81VE1SxUrijhbBwdzsw9jPoxhO/hilpdZa1dqOQXJD/q/lREB+kYTcu78k1fU3ZkYgWREKyYA/oNt+xaDWyoNcAkUMoRDp2z/QnyEH71opZs1e6u73Y6UYmqjE149Qi8ihSpEdSv4GRzyDuLNAh1z4rdNWYXJyEHmkmq9Nu6YBquN/poIKdMrfUt6i/pRYf7DSTSshqwQF8m+wnt7Nm8Rr7oi03nohwS1asBKZof4PWftU1Zyb0Wr0hD5aqzTHDTMsnKZEGvHy51TubwqevfeZb3N+0Kg==
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by DB9P250MB0524.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:337::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 08:42:59 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9eb9:f756:55ee:f036]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::9eb9:f756:55ee:f036%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 08:42:59 +0000
Date: Wed, 3 Apr 2024 10:42:58 +0200 (CEST)
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
    Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
    Jonathan Tan <jonathantanmy@google.com>, 
    Emily Shaffer <nasamuffin@google.com>, 
    Pablo CHABANNE <pablo.chabanne@etu.univ-lyon1.fr>, 
    Nathan BERBEZIER <nathan.berbezier@etu.univ-lyon1.fr>, 
    Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>, 
    Matthieu MOY <matthieu.moy@univ-lyon1.fr>, Linus Arver <linusa@google.com>, 
    Linus Arver <linusa@google.com>
Subject: Re: [PATCH] docs: recommend using contrib/contacts/git-contacts
In-Reply-To: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
Message-ID:
 <DB9P250MB0692A99BBDC70A0E65B18A1FA53D2@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <pull.1704.git.1712017205754.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-TMN: [Q6Px9U6yn7N006wwHvcuyN4f/iZquiV/]
X-ClientProxiedBy: FR0P281CA0265.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::14) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <35192e61-c442-6719-caf0-1019bf3e44c9@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|DB9P250MB0524:EE_
X-MS-Office365-Filtering-Correlation-Id: ae729462-4015-4bb9-8ef2-08dc53ba10fe
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	83a0AFM2OSwhhpEWfQfme7k3CBf34e+jLOa+V1RZ/o0fgCQwp2NmtDAVgOqlK9YenxMDl6ed4QxNIdFP4AsBZd8RyVn5kckbQi1KYMePy2514sMEE5zsVKiVu2BEpoVUufGcdLb67Nk5ZgnYoZH+NXGHJ0r4PyA/EaS4rqkJaP/znXFB9sOeAi7A9pBvbltOKJ9r+IUzO8IVhZLyTm2jBcK2Cq9kmundztxhObQTtKEVis8n1m4f4DUqnDYdoTAW0R1DwNHq2mbtKKPPkrBmC2J+Mv2pC7JNGe4OQeevkUk1f2LaiAbDzyYE++zgIZ/y8MB4hn12OYDmSoqDvVwCqhrj96jqH3QAlmeA77UUtRC0Dmg4MVmVeMFB2wMIbNwNREcV2wCIJ/+1VvKb7/1OUZN0YSVUkpKA9OF6gvhbT51894SUhWoT2T3yZZLNa5x0oFjTxVHicAojTTAENyCKrwWUCLbyM7FDL+dtfX0TJjkC4G/7iGwiegOtNU9wl4XwHzkWBTI6hGwdjbFecMzGjcFUI+aceNq7hFsRO+cIfTQfMfwRH4qzhdHeNdEtQQqDo9fmPux4Y9NArB6VAvexflptuXmpNXKchWifuKLirnhi09WOpfPSvMdJOKacYbsOmFcLsKLrTyqSPhHVf9EB7Fi0HSvxKm38TCEEbAjXs6E=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+EFkaXCvt0Ofm4B4TwyujgP622WpYPkp5fNErswxUKzhTIhYOoRsydaI/0rW?=
 =?us-ascii?Q?r3wSGHPYdYkB82R3agFxrbmkwnuzPf/P6hFv3IGPiwuvpMslJn8Fniv7JQ1n?=
 =?us-ascii?Q?nfNYolR+fdWPcnjKXn24fJgBN60Dvpo6zLXxk+cIBoh3o2c0TKS64JYKkJlw?=
 =?us-ascii?Q?hCBHG4296Qj9iA8pc3kIV4ui0NDQtBhG47fhgjMBawl8NOjoGbYdqIDoARpm?=
 =?us-ascii?Q?zYYt4lv7kWvKtWRAHfgfbVqZH9oFPZHajDjb7BQ0hUsZRpZhXv6FRfXNio18?=
 =?us-ascii?Q?9vGH+rPYo1YqxtTphR3JkhWFCc8cGS4WEG7Du2e6aeI7R1bM2gAgSR0xUyax?=
 =?us-ascii?Q?Z3upOyLdE3VDwBmlwjd5ECHocQPkZHU7kb+Df/CmkyRQdQxKVaTS5KHZLoCh?=
 =?us-ascii?Q?pNGb1czbddTNMhklLzV3YHUPuULeHH46r/j04Z16v/2qxsr/B7DWWN7uP7wE?=
 =?us-ascii?Q?ifRr3VO8ouXKK4JPyRgw7o2p3+kfR+28Lo1JCF8dz4eWwCzYqHOrwJSYBPW0?=
 =?us-ascii?Q?Vp7LCJYlEU+LBEPwR4ZoRrti0Chf/9jXB7r9eJx7p/64AtTmYlc7N1bacgGQ?=
 =?us-ascii?Q?NqF3MxKQrEbbJdhyUqXpiAD1+yq1bo3+GgGLs/phU0XODNyFcJYxuLyuheqf?=
 =?us-ascii?Q?W1Sk0gPaCpLs3M2Gb8rcTQGflK4tEOvqlUw8Nyo1E/JSi/oSoJ7/xnn4IFuN?=
 =?us-ascii?Q?pyuiJ3/rjibyKWmQi2HM/VuJ4DCRx8wWn2EZUTkijqGKd8npVFSzPKGdlXFs?=
 =?us-ascii?Q?pg9pQGdEunk+fKXtF75ph404sEBcKvaL5eedBxdIF7pGVI9iqyR20BKlAF1l?=
 =?us-ascii?Q?c5Q0S/ssQI2U+lNMSZi83pqChvMLpCQEKUDQ9CK+Dmq8jQhq+vZuLng7gmyB?=
 =?us-ascii?Q?aZaY071k9V9kRhbUZebUo+xkROSZh/VH2ogueYGk+bLvQTrzVK8NRiqwQzkG?=
 =?us-ascii?Q?hesdRaTeLWLYv0zkiiqMoqCnw+wiaFdYaSto8kYnB+24utu93/7adgsZ4+p/?=
 =?us-ascii?Q?9/RIeNub1+6GqswSO7cNDdcJcuqSQhznHMVAIhntopZyeZ00U2Fmwfhw0PLv?=
 =?us-ascii?Q?45C6Qtcn04+S54xkHLsQfN2IIWniIO1gtvtByeGSDMO6LHGBw4HVFv67pZHC?=
 =?us-ascii?Q?tGjvSIEfLSBYPCRDG/aF5ByodhdLaUJozTMxyC0UwVOJKaYI4VJxXWr+HROx?=
 =?us-ascii?Q?hsYVNvt5YwAM+NZXHDTbIKBqq2ZooFrudgRBUU2JgIClh0+H8bvjvPd3EYc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-0fa01.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ae729462-4015-4bb9-8ef2-08dc53ba10fe
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 08:42:59.8419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P250MB0524



On Tue, 2 Apr 2024, Linus Arver via GitGitGadget wrote:

> From: Linus Arver <linusa@google.com>
>
> Although we've had this script since 4d06402b1b (contrib: add
> git-contacts helper, 2013-07-21), we don't mention it in our
> introductory docs. Do so now.
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>    docs: recommend using contrib/contacts/git-contacts
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1704%2Flistx%2Freviewers-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1704/listx/reviewers-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1704
>
> Documentation/MyFirstContribution.txt | 3 +++
> Documentation/SubmittingPatches       | 4 ++++
> 2 files changed, 7 insertions(+)
>
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
> index f06563e9817..eb1e27a82df 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -1116,6 +1116,9 @@ $ git send-email --to=target@example.com psuh/*.patch
> NOTE: Check `git help send-email` for some other options which you may find
> valuable, such as changing the Reply-to address or adding more CC and BCC lines.
>
> +NOTE: Use `contrib/contacts/git-contacts` to get a list of reviewers you should
> +include in the CC list.
> +
> NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
> please don't send your patchset from the tutorial to the real mailing list! For
> now, you can send it to yourself, to make sure you understand how it will look.
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index e734a3f0f17..52d11ff510b 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -459,6 +459,10 @@ an explanation of changes between each iteration can be kept in
> Git-notes and inserted automatically following the three-dash
> line via `git format-patch --notes`.
>
> +[[suggested-reviewers]]
> +Use `contrib/contacts/git-contacts` to get a list of reviewers you should
> +include in the CC list.
> +

There is already a paragraph about this in Documentation/SubmittingPatches 
just a few paragraphs below.

> Send your patch with "To:" set to the mailing list, with "cc:" listing
> people who are involved in the area you are touching (the `git
> contacts` command in `contrib/contacts/` can help to
> identify them), to solicit comments and reviews.  Also, when you made
> trial merges of your topic to `next` and `seen`, you may have noticed
> work by others conflicting with your changes.  There is a good possibility
> that these people may know the area you are touching well.

Could we improve the existing paragraph instead of duplicating this 
information?

> [[attachment]]
> Do not attach the patch as a MIME attachment, compressed or not.
> Do not let your e-mail client send quoted-printable.  Do not let
>
> base-commit: c2cbfbd2e28cbe27c194d62183b42f27a6a5bb87
> -- 
> gitgitgadget
>
