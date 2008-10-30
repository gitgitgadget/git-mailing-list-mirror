From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] Documentation: add a planning document for the next
	CLI revamp
Date: Thu, 30 Oct 2008 10:39:18 -0400
Message-ID: <20081030143918.GB14744@mit.edu>
References: <1225338485-11046-1-git-send-email-sam@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <samv@vilain.net>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 15:40:49 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvYhQ-0007wq-Cn
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 15:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbYJ3OjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 10:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbYJ3OjW
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 10:39:22 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:57888 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754615AbYJ3OjV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 10:39:21 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KvYgB-0006uS-LV; Thu, 30 Oct 2008 10:39:19 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KvYgA-0007vp-T3; Thu, 30 Oct 2008 10:39:18 -0400
Content-Disposition: inline
In-Reply-To: <1225338485-11046-1-git-send-email-sam@vilain.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99473>

On Wed, Oct 29, 2008 at 08:48:05PM -0700, Sam Vilain wrote:
> From: Sam Vilain <samv@vilain.net>
> 
> For cross-command CLI changes to be effective, they need to be
> cohesively planned.  Add a planning document for this next set of
> changes.

Here are my favorites:

* Add the command "git revert-file <files>" which is syntactic sugar for:

        git checkout HEAD -- <files>

  Rationale: Many other SCM's have a way of undoing local edits to a
  file very simply, i.e."hg revert <file>" or "svn revert <file>", and
  for many developers's workflow, it's useful to be able to undo local
  edits to a single file, but not to everything else in the working
  directory.  And "git checkout HEAD -- <file>" is rather cumbersome
  to type, and many beginning users don't find it intuitive to look in
  the "git-checkout" man page for instructions on how to revert a
  local file.

* Change the argument handling for "git format-patch" so it is
  consistent with everything else which takes a set of commits.  Yes,
  it means that where people have gotten used to typing "git
  format-patch origin", they'll have to type instead: "git
  format-patch origin..", but's much more consistent.  We've done the
  best we can by documenting the existing behavior, but if'we re going
  to make major, potentially incompatible, CLI changes, this is
  something to at least consider.  Maybe with a config file for people
  who really don't want to retrain their fingers to type the two extra
  periods?

						- Ted
