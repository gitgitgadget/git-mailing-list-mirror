From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 10:34:00 +0100
Message-ID: <20071219093400.GA4361@diana.vm.bytemark.co.uk>
References: <20071214105238.18066.23281.stgit@krank> <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com> <20071217224812.GA6342@diana.vm.bytemark.co.uk> <20071218052115.GA13422@diana.vm.bytemark.co.uk> <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 10:34:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4vKE-0003te-FY
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 10:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbXLSJeT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 04:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbXLSJeT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 04:34:19 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2252 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbXLSJeS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 04:34:18 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1J4vJQ-0001Bz-00; Wed, 19 Dec 2007 09:34:00 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68873>

On 2007-12-18 16:09:24 +0000, Catalin Marinas wrote:

> On 18/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> >       "stg status --reset" is not needed anymore
>
> I would keep this as an alias for 'git reset --hard' (see below as
> well).
>
> >       Remove "stg add"
> >       Remove "stg rm"
> >       Remove "stg cp"
>
> I plan to add a generic command for these kind of aliases. The
> reason is that I don't really like mixing GIT and StGIT commands (I
> think at some point I'll get confused and try to run stg commands
> with git).

How should these aliases be presented in the documentation etc.? I
suggest making it very clear that they are only aliases.

> >       Remove "stg resolved"
>
> I'd like to keep this command. git-mergetool doesn't support the
> tool I use (emacs + ediff and more stgit-specific file extensions
> like current, patch etc.).

So why have a separate command instead of fixing git-mergetool?

> I also don't find 'git add' to be meaningful for marking a conflict
> as solved.

So maybe let "stg resolved" be an alias for "git add"?

This is all our usual disagreement: You want stg to be a fairly
standalone tool, and I want it to be a tool to use side by side with
git. The problem I see with your approach is that stg risks ending up
like Cogito: it'll provide inspiration for improving git, but will
itself become obsolete because of the simple fact that git has so much
more development manpower. I think it'd be more productive to let stg
do one thing -- patch stacks -- and do it well, and rely on git for
everything else.

Of course, if stuff like "stg add" and "stg resolved" are really
implemented as three-line wrappers around git commands, we don't have
that problem.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
