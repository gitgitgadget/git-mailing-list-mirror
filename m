From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-diff/git-format-patch safe for GNU (or POSIX) patch?
Date: Thu, 26 Jun 2008 12:36:07 +0200
Message-ID: <20080626103607.GA16525@diana.vm.bytemark.co.uk>
References: <58230.213.203.159.164.1214476059.squirrel@upmail.polettix.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Flavio Poletti <flavio@polettix.it>
X-From: git-owner@vger.kernel.org Thu Jun 26 12:37:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBoqw-0008Sm-0f
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 12:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754027AbYFZKgZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2008 06:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbYFZKgZ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 06:36:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1626 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbYFZKgY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 06:36:24 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KBopk-0004LF-00; Thu, 26 Jun 2008 11:36:08 +0100
Content-Disposition: inline
In-Reply-To: <58230.213.203.159.164.1214476059.squirrel@upmail.polettix.it>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86427>

On 2008-06-26 12:27:39 +0200, Flavio Poletti wrote:

> When I was happy with the modifications, I used git-format-patch to
> produce the message and the patch to send. I then saw that the
> format is a little different with respect to what diff -u produces;
> in particular, I noticed that there was an added line between the
> "diff --git..." line and the one stating the "origin" file:
>
>                    diff --git a/glib/gstrfuncs.c b/glib/gstrfuncs.c
> *** this one ***   index 61d11ed..7786f10 100644
>                    --- a/glib/gstrfuncs.c
>                    +++ b/glib/gstrfuncs.c

patch ignores any junk it doesn't understand, including this line.

> Moreover, each chunk's header contained added stuff, like the
> "g_ascii_strtoll..." stuff in the following example line:
>
>     @@ -813,6 +813,8 @@ g_ascii_strtoll (const gchar *nptr,

You get this by giving the -p flag to GNU diff; git diff just does it
by default, is all.

> 4. some hints to use git for working on projects that do not use any
> other VCS, or for which one only wants to produce and send a quick
> patch starting from a tarball.

You can use git/contrib/fast-import/import-tars.perl to import the
last few releases into git (possibly just the last release, if you
don't need the history) and then just build on that, and send patches
back to the project when you're done.

When the project makes another release, use import-tars to import the
new tarball, and then rebase if you have any patches they haven't
accepted yet.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
