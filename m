From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: RFC: New diff-delta.c implementation
Date: Fri, 21 Apr 2006 22:21:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604212220070.22622@alien.or.mcafeemobile.com>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 22 21:25:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXNjB-0000iP-Qu
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 21:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWDVTZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 15:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWDVTZF
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 15:25:05 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:59067 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751044AbWDVTZD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 15:25:03 -0400
Received: from x35.xmailserver.org (x35.xmailserver.org [69.30.125.51])
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k3M5PI0J008213
	for <git@vger.kernel.org>; Sat, 22 Apr 2006 05:25:18 GMT
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1CB693> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Fri, 21 Apr 2006 22:22:03 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Geert Bosch <bosch@adacore.com>
In-Reply-To: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
X-Virus-Scanned: ClamAV 0.88/1414/Fri Apr 21 22:58:39 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19045>

On Fri, 21 Apr 2006, Geert Bosch wrote:

> I wrote a new binary differencing algorithm that is both faster
> and generates smaller deltas than the current implementation.
> The format is compatible with that used by patch-delta, so
> it should be easy to integrate.
>
> Originally, I wrote this for the GDIFF format, see 
> http://www.w3.org/TR/NOTE-gdiff-19970901.
> The adaptation for GIT format was relatively simple, but is not thoroughly 
> tested.
> The code is not derived from libxdiff, but uses the rabin_slide function 
> written
> by David Mazieres (dm@uun.org). Also the tables are generated using his code.
> Finally, this was developed on Darwin, and not a Linux system, so some 
> changes may be needed.
>
> Initial testing seems quite positive, take for example git-1.2.5.tar vs 
> git-1.2.6.tar
> on my PowerBook (both with -O2 -DNDEBUG):
>
> current: 2.281s, patch size 36563
> new    : 0.109s, patch size 16199

Geert, the code needs some works IMO ;), but otherwise very lever idea to 
use Rabin's polynomials and impressive results!



- Davide
