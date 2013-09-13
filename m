From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 0/3] fixes for relative_path
Date: Fri, 13 Sep 2013 13:08:11 +0800
Message-ID: <cover.1379048276.git.worldhello.net@gmail.com>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 07:11:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKLel-0006yw-S3
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 07:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab3IMFK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 01:10:56 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:54096 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010Ab3IMFKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 01:10:55 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so759185pdj.21
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 22:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SRJLbVVgwKsbUME/K6Ta14HIGjmgpaZ9NVFZCx0n4A0=;
        b=jn4LSeJRGDa1DmXNm7I4hxQmilGR0LS46i4tcTLAVonPQd7Hdcr4xaf1z/n9jgXsPT
         IPIkaZLKIw+u/DiRNc8aymkPFDeSvnkOsb32SXPtH6+zbVduukXQ2tWJtWOcYUGqJIIT
         jqmoQoHi0yRzCKeWtC28I88c6NF1SoHaYh+04S8Qw3SppbMwiaXSjJDekNAEEfa8EhcI
         PRQWADm4pEdCqca9PTleI1/HrU217j9DQHyAPzZZ+nhAexsFsefF1fzytOqivCQLjN2s
         TZTcBEZ4H4vkt5HrrseKNpLvWM0mIbHRRrTVFJ4/+RD6BmFt+O9qc93IWUZyr0BcyOuA
         0sWg==
X-Received: by 10.66.27.43 with SMTP id q11mr12971021pag.97.1379049054621;
        Thu, 12 Sep 2013 22:10:54 -0700 (PDT)
Received: from localhost.localdomain ([114.248.145.187])
        by mx.google.com with ESMTPSA id qa9sm8985593pbc.7.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 12 Sep 2013 22:10:53 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.459.gd80d422
In-Reply-To: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234728>

Updates since v1:

* New patch 1/3 on t0060, which use umambigous leading path (/foo).
* Call tolower instead of strncasecmp in patch 2/3.
* Rename simple_relative_path to remove_leading_path in patch 3/3.

Jiang Xin (3):
  test: use unambigous leading path (/foo) for mingw
  relative_path should honor dos_drive_prefix
  Use simpler relative_path when set_git_dir

 cache.h               |  1 +
 path.c                | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 setup.c               |  5 +---
 t/t0060-path-utils.sh | 60 +++++++++++++++++++++++++----------------------
 4 files changed, 99 insertions(+), 32 deletions(-)

-- 
1.8.4.459.gd80d422
