From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] submodule: handle trailing slash, warn about
 non-submodules
Date: Fri, 6 Feb 2009 12:41:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902061238060.7377@intel-tinevez-2-302>
References: <cover.1233892769u.git.johannes.schindelin@gmx.de> <b14e34d2529721c24437ec9da3f8f15c916d4051.1233892769u.git.johannes.schindelin@gmx.de> <7vzlh0875l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 12:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVP70-00060h-7m
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:43:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311AbZBFLlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753069AbZBFLln
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:41:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:47345 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752660AbZBFLln (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:41:43 -0500
Received: (qmail invoked by alias); 06 Feb 2009 11:41:41 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp019) with SMTP; 06 Feb 2009 12:41:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+pNBc4GBappM8Brox4E/kzk2lF4kULOuLYCnjO1L
	Mc098JAFlNqhFg
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vzlh0875l.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108691>

Hi,

On Thu, 5 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Earlier, when you called
> >
> > 	git submodule path/to/submodule/
> >
> > (which happens easily if you are a heavy user of tab-completion), Git
> > would silently ignore the given path, as "git ls-files path/to/submodule/"
> > does not return anything due to the trailing slash.
> 
> Does --error-unmatch help in such a case to avoid shell loops?

No, as the second issue solved by the shell loop still holds true:

	$ git ls-files --error-unmatch submodule/
	error: pathspec 'submodule/' did not match any file(s) known to git.
	Did you forget to 'git add'?

That would be really awkward, don't you think?

BTW I have been asked about this behavior _easily_ a 50 times.  I just 
finally broke down and went for the easiest solution.

A proper solution would most probably involve a rewrite as a builtin.

Ciao,
Dscho
