From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 0/7] gitk -L
Date: Tue, 29 Oct 2013 08:20:33 +0100
Message-ID: <cover.1383031141.git.tr@thomasrast.ch>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 29 08:21:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb3cO-0006Sy-To
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 08:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978Ab3J2HVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 03:21:06 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:56247 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952Ab3J2HVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 03:21:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 931E94D65A8;
	Tue, 29 Oct 2013 08:21:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 76AFwFuUYTAR; Tue, 29 Oct 2013 08:20:51 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id AD9364D6414;
	Tue, 29 Oct 2013 08:20:49 +0100 (CET)
X-Mailer: git-send-email 1.8.4.2.838.ga9a3e20
In-Reply-To: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236903>

Thomas Rast wrote:
> Jonathan Nieder wrote:
> > Support for just the sticked form is better than nothing, especially
> > if the gitk(1) manpage gains a note about it.  In the long run I guess
> > the ideal would be to add a parse-options-like library to the tcl
> > support.
> 
> Ok.  I'm generally not happy with the state of that manpage, so I took
> the chance to improve it.
> [...]
> I'll hold the gitk patches until we get this one sorted out, but then
> just do the sticked form as before.

Ok, there weren't any comments and this patch is in 'next', so here's
gitk -L built on top of it.

I'm sending this as a single topic, but once agreement is reached, it
has to be applied in two parts: the gitk patches (1-5) need to be
subtree-rebased to match gitk.git, and then merged separately, while
the documentation patches (6&7) need to be applied directly.  The
latter depend on the patch I'm replying to.

Changes since v1:

* 1/7 is new; while investigating the sticked/unsticked issue, I
  noticed that -G is not even supported by gitk.

* 3/7 has improved snipping logic, to get rid of an extra empty line
  before the diff

* 5/7 has a slightly different comment pointing out that this is only
  the sticked form of -L

* 6&7 are new, to resolve the sticky issue


Thomas Rast (7):
  gitk: support -G option from the command line
  gitk: refactor per-line part of getblobdiffline and its support
  gitk: split out diff part in $commitinfo
  gitk: support showing the gathered inline diffs
  gitk: recognize -L option
  Documentation: put blame/log -L in sticked form
  Documentation/gitk: document -L option

 Documentation/blame-options.txt |   8 +-
 Documentation/git-blame.txt     |   8 +-
 Documentation/git-log.txt       |   6 +-
 Documentation/gitk.txt          |  12 ++
 gitk-git/gitk                   | 467 +++++++++++++++++++++++-----------------
 5 files changed, 293 insertions(+), 208 deletions(-)

-- 
1.8.4.2.838.ga9a3e20
