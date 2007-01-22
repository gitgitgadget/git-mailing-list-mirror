From: Yann Dirson <ydirson@altern.org>
Subject: Re: Rebasing stgit stacks
Date: Mon, 22 Jan 2007 20:47:56 +0100
Message-ID: <20070122194756.GA4083@nan92-1-81-57-214-146.fbx.proxad.net>
References: <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com> <20070115202412.GE9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701151446l45eff9dbgcae718c1461d0725@mail.gmail.com> <20070115233958.GF9761@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701161442t6b93e0d6nd88364600f2809ee@mail.gmail.com> <20070116231735.GF7029@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0701180105t7b01cb4di43b4db1fdc314bb7@mail.gmail.com> <20070118205233.GK9761@nan92-1-81-57-214-146.fbx.proxad.net> <eoq439$7ml$1@sea.gmane.org> <tnxirezueui.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 20:48:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H959j-0008K0-VG
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 20:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbXAVTsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 22 Jan 2007 14:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbXAVTsc
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 14:48:32 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:51202 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932405AbXAVTsb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 14:48:31 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 569D957D4;
	Mon, 22 Jan 2007 20:48:29 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 2ADD01F088; Mon, 22 Jan 2007 20:47:56 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnxirezueui.fsf@arm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37440>

On Mon, Jan 22, 2007 at 05:54:29PM +0000, Catalin Marinas wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > Yann Dirson wrote:
> >> On Thu, Jan 18, 2007 at 09:05:47AM +0000, Catalin Marinas wrote:
> >
> >>> As Jakub said, I would also call this command 'rebase' instead of
> >>> 'pull --to', even if we duplicate a bit of code.
> >>> It would make the implementation even simpler
> >>=20
> >> A new command is fine with me, it's just that I feel "rebase <targ=
et>"
> >> may be confusing to beginners. =A0I'd rather say "rebase [<stack>]=
 --to
> >> <target>", but it's just that I don't see the case for specifying =
a
> >> different stack than the current one.
> >
> > If you want to move some stack from one branch to other, for exampl=
e
> > from 'next' or next-based branch to 'origin'/'master' or origin-bas=
ed
> > branch you could do either:
> >
> >   $ git checkout <newbase>
> >   $ stg rebase <stack>
>=20
> Currently, in the StGIT terminology stack and branch are about the
> same. If you want to move to a different stack, just use the "stg
> branch" command.

I think you missed the point.  StGIT stacks are usually forked off
another branch.  As I understand it, Jakub talks about standard
rebasing, ie. moving the stack base from its current parent branch to
a new one.


> A stack is just a branch with stgit-specific metadata.

I would rather say that an StGIT stacks uses a branch, but the stack
is not the branch - eg, unapplied patches do not belong to the branch.

Indeed I was thinking about that today, and thought that maybe it
would make sense not to use a head ref (and thus not using a real
branch), which would minimize the risk of someone committing by error
(and thus minimize the need to use "assimilate"), since porcelainish
commit tools would then refuse to commit there.


> What you'd probably want is a way to import patches from a different
> branch/stack onto the newly checked out branch.

Sometimes you just want to throw out an obsolete branch and move your
stack to a new baseline.  That said, being able to duplicate a stack
(and possibly rebasing it afterwards) would be useful as well.


> > Although usually you have separate branch as StGIT stack "base", an=
d
> > you can simply rebase git branch, then do
> >
> >   $ stg rebase

Oh, I think I understand - he probably uses "base" to refer to what I
call "parent branch", and not to the refs/bases/<branch> reference...

Best regards,
--=20
yann.
