From: Jeff King <peff@peff.net>
Subject: Re: How do I run tests under Valgrind?
Date: Mon, 17 Sep 2012 13:35:31 -0400
Message-ID: <20120917173531.GB1179@sigill.intra.peff.net>
References: <CALkWK0m_9OsAfG_pF3hUDW+EKCyZCn9NiDKKEW6AEOMmAw=yuA@mail.gmail.com>
 <20120917172022.GA1179@sigill.intra.peff.net>
 <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 19:35:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDfEV-0003Ao-Ve
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 19:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135Ab2IQRff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 13:35:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46649 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755801Ab2IQRfe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 13:35:34 -0400
Received: (qmail 9299 invoked by uid 107); 17 Sep 2012 17:35:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Sep 2012 13:35:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2012 13:35:31 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0m378ApSwa1xiYUqEjMny5m0wt3KacqdDRU1qt=cw6k8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205719>

On Mon, Sep 17, 2012 at 10:53:18PM +0530, Ramkumar Ramachandra wrote:

> Hi Peff,
> 
> Jeff King wrote:
> > No, that should work (and it does work here). I assume you can pass
> > t0000 without --valgrind?
> 
> Yes.  Here's the output from running it with --valgrind.  I'm digging
> deeper to see what went wrong.
> 
> make_valgrind_symlink:6: permission denied:
> /home/artagnon/src/git/t/../git-instaweb
> ./test-lib.sh:487: no matches found:
> /home/artagnon/svn/prefix/svn-trunk/bin:/home/artagnon/bin:/home/artagnon/bin/depot_tools:/home/artagnon/.ruby/bin:/home/artagnon/.python/bin:/home/artagnon/.cabal/bin:/home/artagnon/svn/prefix/svn-trunk/bin:/home/artagnon/bin:/home/artagnon/bin/depot_tools:/home/artagnon/.ruby/bin:/home/artagnon/.python/bin:/home/artagnon/.cabal/bin:/home/artagnon/bin:/usr/local/bin:/usr/bin:/bin:/usr/games:/home/artagnon/.ec2/bin:/home/artagnon/.ec2/bin/git-*

That's certainly odd. It sounds like the valgrind setup is broken for
you. Can you run:

  sh -x t0000-basic.sh --valgrind

and see what's happening near those weird errors?

> test_cmp:1: command not found: diff -u

Lack of diff is going to be a problem. What OS is this? Do you really
not have diff? Or is there something funny going on with your PATH?

-Peff
