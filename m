From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: How to clone faster via ssh ?
Date: Wed, 26 Oct 2005 09:46:58 +0700
Organization: AcademSoft Ltd.
Message-ID: <200510260946.58443.lan@ac-sw.com>
References: <200510251449.15302.lan@ac-sw.com> <Pine.LNX.4.63.0510251103110.24174@wbgn013.biozentrum.uni-wuerzburg.de> <7vbr1dh5y7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 04:48:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUbJv-0007oB-Vp
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 04:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522AbVJZCrE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 22:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVJZCrE
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 22:47:04 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:15784 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S932522AbVJZCrD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 22:47:03 -0400
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 8B205BD38; Wed, 26 Oct 2005 09:47:01 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 7755C73AAE; Wed, 26 Oct 2005 09:47:01 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 38AB873AA9;
	Wed, 26 Oct 2005 09:46:59 +0700 (NOVST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.6.2
In-Reply-To: <7vbr1dh5y7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 2.64 (2004-01-11) on lan.ac-sw.lcl
X-Spam-Level: 
X-Spam-Status: No, hits=-4.8 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=2.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10643>

> The time to unpack the resulting pack on this end is eliminated
> if you use git from last week, namely this commit:
>
> commit e1c7ada6dd1fdf249d0bb84f3293d3be768b9239
> Author: Junio C Hamano <junkio@cox.net>
> Date:   Wed Oct 19 14:43:43 2005 -0700
>
>     git-clone: always keep pack sent from remote.
>
>     This deprecates --keep and -q flags and always keeps the
>     pack
>     sent from the remote site.  Corresponding configuration
>     variables are also removed.
>
>     Signed-off-by: Junio C Hamano <junkio@cox.net>
>
> But you would still pay for creating a pack on the remote side.

Yeah ! Thanks.

Version for todays master branch works much faster:
lan@lan:~/tmp/git/billing> time git-clone -n 
ssh://lan@lan/home/lan/tmp/git/billing/repo r1
defaulting to local storage area
lan@lan's password:
Packing 204607 objects

real    4m0.107s
user    0m11.879s
sys     0m1.717s

And it makes only one pack. Great.
