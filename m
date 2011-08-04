From: Jeff King <peff@peff.net>
Subject: Re: git-fast-export is returning streams with source code inside
Date: Thu, 4 Aug 2011 12:32:18 -0600
Message-ID: <20110804183218.GA15943@sigill.intra.peff.net>
References: <CAFC9htxwRg=+RD68hnnRy0hfptq23x3bL+xxHieK1evfFCTPjw@mail.gmail.com>
 <20110804070528.GA11805@sigill.intra.peff.net>
 <CAFC9htxRD0z3O_k_OLp08KZFUOL_T3AryCXD+OqqXx9ZYeRutg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James Gregory <j.gregory@epigenesys.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 04 20:32:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp2ie-00054U-BP
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 20:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149Ab1HDScY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 14:32:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33093
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640Ab1HDScX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 14:32:23 -0400
Received: (qmail 21693 invoked by uid 107); 4 Aug 2011 18:32:57 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Aug 2011 14:32:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2011 12:32:18 -0600
Content-Disposition: inline
In-Reply-To: <CAFC9htxRD0z3O_k_OLp08KZFUOL_T3AryCXD+OqqXx9ZYeRutg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178760>

On Thu, Aug 04, 2011 at 10:08:43AM +0100, James Gregory wrote:

> Thanks for your reply. I'm afraid I won't be able to allow you access
> to repo as it is for a business project and covered by NDAs, etc. If I
> can do anything to help with diagnosing the problem (debug logs, more
> excerpts from the stream, etc.) then that shouldn't be a problem.

Since it seems like blob data is making it into the stream in an odd
place, my first guess would be a memory problem. Can you try installing
valgrind (since you are on Ubuntu, there should be a package), and then
running:

  valgrind git fast-export --all >/dev/null 2>valgrind.out

and then sharing the results of valgrind.out?

-Peff
