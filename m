From: Brent Goodrick <bgoodr@gmail.com>
Subject: How do I force git to forget about merging a binary file that is to 
	stay deleted on the target branch?
Date: Fri, 27 Mar 2009 22:26:28 -0700
Message-ID: <e38bce640903272226l3facf47br9b1849bf708c3881@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 06:28:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnR5N-0005rY-62
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 06:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbZC1F0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 01:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbZC1F0b
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 01:26:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.238]:3588 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbZC1F0a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 01:26:30 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1595049rvb.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 22:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=JuVawe+ogQYjICBwqLd0b8tyl78ED+gRe3W3V2GPhXw=;
        b=aN2WyvYBT0NgsoewEgaMJei3I3Q40/u0Y4brR01qE+/QYvkA/wTOkpX9guqxHPd2+m
         Z7W0NSQ0c09tIdtsRG27Vbtb5lO8hnvBQUrQaxQTjM0w3eFFbxMlPCbcM5HApBjT5Bmd
         X2YfSV71AwBR1wEqqc8hRcKRzgjhu+2QM9JDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=JnbVAB9RnG1c8/kQSuXm5Y2afPKgfKqN3zl4krcvY/9JWTFebIhpmlCyQ1Jc8EzIpA
         dQs8fRbVxhPy1HwhH5UO0bX9lLEcHStJ5TS0ToWV0UaTxnxN6+EzWKmqUNS7N5M7YNLi
         QGUv6zQA6ONwS1zI0WRVvvdZC96u5dxfWWdTM=
Received: by 10.141.132.1 with SMTP id j1mr1473836rvn.124.1238217988833; Fri, 
	27 Mar 2009 22:26:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114935>

Hi,

How do I commit a merge but force git to forget about merging one file
that I don't want on the target branch, when it is binary, and when it
was changed on the source branch, but was deleted on the target branch
(and should stay deleted on the target branch)?

The details: I am merging a "work" branch into a "home" branch.  There
is one file called "TimeSheets/Timesheet Exempt.XLS" that is binary.
I don't want that file on the "home" branch, but do want it on the
"work" branch.  I had made an editing change to that file on the
"work" branch, along with a bunch of other changes I do want to merge
into the "home" branch. But no matter what I do, I can't force git to
forget about that "TimeSheets/Timesheet Exempt.XLS" file.

I've tried various flavors of git-checkout and git-reset to no
avail. This is what I see at the very last before I gave up:

Here is what I'm left with:

,----
| $ : gitw status
| TimeSheets/Timesheet Exempt.XLS: needs merge
| # On branch home
| # Changes to be committed:
| #   (use "git reset HEAD <file>..." to unstage)
| #
| <snipped out other files I do want to commit>
| #
| # Changed but not updated:
| #   (use "git add <file>..." to update what will be committed)
| #   (use "git checkout -- <file>..." to discard changes in working directory)
| #
| #	unmerged:   TimeSheets/Timesheet Exempt.XLS
| #
| $ : gitw commit -m "merge from work"
| TimeSheets/Timesheet Exempt.XLS: needs merge
| TimeSheets/Timesheet Exempt.XLS: unmerged
(49a49bd9de154daa8ca6cff3cfb550d0dd1b4519)
| TimeSheets/Timesheet Exempt.XLS: unmerged
(8de60b8b6827ef1f80921f6d35b574a56683bfdd)
| error: Error building trees
`----

Any help anyone can provide is greatly appreciated.

Thanks,
Brent
