From: Frank <streamlake@tiscali.it>
Subject: Cygwin: problem with renaming and case
Date: Fri, 21 Mar 2008 17:07:04 +0100
Message-ID: <47E3DD28.4030302@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 17:23:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jck1L-00088q-62
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 17:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754740AbYCUQW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 12:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754185AbYCUQW0
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 12:22:26 -0400
Received: from smtp-out28.alice.it ([85.33.2.28]:4667 "EHLO
	smtp-out28.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbYCUQWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 12:22:25 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Mar 2008 12:22:24 EDT
Received: from FBCMMO01.fbc.local ([192.168.68.195]) by smtp-out28.alice.it with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Mar 2008 17:07:07 +0100
Received: from FBCMCL01B04.fbc.local ([192.168.69.85]) by FBCMMO01.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Mar 2008 17:07:07 +0100
Received: from [192.0.0.91] ([82.50.146.159]) by FBCMCL01B04.fbc.local with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 21 Mar 2008 17:07:06 +0100
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
X-OriginalArrivalTime: 21 Mar 2008 16:07:06.0495 (UTC) FILETIME=[9BFF38F0:01C88B6D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77747>

Hi,
Don't know exactly if this is a bug or a feature or something in the 
middle, but I have a lot of problems while changing just the casing of 
file names and using git mv und cygwin. Here's a test case:

mkdir testrename
cd testrename
git init
echo "AAA" >aaa.txt
echo "BBB" >bbb.txt
git add aaa.txt
git add bbb.txt
git commit -m "First commit"
git checkout -b new_branch
git mv aaa.txt ccc.txt
git commit -a -m "Moved file"
echo "NEW AAA" >Aaa.txt
git add Aaa.txt
git commit -m "Added Aaa"
#aaa.txt exists in master, Aaa.txt in new_branch
git checkout master

Last command gives: "fatal: Untracked working tree file 'aaa.txt' would 
be overwritten by merge".
I know I can use git checkout -f but the problem returns while others do 
merging/pulling from my repo, etc.
Thanks,
Frank
