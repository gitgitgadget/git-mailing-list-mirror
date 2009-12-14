From: Richard Rossel <rrossel@inf.utfsm.cl>
Subject: git gc logs to standard error
Date: Mon, 14 Dec 2009 11:45:15 -0300
Message-ID: <4B264F7B.8070504@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 14 16:28:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1NKCqa-0000yk-M3
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 16:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757522AbZLNPYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 10:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757519AbZLNPYL
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 10:24:11 -0500
Received: from alegre.inf.utfsm.cl ([204.87.169.3]:46858 "EHLO
	alegre.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757525AbZLNPYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 10:24:10 -0500
X-Greylist: delayed 2328 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Dec 2009 10:24:10 EST
Received: from trompe.intra.wiseocean.cl (red-corfo.tecnoera.net [200.24.238.226] (may be forged))
	(authenticated bits=0)
	by alegre.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id nBEEjFSh001138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 14 Dec 2009 11:45:16 -0300
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
X-Virus-Scanned: ClamAV 0.94.2/10164/Mon Dec 14 10:49:22 2009 on alegre.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RDNS_NONE
	autolearn=no version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on alegre.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135217>

Hi,
I have a question related to the output of git gc logs. Let me explain,

I have a git commands in crontab (for redmine purpose) doing this stuff:
' git fetch -q origin && git reset -q --soft refs/remotes/origin/master '
for each project.

The problem is that am getting mail from crontab each time that somebody
do a push to the central server. Its really annoying. I try to avoid 
those messages
redirecting the standard output with no results, then adding a quiet 
option  and no results.
This is the kind of mails that am receiving:


remote: Counting objects: 6, done.
remote: Compressing objects:  25% (1/4)
remote: Compressing objects:  50% (2/4)
remote: Compressing objects:  75% (3/4        )remote:
remote: Compressing objects: 100% (4/4)
remote: Compressing objects: 100% (4/4), done.
remote: Total 4 (delta 2), reused 0 (delta 0)
 From git@boss:drivings
   0f35f06..5bc8866  master     -> origin/master


Then I realized that the message is git gc logs looks like, so I did:

$ git gc
Counting objects: 51, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (35/35), done.
Writing objects: 100% (51/51), done.
Total 51 (delta 12), reused 51 (delta 12)

The message are pretty similar, so I sent the logs to dev/null but:

$ git gc >/dev/null
Counting objects: 51, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (35/35), done.
Writing objects: 100% (51/51), done.
Total 51 (delta 12), reused 51 (delta 12)

I realized that the message are sent to standard error,
so the question is why is the reason to do that?

The quick solution to my problem of annoying mails is send the output 
error to /dev/null
but what happens when an error really occur, there will be no message to 
alert me.

thanks for your help

saludos.-

--
Richard Rossel
Software Engineer at Airsage Inc.
Valparaiso - Chile
