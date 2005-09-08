From: Patrick Mauritz <oxygene@studentenbude.ath.cx>
Subject: Re: patches
Date: Thu, 08 Sep 2005 12:11:09 +0200
Message-ID: <1126174268.723.10.camel@divert>
References: <1125962642.15293.20.camel@divert>
	 <7vr7c0xqhd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 08 12:13:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EDJMi-0004MN-Gj
	for gcvg-git@gmane.org; Thu, 08 Sep 2005 12:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVIHKKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Sep 2005 06:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVIHKKe
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Sep 2005 06:10:34 -0400
Received: from khepri.openbios.org ([80.190.231.112]:33715 "EHLO
	khepri.openbios.org") by vger.kernel.org with ESMTP id S964782AbVIHKKd
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Sep 2005 06:10:33 -0400
Received: from dsl-082-082-236-009.arcor-ip.net ([82.82.236.9] helo=t-stueck.streichelzoo)
	by khepri.openbios.org with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.50)
	id 1EDJMQ-00061v-VT; Thu, 08 Sep 2005 12:10:27 +0200
Received: from 192.168.1.201 (divert.studentenbude.ath.cx [192.168.1.201])
	by t-stueck.streichelzoo (8.13.4+Sun/8.13.3) with ESMTP id j88AAKng027215;
	Thu, 8 Sep 2005 12:10:25 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr7c0xqhd.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Ximian Evolution 1.4.6.316 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0 (t-stueck.streichelzoo [192.168.1.200]); Thu, 08 Sep 2005 12:10:26 +0200 (CEST)
X-Spam-Score: -1.4 (-)
X-Duff: Orig. Duff, Duff Lite, Duff Dry, Duff Dark,
	Raspberry Duff, Lady Duff, Red Duff, Tartar Control Duff
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8197>

On Thu, 2005-09-08 at 04:06, Junio C Hamano wrote:
> I would have appreciated if you said "Solaris portability patch"
> or somesuch on the subject line.
sorry, of course you're right..

the #ifndef __sun was done because getdomainname() doesn't exist on
solaris. (just for clarification)

> Curious.  Doesn't the order of -l and -L/-R matter these days?
hmm.. no idea why it worked for me, but a test case fails now: better
make that -L -R -l

> I am sympathetic to the reason why you need this, but if we go
> this route we should also do openssl as well.  I'd drop this
> part for now.
because on solaris there are lots of places where external libraries
could be found (/usr/local/lib, /opt/csw/lib, whereever people who
package themselves put them). ld.so.conf doesn't exist (same as on
*bsd), so using -L and -R is the standard way of linking external
libraries.


thanks,
patrick mauritz
