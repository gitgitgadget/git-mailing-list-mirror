From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Efficient way to import snapshots?
Date: Tue, 31 Jul 2007 08:50:19 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707310845490.4161@woody.linux-foundation.org>
References: <20070730180710.GA64467@nowhere>
 <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org>
 <20070730192922.GB64467@nowhere> <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org>
 <20070730222028.GE64467@nowhere> <alpine.LFD.0.999.0707301629230.4161@woody.linux-foundation.org>
 <20070731011707.GA91930@nowhere> <alpine.LFD.0.999.0707301825130.4161@woody.linux-foundation.org>
 <20070731042347.GG25876@thunk.org> <20070731135332.GA58867@nowhere>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Craig Boston <craig@olyun.gank.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 17:50:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFtzd-0002ho-O1
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 17:50:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759954AbXGaPug (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 11:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759018AbXGaPuf
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 11:50:35 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45411 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756625AbXGaPue (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 11:50:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6VFoQHN020600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 Jul 2007 08:50:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6VFoJ4Q009379;
	Tue, 31 Jul 2007 08:50:21 -0700
In-Reply-To: <20070731135332.GA58867@nowhere>
X-Spam-Status: No, hits=-2.688 required=5 tests=AWL,BAYES_00,TW_ZF
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.16__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54361>



On Tue, 31 Jul 2007, Craig Boston wrote:
> 
> I just so happen to be rebuilding the zfs pool on that server this
> morning in order to add more swap, so your wish(1tcl) is my rcmd(3).

You, sir, are a total geek.

I'm not sure if that's a compliment or a curse.

> Same machine, on a UFS filesystem (single disk, since zfs was doing the
> RAID), with the cache tuning parameters reset back to defaults:
> 
> First 'git status' after a reboot:
> git status  2.23s user 2.23s system 17% cpu 24.987 total
> 
> Second:
> git status  1.81s user 1.34s system 98% cpu 3.188 total
> 
> Third:
> git status  1.76s user 1.45s system 98% cpu 3.252 total
> 
> So I definitely think the problem is just that with its increased
> overhead, ZFS simply can't keep all the metadata in the cache with the
> available memory.

Very interesting. And thanks. The whole "ZFS is great" internet meme seems 
to be partly due to not a lot of people having used or compared it in real 
life. I'm sure it's wonderful for some things, but it clearly does have a 
lot of downsides too. 

			Linus
