From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 01:32:45 +0200
Message-ID: <20080909233245.GC7459@cuci.nl>
References: <20080909132212.GA25476@cuci.nl> <20080909211355.GB10544@machine.or.cz> <20080909225603.GA7459@cuci.nl> <20080909230525.GC10360@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 10 01:34:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdCig-0004vk-9q
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:34:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756838AbYIIXcr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756820AbYIIXcr
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:32:47 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:39708 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797AbYIIXcq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:32:46 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 41BAC5465; Wed, 10 Sep 2008 01:32:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080909230525.GC10360@machine.or.cz>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95461>

Petr Baudis wrote:
>On Wed, Sep 10, 2008 at 12:56:03AM +0200, Stephen R. van den Berg wrote:

>In other way, I think this is purely a porcelain matter and recording
>this information in the free-form area is more than enough.

>> I'd prefer to formalise the (weak) relationship of an origin link, instead of
>> relying on vague assumptions when parsing the free-form commit message
>> and then guessing what the mentioned hash might mean.

>Why?

Using special references in the free-form area of a commit is akin to
using X-... headerfields in E-mail with all the assorted mess:
- No strict definition of what it means.
- Diverging porcelain implementations making use of the field in ever so
  slightly changing ways over the years.
- You cannot rely on the field being always available.
- Automated "renumbering" becomes difficult at best.

What we want are concise and unambiguous definitions which allow us to
build tools that operate predictably on them now, and will operate
predictably on them in the future.

>> >Having history browsers draw fancy lines is fine but I see nothing wrong

>> It's not just that.  If I make a change to an area that was cherrypicked
>> from another branch, then I find it rather important to check if any
>> changes to this area need to be backported/forwardported to the branches
>> the origin links are pointing to.
>> I.e. the origin link allows me to improve my efficiency as a programmer.

>And why are the notes created by git cherry-pick -x insufficient for that?

Things like rebase/filter-branch/stgit mess that up because they don't
know if the hash in the free-form should be altered.
Also, there is no automated way to actually fetch missing branches we
cherry-picked from this way.
-- 
Sincerely,
           Stephen R. van den Berg.

"Be spontaneous!"
