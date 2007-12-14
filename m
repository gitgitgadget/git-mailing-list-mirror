From: Pieter de Bie <frim@frim.nl>
Subject: [BUG?] git rebase -i
Date: Fri, 14 Dec 2007 02:21:25 +0100
Message-ID: <2791F15A-EB72-4FE4-8DB3-7A4B4DCB07B3@frim.nl>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 14 02:42:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2zZC-0007Qm-FE
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 02:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763863AbXLNBlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 20:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760822AbXLNBlg
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 20:41:36 -0500
Received: from [72.249.127.116] ([72.249.127.116]:57927 "EHLO
	smtp.novowork.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1765238AbXLNBle (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 20:41:34 -0500
X-Greylist: delayed 1198 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Dec 2007 20:41:34 EST
Received: from [192.168.1.203] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by smtp.novowork.com (Postfix) with ESMTP id 0F18912600AC
	for <git@vger.kernel.org>; Fri, 14 Dec 2007 02:21:32 +0100 (CET)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68211>

Hi,

I was just toying with git rebase -i -p, when I found the following:

Tirana:~/git pieter$ /opt/local/bin/git --version
git version 1.5.3.5

Tirana:~/git pieter$ time /opt/local/bin/git rebase -p -i HEAD~100
Successfully rebased and updated refs/heads/master.

real    0m17.816s
user    0m3.927s
sys     0m10.381s

Tirana:~/git pieter$ git --version
git version 1.5.4.rc0
Tirana:~/git pieter$ time git rebase -p -i HEAD~100
cat: /Users/pieter/git/.git/.dotest-merge/rewritten/ 
1e8df762b38e01685f3aa3613e2d61f73346fcbe: No such file or directory

real    0m20.427s
user    0m4.449s
sys     0m14.028s

The rebase in 1.5.4.rc0 exists with an error. Another thing to note  
is that the 1.5.4.rc0 tries to apply 215 patches, while the 1.5.3.5  
tries to apply 206 patches. This test was done on the git master  
branch (tagged 1.5.4.rc0). I did not change anything in the  
interactive rebase editor (just hit :wq in vim).

- Pieter
