From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] rebase: convert revert to squash on autosquash
Date: Fri, 08 Apr 2016 13:42:12 +0200
Message-ID: <vpqtwjcnx7v.fsf@anie.imag.fr>
References: <1460041965-31526-1-git-send-email-mst@redhat.com>
	<alpine.DEB.2.20.1604071720160.2967@virtualbox>
	<20160407184026-mutt-send-email-mst@redhat.com>
	<alpine.DEB.2.20.1604081309150.2967@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Michael S. Tsirkin" <mst@redhat.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 08 13:42:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoUoB-0001Mx-Sh
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 13:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758237AbcDHLmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 07:42:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60255 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758226AbcDHLmW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 07:42:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u38BgAQJ004322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 8 Apr 2016 13:42:10 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u38BgC8R015148;
	Fri, 8 Apr 2016 13:42:12 +0200
In-Reply-To: <alpine.DEB.2.20.1604081309150.2967@virtualbox> (Johannes
	Schindelin's message of "Fri, 8 Apr 2016 13:13:51 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 08 Apr 2016 13:42:11 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u38BgAQJ004322
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460720533.81298@EIwl9ZoSSAt6Bk9/BAeOyA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291026>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	git revert -n deadbeef
> 	git commit --squash deadbeef
>
> where "deadbeef" is the placeholder for the actual commit to revert.
>
> And indeed, I use exactly this song and dance quite frequently, *iff* my
> intention is to drop a patch.
>
> A much better idea than co-opting the "Revert" commit message would be to
> introduce a sibling to --fixup and --squash that you could call
> --drop.

One could also add --fixup and --squash to "git revert", so the above
would become

    git revert --squash deadbeef

In most cases, I find it simpler to just start a rebase -i and drop the
commit from rebase's todo-list.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
