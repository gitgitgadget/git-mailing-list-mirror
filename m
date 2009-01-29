From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 06:48:34 -0500
Message-ID: <20090129114834.GA10792@coredump.intra.peff.net>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org> <20090129035138.GC11836@coredump.intra.peff.net> <bd6139dc0901290327u572cc30ci9dc719c912fbf875@mail.gmail.com> <20090129113735.GA6505@coredump.intra.peff.net> <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Jan 29 12:50:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSVPI-0006Pu-MN
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 12:50:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbZA2Lsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 06:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753838AbZA2Lsh
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 06:48:37 -0500
Received: from peff.net ([208.65.91.99]:38758 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbZA2Lsh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 06:48:37 -0500
Received: (qmail 7462 invoked by uid 107); 29 Jan 2009 11:48:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 06:48:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 06:48:34 -0500
Content-Disposition: inline
In-Reply-To: <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107661>

On Thu, Jan 29, 2009 at 11:40:42AM +0000, Pieter de Bie wrote:

> This is true in all cases. If you create a new branch in any
> repository, push that, and later do a 'git pull', you get that
> message. I agree it's not the nicest way to handle things, but this is
> not an issue with the  clone, it's an issue of pushing new branches in
> general.

Right. I guess I was hoping by cloning an existing repository, even one
with no commits on the branch, that we could somehow remember that we
are "on" the master branch. I think that is what people who ask for
empty cloning really want:

  1. make a bare upstream

  2. clone empty repo

  3. create commits

  4. git push / git pull, as if we had cloned non-empty repo

And I know that it is not very "git" to talk about empty branches, since
branches are pointers into the DAG. But we already do similar trickery
with "yet to be born" branches by putting a dangling symref into HEAD.
But I don't think there's any way currently to send those dangling
symrefs across the git protocol, which is what would be required to do
the above accurately.

-Peff
