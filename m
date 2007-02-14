From: Bill Lear <rael@zopyra.com>
Subject: Re: Error converting from 1.4.4.1 to 1.5.0?
Date: Wed, 14 Feb 2007 15:18:42 -0600
Message-ID: <17875.31922.333264.948817@lisa.zopyra.com>
References: <17875.13564.622087.63653@lisa.zopyra.com>
	<7vhctor78j.fsf@assigned-by-dhcp.cox.net>
	<17875.17647.74882.218627@lisa.zopyra.com>
	<7vy7n0pr9x.fsf@assigned-by-dhcp.cox.net>
	<17875.30187.289679.417079@lisa.zopyra.com>
	<7vmz3gmojt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:18:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRWc-0008Kw-4p
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbXBNVSr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbXBNVSr
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:18:47 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60378 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932622AbXBNVSq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:18:46 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l1ELIjI20381;
	Wed, 14 Feb 2007 15:18:45 -0600
In-Reply-To: <7vmz3gmojt.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39750>

On Wednesday, February 14, 2007 at 13:12:22 (-0800) Junio C Hamano writes:
>Bill Lear <rael@zopyra.com> writes:
>...
>"ldd ~/git-master/bin/git" tells me that it links with libcrypto.so,
>so I am using OpenSSL's SHA-1 implementation.  I do not know
>what your distro uses (or you hand built git yourself?).

Should have known --- I hand-built it myself, and thought perhaps
it was a configure option (output truncated):

% ldd /opt/git-1.5.0/bin/git
        libcrypto.so.4 => /lib64/libcrypto.so.4 (0x0000003de1300000)
% ldd /usr/bin/git
        libcrypto.so.4 => /lib64/libcrypto.so.4 (0x0000003de1300000)

So, both 1.5 and 1.4.4.1 are using OpenSSL, I reckon.

>So it looks more and more like a bit decay as Linus suspected...

Strange: given that fsck works on my public repo, with both 1.4.4.1
and with 1.5.0, and I reproduced this easily and fsck barfs on
both of my failed repos.  I can't imagine this is really a disk
error of any kind.


Bill
