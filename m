From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2010, #03; Wed, 07)
Date: Thu, 8 Apr 2010 03:38:26 -0400
Message-ID: <20100408073825.GA15153@coredump.intra.peff.net>
References: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 09:38:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzmKC-00011v-F6
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 09:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145Ab0DHHir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 03:38:47 -0400
Received: from peff.net ([208.65.91.99]:60590 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932113Ab0DHHiq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 03:38:46 -0400
Received: (qmail 18443 invoked by uid 107); 8 Apr 2010 07:38:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 03:38:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 03:38:26 -0400
Content-Disposition: inline
In-Reply-To: <7v6342ahx9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144342>

On Wed, Apr 07, 2010 at 05:48:02PM -0700, Junio C Hamano wrote:

> * jc/test-sleepless (2010-04-06) 1 commit
>   (merged to 'next' on 2010-04-07 at 8ccf40a)
>  + war on "sleep" in tests

I read this one, and it looked fine to me.

> * sd/log-decorate (2010-04-06) 4 commits
>   (merged to 'next' on 2010-04-06 at 992c9ad)
>  + log --pretty/--oneline: ignore log.decorate
>   (merged to 'next' on 2010-03-08 at 58a6fba)
>  + log.decorate: usability fixes
>  + Add `log.decorate' configuration variable.
>  + git_config_maybe_bool()
> 
> I did the tip one myself.  An extra set or two of eyeballs would be
> appreciated.

I just responded in that thread.

> * jk/cached-textconv (2010-04-01) 7 commits
>   (merged to 'next' on 2010-04-02 at a023e3c)
>  + diff: avoid useless filespec population
>  + diff: cache textconv output
>  + textconv: refactor calls to run_textconv
>  + introduce notes-cache interface
>  + make commit_tree a library function
>  + fix textconv leak in emit_rewrite_diff
>  + fix const-correctness of write_sha1_file

You mentioned pushing this off to 1.7.2. I don't have a problem with
that, but you may want to cherry-pick or merge up to the "fix textconv
leak", as it is an unrelated fix.

I think it makes sense to target 1.7.2 with the feature, and then flip
the default for diff.*.cachetextconv to 'true' in 1.7.3. That will give
it some wider exposure before we start running it by default.

> * nd/setup (2010-04-05) 43 commits
> [...]
> Rerolled.  I need to look at this series during the feature freeze so that
> we can decide to (or not to) include it in 'next' early in post 1.7.1 cycle.

I really should review this, but it's just so dauntingly large and
boring looking that I haven't gotten around to it. Probably one or both
of us should look at it before applying it to next, but assuming it
passes a basic sanity check, I think the best thing will be to get it in
'next' early so we can shake out any bugs during the next cycle.

-Peff
