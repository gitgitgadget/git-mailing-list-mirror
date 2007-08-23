From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: git-svnimport: what to do after -i?
Date: Thu, 23 Aug 2007 08:29:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708230827440.26254@beast.quantumfyre.co.uk>
References: <20070822113325.1bihryuk4gko8kgs@intranet.digizenstudio.com>
 <20070823012836.GA18796@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jing Xue <jingxue@digizenstudio.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 09:30:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO78i-0007j4-QM
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 09:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753287AbXHWH35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 03:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753642AbXHWH35
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 03:29:57 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:57455 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752917AbXHWH34 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 03:29:56 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 7CFCA740E0
	for <git@vger.kernel.org>; Thu, 23 Aug 2007 08:29:55 +0100 (BST)
Received: (qmail 16051 invoked by uid 103); 23 Aug 2007 08:29:55 +0100
Received: from 192.168.0.7 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.91/4032. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(192.168.0.7):. 
 Processed in 0.029605 secs); 23 Aug 2007 07:29:55 -0000
Received: from beast.quantumfyre.co.uk (192.168.0.7)
  by neutron.datavampyre.co.uk with SMTP; 23 Aug 2007 08:29:54 +0100
X-X-Sender: jp3@beast.quantumfyre.co.uk
In-Reply-To: <20070823012836.GA18796@falcon.digizenstudio.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56465>

On Wed, 22 Aug 2007, Jing Xue wrote:

> OK, got it working. It had more to do with the module/trunk path than
> the -i.
>
> My svn projects are organized like:
> projectFoo
>    -trunk
>    -tags
>    -branches
>
> So I initially used:
>
> git svnimport -C projectFoo -r -A svn-authors -I .gitignore -T projectFoo svn://jabba trunk
>
> which resulted in the empty working directory - with or without the -i.
>
> What ended up working is this:
>
> git svnimport -C projectFoo -r -A svn-authors -I .gitignore -T projectFoo -P trunk svn://jabba
>
> Cheers.

I haven't used svnimport in a while (and never with subprojects), but you 
seem to be specifying that projectFoo is your trunk - which doesn't seem 
right.

I would have expected the command to be:

git svnimport -C projectFoo -r -A svn-authors -I .gitignore svn://jabba projectFoo

-- 
Julian

  ---
Everything you know is wrong!
