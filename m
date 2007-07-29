From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Makefile: create an install-symlinks target
Date: Mon, 30 Jul 2007 00:30:08 +0200
Message-ID: <85bqduvo5r.fsf@lola.goethe.zz>
References: <85lkcyvr4f.fsf@lola.goethe.zz>
	<7vk5sin9g0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 00:31:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFHI6-0008U7-TT
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 00:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbXG2Wan (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 18:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbXG2Wam
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 18:30:42 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:46537 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964900AbXG2Wal (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jul 2007 18:30:41 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 2814F18B441;
	Mon, 30 Jul 2007 00:30:40 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id 19C0012BE98;
	Mon, 30 Jul 2007 00:30:40 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-015.pools.arcor-ip.net [84.61.17.15])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id E879A3425E4;
	Mon, 30 Jul 2007 00:30:39 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9A8641C39595; Mon, 30 Jul 2007 00:30:08 +0200 (CEST)
In-Reply-To: <7vk5sin9g0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sun\, 29 Jul 2007 15\:15\:11 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3808/Sun Jul 29 22:05:04 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54143>

Junio C Hamano <gitster@pobox.com> writes:

> I thought we already rejected the "install symlink" in the
> earlier round.  Am I mistaken, or are there any compelling new
> reasons to revisit it?

Uh, perhaps I have a patchy recollection, but what I remember is that
Scho argued that one might use something like xstow or a package
manager instead, and I replied that

a) this required the installation of additional software for a simple
   task.

b) if the software worked using symbolic links, it would not know at
   what level to make the links (namely create
   /usr/local/share/man/man1 and link every file from
   /opt/git/share/man/man1, but link the directory
   /usr/local/share/git-core directly to /opt/git/share/git-core).

I don't remember a conclusive reply to that.  Not seeing the patch
appear either, I decided to clean it up, remove the objection of using
the GNU-specific -mindepth option, and properly document the usage.

Since the stuff is strictly an additional convenience not impacting
any of the existing targets, I would not have thought it terribly
controversial.

If I have misinterpreted or misremembered part of the discussion, I
apologize.  No harm was intended.

In any case, some people might want to make use of the polished patch
series even if it is not applied to git.git.

Is there a place other than the git list where one can provide patches
that are not likely to end up in git.git?

Thanks,

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
