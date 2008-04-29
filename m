From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git-help: Try to find html pages without the git- prefix
Date: Tue, 29 Apr 2008 05:13:40 +0200
Message-ID: <200804290513.40948.chriscool@tuxfamily.org>
References: <1209377611-90005-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Apr 29 05:09:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqgDi-00070c-5A
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 05:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbYD2DIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 23:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752415AbYD2DIl
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 23:08:41 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:55885 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045AbYD2DIk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2008 23:08:40 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 9CED81AB2BC;
	Tue, 29 Apr 2008 05:08:38 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 545F81AB2BB;
	Tue, 29 Apr 2008 05:08:38 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1209377611-90005-1-git-send-email-pdebie@ai.rug.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80641>

Le lundi 28 avril 2008, Pieter de Bie a =E9crit :
> Some html documentation does not have the git- prefix, for example
> hooks.html. If the git-command.html page does not exist, try to find =
the
> command.html file. This allows commands like `git help -w hooks' to w=
ork

Yes, this works fine for html documentation.

But 'git help -w githooks' could work fine too, if the source filename=20
was "githooks.txt" instead of "hooks.txt". Because the "cmd_to_page"=20
function returns its input as is, if it starts with "git".

And with more filenames like "githooks.txt" we could also have=20
more "githooks" like regular man pages without poluting too much the ma=
n=20
page namespace.

We already have the following files following that scheme:

gitk.txt
gitattributes.txt
gitignore.txt
gitcli.txt
gitmodules.txt
git.txt

And for example the following commands are already working:

$ git help -w gitmodules
$ git help -m gitmodules
$ man gitmodules

("git help -i gitmodules" should work too, but info format help seems=20
broken.)

Of course typing "git help hooks" is shorter and simpler than "git help=
=20
githooks", so it could perhaps still be a good idea to try "gitXXX" as =
a=20
fallback if we find nothing for "git-XXX".

Thanks,
Christian.
