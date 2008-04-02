From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Tue, 1 Apr 2008 22:03:50 -0400
Message-ID: <32541b130804011903u3b5d0794w984e26c4570c4688@mail.gmail.com>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
	 <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no>
	 <47EFD253.6020105@vilain.net>
	 <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no>
	 <32541b130803301603u65d1b6b6ladac0f6200433e5f@mail.gmail.com>
	 <834174D1-82F4-4438-9854-762F416BB5EF@orakel.ntnu.no>
	 <32541b130803311436t7b5041a4pabface15aad8ce63@mail.gmail.com>
	 <47F2BFCD.5070202@vilain.net>
	 <32541b130804011656l2e907895i98e5260b49743bbe@mail.gmail.com>
	 <7vd4p9ccw8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>,
	"Eyvind Bernhardsen" <eyvind-git@orakel.ntnu.no>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 04:04:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgsL8-0001f4-UW
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 04:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbYDBCDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 22:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754740AbYDBCDz
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 22:03:55 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:19667 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbYDBCDy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 22:03:54 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2655135fgb.17
        for <git@vger.kernel.org>; Tue, 01 Apr 2008 19:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=K95JzUJCyp1/Bm6ZxpKWJ4y6fw2+cacFP9lOOrZwuFo=;
        b=mWJfviGwMT/rDRuJ8onoKBjU85/iuhrlFPR5mGAXlRGNhIKmLjc9qpVxWt+KP7Df29zsYmzt/PYJJjyrvJ9ae8XNAvfUM9F3rjZ4Ci+bo4tgzoS6mK8KMLYXeJTz/lt2O/c+zPlCTRAbCsNoiPuRaoJzcQQxWevjwUggkXNXGxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SbuhwQljg8028dHoaNjTj1I8aCuG6xQe/I5Wo1oY1xJc4Qul4sEdNeAyfxuPzq+YSVnmK5FqKZXIWsG3pnC1mKXMffaLTu6J/DBC7vYoNtfCuBkFKU1KwFUXAXFM2W8FEziX9w/pNagGHKdpZarAzAOIvfv3ECRTb7zq185zIdo=
Received: by 10.82.188.15 with SMTP id l15mr20838505buf.34.1207101830969;
        Tue, 01 Apr 2008 19:03:50 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Tue, 1 Apr 2008 19:03:50 -0700 (PDT)
In-Reply-To: <7vd4p9ccw8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78675>

On 4/1/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Avery Pennarun" <apenwarr@gmail.com> writes:
>  > Instead of storing only the commitid of each submodule in the parent
>  > tree, store the current branch name as well.
> > ...
> > This way, cloning a project with submodules will work much like
>  > cloning the parent project; pushing and pulling the parent and the
>  > submodules will do as you expect.
>
> That goes quite against the fundamental design of git submodules in that
>  the submodules are by themselves independent entities.

Not sure what you mean here; the supermodule already stores the
commitid of the submodule.  All I'm proposing is that it also store
the default branchname (ie. the branchname that the submodule was
using when its gitlink was checked into the supermodule) along with
that commitid.  The submodule never knows anything about the
supermodule.

>  An often-cited
>  example is an appliance project, where superproject bundles a clone of
>  Linux kernel and a clone of busybox repositories as its submodules.

What a coincidence!  This is almost exactly like my situation :)

>  If your superproject (i.e. the appliance product) uses two branches to
>  manage two product lines, named "v1" and "v2", these names are local to
>  the superproject.  It should not force the projects you borrow your
>  submodules from to have branches with corresponding name.

I meant that we should store the submodule's branch name when
committing the superproject, and put it back when checking out the
submodule fresh from the superproject.

>   - When not working in a particular submodule, but using it as a component
>    to build the superproject, it would be better to leave its HEAD
>    detached to the version the superproject points at.  IOW, usually you
>    won't have to be on any branch in submodules unless you are working in
>    them.

I agree that the submodule should have its HEAD pointing at exactly
the superproject-specified commit.  However, I believe this commit
should have a local branch name (in the subproject) attached to it, or
else (as I and my co-workers have frequently experienced) people will
accidentally check in to a nameless branch, causing 'git push' to
silently not upload anything, and thus lose track of their commits.  I
have lost work this way.

The idea of naming the local-subproject-branch with the same name as
it had on checking is that then "git pull" in the subproject will work
exactly as expected: it'll get you the latest version of the branch
the superproject developer was on.  But if you *don't* explicitly "git
pull" in the subproject, I'd expect (of course) the checkout to stick
to the commit specified by the superproject - and also to leave its
local branch name pointing at exactly that commit.

>   - Sometimes you need to work in a submodule; e.g. you would want to add
>    'frotz' tool to your copy of busybox.  You chdir to the submodule
>    directory, and develop as if there is no superproject.

This is where my workflow is a bit different.  One of my subprojects
is a library that gets used by several application superprojects.  I
often add features to my library in the process of editing a
particular superproject.  I also expect my co-developers to want to do
the same.  Thus, the difference from your example is that I want to
streamline the process of working in a subproject as well as a
superproject, and minimize the chances of losing data in this case.

With the current system the way it is, it's too easy to make mistakes,
and it requires too many steps to fetch/merge/rebranch each submodule.

>    - Then work on adding that 'frotz' tool.  Make commits, test it in
>      isolation and test with superproject.  Push it out as whichever
>      remote branch the project policy asks you to.

As an orthogonal secondary wish, I'd like to have the subproject and
superproject hosted in the same remote repository.  This appears to be
possible (albeit inefficiently right now) by using "." as the remote
repo name in .gitmodules.  It would be more efficient if
git-submodule-update would use the superproject's checkout as a
--alternate when cloning the submodule... I think that would be easy
and harmless, right?

The super-summary of all that is I think I'd like to make three git
changes here:

1) When checking out a submodule from scratch, use the local
supermodule as a --alternate.  That way if both super and submodule
are hosted in the same remote repo, I don't have to clone them twice.
(And cloning my local repo to another copy doesn't stop git-submodule
from working.)

2) When checking out a submodule, give the submodule's current commit
a useful branch name (ideally, the name it had when the gitlink was
checked into the supermodule).  When updating a submodule with
git-submodule-update, quietly fixup the submodule's local branch ref
if it hasn't been changed; else produce a conflict of some sort.

3) Bonus: make "git push" operate recursively on submodules, and "git
pull" automatically run git-submodule-update.

Does that make sense?

Thanks,

Avery
