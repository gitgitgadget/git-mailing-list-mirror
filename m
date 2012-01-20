From: Marc Herbert <Marc.Herbert+news@gmail.com>
Subject: git clone, hardlinks and multiple users?
Date: Fri, 20 Jan 2012 17:31:59 +0000
Message-ID: <jfc8eh$ck5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 22:55:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoMQQ-0006E8-CJ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 22:55:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755279Ab2ATVzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 16:55:05 -0500
Received: from lo.gmane.org ([80.91.229.12]:44042 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969Ab2ATVzE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 16:55:04 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RoMQJ-0006BW-8c
	for git@vger.kernel.org; Fri, 20 Jan 2012 22:55:03 +0100
Received: from irdmzpr01-ext.ir.intel.com ([192.198.151.36])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 22:55:03 +0100
Received: from Marc.Herbert+news by irdmzpr01-ext.ir.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 22:55:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: irdmzpr01-ext.ir.intel.com
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188905>

Hi,

   "git clone" is using hardlinks by default, even when cloning from a 
different user. In such a case the clone ends up with a number of files 
owned by someone else.

Since only immutable objects are cloned this seems to work fine. However 
I would like to know if this "multiple users" case works by chance or by 
specification.

In other words, is there a guarantee that no later version of git or no 
obscure option I haven't used yet will ever try to touch a hardlink in 
any way like for instance: trying update some metadata timestamp or, 
overwrite it with the same value by lack of optimization, or any other 
kind of side-effect that would obviously fail.

Thanks in advance!

Marc
