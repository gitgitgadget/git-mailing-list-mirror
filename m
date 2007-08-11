From: David Kastrup <dak@gnu.org>
Subject: Re: [fixed PATCH] git-filter-branch.sh: Fix broken setting of GIT_DIR
Date: Sat, 11 Aug 2007 14:12:54 +0200
Message-ID: <858x8iw9q1.fsf@lola.goethe.zz>
References: <868x8j7aj2.fsf@lola.quinscape.zz>
	<864pj74ay9.fsf@lola.quinscape.zz>
	<7vk5s2mllf.fsf@assigned-by-dhcp.cox.net>
	<85r6mawedp.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 14:13:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJpqH-0003Fm-Ue
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 14:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755905AbXHKMM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 08:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755678AbXHKMM6
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 08:12:58 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:54315 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754101AbXHKMM5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 08:12:57 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 32E0F15BEDE;
	Sat, 11 Aug 2007 14:12:55 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id 194B12DA967;
	Sat, 11 Aug 2007 14:12:55 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-066.pools.arcor-ip.net [84.61.49.66])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 8202F22D166;
	Sat, 11 Aug 2007 14:12:54 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 1A7851C3C79D; Sat, 11 Aug 2007 14:12:54 +0200 (CEST)
In-Reply-To: <85r6mawedp.fsf@lola.goethe.zz> (David Kastrup's message of "Sat\, 11 Aug 2007 12\:32\:18 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3923/Sat Aug 11 10:03:45 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55606>

David Kastrup <dak@gnu.org> writes:

> Anyway, if $GIT_DIR is a relative path, things would go wrong in some
> lines earlier,

and if GIT_DIR were used or exported which it isn't, so we are lucky...

> where the path is already being changed.
>
> If git-sh-setup sets GIT_DIR, perhaps it would be sanest if it also
> made it absolute?
>
> Otherwise any script that does "cd" will lose track of GIT_DIR, right?

Actually, wouldn't by far the most straightforward thing be if
git-rev-parse --git-dir always returned an absolute path (even when
being passed a relative path in GIT_DIR)?

No need for postprocessing, no need to keep track of changed
directories.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
