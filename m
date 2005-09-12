From: Tony Luck <tony.luck@gmail.com>
Subject: Re: What's up with the GIT archive on www.kernel.org?
Date: Mon, 12 Sep 2005 11:22:58 -0700
Message-ID: <12c511ca050912112266470d8b@mail.gmail.com>
References: <m3mzmjvbh7.fsf@telia.com>
	 <Pine.LNX.4.58.0509110908590.4912@g5.osdl.org>
	 <20050911185711.GA22556@mars.ravnborg.org>
	 <Pine.LNX.4.58.0509111157360.3242@g5.osdl.org>
	 <20050911194630.GB22951@mars.ravnborg.org>
	 <Pine.LNX.4.58.0509111251150.3242@g5.osdl.org>
	 <52irx7cnw5.fsf@cisco.com>
	 <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
Reply-To: tony.luck@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Roland Dreier <rolandd@cisco.com>, Sam Ravnborg <sam@ravnborg.org>,
	Peter Osterlund <petero2@telia.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 20:24:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEsxd-0006u8-0W
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 20:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVILSXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 14:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbVILSXN
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 14:23:13 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:59215 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932126AbVILSXM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 14:23:12 -0400
Received: by zproxy.gmail.com with SMTP id 13so305913nzn
        for <git@vger.kernel.org>; Mon, 12 Sep 2005 11:23:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g7jz+SdceMelp/H/oY09LnYxEMx35X8KAHOLilQznCKGFYVxqbFVy1x/hZm9RCvbTpZRo6sCWiRaj5/sifvV3GCwS0/fvkq8Rl5R7/KE7/KqPc0jwx+2oj1bL2/AGMYrJfpEcvWlzF37yXCuSIg6z/ohsQrhkiuu2Jjwpg+w1Rg=
Received: by 10.36.58.17 with SMTP id g17mr95450nza;
        Mon, 12 Sep 2005 11:22:59 -0700 (PDT)
Received: by 10.36.58.18 with HTTP; Mon, 12 Sep 2005 11:22:58 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509111422510.3242@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8411>

On 9/11/05, Linus Torvalds <torvalds@osdl.org> wrote:
> There is such an anonymous server, btw: "git-daemon" implements anonymous
> access much more efficient than rsync/http. Sadly, kernel.org still
> doesn't offer it (but it's now used in the wild, ie I've done a couple of
> merges with people running the git daemon).

Should the git daemon take a look at objects/info/alternates to check
that if it exists, it
points to a repository that also has a "git-daemon-export-ok" file?  
I don't see that this
could be used for anything nasty, but it does provide a loophole where
the daemon may
open files outside the initial repository ... so a sanity check seems in order.

-Tony
