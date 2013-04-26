From: Yann Dirson <dirson@bertin.fr>
Subject: Re: Itches with the current rev spec
Date: Fri, 26 Apr 2013 10:19:46 +0200
Organization: Bertin Technologies
Message-ID: <20130426101946.433f2d12@chalon.bertin.fr>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 26 10:19:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVdso-0005ls-No
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 10:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757471Ab3DZITs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 04:19:48 -0400
Received: from blois.bertin.fr ([195.68.26.9]:61622 "EHLO blois.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979Ab3DZITq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 04:19:46 -0400
Received: from blois.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 9BACA6AAE7
	for <git@vger.kernel.org>; Fri, 26 Apr 2013 10:19:44 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by blois.bertin.fr (Postfix) with ESMTP id 795E16AAD1
	for <git@vger.kernel.org>; Fri, 26 Apr 2013 10:19:44 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MLU00DZTSGW8D50@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Fri, 26 Apr 2013 10:19:44 +0200 (CEST)
In-reply-to: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8250-7.0.0.1014-19824.004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222508>

>2. git rebase -i master fails unless I've rebased my branch on top of
>master.  I always wished I could do the equivalent of 'git rebase -i
>master..', but I can't.  Can we give the A..B syntax a new meaning in
>the context of rebase, namely $(git merge-base A B)? 

If I understand well, you're refering to a problem that also annoys me,
ie. using "rebase -i" to just edit your local commits, without rebasing
onto the lastest revision on the upstream branch, right ?  That is, just
another wart of having a single command for arguably-different use cases,
or of having the single-argument version of rebase use that argument for
2 very different things (cut-off point and destination), but I won't try
to address either of these today :)

In that case, what about just adding a new flag to "rebase -i", that would
prevent the single-argument to be interpreted as destination ?  I really
consider this a workaround for a suboptimal CLI, but since we don't want
to change the rebase CLI before at least 2.0, that could fill the gap for now.

As for the flag itself, what about --here ?  Obviously it would only be
meaninglful together with -i, and be exclusive with --onto.

-- 
Yann Dirson - Bertin Technologies
