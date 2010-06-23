From: Jeff King <peff@peff.net>
Subject: Re: Newbie question: how can I list added files?
Date: Wed, 23 Jun 2010 14:30:50 -0400
Message-ID: <20100623183050.GA20842@coredump.intra.peff.net>
References: <AANLkTinxOE5xcP_V-PvoZGlfsxtcCafoYKy_PuBZnQnQ@mail.gmail.com>
 <7vzkylejbf.fsf@alter.siamese.dyndns.org>
 <AANLkTikE2ylLXk5XxNGvcvol6R-puSTzPurdLcNMYaZJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, GIT List <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 20:30:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORUiv-00016K-Nt
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 20:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753055Ab0FWSax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 14:30:53 -0400
Received: from peff.net ([208.65.91.99]:55091 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab0FWSaw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 14:30:52 -0400
Received: (qmail 31137 invoked by uid 107); 23 Jun 2010 18:31:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 23 Jun 2010 14:31:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Jun 2010 14:30:50 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikE2ylLXk5XxNGvcvol6R-puSTzPurdLcNMYaZJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149528>

On Wed, Jun 23, 2010 at 10:50:11AM -0700, Bruce Korb wrote:

> On Wed, Jun 23, 2010 at 10:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > "git diff --name-only --diff-filter=A HEAD"?
> 
> Thank you, but "Nope."
> My added file doesn't show anything and not using the
> "--diff-filter" thing shows both added and not added files:
> 
> $ git diff --name-only --diff-filter=A HEAD
> $ git-status
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       modified:   sw/embedded/platform/strad/scripts/mk_relsrc.sh
> [...]
> $ git diff --name-only HEAD
> chip/chopin2/up/hdl/.sopc_builder/install.ptf
> chip/mozart/up_oam/hdl/.sopc_builder/install.ptf
> chip/mozart2/up/hdl/.sopc_builder/install.ptf
> chip/mozart2/up_ft/hdl/.sopc_builder/install.ptf
> sw/embedded/nios2/system/system.stf
> sw/embedded/platform/strad/scripts/mk_relsrc.sh
> sw/projects/nios2/modules/system/lib/system.stf

Usually when we say "added file", it means "a new file which has just
been added". Did you mean "a file which was modified, but whose contents
I have already added to the index"?

In that case, I think you just want:

  git diff --cached --name-only

to see files that differ between the index and HEAD (i.e., things which
will be committed).

-Peff
