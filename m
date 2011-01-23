From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Move git-stash from one machine (or working copy) to another
Date: Sun, 23 Jan 2011 10:04:53 +0100
Message-ID: <vpqaaisj8i2.fsf@bauges.imag.fr>
References: <AANLkTin2M+dLUOFnAKqNvYn04NumCmmQ331Yfb9ieW-D@mail.gmail.com>
	<7vfwsmp2op.fsf@alter.siamese.dyndns.org>
	<1E3784B5-76A2-4071-989D-46E271BB1BAC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Doyle <wpdster@gmail.com>, git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 23 10:06:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pgvte-0005wB-9j
	for gcvg-git-2@lo.gmane.org; Sun, 23 Jan 2011 10:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab1AWJFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 04:05:39 -0500
Received: from mx2.imag.fr ([129.88.30.17]:41423 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169Ab1AWJFC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 04:05:02 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p0N94rSX030517
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 23 Jan 2011 10:04:53 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PgvsU-0001R4-6m; Sun, 23 Jan 2011 10:04:54 +0100
In-Reply-To: <1E3784B5-76A2-4071-989D-46E271BB1BAC@gmail.com> (David Aguilar's message of "Sat\, 22 Jan 2011 18\:05\:20 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 23 Jan 2011 10:04:54 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p0N94rSX030517
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1296378295.5021@f4ny+Xd3AfG1lpTnZPSAVA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165420>

David Aguilar <davvid@gmail.com> writes:

> This won't handle all cases, but it should do the trick 80%+ of the
> time.
>
> % git diff > foo.patch

Or, if the patch produced by "git diff" doesn't do it:

git commit -am foo
git format-patch -1
git reset HEAD^

> (on other machine)
> % git apply foo.patch

In one command:

git diff | ssh other-machine 'cd /path/to/repo && git apply'

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
