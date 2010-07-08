From: Tait <git.git@t41t.com>
Subject: Re: fixing workdirs
Date: Thu, 8 Jul 2010 11:37:14 -0700
Message-ID: <20100708183714.GR2480@ece.pdx.edu>
References: <20100708110842.GC12789@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@madism.org>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 08 20:48:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWw9V-0005R9-Li
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 20:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793Ab0GHSss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 14:48:48 -0400
Received: from rcpt.cat.pdx.edu ([131.252.208.107]:46489 "EHLO
	rcpt.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002Ab0GHSsr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 14:48:47 -0400
X-Greylist: delayed 684 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2010 14:48:47 EDT
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by rcpt.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id o68IbFuB018950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Jul 2010 11:37:15 -0700
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o68IbEq6001272;
	Thu, 8 Jul 2010 11:37:14 -0700 (PDT)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o68IbEMx001271;
	Thu, 8 Jul 2010 11:37:14 -0700 (PDT)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <20100708110842.GC12789@madism.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (rcpt.cat.pdx.edu [131.252.208.107]); Thu, 08 Jul 2010 11:37:15 -0700 (PDT)
X-Spam-Status: No, score=0.1 required=6.0 tests=L_PHISH4 autolearn=no
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on rcpt.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.95.2 at rcpt.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150590>


Pierre Habouzit <madcoder_madism.org> said (on 2010/07/08):
> ...                                    The workdir HEAD reflog is then a
> symlink to the masters.

#include <std-symlink-rant>

On programs (like git) pretending to be cross-platform, symlinks should
be avoided. They are to varying degrees, painful on non-*nix operating
systems.

Windows is an especially compatibility-breaking example, not only on the
programming side, but also in relation to user interface, and compatibility
with other programs. Programming-wise, documentation is sparse and
would require lots of platform-specific work-arounds. The user-interface
support is worse than terrible. And even if git does everything right,
there's no guarantee a copy, backup/restore, antivirus program, etc. won't
come along and corrupt the environment git so carefully created. Many of
those other programs don't properly handle Windows reparse points. For
those interested, http://shell-shocked.org/article.php?id=284 gives a
reasonable-looking overview of the details on Windows.
