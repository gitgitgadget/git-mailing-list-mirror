From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git versus CVS (versus bk)
Date: Tue, 1 Nov 2005 09:28:30 +1300
Message-ID: <46a038f90510311228v50743158q80d79e963bd503ce@mail.gmail.com>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
	 <Pine.LNX.4.64.0510301811390.27915@g5.osdl.org>
	 <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
	 <20051031195010.GM11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 21:29:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWgGg-0003yW-Op
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 21:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVJaU2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 15:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVJaU2c
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 15:28:32 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:43513 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932179AbVJaU2b convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 15:28:31 -0500
Received: by xproxy.gmail.com with SMTP id i30so1071202wxd
        for <git@vger.kernel.org>; Mon, 31 Oct 2005 12:28:30 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lbHUUTbr8xpn4vAJrEnR4B19H3Y85iJ5p4D4o4jZfU0KPA0g2WARA4pKx0yaCdyt4Q9MiWB756+fYaVmoIlTerp4YT32GB1w9mXR/hpC5CRJ4qrE/ltwwyL5NhSUV9YoTmxTU4tC42YO04IPjvk8iOE/6mvmnXXbf9vGHyV3jOw=
Received: by 10.65.180.18 with SMTP id h18mr488710qbp;
        Mon, 31 Oct 2005 12:28:30 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Mon, 31 Oct 2005 12:28:30 -0800 (PST)
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20051031195010.GM11488@ca-server1.us.oracle.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10881>

On 11/1/05, Joel Becker <Joel.Becker@oracle.com> wrote:
>         Where do you stand on this?  Would you rather see the full
> history pulled?  Do you prefer the one-clean-patch approach?  If so, is
> there any way to get a cogito/git command for it (git-pull-as-one?)?

You can do a diff that spans all the commits and apply it with a new
commit msg. With cogito:

   cg-diff -r from:to | patch -p1

With git you can also do it directly within the repo/index with

   git-read-tree -m from HEAD to

In practice, a new developer will often roll up commits to avoid
sending a string of shameful patches and corrections on top -- I often
do that ;-) . Developers with more "mana" will have published repos
where Junio pulls directly from -- and they get merged with full
history. Of course -- they don't have brown-paper-bag commits like I
do...

Sounds like a reasonable, organic/dynamic way of doing it.

cheers,


martin
