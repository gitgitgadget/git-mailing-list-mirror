From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Documentation/git-filter-branch: Remove Useless Use of
	Plumbing
Date: Thu, 24 Jul 2008 00:02:30 +0200
Message-ID: <20080723220230.GP32184@machine.or.cz>
References: <20080722222418.15372.62190.stgit@localhost> <7vd4l5jwi4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 00:03:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLmQq-0003L2-Fm
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 00:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbYGWWCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 18:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753958AbYGWWCc
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 18:02:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55533 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886AbYGWWCc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 18:02:32 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 24E23393A36E; Thu, 24 Jul 2008 00:02:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vd4l5jwi4.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89789>

On Tue, Jul 22, 2008 at 05:05:07PM -0700, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > The example to remove file using index-filter uses git update-index
> >  --remove where git rm --cached works as well.
> 
> I am not sure "works as well" is a good enough justification to choose a
> Porcelain command over a plumbing command in this particular context.
> After all, filter-branch is a scripting enviornment, isn't it?

But one of the few that are regularly used even by "mere users", who
would be probably put off unnecessarily by using this mysterious command.
(We might also say that I'm testing Dscho's suggestions, though this
patch was of course provoked by a "huh" of a user I was helping.)

> There also is another subtle difference.  "git rm" takes pathspecs while
> "update-index" takes paths.
> 
> So after running one of these commands:
> 
> 	$ git rm --cached 'Makefil?'
> 	$ git update-index --force-remove 'Makefil?'
> 
> output from:
> 
> 	$ git diff --cached --stat
> 
> would be different.

I don't think this is relevant for the example in question. Users are as
likely to be bit by or take advantage of this as by regular git rm
usage.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
