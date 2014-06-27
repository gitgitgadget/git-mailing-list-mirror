From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] submodule.c: use the ARRAY_SIZE macro
Date: Fri, 27 Jun 2014 05:11:39 -0700
Message-ID: <1403871099-30620-1-git-send-email-gitter.spiros@gmail.com>
Cc: hvoigt@hvoigt.net, Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 14:12:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0V0n-0000ES-Pf
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 14:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561AbaF0MMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 08:12:09 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:40451 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbaF0MMI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 08:12:08 -0400
Received: by mail-pb0-f45.google.com with SMTP id rr13so4516953pbb.32
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=K7AR+D+LnkNFVY+2xEXyLJXqBZA54QlfITbcWvOeV2w=;
        b=ZBh4NWH8zEYj30l0KyBJA3x47IyUqOMhE9XI7JjHmvKTnz5FEQVUdMzwBOYByUC2RL
         Nz1u8A/EKFksH3KVcIbNXh5ZPinj4P+cDOJeVo0Qrwm2EIiB3bXMaIyrZygwlgUSvlQE
         OOEQs7UwOSOsobsegQHjkD0ZSdGTZ01i5OfmwNwA5gVxiJNsQVCoWQkmIyBtPvmpyXhj
         vOz/zG+rUUW2r4PdowGKDV/euj340Iw9HiRo8pAKjYhaqP9se2JqU2DnX9S1H2ZcHvTj
         BxgW4qBhFTL0AdBlXPDwSV/qQaKti80yp3H0gHdAdPZ+66gorwigs23lmv2l/U5OAxqw
         A38g==
X-Received: by 10.66.228.37 with SMTP id sf5mr30270817pac.19.1403871127648;
        Fri, 27 Jun 2014 05:12:07 -0700 (PDT)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id py7sm14539101pbb.78.2014.06.27.05.12.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 27 Jun 2014 05:12:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252546>

Use the ARRAY_SIZE macro to get the number
of elements in an array.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 submodule.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index b80ecac..48e3b44 100644
--- a/submodule.c
+++ b/submodule.c
@@ -965,7 +965,7 @@ static int find_first_merges(struct object_array *result, const char *path,
 			sha1_to_hex(a->object.sha1));
 	init_revisions(&revs, NULL);
 	rev_opts.submodule = path;
-	setup_revisions(sizeof(rev_args)/sizeof(char *)-1, rev_args, &revs, &rev_opts);
+	setup_revisions(ARRAY_SIZE(rev_args)-1, rev_args, &revs, &rev_opts);
 
 	/* save all revisions from the above list that contain b */
 	if (prepare_revision_walk(&revs))
-- 
1.7.10.4
