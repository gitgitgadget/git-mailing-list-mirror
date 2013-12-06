From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Git reports
Date: Fri, 6 Dec 2013 21:53:34 +0400
Message-ID: <20131206215334.1a9031a1450d9c436943ce3d@domain007.com>
References: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
	<20131206210035.17413ee7bcdf3ca0c9655d81@domain007.com>
	<20131206210958.59f553060e3802d56f4a53b8@domain007.com>
	<CAMAQ3nKVjF-5oW2pZZaD9MSz9wqoXJBQDoGcdy5mb=gxCguuSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org
To: Muzaffer Tolga Ozses <tolga@ozses.net>
X-From: git-owner@vger.kernel.org Fri Dec 06 18:54:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VozbD-0006Jt-Ij
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 18:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758411Ab3LFRxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 12:53:52 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:59603 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758393Ab3LFRxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 12:53:50 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id rB6HrYep020538;
	Fri, 6 Dec 2013 21:53:37 +0400
In-Reply-To: <CAMAQ3nKVjF-5oW2pZZaD9MSz9wqoXJBQDoGcdy5mb=gxCguuSA@mail.gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238940>

On Fri, 6 Dec 2013 19:44:21 +0200
Muzaffer Tolga Ozses <tolga@ozses.net> wrote:

[...]
> >> > Resolving deltas: 100% (369/369), done.
> >> >
> >> > whereas I don't get those with my own. What could I be doing
> >> > wrong?
[...]
> >> So it might turn out on your own server Git for some reason fails
> >> to figure out its standard error stream is connected to a terminal.
> >> Or, the error stream of your shell process is redirected somewhere
> >> (and hence inherited by Git).
[...]
> > So you might face a misbehaving shell logon script for instance.
> >
> > As to whether Git senses the TTY -- what does running
> >
> >   stty
> >
> > tells you?  Does it fail with something like "inappropriate ioctl
> > for device" or prints a couple of settings?
> stty tells me
> speed 38400 baud; line = 0;
> eol = M-^?; eol2 = M-^?; swtch = M-^?;
> ixany iutf8
> 
> And I run identical commands on both servers, only URL changes.

OK, so we could supposedly rule out the possibility Git does not sense
it's connected to a terminal.

So let's do the next test: does

    echo test >&2

print "test" on the box where Git does not report progress?

Another one: does Git report progress if you explicitly pass --progress
to it?

Does it work if you do

    git clone $URL 2>&1

?

What Git and OS versions are on both machines?
