From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: git merge changes file mode from 644 to 755
Date: Fri, 14 Aug 2015 16:17:53 +0200
Message-ID: <55CDF891.4080709@kdbg.org>
References: <CA+POfmsohJAGVYHM3nHJydoyxe92QFd59eWT_UG+_0fM46SATA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Dmitry Oksenchuk <oksenchuk89@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 14 16:18:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQFoK-00014Y-HZ
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 16:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbbHNOR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 10:17:58 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:25976 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153AbbHNOR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 10:17:57 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3mt6LC2gCvz5tlP;
	Fri, 14 Aug 2015 16:17:55 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id A0339519D;
	Fri, 14 Aug 2015 16:17:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <CA+POfmsohJAGVYHM3nHJydoyxe92QFd59eWT_UG+_0fM46SATA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275904>

Am 14.08.2015 um 14:02 schrieb Dmitry Oksenchuk:
> Hello,
>
> I've noticed strange behavior of git merge on Windows with
> core.filemode=false (set by default). Git changed mode of some files
> from 644 to 755 for unknown reason. One of the files is stdafx.cpp,
> it's absent in the common ancestor, it was added in the first branch
> (master) with mode 644 and it's still absent in the second branch
> (feature). So, git merges the file without conflicts but changes mode
> from 644 to 755.

I do know the git-merge-recursive does not honor core.filemode. However, 
I am surprised to see a mode change from 644 to 755. I usually observe 
only mode changes from 755 to 644, but then the case where the file is 
not present on one branch is uncommon for me.

> Why git merge changes mode from 644 to 755? Is it a known issue?

So, well, yes, it is known that with git merge mode changes do occur, 
but no, 644 to 755 is news to me.

The work-around is to unstage the file and stage it again, e.g. with 
git-gui and then to amend the merge commit.

-- Hannes
