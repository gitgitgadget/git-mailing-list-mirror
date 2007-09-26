From: Russ Brown <pickscrape@gmail.com>
Subject: Re: Workflow question
Date: Tue, 25 Sep 2007 21:55:38 -0500
Message-ID: <46F9CA2A.7000107@gmail.com>
References: <46F93A99.5080707@gmail.com> <46F95CCC.4080209@op5.se> <46F96493.8000607@gmail.com> <20070925201717.GB19549@segfault.peff.net> <46F97618.9010207@gmail.com> <20070926004734.GA22617@segfault.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 26 04:56:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaN4A-0008P6-Ew
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 04:55:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755023AbXIZCzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 22:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754972AbXIZCzu
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 22:55:50 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:25788 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbXIZCzt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 22:55:49 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1678062wxd
        for <git@vger.kernel.org>; Tue, 25 Sep 2007 19:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=q9dStzoIVay0+irhA9GsJaQHkfblF7MPNQp9JF/WKzo=;
        b=fQ/TjLGGaUZo0e9IrLDEU/s4IvSbPJrCl4d1rp+DO57r9CEcx4wuFeQItvWPGQoeckuC+RP5oj8lYBHw2+r4H0UJ2mafbC5k925k55wwFx/0ZROB6XKiK1xUXsKr3fEiiEopsCo/7lRkwqUo2Kjr0FqANMwtQhzqSknlY3oeGTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=khvKrL98emqrwfm3F6Okkv9TGEsUFvxOg4305OneYuN9vTxSpmk9CX5uLL35ivXWn8ilAtWnx025nOzde39xpy2SC5pqmlgkgy3QXFpJcQ7qgJWAT73TTbcUq/+jzIq70u+in1/0n9FA3pFjxGQ6m+cfcAPDnnxT4CDDI8c/Ll4=
Received: by 10.90.119.15 with SMTP id r15mr170677agc.1190775348024;
        Tue, 25 Sep 2007 19:55:48 -0700 (PDT)
Received: from ?192.168.0.100? ( [71.252.196.170])
        by mx.google.com with ESMTPS id d29sm217970and.2007.09.25.19.55.45
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Sep 2007 19:55:46 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070807)
In-Reply-To: <20070926004734.GA22617@segfault.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59212>

Jeff King wrote:
> On Tue, Sep 25, 2007 at 03:56:56PM -0500, Russ Brown wrote:
> 
>> I keep reading things similar to this and bit by bit I'm starting to get
>> it. :) I suppose this is one case in which it's definitely a
>> disadvantage to have a good understanding of svn before coming to git...
>>
>> <yoda>You must unlearn what you have learned</yoda>
> 
> I prefer to think of it like a war movie, where I keep having
> nightmarish flashbacks to CVS.
> 
> But yes, from the outside git _looks_ a lot like other SCMs you may have
> used, and so it's tempting to keep their mental models. But that can
> easily end up being confusing, as you have found. Personally, I think it
> pays to learn a little about what's going on under the hood, and then
> all of the commands Just Make Sense.
> 
> There are several explanations floating around; this is a pretty concise
> one:
> 
>   http://eagain.net/articles/git-for-computer-scientists/
> 

Yes, this is very helpful indeed: thank you for that. /me bookmarks. I
hadn't actually realised that rebase creates new commits and replaces
your old ones: I'd thought they just got 'moved' (dunno how I thought it
worked though!)

>> If you delete a branch that has commits on it that aren't referenced by
>> any other branches, will those commits be removed by something like git
>> pack or git gc?
> 
> The 'git-prune' command will do this, though it is not run as part of
> git-gc unless you specify --prune.
> 

Another thing makes sense now (helped by the link above also).

>> I suppose what has me the most confused is how a developer works with a
>> remote branch: I've come to understand that a developer should never
>> check out and work on a remote branch, and always create a local one and
>> work on that. If he does that using the above hierarchy, there then
>> becomes main->projectX->featureY->jeff_local_branch_of_featureY. Or is
>> is possible for a developer to work directory on a remote branch?
> 
> As Junio noted, you can't, because they're remote. What you have in your
> local repository is a remote _tracking branch_, which is a local ref
> that tracks your idea of what the remote's branches are. And git will
> feel free to overwrite the contents of that tracking branch whenever you
> do a fetch or pull. So if you make commits on it, they are subject to
> being overwritten (and we note this property of the refs by putting them
> in the refs/remotes hierarchy, rather than refs/heads).
> 
> So in the case of our developer Jeff, his local repository will have a
> "projectX/featureY" branch that he works on. And he will also have a
> remote tracking branch "origin/projectX/featureY" which indicates where
> his local repo thinks the remote repo points. And the remote repo will
> have a "projectX/featureY" branch, of course.
> 

I'm just wondering at this point why git lets you checkout remote
tracking branches if it's something you really shouldn't do. Unless it's
something you want to be able to do in edge cases to fix screwups maybe?

>> Ah,I see... The light is beginning to come on somewhat here, though it's
>> dimmed somewhat by the remote/local branch confusion I mention above,
>> which tends to imply that rebase is only really useful in local branches
>> since it is always the outer-most branch (assuming that my understanding
>> on that is correct, which it may well not be).
> 
> Yes, although the important distinction is not so much "this is a local
> branch" but rather "this is a _published_ branch" which implies that
> other people are looking at (and possibly basing work on) it.
> 
>> I actually quite like the idea of the freezing before re-basing in the
>> sub-branches. However, to answer the question of which merge strategy
>> would work best for us I think I need to actually set this up and have a
>> play with it to see how it all pans out using the various options available.
> 
> Yes, it is easy to get into academic discussions of setups, but in
> practice you need to find a workflow that is smooth for your team.
> 
> On one web-based project I work on, we have a setup like this (which is
> very centralized):
> 
>   - a central repo resides on a development server with two branches,
>     "master" and "production"
>   - each developer clones the repo with a working tree
>   - some developers develop directly on 'master' if they have small
>     changes, or only work on one thing at a time; other developers use
>     topic branches to work on simultaneous changes
>   - any developer can push to master; it is expected that your code is
>     in a reasonable state, since it will now be consumed by other
>     developers. Anything that has made it into master is considered
>     published and should not be rebased. It is up to developers whether
>     they want to rebase their work before publishing or to simply merge.
>   - some developers communicate directly with each other: "hey, check
>     out branch 'foo' in my repo" or "what do you think of this patch?"
>   - The live site has a repo cloned from the central repo, pointing at
>     "production".
>   - there is a test site with a repo cloned from the master.
>     Occasionally the master branch is pulled and tested. If it passes,
>     it is pushed to the "production" branch. In addition, small
>     immediate fixes can go onto "production", tested, and then pushed to
>     the central repo's "production"
> 
> So this is not necessarily using the distributed nature of that much,
> but it allows those developers who aren't very comfortable with SCMs to
> stick to a "pull, hack, push" workflow. And those who want to can do
> more interesting things if it helps them.
> 

Thanks for this, it's very useful to read examples of workflows in
actual use. In fact, I was thinking the other day that it would be good
to have a site that acts as a directory of many different workflows,
including descriptions of how they work, how you actually go about
setting it up and using it day to day (i.e. lists of commands for each
role/task) and the pros/cons that it provides. I reckon that would help
newbies out quite a bit (if only for the examples). I've seen a few
individual examples of workflow but nothing like a comprehensive set of
them.

> -Peff

Thanks!

-- 

Russ
