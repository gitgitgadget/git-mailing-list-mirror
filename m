From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Mon, 12 Sep 2005 09:06:23 +1200
Message-ID: <46a038f905091114062b8cf3e6@mail.gmail.com>
References: <deofnh$jl0$1@sea.gmane.org>
	 <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	John Ellson <ellson@research.att.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 23:08:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEZ1y-0002gT-MJ
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 23:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbVIKVG1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 17:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbVIKVG1
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 17:06:27 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:44704 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750894AbVIKVG0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 17:06:26 -0400
Received: by rproxy.gmail.com with SMTP id i8so279585rne
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 14:06:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=szFkwpcMg2lKWzqjlDAiqtjs2ial7vS71tjHTAr39IH6Qo3N0cCBCStE2QkPHEQxndFjsJI34gP0Yxf9SVxz9fWyLnGtq7KL7ovyuavxCSeY0YENMLdUii/MhDtPrCxUabiIVPh/20Yzu/WDIhwUzCuMK4jzgPy3BH3m++HGBLQ=
Received: by 10.38.97.78 with SMTP id u78mr231424rnb;
        Sun, 11 Sep 2005 14:06:23 -0700 (PDT)
Received: by 10.38.101.53 with HTTP; Sun, 11 Sep 2005 14:06:23 -0700 (PDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0509111159190.32555@wgmdd8.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8329>

I'm running git & cogito on OSX 10.3.9 (Panther) with fink
0.7.1(stable), and have been using git w/o problems. I've just done an
update and recompiled to confirm...

On 9/11/05, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> - daemon.c needs a define or typedef for socklen_t.

Not a problem on 10.3.9.
 
> - mailinfo.c needs to have a simple strcasestr implementation, because
>   10.2.8 (at least in my setup) is lacking it!

Not a problem on 10.3.9.
 
> - gitk gets very confused about the window layout. My preliminary tests on
>   cygwin showed that this seems to be rather a problem of Tk with rootless
>   Xwin. I worked around it by explicitely stating the dimensions of some
>   canvas windows which would not automatically resize with their contents
>   otherwise.

I _am_ seeing this problem, but it's definitely an issue with Tk. I'd
be thankful if you could post the fixes...
 
> The only thing I did not "fix" is git-cvsimport not running because of a
> lacking File/Temp.pm. But then, I run git-cvsimport on a different machine
> anyway.

sudo cpan install File::Temp ?

At any rate, I've just checked and File::Temp is part of the Perl
5.8.1 installed in 10.3.9. Even fink knows this, and if you do
apt-cache show system-perl it'll tell you that it includes File::Temp.

Any platform-specific changes should be limited to backwards compat,
really. MacOSX is converging quickly towards GNU/Linux compatibility
in the build environment.

cheers,



martin
