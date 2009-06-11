From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Mercurial on BigTable
Date: Thu, 11 Jun 2009 01:24:48 -0700 (PDT)
Message-ID: <m34oun41pz.fsf@localhost.localdomain>
References: <d411cc4a0906101215t313b2037k713aa1ce974c30cc@mail.gmail.com>
	<4A3065C5.3070203@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git list <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jun 11 10:25:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEfat-0005al-BZ
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 10:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041AbZFKIY4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 04:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbZFKIYy
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 04:24:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:12147 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755949AbZFKIYw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 04:24:52 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1438451fga.17
        for <git@vger.kernel.org>; Thu, 11 Jun 2009 01:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=TbGE37/Xe3umS0qg8qNFFvjZlwSBuQAR0Bq0EJHwwdg=;
        b=GFqIhP4Ji8HSdLNKcF+Uox/0Lx/OD1i/NOQsYm79Hgr5FqsLBs5gbFS7BbJZcFySog
         osYNfIA/pW6O+7YmEjdE1qvk/ZuJnih3IkswDG0B1GcWIo0IKLwIiVs0zAd192YiUJ5Q
         0NAVOP5FTetAGEycLOhNYKPWajrfYdJe713uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=mf1cggkewCSF7MzpWo1JFX56UTEpXpI0V0qq82zop3lbwTPXMe6Uy9vwOWtHQDTOSz
         d7FFU45NpfVgRE6ng5IoMlnRLXY+cRoUevs7ybkH+5IXYzKa05Pb9B0pWjffrvle38tK
         bYF19/4qu/WYQjR6NQPfeTEmF44Jfo8CdhSWg=
Received: by 10.86.49.13 with SMTP id w13mr1969105fgw.31.1244708691097;
        Thu, 11 Jun 2009 01:24:51 -0700 (PDT)
Received: from localhost.localdomain (abwl198.neoplus.adsl.tpnet.pl [83.8.235.198])
        by mx.google.com with ESMTPS id l19sm1457809fgb.17.2009.06.11.01.24.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Jun 2009 01:24:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5B8OhNl007193;
	Thu, 11 Jun 2009 10:24:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5B8OfRH007190;
	Thu, 11 Jun 2009 10:24:41 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A3065C5.3070203@op5.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121330>

Andreas Ericsson <ae@op5.se> writes:

> I'm more curious as to why they didn't choose git. The only explanation
> that was actually true is that hg works well over HTTP (if you can call
> 3 network requests per not-up-to-date head "well"). Since I can't imagine
> them not doing proper research before launching a project that almost
> certainly cost quite a lot of money, and I personally think that the
> "http rules all" explanation sounded weak, I'm guessing there were other
> reasons as to why they didn't go with git instead, and I'm fairly curious
> to hear them. If I was to take a guess, I'd say git is written in a pretty
> unfriendly way for implementing other storage engines.

Well, Google App Engine was in Python, so it follows that the crew
would have it easier understanding Mercurial code (which is written in
Python with parts in C for performance), and in moving it to BigTable.
Adding Java to Gogle App Engine is, as far as I know, fairly recent;
additionally JGit (git implementation in Java) is not yet full
implementation.

I don't know if Git would be easy to implement on BigTable, and
whether it wouldn't be better for performance to try to implement it
on top of underlying Google File System (GFS) and Chubby Lock Service
_directly_...


Sidenote: lack of good HTTP protocol support (there are some numbers
at the bottom of comparison[1], but not enough detail to satisfy) as a
reason is especially strange now that there was quite long discussion
designing git-over-HTTP ("smart" HTTP protocol); cleaning warts in git
pack protocol, working around HTTP being stateless, ensuring backward
compatibility, ensuring that it would work well with HTTP caches...

But that is the problem with detailed research for "fast moving
target". Good research takes time, and by the time you finished it its
results are already obsolete...

[1] http://code.google.com/p/support/wiki/DVCSAnalysis

> 
> Ah well. In a year or two they'll probably support git as well. One can
> hope at least ;-)

Let's hope to that...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
