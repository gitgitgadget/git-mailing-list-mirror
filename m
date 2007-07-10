From: David Kastrup <dak@gnu.org>
Subject: Re: "svn switch" equivalent when using git-svn -- git-filter-branch?
Date: Tue, 10 Jul 2007 11:38:56 +0200
Message-ID: <86hcocwqbz.fsf@lola.quinscape.zz>
References: <86sl7x7nzq.fsf@lola.quinscape.zz> <20070710054038.GA17675@muzzle> <86ejjgzmxl.fsf@lola.quinscape.zz> <20070710090003.GA18850@muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 10 11:39:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8CBi-0004F9-Cm
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 11:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759017AbXGJJjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 05:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759130AbXGJJjN
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 05:39:13 -0400
Received: from main.gmane.org ([80.91.229.2]:53351 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759017AbXGJJjN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 05:39:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I8CBW-0004W8-MD
	for git@vger.kernel.org; Tue, 10 Jul 2007 11:39:06 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 11:39:06 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 11:39:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:rYUXRqLwIbTPjv3R9JfQs1G0wrg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52057>

Eric Wong <normalperson@yhbt.net> writes:

> David Kastrup <dak@gnu.org> wrote:
>> Eric Wong <normalperson@yhbt.net> writes:
>> 
>> > David Kastrup <dak@gnu.org> wrote:
>> >> Hi,
>> >> 
>> >> an upstream svn repository that I access with git-svn has moved.  I
>> >> seem to be too stupid to use git-filter-branch and/or .git/config
>> >> and/or git-reset to make my git mirror follow the switch.
>> >
>> > Just changing the url key in the [svn-remote] section of the .git/config
>> > file should be enough.
>> >
>> > You'll probably need to fetch at least one revision from the new URL
>> > before being able to dcommit, though.
>> 
>> git-fetch works, but git-rebase -l still complains:
>> 
>> git-svn rebase -l
>> Unable to determine upstream SVN information from working tree history
>> 
>> And consequently I can't actually update.
>
> Does manually specifying the remote name work?
>
> Try bypassing the auto-detection of "git-svn rebase" and just using
> "git rebase <remote name>"

Well, a combination of changing the config, doing a fetch, changing
the config back again, doing the rebase, and changing the config again
seems to have done the trick for now.

I'll have to see how this works in future.  Maybe I will have to
refetch everything anyhow as upstream has just decided to create a
trunk directory (and presumably tags and branches will follow).  I am
not sure I am up to performing the correct steps for adapting to this.

-- 
David Kastrup
