From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH 1/3] configure: Add test for Perl
Date: 06 Jul 2006 06:03:40 -0700
Message-ID: <868xn67umr.fsf@blue.stonehenge.com>
References: <20060706124025.G325584e9@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 15:04:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyTWY-0004n5-SU
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 15:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWGFNDn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 09:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbWGFNDn
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 09:03:43 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:30875 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1030253AbWGFNDm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jul 2006 09:03:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id D49228F401;
	Thu,  6 Jul 2006 06:03:41 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 29721-01-29; Thu,  6 Jul 2006 06:03:40 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 3542A8F40D; Thu,  6 Jul 2006 06:03:40 -0700 (PDT)
To: Dennis Stosberg <dennis@stosberg.net>
x-mayan-date: Long count = 12.19.13.8.0; tzolkin = 10 Ahau; haab = 13 Tzec
In-Reply-To: <20060706124025.G325584e9@leonov.stosberg.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23386>

>>>>> "Dennis" == Dennis Stosberg <dennis@stosberg.net> writes:

Dennis> +	_perl_version=`"$_perl" -e 'require 5.6.0;printf "%vd", $^V'`

perl -V:version gives you the version like:

        version='5.8.6';

nice and eval-able. :)  But you can just rely on the exit status from

        perl -e 'eval { require 5.006; 1 } or exit 1'

which will be good (0) if the perl is new enough, and bad (1) if the perl is
too old.  (Perl4 will really barf and give an error as well, but still
be an exit 1.)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
