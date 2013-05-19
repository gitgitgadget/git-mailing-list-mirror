From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v8 0/3] Begin replacing OpenSSL with CommonCrypto
Date: Sun, 19 May 2013 06:23:33 -0400
Message-ID: <1368959016-23146-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	David Aguilar <davvid@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 19 12:24:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue0my-0004mw-89
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 12:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab3ESKYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 06:24:11 -0400
Received: from mail-ia0-f169.google.com ([209.85.210.169]:62816 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab3ESKYK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 06:24:10 -0400
Received: by mail-ia0-f169.google.com with SMTP id k38so6700352iah.0
        for <git@vger.kernel.org>; Sun, 19 May 2013 03:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=04oCIjYyYyV0BA7zyC4TZSWy0h+AYDnSLVWDU2uzLmw=;
        b=WPnYf23BKSKPMu8WUNL5zOTnGXomqqdun1FRbp8WS5C5o+xri4UOuu2ifanIqu7SCY
         LCLLUMQGQ10FUMzUZsPafk++kLZoQEGePgp5csVgEFkf68qw0Tt2EQEiszqS/WoL3ANr
         XHxpCXSIkYYPyO7KDamwx0Pe3bf9rkddJVD6azJjiABEcXi48LNhJpaneYSLtb9vyzSm
         Zc8XqqUgr0EKY8+NCYy6VVap98vjcUfIWk33cv2uiP9hieoa0EPYY2Cn+xKInW/NJAq0
         CXtePWpqrVhmBaEz0BHif5d/4vicrkzTuYuJlVwTKrGQJWYAbSEQpylAqFmh24qfmVqs
         CRFA==
X-Received: by 10.50.213.41 with SMTP id np9mr2674105igc.79.1368959050215;
        Sun, 19 May 2013 03:24:10 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id qn10sm6338918igc.6.2013.05.19.03.24.08
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 19 May 2013 03:24:09 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224833>

This is a re-roll of David Aguilar's patch series [1] which eliminates some
of the OpenSSL deprecation warnings on Mac OS X.

Changes since v7:
- Avoid double-negation (#ifndef NO_APPLE_COMMON_CRYPTO)
- Don't break imap-send.c for platforms other than Apple

[1]: http://thread.gmane.org/gmane.comp.version-control.git/224744

David Aguilar (3):
  Makefile: add support for Apple CommonCrypto facility
  cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
  imap-send: eliminate HMAC deprecation warnings on Mac OS X

 Makefile    | 14 ++++++++++++++
 imap-send.c | 10 ++++++++++
 2 files changed, 24 insertions(+)

-- 
1.8.2.3
