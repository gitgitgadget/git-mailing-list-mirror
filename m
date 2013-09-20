From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v4 0/3] relative path regression fix
Date: Fri, 20 Sep 2013 10:38:45 +0800
Message-ID: <cover.1379644482.git.worldhello.net@gmail.com>
References: <CANYiYbGK_KdF5Yvcus5C_cGz3EyGTaFvirsUH5q4Eu=3VC4=Wg@mail.gmail.com>
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 20 04:41:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMqf1-0002as-OW
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 04:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457Ab3ITClc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 22:41:32 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:49440 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771Ab3ITClb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 22:41:31 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so9175592pdj.32
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 19:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M30bWg2dSosnA2CEgq0fFk8Ep2rTJteB6FCZiV8JLGQ=;
        b=B9EElQbVkxF957hX9vVWAw1VU8s3TgdeI0VrrsZWhqhe+bw0dW6eYa6XLRUJzxSWSi
         xLJOVolXgxZAR4sgnST3o8JZigyYol+Z8V7NnwjVlr56J0lztusgk4hl221AYoYe/YnI
         A3jsbb4/E2/3nO82AfdCptg1l8QGVVqACLT7h5SMiOxHnQgk+cJKgOWeuz7l0Gc2wzYa
         pLENw5SVNAEeHI2EsBq2ffwf1QhX4MHhlilFiPgiBznG/hncCqYMdIVmhbjS5hZjKZYL
         VUYGA5weOpPkBsaZM6RP3n8DpZjzIUSei6qR3nEcfJSe1odC2d/Eatsj7rq2Qa7/QdTY
         UTQA==
X-Received: by 10.66.118.129 with SMTP id km1mr6015543pab.127.1379644890891;
        Thu, 19 Sep 2013 19:41:30 -0700 (PDT)
Received: from localhost.localdomain ([114.248.149.94])
        by mx.google.com with ESMTPSA id wp8sm12412723pbc.26.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 19 Sep 2013 19:41:29 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.460.gbed9cb4
In-Reply-To: <CANYiYbGK_KdF5Yvcus5C_cGz3EyGTaFvirsUH5q4Eu=3VC4=Wg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235047>

Remove implementations on UNC names in patch v3.
So patch v4 is the same like v2, but with minor
update for commit logs.

Jiang Xin (3):
  test: use unambigous leading path (/foo) for mingw
  relative_path should honor dos-driver-prefix
  Use simpler relative_path when set_git_dir

 cache.h               |  1 +
 path.c                | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 setup.c               |  5 +---
 t/t0060-path-utils.sh | 60 +++++++++++++++++++++++++----------------------
 4 files changed, 99 insertions(+), 32 deletions(-)

-- 
1.8.4.460.gbed9cb4
