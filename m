From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2011, #02; Mon, 5)
Date: Tue, 6 Dec 2011 00:52:39 -0500
Message-ID: <20111206055239.GA20671@sigill.intra.peff.net>
References: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 06:52:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXnxO-0005Qs-2l
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 06:52:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab1LFFwn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 00:52:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40026
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752320Ab1LFFwm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 00:52:42 -0500
Received: (qmail 762 invoked by uid 107); 6 Dec 2011 05:59:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Dec 2011 00:59:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2011 00:52:39 -0500
Content-Disposition: inline
In-Reply-To: <7v8vmqi98f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186317>

On Mon, Dec 05, 2011 at 09:01:52PM -0800, Junio C Hamano wrote:

> * jk/credentials (2011-11-28) 20 commits
>  - fixup! 034c066e
>  - compat/getpass: add a /dev/tty implementation
>  - credential: use git_prompt instead of git_getpass
>  - prompt: add PROMPT_ECHO flag
>  - stub out getpass_echo function
>  - refactor git_getpass into generic prompt function
>  - move git_getpass to its own source file
>  - t: add test harness for external credential helpers
>  - credentials: add "store" helper
>  - strbuf: add strbuf_add*_urlencode
>  - credentials: add "cache" helper
>  - docs: end-user documentation for the credential subsystem
>  - credential: make relevance of http path configurable
>  - credential: add credential.*.username
>  - credential: apply helper config
>  - http: use credential API to get passwords
>  - credential: add function for parsing url components
>  - introduce credentials API
>  - t5550: fix typo
>  - test-lib: add test_config_global variant
> 
> Expecting a reroll?

Yes, I have a re-roll ready. I was holding back to see if some of the
helper authors might comment, but got nothing. Perhaps the new version
will spur some interest.

Also, let's drop the top git_getpass bits from the topic for now (they
will not be part of my rebase). They are a separate topic that can go on
top, but I think there was some question from Erik of whether we should
simply roll our own getpass().

> * jk/upload-archive-use-start-command (2011-11-21) 1 commit
>  - upload-archive: use start_command instead of fork
> 
> What's the status of this one?

I think what you have in pu is good, but of course I didn't actually
test it on Windows. Erik?

> * jk/maint-1.6.2-upload-archive (2011-11-21) 1 commit
>  - archive: don't let remote clients get unreachable commits
>  (this branch is used by jk/maint-upload-archive.)
> 
> * jk/maint-upload-archive (2011-11-21) 1 commit
>  - Merge branch 'jk/maint-1.6.2-upload-archive' into jk/maint-upload-archive
>  (this branch uses jk/maint-1.6.2-upload-archive.)
> 
> Will merge to 'next' after taking another look.

Thanks. I also have some followup patches to re-loosen to at least
trees reachable from refs. Do you want to leave the tightening to the
maint track, and then consider the re-loosening for master?

-Peff
