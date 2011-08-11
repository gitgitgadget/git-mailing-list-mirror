From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3 0/2] Reduce parse-options.o dependencies
Date: Thu, 11 Aug 2011 15:15:36 +0600
Message-ID: <1313054138-30885-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	David Barr <davidbarr@google.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 11 11:15:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrRMY-0000Uz-TU
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 11:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777Ab1HKJP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 05:15:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64998 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753592Ab1HKJPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 05:15:25 -0400
Received: by bke11 with SMTP id 11so832950bke.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=mbj47hFdJV9ZNFkuth/y3d6+eU5oIHcBS2dTWievJK0=;
        b=XXQ90JmnYxKMXUS8uYxSkHK9gP5d2QlrQ7BD3wfhbmQhxZd4GIw7bNf9ZxY911s9oD
         38GrKI+pP8MyzXZRZGmqQKRTCfp7sa6CMDXJOKpFcHzJPtqaCG9IYQh7aotcJrhZqTTn
         /+F+OwwRdqBHd7aDkQ38fQtZjz8INVyDCirYs=
Received: by 10.204.133.28 with SMTP id d28mr2976701bkt.81.1313054124458;
        Thu, 11 Aug 2011 02:15:24 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id n9sm458521bkd.40.2011.08.11.02.15.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 02:15:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179094>

This is a reroll of [1]. The main purpose is to make parse-options.o more
self-contained so that it at least doesn't pull any extlibs. Immediate usage
is for stuff in contrib (svn-fe). Distant application is that some day we could
publish this small library separately.

Mostly no changes since [1], just commit message line wrapping, fixup for a
Makefile typo and rebase on top of master (new parse_opt_string_list moved to
parse-options-cb.c too).

[1] http://thread.gmane.org/gmane.comp.version-control.git/176318/focus=176574

Dmitry Ivankov (2):
  parse-options: export opterr, optbug
  Reduce parse-options.o dependencies

 Makefile           |    3 +-
 abspath.c          |   28 ++++++++++++
 parse-options-cb.c |  125 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 parse-options.c    |  125 +---------------------------------------------------
 parse-options.h    |    2 +
 setup.c            |   28 ------------
 6 files changed, 159 insertions(+), 152 deletions(-)
 create mode 100644 parse-options-cb.c

-- 
1.7.3.4
