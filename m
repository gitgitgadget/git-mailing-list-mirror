From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Mon, 8 Oct 2007 01:40:39 +0200
Message-ID: <20071007234039.GH2765@steel.home>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <20071007221920.GF2765@steel.home> <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 01:40:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iefjz-0006lT-16
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 01:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802AbXJGXkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 19:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756413AbXJGXkm
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 19:40:42 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:27775 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756191AbXJGXkm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 19:40:42 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (fruni mo57) (RZmta 13.4)
	with ESMTP id w02e32j97KAW7T ; Mon, 8 Oct 2007 01:40:40 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 28820277AE;
	Mon,  8 Oct 2007 01:40:40 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D89BCC502; Mon,  8 Oct 2007 01:40:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60265>

Elijah Newren, Mon, Oct 08, 2007 00:24:49 +0200:
> On 10/7/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> > rm -rf .git/refs/original/refs/heads/<the branch where HEAD pointed to>
> > (assuming you haven't repacked yet)
> >
> > or just edit .git/packed-refs and remove everything "refs/original"
> > which fits the criteria
> >
> > > So...how do I fix the reflog, and then repack to have a
> > > pack under 11MB in size?
> >
> > git reflog expire --all (it is a bit to much. You can just edit
> > .git/logs/* in any text editor)
> 
> So...
> 
> $ du -hs .
> 11M     .
> $ rm -rf .git/refs/original/
> $ vi .git/packed-refs
> # Remove the line referring to refs/original...
> $ git reflog expire --all
> $ git gc --aggressive --prune
> $ du -hs .
> 11M     .
> 
> It's still 11MB.
> 
> Any other ideas?

you missed something. Your example compresses to about 124k.
