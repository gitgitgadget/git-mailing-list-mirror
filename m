From: Junio C Hamano <junkio@cox.net>
Subject: [WARNING] please stop using git.git "next" for now
Date: Wed, 03 May 2006 14:53:31 -0700
Message-ID: <7virombwro.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 23:53:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbPHv-0002YT-Ns
	for gcvg-git@gmane.org; Wed, 03 May 2006 23:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWECVxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 17:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWECVxe
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 17:53:34 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:21720 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751368AbWECVxd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 17:53:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060503215332.CNJP25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 3 May 2006 17:53:32 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19524>

I just noticed there is a breakage in write-tree optimization
that uses the new cache-tree data structure in the "next"
branch.  Switching branches with "git checkout anotherbranch"
when your index exactly matches the current HEAD commit and then
immediately doing write-tree produces a nonsense tree, and
commits on top of that results in tree objects that have
duplicated entries.

I will be working on a fix now, but in the meantime please do
not use the "next" branch for real work.  Sorry for the
breakage.
