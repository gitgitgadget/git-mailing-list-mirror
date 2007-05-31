From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH (tig)] Infrastructure for tig rpm builds.
Date: Thu, 31 May 2007 15:16:16 +0200
Message-ID: <20070531131615.GA27044@diku.dk>
References: <200705281054.05376.jnareb@gmail.com> <20070529202923.GA6358@diku.dk> <200705300131.17137.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 15:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htkbl-0002UJ-0z
	for gcvg-git@gmane.org; Thu, 31 May 2007 15:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbXEaNWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 09:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbXEaNWT
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 09:22:19 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:41301 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbXEaNWS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 09:22:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 152C9778024;
	Thu, 31 May 2007 15:22:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qd+6SHeRoW1c; Thu, 31 May 2007 15:22:15 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 3FBC8F0044;
	Thu, 31 May 2007 15:16:16 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 645AE6DFD36; Thu, 31 May 2007 15:14:13 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 2A05262A5D; Thu, 31 May 2007 15:16:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200705300131.17137.jnareb@gmail.com>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48809>

Jakub Narebski <jnareb@gmail.com> wrote Wed, May 30, 2007:
> On Tue, 29 May 2007, Jonas Fonseca wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote Mon, May 28, 2007:
> [...]
> By the way, isn't Ubuntu based on Debian? Do you
> have rpmbuild installed?

Yes it is Debian-based and yes I do, but I don't know if I need to do
something explicitly to get it working. Mostly, prefixing things with
'sudo' works magic on Ubuntu but not in this case. ;)

> BTW. perhaps you could provide spec equivalent for building tig*.deb?

Well, there already exists a Debian package for tig so it would be easy
to lift the files required and if the Debian maintainer wanted it, sure.
However, not as simple as a .spec file so it is more work to maintain.
 
>   1000:[master!tig]$ make rpm

Maybe you can test the newly released tig 0.7 tarball?

Your patch was added as commit 8cdf56913e7e486bb3f527c24ee4a4d19f2a4f61,
with a few minor adjustments.
 
> [...]
> >> +%files
> >> +%defattr(-,root,root)
> >> +%{_bindir}/*
> >> +%doc README COPYING INSTALL SITES BUGS TODO tigrc
> 
> By the way, should we put tigrc in examples/tigrc, or perhaps in some
> skeleton file?

It is mostly the default (builtin) options, so I don't see the point.
Maybe it is time tig got a contrib area though, since I've been wanting
to make a bash completion file. The tigrc file could go there as
tigrc.sample or something. Could make it more obvious the intension of
the file?

> > I don't know if manual.txt should perhaps be included if
> > HTML and PDF files will not be generated.
> > 
> >> +%{!?_without_docs: %{_mandir}/man1/*.1*}
> >> +%{!?_without_docs: %{_mandir}/man5/*.5*}
> >> +%{!?_without_docs: %doc *.html *.pdf}
> 
> O.K. It would be as easy as %{?_without_docs: %doc *.txt}

I will try to correct this together with the no-PDF doc-building.

-- 
Jonas Fonseca
