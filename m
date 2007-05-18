From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Opinions on bug fix organisation
Date: Fri, 18 May 2007 10:11:44 +0200
Organization: eudaptics software gmbh
Message-ID: <464D5FC0.3BBF977F@eudaptics.com>
References: <200705161138.30134.andyparkins@gmail.com> <7v1whgfybe.fsf@assigned-by-dhcp.cox.net> <200705162220.15417.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 10:11:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoxYh-0006w6-SM
	for gcvg-git@gmane.org; Fri, 18 May 2007 10:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbXERILZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 04:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbXERILZ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 04:11:25 -0400
Received: from main.gmane.org ([80.91.229.2]:47092 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745AbXERILX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 04:11:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HoxYU-0006S6-2p
	for git@vger.kernel.org; Fri, 18 May 2007 10:11:18 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 10:11:18 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 May 2007 10:11:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47578>

Andy Parkins wrote:
> What is your preference when, for example, you have already merged a
> topic to next but then a bug fix appears?
> 
>  * -- * -- * -- M -- F         * -- * -- * -- M -- m (next)
>                /        or                   /    /
>     B -- * -- *                   B -- * -- * -- F (topic)
> 
> F is certainly most appropriate to be on the topic branch, but we create
> a perhaps excessively verbose extra merge, m.

It depends on whether the topic branch is "closed": A topic branch is
"closed" after it is merged into all branches that it is intended to be
merged into.

For example, in our setup we sometimes create topic branches off of
'maint' because we want to keep the option alive to merge it into
'maint', although for the time being it is only merged into 'master'
(main development). If a bug fix appears, we have to add it to 'topic'
and merge into 'master' again (your second example). 'topic' may never
make it into 'maint', but this way we keep the option; hence, 'topic' is
_not_ "closed", yet.

-- Hannes
