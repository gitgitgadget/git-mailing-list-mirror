From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 02/21] Return error messages when parsing fails.
Date: Sat, 09 Jun 2007 20:28:54 +0200
Message-ID: <200706092028.54459.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706090213.16031.johan@herland.net>
 <7vwsydf1m8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 20:29:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx5gL-0005Pa-7v
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 20:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbXFIS3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 14:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756802AbXFIS3A
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 14:29:00 -0400
Received: from smtp.getmail.no ([84.208.20.33]:45486 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681AbXFIS27 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 14:28:59 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJD00M07SOADQ00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:28:58 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD00JQOSO6IC00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:28:54 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJD000QASO6UK60@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 20:28:54 +0200 (CEST)
In-reply-to: <7vwsydf1m8.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49603>

On Saturday 09 June 2007, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> 
> > This patch brings the already similar tag.c:parse_tag_buffer() and
> > mktag.c:verify_tag() a little bit closer to eachother.
> 
> While I would agree that it makes sense to have the same
> definition of what is and is not a 100% well formatted tag
> object for producer side and consumer side, I do not necessarily
> think it is a good idea to make parse_tag_buffer() chattier on
> errors.  mktag.c:verify_tag() can afford to be verbose in its
> diagnosis, because it is used when the user is _creating_ the
> tag, and it is generally a good idea to be strict when we
> create.
> 
> On the other hand, parse_tag_buffer() is on the side of users
> who use existing tag objects that were produced by somebody
> else.  It is generally a good practice to be more lenient when
> you are consuming.
> 
> Also, callers of parse_tag_buffer() know the function is silent
> on errors (unless there is something seriously wrong with the
> repository); they do their own error messages when they get an
> error return.
> 
> 

Ok. I can make the error messages conditional on 'thorough_verify'.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
