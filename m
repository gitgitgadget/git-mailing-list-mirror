From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: [ANNOUNCE qgit-0.94]
Date: Sun, 11 Sep 2005 02:18:32 -0700 (PDT)
Message-ID: <20050911091832.16214.qmail@web26306.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 11 11:18:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EENyu-0001Mz-Lj
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 11:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbVIKJSe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 05:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbVIKJSe
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 05:18:34 -0400
Received: from web26306.mail.ukl.yahoo.com ([217.146.176.17]:5006 "HELO
	web26306.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964824AbVIKJSd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2005 05:18:33 -0400
Received: (qmail 16216 invoked by uid 60001); 11 Sep 2005 09:18:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Y+76XoNpd0qclmU2wRw3JUcXAhBA1LNT8CaUicBoJmeCLHoJyD6FqD+Yw1XBghJvZvnk/luAHaegNvTX14V6paCl/8sjhOW5ZXeZgKDwo/UpCf6VuQZWkZMJY4OI7FAKfmJJ4qrQhhPZrqSeZNe8p/AZSxwhhTO3pGa+cDLe7MQ=  ;
Received: from [151.42.200.67] by web26306.mail.ukl.yahoo.com via HTTP; Sun, 11 Sep 2005 02:18:32 PDT
To: skimo@liacs.nl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8279>

Sven Verdoolaege wrote:


>I had installed qt 4.0.1 in the mean time, because apparently
>the 3.1.2 I had installed before was too old.

QGit is build against qt3-devel-3.3.4

Qt 4 is known to be NOT compatible with qt3.


>It seems to have installed itself in /usr though.
>Removing the -I/usr/include/qt3 from SConstruct _seems_
>to make annotate.cpp compile.
>
>But now I get this:
>
>bash-3.00$ QTDIR=/usr/ make
>scons
>scons: Reading SConscript files ...
>scons: done reading SConscript files.
>scons: Building targets ...
>/usr//bin/uic -o src/commitbase.h src/commitbase.ui
>/usr//bin/uic -impl commitbase.h -o src/uic_commitbase.cc src/commitbase.ui
>/usr//bin/moc -o src/moc_commitbase.cc src/commitbase.h
>uic: File generated with too old version of Qt Designer
>File 'src/commitbase.ui' is not valid
>scons: *** [src/commitbase.h] Error 1
>scons: building terminated because of errors.
>make: *** [all] Error 2
>
>How can I create src/commitbase.ui ?
>

moc_* files are created by /usr/bin/moc, called automatically by scons, 
*base.h and *base.cpp files are created by /usr/bin/uic from
corresponding *base.ui file, also uic  is called automatically.

uic and moc are binary files distributed with qt package

IMHO your uic and moc binary are from Qt4 instead of Qt3. That's could explaing
the 'uic: File generated with too old version of Qt Designer' error.

Please remove qt4 and install qt3-devel-3.3.4


Marco





	
		
______________________________________________________ 
Yahoo! for Good 
Watch the Hurricane Katrina Shelter From The Storm concert 
http://advision.webevents.yahoo.com/shelter 
