From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Git crash in Ubuntu 12.04
Date: Thu, 11 Apr 2013 17:06:59 +0400
Message-ID: <20130411170659.a35d2c581cf34ade13448bfa@domain007.com>
References: <CAJiNi_FfU9Gsr2D9CcC0wWwgO1oKBXwxp87-wBUJBU2kyGaQNQ@mail.gmail.com>
	<87mwt6ltia.fsf@linux-k42r.v.cablecom.net>
	<CAJiNi_EgjgKs7oNJyGcamUFz=ARDAuBTb+bJ0uVsPFBMbZF3YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Sivaram Kannan <siva.devel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 15:07:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQHDh-0004vb-9p
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 15:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000Ab3DKNHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 09:07:09 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:33309 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab3DKNHI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 09:07:08 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r3BD6xBb002921;
	Thu, 11 Apr 2013 17:07:00 +0400
In-Reply-To: <CAJiNi_EgjgKs7oNJyGcamUFz=ARDAuBTb+bJ0uVsPFBMbZF3YA@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220876>

On Thu, 11 Apr 2013 15:50:31 +0530
Sivaram Kannan <siva.devel@gmail.com> wrote:

[...]
> Output of coredump gdb:
> 
> gitadmin@gitserver:/var/crash/dump$ gdb git CoreDump
> GNU gdb (Ubuntu/Linaro 7.4-2012.04-0ubuntu2.1) 7.4-2012.04
> Copyright (C) 2012 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later
> <http://gnu.org/licenses/gpl.html> This is free software: you are
> free to change and redistribute it. There is NO WARRANTY, to the
> extent permitted by law.  Type "show copying" and "show warranty" for
> details. This GDB was configured as "x86_64-linux-gnu".
> For bug reporting instructions, please see:
> <http://bugs.launchpad.net/gdb-linaro/>...
> Reading symbols from /usr/bin/git...(no debugging symbols
> found)...done. BFD: Warning: /var/crash/dump/CoreDump is truncated:
> expected core file size >= 600195072, found: 1114112.

^^^ Try to issue the

$ ulimit -c unlimited

command in your shell before attempting the cloning -- this should
remove the upper limit on the core file size.  And try look for the core
file in the current directory after the crash occurs.  I'm not sure
Ubuntu's "crash interceptor" won't kick in, but just in case...
