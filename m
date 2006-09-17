From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: gitweb on OpenBSD (-T not supported on filesystems...)
Date: 17 Sep 2006 08:07:03 -0700
Message-ID: <864pv6sfag.fsf@blue.stonehenge.com>
References: <op.tf0k9fdvqpav6l@crystal.sienna.ath.cx>
	<eej3g3$d9j$1@sea.gmane.org> <op.tf0n3bjjqpav6l@crystal.sienna.ath.cx>
	<eej5qa$i3o$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 17:07:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOyF4-0006Cr-7L
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 17:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbWIQPHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 11:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWIQPHH
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 11:07:07 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:50990 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S932283AbWIQPHF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 11:07:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 85D368F5CC;
	Sun, 17 Sep 2006 08:07:04 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 29926-01-46; Sun, 17 Sep 2006 08:07:04 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 0FF158F994; Sun, 17 Sep 2006 08:07:04 -0700 (PDT)
To: Jakub Narebski <jnareb@gmail.com>
x-mayan-date: Long count = 12.19.13.11.13; tzolkin = 5 Ben; haab = 6 Chen
In-Reply-To: <eej5qa$i3o$1@sea.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27195>

>>>>> "Jakub" == Jakub Narebski <jnareb@gmail.com> writes:

Jakub> I thought that OpenBSD has perhaps distributed some old Perl version that
Jakub> doesn't have -X tests (including -T/-B) on filehandles.

>> When I try the original -T $fd I get: 
>> 
>> Software error:
>> -T and -B not implemented on filehandles at /var/www/htdocs/git/gitweb.cgi  
>> line 1598.

Jakub> So this means that Perl implementation in OpenBSD is flawed.

No, see "perldoc perldiag":

       "-T" and "-B" not implemented on filehandles
           (F) Perl can't peek at the stdio buffer of filehandles when it
           doesn't know about your kind of stdio.  You'll have to use a file-
           name instead.

So the problem is that OpenBSD has a stdio that is not what the Perl authors
anticipated, because it requires peeking behind official interfaces.  Perl
isn't flawed. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
