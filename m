From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 18:02:25 +0300
Message-ID: <20070510150225.GS13655@mellanox.co.il>
References: <20070510095156.GC13655@mellanox.co.il>
	<81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
	<20070510120802.GG13655@mellanox.co.il>
	<81b0412b0705100519i3028fbc4y25e7c407c7c8216@mail.gmail.com>
	<20070510122550.GJ13655@mellanox.co.il>
	<81b0412b0705100633t61ac0309jfc8536b30244adf6@mail.gmail.com>
	<20070510134622.GN13655@mellanox.co.il>
	<81b0412b0705100716t680290a3qd1d10cf588a65f5a@mail.gmail.com>
	<20070510143913.GF22029@mellanox.co.il>
	<81b0412b0705100752wa6dec37t787ccd61266f8944@mail.gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 17:02:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmAA7-0004pZ-0g
	for gcvg-git@gmane.org; Thu, 10 May 2007 17:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbXEJPCa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 11:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752784AbXEJPCa
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 11:02:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:33774 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbXEJPC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 11:02:29 -0400
Received: by ug-out-1314.google.com with SMTP id 44so613825uga
        for <git@vger.kernel.org>; Thu, 10 May 2007 08:02:23 -0700 (PDT)
Received: by 10.82.151.14 with SMTP id y14mr3166701bud.1178809343657;
        Thu, 10 May 2007 08:02:23 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id y37sm8340280iky.2007.05.10.08.02.22;
        Thu, 10 May 2007 08:02:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0705100752wa6dec37t787ccd61266f8944@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46871>


> Quoting Alex Riesen <raa.lkml@gmail.com>:
> Subject: Re: [PATCHv2] connect: display connection progress
> 
> On 5/10/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> >So, that's why the "connecting" message belongs in the default setup
> >(it can hang there for minutes), IP and such technicalia
> >belong with -v, and -q would only print data on connection error.
> 
> How about a config option? So that people working with
> repos connected through fast links (say, in local network or
> even locally on the same system) are not bothered by the
> "connecting" messages (they're is useless then, local networks
> usually work).

Do you really have git servers accessed over a local lan or on local system?
I just use ssh in this case, and I think that's the common case ...

I think making it possible to make -q a config option would be useful, though.

We *could* try doing something smart with non-blocking connect + select,
and only print the message if it takes > 1 second. Are you
sure it's worth the complication?

-- 
MST
