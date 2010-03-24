From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 7/7] fmt-merge-msg: hide summary option
Date: Wed, 24 Mar 2010 00:16:04 -0700
Message-ID: <1269414964-9518-8-git-send-email-bebarino@gmail.com>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 08:17:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuKpy-0006wZ-GW
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 08:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab0CXHQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 03:16:38 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:51811 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754900Ab0CXHQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 03:16:26 -0400
Received: by mail-gx0-f217.google.com with SMTP id 9so1364583gxk.8
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 00:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=elt1Uf+1IZLkCe+s6EVkRtCfRvwTYVJnWYlLlsg0708=;
        b=hzGptZ6AcaDVWinZSVmCux8dSHqLjk2fR46YAit4s0bVtFCYTkYbMYYRQyJ+zHoNQ9
         Z70SDzvf6C0X+ZRNTpuSa71nUIbbwi/DIm83O4hzVyzH0mVOgd9VoL2y3B5gw8UH9rft
         mJ2aPhmUbvdSh9L/b0ZLaAdlaZcvtqp2yIof4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SfOblHXavbw85P8uS6gIijhJXWewym9+9zRsOdL896Z+YpUhQWI6VBlLU/67oZEhpw
         x/jjRjhGH0g864pkWAfbFSpADPKfeHqhnJ1viYzAvdDNoQ5qFMzTpI+2gUN1M6v3WgEA
         r16IVVK1XvcBZGHSek7qWA/MVNu+lzTM8FxcU=
Received: by 10.101.141.10 with SMTP id t10mr6613414ann.25.1269414986566;
        Wed, 24 Mar 2010 00:16:26 -0700 (PDT)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 21sm5796628iwn.11.2010.03.24.00.16.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 00:16:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.254.g4503b
In-Reply-To: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143074>

The --summary command line option has been deprecated in favor of --log.
Hide the option from the help message to further discourage the use of
this option.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

When is this option going to be removed? It's approaching 2 years
since the deprecation occured in 6cd9cfe (fmt-merge-msg: add
'--(no-)log' options and 'merge.log' config variable, 2008-04-06)

 builtin/fmt-merge-msg.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 0fb4014..379a031 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -301,7 +301,9 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 	const char *inpath = NULL;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "log",     &merge_summary, "populate log with the shortlog"),
-		OPT_BOOLEAN(0, "summary", &merge_summary, "alias for --log"),
+		{ OPTION_BOOLEAN, 0, "summary", &merge_summary, NULL,
+		  "alias for --log (deprecated)",
+		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
 		OPT_FILENAME('F', "file", &inpath, "file to read from"),
 		OPT_END()
 	};
-- 
1.7.0.3.254.g4503b
