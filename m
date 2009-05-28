From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Quick way to clone exactly one branch
Date: Thu, 28 May 2009 13:26:05 -0700 (PDT)
Message-ID: <m3ljohas9x.fsf@localhost.localdomain>
References: <32541b130905201345h6daa84e8hb937e1e46456b3c5@mail.gmail.com>
	<20090528201503.GL13499@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 28 22:26:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9mB7-0000Af-C5
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 22:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760865AbZE1U0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 16:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759962AbZE1U0G
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 16:26:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:30626 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759813AbZE1U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 16:26:05 -0400
Received: by fg-out-1718.google.com with SMTP id 16so2092466fgg.17
        for <git@vger.kernel.org>; Thu, 28 May 2009 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=n4wM5M/ZfzIETgxj29QpscBq4hETS11mYxAhnaqzjDY=;
        b=YGOuk3PPxdvT/W1tDvaK3T7IaMKkioZlqPhDPIvgO4qJ9I0HNFuRAQmRRtjEN0jZRq
         2ZdgduTX0MWWR29c5dgTRI+geZNDWATngKZebzrvWGQADzkf3kTnLxBwjPDWQKv7Dc5r
         RPQdSHmRkLDF3QFYmtCHPpUtvM32EkPcmM0nE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=fvlJC6UPsuarutRoOfNYAaztxVSefjtSEPCWFeMF7EYeixnCj7LGbl4crZNlyQyS5i
         RMLn3GWtM3gxvCJxbKEejj7oX3l/IiZ4hJyWk6gLwr8xt9N/PdDrrzwjtf8CQ6szicVn
         0xV18t4floyZwzwWmzKiSzi8GYImYkQ+CI5qA=
Received: by 10.86.91.10 with SMTP id o10mr1981624fgb.13.1243542365672;
        Thu, 28 May 2009 13:26:05 -0700 (PDT)
Received: from localhost.localdomain (abtj91.neoplus.adsl.tpnet.pl [83.8.155.91])
        by mx.google.com with ESMTPS id d4sm885320fga.19.2009.05.28.13.26.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 13:26:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4SKQ586002968;
	Thu, 28 May 2009 22:26:05 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4SKQ3pB002965;
	Thu, 28 May 2009 22:26:03 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090528201503.GL13499@coredump.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120223>

Jeff King <peff@peff.net> writes:

> On Wed, May 20, 2009 at 04:45:44PM -0400, Avery Pennarun wrote:
> 
> > Is there a quick alternative to the following?
> > 
> >    mkdir myproj
> >    cd myproj
> >    git init
> >    git fetch git://whatever master
> >    git checkout -b master FETCH_HEAD
> > 
> > Basically, the above is a lot like 'git clone' but only clones the
> > 'master' branch.  For really big projects with lots of junk in other
> > branches, the above can save a lot of bandwidth.
> 
> No, AFAIK there isn't a simpler way to do it. But it is something people
> have asked about before, so I think it would be a nice addition.
> 
> You can't even use "git remote" because it doesn't allow you to tweak
> the refspecs you add. [...]

It doesn't? Strange, I thought that is what '-t <branch>' option
for "git remote add" for ;-))))

-- 
Jakub Narebski
Poland
ShadeHawk on #git
