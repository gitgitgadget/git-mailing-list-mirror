From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] completion: fix alias listings with newlines
Date: Wed, 7 Oct 2009 21:29:17 -0700
Message-ID: <20091008042917.GX9261@spearce.org>
References: <1254905331-29516-1-git-send-email-bebarino@gmail.com> <4ACC6055.1070204@viscovery.net> <4ACCE417.5080907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 06:31:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mvkef-0007a9-Me
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 06:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbZJHE3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 00:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZJHE3y
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 00:29:54 -0400
Received: from george.spearce.org ([209.20.77.23]:40500 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbZJHE3y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2009 00:29:54 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C9906381FE; Thu,  8 Oct 2009 04:29:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4ACCE417.5080907@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129670>

Stephen Boyd <bebarino@gmail.com> wrote:
> Johannes Sixt wrote:
> > Is it necessary to change the body of the loop? Your version spawns two
> > processes on each iteration, while the original spawned no processes.

Yes, we should try to avoid spawning a process here, it fires on
each completion attempt if I recall.

> Maybe a better solution would be to add --keys-only or something to
> git-config?

Or a format string with a language based escape like for-each-ref
supports?  Might make it easier to use git config in scripts if we
can write things like:

  git config --format='$data{%(key)}=%(value);' --perl

-- 
Shawn.
