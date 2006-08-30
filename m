From: aonghus <thecolourblue@gmail.com>
Subject: problem with git-cvsserver
Date: Wed, 30 Aug 2006 16:45:43 +0100
Message-ID: <44F5B2A7.8070501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 30 17:51:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GISGG-0000dD-0R
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 17:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWH3Pps (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 11:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWH3Pps
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 11:45:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:2067 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751097AbWH3Ppr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Aug 2006 11:45:47 -0400
Received: by nf-out-0910.google.com with SMTP id x30so170645nfb
        for <git@vger.kernel.org>; Wed, 30 Aug 2006 08:45:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=S8VL/++R6t+kOHoeAhh7DdbGxZDSKt3W2+gHxhn5jjrfSJZcD5xVEV5n54kF6ABw8O4/AcJqh/c7HcE4PcQ1E0ciVjakz7gBtcAU6sanDbiBp/RSnKpQ2ee7GzkhsE9fs+gwe6TKMvxpFHmF1DzYxAumZyAA85sddJK77IFhAXg=
Received: by 10.67.89.5 with SMTP id r5mr483603ugl;
        Wed, 30 Aug 2006 08:45:45 -0700 (PDT)
Received: from ?192.168.0.100? ( [137.43.156.41])
        by mx.gmail.com with ESMTP id o1sm425325uge.2006.08.30.08.45.44;
        Wed, 30 Aug 2006 08:45:45 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26227>

Hi,

I am trying to use git-cvsserver and I have come across this error:

    $ cvs co -d project-master master

    install_driver(SQLite) failed: Can't locate DBD/SQLite.pm in @INC (@INC contains: /etc/perl /usr/local/lib/perl/5.8.8 /usr/local/share/perl/5.8.8 /usr/lib/perl5 /usr/share/perl5 /usr/lib/perl/5.8 /usr/share/perl/5.8 /usr/local/lib/site_perl /usr/local/lib/perl/5.8.7 /usr/local/share/perl/5.8.7 .) at (eval 7) line 3, <STDIN> line 14.

    Perhaps the DBD::SQLite perl module hasn't been fully installed,

    or perhaps the capitalisation of 'SQLite' isn't right.

    Available drivers: DBM, ExampleP, File, Pg, Proxy, Sponge, mysql.

     at /usr/bin/git-cvsserver line 2055

    cvs [checkout aborted]: end of file from server (consult above messages if any)


This is a debian testing/unstable machine with git, git-core, git-cvs 
etc installed (with no problems):

    $ dpkg --list git-cvs

    ||/ Name                            Version                         Description

    +++-===============================-===============================-

    ii  git-cvs                         1.4.1.1-1                       content addressable filesystem (cvs interoperability)


Also, the perl DBI modules are installed:

    $ dpkg --list libdbd-sqlite3-perl

    ||/ Name                            Version                         Description

    +++-===============================-===============================-

    ii  libdbd-sqlite3-perl             1.12-1                          Perl DBI driver with a self-contained RDBMS

    $ dpkg -S SQLite

    libdbd-sqlite3-perl: /usr/share/man/man3/DBD::SQLite.3pm.gz

    libdbd-sqlite3-perl: /usr/share/perl5/DBD/SQLite.pm

    libdbd-sqlite3-perl: /usr/lib/perl5/auto/DBD/SQLite

    libdbd-sqlite3-perl: /usr/lib/perl5/auto/DBD/SQLite/SQLite.bs

    libdbd-sqlite3-perl: /usr/lib/perl5/auto/DBD/SQLite/SQLite.so


Anyone know whats wrong? If its a problem somewhere else (eg. with 
debian packaging), please point me there,

thanks

a
