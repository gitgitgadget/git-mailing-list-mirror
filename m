From: Orgad and Raizel Shaneh <orgads@gmail.com>
Subject: bug with submodule and assume-unchanged
Date: Sat, 24 Sep 2011 21:41:29 +0300
Message-ID: <CAGHpTBKyK_PQ1LU-st-vq3xa9tkxJSUQ=UZKARUQu25_sVu46A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 20:41:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7XAO-0006aT-8e
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 20:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752295Ab1IXSlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 14:41:32 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61998 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284Ab1IXSlb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 14:41:31 -0400
Received: by fxe4 with SMTP id 4so4803726fxe.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 11:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7P8v62ib+og/Dbl8iRglObtjKgp0KQ/8OHXggS7FyCw=;
        b=WnvC0Iuag7K1E5t4qCnDooPbDrB8rNwjq9F0V/dF7i819jHdtTyLMMcC8uEH8/GRAl
         KBLMoGcHdXG3kkRGoTJKByKBxb/1b9cIyLgssKBlLuqEi+CZ1Rk2uid0mEklNanoHb5r
         0kRY/fseYs+1gDNAbfzBU6kSa6HMB0NtWXd3M=
Received: by 10.223.32.9 with SMTP id a9mr7245225fad.134.1316889689868; Sat,
 24 Sep 2011 11:41:29 -0700 (PDT)
Received: by 10.223.115.82 with HTTP; Sat, 24 Sep 2011 11:41:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182037>

Hello,

Marking a submodule with update-index --assume-unchanged breaks diff.

Consider the script in http://pastebin.ca/2082543. The last 'diff'
output follows. Note that the diff for 'afile' is displayed, then sub
breaks the operation, and the diff for 'test' (or any other file that
comes after 'sub') is not displayed at all.

$:/tmp/git$ cd super/
$:/tmp/git/super$ git diff
fatal: unable to read c17499ae216dfba9538ed7f94ba109c2c5b87b2a
diff --git a/afile b/afile
index 14be0d4..7c2160f 100644
--- a/afile
+++ b/afile
@@ -1 +1 @@
-hello2
+goodbye2
diff --git a/sub b/sub
deleted file mode 160000
index c17499a..0000000
--- a/sub
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit c17499ae216dfba9538ed7f94ba109c2c5b87b2a

- Orgad
