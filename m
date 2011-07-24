From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 0/5] fast-export: prepare for remote helpers awesomeness
Date: Sun, 24 Jul 2011 16:21:17 +0200
Message-ID: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jul 24 16:22:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkzZm-0006Dd-Ir
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 16:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab1GXOWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 10:22:20 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56531 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab1GXOWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 10:22:18 -0400
Received: by wyg8 with SMTP id 8so2291817wyg.19
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CUvF5Z0/dyeZi1P4p/R8m8MJ7EcqYUdegf7m7guzykw=;
        b=nZ5ZH6id3Qn9CeIRuc5jAFQFYrfhpCcrhfSdSoO+kJ2TTTOYIBjSr74gnI6EtOQzI0
         0uaFdKU+OFw+jPYsXDYNmU44PTyMpR/YE1aa/Y6dnjpOltHmNiVOpuM3+BKDNYSSWsXM
         RGkgywDWUzAAhjCWKMWaQVgNaG3q0e97F/x/o=
Received: by 10.227.19.206 with SMTP id c14mr2983046wbb.0.1311517337462;
        Sun, 24 Jul 2011 07:22:17 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id fc2sm3526819wbb.35.2011.07.24.07.22.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 07:22:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.385.g91185.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177756>

During a funathon with a lot of sheep baaah-ing in the background, we
discovered this ancient fast-export bug while working on finishing
git-remote-hg. So, here it goes.

Johannes Schindelin (4):
  fast-export: do not refer to non-existing marks
  setup_revisions: remember whether a ref was positive or not
  fast-export: do not export negative refs
  setup_revisions: remember whether a ref was positive or not

Sverre Rabbelier (1):
  t9350: point out that refs are not updated correctly

 builtin/fast-export.c  |   55 +++++++++++++++++++++++++++++++++++++++--------
 object.h               |    2 +-
 revision.c             |   12 ++++++----
 t/t9350-fast-export.sh |   11 +++++++++
 4 files changed, 64 insertions(+), 16 deletions(-)

-- 
1.7.6.385.g91185.dirty
