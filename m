From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Mon, 26 Sep 2005 07:09:12 +0100
Message-ID: <200509260709.12937.alan@chandlerfamily.org.uk>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net> <200509252143.23905.alan@chandlerfamily.org.uk> <7v1x3cn1cj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Sep 26 08:10:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJmAn-000382-0B
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 08:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbVIZGJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 02:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbVIZGJF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 02:09:05 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:41426
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932396AbVIZGJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 02:09:04 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EJmAh-0003F6-LN
	for git@vger.kernel.org; Mon, 26 Sep 2005 07:09:03 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <7v1x3cn1cj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9303>

On Monday 26 Sep 2005 01:01, Junio C Hamano wrote:
> Alan Chandler <alan@chandlerfamily.org.uk> writes:
> > Does that mean I have missed some step along the way to get the maint
> > branch position moved to the new tag?
>
> To recap, you did:
>
>     (before 0.99.7d propagated to the mirrors)
>     $ git clone http://kernel.org/pub/scm/git/git.git git-src
>     $ cd git-src
>
>     (after 0.99.7d propagated to the mirrors)
>     $ git fetch origin tag v0.99.7d
>     $ git checkout -f maint

Actually, I got as far as doing the fetch, but I didn't checkout anything.  I 
just ran gitk --all 

I would have been on the branch that the git clone would have left me on 
(presumably master)

>
> The 'fetch origin tag v0.99.7d' step should have left
> the new file .git/refs/tags/v0.99.7d _after_ downloading all the
> objects necessary to reconstruct the history to get there.
>

Yes - I gitk showed had all the objects - but v0.99.7d was a a tag at the tip 
of an unamed branch

> Ah, you are right.  My instruction did not update other branches
> for you.  My bad.
>
> Assuming people stay on their "master" branch, and have the
> recommended .git/remotes/origin contents in my previous message,
> then the steps "after 0.99.7d propagated to the mirrors" would
> just be:
>
>     $ git fetch

Its not the "other" branches that I was concerned about, it was the "maint" 
branch reference which seemed to still be still at the same commit as the 
v0.99.7c tag, at least that was what gitk --all showed me, after the fetch. 


>
> which would fetch all the branches mentioned in the remotes
> file, and then:
>
>     $ git checkout -f maint

This is where I get puzzled.  Fetch on its own didn't move where "maint" 
pointed to so doing this checkout would have left me at the v0.99.7c tag (I 
didn't actually do it - as I was then puzzling over the documentation trying 
to see what I did wrong)

I realise I could have just manually moved it - but none of the steps in your 
instructions seemed to move it for me.

In the end - I blew my git away and repeated the clone exercise after the 
mirrors had updated - in this version the "maint" branch was co-incident with 
the v0.99.7d tag

>
> which would switch your working tree to maint branch.
>
> NOTE NOTE NOTE.  The above assumes you are on your "master"
> branch when you run 'git fetch' --- if you are on any of the
> branches that is being updated (you can check which branch you
> are on with 'git branch' without argument, or just with 'ls -l
> .git/HEAD') 'git fetch' will complain because doing so without
> updating them to match the updated branch head would make your
> index file and working tree inconsistent with your .git/HEAD,
> but 'git fetch' is supposed to be only fetching without touching
> the working tree.



-- 
Alan Chandler
http://www.chandlerfamily.org.uk
