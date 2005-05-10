From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-log patches
Date: Tue, 10 May 2005 02:37:13 +0200
Message-ID: <20050510003713.GL15712@pasky.ji.cz>
References: <1742.10.10.10.24.1115573750.squirrel@linux1> <20050508234936.GA26624@diku.dk> <4302.10.10.10.24.1115610350.squirrel@linux1> <20050509113907.GA22830@diku.dk> <20050509121435.GB18382@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 10 02:30:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVIda-0003iL-In
	for gcvg-git@gmane.org; Tue, 10 May 2005 02:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVEJAhb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 20:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVEJAhb
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 20:37:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51086 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261463AbVEJAhO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 20:37:14 -0400
Received: (qmail 5964 invoked by uid 2001); 10 May 2005 00:37:13 -0000
To: Jonas Fonseca <fonseca@diku.dk>
Content-Disposition: inline
In-Reply-To: <20050509121435.GB18382@pasky.ji.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 02:14:35PM CEST, I got a letter
where Petr Baudis <pasky@ucw.cz> told me that...
> In git, the parents list is unordered. But this is different in Cogito,
> where the first parent _is_ special. If you are merging _from_ branch B
> _to_ branch A, the order of parents will be always
> 
> parent A
> parent B
> 
> In practice, it does not make too much difference, but this is one of
> the cases where it makes difference. So I think the current behaviour is
> right.
> 
> BTW, this also implies that merges
> 
>   A --
>       \
>   B ---+--
> 
> and
> 
>   A ---+--
>       /
>   B --
> 
> are considered as different ones by Cogito

Ok. So you do

A ---+--
    /
B --

and now merge A to B, which results in fast-forward and

A ---+----
    /  \
B --    --

but when doing cg-log in B, the merge is the wrong way around now.

Sean counterexample works too, it's a good thing to maintain
compatibility with git at this one too.

Still, I would like to have the files list separated. What about one
bullet per parent? Like

    * asdf, hjkl, xyzzy
    * hjkl, quux

for a regular two-parents merge.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
