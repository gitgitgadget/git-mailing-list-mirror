From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 2/2] Remove dead code after direct graph drawing
Date: Sat, 21 Oct 2006 17:40:25 +0200
Message-ID: <200610211740.26128.Josef.Weidendorfer@gmx.de>
References: <200610191613.19142.Josef.Weidendorfer@gmx.de> <200610200111.26259.Josef.Weidendorfer@gmx.de> <e5bfff550610202335rcb83ea8mf7ec2dd79ec6dd90@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 17:40:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbIxj-0002Mj-FH
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 17:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993107AbWJUPkg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 11:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993109AbWJUPkg
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 11:40:36 -0400
Received: from mail.gmx.de ([213.165.64.20]:61677 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S2993107AbWJUPkf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 11:40:35 -0400
Received: (qmail invoked by alias); 21 Oct 2006 15:40:34 -0000
Received: from p54968BB2.dip0.t-ipconnect.de (EHLO noname) [84.150.139.178]
  by mail.gmx.net (mp039) with SMTP; 21 Oct 2006 17:40:34 +0200
X-Authenticated: #352111
To: "Marco Costalba" <mcostalba@gmail.com>
User-Agent: KMail/1.9.3
In-Reply-To: <e5bfff550610202335rcb83ea8mf7ec2dd79ec6dd90@mail.gmail.com>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29621>

On Saturday 21 October 2006 08:35, you wrote:
> Josef,
> 
>  I think ther's a leak somewhere.

I am not really sure...
I just scrolled up and down through
the kernel repo with the page up/down keys (around 34K revisions).

On the first pass down, the memory increases by around 26 MB,
which could by correct, as you do setupData() lazy (no idea what
this function does...).
On the 2nd pass up again, I only get an increase of around 2 MB.
That could be other effects, as on further passes, I do not see
any change with pure scrolling.

> Checking memory use with ksysguard is see memory use going up
> scrolling up and down also on the same revisions list view subset.
> 
> I'm not sure it depends on your patch though.

Can you compare with/without my patch?
I have no idea what could have introduced any leak here. I do not
create any new class instance / structures, but only get rid of pixmap
creations/deletions.

How did you check for leaks in the past?
Did you try valgrind (memcheck or massif)?

Josef

> 
> Marco
> 
> 
