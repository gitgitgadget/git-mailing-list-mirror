From: Bill Lear <rael@zopyra.com>
Subject: How to revert one of multiple merges
Date: Sat, 17 Oct 2009 21:31:37 -0500
Message-ID: <19162.32265.738503.382638@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 18 05:09:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzM9L-0002Ii-V8
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 05:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbZJRDJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 23:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754165AbZJRDJ1
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 23:09:27 -0400
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:57446
	"EHLO zopyra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164AbZJRDJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2009 23:09:27 -0400
X-Greylist: delayed 2268 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 Oct 2009 23:09:27 EDT
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id n9I2ViJ18689;
	Sat, 17 Oct 2009 20:31:44 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130583>

Branch A, B, C each have 20 commits, 0-19.

Branch v1.0.0 created, then merge of A, B, C performed.

After testing, we realize that the branch B is not ready for
production release and we'd like to remove it from branch
v1.0.0.

If I do

% git merge A B C

I get a single commit:

% git log -p

commit 1644a0b98c01869aa83e59aa41374c22098c47b6
[...]
Date:   Fri Oct 16 09:52:32 2009 -0500

    Merge branches 'A', 'B' and 'C' into v1.0.0

[20 x 3 commits]

If I do

% git merge A
% git merge B
% git merge C

Then:

% git log -p

commit 8946edd381384d0882221c87b5b3b7bf47127d70
[...]
Date:   Sat Oct 17 21:28:36 2009 -0500

    Merge branch 'B' into v1.0.0

commit 076ed422443e3684e564f7cae2b92e4538088ae6
[...]
Date:   Sat Oct 17 21:28:35 2009 -0500

    Merge branch 'A' into v1.0.0

but no "Merge branch 'C' into v1.0.0".

And so, I'm faced with git rebase -i posing some unanswerable questions
to our release manager.  She cannot easily remove B from the merge after
doint either merge A B C, or merge A, merge B, merge C.

Can anyone help?


Bill
