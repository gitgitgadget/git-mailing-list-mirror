From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Jan 2013, #08; Tue, 22)
Date: Wed, 23 Jan 2013 21:12:37 +0000
Message-ID: <20130123211237.GR7498@serenity.lan>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
 <20130122234554.GI7498@serenity.lan>
 <7vobgglpv4.fsf@alter.siamese.dyndns.org>
 <20130123092858.GJ7498@serenity.lan>
 <7vsj5rhlfs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 22:13:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty7d7-0003zI-Km
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 22:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab3AWVMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 16:12:48 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:49975 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab3AWVMr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 16:12:47 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 7AB2822E9C;
	Wed, 23 Jan 2013 21:12:46 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8c6sD7S5F35k; Wed, 23 Jan 2013 21:12:45 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 023692305F;
	Wed, 23 Jan 2013 21:12:39 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vsj5rhlfs.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214365>

On Wed, Jan 23, 2013 at 09:13:27AM -0800, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > My preference would be for something like this, possibly with an
> > expanded examples section showing how to pipe the output of cvsps-3 or
> > cvs2git into git-fast-import:
> >
> > -- >8 --
> >
> > diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> > index 9d5353e..20b846e 100644
> > --- a/Documentation/git-cvsimport.txt
> > +++ b/Documentation/git-cvsimport.txt
> > @@ -18,6 +18,11 @@ SYNOPSIS
> >  
> >  DESCRIPTION
> >  -----------
> > +*WARNING:* `git cvsimport` uses cvsps version 2, which is considered
> > +deprecated; it does not work with cvsps version 3 and later.  If you are
> > +performing a one-shot import of a CVS repository consider using cvsps-3,
> > +cvs2git or parsecvs directly.
> > +
> >  Imports a CVS repository into git. It will either create a new
> >  repository, or incrementally import into an existing one.
> >  
> > -- 8< --
> 
> OK, that is certainly a lot simpler to explain.
> 
> Is it "it does not work yet with cvsps3", or "it will not ever work
> with cvsps3"?  The impression I am getting is that it is the latter.

The existing script (git-cvsimport.perl) won't ever work with cvsps-3
since features it relies on have been removed.

> Also, should we have a suggestion to people who are *not* performing
> a one-shot import, i.e. doing incremental or bidirectional?

As far as I know cvsps is the only backend that attempts to support
partial exports but the support for that in its fast-export mode needs
work before I would consider it reliable.  For now the existing
git-cvsimport is the best option I'm aware of.


John
