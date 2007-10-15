From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-svn and submodules
Date: Mon, 15 Oct 2007 16:45:13 +0200
Message-ID: <20071015144513.GB7351@diana.vm.bytemark.co.uk>
References: <20071014091855.GA17397@soma> <20071014095755.GF1198@artemis.corp> <Pine.LNX.4.64.0710141751530.25221@racer.site> <Pine.LNX.4.64.0710141901450.25221@racer.site> <20071014180815.GK1198@artemis.corp> <20071014210130.GA17675@soma> <Pine.LNX.4.64.0710142309010.25221@racer.site> <20071014224959.GA17828@untitled> <Pine.LNX.4.64.0710142359020.25221@racer.site> <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git list <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Oct 15 17:11:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhRCO-0006sy-6A
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 16:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbXJOOp2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Oct 2007 10:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbXJOOp2
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 10:45:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4934 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbXJOOp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 10:45:27 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IhRBx-0002JY-00; Mon, 15 Oct 2007 15:45:13 +0100
Content-Disposition: inline
In-Reply-To: <05CAB148-56ED-4FF1-8AAB-4BA2A0B70C2C@lrde.epita.fr>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61005>

On 2007-10-15 09:07:21 +0200, Benoit SIGOURE wrote:

>   - git svn create-ignore (to create one .gitignore per directory
> from the svn:ignore properties. This has the disadvantage of
> committing the .gitignore during the next dcommit,

I built ignore support for git-svnignore a long time ago. It converts
the per-directory svn:ignore to per-directory .gitignore at commit
import time, which is very handy:

-I <ignorefile_name>::
        Import the svn:ignore directory property to files with this
        name in each directory. (The Subversion and GIT ignore
        syntaxes are similar enough that using the Subversion patterns
        directly with "-I .gitignore" will almost always just work.)

The only downside with that is that svn ignore patterns are
non-recursive, while git ignore patterns are recursive. This could be
solved by prefixing them with a "/".

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
