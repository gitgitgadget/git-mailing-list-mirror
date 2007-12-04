From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: git guidance
Date: Tue, 04 Dec 2007 17:21:28 -0500
Message-ID: <4755D2E8.5050402@cfl.rr.com>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com> <alpine.LFD.0.9999.0711290810170.8458@woody.linux-foundation.org> <200712010950.15628.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755119AbXLDWVq@vger.kernel.org Tue Dec 04 23:22:48 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755119AbXLDWVq@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzgAB-0001aE-9V
	for glk-linux-kernel-3@gmane.org; Tue, 04 Dec 2007 23:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755119AbXLDWVq (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 4 Dec 2007 17:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752846AbXLDWV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Dec 2007 17:21:27 -0500
Received: from iriserv.iradimed.com ([72.242.190.170]:18321 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752219AbXLDWV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Dec 2007 17:21:26 -0500
Received: from [10.1.1.235] ([10.1.1.235]) by iradimed.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 4 Dec 2007 17:21:40 -0500
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <200712010950.15628.a1426z@gawab.com>
X-OriginalArrivalTime: 04 Dec 2007 22:21:40.0518 (UTC) FILETIME=[0AF1FC60:01C836C4]
X-TM-AS-Product-Ver: SMEX-7.5.0.1243-5.0.1023-15586.001
X-TM-AS-Result: No--9.637500-5.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67093>

Al Boldi wrote:
> Judging an idea, based on a flawed implementation, doesn't prove that the 
> idea itself is flawed.

It isn't the implementation that is flawed, it is the idea.  The entire 
point of a change control system is that you explicitly define change 
sets and add comments to the set.  The filesystem was designed to allow 
changes to be made willy-nilly.  If your goal is to perform change 
control only with filesystem semantics, then you have a non starter as 
their goals are opposing.  Requiring an explicit command command is 
hardly burdensome, and otherwise, a git tree is perfectly transparent to 
non git aware tools.

> Sure, you wouldn't want to change the git-engine update semantics, as that 
> sits on the server and handles all users.  But what the git model is 
> currently missing is a client manager.  Right now, this is being worked 
> around by replicating the git tree on the client, which still doesn't 
> provide the required transparency.

It isn't missing a client manager, it was explicitly designed to not 
have one, at least not as a distinct entity from a server, because it 
does not use a client/server architecture.  This is very much by design, 
not a work around.

What transparency are you requiring here?  You can transparently read 
your git tree with all non git aware tools, what other meaning of 
transparency is there?

> IOW, git currently only implements the server-side use-case, but fails to 
> deliver on the client-side.  By introducing a git-client manager that 
> handles the transparency needs of a single user, it should be possible to 
> clearly isolate update semantics for both the client and the server, each 
> handling their specific use-case.

Any talk of client or server makes no sense since git does not use a 
client/server model.  If you wish to use a centralized repository, then 
git can be set up to transparently push/pull to/from said repository if 
you wish via hooks or cron jobs.

