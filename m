Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65236D53B
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 09:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711187710; cv=none; b=ooojYzsR0woTN3vzvXBIqGk7hUDJgnFurcM7v0he7TLbzPBda1hrlyTQkJghdwq7Tz/3AVryZpk4snIsuLy0oIbUXEJzXpLdlJbRXbe2KY2dhL8njBKs50HWyTQJQ75g2nQfMKuZzYSP5jLE1C0FSXoyjic6jRxpvCgmPIC1K/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711187710; c=relaxed/simple;
	bh=oKIsVIg64Royn1S7/c7k9cnrutdSbvMNPtFsigrkCXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxRFLXCrCM+HM+UPWg6jkFXNEHaxz7x+TMUoUYoFIhCGQIuKupYBNHu6OcDPBkFVwfBgi9a91EiF2HySoidwC7iFFarMTeL77hXSTZTjiHiW5VIXl3f96j8XrJdq5uyQLzpl9Qc7aGlVmXZ3Zb/s8Sy0FJPjw6pjAbZQKvfrlDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=MWPv7msr; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="MWPv7msr"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 92F6660382;
	Sat, 23 Mar 2024 10:55:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711187703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LPCx9pPjJ7AMgpnVUsUeuP7VCjz1+fR7VEvjmHJtg0Y=;
	b=MWPv7msrzgSAH8TwXkL/xN2KMLeXAwaDNNV1A2vtyVeTeNk//nfjtaHUE/h5L8Z6EuK1AM
	+VYqTWBSMegHvrCQ63b3jhFPU7Ehw7Q9c3t8BuQizkKfmopKsCnpg3QVuMMgNox1YIw32p
	K/i+grMmGRAEwZhvjisT5E07L9O2vWtxkE1VuaLxIkwvEjXTjEp0/qCu0gRr9glkG/WzYl
	qcZo/Lmm/KwYZK1e9i2f/TImW4gtrTIqLEmWnxz+84nkE9+VEC3RkQbTE7MRXguK5hDBA2
	TGMgeDCFAX7Zn7YkXItsoXXtLDRxA3kb/LMVPu7TfVKKgxP2YTr98mEvvV2Naw==
Date: Sat, 23 Mar 2024 10:52:48 +0100
From: Max Gautier <mg@max.gautier.name>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/6] maintenance: use packaged systemd units
Message-ID: <Zf6mcBhd31WYkwob@framework>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <20240322221327.12204-3-mg@max.gautier.name>
 <CAPig+cS1YL1iOZFh5=b1+_P=KBST=DYRqp7TaD7uMVLJQjs1bA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cS1YL1iOZFh5=b1+_P=KBST=DYRqp7TaD7uMVLJQjs1bA@mail.gmail.com>

On Sat, Mar 23, 2024 at 04:38:44AM -0400, Eric Sunshine wrote:
> On Sat, Mar 23, 2024 at 4:21 AM Max Gautier <mg@max.gautier.name> wrote:
> > [...]
> > Package the systemd user units (timer and service) with git in
> > $(prefix)/lib/systemd/user (or $XDG_DATA_HOME for $HOME installation),
> > and remove code for writing and deleting the units from builtin/gc.c.
> > Determine the correct git path at install time by for the service unit.
> >
> > Detect systemd timers support (at install time) by relying on systemctl
> > presence, since we use it as the control interface for the systemd
> > scheduler.
> >
> > Signed-off-by: Max Gautier <mg@max.gautier.name>
> > ---
> > Notes:
> >     I'm not completely sure if it's ok to do install time templating like
> >     this, but I couldn't find a similar enough example in the Makefile. Any
> >     suggestion for a better way ?
> >
> > diff --git a/Makefile b/Makefile
> > @@ -3469,6 +3469,11 @@ install: all
> > +ifdef SYSTEMD_USER_UNIT_DIR
> > +       $(INSTALL) -Dm 644 -t '$(DESTDIR_SQ)$(SYSTEMD_USER_UNIT_DIR)' systemd/user/git-maintenance@.timer
> > +       sed 's+@BINDIR@+$(bindir_SQ)+' systemd/user/git-maintenance@.service.in | \
> > +               $(INSTALL) -Dm 644 /dev/stdin '$(DESTDIR_SQ)$(SYSTEMD_USER_UNIT_DIR)/git-maintenance@.service'
> > +endif
> 
> This is the first use of /dev/stdin in the project and I might worry a
> bit about portability. Granted, a system in which systemd is installed
> is likely to have /dev/stdin available, but it's often a good idea to
> be cautious when introducing something new into the project.
> 
> I would think it would be possible to instead generate the
> `git-maintenance@.service` file locally from the template
> `git-maintenance@.service.in` as part of the normal build process, and
> then install the built `git-maintenance@.service` at "install" time.
> That seems more in line with how other resources are handled, avoids
> the novel use of /dev/stdin, and answers the question you ask above.

Ok.  It's not completely obvious to me how the "Detect prefix change
logic" works, but using other rules as a model, I think I can do
something like that:
systemd/user/git-maintenance@.service: systemd/user/git-maintenance@.service.in GIT-PREFIX
    sed 's+@BINDIR@+$(bindir_SQ)+' $< > $@

and depending on GIT-PREFIX should regenerate the service when changing
the prefix, correct ?
I'll need to add that to .gitignore as well.

> 
> > diff --git a/config.mak.uname b/config.mak.uname
> > @@ -68,6 +68,16 @@ ifeq ($(uname_S),Linux)
> > +       ifeq ($(shell command -v systemctl >/dev/null ?&& echo y),y)
> 
> What is "?&&"?
> 

Hum, a typo, sorry that slipped through. It apparently works regardless,
because shell expansion does something with it I guess. Curious. I'll
clean that up as well.

> > +               XDG_DATA_HOME ?= $(HOME)/.local/share
> > +               # systemd user units of programm installed in the home directory
> > +               # (meaning prefix == $HOME) shall go in XDG_DATA_HOME
> > +               # (from man 5 systemd.unit)
> 
> s/programm/program/
Ack.
That should even be 'programs' I think, that's a general rule.

-- 
Max Gautier
