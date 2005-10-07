From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some ASCII Art
Date: Fri, 07 Oct 2005 12:42:52 -0700
Message-ID: <7vk6gpyuyr.fsf@assigned-by-dhcp.cox.net>
References: <1128621923.29904.30.camel@cashmere.sps.mot.com>
	<7v8xx67559.fsf@assigned-by-dhcp.cox.net>
	<1128713749.29904.84.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 07 21:43:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENy7O-0002qS-70
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 21:42:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030535AbVJGTmy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 15:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030537AbVJGTmy
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 15:42:54 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:29672 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030535AbVJGTmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2005 15:42:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051007194239.NTFD776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Oct 2005 15:42:39 -0400
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1128713749.29904.84.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Fri, 07 Oct 2005 14:35:50 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9814>

Jon Loeliger <jdl@freescale.com> writes:

> Would it be a useful option to git-show-branch
> that would state the commit SHA1s as well?
>
>     % git show-branch --show-revs
>
>     * [master] Merge paul's branch
>      ! [origin] Fix drm 'debug' sysfs permissions
>       ! [paul] powerpc: Fix idle.c compile warning
>     ---
>     +   [06a41091c93e529e6cef68ba60deeb1b9ceabc7f] Merge paul's branch
>     + + [05f62a5c049845eab8dfb3aeda55c18a2d4396e3] powerpc: Fix idle.c compile warning
>     + + [c16ff7e44883afc05cbf6fde0e6913bb10c66885] powerpc: Define a _sdata symbol
>     + + [8dad3f9257414f151cd821bfe01f54d7f52d2507] powerpc: Merge traps.c a bit more
>     + + [b3491269f5604e4265ee2f27b47a76ce1e3678b6] powerpc: Use the merged of_device.c with ARCH=powerpc

In practice, probably 30 or so bits prefix would identify an
object uniquely within a repository, so one possibility is to
use the first 7 or so letters from 40-byte SHA1, after making
sure 7 is enough for that particular prefix -- otherwise use
more for that particular object.

The current "relative to the head" notation is descriptive and
easier to see when you do not have too many branches and complex
merge structure but one major drawback is that it is not stable;
you add a commit then what was used to be master~5 now suddenly
become master~6.
