From: adatoccpptranslator@free.fr
Subject: Issue when merging a subtree whose a file has been removed
Date: Thu, 21 May 2015 14:49:30 +0200 (CEST)
Message-ID: <932593700.419144884.1432212570125.JavaMail.root@zimbra41-e7.priv.proxad.net>
References: <2074448442.419140473.1432212498797.JavaMail.root@zimbra41-e7.priv.proxad.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_419144882_759356076.1432212570122"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 14:49:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvPux-0004c5-3e
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 14:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbbEUMth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 08:49:37 -0400
Received: from smtpfb1-g21.free.fr ([212.27.42.9]:50589 "EHLO
	smtpfb1-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbbEUMtg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 08:49:36 -0400
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id 5007D77D4FE
	for <git@vger.kernel.org>; Thu, 21 May 2015 14:49:31 +0200 (CEST)
Received: from zimbra41-e7.priv.proxad.net (unknown [172.20.243.191])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5B7119400AA
	for <git@vger.kernel.org>; Thu, 21 May 2015 14:46:05 +0200 (CEST)
In-Reply-To: <2074448442.419140473.1432212498797.JavaMail.root@zimbra41-e7.priv.proxad.net>
X-Originating-IP: [164.129.115.76, 77.242.202.228]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Win)/7.2.0-GA2598)
X-Authenticated-User: adatoccpptranslator@free.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269581>

------=_Part_419144882_759356076.1432212570122
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi all, ( sorry for possible the double mail, the first one seems could have been rejected by server due to sh scripts in attachment),

 

I want to use subtrees in one of my projects and I use method desribed here https://git-scm.com/book/en/v1/Git-Tools-Subtree-Merging
I`m facing issues when merging subtree in my subproject in case some files have been removed from the subtree.

I`m running git 1.9.1 on Kubuntu  14.04
sub_project is integrated as subtree in my main project. I modify a file and remove an other file from my sub_project, commit the modification, go in my main_project, checkout the sub_project integration branch, pull the modification.
I see the modification of the modified file and the deletion of the removed file
I checkout the master branch of my main project.
git diff-tree -p sub_project_branch indicate that one file has been modified and one files has been deleted
then I perform a merge of my subtree integration branch into master branch.

I was expecting to see the in master the modification of the file and the deletion of the other file but the removed file is still there and tracked. The modification of file has been done but It looks like the deletion has not been "merged".
The test case can be reproduced using run_subtree.sh attached script

The behaviour I expect is the same that the one illustrated in run.sh which perform exactly the same actions excepted they are done in a branch instead of a subtree:
toto should have been modified, tata should no more be there or at least no more be tracked

According to what I see it seems that the subtree merge is doing a kind of copy instead of a real merge meaning that if source file disappear then the corresponding target file is untouched instead of being deleted.
Is this behaviour correct or is it my understanding of what subtree merge should do that is wrong ?


Thanks by advance
Julien

PS : as my subtree prefix has 2 levels I also test with a single level like in subtree tutorial to ensure this was not the cause of my issue but the problem remains the same. the single level test is performed by run_simple_subtree.sh
------=_Part_419144882_759356076.1432212570122
Content-Type: application/zip; name=scripts.zip
Content-Disposition: attachment; filename=scripts.zip
Content-Transfer-Encoding: base64

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
BQYAAAAAAwADAB8BAACNBQAAAAA=
------=_Part_419144882_759356076.1432212570122--
