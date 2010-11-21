From: tom fogal <tfogal@sci.utah.edu>
Subject: Re: rebuild repo from data, packfiles?
Date: Sat, 20 Nov 2010 19:44:52 -0700
Message-ID: <auto-000024045093@sci.utah.edu>
References: <auto-000024044659@sci.utah.edu>  <20101121001643.GB27666@burratino>
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 21 03:46:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJzwZ-0000Rw-UZ
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 03:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757400Ab0KUCpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 21:45:42 -0500
Received: from mail.sci.utah.edu ([155.98.58.80]:28748 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756930Ab0KUCpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 21:45:41 -0500
Received: from dummy.name; Sat, 20 Nov 2010 19:45:38 -0700
In-Reply-To: Your message of "Sat, 20 Nov 2010 18:16:48 CST."
             <20101121001643.GB27666@burratino> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161852>

Hi John, thanks for the help.

Jonathan Nieder <jrnieder@gmail.com> writes:
> tom fogal wrote:
> 
> > Long story short, I lost some metadata in a repo I've got.
> > However, my entire .git/objects/ && subdirs is intact, so I'm
> > hopeful my data's still accessible in some form.

Turns out I'm dumber than I thought =(. I had a lot of trouble with
trees seemingly becoming invalid after a bit... my shell history's got
an rm -r and deleted a lone packfile before I thought "what the hell am
I doing?!" and stopped, so that must be it.

> Here's what I'd suggest.
[snip]

The repository-layout info and the lost-found option to fsck were both
new to me, and quite useful.  Thanks!

Where I'm at now: through lost-found, mucking with metadata enough
that git-log and format-patch work, and re-creating a repo to apply
patches onto, I've got a lot of my work back.  There's a 3 or 4 week
gap though, and of course git has trouble dealing with that; some of my
"patches" actually add entire files and the like.

If I git cat-file -p all of the `commit' and `blob' sha1's in
.git/objects, it looks to me like all my code is there, I just need to
get it out somehow.

My thought is to cat-file all my commits, filter out the ones which are
upstream, order them by date, and git-am them back into a repo.

Some of my data only exist in blobs, though... maybe git-diff-tree
can get me the patch I need?  Not quite sure what to diff it with,
though... maybe the most-recent sha1 I have, based on date?

Other ideas would certainly be welcome!

-tom
