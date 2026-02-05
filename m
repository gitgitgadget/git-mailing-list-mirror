Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF303ACEF9
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292512; cv=none; b=ZZ5K47dMyl1G94QBEfE5EUCNSIMTQp8KAm7RpseCX1rPfeJg+ehKGYiXnsvnhQWey5Q42ghJPzV3EU/h/vCtjqnCcHkinNd235prOGYlGvP1JQXA8SfqKKfSgE/j7tJgXFmrYuk+FA7rP6ygiWvJ9C8qFX1w6tjweBIN2q/BXXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292512; c=relaxed/simple;
	bh=YMzFuYc5u3J11f8epckiRmDgCn35GXqlCcGUm1d8oc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/8UZ6oB9JX1s0lvxYjtREoNcGQVY2wYOO8kSF6k9Dg368vWA83f/tyEWUSKbzD1cJpW8UM52Fkhd2W4B589bdV5i3Opj3mgz4oXoMVr3K9MEOl5EXwnp/m1rdOB7IeooVtrkmp3B4RooBJD3THT1xl0xsuvPTYDJqyHCXeL52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iwkRBSPh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=htdK4Qlo; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iwkRBSPh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="htdK4Qlo"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A5447EC05BF;
	Thu,  5 Feb 2026 06:55:10 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 05 Feb 2026 06:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770292510; x=1770378910; bh=f0FrkOkP0r
	b5F7YKei4I+hootTBVB7KiKW9deMixE1A=; b=iwkRBSPh3QN2YJ8BtYr3b1k7Dq
	3YTlq9kpPKL85ZqbHVWtC+y0D8NW0WQro5jHZ1GDVYKg9vX7T1lS6730CcqFP1Wm
	t3D2BQYnQh6NqIWGJwE3SQ7fWEB4mWkfd7Htm7d1HZvGzWHg9r1UWoSYu/r7V4At
	ieb8FMIDMZ3bGnbjXk35m4B31H1xtuZzb/+om1zYs/8THIHSjRJfoQyFi+14/wyw
	RrZ/BvAoADDAjTz93m1VZ/PtAJumXtqa2n6xMvUTPNgnMHcvhikRS/qj5kI3IUnz
	KYaxGsj15HPMJQu/KLB21MOgvHJbpGbl2Ni08jbY2/CH3MM7Oz2tH1QO8V9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770292510; x=1770378910; bh=f0FrkOkP0rb5F7YKei4I+hootTBVB7KiKW9
	deMixE1A=; b=htdK4QloWWrsdjE27RrCUM5XBm/UjNNr+jq2UXUpfOrfU+cI//7
	wmehL1FPddSgVTQpJsag9itXhIxtz5Bi+Q1K/wT5PYjdaSvb2y9Y8WtnnKOCA9cL
	3PYfXUD87KXBGfdEMQFP5nibQutXzih6wpiMIGA5/7Lsr9I+vi7q71IcS2INIKX3
	qDNwzzRkJLeMxtV2Hk0LkAzuAGQwO6dLWuTGBV/BgxKZaSHD5WJrhzM6SHJyZOB4
	97FZnjzusFdA1vliLVAQtye5apnWZtS/Ks/sbhohRTRSggTXCWnyyjtwnFA7eM2S
	uD0AIEEvZUuIMn5kH77kGhmxHOdmeK9srBg==
X-ME-Sender: <xms:HoWEaXvDnJch2fh2d1K0ly-WO0emt8QJF10q5iDjqI6fkVlPjc910w>
    <xme:HoWEaf60lfbfG8-ztvceJNOdzv0fcvshdLOJz2_8gIfWzjQw5oEEH38oTzsqCWoqf
    h8HtuI5AmIenjxWrv5bLOKzaVOInxU7Ni3GJRBvL8CSi8DqEGe04gE>
X-ME-Received: <xmr:HoWEaYJMANHjQFhfKhSnaL06mXWVDcV9WGQBeUJLPXuQZjUhL-Eh51Q11NTtmCmq8CmnTB1SI1dvHahatpO4A7PmyacYgdQU06w3Tybn1g9e7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehvdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeute
    ffudfgheetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:HoWEaf7if25P7nduuwxIYYtqyxwiH7jqhMmbPQdf50Cg797QshcxJw>
    <xmx:HoWEabxV7eKGJ26w6BVC72tPZb7V8jc41-Z8YgY1o5XB1GVRdYRRBQ>
    <xmx:HoWEaTbq9fXkTwrr_zGn413ah4YWWu4w7C595z3prDkB5xoPRm9b0g>
    <xmx:HoWEadRGvNXofIrlXREAohAtKrGB3Vl0W_Q0X7Lm32Xyi1Xt2___cg>
    <xmx:HoWEaUc0NNguVsPqF2LkRFFg278wRsoTwrLnPHdGU2uwBLjKfEb_Xkxw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Feb 2026 06:55:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 995511a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Feb 2026 11:55:07 +0000 (UTC)
Date: Thu, 5 Feb 2026 12:55:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] meson: wire up gitk and git-gui
Message-ID: <aYSFGG7lCg6Sw8vy@pks.im>
References: <20250819-b4-pks-meson-tcl-tk-v1-0-6bcaff0bc0a0@pks.im>
 <20260204-b4-pks-meson-tcl-tk-v2-1-5bc3ccf3a8ce@pks.im>
 <20260205093748.GA2177239@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205093748.GA2177239@coredump.intra.peff.net>

On Thu, Feb 05, 2026 at 04:37:48AM -0500, Jeff King wrote:
> On Wed, Feb 04, 2026 at 09:38:11AM +0100, Patrick Steinhardt wrote:
> 
> > Wire up both gitk and git-gui in Meson as subprojects. These two
> > programs should be the last missing pieces for feature compatibility
> > with our Makefile for distributors.
> > 
> > Note that Meson expects subprojects to live in the "subprojects/"
> > directory. Create symlinks to fulfill this requirement.
> 
> The GitHub Actions win+Meson job fails for 'jch' with:
> 
>   Project name: gitk
>   Project version: undefined
>   Program sh found: YES (C:\Program Files\Git\bin\sh.EXE)
>   Program wish found: YES (C:\Program Files\Git\mingw64\bin\wish.EXE)
>   Program chmod found: YES (C:\Program Files\Git\usr\bin\chmod.EXE)
>   Program mv found: YES (C:\Program Files\Git\usr\bin\mv.EXE)
>   Program sed found: YES (C:\Program Files\Git\usr\bin\sed.EXE)
>   Program msgfmt found: NO
> 
>   subprojects\gitk\meson.build:28:3: ERROR: Program 'msgfmt' not found or not executable
> 
> I didn't investigate, but presumably it is related to this topic.

Oh, indeed. It seems like the logic to handle a missing msgfmt
executable already exists, but that I forgot to mark the executable as
optional itself. So we need the below patch to fix this.

The nice thing is that this verifies that things actually work with the
symlink on Windows :)

I've created https://github.com/j6t/gitk/pull/37 to fix the issue,
thanks!

Patrick

diff --git a/gitk-git/meson.build b/gitk-git/meson.build
index ca3c0cec58..aecc068d30 100644
--- a/gitk-git/meson.build
+++ b/gitk-git/meson.build
@@ -25,6 +25,6 @@ custom_target(
   install_dir: get_option('bindir'),
 )
 
-if find_program('msgfmt').found()
+if find_program('msgfmt', required: false).found()
   subdir('po')
 endif

