From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Dangling blob after git gc
Date: Thu, 27 Nov 2008 14:46:47 +0100
Message-ID: <vpqzljlnuwo.fsf@bauges.imag.fr>
References: <20081127133027.GW4746@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Nov 27 14:51:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5hGr-0006Vq-B7
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 14:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599AbYK0Nts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 08:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbYK0Nts
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 08:49:48 -0500
Received: from imag.imag.fr ([129.88.30.1]:58846 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbYK0Nts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 08:49:48 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id mARDkmon015034
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 27 Nov 2008 14:46:48 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1L5hCh-0001Us-Vk; Thu, 27 Nov 2008 14:46:48 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1L5hCh-0000hK-TU; Thu, 27 Nov 2008 14:46:47 +0100
In-Reply-To: <20081127133027.GW4746@genesis.frugalware.org> (Miklos Vajna's message of "Thu\, 27 Nov 2008 14\:30\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 27 Nov 2008 14:46:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101813>

Miklos Vajna <vmiklos@frugalware.org> writes:

> The commits are probably due to reflogs, that's OK. But why do I have a
> dangling blob after git gc? The interesting part is that as you can see
> most of them is removed, but not all.
>
> Any ideas? :)

from man git-gc:

     The optional configuration variable gc.pruneExpire controls
     how old the unreferenced loose objects have to be before
     they are pruned. The default is "2 weeks ago".

Git can hardly know for sure whether a dangling object is actually a
temporary object used by another instance of git or actually an unused
object. Older versions of Git required you to explicitely say --prune
to mean "OK, _I_ am sure, you can prune the objects", newer do it the
safe way by removing only objects old enough.

-- 
Matthieu
