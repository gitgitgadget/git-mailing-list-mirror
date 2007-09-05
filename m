From: Mike Hommey <mh@glandium.org>
Subject: Re: Git's database structure
Date: Wed, 5 Sep 2007 19:39:12 +0200
Organization: glandium.org
Message-ID: <20070905173912.GB3396@glandium.org>
References: <7vtzqany0z.fsf@gitster.siamese.dyndns.org> <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com> <20070904212507.GA24434@thunk.org> <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com> <46DE5861.4050201@op5.se> <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com> <46DEC26E.7030809@op5.se> <9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com> <Pine.LNX.4.64.0709051648400.3189@reaper.quantumfyre.co.uk> <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Andreas Ericsson <ae@op5.se>, Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 19:42:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISytF-0001QZ-Va
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 19:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754841AbXIERmE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 13:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbXIERmD
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 13:42:03 -0400
Received: from vawad.err.no ([85.19.200.177]:42997 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003AbXIERmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 13:42:00 -0400
Received: from aputeaux-153-1-85-89.w86-205.abo.wanadoo.fr ([86.205.43.89] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1ISysW-000256-Bb; Wed, 05 Sep 2007 19:41:27 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1ISyqO-0000uK-My; Wed, 05 Sep 2007 19:39:13 +0200
Content-Disposition: inline
In-Reply-To: <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57727>

On Wed, Sep 05, 2007 at 12:12:28PM -0400, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 9/5/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
> > On Wed, 5 Sep 2007, Jon Smirl wrote:
> >
> > > On 9/5/07, Andreas Ericsson <ae@op5.se> wrote:
> > >> Jon Smirl wrote:
> > >>>
> > >>> The path name field needs to be moved back into the blobs to support
> > >>> alternative indexes. For example I want an index on the Signed-off-by
> > >>> field. I use this index to give me the SHAs for the blobs
> > >>> Signed-off-by a particular person. In the current design I have no way
> > >>> of recovering the path name for these blobs other than a brute force
> > >>> search following every path looking for the right SHA.
> > >>>
> > >>
> > >> Ah, there we go. A use-case at last :)
> >
> > But not a brilliant one.  You sign off on commits not blobs.  So you go
> > from the sign-off to paths, then to blobs.  There is no need to go from
> > blob to path unless you deliberately introduce such a need.
> 
> Use blame for an example. Blame has to crawl every commit to see if it
> touched the file. It keeps doing this until it figures out the last
> author for every line in the file. Worse case blame has to crawl every
> commit in the data store.

And why exactly would you need to change blobs to contain path for blame
to be faster ?

Or more generally, what, in the current way of git doing things,
prevents you from adding an index to $THE_DATA_YOU_LIKE, exactly ?

>From the very few use cases you've given, I see nothing preventing to
create an additional index from the data git currently uses.

Mike
