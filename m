From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3] status: always show tracking branch even no change
Date: Thu,  8 Aug 2013 22:49:20 +0800
Message-ID: <cover.1375972599.git.worldhello.net@gmail.com>
References: <1481cfff6c22568f2a73613668cee0b99ceb4629.1375940354.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 08 16:51:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7RZ5-0000po-4u
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 16:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757878Ab3HHOvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 10:51:43 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58365 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757850Ab3HHOvm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 10:51:42 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so3547132pab.40
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 07:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s6N5C2unTQKhN/0iTZ+aVuHh/KQ+1F3v17s1vMjDml8=;
        b=DRPR1bc0gXTFiZZWTUhAY3jCJ/LKo6Xs1gEeodXnTXvF+Tj8ukpSEOH6Uzc4YjWgtq
         VCJpdwl0h4mHyGRvlKq5+oH9L7Ruur722YQhvwfF2Af7Zig5IN2gT+RyWceZXnVTWcZP
         Hve3Oykqjqwad/M7F2yoGbJ/EjwLA3BX8jhWPVzR99NmYjy3T1m8/0vLbM6WmcTtMCzm
         5ee2vA0W2d2twTvftAzmA+EsoypV7n0mRL06bQ93avIzGxcqplcodSMVXS1vjInsvDN2
         Ps/2MYMCOmq4iiYH7jMBz8nwxichO+2hgNrB9oSQ1vy6ie2t6gE62bvRu5466GlXokXB
         QBCA==
X-Received: by 10.66.169.172 with SMTP id af12mr6684927pac.23.1375973502126;
        Thu, 08 Aug 2013 07:51:42 -0700 (PDT)
Received: from localhost.localdomain ([114.246.125.252])
        by mx.google.com with ESMTPSA id qf7sm16969647pac.14.2013.08.08.07.51.38
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 07:51:41 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.430.g417e2f3
In-Reply-To: <1481cfff6c22568f2a73613668cee0b99ceb4629.1375940354.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231889>

Changes since v2:

 * The return value of function stat_tracking_info() is changed.
   When the current branch and its remote tracking branch point
   to the same commit, will return 1, instead of 0. Because we
   want to report the tracking info for such case.

 * Remove duplicated codes in builtin/branch.c, and make it simpler.

Jiang Xin (1):
  status: always show tracking branch even no change

 builtin/branch.c         | 18 +++++-----------
 remote.c                 | 18 +++++++++++-----
 t/t6040-tracking-info.sh | 54 ++++++++++++++++++++++++++++++++++++++++++++----
 wt-status.c              |  5 +++++
 4 files changed, 73 insertions(+), 22 deletions(-)

-- 
1.8.4.rc1.430.g417e2f3
