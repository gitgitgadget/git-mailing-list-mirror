From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Does anyone use git-notes?
Date: Wed, 25 Aug 2010 20:52:37 +0200
Message-ID: <201008252052.37524.trast@student.ethz.ch>
References: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 20:52:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoL5a-0001oy-K6
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 20:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab0HYSwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 14:52:41 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:14020 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142Ab0HYSwk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 14:52:40 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Wed, 25 Aug
 2010 20:52:40 +0200
Received: from thomas.site (84.74.100.241) by CAS21.d.ethz.ch (172.31.51.111)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Wed, 25 Aug 2010 20:52:38
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <AANLkTin=VXp2BU0vhTLUy6MpJ7spXRs1dZC1wygoN6T-@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154460>

Scott Chacon wrote:
> I would like to write a post on how to use them, but I'm a bit
> confused as to how people actually use them on a day to day basis.  I
> appears to me in trying to work out a flow for them that the lack of
> an ability to merge them makes them very difficult to use for anything
> practical.  Can someone share with me how they use them and what the
> cycle is?

I run a cronjob that downloads mail from gmane and fetches git.git,
then attempts to correlate mail with commits.  The results are at

  git://repo.or.cz/git/trast.git notes/terse notes/full

I have previously posted about this at e.g.

  http://mid.gmane.org/200902091508.11460.trast@student.ethz.ch
  http://mid.gmane.org/201003042321.36240.trast@student.ethz.ch

though I should point out that it no longer tries to apply the patches
as outlined in the first post; this was simply way too expensive.


I also use it when heavily editing a patch series to tack little
reminders on my fixup patches.  I have

  $ git config alias.fixup
  !sh -c 'r=$1; git commit -m"fixup! $(git log -1 --pretty=%s $r)"' -

so I usually do

  # hack
  git add -p
  git fixup HEAD~3
  git notes add -m 'fix foo'

which combined with notes.rewriteRef=refs/notes/* (and
notes.rewriteMode left at the default of 'concatenate') means that I
end up having a little list of reminders what changed since the last
revisions.  I then simply clear them out before starting a new round.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
