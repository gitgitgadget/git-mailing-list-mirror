From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: Global .git directory
Date: Tue, 27 Apr 2010 07:14:13 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004270705280.15197@bbs.intern>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 07:28:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6dLY-00047Z-Dw
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 07:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095Ab0D0F2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 01:28:31 -0400
Received: from chello084112167138.7.11.vie.surfer.at ([84.112.167.138]:56320
	"EHLO wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab0D0F2a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 01:28:30 -0400
Received: from bbs.intern (localhost [127.0.0.1])
	by wiesinger.com (8.14.4/8.14.4) with ESMTP id o3R5EDhL016651
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 07:14:13 +0200
Received: from localhost (gerhard@localhost)
	by bbs.intern (8.14.4/8.14.4/Submit) with ESMTP id o3R5EDOC016646
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 07:14:13 +0200
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-MailScanner-Information-wiesinger-com: Please contact the ISP for more information
X-wiesinger-com-MailScanner-ID: o3R5EDhL016651
X-MailScanner-wiesinger-com: Found to be clean
X-MailScanner-SpamCheck-wiesinger-com: not spam, SpamAssassin (not cached,
	score=-4.345, required 4.5, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 0.05, BAYES_00 -2.60)
X-MailScanner-From: lists@wiesinger.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145877>

Hello,

I'm new to git and as far as I saw that feature is missing: Placing .git 
directory/repository on a central place for many git repositories. This 
feature ensures that data directories are kept clean from metadata of git.

I know the GIT_DIR environment variable but therefore environment has to 
be set for each repository which is IHMO not practicable. Therefore I 
suggest the following approach (which also overrides GIT_DIR when set):
#  Can be set globally for all users
export GIT_GLOBAL_DIR=$HOME/.git_global

When this environment variable is set git searches the repository in 
$HOME/.git_global/`pwd`
Example:
cd /home/gerhard/myproject
=> /home/gerhard/.git_global/home/gerhard/myproject/.git directory is used
cd /home/gerhard/myproject/subdir
=> /home/gerhard/.git_global/home/gerhard/myproject/.git directory is 
still used, base directory must also be searched for (algorithm must 
already be implemented)

I think this should be easy to implement on a centralized point.

Any feedback is welcome.

Thnx.

Ciao,
Gerhard

--
http://www.wiesinger.com/
