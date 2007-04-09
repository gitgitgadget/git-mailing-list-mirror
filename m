From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] git-archive: document CWD effect
Date: Mon, 09 Apr 2007 17:04:27 +0200
Message-ID: <461A55FB.6070600@lsrfire.ath.cx>
References: <esc64d$d2u$1@sea.gmane.org> <4618DFEE.8080707@lsrfire.ath.cx> <7virc68nc1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nick Williams <njw@jarb.freeserve.co.uk>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 09 18:54:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HavQM-0006DM-VC
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 17:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965336AbXDIPEq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 9 Apr 2007 11:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965309AbXDIPEq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 11:04:46 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:48043
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965109AbXDIPEn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Apr 2007 11:04:43 -0400
Received: from [10.0.1.201] (p508e4c97.dip.t-dialin.net [80.142.76.151])
	by neapel230.server4you.de (Postfix) with ESMTP id 7BB7222006;
	Mon,  9 Apr 2007 17:04:42 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.10 (Windows/20070221)
In-Reply-To: <7virc68nc1.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44057>

Junio C Hamano schrieb:
> While the updated description reflects what the command does
> more accurately, I am not sure if it is a desired behaviour.
> For one thing, --format=3Dtar (by the way, maybe we would want to
> make this the default when none is specified?) adds the comment
> that is readable by get-tar-commit-id that claims the tarball
> contains the named commit, giving a false impression that it is
> the whole thing.

It marks the archive as being _created_ from this specific commit, not
necessarily as containing all of it.  Perhaps this should be noted in
the documentation..

Making '--format=3Dtar' the default is a good idea.  I doubt we'll see =
the
addition of a new archive format -- that deserves to be the default one
instead of tar -- soon.

> Since people who _really_ want a subtree can
> just say "git archive --format=3Dtar HEAD:Documentation", I
> suspect we may be better off not doing "current directory only"
> by default.  This changes the behaviour, but (1) it affects only
> people who run from a subdirectory, (2) it is counterintuitive
> that your location in the working tree matters when you say "I
> want a tarball of that commit", and (3) it is an undocumented
> behaviour anyway.

I agree with (1) and (3), meaning that we are free to change the
behaviour.  I don't agree with (2), though.  I'd find it strange if
changing the working directory wouldn't change the archive contents.

We should keep consistency with the rest of git here.  Since git-archiv=
e
is just a fancy git-ls-tree, I think we should mirror its behaviour wit=
h
respect to the working directory.  (Which is what the current code does=
=2E
 Modulo bugs, of course.)

Ren=C3=A9
