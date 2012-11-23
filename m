From: Tobias Reuleaux <trx@ixsys.de>
Subject: cherry-pick and reset while merging
Date: Fri, 23 Nov 2012 20:00:39 +0100
Message-ID: <50AFC7D7.8040202@ixsys.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 20:11:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbyec-0008CM-Qc
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 20:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125Ab2KWTKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 14:10:55 -0500
Received: from mail.ixsys.de ([78.46.89.35]:59803 "EHLO bazaar.ixsys.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787Ab2KWTKy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 14:10:54 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Nov 2012 14:10:54 EST
Received: by bazaar.ixsys.de (Postfix, from userid 5001)
	id 9A955D016DB6; Fri, 23 Nov 2012 20:00:49 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on bazaar.ixsys.de
X-Spam-Level: 
X-Spam-Status: No, score=-102.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
	USER_IN_WHITELIST autolearn=ham version=3.3.1
Received: from [192.168.33.167] (office.ixsys.de [217.7.236.217])
	by bazaar.ixsys.de (Postfix) with ESMTPSA id D1209D016DB4
	for <git@vger.kernel.org>; Fri, 23 Nov 2012 20:00:39 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210270>

Hello everyone,

we recently switched to git and so far it's doing a terriffic job.
Today though, we had a problem that we couldn't figure until now.

We have a master, a develop and a refactor branch. Today we merged 
refactor into develop, which dramatically changes some source files. I 
needed to change only one line in master and develop afterwards.

So i changed it in develop and cherry picked it into master.

  $ git cherry-pick a165eb8c7b4306f349a9754102315195a17208ab

Got of course a conflict and also know that this was a bad idea. So i 
decided to reset this to HEAD and do a checkout from my HEAD after.

  $ git reset HEAD somefile
  $ git checkout -- somefile

After that i modified my line by hand in the file (so the original 
modification from develop wasn't there), made a diff afterwards (which 
only showed the modification of the one line) and committed my changes.

  $ git diff somefile
  $ git push

In the end the new file from develop was pushed to master, which isn't 
of course what i wanted.

What did i do wrong? Why does git reset to the develop HEAD during the 
merge? Why is the checkout of the file a version of the file before the 
cherry-picked commit? Why does my diff show only the one changed line?

A lot of questions i know. I'm totally new to git so can someone please 
help me!

Thank you in advance!

kind regards,

Tobias
