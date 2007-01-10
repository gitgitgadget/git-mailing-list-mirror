From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 10:08:24 +0100
Message-ID: <45A4AD08.1020002@op5.se>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>	<87ps9xgkjo.wl%cworth@cworth.org>	<7virfprquo.fsf@assigned-by-dhcp.cox.net>	<87odphgfzz.wl%cworth@cworth.org>	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>	<20070108131735.GA2647@coredump.intra.peff.net>	<7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>	<20070109142130.GA10633@coredump.intra.peff.net>	<7virffkick.fsf@assigned-by-dhcp.cox.net>	<20070109213117.GB25012@fieldses.org> <87zm8ryiyz.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 10:08:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4ZRe-00058X-JX
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 10:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbXAJJI2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 04:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932756AbXAJJI1
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 04:08:27 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:59205 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932754AbXAJJI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 04:08:27 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id EF7586BCBF; Wed, 10 Jan 2007 10:08:24 +0100 (CET)
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87zm8ryiyz.wl%cworth@cworth.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36492>

Carl Worth wrote:
> 
> Frankly, I don't understand why so much effort is being put toward
> allowing these "fragile commits" to be made in the first place. Why
> not require users to name the branch before creating any commits, just
> as has always been the case?
> 

Agreed. Possibly, we could have commit (or commit-tree) issue a big fat 
warning along the lines of:

*** WARNING ***
You are about to create a commit on a detached HEAD.
It is recommended that you run "git branch <name>" to create a branch to 
commit to first. If you don't, you might lose this commit further on.
*** WARNING ***

which could be suppressed by a "--silently-ignore-detached-head" in case 
scripts (securely) use this behaviour. Since committing on detached 
heads really should be a very rare case I don't think many people will 
find this terribly annoying.

> To me, the only real advantage to the new "detached head" stuff is
> simply making it easier to checkout previous state without having to
> name a new branch precisely _because_ the user has not intent to
> commit anything. If the user is going to commit something, then the
> user should be able to come up with a name for the branch.
> 

Indeed and as I've said before, *all* developers have "silly-names" they 
use for temporary stuff (foo, bar, frotz, nitfol, blaj, fnurg, sdf, ...) 
so it's not like we'll put a heavy burden on peoples imagination.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
