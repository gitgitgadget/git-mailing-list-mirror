From: Conrad Irwin <conrad.irwin@gmail.com>
Subject: [PATCH 2/3] Allow git commit --interactive with paths
Date: Wed,  2 Feb 2011 21:25:31 -0800
Message-ID: <1296710732-12493-3-git-send-email-conrad.irwin@gmail.com>
References: <1296710732-12493-1-git-send-email-conrad.irwin@gmail.com>
Cc: conrad.irwin@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 03 06:25:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkrhW-0001mN-SU
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 06:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402Ab1BCFZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 00:25:44 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58299 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab1BCFZl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 00:25:41 -0500
Received: by gyb11 with SMTP id 11so326993gyb.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 21:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Xx1e0Z1cNYRxcbEp4+wamAo3W44KmxMYF89oNpGoNJQ=;
        b=SMz72NkG4Up/1c64WzAnls3PC7U3TfHLtkdOjWsu65yBddSUUbqAaWDLMJDpyUJ9gC
         5CBjEGzZrUihcoC2kR9BP6Wcn/tgq81ZQjxf+mMGbo6ZBAUDpfxXUS47Yy1VkEUCIu+S
         /EPS50D1AVcpGBP9auVdXarqLJZy82tPA6q08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NChAEmx34bwlpyJc/eot6QAIjXhu+qYaept+R4X3D4RZQXVJBFCCp0vsCv5MCFCn/D
         CkfgJTe87VybcDfw8KIvsYQyr27JZ4Vl/jhPEJkH7oD9R/HwBG0FrGe2vT8rlDOiI3M1
         TWYWsVjSbHfQLE/4wbRibPWebhmiHqpeegGkc=
Received: by 10.151.143.11 with SMTP id v11mr4215645ybn.188.1296710740790;
        Wed, 02 Feb 2011 21:25:40 -0800 (PST)
Received: from scarlatti.dunvegan.biz ([173.228.114.197])
        by mx.google.com with ESMTPS id r24sm113083yba.18.2011.02.02.21.25.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 21:25:39 -0800 (PST)
Received: from conrad by scarlatti.dunvegan.biz with local (Exim 4.72)
	(envelope-from <conrad@scarlatti.dunvegan.biz>)
	id 1PkrhK-0003Gx-99; Wed, 02 Feb 2011 21:25:38 -0800
X-Mailer: git-send-email 1.7.4.1.g1c7a9.dirty
In-Reply-To: <1296710732-12493-1-git-send-email-conrad.irwin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165953>

Make git commit --interactive feel more like git add --interactive by
allowing the user to restrict the list of files they have to deal with.

Signed-off-by: Conrad Irwin <conrad.irwin@gmail.com>
---
 builtin/commit.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 41f0e2e..592c2d2 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1012,8 +1012,6 @@ static int parse_and_validate_options(int argc, const char *argv[],
 
 	if (all && argc > 0)
 		die("Paths with -a does not make sense.");
-	else if (interactive && argc > 0)
-		die("Paths with --interactive does not make sense.");
 
 	if (null_termination && status_format == STATUS_FORMAT_LONG)
 		status_format = STATUS_FORMAT_PORCELAIN;
-- 
1.7.4.1.g1c7a9.dirty
