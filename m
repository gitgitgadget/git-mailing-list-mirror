From: Erez Zilber <erezzi.list@gmail.com>
Subject: Running "make rpm" fails on a CentOS 6.3 machine
Date: Tue, 28 Jan 2014 12:29:22 +0200
Message-ID: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 28 11:29:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W85v5-0000nA-5l
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 11:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbaA1K3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 05:29:23 -0500
Received: from mail-oa0-f44.google.com ([209.85.219.44]:46781 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbaA1K3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 05:29:22 -0500
Received: by mail-oa0-f44.google.com with SMTP id g12so189887oah.31
        for <git@vger.kernel.org>; Tue, 28 Jan 2014 02:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7L04vzjVC2wWy6zw36AyY/ut5P05fnnfgpucj0P+yCg=;
        b=DminZFpS02vzbkzqsJuSpT41U1f6kx9HeMrZ/CEk2to447UiCWpULne/wgueOEQ4uB
         0bc2sPsBKUO94+68/ICGhePqiAFa6rI+e2V0RDV/d31w3/A/KC9h5IAGG6JwXLjaasDw
         LxuHw+Avdn+Do3BfQQsNoBlAKpY1upYcUhw6uKneS1/mtdP9ntMH2K29b6xGvNmp2rCp
         32CCZWJpqsXhn+vRUejGzGwIgiuQHiCoc8FHTFBw2YefLOxXcRqh1Z6xsb9rkRAyhSTp
         4pChC8g+q/t0JJyuMOyG9Ps2hPxKtOjBerXgq9xLqd6NehbW1Apalelbr1miL+BkDbNU
         S0gA==
X-Received: by 10.60.123.10 with SMTP id lw10mr529196oeb.24.1390904962169;
 Tue, 28 Jan 2014 02:29:22 -0800 (PST)
Received: by 10.60.68.99 with HTTP; Tue, 28 Jan 2014 02:29:22 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241182>

Hi,

I'm trying to build the git RPM (using tag v1.8.5.3) on a CentOS 6.3
64 bit machine. I was able to run 'make', but then I fail when running
'make rpm'. Can anyone help with the following error?

[erez.zilber@erez-lx:~/work/
git]$ make rpm
sed -e 's/@@VERSION@@/1.8.5.3/g' < git.spec.in > git.spec+
mv git.spec+ git.spec
    GEN configure
./git-archive --format=tar \
                --prefix=git-1.8.5.3/ HEAD^{tree} > git-1.8.5.3.tar
make[1]: Entering directory `/khome/erez.zilber/work/git/git-gui'
make[1]: Leaving directory `/khome/erez.zilber/work/git/git-gui'
tar rf git-1.8.5.3.tar \
                git-1.8.5.3/git.spec \
                git-1.8.5.3/configure \
                git-1.8.5.3/version \
                git-1.8.5.3/git-gui/version
gzip -f -9 git-1.8.5.3.tar
rpmbuild \
                --define "_source_filedigest_algorithm md5" \
                --define "_binary_filedigest_algorithm md5" \
                -ta git-1.8.5.3.tar.gz
Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.GmHLGn
+ umask 022
+ cd /khome/erez.zilber/rpmbuild/BUILD
+ cd /khome/erez.zilber/rpmbuild/BUILD
+ rm -rf git-1.8.5.3
+ /usr/bin/gzip -dc /khome/erez.zilber/work/git/git-1.8.5.3.tar.gz
+ /bin/tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd git-1.8.5.3
+ /bin/chmod -Rf a+rX,u+w,g-w,o-w .
+ exit 0
Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.aVAwKk
+ umask 022
+ cd /khome/erez.zilber/rpmbuild/BUILD
+ cd git-1.8.5.3
+ make -j8 'CFLAGS=-O2 -g' ETC_GITCONFIG=/etc/gitconfig prefix=/usr
mandir=/usr/share/man htmldir=/usr/share/doc/git-1.8.5.3 all doc
make[1]: Entering directory `/khome/erez.zilber/rpmbuild/BUILD/git-1.8.5.3'
GIT_VERSION = 1.8.5.3
make[1]: Leaving directory `/khome/erez.zilber/rpmbuild/BUILD/git-1.8.5.3'
make[1]: Entering directory `/khome/erez.zilber/rpmbuild/BUILD/git-1.8.5.3'

...

Writing perl.mak for Git
Writing perl.mak for Git
rename MakeMaker.tmp => perl.mak: No such file or directory at
/usr/share/perl5/ExtUtils/MakeMaker.pm line 1024.
make[3]: perl.mak: No such file or directory
make[3]: perl.mak: No such file or directory
make[3]: *** No rule to make target `perl.mak'.  Stop.
make[2]: *** [instlibdir] Error 2
make[1]: *** [git-difftool] Error 2
make[1]: *** Waiting for unfinished jobs....
make[3]: *** No rule to make target `perl.mak'.  Stop.
make[2]: *** [instlibdir] Error 2
make[1]: *** [git-add--interactive] Error 2
Writing perl.mak for Git
Writing perl.mak for Git
Writing perl.mak for Git
rename MakeMaker.tmp => perl.mak: No such file or directory at
/usr/share/perl5/ExtUtils/MakeMaker.pm line 1024.
make[3]: perl.mak: No such file or directory
make[3]: perl.mak: No such file or directory
make[3]: *** No rule to make target `perl.mak'.  Stop.
make[2]: *** [instlibdir] Error 2
make[1]: *** [git-cvsexportcommit] Error 2
make[3]: *** No rule to make target `instlibdir'.  Stop.
make[2]: *** [instlibdir] Error 2
make[1]: *** [git-cvsserver] Error 2
Writing perl.mak for Git
mv: cannot stat `perl.mak': No such file or directory
