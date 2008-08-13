From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH] Makefile: Use $(wildcard) for commands_in
Date: Wed, 13 Aug 2008 09:11:15 +0200
Message-ID: <1218611475-12960-1-git-send-email-bert.wesarg@googlemail.com>
References: <36ca99e90808130010w226a8947y1e1c59e5f5d57989@mail.gmail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 13 09:12:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTAWt-0006aa-Hw
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 09:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbYHMHLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 03:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751722AbYHMHLV
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 03:11:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:34663 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbYHMHLU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 03:11:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1587405fgg.17
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=fcSV8GhP6QLrUZUPSkdFrTLITN2Az+wjT18tJXwoI50=;
        b=rqA9SLa8DBLMRKT9vn1fVFB4zUvdA4ESvmT62kU3VohRSm8COIMuEwQyAPDTE8Abes
         BtZdipbF9c2DiOMO+uJQsx/keHvrYal6xsyjpOXXbEoUAkY/U2GgrAtqVUg7BcSqV4Wj
         cFzFL4ZAfKGybXoPxJUEPs5ZZWwW5JfNaD3O4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=MPzq152M1nqt+hzf5sh9BN04tGmizC1Z9uk6aEu3zWaOATehGb6vyOUwOVVPMxgGey
         xsQT2vItuejAQWjuOyeQcqEFmsTogPZCwz0Mz+O0hIUHyD46WNnSJ2CJaS1skTFC6+dJ
         Xtfti0Z0nf6qgevhr/9FpLvTz8yWmrY5zbqbM=
Received: by 10.103.212.20 with SMTP id o20mr7834105muq.22.1218611478850;
        Wed, 13 Aug 2008 00:11:18 -0700 (PDT)
Received: from localhost ( [91.15.91.25])
        by mx.google.com with ESMTPS id y6sm1818230mug.15.2008.08.13.00.11.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 00:11:17 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <36ca99e90808130010w226a8947y1e1c59e5f5d57989@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92186>

To prevent merge conflicts while adding new commands, use a wildcard for
the command list.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 6eade1e..2c4a67c 100644
--- a/Makefile
+++ b/Makefile
@@ -6,7 +6,7 @@ sharedir = $(PREFIX)/share/topgit
 hooksdir = $(cmddir)/hooks
 
 
-commands_in = tg-create.sh tg-delete.sh tg-export.sh tg-info.sh tg-patch.sh tg-summary.sh tg-update.sh
+commands_in = $(wildcard tg-*.sh)
 hooks_in = hooks/pre-commit.sh
 
 commands_out = $(patsubst %.sh,%,$(commands_in))
-- 
tg: (f27e693..) t/use-wildcard-for-commands_in (depends on: master)
