From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 10:09:40 +0000
Message-ID: <b0943d9e0712190209y485bc2f8w806bd2cad309e74b@mail.gmail.com>
References: <20071214105238.18066.23281.stgit@krank>
	 <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
	 <20071217224812.GA6342@diana.vm.bytemark.co.uk>
	 <20071218052115.GA13422@diana.vm.bytemark.co.uk>
	 <b0943d9e0712180809l4d2d01b8j32ab2a410885cc5e@mail.gmail.com>
	 <20071219093400.GA4361@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 11:10:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4vsL-00069v-VE
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 11:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbXLSKJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 05:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752491AbXLSKJm
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 05:09:42 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:50009 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125AbXLSKJk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 05:09:40 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2600003rvb.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 02:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YN2YK+WpLm7cc8D7NyLhU0J+FTR3hE1CjzDKs5U1bw0=;
        b=twWCWOSI4Bw6x1Q9hSJP3RsoxY60gUovpSIoafvT1V2Km8oiNFy/RVjoq9W4NOVO7xJGCfTNtVsRj77sURMEBOQhQiUCg4NXQGb7XIxQq/SR9anMszoWXxyTH7Dl7Zek/pb62qhPoBnH81vc0ZSKQA2mY1jQZa/U0OYmSVcxP5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hHXkfIU8UES6JWI6yhdXUMvGdztZ4ajj4sBXVg5G24jk/fIvu4EGd2e5u5JdJLIu9cq84CAmOiWrQjeRzsXotTfOc04+EKm6YXCKYz6LOqP15Hp0bVupwG/bUSFJe/VTuL7wJ8z8/o3u0yKVhtMYrAbdYWXE8Sx1Go1X5/7vhmY=
Received: by 10.141.141.3 with SMTP id t3mr5743548rvn.213.1198058980407;
        Wed, 19 Dec 2007 02:09:40 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Wed, 19 Dec 2007 02:09:40 -0800 (PST)
In-Reply-To: <20071219093400.GA4361@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68879>

On 19/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-12-18 16:09:24 +0000, Catalin Marinas wrote:
>
> > On 18/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >
> > >       "stg status --reset" is not needed anymore
> >
> > I would keep this as an alias for 'git reset --hard' (see below as
> > well).
> >
> > >       Remove "stg add"
> > >       Remove "stg rm"
> > >       Remove "stg cp"
> >
> > I plan to add a generic command for these kind of aliases. The
> > reason is that I don't really like mixing GIT and StGIT commands (I
> > think at some point I'll get confused and try to run stg commands
> > with git).
>
> How should these aliases be presented in the documentation etc.? I
> suggest making it very clear that they are only aliases.

Yes, 'stg help' should clearly mark them as aliases of git commands.
I'm not sure how I'll do this yet. For the 'status --reset', I'll keep
it if we have a separate 'resolved' command.

> > >       Remove "stg resolved"
> >
> > I'd like to keep this command. git-mergetool doesn't support the
> > tool I use (emacs + ediff and more stgit-specific file extensions
> > like current, patch etc.).
>
> So why have a separate command instead of fixing git-mergetool?

In the past, StGIT only used the core git functionality and stayed
away from the porcelain scripts. We now started to use some of the
built-in commands more and more and I think it is fine but the git
scripts look more volatile to me than the C code (look at the many
variants the git merging went through, from shell scripts to python
and only now seems to be stabilised with the recursive merge as a
built-in command).

Adding the functionality I need to git-mergetool would also mean
always using the latest GIT with StGIT. Anyway, if you like
git-mergetool, I think you can easily change the StGIT configuration
to

> > I also don't find 'git add' to be meaningful for marking a conflict
> > as solved.
>
> So maybe let "stg resolved" be an alias for "git add"?

It's not a simple alias, if you use 'stg resolved -a'. Now, if we
allow stgit.keeporig, it needs even more functionality.

> This is all our usual disagreement: You want stg to be a fairly
> standalone tool, and I want it to be a tool to use side by side with
> git. The problem I see with your approach is that stg risks ending up
> like Cogito: it'll provide inspiration for improving git, but will
> itself become obsolete because of the simple fact that git has so muc=
h
> more development manpower.

If GIT would have all the functionality I need for my workflow, I
wouldn't mind giving up StGIT (I started StGIT because I needed easier
patch management on top of GIT and modifying Quilt would've been too
intrusive).

> I think it'd be more productive to let stg
> do one thing -- patch stacks -- and do it well, and rely on git for
> everything else.

In principle, yes, but I have some minor problems with the UI of GIT
(like resolved =3D=3D add). I think there is also a fundamental differe=
nce
between 'git commit' and 'stg refresh'. The former requires explicit
marking of the files to commit (or use the -a option) while the latter
always adds all the local changes to the current patch. Maybe GIT
users are more used to running 'git add' after fixing a conflict but I
use StGIT almost exclusively.

> Of course, if stuff like "stg add" and "stg resolved" are really
> implemented as three-line wrappers around git commands, we don't have
> that problem.

=46or add/rm/cp, they should just be a generic wrapper which doesn't
even parse the command line options. That's not the case with
'resolved'.

--=20
Catalin
