From: David Kowis <dkowis@shlrm.org>
Subject: Re: git-rebase nukes multiline comments
Date: Fri, 16 Jun 2006 12:23:05 -0500
Message-ID: <4492E8F9.4000106@shlrm.org>
References: <20060616171251.GA29820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jun 16 19:23:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrI2I-0000q3-55
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 19:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWFPRXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 13:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbWFPRXG
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 13:23:06 -0400
Received: from adsl-66-143-246-231.dsl.snantx.swbell.net ([66.143.246.231]:22190
	"EHLO mail.shlrm.org") by vger.kernel.org with ESMTP
	id S1751497AbWFPRXF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 13:23:05 -0400
Received: from [192.168.2.111] (rrcs-24-173-63-133.sw.biz.rr.com [24.173.63.133])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.shlrm.org (Postfix) with ESMTP id 040FB2816BBC;
	Fri, 16 Jun 2006 12:23:03 -0500 (CDT)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: git@vger.kernel.org, xorg@lists.freedesktop.org
In-Reply-To: <20060616171251.GA29820@suse.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21950>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Matthias Hopf wrote:
> Hi all,
> 
> I'm using git-1.2.4 on SL10.1, in centralized style development (for X.org).
> 
> I wanted to commit a set of changes (4 local commits) upstream, so I had
> to do a git-rebase first (in that particular case a git-pull would have
> been possible as well, but git-rebase fits the CVS style development
> better). After git-fetch, git-rebase origin, and git-push all my changes
> had only the first line of the changelog comment, the remainder was
> nuked.
> 
> To reproduce:
> 
> mkdir /var/tmp/blaup
> cd /var/tmp/blaup
> git-init-db
> echo test > foo
> git-add foo
> git-commit      (any comment)
> cd ..
> git-clone /var/tmp/blaup bla
> cd bla
> echo test2 >>foo 
> git-commit foo  (multiline comment)
> cd ../blaup
> echo test3 >bar
> git-add bar
> git-commit      (any comment)
> cd ../bla
> git-fetch
> git-log         (shows multiline comment for 'test2')
> git-rebase origin
> git-log         (shows only the first line of the multiline comment!)
> 
> 

I'm new to git, but I tried what you said.
my git log:
commit c846bea8c61bec7cf0f7688c48abc42577b9ac7f
Author: David Kowis <dkowis@kain.org>
Date:   Fri Jun 16 12:20:08 2006 -0500

    this is a multi

    line comment
    with three lines


I'm using git 1.4.0. It added a blank line in there...


David Kowis

ISO Team Lead - www.sourcemage.org
Source Mage GNU/Linux

Progress isn't made by early risers. It's made by lazy men trying to
find easier ways to do something.
  - Robert Heinlein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)

iQGVAwUBRJLo+cnf+vRw63ObAQomewv+L18ogJHgx3jQPt/B+K84GIAX5SugrSnZ
ASC2jm/sbMdidU1goOepXILw2DBOWKSpuDwTZXE0uDrldMTK4RW/2dDACbGVEQX/
Ter4cclIxNztaAwzXGHqKyOI24c5jQmlzW+yDcnErJZTexDA6xyp4xVZlySJpZev
tzfj1Di/uYNJ83lcgS9ID64JToZ5sYZjeqy5HjfEpEQR7xHSYoaR94LNjSHMrqU8
S32ryCMeBSX9SWP8lX7lv6YzIlPGYbOVIsskANVN4GyYVdoMXyXpNtDvziIXrxJj
FkSCloMq5bzVuykthPer0FQRXiySyM1bWsUt9i7Xf3fF8qzyVpIJghP3GAlwh4Gs
LRefaUkkVH61FmN+Uw65xxdx99L4ABoZJDpPBhQdOnY+BXbhNGM5p/lAi3iX72Bx
eIMmaWiwxF8XlIaLJFbDVtGA7lwJzneQQUyHHlTZhzu+VXf4ulKPE93NKEuWWqnL
FD9Tgmu5sFANq5iKSCyocvyAqiWljR8w
=hQWx
-----END PGP SIGNATURE-----
