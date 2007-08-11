From: David Kastrup <dak@gnu.org>
Subject: Re: [fixed PATCH] git-filter-branch.sh: Fix broken setting of GIT_DIR
Date: Sat, 11 Aug 2007 23:04:54 +0200
Message-ID: <857io1u6ix.fsf@lola.goethe.zz>
References: <868x8j7aj2.fsf@lola.quinscape.zz>
	<864pj74ay9.fsf@lola.quinscape.zz>
	<7vk5s2mllf.fsf@assigned-by-dhcp.cox.net>
	<85r6mawedp.fsf@lola.goethe.zz> <858x8iw9q1.fsf@lola.goethe.zz>
	<851weaw8z6.fsf@lola.goethe.zz>
	<7vbqddn8zj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 23:05:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJy8t-0007K1-H8
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 23:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758130AbXHKVE7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 17:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758031AbXHKVE6
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 17:04:58 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:33328 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757700AbXHKVE5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 17:04:57 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 7B22F43E05;
	Sat, 11 Aug 2007 23:04:56 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 6D573114372;
	Sat, 11 Aug 2007 23:04:56 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-066.pools.arcor-ip.net [84.61.49.66])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 018BF225124;
	Sat, 11 Aug 2007 23:04:55 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id EB10F1C3C79D; Sat, 11 Aug 2007 23:04:54 +0200 (CEST)
In-Reply-To: <7vbqddn8zj.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 11 Aug 2007 12\:53\:36 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3924/Sat Aug 11 17:29:49 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55633>

Junio C Hamano <gitster@pobox.com> writes:

> I think your other patch to always give full path to the shell
> scripts from git-sh-setup makes sense.  Could you please make
> test scripts to expose the problems you described in the message
> I am replying to and add it as say t/t2050-git-dir-relative.sh?

It is actually a bit harder to trigger than I expected: if GIT_DIR is
not a direct descendant of the current directory, git-rev-parse does
output an absolute path.  So at least for the test failure in
git-commit, I have to revert to a non-run-of-the-mill setup.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
