From: Jeff King <peff@peff.net>
Subject: Re: git-config: aliases with parameter expansion ($1 and such)
Date: Sun, 23 Mar 2008 15:38:42 -0400
Message-ID: <20080323193842.GA23227@coredump.intra.peff.net>
References: <47E65AF5.4060708@dirk.my1.cc> <76718490803230645k13471472sc99932563b0239da@mail.gmail.com> <47E66382.5030800@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:39:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdW2T-0004fw-HX
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 20:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755130AbYCWTir convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Mar 2008 15:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755082AbYCWTir
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 15:38:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3014 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754475AbYCWTiq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 15:38:46 -0400
Received: (qmail 9277 invoked by uid 111); 23 Mar 2008 19:38:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 23 Mar 2008 15:38:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Mar 2008 15:38:42 -0400
Content-Disposition: inline
In-Reply-To: <47E66382.5030800@dirk.my1.cc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77950>

On Sun, Mar 23, 2008 at 03:04:50PM +0100, Dirk S=C3=BCsserott wrote:

>> atag =3D !git tag -a -m "$1"
> Thanks for the quick reply. Did you try that out? I did
>
> $ git atag foo
>
> with your definition and got a tag with message "$1" and
> the tag's name was "'foo'" (surrounded by single quotes).

If you want to use positional parameters, you have to invoke the shell
explicitly. Try:

  [alias]
    atag =3D !sh -c 'git tag -a -m "$0" "$0"'

As an aside, this should be "$1" but it looks like we don't pass the
shell a proper argv[0].

-Peff
