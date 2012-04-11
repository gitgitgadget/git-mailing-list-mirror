From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Why can't git open empty branches ?
Date: Wed, 11 Apr 2012 13:21:50 +0200
Message-ID: <vpq7gxmzf75.fsf@bauges.imag.fr>
References: <4F855E6B.4010504@danisch.de> <20120411105906.GA19823@burratino>
	<4F8565BC.1070701@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Hadmut Danisch <hadmut@danisch.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 13:22:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHvcg-0001X9-Is
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 13:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596Ab2DKLV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 07:21:58 -0400
Received: from mx2.imag.fr ([129.88.30.17]:44242 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553Ab2DKLV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 07:21:57 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q3BBGDZU024208
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 11 Apr 2012 13:16:13 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SHvcV-0002bk-K8; Wed, 11 Apr 2012 13:21:51 +0200
In-Reply-To: <4F8565BC.1070701@danisch.de> (Hadmut Danisch's message of "Wed,
	11 Apr 2012 13:06:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 11 Apr 2012 13:16:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3BBGDZU024208
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1334747776.0251@eV+k9M15NMNOa8BGJJKELw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195166>

Hadmut Danisch <hadmut@danisch.de> writes:

> It is not really plausible to create a new branch by checking out a
> non-existing one.

... but it is hardly useful to create a new branch unless you want to
check it out.

I think the most common way to create a branch with Git is "git checkout
-b new-branch", which does the creation+checkout in a single command.
"git checkout --orphan" is the natural extension of it.

BTW, it is rarely good practice to create an empty branch in an existing
repository. You'll have different branches that do not share any
history, and they would likely be better in separate repositories (or at
least, be in separate local repositories, pushed to the same remote bare
repository, in which case you don't need anything special, just "git
init" and "git push"). That doesn't mean you shouldn't do it, but just
that you may want to think twice before doing it ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
