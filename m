From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Question on empty commit
Date: Mon, 16 Jan 2006 13:58:56 -0800 (PST)
Message-ID: <20060116215856.6618.qmail@web31805.mail.mud.yahoo.com>
References: <7vmzhx7ref.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 22:59:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EycNS-0005qN-Vn
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 22:59:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWAPV7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 16:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWAPV7A
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 16:59:00 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:33105 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751217AbWAPV67 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 16:58:59 -0500
Received: (qmail 6620 invoked by uid 60001); 16 Jan 2006 21:58:56 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=2KPQe/jNQl64NOU1ULKcpwLe0zjEoItxl6c91nv+uYKQGy34KBhKq32JyeiigKE+rwvkG5b4MVbgDZOCqJK7R6ZIKu7If3CJPAfJ6CyPjpMRKLec+q8k7/yihJ3VngvRuSlQsaRs9ANVyjeCL6e4AGjbW9BYfCOhLNf+PA1b7MQ=  ;
Received: from [64.215.88.90] by web31805.mail.mud.yahoo.com via HTTP; Mon, 16 Jan 2006 13:58:56 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzhx7ref.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14761>

--- Junio C Hamano <junkio@cox.net> wrote:

> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > Now the last merge introduced an empty commit, since
> > tree A and tree B had been in sync (only local and
> > remote trunk had been out of sync).  While it was expected
> > that no commit would be introduced since they were in sync.
> >
> > Was the empty commit correct behavior?
> 
> I do not quite follow you, but immediately before the "empty
> commit" (I presume you mean the last "git merge" that merges
> treeA head in treeB), you say "the treeA and treeB had been in
> sync".

Meaning that merging Tree A into Tree B would introduce 0 changes
to Tree B.

> What do you exactly mean?  The tree object in the head
> commits in treeA branch and treeB branch were identical?

They cannot be, since Tree B contains Project B, which is not
present in Tree A, but it depends on Project A in Tree A.

> If that is the case, the commit being empty is the correct
> behaviour, because there is no difference in the set of files
> introduced by that commit.  And the commit being made is also
> the correct behaviour, because those two branches have different
> development history, and the commit is what binds them together.

So a new commit object, with 0 files changed was the correct behavior
after all?

I'd expect that there would be no commit object whatsoever since
those trees had been synced before.  I.e. the only thing which changed
was the trunk and that trunk was synced to Tree A and Tree B separately.

Thanks,
    Luben
