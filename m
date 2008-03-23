From: Jeff King <peff@peff.net>
Subject: Re: git-config: aliases with parameter expansion ($1 and such)
Date: Sun, 23 Mar 2008 15:45:15 -0400
Message-ID: <20080323194514.GA23492@coredump.intra.peff.net>
References: <47E65AF5.4060708@dirk.my1.cc> <76718490803230645k13471472sc99932563b0239da@mail.gmail.com> <47E66382.5030800@dirk.my1.cc> <20080323193842.GA23227@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdW8l-0006T2-FD
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 20:45:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755870AbYCWTpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 15:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755834AbYCWTpS
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 15:45:18 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4589 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750789AbYCWTpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 15:45:17 -0400
Received: (qmail 9752 invoked by uid 111); 23 Mar 2008 19:45:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 23 Mar 2008 15:45:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Mar 2008 15:45:15 -0400
Content-Disposition: inline
In-Reply-To: <20080323193842.GA23227@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77953>

On Sun, Mar 23, 2008 at 03:38:42PM -0400, Jeff King wrote:

>     atag = !sh -c 'git tag -a -m "$0" "$0"'
> 
> As an aside, this should be "$1" but it looks like we don't pass the
> shell a proper argv[0].

Hmm, I take it back. Git is doing the right thing, but it is a quirk of
the shell that it counts the first argument as the "name of the script"
even though the script actually comes from "-c".

  $ sh -c 'echo $0' foo
  foo
  $ echo 'echo $0' | sh
  sh

-Peff
