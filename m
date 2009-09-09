From: Jeff King <peff@peff.net>
Subject: jk/1.7.0-status, was: What's cooking in git.git (Sep 2009, #02;
 Mon, 07)
Date: Wed, 9 Sep 2009 07:59:24 -0400
Message-ID: <20090909115924.GA31149@coredump.intra.peff.net>
References: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 13:59:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlLpm-0000GB-Cz
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 13:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbZIIL71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 07:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbZIIL71
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 07:59:27 -0400
Received: from peff.net ([208.65.91.99]:33929 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179AbZIIL70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 07:59:26 -0400
Received: (qmail 28057 invoked by uid 107); 9 Sep 2009 11:59:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 09 Sep 2009 07:59:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Sep 2009 07:59:24 -0400
Content-Disposition: inline
In-Reply-To: <7vtyzexnhm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128063>

On Mon, Sep 07, 2009 at 05:56:53PM -0700, Junio C Hamano wrote:

> * jk/1.7.0-status (2009-09-05) 5 commits
>  - docs: note that status configuration affects only long format
>   (merged to 'next' on 2009-09-07 at 8a7c563)
>  + commit: support alternate status formats
>  + status: add --porcelain output format
>  + status: refactor format option parsing
>  + status: refactor short-mode printing to its own function
>  (this branch uses jc/1.7.0-status.)
> 
> Gives the --short output format to post 1.7.0 "git commit --dry-run" that
> is similar to that of post 1.7.0 "git status".
> 
> It might be a good idea to make the --short format part of 1.6.6 without
> waiting for 1.7.0; it would require some branch shuffling to bring the
> short-status patch earlier than the one that makes "status" different from
> "commit --dry-run", though.

It looks like the short-status patch is already right before "commit
--dry-run", but it is of course part of "git stat". So we could get by
with branching from jc/1.7.0-status^, and do one of:

 1. develop as if we were a totally separate topic, refactoring, adding
    --porcelain mode, etc.

 2. just support "--short" from "git status" with as small a change as
    possible, and let the rest of the enhancements stay where they are,
    for 1.7.0

Option (1) is what I would usually do, but I think in this case it is
just going to end up with me re-doing lots of work as the
almost-duplicated refactoring happening in the two branches is going to
make a gigantic conflict.

And of course option (3) is to just let --short rest until 1.7.0.

-Peff
