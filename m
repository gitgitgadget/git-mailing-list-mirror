From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/3] fast-import: Allow cat requests at arbitrary
 points in stream
Date: Wed, 8 Sep 2010 15:46:54 +0530
Message-ID: <20100908101649.GH13171@kytes>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100908032736.GC23409@capella.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 12:19:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtHk7-0003h8-ON
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 12:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758014Ab0IHKS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 06:18:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53632 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756838Ab0IHKS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 06:18:57 -0400
Received: by pwi3 with SMTP id 3so1759830pwi.19
        for <git@vger.kernel.org>; Wed, 08 Sep 2010 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cd0Fc43o+hr6Hx+a3MRyc9L1ZkMejIniN6t2zXoW7k0=;
        b=x9XMu4oqMFZi1svr54mkHEBCIhmtDshZLHxDdyY929iElQgE+AaF8PaL4yP+1qGLfX
         YXuWoZnkKvw/jEVC2WkjXQcg0B+/lOABTD53X3+MwQZN/RbWa1NLWl1PPH7V7nAEAw/b
         QEa5a3jiLcLCIUsHIq54fX9DyzOT0JwC8dv6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dyNKNKaGxjeqjgvUVeLVY73szRSYNi1nvXJn4Pc+8HsiqhxfbH+N81+jlJOgvHAqOA
         yUrSxj1LBJk3sl4uDPcni4fDL9qoj+foNj3QuEx/FBb+M0vVmLggruow383NcOKlkRrC
         f6OMgJ+My34CsjisvWFeSBOaZ38qbLNa6uDc4=
Received: by 10.142.217.9 with SMTP id p9mr515146wfg.296.1283941136777;
        Wed, 08 Sep 2010 03:18:56 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id s34sm7015875wfc.8.2010.09.08.03.18.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Sep 2010 03:18:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100908032736.GC23409@capella.cs.uchicago.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155781>

Hi Jonathan,

Jonathan Nieder writes:
> Rather than planning in advance and saving up a bunch of objects
> before a "commit" command, frontends might want to wait until the
> middle of a commit and request objects then.
> 
> Allow them to.
> 
> The new rule: a "cat" request can be inserted wherever a comment
> is allowed, which means at the start of any line except in the
> middle of a "data" command.

Excellent idea. This will certainly be useful when we start working on
the zero-tree refactor.

> That's it for today.  I'll be on vacation for the next couple of weeks
> so I can't promise to be responsive.  Comments are still welcome,
> though (nothing is really different except that the latency may be
> longer).

Quick status update: David has started working on the IO backend
that's necessary to get svn-fe to use svn-da. We'll start testing/
reviewing this series once that's done.

I'm busy studying for exams next week.

-- Ram
