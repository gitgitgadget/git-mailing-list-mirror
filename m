From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 2/2] Run garbage collection with loose object pruning
 after svn dcommit
Date: Fri, 05 Oct 2007 10:48:29 -0700
Message-ID: <470678ED.8050407@midwinter.com>
References: <20071005001528.GA13029@midwinter.com> <20071005082110.GA4797@xp.machine.xx> <47066255.6080500@midwinter.com> <20071005164912.GE4797@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 05 19:48:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdrI1-0005h4-HP
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 19:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756898AbXJERsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 13:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753763AbXJERsc
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 13:48:32 -0400
Received: from tater.midwinter.com ([216.32.86.90]:42370 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752616AbXJERsb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 13:48:31 -0400
Received: (qmail 22982 invoked from network); 5 Oct 2007 17:48:30 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=QqB2Nbq0UV8fa/e0LpJbWgF0q9VjyZnV+Gi1GeZxKrWryKE1J+FVgU3A8I+cYbJD  ;
Received: from localhost (HELO sgrimm-mbp.lan) (koreth@127.0.0.1)
  by localhost with SMTP; 5 Oct 2007 17:48:30 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <20071005164912.GE4797@xp.machine.xx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60119>

Peter Baumann wrote:
> That's new to me. Glancing over git-commit.sh, I could only find a
> 'git-gc --auto', but no prune. I am not against doing a 'git gc --auto',
> but I am against the --prune, because this could make shared
> repositories unfunctional.
>   

Does anyone run "git svn dcommit" from a shared repository? That is the 
only command that will trigger this code path.

Given that you lose all the svn metadata if you do "git clone" (or "git 
clone -s") on a git-svn-managed repository, it's not clear to me that 
anyone would ever be bitten by this. Counterexamples welcome, of course.

How would you feel about a separate config option to specifically enable 
auto-pruning, and having "git svn clone" set that option by default? 
Presumably anyone who is setting up a shared git-svn repository will be 
up to the task of disabling the option.

-Steve
