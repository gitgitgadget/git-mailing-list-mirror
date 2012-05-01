From: <dag@cray.com>
Subject: Re: git-subtree split O(N)
Date: Tue, 1 May 2012 14:49:32 -0500
Message-ID: <nnghavzu1f7.fsf@transit.us.cray.com>
References: <CA+EzHGfiRg+w8FsvrXEi0Yr4oVzxaZA_1JT8cmRR0YrYG7m6AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Vinnie Falco <vinnie.falco@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 01 21:51:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPJ6J-0004Ax-CI
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 21:51:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757111Ab2EATvB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 15:51:01 -0400
Received: from exprod6og105.obsmtp.com ([64.18.1.189]:53681 "EHLO
	exprod6og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756169Ab2EATvA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 15:51:00 -0400
Received: from CFWEX01.americas.cray.com ([136.162.34.11]) (using TLSv1) by exprod6ob105.postini.com ([64.18.5.12]) with SMTP
	ID DSNKT6A+o6DgXnxArxnP9zYf24uFwyNxXWP9@postini.com; Tue, 01 May 2012 12:51:00 PDT
Received: from transit.us.cray.com (172.31.17.53) by CFWEX01.americas.cray.com
 (172.30.88.25) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 1 May
 2012 14:49:35 -0500
In-Reply-To: <CA+EzHGfiRg+w8FsvrXEi0Yr4oVzxaZA_1JT8cmRR0YrYG7m6AQ@mail.gmail.com>
	(Vinnie Falco's message of "Mon, 30 Apr 2012 18:39:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196734>

Vinnie Falco <vinnie.falco@gmail.com> writes:

> The problem is that every time I split, git-subtree starts from the
> very beginning of the commit log and works its way forward. I thought
> that it was only supposed to do that once, and that subsequent splits
> would start from the last commit in the destination branch (I keep the
> split branch around).
>
> What's going on?

This is an area I want to improve.

You have to use --rejoin so subtree will remember where you left off
last time.  I also always specify a branch name, like this:

git subtree split -P subproj --rejoin --branch=subproj-to-push

I think --rejoin should probably be default but I need to understand the
code better to make sure.

HTH.

                              -Dave
