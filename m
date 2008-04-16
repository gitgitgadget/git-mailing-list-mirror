From: David Kastrup <dak@gnu.org>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 11:14:43 +0200
Message-ID: <86lk3ecgak.fsf@lola.quinscape.zz>
References: <20080416062925.8028e952@zebulon.innova-card.com>
	<20080416063739.4B72647879@blf.utvinternet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 11:15:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm3jt-0007oI-NN
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 11:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbYDPJOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 05:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbYDPJOx
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 05:14:53 -0400
Received: from main.gmane.org ([80.91.229.2]:54567 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbYDPJOw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 05:14:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jm3j8-0001rI-MF
	for git@vger.kernel.org; Wed, 16 Apr 2008 09:14:50 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 09:14:50 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 09:14:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:uVTKTnzQ9z//3W4icj3UPyy9wRk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79688>

Brian Foster <brian.foster@innova-card.com> writes:

>    (many many apologies if this turns into a double post,
>   there seems to have been problems with the 1st attempt?)
>
>  I've recently inherited a bare git repository,
>  which, as far as I can tell (I'm something of
>  a newbie with git), seems Ok: `git fsck --full'
>  does not report any problems.    however, any
>  clones I make from it are not Ok:
>
> 	$ git-fsck --full   # clone (same command for bare repo is Ok)
> 	broken link from  commit dd3f3c0636cfd50719c706b030db5473b0270add
> 		      to  commit 0fed9c2eb14eee47097e1d870fe8e55a6430edeb
> 	missing commit fb57c018d15005b60f104e57f198ff34a6035b99
> 	missing commit f8947cb0b5fe605e6cb5f73c89f262424b64ef3c
> 	missing commit 0fed9c2eb14eee47097e1d870fe8e55a6430edeb
> 	missing commit dff364d8da15be0b856a174062fb785acb1c363e

>From the git-clone manpage


	--shared, -s
	    When the repository to clone is on the local machine,
	    instead of using hard links, automatically setup
	    .git/objects/info/alternates to share the objects with
	    the source repository. The resulting repository starts
	    out without any object of its own. NOTE: this is a
	    possibly dangerous operation; do not use it unless you
	    understand what it does. If you clone your repository
	    using this option, then delete branches in the source
	    repository and then run git-gc(1) using the --prune
	    option in the source repository, it may remove objects
	    which are referenced by the cloned repository.

Did you use something like that?

-- 
David Kastrup
