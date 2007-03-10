From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Split sample update hook into post-receive hook
Date: Sat, 10 Mar 2007 03:29:23 -0500
Message-ID: <20070310082923.GA4092@spearce.org>
References: <20070308041618.GA29744@spearce.org> <81b0412b0703080026v6f3990c3x2cefca661b64e00d@mail.gmail.com> <20070308083317.GB30289@spearce.org> <7vy7m8aytt.fsf@assigned-by-dhcp.cox.net> <20070308091313.GC30289@spearce.org> <20070308124024.d20e29c9.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>,
	Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Sat Mar 10 09:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPwxl-0004Fn-Po
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 09:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933234AbXCJI3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 03:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933296AbXCJI3a
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 03:29:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60169 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933234AbXCJI33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 03:29:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPwx9-0003dc-NH; Sat, 10 Mar 2007 03:29:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6668F20FBAE; Sat, 10 Mar 2007 03:29:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070308124024.d20e29c9.vsu@altlinux.ru>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41862>

Sergey Vlasov <vsu@altlinux.ru> wrote:
> On Thu, 8 Mar 2007 04:13:13 -0500 Shawn O. Pearce wrote:
> > Agree completely.  I'm not too worried about it.  1300 ref push is
> > just not going to really occur in practice; that is just insane.
> > 30 refs, maybe.
> 
> It is not completely insane - e.g., the current klibc repository
> already contains 338 tags.  Being unable to use "git push --tags" to
> an initially empty repository does not look good.
> 
> So could you please switch to passing refs through stdin while we
> still can do it without breaking public interfaces?

Fixed with my latest 8 patch series.  We now pass the ref data
to the new {pre,post}-receive hooks by stdin, rather than as
command line arguments.

Thanks for the reality check.  ;-)

-- 
Shawn.
