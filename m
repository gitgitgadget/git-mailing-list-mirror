From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Wed, 22 Jun 2005 21:47:36 -0400
Message-ID: <42BA14B8.2020609@pobox.com>
References: <42B9E536.60704@pobox.com> <20050622230905.GA7873@kroah.com> <Pine.LNX.4.58.0506221623210.11175@ppc970.osdl.org> <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261841AbVFWBuX@vger.kernel.org Thu Jun 23 03:48:02 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261841AbVFWBuX@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlGoz-0001y2-BD
	for glk-linux-kernel@gmane.org; Thu, 23 Jun 2005 03:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVFWBuX (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Wed, 22 Jun 2005 21:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVFWBuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 21:50:20 -0400
Received: from mail.dvmed.net ([216.237.124.58]:31153 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261972AbVFWBrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 21:47:43 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1DlGoe-0002uB-Cp; Thu, 23 Jun 2005 01:47:40 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 22 Jun 2005, Jeff Garzik wrote:
> 
>>>But, like branches, it means that if you want a tag, you need to know the 
>>>tag you want, and download it the same way you download a branch.
>>
>>Still -- that's interesting data that no script currently tracks.  You 
>>gotta fall back to rsync.
> 
> 
> Something like
> 
> 	git-ssh/http-pull -w tags/<tagname> tags/<tagname> <url>
> 
> _should_ hopefully work now (and the "-a" flag should mean that you also 
> get all the objects needed for the tag).

The problem isn't pulling tags, the problem is that nothing 
automatically downloads the 41-byte tag files themselves.  Pulling 
linux-2.6.git after the 2.6.12 release did not cause refs/tags/v2.6.12 
to be downloaded.

With BK, tags came with each pull.  With git, you have to go "outside 
the system" (rsync) just get the new tags.

	Jeff
