From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Strange date format in git-send-email
Date: Wed, 05 Jul 2006 11:00:13 +0200
Organization: At home
Message-ID: <e8fv2o$khv$1@sea.gmane.org>
References: <200607050817.37366.martijn.kuipers@lx.it.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jul 05 11:00:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy3F8-0007rJ-J7
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 11:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWGEJAT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 05:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964773AbWGEJAT
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 05:00:19 -0400
Received: from main.gmane.org ([80.91.229.2]:30083 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964772AbWGEJAS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 05:00:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fy3F3-0007qq-3g
	for git@vger.kernel.org; Wed, 05 Jul 2006 11:00:17 +0200
Received: from host-81-190-27-124.torun.mm.pl ([81.190.27.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 11:00:17 +0200
Received: from jnareb by host-81-190-27-124.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 11:00:17 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-27-124.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23343>

Martijn Kuipers wrote:

> My email is sorted by date and a number of email-patches list the date format 
> as unknown (in kmail, that is).
> 
> When checking the headers of these mails I see the following pattern:
> 
> Date: mer, 05 jui 2006 00:36:08 +0200
> X-Mailer: git-send-email 1.4.1
> 
> Date: wto, 20 cze 2006 17:59:19 +0200
> X-Mailer: git-send-email 1.3.0
> 
> Date: Tue, Mar 14 12:12:35 2006 -0500
> User-Agent: send_patch 0.1
> 
> Date: Tue Feb 7 18:21:02 2006 +0100
[...]
> Is this my problem (or kmail), or is there something funny with 
> git-send-email? I just don't git it.

Yes, there was a problem with git-sen-email, namely it used strftime 
to print "Date:" header, but strftime is locale specific setting 
$ENV{LC_ALL} = 'C' is not enought.

There were two patches on the list: one hacky adding setlocale 
call (not applied), second implementing rfc-822 date in Perl.
Should be in current.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
