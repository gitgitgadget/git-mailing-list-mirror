From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Advanced revision selection?
Date: Fri, 27 May 2016 17:59:12 +0200
Message-ID: <vpq8tyvmqzz.fsf@anie.imag.fr>
References: <874m9j7bnv.fsf@thinkpad.rath.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 17:59:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6KAS-0005EU-Mh
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 17:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959AbcE0P7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 11:59:16 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59954 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755229AbcE0P7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 11:59:16 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4RFxAFO007315
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 27 May 2016 17:59:10 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4RFxC4H013365;
	Fri, 27 May 2016 17:59:12 +0200
In-Reply-To: <874m9j7bnv.fsf@thinkpad.rath.org> (Nikolaus Rath's message of
	"Fri, 27 May 2016 08:39:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 27 May 2016 17:59:10 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4RFxAFO007315
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1464969550.36414@HC3AaEg3msgrHYRk68Y7+A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295765>

Nikolaus Rath <Nikolaus@rath.org> writes:

> In Mercurial, this can be done with a more verbose syntax (e.g.
> "last(ancestors(tag("re:release-.*")),3) and descendants(aebeccf)" for
> the above example).

This has no direct equivalent in Git. A lot can be done passing options
to "git rev-list" or so, for example, but I don't think a combination
can be found for your exact example.

The closest I get is:

  git log `git for-each-ref refs/tags/release- --format '%(refname)'` -3

Which lists 3 commits preceeding a tag whose name starts with release-.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
