From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: merging initial part of a branch?
Date: Thu, 12 Jan 2006 22:08:37 -0500
Message-ID: <20060113030837.GD27214@fieldses.org>
References: <20060111230451.GH8618@fieldses.org> <7vek3epbs9.fsf@assigned-by-dhcp.cox.net> <20060112005531.GB14599@fieldses.org> <7vmzi2i5eu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 04:09:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExFJ1-0008Tm-Ul
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 04:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbWAMDIj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 22:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161638AbWAMDIj
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 22:08:39 -0500
Received: from mail.fieldses.org ([66.93.2.214]:19616 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1161155AbWAMDIi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 22:08:38 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.60)
	(envelope-from <bfields@fieldses.org>)
	id 1ExFIr-0001io-A7; Thu, 12 Jan 2006 22:08:37 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzi2i5eu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14604>

On Wed, Jan 11, 2006 at 05:47:05PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> >> I haven't tried this for some time, but I presume
> >> 
> >> 	$ git pull linus tag v2.6.15
> >> 
> >> would do what you want.
> >
> > Yep!  Thanks.  The only documentation I can find for this is a slightly
> > obscure bit in the git-pull man page which lists this as a "short-cut"
> > notation.  What is it a shortcut for?  Is it possible to specify an
> > arbitrary commit in place of the "tag v2.6.15" somehow?
> 
> The phrase "short-hand" refers to "linus" in the above example.
> I.e. the name of the file in $GIT_DIR/remotes that records the
> URL (among other things).

No, I'm referring to the following language:

	"Some short-cut notations are also supported.

	"For backward compatibility, tag is almost ignored; it just
	makes the following parameter <tag> to mean a refspec
	refs/tags/<tag>:refs/tags/<tag>."

That's the only reference I can find to the "tag <tag>" notation, and
it's a bit unhelpful as written.  (What backward compatibility?)

How about the following?--b.


diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index b5b9792..4524fee 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -134,9 +134,9 @@ is often useful.
 +
 Some short-cut notations are also supported.
 +
-* For backward compatibility, `tag` is almost ignored;
-  it just makes the following parameter <tag> to mean a
-  refspec `refs/tags/<tag>:refs/tags/<tag>`.
+* `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`; 
+  used with pull or fetch, it requests fetching everything up to
+  the given tag.
 * A parameter <ref> without a colon is equivalent to
   <ref>: when pulling/fetching, and <ref>`:`<ref> when
   pushing.  That is, do not store it locally if
