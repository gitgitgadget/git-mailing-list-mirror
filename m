From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/3] format-patch: make full-diff enabled by default
Date: Sat, 28 Nov 2009 13:40:28 +0200
Message-ID: <1259408429-5685-3-git-send-email-felipe.contreras@gmail.com>
References: <1259408429-5685-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 28 12:40:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NELfc-0006w7-0z
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 12:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbZK1Lko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 06:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbZK1Lko
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 06:40:44 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:38892 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbZK1Lkn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 06:40:43 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so1602122bwz.21
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 03:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tf4dW70lxdS+XVe6w2wtpImSmMqG0x5izoxROxYknbE=;
        b=Rpm//UmmEXpCcZukdywNEo6Tvj+q4KoGkMiCiYQq+gN/8iHxVYU9siLagu8kqK3TT3
         dV4nAKED6KeerYAO8UIwsPj1B5ufiCqKJIlJTSOqFAGA9RCXXlzdXIJ72ywYXUajGfQM
         l7uTEbx1E5rzJ2CYE9qfqmR+LKOjKoUgJQVHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IkIPfpUWmAnN9+OIFPmba7aXcxVKZEapDmabt/Q5tR5a4CB+uo3uYp0RtXyK7G70Lu
         mxzPvxcmY/n4yJ42JVSkcpGbviwIT1g6pa0sj9HjWRwq8QSFyp5p5SC4kMtMVikKByY3
         V+PW6uIYjujTzClLDLTGVx1+nEQs8pfL0tSrI=
Received: by 10.204.156.201 with SMTP id y9mr2108501bkw.204.1259408449272;
        Sat, 28 Nov 2009 03:40:49 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi [91.153.253.80])
        by mx.google.com with ESMTPS id 13sm615057bwz.6.2009.11.28.03.40.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 03:40:48 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc0.61.geeb75
In-Reply-To: <1259408429-5685-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133956>

It doesn't make much sense to generate partial patches (with some paths
omitted).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin-log.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 1766349..1e06859 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -960,6 +960,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
+	rev.full_diff = 1;
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
 	rev.subject_prefix = fmt_patch_subject_prefix;
-- 
1.6.6.rc0.59.g5117f7.dirty
