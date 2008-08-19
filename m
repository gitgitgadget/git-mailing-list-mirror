From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 12:59:28 -0700
Message-ID: <20080819195928.GB24212@spearce.org>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com> <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com> <20080819185804.GA17943@coredump.intra.peff.net> <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com> <20080819190832.GC17943@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 22:00:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVXNZ-0007S8-3W
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 22:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbYHST73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbYHST73
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:59:29 -0400
Received: from george.spearce.org ([209.20.77.23]:60957 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbYHST72 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:59:28 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 653F338375; Tue, 19 Aug 2008 19:59:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080819190832.GC17943@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92919>

Jeff King <peff@peff.net> wrote:
> I think the common wisdom has been that such tests should be done on the
> _receiving_ end, since that makes a more trustworthy enforcement point.
> E.g., I know that crap can't get into my central repo because a hook
> checks everything coming in. But if a developer has turned off his
> pre-push hook (or accidentally failed to enable it), he can still send
> crap.
> 
> One other argument I have seen is that, to prevent the proliferation of
> hooks, the rule is not to add a hook that could just as easily be done
> as a sequence of commands. IOW, what's wrong with
> 
>   run_my_automated_tests && git push

Yup, I agree completely.

Why not just setup an alias:

	git config alias.send '! run_my_tests && git push "$@"'

and retrain your fingers to use "git send ..."?
 
-- 
Shawn.
