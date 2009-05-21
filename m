From: Henk <henk_westhuis@hotmail.com>
Subject: Submodules and merge conflicts
Date: Thu, 21 May 2009 06:22:00 -0700 (PDT)
Message-ID: <1242912120853-2951928.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 15:22:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M78Do-0000GH-0v
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 15:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986AbZEUNWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 09:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753705AbZEUNWA
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 09:22:00 -0400
Received: from kuber.nabble.com ([216.139.236.158]:44171 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753392AbZEUNV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 09:21:59 -0400
Received: from tervel.nabble.com ([192.168.236.150])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <lists+1217463532682-661346@n2.nabble.com>)
	id 1M78Dg-0003kQ-Rl
	for git@vger.kernel.org; Thu, 21 May 2009 06:22:00 -0700
X-Nabble-From: henk_westhuis@hotmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119676>


We have a git repository with 2 submodules structured like this:
-Root
 -Src
    -Scripts [Submodule]
    -Kernel [Submodule]
    -Web

When someone makes changes in the Kernel submodule, the sha1 of the
submodule changes. This means that the repository that uses this submodule
also changes because the link to the submodule changes. This very often
causes confusion. Co-workers very often get merge-conflicts on the submodule
sha1 which are annoying and confusing.

The reason we like using submodules instead of having one larger repository
is that there are seperate teams working on each module. We also use other
version numbers voor the kernel and the appllications using the kernel.

Instead of using the sha1 of a specific revision in the submodule, I would
find it more logical to use a branch-name or tag. This way you can commit on
the submodule without having to commit the new submodule revision to the
main repository also.

I would like to hear your thoughts on this. Maybe we are using submodules
wrong, or maybe this is already possible.

Henk Westhuis

-- 
View this message in context: http://n2.nabble.com/Submodules-and-merge-conflicts-tp2951928p2951928.html
Sent from the git mailing list archive at Nabble.com.
