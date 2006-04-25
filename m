From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 12:08:54 +0200
Organization: At home
Message-ID: <e2kset$lk2$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net> <e2kjul$ntq$1@sea.gmane.org> <20060425043436.2ff53318.seanlkml@sympatico.ca> <BAYC1-PASMTP116C6B217F25F2ADAF0C67AEBF0@CEZ.ICE> <e2kp27$8ne$1@sea.gmane.org> <7vmzeax9gj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Apr 25 12:09:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYKTf-0006Ai-Ve
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 12:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWDYKJA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 06:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWDYKI7
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 06:08:59 -0400
Received: from main.gmane.org ([80.91.229.2]:64408 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932172AbWDYKI7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 06:08:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYKTR-00067v-0B
	for git@vger.kernel.org; Tue, 25 Apr 2006 12:08:49 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 12:08:48 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 12:08:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19143>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Actually, this can be resolved using automatic history grafts to the
>> remote repository we pulled from, if the commit is not present on local
>> side (and removing graft when commit appears on local side).
> 
> You do not even need history grafts.  The "cherry-pick source"
> was a bad example.  Maybe using "related" as a way to implement
> "bind" would have been a better example -- we want inter-commit
> relationship that requires connectivity but without ancestry for
> them.
> 
> You can just have two kinds of 'related'.  One that means
> connectivity, the other that does not.

Good idea.

Another problem for core git, but I think orthogonal to the "related"/"note"
distinction is if the relation (or note) should be used as helper in
merges, perhaps by some agreed upon convention on the
comment/description/value part (e.g. "mergehelper" or "mergeinfo").

BTW. in your first example, what "key" relation should mean?
"cherrypick" (which should be "note" as we don't need connectivity) is
quite obvious (or equivalent "origin" if rebase wouldn't destroy the branch
picked from).

-- 
Jakub Narebski
Warsaw, Poland
