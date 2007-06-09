From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 12/21] Use prefixcmp() instead of memcmp() for cleaner code
 with less magic numbers
Date: Sat, 09 Jun 2007 23:47:08 +0200
Message-ID: <200706092347.08729.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706090217.49818.johan@herland.net>
 <81b0412b0706091442m6594260btd3b898bfb63e1fbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 23:47:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8mA-0001kr-6Q
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbXFIVrN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753384AbXFIVrN
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:47:13 -0400
Received: from smtp.getmail.no ([84.208.20.33]:63169 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508AbXFIVrL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:47:11 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJE006051UM8L00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 23:47:10 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE00BP91ULAL60@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 23:47:09 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE000V51UKUO80@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 23:47:09 +0200 (CEST)
In-reply-to: <81b0412b0706091442m6594260btd3b898bfb63e1fbb@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49629>

On Saturday 09 June 2007, Alex Riesen wrote:
> On 6/9/07, Johan Herland <johan@herland.net> wrote:
> > +/*
> > + * Perform parsing and verification of tag object data.
> > + *
> > + * The 'item' parameter may be set to NULL if only verification is desired.
> > + *
> > + * The given data _must_ be null-terminated.
> > + */
> >  int parse_and_verify_tag_buffer(struct tag *item,
> >                 const char *data, const unsigned long size, int thorough_verify)
> 
> This hunk really belongs into commit which introduced the function
> parse_and_verify_tag_buffer.

Yes. I'm sorry it slipped out of that patch and into this one.


...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
