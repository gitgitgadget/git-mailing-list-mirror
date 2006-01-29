From: Marco Costalba <mcostalba@yahoo.it>
Subject: qgit with autotools
Date: Sun, 29 Jan 2006 10:14:28 +0100
Message-ID: <43DC8774.8080309@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: proski@gnu.org
X-From: git-owner@vger.kernel.org Sun Jan 29 10:14:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F38dv-000547-Jp
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 10:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWA2JOk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 04:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWA2JOk
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 04:14:40 -0500
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:58990 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750759AbWA2JOk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2006 04:14:40 -0500
Received: (qmail 65739 invoked from network); 29 Jan 2006 09:14:37 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:Content-Type:Content-Transfer-Encoding;
  b=k/GoXFxByIxe0ltLjjGbz+54xW/5NgzXyxDfFKDT/rF4IIGgwJDjmzgXuJIkmTjmW88RlSPJWSNofiziCusd654dvu0gLz+A6oINHQMVNaautZz5V1kg9xxZ6GW4lDNs6pLFQEdpZlpjWwkn1dpp6xVKpIFLlQLaHVwtXy/XsT0=  ;
Received: from unknown (HELO ?10.0.0.13?) (mcostalba@151.56.33.177 with plain)
  by smtp015.mail.yahoo.com with SMTP; 29 Jan 2006 09:14:35 -0000
User-Agent: Mozilla Thunderbird 1.0.6-7.4.20060mdk (X11/20050322)
X-Accept-Language: it, it-it, en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15208>

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


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
