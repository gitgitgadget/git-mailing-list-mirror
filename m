From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 03 Oct 2012 07:37:29 +0200
Message-ID: <506BCF19.7020800@viscovery.net>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com> <506AA51E.9010209@viscovery.net> <7vzk449449.fsf@alter.siamese.dyndns.org> <CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com> <7vhaqc7in6.fsf@alter.siamese.dyndns.org> <CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 07:38:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJHez-0000IW-B6
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 07:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab2JCFhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 01:37:35 -0400
Received: from so.liwest.at ([212.33.55.24]:57869 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905Ab2JCFhf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 01:37:35 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TJHeD-0008Gn-VR; Wed, 03 Oct 2012 07:37:30 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A3CE01660F;
	Wed,  3 Oct 2012 07:37:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206857>

Am 10/2/2012 23:56, schrieb Angelo Borsotti:
> The problem I am trying to solve is to push to a remote server the
> source files only,
> while keeping in the local repo both sources and binaries. To do it, I
> keep an orphan
> branch, [...] 
> 
> # this is the commit on the master branch
> git init
> echo "aaa" >f1
> git add f1
> git commit -m A
> 
> # this is the piece of the script that builds the sources branch
> git checkout --orphan sources
> # git rm --cached ...   remove binaries, if any"
> git commit -m A --allow-empty
> git rev-list --all --pretty=oneline
> 
> When there are binaries in the commit A, they are removed, and the
> tree for the second
> git commit is then different, and the commit is actually created.
> When there are no binaries (as in the script above, in which the
> removal is commented out),
> the second git commit would not create any new commit, and I would not
> have an orphan
> branch. Thence the --allow-empty to force it to create a new commit.
> Unfortunately, it creates a new commit only if the system clock
> changes the seconds of
> the system time between the two git commits.

But the existing-and-not-created-commit has exactly the content that you
wanted. What's the point in insisting that it is different from any other
commit?

-- Hannes
