From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: simple cvs-like git wrapper
Date: Tue, 29 Jan 2008 14:28:02 -0800 (PST)
Message-ID: <m3hcgw8dz7.fsf@localhost.localdomain>
References: <20080129204048.GA9612@venus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ed S. Peschko" <esp5@pge.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 23:28:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJywe-0004rX-K3
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 23:28:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753752AbYA2W2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 17:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753533AbYA2W2L
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 17:28:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:55525 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbYA2W2I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 17:28:08 -0500
Received: by ug-out-1314.google.com with SMTP id z38so268193ugc.16
        for <git@vger.kernel.org>; Tue, 29 Jan 2008 14:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=CTifKwl4f0DKHXxTeUBnxplIbNbWOxFFewBiREtDpbE=;
        b=K0AtjRpb2G8pzoIctWkDKFGF9k0L1K/kW3nWP0HenT5+XVqR6OVCKzU1LFzPGY6EGS3jHaX5PW/5MOH/yHJItL3JI/b8ftJymOeKz/3ZxgrAwV90tOP8PQPs290jrJ7qT43oqIBPw/fN7F1WUdd45FfawMiZNMK8+zRlx+f2Nt8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=jAq7kDXPq+xCP/wm3kR0lcZeZQ/Yll08+gujHXzRC0r1UX7kzVN5QcGQWm3JIP2LO+YrRPa5lZ63+BhpTGq3ddBcvudWXhfZH036SN0oVZXHCgcDz0pHVIY/6FdF09mbZZrOhhxdDNDCzv+39K7XjBfNe3iHlvb81TQqB1TBjnQ=
Received: by 10.67.115.19 with SMTP id s19mr1979566ugm.70.1201645684168;
        Tue, 29 Jan 2008 14:28:04 -0800 (PST)
Received: from localhost.localdomain ( [83.8.244.23])
        by mx.google.com with ESMTPS id a1sm3932038ugf.78.2008.01.29.14.28.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Jan 2008 14:28:02 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0TMRPCv000364;
	Tue, 29 Jan 2008 23:27:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0TMR9aI000359;
	Tue, 29 Jan 2008 23:27:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20080129204048.GA9612@venus>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72005>

"Ed S. Peschko" <esp5@pge.com> writes:

> We've been trying out git here for a while now, and we've noticed two
> things that we both like and dislike: git's flexibility, and git's
> flexibility.
> 
> 
> Git's flexibility is great in the sense that power users can basically
> bend git to their will, but its' flexibility is also causing workflow
> issues in our environment, where beginning users can get lost in all 
> the options that it has, and this is causing communication issues for 
> these folks with the rest of our team.
[...]
> gvs update:
> 
>     Takes the latest changes, from all branches, that everyone 
> 	else has committed into the centralized git repository, and merges 
> 	them onto the current branch. 
[...]
> We basically want this for managing related changesets - we want 
> to be able to switch from one patch branch to another and commit them
> separately - but we don't want to sacrifice the automatic integration
> that you get from cvs by doing:
> 
> 	cvs update
> 
> on a given branch.

One thing (besides horrible branching and even worse merging)  which I
hated in multi-user CVS is the "cvs update", namely the fact that if
you want to commit changes, you _have_ to rebase them on top of
current work. So when you are ready to commit, when you have tested
everything, you are sometimes forced to resolve a merge to be able to
commit... and have to test resolved merge... and perhaps again, and
again.

Working on branches is much nicer IMVHO. And it allows to separate
changes into series of small, incremental commits[*1*]. If you want to
work in centralized or semi-centralized way, you probably would want
to use rebase based workflow, with "git pull --rebase" (which just got
implemented).

Footonotes:
===========
[*1*] I'd like to point to LKML post about creating perfect patch
*series*, but I have forgot to bookmark it, and canot find it again
(IIRC somebody posted link some time ago here on git mailing list).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
