From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/2] completion: synchronize zsh wrapper
Date: Wed,  8 May 2013 02:37:01 -0500
Message-ID: <1367998621-12582-3-git-send-email-felipe.contreras@gmail.com>
References: <1367998621-12582-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 09:38:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZyxW-0004fw-1D
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 09:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368Ab3EHHie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 May 2013 03:38:34 -0400
Received: from mail-ye0-f177.google.com ([209.85.213.177]:34312 "EHLO
	mail-ye0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab3EHHic (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 May 2013 03:38:32 -0400
Received: by mail-ye0-f177.google.com with SMTP id q3so341923yen.22
        for <git@vger.kernel.org>; Wed, 08 May 2013 00:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=nV7dHvJJvdhOzOMtfhq73+k35rSxTyCowghOVOMw1lI=;
        b=B3Z51rwEIe+K86BYc3amBlzGShrbTc7FCQfBQwHQ0sAHa7+PvDqUddY96aC9a791UE
         3smf6FKu9cRMns7OK17GvUfT6FVtKqmtua/j2GdrymsRci1kjM9DYxY2UQ/R8Bmt1IM7
         J8KMBmL4Re1RPlmg2GQYK5PBobqiWxXS99XnKxgDxiK54Lb6RsForeVYZkglI/0DdVev
         9NvgV1K2xcv+L/PKfuHFL0LyMs0ZHBE4ghpG+c0XEyLPNDT53XvJUp03vpKNMswNg9LN
         SMRcU51klZ4EgQS4cetftiWfEmbty3l49ORERIqKgdTaieGhCDUM8Pdl9IHAtAlqTTv8
         L5Mg==
X-Received: by 10.236.1.233 with SMTP id 69mr5237278yhd.127.1367998712304;
        Wed, 08 May 2013 00:38:32 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i75sm61838351yhi.9.2013.05.08.00.38.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 May 2013 00:38:31 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.553.gac13664
In-Reply-To: <1367998621-12582-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223648>

So it's closer to the full zsh wrapper.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 84dbf19..b61f6c2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2663,7 +2663,7 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 				--*=*|*.) ;;
 				*) c="$c " ;;
 				esac
-				array[$#array+1]="$c"
+				array+=("$c")
 			done
 			compset -P '*[=:]'
 			compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
@@ -2696,7 +2696,7 @@ if [[ -n ${ZSH_VERSION-} ]]; then
 		prev=${words[CURRENT-1]}
 		let cword=CURRENT-1
 		emulate ksh -c __${service}_main
-		let _ret && _default -S '' && _ret=0
+		let _ret && _default && _ret=0
 		return _ret
 	}
 
-- 
1.8.3.rc1.553.gac13664
