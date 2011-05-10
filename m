From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/9] clean ":" is like specifying nothing
Date: Mon,  9 May 2011 22:51:15 -0700
Message-ID: <1305006678-4051-7-git-send-email-gitster@pobox.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com>
Cc: pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 07:51:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJfrN-0001Iw-N5
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 07:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629Ab1EJFvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 01:51:44 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589Ab1EJFvn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 01:51:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 84C0E5C9A;
	Tue, 10 May 2011 01:53:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=otgK
	zSouLVGNpsEj11VmhSA8vN8=; b=JQ5O2n9IDRvRTzJZVOvaYbZq1Bu3ac14X8YT
	PsMAfrDY7AMJtI8Kl3sFI8+9jcupx9ck9HOwFF9lYGbFDsCnwf4Mafj6Jp8n+mMx
	C+hvUEGeXgUw0PyZnYMA51j10Ky2g+vuI4HpmZdCTkeVWZfVTeaCRcVtrrLRHv1I
	5HAj0kM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	bGNBWqfq9GZPCnFs8eRrgtPsk+ObFyYi0U4XHdScF6Sz6+uAFHXA8EBerdNkrJuF
	oswWwYPDI89pXaJTiQuRXlTR9Xy1DlKg6f9goT4a87kLBlUYEFj1peqbdCiw575L
	ceZLGKNej7M0nY9i+0CVdIYRDpjzwMnN2gG8w72BNxg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 70AA85C99;
	Tue, 10 May 2011 01:53:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CFF85C98; Tue, 10 May 2011
 01:53:45 -0400 (EDT)
X-Mailer: git-send-email 1.7.5.1.290.g1b565
In-Reply-To: <1305006678-4051-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DF3AD6A2-7AC9-11E0-A9E3-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173310>

Adjust argc that is meant to correspond do the number of elements in
the pathspec array.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 4a312ab..686cd6b 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -96,6 +96,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		add_exclude(exclude_list.items[i].string, "", 0, dir.exclude_list);
 
 	pathspec = get_pathspec(prefix, argv);
+	argc = count_pathspec(pathspec);
 
 	fill_directory(&dir, pathspec);
 
-- 
1.7.5.1.290.g1b565
