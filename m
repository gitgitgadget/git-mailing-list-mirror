From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Wed, 30 Oct 2013 18:53:52 +0100
Message-ID: <CALKQrgc297dqaxBNDT-N831a94gF7TyDrjt2y4DpOdT_tkyayA@mail.gmail.com>
References: <20131024122255.GI9378@mwanda>
	<20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com>
	<20131027013402.GA7146@leaf>
	<526CA7D4.1070904@alum.mit.edu>
	<20131027071407.GA11683@leaf>
	<874n83m8xv.fsf@linux-k42r.v.cablecom.net>
	<20131027092019.GB13149@leaf>
	<CALKQrgc7a+p5eebJErcGdA3QDyvdHEaef36RhZocQp9LjDUeeg@mail.gmail.com>
	<CAP8UFD3MZJKWUbdZqrSwoatpnx73MTpiwSkxPHYDagGjMSqJNw@mail.gmail.com>
	<CALKQrgcgfimZRJL7WyS-brqEZnHJkJjK_0cqe6-7HWkuCW6Dzw@mail.gmail.com>
	<87txg1hwsa.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git mailing list <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:54:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZy3-0002xv-1h
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628Ab3J3RyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 13:54:02 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:40395 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab3J3RyA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 13:54:00 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1VbZxt-0005EE-OE
	for git@vger.kernel.org; Wed, 30 Oct 2013 18:53:57 +0100
Received: from mail-pd0-f173.google.com ([209.85.192.173])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1VbZxs-000PwX-T5
	for git@vger.kernel.org; Wed, 30 Oct 2013 18:53:57 +0100
Received: by mail-pd0-f173.google.com with SMTP id r10so1293098pdi.18
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 10:53:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oeEA04qK28M9ghTEMLrAiLH3m9Hf1oWaKo3GRCUtu1o=;
        b=BH/tu22tVfvLZ9xkphzYiKLHt+JEueIRJc3AaBNq8e0vHKCYQGNqiqlGxE8YRn5rQz
         NGwEXcJI60myfwn0Y8jpS1NP3lurI/Srl4OWtbwhrNbTk8Qxc00+p1Dqy6FGAr09pqX4
         XHDlkj80wTvDxkKurkKq54JH+lIVxGKY6EtremU5/BmlJSNiwsTYrbrCBnwEis9+rtjD
         4cvdb7a/L4+tKcoWqrHI7rI3uoRlr+TPEBKjfILQbL2fu3KPTOmmWhqBzEw3CKkeMQq0
         KjaU/LzzJCh2G26UDfTDlTyIQdwgJids8Ua2f0FRySIbiHzcKdYYSyTE0vGcQRPeInCz
         jt/g==
X-Received: by 10.68.225.197 with SMTP id rm5mr6507259pbc.166.1383155632881;
 Wed, 30 Oct 2013 10:53:52 -0700 (PDT)
Received: by 10.70.24.226 with HTTP; Wed, 30 Oct 2013 10:53:52 -0700 (PDT)
In-Reply-To: <87txg1hwsa.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237049>

On Mon, Oct 28, 2013 at 11:10 PM, Thomas Rast <tr@thomasrast.ch> wrote:
> Johan Herland <johan@herland.net> writes:
>> But I still don't see exactly what this option should do (inside "git
>> commit") that would end up being useful across most/all projects, and
>> not just something that could more easily be implemented in the
>> *commit-msg hooks for relevant projects.
>
> [Ok, admittedly I don't really know what to quote from your message,
> since I'm mostly responding to the overall concept.]
>
> I like the idea of putting all that in hooks, but I have two
> observations:
>
> * Signed-off-by: is already such a case (and was probably also added for
>   the kernel?) that _could_ have been dealt with using {prepare-,}commit-msg,
>   but has its own support in various git tools.

Yes, and I don't like using the precedent of "Signed-off-by" as an
argument to push support for more (IMHO project-specific) footers into
core Git. Hence, I'd rather see the "Signed-off-by" reimplemented as a
hook (obviously, the -s option for "git commit" would have to remain
for backward-compatibility).

> * In your list
>
>>   Fixes:
>>   Reported-by:
>>   Suggested-by:
>>   Improved-by:
>>   Acked-by:
>>   Reviewed-by:
>>   Tested-by:
>>   Signed-off-by:
>
>   and I might add
>
>     Cherry-picked-from:
>     Reverts:
>
>   if one were to phrase that as a footer/pseudoheader, observe that
>   there are only two kinds of these: footers that contain identities,
>   and footers that contain references to commits.

I'm not so sure we can make those assumptions. One might conceivably
imagine a "Fixes:" footer that refers to a bug ID, and not a commit.
Also, projects might want to apply different rules on what may appear
in which footer. E.g. one could e.g. want to enforce that the ident
listed in "Reviewed-by:" or "Signed-off-by:" must always appear in a
project-specific REVIEWERS.txt or AUTHORS.txt file. Since we don't
really know what projects might want, we shouldn't make too many
assumptions on how these footers will be used... That said, I am not
(or at least no longer) opposed to generic support in core Git for
processing these footers, as long as that support is flexible/generic
in nature, and equally available to be reused from within hooks as
from within core Git.

> So why not support these use-cases?  We could have something like
> footer.foo.* configuration, e.g.
>
> [footer "fixes"]
>         type = commit
>         suggest = true
> [footer "acked-by"]
>         type = identity
>
> where 'suggest' (please suggest a better name) means that git-commit
> will put a blank one in the commit message template for you to fill in.
> 'commit' and 'identity' can have some elementary expansion and
> validation tied to them.  Some easy extensiblity (hooks?) might not
> hurt, but then as you point out, the existing hooks already cover that.
>
> Perhaps we could also have, for Gerrit (cf. [1]):
>
> [footer "change-id"]
>         type = uuid
>
> though admittedly I haven't investigated if it's okay to just put a
> random string there, or it needs to have a specific value.
>
> [1]  http://thread.gmane.org/gmane.comp.version-control.git/236429

How the config ends up looking is not actually that interesting to me
(not at this stage, at least). My objection is to adding support for
specific footers with specific interpretations tailored specifically
for one (or a few) projects. Such things only open the door to more
bloat. Instead, we already have the hooks for implementing such
project-specific rules and conventions. This is the core of my
argument. Since then, the discussion has moved towards generic and
flexible support for commonly-used footers, and I don't really have a
problem with that, as long as it is easily reusable (and extensible)
by a project's own hooks.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
