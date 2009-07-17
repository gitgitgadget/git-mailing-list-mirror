From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: how to fetch a new svn branch after clone?
Date: Fri, 17 Jul 2009 12:09:24 -0400
Message-ID: <4A60A234.5020907@xiplink.com>
References: <eafc0afe0907160830m29e2f3d3jf5c0e9db29cace54@mail.gmail.com> 	<4A5F8CDA.5080202@xiplink.com> <eafc0afe0907161900k35b2dff1u5a2bfc574bb93231@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Changsheng Jiang <jiangzuoyan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 18:11:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRq1m-0001PQ-QX
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 18:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbZGQQLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 12:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbZGQQLK
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 12:11:10 -0400
Received: from smtp152.iad.emailsrvr.com ([207.97.245.152]:41811 "EHLO
	smtp152.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964871AbZGQQLK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 12:11:10 -0400
Received: from relay5.relay.iad.emailsrvr.com (localhost [127.0.0.1])
	by relay5.relay.iad.emailsrvr.com (SMTP Server) with ESMTP id 0204F5C0329;
	Fri, 17 Jul 2009 12:11:07 -0400 (EDT)
Received: by relay5.relay.iad.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id D0A635C01D7;
	Fri, 17 Jul 2009 12:11:07 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <eafc0afe0907161900k35b2dff1u5a2bfc574bb93231@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123471>

Changsheng Jiang wrote:
> Thank Marc.
> 
> You are right, it should be the latter case with url
> http://www.example.com/project/branches/test

Hmmm, that isn't a case I mentioned in my previous email.  Are you saying that the layout is actually

	http://www.example.com/project/branches/<some branches>
	http://www.example.com/project/branches/test/<some other branches>

If that's the case I think you might be stuck.  I think git-svn can't handle that layout (with branch names under both branches/ and branches/test/).

> But "git svn clone" has already added these lines to .git/config
> 
> [svn-remote "svn"]
> 	url = https://xxx.xxxx.com/svn/xxx
> 	fetch = trunk:refs/remotes/trunk
> 	branches = branches/*:refs/remotes/*
> 	tags = tags/*:refs/remotes/tags/*
> 
> And it still can not fetch new branch.

Yes.  If you had a layout that git-svn supported, you would need to add a _second_ branches line.

		M.
