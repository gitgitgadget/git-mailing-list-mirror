From: Denis Rosset <dr@racontemoi.ch>
Subject: Git reproducible corruption errors on merge/checkout not detected by git fsck --full --strict
Date: Sun, 27 Dec 2009 22:59:04 +0100
Message-ID: <501B634A-02B3-4F30-8E36-3AE76BA7A0D8@racontemoi.ch>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 27 23:05:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP1FM-0004Di-Oe
	for gcvg-git-2@lo.gmane.org; Sun, 27 Dec 2009 23:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbZL0WFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 17:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbZL0WFw
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 17:05:52 -0500
Received: from 42.mail-out.ovh.net ([213.251.189.42]:48566 "HELO
	42.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750913AbZL0WFv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 17:05:51 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Dec 2009 17:05:51 EST
Received: (qmail 21751 invoked by uid 503); 27 Dec 2009 21:59:23 -0000
Received: from b7.ovh.net (HELO mail415.ha.ovh.net) (213.186.33.57)
  by 42.mail-out.ovh.net with SMTP; 27 Dec 2009 21:59:23 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 27 Dec 2009 21:59:08 -0000
Received: from adsl-84-227-203-117.adslplus.ch (HELO ?192.168.1.20?) (dr%racontemoi.ch@84.227.203.117)
  by ns0.ovh.net with SMTP; 27 Dec 2009 21:59:05 -0000
X-Mailer: Apple Mail (2.936)
X-Ovh-Tracer-Id: 15612009583848284382
X-Ovh-Remote: 84.227.203.117 (adsl-84-227-203-117.adslplus.ch)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135717>

Hi all !

I use git regularly since twelve months; on one specific repository, I  
had repetitive "inflate: data stream error (incorrect data check)"  
errors. These errors appear when checking out from one branch to  
another or when merging; however doing a "git fsck --full --strict" on  
either the local repository or the remote repository before the  
operation does not show anything wrong.

The bare repository is located on a Mac OS X 10.5 PPC server with Git  
1.5.X.Y (X, Y not known), the local client is Git 1.6.6 installed  
through MacPorts. I am stuck with Git 1.6.6 due to the MacPorts  
architecture. Local zlib is 1.2.3_3.

I created a new local repository, reimported the files manually (only  
the files, losing all the history in the process), and errors happen  
again. The errors seems to appear when Git creates a local pack to  
store the object files.

I am now installing Macports git 1.6.6 on the server to do further  
testing.

My questions :

1) is "git fsck --full --strict" the most comprehensive check I can do  
on a repository ?
2) are there known bugs leading to data corruption in the git 1.6.6  
prerelease and/or zlib 1.2.3_3 ?
3) is there a verbose flag or a log I can consult (and eventually send  
to this list) ?

Kind regards,

Denis Rosset
