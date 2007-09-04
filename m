From: David Kastrup <dak@gnu.org>
Subject: Re: git-svn and a nested branches folder
Date: Tue, 04 Sep 2007 17:01:04 +0200
Message-ID: <86r6leeaq7.fsf@lola.quinscape.zz>
References: <46DD6EEA.9010304@gmail.com> <86veaqebf1.fsf@lola.quinscape.zz> <46DD718C.7060908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 04 17:01:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISZuD-0004lE-CN
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 17:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367AbXIDPBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 11:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754040AbXIDPBX
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 11:01:23 -0400
Received: from main.gmane.org ([80.91.229.2]:41439 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754193AbXIDPBX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 11:01:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ISZtz-0002p1-3c
	for git@vger.kernel.org; Tue, 04 Sep 2007 17:01:15 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 17:01:15 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 17:01:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:oaD0p2AoQewAyDcr4zRgEtOxBgA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57591>

Russ Brown <pickscrape@gmail.com> writes:

> David Kastrup wrote:
>> Russ Brown <pickscrape@gmail.com> writes:
>> 
>>> I'm having some trouble with using git-svn to fetch a repository, and I
>>> think it's because the repository doesn't store branches as a flat list
>>> directly under the 'branches' directory.
>>>
>>> Basically, we have a structure like this:
>>>
>>> |
>>> +-trunk
>>> +-tags
>>> +-branches
>>>   + category-a
>>>     + branch-a
>>>     + branch-b
>>>   + category-b
>>>     + branch-c
>>>     + branch-d
>>>
>>> etc. category-a and category-b are simple directories created using svn
>>> mkdir. The branches are created using svn cp.
>>>
>>> It helps us to organise the branches better, but the rationale is
>>> besides the point. The problem is that git-svn seems to want to
>>> treat category-a and category-b as branches, which isn't right at
>>> all. As a result, git-svn seems to skip most (if not all) revisions
>>> that occur in these directories and creates a lot of entries in
>>> unhandled.log.
>> 
>> So what did you specify in your .git/config file regarding the svn
>> structure?
>
> I specified the 'branches' directory, but that's because earlier in
> the life of the repo we did just do the flat branch layout, but
> decided to make it more structured once that got unwieldy.

Cough, cough.  _What_ did you specify in your .git/config file
regarding the svn structure?  Please quote the section.

> Is it possible to specify more than one folder for the branches
> option?

It is possible to adapt the config section to the actual layout.  If
not otherwise, by starting with
git svn init
with a clean slate, editing the config file, and only then actually
fetching stuff.

However, git-svn will not magically start guessing that you changed
your structure around.  You have to edit the configuration
appropriately.

-- 
David Kastrup
