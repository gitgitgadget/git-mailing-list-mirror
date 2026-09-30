Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E1951615E
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784531; cv=none; b=S9JiG6vJv8yk2UErz6Uq/rH/gCVpvPsaHx5EuGB29EnU7Bdfgu0uqHwiQvrFyfJMN0lLXGn6Q/tuFy6bDsCi6n9I2z75+KHoLQVKSndVBnjV6Vmu5fnDaAShY2KxeDLxaTdjC/3ru1yLlG32fxRM6HioJ/Tm4wZ3Pfl7W7nf+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784531; c=relaxed/simple;
	bh=ijnQGhJrwTFuLxzH7d7jDyLK1jkQSix1nrujfmIG/qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGoOirOdv9vj3tYd9BWdda6jiCI6e9CYvg1dxmpNOmFnN/dIS7pTQks1bVO3ziZ6h88hbPQS/Wft/JJHrg/YiStQmdhJa/XVpgK92r2LcQtUkmDk2sba6ejEvZjAu22E0X/CdKUUSGFJzrofAXAuaMrRKtecemCLjWsMEmmxi0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HXAo8FaR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pLo1CO8y; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HXAo8FaR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pLo1CO8y"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B1BE1140021E;
	Wed, 30 Sep 2026 12:08:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 30 Sep 2026 12:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790784522; x=1790870922; bh=0hbQ1cXEj5
	7BuAmmJTsdRItpTJoVxhVE0SacBc+WVss=; b=HXAo8FaRl1grsu2cMhYjbynQi/
	PdD/1WW0vOkYrTdMYe5Qp0iWckIWPMsEiVwWTwUCOvygRiN69XXxTaWquVadtspx
	u3AAKWT82NThs5Kp0PLwmfsJbvw9tTRKp/p26HMFYhTnX4SvWIShpzlihgmxpgKp
	g86DrGwtOwn5HLHwYmTgedGOXWmdDwPCl5ERuozU5xfj8sJ5104EUldSIMEu8jom
	QspECrNRwyOoUiarS+0ncPd6Q2N+BkwODYNu74a1RJF0cPiD/vWUn2ddFdUWnIV0
	SIj2pvlXydde0nhC6UPMD/CaxtfbD/SZwz9sGJC9HYnDAGLt4EEo2BtVDLYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790784522; x=1790870922; bh=0hbQ1cXEj57BuAmmJTsdRItpTJoVxhVE0Sa
	cBc+WVss=; b=pLo1CO8yG8n24+RKoaZZ5BgSwUUNwHApamvkb52XOmnoHNQ9JBC
	dj4aLX2x75+rMjsqaFe1dcb0yeNsLuLbDOPVXmwrGFexqqua8zOi8M2mbldluQLo
	dDYlGyKmIBpIwDCaE+ljWikfE+LwXAKq3YhKkfrHjid6ZqGwr8u/plE5H/bkEFvw
	O153HVmXvhFCnnRiijEIFMPSD/cfVS9SA3JkfZ+d0p39sZzTzrfRjArrbIb5hv1X
	pEK4rE0bqFKjtlvwIAxBqo7RqftoNu7Efjf7HRqj049U1Wt0HGz1lxP7sxuHdF38
	XKUcQ/hJSzq/oXCb7IyZpUSS8PAUCdIBq9g==
X-ME-Sender: <xms:CjS9amaVrg6ec2Ogph2c63fCo1QnNxtrZY6MHgNdb0rmpzdBSLM_Gw>
    <xme:CjS9ag04afpNYemQ806kPSe4UTsomPx4dAUYYct3AY8nQ3T40zdMlowHVJBYLtPMW
    527FjCSu02FlfqXxvK6yTDmDy0wZqYQ52hpj1idUD4qrDfXrkcZ3w>
X-ME-Received: <xmr:CjS9auWTok0IQcmmYDrL_ebiLU4a_3C-dt4YaGcsoyDJHFYgTfExpw>
X-ME-Proxy-Cause: dmFkZTEWRiQeTynOP1ssaqptVyLcgpG2mqcPUqmIwy0PXSOZlyA1Xd72S73lhk/5Kt5FP1
    razoNUFqyXGcs94OXzHLvaTLfUmj+sBkDfoYDrOEI0PGKKQkj40p13czpcHT4dRiNnhnnN
    59t4OypVd2tg98qRqmML0kIA17ehVH18SqTqOHMnXYI2GMWBXTE3y/qMlCHf4k07t4L1cl
    p1RmGg79sjage5PmDMManMiFaIETwijaSDkHbzPNdHmAd2VBzz6CiJMg0Rjpx398dmsDZG
    yMLqb6f6xOmbfqv2VHieak2CKEUKJSJW5wmyZX+23mBbEmxsTmZee/rtbAP/SHRO6CYJGR
    RWEeb6+NxbNCITmTa1UZjD+IJbGRLhT4waLZ0dRqrveDiPQRTxBaw4T8ZrmbyszX6NAApD
    Y9MK3Syo4jHVAg9IMCXSueCDPo4Z+On7hovO4PLH2p1PaQD4vl3cO4sPhOpUp7tOF3bpYa
    ZjMJP3RoiIJgpZYt4Pn+h7R+v3a320olwayjbFNnoK5rhmNEzj0tD6L0H9UTtWRLtkY4k4
    USq/7utaH7Y45ajWS0iFzI3pPp7J2ptWgKrDr8pK9kBzYn5/JivozOlMI1f7cQCh9+GDwI
    IjekPgamhcwmcgwigQ7JrBdSZ43PUtLSDV0UTkqlR4+s/vsUf0uwgd8uxrPg
X-ME-Proxy: <xmx:CjS9aiU6__RMJF185kJMtjosjEsfP_tPVrUSfAns48jwVgScZaMWIg>
    <xmx:CjS9ald7Zrlin7YhRaHRiGOIEPgknUjkXjrfw4NBHb6AZaN9zINfyA>
    <xmx:CjS9ajUvODQmom5hdEZjiy4ETV9B5znVYaoNEgcGj-2LDD1rqZO1qw>
    <xmx:CjS9amfBBJ9T4Ce7bfjK7OLozVpEg74xnRwjFX1DM2GYf2VzTjaV4g>
    <xmx:CjS9auAFi-oVeP4x4nrpAVCHDqZPtxtyNZ3uGsiE8Pc9hxXdmpLtui9r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 12:08:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ed837cfd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 16:08:40 +0000 (UTC)
Date: Wed, 30 Sep 2026 18:08:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Grant Moyer <dev@grantmoyer.com>
Cc: git@vger.kernel.org, Michele Locati <michele@locati.it>
Subject: Re: [PATCH] fiter-branch: fix commit map init from state branch
Message-ID: <ar00BTrDQ4voz38a@pks.im>
References: <20260801033127.10606-1-dev@grantmoyer.com>
 <ar0fRtN8XMG-fyis@pks.im>
 <c6d3deb4-088b-476e-921c-c2ee788fb309@grantmoyer.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6d3deb4-088b-476e-921c-c2ee788fb309@grantmoyer.com>

On Wed, Sep 30, 2026 at 11:48:25AM -0400, Grant Moyer wrote:
> On September 30, 2026 10:40:06 AM EDT, Patrick Steinhardt <ps@pks.im> wrote:
> > Okay. A simpler fix could've been the following diff:
> > 
> > - echo "${line%:*}" >../map/"${line#*:}";;
> > + echo "${line#*:}" >../map/"${line%:*}";;
> 
> Yep, that's equivalent and was my first version, but I decided to err on the
> side of clearer intent. Plus, the more verbose version mirrors how the state
> branch is constructed further down in the script.
> 
> > So... does this mean that we don't have test coverage for this case at
> > all?
> 
> Yeah, the test for this case was broken.
> 
> > >  test_expect_success 'using --state-branch to skip already rewritten commits' '
> > >  test_when_finished git reset --hard $V &&
> > >  git reset --hard $V &&
> > > - git filter-branch --state-branch state -f --tree-filter "touch file || :" HEAD &&
> > > + git filter-branch --state-branch state -f --tree-filter "exit 1" HEAD &&
> > >  test_cmp_rev $W HEAD
> > >  '
> > 
> > So does this now detect the issue? If so, it feels somewhat roundabout.
> 
> The current test seemingly intends to check if the --tree-filter filter was
> run on already processed commits, but it only checks that the filter
> produces the same final result. Since the filter is deterministic, the final
> result is the same whether or not the filter is re-run on already processed
> commits.
> 
> The proposed change makes the test fail immediately if the tree-filter
> is re-run. I looked around other tests for a test_* command or
> conventions to fail with a message, but I didn't find anything. I've
> checked that the test fails without the filter-branch change, and passes
> with it.

The thing that I'm worried about is that the test seems to only
coincidentally exercise the code. I think it may be helpful to have a
test that explicitly tests for the scenarios that were reported as
broken by Michele. Let's maybe wait for them to respond -- if we're
lucky they already have a test we can reuse here that more directly
exercises a couple of the reportedly-broken scenarios.

> > Nit: pointed out by Michele: the subject has a typo in "fiter-branch".
> 
> I'm new here. Is this something I should fix by submitting a new version of
> the patch, or will the maintainer fix it  up if/when they merge the patch?

It depends. For a small fix like this the maintainer may make the change
themselves if nothing else needs to be changed. But Junio will often
tell you in that case, so if he stays quiet without the series getting
merged down, then I'd eventually just send a new version. Also helps to
bump up the patch series on the mailing list again :)

Thanks!

Patrick
