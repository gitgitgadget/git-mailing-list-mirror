From: Brandon McCaig <bamccaig@gmail.com>
Subject: Re: Requesting `git stash --cached` or something similar
Date: Mon, 13 Apr 2015 21:42:54 -0400
Message-ID: <CANUGeEZ7tgVDfh2mnha3dwNDF--aRCMGB3TDQ5pQOUYMaX7tJQ@mail.gmail.com>
References: <37E34942-ACEB-48BC-ABFF-C7248DA6607E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Quinn Taylor <quinntaylor@mac.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 03:43:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhpso-0001Zc-C8
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 03:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbbDNBnR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2015 21:43:17 -0400
Received: from mail-vn0-f46.google.com ([209.85.216.46]:33932 "EHLO
	mail-vn0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbbDNBnP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2015 21:43:15 -0400
Received: by vnbf190 with SMTP id f190so26103858vnb.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2015 18:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GfameWAfqRVR4J5Pn5D+K+imr/rOp+V6dtsa/KtJGy0=;
        b=UBHmA/VSXtPygKJkEvYHVWD+CL/Y7fX0JLcjPVQ2KsZVGh0AnuulaD3kwVc0Vja1pa
         ggC6sWEOod1MgOk5MBRBHXmLY5kgEdYQumkfQnmKXb8HmOO2PxpESHZObT7rcKFJqCy0
         j8KNrBqMAZSgc1uFpFK+57Dylaf+2QCrqQYNNZfulmSjIZRW71laU+ANknQ3kP+X0iL5
         AcbynN7LmWqoLs4l1GmXugZ0+x8ptI+7HGHNgSJ8mGtGUDkLezHL4UCUhDp/XDYYJeyg
         yf3qHyKePIJxErlgCxk1yvWQ3VCdIveOj0y2KpQhQoR7bP2yUXVrdMcQXypYwmyKc1AE
         oOmA==
X-Received: by 10.60.52.237 with SMTP id w13mr14364040oeo.58.1428975795005;
 Mon, 13 Apr 2015 18:43:15 -0700 (PDT)
Received: by 10.202.220.4 with HTTP; Mon, 13 Apr 2015 18:42:54 -0700 (PDT)
In-Reply-To: <37E34942-ACEB-48BC-ABFF-C7248DA6607E@mac.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267106>

Quinn:

On Mon, Apr 13, 2015 at 5:24 PM, Quinn Taylor <quinntaylor@mac.com> wro=
te:
> I'm still fairly new to git (coming from svn) and have found `git sta=
sh` to be really useful for storing in-progress work to resume later, a=
s one might otherwise do with diff/patch files. (With the git tools I u=
se, I find `git stash pop` to be more convenient and reliable than crea=
ting and applying diffs, partially because the changes remained tied to=
 my repository and easily accessible.)
>
> Since `git stash` defaults to stashing ALL local modifications, I'd l=
ike to request there be an easy way to stash *only* the changes I've al=
ready staged in the index. (The reason I suggested --cached is due to t=
he similarity with `git diff --cached`, but I don't doubt there would b=
e a better name for this option.)
>
> I tried staging everything *except* what I want to stash and using `g=
it stash save --keep-index <message>`, but it isn't intended to support=
 this case, and doesn't work when I have new untracked files. Instead, =
it stashes *all* local (tracked) changes =E2=80=94 both staged and unst=
aged =E2=80=94 but leaves the staged changes intact in the index.
>
> I understand that git's branching model is powerful and flexible, and=
 that an experienced git user would generally create a private branch a=
nd commit to that, then merge the changes to mainline sometime later. H=
owever, for those like me for whom having many branches is generally mo=
re confusing than helpful, it would be fantastic to have more flexibili=
ty with `git stash`.

I know that git-stash feels like a suitable solution for this, but it
really doesn't seem to have been built for it. Especially when you get
a little bit more experienced with Git and start experimenting with
branching more you will find that stashes quickly become difficult to
maintain. Branches are easier to manage, and they come with the full
power of Git for free. It just doesn't make sense to create a separate
system to manage this when it's precisely what Git does so well
already. That's my two cents.

Note that you don't have to merge these "branches". You can rebase as
you please to formulate the history exactly as you want if you want.
You'll find that if you try you can more easily keep track of
branches. It helps to formulate a workflow for yourself. You can even
use "namespaces" in your branch names to keep them separate. For
example, instead of creating a branch with your "stash" changes called
"foobar", you could create one called "stash/foobar". It would help
you to differentiate between other branches, but you still have the
full power of Git. You can rebase the branch onto other history, or
you can merge if you so desire. It's easier to keep track of where the
work began and where it was first applied. There are just so many
advantages. The stash can be useful to quickly tuck a dirty tree away
while you do something else. Even so, often committing it is
sufficient. You can often just work around that commit and edit it
later if necessary.

I'm not a developer so I can't say that your suggestion isn't useful.
I know that I have had the same desire in the past. For example,
wanting git stash save --interactive or git stash save --patch (i.e.,
see git-add flags). Of course, Git already has stable code to do this
and it doesn't require introducing parallel APIs for the same exact
thing. If you give it a shot you may find that branches solve your
problem sufficiently.

Regards,


--=20
Brandon McCaig <bamccaig@gmail.com> <bamccaig@castopulence.org>
Castopulence Software <https://www.castopulence.org/>
Blog <http://www.bambams.ca/>
perl -E '$_=3Dq{V zrna gur orfg jvgu jung V fnl. }.
q{Vg qbrfa'\''g nyjnlf fbhaq gung jnl.};
tr/A-Ma-mN-Zn-z/N-Zn-zA-Ma-m/;say'
