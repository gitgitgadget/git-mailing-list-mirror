Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8E35973
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739341110; cv=none; b=ubr2+k1Lyi5HCBZSk0eaxGNB6vmN4TIeSZZ0RwxHGjf10jpXW0UYm0sFMw2g493oefS6xbjjefatXLrzD3MBX6Ms1SK6MXxEDqooUh12vByasFL28zj0SZfomAJnaTXxi3NPaA09vsIK/d6DBatbKKKF3kJNuwRerbjciuVOgfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739341110; c=relaxed/simple;
	bh=xlJsAvyNQcND2kjIXq+V+ENdBcGSWANbalk5toBicEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEgBhefkvkskge+CeQ2lAsP5CKeL4NBAOORL4llYj3DQZwH2ntLMy25Rhf610jGHcRwDfu5nwiNzatWm7ydSORS/SoTreDxA8Rgk/l3LqhTJGDE47MIptichGs1wBxYkeNBl1ChItAyvOc3G3CGCMc9nGvypEXyg/uCIKoG/v1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b=KTmuBF0d; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="KTmuBF0d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739341100; x=1739945900; i=tboegi@web.de;
	bh=xtvYqhO+cXOeL5zlF8sEg4Xtp0mLMjEkZVg86+a7HWs=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KTmuBF0d2jWLNwvBGncr2ETx02Y4CpkcZS2YOjzBmTrvyfARZOcTuhxP9D5LQKKM
	 dZQRikDf+oM21c3bejJLoOzWZ3FQL4AEM8Dd+AdbicGS4B9pSen7Cp4PyvyB3IbFi
	 rSBqxlyomIO3LiJn0x9bjvt22jz0or0HXc74+i3w9RFYaN9GqQ+0znUJNezL+uwhy
	 qenRdgUeJj+pfV/wYmgcqMCN2JNcCl6sPD5BXHs/7cfSsPMoOXd+nAEk7Bf1aX318
	 4ZcVUAK1T/m78S0i54eNYdsKDMHOlappKM6Y7/7pp0dn9pI1x42r9OfKmtHO1D2sB
	 Vh+6ZRb+rJagWHQkKw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([81.231.143.213]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Ml4B6-1swtHM1qiy-00a6X5; Wed, 12
 Feb 2025 07:18:20 +0100
Date: Wed, 12 Feb 2025 07:18:19 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] doc: clarify the intent of the renormalize option in the
 merge machinery
Message-ID: <20250212061819.GB990@tb-raspi4>
References: <pull.1861.git.1739307712372.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1861.git.1739307712372.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:/I3jOd9nqLdWDFunmEZlvO9cBWRLmax+/ea7BRs+sz+9OKfPq8I
 dCBFVI22YOBQe0HrAOjvulAlk/NwsLePYZvcd8p7gZdGG/qr+qs5CUx9yWmXPWSq+Yg7KXQ
 lk/VJ8+lC5q2TwtmMktliFIFrNL2+khhqqFRyfe1CCbAfPE4URUPq1veHG1+PtRR8fZIV7N
 5rFVrPwh1atG2wIv/AysQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:r0rMB3Lfqas=;n4KGRBBf4gxD1+Pxpihodvzqeug
 mNUTOq+Q9wtbNtGtwsRfEO9JWqrotWHjdByUFHCeK+JAsrP3ykBdyZanLvmskKDVYomrUnj0E
 elxYbvpctojbRBqg5WgVM3yBLfQXJ9sh+JlOPEpXq+VftqEupOF/EzDXrkyzH+jPPqpGCgPMM
 ZAsBSnkW/DTbvUX41AaOXOxiAZojYqmvp/qYg4GU88r071kLtQvZk4X+2k7GGJHp7Y21Y95vs
 F6/RbvKnZjYBL/aI/uHmXppOGJBL1OIZNEYzgMXRRa6Kmsz7csaNtWoLFi6I1nJVIof5P1+LF
 qvi24Jx1q3et+DlAadr6wJs1UeWJnTppTaQTFXKZVrL5HSPVrKEHlTvdAw7v8377DHA7hYtiC
 tpOaO0qmYC+dLRgMELP6e7jIlIqLC41/AJ3Jynsv9/OafIF09MP+IcdMWoYuQDWCRI5gKPKXW
 MUvvFFWU2rfb9F4An++MXJ8t9liA1lpUlHSGGhFcPUzzDPnJyY/3AlNhC07eDy/DCDM65QTIE
 w/ZKXd8ynrPJCDQEtLZwrpJ0wue0ylkJuE1pxi3UToDXB8+JSy6ktRC0jgH+Atsx67N4Gg7a1
 pm8Y6U70unzt+EH0hRwX6qbPAA3oM4pKdDnmPZOVYoBQcyNAMyCjJFE9Q3MItEgNmqc9lqiyr
 xrmU3uVavD1Bwcz3MBHh9BFtTy3Mmoc2GKnqeKxSTW1GWUXNNmOzZmc33QMVe2YKdG4MLwtBZ
 jC/E8DORwRmObPBfpGQpI2MWXWTEDWlvFhIZXZtFwABzMeIpai+lWV1kCCn2jJCTt+vHvOZ67
 CR/B54m9JUwC8oe0/pCi89ISoA91l75duuoDl5Xo3KYxiVhOl34M8jqDyenyrkPKX2qX9KVpB
 OG6YJ8WvklwHMbBYcn68V3QWAPi3IUkZozbnBuHvaGx6N4+n6Xgedyvvj1Sdm2J7PbjXloY5S
 qYqim1al4O+/mfh1ewnFkqzGyzDEiZ7glkFvr1tt/H+TEe2iBLJt14/LfXJHxIClRlcnfoQim
 iN5pMACsdrBVXBHoQzRD79wqAbx+pTCo1oFY6/Ksy3m5Z7YJxVhd1+UyBvRMstqPTh0wESTsK
 wcQSnObJrFWcg6F6JzPEg/pEpPtnCDnct74AVvtPmisNukpM29NnZjLuiWKvEgX0XKpQOueyd
 FxP99TN35MXki1FOT7ASVL6yHfxUMDrMBz4NLw55wXC7jKi94GNlusgvyPJR74dKtd8OXXRp5
 No9Mggb/pzdYF0qREaD6/76t1KdQIQhsZ8FmjSellqgSpuhfAyhDA8sT2NwBojrurbsF0X8CM
 Zuita5Vey6RHNjXHCsqZNb7O39bbOiByejut7Vyo7ugEGWZU7CZYLztJPcJTgvRsn4yPhL2do
 x7miFoYgUSyT4pt4mEkk980e8rHLdgkKsuMZxzwP4/SnooN35yxmKiIQ2Q
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 09:01:52PM +0000, Elijah Newren via GitGitGadget w=
rote:
> From: Elijah Newren <newren@gmail.com>
>
> The -X renormalize (or merge.renormalize config) option is intended to
> reduce conflicts due to normalization of newer versions of history.  It
> does so by renormalizing files that it is about to do a three-way
> content merge on.  Some folks thought it would renormalize all files
> throughout the tree, and the previous wording wasn't clear enough to
> dispell that misconception.  Update the docs to make it clear that the
> merge machinery will only apply renormalization to files which need a
> three-way content merge.
>
> (Technically, the merge machinery also does renormalization on
> modify/delete conflicts, in order to see if the modification was merely
> a normalization; if so, it can accept the delete and not report a
> conflict.  But it's not clear that this piece needs to be explained to
> users, and trying to distinguish it might feel like splitting hairs and
> overcomplicating the explanation, so we leave it out.)
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>     doc: clarify the intent of the renormalize option in the merge machi=
nery
>
>     cf.
>     https://lore.kernel.org/git/CABPp-BGQ0pc=3DAZ0fdXcqDbhMLbm2xBvi71g0m=
XAVDagz19NkEg@mail.gmail.com/
>     and the thread there

My first impression after reading this:
Thanks, that makes sense.
The second one: Do we need to explain how a merge works here in this
part of the documenatation ?

The third round after re-reading and re-thinking:

Yes, this makes sense and lloks good.


