From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFH] pp_header(): work around possible memory corruption
Date: Sun, 24 Jun 2007 00:32:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706240031220.4059@racer.site>
References: <Pine.LNX.4.64.0706151318210.4059@racer.site>
 <7vps3w4g9x.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 01:33:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2F6O-0000q3-ET
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 01:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbXFWXdJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Jun 2007 19:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752425AbXFWXdI
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jun 2007 19:33:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:34604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752282AbXFWXdH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2007 19:33:07 -0400
Received: (qmail invoked by alias); 23 Jun 2007 23:33:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp008) with SMTP; 24 Jun 2007 01:33:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19YJboBua5YmeAoO4o24vIUbwMTF2V4LXqk/91vHW
	DKeKgcfkr0pa3u
X-X-Sender: gene099@racer.site
In-Reply-To: <7vps3w4g9x.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50758>

Hi,

On Fri, 15 Jun 2007, Junio C Hamano wrote:

> At least the older humongous pretty_print_commit() got separated into 
> manageable chunks, and I was happy.  I was just too lazy when 
> refactoring the code and stopped there.

Understandable.

> The right fix is to propagate the "realloc as needed" callchain into 
> add_user_info(), instead of having "this should be enough" there.  
> These two you touched are the only two callsite of that static function.

I had a go at this, but unfortunately I do not understand enough of what 
is going on there. For example, add_rfc2047() sometimes quotes some text. 
I have no idea what a conservative estimate of the growth is, so I cannot 
continue there.

Sorry,
Dscho
