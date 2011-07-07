From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 0/4] prepare for histogram diff
Date: Thu,  7 Jul 2011 12:23:54 +0800
Message-ID: <1310012638-3668-1-git-send-email-rctay89@gmail.com>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 07 06:24:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qeg8W-0008ID-Gu
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 06:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285Ab1GGEYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 00:24:13 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60634 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab1GGEYM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 00:24:12 -0400
Received: by iwn6 with SMTP id 6so513718iwn.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 21:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=2zOFydmjtKYo3nptwhtQX2FJuvdgZfYd7Psa0C7EWJY=;
        b=itaN8z4rEo+BpSiWtIXdHYkqHGnA19u+bN+m6jAo4BvmD8x3DCElZboXU+N3iSBz/q
         Z/8CSaWfGgRHtqpft5CrKhQiPGeWyI8hWjbXzVUu1Phzt5k2WT8DP37cIvjSNtUyEFoB
         yhK8BZi1+zKBIzlYgTtPU1J/OQOP7x76yiMYg=
Received: by 10.42.167.200 with SMTP id t8mr430483icy.270.1310012651521;
        Wed, 06 Jul 2011 21:24:11 -0700 (PDT)
Received: from localhost (cm119.beta238.maxonline.com.sg [116.86.238.119])
        by mx.google.com with ESMTPS id s2sm5249956ibe.18.2011.07.06.21.24.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 21:24:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176743>

Tay Ray Chuan (4):
  xdiff/xprepare: use memset()
  xdiff/xprepare: refactor abort cleanups
  xdiff/xpatience: factor out fall-back-diff function
  t4033-diff-patience: factor out tests

 t/lib-diff-alternative.sh |  165 +++++++++++++++++++++++++++++++++++++++++++++
 t/t4033-diff-patience.sh  |  162 +-------------------------------------------
 xdiff/xpatience.c         |   27 +-------
 xdiff/xprepare.c          |  101 ++++++++++------------------
 xdiff/xutils.c            |   31 +++++++++
 xdiff/xutils.h            |    2 +
 6 files changed, 238 insertions(+), 250 deletions(-)
 create mode 100644 t/lib-diff-alternative.sh

-- 
1.7.3.4.676.gf08cd.dirty
