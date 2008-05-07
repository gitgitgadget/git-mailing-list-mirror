From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: git-checkout sometimes silently fails
Date: Wed, 7 May 2008 11:09:27 -0400
Message-ID: <20080507150927.GA11447@fieldses.org>
References: <20080506122256.04ca7d77.akpm@linux-foundation.org> <20080506215049.GC4647@steel.home> <20080506171052.340d643e.akpm@linux-foundation.org> <7v4p9bge4q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 17:12:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtlIQ-0004KF-Hv
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 17:11:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757131AbYEGPKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 11:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754335AbYEGPKA
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 11:10:00 -0400
Received: from mail.fieldses.org ([66.93.2.214]:44450 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757082AbYEGPJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 11:09:57 -0400
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JtlGp-00035J-Rn; Wed, 07 May 2008 11:09:27 -0400
Content-Disposition: inline
In-Reply-To: <7v4p9bge4q.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81445>

On Tue, May 06, 2008 at 05:19:01PM -0700, Junio C Hamano wrote:
> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > y:/usr/src/git26> git-branch -av | grep '^\*'
> > * master               5717922 Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb
> > y:/usr/src/git26> git-checkout linux-next    
> > Switched to branch "linux-next"
> > y:/usr/src/git26> git-branch -av | grep '^\*'
> > * linux-next           5717922 Merge branch 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jwessel/linux-2.6-kgdb
> 
> So your two local branches 'master' and 'linux-next' both point at the
> same commit, 5717922.
> 
> "git checkout <branchname>" is to check out the local branch name.  You
> expect "git checkout master" and then "git checkout linux-next" to check
> out two different commits because linux-next _should_ have been updated to
> the latest from sfr repository.  But it appears to me that that is not the
> case.
> 
> Perhaps "git fetch linux-next" hasn't been run, before "git checkout" was
> attempted?

Might also be worth checking whether there happens to be a tag (or
something else?) named the same as one of the branches?  I remember the
public -mm git repo, for example, having a tag named "master".  Yuch.

Grepping through git-for-each-ref output might shed some light.

--b.
