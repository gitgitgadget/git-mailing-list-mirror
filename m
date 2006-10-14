From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: git-svn and u-boot broken.
Date: Sat, 14 Oct 2006 03:21:34 +0200
Message-ID: <00e301c6ef2f$16993ac0$1267a8c0@Jocke>
References: <86slhsgg3f.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 14 03:23:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYYFg-0002sm-Ts
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 03:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbWJNBXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 21:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWJNBXm
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 21:23:42 -0400
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:53935
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1752031AbWJNBXl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 21:23:41 -0400
Received: from Jocke ([84.217.9.178]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Sat, 14 Oct 2006 03:23:39 +0200
To: "'Randal L. Schwartz'" <merlyn@stonehenge.com>
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: Acbu/2XhgfSie4HXTBGPTIL6wyYORwAL5HPg
In-Reply-To: <86slhsgg3f.fsf@blue.stonehenge.com>
X-OriginalArrivalTime: 14 Oct 2006 01:23:39.0704 (UTC) FILETIME=[6107CB80:01C6EF2F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28868>

 

> -----Original Message-----
> From: Randal L. Schwartz [mailto:merlyn@stonehenge.com] 
> Sent: den 13 oktober 2006 21:40
> To: Joakim Tjernlund
> Cc: git@vger.kernel.org
> Subject: Re: git-svn and u-boot broken.
> 
> >>>>> "Joakim" == Joakim Tjernlund 
> <joakim.tjernlund@transmode.se> writes:
> 
> Joakim> First, I had to change this (from memory) in git-svn:
> Joakim>   my $got = SVN::TxDelta::send_stream($fh, @$atd, 
> $self->{pool});
> Joakim> to
> Joakim>   my $got;
> Joakim>   if ( $got ) {
> Joakim>     $got = SVN::TxDelta::send_stream($fh, @$atd, 
> $self->{pool});
> Joakim>   } else {
> Joakim>     $got = $exp
> Joakim>   }
> Joakim> I am no perl programmer so please change as you se fit.
> 
> That doesn't make any sense.  You'll never run the if-true 
> branch there.
> The value of $got immediately following "my $got;" is always undef.

git-pull --squash seems to do what I want but know I get this when
committing to svn: 
git-svn commit remotes/git-svn..svn-branch
...
        A       cpu/mpc824x/drivers/i2c_export.h
        A       cpu/mpc824x/drivers/i2o.h
        A       cpu/mpc824x/drivers/i2o/Makefile
        A       cpu/mpc824x/drivers/i2o/Makefile_pc
Cannot allocate memory at /usr/bin/git-svn line 1462
3072 at /usr/bin/git-svn line 547
        main::commit_lib('2ff9bcb7908d2752f643695ab3a28f9ababfafab') called at /usr/bin/git-svn line 457
        main::commit('remotes/git-svn..svn-branch') called at /usr/bin/git-svn line 149

 Jocke
