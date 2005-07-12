From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Tue, 12 Jul 2005 18:29:26 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.12.16.29.24.715453@smurf.noris.de>
References: <20050708230750.GA23847@buici.com> <Pine.LNX.4.58.0507081842550.17536@g5.osdl.org> <20050711222046.GA21376@buici.com> <7vll4dndwu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507111646000.17536@g5.osdl.org> <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org> <20050712021004.GA27576@buici.com> <Pine.LNX.4.58.0507112005540.17536@g5.osdl.org> <Pine.LNX.4.58.0507112045420.17536@g5.osdl.org> <Pine.LNX.4.58.0507112132170.17536@g5.osdl.org> <20050712074801.GD6363@pasky.ji.cz> <7vy88c5r4w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Jul 12 18:36:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsNiK-0007bK-UU
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 18:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVGLQdy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 12:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVGLQcH
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 12:32:07 -0400
Received: from main.gmane.org ([80.91.229.2]:62139 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261581AbVGLQae (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 12:30:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DsNdu-0006tA-Lo
	for git@vger.kernel.org; Tue, 12 Jul 2005 18:29:58 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 18:29:58 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 12 Jul 2005 18:29:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Junio C Hamano wrote:

> Having said that, I do like the concept of keeping track of
> "which development line are we on, and what's most recent in
> it".  The way I read your description of cg-seek, you currently
> have that information is either in .git/head-name and
> .git/refs/heads/<head-name> pair (when .git/head-name exists),
> or .git/HEAD.

Personally, I'd rather have as few invariants as possible, so that various
Porcelains can agree on semantics.

What I would expect from a sane .git tree is that
* .git/HEAD contains the commit that is currently checked out.
* If HEAD is not a symlink, then switching to a branch HEAD is not a part
  of should emit a warning.
  ("fsck to find the dangling commits" is not an answer ;-)

Ideas like
* remember the branch to un-seek back to
or
* treat HEAD as read-only when there's a seek active

seem to be optional / Porcelain-specific.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"We'll strategically withdraw to previously prepared position."
"Who prepared them?"
"we'll prepare them when we get there."
		-- Terry Pratchett (Reaper Man)
