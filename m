From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] git-mv is not able to handle big directories
Date: 22 Nov 2005 23:55:07 -0800
Message-ID: <867jazre78.fsf@blue.stonehenge.com>
References: <200511231141.57683.lan@ac-sw.com>
	<7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>
	<7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <lan@ac-sw.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 08:55:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EepTO-0001KO-7z
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 08:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030349AbVKWHzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 02:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030351AbVKWHzO
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 02:55:14 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:64378 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1030349AbVKWHzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 02:55:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 05A938F6EF;
	Tue, 22 Nov 2005 23:55:08 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 04280-03-3; Tue, 22 Nov 2005 23:55:07 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 920478F6F3; Tue, 22 Nov 2005 23:55:07 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.12.14.14; tzolkin = 5 Ix; haab = 12 Ceh
In-Reply-To: <7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12611>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio>             open my $oh, qw(|- git-update-index -z --stdin)
Junio>                     or die "oops";

This is Perl 5.6 or later.  Breaks on Perl 5.5, which is still in use
in some places.

To be compatible with 5.5, you have to create a handle explicitly:

        require IO::Handle;
        my $oh = IO::Handle->new;
        open $oh, qw(...) ...;

That works all the way back to 5.4, which is the earliest Perl
supported by the core team.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
