From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git fetch: where are the downloaded objects stored?
Date: Mon, 3 Mar 2008 17:51:03 +0100
Message-ID: <4d8e3fd30803030851n498953c4u7e7a109b91b9da11@mail.gmail.com>
References: <4d8e3fd30803030440s7239c83cj8bf69401dd76bad@mail.gmail.com>
	 <vpqskz82bm3.fsf@bauges.imag.fr>
	 <4d8e3fd30803030633nf6266d5qab0df4ba4c539e0b@mail.gmail.com>
	 <vpq63w325px.fsf@bauges.imag.fr>
	 <4d8e3fd30803030740i18ca8db1y681b4f10797f8c83@mail.gmail.com>
	 <alpine.LFD.1.00.0803031057140.2899@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 17:52:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWDtE-0002cd-4W
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 17:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663AbYCCQvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 11:51:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754525AbYCCQvK
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 11:51:10 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:8856 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYCCQvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 11:51:09 -0500
Received: by wa-out-1112.google.com with SMTP id v27so132609wah.23
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 08:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=DA5dz9ufCvEjusXPlpQ994830O+7ohrTIXsmsFBKAL8=;
        b=gfrc/oeknz/l7Z1RvHCARzXrPIQIoRFXlrWIanrOlirHphUZiKnH9NOI3rCFggIAEierq3/+y4gfDfHxe/hjppMWRdekoj3JP+56myu3boVKpslWDmCF31PXbpuLqTWFlGx9kbeI3UEWqDDfpA64zGfLrFNjz+gCkHBFGdMzMc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fAijXvm6KJMfgnF4cw/muwRPN+WBBv5iYW7CC5dBZC7CMABGca7WjMN6u9vKSM1gEHXjFqScWouNiBYvepk1iZ0Wu9OdEzKldNru18l1zkdUL/kJgCdC2R6rz8bB5fxUJ4VThi3df/5zr9ekPNXtnVeQkChBANtBEahyiZpf0i4=
Received: by 10.114.156.1 with SMTP id d1mr212912wae.120.1204563063803;
        Mon, 03 Mar 2008 08:51:03 -0800 (PST)
Received: by 10.114.151.7 with HTTP; Mon, 3 Mar 2008 08:51:03 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0803031057140.2899@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75943>

On Mon, Mar 3, 2008 at 5:29 PM, Nicolas Pitre <nico@cam.org> wrote:
> On Mon, 3 Mar 2008, Paolo Ciarrocchi wrote:
>
> > On Mon, Mar 3, 2008 at 4:21 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> > > "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
> > >
> > > > "A merge is always between the current HEAD and one or more remote
> > > > branch heads"
> > >
> > > I think this is just wrong. Would this be correct?
> >
> > Sounds better than the original document,
> > however I'm still having some problems in visualizing what happens
> > when I type "git fetch" followed by "git merge".
> >
> > > diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> > > index 0c9ad7f..e46dea1 100644
> > > --- a/Documentation/git-merge.txt
> > > +++ b/Documentation/git-merge.txt
> > > @@ -68,7 +68,7 @@ HOW MERGE WORKS
> > >  ---------------
> > >
> > >  A merge is always between the current `HEAD` and one or more
> > > -remote branch heads, and the index file must exactly match the
> > > +branch heads (remote or local), and the index file must exactly match the
>
> Yes, this is much better.  A merge may occur with any other branches,
> local or remote, or even with a tag, or any other random commit
> reference for that matter.

It's probably a good idea to mention the tag as well.
Something like:
  A merge is always between the current `HEAD` and one or more
  branch heads (remote or local) or tags, and the index file must
exactly match the

> > When I run the command git fetch the objects are downloaded from the remote
> > branch and locally stored in the objects database.
> > Both the working tree and index are not touched by this operation.
> > Is this correct?
>
> Yes.  The fetch operation will figure out, with the remote machine, what
> is the set of objects that you already have and the set that you don't
> have so the remote machine will create and send you a pack of only the
> objects you're missing.  And the remote machine will also reduce it to
> deltas against objects that you already have when possible so the
> transferred pack is even smaller.  Once that pack has successfully been
> received, then the branch head for which this pack was requested will be
> updated to point at the latest commit for that branch.

OK, that's now completely clear and understood.

> > How can I look to what I just downloaded?
> > Should I simply do a git diff?
>
> If you have reflog enabled (it should be by default) then a good thing
> to remember is the @{1} notation.  For example, if the fetch updated the
> origin/master branch, then origin/master@{1} is what your origin/master
> was before being updated.  To see the difference between the previous
> and the current state of origin/master, you can do:
>
>        git diff origin/master@{1}..origin/master
>
> Or to see the list of new commits:
>
>        git log origin/master@{1}..origin/master
>
>        git log -p origin/master@{1}..origin/master
>
> Etc.

Very nice, I didn't find in the documentation.
I'll read again the documents and if needed, I'll propose some new text.

> This notation is a bit obnoxious and the re were suggestions about
> addind the equivalent origin/master@{1..} but that didn't materialize
> yet.

Mybe it's just me but wouldn't be very nice to have a simple command
to look at what data have been used for updating the currente branch?
i.e.
git fetch
git diff -- fetch (which is an alias of git diff
origin/master@{1}..origin/master)

And how about a repository which have reflogs disabled?

> > Backing to the documentation, your proposal is:
> >  A merge is always between the current `HEAD` and one or more
> >  branch heads (remote or local), and the index file must exactly match the
> >
> > In case of a git fetch + git merge the merge is between the current
> > `HEAD` and the
> > downloaded objects. Is correct to define it `branch heads`?
>
> A merge doesn't happen between a branch and some objects.  Please don't
> see it that way.  Objects are at a lower level of abstraction.  What a
> fetch does is to make sure your version of a branch (say origin/master)
> matches the remote version of the branch "master" on server "origin".
> If you happen to already have all the needed objects already, then no
> objects will be transferred and only the branch reference will be
> updated.

OK.

> The merge operation really works at the commit graph level in order to
> jointwo or more branches together. Objects associated to the involved
> branches are only checked so to make sure the merging of the specified
> branches does not create a conflict (and to fix it otherwise).  If a
> merge conflict is fixed (either manually or automatically) then new
> objects corresponding to the modified files are locally created but the
> previously existing objects remain unchanged.  But object handling
> during a merge is really a low level thing.
>
> > Maybe (read it: for sure) I'm a bit confused by the git terminology
> > but I really feel that
> > other newbies are not easily understanding this process.
>
> I suggest you have a look at the following article:
>
>        http://eagain.net/articles/git-for-computer-scientists/
>
> It is really well written, with the right level of vulgarization to make
> the Git concept really obvious very quickly.

I read it, very intersting.

Thank you Nicolas.

Ciao,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
