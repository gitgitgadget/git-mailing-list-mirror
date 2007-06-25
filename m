From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT RFC] Changing patch@branch syntax
Date: Mon, 25 Jun 2007 23:22:15 +0100
Message-ID: <b0943d9e0706251522s6baf7997r48beae7f57681d77@mail.gmail.com>
References: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0705220527x5d4c3d0fw2d0d66b37aab3f97@mail.gmail.com>
	 <20070522210020.GV19253@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070621230207.GD7730@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0706220859n2c2962ffy21464526a5ebd6cd@mail.gmail.com>
	 <20070622200037.GE7730@nan92-1-81-57-214-146.fbx.proxad.net>
	 <b0943d9e0706221529w63a41e82r557179a45b461f61@mail.gmail.com>
	 <20070624212603.GA6361@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Jun 26 00:22:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2wwu-0007uB-1R
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 00:22:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbXFYWWS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 18:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbXFYWWS
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 18:22:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:4970 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbXFYWWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 18:22:17 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1390079ugf
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 15:22:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tlf2Wpn5v0xupw98wrXZAnOWwGADzVWOiheb10O8BIGu5xDRo7KKoC7jm5BTV/7o1/K0ZWLiG8Al1enJaiwmWtEvX2+YutMqntVKZGqVGf/FgHNmMx9tq+sUALIvqi8DuabdFMdkobizyq8EPhy13M967XXKUFBmOiRoqsKlkYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y2Veg/YZLsO5Xyhy8+MSFmvAYhaRpKaIdyXiQ5n8edi+zlYcrop3H+eLkjb0vO+HTqQ6W/CsCmZ5vn5TmlFZQCd8CiWP/DyzpoFCpqFCTCQZPpXHLJYp498wVZ34cRWmfkfoFomV9IGGhykVEX0miWLVSm21k+Hkzo2U9V28bP4=
Received: by 10.67.96.14 with SMTP id y14mr5432366ugl.1182810135252;
        Mon, 25 Jun 2007 15:22:15 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Mon, 25 Jun 2007 15:22:15 -0700 (PDT)
In-Reply-To: <20070624212603.GA6361@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50933>

On 24/06/07, Yann Dirson <ydirson@altern.org> wrote:
> Well, currently "stg show <stack>" will just take <stack> as a git
> ref, and will show the top commit, which may well be the base commit
> of the stack - not very exciting, I agree.

Indeed. The 'show' command was meant for patches but I added the
support to fall back to git commits.

> > What might be easier with a complete spec is bash completion. I find
> > this mandatory precise description similar to the Hungarian notation.
> > Since most of the time I work with push/pop commands, I don't like
> > always putting a ":" for every patch
>
> Right, push/pop should only get the local name in the current
> patchset, no ":" whatsoever in there.  It is not the same for "show",
> since we often want to look at patches in other stacks.

Yes, but most of the time I look at patches on the current branch.

> I have often wondered if it would be useful to have a given
> patch@stack as a base for another stack, or maybe as one of the
> "heads" of an hydra.  Still not sure it would make any sense, however
> - especially, proper use of hydras would possibly suppress the need
> for the former.

There are situations when I want a separate branch but it relies on
patches in other branches. I currently duplicate the patches and use
the 'sync' command to keep them up to date (though this command would
be more useful with support for git-rerere to avoid fixing the same
conflict several times).

Can a patch series be part of multiple pools? This would be useful to
my workflow.

> > >I'd rather having a single name-resolution mechanism, instead of one
> > >for patches and one for branches.
> >
> > I don't see why we couldn't have a single name resolution but without
> > the mandatory ":". An example (but in reverse order) is internet
> > names. I only type "intranet" rather than "intranet." in a browser. To
> > fully qualify, I type "intranet.arm.com".
>
> There is a difference, in that in name resolution there is a
> well-define algorithm to resolve this, and in that "intranet" alone is
> not a valid fully-qualified name.

No, it's not fully qualified but it gets the .arm.com by default. If
it fails, the browser will complain.

> In current StGIT, in cases where
> "name" matches both a local patch a git ref... well, we can still ask
> for refs/heads/name as fully-qualified name - looks like I had
> forgotten that one ;)

StGIT could default to patches and fall back to git commits if no ":"
are found in the name.

> Let's try to find a proper solution.
>
> We have on one hand a number of commands (in the patch/stack sets)
> that act solely within the patchset, and thus have no need for
> referencing stackables outside the current patchset:
>
>         new, push, pop, goto, float, sink, clean, uncommit, export,
>         import, mail, refresh
>
> Similar commands, but which no technical issue restrain from acting on
> stackables in other patchsets:
>
>         delete, hide, unhide, patches, series, files, log, rename, show
>
> Commands that solely refer to patchsets, not stackables:
>
>         applied, unapplied, top, branch, rebase

Those that can refer to other patchsets have the '--branch' argument,
otherwise they just use the current series.

> Commands that need to refer to patches in other patchsets:
>
>         pick
>
> Commands that don't care:
>
>         assimilate, commit, init, pull, fold
>
>
> I consider we have a couple of special cases:
>
>         clean currently does not care, but see task #5235
>         rebase currently only needs patchets, do we need to extend that to patches ?

'rebase' could only work on the current patchset because of the
possibility of getting conflicts during push (unless you implement the
branch switching as well).

>         mail currently does not accept --branch or patch@stack but probably could

Yes.

>         new creates a patch in the current stack, we may want to unify
>                 this with "branch -c" in some way (maybe "stg
>                 (patch|stack|pool) new" ?)

This might be a possibility once we refactor the command line.

>         show is special in that when its arg is not a ref to a patch,
>                 it falls back to git-show.  We may want to change
>                 that, to be an stgit-only command.

We need the commit id generation for the 'pick' command and 'show'
would use the same code. I don't think we should restrict it.

>         sync uses non-standard way to refer to the other stack - do we
>                 really need to sync several patches in one command ?

I have stacks with more than 10 common patches and it is useful to
update them with only one command (I do this many times only as a
simple check).

>         clone is also special, in that it is currently the only one to
>                 have a use for the repo - it could surely be extended
>                 to accept a stackable (eg. "stg clone http://this/repo#pool2:stk1")

Yes, it would be nice.

> To summarize, appart from "show" which does not really need to know
> about branches, no current command would have any ambiguity.

If we don't want ambiguities in the UI, we could restrict 'show' only
to the StGIT patches (though I personally don't mind the fall-back to
GIT objects).

> > Also, shourt stgit/git.py be aware of the repository?
>
> I'd rather think that we should have git.Repository (and further
> structurate git.py with more objects, like git.Branch), with
> stgit-specific stuff in the stgit.Repository subclass.

Sounds good.

Thanks.

-- 
Catalin
