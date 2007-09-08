From: Brian Mc Enery <moghroth@gmail.com>
Subject: gitweb on MAC OSX 10.3 Panther
Date: Sat, 8 Sep 2007 15:05:44 +0100
Message-ID: <9774728C-5E14-11DC-9B36-000A95EB57B4@gmail.com>
Mime-Version: 1.0 (Apple Message framework v606)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 08 16:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IU13A-00033Z-EG
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 16:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742AbXIHOMd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 8 Sep 2007 10:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752725AbXIHOMc
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 10:12:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:20207 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbXIHOMb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 10:12:31 -0400
Received: by nf-out-0910.google.com with SMTP id f5so548318nfh
        for <git@vger.kernel.org>; Sat, 08 Sep 2007 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer;
        bh=DYaMi0jInZrkYq+o8YTp1IdqlZ5SvA+SJwY3I7k/CBA=;
        b=IgVcK67BL/4mzGcCOBz/UNW2T/FUz7qdCgKIJUGr+xFyJ6anCQjnH3c/u9PafqcRQDqkzMlU79ZZoi5gmcq9I5PTZ2xiDnc0UaGObmU8P3476TPXxRrvX+k/fxh4zVAKz7FYzyCmiqe3JYVQp9CAvwlbsHAxIIQg663n9djSM/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:mime-version:content-transfer-encoding:message-id:content-type:to:from:subject:date:x-mailer;
        b=p0X6jYzysSjm0DFmsndpBbOvQh+fJ6lEBwu1FPWvonAVFRfansdHiGtgKTkH2DbpLCJwY+3gOgt7SZJy60lUNMDfPtdE5X1cpoR504zTDQRCCub5H50CXHU6CrXnGb9xWCbS8xBuCtWLYJEPHYw/SJhbHwFtfAyNjh9o17opNcQ=
Received: by 10.86.82.16 with SMTP id f16mr2235564fgb.1189260750095;
        Sat, 08 Sep 2007 07:12:30 -0700 (PDT)
Received: from ?194.165.168.222? ( [194.165.168.222])
        by mx.google.com with ESMTPS id d26sm9434785nfh.2007.09.08.07.12.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Sep 2007 07:12:29 -0700 (PDT)
X-Mailer: Apple Mail (2.606)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58126>

Hi there,

I have just completed the installation of gitweb (git version 1.5.3.1)=20
on Mac OSX 10.3 Panther, and I thought that you may be interested in=20
including  a note with your distribution, to enable an easier=20
experience for others.

Essentially the commands I used were variations on the following.

****** Start installation of gitweb on Mac OSX ******

make    	prefix=3D"/usr/local" \
         	PERL_PATH=3D"/usr/local/ActivePerl-5.8/bin/perl" \
         	all

sudo      make prefix=3D/usr/local install


make   	PERL_PATH=3D"/usr/local/ActivePerl-5.8/bin/perl" \
         	GITWEB_PROJECTROOT=3D"/Library/WebServer/Documents/gitweb/rep=
" \
		GITWEB_CSS=3D"/gitweb/res/gitweb.css" \
		GITWEB_LOGO=3D"/gitweb/res/git-logo.png" \
		GITWEB_FAVICON=3D"/gitweb/res/git-favicon.png" \
         	GITWEB_SITENAME=3D"Local Git" \
		bindir=3D/usr/local/bin \
		gitweb/gitweb.cgi

cp -fv  ./gitweb/gitweb.cgi /Library/WebServer/CGI-Executables/gitweb

cp -fv  	./gitweb/gitweb.css \
         	./gitweb/git-{favicon,logo}.png \
         	/Library/WebServer/Documents/gitweb/res

****** End installation of gitweb on Mac OSX ******

Notes:

Perl_Path was necessary in order to change the shebang line in any perl=
=20
or cgi scripts to use my non-standard
perl interpreter, i.e. different from usr/bin/perl.

The gitweb.cgi script and the configuration file gitweb_configure.perl=20
must be placed in a directory under /Library/WebServer/CGI-Executables,=
=20
as this is equivalent to localhost/cgi-bin. In this case I used=20
/Library/WebServer/CGI-Executables/gitweb.


The gitweb resources *must* be placed in a folder in=20
/Library/WebServer/Documents, not in=20
/Library/WebServer/CGI-Executables. In this case I placed the resources=
=20
in  /Library/WebServer/Documents/gitweb/res, and used=20
/Library/WebServer/Documents/gitweb/rep, as the project root. The=20
absolute url for the project root must be specified.

In order to use symbolic links from a live project to the projectroot=20
it was not necessary to make any changes to the Apache configuration=20
file, however the files being linked to i.e. the project/.git files=20
*must*(it took forever to work this out), be in a publicly accessible=20
area, even if you are accessing using a browser under you own username.=
=20
In my case I placed those projects in the Public folder, under my own=20
username.

Relevant file permissions must of course be tweaked.

If all goes according to plan repositories are accessible from=20
http://localhost/cgi-bin/gitweb/gitweb.cgi



Thank you,

Br=EDan




Br=EDan Mach Aon Inn=E9irghthe
Corcaigh
=C9ire
