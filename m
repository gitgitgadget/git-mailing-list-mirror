From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and other commit links ideas)
Date: Tue, 25 Apr 2006 11:10:56 +0200
Organization: At home
Message-ID: <e2kp27$8ne$1@sea.gmane.org>
References: <20060425035421.18382.51677.stgit@localhost.localdomain> <e2kgga$d7q$1@sea.gmane.org> <7v7j5e2jv7.fsf@assigned-by-dhcp.cox.net> <e2kjul$ntq$1@sea.gmane.org> <20060425043436.2ff53318.seanlkml@sympatico.ca> <BAYC1-PASMTP116C6B217F25F2ADAF0C67AEBF0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Apr 25 11:11:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYJZa-0003MO-P2
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 11:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWDYJLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 05:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWDYJLD
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 05:11:03 -0400
Received: from main.gmane.org ([80.91.229.2]:55999 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751427AbWDYJLC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Apr 2006 05:11:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FYJZF-0003Ir-JA
	for git@vger.kernel.org; Tue, 25 Apr 2006 11:10:45 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 11:10:45 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 25 Apr 2006 11:10:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19141>

sean wrote:

> On Tue, 25 Apr 2006 04:34:36 -0400
> sean <seanlkml@sympatico.ca> wrote:
> 
>> If you're cherry-picking from a disposable branch, then you don't want to
>> include a link to it in your new commit.  Once you include the link, the
>> source commit should be protected from pruning just like any other piece
>> of history.  Otherwise there's no way for fsck-objects to know if a
>> missing
>> object means corruption or not.  So you need a way at commit time to
>> request the explicit linkage.
> 
> Actually this implies that anyone pulling just this branch would
> potentially
> also end up pulling large portions of other branches too.   So maybe
> making
> them optional is The Right Thing.  In which case, we'd just have to accept
> these as weaker than the parentage links and fsck-objects et. al. would
> have to tolerate such missing commits.

Actually, this can be resolved using automatic history grafts to the remote
repository we pulled from, if the commit is not present on local side (and
removing graft when commit appears on local side).

I was more concerned about size of repository required by keeping some parts
of history which would be purged without those "related" links. But your
concern (pulling) is more important.

-- 
Jakub Narebski
Warsaw, Poland
