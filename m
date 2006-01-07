From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Use testlib to skip t3300-funny-names
Date: Sat, 7 Jan 2006 10:25:38 +0100
Message-ID: <20060107092538.GA5536@steel.home>
References: <81b0412b0601050353o6b96ed4fp2a6d24dd514cc9c2@mail.gmail.com> <7vvewxq8xg.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 10:26:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvAKk-00052A-1I
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 10:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbWAGJZz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 04:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932708AbWAGJZz
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 04:25:55 -0500
Received: from devrace.com ([198.63.210.113]:12041 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932707AbWAGJZz (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 04:25:55 -0500
Received: from tigra.home (p54A073FD.dip.t-dialin.net [84.160.115.253])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k079PknO044788;
	Sat, 7 Jan 2006 03:25:46 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EvAKR-0008Cl-00; Sat, 07 Jan 2006 10:25:39 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EvAKQ-0001RR-Li; Sat, 07 Jan 2006 10:25:38 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvewxq8xg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14248>

Junio C Hamano, Fri, Jan 06, 2006 23:38:03 +0100:
> > The test cannot be run on cygwin anyway.
> > Corrected the error message to reflect the problem source.
> 
> I'd rather see the test actually try to create a funny-named
> testfile and see if it managed to create it, so that it can be
> skipped on non DOS systems that mounted DOS filesystem.
> 
> So instead I would do something like this:
> 
> +test -f "$p1" && cmp "$p0" "$p1" || {
> +	# since FAT/NTFS does not allow tabs in filenames, skip this test
> +	say 'Your filesystem does not allow tabs in filenames, test skipped.'
> +	test_done
> +}

Yes, that's better
