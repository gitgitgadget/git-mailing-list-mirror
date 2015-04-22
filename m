From: edgar.hipp@netapsys.fr
Subject: Proposal for git stash : add --staged option
Date: Wed, 22 Apr 2015 10:30:26 +0200
Message-ID: <96c00a316c79d9e5a85e199ba7d6f317@netapsys.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 10:35:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykq8S-000435-Bt
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 10:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934381AbbDVIfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 04:35:51 -0400
Received: from smtp.netapsys.fr ([5.135.55.152]:41294 "EHLO mx01.netapsys.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756276AbbDVIfs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 04:35:48 -0400
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2015 04:35:48 EDT
Received: from localhost (localhost [127.0.0.1])
	by mx01.netapsys.fr (Postfix) with ESMTP id 98A0427B44
	for <git@vger.kernel.org>; Wed, 22 Apr 2015 10:30:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mx01.netapsys.fr
Received: from mx01.netapsys.fr ([127.0.0.1])
	by localhost (mx01.netapsys.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aIuDPRgHnOfM for <git@vger.kernel.org>;
	Wed, 22 Apr 2015 10:30:26 +0200 (CEST)
Received: from webmail.ovh.netapsys.fr (unknown [5.135.55.138])
	by mx01.netapsys.fr (Postfix) with ESMTPA id 6910E27B40
	for <git@vger.kernel.org>; Wed, 22 Apr 2015 10:30:26 +0200 (CEST)
X-Sender: edgar.hipp@netapsys.fr
User-Agent: Roundcube Webmail/1.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267581>

Hello,

There's some feature of git that I have been missing.
When you have a lot of unstaged files, and would like to test what 
happens if you undo some of the changes that you think are unecessary, 
you would rather keep a copy of those changes somewhere.

For example

Changed but not updated:
     M config_test.xml
     M config_real.xml

I have changed both config_test.xml and config_real.xml, but I think the 
changes made in config_test.xml are unnecessary. However, I would still 
like to keep them somewhere in case it breaks something.

In this case for example, I would like to be able to stash only the file 
config_test.xml

Eg:

git add config_test.xml
git stash --staged

So that after this, my git looks like this:

Changed but not updated:
     M config_real.xml

and my stash contains only the changes introduced in config_test.xml

`git stash --keep-index` doesn't give the necessary control, because it 
will still stash everything (and create unnecessary merge complications 
if I change the files and apply the stash)

Best,

Edgar
