From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH 0/2] Add an update=none option for 'loose' submodules
Date: Wed, 24 Aug 2011 22:38:16 +0200
Message-ID: <20110824203816.GG45292@book.hvoigt.net>
References: <cover.1312923673.git.hvoigt@hvoigt.net> <7v8vqzreeo.fsf@alter.siamese.dyndns.org> <20110811195955.GA21185@book.hvoigt.net> <7vy5yujtr2.fsf@alter.siamese.dyndns.org> <20110822200052.GC11745@sandbox-rc> <7v62lpuky8.fsf@alter.siamese.dyndns.org> <20110823194350.GA57187@book.hvoigt.net> <4E540B03.2030909@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Aug 24 22:38:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwKDT-0005v3-B7
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 22:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620Ab1HXUiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 16:38:22 -0400
Received: from darksea.de ([83.133.111.250]:54902 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751617Ab1HXUiV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 16:38:21 -0400
Received: (qmail 5489 invoked from network); 24 Aug 2011 22:38:17 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 24 Aug 2011 22:38:17 +0200
Content-Disposition: inline
In-Reply-To: <4E540B03.2030909@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180037>

On Tue, Aug 23, 2011 at 10:18:11PM +0200, Jens Lehmann wrote:
> Am 23.08.2011 21:43, schrieb Heiko Voigt:
> > Another change I am thinking of (which would definitely need an entry in
> > the release notes) is to change submodule foreach to iterate over all
> > gitmodule entries in the index/HEAD/worktree (not sure yet) instead of
> > "just entries that are in .git/config".
> 
> When changing the default I think we'll surprise a lot of users (imagine
> someone running a "git submodule foreach pwd" when some submodules aren't
> populated). But adding an option to "git submodule foreach" (and maybe others)
> to get the list of submodules from the index or HEAD might make sense (while
> I'm not sure parsing the work tree does, as you'll basically have to pick up
> any .git you find. AFAICS a submodule is defined either by an entry in the
> .gitmodules file, in .git/config or through a gitlink entry in a commit or the
> index. So maybe the third alternative to index and HEAD is to use those found
> in .gitmodules?).
> 
> Could you describe a use case for that?

Yes, a repository using the submodule.$name.checkout=none config.

Currently its hard to iterate over all submodules to set this config to
'checkout' locally. You can not use submodule foreach for that since it
will skip submodule directories that do not have .git in them.

But you are right this should obviously be done using an option like

	git submodule foreach --head ...

or similar.

Cheers Heiko
