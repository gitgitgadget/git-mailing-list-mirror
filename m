From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 09:52:32 -0700
Message-ID: <20050429165232.GV21897@waste.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1> <20050429074043.GT21897@waste.org> <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org> <118833cc05042908181d09bdfd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 18:50:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRYgP-0005WO-Gw
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 18:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbVD2Qyp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 12:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVD2Qyc
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 12:54:32 -0400
Received: from waste.org ([216.27.176.166]:36059 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262845AbVD2Qwj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 12:52:39 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j3TGqWPf022044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Apr 2005 11:52:32 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j3TGqWsc022041;
	Fri, 29 Apr 2005 11:52:32 -0500
To: Morten Welinder <mwelinder@gmail.com>
Content-Disposition: inline
In-Reply-To: <118833cc05042908181d09bdfd@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2005 at 11:18:20AM -0400, Morten Welinder wrote:
> > I had three design goals. "disk space" wasn't one of them
> 
> And, if at some point it should become an issue, it's fixable. Since
> access to objects is fairly centralized and since they are
> immutable, it would be quite simple to move an arbitrary selection
> of the objects into some other storage form which could take
> similarities between objects into account.

This is not a fix, this is a band-aid. A fix is fitting all the data
in 10 times less space without sacrificing too much performance.

> So disk space and its cousin number-of-files are both when-and-if
> problems. And not scary ones at that.

But its sibling bandwidth _is_ a problem. The delta between 2.6.10 and
2.6.11 in git terms will be much larger than a _full kernel tarball_.
Simply checking in patch-2.6.11 on top of 2.6.10 as a single changeset
takes 41M. Break that into a thousand overlapping deltas (ie the way
it is actually done) and it will be much larger.

-- 
Mathematics is the supreme nostalgia of our time.
