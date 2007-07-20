From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Feedback on native Win32 git from a Perl perspective
Date: Sat, 21 Jul 2007 01:32:25 +1200
Message-ID: <46a038f90707200632u1ce762c1i70eb1586e2542256@mail.gmail.com>
References: <46A06C7F.5010601@phase-n.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adam Kennedy" <adam@phase-n.com>
X-From: git-owner@vger.kernel.org Fri Jul 20 15:32:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBsas-00070M-Oa
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 15:32:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757325AbXGTNc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 09:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757323AbXGTNc1
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 09:32:27 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:12811 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756729AbXGTNc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 09:32:26 -0400
Received: by wx-out-0506.google.com with SMTP id h31so837910wxd
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 06:32:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NHm2GDkBeRxNMgLc+Ycv6mFApxLGomwdQjFypqh0Tq8MWlDuMLcTD/qo7jT0hdmfhOjfqvl85xTtxg7WkVrCeS8ZLe/mTQN/TDGzy1WMBK+LMj4WFhixlqVcuRsIH4+8AVvITD9FPM+4EUKMKfU3FCEjG0lFj1Vo+574AILQ9Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WrPf4k28HhLiqeJ6a41PpkLNfwEHth830yQ4/xl5o6WlwzrxmekfR9oiat/IHTIzlQIH/oliKZoLTWsRLs/PzZ85AWvpjY75cGXR3lJ2hDoQZlp3P7Fo+FyLtT/Cb996RFD4WcGtVxkyeMueIQUzQ3Z0jLQ6lZ5y7w8ZI94xiO0=
Received: by 10.90.73.7 with SMTP id v7mr283620aga.1184938345551;
        Fri, 20 Jul 2007 06:32:25 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Fri, 20 Jul 2007 06:32:25 -0700 (PDT)
In-Reply-To: <46A06C7F.5010601@phase-n.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53093>

On 7/20/07, Adam Kennedy <adam@phase-n.com> wrote:
> A quick review of native Win32 git provoked by the current conversation
> amoungst the Perl core maintainers about changing version control
> systems and whether to go with svn or git (the main two candidates).

Hi Adam,

The problem you hit is that you need the MinGW runtime -- I forget its
name -- and that will have installed an item in your start menu. It's
for a terminal that has all the MinGW stuff, you get a nice bash
shell. I opened, added the GIT install directory to the path, and was
all set.

I think Sam Vilain (aka mugwump) is going to / at / returning from
OSCON this week, so he migth take a while to reply. Oh, I see he
posted in your blog too.

He's been running imports of the Perl dev trees into git, they'll be
at http://git.catalyst.net.nz/gitweb - fetchable via http at
http://git.catalyst.net.nz/git/perl.git

My notes above are because I have _just_ been setting up git at
aclient site on Win32. Took me a bit of fiddling as I hadn't used
Windows in years, but I got it going...

 - needs the mingw runtime - trivial
 - runs pretty well from the commandline - impressed
 - gitk and other Tk-based utilities work great ( _very_ impressed)
but I had to fixup the wish executable name - minor
 - the http protocol wasn't supported out of the box in the version I
got, a pain for anon checkouts, and I've seen some discussion about
that on the list -- unsure here

In terms of http support -- IIRC the problem is handling of forked
processes, but there might be a way to sidestep the problem.  Very
early versions of git did some odd curl cmdline that Cogito copied.
Serialised, slow and not one bit as smart as what we do now, but we
can perhaps reuse some of that.

Some things you point out can be improved once things are more
polished -- like adding links to gitk and git gui but we'd need to
sort out how to do this in a directory context. Heh - maybe we need
one of those explorer.exe extensions...

>From a "we are very limited Windows users" POV, no, we don't have
TortoiseSVN unfortunately. But for developers used to mixed cli/gui
environments, like I'm sure most Perl developers are, it'll be a
breeze. It does need a bit of a howto though.

> For reference, the reviewer (me) has 10 years of experience with Perl
> development across both Windows, Linux, BSD, Solaris, Mac (old and new).

I'm guess in general terms I have a somewhat similar bg  -- though I
don't develop Perl ;-) -- and perhaps it's a bit of luck. I had
_never_ seen MinGW (I do know CygWin) and perhaps it was a stroke of
luck that it only took me about 45 minutes to get things going,
figuring out the stuff noted above.

cheers,



martin
