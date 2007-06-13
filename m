From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Teach Makefile to respect external variables: CFLAGS and others.
Date: Wed, 13 Jun 2007 08:12:34 +0200
Message-ID: <20070613061234.GA20648@uranus.ravnborg.org>
References: <20070613054229.GM86872@void.codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Jun 13 08:11:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyM5A-0004i4-Ln
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 08:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbXFMGLc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 02:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753064AbXFMGLc
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 02:11:32 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:45132 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755342AbXFMGLb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 02:11:31 -0400
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpB.tele.dk (Postfix) with ESMTP id 70238E301B5;
	Wed, 13 Jun 2007 08:11:30 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 1000)
	id 131A3580D2; Wed, 13 Jun 2007 08:12:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070613054229.GM86872@void.codelabs.ru>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50021>

On Wed, Jun 13, 2007 at 09:42:30AM +0400, Eygene Ryabinkin wrote:
> If one is not using the configure script, then there is no way to
> redefine variables CFLAGS, LFLAGS, CC, AR, TAR, INSTALL, RPMBUILD,
> TCL_PATCH and TCLTK_PATH.  This shouldn't be so, since these variables
> can be manually set by user and we should respect them.

make distingush between environment variables and make variables.
So for make there is a big difference between:

export FOO=foobar
make

and
make FOO=foobar

The latter will work as expected without your changes.
And the good part about this is that some random environment variables
does not influence the build.

	Sam
