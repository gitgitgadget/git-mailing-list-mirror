From: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 15:08:02 +0300
Message-ID: <20070510120802.GG13655@mellanox.co.il>
References: <20070506195230.GA30339@mellanox.co.il>
	<7vhcqpbs78.fsf@assigned-by-dhcp.cox.net>
	<20070510095156.GC13655@mellanox.co.il>
	<81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 14:08:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm7RG-0001io-Lb
	for gcvg-git@gmane.org; Thu, 10 May 2007 14:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752892AbXEJMID (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 08:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754032AbXEJMIC
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 08:08:02 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:62651 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbXEJMIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 08:08:00 -0400
Received: by mu-out-0910.google.com with SMTP id w1so345157mue
        for <git@vger.kernel.org>; Thu, 10 May 2007 05:07:59 -0700 (PDT)
Received: by 10.82.126.5 with SMTP id y5mr2889860buc.1178798879558;
        Thu, 10 May 2007 05:07:59 -0700 (PDT)
Received: from ?127.0.0.1? ( [194.90.237.34])
        by mx.google.com with ESMTP id c25sm7984205ika.2007.05.10.05.07.58;
        Thu, 10 May 2007 05:07:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0705100439j4e6b072bk1ba19a4f971e5d0c@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46862>

> Quoting Alex Riesen <raa.lkml@gmail.com>:
> Subject: Re: [PATCHv2] connect: display connection progress
> 
> On 5/10/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
> >-static int git_tcp_connect_sock(char *host)
> >+static int git_tcp_connect_sock(char *host, int flags)
> 
> There is only one bit of flags ever used. What are the others for?

Hmm, I thought it's easier to read 
git_tcp_connect_sock(host, NET_QUIET)
	than
git_tcp_connect_sock(host, 1)

but maybe that's overdesign.

> Why use negative logic?
> What was wrong with plain "int verbose"?

I want the default to report connections, and -q
to silence them. Maybe "int quiet"?

> What addresses were tried by connect?

You are speaking about your patch reporting the IP on failure?
I think it makes sense, but it's a separate issue, isn't it?

-- 
MST
