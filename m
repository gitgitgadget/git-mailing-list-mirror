From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: a bug when execute "git status" in git version 1.7.7.431.g89633
Date: Sun, 23 Oct 2011 10:25:28 +0200
Message-ID: <vpqfwiknmh3.fsf@bauges.imag.fr>
References: <4EA20C5B.3090808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: John Hsing <tsyj2007@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 23 10:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHtND-0004pT-Kl
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 10:25:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755142Ab1JWIZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Oct 2011 04:25:34 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58006 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755032Ab1JWIZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 04:25:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p9N8Lv7O000702
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 23 Oct 2011 10:21:57 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RHtN2-0000sP-QL; Sun, 23 Oct 2011 10:25:28 +0200
In-Reply-To: <4EA20C5B.3090808@gmail.com> (John Hsing's message of "Sat, 22
	Oct 2011 08:20:43 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 23 Oct 2011 10:21:57 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p9N8Lv7O000702
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1319962919.08414@h3wCI8ZcAanFCmmd76K6qA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184128>

John Hsing <tsyj2007@gmail.com> writes:

> the error:

When does this error occur? is it reproducible on any repository? Which
OS?

> git: malloc.c:3096: sYSMALLOc: Assertion `(old_top == (((mbinptr)
> (((char *) &((av)->bins[((1) - 1) * 2])) - __builtin_offsetof (struct
> malloc_chunk, fd)))) && old_size == 0) || ((unsigned long) (old_size) >=
> (unsigned long)((((__builtin_offsetof (struct malloc_chunk,
> fd_nextsize))+((2 * (sizeof(size_t))) - 1)) & ~((2 * (sizeof(size_t))) -
> 1))) && ((old_top)->size & 0x1) && ((unsigned long)old_end & pagemask)
> == 0)' failed.

The assertion is violated outside the source code of Git itself, so
either Git calls malloc incorrectly, or this is a bug in your libc.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
