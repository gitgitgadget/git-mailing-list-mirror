Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390F936E47F
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776151441; cv=none; b=J9twyiLtLuk870KvAhFXB/uC/o5dk3WuuHywPlM0as+kY7ikeBrBzoyn8z76Tetc+7jRwtYKkwkcSqYeJyS494UXKYV/e9cugPZRnzCjJ8uh6k9Ag9IQEyI23TQflBpJD8MiOa73jzpfSTWWCte5ryoKxPcPqpYVBGMhNFRDDnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776151441; c=relaxed/simple;
	bh=RyKQmFFAi5Ic5OTDRTFDd4++qePmTRP0cRTGjk8UEZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo1Qr3+Ad8GHhDwmFATy7gCJuyhIVVDlyr/Fcq5fLtJF/Bp323q9Oe3pa6daC+OrWketx36B7g04y58fg1l5LFSD4zhu/no+h0eOP/iwmxi0FEm9Y5PgkU10DxPOy6NuKtEtjY9pg46qoQB9zJ0a0Ma4/Y67pTT0Rj1f9e/Y5FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N6Ap0Oy2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PMqUjBKL; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N6Ap0Oy2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PMqUjBKL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8189E1D00189;
	Tue, 14 Apr 2026 03:23:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 14 Apr 2026 03:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776151439; x=1776237839; bh=S9IAYrkGP2
	riLdMEikk683rsj8kUrgYUIJLwL/gAtR4=; b=N6Ap0Oy2273pjSWxntyahVxeia
	HYuWTXSBEVW4dBliaI4p1bM6yV/HL/PA6slZT8D0oe0ERdBZUsAWyNDnZmcHMBwA
	Gk5/ZLZhfzG0DdyZDYIgZIMJLkM4xYrSuOj9H6GvS/m35vUs2DpuXaIxOkyHK7Vz
	aEXELuZHhuaXmT8fu7BN1d2ZGFCyj5/xQtWEei8aF2EQr+7uYtIIY8f5yiRgYfMj
	e3WOeDRnw9Vz5ImSx5fAyTa7m1kUlGbPTsIeGL5/UCVrcswYXcswda6mxKEb37f4
	QnPtMFwhXMMAK+e7O4QOdkvuAjuBvQQLkXDcI/G1j7CS8H6F7kZ82yQtUBHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776151439; x=1776237839; bh=S9IAYrkGP2riLdMEikk683rsj8kUrgYUIJL
	wL/gAtR4=; b=PMqUjBKLr4W1XxZLCGF+npHEL6saWY3T9BrIS5SPZ/aJAYofcNs
	2XDGg2cgmaBmkz1IeK3AsRIp1La60Vbph13fkBAOXf5N7BnmfxT28Tj6vzEonVeJ
	HQ/2Diqm2TnXV9kGU7PazfCT5706twP2mCjejY9g5O0fatwReAklauT9/NkuQIwW
	OrIubFPLx1jaY+vYRorTNO8zFKOeNJVaynp/FBOydA/y4iE8P5WBfbRYav70EZrH
	Zz/nXtuKgRo8ODYEb8Mi2xi+4hGnJCcZRX2H9nWo0LHh+M8dSM+y1rLn9kfFW5yo
	shzhtLz7789ZAKmZRLQtnHSzt6sDIPxLMbg==
X-ME-Sender: <xms:j-vdabiU8Z7xznCNu4bSfnbAmkhD4i-oET8-WApwEqP_XW7hfqme8w>
    <xme:j-vdaeBBrTqrluLK5E2eGnytNq9cR5Svzy8_svtyiXzVlfwsQsUOCTctxJzfS5ejO
    o4NG-tQu1twne05nK1UqqL7Pl9819pPxazGjoEfX-HIfbppMl4>
X-ME-Received: <xmr:j-vdaYtCvdNPWPPo9NCyqueDJdPCS3eMvrP6hsFlI_EiqBrK4KrxootgCtlBbUf0ImJqRnoJ_gNuMy_YSPFkSSKmBnvbfbkWUuXQrqo5BII1eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegtdehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j-vdaTaAXDuurI93n8V74LCIJztZDDlILHgcAnQIoxOr49TO1w_Ymw>
    <xmx:j-vdabWYIVE8qkDAtZ6Kp8Z6--eYCsvms5Pu213WC6eCydxFmOOoBQ>
    <xmx:j-vdaX6O9BRl4RU60Z84YdNbxTDbCKCfVsN1Y75eJ3V_rgCy-D6Rcg>
    <xmx:j-vdaWiS4h8d8HR19dNpA0yoyA-QonWiS2kHX15aBdN-8if7GIzGUw>
    <xmx:j-vdae5eB3y0NpNN_lj_FdEdvpNw4Rg-uJYQpcfMgQxqPRp13n5mweIi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 03:23:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1aeefbc5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Apr 2026 07:23:58 +0000 (UTC)
Date: Tue, 14 Apr 2026 09:23:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/12] t: prepare execution of potentially failing
 commands for `set -e`
Message-ID: <ad3riiF5QWuMmUeT@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
 <20260413-b4-pks-tests-with-set-e-v1-6-5b83763a0e84@pks.im>
 <xmqqtsteiy7s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtsteiy7s.fsf@gitster.g>

On Mon, Apr 13, 2026 at 10:09:27AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Several of our tests verify whether a certain binary can be executed,
> > potentially skipping tests in case we cannot, for example because the
> > binary doesn't exist. In those cases we often run the binary outside of
> > any conditionally.
> >
> > This will start to fail once we enable `set -e`, as that will cause us
> > to bail out the test immediately. Improve these tests by executing them
> > inside of a conditional instead.
> 
> OK.  "svn help" and "cvs version" do exit with status 0 and the
> rewrites that use them make sense.  I wonder if we can do something
> similar to "git" instead of relying on "git<RETURN>" to exit with 1,
> perhaps ...
> 
>     $ git version >/dev/null; echo $?
>     0
> 
> ... by using "git version" in the test-lib.sh change?
> 
> Other than that looking very good.

I'm a bit confused. We do exactly that in "test-lib.sh" now, see the
below hunk that is part of this patch. Am I missing something?

Patrick

> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index 70fd3e9baf..81380fe978 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -143,8 +143,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> >  ################################################################
> >  # It appears that people try to run tests without building...
> >  GIT_BINARY="${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X"
> > -"$GIT_BINARY" >/dev/null
> > -if test $? != 1
> > +
> > +if ! "$GIT_BINARY" version >/dev/null
> >  then
> >  	if test -n "$GIT_TEST_INSTALLED"
> >  	then
