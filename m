From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCHv2 2/2] completion: complete config variables for --get/getall/unset/unset-all
Date: Fri,  8 May 2009 18:23:33 -0700
Message-ID: <1241832213-23070-3-git-send-email-bebarino@gmail.com>
References: <1241832213-23070-1-git-send-email-bebarino@gmail.com>
 <1241832213-23070-2-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 09 03:23:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2bI7-0007z8-9f
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 03:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755521AbZEIBXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 21:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754656AbZEIBXp
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 21:23:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:25134 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbZEIBXm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 21:23:42 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1394673rvb.1
        for <git@vger.kernel.org>; Fri, 08 May 2009 18:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=ueetQpjQD8Sh6Ty9VkTmken4jJK1NlI6QMngPE7c430=;
        b=VXQ1sU4fWbNjiMXMpyRD//MLyIHbEJf5w0/SnBvPjpTG9Tk1TZ9GwbDJpG+nA7M3+Z
         Y20CVzE+BW5jgUcAVv3TMc98cgaodUQHN2PC+MYqXTs3Gm+9ZyXAugHupmrewtOhF03X
         sDip2tv+xd8hWwlwXrknxnP/B33xzN1OLkQ14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YjVHalWyzDkYn/7xkMYumvhI3Vq7iCaV5akgEClibn/chqQJsX7ANGM+4WsdN+4C9Z
         ttSGNEtbU0ECtRMA9zGcCscpAIdqLiTclOJEnqPn8o5TYJUu0Hx1L56mmTWjtcsCSghH
         s/I8bMoZNjnVRKLnCI3Bx2nPAyLwEqagQwCxg=
Received: by 10.140.126.19 with SMTP id y19mr1280095rvc.115.1241832222917;
        Fri, 08 May 2009 18:23:42 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id b8sm3772453rvf.14.2009.05.08.18.23.40
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 08 May 2009 18:23:42 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Fri, 08 May 2009 18:23:39 -0700
X-Mailer: git-send-email 1.6.3
In-Reply-To: <1241832213-23070-2-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118644>

This should make it easier for users to get and unset their
configuration variables without having to open documentation or dig
through their configuration file.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 contrib/completion/git-completion.bash |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e73359c..ad26b7c 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1417,6 +1417,10 @@ _git_config ()
 		__gitcomp "$__git_send_email_suppresscc_options"
 		return
 		;;
+	--get|--get-all|--unset|--unset-all)
+		__gitcomp "$(__git_config_get_set_variables)"
+		return
+		;;
 	*.*)
 		COMPREPLY=()
 		return
-- 
1.6.3
