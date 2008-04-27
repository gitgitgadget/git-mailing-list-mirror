From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-send-email: add a new sendemail.cc configuration
	variable
Date: Sun, 27 Apr 2008 14:14:58 +0200
Message-ID: <20080427121458.GU4012@genesis.frugalware.org>
References: <1209244746-12649-1-git-send-email-vmiklos@frugalware.org> <alpine.DEB.1.00.0804262330370.7944@eeepc-johanness> <20080426232737.GR4012@genesis.frugalware.org> <alpine.DEB.1.00.0804271252200.16320@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 14:15:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq5nJ-0000ig-1D
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 14:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976AbYD0MPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 08:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755292AbYD0MPA
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 08:15:00 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47782 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754926AbYD0MPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 08:15:00 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1AACE1B251D;
	Sun, 27 Apr 2008 14:14:59 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E730344659;
	Sun, 27 Apr 2008 14:11:19 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 89D2611904D3; Sun, 27 Apr 2008 14:14:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804271252200.16320@eeepc-johanness>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80446>

Some projects prefer to always CC patches to a given mailing list. In
these cases, it's handy to configure that address once.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sun, Apr 27, 2008 at 12:53:34PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Yes and no. :-) I first searched for a --cc option in send-email,
> > then
> > realized that only format-patch has one.
>
> You are completely correct, sorry.  Hmm.  I would have preferred
> send-email inserting that header, oh well.

Heh, no. git-send-email has a --cc option as well, just it was not
configurable. Here is a one-liner which does the trick.

 git-send-email.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 9e568bf..cb05cf5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -203,6 +203,7 @@ my %config_settings = (
     "smtpuser" => \$smtp_authuser,
     "smtppass" => \$smtp_authpass,
     "to" => \@to,
+    "cc" => \@initial_cc,
     "cccmd" => \$cc_cmd,
     "aliasfiletype" => \$aliasfiletype,
     "bcc" => \@bcclist,
-- 
1.5.5.1
