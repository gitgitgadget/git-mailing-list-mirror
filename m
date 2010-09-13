From: Stephen Bash <bash@genarts.com>
Subject: Re: git log for a merged branch
Date: Mon, 13 Sep 2010 09:37:58 -0400 (EDT)
Message-ID: <30770696.248360.1284385078695.JavaMail.root@mail.hq.genarts.com>
References: <201009090117.06555.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Mon Sep 13 15:38:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ov9Ed-0005dm-4O
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 15:38:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab0IMNiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 09:38:07 -0400
Received: from hq.genarts.com ([173.9.65.1]:51027 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751792Ab0IMNiG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 09:38:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 875AF1E2636A;
	Mon, 13 Sep 2010 09:38:05 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TGAazEOyD2t4; Mon, 13 Sep 2010 09:37:58 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id C05421E26354;
	Mon, 13 Sep 2010 09:37:58 -0400 (EDT)
In-Reply-To: <201009090117.06555.barra_cuda@katamail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156089>



----- Original Message -----
> From: "Michele Ballabio" <barra_cuda@katamail.com>
> To: "Stephen Bash" <bash@genarts.com>
> Cc: "Git Mailing List" <git@vger.kernel.org>
> Sent: Wednesday, September 8, 2010 7:17:05 PM
> Subject: Re: git log for a merged branch
> On Wednesday 08 September 2010, Stephen Bash wrote:
>
> Let's call the merge commit "mergecmt". The commit where the "release"
> branch
> branched off is
> 
> git merge-base mergecmt^1 mergecmt^2
> 
> ... where mergecmt^1 is the first parent of the merge (usually on the
> "mainline" branch) and mergecmt^2 is the second parent, which
> usually(*)
> refers to the "release" branch (in this case, tagFoo).
> 
> So
> 
> git log $(git merge-base mergecmt^1 mergecmt^2)..mergecmt^2
> 
> is what you want.
> 
> > To complicate things a bit more, in the real world there may be
> > multiple
> > merges from the release branch to mainline during the life of the
> > release
> > branch, so any solution that also deals with that would be
> > outstanding
> > (probably at the cost of additional complexity?)
> 
> Maybe something like:
> 
> for i in $(git rev-list --merges last_interesting_tag..mainline)
> do
> git log $(git merge-base $i^1 $i^2)..$i^2
> done

Hm...  Makes sense...  I'll have to play with it a little bit to get a good feel for how it fits our workflow, but it seems like a really good option.

Thanks!

Stephen
