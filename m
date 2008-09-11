From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 00:56:48 +0200
Message-ID: <20080911225648.GC29559@cuci.nl>
References: <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu> <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu> <20080911190335.GB1451@cuci.nl> <20080911200452.GM5082@mit.edu> <20080911214650.GB3187@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@MIT.EDU>, Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 12 00:58:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdv73-0000v3-28
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 00:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbYIKW4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 18:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753780AbYIKW4u
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 18:56:50 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:36746 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbYIKW4t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 18:56:49 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 1C7D25465; Fri, 12 Sep 2008 00:56:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080911214650.GB3187@coredump.intra.peff.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95661>

Jeff King wrote:
>On Thu, Sep 11, 2008 at 04:04:53PM -0400, Theodore Tso wrote:
>> > It will be q^..q, and specifically not p^..p, using ^p..p would be
>> > lying.  We aim to document the evolvement of the patch in time.
>> > Cherry-pick itself will always ignore the origin links present on the
>> > old commit, it simply creates new ones as if the old ones didn't exist.

>> So if you never pull branch C (where commit q resides), there is no
>> way for you to know that commits p and r are related.  How.... not
>> useful.

>But what about workflows in between? When I pull from some developer who
>has added a weak reference to a particular commit SHA1, but I _don't_
>have that commit, my next question "OK, so what was in that commit?".
>What is the mechanism by which I find out more information on that SHA1?

Well, the usual way to fix this is to actually startup fetch and tell it
to try and fetch all the weak links (or just fetch a single hash (the
offending origin link)) from upstream; this is by no means the default
operatingmode of fetch, but I don't see any harm in allowing to fetch
those if one really wants to.

>Using a key that is meaningful to an external database (like a bug
>tracker) means that you can go to that database to look up more
>information.

True.  And also a Good Thing, I concur.
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
