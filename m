From: Kumar Gala <galak@kernel.crashing.org>
Subject: git-send-email and pine alias format
Date: Mon, 23 Jul 2007 11:49:29 -0500 (CDT)
Message-ID: <Pine.LNX.4.64.0707231146160.6889@blarg.am.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 18:49:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID16b-0002sL-9e
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 18:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761862AbXGWQty (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 12:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761758AbXGWQty
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 12:49:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:42620 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758063AbXGWQtx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 12:49:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l6NGnpbS007252
	for <git@vger.kernel.org>; Mon, 23 Jul 2007 11:49:52 -0500
X-X-Sender: galak@blarg.am.freescale.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53443>

I was wondering why we don't parse the pine alias format according to the
following spec:

http://www.washington.edu/pine/tech-notes/low-level.html

I'd expect omething like, to get the address field.

@@ -225,7 +238,7 @@ my %parse_alias = (
                        $aliases{$1} = [ split(/\s+/, $2) ];
                }}},
        pine => sub { my $fh = shift; while (<$fh>) {
-               if (/^(\S+)\t.*\t(.*)$/) {
+               if (/^(\S+)\s+(.*)$/) {
                        $aliases{$1} = [ split(/\s*,\s*/, $2) ];
                }}},
        gnus => sub { my $fh = shift; while (<$fh>) {

- k
