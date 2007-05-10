From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 16:46:22 +0300
Message-ID: <20070510134622.GN13655@mellanox.co.il>
References: <20070506195230.GA30339@mellanox.co.il>
	<7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
	<20070510095156.GC13655@mellanox.co.il>
	<81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
	<20070510120802.GG13655@mellanox.co.il>
	<81b0412b0705100519i3028fbc4y25e7c407c7c8216@mail.gmail.com>
	<20070510122550.GJ13655@mellanox.co.il>
	<81b0412b0705100633t61ac0309jfc8536b30244adf6@mail.gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 15:46:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm8yZ-00005L-4c
	for gcvg-git@gmane.org; Thu, 10 May 2007 15:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbXEJNqZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 09:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754596AbXEJNqY
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 09:46:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:59847 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbXEJNqY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 09:46:24 -0400
Received: by ug-out-1314.google.com with SMTP id 44so598081uga
        for <git@vger.kernel.org>; Thu, 10 May 2007 06:46:22 -0700 (PDT)
Received: by 10.82.173.19 with SMTP id v19mr3027166bue.1178804782061;
        Thu, 10 May 2007 06:46:22 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id c22sm8176022ika.2007.05.10.06.46.18;
        Thu, 10 May 2007 06:46:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0705100633t61ac0309jfc8536b30244adf6@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46867>

> Quoting Alex Riesen <raa.lkml@gmail.com>:
> Subject: Re: [PATCHv2] connect: display connection progress
> 
> On 5/10/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> >> >> What addresses were tried by connect?
> >> >
> >> >You are speaking about your patch reporting the IP on failure?
> >>
> >> Yes. Not on failure (not only). Every time an address is tried
> >> to connect.
> >
> >Why not only on failure? IP addresses look ugly.
> 
> So you can see DNS problems you wanted to uncover.

I really just wanted git to tell me what it's doing,
so that I know it's not actually blocked on network,
not doing any work.

> DNS is all about mapping names to that ugly IP.

Yes, but so far git port does not seem to be commonly open
on random IPs ;).

> And DNS _problems_ often manifest themselves
> by mapping the name to an unexpected IP.


> Now that's really ugly

So, let's print the IP if -v is set?
Oh, look, now we'll have
NET_QUIET
NET_VERBOSE

> >> >I think it makes sense, but it's a separate issue, isn't it?
> >>
> >> You are just about to make git_tcp_connect verbose,
> >> are you not?
> >
> >Only if the flag is set. So git-fetch without -q qill be more verbose -
> >but it already spits out a fair amount of data on screen.
> 
> And so you added some more? Does not sound logical.
> 
> How about cleaning up this (reduce the amount of date
> on screen)

Isn't this why we have -q?

> and adding another verbosity level (with your
> messages and IP) instead?

What, yet another flag? Nooooooo

-- 
MST
