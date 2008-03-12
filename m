From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: optimized checkout+rebase?
Date: Wed, 12 Mar 2008 20:10:41 +0100
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080312191041.GF3198@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 20:11:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZWMH-0005Jy-Bz
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 20:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804AbYCLTKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 15:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbYCLTKr
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 15:10:47 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:43473 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbYCLTKq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 15:10:46 -0400
Received: from localhost.localdomain (xdsl-87-78-70-167.netcologne.de [87.78.70.167])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 74AC040002DDC
	for <git@vger.kernel.org>; Wed, 12 Mar 2008 20:10:45 +0100 (CET)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1JZWLZ-0001Ah-Uf
	for git@vger.kernel.org; Wed, 12 Mar 2008 20:10:41 +0100
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76974>

Hello,

this is a common work pattern:

  git checkout master
  git pull
  for branch in $my_topic_branches; do
    git checkout $branch
    git rebase master
    # occasional fixups here...
  done

Now, it looks to me that one of the first operations of rebase just
undoes part of the work that the checkout of the branch did.  Well,
"undoes" is the wrong word, what I mean is that it looks like work
may be saved by combining the two checkout and the rewinding step.

Has this optimization already been implemented in git by some command
I've overlooked, and if no, do you agree that there is some optimization
possible?

Thanks,
Ralf
