From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] Documentation/git-commit: reword the --amend explanation
Date: Thu, 04 Apr 2013 18:49:19 +0200
Message-ID: <1365094159.30466.60.camel@centaur.cmartin.tk>
References: <1364994441-15961-1-git-send-email-cmn@elego.de>
	 <7v4nfn7j5i.fsf@alter.siamese.dyndns.org>
	 <7vtxnn4c02.fsf@alter.siamese.dyndns.org>
	 <50CA4F4141DD484D97CA8BA571529F65@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 18:49:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNnLw-00021b-NU
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 18:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763231Ab3DDQtD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Apr 2013 12:49:03 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:38551 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763188Ab3DDQtB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 12:49:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id B0CA5DE078;
	Thu,  4 Apr 2013 18:48:59 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zh7q1CTNVSMj; Thu,  4 Apr 2013 18:48:59 +0200 (CEST)
Received: from [192.168.1.2] (p57A96DFD.dip.t-dialin.net [87.169.109.253])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 494BFDE077;
	Thu,  4 Apr 2013 18:48:59 +0200 (CEST)
In-Reply-To: <50CA4F4141DD484D97CA8BA571529F65@PhilipOakley>
X-Mailer: Evolution 3.6.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220033>

On Wed, 2013-04-03 at 23:25 +0100, Philip Oakley wrote:
> Sent: Wednesday, April 03, 2013 9:04 PM
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Yes, and since then we gained --no-edit option and such, so "edito=
r
> >> starts off" also needs to be rethought, no?  The original wording
> >> with "seeded" may have a better chance of survival, I suspect, but
> >> still needs some adjustment.
> >
> > So here is my attempt.  We still need a sign-off from you even if w=
e
> > decide to use this version.  Relative to your original patch:


Sorry I keep forgetting lately, it seems I've been away from core git
too long.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

> > -- >8 --
> > From: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
> >
> > The explanation for 'git commit --amend' talks about preparing a tr=
ee
> > object, which shouldn't be how user-facing documentation talks abou=
t
> > commit.
> >
> > Reword it to say it works as usual, but replaces the current commit=
=2E
> >
> > ---
> > Documentation/git-commit.txt | 17 +++++++++--------
> > 1 file changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/git-commit.txt=20
> > b/Documentation/git-commit.txt
> > index 19cbb90..bc919ac 100644
> > --- a/Documentation/git-commit.txt
> > +++ b/Documentation/git-commit.txt
> > @@ -190,14 +190,15 @@ OPTIONS
> >  without changing its commit message.
> >
> > --amend::
> > - Used to amend the tip of the current branch. Prepare the tree
> > - object you would want to replace the latest commit as usual
> > - (this includes the usual -i/-o and explicit paths), and the
> > - commit log editor is seeded with the commit message from the
> > - tip of the current branch. The commit you create replaces the
> > - current tip -- if it was a merge, it will have the parents of
> > - the current tip as parents -- so the current top commit is
> > - discarded.
> > + Create a new commit and replace the tip of the current
> > + branch.
>=20
> I don't think we should say "Create New" at the start of the sentence=
,
> which may confuse some, rather we should start with the key
> 'Replace' verb, essentially swapping the parts to say:
>=20
>  + Replace the tip of the current branch with a fresh commit.
> [or updated commit, or new commit, or ...]

Ack, we should lead with the goal, I'd go for the

    "Replace the tip of the current branch with a new commit"

wording.


>=20
> >                  The recorded tree is prepared as usual (including
> > + the effect of the `-i` and `-o` options and explicit

Is "recorded tree" what we want to say at porcelain level? I'd go for
"The commit" as in my version, but maybe it's just the way I think abou=
t
it. I don't feel too strongly about changing it, though.

> > + pathspec), and the message from the original commit is used
> > + as the starting point, instead of an empty message, when no
> > + other message is specified from the command line via options
> > + such as `-m`, `-F`, `-c`, etc.  The new commit has the same
> > + parents and author as the current one (the `--reset-author`
> > + option can countermand this).
> > +

The rest looks great.

   cmn
