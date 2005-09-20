From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why does git-core 0.99.7 require python 2.4?
Date: Mon, 19 Sep 2005 19:02:59 -0700
Message-ID: <7v8xxsebsc.fsf@assigned-by-dhcp.cox.net>
References: <432F0C66.7060402@zytor.com>
	<20050919200222.GA11322@c165.ib.student.liu.se>
	<7vslw0lqvd.fsf@assigned-by-dhcp.cox.net> <432F26E9.9090707@zytor.com>
	<7v7jdclpme.fsf@assigned-by-dhcp.cox.net> <432F3253.3070201@zytor.com>
	<20050919231704.GA19276@unpythonic.net> <432F48C7.8070405@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 04:04:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHXTV-00038Q-6J
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 04:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVITCDI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 22:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbVITCDI
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 22:03:08 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:61685 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964832AbVITCDH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 22:03:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050920020300.BXEN18416.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 22:03:00 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <432F48C7.8070405@zytor.com> (H. Peter Anvin's message of "Mon,
	19 Sep 2005 16:24:55 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8950>

"H. Peter Anvin" <hpa@zytor.com> writes:

> jepler@unpythonic.net wrote:
>> It looks like Python2.4's subprocess module is pure Python, and works
>> with python2.3.
>> Could subprocess.py just be included in git?
>
> I think that would be the best solution.

OK, it appears that I'd better be doing a 0.99.7a real soon to
only include:

 - merge-recursive not requiring 2.4 but checking the result
   from 'import subprocess', and optionally install its own
   subprocess.py (I could do this myself but Fredrik could help
   me);

 - 'git-init-db' template installation fix from Pasky (thanks
   both Peter and Petr for diagnosis and fix);

 - 'git checkout' error message fix from Linus;

 - 'git show-branch' not barfing on corrupt repository (me);

 - not installing compatibility symlink for commands we do not
   install (Patrick Mauritz).

There are other patches for some other things discussed on the
list since 0.99.7 but they do not belong to "fixing breakage"
category.
