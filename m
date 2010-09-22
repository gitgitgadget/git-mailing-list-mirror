From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/2] diff: add a special SYMLINK user-diff driver
Date: Wed, 22 Sep 2010 07:53:49 +0200
Message-ID: <vpqpqw6coia.fsf@bauges.imag.fr>
References: <20100921205914.GA1166@sigill.intra.peff.net>
	<20100921211303.GB1188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 22 07:55:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyIIc-0005Od-7E
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 07:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab0IVFzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 01:55:14 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43484 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316Ab0IVFzN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 01:55:13 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o8M5nCbx012419
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 22 Sep 2010 07:49:12 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OyIH7-0007X9-M8; Wed, 22 Sep 2010 07:53:49 +0200
In-Reply-To: <20100921211303.GB1188@sigill.intra.peff.net> (Jeff King's message of "Tue\, 21 Sep 2010 17\:13\:03 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 22 Sep 2010 07:49:12 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o8M5nCbx012419
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1285739352.6942@jurTZnZ9Lmet0/iHPXqNeA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156784>

Jeff King <peff@peff.net> writes:

> So I wonder if the problem really is not in the userdiff code at all,
> and we should be disabling gitattribute lookup entirely for non-regular
> files.

Actually, I'd also say that what needs to be changed is on the
.gitattributes side, not on the .gitconfig side.

Another option would be zsh-style globbing, like:

# any symbolic link
*(@) diff=link

# Symbolic links named *.pdf
*.pdf(@)

(except that * means "all" to zsh, and should mean "regular" to Git).

But OTOH, that's a lot of work to implement, for very little benefit.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
