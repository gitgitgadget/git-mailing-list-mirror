From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [patch 06/16] diff-test_cmp.patch
Date: Wed, 28 Apr 2010 10:22:50 +0000
Message-ID: <20100428102250.GB39644@thor.il.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
 <20100427135833.403548000@mlists.thewrittenword.com>
 <20100427171531.GA15553@progeny.tock>
 <20100428090045.GD36271@thor.il.thewrittenword.com>
 <20100428095159.GD1394@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 12:22:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O74Px-0006nu-Lj
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 12:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047Ab0D1KWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 06:22:51 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:57533 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981Ab0D1KWv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 06:22:51 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 772FB5CDA;
	Wed, 28 Apr 2010 10:44:00 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 772FB5CDA
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 8D5ABAC3;
	Wed, 28 Apr 2010 10:22:50 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id 7E314BAB5; Wed, 28 Apr 2010 10:22:50 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100428095159.GD1394@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145986>

On Wed, Apr 28, 2010 at 04:51:59AM -0500, Jonathan Nieder wrote:
> I think one sign-off for the whole series would be good enough; then
> the person applying the patches can forge your signed-off-by lines.

Okay, done Thanks.

> Gary V. Vaughan wrote:
> > (Like SuSE Linux, we use quilt to manage and
> > submit our patch stacks... git seems to require hosting the entire
> > history of each project which is too heavyweight for the 1000's of
> > packages we build - if git provides the means to store just the head
> > of an upstream release branch along with our patch stacks on local
> > disk, I would love to be proven wrong here).
> 
> The most general way:
> 
>  curl http://address/of/tarball.tar.gz | tar -xf - 
>  git init *
>  cd *
>  git add .
>  git commit -m "upstream release"
>  ... use git like normal

D'oh.  Of course... I was too fixated on git clone to notice.

> You can automate some of those steps by
> 
>  wget http://address/of/tarball.tar.gz
>  git init project
>  cd project
>  perl /usr/share/doc/git/contrib/fast-import/import-tars.perl tarball.tar.gz
>  git checkout import-tars
>  ... use git as usual

What's happening here?  Is this sharing a single repository for all
locally hosted git projects, or is this more or less the same as the
above?

> If upstream uses git, there is also the shallow-clone facility:
> 
>  git clone -b master --depth=1 git://repo.or.cz/git.git/
>  cd git
>  ... use git as usual, except history is cauterized

This is probably the flavour that would be of the most use to us.
Thanks for educating me :)

> It has one rough edge you may run into: push is not supported.  If that
> is a problem for you, let me know and maybe I can try to help fix it.

No, I think the main benefit of using git locally would be to provide
a pull source for upstream.

> Honestly, I???m okay with quilt, too.  The main difference I notice is that
> ???git diff??? uses the equivalent of the diff -p (--show-c-function)
> option by default.

In /etc/quilt.quiltrc we have:

# Options passed to GNU diff when generating patches
QUILT_DIFF_OPTS="--show-c-function"

And I've been careful to regenerate a/b patches for submission to this
list, so the only difference then is that you can't pull the patches
from me when I use quilt.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
