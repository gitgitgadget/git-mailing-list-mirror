From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC 2/2] completion: allow use without compiling
Date: Tue, 27 Oct 2009 11:52:23 -0700
Message-ID: <20091027185223.GH10505@spearce.org>
References: <1256589116-6998-1-git-send-email-bebarino@gmail.com> <1256589116-6998-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 19:52:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2r9i-0005Y7-BK
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 19:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374AbZJ0SwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 14:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756304AbZJ0SwT
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 14:52:19 -0400
Received: from george.spearce.org ([209.20.77.23]:43258 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206AbZJ0SwT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 14:52:19 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0AE4F381D3; Tue, 27 Oct 2009 18:52:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1256589116-6998-3-git-send-email-bebarino@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131369>

Stephen Boyd <bebarino@gmail.com> wrote:
> Some users don't want to compile their completion, even when the build
> generated completion is 10x faster to load. For example, in my bashrc I
> source the completion script directly so I can stay up to date with the
> latest completion by merely pulling changes.
> 
> Do this by generating the lists dynamically when the merge strategy and
> command lists still have their initial values (__GIT_MERGE_STRATEGYLIST,
> __GIT_ALL_COMMANDLIST).
> 
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
> 
>  This duplicates code, but I don't know of a way to re-use the dynamic
>  code without sourcing a bash script and possibly breaking someone's build.

NAK on code duplication, especially this much.  As Junio already
pointed out in this thread we need an approach that doesn't cause
this sort of redundant code.

I'm trying to catch up on email right now.  I have no great
suggestions on how to implement this to avoid the code duplication
and still be able to support both compile-time and on-the-fly
computation, but I do know I don't want this code twice.

-- 
Shawn.
