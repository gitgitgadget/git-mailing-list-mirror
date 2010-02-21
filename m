From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 0/7] http: minor improvements
Date: Sun, 21 Feb 2010 11:08:21 +0800
Message-ID: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Cc: "Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:37:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2BZ-0004id-Ty
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757036Ab0BUDIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:08:41 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:48037 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756308Ab0BUDIk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:08:40 -0500
Received: by qyk9 with SMTP id 9so352982qyk.21
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 19:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=zWBBbWLIGvPcmrZIVX52kUhAF7lFGDVfDWDgOf7yChg=;
        b=RyLQUT+TqaNpmxUHzbpC7/wMjPG/g0F7yjV2qDFQiaVnjEFmSYU+1b+ZJf497k6GLd
         r9LGZx0Peal93H0MG6RGpe19q4HFFX/FGV/mwW9kFrRbwfv41CAPYRXY4z88w1W+qhmJ
         cv5mVAU+NnbX/BYWlEVdKsh0aoBhQwLS+K8Wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=EWQc8M7Am4ftX+f06kHBTlad7gh/EZkAJR1Q+LPYB4Bo2RNrgJBT7Tl0+CYK1p/cN6
         rCSFf3H/HiDVp9nKN/hM0A1H5cZ2IehkULstXhlfC8GpABvwJi5W7WWgrMn8ur/lclIN
         MtNPdM1luc9g7dL7DKHaRP/dOnY4zj7+nhv6Y=
Received: by 10.224.117.204 with SMTP id s12mr4747159qaq.63.1266721720172;
        Sat, 20 Feb 2010 19:08:40 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 22sm1412717qyk.14.2010.02.20.19.08.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 19:08:39 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140583>

This patch series was generated on top of 'next'. It contains some
general changes to http users.

Some highlights:
  - add non-ff test cases to "dumb" http push test
  - separate init and cleanup of http from http-walker

[PATCH 1/7] t5541-http-push: check that ref is unchanged for non-ff test
[PATCH 2/7] t554[01]-http-push: refactor, add non-ff tests
[PATCH 3/7] http-push: remove useless condition
[PATCH 4/7] http-walker: cleanup more thoroughly
[PATCH 5/7] http: init and cleanup separately from http-walker
[PATCH 6/7] remote-curl: use http_fetch_ref() instead of walker wrapper
[PATCH 7/7] remote-curl: init walker only when needed

 http-fetch.c         |    4 +++-
 http-push.c          |    2 +-
 http-walker.c        |   21 ++++++++++++++++++---
 remote-curl.c        |   21 +++++++++------------
 t/lib-httpd.sh       |   29 +++++++++++++++++++++++++++++
 t/t5540-http-push.sh |    3 +++
 t/t5541-http-push.sh |   22 ++--------------------
 walker.h             |    2 +-
 8 files changed, 66 insertions(+), 38 deletions(-)

--
Cheers,
Ray Chuan
