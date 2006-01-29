From: Marco Costalba <mcostalba@gmail.com>
Subject: qgit with autotools
Date: Sun, 29 Jan 2006 09:14:03 +0100
Message-ID: <43DC794B.8000207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: proski@gnu.org
X-From: git-owner@vger.kernel.org Sun Jan 29 09:14:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F37hP-0004To-19
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 09:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWA2IOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 03:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWA2IOM
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 03:14:12 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:23584 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750751AbWA2IOL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 03:14:11 -0500
Received: by uproxy.gmail.com with SMTP id h2so64948ugf
        for <git@vger.kernel.org>; Sun, 29 Jan 2006 00:14:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=iD9ScXtRiT4grcYab/H7hocpgX1tQsTL6e4m7G28Die++Vy9qkZQmvqZib1U8ERRhYgcIDNLTJWngs0W5uo16KNnfFkovsLn+eGtBuvxJAfOet/ijH8kKut6B/ws6RxPV/hjXTlPuK89P0d4QPZSidUjBIRL8LFuuxmQSK08Ys0=
Received: by 10.48.254.9 with SMTP id b9mr452429nfi;
        Sun, 29 Jan 2006 00:14:09 -0800 (PST)
Received: from ?10.0.0.13? ( [151.56.33.177])
        by mx.gmail.com with ESMTP id l38sm732195nfc.2006.01.29.00.14.07;
        Sun, 29 Jan 2006 00:14:08 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0.6-7.4.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15205>

Hi all,

QGit now uses autotools instead of scons, courtesy of Pavel patch that has been pushed.
In patch description you will find the rationale for this update.

Also old git public repo has been removed after a deprecation period, so please now use:

    http://digilander.libero.it/mcostalba/scm/qgit.git


After pulling new changes you should run "autoreconf -i" to create proper build environment and
then the usual ./configure + make + make install


Following, Pavel's answers regarding some notes on new build environment.


>
> 1) qgit binary is now 4,6MB on my machine, with scons it was 858KB.

I think Autoconf defaults to using "-g".  You can strip the binary.  I think you
can even run "make install-strip".  And of course you can use "configure
CXXFLAGS=-O2" or something to disable debug information.

> 2) qgit is built in src directory instead of ./bin/ or ./ (not a biggie)

That's an Automake thing.  There are ways to work it about, but they are not
nice (using libraries).

However, you can create a separate directory and run "configure && make" from it
(configure should run be with full path to the source directory).  Then you get
a build outside the source tree.  It may be just as good for your purposes.


Marco
