From: Aaron Schrab <aaron@schrab.com>
Subject: Re:  difftool: honor --trust-exit-code for builtin tools
Date: Mon, 17 Nov 2014 17:15:37 -0500
Message-ID: <20141117221536.GG615@pug.qqx.org>
References: <1416000835-79274-1-git-send-email-davvid@gmail.com>
 <xmqqy4rd1mdw.fsf@gitster.dls.corp.google.com>
 <CAHYJk3Q9tcS+o0hDnDz24ysSKkL6m16OmhyHuj=W88VQjTximw@mail.gmail.com>
 <xmqq4mtz10ef.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Mikael Magnusson <mikachu@gmail.com>,
	David Aguilar <davvid@gmail.com>, git <git@vger.kernel.org>,
	Adri Farr <14farresa@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 17 23:23:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqUhu-0002jf-Rr
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 23:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbaKQWXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 17:23:34 -0500
Received: from pug.qqx.org ([50.116.43.67]:43675 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791AbaKQWXc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 17:23:32 -0500
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Nov 2014 17:23:32 EST
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 56CD557779; Mon, 17 Nov 2014 17:15:37 -0500 (EST)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	David Aguilar <davvid@gmail.com>, git <git@vger.kernel.org>,
	Adri Farr <14farresa@gmail.com>
Content-Disposition: inline
In-Reply-To: <xmqq4mtz10ef.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.22+86 (g0ed1b9d) (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At 10:11 -0800 16 Nov 2014, Junio C Hamano <gitster@pobox.com> wrote:
>It does not have any significance that a random shell implementation
>is not POSIX compliant.  That would merely mean that such a shell
>cannot be used to run POSIX shell scripts like our Porcelain.

Right, and I suspect that it's very rare for zsh to be used as /bin/sh.  
I've heard of people doing it just to see what would fail, but not of 
anybody doing that for regular use.

>I would suspect that zsh has more "posixly correct" mode, with which
>it _can_ run POSIX shell scripts, and I would imagine that this 
>"$status is an alias $?" business is disabled in that mode? 

Yes, if zsh is invoked as either "sh" or "ksh" it attempts to emulate 
the usual semantics of the named shell.  One of the differences is that 
$status isn't special in the emulation modes.
