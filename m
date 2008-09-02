From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: non-monotonic index error
Date: Tue, 2 Sep 2008 19:48:47 -0400
Message-ID: <9e4733910809021648y5b0db178vc953fb81144881b0@mail.gmail.com>
References: <9e4733910809021257v3012ec89l64b2bb412ac1ebbd@mail.gmail.com>
	 <alpine.LFD.1.10.0809021625230.23787@xanadu.home>
	 <9e4733910809021437w40eb1e2cv6379e5d199e234a5@mail.gmail.com>
	 <alpine.LFD.1.10.0809021859030.23787@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 01:50:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KafdI-0003bu-Qq
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 01:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123AbYIBXsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 19:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbYIBXsu
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 19:48:50 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:31607 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753650AbYIBXst (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 19:48:49 -0400
Received: by py-out-1112.google.com with SMTP id p76so1386686pyb.10
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 16:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=28gCbGq6+zngIsl07+stWlKoKP0XH37aCM4xqhPJexg=;
        b=ufGBwEzR8ty9CCyS6eAU3eB1w/Es1rxTwUyhkWqzs9xRvc160blyGDxBN2cTqWYzfq
         xfqt4WcJeeNgDYDv+ChoWjO5P85Bf8ewWz0c3EzpS5zPS3VmqcTPoeyYUgey6kmYnUgw
         6N8raZLtNzrJBqJUGCZ2GyxoB9scbNdoVTh9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ad8nbXoor3C8wftb86+9v0QIPKqQLwsp1nbKUCOOey77Ng14KOZL8W7rQPvJL5peVu
         CGjVtv6nOvUgcy9bbGxxpOsJppNWHYfS+QcMdvpn1Byb940+Zv+ZfOE2IuWX7a0FG9GY
         qvpeDgW/XR6BGhkipFd5aW5iRV8oD4cohzy5E=
Received: by 10.64.199.2 with SMTP id w2mr16764331qbf.13.1220399327358;
        Tue, 02 Sep 2008 16:48:47 -0700 (PDT)
Received: by 10.64.178.13 with HTTP; Tue, 2 Sep 2008 16:48:47 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0809021859030.23787@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94740>

On 9/2/08, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 2 Sep 2008, Jon Smirl wrote:
>
>  > On 9/2/08, Nicolas Pitre <nico@cam.org> wrote:
>  > > On Tue, 2 Sep 2008, Jon Smirl wrote:
>  > >
>  > >  > I pulled from linus, did stg rebase linus/master, git push digispeaker
>  > >  > and got these errors.
>  > >  >
>  > >  > Where's the problem, at my local machine or the digispeaker one? How
>  > >  > do I fix this?
>  > >  >
>  > >  > jonsmirl@terra:~/fs$ stg --version
>  > >  > Stacked GIT 0.14.3.195.g36a0
>  > >  > git version 1.5.6.GIT
>  > >  > Python version 2.5.2 (r252:60911, Jul 31 2008, 17:31:22)
>  > >  > [GCC 4.2.3 (Ubuntu 4.2.3-2ubuntu7)]
>  > >  > jonsmirl@terra:~/fs$
>  > >  >
>  > >  > [digispeaker]$ git --version
>  > >  > git version 1.4.4.4
>  > >
>  > >
>  > > This should be upgraded to at least version 1.4.4.5.  If this is a
>  > >  Debian distro and they didn't provide an updated package for git then
>  > >  please fill a bug with Debian.
>  > >
>  >
>  > I just built the current version in my local directory, I'm still
>  > getting the monotonic error on push. Do I need to repack or something?
>
>
> Probably because the version in your local directory is not the one used
>  when the push is performed.  Still, on pushes it is the native git
>  protocol which is used and in that case there should not be any index
>  version issues.
>
>  Puzzled.

Whack tree at server.
Clone from linus.
Push to the tree again.

Problem is gone.

--------------------------------------
This may be a clue...

[digispeaker]$ git repack
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
Generating pack...
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
fatal: bad object bce7f793daec3e65ec5c5705d2457b81fe7b5725
[digispeaker]$ git show bce7f793daec3e65ec5c5705d2457b81fe7b5725
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
error: non-monotonic index
fatal: bad object bce7f793daec3e65ec5c5705d2457b81fe7b5725
[digispeaker]$

That's a valid object so it should have been ok. I think my tree got
corrupted somehow.


-- 
Jon Smirl
jonsmirl@gmail.com
