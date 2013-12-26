From: Yvonne Leroy <articulation7@gmail.com>
Subject: how to recovery corrupted git blob
Date: Thu, 26 Dec 2013 00:35:06 -0800 (PST)
Message-ID: <1388046906300-7601221.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 26 09:35:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vw6PR-0005qJ-9B
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 09:35:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab3LZIfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 03:35:08 -0500
Received: from sam.nabble.com ([216.139.236.26]:42247 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381Ab3LZIfG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 03:35:06 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <articulation7@gmail.com>)
	id 1Vw6PK-0007PO-9v
	for git@vger.kernel.org; Thu, 26 Dec 2013 00:35:06 -0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239686>

Hi all, 

I have a corrupted git repo.I've worked through the process 
https://git.wiki.kernel.org/index.php/GitFaq#How_to_fix_a_broken_repository.3F
<https://git.wiki.kernel.org/index.php/GitFaq#How_to_fix_a_broken_repository.3F> 
but still have some problem. 

1- at the beginning, with "git fsck --full", it showed: 

Checking object directories: 100% (256/256), done. 
dangling blob 13dcdade560f11e8bc2d865a0d4a1a1133e5b132 
dangling tree 5c9e60742ff24bb19fd73a8c1c879c4e10951b78 
missing blob 96209289c92e6ef0e6beb6ec1644f93981b00829 
dangling blob f61e50d30fa95683067aa2a50380e3dd7033e6dd 
dangling tree 95b5c5eeec8ac9359a31b268b938c142443d783a 
dangling commit d41b93032b34e380030207b5c8f502c6ecfd56ad 
dangling blob dae58bd96104c1292a20e1b8c8c948025e2e8924 
missing blob e187557d07857b974ea51e3ea962ac120cfc9488 

2- since I don't have a "broken link" message,I use $ git commit -m "fixing
git repo",it said: 

error: invalid object 100644 e187557d07857b974ea51e3ea962ac120cfc9488 for
'proje 
ct5/css/style.css' 
error: Error building trees 

3- and then   I use $ git hash-object -w project5/css/style.css, it said: 

git hash-object -w project5/css/style.css 
f61e50d30fa95683067aa2a50380e3dd7033e6dd 

the result is not the missing blob
(e187557d07857b974ea51e3ea962ac120cfc9488) 

4- so I use $ git log --raw --all --full-history -- project5/css/style.css,
it said: 


commit 7b5314a110b8e2835f7f3d068072429be87be574 
Merge: ec5e609 e415bb6 
Author: Yvonne Leroy <articulation7@gmail.com>
Date:   Sun Dec 15 23:40:41 2013 +0800 

    WIP on master: ec5e609 list 

commit e415bb6d51ee05d60055d89f2bf63ccb32f4c12c 
Author: Yvonne Leroy <articulation7@gmail.com>
Date:   Sun Dec 15 23:40:39 2013 +0800 

    index on master: ec5e609 list 

:100644 100644 595691a... e187557... M  project5/css/style.css 

commit ec76f78324632c3eebd874a724a9ebfe7d1f22ec 
Author: Yvonne Leroy <articulation7@gmail.com>
Date:   Sat Dec 7 14:48:37 2013 +0800 

    nav view 

:000000 100644 0000000... 595691a... A  project5/css/style.css 

5-here is my problem,how can I looking at those older and newer
versions(Could someone point me to which commands I should look at? Still
new to git:)) 
so that I can use the next step    git hash-object -w <recreated-file>
and could someone tell me what should I do with <recreated-file>,is it still
project5/css/style.css ? 

Thanks in advance, 
Yvonne. 




--
View this message in context: http://git.661346.n2.nabble.com/how-to-recovery-corrupted-git-blob-tp7601221.html
Sent from the git mailing list archive at Nabble.com.
