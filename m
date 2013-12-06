From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Git reports
Date: Fri, 6 Dec 2013 21:00:35 +0400
Message-ID: <20131206210035.17413ee7bcdf3ca0c9655d81@domain007.com>
References: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Muzaffer Tolga Ozses <tolga@ozses.net>
X-From: git-owner@vger.kernel.org Fri Dec 06 18:00:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Voylh-0004lA-GD
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 18:00:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab3LFRAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 12:00:41 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:59249 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab3LFRAl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 12:00:41 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rB6H0ZrG016991;
	Fri, 6 Dec 2013 21:00:36 +0400
In-Reply-To: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238934>

On Fri, 6 Dec 2013 18:51:47 +0200
Muzaffer Tolga Ozses <tolga@ozses.net> wrote:

> On another git server, I get reports like
> Cloning into 'tcmb'...
> remote: Counting objects: 704, done.
> remote: Compressing objects: 100% (574/574), done.
> remote: Total 704 (delta 369), reused 107 (delta 60)
> Receiving objects: 100% (704/704), 129.99 KiB | 23 KiB/s, done.
> Resolving deltas: 100% (369/369), done.
> 
> whereas I don't get those with my own. What could I be doing wrong?

The documentation on `git push` states:

  --progress

    Progress status is reported on the standard error stream by default
  when it is attached to a terminal, unless -q is specified. This flag
  forces progress status even if the standard error stream is not
  directed to a terminal.

So it might turn out on your own server Git for some reason fails to
figure out its standard error stream is connected to a terminal.
Or, the error stream of your shell process is redirected somewhere (and
hence inherited by Git).
Or you pass the "-q" command-line option to `git clone`.
