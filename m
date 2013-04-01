From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: Composing git repositories
Date: Sun, 31 Mar 2013 20:16:07 -0400
Message-ID: <201304010016.r310G79C032108@no.baka.org>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 02:22:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMSWL-0007CP-51
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 02:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756197Ab3DAAWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 20:22:17 -0400
Received: from tsutomu.baka.org ([66.114.72.182]:33130 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756032Ab3DAAWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 20:22:16 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Mar 2013 20:22:15 EDT
Received: from no.baka.org (ohayo.baka.org [IPv6:2001:470:88bb::1])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id r310G9sa028138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Mar 2013 20:16:10 -0400
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id r310G79C032108;
	Sun, 31 Mar 2013 20:16:07 -0400
In-reply-to: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
Comments: In reply to a message from "Ramkumar Ramachandra <artagnon@gmail.com>" dated "Tue, 26 Mar 2013 13:26:33 +0530."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219650>


In message <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>, Ramkumar Ramachandra writes:

    As a user inexperienced with recursive submodules (I've only used them
    in this repository), I found it highly confusing.  Thanks for clearing
    them up.

You may want to investigate third party alternatives like gitslave
http://gitslave.sf.net Depending on what problem you are trying to
solve, it can be better (or worse) to use compared to submodules.

It provides a usually conceptually easier method to group subprojects
together into a superproject.  You can replace practically any git
command you want with "gits" and it will usually work as you might
more or less expect.  Conceptually it has a list of git repositories
and will execute the listed git command on each in turn.

It seems to resolve most of the issues that you raise, but of course
it has some warts of its own.  Some could be resolved with sufficient
effort, others are fundamental.  (An example of the latter, you cannot
trivially tell what commit in other repositories a particular user was
at when he made a commit in a specific repository (absent a gits tag
being created).  An example of the former, if you have git output
paging turned on and many subprojects to check out, `gits clone` pages
the output and more to the point, blocks the clones until you page
through the output which you must typically do many times).

					-Seth Robertson
