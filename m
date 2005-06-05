From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cg-init bug -- identified
Date: Sun, 5 Jun 2005 11:29:12 -0700
Message-ID: <20050605182912.GC6890@tumblerings.org>
References: <20050605153053.GA6890@tumblerings.org> <20050605172854.GF17462@pasky.ji.cz> <20050605175634.GB6890@tumblerings.org> <20050605181042.GH17462@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 20:26:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dezoy-0000oL-HF
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 20:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVFES3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 14:29:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVFES3Y
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 14:29:24 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:63212 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261597AbVFES3S
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 14:29:18 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1Dezs0-0000Mx-GH; Sun, 05 Jun 2005 11:29:12 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050605181042.GH17462@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 05, 2005 at 08:10:42PM +0200, Petr Baudis wrote:
> Dear diary, on Sun, Jun 05, 2005 at 07:56:34PM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> told me that...
> > Depending on how I check, I get very different lists. I'll include both in this email.
> > 
> > If I do the 'cg-init' on the full source.cogito directory, then do a 'cg-clone'
> > into a new source.cogtst directory, here is the result of a comparison:
> 
> Hmm. That's very strange, I can't see what could be the problem. If you
> try cg-init multiple times, do you always get the same list of files
> missed out? Can you spot any error messages while doing cg-init?

I figured it out.

I made a temporary copy of the directory, and kept doing

$ rm -rf .git
$ rm somerandomfileordir
$ cg-init
$ cg-status

It turned out one of my files had a "'" in the name, i.e.:

$ ls
Zack's_file
$

I removed it, and all of a sudden cg-init worked perfectly.

Is that a Cogito bug? I would expect git to handle any filename the filesystem
itself can handle.

Be well,
Zack

> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
