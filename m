From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH v1 0/2] contrib/subtree: make it respect spaces in a repository path
Date: Sat,  5 Sep 2015 01:24:09 +0300
Message-ID: <cover.1441404851.git.Alex.Crezoff@gmail.com>
Cc: Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 00:24:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXzPY-00085K-9l
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 00:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760610AbbIDWYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 18:24:35 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33100 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760190AbbIDWYe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 18:24:34 -0400
Received: by lbcjc2 with SMTP id jc2so18333158lbc.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 15:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rebuuRKSIepKwYzJjkRVP1UqwT8hcgEdL106erAY0T8=;
        b=d5862eHiOCatOywR9X+wRSpcOprqsPhl63923hCgsKZcBgY/uody4eg099PcyfqMUa
         hbOSEwgz3nfecv7TwW5QqWKpPeEQtWIP91QMdRabBurv7EbovAMXfZjYTSlrVoakzWBs
         XWRfe1mNVVH3xekBu0MrYXPm2LXnqGZDg+nPraboHw20Y+1bxDBASyRa+JgR0IMuz5R0
         RS26UF8XNmnUWtLQA6zZDAEcMvzu/E1bfER8N6lwmLcW4hypte1sEzmAoyPzAd4qs2XS
         a9Orz8B2ywWbcKopsFkR52pUAeYwnDDzW4iApGsUy+MYNb68APDen1W528436LbhKw8+
         TsdQ==
X-Received: by 10.152.6.231 with SMTP id e7mr5784898laa.78.1441405472946;
        Fri, 04 Sep 2015 15:24:32 -0700 (PDT)
Received: from localhost ([213.108.22.197])
        by smtp.gmail.com with ESMTPSA id da6sm477782lad.29.2015.09.04.15.24.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2015 15:24:31 -0700 (PDT)
X-Google-Original-From: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-Mailer: git-send-email 2.4.1-21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277343>

Some repositories may have spaces in their paths. Currently `git-subtree`
raises an error in such cases.
Also, `git-subtree` currently does not have tests for its 'push' command.
Following patches are to fix these statements.

Alexey Shumkin (2):
  t7900-subtree: test the "space in a subdirectory name" case
  contrib/subtree: respect spaces in a repository path

 contrib/subtree/git-subtree.sh     |   4 +-
 contrib/subtree/t/t7900-subtree.sh | 194 +++++++++++++++++++++++--------------
 2 files changed, 124 insertions(+), 74 deletions(-)

-- 
2.4.1-21
