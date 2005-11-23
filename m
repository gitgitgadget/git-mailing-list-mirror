From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-mv is not able to handle big directories
Date: Tue, 22 Nov 2005 22:32:57 -0800
Message-ID: <7vk6ez7u1y.fsf@assigned-by-dhcp.cox.net>
References: <200511231141.57683.lan@ac-sw.com>
	<7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 07:57:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeoBo-00036M-Ch
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 07:33:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbVKWGdA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 01:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030329AbVKWGdA
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 01:33:00 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:20426 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030333AbVKWGc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 01:32:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123063224.LMXI20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 01:32:24 -0500
To: Alexander Litvinov <lan@ac-sw.com>
In-Reply-To: <7voe4b7uw7.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 22 Nov 2005 22:14:48 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12606>

Junio C Hamano <junkio@cox.net> writes:

> Two comments.
>
> (1) the argument limit is enforced by the operating system in
> ...
> (2) I wonder if we can detect this particular failure case and
> ...

(3) Even better, 'git-update-index -z --stdin'

	if (@changedfiles) {
            open my $oh, qw(|- git-update-index -z --stdin)
                    or die "oops";
            for (@changedfiles) {
                print $oh "$_\0";
	    }
	    close $oh;
	}



	JC "added too many features that myself cannot remember" Hamano
