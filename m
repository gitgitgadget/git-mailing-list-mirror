From: Alexander Litvinov <lan@academsoft.ru>
Subject: Re: Security problem
Date: Fri, 16 Jun 2006 10:54:46 +0700
Organization: AcademSoft Ltd.
Message-ID: <200606161054.46813.lan@academsoft.ru>
References: <200606151709.22752.lan@academsoft.ru> <200606160931.29553.lan@academsoft.ru> <Pine.LNX.4.64.0606151948230.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 05:55:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fr5QM-0004Og-BV
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 05:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWFPDzE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 23:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWFPDzB
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 23:55:01 -0400
Received: from gw.ac-sw.com ([81.1.223.2]:57292 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S1751020AbWFPDzA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 23:55:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP
	id 009E0BDD4; Fri, 16 Jun 2006 10:54:59 +0700 (NOVST)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21369-06; Fri, 16 Jun 2006 10:54:49 +0700 (NOVST)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP
	id B94BDBDD0; Fri, 16 Jun 2006 10:54:49 +0700 (NOVST)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id B556C8DA2A5C; Fri, 16 Jun 2006 10:54:49 +0700 (NOVST)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 1BA408DA2841;
	Fri, 16 Jun 2006 10:54:47 +0700 (NOVST)
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.64.0606151948230.5498@g5.osdl.org>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21928>

> If you can't trust your local filesystem, you are screwed.

You are right, I trust my file system. But if our team had central repo with 
ssh access to that machine, every developer can hack central repo.

Whould git-clone/git-fetch warn me about this ?

My own test with (another) local repo says:
lan@lan:~/tmp/git/test> git clone 1 2
Generating pack...
Done counting 3 objects.
Deltifying 3 objects.
 100% (3/3) done
Total 3, written 3 (delta 0), reused 0 (delta 0)
error: git-checkout-index: unable to read sha1 file of a 
(3609f20ebd357679b111783e8afaf36ec46427f3)

It can't checkout object (3609f20ebd357679b111783e8afaf36ec46427f3 is the 
original file). It seems packed repos are safe from this point.
