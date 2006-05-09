From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/6] gitopt: a new command-line option parser for git
Date: Tue, 09 May 2006 05:58:45 -0700
Message-ID: <7v8xpb73sq.fsf@assigned-by-dhcp.cox.net>
References: <1147151209168-git-send-email-normalperson@yhbt.net>
	<11471512103526-git-send-email-normalperson@yhbt.net>
	<20060509120809.4d9494b9.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 14:59:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdRne-00032n-4Z
	for gcvg-git@gmane.org; Tue, 09 May 2006 14:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWEIM6r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 08:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbWEIM6r
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 08:58:47 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:30600 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932299AbWEIM6q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 08:58:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509125846.VGQX18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 May 2006 08:58:46 -0400
To: Timo Hirvonen <tihirvon@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060509120809.4d9494b9.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Tue, 9 May 2006 12:08:09 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19836>

Timo Hirvonen <tihirvon@gmail.com> writes:

> Eric Wong <normalperson@yhbt.net> wrote:
>
>>  * unbundling of short options: -uC20n20z => -u -C20 -n20 -z
>
> Does anyone ever use this?  I think this makes sense only for flags that
> don't have parameters but that would create an ugly special case. Is it
> too hard to type "-u -C=20 -n=20 -z"?

I can already hear in my head that people would start talking
about "git understands insane abbeviations of options".  It
might be unambiguous, but that does not change it is a bit on
the insane side.  People would probably expect -nuz can be split
into -n -u -z, and the current handcrafted mess (although it is
more obvious and easy to work with when reading and maintaining
the existing code) is not abbreviation friendly, which we would
want to do something about.  But I think squashing options with
parameters together is going a bit too far.

> --with-r => --patch-with-raw works great

I personally think this also is too much.
