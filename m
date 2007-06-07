From: kurt_p_lloyd <kplloyd@alcatel-lucent.com>
Subject: Re: pull/merge --no-commit
Date: Thu, 07 Jun 2007 16:32:35 -0400
Message-ID: <46686B63.6080808@alcatel-lucent.com>
References: <46678909.10608@alcatel-lucent.com> <7vfy54qqu8.fsf@assigned-by-dhcp.cox.net> <46684EFD.1080804@alcatel-lucent.com> <alpine.DEB.0.99.0706080658070.6319@sleipnir.no.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Keith Duthie <keith@no.net.nz>, Junio C Hamano <gitster@pobox.com>,
	Kevin Green <Kevin.T.Green@morganstanley.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 22:33:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwOfM-0005VH-FZ
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 22:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935566AbXFGUc6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 16:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbXFGUc6
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 16:32:58 -0400
Received: from ihemail3.lucent.com ([135.245.0.37]:41767 "EHLO
	ihemail3.lucent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763593AbXFGUc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 16:32:58 -0400
Received: from homail.ho.lucent.com (h135-17-192-10.lucent.com [135.17.192.10])
	by ihemail3.lucent.com (8.13.8/IER-o) with ESMTP id l57KWaiO008834;
	Thu, 7 Jun 2007 15:32:36 -0500 (CDT)
Received: from cde1806.inse.lucent.com (cde1806.inse.lucent.com [152.148.202.141])
	by homail.ho.lucent.com (8.11.7p1+Sun/8.12.11) with ESMTP id l57KWZI16345;
	Thu, 7 Jun 2007 16:32:35 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.0 (X11/20070425)
In-Reply-To: <alpine.DEB.0.99.0706080658070.6319@sleipnir.no.net.nz>
X-Scanned-By: MIMEDefang 2.57 on 135.245.2.37
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49384>

Many thanks to Junio, Kevin, and Keith for the helpful comments.
I'll give some play time to all of these suggestions :)

One thing I was thinking might be useful would be a command to make
(just) my repository unavailable for 'fetch' or 'pull' from others,
temporarily.  And then a command to make it available again,
after I finish things that could end up needing "database" surgery,
like maybe something that could result in having to do a git reset.
I was thinking maybe something like:

   $ git config maintenance true
   .... do something that may end up needing "database" surgery
   $ git config maintenance false

Just an idea.  Of course, if something like this already exists ....
(I'd rather not shut down sshd, nor have to create a separate "public"
  repository (for certain types of "projects" anyway).)

-Kurt

Keith Duthie wrote:
> On Thu, 7 Jun 2007, kurt_p_lloyd wrote:
> 
>> Except here's the model that I am trying to follow....
>> It seems that 'pull' can be partitioned into 3 separate responsibilities:
>>
>>   1. Retrieve changes from the remote user's replica (without modifying
>>      any /local/ branches).
>>   2. Bring changes from "remote" into a local branch (without commit).
>>   3. Commit.
> 
> I believe you can accomplish step one with a remote tracking branch
> ("git-remote add localname git://whereever/project.git" to add the branch
> to the repository, then "git-remote update localname" to update it to the
> current remote state).
