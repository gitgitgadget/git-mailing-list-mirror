From: aonghus <thecolourblue@gmail.com>
Subject: Re: problem with git-cvsserver
Date: Wed, 30 Aug 2006 19:20:40 +0100
Message-ID: <44F5D6F8.50307@gmail.com>
References: <44F5B2A7.8070501@gmail.com> <Pine.LNX.4.63.0608301904360.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 30 20:21:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIUgR-0007oe-2l
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 20:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWH3SUp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 14:20:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWH3SUp
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 14:20:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:57470 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751287AbWH3SUo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Aug 2006 14:20:44 -0400
Received: by ug-out-1314.google.com with SMTP id m3so277371ugc
        for <git@vger.kernel.org>; Wed, 30 Aug 2006 11:20:42 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=G9Ucwexpp8IOB3MquZyQCJ6G0+k8eJhNd2p3RdxVNthWlPKbQMSlGFW5Azm73wuIJVAENtBuQByZE0SrOjtmmuPEvDeACbVuF8nB9A6KVkHvThdlRlo3Fo0QhmL2DJfmRfvWuTzIOHN+hHLXYnTZ9sNCv1hDXwMPjG5EXksVp+E=
Received: by 10.67.100.17 with SMTP id c17mr572173ugm;
        Wed, 30 Aug 2006 11:20:42 -0700 (PDT)
Received: from ?192.168.0.100? ( [137.43.156.41])
        by mx.gmail.com with ESMTP id q1sm718503uge.2006.08.30.11.20.41;
        Wed, 30 Aug 2006 11:20:42 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608301904360.28360@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26230>

Johannes Schindelin wrote:
> Hi,
>
> On Wed, 30 Aug 2006, aonghus wrote:
>
>   
>>    install_driver(SQLite) failed: Can't locate DBD/SQLite.pm in @INC (@INC
>> contains: /etc/perl /usr/local/lib/perl/5.8.8 /usr/local/share/perl/5.8.8
>> /usr/lib/perl5 /usr/share/perl5 /usr/lib/perl/5.8 /usr/share/perl/5.8
>> /usr/local/lib/site_perl /usr/local/lib/perl/5.8.7 /usr/local/share/perl/5.8.7
>> .) at (eval 7) line 3, <STDIN> line 14.
>>
>> [...]
>>
>>    libdbd-sqlite3-perl: /usr/share/perl5/DBD/SQLite.pm
>>     
>
> Have you checked that /usr/share/perl5/DBD/SQLite.pm is actually there? 
> Because your perl does not think so.
>
> OTOH it could be that it only works when SQLite.pm is in 
> /usr/lib/perl5/DBD/ (note the "lib" instead of "share"), because in my 
> (working) setup, both the .pm and the .so are under /usr/lib/perl5/...
>
> Hth,
> Dscho
>   

Hi,

Thanks for the reply, but I think the files are in the right place- here 
is what I have:

    $ dpkg -S SQLite
    libdbd-sqlite3-perl: /usr/share/man/man3/DBD::SQLite.3pm.gz
    libdbd-sqlite3-perl: /usr/share/perl5/DBD/SQLite.pm
    libdbd-sqlite3-perl: /usr/lib/perl5/auto/DBD/SQLite
    libdbd-sqlite3-perl: /usr/lib/perl5/auto/DBD/SQLite/SQLite.bs
    libdbd-sqlite3-perl: /usr/lib/perl5/auto/DBD/SQLite/SQLite.so


and it really is there:

    $ ll /usr/share/perl5/DBD/SQLite.pm
    -rw-r--r-- 1 root root 16K Apr 18 16:20 /usr/share/perl5/DBD/SQLite.pm


I don't know much about the perl SQLite package, but it seems that 
git-cvsserver is not loading the correct module. The line 'use DBI;' 
seems to load only this module:

    'DBI.pm' => '1.51 from /usr/lib/perl5/DBI.pm'

Does it need something else to load the SQLite module?

a
