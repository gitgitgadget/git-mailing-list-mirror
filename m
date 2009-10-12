From: Jeff King <peff@peff.net>
Subject: Re: Git: "No you can't handle my root!" (?)
Date: Mon, 12 Oct 2009 14:35:19 -0400
Message-ID: <20091012183519.GA10686@coredump.intra.peff.net>
References: <20091012012826.7sffggwmm8sk0cc8@webmail.demarque.qc.ca>
 <20091012135910.ujqifycf9cwsk4ss@webmail.demarque.qc.ca>
 <f488382f0910121106h64571b93jb92372a1d7720b10@mail.gmail.com>
 <81b0412b0910121115s26c6c08s1ea54c28851faf05@mail.gmail.com>
 <20091012142017.vrs4v2cc8wgws8g4@webmail.demarque.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Steven Noonan <steven@uplinklabs.net>, git@vger.kernel.org
To: sylvain@demarque.qc.ca
X-From: git-owner@vger.kernel.org Mon Oct 12 20:37:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxPlJ-00010D-Tp
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 20:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757707AbZJLSf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 14:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757596AbZJLSf4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 14:35:56 -0400
Received: from peff.net ([208.65.91.99]:33698 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757598AbZJLSf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 14:35:56 -0400
Received: (qmail 6101 invoked by uid 107); 12 Oct 2009 18:38:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 12 Oct 2009 14:38:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Oct 2009 14:35:19 -0400
Content-Disposition: inline
In-Reply-To: <20091012142017.vrs4v2cc8wgws8g4@webmail.demarque.qc.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130049>

On Mon, Oct 12, 2009 at 02:20:17PM -0400, sylvain@demarque.qc.ca wrote:

> >It's more of "a note to the future generation of developers": "Hey guys,
> >we didn't need that working, but if you have a night to spare could you
> >please finish that?"
> 
> Ok, then I won't wait for it to work. I will dive in Git's code and
> play the "future generation of developers" part... some day. ;-)
> 
> Thank you! :-)

I think that it sort of works, actually. It seems to do OK if you do
something like:

  $ GIT_DIR=/path/to/store/repo; export GIT_DIR
  $ GIT_WORK_TREE=/; export GIT_WORK_TREE
  $ git init
  $ cd /etc/whatever
  $ git add .

But it does not work if you try to make things work automatically:

  $ cd /
  $ git init
  $ cd /etc/whatever
  $ git add .

So probably the bug is in detecting the location of the work tree when
it is not explicitly given. You can use the explicit style as a
workaround for now.

-Peff
