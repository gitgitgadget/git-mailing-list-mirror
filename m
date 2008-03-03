From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] help: add "man.viewer" config var to use "woman" or "konqueror"
Date: Mon, 3 Mar 2008 08:20:52 +0100
Message-ID: <200803030820.52842.chriscool@tuxfamily.org>
References: <20080228051956.2f36edf0.chriscool@tuxfamily.org> <7vfxvcdx23.fsf@gitster.siamese.dyndns.org> <200803010100.m21105LU008843@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, pascal@obry.net,
	nanako3@bluebottle.com, git@vger.kernel.org
To: Xavier Maillard <xma@gnu.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 08:15:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW4tv-0000Yy-BR
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 08:15:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbYCCHPN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2008 02:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753335AbYCCHPM
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 02:15:12 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:45390 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbYCCHPL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2008 02:15:11 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 817DB1AB2EC;
	Mon,  3 Mar 2008 08:15:08 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E63101AB2EB;
	Mon,  3 Mar 2008 08:15:07 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <200803010100.m21105LU008843@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75898>

Le samedi 1 mars 2008, Xavier Maillard a =E9crit :
>    Looking at this exchange really makes me suspect that these
>    things should not be in C.  Every time Emacs updates we need
>    recompilation?  Yuck.
>
> In fact, I am pretty confident that emacsclient has always
> printed its version onto stdout so I do not think we need to
> recompile every week :)

On my Kubuntu Feisty development machine with the stock emacs=20
21.4a+1-2ubuntu1.1 package I get:

$ emacsclient --version
emacsclient 21.4
$ emacsclient --version 2>/dev/null
$ emacsclient --version 1>/dev/null
emacsclient 21.4

And I don't think it specific to Kubuntu because I remenber getting the=
 same=20
with emacs21 (before installing emacs22) on another (Debian testing)=20
machine.

>    What was the reason we gave up calling out to a single generic
>    scripted wrapper that the users can just munge to suit their
>    tastes?

I didn't gave up, I am just waiting for the implementation of a scripte=
d=20
wrapper in git-mergetool.sh, that is now in 'pu', to mature. Then I wil=
l=20
steal it so we have the same for git help.

> Good question. Though I find chriscool's implementation nicely
> thought.

Thanks.

> With the modifications I made, this works as expected=20
> with either emacs22 and emacs23 (aka CVS). What's more, how a
> user could have tested if emacsclient was provided in the right
> version using a generic scripted wrapper ?

I agree that it's better to do it for the users.

In fact just after this email, I will send a patch to "run_command.c" n=
amed:

"Redirect stderr to a pipe before redirecting stdout to stderr"

that will make my last patches to "help.c" work with both Emacs21 and=20
Emacs22.

> I guess, chriscool should provide a more consistent emacsclient
> wrapper with support for GNU Emacs version >=3D 21. This won't be
> an enormous amount of work to do it (I can help him if he wants
> to but I do not want to steal the paternity of his idea).

It would help if you could test with Emacs23 as I didn't installed it.

Thank you for testing my patches.

Christian.
