From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: running git from non-standard location on Mac
Date: Thu, 21 Feb 2013 11:53:11 +0100
Message-ID: <vpq8v6ix7jc.fsf@grenoble-inp.fr>
References: <1CE1BECC0915A6448EAE5D7080EDA905052078C95E@oxexc1>
	<20130221143525.726f06827351376b59a02f4b@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: James French <James.French@naturalmotion.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Feb 21 11:54:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Tmo-0005wM-37
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 11:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834Ab3BUKx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 05:53:29 -0500
Received: from mx2.imag.fr ([129.88.30.17]:42681 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753495Ab3BUKx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 05:53:28 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r1LArAf6017135
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 21 Feb 2013 11:53:10 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U8Tm3-0004EW-Rw; Thu, 21 Feb 2013 11:53:11 +0100
In-Reply-To: <20130221143525.726f06827351376b59a02f4b@domain007.com>
	(Konstantin Khomoutov's message of "Thu, 21 Feb 2013 14:35:25 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 21 Feb 2013 11:53:11 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r1LArAf6017135
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1362048794.98598@up0SHtsPq5Tec386PNBPeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216765>

Konstantin Khomoutov <flatworm@users.sourceforge.net> writes:

> This [1] should help you get started with affecting @INC.

In the particular case of Git, the Makefile hardcodes the path to the
Git library. The script git-svn in Git's exec-path should start with:

use lib (split(/:/, $ENV{GITPERLLIB} || "/some/hardcoded/path/to/perl/5.10.1"));

Setting the $GITPERLLIB environment variable or editing the script to
let the hardcoded path point to the place where the Git.pm file is
should do it.


But I still have to wonder why you didn't build Git with the right paths
in the first place.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
