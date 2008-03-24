From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: What I miss from Cogito...
Date: Sun, 23 Mar 2008 20:16:17 -0400
Message-ID: <20080324001617.GB24943@mit.edu>
References: <47E69044.3000207@zytor.com> <20080323173841.GA24943@mit.edu> <20080323182102.GA22551@bit.office.eurotux.com> <87r6e1b6c8.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 01:17:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdaNL-0005hT-2x
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 01:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448AbYCXAQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 20:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757447AbYCXAQg
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 20:16:36 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:54737 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757375AbYCXAQg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2008 20:16:36 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m2O0GO8B017588;
	Sun, 23 Mar 2008 20:16:24 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m2O0GI9h001122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 23 Mar 2008 20:16:23 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.67)
	(envelope-from <tytso@mit.edu>)
	id 1JdaML-00070b-Ot; Sun, 23 Mar 2008 20:16:17 -0400
Content-Disposition: inline
In-Reply-To: <87r6e1b6c8.fsf@mid.deneb.enyo.de>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77980>

On Sun, Mar 23, 2008 at 08:14:47PM +0100, Florian Weimer wrote:
> 
> Personally, I'm not all that happy with the multiple different meanings
> of "git reset" and "git checkout", either.  Depending on the parameters,
> the two comments manipulate both the contents of the working copy, or
> the location at which the working copy is hooked in the history.  If we
> need to have two separate commands for this, it would make more sense to
> draw distinction between the two aspects, and not the mess we have now.
> OTOH, it's probably too late for that.

Yeah, it's not at all intuitive.  I've been using git for quite some
time and had *absolutely* *no* *idea* that "git checkout <treeish> --
path" did what "bk revert" and "hg revert" does.  In fact, I'm pretty
sure I remember asking for this functionality a while back, and being
told the right answer was "git show HEAD:pathname > pathname", and I
kept on typing it until I got sick and tired of it, and so I created
my short-hand shell script.  

And the fact that Peter was using "git reset --hard -- pathname" is
another hint that it isn't at *all* obvious that "git checkout" does
two completely different things, and it's not something that you're
likely to intuit from the name or looking at the top-level git man
page (where the summary in the top-level git manpage is, "checkout and
switch to a branch").

If we were going to separate the two commands out, I'd use the name
"git revert-file", because that's what people who are coming from bk
or hg are used to (where "revert" means to undo the local edits done
to a particular file, as opposed to the git meaning of undoing a
particular commit).

						- Ted
