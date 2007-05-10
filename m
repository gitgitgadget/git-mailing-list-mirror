From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 17:39:13 +0300
Message-ID: <20070510143913.GF22029@mellanox.co.il>
References: <20070506195230.GA30339@mellanox.co.il>
	<7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
	<20070510095156.GC13655@mellanox.co.il>
	<81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
	<20070510120802.GG13655@mellanox.co.il>
	<81b0412b0705100519i3028fbc4y25e7c407c7c8216@mail.gmail.com>
	<20070510122550.GJ13655@mellanox.co.il>
	<81b0412b0705100633t61ac0309jfc8536b30244adf6@mail.gmail.com>
	<20070510134622.GN13655@mellanox.co.il>
	<81b0412b0705100716t680290a3qd1d10cf588a65f5a@mail.gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 16:39:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm9nc-0005j3-BL
	for gcvg-git@gmane.org; Thu, 10 May 2007 16:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbXEJOjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 10:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbXEJOjO
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 10:39:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:2715 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbXEJOjN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 10:39:13 -0400
Received: by ug-out-1314.google.com with SMTP id 44so609058uga
        for <git@vger.kernel.org>; Thu, 10 May 2007 07:39:11 -0700 (PDT)
Received: by 10.82.118.2 with SMTP id q2mr3160059buc.1178807951634;
        Thu, 10 May 2007 07:39:11 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id c25sm8268628ika.2007.05.10.07.39.10;
        Thu, 10 May 2007 07:39:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0705100716t680290a3qd1d10cf588a65f5a@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46869>

> >> How about cleaning up this (reduce the amount of date
> >> on screen)
> >
> >Isn't this why we have -q?
> 
> Only fetch-pack has -q (and -v, which is confusing to
> say the least).

I find it quite proper to have both.
I would expect the following:

- git fetch normally displays progress meter, possibly
  tells me what stage it's in (connecting/downloading ....)
  so I know it's not hung.
- git fetch -q only tells me about errors/exceptional events
  good e.g. for scripts.
- git fetch -v gives a lot of detail useful for debugging
  only used if I see problems and want to debug.

Isn't this what's going on?

So, that's why the "connecting" message belongs in the default setup
(it can hang there for minutes), IP and such technicalia
belong with -v, and -q would only print data on connection error.
 
-- 
MST
