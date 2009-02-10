From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Trouble testing out a patch on a branch new scratch git.git
  repository
Date: Tue, 10 Feb 2009 05:32:09 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngp24ap.i22.sitaramc@sitaramc.homelinux.net>
References: <e38bce640902081256j3cd84aadn2f0cc863cfca904d@mail.gmail.com>
 <7vy6wgwqjp.fsf@gitster.siamese.dyndns.org>
 <e38bce640902081613v3e93c1e3g716118c38ce861ab@mail.gmail.com>
 <200902081918.35665.bss@iguanasuicide.net>
 <e38bce640902081859o47462a58s59c120209fabb0@mail.gmail.com>
 <7vmycww6if.fsf@gitster.siamese.dyndns.org>
 <e38bce640902091359j3f306839h9aeb699e18e420ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 10 06:33:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWlFp-00088J-Cf
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 06:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbZBJFc0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 00:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbZBJFcZ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 00:32:25 -0500
Received: from main.gmane.org ([80.91.229.2]:58194 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbZBJFcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 00:32:25 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LWlEK-0005Lp-Q7
	for git@vger.kernel.org; Tue, 10 Feb 2009 05:32:21 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 05:32:20 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 05:32:20 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109181>

On 2009-02-09, Brent Goodrick <bgoodr@gmail.com> wrote:
> To explain what I mean: Yesterday, I had this configuration on my
> bg/no-progress branch:
>
>              A---B---C---D (bg/no-progress)
>             /
> ----1-----2----3----4 (master)
>
> B C and D commits are noisy,
> fix-the-white-space-and-conform-to-coding-guidelines type commits. I
> want to collapse A through D into one commit called E on that branch
> so that I can run git format-patch -M on the result and provide a nice
> patch email. I would end up with:
>
>              E (bg/no-progress)
>             /
> ----1-----2----3----4 (master)

You want to squash the last 4 patches on the current branch
into one?

The fastest way, if you don't mind re-typing the commit
message for the combined commit, is this:

    git reset --soft HEAD~4
    git commit

A kinder, gentler, way is this:

(1) type in 'git rebase -i HEAD~4'

(2) In the editor that pops up, change the 'pick' on all but
    the first entry to 'squash' or just 's' and save the
    file.

    There won't be any conflicts in this scenario, so don't
    worry about that.

(3) Another editor will pop up showing all 4 commit messages
    in one edit buffer -- combine the various commit
    messages however you wish and save the file.

Done :-)

-- 
Sitaram
