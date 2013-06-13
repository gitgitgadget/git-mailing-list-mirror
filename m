From: =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
Subject: [PATCH v2] show-branch: use pager
Date: Thu, 13 Jun 2013 09:57:18 +0200
Message-ID: <1371110238-6910-1-git-send-email-oystwa@gmail.com>
References: <20130613070118.GA23235@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 13 09:57:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un2Pt-0003ES-UW
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 09:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264Ab3FMH5y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Jun 2013 03:57:54 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:52811 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755531Ab3FMH5x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 03:57:53 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so8632816lab.2
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 00:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=joCGpDCxwQlPKSbRiB/dUx/89n7all8f1hcd4MR4elc=;
        b=Ku8Xbq17xvwzzbyaMIFdaf5cmiC7wHOMRDVxmHWROUx4mpA3RQrvpMvcB9b+RlW8G8
         7Vc+kVL7aNYOzz2eYg1GpeZTne7STifyjH2JMab27YnZXfPDJIJfOQpMMAMzvfKR1KxV
         yUByF+kN/T6X+LvchLuIOTF4DlXOQeft/C7bY0dvlokBHDgBFHtCtZkczvi1m6Rthh9x
         ZbUZ+sFmU/BuXpUTJgxFwzWJwrAQW0k7NYLdvMjqfaY+UFcfgHBNIYs7upGLx8Nj3q4d
         PSw8v71p8HM/V2wOoN5MZ1ZW2sMVXrxXjHSG/CQMf/inxau8FgMklPFTqNofMY63LH4a
         0ryg==
X-Received: by 10.152.29.169 with SMTP id l9mr11547241lah.31.1371110271933;
        Thu, 13 Jun 2013 00:57:51 -0700 (PDT)
Received: from osse-w760.lan (147.137.202.84.customer.cdi.no. [84.202.137.147])
        by mx.google.com with ESMTPSA id e9sm10303402lbj.3.2013.06.13.00.57.50
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 00:57:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.2
In-Reply-To: <20130613070118.GA23235@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227704>

This is for consistency with other porcelain commands such as 'log'.

Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
---
Hi, Jeff

Thanks for the (fast!) feedback and good to hear it won't cause any tro=
uble.

I hadn't actually noticed this mechanism of setting up the pager before=
 now but
I fully agree. Here's an updated version.=20

=C3=98sse

 git.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 4359086..6d1f6ca 100644
--- a/git.c
+++ b/git.c
@@ -406,7 +406,7 @@ static void handle_internal_command(int argc, const=
 char **argv)
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
 		{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "show", cmd_show, RUN_SETUP },
-		{ "show-branch", cmd_show_branch, RUN_SETUP },
+		{ "show-branch", cmd_show_branch, RUN_SETUP | USE_PAGER },
 		{ "show-ref", cmd_show_ref, RUN_SETUP },
 		{ "stage", cmd_add, RUN_SETUP | NEED_WORK_TREE },
 		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
--=20
1.8.2.2
