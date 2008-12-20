From: Mark Burton <markb@ordern.com>
Subject: Re: RFC: Change whatchanged to report changes from merges by
 default?
Date: Sat, 20 Dec 2008 17:22:52 +0000
Organization: Order N Ltd.
Message-ID: <20081220172252.6469d9b7@crow>
References: <20081220104232.5ff1b7c0@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 20 18:29:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE5dw-0004pr-5F
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 18:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbYLTRW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 12:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752771AbYLTRW4
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 12:22:56 -0500
Received: from c2bthomr13.btconnect.com ([213.123.20.131]:4516 "EHLO
	c2bthomr13.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbYLTRWz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 12:22:55 -0500
Received: from crow.ordern.com (host86-128-197-104.range86-128.btcentralplus.com [86.128.197.104])
	by c2bthomr13.btconnect.com
	with ESMTP id CAF40999;
	Sat, 20 Dec 2008 17:22:53 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 1C612190CDE
	for <git@vger.kernel.org>; Sat, 20 Dec 2008 17:22:53 +0000 (GMT)
In-Reply-To: <20081220104232.5ff1b7c0@crow>
X-Mailer: Claws Mail 3.6.1 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2bthomr13.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0208.494D29ED.01DD,ss=1,fgs=0,
	ip=86.128.197.104,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103652>


Hi,

On further studying, I see that 1aec7917dc (git log: don't do merge
diffs by default) makes git log only show the log message by default
for merges. OK, no problem with that. 

However, in my mind, whatchanged is misleading when it doesn't output
anything (by default) for merges because, in my mind, that implies that
nothing has changed when, in fact, whole heaps of stuff could have been
merged in. So, if you forget to add the -m option, whatchanged will silently
ignore all the merged stuff and leave the poor user in the dark.

So, if changing the default behaviour is acceptable, I still think it would
be better if ignore_merges is set to 0 in cmd_whatchanged() but I guess an
alternative would be to set always_show_header, instead.

Any thoughts?

Cheers,

Mark
