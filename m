From: Francis Moreau <francis.moro@gmail.com>
Subject: Question about "git log --cherry"
Date: Thu, 26 Sep 2013 18:35:57 +0200
Message-ID: <CAC9WiBjLqdqSKgLv_M6FPx3a2J-+ZKAQnk9OGn3h5SfqSpiT3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 26 18:36:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPEXr-0007v9-5E
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 18:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392Ab3IZQf7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 12:35:59 -0400
Received: from mail-ve0-f174.google.com ([209.85.128.174]:51583 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab3IZQf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 12:35:58 -0400
Received: by mail-ve0-f174.google.com with SMTP id jy13so1104708veb.33
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=B4gAsHpuUsnjX4P+1Zx9zwAUr+5DRLc0KvnFZ+fMqAA=;
        b=XkbgIK1QOC/i95gNm8QXwithH0QMGw7UO6sfPHU50j6r7ZWBmOyjL547EVKjfMizqD
         mgCMBH+RsiD4nV92qtI5wqfH8j/9h26bwAtWChm6IR1BRWih0GOQ1XWID+aRthmDcQzV
         5cMPx+DKYrz1vF0KqWbfdYQI7MXblr6LXcbGxJ1XmAl18x3mmiCR2xXDPyHwnNOglpc4
         QhfanxgZM8pZvFKHttV2iAPVATtX+f+qxeXYv4t66wZojYlyRbcQ45OeNO9Hj/FZ6Ykb
         hHL+QrluQflUKiUMmiW0YQlFf4xNlz9YtoN5wRMbSy9BO+NM9thc2KJ7tIxivGP6bO2D
         YYJg==
X-Received: by 10.58.67.9 with SMTP id j9mr1425609vet.3.1380213357806; Thu, 26
 Sep 2013 09:35:57 -0700 (PDT)
Received: by 10.58.8.169 with HTTP; Thu, 26 Sep 2013 09:35:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235421>

Hello,

I'm trying to use "git log --cherry ..." in order to display new, kept
and removed commits between two branches A and B.

So commits which are only in B are considered new and should be marked
with '+'. Commits which are in both branches are marked with '=' but
only commit in branch B are shown. Eventually commits which are in A
but not in B anymore should be marked with '-'.

So far I found this solution:

  $ git log --cherry-mark --right-only A...B
  $ git log --cherry-pick  --left-only   A...B

but I have to call twice git-log. This can be annoying since depending
on A and B, calling git-log can take time.

Is there another option that I'm missing which would do the job but
with only one call to git-log ?

Thanks
-- 
Francis
