From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Shell aliases & paths
Date: Tue, 4 May 2010 17:22:58 -0400
Message-ID: <19424.36914.867693.327548@winooski.ccs.neu.edu>
References: <19424.34226.564684.613674@winooski.ccs.neu.edu>
	<20100504211122.GA15091@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 23:23:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Pa9-00040k-89
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 23:23:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933905Ab0EDVXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 17:23:00 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:45968 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933820Ab0EDVXA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 17:23:00 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9PZy-0007XU-Sa; Tue, 04 May 2010 17:22:58 -0400
In-Reply-To: <20100504211122.GA15091@progeny.tock>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146346>

On May  4, Jonathan Nieder wrote:
> Eli Barzilay wrote:
>=20
> > AFAICT, a shell command alias (one that starts with a "!") is
> > executed from the repository root, but to make things worse it
> > looks like there is no way to tell which directory it was executed
> > from.  If this is correct, then these aliases are useless for
> > anything that need to accept relative paths.  Is there something
> > obvious that I'm missing?
>=20
> Not that I can see.  Maybe a new GIT_PATHNAME_PREFIX environment
> variable would help.

Yeah, I was searching the environment for something like that, and was
surprised when I didn't find any shred of the original path in there.
(In any case, I'd like to see something like that, although it's too
late for me to use it since I need a solution that works now...)


> If we were starting from scratch, it might be nice to make aliases
> suppress the chdir to toplevel.  Unfortunately, that would probably
> break some existing aliases.  Another possibility would be to use
> some alternative convention (like [alias] foo =3D "# bar") to suppres=
s
> the repository search.



> At that point, why not just add a git-foo script to $PATH?  (=E2=80=98=
git
> foo=E2=80=99 will still call it.)

The same can be said on all shell aliases, no?

=46WIW, I find these aliases more convenient in having "extensions" wor=
k
for other people -- ie, it's easier to say "here's some text, dump it
in your ~/.gitconfig" than it is to explain where some script should
be added and how ("put the text in a git-foo file, make sure to chmod
+x it, put that in your $PATH, you do have your own bin directory,
right?").

(But the disclaimer here is that I have a very narrow point of view.)

--=20
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay=
:
                    http://barzilay.org/                   Maze is Life=
!
