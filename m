From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 11:46:31 +0200
Message-ID: <878wzgwyyw.fsf@basil.nowhere.org>
References: <20080413232441.e216a02c.akpm@linux-foundation.org>
	<20080414072328.GW9785@ZenIV.linux.org.uk>
	<20080414010412.c42dc560.akpm@linux-foundation.org>
	<20080414.013058.149905948.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@linux-foundation.org, viro@ZenIV.linux.org.uk, w@1wt.eu,
	david@lang.hm, sclark46@earthlink.net, johnpol@2ka.mipt.ru,
	rjw@sisk.pl, tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	netdev@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: netdev-owner@vger.kernel.org Mon Apr 14 11:47:21 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlLHU-000435-KF
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 11:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752252AbYDNJqg (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 05:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbYDNJqg
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 05:46:36 -0400
Received: from smtp-out01.alice-dsl.net ([88.44.60.11]:19215 "EHLO
	smtp-out01.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbYDNJqe (ORCPT
	<rfc822;netdev@vger.kernel.org>); Mon, 14 Apr 2008 05:46:34 -0400
Received: from out.alice-dsl.de ([192.168.125.59]) by smtp-out01.alice-dsl.net with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Apr 2008 11:39:46 +0200
Received: from basil.firstfloor.org ([92.224.153.101]) by out.alice-dsl.de with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Apr 2008 11:39:46 +0200
Received: by basil.firstfloor.org (Postfix, from userid 1000)
	id C47381B41F4; Mon, 14 Apr 2008 11:46:31 +0200 (CEST)
In-Reply-To: <20080414.013058.149905948.davem@davemloft.net> (David Miller's message of "Mon, 14 Apr 2008 01:30:58 -0700 (PDT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.3 (gnu/linux)
X-OriginalArrivalTime: 14 Apr 2008 09:39:46.0731 (UTC) FILETIME=[79EEA7B0:01C89E13]
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79494>

David Miller <davem@davemloft.net> writes:
>
> It's still largely free form, loose, and flexible. 

I think Al's point was that we need far more "free form, loose and
flexible" work for reviewing code. As in people going over trees and
just checking it for anything suspicious and going over existing code
and checking it for anything suspicious and going also over mailing
list patch posts. And also maintainers who appreciate such review.

And checking it for anything suspicious does not mean running
only checkpatch.pl or even just sparse, but actually reading it
and trying to make sense of it.

I don't see that really as conflicting with your goals.

It would be some more work for the maintainers to handle more such
feedback because they would need to process comments from such "free
form reviewers".  Some of them will undoutedly be wrong and that will
take some time away from processing features (and bugs) but I suspect
it would be still worth it.

On the other hand it would also take some work away from
processing bugs, but as Andrew mentions earlier it looks
like significant parts of the boring areas of bug reports 
(like getting basic information from reporter etc.) 
could be "out-sourced" to bug masters. 

And I think being a bug master is an excellent way for someone who isn't
a great coder to contribute in excellent ways to Linux
(far more than someone e.g. running checkpatch.pl ever could) 

The challenging thing is also to make sure that the quality of
comments stays high. That means more focus on logic and functionality
than on form. If the reviewer just goes over the coding style or
trivialities I don't think that will improve Linux really. I think the
problem is often that people think kernel code must be very
complicated and they don't even dare try to understand it.  But
frankly a lot of the kernel code is not really that complicated logic
wise and also doesn't need too specialized knowledge to understand.
So I am optimistic that there are a lot of people out there who would
be qualified to do some logic review.

Really Linux needs a better "reviewing culture" and also
a better "bug processing culture"

> We can ask more subsystem tree maintainers to run their trees more
> strictly, review patches more closely, etc.  But, be honest, good luck
> getting that from the guys who do subsystem maintainence in their
> spare time on the weekends.  The remaining cases should know better,
> or simply don't care.

In my experience weekend maintainers tend to be better at sharing
out work. As in they usually (ok there are exceptions) more work
including review work on the mailing lists, while my impression
is that paid for maintainers tend to have tendency for more 
centralized "cathedral" tree maintenance. That is with them trying to 
keep everything under control and effectively much more stuff going on the 
background out of public view. But the sharing out of work and less
centralization is what we really want here I think.

Anyways I'm not saying all paid-for maintainers are like this, but
there is certainly a trend I think.

I admit I personally went through both phases in several projects.

When you're really focussed on something it is tempting to do 
the "keep things under control" central model, but in the end
it is the wrong way to go.

-Andi
