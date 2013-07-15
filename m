From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: What's cooking in git.git (Jul 2013, #05; Fri, 12)
Date: Mon, 15 Jul 2013 10:34:42 +0200
Message-ID: <vpqd2qkgr19.fsf@anie.imag.fr>
References: <7vk3kvie4h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 10:34:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyeFB-0006M9-Kh
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 10:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab3GOIet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 04:34:49 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60512 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754500Ab3GOIer (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 04:34:47 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r6F8YfZA031385
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 10:34:41 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UyeF0-0005lr-CX; Mon, 15 Jul 2013 10:34:42 +0200
In-Reply-To: <7vk3kvie4h.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 12 Jul 2013 15:53:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Jul 2013 10:34:42 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6F8YfZA031385
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1374482082.67588@NlBH/poyI9IfwjxD8B4FGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230439>

Junio C Hamano <gitster@pobox.com> writes:

> * bp/mediawiki-preview (2013-07-08) 7 commits
>   (merged to 'next' on 2013-07-12 at 870890a)
>  + git-remote-mediawiki: add preview subcommand into git mw
>  + git-remote-mediawiki: add git-mw command
>  + git-remote-mediawiki: factoring code between git-remote-mediawiki and Git::Mediawiki
>  + git-remote-mediawiki: update tests to run with the new bin-wrapper
>  + git-remote-mediawiki: add a git bin-wrapper for developement
>  + wrap-for-bin: make bin-wrappers chainable
>  + git-remote-mediawiki: introduction of Git::Mediawiki.pm
>
>  Add a command to allow previewing the contents locally before
>  pushing it out, when working with a MediaWiki remote.
>
>  I personally do not think this belongs to Git.  If you are working
>  on a set of AsciiDoc source files, you sure do want to locally
>  format to preview what you will be pushing out, and if you are
>  working on a set of C or Java source files, you do want to test it
>  before pushing it out, too.  That kind of thing belongs to your
>  build script, not to your SCM.

There's one big difference: when you use AsciiDoc/C/Java/... your build
system works locally. "git mw preview" uses the remote wiki to do the
rendering. It doesn't do so with the remote-helper interface, but uses
the same remote and same configuration as the remote-helper, and it
shares some code with it. It seems logical to let it leave next to the
remote-helper (but clearly in contrib/, not in the core Git).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
