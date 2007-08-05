From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: GIT push to sftp (feature request)
Date: Mon, 06 Aug 2007 00:20:55 +0200
Message-ID: <vpqir7t8vy0.fsf@bauges.imag.fr>
References: <200708051105.44376.pavlix@pavlix.net>
	<46a038f90708051412p722aa906v73e986a805f1558b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pavlix <pavlix@pavlix.net>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 00:25:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHoX5-0006lL-V9
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 00:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754409AbXHEWZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 18:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754607AbXHEWZE
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 18:25:04 -0400
Received: from imag.imag.fr ([129.88.30.1]:49350 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754316AbXHEWZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 18:25:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l75MKu8F003570
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 6 Aug 2007 00:20:56 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IHoT2-0003Ys-2G; Mon, 06 Aug 2007 00:20:56 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IHoT1-00081E-W6; Mon, 06 Aug 2007 00:20:56 +0200
Mail-Followup-To: "Martin Langhoff" <martin.langhoff@gmail.com>, pavlix <pavlix@pavlix.net>,  git@vger.kernel.org
In-Reply-To: <46a038f90708051412p722aa906v73e986a805f1558b@mail.gmail.com> (Martin Langhoff's message of "Mon\, 6 Aug 2007 09\:12\:41 +1200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 06 Aug 2007 00:20:56 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55077>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> Git tries to be smart in at least 2 ways that don't work with dump
> protocols: it works locklessly (yet it performs atomic updates) and it
> sends only the objects needed over the wire (saving a lot of
> bandwidth).
>
> Using dumb protocols it's impossible to do either.

That's not exactly true. You can't be as efficient with dumb protocols
than you are with a dedicated protocol (something with some
intelligence on both sides), but at least the second point you mention
can be achieved with a dumb protocol, and bzr is a proof of existance.
To read over HTTP, it uses ranges request, and to push over
ftp/sftp/webdav, it appends new data to existing files (its ancestor,
GNU Arch, also had a way to be network-efficient on dumb protocols).

Regarding atomic and lock-less updates, I believe this is
implementable too as soon as you have an atomit "rename" in the
protocol. But here, bzr isn't a proof of existance, it does locking.

(BTW, about bzr, it also has a dedicated server now)

-- 
Matthieu
