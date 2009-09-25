From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: how optparse can go horribly wrong
Date: Fri, 25 Sep 2009 16:32:26 -0700
Message-ID: <20090925233226.GC14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 26 01:32:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrKHC-0001Jz-R7
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 01:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbZIYXcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 19:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbZIYXcW
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 19:32:22 -0400
Received: from george.spearce.org ([209.20.77.23]:45030 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbZIYXcW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 19:32:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8F69038151; Fri, 25 Sep 2009 23:32:26 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129134>

*sigh*.  Someone just ran into this today:

  $ git commit -a -ammend
  [work ce38944] mend
   1 files changed, 2 insertions(+), 0 deletions(-)

Omit one - and include an extra 'm', and instead of --amend you
have -a -m mend.  Which isn't exactly what you wanted.

We do catch -amend with an error though:

  $ git commit -amend
  error: did you mean `--amend` (with two dashes ?)

I wonder, should the -m flag on commit not allow cuddling its
value against the switch when its combined in short form with
other switches?

-- 
Shawn.
