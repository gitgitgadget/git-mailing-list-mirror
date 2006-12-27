From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFH] An early draft of v1.5.0 release notes
Date: Wed, 27 Dec 2006 03:18:19 -0500
Message-ID: <20061227081819.GB23022@spearce.org>
References: <7vvejx948y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 09:19:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzU0C-0003SG-8X
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 09:19:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbWL0IS3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 03:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752301AbWL0IS2
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 03:18:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55986 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724AbWL0ISY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 03:18:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzTzY-0005dZ-T3; Wed, 27 Dec 2006 03:18:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 878AB20FB65; Wed, 27 Dec 2006 03:18:20 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvejx948y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35454>

Junio C Hamano <junkio@cox.net> wrote:
> This is still rough, but I think we have a pretty good idea what
> will and what won't be in v1.5.0 by now, and end-of-year is a
> good slow time to summarize what we have done.

This is certainly a good idea.  And your summary was pretty good
too, I enjoyed the read.  This group has certainly accomplished
quite a bit lately!

Just a few comments:
 
>  - Pack-compatible loose object headers, introduced between
>    v1.4.1 and v1.4.2; repository cannot be read with ancient
>    version of git anymore -- this is a one-way street but
>    core.legacyheaders is still not enabled by default);
> 
>  - delta-base-offset pack encoding, introduced between v1.4.2
>    and v1.4.3; this is also a one-way street.

Perhaps you can clarify that using these means the repository
cannot be used with an earlier version of Git?  You may also want
to highlight why these features are good, answering the question
"Why should I enable them if it breaks backwards compatibility?".

Isn't the new packed-refs format also a one-way street?  If you
use them for tags on a web server and the client is using a very
old http commit walker, what happens?
 
>  - git-clone used to be buggy and copied refs outside refs/heads
>    and refs/tags; it doesn't anymore.

I mentioned to you on #git this morning that I don't think this
is noteworthy for this release.

You missed talking about the mess of pack files created by git-push
now, especially with pushes over 100 objects.  ;-)
 
>  - git-push can now be used to delete a remote branch or a tag.

You should mention this requires server side support too.  I read
that and assumed I could just upgrade my client and push to delete
- which isn't the case, and I know its not...  but I still read it
that way.
 
>  - "git show-branch" learned showing the reflog data with the
>    new --reflog option.

I had hoped we could get 'git reflog show' into 1.5.0 but the
current discussion with Johannes seems like that's unlikely.
 
>  - We have been depended on "merge" program from RCS suite for
>    the file-level 3-way merge, but now we lost this dependency.

Perhaps just reword as:

	We no longer require the "merge" program from the RCS suite.
	All 3-way file-level merges are now done internally.
 
>  - git-shortlog is not in Perl anymore, and more importantly it
>    does not have to be piped output from git-log.  It can
>    traverse the commit ancestry itself.

The "traverse the commit ancestry itself" part is not very
readable for the average user.  How about instead:

	git-shortlog is no longer a Perl script.  git-shortlog also
	no longer requires output piped from git-log; it can accept
	revision parameters directly on the command line.

-- 
Shawn.
