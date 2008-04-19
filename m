From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Best way to re-do a CVS repository with git?
Date: Sat, 19 Apr 2008 01:23:25 -0700 (PDT)
Message-ID: <m3wsmuqmmp.fsf@localhost.localdomain>
References: <2729632a0804161937w168aba8ahee742e182e50b4e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 19 18:01:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jn8Ms-00036O-Je
	for gcvg-git-2@gmane.org; Sat, 19 Apr 2008 10:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbYDSIXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 04:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757863AbYDSIXd
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 04:23:33 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:28369 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756911AbYDSIX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 04:23:29 -0400
Received: by fk-out-0910.google.com with SMTP id 19so1095859fkr.5
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 01:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=l0f7YYEtdFbWkOQEp5pvneUtulr+AAaLlvlPjtYYqNo=;
        b=sD6WJnn+6qU7lWE7pQFudlkCGQSrEv2hSa2mFyvnDBVH33c6UG1APFwT1jB4ORyZPKoo5UhhHAO4vi4xrh54II1n+rupZYmRmpusOTaMzT/6NT0R27wBFPtd5YvR4O7W0LaKgs6xDTc9Vngg1oZ2M5pqtmDuaxryj1om8it07pc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=sxzHY+JaxKBGoIZiwXL/9l4K98KVhkKcXULFF5rChSE8ITgTF3HRqkuEDSznSpHlGKv3kVFQKLqkvyM2/PYiGN7rPFPEDAbCUY8Jh6x1aiyNcTVm7cdoHzibfLszi8wrsjDnrX32+ZEZj4FiPf5zVphLJ81jtV8LP8nkODDLg+Q=
Received: by 10.82.185.3 with SMTP id i3mr6357433buf.15.1208593406535;
        Sat, 19 Apr 2008 01:23:26 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.208.125])
        by mx.google.com with ESMTPS id 1sm1399574nfv.3.2008.04.19.01.23.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Apr 2008 01:23:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3J8NDc6011426;
	Sat, 19 Apr 2008 10:23:15 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3J8NB31011423;
	Sat, 19 Apr 2008 10:23:11 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2729632a0804161937w168aba8ahee742e182e50b4e7@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79899>

I think the subject would better read:
"What is best way to represent multimodule CVS repository in Git?"

skillzero@gmail.com writes:

> I have a large CVS repository (1.5 GB without its history) that I'd
> like to convert to git, but I'm not sure about the right way to set it
> up. If I need to change the way I'm thinking about source code
> management, that's fine too, but here's what I have today in a single
> CVS repository:
> 
> MyProject
>    Apps                 # Only apps people use this.
>    Common               # Everyone uses this.
>    Firmware             # Only firmware people use this.
>    External/ProjectA    # Only app people use this.
>    External/ProjectB    # Everyone uses this.
>    External/ProjectC    # Only firmware people use this. This is 1 GB
> of code by itself.
> 
> I manage this today with CVS modules, one for apps people and one for
> firmware people (and another CVS module with everything for people
> like me that work on both).
> 
> I initially thought I'd create separate git repositories for each
> piece, but I'm not sure how that would work when it comes to tagging
> an entire release (i.e. a tag that spans multiple repositories). Or
> how it would handle a git repository within a directory managed by
> another git repository.
> 
> What's the best way to set up something like this with git?

I think that such setup would be best managed by creating Git
repository for each piece, and "integration" repositories, one for
apps people, and one for firmware people, using submodule support in
Git.

Tagging entire release would be tagging in "integration" repository,
the one using submodules.

See also:
 * http://git.or.cz/gitwiki/SubmoduleSupport
 * http://git.or.cz/gitwiki/GitSubmoduleTutorial
 * http://www.kernel.org/pub/software/scm/git/docs/git-submodule.html
   aka git-submodule(1)
-- 
Jakub Narebski
Poland
ShadeHawk on #git
