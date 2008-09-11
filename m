From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 01:17:42 +0200
Message-ID: <20080911231742.GD29559@cuci.nl>
References: <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu> <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu> <20080911190335.GB1451@cuci.nl> <20080911200452.GM5082@mit.edu> <20080911214650.GB3187@coredump.intra.peff.net> <20080911225648.GC29559@cuci.nl> <20080911230117.GA4194@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 01:19:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdvRF-00051z-Gx
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 01:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720AbYIKXRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 19:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754729AbYIKXRn
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 19:17:43 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:41409 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbYIKXRn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 19:17:43 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 0EC655465; Fri, 12 Sep 2008 01:17:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080911230117.GA4194@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95665>

Jeff King wrote:
>On Fri, Sep 12, 2008 at 12:56:48AM +0200, Stephen R. van den Berg wrote:
>> Well, the usual way to fix this is to actually startup fetch and tell it
>> to try and fetch all the weak links (or just fetch a single hash (the
>> offending origin link)) from upstream; this is by no means the default
>> operatingmode of fetch, but I don't see any harm in allowing to fetch
>> those if one really wants to.

>Maybe I am misremembering the details of fetching, but I believe you
>cannot fetch an arbitrary SHA-1, and that is by design. So:

I see, didn't know that.

>  1. You would have to argue the merits of changing that design. I
>     believe the rationale relates to exposing some subset of the
>     content via refs, but I have personally never felt that is very
>     compelling.

Well, I can understand why it is done this way, I think.

>  2. Even if we did make a change, that means that _both_ sides need the
>     upgraded version.

If you're using origin links, you'd need that anyway, so that's a given.
I could imagine the minimum would be something like:

 Allow direct SHA1 fetches (which obviously pull in all parents as well)
 if the ref is part of one of the public branches (either as a commit,
 or as an origin link).
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
