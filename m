From: Strainu <strainu10@gmail.com>
Subject: BUG: [Cosmetic] Commiting a gerrit ChangeId before the commit hook
 was installed
Date: Fri, 17 Jan 2014 22:23:18 +0200
Message-ID: <CAC9meRKiR+60YaGiuCu4twEt6dyWksEjHSH8YPTEvmD=LoB=aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 21:24:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4FxW-0001cZ-JL
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 21:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbaAQUYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 15:24:01 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:64771 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbaAQUYA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 15:24:00 -0500
Received: by mail-pd0-f177.google.com with SMTP id x10so3123969pdj.36
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 12:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=6Bk+tU81LRk0r7vkQlnxG+26vthsVza7wXck2i7vlXo=;
        b=KNIATaJBnK3gILmmpf7ktx+GmC4k/VIxT6TVBYYoSCvf1RFqiWVTfwsUjyM5Q2sXsJ
         3K7uuc9CF1RzZzBupibbX5JjtP6Xmirak3mXdbyNGGbaeTSGpxwWRUuAeOOHRL2zxrqA
         DB9n+1+SLhr4TJHo1/W5D3B32NlwIjl7DC1DdNwPaDytEJozixOwyNU9nfZl2QK25Mv/
         U2hL0xST0iiczXOcW5yytlhq4BCbfQbINMBwndjboD/e2VNv9cNR1UatRjLyluTjB5HJ
         K98X4ma8d7NlICV547tRIaXaAt/ZWMfCL5BSrDwwtkYOaDdfhCZX640cb1kAhwRmguXL
         CL6w==
X-Received: by 10.68.240.36 with SMTP id vx4mr4371362pbc.140.1389990239289;
 Fri, 17 Jan 2014 12:23:59 -0800 (PST)
Received: by 10.68.175.225 with HTTP; Fri, 17 Jan 2014 12:23:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240628>

I was trying to send a new version of a patch to a gerrit server from
a new computer, so I made a change with a ChangeId in the description
and tried to review it:

strainu@emily:~/core> git branch archivebot
strainu@emily:~/core> git checkout archivebot
M       pywikibot/page.py
Switched to branch 'archivebot'
strainu@emily:~/core> git diff
strainu@emily:~/core> git add .
strainu@emily:~/core> git commit
[archivebot 282ad24] Update getFileVersionHistoryTable.
 1 file changed, 3 insertions(+), 4 deletions(-)
strainu@emily:~/core> git review -f
Creating a git remote called "gerrit" that maps to:
        ssh://strainu@gerrit.wikimedia.org:29418/pywikibot/core.git
Your change was committed before the commit hook was installed.
Amending the commit to add a gerrit change id.


At this point I ended the transaction, as I was confused by the last
message: I was afraid the ChangeId would have changed, causing the
patch to be attached to another review.

I think git should not show this message if the change description
already has a change id, or at least add another message that
clarifies the fact that the change id has not changed.

Thanks,
   Strainu
