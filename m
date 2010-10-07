From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git log doesn't allow %x00 in custom format anymore?
Date: Thu, 07 Oct 2010 19:52:42 +0200
Message-ID: <vpqaamp3n6d.fsf@bauges.imag.fr>
References: <D9157D2F-31D5-44EF-8FB4-F0E62BBF8017@jetbrains.com>
	<20101007141015.GB8162@sigill.intra.peff.net>
	<5BA0D807-C5C0-4797-82CD-5D5087496D6F@jetbrains.com>
	<4CADE232.8030801@viscovery.net>
	<FF2FF369-0B1C-457E-A86E-8651BF0A82CB@jetbrains.com>
	<20101007172939.GA12130@sigill.intra.peff.net>
	<AANLkTimYVNNjhaqUHjoVOV-fQBhcENKn7cyj10qcZ+MW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Oct 07 19:53:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3ueK-0001V3-Cs
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 19:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753539Ab0JGRwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Oct 2010 13:52:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45382 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619Ab0JGRwx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Oct 2010 13:52:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o97Hd12F006934
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 7 Oct 2010 19:39:01 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P3ue3-0001ko-1s; Thu, 07 Oct 2010 19:52:43 +0200
In-Reply-To: <AANLkTimYVNNjhaqUHjoVOV-fQBhcENKn7cyj10qcZ+MW@mail.gmail.com> (Erik Faye-Lund's message of "Thu\, 7 Oct 2010 19\:41\:01 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 07 Oct 2010 19:39:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o97Hd12F006934
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1287077944.20215@74hFDXX+VdzzGiEW+HQLOA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158418>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Also, fwriting like that to stdout might be a bit troublesome on
> Windows because the string won't end up going through our
> ANSI-emulation.

I don't know which one would be most portable, but if fwrite is the
problem, then

  printf("%*s%c", buf.buf, buf.len, info->hdr_termination);

should do the trick.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
