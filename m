From: Dave Zarzycki <zarzycki@apple.com>
Subject: Re: git-svn repo in weird state
Date: Thu, 18 Aug 2011 10:22:54 -0400
Message-ID: <2F128636-95A4-4216-894A-F0295A2D23EB@apple.com>
References: <85C67F68-AEF7-4E98-9388-C16BD04A68F8@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 16:23:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu3V0-0008DK-JI
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 16:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab1HROXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 10:23:05 -0400
Received: from mail-out.apple.com ([17.151.62.50]:46983 "EHLO
	mail-out.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab1HROXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 10:23:04 -0400
Received: from relay11.apple.com ([17.128.113.48])
 by mail-out.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPS id <0LQ400BISNXTK421@mail-out.apple.com> for git@vger.kernel.org;
 Thu, 18 Aug 2011 07:22:45 -0700 (PDT)
X-AuditID: 11807130-b7c45ae000001381-00-4e4d1fc1ef20
Received: from koseret (koseret.apple.com [17.151.62.39])
	(using TLS with cipher RC4-MD5 (RC4-MD5/128 bits))
	(Client did not present a certificate)	by relay11.apple.com (Apple SCV relay)
 with SMTP id 14.CB.04993.2CF1D4E4; Thu, 18 Aug 2011 07:20:50 -0700 (PDT)
Received: from [17.153.19.95] (unknown [17.153.19.95])
 by koseret.apple.com (Oracle Communications Messaging Exchange Server
 7u4-20.01 64bit (built Nov 21 2010))
 with ESMTPSA id <0LQ400CS3NXVKJ30@koseret.apple.com> for git@vger.kernel.org;
 Thu, 18 Aug 2011 07:22:44 -0700 (PDT)
In-reply-to: <85C67F68-AEF7-4E98-9388-C16BD04A68F8@apple.com>
X-Mailer: Apple Mail (2.1244.3)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsUiON1OXfeQvK+fweEDPBZdV7qZHBg9Pm+S
	C2CM4rJJSc3JLEst0rdL4Mr4e9iz4Alnxcu7S9kaGH+zdzFyckgImEj0TboFZYtJXLi3nq2L
	kYtDSKCTSaJt7VKwBK+AoMSPyfdYuhg5OJgF5CUOnpcFCTMLaEl8f9TKAlE/l0li4qNfLCAJ
	YQENiYMXl7GC2GxA9qdTd5lBbE4BW4ldm3ezgsxhEVCV+PiJC8TkFbCR6JomDlIhBGSemvke
	rFpEQFzi7fGZUKfJSyxu+cw4gZF/FpKDZiEcNAvJQQsYmVcxChal5iRWGhrqJRYU5KTqJefn
	bmIEBVZDocEOxrU/+Q8xCnAwKvHwPnjn7SfEmlhWXJl7iFGCg1lJhFdTxNdPiDclsbIqtSg/
	vqg0J7X4EKM0B4uSOO+G90DVAumJJanZqakFqUUwWSYOTqkGxhVSjYJCJ2yfTPT4Wnj+odPi
	Oy+PV935fCaseHnN+9Lj1pwNvw6wTrrXscElTz/0apCimWFOVNrBXxq7ZPp4D6rFfVJ7GPD+
	vPulGxN6tjaW68g4STOkXt1Qf+9aHafnfo61XQXWRh7f14tO1mCaI/RWdt+LRadYrnKWNk80
	qZf4FtE+++2EdiWW4oxEQy3mouJEAOGbvQMoAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179601>

After introspecting the .git directory, it seems like a stale .git/master was created somehow. Why does git-show-ref not show .git/master as a ref?


On Aug 18, 2011, at 10:14 AM, Dave Zarzycki wrote:

> I have a local git-svn repository that is now in a weird state and would any tips for how to debug this. Thanks!
> 
> davez
> 
> 
> 
> $ git --version
> git version 1.7.6
> $ git checkout master
> warning: refname 'master' is ambiguous.
> Already on 'master'
> $ git show-ref | grep master
> d510ee7a969c908a20ab8abab08dd3ad09870508 refs/heads/master
> $ git svn rebase
> warning: refname 'master' is ambiguous.
> First, rewinding head to replay your work on top of it...
> Fast-forwarded master to refs/remotes/svn/trunk.
> error: Ref refs/heads/master is at d510ee7a969c908a20ab8abab08dd3ad09870508 but expected 014cd21f9f6e88e4515ed99c632308a954085a34
> fatal: Cannot lock the ref 'refs/heads/master'.
> Could not move back to refs/heads/master
> rebase refs/remotes/svn/trunk: command returned error: 1
> 
> $ 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
