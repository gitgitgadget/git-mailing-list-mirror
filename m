From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: possible bug in using local branches
Date: Tue, 9 Oct 2007 12:56:20 +0200
Message-ID: <20071009105620.GD31659@planck.djpig.de>
References: <1191924707.10822.94.camel@nc.nor.wtbts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Natanael Copa <natanael.copa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 12:56:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfClV-0007cc-4c
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 12:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbXJIK4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 06:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752216AbXJIK4c
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 06:56:32 -0400
Received: from planck.djpig.de ([85.10.192.180]:3430 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbXJIK4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 06:56:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 4E9AD88231;
	Tue,  9 Oct 2007 12:56:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fjJkMopC9non; Tue,  9 Oct 2007 12:56:20 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 69CF988232; Tue,  9 Oct 2007 12:56:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1191924707.10822.94.camel@nc.nor.wtbts.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60385>

On Tue, Oct 09, 2007 at 12:11:47PM +0200, Natanael Copa wrote:
> 
> http://distfiles.gentoo.org/distfiles/linux-2.6.22.tar.bz2
> http://distfiles.gentoo.org/distfiles/genpatches-2.6.22-9.base.tar.bz2
> http://people.linux-vserver.org/~harry/patch-2.6.22.6-vs2.2.0.3-grsec2.1.11-20070905.diff
> 
> First unpack the linux-2.6.22.tar.bz2 archive, genpatches archive and
> add linux kernel to a local repository.
> 
> $ tar -jxf linux-2.6.22.tar.bz2
> $ tar -jxf genpatches-2.6.22-9.base.tar.bz2
> $ cd linux-2.6.22
> $ git-init
> Initialized empty Git repository in .git/
> $ git-add .
> $ git commit -m 'vanilla 2.6.22'
> ...
>  create mode 100644 usr/Makefile
>  create mode 100644 usr/gen_init_cpio.c
>  create mode 100644 usr/initramfs_data.S

It already goes wrong here. The top-level .gitignore contains a
vmlinux*, so the file you later test is never actually committed...

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
