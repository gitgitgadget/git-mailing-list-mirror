From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] diff: chapter and part in funcname for tex
Date: Sat,  2 Aug 2008 23:56:44 +0200
Message-ID: <1217714204-12762-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <7vprormh7a.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 23:57:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPP6L-0004ef-Dc
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbYHBV41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbYHBV40
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:56:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:12983 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540AbYHBV40 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:56:26 -0400
Received: by fg-out-1718.google.com with SMTP id 19so762187fgg.17
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 14:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=S+pJhkvB1gdaFFNZpI0p/2y2Ns1hENonsuF6E7+nksE=;
        b=XUpyIsZaED7aqELBYUAlCbuvZayyeLl4eS82VZxHlztEwX0nDeCMZbTGWtrQprWjt+
         OfvLy3w6gqjBPuX4u/4NKnM96GeWJ6UtwTuxEozh5KSHPPEIAN8S8PeKOWMHFHQwKY8a
         opzSIKa4a+CCtchdFF5+IX5sjvaWN6A3Tgp2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KT08QocRsOocuiZtBif/vnecj0EY8w+2iZ4mnUWqY2fvCM9MmE+UgVdsNfdfKft661
         awb7mp1e4ye2qQC36B+usgAbYQ6ay0BVr8Lu57DCCE0cTaeBrC/5GTzbmq+YsFlNYMlV
         /nvDCezRIa/Phu+mgnWblkoMY/4LDm5Z4LMvU=
Received: by 10.86.36.11 with SMTP id j11mr8807657fgj.7.1217714184967;
        Sat, 02 Aug 2008 14:56:24 -0700 (PDT)
Received: from localhost ( [94.37.6.145])
        by mx.google.com with ESMTPS id 4sm2965373fge.5.2008.08.02.14.56.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Aug 2008 14:56:24 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <7vprormh7a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91191>

This patch enhances the tex funcname by adding support for
chapter and part sectioning commands. It also matches
the starred version of the sectioning commands.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---

As recommended by Junio, use \{0,1\} instead of \?

 diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index c253015..776bce1 100644
--- a/diff.c
+++ b/diff.c
@@ -1380,7 +1380,7 @@ static struct builtin_funcname_pattern {
 			"^[ 	]*\\(\\([ 	]*"
 			"[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}"
 			"[ 	]*([^;]*\\)$" },
-	{ "tex", "^\\(\\\\\\(sub\\)*section{.*\\)$" },
+	{ "tex", "^\\(\\\\\\(\\(sub\\)*section\\|chapter\\|part\\)\\*\\{0,1\\}{.*\\)$" },
 	{ "ruby", "^\\s*\\(\\(class\\|module\\|def\\)\\s.*\\)$" },
 };
 
-- 
1.5.6.3
