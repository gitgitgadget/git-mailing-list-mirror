From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH 2/5] daemon: if one of the standard fds is missing open it to /dev/null
Date: Thu, 13 Jul 2006 16:36:49 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060713143649.GA3395@informatik.uni-freiburg.de>
References: <E1G0zj7-0001c1-8q@moooo.ath.cx> <E1G0znB-0002IO-61@moooo.ath.cx> <20060713152725.7a5081df.froese@gmx.de> <E1G11nq-00076g-Aa@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 13 16:37:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G12JG-0002sq-AV
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 16:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWGMOgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 10:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWGMOgz
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 10:36:55 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:48339 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751546AbWGMOgy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 10:36:54 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1G12JB-0003FW-7a; Thu, 13 Jul 2006 16:36:53 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11) with ESMTP id k6DEaoCW012972;
	Thu, 13 Jul 2006 16:36:50 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.6/8.12.11/Submit) id k6DEanYb012971;
	Thu, 13 Jul 2006 16:36:49 +0200 (MEST)
To: Edgar Toernig <froese@gmx.de>, git@vger.kernel.org,
	Matthias Lederhofer <matled@gmx.net>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Edgar Toernig <froese@gmx.de>, git@vger.kernel.org,
	Matthias Lederhofer <matled@gmx.net>
Content-Disposition: inline
In-Reply-To: <E1G11nq-00076g-Aa@moooo.ath.cx>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23837>

Hello Matthias,

(Do you know you set the Mail-Followup-To Header?  That is annoying.)

>     devnull = open("/dev/null", O_RDWR, 0);
>     while (devnull != -1 && devnull < 2)
>         dup(devnull);
You mean

	  devnull = dup(devnull);

, don't you?

>     if (devnull == -1)
>         die("..");
>     close(devnull);

Best regards
Uwe

-- 
Uwe Zeisberger

primes where sieve (p:xs) = [ x | x<-xs, x `rem` p /= 0 ]; \
primes = map head (iterate sieve [2..])
