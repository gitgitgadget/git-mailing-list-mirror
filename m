From: Erez Zilber <erezzi.list@gmail.com>
Subject: Re: Running "make rpm" fails on a CentOS 6.3 machine
Date: Thu, 30 Jan 2014 10:05:19 +0200
Message-ID: <CALMr_pWaSne1td951EJoWnSBzRwjvOQ5kt9En5KrE5rZ1FCAXw@mail.gmail.com>
References: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 30 09:05:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8mcm-0001Xr-MU
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 09:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275AbaA3IFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 03:05:21 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:61631 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000AbaA3IFU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 03:05:20 -0500
Received: by mail-ob0-f173.google.com with SMTP id vb8so3171013obc.32
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 00:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=Prlc95nlBDsIxpVl9CvBMQSOnCYxT8VUl9NiMZNokB4=;
        b=QvJbLZooEOnH/hjtKM81Mv6Yk6bdDDEdijyZGBTN0nLT9xUi2m9GctUPgfdRhPA2hq
         0hXZGA3hl8YY8k68hWNefiaX+P39fcCMFYkvoQnMFgHvCjZfrwCJ1kk1dEXti6xAXb4/
         jmcx3sS6ZuW3yqyigqs/feT76ApHWc1N2ZThhaJkvR2EaS8wV6Rfxq4g7fy0rCAzgW6w
         MvmYsJ7Cke79hg4L+cw9iCrv63bGy07qfXNRgESMpV+XVz+UXFmxqdSpenCcTABtRkRL
         r9Jj98f4Df233cvg51rjo5kgYvih3iNGGrp9vnVxCk9vRrQjNVagbWv5pRGlf49yjaud
         C0TA==
X-Received: by 10.60.120.8 with SMTP id ky8mr10416934oeb.3.1391069119863; Thu,
 30 Jan 2014 00:05:19 -0800 (PST)
Received: by 10.60.68.99 with HTTP; Thu, 30 Jan 2014 00:05:19 -0800 (PST)
In-Reply-To: <CALMr_pWHfaHq46418UPcqGKm6bFc61jw-VqGJYV8Ogc9yuHDFA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241260>

I hope this is the right list for this question. Is this a broken
feature/known issue? Is there a workaround for building the git rpm?

Thanks,
Erez

On Tue, Jan 28, 2014 at 12:29 PM, Erez Zilber <erezzi.list@gmail.com> wrote:
> Hi,
>
> I'm trying to build the git RPM (using tag v1.8.5.3) on a CentOS 6.3
> 64 bit machine. I was able to run 'make', but then I fail when running
> 'make rpm'. Can anyone help with the following error?
>
> [erez.zilber@erez-lx:~/work/
> git]$ make rpm
> sed -e 's/@@VERSION@@/1.8.5.3/g' < git.spec.in > git.spec+
> mv git.spec+ git.spec
>     GEN configure
> ./git-archive --format=tar \
>                 --prefix=git-1.8.5.3/ HEAD^{tree} > git-1.8.5.3.tar
> make[1]: Entering directory `/khome/erez.zilber/work/git/git-gui'
> make[1]: Leaving directory `/khome/erez.zilber/work/git/git-gui'
> tar rf git-1.8.5.3.tar \
>                 git-1.8.5.3/git.spec \
>                 git-1.8.5.3/configure \
>                 git-1.8.5.3/version \
>                 git-1.8.5.3/git-gui/version
> gzip -f -9 git-1.8.5.3.tar
> rpmbuild \
>                 --define "_source_filedigest_algorithm md5" \
>                 --define "_binary_filedigest_algorithm md5" \
>                 -ta git-1.8.5.3.tar.gz
> Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.GmHLGn
> + umask 022
> + cd /khome/erez.zilber/rpmbuild/BUILD
> + cd /khome/erez.zilber/rpmbuild/BUILD
> + rm -rf git-1.8.5.3
> + /usr/bin/gzip -dc /khome/erez.zilber/work/git/git-1.8.5.3.tar.gz
> + /bin/tar -xf -
> + STATUS=0
> + '[' 0 -ne 0 ']'
> + cd git-1.8.5.3
> + /bin/chmod -Rf a+rX,u+w,g-w,o-w .
> + exit 0
> Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.aVAwKk
> + umask 022
> + cd /khome/erez.zilber/rpmbuild/BUILD
> + cd git-1.8.5.3
> + make -j8 'CFLAGS=-O2 -g' ETC_GITCONFIG=/etc/gitconfig prefix=/usr
> mandir=/usr/share/man htmldir=/usr/share/doc/git-1.8.5.3 all doc
> make[1]: Entering directory `/khome/erez.zilber/rpmbuild/BUILD/git-1.8.5.3'
> GIT_VERSION = 1.8.5.3
> make[1]: Leaving directory `/khome/erez.zilber/rpmbuild/BUILD/git-1.8.5.3'
> make[1]: Entering directory `/khome/erez.zilber/rpmbuild/BUILD/git-1.8.5.3'
>
> ...
>
> Writing perl.mak for Git
> Writing perl.mak for Git
> rename MakeMaker.tmp => perl.mak: No such file or directory at
> /usr/share/perl5/ExtUtils/MakeMaker.pm line 1024.
> make[3]: perl.mak: No such file or directory
> make[3]: perl.mak: No such file or directory
> make[3]: *** No rule to make target `perl.mak'.  Stop.
> make[2]: *** [instlibdir] Error 2
> make[1]: *** [git-difftool] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make[3]: *** No rule to make target `perl.mak'.  Stop.
> make[2]: *** [instlibdir] Error 2
> make[1]: *** [git-add--interactive] Error 2
> Writing perl.mak for Git
> Writing perl.mak for Git
> Writing perl.mak for Git
> rename MakeMaker.tmp => perl.mak: No such file or directory at
> /usr/share/perl5/ExtUtils/MakeMaker.pm line 1024.
> make[3]: perl.mak: No such file or directory
> make[3]: perl.mak: No such file or directory
> make[3]: *** No rule to make target `perl.mak'.  Stop.
> make[2]: *** [instlibdir] Error 2
> make[1]: *** [git-cvsexportcommit] Error 2
> make[3]: *** No rule to make target `instlibdir'.  Stop.
> make[2]: *** [instlibdir] Error 2
> make[1]: *** [git-cvsserver] Error 2
> Writing perl.mak for Git
> mv: cannot stat `perl.mak': No such file or directory
