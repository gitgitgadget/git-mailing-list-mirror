From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH] checkout: warn about 'branch name' rather than 'local branch'
Date: Fri, 29 Jan 2010 22:09:02 +0100
Message-ID: <1264799342-11093-1-git-send-email-srabbelier@gmail.com>
References: <fabb9a1e1001291256j71e2c95cic21cb5a6a0cc1fe8@mail.gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ron1 <ron1@flownet.com>, Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 22:17:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NayDW-0001Ay-Of
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 22:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab0A2VRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 16:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754131Ab0A2VRV
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 16:17:21 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:26349 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab0A2VRU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 16:17:20 -0500
Received: by ey-out-2122.google.com with SMTP id d26so564747eyd.19
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 13:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=zSq1sVFozgSW3QCm6xG74x8HbEPNV8ALYFbl3uV+N+E=;
        b=r1csKujz5WXXRkO1tw1pTBYIxcXAtJizbBMOjldSSs4Q1z9gZgunIR8JLjlwlWpPOy
         mSb5PwkdxoScWoIHFMtLyQQGiiz6js/b1/NHhEy8sfd3p1+nSTKgOzbmwRXe9H3PfH07
         NquFZc8QewBUPse3xeZ7LUuEdyMgu6oFW262k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=m3ZNnIVVqhBOxKoXaWCL97p9nkGwl7JMf3WccUULcQd0Ee8FV7wsGexeMmKi1DzN28
         IO+fs6WWcgZTYdsnpyy/tUBa9zZkk23Z5GygnW4r3DQk8HntmG4x744n47TWl+59m5SI
         ZstWKyyZ+QX+GKk4FgQ3oDTZojDTb+1wCk6qo=
Received: by 10.213.110.4 with SMTP id l4mr1333808ebp.81.1264799373194;
        Fri, 29 Jan 2010 13:09:33 -0800 (PST)
Received: from localhost.localdomain (ip138-114-211-87.adsl2.static.versatel.nl [87.211.114.138])
        by mx.google.com with ESMTPS id 16sm1670106ewy.2.2010.01.29.13.09.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Jan 2010 13:09:32 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.56.gaea25.dirty
In-Reply-To: <fabb9a1e1001291256j71e2c95cic21cb5a6a0cc1fe8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138358>

These days, you can say "git checkout topic" to automagically create
a local "topic" branch that forks from "origin/topic" remote tracking
branch when you have one, thanks to Dscho's UI improvement ideas. As
such it is more appropriate to say that the user is checking out
something that is not a branch name, rather than saying it is not a
'local branch'.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Junio, I used part of your reply as the commit message, is that ok?

  Only change is s/local branch/branch name/.

 builtin-checkout.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 5277817..4b34314 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -523,7 +523,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			   REF_NODEREF, DIE_ON_ERR);
 		if (!opts->quiet) {
 			if (old->path)
-				fprintf(stderr, "Note: moving to '%s' which isn't a local branch\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
+				fprintf(stderr, "Note: moving to '%s' which isn't a branch name\nIf you want to create a new branch from this checkout, you may do so\n(now or later) by using -b with the checkout command again. Example:\n  git checkout -b <new_branch_name>\n", new->name);
 			describe_detached_head("HEAD is now at", new->commit);
 		}
 	}
-- 
1.6.6.rc1.56.gaea25.dirty
