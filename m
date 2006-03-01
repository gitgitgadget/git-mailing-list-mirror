From: Junio C Hamano <junkio@cox.net>
Subject: Re: git doesn't like big files when pushing
Date: Wed, 01 Mar 2006 15:03:17 -0800
Message-ID: <7v8xrtepje.fsf@assigned-by-dhcp.cox.net>
References: <20060301220802.GA18250@kroah.com>
	<20060301220840.GB18250@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 00:03:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEaLr-0004QH-N0
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 00:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbWCAXDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 18:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbWCAXDU
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 18:03:20 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:35558 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751950AbWCAXDT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 18:03:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060301230130.BBAS20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 18:01:30 -0500
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060301220840.GB18250@kroah.com> (Greg KH's message of "Wed, 1
	Mar 2006 14:08:40 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17027>

Greg KH <greg@kroah.com> writes:

> On Wed, Mar 01, 2006 at 02:08:02PM -0800, Greg KH wrote:
>> I have a mail archive stored with git, in mbox form, and I made some
>> changes to a few of the files and checked them back in.
>...

Ouch.  Running out of memory while deltifying sounds really bad.

> Oh, and I'm using:
> 	$ git --version
> 	git version 1.2.3.g8c2f
>
> if that helps or not.

It doen't, since I do not have 8c2fXXXX commit ;-).

I suspect "git push --thin origin" might help, if you are on my
"master" branch:

        diff-tree a79a276... (from 2245be3...)
        Author: Junio C Hamano <junkio@cox.net>
        Date:   Mon Feb 20 00:09:41 2006 -0800

            Add git-push --thin.

            Maybe we would want to make this default before it graduates to
            the master branch, but in the meantime to help testing things,
            this allows you to say "git push --thin destination".

            Signed-off-by: Junio C Hamano <junkio@cox.net>

        :100755 100755 706db99... 73dcf06... M	git-push.sh
