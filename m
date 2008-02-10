From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 10:02:17 -0500
Message-ID: <20080210150216.GB8797@dervierte>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802100213330.11591@racer.site> <0DE4061C-7189-4932-AA3D-D09009F753F2@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, Jeff King <peff@peff.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 16:03:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JODi4-0005Yl-Nb
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 16:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbYBJPCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 10:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbYBJPCY
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 10:02:24 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:34822 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbYBJPCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 10:02:22 -0500
Received: by wr-out-0506.google.com with SMTP id c48so3852773wra.23
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 07:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=F6+qif2at3N0lXBWGxVvn0bvvbp012F3xi1uxn2fgc4=;
        b=l394txqlpxoa1x++cp22sIFHThqklSgg8rHnwuSaQcYupPHc6YQNowM20hoKgtzdtLeIWV2ILjAaIhfw4mFIx3i0gp55fqbZhMmbdKMmYctjM7eWv8UMK5bSAOdB6wJVtEDZxGnY+ApRoIM98/+2xe9Y90TfnUIUgONkLcrPVhE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=BKaEm/y6LG3p5550Xsf95hJ5EKn+zc8/azHREz5IeQcf8VUAKfLRQVi8hUwq6uXIXaTOM31ONTXdhfNnQpSi9xP43kBBWcMEEztr5ppE4MW11axnH9g4DUOXnEOXLHny+KcWbaq6ObwpYKNTsoC1T2S8H+EsoT0qeBC4tF8bTm4=
Received: by 10.150.53.2 with SMTP id b2mr6214880yba.110.1202655739757;
        Sun, 10 Feb 2008 07:02:19 -0800 (PST)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id 31sm39059659wri.24.2008.02.10.07.02.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Feb 2008 07:02:19 -0800 (PST)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 64A5F92B5; Sun, 10 Feb 2008 10:02:16 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <0DE4061C-7189-4932-AA3D-D09009F753F2@wincent.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73358>

On Sun, Feb 10, 2008 at 03:03:13PM +0100, Wincent Colaiuta wrote:
> I think there's no way we should be catering for people who type command 
> like "git push" just to see what the synopsis does.
>
> The verb "push" very clearly has connotations of a state-changing, possibly 
> irreversible action (unlike other verbs like "log" or "show").

I think you're quite correct: push is a state changing action.  For that
reason, it should default to the smallest amount of work conceivably
envisioned by the user.  To do more work than the user may have meant is
asking for trouble.

Take git-commit as a parallel.  You make some file changes and run
"git commit".  Nothing happens.  If you wanted to commit all your
changes, you need the -a flag.  Here, subversion takes the opposite
approach and commits all your files, when in fact you may have only
wanted a smaller subset.  I have seen this cause problems many times
(and more than once, I was the problem-maker :) )

> People who type "git push" just to see a synopsis need to learn a lesson; 
> the lesson being that if you want to find out what a command does the 
> safest thing is to type "git help push" instead.

This is an interesting theory on user-interface design.


I propose a new configuration option, remote.*.pushAllRefs, defaulting
to off.  When pushAllRefs is false, "git push" pushes only the current
branch.  When pushAllRefs is true, "git push" does what it does today.
For the old-timers, the impact of such a change seems minimal.
Worst-case, they run "git push," it doesn't do what they expect, they run
"git push origin" and then go change their config files.

Thoughts?
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
