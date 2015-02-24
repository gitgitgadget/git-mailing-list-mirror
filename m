From: Mauro Condarelli <mc5686@mclink.it>
Subject: [bug?] renamed file loses changes in merge.
Date: Tue, 24 Feb 2015 16:33:42 +0100
Message-ID: <54EC99D6.9010307@mclink.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 16:49:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQHjV-0001GT-63
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 16:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbbBXPsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 10:48:52 -0500
Received: from relaygw3-17.mclink.it ([77.43.14.243]:36847 "EHLO
	relaygw3-17.mclink.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbbBXPsv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 10:48:51 -0500
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Feb 2015 10:48:51 EST
Received: from [195.110.128.82] (HELO smtpoutgw2.mclink.it)
  by relaygw3-17.mclink.it (CommuniGate Pro SMTP 6.0.6)
  with ESMTP id 45298737 for git@vger.kernel.org; Tue, 24 Feb 2015 16:33:45 +0100
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DhAQBhmexU/7T8/l8NTrRtBQEBAQEBAQaaLgEBAQEBAYVKQD0WGAMCAQIBWAgBAYgwuleaE4YHiheEFQWZG5M3giQcgVGDMQEBAQ
Received: from host180-252-static.254-95-b.business.telecomitalia.it (HELO [192.168.7.124]) ([95.254.252.180])
  by smtpoutgw2.mclink.it with ESMTP; 24 Feb 2015 16:33:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264331>

I'm unsure it is a bug or a misuse on my part, but:

Situation:

There are two distinct repositories (upstream & local), local is a fork of upstream (at tag "v3.7").
Both repositories were modified (upstream has delivered new version with tag "v3.7.1").
I need to incorporate local changes into the new upstream release.

I did the following:

git clone upstream
git checkout v3.7.1 -b v3.7.1_local                       (I do not want anything later than that)
git remote add local ../local/.git
git fetch local
git merge local/current
... resolve conflicts ...
git ad --all
git commit -m ...

At this point I discovered that one specific file:
was renamed in upstream
was changed in local

What I have on my workspace is the *renamed* file *without* the modifications from local.

Is this the normal behavior?
If so I fail to understand the rationale behind it; I would expect git to apply changes to the renamed file.

Thanks in Advance
Mauro
