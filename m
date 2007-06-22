From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT RFC] Changing patch@branch syntax
Date: Fri, 22 Jun 2007 23:29:14 +0100
Message-ID: <b0943d9e0706221529w63a41e82r557179a45b461f61@mail.gmail.com>
References: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0705220527x5d4c3d0fw2d0d66b37aab3f97@mail.gmail.com>
	 <20070522210020.GV19253@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070621230207.GD7730@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0706220859n2c2962ffy21464526a5ebd6cd@mail.gmail.com>
	 <20070622200037.GE7730@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Jun 23 00:29:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1rd5-0004Xg-5w
	for gcvg-git@gmane.org; Sat, 23 Jun 2007 00:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbXFVW3R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 18:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754378AbXFVW3R
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 18:29:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:5111 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442AbXFVW3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 18:29:16 -0400
Received: by ug-out-1314.google.com with SMTP id j3so901898ugf
        for <git@vger.kernel.org>; Fri, 22 Jun 2007 15:29:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RFz/sdZB7NtkyYkHfUu9NNAIdNjPzKDSjBI9Pao84D7r36UqDCWg5hnxjrPC8MC+h48mw9SoDadHTRA70qbwL6DAwQv6sMkd580NsOfmyovm9tcAojtn9RuG219EV09Pvks56QqfmH3/AwkovVWgNJb8//FD8bqAQ08f3cA2IhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sStSA0vCS+2UOLp5B7XSRcFdHfn2vYUdwDG7OhZ5b625IKcx1wuBRJRHOdTn4y+1lLHkSZGxsESAO6NWxtQZF2b9JscY1i4xTExeGWeX5RbHnpkeG3Zql73ba6k9IMDhfINUdnRnHXStwPS0mCZamXYCc8KBG8XzMlqHL9ZgUfY=
Received: by 10.67.90.1 with SMTP id s1mr3107166ugl.1182551354165;
        Fri, 22 Jun 2007 15:29:14 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Fri, 22 Jun 2007 15:29:14 -0700 (PDT)
In-Reply-To: <20070622200037.GE7730@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50712>

On 22/06/07, Yann Dirson <ydirson@altern.org> wrote:
> On Fri, Jun 22, 2007 at 04:59:05PM +0100, Catalin Marinas wrote:
> > I also don't think we need to make this distinction in the names as
> > different commands or options take different type of arguments:
> >
> > stg show <patch>
> > stg series --branch <stack>
>
> Currently, "stg show HEAD" or any other git ref does work, except when
> there are name clashes.

But the argument to 'show' here is either a patch or a git ref (not a
stack or a pool). It first tries to find a patch and fall back to a
git ref. You don't specify a stack to 'show'. 'git show' is also able
to take a commit or a tag object without clearly specifying the
difference.

What might be easier with a complete spec is bash completion. I find
this mandatory precise description similar to the Hungarian notation.
Since most of the time I work with push/pop commands, I don't like
always putting a ":" for every patch (BTW, what about patch ranges, I
don't think they can go across multiple stacks).

> And since we're going to have all of patches, stacks, and pools in the
> same "stackable" family, we're going to use them interchangeably in
> more and more places.  But there are also places where we can use at
> will stack names and generic git heads (eg. "stg branch X").

Currently, stack names and git branches are the same. Would this
change with hydra? I use StGIT to maintain my branches on
http://www.linux-arm.org/git?p=linux-2.6.git;a=heads and I find the
stack name == git branch simplification pretty useful.

What commands/options would we have where we need to distinguish
between stack and patch names?

> I'd rather having a single name-resolution mechanism, instead of one
> for patches and one for branches.

I don't see why we couldn't have a single name resolution but without
the mandatory ":". An example (but in reverse order) is internet
names. I only type "intranet" rather than "intranet." in a browser. To
fully qualify, I type "intranet.arm.com".

> > I would introduce a <repo> in front of all the above (for which we
> > don't have any support)
>
> Yes - URLs could do the work, with a '#' to use the stackable as URL
> fragment.

OK, you mentioned this in the past.

> Now for technical details.  I have a prototype hydra mechanism that
> demonstrates that we can create such a beast without having everything
> breaking all around.  However, it does not use the model described in
> this thread, but rather links to stacks which exist independantly - I
> want to keep that as a possibility, by using some symlink-like
> mechanism, but the current prototype will not live, although I may
> experiment a bit more with it.  BTW, we should probably name the final
> beast "pool" and not "hydra", so users have a better idea of how to
> use it :)

Yes, "pool" sounds better (though I didn't get the full idea of how
things work).

> However, the various refactorings and fixes I have done should be
> quite ready for inclusion (modulo dispatching recent fixes down to the
> relevant patch).  Here I need to know your plans for 0.13: if the
> refactoring would go in, I just have to polish things as they are; if
> you prefer to keep this for 0.14, I'll sink the bugfixes down my stack
> so they can be in 0.13 at least.

I plan to do a 0.13 release pretty soon. I want to clear some of the
logged bugs and release it as it seems to be pretty stable. It's
better to keep this refactoring for 0.14.

If it is easier for you, you could create a branch (for-upstream etc.)
and just send me an email to merge it.

> Did you have time to look at the various refactorings at
> http://repo.or.cz/w/stgit/ydirson.git ?

I had a quick look (not much though, moving house and a lot of FYI).
They look OK, but just a few comments:

- concreteCommand, I would write classes with capital first letter
(unwritten convention in StGIT)

- why the Repository class definition in stgit/__init__.py? Can it not
be in a different file? Also, shourt stgit/git.py be aware of the
repository?

Regards.

-- 
Catalin
