From: Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH] gitk: Add mouse right-click options
Date: Thu,  7 May 2015 22:29:20 -0400
Message-ID: <1431052160-82758-2-git-send-email-rappazzo@gmail.com>
References: <1431052160-82758-1-git-send-email-rappazzo@gmail.com>
Cc: Michael Rappazzo <rappazzo@gmail.com>, Jens.Lehmann@web.de,
	Johannes.Schindelin@gmx.de, Josef.Weidendorfer@gmx.de,
	Knut.Franke@gmx.de, alexhenrie24@gmail.com, andersk@MIT.EDU,
	andrew.kw.w@gmail.com, angavrilov@gmail.com, arjen@yaph.org,
	askeolsson@gmail.com, astrilhayato@gmail.com,
	barra_cuda@katamail.com, bdowning@lavos.net, bebarino@gmail.com,
	bernt@norang.ca, chriscool@tuxfamily.org,
	das@users.sourceforge.net, dave@dulson.com, davvid@gmail.com,
	drafnel@gmail.com, fbriere@fbriere.net, felipe.contreras@gmail.com,
	gabriele.mzt@gmail.com, gauthier@ostervall.se, gitster@pobox.com,
	giuseppe.bilotta@gmail.com, gsromero@infernal-iceberg.com,
	hirofumi@mail.parknet.co.jp, ilya.bobyr@gmail.com, j6t@kdbg.org,
	jeffh@ActiveState.com, jim@meyering.net,
	jon.delStrother@bestbefore.tv, jrnieder@gmail.com,
	judge.packham@gmail.com, kaitanie@cc.helsinki.fi, kevin@sb.org,
	killekulla@rdrz
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 08 04:29:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqY2s-0007Oz-IM
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 04:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbbEHC3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 22:29:42 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35045 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbbEHC3l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 22:29:41 -0400
Received: by qgej70 with SMTP id j70so30596893qge.2
        for <git@vger.kernel.org>; Thu, 07 May 2015 19:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4u9mxASr6hPs/oJ+6yhzXNKaFHFRWu1vueZ4ds0hfvA=;
        b=QyX7JJYhCVvEFC6nUdm2NT7ISaDNa2BpV9iUk6Nstq47Rf5r4oV3JcGnMfaCg6geby
         Gi6t3chhzcKnE1sOaJPEXOYZJ95dH5Y1BwO7VFlnDu4Es5oWTe43OVCRr6LAJfqWryMP
         pYx94FMjPkeCZ6NOkYM5nc7+ZZIrNA3mivtyHTjUh8fbAAgaNZi71ixIZYpndz64Fs2p
         B5XB6JkJgzl1hCTVqkOtUUdE1tsLNnWnCw4r/pmxUcorwqt4iSNDwX5674ah0bbcBnM/
         J5sKRhKXIYMBQhuvNMfUkdQHtle2FoDAJxQo3o9CkFTxAebXAI5rESokAOBq+4Eup1BF
         u0QQ==
X-Received: by 10.140.32.34 with SMTP id g31mr2162168qgg.74.1431052180627;
        Thu, 07 May 2015 19:29:40 -0700 (PDT)
Received: from localhost (ool-18e49664.dyn.optonline.net. [24.228.150.100])
        by mx.google.com with ESMTPSA id b7sm2719538qkb.33.2015.05.07.19.29.39
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 19:29:40 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431052160-82758-1-git-send-email-rappazzo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268597>

 - 'Copy path' in the file list
 - 'Copy branch name' on a branch in the commit list

Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
---
 gitk-git/gitk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 9a2daf3..6d86820 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2645,6 +2645,7 @@ proc makewindow {} {
     makemenu $headctxmenu {
 	{mc "Check out this branch" command cobranch}
 	{mc "Remove this branch" command rmbranch}
+	{mc "Copy branch name" command {clipboard clear; clipboard append $headmenuhead}}
     }
     $headctxmenu configure -tearoff 0
 
@@ -2655,6 +2656,7 @@ proc makewindow {} {
 	{mc "Highlight this only" command {flist_hl 1}}
 	{mc "External diff" command {external_diff}}
 	{mc "Blame parent commit" command {external_blame 1}}
+	{mc "Copy path" command {clipboard clear; clipboard append $flist_menu_file}}
     }
     $flist_menu configure -tearoff 0
 
-- 
2.4.0
