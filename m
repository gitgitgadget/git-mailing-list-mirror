From: Jeff King <peff@peff.net>
Subject: Re: git for local web development
Date: Fri, 17 Apr 2009 07:59:25 -0400
Message-ID: <20090417115925.GB29121@coredump.intra.peff.net>
References: <135754252540163221910297561025355826788-Webmail@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: William DiNoia <william.dinoia@mac.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 14:01:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lumki-0005eA-Ju
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 14:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757772AbZDQL7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 07:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbZDQL7d
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 07:59:33 -0400
Received: from peff.net ([208.65.91.99]:36600 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739AbZDQL7c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 07:59:32 -0400
Received: (qmail 15951 invoked by uid 107); 17 Apr 2009 11:59:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 17 Apr 2009 07:59:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2009 07:59:25 -0400
Content-Disposition: inline
In-Reply-To: <135754252540163221910297561025355826788-Webmail@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116733>

On Thu, Apr 16, 2009 at 07:04:10PM -0400, William DiNoia wrote:

> I would like to be able to git-push and have the work tree updated.
>
> [...]
>
> $vim .git/hooks/post-receive
>  #!/bin/sh
>  git-checkout -f
> $chmod +x .git/hooks/post-receive
>
> [...]
>
> Counting objects: 5, done.
> Compressing objects: 100% (2/2), done.
> Writing objects: 100% (3/3), 277 bytes, done.
> Total 3 (delta 1), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> To /var/www/sites/test.com/.git
>    9b490a2..5e5cc63  master -> master
> error: unable to unlink old 'index.html' (Permission denied)
> error: hooks/post-receive exited with error code 1

Well, your post-receive hook is running, and checkout is barfing with a
permission denied error. Probably the repo directory is owned by
www-data, and you are pushing as user "william"? What are the directory
permissions like?

-Peff
