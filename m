From: Sebastian Leske <Sebastian.Leske@sleske.name>
Subject: git-svn: What is --follow-parent / --no-follow-parent for?
Date: Tue, 20 Nov 2012 08:31:53 +0100
Message-ID: <20121120073153.GA340@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 20 08:44:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaiVg-0002Ee-Bj
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 08:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635Ab2KTHoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2012 02:44:30 -0500
Received: from serv28.loswebos.de ([213.187.93.221]:45227 "EHLO
	serv28.loswebos.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab2KTHo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 02:44:29 -0500
X-Greylist: delayed 618 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Nov 2012 02:44:29 EST
Received: from iota.localnet (unknown [46.115.53.181])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by serv28.loswebos.de (Postfix) with ESMTPSA id DEF791F54976
	for <git@vger.kernel.org>; Tue, 20 Nov 2012 08:33:41 +0100 (CET)
Received: from sleske by iota.localnet with local (Exim 4.69)
	(envelope-from <Sebastian.Leske@sleske.name>)
	id 1TaiJG-0000X2-JB
	for git@vger.kernel.org; Tue, 20 Nov 2012 08:31:54 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210084>

Hi,

on reading the docs of "git-svn", I stumbled across this paragraph:

> --follow-parent
> This is especially helpful when we=E2=80=99re tracking a directory th=
at has been
> moved around within the repository, or if we started tracking a branc=
h
> and never tracked the trunk it was descended from.  This feature is
> enabled by default, use --no-follow-parent to disable it.

However, this does not make sense to me: This sounds like there is no
good reason *not* to enable this option.  So why is it there? And in
what situation might I want to use "--no-follow-parent"?

As a matter of fact, I'm not even sure what "--no-follow-parent" does
(and the docs don't really say).=20

I tried it out with a small test repo with a single branch (produced by
copying the trunk, then later deleted). With --follow-parent git-svn
correctly detected the branch point, and modeled the branch deletion as
a merge. With --no-follow-parent it just acted as if branch and trunk
were completely unrelated.

Commit graph of git-svn result:

--follow-parent:               --no-follow-parent:


       |                               |
      /|                             | |
     / |                             | |
     | |                             | |
     | |                             | |
     | |                             | |
     \ |                             | |
      \|                             | |
       |                               |=20


(please excuse cheap ASCII art)

Is that the only effect of --no-follow-parent? And again, why would I
want that?

I'd be grateful for any clarifications. If I manage to understand the
explanation, I'll volunteer to summarize it into doc patch (if there ar=
e
no objections).
