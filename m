From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 02/26] refs: make is_branch public
Date: Tue, 27 Oct 2015 22:14:03 -0400
Message-ID: <1445998467-11511-3-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:14:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGGL-0000pm-Ux
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbbJ1COp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:14:45 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:35752 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177AbbJ1COn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:14:43 -0400
Received: by igbkq10 with SMTP id kq10so96953881igb.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GW6WCu+7iCfxGc+w7FupXZ6dw4f0+txSBM/qPfwFcYU=;
        b=iErGJpwdKUTOC1DEal0iGfZcGoV4y1XuPNPGmiWVBSdTklxK13wlW5FBg4qDM6aQu3
         orY8xfzbRstu6FDKKeuK8NyKZ+A3RDtuaqUJzUMIgbOdgcudq2NBcasO4SZ0AxC8W9qU
         4YQv5kI2a1maf+CLyIvBQDcZjlujeINa9M1epJk3vELZgO2nflJLAwVn9yJkHKcB2iKR
         fkDFON/Pll+qDpNH4xjMHgLu8FsdzAsWg9sWY/1Q0xpWXIMVf79MCGP2MUIyZQJqKi7H
         GjqEfSeJn9BycZwKbb6alq3ZzQ8SlllKDb+VZjzKQ7QDezBax15SBevdNYWZpQBStFwi
         RD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GW6WCu+7iCfxGc+w7FupXZ6dw4f0+txSBM/qPfwFcYU=;
        b=Z75vc4Gu131w43NLmTq5+52AlFJTOcEyCfOtXXY5IzgaA1TuiW9LNq9nY3NZkw508T
         JCrncGym3zId5cGRGpJKmRYsYoBeNJmAjjsiyQ8a7nygF7mvsZh5CIszWXYlIrNTTTWC
         wfHDo3jidd9qlldQCAbOQf6yYVJYkFsaIp9XB2BL6reRU3aISJQpWzc5fv6vbnhkC87m
         4X86IkUmmjCIoie26dkgbo4YZb5NfjgxsPGHCZBmQUY3cgsViQoqBtXiKOe6tVn1Ykto
         DudDo6TNk+n9PTy2CijQdos3ZDbQ1HhQyD9UAnvvQ9b9srpkv4uWA5bbFYAaLP/Xxi3S
         1CjA==
X-Gm-Message-State: ALoCoQlZyh4+hd064he1TZ/we72DlNkjJ3n52evwmEeJS2kncn3NCbdkm4xH573bCEILoOiKG3sU
X-Received: by 10.50.6.68 with SMTP id y4mr334804igy.49.1445998482515;
        Tue, 27 Oct 2015 19:14:42 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.14.41
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:14:41 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280326>

is_branch was already non-static, but this patch declares it in the
header.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/refs.h b/refs.h
index 7367a7f..8408bef 100644
--- a/refs.h
+++ b/refs.h
@@ -237,6 +237,8 @@ int pack_refs(unsigned int flags);
 int verify_refname_available(const char *newname, struct string_list *extra,
 			     struct string_list *skip, struct strbuf *err);
 
+extern int is_branch(const char *refname);
+
 /*
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
  * REF_NODEREF: act on the ref directly, instead of dereferencing
-- 
2.4.2.658.g6d8523e-twtrsrc
