From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH] Trivial fix: Display a more friendly message with
	git-shell.
Date: Tue, 22 Sep 2009 10:15:44 +0200
Message-ID: <20090922081544.GB48307@book.hvoigt.net>
References: <1253466672-21051-1-git-send-email-tfransosi@gmail.com> <4AB71A76.5010509@viscovery.net> <vpqeiq0ssn7.fsf@bauges.imag.fr> <a4c8a6d00909211345q593e673bo4964204afa5ce807@mail.gmail.com> <vpqr5tzqvzm.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thiago Farina <tfransosi@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 22 10:15:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq0XT-0004EL-3r
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 10:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbZIVIPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2009 04:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbZIVIPn
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 04:15:43 -0400
Received: from darksea.de ([83.133.111.250]:34924 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751402AbZIVIPm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 04:15:42 -0400
Received: (qmail 31289 invoked from network); 22 Sep 2009 10:15:44 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 22 Sep 2009 10:15:44 +0200
Content-Disposition: inline
In-Reply-To: <vpqr5tzqvzm.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128924>

On Tue, Sep 22, 2009 at 09:28:13AM +0200, Matthieu Moy wrote:
> Thiago Farina <tfransosi@gmail.com> writes:
> 
> > On Mon, Sep 21, 2009 at 3:45 AM, Matthieu Moy
> > <Matthieu.Moy@grenoble-inp.fr> wrote:
> >> $ git-shell
> >> git-shell: Restricted login shell for GIT-only SSH access
> >> Usage: ...
> > I added this line to the output usage, but would be good to show the
> > commands that git-shell accept too?
> 
> Well, at some point, I think the user will have to read the man page.
> I find it better to have a non-agressive error message, but I'm not
> sure it's relevant to try to give the complete manual here.

Why not simply like this? I liked the old output as well. And sometimes its
just better to have commands behave like humans ;)

diff --git a/shell.c b/shell.c
index e4864e0..a0da191 100644
--- a/shell.c
+++ b/shell.c
@@ -74,7 +74,8 @@ int main(int argc, char **argv)
         * where "cmd" is a very limited subset of git commands.
         */
        else if (argc != 3 || strcmp(argv[1], "-c"))
-               die("What do you think I am? A shell?");
+               die("What do you think I am? A shell?\n\
+                    See: git help shell");
 
        prog = argv[2];
        if (!strncmp(prog, "git", 3) && isspace(prog[3]))
