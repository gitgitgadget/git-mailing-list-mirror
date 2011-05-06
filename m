From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Fri, 6 May 2011 09:50:37 -0500
Message-ID: <20110506145036.GB2991@elie>
References: <4DB9329E.7000703@op5.se>
 <88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
 <7vhb986chl.fsf@alter.siamese.dyndns.org>
 <BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
 <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
 <BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
 <20110506065601.GB13351@elie>
 <BANLkTimVjZgOJk1ik7fbhQvW21Fo9eZoXg@mail.gmail.com>
 <20110506141719.GA2991@elie>
 <BANLkTikW2u2W=Hpw2G4VJf_h88x4_7x_=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 16:50:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIMMo-0004pP-Kx
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 16:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755024Ab1EFOup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 10:50:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38568 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab1EFOun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 10:50:43 -0400
Received: by iwn34 with SMTP id 34so2728941iwn.19
        for <git@vger.kernel.org>; Fri, 06 May 2011 07:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YGLXT2yt4pWl+yBfZFbfagiXXW0TdExIb0qC/3+lqBM=;
        b=tyDmry2h/sOCoPlmF35YkV7A9Nw8I/JXoQwAXmO2NSxh86V1DHVIp6s1GQFb4Z4EQA
         TMde4xsQz4jLo0RCZNpZXJkTcRGJMNPRB/dMZTEPe58Do/LSfJtEuSlI0gQGa+mtGNww
         UIMyNCVjacNUzy+XD4yqR2gPQfOIOLI8BIpbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dDO3pAXvSjWW7esTnrGl36RC1xcZdKrEnKXP1XYPZJCpaHjpt7g7crNf/iNXzYGgj1
         P6ZOg7l24aLfX+lZRGeNQriCjZldtlGQIQEH55JS45V+Js12st2m8qjeLIec55sF95z5
         1cWQHDIK4wCmPDMSc0mjn4zYlVIrX9x/orYsY=
Received: by 10.42.169.67 with SMTP id a3mr1189908icz.160.1304693442495;
        Fri, 06 May 2011 07:50:42 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id a8sm1369703ibg.48.2011.05.06.07.50.39
        (version=SSLv3 cipher=OTHER);
        Fri, 06 May 2011 07:50:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTikW2u2W=Hpw2G4VJf_h88x4_7x_=Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172979>

Jon Seymour wrote:

> Partly because that is second guessing &/or reverse engineering the
> distribution's decisions and

Well, no --- that's what /usr/local is _for_:
http://www.pathname.com/fhs/pub/fhs-2.3.html#USRLOCALLOCALHIERARCHY

> it won't work for a Windows install where there is no /usr/local

That's true.  I believe command-line users on Windows who install by
unzipping to a directory are used to having to set a PATH for
themselves.  Perhaps it would be convenient for git to learn to add a
specific standard directory to its private PATH as a Windows-specific
extension, though.

If your goal is to make installing new commands for git easier than
installing native apps --- why?  It seems backwards.  Consider that
the end result ought to be easy not only for the app developer but for
the end user, and if every program with the ability to call other
programs sets up its own better replacement for standard operating
system facilities, that will make for a complicated system to
administer indeed.  So with that in mind, it might be simpler to take
advantage of existing project that simplifies installation of native
apps, like <http://zero-install.sourceforge.net/>.

The development environment for git on Windows (mysgit) does provide a
directory hierarchy complete with /usr et al, so people using that
very well might want to install to /usr/local.  Likewise with Cygwin.

> Not that I currently, have a need, but Junio did mention the case
> where someone wants to enhance an existing git command with a wrapper
> of some kind.

For reasons you've hinted at before, Git deliberately does not allow
that (similarly, it does not allow git aliases to override existing
commands).  $GIT_EXEC_PATH comes first on the PATH that git uses
internally.  That's a feature, not a bug, imho.
