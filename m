From: David Brown <git@davidb.org>
Subject: Failed binary detection.
Date: Fri, 21 Dec 2007 11:50:19 -0800
Message-ID: <20071221195019.GA20668@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 20:50:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5ntM-0006bL-TR
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 20:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbXLUTuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 14:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbXLUTuV
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 14:50:21 -0500
Received: from mail.davidb.org ([66.93.32.219]:34717 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753423AbXLUTuU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 14:50:20 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.68 #1 (Debian))
	id 1J5nsx-0005dG-IX
	for <git@vger.kernel.org>; Fri, 21 Dec 2007 11:50:19 -0800
Mail-Followup-To: Git <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69088>

A coworker has a branch with some large binary files (video test streams).
Git doesn't seem to be detecting this file is binary, and is causing things
that try to generate diffs to fail.

Specifically, he is unable to rebase his branch, getting an error:

.dotest/patch:3241:LD   := ld
fatal: corrupt patch at line 84682
Patch failed at 0001.

Line 84682 is in the middle of what appear to be the binary contents of the
large media file, with pluses inserted after newline.

Any advice on where to look or possibly how to fix this?

I was able to work around the problem by cherry picking the change instead
of using rebase.  git-format-patch generates a patch that is corrupt in the
same way, which fails with 'git-am'.

Thanks,
Dave
