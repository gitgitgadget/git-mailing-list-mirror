From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Having Git follow symlinks
Date: Fri, 31 Jan 2014 18:56:42 +0100
Message-ID: <vpqiot0ox0l.fsf@anie.imag.fr>
References: <alpine.DEB.2.02.1401281443330.17426@perkele.intern.softwolves.pp.se>
	<CALKQrgf5o-ZcaeqXLm3P7RpK2yPcFd_HnG4ewwoEGESduyDSjQ@mail.gmail.com>
	<alpine.DEB.2.00.1401300958320.30100@ds9.cixit.se>
	<vpqa9ed1w8y.fsf@anie.imag.fr>
	<alpine.DEB.2.00.1401311052370.3993@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jan 31 18:57:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9ILE-0003jk-20
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 18:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933300AbaAaR4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 12:56:54 -0500
Received: from mx1.imag.fr ([129.88.30.5]:55573 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933288AbaAaR4v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 12:56:51 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s0VHuf5F012384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 31 Jan 2014 18:56:41 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id s0VHugb1026921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 31 Jan 2014 18:56:42 +0100
In-Reply-To: <alpine.DEB.2.00.1401311052370.3993@ds9.cixit.se> (Peter
	Krefting's message of "Fri, 31 Jan 2014 10:56:41 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 31 Jan 2014 18:56:41 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s0VHuf5F012384
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1391795804.06991@BNbcRAE1CUBFOCVN/AV34A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241311>

Peter Krefting <peter@softwolves.pp.se> writes:

> Oh, well, if I have the time, maybe I can come up with a patch. There
> is already some hacks in the "core.symlinks" setting, so I guess it
> should be possible.

I'd love to have a way to follow symlinks, but this needs to be done
with care: when following symlinks, writing to a link may mean writing
outside the Git repository, which brings some security concerns. Not
that following symlinks has to be insecure, but we'd have to make sure
that it does not allow a malicious user to e.g. setup a symlink to
~/.bashrc and then write to it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
