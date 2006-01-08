From: Willy Tarreau <willy@w.ods.org>
Subject: Re: git pull on Linux/ACPI release tree
Date: Mon, 9 Jan 2006 00:53:25 +0100
Message-ID: <20060108235325.GJ7142@w.ods.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com> <Pine.LNX.4.64.0601081111190.3169@g5.osdl.org> <20060108230611.GP3774@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>,
	"Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Mon Jan 09 00:58:38 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvkQi-0003xy-7x
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Mon, 09 Jan 2006 00:58:32 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1161252AbWAHX62 (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Sun, 8 Jan 2006 18:58:28 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S965354AbWAHX62
	(ORCPT <rfc822;linux-acpi-outgoing>); Sun, 8 Jan 2006 18:58:28 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:43276 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S965045AbWAHX61 (ORCPT <rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>);
	Sun, 8 Jan 2006 18:58:27 -0500
To: Adrian Bunk <bunk-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20060108230611.GP3774-HeJ8Db2Gnd6zQB+pC5nmwQ@public.gmane.org>
User-Agent: Mutt/1.5.10i
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Adrian,

On Mon, Jan 09, 2006 at 12:06:11AM +0100, Adrian Bunk wrote:
> On Sun, Jan 08, 2006 at 11:41:28AM -0800, Linus Torvalds wrote:
> >...
> > What I object to is that there were _also_ two automated merges within ten 
> > hours or each other, with absolutely _zero_ development in your tree in 
> > between. Why did you do that in your development tree? By _definition_ you 
> > had done zero development. You just tracked the development in _my_ tree.
> >...
> 
> My impression is that you and Len are talking at different levels.
> 
> I can't speak for Len, but let me try to describe a problem in this area 
> I don't know the solution for:
> 
> Consider I want to do the following:
> 1. update my tree daily from your tree
> 2. include 10 patches per week into my tree
> 3. ask you once a month to pull from my tree
> 
> How should step 1 be done?

I believe we all have the same problem. The only solution I found for
this was to proceed like David described. I know even have a 'git-patches'
directory next to my git repo to keep the resulting patches after I do a
'git-format-patch --mbox'.

When Linus called it the 'stupid content tracker', he was half right.
In fact, it's more a 'changes tracker' than a 'content tracker'. It
logs everything you and others do, so if you don't want your operations
to appear on others' history, you have to hide them by working on
temporary trees to generate the patches you will use later.

At first I found this very annoying, but finally, it's a way to ensure
that I always have clean and ordered patches. It's not much different
from what I was doing by hand previously, it's just that all git-xxx
operations take much longer time, possibly because of the compression.
On the other hand, its ability to understand mbox saves me some time.

> In CVS, I'd do a "cvs update -dP ."
> In cogito, the equivalent command seems to be "cg-update".
> 
> CVS has no problems if I have changed MAINTAINERS in one place and it 
> changes daily in your tree in other places, but how do I do the same in 
> git/cogito without creating the merges you don't want to see?
> 
> The solution might be described somewhere in TFM, but this is the class 
> of problems people like me run into when the goal is simply a git tree 
> to both track your tree and send changes to you without any interest in 
> advanced SCM knowledge.

What sometimes worries me is that some operations seem so much complicated
that there is a high risk of doing the wrong thing, and I'm not certain
that this will reduce the number of mistakes I do in a month, compared
to manual patching. I became a real addict to 'git-reset --hard' ...

> cu
> Adrian

Regards,
Willy

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
