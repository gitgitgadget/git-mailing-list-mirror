From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: git rebase --abort of an --onto run does not checkout the originating
 branch
Date: Fri, 22 Oct 2010 11:01:02 -0600
Message-ID: <4CC1C34E.8090203@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 22 19:01:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9KzU-0007u7-MK
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 19:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174Ab0JVRBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 13:01:08 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:58102 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758170Ab0JVRBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 13:01:05 -0400
Received: (qmail 20332 invoked by uid 399); 22 Oct 2010 11:01:02 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.196.217.129)
  by hsmail.qwknetllc.com with ESMTPAM; 22 Oct 2010 11:01:02 -0600
X-Originating-IP: 75.196.217.129
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.11) Gecko/20101013 Lightning/1.0b3pre Thunderbird/3.1.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159710>

'git rebase --abort' has documentation stating it will restore the 
original <branch>.  This works great for my basic usage of 'git rebase 
--interactive', for instance.

When running 'git rebase --onto', it does exactly what the documentation 
states, but the restored branch is not desirable.

To cherry pick a range of commits, I run:

git rebase --onto mybranch START_SHA END_SHA

In the middle, I decide to run 'git rebase --abort'.

Just as the documentation states, it performs a checkout of END_SHA as 
the restored branch.  END_SHA has nothing to do with the originating 
branch, and confusion ensues.

Is there a reason why 'git rebase' should not store off the originating 
branch and use that for an --abort, instead of <branch> which is END_SHA?

Thanks.

Josh
