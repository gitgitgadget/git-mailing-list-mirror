From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git-svn and u-boot broken.
Date: 13 Oct 2006 12:39:48 -0700
Message-ID: <86slhsgg3f.fsf@blue.stonehenge.com>
References: <00ad01c6eefc$84298280$1267a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 13 21:39:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYSsq-0001T1-Vb
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 21:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbWJMTju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 15:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751846AbWJMTju
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 15:39:50 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:50036 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751844AbWJMTjt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 15:39:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id C296A8F9D3;
	Fri, 13 Oct 2006 12:39:48 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 04336-01-67; Fri, 13 Oct 2006 12:39:48 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 4BA068F9C7; Fri, 13 Oct 2006 12:39:48 -0700 (PDT)
To: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
x-mayan-date: Long count = 12.19.13.12.19; tzolkin = 5 Cauac; haab = 12 Yax
In-Reply-To: <00ad01c6eefc$84298280$1267a8c0@Jocke>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28855>

>>>>> "Joakim" == Joakim Tjernlund <joakim.tjernlund@transmode.se> writes:

Joakim> First, I had to change this (from memory) in git-svn:
Joakim>   my $got = SVN::TxDelta::send_stream($fh, @$atd, $self->{pool});
Joakim> to
Joakim>   my $got;
Joakim>   if ( $got ) {
Joakim>     $got = SVN::TxDelta::send_stream($fh, @$atd, $self->{pool});
Joakim>   } else {
Joakim>     $got = $exp
Joakim>   }
Joakim> I am no perl programmer so please change as you se fit.

That doesn't make any sense.  You'll never run the if-true branch there.
The value of $got immediately following "my $got;" is always undef.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
