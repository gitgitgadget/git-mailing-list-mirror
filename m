From: Martin Nordholts <enselic@gmail.com>
Subject: [PATCH] git.el: Make it easy to add unmerged files
Date: Sun, 30 Aug 2009 16:35:02 +0200
Message-ID: <4A9A8E16.9040106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	julliard@winehq.org
X-From: git-owner@vger.kernel.org Sun Aug 30 16:32:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhlS7-0007Uq-DQ
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 16:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbZH3Oby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2009 10:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753675AbZH3Oby
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 10:31:54 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:54570 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbZH3Obx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2009 10:31:53 -0400
Received: by ewy2 with SMTP id 2so3343946ewy.17
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=AvfKLtna6ogk883b9vdGjBQ+uq+HC7/t8rY4KWNSb0M=;
        b=Jl2Xfh1VwKMXM9Se4KULe7cTvs5Hjsnq4dEz+yxARxRoFOCXgbKPaBEbM7pcb/AU7c
         t2DN1Zg3KIDV/ifw0d2zRjRpmkB/8M03uo5o7YzrRI3Xwo5eHBZ8hZhQijicHkpsz0wu
         fQyt7Mg1fsDGrJZkrFn12QrH1utkVEQ9ytbuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=Vv6bWIXO5Rx4pixt2JjkgRHfQcDyrfnuS4kr+cRiFP2I6COV0AoSYL3ZWXMqqTAioC
         oxCdx1Atyzk5ZbNNnn+PRuWVHn5pt4Uwyz9xLgQyC5W84XEmLWHCQENK0V3d0eus4LH6
         o5HbhPD5OqS2oTlI9imbcfTUbzxUWu6laCb00=
Received: by 10.210.126.1 with SMTP id y1mr1607510ebc.80.1251642714641;
        Sun, 30 Aug 2009 07:31:54 -0700 (PDT)
Received: from ?192.168.1.2? (c-267871d5.017-113-6c756e10.cust.bredbandsbolaget.se [213.113.120.38])
        by mx.google.com with ESMTPS id 5sm2318174eyh.43.2009.08.30.07.31.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 30 Aug 2009 07:31:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.1) Gecko/20090814 Fedora/3.0-2.6.b3.fc11 Thunderbird/3.0b3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127412>

It is nice and easy to git-add ignored and unknown files in a
git-status buffer. Make it equally easy to add unmerged files which is
a common use case.

Signed-off-by: Martin Nordholts <martinn@src.gnome.org>
---
  contrib/emacs/git.el |    2 +-
  1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 8c70ad8..3af5d00 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1046,7 +1046,7 @@ The FILES list must be sorted."
  (defun git-add-file ()
    "Add marked file(s) to the index cache."
    (interactive)
-  (let ((files (git-get-filenames (git-marked-files-state 'unknown 
'ignored))))
+  (let ((files (git-get-filenames (git-marked-files-state 'unknown 
'ignored 'unmerged))))
      ;; FIXME: add support for directories
      (unless files
        (push (file-relative-name (read-file-name "File to add: " nil 
nil t)) files))
-- 
1.6.2.5
