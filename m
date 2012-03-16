From: "Patrick F. Marques" <patrickfmarques@gmail.com>
Subject: [PATCH] Vim configurations, add gitcommit filetype to submodules
Date: Fri, 16 Mar 2012 11:47:53 +0000
Message-ID: <CANigeX1MuhT8tG0Gb4cNXrZKzd2jt66wS84VswL-w1dngBD92w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 16 12:48:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8VeB-0003VE-SO
	for gcvg-git-2@plane.gmane.org; Fri, 16 Mar 2012 12:48:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032748Ab2CPLsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 07:48:35 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:64846 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031167Ab2CPLsf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 07:48:35 -0400
Received: by wejx9 with SMTP id x9so3817084wej.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=dwRHR6nEybEjyeMDncR4+N7hoSaHhd2/uu33xxW49/4=;
        b=I1W84QwykEp3b5yfP4YBCB/dPSA5g0fDfTaz+dSqP3/ERlKL7Vyl+AOEUFjn7XmU5H
         Lf9VpOkGQAl7PGnkup3lc/QLqlzuhwaoXOIoysWumcu74OETIBXnapaKkIFTypJLwUKY
         wmF8KQ+UhYi6Vq8mZWUQEmLAKGub1nKmoQlQPM2dywPNPx1t4u7jpfR70XUTB6ZHdk0K
         I8FbMWAB/EEdRF0hSahpyas0zyAa7bcPh80j3oLQXPE4uyozUwEurpT5v0BSTVO/ypou
         zb+pw3GMbyrWpa8UV+c4f6C9VjQ3tJWUvN36ewjzW0zayQnAVQTHL78OP2X1nJL0NQoC
         7alA==
Received: by 10.180.92.34 with SMTP id cj2mr5815851wib.8.1331898513654; Fri,
 16 Mar 2012 04:48:33 -0700 (PDT)
Received: by 10.180.99.196 with HTTP; Fri, 16 Mar 2012 04:47:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193253>

Git commit in submodules doesn't use the
correct vim syntax. (filetype is set to conf
instead of gitcommit)

This will set ft to gitcommit in all submodules
(also tested on submodules of submodules)

Signed-off-by: Patrick F. Marques <patrickfmarques@gmail.com>
---

diff --git a/contrib/vim/README b/contrib/vim/README
--- a/contrib/vim/README
+++ b/contrib/vim/README
@@ -19,6 +19,7 @@ To install:
   2. To auto-detect the editing of various git-related filetypes:
 	$ cat >>$HOME/.vim/filetype.vim <<'EOF'
 	autocmd BufNewFile,BufRead *.git/COMMIT_EDITMSG    setf gitcommit
+	autocmd BufNewFile,BufRead *.git/modules/*/COMMIT_EDITMSG    setf gitcommit
 	autocmd BufNewFile,BufRead *.git/config,.gitconfig setf gitconfig
 	autocmd BufNewFile,BufRead git-rebase-todo         setf gitrebase
 	autocmd BufNewFile,BufRead .msg.[0-9]*
--
