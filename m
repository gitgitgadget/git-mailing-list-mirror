From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Command-line interface thoughts
Date: Sat, 11 Jun 2011 01:05:07 +0200
Message-ID: <201106110105.08715.jnareb@gmail.com>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <20110609200403.GA3955@sigill.intra.peff.net> <7v4o3xwe5z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 01:05:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVAlY-0004O7-CP
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 01:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248Ab1FJXFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 19:05:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48220 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758229Ab1FJXFS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 19:05:18 -0400
Received: by fxm17 with SMTP id 17so1866103fxm.19
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 16:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=jVWtejpCwJlyZCicTuNiZkTUh+tLyt5xwu9MNw49uds=;
        b=Eiv23UDCsw5366EKoUakVq5mdI/Kd/oFUrtHKutfhUF+3eEztQm4vToQj+Spz4lGHo
         NG8XX/rEOjS+0WIbqbuVR8MCLbIGFM5zibBJ7k5Vusg0xYoHopRPZzBI7u47pCEDKT8t
         xQX0JVxHTSJkkjclY8V7rkQQe74bzekRIIBS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=EeWFpTboKKt4owNkMBhcGDD5IDTTH7OV0oqCqottYGXHk1pUH4I+BjGRKo76EWDqwm
         1/cmevP/0vBGeO5Jc0eaGuuGAvV/dQWL+nzByktqsbA8FANWZRp1+C8tbaehhGvZh/rP
         vhReUiJ7U43LvEbAurJ1vwXNj2VCuXiRBmHOI=
Received: by 10.223.102.131 with SMTP id g3mr2559761fao.68.1307747116697;
        Fri, 10 Jun 2011 16:05:16 -0700 (PDT)
Received: from [192.168.1.15] (abvz126.neoplus.adsl.tpnet.pl [83.8.223.126])
        by mx.google.com with ESMTPS id h1sm1219478fag.11.2011.06.10.16.05.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Jun 2011 16:05:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4o3xwe5z.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175634>

On Fri, 10 Jun 2011, Junio C Hamano wrote:

I'll be there advocatus diaboli for some things.

> Jeff King <peff@peff.net> writes:
> 
> > I think there are actually two questions here:
> >
> >   1. Will it be easier for people to understand "git diff" if we use
> >      tokens to describe non-treeish sources and destinations?
> >
> >   2. Are there better tokens to use to break down parts of the index?
> >
> > I don't have a big problem with (1). Allowing things like:
> >
> >   git diff INDEX WTREE
> >
> > allows one to explain what is going on with the diff syntax in a very
> > clear and verbose manner. I wouldn't want to type that every day, but
> > that's OK; "git diff" will always mean the same thing as it always has,
> > but can now be explained to people who have trouble seeing it in terms
> > of "git diff INDEX WTREE".
> >
> > There's still a bit of magic in that INDEX is _not_ a tree, but I think
> > that's a good thing. When there are no merge conflicts, it will behave
> > identically to the proposed NEXT tree. And when there are conflicts, it
> > will show you something even more useful.
> 
> Thanks. This is exactly why I love to have people like you on the list,
> who can say what I wanted to say in a manner that is a lot easier to
> understand.
> 
> In short, the proposed "NEXT" does not help in a situation with conflicts,
> and makes the user experience worse.

Which proposed NEXT?  I'm asking because there were many proposals from
many people, some contradictory.

One proposal was, if I understand it correctly, to have NEXT actually be
STAGE, i.e. be multi-tree like current index is in the case of merge
conflicts.  This means that NEXT = \Sum stage_0 + (stage_ours + stage_theirs
+ stage_base). 

> In order to get the current power of 
> "git diff" with various options that are specifically designed to help
> users to make progress (either working on their own changes, rebasing them
> on top of others, or merging other's work in), people _COULD_ introduce
> BASE/OURS/THEIRS in addition to "NEXT", throw the existing HEAD and
> MERGE_HEAD to the mix, derive the same information by spending mental
> effort to choose between which pairs of two entities among these six
> possibilities and take pairwise diffs among those pairs,

And find which direction makes more sense "diff A B" or "diff B A".
"git diff" / "git diff --staged" / "git diff HEAD" use direction that
makes most sense.

> and combine the 
> results of these diffs (the message I responded to with "is that a useful
> question" was an example of that---"Could we pile more kludge on top of
> NEXT to have expressiveness equivalent to what the current index-based
> system offers?"). Yes, that may be possible, but is there a point in
> making users go through that kind of mental contortion by introducing
> these new tokens? I find it highly doubtful that it would help new people
> understand the situation during conflicted merges.
> 
> >   git show INDEX:OURS:Makefile
> >
> > which is identical to what I wrote above, but is perhaps easier to
> > explain.
> 
> Why does anybody even want to say :2:Makefile to begin with?
> 
> Presumably, you are dealing with a merge conflict at that path and trying
> to see how pre-merge version of Makefile looked like, and then the next
> thing you may want to do is how pre-merge version of their Makefile looked
> like.
> 
> Wouldn't it be far more natural to ask for these instead?
> 
>     git show HEAD:Makefile
>     git show MERGE_HEAD:Makefile
> 
> I do not think whoever brought that "you can look at individual stages
> with :$n:$path" to this discussion was thinking straight. Yes, it is
> something you _could_ do, I've never found that particularly _useful_
> unless I was debugging git itself.

Actually there are cases when you don't have MERGE_HEAD, namely:

 * "git merge --squash"
 * "git rebase" and "git rebase --interactive", and "git cherry-pick"
 * "git am --3way"

Note that OURS/THEIRS/BASE/WTREE has more power: currently there is no way
as far as I know to compare stages 2 and 3 directly ("git diff :2: :3:"
didn't work, though this might be fiexed in newer git), or stage and base.

Though I am not sure if anybody would want this.
-- 
Jakub Narebski
Poland
