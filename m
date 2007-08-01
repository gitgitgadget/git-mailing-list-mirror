From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-sh-setup.sh: make GIT_EDITOR/core.editor/VISUAL/EDITOR accept commands
Date: Thu, 02 Aug 2007 01:58:14 +0200
Message-ID: <85sl72x0x5.fsf@lola.goethe.zz>
References: <7v7iof3uc5.fsf@assigned-by-dhcp.cox.net>
	<S1752294AbXHAWCj/20070801220239Z+281@vger.kernel.org>
	<85ejimrjb2.fsf@lola.goethe.zz>
	<7vy7gu3kuh.fsf@assigned-by-dhcp.cox.net>
	<7vtzri3kpr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 01:59:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGO5x-0004sy-2N
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 01:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556AbXHAX7J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 19:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752927AbXHAX7I
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 19:59:08 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:38609 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752661AbXHAX7H (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 19:59:07 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 9F8CD1E54DE;
	Thu,  2 Aug 2007 01:59:05 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 8C4A8114459;
	Thu,  2 Aug 2007 01:59:05 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-069.pools.arcor-ip.net [84.61.17.69])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 63D073425E2;
	Thu,  2 Aug 2007 01:59:05 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id AC1E31C3E076; Thu,  2 Aug 2007 01:58:14 +0200 (CEST)
In-Reply-To: <7vtzri3kpr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 01 Aug 2007 16\:21\:04 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV version 0.91.1, clamav-milter version 0.91.1 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54503>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> It is not just "won't apply".  What if GIT_DIR had spaces (which
>> is fine) and single-quotes in it?  Wouldn't it percolate down to
>> $@ because it becomes the leading directory of the temporary
>> file name?  And you quote '"$@"' and eval it, now what happens?
>
> Ah, I spoke too fast.  It is fine --- the shell that actually is
> doing the eval then interpolates "$@".  Clever.

Since eval folds all its arguments into a single string separated by
single blanks, actual blanks (which can be multiple or interspersed
with newlines) must not yet be seen.  The string '"$@"' contains no
blanks and thus gets through unmolested.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
