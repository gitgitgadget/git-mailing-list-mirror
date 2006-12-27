From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: branch.pu.forcefetch
Date: Wed, 27 Dec 2006 22:14:27 +0100
Organization: At home
Message-ID: <emunic$fn$1@sea.gmane.org>
References: <1167251519.2247.10.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Dec 27 22:12:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzg4A-00062l-WF
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 22:12:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbWL0VL7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 16:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754747AbWL0VL7
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 16:11:59 -0500
Received: from main.gmane.org ([80.91.229.2]:50139 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754777AbWL0VL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 16:11:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Gzg42-0007To-2I
	for git@vger.kernel.org; Wed, 27 Dec 2006 22:11:54 +0100
Received: from host-81-190-19-121.torun.mm.pl ([81.190.19.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 22:11:54 +0100
Received: from jnareb by host-81-190-19-121.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 22:11:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-121.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35480>

Pavel Roskin wrote:

> I'm testing the current git from the master branch, and I like the idea
> of moving the remotes to the config file, but I think there is a
> significant omission in the new syntax.  There is no way to specify that
> some branches are fast forward.
> 
> For example, I clone the git repository anew, and I try to update it by
> git-fetch a few days later.  I get an error:
> 
> * refs/remotes/origin/pu: not updating to non-fast forward branch 'pu'
> of git://www.kernel.org/pub/scm/git/git
> 
> It would be great to have a "non-fastforward" option in the config file
> for every branch. I'm thinking about something like: 
> 
> [branch "pu"]
>         forcefetch = 1

Currently the old '+' before refspec still works. So you should have
[remote "origin"]
        # ...
        fetch = +refs/heads/pu:refs/remotes/origin/pu

> It would be even better to initialize such option while cloning.

There was some talk about this, but I don't remember if there were any code.

Actually the talk was about marking branch as non-fast-forwardable (which
is meant to have rewritten history) on _server_ side, and allowing to
fetch all/parts of config while cloning to get this info.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
