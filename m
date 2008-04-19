From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Best way to re-do a CVS repository with git?
Date: Sat, 19 Apr 2008 15:49:46 -0700 (PDT)
Message-ID: <m3k5itqx2v.fsf@localhost.localdomain>
References: <2729632a0804161937w168aba8ahee742e182e50b4e7@mail.gmail.com>
	<m3wsmuqmmp.fsf@localhost.localdomain>
	<2729632a0804191247t4458067etfc1627a533a84376@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sun Apr 20 00:50:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnLtO-0002Hl-8T
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 00:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbYDSWtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 18:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753177AbYDSWtv
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 18:49:51 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:45334 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbYDSWtu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 18:49:50 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1140489fgb.17
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 15:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=wEbjergcVfSz36kUOOwCfoY3ijuFBZi7xoea0jQyyM0=;
        b=jXAV9TYvS9e0XWrND9JqB4T6Z4oKX7Of0Gs0PS6L6k4TybBwEuQnm1xDGTkCjHBlefzpZiNrbY1lHnx358u+jxwTpCDSBQ9kP6lBTOb6yz9y5fwL0TdApGX14xM/N9pNDvYXsGSeOhRvbD6+vAQoiO1QD50508tFZka/Ewk2pRU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=iAIUJD1+B4MjpTbt9ybq8clWa3UlbHkMxFPQMjqYNoMnr7rA6AidvUu5nfdBDVXQj66R5RNlFHqnu2roxK0nzpVG5fhTIKWpotw2lGPboYohaKfD/eE8Ze/+DqT7kgzed0m6dpZ4JYHRkTrugL0+ADgLvqnFcfTpxP6h2UcsNRk=
Received: by 10.82.161.19 with SMTP id j19mr7763001bue.12.1208645387364;
        Sat, 19 Apr 2008 15:49:47 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.225.130])
        by mx.google.com with ESMTPS id 1sm2544342nfv.3.2008.04.19.15.49.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Apr 2008 15:49:46 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3JMnjdU016818;
	Sun, 20 Apr 2008 00:49:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3JMniir016815;
	Sun, 20 Apr 2008 00:49:44 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <2729632a0804191247t4458067etfc1627a533a84376@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79930>

skillzero@gmail.com writes:

> On Sat, Apr 19, 2008 at 1:23 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> > I think that such setup would be best managed by creating Git
> > repository for each piece, and "integration" repositories, one for
> > apps people, and one for firmware people, using submodule support in
> > Git.
> 
> > Tagging entire release would be tagging in "integration" repository,
> > the one using submodules.
> 
> Thanks for the info. git submodules seem like the right direction.
[cut]

I don't know if using submodules is a right solution: git submodules
are for more or less loosely tied projects.  It is a solution which is
worth considering.  It allows for example developing some experimental
feature in subproject, while superproject use stable, tested version
of submodule.

Another solution is to merge subproject directly to superproject using
'subtree' merge strategy, like currently gitk and git-gui is
maintained/managed in git.

Yet another would be to use something similar to Mercurial's fores, or
one of earlier submodule implementations, namely git repositories
inside working directories in other git repositories.


And perhaps you would have to roll your own scripts around git, so
single commit would trigger commit in supermodule; that or write your
own hook scripts to do that.


Unfortunately it seems like nobody interested in your plight... and I
cannot help mych beyound that what I've wrote...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
