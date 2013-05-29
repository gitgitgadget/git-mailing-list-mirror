From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/3] push: fail early with detached HEAD and current
Date: Thu, 30 May 2013 01:34:06 +0530
Message-ID: <CALkWK0=W3B0wFSjwa5qrtyOGHyJFWnZQicqubpyvT6hS5EYXpQ@mail.gmail.com>
References: <1369855311-23367-1-git-send-email-artagnon@gmail.com>
 <1369855311-23367-3-git-send-email-artagnon@gmail.com> <7vppw9shq2.fsf@alter.siamese.dyndns.org>
 <CALkWK0mCY0F-EgO6hQv-LvV1Nb5H9jNXBWLDrY07rVNqLBPjkw@mail.gmail.com> <7v7gihsgjr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 29 22:04:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhmc7-00029i-Uv
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 22:04:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935148Ab3E2UEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 16:04:48 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41468 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933570Ab3E2UEr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 16:04:47 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so6506983iea.32
        for <git@vger.kernel.org>; Wed, 29 May 2013 13:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=rvOb6v7ONrD1o53sDZPYP6xqvSKmUucS1+dMBgssTn4=;
        b=PyUb6xfZNsV/GbKMeV/fnxmw95t7I9rQeeE3qZ9PYfdSpeJx4zj2mbxDtftjR0I8Kv
         GCCyNvN5T7S8oZNy4FZCNGd1PyMhg88v6e1FaAItiaY6JkVr+LKPcLw8aGr8hnbBVgX5
         TbVlD9eB068B5Dz1YkWkz6z0659q5jE91ynBDaDuW/y0FrkHk7sfc/H2mSg+EKQu3KSf
         H5QHFlpMvD4OVB8cQ+rZS8BANRR0JS1I80IIhuRUdJh7bSElRI70AEVZx9NEpaQDJeds
         VMKKHpJAQdJ+oAJpKhx/5pm55YlMtZIge842Z45D4yqU07lKn0g6qgsPyofDiOECmwia
         jd6Q==
X-Received: by 10.42.95.147 with SMTP id f19mr1851628icn.24.1369857887029;
 Wed, 29 May 2013 13:04:47 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Wed, 29 May 2013 13:04:06 -0700 (PDT)
In-Reply-To: <7v7gihsgjr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225883>

Here: put this at the end of the series and autosquash.

-- 8< --
From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Thu, 30 May 2013 01:29:59 +0530
Subject: [PATCH] fixup! HEAD~2

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index d819487..2d84d10 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -175,7 +175,7 @@ static void
warn_unspecified_push_default_configuration(void)

 static void setup_default_push_refspecs(struct remote *remote)
 {
-       struct branch *branch = branch_get(NULL);
+       struct branch *branch;

        switch (push_default) {
        default:
@@ -196,6 +196,7 @@ static void setup_default_push_refspecs(struct
remote *remote)
                break;

        case PUSH_DEFAULT_CURRENT:
+               branch = branch_get(NULL);
                if (!branch)
                        die(_(message_detached_head_die), remote->name);
                add_refspec(branch->name);
-- 
1.8.3.12.gbd56588
