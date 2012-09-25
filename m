From: xmeng@cs.wisc.edu
Subject: A generalization of git blame
Date: Tue, 25 Sep 2012 13:14:39 -0500
Message-ID: <89ccf5dd776edc648d488c20214e1105.squirrel@webmail.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 20:22:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGZmR-0001eY-PG
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 20:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab2IYSWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 14:22:12 -0400
Received: from sandstone.cs.wisc.edu ([128.105.6.39]:36627 "EHLO
	sandstone.cs.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab2IYSWM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 14:22:12 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Sep 2012 14:22:12 EDT
Received: from webmail.cs.wisc.edu (slappy.cs.wisc.edu [128.105.7.37])
	by sandstone.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id q8PIEc9l018645
	for <git@vger.kernel.org>; Tue, 25 Sep 2012 13:14:39 -0500
Received: from 128.105.14.84
        (SquirrelMail authenticated user xmeng)
        by webmail.cs.wisc.edu with HTTP;
        Tue, 25 Sep 2012 13:14:39 -0500
User-Agent: SquirrelMail/1.4.22
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206370>




Hi,

I have been developing my git tool (based on the git internal API) that
can find out all the commits that have changed a line for better
authorship.

The reason is for my binary code authorship research, I use machine
learning to classify code authorship. To produce training data, I start
with a source code repository with well-known author labels for each line
and then compiling the project into binary. So, I am able to know the
authorship for binary code and then apply some machine learning
techniques.

To get ground truth of authorship for each line, I start with git-blame.
But later I find this is not sufficient because the last commit may only
add comments or may only change a small part of the line, so that I
shouldn't attribute the line of code to the last author. Of course, there
must be some debates on who can be the representative of a line of code.
So what I would like to do is find out all the commits that have ever
changed a line, then I can try different approaches to summarize over all
these commits to produce my final authorship label (or even tuple).

I was wondering whether there have been similar debates over accurate
authorship in this community before and whether there may be other people
interested in this work.

Thanks

--Xiaozhu
