From: ebiederm@xmission.com (Eric W. Biederman)
Subject: git-format-patch-script bug?
Date: Sun, 07 Aug 2005 01:35:29 -0600
Message-ID: <m1d5oqxkqm.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Aug 07 09:36:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1fhL-0003Ni-U3
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 09:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVHGHfs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 03:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVHGHfs
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 03:35:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3219 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751201AbVHGHfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 03:35:48 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j777ZVV3017455
	for <git@vger.kernel.org>; Sun, 7 Aug 2005 01:35:31 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j777ZTP4017454;
	Sun, 7 Aug 2005 01:35:29 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: <git@vger.kernel.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


I haven't had a chance to investigate this much
yet but I have ran into a peculiar problem.

I was trying to help someone track down a bug that
occurred between linux-2.6.12 and linux-2.6.13-rc1.
Since it was very much an unknown where the problem
was introduced I decided to run git format-patch
so I could see what all of the differences were.
Then to be certain the patch series worked I started
applying them in order.  

I didn't get very far when I had a patch conflict.

Looking deeper git-diff-tree is always making the diffs
against the parent instead of against the next commit
in the series.  Which is largely sane.  However it does
not warn or fail when the parents and the next commit are different,
which seems nonintuitive.

Eric
