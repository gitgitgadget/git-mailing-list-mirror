From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Add gitattributes file making whitespace checking
	pickier
Date: Sat, 9 Feb 2008 18:36:58 -0500
Message-ID: <20080209233658.GB20501@fieldses.org>
References: <20080209162234.GA25533@fieldses.org> <alpine.LNX.1.00.0802091251430.13593@iabervon.org> <20080209185038.GB25533@fieldses.org> <7vr6fletkl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 00:38:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNzGo-0004dP-Ip
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 00:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846AbYBIXhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 18:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755742AbYBIXhE
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 18:37:04 -0500
Received: from mail.fieldses.org ([66.93.2.214]:39311 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755403AbYBIXhC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 18:37:02 -0500
Received: from bfields by fieldses.org with local (Exim 4.69)
	(envelope-from <bfields@fieldses.org>)
	id 1JNzFi-0005td-CP; Sat, 09 Feb 2008 18:36:58 -0500
Content-Disposition: inline
In-Reply-To: <7vr6fletkl.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73274>

On Sat, Feb 09, 2008 at 12:57:46PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > Yeah, fair enough.  Hard to know where to start, though.  OK, just to
> > get an idea, I committed a completely empty tree, made a diff (with
> > --binary), then applied with --whitespace=fix and compared to the
> > original.  In some cases these seem to be accidental, in some cases
> > (git-p4) I assume they're intended to use the different style.
> 
> I personally have this in .git/config
> 
> [core]
> 	whitespace = indent,trail,space
> 
> and the following three lines in contrib/.gitattributes (untracked)
> 
> *.py whitespace=!indent,trail,space
> *.el whitespace=!indent,trail,space
> fast-import/git-p4 whitespace=!indent,trail,space
> 
> The latter I added after receiving a fix-up patch from Toby
> Allsopp a few days ago.  I applied git-p4 patch with the
> strictest rule.
> 
> As you argued correctly earlier, when we made the whitespace
> rules per-path using the attributes mechanism, the whitespace
> policy should be project wide, just like coding style, so I
> think it is a good idea to have in-tree .gitattributes files
> that spell out what the policy is more explicitly.
> 
> At least I think we can all agree that this one entry in the
> toplevel .gitattributes is a safe and good idea.
> 
> *.[ch] whitespace

Sounds good to me (but so does your configuration above, and if you've
been running with it for a while then it must not to too bad....)

> I am not sure about the AsciiDoc Documentation.  I've always
> assumed that the docs would format exactly the same before and
> after running expand and/or unexpand on Documentation/*.txt

That's what I'd assumed too.

--b.

> , and
> if that is indeed the case we should add
> 
> *.txt whitespace
> 
> to Documentation/.gitattributes as well.
> 
> Then I should _discard_ the one in my .git/config and the
> untracked contrib/.gitattributes file.
