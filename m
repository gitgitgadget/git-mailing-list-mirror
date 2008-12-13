From: nadim khemir <nadim@khemir.net>
Subject: Adding Exit status documentation to all git commands starting with git status
Date: Sat, 13 Dec 2008 20:36:39 +0100
Message-ID: <200812132036.39318.nadim@khemir.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 13 20:36:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBaHu-000831-QK
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 20:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbYLMTfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2008 14:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbYLMTfM
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Dec 2008 14:35:12 -0500
Received: from mail1.perspektivbredband.net ([81.186.254.13]:33689 "EHLO
	mail1.perspektivbredband.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751211AbYLMTfL (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Dec 2008 14:35:11 -0500
Received: from khemir.net (h51bafc0a.c46-01-06.sta.perspektivbredband.net [81.186.252.10])
	by mail1.perspektivbredband.net (Postfix) with ESMTP id 73D0894009A
	for <git@vger.kernel.org>; Sat, 13 Dec 2008 20:35:09 +0100 (CET)
Received: from naquadim.khemir.lan (naquadim.khemir.lan [192.168.1.234])
	by khemir.net (Postfix) with ESMTP id AA20D1264002
	for <git@vger.kernel.org>; Sat, 13 Dec 2008 20:35:08 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,
	UNPARSEABLE_RELAY autolearn=ham version=3.2.5-gr0
X-Spam-Checker-Version: SpamAssassin 3.2.5-gr0 (2008-06-10) on firewall
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103015>

I was asking on the irc channel about how to know if I need to commit. I 
promptely got answered but during the discussion, the few of us still awake 
in the middle of the night (for me at least), agreed that it would be good to 
have a EXIT STATUS in all the commands documentation starting with 
the 'status' command.

The current documentation of 'git status' does cover exit status and looks 
like:
<original>
...
shows what would be committed if the same options are given to
'git-commit'.

If there is no path that is different between the index file and
the current HEAD commit (i.e., there is nothing to commit by running
`git commit`), the command exits with non-zero status.


OUTPUT
------
</original>

There are different styles to add exit status, give me your input on why and 
why not using one or the other. I list 3 solutions and what I think about 
them.

<solution 1, least change, easier to recognize although all the negations and 
the explaination being about when the command ~fails~ makes newbies head spin 
for a few seconds>

...
shows what would be committed if the same options are given to
'git-commit'.

EXIT STATUS
-----------
The command exits with non-zero status if there is no path that is 
different between the index file and the current HEAD commit (i.e.,
there is nothing to commit by running `git commit`).


OUTPUT
------
</solution 1>



<solution 2, both zero and non zero status>

...
shows what would be committed if the same options are given to
'git-commit'.

EXIT STATUS
-----------
Zero status:      There is a different between the index file and HEAD.
Non-zero status:  There is nothing to commit by running `git commit`. 


OUTPUT
------
</solution 2>



<solution 3, Only zero status, non zero is easilly deducted. Clearest IMO>

...
shows what would be committed if the same options are given to
'git-commit'.

EXIT STATUS
-----------
Zero status: There is a different between the index and HEAD; running 
`git commit` would create a new commit. 


OUTPUT
------
</solution 3>



A few things could be better explained:
	- The command is to be run with '-a' as option. 
	- The fact that non add'ed files are not taken into account is not
completely obvious. The first paragraph of the DESCRIPTION explains it but it  
is not the clearest explaination ever (maybe because it's not easy to explain 
and man pages are references not user manuals)

Cheers, Nadim.
