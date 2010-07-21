From: Zeeshan Qureshi <zeeshan@zqureshi.in>
Subject: Git commit behaving strangely
Date: Tue, 20 Jul 2010 22:28:04 -0400
Message-ID: <4C465B34.2040407@zqureshi.in>
Reply-To: zeeshan@zqureshi.in
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 21 04:28:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObP2s-0003F1-Ii
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 04:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933027Ab0GUC2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 22:28:12 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48877 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932983Ab0GUC2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 22:28:12 -0400
Received: by qwh6 with SMTP id 6so2274351qwh.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 19:28:10 -0700 (PDT)
Received: by 10.224.34.209 with SMTP id m17mr6492744qad.267.1279679290548;
        Tue, 20 Jul 2010 19:28:10 -0700 (PDT)
Received: from [192.168.2.12] (bas9-ottawa23-1096655242.dsl.bell.ca [65.93.161.138])
        by mx.google.com with ESMTPS id fb41sm28796383qcb.15.2010.07.20.19.28.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jul 2010 19:28:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10) Gecko/20100527 Thunderbird/3.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151386>

Hello,

I am new to git and was going through gittutorial-2 when i noticed 
something weird.

1. I first create a file file.txt with some text and committed it.
2. I create a file called closing.txt with some text and committed it.
3. then i added 1 new line to both closing.txt and file.txt
4. i added the file closing.txt to the staging are by running 'git add 
closing.txt'
5. now i ran 'git checkout' (by mistake)
6. Now i run 'git diff --cached' (which should show the changes i have 
in the index), the output is this

diff --git a/closing.txt b/closing.txt
index da55920..953ec3a 100644
--- a/closing.txt
+++ b/closing.txt
@@ -1 +1,2 @@
  closing
+again?

7. Now when i run 'git commit -m "closing again"', the change is not 
committed even though i get a new commit id.

The output of 'git log -p' is this (as you can clearly see, there are 
new commits but no change has been recorded)

commit 7dbe9a272c58decc08f9fd5ce07efd5bf28d89f8
Author: Zeeshan Qureshi <{email}>
Date:   Tue Jul 20 15:36:05 2010 -0400

     closing again

commit 1bfda310eb82e62925b28d62e98097d6fbd61620
Author: Zeeshan Qureshi <{email}>
Date:   Tue Jul 20 15:34:46 2010 -0400

     closing again

commit 3d0e35717bea56adbc7c578b3b17db3657e30040
Author: Zeeshan Qureshi <{email}>
Date:   Tue Jul 20 15:33:40 2010 -0400

     closing

diff --git a/closing.txt b/closing.txt
new file mode 100644
index 0000000..da55920
--- /dev/null
+++ b/closing.txt
@@ -0,0 +1 @@
+closing

commit 2a0a0e4edb1810b6e31b0739bd7736d1360e6d13
Author: Zeeshan Qureshi <{email}>
Date:   Tue Jul 20 15:32:13 2010 -0400

     initial commit

diff --git a/file.txt b/file.txt
new file mode 100644
index 0000000..3b18e51
--- /dev/null
+++ b/file.txt
@@ -0,0 +1 @@
+hello world


-- 
Zeeshan Qureshi
zeeshan@zqureshi.in
