From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/18] builtin-rev-list.c: mark file-local function static
Date: Mon, 11 Jan 2010 23:52:45 -0800
Message-ID: <1263282781-25596-3-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:53:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbZQ-0004h8-Fg
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753394Ab0ALHxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753006Ab0ALHxR
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:17 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab0ALHxP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AA8F8E876
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vR3S
	JWZ0V80Apfapv2LHcTudM7Q=; b=vpcty8Cgadvdt0UWV8OkuRyDTxv2+JZ60qH/
	wqS93Gcmyc/S0xe6TLVO1Ng8AcKzJrqwnpPdnpAe6UeoSS3ScO4gSlf2/Rifnep3
	4+Rwy8B/fSNaKpR3mq6s/+vddAJ5KW/lOrc94iH/0lN3uouDRHWvn+N+7ahoH1BA
	F2RNFws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=py1iI8
	oFVPl1t8lp/C99nEJCtSoK7V9kmp6La++e1zu/bNfxd6DOWgkNQWY1ERf1zSCWcs
	fRTG9I5o0h33GwAtXlR9fWzu6bOpqsFry0h5qTCGu4+xFxnkb/FDaQ0ztmWGxLpL
	L9Y4vBJdxt9Oq9CJxVRLfImLJieiv7ZSeUG+o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0670A8E874
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 923BA8E872 for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:13 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 895FDD00-FF4F-11DE-93EE-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136693>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 bisect.h           |    2 --
 builtin-rev-list.c |    2 +-
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/bisect.h b/bisect.h
index 82f8fc1..0862ce5 100644
--- a/bisect.h
+++ b/bisect.h
@@ -27,8 +27,6 @@ struct rev_list_info {
 	const char *header_prefix;
 };
 
-extern int show_bisect_vars(struct rev_list_info *info, int reaches, int all);
-
 extern int bisect_next_all(const char *prefix);
 
 extern int estimate_bisect_steps(int all);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index cd97ded..c924b3a 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -253,7 +253,7 @@ static void print_var_int(const char *var, int val)
 	printf("%s=%d\n", var, val);
 }
 
-int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
+static int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 {
 	int cnt, flags = info->bisect_show_flags;
 	char hex[41] = "";
-- 
1.6.6.280.ge295b7.dirty
