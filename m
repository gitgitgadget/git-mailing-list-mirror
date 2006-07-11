From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: Why doesn't git-rerere automatically commit a resolution?
Date: Tue, 11 Jul 2006 09:05:18 +0200
Message-ID: <20060711070518.GB4201@spinlock.ch>
References: <20060711061626.GB11822@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 09:05:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0CJE-00087Y-CO
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 09:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWGKHFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 03:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWGKHFZ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 03:05:25 -0400
Received: from mail22.bluewin.ch ([195.186.19.66]:51154 "EHLO
	mail22.bluewin.ch") by vger.kernel.org with ESMTP id S1030219AbWGKHFX
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 03:05:23 -0400
Received: from spinlock.ch (85.1.71.27) by mail22.bluewin.ch (Bluewin 7.3.110.2)
        id 449255C7005408A9; Tue, 11 Jul 2006 07:05:11 +0000
Received: (nullmailer pid 5990 invoked by uid 1000);
	Tue, 11 Jul 2006 07:05:18 -0000
To: Shawn Pearce <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <20060711061626.GB11822@spearce.org>
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.18-rc1 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23693>

* Shawn Pearce (spearce@spearce.org) wrote:
> I'm curious... I have a pair of topic branches which don't merge
> together cleanly by recursive (due to conflicting hunks in the
> same line segments).  I enabled git-rerere, ran the merge, fixed
> up the hunks and committed it.  git-rerere built its cache, as
> the next time I pulled the two topic branches together and got
> the same conflicts it correctly regenerated the prior resolution
> (and printed a message saying as much).
> 
> But it git-rerere left the files unmerged in the index and it
> doesn't generate a commit for the merge, even though there are no
> merge conflicts remaining.  I expected it to update the index (to
> merge the stages) and to generate a commit if possible; especially
> in this case as I was pulling the exact same two commits together
> again with the exact same merge base commit.
> 
> So I'm wondering why doesn't it try to finish the merge?  Was there
> a really deep rooted reason behind it or was it simply easier/safer
> to let the user sort out the working directory state every time?
> 

I am maintaining different websites from one git repository. The
code is almost the same between all versions, but the HTML templates
are not. Sometimes, modified templates in feature branches produce
mismerges which I want to fix up in different ways for different
websites. There, git-rerere doesn't help me at all. It does help 
very much with the code and configuration files though.

To conclude, I have rerere enabled, but it does not always do the
right thing, so I am happy that I get a chance to inspect the files
before committing (I could also amend the commit later, but I still
think it's better that the user still needs to acknowledge the
result of the automatic merge.)

	Matthias
