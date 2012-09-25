From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 0/3] git log --pretty=lua
Date: Tue, 25 Sep 2012 17:19:20 +0200
Message-ID: <vpqvcf2ruyv.fsf@grenoble-inp.fr>
References: <20120925002325.GA19560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 17:19:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGWvG-0002en-60
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 17:19:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754811Ab2IYPTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 11:19:32 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59511 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870Ab2IYPTc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 11:19:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8PFEEXR017801
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 25 Sep 2012 17:14:14 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TGWuv-0001Kz-7S; Tue, 25 Sep 2012 17:19:21 +0200
In-Reply-To: <20120925002325.GA19560@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Sep 2012 20:23:25 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 25 Sep 2012 17:14:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8PFEEXR017801
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1349190855.96585@vTGls9FWYOzG6ZiwOKVung
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206362>

Jeff King <peff@peff.net> writes:

> We've talked off and on about extending the --pretty=format specifiers
> to something more flexible. There's also been talk recently of more
> flexible commit-filtering (e.g., grepping individual notes).

Mercurial has a similar thing, which can be a source of inspiration:

http://www.selenic.com/hg/help/revsets

On the one hand, if find it a bit overkill to have a full language for
this, but on the other hand, it allows expressing easily and explicitely
boolean operators.

I would find

  git log 'grep(foo) or grep(bar)'

very intuitive and elegant, while I never know whether

  git log --grep=foo --grep=bar

is a OR or a AND (there was a patch recently to clarify the doc).

Note that Mercurial's version seem to really act on sets of commits, not
just individual commits, as it allows things like

  hg log -r 'sort(date("May 2008"), user)'

or the equivalent of git's negative revision argument :

  "x - y"
      Changesets in x but not in y.

So it would be more a new "git log --filter='some expression'", not a
--pretty=lua.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
