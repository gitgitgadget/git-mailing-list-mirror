From: "Chris Friesen" <cfriesen@nortel.com>
Subject: Re: any way to apply tag across all branches in repository?
Date: Tue, 19 May 2009 13:05:49 -0600
Message-ID: <4A13030D.8000000@nortel.com>
References: <4A12DDB9.60608@nortel.com> <Y0WmOpNg_9ptwbJ3VHYrzAgFtDvPi5pn4Tz-0w5Phhlo9frjieUaeA@cipher.nrlssc.navy.mil> <4A12F0ED.4070707@nortel.com> <alpine.LFD.2.01.0905191132490.3301@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 19 21:06:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Ue6-000331-6b
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 21:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753624AbZESTGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 15:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753564AbZESTG3
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 15:06:29 -0400
Received: from zcars04e.nortel.com ([47.129.242.56]:49460 "EHLO
	zcars04e.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753460AbZESTG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 15:06:29 -0400
Received: from zcarhxs1.corp.nortel.com (casmtp.ca.nortel.com [47.129.230.89])
	by zcars04e.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id n4JJ4lo13487;
	Tue, 19 May 2009 19:04:47 GMT
Received: from localhost.localdomain ([47.130.81.171] RDNS failed) by zcarhxs1.corp.nortel.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 19 May 2009 15:05:50 -0400
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
In-Reply-To: <alpine.LFD.2.01.0905191132490.3301@localhost.localdomain>
X-OriginalArrivalTime: 19 May 2009 19:05:50.0519 (UTC) FILETIME=[D3296C70:01C9D8B4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119560>

Linus Torvalds wrote:
> 
> On Tue, 19 May 2009, Chris Friesen wrote:
>> However, if I make a change on the arch-specific branch, then tag the
>> main branch and merge it into the arch-specific branch, git tells me
>> the arch-specific branch is already up-to-date and the tag doesn't
>> get propagated.
> 
> You can always just do "git fetch --tags" to fetch any new tags without 
> doing anything else.

This is all in the same local repository, but with target-specific branches
containing arch-specific changes on top of a common codebase.  The
arch-specific stuff often comes from board vendors and such, and they're
never going to be merged back into the common codebase.

I'm looking for some way to conceptually tag the current head of each
branch to indicate "this commit was used to build product version FOO" so
that later on when we find a bug in our code we can tell which product
version(s) contain the bug and need to be patched in the field.

The brute-force way to do this would be to manually loop through each branch
and create a tag of the form "$branch_$version" to ensure unique tags.  But I was
hoping there was a more elegant way.

Chris
