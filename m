From: Johan Herland <johan@herland.net>
Subject: [RFC/PATCHv3 0/3] Change git-svn's default --prefix in Git v2.0
Date: Fri, 11 Oct 2013 14:57:04 +0200
Message-ID: <1381496227-28700-1-git-send-email-johan@herland.net>
References: <1381015833-696-1-git-send-email-johan@herland.net>
Cc: tfnico@gmail.com, Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 11 14:57:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUcHe-0002i3-6Q
	for gcvg-git-2@plane.gmane.org; Fri, 11 Oct 2013 14:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623Ab3JKM5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 08:57:30 -0400
Received: from mail-ea0-f182.google.com ([209.85.215.182]:48415 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042Ab3JKM53 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 08:57:29 -0400
Received: by mail-ea0-f182.google.com with SMTP id o10so1883667eaj.27
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 05:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SZwphQXjxPGO/YsQ8q2GGshc6feJkkaYDl7yGb3sVgY=;
        b=bZdlzZnHFIqq10dfzaLwnjtx3lSFgMjxZq9qHtT1XH59+dwn1ZtBZ3ShlmX3BjNutT
         Rvi5TQdRiKHVhdbwKbRSKJYMVb3grRz480XbthEdB65SuwKn6sKl0PDtmmI/QNBYTPuh
         t2LpYZ8QWjsk4lmEpuo/o8R43ewl2Z4uKq2F/Ac2wEIYmRy2/aNkZOKXDcwTbxxK3MYp
         48uTmIBUXDdiw52JqpJeWfsn5haBVl4tTwiuR23udsJRFsuu7CM5vuQAlASxy5rZxcqQ
         WYvuuysvoRXFQW7Qvr9NYEYDsgJHk1lXMoAdhJSntygJApDZpkb1F2pZjGb168/LZLGu
         TjOA==
X-Received: by 10.14.172.133 with SMTP id t5mr28649985eel.35.1381496248312;
        Fri, 11 Oct 2013 05:57:28 -0700 (PDT)
Received: from beta.cisco.com (173-38-208-169.cisco.com. [173.38.208.169])
        by mx.google.com with ESMTPSA id k7sm114514621eeg.13.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 05:57:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.653.g2df02b3
In-Reply-To: <1381015833-696-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235899>

Hi,

Another iteration, identical to v2, except for the fixes suggested by
Eric Sunshine.

...Johan


Johan Herland (3):
  Documentation/git-svn: Promote the use of --prefix in docs + examples
  git-svn: Warn about changing default for --prefix in Git v2.0
  Git 2.0: git svn: Set default --prefix='origin/' if --prefix is not given

 Documentation/git-svn.txt                        | 27 ++++++----
 git-svn.perl                                     |  2 +-
 t/t9107-git-svn-migrate.sh                       | 54 +++++++++----------
 t/t9114-git-svn-dcommit-merge.sh                 |  4 +-
 t/t9116-git-svn-log.sh                           | 46 ++++++++--------
 t/t9117-git-svn-init-clone.sh                    | 67 ++++++++++++++++++++++++
 t/t9118-git-svn-funky-branch-names.sh            | 20 +++----
 t/t9120-git-svn-clone-with-percent-escapes.sh    | 14 ++---
 t/t9125-git-svn-multi-glob-branch-names.sh       |  6 +--
 t/t9128-git-svn-cmd-branch.sh                    | 18 +++----
 t/t9135-git-svn-moved-branch-empty-file.sh       |  2 +-
 t/t9141-git-svn-multiple-branches.sh             | 28 +++++-----
 t/t9145-git-svn-master-branch.sh                 |  2 +-
 t/t9155-git-svn-fetch-deleted-tag.sh             |  4 +-
 t/t9156-git-svn-fetch-deleted-tag-2.sh           |  6 +--
 t/t9161-git-svn-mergeinfo-push.sh                | 22 ++++----
 t/t9163-git-svn-reset-clears-caches.sh           |  4 +-
 t/t9165-git-svn-fetch-merge-branch-of-branch.sh  |  2 +-
 t/t9166-git-svn-fetch-merge-branch-of-branch2.sh |  2 +-
 t/t9167-git-svn-cmd-branch-subproject.sh         |  2 +-
 20 files changed, 203 insertions(+), 129 deletions(-)

-- 
1.8.4.653.g2df02b3
