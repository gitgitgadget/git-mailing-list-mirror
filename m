From: "Jerry Seutter" <Jerry.Seutter@pason.com>
Subject: RE: Compilation troubles
Date: Tue, 12 Jul 2005 13:47:40 -0600
Message-ID: <5EDB10423795F248B2A4C4957409ED680280D62D@exch-calgary.int.pason.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Tue Jul 12 21:48:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsQk7-0005AX-Ss
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 21:48:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVGLTsA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 15:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVGLTry
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 15:47:54 -0400
Received: from hemlock.pason.com ([208.38.1.1]:22055 "EHLO
	exch-calgary.int.pason.com") by vger.kernel.org with ESMTP
	id S262351AbVGLTro convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 15:47:44 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Compilation troubles
Thread-Index: AcWHEDcGAWw+xoR4SmSK9oF5pT6cpAAAsoMAAAGyC9A=
To: "Jerry Seutter" <Jerry.Seutter@pason.com>,
	"Dan Kohn" <dan@dankohn.com>, <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 

> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Jerry Seutter
> Sent: Tuesday, July 12, 2005 1:01 PM
> To: Dan Kohn; git@vger.kernel.org
> Subject: RE: Compilation troubles
> 
>  
> 
> > -----Original Message-----
> > From: git-owner@vger.kernel.org 
> > [mailto:git-owner@vger.kernel.org] On Behalf Of Dan Kohn
> > Sent: Tuesday, July 12, 2005 12:34 PM
> > To: git@vger.kernel.org
> > Subject: Compilation troubles
> > 
> > I apologize for what are probably obvious compilation 
> questions, but I
> > suspect other newbies are encountering them as well.  I'm 
> > having trouble
> > installing cogito 0.12.1 on both a vanilla Ubuntu box and on 
> > my account
> > on a FreeBSD machine.  I'm used to autoconf-built programs, 
> so there's
> > probably just some simple library path I'm not setting up 
> right.  But
> > I'd appreciate your suggestions, and perhaps we can add the 
> answer to
> > the INSTALL file.
> > 
> > UBUNTU 5.04
> > 
> > I used synaptics to install openssl, zlib, and curl, but 
> cogito can't
> > seem to see them.
> > 
> > root@ubuntu-dan-kohn:/usr/local/src/cogito-0.12.1 # make
> > cc -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>'   -c -o 
> read-cache.o
> > read-cache.c
> > In file included from read-cache.c:6:
> > cache.h:21:21: openssl/sha.h: No such file or directory
> 
> I tried this last night with Ubuntu (Warty).  The openssl package
> doesn't include header files so presumably you would need to install
> openssl-dev, only that package doesn't seem to exist in 
> Ubuntu-land.  I
> gave up at this point and installed on a different system.
> 
> The README file for cogito/git mentions that there is an ssl library
> included in the source which you can use if you don't have 
> openssl.  It
> doesn't give any directions on how to use it, however.  You could try
> looking into using that.
> 

If you build the openssl package from source, it builds a libssl-dev
package that you can install on your system.  Do something like:

mkdir -p /tmp/tmp && cd /tmp/tmp
apt-get source openssl
sudo ./openssl-0.9.7d/debian/rules binary
sudo dpkg -i libssl-dev_0.9.7d-3ubuntu0.1_i386.deb

then you should be able to build past the openssl part.  Presumably
you'll have to do something similar for libcurl, but I haven't tried it.

Jerry Seutter
