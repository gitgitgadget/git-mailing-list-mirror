From: Erik van Konijnenburg <ekonijn@xs4all.nl>
Subject: Re: fix mktemp (remove mktemp ;)
Date: Sun, 17 Apr 2005 02:51:08 +0200
Message-ID: <20050417025108.G2442@banaan.localdomain>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com> <20050416233724.GP19099@pasky.ji.cz> <20050416170221.38b3e66c.pj@sgi.com> <20050417003325.GA15608@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Jackson <pj@sgi.com>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org, mj@ucw.cz
X-From: git-owner@vger.kernel.org Sun Apr 17 02:47:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMxwo-0000lT-Rw
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 02:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVDQAvU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 20:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVDQAvU
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 20:51:20 -0400
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:18193 "EHLO
	smtp-vbr2.xs4all.nl") by vger.kernel.org with ESMTP id S261225AbVDQAvQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 20:51:16 -0400
Received: from banaan.xs4all.nl (banaan.xs4all.nl [80.126.2.237])
	by smtp-vbr2.xs4all.nl (8.12.11/8.12.11) with ESMTP id j3H0p8cj048201;
	Sun, 17 Apr 2005 02:51:08 +0200 (CEST)
	(envelope-from konijn@banaan.xs4all.nl)
Received: (from konijn@localhost)
	by banaan.xs4all.nl (8.11.6/8.11.6) id j3H0p8306142;
	Sun, 17 Apr 2005 02:51:08 +0200
To: Dave Jones <davej@redhat.com>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050417003325.GA15608@redhat.com>; from davej@redhat.com on Sat, Apr 16, 2005 at 08:33:25PM -0400
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 16, 2005 at 08:33:25PM -0400, Dave Jones wrote:
> On Sat, Apr 16, 2005 at 05:02:21PM -0700, Paul Jackson wrote:
>  > > And racy. And not guaranteed to come up with fresh new files.
>  > 
>  > In theory perhaps.  In practice no.
>  > 
>  > Even mktemp(1) can collide, in theory, since there is no practical way
>  > in shell scripts to hold open and locked the file from the instant of it
>  > is determined to be a unique name.
> 
> Using the pid as a 'random' number is a bad idea. all an attacker
> has to do is create 65535 symlinks in /usr/tmp, and he can now
> overwrite any file you own.
> 
> mktemp is being used here to provide randomness in the filename,
> not just a uniqueness.

How about putting using .git/tmp.$$ or similar as tempfile?

This should satisfy both the portability and security requirements,
since the warnings against using $$ only apply to public directories.

Regards,
Erik
