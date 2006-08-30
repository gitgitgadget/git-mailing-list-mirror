From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: problem with git-cvsserver
Date: Thu, 31 Aug 2006 08:29:21 +1200
Message-ID: <46a038f90608301329n14df4dd2tb1563cc48662cd14@mail.gmail.com>
References: <44F5B2A7.8070501@gmail.com>
	 <Pine.LNX.4.63.0608301904360.28360@wbgn013.biozentrum.uni-wuerzburg.de>
	 <44F5D6F8.50307@gmail.com> <7vlkp6gh6e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: aonghus <thecolourblue@gmail.com>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 30 22:29:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIWgp-0007EK-1j
	for gcvg-git@gmane.org; Wed, 30 Aug 2006 22:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWH3U3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Aug 2006 16:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWH3U3X
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Aug 2006 16:29:23 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:42013 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750858AbWH3U3W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Aug 2006 16:29:22 -0400
Received: by nf-out-0910.google.com with SMTP id x30so247472nfb
        for <git@vger.kernel.org>; Wed, 30 Aug 2006 13:29:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CtEsylM1sD4MRGAWeIlDx1uXF00tMfc3KtnHV50qACvY8XzzoZnQXe5HU98+LKFCLAie4qgCnnHdAoO8mz37S+Hth9Vjo6MKt+wB7jN+vkWTOcDMe0YsuhQoKnlFpgUy8fB2o5H4JXb+SFHVHyOpmif0mNcf8f0ZeeRhVbQds6A=
Received: by 10.49.91.6 with SMTP id t6mr180494nfl;
        Wed, 30 Aug 2006 13:29:21 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Wed, 30 Aug 2006 13:29:21 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vlkp6gh6e.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26232>

On 8/31/06, Junio C Hamano <junkio@cox.net> wrote:

> I am on Debian etch plus some from testing and have these:
>
>         perl (5.8.8-6.1)
>         perl-base (5.8.8-6.1)
>         libdbi-perl (1.51-2)
>         libsqlite3-0 (3.3.7-1)
>         libdbd-sqlite3-perl (1.12-1)
>
> Does this work for you?
>
> -- >8 -- cut here -- >8 --
> #!/usr/bin/perl -w
> use DBI;
> my $dsn = 'dbi:SQLite:dbname=foo';
> my $dbh = DBI->connect($dsn, '', '');
> -- 8< -- cut here -- 8< --

Hi! all this seems to have happened during NZ's night, so I'm only
catching up. +1 on all the diagnosis Junio is proposing. Can't think
of anything more relevant to add. The code was developed mainly on a
bunch of debian sarge/etch boxes using all the standard
libdbd-sqlite-perl libs, and a gentoo box.

Actually, just looking at my etch dev box, libdbd-sqlite-perl is
0.29-1 and sqlite is 2.8.16-1. Not sure if the difference is
significant. Perhaps SQLite v3 has a different invocation / driver
name?

BTW, I just doublechecked, cvsserver isn't mangling the lib path in
any way. However, the environment it's running under may have a
strange PERL5LIB.

cheers,


martin
