From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH] cleanup: remove unused git_checkout_config
Date: Sun,  2 Mar 2008 18:05:05 +0800
Message-ID: <1204452305-5580-1-git-send-email-crquan@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 11:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVl5e-00058A-Uj
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277AbYCBKFn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 05:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752169AbYCBKFn
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:05:43 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:13740 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbYCBKFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:05:42 -0500
Received: by ti-out-0910.google.com with SMTP id 28so4963255tif.23
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 02:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=qNv6xXpfW1PaxTWLhnpHuOCNe/KZe2frTl/mjl85cfE=;
        b=Ee474x3lX/oKqJTXYT/YxyRg+ubogbxLUHy2lUwxF7slgM5R0wG1/PTSGkqbwgOA5Kf9a3p6bUXXkwuIGYxzrOmdq/gjw4JhVFFrlHP7QEI/Oe29p9dACqpocdvBbhJcGpZgWtpi15LnjwbdEwR7FvF1JjHEw8zBLevXm6ishMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AIfs5hamZswYmTW1BS8XTNzNJXN6QnGOyTVpMltN2yVVwG5ZG/cHo/plGfXJqqyfhTQyLJGXrGg6NIhFVamhqDqJkKTV2B+Tg/UkfbG7m/suuqinRuBSBoESfd5pv/3O7IWXTXAnagwLwbUJhBQTcLxINXlIh5+650nIyzQnBVY=
Received: by 10.114.137.2 with SMTP id k2mr5541276wad.104.1204452338649;
        Sun, 02 Mar 2008 02:05:38 -0800 (PST)
Received: from tux ( [121.34.60.168])
        by mx.google.com with ESMTPS id j39sm18472335waf.32.2008.03.02.02.05.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Mar 2008 02:05:37 -0800 (PST)
Received: by tux (sSMTP sendmail emulation); Sun,  2 Mar 2008 18:05:05 +0800
X-Mailer: git-send-email 1.5.4.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75759>

Directly call git_default_config instead.

Signed-off-by: Denis Cheng <crquan@gmail.com>
---
 builtin-checkout.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index b0cd788..6b08016 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -484,11 +484,6 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	return post_checkout_hook(old.commit, new->commit, 1);
 }
 
-static int git_checkout_config(const char *var, const char *value)
-{
-	return git_default_config(var, value);
-}
