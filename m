From: Sergio <sergio.callegari@gmail.com>
Subject: Re: Grafts workflow for a
Date: Tue, 16 Sep 2008 19:12:51 +0000 (UTC)
Message-ID: <loom.20080916T190745-332@post.gmane.org>
References: <46a038f90809152209l2230d9e3o442dac1f5047d2bd@mail.gmail.com> <20080916052425.GA14644@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 21:14:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfg0B-0005pT-RT
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 21:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053AbYIPTNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 15:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754072AbYIPTNL
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 15:13:11 -0400
Received: from main.gmane.org ([80.91.229.2]:41816 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752953AbYIPTNK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 15:13:10 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Kffyz-0004ln-HH
	for git@vger.kernel.org; Tue, 16 Sep 2008 19:13:06 +0000
Received: from D-69-91-163-33.dhcp4.washington.edu ([69.91.163.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 19:13:05 +0000
Received: from sergio.callegari by D-69-91-163-33.dhcp4.washington.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 19:13:05 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.91.163.33 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.16) Gecko/20080715 Ubuntu/7.10 (gutsy) Firefox/2.0.0.16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96028>

Shawn O. Pearce <spearce <at> spearce.org> writes:

> 
> Martin Langhoff <martin.langhoff <at> gmail.com> wrote:
> > Here is my attempt at a "let's publish a shallow repository for branch
> > of moodle". Let me show you what I did...
> ...
> >  # 1.7 was a significant release, anything earlier than that
> >  # is just not interesting -- even for pickaxe/annotate purposes
> >  # so add a graft point right at the branching point.
> ...
> > Is this kind of workflow (or a variation of it) supported? For this to
> > work, we should communicate the grafts in some push operations and
> > read them in clone ops - and perhaps in fetch too.
> 
> Currently the grafts file isn't transferred over any transport
> protocol as it is considered to be local only to the repository.
> 
> For one thing, grafts are a security risk.  Any user can graft
> anything in at any position and log/blame operations will honor
> the graft, rather than what is stored in the signed commit chain.
> Its a low risk, but it allows a peer to lie to you and give you
> something other than what you asked for.
> 

Would it make sense to differentiate two types of grafts, just like we
differentiate two kind of tags?

Then there could be "annotated grafts objects" that could be optionally signed
and that would get transferred on clones, fetches, pushes, etc.

Sergio
