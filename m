From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: "git clone" executed as root on solaris 10 shreds UFS (it is
	possible to create hardlinks for directories as root under solaris)
Date: Mon, 16 Jul 2007 12:43:42 +0200
Message-ID: <20070716104342.GB24036@cip.informatik.uni-erlangen.de>
References: <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <gitster@pobox.com>
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 16 12:43:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAO3S-0000y7-Qc
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 12:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755783AbXGPKno (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 06:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756113AbXGPKno
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 06:43:44 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:43672 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755622AbXGPKnn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jul 2007 06:43:43 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 499933F42E; Mon, 16 Jul 2007 12:43:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070716100803.GA24036@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52658>

Hello,
I narrowed it down. It is in "git checkout" if I copy the ".git" dir via
"cp -a" and type in "git checkout" it breaks. And it _only_ breaks for
subdirectories:

        (faui04a) [/var/tmp/shit] git checkout
        D       profiles/icpc
        D       profiles/sithglan
        D       sources/boot.msg
        D       sources/busybox-config
        D       sources/config
        D       sources/easix.logo.16
        D       sources/easixdm
        D       sources/f2
        D       sources/home-faumachine.tar.gz
        D       sources/home-icpc.tar.gz
        D       sources/home-simigern.tar.gz
        D       sources/home-sithglan.tar.gz
        D       sources/home-sitowert.tar.gz
        D       sources/linuxrc
        D       sources/rc.local

and I also see that _one_ file in each subdirectory is checked out but the
others are not.

        Thomas
