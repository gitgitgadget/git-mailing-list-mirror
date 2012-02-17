From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] git-latexdiff: new command in contrib, to use latexdiff and Git
Date: Fri, 17 Feb 2012 09:10:46 +0100
Message-ID: <vpqty2px4l5.fsf@bauges.imag.fr>
References: <1329320987-15203-1-git-send-email-Matthieu.Moy@imag.fr>
	<20120216003300.17228570@sirion> <vpq39abrxav.fsf@bauges.imag.fr>
	<7v8vk2zghl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tim Haga <timhaga@ebene6.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 17 09:11:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyIuE-000703-8A
	for gcvg-git-2@plane.gmane.org; Fri, 17 Feb 2012 09:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab2BQIK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 03:10:57 -0500
Received: from mx2.imag.fr ([129.88.30.17]:57719 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730Ab2BQIK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2012 03:10:56 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q1H87KPv015464
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 17 Feb 2012 09:07:20 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RyItz-0005aE-Qs; Fri, 17 Feb 2012 09:10:47 +0100
In-Reply-To: <7v8vk2zghl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 16 Feb 2012 12:10:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 17 Feb 2012 09:07:21 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1H87KPv015464
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1330070845.34675@mUGPanzg4PAh5fMNyVTHbw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190937>

Junio C Hamano <gitster@pobox.com> writes:

> Honestly speaking, this is looking more like an "useful application for
> latex users who happen to use git to store their document source", and not
> a "useful addition for all git users", to me.
>
> These two viewpoint suggests completely different evolution path for this
> program.  Imagining what the first major new enhancement intended for
> people outside the original audience <git,latex> will be, I have this
> suspicion that "this new version will help people who have their documents
> stored in Mercurial" would be much more realistic (and the end result
> being useful) than "this new version will help git users who do not write
> their documents in latex but in asciidoc".

I agree that the next step may be to allow users of <whatever SCM
outside Git>, but I don't think the way to do that would be to make the
script generic. The script is a quick hack, and all the "clever" parts
of it are calls to Git. If someone were to adapt this for Mercurial or
Bzr, writting a python plugin would be a much better way to go
(Mercurial already has "hg extdiff" doing the hardlinked checkouts for
example, and both would allow better command-line option parsing than
my "case $1 in ... esac").

I normally like code reuse very much, but trying to make a 250 lines
long script generic enough to accept multiple SCMs would be more work
than a rewrite.

OTOH, having this script in contrib/ has several advantages over
maintaining it as a separate one-file project:

- "make install" uses Git's Makefile configuration, so it's easy to
  install.

- It makes it natural to use this mailing list for discussion. The
  script has already improved a lot since I posted it as a patch here.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
