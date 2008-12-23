From: "Paul Vincent Craven" <paul@cravenfamily.com>
Subject: Question with git push
Date: Tue, 23 Dec 2008 10:59:10 -0600
Message-ID: <5591393c0812230859n3b50b1f9k36153f40dd75ff57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 18:00:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFAcg-0003ip-Tf
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 18:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbYLWQ7M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 11:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbYLWQ7M
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 11:59:12 -0500
Received: from wf-out-1314.google.com ([209.85.200.172]:15611 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbYLWQ7M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 11:59:12 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2756166wfd.4
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 08:59:11 -0800 (PST)
Received: by 10.142.52.9 with SMTP id z9mr3224902wfz.327.1230051550461;
        Tue, 23 Dec 2008 08:59:10 -0800 (PST)
Received: by 10.142.177.16 with HTTP; Tue, 23 Dec 2008 08:59:10 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103834>

If I do a 'git push' to another repository, my changes are reverted
the next time that repository is updated, unless I do a hard reset on
the remote repository first. Of course, then I would lose my changes
in the remote repository. What is the correct way of handling this?

A quick example:

mkdir -p RepositoryA/files RepositoryB
cd RepositoryA/files
echo "Test file" > test1.txt
git init
git add .
git commit -a -m "Test Commit 1"
cd ../../RepositoryB
git clone ../RepositoryA/files
cd files
# I want this change to go to RepositoryA
echo "More data" >> test1.txt
git add .
git commit -a -m "Test Commit 2"
git push ../../RepositoryA/files
cd ../../RepositoryA/files
echo "Test file" > test2.txt
git add .
# This commit reverts test1.txt to not have "More data"
git commit -a -m "Test Commit 3" # This reverts test1.txt to not
git diff master^ master

How do I change my commands so I keep the change I made in RepositoryB?

Thanks,

-- 
Paul Vincent Craven

--
Paul Vincent Craven
http://www.cravenfamily.com
