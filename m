From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Add "--show-all" revision walker flag for debugging
Date: Sun, 10 Feb 2008 12:17:21 -0800 (PST)
Message-ID: <m3myq8fwdx.fsf@localhost.localdomain>
References: <alpine.LFD.1.00.0802091341210.2896@woody.linux-foundation.org>
	<alpine.LSU.1.00.0802100110450.11591@racer.site>
	<alpine.LFD.1.00.0802092016540.2732@xanadu.home>
	<alpine.LSU.1.00.0802100130090.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:18:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOIcp-0005Ki-Eb
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:18:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430AbYBJUR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 15:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753351AbYBJUR1
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:17:27 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:8009 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbYBJUR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:17:26 -0500
Received: by fg-out-1718.google.com with SMTP id e21so3561311fga.17
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 12:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=VAPLU5jnJbFI52at7ck0xDDCkVRibqCF0kEnstrTbxI=;
        b=UChacqr9AzRuSxjsgS3ZVvl28CbtgTUJY7U05SjTsIZ52vXjO8Oc1j95LgcxWUgFzkOXV/Ly7w0wRrznMg8Nz0taE79BgYf2QFHer3VKpB9PyEfPd7NI07FnXfVNoYgaqBaCzUNqEM8evRe/3VofiHvyou0rLzZC0UFn1j9Gx8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=iZZ3LS7b9T932CUGk4tnvN1YxXp+3hqzvirGch6mJkYO5mFWDvlKC7VhXp58A+Fy31fhFLPdOBuhlFVEnevK7/sQTJX2WHMk0sCRhANrc8TtwbYcNbsST4yanTYta1kXUPb5q9KlbjTz2A/WQ6jnIXjCj4B6231wt9MrqEH0LrU=
Received: by 10.82.158.12 with SMTP id g12mr27966030bue.18.1202674642804;
        Sun, 10 Feb 2008 12:17:22 -0800 (PST)
Received: from localhost.localdomain ( [83.8.220.19])
        by mx.google.com with ESMTPS id z37sm17427011ikz.1.2008.02.10.12.17.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Feb 2008 12:17:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m1AJNwhJ031754;
	Sun, 10 Feb 2008 20:23:59 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m1AJNsOu031751;
	Sun, 10 Feb 2008 20:23:54 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <alpine.LSU.1.00.0802100130090.11591@racer.site>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73398>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 9 Feb 2008, Nicolas Pitre wrote:
> 
> > I, too, have some reservations about adding any kind of generation 
> > header to commit objects.  First because it can be generated and 
> > maintained locally, just like the pack index.  But also because its 
> > usefulness has not been proven in all possible graph topologies, and 
> > adding it to the commit header pretty much deny any further 
> > modifications/improvements on it, if for example some other kind of 
> > generation notation becomes advantageous to use.
> 
> I fully agree.

I think I'd agree, also because without 'generation' (and 'roots')
commit object header being there from beginning it is not clear when
to calculate it: the first few commits with it would be costly.
Besides graft and shallow information is local, and it affect commit
traversal.

I was thinking about pack-index like file, either directly mapping
"sha1 -> generation + roots", or indirectly "sha1 -> offset", 
"offset -> generation + roots".


P.S. Would having generation + roots be enough?

  gen(rev) = max_i { gen(i) + 1 : i in parents(rev) } || 1

  roots(rev) = { rev  if rev is a root (parentless) commit 
               { union of roots of parents of a commit otherwise

Union in the sense of set sum.

Note that if roots was to be saved in commit header, then it couldn't
be as simple as commit-id for root commits: no self links. It would
have to be empty for root commits, and the "union of roots" would have
to be modified to "union of roots or commit ids for root commits, of
each of parents of a commit".

-- 
Jakub Narebski
Poland
ShadeHawk on #git
