From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: Question on empty commit
Date: Mon, 16 Jan 2006 14:57:49 -0800 (PST)
Message-ID: <20060116225749.90052.qmail@web31812.mail.mud.yahoo.com>
References: <20060116215856.6618.qmail@web31805.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 23:58:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EydIP-0003WF-SA
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 23:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbWAPW5v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 17:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWAPW5v
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 17:57:51 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:11159 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751247AbWAPW5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 17:57:50 -0500
Received: (qmail 90054 invoked by uid 60001); 16 Jan 2006 22:57:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=GGRRkHscTzbIDJsSjafk8N3M3JsdrEdlCGSXexgLrmdfuEHxgyZxDfcRIwINzmyopK/6VJZTd2EbfkkoyLraQ/SXJyF4M8qqUO5Sx8JFaDwJ+7PD2Z89p1GLWaDTvt5LtyO1mi3xNIhzUBreQU++wGVXN4xsoKuJ5QyDwRs/bs0=  ;
Received: from [64.215.88.90] by web31812.mail.mud.yahoo.com via HTTP; Mon, 16 Jan 2006 14:57:49 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20060116215856.6618.qmail@web31805.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14764>

--- Luben Tuikov <ltuikov@yahoo.com> wrote:
> --- Junio C Hamano <junkio@cox.net> wrote:
> 
> > Luben Tuikov <ltuikov@yahoo.com> writes:
> > 
> > > Now the last merge introduced an empty commit, since
> > > tree A and tree B had been in sync (only local and
> > > remote trunk had been out of sync).  While it was expected
> > > that no commit would be introduced since they were in sync.
> > >
> > > Was the empty commit correct behavior?
> > 
> > I do not quite follow you, but immediately before the "empty
> > commit" (I presume you mean the last "git merge" that merges
> > treeA head in treeB), you say "the treeA and treeB had been in
> > sync".
> 
> Meaning that merging Tree A into Tree B would introduce 0 changes
> to Tree B.
> 
> > What do you exactly mean?  The tree object in the head
> > commits in treeA branch and treeB branch were identical?
> 
> They cannot be, since Tree B contains Project B, which is not
> present in Tree A, but it depends on Project A in Tree A.
> 
> > If that is the case, the commit being empty is the correct
> > behaviour, because there is no difference in the set of files
> > introduced by that commit.  And the commit being made is also
> > the correct behaviour, because those two branches have different
> > development history, and the commit is what binds them together.
> 
> So a new commit object, with 0 files changed was the correct behavior
> after all?
> 
> I'd expect that there would be no commit object whatsoever since
> those trees had been synced before.  I.e. the only thing which changed
> was the trunk and that trunk was synced to Tree A and Tree B separately.
> 
> Thanks,
>     Luben

Ok, so what I'm seeing is that git history records what the _user did_
as opposed to _what happened to the code_.

Is it possible to have an env var to control this "feature".  I.e. if
the result is 0 lines 0 files changed, then do not update the index and/or
the git database.

Thanks Junio,
    Luben
