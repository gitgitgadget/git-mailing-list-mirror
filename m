From: "David D. Kilzer" <ddkilzer@kilzer.net>
Subject: [PATCH 0/3 v3] Implement git-svn info
Date: Wed, 21 Nov 2007 11:57:16 -0800
Message-ID: <1195675039-26746-1-git-send-email-ddkilzer@kilzer.net>
Cc: git@vger.kernel.org, "David D. Kilzer" <ddkilzer@kilzer.net>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:58:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuviP-00055F-Ex
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 20:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309AbXKUT5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 14:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756284AbXKUT5W
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 14:57:22 -0500
Received: from mail-out4.apple.com ([17.254.13.23]:52152 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbXKUT5U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 14:57:20 -0500
Received: from relay11.apple.com (relay11.apple.com [17.128.113.48])
	by mail-out4.apple.com (Postfix) with ESMTP id 796A019D7A21;
	Wed, 21 Nov 2007 11:57:20 -0800 (PST)
Received: from relay11.apple.com (unknown [127.0.0.1])
	by relay11.apple.com (Symantec Mail Security) with ESMTP id 613D028087;
	Wed, 21 Nov 2007 11:57:20 -0800 (PST)
X-AuditID: 11807130-a6baabb000006ed1-f9-47448da0d9c7
Received: from localhost.localdomain (unknown [17.151.86.253])
	by relay11.apple.com (Apple SCV relay) with ESMTP id 3863E2804E;
	Wed, 21 Nov 2007 11:57:20 -0800 (PST)
X-Mailer: git-send-email 1.5.3.4
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65697>

Changes since the last patch series I posted (last night):

- Patch 1/3: No changes.
- Patch 2/3: Only changes to test code.
  - Renamed t/t9117-git-svn-info.sh to t/t9119-git-svn-info.sh.
  - Removed static expected.* files and reinstated dynamic generation.
  - Replaced "touch -c -r" with ptouch (portable/perl touch) function.
    (Should this go in t/lib-git-svn.sh?)
  - Use sed(1) inline to work around minor "svn info" vs. "git svn info"
    difference.
  - Minor test name and expected.*/actual.* file name changes.
  - Updated comments.
- Patch 3/3: Added 17 more tests (mirroring the existing 18 tests from
  Patch 2/3).

"David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> "David D. Kilzer" <ddkilzer@kilzer.net> wrote:
> > Eric Wong <normalperson@yhbt.net> wrote:
> > > Can we expect the output of "svn info" to not change between
> > > versions?  I know "svn status" has changed between versions of
> > > svn.  I'd prefer if we keep the expected.* files hard-coded
> > > in a test directory and compare those instead.  Maybe use sed
> > > to substitute placeholders for timestamps..
> > Done.
> Grrr.  I remember the reason I didn't do this in the first place.
> In Patch 2/3, there are now hard-coded directory paths and my
> username in the static expected-* files.

Actually, using "svn info" to dynamically generate the results means
that the tests will break when "svn info" does change, which is a good
thing.  In other words, I think we want to know when that happens so
that we can make a decision about whether to support the change or not.

Dave
