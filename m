From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sun, 18 May 2014 19:34:34 +0200
Message-ID: <vpqk39jous5.fsf@anie.imag.fr>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
	<20140516084126.GB21468@sigill.intra.peff.net>
	<xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
	<20140516225228.GA3988@sigill.intra.peff.net>
	<5376f2ca5c90d_65b915db2f877@nysa.notmuch>
	<20140517062413.GA13003@sigill.intra.peff.net>
	<5377994fe8dec_7a27d4b30438@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 18 19:34:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm4z7-0006A6-EZ
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 19:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbaERRet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 13:34:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49637 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbaERRes (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 13:34:48 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s4IHYWmx001896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 18 May 2014 19:34:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s4IHYYmY005106;
	Sun, 18 May 2014 19:34:34 +0200
In-Reply-To: <5377994fe8dec_7a27d4b30438@nysa.notmuch> (Felipe Contreras's
	message of "Sat, 17 May 2014 12:15:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 18 May 2014 19:34:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s4IHYWmx001896
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1401039273.86374@jjC64uJV1EXMjHVfVKQcKQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249502>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>  % git fetch
>  WARNING: git-remote-hg is now maintained independently.
>  WARNING: For more information visit https://github.com/felipec/git-remote-hg
>  searching for changes
>  no changes found

I don't think the situation is as simple as you claim. In many cases,
the first step before the ones you are mentionning are:

  cd $git/contrib/remote-helpers
  cp git-remote-{hg,bzr} somewhere/in/path

They produces no warning if git-remote-{hg,bzr} exist with the warning,
but "no such file or directory: contrib/remote-helpers" if the directory
has been renamed or removed.

When git-remote-{hg,bzr} are installed with a package manager, the fact
that they are part of Git's core or not is often irrelevant. For
example, Debian splits the git.git source into many packages, so a
Debian user will not see any difference between helpers included in
git.git or outside (e.g. I have to install the package git-svn if I want
to use git-svn).

That said, I'm fine with the "add a warning" option too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
