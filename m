From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: cg-log patches
Date: Mon, 9 May 2005 09:13:47 -0400 (EDT)
Message-ID: <4712.10.10.10.24.1115644427.squirrel@linux1>
References: <1742.10.10.10.24.1115573750.squirrel@linux1>
    <20050508234936.GA26624@diku.dk>
    <4302.10.10.10.24.1115610350.squirrel@linux1>
    <20050509113907.GA22830@diku.dk> <20050509121435.GB18382@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Jonas Fonseca" <fonseca@diku.dk>,
	"GIT Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 15:08:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV7y1-00004w-Tg
	for gcvg-git@gmane.org; Mon, 09 May 2005 15:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVEINNv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 09:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVEINNv
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 09:13:51 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:42937 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261354AbVEINNs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2005 09:13:48 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050509131347.GMIA1623.simmts8-srv.bellnexxia.net@linux1>;
          Mon, 9 May 2005 09:13:47 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j49DDiS2004546;
	Mon, 9 May 2005 09:13:44 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Mon, 9 May 2005 09:13:47 -0400 (EDT)
In-Reply-To: <20050509121435.GB18382@pasky.ji.cz>
To: "Petr Baudis" <pasky@ucw.cz>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 9, 2005 8:14 am, Petr Baudis said:

> But that makes no sense, since each merge will have enormous amount of
> files listed, making no sense. E.g. each merge of Cogito with Linus will
> have all the Cogito files listed, since they aren't in the Linus branch
> - but that's wrong, since the merge _to_ the Cogito branch concerns no
> Cogito files.
>
> In git, the parents list is unordered. But this is different in Cogito,
> where the first parent _is_ special. If you are merging _from_ branch B
> _to_ branch A, the order of parents will be always

But, there are commits (even in your tree) that aren't produced by Cogito.
 And the current logic gets them wrong.

Look at commit:  211232bae64bcc60bbf5d1b5e5b2344c22ed767e in your tree.

The current logic will miss the fact that one of the other parents
altered, git-apply-patch-script.   Seems better to over report, than under
report changes, although I agree that some way must be found to handle the
merge case.

Sean


