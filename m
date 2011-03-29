From: Edwin Amsler <edwinamsler@thinkboxsoftware.com>
Subject: Git not using logged in user for propfind
Date: Tue, 29 Mar 2011 12:01:41 -0500
Message-ID: <4D921075.1050208@thinkboxsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 19:01:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4cIf-0006wu-GO
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 19:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933Ab1C2RBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 13:01:43 -0400
Received: from smtp152.dfw.emailsrvr.com ([67.192.241.152]:43210 "EHLO
	smtp152.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753920Ab1C2RBn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 13:01:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp25.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id CE4092D0180
	for <git@vger.kernel.org>; Tue, 29 Mar 2011 13:01:42 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp25.relay.dfw1a.emailsrvr.com (Authenticated sender: edwinamsler-AT-thinkboxsoftware.com) with ESMTPSA id 7F88E2D039F
	for <git@vger.kernel.org>; Tue, 29 Mar 2011 13:01:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170280>

So, I set up a dandy non-ssl webshare on my server. SSL can come later 
once everything is configured right.

Git clones fine, but when it does a push and uses propfind, it decides 
to not use my username and so it gets a 401 not authorized error.

Here's output from my log. DAV works fine on everything I've tested on, 
it seems to be a git oopsie. Any ideas?

24.77.236.213 - -     [27/Mar/2011:18:21:47 -0500] "GET 
/dav/git/coral/info/refs?service=git-receive-pack HTTP/1.1" 401 409
24.77.236.213 - -     [27/Mar/2011:18:21:52 -0500] "GET 
/dav/git/coral/info/refs?service=git-receive-pack HTTP/1.1" 401 409
24.77.236.213 - edwin [27/Mar/2011:18:21:52 -0500] "GET 
/dav/git/coral/info/refs?service=git-receive-pack HTTP/1.1" 200 0
24.77.236.213 - edwin [27/Mar/2011:18:21:52 -0500] "GET 
/dav/git/coral/HEAD HTTP/1.1" 200 23
24.77.236.213 - -     [27/Mar/2011:18:21:52 -0500] "PROPFIND 
/dav/git/coral/ HTTP/1.1" 401 397
