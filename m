From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Thu, 1 Jun 2006 19:47:03 +1200
Message-ID: <46a038f90606010047r676840d2nd91ad2361abbe1c8@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <447B7669.8050805@gentoo.org>
	 <46a038f90605301531g4f8b37c7qab9a717833c64ebc@mail.gmail.com>
	 <Pine.LNX.4.64.0605301604130.24646@g5.osdl.org>
	 <46a038f90605301804u3beabf4ct97c8a0ea6ef7b995@mail.gmail.com>
	 <447D043D.1020609@gentoo.org>
	 <46a038f90605302305g7a969a62r277af1724b912069@mail.gmail.com>
	 <447DA028.3040606@gentoo.org>
	 <46a038f90605311503o1526c664qe61b0f3f40929b92@mail.gmail.com>
	 <447E4611.7000309@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Donnie Berkholz" <spyderous@gentoo.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 01 09:48:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlhuR-0006a3-VW
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 09:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWFAHrG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 03:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWFAHrG
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 03:47:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:33182 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750767AbWFAHrE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 03:47:04 -0400
Received: by wr-out-0506.google.com with SMTP id 36so230923wra
        for <git@vger.kernel.org>; Thu, 01 Jun 2006 00:47:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OaGgra4Dmgtdq38U0NUeZTIUmtA8INT4EyCxP0vxF89U8KaRH7ts4PFZd+Phd6ihzqklcH957j3XOIThyGYbAGBj5sKUstZ1HcFzTqdB03URKyuEVYQL6XmhexgwfNxpL8JeGeYTMg1Zy5u96w9MFrahpR9cw1G2UIMmzQY56NM=
Received: by 10.54.107.8 with SMTP id f8mr340323wrc;
        Thu, 01 Jun 2006 00:47:03 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Thu, 1 Jun 2006 00:47:03 -0700 (PDT)
To: antarus@gentoo.org
In-Reply-To: <447E4611.7000309@gentoo.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21106>

On 6/1/06, Alec Warner <antarus@gentoo.org> wrote:
> After reading the whole thread on this, I've using a git checkout of
> git, cvsps-2.1 and cvs-1.11.12, running overnight in verbose mode with
> screen.  Hopefully will have a repo in the morning ;)

Good stuff. I am rerunning it to prove (and bench) a complete an
uninterrupted import. So far it's done 4hs 30m, footprint grown to
207MB, 49750 commits. So I think it will be done in approx 30hs on
this single-cpu opteron.

Most commits are small, but there is a handful that are downright
massive -- and we hold all the file list in memory, which I think
explains (most of) the memory growth. I've looked into avoiding
holding the whole filelist in memory, but it involves rewriting the
cvsps output parsing loop, which is better left for a rainy day, with
a test case that doesn't take 30hs to resolve.

cheers,



martin
