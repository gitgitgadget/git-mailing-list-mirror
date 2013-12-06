From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Git reports
Date: Fri, 6 Dec 2013 21:09:58 +0400
Message-ID: <20131206210958.59f553060e3802d56f4a53b8@domain007.com>
References: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
	<20131206210035.17413ee7bcdf3ca0c9655d81@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Muzaffer Tolga Ozses <tolga@ozses.net>, git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 06 18:10:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Voyuy-00011T-Tq
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 18:10:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758055Ab3LFRKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 12:10:14 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:59388 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758042Ab3LFRKN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 12:10:13 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rB6H9wvS017632;
	Fri, 6 Dec 2013 21:09:59 +0400
In-Reply-To: <20131206210035.17413ee7bcdf3ca0c9655d81@domain007.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238935>

On Fri, 6 Dec 2013 21:00:35 +0400
Konstantin Khomoutov <flatworm@users.sourceforge.net> wrote:

[...]
> > Resolving deltas: 100% (369/369), done.
> > 
> > whereas I don't get those with my own. What could I be doing wrong?
> 
> The documentation on `git push` states:
> 
>   --progress
> 
>     Progress status is reported on the standard error stream by
> default when it is attached to a terminal, unless -q is specified.
> This flag forces progress status even if the standard error stream is
> not directed to a terminal.
> 
> So it might turn out on your own server Git for some reason fails to
> figure out its standard error stream is connected to a terminal.
> Or, the error stream of your shell process is redirected somewhere
> (and hence inherited by Git).

To underline the fact this is not all too unlikely, you're able to
completely silence error reports in your shell prompt by executing

  exec 2>/dev/null

(you can regain it back by doing `exec 2>&1`).

So you might face a misbehaving shell logon script for instance.

As to whether Git senses the TTY -- what does running

  stty

tells you?  Does it fail with something like "inappropriate ioctl for
device" or prints a couple of settings?
