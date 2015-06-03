From: Jeff King <peff@peff.net>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 3 Jun 2015 05:06:55 -0400
Message-ID: <20150603090654.GD32000@peff.net>
References: <loom.20150603T104534-909@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 11:07:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z04db-0003mY-Ln
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 11:07:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753992AbbFCJG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 05:06:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:40301 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754176AbbFCJG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 05:06:57 -0400
Received: (qmail 16013 invoked by uid 102); 3 Jun 2015 09:06:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 04:06:57 -0500
Received: (qmail 17927 invoked by uid 107); 3 Jun 2015 09:06:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 05:06:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 05:06:55 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150603T104534-909@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270670>

On Wed, Jun 03, 2015 at 08:50:44AM +0000, Ed Avis wrote:

> Currently a plain 'git checkout .' will revert any local changes, e.g.
> 
>     % mkdir test
>     % cd test
>     % git init
>     Initialized empty Git repository in /home/eda/test/.git/
>     % echo hello >foo
>     % git add foo
>     % git commit -m.
>     [master (root-commit) 34f6694] .
>      1 file changed, 1 insertion(+)
>      create mode 100644 foo
>     % echo goodbye >foo
>     % git checkout .
>     % cat foo
>     hello
> 
> I suggest this is dangerous and by default 'git checkout' should only alter
> files which do not have local changes (as would be reported by 'git diff').
> Only if --force is given should working tree differences be thrown away.
> 
>     % git --version
>     git version 2.4.0

That's what "git checkout <path>" is designed for. I'm not clear on what
you expect "git checkout ." to do in this example, if not overwrite
"foo". Can you elaborate?

-Peff
