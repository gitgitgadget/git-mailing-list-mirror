From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 0/3] Get rebase to work with :/foomery committish
Date: Fri, 14 Jun 2013 18:47:49 +0530
Message-ID: <1371215872-9796-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 14 15:19:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnTux-0004oM-E9
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab3FNNTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 09:19:47 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:39132 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab3FNNTq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:19:46 -0400
Received: by mail-pd0-f169.google.com with SMTP id y10so572568pdj.14
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=aE1fvi5UXn1WQqrvrxCGgQ7fQCMmGT2tygKpV3xpL0A=;
        b=qfRnzbnx5auhOoVn3zhuM5JBm979pJE58o5mrxxBRKeyqX2ee7s/JP5RTTSu/Xs13R
         pVF3dEolsJCVqdmVbpnM339O45E8Y4ZDYKXd7FTtg6FlaicUpKyoFwz4RVl4jrAL0w2q
         Xh04pfjsT+7k6Bri6Q91N82xkfb7XJrHfWGEpWwwgXt7x80DRRwluHHbiTofSvl4trLp
         BjqM56hqDLA/w7aSPsQu4SdZQbH+3uZ/WZgRTGCfSugxXXUolBMo8yfckteElWmcsWBo
         pW/tRXkM/W4Jj4YxR8N+gsMOl5J+DC5wsu02AwmmidIkmPhWMiiLFZhW5tQJzZRGZDOz
         AU6w==
X-Received: by 10.66.121.108 with SMTP id lj12mr2569147pab.52.1371215986357;
        Fri, 14 Jun 2013 06:19:46 -0700 (PDT)
Received: from localhost.localdomain ([122.164.213.38])
        by mx.google.com with ESMTPSA id i16sm2422081pag.18.2013.06.14.06.19.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Jun 2013 06:19:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.381.g12ca056.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227826>

Since the early preview, I realized that peel_committish() is required
in exactly two places: the <onto> and <upstream> parsers facing
end-user data.  Updated appropriately.

Thanks.

Ramkumar Ramachandra (3):
  t/rebase: add failing tests for a peculiar revision
  sh-setup: add new peel_committish() helper
  rebase: use peel_committish() where appropriate

 git-rebase.sh                 |  4 ++--
 git-sh-setup.sh               | 12 ++++++++++++
 t/t3400-rebase.sh             | 11 +++++++++++
 t/t3404-rebase-interactive.sh | 11 +++++++++++
 4 files changed, 36 insertions(+), 2 deletions(-)

-- 
1.8.3.1.381.g12ca056.dirty
