From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Histogram diff, libgit2 enhancement, libgit2 => git merge (GSOC)
Date: Sun, 20 Mar 2011 20:27:08 -0500
Message-ID: <20110321012708.GA18323@elie>
References: <op.vsm1yszq2m56ex@localhost.localdomain>
 <AANLkTi=Fu5v-5E2dSAA74f0juUQNjNjus5XFWqMb9v9k@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Raiskup <xraisk00@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Vicent Marti <vicent@github.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 02:27:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1Tu2-0002yR-Ag
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 02:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab1CUB1V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2011 21:27:21 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54941 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab1CUB1T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2011 21:27:19 -0400
Received: by gxk21 with SMTP id 21so2213507gxk.19
        for <git@vger.kernel.org>; Sun, 20 Mar 2011 18:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=V9DK2o56OImwX/Wx4/rpE3wvQ/upEtQS3Vdv9oD7ZsE=;
        b=X41rQyKEhNG1peD5+hb9djHhieRvoEg76Gt1P8P8Cz+HYQ3BGe+fxG8yDQCmP6wXdm
         Ohwznrws4iDenMDzyQckUq9q4X3P34ykzCo/fHjUE6NW6QQqJicEASjmHyXyte1ddj0f
         l0I6thGV5Sofx1Poe6YXqj94jqdIm8lTpQ9/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=obZvAxMjAmyGmicDzOJCIGeDeXoVflIwa5QcnZ5tU3SYF9e9nVNbhr7ZZX5aAaDGq0
         +YFEpZeObGx1z0wAADQxN8GRPoppFEECuChpLld5PGQGNQqwq5wDqIyT5GR+BO3hSIJ+
         7xcj3ukRtHMy68XVchqVXPWEUmMvTWp5olSAw=
Received: by 10.150.100.12 with SMTP id x12mr3280290ybb.428.1300670839123;
        Sun, 20 Mar 2011 18:27:19 -0700 (PDT)
Received: from elie ([69.209.56.53])
        by mx.google.com with ESMTPS id f5sm968805ybh.28.2011.03.20.18.27.16
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Mar 2011 18:27:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Fu5v-5E2dSAA74f0juUQNjNjus5XFWqMb9v9k@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169549>

Hi,

Vicent Marti wrote:

> Merging libgit2 into upstream Git is a scary as fuck task. Somebody
> put it up on the Wiki ideas page, but that was not me

Cc-ing Ram (who added it), in case he has anything to add.

> -- I'm
> personally doubtful of anybody succeeding on doing that project during
> the SoC,

I agree there --- it is a huge task.  But maybe it could inspire
someone to come up with a smaller task.  One long-term goal might be
to get libgit2 and core git to share revision walking APIs; a baby
step towards that would be a proof-of-concept patch to share object
access APIs.

If someone wants to work on this, I'd be glad to talk over what would
be needed to make a realistic proposal.

> so I have very little interest on mentoring the task.

That's okay, of course.  What's probably important for people
considering this project is: would you be willing to answer questions
and consider patches from a person working on this?  That is, do you
consider the goal even worthwhile?

I am probably not the best person to mentor this but if no one else
wants to then I would be interested.

> Here's what's going on: The Git code base is hairy and not that well
> documented, so you're gonna need to study that quite a bit. I like to
> think that the libgit2 code base is not hairy, and is pretty well
> documented (I'm an optimistic guy), but you're still going to need
> quite a bit of research to understand the whole architecture before
> you can actually merge anything into Git.

Like the Linux kernel, the git codebase does not have many comments
alongside the code, it is true.  But it is actually incredibly well
documented in my experience.  The best documentation is in the
history.  In addition to that, there is some API documentation in
Documentation/technical.

A good place to start is the initial commit e83c516 (Initial revision
of "git", the information manager from hell, 2005-04-07).  The
architecture described therein is very simple and still exists today
with few changes.

To explain something that has come later, the easiest way is to learn
how the author explained it when the change was made.

Let me give an example.  Suppose I am wondering how git decides what
commits to show when I say "git log ^topic1 topic2".  In particular, I
wonder what the performance characteristics of that operation are and
how it is able to print the first result without spending O(depth of
history) to traverse all the ancestors of topic1 going back to the
beginning of time.

First step: what does "git log" do with that "^topic1 topic2"?  Wait,
where is the "log" command defined in the first place?

 $ git grep -e '"log"'
[...]
 git.c:          { "log", cmd_log, RUN_SETUP },
[...]

Ok, it's the cmd_log function.  Looking at the definition of that
function, it seems that it does

	init_revisions(&rev, prefix);
	rev.always_show_header = 1;
	memset(&opt, 0, sizeof(opt));
	opt.def = "HEAD";
	cmd_log_init(argc, argv, prefix, &rev, &opt);
	return cmd_log_walk(&rev);

 $ git grep -e init_revisions -- Documentation
 Documentation/technical/api-revision-walking.txt:`init_revisions`::

The revision walking API is explained in the api-revision-walking.txt
document.  From this we learn that responsibility for the revision
walk is divided between prepare_revision_walk and get_revision,
defined in revision.c.

prepare_revision_walk seems to use functions "handle_commit" and
"commit_list_insert_by_date".  What do they do?

 $ git log -p -Shandle_commit -- revision.c
 commit cd2bdc5309461034e5cc58e1d3e87535ed9e093b
 Author: Linus Torvalds <torvalds@osdl.org>
 Date:   Fri Apr 14 16:52:13 2006 -0700

     Common option parsing for "git log --diff" and friends

     This basically does a few things that are sadly somewhat interdependent,
[...]
     Now, that was the easy and straightforward part.

     The slightly more involved part is that some of the programs that want to
     use the new-and-improved rev_info parsing don't actually want _commits_,
     they may want tree'ish arguments instead. That meant that I had to change
     setup_revision() to parse the arguments not into the "revs->commits" list,
     but into the "revs->pending_objects" list.
    
     Then, when we do "prepare_revision_walk()", we walk that list, and create
     the sorted commit list from there.

Okay: so in revision walking:

 - first (in setup_revisions), git pushes the ^topic1 and topic2
   commits onto a list called "pending_objects";
 - next, in prepare_revision_walk, it walks through the pending
   objects list and inserts them in a commit list, sorted by date;

and next?

 $ git log -Sget_revision -- revision.c
[...]
 commit a4a88b2bab3b6fb0b30f63418701f42388e0fe0a
 Author: Linus Torvalds <torvalds@osdl.org>
 Date:   Tue Feb 28 11:24:00 2006 -0800

     git-rev-list libification: rev-list walking

     This actually moves the "meat" of the revision walking from rev-list.c
     to the new library code in revision.h. It introduces the new functions

         void prepare_revision_walk(struct rev_info *revs);
         struct commit *get_revision(struct rev_info *revs);

     to prepare and then walk the revisions that we have.

     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
     Signed-off-by: Junio C Hamano <junkio@cox.net>

Well, that's actually not so helpful.  I mean, it tells us that
get_revision is what takes care of the revision walk, but it doesn't
tell us what the revision walk consists of.

So here we need another trick to get at the meat of the matter ---
we need to know where this "revision walking from rev-list.c" came
from.  Ah:

 $ git log -- rev-list.c
[...]
 commit 64745109c41a5c4a66b9e3df6bca2fd4abf60d48
 Author: Linus Torvalds <torvalds@ppc970.osdl.org>
 Date:   Sat Apr 23 19:04:40 2005 -0700

     Add "rev-list" program that uses the new time-based commit listing.

     This is probably what you'd want to see for "git log".

And the answer is there in the patch for a commit that comes after that
(8906300, git-rev-list: use proper lazy reachability analysis,
2005-05-30).

Heh, probably I didn't choose the best example. :)  A short article
about this in Documentation/technical certainly wouldn't be a bad
thing.

In addition to "git log -S" as used above, I tend to find "git blame -L"
helpful FWIW.  And people on the list can be helpful, too.

> (libgit2 is reentrant and mostly threadsafe, so there's quite the
> architecture mismatch there),

Could you expand on that a little?  I understand that a lot of git
code wouldn't be usable for libgit2 as-is and that there is going to
be some overhead from, say, using malloc to initialize buffers instead
of relying on static ones.  But does that deserve to be called an
architecture mismatch?  Would that make it hard to reuse libgit2 code
within git?

I'd be very interested in learning about more substantial differences
in approach.  Probably the two codebases could learn a lot from each
other's design.

> Overall, you'd need balls of steel

Here I agree.

> HOWEVER. If you want to do something libgit2-related for the SoC
> (which would be awesome), there's still two options:
>
> a) Help us make the library more awesome by implementing new features!
> This task is the opposite the previous one; it's like full of unicorns
> and rainbows. You can choose one (or more) features we are missing,
> and see how to implement them in libgit2 while making them reentrant,
> threadsafe AND faster. It's not easy, but it's fucking cool. And you
> get to do a lot of micro-optimization if you're into that.

Note that if this is your kind of thing, you might consider sending
"libification patches" to modify the code in git while at it.  That
means free code review and free bugfixes from then on if your changes
are accepted.

> b) Write a minimal Git client using libgit2. Peff keeps bringing this
> up and I think it's a bangin' good idea. Write something small and
> 100% self contained in a C executable that runs everywhere with 0
> dependencies -- don't aim for full feature completion, just the basic
> stuff to interoperate with a Git repository.

I agree that this would be very neat, too.

> So, yeah. That's pretty much my libgit2-related advice for the SoC.

Thanks again, Vicent, for these very useful explanations.

> Best of luck with your application process with whatever project you decide,
> Vicent

Seconded. :)

Hope that helps,
Jonathan
