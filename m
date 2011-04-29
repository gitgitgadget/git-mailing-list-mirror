From: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] diffcore-rename: Remove unused variable 'num_src'
Date: Fri, 29 Apr 2011 08:35:06 +0200
Message-ID: <20110429063506.GA13893@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 08:35:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFhIN-0005RR-7e
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 08:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab1D2GfM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2011 02:35:12 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:33434 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842Ab1D2GfL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 02:35:11 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1QFhIC-0001IU-9l
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Fri, 29 Apr 2011 08:35:10 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id A2BB63E2514; Fri, 29 Apr 2011 08:35:04 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx2.mail.elte.hu: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172428>


GCC 4.6 noticed an initialized but unused variable in diffcore_rename()=
:

  diffcore-rename.c: In function =E2=80=98diffcore_rename=E2=80=99:
  diffcore-rename.c:501:18: warning: variable =E2=80=98num_src=E2=80=99=
 set but not used [-Wunused-but-set-variable]

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
diff --git a/diffcore-rename.c b/diffcore-rename.c
index d0259be..f639601 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -498,7 +498,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
 	int i, j, rename_count, skip_unmodified =3D 0;
-	int num_create, num_src, dst_cnt;
+	int num_create, dst_cnt;
 	struct progress *progress =3D NULL;
=20
 	if (!minimum_score)
@@ -554,7 +554,6 @@ void diffcore_rename(struct diff_options *options)
 	 * files still remain as options for rename/copies!)
 	 */
 	num_create =3D (rename_dst_nr - rename_count);
-	num_src =3D rename_src_nr;
=20
 	/* All done? */
 	if (!num_create)
