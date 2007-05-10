From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 16:16:17 +0200
Message-ID: <81b0412b0705100716t680290a3qd1d10cf588a65f5a@mail.gmail.com>
References: <20070506195230.GA30339@mellanox.co.il>
	 <7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
	 <20070510095156.GC13655@mellanox.co.il>
	 <81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
	 <20070510120802.GG13655@mellanox.co.il>
	 <81b0412b0705100519i3028fbc4y25e7c407c7c8216@mail.gmail.com>
	 <20070510122550.GJ13655@mellanox.co.il>
	 <81b0412b0705100633t61ac0309jfc8536b30244adf6@mail.gmail.com>
	 <20070510134622.GN13655@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu May 10 16:16:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm9RS-0007rE-Kp
	for gcvg-git@gmane.org; Thu, 10 May 2007 16:16:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbXEJOQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 10:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756030AbXEJOQV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 10:16:21 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:42374 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbXEJOQU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 10:16:20 -0400
Received: by an-out-0708.google.com with SMTP id d18so144659and
        for <git@vger.kernel.org>; Thu, 10 May 2007 07:16:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SWkmSKiwysX14X+8jHicSqQtcljlDxjlyido5DkdKgLSxxDD9LISKzpXVJzY/b0C5uRm0NuFvZMm4cRJAeEBsW+r+4bvfunkoClNzEJ46JVDEYlNX1jMRrwL4VOSmlBZOj2XB3RHo0jabrcFXOioyPA++7hPTUa1XV3uVsYBKB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AJRdulvLY2KTdFZtFbs+I1MCkjpKXE+JApXKmwhMmQ8+yWbVc4rYELDBP4iHc4cjk16bpp10J3ZROumHMXmyUWnsonx+K/iLl58FU/11IZtM/pahDaUjBFKJ/pMBoI+xoidJHiOG7T383U55VmRqQeG1VOVFTV0L/ZcG66FDNZM=
Received: by 10.100.119.14 with SMTP id r14mr1291735anc.1178806578083;
        Thu, 10 May 2007 07:16:18 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Thu, 10 May 2007 07:16:17 -0700 (PDT)
In-Reply-To: <20070510134622.GN13655@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46868>

On 5/10/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> > >Why not only on failure? IP addresses look ugly.
> >
> > So you can see DNS problems you wanted to uncover.
>
> I really just wanted git to tell me what it's doing,
> so that I know it's not actually blocked on network,
> not doing any work.

Aren't you interested in _what_ work is it doing?

> > DNS is all about mapping names to that ugly IP.
>
> Yes, but so far git port does not seem to be commonly open
> on random IPs ;).

Well, it does. It happened.

> > And DNS _problems_ often manifest themselves
> > by mapping the name to an unexpected IP.
> > Now that's really ugly
>
> So, let's print the IP if -v is set?
> Oh, look, now we'll have
> NET_QUIET
> NET_VERBOSE

No. All you have is QUIET and !QUIET (or VERBOSE and
!VERBOSE which is the same).

> > How about cleaning up this (reduce the amount of date
> > on screen)
>
> Isn't this why we have -q?

Only fetch-pack has -q (and -v, which is confusing to
say the least).
