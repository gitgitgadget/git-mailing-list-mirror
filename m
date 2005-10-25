From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: How to clone faster via ssh ?
Date: Tue, 25 Oct 2005 18:30:24 +0700
Organization: AcademSoft Ltd.
Message-ID: <200510251830.24550.lan@ac-sw.com>
References: <200510251449.15302.lan@ac-sw.com> <200510251454.35202.lan@ac-sw.com> <Pine.LNX.4.63.0510251103110.24174@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 13:33:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUN0v-00070m-Lb
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 13:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbVJYLae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 07:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbVJYLae
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 07:30:34 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:29860 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S932130AbVJYLad (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2005 07:30:33 -0400
Received: from lan.ac-sw.lcl (unknown [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 7DC18BD2D; Tue, 25 Oct 2005 18:30:32 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 630F68C39B; Tue, 25 Oct 2005 18:30:32 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id A1EAE641CA;
	Tue, 25 Oct 2005 18:30:25 +0700 (NOVST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: KMail/1.6.2
In-Reply-To: <Pine.LNX.4.63.0510251103110.24174@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 2.64 (2004-01-11) on lan.ac-sw.lcl
X-Spam-Level: 
X-Spam-Status: No, hits=-4.8 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=2.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10582>

> If you have a working git on the other side, you could do
>
> 	time git-clone lan@lan:/home/lan/tmp/git/billing/repo r3
>
> which would utilize git-clone-pack. Way faster.

I have tried this command:
lan@lan> time git-clone lan@lan:/home/lan/tmp/git/billing/repo r3
defaulting to local storage area
lan@lan's password:
Packing 204607 objects
Unpacking 204607 objects
Killed by signal 2.) done

real    4m0.874s
user    0m0.013s
sys     0m0.120s

I have killed it at ~ 20%. As I understand it does exactly what ssh git thru 
ssh transport does: git-rev-list |  git-pack | ssh | git-unpack or something 
like this. So it is not faster.
