From: Kay Sievers <kay.sievers@suse.de>
Subject: Re: gitweb using "--cc"?
Date: Thu, 9 Feb 2006 04:13:02 +0100
Message-ID: <20060209031302.GA7214@vrfy.org>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 04:13:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F72F1-0003vX-N9
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 04:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965048AbWBIDNE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 22:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964943AbWBIDNE
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 22:13:04 -0500
Received: from soundwarez.org ([217.160.171.123]:53635 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1030428AbWBIDND (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 22:13:03 -0500
Received: by soundwarez.org (Postfix, from userid 2702)
	id E16647E728; Thu,  9 Feb 2006 04:13:02 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15785>

On Wed, Feb 08, 2006 at 03:44:58PM -0800, Linus Torvalds wrote:
> 
> I just did an arm merge that needed some (very trivial) manual fixups 
> (commit ID cce0cac1, in case anybody cares).
> 
> As usual, git-diff-tree --cc does a beautiful job on it, but I also 
> checked the gitweb output, which seems to not do as well (the commit 
> message about a manual conflict merge doesn't make any sense at all).
> 
> Now, in this case, what gitweb shows is actually "sensible": it will show 
> the diff of what the merge "brought in" to the mainline kernel, and in 
> that sense I can certainly understand it. It basically diffs the merge 
> against the first parent.
> 
> So looking at that particular example, arguably gitweb does something 
> "different" from what the commit message is talking about, but in many 
> ways it's a perfectly logical thing.
> 
> However, diffing against the first parent, while it sometimes happens to 
> be a sane thing to do, really isn't very sane in general. The merge may go 
> the other way (subdevelopers merging my code), like in commit b2faf597, 
> and sometimes there might not be a single reference tree, but more of a 
> "couple of main branches" approach with merging back and forth). Then the 
> current gitweb behaviour makes no sense at all.
> 
> So it would be much nicer if gitweb had some alternate approach to showing 
> merge diffs. My suggested approach would be to just let the user choose: 
> have separate "diff against fist/second[/third[/..]] parent" buttons. And 
> one of the choices would be the "conflict view" that git-diff-tree --cc 
> gives (I'd argue for that being the default one, because it's the only one 
> that doesn't have a "preferred parent").

Hmm, I have no real clue what all the --cc is about. It's not obvious
for someone who never thought about "meta patches" or "complex merges". :)

If nobody else can do the changes to gitweb, sure, I'll do this and try
to understand what is needed, but then I will need it explained in more
details, what functionality we want to see here. At best with some commented
commandline examples that produce the data you want to see. So that I
can imagine what you are looking for and can give it a try ...

On the technical side for the kernel.org installation:
  does git diff use /usr/bin/diff?

  does git diff create temp files?

  how can i specify the location for the temp files?
  (wasn't possible some months ago, but needed on kernel.org)

  is the temp file naming safe for a lot of git diff running in parallel?

  is a --cc capable git already available on the kernel.org boxes?

Thanks,
Kay
