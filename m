From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: thoughts on a possible "pre-upload" hook
Date: Fri, 25 Sep 2009 14:29:47 +0200
Message-ID: <vpqab0j1a2s.fsf@bauges.imag.fr>
References: <2e24e5b90909220320rbd5fd1l40c7898656445232@mail.gmail.com>
	<867hvr2cms.fsf@blue.stonehenge.com> <vpqd45jvub6.fsf@bauges.imag.fr>
	<20090922161725.GS14660@spearce.org>
	<2e24e5b90909250454s7ed35b9ch10b954b0b1a40cfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 14:30:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mr9w7-0000RA-6c
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 14:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbZIYM35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 08:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbZIYM35
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 08:29:57 -0400
Received: from mx2.imag.fr ([129.88.30.17]:58933 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752374AbZIYM34 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 08:29:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8PCQYVH005495
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 Sep 2009 14:26:34 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mr9vo-00058X-8T; Fri, 25 Sep 2009 14:29:48 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Mr9vn-0002Wa-7g; Fri, 25 Sep 2009 14:29:47 +0200
In-Reply-To: <2e24e5b90909250454s7ed35b9ch10b954b0b1a40cfe@mail.gmail.com> (Sitaram Chamarty's message of "Fri\, 25 Sep 2009 17\:24\:36 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 Sep 2009 14:26:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8PCQYVH005495
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1254486397.28693@+jZQmVS4WHVT02AAHjPoRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129079>

Sitaram Chamarty <sitaramc@gmail.com> writes:

> yes indeed -- if someone were to foolishly merge a "secret" branch
> into a "normal" branch, so that it is now reachable from a "normal"
> branch, that's his problem -- that cannot be within the scope of this
> check.

Merging is not the only scenario. Adding a tag could make secret
things become visible too. I'm not saying the approach isn't viable,
but if it gets implemented, it should be done with care to make sure
there's no easy mis-use that would lead to reveal a secret (typically,
I'd do that with a whitelist and not a black-list, so that new
references are secret by default).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
