From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 0/6] Support triangular workflows
Date: Thu, 28 Mar 2013 18:56:36 +0530
Message-ID: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 28 14:25:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULCq4-0002Td-Pf
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 14:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025Ab3C1NZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 09:25:29 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:37910 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755711Ab3C1NZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 09:25:28 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so1518456pad.2
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=DwtgTi/O8zBt78bNvvza5WhM1uwo3txmtA2EGYy50uE=;
        b=OylA7IrgyxrkJofGQy8srjKlOx2F20GWj0DgTGuPy79flq6oDG/x84DzxF/2VbHhRG
         GzhYNhqDcP7AWr56GAlkQmC9tvcJQcGFtcP8jhYPh01I2fEu6C7jDS9zSt4xAvDVbizn
         jMvD9OK/o5xJzeOJw6NyIYE2SfVXtWjFtHZNwQgfXJetYw0ClScDBQ6d1KikalOyGAyJ
         7h52oHkIDq3yOL9OCkbcNsPKhVoCWo41Bh0zj2yhUiyOIjMtqaiv7ubCGl+x6IvWxzQx
         S1pBb/Ij5ALFC2uvIUXM5R9u8j70WZ3zPw0i2dhjUHyP59Mh7Y3N3NVZz3CCe+db+/e2
         0f3w==
X-Received: by 10.68.253.68 with SMTP id zy4mr16733655pbc.38.1364477127985;
        Thu, 28 Mar 2013 06:25:27 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id tm1sm25586603pbc.11.2013.03.28.06.25.25
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Mar 2013 06:25:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.g3797f84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219387>

Hi,

The changes in this round are:

1. Peff submitted a patch to squash into [3/6].  Since his patch
   essentially reverts mine, I've blamed him for the change.

2. Peff suggested a code movement in [5/6] to make things flow more
   naturally.

3. Jonathan suggested a better test description in [2/6].

4. Junio suggested a minor documentation update in [6/6].

My build of git has had this feature for two weeks now (since the
first iteration), and I'm very happy with it.

Jeff King (1):
  t5516 (fetch-push): drop implicit arguments from helper functions

Ramkumar Ramachandra (5):
  remote.c: simplify a bit of code using git_config_string()
  t5516 (fetch-push): update test description
  remote.c: introduce a way to have different remotes for fetch/push
  remote.c: introduce remote.pushdefault
  remote.c: introduce branch.<name>.pushremote

 Documentation/config.txt |  24 +++-
 builtin/push.c           |   2 +-
 remote.c                 |  41 ++++--
 remote.h                 |   1 +
 t/t5516-fetch-push.sh    | 316 +++++++++++++++++++++++++++--------------------
 5 files changed, 238 insertions(+), 146 deletions(-)

-- 
1.8.2.141.g3797f84
