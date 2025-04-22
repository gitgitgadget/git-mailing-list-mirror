Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466E719AD70
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304709; cv=none; b=VMkv8eRyhwPageed+faogAG4+6lUWtG2XP6ckc9W+s0A3eb/xl5Vfw4CmKnl71miKJyOA5ft5Q2DkHN6pm6q7/OiDJUtd01NPvwNZT7rODavSsk9jVDFs7uwe5sDPSrGwk2Haf+QFoIFwVDe16JLWI3euMrY/+pTnn2mXDMd67o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304709; c=relaxed/simple;
	bh=TGcx8H1bJ50+QEP6rBRQeWOk+BNZJ/r/ogOJ/ixCF14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7Y36iAtjvhjO7DEq5AMEkk/zwqdtO8Mce1ZKHbbPkgfd9Jm7pnRn2UAVcq4Mdf5t5hOaENsP6LRlg1UKUNtVbZLvpB1Pj7h9kkZojx9qUytmqHGAzUV+65p0A6V1giTqnhPmoFnX9EkyJkOwB9LrjTBUQtTA2xHkZtciQl6aow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rud/AeUw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BthbNQ8S; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rud/AeUw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BthbNQ8S"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 631D725401A3;
	Tue, 22 Apr 2025 02:51:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 22 Apr 2025 02:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745304706;
	 x=1745391106; bh=adz9rrhnfxhqvq3c/JwMNTkdOqpY8mMyNHZ+YdAmO38=; b=
	Rud/AeUwPJL6lfYFMI6J8HQGvrcyy2pRIxi5kUGTUa8/DtSi+ARGqmhLN65xbJYr
	V/g5JaKFrpZN6t0YV6P3Ltw5V4WWuzH77ptfuJ6hHW86VIzfnfby7f5FQohiJEmg
	BPGb0ncSBWmnanQi9tmYr9aSGpWwea27CB9QelkPd50/2wclB0wetFIFWrMfYH6u
	tT4Hs/EuPQ1HZw9/pLE5b34MEyIqHXj4cNwl0gMMeD6piXcZk7ylROJ1bUHOZZjc
	4w09CpckNZFQvhLWAIrdbmV6modMhByFzPItwJSNl4Wozv1EbT4T/9l2k+6qu/h0
	4Ccyb5VwRZq18gECZFm/wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745304706; x=
	1745391106; bh=adz9rrhnfxhqvq3c/JwMNTkdOqpY8mMyNHZ+YdAmO38=; b=B
	thbNQ8S+Ow/ZYfpYgfsa2XUPP/qZg5pFQtG0YlCO4n45PQkMrTBFpJGWPv39Bgtg
	aDzGYrN6l2CP5BuDziGPe4ba/riFmiC3Xq0NZLY/PaLnjJWxAg2RcKZ2ziwUBfCB
	coYJfBXgagtGCic6DC/y1w2KhFuo8v5/L22bUss4lgR7Mlq8qXCOx/eLYpJcGzxn
	CMRdJrMdZni2L5wwbtNxRRMh07beJ11ZZA+TrErEo/G9JPVoHxZTGci91CzYCc18
	d4nwHCOTZM+vgUs5vMZbnQH9bFRKzFdVHex/hcUWumg/PEmoW0gI4wFqe85Gtc6u
	bhRmKUb671VtJWSP423VA==
X-ME-Sender: <xms:gjwHaCOyOHLldBCIeMv3j5JwDyuGj2YnF1cpzin_kqgfAN0Pm-mIUA>
    <xme:gjwHaA9naWzc2DB5WYHljSQScatsfAlVIx_VRby0H-BmnK9Cwz-vtPOlMUTvyS6bx
    JKUwISPqJwPQi1NBg>
X-ME-Received: <xmr:gjwHaJSzrNZrxfhuuNmjgi9mzRFq8ZLNLANFJ_A6wjK-DCmgI11clGXypPeC1uXFTWrlGYkIJh7ggxryN0cy-U3b7lCX2nO4MqlfodVBGvM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeftdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gjwHaCvaMrreQtq85fTr5SYtfVKI53aA5kY3fQPfj7he253Lgyg1Cw>
    <xmx:gjwHaKdKkZ2y5tDlYKeWlbltmbm2JKnLtBSRag60a0PZLAgvd_Gwag>
    <xmx:gjwHaG1vycTbw9FhPYGa1R0shtDdglUzxu2Vy0YBTHeqwXbim-NOKQ>
    <xmx:gjwHaO_w-XRJixJtXTcUhwn5VQh-JAPg0xWoZICR1rUjz2WFcQ-nlw>
    <xmx:gjwHaB6yubQFF69HO_6bcKeOc_Tp8pU63DLP-URlXFIq_1X8TWni4MBy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 02:51:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 33a9368d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 06:51:44 +0000 (UTC)
Date: Tue, 22 Apr 2025 08:51:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/5] t/perf: fix benchmarks with out-of-tree builds
Message-ID: <aAc8f52rJ8ATncVc@pks.im>
References: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
 <20250414-pks-meson-benchmarks-v2-3-04377080a167@pks.im>
 <CAP8UFD3HcAVs351sabU2qd70PmMzTtGbS7P7eKYyDyUQZ4nQ2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3HcAVs351sabU2qd70PmMzTtGbS7P7eKYyDyUQZ4nQ2Q@mail.gmail.com>

On Sun, Apr 20, 2025 at 12:00:08PM +0200, Christian Couder wrote:
> On Mon, Apr 14, 2025 at 8:51 AM Patrick Steinhardt <ps@pks.im> wrote:
> 
> > --- a/t/perf/perf-lib.sh
> > +++ b/t/perf/perf-lib.sh
> > @@ -25,7 +25,29 @@ TEST_OUTPUT_DIRECTORY=$(pwd)
> >  TEST_NO_CREATE_REPO=t
> >  TEST_NO_MALLOC_CHECK=t
> >
> > -. ../test-lib.sh
> > +# While test-lib.sh computes the build directory for us, we also have to do the
> > +# same thing in order to locate the script via GIT-BUILD-OPTIONS in the first
> > +# place.
> > +GIT_BUILD_DIR="${GIT_BUILD_DIR:-$TEST_DIRECTORY/..}"
> 
> Right now on 'master' there is:
> 
> GIT_BUILD_DIR="${GIT_BUILD_DIR:-${TEST_DIRECTORY%/t}}"
> if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
> then
>        echo "PANIC: Running in a $TEST_DIRECTORY that doesn't end in '/t'?" >&2
>        exit 1
> fi
> 
> so it's not exactly the same thing, even if it still probably works well.
> 
> Future readers might wonder if this discrepancy results from changes
> that were made to only one of the files or if we really wanted to get
> rid of the "/t" check here. In case we do want to get rid of the "/t"
> check, I think it might be worth saying it clearly in the comment.

The "/.." is intentional here due to the way that `TEST_DIRECTORY` is
constructed. If you extend the context of this patch a bit, you can see
that `TEST_DIRECTORY=$(pwd)/..`. So stripping "/t" from the suffix
wouldn't do anything because it never has that suffix in the first
place. And neither do we  want to strip "/..", because then we'd end up
in "t/perf". So the easiest fix is to just append another "/.." to end
up where we want to.

I'll try to paraphrase this in the commit message.

> > +if test -f "$GIT_BUILD_DIR/GIT-BUILD-DIR"
> > +then
> > +       GIT_BUILD_DIR="$(cat "$GIT_BUILD_DIR/GIT-BUILD-DIR")" || exit 1
> > +       # On Windows, we must convert Windows paths lest they contain a colon
> > +       case "$(uname -s)" in
> > +       *MINGW*)
> > +               GIT_BUILD_DIR="$(cygpath -au "$GIT_BUILD_DIR")"
> > +               ;;
> > +       esac
> > +fi
> > +
> > +if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
> > +then
> > +       echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
> 
> Maybe something like the following could help debug this:
> 
>        echo >&2 "error: GIT-BUILD-OPTIONS file missing from '$GIT_BUILD_DIR'"
>        echo >&2 'error: (has Git been built?).'

I'd rather want to keep this as-is for now as we have the same error
message in "test-lib.sh". If we want to change it we should change both
errors, but that feels outside of the scope of this patch series.

Patrick
