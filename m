From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: [PATCH] Make git compile with SUNs forte12 compiler
Date: Sun, 13 May 2007 12:30:38 +0200
Message-ID: <20070513103038.GC18546@cip.informatik.uni-erlangen.de>
References: <11790057101792-git-send-email-sithglan@stud.uni-erlangen.de> <pan.2007.05.13.09.47.32@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Matthieu CASTET <castet.matthieu@free.fr>
X-From: git-owner@vger.kernel.org Sun May 13 12:30:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnBLi-00062o-Ij
	for gcvg-git@gmane.org; Sun, 13 May 2007 12:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757132AbXEMKak (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 06:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757237AbXEMKak
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 06:30:40 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:45516 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757132AbXEMKaj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 May 2007 06:30:39 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 413043F319; Sun, 13 May 2007 12:30:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <pan.2007.05.13.09.47.32@free.fr>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47135>

Hello,

[ Junio please drop the patch, if you thought about putting it upstream ]

> Did you understand what you did ?

I do. But my objective wasn't get that function inline but get git to compile
under forte12. However. After you pushed me in the right direction I read the
compiler documentation and found a compiler option called "-features=no%extinl"
which makes it possible to compile git as is using forte12.

So if anyone tries to build git for Solaris using forte12 try this
commandline:

export PATH="/opt/forte12/x86/SUNWspro/bin:/usr/ccs/bin:/usr/bin:/usr/openwin/bin"

/opt/csw/bin/gmake \
        CFLAGS='-O -features=no%extinl' \
        CC=/opt/forte12/x86/SUNWspro/bin/cc \
        DESTDIR=/var/tmp/sithglan-pkg/git-1.5.1.4-buildroot \
        ETC_GITCONFIG=/etc/gitconfig \
        INSTALL=/opt/csw/bin/ginstall \
        NO_CURL=1 \
        NO_EXPAT=1 \
        NO_ICONV=1 \
        NO_OPENSSL=1 \
        TAR=/opt/csw/bin/gtar \
        mandir=/usr/share/man \
        prefix=/usr \
        install

Thanks,
        Thomas
