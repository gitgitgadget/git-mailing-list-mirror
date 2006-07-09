From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [Patch] Using 'perl' in *.sh
Date: 09 Jul 2006 07:02:13 -0700
Message-ID: <86ejwuuba2.fsf@blue.stonehenge.com>
References: <200607081732.04273.michal.rokos@nextsoft.cz>
	<20060709095114.GQ22573@lug-owl.de>
	<7vd5cfnkz4.fsf@assigned-by-dhcp.cox.net>
	<200607091441.16161.michal.rokos@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 16:02:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzZrb-0005f5-Dy
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 16:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWGIOCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 10:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161007AbWGIOCQ
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 10:02:16 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:23051 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1161005AbWGIOCP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 10:02:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 993988F566;
	Sun,  9 Jul 2006 07:02:14 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 17057-01-27; Sun,  9 Jul 2006 07:02:13 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 7F8E88F58C; Sun,  9 Jul 2006 07:02:13 -0700 (PDT)
To: Michal Rokos <michal.rokos@nextsoft.cz>
x-mayan-date: Long count = 12.19.13.8.3; tzolkin = 13 Akbal; haab = 16 Tzec
In-Reply-To: <200607091441.16161.michal.rokos@nextsoft.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23549>

>>>>> "Michal" == Michal Rokos <michal.rokos@nextsoft.cz> writes:

Michal> I have no problem with that. I can set $PATH.
Michal> But then I'd suggest to change magic #!
Michal> from #!/usr/bin/perl
Michal> to #!/usr/bin/env perl
Michal> for *.perl

Michal> It that what you meant?

No, don't do that.  Use the path to Perl that they chose during
configuration because

(a) it might not be the first one in PATH
(b) even if it's the first one in *my* path, it might not be the
    first one in *everyone's* path
(c) env requires an *extra* fork/exec
(d) some systems don't have env

The env hack is a nice hack, but it's just a hack.  Don't
rely on it when the right thing is nearby.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
