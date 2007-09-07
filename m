From: Josh England <jjengla@comcast.net>
Subject: Re: how to access working tree from .git dir?
Date: Fri, 07 Sep 2007 15:27:01 -0600
Message-ID: <1189200421.12525.8.camel@beauty>
References: <1189120800.6203.23.camel@beauty>
	 <7v642m436q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 23:26:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITlLg-0005Xz-Ll
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 23:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547AbXIGV0j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 17:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758480AbXIGV0j
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 17:26:39 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:47078 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbXIGV0i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 17:26:38 -0400
Received: from [192.168.0.133] (c-68-54-9-220.hsd1.nm.comcast.net[68.54.9.220])
          by comcast.net (rwcrmhc13) with SMTP
          id <20070907212637m13003lgcbe>; Fri, 7 Sep 2007 21:26:38 +0000
In-Reply-To: <7v642m436q.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58078>

On Fri, 2007-09-07 at 13:43 -0700, Junio C Hamano wrote:
> "Josh England" <jjengla@sandia.gov> writes:
> 
> > In messsing around with hooks, I've discovered that not all hooks are
> > run in the same environment.  In particular, the current working
> > directory in the post-receive hook (maybe others as well) is the GIT_DIR
> > (.git) directory, instead of the root of the working tree (as in
> > pre-commit).
> 
> It is not even "instead of"; that's the only sane thing to do
> for post-receive, which is in response to git-push and usually
> used for a bare repository, i.e. without any work tree.

I thought there was probably a sane reason for it.  That is perfectly
acceptable, but the problem still exists that there doesn't seem to be a
good way to access the top of the working tree from within the GIT_DIR.
Since I now know that post-receive has a CWD in .git, I could just use
`pwd`/../ , but I was hoping for a better (read: consistent between
hooks) solution.

-JE
