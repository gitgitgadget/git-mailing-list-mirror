Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92C1E534
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711032554; cv=none; b=m9t7ke+xoq/4A/LEWTff9xq9bUrDOPj7b6z605hUSccQaB3k8QxMrUycjxidIQYrWypzdN4JuJX55QmpIhvk1x/IAA2n6N9tSmZ+EaGxUIsM9MMmLXVMValMtFS+LliZnMb7gSNUo1/mtRZFfib7yNH8QiFkSDR/pbhxj6Mt1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711032554; c=relaxed/simple;
	bh=oe4c0gZQgJ/HX2+sCCxqrPDpl8P5YWWKe+MpX9HOKFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhOcDmilAVQInM4Aq0xhBHNPcRHnx+WDap7Tmi/stONK86waPINaDtSIhfaX1/LrzvDCCrWQ+9VEd9b3by09Ya9aKP5fo56WVtd1SV4MKqul5kza+ky1DR2W/d6ec5ppfIIs9Ns7H8KyjTwf3R/Uql5OVKmDfFsUsF4hHkFBrII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=eXrwyeaL; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="eXrwyeaL"
Received: from localhost (unknown [IPv6:2001:910:10ee:0:a24:f690:de50:c41e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id CC8CA6036D;
	Thu, 21 Mar 2024 15:49:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711032549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3IBGbekTKBSDkUVhTpqauwUMl2cPSEUyhM0m298dNeU=;
	b=eXrwyeaLXd69rCw5X3qIpUChIrNRNbNs1BiE4PX+I5m0LlvLeQIFhN+17HXzFP/fgoOKa4
	UicrRU+M/Tw83W4S+/w0leQYRzsUgaBxWG5kWRIMPqvq8qrQYJ7VuCDVRxmSGD1x7t6qMU
	gcslcloKYameA/dPPMUmrxBDWoJIWuihn1NLd0TBp47Vi56xXbXgAVADgOY7gBy+skeR+p
	A2NrXHo+tyMi+PGZYfhyFTL3/OkvqWGd2Mr1vD8GhK+W5x1cteSAxMQLtySBxslxhHEIav
	CuyhOWfG5wGF9Ku6XLW8fx6XfwAbCtcBKdkAaE4yNc7+rv3uP/RXu6hHcfgnzA==
Date: Thu, 21 Mar 2024 15:49:09 +0100
From: Max Gautier <mg@max.gautier.name>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [RFC PATCH 1/5] maintenance: package systemd units
Message-ID: <ZfxI5et2h6Bx1bym@framework>
References: <20240318153257.27451-1-mg@max.gautier.name>
 <20240318153257.27451-2-mg@max.gautier.name>
 <ZfwqCv889UdI0mU6@tanuki>
 <Zfw4XNJdZqgZhvOv@framework>
 <ZfxHtetjUIUByqeF@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfxHtetjUIUByqeF@tanuki>

On Thu, Mar 21, 2024 at 03:44:05PM +0100, Patrick Steinhardt wrote:
> On Thu, Mar 21, 2024 at 02:38:36PM +0100, Max Gautier wrote:
> > On Thu, Mar 21, 2024 at 01:37:30PM +0100, Patrick Steinhardt wrote:
> > > On Mon, Mar 18, 2024 at 04:31:15PM +0100, Max Gautier wrote:
> > > 
> > > It would be great to document _why_ we want to package the systemd units
> > > alongside with Git.
> > > 
> > > > Signed-off-by: Max Gautier <mg@max.gautier.name>
> > > > ---
> > > >  Makefile                              |  4 ++++
> > > >  systemd/user/git-maintenance@.service | 16 ++++++++++++++++
> > > >  systemd/user/git-maintenance@.timer   |  9 +++++++++
> > > >  3 files changed, 29 insertions(+)
> > > >  create mode 100644 systemd/user/git-maintenance@.service
> > > >  create mode 100644 systemd/user/git-maintenance@.timer
> > > > 
> > > > diff --git a/Makefile b/Makefile
> > > > index 4e255c81f2..276b4373c6 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -619,6 +619,7 @@ htmldir = $(prefix)/share/doc/git-doc
> > > >  ETC_GITCONFIG = $(sysconfdir)/gitconfig
> > > >  ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
> > > >  lib = lib
> > > > +libdir = $(prefix)/lib
> > > >  # DESTDIR =
> > > >  pathsep = :
> > > >  
> > > > @@ -1328,6 +1329,8 @@ BUILTIN_OBJS += builtin/verify-tag.o
> > > >  BUILTIN_OBJS += builtin/worktree.o
> > > >  BUILTIN_OBJS += builtin/write-tree.o
> > > >  
> > > > +SYSTEMD_USER_UNITS := $(wildcard systemd/user/*)
> > > > +
> > > >  # THIRD_PARTY_SOURCES is a list of patterns compatible with the
> > > >  # $(filter) and $(filter-out) family of functions. They specify source
> > > >  # files which are taken from some third-party source where we want to be
> > > > @@ -3469,6 +3472,7 @@ install: all
> > > >  	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> > > >  	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
> > > >  	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
> > > > +	$(INSTALL) -Dm 644 -t '$(DESTDIR_SQ)$(libdir)/systemd/user' $(SYSTEMD_USER_UNITS)
> > > 
> > > I wonder whether we want to unconditionally install those units. Many of
> > > the platforms that we support don't even have systemd available, so
> > > certainly it wouldn't make any sense to install it on those platforms.
> > > 
> > > Assuming that this is something we want in the first place I thus think
> > > that we should at least make this conditional and add some platform
> > > specific quirk to "config.mak.uname".
> > > 
> > 
> > We probably want that (conditional install) but I'm not sure where that
> > should go ; I'm not super familiar with autoconf. 
> > 
> > I just noticed than man 7 daemon (shipped by systemd) propose the
> > following snippet for installing systemd system services (should be easy
> > enough to adapt for user ervices, I think):
> > 
> > PKG_PROG_PKG_CONFIG()
> > AC_ARG_WITH([systemdsystemunitdir],
> >     [AS_HELP_STRING([--with-systemdsystemunitdir=DIR], [Directory for systemd service files])],,
> >     [with_systemdsystemunitdir=auto])
> > AS_IF([test "x$with_systemdsystemunitdir" = "xyes" -o "x$with_systemdsystemunitdir" = "xauto"], [
> >     def_systemdsystemunitdir=$($PKG_CONFIG --variable=systemdsystemunitdir systemd)
> > 
> >     AS_IF([test "x$def_systemdsystemunitdir" = "x"],
> >   [AS_IF([test "x$with_systemdsystemunitdir" = "xyes"],
> >    [AC_MSG_ERROR([systemd support requested but pkg-config unable to query systemd package])])
> >    with_systemdsystemunitdir=no],
> >   [with_systemdsystemunitdir="$def_systemdsystemunitdir"])])
> > AS_IF([test "x$with_systemdsystemunitdir" != "xno"],
> >      [AC_SUBST([systemdsystemunitdir], [$with_systemdsystemunitdir])])
> > AM_CONDITIONAL([HAVE_SYSTEMD], [test "x$with_systemdsystemunitdir" != "xno"])
> > 
> > Would something like that work ?
> 
> Probably. But while we do have autoconf wired up, the primary way of
> building Git does not use it, but rather uses `config.mak.uname`. I'd
> recommend to have a look at it to figure out how we handle other
> build-time options there.
> 
> Patrick

I'll take a look, thanks.


-- 
Max Gautier
