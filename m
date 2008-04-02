From: Jake Goulding <goulding@vivisimo.com>
Subject: [REQ] Better error reporting when git rebase cannot rebase
Date: Wed, 02 Apr 2008 11:44:10 -0400
Message-ID: <47F3A9CA.9090307@vivisimo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 02 18:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jh5U1-0002vt-8a
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 18:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbYDBQF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 12:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755116AbYDBQF4
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 12:05:56 -0400
Received: from scalix.vivisimo.com ([207.97.211.28]:42997 "EHLO
	mail.vivisimo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819AbYDBQFz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 12:05:55 -0400
X-Greylist: delayed 1303 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Apr 2008 12:05:55 EDT
Received: from mail.office.vivisimo.com (mail.office.vivisimo.com [206.210.75.84])
	by mail.vivisimo.com (Postfix) with ESMTP id AA04E851378
	for <git@vger.kernel.org>; Wed,  2 Apr 2008 11:44:11 -0400 (EDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.office.vivisimo.com (Postfix) with ESMTP id 7D8072EE886
	for <git@vger.kernel.org>; Wed,  2 Apr 2008 11:44:11 -0400 (EDT)
X-Virus-Scanned: amavisd-new at vivisimo.com
Received: from mail.office.vivisimo.com ([127.0.0.1])
	by localhost (office.mail.vivisimo.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R3yyDjHFs+ga for <git@vger.kernel.org>;
	Wed,  2 Apr 2008 11:44:10 -0400 (EDT)
Received: from [192.168.0.20] (unknown [192.168.0.20])
	by mail.office.vivisimo.com (Postfix) with ESMTP id CE6102EE885
	for <git@vger.kernel.org>; Wed,  2 Apr 2008 11:44:10 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.12 (X11/20080304)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78698>

Right now, if you have modified files in the working directory and 
attempt to do a git rebase, you will see messages like:

$ git rebase origin/master
Makefile: needs update

However, it isn't always clear that that means the rebase *did not 
work*. This has bitten a few of my developers a few times when they 
think that a rebase worked and that they need to perform some sort of 
"update" to the files in question.

I would suggest making this more explicit:

$ git rebase origin/master
* error: rebasing branch master on branch origin/master failed
Makefile: uncommitted changes would be overwritten

Thanks!

-Jake
