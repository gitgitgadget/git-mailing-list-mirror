From: Marc Singer <elf@buici.com>
Subject: Re: Why is there no git-update-cache --modified (aka I give up)
Date: Tue, 12 Jul 2005 08:53:16 -0700
Message-ID: <20050712155316.GA5841@buici.com>
References: <20050712055218.GA18192@buici.com> <7v7jfwbfvj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 17:53:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsN4c-00011n-MG
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 17:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbVGLPxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 11:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVGLPxS
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 11:53:18 -0400
Received: from florence.buici.com ([206.124.142.26]:39840 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S261465AbVGLPxR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2005 11:53:17 -0400
Received: (qmail 6512 invoked by uid 1000); 12 Jul 2005 15:53:16 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jfwbfvj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 12, 2005 at 01:14:24AM -0700, Junio C Hamano wrote:
> Marc Singer <elf@buici.com> writes:
> 
> >   # git-diff-cache HEAD
> >
> > is really nice.  But, do I really have to invoke git-update-cache with
> > every modified file?  I could write a script to cul the filenames from
> > git-diff-cache, but I'm having a hard time believing that that is how
> > others are preparing their commits.
> 
> Me too.  By the way, I think you mean diff-files not
> diff-cache.

No, I mean git-diff-cache.  I find that this works pretty well, though.

  # git-update-cache `git-diff-cache | cut -f2`

It looks like the same thing works for git-diff-files. 

  # git-update-cache `git-diff-files | cut -f2`

This seems to agree with the way you handle things.

Similarly, there is the need to determine which files are new to the
tree.  This isn't much of a burden when creating files in the tree,
but can be bothersome when using patch since git-apply is conservative
about fuzz.
