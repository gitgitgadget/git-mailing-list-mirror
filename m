From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 0/3] Fix a ton of compiler warnings
Date: Sun,  4 May 2014 01:12:52 -0500
Message-ID: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 04 08:23:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgppu-0008FB-8G
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 08:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbaEDGXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 02:23:37 -0400
Received: from mail-oa0-f50.google.com ([209.85.219.50]:58649 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbaEDGXg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 02:23:36 -0400
Received: by mail-oa0-f50.google.com with SMTP id i7so1065815oag.9
        for <git@vger.kernel.org>; Sat, 03 May 2014 23:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=k3wMiEbmFautARdLDtUaFeM0szvDFET3xxnnNeK/GjA=;
        b=OPEdDgFScEM6Rug5LuI2v4IdH+hhP8+WBHChJ5p3nornYJYtGRWckYLoHQzrS+Fqxs
         sRkiMQSiogL8yQ+1gJ4EpOXf4EljbrFWUx8WUE5vBdiC0Ws1txYQdIKmdRrwePVY8gsB
         /bSK5qBZdKVrUrBJcebHKy9CmtGMCTO+EX+URt0tDfmQPheVugys2tt/yLqgo79xjjx6
         XLEALeit77tljSUTK0AyZmKhEz+qwrWR8dJPaU7NB6lTtd+IZVjbzHT24UzFPB+mUD/i
         +eI7Bz9fY/YFqi51AXoVLjNh6uxO0vH2D+693muDzhceSWbVU6iE4t3P2C4fDedROTqz
         46Tw==
X-Received: by 10.182.214.41 with SMTP id nx9mr24836197obc.15.1399184616177;
        Sat, 03 May 2014 23:23:36 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ml9sm19791688oeb.2.2014.05.03.23.23.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 May 2014 23:23:34 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.20.g204a630
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248075>

Hi,

I'm getting tons and tons of warnings with gcc 4.9.0. Here are the patches to
fix them all.


Felipe Contreras (3):
  Revert "make error()'s constant return value more visible"
  Revert "silence some -Wuninitialized false positives"
  Silence a bunch of format-zero-length warnings

 builtin/commit.c  |  2 +-
 cache.h           |  3 ---
 config.c          |  1 -
 git-compat-util.h | 11 -----------
 parse-options.c   | 18 +++++++++---------
 parse-options.h   |  4 ----
 usage.c           |  1 -
 wt-status.c       | 22 +++++++++++-----------
 8 files changed, 21 insertions(+), 41 deletions(-)

-- 
1.9.2+fc1.20.g204a630
