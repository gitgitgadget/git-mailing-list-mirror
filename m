From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Fix an "variable might be used uninitialized" gcc warning
Date: Tue, 31 Jan 2012 18:36:29 +0000
Message-ID: <4F2834AD.20004@ramsay1.demon.co.uk>
References: <4EEBC9D6.6010204@ramsay1.demon.co.uk> <20111216235908.GA5858@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 19:51:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsInn-0001wJ-9T
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 19:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab2AaSvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 13:51:19 -0500
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:33344 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754498Ab2AaSvR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2012 13:51:17 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1RsInS-000030-lt; Tue, 31 Jan 2012 18:51:15 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20111216235908.GA5858@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189463>

Jonathan Nieder wrote:
> Ramsay Jones wrote:
> 
>>         CC builtin/checkout.o
>>     builtin/checkout.c: In function `cmd_checkout':
>>     builtin/checkout.c:160: warning: 'mode' might be used uninitialized \
>>         in this function
> [...]
>> [Note that only 2 out of the 3 versions of gcc I use issues this
>> warning]
> 
> Which version of gcc is that?  Is gcc getting more sane, so we won't
> have to worry about this after a while, or is the false positive a
> new regression that should be reported to them?

[Sorry for the late reply, I've been away from email for several weeks...]

The versions which complain are 3.4.4 and 4.1.2, whereas 4.4.0 compiles
the code without complaint. So, gcc *may* be getting more sane, but I wouldn't
bet on it! :-P

I've had examples of this kind of warning, which relies heavily on the
analysis performed primarily for the optimizer, come-and-go in gcc before; so
don't hold your breath (this is the most volatile part of the compiler).

Having said that, unless you are going to decree that the project only
supports gcc (and presumably only some particular versions of gcc), then you
may well find similar warnings triggered when using other compilers anyway ...

ATB,
Ramsay Jones
