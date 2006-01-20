From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] fsck-objects: support platforms without d_ino in struct dirent.
Date: Thu, 19 Jan 2006 22:38:03 -0500
Message-ID: <20060120033803.GF5090@trixie.casa.cgf.cx>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com> <20060119052914.GC8121@trixie.casa.cgf.cx> <7vlkxciodu.fsf@assigned-by-dhcp.cox.net> <7vu0bz7lbk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 20 04:38:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezn6G-0004gp-Hs
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 04:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161478AbWATDiF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 22:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161481AbWATDiF
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 22:38:05 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:17853 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1161478AbWATDiE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 22:38:04 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id DEC0B4A85B3; Thu, 19 Jan 2006 22:38:03 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vu0bz7lbk.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14952>

On Thu, Jan 19, 2006 at 05:13:51PM -0800, Junio C Hamano wrote:
>The d_ino field is only used for performance reasons in
>fsck-objects.  On a typical filesystem, i-number tends to have a
>strong correlation with where the actual bits sit on the disk
>platter, and we sort the entries to allow us scan things that
>ought to be close together together.
>
>If the platform lacks support for it, it is not a big deal.
>Just do not use d_ino for sorting, and scan them unsorted.

Ah, interesting.  I don't know if the file id objects would have
that sort of correlation on NT but obviously the file hashes don't.

cgf
