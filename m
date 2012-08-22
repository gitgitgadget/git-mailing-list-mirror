From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [Q] Comparing differences introduced by two commits?
Date: Wed, 22 Aug 2012 16:15:52 +0100
Message-ID: <CAF5DW8L=6wn6wumzwJuC=QMkb3ggZoPxOJrZf=FQEdArwNzzdw@mail.gmail.com>
References: <2794881.R5SsgFdXjR@laclwks004>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Brian Foster <brian.foster@maxim-ic.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 18:09:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4DUQ-00048i-Fk
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 18:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418Ab2HVQJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 12:09:00 -0400
Received: from gardner.asmallorange.com ([184.173.73.186]:42320 "EHLO
	gardner.asmallorange.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab2HVQI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 12:08:58 -0400
X-Greylist: delayed 3164 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Aug 2012 12:08:58 EDT
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44680)
	by gardner.asmallorange.com with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.77)
	(envelope-from <maillist@steelskies.com>)
	id 1T4CfF-002mhV-RJ
	for git@vger.kernel.org; Wed, 22 Aug 2012 11:16:13 -0400
Received: by yenl14 with SMTP id l14so769893yen.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 08:16:13 -0700 (PDT)
Received: by 10.50.191.227 with SMTP id hb3mr2548230igc.45.1345648572795; Wed,
 22 Aug 2012 08:16:12 -0700 (PDT)
Received: by 10.43.56.79 with HTTP; Wed, 22 Aug 2012 08:15:52 -0700 (PDT)
In-Reply-To: <2794881.R5SsgFdXjR@laclwks004>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gardner.asmallorange.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - steelskies.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204024>

On 22 August 2012 13:10, Brian Foster <brian.foster@maxim-ic.com> wrote:
>
> Hello,
>
>  I have two commits A and B.  They are on separate branches.
>  Commit A is a older version of B.  I want to see what, if
>  any, differences there are between what commit A changes
>  and what commit B changes.  (The relative positions of
>  two commits may also differ in the two branches; that is,
>  there may have been some commit re-ordering.)
>
>  Ideally, the contents of the commit-message are also taken
>  into account (albeit things like the commit-Id, dates, and
>  so on will differ and therefore should be ignored).
>
>  I realize the history leading up to each commit can itself
>  cause what the commits change to differ, even if the "net
>  result" of the two commits is the same.  For my purposes,
>  this is a noise issue, and I'm happy to consider A and B
>  as not causing the same changes (i.e., as being different),
>  albeit if the only difference is the line numbers, then it
>  would be nice to ignore that.
>
>  In the past I've done:
>
>     diff <(git show A) <(git show B)
>
>  which produces rather messy output but is Ok when dealing
>  with just one or two sets of A/B commits.  I now have a
>  large-ist set of A/B commits, and the above is impractical.
>
>  Some searching hasn't found any suggestions I'm too happy
>  with, albeit I've very possibly overlooked something.

What about cherry picking B onto A, then showing the cherry-picked commit?

Off the top of my head :

git checkout A
git cherry-pick B
git show HEAD

-Jonathan
