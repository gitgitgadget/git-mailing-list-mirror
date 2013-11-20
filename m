From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Bizarre git merge behaviour
Date: Wed, 20 Nov 2013 13:29:52 +0100
Message-ID: <528CAB40.8030107@viscovery.net>
References: <l6hbgg$oej$1@ger.gmane.org> <528C62BE.7060803@viscovery.net> <20131120120326.GD26413@debian.cengia.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthew Cengia <mattcen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 13:30:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj6uu-0008G4-G7
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 13:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab3KTM34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 07:29:56 -0500
Received: from so.liwest.at ([212.33.55.18]:57327 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751681Ab3KTM34 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 07:29:56 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Vj6um-00067C-JZ; Wed, 20 Nov 2013 13:29:52 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 46A7816613;
	Wed, 20 Nov 2013 13:29:52 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131120120326.GD26413@debian.cengia.id.au>
X-Enigmail-Version: 1.6
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238075>

Am 11/20/2013 13:03, schrieb Matthew Cengia:
> The only changes I expect are these:
> 
> mattcen@sonar:prisonpc(wtf)$ git --no-pager diff --numstat --oneline
> \ "$(git merge-base wtf origin/22869-new-kernel)"
> origin/22869-new-kernel 37      0       client/kernel/README 2797
> 0       client/kernel/config-3.5.7.20-1 0       3525
> client/kernel/config-3.5.7.21-1 -       -
> client/kernel/linux-firmware-image_3.5.7.21-1_i386.deb -       -
> client/kernel/linux-image-3.5.7.20_3.5.7.20-1_i386.deb -       -
> client/kernel/linux-image-3.5.7.21_3.5.7.21-1_i386.deb 1       0
> client/scm/20-security.scm 6       7
> client/scm/50-kernel-prisoner.scm 1       0
> client/scm/50-staff.scm 22      0
> doc/user_acceptance_tests/README 581     0
> doc/user_acceptance_tests/default.css 1548    0
> doc/user_acceptance_tests/user_acceptance_tests.html 4268    0
> doc/user_acceptance_tests/user_acceptance_tests.pdf 940     0
> doc/user_acceptance_tests/user_acceptance_tests.rst

> mattcen@sonar:prisonpc(wtf)$ git log --left-right --oneline \ 
> wtf...origin/22869-new-kernel ppcadm/modules/quarantine.py | cut
> -c1-70 < 5b5f552 Fixed msg vs msg.as_string because smtp.sendmail is
> picky < 03618f2 Use Return-Path, not X-Original-Envelope-From. <
> dc1169e Bug squashing. < 8e20216 Changed quarantine module to run
> maybe and send directly to < d79ad42 Change final port, name the
> magic number. < e44d1b3 Merge remote-tracking branch 'origin/staging'
> into 22912-ppc < a03db6d Modified quarantine UI to handle the new
> reports format

So, ppcadm/modules/quarantine.py changed only on our side, but not on
their side. This is in accordance with your listing above. Nevertheless,
the file is marked conflicted in your git status --porcelain output in
the original post:

UU ppcadm/modules/quarantine.py

That's strange. I can't tell what is going on. Perhaps you have some
criss-cross merges in your history that merge-recursive trips over?

Sorry, I don't know how to help you further.

-- Hannes
