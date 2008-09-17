From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 05:18:16 +0400
Message-ID: <20080917011816.GL28210@dpotapov.dyndns.org>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com> <37fcd2780809161620v38d9ade0sc1a2715f79501c6f@mail.gmail.com> <c49095e30809161640o21cb89b7x17a9ac1b5b18054f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mtk.manpages@gmail.com, git@vger.kernel.org,
	michael.kerrisk@gmail.com
To: Michael Kerrisk <michael.kerrisk@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 03:19:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kflhc-0004hw-Pb
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 03:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752589AbYIQBSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 21:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbYIQBSX
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 21:18:23 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:3381 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752524AbYIQBSW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 21:18:22 -0400
Received: by ey-out-2122.google.com with SMTP id 6so1310309eyi.37
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 18:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=jZWr6qeea4ynRayrdFP3zXdhZ1JeKEMQfzcBRJ98cQg=;
        b=DCqtS+bEcsl+n7G9dxLorQsiaUi1X1m2cOX0ZYLL9T8VgEBwhL8uerqajH5JKaIgij
         Xfw8fcNDn75euu5/JoY81ghiKD2jWBYfTiLFGrAStF/y7ibX85XK8kV9Wy05SZNTZoqT
         lLbA1z9ss75h1BnFfHAxDTs8H1omEVBxvAUPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GN5rYFiu5jVVLf1Ick2rTdrUpO0rknzbzReWud70jsAFHISAFgbgZ8GL2zmeMaPKkY
         2QHulJ1XL8qEcYFrHBA59jRi9KjaB/IPF3HVccU6tEDn+kcjEouZJ/lk35zACdMbDlxj
         Pb8rAV9hPjs01f6O+zfpu7SHCuaCLowhVz+H8=
Received: by 10.86.95.8 with SMTP id s8mr1437620fgb.6.1221614300894;
        Tue, 16 Sep 2008 18:18:20 -0700 (PDT)
Received: from localhost ( [85.141.190.51])
        by mx.google.com with ESMTPS id l19sm319217fgb.7.2008.09.16.18.18.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Sep 2008 18:18:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <c49095e30809161640o21cb89b7x17a9ac1b5b18054f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96063>

On Wed, Sep 17, 2008 at 01:40:36AM +0200, Michael Kerrisk wrote:
> 
> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b branches
> 
> takes about half an hour to run, the other command (which I already
> started yesterday) seems to be taking (far) more than a day!

What version of Git do you use? If you use a version earlier than 1.5.6
than you can notice *considerable* speed up by upgrading to the latest
version of Git. Also, git-svn does not work well on Windows. Cygwin
version is slow due to fork(), and MSYS Git has some other issues with
Perl. So, if you want to convert a huge SVN repo, it is better to do on
Linux and using the latest version of Git. Perhaps, running on tmpfs may
speed up the process even more.

> Therefore, so far, I have not had a chance to run the command to
> completion to see if it gives the desired result.  The greatly
> increased tun time also made me suspicious about whether the command
> was going to do the right thing.  And, I end up with a lot of strange
> looking tags in the (as yet incompletely) imported tree:
> 
> $ git branch -a
>   tags/man-pages-2.00
>   tags/man-pages-2.00@117
>   tags/man-pages-2.01
>   tags/man-pages-2.01@145
>   tags/man-pages-2.02
>   tags/man-pages-2.02@184
>   tags/man-pages-2.03
>   tags/man-pages-2.03@232
>   tags/man-pages-2.04
>   tags/man-pages-2.04@283
> 
> What are the @nnn tags about?

I have never encounted them. Are you sure that you import into a clean
Git repo?

Dmitry
