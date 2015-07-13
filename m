From: Greg Logan <gregorydlogan@gmail.com>
Subject: Reproducable fatal error while attempting to merge
Date: Mon, 13 Jul 2015 14:34:59 -0600
Message-ID: <CAGQUBiSEyJCWmqScANh8nNN6Rinp3sQ7syYe-Rm7gJJy7iTZaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 13 22:35:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEkRR-0007DF-7h
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 22:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752227AbbGMUfC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 16:35:02 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:36349 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbGMUfB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 16:35:01 -0400
Received: by lagw2 with SMTP id w2so21396794lag.3
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 13:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=24pMVR6CeL3x0ii8ADCqXqm+cTc+Yx5HiXHS/gAqGa8=;
        b=Zho9YFSG8/aVOn8/CovMshClGAtUKIck+5jPuN2pvCHl+7zkY1Xu2vQX2Os6QY+N3H
         eB7ujlRwUK+EKhI/bReTXmxUGSBQoidabli8yul4imgfYSMP65e6zR6PWSk6Dn09+iU3
         69g3Ea64A0jMT58KZQpmVBBC1aEL/kh3OK7Ox/ZOUgA4UKRElRKccXV0UMSMDomAzl5U
         0pIjSQtd+V8NgvJAbnGCl+RcW/G+Objp1CEHKGA6ZHqjUUL7smiYULtavrdldM3YjXIA
         LjFirxrqSjVzwfbv3A9gk8quzndP0P3MMdzPpd+SF09Xk+m3IlcE0ZVBkbj+Xut5jyo9
         tdCQ==
X-Received: by 10.112.29.228 with SMTP id n4mr34167768lbh.89.1436819699573;
 Mon, 13 Jul 2015 13:34:59 -0700 (PDT)
Received: by 10.25.24.211 with HTTP; Mon, 13 Jul 2015 13:34:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273924>

Hi folks,

I'm encountering an error which kicks out an error that looks like
this, every time:

git merge upstream/r/1.6.x
BUG: There are unmerged index entries:
BUG: 2 modules/matterhorn-series-service-remote/pom.xml
BUG: 3 modules/matterhorn-series-service-remote/pom.xml
fatal: Bug in merge-recursive.c

I'm attempting to merge the upstream 1.6.x branch from
https://bitbucket.org/opencast-community/matterhorn/ into our master
(which branched off from the upstream 1.5.x quite a while ago).  There
are common patches which have been applied to both branches, but in
those cases they have *not* been cherry picked.

Both of the repos are rather large, and one of them is actually
private!  I'm not sure how to proceed here in terms of attempting to
resolve this issue.  I've tried building Git from source, which did
not resolve the issue.  Adding '-X rename-threshold=95%' to the
commandline allows the merge to proceed as expected, although I
haven't actually finished it so I can't be sure that there aren't
issues that have arisen due to the changed threshold - there are a
number of conflicts.  I have the merge log with GIT_MERGE_VERBOSITY=5
posted at http://pastebin.com/WxzrT5sb.  Help?

Thanks,
G
