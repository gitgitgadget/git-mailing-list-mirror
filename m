From: Simon Eugster <simon.eu@gmail.com>
Subject: Re: [PATCH 2/2] Documentation on git-checkout --ours/--theirs improved
Date: Tue, 16 Jun 2015 09:03:06 +0200
Message-ID: <CAO8d5Bbi8LHHP0nnYwv=_Qr6KZCJmFPTq5ut2KzeSKJ-i0RZNg@mail.gmail.com>
References: <xmqqwpzafe88.fsf@gitster.dls.corp.google.com>
	<1434372447-51230-1-git-send-email-simon.eu@gmail.com>
	<1434372447-51230-3-git-send-email-simon.eu@gmail.com>
	<xmqq381s91gz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 09:03:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4kuG-00070H-38
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 09:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753900AbbFPHDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2015 03:03:18 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36768 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbbFPHDH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Jun 2015 03:03:07 -0400
Received: by wigg3 with SMTP id g3so99300752wig.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 00:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HAuQOLLcMkr+WcRWXWV0aAQSZNwFKgSoTixr6gOXiBc=;
        b=I4NE2WYYDXohVQPQ8VsRFYBFCqz99RzP0fGr1e6g/IeUD0utYGfymWrTUoEa7aNhkY
         b3J8lIXcZ7KZknJ5b36neodiUuSpagt98gsoJDr65gzOi+0CKg+2+Hs4pmzqKCpnWqHf
         SY1ZsWBL/pWxX75phpWEdf+voRXvb7ZVcUiGgxqn+HW3rmTGNiUJJRc7H0rccETk7W8f
         ECCZykdIgBYbQDA6uJDCI+rWayK1Rhfqywfsj+DPWhz0R8LSB9T1Yeu+PhRPeAUbhyJ8
         CaWghfw+yunjxllYkM1AiDtYxcAnaIRb4exj+9E497/YahTAbcnbuM0OiQIwi9oBV19e
         7JpA==
X-Received: by 10.180.107.138 with SMTP id hc10mr3629466wib.2.1434438186310;
 Tue, 16 Jun 2015 00:03:06 -0700 (PDT)
Received: by 10.27.134.86 with HTTP; Tue, 16 Jun 2015 00:03:06 -0700 (PDT)
In-Reply-To: <xmqq381s91gz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271739>

2015-06-15 22:10 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
>
> "Simon A. Eugster" <simon.eu@gmail.com> writes:
>
> > ---
>
> - Lack of explanation as to why this is a good thing.
> - Lack of sign-off.
>
> Why is there still 1/2, if its effect is wholly annulled by a
> subsequent step 2/2?


Sorry for that, still trying to find out how git send-email works.

> >  Documentation/git-checkout.txt | 39 ++++++++++++++++++++++++++++++=
+++++----
> >  1 file changed, 35 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/git-checkout.txt b/Documentation/git-che=
ckout.txt
> > index 5c3ef86..ec0be28 100644
> > --- a/Documentation/git-checkout.txt
> > +++ b/Documentation/git-checkout.txt
> > @@ -116,10 +116,41 @@ entries; instead, unmerged entries are ignore=
d.
> >  --theirs::
> >       When checking out paths from the index, check out stage #2
> >       ('ours', HEAD) or #3 ('theirs', MERGE_HEAD) for unmerged path=
s.
> > -+
> > -After a `git pull --rebase`, for example, 'ours' points to the rem=
ote
> > -version and 'theirs' points to the local version. See linkgit:git-=
merge[1]
> > -for details about stages #2 and #3.
> > +     See linkgit:git-merge[1] for details about stages #2 and #3.
> > ++
> > +Note that during `git rebase` and `git pull --rebase`, 'theirs' ch=
ecks out
> > +the local version, and 'ours' the remote version or the history th=
at is rebased
> > +against.
> > ++
> > +The reason ours/theirs appear to be swapped during a rebase is tha=
t we
> > +define the remote history as the canonical history, on top of whic=
h our
> > +private commits are applied on, as opposed to normal merging where=
 the
> > +local history is the canonical one.
>
> "We define" sounds a bit strange to me.
>
> It is not "we" who define so.  Those who use "rebase" because they
> employ a shared central repository workflow are the ones that treat
> the history of their "remote repository" (which is their shared
> central repository) as the canonical one.


Yes, that is how it is meant; I checked other parts of the
documentation of git-checkout, and they use the same style, e.g.:
 > Let=E2=80=99s look at what happens when we checkout commit b (here w=
e show
two ways this may be done)


>         Note that during `git rebase` and `git pull --rebase`,
>         'ours' and 'theirs' may appear swapped; `--ours` gives the
>         version from the branch the changes are rebased onto, while
>         `--theirs` gives the version from the branch that holds your
>         work that is being rebased.
>
>         This is because `rebase` is used in a workflow that treats
>         the history at the remote as the shared canonical one, and
>         treat the work done on the branch you are rebasing as the
>         third-party work to be integrated, and while you are
>         rebasing, you are temporarily assuming the role of the
>         keeper of the canonical history.  As the keeper of the
>         canonical history, you would view the history from the
>         remote as `ours`, while what you did on your side branch as
>         `theirs`.

Could you commit your version? I think that's easier.

> > +During merging, we assume the role of the canonical history=E2=80=99=
s keeper,
> > +which, in case of a rebase, is the remote history, and our private=
 commits
> > +look to the keeper as =E2=80=9Ctheir=E2=80=9D commits which need t=
o be integrated on top
> > +of =E2=80=9Cour=E2=80=9D work.
> > ++
> > +Normal merging:
> > +------------
> > +local ---------abC                  <-- canonical history
> > +                 | git checkout --ours
> > +                 v
> > +MERGE ---------abC
> > +                 ^
> > +                 | git checkout --theirs
> > +origin/master ---Xyz
> > +------------
> > +Rebasing:
> > +------------
> > +local -----------Abc
> > +                 | git checkout --theirs
> > +                 v
> > +REBASE --------xyZ
> > +                 ^
> > +                 | git checkout --ours
> > +origin/master -xyZ                    <-- canonical history
> > +------------
>
> I can see that an arrow with "canonical history" points at different
> things between the two pictures, but other than that, I am not sure
> what these are trying to illustrate.  Especially between abc and
> xyz, why does the former choose abc while the latter choooses xyz?
> Are these pictures meant to show what happens when the user says
> "checkout --ours" during a conflicted integration (whether it is a
> merge or a rebase)?


I tried to create a picture which shows the difference of ours and
theirs when merging vs. rebasing, but apparently it did not turn out
well, and I will just leave it away.

Simon
