From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 12:00:59 -0400
Message-ID: <20080912160059.GY5082@mit.edu>
References: <20080909132212.GA25476@cuci.nl> <20080912054739.GB22228@cuci.nl> <20080912145802.GV5082@mit.edu> <200809121711.32448.jnareb@gmail.com> <48CA8D6A.4000303@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 18:02:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeB6S-0003I1-99
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 18:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbYILQB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 12:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754720AbYILQB2
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 12:01:28 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:46384 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754274AbYILQB1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 12:01:27 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8CG11Lu013386;
	Fri, 12 Sep 2008 12:01:01 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8CG0xX7003461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 12 Sep 2008 12:01:00 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KeB4t-0004hj-CY; Fri, 12 Sep 2008 12:00:59 -0400
Content-Disposition: inline
In-Reply-To: <48CA8D6A.4000303@gnu.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95744>

On Fri, Sep 12, 2008 at 05:40:26PM +0200, Paolo Bonzini wrote:
> > But it is not true that "you can always generate the cache from the
> > git repository" in this case; the patch-id that is to be saved is
> > _original_ patch-id of cherry-picked (or reverted) changeset.
> 
> He's proposing storing the original patch id in the commit message, and
> caching the commit SHA->patch id association on the side.
> 

Actually its the association in the other direction which you'd want
to cache.  It's fast given the commit SHA to dig the original patch id
out of the commit message.  What is harder is given a patch id X, to
find all of the commits which either (a) have a patch id of X, or (b)
have a commit message indicating that the original patch-id was X.  So
having a database which caches this information, so given a patch-id,
you can quickly look up the related commits, is what I believe Sam was
proposing, and which I think would solve the problem quite nicely.

	       	       	     	   	     - Ted
