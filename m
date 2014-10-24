From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Fatal: <hash> is corrupted can be caused by wrong permissions
Date: Fri, 24 Oct 2014 16:05:24 +0200
Message-ID: <vpqbnp1zhp7.fsf@anie.imag.fr>
References: <20141024134802.93466250E0D@webabinitio.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "R. David Murray" <rdmurray@bitdance.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 16:05:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhfUl-0005eA-M2
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 16:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbaJXOFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 10:05:31 -0400
Received: from mx2.imag.fr ([129.88.30.17]:51097 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756565AbaJXOFa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 10:05:30 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s9OE5M3J023497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Oct 2014 16:05:23 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s9OE5OAv010586;
	Fri, 24 Oct 2014 16:05:24 +0200
In-Reply-To: <20141024134802.93466250E0D@webabinitio.net> (R. David Murray's
	message of "Fri, 24 Oct 2014 09:48:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 24 Oct 2014 16:05:23 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s9OE5M3J023497
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1414764323.57448@WUylZEbi+msSAqe3xl9BSw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"R. David Murray" <rdmurray@bitdance.com> writes:

> On git 1.7.1 I ran into the Fatal corruption error in one of my projects.  For
> reasons that are irrelevant I was operating on the repo as user X, a member of
> group Z, but the files were all owned by Y:Z, with (I thought) -rw-rw---
> permissions.  After a bunch of head banging I finally figured out that the
> Fatal error wasn't because the object files were corrupted, but because three
> objects (for reasons unknown to me that are probably lost in the early history
> of the setup of this particular repo...one of the blobs was the first commit)
> were -rw-----.

I can reproduce with Git 1.7.10 by doing a chmod 0 on some object files,
but recent Git's produce

Checking object directories: 100% (256/256), done.
fatal: failed to read object ab2e06e74d922268fbff8d219dad9eee63786947: Permission denied

So I guess this has already been fixed :-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
