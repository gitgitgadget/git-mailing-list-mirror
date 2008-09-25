From: Jonas Fonseca <fonseca@diku.dk>
Subject: [TG PATCH] depend: Fix help listing
Date: Thu, 25 Sep 2008 12:50:40 +0200
Message-ID: <20080925105039.GA12949@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 12:51:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KioRv-0001uE-Gt
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 12:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbYIYKuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 06:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753014AbYIYKuq
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 06:50:46 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:51464 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752929AbYIYKup (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 06:50:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 8214019BC0E;
	Thu, 25 Sep 2008 12:50:44 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22529-16; Thu, 25 Sep 2008 12:50:40 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 2A7D219BB24;
	Thu, 25 Sep 2008 12:50:40 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 918946DF823; Thu, 25 Sep 2008 12:50:06 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 09B4C1A4001; Thu, 25 Sep 2008 12:50:40 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96745>

Without this `tg help depend` causes all kinds of trouble such as adding
empty lines to .topdeps.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
 tg-depend.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/tg-depend.sh b/tg-depend.sh
index af78808..498eec4 100644
--- a/tg-depend.sh
+++ b/tg-depend.sh
@@ -9,6 +9,10 @@ name=
 ## Parse options
 
 subcmd="$1"; shift
+[ "$subcmd" = "-h" ] && {
+	echo "Usage: tg [...] depend add NAME" >&2
+	exit 1
+}
 [ "$subcmd" = "add" ] || die "unknown subcommand ($subcmd)"
 
 while [ -n "$1" ]; do
-- 
tg: (212809f..) jf/depend-help (depends on: master)

-- 
Jonas Fonseca
