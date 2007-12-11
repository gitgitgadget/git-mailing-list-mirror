From: David <davvid@gmail.com>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Tue, 11 Dec 2007 12:54:46 -0800
Message-ID: <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com>
	 <e5bfff550712111020k51829c03n5d64a94ce7c7ac2a@mail.gmail.com>
	 <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com>
	 <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jason Sewall" <jasonsewall@gmail.com>,
	"Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 21:55:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2C8H-0000VT-5j
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbXLKUys (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 15:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751769AbXLKUys
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 15:54:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:34149 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbXLKUyr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 15:54:47 -0500
Received: by ug-out-1314.google.com with SMTP id z38so390998ugc.16
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 12:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=16uqRYyULbUw/GoFGLXUmz15bxHezpox6FWwKRbWTCo=;
        b=O84JXL1PabAaeUQ2qgBbI+Fgd28GzdIUYUCY7U0vhTgU49GhjSfJhS5r0/ug72ttG/W29h8GCbGHqe9VW3m5ftvLmU0jw4/7X4QCxQ+0i7Pc4LWlEVuPmpv66HOCzpnVkGTaVL0zcCijdBpibsHDcIt2p557zyvGAcpx1U6teOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XHhL3BE2ZPX8R1V8kr1A0URx/UgjD0kZj2HcGpxF6/sw3cxUIVPvjrJ8qLy0K/bJgrF/ubAg2ZLYnYuRmWbjulyPBVU1YL4jmsy+HeiLXPYiKGijolTOrdk5EW1n6GiFbD7VFlUb1aFrnViM9LoTqC+/TTQ0auvSkiQ3jYKqaN8=
Received: by 10.67.22.2 with SMTP id z2mr1406121ugi.1.1197406486279;
        Tue, 11 Dec 2007 12:54:46 -0800 (PST)
Received: by 10.67.118.1 with HTTP; Tue, 11 Dec 2007 12:54:46 -0800 (PST)
In-Reply-To: <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67937>

On Dec 11, 2007 11:33 AM, Marco Costalba <mcostalba@gmail.com> wrote:
> On Dec 11, 2007 8:14 PM, Jason Sewall <jasonsewall@gmail.com> wrote:
> > On Dec 11, 2007 1:20 PM, Marco Costalba <mcostalba@gmail.com> wrote:
>
> > ./configure --prefix=/usr fixed that for me (and I'm sure there's a
> > way to tell python to look in /usr/local... too, but I can't be
> > bothered with that.
> >
>
> ./configure --prefix=$HOME/bin
>
> (half) worked thanks.
>

Hello

To allow python to find the libs you just have to set $PYTHONPATH to
include $PREFIX/lib/python2.4/site-packages  (change that 2.4 to 2.5
if you're on python2.5).  Of course in a packaged form that wouldn't
be an issue since $PREFIX=/usr, but for test-driving it you'd probably
need to set PYTHONPATH.  Are there any distros that don't use
$PREFIX/lib/python2.x/site-packages?  If not, it wouldn't hurt to add
an assumption about the installation layout into the main script.


> > I re-installed without the prefix and that error disappeared, but now I get
> > Traceback (most recent call last):
> >   File "/usr/local/bin/ugit", line 12, in <module>
> >     view = GitView (app.activeWindow())
> >   File "../py/views.py", line 15, in __init__
> >   File "default/ui/Window.py", line 43, in setupUi
> > AttributeError: setLeftMargin

As for the setLeftMarginError -- That could be because you have py/qt
4.2.  The ui files were generated with designer-qt4 (4.3.x) so you
might need a more recent pyqt4.  I'll see if I can grab an older
version of pyqt and use it for all of the ui designs  (.ui files are
probably forward but not backwards compatible).
