From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --with-tcltk and --without-tcltk to configure.
Date: Thu, 29 Mar 2007 01:35:55 -0700
Message-ID: <7v7it04fbo.fsf@assigned-by-dhcp.cox.net>
References: <7vejnbtjdq.fsf@assigned-by-dhcp.cox.net>
	<20070327065940.GC51155@codelabs.ru>
	<20070327102437.GM14837@codelabs.ru>
	<7vtzw7nej6.fsf@assigned-by-dhcp.cox.net>
	<20070327110714.GA14837@codelabs.ru>
	<7vps6um8wv.fsf@assigned-by-dhcp.cox.net>
	<20070328091209.GQ14837@codelabs.ru>
	<7vps6tf8te.fsf@assigned-by-dhcp.cox.net>
	<20070329074424.GD59098@codelabs.ru>
	<7vwt107a3g.fsf@assigned-by-dhcp.cox.net>
	<20070329082908.GH59098@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Thu Mar 29 10:36:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWq7E-0002T3-G3
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 10:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbXC2IgN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 04:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbXC2IgN
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 04:36:13 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:65074 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbXC2IgM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 04:36:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329083556.QTSJ27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 04:35:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gYbv1W0051kojtg0000000; Thu, 29 Mar 2007 04:35:56 -0400
In-Reply-To: <20070329082908.GH59098@codelabs.ru> (Eygene Ryabinkin's message
	of "Thu, 29 Mar 2007 12:29:08 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43419>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> Or you meant something different? I am little confused with
> the '$PATH' in your example. Was it intended?

Yes, the dollar-sign-in-pathname is pretty much a part of my
pathological example. 

>> But come to think of it, it lets shell handle $PATH to find wish
>> anyway, so *unless* we have specific version dependency to wish
>> that wish binary normally found on user's $PATH is inadequate,
>> we probably should not even need to be doing any of this path
>> munging.  You might end up discovering the path to wish binary
>> in your autoconf script, we do not have to use it.  ./configure
>> can just see if there is wish, and set NO_TCLTK appropriately
>> without any of the path business.
>> 
>> What do you think?
>
> There are problems at least with FreeBSD: it just installs the
> wish8.4, wish8.3, wish8.2, etc. It does not provide the bare 'wish'
> as the link to one of those.

Then sed -e 's/wish/$(WISH_NAME)/', still letting the shell to
handle the path part, could be a simpler option.  I dunno.
