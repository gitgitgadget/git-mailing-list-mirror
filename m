From: Jon Seymour <jon.seymour@gmail.com>
Subject: git-svn: a interesting difference in performance as compared to
 Tortoise SVN
Date: Wed, 18 Apr 2012 15:56:09 +1000
Message-ID: <CAH3AnrrY2F9rfTTFpTuBaRQmT4jHsS=WPTNTcWZGA8Oqz_UtQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 07:56:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKNsF-0004As-Hi
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 07:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125Ab2DRF4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 01:56:11 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:42637 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab2DRF4K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 01:56:10 -0400
Received: by wibhj6 with SMTP id hj6so300323wib.1
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 22:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7ZbWQ0aD52VLj/RJs9edvU1NrtB6kfoJb07QOxbqnZw=;
        b=L4MGsaf7l/p4DBvi66+gShGWHhxf33KOWNmAijUiG27eNU0+y1Y9vT1q6Sq4stVP7M
         wo6zB3Rk6ehIHvZyw9TQfNhYnaTOiIdkRnQuyMTexoJ8KuiFAwgr4WCapt63pUMi3Cna
         ZxI7M9cZ31Q42axqNEluHXhGcWDZJkN5Mht26kcnDrFRLulgH/B1r20sljJhB1+POgPe
         NJga2QDJmRZIagVWfXZiPY8q4PGMuwEXu2EvSfQbpQOy2rneYd3YsamyG5JlNVJTGBgz
         1tCSnsv4IpvwVMSAi4FdGUr2iVyrmuRxenn17lVPnUwOkhrA+/Ct5jYqZ5/T6wu8FNpR
         VnTQ==
Received: by 10.216.134.27 with SMTP id r27mr582037wei.107.1334728569228; Tue,
 17 Apr 2012 22:56:09 -0700 (PDT)
Received: by 10.180.82.35 with HTTP; Tue, 17 Apr 2012 22:56:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195840>

I thought others might be interested in this slightly
counter-intuitive performance of git-svn as opposed to Tortoise SVN.

The SVN repo is exposed via HTTP. The current tree is about 8500 files
and consumes 300MB of disk, checked out. The git repo is 200MB. There
are around 231 commits in the history.

The initially slightly counter-intuitive aspect is that given the
current state of the repo, git-svn is 4 times faster when it pulls the
entire history than TortoiseSVN is when it checks out just the current
head. It seems that the extra network cost of the extra git-svn
retrieval is dwarfed by the local processing costs of the TortoiseSVN
client.

jon.
