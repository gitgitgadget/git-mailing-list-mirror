From: Bill Lear <rael@zopyra.com>
Subject: Re: Pulling peer's branch and getting tracking branch created
Date: Mon, 26 Feb 2007 19:04:45 -0600
Message-ID: <17891.33709.278100.35712@lisa.zopyra.com>
References: <17891.32095.655545.637691@lisa.zopyra.com>
	<7v7iu4l8k0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 27 02:04:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLqlw-0005uL-Tv
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 02:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965263AbXB0BEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 20:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbXB0BEu
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 20:04:50 -0500
Received: from mail.zopyra.com ([65.68.225.25]:61820 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965263AbXB0BEt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 20:04:49 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1R14jc08323;
	Mon, 26 Feb 2007 19:04:45 -0600
In-Reply-To: <7v7iu4l8k0.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40683>

On Monday, February 26, 2007 at 16:59:27 (-0800) Junio C Hamano writes:
>Bill Lear <rael@zopyra.com> writes:
>
>> I can't seem to figure out the correct magic to get my buddy's branch,
>> and create the appropriate tracking branch at the same time without
>> doing a clone.
>
>I'll cheat and ask "git show b6f5da1e" ;-).
>
>	$ git remote add -f -m master bob ../bob.git/
>
>which should add:
>
>	[remote "bob"]
>        	url = ../bob.git/
>		fetch = +refs/heads/*:refs/remotes/bob/*
>
>to .git/config, and perform the initial "git fetch bob" so that
>bob's heads appear under your .git/refs/remotes/bob/*, iow,
>after this, you can ask:
>
>	$ git branch -r
>	  bob/HEAD
>          bob/master
>          bob/topic-1
>          bob/topic-2

Ok, and then:

% git checkout -b topic-1 bob/topic-1

Gets me onto a topic branch ...

So, this does do what I've asked, and more: however, how can I get it
to do only the one branch that I want and not all of the others?  If
this part is really annoyingly hard and/or stupid, don't hesitate to
say so.


Bill
