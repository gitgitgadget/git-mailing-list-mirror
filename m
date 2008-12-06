From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk: 'show origin of this line' barfs if gitk run in subdir
Date: Sat, 6 Dec 2008 21:56:45 +1100
Message-ID: <18746.23149.709046.770559@cargo.ozlabs.ibm.com>
References: <20081203205158.6b4b62c7@crow>
	<20081203222258.6db9b34e@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 11:58:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8urW-0006h3-Ku
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 11:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbYLFK45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2008 05:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754178AbYLFK45
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 05:56:57 -0500
Received: from ozlabs.org ([203.10.76.45]:51155 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722AbYLFK44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 05:56:56 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 5983EDDD0B; Sat,  6 Dec 2008 21:56:54 +1100 (EST)
In-Reply-To: <20081203222258.6db9b34e@crow>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102444>

Mark Burton writes:

> I think the same problem exists with the 'run git gui blame on this
> line' feature. It doesn't work when gitk is started in a subdir of the
> working tree but it does work when gitk is started in the top-level
> directory.

I have checked in a fix into my gitk.git repository at
git://git.kernel.org/pub/scm/gitk/gitk.git.  However, there seems to
be a bug in git gui blame; it gives a "list index out of range" error
sometimes.

Shawn, to see an example of the error, get a current kernel tree and
do:

$ cd arch/powerpc
$ git gui blame --line=1183 2c5e76158fcea6e3b9536a74efa7b5e2e846d374 \
  ../../net/sunrpc/svcsock.c

Paul.
