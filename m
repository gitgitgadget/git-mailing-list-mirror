From: Junio C Hamano <gitster@pobox.com>
Subject: Re: fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
Date: Fri, 08 Jun 2007 03:15:54 -0700
Message-ID: <7vodjqkazp.fsf@assigned-by-dhcp.cox.net>
References: <20070608100831.GA2335@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Fri Jun 08 12:16:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwbVh-0006aR-Ey
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 12:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761922AbXFHKP4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 06:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937244AbXFHKP4
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 06:15:56 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:60056 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932165AbXFHKPz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 06:15:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070608101554.WLSD7825.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Fri, 8 Jun 2007 06:15:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8yFu1X0021kojtg0000000; Fri, 08 Jun 2007 06:15:54 -0400
In-Reply-To: <20070608100831.GA2335@cip.informatik.uni-erlangen.de> (Thomas
	Glanzmann's message of "Fri, 8 Jun 2007 12:08:31 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49454>

Thomas Glanzmann <thomas@glanzmann.de> writes:

> Hello,
>
>         (s017241) [/usr/src/linux-2.6] git checkout v2.6.20
>         warning: You appear to be on a branch yet to be born.
>         warning: Forcing checkout of v2.6.20.
>         fatal: ambiguous argument 'HEAD': unknown revision or path not in the working tree.
>         Use '--' to separate paths from revisions
>         Cannot detach HEAD
>
> (s017241) [/usr/src/linux-2.6] git version
> git version 1.5.2.1
>
> what is going wrong here?

Perhaps repository was set up in an unusual way by hand
(i.e. not by a clone), such that:

 1. you have HEAD pointing at a branch (e.g. 'refs/heads/master'),
 2. which does _not_ exist yet (i.e. no 'refs/heads/master'),
 3. yet you have a tag that you can try to detach your HEAD to (e.g. v2.6.20).

... well that was my initial guess, but even after setting up such a
funny repository by hand, I cannot seem to reproduce it.
