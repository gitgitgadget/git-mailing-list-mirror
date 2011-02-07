From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 07 Feb 2011 07:54:36 +0100
Message-ID: <vpq7hdcjpw3.fsf@bauges.imag.fr>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
	<201102070022.51403.johan@herland.net>
	<vpqtyggk9i2.fsf@bauges.imag.fr>
	<201102070451.37370.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 07:57:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmL2K-0004TZ-JE
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 07:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab1BGG5T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 01:57:19 -0500
Received: from mx2.imag.fr ([129.88.30.17]:47395 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab1BGG5S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 01:57:18 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p176sahn009859
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 7 Feb 2011 07:54:36 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PmKzd-0004bZ-Bo; Mon, 07 Feb 2011 07:54:37 +0100
In-Reply-To: <201102070451.37370.johan@herland.net> (Johan Herland's message of "Mon\, 07 Feb 2011 04\:51\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 07 Feb 2011 07:54:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p176sahn009859
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1297666477.66004@RuH1h2yFPnwsXNt0YYVOgw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166238>

Johan Herland <johan@herland.net> writes:

> When you push to "remoteB", you would say "git push remoteB tag v1.7.4", and 
> it would resolve "v1.7.4" (via "refs/remotes/remoteA/tags/v1.7.4") into the 
> appropriate SHA-1, and then push the "v1.7.4" tag to the remote.

That means I can fetch git-gui/v1.0, gitk/v1.1 and git/v1.7, my
subproject tags are well sorted in my local repository, but if they
don't have the same shortname, they're not "ambiguous", and the
namespace will be completely flattened when I push (i.e. I'll push
v1.0, v1.1 and v1.7, and people accessing my repository will not be
able to say whether they refer to gitk, git-gui or git versions).

This defeats the point in having proper namespaces, and we'll still
see handmade namespaces like we already have now for git-gui tags in
git.git.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
