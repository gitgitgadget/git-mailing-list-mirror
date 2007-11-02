From: Pierre Habouzit <madcoder@debian.org>
Subject: let's retry this based on git-rev-parse --parseopt
Date: Fri,  2 Nov 2007 23:39:47 +0100
Message-ID: <1194043193-29601-1-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org
To: gitster@pobox.com, torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Fri Nov 02 23:40:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io5Bf-0002Dm-0z
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 23:40:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053AbXKBWj5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 18:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754833AbXKBWj4
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 18:39:56 -0400
Received: from pan.madism.org ([88.191.52.104]:45427 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204AbXKBWjz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 18:39:55 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 4EA3A282CF;
	Fri,  2 Nov 2007 23:39:54 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 0D86A8412; Fri,  2 Nov 2007 23:39:53 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1460.gdb47
In-Reply-To: alpine.LFD.0.999.0711020844310.3342@woody.linux-foundation.org
References: alpine.LFD.0.999.0711020844310.3342@woody.linux-foundation.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63187>

So as it seems git-rev-parse is the place to do that, here is a new
proposal, with a few more commands migrated. Of course it doesn't means
we should not rewrite some (if not all) of the shell scripts as
builtins, but it will take some pain from the user, and provide nice
option parsers from day 1 for new porcelains.

I believe that the git-am.sh migration is a perfect example of why this
option parser helps.

Note that in the patch 1, the documentation _needs_ to be reviewed by a
native speaker.
