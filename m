From: Jeff King <peff@peff.net>
Subject: Re: Git issues with submodules
Date: Fri, 22 Nov 2013 10:11:20 -0500
Message-ID: <20131122151120.GA32361@sigill.intra.peff.net>
References: <CAErtv26Q_YN+U+trjNac1aKLi9BvNHNNuaUkrr2RE0nB+yxWsw@mail.gmail.com>
 <CALkWK0n7jdLKOAFoFjuRz0aTCssorAgk2y=Vce76Y5aHWbj53Q@mail.gmail.com>
 <CAErtv27dMepNSbBVdOokn6OF858ENaKooL+FzD7JHtp9nRPufw@mail.gmail.com>
 <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergey Sharybin <sergey.vfx@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 16:11:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjsOE-0002fp-Gl
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 16:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755816Ab3KVPLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 10:11:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:43815 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755647Ab3KVPLW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 10:11:22 -0500
Received: (qmail 26441 invoked by uid 102); 22 Nov 2013 15:11:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Nov 2013 09:11:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Nov 2013 10:11:20 -0500
Content-Disposition: inline
In-Reply-To: <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238190>

On Fri, Nov 22, 2013 at 06:38:47PM +0530, Ramkumar Ramachandra wrote:

> >> Does Arcanist use `git ls-files -m` to check?
> >
> > Yes, Arcanist uses `git ls-files -m` to check whether there're local
> > modifications. We might also contact phab developers asking to change
> > it to `git diff --name-only HEAD --`.  Is there a preferable way to
> > get list of modified files and are this command intended to output the
> > same results?
> 
> I just checked it out: it uses `git ls-files -m` to get the list of
> unstaged changes; `git diff --name-only HEAD --` will list staged
> changes as well.

That diff command compares the working tree and HEAD; if you are trying
to match `ls-files -m`, you probably wanted just `git diff --name-only`
to compare the working tree and the index. Although in a script you'd
probably want to use the plumbing `git diff-files` instead.

-Peff
