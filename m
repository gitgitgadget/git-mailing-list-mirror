From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What's cooking in git/spearce.git (topics)
Date: Mon, 22 Oct 2007 17:27:17 +0200
Message-ID: <C711793E-BBA0-4AB5-84A7-D37555F80676@zib.de>
References: <20071022063222.GS14735@spearce.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 17:26:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjzAO-0000yR-JQ
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 17:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbXJVPZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 11:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbXJVPZz
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 11:25:55 -0400
Received: from mailer.zib.de ([130.73.108.11]:63968 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752214AbXJVPZz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 11:25:55 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9MFPqpG007537;
	Mon, 22 Oct 2007 17:25:52 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9MFPpLZ023731
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 22 Oct 2007 17:25:52 +0200 (MEST)
In-Reply-To: <20071022063222.GS14735@spearce.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62022>


On Oct 22, 2007, at 8:32 AM, Shawn O. Pearce wrote:

> * sp/push-refspec (Sun Oct 14 10:54:45 2007 +0200) 6 commits
>  - push, send-pack: use same rules as git-rev-parse to resolve
>    refspecs
>  - add ref_cmp_full_short() comparing full ref name with a short name
>  - push, send-pack: support pushing HEAD to real ref name
>  - rev-parse: teach "git rev-parse --symbolic" to print the full ref
>    name
>  - add get_sha1_with_real_ref() returning full name of ref on demand
>  - push, send-pack: fix test if remote branch exists for colon-less
>    refspec
>
> I've briefly looked at this series and there's reasons why its not
> in next yet.

It's not ready for next. Especially the last patch in the list
changes the existing behaviour in a way that might be unexpected
by longtime git users. And maybe we even need for the 1.6 cycle
before we can change the behaviour of git push.


> Its actually something that I'm interested in seeing
> fixed as the current behavior of how git-push matches refs on the
> remote side is just plain nuts.  I'll look at it further after I
> get ph/parseopt and cc/skip into next.

I planned to draw a conclusion from the discussion in

http://marc.info/?l=git&m=119286893014690&w=2

and send an updated proposal based on what I learnt. But
unfortunately I didn't have time yet.

My impression now is that the details of the behaviour of "git
push" are hard to understand and should be made more explicit.

Related tasks are currently encoded in the refspecs, but the
details are not always obvious right away:
- creation of new branches on the remote side.
- deletion of branches on the remote side.
- pushing of branches matching on local and remote side.
- pushing local branches explicitly to a different ref on the remote.
- save newbies from pushing to 'non-standard' location, that
   is only push to heads and tags.
- but also allow to push to funny refs if you force git to
   do this.

All this is related to the topic above, although its maybe too much
to be solved at once.

	Steffen
