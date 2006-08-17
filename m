From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: use action dispatcher for non-project actions, too.
Date: Thu, 17 Aug 2006 22:00:50 +0200
Organization: At home
Message-ID: <ec2hrj$a37$1@sea.gmane.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <11557673212235-git-send-email-tali@admingilde.org> <1155767325181-git-send-email-tali@admingilde.org> <11557673263081-git-send-email-tali@admingilde.org> <11557673262714-git-send-email-tali@admingilde.org> <11557673281583-git-send-email-tali@admingilde.org> <ec1dis$823$3@sea.gmane.org> <20060817194913.GD11477@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 17 22:00:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDo2G-0007a5-H5
	for gcvg-git@gmane.org; Thu, 17 Aug 2006 22:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWHQUAI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Aug 2006 16:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWHQUAH
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Aug 2006 16:00:07 -0400
Received: from main.gmane.org ([80.91.229.2]:3735 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030227AbWHQUAG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Aug 2006 16:00:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GDo1z-0007We-OQ
	for git@vger.kernel.org; Thu, 17 Aug 2006 21:59:56 +0200
Received: from host-81-190-26-94.torun.mm.pl ([81.190.26.94])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 21:59:55 +0200
Received: from jnareb by host-81-190-26-94.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Aug 2006 21:59:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-94.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25611>

Martin Waitz wrote:

> hoi :)
> 
> On Thu, Aug 17, 2006 at 11:41:43AM +0200, Jakub Narebski wrote:
>> > Project list and OPML generation are now hooked into the list as
>> > "/summary" and "/opml".
>> 
>> It would be better to use "/list" or "/projects", although empty or 
>> undef or "/" action would work as well.
>> 
>> Having both "/summary" (for projects list) and "summary" (for project
>> summary) is bad, bad idea.
> 
> well, it was a little trick so that only one default action "summary"
> is needed.  I have no strong feelings about it so any other name is
> good for me, too.

if (defined $project) { # with the patch that undef $project when empty
        $action ||= "summary";
} else {
        $action ||= "/projects_list"; # or simply "projects_list", or "/"
}

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
