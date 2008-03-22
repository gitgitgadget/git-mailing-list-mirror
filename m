From: Jeff King <peff@peff.net>
Subject: Re: perl should be optional like tcl
Date: Sat, 22 Mar 2008 13:10:02 -0400
Message-ID: <20080322171001.GC7611@coredump.intra.peff.net>
References: <d512a4f30803220644j1c74642fne709e27da792850@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sylvain Bertrand <sylvain.bertrand@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 18:11:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd7FM-0006sT-1n
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 18:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbYCVRKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 13:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbYCVRKG
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 13:10:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4973 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257AbYCVRKF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 13:10:05 -0400
Received: (qmail 1229 invoked by uid 111); 22 Mar 2008 17:10:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 22 Mar 2008 13:10:03 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Mar 2008 13:10:02 -0400
Content-Disposition: inline
In-Reply-To: <d512a4f30803220644j1c74642fne709e27da792850@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77826>

On Sat, Mar 22, 2008 at 02:44:06PM +0100, Sylvain Bertrand wrote:

> I'm a gentoo user and since a long time I have been able to disable
> the perl sweet thanks to the gentoo "-perl" use flag. Recently I
> realized that was not possible anymore (I have *tons* of perl
> dependencies pulled on my system because of this).

Sure, it is possible to do this, and most of git would still work. You
would lose:

  - gitweb
  - interactive add ("git add -i")
  - send-email
  - CVS/SVN/arch integration (cvsimport, cvsserver, cvsexportcommit,
    svn, archimport)
  - git-relink (which I'm not sure is commonly used anyway)

The test scripts also use perl a bit, so you would lose the ability to
run the tests.

The right way would probably be to add a NO_PERL flag to the Makefile to
avoid building these programs.  I'm not sure anyone else cares enough to
spend time on this themselves, but you might try working up a patch.

-Peff
